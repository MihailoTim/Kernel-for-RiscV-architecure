
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
    8000001c:	395040ef          	jal	ra,80004bb0 <start>

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
    80001088:	5d1020ef          	jal	ra,80003e58 <_ZN5RiscV20handleSupervisorTrapEv>

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
    800011d8:	7d8080e7          	jalr	2008(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011dc:	01000693          	li	a3,16
    800011e0:	00006617          	auipc	a2,0x6
    800011e4:	17060613          	addi	a2,a2,368 # 80007350 <CONSOLE_STATUS+0x340>
    800011e8:	01892583          	lw	a1,24(s2)
    800011ec:	00006517          	auipc	a0,0x6
    800011f0:	e4450513          	addi	a0,a0,-444 # 80007030 <CONSOLE_STATUS+0x20>
    800011f4:	00003097          	auipc	ra,0x3
    800011f8:	7b8080e7          	jalr	1976(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    800011fc:	01000693          	li	a3,16
    80001200:	00006617          	auipc	a2,0x6
    80001204:	15060613          	addi	a2,a2,336 # 80007350 <CONSOLE_STATUS+0x340>
    80001208:	01092583          	lw	a1,16(s2)
    8000120c:	00006517          	auipc	a0,0x6
    80001210:	e3c50513          	addi	a0,a0,-452 # 80007048 <CONSOLE_STATUS+0x38>
    80001214:	00003097          	auipc	ra,0x3
    80001218:	798080e7          	jalr	1944(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    8000121c:	01000693          	li	a3,16
    80001220:	00006617          	auipc	a2,0x6
    80001224:	13060613          	addi	a2,a2,304 # 80007350 <CONSOLE_STATUS+0x340>
    80001228:	03800593          	li	a1,56
    8000122c:	00006517          	auipc	a0,0x6
    80001230:	e3450513          	addi	a0,a0,-460 # 80007060 <CONSOLE_STATUS+0x50>
    80001234:	00003097          	auipc	ra,0x3
    80001238:	778080e7          	jalr	1912(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000123c:	01000693          	li	a3,16
    80001240:	00006617          	auipc	a2,0x6
    80001244:	11060613          	addi	a2,a2,272 # 80007350 <CONSOLE_STATUS+0x340>
    80001248:	02892583          	lw	a1,40(s2)
    8000124c:	00006517          	auipc	a0,0x6
    80001250:	e2c50513          	addi	a0,a0,-468 # 80007078 <CONSOLE_STATUS+0x68>
    80001254:	00003097          	auipc	ra,0x3
    80001258:	758080e7          	jalr	1880(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    8000125c:	01000693          	li	a3,16
    80001260:	00006617          	auipc	a2,0x6
    80001264:	0f060613          	addi	a2,a2,240 # 80007350 <CONSOLE_STATUS+0x340>
    80001268:	02092583          	lw	a1,32(s2)
    8000126c:	00006517          	auipc	a0,0x6
    80001270:	e1c50513          	addi	a0,a0,-484 # 80007088 <CONSOLE_STATUS+0x78>
    80001274:	00003097          	auipc	ra,0x3
    80001278:	738080e7          	jalr	1848(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000127c:	00006517          	auipc	a0,0x6
    80001280:	e2c50513          	addi	a0,a0,-468 # 800070a8 <CONSOLE_STATUS+0x98>
    80001284:	00003097          	auipc	ra,0x3
    80001288:	608080e7          	jalr	1544(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
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
    800012b8:	6f8080e7          	jalr	1784(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
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
    800012dc:	5b4080e7          	jalr	1460(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
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
    80001324:	56c080e7          	jalr	1388(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001328:	00090513          	mv	a0,s2
    8000132c:	00003097          	auipc	ra,0x3
    80001330:	560080e7          	jalr	1376(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001334:	00006517          	auipc	a0,0x6
    80001338:	01c50513          	addi	a0,a0,28 # 80007350 <CONSOLE_STATUS+0x340>
    8000133c:	00003097          	auipc	ra,0x3
    80001340:	550080e7          	jalr	1360(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
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
    80001368:	648080e7          	jalr	1608(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000136c:	01000693          	li	a3,16
    80001370:	00006617          	auipc	a2,0x6
    80001374:	fe060613          	addi	a2,a2,-32 # 80007350 <CONSOLE_STATUS+0x340>
    80001378:	0009059b          	sext.w	a1,s2
    8000137c:	00006517          	auipc	a0,0x6
    80001380:	d7450513          	addi	a0,a0,-652 # 800070f0 <CONSOLE_STATUS+0xe0>
    80001384:	00003097          	auipc	ra,0x3
    80001388:	628080e7          	jalr	1576(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    8000138c:	01000693          	li	a3,16
    80001390:	00006617          	auipc	a2,0x6
    80001394:	fc060613          	addi	a2,a2,-64 # 80007350 <CONSOLE_STATUS+0x340>
    80001398:	04892583          	lw	a1,72(s2)
    8000139c:	00006517          	auipc	a0,0x6
    800013a0:	d6450513          	addi	a0,a0,-668 # 80007100 <CONSOLE_STATUS+0xf0>
    800013a4:	00003097          	auipc	ra,0x3
    800013a8:	608080e7          	jalr	1544(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013ac:	01000693          	li	a3,16
    800013b0:	00006617          	auipc	a2,0x6
    800013b4:	fa060613          	addi	a2,a2,-96 # 80007350 <CONSOLE_STATUS+0x340>
    800013b8:	04092583          	lw	a1,64(s2)
    800013bc:	00006517          	auipc	a0,0x6
    800013c0:	d5c50513          	addi	a0,a0,-676 # 80007118 <CONSOLE_STATUS+0x108>
    800013c4:	00003097          	auipc	ra,0x3
    800013c8:	5e8080e7          	jalr	1512(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013cc:	01000693          	li	a3,16
    800013d0:	00006617          	auipc	a2,0x6
    800013d4:	f8060613          	addi	a2,a2,-128 # 80007350 <CONSOLE_STATUS+0x340>
    800013d8:	06092583          	lw	a1,96(s2)
    800013dc:	00006517          	auipc	a0,0x6
    800013e0:	d5450513          	addi	a0,a0,-684 # 80007130 <CONSOLE_STATUS+0x120>
    800013e4:	00003097          	auipc	ra,0x3
    800013e8:	5c8080e7          	jalr	1480(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>

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
    80001410:	5a0080e7          	jalr	1440(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001414:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001418:	fd9ff06f          	j	800013f0 <_ZN13SlabAllocator10printCacheEP5Cache+0xf4>
    }
    ConsoleUtil::printString("\n");
    8000141c:	00006517          	auipc	a0,0x6
    80001420:	f3450513          	addi	a0,a0,-204 # 80007350 <CONSOLE_STATUS+0x340>
    80001424:	00003097          	auipc	ra,0x3
    80001428:	468080e7          	jalr	1128(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    8000142c:	01000693          	li	a3,16
    80001430:	00006617          	auipc	a2,0x6
    80001434:	f2060613          	addi	a2,a2,-224 # 80007350 <CONSOLE_STATUS+0x340>
    80001438:	06892583          	lw	a1,104(s2)
    8000143c:	00006517          	auipc	a0,0x6
    80001440:	d0450513          	addi	a0,a0,-764 # 80007140 <CONSOLE_STATUS+0x130>
    80001444:	00003097          	auipc	ra,0x3
    80001448:	568080e7          	jalr	1384(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>

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
    80001470:	540080e7          	jalr	1344(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001474:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001478:	fd9ff06f          	j	80001450 <_ZN13SlabAllocator10printCacheEP5Cache+0x154>
    }
    ConsoleUtil::printString("\n");
    8000147c:	00006517          	auipc	a0,0x6
    80001480:	ed450513          	addi	a0,a0,-300 # 80007350 <CONSOLE_STATUS+0x340>
    80001484:	00003097          	auipc	ra,0x3
    80001488:	408080e7          	jalr	1032(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    8000148c:	01000693          	li	a3,16
    80001490:	00006617          	auipc	a2,0x6
    80001494:	ec060613          	addi	a2,a2,-320 # 80007350 <CONSOLE_STATUS+0x340>
    80001498:	07092583          	lw	a1,112(s2)
    8000149c:	00006517          	auipc	a0,0x6
    800014a0:	cb450513          	addi	a0,a0,-844 # 80007150 <CONSOLE_STATUS+0x140>
    800014a4:	00003097          	auipc	ra,0x3
    800014a8:	508080e7          	jalr	1288(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>

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
    800014d0:	4e0080e7          	jalr	1248(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800014d4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014d8:	fd9ff06f          	j	800014b0 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b4>
    }
    ConsoleUtil::printString("\n");
    800014dc:	00006517          	auipc	a0,0x6
    800014e0:	e7450513          	addi	a0,a0,-396 # 80007350 <CONSOLE_STATUS+0x340>
    800014e4:	00003097          	auipc	ra,0x3
    800014e8:	3a8080e7          	jalr	936(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
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
    8000198c:	9cc080e7          	jalr	-1588(ra) # 80004354 <_Z6strcpyPKcPc>
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
    80001a3c:	91c080e7          	jalr	-1764(ra) # 80004354 <_Z6strcpyPKcPc>
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
    80001e44:	478080e7          	jalr	1144(ra) # 800042b8 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001e48:	fe843783          	ld	a5,-24(s0)
    80001e4c:	0107a703          	lw	a4,16(a5)
    80001e50:	00200793          	li	a5,2
    80001e54:	00f70863          	beq	a4,a5,80001e64 <_ZN6SystemC1Ev+0x68>
            TCB::dispatch();
    80001e58:	00001097          	auipc	ra,0x1
    80001e5c:	a60080e7          	jalr	-1440(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    80001e60:	fe9ff06f          	j	80001e48 <_ZN6SystemC1Ev+0x4c>
        }

        //finalize the machine
        RiscV::finalize();
    80001e64:	00001097          	auipc	ra,0x1
    80001e68:	708080e7          	jalr	1800(ra) # 8000356c <_ZN5RiscV8finalizeEv>
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
    800023a4:	4ec080e7          	jalr	1260(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800023a8:	0019091b          	addiw	s2,s2,1
    800023ac:	00c00793          	li	a5,12
    800023b0:	0727c663          	blt	a5,s2,8000241c <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    800023b4:	00000613          	li	a2,0
    800023b8:	00a00593          	li	a1,10
    800023bc:	00090513          	mv	a0,s2
    800023c0:	00002097          	auipc	ra,0x2
    800023c4:	510080e7          	jalr	1296(ra) # 800048d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    800023c8:	00005517          	auipc	a0,0x5
    800023cc:	ee050513          	addi	a0,a0,-288 # 800072a8 <CONSOLE_STATUS+0x298>
    800023d0:	00002097          	auipc	ra,0x2
    800023d4:	4bc080e7          	jalr	1212(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
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
    80002400:	4d4080e7          	jalr	1236(ra) # 800048d0 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002404:	00005517          	auipc	a0,0x5
    80002408:	ce450513          	addi	a0,a0,-796 # 800070e8 <CONSOLE_STATUS+0xd8>
    8000240c:	00002097          	auipc	ra,0x2
    80002410:	480080e7          	jalr	1152(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
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
    800024d8:	594080e7          	jalr	1428(ra) # 80004a68 <_Z17kmem_cache_createPKcmPFvPvES3_>
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
    80002544:	eb8080e7          	jalr	-328(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>
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
    80002604:	df8080e7          	jalr	-520(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>
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
    800026c4:	3d0080e7          	jalr	976(ra) # 80004a90 <_Z16kmem_cache_allocP5Cache>
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
    800026f8:	3c4080e7          	jalr	964(ra) # 80004ab8 <_Z15kmem_cache_freeP5CachePv>
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
    800027e8:	b50080e7          	jalr	-1200(ra) # 80004334 <_ZN5RiscV14threadExitUtilEv>
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
    8000287c:	310080e7          	jalr	784(ra) # 80004b88 <_Z5kfreePKv>
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
    800028e4:	b60080e7          	jalr	-1184(ra) # 80004440 <_ZN9Scheduler3getEv>
    800028e8:	00005797          	auipc	a5,0x5
    800028ec:	46a7bc23          	sd	a0,1144(a5) # 80007d60 <_ZN3TCB7runningE>
    if(running) {
    800028f0:	02050263          	beqz	a0,80002914 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    800028f4:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    800028f8:	00001097          	auipc	ra,0x1
    800028fc:	c30080e7          	jalr	-976(ra) # 80003528 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
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
    80002930:	acc080e7          	jalr	-1332(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>
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
    80002954:	140080e7          	jalr	320(ra) # 80004a90 <_Z16kmem_cache_allocP5Cache>
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
    800029a0:	0cc080e7          	jalr	204(ra) # 80004a68 <_Z17kmem_cache_createPKcmPFvPvES3_>
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
    800029f0:	174080e7          	jalr	372(ra) # 80004b60 <_Z7kmallocm>
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
    80002a40:	9bc080e7          	jalr	-1604(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>
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
    80002a7c:	040080e7          	jalr	64(ra) # 80004ab8 <_Z15kmem_cache_freeP5CachePv>
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
    80002e50:	cd0080e7          	jalr	-816(ra) # 80010b1c <_Z11printStringPKc>
    while(iter!=nullptr){
    80002e54:	04048663          	beqz	s1,80002ea0 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80002e58:	00000613          	li	a2,0
    80002e5c:	00a00593          	li	a1,10
    80002e60:	0004851b          	sext.w	a0,s1
    80002e64:	0000e097          	auipc	ra,0xe
    80002e68:	e50080e7          	jalr	-432(ra) # 80010cb4 <_Z8printIntiii>
        putc(' ');
    80002e6c:	02000513          	li	a0,32
    80002e70:	0000c097          	auipc	ra,0xc
    80002e74:	4bc080e7          	jalr	1212(ra) # 8000f32c <_Z4putcc>
        printInt(iter->size);
    80002e78:	00000613          	li	a2,0
    80002e7c:	00a00593          	li	a1,10
    80002e80:	0004a503          	lw	a0,0(s1)
    80002e84:	0000e097          	auipc	ra,0xe
    80002e88:	e30080e7          	jalr	-464(ra) # 80010cb4 <_Z8printIntiii>
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
    80002eac:	c74080e7          	jalr	-908(ra) # 80010b1c <_Z11printStringPKc>
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
    80002ecc:	dec080e7          	jalr	-532(ra) # 80010cb4 <_Z8printIntiii>
        putc(' ');
    80002ed0:	02000513          	li	a0,32
    80002ed4:	0000c097          	auipc	ra,0xc
    80002ed8:	458080e7          	jalr	1112(ra) # 8000f32c <_Z4putcc>
        printInt(iter->size);
    80002edc:	00000613          	li	a2,0
    80002ee0:	00a00593          	li	a1,10
    80002ee4:	0004a503          	lw	a0,0(s1)
    80002ee8:	0000e097          	auipc	ra,0xe
    80002eec:	dcc080e7          	jalr	-564(ra) # 80010cb4 <_Z8printIntiii>
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
    80002f10:	c10080e7          	jalr	-1008(ra) # 80010b1c <_Z11printStringPKc>
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
    800030f8:	94c080e7          	jalr	-1716(ra) # 80004a40 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    800030fc:	00000097          	auipc	ra,0x0
    80003100:	9c0080e7          	jalr	-1600(ra) # 80002abc <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80003104:	00001097          	auipc	ra,0x1
    80003108:	2dc080e7          	jalr	732(ra) # 800043e0 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    8000310c:	00000097          	auipc	ra,0x0
    80003110:	85c080e7          	jalr	-1956(ra) # 80002968 <_ZN3TCB10initializeEv>
    SCB::initialize();
    80003114:	fffff097          	auipc	ra,0xfffff
    80003118:	394080e7          	jalr	916(ra) # 800024a8 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    8000311c:	00001097          	auipc	ra,0x1
    80003120:	4d8080e7          	jalr	1240(ra) # 800045f4 <_ZN11ConsoleUtil10initializeEv>
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
    8000348c:	30c080e7          	jalr	780(ra) # 80004794 <_ZN11ConsoleUtil9putOutputEc>
}
    80003490:	00813083          	ld	ra,8(sp)
    80003494:	00013403          	ld	s0,0(sp)
    80003498:	01010113          	addi	sp,sp,16
    8000349c:	00008067          	ret

00000000800034a0 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    800034a0:	fe010113          	addi	sp,sp,-32
    800034a4:	00113c23          	sd	ra,24(sp)
    800034a8:	00813823          	sd	s0,16(sp)
    800034ac:	02010413          	addi	s0,sp,32
    800034b0:	00c0006f          	j	800034bc <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            TCB::dispatch();
    800034b4:	fffff097          	auipc	ra,0xfffff
    800034b8:	404080e7          	jalr	1028(ra) # 800028b8 <_ZN3TCB8dispatchEv>
        uint64 status = CONSOLE_STATUS;
    800034bc:	00004797          	auipc	a5,0x4
    800034c0:	6147b783          	ld	a5,1556(a5) # 80007ad0 <_GLOBAL_OFFSET_TABLE_+0x10>
    800034c4:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800034c8:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800034cc:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800034d0:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    800034d4:	0207f793          	andi	a5,a5,32
    800034d8:	fc078ee3          	beqz	a5,800034b4 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    800034dc:	00001097          	auipc	ra,0x1
    800034e0:	53c080e7          	jalr	1340(ra) # 80004a18 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    800034e4:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    800034e8:	00004797          	auipc	a5,0x4
    800034ec:	5e07b783          	ld	a5,1504(a5) # 80007ac8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800034f0:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    800034f4:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    800034f8:	fef44783          	lbu	a5,-17(s0)
    800034fc:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003500:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003504:	00004797          	auipc	a5,0x4
    80003508:	6647b783          	ld	a5,1636(a5) # 80007b68 <_GLOBAL_OFFSET_TABLE_+0xa8>
    8000350c:	0007b783          	ld	a5,0(a5)
    80003510:	fa0786e3          	beqz	a5,800034bc <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003514:	fff78793          	addi	a5,a5,-1
    80003518:	00004717          	auipc	a4,0x4
    8000351c:	65073703          	ld	a4,1616(a4) # 80007b68 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003520:	00f73023          	sd	a5,0(a4)
    80003524:	f99ff06f          	j	800034bc <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003528 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003528:	ff010113          	addi	sp,sp,-16
    8000352c:	00813423          	sd	s0,8(sp)
    80003530:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80003534:	00004797          	auipc	a5,0x4
    80003538:	63c7b783          	ld	a5,1596(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000353c:	0007b783          	ld	a5,0(a5)
    80003540:	0147a703          	lw	a4,20(a5)
    80003544:	00100793          	li	a5,1
    80003548:	00f70c63          	beq	a4,a5,80003560 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    8000354c:	10000793          	li	a5,256
    80003550:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    80003554:	00813403          	ld	s0,8(sp)
    80003558:	01010113          	addi	sp,sp,16
    8000355c:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003560:	10000793          	li	a5,256
    80003564:	1007a073          	csrs	sstatus,a5
}
    80003568:	fedff06f          	j	80003554 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

000000008000356c <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    8000356c:	ff010113          	addi	sp,sp,-16
    80003570:	00113423          	sd	ra,8(sp)
    80003574:	00813023          	sd	s0,0(sp)
    80003578:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    8000357c:	00100793          	li	a5,1
    80003580:	00005717          	auipc	a4,0x5
    80003584:	84f70023          	sb	a5,-1984(a4) # 80007dc0 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003588:	00004797          	auipc	a5,0x4
    8000358c:	5e07b783          	ld	a5,1504(a5) # 80007b68 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003590:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003594:	00004797          	auipc	a5,0x4
    80003598:	58c7b783          	ld	a5,1420(a5) # 80007b20 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000359c:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    800035a0:	00200793          	li	a5,2
    800035a4:	1047b073          	csrc	sie,a5
    800035a8:	20000793          	li	a5,512
    800035ac:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    800035b0:	00004797          	auipc	a5,0x4
    800035b4:	5907b783          	ld	a5,1424(a5) # 80007b40 <_GLOBAL_OFFSET_TABLE_+0x80>
    800035b8:	0007b783          	ld	a5,0(a5)
    800035bc:	00078c63          	beqz	a5,800035d4 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    800035c0:	0487b703          	ld	a4,72(a5)
    800035c4:	00004797          	auipc	a5,0x4
    800035c8:	57c7b783          	ld	a5,1404(a5) # 80007b40 <_GLOBAL_OFFSET_TABLE_+0x80>
    800035cc:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    800035d0:	fe1ff06f          	j	800035b0 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    800035d4:	00004797          	auipc	a5,0x4
    800035d8:	5747b783          	ld	a5,1396(a5) # 80007b48 <_GLOBAL_OFFSET_TABLE_+0x88>
    800035dc:	0007b503          	ld	a0,0(a5)
    800035e0:	00001097          	auipc	ra,0x1
    800035e4:	e18080e7          	jalr	-488(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    800035e8:	00004797          	auipc	a5,0x4
    800035ec:	5707b783          	ld	a5,1392(a5) # 80007b58 <_GLOBAL_OFFSET_TABLE_+0x98>
    800035f0:	0007b703          	ld	a4,0(a5)
    800035f4:	00004797          	auipc	a5,0x4
    800035f8:	56c7b783          	ld	a5,1388(a5) # 80007b60 <_GLOBAL_OFFSET_TABLE_+0xa0>
    800035fc:	0007b783          	ld	a5,0(a5)
    80003600:	00f70863          	beq	a4,a5,80003610 <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    80003604:	fffff097          	auipc	ra,0xfffff
    80003608:	2b4080e7          	jalr	692(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000360c:	fddff06f          	j	800035e8 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003610:	00813083          	ld	ra,8(sp)
    80003614:	00013403          	ld	s0,0(sp)
    80003618:	01010113          	addi	sp,sp,16
    8000361c:	00008067          	ret

0000000080003620 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003620:	ff010113          	addi	sp,sp,-16
    80003624:	00813423          	sd	s0,8(sp)
    80003628:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    8000362c:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003630:	00004717          	auipc	a4,0x4
    80003634:	54073703          	ld	a4,1344(a4) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003638:	00073703          	ld	a4,0(a4)
    8000363c:	06873703          	ld	a4,104(a4)
    80003640:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003644:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003648:	00078593          	mv	a1,a5
}
    8000364c:	00813403          	ld	s0,8(sp)
    80003650:	01010113          	addi	sp,sp,16
    80003654:	00008067          	ret

0000000080003658 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003658:	ff010113          	addi	sp,sp,-16
    8000365c:	00113423          	sd	ra,8(sp)
    80003660:	00813023          	sd	s0,0(sp)
    80003664:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003668:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    8000366c:	fffff097          	auipc	ra,0xfffff
    80003670:	4d0080e7          	jalr	1232(ra) # 80002b3c <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003674:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003678:	00000097          	auipc	ra,0x0
    8000367c:	fa8080e7          	jalr	-88(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003680:	00813083          	ld	ra,8(sp)
    80003684:	00013403          	ld	s0,0(sp)
    80003688:	01010113          	addi	sp,sp,16
    8000368c:	00008067          	ret

0000000080003690 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003690:	ff010113          	addi	sp,sp,-16
    80003694:	00113423          	sd	ra,8(sp)
    80003698:	00813023          	sd	s0,0(sp)
    8000369c:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    800036a0:	00004797          	auipc	a5,0x4
    800036a4:	4e07b783          	ld	a5,1248(a5) # 80007b80 <_GLOBAL_OFFSET_TABLE_+0xc0>
    800036a8:	0007c783          	lbu	a5,0(a5)
    800036ac:	02079263          	bnez	a5,800036d0 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    800036b0:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800036b4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800036b8:	00000097          	auipc	ra,0x0
    800036bc:	f68080e7          	jalr	-152(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    800036c0:	00813083          	ld	ra,8(sp)
    800036c4:	00013403          	ld	s0,0(sp)
    800036c8:	01010113          	addi	sp,sp,16
    800036cc:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800036d0:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    800036d4:	fffff097          	auipc	ra,0xfffff
    800036d8:	6a0080e7          	jalr	1696(ra) # 80002d74 <_ZN15MemoryAllocator5kfreeEPv>
    800036dc:	fd9ff06f          	j	800036b4 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

00000000800036e0 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    800036e0:	fc010113          	addi	sp,sp,-64
    800036e4:	02113c23          	sd	ra,56(sp)
    800036e8:	02813823          	sd	s0,48(sp)
    800036ec:	02913423          	sd	s1,40(sp)
    800036f0:	03213023          	sd	s2,32(sp)
    800036f4:	01313c23          	sd	s3,24(sp)
    800036f8:	01413823          	sd	s4,16(sp)
    800036fc:	01513423          	sd	s5,8(sp)
    80003700:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003704:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003708:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000370c:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003710:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003714:	07000513          	li	a0,112
    80003718:	fffff097          	auipc	ra,0xfffff
    8000371c:	220080e7          	jalr	544(ra) # 80002938 <_ZN3TCBnwEm>
    80003720:	00050493          	mv	s1,a0
    80003724:	00050e63          	beqz	a0,80003740 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    80003728:	00200713          	li	a4,2
    8000372c:	000a8693          	mv	a3,s5
    80003730:	000a0613          	mv	a2,s4
    80003734:	00098593          	mv	a1,s3
    80003738:	fffff097          	auipc	ra,0xfffff
    8000373c:	0c4080e7          	jalr	196(ra) # 800027fc <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003740:	04048863          	beqz	s1,80003790 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    80003744:	0184b783          	ld	a5,24(s1)
    80003748:	00078863          	beqz	a5,80003758 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    8000374c:	00048513          	mv	a0,s1
    80003750:	00001097          	auipc	ra,0x1
    80003754:	ca8080e7          	jalr	-856(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003758:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    8000375c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003760:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003764:	00000097          	auipc	ra,0x0
    80003768:	ebc080e7          	jalr	-324(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000376c:	03813083          	ld	ra,56(sp)
    80003770:	03013403          	ld	s0,48(sp)
    80003774:	02813483          	ld	s1,40(sp)
    80003778:	02013903          	ld	s2,32(sp)
    8000377c:	01813983          	ld	s3,24(sp)
    80003780:	01013a03          	ld	s4,16(sp)
    80003784:	00813a83          	ld	s5,8(sp)
    80003788:	04010113          	addi	sp,sp,64
    8000378c:	00008067          	ret
        status = -1;
    80003790:	fff00793          	li	a5,-1
    80003794:	fcdff06f          	j	80003760 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    80003798:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000379c:	00048513          	mv	a0,s1
    800037a0:	fffff097          	auipc	ra,0xfffff
    800037a4:	2bc080e7          	jalr	700(ra) # 80002a5c <_ZN3TCBdlEPv>
    800037a8:	00090513          	mv	a0,s2
    800037ac:	00009097          	auipc	ra,0x9
    800037b0:	74c080e7          	jalr	1868(ra) # 8000cef8 <_Unwind_Resume>

00000000800037b4 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    800037b4:	fc010113          	addi	sp,sp,-64
    800037b8:	02113c23          	sd	ra,56(sp)
    800037bc:	02813823          	sd	s0,48(sp)
    800037c0:	02913423          	sd	s1,40(sp)
    800037c4:	03213023          	sd	s2,32(sp)
    800037c8:	01313c23          	sd	s3,24(sp)
    800037cc:	01413823          	sd	s4,16(sp)
    800037d0:	01513423          	sd	s5,8(sp)
    800037d4:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    800037d8:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800037dc:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    800037e0:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    800037e4:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800037e8:	07000513          	li	a0,112
    800037ec:	fffff097          	auipc	ra,0xfffff
    800037f0:	14c080e7          	jalr	332(ra) # 80002938 <_ZN3TCBnwEm>
    800037f4:	00050493          	mv	s1,a0
    800037f8:	00050e63          	beqz	a0,80003814 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    800037fc:	00200713          	li	a4,2
    80003800:	000a8693          	mv	a3,s5
    80003804:	00090613          	mv	a2,s2
    80003808:	00098593          	mv	a1,s3
    8000380c:	fffff097          	auipc	ra,0xfffff
    80003810:	ff0080e7          	jalr	-16(ra) # 800027fc <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003814:	04048263          	beqz	s1,80003858 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    80003818:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    8000381c:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80003820:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    80003824:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003828:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000382c:	00000097          	auipc	ra,0x0
    80003830:	df4080e7          	jalr	-524(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003834:	03813083          	ld	ra,56(sp)
    80003838:	03013403          	ld	s0,48(sp)
    8000383c:	02813483          	ld	s1,40(sp)
    80003840:	02013903          	ld	s2,32(sp)
    80003844:	01813983          	ld	s3,24(sp)
    80003848:	01013a03          	ld	s4,16(sp)
    8000384c:	00813a83          	ld	s5,8(sp)
    80003850:	04010113          	addi	sp,sp,64
    80003854:	00008067          	ret
        status = -1;
    80003858:	fff00793          	li	a5,-1
    8000385c:	fcdff06f          	j	80003828 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    80003860:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003864:	00048513          	mv	a0,s1
    80003868:	fffff097          	auipc	ra,0xfffff
    8000386c:	1f4080e7          	jalr	500(ra) # 80002a5c <_ZN3TCBdlEPv>
    80003870:	00090513          	mv	a0,s2
    80003874:	00009097          	auipc	ra,0x9
    80003878:	684080e7          	jalr	1668(ra) # 8000cef8 <_Unwind_Resume>

000000008000387c <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    8000387c:	ff010113          	addi	sp,sp,-16
    80003880:	00113423          	sd	ra,8(sp)
    80003884:	00813023          	sd	s0,0(sp)
    80003888:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000388c:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003890:	02051263          	bnez	a0,800038b4 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003894:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003898:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000389c:	00000097          	auipc	ra,0x0
    800038a0:	d84080e7          	jalr	-636(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    800038a4:	00813083          	ld	ra,8(sp)
    800038a8:	00013403          	ld	s0,0(sp)
    800038ac:	01010113          	addi	sp,sp,16
    800038b0:	00008067          	ret
        tcb->status = TCB::Status::READY;
    800038b4:	00100793          	li	a5,1
    800038b8:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    800038bc:	00001097          	auipc	ra,0x1
    800038c0:	b3c080e7          	jalr	-1220(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    800038c4:	fffff097          	auipc	ra,0xfffff
    800038c8:	ff4080e7          	jalr	-12(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    800038cc:	00000793          	li	a5,0
    800038d0:	fc9ff06f          	j	80003898 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

00000000800038d4 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    800038d4:	ff010113          	addi	sp,sp,-16
    800038d8:	00113423          	sd	ra,8(sp)
    800038dc:	00813023          	sd	s0,0(sp)
    800038e0:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    800038e4:	00004797          	auipc	a5,0x4
    800038e8:	28c7b783          	ld	a5,652(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800038ec:	0007b783          	ld	a5,0(a5)
    800038f0:	02078a63          	beqz	a5,80003924 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    800038f4:	00200713          	li	a4,2
    800038f8:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    800038fc:	fffff097          	auipc	ra,0xfffff
    80003900:	fbc080e7          	jalr	-68(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003904:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003908:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000390c:	00000097          	auipc	ra,0x0
    80003910:	d14080e7          	jalr	-748(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003914:	00813083          	ld	ra,8(sp)
    80003918:	00013403          	ld	s0,0(sp)
    8000391c:	01010113          	addi	sp,sp,16
    80003920:	00008067          	ret
        status = -1;
    80003924:	fff00793          	li	a5,-1
    80003928:	fe1ff06f          	j	80003908 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

000000008000392c <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    8000392c:	fd010113          	addi	sp,sp,-48
    80003930:	02113423          	sd	ra,40(sp)
    80003934:	02813023          	sd	s0,32(sp)
    80003938:	00913c23          	sd	s1,24(sp)
    8000393c:	01213823          	sd	s2,16(sp)
    80003940:	01313423          	sd	s3,8(sp)
    80003944:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003948:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    8000394c:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    80003950:	01800513          	li	a0,24
    80003954:	fffff097          	auipc	ra,0xfffff
    80003958:	d54080e7          	jalr	-684(ra) # 800026a8 <_ZN3SCBnwEm>
    8000395c:	00050493          	mv	s1,a0
    80003960:	00050863          	beqz	a0,80003970 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    80003964:	00098593          	mv	a1,s3
    80003968:	fffff097          	auipc	ra,0xfffff
    8000396c:	b8c080e7          	jalr	-1140(ra) # 800024f4 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003970:	02048a63          	beqz	s1,800039a4 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    80003974:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80003978:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000397c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003980:	00000097          	auipc	ra,0x0
    80003984:	ca0080e7          	jalr	-864(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003988:	02813083          	ld	ra,40(sp)
    8000398c:	02013403          	ld	s0,32(sp)
    80003990:	01813483          	ld	s1,24(sp)
    80003994:	01013903          	ld	s2,16(sp)
    80003998:	00813983          	ld	s3,8(sp)
    8000399c:	03010113          	addi	sp,sp,48
    800039a0:	00008067          	ret
        status = -1;
    800039a4:	fff00793          	li	a5,-1
    800039a8:	fd5ff06f          	j	8000397c <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    800039ac:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    800039b0:	00048513          	mv	a0,s1
    800039b4:	fffff097          	auipc	ra,0xfffff
    800039b8:	d24080e7          	jalr	-732(ra) # 800026d8 <_ZN3SCBdlEPv>
    800039bc:	00090513          	mv	a0,s2
    800039c0:	00009097          	auipc	ra,0x9
    800039c4:	538080e7          	jalr	1336(ra) # 8000cef8 <_Unwind_Resume>

00000000800039c8 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    800039c8:	fe010113          	addi	sp,sp,-32
    800039cc:	00113c23          	sd	ra,24(sp)
    800039d0:	00813823          	sd	s0,16(sp)
    800039d4:	00913423          	sd	s1,8(sp)
    800039d8:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800039dc:	00058493          	mv	s1,a1
    if(scb == nullptr){
    800039e0:	02049463          	bnez	s1,80003a08 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    800039e4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800039e8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800039ec:	00000097          	auipc	ra,0x0
    800039f0:	c34080e7          	jalr	-972(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    800039f4:	01813083          	ld	ra,24(sp)
    800039f8:	01013403          	ld	s0,16(sp)
    800039fc:	00813483          	ld	s1,8(sp)
    80003a00:	02010113          	addi	sp,sp,32
    80003a04:	00008067          	ret
        delete (SCB*)ihandle;
    80003a08:	00048513          	mv	a0,s1
    80003a0c:	fffff097          	auipc	ra,0xfffff
    80003a10:	b04080e7          	jalr	-1276(ra) # 80002510 <_ZN3SCBD1Ev>
    80003a14:	00048513          	mv	a0,s1
    80003a18:	fffff097          	auipc	ra,0xfffff
    80003a1c:	cc0080e7          	jalr	-832(ra) # 800026d8 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003a20:	00000793          	li	a5,0
    80003a24:	fc5ff06f          	j	800039e8 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080003a28 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80003a28:	ff010113          	addi	sp,sp,-16
    80003a2c:	00113423          	sd	ra,8(sp)
    80003a30:	00813023          	sd	s0,0(sp)
    80003a34:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003a38:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003a3c:	02051c63          	bnez	a0,80003a74 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80003a40:	00004797          	auipc	a5,0x4
    80003a44:	1307b783          	ld	a5,304(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003a48:	0007b783          	ld	a5,0(a5)
    80003a4c:	0607b783          	ld	a5,96(a5)
    80003a50:	02078863          	beqz	a5,80003a80 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003a54:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a58:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003a5c:	00000097          	auipc	ra,0x0
    80003a60:	bc4080e7          	jalr	-1084(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a64:	00813083          	ld	ra,8(sp)
    80003a68:	00013403          	ld	s0,0(sp)
    80003a6c:	01010113          	addi	sp,sp,16
    80003a70:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003a74:	fffff097          	auipc	ra,0xfffff
    80003a78:	ba8080e7          	jalr	-1112(ra) # 8000261c <_ZN3SCB4waitEv>
    80003a7c:	fc5ff06f          	j	80003a40 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80003a80:	00000793          	li	a5,0
    80003a84:	fd5ff06f          	j	80003a58 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003a88 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003a88:	ff010113          	addi	sp,sp,-16
    80003a8c:	00113423          	sd	ra,8(sp)
    80003a90:	00813023          	sd	s0,0(sp)
    80003a94:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003a98:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003a9c:	02051263          	bnez	a0,80003ac0 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003aa0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003aa4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003aa8:	00000097          	auipc	ra,0x0
    80003aac:	b78080e7          	jalr	-1160(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ab0:	00813083          	ld	ra,8(sp)
    80003ab4:	00013403          	ld	s0,0(sp)
    80003ab8:	01010113          	addi	sp,sp,16
    80003abc:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003ac0:	fffff097          	auipc	ra,0xfffff
    80003ac4:	bac080e7          	jalr	-1108(ra) # 8000266c <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003ac8:	00000793          	li	a5,0
    80003acc:	fd9ff06f          	j	80003aa4 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003ad0 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003ad0:	fe010113          	addi	sp,sp,-32
    80003ad4:	00113c23          	sd	ra,24(sp)
    80003ad8:	00813823          	sd	s0,16(sp)
    80003adc:	00913423          	sd	s1,8(sp)
    80003ae0:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003ae4:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003ae8:	00004797          	auipc	a5,0x4
    80003aec:	0887b783          	ld	a5,136(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003af0:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003af4:	00004797          	auipc	a5,0x4
    80003af8:	2d47b783          	ld	a5,724(a5) # 80007dc8 <_ZN5RiscV10globalTimeE>
    80003afc:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003b00:	00e787b3          	add	a5,a5,a4
    80003b04:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003b08:	00048513          	mv	a0,s1
    80003b0c:	00001097          	auipc	ra,0x1
    80003b10:	968080e7          	jalr	-1688(ra) # 80004474 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003b14:	00300793          	li	a5,3
    80003b18:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003b1c:	fffff097          	auipc	ra,0xfffff
    80003b20:	d9c080e7          	jalr	-612(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b24:	00000793          	li	a5,0
    80003b28:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003b2c:	00000097          	auipc	ra,0x0
    80003b30:	af4080e7          	jalr	-1292(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b34:	01813083          	ld	ra,24(sp)
    80003b38:	01013403          	ld	s0,16(sp)
    80003b3c:	00813483          	ld	s1,8(sp)
    80003b40:	02010113          	addi	sp,sp,32
    80003b44:	00008067          	ret

0000000080003b48 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003b48:	fe010113          	addi	sp,sp,-32
    80003b4c:	00113c23          	sd	ra,24(sp)
    80003b50:	00813823          	sd	s0,16(sp)
    80003b54:	00913423          	sd	s1,8(sp)
    80003b58:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003b5c:	00004797          	auipc	a5,0x4
    80003b60:	2647c783          	lbu	a5,612(a5) # 80007dc0 <_ZN5RiscV16userMainFinishedE>
    80003b64:	00079c63          	bnez	a5,80003b7c <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003b68:	00004717          	auipc	a4,0x4
    80003b6c:	fb873703          	ld	a4,-72(a4) # 80007b20 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003b70:	00073783          	ld	a5,0(a4)
    80003b74:	00178793          	addi	a5,a5,1
    80003b78:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003b7c:	00001097          	auipc	ra,0x1
    80003b80:	ba0080e7          	jalr	-1120(ra) # 8000471c <_ZN11ConsoleUtil8getInputEv>
    80003b84:	00050493          	mv	s1,a0
    if(c==13) {
    80003b88:	00d00793          	li	a5,13
    80003b8c:	02f50663          	beq	a0,a5,80003bb8 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80003b90:	01b00793          	li	a5,27
    80003b94:	04f51063          	bne	a0,a5,80003bd4 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003b98:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003b9c:	00000097          	auipc	ra,0x0
    80003ba0:	a84080e7          	jalr	-1404(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ba4:	01813083          	ld	ra,24(sp)
    80003ba8:	01013403          	ld	s0,16(sp)
    80003bac:	00813483          	ld	s1,8(sp)
    80003bb0:	02010113          	addi	sp,sp,32
    80003bb4:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003bb8:	00d00513          	li	a0,13
    80003bbc:	00001097          	auipc	ra,0x1
    80003bc0:	bd8080e7          	jalr	-1064(ra) # 80004794 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003bc4:	00a00513          	li	a0,10
    80003bc8:	00001097          	auipc	ra,0x1
    80003bcc:	bcc080e7          	jalr	-1076(ra) # 80004794 <_ZN11ConsoleUtil9putOutputEc>
    80003bd0:	fc9ff06f          	j	80003b98 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003bd4:	00001097          	auipc	ra,0x1
    80003bd8:	bc0080e7          	jalr	-1088(ra) # 80004794 <_ZN11ConsoleUtil9putOutputEc>
    80003bdc:	fbdff06f          	j	80003b98 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003be0 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003be0:	ff010113          	addi	sp,sp,-16
    80003be4:	00113423          	sd	ra,8(sp)
    80003be8:	00813023          	sd	s0,0(sp)
    80003bec:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003bf0:	00001097          	auipc	ra,0x1
    80003bf4:	c24080e7          	jalr	-988(ra) # 80004814 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003bf8:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003bfc:	00000097          	auipc	ra,0x0
    80003c00:	a24080e7          	jalr	-1500(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003c04:	00813083          	ld	ra,8(sp)
    80003c08:	00013403          	ld	s0,0(sp)
    80003c0c:	01010113          	addi	sp,sp,16
    80003c10:	00008067          	ret

0000000080003c14 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003c14:	fe010113          	addi	sp,sp,-32
    80003c18:	00113c23          	sd	ra,24(sp)
    80003c1c:	00813823          	sd	s0,16(sp)
    80003c20:	00913423          	sd	s1,8(sp)
    80003c24:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003c28:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003c2c:	02049463          	bnez	s1,80003c54 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003c30:	fff00793          	li	a5,-1
    80003c34:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003c38:	00000097          	auipc	ra,0x0
    80003c3c:	9e8080e7          	jalr	-1560(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003c40:	01813083          	ld	ra,24(sp)
    80003c44:	01013403          	ld	s0,16(sp)
    80003c48:	00813483          	ld	s1,8(sp)
    80003c4c:	02010113          	addi	sp,sp,32
    80003c50:	00008067          	ret
        kfree(thr->stack);
    80003c54:	0284b503          	ld	a0,40(s1)
    80003c58:	00001097          	auipc	ra,0x1
    80003c5c:	f30080e7          	jalr	-208(ra) # 80004b88 <_Z5kfreePKv>
        delete thr;
    80003c60:	00048513          	mv	a0,s1
    80003c64:	fffff097          	auipc	ra,0xfffff
    80003c68:	c2c080e7          	jalr	-980(ra) # 80002890 <_ZN3TCBD1Ev>
    80003c6c:	00048513          	mv	a0,s1
    80003c70:	fffff097          	auipc	ra,0xfffff
    80003c74:	dec080e7          	jalr	-532(ra) # 80002a5c <_ZN3TCBdlEPv>
    80003c78:	fb9ff06f          	j	80003c30 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080003c7c <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003c7c:	fe010113          	addi	sp,sp,-32
    80003c80:	00113c23          	sd	ra,24(sp)
    80003c84:	00813823          	sd	s0,16(sp)
    80003c88:	00913423          	sd	s1,8(sp)
    80003c8c:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003c90:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003c94:	02049463          	bnez	s1,80003cbc <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003c98:	fff00793          	li	a5,-1
    80003c9c:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003ca0:	00000097          	auipc	ra,0x0
    80003ca4:	980080e7          	jalr	-1664(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ca8:	01813083          	ld	ra,24(sp)
    80003cac:	01013403          	ld	s0,16(sp)
    80003cb0:	00813483          	ld	s1,8(sp)
    80003cb4:	02010113          	addi	sp,sp,32
    80003cb8:	00008067          	ret
        delete scb;
    80003cbc:	00048513          	mv	a0,s1
    80003cc0:	fffff097          	auipc	ra,0xfffff
    80003cc4:	850080e7          	jalr	-1968(ra) # 80002510 <_ZN3SCBD1Ev>
    80003cc8:	00048513          	mv	a0,s1
    80003ccc:	fffff097          	auipc	ra,0xfffff
    80003cd0:	a0c080e7          	jalr	-1524(ra) # 800026d8 <_ZN3SCBdlEPv>
    80003cd4:	fc5ff06f          	j	80003c98 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003cd8 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003cd8:	fe010113          	addi	sp,sp,-32
    80003cdc:	00113c23          	sd	ra,24(sp)
    80003ce0:	00813823          	sd	s0,16(sp)
    80003ce4:	00913423          	sd	s1,8(sp)
    80003ce8:	01213023          	sd	s2,0(sp)
    80003cec:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80003cf0:	00001537          	lui	a0,0x1
    80003cf4:	00001097          	auipc	ra,0x1
    80003cf8:	e6c080e7          	jalr	-404(ra) # 80004b60 <_Z7kmallocm>
    80003cfc:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003d00:	00004797          	auipc	a5,0x4
    80003d04:	e707b783          	ld	a5,-400(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003d08:	0007b783          	ld	a5,0(a5)
    80003d0c:	00001637          	lui	a2,0x1
    80003d10:	00050593          	mv	a1,a0
    80003d14:	0287b503          	ld	a0,40(a5)
    80003d18:	fffff097          	auipc	ra,0xfffff
    80003d1c:	210080e7          	jalr	528(ra) # 80002f28 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003d20:	07000513          	li	a0,112
    80003d24:	fffff097          	auipc	ra,0xfffff
    80003d28:	c14080e7          	jalr	-1004(ra) # 80002938 <_ZN3TCBnwEm>
    80003d2c:	00050493          	mv	s1,a0
    80003d30:	00050e63          	beqz	a0,80003d4c <_ZN5RiscV18executeForkSyscallEv+0x74>
    80003d34:	00200713          	li	a4,2
    80003d38:	00090693          	mv	a3,s2
    80003d3c:	00000613          	li	a2,0
    80003d40:	00000593          	li	a1,0
    80003d44:	fffff097          	auipc	ra,0xfffff
    80003d48:	ab8080e7          	jalr	-1352(ra) # 800027fc <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003d4c:	0a048e63          	beqz	s1,80003e08 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003d50:	00004797          	auipc	a5,0x4
    80003d54:	de87b783          	ld	a5,-536(a5) # 80007b38 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003d58:	0007b783          	ld	a5,0(a5)
    80003d5c:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003d60:	00004797          	auipc	a5,0x4
    80003d64:	dc87b783          	ld	a5,-568(a5) # 80007b28 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003d68:	0007b783          	ld	a5,0(a5)
    80003d6c:	00f907b3          	add	a5,s2,a5
    80003d70:	00004717          	auipc	a4,0x4
    80003d74:	e0073703          	ld	a4,-512(a4) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003d78:	00073683          	ld	a3,0(a4)
    80003d7c:	0286b683          	ld	a3,40(a3)
    80003d80:	40d787b3          	sub	a5,a5,a3
    80003d84:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003d88:	00073783          	ld	a5,0(a4)
    80003d8c:	0687b503          	ld	a0,104(a5)
    80003d90:	0287b783          	ld	a5,40(a5)
    80003d94:	40f50533          	sub	a0,a0,a5
    80003d98:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003d9c:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003da0:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80003da4:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003da8:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80003dac:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80003db0:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80003db4:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80003db8:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003dbc:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003dc0:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003dc4:	00073783          	ld	a5,0(a4)
    80003dc8:	0387b703          	ld	a4,56(a5)
    80003dcc:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003dd0:	0407b783          	ld	a5,64(a5)
    80003dd4:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003dd8:	00048513          	mv	a0,s1
    80003ddc:	00000097          	auipc	ra,0x0
    80003de0:	61c080e7          	jalr	1564(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003de4:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003de8:	00000097          	auipc	ra,0x0
    80003dec:	838080e7          	jalr	-1992(ra) # 80003620 <_ZN5RiscV16saveA0toSscratchEv>

}
    80003df0:	01813083          	ld	ra,24(sp)
    80003df4:	01013403          	ld	s0,16(sp)
    80003df8:	00813483          	ld	s1,8(sp)
    80003dfc:	00013903          	ld	s2,0(sp)
    80003e00:	02010113          	addi	sp,sp,32
    80003e04:	00008067          	ret
        status = -1;
    80003e08:	fff00493          	li	s1,-1
    80003e0c:	fd9ff06f          	j	80003de4 <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80003e10:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003e14:	00048513          	mv	a0,s1
    80003e18:	fffff097          	auipc	ra,0xfffff
    80003e1c:	c44080e7          	jalr	-956(ra) # 80002a5c <_ZN3TCBdlEPv>
    80003e20:	00090513          	mv	a0,s2
    80003e24:	00009097          	auipc	ra,0x9
    80003e28:	0d4080e7          	jalr	212(ra) # 8000cef8 <_Unwind_Resume>

0000000080003e2c <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003e2c:	ff010113          	addi	sp,sp,-16
    80003e30:	00813423          	sd	s0,8(sp)
    80003e34:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003e38:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003e3c:	00878793          	addi	a5,a5,8
    80003e40:	00004717          	auipc	a4,0x4
    80003e44:	cf873703          	ld	a4,-776(a4) # 80007b38 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003e48:	00f73023          	sd	a5,0(a4)
}
    80003e4c:	00813403          	ld	s0,8(sp)
    80003e50:	01010113          	addi	sp,sp,16
    80003e54:	00008067          	ret

0000000080003e58 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003e58:	f9010113          	addi	sp,sp,-112
    80003e5c:	06113423          	sd	ra,104(sp)
    80003e60:	06813023          	sd	s0,96(sp)
    80003e64:	04913c23          	sd	s1,88(sp)
    80003e68:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    80003e6c:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003e70:	142027f3          	csrr	a5,scause
    80003e74:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80003e78:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    80003e7c:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80003e80:	00004797          	auipc	a5,0x4
    80003e84:	cf07b783          	ld	a5,-784(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003e88:	0007b783          	ld	a5,0(a5)
    80003e8c:	14002773          	csrr	a4,sscratch
    80003e90:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80003e94:	fd843703          	ld	a4,-40(s0)
    80003e98:	00900793          	li	a5,9
    80003e9c:	10f70663          	beq	a4,a5,80003fa8 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    80003ea0:	fd843703          	ld	a4,-40(s0)
    80003ea4:	00800793          	li	a5,8
    80003ea8:	10f70063          	beq	a4,a5,80003fa8 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    80003eac:	fd843703          	ld	a4,-40(s0)
    80003eb0:	fff00793          	li	a5,-1
    80003eb4:	03f79793          	slli	a5,a5,0x3f
    80003eb8:	00178793          	addi	a5,a5,1
    80003ebc:	26f70463          	beq	a4,a5,80004124 <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    80003ec0:	fd843703          	ld	a4,-40(s0)
    80003ec4:	fff00793          	li	a5,-1
    80003ec8:	03f79793          	slli	a5,a5,0x3f
    80003ecc:	00978793          	addi	a5,a5,9
    80003ed0:	2ef70263          	beq	a4,a5,800041b4 <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    80003ed4:	fd843703          	ld	a4,-40(s0)
    80003ed8:	00200793          	li	a5,2
    80003edc:	36f70a63          	beq	a4,a5,80004250 <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    80003ee0:	00003517          	auipc	a0,0x3
    80003ee4:	4a850513          	addi	a0,a0,1192 # 80007388 <CONSOLE_STATUS+0x378>
    80003ee8:	00001097          	auipc	ra,0x1
    80003eec:	9a4080e7          	jalr	-1628(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003ef0:	00003517          	auipc	a0,0x3
    80003ef4:	4a850513          	addi	a0,a0,1192 # 80007398 <CONSOLE_STATUS+0x388>
    80003ef8:	00001097          	auipc	ra,0x1
    80003efc:	994080e7          	jalr	-1644(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003f00:	142027f3          	csrr	a5,scause
    80003f04:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003f08:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80003f0c:	00000613          	li	a2,0
    80003f10:	00a00593          	li	a1,10
    80003f14:	0005051b          	sext.w	a0,a0
    80003f18:	00001097          	auipc	ra,0x1
    80003f1c:	9b8080e7          	jalr	-1608(ra) # 800048d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003f20:	00003517          	auipc	a0,0x3
    80003f24:	43850513          	addi	a0,a0,1080 # 80007358 <CONSOLE_STATUS+0x348>
    80003f28:	00001097          	auipc	ra,0x1
    80003f2c:	964080e7          	jalr	-1692(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003f30:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003f34:	00000613          	li	a2,0
    80003f38:	01000593          	li	a1,16
    80003f3c:	0005051b          	sext.w	a0,a0
    80003f40:	00001097          	auipc	ra,0x1
    80003f44:	990080e7          	jalr	-1648(ra) # 800048d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003f48:	00003517          	auipc	a0,0x3
    80003f4c:	40850513          	addi	a0,a0,1032 # 80007350 <CONSOLE_STATUS+0x340>
    80003f50:	00001097          	auipc	ra,0x1
    80003f54:	93c080e7          	jalr	-1732(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    80003f58:	01000693          	li	a3,16
    80003f5c:	00003617          	auipc	a2,0x3
    80003f60:	3f460613          	addi	a2,a2,1012 # 80007350 <CONSOLE_STATUS+0x340>
    80003f64:	0004859b          	sext.w	a1,s1
    80003f68:	00003517          	auipc	a0,0x3
    80003f6c:	44050513          	addi	a0,a0,1088 # 800073a8 <CONSOLE_STATUS+0x398>
    80003f70:	00001097          	auipc	ra,0x1
    80003f74:	a3c080e7          	jalr	-1476(ra) # 800049ac <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80003f78:	00004797          	auipc	a5,0x4
    80003f7c:	bf87b783          	ld	a5,-1032(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003f80:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003f84:	00200713          	li	a4,2
    80003f88:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003f8c:	00003517          	auipc	a0,0x3
    80003f90:	42450513          	addi	a0,a0,1060 # 800073b0 <CONSOLE_STATUS+0x3a0>
    80003f94:	00001097          	auipc	ra,0x1
    80003f98:	8f8080e7          	jalr	-1800(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003f9c:	fffff097          	auipc	ra,0xfffff
    80003fa0:	91c080e7          	jalr	-1764(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    80003fa4:	0800006f          	j	80004024 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003fa8:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003fac:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003fb0:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80003fb4:	00478793          	addi	a5,a5,4
    80003fb8:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    80003fbc:	00004797          	auipc	a5,0x4
    80003fc0:	bb47b783          	ld	a5,-1100(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003fc4:	0007b783          	ld	a5,0(a5)
    80003fc8:	fa043703          	ld	a4,-96(s0)
    80003fcc:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80003fd0:	f9843703          	ld	a4,-104(s0)
    80003fd4:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80003fd8:	00050793          	mv	a5,a0
        switch(syscallID){
    80003fdc:	06100713          	li	a4,97
    80003fe0:	02f76463          	bltu	a4,a5,80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    80003fe4:	00279793          	slli	a5,a5,0x2
    80003fe8:	00003717          	auipc	a4,0x3
    80003fec:	3dc70713          	addi	a4,a4,988 # 800073c4 <CONSOLE_STATUS+0x3b4>
    80003ff0:	00e787b3          	add	a5,a5,a4
    80003ff4:	0007a783          	lw	a5,0(a5)
    80003ff8:	00e787b3          	add	a5,a5,a4
    80003ffc:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004000:	fffff097          	auipc	ra,0xfffff
    80004004:	658080e7          	jalr	1624(ra) # 80003658 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004008:	00004797          	auipc	a5,0x4
    8000400c:	b687b783          	ld	a5,-1176(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80004010:	0007b783          	ld	a5,0(a5)
    80004014:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004018:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    8000401c:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004020:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80004024:	fffff097          	auipc	ra,0xfffff
    80004028:	504080e7          	jalr	1284(ra) # 80003528 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    8000402c:	06813083          	ld	ra,104(sp)
    80004030:	06013403          	ld	s0,96(sp)
    80004034:	05813483          	ld	s1,88(sp)
    80004038:	07010113          	addi	sp,sp,112
    8000403c:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80004040:	fffff097          	auipc	ra,0xfffff
    80004044:	650080e7          	jalr	1616(ra) # 80003690 <_ZN5RiscV21executeMemFreeSyscallEv>
    80004048:	fc1ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    8000404c:	fffff097          	auipc	ra,0xfffff
    80004050:	694080e7          	jalr	1684(ra) # 800036e0 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004054:	fb5ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    80004058:	00000097          	auipc	ra,0x0
    8000405c:	87c080e7          	jalr	-1924(ra) # 800038d4 <_ZN5RiscV24executeThreadExitSyscallEv>
    80004060:	fa9ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004064:	fffff097          	auipc	ra,0xfffff
    80004068:	3b0080e7          	jalr	944(ra) # 80003414 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    8000406c:	f9dff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80004070:	fffff097          	auipc	ra,0xfffff
    80004074:	744080e7          	jalr	1860(ra) # 800037b4 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004078:	f91ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    8000407c:	00000097          	auipc	ra,0x0
    80004080:	800080e7          	jalr	-2048(ra) # 8000387c <_ZN5RiscV25executeThreadStartSyscallEv>
    80004084:	f85ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80004088:	00000097          	auipc	ra,0x0
    8000408c:	8a4080e7          	jalr	-1884(ra) # 8000392c <_ZN5RiscV21executeSemOpenSyscallEv>
    80004090:	f79ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    80004094:	00000097          	auipc	ra,0x0
    80004098:	934080e7          	jalr	-1740(ra) # 800039c8 <_ZN5RiscV22executeSemCloseSyscallEv>
    8000409c:	f6dff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    800040a0:	00000097          	auipc	ra,0x0
    800040a4:	988080e7          	jalr	-1656(ra) # 80003a28 <_ZN5RiscV21executeSemWaitSyscallEv>
    800040a8:	f61ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    800040ac:	00000097          	auipc	ra,0x0
    800040b0:	9dc080e7          	jalr	-1572(ra) # 80003a88 <_ZN5RiscV23executeSemSignalSyscallEv>
    800040b4:	f55ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    800040b8:	00000097          	auipc	ra,0x0
    800040bc:	a18080e7          	jalr	-1512(ra) # 80003ad0 <_ZN5RiscV23executeTimeSleepSyscallEv>
    800040c0:	f49ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    800040c4:	00000097          	auipc	ra,0x0
    800040c8:	a84080e7          	jalr	-1404(ra) # 80003b48 <_ZN5RiscV18executeGetcSyscallEv>
    800040cc:	f3dff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    800040d0:	fffff097          	auipc	ra,0xfffff
    800040d4:	380080e7          	jalr	896(ra) # 80003450 <_ZN5RiscV18executePutcSyscallEv>
    800040d8:	f31ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    800040dc:	00000097          	auipc	ra,0x0
    800040e0:	b04080e7          	jalr	-1276(ra) # 80003be0 <_ZN5RiscV22executePutcUtilSyscallEv>
    800040e4:	f25ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    800040e8:	00000097          	auipc	ra,0x0
    800040ec:	b2c080e7          	jalr	-1236(ra) # 80003c14 <_ZN5RiscV24executeThreadFreeSyscallEv>
    800040f0:	f19ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    800040f4:	00000097          	auipc	ra,0x0
    800040f8:	b88080e7          	jalr	-1144(ra) # 80003c7c <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    800040fc:	f0dff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004100:	00010793          	mv	a5,sp
    80004104:	00004717          	auipc	a4,0x4
    80004108:	a2473703          	ld	a4,-1500(a4) # 80007b28 <_GLOBAL_OFFSET_TABLE_+0x68>
    8000410c:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004110:	00000097          	auipc	ra,0x0
    80004114:	d1c080e7          	jalr	-740(ra) # 80003e2c <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004118:	00000097          	auipc	ra,0x0
    8000411c:	bc0080e7          	jalr	-1088(ra) # 80003cd8 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004120:	ee9ff06f          	j	80004008 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004124:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004128:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000412c:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004130:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004134:	00200793          	li	a5,2
    80004138:	1447b073          	csrc	sip,a5
        globalTime += 1;
    8000413c:	00004717          	auipc	a4,0x4
    80004140:	c7c70713          	addi	a4,a4,-900 # 80007db8 <_ZN5RiscV4kPMTE>
    80004144:	01073783          	ld	a5,16(a4)
    80004148:	00178793          	addi	a5,a5,1
    8000414c:	00f73823          	sd	a5,16(a4)
        Scheduler::awake();
    80004150:	00000097          	auipc	ra,0x0
    80004154:	37c080e7          	jalr	892(ra) # 800044cc <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80004158:	00004717          	auipc	a4,0x4
    8000415c:	99073703          	ld	a4,-1648(a4) # 80007ae8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80004160:	00073783          	ld	a5,0(a4)
    80004164:	00178793          	addi	a5,a5,1
    80004168:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    8000416c:	00004717          	auipc	a4,0x4
    80004170:	a0473703          	ld	a4,-1532(a4) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80004174:	00073703          	ld	a4,0(a4)
    80004178:	03073683          	ld	a3,48(a4)
    8000417c:	00d7fc63          	bgeu	a5,a3,80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    80004180:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004184:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004188:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000418c:	14179073          	csrw	sepc,a5
}
    80004190:	e95ff06f          	j	80004024 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    80004194:	00004797          	auipc	a5,0x4
    80004198:	9547b783          	ld	a5,-1708(a5) # 80007ae8 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000419c:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    800041a0:	00100793          	li	a5,1
    800041a4:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    800041a8:	ffffe097          	auipc	ra,0xffffe
    800041ac:	710080e7          	jalr	1808(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    800041b0:	fd1ff06f          	j	80004180 <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800041b4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800041b8:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800041bc:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800041c0:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    800041c4:	00004797          	auipc	a5,0x4
    800041c8:	90c7b783          	ld	a5,-1780(a5) # 80007ad0 <_GLOBAL_OFFSET_TABLE_+0x10>
    800041cc:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800041d0:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800041d4:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800041d8:	00058793          	mv	a5,a1
        if(status & 1UL)
    800041dc:	0017f793          	andi	a5,a5,1
    800041e0:	02078863          	beqz	a5,80004210 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    800041e4:	00004797          	auipc	a5,0x4
    800041e8:	9347b783          	ld	a5,-1740(a5) # 80007b18 <_GLOBAL_OFFSET_TABLE_+0x58>
    800041ec:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    800041f0:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    800041f4:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    800041f8:	00058513          	mv	a0,a1
    800041fc:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004200:	00004797          	auipc	a5,0x4
    80004204:	9207b783          	ld	a5,-1760(a5) # 80007b20 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004208:	0007b783          	ld	a5,0(a5)
    8000420c:	02079463          	bnez	a5,80004234 <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    80004210:	00001097          	auipc	ra,0x1
    80004214:	1f4080e7          	jalr	500(ra) # 80005404 <plic_claim>
    80004218:	00001097          	auipc	ra,0x1
    8000421c:	224080e7          	jalr	548(ra) # 8000543c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004220:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004224:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004228:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000422c:	14179073          	csrw	sepc,a5
}
    80004230:	df5ff06f          	j	80004024 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    80004234:	fff78793          	addi	a5,a5,-1
    80004238:	00004717          	auipc	a4,0x4
    8000423c:	8e873703          	ld	a4,-1816(a4) # 80007b20 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004240:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004244:	00000097          	auipc	ra,0x0
    80004248:	468080e7          	jalr	1128(ra) # 800046ac <_ZN11ConsoleUtil8putInputEc>
    8000424c:	fc5ff06f          	j	80004210 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    80004250:	00004797          	auipc	a5,0x4
    80004254:	9207b783          	ld	a5,-1760(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80004258:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000425c:	00200713          	li	a4,2
    80004260:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004264:	00003517          	auipc	a0,0x3
    80004268:	0f450513          	addi	a0,a0,244 # 80007358 <CONSOLE_STATUS+0x348>
    8000426c:	00000097          	auipc	ra,0x0
    80004270:	620080e7          	jalr	1568(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004274:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004278:	00000613          	li	a2,0
    8000427c:	01000593          	li	a1,16
    80004280:	0005051b          	sext.w	a0,a0
    80004284:	00000097          	auipc	ra,0x0
    80004288:	64c080e7          	jalr	1612(ra) # 800048d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000428c:	00003517          	auipc	a0,0x3
    80004290:	0c450513          	addi	a0,a0,196 # 80007350 <CONSOLE_STATUS+0x340>
    80004294:	00000097          	auipc	ra,0x0
    80004298:	5f8080e7          	jalr	1528(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    8000429c:	00003517          	auipc	a0,0x3
    800042a0:	0c450513          	addi	a0,a0,196 # 80007360 <CONSOLE_STATUS+0x350>
    800042a4:	00000097          	auipc	ra,0x0
    800042a8:	5e8080e7          	jalr	1512(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800042ac:	ffffe097          	auipc	ra,0xffffe
    800042b0:	60c080e7          	jalr	1548(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    800042b4:	d71ff06f          	j	80004024 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

00000000800042b8 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    800042b8:	fd010113          	addi	sp,sp,-48
    800042bc:	02113423          	sd	ra,40(sp)
    800042c0:	02813023          	sd	s0,32(sp)
    800042c4:	00913c23          	sd	s1,24(sp)
    800042c8:	01213823          	sd	s2,16(sp)
    800042cc:	01313423          	sd	s3,8(sp)
    800042d0:	03010413          	addi	s0,sp,48
    800042d4:	00050913          	mv	s2,a0
    800042d8:	00058493          	mv	s1,a1
    800042dc:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    800042e0:	00058e63          	beqz	a1,800042fc <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc(DEFAULT_STACK_SIZE);
    800042e4:	00001537          	lui	a0,0x1
    800042e8:	fffff097          	auipc	ra,0xfffff
    800042ec:	854080e7          	jalr	-1964(ra) # 80002b3c <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    800042f0:	00051863          	bnez	a0,80004300 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    800042f4:	00093023          	sd	zero,0(s2)
            return;
    800042f8:	0200006f          	j	80004318 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    800042fc:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80004300:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80004304:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80004308:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000430c:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80004310:	01100513          	li	a0,17

    asm("ecall");
    80004314:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    80004318:	02813083          	ld	ra,40(sp)
    8000431c:	02013403          	ld	s0,32(sp)
    80004320:	01813483          	ld	s1,24(sp)
    80004324:	01013903          	ld	s2,16(sp)
    80004328:	00813983          	ld	s3,8(sp)
    8000432c:	03010113          	addi	sp,sp,48
    80004330:	00008067          	ret

0000000080004334 <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    80004334:	ff010113          	addi	sp,sp,-16
    80004338:	00813423          	sd	s0,8(sp)
    8000433c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80004340:	01200513          	li	a0,18

    asm("ecall");
    80004344:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    80004348:	00813403          	ld	s0,8(sp)
    8000434c:	01010113          	addi	sp,sp,16
    80004350:	00008067          	ret

0000000080004354 <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    80004354:	ff010113          	addi	sp,sp,-16
    80004358:	00813423          	sd	s0,8(sp)
    8000435c:	01010413          	addi	s0,sp,16
    80004360:	00050793          	mv	a5,a0
    80004364:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004368:	0007c703          	lbu	a4,0(a5)
    8000436c:	00070a63          	beqz	a4,80004380 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004370:	00178793          	addi	a5,a5,1
    80004374:	00e50023          	sb	a4,0(a0) # 1000 <_entry-0x7ffff000>
    80004378:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    8000437c:	fedff06f          	j	80004368 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004380:	00e50023          	sb	a4,0(a0)
    return dst;
}
    80004384:	00813403          	ld	s0,8(sp)
    80004388:	01010113          	addi	sp,sp,16
    8000438c:	00008067          	ret

0000000080004390 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004390:	fe010113          	addi	sp,sp,-32
    80004394:	00113c23          	sd	ra,24(sp)
    80004398:	00813823          	sd	s0,16(sp)
    8000439c:	00913423          	sd	s1,8(sp)
    800043a0:	02010413          	addi	s0,sp,32
    800043a4:	00050493          	mv	s1,a0
    800043a8:	00058513          	mv	a0,a1
    char *dest = dst;
    800043ac:	00048593          	mv	a1,s1
    while(*dest != '\0')
    800043b0:	0005c783          	lbu	a5,0(a1)
    800043b4:	00078663          	beqz	a5,800043c0 <_Z6strcatPcPKc+0x30>
        dest++;
    800043b8:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    800043bc:	ff5ff06f          	j	800043b0 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    800043c0:	00000097          	auipc	ra,0x0
    800043c4:	f94080e7          	jalr	-108(ra) # 80004354 <_Z6strcpyPKcPc>
    return dst;
    800043c8:	00048513          	mv	a0,s1
    800043cc:	01813083          	ld	ra,24(sp)
    800043d0:	01013403          	ld	s0,16(sp)
    800043d4:	00813483          	ld	s1,8(sp)
    800043d8:	02010113          	addi	sp,sp,32
    800043dc:	00008067          	ret

00000000800043e0 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    800043e0:	ff010113          	addi	sp,sp,-16
    800043e4:	00813423          	sd	s0,8(sp)
    800043e8:	01010413          	addi	s0,sp,16
}
    800043ec:	00813403          	ld	s0,8(sp)
    800043f0:	01010113          	addi	sp,sp,16
    800043f4:	00008067          	ret

00000000800043f8 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    800043f8:	ff010113          	addi	sp,sp,-16
    800043fc:	00813423          	sd	s0,8(sp)
    80004400:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004404:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004408:	00004797          	auipc	a5,0x4
    8000440c:	9d07b783          	ld	a5,-1584(a5) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    80004410:	02078263          	beqz	a5,80004434 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004414:	00004797          	auipc	a5,0x4
    80004418:	9cc7b783          	ld	a5,-1588(a5) # 80007de0 <_ZN9Scheduler9readyTailE>
    8000441c:	04a7b423          	sd	a0,72(a5)
    80004420:	00004797          	auipc	a5,0x4
    80004424:	9ca7b023          	sd	a0,-1600(a5) # 80007de0 <_ZN9Scheduler9readyTailE>
}
    80004428:	00813403          	ld	s0,8(sp)
    8000442c:	01010113          	addi	sp,sp,16
    80004430:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004434:	00004797          	auipc	a5,0x4
    80004438:	9aa7b223          	sd	a0,-1628(a5) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    8000443c:	fe5ff06f          	j	80004420 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004440 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004440:	ff010113          	addi	sp,sp,-16
    80004444:	00813423          	sd	s0,8(sp)
    80004448:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    8000444c:	00004517          	auipc	a0,0x4
    80004450:	98c53503          	ld	a0,-1652(a0) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    80004454:	00050a63          	beqz	a0,80004468 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004458:	04853783          	ld	a5,72(a0)
    8000445c:	00004717          	auipc	a4,0x4
    80004460:	96f73e23          	sd	a5,-1668(a4) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004464:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004468:	00813403          	ld	s0,8(sp)
    8000446c:	01010113          	addi	sp,sp,16
    80004470:	00008067          	ret

0000000080004474 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004474:	ff010113          	addi	sp,sp,-16
    80004478:	00813423          	sd	s0,8(sp)
    8000447c:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004480:	00004797          	auipc	a5,0x4
    80004484:	9687b783          	ld	a5,-1688(a5) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
    80004488:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    8000448c:	00078e63          	beqz	a5,800044a8 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004490:	0587b683          	ld	a3,88(a5)
    80004494:	05853703          	ld	a4,88(a0)
    80004498:	00d76863          	bltu	a4,a3,800044a8 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    8000449c:	00078613          	mv	a2,a5
    800044a0:	0487b783          	ld	a5,72(a5)
    800044a4:	fe9ff06f          	j	8000448c <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    800044a8:	04f53423          	sd	a5,72(a0)
    if(prev)
    800044ac:	00060a63          	beqz	a2,800044c0 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    800044b0:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    800044b4:	00813403          	ld	s0,8(sp)
    800044b8:	01010113          	addi	sp,sp,16
    800044bc:	00008067          	ret
        sleepingHead = t;
    800044c0:	00004797          	auipc	a5,0x4
    800044c4:	92a7b423          	sd	a0,-1752(a5) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
}
    800044c8:	fedff06f          	j	800044b4 <_ZN9Scheduler5sleepEP3TCB+0x40>

00000000800044cc <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    800044cc:	fe010113          	addi	sp,sp,-32
    800044d0:	00113c23          	sd	ra,24(sp)
    800044d4:	00813823          	sd	s0,16(sp)
    800044d8:	00913423          	sd	s1,8(sp)
    800044dc:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    800044e0:	00004497          	auipc	s1,0x4
    800044e4:	9084b483          	ld	s1,-1784(s1) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
    800044e8:	02048c63          	beqz	s1,80004520 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    800044ec:	0584b703          	ld	a4,88(s1)
    800044f0:	00003797          	auipc	a5,0x3
    800044f4:	6a07b783          	ld	a5,1696(a5) # 80007b90 <_GLOBAL_OFFSET_TABLE_+0xd0>
    800044f8:	0007b783          	ld	a5,0(a5)
    800044fc:	02e7e263          	bltu	a5,a4,80004520 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004500:	0484b783          	ld	a5,72(s1)
    80004504:	00004717          	auipc	a4,0x4
    80004508:	8ef73223          	sd	a5,-1820(a4) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    8000450c:	00048513          	mv	a0,s1
    80004510:	00000097          	auipc	ra,0x0
    80004514:	ee8080e7          	jalr	-280(ra) # 800043f8 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004518:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    8000451c:	fc5ff06f          	j	800044e0 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004520:	01813083          	ld	ra,24(sp)
    80004524:	01013403          	ld	s0,16(sp)
    80004528:	00813483          	ld	s1,8(sp)
    8000452c:	02010113          	addi	sp,sp,32
    80004530:	00008067          	ret

0000000080004534 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004534:	fe010113          	addi	sp,sp,-32
    80004538:	00113c23          	sd	ra,24(sp)
    8000453c:	00813823          	sd	s0,16(sp)
    80004540:	00913423          	sd	s1,8(sp)
    80004544:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004548:	00004497          	auipc	s1,0x4
    8000454c:	8904b483          	ld	s1,-1904(s1) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004550:	02048863          	beqz	s1,80004580 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004554:	00000613          	li	a2,0
    80004558:	01000593          	li	a1,16
    8000455c:	0004851b          	sext.w	a0,s1
    80004560:	00000097          	auipc	ra,0x0
    80004564:	370080e7          	jalr	880(ra) # 800048d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004568:	00003517          	auipc	a0,0x3
    8000456c:	de850513          	addi	a0,a0,-536 # 80007350 <CONSOLE_STATUS+0x340>
    80004570:	00000097          	auipc	ra,0x0
    80004574:	31c080e7          	jalr	796(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004578:	0484b483          	ld	s1,72(s1)
    while(iter){
    8000457c:	fd5ff06f          	j	80004550 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004580:	01813083          	ld	ra,24(sp)
    80004584:	01013403          	ld	s0,16(sp)
    80004588:	00813483          	ld	s1,8(sp)
    8000458c:	02010113          	addi	sp,sp,32
    80004590:	00008067          	ret

0000000080004594 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004594:	fe010113          	addi	sp,sp,-32
    80004598:	00113c23          	sd	ra,24(sp)
    8000459c:	00813823          	sd	s0,16(sp)
    800045a0:	00913423          	sd	s1,8(sp)
    800045a4:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    800045a8:	00004497          	auipc	s1,0x4
    800045ac:	8404b483          	ld	s1,-1984(s1) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    800045b0:	02048863          	beqz	s1,800045e0 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    800045b4:	00000613          	li	a2,0
    800045b8:	01000593          	li	a1,16
    800045bc:	0004851b          	sext.w	a0,s1
    800045c0:	0000c097          	auipc	ra,0xc
    800045c4:	6f4080e7          	jalr	1780(ra) # 80010cb4 <_Z8printIntiii>
        printString("\n");
    800045c8:	00003517          	auipc	a0,0x3
    800045cc:	d8850513          	addi	a0,a0,-632 # 80007350 <CONSOLE_STATUS+0x340>
    800045d0:	0000c097          	auipc	ra,0xc
    800045d4:	54c080e7          	jalr	1356(ra) # 80010b1c <_Z11printStringPKc>
        iter = iter->next;
    800045d8:	0484b483          	ld	s1,72(s1)
    while(iter){
    800045dc:	fd5ff06f          	j	800045b0 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    800045e0:	01813083          	ld	ra,24(sp)
    800045e4:	01013403          	ld	s0,16(sp)
    800045e8:	00813483          	ld	s1,8(sp)
    800045ec:	02010113          	addi	sp,sp,32
    800045f0:	00008067          	ret

00000000800045f4 <_ZN11ConsoleUtil10initializeEv>:
char ConsoleUtil::inputBuffer[8192];
char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    800045f4:	fe010113          	addi	sp,sp,-32
    800045f8:	00113c23          	sd	ra,24(sp)
    800045fc:	00813823          	sd	s0,16(sp)
    80004600:	00913423          	sd	s1,8(sp)
    80004604:	01213023          	sd	s2,0(sp)
    80004608:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    8000460c:	01800513          	li	a0,24
    80004610:	ffffe097          	auipc	ra,0xffffe
    80004614:	098080e7          	jalr	152(ra) # 800026a8 <_ZN3SCBnwEm>
    80004618:	00050493          	mv	s1,a0
    8000461c:	00050863          	beqz	a0,8000462c <_ZN11ConsoleUtil10initializeEv+0x38>
    80004620:	00000593          	li	a1,0
    80004624:	ffffe097          	auipc	ra,0xffffe
    80004628:	ed0080e7          	jalr	-304(ra) # 800024f4 <_ZN3SCBC1Em>
    8000462c:	00003797          	auipc	a5,0x3
    80004630:	7c97b223          	sd	s1,1988(a5) # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004634:	01800513          	li	a0,24
    80004638:	ffffe097          	auipc	ra,0xffffe
    8000463c:	070080e7          	jalr	112(ra) # 800026a8 <_ZN3SCBnwEm>
    80004640:	00050493          	mv	s1,a0
    80004644:	00050863          	beqz	a0,80004654 <_ZN11ConsoleUtil10initializeEv+0x60>
    80004648:	00000593          	li	a1,0
    8000464c:	ffffe097          	auipc	ra,0xffffe
    80004650:	ea8080e7          	jalr	-344(ra) # 800024f4 <_ZN3SCBC1Em>
    80004654:	00003797          	auipc	a5,0x3
    80004658:	7a97b223          	sd	s1,1956(a5) # 80007df8 <_ZN11ConsoleUtil9outputSemE>
//    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
//    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
}
    8000465c:	01813083          	ld	ra,24(sp)
    80004660:	01013403          	ld	s0,16(sp)
    80004664:	00813483          	ld	s1,8(sp)
    80004668:	00013903          	ld	s2,0(sp)
    8000466c:	02010113          	addi	sp,sp,32
    80004670:	00008067          	ret
    80004674:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004678:	00048513          	mv	a0,s1
    8000467c:	ffffe097          	auipc	ra,0xffffe
    80004680:	05c080e7          	jalr	92(ra) # 800026d8 <_ZN3SCBdlEPv>
    80004684:	00090513          	mv	a0,s2
    80004688:	00009097          	auipc	ra,0x9
    8000468c:	870080e7          	jalr	-1936(ra) # 8000cef8 <_Unwind_Resume>
    80004690:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004694:	00048513          	mv	a0,s1
    80004698:	ffffe097          	auipc	ra,0xffffe
    8000469c:	040080e7          	jalr	64(ra) # 800026d8 <_ZN3SCBdlEPv>
    800046a0:	00090513          	mv	a0,s2
    800046a4:	00009097          	auipc	ra,0x9
    800046a8:	854080e7          	jalr	-1964(ra) # 8000cef8 <_Unwind_Resume>

00000000800046ac <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    800046ac:	00003717          	auipc	a4,0x3
    800046b0:	74470713          	addi	a4,a4,1860 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    800046b4:	01073683          	ld	a3,16(a4)
    800046b8:	00168793          	addi	a5,a3,1
    800046bc:	00003617          	auipc	a2,0x3
    800046c0:	3fc63603          	ld	a2,1020(a2) # 80007ab8 <_ZN11ConsoleUtil10bufferSizeE>
    800046c4:	02c7f7b3          	remu	a5,a5,a2
    800046c8:	01873703          	ld	a4,24(a4)
    800046cc:	04e78663          	beq	a5,a4,80004718 <_ZN11ConsoleUtil8putInputEc+0x6c>
void ConsoleUtil::putInput(char c) {
    800046d0:	ff010113          	addi	sp,sp,-16
    800046d4:	00113423          	sd	ra,8(sp)
    800046d8:	00813023          	sd	s0,0(sp)
    800046dc:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    800046e0:	00005717          	auipc	a4,0x5
    800046e4:	74870713          	addi	a4,a4,1864 # 80009e28 <_ZN11ConsoleUtil11inputBufferE>
    800046e8:	00d706b3          	add	a3,a4,a3
    800046ec:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    800046f0:	00003717          	auipc	a4,0x3
    800046f4:	70070713          	addi	a4,a4,1792 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    800046f8:	00f73823          	sd	a5,16(a4)
    inputSem->signal();
    800046fc:	00073503          	ld	a0,0(a4)
    80004700:	ffffe097          	auipc	ra,0xffffe
    80004704:	f6c080e7          	jalr	-148(ra) # 8000266c <_ZN3SCB6signalEv>
}
    80004708:	00813083          	ld	ra,8(sp)
    8000470c:	00013403          	ld	s0,0(sp)
    80004710:	01010113          	addi	sp,sp,16
    80004714:	00008067          	ret
    80004718:	00008067          	ret

000000008000471c <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    8000471c:	fe010113          	addi	sp,sp,-32
    80004720:	00113c23          	sd	ra,24(sp)
    80004724:	00813823          	sd	s0,16(sp)
    80004728:	00913423          	sd	s1,8(sp)
    8000472c:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004730:	00003497          	auipc	s1,0x3
    80004734:	6c048493          	addi	s1,s1,1728 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    80004738:	0004b503          	ld	a0,0(s1)
    8000473c:	ffffe097          	auipc	ra,0xffffe
    80004740:	ee0080e7          	jalr	-288(ra) # 8000261c <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004744:	0184b783          	ld	a5,24(s1)
    80004748:	0104b703          	ld	a4,16(s1)
    8000474c:	04e78063          	beq	a5,a4,8000478c <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80004750:	00005717          	auipc	a4,0x5
    80004754:	6d870713          	addi	a4,a4,1752 # 80009e28 <_ZN11ConsoleUtil11inputBufferE>
    80004758:	00f70733          	add	a4,a4,a5
    8000475c:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004760:	00178793          	addi	a5,a5,1
    80004764:	00003717          	auipc	a4,0x3
    80004768:	35473703          	ld	a4,852(a4) # 80007ab8 <_ZN11ConsoleUtil10bufferSizeE>
    8000476c:	02e7f7b3          	remu	a5,a5,a4
    80004770:	00003717          	auipc	a4,0x3
    80004774:	68f73c23          	sd	a5,1688(a4) # 80007e08 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004778:	01813083          	ld	ra,24(sp)
    8000477c:	01013403          	ld	s0,16(sp)
    80004780:	00813483          	ld	s1,8(sp)
    80004784:	02010113          	addi	sp,sp,32
    80004788:	00008067          	ret
        return -1;
    8000478c:	0ff00513          	li	a0,255
    80004790:	fe9ff06f          	j	80004778 <_ZN11ConsoleUtil8getInputEv+0x5c>

0000000080004794 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004794:	00003797          	auipc	a5,0x3
    80004798:	65c78793          	addi	a5,a5,1628 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    8000479c:	0207b683          	ld	a3,32(a5)
    800047a0:	00168713          	addi	a4,a3,1
    800047a4:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    800047a8:	0287b603          	ld	a2,40(a5)
    800047ac:	00160713          	addi	a4,a2,1
    800047b0:	00003597          	auipc	a1,0x3
    800047b4:	3085b583          	ld	a1,776(a1) # 80007ab8 <_ZN11ConsoleUtil10bufferSizeE>
    800047b8:	02b77733          	remu	a4,a4,a1
    800047bc:	0307b783          	ld	a5,48(a5)
    800047c0:	04f70863          	beq	a4,a5,80004810 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    800047c4:	ff010113          	addi	sp,sp,-16
    800047c8:	00113423          	sd	ra,8(sp)
    800047cc:	00813023          	sd	s0,0(sp)
    800047d0:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    800047d4:	00003797          	auipc	a5,0x3
    800047d8:	65478793          	addi	a5,a5,1620 # 80007e28 <_ZN11ConsoleUtil12outputBufferE>
    800047dc:	00c78633          	add	a2,a5,a2
    800047e0:	00a60023          	sb	a0,0(a2)

    outputTail = (outputTail+1)%bufferSize;
    800047e4:	00003797          	auipc	a5,0x3
    800047e8:	60c78793          	addi	a5,a5,1548 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    800047ec:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    800047f0:	02d7b023          	sd	a3,32(a5)

    outputSem->signal();
    800047f4:	0087b503          	ld	a0,8(a5)
    800047f8:	ffffe097          	auipc	ra,0xffffe
    800047fc:	e74080e7          	jalr	-396(ra) # 8000266c <_ZN3SCB6signalEv>
}
    80004800:	00813083          	ld	ra,8(sp)
    80004804:	00013403          	ld	s0,0(sp)
    80004808:	01010113          	addi	sp,sp,16
    8000480c:	00008067          	ret
    80004810:	00008067          	ret

0000000080004814 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004814:	fe010113          	addi	sp,sp,-32
    80004818:	00113c23          	sd	ra,24(sp)
    8000481c:	00813823          	sd	s0,16(sp)
    80004820:	00913423          	sd	s1,8(sp)
    80004824:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004828:	00003497          	auipc	s1,0x3
    8000482c:	5c848493          	addi	s1,s1,1480 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    80004830:	0084b503          	ld	a0,8(s1)
    80004834:	ffffe097          	auipc	ra,0xffffe
    80004838:	de8080e7          	jalr	-536(ra) # 8000261c <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    8000483c:	0304b783          	ld	a5,48(s1)
    80004840:	0284b703          	ld	a4,40(s1)
    80004844:	04e78063          	beq	a5,a4,80004884 <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004848:	00003717          	auipc	a4,0x3
    8000484c:	5e070713          	addi	a4,a4,1504 # 80007e28 <_ZN11ConsoleUtil12outputBufferE>
    80004850:	00f70733          	add	a4,a4,a5
    80004854:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004858:	00178793          	addi	a5,a5,1
    8000485c:	00003717          	auipc	a4,0x3
    80004860:	25c73703          	ld	a4,604(a4) # 80007ab8 <_ZN11ConsoleUtil10bufferSizeE>
    80004864:	02e7f7b3          	remu	a5,a5,a4
    80004868:	00003717          	auipc	a4,0x3
    8000486c:	5af73c23          	sd	a5,1464(a4) # 80007e20 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004870:	01813083          	ld	ra,24(sp)
    80004874:	01013403          	ld	s0,16(sp)
    80004878:	00813483          	ld	s1,8(sp)
    8000487c:	02010113          	addi	sp,sp,32
    80004880:	00008067          	ret
        return -1;
    80004884:	0ff00513          	li	a0,255
    80004888:	fe9ff06f          	j	80004870 <_ZN11ConsoleUtil9getOutputEv+0x5c>

000000008000488c <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    8000488c:	fe010113          	addi	sp,sp,-32
    80004890:	00113c23          	sd	ra,24(sp)
    80004894:	00813823          	sd	s0,16(sp)
    80004898:	00913423          	sd	s1,8(sp)
    8000489c:	02010413          	addi	s0,sp,32
    800048a0:	00050493          	mv	s1,a0
    while (*string != '\0')
    800048a4:	0004c503          	lbu	a0,0(s1)
    800048a8:	00050a63          	beqz	a0,800048bc <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    800048ac:	00000097          	auipc	ra,0x0
    800048b0:	ee8080e7          	jalr	-280(ra) # 80004794 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    800048b4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800048b8:	fedff06f          	j	800048a4 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    800048bc:	01813083          	ld	ra,24(sp)
    800048c0:	01013403          	ld	s0,16(sp)
    800048c4:	00813483          	ld	s1,8(sp)
    800048c8:	02010113          	addi	sp,sp,32
    800048cc:	00008067          	ret

00000000800048d0 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800048d0:	fb010113          	addi	sp,sp,-80
    800048d4:	04113423          	sd	ra,72(sp)
    800048d8:	04813023          	sd	s0,64(sp)
    800048dc:	02913c23          	sd	s1,56(sp)
    800048e0:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800048e4:	00003797          	auipc	a5,0x3
    800048e8:	c6c78793          	addi	a5,a5,-916 # 80007550 <CONSOLE_STATUS+0x540>
    800048ec:	0007b703          	ld	a4,0(a5)
    800048f0:	fce43423          	sd	a4,-56(s0)
    800048f4:	0087b703          	ld	a4,8(a5)
    800048f8:	fce43823          	sd	a4,-48(s0)
    800048fc:	0107c783          	lbu	a5,16(a5)
    80004900:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004904:	00060463          	beqz	a2,8000490c <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004908:	08054263          	bltz	a0,8000498c <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000490c:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004910:	00000813          	li	a6,0
    }

    i = 0;
    80004914:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004918:	0005871b          	sext.w	a4,a1
    8000491c:	02b577bb          	remuw	a5,a0,a1
    80004920:	00048693          	mv	a3,s1
    80004924:	0014849b          	addiw	s1,s1,1
    80004928:	02079793          	slli	a5,a5,0x20
    8000492c:	0207d793          	srli	a5,a5,0x20
    80004930:	fe040613          	addi	a2,s0,-32
    80004934:	00f607b3          	add	a5,a2,a5
    80004938:	fe87c603          	lbu	a2,-24(a5)
    8000493c:	fe040793          	addi	a5,s0,-32
    80004940:	00d787b3          	add	a5,a5,a3
    80004944:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004948:	0005061b          	sext.w	a2,a0
    8000494c:	02b5553b          	divuw	a0,a0,a1
    80004950:	fce674e3          	bgeu	a2,a4,80004918 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004954:	00080c63          	beqz	a6,8000496c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004958:	fe040793          	addi	a5,s0,-32
    8000495c:	009784b3          	add	s1,a5,s1
    80004960:	02d00793          	li	a5,45
    80004964:	fcf48c23          	sb	a5,-40(s1)
    80004968:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    8000496c:	fff4849b          	addiw	s1,s1,-1
    80004970:	0204c463          	bltz	s1,80004998 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004974:	fe040793          	addi	a5,s0,-32
    80004978:	009787b3          	add	a5,a5,s1
    8000497c:	fd87c503          	lbu	a0,-40(a5)
    80004980:	00000097          	auipc	ra,0x0
    80004984:	e14080e7          	jalr	-492(ra) # 80004794 <_ZN11ConsoleUtil9putOutputEc>
    80004988:	fe5ff06f          	j	8000496c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    8000498c:	40a0053b          	negw	a0,a0
        neg = 1;
    80004990:	00100813          	li	a6,1
        x = -xx;
    80004994:	f81ff06f          	j	80004914 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004998:	04813083          	ld	ra,72(sp)
    8000499c:	04013403          	ld	s0,64(sp)
    800049a0:	03813483          	ld	s1,56(sp)
    800049a4:	05010113          	addi	sp,sp,80
    800049a8:	00008067          	ret

00000000800049ac <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    800049ac:	fd010113          	addi	sp,sp,-48
    800049b0:	02113423          	sd	ra,40(sp)
    800049b4:	02813023          	sd	s0,32(sp)
    800049b8:	00913c23          	sd	s1,24(sp)
    800049bc:	01213823          	sd	s2,16(sp)
    800049c0:	01313423          	sd	s3,8(sp)
    800049c4:	03010413          	addi	s0,sp,48
    800049c8:	00058913          	mv	s2,a1
    800049cc:	00060493          	mv	s1,a2
    800049d0:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    800049d4:	00000097          	auipc	ra,0x0
    800049d8:	eb8080e7          	jalr	-328(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    800049dc:	00000613          	li	a2,0
    800049e0:	00098593          	mv	a1,s3
    800049e4:	00090513          	mv	a0,s2
    800049e8:	00000097          	auipc	ra,0x0
    800049ec:	ee8080e7          	jalr	-280(ra) # 800048d0 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    800049f0:	00048513          	mv	a0,s1
    800049f4:	00000097          	auipc	ra,0x0
    800049f8:	e98080e7          	jalr	-360(ra) # 8000488c <_ZN11ConsoleUtil11printStringEPKc>
}
    800049fc:	02813083          	ld	ra,40(sp)
    80004a00:	02013403          	ld	s0,32(sp)
    80004a04:	01813483          	ld	s1,24(sp)
    80004a08:	01013903          	ld	s2,16(sp)
    80004a0c:	00813983          	ld	s3,8(sp)
    80004a10:	03010113          	addi	sp,sp,48
    80004a14:	00008067          	ret

0000000080004a18 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004a18:	ff010113          	addi	sp,sp,-16
    80004a1c:	00813423          	sd	s0,8(sp)
    80004a20:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004a24:	04300513          	li	a0,67

    asm("ecall");
    80004a28:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004a2c:	00050513          	mv	a0,a0

    return (char)status;
}
    80004a30:	0ff57513          	andi	a0,a0,255
    80004a34:	00813403          	ld	s0,8(sp)
    80004a38:	01010113          	addi	sp,sp,16
    80004a3c:	00008067          	ret

0000000080004a40 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004a40:	ff010113          	addi	sp,sp,-16
    80004a44:	00113423          	sd	ra,8(sp)
    80004a48:	00813023          	sd	s0,0(sp)
    80004a4c:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004a50:	ffffd097          	auipc	ra,0xffffd
    80004a54:	f68080e7          	jalr	-152(ra) # 800019b8 <_ZN13SlabAllocator10initializeEPvm>
}
    80004a58:	00813083          	ld	ra,8(sp)
    80004a5c:	00013403          	ld	s0,0(sp)
    80004a60:	01010113          	addi	sp,sp,16
    80004a64:	00008067          	ret

0000000080004a68 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80004a68:	ff010113          	addi	sp,sp,-16
    80004a6c:	00113423          	sd	ra,8(sp)
    80004a70:	00813023          	sd	s0,0(sp)
    80004a74:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80004a78:	ffffd097          	auipc	ra,0xffffd
    80004a7c:	e9c080e7          	jalr	-356(ra) # 80001914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004a80:	00813083          	ld	ra,8(sp)
    80004a84:	00013403          	ld	s0,0(sp)
    80004a88:	01010113          	addi	sp,sp,16
    80004a8c:	00008067          	ret

0000000080004a90 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80004a90:	ff010113          	addi	sp,sp,-16
    80004a94:	00113423          	sd	ra,8(sp)
    80004a98:	00813023          	sd	s0,0(sp)
    80004a9c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80004aa0:	ffffd097          	auipc	ra,0xffffd
    80004aa4:	d38080e7          	jalr	-712(ra) # 800017d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004aa8:	00813083          	ld	ra,8(sp)
    80004aac:	00013403          	ld	s0,0(sp)
    80004ab0:	01010113          	addi	sp,sp,16
    80004ab4:	00008067          	ret

0000000080004ab8 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80004ab8:	ff010113          	addi	sp,sp,-16
    80004abc:	00113423          	sd	ra,8(sp)
    80004ac0:	00813023          	sd	s0,0(sp)
    80004ac4:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80004ac8:	ffffd097          	auipc	ra,0xffffd
    80004acc:	0c8080e7          	jalr	200(ra) # 80001b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80004ad0:	00813083          	ld	ra,8(sp)
    80004ad4:	00013403          	ld	s0,0(sp)
    80004ad8:	01010113          	addi	sp,sp,16
    80004adc:	00008067          	ret

0000000080004ae0 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    80004ae0:	fe010113          	addi	sp,sp,-32
    80004ae4:	00113c23          	sd	ra,24(sp)
    80004ae8:	00813823          	sd	s0,16(sp)
    80004aec:	02010413          	addi	s0,sp,32
    80004af0:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80004af4:	fe840513          	addi	a0,s0,-24
    80004af8:	ffffd097          	auipc	ra,0xffffd
    80004afc:	1f8080e7          	jalr	504(ra) # 80001cf0 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    80004b00:	01813083          	ld	ra,24(sp)
    80004b04:	01013403          	ld	s0,16(sp)
    80004b08:	02010113          	addi	sp,sp,32
    80004b0c:	00008067          	ret

0000000080004b10 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80004b10:	ff010113          	addi	sp,sp,-16
    80004b14:	00113423          	sd	ra,8(sp)
    80004b18:	00813023          	sd	s0,0(sp)
    80004b1c:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80004b20:	ffffc097          	auipc	ra,0xffffc
    80004b24:	7dc080e7          	jalr	2012(ra) # 800012fc <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80004b28:	00813083          	ld	ra,8(sp)
    80004b2c:	00013403          	ld	s0,0(sp)
    80004b30:	01010113          	addi	sp,sp,16
    80004b34:	00008067          	ret

0000000080004b38 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80004b38:	ff010113          	addi	sp,sp,-16
    80004b3c:	00113423          	sd	ra,8(sp)
    80004b40:	00813023          	sd	s0,0(sp)
    80004b44:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80004b48:	ffffc097          	auipc	ra,0xffffc
    80004b4c:	5ec080e7          	jalr	1516(ra) # 80001134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80004b50:	00813083          	ld	ra,8(sp)
    80004b54:	00013403          	ld	s0,0(sp)
    80004b58:	01010113          	addi	sp,sp,16
    80004b5c:	00008067          	ret

0000000080004b60 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80004b60:	ff010113          	addi	sp,sp,-16
    80004b64:	00113423          	sd	ra,8(sp)
    80004b68:	00813023          	sd	s0,0(sp)
    80004b6c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80004b70:	ffffd097          	auipc	ra,0xffffd
    80004b74:	d04080e7          	jalr	-764(ra) # 80001874 <_ZN13SlabAllocator14allocateBufferEm>
}
    80004b78:	00813083          	ld	ra,8(sp)
    80004b7c:	00013403          	ld	s0,0(sp)
    80004b80:	01010113          	addi	sp,sp,16
    80004b84:	00008067          	ret

0000000080004b88 <_Z5kfreePKv>:

void kfree(const void* objp){
    80004b88:	ff010113          	addi	sp,sp,-16
    80004b8c:	00113423          	sd	ra,8(sp)
    80004b90:	00813023          	sd	s0,0(sp)
    80004b94:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80004b98:	ffffd097          	auipc	ra,0xffffd
    80004b9c:	0ec080e7          	jalr	236(ra) # 80001c84 <_ZN13SlabAllocator10freeBufferEPKv>
    80004ba0:	00813083          	ld	ra,8(sp)
    80004ba4:	00013403          	ld	s0,0(sp)
    80004ba8:	01010113          	addi	sp,sp,16
    80004bac:	00008067          	ret

0000000080004bb0 <start>:
    80004bb0:	ff010113          	addi	sp,sp,-16
    80004bb4:	00813423          	sd	s0,8(sp)
    80004bb8:	01010413          	addi	s0,sp,16
    80004bbc:	300027f3          	csrr	a5,mstatus
    80004bc0:	ffffe737          	lui	a4,0xffffe
    80004bc4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffea7ff>
    80004bc8:	00e7f7b3          	and	a5,a5,a4
    80004bcc:	00001737          	lui	a4,0x1
    80004bd0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004bd4:	00e7e7b3          	or	a5,a5,a4
    80004bd8:	30079073          	csrw	mstatus,a5
    80004bdc:	00000797          	auipc	a5,0x0
    80004be0:	16078793          	addi	a5,a5,352 # 80004d3c <system_main>
    80004be4:	34179073          	csrw	mepc,a5
    80004be8:	00000793          	li	a5,0
    80004bec:	18079073          	csrw	satp,a5
    80004bf0:	000107b7          	lui	a5,0x10
    80004bf4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004bf8:	30279073          	csrw	medeleg,a5
    80004bfc:	30379073          	csrw	mideleg,a5
    80004c00:	104027f3          	csrr	a5,sie
    80004c04:	2227e793          	ori	a5,a5,546
    80004c08:	10479073          	csrw	sie,a5
    80004c0c:	fff00793          	li	a5,-1
    80004c10:	00a7d793          	srli	a5,a5,0xa
    80004c14:	3b079073          	csrw	pmpaddr0,a5
    80004c18:	00f00793          	li	a5,15
    80004c1c:	3a079073          	csrw	pmpcfg0,a5
    80004c20:	f14027f3          	csrr	a5,mhartid
    80004c24:	0200c737          	lui	a4,0x200c
    80004c28:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004c2c:	0007869b          	sext.w	a3,a5
    80004c30:	00269713          	slli	a4,a3,0x2
    80004c34:	000f4637          	lui	a2,0xf4
    80004c38:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004c3c:	00d70733          	add	a4,a4,a3
    80004c40:	0037979b          	slliw	a5,a5,0x3
    80004c44:	020046b7          	lui	a3,0x2004
    80004c48:	00d787b3          	add	a5,a5,a3
    80004c4c:	00c585b3          	add	a1,a1,a2
    80004c50:	00371693          	slli	a3,a4,0x3
    80004c54:	00007717          	auipc	a4,0x7
    80004c58:	1dc70713          	addi	a4,a4,476 # 8000be30 <timer_scratch>
    80004c5c:	00b7b023          	sd	a1,0(a5)
    80004c60:	00d70733          	add	a4,a4,a3
    80004c64:	00f73c23          	sd	a5,24(a4)
    80004c68:	02c73023          	sd	a2,32(a4)
    80004c6c:	34071073          	csrw	mscratch,a4
    80004c70:	00000797          	auipc	a5,0x0
    80004c74:	6e078793          	addi	a5,a5,1760 # 80005350 <timervec>
    80004c78:	30579073          	csrw	mtvec,a5
    80004c7c:	300027f3          	csrr	a5,mstatus
    80004c80:	0087e793          	ori	a5,a5,8
    80004c84:	30079073          	csrw	mstatus,a5
    80004c88:	304027f3          	csrr	a5,mie
    80004c8c:	0807e793          	ori	a5,a5,128
    80004c90:	30479073          	csrw	mie,a5
    80004c94:	f14027f3          	csrr	a5,mhartid
    80004c98:	0007879b          	sext.w	a5,a5
    80004c9c:	00078213          	mv	tp,a5
    80004ca0:	30200073          	mret
    80004ca4:	00813403          	ld	s0,8(sp)
    80004ca8:	01010113          	addi	sp,sp,16
    80004cac:	00008067          	ret

0000000080004cb0 <timerinit>:
    80004cb0:	ff010113          	addi	sp,sp,-16
    80004cb4:	00813423          	sd	s0,8(sp)
    80004cb8:	01010413          	addi	s0,sp,16
    80004cbc:	f14027f3          	csrr	a5,mhartid
    80004cc0:	0200c737          	lui	a4,0x200c
    80004cc4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004cc8:	0007869b          	sext.w	a3,a5
    80004ccc:	00269713          	slli	a4,a3,0x2
    80004cd0:	000f4637          	lui	a2,0xf4
    80004cd4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004cd8:	00d70733          	add	a4,a4,a3
    80004cdc:	0037979b          	slliw	a5,a5,0x3
    80004ce0:	020046b7          	lui	a3,0x2004
    80004ce4:	00d787b3          	add	a5,a5,a3
    80004ce8:	00c585b3          	add	a1,a1,a2
    80004cec:	00371693          	slli	a3,a4,0x3
    80004cf0:	00007717          	auipc	a4,0x7
    80004cf4:	14070713          	addi	a4,a4,320 # 8000be30 <timer_scratch>
    80004cf8:	00b7b023          	sd	a1,0(a5)
    80004cfc:	00d70733          	add	a4,a4,a3
    80004d00:	00f73c23          	sd	a5,24(a4)
    80004d04:	02c73023          	sd	a2,32(a4)
    80004d08:	34071073          	csrw	mscratch,a4
    80004d0c:	00000797          	auipc	a5,0x0
    80004d10:	64478793          	addi	a5,a5,1604 # 80005350 <timervec>
    80004d14:	30579073          	csrw	mtvec,a5
    80004d18:	300027f3          	csrr	a5,mstatus
    80004d1c:	0087e793          	ori	a5,a5,8
    80004d20:	30079073          	csrw	mstatus,a5
    80004d24:	304027f3          	csrr	a5,mie
    80004d28:	0807e793          	ori	a5,a5,128
    80004d2c:	30479073          	csrw	mie,a5
    80004d30:	00813403          	ld	s0,8(sp)
    80004d34:	01010113          	addi	sp,sp,16
    80004d38:	00008067          	ret

0000000080004d3c <system_main>:
    80004d3c:	fe010113          	addi	sp,sp,-32
    80004d40:	00813823          	sd	s0,16(sp)
    80004d44:	00913423          	sd	s1,8(sp)
    80004d48:	00113c23          	sd	ra,24(sp)
    80004d4c:	02010413          	addi	s0,sp,32
    80004d50:	00000097          	auipc	ra,0x0
    80004d54:	0c4080e7          	jalr	196(ra) # 80004e14 <cpuid>
    80004d58:	00003497          	auipc	s1,0x3
    80004d5c:	e6848493          	addi	s1,s1,-408 # 80007bc0 <started>
    80004d60:	02050263          	beqz	a0,80004d84 <system_main+0x48>
    80004d64:	0004a783          	lw	a5,0(s1)
    80004d68:	0007879b          	sext.w	a5,a5
    80004d6c:	fe078ce3          	beqz	a5,80004d64 <system_main+0x28>
    80004d70:	0ff0000f          	fence
    80004d74:	00003517          	auipc	a0,0x3
    80004d78:	82450513          	addi	a0,a0,-2012 # 80007598 <CONSOLE_STATUS+0x588>
    80004d7c:	00001097          	auipc	ra,0x1
    80004d80:	a70080e7          	jalr	-1424(ra) # 800057ec <panic>
    80004d84:	00001097          	auipc	ra,0x1
    80004d88:	9c4080e7          	jalr	-1596(ra) # 80005748 <consoleinit>
    80004d8c:	00001097          	auipc	ra,0x1
    80004d90:	150080e7          	jalr	336(ra) # 80005edc <printfinit>
    80004d94:	00002517          	auipc	a0,0x2
    80004d98:	5bc50513          	addi	a0,a0,1468 # 80007350 <CONSOLE_STATUS+0x340>
    80004d9c:	00001097          	auipc	ra,0x1
    80004da0:	aac080e7          	jalr	-1364(ra) # 80005848 <__printf>
    80004da4:	00002517          	auipc	a0,0x2
    80004da8:	7c450513          	addi	a0,a0,1988 # 80007568 <CONSOLE_STATUS+0x558>
    80004dac:	00001097          	auipc	ra,0x1
    80004db0:	a9c080e7          	jalr	-1380(ra) # 80005848 <__printf>
    80004db4:	00002517          	auipc	a0,0x2
    80004db8:	59c50513          	addi	a0,a0,1436 # 80007350 <CONSOLE_STATUS+0x340>
    80004dbc:	00001097          	auipc	ra,0x1
    80004dc0:	a8c080e7          	jalr	-1396(ra) # 80005848 <__printf>
    80004dc4:	00001097          	auipc	ra,0x1
    80004dc8:	4a4080e7          	jalr	1188(ra) # 80006268 <kinit>
    80004dcc:	00000097          	auipc	ra,0x0
    80004dd0:	148080e7          	jalr	328(ra) # 80004f14 <trapinit>
    80004dd4:	00000097          	auipc	ra,0x0
    80004dd8:	16c080e7          	jalr	364(ra) # 80004f40 <trapinithart>
    80004ddc:	00000097          	auipc	ra,0x0
    80004de0:	5b4080e7          	jalr	1460(ra) # 80005390 <plicinit>
    80004de4:	00000097          	auipc	ra,0x0
    80004de8:	5d4080e7          	jalr	1492(ra) # 800053b8 <plicinithart>
    80004dec:	00000097          	auipc	ra,0x0
    80004df0:	078080e7          	jalr	120(ra) # 80004e64 <userinit>
    80004df4:	0ff0000f          	fence
    80004df8:	00100793          	li	a5,1
    80004dfc:	00002517          	auipc	a0,0x2
    80004e00:	78450513          	addi	a0,a0,1924 # 80007580 <CONSOLE_STATUS+0x570>
    80004e04:	00f4a023          	sw	a5,0(s1)
    80004e08:	00001097          	auipc	ra,0x1
    80004e0c:	a40080e7          	jalr	-1472(ra) # 80005848 <__printf>
    80004e10:	0000006f          	j	80004e10 <system_main+0xd4>

0000000080004e14 <cpuid>:
    80004e14:	ff010113          	addi	sp,sp,-16
    80004e18:	00813423          	sd	s0,8(sp)
    80004e1c:	01010413          	addi	s0,sp,16
    80004e20:	00020513          	mv	a0,tp
    80004e24:	00813403          	ld	s0,8(sp)
    80004e28:	0005051b          	sext.w	a0,a0
    80004e2c:	01010113          	addi	sp,sp,16
    80004e30:	00008067          	ret

0000000080004e34 <mycpu>:
    80004e34:	ff010113          	addi	sp,sp,-16
    80004e38:	00813423          	sd	s0,8(sp)
    80004e3c:	01010413          	addi	s0,sp,16
    80004e40:	00020793          	mv	a5,tp
    80004e44:	00813403          	ld	s0,8(sp)
    80004e48:	0007879b          	sext.w	a5,a5
    80004e4c:	00779793          	slli	a5,a5,0x7
    80004e50:	00008517          	auipc	a0,0x8
    80004e54:	01050513          	addi	a0,a0,16 # 8000ce60 <cpus>
    80004e58:	00f50533          	add	a0,a0,a5
    80004e5c:	01010113          	addi	sp,sp,16
    80004e60:	00008067          	ret

0000000080004e64 <userinit>:
    80004e64:	ff010113          	addi	sp,sp,-16
    80004e68:	00813423          	sd	s0,8(sp)
    80004e6c:	01010413          	addi	s0,sp,16
    80004e70:	00813403          	ld	s0,8(sp)
    80004e74:	01010113          	addi	sp,sp,16
    80004e78:	ffffe317          	auipc	t1,0xffffe
    80004e7c:	8c030067          	jr	-1856(t1) # 80002738 <main>

0000000080004e80 <either_copyout>:
    80004e80:	ff010113          	addi	sp,sp,-16
    80004e84:	00813023          	sd	s0,0(sp)
    80004e88:	00113423          	sd	ra,8(sp)
    80004e8c:	01010413          	addi	s0,sp,16
    80004e90:	02051663          	bnez	a0,80004ebc <either_copyout+0x3c>
    80004e94:	00058513          	mv	a0,a1
    80004e98:	00060593          	mv	a1,a2
    80004e9c:	0006861b          	sext.w	a2,a3
    80004ea0:	00002097          	auipc	ra,0x2
    80004ea4:	c54080e7          	jalr	-940(ra) # 80006af4 <__memmove>
    80004ea8:	00813083          	ld	ra,8(sp)
    80004eac:	00013403          	ld	s0,0(sp)
    80004eb0:	00000513          	li	a0,0
    80004eb4:	01010113          	addi	sp,sp,16
    80004eb8:	00008067          	ret
    80004ebc:	00002517          	auipc	a0,0x2
    80004ec0:	70450513          	addi	a0,a0,1796 # 800075c0 <CONSOLE_STATUS+0x5b0>
    80004ec4:	00001097          	auipc	ra,0x1
    80004ec8:	928080e7          	jalr	-1752(ra) # 800057ec <panic>

0000000080004ecc <either_copyin>:
    80004ecc:	ff010113          	addi	sp,sp,-16
    80004ed0:	00813023          	sd	s0,0(sp)
    80004ed4:	00113423          	sd	ra,8(sp)
    80004ed8:	01010413          	addi	s0,sp,16
    80004edc:	02059463          	bnez	a1,80004f04 <either_copyin+0x38>
    80004ee0:	00060593          	mv	a1,a2
    80004ee4:	0006861b          	sext.w	a2,a3
    80004ee8:	00002097          	auipc	ra,0x2
    80004eec:	c0c080e7          	jalr	-1012(ra) # 80006af4 <__memmove>
    80004ef0:	00813083          	ld	ra,8(sp)
    80004ef4:	00013403          	ld	s0,0(sp)
    80004ef8:	00000513          	li	a0,0
    80004efc:	01010113          	addi	sp,sp,16
    80004f00:	00008067          	ret
    80004f04:	00002517          	auipc	a0,0x2
    80004f08:	6e450513          	addi	a0,a0,1764 # 800075e8 <CONSOLE_STATUS+0x5d8>
    80004f0c:	00001097          	auipc	ra,0x1
    80004f10:	8e0080e7          	jalr	-1824(ra) # 800057ec <panic>

0000000080004f14 <trapinit>:
    80004f14:	ff010113          	addi	sp,sp,-16
    80004f18:	00813423          	sd	s0,8(sp)
    80004f1c:	01010413          	addi	s0,sp,16
    80004f20:	00813403          	ld	s0,8(sp)
    80004f24:	00002597          	auipc	a1,0x2
    80004f28:	6ec58593          	addi	a1,a1,1772 # 80007610 <CONSOLE_STATUS+0x600>
    80004f2c:	00008517          	auipc	a0,0x8
    80004f30:	fb450513          	addi	a0,a0,-76 # 8000cee0 <tickslock>
    80004f34:	01010113          	addi	sp,sp,16
    80004f38:	00001317          	auipc	t1,0x1
    80004f3c:	5c030067          	jr	1472(t1) # 800064f8 <initlock>

0000000080004f40 <trapinithart>:
    80004f40:	ff010113          	addi	sp,sp,-16
    80004f44:	00813423          	sd	s0,8(sp)
    80004f48:	01010413          	addi	s0,sp,16
    80004f4c:	00000797          	auipc	a5,0x0
    80004f50:	2f478793          	addi	a5,a5,756 # 80005240 <kernelvec>
    80004f54:	10579073          	csrw	stvec,a5
    80004f58:	00813403          	ld	s0,8(sp)
    80004f5c:	01010113          	addi	sp,sp,16
    80004f60:	00008067          	ret

0000000080004f64 <usertrap>:
    80004f64:	ff010113          	addi	sp,sp,-16
    80004f68:	00813423          	sd	s0,8(sp)
    80004f6c:	01010413          	addi	s0,sp,16
    80004f70:	00813403          	ld	s0,8(sp)
    80004f74:	01010113          	addi	sp,sp,16
    80004f78:	00008067          	ret

0000000080004f7c <usertrapret>:
    80004f7c:	ff010113          	addi	sp,sp,-16
    80004f80:	00813423          	sd	s0,8(sp)
    80004f84:	01010413          	addi	s0,sp,16
    80004f88:	00813403          	ld	s0,8(sp)
    80004f8c:	01010113          	addi	sp,sp,16
    80004f90:	00008067          	ret

0000000080004f94 <kerneltrap>:
    80004f94:	fe010113          	addi	sp,sp,-32
    80004f98:	00813823          	sd	s0,16(sp)
    80004f9c:	00113c23          	sd	ra,24(sp)
    80004fa0:	00913423          	sd	s1,8(sp)
    80004fa4:	02010413          	addi	s0,sp,32
    80004fa8:	142025f3          	csrr	a1,scause
    80004fac:	100027f3          	csrr	a5,sstatus
    80004fb0:	0027f793          	andi	a5,a5,2
    80004fb4:	10079c63          	bnez	a5,800050cc <kerneltrap+0x138>
    80004fb8:	142027f3          	csrr	a5,scause
    80004fbc:	0207ce63          	bltz	a5,80004ff8 <kerneltrap+0x64>
    80004fc0:	00002517          	auipc	a0,0x2
    80004fc4:	69850513          	addi	a0,a0,1688 # 80007658 <CONSOLE_STATUS+0x648>
    80004fc8:	00001097          	auipc	ra,0x1
    80004fcc:	880080e7          	jalr	-1920(ra) # 80005848 <__printf>
    80004fd0:	141025f3          	csrr	a1,sepc
    80004fd4:	14302673          	csrr	a2,stval
    80004fd8:	00002517          	auipc	a0,0x2
    80004fdc:	69050513          	addi	a0,a0,1680 # 80007668 <CONSOLE_STATUS+0x658>
    80004fe0:	00001097          	auipc	ra,0x1
    80004fe4:	868080e7          	jalr	-1944(ra) # 80005848 <__printf>
    80004fe8:	00002517          	auipc	a0,0x2
    80004fec:	69850513          	addi	a0,a0,1688 # 80007680 <CONSOLE_STATUS+0x670>
    80004ff0:	00000097          	auipc	ra,0x0
    80004ff4:	7fc080e7          	jalr	2044(ra) # 800057ec <panic>
    80004ff8:	0ff7f713          	andi	a4,a5,255
    80004ffc:	00900693          	li	a3,9
    80005000:	04d70063          	beq	a4,a3,80005040 <kerneltrap+0xac>
    80005004:	fff00713          	li	a4,-1
    80005008:	03f71713          	slli	a4,a4,0x3f
    8000500c:	00170713          	addi	a4,a4,1
    80005010:	fae798e3          	bne	a5,a4,80004fc0 <kerneltrap+0x2c>
    80005014:	00000097          	auipc	ra,0x0
    80005018:	e00080e7          	jalr	-512(ra) # 80004e14 <cpuid>
    8000501c:	06050663          	beqz	a0,80005088 <kerneltrap+0xf4>
    80005020:	144027f3          	csrr	a5,sip
    80005024:	ffd7f793          	andi	a5,a5,-3
    80005028:	14479073          	csrw	sip,a5
    8000502c:	01813083          	ld	ra,24(sp)
    80005030:	01013403          	ld	s0,16(sp)
    80005034:	00813483          	ld	s1,8(sp)
    80005038:	02010113          	addi	sp,sp,32
    8000503c:	00008067          	ret
    80005040:	00000097          	auipc	ra,0x0
    80005044:	3c4080e7          	jalr	964(ra) # 80005404 <plic_claim>
    80005048:	00a00793          	li	a5,10
    8000504c:	00050493          	mv	s1,a0
    80005050:	06f50863          	beq	a0,a5,800050c0 <kerneltrap+0x12c>
    80005054:	fc050ce3          	beqz	a0,8000502c <kerneltrap+0x98>
    80005058:	00050593          	mv	a1,a0
    8000505c:	00002517          	auipc	a0,0x2
    80005060:	5dc50513          	addi	a0,a0,1500 # 80007638 <CONSOLE_STATUS+0x628>
    80005064:	00000097          	auipc	ra,0x0
    80005068:	7e4080e7          	jalr	2020(ra) # 80005848 <__printf>
    8000506c:	01013403          	ld	s0,16(sp)
    80005070:	01813083          	ld	ra,24(sp)
    80005074:	00048513          	mv	a0,s1
    80005078:	00813483          	ld	s1,8(sp)
    8000507c:	02010113          	addi	sp,sp,32
    80005080:	00000317          	auipc	t1,0x0
    80005084:	3bc30067          	jr	956(t1) # 8000543c <plic_complete>
    80005088:	00008517          	auipc	a0,0x8
    8000508c:	e5850513          	addi	a0,a0,-424 # 8000cee0 <tickslock>
    80005090:	00001097          	auipc	ra,0x1
    80005094:	48c080e7          	jalr	1164(ra) # 8000651c <acquire>
    80005098:	00003717          	auipc	a4,0x3
    8000509c:	b2c70713          	addi	a4,a4,-1236 # 80007bc4 <ticks>
    800050a0:	00072783          	lw	a5,0(a4)
    800050a4:	00008517          	auipc	a0,0x8
    800050a8:	e3c50513          	addi	a0,a0,-452 # 8000cee0 <tickslock>
    800050ac:	0017879b          	addiw	a5,a5,1
    800050b0:	00f72023          	sw	a5,0(a4)
    800050b4:	00001097          	auipc	ra,0x1
    800050b8:	534080e7          	jalr	1332(ra) # 800065e8 <release>
    800050bc:	f65ff06f          	j	80005020 <kerneltrap+0x8c>
    800050c0:	00001097          	auipc	ra,0x1
    800050c4:	090080e7          	jalr	144(ra) # 80006150 <uartintr>
    800050c8:	fa5ff06f          	j	8000506c <kerneltrap+0xd8>
    800050cc:	00002517          	auipc	a0,0x2
    800050d0:	54c50513          	addi	a0,a0,1356 # 80007618 <CONSOLE_STATUS+0x608>
    800050d4:	00000097          	auipc	ra,0x0
    800050d8:	718080e7          	jalr	1816(ra) # 800057ec <panic>

00000000800050dc <clockintr>:
    800050dc:	fe010113          	addi	sp,sp,-32
    800050e0:	00813823          	sd	s0,16(sp)
    800050e4:	00913423          	sd	s1,8(sp)
    800050e8:	00113c23          	sd	ra,24(sp)
    800050ec:	02010413          	addi	s0,sp,32
    800050f0:	00008497          	auipc	s1,0x8
    800050f4:	df048493          	addi	s1,s1,-528 # 8000cee0 <tickslock>
    800050f8:	00048513          	mv	a0,s1
    800050fc:	00001097          	auipc	ra,0x1
    80005100:	420080e7          	jalr	1056(ra) # 8000651c <acquire>
    80005104:	00003717          	auipc	a4,0x3
    80005108:	ac070713          	addi	a4,a4,-1344 # 80007bc4 <ticks>
    8000510c:	00072783          	lw	a5,0(a4)
    80005110:	01013403          	ld	s0,16(sp)
    80005114:	01813083          	ld	ra,24(sp)
    80005118:	00048513          	mv	a0,s1
    8000511c:	0017879b          	addiw	a5,a5,1
    80005120:	00813483          	ld	s1,8(sp)
    80005124:	00f72023          	sw	a5,0(a4)
    80005128:	02010113          	addi	sp,sp,32
    8000512c:	00001317          	auipc	t1,0x1
    80005130:	4bc30067          	jr	1212(t1) # 800065e8 <release>

0000000080005134 <devintr>:
    80005134:	142027f3          	csrr	a5,scause
    80005138:	00000513          	li	a0,0
    8000513c:	0007c463          	bltz	a5,80005144 <devintr+0x10>
    80005140:	00008067          	ret
    80005144:	fe010113          	addi	sp,sp,-32
    80005148:	00813823          	sd	s0,16(sp)
    8000514c:	00113c23          	sd	ra,24(sp)
    80005150:	00913423          	sd	s1,8(sp)
    80005154:	02010413          	addi	s0,sp,32
    80005158:	0ff7f713          	andi	a4,a5,255
    8000515c:	00900693          	li	a3,9
    80005160:	04d70c63          	beq	a4,a3,800051b8 <devintr+0x84>
    80005164:	fff00713          	li	a4,-1
    80005168:	03f71713          	slli	a4,a4,0x3f
    8000516c:	00170713          	addi	a4,a4,1
    80005170:	00e78c63          	beq	a5,a4,80005188 <devintr+0x54>
    80005174:	01813083          	ld	ra,24(sp)
    80005178:	01013403          	ld	s0,16(sp)
    8000517c:	00813483          	ld	s1,8(sp)
    80005180:	02010113          	addi	sp,sp,32
    80005184:	00008067          	ret
    80005188:	00000097          	auipc	ra,0x0
    8000518c:	c8c080e7          	jalr	-884(ra) # 80004e14 <cpuid>
    80005190:	06050663          	beqz	a0,800051fc <devintr+0xc8>
    80005194:	144027f3          	csrr	a5,sip
    80005198:	ffd7f793          	andi	a5,a5,-3
    8000519c:	14479073          	csrw	sip,a5
    800051a0:	01813083          	ld	ra,24(sp)
    800051a4:	01013403          	ld	s0,16(sp)
    800051a8:	00813483          	ld	s1,8(sp)
    800051ac:	00200513          	li	a0,2
    800051b0:	02010113          	addi	sp,sp,32
    800051b4:	00008067          	ret
    800051b8:	00000097          	auipc	ra,0x0
    800051bc:	24c080e7          	jalr	588(ra) # 80005404 <plic_claim>
    800051c0:	00a00793          	li	a5,10
    800051c4:	00050493          	mv	s1,a0
    800051c8:	06f50663          	beq	a0,a5,80005234 <devintr+0x100>
    800051cc:	00100513          	li	a0,1
    800051d0:	fa0482e3          	beqz	s1,80005174 <devintr+0x40>
    800051d4:	00048593          	mv	a1,s1
    800051d8:	00002517          	auipc	a0,0x2
    800051dc:	46050513          	addi	a0,a0,1120 # 80007638 <CONSOLE_STATUS+0x628>
    800051e0:	00000097          	auipc	ra,0x0
    800051e4:	668080e7          	jalr	1640(ra) # 80005848 <__printf>
    800051e8:	00048513          	mv	a0,s1
    800051ec:	00000097          	auipc	ra,0x0
    800051f0:	250080e7          	jalr	592(ra) # 8000543c <plic_complete>
    800051f4:	00100513          	li	a0,1
    800051f8:	f7dff06f          	j	80005174 <devintr+0x40>
    800051fc:	00008517          	auipc	a0,0x8
    80005200:	ce450513          	addi	a0,a0,-796 # 8000cee0 <tickslock>
    80005204:	00001097          	auipc	ra,0x1
    80005208:	318080e7          	jalr	792(ra) # 8000651c <acquire>
    8000520c:	00003717          	auipc	a4,0x3
    80005210:	9b870713          	addi	a4,a4,-1608 # 80007bc4 <ticks>
    80005214:	00072783          	lw	a5,0(a4)
    80005218:	00008517          	auipc	a0,0x8
    8000521c:	cc850513          	addi	a0,a0,-824 # 8000cee0 <tickslock>
    80005220:	0017879b          	addiw	a5,a5,1
    80005224:	00f72023          	sw	a5,0(a4)
    80005228:	00001097          	auipc	ra,0x1
    8000522c:	3c0080e7          	jalr	960(ra) # 800065e8 <release>
    80005230:	f65ff06f          	j	80005194 <devintr+0x60>
    80005234:	00001097          	auipc	ra,0x1
    80005238:	f1c080e7          	jalr	-228(ra) # 80006150 <uartintr>
    8000523c:	fadff06f          	j	800051e8 <devintr+0xb4>

0000000080005240 <kernelvec>:
    80005240:	f0010113          	addi	sp,sp,-256
    80005244:	00113023          	sd	ra,0(sp)
    80005248:	00213423          	sd	sp,8(sp)
    8000524c:	00313823          	sd	gp,16(sp)
    80005250:	00413c23          	sd	tp,24(sp)
    80005254:	02513023          	sd	t0,32(sp)
    80005258:	02613423          	sd	t1,40(sp)
    8000525c:	02713823          	sd	t2,48(sp)
    80005260:	02813c23          	sd	s0,56(sp)
    80005264:	04913023          	sd	s1,64(sp)
    80005268:	04a13423          	sd	a0,72(sp)
    8000526c:	04b13823          	sd	a1,80(sp)
    80005270:	04c13c23          	sd	a2,88(sp)
    80005274:	06d13023          	sd	a3,96(sp)
    80005278:	06e13423          	sd	a4,104(sp)
    8000527c:	06f13823          	sd	a5,112(sp)
    80005280:	07013c23          	sd	a6,120(sp)
    80005284:	09113023          	sd	a7,128(sp)
    80005288:	09213423          	sd	s2,136(sp)
    8000528c:	09313823          	sd	s3,144(sp)
    80005290:	09413c23          	sd	s4,152(sp)
    80005294:	0b513023          	sd	s5,160(sp)
    80005298:	0b613423          	sd	s6,168(sp)
    8000529c:	0b713823          	sd	s7,176(sp)
    800052a0:	0b813c23          	sd	s8,184(sp)
    800052a4:	0d913023          	sd	s9,192(sp)
    800052a8:	0da13423          	sd	s10,200(sp)
    800052ac:	0db13823          	sd	s11,208(sp)
    800052b0:	0dc13c23          	sd	t3,216(sp)
    800052b4:	0fd13023          	sd	t4,224(sp)
    800052b8:	0fe13423          	sd	t5,232(sp)
    800052bc:	0ff13823          	sd	t6,240(sp)
    800052c0:	cd5ff0ef          	jal	ra,80004f94 <kerneltrap>
    800052c4:	00013083          	ld	ra,0(sp)
    800052c8:	00813103          	ld	sp,8(sp)
    800052cc:	01013183          	ld	gp,16(sp)
    800052d0:	02013283          	ld	t0,32(sp)
    800052d4:	02813303          	ld	t1,40(sp)
    800052d8:	03013383          	ld	t2,48(sp)
    800052dc:	03813403          	ld	s0,56(sp)
    800052e0:	04013483          	ld	s1,64(sp)
    800052e4:	04813503          	ld	a0,72(sp)
    800052e8:	05013583          	ld	a1,80(sp)
    800052ec:	05813603          	ld	a2,88(sp)
    800052f0:	06013683          	ld	a3,96(sp)
    800052f4:	06813703          	ld	a4,104(sp)
    800052f8:	07013783          	ld	a5,112(sp)
    800052fc:	07813803          	ld	a6,120(sp)
    80005300:	08013883          	ld	a7,128(sp)
    80005304:	08813903          	ld	s2,136(sp)
    80005308:	09013983          	ld	s3,144(sp)
    8000530c:	09813a03          	ld	s4,152(sp)
    80005310:	0a013a83          	ld	s5,160(sp)
    80005314:	0a813b03          	ld	s6,168(sp)
    80005318:	0b013b83          	ld	s7,176(sp)
    8000531c:	0b813c03          	ld	s8,184(sp)
    80005320:	0c013c83          	ld	s9,192(sp)
    80005324:	0c813d03          	ld	s10,200(sp)
    80005328:	0d013d83          	ld	s11,208(sp)
    8000532c:	0d813e03          	ld	t3,216(sp)
    80005330:	0e013e83          	ld	t4,224(sp)
    80005334:	0e813f03          	ld	t5,232(sp)
    80005338:	0f013f83          	ld	t6,240(sp)
    8000533c:	10010113          	addi	sp,sp,256
    80005340:	10200073          	sret
    80005344:	00000013          	nop
    80005348:	00000013          	nop
    8000534c:	00000013          	nop

0000000080005350 <timervec>:
    80005350:	34051573          	csrrw	a0,mscratch,a0
    80005354:	00b53023          	sd	a1,0(a0)
    80005358:	00c53423          	sd	a2,8(a0)
    8000535c:	00d53823          	sd	a3,16(a0)
    80005360:	01853583          	ld	a1,24(a0)
    80005364:	02053603          	ld	a2,32(a0)
    80005368:	0005b683          	ld	a3,0(a1)
    8000536c:	00c686b3          	add	a3,a3,a2
    80005370:	00d5b023          	sd	a3,0(a1)
    80005374:	00200593          	li	a1,2
    80005378:	14459073          	csrw	sip,a1
    8000537c:	01053683          	ld	a3,16(a0)
    80005380:	00853603          	ld	a2,8(a0)
    80005384:	00053583          	ld	a1,0(a0)
    80005388:	34051573          	csrrw	a0,mscratch,a0
    8000538c:	30200073          	mret

0000000080005390 <plicinit>:
    80005390:	ff010113          	addi	sp,sp,-16
    80005394:	00813423          	sd	s0,8(sp)
    80005398:	01010413          	addi	s0,sp,16
    8000539c:	00813403          	ld	s0,8(sp)
    800053a0:	0c0007b7          	lui	a5,0xc000
    800053a4:	00100713          	li	a4,1
    800053a8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800053ac:	00e7a223          	sw	a4,4(a5)
    800053b0:	01010113          	addi	sp,sp,16
    800053b4:	00008067          	ret

00000000800053b8 <plicinithart>:
    800053b8:	ff010113          	addi	sp,sp,-16
    800053bc:	00813023          	sd	s0,0(sp)
    800053c0:	00113423          	sd	ra,8(sp)
    800053c4:	01010413          	addi	s0,sp,16
    800053c8:	00000097          	auipc	ra,0x0
    800053cc:	a4c080e7          	jalr	-1460(ra) # 80004e14 <cpuid>
    800053d0:	0085171b          	slliw	a4,a0,0x8
    800053d4:	0c0027b7          	lui	a5,0xc002
    800053d8:	00e787b3          	add	a5,a5,a4
    800053dc:	40200713          	li	a4,1026
    800053e0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800053e4:	00813083          	ld	ra,8(sp)
    800053e8:	00013403          	ld	s0,0(sp)
    800053ec:	00d5151b          	slliw	a0,a0,0xd
    800053f0:	0c2017b7          	lui	a5,0xc201
    800053f4:	00a78533          	add	a0,a5,a0
    800053f8:	00052023          	sw	zero,0(a0)
    800053fc:	01010113          	addi	sp,sp,16
    80005400:	00008067          	ret

0000000080005404 <plic_claim>:
    80005404:	ff010113          	addi	sp,sp,-16
    80005408:	00813023          	sd	s0,0(sp)
    8000540c:	00113423          	sd	ra,8(sp)
    80005410:	01010413          	addi	s0,sp,16
    80005414:	00000097          	auipc	ra,0x0
    80005418:	a00080e7          	jalr	-1536(ra) # 80004e14 <cpuid>
    8000541c:	00813083          	ld	ra,8(sp)
    80005420:	00013403          	ld	s0,0(sp)
    80005424:	00d5151b          	slliw	a0,a0,0xd
    80005428:	0c2017b7          	lui	a5,0xc201
    8000542c:	00a78533          	add	a0,a5,a0
    80005430:	00452503          	lw	a0,4(a0)
    80005434:	01010113          	addi	sp,sp,16
    80005438:	00008067          	ret

000000008000543c <plic_complete>:
    8000543c:	fe010113          	addi	sp,sp,-32
    80005440:	00813823          	sd	s0,16(sp)
    80005444:	00913423          	sd	s1,8(sp)
    80005448:	00113c23          	sd	ra,24(sp)
    8000544c:	02010413          	addi	s0,sp,32
    80005450:	00050493          	mv	s1,a0
    80005454:	00000097          	auipc	ra,0x0
    80005458:	9c0080e7          	jalr	-1600(ra) # 80004e14 <cpuid>
    8000545c:	01813083          	ld	ra,24(sp)
    80005460:	01013403          	ld	s0,16(sp)
    80005464:	00d5179b          	slliw	a5,a0,0xd
    80005468:	0c201737          	lui	a4,0xc201
    8000546c:	00f707b3          	add	a5,a4,a5
    80005470:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005474:	00813483          	ld	s1,8(sp)
    80005478:	02010113          	addi	sp,sp,32
    8000547c:	00008067          	ret

0000000080005480 <consolewrite>:
    80005480:	fb010113          	addi	sp,sp,-80
    80005484:	04813023          	sd	s0,64(sp)
    80005488:	04113423          	sd	ra,72(sp)
    8000548c:	02913c23          	sd	s1,56(sp)
    80005490:	03213823          	sd	s2,48(sp)
    80005494:	03313423          	sd	s3,40(sp)
    80005498:	03413023          	sd	s4,32(sp)
    8000549c:	01513c23          	sd	s5,24(sp)
    800054a0:	05010413          	addi	s0,sp,80
    800054a4:	06c05c63          	blez	a2,8000551c <consolewrite+0x9c>
    800054a8:	00060993          	mv	s3,a2
    800054ac:	00050a13          	mv	s4,a0
    800054b0:	00058493          	mv	s1,a1
    800054b4:	00000913          	li	s2,0
    800054b8:	fff00a93          	li	s5,-1
    800054bc:	01c0006f          	j	800054d8 <consolewrite+0x58>
    800054c0:	fbf44503          	lbu	a0,-65(s0)
    800054c4:	0019091b          	addiw	s2,s2,1
    800054c8:	00148493          	addi	s1,s1,1
    800054cc:	00001097          	auipc	ra,0x1
    800054d0:	a9c080e7          	jalr	-1380(ra) # 80005f68 <uartputc>
    800054d4:	03298063          	beq	s3,s2,800054f4 <consolewrite+0x74>
    800054d8:	00048613          	mv	a2,s1
    800054dc:	00100693          	li	a3,1
    800054e0:	000a0593          	mv	a1,s4
    800054e4:	fbf40513          	addi	a0,s0,-65
    800054e8:	00000097          	auipc	ra,0x0
    800054ec:	9e4080e7          	jalr	-1564(ra) # 80004ecc <either_copyin>
    800054f0:	fd5518e3          	bne	a0,s5,800054c0 <consolewrite+0x40>
    800054f4:	04813083          	ld	ra,72(sp)
    800054f8:	04013403          	ld	s0,64(sp)
    800054fc:	03813483          	ld	s1,56(sp)
    80005500:	02813983          	ld	s3,40(sp)
    80005504:	02013a03          	ld	s4,32(sp)
    80005508:	01813a83          	ld	s5,24(sp)
    8000550c:	00090513          	mv	a0,s2
    80005510:	03013903          	ld	s2,48(sp)
    80005514:	05010113          	addi	sp,sp,80
    80005518:	00008067          	ret
    8000551c:	00000913          	li	s2,0
    80005520:	fd5ff06f          	j	800054f4 <consolewrite+0x74>

0000000080005524 <consoleread>:
    80005524:	f9010113          	addi	sp,sp,-112
    80005528:	06813023          	sd	s0,96(sp)
    8000552c:	04913c23          	sd	s1,88(sp)
    80005530:	05213823          	sd	s2,80(sp)
    80005534:	05313423          	sd	s3,72(sp)
    80005538:	05413023          	sd	s4,64(sp)
    8000553c:	03513c23          	sd	s5,56(sp)
    80005540:	03613823          	sd	s6,48(sp)
    80005544:	03713423          	sd	s7,40(sp)
    80005548:	03813023          	sd	s8,32(sp)
    8000554c:	06113423          	sd	ra,104(sp)
    80005550:	01913c23          	sd	s9,24(sp)
    80005554:	07010413          	addi	s0,sp,112
    80005558:	00060b93          	mv	s7,a2
    8000555c:	00050913          	mv	s2,a0
    80005560:	00058c13          	mv	s8,a1
    80005564:	00060b1b          	sext.w	s6,a2
    80005568:	00008497          	auipc	s1,0x8
    8000556c:	9a048493          	addi	s1,s1,-1632 # 8000cf08 <cons>
    80005570:	00400993          	li	s3,4
    80005574:	fff00a13          	li	s4,-1
    80005578:	00a00a93          	li	s5,10
    8000557c:	05705e63          	blez	s7,800055d8 <consoleread+0xb4>
    80005580:	09c4a703          	lw	a4,156(s1)
    80005584:	0984a783          	lw	a5,152(s1)
    80005588:	0007071b          	sext.w	a4,a4
    8000558c:	08e78463          	beq	a5,a4,80005614 <consoleread+0xf0>
    80005590:	07f7f713          	andi	a4,a5,127
    80005594:	00e48733          	add	a4,s1,a4
    80005598:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000559c:	0017869b          	addiw	a3,a5,1
    800055a0:	08d4ac23          	sw	a3,152(s1)
    800055a4:	00070c9b          	sext.w	s9,a4
    800055a8:	0b370663          	beq	a4,s3,80005654 <consoleread+0x130>
    800055ac:	00100693          	li	a3,1
    800055b0:	f9f40613          	addi	a2,s0,-97
    800055b4:	000c0593          	mv	a1,s8
    800055b8:	00090513          	mv	a0,s2
    800055bc:	f8e40fa3          	sb	a4,-97(s0)
    800055c0:	00000097          	auipc	ra,0x0
    800055c4:	8c0080e7          	jalr	-1856(ra) # 80004e80 <either_copyout>
    800055c8:	01450863          	beq	a0,s4,800055d8 <consoleread+0xb4>
    800055cc:	001c0c13          	addi	s8,s8,1
    800055d0:	fffb8b9b          	addiw	s7,s7,-1
    800055d4:	fb5c94e3          	bne	s9,s5,8000557c <consoleread+0x58>
    800055d8:	000b851b          	sext.w	a0,s7
    800055dc:	06813083          	ld	ra,104(sp)
    800055e0:	06013403          	ld	s0,96(sp)
    800055e4:	05813483          	ld	s1,88(sp)
    800055e8:	05013903          	ld	s2,80(sp)
    800055ec:	04813983          	ld	s3,72(sp)
    800055f0:	04013a03          	ld	s4,64(sp)
    800055f4:	03813a83          	ld	s5,56(sp)
    800055f8:	02813b83          	ld	s7,40(sp)
    800055fc:	02013c03          	ld	s8,32(sp)
    80005600:	01813c83          	ld	s9,24(sp)
    80005604:	40ab053b          	subw	a0,s6,a0
    80005608:	03013b03          	ld	s6,48(sp)
    8000560c:	07010113          	addi	sp,sp,112
    80005610:	00008067          	ret
    80005614:	00001097          	auipc	ra,0x1
    80005618:	1d8080e7          	jalr	472(ra) # 800067ec <push_on>
    8000561c:	0984a703          	lw	a4,152(s1)
    80005620:	09c4a783          	lw	a5,156(s1)
    80005624:	0007879b          	sext.w	a5,a5
    80005628:	fef70ce3          	beq	a4,a5,80005620 <consoleread+0xfc>
    8000562c:	00001097          	auipc	ra,0x1
    80005630:	234080e7          	jalr	564(ra) # 80006860 <pop_on>
    80005634:	0984a783          	lw	a5,152(s1)
    80005638:	07f7f713          	andi	a4,a5,127
    8000563c:	00e48733          	add	a4,s1,a4
    80005640:	01874703          	lbu	a4,24(a4)
    80005644:	0017869b          	addiw	a3,a5,1
    80005648:	08d4ac23          	sw	a3,152(s1)
    8000564c:	00070c9b          	sext.w	s9,a4
    80005650:	f5371ee3          	bne	a4,s3,800055ac <consoleread+0x88>
    80005654:	000b851b          	sext.w	a0,s7
    80005658:	f96bf2e3          	bgeu	s7,s6,800055dc <consoleread+0xb8>
    8000565c:	08f4ac23          	sw	a5,152(s1)
    80005660:	f7dff06f          	j	800055dc <consoleread+0xb8>

0000000080005664 <consputc>:
    80005664:	10000793          	li	a5,256
    80005668:	00f50663          	beq	a0,a5,80005674 <consputc+0x10>
    8000566c:	00001317          	auipc	t1,0x1
    80005670:	9f430067          	jr	-1548(t1) # 80006060 <uartputc_sync>
    80005674:	ff010113          	addi	sp,sp,-16
    80005678:	00113423          	sd	ra,8(sp)
    8000567c:	00813023          	sd	s0,0(sp)
    80005680:	01010413          	addi	s0,sp,16
    80005684:	00800513          	li	a0,8
    80005688:	00001097          	auipc	ra,0x1
    8000568c:	9d8080e7          	jalr	-1576(ra) # 80006060 <uartputc_sync>
    80005690:	02000513          	li	a0,32
    80005694:	00001097          	auipc	ra,0x1
    80005698:	9cc080e7          	jalr	-1588(ra) # 80006060 <uartputc_sync>
    8000569c:	00013403          	ld	s0,0(sp)
    800056a0:	00813083          	ld	ra,8(sp)
    800056a4:	00800513          	li	a0,8
    800056a8:	01010113          	addi	sp,sp,16
    800056ac:	00001317          	auipc	t1,0x1
    800056b0:	9b430067          	jr	-1612(t1) # 80006060 <uartputc_sync>

00000000800056b4 <consoleintr>:
    800056b4:	fe010113          	addi	sp,sp,-32
    800056b8:	00813823          	sd	s0,16(sp)
    800056bc:	00913423          	sd	s1,8(sp)
    800056c0:	01213023          	sd	s2,0(sp)
    800056c4:	00113c23          	sd	ra,24(sp)
    800056c8:	02010413          	addi	s0,sp,32
    800056cc:	00008917          	auipc	s2,0x8
    800056d0:	83c90913          	addi	s2,s2,-1988 # 8000cf08 <cons>
    800056d4:	00050493          	mv	s1,a0
    800056d8:	00090513          	mv	a0,s2
    800056dc:	00001097          	auipc	ra,0x1
    800056e0:	e40080e7          	jalr	-448(ra) # 8000651c <acquire>
    800056e4:	02048c63          	beqz	s1,8000571c <consoleintr+0x68>
    800056e8:	0a092783          	lw	a5,160(s2)
    800056ec:	09892703          	lw	a4,152(s2)
    800056f0:	07f00693          	li	a3,127
    800056f4:	40e7873b          	subw	a4,a5,a4
    800056f8:	02e6e263          	bltu	a3,a4,8000571c <consoleintr+0x68>
    800056fc:	00d00713          	li	a4,13
    80005700:	04e48063          	beq	s1,a4,80005740 <consoleintr+0x8c>
    80005704:	07f7f713          	andi	a4,a5,127
    80005708:	00e90733          	add	a4,s2,a4
    8000570c:	0017879b          	addiw	a5,a5,1
    80005710:	0af92023          	sw	a5,160(s2)
    80005714:	00970c23          	sb	s1,24(a4)
    80005718:	08f92e23          	sw	a5,156(s2)
    8000571c:	01013403          	ld	s0,16(sp)
    80005720:	01813083          	ld	ra,24(sp)
    80005724:	00813483          	ld	s1,8(sp)
    80005728:	00013903          	ld	s2,0(sp)
    8000572c:	00007517          	auipc	a0,0x7
    80005730:	7dc50513          	addi	a0,a0,2012 # 8000cf08 <cons>
    80005734:	02010113          	addi	sp,sp,32
    80005738:	00001317          	auipc	t1,0x1
    8000573c:	eb030067          	jr	-336(t1) # 800065e8 <release>
    80005740:	00a00493          	li	s1,10
    80005744:	fc1ff06f          	j	80005704 <consoleintr+0x50>

0000000080005748 <consoleinit>:
    80005748:	fe010113          	addi	sp,sp,-32
    8000574c:	00113c23          	sd	ra,24(sp)
    80005750:	00813823          	sd	s0,16(sp)
    80005754:	00913423          	sd	s1,8(sp)
    80005758:	02010413          	addi	s0,sp,32
    8000575c:	00007497          	auipc	s1,0x7
    80005760:	7ac48493          	addi	s1,s1,1964 # 8000cf08 <cons>
    80005764:	00048513          	mv	a0,s1
    80005768:	00002597          	auipc	a1,0x2
    8000576c:	f2858593          	addi	a1,a1,-216 # 80007690 <CONSOLE_STATUS+0x680>
    80005770:	00001097          	auipc	ra,0x1
    80005774:	d88080e7          	jalr	-632(ra) # 800064f8 <initlock>
    80005778:	00000097          	auipc	ra,0x0
    8000577c:	7ac080e7          	jalr	1964(ra) # 80005f24 <uartinit>
    80005780:	01813083          	ld	ra,24(sp)
    80005784:	01013403          	ld	s0,16(sp)
    80005788:	00000797          	auipc	a5,0x0
    8000578c:	d9c78793          	addi	a5,a5,-612 # 80005524 <consoleread>
    80005790:	0af4bc23          	sd	a5,184(s1)
    80005794:	00000797          	auipc	a5,0x0
    80005798:	cec78793          	addi	a5,a5,-788 # 80005480 <consolewrite>
    8000579c:	0cf4b023          	sd	a5,192(s1)
    800057a0:	00813483          	ld	s1,8(sp)
    800057a4:	02010113          	addi	sp,sp,32
    800057a8:	00008067          	ret

00000000800057ac <console_read>:
    800057ac:	ff010113          	addi	sp,sp,-16
    800057b0:	00813423          	sd	s0,8(sp)
    800057b4:	01010413          	addi	s0,sp,16
    800057b8:	00813403          	ld	s0,8(sp)
    800057bc:	00008317          	auipc	t1,0x8
    800057c0:	80433303          	ld	t1,-2044(t1) # 8000cfc0 <devsw+0x10>
    800057c4:	01010113          	addi	sp,sp,16
    800057c8:	00030067          	jr	t1

00000000800057cc <console_write>:
    800057cc:	ff010113          	addi	sp,sp,-16
    800057d0:	00813423          	sd	s0,8(sp)
    800057d4:	01010413          	addi	s0,sp,16
    800057d8:	00813403          	ld	s0,8(sp)
    800057dc:	00007317          	auipc	t1,0x7
    800057e0:	7ec33303          	ld	t1,2028(t1) # 8000cfc8 <devsw+0x18>
    800057e4:	01010113          	addi	sp,sp,16
    800057e8:	00030067          	jr	t1

00000000800057ec <panic>:
    800057ec:	fe010113          	addi	sp,sp,-32
    800057f0:	00113c23          	sd	ra,24(sp)
    800057f4:	00813823          	sd	s0,16(sp)
    800057f8:	00913423          	sd	s1,8(sp)
    800057fc:	02010413          	addi	s0,sp,32
    80005800:	00050493          	mv	s1,a0
    80005804:	00002517          	auipc	a0,0x2
    80005808:	e9450513          	addi	a0,a0,-364 # 80007698 <CONSOLE_STATUS+0x688>
    8000580c:	00008797          	auipc	a5,0x8
    80005810:	8407ae23          	sw	zero,-1956(a5) # 8000d068 <pr+0x18>
    80005814:	00000097          	auipc	ra,0x0
    80005818:	034080e7          	jalr	52(ra) # 80005848 <__printf>
    8000581c:	00048513          	mv	a0,s1
    80005820:	00000097          	auipc	ra,0x0
    80005824:	028080e7          	jalr	40(ra) # 80005848 <__printf>
    80005828:	00002517          	auipc	a0,0x2
    8000582c:	b2850513          	addi	a0,a0,-1240 # 80007350 <CONSOLE_STATUS+0x340>
    80005830:	00000097          	auipc	ra,0x0
    80005834:	018080e7          	jalr	24(ra) # 80005848 <__printf>
    80005838:	00100793          	li	a5,1
    8000583c:	00002717          	auipc	a4,0x2
    80005840:	38f72623          	sw	a5,908(a4) # 80007bc8 <panicked>
    80005844:	0000006f          	j	80005844 <panic+0x58>

0000000080005848 <__printf>:
    80005848:	f3010113          	addi	sp,sp,-208
    8000584c:	08813023          	sd	s0,128(sp)
    80005850:	07313423          	sd	s3,104(sp)
    80005854:	09010413          	addi	s0,sp,144
    80005858:	05813023          	sd	s8,64(sp)
    8000585c:	08113423          	sd	ra,136(sp)
    80005860:	06913c23          	sd	s1,120(sp)
    80005864:	07213823          	sd	s2,112(sp)
    80005868:	07413023          	sd	s4,96(sp)
    8000586c:	05513c23          	sd	s5,88(sp)
    80005870:	05613823          	sd	s6,80(sp)
    80005874:	05713423          	sd	s7,72(sp)
    80005878:	03913c23          	sd	s9,56(sp)
    8000587c:	03a13823          	sd	s10,48(sp)
    80005880:	03b13423          	sd	s11,40(sp)
    80005884:	00007317          	auipc	t1,0x7
    80005888:	7cc30313          	addi	t1,t1,1996 # 8000d050 <pr>
    8000588c:	01832c03          	lw	s8,24(t1)
    80005890:	00b43423          	sd	a1,8(s0)
    80005894:	00c43823          	sd	a2,16(s0)
    80005898:	00d43c23          	sd	a3,24(s0)
    8000589c:	02e43023          	sd	a4,32(s0)
    800058a0:	02f43423          	sd	a5,40(s0)
    800058a4:	03043823          	sd	a6,48(s0)
    800058a8:	03143c23          	sd	a7,56(s0)
    800058ac:	00050993          	mv	s3,a0
    800058b0:	4a0c1663          	bnez	s8,80005d5c <__printf+0x514>
    800058b4:	60098c63          	beqz	s3,80005ecc <__printf+0x684>
    800058b8:	0009c503          	lbu	a0,0(s3)
    800058bc:	00840793          	addi	a5,s0,8
    800058c0:	f6f43c23          	sd	a5,-136(s0)
    800058c4:	00000493          	li	s1,0
    800058c8:	22050063          	beqz	a0,80005ae8 <__printf+0x2a0>
    800058cc:	00002a37          	lui	s4,0x2
    800058d0:	00018ab7          	lui	s5,0x18
    800058d4:	000f4b37          	lui	s6,0xf4
    800058d8:	00989bb7          	lui	s7,0x989
    800058dc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800058e0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800058e4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800058e8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800058ec:	00148c9b          	addiw	s9,s1,1
    800058f0:	02500793          	li	a5,37
    800058f4:	01998933          	add	s2,s3,s9
    800058f8:	38f51263          	bne	a0,a5,80005c7c <__printf+0x434>
    800058fc:	00094783          	lbu	a5,0(s2)
    80005900:	00078c9b          	sext.w	s9,a5
    80005904:	1e078263          	beqz	a5,80005ae8 <__printf+0x2a0>
    80005908:	0024849b          	addiw	s1,s1,2
    8000590c:	07000713          	li	a4,112
    80005910:	00998933          	add	s2,s3,s1
    80005914:	38e78a63          	beq	a5,a4,80005ca8 <__printf+0x460>
    80005918:	20f76863          	bltu	a4,a5,80005b28 <__printf+0x2e0>
    8000591c:	42a78863          	beq	a5,a0,80005d4c <__printf+0x504>
    80005920:	06400713          	li	a4,100
    80005924:	40e79663          	bne	a5,a4,80005d30 <__printf+0x4e8>
    80005928:	f7843783          	ld	a5,-136(s0)
    8000592c:	0007a603          	lw	a2,0(a5)
    80005930:	00878793          	addi	a5,a5,8
    80005934:	f6f43c23          	sd	a5,-136(s0)
    80005938:	42064a63          	bltz	a2,80005d6c <__printf+0x524>
    8000593c:	00a00713          	li	a4,10
    80005940:	02e677bb          	remuw	a5,a2,a4
    80005944:	00002d97          	auipc	s11,0x2
    80005948:	d7cd8d93          	addi	s11,s11,-644 # 800076c0 <digits>
    8000594c:	00900593          	li	a1,9
    80005950:	0006051b          	sext.w	a0,a2
    80005954:	00000c93          	li	s9,0
    80005958:	02079793          	slli	a5,a5,0x20
    8000595c:	0207d793          	srli	a5,a5,0x20
    80005960:	00fd87b3          	add	a5,s11,a5
    80005964:	0007c783          	lbu	a5,0(a5)
    80005968:	02e656bb          	divuw	a3,a2,a4
    8000596c:	f8f40023          	sb	a5,-128(s0)
    80005970:	14c5d863          	bge	a1,a2,80005ac0 <__printf+0x278>
    80005974:	06300593          	li	a1,99
    80005978:	00100c93          	li	s9,1
    8000597c:	02e6f7bb          	remuw	a5,a3,a4
    80005980:	02079793          	slli	a5,a5,0x20
    80005984:	0207d793          	srli	a5,a5,0x20
    80005988:	00fd87b3          	add	a5,s11,a5
    8000598c:	0007c783          	lbu	a5,0(a5)
    80005990:	02e6d73b          	divuw	a4,a3,a4
    80005994:	f8f400a3          	sb	a5,-127(s0)
    80005998:	12a5f463          	bgeu	a1,a0,80005ac0 <__printf+0x278>
    8000599c:	00a00693          	li	a3,10
    800059a0:	00900593          	li	a1,9
    800059a4:	02d777bb          	remuw	a5,a4,a3
    800059a8:	02079793          	slli	a5,a5,0x20
    800059ac:	0207d793          	srli	a5,a5,0x20
    800059b0:	00fd87b3          	add	a5,s11,a5
    800059b4:	0007c503          	lbu	a0,0(a5)
    800059b8:	02d757bb          	divuw	a5,a4,a3
    800059bc:	f8a40123          	sb	a0,-126(s0)
    800059c0:	48e5f263          	bgeu	a1,a4,80005e44 <__printf+0x5fc>
    800059c4:	06300513          	li	a0,99
    800059c8:	02d7f5bb          	remuw	a1,a5,a3
    800059cc:	02059593          	slli	a1,a1,0x20
    800059d0:	0205d593          	srli	a1,a1,0x20
    800059d4:	00bd85b3          	add	a1,s11,a1
    800059d8:	0005c583          	lbu	a1,0(a1)
    800059dc:	02d7d7bb          	divuw	a5,a5,a3
    800059e0:	f8b401a3          	sb	a1,-125(s0)
    800059e4:	48e57263          	bgeu	a0,a4,80005e68 <__printf+0x620>
    800059e8:	3e700513          	li	a0,999
    800059ec:	02d7f5bb          	remuw	a1,a5,a3
    800059f0:	02059593          	slli	a1,a1,0x20
    800059f4:	0205d593          	srli	a1,a1,0x20
    800059f8:	00bd85b3          	add	a1,s11,a1
    800059fc:	0005c583          	lbu	a1,0(a1)
    80005a00:	02d7d7bb          	divuw	a5,a5,a3
    80005a04:	f8b40223          	sb	a1,-124(s0)
    80005a08:	46e57663          	bgeu	a0,a4,80005e74 <__printf+0x62c>
    80005a0c:	02d7f5bb          	remuw	a1,a5,a3
    80005a10:	02059593          	slli	a1,a1,0x20
    80005a14:	0205d593          	srli	a1,a1,0x20
    80005a18:	00bd85b3          	add	a1,s11,a1
    80005a1c:	0005c583          	lbu	a1,0(a1)
    80005a20:	02d7d7bb          	divuw	a5,a5,a3
    80005a24:	f8b402a3          	sb	a1,-123(s0)
    80005a28:	46ea7863          	bgeu	s4,a4,80005e98 <__printf+0x650>
    80005a2c:	02d7f5bb          	remuw	a1,a5,a3
    80005a30:	02059593          	slli	a1,a1,0x20
    80005a34:	0205d593          	srli	a1,a1,0x20
    80005a38:	00bd85b3          	add	a1,s11,a1
    80005a3c:	0005c583          	lbu	a1,0(a1)
    80005a40:	02d7d7bb          	divuw	a5,a5,a3
    80005a44:	f8b40323          	sb	a1,-122(s0)
    80005a48:	3eeaf863          	bgeu	s5,a4,80005e38 <__printf+0x5f0>
    80005a4c:	02d7f5bb          	remuw	a1,a5,a3
    80005a50:	02059593          	slli	a1,a1,0x20
    80005a54:	0205d593          	srli	a1,a1,0x20
    80005a58:	00bd85b3          	add	a1,s11,a1
    80005a5c:	0005c583          	lbu	a1,0(a1)
    80005a60:	02d7d7bb          	divuw	a5,a5,a3
    80005a64:	f8b403a3          	sb	a1,-121(s0)
    80005a68:	42eb7e63          	bgeu	s6,a4,80005ea4 <__printf+0x65c>
    80005a6c:	02d7f5bb          	remuw	a1,a5,a3
    80005a70:	02059593          	slli	a1,a1,0x20
    80005a74:	0205d593          	srli	a1,a1,0x20
    80005a78:	00bd85b3          	add	a1,s11,a1
    80005a7c:	0005c583          	lbu	a1,0(a1)
    80005a80:	02d7d7bb          	divuw	a5,a5,a3
    80005a84:	f8b40423          	sb	a1,-120(s0)
    80005a88:	42ebfc63          	bgeu	s7,a4,80005ec0 <__printf+0x678>
    80005a8c:	02079793          	slli	a5,a5,0x20
    80005a90:	0207d793          	srli	a5,a5,0x20
    80005a94:	00fd8db3          	add	s11,s11,a5
    80005a98:	000dc703          	lbu	a4,0(s11)
    80005a9c:	00a00793          	li	a5,10
    80005aa0:	00900c93          	li	s9,9
    80005aa4:	f8e404a3          	sb	a4,-119(s0)
    80005aa8:	00065c63          	bgez	a2,80005ac0 <__printf+0x278>
    80005aac:	f9040713          	addi	a4,s0,-112
    80005ab0:	00f70733          	add	a4,a4,a5
    80005ab4:	02d00693          	li	a3,45
    80005ab8:	fed70823          	sb	a3,-16(a4)
    80005abc:	00078c93          	mv	s9,a5
    80005ac0:	f8040793          	addi	a5,s0,-128
    80005ac4:	01978cb3          	add	s9,a5,s9
    80005ac8:	f7f40d13          	addi	s10,s0,-129
    80005acc:	000cc503          	lbu	a0,0(s9)
    80005ad0:	fffc8c93          	addi	s9,s9,-1
    80005ad4:	00000097          	auipc	ra,0x0
    80005ad8:	b90080e7          	jalr	-1136(ra) # 80005664 <consputc>
    80005adc:	ffac98e3          	bne	s9,s10,80005acc <__printf+0x284>
    80005ae0:	00094503          	lbu	a0,0(s2)
    80005ae4:	e00514e3          	bnez	a0,800058ec <__printf+0xa4>
    80005ae8:	1a0c1663          	bnez	s8,80005c94 <__printf+0x44c>
    80005aec:	08813083          	ld	ra,136(sp)
    80005af0:	08013403          	ld	s0,128(sp)
    80005af4:	07813483          	ld	s1,120(sp)
    80005af8:	07013903          	ld	s2,112(sp)
    80005afc:	06813983          	ld	s3,104(sp)
    80005b00:	06013a03          	ld	s4,96(sp)
    80005b04:	05813a83          	ld	s5,88(sp)
    80005b08:	05013b03          	ld	s6,80(sp)
    80005b0c:	04813b83          	ld	s7,72(sp)
    80005b10:	04013c03          	ld	s8,64(sp)
    80005b14:	03813c83          	ld	s9,56(sp)
    80005b18:	03013d03          	ld	s10,48(sp)
    80005b1c:	02813d83          	ld	s11,40(sp)
    80005b20:	0d010113          	addi	sp,sp,208
    80005b24:	00008067          	ret
    80005b28:	07300713          	li	a4,115
    80005b2c:	1ce78a63          	beq	a5,a4,80005d00 <__printf+0x4b8>
    80005b30:	07800713          	li	a4,120
    80005b34:	1ee79e63          	bne	a5,a4,80005d30 <__printf+0x4e8>
    80005b38:	f7843783          	ld	a5,-136(s0)
    80005b3c:	0007a703          	lw	a4,0(a5)
    80005b40:	00878793          	addi	a5,a5,8
    80005b44:	f6f43c23          	sd	a5,-136(s0)
    80005b48:	28074263          	bltz	a4,80005dcc <__printf+0x584>
    80005b4c:	00002d97          	auipc	s11,0x2
    80005b50:	b74d8d93          	addi	s11,s11,-1164 # 800076c0 <digits>
    80005b54:	00f77793          	andi	a5,a4,15
    80005b58:	00fd87b3          	add	a5,s11,a5
    80005b5c:	0007c683          	lbu	a3,0(a5)
    80005b60:	00f00613          	li	a2,15
    80005b64:	0007079b          	sext.w	a5,a4
    80005b68:	f8d40023          	sb	a3,-128(s0)
    80005b6c:	0047559b          	srliw	a1,a4,0x4
    80005b70:	0047569b          	srliw	a3,a4,0x4
    80005b74:	00000c93          	li	s9,0
    80005b78:	0ee65063          	bge	a2,a4,80005c58 <__printf+0x410>
    80005b7c:	00f6f693          	andi	a3,a3,15
    80005b80:	00dd86b3          	add	a3,s11,a3
    80005b84:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005b88:	0087d79b          	srliw	a5,a5,0x8
    80005b8c:	00100c93          	li	s9,1
    80005b90:	f8d400a3          	sb	a3,-127(s0)
    80005b94:	0cb67263          	bgeu	a2,a1,80005c58 <__printf+0x410>
    80005b98:	00f7f693          	andi	a3,a5,15
    80005b9c:	00dd86b3          	add	a3,s11,a3
    80005ba0:	0006c583          	lbu	a1,0(a3)
    80005ba4:	00f00613          	li	a2,15
    80005ba8:	0047d69b          	srliw	a3,a5,0x4
    80005bac:	f8b40123          	sb	a1,-126(s0)
    80005bb0:	0047d593          	srli	a1,a5,0x4
    80005bb4:	28f67e63          	bgeu	a2,a5,80005e50 <__printf+0x608>
    80005bb8:	00f6f693          	andi	a3,a3,15
    80005bbc:	00dd86b3          	add	a3,s11,a3
    80005bc0:	0006c503          	lbu	a0,0(a3)
    80005bc4:	0087d813          	srli	a6,a5,0x8
    80005bc8:	0087d69b          	srliw	a3,a5,0x8
    80005bcc:	f8a401a3          	sb	a0,-125(s0)
    80005bd0:	28b67663          	bgeu	a2,a1,80005e5c <__printf+0x614>
    80005bd4:	00f6f693          	andi	a3,a3,15
    80005bd8:	00dd86b3          	add	a3,s11,a3
    80005bdc:	0006c583          	lbu	a1,0(a3)
    80005be0:	00c7d513          	srli	a0,a5,0xc
    80005be4:	00c7d69b          	srliw	a3,a5,0xc
    80005be8:	f8b40223          	sb	a1,-124(s0)
    80005bec:	29067a63          	bgeu	a2,a6,80005e80 <__printf+0x638>
    80005bf0:	00f6f693          	andi	a3,a3,15
    80005bf4:	00dd86b3          	add	a3,s11,a3
    80005bf8:	0006c583          	lbu	a1,0(a3)
    80005bfc:	0107d813          	srli	a6,a5,0x10
    80005c00:	0107d69b          	srliw	a3,a5,0x10
    80005c04:	f8b402a3          	sb	a1,-123(s0)
    80005c08:	28a67263          	bgeu	a2,a0,80005e8c <__printf+0x644>
    80005c0c:	00f6f693          	andi	a3,a3,15
    80005c10:	00dd86b3          	add	a3,s11,a3
    80005c14:	0006c683          	lbu	a3,0(a3)
    80005c18:	0147d79b          	srliw	a5,a5,0x14
    80005c1c:	f8d40323          	sb	a3,-122(s0)
    80005c20:	21067663          	bgeu	a2,a6,80005e2c <__printf+0x5e4>
    80005c24:	02079793          	slli	a5,a5,0x20
    80005c28:	0207d793          	srli	a5,a5,0x20
    80005c2c:	00fd8db3          	add	s11,s11,a5
    80005c30:	000dc683          	lbu	a3,0(s11)
    80005c34:	00800793          	li	a5,8
    80005c38:	00700c93          	li	s9,7
    80005c3c:	f8d403a3          	sb	a3,-121(s0)
    80005c40:	00075c63          	bgez	a4,80005c58 <__printf+0x410>
    80005c44:	f9040713          	addi	a4,s0,-112
    80005c48:	00f70733          	add	a4,a4,a5
    80005c4c:	02d00693          	li	a3,45
    80005c50:	fed70823          	sb	a3,-16(a4)
    80005c54:	00078c93          	mv	s9,a5
    80005c58:	f8040793          	addi	a5,s0,-128
    80005c5c:	01978cb3          	add	s9,a5,s9
    80005c60:	f7f40d13          	addi	s10,s0,-129
    80005c64:	000cc503          	lbu	a0,0(s9)
    80005c68:	fffc8c93          	addi	s9,s9,-1
    80005c6c:	00000097          	auipc	ra,0x0
    80005c70:	9f8080e7          	jalr	-1544(ra) # 80005664 <consputc>
    80005c74:	ff9d18e3          	bne	s10,s9,80005c64 <__printf+0x41c>
    80005c78:	0100006f          	j	80005c88 <__printf+0x440>
    80005c7c:	00000097          	auipc	ra,0x0
    80005c80:	9e8080e7          	jalr	-1560(ra) # 80005664 <consputc>
    80005c84:	000c8493          	mv	s1,s9
    80005c88:	00094503          	lbu	a0,0(s2)
    80005c8c:	c60510e3          	bnez	a0,800058ec <__printf+0xa4>
    80005c90:	e40c0ee3          	beqz	s8,80005aec <__printf+0x2a4>
    80005c94:	00007517          	auipc	a0,0x7
    80005c98:	3bc50513          	addi	a0,a0,956 # 8000d050 <pr>
    80005c9c:	00001097          	auipc	ra,0x1
    80005ca0:	94c080e7          	jalr	-1716(ra) # 800065e8 <release>
    80005ca4:	e49ff06f          	j	80005aec <__printf+0x2a4>
    80005ca8:	f7843783          	ld	a5,-136(s0)
    80005cac:	03000513          	li	a0,48
    80005cb0:	01000d13          	li	s10,16
    80005cb4:	00878713          	addi	a4,a5,8
    80005cb8:	0007bc83          	ld	s9,0(a5)
    80005cbc:	f6e43c23          	sd	a4,-136(s0)
    80005cc0:	00000097          	auipc	ra,0x0
    80005cc4:	9a4080e7          	jalr	-1628(ra) # 80005664 <consputc>
    80005cc8:	07800513          	li	a0,120
    80005ccc:	00000097          	auipc	ra,0x0
    80005cd0:	998080e7          	jalr	-1640(ra) # 80005664 <consputc>
    80005cd4:	00002d97          	auipc	s11,0x2
    80005cd8:	9ecd8d93          	addi	s11,s11,-1556 # 800076c0 <digits>
    80005cdc:	03ccd793          	srli	a5,s9,0x3c
    80005ce0:	00fd87b3          	add	a5,s11,a5
    80005ce4:	0007c503          	lbu	a0,0(a5)
    80005ce8:	fffd0d1b          	addiw	s10,s10,-1
    80005cec:	004c9c93          	slli	s9,s9,0x4
    80005cf0:	00000097          	auipc	ra,0x0
    80005cf4:	974080e7          	jalr	-1676(ra) # 80005664 <consputc>
    80005cf8:	fe0d12e3          	bnez	s10,80005cdc <__printf+0x494>
    80005cfc:	f8dff06f          	j	80005c88 <__printf+0x440>
    80005d00:	f7843783          	ld	a5,-136(s0)
    80005d04:	0007bc83          	ld	s9,0(a5)
    80005d08:	00878793          	addi	a5,a5,8
    80005d0c:	f6f43c23          	sd	a5,-136(s0)
    80005d10:	000c9a63          	bnez	s9,80005d24 <__printf+0x4dc>
    80005d14:	1080006f          	j	80005e1c <__printf+0x5d4>
    80005d18:	001c8c93          	addi	s9,s9,1
    80005d1c:	00000097          	auipc	ra,0x0
    80005d20:	948080e7          	jalr	-1720(ra) # 80005664 <consputc>
    80005d24:	000cc503          	lbu	a0,0(s9)
    80005d28:	fe0518e3          	bnez	a0,80005d18 <__printf+0x4d0>
    80005d2c:	f5dff06f          	j	80005c88 <__printf+0x440>
    80005d30:	02500513          	li	a0,37
    80005d34:	00000097          	auipc	ra,0x0
    80005d38:	930080e7          	jalr	-1744(ra) # 80005664 <consputc>
    80005d3c:	000c8513          	mv	a0,s9
    80005d40:	00000097          	auipc	ra,0x0
    80005d44:	924080e7          	jalr	-1756(ra) # 80005664 <consputc>
    80005d48:	f41ff06f          	j	80005c88 <__printf+0x440>
    80005d4c:	02500513          	li	a0,37
    80005d50:	00000097          	auipc	ra,0x0
    80005d54:	914080e7          	jalr	-1772(ra) # 80005664 <consputc>
    80005d58:	f31ff06f          	j	80005c88 <__printf+0x440>
    80005d5c:	00030513          	mv	a0,t1
    80005d60:	00000097          	auipc	ra,0x0
    80005d64:	7bc080e7          	jalr	1980(ra) # 8000651c <acquire>
    80005d68:	b4dff06f          	j	800058b4 <__printf+0x6c>
    80005d6c:	40c0053b          	negw	a0,a2
    80005d70:	00a00713          	li	a4,10
    80005d74:	02e576bb          	remuw	a3,a0,a4
    80005d78:	00002d97          	auipc	s11,0x2
    80005d7c:	948d8d93          	addi	s11,s11,-1720 # 800076c0 <digits>
    80005d80:	ff700593          	li	a1,-9
    80005d84:	02069693          	slli	a3,a3,0x20
    80005d88:	0206d693          	srli	a3,a3,0x20
    80005d8c:	00dd86b3          	add	a3,s11,a3
    80005d90:	0006c683          	lbu	a3,0(a3)
    80005d94:	02e557bb          	divuw	a5,a0,a4
    80005d98:	f8d40023          	sb	a3,-128(s0)
    80005d9c:	10b65e63          	bge	a2,a1,80005eb8 <__printf+0x670>
    80005da0:	06300593          	li	a1,99
    80005da4:	02e7f6bb          	remuw	a3,a5,a4
    80005da8:	02069693          	slli	a3,a3,0x20
    80005dac:	0206d693          	srli	a3,a3,0x20
    80005db0:	00dd86b3          	add	a3,s11,a3
    80005db4:	0006c683          	lbu	a3,0(a3)
    80005db8:	02e7d73b          	divuw	a4,a5,a4
    80005dbc:	00200793          	li	a5,2
    80005dc0:	f8d400a3          	sb	a3,-127(s0)
    80005dc4:	bca5ece3          	bltu	a1,a0,8000599c <__printf+0x154>
    80005dc8:	ce5ff06f          	j	80005aac <__printf+0x264>
    80005dcc:	40e007bb          	negw	a5,a4
    80005dd0:	00002d97          	auipc	s11,0x2
    80005dd4:	8f0d8d93          	addi	s11,s11,-1808 # 800076c0 <digits>
    80005dd8:	00f7f693          	andi	a3,a5,15
    80005ddc:	00dd86b3          	add	a3,s11,a3
    80005de0:	0006c583          	lbu	a1,0(a3)
    80005de4:	ff100613          	li	a2,-15
    80005de8:	0047d69b          	srliw	a3,a5,0x4
    80005dec:	f8b40023          	sb	a1,-128(s0)
    80005df0:	0047d59b          	srliw	a1,a5,0x4
    80005df4:	0ac75e63          	bge	a4,a2,80005eb0 <__printf+0x668>
    80005df8:	00f6f693          	andi	a3,a3,15
    80005dfc:	00dd86b3          	add	a3,s11,a3
    80005e00:	0006c603          	lbu	a2,0(a3)
    80005e04:	00f00693          	li	a3,15
    80005e08:	0087d79b          	srliw	a5,a5,0x8
    80005e0c:	f8c400a3          	sb	a2,-127(s0)
    80005e10:	d8b6e4e3          	bltu	a3,a1,80005b98 <__printf+0x350>
    80005e14:	00200793          	li	a5,2
    80005e18:	e2dff06f          	j	80005c44 <__printf+0x3fc>
    80005e1c:	00002c97          	auipc	s9,0x2
    80005e20:	884c8c93          	addi	s9,s9,-1916 # 800076a0 <CONSOLE_STATUS+0x690>
    80005e24:	02800513          	li	a0,40
    80005e28:	ef1ff06f          	j	80005d18 <__printf+0x4d0>
    80005e2c:	00700793          	li	a5,7
    80005e30:	00600c93          	li	s9,6
    80005e34:	e0dff06f          	j	80005c40 <__printf+0x3f8>
    80005e38:	00700793          	li	a5,7
    80005e3c:	00600c93          	li	s9,6
    80005e40:	c69ff06f          	j	80005aa8 <__printf+0x260>
    80005e44:	00300793          	li	a5,3
    80005e48:	00200c93          	li	s9,2
    80005e4c:	c5dff06f          	j	80005aa8 <__printf+0x260>
    80005e50:	00300793          	li	a5,3
    80005e54:	00200c93          	li	s9,2
    80005e58:	de9ff06f          	j	80005c40 <__printf+0x3f8>
    80005e5c:	00400793          	li	a5,4
    80005e60:	00300c93          	li	s9,3
    80005e64:	dddff06f          	j	80005c40 <__printf+0x3f8>
    80005e68:	00400793          	li	a5,4
    80005e6c:	00300c93          	li	s9,3
    80005e70:	c39ff06f          	j	80005aa8 <__printf+0x260>
    80005e74:	00500793          	li	a5,5
    80005e78:	00400c93          	li	s9,4
    80005e7c:	c2dff06f          	j	80005aa8 <__printf+0x260>
    80005e80:	00500793          	li	a5,5
    80005e84:	00400c93          	li	s9,4
    80005e88:	db9ff06f          	j	80005c40 <__printf+0x3f8>
    80005e8c:	00600793          	li	a5,6
    80005e90:	00500c93          	li	s9,5
    80005e94:	dadff06f          	j	80005c40 <__printf+0x3f8>
    80005e98:	00600793          	li	a5,6
    80005e9c:	00500c93          	li	s9,5
    80005ea0:	c09ff06f          	j	80005aa8 <__printf+0x260>
    80005ea4:	00800793          	li	a5,8
    80005ea8:	00700c93          	li	s9,7
    80005eac:	bfdff06f          	j	80005aa8 <__printf+0x260>
    80005eb0:	00100793          	li	a5,1
    80005eb4:	d91ff06f          	j	80005c44 <__printf+0x3fc>
    80005eb8:	00100793          	li	a5,1
    80005ebc:	bf1ff06f          	j	80005aac <__printf+0x264>
    80005ec0:	00900793          	li	a5,9
    80005ec4:	00800c93          	li	s9,8
    80005ec8:	be1ff06f          	j	80005aa8 <__printf+0x260>
    80005ecc:	00001517          	auipc	a0,0x1
    80005ed0:	7dc50513          	addi	a0,a0,2012 # 800076a8 <CONSOLE_STATUS+0x698>
    80005ed4:	00000097          	auipc	ra,0x0
    80005ed8:	918080e7          	jalr	-1768(ra) # 800057ec <panic>

0000000080005edc <printfinit>:
    80005edc:	fe010113          	addi	sp,sp,-32
    80005ee0:	00813823          	sd	s0,16(sp)
    80005ee4:	00913423          	sd	s1,8(sp)
    80005ee8:	00113c23          	sd	ra,24(sp)
    80005eec:	02010413          	addi	s0,sp,32
    80005ef0:	00007497          	auipc	s1,0x7
    80005ef4:	16048493          	addi	s1,s1,352 # 8000d050 <pr>
    80005ef8:	00048513          	mv	a0,s1
    80005efc:	00001597          	auipc	a1,0x1
    80005f00:	7bc58593          	addi	a1,a1,1980 # 800076b8 <CONSOLE_STATUS+0x6a8>
    80005f04:	00000097          	auipc	ra,0x0
    80005f08:	5f4080e7          	jalr	1524(ra) # 800064f8 <initlock>
    80005f0c:	01813083          	ld	ra,24(sp)
    80005f10:	01013403          	ld	s0,16(sp)
    80005f14:	0004ac23          	sw	zero,24(s1)
    80005f18:	00813483          	ld	s1,8(sp)
    80005f1c:	02010113          	addi	sp,sp,32
    80005f20:	00008067          	ret

0000000080005f24 <uartinit>:
    80005f24:	ff010113          	addi	sp,sp,-16
    80005f28:	00813423          	sd	s0,8(sp)
    80005f2c:	01010413          	addi	s0,sp,16
    80005f30:	100007b7          	lui	a5,0x10000
    80005f34:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80005f38:	f8000713          	li	a4,-128
    80005f3c:	00e781a3          	sb	a4,3(a5)
    80005f40:	00300713          	li	a4,3
    80005f44:	00e78023          	sb	a4,0(a5)
    80005f48:	000780a3          	sb	zero,1(a5)
    80005f4c:	00e781a3          	sb	a4,3(a5)
    80005f50:	00700693          	li	a3,7
    80005f54:	00d78123          	sb	a3,2(a5)
    80005f58:	00e780a3          	sb	a4,1(a5)
    80005f5c:	00813403          	ld	s0,8(sp)
    80005f60:	01010113          	addi	sp,sp,16
    80005f64:	00008067          	ret

0000000080005f68 <uartputc>:
    80005f68:	00002797          	auipc	a5,0x2
    80005f6c:	c607a783          	lw	a5,-928(a5) # 80007bc8 <panicked>
    80005f70:	00078463          	beqz	a5,80005f78 <uartputc+0x10>
    80005f74:	0000006f          	j	80005f74 <uartputc+0xc>
    80005f78:	fd010113          	addi	sp,sp,-48
    80005f7c:	02813023          	sd	s0,32(sp)
    80005f80:	00913c23          	sd	s1,24(sp)
    80005f84:	01213823          	sd	s2,16(sp)
    80005f88:	01313423          	sd	s3,8(sp)
    80005f8c:	02113423          	sd	ra,40(sp)
    80005f90:	03010413          	addi	s0,sp,48
    80005f94:	00002917          	auipc	s2,0x2
    80005f98:	c3c90913          	addi	s2,s2,-964 # 80007bd0 <uart_tx_r>
    80005f9c:	00093783          	ld	a5,0(s2)
    80005fa0:	00002497          	auipc	s1,0x2
    80005fa4:	c3848493          	addi	s1,s1,-968 # 80007bd8 <uart_tx_w>
    80005fa8:	0004b703          	ld	a4,0(s1)
    80005fac:	02078693          	addi	a3,a5,32
    80005fb0:	00050993          	mv	s3,a0
    80005fb4:	02e69c63          	bne	a3,a4,80005fec <uartputc+0x84>
    80005fb8:	00001097          	auipc	ra,0x1
    80005fbc:	834080e7          	jalr	-1996(ra) # 800067ec <push_on>
    80005fc0:	00093783          	ld	a5,0(s2)
    80005fc4:	0004b703          	ld	a4,0(s1)
    80005fc8:	02078793          	addi	a5,a5,32
    80005fcc:	00e79463          	bne	a5,a4,80005fd4 <uartputc+0x6c>
    80005fd0:	0000006f          	j	80005fd0 <uartputc+0x68>
    80005fd4:	00001097          	auipc	ra,0x1
    80005fd8:	88c080e7          	jalr	-1908(ra) # 80006860 <pop_on>
    80005fdc:	00093783          	ld	a5,0(s2)
    80005fe0:	0004b703          	ld	a4,0(s1)
    80005fe4:	02078693          	addi	a3,a5,32
    80005fe8:	fce688e3          	beq	a3,a4,80005fb8 <uartputc+0x50>
    80005fec:	01f77693          	andi	a3,a4,31
    80005ff0:	00007597          	auipc	a1,0x7
    80005ff4:	08058593          	addi	a1,a1,128 # 8000d070 <uart_tx_buf>
    80005ff8:	00d586b3          	add	a3,a1,a3
    80005ffc:	00170713          	addi	a4,a4,1
    80006000:	01368023          	sb	s3,0(a3)
    80006004:	00e4b023          	sd	a4,0(s1)
    80006008:	10000637          	lui	a2,0x10000
    8000600c:	02f71063          	bne	a4,a5,8000602c <uartputc+0xc4>
    80006010:	0340006f          	j	80006044 <uartputc+0xdc>
    80006014:	00074703          	lbu	a4,0(a4)
    80006018:	00f93023          	sd	a5,0(s2)
    8000601c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006020:	00093783          	ld	a5,0(s2)
    80006024:	0004b703          	ld	a4,0(s1)
    80006028:	00f70e63          	beq	a4,a5,80006044 <uartputc+0xdc>
    8000602c:	00564683          	lbu	a3,5(a2)
    80006030:	01f7f713          	andi	a4,a5,31
    80006034:	00e58733          	add	a4,a1,a4
    80006038:	0206f693          	andi	a3,a3,32
    8000603c:	00178793          	addi	a5,a5,1
    80006040:	fc069ae3          	bnez	a3,80006014 <uartputc+0xac>
    80006044:	02813083          	ld	ra,40(sp)
    80006048:	02013403          	ld	s0,32(sp)
    8000604c:	01813483          	ld	s1,24(sp)
    80006050:	01013903          	ld	s2,16(sp)
    80006054:	00813983          	ld	s3,8(sp)
    80006058:	03010113          	addi	sp,sp,48
    8000605c:	00008067          	ret

0000000080006060 <uartputc_sync>:
    80006060:	ff010113          	addi	sp,sp,-16
    80006064:	00813423          	sd	s0,8(sp)
    80006068:	01010413          	addi	s0,sp,16
    8000606c:	00002717          	auipc	a4,0x2
    80006070:	b5c72703          	lw	a4,-1188(a4) # 80007bc8 <panicked>
    80006074:	02071663          	bnez	a4,800060a0 <uartputc_sync+0x40>
    80006078:	00050793          	mv	a5,a0
    8000607c:	100006b7          	lui	a3,0x10000
    80006080:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006084:	02077713          	andi	a4,a4,32
    80006088:	fe070ce3          	beqz	a4,80006080 <uartputc_sync+0x20>
    8000608c:	0ff7f793          	andi	a5,a5,255
    80006090:	00f68023          	sb	a5,0(a3)
    80006094:	00813403          	ld	s0,8(sp)
    80006098:	01010113          	addi	sp,sp,16
    8000609c:	00008067          	ret
    800060a0:	0000006f          	j	800060a0 <uartputc_sync+0x40>

00000000800060a4 <uartstart>:
    800060a4:	ff010113          	addi	sp,sp,-16
    800060a8:	00813423          	sd	s0,8(sp)
    800060ac:	01010413          	addi	s0,sp,16
    800060b0:	00002617          	auipc	a2,0x2
    800060b4:	b2060613          	addi	a2,a2,-1248 # 80007bd0 <uart_tx_r>
    800060b8:	00002517          	auipc	a0,0x2
    800060bc:	b2050513          	addi	a0,a0,-1248 # 80007bd8 <uart_tx_w>
    800060c0:	00063783          	ld	a5,0(a2)
    800060c4:	00053703          	ld	a4,0(a0)
    800060c8:	04f70263          	beq	a4,a5,8000610c <uartstart+0x68>
    800060cc:	100005b7          	lui	a1,0x10000
    800060d0:	00007817          	auipc	a6,0x7
    800060d4:	fa080813          	addi	a6,a6,-96 # 8000d070 <uart_tx_buf>
    800060d8:	01c0006f          	j	800060f4 <uartstart+0x50>
    800060dc:	0006c703          	lbu	a4,0(a3)
    800060e0:	00f63023          	sd	a5,0(a2)
    800060e4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800060e8:	00063783          	ld	a5,0(a2)
    800060ec:	00053703          	ld	a4,0(a0)
    800060f0:	00f70e63          	beq	a4,a5,8000610c <uartstart+0x68>
    800060f4:	01f7f713          	andi	a4,a5,31
    800060f8:	00e806b3          	add	a3,a6,a4
    800060fc:	0055c703          	lbu	a4,5(a1)
    80006100:	00178793          	addi	a5,a5,1
    80006104:	02077713          	andi	a4,a4,32
    80006108:	fc071ae3          	bnez	a4,800060dc <uartstart+0x38>
    8000610c:	00813403          	ld	s0,8(sp)
    80006110:	01010113          	addi	sp,sp,16
    80006114:	00008067          	ret

0000000080006118 <uartgetc>:
    80006118:	ff010113          	addi	sp,sp,-16
    8000611c:	00813423          	sd	s0,8(sp)
    80006120:	01010413          	addi	s0,sp,16
    80006124:	10000737          	lui	a4,0x10000
    80006128:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000612c:	0017f793          	andi	a5,a5,1
    80006130:	00078c63          	beqz	a5,80006148 <uartgetc+0x30>
    80006134:	00074503          	lbu	a0,0(a4)
    80006138:	0ff57513          	andi	a0,a0,255
    8000613c:	00813403          	ld	s0,8(sp)
    80006140:	01010113          	addi	sp,sp,16
    80006144:	00008067          	ret
    80006148:	fff00513          	li	a0,-1
    8000614c:	ff1ff06f          	j	8000613c <uartgetc+0x24>

0000000080006150 <uartintr>:
    80006150:	100007b7          	lui	a5,0x10000
    80006154:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006158:	0017f793          	andi	a5,a5,1
    8000615c:	0a078463          	beqz	a5,80006204 <uartintr+0xb4>
    80006160:	fe010113          	addi	sp,sp,-32
    80006164:	00813823          	sd	s0,16(sp)
    80006168:	00913423          	sd	s1,8(sp)
    8000616c:	00113c23          	sd	ra,24(sp)
    80006170:	02010413          	addi	s0,sp,32
    80006174:	100004b7          	lui	s1,0x10000
    80006178:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000617c:	0ff57513          	andi	a0,a0,255
    80006180:	fffff097          	auipc	ra,0xfffff
    80006184:	534080e7          	jalr	1332(ra) # 800056b4 <consoleintr>
    80006188:	0054c783          	lbu	a5,5(s1)
    8000618c:	0017f793          	andi	a5,a5,1
    80006190:	fe0794e3          	bnez	a5,80006178 <uartintr+0x28>
    80006194:	00002617          	auipc	a2,0x2
    80006198:	a3c60613          	addi	a2,a2,-1476 # 80007bd0 <uart_tx_r>
    8000619c:	00002517          	auipc	a0,0x2
    800061a0:	a3c50513          	addi	a0,a0,-1476 # 80007bd8 <uart_tx_w>
    800061a4:	00063783          	ld	a5,0(a2)
    800061a8:	00053703          	ld	a4,0(a0)
    800061ac:	04f70263          	beq	a4,a5,800061f0 <uartintr+0xa0>
    800061b0:	100005b7          	lui	a1,0x10000
    800061b4:	00007817          	auipc	a6,0x7
    800061b8:	ebc80813          	addi	a6,a6,-324 # 8000d070 <uart_tx_buf>
    800061bc:	01c0006f          	j	800061d8 <uartintr+0x88>
    800061c0:	0006c703          	lbu	a4,0(a3)
    800061c4:	00f63023          	sd	a5,0(a2)
    800061c8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800061cc:	00063783          	ld	a5,0(a2)
    800061d0:	00053703          	ld	a4,0(a0)
    800061d4:	00f70e63          	beq	a4,a5,800061f0 <uartintr+0xa0>
    800061d8:	01f7f713          	andi	a4,a5,31
    800061dc:	00e806b3          	add	a3,a6,a4
    800061e0:	0055c703          	lbu	a4,5(a1)
    800061e4:	00178793          	addi	a5,a5,1
    800061e8:	02077713          	andi	a4,a4,32
    800061ec:	fc071ae3          	bnez	a4,800061c0 <uartintr+0x70>
    800061f0:	01813083          	ld	ra,24(sp)
    800061f4:	01013403          	ld	s0,16(sp)
    800061f8:	00813483          	ld	s1,8(sp)
    800061fc:	02010113          	addi	sp,sp,32
    80006200:	00008067          	ret
    80006204:	00002617          	auipc	a2,0x2
    80006208:	9cc60613          	addi	a2,a2,-1588 # 80007bd0 <uart_tx_r>
    8000620c:	00002517          	auipc	a0,0x2
    80006210:	9cc50513          	addi	a0,a0,-1588 # 80007bd8 <uart_tx_w>
    80006214:	00063783          	ld	a5,0(a2)
    80006218:	00053703          	ld	a4,0(a0)
    8000621c:	04f70263          	beq	a4,a5,80006260 <uartintr+0x110>
    80006220:	100005b7          	lui	a1,0x10000
    80006224:	00007817          	auipc	a6,0x7
    80006228:	e4c80813          	addi	a6,a6,-436 # 8000d070 <uart_tx_buf>
    8000622c:	01c0006f          	j	80006248 <uartintr+0xf8>
    80006230:	0006c703          	lbu	a4,0(a3)
    80006234:	00f63023          	sd	a5,0(a2)
    80006238:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000623c:	00063783          	ld	a5,0(a2)
    80006240:	00053703          	ld	a4,0(a0)
    80006244:	02f70063          	beq	a4,a5,80006264 <uartintr+0x114>
    80006248:	01f7f713          	andi	a4,a5,31
    8000624c:	00e806b3          	add	a3,a6,a4
    80006250:	0055c703          	lbu	a4,5(a1)
    80006254:	00178793          	addi	a5,a5,1
    80006258:	02077713          	andi	a4,a4,32
    8000625c:	fc071ae3          	bnez	a4,80006230 <uartintr+0xe0>
    80006260:	00008067          	ret
    80006264:	00008067          	ret

0000000080006268 <kinit>:
    80006268:	fc010113          	addi	sp,sp,-64
    8000626c:	02913423          	sd	s1,40(sp)
    80006270:	fffff7b7          	lui	a5,0xfffff
    80006274:	0000f497          	auipc	s1,0xf
    80006278:	d8b48493          	addi	s1,s1,-629 # 80014fff <end+0xfff>
    8000627c:	02813823          	sd	s0,48(sp)
    80006280:	01313c23          	sd	s3,24(sp)
    80006284:	00f4f4b3          	and	s1,s1,a5
    80006288:	02113c23          	sd	ra,56(sp)
    8000628c:	03213023          	sd	s2,32(sp)
    80006290:	01413823          	sd	s4,16(sp)
    80006294:	01513423          	sd	s5,8(sp)
    80006298:	04010413          	addi	s0,sp,64
    8000629c:	000017b7          	lui	a5,0x1
    800062a0:	01100993          	li	s3,17
    800062a4:	00f487b3          	add	a5,s1,a5
    800062a8:	01b99993          	slli	s3,s3,0x1b
    800062ac:	06f9e063          	bltu	s3,a5,8000630c <kinit+0xa4>
    800062b0:	0000ea97          	auipc	s5,0xe
    800062b4:	d50a8a93          	addi	s5,s5,-688 # 80014000 <end>
    800062b8:	0754ec63          	bltu	s1,s5,80006330 <kinit+0xc8>
    800062bc:	0734fa63          	bgeu	s1,s3,80006330 <kinit+0xc8>
    800062c0:	00088a37          	lui	s4,0x88
    800062c4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800062c8:	00002917          	auipc	s2,0x2
    800062cc:	91890913          	addi	s2,s2,-1768 # 80007be0 <kmem>
    800062d0:	00ca1a13          	slli	s4,s4,0xc
    800062d4:	0140006f          	j	800062e8 <kinit+0x80>
    800062d8:	000017b7          	lui	a5,0x1
    800062dc:	00f484b3          	add	s1,s1,a5
    800062e0:	0554e863          	bltu	s1,s5,80006330 <kinit+0xc8>
    800062e4:	0534f663          	bgeu	s1,s3,80006330 <kinit+0xc8>
    800062e8:	00001637          	lui	a2,0x1
    800062ec:	00100593          	li	a1,1
    800062f0:	00048513          	mv	a0,s1
    800062f4:	00000097          	auipc	ra,0x0
    800062f8:	5e4080e7          	jalr	1508(ra) # 800068d8 <__memset>
    800062fc:	00093783          	ld	a5,0(s2)
    80006300:	00f4b023          	sd	a5,0(s1)
    80006304:	00993023          	sd	s1,0(s2)
    80006308:	fd4498e3          	bne	s1,s4,800062d8 <kinit+0x70>
    8000630c:	03813083          	ld	ra,56(sp)
    80006310:	03013403          	ld	s0,48(sp)
    80006314:	02813483          	ld	s1,40(sp)
    80006318:	02013903          	ld	s2,32(sp)
    8000631c:	01813983          	ld	s3,24(sp)
    80006320:	01013a03          	ld	s4,16(sp)
    80006324:	00813a83          	ld	s5,8(sp)
    80006328:	04010113          	addi	sp,sp,64
    8000632c:	00008067          	ret
    80006330:	00001517          	auipc	a0,0x1
    80006334:	3a850513          	addi	a0,a0,936 # 800076d8 <digits+0x18>
    80006338:	fffff097          	auipc	ra,0xfffff
    8000633c:	4b4080e7          	jalr	1204(ra) # 800057ec <panic>

0000000080006340 <freerange>:
    80006340:	fc010113          	addi	sp,sp,-64
    80006344:	000017b7          	lui	a5,0x1
    80006348:	02913423          	sd	s1,40(sp)
    8000634c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006350:	009504b3          	add	s1,a0,s1
    80006354:	fffff537          	lui	a0,0xfffff
    80006358:	02813823          	sd	s0,48(sp)
    8000635c:	02113c23          	sd	ra,56(sp)
    80006360:	03213023          	sd	s2,32(sp)
    80006364:	01313c23          	sd	s3,24(sp)
    80006368:	01413823          	sd	s4,16(sp)
    8000636c:	01513423          	sd	s5,8(sp)
    80006370:	01613023          	sd	s6,0(sp)
    80006374:	04010413          	addi	s0,sp,64
    80006378:	00a4f4b3          	and	s1,s1,a0
    8000637c:	00f487b3          	add	a5,s1,a5
    80006380:	06f5e463          	bltu	a1,a5,800063e8 <freerange+0xa8>
    80006384:	0000ea97          	auipc	s5,0xe
    80006388:	c7ca8a93          	addi	s5,s5,-900 # 80014000 <end>
    8000638c:	0954e263          	bltu	s1,s5,80006410 <freerange+0xd0>
    80006390:	01100993          	li	s3,17
    80006394:	01b99993          	slli	s3,s3,0x1b
    80006398:	0734fc63          	bgeu	s1,s3,80006410 <freerange+0xd0>
    8000639c:	00058a13          	mv	s4,a1
    800063a0:	00002917          	auipc	s2,0x2
    800063a4:	84090913          	addi	s2,s2,-1984 # 80007be0 <kmem>
    800063a8:	00002b37          	lui	s6,0x2
    800063ac:	0140006f          	j	800063c0 <freerange+0x80>
    800063b0:	000017b7          	lui	a5,0x1
    800063b4:	00f484b3          	add	s1,s1,a5
    800063b8:	0554ec63          	bltu	s1,s5,80006410 <freerange+0xd0>
    800063bc:	0534fa63          	bgeu	s1,s3,80006410 <freerange+0xd0>
    800063c0:	00001637          	lui	a2,0x1
    800063c4:	00100593          	li	a1,1
    800063c8:	00048513          	mv	a0,s1
    800063cc:	00000097          	auipc	ra,0x0
    800063d0:	50c080e7          	jalr	1292(ra) # 800068d8 <__memset>
    800063d4:	00093703          	ld	a4,0(s2)
    800063d8:	016487b3          	add	a5,s1,s6
    800063dc:	00e4b023          	sd	a4,0(s1)
    800063e0:	00993023          	sd	s1,0(s2)
    800063e4:	fcfa76e3          	bgeu	s4,a5,800063b0 <freerange+0x70>
    800063e8:	03813083          	ld	ra,56(sp)
    800063ec:	03013403          	ld	s0,48(sp)
    800063f0:	02813483          	ld	s1,40(sp)
    800063f4:	02013903          	ld	s2,32(sp)
    800063f8:	01813983          	ld	s3,24(sp)
    800063fc:	01013a03          	ld	s4,16(sp)
    80006400:	00813a83          	ld	s5,8(sp)
    80006404:	00013b03          	ld	s6,0(sp)
    80006408:	04010113          	addi	sp,sp,64
    8000640c:	00008067          	ret
    80006410:	00001517          	auipc	a0,0x1
    80006414:	2c850513          	addi	a0,a0,712 # 800076d8 <digits+0x18>
    80006418:	fffff097          	auipc	ra,0xfffff
    8000641c:	3d4080e7          	jalr	980(ra) # 800057ec <panic>

0000000080006420 <kfree>:
    80006420:	fe010113          	addi	sp,sp,-32
    80006424:	00813823          	sd	s0,16(sp)
    80006428:	00113c23          	sd	ra,24(sp)
    8000642c:	00913423          	sd	s1,8(sp)
    80006430:	02010413          	addi	s0,sp,32
    80006434:	03451793          	slli	a5,a0,0x34
    80006438:	04079c63          	bnez	a5,80006490 <kfree+0x70>
    8000643c:	0000e797          	auipc	a5,0xe
    80006440:	bc478793          	addi	a5,a5,-1084 # 80014000 <end>
    80006444:	00050493          	mv	s1,a0
    80006448:	04f56463          	bltu	a0,a5,80006490 <kfree+0x70>
    8000644c:	01100793          	li	a5,17
    80006450:	01b79793          	slli	a5,a5,0x1b
    80006454:	02f57e63          	bgeu	a0,a5,80006490 <kfree+0x70>
    80006458:	00001637          	lui	a2,0x1
    8000645c:	00100593          	li	a1,1
    80006460:	00000097          	auipc	ra,0x0
    80006464:	478080e7          	jalr	1144(ra) # 800068d8 <__memset>
    80006468:	00001797          	auipc	a5,0x1
    8000646c:	77878793          	addi	a5,a5,1912 # 80007be0 <kmem>
    80006470:	0007b703          	ld	a4,0(a5)
    80006474:	01813083          	ld	ra,24(sp)
    80006478:	01013403          	ld	s0,16(sp)
    8000647c:	00e4b023          	sd	a4,0(s1)
    80006480:	0097b023          	sd	s1,0(a5)
    80006484:	00813483          	ld	s1,8(sp)
    80006488:	02010113          	addi	sp,sp,32
    8000648c:	00008067          	ret
    80006490:	00001517          	auipc	a0,0x1
    80006494:	24850513          	addi	a0,a0,584 # 800076d8 <digits+0x18>
    80006498:	fffff097          	auipc	ra,0xfffff
    8000649c:	354080e7          	jalr	852(ra) # 800057ec <panic>

00000000800064a0 <kalloc>:
    800064a0:	fe010113          	addi	sp,sp,-32
    800064a4:	00813823          	sd	s0,16(sp)
    800064a8:	00913423          	sd	s1,8(sp)
    800064ac:	00113c23          	sd	ra,24(sp)
    800064b0:	02010413          	addi	s0,sp,32
    800064b4:	00001797          	auipc	a5,0x1
    800064b8:	72c78793          	addi	a5,a5,1836 # 80007be0 <kmem>
    800064bc:	0007b483          	ld	s1,0(a5)
    800064c0:	02048063          	beqz	s1,800064e0 <kalloc+0x40>
    800064c4:	0004b703          	ld	a4,0(s1)
    800064c8:	00001637          	lui	a2,0x1
    800064cc:	00500593          	li	a1,5
    800064d0:	00048513          	mv	a0,s1
    800064d4:	00e7b023          	sd	a4,0(a5)
    800064d8:	00000097          	auipc	ra,0x0
    800064dc:	400080e7          	jalr	1024(ra) # 800068d8 <__memset>
    800064e0:	01813083          	ld	ra,24(sp)
    800064e4:	01013403          	ld	s0,16(sp)
    800064e8:	00048513          	mv	a0,s1
    800064ec:	00813483          	ld	s1,8(sp)
    800064f0:	02010113          	addi	sp,sp,32
    800064f4:	00008067          	ret

00000000800064f8 <initlock>:
    800064f8:	ff010113          	addi	sp,sp,-16
    800064fc:	00813423          	sd	s0,8(sp)
    80006500:	01010413          	addi	s0,sp,16
    80006504:	00813403          	ld	s0,8(sp)
    80006508:	00b53423          	sd	a1,8(a0)
    8000650c:	00052023          	sw	zero,0(a0)
    80006510:	00053823          	sd	zero,16(a0)
    80006514:	01010113          	addi	sp,sp,16
    80006518:	00008067          	ret

000000008000651c <acquire>:
    8000651c:	fe010113          	addi	sp,sp,-32
    80006520:	00813823          	sd	s0,16(sp)
    80006524:	00913423          	sd	s1,8(sp)
    80006528:	00113c23          	sd	ra,24(sp)
    8000652c:	01213023          	sd	s2,0(sp)
    80006530:	02010413          	addi	s0,sp,32
    80006534:	00050493          	mv	s1,a0
    80006538:	10002973          	csrr	s2,sstatus
    8000653c:	100027f3          	csrr	a5,sstatus
    80006540:	ffd7f793          	andi	a5,a5,-3
    80006544:	10079073          	csrw	sstatus,a5
    80006548:	fffff097          	auipc	ra,0xfffff
    8000654c:	8ec080e7          	jalr	-1812(ra) # 80004e34 <mycpu>
    80006550:	07852783          	lw	a5,120(a0)
    80006554:	06078e63          	beqz	a5,800065d0 <acquire+0xb4>
    80006558:	fffff097          	auipc	ra,0xfffff
    8000655c:	8dc080e7          	jalr	-1828(ra) # 80004e34 <mycpu>
    80006560:	07852783          	lw	a5,120(a0)
    80006564:	0004a703          	lw	a4,0(s1)
    80006568:	0017879b          	addiw	a5,a5,1
    8000656c:	06f52c23          	sw	a5,120(a0)
    80006570:	04071063          	bnez	a4,800065b0 <acquire+0x94>
    80006574:	00100713          	li	a4,1
    80006578:	00070793          	mv	a5,a4
    8000657c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006580:	0007879b          	sext.w	a5,a5
    80006584:	fe079ae3          	bnez	a5,80006578 <acquire+0x5c>
    80006588:	0ff0000f          	fence
    8000658c:	fffff097          	auipc	ra,0xfffff
    80006590:	8a8080e7          	jalr	-1880(ra) # 80004e34 <mycpu>
    80006594:	01813083          	ld	ra,24(sp)
    80006598:	01013403          	ld	s0,16(sp)
    8000659c:	00a4b823          	sd	a0,16(s1)
    800065a0:	00013903          	ld	s2,0(sp)
    800065a4:	00813483          	ld	s1,8(sp)
    800065a8:	02010113          	addi	sp,sp,32
    800065ac:	00008067          	ret
    800065b0:	0104b903          	ld	s2,16(s1)
    800065b4:	fffff097          	auipc	ra,0xfffff
    800065b8:	880080e7          	jalr	-1920(ra) # 80004e34 <mycpu>
    800065bc:	faa91ce3          	bne	s2,a0,80006574 <acquire+0x58>
    800065c0:	00001517          	auipc	a0,0x1
    800065c4:	12050513          	addi	a0,a0,288 # 800076e0 <digits+0x20>
    800065c8:	fffff097          	auipc	ra,0xfffff
    800065cc:	224080e7          	jalr	548(ra) # 800057ec <panic>
    800065d0:	00195913          	srli	s2,s2,0x1
    800065d4:	fffff097          	auipc	ra,0xfffff
    800065d8:	860080e7          	jalr	-1952(ra) # 80004e34 <mycpu>
    800065dc:	00197913          	andi	s2,s2,1
    800065e0:	07252e23          	sw	s2,124(a0)
    800065e4:	f75ff06f          	j	80006558 <acquire+0x3c>

00000000800065e8 <release>:
    800065e8:	fe010113          	addi	sp,sp,-32
    800065ec:	00813823          	sd	s0,16(sp)
    800065f0:	00113c23          	sd	ra,24(sp)
    800065f4:	00913423          	sd	s1,8(sp)
    800065f8:	01213023          	sd	s2,0(sp)
    800065fc:	02010413          	addi	s0,sp,32
    80006600:	00052783          	lw	a5,0(a0)
    80006604:	00079a63          	bnez	a5,80006618 <release+0x30>
    80006608:	00001517          	auipc	a0,0x1
    8000660c:	0e050513          	addi	a0,a0,224 # 800076e8 <digits+0x28>
    80006610:	fffff097          	auipc	ra,0xfffff
    80006614:	1dc080e7          	jalr	476(ra) # 800057ec <panic>
    80006618:	01053903          	ld	s2,16(a0)
    8000661c:	00050493          	mv	s1,a0
    80006620:	fffff097          	auipc	ra,0xfffff
    80006624:	814080e7          	jalr	-2028(ra) # 80004e34 <mycpu>
    80006628:	fea910e3          	bne	s2,a0,80006608 <release+0x20>
    8000662c:	0004b823          	sd	zero,16(s1)
    80006630:	0ff0000f          	fence
    80006634:	0f50000f          	fence	iorw,ow
    80006638:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000663c:	ffffe097          	auipc	ra,0xffffe
    80006640:	7f8080e7          	jalr	2040(ra) # 80004e34 <mycpu>
    80006644:	100027f3          	csrr	a5,sstatus
    80006648:	0027f793          	andi	a5,a5,2
    8000664c:	04079a63          	bnez	a5,800066a0 <release+0xb8>
    80006650:	07852783          	lw	a5,120(a0)
    80006654:	02f05e63          	blez	a5,80006690 <release+0xa8>
    80006658:	fff7871b          	addiw	a4,a5,-1
    8000665c:	06e52c23          	sw	a4,120(a0)
    80006660:	00071c63          	bnez	a4,80006678 <release+0x90>
    80006664:	07c52783          	lw	a5,124(a0)
    80006668:	00078863          	beqz	a5,80006678 <release+0x90>
    8000666c:	100027f3          	csrr	a5,sstatus
    80006670:	0027e793          	ori	a5,a5,2
    80006674:	10079073          	csrw	sstatus,a5
    80006678:	01813083          	ld	ra,24(sp)
    8000667c:	01013403          	ld	s0,16(sp)
    80006680:	00813483          	ld	s1,8(sp)
    80006684:	00013903          	ld	s2,0(sp)
    80006688:	02010113          	addi	sp,sp,32
    8000668c:	00008067          	ret
    80006690:	00001517          	auipc	a0,0x1
    80006694:	07850513          	addi	a0,a0,120 # 80007708 <digits+0x48>
    80006698:	fffff097          	auipc	ra,0xfffff
    8000669c:	154080e7          	jalr	340(ra) # 800057ec <panic>
    800066a0:	00001517          	auipc	a0,0x1
    800066a4:	05050513          	addi	a0,a0,80 # 800076f0 <digits+0x30>
    800066a8:	fffff097          	auipc	ra,0xfffff
    800066ac:	144080e7          	jalr	324(ra) # 800057ec <panic>

00000000800066b0 <holding>:
    800066b0:	00052783          	lw	a5,0(a0)
    800066b4:	00079663          	bnez	a5,800066c0 <holding+0x10>
    800066b8:	00000513          	li	a0,0
    800066bc:	00008067          	ret
    800066c0:	fe010113          	addi	sp,sp,-32
    800066c4:	00813823          	sd	s0,16(sp)
    800066c8:	00913423          	sd	s1,8(sp)
    800066cc:	00113c23          	sd	ra,24(sp)
    800066d0:	02010413          	addi	s0,sp,32
    800066d4:	01053483          	ld	s1,16(a0)
    800066d8:	ffffe097          	auipc	ra,0xffffe
    800066dc:	75c080e7          	jalr	1884(ra) # 80004e34 <mycpu>
    800066e0:	01813083          	ld	ra,24(sp)
    800066e4:	01013403          	ld	s0,16(sp)
    800066e8:	40a48533          	sub	a0,s1,a0
    800066ec:	00153513          	seqz	a0,a0
    800066f0:	00813483          	ld	s1,8(sp)
    800066f4:	02010113          	addi	sp,sp,32
    800066f8:	00008067          	ret

00000000800066fc <push_off>:
    800066fc:	fe010113          	addi	sp,sp,-32
    80006700:	00813823          	sd	s0,16(sp)
    80006704:	00113c23          	sd	ra,24(sp)
    80006708:	00913423          	sd	s1,8(sp)
    8000670c:	02010413          	addi	s0,sp,32
    80006710:	100024f3          	csrr	s1,sstatus
    80006714:	100027f3          	csrr	a5,sstatus
    80006718:	ffd7f793          	andi	a5,a5,-3
    8000671c:	10079073          	csrw	sstatus,a5
    80006720:	ffffe097          	auipc	ra,0xffffe
    80006724:	714080e7          	jalr	1812(ra) # 80004e34 <mycpu>
    80006728:	07852783          	lw	a5,120(a0)
    8000672c:	02078663          	beqz	a5,80006758 <push_off+0x5c>
    80006730:	ffffe097          	auipc	ra,0xffffe
    80006734:	704080e7          	jalr	1796(ra) # 80004e34 <mycpu>
    80006738:	07852783          	lw	a5,120(a0)
    8000673c:	01813083          	ld	ra,24(sp)
    80006740:	01013403          	ld	s0,16(sp)
    80006744:	0017879b          	addiw	a5,a5,1
    80006748:	06f52c23          	sw	a5,120(a0)
    8000674c:	00813483          	ld	s1,8(sp)
    80006750:	02010113          	addi	sp,sp,32
    80006754:	00008067          	ret
    80006758:	0014d493          	srli	s1,s1,0x1
    8000675c:	ffffe097          	auipc	ra,0xffffe
    80006760:	6d8080e7          	jalr	1752(ra) # 80004e34 <mycpu>
    80006764:	0014f493          	andi	s1,s1,1
    80006768:	06952e23          	sw	s1,124(a0)
    8000676c:	fc5ff06f          	j	80006730 <push_off+0x34>

0000000080006770 <pop_off>:
    80006770:	ff010113          	addi	sp,sp,-16
    80006774:	00813023          	sd	s0,0(sp)
    80006778:	00113423          	sd	ra,8(sp)
    8000677c:	01010413          	addi	s0,sp,16
    80006780:	ffffe097          	auipc	ra,0xffffe
    80006784:	6b4080e7          	jalr	1716(ra) # 80004e34 <mycpu>
    80006788:	100027f3          	csrr	a5,sstatus
    8000678c:	0027f793          	andi	a5,a5,2
    80006790:	04079663          	bnez	a5,800067dc <pop_off+0x6c>
    80006794:	07852783          	lw	a5,120(a0)
    80006798:	02f05a63          	blez	a5,800067cc <pop_off+0x5c>
    8000679c:	fff7871b          	addiw	a4,a5,-1
    800067a0:	06e52c23          	sw	a4,120(a0)
    800067a4:	00071c63          	bnez	a4,800067bc <pop_off+0x4c>
    800067a8:	07c52783          	lw	a5,124(a0)
    800067ac:	00078863          	beqz	a5,800067bc <pop_off+0x4c>
    800067b0:	100027f3          	csrr	a5,sstatus
    800067b4:	0027e793          	ori	a5,a5,2
    800067b8:	10079073          	csrw	sstatus,a5
    800067bc:	00813083          	ld	ra,8(sp)
    800067c0:	00013403          	ld	s0,0(sp)
    800067c4:	01010113          	addi	sp,sp,16
    800067c8:	00008067          	ret
    800067cc:	00001517          	auipc	a0,0x1
    800067d0:	f3c50513          	addi	a0,a0,-196 # 80007708 <digits+0x48>
    800067d4:	fffff097          	auipc	ra,0xfffff
    800067d8:	018080e7          	jalr	24(ra) # 800057ec <panic>
    800067dc:	00001517          	auipc	a0,0x1
    800067e0:	f1450513          	addi	a0,a0,-236 # 800076f0 <digits+0x30>
    800067e4:	fffff097          	auipc	ra,0xfffff
    800067e8:	008080e7          	jalr	8(ra) # 800057ec <panic>

00000000800067ec <push_on>:
    800067ec:	fe010113          	addi	sp,sp,-32
    800067f0:	00813823          	sd	s0,16(sp)
    800067f4:	00113c23          	sd	ra,24(sp)
    800067f8:	00913423          	sd	s1,8(sp)
    800067fc:	02010413          	addi	s0,sp,32
    80006800:	100024f3          	csrr	s1,sstatus
    80006804:	100027f3          	csrr	a5,sstatus
    80006808:	0027e793          	ori	a5,a5,2
    8000680c:	10079073          	csrw	sstatus,a5
    80006810:	ffffe097          	auipc	ra,0xffffe
    80006814:	624080e7          	jalr	1572(ra) # 80004e34 <mycpu>
    80006818:	07852783          	lw	a5,120(a0)
    8000681c:	02078663          	beqz	a5,80006848 <push_on+0x5c>
    80006820:	ffffe097          	auipc	ra,0xffffe
    80006824:	614080e7          	jalr	1556(ra) # 80004e34 <mycpu>
    80006828:	07852783          	lw	a5,120(a0)
    8000682c:	01813083          	ld	ra,24(sp)
    80006830:	01013403          	ld	s0,16(sp)
    80006834:	0017879b          	addiw	a5,a5,1
    80006838:	06f52c23          	sw	a5,120(a0)
    8000683c:	00813483          	ld	s1,8(sp)
    80006840:	02010113          	addi	sp,sp,32
    80006844:	00008067          	ret
    80006848:	0014d493          	srli	s1,s1,0x1
    8000684c:	ffffe097          	auipc	ra,0xffffe
    80006850:	5e8080e7          	jalr	1512(ra) # 80004e34 <mycpu>
    80006854:	0014f493          	andi	s1,s1,1
    80006858:	06952e23          	sw	s1,124(a0)
    8000685c:	fc5ff06f          	j	80006820 <push_on+0x34>

0000000080006860 <pop_on>:
    80006860:	ff010113          	addi	sp,sp,-16
    80006864:	00813023          	sd	s0,0(sp)
    80006868:	00113423          	sd	ra,8(sp)
    8000686c:	01010413          	addi	s0,sp,16
    80006870:	ffffe097          	auipc	ra,0xffffe
    80006874:	5c4080e7          	jalr	1476(ra) # 80004e34 <mycpu>
    80006878:	100027f3          	csrr	a5,sstatus
    8000687c:	0027f793          	andi	a5,a5,2
    80006880:	04078463          	beqz	a5,800068c8 <pop_on+0x68>
    80006884:	07852783          	lw	a5,120(a0)
    80006888:	02f05863          	blez	a5,800068b8 <pop_on+0x58>
    8000688c:	fff7879b          	addiw	a5,a5,-1
    80006890:	06f52c23          	sw	a5,120(a0)
    80006894:	07853783          	ld	a5,120(a0)
    80006898:	00079863          	bnez	a5,800068a8 <pop_on+0x48>
    8000689c:	100027f3          	csrr	a5,sstatus
    800068a0:	ffd7f793          	andi	a5,a5,-3
    800068a4:	10079073          	csrw	sstatus,a5
    800068a8:	00813083          	ld	ra,8(sp)
    800068ac:	00013403          	ld	s0,0(sp)
    800068b0:	01010113          	addi	sp,sp,16
    800068b4:	00008067          	ret
    800068b8:	00001517          	auipc	a0,0x1
    800068bc:	e7850513          	addi	a0,a0,-392 # 80007730 <digits+0x70>
    800068c0:	fffff097          	auipc	ra,0xfffff
    800068c4:	f2c080e7          	jalr	-212(ra) # 800057ec <panic>
    800068c8:	00001517          	auipc	a0,0x1
    800068cc:	e4850513          	addi	a0,a0,-440 # 80007710 <digits+0x50>
    800068d0:	fffff097          	auipc	ra,0xfffff
    800068d4:	f1c080e7          	jalr	-228(ra) # 800057ec <panic>

00000000800068d8 <__memset>:
    800068d8:	ff010113          	addi	sp,sp,-16
    800068dc:	00813423          	sd	s0,8(sp)
    800068e0:	01010413          	addi	s0,sp,16
    800068e4:	1a060e63          	beqz	a2,80006aa0 <__memset+0x1c8>
    800068e8:	40a007b3          	neg	a5,a0
    800068ec:	0077f793          	andi	a5,a5,7
    800068f0:	00778693          	addi	a3,a5,7
    800068f4:	00b00813          	li	a6,11
    800068f8:	0ff5f593          	andi	a1,a1,255
    800068fc:	fff6071b          	addiw	a4,a2,-1
    80006900:	1b06e663          	bltu	a3,a6,80006aac <__memset+0x1d4>
    80006904:	1cd76463          	bltu	a4,a3,80006acc <__memset+0x1f4>
    80006908:	1a078e63          	beqz	a5,80006ac4 <__memset+0x1ec>
    8000690c:	00b50023          	sb	a1,0(a0)
    80006910:	00100713          	li	a4,1
    80006914:	1ae78463          	beq	a5,a4,80006abc <__memset+0x1e4>
    80006918:	00b500a3          	sb	a1,1(a0)
    8000691c:	00200713          	li	a4,2
    80006920:	1ae78a63          	beq	a5,a4,80006ad4 <__memset+0x1fc>
    80006924:	00b50123          	sb	a1,2(a0)
    80006928:	00300713          	li	a4,3
    8000692c:	18e78463          	beq	a5,a4,80006ab4 <__memset+0x1dc>
    80006930:	00b501a3          	sb	a1,3(a0)
    80006934:	00400713          	li	a4,4
    80006938:	1ae78263          	beq	a5,a4,80006adc <__memset+0x204>
    8000693c:	00b50223          	sb	a1,4(a0)
    80006940:	00500713          	li	a4,5
    80006944:	1ae78063          	beq	a5,a4,80006ae4 <__memset+0x20c>
    80006948:	00b502a3          	sb	a1,5(a0)
    8000694c:	00700713          	li	a4,7
    80006950:	18e79e63          	bne	a5,a4,80006aec <__memset+0x214>
    80006954:	00b50323          	sb	a1,6(a0)
    80006958:	00700e93          	li	t4,7
    8000695c:	00859713          	slli	a4,a1,0x8
    80006960:	00e5e733          	or	a4,a1,a4
    80006964:	01059e13          	slli	t3,a1,0x10
    80006968:	01c76e33          	or	t3,a4,t3
    8000696c:	01859313          	slli	t1,a1,0x18
    80006970:	006e6333          	or	t1,t3,t1
    80006974:	02059893          	slli	a7,a1,0x20
    80006978:	40f60e3b          	subw	t3,a2,a5
    8000697c:	011368b3          	or	a7,t1,a7
    80006980:	02859813          	slli	a6,a1,0x28
    80006984:	0108e833          	or	a6,a7,a6
    80006988:	03059693          	slli	a3,a1,0x30
    8000698c:	003e589b          	srliw	a7,t3,0x3
    80006990:	00d866b3          	or	a3,a6,a3
    80006994:	03859713          	slli	a4,a1,0x38
    80006998:	00389813          	slli	a6,a7,0x3
    8000699c:	00f507b3          	add	a5,a0,a5
    800069a0:	00e6e733          	or	a4,a3,a4
    800069a4:	000e089b          	sext.w	a7,t3
    800069a8:	00f806b3          	add	a3,a6,a5
    800069ac:	00e7b023          	sd	a4,0(a5)
    800069b0:	00878793          	addi	a5,a5,8
    800069b4:	fed79ce3          	bne	a5,a3,800069ac <__memset+0xd4>
    800069b8:	ff8e7793          	andi	a5,t3,-8
    800069bc:	0007871b          	sext.w	a4,a5
    800069c0:	01d787bb          	addw	a5,a5,t4
    800069c4:	0ce88e63          	beq	a7,a4,80006aa0 <__memset+0x1c8>
    800069c8:	00f50733          	add	a4,a0,a5
    800069cc:	00b70023          	sb	a1,0(a4)
    800069d0:	0017871b          	addiw	a4,a5,1
    800069d4:	0cc77663          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    800069d8:	00e50733          	add	a4,a0,a4
    800069dc:	00b70023          	sb	a1,0(a4)
    800069e0:	0027871b          	addiw	a4,a5,2
    800069e4:	0ac77e63          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    800069e8:	00e50733          	add	a4,a0,a4
    800069ec:	00b70023          	sb	a1,0(a4)
    800069f0:	0037871b          	addiw	a4,a5,3
    800069f4:	0ac77663          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    800069f8:	00e50733          	add	a4,a0,a4
    800069fc:	00b70023          	sb	a1,0(a4)
    80006a00:	0047871b          	addiw	a4,a5,4
    80006a04:	08c77e63          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a08:	00e50733          	add	a4,a0,a4
    80006a0c:	00b70023          	sb	a1,0(a4)
    80006a10:	0057871b          	addiw	a4,a5,5
    80006a14:	08c77663          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a18:	00e50733          	add	a4,a0,a4
    80006a1c:	00b70023          	sb	a1,0(a4)
    80006a20:	0067871b          	addiw	a4,a5,6
    80006a24:	06c77e63          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a28:	00e50733          	add	a4,a0,a4
    80006a2c:	00b70023          	sb	a1,0(a4)
    80006a30:	0077871b          	addiw	a4,a5,7
    80006a34:	06c77663          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a38:	00e50733          	add	a4,a0,a4
    80006a3c:	00b70023          	sb	a1,0(a4)
    80006a40:	0087871b          	addiw	a4,a5,8
    80006a44:	04c77e63          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a48:	00e50733          	add	a4,a0,a4
    80006a4c:	00b70023          	sb	a1,0(a4)
    80006a50:	0097871b          	addiw	a4,a5,9
    80006a54:	04c77663          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a58:	00e50733          	add	a4,a0,a4
    80006a5c:	00b70023          	sb	a1,0(a4)
    80006a60:	00a7871b          	addiw	a4,a5,10
    80006a64:	02c77e63          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a68:	00e50733          	add	a4,a0,a4
    80006a6c:	00b70023          	sb	a1,0(a4)
    80006a70:	00b7871b          	addiw	a4,a5,11
    80006a74:	02c77663          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a78:	00e50733          	add	a4,a0,a4
    80006a7c:	00b70023          	sb	a1,0(a4)
    80006a80:	00c7871b          	addiw	a4,a5,12
    80006a84:	00c77e63          	bgeu	a4,a2,80006aa0 <__memset+0x1c8>
    80006a88:	00e50733          	add	a4,a0,a4
    80006a8c:	00b70023          	sb	a1,0(a4)
    80006a90:	00d7879b          	addiw	a5,a5,13
    80006a94:	00c7f663          	bgeu	a5,a2,80006aa0 <__memset+0x1c8>
    80006a98:	00f507b3          	add	a5,a0,a5
    80006a9c:	00b78023          	sb	a1,0(a5)
    80006aa0:	00813403          	ld	s0,8(sp)
    80006aa4:	01010113          	addi	sp,sp,16
    80006aa8:	00008067          	ret
    80006aac:	00b00693          	li	a3,11
    80006ab0:	e55ff06f          	j	80006904 <__memset+0x2c>
    80006ab4:	00300e93          	li	t4,3
    80006ab8:	ea5ff06f          	j	8000695c <__memset+0x84>
    80006abc:	00100e93          	li	t4,1
    80006ac0:	e9dff06f          	j	8000695c <__memset+0x84>
    80006ac4:	00000e93          	li	t4,0
    80006ac8:	e95ff06f          	j	8000695c <__memset+0x84>
    80006acc:	00000793          	li	a5,0
    80006ad0:	ef9ff06f          	j	800069c8 <__memset+0xf0>
    80006ad4:	00200e93          	li	t4,2
    80006ad8:	e85ff06f          	j	8000695c <__memset+0x84>
    80006adc:	00400e93          	li	t4,4
    80006ae0:	e7dff06f          	j	8000695c <__memset+0x84>
    80006ae4:	00500e93          	li	t4,5
    80006ae8:	e75ff06f          	j	8000695c <__memset+0x84>
    80006aec:	00600e93          	li	t4,6
    80006af0:	e6dff06f          	j	8000695c <__memset+0x84>

0000000080006af4 <__memmove>:
    80006af4:	ff010113          	addi	sp,sp,-16
    80006af8:	00813423          	sd	s0,8(sp)
    80006afc:	01010413          	addi	s0,sp,16
    80006b00:	0e060863          	beqz	a2,80006bf0 <__memmove+0xfc>
    80006b04:	fff6069b          	addiw	a3,a2,-1
    80006b08:	0006881b          	sext.w	a6,a3
    80006b0c:	0ea5e863          	bltu	a1,a0,80006bfc <__memmove+0x108>
    80006b10:	00758713          	addi	a4,a1,7
    80006b14:	00a5e7b3          	or	a5,a1,a0
    80006b18:	40a70733          	sub	a4,a4,a0
    80006b1c:	0077f793          	andi	a5,a5,7
    80006b20:	00f73713          	sltiu	a4,a4,15
    80006b24:	00174713          	xori	a4,a4,1
    80006b28:	0017b793          	seqz	a5,a5
    80006b2c:	00e7f7b3          	and	a5,a5,a4
    80006b30:	10078863          	beqz	a5,80006c40 <__memmove+0x14c>
    80006b34:	00900793          	li	a5,9
    80006b38:	1107f463          	bgeu	a5,a6,80006c40 <__memmove+0x14c>
    80006b3c:	0036581b          	srliw	a6,a2,0x3
    80006b40:	fff8081b          	addiw	a6,a6,-1
    80006b44:	02081813          	slli	a6,a6,0x20
    80006b48:	01d85893          	srli	a7,a6,0x1d
    80006b4c:	00858813          	addi	a6,a1,8
    80006b50:	00058793          	mv	a5,a1
    80006b54:	00050713          	mv	a4,a0
    80006b58:	01088833          	add	a6,a7,a6
    80006b5c:	0007b883          	ld	a7,0(a5)
    80006b60:	00878793          	addi	a5,a5,8
    80006b64:	00870713          	addi	a4,a4,8
    80006b68:	ff173c23          	sd	a7,-8(a4)
    80006b6c:	ff0798e3          	bne	a5,a6,80006b5c <__memmove+0x68>
    80006b70:	ff867713          	andi	a4,a2,-8
    80006b74:	02071793          	slli	a5,a4,0x20
    80006b78:	0207d793          	srli	a5,a5,0x20
    80006b7c:	00f585b3          	add	a1,a1,a5
    80006b80:	40e686bb          	subw	a3,a3,a4
    80006b84:	00f507b3          	add	a5,a0,a5
    80006b88:	06e60463          	beq	a2,a4,80006bf0 <__memmove+0xfc>
    80006b8c:	0005c703          	lbu	a4,0(a1)
    80006b90:	00e78023          	sb	a4,0(a5)
    80006b94:	04068e63          	beqz	a3,80006bf0 <__memmove+0xfc>
    80006b98:	0015c603          	lbu	a2,1(a1)
    80006b9c:	00100713          	li	a4,1
    80006ba0:	00c780a3          	sb	a2,1(a5)
    80006ba4:	04e68663          	beq	a3,a4,80006bf0 <__memmove+0xfc>
    80006ba8:	0025c603          	lbu	a2,2(a1)
    80006bac:	00200713          	li	a4,2
    80006bb0:	00c78123          	sb	a2,2(a5)
    80006bb4:	02e68e63          	beq	a3,a4,80006bf0 <__memmove+0xfc>
    80006bb8:	0035c603          	lbu	a2,3(a1)
    80006bbc:	00300713          	li	a4,3
    80006bc0:	00c781a3          	sb	a2,3(a5)
    80006bc4:	02e68663          	beq	a3,a4,80006bf0 <__memmove+0xfc>
    80006bc8:	0045c603          	lbu	a2,4(a1)
    80006bcc:	00400713          	li	a4,4
    80006bd0:	00c78223          	sb	a2,4(a5)
    80006bd4:	00e68e63          	beq	a3,a4,80006bf0 <__memmove+0xfc>
    80006bd8:	0055c603          	lbu	a2,5(a1)
    80006bdc:	00500713          	li	a4,5
    80006be0:	00c782a3          	sb	a2,5(a5)
    80006be4:	00e68663          	beq	a3,a4,80006bf0 <__memmove+0xfc>
    80006be8:	0065c703          	lbu	a4,6(a1)
    80006bec:	00e78323          	sb	a4,6(a5)
    80006bf0:	00813403          	ld	s0,8(sp)
    80006bf4:	01010113          	addi	sp,sp,16
    80006bf8:	00008067          	ret
    80006bfc:	02061713          	slli	a4,a2,0x20
    80006c00:	02075713          	srli	a4,a4,0x20
    80006c04:	00e587b3          	add	a5,a1,a4
    80006c08:	f0f574e3          	bgeu	a0,a5,80006b10 <__memmove+0x1c>
    80006c0c:	02069613          	slli	a2,a3,0x20
    80006c10:	02065613          	srli	a2,a2,0x20
    80006c14:	fff64613          	not	a2,a2
    80006c18:	00e50733          	add	a4,a0,a4
    80006c1c:	00c78633          	add	a2,a5,a2
    80006c20:	fff7c683          	lbu	a3,-1(a5)
    80006c24:	fff78793          	addi	a5,a5,-1
    80006c28:	fff70713          	addi	a4,a4,-1
    80006c2c:	00d70023          	sb	a3,0(a4)
    80006c30:	fec798e3          	bne	a5,a2,80006c20 <__memmove+0x12c>
    80006c34:	00813403          	ld	s0,8(sp)
    80006c38:	01010113          	addi	sp,sp,16
    80006c3c:	00008067          	ret
    80006c40:	02069713          	slli	a4,a3,0x20
    80006c44:	02075713          	srli	a4,a4,0x20
    80006c48:	00170713          	addi	a4,a4,1
    80006c4c:	00e50733          	add	a4,a0,a4
    80006c50:	00050793          	mv	a5,a0
    80006c54:	0005c683          	lbu	a3,0(a1)
    80006c58:	00178793          	addi	a5,a5,1
    80006c5c:	00158593          	addi	a1,a1,1
    80006c60:	fed78fa3          	sb	a3,-1(a5)
    80006c64:	fee798e3          	bne	a5,a4,80006c54 <__memmove+0x160>
    80006c68:	f89ff06f          	j	80006bf0 <__memmove+0xfc>
	...

Disassembly of section .user:

000000008000e4a0 <copy_and_swap-0xb60>:
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
    8000f43c:	a34080e7          	jalr	-1484(ra) # 80010e6c <_Znwm>
    8000f440:	00050913          	mv	s2,a0
    8000f444:	00050863          	beqz	a0,8000f454 <_ZN9BufferCPPC1Ei+0x68>
    8000f448:	00000593          	li	a1,0
    8000f44c:	00002097          	auipc	ra,0x2
    8000f450:	b18080e7          	jalr	-1256(ra) # 80010f64 <_ZN9SemaphoreC1Ej>
    8000f454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000f458:	01000513          	li	a0,16
    8000f45c:	00002097          	auipc	ra,0x2
    8000f460:	a10080e7          	jalr	-1520(ra) # 80010e6c <_Znwm>
    8000f464:	00050913          	mv	s2,a0
    8000f468:	00050863          	beqz	a0,8000f478 <_ZN9BufferCPPC1Ei+0x8c>
    8000f46c:	00098593          	mv	a1,s3
    8000f470:	00002097          	auipc	ra,0x2
    8000f474:	af4080e7          	jalr	-1292(ra) # 80010f64 <_ZN9SemaphoreC1Ej>
    8000f478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000f47c:	01000513          	li	a0,16
    8000f480:	00002097          	auipc	ra,0x2
    8000f484:	9ec080e7          	jalr	-1556(ra) # 80010e6c <_Znwm>
    8000f488:	00050913          	mv	s2,a0
    8000f48c:	00050863          	beqz	a0,8000f49c <_ZN9BufferCPPC1Ei+0xb0>
    8000f490:	00100593          	li	a1,1
    8000f494:	00002097          	auipc	ra,0x2
    8000f498:	ad0080e7          	jalr	-1328(ra) # 80010f64 <_ZN9SemaphoreC1Ej>
    8000f49c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000f4a0:	01000513          	li	a0,16
    8000f4a4:	00002097          	auipc	ra,0x2
    8000f4a8:	9c8080e7          	jalr	-1592(ra) # 80010e6c <_Znwm>
    8000f4ac:	00050913          	mv	s2,a0
    8000f4b0:	00050863          	beqz	a0,8000f4c0 <_ZN9BufferCPPC1Ei+0xd4>
    8000f4b4:	00100593          	li	a1,1
    8000f4b8:	00002097          	auipc	ra,0x2
    8000f4bc:	aac080e7          	jalr	-1364(ra) # 80010f64 <_ZN9SemaphoreC1Ej>
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
    8000f4e8:	00002097          	auipc	ra,0x2
    8000f4ec:	9d4080e7          	jalr	-1580(ra) # 80010ebc <_ZdlPv>
    8000f4f0:	00048513          	mv	a0,s1
    8000f4f4:	ffffe097          	auipc	ra,0xffffe
    8000f4f8:	a04080e7          	jalr	-1532(ra) # 8000cef8 <_Unwind_Resume>
    8000f4fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000f500:	00090513          	mv	a0,s2
    8000f504:	00002097          	auipc	ra,0x2
    8000f508:	9b8080e7          	jalr	-1608(ra) # 80010ebc <_ZdlPv>
    8000f50c:	00048513          	mv	a0,s1
    8000f510:	ffffe097          	auipc	ra,0xffffe
    8000f514:	9e8080e7          	jalr	-1560(ra) # 8000cef8 <_Unwind_Resume>
    8000f518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000f51c:	00090513          	mv	a0,s2
    8000f520:	00002097          	auipc	ra,0x2
    8000f524:	99c080e7          	jalr	-1636(ra) # 80010ebc <_ZdlPv>
    8000f528:	00048513          	mv	a0,s1
    8000f52c:	ffffe097          	auipc	ra,0xffffe
    8000f530:	9cc080e7          	jalr	-1588(ra) # 8000cef8 <_Unwind_Resume>
    8000f534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000f538:	00090513          	mv	a0,s2
    8000f53c:	00002097          	auipc	ra,0x2
    8000f540:	980080e7          	jalr	-1664(ra) # 80010ebc <_ZdlPv>
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
    8000f578:	a28080e7          	jalr	-1496(ra) # 80010f9c <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000f57c:	0304b503          	ld	a0,48(s1)
    8000f580:	00002097          	auipc	ra,0x2
    8000f584:	a1c080e7          	jalr	-1508(ra) # 80010f9c <_ZN9Semaphore4waitEv>
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
    8000f5b4:	00002097          	auipc	ra,0x2
    8000f5b8:	a14080e7          	jalr	-1516(ra) # 80010fc8 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000f5bc:	0204b503          	ld	a0,32(s1)
    8000f5c0:	00002097          	auipc	ra,0x2
    8000f5c4:	a08080e7          	jalr	-1528(ra) # 80010fc8 <_ZN9Semaphore6signalEv>

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
    8000f600:	00002097          	auipc	ra,0x2
    8000f604:	99c080e7          	jalr	-1636(ra) # 80010f9c <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000f608:	0284b503          	ld	a0,40(s1)
    8000f60c:	00002097          	auipc	ra,0x2
    8000f610:	990080e7          	jalr	-1648(ra) # 80010f9c <_ZN9Semaphore4waitEv>

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
    8000f63c:	00002097          	auipc	ra,0x2
    8000f640:	98c080e7          	jalr	-1652(ra) # 80010fc8 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000f644:	0184b503          	ld	a0,24(s1)
    8000f648:	00002097          	auipc	ra,0x2
    8000f64c:	980080e7          	jalr	-1664(ra) # 80010fc8 <_ZN9Semaphore6signalEv>

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
    8000f68c:	00002097          	auipc	ra,0x2
    8000f690:	910080e7          	jalr	-1776(ra) # 80010f9c <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000f694:	0304b503          	ld	a0,48(s1)
    8000f698:	00002097          	auipc	ra,0x2
    8000f69c:	904080e7          	jalr	-1788(ra) # 80010f9c <_ZN9Semaphore4waitEv>

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
    8000f6b4:	00002097          	auipc	ra,0x2
    8000f6b8:	914080e7          	jalr	-1772(ra) # 80010fc8 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000f6bc:	0284b503          	ld	a0,40(s1)
    8000f6c0:	00002097          	auipc	ra,0x2
    8000f6c4:	908080e7          	jalr	-1784(ra) # 80010fc8 <_ZN9Semaphore6signalEv>

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
    8000f714:	af0080e7          	jalr	-1296(ra) # 80011200 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000f718:	00003517          	auipc	a0,0x3
    8000f71c:	8e850513          	addi	a0,a0,-1816 # 80012000 <userDataStart>
    8000f720:	00001097          	auipc	ra,0x1
    8000f724:	3fc080e7          	jalr	1020(ra) # 80010b1c <_Z11printStringPKc>
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
    8000f750:	ab4080e7          	jalr	-1356(ra) # 80011200 <_ZN7Console4putcEc>
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
    8000f774:	a90080e7          	jalr	-1392(ra) # 80011200 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000f778:	00a00513          	li	a0,10
    8000f77c:	00002097          	auipc	ra,0x2
    8000f780:	a84080e7          	jalr	-1404(ra) # 80011200 <_ZN7Console4putcEc>
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
    8000f85c:	2c4080e7          	jalr	708(ra) # 80010b1c <_Z11printStringPKc>
    8000f860:	00000613          	li	a2,0
    8000f864:	00a00593          	li	a1,10
    8000f868:	0009051b          	sext.w	a0,s2
    8000f86c:	00001097          	auipc	ra,0x1
    8000f870:	448080e7          	jalr	1096(ra) # 80010cb4 <_Z8printIntiii>
    8000f874:	00003517          	auipc	a0,0x3
    8000f878:	8e450513          	addi	a0,a0,-1820 # 80012158 <userDataStart+0x158>
    8000f87c:	00001097          	auipc	ra,0x1
    8000f880:	2a0080e7          	jalr	672(ra) # 80010b1c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000f884:	00000493          	li	s1,0
    8000f888:	f99ff06f          	j	8000f820 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000f88c:	00002517          	auipc	a0,0x2
    8000f890:	79450513          	addi	a0,a0,1940 # 80012020 <userDataStart+0x20>
    8000f894:	00001097          	auipc	ra,0x1
    8000f898:	288080e7          	jalr	648(ra) # 80010b1c <_Z11printStringPKc>
    finishedA = true;
    8000f89c:	00100793          	li	a5,1
    8000f8a0:	00003717          	auipc	a4,0x3
    8000f8a4:	aef70023          	sb	a5,-1312(a4) # 80012380 <finishedA>
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
    8000f928:	1f8080e7          	jalr	504(ra) # 80010b1c <_Z11printStringPKc>
    8000f92c:	00000613          	li	a2,0
    8000f930:	00a00593          	li	a1,10
    8000f934:	0009051b          	sext.w	a0,s2
    8000f938:	00001097          	auipc	ra,0x1
    8000f93c:	37c080e7          	jalr	892(ra) # 80010cb4 <_Z8printIntiii>
    8000f940:	00003517          	auipc	a0,0x3
    8000f944:	81850513          	addi	a0,a0,-2024 # 80012158 <userDataStart+0x158>
    8000f948:	00001097          	auipc	ra,0x1
    8000f94c:	1d4080e7          	jalr	468(ra) # 80010b1c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000f950:	00000493          	li	s1,0
    8000f954:	f99ff06f          	j	8000f8ec <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000f958:	00002517          	auipc	a0,0x2
    8000f95c:	6e050513          	addi	a0,a0,1760 # 80012038 <userDataStart+0x38>
    8000f960:	00001097          	auipc	ra,0x1
    8000f964:	1bc080e7          	jalr	444(ra) # 80010b1c <_Z11printStringPKc>
    finishedB = true;
    8000f968:	00100793          	li	a5,1
    8000f96c:	00003717          	auipc	a4,0x3
    8000f970:	a0f70aa3          	sb	a5,-1515(a4) # 80012381 <finishedB>
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

000000008000f994 <_Z9sleepyRunPv>:

#include "../../../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    8000f994:	fe010113          	addi	sp,sp,-32
    8000f998:	00113c23          	sd	ra,24(sp)
    8000f99c:	00813823          	sd	s0,16(sp)
    8000f9a0:	00913423          	sd	s1,8(sp)
    8000f9a4:	01213023          	sd	s2,0(sp)
    8000f9a8:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    8000f9ac:	00053903          	ld	s2,0(a0)
    int i = 6;
    8000f9b0:	00600493          	li	s1,6
    while (--i > 0) {
    8000f9b4:	fff4849b          	addiw	s1,s1,-1
    8000f9b8:	04905463          	blez	s1,8000fa00 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    8000f9bc:	00002517          	auipc	a0,0x2
    8000f9c0:	68c50513          	addi	a0,a0,1676 # 80012048 <userDataStart+0x48>
    8000f9c4:	00001097          	auipc	ra,0x1
    8000f9c8:	158080e7          	jalr	344(ra) # 80010b1c <_Z11printStringPKc>
        printInt(sleep_time);
    8000f9cc:	00000613          	li	a2,0
    8000f9d0:	00a00593          	li	a1,10
    8000f9d4:	0009051b          	sext.w	a0,s2
    8000f9d8:	00001097          	auipc	ra,0x1
    8000f9dc:	2dc080e7          	jalr	732(ra) # 80010cb4 <_Z8printIntiii>
        printString(" !\n");
    8000f9e0:	00002517          	auipc	a0,0x2
    8000f9e4:	67050513          	addi	a0,a0,1648 # 80012050 <userDataStart+0x50>
    8000f9e8:	00001097          	auipc	ra,0x1
    8000f9ec:	134080e7          	jalr	308(ra) # 80010b1c <_Z11printStringPKc>
        time_sleep(sleep_time);
    8000f9f0:	00090513          	mv	a0,s2
    8000f9f4:	00000097          	auipc	ra,0x0
    8000f9f8:	8e4080e7          	jalr	-1820(ra) # 8000f2d8 <_Z10time_sleepm>
    while (--i > 0) {
    8000f9fc:	fb9ff06f          	j	8000f9b4 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    8000fa00:	00a00793          	li	a5,10
    8000fa04:	02f95933          	divu	s2,s2,a5
    8000fa08:	fff90913          	addi	s2,s2,-1
    8000fa0c:	00003797          	auipc	a5,0x3
    8000fa10:	97478793          	addi	a5,a5,-1676 # 80012380 <finishedA>
    8000fa14:	01278933          	add	s2,a5,s2
    8000fa18:	00100793          	li	a5,1
    8000fa1c:	00f90423          	sb	a5,8(s2)
}
    8000fa20:	01813083          	ld	ra,24(sp)
    8000fa24:	01013403          	ld	s0,16(sp)
    8000fa28:	00813483          	ld	s1,8(sp)
    8000fa2c:	00013903          	ld	s2,0(sp)
    8000fa30:	02010113          	addi	sp,sp,32
    8000fa34:	00008067          	ret

000000008000fa38 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    8000fa38:	fe010113          	addi	sp,sp,-32
    8000fa3c:	00113c23          	sd	ra,24(sp)
    8000fa40:	00813823          	sd	s0,16(sp)
    8000fa44:	00913423          	sd	s1,8(sp)
    8000fa48:	01213023          	sd	s2,0(sp)
    8000fa4c:	02010413          	addi	s0,sp,32
    8000fa50:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000fa54:	00100793          	li	a5,1
    8000fa58:	02a7f863          	bgeu	a5,a0,8000fa88 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000fa5c:	00a00793          	li	a5,10
    8000fa60:	02f577b3          	remu	a5,a0,a5
    8000fa64:	02078e63          	beqz	a5,8000faa0 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000fa68:	fff48513          	addi	a0,s1,-1
    8000fa6c:	00000097          	auipc	ra,0x0
    8000fa70:	fcc080e7          	jalr	-52(ra) # 8000fa38 <_Z9fibonaccim>
    8000fa74:	00050913          	mv	s2,a0
    8000fa78:	ffe48513          	addi	a0,s1,-2
    8000fa7c:	00000097          	auipc	ra,0x0
    8000fa80:	fbc080e7          	jalr	-68(ra) # 8000fa38 <_Z9fibonaccim>
    8000fa84:	00a90533          	add	a0,s2,a0
}
    8000fa88:	01813083          	ld	ra,24(sp)
    8000fa8c:	01013403          	ld	s0,16(sp)
    8000fa90:	00813483          	ld	s1,8(sp)
    8000fa94:	00013903          	ld	s2,0(sp)
    8000fa98:	02010113          	addi	sp,sp,32
    8000fa9c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000faa0:	fffff097          	auipc	ra,0xfffff
    8000faa4:	690080e7          	jalr	1680(ra) # 8000f130 <_Z15thread_dispatchv>
    8000faa8:	fc1ff06f          	j	8000fa68 <_Z9fibonaccim+0x30>

000000008000faac <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    8000faac:	fe010113          	addi	sp,sp,-32
    8000fab0:	00113c23          	sd	ra,24(sp)
    8000fab4:	00813823          	sd	s0,16(sp)
    8000fab8:	00913423          	sd	s1,8(sp)
    8000fabc:	01213023          	sd	s2,0(sp)
    8000fac0:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000fac4:	00000493          	li	s1,0
    8000fac8:	0400006f          	j	8000fb08 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000facc:	00002517          	auipc	a0,0x2
    8000fad0:	58c50513          	addi	a0,a0,1420 # 80012058 <userDataStart+0x58>
    8000fad4:	00001097          	auipc	ra,0x1
    8000fad8:	048080e7          	jalr	72(ra) # 80010b1c <_Z11printStringPKc>
    8000fadc:	00000613          	li	a2,0
    8000fae0:	00a00593          	li	a1,10
    8000fae4:	00048513          	mv	a0,s1
    8000fae8:	00001097          	auipc	ra,0x1
    8000faec:	1cc080e7          	jalr	460(ra) # 80010cb4 <_Z8printIntiii>
    8000faf0:	00002517          	auipc	a0,0x2
    8000faf4:	66850513          	addi	a0,a0,1640 # 80012158 <userDataStart+0x158>
    8000faf8:	00001097          	auipc	ra,0x1
    8000fafc:	024080e7          	jalr	36(ra) # 80010b1c <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000fb00:	0014849b          	addiw	s1,s1,1
    8000fb04:	0ff4f493          	andi	s1,s1,255
    8000fb08:	00200793          	li	a5,2
    8000fb0c:	fc97f0e3          	bgeu	a5,s1,8000facc <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    8000fb10:	00002517          	auipc	a0,0x2
    8000fb14:	55050513          	addi	a0,a0,1360 # 80012060 <userDataStart+0x60>
    8000fb18:	00001097          	auipc	ra,0x1
    8000fb1c:	004080e7          	jalr	4(ra) # 80010b1c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000fb20:	00700313          	li	t1,7
    thread_dispatch();
    8000fb24:	fffff097          	auipc	ra,0xfffff
    8000fb28:	60c080e7          	jalr	1548(ra) # 8000f130 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000fb2c:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000fb30:	00002517          	auipc	a0,0x2
    8000fb34:	54050513          	addi	a0,a0,1344 # 80012070 <userDataStart+0x70>
    8000fb38:	00001097          	auipc	ra,0x1
    8000fb3c:	fe4080e7          	jalr	-28(ra) # 80010b1c <_Z11printStringPKc>
    8000fb40:	00000613          	li	a2,0
    8000fb44:	00a00593          	li	a1,10
    8000fb48:	0009051b          	sext.w	a0,s2
    8000fb4c:	00001097          	auipc	ra,0x1
    8000fb50:	168080e7          	jalr	360(ra) # 80010cb4 <_Z8printIntiii>
    8000fb54:	00002517          	auipc	a0,0x2
    8000fb58:	60450513          	addi	a0,a0,1540 # 80012158 <userDataStart+0x158>
    8000fb5c:	00001097          	auipc	ra,0x1
    8000fb60:	fc0080e7          	jalr	-64(ra) # 80010b1c <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000fb64:	00c00513          	li	a0,12
    8000fb68:	00000097          	auipc	ra,0x0
    8000fb6c:	ed0080e7          	jalr	-304(ra) # 8000fa38 <_Z9fibonaccim>
    8000fb70:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000fb74:	00002517          	auipc	a0,0x2
    8000fb78:	50450513          	addi	a0,a0,1284 # 80012078 <userDataStart+0x78>
    8000fb7c:	00001097          	auipc	ra,0x1
    8000fb80:	fa0080e7          	jalr	-96(ra) # 80010b1c <_Z11printStringPKc>
    8000fb84:	00000613          	li	a2,0
    8000fb88:	00a00593          	li	a1,10
    8000fb8c:	0009051b          	sext.w	a0,s2
    8000fb90:	00001097          	auipc	ra,0x1
    8000fb94:	124080e7          	jalr	292(ra) # 80010cb4 <_Z8printIntiii>
    8000fb98:	00002517          	auipc	a0,0x2
    8000fb9c:	5c050513          	addi	a0,a0,1472 # 80012158 <userDataStart+0x158>
    8000fba0:	00001097          	auipc	ra,0x1
    8000fba4:	f7c080e7          	jalr	-132(ra) # 80010b1c <_Z11printStringPKc>
    8000fba8:	0400006f          	j	8000fbe8 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000fbac:	00002517          	auipc	a0,0x2
    8000fbb0:	4ac50513          	addi	a0,a0,1196 # 80012058 <userDataStart+0x58>
    8000fbb4:	00001097          	auipc	ra,0x1
    8000fbb8:	f68080e7          	jalr	-152(ra) # 80010b1c <_Z11printStringPKc>
    8000fbbc:	00000613          	li	a2,0
    8000fbc0:	00a00593          	li	a1,10
    8000fbc4:	00048513          	mv	a0,s1
    8000fbc8:	00001097          	auipc	ra,0x1
    8000fbcc:	0ec080e7          	jalr	236(ra) # 80010cb4 <_Z8printIntiii>
    8000fbd0:	00002517          	auipc	a0,0x2
    8000fbd4:	58850513          	addi	a0,a0,1416 # 80012158 <userDataStart+0x158>
    8000fbd8:	00001097          	auipc	ra,0x1
    8000fbdc:	f44080e7          	jalr	-188(ra) # 80010b1c <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000fbe0:	0014849b          	addiw	s1,s1,1
    8000fbe4:	0ff4f493          	andi	s1,s1,255
    8000fbe8:	00500793          	li	a5,5
    8000fbec:	fc97f0e3          	bgeu	a5,s1,8000fbac <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    8000fbf0:	00002517          	auipc	a0,0x2
    8000fbf4:	43050513          	addi	a0,a0,1072 # 80012020 <userDataStart+0x20>
    8000fbf8:	00001097          	auipc	ra,0x1
    8000fbfc:	f24080e7          	jalr	-220(ra) # 80010b1c <_Z11printStringPKc>
    finishedC = true;
    8000fc00:	00100793          	li	a5,1
    8000fc04:	00002717          	auipc	a4,0x2
    8000fc08:	78f70323          	sb	a5,1926(a4) # 8001238a <finishedC>
    thread_dispatch();
    8000fc0c:	fffff097          	auipc	ra,0xfffff
    8000fc10:	524080e7          	jalr	1316(ra) # 8000f130 <_Z15thread_dispatchv>
}
    8000fc14:	01813083          	ld	ra,24(sp)
    8000fc18:	01013403          	ld	s0,16(sp)
    8000fc1c:	00813483          	ld	s1,8(sp)
    8000fc20:	00013903          	ld	s2,0(sp)
    8000fc24:	02010113          	addi	sp,sp,32
    8000fc28:	00008067          	ret

000000008000fc2c <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    8000fc2c:	fe010113          	addi	sp,sp,-32
    8000fc30:	00113c23          	sd	ra,24(sp)
    8000fc34:	00813823          	sd	s0,16(sp)
    8000fc38:	00913423          	sd	s1,8(sp)
    8000fc3c:	01213023          	sd	s2,0(sp)
    8000fc40:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000fc44:	00a00493          	li	s1,10
    8000fc48:	0400006f          	j	8000fc88 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000fc4c:	00002517          	auipc	a0,0x2
    8000fc50:	43c50513          	addi	a0,a0,1084 # 80012088 <userDataStart+0x88>
    8000fc54:	00001097          	auipc	ra,0x1
    8000fc58:	ec8080e7          	jalr	-312(ra) # 80010b1c <_Z11printStringPKc>
    8000fc5c:	00000613          	li	a2,0
    8000fc60:	00a00593          	li	a1,10
    8000fc64:	00048513          	mv	a0,s1
    8000fc68:	00001097          	auipc	ra,0x1
    8000fc6c:	04c080e7          	jalr	76(ra) # 80010cb4 <_Z8printIntiii>
    8000fc70:	00002517          	auipc	a0,0x2
    8000fc74:	4e850513          	addi	a0,a0,1256 # 80012158 <userDataStart+0x158>
    8000fc78:	00001097          	auipc	ra,0x1
    8000fc7c:	ea4080e7          	jalr	-348(ra) # 80010b1c <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000fc80:	0014849b          	addiw	s1,s1,1
    8000fc84:	0ff4f493          	andi	s1,s1,255
    8000fc88:	00c00793          	li	a5,12
    8000fc8c:	fc97f0e3          	bgeu	a5,s1,8000fc4c <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000fc90:	00002517          	auipc	a0,0x2
    8000fc94:	40050513          	addi	a0,a0,1024 # 80012090 <userDataStart+0x90>
    8000fc98:	00001097          	auipc	ra,0x1
    8000fc9c:	e84080e7          	jalr	-380(ra) # 80010b1c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000fca0:	00500313          	li	t1,5
    thread_dispatch();
    8000fca4:	fffff097          	auipc	ra,0xfffff
    8000fca8:	48c080e7          	jalr	1164(ra) # 8000f130 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000fcac:	01000513          	li	a0,16
    8000fcb0:	00000097          	auipc	ra,0x0
    8000fcb4:	d88080e7          	jalr	-632(ra) # 8000fa38 <_Z9fibonaccim>
    8000fcb8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000fcbc:	00002517          	auipc	a0,0x2
    8000fcc0:	3e450513          	addi	a0,a0,996 # 800120a0 <userDataStart+0xa0>
    8000fcc4:	00001097          	auipc	ra,0x1
    8000fcc8:	e58080e7          	jalr	-424(ra) # 80010b1c <_Z11printStringPKc>
    8000fccc:	00000613          	li	a2,0
    8000fcd0:	00a00593          	li	a1,10
    8000fcd4:	0009051b          	sext.w	a0,s2
    8000fcd8:	00001097          	auipc	ra,0x1
    8000fcdc:	fdc080e7          	jalr	-36(ra) # 80010cb4 <_Z8printIntiii>
    8000fce0:	00002517          	auipc	a0,0x2
    8000fce4:	47850513          	addi	a0,a0,1144 # 80012158 <userDataStart+0x158>
    8000fce8:	00001097          	auipc	ra,0x1
    8000fcec:	e34080e7          	jalr	-460(ra) # 80010b1c <_Z11printStringPKc>
    8000fcf0:	0400006f          	j	8000fd30 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000fcf4:	00002517          	auipc	a0,0x2
    8000fcf8:	39450513          	addi	a0,a0,916 # 80012088 <userDataStart+0x88>
    8000fcfc:	00001097          	auipc	ra,0x1
    8000fd00:	e20080e7          	jalr	-480(ra) # 80010b1c <_Z11printStringPKc>
    8000fd04:	00000613          	li	a2,0
    8000fd08:	00a00593          	li	a1,10
    8000fd0c:	00048513          	mv	a0,s1
    8000fd10:	00001097          	auipc	ra,0x1
    8000fd14:	fa4080e7          	jalr	-92(ra) # 80010cb4 <_Z8printIntiii>
    8000fd18:	00002517          	auipc	a0,0x2
    8000fd1c:	44050513          	addi	a0,a0,1088 # 80012158 <userDataStart+0x158>
    8000fd20:	00001097          	auipc	ra,0x1
    8000fd24:	dfc080e7          	jalr	-516(ra) # 80010b1c <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000fd28:	0014849b          	addiw	s1,s1,1
    8000fd2c:	0ff4f493          	andi	s1,s1,255
    8000fd30:	00f00793          	li	a5,15
    8000fd34:	fc97f0e3          	bgeu	a5,s1,8000fcf4 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000fd38:	00002517          	auipc	a0,0x2
    8000fd3c:	37850513          	addi	a0,a0,888 # 800120b0 <userDataStart+0xb0>
    8000fd40:	00001097          	auipc	ra,0x1
    8000fd44:	ddc080e7          	jalr	-548(ra) # 80010b1c <_Z11printStringPKc>
    finishedD = true;
    8000fd48:	00100793          	li	a5,1
    8000fd4c:	00002717          	auipc	a4,0x2
    8000fd50:	62f70fa3          	sb	a5,1599(a4) # 8001238b <finishedD>
    thread_dispatch();
    8000fd54:	fffff097          	auipc	ra,0xfffff
    8000fd58:	3dc080e7          	jalr	988(ra) # 8000f130 <_Z15thread_dispatchv>
}
    8000fd5c:	01813083          	ld	ra,24(sp)
    8000fd60:	01013403          	ld	s0,16(sp)
    8000fd64:	00813483          	ld	s1,8(sp)
    8000fd68:	00013903          	ld	s2,0(sp)
    8000fd6c:	02010113          	addi	sp,sp,32
    8000fd70:	00008067          	ret

000000008000fd74 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000fd74:	fc010113          	addi	sp,sp,-64
    8000fd78:	02113c23          	sd	ra,56(sp)
    8000fd7c:	02813823          	sd	s0,48(sp)
    8000fd80:	02913423          	sd	s1,40(sp)
    8000fd84:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000fd88:	00000613          	li	a2,0
    8000fd8c:	00000597          	auipc	a1,0x0
    8000fd90:	a6858593          	addi	a1,a1,-1432 # 8000f7f4 <_Z11workerBodyAPv>
    8000fd94:	fc040513          	addi	a0,s0,-64
    8000fd98:	fffff097          	auipc	ra,0xfffff
    8000fd9c:	2e4080e7          	jalr	740(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000fda0:	00002517          	auipc	a0,0x2
    8000fda4:	32050513          	addi	a0,a0,800 # 800120c0 <userDataStart+0xc0>
    8000fda8:	00001097          	auipc	ra,0x1
    8000fdac:	d74080e7          	jalr	-652(ra) # 80010b1c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000fdb0:	00000613          	li	a2,0
    8000fdb4:	00000597          	auipc	a1,0x0
    8000fdb8:	b0c58593          	addi	a1,a1,-1268 # 8000f8c0 <_Z11workerBodyBPv>
    8000fdbc:	fc840513          	addi	a0,s0,-56
    8000fdc0:	fffff097          	auipc	ra,0xfffff
    8000fdc4:	2bc080e7          	jalr	700(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    8000fdc8:	00002517          	auipc	a0,0x2
    8000fdcc:	31050513          	addi	a0,a0,784 # 800120d8 <userDataStart+0xd8>
    8000fdd0:	00001097          	auipc	ra,0x1
    8000fdd4:	d4c080e7          	jalr	-692(ra) # 80010b1c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000fdd8:	00000613          	li	a2,0
    8000fddc:	00000597          	auipc	a1,0x0
    8000fde0:	cd058593          	addi	a1,a1,-816 # 8000faac <_Z11workerBodyCPv>
    8000fde4:	fd040513          	addi	a0,s0,-48
    8000fde8:	fffff097          	auipc	ra,0xfffff
    8000fdec:	294080e7          	jalr	660(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    8000fdf0:	00002517          	auipc	a0,0x2
    8000fdf4:	30050513          	addi	a0,a0,768 # 800120f0 <userDataStart+0xf0>
    8000fdf8:	00001097          	auipc	ra,0x1
    8000fdfc:	d24080e7          	jalr	-732(ra) # 80010b1c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000fe00:	00000613          	li	a2,0
    8000fe04:	00000597          	auipc	a1,0x0
    8000fe08:	e2858593          	addi	a1,a1,-472 # 8000fc2c <_Z11workerBodyDPv>
    8000fe0c:	fd840513          	addi	a0,s0,-40
    8000fe10:	fffff097          	auipc	ra,0xfffff
    8000fe14:	26c080e7          	jalr	620(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    8000fe18:	00002517          	auipc	a0,0x2
    8000fe1c:	2f050513          	addi	a0,a0,752 # 80012108 <userDataStart+0x108>
    8000fe20:	00001097          	auipc	ra,0x1
    8000fe24:	cfc080e7          	jalr	-772(ra) # 80010b1c <_Z11printStringPKc>
    8000fe28:	00c0006f          	j	8000fe34 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000fe2c:	fffff097          	auipc	ra,0xfffff
    8000fe30:	304080e7          	jalr	772(ra) # 8000f130 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000fe34:	00002797          	auipc	a5,0x2
    8000fe38:	54c7c783          	lbu	a5,1356(a5) # 80012380 <finishedA>
    8000fe3c:	fe0788e3          	beqz	a5,8000fe2c <_Z18Threads_C_API_testv+0xb8>
    8000fe40:	00002797          	auipc	a5,0x2
    8000fe44:	5417c783          	lbu	a5,1345(a5) # 80012381 <finishedB>
    8000fe48:	fe0782e3          	beqz	a5,8000fe2c <_Z18Threads_C_API_testv+0xb8>
    8000fe4c:	00002797          	auipc	a5,0x2
    8000fe50:	53e7c783          	lbu	a5,1342(a5) # 8001238a <finishedC>
    8000fe54:	fc078ce3          	beqz	a5,8000fe2c <_Z18Threads_C_API_testv+0xb8>
    8000fe58:	00002797          	auipc	a5,0x2
    8000fe5c:	5337c783          	lbu	a5,1331(a5) # 8001238b <finishedD>
    8000fe60:	fc0786e3          	beqz	a5,8000fe2c <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    8000fe64:	fc040493          	addi	s1,s0,-64
    8000fe68:	0080006f          	j	8000fe70 <_Z18Threads_C_API_testv+0xfc>
    8000fe6c:	00848493          	addi	s1,s1,8
    8000fe70:	fe040793          	addi	a5,s0,-32
    8000fe74:	00f48c63          	beq	s1,a5,8000fe8c <_Z18Threads_C_API_testv+0x118>
    8000fe78:	0004b503          	ld	a0,0(s1)
    8000fe7c:	fe0508e3          	beqz	a0,8000fe6c <_Z18Threads_C_API_testv+0xf8>
    8000fe80:	fffff097          	auipc	ra,0xfffff
    8000fe84:	544080e7          	jalr	1348(ra) # 8000f3c4 <_ZN7_threaddlEPv>
    8000fe88:	fe5ff06f          	j	8000fe6c <_Z18Threads_C_API_testv+0xf8>
}
    8000fe8c:	03813083          	ld	ra,56(sp)
    8000fe90:	03013403          	ld	s0,48(sp)
    8000fe94:	02813483          	ld	s1,40(sp)
    8000fe98:	04010113          	addi	sp,sp,64
    8000fe9c:	00008067          	ret

000000008000fea0 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    8000fea0:	fd010113          	addi	sp,sp,-48
    8000fea4:	02113423          	sd	ra,40(sp)
    8000fea8:	02813023          	sd	s0,32(sp)
    8000feac:	00913c23          	sd	s1,24(sp)
    8000feb0:	01213823          	sd	s2,16(sp)
    8000feb4:	01313423          	sd	s3,8(sp)
    8000feb8:	03010413          	addi	s0,sp,48
    8000febc:	00050993          	mv	s3,a0
    8000fec0:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000fec4:	00000913          	li	s2,0
    8000fec8:	00c0006f          	j	8000fed4 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    8000fecc:	00001097          	auipc	ra,0x1
    8000fed0:	244080e7          	jalr	580(ra) # 80011110 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    8000fed4:	fffff097          	auipc	ra,0xfffff
    8000fed8:	430080e7          	jalr	1072(ra) # 8000f304 <_Z4getcv>
    8000fedc:	0005059b          	sext.w	a1,a0
    8000fee0:	01b00793          	li	a5,27
    8000fee4:	02f58a63          	beq	a1,a5,8000ff18 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    8000fee8:	0084b503          	ld	a0,8(s1)
    8000feec:	fffff097          	auipc	ra,0xfffff
    8000fef0:	664080e7          	jalr	1636(ra) # 8000f550 <_ZN9BufferCPP3putEi>
        i++;
    8000fef4:	0019071b          	addiw	a4,s2,1
    8000fef8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000fefc:	0004a683          	lw	a3,0(s1)
    8000ff00:	0026979b          	slliw	a5,a3,0x2
    8000ff04:	00d787bb          	addw	a5,a5,a3
    8000ff08:	0017979b          	slliw	a5,a5,0x1
    8000ff0c:	02f767bb          	remw	a5,a4,a5
    8000ff10:	fc0792e3          	bnez	a5,8000fed4 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    8000ff14:	fb9ff06f          	j	8000fecc <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    8000ff18:	00100793          	li	a5,1
    8000ff1c:	00002717          	auipc	a4,0x2
    8000ff20:	46f72823          	sw	a5,1136(a4) # 8001238c <threadEnd>
    td->buffer->put('!');
    8000ff24:	0109b783          	ld	a5,16(s3)
    8000ff28:	02100593          	li	a1,33
    8000ff2c:	0087b503          	ld	a0,8(a5)
    8000ff30:	fffff097          	auipc	ra,0xfffff
    8000ff34:	620080e7          	jalr	1568(ra) # 8000f550 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    8000ff38:	0104b503          	ld	a0,16(s1)
    8000ff3c:	00001097          	auipc	ra,0x1
    8000ff40:	08c080e7          	jalr	140(ra) # 80010fc8 <_ZN9Semaphore6signalEv>
}
    8000ff44:	02813083          	ld	ra,40(sp)
    8000ff48:	02013403          	ld	s0,32(sp)
    8000ff4c:	01813483          	ld	s1,24(sp)
    8000ff50:	01013903          	ld	s2,16(sp)
    8000ff54:	00813983          	ld	s3,8(sp)
    8000ff58:	03010113          	addi	sp,sp,48
    8000ff5c:	00008067          	ret

000000008000ff60 <_ZN8Producer8producerEPv>:
    void run() override {
        producer(td);
    }
};

void Producer::producer(void *arg) {
    8000ff60:	fe010113          	addi	sp,sp,-32
    8000ff64:	00113c23          	sd	ra,24(sp)
    8000ff68:	00813823          	sd	s0,16(sp)
    8000ff6c:	00913423          	sd	s1,8(sp)
    8000ff70:	01213023          	sd	s2,0(sp)
    8000ff74:	02010413          	addi	s0,sp,32
    8000ff78:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000ff7c:	00000913          	li	s2,0
    8000ff80:	00c0006f          	j	8000ff8c <_ZN8Producer8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    8000ff84:	00001097          	auipc	ra,0x1
    8000ff88:	18c080e7          	jalr	396(ra) # 80011110 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    8000ff8c:	00002797          	auipc	a5,0x2
    8000ff90:	4007a783          	lw	a5,1024(a5) # 8001238c <threadEnd>
    8000ff94:	02079e63          	bnez	a5,8000ffd0 <_ZN8Producer8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    8000ff98:	0004a583          	lw	a1,0(s1)
    8000ff9c:	0305859b          	addiw	a1,a1,48
    8000ffa0:	0084b503          	ld	a0,8(s1)
    8000ffa4:	fffff097          	auipc	ra,0xfffff
    8000ffa8:	5ac080e7          	jalr	1452(ra) # 8000f550 <_ZN9BufferCPP3putEi>
        i++;
    8000ffac:	0019071b          	addiw	a4,s2,1
    8000ffb0:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000ffb4:	0004a683          	lw	a3,0(s1)
    8000ffb8:	0026979b          	slliw	a5,a3,0x2
    8000ffbc:	00d787bb          	addw	a5,a5,a3
    8000ffc0:	0017979b          	slliw	a5,a5,0x1
    8000ffc4:	02f767bb          	remw	a5,a4,a5
    8000ffc8:	fc0792e3          	bnez	a5,8000ff8c <_ZN8Producer8producerEPv+0x2c>
    8000ffcc:	fb9ff06f          	j	8000ff84 <_ZN8Producer8producerEPv+0x24>
        }
    }

    data->wait->signal();
    8000ffd0:	0104b503          	ld	a0,16(s1)
    8000ffd4:	00001097          	auipc	ra,0x1
    8000ffd8:	ff4080e7          	jalr	-12(ra) # 80010fc8 <_ZN9Semaphore6signalEv>
}
    8000ffdc:	01813083          	ld	ra,24(sp)
    8000ffe0:	01013403          	ld	s0,16(sp)
    8000ffe4:	00813483          	ld	s1,8(sp)
    8000ffe8:	00013903          	ld	s2,0(sp)
    8000ffec:	02010113          	addi	sp,sp,32
    8000fff0:	00008067          	ret

000000008000fff4 <_ZN8Consumer8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void Consumer::consumer(void *arg) {
    8000fff4:	fd010113          	addi	sp,sp,-48
    8000fff8:	02113423          	sd	ra,40(sp)
    8000fffc:	02813023          	sd	s0,32(sp)
    80010000:	00913c23          	sd	s1,24(sp)
    80010004:	01213823          	sd	s2,16(sp)
    80010008:	01313423          	sd	s3,8(sp)
    8001000c:	01413023          	sd	s4,0(sp)
    80010010:	03010413          	addi	s0,sp,48
    80010014:	00050993          	mv	s3,a0
    80010018:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8001001c:	00000a13          	li	s4,0
    80010020:	01c0006f          	j	8001003c <_ZN8Consumer8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80010024:	00001097          	auipc	ra,0x1
    80010028:	0ec080e7          	jalr	236(ra) # 80011110 <_ZN6Thread8dispatchEv>
    8001002c:	0500006f          	j	8001007c <_ZN8Consumer8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80010030:	00a00513          	li	a0,10
    80010034:	fffff097          	auipc	ra,0xfffff
    80010038:	2f8080e7          	jalr	760(ra) # 8000f32c <_Z4putcc>
    while (!threadEnd) {
    8001003c:	00002797          	auipc	a5,0x2
    80010040:	3507a783          	lw	a5,848(a5) # 8001238c <threadEnd>
    80010044:	06079263          	bnez	a5,800100a8 <_ZN8Consumer8consumerEPv+0xb4>
        int key = data->buffer->get();
    80010048:	00893503          	ld	a0,8(s2)
    8001004c:	fffff097          	auipc	ra,0xfffff
    80010050:	594080e7          	jalr	1428(ra) # 8000f5e0 <_ZN9BufferCPP3getEv>
        i++;
    80010054:	001a049b          	addiw	s1,s4,1
    80010058:	00048a1b          	sext.w	s4,s1
        putc(key);
    8001005c:	0ff57513          	andi	a0,a0,255
    80010060:	fffff097          	auipc	ra,0xfffff
    80010064:	2cc080e7          	jalr	716(ra) # 8000f32c <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80010068:	00092703          	lw	a4,0(s2)
    8001006c:	0027179b          	slliw	a5,a4,0x2
    80010070:	00e787bb          	addw	a5,a5,a4
    80010074:	02f4e7bb          	remw	a5,s1,a5
    80010078:	fa0786e3          	beqz	a5,80010024 <_ZN8Consumer8consumerEPv+0x30>
        if (i % 80 == 0) {
    8001007c:	05000793          	li	a5,80
    80010080:	02f4e4bb          	remw	s1,s1,a5
    80010084:	fa049ce3          	bnez	s1,8001003c <_ZN8Consumer8consumerEPv+0x48>
    80010088:	fa9ff06f          	j	80010030 <_ZN8Consumer8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    8001008c:	0109b783          	ld	a5,16(s3)
    80010090:	0087b503          	ld	a0,8(a5)
    80010094:	fffff097          	auipc	ra,0xfffff
    80010098:	54c080e7          	jalr	1356(ra) # 8000f5e0 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    8001009c:	0ff57513          	andi	a0,a0,255
    800100a0:	00001097          	auipc	ra,0x1
    800100a4:	160080e7          	jalr	352(ra) # 80011200 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    800100a8:	0109b783          	ld	a5,16(s3)
    800100ac:	0087b503          	ld	a0,8(a5)
    800100b0:	fffff097          	auipc	ra,0xfffff
    800100b4:	5bc080e7          	jalr	1468(ra) # 8000f66c <_ZN9BufferCPP6getCntEv>
    800100b8:	fca04ae3          	bgtz	a0,8001008c <_ZN8Consumer8consumerEPv+0x98>
    }

    data->wait->signal();
    800100bc:	01093503          	ld	a0,16(s2)
    800100c0:	00001097          	auipc	ra,0x1
    800100c4:	f08080e7          	jalr	-248(ra) # 80010fc8 <_ZN9Semaphore6signalEv>
}
    800100c8:	02813083          	ld	ra,40(sp)
    800100cc:	02013403          	ld	s0,32(sp)
    800100d0:	01813483          	ld	s1,24(sp)
    800100d4:	01013903          	ld	s2,16(sp)
    800100d8:	00813983          	ld	s3,8(sp)
    800100dc:	00013a03          	ld	s4,0(sp)
    800100e0:	03010113          	addi	sp,sp,48
    800100e4:	00008067          	ret

00000000800100e8 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800100e8:	f8010113          	addi	sp,sp,-128
    800100ec:	06113c23          	sd	ra,120(sp)
    800100f0:	06813823          	sd	s0,112(sp)
    800100f4:	06913423          	sd	s1,104(sp)
    800100f8:	07213023          	sd	s2,96(sp)
    800100fc:	05313c23          	sd	s3,88(sp)
    80010100:	05413823          	sd	s4,80(sp)
    80010104:	05513423          	sd	s5,72(sp)
    80010108:	05613023          	sd	s6,64(sp)
    8001010c:	03713c23          	sd	s7,56(sp)
    80010110:	03813823          	sd	s8,48(sp)
    80010114:	03913423          	sd	s9,40(sp)
    80010118:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    8001011c:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80010120:	00002517          	auipc	a0,0x2
    80010124:	00050513          	mv	a0,a0
    80010128:	00001097          	auipc	ra,0x1
    8001012c:	9f4080e7          	jalr	-1548(ra) # 80010b1c <_Z11printStringPKc>
    getString(input, 30);
    80010130:	01e00593          	li	a1,30
    80010134:	f8040493          	addi	s1,s0,-128
    80010138:	00048513          	mv	a0,s1
    8001013c:	00001097          	auipc	ra,0x1
    80010140:	a5c080e7          	jalr	-1444(ra) # 80010b98 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80010144:	00048513          	mv	a0,s1
    80010148:	00001097          	auipc	ra,0x1
    8001014c:	b1c080e7          	jalr	-1252(ra) # 80010c64 <_Z11stringToIntPKc>
    80010150:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80010154:	00002517          	auipc	a0,0x2
    80010158:	fec50513          	addi	a0,a0,-20 # 80012140 <userDataStart+0x140>
    8001015c:	00001097          	auipc	ra,0x1
    80010160:	9c0080e7          	jalr	-1600(ra) # 80010b1c <_Z11printStringPKc>
    getString(input, 30);
    80010164:	01e00593          	li	a1,30
    80010168:	00048513          	mv	a0,s1
    8001016c:	00001097          	auipc	ra,0x1
    80010170:	a2c080e7          	jalr	-1492(ra) # 80010b98 <_Z9getStringPci>
    n = stringToInt(input);
    80010174:	00048513          	mv	a0,s1
    80010178:	00001097          	auipc	ra,0x1
    8001017c:	aec080e7          	jalr	-1300(ra) # 80010c64 <_Z11stringToIntPKc>
    80010180:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80010184:	00002517          	auipc	a0,0x2
    80010188:	fdc50513          	addi	a0,a0,-36 # 80012160 <userDataStart+0x160>
    8001018c:	00001097          	auipc	ra,0x1
    80010190:	990080e7          	jalr	-1648(ra) # 80010b1c <_Z11printStringPKc>
    80010194:	00000613          	li	a2,0
    80010198:	00a00593          	li	a1,10
    8001019c:	00090513          	mv	a0,s2
    800101a0:	00001097          	auipc	ra,0x1
    800101a4:	b14080e7          	jalr	-1260(ra) # 80010cb4 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    800101a8:	00002517          	auipc	a0,0x2
    800101ac:	fd050513          	addi	a0,a0,-48 # 80012178 <userDataStart+0x178>
    800101b0:	00001097          	auipc	ra,0x1
    800101b4:	96c080e7          	jalr	-1684(ra) # 80010b1c <_Z11printStringPKc>
    800101b8:	00000613          	li	a2,0
    800101bc:	00a00593          	li	a1,10
    800101c0:	00048513          	mv	a0,s1
    800101c4:	00001097          	auipc	ra,0x1
    800101c8:	af0080e7          	jalr	-1296(ra) # 80010cb4 <_Z8printIntiii>
    printString(".\n");
    800101cc:	00002517          	auipc	a0,0x2
    800101d0:	fc450513          	addi	a0,a0,-60 # 80012190 <userDataStart+0x190>
    800101d4:	00001097          	auipc	ra,0x1
    800101d8:	948080e7          	jalr	-1720(ra) # 80010b1c <_Z11printStringPKc>
    if(threadNum > n) {
    800101dc:	0324c663          	blt	s1,s2,80010208 <_Z29producerConsumer_CPP_Sync_APIv+0x120>
    } else if (threadNum < 1) {
    800101e0:	03205e63          	blez	s2,8001021c <_Z29producerConsumer_CPP_Sync_APIv+0x134>
    BufferCPP *buffer = new BufferCPP(n);
    800101e4:	03800513          	li	a0,56
    800101e8:	00001097          	auipc	ra,0x1
    800101ec:	c84080e7          	jalr	-892(ra) # 80010e6c <_Znwm>
    800101f0:	00050a93          	mv	s5,a0
    800101f4:	04050063          	beqz	a0,80010234 <_Z29producerConsumer_CPP_Sync_APIv+0x14c>
    800101f8:	00048593          	mv	a1,s1
    800101fc:	fffff097          	auipc	ra,0xfffff
    80010200:	1f0080e7          	jalr	496(ra) # 8000f3ec <_ZN9BufferCPPC1Ei>
    80010204:	0300006f          	j	80010234 <_Z29producerConsumer_CPP_Sync_APIv+0x14c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80010208:	00002517          	auipc	a0,0x2
    8001020c:	f9050513          	addi	a0,a0,-112 # 80012198 <userDataStart+0x198>
    80010210:	00001097          	auipc	ra,0x1
    80010214:	90c080e7          	jalr	-1780(ra) # 80010b1c <_Z11printStringPKc>
        return;
    80010218:	0140006f          	j	8001022c <_Z29producerConsumer_CPP_Sync_APIv+0x144>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    8001021c:	00002517          	auipc	a0,0x2
    80010220:	fbc50513          	addi	a0,a0,-68 # 800121d8 <userDataStart+0x1d8>
    80010224:	00001097          	auipc	ra,0x1
    80010228:	8f8080e7          	jalr	-1800(ra) # 80010b1c <_Z11printStringPKc>
        return;
    8001022c:	000b8113          	mv	sp,s7
    80010230:	2540006f          	j	80010484 <_Z29producerConsumer_CPP_Sync_APIv+0x39c>
    waitForAll = new Semaphore(0);
    80010234:	01000513          	li	a0,16
    80010238:	00001097          	auipc	ra,0x1
    8001023c:	c34080e7          	jalr	-972(ra) # 80010e6c <_Znwm>
    80010240:	00050493          	mv	s1,a0
    80010244:	00050863          	beqz	a0,80010254 <_Z29producerConsumer_CPP_Sync_APIv+0x16c>
    80010248:	00000593          	li	a1,0
    8001024c:	00001097          	auipc	ra,0x1
    80010250:	d18080e7          	jalr	-744(ra) # 80010f64 <_ZN9SemaphoreC1Ej>
    80010254:	00002717          	auipc	a4,0x2
    80010258:	12c70713          	addi	a4,a4,300 # 80012380 <finishedA>
    8001025c:	00973823          	sd	s1,16(a4)
    Thread* threads[threadNum];
    80010260:	00391793          	slli	a5,s2,0x3
    80010264:	00f78793          	addi	a5,a5,15
    80010268:	ff07f793          	andi	a5,a5,-16
    8001026c:	40f10133          	sub	sp,sp,a5
    80010270:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80010274:	0019069b          	addiw	a3,s2,1
    80010278:	00169793          	slli	a5,a3,0x1
    8001027c:	00d787b3          	add	a5,a5,a3
    80010280:	00379793          	slli	a5,a5,0x3
    80010284:	00f78793          	addi	a5,a5,15
    80010288:	ff07f793          	andi	a5,a5,-16
    8001028c:	40f10133          	sub	sp,sp,a5
    80010290:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80010294:	00191793          	slli	a5,s2,0x1
    80010298:	012787b3          	add	a5,a5,s2
    8001029c:	00379793          	slli	a5,a5,0x3
    800102a0:	00fa07b3          	add	a5,s4,a5
    800102a4:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800102a8:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    800102ac:	01073703          	ld	a4,16(a4)
    800102b0:	00e7b823          	sd	a4,16(a5)
    consumerThread = new Consumer(data+threadNum);
    800102b4:	01800513          	li	a0,24
    800102b8:	00001097          	auipc	ra,0x1
    800102bc:	bb4080e7          	jalr	-1100(ra) # 80010e6c <_Znwm>
    800102c0:	00050b13          	mv	s6,a0
    800102c4:	02050663          	beqz	a0,800102f0 <_Z29producerConsumer_CPP_Sync_APIv+0x208>
    800102c8:	00191493          	slli	s1,s2,0x1
    800102cc:	012484b3          	add	s1,s1,s2
    800102d0:	00349493          	slli	s1,s1,0x3
    800102d4:	009a04b3          	add	s1,s4,s1
    Consumer(thread_data* _td):Thread(), td(_td) {}
    800102d8:	00001097          	auipc	ra,0x1
    800102dc:	d70080e7          	jalr	-656(ra) # 80011048 <_ZN6ThreadC1Ev>
    800102e0:	00002797          	auipc	a5,0x2
    800102e4:	fd078793          	addi	a5,a5,-48 # 800122b0 <_ZTV8Consumer+0x10>
    800102e8:	00fb3023          	sd	a5,0(s6) # 2000 <_entry-0x7fffe000>
    800102ec:	009b3823          	sd	s1,16(s6)
    consumerThread->start();
    800102f0:	000b0513          	mv	a0,s6
    800102f4:	00001097          	auipc	ra,0x1
    800102f8:	e44080e7          	jalr	-444(ra) # 80011138 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800102fc:	00000493          	li	s1,0
    80010300:	0380006f          	j	80010338 <_Z29producerConsumer_CPP_Sync_APIv+0x250>
    Producer(thread_data* _td):Thread(), td(_td) {}
    80010304:	00002797          	auipc	a5,0x2
    80010308:	f8478793          	addi	a5,a5,-124 # 80012288 <_ZTV8Producer+0x10>
    8001030c:	00fc3023          	sd	a5,0(s8)
    80010310:	019c3823          	sd	s9,16(s8)
            threads[i] = new Producer(data+i);
    80010314:	00349793          	slli	a5,s1,0x3
    80010318:	00f987b3          	add	a5,s3,a5
    8001031c:	0187b023          	sd	s8,0(a5)
        threads[i]->start();
    80010320:	00349793          	slli	a5,s1,0x3
    80010324:	00f987b3          	add	a5,s3,a5
    80010328:	0007b503          	ld	a0,0(a5)
    8001032c:	00001097          	auipc	ra,0x1
    80010330:	e0c080e7          	jalr	-500(ra) # 80011138 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80010334:	0014849b          	addiw	s1,s1,1
    80010338:	0b24d463          	bge	s1,s2,800103e0 <_Z29producerConsumer_CPP_Sync_APIv+0x2f8>
        data[i].id = i;
    8001033c:	00149793          	slli	a5,s1,0x1
    80010340:	009787b3          	add	a5,a5,s1
    80010344:	00379793          	slli	a5,a5,0x3
    80010348:	00fa07b3          	add	a5,s4,a5
    8001034c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80010350:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80010354:	00002717          	auipc	a4,0x2
    80010358:	03c73703          	ld	a4,60(a4) # 80012390 <waitForAll>
    8001035c:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80010360:	02905a63          	blez	s1,80010394 <_Z29producerConsumer_CPP_Sync_APIv+0x2ac>
            threads[i] = new Producer(data+i);
    80010364:	01800513          	li	a0,24
    80010368:	00001097          	auipc	ra,0x1
    8001036c:	b04080e7          	jalr	-1276(ra) # 80010e6c <_Znwm>
    80010370:	00050c13          	mv	s8,a0
    80010374:	fa0500e3          	beqz	a0,80010314 <_Z29producerConsumer_CPP_Sync_APIv+0x22c>
    80010378:	00149c93          	slli	s9,s1,0x1
    8001037c:	009c8cb3          	add	s9,s9,s1
    80010380:	003c9c93          	slli	s9,s9,0x3
    80010384:	019a0cb3          	add	s9,s4,s9
    Producer(thread_data* _td):Thread(), td(_td) {}
    80010388:	00001097          	auipc	ra,0x1
    8001038c:	cc0080e7          	jalr	-832(ra) # 80011048 <_ZN6ThreadC1Ev>
    80010390:	f75ff06f          	j	80010304 <_Z29producerConsumer_CPP_Sync_APIv+0x21c>
            threads[i] = new ProducerKeyboard(data+i);
    80010394:	01800513          	li	a0,24
    80010398:	00001097          	auipc	ra,0x1
    8001039c:	ad4080e7          	jalr	-1324(ra) # 80010e6c <_Znwm>
    800103a0:	00050c13          	mv	s8,a0
    800103a4:	02050663          	beqz	a0,800103d0 <_Z29producerConsumer_CPP_Sync_APIv+0x2e8>
    800103a8:	00149c93          	slli	s9,s1,0x1
    800103ac:	009c8cb3          	add	s9,s9,s1
    800103b0:	003c9c93          	slli	s9,s9,0x3
    800103b4:	019a0cb3          	add	s9,s4,s9
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    800103b8:	00001097          	auipc	ra,0x1
    800103bc:	c90080e7          	jalr	-880(ra) # 80011048 <_ZN6ThreadC1Ev>
    800103c0:	00002797          	auipc	a5,0x2
    800103c4:	ea078793          	addi	a5,a5,-352 # 80012260 <_ZTV16ProducerKeyboard+0x10>
    800103c8:	00fc3023          	sd	a5,0(s8)
    800103cc:	019c3823          	sd	s9,16(s8)
            threads[i] = new ProducerKeyboard(data+i);
    800103d0:	00349793          	slli	a5,s1,0x3
    800103d4:	00f987b3          	add	a5,s3,a5
    800103d8:	0187b023          	sd	s8,0(a5)
    800103dc:	f45ff06f          	j	80010320 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    Thread::dispatch();
    800103e0:	00001097          	auipc	ra,0x1
    800103e4:	d30080e7          	jalr	-720(ra) # 80011110 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    800103e8:	00000493          	li	s1,0
    800103ec:	00994e63          	blt	s2,s1,80010408 <_Z29producerConsumer_CPP_Sync_APIv+0x320>
        waitForAll->wait();
    800103f0:	00002517          	auipc	a0,0x2
    800103f4:	fa053503          	ld	a0,-96(a0) # 80012390 <waitForAll>
    800103f8:	00001097          	auipc	ra,0x1
    800103fc:	ba4080e7          	jalr	-1116(ra) # 80010f9c <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80010400:	0014849b          	addiw	s1,s1,1
    80010404:	fe9ff06f          	j	800103ec <_Z29producerConsumer_CPP_Sync_APIv+0x304>
    for (int i = 0; i < threadNum; i++) {
    80010408:	00000493          	li	s1,0
    8001040c:	0080006f          	j	80010414 <_Z29producerConsumer_CPP_Sync_APIv+0x32c>
    80010410:	0014849b          	addiw	s1,s1,1
    80010414:	0324d263          	bge	s1,s2,80010438 <_Z29producerConsumer_CPP_Sync_APIv+0x350>
        delete threads[i];
    80010418:	00349793          	slli	a5,s1,0x3
    8001041c:	00f987b3          	add	a5,s3,a5
    80010420:	0007b503          	ld	a0,0(a5)
    80010424:	fe0506e3          	beqz	a0,80010410 <_Z29producerConsumer_CPP_Sync_APIv+0x328>
    80010428:	00053783          	ld	a5,0(a0)
    8001042c:	0087b783          	ld	a5,8(a5)
    80010430:	000780e7          	jalr	a5
    80010434:	fddff06f          	j	80010410 <_Z29producerConsumer_CPP_Sync_APIv+0x328>
    delete consumerThread;
    80010438:	000b0a63          	beqz	s6,8001044c <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    8001043c:	000b3783          	ld	a5,0(s6)
    80010440:	0087b783          	ld	a5,8(a5)
    80010444:	000b0513          	mv	a0,s6
    80010448:	000780e7          	jalr	a5
    delete waitForAll;
    8001044c:	00002517          	auipc	a0,0x2
    80010450:	f4453503          	ld	a0,-188(a0) # 80012390 <waitForAll>
    80010454:	00050863          	beqz	a0,80010464 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    80010458:	00053783          	ld	a5,0(a0)
    8001045c:	0087b783          	ld	a5,8(a5)
    80010460:	000780e7          	jalr	a5
    delete buffer;
    80010464:	000a8e63          	beqz	s5,80010480 <_Z29producerConsumer_CPP_Sync_APIv+0x398>
    80010468:	000a8513          	mv	a0,s5
    8001046c:	fffff097          	auipc	ra,0xfffff
    80010470:	288080e7          	jalr	648(ra) # 8000f6f4 <_ZN9BufferCPPD1Ev>
    80010474:	000a8513          	mv	a0,s5
    80010478:	00001097          	auipc	ra,0x1
    8001047c:	a44080e7          	jalr	-1468(ra) # 80010ebc <_ZdlPv>
    80010480:	000b8113          	mv	sp,s7

}
    80010484:	f8040113          	addi	sp,s0,-128
    80010488:	07813083          	ld	ra,120(sp)
    8001048c:	07013403          	ld	s0,112(sp)
    80010490:	06813483          	ld	s1,104(sp)
    80010494:	06013903          	ld	s2,96(sp)
    80010498:	05813983          	ld	s3,88(sp)
    8001049c:	05013a03          	ld	s4,80(sp)
    800104a0:	04813a83          	ld	s5,72(sp)
    800104a4:	04013b03          	ld	s6,64(sp)
    800104a8:	03813b83          	ld	s7,56(sp)
    800104ac:	03013c03          	ld	s8,48(sp)
    800104b0:	02813c83          	ld	s9,40(sp)
    800104b4:	08010113          	addi	sp,sp,128
    800104b8:	00008067          	ret
    800104bc:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800104c0:	000a8513          	mv	a0,s5
    800104c4:	00001097          	auipc	ra,0x1
    800104c8:	9f8080e7          	jalr	-1544(ra) # 80010ebc <_ZdlPv>
    800104cc:	00048513          	mv	a0,s1
    800104d0:	ffffd097          	auipc	ra,0xffffd
    800104d4:	a28080e7          	jalr	-1496(ra) # 8000cef8 <_Unwind_Resume>
    800104d8:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    800104dc:	00048513          	mv	a0,s1
    800104e0:	00001097          	auipc	ra,0x1
    800104e4:	9dc080e7          	jalr	-1572(ra) # 80010ebc <_ZdlPv>
    800104e8:	00090513          	mv	a0,s2
    800104ec:	ffffd097          	auipc	ra,0xffffd
    800104f0:	a0c080e7          	jalr	-1524(ra) # 8000cef8 <_Unwind_Resume>
    800104f4:	00050493          	mv	s1,a0
    consumerThread = new Consumer(data+threadNum);
    800104f8:	000b0513          	mv	a0,s6
    800104fc:	00001097          	auipc	ra,0x1
    80010500:	9c0080e7          	jalr	-1600(ra) # 80010ebc <_ZdlPv>
    80010504:	00048513          	mv	a0,s1
    80010508:	ffffd097          	auipc	ra,0xffffd
    8001050c:	9f0080e7          	jalr	-1552(ra) # 8000cef8 <_Unwind_Resume>
    80010510:	00050493          	mv	s1,a0
            threads[i] = new Producer(data+i);
    80010514:	000c0513          	mv	a0,s8
    80010518:	00001097          	auipc	ra,0x1
    8001051c:	9a4080e7          	jalr	-1628(ra) # 80010ebc <_ZdlPv>
    80010520:	00048513          	mv	a0,s1
    80010524:	ffffd097          	auipc	ra,0xffffd
    80010528:	9d4080e7          	jalr	-1580(ra) # 8000cef8 <_Unwind_Resume>
    8001052c:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80010530:	000c0513          	mv	a0,s8
    80010534:	00001097          	auipc	ra,0x1
    80010538:	988080e7          	jalr	-1656(ra) # 80010ebc <_ZdlPv>
    8001053c:	00048513          	mv	a0,s1
    80010540:	ffffd097          	auipc	ra,0xffffd
    80010544:	9b8080e7          	jalr	-1608(ra) # 8000cef8 <_Unwind_Resume>

0000000080010548 <_Z12testSleepingv>:

void testSleeping() {
    80010548:	fc010113          	addi	sp,sp,-64
    8001054c:	02113c23          	sd	ra,56(sp)
    80010550:	02813823          	sd	s0,48(sp)
    80010554:	02913423          	sd	s1,40(sp)
    80010558:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    8001055c:	00a00793          	li	a5,10
    80010560:	fcf43823          	sd	a5,-48(s0)
    80010564:	01400793          	li	a5,20
    80010568:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    8001056c:	00000493          	li	s1,0
    80010570:	02c0006f          	j	8001059c <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80010574:	00349793          	slli	a5,s1,0x3
    80010578:	fd040613          	addi	a2,s0,-48
    8001057c:	00f60633          	add	a2,a2,a5
    80010580:	fffff597          	auipc	a1,0xfffff
    80010584:	41458593          	addi	a1,a1,1044 # 8000f994 <_Z9sleepyRunPv>
    80010588:	fc040513          	addi	a0,s0,-64
    8001058c:	00f50533          	add	a0,a0,a5
    80010590:	fffff097          	auipc	ra,0xfffff
    80010594:	aec080e7          	jalr	-1300(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80010598:	0014849b          	addiw	s1,s1,1
    8001059c:	00100793          	li	a5,1
    800105a0:	fc97dae3          	bge	a5,s1,80010574 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800105a4:	00002797          	auipc	a5,0x2
    800105a8:	de47c783          	lbu	a5,-540(a5) # 80012388 <finished>
    800105ac:	fe078ce3          	beqz	a5,800105a4 <_Z12testSleepingv+0x5c>
    800105b0:	00002797          	auipc	a5,0x2
    800105b4:	dd97c783          	lbu	a5,-551(a5) # 80012389 <finished+0x1>
    800105b8:	fe0786e3          	beqz	a5,800105a4 <_Z12testSleepingv+0x5c>
}
    800105bc:	03813083          	ld	ra,56(sp)
    800105c0:	03013403          	ld	s0,48(sp)
    800105c4:	02813483          	ld	s1,40(sp)
    800105c8:	04010113          	addi	sp,sp,64
    800105cc:	00008067          	ret

00000000800105d0 <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
//#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    800105d0:	ff010113          	addi	sp,sp,-16
    800105d4:	00113423          	sd	ra,8(sp)
    800105d8:	00813023          	sd	s0,0(sp)
    800105dc:	01010413          	addi	s0,sp,16
//    Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
//    Threads_CPP_API_test(); // zadatak 2., niti CPP API i sinhrona promena konteksta

//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta
    800105e0:	00000097          	auipc	ra,0x0
    800105e4:	b08080e7          	jalr	-1272(ra) # 800100e8 <_Z29producerConsumer_CPP_Sync_APIv>

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    800105e8:	00813083          	ld	ra,8(sp)
    800105ec:	00013403          	ld	s0,0(sp)
    800105f0:	01010113          	addi	sp,sp,16
    800105f4:	00008067          	ret

00000000800105f8 <_ZN8ConsumerD1Ev>:
class Consumer:public Thread {
    800105f8:	ff010113          	addi	sp,sp,-16
    800105fc:	00113423          	sd	ra,8(sp)
    80010600:	00813023          	sd	s0,0(sp)
    80010604:	01010413          	addi	s0,sp,16
    80010608:	00002797          	auipc	a5,0x2
    8001060c:	ca878793          	addi	a5,a5,-856 # 800122b0 <_ZTV8Consumer+0x10>
    80010610:	00f53023          	sd	a5,0(a0)
    80010614:	00001097          	auipc	ra,0x1
    80010618:	818080e7          	jalr	-2024(ra) # 80010e2c <_ZN6ThreadD1Ev>
    8001061c:	00813083          	ld	ra,8(sp)
    80010620:	00013403          	ld	s0,0(sp)
    80010624:	01010113          	addi	sp,sp,16
    80010628:	00008067          	ret

000000008001062c <_ZN8ConsumerD0Ev>:
    8001062c:	fe010113          	addi	sp,sp,-32
    80010630:	00113c23          	sd	ra,24(sp)
    80010634:	00813823          	sd	s0,16(sp)
    80010638:	00913423          	sd	s1,8(sp)
    8001063c:	02010413          	addi	s0,sp,32
    80010640:	00050493          	mv	s1,a0
    80010644:	00002797          	auipc	a5,0x2
    80010648:	c6c78793          	addi	a5,a5,-916 # 800122b0 <_ZTV8Consumer+0x10>
    8001064c:	00f53023          	sd	a5,0(a0)
    80010650:	00000097          	auipc	ra,0x0
    80010654:	7dc080e7          	jalr	2012(ra) # 80010e2c <_ZN6ThreadD1Ev>
    80010658:	00048513          	mv	a0,s1
    8001065c:	00001097          	auipc	ra,0x1
    80010660:	860080e7          	jalr	-1952(ra) # 80010ebc <_ZdlPv>
    80010664:	01813083          	ld	ra,24(sp)
    80010668:	01013403          	ld	s0,16(sp)
    8001066c:	00813483          	ld	s1,8(sp)
    80010670:	02010113          	addi	sp,sp,32
    80010674:	00008067          	ret

0000000080010678 <_ZN8ProducerD1Ev>:
class Producer:public Thread {
    80010678:	ff010113          	addi	sp,sp,-16
    8001067c:	00113423          	sd	ra,8(sp)
    80010680:	00813023          	sd	s0,0(sp)
    80010684:	01010413          	addi	s0,sp,16
    80010688:	00002797          	auipc	a5,0x2
    8001068c:	c0078793          	addi	a5,a5,-1024 # 80012288 <_ZTV8Producer+0x10>
    80010690:	00f53023          	sd	a5,0(a0)
    80010694:	00000097          	auipc	ra,0x0
    80010698:	798080e7          	jalr	1944(ra) # 80010e2c <_ZN6ThreadD1Ev>
    8001069c:	00813083          	ld	ra,8(sp)
    800106a0:	00013403          	ld	s0,0(sp)
    800106a4:	01010113          	addi	sp,sp,16
    800106a8:	00008067          	ret

00000000800106ac <_ZN8ProducerD0Ev>:
    800106ac:	fe010113          	addi	sp,sp,-32
    800106b0:	00113c23          	sd	ra,24(sp)
    800106b4:	00813823          	sd	s0,16(sp)
    800106b8:	00913423          	sd	s1,8(sp)
    800106bc:	02010413          	addi	s0,sp,32
    800106c0:	00050493          	mv	s1,a0
    800106c4:	00002797          	auipc	a5,0x2
    800106c8:	bc478793          	addi	a5,a5,-1084 # 80012288 <_ZTV8Producer+0x10>
    800106cc:	00f53023          	sd	a5,0(a0)
    800106d0:	00000097          	auipc	ra,0x0
    800106d4:	75c080e7          	jalr	1884(ra) # 80010e2c <_ZN6ThreadD1Ev>
    800106d8:	00048513          	mv	a0,s1
    800106dc:	00000097          	auipc	ra,0x0
    800106e0:	7e0080e7          	jalr	2016(ra) # 80010ebc <_ZdlPv>
    800106e4:	01813083          	ld	ra,24(sp)
    800106e8:	01013403          	ld	s0,16(sp)
    800106ec:	00813483          	ld	s1,8(sp)
    800106f0:	02010113          	addi	sp,sp,32
    800106f4:	00008067          	ret

00000000800106f8 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800106f8:	ff010113          	addi	sp,sp,-16
    800106fc:	00113423          	sd	ra,8(sp)
    80010700:	00813023          	sd	s0,0(sp)
    80010704:	01010413          	addi	s0,sp,16
    80010708:	00002797          	auipc	a5,0x2
    8001070c:	b5878793          	addi	a5,a5,-1192 # 80012260 <_ZTV16ProducerKeyboard+0x10>
    80010710:	00f53023          	sd	a5,0(a0)
    80010714:	00000097          	auipc	ra,0x0
    80010718:	718080e7          	jalr	1816(ra) # 80010e2c <_ZN6ThreadD1Ev>
    8001071c:	00813083          	ld	ra,8(sp)
    80010720:	00013403          	ld	s0,0(sp)
    80010724:	01010113          	addi	sp,sp,16
    80010728:	00008067          	ret

000000008001072c <_ZN16ProducerKeyboardD0Ev>:
    8001072c:	fe010113          	addi	sp,sp,-32
    80010730:	00113c23          	sd	ra,24(sp)
    80010734:	00813823          	sd	s0,16(sp)
    80010738:	00913423          	sd	s1,8(sp)
    8001073c:	02010413          	addi	s0,sp,32
    80010740:	00050493          	mv	s1,a0
    80010744:	00002797          	auipc	a5,0x2
    80010748:	b1c78793          	addi	a5,a5,-1252 # 80012260 <_ZTV16ProducerKeyboard+0x10>
    8001074c:	00f53023          	sd	a5,0(a0)
    80010750:	00000097          	auipc	ra,0x0
    80010754:	6dc080e7          	jalr	1756(ra) # 80010e2c <_ZN6ThreadD1Ev>
    80010758:	00048513          	mv	a0,s1
    8001075c:	00000097          	auipc	ra,0x0
    80010760:	760080e7          	jalr	1888(ra) # 80010ebc <_ZdlPv>
    80010764:	01813083          	ld	ra,24(sp)
    80010768:	01013403          	ld	s0,16(sp)
    8001076c:	00813483          	ld	s1,8(sp)
    80010770:	02010113          	addi	sp,sp,32
    80010774:	00008067          	ret

0000000080010778 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80010778:	ff010113          	addi	sp,sp,-16
    8001077c:	00113423          	sd	ra,8(sp)
    80010780:	00813023          	sd	s0,0(sp)
    80010784:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80010788:	01053583          	ld	a1,16(a0)
    8001078c:	fffff097          	auipc	ra,0xfffff
    80010790:	714080e7          	jalr	1812(ra) # 8000fea0 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80010794:	00813083          	ld	ra,8(sp)
    80010798:	00013403          	ld	s0,0(sp)
    8001079c:	01010113          	addi	sp,sp,16
    800107a0:	00008067          	ret

00000000800107a4 <_ZN8Producer3runEv>:
    void run() override {
    800107a4:	ff010113          	addi	sp,sp,-16
    800107a8:	00113423          	sd	ra,8(sp)
    800107ac:	00813023          	sd	s0,0(sp)
    800107b0:	01010413          	addi	s0,sp,16
        producer(td);
    800107b4:	01053583          	ld	a1,16(a0)
    800107b8:	fffff097          	auipc	ra,0xfffff
    800107bc:	7a8080e7          	jalr	1960(ra) # 8000ff60 <_ZN8Producer8producerEPv>
    }
    800107c0:	00813083          	ld	ra,8(sp)
    800107c4:	00013403          	ld	s0,0(sp)
    800107c8:	01010113          	addi	sp,sp,16
    800107cc:	00008067          	ret

00000000800107d0 <_ZN8Consumer3runEv>:
    void run() override {
    800107d0:	ff010113          	addi	sp,sp,-16
    800107d4:	00113423          	sd	ra,8(sp)
    800107d8:	00813023          	sd	s0,0(sp)
    800107dc:	01010413          	addi	s0,sp,16
        consumer(td);
    800107e0:	01053583          	ld	a1,16(a0)
    800107e4:	00000097          	auipc	ra,0x0
    800107e8:	810080e7          	jalr	-2032(ra) # 8000fff4 <_ZN8Consumer8consumerEPv>
    }
    800107ec:	00813083          	ld	ra,8(sp)
    800107f0:	00013403          	ld	s0,0(sp)
    800107f4:	01010113          	addi	sp,sp,16
    800107f8:	00008067          	ret

00000000800107fc <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800107fc:	fe010113          	addi	sp,sp,-32
    80010800:	00113c23          	sd	ra,24(sp)
    80010804:	00813823          	sd	s0,16(sp)
    80010808:	00913423          	sd	s1,8(sp)
    8001080c:	01213023          	sd	s2,0(sp)
    80010810:	02010413          	addi	s0,sp,32
    80010814:	00050493          	mv	s1,a0
    80010818:	00058913          	mv	s2,a1
    8001081c:	0015879b          	addiw	a5,a1,1
    80010820:	0007851b          	sext.w	a0,a5
    80010824:	00f4a023          	sw	a5,0(s1)
    80010828:	0004a823          	sw	zero,16(s1)
    8001082c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80010830:	00251513          	slli	a0,a0,0x2
    80010834:	ffffe097          	auipc	ra,0xffffe
    80010838:	7ec080e7          	jalr	2028(ra) # 8000f020 <_Z9mem_allocm>
    8001083c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80010840:	00000593          	li	a1,0
    80010844:	02048513          	addi	a0,s1,32
    80010848:	fffff097          	auipc	ra,0xfffff
    8001084c:	9d4080e7          	jalr	-1580(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80010850:	00090593          	mv	a1,s2
    80010854:	01848513          	addi	a0,s1,24
    80010858:	fffff097          	auipc	ra,0xfffff
    8001085c:	9c4080e7          	jalr	-1596(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80010860:	00100593          	li	a1,1
    80010864:	02848513          	addi	a0,s1,40
    80010868:	fffff097          	auipc	ra,0xfffff
    8001086c:	9b4080e7          	jalr	-1612(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80010870:	00100593          	li	a1,1
    80010874:	03048513          	addi	a0,s1,48
    80010878:	fffff097          	auipc	ra,0xfffff
    8001087c:	9a4080e7          	jalr	-1628(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
}
    80010880:	01813083          	ld	ra,24(sp)
    80010884:	01013403          	ld	s0,16(sp)
    80010888:	00813483          	ld	s1,8(sp)
    8001088c:	00013903          	ld	s2,0(sp)
    80010890:	02010113          	addi	sp,sp,32
    80010894:	00008067          	ret

0000000080010898 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80010898:	fe010113          	addi	sp,sp,-32
    8001089c:	00113c23          	sd	ra,24(sp)
    800108a0:	00813823          	sd	s0,16(sp)
    800108a4:	00913423          	sd	s1,8(sp)
    800108a8:	01213023          	sd	s2,0(sp)
    800108ac:	02010413          	addi	s0,sp,32
    800108b0:	00050493          	mv	s1,a0
    800108b4:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800108b8:	01853503          	ld	a0,24(a0)
    800108bc:	fffff097          	auipc	ra,0xfffff
    800108c0:	9c4080e7          	jalr	-1596(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    800108c4:	0304b503          	ld	a0,48(s1)
    800108c8:	fffff097          	auipc	ra,0xfffff
    800108cc:	9b8080e7          	jalr	-1608(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    800108d0:	0084b783          	ld	a5,8(s1)
    800108d4:	0144a703          	lw	a4,20(s1)
    800108d8:	00271713          	slli	a4,a4,0x2
    800108dc:	00e787b3          	add	a5,a5,a4
    800108e0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800108e4:	0144a783          	lw	a5,20(s1)
    800108e8:	0017879b          	addiw	a5,a5,1
    800108ec:	0004a703          	lw	a4,0(s1)
    800108f0:	02e7e7bb          	remw	a5,a5,a4
    800108f4:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800108f8:	0304b503          	ld	a0,48(s1)
    800108fc:	fffff097          	auipc	ra,0xfffff
    80010900:	9b0080e7          	jalr	-1616(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80010904:	0204b503          	ld	a0,32(s1)
    80010908:	fffff097          	auipc	ra,0xfffff
    8001090c:	9a4080e7          	jalr	-1628(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

}
    80010910:	01813083          	ld	ra,24(sp)
    80010914:	01013403          	ld	s0,16(sp)
    80010918:	00813483          	ld	s1,8(sp)
    8001091c:	00013903          	ld	s2,0(sp)
    80010920:	02010113          	addi	sp,sp,32
    80010924:	00008067          	ret

0000000080010928 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80010928:	fe010113          	addi	sp,sp,-32
    8001092c:	00113c23          	sd	ra,24(sp)
    80010930:	00813823          	sd	s0,16(sp)
    80010934:	00913423          	sd	s1,8(sp)
    80010938:	01213023          	sd	s2,0(sp)
    8001093c:	02010413          	addi	s0,sp,32
    80010940:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80010944:	02053503          	ld	a0,32(a0)
    80010948:	fffff097          	auipc	ra,0xfffff
    8001094c:	938080e7          	jalr	-1736(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80010950:	0284b503          	ld	a0,40(s1)
    80010954:	fffff097          	auipc	ra,0xfffff
    80010958:	92c080e7          	jalr	-1748(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8001095c:	0084b703          	ld	a4,8(s1)
    80010960:	0104a783          	lw	a5,16(s1)
    80010964:	00279693          	slli	a3,a5,0x2
    80010968:	00d70733          	add	a4,a4,a3
    8001096c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80010970:	0017879b          	addiw	a5,a5,1
    80010974:	0004a703          	lw	a4,0(s1)
    80010978:	02e7e7bb          	remw	a5,a5,a4
    8001097c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80010980:	0284b503          	ld	a0,40(s1)
    80010984:	fffff097          	auipc	ra,0xfffff
    80010988:	928080e7          	jalr	-1752(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    8001098c:	0184b503          	ld	a0,24(s1)
    80010990:	fffff097          	auipc	ra,0xfffff
    80010994:	91c080e7          	jalr	-1764(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80010998:	00090513          	mv	a0,s2
    8001099c:	01813083          	ld	ra,24(sp)
    800109a0:	01013403          	ld	s0,16(sp)
    800109a4:	00813483          	ld	s1,8(sp)
    800109a8:	00013903          	ld	s2,0(sp)
    800109ac:	02010113          	addi	sp,sp,32
    800109b0:	00008067          	ret

00000000800109b4 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800109b4:	fe010113          	addi	sp,sp,-32
    800109b8:	00113c23          	sd	ra,24(sp)
    800109bc:	00813823          	sd	s0,16(sp)
    800109c0:	00913423          	sd	s1,8(sp)
    800109c4:	01213023          	sd	s2,0(sp)
    800109c8:	02010413          	addi	s0,sp,32
    800109cc:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800109d0:	02853503          	ld	a0,40(a0)
    800109d4:	fffff097          	auipc	ra,0xfffff
    800109d8:	8ac080e7          	jalr	-1876(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    800109dc:	0304b503          	ld	a0,48(s1)
    800109e0:	fffff097          	auipc	ra,0xfffff
    800109e4:	8a0080e7          	jalr	-1888(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    800109e8:	0144a783          	lw	a5,20(s1)
    800109ec:	0104a903          	lw	s2,16(s1)
    800109f0:	0327ce63          	blt	a5,s2,80010a2c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800109f4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800109f8:	0304b503          	ld	a0,48(s1)
    800109fc:	fffff097          	auipc	ra,0xfffff
    80010a00:	8b0080e7          	jalr	-1872(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80010a04:	0284b503          	ld	a0,40(s1)
    80010a08:	fffff097          	auipc	ra,0xfffff
    80010a0c:	8a4080e7          	jalr	-1884(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80010a10:	00090513          	mv	a0,s2
    80010a14:	01813083          	ld	ra,24(sp)
    80010a18:	01013403          	ld	s0,16(sp)
    80010a1c:	00813483          	ld	s1,8(sp)
    80010a20:	00013903          	ld	s2,0(sp)
    80010a24:	02010113          	addi	sp,sp,32
    80010a28:	00008067          	ret
        ret = cap - head + tail;
    80010a2c:	0004a703          	lw	a4,0(s1)
    80010a30:	4127093b          	subw	s2,a4,s2
    80010a34:	00f9093b          	addw	s2,s2,a5
    80010a38:	fc1ff06f          	j	800109f8 <_ZN6Buffer6getCntEv+0x44>

0000000080010a3c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80010a3c:	fe010113          	addi	sp,sp,-32
    80010a40:	00113c23          	sd	ra,24(sp)
    80010a44:	00813823          	sd	s0,16(sp)
    80010a48:	00913423          	sd	s1,8(sp)
    80010a4c:	02010413          	addi	s0,sp,32
    80010a50:	00050493          	mv	s1,a0
    putc('\n');
    80010a54:	00a00513          	li	a0,10
    80010a58:	fffff097          	auipc	ra,0xfffff
    80010a5c:	8d4080e7          	jalr	-1836(ra) # 8000f32c <_Z4putcc>
    printString("Buffer deleted!\n");
    80010a60:	00001517          	auipc	a0,0x1
    80010a64:	5a050513          	addi	a0,a0,1440 # 80012000 <userDataStart>
    80010a68:	00000097          	auipc	ra,0x0
    80010a6c:	0b4080e7          	jalr	180(ra) # 80010b1c <_Z11printStringPKc>
    while (getCnt() > 0) {
    80010a70:	00048513          	mv	a0,s1
    80010a74:	00000097          	auipc	ra,0x0
    80010a78:	f40080e7          	jalr	-192(ra) # 800109b4 <_ZN6Buffer6getCntEv>
    80010a7c:	02a05c63          	blez	a0,80010ab4 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80010a80:	0084b783          	ld	a5,8(s1)
    80010a84:	0104a703          	lw	a4,16(s1)
    80010a88:	00271713          	slli	a4,a4,0x2
    80010a8c:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80010a90:	0007c503          	lbu	a0,0(a5)
    80010a94:	fffff097          	auipc	ra,0xfffff
    80010a98:	898080e7          	jalr	-1896(ra) # 8000f32c <_Z4putcc>
        head = (head + 1) % cap;
    80010a9c:	0104a783          	lw	a5,16(s1)
    80010aa0:	0017879b          	addiw	a5,a5,1
    80010aa4:	0004a703          	lw	a4,0(s1)
    80010aa8:	02e7e7bb          	remw	a5,a5,a4
    80010aac:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80010ab0:	fc1ff06f          	j	80010a70 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80010ab4:	02100513          	li	a0,33
    80010ab8:	fffff097          	auipc	ra,0xfffff
    80010abc:	874080e7          	jalr	-1932(ra) # 8000f32c <_Z4putcc>
    putc('\n');
    80010ac0:	00a00513          	li	a0,10
    80010ac4:	fffff097          	auipc	ra,0xfffff
    80010ac8:	868080e7          	jalr	-1944(ra) # 8000f32c <_Z4putcc>
    mem_free(buffer);
    80010acc:	0084b503          	ld	a0,8(s1)
    80010ad0:	ffffe097          	auipc	ra,0xffffe
    80010ad4:	580080e7          	jalr	1408(ra) # 8000f050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80010ad8:	0204b503          	ld	a0,32(s1)
    80010adc:	ffffe097          	auipc	ra,0xffffe
    80010ae0:	778080e7          	jalr	1912(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80010ae4:	0184b503          	ld	a0,24(s1)
    80010ae8:	ffffe097          	auipc	ra,0xffffe
    80010aec:	76c080e7          	jalr	1900(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80010af0:	0304b503          	ld	a0,48(s1)
    80010af4:	ffffe097          	auipc	ra,0xffffe
    80010af8:	760080e7          	jalr	1888(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80010afc:	0284b503          	ld	a0,40(s1)
    80010b00:	ffffe097          	auipc	ra,0xffffe
    80010b04:	754080e7          	jalr	1876(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
}
    80010b08:	01813083          	ld	ra,24(sp)
    80010b0c:	01013403          	ld	s0,16(sp)
    80010b10:	00813483          	ld	s1,8(sp)
    80010b14:	02010113          	addi	sp,sp,32
    80010b18:	00008067          	ret

0000000080010b1c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80010b1c:	fe010113          	addi	sp,sp,-32
    80010b20:	00113c23          	sd	ra,24(sp)
    80010b24:	00813823          	sd	s0,16(sp)
    80010b28:	00913423          	sd	s1,8(sp)
    80010b2c:	02010413          	addi	s0,sp,32
    80010b30:	00050493          	mv	s1,a0
    LOCK();
    80010b34:	00100613          	li	a2,1
    80010b38:	00000593          	li	a1,0
    80010b3c:	00002517          	auipc	a0,0x2
    80010b40:	85c50513          	addi	a0,a0,-1956 # 80012398 <lockPrint>
    80010b44:	ffffe097          	auipc	ra,0xffffe
    80010b48:	4bc080e7          	jalr	1212(ra) # 8000f000 <copy_and_swap>
    80010b4c:	fe0514e3          	bnez	a0,80010b34 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80010b50:	0004c503          	lbu	a0,0(s1)
    80010b54:	00050a63          	beqz	a0,80010b68 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80010b58:	ffffe097          	auipc	ra,0xffffe
    80010b5c:	7d4080e7          	jalr	2004(ra) # 8000f32c <_Z4putcc>
        string++;
    80010b60:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80010b64:	fedff06f          	j	80010b50 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80010b68:	00000613          	li	a2,0
    80010b6c:	00100593          	li	a1,1
    80010b70:	00002517          	auipc	a0,0x2
    80010b74:	82850513          	addi	a0,a0,-2008 # 80012398 <lockPrint>
    80010b78:	ffffe097          	auipc	ra,0xffffe
    80010b7c:	488080e7          	jalr	1160(ra) # 8000f000 <copy_and_swap>
    80010b80:	fe0514e3          	bnez	a0,80010b68 <_Z11printStringPKc+0x4c>
}
    80010b84:	01813083          	ld	ra,24(sp)
    80010b88:	01013403          	ld	s0,16(sp)
    80010b8c:	00813483          	ld	s1,8(sp)
    80010b90:	02010113          	addi	sp,sp,32
    80010b94:	00008067          	ret

0000000080010b98 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80010b98:	fd010113          	addi	sp,sp,-48
    80010b9c:	02113423          	sd	ra,40(sp)
    80010ba0:	02813023          	sd	s0,32(sp)
    80010ba4:	00913c23          	sd	s1,24(sp)
    80010ba8:	01213823          	sd	s2,16(sp)
    80010bac:	01313423          	sd	s3,8(sp)
    80010bb0:	01413023          	sd	s4,0(sp)
    80010bb4:	03010413          	addi	s0,sp,48
    80010bb8:	00050993          	mv	s3,a0
    80010bbc:	00058a13          	mv	s4,a1
    LOCK();
    80010bc0:	00100613          	li	a2,1
    80010bc4:	00000593          	li	a1,0
    80010bc8:	00001517          	auipc	a0,0x1
    80010bcc:	7d050513          	addi	a0,a0,2000 # 80012398 <lockPrint>
    80010bd0:	ffffe097          	auipc	ra,0xffffe
    80010bd4:	430080e7          	jalr	1072(ra) # 8000f000 <copy_and_swap>
    80010bd8:	fe0514e3          	bnez	a0,80010bc0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80010bdc:	00000913          	li	s2,0
    80010be0:	00090493          	mv	s1,s2
    80010be4:	0019091b          	addiw	s2,s2,1
    80010be8:	03495a63          	bge	s2,s4,80010c1c <_Z9getStringPci+0x84>
        cc = getc();
    80010bec:	ffffe097          	auipc	ra,0xffffe
    80010bf0:	718080e7          	jalr	1816(ra) # 8000f304 <_Z4getcv>
        if(cc < 1)
    80010bf4:	02050463          	beqz	a0,80010c1c <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80010bf8:	009984b3          	add	s1,s3,s1
    80010bfc:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80010c00:	00a00793          	li	a5,10
    80010c04:	00f50a63          	beq	a0,a5,80010c18 <_Z9getStringPci+0x80>
    80010c08:	00d00793          	li	a5,13
    80010c0c:	fcf51ae3          	bne	a0,a5,80010be0 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80010c10:	00090493          	mv	s1,s2
    80010c14:	0080006f          	j	80010c1c <_Z9getStringPci+0x84>
    80010c18:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80010c1c:	009984b3          	add	s1,s3,s1
    80010c20:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80010c24:	00000613          	li	a2,0
    80010c28:	00100593          	li	a1,1
    80010c2c:	00001517          	auipc	a0,0x1
    80010c30:	76c50513          	addi	a0,a0,1900 # 80012398 <lockPrint>
    80010c34:	ffffe097          	auipc	ra,0xffffe
    80010c38:	3cc080e7          	jalr	972(ra) # 8000f000 <copy_and_swap>
    80010c3c:	fe0514e3          	bnez	a0,80010c24 <_Z9getStringPci+0x8c>
    return buf;
}
    80010c40:	00098513          	mv	a0,s3
    80010c44:	02813083          	ld	ra,40(sp)
    80010c48:	02013403          	ld	s0,32(sp)
    80010c4c:	01813483          	ld	s1,24(sp)
    80010c50:	01013903          	ld	s2,16(sp)
    80010c54:	00813983          	ld	s3,8(sp)
    80010c58:	00013a03          	ld	s4,0(sp)
    80010c5c:	03010113          	addi	sp,sp,48
    80010c60:	00008067          	ret

0000000080010c64 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80010c64:	ff010113          	addi	sp,sp,-16
    80010c68:	00813423          	sd	s0,8(sp)
    80010c6c:	01010413          	addi	s0,sp,16
    80010c70:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80010c74:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80010c78:	0006c603          	lbu	a2,0(a3)
    80010c7c:	fd06071b          	addiw	a4,a2,-48
    80010c80:	0ff77713          	andi	a4,a4,255
    80010c84:	00900793          	li	a5,9
    80010c88:	02e7e063          	bltu	a5,a4,80010ca8 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80010c8c:	0025179b          	slliw	a5,a0,0x2
    80010c90:	00a787bb          	addw	a5,a5,a0
    80010c94:	0017979b          	slliw	a5,a5,0x1
    80010c98:	00168693          	addi	a3,a3,1
    80010c9c:	00c787bb          	addw	a5,a5,a2
    80010ca0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80010ca4:	fd5ff06f          	j	80010c78 <_Z11stringToIntPKc+0x14>
    return n;
}
    80010ca8:	00813403          	ld	s0,8(sp)
    80010cac:	01010113          	addi	sp,sp,16
    80010cb0:	00008067          	ret

0000000080010cb4 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80010cb4:	fc010113          	addi	sp,sp,-64
    80010cb8:	02113c23          	sd	ra,56(sp)
    80010cbc:	02813823          	sd	s0,48(sp)
    80010cc0:	02913423          	sd	s1,40(sp)
    80010cc4:	03213023          	sd	s2,32(sp)
    80010cc8:	01313c23          	sd	s3,24(sp)
    80010ccc:	04010413          	addi	s0,sp,64
    80010cd0:	00050493          	mv	s1,a0
    80010cd4:	00058913          	mv	s2,a1
    80010cd8:	00060993          	mv	s3,a2
    LOCK();
    80010cdc:	00100613          	li	a2,1
    80010ce0:	00000593          	li	a1,0
    80010ce4:	00001517          	auipc	a0,0x1
    80010ce8:	6b450513          	addi	a0,a0,1716 # 80012398 <lockPrint>
    80010cec:	ffffe097          	auipc	ra,0xffffe
    80010cf0:	314080e7          	jalr	788(ra) # 8000f000 <copy_and_swap>
    80010cf4:	fe0514e3          	bnez	a0,80010cdc <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80010cf8:	00098463          	beqz	s3,80010d00 <_Z8printIntiii+0x4c>
    80010cfc:	0804c463          	bltz	s1,80010d84 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80010d00:	0004851b          	sext.w	a0,s1
    neg = 0;
    80010d04:	00000593          	li	a1,0
    }

    i = 0;
    80010d08:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80010d0c:	0009079b          	sext.w	a5,s2
    80010d10:	0325773b          	remuw	a4,a0,s2
    80010d14:	00048613          	mv	a2,s1
    80010d18:	0014849b          	addiw	s1,s1,1
    80010d1c:	02071693          	slli	a3,a4,0x20
    80010d20:	0206d693          	srli	a3,a3,0x20
    80010d24:	00001717          	auipc	a4,0x1
    80010d28:	5a470713          	addi	a4,a4,1444 # 800122c8 <digits>
    80010d2c:	00d70733          	add	a4,a4,a3
    80010d30:	00074683          	lbu	a3,0(a4)
    80010d34:	fd040713          	addi	a4,s0,-48
    80010d38:	00c70733          	add	a4,a4,a2
    80010d3c:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80010d40:	0005071b          	sext.w	a4,a0
    80010d44:	0325553b          	divuw	a0,a0,s2
    80010d48:	fcf772e3          	bgeu	a4,a5,80010d0c <_Z8printIntiii+0x58>
    if(neg)
    80010d4c:	00058c63          	beqz	a1,80010d64 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80010d50:	fd040793          	addi	a5,s0,-48
    80010d54:	009784b3          	add	s1,a5,s1
    80010d58:	02d00793          	li	a5,45
    80010d5c:	fef48823          	sb	a5,-16(s1)
    80010d60:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80010d64:	fff4849b          	addiw	s1,s1,-1
    80010d68:	0204c463          	bltz	s1,80010d90 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80010d6c:	fd040793          	addi	a5,s0,-48
    80010d70:	009787b3          	add	a5,a5,s1
    80010d74:	ff07c503          	lbu	a0,-16(a5)
    80010d78:	ffffe097          	auipc	ra,0xffffe
    80010d7c:	5b4080e7          	jalr	1460(ra) # 8000f32c <_Z4putcc>
    80010d80:	fe5ff06f          	j	80010d64 <_Z8printIntiii+0xb0>
        x = -xx;
    80010d84:	4090053b          	negw	a0,s1
        neg = 1;
    80010d88:	00100593          	li	a1,1
        x = -xx;
    80010d8c:	f7dff06f          	j	80010d08 <_Z8printIntiii+0x54>

    UNLOCK();
    80010d90:	00000613          	li	a2,0
    80010d94:	00100593          	li	a1,1
    80010d98:	00001517          	auipc	a0,0x1
    80010d9c:	60050513          	addi	a0,a0,1536 # 80012398 <lockPrint>
    80010da0:	ffffe097          	auipc	ra,0xffffe
    80010da4:	260080e7          	jalr	608(ra) # 8000f000 <copy_and_swap>
    80010da8:	fe0514e3          	bnez	a0,80010d90 <_Z8printIntiii+0xdc>
    80010dac:	03813083          	ld	ra,56(sp)
    80010db0:	03013403          	ld	s0,48(sp)
    80010db4:	02813483          	ld	s1,40(sp)
    80010db8:	02013903          	ld	s2,32(sp)
    80010dbc:	01813983          	ld	s3,24(sp)
    80010dc0:	04010113          	addi	sp,sp,64
    80010dc4:	00008067          	ret

0000000080010dc8 <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    80010dc8:	ff010113          	addi	sp,sp,-16
    80010dcc:	00113423          	sd	ra,8(sp)
    80010dd0:	00813023          	sd	s0,0(sp)
    80010dd4:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80010dd8:	00053783          	ld	a5,0(a0)
    80010ddc:	0107b783          	ld	a5,16(a5)
    80010de0:	000780e7          	jalr	a5
}
    80010de4:	00813083          	ld	ra,8(sp)
    80010de8:	00013403          	ld	s0,0(sp)
    80010dec:	01010113          	addi	sp,sp,16
    80010df0:	00008067          	ret

0000000080010df4 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80010df4:	ff010113          	addi	sp,sp,-16
    80010df8:	00113423          	sd	ra,8(sp)
    80010dfc:	00813023          	sd	s0,0(sp)
    80010e00:	01010413          	addi	s0,sp,16
    80010e04:	00001797          	auipc	a5,0x1
    80010e08:	51c78793          	addi	a5,a5,1308 # 80012320 <_ZTV9Semaphore+0x10>
    80010e0c:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80010e10:	00853503          	ld	a0,8(a0)
    80010e14:	ffffe097          	auipc	ra,0xffffe
    80010e18:	440080e7          	jalr	1088(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
};
    80010e1c:	00813083          	ld	ra,8(sp)
    80010e20:	00013403          	ld	s0,0(sp)
    80010e24:	01010113          	addi	sp,sp,16
    80010e28:	00008067          	ret

0000000080010e2c <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80010e2c:	00001797          	auipc	a5,0x1
    80010e30:	51478793          	addi	a5,a5,1300 # 80012340 <_ZTV6Thread+0x10>
    80010e34:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80010e38:	00853503          	ld	a0,8(a0)
    80010e3c:	02050663          	beqz	a0,80010e68 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80010e40:	ff010113          	addi	sp,sp,-16
    80010e44:	00113423          	sd	ra,8(sp)
    80010e48:	00813023          	sd	s0,0(sp)
    80010e4c:	01010413          	addi	s0,sp,16
    delete myHandle;
    80010e50:	ffffe097          	auipc	ra,0xffffe
    80010e54:	574080e7          	jalr	1396(ra) # 8000f3c4 <_ZN7_threaddlEPv>
}
    80010e58:	00813083          	ld	ra,8(sp)
    80010e5c:	00013403          	ld	s0,0(sp)
    80010e60:	01010113          	addi	sp,sp,16
    80010e64:	00008067          	ret
    80010e68:	00008067          	ret

0000000080010e6c <_Znwm>:
void* operator new(size_t sz){
    80010e6c:	ff010113          	addi	sp,sp,-16
    80010e70:	00113423          	sd	ra,8(sp)
    80010e74:	00813023          	sd	s0,0(sp)
    80010e78:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80010e7c:	ffffe097          	auipc	ra,0xffffe
    80010e80:	1a4080e7          	jalr	420(ra) # 8000f020 <_Z9mem_allocm>
}
    80010e84:	00813083          	ld	ra,8(sp)
    80010e88:	00013403          	ld	s0,0(sp)
    80010e8c:	01010113          	addi	sp,sp,16
    80010e90:	00008067          	ret

0000000080010e94 <_Znam>:
void* operator new[](size_t sz){
    80010e94:	ff010113          	addi	sp,sp,-16
    80010e98:	00113423          	sd	ra,8(sp)
    80010e9c:	00813023          	sd	s0,0(sp)
    80010ea0:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80010ea4:	ffffe097          	auipc	ra,0xffffe
    80010ea8:	17c080e7          	jalr	380(ra) # 8000f020 <_Z9mem_allocm>
}
    80010eac:	00813083          	ld	ra,8(sp)
    80010eb0:	00013403          	ld	s0,0(sp)
    80010eb4:	01010113          	addi	sp,sp,16
    80010eb8:	00008067          	ret

0000000080010ebc <_ZdlPv>:
void operator delete(void *ptr){
    80010ebc:	ff010113          	addi	sp,sp,-16
    80010ec0:	00113423          	sd	ra,8(sp)
    80010ec4:	00813023          	sd	s0,0(sp)
    80010ec8:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80010ecc:	ffffe097          	auipc	ra,0xffffe
    80010ed0:	184080e7          	jalr	388(ra) # 8000f050 <_Z8mem_freePv>
}
    80010ed4:	00813083          	ld	ra,8(sp)
    80010ed8:	00013403          	ld	s0,0(sp)
    80010edc:	01010113          	addi	sp,sp,16
    80010ee0:	00008067          	ret

0000000080010ee4 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80010ee4:	fe010113          	addi	sp,sp,-32
    80010ee8:	00113c23          	sd	ra,24(sp)
    80010eec:	00813823          	sd	s0,16(sp)
    80010ef0:	00913423          	sd	s1,8(sp)
    80010ef4:	02010413          	addi	s0,sp,32
    80010ef8:	00050493          	mv	s1,a0
};
    80010efc:	00000097          	auipc	ra,0x0
    80010f00:	ef8080e7          	jalr	-264(ra) # 80010df4 <_ZN9SemaphoreD1Ev>
    80010f04:	00048513          	mv	a0,s1
    80010f08:	00000097          	auipc	ra,0x0
    80010f0c:	fb4080e7          	jalr	-76(ra) # 80010ebc <_ZdlPv>
    80010f10:	01813083          	ld	ra,24(sp)
    80010f14:	01013403          	ld	s0,16(sp)
    80010f18:	00813483          	ld	s1,8(sp)
    80010f1c:	02010113          	addi	sp,sp,32
    80010f20:	00008067          	ret

0000000080010f24 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80010f24:	fe010113          	addi	sp,sp,-32
    80010f28:	00113c23          	sd	ra,24(sp)
    80010f2c:	00813823          	sd	s0,16(sp)
    80010f30:	00913423          	sd	s1,8(sp)
    80010f34:	02010413          	addi	s0,sp,32
    80010f38:	00050493          	mv	s1,a0
}
    80010f3c:	00000097          	auipc	ra,0x0
    80010f40:	ef0080e7          	jalr	-272(ra) # 80010e2c <_ZN6ThreadD1Ev>
    80010f44:	00048513          	mv	a0,s1
    80010f48:	00000097          	auipc	ra,0x0
    80010f4c:	f74080e7          	jalr	-140(ra) # 80010ebc <_ZdlPv>
    80010f50:	01813083          	ld	ra,24(sp)
    80010f54:	01013403          	ld	s0,16(sp)
    80010f58:	00813483          	ld	s1,8(sp)
    80010f5c:	02010113          	addi	sp,sp,32
    80010f60:	00008067          	ret

0000000080010f64 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80010f64:	ff010113          	addi	sp,sp,-16
    80010f68:	00113423          	sd	ra,8(sp)
    80010f6c:	00813023          	sd	s0,0(sp)
    80010f70:	01010413          	addi	s0,sp,16
    80010f74:	00001797          	auipc	a5,0x1
    80010f78:	3ac78793          	addi	a5,a5,940 # 80012320 <_ZTV9Semaphore+0x10>
    80010f7c:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80010f80:	00850513          	addi	a0,a0,8
    80010f84:	ffffe097          	auipc	ra,0xffffe
    80010f88:	298080e7          	jalr	664(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
}
    80010f8c:	00813083          	ld	ra,8(sp)
    80010f90:	00013403          	ld	s0,0(sp)
    80010f94:	01010113          	addi	sp,sp,16
    80010f98:	00008067          	ret

0000000080010f9c <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80010f9c:	ff010113          	addi	sp,sp,-16
    80010fa0:	00113423          	sd	ra,8(sp)
    80010fa4:	00813023          	sd	s0,0(sp)
    80010fa8:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80010fac:	00853503          	ld	a0,8(a0)
    80010fb0:	ffffe097          	auipc	ra,0xffffe
    80010fb4:	2d0080e7          	jalr	720(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
}
    80010fb8:	00813083          	ld	ra,8(sp)
    80010fbc:	00013403          	ld	s0,0(sp)
    80010fc0:	01010113          	addi	sp,sp,16
    80010fc4:	00008067          	ret

0000000080010fc8 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80010fc8:	ff010113          	addi	sp,sp,-16
    80010fcc:	00113423          	sd	ra,8(sp)
    80010fd0:	00813023          	sd	s0,0(sp)
    80010fd4:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80010fd8:	00853503          	ld	a0,8(a0)
    80010fdc:	ffffe097          	auipc	ra,0xffffe
    80010fe0:	2d0080e7          	jalr	720(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>
}
    80010fe4:	00813083          	ld	ra,8(sp)
    80010fe8:	00013403          	ld	s0,0(sp)
    80010fec:	01010113          	addi	sp,sp,16
    80010ff0:	00008067          	ret

0000000080010ff4 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80010ff4:	fe010113          	addi	sp,sp,-32
    80010ff8:	00113c23          	sd	ra,24(sp)
    80010ffc:	00813823          	sd	s0,16(sp)
    80011000:	00913423          	sd	s1,8(sp)
    80011004:	02010413          	addi	s0,sp,32
    80011008:	00050493          	mv	s1,a0
    8001100c:	00001797          	auipc	a5,0x1
    80011010:	33478793          	addi	a5,a5,820 # 80012340 <_ZTV6Thread+0x10>
    80011014:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    80011018:	00850513          	addi	a0,a0,8
    8001101c:	ffffe097          	auipc	ra,0xffffe
    80011020:	134080e7          	jalr	308(ra) # 8000f150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80011024:	fff00793          	li	a5,-1
    80011028:	00f50c63          	beq	a0,a5,80011040 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    8001102c:	01813083          	ld	ra,24(sp)
    80011030:	01013403          	ld	s0,16(sp)
    80011034:	00813483          	ld	s1,8(sp)
    80011038:	02010113          	addi	sp,sp,32
    8001103c:	00008067          	ret
        myHandle = nullptr;
    80011040:	0004b423          	sd	zero,8(s1)
}
    80011044:	fe9ff06f          	j	8001102c <_ZN6ThreadC1EPFvPvES0_+0x38>

0000000080011048 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80011048:	fe010113          	addi	sp,sp,-32
    8001104c:	00113c23          	sd	ra,24(sp)
    80011050:	00813823          	sd	s0,16(sp)
    80011054:	00913423          	sd	s1,8(sp)
    80011058:	02010413          	addi	s0,sp,32
    8001105c:	00050493          	mv	s1,a0
    80011060:	00001797          	auipc	a5,0x1
    80011064:	2e078793          	addi	a5,a5,736 # 80012340 <_ZTV6Thread+0x10>
    80011068:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    8001106c:	00050613          	mv	a2,a0
    80011070:	00000597          	auipc	a1,0x0
    80011074:	d5858593          	addi	a1,a1,-680 # 80010dc8 <_ZN6Thread7wrapperEPv>
    80011078:	00850513          	addi	a0,a0,8
    8001107c:	ffffe097          	auipc	ra,0xffffe
    80011080:	0d4080e7          	jalr	212(ra) # 8000f150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80011084:	fff00793          	li	a5,-1
    80011088:	00f50c63          	beq	a0,a5,800110a0 <_ZN6ThreadC1Ev+0x58>
}
    8001108c:	01813083          	ld	ra,24(sp)
    80011090:	01013403          	ld	s0,16(sp)
    80011094:	00813483          	ld	s1,8(sp)
    80011098:	02010113          	addi	sp,sp,32
    8001109c:	00008067          	ret
        myHandle = nullptr;
    800110a0:	0004b423          	sd	zero,8(s1)
}
    800110a4:	fe9ff06f          	j	8001108c <_ZN6ThreadC1Ev+0x44>

00000000800110a8 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    800110a8:	ff010113          	addi	sp,sp,-16
    800110ac:	00113423          	sd	ra,8(sp)
    800110b0:	00813023          	sd	s0,0(sp)
    800110b4:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    800110b8:	ffffe097          	auipc	ra,0xffffe
    800110bc:	220080e7          	jalr	544(ra) # 8000f2d8 <_Z10time_sleepm>
}
    800110c0:	00813083          	ld	ra,8(sp)
    800110c4:	00013403          	ld	s0,0(sp)
    800110c8:	01010113          	addi	sp,sp,16
    800110cc:	00008067          	ret

00000000800110d0 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    800110d0:	fe010113          	addi	sp,sp,-32
    800110d4:	00113c23          	sd	ra,24(sp)
    800110d8:	00813823          	sd	s0,16(sp)
    800110dc:	00913423          	sd	s1,8(sp)
    800110e0:	01213023          	sd	s2,0(sp)
    800110e4:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    800110e8:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    800110ec:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    800110f0:	0004b783          	ld	a5,0(s1)
    800110f4:	0187b783          	ld	a5,24(a5)
    800110f8:	00048513          	mv	a0,s1
    800110fc:	000780e7          	jalr	a5
        pt->sleep(time);
    80011100:	00090513          	mv	a0,s2
    80011104:	00000097          	auipc	ra,0x0
    80011108:	fa4080e7          	jalr	-92(ra) # 800110a8 <_ZN6Thread5sleepEm>
    while(true){
    8001110c:	fe5ff06f          	j	800110f0 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080011110 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80011110:	ff010113          	addi	sp,sp,-16
    80011114:	00113423          	sd	ra,8(sp)
    80011118:	00813023          	sd	s0,0(sp)
    8001111c:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80011120:	ffffe097          	auipc	ra,0xffffe
    80011124:	010080e7          	jalr	16(ra) # 8000f130 <_Z15thread_dispatchv>
}
    80011128:	00813083          	ld	ra,8(sp)
    8001112c:	00013403          	ld	s0,0(sp)
    80011130:	01010113          	addi	sp,sp,16
    80011134:	00008067          	ret

0000000080011138 <_ZN6Thread5startEv>:
int Thread::start() {
    80011138:	ff010113          	addi	sp,sp,-16
    8001113c:	00113423          	sd	ra,8(sp)
    80011140:	00813023          	sd	s0,0(sp)
    80011144:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80011148:	00853503          	ld	a0,8(a0)
    8001114c:	ffffe097          	auipc	ra,0xffffe
    80011150:	098080e7          	jalr	152(ra) # 8000f1e4 <_Z12thread_startP7_thread>
}
    80011154:	00813083          	ld	ra,8(sp)
    80011158:	00013403          	ld	s0,0(sp)
    8001115c:	01010113          	addi	sp,sp,16
    80011160:	00008067          	ret

0000000080011164 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80011164:	fe010113          	addi	sp,sp,-32
    80011168:	00113c23          	sd	ra,24(sp)
    8001116c:	00813823          	sd	s0,16(sp)
    80011170:	00913423          	sd	s1,8(sp)
    80011174:	01213023          	sd	s2,0(sp)
    80011178:	02010413          	addi	s0,sp,32
    8001117c:	00050493          	mv	s1,a0
    80011180:	00058913          	mv	s2,a1
    80011184:	01000513          	li	a0,16
    80011188:	00000097          	auipc	ra,0x0
    8001118c:	ce4080e7          	jalr	-796(ra) # 80010e6c <_Znwm>
    80011190:	00050613          	mv	a2,a0
    80011194:	00050663          	beqz	a0,800111a0 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    80011198:	00953023          	sd	s1,0(a0)
    8001119c:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800111a0:	00000597          	auipc	a1,0x0
    800111a4:	f3058593          	addi	a1,a1,-208 # 800110d0 <_ZN14PeriodicThread7wrapperEPv>
    800111a8:	00048513          	mv	a0,s1
    800111ac:	00000097          	auipc	ra,0x0
    800111b0:	e48080e7          	jalr	-440(ra) # 80010ff4 <_ZN6ThreadC1EPFvPvES0_>
    800111b4:	00001797          	auipc	a5,0x1
    800111b8:	13c78793          	addi	a5,a5,316 # 800122f0 <_ZTV14PeriodicThread+0x10>
    800111bc:	00f4b023          	sd	a5,0(s1)
    800111c0:	01813083          	ld	ra,24(sp)
    800111c4:	01013403          	ld	s0,16(sp)
    800111c8:	00813483          	ld	s1,8(sp)
    800111cc:	00013903          	ld	s2,0(sp)
    800111d0:	02010113          	addi	sp,sp,32
    800111d4:	00008067          	ret

00000000800111d8 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    800111d8:	ff010113          	addi	sp,sp,-16
    800111dc:	00113423          	sd	ra,8(sp)
    800111e0:	00813023          	sd	s0,0(sp)
    800111e4:	01010413          	addi	s0,sp,16
    return ::getc();
    800111e8:	ffffe097          	auipc	ra,0xffffe
    800111ec:	11c080e7          	jalr	284(ra) # 8000f304 <_Z4getcv>
}
    800111f0:	00813083          	ld	ra,8(sp)
    800111f4:	00013403          	ld	s0,0(sp)
    800111f8:	01010113          	addi	sp,sp,16
    800111fc:	00008067          	ret

0000000080011200 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80011200:	ff010113          	addi	sp,sp,-16
    80011204:	00113423          	sd	ra,8(sp)
    80011208:	00813023          	sd	s0,0(sp)
    8001120c:	01010413          	addi	s0,sp,16
    ::putc(c);
    80011210:	ffffe097          	auipc	ra,0xffffe
    80011214:	11c080e7          	jalr	284(ra) # 8000f32c <_Z4putcc>
}
    80011218:	00813083          	ld	ra,8(sp)
    8001121c:	00013403          	ld	s0,0(sp)
    80011220:	01010113          	addi	sp,sp,16
    80011224:	00008067          	ret

0000000080011228 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80011228:	ff010113          	addi	sp,sp,-16
    8001122c:	00813423          	sd	s0,8(sp)
    80011230:	01010413          	addi	s0,sp,16
    80011234:	00813403          	ld	s0,8(sp)
    80011238:	01010113          	addi	sp,sp,16
    8001123c:	00008067          	ret

0000000080011240 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80011240:	ff010113          	addi	sp,sp,-16
    80011244:	00813423          	sd	s0,8(sp)
    80011248:	01010413          	addi	s0,sp,16
    8001124c:	00813403          	ld	s0,8(sp)
    80011250:	01010113          	addi	sp,sp,16
    80011254:	00008067          	ret

0000000080011258 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80011258:	ff010113          	addi	sp,sp,-16
    8001125c:	00113423          	sd	ra,8(sp)
    80011260:	00813023          	sd	s0,0(sp)
    80011264:	01010413          	addi	s0,sp,16
    80011268:	00001797          	auipc	a5,0x1
    8001126c:	08878793          	addi	a5,a5,136 # 800122f0 <_ZTV14PeriodicThread+0x10>
    80011270:	00f53023          	sd	a5,0(a0)
    80011274:	00000097          	auipc	ra,0x0
    80011278:	bb8080e7          	jalr	-1096(ra) # 80010e2c <_ZN6ThreadD1Ev>
    8001127c:	00813083          	ld	ra,8(sp)
    80011280:	00013403          	ld	s0,0(sp)
    80011284:	01010113          	addi	sp,sp,16
    80011288:	00008067          	ret

000000008001128c <_ZN14PeriodicThreadD0Ev>:
    8001128c:	fe010113          	addi	sp,sp,-32
    80011290:	00113c23          	sd	ra,24(sp)
    80011294:	00813823          	sd	s0,16(sp)
    80011298:	00913423          	sd	s1,8(sp)
    8001129c:	02010413          	addi	s0,sp,32
    800112a0:	00050493          	mv	s1,a0
    800112a4:	00001797          	auipc	a5,0x1
    800112a8:	04c78793          	addi	a5,a5,76 # 800122f0 <_ZTV14PeriodicThread+0x10>
    800112ac:	00f53023          	sd	a5,0(a0)
    800112b0:	00000097          	auipc	ra,0x0
    800112b4:	b7c080e7          	jalr	-1156(ra) # 80010e2c <_ZN6ThreadD1Ev>
    800112b8:	00048513          	mv	a0,s1
    800112bc:	00000097          	auipc	ra,0x0
    800112c0:	c00080e7          	jalr	-1024(ra) # 80010ebc <_ZdlPv>
    800112c4:	01813083          	ld	ra,24(sp)
    800112c8:	01013403          	ld	s0,16(sp)
    800112cc:	00813483          	ld	s1,8(sp)
    800112d0:	02010113          	addi	sp,sp,32
    800112d4:	00008067          	ret

00000000800112d8 <_Z8testUserv>:
    long id;
    bool finished;
};


void testUser() {
    800112d8:	fc010113          	addi	sp,sp,-64
    800112dc:	02113c23          	sd	ra,56(sp)
    800112e0:	02813823          	sd	s0,48(sp)
    800112e4:	02913423          	sd	s1,40(sp)
    800112e8:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    800112ec:	fc040493          	addi	s1,s0,-64
    800112f0:	00048513          	mv	a0,s1
    800112f4:	00000097          	auipc	ra,0x0
    800112f8:	d54080e7          	jalr	-684(ra) # 80011048 <_ZN6ThreadC1Ev>
    800112fc:	00001797          	auipc	a5,0x1
    80011300:	06c78793          	addi	a5,a5,108 # 80012368 <_ZTV10ForkThread+0x10>
    80011304:	fcf43023          	sd	a5,-64(s0)
    80011308:	00100793          	li	a5,1
    8001130c:	fcf43823          	sd	a5,-48(s0)
    80011310:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    80011314:	00048513          	mv	a0,s1
    80011318:	00000097          	auipc	ra,0x0
    8001131c:	e20080e7          	jalr	-480(ra) # 80011138 <_ZN6Thread5startEv>
        return finished;
    80011320:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    80011324:	00079863          	bnez	a5,80011334 <_Z8testUserv+0x5c>
        thread_dispatch();
    80011328:	ffffe097          	auipc	ra,0xffffe
    8001132c:	e08080e7          	jalr	-504(ra) # 8000f130 <_Z15thread_dispatchv>
    80011330:	ff1ff06f          	j	80011320 <_Z8testUserv+0x48>
    }

//    ConsoleUtil::printString("User main finished\n");
    printString("User main finished\n");
    80011334:	00001517          	auipc	a0,0x1
    80011338:	f0450513          	addi	a0,a0,-252 # 80012238 <userDataStart+0x238>
    8001133c:	fffff097          	auipc	ra,0xfffff
    80011340:	7e0080e7          	jalr	2016(ra) # 80010b1c <_Z11printStringPKc>
class ForkThread : public Thread {
    80011344:	00001797          	auipc	a5,0x1
    80011348:	02478793          	addi	a5,a5,36 # 80012368 <_ZTV10ForkThread+0x10>
    8001134c:	fcf43023          	sd	a5,-64(s0)
    80011350:	fc040513          	addi	a0,s0,-64
    80011354:	00000097          	auipc	ra,0x0
    80011358:	ad8080e7          	jalr	-1320(ra) # 80010e2c <_ZN6ThreadD1Ev>
    8001135c:	03813083          	ld	ra,56(sp)
    80011360:	03013403          	ld	s0,48(sp)
    80011364:	02813483          	ld	s1,40(sp)
    80011368:	04010113          	addi	sp,sp,64
    8001136c:	00008067          	ret
    80011370:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    80011374:	00001797          	auipc	a5,0x1
    80011378:	ff478793          	addi	a5,a5,-12 # 80012368 <_ZTV10ForkThread+0x10>
    8001137c:	fcf43023          	sd	a5,-64(s0)
    80011380:	fc040513          	addi	a0,s0,-64
    80011384:	00000097          	auipc	ra,0x0
    80011388:	aa8080e7          	jalr	-1368(ra) # 80010e2c <_ZN6ThreadD1Ev>
    8001138c:	00048513          	mv	a0,s1
    80011390:	ffffc097          	auipc	ra,0xffffc
    80011394:	b68080e7          	jalr	-1176(ra) # 8000cef8 <_Unwind_Resume>

0000000080011398 <_ZN10TCBWrapper7tcbWrapEPFvPvES0_>:
#include "../../h/syscall_c.h"
#include "../../src/user/tests/testUser.hpp"
#include "../../src/user/tests/userMain.hpp"

void TCBWrapper::tcbWrap(void (*body)(void*), void* args)
{
    80011398:	ff010113          	addi	sp,sp,-16
    8001139c:	00113423          	sd	ra,8(sp)
    800113a0:	00813023          	sd	s0,0(sp)
    800113a4:	01010413          	addi	s0,sp,16
    800113a8:	00050793          	mv	a5,a0
    body(args);
    800113ac:	00058513          	mv	a0,a1
    800113b0:	000780e7          	jalr	a5
    thread_exit();
    800113b4:	ffffe097          	auipc	ra,0xffffe
    800113b8:	d54080e7          	jalr	-684(ra) # 8000f108 <_Z11thread_exitv>
}
    800113bc:	00813083          	ld	ra,8(sp)
    800113c0:	00013403          	ld	s0,0(sp)
    800113c4:	01010113          	addi	sp,sp,16
    800113c8:	00008067          	ret

00000000800113cc <_ZN10TCBWrapper15userMainWrapperEPv>:

void TCBWrapper::userMainWrapper(void* args) {
    800113cc:	ff010113          	addi	sp,sp,-16
    800113d0:	00113423          	sd	ra,8(sp)
    800113d4:	00813023          	sd	s0,0(sp)
    800113d8:	01010413          	addi	s0,sp,16
    userMain();
    800113dc:	fffff097          	auipc	ra,0xfffff
    800113e0:	1f4080e7          	jalr	500(ra) # 800105d0 <_Z8userMainv>
//    testUser();
}
    800113e4:	00813083          	ld	ra,8(sp)
    800113e8:	00013403          	ld	s0,0(sp)
    800113ec:	01010113          	addi	sp,sp,16
    800113f0:	00008067          	ret

00000000800113f4 <_ZN10ForkThread3runEv>:
    virtual void run() {
    800113f4:	fc010113          	addi	sp,sp,-64
    800113f8:	02113c23          	sd	ra,56(sp)
    800113fc:	02813823          	sd	s0,48(sp)
    80011400:	02913423          	sd	s1,40(sp)
    80011404:	03213023          	sd	s2,32(sp)
    80011408:	01313c23          	sd	s3,24(sp)
    8001140c:	01413823          	sd	s4,16(sp)
    80011410:	01513423          	sd	s5,8(sp)
    80011414:	01613023          	sd	s6,0(sp)
    80011418:	04010413          	addi	s0,sp,64
    8001141c:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    80011420:	00001517          	auipc	a0,0x1
    80011424:	de850513          	addi	a0,a0,-536 # 80012208 <userDataStart+0x208>
    80011428:	fffff097          	auipc	ra,0xfffff
    8001142c:	6f4080e7          	jalr	1780(ra) # 80010b1c <_Z11printStringPKc>
        printInt(id,10);
    80011430:	00000613          	li	a2,0
    80011434:	00a00593          	li	a1,10
    80011438:	010a2503          	lw	a0,16(s4)
    8001143c:	00000097          	auipc	ra,0x0
    80011440:	878080e7          	jalr	-1928(ra) # 80010cb4 <_Z8printIntiii>
        printString("\n");
    80011444:	00001517          	auipc	a0,0x1
    80011448:	d1450513          	addi	a0,a0,-748 # 80012158 <userDataStart+0x158>
    8001144c:	fffff097          	auipc	ra,0xfffff
    80011450:	6d0080e7          	jalr	1744(ra) # 80010b1c <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    80011454:	02000513          	li	a0,32
    80011458:	00000097          	auipc	ra,0x0
    8001145c:	a14080e7          	jalr	-1516(ra) # 80010e6c <_Znwm>
    80011460:	00050993          	mv	s3,a0
    80011464:	02050463          	beqz	a0,8001148c <_ZN10ForkThread3runEv+0x98>
    80011468:	010a3483          	ld	s1,16(s4)
    8001146c:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80011470:	00000097          	auipc	ra,0x0
    80011474:	bd8080e7          	jalr	-1064(ra) # 80011048 <_ZN6ThreadC1Ev>
    80011478:	00001797          	auipc	a5,0x1
    8001147c:	ef078793          	addi	a5,a5,-272 # 80012368 <_ZTV10ForkThread+0x10>
    80011480:	00f9b023          	sd	a5,0(s3)
    80011484:	0099b823          	sd	s1,16(s3)
    80011488:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    8001148c:	010a3503          	ld	a0,16(s4)
    80011490:	00351513          	slli	a0,a0,0x3
    80011494:	ffffe097          	auipc	ra,0xffffe
    80011498:	b8c080e7          	jalr	-1140(ra) # 8000f020 <_Z9mem_allocm>
    8001149c:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    800114a0:	10050863          	beqz	a0,800115b0 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    800114a4:	00000913          	li	s2,0
    800114a8:	0140006f          	j	800114bc <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    800114ac:	00391793          	slli	a5,s2,0x3
    800114b0:	00fa87b3          	add	a5,s5,a5
    800114b4:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    800114b8:	00190913          	addi	s2,s2,1
    800114bc:	010a3783          	ld	a5,16(s4)
    800114c0:	02f95e63          	bge	s2,a5,800114fc <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    800114c4:	02000513          	li	a0,32
    800114c8:	00000097          	auipc	ra,0x0
    800114cc:	9a4080e7          	jalr	-1628(ra) # 80010e6c <_Znwm>
    800114d0:	00050493          	mv	s1,a0
    800114d4:	fc050ce3          	beqz	a0,800114ac <_ZN10ForkThread3runEv+0xb8>
    800114d8:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    800114dc:	00000097          	auipc	ra,0x0
    800114e0:	b6c080e7          	jalr	-1172(ra) # 80011048 <_ZN6ThreadC1Ev>
    800114e4:	00001797          	auipc	a5,0x1
    800114e8:	e8478793          	addi	a5,a5,-380 # 80012368 <_ZTV10ForkThread+0x10>
    800114ec:	00f4b023          	sd	a5,0(s1)
    800114f0:	0164b823          	sd	s6,16(s1)
    800114f4:	00048c23          	sb	zero,24(s1)
    800114f8:	fb5ff06f          	j	800114ac <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    800114fc:	06098a63          	beqz	s3,80011570 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    80011500:	00098513          	mv	a0,s3
    80011504:	00000097          	auipc	ra,0x0
    80011508:	c34080e7          	jalr	-972(ra) # 80011138 <_ZN6Thread5startEv>
    8001150c:	00050913          	mv	s2,a0
    80011510:	04051863          	bnez	a0,80011560 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    80011514:	00050493          	mv	s1,a0
    80011518:	0100006f          	j	80011528 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    8001151c:	ffffe097          	auipc	ra,0xffffe
    80011520:	c14080e7          	jalr	-1004(ra) # 8000f130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    80011524:	0014849b          	addiw	s1,s1,1
    80011528:	000017b7          	lui	a5,0x1
    8001152c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80011530:	0097ce63          	blt	a5,s1,8001154c <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    80011534:	00090713          	mv	a4,s2
    80011538:	000017b7          	lui	a5,0x1
    8001153c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80011540:	fce7cee3          	blt	a5,a4,8001151c <_ZN10ForkThread3runEv+0x128>
    80011544:	0017071b          	addiw	a4,a4,1
    80011548:	ff1ff06f          	j	80011538 <_ZN10ForkThread3runEv+0x144>
        return finished;
    8001154c:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    80011550:	00079863          	bnez	a5,80011560 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    80011554:	ffffe097          	auipc	ra,0xffffe
    80011558:	bdc080e7          	jalr	-1060(ra) # 8000f130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8001155c:	ff1ff06f          	j	8001154c <_ZN10ForkThread3runEv+0x158>
                delete thread;
    80011560:	0009b783          	ld	a5,0(s3)
    80011564:	0087b783          	ld	a5,8(a5)
    80011568:	00098513          	mv	a0,s3
    8001156c:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    80011570:	00000493          	li	s1,0
    80011574:	0080006f          	j	8001157c <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    80011578:	00148493          	addi	s1,s1,1
    8001157c:	010a3783          	ld	a5,16(s4)
    80011580:	02f4d263          	bge	s1,a5,800115a4 <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    80011584:	00349793          	slli	a5,s1,0x3
    80011588:	00fa87b3          	add	a5,s5,a5
    8001158c:	0007b503          	ld	a0,0(a5)
    80011590:	fe0504e3          	beqz	a0,80011578 <_ZN10ForkThread3runEv+0x184>
    80011594:	00053783          	ld	a5,0(a0)
    80011598:	0087b783          	ld	a5,8(a5)
    8001159c:	000780e7          	jalr	a5
    800115a0:	fd9ff06f          	j	80011578 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    800115a4:	000a8513          	mv	a0,s5
    800115a8:	ffffe097          	auipc	ra,0xffffe
    800115ac:	aa8080e7          	jalr	-1368(ra) # 8000f050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    800115b0:	00001517          	auipc	a0,0x1
    800115b4:	c7050513          	addi	a0,a0,-912 # 80012220 <userDataStart+0x220>
    800115b8:	fffff097          	auipc	ra,0xfffff
    800115bc:	564080e7          	jalr	1380(ra) # 80010b1c <_Z11printStringPKc>
        printInt(id,10);
    800115c0:	00000613          	li	a2,0
    800115c4:	00a00593          	li	a1,10
    800115c8:	010a2503          	lw	a0,16(s4)
    800115cc:	fffff097          	auipc	ra,0xfffff
    800115d0:	6e8080e7          	jalr	1768(ra) # 80010cb4 <_Z8printIntiii>
        printString("\n");
    800115d4:	00001517          	auipc	a0,0x1
    800115d8:	b8450513          	addi	a0,a0,-1148 # 80012158 <userDataStart+0x158>
    800115dc:	fffff097          	auipc	ra,0xfffff
    800115e0:	540080e7          	jalr	1344(ra) # 80010b1c <_Z11printStringPKc>
        finished = true;
    800115e4:	00100793          	li	a5,1
    800115e8:	00fa0c23          	sb	a5,24(s4)
    }
    800115ec:	03813083          	ld	ra,56(sp)
    800115f0:	03013403          	ld	s0,48(sp)
    800115f4:	02813483          	ld	s1,40(sp)
    800115f8:	02013903          	ld	s2,32(sp)
    800115fc:	01813983          	ld	s3,24(sp)
    80011600:	01013a03          	ld	s4,16(sp)
    80011604:	00813a83          	ld	s5,8(sp)
    80011608:	00013b03          	ld	s6,0(sp)
    8001160c:	04010113          	addi	sp,sp,64
    80011610:	00008067          	ret

0000000080011614 <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    80011614:	ff010113          	addi	sp,sp,-16
    80011618:	00113423          	sd	ra,8(sp)
    8001161c:	00813023          	sd	s0,0(sp)
    80011620:	01010413          	addi	s0,sp,16
    80011624:	00001797          	auipc	a5,0x1
    80011628:	d4478793          	addi	a5,a5,-700 # 80012368 <_ZTV10ForkThread+0x10>
    8001162c:	00f53023          	sd	a5,0(a0)
    80011630:	fffff097          	auipc	ra,0xfffff
    80011634:	7fc080e7          	jalr	2044(ra) # 80010e2c <_ZN6ThreadD1Ev>
    80011638:	00813083          	ld	ra,8(sp)
    8001163c:	00013403          	ld	s0,0(sp)
    80011640:	01010113          	addi	sp,sp,16
    80011644:	00008067          	ret

0000000080011648 <_ZN10ForkThreadD0Ev>:
    80011648:	fe010113          	addi	sp,sp,-32
    8001164c:	00113c23          	sd	ra,24(sp)
    80011650:	00813823          	sd	s0,16(sp)
    80011654:	00913423          	sd	s1,8(sp)
    80011658:	02010413          	addi	s0,sp,32
    8001165c:	00050493          	mv	s1,a0
    80011660:	00001797          	auipc	a5,0x1
    80011664:	d0878793          	addi	a5,a5,-760 # 80012368 <_ZTV10ForkThread+0x10>
    80011668:	00f53023          	sd	a5,0(a0)
    8001166c:	fffff097          	auipc	ra,0xfffff
    80011670:	7c0080e7          	jalr	1984(ra) # 80010e2c <_ZN6ThreadD1Ev>
    80011674:	00048513          	mv	a0,s1
    80011678:	00000097          	auipc	ra,0x0
    8001167c:	844080e7          	jalr	-1980(ra) # 80010ebc <_ZdlPv>
    80011680:	01813083          	ld	ra,24(sp)
    80011684:	01013403          	ld	s0,16(sp)
    80011688:	00813483          	ld	s1,8(sp)
    8001168c:	02010113          	addi	sp,sp,32
    80011690:	00008067          	ret
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
    80012048:	6548                	ld	a0,136(a0)
    8001204a:	6c6c                	ld	a1,216(s0)
    8001204c:	0000206f          	j	8001404c <end+0x4c>
    80012050:	2120                	fld	fs0,64(a0)
    80012052:	000a                	c.slli	zero,0x2
    80012054:	0000                	unimp
    80012056:	0000                	unimp
    80012058:	69203a43          	fmadd.s	fs4,ft0,fs2,fa3,rup
    8001205c:	003d                	c.nop	15
    8001205e:	0000                	unimp
    80012060:	64203a43          	0x64203a43
    80012064:	7369                	lui	t1,0xffffa
    80012066:	6170                	ld	a2,192(a0)
    80012068:	6374                	ld	a3,192(a4)
    8001206a:	0a68                	addi	a0,sp,284
    8001206c:	0000                	unimp
    8001206e:	0000                	unimp
    80012070:	74203a43          	0x74203a43
    80012074:	3d31                	addiw	s10,s10,-20
    80012076:	0000                	unimp
    80012078:	66203a43          	fmadd.q	fs4,ft0,ft2,fa2,rup
    8001207c:	6269                	lui	tp,0x1a
    8001207e:	63616e6f          	jal	t3,800286b4 <end+0x146b4>
    80012082:	3d69                	addiw	s10,s10,-6
    80012084:	0000                	unimp
    80012086:	0000                	unimp
    80012088:	3a44                	fld	fs1,176(a2)
    8001208a:	6920                	ld	s0,80(a0)
    8001208c:	003d                	c.nop	15
    8001208e:	0000                	unimp
    80012090:	3a44                	fld	fs1,176(a2)
    80012092:	6420                	ld	s0,72(s0)
    80012094:	7369                	lui	t1,0xffffa
    80012096:	6170                	ld	a2,192(a0)
    80012098:	6374                	ld	a3,192(a4)
    8001209a:	0a68                	addi	a0,sp,284
    8001209c:	0000                	unimp
    8001209e:	0000                	unimp
    800120a0:	3a44                	fld	fs1,176(a2)
    800120a2:	6620                	ld	s0,72(a2)
    800120a4:	6269                	lui	tp,0x1a
    800120a6:	63616e6f          	jal	t3,800286dc <end+0x146dc>
    800120aa:	3d69                	addiw	s10,s10,-6
    800120ac:	0000                	unimp
    800120ae:	0000                	unimp
    800120b0:	2044                	fld	fs1,128(s0)
    800120b2:	6966                	ld	s2,88(sp)
    800120b4:	696e                	ld	s2,216(sp)
    800120b6:	64656873          	csrrsi	a6,0x646,10
    800120ba:	0a21                	addi	s4,s4,8
    800120bc:	0000                	unimp
    800120be:	0000                	unimp
    800120c0:	6854                	ld	a3,144(s0)
    800120c2:	6572                	ld	a0,280(sp)
    800120c4:	6461                	lui	s0,0x18
    800120c6:	2041                	0x2041
    800120c8:	61657263          	bgeu	a0,s6,800126cc <lockPrint+0x334>
    800120cc:	6574                	ld	a3,200(a0)
    800120ce:	0a64                	addi	s1,sp,284
	...
    800120d8:	6854                	ld	a3,144(s0)
    800120da:	6572                	ld	a0,280(sp)
    800120dc:	6461                	lui	s0,0x18
    800120de:	2042                	fld	ft0,16(sp)
    800120e0:	61657263          	bgeu	a0,s6,800126e4 <lockPrint+0x34c>
    800120e4:	6574                	ld	a3,200(a0)
    800120e6:	0a64                	addi	s1,sp,284
	...
    800120f0:	6854                	ld	a3,144(s0)
    800120f2:	6572                	ld	a0,280(sp)
    800120f4:	6461                	lui	s0,0x18
    800120f6:	72632043          	fmadd.d	ft0,ft6,ft6,fa4,rdn
    800120fa:	6165                	addi	sp,sp,112
    800120fc:	6574                	ld	a3,200(a0)
    800120fe:	0a64                	addi	s1,sp,284
	...
    80012108:	6854                	ld	a3,144(s0)
    8001210a:	6572                	ld	a0,280(sp)
    8001210c:	6461                	lui	s0,0x18
    8001210e:	2044                	fld	fs1,128(s0)
    80012110:	61657263          	bgeu	a0,s6,80012714 <lockPrint+0x37c>
    80012114:	6574                	ld	a3,200(a0)
    80012116:	0a64                	addi	s1,sp,284
	...
    80012120:	6e55                	lui	t3,0x15
    80012122:	7365                	lui	t1,0xffff9
    80012124:	7469                	lui	s0,0xffffa
    80012126:	2065                	0x2065
    80012128:	7262                	ld	tp,56(sp)
    8001212a:	70206a6f          	jal	s4,8001882c <end+0x482c>
    8001212e:	6f72                	ld	t5,280(sp)
    80012130:	7a69                	lui	s4,0xffffa
    80012132:	6f76                	ld	t5,344(sp)
    80012134:	6a64                	ld	s1,208(a2)
    80012136:	6361                	lui	t1,0x18
    80012138:	3f61                	addiw	t5,t5,-8
    8001213a:	000a                	c.slli	zero,0x2
    8001213c:	0000                	unimp
    8001213e:	0000                	unimp
    80012140:	6e55                	lui	t3,0x15
    80012142:	7365                	lui	t1,0xffff9
    80012144:	7469                	lui	s0,0xffffa
    80012146:	2065                	0x2065
    80012148:	6576                	ld	a0,344(sp)
    8001214a:	696c                	ld	a1,208(a0)
    8001214c:	756e6963          	bltu	t3,s6,8001289e <lockPrint+0x506>
    80012150:	6220                	ld	s0,64(a2)
    80012152:	6661                	lui	a2,0x18
    80012154:	7265                	lui	tp,0xffff9
    80012156:	3f61                	addiw	t5,t5,-8
    80012158:	000a                	c.slli	zero,0x2
    8001215a:	0000                	unimp
    8001215c:	0000                	unimp
    8001215e:	0000                	unimp
    80012160:	7242                	ld	tp,48(sp)
    80012162:	70206a6f          	jal	s4,80018864 <end+0x4864>
    80012166:	6f72                	ld	t5,280(sp)
    80012168:	7a69                	lui	s4,0xffffa
    8001216a:	6f76                	ld	t5,344(sp)
    8001216c:	6a64                	ld	s1,208(a2)
    8001216e:	6361                	lui	t1,0x18
    80012170:	2061                	0x2061
    80012172:	0000                	unimp
    80012174:	0000                	unimp
    80012176:	0000                	unimp
    80012178:	6920                	ld	s0,80(a0)
    8001217a:	7620                	ld	s0,104(a2)
    8001217c:	6c65                	lui	s8,0x19
    8001217e:	6369                	lui	t1,0x1a
    80012180:	6e69                	lui	t3,0x1a
    80012182:	2061                	0x2061
    80012184:	6162                	ld	sp,24(sp)
    80012186:	6566                	ld	a0,88(sp)
    80012188:	6172                	ld	sp,280(sp)
    8001218a:	0020                	addi	s0,sp,8
    8001218c:	0000                	unimp
    8001218e:	0000                	unimp
    80012190:	0a2e                	slli	s4,s4,0xb
    80012192:	0000                	unimp
    80012194:	0000                	unimp
    80012196:	0000                	unimp
    80012198:	7242                	ld	tp,48(sp)
    8001219a:	70206a6f          	jal	s4,8001889c <end+0x489c>
    8001219e:	6f72                	ld	t5,280(sp)
    800121a0:	7a69                	lui	s4,0xffffa
    800121a2:	6f76                	ld	t5,344(sp)
    800121a4:	6a64                	ld	s1,208(a2)
    800121a6:	6361                	lui	t1,0x18
    800121a8:	2061                	0x2061
    800121aa:	656e                	ld	a0,216(sp)
    800121ac:	7320                	ld	s0,96(a4)
    800121ae:	656d                	lui	a0,0x1b
    800121b0:	6220                	ld	s0,64(a2)
    800121b2:	7469                	lui	s0,0xffffa
    800121b4:	2069                	0x2069
    800121b6:	616d                	addi	sp,sp,240
    800121b8:	6a6e                	ld	s4,216(sp)
    800121ba:	2069                	0x2069
    800121bc:	7620646f          	jal	s0,8001891e <end+0x491e>
    800121c0:	6c65                	lui	s8,0x19
    800121c2:	6369                	lui	t1,0x1a
    800121c4:	6e69                	lui	t3,0x1a
    800121c6:	2065                	0x2065
    800121c8:	6162                	ld	sp,24(sp)
    800121ca:	6566                	ld	a0,88(sp)
    800121cc:	6172                	ld	sp,280(sp)
    800121ce:	0a21                	addi	s4,s4,8
	...
    800121d8:	7242                	ld	tp,48(sp)
    800121da:	70206a6f          	jal	s4,800188dc <end+0x48dc>
    800121de:	6f72                	ld	t5,280(sp)
    800121e0:	7a69                	lui	s4,0xffffa
    800121e2:	6f76                	ld	t5,344(sp)
    800121e4:	6a64                	ld	s1,208(a2)
    800121e6:	6361                	lui	t1,0x18
    800121e8:	2061                	0x2061
    800121ea:	6f6d                	lui	t5,0x1b
    800121ec:	6172                	ld	sp,280(sp)
    800121ee:	6220                	ld	s0,64(a2)
    800121f0:	7469                	lui	s0,0xffffa
    800121f2:	2069                	0x2069
    800121f4:	6576                	ld	a0,344(sp)
    800121f6:	6f206963          	bltu	zero,s2,800128e8 <lockPrint+0x550>
    800121fa:	2064                	fld	fs1,192(s0)
    800121fc:	756e                	ld	a0,248(sp)
    800121fe:	616c                	ld	a1,192(a0)
    80012200:	0a21                	addi	s4,s4,8
    80012202:	0000                	unimp
    80012204:	0000                	unimp
    80012206:	0000                	unimp
    80012208:	72617453          	0x72617453
    8001220c:	6574                	ld	a3,200(a0)
    8001220e:	2064                	fld	fs1,192(s0)
    80012210:	6874                	ld	a3,208(s0)
    80012212:	6572                	ld	a0,280(sp)
    80012214:	6461                	lui	s0,0x18
    80012216:	6920                	ld	s0,80(a0)
    80012218:	3a64                	fld	fs1,240(a2)
    8001221a:	0020                	addi	s0,sp,8
    8001221c:	0000                	unimp
    8001221e:	0000                	unimp
    80012220:	6946                	ld	s2,80(sp)
    80012222:	696e                	ld	s2,216(sp)
    80012224:	64656873          	csrrsi	a6,0x646,10
    80012228:	7420                	ld	s0,104(s0)
    8001222a:	7268                	ld	a0,224(a2)
    8001222c:	6165                	addi	sp,sp,112
    8001222e:	2064                	fld	fs1,192(s0)
    80012230:	6469                	lui	s0,0x1a
    80012232:	203a                	fld	ft0,392(sp)
    80012234:	0000                	unimp
    80012236:	0000                	unimp
    80012238:	7355                	lui	t1,0xffff5
    8001223a:	7265                	lui	tp,0xffff9
    8001223c:	6d20                	ld	s0,88(a0)
    8001223e:	6961                	lui	s2,0x18
    80012240:	206e                	fld	ft0,216(sp)
    80012242:	6966                	ld	s2,88(sp)
    80012244:	696e                	ld	s2,216(sp)
    80012246:	64656873          	csrrsi	a6,0x646,10
    8001224a:	000a                	c.slli	zero,0x2
    8001224c:	0000                	unimp
	...

0000000080012250 <_ZTV16ProducerKeyboard>:
	...
    80012260:	06f8 8001 0000 0000 072c 8001 0000 0000     ........,.......
    80012270:	0778 8001 0000 0000                         x.......

0000000080012278 <_ZTV8Producer>:
	...
    80012288:	0678 8001 0000 0000 06ac 8001 0000 0000     x...............
    80012298:	07a4 8001 0000 0000                         ........

00000000800122a0 <_ZTV8Consumer>:
	...
    800122b0:	05f8 8001 0000 0000 062c 8001 0000 0000     ........,.......
    800122c0:	07d0 8001 0000 0000                         ........

00000000800122c8 <digits>:
    800122c8:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...

00000000800122e0 <_ZTV14PeriodicThread>:
	...
    800122f0:	1258 8001 0000 0000 128c 8001 0000 0000     X...............
    80012300:	1228 8001 0000 0000 1240 8001 0000 0000     (.......@.......

0000000080012310 <_ZTV9Semaphore>:
	...
    80012320:	0df4 8001 0000 0000 0ee4 8001 0000 0000     ................

0000000080012330 <_ZTV6Thread>:
	...
    80012340:	0e2c 8001 0000 0000 0f24 8001 0000 0000     ,.......$.......
    80012350:	1228 8001 0000 0000                         (.......

0000000080012358 <_ZTV10ForkThread>:
	...
    80012368:	1614 8001 0000 0000 1648 8001 0000 0000     ........H.......
    80012378:	13f4 8001 0000 0000                         ........

0000000080012380 <finishedA>:
	...

0000000080012381 <finishedB>:
    80012381:	0000 0000 0000                               .......

0000000080012388 <finished>:
	...

000000008001238a <finishedC>:
	...

000000008001238b <finishedD>:
	...

000000008001238c <threadEnd>:
    8001238c:	0000 0000                                   ....

0000000080012390 <waitForAll>:
	...

0000000080012398 <lockPrint>:
	...
    800123a0:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    800123b0:	0d1b 0002 0020 0000 0018 0000 cc64 ffff     .... .......d...
    800123c0:	0030 0000 4400 100e 8844 4402 000c 0000     0....D..D..D....
    800123d0:	0c00 1002 0e44 0000 0020 0000 003c 0000     ....D... ...<...
    800123e0:	cc70 ffff 002c 0000 4400 100e 8844 4402     p...,....D..D..D
    800123f0:	000c 0000 0c00 1002 0e44 0000 0034 0000     ........D...4...
    80012400:	0060 0000 cc78 ffff 008c 0000 4400 000e     `...x........D..
	...
    80012418:	9300 440a 080c 0000 0000 0000 0c00 3002     ...D...........0
    80012428:	c944 d244 d344 0e44 4400 000b 0020 0000     D.D.D.D..D.. ...
    80012438:	0098 0000 cccc ffff 0028 0000 4400 100e     ........(....D..
    80012448:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012458:	0020 0000 00bc 0000 ccd0 ffff 0020 0000      ........... ...
    80012468:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012478:	0e44 0000 0034 0000 00e0 0000 cccc ffff     D...4...........
    80012488:	0094 0000 4400 000e 0000 0000 0000 0000     .....D..........
    80012498:	9300 440a 080c 0000 0000 0000 0c00 3002     ...D...........0
    800124a8:	c944 d244 d344 0e44 4400 000b 0024 0000     D.D.D.D..D..$...
    800124b8:	0118 0000 cd28 ffff 0038 0000 4400 100e     ....(...8....D..
    800124c8:	8844 4402 000c 0000 0000 020c 4410 000e     D..D.........D..
    800124d8:	0b44 0000 0020 0000 0140 0000 cd38 ffff     D... ...@...8...
    800124e8:	0038 0000 4400 100e 8844 4402 000c 0000     8....D..D..D....
    800124f8:	0c00 1002 0e44 0000 0020 0000 0164 0000     ....D... ...d...
    80012508:	cd4c ffff 002c 0000 4400 100e 8844 4402     L...,....D..D..D
    80012518:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    80012528:	0188 0000 cd54 ffff 002c 0000 4400 100e     ....T...,....D..
    80012538:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012548:	0020 0000 01ac 0000 cd5c ffff 002c 0000      .......\...,...
    80012558:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012568:	0e44 0000 0020 0000 01d0 0000 cd64 ffff     D... .......d...
    80012578:	002c 0000 4400 100e 8844 4402 000c 0000     ,....D..D..D....
    80012588:	0c00 1002 0e44 0000 0020 0000 01f4 0000     ....D... .......
    80012598:	cd6c ffff 0028 0000 4400 100e 8844 4402     l...(....D..D..D
    800125a8:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    800125b8:	0218 0000 cd70 ffff 0024 0000 4400 100e     ....p...$....D..
    800125c8:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    800125d8:	0020 0000 023c 0000 cd70 ffff 0028 0000      ...<...p...(...
    800125e8:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    800125f8:	0e44 0000 0020 0000 0260 0000 cd74 ffff     D... ...`...t...
    80012608:	0024 0000 4400 100e 8844 4402 000c 0000     $....D..D..D....
    80012618:	0c00 1002 0e44 0000 0010 0000 0000 0000     ....D...........
    80012628:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    80012638:	0018 0000 cd60 ffff 0028 0000 4400 000e     ....`...(....D..
    80012648:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012658:	0e44 0000 0000 0000 0010 0000 0000 0000     D...............
    80012668:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    80012678:	0018 0000 cd48 ffff 0028 0000 4400 000e     ....H...(....D..
    80012688:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012698:	0e44 0000 0000 0000 0018 0000 0000 0000     D...............
    800126a8:	7a03 4c50 0052 7c01 0701 fd9b ff53 1bff     .zPLR..|....S...
    800126b8:	0d1b 0002 0038 0000 0020 0000 cd28 ffff     ....8... ...(...
    800126c8:	0164 0000 8a04 ff51 44ff 000e 0000 0000     d.....Q..D......
    800126d8:	0000 0000 9300 440a 080c 0000 0000 0000     .......D........
    800126e8:	0c00 3002 c944 d244 d344 0e44 4400 000b     ...0D.D.D.D..D..
    800126f8:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    80012708:	0d1b 0002 002c 0000 0018 0000 ce3c ffff     ....,.......<...
    80012718:	0090 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012728:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    80012738:	44d2 000e 002c 0000 0048 0000 ce9c ffff     .D..,...H.......
    80012748:	008c 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012758:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    80012768:	44d2 000e 0030 0000 0078 0000 cef8 ffff     .D..0...x.......
    80012778:	0088 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012788:	4408 080c 0000 0000 0000 0c00 2002 c944     .D........... D.
    80012798:	d244 0e44 4400 000b 002c 0000 0104 0000     D.D..D..,.......
    800127a8:	cf4c ffff 0100 0000 4704 ff51 44ff 000e     L........GQ..D..
    800127b8:	0000 0000 8900 4406 080c 0200 0000 0000     .......D........
    800127c8:	020c 4420 44c9 000e 0010 0000 0000 0000     .. D.D..........
    800127d8:	7a03 0052 7c01 0101 0d1b 0002 002c 0000     .zR..|......,...
    800127e8:	0018 0000 d008 ffff 00cc 0000 4400 000e     .............D..
    800127f8:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    80012808:	0000 020c 4420 44c9 44d2 000e 002c 0000     .... D.D.D..,...
    80012818:	0048 0000 d0a4 ffff 00d4 0000 4400 000e     H............D..
    80012828:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    80012838:	0000 020c 4420 44c9 44d2 000e 0024 0000     .... D.D.D..$...
    80012848:	0078 0000 ddac ffff 0034 0000 4400 000e     x.......4....D..
    80012858:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012868:	0e44 0000 0028 0000 00a0 0000 ddb8 ffff     D...(...........
    80012878:	004c 0000 4400 000e 0000 0000 8900 4406     L....D.........D
    80012888:	080c 0000 0000 0c00 2002 c944 0e44 0000     ......... D.D...
    80012898:	0024 0000 00cc 0000 ddd8 ffff 0034 0000     $...........4...
    800128a8:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    800128b8:	0c00 1002 0e44 0000 0028 0000 00f4 0000     ....D...(.......
    800128c8:	dde4 ffff 004c 0000 4400 000e 0000 0000     ....L....D......
    800128d8:	8900 4406 080c 0000 0000 0c00 2002 c944     ...D......... D.
    800128e8:	0e44 0000 0024 0000 0120 0000 de04 ffff     D...$... .......
    800128f8:	0034 0000 4400 000e 0000 8800 4404 080c     4....D.......D..
    80012908:	0000 0000 0c00 1002 0e44 0000 0028 0000     ........D...(...
    80012918:	0148 0000 de10 ffff 004c 0000 4400 000e     H.......L....D..
    80012928:	0000 0000 8900 4406 080c 0000 0000 0c00     .......D........
    80012938:	2002 c944 0e44 0000 002c 0000 0174 0000     . D.D...,...t...
    80012948:	d04c ffff 00a4 0000 4400 000e 0000 0000     L........D......
    80012958:	0000 9200 4408 080c 0200 0000 0000 020c     .....D..........
    80012968:	4420 44c9 44d2 000e 0030 0000 01a4 0000      D.D.D..0.......
    80012978:	d0c0 ffff 0074 0000 4400 000e 0000 0000     ....t....D......
    80012988:	0000 9200 4408 000c 0000 0000 0000 020c     .....D..........
    80012998:	4420 44c9 44d2 000e 0b44 0000 0030 0000      D.D.D..D...0...
    800129a8:	01d8 0000 d100 ffff 0180 0000 4400 000e     .............D..
    800129b8:	0000 0000 0000 9200 4408 080c 0300 0054     .........D....T.
    800129c8:	0000 0c00 2002 c944 d244 0e44 0000 0000     ..... D.D.D.....
    800129d8:	0030 0000 020c 0000 d24c ffff 0148 0000     0.......L...H...
    800129e8:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    800129f8:	0300 001c 0000 0c00 2002 c944 d244 0e44     ......... D.D.D.
    80012a08:	0000 0000 002c 0000 0240 0000 d360 ffff     ....,...@...`...
    80012a18:	012c 0000 4400 000e 0000 0000 8900 4406     ,....D.........D
    80012a28:	080c 0300 0008 0000 0c00 4002 c944 0e44     ...........@D.D.
    80012a38:	0000 0000 0030 0000 0270 0000 d45c ffff     ....0...p...\...
    80012a48:	00c0 0000 4400 000e 0000 0000 0000 0000     .....D..........
    80012a58:	9300 440a 080c 0200 0000 0000 020c 4430     ...D..........0D
    80012a68:	44c9 44d2 44d3 000e 0024 0000 02a4 0000     .D.D.D..$.......
    80012a78:	dd00 ffff 002c 0000 4400 000e 0000 8800     ....,....D......
    80012a88:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012a98:	002c 0000 02cc 0000 d4c0 ffff 0094 0000     ,...............
    80012aa8:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    80012ab8:	0200 0000 0000 020c 4420 44c9 44d2 000e     ........ D.D.D..
    80012ac8:	0024 0000 02fc 0000 dcd4 ffff 002c 0000     $...........,...
    80012ad8:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012ae8:	0c00 1002 0e44 0000 0034 0000 0324 0000     ....D...4...$...
    80012af8:	d4fc ffff 00f4 0000 4400 000e 0000 0000     .........D......
    80012b08:	0000 0000 0000 9400 440c 080c 0200 0000     .........D......
    80012b18:	0000 020c 4430 44c9 44d2 44d3 44d4 000e     ....0D.D.D.D.D..
    80012b28:	0024 0000 035c 0000 dca0 ffff 002c 0000     $...\.......,...
    80012b38:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012b48:	0c00 1002 0e44 0000 0018 0000 0000 0000     ....D...........
    80012b58:	7a03 4c50 0052 7c01 0701 4d9b ff4f 1bff     .zPLR..|...MO...
    80012b68:	0d1b 0002 0054 0000 0020 0000 d574 ffff     ....T... ...t...
    80012b78:	0460 0000 7f04 ff4d 44ff 800e 0000 0000     `.....M..D......
	...
    80012b98:	0000 1699 0c44 0008 0000 0000 020c 0180     ....D...........
    80012ba8:	c144 c844 c944 d244 d344 d444 d544 d644     D.D.D.D.D.D.D.D.
    80012bb8:	d744 d844 d944 0e44 4400 000b 0028 0000     D.D.D.D..D..(...
    80012bc8:	03f8 0000 d97c ffff 0088 0000 4400 000e     ....|........D..
    80012bd8:	0000 0000 8900 4406 080c 0200 0000 0000     .......D........
    80012be8:	020c 4440 44c9 000e 0024 0000 0424 0000     ..@D.D..$...$...
    80012bf8:	d9d8 ffff 0028 0000 4400 000e 0000 8800     ....(....D......
    80012c08:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012c18:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    80012c28:	0d1b 0002 002c 0000 0018 0000 dbc8 ffff     ....,...........
    80012c38:	009c 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012c48:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    80012c58:	44d2 000e 002c 0000 0048 0000 dc34 ffff     .D..,...H...4...
    80012c68:	0090 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012c78:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    80012c88:	44d2 000e 002c 0000 0078 0000 dc94 ffff     .D..,...x.......
    80012c98:	008c 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012ca8:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    80012cb8:	44d2 000e 0030 0000 00a8 0000 dcf0 ffff     .D..0...........
    80012cc8:	0088 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012cd8:	4408 080c 0000 0000 0000 0c00 2002 c944     .D........... D.
    80012ce8:	d244 0e44 4400 000b 0018 0000 0000 0000     D.D..D..........
    80012cf8:	7a03 4c50 0052 7c01 0701 ad9b ff4d 1bff     .zPLR..|....M...
    80012d08:	0d1b 0002 0030 0000 0020 0000 dd28 ffff     ....0... ...(...
    80012d18:	00e0 0000 b404 ff4c 44ff 000e 0000 0000     ......L..D......
    80012d28:	8900 4406 080c 0200 0000 0000 020c 4420     ...D.......... D
    80012d38:	44c9 000e 0000 0000 0010 0000 0000 0000     .D..............
    80012d48:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    80012d58:	0018 0000 ddc0 ffff 007c 0000 4400 000e     ........|....D..
    80012d68:	0000 0000 8900 4406 080c 0200 0000 0000     .......D........
    80012d78:	020c 4420 44c9 000e 0034 0000 0044 0000     .. D.D..4...D...
    80012d88:	de10 ffff 00cc 0000 4400 000e 0000 0000     .........D......
    80012d98:	0000 0000 0000 9400 440c 080c 0200 0000     .........D......
    80012da8:	0000 020c 4430 44c9 44d2 44d3 44d4 000e     ....0D.D.D.D.D..
    80012db8:	0020 0000 007c 0000 dea4 ffff 0050 0000      ...|.......P...
    80012dc8:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012dd8:	0e44 0000 0030 0000 00a0 0000 ded0 ffff     D...0...........
    80012de8:	0114 0000 4400 000e 0000 0000 0000 0000     .....D..........
    80012df8:	9300 440a 080c 0200 0000 0000 020c 4440     ...D..........@D
    80012e08:	44c9 44d2 44d3 000e 0010 0000 0000 0000     .D.D.D..........
    80012e18:	7a03 0052 7c01 0101 0d1b 0002 0020 0000     .zR..|...... ...
    80012e28:	0018 0000 e3fc ffff 0018 0000 4400 100e     .............D..
    80012e38:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012e48:	0020 0000 003c 0000 e3f0 ffff 0018 0000      ...<...........
    80012e58:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012e68:	0e44 0000 0024 0000 0060 0000 df54 ffff     D...$...`...T...
    80012e78:	002c 0000 4400 000e 0000 8800 4404 080c     ,....D.......D..
    80012e88:	0000 0000 0c00 1002 0e44 0000 0018 0000     ........D.......
    80012e98:	0000 0000 7a03 4c50 0052 7c01 0701 099b     .....zPLR..|....
    80012ea8:	ff4c 1bff 0d1b 0002 0028 0000 0020 0000     L.......(... ...
    80012eb8:	df3c ffff 0038 0000 1404 ff4b 44ff 000e     <...8.....K..D..
    80012ec8:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012ed8:	0e44 0000 0028 0000 004c 0000 df48 ffff     D...(...L...H...
    80012ee8:	0040 0000 ec04 ff4a 58ff 000e 0000 8800     @.....J..X......
    80012ef8:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012f08:	0024 0000 00fc 0000 e348 ffff 0034 0000     $.......H...4...
    80012f18:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012f28:	0c00 1002 0e44 0000 0024 0000 0124 0000     ....D...$...$...
    80012f38:	df34 ffff 0028 0000 4400 000e 0000 8800     4...(....D......
    80012f48:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012f58:	0024 0000 014c 0000 df34 ffff 0028 0000     $...L...4...(...
    80012f68:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012f78:	0c00 1002 0e44 0000 0024 0000 0174 0000     ....D...$...t...
    80012f88:	df34 ffff 0028 0000 4400 000e 0000 8800     4...(....D......
    80012f98:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012fa8:	0028 0000 019c 0000 df34 ffff 0040 0000     (.......4...@...
    80012fb8:	4400 000e 0000 0000 8900 4406 080c 0000     .D.........D....
    80012fc8:	0000 0c00 2002 c944 0e44 0000 0028 0000     ..... D.D...(...
    80012fd8:	01c8 0000 df48 ffff 0040 0000 4400 000e     ....H...@....D..
    80012fe8:	0000 0000 8900 4406 080c 0000 0000 0c00     .......D........
    80012ff8:	2002 c944 0e44 0000 0028 0000 01f4 0000     . D.D...(.......
    80013008:	e284 ffff 004c 0000 4400 000e 0000 0000     ....L....D......
    80013018:	8900 4406 080c 0000 0000 0c00 2002 c944     ...D......... D.
    80013028:	0e44 0000 0024 0000 0220 0000 df30 ffff     D...$... ...0...
    80013038:	0038 0000 4400 000e 0000 8800 4404 080c     8....D.......D..
    80013048:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    80013058:	0248 0000 df40 ffff 002c 0000 4400 000e     H...@...,....D..
    80013068:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80013078:	0e44 0000 0024 0000 0270 0000 df44 ffff     D...$...p...D...
    80013088:	002c 0000 4400 000e 0000 8800 4404 080c     ,....D.......D..
    80013098:	0000 0000 0c00 1002 0e44 0000 002c 0000     ........D...,...
    800130a8:	0298 0000 df48 ffff 0054 0000 4400 000e     ....H...T....D..
    800130b8:	0000 0000 8900 4406 000c 0000 0000 0000     .......D........
    800130c8:	020c 4420 44c9 000e 0b44 0000 002c 0000     .. D.D..D...,...
    800130d8:	02c8 0000 df6c ffff 0060 0000 4400 000e     ....l...`....D..
    800130e8:	0000 0000 8900 4406 000c 0000 0000 0000     .......D........
    800130f8:	020c 4420 44c9 000e 0b44 0000 0024 0000     .. D.D..D...$...
    80013108:	02f8 0000 df9c ffff 0028 0000 4400 000e     ........(....D..
    80013118:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80013128:	0e44 0000 0020 0000 0320 0000 df9c ffff     D... ... .......
    80013138:	0040 0000 4400 000e 0000 0000 0000 9200     @....D..........
    80013148:	4408 080c 0000 0000 0024 0000 0344 0000     .D......$...D...
    80013158:	dfb8 ffff 0028 0000 4400 000e 0000 8800     ....(....D......
    80013168:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80013178:	0024 0000 036c 0000 dfb8 ffff 002c 0000     $...l.......,...
    80013188:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80013198:	0c00 1002 0e44 0000 002c 0000 0394 0000     ....D...,.......
    800131a8:	dfbc ffff 0074 0000 4400 000e 0000 0000     ....t....D......
    800131b8:	0000 9200 4408 080c 0200 0000 0000 020c     .....D..........
    800131c8:	4420 44c9 44d2 000e 0024 0000 03c4 0000      D.D.D..$.......
    800131d8:	e000 ffff 0028 0000 4400 000e 0000 8800     ....(....D......
    800131e8:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    800131f8:	0024 0000 03ec 0000 e000 ffff 0028 0000     $...........(...
    80013208:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80013218:	0c00 1002 0e44 0000 0018 0000 0000 0000     ....D...........
    80013228:	7a03 4c50 0052 7c01 0701 7d9b ff48 1bff     .zPLR..|...}H...
    80013238:	0d1b 0002 0044 0000 0020 0000 e1b0 ffff     ....D... .......
    80013248:	0220 0000 ae04 ff47 44ff 000e 0000 0000      .....G..D......
	...
    80013260:	0000 9600 4410 080c 0300 00d4 0000 0c00     .....D..........
    80013270:	4002 c944 d244 d344 d444 d544 d644 0e44     .@D.D.D.D.D.D.D.
    80013280:	0000 0000 0010 0000 0000 0000 7a03 0052     .............zR.
    80013290:	7c01 0101 0d1b 0002 0024 0000 0018 0000     .|......$.......
    800132a0:	e374 ffff 0034 0000 4400 000e 0000 8800     t...4....D......
    800132b0:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    800132c0:	0028 0000 0040 0000 e380 ffff 004c 0000     (...@.......L...
    800132d0:	4400 000e 0000 0000 8900 4406 080c 0000     .D.........D....
    800132e0:	0000 0c00 2002 c944 0e44 0000 0030 0000     ..... D.D...0...
    800132f0:	00d0 0000 dfe4 ffff 00c0 0000 e004 ff46     ..............F.
    80013300:	44ff 000e 0000 0000 8900 4406 080c 0000     .D.........D....
    80013310:	0000 0000 0c00 4002 c944 0e44 4400 000b     .......@D.D..D..
    80013320:	0024 0000 00a0 0000 e070 ffff 0034 0000     $.......p...4...
    80013330:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80013340:	0c00 1002 0e44 0000 0024 0000 00c8 0000     ....D...$.......
    80013350:	e07c ffff 0028 0000 4400 000e 0000 8800     |...(....D......
    80013360:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
	...
