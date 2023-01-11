
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	ac013103          	ld	sp,-1344(sp) # 80008ac0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	13c050ef          	jal	ra,80005158 <start>

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
    80001088:	551020ef          	jal	ra,80003dd8 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001164:	4b0080e7          	jalr	1200(ra) # 80002610 <_ZN5Buddy4freeEPvm>
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
    8000119c:	14050c63          	beqz	a0,800012f4 <_ZN13SlabAllocator9printSlabEP4Slab+0x158>
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
    800011c0:	00007617          	auipc	a2,0x7
    800011c4:	1d060613          	addi	a2,a2,464 # 80008390 <CONSOLE_STATUS+0x380>
    800011c8:	0005059b          	sext.w	a1,a0
    800011cc:	00007517          	auipc	a0,0x7
    800011d0:	e5450513          	addi	a0,a0,-428 # 80008020 <CONSOLE_STATUS+0x10>
    800011d4:	00004097          	auipc	ra,0x4
    800011d8:	d80080e7          	jalr	-640(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011dc:	01000693          	li	a3,16
    800011e0:	00007617          	auipc	a2,0x7
    800011e4:	1b060613          	addi	a2,a2,432 # 80008390 <CONSOLE_STATUS+0x380>
    800011e8:	01892583          	lw	a1,24(s2)
    800011ec:	00007517          	auipc	a0,0x7
    800011f0:	e4450513          	addi	a0,a0,-444 # 80008030 <CONSOLE_STATUS+0x20>
    800011f4:	00004097          	auipc	ra,0x4
    800011f8:	d60080e7          	jalr	-672(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    800011fc:	01000693          	li	a3,16
    80001200:	00007617          	auipc	a2,0x7
    80001204:	19060613          	addi	a2,a2,400 # 80008390 <CONSOLE_STATUS+0x380>
    80001208:	01092583          	lw	a1,16(s2)
    8000120c:	00007517          	auipc	a0,0x7
    80001210:	e3c50513          	addi	a0,a0,-452 # 80008048 <CONSOLE_STATUS+0x38>
    80001214:	00004097          	auipc	ra,0x4
    80001218:	d40080e7          	jalr	-704(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    8000121c:	01000693          	li	a3,16
    80001220:	00007617          	auipc	a2,0x7
    80001224:	17060613          	addi	a2,a2,368 # 80008390 <CONSOLE_STATUS+0x380>
    80001228:	43000593          	li	a1,1072
    8000122c:	00007517          	auipc	a0,0x7
    80001230:	e3450513          	addi	a0,a0,-460 # 80008060 <CONSOLE_STATUS+0x50>
    80001234:	00004097          	auipc	ra,0x4
    80001238:	d20080e7          	jalr	-736(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000123c:	01000693          	li	a3,16
    80001240:	00007617          	auipc	a2,0x7
    80001244:	15060613          	addi	a2,a2,336 # 80008390 <CONSOLE_STATUS+0x380>
    80001248:	42092583          	lw	a1,1056(s2)
    8000124c:	00007517          	auipc	a0,0x7
    80001250:	e2c50513          	addi	a0,a0,-468 # 80008078 <CONSOLE_STATUS+0x68>
    80001254:	00004097          	auipc	ra,0x4
    80001258:	d00080e7          	jalr	-768(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    8000125c:	01000693          	li	a3,16
    80001260:	00007617          	auipc	a2,0x7
    80001264:	13060613          	addi	a2,a2,304 # 80008390 <CONSOLE_STATUS+0x380>
    80001268:	0209059b          	addiw	a1,s2,32
    8000126c:	00007517          	auipc	a0,0x7
    80001270:	e1c50513          	addi	a0,a0,-484 # 80008088 <CONSOLE_STATUS+0x78>
    80001274:	00004097          	auipc	ra,0x4
    80001278:	ce0080e7          	jalr	-800(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000127c:	00007517          	auipc	a0,0x7
    80001280:	e2c50513          	addi	a0,a0,-468 # 800080a8 <CONSOLE_STATUS+0x98>
    80001284:	00004097          	auipc	ra,0x4
    80001288:	bb0080e7          	jalr	-1104(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    8000128c:	00000493          	li	s1,0
    80001290:	02c0006f          	j	800012bc <_ZN13SlabAllocator9printSlabEP4Slab+0x120>
            ConsoleUtil::print("", slab->allocated[i], " ");
    80001294:	009907b3          	add	a5,s2,s1
    80001298:	01000693          	li	a3,16
    8000129c:	00007617          	auipc	a2,0x7
    800012a0:	e5c60613          	addi	a2,a2,-420 # 800080f8 <CONSOLE_STATUS+0xe8>
    800012a4:	0207c583          	lbu	a1,32(a5)
    800012a8:	00007517          	auipc	a0,0x7
    800012ac:	12850513          	addi	a0,a0,296 # 800083d0 <CONSOLE_STATUS+0x3c0>
    800012b0:	00004097          	auipc	ra,0x4
    800012b4:	ca4080e7          	jalr	-860(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012b8:	00148493          	addi	s1,s1,1
    800012bc:	01893783          	ld	a5,24(s2)
    800012c0:	0037d793          	srli	a5,a5,0x3
    800012c4:	00178793          	addi	a5,a5,1
    800012c8:	fcf4e6e3          	bltu	s1,a5,80001294 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    800012cc:	00007517          	auipc	a0,0x7
    800012d0:	0c450513          	addi	a0,a0,196 # 80008390 <CONSOLE_STATUS+0x380>
    800012d4:	00004097          	auipc	ra,0x4
    800012d8:	b60080e7          	jalr	-1184(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    800012dc:	01813083          	ld	ra,24(sp)
    800012e0:	01013403          	ld	s0,16(sp)
    800012e4:	00813483          	ld	s1,8(sp)
    800012e8:	00013903          	ld	s2,0(sp)
    800012ec:	02010113          	addi	sp,sp,32
    800012f0:	00008067          	ret
    800012f4:	00008067          	ret

00000000800012f8 <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    800012f8:	fe010113          	addi	sp,sp,-32
    800012fc:	00113c23          	sd	ra,24(sp)
    80001300:	00813823          	sd	s0,16(sp)
    80001304:	00913423          	sd	s1,8(sp)
    80001308:	01213023          	sd	s2,0(sp)
    8000130c:	02010413          	addi	s0,sp,32
    80001310:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    80001314:	00007517          	auipc	a0,0x7
    80001318:	db450513          	addi	a0,a0,-588 # 800080c8 <CONSOLE_STATUS+0xb8>
    8000131c:	00004097          	auipc	ra,0x4
    80001320:	b18080e7          	jalr	-1256(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001324:	00090513          	mv	a0,s2
    80001328:	00004097          	auipc	ra,0x4
    8000132c:	b0c080e7          	jalr	-1268(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001330:	00007517          	auipc	a0,0x7
    80001334:	06050513          	addi	a0,a0,96 # 80008390 <CONSOLE_STATUS+0x380>
    80001338:	00004097          	auipc	ra,0x4
    8000133c:	afc080e7          	jalr	-1284(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80001340:	01000693          	li	a3,16
    80001344:	00007617          	auipc	a2,0x7
    80001348:	04c60613          	addi	a2,a2,76 # 80008390 <CONSOLE_STATUS+0x380>
    8000134c:	0009059b          	sext.w	a1,s2
    80001350:	00007517          	auipc	a0,0x7
    80001354:	d8850513          	addi	a0,a0,-632 # 800080d8 <CONSOLE_STATUS+0xc8>
    80001358:	00004097          	auipc	ra,0x4
    8000135c:	bfc080e7          	jalr	-1028(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n",10);
    80001360:	00a00693          	li	a3,10
    80001364:	00007617          	auipc	a2,0x7
    80001368:	02c60613          	addi	a2,a2,44 # 80008390 <CONSOLE_STATUS+0x380>
    8000136c:	04892583          	lw	a1,72(s2)
    80001370:	00007517          	auipc	a0,0x7
    80001374:	d7850513          	addi	a0,a0,-648 # 800080e8 <CONSOLE_STATUS+0xd8>
    80001378:	00004097          	auipc	ra,0x4
    8000137c:	bdc080e7          	jalr	-1060(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n",10);
    80001380:	00a00693          	li	a3,10
    80001384:	00007617          	auipc	a2,0x7
    80001388:	00c60613          	addi	a2,a2,12 # 80008390 <CONSOLE_STATUS+0x380>
    8000138c:	04092583          	lw	a1,64(s2)
    80001390:	00007517          	auipc	a0,0x7
    80001394:	d7050513          	addi	a0,a0,-656 # 80008100 <CONSOLE_STATUS+0xf0>
    80001398:	00004097          	auipc	ra,0x4
    8000139c:	bbc080e7          	jalr	-1092(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013a0:	01000693          	li	a3,16
    800013a4:	00007617          	auipc	a2,0x7
    800013a8:	fec60613          	addi	a2,a2,-20 # 80008390 <CONSOLE_STATUS+0x380>
    800013ac:	06092583          	lw	a1,96(s2)
    800013b0:	00007517          	auipc	a0,0x7
    800013b4:	d6850513          	addi	a0,a0,-664 # 80008118 <CONSOLE_STATUS+0x108>
    800013b8:	00004097          	auipc	ra,0x4
    800013bc:	b9c080e7          	jalr	-1124(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>

    Slab* iter = cache->emptyHead;
    800013c0:	06093483          	ld	s1,96(s2)
    while(iter){
    800013c4:	02048663          	beqz	s1,800013f0 <_ZN13SlabAllocator10printCacheEP5Cache+0xf8>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013c8:	01000693          	li	a3,16
    800013cc:	00007617          	auipc	a2,0x7
    800013d0:	d2c60613          	addi	a2,a2,-724 # 800080f8 <CONSOLE_STATUS+0xe8>
    800013d4:	0004859b          	sext.w	a1,s1
    800013d8:	00007517          	auipc	a0,0x7
    800013dc:	ff850513          	addi	a0,a0,-8 # 800083d0 <CONSOLE_STATUS+0x3c0>
    800013e0:	00004097          	auipc	ra,0x4
    800013e4:	b74080e7          	jalr	-1164(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800013e8:	0084b483          	ld	s1,8(s1)
    while(iter){
    800013ec:	fd9ff06f          	j	800013c4 <_ZN13SlabAllocator10printCacheEP5Cache+0xcc>
    }
    ConsoleUtil::printString("\n");
    800013f0:	00007517          	auipc	a0,0x7
    800013f4:	fa050513          	addi	a0,a0,-96 # 80008390 <CONSOLE_STATUS+0x380>
    800013f8:	00004097          	auipc	ra,0x4
    800013fc:	a3c080e7          	jalr	-1476(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80001400:	01000693          	li	a3,16
    80001404:	00007617          	auipc	a2,0x7
    80001408:	f8c60613          	addi	a2,a2,-116 # 80008390 <CONSOLE_STATUS+0x380>
    8000140c:	06892583          	lw	a1,104(s2)
    80001410:	00007517          	auipc	a0,0x7
    80001414:	d1850513          	addi	a0,a0,-744 # 80008128 <CONSOLE_STATUS+0x118>
    80001418:	00004097          	auipc	ra,0x4
    8000141c:	b3c080e7          	jalr	-1220(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->partialHead;
    80001420:	06893483          	ld	s1,104(s2)
    while(iter){
    80001424:	02048663          	beqz	s1,80001450 <_ZN13SlabAllocator10printCacheEP5Cache+0x158>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001428:	01000693          	li	a3,16
    8000142c:	00007617          	auipc	a2,0x7
    80001430:	ccc60613          	addi	a2,a2,-820 # 800080f8 <CONSOLE_STATUS+0xe8>
    80001434:	0004859b          	sext.w	a1,s1
    80001438:	00007517          	auipc	a0,0x7
    8000143c:	f9850513          	addi	a0,a0,-104 # 800083d0 <CONSOLE_STATUS+0x3c0>
    80001440:	00004097          	auipc	ra,0x4
    80001444:	b14080e7          	jalr	-1260(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001448:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000144c:	fd9ff06f          	j	80001424 <_ZN13SlabAllocator10printCacheEP5Cache+0x12c>
    }
    ConsoleUtil::printString("\n");
    80001450:	00007517          	auipc	a0,0x7
    80001454:	f4050513          	addi	a0,a0,-192 # 80008390 <CONSOLE_STATUS+0x380>
    80001458:	00004097          	auipc	ra,0x4
    8000145c:	9dc080e7          	jalr	-1572(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001460:	01000693          	li	a3,16
    80001464:	00007617          	auipc	a2,0x7
    80001468:	f2c60613          	addi	a2,a2,-212 # 80008390 <CONSOLE_STATUS+0x380>
    8000146c:	07092583          	lw	a1,112(s2)
    80001470:	00007517          	auipc	a0,0x7
    80001474:	cc850513          	addi	a0,a0,-824 # 80008138 <CONSOLE_STATUS+0x128>
    80001478:	00004097          	auipc	ra,0x4
    8000147c:	adc080e7          	jalr	-1316(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->fullHead;
    80001480:	07093483          	ld	s1,112(s2)
    while(iter){
    80001484:	02048663          	beqz	s1,800014b0 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001488:	01000693          	li	a3,16
    8000148c:	00007617          	auipc	a2,0x7
    80001490:	c6c60613          	addi	a2,a2,-916 # 800080f8 <CONSOLE_STATUS+0xe8>
    80001494:	0004859b          	sext.w	a1,s1
    80001498:	00007517          	auipc	a0,0x7
    8000149c:	f3850513          	addi	a0,a0,-200 # 800083d0 <CONSOLE_STATUS+0x3c0>
    800014a0:	00004097          	auipc	ra,0x4
    800014a4:	ab4080e7          	jalr	-1356(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800014a8:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014ac:	fd9ff06f          	j	80001484 <_ZN13SlabAllocator10printCacheEP5Cache+0x18c>
    }
    ConsoleUtil::printString("\n");
    800014b0:	00007517          	auipc	a0,0x7
    800014b4:	ee050513          	addi	a0,a0,-288 # 80008390 <CONSOLE_STATUS+0x380>
    800014b8:	00004097          	auipc	ra,0x4
    800014bc:	97c080e7          	jalr	-1668(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
}
    800014c0:	01813083          	ld	ra,24(sp)
    800014c4:	01013403          	ld	s0,16(sp)
    800014c8:	00813483          	ld	s1,8(sp)
    800014cc:	00013903          	ld	s2,0(sp)
    800014d0:	02010113          	addi	sp,sp,32
    800014d4:	00008067          	ret

00000000800014d8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    800014d8:	ff010113          	addi	sp,sp,-16
    800014dc:	00813423          	sd	s0,8(sp)
    800014e0:	01010413          	addi	s0,sp,16
    slab->next = head;
    800014e4:	00053783          	ld	a5,0(a0)
    800014e8:	00f5b423          	sd	a5,8(a1)
    if(head)
    800014ec:	00078463          	beqz	a5,800014f4 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    800014f0:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    800014f4:	0005b023          	sd	zero,0(a1)
    head = slab;
    800014f8:	00b53023          	sd	a1,0(a0)
}
    800014fc:	00813403          	ld	s0,8(sp)
    80001500:	01010113          	addi	sp,sp,16
    80001504:	00008067          	ret

0000000080001508 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    80001508:	fd010113          	addi	sp,sp,-48
    8000150c:	02113423          	sd	ra,40(sp)
    80001510:	02813023          	sd	s0,32(sp)
    80001514:	00913c23          	sd	s1,24(sp)
    80001518:	01213823          	sd	s2,16(sp)
    8000151c:	01313423          	sd	s3,8(sp)
    80001520:	03010413          	addi	s0,sp,48
    80001524:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    80001528:	04853503          	ld	a0,72(a0)
    8000152c:	00001097          	auipc	ra,0x1
    80001530:	1bc080e7          	jalr	444(ra) # 800026e8 <_ZN5Buddy5allocEm>
    if(!slab)
    80001534:	0a050063          	beqz	a0,800015d4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xcc>
    80001538:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    8000153c:	00050593          	mv	a1,a0
    80001540:	06098513          	addi	a0,s3,96
    80001544:	00000097          	auipc	ra,0x0
    80001548:	f94080e7          	jalr	-108(ra) # 800014d8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    8000154c:	0489b783          	ld	a5,72(s3)
    80001550:	00100693          	li	a3,1
    80001554:	00f696bb          	sllw	a3,a3,a5
    80001558:	00c6969b          	slliw	a3,a3,0xc
    8000155c:	bd068693          	addi	a3,a3,-1072
    80001560:	0409b783          	ld	a5,64(s3)
    80001564:	02f6d6b3          	divu	a3,a3,a5
    80001568:	00d4b823          	sd	a3,16(s1)
    8000156c:	00d4bc23          	sd	a3,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab));
    80001570:	43048793          	addi	a5,s1,1072
    80001574:	42f4b023          	sd	a5,1056(s1)
    slab->parent = cache;
    80001578:	4334b423          	sd	s3,1064(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    8000157c:	00000713          	li	a4,0
    80001580:	0036d793          	srli	a5,a3,0x3
    80001584:	00178793          	addi	a5,a5,1
    80001588:	00f77a63          	bgeu	a4,a5,8000159c <_ZN13SlabAllocator12allocateSlabEP5Cache+0x94>
        slab->allocated[i] = 0;
    8000158c:	00e487b3          	add	a5,s1,a4
    80001590:	02078023          	sb	zero,32(a5)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    80001594:	00170713          	addi	a4,a4,1
    80001598:	fe9ff06f          	j	80001580 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x78>
    if(cache->ctor) {
    8000159c:	0509b783          	ld	a5,80(s3)
    800015a0:	02078e63          	beqz	a5,800015dc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xd4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800015a4:	00000913          	li	s2,0
    800015a8:	0184b783          	ld	a5,24(s1)
    800015ac:	02f97c63          	bgeu	s2,a5,800015e4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xdc>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800015b0:	0509b703          	ld	a4,80(s3)
    800015b4:	4204b503          	ld	a0,1056(s1)
    800015b8:	4284b783          	ld	a5,1064(s1)
    800015bc:	0407b783          	ld	a5,64(a5)
    800015c0:	032787b3          	mul	a5,a5,s2
    800015c4:	00f50533          	add	a0,a0,a5
    800015c8:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800015cc:	00190913          	addi	s2,s2,1
    800015d0:	fd9ff06f          	j	800015a8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa0>
        return false;
    800015d4:	00000513          	li	a0,0
    800015d8:	0100006f          	j	800015e8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe0>
    return true;
    800015dc:	00100513          	li	a0,1
    800015e0:	0080006f          	j	800015e8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe0>
    800015e4:	00100513          	li	a0,1
}
    800015e8:	02813083          	ld	ra,40(sp)
    800015ec:	02013403          	ld	s0,32(sp)
    800015f0:	01813483          	ld	s1,24(sp)
    800015f4:	01013903          	ld	s2,16(sp)
    800015f8:	00813983          	ld	s3,8(sp)
    800015fc:	03010113          	addi	sp,sp,48
    80001600:	00008067          	ret

0000000080001604 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80001604:	ff010113          	addi	sp,sp,-16
    80001608:	00813423          	sd	s0,8(sp)
    8000160c:	01010413          	addi	s0,sp,16
    if(slab == head)
    80001610:	00053783          	ld	a5,0(a0)
    80001614:	02b78c63          	beq	a5,a1,8000164c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80001618:	0085b783          	ld	a5,8(a1)
    8000161c:	00078663          	beqz	a5,80001628 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    80001620:	0005b703          	ld	a4,0(a1)
    80001624:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80001628:	0005b783          	ld	a5,0(a1)
    8000162c:	00078663          	beqz	a5,80001638 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    80001630:	0085b703          	ld	a4,8(a1)
    80001634:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80001638:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    8000163c:	0005b423          	sd	zero,8(a1)
}
    80001640:	00813403          	ld	s0,8(sp)
    80001644:	01010113          	addi	sp,sp,16
    80001648:	00008067          	ret
        head = slab->next;
    8000164c:	0085b783          	ld	a5,8(a1)
    80001650:	00f53023          	sd	a5,0(a0)
    80001654:	fc5ff06f          	j	80001618 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

0000000080001658 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    80001658:	fe010113          	addi	sp,sp,-32
    8000165c:	00113c23          	sd	ra,24(sp)
    80001660:	00813823          	sd	s0,16(sp)
    80001664:	00913423          	sd	s1,8(sp)
    80001668:	01213023          	sd	s2,0(sp)
    8000166c:	02010413          	addi	s0,sp,32
    80001670:	00058913          	mv	s2,a1
    80001674:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    80001678:	00060593          	mv	a1,a2
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	f88080e7          	jalr	-120(ra) # 80001604 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    80001684:	00048593          	mv	a1,s1
    80001688:	00090513          	mv	a0,s2
    8000168c:	00000097          	auipc	ra,0x0
    80001690:	e4c080e7          	jalr	-436(ra) # 800014d8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    80001694:	01813083          	ld	ra,24(sp)
    80001698:	01013403          	ld	s0,16(sp)
    8000169c:	00813483          	ld	s1,8(sp)
    800016a0:	00013903          	ld	s2,0(sp)
    800016a4:	02010113          	addi	sp,sp,32
    800016a8:	00008067          	ret

00000000800016ac <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    800016ac:	fe010113          	addi	sp,sp,-32
    800016b0:	00113c23          	sd	ra,24(sp)
    800016b4:	00813823          	sd	s0,16(sp)
    800016b8:	00913423          	sd	s1,8(sp)
    800016bc:	01213023          	sd	s2,0(sp)
    800016c0:	02010413          	addi	s0,sp,32
    800016c4:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    800016c8:	00000493          	li	s1,0
    800016cc:	01893683          	ld	a3,24(s2)
    800016d0:	0ad4f663          	bgeu	s1,a3,8000177c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd0>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    800016d4:	0034d613          	srli	a2,s1,0x3
    800016d8:	00c907b3          	add	a5,s2,a2
    800016dc:	0207c583          	lbu	a1,32(a5)
    800016e0:	fff4c793          	not	a5,s1
    800016e4:	0077f793          	andi	a5,a5,7
    800016e8:	40f5d73b          	sraw	a4,a1,a5
    800016ec:	00177713          	andi	a4,a4,1
    800016f0:	00070663          	beqz	a4,800016fc <_ZN13SlabAllocator12allocateSlotEP4Slab+0x50>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    800016f4:	00148493          	addi	s1,s1,1
    800016f8:	fd5ff06f          	j	800016cc <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    800016fc:	00100713          	li	a4,1
    80001700:	00f717bb          	sllw	a5,a4,a5
    80001704:	00c90633          	add	a2,s2,a2
    80001708:	00f5e5b3          	or	a1,a1,a5
    8000170c:	02b60023          	sb	a1,32(a2)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001710:	01093783          	ld	a5,16(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001714:	04f68863          	beq	a3,a5,80001764 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb8>
    80001718:	42893503          	ld	a0,1064(s2)
    8000171c:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80001720:	fff78793          	addi	a5,a5,-1
    80001724:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001728:	04079463          	bnez	a5,80001770 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc4>
    8000172c:	42893583          	ld	a1,1064(s2)
    80001730:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80001734:	0005b703          	ld	a4,0(a1)
    80001738:	00053783          	ld	a5,0(a0)
    8000173c:	00f70863          	beq	a4,a5,8000174c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa0>
                SlabAllocator::move(headFrom, headTo, slab);
    80001740:	00090613          	mv	a2,s2
    80001744:	00000097          	auipc	ra,0x0
    80001748:	f14080e7          	jalr	-236(ra) # 80001658 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    8000174c:	42093503          	ld	a0,1056(s2)
    80001750:	42893783          	ld	a5,1064(s2)
    80001754:	0407b783          	ld	a5,64(a5)
    80001758:	029784b3          	mul	s1,a5,s1
    8000175c:	00950533          	add	a0,a0,s1
    80001760:	0200006f          	j	80001780 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001764:	42893503          	ld	a0,1064(s2)
    80001768:	06050513          	addi	a0,a0,96
    8000176c:	fb5ff06f          	j	80001720 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x74>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001770:	42893583          	ld	a1,1064(s2)
    80001774:	06858593          	addi	a1,a1,104
    80001778:	fbdff06f          	j	80001734 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x88>
    return nullptr;
    8000177c:	00000513          	li	a0,0
}
    80001780:	01813083          	ld	ra,24(sp)
    80001784:	01013403          	ld	s0,16(sp)
    80001788:	00813483          	ld	s1,8(sp)
    8000178c:	00013903          	ld	s2,0(sp)
    80001790:	02010113          	addi	sp,sp,32
    80001794:	00008067          	ret

0000000080001798 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    80001798:	fe010113          	addi	sp,sp,-32
    8000179c:	00113c23          	sd	ra,24(sp)
    800017a0:	00813823          	sd	s0,16(sp)
    800017a4:	00913423          	sd	s1,8(sp)
    800017a8:	01213023          	sd	s2,0(sp)
    800017ac:	02010413          	addi	s0,sp,32
    800017b0:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    800017b4:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    800017b8:	00048c63          	beqz	s1,800017d0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    800017bc:	00048513          	mv	a0,s1
    800017c0:	00000097          	auipc	ra,0x0
    800017c4:	eec080e7          	jalr	-276(ra) # 800016ac <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    800017c8:	fe0508e3          	beqz	a0,800017b8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    800017cc:	00050493          	mv	s1,a0
    if(ret){
    800017d0:	02048063          	beqz	s1,800017f0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    800017d4:	00048513          	mv	a0,s1
    800017d8:	01813083          	ld	ra,24(sp)
    800017dc:	01013403          	ld	s0,16(sp)
    800017e0:	00813483          	ld	s1,8(sp)
    800017e4:	00013903          	ld	s2,0(sp)
    800017e8:	02010113          	addi	sp,sp,32
    800017ec:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    800017f0:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    800017f4:	00048c63          	beqz	s1,8000180c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    800017f8:	00048513          	mv	a0,s1
    800017fc:	00000097          	auipc	ra,0x0
    80001800:	eb0080e7          	jalr	-336(ra) # 800016ac <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001804:	fe0508e3          	beqz	a0,800017f4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80001808:	00050493          	mv	s1,a0
    if(ret){
    8000180c:	fc0494e3          	bnez	s1,800017d4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80001810:	00090513          	mv	a0,s2
    80001814:	00000097          	auipc	ra,0x0
    80001818:	cf4080e7          	jalr	-780(ra) # 80001508 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    8000181c:	fa050ce3          	beqz	a0,800017d4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001820:	06093503          	ld	a0,96(s2)
    80001824:	00000097          	auipc	ra,0x0
    80001828:	e88080e7          	jalr	-376(ra) # 800016ac <_ZN13SlabAllocator12allocateSlotEP4Slab>
    8000182c:	00050493          	mv	s1,a0
    return ret;
    80001830:	fa5ff06f          	j	800017d4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

0000000080001834 <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    80001834:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80001838:	0017d513          	srli	a0,a5,0x1
    8000183c:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80001840:	0027d713          	srli	a4,a5,0x2
    80001844:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80001848:	0047d713          	srli	a4,a5,0x4
    8000184c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80001850:	0087d713          	srli	a4,a5,0x8
    80001854:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80001858:	0107d713          	srli	a4,a5,0x10
    8000185c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80001860:	0207d713          	srli	a4,a5,0x20
    80001864:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80001868:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    8000186c:	00000713          	li	a4,0
        while(num>1){
    80001870:	00100693          	li	a3,1
    80001874:	00f6f863          	bgeu	a3,a5,80001884 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    80001878:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000187c:	00170713          	addi	a4,a4,1
        while(num>1){
    80001880:	ff1ff06f          	j	80001870 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    80001884:	ffb70713          	addi	a4,a4,-5
    80001888:	00c00793          	li	a5,12
    8000188c:	04e7e063          	bltu	a5,a4,800018cc <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    80001890:	ff010113          	addi	sp,sp,-16
    80001894:	00113423          	sd	ra,8(sp)
    80001898:	00813023          	sd	s0,0(sp)
    8000189c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    800018a0:	00371713          	slli	a4,a4,0x3
    800018a4:	00007797          	auipc	a5,0x7
    800018a8:	2ec78793          	addi	a5,a5,748 # 80008b90 <_ZN13SlabAllocator5sizeNE>
    800018ac:	00e78733          	add	a4,a5,a4
    800018b0:	00073503          	ld	a0,0(a4)
    800018b4:	00000097          	auipc	ra,0x0
    800018b8:	ee4080e7          	jalr	-284(ra) # 80001798 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800018bc:	00813083          	ld	ra,8(sp)
    800018c0:	00013403          	ld	s0,0(sp)
    800018c4:	01010113          	addi	sp,sp,16
    800018c8:	00008067          	ret
        return nullptr;
    800018cc:	00000513          	li	a0,0
}
    800018d0:	00008067          	ret

00000000800018d4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800018d4:	fc010113          	addi	sp,sp,-64
    800018d8:	02113c23          	sd	ra,56(sp)
    800018dc:	02813823          	sd	s0,48(sp)
    800018e0:	02913423          	sd	s1,40(sp)
    800018e4:	03213023          	sd	s2,32(sp)
    800018e8:	01313c23          	sd	s3,24(sp)
    800018ec:	01413823          	sd	s4,16(sp)
    800018f0:	01513423          	sd	s5,8(sp)
    800018f4:	04010413          	addi	s0,sp,64
    800018f8:	00050913          	mv	s2,a0
    800018fc:	00058493          	mv	s1,a1
    80001900:	00060a93          	mv	s5,a2
    80001904:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001908:	00007517          	auipc	a0,0x7
    8000190c:	2f053503          	ld	a0,752(a0) # 80008bf8 <_ZN13SlabAllocator5cacheE>
    80001910:	00000097          	auipc	ra,0x0
    80001914:	e88080e7          	jalr	-376(ra) # 80001798 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001918:	00050993          	mv	s3,a0
    if(ret == nullptr)
    8000191c:	08050863          	beqz	a0,800019ac <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xd8>
    ret->ctor = ctor;
    80001920:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80001924:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80001928:	06053823          	sd	zero,112(a0)
    8000192c:	06053423          	sd	zero,104(a0)
    80001930:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80001934:	04953023          	sd	s1,64(a0)
        num--;
    80001938:	fff48793          	addi	a5,s1,-1
        num |= num>>1;
    8000193c:	0017d493          	srli	s1,a5,0x1
    80001940:	0097e7b3          	or	a5,a5,s1
        num |= num>>2;
    80001944:	0027d493          	srli	s1,a5,0x2
    80001948:	0097e7b3          	or	a5,a5,s1
        num |= num>>4;
    8000194c:	0047d713          	srli	a4,a5,0x4
    80001950:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80001954:	0087d713          	srli	a4,a5,0x8
    80001958:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    8000195c:	0107d713          	srli	a4,a5,0x10
    80001960:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80001964:	0207d713          	srli	a4,a5,0x20
    80001968:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    8000196c:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80001970:	00000713          	li	a4,0
        while(num>1){
    80001974:	00100693          	li	a3,1
    80001978:	00f6f863          	bgeu	a3,a5,80001988 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xb4>
            num/=2;
    8000197c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001980:	00170713          	addi	a4,a4,1
        while(num>1){
    80001984:	ff1ff06f          	j	80001974 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xa0>
    int deg = Buddy::getDeg(Buddy::ceil(size));
    80001988:	0007071b          	sext.w	a4,a4
    if(deg < 12){
    8000198c:	00b00793          	li	a5,11
    80001990:	04e7c263          	blt	a5,a4,800019d4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x100>
        ret->slabSize = DEFAULT_SLAB_SIZE;
    80001994:	00100793          	li	a5,1
    80001998:	04f9b423          	sd	a5,72(s3)
    strcpy(name, ret->name);
    8000199c:	00098593          	mv	a1,s3
    800019a0:	00090513          	mv	a0,s2
    800019a4:	00003097          	auipc	ra,0x3
    800019a8:	f58080e7          	jalr	-168(ra) # 800048fc <_Z6strcpyPKcPc>
}
    800019ac:	00098513          	mv	a0,s3
    800019b0:	03813083          	ld	ra,56(sp)
    800019b4:	03013403          	ld	s0,48(sp)
    800019b8:	02813483          	ld	s1,40(sp)
    800019bc:	02013903          	ld	s2,32(sp)
    800019c0:	01813983          	ld	s3,24(sp)
    800019c4:	01013a03          	ld	s4,16(sp)
    800019c8:	00813a83          	ld	s5,8(sp)
    800019cc:	04010113          	addi	sp,sp,64
    800019d0:	00008067          	ret
        deg-=10;
    800019d4:	ff67071b          	addiw	a4,a4,-10
        ret->slabSize = deg;
    800019d8:	04e9b423          	sd	a4,72(s3)
    800019dc:	fc1ff06f          	j	8000199c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xc8>

00000000800019e0 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    800019e0:	fe010113          	addi	sp,sp,-32
    800019e4:	00113c23          	sd	ra,24(sp)
    800019e8:	00813823          	sd	s0,16(sp)
    800019ec:	00913423          	sd	s1,8(sp)
    800019f0:	01213023          	sd	s2,0(sp)
    800019f4:	02010413          	addi	s0,sp,32
    Buddy::initialize(space, blockNum);
    800019f8:	00001097          	auipc	ra,0x1
    800019fc:	920080e7          	jalr	-1760(ra) # 80002318 <_ZN5Buddy10initializeEPvm>
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80001a00:	00007797          	auipc	a5,0x7
    80001a04:	0707b783          	ld	a5,112(a5) # 80008a70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001a08:	0007b583          	ld	a1,0(a5)
    80001a0c:	00c5d593          	srli	a1,a1,0xc
    80001a10:	00158593          	addi	a1,a1,1
    80001a14:	00c59593          	slli	a1,a1,0xc
    80001a18:	00007797          	auipc	a5,0x7
    80001a1c:	1eb7b023          	sd	a1,480(a5) # 80008bf8 <_ZN13SlabAllocator5cacheE>
    cache->ctor = nullptr;
    80001a20:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80001a24:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80001a28:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80001a2c:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80001a30:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80001a34:	07800793          	li	a5,120
    80001a38:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001a3c:	00100793          	li	a5,1
    80001a40:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001a44:	00006517          	auipc	a0,0x6
    80001a48:	70450513          	addi	a0,a0,1796 # 80008148 <CONSOLE_STATUS+0x138>
    80001a4c:	00003097          	auipc	ra,0x3
    80001a50:	eb0080e7          	jalr	-336(ra) # 800048fc <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a54:	00000493          	li	s1,0
    80001a58:	0480006f          	j	80001aa0 <_ZN13SlabAllocator10initializeEPvm+0xc0>
        sizeN[i] = SlabAllocator::createCache(names[i], 1<<(i+CACHE_LOWER_BOUND), nullptr, nullptr);
    80001a5c:	0054871b          	addiw	a4,s1,5
    80001a60:	00349913          	slli	s2,s1,0x3
    80001a64:	00007797          	auipc	a5,0x7
    80001a68:	f4c78793          	addi	a5,a5,-180 # 800089b0 <_ZN13SlabAllocator5namesE>
    80001a6c:	012787b3          	add	a5,a5,s2
    80001a70:	00000693          	li	a3,0
    80001a74:	00000613          	li	a2,0
    80001a78:	00100593          	li	a1,1
    80001a7c:	00e595bb          	sllw	a1,a1,a4
    80001a80:	0007b503          	ld	a0,0(a5)
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	e50080e7          	jalr	-432(ra) # 800018d4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a8c:	00007797          	auipc	a5,0x7
    80001a90:	10478793          	addi	a5,a5,260 # 80008b90 <_ZN13SlabAllocator5sizeNE>
    80001a94:	012787b3          	add	a5,a5,s2
    80001a98:	00a7b023          	sd	a0,0(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a9c:	0014849b          	addiw	s1,s1,1
    80001aa0:	00c00793          	li	a5,12
    80001aa4:	fa97dce3          	bge	a5,s1,80001a5c <_ZN13SlabAllocator10initializeEPvm+0x7c>
}
    80001aa8:	01813083          	ld	ra,24(sp)
    80001aac:	01013403          	ld	s0,16(sp)
    80001ab0:	00813483          	ld	s1,8(sp)
    80001ab4:	00013903          	ld	s2,0(sp)
    80001ab8:	02010113          	addi	sp,sp,32
    80001abc:	00008067          	ret

0000000080001ac0 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80001ac0:	0035d713          	srli	a4,a1,0x3
    80001ac4:	00e507b3          	add	a5,a0,a4
    80001ac8:	0207c683          	lbu	a3,32(a5)
    80001acc:	fff5c593          	not	a1,a1
    80001ad0:	0075f593          	andi	a1,a1,7
    80001ad4:	40b6d7bb          	sraw	a5,a3,a1
    80001ad8:	0017f793          	andi	a5,a5,1
    80001adc:	0c078463          	beqz	a5,80001ba4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xe4>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001ae0:	fe010113          	addi	sp,sp,-32
    80001ae4:	00113c23          	sd	ra,24(sp)
    80001ae8:	00813823          	sd	s0,16(sp)
    80001aec:	00913423          	sd	s1,8(sp)
    80001af0:	02010413          	addi	s0,sp,32
    80001af4:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80001af8:	00100793          	li	a5,1
    80001afc:	00b795bb          	sllw	a1,a5,a1
    80001b00:	00e50733          	add	a4,a0,a4
    80001b04:	fff5c593          	not	a1,a1
    80001b08:	00d5f5b3          	and	a1,a1,a3
    80001b0c:	02b70023          	sb	a1,32(a4)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001b10:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b14:	04079a63          	bnez	a5,80001b68 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001b18:	42853503          	ld	a0,1064(a0)
    80001b1c:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001b20:	00178793          	addi	a5,a5,1
    80001b24:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001b28:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b2c:	04e78463          	beq	a5,a4,80001b74 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80001b30:	4284b583          	ld	a1,1064(s1)
    80001b34:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001b38:	04e78463          	beq	a5,a4,80001b80 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80001b3c:	0005b703          	ld	a4,0(a1)
    80001b40:	00053783          	ld	a5,0(a0)
    80001b44:	00f70863          	beq	a4,a5,80001b54 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001b48:	00048613          	mv	a2,s1
    80001b4c:	00000097          	auipc	ra,0x0
    80001b50:	b0c080e7          	jalr	-1268(ra) # 80001658 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001b54:	01813083          	ld	ra,24(sp)
    80001b58:	01013403          	ld	s0,16(sp)
    80001b5c:	00813483          	ld	s1,8(sp)
    80001b60:	02010113          	addi	sp,sp,32
    80001b64:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b68:	42853503          	ld	a0,1064(a0)
    80001b6c:	06850513          	addi	a0,a0,104
    80001b70:	fb1ff06f          	j	80001b20 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b74:	4284b583          	ld	a1,1064(s1)
    80001b78:	06058593          	addi	a1,a1,96
    80001b7c:	fbdff06f          	j	80001b38 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80001b80:	00048593          	mv	a1,s1
    80001b84:	00000097          	auipc	ra,0x0
    80001b88:	a80080e7          	jalr	-1408(ra) # 80001604 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80001b8c:	4284b783          	ld	a5,1064(s1)
    80001b90:	0487b583          	ld	a1,72(a5)
    80001b94:	00048513          	mv	a0,s1
    80001b98:	00001097          	auipc	ra,0x1
    80001b9c:	a78080e7          	jalr	-1416(ra) # 80002610 <_ZN5Buddy4freeEPvm>
    80001ba0:	fb5ff06f          	j	80001b54 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001ba4:	00008067          	ret

0000000080001ba8 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001ba8:	fe010113          	addi	sp,sp,-32
    80001bac:	00113c23          	sd	ra,24(sp)
    80001bb0:	00813823          	sd	s0,16(sp)
    80001bb4:	00913423          	sd	s1,8(sp)
    80001bb8:	01213023          	sd	s2,0(sp)
    80001bbc:	02010413          	addi	s0,sp,32
    80001bc0:	00050913          	mv	s2,a0
    80001bc4:	00058493          	mv	s1,a1
    if(cache->dtor)
    80001bc8:	05853783          	ld	a5,88(a0)
    80001bcc:	00078663          	beqz	a5,80001bd8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80001bd0:	00058513          	mv	a0,a1
    80001bd4:	000780e7          	jalr	a5
    if(cache->ctor)
    80001bd8:	05093783          	ld	a5,80(s2)
    80001bdc:	00078663          	beqz	a5,80001be8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80001be0:	00048513          	mv	a0,s1
    80001be4:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001be8:	07093503          	ld	a0,112(s2)
    80001bec:	0080006f          	j	80001bf4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001bf0:	00853503          	ld	a0,8(a0)
        while(head){
    80001bf4:	02050e63          	beqz	a0,80001c30 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001bf8:	42053703          	ld	a4,1056(a0)
    80001bfc:	01853783          	ld	a5,24(a0)
    80001c00:	42853683          	ld	a3,1064(a0)
    80001c04:	0406b583          	ld	a1,64(a3)
    80001c08:	02b787b3          	mul	a5,a5,a1
    80001c0c:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c10:	fef4f0e3          	bgeu	s1,a5,80001bf0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80001c14:	fce4eee3          	bltu	s1,a4,80001bf0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c18:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80001c1c:	02b755b3          	divu	a1,a4,a1
    80001c20:	00000097          	auipc	ra,0x0
    80001c24:	ea0080e7          	jalr	-352(ra) # 80001ac0 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c28:	00100513          	li	a0,1
    80001c2c:	0080006f          	j	80001c34 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80001c30:	00000513          	li	a0,0
    if(deleted)
    80001c34:	00050e63          	beqz	a0,80001c50 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80001c38:	01813083          	ld	ra,24(sp)
    80001c3c:	01013403          	ld	s0,16(sp)
    80001c40:	00813483          	ld	s1,8(sp)
    80001c44:	00013903          	ld	s2,0(sp)
    80001c48:	02010113          	addi	sp,sp,32
    80001c4c:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001c50:	06893783          	ld	a5,104(s2)
    80001c54:	0080006f          	j	80001c5c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80001c58:	0087b783          	ld	a5,8(a5)
        while(head){
    80001c5c:	fc078ee3          	beqz	a5,80001c38 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001c60:	4207b683          	ld	a3,1056(a5)
    80001c64:	0187b703          	ld	a4,24(a5)
    80001c68:	4287b603          	ld	a2,1064(a5)
    80001c6c:	04063583          	ld	a1,64(a2)
    80001c70:	02b70733          	mul	a4,a4,a1
    80001c74:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c78:	fee4f0e3          	bgeu	s1,a4,80001c58 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80001c7c:	fcd4eee3          	bltu	s1,a3,80001c58 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c80:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001c84:	02b6d5b3          	divu	a1,a3,a1
    80001c88:	00078513          	mv	a0,a5
    80001c8c:	00000097          	auipc	ra,0x0
    80001c90:	e34080e7          	jalr	-460(ra) # 80001ac0 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c94:	00100513          	li	a0,1
    80001c98:	fa1ff06f          	j	80001c38 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080001c9c <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001c9c:	fe010113          	addi	sp,sp,-32
    80001ca0:	00113c23          	sd	ra,24(sp)
    80001ca4:	00813823          	sd	s0,16(sp)
    80001ca8:	00913423          	sd	s1,8(sp)
    80001cac:	01213023          	sd	s2,0(sp)
    80001cb0:	02010413          	addi	s0,sp,32
    80001cb4:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001cb8:	00000493          	li	s1,0
    80001cbc:	00c00793          	li	a5,12
    80001cc0:	0297c863          	blt	a5,s1,80001cf0 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001cc4:	00349713          	slli	a4,s1,0x3
    80001cc8:	00007797          	auipc	a5,0x7
    80001ccc:	ec878793          	addi	a5,a5,-312 # 80008b90 <_ZN13SlabAllocator5sizeNE>
    80001cd0:	00e787b3          	add	a5,a5,a4
    80001cd4:	00090593          	mv	a1,s2
    80001cd8:	0007b503          	ld	a0,0(a5)
    80001cdc:	00000097          	auipc	ra,0x0
    80001ce0:	ecc080e7          	jalr	-308(ra) # 80001ba8 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001ce4:	00051663          	bnez	a0,80001cf0 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001ce8:	0014849b          	addiw	s1,s1,1
    80001cec:	fd1ff06f          	j	80001cbc <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001cf0:	01813083          	ld	ra,24(sp)
    80001cf4:	01013403          	ld	s0,16(sp)
    80001cf8:	00813483          	ld	s1,8(sp)
    80001cfc:	00013903          	ld	s2,0(sp)
    80001d00:	02010113          	addi	sp,sp,32
    80001d04:	00008067          	ret

0000000080001d08 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001d08:	fe010113          	addi	sp,sp,-32
    80001d0c:	00113c23          	sd	ra,24(sp)
    80001d10:	00813823          	sd	s0,16(sp)
    80001d14:	00913423          	sd	s1,8(sp)
    80001d18:	01213023          	sd	s2,0(sp)
    80001d1c:	02010413          	addi	s0,sp,32
    80001d20:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001d24:	00053903          	ld	s2,0(a0)
    80001d28:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001d2c:	00093503          	ld	a0,0(s2)
    80001d30:	02050263          	beqz	a0,80001d54 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80001d34:	42853783          	ld	a5,1064(a0)
    80001d38:	0487b583          	ld	a1,72(a5)
    80001d3c:	00001097          	auipc	ra,0x1
    80001d40:	8d4080e7          	jalr	-1836(ra) # 80002610 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d44:	00093783          	ld	a5,0(s2)
    80001d48:	0087b783          	ld	a5,8(a5)
    80001d4c:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d50:	fddff06f          	j	80001d2c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001d54:	0004b903          	ld	s2,0(s1)
    80001d58:	06890913          	addi	s2,s2,104
    80001d5c:	00093503          	ld	a0,0(s2)
    80001d60:	02050263          	beqz	a0,80001d84 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80001d64:	42853783          	ld	a5,1064(a0)
    80001d68:	0487b583          	ld	a1,72(a5)
    80001d6c:	00001097          	auipc	ra,0x1
    80001d70:	8a4080e7          	jalr	-1884(ra) # 80002610 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d74:	00093783          	ld	a5,0(s2)
    80001d78:	0087b783          	ld	a5,8(a5)
    80001d7c:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d80:	fddff06f          	j	80001d5c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001d84:	0004b903          	ld	s2,0(s1)
    80001d88:	06090913          	addi	s2,s2,96
    80001d8c:	00093503          	ld	a0,0(s2)
    80001d90:	02050263          	beqz	a0,80001db4 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80001d94:	42853783          	ld	a5,1064(a0)
    80001d98:	0487b583          	ld	a1,72(a5)
    80001d9c:	00001097          	auipc	ra,0x1
    80001da0:	874080e7          	jalr	-1932(ra) # 80002610 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001da4:	00093783          	ld	a5,0(s2)
    80001da8:	0087b783          	ld	a5,8(a5)
    80001dac:	00f93023          	sd	a5,0(s2)
        while(head){
    80001db0:	fddff06f          	j	80001d8c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001db4:	0004b583          	ld	a1,0(s1)
    80001db8:	00007517          	auipc	a0,0x7
    80001dbc:	e4053503          	ld	a0,-448(a0) # 80008bf8 <_ZN13SlabAllocator5cacheE>
    80001dc0:	00000097          	auipc	ra,0x0
    80001dc4:	de8080e7          	jalr	-536(ra) # 80001ba8 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001dc8:	0004b023          	sd	zero,0(s1)
}
    80001dcc:	01813083          	ld	ra,24(sp)
    80001dd0:	01013403          	ld	s0,16(sp)
    80001dd4:	00813483          	ld	s1,8(sp)
    80001dd8:	00013903          	ld	s2,0(sp)
    80001ddc:	02010113          	addi	sp,sp,32
    80001de0:	00008067          	ret

0000000080001de4 <_Z6memsetPKvii>:
                                    "tc_1",
                                    "tc_2",
                                    "tc_3",
                                    "tc_4"};

void memset(const void *data, int size, int value) {
    80001de4:	ff010113          	addi	sp,sp,-16
    80001de8:	00813423          	sd	s0,8(sp)
    80001dec:	01010413          	addi	s0,sp,16
    for (int j = 0; j < size; j++) {
    80001df0:	00000793          	li	a5,0
    80001df4:	00b7da63          	bge	a5,a1,80001e08 <_Z6memsetPKvii+0x24>
        *(char *)((uint64)data+j) = value;
    80001df8:	00f50733          	add	a4,a0,a5
    80001dfc:	00c70023          	sb	a2,0(a4)
    for (int j = 0; j < size; j++) {
    80001e00:	0017879b          	addiw	a5,a5,1
    80001e04:	ff1ff06f          	j	80001df4 <_Z6memsetPKvii+0x10>
    }
}
    80001e08:	00813403          	ld	s0,8(sp)
    80001e0c:	01010113          	addi	sp,sp,16
    80001e10:	00008067          	ret

0000000080001e14 <_Z9constructPv>:

void construct(void *data) {
    80001e14:	ff010113          	addi	sp,sp,-16
    80001e18:	00113423          	sd	ra,8(sp)
    80001e1c:	00813023          	sd	s0,0(sp)
    80001e20:	01010413          	addi	s0,sp,16
//    static int i = 1;
//    printf("%d Shared object constructed.\n", i++);
    memset(data, shared_size, MASK);
    80001e24:	0a500613          	li	a2,165
    80001e28:	00700593          	li	a1,7
    80001e2c:	00000097          	auipc	ra,0x0
    80001e30:	fb8080e7          	jalr	-72(ra) # 80001de4 <_Z6memsetPKvii>
}
    80001e34:	00813083          	ld	ra,8(sp)
    80001e38:	00013403          	ld	s0,0(sp)
    80001e3c:	01010113          	addi	sp,sp,16
    80001e40:	00008067          	ret

0000000080001e44 <_Z5checkPvm>:

int check(void *data, size_t size) {
    80001e44:	ff010113          	addi	sp,sp,-16
    80001e48:	00813423          	sd	s0,8(sp)
    80001e4c:	01010413          	addi	s0,sp,16
    80001e50:	00050613          	mv	a2,a0
    int ret = 1;
    for (uint64 i = 0; i < size; i++) {
    80001e54:	00000793          	li	a5,0
    int ret = 1;
    80001e58:	00100513          	li	a0,1
    80001e5c:	0080006f          	j	80001e64 <_Z5checkPvm+0x20>
    for (uint64 i = 0; i < size; i++) {
    80001e60:	00178793          	addi	a5,a5,1
    80001e64:	00b7fe63          	bgeu	a5,a1,80001e80 <_Z5checkPvm+0x3c>
        if (((unsigned char *)data)[i] != MASK) {
    80001e68:	00f60733          	add	a4,a2,a5
    80001e6c:	00074683          	lbu	a3,0(a4)
    80001e70:	0a500713          	li	a4,165
    80001e74:	fee686e3          	beq	a3,a4,80001e60 <_Z5checkPvm+0x1c>
            ret = 0;
    80001e78:	00000513          	li	a0,0
    80001e7c:	fe5ff06f          	j	80001e60 <_Z5checkPvm+0x1c>
        }
    }

    return ret;
}
    80001e80:	00813403          	ld	s0,8(sp)
    80001e84:	01010113          	addi	sp,sp,16
    80001e88:	00008067          	ret

0000000080001e8c <_Z4workPv>:
struct objects_s {
    kmem_cache_t *cache;
    void *data;
};

void work(void* pdata) {
    80001e8c:	f8010113          	addi	sp,sp,-128
    80001e90:	06113c23          	sd	ra,120(sp)
    80001e94:	06813823          	sd	s0,112(sp)
    80001e98:	06913423          	sd	s1,104(sp)
    80001e9c:	07213023          	sd	s2,96(sp)
    80001ea0:	05313c23          	sd	s3,88(sp)
    80001ea4:	05413823          	sd	s4,80(sp)
    80001ea8:	05513423          	sd	s5,72(sp)
    80001eac:	05613023          	sd	s6,64(sp)
    80001eb0:	03713c23          	sd	s7,56(sp)
    80001eb4:	03813823          	sd	s8,48(sp)
    80001eb8:	03913423          	sd	s9,40(sp)
    80001ebc:	08010413          	addi	s0,sp,128
    struct data_s data = *(struct data_s*) pdata;
    80001ec0:	00053c03          	ld	s8,0(a0)
    80001ec4:	f9843423          	sd	s8,-120(s0)
    80001ec8:	00853783          	ld	a5,8(a0)
    80001ecc:	f8f43823          	sd	a5,-112(s0)
    80001ed0:	01053783          	ld	a5,16(a0)
    80001ed4:	f8f43c23          	sd	a5,-104(s0)
    int size = 0;
    int object_size = data.id + 1;
    80001ed8:	000c079b          	sext.w	a5,s8
    80001edc:	001c0c1b          	addiw	s8,s8,1
    kmem_cache_t *cache = kmem_cache_create(CACHE_NAMES[data.id], object_size, 0, 0);
    80001ee0:	00379713          	slli	a4,a5,0x3
    80001ee4:	00007797          	auipc	a5,0x7
    80001ee8:	b3478793          	addi	a5,a5,-1228 # 80008a18 <_ZL11CACHE_NAMES>
    80001eec:	00e787b3          	add	a5,a5,a4
    80001ef0:	000c0b13          	mv	s6,s8
    80001ef4:	00000693          	li	a3,0
    80001ef8:	00000613          	li	a2,0
    80001efc:	000c0593          	mv	a1,s8
    80001f00:	0007b503          	ld	a0,0(a5)
    80001f04:	00003097          	auipc	ra,0x3
    80001f08:	10c080e7          	jalr	268(ra) # 80005010 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001f0c:	00050a13          	mv	s4,a0

    struct objects_s *objs = (struct objects_s*)(kmalloc(sizeof(struct objects_s) * data.iterations));
    80001f10:	f9842b83          	lw	s7,-104(s0)
    80001f14:	004b9513          	slli	a0,s7,0x4
    80001f18:	00003097          	auipc	ra,0x3
    80001f1c:	1f0080e7          	jalr	496(ra) # 80005108 <_Z7kmallocm>
    80001f20:	00050a93          	mv	s5,a0

    for (int i = 0; i < data.iterations; i++) {
    80001f24:	00000493          	li	s1,0
    int size = 0;
    80001f28:	00000993          	li	s3,0
    80001f2c:	0380006f          	j	80001f64 <_Z4workPv+0xd8>
            if (!check(objs[size].data, shared_size)) {
                ConsoleUtil::printString("Value not correct!");
            }
        }
        else {
            objs[size].data = kmem_cache_alloc(cache);
    80001f30:	00499913          	slli	s2,s3,0x4
    80001f34:	012a8933          	add	s2,s5,s2
    80001f38:	000a0513          	mv	a0,s4
    80001f3c:	00003097          	auipc	ra,0x3
    80001f40:	0fc080e7          	jalr	252(ra) # 80005038 <_Z16kmem_cache_allocP5Cache>
    80001f44:	00a93423          	sd	a0,8(s2)
            objs[size].cache = cache;
    80001f48:	01493023          	sd	s4,0(s2)
            memset(objs[size].data, object_size, MASK);
    80001f4c:	0a500613          	li	a2,165
    80001f50:	000c0593          	mv	a1,s8
    80001f54:	00000097          	auipc	ra,0x0
    80001f58:	e90080e7          	jalr	-368(ra) # 80001de4 <_Z6memsetPKvii>
        }
        size++;
    80001f5c:	0019899b          	addiw	s3,s3,1
    for (int i = 0; i < data.iterations; i++) {
    80001f60:	0014849b          	addiw	s1,s1,1
    80001f64:	0574da63          	bge	s1,s7,80001fb8 <_Z4workPv+0x12c>
        if (i % 100 == 0) {
    80001f68:	06400793          	li	a5,100
    80001f6c:	02f4e7bb          	remw	a5,s1,a5
    80001f70:	fc0790e3          	bnez	a5,80001f30 <_Z4workPv+0xa4>
            objs[size].data = kmem_cache_alloc(data.shared);
    80001f74:	f9043c83          	ld	s9,-112(s0)
    80001f78:	00499913          	slli	s2,s3,0x4
    80001f7c:	012a8933          	add	s2,s5,s2
    80001f80:	000c8513          	mv	a0,s9
    80001f84:	00003097          	auipc	ra,0x3
    80001f88:	0b4080e7          	jalr	180(ra) # 80005038 <_Z16kmem_cache_allocP5Cache>
    80001f8c:	00a93423          	sd	a0,8(s2)
            objs[size].cache = data.shared;
    80001f90:	01993023          	sd	s9,0(s2)
            if (!check(objs[size].data, shared_size)) {
    80001f94:	00700593          	li	a1,7
    80001f98:	00000097          	auipc	ra,0x0
    80001f9c:	eac080e7          	jalr	-340(ra) # 80001e44 <_Z5checkPvm>
    80001fa0:	fa051ee3          	bnez	a0,80001f5c <_Z4workPv+0xd0>
                ConsoleUtil::printString("Value not correct!");
    80001fa4:	00006517          	auipc	a0,0x6
    80001fa8:	2ec50513          	addi	a0,a0,748 # 80008290 <CONSOLE_STATUS+0x280>
    80001fac:	00003097          	auipc	ra,0x3
    80001fb0:	e88080e7          	jalr	-376(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    80001fb4:	fa9ff06f          	j	80001f5c <_Z4workPv+0xd0>
    }

    kmem_cache_info(cache);
    80001fb8:	000a0513          	mv	a0,s4
    80001fbc:	00003097          	auipc	ra,0x3
    80001fc0:	0fc080e7          	jalr	252(ra) # 800050b8 <_Z15kmem_cache_infoP5Cache>
    kmem_cache_info(data.shared);
    80001fc4:	f9043503          	ld	a0,-112(s0)
    80001fc8:	00003097          	auipc	ra,0x3
    80001fcc:	0f0080e7          	jalr	240(ra) # 800050b8 <_Z15kmem_cache_infoP5Cache>

    for (int i = 0; i < size; i++) {
    80001fd0:	00000913          	li	s2,0
    80001fd4:	0300006f          	j	80002004 <_Z4workPv+0x178>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    80001fd8:	000b0593          	mv	a1,s6
    80001fdc:	0440006f          	j	80002020 <_Z4workPv+0x194>
            ConsoleUtil::printString("Value not correct!");
    80001fe0:	00006517          	auipc	a0,0x6
    80001fe4:	2b050513          	addi	a0,a0,688 # 80008290 <CONSOLE_STATUS+0x280>
    80001fe8:	00003097          	auipc	ra,0x3
    80001fec:	e4c080e7          	jalr	-436(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        }
        kmem_cache_free(objs[i].cache, objs[i].data);
    80001ff0:	0084b583          	ld	a1,8(s1)
    80001ff4:	0004b503          	ld	a0,0(s1)
    80001ff8:	00003097          	auipc	ra,0x3
    80001ffc:	068080e7          	jalr	104(ra) # 80005060 <_Z15kmem_cache_freeP5CachePv>
    for (int i = 0; i < size; i++) {
    80002000:	0019091b          	addiw	s2,s2,1
    80002004:	03395663          	bge	s2,s3,80002030 <_Z4workPv+0x1a4>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    80002008:	00491493          	slli	s1,s2,0x4
    8000200c:	009a84b3          	add	s1,s5,s1
    80002010:	0084b503          	ld	a0,8(s1)
    80002014:	0004b783          	ld	a5,0(s1)
    80002018:	fd4780e3          	beq	a5,s4,80001fd8 <_Z4workPv+0x14c>
    8000201c:	00700593          	li	a1,7
    80002020:	00000097          	auipc	ra,0x0
    80002024:	e24080e7          	jalr	-476(ra) # 80001e44 <_Z5checkPvm>
    80002028:	fc0514e3          	bnez	a0,80001ff0 <_Z4workPv+0x164>
    8000202c:	fb5ff06f          	j	80001fe0 <_Z4workPv+0x154>
    }

    kfree(objs);
    80002030:	000a8513          	mv	a0,s5
    80002034:	00003097          	auipc	ra,0x3
    80002038:	0fc080e7          	jalr	252(ra) # 80005130 <_Z5kfreePKv>
    kmem_cache_destroy(cache);
    8000203c:	000a0513          	mv	a0,s4
    80002040:	00003097          	auipc	ra,0x3
    80002044:	048080e7          	jalr	72(ra) # 80005088 <_Z18kmem_cache_destroyP5Cache>
}
    80002048:	07813083          	ld	ra,120(sp)
    8000204c:	07013403          	ld	s0,112(sp)
    80002050:	06813483          	ld	s1,104(sp)
    80002054:	06013903          	ld	s2,96(sp)
    80002058:	05813983          	ld	s3,88(sp)
    8000205c:	05013a03          	ld	s4,80(sp)
    80002060:	04813a83          	ld	s5,72(sp)
    80002064:	04013b03          	ld	s6,64(sp)
    80002068:	03813b83          	ld	s7,56(sp)
    8000206c:	03013c03          	ld	s8,48(sp)
    80002070:	02813c83          	ld	s9,40(sp)
    80002074:	08010113          	addi	sp,sp,128
    80002078:	00008067          	ret

000000008000207c <_Z4runsPFvPvEP6data_si>:



void runs(void(*work)(void*), struct data_s* data, int num) {
    8000207c:	fb010113          	addi	sp,sp,-80
    80002080:	04113423          	sd	ra,72(sp)
    80002084:	04813023          	sd	s0,64(sp)
    80002088:	02913c23          	sd	s1,56(sp)
    8000208c:	03213823          	sd	s2,48(sp)
    80002090:	03313423          	sd	s3,40(sp)
    80002094:	03413023          	sd	s4,32(sp)
    80002098:	05010413          	addi	s0,sp,80
    8000209c:	00050a13          	mv	s4,a0
    800020a0:	00058913          	mv	s2,a1
    800020a4:	00060993          	mv	s3,a2
    for (int i = 0; i < num; i++) {
    800020a8:	00000493          	li	s1,0
    800020ac:	0334d863          	bge	s1,s3,800020dc <_Z4runsPFvPvEP6data_si+0x60>
        struct data_s private_data;
        private_data = *(struct data_s*) data;
    800020b0:	00093783          	ld	a5,0(s2)
    800020b4:	faf43c23          	sd	a5,-72(s0)
    800020b8:	00893783          	ld	a5,8(s2)
    800020bc:	fcf43023          	sd	a5,-64(s0)
    800020c0:	01093783          	ld	a5,16(s2)
    800020c4:	fcf43423          	sd	a5,-56(s0)
        private_data.id = i;
    800020c8:	fa942c23          	sw	s1,-72(s0)
        work(&private_data);
    800020cc:	fb840513          	addi	a0,s0,-72
    800020d0:	000a00e7          	jalr	s4
    for (int i = 0; i < num; i++) {
    800020d4:	0014849b          	addiw	s1,s1,1
    800020d8:	fd5ff06f          	j	800020ac <_Z4runsPFvPvEP6data_si+0x30>
    }
}
    800020dc:	04813083          	ld	ra,72(sp)
    800020e0:	04013403          	ld	s0,64(sp)
    800020e4:	03813483          	ld	s1,56(sp)
    800020e8:	03013903          	ld	s2,48(sp)
    800020ec:	02813983          	ld	s3,40(sp)
    800020f0:	02013a03          	ld	s4,32(sp)
    800020f4:	05010113          	addi	sp,sp,80
    800020f8:	00008067          	ret

00000000800020fc <_Z5test2v>:

void test2() {
    800020fc:	fc010113          	addi	sp,sp,-64
    80002100:	02113c23          	sd	ra,56(sp)
    80002104:	02813823          	sd	s0,48(sp)
    80002108:	02913423          	sd	s1,40(sp)
    8000210c:	04010413          	addi	s0,sp,64
    kmem_cache_t *shared = kmem_cache_create("shared object", shared_size, construct, nullptr);
    80002110:	00000693          	li	a3,0
    80002114:	00000617          	auipc	a2,0x0
    80002118:	d0060613          	addi	a2,a2,-768 # 80001e14 <_Z9constructPv>
    8000211c:	00700593          	li	a1,7
    80002120:	00006517          	auipc	a0,0x6
    80002124:	18850513          	addi	a0,a0,392 # 800082a8 <CONSOLE_STATUS+0x298>
    80002128:	00003097          	auipc	ra,0x3
    8000212c:	ee8080e7          	jalr	-280(ra) # 80005010 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002130:	00050493          	mv	s1,a0

    struct data_s data;
    data.shared = shared;
    80002134:	fca43823          	sd	a0,-48(s0)
    data.iterations = ITERATIONS;
    80002138:	3e800793          	li	a5,1000
    8000213c:	fcf42c23          	sw	a5,-40(s0)
    runs(work, &data, RUN_NUM);
    80002140:	00500613          	li	a2,5
    80002144:	fc840593          	addi	a1,s0,-56
    80002148:	00000517          	auipc	a0,0x0
    8000214c:	d4450513          	addi	a0,a0,-700 # 80001e8c <_Z4workPv>
    80002150:	00000097          	auipc	ra,0x0
    80002154:	f2c080e7          	jalr	-212(ra) # 8000207c <_Z4runsPFvPvEP6data_si>

    kmem_cache_destroy(shared);
    80002158:	00048513          	mv	a0,s1
    8000215c:	00003097          	auipc	ra,0x3
    80002160:	f2c080e7          	jalr	-212(ra) # 80005088 <_Z18kmem_cache_destroyP5Cache>
}
    80002164:	03813083          	ld	ra,56(sp)
    80002168:	03013403          	ld	s0,48(sp)
    8000216c:	02813483          	ld	s1,40(sp)
    80002170:	04010113          	addi	sp,sp,64
    80002174:	00008067          	ret

0000000080002178 <_Z4ctorPv>:

struct Test{
    uint64 a,b,c,d,e,f;
};

void ctor(void* tst){
    80002178:	ff010113          	addi	sp,sp,-16
    8000217c:	00813423          	sd	s0,8(sp)
    80002180:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    80002184:	01100793          	li	a5,17
    80002188:	00f53023          	sd	a5,0(a0)
    ((Test*)tst)->b = 32;
    8000218c:	02000793          	li	a5,32
    80002190:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    80002194:	00d00793          	li	a5,13
    80002198:	00f53823          	sd	a5,16(a0)

}
    8000219c:	00813403          	ld	s0,8(sp)
    800021a0:	01010113          	addi	sp,sp,16
    800021a4:	00008067          	ret

00000000800021a8 <_ZN6SystemC1Ev>:


System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
    800021a8:	00007797          	auipc	a5,0x7
    800021ac:	a587c783          	lbu	a5,-1448(a5) # 80008c00 <_ZN6System11initializedE>
    800021b0:	00078463          	beqz	a5,800021b8 <_ZN6SystemC1Ev+0x10>
    800021b4:	00008067          	ret
System::System() {
    800021b8:	fe010113          	addi	sp,sp,-32
    800021bc:	00113c23          	sd	ra,24(sp)
    800021c0:	00813823          	sd	s0,16(sp)
    800021c4:	02010413          	addi	s0,sp,32
        initialized = true;
    800021c8:	00100793          	li	a5,1
    800021cc:	00007717          	auipc	a4,0x7
    800021d0:	a2f70a23          	sb	a5,-1484(a4) # 80008c00 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    800021d4:	00002097          	auipc	ra,0x2
    800021d8:	664080e7          	jalr	1636(ra) # 80004838 <_ZN5RiscV10initializeEv>

        void* ret1 = kmalloc(1<<17);
    800021dc:	00020537          	lui	a0,0x20
    800021e0:	00003097          	auipc	ra,0x3
    800021e4:	f28080e7          	jalr	-216(ra) # 80005108 <_Z7kmallocm>
        if(ret1 == nullptr){
    800021e8:	08050863          	beqz	a0,80002278 <_ZN6SystemC1Ev+0xd0>
            ConsoleUtil::printString("ERROR\n");
        }
        else{
            ConsoleUtil::print("",(uint64)ret1,"\n");
    800021ec:	01000693          	li	a3,16
    800021f0:	00006617          	auipc	a2,0x6
    800021f4:	1a060613          	addi	a2,a2,416 # 80008390 <CONSOLE_STATUS+0x380>
    800021f8:	0005059b          	sext.w	a1,a0
    800021fc:	00006517          	auipc	a0,0x6
    80002200:	1d450513          	addi	a0,a0,468 # 800083d0 <CONSOLE_STATUS+0x3c0>
    80002204:	00003097          	auipc	ra,0x3
    80002208:	d50080e7          	jalr	-688(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        };
        void* ret2 = kmalloc(1<<17);
    8000220c:	00020537          	lui	a0,0x20
    80002210:	00003097          	auipc	ra,0x3
    80002214:	ef8080e7          	jalr	-264(ra) # 80005108 <_Z7kmallocm>
        if(ret2 == nullptr){
    80002218:	06050a63          	beqz	a0,8000228c <_ZN6SystemC1Ev+0xe4>
            ConsoleUtil::printString("ERROR\n");
        }
        else{
            ConsoleUtil::print("",(uint64)ret2,"\n");
    8000221c:	01000693          	li	a3,16
    80002220:	00006617          	auipc	a2,0x6
    80002224:	17060613          	addi	a2,a2,368 # 80008390 <CONSOLE_STATUS+0x380>
    80002228:	0005059b          	sext.w	a1,a0
    8000222c:	00006517          	auipc	a0,0x6
    80002230:	1a450513          	addi	a0,a0,420 # 800083d0 <CONSOLE_STATUS+0x3c0>
    80002234:	00003097          	auipc	ra,0x3
    80002238:	d20080e7          	jalr	-736(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        };
//        for(int i=0;i<BUCKET_SIZE;i++){
//            kmem_cache_info(SlabAllocator::sizeN[i]);
//        }
        test2();
    8000223c:	00000097          	auipc	ra,0x0
    80002240:	ec0080e7          	jalr	-320(ra) # 800020fc <_Z5test2v>
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), userMainWrapper, nullptr);
    80002244:	00000613          	li	a2,0
    80002248:	00007597          	auipc	a1,0x7
    8000224c:	8805b583          	ld	a1,-1920(a1) # 80008ac8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002250:	fe840513          	addi	a0,s0,-24
    80002254:	00002097          	auipc	ra,0x2
    80002258:	fe4080e7          	jalr	-28(ra) # 80004238 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    8000225c:	fe843783          	ld	a5,-24(s0)
    80002260:	0107a703          	lw	a4,16(a5)
    80002264:	00200793          	li	a5,2
    80002268:	02f70c63          	beq	a4,a5,800022a0 <_ZN6SystemC1Ev+0xf8>
            RiscV::threadDispatchUtil();
    8000226c:	00002097          	auipc	ra,0x2
    80002270:	068080e7          	jalr	104(ra) # 800042d4 <_ZN5RiscV18threadDispatchUtilEv>
    80002274:	fe9ff06f          	j	8000225c <_ZN6SystemC1Ev+0xb4>
            ConsoleUtil::printString("ERROR\n");
    80002278:	00006517          	auipc	a0,0x6
    8000227c:	04050513          	addi	a0,a0,64 # 800082b8 <CONSOLE_STATUS+0x2a8>
    80002280:	00003097          	auipc	ra,0x3
    80002284:	bb4080e7          	jalr	-1100(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    80002288:	f85ff06f          	j	8000220c <_ZN6SystemC1Ev+0x64>
            ConsoleUtil::printString("ERROR\n");
    8000228c:	00006517          	auipc	a0,0x6
    80002290:	02c50513          	addi	a0,a0,44 # 800082b8 <CONSOLE_STATUS+0x2a8>
    80002294:	00003097          	auipc	ra,0x3
    80002298:	ba0080e7          	jalr	-1120(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    8000229c:	fa1ff06f          	j	8000223c <_ZN6SystemC1Ev+0x94>
        }

        //finalize the machine
        RiscV::finalize();
    800022a0:	00001097          	auipc	ra,0x1
    800022a4:	24c080e7          	jalr	588(ra) # 800034ec <_ZN5RiscV8finalizeEv>
    }
    800022a8:	01813083          	ld	ra,24(sp)
    800022ac:	01013403          	ld	s0,16(sp)
    800022b0:	02010113          	addi	sp,sp,32
    800022b4:	00008067          	ret

00000000800022b8 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    800022b8:	ff010113          	addi	sp,sp,-16
    800022bc:	00813423          	sd	s0,8(sp)
    800022c0:	01010413          	addi	s0,sp,16
    800022c4:	00100793          	li	a5,1
    800022c8:	00f50863          	beq	a0,a5,800022d8 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800022cc:	00813403          	ld	s0,8(sp)
    800022d0:	01010113          	addi	sp,sp,16
    800022d4:	00008067          	ret
    800022d8:	000107b7          	lui	a5,0x10
    800022dc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800022e0:	fef596e3          	bne	a1,a5,800022cc <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    800022e4:	00006797          	auipc	a5,0x6
    800022e8:	78c7b783          	ld	a5,1932(a5) # 80008a70 <_GLOBAL_OFFSET_TABLE_+0x18>
    800022ec:	0007b703          	ld	a4,0(a5)
    800022f0:	00c75793          	srli	a5,a4,0xc
    800022f4:	00278793          	addi	a5,a5,2
    800022f8:	00c79793          	slli	a5,a5,0xc
    800022fc:	00007697          	auipc	a3,0x7
    80002300:	90c68693          	addi	a3,a3,-1780 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002304:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002308:	fffff7b7          	lui	a5,0xfffff
    8000230c:	00f77733          	and	a4,a4,a5
    80002310:	00e6b423          	sd	a4,8(a3)
    80002314:	fb9ff06f          	j	800022cc <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002318 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80002318:	ff010113          	addi	sp,sp,-16
    8000231c:	00813423          	sd	s0,8(sp)
    80002320:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80002324:	00007717          	auipc	a4,0x7
    80002328:	8e470713          	addi	a4,a4,-1820 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000232c:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002330:	00006797          	auipc	a5,0x6
    80002334:	7407b783          	ld	a5,1856(a5) # 80008a70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002338:	0007b783          	ld	a5,0(a5)
    8000233c:	fffff6b7          	lui	a3,0xfffff
    80002340:	00d7f7b3          	and	a5,a5,a3
    80002344:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80002348:	00006797          	auipc	a5,0x6
    8000234c:	6eb7bc23          	sd	a1,1784(a5) # 80008a40 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80002350:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80002354:	00000713          	li	a4,0
        while(num>1){
    80002358:	00100693          	li	a3,1
    8000235c:	00f6f863          	bgeu	a3,a5,8000236c <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80002360:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002364:	00170713          	addi	a4,a4,1
        while(num>1){
    80002368:	ff1ff06f          	j	80002358 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    8000236c:	00371713          	slli	a4,a4,0x3
    80002370:	00007797          	auipc	a5,0x7
    80002374:	89878793          	addi	a5,a5,-1896 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002378:	00e78733          	add	a4,a5,a4
    8000237c:	00a73823          	sd	a0,16(a4)
    80002380:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002384:	00000713          	li	a4,0
        while(num>1){
    80002388:	00100693          	li	a3,1
    8000238c:	00f6f863          	bgeu	a3,a5,8000239c <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80002390:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002394:	00170713          	addi	a4,a4,1
        while(num>1){
    80002398:	ff1ff06f          	j	80002388 <_ZN5Buddy10initializeEPvm+0x70>
    8000239c:	00371713          	slli	a4,a4,0x3
    800023a0:	00007797          	auipc	a5,0x7
    800023a4:	86878793          	addi	a5,a5,-1944 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023a8:	00e78733          	add	a4,a5,a4
    800023ac:	06a73c23          	sd	a0,120(a4)
    800023b0:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800023b4:	00000713          	li	a4,0
        while(num>1){
    800023b8:	00100693          	li	a3,1
    800023bc:	00f6f863          	bgeu	a3,a5,800023cc <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    800023c0:	0017d793          	srli	a5,a5,0x1
            deg++;
    800023c4:	00170713          	addi	a4,a4,1
        while(num>1){
    800023c8:	ff1ff06f          	j	800023b8 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    800023cc:	00371713          	slli	a4,a4,0x3
    800023d0:	00007797          	auipc	a5,0x7
    800023d4:	83878793          	addi	a5,a5,-1992 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023d8:	00e78733          	add	a4,a5,a4
    800023dc:	01073783          	ld	a5,16(a4)
    800023e0:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    800023e4:	00000793          	li	a5,0
    800023e8:	00c0006f          	j	800023f4 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    800023ec:	0015d593          	srli	a1,a1,0x1
            deg++;
    800023f0:	00178793          	addi	a5,a5,1
        while(num>1){
    800023f4:	00100713          	li	a4,1
    800023f8:	feb76ae3          	bltu	a4,a1,800023ec <_ZN5Buddy10initializeEPvm+0xd4>
    800023fc:	00379793          	slli	a5,a5,0x3
    80002400:	00007717          	auipc	a4,0x7
    80002404:	80870713          	addi	a4,a4,-2040 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002408:	00f707b3          	add	a5,a4,a5
    8000240c:	0787b783          	ld	a5,120(a5)
    80002410:	0007b023          	sd	zero,0(a5)
}
    80002414:	00813403          	ld	s0,8(sp)
    80002418:	01010113          	addi	sp,sp,16
    8000241c:	00008067          	ret

0000000080002420 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80002420:	00c00793          	li	a5,12
    80002424:	10f50063          	beq	a0,a5,80002524 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80002428:	fd010113          	addi	sp,sp,-48
    8000242c:	02113423          	sd	ra,40(sp)
    80002430:	02813023          	sd	s0,32(sp)
    80002434:	00913c23          	sd	s1,24(sp)
    80002438:	01213823          	sd	s2,16(sp)
    8000243c:	01313423          	sd	s3,8(sp)
    80002440:	03010413          	addi	s0,sp,48
    80002444:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80002448:	00351713          	slli	a4,a0,0x3
    8000244c:	00006797          	auipc	a5,0x6
    80002450:	7bc78793          	addi	a5,a5,1980 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002454:	00e787b3          	add	a5,a5,a4
    80002458:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    8000245c:	00000993          	li	s3,0
    80002460:	0180006f          	j	80002478 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002464:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80002468:	04f70463          	beq	a4,a5,800024b0 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    8000246c:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80002470:	08f70063          	beq	a4,a5,800024f0 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80002474:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80002478:	08048863          	beqz	s1,80002508 <_ZN5Buddy8compressEm+0xe8>
    8000247c:	0004b683          	ld	a3,0(s1)
    80002480:	08068463          	beqz	a3,80002508 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002484:	00006797          	auipc	a5,0x6
    80002488:	7847b783          	ld	a5,1924(a5) # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000248c:	40f48733          	sub	a4,s1,a5
    80002490:	00c9061b          	addiw	a2,s2,12
    80002494:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002498:	40f687b3          	sub	a5,a3,a5
    8000249c:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    800024a0:	00177613          	andi	a2,a4,1
    800024a4:	fc0610e3          	bnez	a2,80002464 <_ZN5Buddy8compressEm+0x44>
    800024a8:	00170713          	addi	a4,a4,1
    800024ac:	fbdff06f          	j	80002468 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    800024b0:	00098863          	beqz	s3,800024c0 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    800024b4:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffec000>
    800024b8:	00d9b023          	sd	a3,0(s3)
    800024bc:	fb5ff06f          	j	80002470 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    800024c0:	0006b603          	ld	a2,0(a3)
    800024c4:	00391593          	slli	a1,s2,0x3
    800024c8:	00006697          	auipc	a3,0x6
    800024cc:	74068693          	addi	a3,a3,1856 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024d0:	00b686b3          	add	a3,a3,a1
    800024d4:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    800024d8:	f8061ce3          	bnez	a2,80002470 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    800024dc:	00006697          	auipc	a3,0x6
    800024e0:	72c68693          	addi	a3,a3,1836 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024e4:	00b686b3          	add	a3,a3,a1
    800024e8:	0006b823          	sd	zero,16(a3)
    800024ec:	f85ff06f          	j	80002470 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    800024f0:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    800024f4:	00190593          	addi	a1,s2,1
    800024f8:	00048513          	mv	a0,s1
    800024fc:	00000097          	auipc	ra,0x0
    80002500:	02c080e7          	jalr	44(ra) # 80002528 <_ZN5Buddy6insertEPvm>
    80002504:	f71ff06f          	j	80002474 <_ZN5Buddy8compressEm+0x54>
}
    80002508:	02813083          	ld	ra,40(sp)
    8000250c:	02013403          	ld	s0,32(sp)
    80002510:	01813483          	ld	s1,24(sp)
    80002514:	01013903          	ld	s2,16(sp)
    80002518:	00813983          	ld	s3,8(sp)
    8000251c:	03010113          	addi	sp,sp,48
    80002520:	00008067          	ret
    80002524:	00008067          	ret

0000000080002528 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80002528:	00050693          	mv	a3,a0
    if(!head[size]){
    8000252c:	00359713          	slli	a4,a1,0x3
    80002530:	00006797          	auipc	a5,0x6
    80002534:	6d878793          	addi	a5,a5,1752 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002538:	00e787b3          	add	a5,a5,a4
    8000253c:	0787b783          	ld	a5,120(a5)
    80002540:	02078c63          	beqz	a5,80002578 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80002544:	ff010113          	addi	sp,sp,-16
    80002548:	00113423          	sd	ra,8(sp)
    8000254c:	00813023          	sd	s0,0(sp)
    80002550:	01010413          	addi	s0,sp,16
    80002554:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80002558:	00068713          	mv	a4,a3
    8000255c:	04f6e063          	bltu	a3,a5,8000259c <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80002560:	00000613          	li	a2,0
            while (iter != nullptr) {
    80002564:	06078863          	beqz	a5,800025d4 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80002568:	04f76c63          	bltu	a4,a5,800025c0 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    8000256c:	00078613          	mv	a2,a5
                    iter = iter->next;
    80002570:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80002574:	ff1ff06f          	j	80002564 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80002578:	00006797          	auipc	a5,0x6
    8000257c:	69078793          	addi	a5,a5,1680 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002580:	00e78533          	add	a0,a5,a4
    80002584:	00d53823          	sd	a3,16(a0)
    80002588:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    8000258c:	0006b023          	sd	zero,0(a3)
    80002590:	07853783          	ld	a5,120(a0)
    80002594:	0007b023          	sd	zero,0(a5)
        return;
    80002598:	00008067          	ret
            newHead->next = head[size];
    8000259c:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    800025a0:	00359713          	slli	a4,a1,0x3
    800025a4:	00006797          	auipc	a5,0x6
    800025a8:	66478793          	addi	a5,a5,1636 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025ac:	00e787b3          	add	a5,a5,a4
    800025b0:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    800025b4:	00000097          	auipc	ra,0x0
    800025b8:	e6c080e7          	jalr	-404(ra) # 80002420 <_ZN5Buddy8compressEm>
            return;
    800025bc:	0440006f          	j	80002600 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    800025c0:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    800025c4:	00d63023          	sd	a3,0(a2)
                    compress(size);
    800025c8:	00000097          	auipc	ra,0x0
    800025cc:	e58080e7          	jalr	-424(ra) # 80002420 <_ZN5Buddy8compressEm>
                    return;
    800025d0:	0300006f          	j	80002600 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    800025d4:	00351713          	slli	a4,a0,0x3
    800025d8:	00006797          	auipc	a5,0x6
    800025dc:	63078793          	addi	a5,a5,1584 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025e0:	00e787b3          	add	a5,a5,a4
    800025e4:	0107b703          	ld	a4,16(a5)
    800025e8:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    800025ec:	0107b703          	ld	a4,16(a5)
    800025f0:	00073703          	ld	a4,0(a4)
    800025f4:	00e7b823          	sd	a4,16(a5)
    compress(size);
    800025f8:	00000097          	auipc	ra,0x0
    800025fc:	e28080e7          	jalr	-472(ra) # 80002420 <_ZN5Buddy8compressEm>
}
    80002600:	00813083          	ld	ra,8(sp)
    80002604:	00013403          	ld	s0,0(sp)
    80002608:	01010113          	addi	sp,sp,16
    8000260c:	00008067          	ret

0000000080002610 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80002610:	02050663          	beqz	a0,8000263c <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80002614:	ff010113          	addi	sp,sp,-16
    80002618:	00113423          	sd	ra,8(sp)
    8000261c:	00813023          	sd	s0,0(sp)
    80002620:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80002624:	00000097          	auipc	ra,0x0
    80002628:	f04080e7          	jalr	-252(ra) # 80002528 <_ZN5Buddy6insertEPvm>
}
    8000262c:	00813083          	ld	ra,8(sp)
    80002630:	00013403          	ld	s0,0(sp)
    80002634:	01010113          	addi	sp,sp,16
    80002638:	00008067          	ret
    8000263c:	00008067          	ret

0000000080002640 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002640:	ff010113          	addi	sp,sp,-16
    80002644:	00813423          	sd	s0,8(sp)
    80002648:	01010413          	addi	s0,sp,16
    8000264c:	03c0006f          	j	80002688 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002650:	00b5859b          	addiw	a1,a1,11
    80002654:	00100713          	li	a4,1
    80002658:	00b715bb          	sllw	a1,a4,a1
    8000265c:	00b505b3          	add	a1,a0,a1
    80002660:	00379693          	slli	a3,a5,0x3
    80002664:	00006717          	auipc	a4,0x6
    80002668:	5a470713          	addi	a4,a4,1444 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000266c:	00d70733          	add	a4,a4,a3
    80002670:	00b73823          	sd	a1,16(a4)
    80002674:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80002678:	0005b023          	sd	zero,0(a1)
    8000267c:	07873703          	ld	a4,120(a4)
    80002680:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002684:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80002688:	fff5879b          	addiw	a5,a1,-1
    8000268c:	04c7c863          	blt	a5,a2,800026dc <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80002690:	00379693          	slli	a3,a5,0x3
    80002694:	00006717          	auipc	a4,0x6
    80002698:	57470713          	addi	a4,a4,1396 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000269c:	00d70733          	add	a4,a4,a3
    800026a0:	01073683          	ld	a3,16(a4)
    800026a4:	fa0686e3          	beqz	a3,80002650 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800026a8:	00b5859b          	addiw	a1,a1,11
    800026ac:	00100713          	li	a4,1
    800026b0:	00b715bb          	sllw	a1,a4,a1
    800026b4:	00b505b3          	add	a1,a0,a1
    800026b8:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    800026bc:	00379693          	slli	a3,a5,0x3
    800026c0:	00006717          	auipc	a4,0x6
    800026c4:	54870713          	addi	a4,a4,1352 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026c8:	00d70733          	add	a4,a4,a3
    800026cc:	01073683          	ld	a3,16(a4)
    800026d0:	0006b683          	ld	a3,0(a3)
    800026d4:	00d73823          	sd	a3,16(a4)
    800026d8:	fadff06f          	j	80002684 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    800026dc:	00813403          	ld	s0,8(sp)
    800026e0:	01010113          	addi	sp,sp,16
    800026e4:	00008067          	ret

00000000800026e8 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    800026e8:	fe010113          	addi	sp,sp,-32
    800026ec:	00113c23          	sd	ra,24(sp)
    800026f0:	00813823          	sd	s0,16(sp)
    800026f4:	00913423          	sd	s1,8(sp)
    800026f8:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    800026fc:	00c00793          	li	a5,12
    80002700:	06a7ec63          	bltu	a5,a0,80002778 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002704:	00050593          	mv	a1,a0
    80002708:	00c00793          	li	a5,12
    8000270c:	06b7ea63          	bltu	a5,a1,80002780 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80002710:	00359713          	slli	a4,a1,0x3
    80002714:	00006797          	auipc	a5,0x6
    80002718:	4f478793          	addi	a5,a5,1268 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000271c:	00e787b3          	add	a5,a5,a4
    80002720:	0787b483          	ld	s1,120(a5)
    80002724:	00049663          	bnez	s1,80002730 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002728:	00158593          	addi	a1,a1,1
    8000272c:	fddff06f          	j	80002708 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80002730:	0004b703          	ld	a4,0(s1)
    80002734:	00359693          	slli	a3,a1,0x3
    80002738:	00006797          	auipc	a5,0x6
    8000273c:	4d078793          	addi	a5,a5,1232 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002740:	00d787b3          	add	a5,a5,a3
    80002744:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002748:	00070e63          	beqz	a4,80002764 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    8000274c:	0005061b          	sext.w	a2,a0
    80002750:	0005859b          	sext.w	a1,a1
    80002754:	00048513          	mv	a0,s1
    80002758:	00000097          	auipc	ra,0x0
    8000275c:	ee8080e7          	jalr	-280(ra) # 80002640 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80002760:	0240006f          	j	80002784 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002764:	00006797          	auipc	a5,0x6
    80002768:	4a478793          	addi	a5,a5,1188 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000276c:	00d787b3          	add	a5,a5,a3
    80002770:	0007b823          	sd	zero,16(a5)
    80002774:	fd9ff06f          	j	8000274c <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002778:	00000493          	li	s1,0
    8000277c:	0080006f          	j	80002784 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80002780:	00000493          	li	s1,0
}
    80002784:	00048513          	mv	a0,s1
    80002788:	01813083          	ld	ra,24(sp)
    8000278c:	01013403          	ld	s0,16(sp)
    80002790:	00813483          	ld	s1,8(sp)
    80002794:	02010113          	addi	sp,sp,32
    80002798:	00008067          	ret

000000008000279c <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    8000279c:	fe010113          	addi	sp,sp,-32
    800027a0:	00113c23          	sd	ra,24(sp)
    800027a4:	00813823          	sd	s0,16(sp)
    800027a8:	00913423          	sd	s1,8(sp)
    800027ac:	01213023          	sd	s2,0(sp)
    800027b0:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    800027b4:	00000913          	li	s2,0
    800027b8:	0180006f          	j	800027d0 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    800027bc:	00006517          	auipc	a0,0x6
    800027c0:	bd450513          	addi	a0,a0,-1068 # 80008390 <CONSOLE_STATUS+0x380>
    800027c4:	00002097          	auipc	ra,0x2
    800027c8:	670080e7          	jalr	1648(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800027cc:	0019091b          	addiw	s2,s2,1
    800027d0:	00c00793          	li	a5,12
    800027d4:	0727c663          	blt	a5,s2,80002840 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    800027d8:	00000613          	li	a2,0
    800027dc:	00a00593          	li	a1,10
    800027e0:	00090513          	mv	a0,s2
    800027e4:	00002097          	auipc	ra,0x2
    800027e8:	694080e7          	jalr	1684(ra) # 80004e78 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    800027ec:	00006517          	auipc	a0,0x6
    800027f0:	afc50513          	addi	a0,a0,-1284 # 800082e8 <CONSOLE_STATUS+0x2d8>
    800027f4:	00002097          	auipc	ra,0x2
    800027f8:	640080e7          	jalr	1600(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    800027fc:	00391713          	slli	a4,s2,0x3
    80002800:	00006797          	auipc	a5,0x6
    80002804:	40878793          	addi	a5,a5,1032 # 80008c08 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002808:	00e787b3          	add	a5,a5,a4
    8000280c:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002810:	fa0486e3          	beqz	s1,800027bc <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    80002814:	00000613          	li	a2,0
    80002818:	01000593          	li	a1,16
    8000281c:	0004851b          	sext.w	a0,s1
    80002820:	00002097          	auipc	ra,0x2
    80002824:	658080e7          	jalr	1624(ra) # 80004e78 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002828:	00006517          	auipc	a0,0x6
    8000282c:	8d050513          	addi	a0,a0,-1840 # 800080f8 <CONSOLE_STATUS+0xe8>
    80002830:	00002097          	auipc	ra,0x2
    80002834:	604080e7          	jalr	1540(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002838:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    8000283c:	fd5ff06f          	j	80002810 <_ZN5Buddy9printListEv+0x74>
    80002840:	01813083          	ld	ra,24(sp)
    80002844:	01013403          	ld	s0,16(sp)
    80002848:	00813483          	ld	s1,8(sp)
    8000284c:	00013903          	ld	s2,0(sp)
    80002850:	02010113          	addi	sp,sp,32
    80002854:	00008067          	ret

0000000080002858 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002858:	ff010113          	addi	sp,sp,-16
    8000285c:	00113423          	sd	ra,8(sp)
    80002860:	00813023          	sd	s0,0(sp)
    80002864:	01010413          	addi	s0,sp,16
    80002868:	000105b7          	lui	a1,0x10
    8000286c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002870:	00100513          	li	a0,1
    80002874:	00000097          	auipc	ra,0x0
    80002878:	a44080e7          	jalr	-1468(ra) # 800022b8 <_Z41__static_initialization_and_destruction_0ii>
    8000287c:	00813083          	ld	ra,8(sp)
    80002880:	00013403          	ld	s0,0(sp)
    80002884:	01010113          	addi	sp,sp,16
    80002888:	00008067          	ret

000000008000288c <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    8000288c:	ff010113          	addi	sp,sp,-16
    80002890:	00813423          	sd	s0,8(sp)
    80002894:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002898:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    8000289c:	00053823          	sd	zero,16(a0)
}
    800028a0:	00813403          	ld	s0,8(sp)
    800028a4:	01010113          	addi	sp,sp,16
    800028a8:	00008067          	ret

00000000800028ac <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    800028ac:	ff010113          	addi	sp,sp,-16
    800028b0:	00813423          	sd	s0,8(sp)
    800028b4:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    800028b8:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    800028bc:	00053823          	sd	zero,16(a0)
    800028c0:	00813403          	ld	s0,8(sp)
    800028c4:	01010113          	addi	sp,sp,16
    800028c8:	00008067          	ret

00000000800028cc <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    800028cc:	ff010113          	addi	sp,sp,-16
    800028d0:	00113423          	sd	ra,8(sp)
    800028d4:	00813023          	sd	s0,0(sp)
    800028d8:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    800028dc:	00000697          	auipc	a3,0x0
    800028e0:	fd068693          	addi	a3,a3,-48 # 800028ac <_ZN3SCB4dtorEPv>
    800028e4:	00000617          	auipc	a2,0x0
    800028e8:	fa860613          	addi	a2,a2,-88 # 8000288c <_ZN3SCB4ctorEPv>
    800028ec:	01800593          	li	a1,24
    800028f0:	00006517          	auipc	a0,0x6
    800028f4:	a0050513          	addi	a0,a0,-1536 # 800082f0 <CONSOLE_STATUS+0x2e0>
    800028f8:	00002097          	auipc	ra,0x2
    800028fc:	718080e7          	jalr	1816(ra) # 80005010 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002900:	00006797          	auipc	a5,0x6
    80002904:	3ea7b423          	sd	a0,1000(a5) # 80008ce8 <_ZN3SCB8scbCacheE>
}
    80002908:	00813083          	ld	ra,8(sp)
    8000290c:	00013403          	ld	s0,0(sp)
    80002910:	01010113          	addi	sp,sp,16
    80002914:	00008067          	ret

0000000080002918 <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    80002918:	ff010113          	addi	sp,sp,-16
    8000291c:	00813423          	sd	s0,8(sp)
    80002920:	01010413          	addi	s0,sp,16
    val = init;
    80002924:	00b52023          	sw	a1,0(a0)
}
    80002928:	00813403          	ld	s0,8(sp)
    8000292c:	01010113          	addi	sp,sp,16
    80002930:	00008067          	ret

0000000080002934 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80002934:	fe010113          	addi	sp,sp,-32
    80002938:	00113c23          	sd	ra,24(sp)
    8000293c:	00813823          	sd	s0,16(sp)
    80002940:	00913423          	sd	s1,8(sp)
    80002944:	01213023          	sd	s2,0(sp)
    80002948:	02010413          	addi	s0,sp,32
    8000294c:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002950:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002954:	02050063          	beqz	a0,80002974 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80002958:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    8000295c:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002960:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002964:	00002097          	auipc	ra,0x2
    80002968:	03c080e7          	jalr	60(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    8000296c:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002970:	fe5ff06f          	j	80002954 <_ZN3SCBD1Ev+0x20>
}
    80002974:	01813083          	ld	ra,24(sp)
    80002978:	01013403          	ld	s0,16(sp)
    8000297c:	00813483          	ld	s1,8(sp)
    80002980:	00013903          	ld	s2,0(sp)
    80002984:	02010113          	addi	sp,sp,32
    80002988:	00008067          	ret

000000008000298c <_ZN3SCB5blockEv>:
void SCB::block() {
    8000298c:	ff010113          	addi	sp,sp,-16
    80002990:	00113423          	sd	ra,8(sp)
    80002994:	00813023          	sd	s0,0(sp)
    80002998:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    8000299c:	00853783          	ld	a5,8(a0)
    800029a0:	04078063          	beqz	a5,800029e0 <_ZN3SCB5blockEv+0x54>
    800029a4:	01053703          	ld	a4,16(a0)
    800029a8:	00006797          	auipc	a5,0x6
    800029ac:	1687b783          	ld	a5,360(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800029b0:	0007b783          	ld	a5,0(a5)
    800029b4:	04f73423          	sd	a5,72(a4)
    800029b8:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    800029bc:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    800029c0:	00300713          	li	a4,3
    800029c4:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800029c8:	00000097          	auipc	ra,0x0
    800029cc:	314080e7          	jalr	788(ra) # 80002cdc <_ZN3TCB8dispatchEv>
}
    800029d0:	00813083          	ld	ra,8(sp)
    800029d4:	00013403          	ld	s0,0(sp)
    800029d8:	01010113          	addi	sp,sp,16
    800029dc:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800029e0:	00006797          	auipc	a5,0x6
    800029e4:	1307b783          	ld	a5,304(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800029e8:	0007b783          	ld	a5,0(a5)
    800029ec:	00f53423          	sd	a5,8(a0)
    800029f0:	fc9ff06f          	j	800029b8 <_ZN3SCB5blockEv+0x2c>

00000000800029f4 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    800029f4:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    800029f8:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    800029fc:	04853703          	ld	a4,72(a0)
    80002a00:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002a04:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002a08:	02050a63          	beqz	a0,80002a3c <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002a0c:	ff010113          	addi	sp,sp,-16
    80002a10:	00113423          	sd	ra,8(sp)
    80002a14:	00813023          	sd	s0,0(sp)
    80002a18:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002a1c:	00100793          	li	a5,1
    80002a20:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002a24:	00002097          	auipc	ra,0x2
    80002a28:	f7c080e7          	jalr	-132(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>
}
    80002a2c:	00813083          	ld	ra,8(sp)
    80002a30:	00013403          	ld	s0,0(sp)
    80002a34:	01010113          	addi	sp,sp,16
    80002a38:	00008067          	ret
    80002a3c:	00008067          	ret

0000000080002a40 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80002a40:	00006797          	auipc	a5,0x6
    80002a44:	0d07b783          	ld	a5,208(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002a48:	0007b783          	ld	a5,0(a5)
    80002a4c:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002a50:	00052783          	lw	a5,0(a0)
    80002a54:	fff7879b          	addiw	a5,a5,-1
    80002a58:	00f52023          	sw	a5,0(a0)
    80002a5c:	02079713          	slli	a4,a5,0x20
    80002a60:	00074463          	bltz	a4,80002a68 <_ZN3SCB4waitEv+0x28>
    80002a64:	00008067          	ret
void SCB::wait() {
    80002a68:	ff010113          	addi	sp,sp,-16
    80002a6c:	00113423          	sd	ra,8(sp)
    80002a70:	00813023          	sd	s0,0(sp)
    80002a74:	01010413          	addi	s0,sp,16
        block();
    80002a78:	00000097          	auipc	ra,0x0
    80002a7c:	f14080e7          	jalr	-236(ra) # 8000298c <_ZN3SCB5blockEv>
}
    80002a80:	00813083          	ld	ra,8(sp)
    80002a84:	00013403          	ld	s0,0(sp)
    80002a88:	01010113          	addi	sp,sp,16
    80002a8c:	00008067          	ret

0000000080002a90 <_ZN3SCB6signalEv>:
    if(val++<0)
    80002a90:	00052783          	lw	a5,0(a0)
    80002a94:	0017871b          	addiw	a4,a5,1
    80002a98:	00e52023          	sw	a4,0(a0)
    80002a9c:	0007c463          	bltz	a5,80002aa4 <_ZN3SCB6signalEv+0x14>
    80002aa0:	00008067          	ret
void SCB::signal(){
    80002aa4:	ff010113          	addi	sp,sp,-16
    80002aa8:	00113423          	sd	ra,8(sp)
    80002aac:	00813023          	sd	s0,0(sp)
    80002ab0:	01010413          	addi	s0,sp,16
        deblock();
    80002ab4:	00000097          	auipc	ra,0x0
    80002ab8:	f40080e7          	jalr	-192(ra) # 800029f4 <_ZN3SCB7deblockEv>
}
    80002abc:	00813083          	ld	ra,8(sp)
    80002ac0:	00013403          	ld	s0,0(sp)
    80002ac4:	01010113          	addi	sp,sp,16
    80002ac8:	00008067          	ret

0000000080002acc <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    80002acc:	ff010113          	addi	sp,sp,-16
    80002ad0:	00113423          	sd	ra,8(sp)
    80002ad4:	00813023          	sd	s0,0(sp)
    80002ad8:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    80002adc:	00006517          	auipc	a0,0x6
    80002ae0:	20c53503          	ld	a0,524(a0) # 80008ce8 <_ZN3SCB8scbCacheE>
    80002ae4:	00002097          	auipc	ra,0x2
    80002ae8:	554080e7          	jalr	1364(ra) # 80005038 <_Z16kmem_cache_allocP5Cache>
}
    80002aec:	00813083          	ld	ra,8(sp)
    80002af0:	00013403          	ld	s0,0(sp)
    80002af4:	01010113          	addi	sp,sp,16
    80002af8:	00008067          	ret

0000000080002afc <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    80002afc:	ff010113          	addi	sp,sp,-16
    80002b00:	00113423          	sd	ra,8(sp)
    80002b04:	00813023          	sd	s0,0(sp)
    80002b08:	01010413          	addi	s0,sp,16
    80002b0c:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80002b10:	00006517          	auipc	a0,0x6
    80002b14:	1d853503          	ld	a0,472(a0) # 80008ce8 <_ZN3SCB8scbCacheE>
    80002b18:	00002097          	auipc	ra,0x2
    80002b1c:	548080e7          	jalr	1352(ra) # 80005060 <_Z15kmem_cache_freeP5CachePv>
}
    80002b20:	00813083          	ld	ra,8(sp)
    80002b24:	00013403          	ld	s0,0(sp)
    80002b28:	01010113          	addi	sp,sp,16
    80002b2c:	00008067          	ret

0000000080002b30 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80002b30:	ff010113          	addi	sp,sp,-16
    80002b34:	00813423          	sd	s0,8(sp)
    80002b38:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002b3c:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002b40:	05200513          	li	a0,82
    asm("ecall");
    80002b44:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002b48:	00050513          	mv	a0,a0
}
    80002b4c:	0005051b          	sext.w	a0,a0
    80002b50:	00813403          	ld	s0,8(sp)
    80002b54:	01010113          	addi	sp,sp,16
    80002b58:	00008067          	ret

0000000080002b5c <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/system.hpp"

int main() {
    80002b5c:	fe010113          	addi	sp,sp,-32
    80002b60:	00113c23          	sd	ra,24(sp)
    80002b64:	00813823          	sd	s0,16(sp)
    80002b68:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002b6c:	fe840513          	addi	a0,s0,-24
    80002b70:	fffff097          	auipc	ra,0xfffff
    80002b74:	638080e7          	jalr	1592(ra) # 800021a8 <_ZN6SystemC1Ev>

    return 0;
    80002b78:	00000513          	li	a0,0
    80002b7c:	01813083          	ld	ra,24(sp)
    80002b80:	01013403          	ld	s0,16(sp)
    80002b84:	02010113          	addi	sp,sp,32
    80002b88:	00008067          	ret

0000000080002b8c <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80002b8c:	ff010113          	addi	sp,sp,-16
    80002b90:	00813423          	sd	s0,8(sp)
    80002b94:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002b98:	00100793          	li	a5,1
    80002b9c:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002ba0:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002ba4:	00052a23          	sw	zero,20(a0)
}
    80002ba8:	00813403          	ld	s0,8(sp)
    80002bac:	01010113          	addi	sp,sp,16
    80002bb0:	00008067          	ret

0000000080002bb4 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80002bb4:	ff010113          	addi	sp,sp,-16
    80002bb8:	00813423          	sd	s0,8(sp)
    80002bbc:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002bc0:	00100793          	li	a5,1
    80002bc4:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002bc8:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002bcc:	00052a23          	sw	zero,20(a0)
    80002bd0:	00813403          	ld	s0,8(sp)
    80002bd4:	01010113          	addi	sp,sp,16
    80002bd8:	00008067          	ret

0000000080002bdc <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80002bdc:	ff010113          	addi	sp,sp,-16
    80002be0:	00113423          	sd	ra,8(sp)
    80002be4:	00813023          	sd	s0,0(sp)
    80002be8:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002bec:	00000097          	auipc	ra,0x0
    80002bf0:	7a0080e7          	jalr	1952(ra) # 8000338c <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    80002bf4:	00006797          	auipc	a5,0x6
    80002bf8:	0fc7b783          	ld	a5,252(a5) # 80008cf0 <_ZN3TCB7runningE>
    80002bfc:	0187b703          	ld	a4,24(a5)
    80002c00:	0207b503          	ld	a0,32(a5)
    80002c04:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    80002c08:	00001097          	auipc	ra,0x1
    80002c0c:	6ac080e7          	jalr	1708(ra) # 800042b4 <_ZN5RiscV14threadExitUtilEv>
}
    80002c10:	00813083          	ld	ra,8(sp)
    80002c14:	00013403          	ld	s0,0(sp)
    80002c18:	01010113          	addi	sp,sp,16
    80002c1c:	00008067          	ret

0000000080002c20 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002c20:	ff010113          	addi	sp,sp,-16
    80002c24:	00813423          	sd	s0,8(sp)
    80002c28:	01010413          	addi	s0,sp,16
    80002c2c:	04053823          	sd	zero,80(a0)
    80002c30:	04053c23          	sd	zero,88(a0)
    80002c34:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002c38:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002c3c:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002c40:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002c44:	02058a63          	beqz	a1,80002c78 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80002c48:	00068793          	mv	a5,a3
    80002c4c:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002c50:	02058863          	beqz	a1,80002c80 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80002c54:	000017b7          	lui	a5,0x1
    80002c58:	00f686b3          	add	a3,a3,a5
    80002c5c:	00d53023          	sd	a3,0(a0)
    80002c60:	00000797          	auipc	a5,0x0
    80002c64:	f7c78793          	addi	a5,a5,-132 # 80002bdc <_ZN3TCB7wrapperEPv>
    80002c68:	00f53423          	sd	a5,8(a0)
}
    80002c6c:	00813403          	ld	s0,8(sp)
    80002c70:	01010113          	addi	sp,sp,16
    80002c74:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002c78:	00000793          	li	a5,0
    80002c7c:	fd1ff06f          	j	80002c4c <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002c80:	00000693          	li	a3,0
    80002c84:	fd9ff06f          	j	80002c5c <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080002c88 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002c88:	ff010113          	addi	sp,sp,-16
    80002c8c:	00113423          	sd	ra,8(sp)
    80002c90:	00813023          	sd	s0,0(sp)
    80002c94:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002c98:	02853503          	ld	a0,40(a0)
    80002c9c:	00002097          	auipc	ra,0x2
    80002ca0:	494080e7          	jalr	1172(ra) # 80005130 <_Z5kfreePKv>
}
    80002ca4:	00813083          	ld	ra,8(sp)
    80002ca8:	00013403          	ld	s0,0(sp)
    80002cac:	01010113          	addi	sp,sp,16
    80002cb0:	00008067          	ret

0000000080002cb4 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002cb4:	ff010113          	addi	sp,sp,-16
    80002cb8:	00113423          	sd	ra,8(sp)
    80002cbc:	00813023          	sd	s0,0(sp)
    80002cc0:	01010413          	addi	s0,sp,16
    free();
    80002cc4:	00000097          	auipc	ra,0x0
    80002cc8:	fc4080e7          	jalr	-60(ra) # 80002c88 <_ZN3TCB4freeEv>
}
    80002ccc:	00813083          	ld	ra,8(sp)
    80002cd0:	00013403          	ld	s0,0(sp)
    80002cd4:	01010113          	addi	sp,sp,16
    80002cd8:	00008067          	ret

0000000080002cdc <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002cdc:	fe010113          	addi	sp,sp,-32
    80002ce0:	00113c23          	sd	ra,24(sp)
    80002ce4:	00813823          	sd	s0,16(sp)
    80002ce8:	00913423          	sd	s1,8(sp)
    80002cec:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002cf0:	00006497          	auipc	s1,0x6
    80002cf4:	0004b483          	ld	s1,0(s1) # 80008cf0 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002cf8:	0104a703          	lw	a4,16(s1)
    80002cfc:	00100793          	li	a5,1
    80002d00:	04e7f663          	bgeu	a5,a4,80002d4c <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002d04:	00002097          	auipc	ra,0x2
    80002d08:	ce4080e7          	jalr	-796(ra) # 800049e8 <_ZN9Scheduler3getEv>
    80002d0c:	00006797          	auipc	a5,0x6
    80002d10:	fea7b223          	sd	a0,-28(a5) # 80008cf0 <_ZN3TCB7runningE>
    if(running) {
    80002d14:	02050263          	beqz	a0,80002d38 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002d18:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002d1c:	00000097          	auipc	ra,0x0
    80002d20:	754080e7          	jalr	1876(ra) # 80003470 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002d24:	00006597          	auipc	a1,0x6
    80002d28:	fcc5b583          	ld	a1,-52(a1) # 80008cf0 <_ZN3TCB7runningE>
    80002d2c:	00048513          	mv	a0,s1
    80002d30:	ffffe097          	auipc	ra,0xffffe
    80002d34:	3f0080e7          	jalr	1008(ra) # 80001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002d38:	01813083          	ld	ra,24(sp)
    80002d3c:	01013403          	ld	s0,16(sp)
    80002d40:	00813483          	ld	s1,8(sp)
    80002d44:	02010113          	addi	sp,sp,32
    80002d48:	00008067          	ret
        Scheduler::put(old);
    80002d4c:	00048513          	mv	a0,s1
    80002d50:	00002097          	auipc	ra,0x2
    80002d54:	c50080e7          	jalr	-944(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>
    80002d58:	fadff06f          	j	80002d04 <_ZN3TCB8dispatchEv+0x28>

0000000080002d5c <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002d5c:	ff010113          	addi	sp,sp,-16
    80002d60:	00113423          	sd	ra,8(sp)
    80002d64:	00813023          	sd	s0,0(sp)
    80002d68:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002d6c:	00006517          	auipc	a0,0x6
    80002d70:	f8c53503          	ld	a0,-116(a0) # 80008cf8 <_ZN3TCB8tcbCacheE>
    80002d74:	00002097          	auipc	ra,0x2
    80002d78:	2c4080e7          	jalr	708(ra) # 80005038 <_Z16kmem_cache_allocP5Cache>
}
    80002d7c:	00813083          	ld	ra,8(sp)
    80002d80:	00013403          	ld	s0,0(sp)
    80002d84:	01010113          	addi	sp,sp,16
    80002d88:	00008067          	ret

0000000080002d8c <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002d8c:	fe010113          	addi	sp,sp,-32
    80002d90:	00113c23          	sd	ra,24(sp)
    80002d94:	00813823          	sd	s0,16(sp)
    80002d98:	00913423          	sd	s1,8(sp)
    80002d9c:	01213023          	sd	s2,0(sp)
    80002da0:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    80002da4:	00000697          	auipc	a3,0x0
    80002da8:	e1068693          	addi	a3,a3,-496 # 80002bb4 <_ZN3TCB4dtorEPv>
    80002dac:	00000617          	auipc	a2,0x0
    80002db0:	de060613          	addi	a2,a2,-544 # 80002b8c <_ZN3TCB4ctorEPv>
    80002db4:	07000593          	li	a1,112
    80002db8:	00005517          	auipc	a0,0x5
    80002dbc:	54850513          	addi	a0,a0,1352 # 80008300 <CONSOLE_STATUS+0x2f0>
    80002dc0:	00002097          	auipc	ra,0x2
    80002dc4:	250080e7          	jalr	592(ra) # 80005010 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002dc8:	00006797          	auipc	a5,0x6
    80002dcc:	f2a7b823          	sd	a0,-208(a5) # 80008cf8 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002dd0:	07000513          	li	a0,112
    80002dd4:	00000097          	auipc	ra,0x0
    80002dd8:	f88080e7          	jalr	-120(ra) # 80002d5c <_ZN3TCBnwEm>
    80002ddc:	00050493          	mv	s1,a0
    80002de0:	00050e63          	beqz	a0,80002dfc <_ZN3TCB10initializeEv+0x70>
    80002de4:	00200713          	li	a4,2
    80002de8:	00000693          	li	a3,0
    80002dec:	00000613          	li	a2,0
    80002df0:	00000593          	li	a1,0
    80002df4:	00000097          	auipc	ra,0x0
    80002df8:	e2c080e7          	jalr	-468(ra) # 80002c20 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002dfc:	00006797          	auipc	a5,0x6
    80002e00:	ee97ba23          	sd	s1,-268(a5) # 80008cf0 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    80002e04:	00100793          	li	a5,1
    80002e08:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80002e0c:	04000513          	li	a0,64
    80002e10:	00000097          	auipc	ra,0x0
    80002e14:	150080e7          	jalr	336(ra) # 80002f60 <_ZN15MemoryAllocator7kmallocEm>
    80002e18:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002e1c:	07000513          	li	a0,112
    80002e20:	00000097          	auipc	ra,0x0
    80002e24:	f3c080e7          	jalr	-196(ra) # 80002d5c <_ZN3TCBnwEm>
    80002e28:	00050493          	mv	s1,a0
    80002e2c:	02050063          	beqz	a0,80002e4c <_ZN3TCB10initializeEv+0xc0>
    80002e30:	00200713          	li	a4,2
    80002e34:	00090693          	mv	a3,s2
    80002e38:	00000613          	li	a2,0
    80002e3c:	00006597          	auipc	a1,0x6
    80002e40:	c5c5b583          	ld	a1,-932(a1) # 80008a98 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002e44:	00000097          	auipc	ra,0x0
    80002e48:	ddc080e7          	jalr	-548(ra) # 80002c20 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002e4c:	00006797          	auipc	a5,0x6
    80002e50:	ea97ba23          	sd	s1,-332(a5) # 80008d00 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    80002e54:	00100793          	li	a5,1
    80002e58:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    80002e5c:	00048513          	mv	a0,s1
    80002e60:	00002097          	auipc	ra,0x2
    80002e64:	b40080e7          	jalr	-1216(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>
}
    80002e68:	01813083          	ld	ra,24(sp)
    80002e6c:	01013403          	ld	s0,16(sp)
    80002e70:	00813483          	ld	s1,8(sp)
    80002e74:	00013903          	ld	s2,0(sp)
    80002e78:	02010113          	addi	sp,sp,32
    80002e7c:	00008067          	ret

0000000080002e80 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    80002e80:	ff010113          	addi	sp,sp,-16
    80002e84:	00113423          	sd	ra,8(sp)
    80002e88:	00813023          	sd	s0,0(sp)
    80002e8c:	01010413          	addi	s0,sp,16
    80002e90:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    80002e94:	00006517          	auipc	a0,0x6
    80002e98:	e6453503          	ld	a0,-412(a0) # 80008cf8 <_ZN3TCB8tcbCacheE>
    80002e9c:	00002097          	auipc	ra,0x2
    80002ea0:	1c4080e7          	jalr	452(ra) # 80005060 <_Z15kmem_cache_freeP5CachePv>
}
    80002ea4:	00813083          	ld	ra,8(sp)
    80002ea8:	00013403          	ld	s0,0(sp)
    80002eac:	01010113          	addi	sp,sp,16
    80002eb0:	00008067          	ret

0000000080002eb4 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    80002eb4:	ff010113          	addi	sp,sp,-16
    80002eb8:	00813423          	sd	s0,8(sp)
    80002ebc:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80002ec0:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80002ec4:	05100513          	li	a0,81
    asm("ecall");
    80002ec8:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002ecc:	00050513          	mv	a0,a0
}
    80002ed0:	0005051b          	sext.w	a0,a0
    80002ed4:	00813403          	ld	s0,8(sp)
    80002ed8:	01010113          	addi	sp,sp,16
    80002edc:	00008067          	ret

0000000080002ee0 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80002ee0:	ff010113          	addi	sp,sp,-16
    80002ee4:	00813423          	sd	s0,8(sp)
    80002ee8:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002eec:	00006797          	auipc	a5,0x6
    80002ef0:	b847b783          	ld	a5,-1148(a5) # 80008a70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002ef4:	0007b783          	ld	a5,0(a5)
    80002ef8:	00c7d793          	srli	a5,a5,0xc
    80002efc:	00278793          	addi	a5,a5,2
    80002f00:	00c79793          	slli	a5,a5,0xc
    80002f04:	01000737          	lui	a4,0x1000
    80002f08:	00e787b3          	add	a5,a5,a4
    80002f0c:	00006717          	auipc	a4,0x6
    80002f10:	e1470713          	addi	a4,a4,-492 # 80008d20 <_ZN15MemoryAllocator11freeMemTailE>
    80002f14:	00f73023          	sd	a5,0(a4)
    80002f18:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002f1c:	0007b823          	sd	zero,16(a5)
    80002f20:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80002f24:	00073823          	sd	zero,16(a4)
    80002f28:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    80002f2c:	00006697          	auipc	a3,0x6
    80002f30:	bfc6b683          	ld	a3,-1028(a3) # 80008b28 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80002f34:	0006b683          	ld	a3,0(a3)
    80002f38:	40f686b3          	sub	a3,a3,a5
    80002f3c:	fe868693          	addi	a3,a3,-24
    80002f40:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80002f44:	00873783          	ld	a5,8(a4)
    80002f48:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80002f4c:	00100793          	li	a5,1
    80002f50:	02f70023          	sb	a5,32(a4)
}
    80002f54:	00813403          	ld	s0,8(sp)
    80002f58:	01010113          	addi	sp,sp,16
    80002f5c:	00008067          	ret

0000000080002f60 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002f60:	ff010113          	addi	sp,sp,-16
    80002f64:	00813423          	sd	s0,8(sp)
    80002f68:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    80002f6c:	14050663          	beqz	a0,800030b8 <_ZN15MemoryAllocator7kmallocEm+0x158>
    80002f70:	00050793          	mv	a5,a0
    80002f74:	00006517          	auipc	a0,0x6
    80002f78:	db453503          	ld	a0,-588(a0) # 80008d28 <_ZN15MemoryAllocator11freeMemHeadE>
    80002f7c:	0a050e63          	beqz	a0,80003038 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80002f80:	00053703          	ld	a4,0(a0)
    80002f84:	12f76e63          	bltu	a4,a5,800030c0 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002f88:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80002f8c:	00000613          	li	a2,0
    80002f90:	00c0006f          	j	80002f9c <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80002f94:	00050613          	mv	a2,a0
    80002f98:	01053503          	ld	a0,16(a0)
    80002f9c:	00050863          	beqz	a0,80002fac <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002fa0:	00053683          	ld	a3,0(a0)
    80002fa4:	01878713          	addi	a4,a5,24
    80002fa8:	fee6e6e3          	bltu	a3,a4,80002f94 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002fac:	08050663          	beqz	a0,80003038 <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    80002fb0:	00053683          	ld	a3,0(a0)
    80002fb4:	01868713          	addi	a4,a3,24
    80002fb8:	00e50733          	add	a4,a0,a4
    80002fbc:	00006597          	auipc	a1,0x6
    80002fc0:	b6c5b583          	ld	a1,-1172(a1) # 80008b28 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80002fc4:	0005b583          	ld	a1,0(a1)
    80002fc8:	00b76463          	bltu	a4,a1,80002fd0 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80002fcc:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002fd0:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002fd4:	05700593          	li	a1,87
    80002fd8:	08d5f063          	bgeu	a1,a3,80003058 <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    80002fdc:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002fe0:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002fe4:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80002fe8:	01053583          	ld	a1,16(a0)
    80002fec:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002ff0:	00853583          	ld	a1,8(a0)
    80002ff4:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80002ff8:	fe868693          	addi	a3,a3,-24
    80002ffc:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80003000:	04060263          	beqz	a2,80003044 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80003004:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80003008:	00006797          	auipc	a5,0x6
    8000300c:	d307b783          	ld	a5,-720(a5) # 80008d38 <_ZN15MemoryAllocator12allocMemHeadE>
    80003010:	06078463          	beqz	a5,80003078 <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80003014:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80003018:	08070063          	beqz	a4,80003098 <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    8000301c:	00873783          	ld	a5,8(a4)
    80003020:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80003024:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80003028:	00873783          	ld	a5,8(a4)
    8000302c:	06078063          	beqz	a5,8000308c <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    80003030:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80003034:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80003038:	00813403          	ld	s0,8(sp)
    8000303c:	01010113          	addi	sp,sp,16
    80003040:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80003044:	00006697          	auipc	a3,0x6
    80003048:	cdc68693          	addi	a3,a3,-804 # 80008d20 <_ZN15MemoryAllocator11freeMemTailE>
    8000304c:	00f6b023          	sd	a5,0(a3)
    80003050:	00f6b423          	sd	a5,8(a3)
    80003054:	fb5ff06f          	j	80003008 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    80003058:	00060863          	beqz	a2,80003068 <_ZN15MemoryAllocator7kmallocEm+0x108>
    8000305c:	01053783          	ld	a5,16(a0)
    80003060:	00f63823          	sd	a5,16(a2)
    80003064:	fa5ff06f          	j	80003008 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    80003068:	01053783          	ld	a5,16(a0)
    8000306c:	00006697          	auipc	a3,0x6
    80003070:	caf6be23          	sd	a5,-836(a3) # 80008d28 <_ZN15MemoryAllocator11freeMemHeadE>
    80003074:	f95ff06f          	j	80003008 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    80003078:	00006797          	auipc	a5,0x6
    8000307c:	ca878793          	addi	a5,a5,-856 # 80008d20 <_ZN15MemoryAllocator11freeMemTailE>
    80003080:	00a7b823          	sd	a0,16(a5)
    80003084:	00a7bc23          	sd	a0,24(a5)
    80003088:	fadff06f          	j	80003034 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    8000308c:	00006797          	auipc	a5,0x6
    80003090:	caa7b623          	sd	a0,-852(a5) # 80008d38 <_ZN15MemoryAllocator12allocMemHeadE>
    80003094:	fa1ff06f          	j	80003034 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    80003098:	00006797          	auipc	a5,0x6
    8000309c:	c8878793          	addi	a5,a5,-888 # 80008d20 <_ZN15MemoryAllocator11freeMemTailE>
    800030a0:	0107b703          	ld	a4,16(a5)
    800030a4:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    800030a8:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    800030ac:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    800030b0:	00a7b823          	sd	a0,16(a5)
    800030b4:	f81ff06f          	j	80003034 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    800030b8:	00000513          	li	a0,0
    800030bc:	f7dff06f          	j	80003038 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    800030c0:	00000513          	li	a0,0
    800030c4:	f75ff06f          	j	80003038 <_ZN15MemoryAllocator7kmallocEm+0xd8>

00000000800030c8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    800030c8:	ff010113          	addi	sp,sp,-16
    800030cc:	00813423          	sd	s0,8(sp)
    800030d0:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    800030d4:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800030d8:	00000713          	li	a4,0
    800030dc:	00078a63          	beqz	a5,800030f0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    800030e0:	00a7f863          	bgeu	a5,a0,800030f0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800030e4:	00078713          	mv	a4,a5
    800030e8:	0107b783          	ld	a5,16(a5)
    800030ec:	ff1ff06f          	j	800030dc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    800030f0:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    800030f4:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    800030f8:	00078463          	beqz	a5,80003100 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    800030fc:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80003100:	02070263          	beqz	a4,80003124 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003104:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80003108:	0005b703          	ld	a4,0(a1)
    8000310c:	00006797          	auipc	a5,0x6
    80003110:	c1c7b783          	ld	a5,-996(a5) # 80008d28 <_ZN15MemoryAllocator11freeMemHeadE>
    80003114:	00f70c63          	beq	a4,a5,8000312c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80003118:	00813403          	ld	s0,8(sp)
    8000311c:	01010113          	addi	sp,sp,16
    80003120:	00008067          	ret
        *head = blk;
    80003124:	00a5b023          	sd	a0,0(a1)
    80003128:	fe1ff06f          	j	80003108 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    8000312c:	01053783          	ld	a5,16(a0)
    80003130:	00078a63          	beqz	a5,80003144 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80003134:	00053683          	ld	a3,0(a0)
    80003138:	00d50733          	add	a4,a0,a3
    8000313c:	01870713          	addi	a4,a4,24
    80003140:	02f70e63          	beq	a4,a5,8000317c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80003144:	00853783          	ld	a5,8(a0)
    80003148:	fc0788e3          	beqz	a5,80003118 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    8000314c:	0007b683          	ld	a3,0(a5)
    80003150:	00d78733          	add	a4,a5,a3
    80003154:	01870713          	addi	a4,a4,24
    80003158:	fca710e3          	bne	a4,a0,80003118 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    8000315c:	00053703          	ld	a4,0(a0)
    80003160:	00e68733          	add	a4,a3,a4
    80003164:	01870713          	addi	a4,a4,24
    80003168:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    8000316c:	00853783          	ld	a5,8(a0)
    80003170:	01053703          	ld	a4,16(a0)
    80003174:	00e7b823          	sd	a4,16(a5)
}
    80003178:	fa1ff06f          	j	80003118 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    8000317c:	0007b703          	ld	a4,0(a5)
    80003180:	00e68733          	add	a4,a3,a4
    80003184:	01870713          	addi	a4,a4,24
    80003188:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    8000318c:	0107b783          	ld	a5,16(a5)
    80003190:	00f53823          	sd	a5,16(a0)
    80003194:	fb1ff06f          	j	80003144 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080003198 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80003198:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    8000319c:	00006697          	auipc	a3,0x6
    800031a0:	b9c6b683          	ld	a3,-1124(a3) # 80008d38 <_ZN15MemoryAllocator12allocMemHeadE>
    800031a4:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    800031a8:	00050a63          	beqz	a0,800031bc <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    800031ac:	fe870793          	addi	a5,a4,-24
    800031b0:	00a78663          	beq	a5,a0,800031bc <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    800031b4:	01053503          	ld	a0,16(a0)
    800031b8:	ff1ff06f          	j	800031a8 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    800031bc:	08050463          	beqz	a0,80003244 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    800031c0:	ff010113          	addi	sp,sp,-16
    800031c4:	00113423          	sd	ra,8(sp)
    800031c8:	00813023          	sd	s0,0(sp)
    800031cc:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    800031d0:	00006797          	auipc	a5,0x6
    800031d4:	b607b783          	ld	a5,-1184(a5) # 80008d30 <_ZN15MemoryAllocator12allocMemTailE>
    800031d8:	04a78663          	beq	a5,a0,80003224 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    800031dc:	04d50c63          	beq	a0,a3,80003234 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    800031e0:	01053783          	ld	a5,16(a0)
    800031e4:	00078663          	beqz	a5,800031f0 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    800031e8:	00853703          	ld	a4,8(a0)
    800031ec:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    800031f0:	00853783          	ld	a5,8(a0)
    800031f4:	00078663          	beqz	a5,80003200 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    800031f8:	01053703          	ld	a4,16(a0)
    800031fc:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80003200:	00006597          	auipc	a1,0x6
    80003204:	b2858593          	addi	a1,a1,-1240 # 80008d28 <_ZN15MemoryAllocator11freeMemHeadE>
    80003208:	00000097          	auipc	ra,0x0
    8000320c:	ec0080e7          	jalr	-320(ra) # 800030c8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80003210:	00000513          	li	a0,0
}
    80003214:	00813083          	ld	ra,8(sp)
    80003218:	00013403          	ld	s0,0(sp)
    8000321c:	01010113          	addi	sp,sp,16
    80003220:	00008067          	ret
            allocMemTail = blk->prev;
    80003224:	00853783          	ld	a5,8(a0)
    80003228:	00006717          	auipc	a4,0x6
    8000322c:	b0f73423          	sd	a5,-1272(a4) # 80008d30 <_ZN15MemoryAllocator12allocMemTailE>
    80003230:	fadff06f          	j	800031dc <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80003234:	01053783          	ld	a5,16(a0)
    80003238:	00006717          	auipc	a4,0x6
    8000323c:	b0f73023          	sd	a5,-1280(a4) # 80008d38 <_ZN15MemoryAllocator12allocMemHeadE>
    80003240:	fa1ff06f          	j	800031e0 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80003244:	fff00513          	li	a0,-1
}
    80003248:	00008067          	ret

000000008000324c <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    8000324c:	fe010113          	addi	sp,sp,-32
    80003250:	00113c23          	sd	ra,24(sp)
    80003254:	00813823          	sd	s0,16(sp)
    80003258:	00913423          	sd	s1,8(sp)
    8000325c:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80003260:	00006497          	auipc	s1,0x6
    80003264:	ad84b483          	ld	s1,-1320(s1) # 80008d38 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80003268:	00005517          	auipc	a0,0x5
    8000326c:	0a850513          	addi	a0,a0,168 # 80008310 <CONSOLE_STATUS+0x300>
    80003270:	0000e097          	auipc	ra,0xe
    80003274:	224080e7          	jalr	548(ra) # 80011494 <_Z11printStringPKc>
    while(iter!=nullptr){
    80003278:	04048663          	beqz	s1,800032c4 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    8000327c:	00000613          	li	a2,0
    80003280:	00a00593          	li	a1,10
    80003284:	0004851b          	sext.w	a0,s1
    80003288:	0000e097          	auipc	ra,0xe
    8000328c:	3a4080e7          	jalr	932(ra) # 8001162c <_Z8printIntiii>
        putc(' ');
    80003290:	02000513          	li	a0,32
    80003294:	0000d097          	auipc	ra,0xd
    80003298:	098080e7          	jalr	152(ra) # 8001032c <_Z4putcc>
        printInt(iter->size);
    8000329c:	00000613          	li	a2,0
    800032a0:	00a00593          	li	a1,10
    800032a4:	0004a503          	lw	a0,0(s1)
    800032a8:	0000e097          	auipc	ra,0xe
    800032ac:	384080e7          	jalr	900(ra) # 8001162c <_Z8printIntiii>
        putc('\n');
    800032b0:	00a00513          	li	a0,10
    800032b4:	0000d097          	auipc	ra,0xd
    800032b8:	078080e7          	jalr	120(ra) # 8001032c <_Z4putcc>
        iter=iter->next;
    800032bc:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800032c0:	fb9ff06f          	j	80003278 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    800032c4:	00005517          	auipc	a0,0x5
    800032c8:	06c50513          	addi	a0,a0,108 # 80008330 <CONSOLE_STATUS+0x320>
    800032cc:	0000e097          	auipc	ra,0xe
    800032d0:	1c8080e7          	jalr	456(ra) # 80011494 <_Z11printStringPKc>
    iter = freeMemHead;
    800032d4:	00006497          	auipc	s1,0x6
    800032d8:	a544b483          	ld	s1,-1452(s1) # 80008d28 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    800032dc:	04048663          	beqz	s1,80003328 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    800032e0:	00000613          	li	a2,0
    800032e4:	00a00593          	li	a1,10
    800032e8:	0004851b          	sext.w	a0,s1
    800032ec:	0000e097          	auipc	ra,0xe
    800032f0:	340080e7          	jalr	832(ra) # 8001162c <_Z8printIntiii>
        putc(' ');
    800032f4:	02000513          	li	a0,32
    800032f8:	0000d097          	auipc	ra,0xd
    800032fc:	034080e7          	jalr	52(ra) # 8001032c <_Z4putcc>
        printInt(iter->size);
    80003300:	00000613          	li	a2,0
    80003304:	00a00593          	li	a1,10
    80003308:	0004a503          	lw	a0,0(s1)
    8000330c:	0000e097          	auipc	ra,0xe
    80003310:	320080e7          	jalr	800(ra) # 8001162c <_Z8printIntiii>
        putc('\n');
    80003314:	00a00513          	li	a0,10
    80003318:	0000d097          	auipc	ra,0xd
    8000331c:	014080e7          	jalr	20(ra) # 8001032c <_Z4putcc>
        iter=iter->next;
    80003320:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003324:	fb9ff06f          	j	800032dc <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80003328:	00005517          	auipc	a0,0x5
    8000332c:	02850513          	addi	a0,a0,40 # 80008350 <CONSOLE_STATUS+0x340>
    80003330:	0000e097          	auipc	ra,0xe
    80003334:	164080e7          	jalr	356(ra) # 80011494 <_Z11printStringPKc>
}
    80003338:	01813083          	ld	ra,24(sp)
    8000333c:	01013403          	ld	s0,16(sp)
    80003340:	00813483          	ld	s1,8(sp)
    80003344:	02010113          	addi	sp,sp,32
    80003348:	00008067          	ret

000000008000334c <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    8000334c:	ff010113          	addi	sp,sp,-16
    80003350:	00813423          	sd	s0,8(sp)
    80003354:	01010413          	addi	s0,sp,16
    80003358:	00050813          	mv	a6,a0
    8000335c:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80003360:	00000793          	li	a5,0
    80003364:	00c7fe63          	bgeu	a5,a2,80003380 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80003368:	00f50733          	add	a4,a0,a5
    8000336c:	00f806b3          	add	a3,a6,a5
    80003370:	0006c683          	lbu	a3,0(a3)
    80003374:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80003378:	00178793          	addi	a5,a5,1
    8000337c:	fe9ff06f          	j	80003364 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80003380:	00813403          	ld	s0,8(sp)
    80003384:	01010113          	addi	sp,sp,16
    80003388:	00008067          	ret

000000008000338c <_ZN5RiscV10popSppSpieEv>:
    RiscV::startVirtualMemory(RiscV::kPMT);
    RiscV::enableInterrupts();
}

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    8000338c:	ff010113          	addi	sp,sp,-16
    80003390:	00813423          	sd	s0,8(sp)
    80003394:	01010413          	addi	s0,sp,16
    uint64 ra = 0;
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80003398:	00005797          	auipc	a5,0x5
    8000339c:	7787b783          	ld	a5,1912(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800033a0:	0007b783          	ld	a5,0(a5)
    800033a4:	0147a683          	lw	a3,20(a5)
    800033a8:	00100713          	li	a4,1
    800033ac:	02e68863          	beq	a3,a4,800033dc <_ZN5RiscV10popSppSpieEv+0x50>
        asm("csrw sepc, ra");
    else
    {
        ra = (uint64)bodyWrapper;
        asm("mv a0, %[iarg]" : : [iarg] "r" (TCB::running->body));
    800033b0:	0187b703          	ld	a4,24(a5)
    800033b4:	00070513          	mv	a0,a4
        asm("mv a1, %[iarg]" : : [iarg] "r" (TCB::running->args));
    800033b8:	0207b783          	ld	a5,32(a5)
    800033bc:	00078593          	mv	a1,a5
        asm("csrw sepc, %[ra]" : : [ra] "r" (ra));
    800033c0:	00005797          	auipc	a5,0x5
    800033c4:	7487b783          	ld	a5,1864(a5) # 80008b08 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800033c8:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    800033cc:	10200073          	sret
}
    800033d0:	00813403          	ld	s0,8(sp)
    800033d4:	01010113          	addi	sp,sp,16
    800033d8:	00008067          	ret
        asm("csrw sepc, ra");
    800033dc:	14109073          	csrw	sepc,ra
    800033e0:	fedff06f          	j	800033cc <_ZN5RiscV10popSppSpieEv+0x40>

00000000800033e4 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    800033e4:	ff010113          	addi	sp,sp,-16
    800033e8:	00113423          	sd	ra,8(sp)
    800033ec:	00813023          	sd	s0,0(sp)
    800033f0:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    800033f4:	00005797          	auipc	a5,0x5
    800033f8:	71c7b783          	ld	a5,1820(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800033fc:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003400:	00100713          	li	a4,1
    80003404:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003408:	00000097          	auipc	ra,0x0
    8000340c:	8d4080e7          	jalr	-1836(ra) # 80002cdc <_ZN3TCB8dispatchEv>
}
    80003410:	00813083          	ld	ra,8(sp)
    80003414:	00013403          	ld	s0,0(sp)
    80003418:	01010113          	addi	sp,sp,16
    8000341c:	00008067          	ret

0000000080003420 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003420:	ff010113          	addi	sp,sp,-16
    80003424:	00113423          	sd	ra,8(sp)
    80003428:	00813023          	sd	s0,0(sp)
    8000342c:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003430:	00006797          	auipc	a5,0x6
    80003434:	9187c783          	lbu	a5,-1768(a5) # 80008d48 <_ZN5RiscV16userMainFinishedE>
    80003438:	00079c63          	bnez	a5,80003450 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    8000343c:	00005717          	auipc	a4,0x5
    80003440:	6c473703          	ld	a4,1732(a4) # 80008b00 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003444:	00073783          	ld	a5,0(a4)
    80003448:	00178793          	addi	a5,a5,1
    8000344c:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003450:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003454:	0ff57513          	andi	a0,a0,255
    80003458:	00002097          	auipc	ra,0x2
    8000345c:	8e4080e7          	jalr	-1820(ra) # 80004d3c <_ZN11ConsoleUtil9putOutputEc>
}
    80003460:	00813083          	ld	ra,8(sp)
    80003464:	00013403          	ld	s0,0(sp)
    80003468:	01010113          	addi	sp,sp,16
    8000346c:	00008067          	ret

0000000080003470 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003470:	ff010113          	addi	sp,sp,-16
    80003474:	00813423          	sd	s0,8(sp)
    80003478:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    8000347c:	00005797          	auipc	a5,0x5
    80003480:	6947b783          	ld	a5,1684(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003484:	0007b783          	ld	a5,0(a5)
    80003488:	0147a703          	lw	a4,20(a5)
    8000348c:	00100793          	li	a5,1
    80003490:	02f70a63          	beq	a4,a5,800034c4 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x54>
inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sstatus(uint64 mask) {
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003494:	10000793          	li	a5,256
    80003498:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
        RiscV::startVirtualMemory(RiscV::kPMT);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
        RiscV::startVirtualMemory(RiscV::uPMT);
    8000349c:	00006797          	auipc	a5,0x6
    800034a0:	8bc7b783          	ld	a5,-1860(a5) # 80008d58 <_ZN5RiscV4uPMTE>
inline void RiscV::disableTimerInterrupts(){
    RiscV::mc_sie(SIP_SSIE);
}

inline void RiscV::startVirtualMemory(void* PMT) {
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    800034a4:	00c7d793          	srli	a5,a5,0xc
    800034a8:	fff00713          	li	a4,-1
    800034ac:	03f71713          	slli	a4,a4,0x3f
    800034b0:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    800034b4:	18079073          	csrw	satp,a5
    }
}
    800034b8:	00813403          	ld	s0,8(sp)
    800034bc:	01010113          	addi	sp,sp,16
    800034c0:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800034c4:	10000793          	li	a5,256
    800034c8:	1007a073          	csrs	sstatus,a5
        RiscV::startVirtualMemory(RiscV::kPMT);
    800034cc:	00006797          	auipc	a5,0x6
    800034d0:	8847b783          	ld	a5,-1916(a5) # 80008d50 <_ZN5RiscV4kPMTE>
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    800034d4:	00c7d793          	srli	a5,a5,0xc
    800034d8:	fff00713          	li	a4,-1
    800034dc:	03f71713          	slli	a4,a4,0x3f
    800034e0:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    800034e4:	18079073          	csrw	satp,a5
}
    800034e8:	fd1ff06f          	j	800034b8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x48>

00000000800034ec <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    800034ec:	ff010113          	addi	sp,sp,-16
    800034f0:	00113423          	sd	ra,8(sp)
    800034f4:	00813023          	sd	s0,0(sp)
    800034f8:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    800034fc:	00100793          	li	a5,1
    80003500:	00006717          	auipc	a4,0x6
    80003504:	84f70423          	sb	a5,-1976(a4) # 80008d48 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003508:	00005797          	auipc	a5,0x5
    8000350c:	5f87b783          	ld	a5,1528(a5) # 80008b00 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003510:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003514:	00005797          	auipc	a5,0x5
    80003518:	59c7b783          	ld	a5,1436(a5) # 80008ab0 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000351c:	0007b023          	sd	zero,0(a5)
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003520:	00200793          	li	a5,2
    80003524:	1047b073          	csrc	sie,a5
    80003528:	20000793          	li	a5,512
    8000352c:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003530:	00005797          	auipc	a5,0x5
    80003534:	5a87b783          	ld	a5,1448(a5) # 80008ad8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003538:	0007b783          	ld	a5,0(a5)
    8000353c:	00078c63          	beqz	a5,80003554 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003540:	0487b703          	ld	a4,72(a5)
    80003544:	00005797          	auipc	a5,0x5
    80003548:	5947b783          	ld	a5,1428(a5) # 80008ad8 <_GLOBAL_OFFSET_TABLE_+0x80>
    8000354c:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003550:	fe1ff06f          	j	80003530 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003554:	00005797          	auipc	a5,0x5
    80003558:	58c7b783          	ld	a5,1420(a5) # 80008ae0 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000355c:	0007b503          	ld	a0,0(a5)
    80003560:	00001097          	auipc	ra,0x1
    80003564:	440080e7          	jalr	1088(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003568:	00005797          	auipc	a5,0x5
    8000356c:	5887b783          	ld	a5,1416(a5) # 80008af0 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003570:	0007b703          	ld	a4,0(a5)
    80003574:	00005797          	auipc	a5,0x5
    80003578:	5847b783          	ld	a5,1412(a5) # 80008af8 <_GLOBAL_OFFSET_TABLE_+0xa0>
    8000357c:	0007b783          	ld	a5,0(a5)
    80003580:	00f70863          	beq	a4,a5,80003590 <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    80003584:	fffff097          	auipc	ra,0xfffff
    80003588:	758080e7          	jalr	1880(ra) # 80002cdc <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000358c:	fddff06f          	j	80003568 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003590:	00813083          	ld	ra,8(sp)
    80003594:	00013403          	ld	s0,0(sp)
    80003598:	01010113          	addi	sp,sp,16
    8000359c:	00008067          	ret

00000000800035a0 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    800035a0:	ff010113          	addi	sp,sp,-16
    800035a4:	00813423          	sd	s0,8(sp)
    800035a8:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    800035ac:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    800035b0:	00005717          	auipc	a4,0x5
    800035b4:	56073703          	ld	a4,1376(a4) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800035b8:	00073703          	ld	a4,0(a4)
    800035bc:	06873703          	ld	a4,104(a4)
    800035c0:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    800035c4:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800035c8:	00078593          	mv	a1,a5
}
    800035cc:	00813403          	ld	s0,8(sp)
    800035d0:	01010113          	addi	sp,sp,16
    800035d4:	00008067          	ret

00000000800035d8 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    800035d8:	ff010113          	addi	sp,sp,-16
    800035dc:	00113423          	sd	ra,8(sp)
    800035e0:	00813023          	sd	s0,0(sp)
    800035e4:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    800035e8:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    800035ec:	00000097          	auipc	ra,0x0
    800035f0:	974080e7          	jalr	-1676(ra) # 80002f60 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    800035f4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800035f8:	00000097          	auipc	ra,0x0
    800035fc:	fa8080e7          	jalr	-88(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003600:	00813083          	ld	ra,8(sp)
    80003604:	00013403          	ld	s0,0(sp)
    80003608:	01010113          	addi	sp,sp,16
    8000360c:	00008067          	ret

0000000080003610 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003610:	ff010113          	addi	sp,sp,-16
    80003614:	00113423          	sd	ra,8(sp)
    80003618:	00813023          	sd	s0,0(sp)
    8000361c:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003620:	00005797          	auipc	a5,0x5
    80003624:	5007b783          	ld	a5,1280(a5) # 80008b20 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80003628:	0007c783          	lbu	a5,0(a5)
    8000362c:	02079263          	bnez	a5,80003650 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003630:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003634:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003638:	00000097          	auipc	ra,0x0
    8000363c:	f68080e7          	jalr	-152(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003640:	00813083          	ld	ra,8(sp)
    80003644:	00013403          	ld	s0,0(sp)
    80003648:	01010113          	addi	sp,sp,16
    8000364c:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003650:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003654:	00000097          	auipc	ra,0x0
    80003658:	b44080e7          	jalr	-1212(ra) # 80003198 <_ZN15MemoryAllocator5kfreeEPv>
    8000365c:	fd9ff06f          	j	80003634 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003660 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003660:	fc010113          	addi	sp,sp,-64
    80003664:	02113c23          	sd	ra,56(sp)
    80003668:	02813823          	sd	s0,48(sp)
    8000366c:	02913423          	sd	s1,40(sp)
    80003670:	03213023          	sd	s2,32(sp)
    80003674:	01313c23          	sd	s3,24(sp)
    80003678:	01413823          	sd	s4,16(sp)
    8000367c:	01513423          	sd	s5,8(sp)
    80003680:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003684:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003688:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000368c:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003690:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003694:	07000513          	li	a0,112
    80003698:	fffff097          	auipc	ra,0xfffff
    8000369c:	6c4080e7          	jalr	1732(ra) # 80002d5c <_ZN3TCBnwEm>
    800036a0:	00050493          	mv	s1,a0
    800036a4:	00050e63          	beqz	a0,800036c0 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    800036a8:	00200713          	li	a4,2
    800036ac:	000a8693          	mv	a3,s5
    800036b0:	000a0613          	mv	a2,s4
    800036b4:	00098593          	mv	a1,s3
    800036b8:	fffff097          	auipc	ra,0xfffff
    800036bc:	568080e7          	jalr	1384(ra) # 80002c20 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800036c0:	04048863          	beqz	s1,80003710 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    800036c4:	0184b783          	ld	a5,24(s1)
    800036c8:	00078863          	beqz	a5,800036d8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    800036cc:	00048513          	mv	a0,s1
    800036d0:	00001097          	auipc	ra,0x1
    800036d4:	2d0080e7          	jalr	720(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    800036d8:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800036dc:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800036e0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800036e4:	00000097          	auipc	ra,0x0
    800036e8:	ebc080e7          	jalr	-324(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
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
    80003714:	fcdff06f          	j	800036e0 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    80003718:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000371c:	00048513          	mv	a0,s1
    80003720:	fffff097          	auipc	ra,0xfffff
    80003724:	760080e7          	jalr	1888(ra) # 80002e80 <_ZN3TCBdlEPv>
    80003728:	00090513          	mv	a0,s2
    8000372c:	0000a097          	auipc	ra,0xa
    80003730:	76c080e7          	jalr	1900(ra) # 8000de98 <_Unwind_Resume>

0000000080003734 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003734:	fc010113          	addi	sp,sp,-64
    80003738:	02113c23          	sd	ra,56(sp)
    8000373c:	02813823          	sd	s0,48(sp)
    80003740:	02913423          	sd	s1,40(sp)
    80003744:	03213023          	sd	s2,32(sp)
    80003748:	01313c23          	sd	s3,24(sp)
    8000374c:	01413823          	sd	s4,16(sp)
    80003750:	01513423          	sd	s5,8(sp)
    80003754:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003758:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000375c:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003760:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003764:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003768:	07000513          	li	a0,112
    8000376c:	fffff097          	auipc	ra,0xfffff
    80003770:	5f0080e7          	jalr	1520(ra) # 80002d5c <_ZN3TCBnwEm>
    80003774:	00050493          	mv	s1,a0
    80003778:	00050e63          	beqz	a0,80003794 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    8000377c:	00200713          	li	a4,2
    80003780:	000a8693          	mv	a3,s5
    80003784:	00090613          	mv	a2,s2
    80003788:	00098593          	mv	a1,s3
    8000378c:	fffff097          	auipc	ra,0xfffff
    80003790:	494080e7          	jalr	1172(ra) # 80002c20 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003794:	04048263          	beqz	s1,800037d8 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    80003798:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    8000379c:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    800037a0:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    800037a4:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800037a8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800037ac:	00000097          	auipc	ra,0x0
    800037b0:	df4080e7          	jalr	-524(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    800037b4:	03813083          	ld	ra,56(sp)
    800037b8:	03013403          	ld	s0,48(sp)
    800037bc:	02813483          	ld	s1,40(sp)
    800037c0:	02013903          	ld	s2,32(sp)
    800037c4:	01813983          	ld	s3,24(sp)
    800037c8:	01013a03          	ld	s4,16(sp)
    800037cc:	00813a83          	ld	s5,8(sp)
    800037d0:	04010113          	addi	sp,sp,64
    800037d4:	00008067          	ret
        status = -1;
    800037d8:	fff00793          	li	a5,-1
    800037dc:	fcdff06f          	j	800037a8 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    800037e0:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800037e4:	00048513          	mv	a0,s1
    800037e8:	fffff097          	auipc	ra,0xfffff
    800037ec:	698080e7          	jalr	1688(ra) # 80002e80 <_ZN3TCBdlEPv>
    800037f0:	00090513          	mv	a0,s2
    800037f4:	0000a097          	auipc	ra,0xa
    800037f8:	6a4080e7          	jalr	1700(ra) # 8000de98 <_Unwind_Resume>

00000000800037fc <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    800037fc:	ff010113          	addi	sp,sp,-16
    80003800:	00113423          	sd	ra,8(sp)
    80003804:	00813023          	sd	s0,0(sp)
    80003808:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000380c:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003810:	02051263          	bnez	a0,80003834 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003814:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003818:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000381c:	00000097          	auipc	ra,0x0
    80003820:	d84080e7          	jalr	-636(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003824:	00813083          	ld	ra,8(sp)
    80003828:	00013403          	ld	s0,0(sp)
    8000382c:	01010113          	addi	sp,sp,16
    80003830:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003834:	00100793          	li	a5,1
    80003838:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    8000383c:	00001097          	auipc	ra,0x1
    80003840:	164080e7          	jalr	356(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	498080e7          	jalr	1176(ra) # 80002cdc <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000384c:	00000793          	li	a5,0
    80003850:	fc9ff06f          	j	80003818 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003854 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003854:	ff010113          	addi	sp,sp,-16
    80003858:	00113423          	sd	ra,8(sp)
    8000385c:	00813023          	sd	s0,0(sp)
    80003860:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003864:	00005797          	auipc	a5,0x5
    80003868:	2ac7b783          	ld	a5,684(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000386c:	0007b783          	ld	a5,0(a5)
    80003870:	02078a63          	beqz	a5,800038a4 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003874:	00200713          	li	a4,2
    80003878:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    8000387c:	fffff097          	auipc	ra,0xfffff
    80003880:	460080e7          	jalr	1120(ra) # 80002cdc <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003884:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003888:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000388c:	00000097          	auipc	ra,0x0
    80003890:	d14080e7          	jalr	-748(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003894:	00813083          	ld	ra,8(sp)
    80003898:	00013403          	ld	s0,0(sp)
    8000389c:	01010113          	addi	sp,sp,16
    800038a0:	00008067          	ret
        status = -1;
    800038a4:	fff00793          	li	a5,-1
    800038a8:	fe1ff06f          	j	80003888 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

00000000800038ac <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    800038ac:	fd010113          	addi	sp,sp,-48
    800038b0:	02113423          	sd	ra,40(sp)
    800038b4:	02813023          	sd	s0,32(sp)
    800038b8:	00913c23          	sd	s1,24(sp)
    800038bc:	01213823          	sd	s2,16(sp)
    800038c0:	01313423          	sd	s3,8(sp)
    800038c4:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800038c8:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    800038cc:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    800038d0:	01800513          	li	a0,24
    800038d4:	fffff097          	auipc	ra,0xfffff
    800038d8:	1f8080e7          	jalr	504(ra) # 80002acc <_ZN3SCBnwEm>
    800038dc:	00050493          	mv	s1,a0
    800038e0:	00050863          	beqz	a0,800038f0 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    800038e4:	00098593          	mv	a1,s3
    800038e8:	fffff097          	auipc	ra,0xfffff
    800038ec:	030080e7          	jalr	48(ra) # 80002918 <_ZN3SCBC1Em>
    if(scb == nullptr){
    800038f0:	02048a63          	beqz	s1,80003924 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    800038f4:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800038f8:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800038fc:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003900:	00000097          	auipc	ra,0x0
    80003904:	ca0080e7          	jalr	-864(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003908:	02813083          	ld	ra,40(sp)
    8000390c:	02013403          	ld	s0,32(sp)
    80003910:	01813483          	ld	s1,24(sp)
    80003914:	01013903          	ld	s2,16(sp)
    80003918:	00813983          	ld	s3,8(sp)
    8000391c:	03010113          	addi	sp,sp,48
    80003920:	00008067          	ret
        status = -1;
    80003924:	fff00793          	li	a5,-1
    80003928:	fd5ff06f          	j	800038fc <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    8000392c:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003930:	00048513          	mv	a0,s1
    80003934:	fffff097          	auipc	ra,0xfffff
    80003938:	1c8080e7          	jalr	456(ra) # 80002afc <_ZN3SCBdlEPv>
    8000393c:	00090513          	mv	a0,s2
    80003940:	0000a097          	auipc	ra,0xa
    80003944:	558080e7          	jalr	1368(ra) # 8000de98 <_Unwind_Resume>

0000000080003948 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003948:	fe010113          	addi	sp,sp,-32
    8000394c:	00113c23          	sd	ra,24(sp)
    80003950:	00813823          	sd	s0,16(sp)
    80003954:	00913423          	sd	s1,8(sp)
    80003958:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000395c:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003960:	02049463          	bnez	s1,80003988 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003964:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003968:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000396c:	00000097          	auipc	ra,0x0
    80003970:	c34080e7          	jalr	-972(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003974:	01813083          	ld	ra,24(sp)
    80003978:	01013403          	ld	s0,16(sp)
    8000397c:	00813483          	ld	s1,8(sp)
    80003980:	02010113          	addi	sp,sp,32
    80003984:	00008067          	ret
        delete (SCB*)ihandle;
    80003988:	00048513          	mv	a0,s1
    8000398c:	fffff097          	auipc	ra,0xfffff
    80003990:	fa8080e7          	jalr	-88(ra) # 80002934 <_ZN3SCBD1Ev>
    80003994:	00048513          	mv	a0,s1
    80003998:	fffff097          	auipc	ra,0xfffff
    8000399c:	164080e7          	jalr	356(ra) # 80002afc <_ZN3SCBdlEPv>
    uint64 status = 0;
    800039a0:	00000793          	li	a5,0
    800039a4:	fc5ff06f          	j	80003968 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

00000000800039a8 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    800039a8:	ff010113          	addi	sp,sp,-16
    800039ac:	00113423          	sd	ra,8(sp)
    800039b0:	00813023          	sd	s0,0(sp)
    800039b4:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800039b8:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800039bc:	02051c63          	bnez	a0,800039f4 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    800039c0:	00005797          	auipc	a5,0x5
    800039c4:	1507b783          	ld	a5,336(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800039c8:	0007b783          	ld	a5,0(a5)
    800039cc:	0607b783          	ld	a5,96(a5)
    800039d0:	02078863          	beqz	a5,80003a00 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    800039d4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800039d8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800039dc:	00000097          	auipc	ra,0x0
    800039e0:	bc4080e7          	jalr	-1084(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    800039e4:	00813083          	ld	ra,8(sp)
    800039e8:	00013403          	ld	s0,0(sp)
    800039ec:	01010113          	addi	sp,sp,16
    800039f0:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800039f4:	fffff097          	auipc	ra,0xfffff
    800039f8:	04c080e7          	jalr	76(ra) # 80002a40 <_ZN3SCB4waitEv>
    800039fc:	fc5ff06f          	j	800039c0 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80003a00:	00000793          	li	a5,0
    80003a04:	fd5ff06f          	j	800039d8 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003a08 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003a08:	ff010113          	addi	sp,sp,-16
    80003a0c:	00113423          	sd	ra,8(sp)
    80003a10:	00813023          	sd	s0,0(sp)
    80003a14:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003a18:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003a1c:	02051263          	bnez	a0,80003a40 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003a20:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a24:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003a28:	00000097          	auipc	ra,0x0
    80003a2c:	b78080e7          	jalr	-1160(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a30:	00813083          	ld	ra,8(sp)
    80003a34:	00013403          	ld	s0,0(sp)
    80003a38:	01010113          	addi	sp,sp,16
    80003a3c:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003a40:	fffff097          	auipc	ra,0xfffff
    80003a44:	050080e7          	jalr	80(ra) # 80002a90 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003a48:	00000793          	li	a5,0
    80003a4c:	fd9ff06f          	j	80003a24 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003a50 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003a50:	fe010113          	addi	sp,sp,-32
    80003a54:	00113c23          	sd	ra,24(sp)
    80003a58:	00813823          	sd	s0,16(sp)
    80003a5c:	00913423          	sd	s1,8(sp)
    80003a60:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003a64:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003a68:	00005797          	auipc	a5,0x5
    80003a6c:	0a87b783          	ld	a5,168(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003a70:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003a74:	00005797          	auipc	a5,0x5
    80003a78:	2ec7b783          	ld	a5,748(a5) # 80008d60 <_ZN5RiscV10globalTimeE>
    80003a7c:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003a80:	00e787b3          	add	a5,a5,a4
    80003a84:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003a88:	00048513          	mv	a0,s1
    80003a8c:	00001097          	auipc	ra,0x1
    80003a90:	f90080e7          	jalr	-112(ra) # 80004a1c <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003a94:	00300793          	li	a5,3
    80003a98:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003a9c:	fffff097          	auipc	ra,0xfffff
    80003aa0:	240080e7          	jalr	576(ra) # 80002cdc <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003aa4:	00000793          	li	a5,0
    80003aa8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003aac:	00000097          	auipc	ra,0x0
    80003ab0:	af4080e7          	jalr	-1292(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ab4:	01813083          	ld	ra,24(sp)
    80003ab8:	01013403          	ld	s0,16(sp)
    80003abc:	00813483          	ld	s1,8(sp)
    80003ac0:	02010113          	addi	sp,sp,32
    80003ac4:	00008067          	ret

0000000080003ac8 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003ac8:	fe010113          	addi	sp,sp,-32
    80003acc:	00113c23          	sd	ra,24(sp)
    80003ad0:	00813823          	sd	s0,16(sp)
    80003ad4:	00913423          	sd	s1,8(sp)
    80003ad8:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003adc:	00005797          	auipc	a5,0x5
    80003ae0:	26c7c783          	lbu	a5,620(a5) # 80008d48 <_ZN5RiscV16userMainFinishedE>
    80003ae4:	00079c63          	bnez	a5,80003afc <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003ae8:	00005717          	auipc	a4,0x5
    80003aec:	fc873703          	ld	a4,-56(a4) # 80008ab0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003af0:	00073783          	ld	a5,0(a4)
    80003af4:	00178793          	addi	a5,a5,1
    80003af8:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003afc:	00001097          	auipc	ra,0x1
    80003b00:	1c8080e7          	jalr	456(ra) # 80004cc4 <_ZN11ConsoleUtil8getInputEv>
    80003b04:	00050493          	mv	s1,a0
    if(c==13) {
    80003b08:	00d00793          	li	a5,13
    80003b0c:	02f50663          	beq	a0,a5,80003b38 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80003b10:	01b00793          	li	a5,27
    80003b14:	04f51063          	bne	a0,a5,80003b54 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003b18:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003b1c:	00000097          	auipc	ra,0x0
    80003b20:	a84080e7          	jalr	-1404(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b24:	01813083          	ld	ra,24(sp)
    80003b28:	01013403          	ld	s0,16(sp)
    80003b2c:	00813483          	ld	s1,8(sp)
    80003b30:	02010113          	addi	sp,sp,32
    80003b34:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003b38:	00d00513          	li	a0,13
    80003b3c:	00001097          	auipc	ra,0x1
    80003b40:	200080e7          	jalr	512(ra) # 80004d3c <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003b44:	00a00513          	li	a0,10
    80003b48:	00001097          	auipc	ra,0x1
    80003b4c:	1f4080e7          	jalr	500(ra) # 80004d3c <_ZN11ConsoleUtil9putOutputEc>
    80003b50:	fc9ff06f          	j	80003b18 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003b54:	00001097          	auipc	ra,0x1
    80003b58:	1e8080e7          	jalr	488(ra) # 80004d3c <_ZN11ConsoleUtil9putOutputEc>
    80003b5c:	fbdff06f          	j	80003b18 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003b60 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003b60:	ff010113          	addi	sp,sp,-16
    80003b64:	00113423          	sd	ra,8(sp)
    80003b68:	00813023          	sd	s0,0(sp)
    80003b6c:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003b70:	00001097          	auipc	ra,0x1
    80003b74:	24c080e7          	jalr	588(ra) # 80004dbc <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003b78:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003b7c:	00000097          	auipc	ra,0x0
    80003b80:	a24080e7          	jalr	-1500(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b84:	00813083          	ld	ra,8(sp)
    80003b88:	00013403          	ld	s0,0(sp)
    80003b8c:	01010113          	addi	sp,sp,16
    80003b90:	00008067          	ret

0000000080003b94 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003b94:	fe010113          	addi	sp,sp,-32
    80003b98:	00113c23          	sd	ra,24(sp)
    80003b9c:	00813823          	sd	s0,16(sp)
    80003ba0:	00913423          	sd	s1,8(sp)
    80003ba4:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003ba8:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003bac:	02049463          	bnez	s1,80003bd4 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003bb0:	fff00793          	li	a5,-1
    80003bb4:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003bb8:	00000097          	auipc	ra,0x0
    80003bbc:	9e8080e7          	jalr	-1560(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003bc0:	01813083          	ld	ra,24(sp)
    80003bc4:	01013403          	ld	s0,16(sp)
    80003bc8:	00813483          	ld	s1,8(sp)
    80003bcc:	02010113          	addi	sp,sp,32
    80003bd0:	00008067          	ret
        kfree(thr->stack);
    80003bd4:	0284b503          	ld	a0,40(s1)
    80003bd8:	00001097          	auipc	ra,0x1
    80003bdc:	558080e7          	jalr	1368(ra) # 80005130 <_Z5kfreePKv>
        delete thr;
    80003be0:	00048513          	mv	a0,s1
    80003be4:	fffff097          	auipc	ra,0xfffff
    80003be8:	0d0080e7          	jalr	208(ra) # 80002cb4 <_ZN3TCBD1Ev>
    80003bec:	00048513          	mv	a0,s1
    80003bf0:	fffff097          	auipc	ra,0xfffff
    80003bf4:	290080e7          	jalr	656(ra) # 80002e80 <_ZN3TCBdlEPv>
    80003bf8:	fb9ff06f          	j	80003bb0 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080003bfc <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003bfc:	fe010113          	addi	sp,sp,-32
    80003c00:	00113c23          	sd	ra,24(sp)
    80003c04:	00813823          	sd	s0,16(sp)
    80003c08:	00913423          	sd	s1,8(sp)
    80003c0c:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003c10:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003c14:	02049463          	bnez	s1,80003c3c <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003c18:	fff00793          	li	a5,-1
    80003c1c:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003c20:	00000097          	auipc	ra,0x0
    80003c24:	980080e7          	jalr	-1664(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003c28:	01813083          	ld	ra,24(sp)
    80003c2c:	01013403          	ld	s0,16(sp)
    80003c30:	00813483          	ld	s1,8(sp)
    80003c34:	02010113          	addi	sp,sp,32
    80003c38:	00008067          	ret
        delete scb;
    80003c3c:	00048513          	mv	a0,s1
    80003c40:	fffff097          	auipc	ra,0xfffff
    80003c44:	cf4080e7          	jalr	-780(ra) # 80002934 <_ZN3SCBD1Ev>
    80003c48:	00048513          	mv	a0,s1
    80003c4c:	fffff097          	auipc	ra,0xfffff
    80003c50:	eb0080e7          	jalr	-336(ra) # 80002afc <_ZN3SCBdlEPv>
    80003c54:	fc5ff06f          	j	80003c18 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003c58 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003c58:	fe010113          	addi	sp,sp,-32
    80003c5c:	00113c23          	sd	ra,24(sp)
    80003c60:	00813823          	sd	s0,16(sp)
    80003c64:	00913423          	sd	s1,8(sp)
    80003c68:	01213023          	sd	s2,0(sp)
    80003c6c:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80003c70:	00001537          	lui	a0,0x1
    80003c74:	00001097          	auipc	ra,0x1
    80003c78:	494080e7          	jalr	1172(ra) # 80005108 <_Z7kmallocm>
    80003c7c:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003c80:	00005797          	auipc	a5,0x5
    80003c84:	e907b783          	ld	a5,-368(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003c88:	0007b783          	ld	a5,0(a5)
    80003c8c:	00001637          	lui	a2,0x1
    80003c90:	00050593          	mv	a1,a0
    80003c94:	0287b503          	ld	a0,40(a5)
    80003c98:	fffff097          	auipc	ra,0xfffff
    80003c9c:	6b4080e7          	jalr	1716(ra) # 8000334c <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003ca0:	07000513          	li	a0,112
    80003ca4:	fffff097          	auipc	ra,0xfffff
    80003ca8:	0b8080e7          	jalr	184(ra) # 80002d5c <_ZN3TCBnwEm>
    80003cac:	00050493          	mv	s1,a0
    80003cb0:	00050e63          	beqz	a0,80003ccc <_ZN5RiscV18executeForkSyscallEv+0x74>
    80003cb4:	00200713          	li	a4,2
    80003cb8:	00090693          	mv	a3,s2
    80003cbc:	00000613          	li	a2,0
    80003cc0:	00000593          	li	a1,0
    80003cc4:	fffff097          	auipc	ra,0xfffff
    80003cc8:	f5c080e7          	jalr	-164(ra) # 80002c20 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003ccc:	0a048e63          	beqz	s1,80003d88 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003cd0:	00005797          	auipc	a5,0x5
    80003cd4:	e007b783          	ld	a5,-512(a5) # 80008ad0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003cd8:	0007b783          	ld	a5,0(a5)
    80003cdc:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003ce0:	00005797          	auipc	a5,0x5
    80003ce4:	dd87b783          	ld	a5,-552(a5) # 80008ab8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003ce8:	0007b783          	ld	a5,0(a5)
    80003cec:	00f907b3          	add	a5,s2,a5
    80003cf0:	00005717          	auipc	a4,0x5
    80003cf4:	e2073703          	ld	a4,-480(a4) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003cf8:	00073683          	ld	a3,0(a4)
    80003cfc:	0286b683          	ld	a3,40(a3)
    80003d00:	40d787b3          	sub	a5,a5,a3
    80003d04:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003d08:	00073783          	ld	a5,0(a4)
    80003d0c:	0687b503          	ld	a0,104(a5)
    80003d10:	0287b783          	ld	a5,40(a5)
    80003d14:	40f50533          	sub	a0,a0,a5
    80003d18:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003d1c:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003d20:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80003d24:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003d28:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80003d2c:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80003d30:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80003d34:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80003d38:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003d3c:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003d40:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003d44:	00073783          	ld	a5,0(a4)
    80003d48:	0387b703          	ld	a4,56(a5)
    80003d4c:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003d50:	0407b783          	ld	a5,64(a5)
    80003d54:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003d58:	00048513          	mv	a0,s1
    80003d5c:	00001097          	auipc	ra,0x1
    80003d60:	c44080e7          	jalr	-956(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d64:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003d68:	00000097          	auipc	ra,0x0
    80003d6c:	838080e7          	jalr	-1992(ra) # 800035a0 <_ZN5RiscV16saveA0toSscratchEv>

}
    80003d70:	01813083          	ld	ra,24(sp)
    80003d74:	01013403          	ld	s0,16(sp)
    80003d78:	00813483          	ld	s1,8(sp)
    80003d7c:	00013903          	ld	s2,0(sp)
    80003d80:	02010113          	addi	sp,sp,32
    80003d84:	00008067          	ret
        status = -1;
    80003d88:	fff00493          	li	s1,-1
    80003d8c:	fd9ff06f          	j	80003d64 <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80003d90:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003d94:	00048513          	mv	a0,s1
    80003d98:	fffff097          	auipc	ra,0xfffff
    80003d9c:	0e8080e7          	jalr	232(ra) # 80002e80 <_ZN3TCBdlEPv>
    80003da0:	00090513          	mv	a0,s2
    80003da4:	0000a097          	auipc	ra,0xa
    80003da8:	0f4080e7          	jalr	244(ra) # 8000de98 <_Unwind_Resume>

0000000080003dac <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003dac:	ff010113          	addi	sp,sp,-16
    80003db0:	00813423          	sd	s0,8(sp)
    80003db4:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003db8:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003dbc:	00878793          	addi	a5,a5,8
    80003dc0:	00005717          	auipc	a4,0x5
    80003dc4:	d1073703          	ld	a4,-752(a4) # 80008ad0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003dc8:	00f73023          	sd	a5,0(a4)
}
    80003dcc:	00813403          	ld	s0,8(sp)
    80003dd0:	01010113          	addi	sp,sp,16
    80003dd4:	00008067          	ret

0000000080003dd8 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003dd8:	f9010113          	addi	sp,sp,-112
    80003ddc:	06113423          	sd	ra,104(sp)
    80003de0:	06813023          	sd	s0,96(sp)
    80003de4:	04913c23          	sd	s1,88(sp)
    80003de8:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    80003dec:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003df0:	142027f3          	csrr	a5,scause
    80003df4:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80003df8:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    80003dfc:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80003e00:	00005797          	auipc	a5,0x5
    80003e04:	d107b783          	ld	a5,-752(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003e08:	0007b783          	ld	a5,0(a5)
    80003e0c:	14002773          	csrr	a4,sscratch
    80003e10:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80003e14:	fd843703          	ld	a4,-40(s0)
    80003e18:	00900793          	li	a5,9
    80003e1c:	10f70663          	beq	a4,a5,80003f28 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    80003e20:	fd843703          	ld	a4,-40(s0)
    80003e24:	00800793          	li	a5,8
    80003e28:	10f70063          	beq	a4,a5,80003f28 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    80003e2c:	fd843703          	ld	a4,-40(s0)
    80003e30:	fff00793          	li	a5,-1
    80003e34:	03f79793          	slli	a5,a5,0x3f
    80003e38:	00178793          	addi	a5,a5,1
    80003e3c:	26f70463          	beq	a4,a5,800040a4 <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    80003e40:	fd843703          	ld	a4,-40(s0)
    80003e44:	fff00793          	li	a5,-1
    80003e48:	03f79793          	slli	a5,a5,0x3f
    80003e4c:	00978793          	addi	a5,a5,9
    80003e50:	2ef70263          	beq	a4,a5,80004134 <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    80003e54:	fd843703          	ld	a4,-40(s0)
    80003e58:	00200793          	li	a5,2
    80003e5c:	36f70a63          	beq	a4,a5,800041d0 <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    80003e60:	00004517          	auipc	a0,0x4
    80003e64:	56850513          	addi	a0,a0,1384 # 800083c8 <CONSOLE_STATUS+0x3b8>
    80003e68:	00001097          	auipc	ra,0x1
    80003e6c:	fcc080e7          	jalr	-52(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003e70:	00004517          	auipc	a0,0x4
    80003e74:	56850513          	addi	a0,a0,1384 # 800083d8 <CONSOLE_STATUS+0x3c8>
    80003e78:	00001097          	auipc	ra,0x1
    80003e7c:	fbc080e7          	jalr	-68(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003e80:	142027f3          	csrr	a5,scause
    80003e84:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003e88:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80003e8c:	00000613          	li	a2,0
    80003e90:	00a00593          	li	a1,10
    80003e94:	0005051b          	sext.w	a0,a0
    80003e98:	00001097          	auipc	ra,0x1
    80003e9c:	fe0080e7          	jalr	-32(ra) # 80004e78 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003ea0:	00004517          	auipc	a0,0x4
    80003ea4:	4f850513          	addi	a0,a0,1272 # 80008398 <CONSOLE_STATUS+0x388>
    80003ea8:	00001097          	auipc	ra,0x1
    80003eac:	f8c080e7          	jalr	-116(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003eb0:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003eb4:	00000613          	li	a2,0
    80003eb8:	01000593          	li	a1,16
    80003ebc:	0005051b          	sext.w	a0,a0
    80003ec0:	00001097          	auipc	ra,0x1
    80003ec4:	fb8080e7          	jalr	-72(ra) # 80004e78 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003ec8:	00004517          	auipc	a0,0x4
    80003ecc:	4c850513          	addi	a0,a0,1224 # 80008390 <CONSOLE_STATUS+0x380>
    80003ed0:	00001097          	auipc	ra,0x1
    80003ed4:	f64080e7          	jalr	-156(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    80003ed8:	01000693          	li	a3,16
    80003edc:	00004617          	auipc	a2,0x4
    80003ee0:	4b460613          	addi	a2,a2,1204 # 80008390 <CONSOLE_STATUS+0x380>
    80003ee4:	0004859b          	sext.w	a1,s1
    80003ee8:	00004517          	auipc	a0,0x4
    80003eec:	50050513          	addi	a0,a0,1280 # 800083e8 <CONSOLE_STATUS+0x3d8>
    80003ef0:	00001097          	auipc	ra,0x1
    80003ef4:	064080e7          	jalr	100(ra) # 80004f54 <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80003ef8:	00005797          	auipc	a5,0x5
    80003efc:	c187b783          	ld	a5,-1000(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003f00:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003f04:	00200713          	li	a4,2
    80003f08:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003f0c:	00004517          	auipc	a0,0x4
    80003f10:	4e450513          	addi	a0,a0,1252 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80003f14:	00001097          	auipc	ra,0x1
    80003f18:	f20080e7          	jalr	-224(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003f1c:	fffff097          	auipc	ra,0xfffff
    80003f20:	dc0080e7          	jalr	-576(ra) # 80002cdc <_ZN3TCB8dispatchEv>
    80003f24:	0800006f          	j	80003fa4 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003f28:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003f2c:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003f30:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80003f34:	00478793          	addi	a5,a5,4
    80003f38:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    80003f3c:	00005797          	auipc	a5,0x5
    80003f40:	bd47b783          	ld	a5,-1068(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003f44:	0007b783          	ld	a5,0(a5)
    80003f48:	fa043703          	ld	a4,-96(s0)
    80003f4c:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80003f50:	f9843703          	ld	a4,-104(s0)
    80003f54:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80003f58:	00050793          	mv	a5,a0
        switch(syscallID){
    80003f5c:	06100713          	li	a4,97
    80003f60:	02f76463          	bltu	a4,a5,80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    80003f64:	00279793          	slli	a5,a5,0x2
    80003f68:	00004717          	auipc	a4,0x4
    80003f6c:	49c70713          	addi	a4,a4,1180 # 80008404 <CONSOLE_STATUS+0x3f4>
    80003f70:	00e787b3          	add	a5,a5,a4
    80003f74:	0007a783          	lw	a5,0(a5)
    80003f78:	00e787b3          	add	a5,a5,a4
    80003f7c:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003f80:	fffff097          	auipc	ra,0xfffff
    80003f84:	658080e7          	jalr	1624(ra) # 800035d8 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003f88:	00005797          	auipc	a5,0x5
    80003f8c:	b887b783          	ld	a5,-1144(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003f90:	0007b783          	ld	a5,0(a5)
    80003f94:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003f98:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003f9c:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003fa0:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003fa4:	fffff097          	auipc	ra,0xfffff
    80003fa8:	4cc080e7          	jalr	1228(ra) # 80003470 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003fac:	06813083          	ld	ra,104(sp)
    80003fb0:	06013403          	ld	s0,96(sp)
    80003fb4:	05813483          	ld	s1,88(sp)
    80003fb8:	07010113          	addi	sp,sp,112
    80003fbc:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003fc0:	fffff097          	auipc	ra,0xfffff
    80003fc4:	650080e7          	jalr	1616(ra) # 80003610 <_ZN5RiscV21executeMemFreeSyscallEv>
    80003fc8:	fc1ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    80003fcc:	fffff097          	auipc	ra,0xfffff
    80003fd0:	694080e7          	jalr	1684(ra) # 80003660 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003fd4:	fb5ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    80003fd8:	00000097          	auipc	ra,0x0
    80003fdc:	87c080e7          	jalr	-1924(ra) # 80003854 <_ZN5RiscV24executeThreadExitSyscallEv>
    80003fe0:	fa9ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003fe4:	fffff097          	auipc	ra,0xfffff
    80003fe8:	400080e7          	jalr	1024(ra) # 800033e4 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003fec:	f9dff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003ff0:	fffff097          	auipc	ra,0xfffff
    80003ff4:	744080e7          	jalr	1860(ra) # 80003734 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003ff8:	f91ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    80003ffc:	00000097          	auipc	ra,0x0
    80004000:	800080e7          	jalr	-2048(ra) # 800037fc <_ZN5RiscV25executeThreadStartSyscallEv>
    80004004:	f85ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80004008:	00000097          	auipc	ra,0x0
    8000400c:	8a4080e7          	jalr	-1884(ra) # 800038ac <_ZN5RiscV21executeSemOpenSyscallEv>
    80004010:	f79ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    80004014:	00000097          	auipc	ra,0x0
    80004018:	934080e7          	jalr	-1740(ra) # 80003948 <_ZN5RiscV22executeSemCloseSyscallEv>
    8000401c:	f6dff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    80004020:	00000097          	auipc	ra,0x0
    80004024:	988080e7          	jalr	-1656(ra) # 800039a8 <_ZN5RiscV21executeSemWaitSyscallEv>
    80004028:	f61ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    8000402c:	00000097          	auipc	ra,0x0
    80004030:	9dc080e7          	jalr	-1572(ra) # 80003a08 <_ZN5RiscV23executeSemSignalSyscallEv>
    80004034:	f55ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    80004038:	00000097          	auipc	ra,0x0
    8000403c:	a18080e7          	jalr	-1512(ra) # 80003a50 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80004040:	f49ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    80004044:	00000097          	auipc	ra,0x0
    80004048:	a84080e7          	jalr	-1404(ra) # 80003ac8 <_ZN5RiscV18executeGetcSyscallEv>
    8000404c:	f3dff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    80004050:	fffff097          	auipc	ra,0xfffff
    80004054:	3d0080e7          	jalr	976(ra) # 80003420 <_ZN5RiscV18executePutcSyscallEv>
    80004058:	f31ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    8000405c:	00000097          	auipc	ra,0x0
    80004060:	b04080e7          	jalr	-1276(ra) # 80003b60 <_ZN5RiscV22executePutcUtilSyscallEv>
    80004064:	f25ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    80004068:	00000097          	auipc	ra,0x0
    8000406c:	b2c080e7          	jalr	-1236(ra) # 80003b94 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004070:	f19ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004074:	00000097          	auipc	ra,0x0
    80004078:	b88080e7          	jalr	-1144(ra) # 80003bfc <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    8000407c:	f0dff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004080:	00010793          	mv	a5,sp
    80004084:	00005717          	auipc	a4,0x5
    80004088:	a3473703          	ld	a4,-1484(a4) # 80008ab8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000408c:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004090:	00000097          	auipc	ra,0x0
    80004094:	d1c080e7          	jalr	-740(ra) # 80003dac <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004098:	00000097          	auipc	ra,0x0
    8000409c:	bc0080e7          	jalr	-1088(ra) # 80003c58 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    800040a0:	ee9ff06f          	j	80003f88 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800040a4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800040a8:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800040ac:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800040b0:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    800040b4:	00200793          	li	a5,2
    800040b8:	1447b073          	csrc	sip,a5
        globalTime += 1;
    800040bc:	00005717          	auipc	a4,0x5
    800040c0:	c8c70713          	addi	a4,a4,-884 # 80008d48 <_ZN5RiscV16userMainFinishedE>
    800040c4:	01873783          	ld	a5,24(a4)
    800040c8:	00178793          	addi	a5,a5,1
    800040cc:	00f73c23          	sd	a5,24(a4)
        Scheduler::awake();
    800040d0:	00001097          	auipc	ra,0x1
    800040d4:	9a4080e7          	jalr	-1628(ra) # 80004a74 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    800040d8:	00005717          	auipc	a4,0x5
    800040dc:	9a873703          	ld	a4,-1624(a4) # 80008a80 <_GLOBAL_OFFSET_TABLE_+0x28>
    800040e0:	00073783          	ld	a5,0(a4)
    800040e4:	00178793          	addi	a5,a5,1
    800040e8:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    800040ec:	00005717          	auipc	a4,0x5
    800040f0:	a2473703          	ld	a4,-1500(a4) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800040f4:	00073703          	ld	a4,0(a4)
    800040f8:	03073683          	ld	a3,48(a4)
    800040fc:	00d7fc63          	bgeu	a5,a3,80004114 <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    80004100:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004104:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004108:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000410c:	14179073          	csrw	sepc,a5
}
    80004110:	e95ff06f          	j	80003fa4 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    80004114:	00005797          	auipc	a5,0x5
    80004118:	96c7b783          	ld	a5,-1684(a5) # 80008a80 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000411c:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004120:	00100793          	li	a5,1
    80004124:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80004128:	fffff097          	auipc	ra,0xfffff
    8000412c:	bb4080e7          	jalr	-1100(ra) # 80002cdc <_ZN3TCB8dispatchEv>
    80004130:	fd1ff06f          	j	80004100 <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004134:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004138:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000413c:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004140:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    80004144:	00005797          	auipc	a5,0x5
    80004148:	9247b783          	ld	a5,-1756(a5) # 80008a68 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000414c:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004150:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004154:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004158:	00058793          	mv	a5,a1
        if(status & 1UL)
    8000415c:	0017f793          	andi	a5,a5,1
    80004160:	02078863          	beqz	a5,80004190 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    80004164:	00005797          	auipc	a5,0x5
    80004168:	9447b783          	ld	a5,-1724(a5) # 80008aa8 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000416c:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004170:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004174:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004178:	00058513          	mv	a0,a1
    8000417c:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004180:	00005797          	auipc	a5,0x5
    80004184:	9307b783          	ld	a5,-1744(a5) # 80008ab0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004188:	0007b783          	ld	a5,0(a5)
    8000418c:	02079463          	bnez	a5,800041b4 <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    80004190:	00002097          	auipc	ra,0x2
    80004194:	824080e7          	jalr	-2012(ra) # 800059b4 <plic_claim>
    80004198:	00002097          	auipc	ra,0x2
    8000419c:	854080e7          	jalr	-1964(ra) # 800059ec <plic_complete>
        RiscV::w_sstatus(sstatus);
    800041a0:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800041a4:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    800041a8:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800041ac:	14179073          	csrw	sepc,a5
}
    800041b0:	df5ff06f          	j	80003fa4 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    800041b4:	fff78793          	addi	a5,a5,-1
    800041b8:	00005717          	auipc	a4,0x5
    800041bc:	8f873703          	ld	a4,-1800(a4) # 80008ab0 <_GLOBAL_OFFSET_TABLE_+0x58>
    800041c0:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    800041c4:	00001097          	auipc	ra,0x1
    800041c8:	a90080e7          	jalr	-1392(ra) # 80004c54 <_ZN11ConsoleUtil8putInputEc>
    800041cc:	fc5ff06f          	j	80004190 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    800041d0:	00005797          	auipc	a5,0x5
    800041d4:	9407b783          	ld	a5,-1728(a5) # 80008b10 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800041d8:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800041dc:	00200713          	li	a4,2
    800041e0:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    800041e4:	00004517          	auipc	a0,0x4
    800041e8:	1b450513          	addi	a0,a0,436 # 80008398 <CONSOLE_STATUS+0x388>
    800041ec:	00001097          	auipc	ra,0x1
    800041f0:	c48080e7          	jalr	-952(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800041f4:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800041f8:	00000613          	li	a2,0
    800041fc:	01000593          	li	a1,16
    80004200:	0005051b          	sext.w	a0,a0
    80004204:	00001097          	auipc	ra,0x1
    80004208:	c74080e7          	jalr	-908(ra) # 80004e78 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000420c:	00004517          	auipc	a0,0x4
    80004210:	18450513          	addi	a0,a0,388 # 80008390 <CONSOLE_STATUS+0x380>
    80004214:	00001097          	auipc	ra,0x1
    80004218:	c20080e7          	jalr	-992(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    8000421c:	00004517          	auipc	a0,0x4
    80004220:	18450513          	addi	a0,a0,388 # 800083a0 <CONSOLE_STATUS+0x390>
    80004224:	00001097          	auipc	ra,0x1
    80004228:	c10080e7          	jalr	-1008(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    8000422c:	fffff097          	auipc	ra,0xfffff
    80004230:	ab0080e7          	jalr	-1360(ra) # 80002cdc <_ZN3TCB8dispatchEv>
    80004234:	d71ff06f          	j	80003fa4 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

0000000080004238 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    80004238:	fd010113          	addi	sp,sp,-48
    8000423c:	02113423          	sd	ra,40(sp)
    80004240:	02813023          	sd	s0,32(sp)
    80004244:	00913c23          	sd	s1,24(sp)
    80004248:	01213823          	sd	s2,16(sp)
    8000424c:	01313423          	sd	s3,8(sp)
    80004250:	03010413          	addi	s0,sp,48
    80004254:	00050913          	mv	s2,a0
    80004258:	00058493          	mv	s1,a1
    8000425c:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    80004260:	00058e63          	beqz	a1,8000427c <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc(DEFAULT_STACK_SIZE);
    80004264:	00001537          	lui	a0,0x1
    80004268:	fffff097          	auipc	ra,0xfffff
    8000426c:	cf8080e7          	jalr	-776(ra) # 80002f60 <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    80004270:	00051863          	bnez	a0,80004280 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    80004274:	00093023          	sd	zero,0(s2)
            return;
    80004278:	0200006f          	j	80004298 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    8000427c:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80004280:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80004284:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80004288:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000428c:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80004290:	01100513          	li	a0,17

    asm("ecall");
    80004294:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    80004298:	02813083          	ld	ra,40(sp)
    8000429c:	02013403          	ld	s0,32(sp)
    800042a0:	01813483          	ld	s1,24(sp)
    800042a4:	01013903          	ld	s2,16(sp)
    800042a8:	00813983          	ld	s3,8(sp)
    800042ac:	03010113          	addi	sp,sp,48
    800042b0:	00008067          	ret

00000000800042b4 <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    800042b4:	ff010113          	addi	sp,sp,-16
    800042b8:	00813423          	sd	s0,8(sp)
    800042bc:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    800042c0:	01200513          	li	a0,18

    asm("ecall");
    800042c4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    800042c8:	00813403          	ld	s0,8(sp)
    800042cc:	01010113          	addi	sp,sp,16
    800042d0:	00008067          	ret

00000000800042d4 <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    800042d4:	ff010113          	addi	sp,sp,-16
    800042d8:	00813423          	sd	s0,8(sp)
    800042dc:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    800042e0:	01300513          	li	a0,19

    asm("ecall");
    800042e4:	00000073          	ecall
}
    800042e8:	00813403          	ld	s0,8(sp)
    800042ec:	01010113          	addi	sp,sp,16
    800042f0:	00008067          	ret

00000000800042f4 <_ZN5RiscV11putcWrapperEPv>:
{
    800042f4:	fe010113          	addi	sp,sp,-32
    800042f8:	00113c23          	sd	ra,24(sp)
    800042fc:	00813823          	sd	s0,16(sp)
    80004300:	02010413          	addi	s0,sp,32
    80004304:	00c0006f          	j	80004310 <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    80004308:	00000097          	auipc	ra,0x0
    8000430c:	fcc080e7          	jalr	-52(ra) # 800042d4 <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    80004310:	00004797          	auipc	a5,0x4
    80004314:	7587b783          	ld	a5,1880(a5) # 80008a68 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004318:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    8000431c:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004320:	00050583          	lb	a1,0(a0) # 1000 <_entry-0x7ffff000>
        asm("mv %[status], a1" : [status] "=r" (status));
    80004324:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80004328:	0207f793          	andi	a5,a5,32
    8000432c:	fc078ee3          	beqz	a5,80004308 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80004330:	00001097          	auipc	ra,0x1
    80004334:	c90080e7          	jalr	-880(ra) # 80004fc0 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80004338:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    8000433c:	00004797          	auipc	a5,0x4
    80004340:	7247b783          	ld	a5,1828(a5) # 80008a60 <_GLOBAL_OFFSET_TABLE_+0x8>
    80004344:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80004348:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    8000434c:	fef44783          	lbu	a5,-17(s0)
    80004350:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80004354:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80004358:	00004797          	auipc	a5,0x4
    8000435c:	7a87b783          	ld	a5,1960(a5) # 80008b00 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80004360:	0007b783          	ld	a5,0(a5)
    80004364:	fa0786e3          	beqz	a5,80004310 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80004368:	fff78793          	addi	a5,a5,-1
    8000436c:	00004717          	auipc	a4,0x4
    80004370:	79473703          	ld	a4,1940(a4) # 80008b00 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80004374:	00f73023          	sd	a5,0(a4)
    80004378:	f99ff06f          	j	80004310 <_ZN5RiscV11putcWrapperEPv+0x1c>

000000008000437c <_ZN5RiscV6getPMTEv>:

    RiscV::mapConsoleRegisters(uPMT);
    RiscV::ms_sstatus(1<<18);
}

void* RiscV::getPMT(){
    8000437c:	ff010113          	addi	sp,sp,-16
    80004380:	00113423          	sd	ra,8(sp)
    80004384:	00813023          	sd	s0,0(sp)
    80004388:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    8000438c:	00100513          	li	a0,1
    80004390:	ffffe097          	auipc	ra,0xffffe
    80004394:	358080e7          	jalr	856(ra) # 800026e8 <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80004398:	00000793          	li	a5,0
    8000439c:	1ff00713          	li	a4,511
    800043a0:	00f74c63          	blt	a4,a5,800043b8 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    800043a4:	00379713          	slli	a4,a5,0x3
    800043a8:	00e50733          	add	a4,a0,a4
    800043ac:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    800043b0:	0017879b          	addiw	a5,a5,1
    800043b4:	fe9ff06f          	j	8000439c <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    800043b8:	00813083          	ld	ra,8(sp)
    800043bc:	00013403          	ld	s0,0(sp)
    800043c0:	01010113          	addi	sp,sp,16
    800043c4:	00008067          	ret

00000000800043c8 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    800043c8:	fc010113          	addi	sp,sp,-64
    800043cc:	02113c23          	sd	ra,56(sp)
    800043d0:	02813823          	sd	s0,48(sp)
    800043d4:	02913423          	sd	s1,40(sp)
    800043d8:	03213023          	sd	s2,32(sp)
    800043dc:	01313c23          	sd	s3,24(sp)
    800043e0:	01413823          	sd	s4,16(sp)
    800043e4:	01513423          	sd	s5,8(sp)
    800043e8:	04010413          	addi	s0,sp,64
    800043ec:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    800043f0:	01e5d793          	srli	a5,a1,0x1e
    800043f4:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    800043f8:	0155d913          	srli	s2,a1,0x15
    800043fc:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    80004400:	00c5d493          	srli	s1,a1,0xc
    80004404:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80004408:	00379793          	slli	a5,a5,0x3
    8000440c:	00f50ab3          	add	s5,a0,a5
    80004410:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80004414:	06078263          	beqz	a5,80004478 <_ZN5RiscV15handlePageFaultEPvmm+0xb0>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80004418:	00a7d513          	srli	a0,a5,0xa
    8000441c:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    80004420:	00391913          	slli	s2,s2,0x3
    80004424:	01250933          	add	s2,a0,s2
    80004428:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    8000442c:	06050463          	beqz	a0,80004494 <_ZN5RiscV15handlePageFaultEPvmm+0xcc>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    80004430:	00a55513          	srli	a0,a0,0xa
    80004434:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    80004438:	003a1a13          	slli	s4,s4,0x3
    8000443c:	01450533          	add	a0,a0,s4
    80004440:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0) {
    80004444:	00079863          	bnez	a5,80004454 <_ZN5RiscV15handlePageFaultEPvmm+0x8c>
        ((uint64 *) pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    80004448:	00a49493          	slli	s1,s1,0xa
    8000444c:	0134e9b3          	or	s3,s1,s3
    80004450:	01353023          	sd	s3,0(a0)
    }
}
    80004454:	03813083          	ld	ra,56(sp)
    80004458:	03013403          	ld	s0,48(sp)
    8000445c:	02813483          	ld	s1,40(sp)
    80004460:	02013903          	ld	s2,32(sp)
    80004464:	01813983          	ld	s3,24(sp)
    80004468:	01013a03          	ld	s4,16(sp)
    8000446c:	00813a83          	ld	s5,8(sp)
    80004470:	04010113          	addi	sp,sp,64
    80004474:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80004478:	00000097          	auipc	ra,0x0
    8000447c:	f04080e7          	jalr	-252(ra) # 8000437c <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    80004480:	00c55793          	srli	a5,a0,0xc
    80004484:	00a79793          	slli	a5,a5,0xa
    80004488:	0017e793          	ori	a5,a5,1
    8000448c:	00fab023          	sd	a5,0(s5)
    80004490:	f91ff06f          	j	80004420 <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    80004494:	00000097          	auipc	ra,0x0
    80004498:	ee8080e7          	jalr	-280(ra) # 8000437c <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    8000449c:	00c55793          	srli	a5,a0,0xc
    800044a0:	00a79793          	slli	a5,a5,0xa
    800044a4:	0017e793          	ori	a5,a5,1
    800044a8:	00f93023          	sd	a5,0(s2)
    800044ac:	f8dff06f          	j	80004438 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

00000000800044b0 <_ZN5RiscV12buildSectionEPvmmm>:
void RiscV::buildSection(void *PMT, uint64 start, uint64 end, uint64 mask) {
    800044b0:	fd010113          	addi	sp,sp,-48
    800044b4:	02113423          	sd	ra,40(sp)
    800044b8:	02813023          	sd	s0,32(sp)
    800044bc:	00913c23          	sd	s1,24(sp)
    800044c0:	01213823          	sd	s2,16(sp)
    800044c4:	01313423          	sd	s3,8(sp)
    800044c8:	01413023          	sd	s4,0(sp)
    800044cc:	03010413          	addi	s0,sp,48
    800044d0:	00050a13          	mv	s4,a0
    800044d4:	00058493          	mv	s1,a1
    800044d8:	00060913          	mv	s2,a2
    800044dc:	00068993          	mv	s3,a3
    for(uint64 i=start;i< end;i+=0x1000) {
    800044e0:	0324f263          	bgeu	s1,s2,80004504 <_ZN5RiscV12buildSectionEPvmmm+0x54>
        handlePageFault(PMT,i, mask);
    800044e4:	00098613          	mv	a2,s3
    800044e8:	00048593          	mv	a1,s1
    800044ec:	000a0513          	mv	a0,s4
    800044f0:	00000097          	auipc	ra,0x0
    800044f4:	ed8080e7          	jalr	-296(ra) # 800043c8 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=start;i< end;i+=0x1000) {
    800044f8:	000017b7          	lui	a5,0x1
    800044fc:	00f484b3          	add	s1,s1,a5
    80004500:	fe1ff06f          	j	800044e0 <_ZN5RiscV12buildSectionEPvmmm+0x30>
}
    80004504:	02813083          	ld	ra,40(sp)
    80004508:	02013403          	ld	s0,32(sp)
    8000450c:	01813483          	ld	s1,24(sp)
    80004510:	01013903          	ld	s2,16(sp)
    80004514:	00813983          	ld	s3,8(sp)
    80004518:	00013a03          	ld	s4,0(sp)
    8000451c:	03010113          	addi	sp,sp,48
    80004520:	00008067          	ret

0000000080004524 <_ZN5RiscV19mapConsoleRegistersEPv>:

void RiscV::mapConsoleRegisters(void *PMT) {
    80004524:	fe010113          	addi	sp,sp,-32
    80004528:	00113c23          	sd	ra,24(sp)
    8000452c:	00813823          	sd	s0,16(sp)
    80004530:	00913423          	sd	s1,8(sp)
    80004534:	02010413          	addi	s0,sp,32
    80004538:	00050493          	mv	s1,a0
    handlePageFault(PMT, (uint64)CONSOLE_RX_DATA,0xf);
    8000453c:	00f00613          	li	a2,15
    80004540:	00004797          	auipc	a5,0x4
    80004544:	5207b783          	ld	a5,1312(a5) # 80008a60 <_GLOBAL_OFFSET_TABLE_+0x8>
    80004548:	0007b583          	ld	a1,0(a5)
    8000454c:	00000097          	auipc	ra,0x0
    80004550:	e7c080e7          	jalr	-388(ra) # 800043c8 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_TX_DATA,0xf);
    80004554:	00f00613          	li	a2,15
    80004558:	00004797          	auipc	a5,0x4
    8000455c:	5507b783          	ld	a5,1360(a5) # 80008aa8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004560:	0007b583          	ld	a1,0(a5)
    80004564:	00048513          	mv	a0,s1
    80004568:	00000097          	auipc	ra,0x0
    8000456c:	e60080e7          	jalr	-416(ra) # 800043c8 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_STATUS,0xf);
    80004570:	00f00613          	li	a2,15
    80004574:	00004797          	auipc	a5,0x4
    80004578:	4f47b783          	ld	a5,1268(a5) # 80008a68 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000457c:	0007b583          	ld	a1,0(a5)
    80004580:	00048513          	mv	a0,s1
    80004584:	00000097          	auipc	ra,0x0
    80004588:	e44080e7          	jalr	-444(ra) # 800043c8 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)0xc201004,0xf);
    8000458c:	00f00613          	li	a2,15
    80004590:	0c2015b7          	lui	a1,0xc201
    80004594:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    80004598:	00048513          	mv	a0,s1
    8000459c:	00000097          	auipc	ra,0x0
    800045a0:	e2c080e7          	jalr	-468(ra) # 800043c8 <_ZN5RiscV15handlePageFaultEPvmm>
    800045a4:	01813083          	ld	ra,24(sp)
    800045a8:	01013403          	ld	s0,16(sp)
    800045ac:	00813483          	ld	s1,8(sp)
    800045b0:	02010113          	addi	sp,sp,32
    800045b4:	00008067          	ret

00000000800045b8 <_ZN5RiscV14buildKernelPMTEv>:
void RiscV::buildKernelPMT() {
    800045b8:	fd010113          	addi	sp,sp,-48
    800045bc:	02113423          	sd	ra,40(sp)
    800045c0:	02813023          	sd	s0,32(sp)
    800045c4:	00913c23          	sd	s1,24(sp)
    800045c8:	01213823          	sd	s2,16(sp)
    800045cc:	01313423          	sd	s3,8(sp)
    800045d0:	01413023          	sd	s4,0(sp)
    800045d4:	03010413          	addi	s0,sp,48
    RiscV::kPMT = RiscV::getPMT();
    800045d8:	00000097          	auipc	ra,0x0
    800045dc:	da4080e7          	jalr	-604(ra) # 8000437c <_ZN5RiscV6getPMTEv>
    800045e0:	00004497          	auipc	s1,0x4
    800045e4:	76848493          	addi	s1,s1,1896 # 80008d48 <_ZN5RiscV16userMainFinishedE>
    800045e8:	00a4b423          	sd	a0,8(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    800045ec:	00004797          	auipc	a5,0x4
    800045f0:	4a47b783          	ld	a5,1188(a5) # 80008a90 <_GLOBAL_OFFSET_TABLE_+0x38>
    800045f4:	0007b903          	ld	s2,0(a5)
    800045f8:	00c91913          	slli	s2,s2,0xc
    800045fc:	00004797          	auipc	a5,0x4
    80004600:	4a47b783          	ld	a5,1188(a5) # 80008aa0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004604:	0007b783          	ld	a5,0(a5)
    80004608:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(kPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    8000460c:	00004a17          	auipc	s4,0x4
    80004610:	46ca3a03          	ld	s4,1132(s4) # 80008a78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004614:	00b00693          	li	a3,11
    80004618:	000a0613          	mv	a2,s4
    8000461c:	00100593          	li	a1,1
    80004620:	01f59593          	slli	a1,a1,0x1f
    80004624:	00000097          	auipc	ra,0x0
    80004628:	e8c080e7          	jalr	-372(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    8000462c:	00004997          	auipc	s3,0x4
    80004630:	4ec9b983          	ld	s3,1260(s3) # 80008b18 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004634:	00700693          	li	a3,7
    80004638:	00098613          	mv	a2,s3
    8000463c:	000a0593          	mv	a1,s4
    80004640:	0084b503          	ld	a0,8(s1)
    80004644:	00000097          	auipc	ra,0x0
    80004648:	e6c080e7          	jalr	-404(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    8000464c:	00004a17          	auipc	s4,0x4
    80004650:	4eca3a03          	ld	s4,1260(s4) # 80008b38 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80004654:	01b00693          	li	a3,27
    80004658:	000a0613          	mv	a2,s4
    8000465c:	00098593          	mv	a1,s3
    80004660:	0084b503          	ld	a0,8(s1)
    80004664:	00000097          	auipc	ra,0x0
    80004668:	e4c080e7          	jalr	-436(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_START, USER_DATA_END, 0x17);
    8000466c:	00004997          	auipc	s3,0x4
    80004670:	41c9b983          	ld	s3,1052(s3) # 80008a88 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004674:	01700693          	li	a3,23
    80004678:	00098613          	mv	a2,s3
    8000467c:	000a0593          	mv	a1,s4
    80004680:	0084b503          	ld	a0,8(s1)
    80004684:	00000097          	auipc	ra,0x0
    80004688:	e2c080e7          	jalr	-468(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_END, bEnd, 0x7);
    8000468c:	00700693          	li	a3,7
    80004690:	00090613          	mv	a2,s2
    80004694:	00098593          	mv	a1,s3
    80004698:	0084b503          	ld	a0,8(s1)
    8000469c:	00000097          	auipc	ra,0x0
    800046a0:	e14080e7          	jalr	-492(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, bEnd, HEAP_END, 0x17);
    800046a4:	01700693          	li	a3,23
    800046a8:	00004797          	auipc	a5,0x4
    800046ac:	4807b783          	ld	a5,1152(a5) # 80008b28 <_GLOBAL_OFFSET_TABLE_+0xd0>
    800046b0:	0007b603          	ld	a2,0(a5)
    800046b4:	00090593          	mv	a1,s2
    800046b8:	0084b503          	ld	a0,8(s1)
    800046bc:	00000097          	auipc	ra,0x0
    800046c0:	df4080e7          	jalr	-524(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(kPMT);
    800046c4:	0084b503          	ld	a0,8(s1)
    800046c8:	00000097          	auipc	ra,0x0
    800046cc:	e5c080e7          	jalr	-420(ra) # 80004524 <_ZN5RiscV19mapConsoleRegistersEPv>
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800046d0:	000407b7          	lui	a5,0x40
    800046d4:	1007a073          	csrs	sstatus,a5
}
    800046d8:	02813083          	ld	ra,40(sp)
    800046dc:	02013403          	ld	s0,32(sp)
    800046e0:	01813483          	ld	s1,24(sp)
    800046e4:	01013903          	ld	s2,16(sp)
    800046e8:	00813983          	ld	s3,8(sp)
    800046ec:	00013a03          	ld	s4,0(sp)
    800046f0:	03010113          	addi	sp,sp,48
    800046f4:	00008067          	ret

00000000800046f8 <_ZN5RiscV12buildUserPMTEv>:
void RiscV::buildUserPMT() {
    800046f8:	fd010113          	addi	sp,sp,-48
    800046fc:	02113423          	sd	ra,40(sp)
    80004700:	02813023          	sd	s0,32(sp)
    80004704:	00913c23          	sd	s1,24(sp)
    80004708:	01213823          	sd	s2,16(sp)
    8000470c:	01313423          	sd	s3,8(sp)
    80004710:	01413023          	sd	s4,0(sp)
    80004714:	03010413          	addi	s0,sp,48
    RiscV::uPMT = RiscV::getPMT();
    80004718:	00000097          	auipc	ra,0x0
    8000471c:	c64080e7          	jalr	-924(ra) # 8000437c <_ZN5RiscV6getPMTEv>
    80004720:	00004497          	auipc	s1,0x4
    80004724:	62848493          	addi	s1,s1,1576 # 80008d48 <_ZN5RiscV16userMainFinishedE>
    80004728:	00a4b823          	sd	a0,16(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    8000472c:	00004797          	auipc	a5,0x4
    80004730:	3647b783          	ld	a5,868(a5) # 80008a90 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004734:	0007b903          	ld	s2,0(a5)
    80004738:	00c91913          	slli	s2,s2,0xc
    8000473c:	00004797          	auipc	a5,0x4
    80004740:	3647b783          	ld	a5,868(a5) # 80008aa0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004744:	0007b783          	ld	a5,0(a5)
    80004748:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(uPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    8000474c:	00004a17          	auipc	s4,0x4
    80004750:	32ca3a03          	ld	s4,812(s4) # 80008a78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004754:	00b00693          	li	a3,11
    80004758:	000a0613          	mv	a2,s4
    8000475c:	00100593          	li	a1,1
    80004760:	01f59593          	slli	a1,a1,0x1f
    80004764:	00000097          	auipc	ra,0x0
    80004768:	d4c080e7          	jalr	-692(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    8000476c:	00004997          	auipc	s3,0x4
    80004770:	3ac9b983          	ld	s3,940(s3) # 80008b18 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004774:	00700693          	li	a3,7
    80004778:	00098613          	mv	a2,s3
    8000477c:	000a0593          	mv	a1,s4
    80004780:	0104b503          	ld	a0,16(s1)
    80004784:	00000097          	auipc	ra,0x0
    80004788:	d2c080e7          	jalr	-724(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    8000478c:	00004a17          	auipc	s4,0x4
    80004790:	3aca3a03          	ld	s4,940(s4) # 80008b38 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80004794:	01b00693          	li	a3,27
    80004798:	000a0613          	mv	a2,s4
    8000479c:	00098593          	mv	a1,s3
    800047a0:	0104b503          	ld	a0,16(s1)
    800047a4:	00000097          	auipc	ra,0x0
    800047a8:	d0c080e7          	jalr	-756(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_START, USER_DATA_END, 0x17);
    800047ac:	00004997          	auipc	s3,0x4
    800047b0:	2dc9b983          	ld	s3,732(s3) # 80008a88 <_GLOBAL_OFFSET_TABLE_+0x30>
    800047b4:	01700693          	li	a3,23
    800047b8:	00098613          	mv	a2,s3
    800047bc:	000a0593          	mv	a1,s4
    800047c0:	0104b503          	ld	a0,16(s1)
    800047c4:	00000097          	auipc	ra,0x0
    800047c8:	cec080e7          	jalr	-788(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_END, bEnd, 0x7);
    800047cc:	00700693          	li	a3,7
    800047d0:	00090613          	mv	a2,s2
    800047d4:	00098593          	mv	a1,s3
    800047d8:	0104b503          	ld	a0,16(s1)
    800047dc:	00000097          	auipc	ra,0x0
    800047e0:	cd4080e7          	jalr	-812(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, bEnd, HEAP_END, 0x17);
    800047e4:	01700693          	li	a3,23
    800047e8:	00004797          	auipc	a5,0x4
    800047ec:	3407b783          	ld	a5,832(a5) # 80008b28 <_GLOBAL_OFFSET_TABLE_+0xd0>
    800047f0:	0007b603          	ld	a2,0(a5)
    800047f4:	00090593          	mv	a1,s2
    800047f8:	0104b503          	ld	a0,16(s1)
    800047fc:	00000097          	auipc	ra,0x0
    80004800:	cb4080e7          	jalr	-844(ra) # 800044b0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(uPMT);
    80004804:	0104b503          	ld	a0,16(s1)
    80004808:	00000097          	auipc	ra,0x0
    8000480c:	d1c080e7          	jalr	-740(ra) # 80004524 <_ZN5RiscV19mapConsoleRegistersEPv>
    80004810:	000407b7          	lui	a5,0x40
    80004814:	1007a073          	csrs	sstatus,a5
}
    80004818:	02813083          	ld	ra,40(sp)
    8000481c:	02013403          	ld	s0,32(sp)
    80004820:	01813483          	ld	s1,24(sp)
    80004824:	01013903          	ld	s2,16(sp)
    80004828:	00813983          	ld	s3,8(sp)
    8000482c:	00013a03          	ld	s4,0(sp)
    80004830:	03010113          	addi	sp,sp,48
    80004834:	00008067          	ret

0000000080004838 <_ZN5RiscV10initializeEv>:
void RiscV::initialize(){
    80004838:	ff010113          	addi	sp,sp,-16
    8000483c:	00113423          	sd	ra,8(sp)
    80004840:	00813023          	sd	s0,0(sp)
    80004844:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80004848:	00004797          	auipc	a5,0x4
    8000484c:	2a07b783          	ld	a5,672(a5) # 80008ae8 <_GLOBAL_OFFSET_TABLE_+0x90>
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80004850:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80004854:	00004797          	auipc	a5,0x4
    80004858:	21c7b783          	ld	a5,540(a5) # 80008a70 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000485c:	0007b503          	ld	a0,0(a5)
    80004860:	00c55513          	srli	a0,a0,0xc
    80004864:	00250513          	addi	a0,a0,2
    80004868:	000015b7          	lui	a1,0x1
    8000486c:	00c51513          	slli	a0,a0,0xc
    80004870:	00000097          	auipc	ra,0x0
    80004874:	778080e7          	jalr	1912(ra) # 80004fe8 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80004878:	ffffe097          	auipc	ra,0xffffe
    8000487c:	668080e7          	jalr	1640(ra) # 80002ee0 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80004880:	00000097          	auipc	ra,0x0
    80004884:	108080e7          	jalr	264(ra) # 80004988 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80004888:	ffffe097          	auipc	ra,0xffffe
    8000488c:	504080e7          	jalr	1284(ra) # 80002d8c <_ZN3TCB10initializeEv>
    SCB::initialize();
    80004890:	ffffe097          	auipc	ra,0xffffe
    80004894:	03c080e7          	jalr	60(ra) # 800028cc <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80004898:	00000097          	auipc	ra,0x0
    8000489c:	304080e7          	jalr	772(ra) # 80004b9c <_ZN11ConsoleUtil10initializeEv>
    RiscV::buildKernelPMT();
    800048a0:	00000097          	auipc	ra,0x0
    800048a4:	d18080e7          	jalr	-744(ra) # 800045b8 <_ZN5RiscV14buildKernelPMTEv>
    RiscV::buildUserPMT();
    800048a8:	00000097          	auipc	ra,0x0
    800048ac:	e50080e7          	jalr	-432(ra) # 800046f8 <_ZN5RiscV12buildUserPMTEv>
    RiscV::initialized = true;
    800048b0:	00004797          	auipc	a5,0x4
    800048b4:	49878793          	addi	a5,a5,1176 # 80008d48 <_ZN5RiscV16userMainFinishedE>
    800048b8:	00100713          	li	a4,1
    800048bc:	02e78023          	sb	a4,32(a5)
    RiscV::startVirtualMemory(RiscV::kPMT);
    800048c0:	0087b783          	ld	a5,8(a5)
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    800048c4:	00c7d793          	srli	a5,a5,0xc
    800048c8:	fff00713          	li	a4,-1
    800048cc:	03f71713          	slli	a4,a4,0x3f
    800048d0:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    800048d4:	18079073          	csrw	satp,a5
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    800048d8:	00200793          	li	a5,2
    800048dc:	1047a073          	csrs	sie,a5
    800048e0:	20000713          	li	a4,512
    800048e4:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800048e8:	1007a073          	csrs	sstatus,a5
}
    800048ec:	00813083          	ld	ra,8(sp)
    800048f0:	00013403          	ld	s0,0(sp)
    800048f4:	01010113          	addi	sp,sp,16
    800048f8:	00008067          	ret

00000000800048fc <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    800048fc:	ff010113          	addi	sp,sp,-16
    80004900:	00813423          	sd	s0,8(sp)
    80004904:	01010413          	addi	s0,sp,16
    80004908:	00050793          	mv	a5,a0
    8000490c:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004910:	0007c703          	lbu	a4,0(a5)
    80004914:	00070a63          	beqz	a4,80004928 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004918:	00178793          	addi	a5,a5,1
    8000491c:	00e50023          	sb	a4,0(a0)
    80004920:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004924:	fedff06f          	j	80004910 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004928:	00e50023          	sb	a4,0(a0)
    return dst;
}
    8000492c:	00813403          	ld	s0,8(sp)
    80004930:	01010113          	addi	sp,sp,16
    80004934:	00008067          	ret

0000000080004938 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004938:	fe010113          	addi	sp,sp,-32
    8000493c:	00113c23          	sd	ra,24(sp)
    80004940:	00813823          	sd	s0,16(sp)
    80004944:	00913423          	sd	s1,8(sp)
    80004948:	02010413          	addi	s0,sp,32
    8000494c:	00050493          	mv	s1,a0
    80004950:	00058513          	mv	a0,a1
    char *dest = dst;
    80004954:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004958:	0005c783          	lbu	a5,0(a1) # 1000 <_entry-0x7ffff000>
    8000495c:	00078663          	beqz	a5,80004968 <_Z6strcatPcPKc+0x30>
        dest++;
    80004960:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004964:	ff5ff06f          	j	80004958 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004968:	00000097          	auipc	ra,0x0
    8000496c:	f94080e7          	jalr	-108(ra) # 800048fc <_Z6strcpyPKcPc>
    return dst;
    80004970:	00048513          	mv	a0,s1
    80004974:	01813083          	ld	ra,24(sp)
    80004978:	01013403          	ld	s0,16(sp)
    8000497c:	00813483          	ld	s1,8(sp)
    80004980:	02010113          	addi	sp,sp,32
    80004984:	00008067          	ret

0000000080004988 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004988:	ff010113          	addi	sp,sp,-16
    8000498c:	00813423          	sd	s0,8(sp)
    80004990:	01010413          	addi	s0,sp,16
}
    80004994:	00813403          	ld	s0,8(sp)
    80004998:	01010113          	addi	sp,sp,16
    8000499c:	00008067          	ret

00000000800049a0 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    800049a0:	ff010113          	addi	sp,sp,-16
    800049a4:	00813423          	sd	s0,8(sp)
    800049a8:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    800049ac:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800049b0:	00004797          	auipc	a5,0x4
    800049b4:	3c07b783          	ld	a5,960(a5) # 80008d70 <_ZN9Scheduler9readyHeadE>
    800049b8:	02078263          	beqz	a5,800049dc <_ZN9Scheduler3putEP3TCB+0x3c>
    800049bc:	00004797          	auipc	a5,0x4
    800049c0:	3bc7b783          	ld	a5,956(a5) # 80008d78 <_ZN9Scheduler9readyTailE>
    800049c4:	04a7b423          	sd	a0,72(a5)
    800049c8:	00004797          	auipc	a5,0x4
    800049cc:	3aa7b823          	sd	a0,944(a5) # 80008d78 <_ZN9Scheduler9readyTailE>
}
    800049d0:	00813403          	ld	s0,8(sp)
    800049d4:	01010113          	addi	sp,sp,16
    800049d8:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800049dc:	00004797          	auipc	a5,0x4
    800049e0:	38a7ba23          	sd	a0,916(a5) # 80008d70 <_ZN9Scheduler9readyHeadE>
    800049e4:	fe5ff06f          	j	800049c8 <_ZN9Scheduler3putEP3TCB+0x28>

00000000800049e8 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    800049e8:	ff010113          	addi	sp,sp,-16
    800049ec:	00813423          	sd	s0,8(sp)
    800049f0:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    800049f4:	00004517          	auipc	a0,0x4
    800049f8:	37c53503          	ld	a0,892(a0) # 80008d70 <_ZN9Scheduler9readyHeadE>
    800049fc:	00050a63          	beqz	a0,80004a10 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004a00:	04853783          	ld	a5,72(a0)
    80004a04:	00004717          	auipc	a4,0x4
    80004a08:	36f73623          	sd	a5,876(a4) # 80008d70 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004a0c:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004a10:	00813403          	ld	s0,8(sp)
    80004a14:	01010113          	addi	sp,sp,16
    80004a18:	00008067          	ret

0000000080004a1c <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004a1c:	ff010113          	addi	sp,sp,-16
    80004a20:	00813423          	sd	s0,8(sp)
    80004a24:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004a28:	00004797          	auipc	a5,0x4
    80004a2c:	3587b783          	ld	a5,856(a5) # 80008d80 <_ZN9Scheduler12sleepingHeadE>
    80004a30:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004a34:	00078e63          	beqz	a5,80004a50 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004a38:	0587b683          	ld	a3,88(a5)
    80004a3c:	05853703          	ld	a4,88(a0)
    80004a40:	00d76863          	bltu	a4,a3,80004a50 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004a44:	00078613          	mv	a2,a5
    80004a48:	0487b783          	ld	a5,72(a5)
    80004a4c:	fe9ff06f          	j	80004a34 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004a50:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004a54:	00060a63          	beqz	a2,80004a68 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004a58:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    80004a5c:	00813403          	ld	s0,8(sp)
    80004a60:	01010113          	addi	sp,sp,16
    80004a64:	00008067          	ret
        sleepingHead = t;
    80004a68:	00004797          	auipc	a5,0x4
    80004a6c:	30a7bc23          	sd	a0,792(a5) # 80008d80 <_ZN9Scheduler12sleepingHeadE>
}
    80004a70:	fedff06f          	j	80004a5c <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004a74 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004a74:	fe010113          	addi	sp,sp,-32
    80004a78:	00113c23          	sd	ra,24(sp)
    80004a7c:	00813823          	sd	s0,16(sp)
    80004a80:	00913423          	sd	s1,8(sp)
    80004a84:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004a88:	00004497          	auipc	s1,0x4
    80004a8c:	2f84b483          	ld	s1,760(s1) # 80008d80 <_ZN9Scheduler12sleepingHeadE>
    80004a90:	02048c63          	beqz	s1,80004ac8 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004a94:	0584b703          	ld	a4,88(s1)
    80004a98:	00004797          	auipc	a5,0x4
    80004a9c:	0987b783          	ld	a5,152(a5) # 80008b30 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80004aa0:	0007b783          	ld	a5,0(a5)
    80004aa4:	02e7e263          	bltu	a5,a4,80004ac8 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004aa8:	0484b783          	ld	a5,72(s1)
    80004aac:	00004717          	auipc	a4,0x4
    80004ab0:	2cf73a23          	sd	a5,724(a4) # 80008d80 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004ab4:	00048513          	mv	a0,s1
    80004ab8:	00000097          	auipc	ra,0x0
    80004abc:	ee8080e7          	jalr	-280(ra) # 800049a0 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004ac0:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004ac4:	fc5ff06f          	j	80004a88 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004ac8:	01813083          	ld	ra,24(sp)
    80004acc:	01013403          	ld	s0,16(sp)
    80004ad0:	00813483          	ld	s1,8(sp)
    80004ad4:	02010113          	addi	sp,sp,32
    80004ad8:	00008067          	ret

0000000080004adc <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004adc:	fe010113          	addi	sp,sp,-32
    80004ae0:	00113c23          	sd	ra,24(sp)
    80004ae4:	00813823          	sd	s0,16(sp)
    80004ae8:	00913423          	sd	s1,8(sp)
    80004aec:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004af0:	00004497          	auipc	s1,0x4
    80004af4:	2804b483          	ld	s1,640(s1) # 80008d70 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004af8:	02048863          	beqz	s1,80004b28 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004afc:	00000613          	li	a2,0
    80004b00:	01000593          	li	a1,16
    80004b04:	0004851b          	sext.w	a0,s1
    80004b08:	00000097          	auipc	ra,0x0
    80004b0c:	370080e7          	jalr	880(ra) # 80004e78 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004b10:	00004517          	auipc	a0,0x4
    80004b14:	88050513          	addi	a0,a0,-1920 # 80008390 <CONSOLE_STATUS+0x380>
    80004b18:	00000097          	auipc	ra,0x0
    80004b1c:	31c080e7          	jalr	796(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004b20:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004b24:	fd5ff06f          	j	80004af8 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004b28:	01813083          	ld	ra,24(sp)
    80004b2c:	01013403          	ld	s0,16(sp)
    80004b30:	00813483          	ld	s1,8(sp)
    80004b34:	02010113          	addi	sp,sp,32
    80004b38:	00008067          	ret

0000000080004b3c <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004b3c:	fe010113          	addi	sp,sp,-32
    80004b40:	00113c23          	sd	ra,24(sp)
    80004b44:	00813823          	sd	s0,16(sp)
    80004b48:	00913423          	sd	s1,8(sp)
    80004b4c:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004b50:	00004497          	auipc	s1,0x4
    80004b54:	2304b483          	ld	s1,560(s1) # 80008d80 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004b58:	02048863          	beqz	s1,80004b88 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004b5c:	00000613          	li	a2,0
    80004b60:	01000593          	li	a1,16
    80004b64:	0004851b          	sext.w	a0,s1
    80004b68:	0000d097          	auipc	ra,0xd
    80004b6c:	ac4080e7          	jalr	-1340(ra) # 8001162c <_Z8printIntiii>
        printString("\n");
    80004b70:	00004517          	auipc	a0,0x4
    80004b74:	82050513          	addi	a0,a0,-2016 # 80008390 <CONSOLE_STATUS+0x380>
    80004b78:	0000d097          	auipc	ra,0xd
    80004b7c:	91c080e7          	jalr	-1764(ra) # 80011494 <_Z11printStringPKc>
        iter = iter->next;
    80004b80:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004b84:	fd5ff06f          	j	80004b58 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004b88:	01813083          	ld	ra,24(sp)
    80004b8c:	01013403          	ld	s0,16(sp)
    80004b90:	00813483          	ld	s1,8(sp)
    80004b94:	02010113          	addi	sp,sp,32
    80004b98:	00008067          	ret

0000000080004b9c <_ZN11ConsoleUtil10initializeEv>:
char ConsoleUtil::inputBuffer[8192];
char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    80004b9c:	fe010113          	addi	sp,sp,-32
    80004ba0:	00113c23          	sd	ra,24(sp)
    80004ba4:	00813823          	sd	s0,16(sp)
    80004ba8:	00913423          	sd	s1,8(sp)
    80004bac:	01213023          	sd	s2,0(sp)
    80004bb0:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004bb4:	01800513          	li	a0,24
    80004bb8:	ffffe097          	auipc	ra,0xffffe
    80004bbc:	f14080e7          	jalr	-236(ra) # 80002acc <_ZN3SCBnwEm>
    80004bc0:	00050493          	mv	s1,a0
    80004bc4:	00050863          	beqz	a0,80004bd4 <_ZN11ConsoleUtil10initializeEv+0x38>
    80004bc8:	00000593          	li	a1,0
    80004bcc:	ffffe097          	auipc	ra,0xffffe
    80004bd0:	d4c080e7          	jalr	-692(ra) # 80002918 <_ZN3SCBC1Em>
    80004bd4:	00004797          	auipc	a5,0x4
    80004bd8:	1a97ba23          	sd	s1,436(a5) # 80008d88 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004bdc:	01800513          	li	a0,24
    80004be0:	ffffe097          	auipc	ra,0xffffe
    80004be4:	eec080e7          	jalr	-276(ra) # 80002acc <_ZN3SCBnwEm>
    80004be8:	00050493          	mv	s1,a0
    80004bec:	00050863          	beqz	a0,80004bfc <_ZN11ConsoleUtil10initializeEv+0x60>
    80004bf0:	00000593          	li	a1,0
    80004bf4:	ffffe097          	auipc	ra,0xffffe
    80004bf8:	d24080e7          	jalr	-732(ra) # 80002918 <_ZN3SCBC1Em>
    80004bfc:	00004797          	auipc	a5,0x4
    80004c00:	1897ba23          	sd	s1,404(a5) # 80008d90 <_ZN11ConsoleUtil9outputSemE>
//    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
//    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
}
    80004c04:	01813083          	ld	ra,24(sp)
    80004c08:	01013403          	ld	s0,16(sp)
    80004c0c:	00813483          	ld	s1,8(sp)
    80004c10:	00013903          	ld	s2,0(sp)
    80004c14:	02010113          	addi	sp,sp,32
    80004c18:	00008067          	ret
    80004c1c:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004c20:	00048513          	mv	a0,s1
    80004c24:	ffffe097          	auipc	ra,0xffffe
    80004c28:	ed8080e7          	jalr	-296(ra) # 80002afc <_ZN3SCBdlEPv>
    80004c2c:	00090513          	mv	a0,s2
    80004c30:	00009097          	auipc	ra,0x9
    80004c34:	268080e7          	jalr	616(ra) # 8000de98 <_Unwind_Resume>
    80004c38:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004c3c:	00048513          	mv	a0,s1
    80004c40:	ffffe097          	auipc	ra,0xffffe
    80004c44:	ebc080e7          	jalr	-324(ra) # 80002afc <_ZN3SCBdlEPv>
    80004c48:	00090513          	mv	a0,s2
    80004c4c:	00009097          	auipc	ra,0x9
    80004c50:	24c080e7          	jalr	588(ra) # 8000de98 <_Unwind_Resume>

0000000080004c54 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004c54:	00004717          	auipc	a4,0x4
    80004c58:	13470713          	addi	a4,a4,308 # 80008d88 <_ZN11ConsoleUtil8inputSemE>
    80004c5c:	01073683          	ld	a3,16(a4)
    80004c60:	00168793          	addi	a5,a3,1
    80004c64:	00004617          	auipc	a2,0x4
    80004c68:	dec63603          	ld	a2,-532(a2) # 80008a50 <_ZN11ConsoleUtil10bufferSizeE>
    80004c6c:	02c7f7b3          	remu	a5,a5,a2
    80004c70:	01873703          	ld	a4,24(a4)
    80004c74:	04e78663          	beq	a5,a4,80004cc0 <_ZN11ConsoleUtil8putInputEc+0x6c>
void ConsoleUtil::putInput(char c) {
    80004c78:	ff010113          	addi	sp,sp,-16
    80004c7c:	00113423          	sd	ra,8(sp)
    80004c80:	00813023          	sd	s0,0(sp)
    80004c84:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004c88:	00006717          	auipc	a4,0x6
    80004c8c:	13870713          	addi	a4,a4,312 # 8000adc0 <_ZN11ConsoleUtil11inputBufferE>
    80004c90:	00d706b3          	add	a3,a4,a3
    80004c94:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    80004c98:	00004717          	auipc	a4,0x4
    80004c9c:	0f070713          	addi	a4,a4,240 # 80008d88 <_ZN11ConsoleUtil8inputSemE>
    80004ca0:	00f73823          	sd	a5,16(a4)
    inputSem->signal();
    80004ca4:	00073503          	ld	a0,0(a4)
    80004ca8:	ffffe097          	auipc	ra,0xffffe
    80004cac:	de8080e7          	jalr	-536(ra) # 80002a90 <_ZN3SCB6signalEv>
}
    80004cb0:	00813083          	ld	ra,8(sp)
    80004cb4:	00013403          	ld	s0,0(sp)
    80004cb8:	01010113          	addi	sp,sp,16
    80004cbc:	00008067          	ret
    80004cc0:	00008067          	ret

0000000080004cc4 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004cc4:	fe010113          	addi	sp,sp,-32
    80004cc8:	00113c23          	sd	ra,24(sp)
    80004ccc:	00813823          	sd	s0,16(sp)
    80004cd0:	00913423          	sd	s1,8(sp)
    80004cd4:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004cd8:	00004497          	auipc	s1,0x4
    80004cdc:	0b048493          	addi	s1,s1,176 # 80008d88 <_ZN11ConsoleUtil8inputSemE>
    80004ce0:	0004b503          	ld	a0,0(s1)
    80004ce4:	ffffe097          	auipc	ra,0xffffe
    80004ce8:	d5c080e7          	jalr	-676(ra) # 80002a40 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004cec:	0184b783          	ld	a5,24(s1)
    80004cf0:	0104b703          	ld	a4,16(s1)
    80004cf4:	04e78063          	beq	a5,a4,80004d34 <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80004cf8:	00006717          	auipc	a4,0x6
    80004cfc:	0c870713          	addi	a4,a4,200 # 8000adc0 <_ZN11ConsoleUtil11inputBufferE>
    80004d00:	00f70733          	add	a4,a4,a5
    80004d04:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004d08:	00178793          	addi	a5,a5,1
    80004d0c:	00004717          	auipc	a4,0x4
    80004d10:	d4473703          	ld	a4,-700(a4) # 80008a50 <_ZN11ConsoleUtil10bufferSizeE>
    80004d14:	02e7f7b3          	remu	a5,a5,a4
    80004d18:	00004717          	auipc	a4,0x4
    80004d1c:	08f73423          	sd	a5,136(a4) # 80008da0 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004d20:	01813083          	ld	ra,24(sp)
    80004d24:	01013403          	ld	s0,16(sp)
    80004d28:	00813483          	ld	s1,8(sp)
    80004d2c:	02010113          	addi	sp,sp,32
    80004d30:	00008067          	ret
        return -1;
    80004d34:	0ff00513          	li	a0,255
    80004d38:	fe9ff06f          	j	80004d20 <_ZN11ConsoleUtil8getInputEv+0x5c>

0000000080004d3c <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004d3c:	00004797          	auipc	a5,0x4
    80004d40:	04c78793          	addi	a5,a5,76 # 80008d88 <_ZN11ConsoleUtil8inputSemE>
    80004d44:	0207b683          	ld	a3,32(a5)
    80004d48:	00168713          	addi	a4,a3,1
    80004d4c:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004d50:	0287b603          	ld	a2,40(a5)
    80004d54:	00160713          	addi	a4,a2,1
    80004d58:	00004597          	auipc	a1,0x4
    80004d5c:	cf85b583          	ld	a1,-776(a1) # 80008a50 <_ZN11ConsoleUtil10bufferSizeE>
    80004d60:	02b77733          	remu	a4,a4,a1
    80004d64:	0307b783          	ld	a5,48(a5)
    80004d68:	04f70863          	beq	a4,a5,80004db8 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    80004d6c:	ff010113          	addi	sp,sp,-16
    80004d70:	00113423          	sd	ra,8(sp)
    80004d74:	00813023          	sd	s0,0(sp)
    80004d78:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004d7c:	00004797          	auipc	a5,0x4
    80004d80:	04478793          	addi	a5,a5,68 # 80008dc0 <_ZN11ConsoleUtil12outputBufferE>
    80004d84:	00c78633          	add	a2,a5,a2
    80004d88:	00a60023          	sb	a0,0(a2)

    outputTail = (outputTail+1)%bufferSize;
    80004d8c:	00004797          	auipc	a5,0x4
    80004d90:	ffc78793          	addi	a5,a5,-4 # 80008d88 <_ZN11ConsoleUtil8inputSemE>
    80004d94:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    80004d98:	02d7b023          	sd	a3,32(a5)

    outputSem->signal();
    80004d9c:	0087b503          	ld	a0,8(a5)
    80004da0:	ffffe097          	auipc	ra,0xffffe
    80004da4:	cf0080e7          	jalr	-784(ra) # 80002a90 <_ZN3SCB6signalEv>
}
    80004da8:	00813083          	ld	ra,8(sp)
    80004dac:	00013403          	ld	s0,0(sp)
    80004db0:	01010113          	addi	sp,sp,16
    80004db4:	00008067          	ret
    80004db8:	00008067          	ret

0000000080004dbc <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004dbc:	fe010113          	addi	sp,sp,-32
    80004dc0:	00113c23          	sd	ra,24(sp)
    80004dc4:	00813823          	sd	s0,16(sp)
    80004dc8:	00913423          	sd	s1,8(sp)
    80004dcc:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004dd0:	00004497          	auipc	s1,0x4
    80004dd4:	fb848493          	addi	s1,s1,-72 # 80008d88 <_ZN11ConsoleUtil8inputSemE>
    80004dd8:	0084b503          	ld	a0,8(s1)
    80004ddc:	ffffe097          	auipc	ra,0xffffe
    80004de0:	c64080e7          	jalr	-924(ra) # 80002a40 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004de4:	0304b783          	ld	a5,48(s1)
    80004de8:	0284b703          	ld	a4,40(s1)
    80004dec:	04e78063          	beq	a5,a4,80004e2c <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004df0:	00004717          	auipc	a4,0x4
    80004df4:	fd070713          	addi	a4,a4,-48 # 80008dc0 <_ZN11ConsoleUtil12outputBufferE>
    80004df8:	00f70733          	add	a4,a4,a5
    80004dfc:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004e00:	00178793          	addi	a5,a5,1
    80004e04:	00004717          	auipc	a4,0x4
    80004e08:	c4c73703          	ld	a4,-948(a4) # 80008a50 <_ZN11ConsoleUtil10bufferSizeE>
    80004e0c:	02e7f7b3          	remu	a5,a5,a4
    80004e10:	00004717          	auipc	a4,0x4
    80004e14:	faf73423          	sd	a5,-88(a4) # 80008db8 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004e18:	01813083          	ld	ra,24(sp)
    80004e1c:	01013403          	ld	s0,16(sp)
    80004e20:	00813483          	ld	s1,8(sp)
    80004e24:	02010113          	addi	sp,sp,32
    80004e28:	00008067          	ret
        return -1;
    80004e2c:	0ff00513          	li	a0,255
    80004e30:	fe9ff06f          	j	80004e18 <_ZN11ConsoleUtil9getOutputEv+0x5c>

0000000080004e34 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004e34:	fe010113          	addi	sp,sp,-32
    80004e38:	00113c23          	sd	ra,24(sp)
    80004e3c:	00813823          	sd	s0,16(sp)
    80004e40:	00913423          	sd	s1,8(sp)
    80004e44:	02010413          	addi	s0,sp,32
    80004e48:	00050493          	mv	s1,a0
    while (*string != '\0')
    80004e4c:	0004c503          	lbu	a0,0(s1)
    80004e50:	00050a63          	beqz	a0,80004e64 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004e54:	00000097          	auipc	ra,0x0
    80004e58:	ee8080e7          	jalr	-280(ra) # 80004d3c <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80004e5c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004e60:	fedff06f          	j	80004e4c <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004e64:	01813083          	ld	ra,24(sp)
    80004e68:	01013403          	ld	s0,16(sp)
    80004e6c:	00813483          	ld	s1,8(sp)
    80004e70:	02010113          	addi	sp,sp,32
    80004e74:	00008067          	ret

0000000080004e78 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004e78:	fb010113          	addi	sp,sp,-80
    80004e7c:	04113423          	sd	ra,72(sp)
    80004e80:	04813023          	sd	s0,64(sp)
    80004e84:	02913c23          	sd	s1,56(sp)
    80004e88:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004e8c:	00003797          	auipc	a5,0x3
    80004e90:	70478793          	addi	a5,a5,1796 # 80008590 <CONSOLE_STATUS+0x580>
    80004e94:	0007b703          	ld	a4,0(a5)
    80004e98:	fce43423          	sd	a4,-56(s0)
    80004e9c:	0087b703          	ld	a4,8(a5)
    80004ea0:	fce43823          	sd	a4,-48(s0)
    80004ea4:	0107c783          	lbu	a5,16(a5)
    80004ea8:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004eac:	00060463          	beqz	a2,80004eb4 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004eb0:	08054263          	bltz	a0,80004f34 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004eb4:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004eb8:	00000813          	li	a6,0
    }

    i = 0;
    80004ebc:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004ec0:	0005871b          	sext.w	a4,a1
    80004ec4:	02b577bb          	remuw	a5,a0,a1
    80004ec8:	00048693          	mv	a3,s1
    80004ecc:	0014849b          	addiw	s1,s1,1
    80004ed0:	02079793          	slli	a5,a5,0x20
    80004ed4:	0207d793          	srli	a5,a5,0x20
    80004ed8:	fe040613          	addi	a2,s0,-32
    80004edc:	00f607b3          	add	a5,a2,a5
    80004ee0:	fe87c603          	lbu	a2,-24(a5)
    80004ee4:	fe040793          	addi	a5,s0,-32
    80004ee8:	00d787b3          	add	a5,a5,a3
    80004eec:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004ef0:	0005061b          	sext.w	a2,a0
    80004ef4:	02b5553b          	divuw	a0,a0,a1
    80004ef8:	fce674e3          	bgeu	a2,a4,80004ec0 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004efc:	00080c63          	beqz	a6,80004f14 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004f00:	fe040793          	addi	a5,s0,-32
    80004f04:	009784b3          	add	s1,a5,s1
    80004f08:	02d00793          	li	a5,45
    80004f0c:	fcf48c23          	sb	a5,-40(s1)
    80004f10:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004f14:	fff4849b          	addiw	s1,s1,-1
    80004f18:	0204c463          	bltz	s1,80004f40 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004f1c:	fe040793          	addi	a5,s0,-32
    80004f20:	009787b3          	add	a5,a5,s1
    80004f24:	fd87c503          	lbu	a0,-40(a5)
    80004f28:	00000097          	auipc	ra,0x0
    80004f2c:	e14080e7          	jalr	-492(ra) # 80004d3c <_ZN11ConsoleUtil9putOutputEc>
    80004f30:	fe5ff06f          	j	80004f14 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004f34:	40a0053b          	negw	a0,a0
        neg = 1;
    80004f38:	00100813          	li	a6,1
        x = -xx;
    80004f3c:	f81ff06f          	j	80004ebc <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004f40:	04813083          	ld	ra,72(sp)
    80004f44:	04013403          	ld	s0,64(sp)
    80004f48:	03813483          	ld	s1,56(sp)
    80004f4c:	05010113          	addi	sp,sp,80
    80004f50:	00008067          	ret

0000000080004f54 <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    80004f54:	fd010113          	addi	sp,sp,-48
    80004f58:	02113423          	sd	ra,40(sp)
    80004f5c:	02813023          	sd	s0,32(sp)
    80004f60:	00913c23          	sd	s1,24(sp)
    80004f64:	01213823          	sd	s2,16(sp)
    80004f68:	01313423          	sd	s3,8(sp)
    80004f6c:	03010413          	addi	s0,sp,48
    80004f70:	00058913          	mv	s2,a1
    80004f74:	00060493          	mv	s1,a2
    80004f78:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    80004f7c:	00000097          	auipc	ra,0x0
    80004f80:	eb8080e7          	jalr	-328(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    80004f84:	00000613          	li	a2,0
    80004f88:	00098593          	mv	a1,s3
    80004f8c:	00090513          	mv	a0,s2
    80004f90:	00000097          	auipc	ra,0x0
    80004f94:	ee8080e7          	jalr	-280(ra) # 80004e78 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004f98:	00048513          	mv	a0,s1
    80004f9c:	00000097          	auipc	ra,0x0
    80004fa0:	e98080e7          	jalr	-360(ra) # 80004e34 <_ZN11ConsoleUtil11printStringEPKc>
}
    80004fa4:	02813083          	ld	ra,40(sp)
    80004fa8:	02013403          	ld	s0,32(sp)
    80004fac:	01813483          	ld	s1,24(sp)
    80004fb0:	01013903          	ld	s2,16(sp)
    80004fb4:	00813983          	ld	s3,8(sp)
    80004fb8:	03010113          	addi	sp,sp,48
    80004fbc:	00008067          	ret

0000000080004fc0 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004fc0:	ff010113          	addi	sp,sp,-16
    80004fc4:	00813423          	sd	s0,8(sp)
    80004fc8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004fcc:	04300513          	li	a0,67

    asm("ecall");
    80004fd0:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004fd4:	00050513          	mv	a0,a0

    return (char)status;
}
    80004fd8:	0ff57513          	andi	a0,a0,255
    80004fdc:	00813403          	ld	s0,8(sp)
    80004fe0:	01010113          	addi	sp,sp,16
    80004fe4:	00008067          	ret

0000000080004fe8 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004fe8:	ff010113          	addi	sp,sp,-16
    80004fec:	00113423          	sd	ra,8(sp)
    80004ff0:	00813023          	sd	s0,0(sp)
    80004ff4:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004ff8:	ffffd097          	auipc	ra,0xffffd
    80004ffc:	9e8080e7          	jalr	-1560(ra) # 800019e0 <_ZN13SlabAllocator10initializeEPvm>
}
    80005000:	00813083          	ld	ra,8(sp)
    80005004:	00013403          	ld	s0,0(sp)
    80005008:	01010113          	addi	sp,sp,16
    8000500c:	00008067          	ret

0000000080005010 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80005010:	ff010113          	addi	sp,sp,-16
    80005014:	00113423          	sd	ra,8(sp)
    80005018:	00813023          	sd	s0,0(sp)
    8000501c:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80005020:	ffffd097          	auipc	ra,0xffffd
    80005024:	8b4080e7          	jalr	-1868(ra) # 800018d4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80005028:	00813083          	ld	ra,8(sp)
    8000502c:	00013403          	ld	s0,0(sp)
    80005030:	01010113          	addi	sp,sp,16
    80005034:	00008067          	ret

0000000080005038 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80005038:	ff010113          	addi	sp,sp,-16
    8000503c:	00113423          	sd	ra,8(sp)
    80005040:	00813023          	sd	s0,0(sp)
    80005044:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80005048:	ffffc097          	auipc	ra,0xffffc
    8000504c:	750080e7          	jalr	1872(ra) # 80001798 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80005050:	00813083          	ld	ra,8(sp)
    80005054:	00013403          	ld	s0,0(sp)
    80005058:	01010113          	addi	sp,sp,16
    8000505c:	00008067          	ret

0000000080005060 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80005060:	ff010113          	addi	sp,sp,-16
    80005064:	00113423          	sd	ra,8(sp)
    80005068:	00813023          	sd	s0,0(sp)
    8000506c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80005070:	ffffd097          	auipc	ra,0xffffd
    80005074:	b38080e7          	jalr	-1224(ra) # 80001ba8 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80005078:	00813083          	ld	ra,8(sp)
    8000507c:	00013403          	ld	s0,0(sp)
    80005080:	01010113          	addi	sp,sp,16
    80005084:	00008067          	ret

0000000080005088 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    80005088:	fe010113          	addi	sp,sp,-32
    8000508c:	00113c23          	sd	ra,24(sp)
    80005090:	00813823          	sd	s0,16(sp)
    80005094:	02010413          	addi	s0,sp,32
    80005098:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    8000509c:	fe840513          	addi	a0,s0,-24
    800050a0:	ffffd097          	auipc	ra,0xffffd
    800050a4:	c68080e7          	jalr	-920(ra) # 80001d08 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    800050a8:	01813083          	ld	ra,24(sp)
    800050ac:	01013403          	ld	s0,16(sp)
    800050b0:	02010113          	addi	sp,sp,32
    800050b4:	00008067          	ret

00000000800050b8 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    800050b8:	ff010113          	addi	sp,sp,-16
    800050bc:	00113423          	sd	ra,8(sp)
    800050c0:	00813023          	sd	s0,0(sp)
    800050c4:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    800050c8:	ffffc097          	auipc	ra,0xffffc
    800050cc:	230080e7          	jalr	560(ra) # 800012f8 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    800050d0:	00813083          	ld	ra,8(sp)
    800050d4:	00013403          	ld	s0,0(sp)
    800050d8:	01010113          	addi	sp,sp,16
    800050dc:	00008067          	ret

00000000800050e0 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    800050e0:	ff010113          	addi	sp,sp,-16
    800050e4:	00113423          	sd	ra,8(sp)
    800050e8:	00813023          	sd	s0,0(sp)
    800050ec:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    800050f0:	ffffc097          	auipc	ra,0xffffc
    800050f4:	044080e7          	jalr	68(ra) # 80001134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    800050f8:	00813083          	ld	ra,8(sp)
    800050fc:	00013403          	ld	s0,0(sp)
    80005100:	01010113          	addi	sp,sp,16
    80005104:	00008067          	ret

0000000080005108 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80005108:	ff010113          	addi	sp,sp,-16
    8000510c:	00113423          	sd	ra,8(sp)
    80005110:	00813023          	sd	s0,0(sp)
    80005114:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80005118:	ffffc097          	auipc	ra,0xffffc
    8000511c:	71c080e7          	jalr	1820(ra) # 80001834 <_ZN13SlabAllocator14allocateBufferEm>
}
    80005120:	00813083          	ld	ra,8(sp)
    80005124:	00013403          	ld	s0,0(sp)
    80005128:	01010113          	addi	sp,sp,16
    8000512c:	00008067          	ret

0000000080005130 <_Z5kfreePKv>:

void kfree(const void* objp){
    80005130:	ff010113          	addi	sp,sp,-16
    80005134:	00113423          	sd	ra,8(sp)
    80005138:	00813023          	sd	s0,0(sp)
    8000513c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80005140:	ffffd097          	auipc	ra,0xffffd
    80005144:	b5c080e7          	jalr	-1188(ra) # 80001c9c <_ZN13SlabAllocator10freeBufferEPKv>
    80005148:	00813083          	ld	ra,8(sp)
    8000514c:	00013403          	ld	s0,0(sp)
    80005150:	01010113          	addi	sp,sp,16
    80005154:	00008067          	ret

0000000080005158 <start>:
    80005158:	ff010113          	addi	sp,sp,-16
    8000515c:	00813423          	sd	s0,8(sp)
    80005160:	01010413          	addi	s0,sp,16
    80005164:	300027f3          	csrr	a5,mstatus
    80005168:	ffffe737          	lui	a4,0xffffe
    8000516c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffeb7ff>
    80005170:	00e7f7b3          	and	a5,a5,a4
    80005174:	00001737          	lui	a4,0x1
    80005178:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000517c:	00e7e7b3          	or	a5,a5,a4
    80005180:	30079073          	csrw	mstatus,a5
    80005184:	00000797          	auipc	a5,0x0
    80005188:	16078793          	addi	a5,a5,352 # 800052e4 <system_main>
    8000518c:	34179073          	csrw	mepc,a5
    80005190:	00000793          	li	a5,0
    80005194:	18079073          	csrw	satp,a5
    80005198:	000107b7          	lui	a5,0x10
    8000519c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800051a0:	30279073          	csrw	medeleg,a5
    800051a4:	30379073          	csrw	mideleg,a5
    800051a8:	104027f3          	csrr	a5,sie
    800051ac:	2227e793          	ori	a5,a5,546
    800051b0:	10479073          	csrw	sie,a5
    800051b4:	fff00793          	li	a5,-1
    800051b8:	00a7d793          	srli	a5,a5,0xa
    800051bc:	3b079073          	csrw	pmpaddr0,a5
    800051c0:	00f00793          	li	a5,15
    800051c4:	3a079073          	csrw	pmpcfg0,a5
    800051c8:	f14027f3          	csrr	a5,mhartid
    800051cc:	0200c737          	lui	a4,0x200c
    800051d0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800051d4:	0007869b          	sext.w	a3,a5
    800051d8:	00269713          	slli	a4,a3,0x2
    800051dc:	000f4637          	lui	a2,0xf4
    800051e0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800051e4:	00d70733          	add	a4,a4,a3
    800051e8:	0037979b          	slliw	a5,a5,0x3
    800051ec:	020046b7          	lui	a3,0x2004
    800051f0:	00d787b3          	add	a5,a5,a3
    800051f4:	00c585b3          	add	a1,a1,a2
    800051f8:	00371693          	slli	a3,a4,0x3
    800051fc:	00008717          	auipc	a4,0x8
    80005200:	bd470713          	addi	a4,a4,-1068 # 8000cdd0 <timer_scratch>
    80005204:	00b7b023          	sd	a1,0(a5)
    80005208:	00d70733          	add	a4,a4,a3
    8000520c:	00f73c23          	sd	a5,24(a4)
    80005210:	02c73023          	sd	a2,32(a4)
    80005214:	34071073          	csrw	mscratch,a4
    80005218:	00000797          	auipc	a5,0x0
    8000521c:	6e878793          	addi	a5,a5,1768 # 80005900 <timervec>
    80005220:	30579073          	csrw	mtvec,a5
    80005224:	300027f3          	csrr	a5,mstatus
    80005228:	0087e793          	ori	a5,a5,8
    8000522c:	30079073          	csrw	mstatus,a5
    80005230:	304027f3          	csrr	a5,mie
    80005234:	0807e793          	ori	a5,a5,128
    80005238:	30479073          	csrw	mie,a5
    8000523c:	f14027f3          	csrr	a5,mhartid
    80005240:	0007879b          	sext.w	a5,a5
    80005244:	00078213          	mv	tp,a5
    80005248:	30200073          	mret
    8000524c:	00813403          	ld	s0,8(sp)
    80005250:	01010113          	addi	sp,sp,16
    80005254:	00008067          	ret

0000000080005258 <timerinit>:
    80005258:	ff010113          	addi	sp,sp,-16
    8000525c:	00813423          	sd	s0,8(sp)
    80005260:	01010413          	addi	s0,sp,16
    80005264:	f14027f3          	csrr	a5,mhartid
    80005268:	0200c737          	lui	a4,0x200c
    8000526c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005270:	0007869b          	sext.w	a3,a5
    80005274:	00269713          	slli	a4,a3,0x2
    80005278:	000f4637          	lui	a2,0xf4
    8000527c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005280:	00d70733          	add	a4,a4,a3
    80005284:	0037979b          	slliw	a5,a5,0x3
    80005288:	020046b7          	lui	a3,0x2004
    8000528c:	00d787b3          	add	a5,a5,a3
    80005290:	00c585b3          	add	a1,a1,a2
    80005294:	00371693          	slli	a3,a4,0x3
    80005298:	00008717          	auipc	a4,0x8
    8000529c:	b3870713          	addi	a4,a4,-1224 # 8000cdd0 <timer_scratch>
    800052a0:	00b7b023          	sd	a1,0(a5)
    800052a4:	00d70733          	add	a4,a4,a3
    800052a8:	00f73c23          	sd	a5,24(a4)
    800052ac:	02c73023          	sd	a2,32(a4)
    800052b0:	34071073          	csrw	mscratch,a4
    800052b4:	00000797          	auipc	a5,0x0
    800052b8:	64c78793          	addi	a5,a5,1612 # 80005900 <timervec>
    800052bc:	30579073          	csrw	mtvec,a5
    800052c0:	300027f3          	csrr	a5,mstatus
    800052c4:	0087e793          	ori	a5,a5,8
    800052c8:	30079073          	csrw	mstatus,a5
    800052cc:	304027f3          	csrr	a5,mie
    800052d0:	0807e793          	ori	a5,a5,128
    800052d4:	30479073          	csrw	mie,a5
    800052d8:	00813403          	ld	s0,8(sp)
    800052dc:	01010113          	addi	sp,sp,16
    800052e0:	00008067          	ret

00000000800052e4 <system_main>:
    800052e4:	fe010113          	addi	sp,sp,-32
    800052e8:	00813823          	sd	s0,16(sp)
    800052ec:	00913423          	sd	s1,8(sp)
    800052f0:	00113c23          	sd	ra,24(sp)
    800052f4:	02010413          	addi	s0,sp,32
    800052f8:	00000097          	auipc	ra,0x0
    800052fc:	0c4080e7          	jalr	196(ra) # 800053bc <cpuid>
    80005300:	00004497          	auipc	s1,0x4
    80005304:	86048493          	addi	s1,s1,-1952 # 80008b60 <started>
    80005308:	02050263          	beqz	a0,8000532c <system_main+0x48>
    8000530c:	0004a783          	lw	a5,0(s1)
    80005310:	0007879b          	sext.w	a5,a5
    80005314:	fe078ce3          	beqz	a5,8000530c <system_main+0x28>
    80005318:	0ff0000f          	fence
    8000531c:	00003517          	auipc	a0,0x3
    80005320:	2bc50513          	addi	a0,a0,700 # 800085d8 <CONSOLE_STATUS+0x5c8>
    80005324:	00001097          	auipc	ra,0x1
    80005328:	a78080e7          	jalr	-1416(ra) # 80005d9c <panic>
    8000532c:	00001097          	auipc	ra,0x1
    80005330:	9cc080e7          	jalr	-1588(ra) # 80005cf8 <consoleinit>
    80005334:	00001097          	auipc	ra,0x1
    80005338:	158080e7          	jalr	344(ra) # 8000648c <printfinit>
    8000533c:	00003517          	auipc	a0,0x3
    80005340:	05450513          	addi	a0,a0,84 # 80008390 <CONSOLE_STATUS+0x380>
    80005344:	00001097          	auipc	ra,0x1
    80005348:	ab4080e7          	jalr	-1356(ra) # 80005df8 <__printf>
    8000534c:	00003517          	auipc	a0,0x3
    80005350:	25c50513          	addi	a0,a0,604 # 800085a8 <CONSOLE_STATUS+0x598>
    80005354:	00001097          	auipc	ra,0x1
    80005358:	aa4080e7          	jalr	-1372(ra) # 80005df8 <__printf>
    8000535c:	00003517          	auipc	a0,0x3
    80005360:	03450513          	addi	a0,a0,52 # 80008390 <CONSOLE_STATUS+0x380>
    80005364:	00001097          	auipc	ra,0x1
    80005368:	a94080e7          	jalr	-1388(ra) # 80005df8 <__printf>
    8000536c:	00001097          	auipc	ra,0x1
    80005370:	4ac080e7          	jalr	1196(ra) # 80006818 <kinit>
    80005374:	00000097          	auipc	ra,0x0
    80005378:	148080e7          	jalr	328(ra) # 800054bc <trapinit>
    8000537c:	00000097          	auipc	ra,0x0
    80005380:	16c080e7          	jalr	364(ra) # 800054e8 <trapinithart>
    80005384:	00000097          	auipc	ra,0x0
    80005388:	5bc080e7          	jalr	1468(ra) # 80005940 <plicinit>
    8000538c:	00000097          	auipc	ra,0x0
    80005390:	5dc080e7          	jalr	1500(ra) # 80005968 <plicinithart>
    80005394:	00000097          	auipc	ra,0x0
    80005398:	078080e7          	jalr	120(ra) # 8000540c <userinit>
    8000539c:	0ff0000f          	fence
    800053a0:	00100793          	li	a5,1
    800053a4:	00003517          	auipc	a0,0x3
    800053a8:	21c50513          	addi	a0,a0,540 # 800085c0 <CONSOLE_STATUS+0x5b0>
    800053ac:	00f4a023          	sw	a5,0(s1)
    800053b0:	00001097          	auipc	ra,0x1
    800053b4:	a48080e7          	jalr	-1464(ra) # 80005df8 <__printf>
    800053b8:	0000006f          	j	800053b8 <system_main+0xd4>

00000000800053bc <cpuid>:
    800053bc:	ff010113          	addi	sp,sp,-16
    800053c0:	00813423          	sd	s0,8(sp)
    800053c4:	01010413          	addi	s0,sp,16
    800053c8:	00020513          	mv	a0,tp
    800053cc:	00813403          	ld	s0,8(sp)
    800053d0:	0005051b          	sext.w	a0,a0
    800053d4:	01010113          	addi	sp,sp,16
    800053d8:	00008067          	ret

00000000800053dc <mycpu>:
    800053dc:	ff010113          	addi	sp,sp,-16
    800053e0:	00813423          	sd	s0,8(sp)
    800053e4:	01010413          	addi	s0,sp,16
    800053e8:	00020793          	mv	a5,tp
    800053ec:	00813403          	ld	s0,8(sp)
    800053f0:	0007879b          	sext.w	a5,a5
    800053f4:	00779793          	slli	a5,a5,0x7
    800053f8:	00009517          	auipc	a0,0x9
    800053fc:	a0850513          	addi	a0,a0,-1528 # 8000de00 <cpus>
    80005400:	00f50533          	add	a0,a0,a5
    80005404:	01010113          	addi	sp,sp,16
    80005408:	00008067          	ret

000000008000540c <userinit>:
    8000540c:	ff010113          	addi	sp,sp,-16
    80005410:	00813423          	sd	s0,8(sp)
    80005414:	01010413          	addi	s0,sp,16
    80005418:	00813403          	ld	s0,8(sp)
    8000541c:	01010113          	addi	sp,sp,16
    80005420:	ffffd317          	auipc	t1,0xffffd
    80005424:	73c30067          	jr	1852(t1) # 80002b5c <main>

0000000080005428 <either_copyout>:
    80005428:	ff010113          	addi	sp,sp,-16
    8000542c:	00813023          	sd	s0,0(sp)
    80005430:	00113423          	sd	ra,8(sp)
    80005434:	01010413          	addi	s0,sp,16
    80005438:	02051663          	bnez	a0,80005464 <either_copyout+0x3c>
    8000543c:	00058513          	mv	a0,a1
    80005440:	00060593          	mv	a1,a2
    80005444:	0006861b          	sext.w	a2,a3
    80005448:	00002097          	auipc	ra,0x2
    8000544c:	c5c080e7          	jalr	-932(ra) # 800070a4 <__memmove>
    80005450:	00813083          	ld	ra,8(sp)
    80005454:	00013403          	ld	s0,0(sp)
    80005458:	00000513          	li	a0,0
    8000545c:	01010113          	addi	sp,sp,16
    80005460:	00008067          	ret
    80005464:	00003517          	auipc	a0,0x3
    80005468:	19c50513          	addi	a0,a0,412 # 80008600 <CONSOLE_STATUS+0x5f0>
    8000546c:	00001097          	auipc	ra,0x1
    80005470:	930080e7          	jalr	-1744(ra) # 80005d9c <panic>

0000000080005474 <either_copyin>:
    80005474:	ff010113          	addi	sp,sp,-16
    80005478:	00813023          	sd	s0,0(sp)
    8000547c:	00113423          	sd	ra,8(sp)
    80005480:	01010413          	addi	s0,sp,16
    80005484:	02059463          	bnez	a1,800054ac <either_copyin+0x38>
    80005488:	00060593          	mv	a1,a2
    8000548c:	0006861b          	sext.w	a2,a3
    80005490:	00002097          	auipc	ra,0x2
    80005494:	c14080e7          	jalr	-1004(ra) # 800070a4 <__memmove>
    80005498:	00813083          	ld	ra,8(sp)
    8000549c:	00013403          	ld	s0,0(sp)
    800054a0:	00000513          	li	a0,0
    800054a4:	01010113          	addi	sp,sp,16
    800054a8:	00008067          	ret
    800054ac:	00003517          	auipc	a0,0x3
    800054b0:	17c50513          	addi	a0,a0,380 # 80008628 <CONSOLE_STATUS+0x618>
    800054b4:	00001097          	auipc	ra,0x1
    800054b8:	8e8080e7          	jalr	-1816(ra) # 80005d9c <panic>

00000000800054bc <trapinit>:
    800054bc:	ff010113          	addi	sp,sp,-16
    800054c0:	00813423          	sd	s0,8(sp)
    800054c4:	01010413          	addi	s0,sp,16
    800054c8:	00813403          	ld	s0,8(sp)
    800054cc:	00003597          	auipc	a1,0x3
    800054d0:	18458593          	addi	a1,a1,388 # 80008650 <CONSOLE_STATUS+0x640>
    800054d4:	00009517          	auipc	a0,0x9
    800054d8:	9ac50513          	addi	a0,a0,-1620 # 8000de80 <tickslock>
    800054dc:	01010113          	addi	sp,sp,16
    800054e0:	00001317          	auipc	t1,0x1
    800054e4:	5c830067          	jr	1480(t1) # 80006aa8 <initlock>

00000000800054e8 <trapinithart>:
    800054e8:	ff010113          	addi	sp,sp,-16
    800054ec:	00813423          	sd	s0,8(sp)
    800054f0:	01010413          	addi	s0,sp,16
    800054f4:	00000797          	auipc	a5,0x0
    800054f8:	2fc78793          	addi	a5,a5,764 # 800057f0 <kernelvec>
    800054fc:	10579073          	csrw	stvec,a5
    80005500:	00813403          	ld	s0,8(sp)
    80005504:	01010113          	addi	sp,sp,16
    80005508:	00008067          	ret

000000008000550c <usertrap>:
    8000550c:	ff010113          	addi	sp,sp,-16
    80005510:	00813423          	sd	s0,8(sp)
    80005514:	01010413          	addi	s0,sp,16
    80005518:	00813403          	ld	s0,8(sp)
    8000551c:	01010113          	addi	sp,sp,16
    80005520:	00008067          	ret

0000000080005524 <usertrapret>:
    80005524:	ff010113          	addi	sp,sp,-16
    80005528:	00813423          	sd	s0,8(sp)
    8000552c:	01010413          	addi	s0,sp,16
    80005530:	00813403          	ld	s0,8(sp)
    80005534:	01010113          	addi	sp,sp,16
    80005538:	00008067          	ret

000000008000553c <kerneltrap>:
    8000553c:	fe010113          	addi	sp,sp,-32
    80005540:	00813823          	sd	s0,16(sp)
    80005544:	00113c23          	sd	ra,24(sp)
    80005548:	00913423          	sd	s1,8(sp)
    8000554c:	02010413          	addi	s0,sp,32
    80005550:	142025f3          	csrr	a1,scause
    80005554:	100027f3          	csrr	a5,sstatus
    80005558:	0027f793          	andi	a5,a5,2
    8000555c:	10079c63          	bnez	a5,80005674 <kerneltrap+0x138>
    80005560:	142027f3          	csrr	a5,scause
    80005564:	0207ce63          	bltz	a5,800055a0 <kerneltrap+0x64>
    80005568:	00003517          	auipc	a0,0x3
    8000556c:	13050513          	addi	a0,a0,304 # 80008698 <CONSOLE_STATUS+0x688>
    80005570:	00001097          	auipc	ra,0x1
    80005574:	888080e7          	jalr	-1912(ra) # 80005df8 <__printf>
    80005578:	141025f3          	csrr	a1,sepc
    8000557c:	14302673          	csrr	a2,stval
    80005580:	00003517          	auipc	a0,0x3
    80005584:	12850513          	addi	a0,a0,296 # 800086a8 <CONSOLE_STATUS+0x698>
    80005588:	00001097          	auipc	ra,0x1
    8000558c:	870080e7          	jalr	-1936(ra) # 80005df8 <__printf>
    80005590:	00003517          	auipc	a0,0x3
    80005594:	13050513          	addi	a0,a0,304 # 800086c0 <CONSOLE_STATUS+0x6b0>
    80005598:	00001097          	auipc	ra,0x1
    8000559c:	804080e7          	jalr	-2044(ra) # 80005d9c <panic>
    800055a0:	0ff7f713          	andi	a4,a5,255
    800055a4:	00900693          	li	a3,9
    800055a8:	04d70063          	beq	a4,a3,800055e8 <kerneltrap+0xac>
    800055ac:	fff00713          	li	a4,-1
    800055b0:	03f71713          	slli	a4,a4,0x3f
    800055b4:	00170713          	addi	a4,a4,1
    800055b8:	fae798e3          	bne	a5,a4,80005568 <kerneltrap+0x2c>
    800055bc:	00000097          	auipc	ra,0x0
    800055c0:	e00080e7          	jalr	-512(ra) # 800053bc <cpuid>
    800055c4:	06050663          	beqz	a0,80005630 <kerneltrap+0xf4>
    800055c8:	144027f3          	csrr	a5,sip
    800055cc:	ffd7f793          	andi	a5,a5,-3
    800055d0:	14479073          	csrw	sip,a5
    800055d4:	01813083          	ld	ra,24(sp)
    800055d8:	01013403          	ld	s0,16(sp)
    800055dc:	00813483          	ld	s1,8(sp)
    800055e0:	02010113          	addi	sp,sp,32
    800055e4:	00008067          	ret
    800055e8:	00000097          	auipc	ra,0x0
    800055ec:	3cc080e7          	jalr	972(ra) # 800059b4 <plic_claim>
    800055f0:	00a00793          	li	a5,10
    800055f4:	00050493          	mv	s1,a0
    800055f8:	06f50863          	beq	a0,a5,80005668 <kerneltrap+0x12c>
    800055fc:	fc050ce3          	beqz	a0,800055d4 <kerneltrap+0x98>
    80005600:	00050593          	mv	a1,a0
    80005604:	00003517          	auipc	a0,0x3
    80005608:	07450513          	addi	a0,a0,116 # 80008678 <CONSOLE_STATUS+0x668>
    8000560c:	00000097          	auipc	ra,0x0
    80005610:	7ec080e7          	jalr	2028(ra) # 80005df8 <__printf>
    80005614:	01013403          	ld	s0,16(sp)
    80005618:	01813083          	ld	ra,24(sp)
    8000561c:	00048513          	mv	a0,s1
    80005620:	00813483          	ld	s1,8(sp)
    80005624:	02010113          	addi	sp,sp,32
    80005628:	00000317          	auipc	t1,0x0
    8000562c:	3c430067          	jr	964(t1) # 800059ec <plic_complete>
    80005630:	00009517          	auipc	a0,0x9
    80005634:	85050513          	addi	a0,a0,-1968 # 8000de80 <tickslock>
    80005638:	00001097          	auipc	ra,0x1
    8000563c:	494080e7          	jalr	1172(ra) # 80006acc <acquire>
    80005640:	00003717          	auipc	a4,0x3
    80005644:	52470713          	addi	a4,a4,1316 # 80008b64 <ticks>
    80005648:	00072783          	lw	a5,0(a4)
    8000564c:	00009517          	auipc	a0,0x9
    80005650:	83450513          	addi	a0,a0,-1996 # 8000de80 <tickslock>
    80005654:	0017879b          	addiw	a5,a5,1
    80005658:	00f72023          	sw	a5,0(a4)
    8000565c:	00001097          	auipc	ra,0x1
    80005660:	53c080e7          	jalr	1340(ra) # 80006b98 <release>
    80005664:	f65ff06f          	j	800055c8 <kerneltrap+0x8c>
    80005668:	00001097          	auipc	ra,0x1
    8000566c:	098080e7          	jalr	152(ra) # 80006700 <uartintr>
    80005670:	fa5ff06f          	j	80005614 <kerneltrap+0xd8>
    80005674:	00003517          	auipc	a0,0x3
    80005678:	fe450513          	addi	a0,a0,-28 # 80008658 <CONSOLE_STATUS+0x648>
    8000567c:	00000097          	auipc	ra,0x0
    80005680:	720080e7          	jalr	1824(ra) # 80005d9c <panic>

0000000080005684 <clockintr>:
    80005684:	fe010113          	addi	sp,sp,-32
    80005688:	00813823          	sd	s0,16(sp)
    8000568c:	00913423          	sd	s1,8(sp)
    80005690:	00113c23          	sd	ra,24(sp)
    80005694:	02010413          	addi	s0,sp,32
    80005698:	00008497          	auipc	s1,0x8
    8000569c:	7e848493          	addi	s1,s1,2024 # 8000de80 <tickslock>
    800056a0:	00048513          	mv	a0,s1
    800056a4:	00001097          	auipc	ra,0x1
    800056a8:	428080e7          	jalr	1064(ra) # 80006acc <acquire>
    800056ac:	00003717          	auipc	a4,0x3
    800056b0:	4b870713          	addi	a4,a4,1208 # 80008b64 <ticks>
    800056b4:	00072783          	lw	a5,0(a4)
    800056b8:	01013403          	ld	s0,16(sp)
    800056bc:	01813083          	ld	ra,24(sp)
    800056c0:	00048513          	mv	a0,s1
    800056c4:	0017879b          	addiw	a5,a5,1
    800056c8:	00813483          	ld	s1,8(sp)
    800056cc:	00f72023          	sw	a5,0(a4)
    800056d0:	02010113          	addi	sp,sp,32
    800056d4:	00001317          	auipc	t1,0x1
    800056d8:	4c430067          	jr	1220(t1) # 80006b98 <release>

00000000800056dc <devintr>:
    800056dc:	142027f3          	csrr	a5,scause
    800056e0:	00000513          	li	a0,0
    800056e4:	0007c463          	bltz	a5,800056ec <devintr+0x10>
    800056e8:	00008067          	ret
    800056ec:	fe010113          	addi	sp,sp,-32
    800056f0:	00813823          	sd	s0,16(sp)
    800056f4:	00113c23          	sd	ra,24(sp)
    800056f8:	00913423          	sd	s1,8(sp)
    800056fc:	02010413          	addi	s0,sp,32
    80005700:	0ff7f713          	andi	a4,a5,255
    80005704:	00900693          	li	a3,9
    80005708:	04d70c63          	beq	a4,a3,80005760 <devintr+0x84>
    8000570c:	fff00713          	li	a4,-1
    80005710:	03f71713          	slli	a4,a4,0x3f
    80005714:	00170713          	addi	a4,a4,1
    80005718:	00e78c63          	beq	a5,a4,80005730 <devintr+0x54>
    8000571c:	01813083          	ld	ra,24(sp)
    80005720:	01013403          	ld	s0,16(sp)
    80005724:	00813483          	ld	s1,8(sp)
    80005728:	02010113          	addi	sp,sp,32
    8000572c:	00008067          	ret
    80005730:	00000097          	auipc	ra,0x0
    80005734:	c8c080e7          	jalr	-884(ra) # 800053bc <cpuid>
    80005738:	06050663          	beqz	a0,800057a4 <devintr+0xc8>
    8000573c:	144027f3          	csrr	a5,sip
    80005740:	ffd7f793          	andi	a5,a5,-3
    80005744:	14479073          	csrw	sip,a5
    80005748:	01813083          	ld	ra,24(sp)
    8000574c:	01013403          	ld	s0,16(sp)
    80005750:	00813483          	ld	s1,8(sp)
    80005754:	00200513          	li	a0,2
    80005758:	02010113          	addi	sp,sp,32
    8000575c:	00008067          	ret
    80005760:	00000097          	auipc	ra,0x0
    80005764:	254080e7          	jalr	596(ra) # 800059b4 <plic_claim>
    80005768:	00a00793          	li	a5,10
    8000576c:	00050493          	mv	s1,a0
    80005770:	06f50663          	beq	a0,a5,800057dc <devintr+0x100>
    80005774:	00100513          	li	a0,1
    80005778:	fa0482e3          	beqz	s1,8000571c <devintr+0x40>
    8000577c:	00048593          	mv	a1,s1
    80005780:	00003517          	auipc	a0,0x3
    80005784:	ef850513          	addi	a0,a0,-264 # 80008678 <CONSOLE_STATUS+0x668>
    80005788:	00000097          	auipc	ra,0x0
    8000578c:	670080e7          	jalr	1648(ra) # 80005df8 <__printf>
    80005790:	00048513          	mv	a0,s1
    80005794:	00000097          	auipc	ra,0x0
    80005798:	258080e7          	jalr	600(ra) # 800059ec <plic_complete>
    8000579c:	00100513          	li	a0,1
    800057a0:	f7dff06f          	j	8000571c <devintr+0x40>
    800057a4:	00008517          	auipc	a0,0x8
    800057a8:	6dc50513          	addi	a0,a0,1756 # 8000de80 <tickslock>
    800057ac:	00001097          	auipc	ra,0x1
    800057b0:	320080e7          	jalr	800(ra) # 80006acc <acquire>
    800057b4:	00003717          	auipc	a4,0x3
    800057b8:	3b070713          	addi	a4,a4,944 # 80008b64 <ticks>
    800057bc:	00072783          	lw	a5,0(a4)
    800057c0:	00008517          	auipc	a0,0x8
    800057c4:	6c050513          	addi	a0,a0,1728 # 8000de80 <tickslock>
    800057c8:	0017879b          	addiw	a5,a5,1
    800057cc:	00f72023          	sw	a5,0(a4)
    800057d0:	00001097          	auipc	ra,0x1
    800057d4:	3c8080e7          	jalr	968(ra) # 80006b98 <release>
    800057d8:	f65ff06f          	j	8000573c <devintr+0x60>
    800057dc:	00001097          	auipc	ra,0x1
    800057e0:	f24080e7          	jalr	-220(ra) # 80006700 <uartintr>
    800057e4:	fadff06f          	j	80005790 <devintr+0xb4>
	...

00000000800057f0 <kernelvec>:
    800057f0:	f0010113          	addi	sp,sp,-256
    800057f4:	00113023          	sd	ra,0(sp)
    800057f8:	00213423          	sd	sp,8(sp)
    800057fc:	00313823          	sd	gp,16(sp)
    80005800:	00413c23          	sd	tp,24(sp)
    80005804:	02513023          	sd	t0,32(sp)
    80005808:	02613423          	sd	t1,40(sp)
    8000580c:	02713823          	sd	t2,48(sp)
    80005810:	02813c23          	sd	s0,56(sp)
    80005814:	04913023          	sd	s1,64(sp)
    80005818:	04a13423          	sd	a0,72(sp)
    8000581c:	04b13823          	sd	a1,80(sp)
    80005820:	04c13c23          	sd	a2,88(sp)
    80005824:	06d13023          	sd	a3,96(sp)
    80005828:	06e13423          	sd	a4,104(sp)
    8000582c:	06f13823          	sd	a5,112(sp)
    80005830:	07013c23          	sd	a6,120(sp)
    80005834:	09113023          	sd	a7,128(sp)
    80005838:	09213423          	sd	s2,136(sp)
    8000583c:	09313823          	sd	s3,144(sp)
    80005840:	09413c23          	sd	s4,152(sp)
    80005844:	0b513023          	sd	s5,160(sp)
    80005848:	0b613423          	sd	s6,168(sp)
    8000584c:	0b713823          	sd	s7,176(sp)
    80005850:	0b813c23          	sd	s8,184(sp)
    80005854:	0d913023          	sd	s9,192(sp)
    80005858:	0da13423          	sd	s10,200(sp)
    8000585c:	0db13823          	sd	s11,208(sp)
    80005860:	0dc13c23          	sd	t3,216(sp)
    80005864:	0fd13023          	sd	t4,224(sp)
    80005868:	0fe13423          	sd	t5,232(sp)
    8000586c:	0ff13823          	sd	t6,240(sp)
    80005870:	ccdff0ef          	jal	ra,8000553c <kerneltrap>
    80005874:	00013083          	ld	ra,0(sp)
    80005878:	00813103          	ld	sp,8(sp)
    8000587c:	01013183          	ld	gp,16(sp)
    80005880:	02013283          	ld	t0,32(sp)
    80005884:	02813303          	ld	t1,40(sp)
    80005888:	03013383          	ld	t2,48(sp)
    8000588c:	03813403          	ld	s0,56(sp)
    80005890:	04013483          	ld	s1,64(sp)
    80005894:	04813503          	ld	a0,72(sp)
    80005898:	05013583          	ld	a1,80(sp)
    8000589c:	05813603          	ld	a2,88(sp)
    800058a0:	06013683          	ld	a3,96(sp)
    800058a4:	06813703          	ld	a4,104(sp)
    800058a8:	07013783          	ld	a5,112(sp)
    800058ac:	07813803          	ld	a6,120(sp)
    800058b0:	08013883          	ld	a7,128(sp)
    800058b4:	08813903          	ld	s2,136(sp)
    800058b8:	09013983          	ld	s3,144(sp)
    800058bc:	09813a03          	ld	s4,152(sp)
    800058c0:	0a013a83          	ld	s5,160(sp)
    800058c4:	0a813b03          	ld	s6,168(sp)
    800058c8:	0b013b83          	ld	s7,176(sp)
    800058cc:	0b813c03          	ld	s8,184(sp)
    800058d0:	0c013c83          	ld	s9,192(sp)
    800058d4:	0c813d03          	ld	s10,200(sp)
    800058d8:	0d013d83          	ld	s11,208(sp)
    800058dc:	0d813e03          	ld	t3,216(sp)
    800058e0:	0e013e83          	ld	t4,224(sp)
    800058e4:	0e813f03          	ld	t5,232(sp)
    800058e8:	0f013f83          	ld	t6,240(sp)
    800058ec:	10010113          	addi	sp,sp,256
    800058f0:	10200073          	sret
    800058f4:	00000013          	nop
    800058f8:	00000013          	nop
    800058fc:	00000013          	nop

0000000080005900 <timervec>:
    80005900:	34051573          	csrrw	a0,mscratch,a0
    80005904:	00b53023          	sd	a1,0(a0)
    80005908:	00c53423          	sd	a2,8(a0)
    8000590c:	00d53823          	sd	a3,16(a0)
    80005910:	01853583          	ld	a1,24(a0)
    80005914:	02053603          	ld	a2,32(a0)
    80005918:	0005b683          	ld	a3,0(a1)
    8000591c:	00c686b3          	add	a3,a3,a2
    80005920:	00d5b023          	sd	a3,0(a1)
    80005924:	00200593          	li	a1,2
    80005928:	14459073          	csrw	sip,a1
    8000592c:	01053683          	ld	a3,16(a0)
    80005930:	00853603          	ld	a2,8(a0)
    80005934:	00053583          	ld	a1,0(a0)
    80005938:	34051573          	csrrw	a0,mscratch,a0
    8000593c:	30200073          	mret

0000000080005940 <plicinit>:
    80005940:	ff010113          	addi	sp,sp,-16
    80005944:	00813423          	sd	s0,8(sp)
    80005948:	01010413          	addi	s0,sp,16
    8000594c:	00813403          	ld	s0,8(sp)
    80005950:	0c0007b7          	lui	a5,0xc000
    80005954:	00100713          	li	a4,1
    80005958:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000595c:	00e7a223          	sw	a4,4(a5)
    80005960:	01010113          	addi	sp,sp,16
    80005964:	00008067          	ret

0000000080005968 <plicinithart>:
    80005968:	ff010113          	addi	sp,sp,-16
    8000596c:	00813023          	sd	s0,0(sp)
    80005970:	00113423          	sd	ra,8(sp)
    80005974:	01010413          	addi	s0,sp,16
    80005978:	00000097          	auipc	ra,0x0
    8000597c:	a44080e7          	jalr	-1468(ra) # 800053bc <cpuid>
    80005980:	0085171b          	slliw	a4,a0,0x8
    80005984:	0c0027b7          	lui	a5,0xc002
    80005988:	00e787b3          	add	a5,a5,a4
    8000598c:	40200713          	li	a4,1026
    80005990:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005994:	00813083          	ld	ra,8(sp)
    80005998:	00013403          	ld	s0,0(sp)
    8000599c:	00d5151b          	slliw	a0,a0,0xd
    800059a0:	0c2017b7          	lui	a5,0xc201
    800059a4:	00a78533          	add	a0,a5,a0
    800059a8:	00052023          	sw	zero,0(a0)
    800059ac:	01010113          	addi	sp,sp,16
    800059b0:	00008067          	ret

00000000800059b4 <plic_claim>:
    800059b4:	ff010113          	addi	sp,sp,-16
    800059b8:	00813023          	sd	s0,0(sp)
    800059bc:	00113423          	sd	ra,8(sp)
    800059c0:	01010413          	addi	s0,sp,16
    800059c4:	00000097          	auipc	ra,0x0
    800059c8:	9f8080e7          	jalr	-1544(ra) # 800053bc <cpuid>
    800059cc:	00813083          	ld	ra,8(sp)
    800059d0:	00013403          	ld	s0,0(sp)
    800059d4:	00d5151b          	slliw	a0,a0,0xd
    800059d8:	0c2017b7          	lui	a5,0xc201
    800059dc:	00a78533          	add	a0,a5,a0
    800059e0:	00452503          	lw	a0,4(a0)
    800059e4:	01010113          	addi	sp,sp,16
    800059e8:	00008067          	ret

00000000800059ec <plic_complete>:
    800059ec:	fe010113          	addi	sp,sp,-32
    800059f0:	00813823          	sd	s0,16(sp)
    800059f4:	00913423          	sd	s1,8(sp)
    800059f8:	00113c23          	sd	ra,24(sp)
    800059fc:	02010413          	addi	s0,sp,32
    80005a00:	00050493          	mv	s1,a0
    80005a04:	00000097          	auipc	ra,0x0
    80005a08:	9b8080e7          	jalr	-1608(ra) # 800053bc <cpuid>
    80005a0c:	01813083          	ld	ra,24(sp)
    80005a10:	01013403          	ld	s0,16(sp)
    80005a14:	00d5179b          	slliw	a5,a0,0xd
    80005a18:	0c201737          	lui	a4,0xc201
    80005a1c:	00f707b3          	add	a5,a4,a5
    80005a20:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005a24:	00813483          	ld	s1,8(sp)
    80005a28:	02010113          	addi	sp,sp,32
    80005a2c:	00008067          	ret

0000000080005a30 <consolewrite>:
    80005a30:	fb010113          	addi	sp,sp,-80
    80005a34:	04813023          	sd	s0,64(sp)
    80005a38:	04113423          	sd	ra,72(sp)
    80005a3c:	02913c23          	sd	s1,56(sp)
    80005a40:	03213823          	sd	s2,48(sp)
    80005a44:	03313423          	sd	s3,40(sp)
    80005a48:	03413023          	sd	s4,32(sp)
    80005a4c:	01513c23          	sd	s5,24(sp)
    80005a50:	05010413          	addi	s0,sp,80
    80005a54:	06c05c63          	blez	a2,80005acc <consolewrite+0x9c>
    80005a58:	00060993          	mv	s3,a2
    80005a5c:	00050a13          	mv	s4,a0
    80005a60:	00058493          	mv	s1,a1
    80005a64:	00000913          	li	s2,0
    80005a68:	fff00a93          	li	s5,-1
    80005a6c:	01c0006f          	j	80005a88 <consolewrite+0x58>
    80005a70:	fbf44503          	lbu	a0,-65(s0)
    80005a74:	0019091b          	addiw	s2,s2,1
    80005a78:	00148493          	addi	s1,s1,1
    80005a7c:	00001097          	auipc	ra,0x1
    80005a80:	a9c080e7          	jalr	-1380(ra) # 80006518 <uartputc>
    80005a84:	03298063          	beq	s3,s2,80005aa4 <consolewrite+0x74>
    80005a88:	00048613          	mv	a2,s1
    80005a8c:	00100693          	li	a3,1
    80005a90:	000a0593          	mv	a1,s4
    80005a94:	fbf40513          	addi	a0,s0,-65
    80005a98:	00000097          	auipc	ra,0x0
    80005a9c:	9dc080e7          	jalr	-1572(ra) # 80005474 <either_copyin>
    80005aa0:	fd5518e3          	bne	a0,s5,80005a70 <consolewrite+0x40>
    80005aa4:	04813083          	ld	ra,72(sp)
    80005aa8:	04013403          	ld	s0,64(sp)
    80005aac:	03813483          	ld	s1,56(sp)
    80005ab0:	02813983          	ld	s3,40(sp)
    80005ab4:	02013a03          	ld	s4,32(sp)
    80005ab8:	01813a83          	ld	s5,24(sp)
    80005abc:	00090513          	mv	a0,s2
    80005ac0:	03013903          	ld	s2,48(sp)
    80005ac4:	05010113          	addi	sp,sp,80
    80005ac8:	00008067          	ret
    80005acc:	00000913          	li	s2,0
    80005ad0:	fd5ff06f          	j	80005aa4 <consolewrite+0x74>

0000000080005ad4 <consoleread>:
    80005ad4:	f9010113          	addi	sp,sp,-112
    80005ad8:	06813023          	sd	s0,96(sp)
    80005adc:	04913c23          	sd	s1,88(sp)
    80005ae0:	05213823          	sd	s2,80(sp)
    80005ae4:	05313423          	sd	s3,72(sp)
    80005ae8:	05413023          	sd	s4,64(sp)
    80005aec:	03513c23          	sd	s5,56(sp)
    80005af0:	03613823          	sd	s6,48(sp)
    80005af4:	03713423          	sd	s7,40(sp)
    80005af8:	03813023          	sd	s8,32(sp)
    80005afc:	06113423          	sd	ra,104(sp)
    80005b00:	01913c23          	sd	s9,24(sp)
    80005b04:	07010413          	addi	s0,sp,112
    80005b08:	00060b93          	mv	s7,a2
    80005b0c:	00050913          	mv	s2,a0
    80005b10:	00058c13          	mv	s8,a1
    80005b14:	00060b1b          	sext.w	s6,a2
    80005b18:	00008497          	auipc	s1,0x8
    80005b1c:	39048493          	addi	s1,s1,912 # 8000dea8 <cons>
    80005b20:	00400993          	li	s3,4
    80005b24:	fff00a13          	li	s4,-1
    80005b28:	00a00a93          	li	s5,10
    80005b2c:	05705e63          	blez	s7,80005b88 <consoleread+0xb4>
    80005b30:	09c4a703          	lw	a4,156(s1)
    80005b34:	0984a783          	lw	a5,152(s1)
    80005b38:	0007071b          	sext.w	a4,a4
    80005b3c:	08e78463          	beq	a5,a4,80005bc4 <consoleread+0xf0>
    80005b40:	07f7f713          	andi	a4,a5,127
    80005b44:	00e48733          	add	a4,s1,a4
    80005b48:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005b4c:	0017869b          	addiw	a3,a5,1
    80005b50:	08d4ac23          	sw	a3,152(s1)
    80005b54:	00070c9b          	sext.w	s9,a4
    80005b58:	0b370663          	beq	a4,s3,80005c04 <consoleread+0x130>
    80005b5c:	00100693          	li	a3,1
    80005b60:	f9f40613          	addi	a2,s0,-97
    80005b64:	000c0593          	mv	a1,s8
    80005b68:	00090513          	mv	a0,s2
    80005b6c:	f8e40fa3          	sb	a4,-97(s0)
    80005b70:	00000097          	auipc	ra,0x0
    80005b74:	8b8080e7          	jalr	-1864(ra) # 80005428 <either_copyout>
    80005b78:	01450863          	beq	a0,s4,80005b88 <consoleread+0xb4>
    80005b7c:	001c0c13          	addi	s8,s8,1
    80005b80:	fffb8b9b          	addiw	s7,s7,-1
    80005b84:	fb5c94e3          	bne	s9,s5,80005b2c <consoleread+0x58>
    80005b88:	000b851b          	sext.w	a0,s7
    80005b8c:	06813083          	ld	ra,104(sp)
    80005b90:	06013403          	ld	s0,96(sp)
    80005b94:	05813483          	ld	s1,88(sp)
    80005b98:	05013903          	ld	s2,80(sp)
    80005b9c:	04813983          	ld	s3,72(sp)
    80005ba0:	04013a03          	ld	s4,64(sp)
    80005ba4:	03813a83          	ld	s5,56(sp)
    80005ba8:	02813b83          	ld	s7,40(sp)
    80005bac:	02013c03          	ld	s8,32(sp)
    80005bb0:	01813c83          	ld	s9,24(sp)
    80005bb4:	40ab053b          	subw	a0,s6,a0
    80005bb8:	03013b03          	ld	s6,48(sp)
    80005bbc:	07010113          	addi	sp,sp,112
    80005bc0:	00008067          	ret
    80005bc4:	00001097          	auipc	ra,0x1
    80005bc8:	1d8080e7          	jalr	472(ra) # 80006d9c <push_on>
    80005bcc:	0984a703          	lw	a4,152(s1)
    80005bd0:	09c4a783          	lw	a5,156(s1)
    80005bd4:	0007879b          	sext.w	a5,a5
    80005bd8:	fef70ce3          	beq	a4,a5,80005bd0 <consoleread+0xfc>
    80005bdc:	00001097          	auipc	ra,0x1
    80005be0:	234080e7          	jalr	564(ra) # 80006e10 <pop_on>
    80005be4:	0984a783          	lw	a5,152(s1)
    80005be8:	07f7f713          	andi	a4,a5,127
    80005bec:	00e48733          	add	a4,s1,a4
    80005bf0:	01874703          	lbu	a4,24(a4)
    80005bf4:	0017869b          	addiw	a3,a5,1
    80005bf8:	08d4ac23          	sw	a3,152(s1)
    80005bfc:	00070c9b          	sext.w	s9,a4
    80005c00:	f5371ee3          	bne	a4,s3,80005b5c <consoleread+0x88>
    80005c04:	000b851b          	sext.w	a0,s7
    80005c08:	f96bf2e3          	bgeu	s7,s6,80005b8c <consoleread+0xb8>
    80005c0c:	08f4ac23          	sw	a5,152(s1)
    80005c10:	f7dff06f          	j	80005b8c <consoleread+0xb8>

0000000080005c14 <consputc>:
    80005c14:	10000793          	li	a5,256
    80005c18:	00f50663          	beq	a0,a5,80005c24 <consputc+0x10>
    80005c1c:	00001317          	auipc	t1,0x1
    80005c20:	9f430067          	jr	-1548(t1) # 80006610 <uartputc_sync>
    80005c24:	ff010113          	addi	sp,sp,-16
    80005c28:	00113423          	sd	ra,8(sp)
    80005c2c:	00813023          	sd	s0,0(sp)
    80005c30:	01010413          	addi	s0,sp,16
    80005c34:	00800513          	li	a0,8
    80005c38:	00001097          	auipc	ra,0x1
    80005c3c:	9d8080e7          	jalr	-1576(ra) # 80006610 <uartputc_sync>
    80005c40:	02000513          	li	a0,32
    80005c44:	00001097          	auipc	ra,0x1
    80005c48:	9cc080e7          	jalr	-1588(ra) # 80006610 <uartputc_sync>
    80005c4c:	00013403          	ld	s0,0(sp)
    80005c50:	00813083          	ld	ra,8(sp)
    80005c54:	00800513          	li	a0,8
    80005c58:	01010113          	addi	sp,sp,16
    80005c5c:	00001317          	auipc	t1,0x1
    80005c60:	9b430067          	jr	-1612(t1) # 80006610 <uartputc_sync>

0000000080005c64 <consoleintr>:
    80005c64:	fe010113          	addi	sp,sp,-32
    80005c68:	00813823          	sd	s0,16(sp)
    80005c6c:	00913423          	sd	s1,8(sp)
    80005c70:	01213023          	sd	s2,0(sp)
    80005c74:	00113c23          	sd	ra,24(sp)
    80005c78:	02010413          	addi	s0,sp,32
    80005c7c:	00008917          	auipc	s2,0x8
    80005c80:	22c90913          	addi	s2,s2,556 # 8000dea8 <cons>
    80005c84:	00050493          	mv	s1,a0
    80005c88:	00090513          	mv	a0,s2
    80005c8c:	00001097          	auipc	ra,0x1
    80005c90:	e40080e7          	jalr	-448(ra) # 80006acc <acquire>
    80005c94:	02048c63          	beqz	s1,80005ccc <consoleintr+0x68>
    80005c98:	0a092783          	lw	a5,160(s2)
    80005c9c:	09892703          	lw	a4,152(s2)
    80005ca0:	07f00693          	li	a3,127
    80005ca4:	40e7873b          	subw	a4,a5,a4
    80005ca8:	02e6e263          	bltu	a3,a4,80005ccc <consoleintr+0x68>
    80005cac:	00d00713          	li	a4,13
    80005cb0:	04e48063          	beq	s1,a4,80005cf0 <consoleintr+0x8c>
    80005cb4:	07f7f713          	andi	a4,a5,127
    80005cb8:	00e90733          	add	a4,s2,a4
    80005cbc:	0017879b          	addiw	a5,a5,1
    80005cc0:	0af92023          	sw	a5,160(s2)
    80005cc4:	00970c23          	sb	s1,24(a4)
    80005cc8:	08f92e23          	sw	a5,156(s2)
    80005ccc:	01013403          	ld	s0,16(sp)
    80005cd0:	01813083          	ld	ra,24(sp)
    80005cd4:	00813483          	ld	s1,8(sp)
    80005cd8:	00013903          	ld	s2,0(sp)
    80005cdc:	00008517          	auipc	a0,0x8
    80005ce0:	1cc50513          	addi	a0,a0,460 # 8000dea8 <cons>
    80005ce4:	02010113          	addi	sp,sp,32
    80005ce8:	00001317          	auipc	t1,0x1
    80005cec:	eb030067          	jr	-336(t1) # 80006b98 <release>
    80005cf0:	00a00493          	li	s1,10
    80005cf4:	fc1ff06f          	j	80005cb4 <consoleintr+0x50>

0000000080005cf8 <consoleinit>:
    80005cf8:	fe010113          	addi	sp,sp,-32
    80005cfc:	00113c23          	sd	ra,24(sp)
    80005d00:	00813823          	sd	s0,16(sp)
    80005d04:	00913423          	sd	s1,8(sp)
    80005d08:	02010413          	addi	s0,sp,32
    80005d0c:	00008497          	auipc	s1,0x8
    80005d10:	19c48493          	addi	s1,s1,412 # 8000dea8 <cons>
    80005d14:	00048513          	mv	a0,s1
    80005d18:	00003597          	auipc	a1,0x3
    80005d1c:	9b858593          	addi	a1,a1,-1608 # 800086d0 <CONSOLE_STATUS+0x6c0>
    80005d20:	00001097          	auipc	ra,0x1
    80005d24:	d88080e7          	jalr	-632(ra) # 80006aa8 <initlock>
    80005d28:	00000097          	auipc	ra,0x0
    80005d2c:	7ac080e7          	jalr	1964(ra) # 800064d4 <uartinit>
    80005d30:	01813083          	ld	ra,24(sp)
    80005d34:	01013403          	ld	s0,16(sp)
    80005d38:	00000797          	auipc	a5,0x0
    80005d3c:	d9c78793          	addi	a5,a5,-612 # 80005ad4 <consoleread>
    80005d40:	0af4bc23          	sd	a5,184(s1)
    80005d44:	00000797          	auipc	a5,0x0
    80005d48:	cec78793          	addi	a5,a5,-788 # 80005a30 <consolewrite>
    80005d4c:	0cf4b023          	sd	a5,192(s1)
    80005d50:	00813483          	ld	s1,8(sp)
    80005d54:	02010113          	addi	sp,sp,32
    80005d58:	00008067          	ret

0000000080005d5c <console_read>:
    80005d5c:	ff010113          	addi	sp,sp,-16
    80005d60:	00813423          	sd	s0,8(sp)
    80005d64:	01010413          	addi	s0,sp,16
    80005d68:	00813403          	ld	s0,8(sp)
    80005d6c:	00008317          	auipc	t1,0x8
    80005d70:	1f433303          	ld	t1,500(t1) # 8000df60 <devsw+0x10>
    80005d74:	01010113          	addi	sp,sp,16
    80005d78:	00030067          	jr	t1

0000000080005d7c <console_write>:
    80005d7c:	ff010113          	addi	sp,sp,-16
    80005d80:	00813423          	sd	s0,8(sp)
    80005d84:	01010413          	addi	s0,sp,16
    80005d88:	00813403          	ld	s0,8(sp)
    80005d8c:	00008317          	auipc	t1,0x8
    80005d90:	1dc33303          	ld	t1,476(t1) # 8000df68 <devsw+0x18>
    80005d94:	01010113          	addi	sp,sp,16
    80005d98:	00030067          	jr	t1

0000000080005d9c <panic>:
    80005d9c:	fe010113          	addi	sp,sp,-32
    80005da0:	00113c23          	sd	ra,24(sp)
    80005da4:	00813823          	sd	s0,16(sp)
    80005da8:	00913423          	sd	s1,8(sp)
    80005dac:	02010413          	addi	s0,sp,32
    80005db0:	00050493          	mv	s1,a0
    80005db4:	00003517          	auipc	a0,0x3
    80005db8:	92450513          	addi	a0,a0,-1756 # 800086d8 <CONSOLE_STATUS+0x6c8>
    80005dbc:	00008797          	auipc	a5,0x8
    80005dc0:	2407a623          	sw	zero,588(a5) # 8000e008 <pr+0x18>
    80005dc4:	00000097          	auipc	ra,0x0
    80005dc8:	034080e7          	jalr	52(ra) # 80005df8 <__printf>
    80005dcc:	00048513          	mv	a0,s1
    80005dd0:	00000097          	auipc	ra,0x0
    80005dd4:	028080e7          	jalr	40(ra) # 80005df8 <__printf>
    80005dd8:	00002517          	auipc	a0,0x2
    80005ddc:	5b850513          	addi	a0,a0,1464 # 80008390 <CONSOLE_STATUS+0x380>
    80005de0:	00000097          	auipc	ra,0x0
    80005de4:	018080e7          	jalr	24(ra) # 80005df8 <__printf>
    80005de8:	00100793          	li	a5,1
    80005dec:	00003717          	auipc	a4,0x3
    80005df0:	d6f72e23          	sw	a5,-644(a4) # 80008b68 <panicked>
    80005df4:	0000006f          	j	80005df4 <panic+0x58>

0000000080005df8 <__printf>:
    80005df8:	f3010113          	addi	sp,sp,-208
    80005dfc:	08813023          	sd	s0,128(sp)
    80005e00:	07313423          	sd	s3,104(sp)
    80005e04:	09010413          	addi	s0,sp,144
    80005e08:	05813023          	sd	s8,64(sp)
    80005e0c:	08113423          	sd	ra,136(sp)
    80005e10:	06913c23          	sd	s1,120(sp)
    80005e14:	07213823          	sd	s2,112(sp)
    80005e18:	07413023          	sd	s4,96(sp)
    80005e1c:	05513c23          	sd	s5,88(sp)
    80005e20:	05613823          	sd	s6,80(sp)
    80005e24:	05713423          	sd	s7,72(sp)
    80005e28:	03913c23          	sd	s9,56(sp)
    80005e2c:	03a13823          	sd	s10,48(sp)
    80005e30:	03b13423          	sd	s11,40(sp)
    80005e34:	00008317          	auipc	t1,0x8
    80005e38:	1bc30313          	addi	t1,t1,444 # 8000dff0 <pr>
    80005e3c:	01832c03          	lw	s8,24(t1)
    80005e40:	00b43423          	sd	a1,8(s0)
    80005e44:	00c43823          	sd	a2,16(s0)
    80005e48:	00d43c23          	sd	a3,24(s0)
    80005e4c:	02e43023          	sd	a4,32(s0)
    80005e50:	02f43423          	sd	a5,40(s0)
    80005e54:	03043823          	sd	a6,48(s0)
    80005e58:	03143c23          	sd	a7,56(s0)
    80005e5c:	00050993          	mv	s3,a0
    80005e60:	4a0c1663          	bnez	s8,8000630c <__printf+0x514>
    80005e64:	60098c63          	beqz	s3,8000647c <__printf+0x684>
    80005e68:	0009c503          	lbu	a0,0(s3)
    80005e6c:	00840793          	addi	a5,s0,8
    80005e70:	f6f43c23          	sd	a5,-136(s0)
    80005e74:	00000493          	li	s1,0
    80005e78:	22050063          	beqz	a0,80006098 <__printf+0x2a0>
    80005e7c:	00002a37          	lui	s4,0x2
    80005e80:	00018ab7          	lui	s5,0x18
    80005e84:	000f4b37          	lui	s6,0xf4
    80005e88:	00989bb7          	lui	s7,0x989
    80005e8c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005e90:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005e94:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005e98:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005e9c:	00148c9b          	addiw	s9,s1,1
    80005ea0:	02500793          	li	a5,37
    80005ea4:	01998933          	add	s2,s3,s9
    80005ea8:	38f51263          	bne	a0,a5,8000622c <__printf+0x434>
    80005eac:	00094783          	lbu	a5,0(s2)
    80005eb0:	00078c9b          	sext.w	s9,a5
    80005eb4:	1e078263          	beqz	a5,80006098 <__printf+0x2a0>
    80005eb8:	0024849b          	addiw	s1,s1,2
    80005ebc:	07000713          	li	a4,112
    80005ec0:	00998933          	add	s2,s3,s1
    80005ec4:	38e78a63          	beq	a5,a4,80006258 <__printf+0x460>
    80005ec8:	20f76863          	bltu	a4,a5,800060d8 <__printf+0x2e0>
    80005ecc:	42a78863          	beq	a5,a0,800062fc <__printf+0x504>
    80005ed0:	06400713          	li	a4,100
    80005ed4:	40e79663          	bne	a5,a4,800062e0 <__printf+0x4e8>
    80005ed8:	f7843783          	ld	a5,-136(s0)
    80005edc:	0007a603          	lw	a2,0(a5)
    80005ee0:	00878793          	addi	a5,a5,8
    80005ee4:	f6f43c23          	sd	a5,-136(s0)
    80005ee8:	42064a63          	bltz	a2,8000631c <__printf+0x524>
    80005eec:	00a00713          	li	a4,10
    80005ef0:	02e677bb          	remuw	a5,a2,a4
    80005ef4:	00003d97          	auipc	s11,0x3
    80005ef8:	80cd8d93          	addi	s11,s11,-2036 # 80008700 <digits>
    80005efc:	00900593          	li	a1,9
    80005f00:	0006051b          	sext.w	a0,a2
    80005f04:	00000c93          	li	s9,0
    80005f08:	02079793          	slli	a5,a5,0x20
    80005f0c:	0207d793          	srli	a5,a5,0x20
    80005f10:	00fd87b3          	add	a5,s11,a5
    80005f14:	0007c783          	lbu	a5,0(a5)
    80005f18:	02e656bb          	divuw	a3,a2,a4
    80005f1c:	f8f40023          	sb	a5,-128(s0)
    80005f20:	14c5d863          	bge	a1,a2,80006070 <__printf+0x278>
    80005f24:	06300593          	li	a1,99
    80005f28:	00100c93          	li	s9,1
    80005f2c:	02e6f7bb          	remuw	a5,a3,a4
    80005f30:	02079793          	slli	a5,a5,0x20
    80005f34:	0207d793          	srli	a5,a5,0x20
    80005f38:	00fd87b3          	add	a5,s11,a5
    80005f3c:	0007c783          	lbu	a5,0(a5)
    80005f40:	02e6d73b          	divuw	a4,a3,a4
    80005f44:	f8f400a3          	sb	a5,-127(s0)
    80005f48:	12a5f463          	bgeu	a1,a0,80006070 <__printf+0x278>
    80005f4c:	00a00693          	li	a3,10
    80005f50:	00900593          	li	a1,9
    80005f54:	02d777bb          	remuw	a5,a4,a3
    80005f58:	02079793          	slli	a5,a5,0x20
    80005f5c:	0207d793          	srli	a5,a5,0x20
    80005f60:	00fd87b3          	add	a5,s11,a5
    80005f64:	0007c503          	lbu	a0,0(a5)
    80005f68:	02d757bb          	divuw	a5,a4,a3
    80005f6c:	f8a40123          	sb	a0,-126(s0)
    80005f70:	48e5f263          	bgeu	a1,a4,800063f4 <__printf+0x5fc>
    80005f74:	06300513          	li	a0,99
    80005f78:	02d7f5bb          	remuw	a1,a5,a3
    80005f7c:	02059593          	slli	a1,a1,0x20
    80005f80:	0205d593          	srli	a1,a1,0x20
    80005f84:	00bd85b3          	add	a1,s11,a1
    80005f88:	0005c583          	lbu	a1,0(a1)
    80005f8c:	02d7d7bb          	divuw	a5,a5,a3
    80005f90:	f8b401a3          	sb	a1,-125(s0)
    80005f94:	48e57263          	bgeu	a0,a4,80006418 <__printf+0x620>
    80005f98:	3e700513          	li	a0,999
    80005f9c:	02d7f5bb          	remuw	a1,a5,a3
    80005fa0:	02059593          	slli	a1,a1,0x20
    80005fa4:	0205d593          	srli	a1,a1,0x20
    80005fa8:	00bd85b3          	add	a1,s11,a1
    80005fac:	0005c583          	lbu	a1,0(a1)
    80005fb0:	02d7d7bb          	divuw	a5,a5,a3
    80005fb4:	f8b40223          	sb	a1,-124(s0)
    80005fb8:	46e57663          	bgeu	a0,a4,80006424 <__printf+0x62c>
    80005fbc:	02d7f5bb          	remuw	a1,a5,a3
    80005fc0:	02059593          	slli	a1,a1,0x20
    80005fc4:	0205d593          	srli	a1,a1,0x20
    80005fc8:	00bd85b3          	add	a1,s11,a1
    80005fcc:	0005c583          	lbu	a1,0(a1)
    80005fd0:	02d7d7bb          	divuw	a5,a5,a3
    80005fd4:	f8b402a3          	sb	a1,-123(s0)
    80005fd8:	46ea7863          	bgeu	s4,a4,80006448 <__printf+0x650>
    80005fdc:	02d7f5bb          	remuw	a1,a5,a3
    80005fe0:	02059593          	slli	a1,a1,0x20
    80005fe4:	0205d593          	srli	a1,a1,0x20
    80005fe8:	00bd85b3          	add	a1,s11,a1
    80005fec:	0005c583          	lbu	a1,0(a1)
    80005ff0:	02d7d7bb          	divuw	a5,a5,a3
    80005ff4:	f8b40323          	sb	a1,-122(s0)
    80005ff8:	3eeaf863          	bgeu	s5,a4,800063e8 <__printf+0x5f0>
    80005ffc:	02d7f5bb          	remuw	a1,a5,a3
    80006000:	02059593          	slli	a1,a1,0x20
    80006004:	0205d593          	srli	a1,a1,0x20
    80006008:	00bd85b3          	add	a1,s11,a1
    8000600c:	0005c583          	lbu	a1,0(a1)
    80006010:	02d7d7bb          	divuw	a5,a5,a3
    80006014:	f8b403a3          	sb	a1,-121(s0)
    80006018:	42eb7e63          	bgeu	s6,a4,80006454 <__printf+0x65c>
    8000601c:	02d7f5bb          	remuw	a1,a5,a3
    80006020:	02059593          	slli	a1,a1,0x20
    80006024:	0205d593          	srli	a1,a1,0x20
    80006028:	00bd85b3          	add	a1,s11,a1
    8000602c:	0005c583          	lbu	a1,0(a1)
    80006030:	02d7d7bb          	divuw	a5,a5,a3
    80006034:	f8b40423          	sb	a1,-120(s0)
    80006038:	42ebfc63          	bgeu	s7,a4,80006470 <__printf+0x678>
    8000603c:	02079793          	slli	a5,a5,0x20
    80006040:	0207d793          	srli	a5,a5,0x20
    80006044:	00fd8db3          	add	s11,s11,a5
    80006048:	000dc703          	lbu	a4,0(s11)
    8000604c:	00a00793          	li	a5,10
    80006050:	00900c93          	li	s9,9
    80006054:	f8e404a3          	sb	a4,-119(s0)
    80006058:	00065c63          	bgez	a2,80006070 <__printf+0x278>
    8000605c:	f9040713          	addi	a4,s0,-112
    80006060:	00f70733          	add	a4,a4,a5
    80006064:	02d00693          	li	a3,45
    80006068:	fed70823          	sb	a3,-16(a4)
    8000606c:	00078c93          	mv	s9,a5
    80006070:	f8040793          	addi	a5,s0,-128
    80006074:	01978cb3          	add	s9,a5,s9
    80006078:	f7f40d13          	addi	s10,s0,-129
    8000607c:	000cc503          	lbu	a0,0(s9)
    80006080:	fffc8c93          	addi	s9,s9,-1
    80006084:	00000097          	auipc	ra,0x0
    80006088:	b90080e7          	jalr	-1136(ra) # 80005c14 <consputc>
    8000608c:	ffac98e3          	bne	s9,s10,8000607c <__printf+0x284>
    80006090:	00094503          	lbu	a0,0(s2)
    80006094:	e00514e3          	bnez	a0,80005e9c <__printf+0xa4>
    80006098:	1a0c1663          	bnez	s8,80006244 <__printf+0x44c>
    8000609c:	08813083          	ld	ra,136(sp)
    800060a0:	08013403          	ld	s0,128(sp)
    800060a4:	07813483          	ld	s1,120(sp)
    800060a8:	07013903          	ld	s2,112(sp)
    800060ac:	06813983          	ld	s3,104(sp)
    800060b0:	06013a03          	ld	s4,96(sp)
    800060b4:	05813a83          	ld	s5,88(sp)
    800060b8:	05013b03          	ld	s6,80(sp)
    800060bc:	04813b83          	ld	s7,72(sp)
    800060c0:	04013c03          	ld	s8,64(sp)
    800060c4:	03813c83          	ld	s9,56(sp)
    800060c8:	03013d03          	ld	s10,48(sp)
    800060cc:	02813d83          	ld	s11,40(sp)
    800060d0:	0d010113          	addi	sp,sp,208
    800060d4:	00008067          	ret
    800060d8:	07300713          	li	a4,115
    800060dc:	1ce78a63          	beq	a5,a4,800062b0 <__printf+0x4b8>
    800060e0:	07800713          	li	a4,120
    800060e4:	1ee79e63          	bne	a5,a4,800062e0 <__printf+0x4e8>
    800060e8:	f7843783          	ld	a5,-136(s0)
    800060ec:	0007a703          	lw	a4,0(a5)
    800060f0:	00878793          	addi	a5,a5,8
    800060f4:	f6f43c23          	sd	a5,-136(s0)
    800060f8:	28074263          	bltz	a4,8000637c <__printf+0x584>
    800060fc:	00002d97          	auipc	s11,0x2
    80006100:	604d8d93          	addi	s11,s11,1540 # 80008700 <digits>
    80006104:	00f77793          	andi	a5,a4,15
    80006108:	00fd87b3          	add	a5,s11,a5
    8000610c:	0007c683          	lbu	a3,0(a5)
    80006110:	00f00613          	li	a2,15
    80006114:	0007079b          	sext.w	a5,a4
    80006118:	f8d40023          	sb	a3,-128(s0)
    8000611c:	0047559b          	srliw	a1,a4,0x4
    80006120:	0047569b          	srliw	a3,a4,0x4
    80006124:	00000c93          	li	s9,0
    80006128:	0ee65063          	bge	a2,a4,80006208 <__printf+0x410>
    8000612c:	00f6f693          	andi	a3,a3,15
    80006130:	00dd86b3          	add	a3,s11,a3
    80006134:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80006138:	0087d79b          	srliw	a5,a5,0x8
    8000613c:	00100c93          	li	s9,1
    80006140:	f8d400a3          	sb	a3,-127(s0)
    80006144:	0cb67263          	bgeu	a2,a1,80006208 <__printf+0x410>
    80006148:	00f7f693          	andi	a3,a5,15
    8000614c:	00dd86b3          	add	a3,s11,a3
    80006150:	0006c583          	lbu	a1,0(a3)
    80006154:	00f00613          	li	a2,15
    80006158:	0047d69b          	srliw	a3,a5,0x4
    8000615c:	f8b40123          	sb	a1,-126(s0)
    80006160:	0047d593          	srli	a1,a5,0x4
    80006164:	28f67e63          	bgeu	a2,a5,80006400 <__printf+0x608>
    80006168:	00f6f693          	andi	a3,a3,15
    8000616c:	00dd86b3          	add	a3,s11,a3
    80006170:	0006c503          	lbu	a0,0(a3)
    80006174:	0087d813          	srli	a6,a5,0x8
    80006178:	0087d69b          	srliw	a3,a5,0x8
    8000617c:	f8a401a3          	sb	a0,-125(s0)
    80006180:	28b67663          	bgeu	a2,a1,8000640c <__printf+0x614>
    80006184:	00f6f693          	andi	a3,a3,15
    80006188:	00dd86b3          	add	a3,s11,a3
    8000618c:	0006c583          	lbu	a1,0(a3)
    80006190:	00c7d513          	srli	a0,a5,0xc
    80006194:	00c7d69b          	srliw	a3,a5,0xc
    80006198:	f8b40223          	sb	a1,-124(s0)
    8000619c:	29067a63          	bgeu	a2,a6,80006430 <__printf+0x638>
    800061a0:	00f6f693          	andi	a3,a3,15
    800061a4:	00dd86b3          	add	a3,s11,a3
    800061a8:	0006c583          	lbu	a1,0(a3)
    800061ac:	0107d813          	srli	a6,a5,0x10
    800061b0:	0107d69b          	srliw	a3,a5,0x10
    800061b4:	f8b402a3          	sb	a1,-123(s0)
    800061b8:	28a67263          	bgeu	a2,a0,8000643c <__printf+0x644>
    800061bc:	00f6f693          	andi	a3,a3,15
    800061c0:	00dd86b3          	add	a3,s11,a3
    800061c4:	0006c683          	lbu	a3,0(a3)
    800061c8:	0147d79b          	srliw	a5,a5,0x14
    800061cc:	f8d40323          	sb	a3,-122(s0)
    800061d0:	21067663          	bgeu	a2,a6,800063dc <__printf+0x5e4>
    800061d4:	02079793          	slli	a5,a5,0x20
    800061d8:	0207d793          	srli	a5,a5,0x20
    800061dc:	00fd8db3          	add	s11,s11,a5
    800061e0:	000dc683          	lbu	a3,0(s11)
    800061e4:	00800793          	li	a5,8
    800061e8:	00700c93          	li	s9,7
    800061ec:	f8d403a3          	sb	a3,-121(s0)
    800061f0:	00075c63          	bgez	a4,80006208 <__printf+0x410>
    800061f4:	f9040713          	addi	a4,s0,-112
    800061f8:	00f70733          	add	a4,a4,a5
    800061fc:	02d00693          	li	a3,45
    80006200:	fed70823          	sb	a3,-16(a4)
    80006204:	00078c93          	mv	s9,a5
    80006208:	f8040793          	addi	a5,s0,-128
    8000620c:	01978cb3          	add	s9,a5,s9
    80006210:	f7f40d13          	addi	s10,s0,-129
    80006214:	000cc503          	lbu	a0,0(s9)
    80006218:	fffc8c93          	addi	s9,s9,-1
    8000621c:	00000097          	auipc	ra,0x0
    80006220:	9f8080e7          	jalr	-1544(ra) # 80005c14 <consputc>
    80006224:	ff9d18e3          	bne	s10,s9,80006214 <__printf+0x41c>
    80006228:	0100006f          	j	80006238 <__printf+0x440>
    8000622c:	00000097          	auipc	ra,0x0
    80006230:	9e8080e7          	jalr	-1560(ra) # 80005c14 <consputc>
    80006234:	000c8493          	mv	s1,s9
    80006238:	00094503          	lbu	a0,0(s2)
    8000623c:	c60510e3          	bnez	a0,80005e9c <__printf+0xa4>
    80006240:	e40c0ee3          	beqz	s8,8000609c <__printf+0x2a4>
    80006244:	00008517          	auipc	a0,0x8
    80006248:	dac50513          	addi	a0,a0,-596 # 8000dff0 <pr>
    8000624c:	00001097          	auipc	ra,0x1
    80006250:	94c080e7          	jalr	-1716(ra) # 80006b98 <release>
    80006254:	e49ff06f          	j	8000609c <__printf+0x2a4>
    80006258:	f7843783          	ld	a5,-136(s0)
    8000625c:	03000513          	li	a0,48
    80006260:	01000d13          	li	s10,16
    80006264:	00878713          	addi	a4,a5,8
    80006268:	0007bc83          	ld	s9,0(a5)
    8000626c:	f6e43c23          	sd	a4,-136(s0)
    80006270:	00000097          	auipc	ra,0x0
    80006274:	9a4080e7          	jalr	-1628(ra) # 80005c14 <consputc>
    80006278:	07800513          	li	a0,120
    8000627c:	00000097          	auipc	ra,0x0
    80006280:	998080e7          	jalr	-1640(ra) # 80005c14 <consputc>
    80006284:	00002d97          	auipc	s11,0x2
    80006288:	47cd8d93          	addi	s11,s11,1148 # 80008700 <digits>
    8000628c:	03ccd793          	srli	a5,s9,0x3c
    80006290:	00fd87b3          	add	a5,s11,a5
    80006294:	0007c503          	lbu	a0,0(a5)
    80006298:	fffd0d1b          	addiw	s10,s10,-1
    8000629c:	004c9c93          	slli	s9,s9,0x4
    800062a0:	00000097          	auipc	ra,0x0
    800062a4:	974080e7          	jalr	-1676(ra) # 80005c14 <consputc>
    800062a8:	fe0d12e3          	bnez	s10,8000628c <__printf+0x494>
    800062ac:	f8dff06f          	j	80006238 <__printf+0x440>
    800062b0:	f7843783          	ld	a5,-136(s0)
    800062b4:	0007bc83          	ld	s9,0(a5)
    800062b8:	00878793          	addi	a5,a5,8
    800062bc:	f6f43c23          	sd	a5,-136(s0)
    800062c0:	000c9a63          	bnez	s9,800062d4 <__printf+0x4dc>
    800062c4:	1080006f          	j	800063cc <__printf+0x5d4>
    800062c8:	001c8c93          	addi	s9,s9,1
    800062cc:	00000097          	auipc	ra,0x0
    800062d0:	948080e7          	jalr	-1720(ra) # 80005c14 <consputc>
    800062d4:	000cc503          	lbu	a0,0(s9)
    800062d8:	fe0518e3          	bnez	a0,800062c8 <__printf+0x4d0>
    800062dc:	f5dff06f          	j	80006238 <__printf+0x440>
    800062e0:	02500513          	li	a0,37
    800062e4:	00000097          	auipc	ra,0x0
    800062e8:	930080e7          	jalr	-1744(ra) # 80005c14 <consputc>
    800062ec:	000c8513          	mv	a0,s9
    800062f0:	00000097          	auipc	ra,0x0
    800062f4:	924080e7          	jalr	-1756(ra) # 80005c14 <consputc>
    800062f8:	f41ff06f          	j	80006238 <__printf+0x440>
    800062fc:	02500513          	li	a0,37
    80006300:	00000097          	auipc	ra,0x0
    80006304:	914080e7          	jalr	-1772(ra) # 80005c14 <consputc>
    80006308:	f31ff06f          	j	80006238 <__printf+0x440>
    8000630c:	00030513          	mv	a0,t1
    80006310:	00000097          	auipc	ra,0x0
    80006314:	7bc080e7          	jalr	1980(ra) # 80006acc <acquire>
    80006318:	b4dff06f          	j	80005e64 <__printf+0x6c>
    8000631c:	40c0053b          	negw	a0,a2
    80006320:	00a00713          	li	a4,10
    80006324:	02e576bb          	remuw	a3,a0,a4
    80006328:	00002d97          	auipc	s11,0x2
    8000632c:	3d8d8d93          	addi	s11,s11,984 # 80008700 <digits>
    80006330:	ff700593          	li	a1,-9
    80006334:	02069693          	slli	a3,a3,0x20
    80006338:	0206d693          	srli	a3,a3,0x20
    8000633c:	00dd86b3          	add	a3,s11,a3
    80006340:	0006c683          	lbu	a3,0(a3)
    80006344:	02e557bb          	divuw	a5,a0,a4
    80006348:	f8d40023          	sb	a3,-128(s0)
    8000634c:	10b65e63          	bge	a2,a1,80006468 <__printf+0x670>
    80006350:	06300593          	li	a1,99
    80006354:	02e7f6bb          	remuw	a3,a5,a4
    80006358:	02069693          	slli	a3,a3,0x20
    8000635c:	0206d693          	srli	a3,a3,0x20
    80006360:	00dd86b3          	add	a3,s11,a3
    80006364:	0006c683          	lbu	a3,0(a3)
    80006368:	02e7d73b          	divuw	a4,a5,a4
    8000636c:	00200793          	li	a5,2
    80006370:	f8d400a3          	sb	a3,-127(s0)
    80006374:	bca5ece3          	bltu	a1,a0,80005f4c <__printf+0x154>
    80006378:	ce5ff06f          	j	8000605c <__printf+0x264>
    8000637c:	40e007bb          	negw	a5,a4
    80006380:	00002d97          	auipc	s11,0x2
    80006384:	380d8d93          	addi	s11,s11,896 # 80008700 <digits>
    80006388:	00f7f693          	andi	a3,a5,15
    8000638c:	00dd86b3          	add	a3,s11,a3
    80006390:	0006c583          	lbu	a1,0(a3)
    80006394:	ff100613          	li	a2,-15
    80006398:	0047d69b          	srliw	a3,a5,0x4
    8000639c:	f8b40023          	sb	a1,-128(s0)
    800063a0:	0047d59b          	srliw	a1,a5,0x4
    800063a4:	0ac75e63          	bge	a4,a2,80006460 <__printf+0x668>
    800063a8:	00f6f693          	andi	a3,a3,15
    800063ac:	00dd86b3          	add	a3,s11,a3
    800063b0:	0006c603          	lbu	a2,0(a3)
    800063b4:	00f00693          	li	a3,15
    800063b8:	0087d79b          	srliw	a5,a5,0x8
    800063bc:	f8c400a3          	sb	a2,-127(s0)
    800063c0:	d8b6e4e3          	bltu	a3,a1,80006148 <__printf+0x350>
    800063c4:	00200793          	li	a5,2
    800063c8:	e2dff06f          	j	800061f4 <__printf+0x3fc>
    800063cc:	00002c97          	auipc	s9,0x2
    800063d0:	314c8c93          	addi	s9,s9,788 # 800086e0 <CONSOLE_STATUS+0x6d0>
    800063d4:	02800513          	li	a0,40
    800063d8:	ef1ff06f          	j	800062c8 <__printf+0x4d0>
    800063dc:	00700793          	li	a5,7
    800063e0:	00600c93          	li	s9,6
    800063e4:	e0dff06f          	j	800061f0 <__printf+0x3f8>
    800063e8:	00700793          	li	a5,7
    800063ec:	00600c93          	li	s9,6
    800063f0:	c69ff06f          	j	80006058 <__printf+0x260>
    800063f4:	00300793          	li	a5,3
    800063f8:	00200c93          	li	s9,2
    800063fc:	c5dff06f          	j	80006058 <__printf+0x260>
    80006400:	00300793          	li	a5,3
    80006404:	00200c93          	li	s9,2
    80006408:	de9ff06f          	j	800061f0 <__printf+0x3f8>
    8000640c:	00400793          	li	a5,4
    80006410:	00300c93          	li	s9,3
    80006414:	dddff06f          	j	800061f0 <__printf+0x3f8>
    80006418:	00400793          	li	a5,4
    8000641c:	00300c93          	li	s9,3
    80006420:	c39ff06f          	j	80006058 <__printf+0x260>
    80006424:	00500793          	li	a5,5
    80006428:	00400c93          	li	s9,4
    8000642c:	c2dff06f          	j	80006058 <__printf+0x260>
    80006430:	00500793          	li	a5,5
    80006434:	00400c93          	li	s9,4
    80006438:	db9ff06f          	j	800061f0 <__printf+0x3f8>
    8000643c:	00600793          	li	a5,6
    80006440:	00500c93          	li	s9,5
    80006444:	dadff06f          	j	800061f0 <__printf+0x3f8>
    80006448:	00600793          	li	a5,6
    8000644c:	00500c93          	li	s9,5
    80006450:	c09ff06f          	j	80006058 <__printf+0x260>
    80006454:	00800793          	li	a5,8
    80006458:	00700c93          	li	s9,7
    8000645c:	bfdff06f          	j	80006058 <__printf+0x260>
    80006460:	00100793          	li	a5,1
    80006464:	d91ff06f          	j	800061f4 <__printf+0x3fc>
    80006468:	00100793          	li	a5,1
    8000646c:	bf1ff06f          	j	8000605c <__printf+0x264>
    80006470:	00900793          	li	a5,9
    80006474:	00800c93          	li	s9,8
    80006478:	be1ff06f          	j	80006058 <__printf+0x260>
    8000647c:	00002517          	auipc	a0,0x2
    80006480:	26c50513          	addi	a0,a0,620 # 800086e8 <CONSOLE_STATUS+0x6d8>
    80006484:	00000097          	auipc	ra,0x0
    80006488:	918080e7          	jalr	-1768(ra) # 80005d9c <panic>

000000008000648c <printfinit>:
    8000648c:	fe010113          	addi	sp,sp,-32
    80006490:	00813823          	sd	s0,16(sp)
    80006494:	00913423          	sd	s1,8(sp)
    80006498:	00113c23          	sd	ra,24(sp)
    8000649c:	02010413          	addi	s0,sp,32
    800064a0:	00008497          	auipc	s1,0x8
    800064a4:	b5048493          	addi	s1,s1,-1200 # 8000dff0 <pr>
    800064a8:	00048513          	mv	a0,s1
    800064ac:	00002597          	auipc	a1,0x2
    800064b0:	24c58593          	addi	a1,a1,588 # 800086f8 <CONSOLE_STATUS+0x6e8>
    800064b4:	00000097          	auipc	ra,0x0
    800064b8:	5f4080e7          	jalr	1524(ra) # 80006aa8 <initlock>
    800064bc:	01813083          	ld	ra,24(sp)
    800064c0:	01013403          	ld	s0,16(sp)
    800064c4:	0004ac23          	sw	zero,24(s1)
    800064c8:	00813483          	ld	s1,8(sp)
    800064cc:	02010113          	addi	sp,sp,32
    800064d0:	00008067          	ret

00000000800064d4 <uartinit>:
    800064d4:	ff010113          	addi	sp,sp,-16
    800064d8:	00813423          	sd	s0,8(sp)
    800064dc:	01010413          	addi	s0,sp,16
    800064e0:	100007b7          	lui	a5,0x10000
    800064e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800064e8:	f8000713          	li	a4,-128
    800064ec:	00e781a3          	sb	a4,3(a5)
    800064f0:	00300713          	li	a4,3
    800064f4:	00e78023          	sb	a4,0(a5)
    800064f8:	000780a3          	sb	zero,1(a5)
    800064fc:	00e781a3          	sb	a4,3(a5)
    80006500:	00700693          	li	a3,7
    80006504:	00d78123          	sb	a3,2(a5)
    80006508:	00e780a3          	sb	a4,1(a5)
    8000650c:	00813403          	ld	s0,8(sp)
    80006510:	01010113          	addi	sp,sp,16
    80006514:	00008067          	ret

0000000080006518 <uartputc>:
    80006518:	00002797          	auipc	a5,0x2
    8000651c:	6507a783          	lw	a5,1616(a5) # 80008b68 <panicked>
    80006520:	00078463          	beqz	a5,80006528 <uartputc+0x10>
    80006524:	0000006f          	j	80006524 <uartputc+0xc>
    80006528:	fd010113          	addi	sp,sp,-48
    8000652c:	02813023          	sd	s0,32(sp)
    80006530:	00913c23          	sd	s1,24(sp)
    80006534:	01213823          	sd	s2,16(sp)
    80006538:	01313423          	sd	s3,8(sp)
    8000653c:	02113423          	sd	ra,40(sp)
    80006540:	03010413          	addi	s0,sp,48
    80006544:	00002917          	auipc	s2,0x2
    80006548:	62c90913          	addi	s2,s2,1580 # 80008b70 <uart_tx_r>
    8000654c:	00093783          	ld	a5,0(s2)
    80006550:	00002497          	auipc	s1,0x2
    80006554:	62848493          	addi	s1,s1,1576 # 80008b78 <uart_tx_w>
    80006558:	0004b703          	ld	a4,0(s1)
    8000655c:	02078693          	addi	a3,a5,32
    80006560:	00050993          	mv	s3,a0
    80006564:	02e69c63          	bne	a3,a4,8000659c <uartputc+0x84>
    80006568:	00001097          	auipc	ra,0x1
    8000656c:	834080e7          	jalr	-1996(ra) # 80006d9c <push_on>
    80006570:	00093783          	ld	a5,0(s2)
    80006574:	0004b703          	ld	a4,0(s1)
    80006578:	02078793          	addi	a5,a5,32
    8000657c:	00e79463          	bne	a5,a4,80006584 <uartputc+0x6c>
    80006580:	0000006f          	j	80006580 <uartputc+0x68>
    80006584:	00001097          	auipc	ra,0x1
    80006588:	88c080e7          	jalr	-1908(ra) # 80006e10 <pop_on>
    8000658c:	00093783          	ld	a5,0(s2)
    80006590:	0004b703          	ld	a4,0(s1)
    80006594:	02078693          	addi	a3,a5,32
    80006598:	fce688e3          	beq	a3,a4,80006568 <uartputc+0x50>
    8000659c:	01f77693          	andi	a3,a4,31
    800065a0:	00008597          	auipc	a1,0x8
    800065a4:	a7058593          	addi	a1,a1,-1424 # 8000e010 <uart_tx_buf>
    800065a8:	00d586b3          	add	a3,a1,a3
    800065ac:	00170713          	addi	a4,a4,1
    800065b0:	01368023          	sb	s3,0(a3)
    800065b4:	00e4b023          	sd	a4,0(s1)
    800065b8:	10000637          	lui	a2,0x10000
    800065bc:	02f71063          	bne	a4,a5,800065dc <uartputc+0xc4>
    800065c0:	0340006f          	j	800065f4 <uartputc+0xdc>
    800065c4:	00074703          	lbu	a4,0(a4)
    800065c8:	00f93023          	sd	a5,0(s2)
    800065cc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800065d0:	00093783          	ld	a5,0(s2)
    800065d4:	0004b703          	ld	a4,0(s1)
    800065d8:	00f70e63          	beq	a4,a5,800065f4 <uartputc+0xdc>
    800065dc:	00564683          	lbu	a3,5(a2)
    800065e0:	01f7f713          	andi	a4,a5,31
    800065e4:	00e58733          	add	a4,a1,a4
    800065e8:	0206f693          	andi	a3,a3,32
    800065ec:	00178793          	addi	a5,a5,1
    800065f0:	fc069ae3          	bnez	a3,800065c4 <uartputc+0xac>
    800065f4:	02813083          	ld	ra,40(sp)
    800065f8:	02013403          	ld	s0,32(sp)
    800065fc:	01813483          	ld	s1,24(sp)
    80006600:	01013903          	ld	s2,16(sp)
    80006604:	00813983          	ld	s3,8(sp)
    80006608:	03010113          	addi	sp,sp,48
    8000660c:	00008067          	ret

0000000080006610 <uartputc_sync>:
    80006610:	ff010113          	addi	sp,sp,-16
    80006614:	00813423          	sd	s0,8(sp)
    80006618:	01010413          	addi	s0,sp,16
    8000661c:	00002717          	auipc	a4,0x2
    80006620:	54c72703          	lw	a4,1356(a4) # 80008b68 <panicked>
    80006624:	02071663          	bnez	a4,80006650 <uartputc_sync+0x40>
    80006628:	00050793          	mv	a5,a0
    8000662c:	100006b7          	lui	a3,0x10000
    80006630:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006634:	02077713          	andi	a4,a4,32
    80006638:	fe070ce3          	beqz	a4,80006630 <uartputc_sync+0x20>
    8000663c:	0ff7f793          	andi	a5,a5,255
    80006640:	00f68023          	sb	a5,0(a3)
    80006644:	00813403          	ld	s0,8(sp)
    80006648:	01010113          	addi	sp,sp,16
    8000664c:	00008067          	ret
    80006650:	0000006f          	j	80006650 <uartputc_sync+0x40>

0000000080006654 <uartstart>:
    80006654:	ff010113          	addi	sp,sp,-16
    80006658:	00813423          	sd	s0,8(sp)
    8000665c:	01010413          	addi	s0,sp,16
    80006660:	00002617          	auipc	a2,0x2
    80006664:	51060613          	addi	a2,a2,1296 # 80008b70 <uart_tx_r>
    80006668:	00002517          	auipc	a0,0x2
    8000666c:	51050513          	addi	a0,a0,1296 # 80008b78 <uart_tx_w>
    80006670:	00063783          	ld	a5,0(a2)
    80006674:	00053703          	ld	a4,0(a0)
    80006678:	04f70263          	beq	a4,a5,800066bc <uartstart+0x68>
    8000667c:	100005b7          	lui	a1,0x10000
    80006680:	00008817          	auipc	a6,0x8
    80006684:	99080813          	addi	a6,a6,-1648 # 8000e010 <uart_tx_buf>
    80006688:	01c0006f          	j	800066a4 <uartstart+0x50>
    8000668c:	0006c703          	lbu	a4,0(a3)
    80006690:	00f63023          	sd	a5,0(a2)
    80006694:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006698:	00063783          	ld	a5,0(a2)
    8000669c:	00053703          	ld	a4,0(a0)
    800066a0:	00f70e63          	beq	a4,a5,800066bc <uartstart+0x68>
    800066a4:	01f7f713          	andi	a4,a5,31
    800066a8:	00e806b3          	add	a3,a6,a4
    800066ac:	0055c703          	lbu	a4,5(a1)
    800066b0:	00178793          	addi	a5,a5,1
    800066b4:	02077713          	andi	a4,a4,32
    800066b8:	fc071ae3          	bnez	a4,8000668c <uartstart+0x38>
    800066bc:	00813403          	ld	s0,8(sp)
    800066c0:	01010113          	addi	sp,sp,16
    800066c4:	00008067          	ret

00000000800066c8 <uartgetc>:
    800066c8:	ff010113          	addi	sp,sp,-16
    800066cc:	00813423          	sd	s0,8(sp)
    800066d0:	01010413          	addi	s0,sp,16
    800066d4:	10000737          	lui	a4,0x10000
    800066d8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800066dc:	0017f793          	andi	a5,a5,1
    800066e0:	00078c63          	beqz	a5,800066f8 <uartgetc+0x30>
    800066e4:	00074503          	lbu	a0,0(a4)
    800066e8:	0ff57513          	andi	a0,a0,255
    800066ec:	00813403          	ld	s0,8(sp)
    800066f0:	01010113          	addi	sp,sp,16
    800066f4:	00008067          	ret
    800066f8:	fff00513          	li	a0,-1
    800066fc:	ff1ff06f          	j	800066ec <uartgetc+0x24>

0000000080006700 <uartintr>:
    80006700:	100007b7          	lui	a5,0x10000
    80006704:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006708:	0017f793          	andi	a5,a5,1
    8000670c:	0a078463          	beqz	a5,800067b4 <uartintr+0xb4>
    80006710:	fe010113          	addi	sp,sp,-32
    80006714:	00813823          	sd	s0,16(sp)
    80006718:	00913423          	sd	s1,8(sp)
    8000671c:	00113c23          	sd	ra,24(sp)
    80006720:	02010413          	addi	s0,sp,32
    80006724:	100004b7          	lui	s1,0x10000
    80006728:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000672c:	0ff57513          	andi	a0,a0,255
    80006730:	fffff097          	auipc	ra,0xfffff
    80006734:	534080e7          	jalr	1332(ra) # 80005c64 <consoleintr>
    80006738:	0054c783          	lbu	a5,5(s1)
    8000673c:	0017f793          	andi	a5,a5,1
    80006740:	fe0794e3          	bnez	a5,80006728 <uartintr+0x28>
    80006744:	00002617          	auipc	a2,0x2
    80006748:	42c60613          	addi	a2,a2,1068 # 80008b70 <uart_tx_r>
    8000674c:	00002517          	auipc	a0,0x2
    80006750:	42c50513          	addi	a0,a0,1068 # 80008b78 <uart_tx_w>
    80006754:	00063783          	ld	a5,0(a2)
    80006758:	00053703          	ld	a4,0(a0)
    8000675c:	04f70263          	beq	a4,a5,800067a0 <uartintr+0xa0>
    80006760:	100005b7          	lui	a1,0x10000
    80006764:	00008817          	auipc	a6,0x8
    80006768:	8ac80813          	addi	a6,a6,-1876 # 8000e010 <uart_tx_buf>
    8000676c:	01c0006f          	j	80006788 <uartintr+0x88>
    80006770:	0006c703          	lbu	a4,0(a3)
    80006774:	00f63023          	sd	a5,0(a2)
    80006778:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000677c:	00063783          	ld	a5,0(a2)
    80006780:	00053703          	ld	a4,0(a0)
    80006784:	00f70e63          	beq	a4,a5,800067a0 <uartintr+0xa0>
    80006788:	01f7f713          	andi	a4,a5,31
    8000678c:	00e806b3          	add	a3,a6,a4
    80006790:	0055c703          	lbu	a4,5(a1)
    80006794:	00178793          	addi	a5,a5,1
    80006798:	02077713          	andi	a4,a4,32
    8000679c:	fc071ae3          	bnez	a4,80006770 <uartintr+0x70>
    800067a0:	01813083          	ld	ra,24(sp)
    800067a4:	01013403          	ld	s0,16(sp)
    800067a8:	00813483          	ld	s1,8(sp)
    800067ac:	02010113          	addi	sp,sp,32
    800067b0:	00008067          	ret
    800067b4:	00002617          	auipc	a2,0x2
    800067b8:	3bc60613          	addi	a2,a2,956 # 80008b70 <uart_tx_r>
    800067bc:	00002517          	auipc	a0,0x2
    800067c0:	3bc50513          	addi	a0,a0,956 # 80008b78 <uart_tx_w>
    800067c4:	00063783          	ld	a5,0(a2)
    800067c8:	00053703          	ld	a4,0(a0)
    800067cc:	04f70263          	beq	a4,a5,80006810 <uartintr+0x110>
    800067d0:	100005b7          	lui	a1,0x10000
    800067d4:	00008817          	auipc	a6,0x8
    800067d8:	83c80813          	addi	a6,a6,-1988 # 8000e010 <uart_tx_buf>
    800067dc:	01c0006f          	j	800067f8 <uartintr+0xf8>
    800067e0:	0006c703          	lbu	a4,0(a3)
    800067e4:	00f63023          	sd	a5,0(a2)
    800067e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800067ec:	00063783          	ld	a5,0(a2)
    800067f0:	00053703          	ld	a4,0(a0)
    800067f4:	02f70063          	beq	a4,a5,80006814 <uartintr+0x114>
    800067f8:	01f7f713          	andi	a4,a5,31
    800067fc:	00e806b3          	add	a3,a6,a4
    80006800:	0055c703          	lbu	a4,5(a1)
    80006804:	00178793          	addi	a5,a5,1
    80006808:	02077713          	andi	a4,a4,32
    8000680c:	fc071ae3          	bnez	a4,800067e0 <uartintr+0xe0>
    80006810:	00008067          	ret
    80006814:	00008067          	ret

0000000080006818 <kinit>:
    80006818:	fc010113          	addi	sp,sp,-64
    8000681c:	02913423          	sd	s1,40(sp)
    80006820:	fffff7b7          	lui	a5,0xfffff
    80006824:	0000d497          	auipc	s1,0xd
    80006828:	7db48493          	addi	s1,s1,2011 # 80013fff <end+0xfff>
    8000682c:	02813823          	sd	s0,48(sp)
    80006830:	01313c23          	sd	s3,24(sp)
    80006834:	00f4f4b3          	and	s1,s1,a5
    80006838:	02113c23          	sd	ra,56(sp)
    8000683c:	03213023          	sd	s2,32(sp)
    80006840:	01413823          	sd	s4,16(sp)
    80006844:	01513423          	sd	s5,8(sp)
    80006848:	04010413          	addi	s0,sp,64
    8000684c:	000017b7          	lui	a5,0x1
    80006850:	01100993          	li	s3,17
    80006854:	00f487b3          	add	a5,s1,a5
    80006858:	01b99993          	slli	s3,s3,0x1b
    8000685c:	06f9e063          	bltu	s3,a5,800068bc <kinit+0xa4>
    80006860:	0000ca97          	auipc	s5,0xc
    80006864:	7a0a8a93          	addi	s5,s5,1952 # 80013000 <end>
    80006868:	0754ec63          	bltu	s1,s5,800068e0 <kinit+0xc8>
    8000686c:	0734fa63          	bgeu	s1,s3,800068e0 <kinit+0xc8>
    80006870:	00088a37          	lui	s4,0x88
    80006874:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006878:	00002917          	auipc	s2,0x2
    8000687c:	30890913          	addi	s2,s2,776 # 80008b80 <kmem>
    80006880:	00ca1a13          	slli	s4,s4,0xc
    80006884:	0140006f          	j	80006898 <kinit+0x80>
    80006888:	000017b7          	lui	a5,0x1
    8000688c:	00f484b3          	add	s1,s1,a5
    80006890:	0554e863          	bltu	s1,s5,800068e0 <kinit+0xc8>
    80006894:	0534f663          	bgeu	s1,s3,800068e0 <kinit+0xc8>
    80006898:	00001637          	lui	a2,0x1
    8000689c:	00100593          	li	a1,1
    800068a0:	00048513          	mv	a0,s1
    800068a4:	00000097          	auipc	ra,0x0
    800068a8:	5e4080e7          	jalr	1508(ra) # 80006e88 <__memset>
    800068ac:	00093783          	ld	a5,0(s2)
    800068b0:	00f4b023          	sd	a5,0(s1)
    800068b4:	00993023          	sd	s1,0(s2)
    800068b8:	fd4498e3          	bne	s1,s4,80006888 <kinit+0x70>
    800068bc:	03813083          	ld	ra,56(sp)
    800068c0:	03013403          	ld	s0,48(sp)
    800068c4:	02813483          	ld	s1,40(sp)
    800068c8:	02013903          	ld	s2,32(sp)
    800068cc:	01813983          	ld	s3,24(sp)
    800068d0:	01013a03          	ld	s4,16(sp)
    800068d4:	00813a83          	ld	s5,8(sp)
    800068d8:	04010113          	addi	sp,sp,64
    800068dc:	00008067          	ret
    800068e0:	00002517          	auipc	a0,0x2
    800068e4:	e3850513          	addi	a0,a0,-456 # 80008718 <digits+0x18>
    800068e8:	fffff097          	auipc	ra,0xfffff
    800068ec:	4b4080e7          	jalr	1204(ra) # 80005d9c <panic>

00000000800068f0 <freerange>:
    800068f0:	fc010113          	addi	sp,sp,-64
    800068f4:	000017b7          	lui	a5,0x1
    800068f8:	02913423          	sd	s1,40(sp)
    800068fc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006900:	009504b3          	add	s1,a0,s1
    80006904:	fffff537          	lui	a0,0xfffff
    80006908:	02813823          	sd	s0,48(sp)
    8000690c:	02113c23          	sd	ra,56(sp)
    80006910:	03213023          	sd	s2,32(sp)
    80006914:	01313c23          	sd	s3,24(sp)
    80006918:	01413823          	sd	s4,16(sp)
    8000691c:	01513423          	sd	s5,8(sp)
    80006920:	01613023          	sd	s6,0(sp)
    80006924:	04010413          	addi	s0,sp,64
    80006928:	00a4f4b3          	and	s1,s1,a0
    8000692c:	00f487b3          	add	a5,s1,a5
    80006930:	06f5e463          	bltu	a1,a5,80006998 <freerange+0xa8>
    80006934:	0000ca97          	auipc	s5,0xc
    80006938:	6cca8a93          	addi	s5,s5,1740 # 80013000 <end>
    8000693c:	0954e263          	bltu	s1,s5,800069c0 <freerange+0xd0>
    80006940:	01100993          	li	s3,17
    80006944:	01b99993          	slli	s3,s3,0x1b
    80006948:	0734fc63          	bgeu	s1,s3,800069c0 <freerange+0xd0>
    8000694c:	00058a13          	mv	s4,a1
    80006950:	00002917          	auipc	s2,0x2
    80006954:	23090913          	addi	s2,s2,560 # 80008b80 <kmem>
    80006958:	00002b37          	lui	s6,0x2
    8000695c:	0140006f          	j	80006970 <freerange+0x80>
    80006960:	000017b7          	lui	a5,0x1
    80006964:	00f484b3          	add	s1,s1,a5
    80006968:	0554ec63          	bltu	s1,s5,800069c0 <freerange+0xd0>
    8000696c:	0534fa63          	bgeu	s1,s3,800069c0 <freerange+0xd0>
    80006970:	00001637          	lui	a2,0x1
    80006974:	00100593          	li	a1,1
    80006978:	00048513          	mv	a0,s1
    8000697c:	00000097          	auipc	ra,0x0
    80006980:	50c080e7          	jalr	1292(ra) # 80006e88 <__memset>
    80006984:	00093703          	ld	a4,0(s2)
    80006988:	016487b3          	add	a5,s1,s6
    8000698c:	00e4b023          	sd	a4,0(s1)
    80006990:	00993023          	sd	s1,0(s2)
    80006994:	fcfa76e3          	bgeu	s4,a5,80006960 <freerange+0x70>
    80006998:	03813083          	ld	ra,56(sp)
    8000699c:	03013403          	ld	s0,48(sp)
    800069a0:	02813483          	ld	s1,40(sp)
    800069a4:	02013903          	ld	s2,32(sp)
    800069a8:	01813983          	ld	s3,24(sp)
    800069ac:	01013a03          	ld	s4,16(sp)
    800069b0:	00813a83          	ld	s5,8(sp)
    800069b4:	00013b03          	ld	s6,0(sp)
    800069b8:	04010113          	addi	sp,sp,64
    800069bc:	00008067          	ret
    800069c0:	00002517          	auipc	a0,0x2
    800069c4:	d5850513          	addi	a0,a0,-680 # 80008718 <digits+0x18>
    800069c8:	fffff097          	auipc	ra,0xfffff
    800069cc:	3d4080e7          	jalr	980(ra) # 80005d9c <panic>

00000000800069d0 <kfree>:
    800069d0:	fe010113          	addi	sp,sp,-32
    800069d4:	00813823          	sd	s0,16(sp)
    800069d8:	00113c23          	sd	ra,24(sp)
    800069dc:	00913423          	sd	s1,8(sp)
    800069e0:	02010413          	addi	s0,sp,32
    800069e4:	03451793          	slli	a5,a0,0x34
    800069e8:	04079c63          	bnez	a5,80006a40 <kfree+0x70>
    800069ec:	0000c797          	auipc	a5,0xc
    800069f0:	61478793          	addi	a5,a5,1556 # 80013000 <end>
    800069f4:	00050493          	mv	s1,a0
    800069f8:	04f56463          	bltu	a0,a5,80006a40 <kfree+0x70>
    800069fc:	01100793          	li	a5,17
    80006a00:	01b79793          	slli	a5,a5,0x1b
    80006a04:	02f57e63          	bgeu	a0,a5,80006a40 <kfree+0x70>
    80006a08:	00001637          	lui	a2,0x1
    80006a0c:	00100593          	li	a1,1
    80006a10:	00000097          	auipc	ra,0x0
    80006a14:	478080e7          	jalr	1144(ra) # 80006e88 <__memset>
    80006a18:	00002797          	auipc	a5,0x2
    80006a1c:	16878793          	addi	a5,a5,360 # 80008b80 <kmem>
    80006a20:	0007b703          	ld	a4,0(a5)
    80006a24:	01813083          	ld	ra,24(sp)
    80006a28:	01013403          	ld	s0,16(sp)
    80006a2c:	00e4b023          	sd	a4,0(s1)
    80006a30:	0097b023          	sd	s1,0(a5)
    80006a34:	00813483          	ld	s1,8(sp)
    80006a38:	02010113          	addi	sp,sp,32
    80006a3c:	00008067          	ret
    80006a40:	00002517          	auipc	a0,0x2
    80006a44:	cd850513          	addi	a0,a0,-808 # 80008718 <digits+0x18>
    80006a48:	fffff097          	auipc	ra,0xfffff
    80006a4c:	354080e7          	jalr	852(ra) # 80005d9c <panic>

0000000080006a50 <kalloc>:
    80006a50:	fe010113          	addi	sp,sp,-32
    80006a54:	00813823          	sd	s0,16(sp)
    80006a58:	00913423          	sd	s1,8(sp)
    80006a5c:	00113c23          	sd	ra,24(sp)
    80006a60:	02010413          	addi	s0,sp,32
    80006a64:	00002797          	auipc	a5,0x2
    80006a68:	11c78793          	addi	a5,a5,284 # 80008b80 <kmem>
    80006a6c:	0007b483          	ld	s1,0(a5)
    80006a70:	02048063          	beqz	s1,80006a90 <kalloc+0x40>
    80006a74:	0004b703          	ld	a4,0(s1)
    80006a78:	00001637          	lui	a2,0x1
    80006a7c:	00500593          	li	a1,5
    80006a80:	00048513          	mv	a0,s1
    80006a84:	00e7b023          	sd	a4,0(a5)
    80006a88:	00000097          	auipc	ra,0x0
    80006a8c:	400080e7          	jalr	1024(ra) # 80006e88 <__memset>
    80006a90:	01813083          	ld	ra,24(sp)
    80006a94:	01013403          	ld	s0,16(sp)
    80006a98:	00048513          	mv	a0,s1
    80006a9c:	00813483          	ld	s1,8(sp)
    80006aa0:	02010113          	addi	sp,sp,32
    80006aa4:	00008067          	ret

0000000080006aa8 <initlock>:
    80006aa8:	ff010113          	addi	sp,sp,-16
    80006aac:	00813423          	sd	s0,8(sp)
    80006ab0:	01010413          	addi	s0,sp,16
    80006ab4:	00813403          	ld	s0,8(sp)
    80006ab8:	00b53423          	sd	a1,8(a0)
    80006abc:	00052023          	sw	zero,0(a0)
    80006ac0:	00053823          	sd	zero,16(a0)
    80006ac4:	01010113          	addi	sp,sp,16
    80006ac8:	00008067          	ret

0000000080006acc <acquire>:
    80006acc:	fe010113          	addi	sp,sp,-32
    80006ad0:	00813823          	sd	s0,16(sp)
    80006ad4:	00913423          	sd	s1,8(sp)
    80006ad8:	00113c23          	sd	ra,24(sp)
    80006adc:	01213023          	sd	s2,0(sp)
    80006ae0:	02010413          	addi	s0,sp,32
    80006ae4:	00050493          	mv	s1,a0
    80006ae8:	10002973          	csrr	s2,sstatus
    80006aec:	100027f3          	csrr	a5,sstatus
    80006af0:	ffd7f793          	andi	a5,a5,-3
    80006af4:	10079073          	csrw	sstatus,a5
    80006af8:	fffff097          	auipc	ra,0xfffff
    80006afc:	8e4080e7          	jalr	-1820(ra) # 800053dc <mycpu>
    80006b00:	07852783          	lw	a5,120(a0)
    80006b04:	06078e63          	beqz	a5,80006b80 <acquire+0xb4>
    80006b08:	fffff097          	auipc	ra,0xfffff
    80006b0c:	8d4080e7          	jalr	-1836(ra) # 800053dc <mycpu>
    80006b10:	07852783          	lw	a5,120(a0)
    80006b14:	0004a703          	lw	a4,0(s1)
    80006b18:	0017879b          	addiw	a5,a5,1
    80006b1c:	06f52c23          	sw	a5,120(a0)
    80006b20:	04071063          	bnez	a4,80006b60 <acquire+0x94>
    80006b24:	00100713          	li	a4,1
    80006b28:	00070793          	mv	a5,a4
    80006b2c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006b30:	0007879b          	sext.w	a5,a5
    80006b34:	fe079ae3          	bnez	a5,80006b28 <acquire+0x5c>
    80006b38:	0ff0000f          	fence
    80006b3c:	fffff097          	auipc	ra,0xfffff
    80006b40:	8a0080e7          	jalr	-1888(ra) # 800053dc <mycpu>
    80006b44:	01813083          	ld	ra,24(sp)
    80006b48:	01013403          	ld	s0,16(sp)
    80006b4c:	00a4b823          	sd	a0,16(s1)
    80006b50:	00013903          	ld	s2,0(sp)
    80006b54:	00813483          	ld	s1,8(sp)
    80006b58:	02010113          	addi	sp,sp,32
    80006b5c:	00008067          	ret
    80006b60:	0104b903          	ld	s2,16(s1)
    80006b64:	fffff097          	auipc	ra,0xfffff
    80006b68:	878080e7          	jalr	-1928(ra) # 800053dc <mycpu>
    80006b6c:	faa91ce3          	bne	s2,a0,80006b24 <acquire+0x58>
    80006b70:	00002517          	auipc	a0,0x2
    80006b74:	bb050513          	addi	a0,a0,-1104 # 80008720 <digits+0x20>
    80006b78:	fffff097          	auipc	ra,0xfffff
    80006b7c:	224080e7          	jalr	548(ra) # 80005d9c <panic>
    80006b80:	00195913          	srli	s2,s2,0x1
    80006b84:	fffff097          	auipc	ra,0xfffff
    80006b88:	858080e7          	jalr	-1960(ra) # 800053dc <mycpu>
    80006b8c:	00197913          	andi	s2,s2,1
    80006b90:	07252e23          	sw	s2,124(a0)
    80006b94:	f75ff06f          	j	80006b08 <acquire+0x3c>

0000000080006b98 <release>:
    80006b98:	fe010113          	addi	sp,sp,-32
    80006b9c:	00813823          	sd	s0,16(sp)
    80006ba0:	00113c23          	sd	ra,24(sp)
    80006ba4:	00913423          	sd	s1,8(sp)
    80006ba8:	01213023          	sd	s2,0(sp)
    80006bac:	02010413          	addi	s0,sp,32
    80006bb0:	00052783          	lw	a5,0(a0)
    80006bb4:	00079a63          	bnez	a5,80006bc8 <release+0x30>
    80006bb8:	00002517          	auipc	a0,0x2
    80006bbc:	b7050513          	addi	a0,a0,-1168 # 80008728 <digits+0x28>
    80006bc0:	fffff097          	auipc	ra,0xfffff
    80006bc4:	1dc080e7          	jalr	476(ra) # 80005d9c <panic>
    80006bc8:	01053903          	ld	s2,16(a0)
    80006bcc:	00050493          	mv	s1,a0
    80006bd0:	fffff097          	auipc	ra,0xfffff
    80006bd4:	80c080e7          	jalr	-2036(ra) # 800053dc <mycpu>
    80006bd8:	fea910e3          	bne	s2,a0,80006bb8 <release+0x20>
    80006bdc:	0004b823          	sd	zero,16(s1)
    80006be0:	0ff0000f          	fence
    80006be4:	0f50000f          	fence	iorw,ow
    80006be8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006bec:	ffffe097          	auipc	ra,0xffffe
    80006bf0:	7f0080e7          	jalr	2032(ra) # 800053dc <mycpu>
    80006bf4:	100027f3          	csrr	a5,sstatus
    80006bf8:	0027f793          	andi	a5,a5,2
    80006bfc:	04079a63          	bnez	a5,80006c50 <release+0xb8>
    80006c00:	07852783          	lw	a5,120(a0)
    80006c04:	02f05e63          	blez	a5,80006c40 <release+0xa8>
    80006c08:	fff7871b          	addiw	a4,a5,-1
    80006c0c:	06e52c23          	sw	a4,120(a0)
    80006c10:	00071c63          	bnez	a4,80006c28 <release+0x90>
    80006c14:	07c52783          	lw	a5,124(a0)
    80006c18:	00078863          	beqz	a5,80006c28 <release+0x90>
    80006c1c:	100027f3          	csrr	a5,sstatus
    80006c20:	0027e793          	ori	a5,a5,2
    80006c24:	10079073          	csrw	sstatus,a5
    80006c28:	01813083          	ld	ra,24(sp)
    80006c2c:	01013403          	ld	s0,16(sp)
    80006c30:	00813483          	ld	s1,8(sp)
    80006c34:	00013903          	ld	s2,0(sp)
    80006c38:	02010113          	addi	sp,sp,32
    80006c3c:	00008067          	ret
    80006c40:	00002517          	auipc	a0,0x2
    80006c44:	b0850513          	addi	a0,a0,-1272 # 80008748 <digits+0x48>
    80006c48:	fffff097          	auipc	ra,0xfffff
    80006c4c:	154080e7          	jalr	340(ra) # 80005d9c <panic>
    80006c50:	00002517          	auipc	a0,0x2
    80006c54:	ae050513          	addi	a0,a0,-1312 # 80008730 <digits+0x30>
    80006c58:	fffff097          	auipc	ra,0xfffff
    80006c5c:	144080e7          	jalr	324(ra) # 80005d9c <panic>

0000000080006c60 <holding>:
    80006c60:	00052783          	lw	a5,0(a0)
    80006c64:	00079663          	bnez	a5,80006c70 <holding+0x10>
    80006c68:	00000513          	li	a0,0
    80006c6c:	00008067          	ret
    80006c70:	fe010113          	addi	sp,sp,-32
    80006c74:	00813823          	sd	s0,16(sp)
    80006c78:	00913423          	sd	s1,8(sp)
    80006c7c:	00113c23          	sd	ra,24(sp)
    80006c80:	02010413          	addi	s0,sp,32
    80006c84:	01053483          	ld	s1,16(a0)
    80006c88:	ffffe097          	auipc	ra,0xffffe
    80006c8c:	754080e7          	jalr	1876(ra) # 800053dc <mycpu>
    80006c90:	01813083          	ld	ra,24(sp)
    80006c94:	01013403          	ld	s0,16(sp)
    80006c98:	40a48533          	sub	a0,s1,a0
    80006c9c:	00153513          	seqz	a0,a0
    80006ca0:	00813483          	ld	s1,8(sp)
    80006ca4:	02010113          	addi	sp,sp,32
    80006ca8:	00008067          	ret

0000000080006cac <push_off>:
    80006cac:	fe010113          	addi	sp,sp,-32
    80006cb0:	00813823          	sd	s0,16(sp)
    80006cb4:	00113c23          	sd	ra,24(sp)
    80006cb8:	00913423          	sd	s1,8(sp)
    80006cbc:	02010413          	addi	s0,sp,32
    80006cc0:	100024f3          	csrr	s1,sstatus
    80006cc4:	100027f3          	csrr	a5,sstatus
    80006cc8:	ffd7f793          	andi	a5,a5,-3
    80006ccc:	10079073          	csrw	sstatus,a5
    80006cd0:	ffffe097          	auipc	ra,0xffffe
    80006cd4:	70c080e7          	jalr	1804(ra) # 800053dc <mycpu>
    80006cd8:	07852783          	lw	a5,120(a0)
    80006cdc:	02078663          	beqz	a5,80006d08 <push_off+0x5c>
    80006ce0:	ffffe097          	auipc	ra,0xffffe
    80006ce4:	6fc080e7          	jalr	1788(ra) # 800053dc <mycpu>
    80006ce8:	07852783          	lw	a5,120(a0)
    80006cec:	01813083          	ld	ra,24(sp)
    80006cf0:	01013403          	ld	s0,16(sp)
    80006cf4:	0017879b          	addiw	a5,a5,1
    80006cf8:	06f52c23          	sw	a5,120(a0)
    80006cfc:	00813483          	ld	s1,8(sp)
    80006d00:	02010113          	addi	sp,sp,32
    80006d04:	00008067          	ret
    80006d08:	0014d493          	srli	s1,s1,0x1
    80006d0c:	ffffe097          	auipc	ra,0xffffe
    80006d10:	6d0080e7          	jalr	1744(ra) # 800053dc <mycpu>
    80006d14:	0014f493          	andi	s1,s1,1
    80006d18:	06952e23          	sw	s1,124(a0)
    80006d1c:	fc5ff06f          	j	80006ce0 <push_off+0x34>

0000000080006d20 <pop_off>:
    80006d20:	ff010113          	addi	sp,sp,-16
    80006d24:	00813023          	sd	s0,0(sp)
    80006d28:	00113423          	sd	ra,8(sp)
    80006d2c:	01010413          	addi	s0,sp,16
    80006d30:	ffffe097          	auipc	ra,0xffffe
    80006d34:	6ac080e7          	jalr	1708(ra) # 800053dc <mycpu>
    80006d38:	100027f3          	csrr	a5,sstatus
    80006d3c:	0027f793          	andi	a5,a5,2
    80006d40:	04079663          	bnez	a5,80006d8c <pop_off+0x6c>
    80006d44:	07852783          	lw	a5,120(a0)
    80006d48:	02f05a63          	blez	a5,80006d7c <pop_off+0x5c>
    80006d4c:	fff7871b          	addiw	a4,a5,-1
    80006d50:	06e52c23          	sw	a4,120(a0)
    80006d54:	00071c63          	bnez	a4,80006d6c <pop_off+0x4c>
    80006d58:	07c52783          	lw	a5,124(a0)
    80006d5c:	00078863          	beqz	a5,80006d6c <pop_off+0x4c>
    80006d60:	100027f3          	csrr	a5,sstatus
    80006d64:	0027e793          	ori	a5,a5,2
    80006d68:	10079073          	csrw	sstatus,a5
    80006d6c:	00813083          	ld	ra,8(sp)
    80006d70:	00013403          	ld	s0,0(sp)
    80006d74:	01010113          	addi	sp,sp,16
    80006d78:	00008067          	ret
    80006d7c:	00002517          	auipc	a0,0x2
    80006d80:	9cc50513          	addi	a0,a0,-1588 # 80008748 <digits+0x48>
    80006d84:	fffff097          	auipc	ra,0xfffff
    80006d88:	018080e7          	jalr	24(ra) # 80005d9c <panic>
    80006d8c:	00002517          	auipc	a0,0x2
    80006d90:	9a450513          	addi	a0,a0,-1628 # 80008730 <digits+0x30>
    80006d94:	fffff097          	auipc	ra,0xfffff
    80006d98:	008080e7          	jalr	8(ra) # 80005d9c <panic>

0000000080006d9c <push_on>:
    80006d9c:	fe010113          	addi	sp,sp,-32
    80006da0:	00813823          	sd	s0,16(sp)
    80006da4:	00113c23          	sd	ra,24(sp)
    80006da8:	00913423          	sd	s1,8(sp)
    80006dac:	02010413          	addi	s0,sp,32
    80006db0:	100024f3          	csrr	s1,sstatus
    80006db4:	100027f3          	csrr	a5,sstatus
    80006db8:	0027e793          	ori	a5,a5,2
    80006dbc:	10079073          	csrw	sstatus,a5
    80006dc0:	ffffe097          	auipc	ra,0xffffe
    80006dc4:	61c080e7          	jalr	1564(ra) # 800053dc <mycpu>
    80006dc8:	07852783          	lw	a5,120(a0)
    80006dcc:	02078663          	beqz	a5,80006df8 <push_on+0x5c>
    80006dd0:	ffffe097          	auipc	ra,0xffffe
    80006dd4:	60c080e7          	jalr	1548(ra) # 800053dc <mycpu>
    80006dd8:	07852783          	lw	a5,120(a0)
    80006ddc:	01813083          	ld	ra,24(sp)
    80006de0:	01013403          	ld	s0,16(sp)
    80006de4:	0017879b          	addiw	a5,a5,1
    80006de8:	06f52c23          	sw	a5,120(a0)
    80006dec:	00813483          	ld	s1,8(sp)
    80006df0:	02010113          	addi	sp,sp,32
    80006df4:	00008067          	ret
    80006df8:	0014d493          	srli	s1,s1,0x1
    80006dfc:	ffffe097          	auipc	ra,0xffffe
    80006e00:	5e0080e7          	jalr	1504(ra) # 800053dc <mycpu>
    80006e04:	0014f493          	andi	s1,s1,1
    80006e08:	06952e23          	sw	s1,124(a0)
    80006e0c:	fc5ff06f          	j	80006dd0 <push_on+0x34>

0000000080006e10 <pop_on>:
    80006e10:	ff010113          	addi	sp,sp,-16
    80006e14:	00813023          	sd	s0,0(sp)
    80006e18:	00113423          	sd	ra,8(sp)
    80006e1c:	01010413          	addi	s0,sp,16
    80006e20:	ffffe097          	auipc	ra,0xffffe
    80006e24:	5bc080e7          	jalr	1468(ra) # 800053dc <mycpu>
    80006e28:	100027f3          	csrr	a5,sstatus
    80006e2c:	0027f793          	andi	a5,a5,2
    80006e30:	04078463          	beqz	a5,80006e78 <pop_on+0x68>
    80006e34:	07852783          	lw	a5,120(a0)
    80006e38:	02f05863          	blez	a5,80006e68 <pop_on+0x58>
    80006e3c:	fff7879b          	addiw	a5,a5,-1
    80006e40:	06f52c23          	sw	a5,120(a0)
    80006e44:	07853783          	ld	a5,120(a0)
    80006e48:	00079863          	bnez	a5,80006e58 <pop_on+0x48>
    80006e4c:	100027f3          	csrr	a5,sstatus
    80006e50:	ffd7f793          	andi	a5,a5,-3
    80006e54:	10079073          	csrw	sstatus,a5
    80006e58:	00813083          	ld	ra,8(sp)
    80006e5c:	00013403          	ld	s0,0(sp)
    80006e60:	01010113          	addi	sp,sp,16
    80006e64:	00008067          	ret
    80006e68:	00002517          	auipc	a0,0x2
    80006e6c:	90850513          	addi	a0,a0,-1784 # 80008770 <digits+0x70>
    80006e70:	fffff097          	auipc	ra,0xfffff
    80006e74:	f2c080e7          	jalr	-212(ra) # 80005d9c <panic>
    80006e78:	00002517          	auipc	a0,0x2
    80006e7c:	8d850513          	addi	a0,a0,-1832 # 80008750 <digits+0x50>
    80006e80:	fffff097          	auipc	ra,0xfffff
    80006e84:	f1c080e7          	jalr	-228(ra) # 80005d9c <panic>

0000000080006e88 <__memset>:
    80006e88:	ff010113          	addi	sp,sp,-16
    80006e8c:	00813423          	sd	s0,8(sp)
    80006e90:	01010413          	addi	s0,sp,16
    80006e94:	1a060e63          	beqz	a2,80007050 <__memset+0x1c8>
    80006e98:	40a007b3          	neg	a5,a0
    80006e9c:	0077f793          	andi	a5,a5,7
    80006ea0:	00778693          	addi	a3,a5,7
    80006ea4:	00b00813          	li	a6,11
    80006ea8:	0ff5f593          	andi	a1,a1,255
    80006eac:	fff6071b          	addiw	a4,a2,-1
    80006eb0:	1b06e663          	bltu	a3,a6,8000705c <__memset+0x1d4>
    80006eb4:	1cd76463          	bltu	a4,a3,8000707c <__memset+0x1f4>
    80006eb8:	1a078e63          	beqz	a5,80007074 <__memset+0x1ec>
    80006ebc:	00b50023          	sb	a1,0(a0)
    80006ec0:	00100713          	li	a4,1
    80006ec4:	1ae78463          	beq	a5,a4,8000706c <__memset+0x1e4>
    80006ec8:	00b500a3          	sb	a1,1(a0)
    80006ecc:	00200713          	li	a4,2
    80006ed0:	1ae78a63          	beq	a5,a4,80007084 <__memset+0x1fc>
    80006ed4:	00b50123          	sb	a1,2(a0)
    80006ed8:	00300713          	li	a4,3
    80006edc:	18e78463          	beq	a5,a4,80007064 <__memset+0x1dc>
    80006ee0:	00b501a3          	sb	a1,3(a0)
    80006ee4:	00400713          	li	a4,4
    80006ee8:	1ae78263          	beq	a5,a4,8000708c <__memset+0x204>
    80006eec:	00b50223          	sb	a1,4(a0)
    80006ef0:	00500713          	li	a4,5
    80006ef4:	1ae78063          	beq	a5,a4,80007094 <__memset+0x20c>
    80006ef8:	00b502a3          	sb	a1,5(a0)
    80006efc:	00700713          	li	a4,7
    80006f00:	18e79e63          	bne	a5,a4,8000709c <__memset+0x214>
    80006f04:	00b50323          	sb	a1,6(a0)
    80006f08:	00700e93          	li	t4,7
    80006f0c:	00859713          	slli	a4,a1,0x8
    80006f10:	00e5e733          	or	a4,a1,a4
    80006f14:	01059e13          	slli	t3,a1,0x10
    80006f18:	01c76e33          	or	t3,a4,t3
    80006f1c:	01859313          	slli	t1,a1,0x18
    80006f20:	006e6333          	or	t1,t3,t1
    80006f24:	02059893          	slli	a7,a1,0x20
    80006f28:	40f60e3b          	subw	t3,a2,a5
    80006f2c:	011368b3          	or	a7,t1,a7
    80006f30:	02859813          	slli	a6,a1,0x28
    80006f34:	0108e833          	or	a6,a7,a6
    80006f38:	03059693          	slli	a3,a1,0x30
    80006f3c:	003e589b          	srliw	a7,t3,0x3
    80006f40:	00d866b3          	or	a3,a6,a3
    80006f44:	03859713          	slli	a4,a1,0x38
    80006f48:	00389813          	slli	a6,a7,0x3
    80006f4c:	00f507b3          	add	a5,a0,a5
    80006f50:	00e6e733          	or	a4,a3,a4
    80006f54:	000e089b          	sext.w	a7,t3
    80006f58:	00f806b3          	add	a3,a6,a5
    80006f5c:	00e7b023          	sd	a4,0(a5)
    80006f60:	00878793          	addi	a5,a5,8
    80006f64:	fed79ce3          	bne	a5,a3,80006f5c <__memset+0xd4>
    80006f68:	ff8e7793          	andi	a5,t3,-8
    80006f6c:	0007871b          	sext.w	a4,a5
    80006f70:	01d787bb          	addw	a5,a5,t4
    80006f74:	0ce88e63          	beq	a7,a4,80007050 <__memset+0x1c8>
    80006f78:	00f50733          	add	a4,a0,a5
    80006f7c:	00b70023          	sb	a1,0(a4)
    80006f80:	0017871b          	addiw	a4,a5,1
    80006f84:	0cc77663          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80006f88:	00e50733          	add	a4,a0,a4
    80006f8c:	00b70023          	sb	a1,0(a4)
    80006f90:	0027871b          	addiw	a4,a5,2
    80006f94:	0ac77e63          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80006f98:	00e50733          	add	a4,a0,a4
    80006f9c:	00b70023          	sb	a1,0(a4)
    80006fa0:	0037871b          	addiw	a4,a5,3
    80006fa4:	0ac77663          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80006fa8:	00e50733          	add	a4,a0,a4
    80006fac:	00b70023          	sb	a1,0(a4)
    80006fb0:	0047871b          	addiw	a4,a5,4
    80006fb4:	08c77e63          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80006fb8:	00e50733          	add	a4,a0,a4
    80006fbc:	00b70023          	sb	a1,0(a4)
    80006fc0:	0057871b          	addiw	a4,a5,5
    80006fc4:	08c77663          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80006fc8:	00e50733          	add	a4,a0,a4
    80006fcc:	00b70023          	sb	a1,0(a4)
    80006fd0:	0067871b          	addiw	a4,a5,6
    80006fd4:	06c77e63          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80006fd8:	00e50733          	add	a4,a0,a4
    80006fdc:	00b70023          	sb	a1,0(a4)
    80006fe0:	0077871b          	addiw	a4,a5,7
    80006fe4:	06c77663          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80006fe8:	00e50733          	add	a4,a0,a4
    80006fec:	00b70023          	sb	a1,0(a4)
    80006ff0:	0087871b          	addiw	a4,a5,8
    80006ff4:	04c77e63          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80006ff8:	00e50733          	add	a4,a0,a4
    80006ffc:	00b70023          	sb	a1,0(a4)
    80007000:	0097871b          	addiw	a4,a5,9
    80007004:	04c77663          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80007008:	00e50733          	add	a4,a0,a4
    8000700c:	00b70023          	sb	a1,0(a4)
    80007010:	00a7871b          	addiw	a4,a5,10
    80007014:	02c77e63          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80007018:	00e50733          	add	a4,a0,a4
    8000701c:	00b70023          	sb	a1,0(a4)
    80007020:	00b7871b          	addiw	a4,a5,11
    80007024:	02c77663          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80007028:	00e50733          	add	a4,a0,a4
    8000702c:	00b70023          	sb	a1,0(a4)
    80007030:	00c7871b          	addiw	a4,a5,12
    80007034:	00c77e63          	bgeu	a4,a2,80007050 <__memset+0x1c8>
    80007038:	00e50733          	add	a4,a0,a4
    8000703c:	00b70023          	sb	a1,0(a4)
    80007040:	00d7879b          	addiw	a5,a5,13
    80007044:	00c7f663          	bgeu	a5,a2,80007050 <__memset+0x1c8>
    80007048:	00f507b3          	add	a5,a0,a5
    8000704c:	00b78023          	sb	a1,0(a5)
    80007050:	00813403          	ld	s0,8(sp)
    80007054:	01010113          	addi	sp,sp,16
    80007058:	00008067          	ret
    8000705c:	00b00693          	li	a3,11
    80007060:	e55ff06f          	j	80006eb4 <__memset+0x2c>
    80007064:	00300e93          	li	t4,3
    80007068:	ea5ff06f          	j	80006f0c <__memset+0x84>
    8000706c:	00100e93          	li	t4,1
    80007070:	e9dff06f          	j	80006f0c <__memset+0x84>
    80007074:	00000e93          	li	t4,0
    80007078:	e95ff06f          	j	80006f0c <__memset+0x84>
    8000707c:	00000793          	li	a5,0
    80007080:	ef9ff06f          	j	80006f78 <__memset+0xf0>
    80007084:	00200e93          	li	t4,2
    80007088:	e85ff06f          	j	80006f0c <__memset+0x84>
    8000708c:	00400e93          	li	t4,4
    80007090:	e7dff06f          	j	80006f0c <__memset+0x84>
    80007094:	00500e93          	li	t4,5
    80007098:	e75ff06f          	j	80006f0c <__memset+0x84>
    8000709c:	00600e93          	li	t4,6
    800070a0:	e6dff06f          	j	80006f0c <__memset+0x84>

00000000800070a4 <__memmove>:
    800070a4:	ff010113          	addi	sp,sp,-16
    800070a8:	00813423          	sd	s0,8(sp)
    800070ac:	01010413          	addi	s0,sp,16
    800070b0:	0e060863          	beqz	a2,800071a0 <__memmove+0xfc>
    800070b4:	fff6069b          	addiw	a3,a2,-1
    800070b8:	0006881b          	sext.w	a6,a3
    800070bc:	0ea5e863          	bltu	a1,a0,800071ac <__memmove+0x108>
    800070c0:	00758713          	addi	a4,a1,7
    800070c4:	00a5e7b3          	or	a5,a1,a0
    800070c8:	40a70733          	sub	a4,a4,a0
    800070cc:	0077f793          	andi	a5,a5,7
    800070d0:	00f73713          	sltiu	a4,a4,15
    800070d4:	00174713          	xori	a4,a4,1
    800070d8:	0017b793          	seqz	a5,a5
    800070dc:	00e7f7b3          	and	a5,a5,a4
    800070e0:	10078863          	beqz	a5,800071f0 <__memmove+0x14c>
    800070e4:	00900793          	li	a5,9
    800070e8:	1107f463          	bgeu	a5,a6,800071f0 <__memmove+0x14c>
    800070ec:	0036581b          	srliw	a6,a2,0x3
    800070f0:	fff8081b          	addiw	a6,a6,-1
    800070f4:	02081813          	slli	a6,a6,0x20
    800070f8:	01d85893          	srli	a7,a6,0x1d
    800070fc:	00858813          	addi	a6,a1,8
    80007100:	00058793          	mv	a5,a1
    80007104:	00050713          	mv	a4,a0
    80007108:	01088833          	add	a6,a7,a6
    8000710c:	0007b883          	ld	a7,0(a5)
    80007110:	00878793          	addi	a5,a5,8
    80007114:	00870713          	addi	a4,a4,8
    80007118:	ff173c23          	sd	a7,-8(a4)
    8000711c:	ff0798e3          	bne	a5,a6,8000710c <__memmove+0x68>
    80007120:	ff867713          	andi	a4,a2,-8
    80007124:	02071793          	slli	a5,a4,0x20
    80007128:	0207d793          	srli	a5,a5,0x20
    8000712c:	00f585b3          	add	a1,a1,a5
    80007130:	40e686bb          	subw	a3,a3,a4
    80007134:	00f507b3          	add	a5,a0,a5
    80007138:	06e60463          	beq	a2,a4,800071a0 <__memmove+0xfc>
    8000713c:	0005c703          	lbu	a4,0(a1)
    80007140:	00e78023          	sb	a4,0(a5)
    80007144:	04068e63          	beqz	a3,800071a0 <__memmove+0xfc>
    80007148:	0015c603          	lbu	a2,1(a1)
    8000714c:	00100713          	li	a4,1
    80007150:	00c780a3          	sb	a2,1(a5)
    80007154:	04e68663          	beq	a3,a4,800071a0 <__memmove+0xfc>
    80007158:	0025c603          	lbu	a2,2(a1)
    8000715c:	00200713          	li	a4,2
    80007160:	00c78123          	sb	a2,2(a5)
    80007164:	02e68e63          	beq	a3,a4,800071a0 <__memmove+0xfc>
    80007168:	0035c603          	lbu	a2,3(a1)
    8000716c:	00300713          	li	a4,3
    80007170:	00c781a3          	sb	a2,3(a5)
    80007174:	02e68663          	beq	a3,a4,800071a0 <__memmove+0xfc>
    80007178:	0045c603          	lbu	a2,4(a1)
    8000717c:	00400713          	li	a4,4
    80007180:	00c78223          	sb	a2,4(a5)
    80007184:	00e68e63          	beq	a3,a4,800071a0 <__memmove+0xfc>
    80007188:	0055c603          	lbu	a2,5(a1)
    8000718c:	00500713          	li	a4,5
    80007190:	00c782a3          	sb	a2,5(a5)
    80007194:	00e68663          	beq	a3,a4,800071a0 <__memmove+0xfc>
    80007198:	0065c703          	lbu	a4,6(a1)
    8000719c:	00e78323          	sb	a4,6(a5)
    800071a0:	00813403          	ld	s0,8(sp)
    800071a4:	01010113          	addi	sp,sp,16
    800071a8:	00008067          	ret
    800071ac:	02061713          	slli	a4,a2,0x20
    800071b0:	02075713          	srli	a4,a4,0x20
    800071b4:	00e587b3          	add	a5,a1,a4
    800071b8:	f0f574e3          	bgeu	a0,a5,800070c0 <__memmove+0x1c>
    800071bc:	02069613          	slli	a2,a3,0x20
    800071c0:	02065613          	srli	a2,a2,0x20
    800071c4:	fff64613          	not	a2,a2
    800071c8:	00e50733          	add	a4,a0,a4
    800071cc:	00c78633          	add	a2,a5,a2
    800071d0:	fff7c683          	lbu	a3,-1(a5)
    800071d4:	fff78793          	addi	a5,a5,-1
    800071d8:	fff70713          	addi	a4,a4,-1
    800071dc:	00d70023          	sb	a3,0(a4)
    800071e0:	fec798e3          	bne	a5,a2,800071d0 <__memmove+0x12c>
    800071e4:	00813403          	ld	s0,8(sp)
    800071e8:	01010113          	addi	sp,sp,16
    800071ec:	00008067          	ret
    800071f0:	02069713          	slli	a4,a3,0x20
    800071f4:	02075713          	srli	a4,a4,0x20
    800071f8:	00170713          	addi	a4,a4,1
    800071fc:	00e50733          	add	a4,a0,a4
    80007200:	00050793          	mv	a5,a0
    80007204:	0005c683          	lbu	a3,0(a1)
    80007208:	00178793          	addi	a5,a5,1
    8000720c:	00158593          	addi	a1,a1,1
    80007210:	fed78fa3          	sb	a3,-1(a5)
    80007214:	fee798e3          	bne	a5,a4,80007204 <__memmove+0x160>
    80007218:	f89ff06f          	j	800071a0 <__memmove+0xfc>
	...

Disassembly of section .user:

000000008000f600 <copy_and_swap-0xa00>:
	...

0000000080010000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80010000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80010004:	00b29a63          	bne	t0,a1,80010018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80010008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8001000c:	fe029ae3          	bnez	t0,80010000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80010010:	00000513          	li	a0,0
    jr ra                  # Return.
    80010014:	00008067          	ret

0000000080010018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80010018:	00100513          	li	a0,1
    8001001c:	00008067          	ret

0000000080010020 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80010020:	ff010113          	addi	sp,sp,-16
    80010024:	00813423          	sd	s0,8(sp)
    80010028:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    8001002c:	03f50513          	addi	a0,a0,63
    80010030:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80010034:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80010038:	00100513          	li	a0,1
    asm("ecall");
    8001003c:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80010040:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80010044:	00813403          	ld	s0,8(sp)
    80010048:	01010113          	addi	sp,sp,16
    8001004c:	00008067          	ret

0000000080010050 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80010050:	ff010113          	addi	sp,sp,-16
    80010054:	00813423          	sd	s0,8(sp)
    80010058:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    8001005c:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80010060:	00200513          	li	a0,2
    asm("ecall");
    80010064:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80010068:	00050513          	mv	a0,a0
    return status;
}
    8001006c:	0005051b          	sext.w	a0,a0
    80010070:	00813403          	ld	s0,8(sp)
    80010074:	01010113          	addi	sp,sp,16
    80010078:	00008067          	ret

000000008001007c <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    8001007c:	fd010113          	addi	sp,sp,-48
    80010080:	02113423          	sd	ra,40(sp)
    80010084:	02813023          	sd	s0,32(sp)
    80010088:	00913c23          	sd	s1,24(sp)
    8001008c:	01213823          	sd	s2,16(sp)
    80010090:	01313423          	sd	s3,8(sp)
    80010094:	03010413          	addi	s0,sp,48
    80010098:	00050913          	mv	s2,a0
    8001009c:	00058493          	mv	s1,a1
    800100a0:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    800100a4:	04058e63          	beqz	a1,80010100 <_Z13thread_createPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    800100a8:	00001537          	lui	a0,0x1
    800100ac:	00000097          	auipc	ra,0x0
    800100b0:	f74080e7          	jalr	-140(ra) # 80010020 <_Z9mem_allocm>
        if(istack == 0) {
    800100b4:	04050063          	beqz	a0,800100f4 <_Z13thread_createPP7_threadPFvPvES2_+0x78>
            *handle = nullptr;
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    800100b8:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    800100bc:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    800100c0:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800100c4:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    800100c8:	01100513          	li	a0,17

    asm("ecall");
    800100cc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800100d0:	00050513          	mv	a0,a0

    return status;
    800100d4:	0005051b          	sext.w	a0,a0
}
    800100d8:	02813083          	ld	ra,40(sp)
    800100dc:	02013403          	ld	s0,32(sp)
    800100e0:	01813483          	ld	s1,24(sp)
    800100e4:	01013903          	ld	s2,16(sp)
    800100e8:	00813983          	ld	s3,8(sp)
    800100ec:	03010113          	addi	sp,sp,48
    800100f0:	00008067          	ret
            *handle = nullptr;
    800100f4:	00093023          	sd	zero,0(s2)
            return -1;
    800100f8:	fff00513          	li	a0,-1
    800100fc:	fddff06f          	j	800100d8 <_Z13thread_createPP7_threadPFvPvES2_+0x5c>
    uint64 istack = 0;
    80010100:	00000513          	li	a0,0
    80010104:	fb5ff06f          	j	800100b8 <_Z13thread_createPP7_threadPFvPvES2_+0x3c>

0000000080010108 <_Z11thread_exitv>:

int thread_exit(){
    80010108:	ff010113          	addi	sp,sp,-16
    8001010c:	00813423          	sd	s0,8(sp)
    80010110:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80010114:	01200513          	li	a0,18

    asm("ecall");
    80010118:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8001011c:	00050513          	mv	a0,a0

    return status;
}
    80010120:	0005051b          	sext.w	a0,a0
    80010124:	00813403          	ld	s0,8(sp)
    80010128:	01010113          	addi	sp,sp,16
    8001012c:	00008067          	ret

0000000080010130 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80010130:	ff010113          	addi	sp,sp,-16
    80010134:	00813423          	sd	s0,8(sp)
    80010138:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    8001013c:	01300513          	li	a0,19

    asm("ecall");
    80010140:	00000073          	ecall
}
    80010144:	00813403          	ld	s0,8(sp)
    80010148:	01010113          	addi	sp,sp,16
    8001014c:	00008067          	ret

0000000080010150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80010150:	fd010113          	addi	sp,sp,-48
    80010154:	02113423          	sd	ra,40(sp)
    80010158:	02813023          	sd	s0,32(sp)
    8001015c:	00913c23          	sd	s1,24(sp)
    80010160:	01213823          	sd	s2,16(sp)
    80010164:	01313423          	sd	s3,8(sp)
    80010168:	03010413          	addi	s0,sp,48
    8001016c:	00050493          	mv	s1,a0
    80010170:	00058913          	mv	s2,a1
    80010174:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(handle && start_routine) {
    80010178:	04050a63          	beqz	a0,800101cc <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x7c>
    8001017c:	04058c63          	beqz	a1,800101d4 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80010180:	00001537          	lui	a0,0x1
    80010184:	00000097          	auipc	ra,0x0
    80010188:	e9c080e7          	jalr	-356(ra) # 80010020 <_Z9mem_allocm>
        if(istack == 0) {
    8001018c:	04050863          	beqz	a0,800101dc <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x8c>
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80010190:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80010194:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80010198:	00090613          	mv	a2,s2
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8001019c:	00048593          	mv	a1,s1
    asm("li a0, 0x14");
    800101a0:	01400513          	li	a0,20

    asm("ecall");
    800101a4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800101a8:	00050513          	mv	a0,a0

    return status;
    800101ac:	0005051b          	sext.w	a0,a0
}
    800101b0:	02813083          	ld	ra,40(sp)
    800101b4:	02013403          	ld	s0,32(sp)
    800101b8:	01813483          	ld	s1,24(sp)
    800101bc:	01013903          	ld	s2,16(sp)
    800101c0:	00813983          	ld	s3,8(sp)
    800101c4:	03010113          	addi	sp,sp,48
    800101c8:	00008067          	ret
    uint64 istack = 0;
    800101cc:	00000513          	li	a0,0
    800101d0:	fc1ff06f          	j	80010190 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
    800101d4:	00000513          	li	a0,0
    800101d8:	fb9ff06f          	j	80010190 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
            return -1;
    800101dc:	fff00513          	li	a0,-1
    800101e0:	fd1ff06f          	j	800101b0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x60>

00000000800101e4 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    800101e4:	ff010113          	addi	sp,sp,-16
    800101e8:	00813423          	sd	s0,8(sp)
    800101ec:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;
    if(handle == nullptr)
    800101f0:	02050263          	beqz	a0,80010214 <_Z12thread_startP7_thread+0x30>
        return -1;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800101f4:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    800101f8:	01500513          	li	a0,21

    asm("ecall");
    800101fc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80010200:	00050513          	mv	a0,a0

    return status;
    80010204:	0005051b          	sext.w	a0,a0
}
    80010208:	00813403          	ld	s0,8(sp)
    8001020c:	01010113          	addi	sp,sp,16
    80010210:	00008067          	ret
        return -1;
    80010214:	fff00513          	li	a0,-1
    80010218:	ff1ff06f          	j	80010208 <_Z12thread_startP7_thread+0x24>

000000008001021c <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    8001021c:	ff010113          	addi	sp,sp,-16
    80010220:	00813423          	sd	s0,8(sp)
    80010224:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80010228:	02059593          	slli	a1,a1,0x20
    8001022c:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80010230:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80010234:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80010238:	02100513          	li	a0,33


    asm("ecall");
    8001023c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80010240:	00050513          	mv	a0,a0

    return status;

}
    80010244:	0005051b          	sext.w	a0,a0
    80010248:	00813403          	ld	s0,8(sp)
    8001024c:	01010113          	addi	sp,sp,16
    80010250:	00008067          	ret

0000000080010254 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80010254:	ff010113          	addi	sp,sp,-16
    80010258:	00813423          	sd	s0,8(sp)
    8001025c:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80010260:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80010264:	02200513          	li	a0,34


    asm("ecall");
    80010268:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8001026c:	00050513          	mv	a0,a0

    return status;
}
    80010270:	0005051b          	sext.w	a0,a0
    80010274:	00813403          	ld	s0,8(sp)
    80010278:	01010113          	addi	sp,sp,16
    8001027c:	00008067          	ret

0000000080010280 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80010280:	ff010113          	addi	sp,sp,-16
    80010284:	00813423          	sd	s0,8(sp)
    80010288:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8001028c:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80010290:	02300513          	li	a0,35


    asm("ecall");
    80010294:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80010298:	00050513          	mv	a0,a0

    return status;
}
    8001029c:	0005051b          	sext.w	a0,a0
    800102a0:	00813403          	ld	s0,8(sp)
    800102a4:	01010113          	addi	sp,sp,16
    800102a8:	00008067          	ret

00000000800102ac <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    800102ac:	ff010113          	addi	sp,sp,-16
    800102b0:	00813423          	sd	s0,8(sp)
    800102b4:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800102b8:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    800102bc:	02400513          	li	a0,36


    asm("ecall");
    800102c0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800102c4:	00050513          	mv	a0,a0

    return status;
}
    800102c8:	0005051b          	sext.w	a0,a0
    800102cc:	00813403          	ld	s0,8(sp)
    800102d0:	01010113          	addi	sp,sp,16
    800102d4:	00008067          	ret

00000000800102d8 <_Z10time_sleepm>:

int time_sleep(time_t time){
    800102d8:	ff010113          	addi	sp,sp,-16
    800102dc:	00813423          	sd	s0,8(sp)
    800102e0:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    800102e4:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    800102e8:	03100513          	li	a0,49


    asm("ecall");
    800102ec:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800102f0:	00050513          	mv	a0,a0

    return status;
}
    800102f4:	0005051b          	sext.w	a0,a0
    800102f8:	00813403          	ld	s0,8(sp)
    800102fc:	01010113          	addi	sp,sp,16
    80010300:	00008067          	ret

0000000080010304 <_Z4getcv>:

char getc(){
    80010304:	ff010113          	addi	sp,sp,-16
    80010308:	00813423          	sd	s0,8(sp)
    8001030c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    80010310:	04100513          	li	a0,65

    asm("ecall");
    80010314:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    80010318:	00050513          	mv	a0,a0

    return c;
}
    8001031c:	0ff57513          	andi	a0,a0,255
    80010320:	00813403          	ld	s0,8(sp)
    80010324:	01010113          	addi	sp,sp,16
    80010328:	00008067          	ret

000000008001032c <_Z4putcc>:

void putc(char c){
    8001032c:	ff010113          	addi	sp,sp,-16
    80010330:	00813423          	sd	s0,8(sp)
    80010334:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    80010338:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    8001033c:	04200513          	li	a0,66

    asm("ecall");
    80010340:	00000073          	ecall
}
    80010344:	00813403          	ld	s0,8(sp)
    80010348:	01010113          	addi	sp,sp,16
    8001034c:	00008067          	ret

0000000080010350 <_Z4forkv>:


int fork(){
    80010350:	ff010113          	addi	sp,sp,-16
    80010354:	00813423          	sd	s0,8(sp)
    80010358:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    8001035c:	06100513          	li	a0,97

    asm("ecall");
    80010360:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80010364:	00050513          	mv	a0,a0

    return status;
}
    80010368:	0005051b          	sext.w	a0,a0
    8001036c:	00813403          	ld	s0,8(sp)
    80010370:	01010113          	addi	sp,sp,16
    80010374:	00008067          	ret

0000000080010378 <_Z8tcb_freePv>:

void tcb_free(void* addr){
    80010378:	ff010113          	addi	sp,sp,-16
    8001037c:	00813423          	sd	s0,8(sp)
    80010380:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80010384:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80010388:	05100513          	li	a0,81
    asm("ecall");
    8001038c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    80010390:	00813403          	ld	s0,8(sp)
    80010394:	01010113          	addi	sp,sp,16
    80010398:	00008067          	ret

000000008001039c <_ZN10_semaphoredlEPv>:
#include "../../h/_semaphore.hpp"
#include "../../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    8001039c:	ff010113          	addi	sp,sp,-16
    800103a0:	00113423          	sd	ra,8(sp)
    800103a4:	00813023          	sd	s0,0(sp)
    800103a8:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    800103ac:	00000097          	auipc	ra,0x0
    800103b0:	ea8080e7          	jalr	-344(ra) # 80010254 <_Z9sem_closeP10_semaphore>
}
    800103b4:	00813083          	ld	ra,8(sp)
    800103b8:	00013403          	ld	s0,0(sp)
    800103bc:	01010113          	addi	sp,sp,16
    800103c0:	00008067          	ret

00000000800103c4 <_ZN7_threaddlEPv>:
#include "../../h/_thread.hpp"
#include "../../h/tcb.hpp"
#include "../../h/syscall_c.h"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    800103c4:	ff010113          	addi	sp,sp,-16
    800103c8:	00113423          	sd	ra,8(sp)
    800103cc:	00813023          	sd	s0,0(sp)
    800103d0:	01010413          	addi	s0,sp,16
    tcb_free(addr);
    800103d4:	00000097          	auipc	ra,0x0
    800103d8:	fa4080e7          	jalr	-92(ra) # 80010378 <_Z8tcb_freePv>
    800103dc:	00813083          	ld	ra,8(sp)
    800103e0:	00013403          	ld	s0,0(sp)
    800103e4:	01010113          	addi	sp,sp,16
    800103e8:	00008067          	ret

00000000800103ec <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800103ec:	fd010113          	addi	sp,sp,-48
    800103f0:	02113423          	sd	ra,40(sp)
    800103f4:	02813023          	sd	s0,32(sp)
    800103f8:	00913c23          	sd	s1,24(sp)
    800103fc:	01213823          	sd	s2,16(sp)
    80010400:	01313423          	sd	s3,8(sp)
    80010404:	03010413          	addi	s0,sp,48
    80010408:	00050493          	mv	s1,a0
    8001040c:	00058993          	mv	s3,a1
    80010410:	0015879b          	addiw	a5,a1,1
    80010414:	0007851b          	sext.w	a0,a5
    80010418:	00f4a023          	sw	a5,0(s1)
    8001041c:	0004a823          	sw	zero,16(s1)
    80010420:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80010424:	00251513          	slli	a0,a0,0x2
    80010428:	00000097          	auipc	ra,0x0
    8001042c:	bf8080e7          	jalr	-1032(ra) # 80010020 <_Z9mem_allocm>
    80010430:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80010434:	01000513          	li	a0,16
    80010438:	00001097          	auipc	ra,0x1
    8001043c:	408080e7          	jalr	1032(ra) # 80011840 <_Znwm>
    80010440:	00050913          	mv	s2,a0
    80010444:	00050863          	beqz	a0,80010454 <_ZN9BufferCPPC1Ei+0x68>
    80010448:	00000593          	li	a1,0
    8001044c:	00001097          	auipc	ra,0x1
    80010450:	4ec080e7          	jalr	1260(ra) # 80011938 <_ZN9SemaphoreC1Ej>
    80010454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80010458:	01000513          	li	a0,16
    8001045c:	00001097          	auipc	ra,0x1
    80010460:	3e4080e7          	jalr	996(ra) # 80011840 <_Znwm>
    80010464:	00050913          	mv	s2,a0
    80010468:	00050863          	beqz	a0,80010478 <_ZN9BufferCPPC1Ei+0x8c>
    8001046c:	00098593          	mv	a1,s3
    80010470:	00001097          	auipc	ra,0x1
    80010474:	4c8080e7          	jalr	1224(ra) # 80011938 <_ZN9SemaphoreC1Ej>
    80010478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8001047c:	01000513          	li	a0,16
    80010480:	00001097          	auipc	ra,0x1
    80010484:	3c0080e7          	jalr	960(ra) # 80011840 <_Znwm>
    80010488:	00050913          	mv	s2,a0
    8001048c:	00050863          	beqz	a0,8001049c <_ZN9BufferCPPC1Ei+0xb0>
    80010490:	00100593          	li	a1,1
    80010494:	00001097          	auipc	ra,0x1
    80010498:	4a4080e7          	jalr	1188(ra) # 80011938 <_ZN9SemaphoreC1Ej>
    8001049c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800104a0:	01000513          	li	a0,16
    800104a4:	00001097          	auipc	ra,0x1
    800104a8:	39c080e7          	jalr	924(ra) # 80011840 <_Znwm>
    800104ac:	00050913          	mv	s2,a0
    800104b0:	00050863          	beqz	a0,800104c0 <_ZN9BufferCPPC1Ei+0xd4>
    800104b4:	00100593          	li	a1,1
    800104b8:	00001097          	auipc	ra,0x1
    800104bc:	480080e7          	jalr	1152(ra) # 80011938 <_ZN9SemaphoreC1Ej>
    800104c0:	0324b823          	sd	s2,48(s1)
}
    800104c4:	02813083          	ld	ra,40(sp)
    800104c8:	02013403          	ld	s0,32(sp)
    800104cc:	01813483          	ld	s1,24(sp)
    800104d0:	01013903          	ld	s2,16(sp)
    800104d4:	00813983          	ld	s3,8(sp)
    800104d8:	03010113          	addi	sp,sp,48
    800104dc:	00008067          	ret
    800104e0:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800104e4:	00090513          	mv	a0,s2
    800104e8:	00001097          	auipc	ra,0x1
    800104ec:	3a8080e7          	jalr	936(ra) # 80011890 <_ZdlPv>
    800104f0:	00048513          	mv	a0,s1
    800104f4:	ffffe097          	auipc	ra,0xffffe
    800104f8:	9a4080e7          	jalr	-1628(ra) # 8000de98 <_Unwind_Resume>
    800104fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80010500:	00090513          	mv	a0,s2
    80010504:	00001097          	auipc	ra,0x1
    80010508:	38c080e7          	jalr	908(ra) # 80011890 <_ZdlPv>
    8001050c:	00048513          	mv	a0,s1
    80010510:	ffffe097          	auipc	ra,0xffffe
    80010514:	988080e7          	jalr	-1656(ra) # 8000de98 <_Unwind_Resume>
    80010518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8001051c:	00090513          	mv	a0,s2
    80010520:	00001097          	auipc	ra,0x1
    80010524:	370080e7          	jalr	880(ra) # 80011890 <_ZdlPv>
    80010528:	00048513          	mv	a0,s1
    8001052c:	ffffe097          	auipc	ra,0xffffe
    80010530:	96c080e7          	jalr	-1684(ra) # 8000de98 <_Unwind_Resume>
    80010534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80010538:	00090513          	mv	a0,s2
    8001053c:	00001097          	auipc	ra,0x1
    80010540:	354080e7          	jalr	852(ra) # 80011890 <_ZdlPv>
    80010544:	00048513          	mv	a0,s1
    80010548:	ffffe097          	auipc	ra,0xffffe
    8001054c:	950080e7          	jalr	-1712(ra) # 8000de98 <_Unwind_Resume>

0000000080010550 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80010550:	fe010113          	addi	sp,sp,-32
    80010554:	00113c23          	sd	ra,24(sp)
    80010558:	00813823          	sd	s0,16(sp)
    8001055c:	00913423          	sd	s1,8(sp)
    80010560:	01213023          	sd	s2,0(sp)
    80010564:	02010413          	addi	s0,sp,32
    80010568:	00050493          	mv	s1,a0
    8001056c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80010570:	01853503          	ld	a0,24(a0) # 1018 <_entry-0x7fffefe8>
    80010574:	00001097          	auipc	ra,0x1
    80010578:	3fc080e7          	jalr	1020(ra) # 80011970 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8001057c:	0304b503          	ld	a0,48(s1)
    80010580:	00001097          	auipc	ra,0x1
    80010584:	3f0080e7          	jalr	1008(ra) # 80011970 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80010588:	0084b783          	ld	a5,8(s1)
    8001058c:	0144a703          	lw	a4,20(s1)
    80010590:	00271713          	slli	a4,a4,0x2
    80010594:	00e787b3          	add	a5,a5,a4
    80010598:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8001059c:	0144a783          	lw	a5,20(s1)
    800105a0:	0017879b          	addiw	a5,a5,1
    800105a4:	0004a703          	lw	a4,0(s1)
    800105a8:	02e7e7bb          	remw	a5,a5,a4
    800105ac:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800105b0:	0304b503          	ld	a0,48(s1)
    800105b4:	00001097          	auipc	ra,0x1
    800105b8:	3e8080e7          	jalr	1000(ra) # 8001199c <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800105bc:	0204b503          	ld	a0,32(s1)
    800105c0:	00001097          	auipc	ra,0x1
    800105c4:	3dc080e7          	jalr	988(ra) # 8001199c <_ZN9Semaphore6signalEv>

}
    800105c8:	01813083          	ld	ra,24(sp)
    800105cc:	01013403          	ld	s0,16(sp)
    800105d0:	00813483          	ld	s1,8(sp)
    800105d4:	00013903          	ld	s2,0(sp)
    800105d8:	02010113          	addi	sp,sp,32
    800105dc:	00008067          	ret

00000000800105e0 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800105e0:	fe010113          	addi	sp,sp,-32
    800105e4:	00113c23          	sd	ra,24(sp)
    800105e8:	00813823          	sd	s0,16(sp)
    800105ec:	00913423          	sd	s1,8(sp)
    800105f0:	01213023          	sd	s2,0(sp)
    800105f4:	02010413          	addi	s0,sp,32
    800105f8:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800105fc:	02053503          	ld	a0,32(a0)
    80010600:	00001097          	auipc	ra,0x1
    80010604:	370080e7          	jalr	880(ra) # 80011970 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80010608:	0284b503          	ld	a0,40(s1)
    8001060c:	00001097          	auipc	ra,0x1
    80010610:	364080e7          	jalr	868(ra) # 80011970 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80010614:	0084b703          	ld	a4,8(s1)
    80010618:	0104a783          	lw	a5,16(s1)
    8001061c:	00279693          	slli	a3,a5,0x2
    80010620:	00d70733          	add	a4,a4,a3
    80010624:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80010628:	0017879b          	addiw	a5,a5,1
    8001062c:	0004a703          	lw	a4,0(s1)
    80010630:	02e7e7bb          	remw	a5,a5,a4
    80010634:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80010638:	0284b503          	ld	a0,40(s1)
    8001063c:	00001097          	auipc	ra,0x1
    80010640:	360080e7          	jalr	864(ra) # 8001199c <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80010644:	0184b503          	ld	a0,24(s1)
    80010648:	00001097          	auipc	ra,0x1
    8001064c:	354080e7          	jalr	852(ra) # 8001199c <_ZN9Semaphore6signalEv>

    return ret;
}
    80010650:	00090513          	mv	a0,s2
    80010654:	01813083          	ld	ra,24(sp)
    80010658:	01013403          	ld	s0,16(sp)
    8001065c:	00813483          	ld	s1,8(sp)
    80010660:	00013903          	ld	s2,0(sp)
    80010664:	02010113          	addi	sp,sp,32
    80010668:	00008067          	ret

000000008001066c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8001066c:	fe010113          	addi	sp,sp,-32
    80010670:	00113c23          	sd	ra,24(sp)
    80010674:	00813823          	sd	s0,16(sp)
    80010678:	00913423          	sd	s1,8(sp)
    8001067c:	01213023          	sd	s2,0(sp)
    80010680:	02010413          	addi	s0,sp,32
    80010684:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80010688:	02853503          	ld	a0,40(a0)
    8001068c:	00001097          	auipc	ra,0x1
    80010690:	2e4080e7          	jalr	740(ra) # 80011970 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80010694:	0304b503          	ld	a0,48(s1)
    80010698:	00001097          	auipc	ra,0x1
    8001069c:	2d8080e7          	jalr	728(ra) # 80011970 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800106a0:	0144a783          	lw	a5,20(s1)
    800106a4:	0104a903          	lw	s2,16(s1)
    800106a8:	0327ce63          	blt	a5,s2,800106e4 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800106ac:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800106b0:	0304b503          	ld	a0,48(s1)
    800106b4:	00001097          	auipc	ra,0x1
    800106b8:	2e8080e7          	jalr	744(ra) # 8001199c <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800106bc:	0284b503          	ld	a0,40(s1)
    800106c0:	00001097          	auipc	ra,0x1
    800106c4:	2dc080e7          	jalr	732(ra) # 8001199c <_ZN9Semaphore6signalEv>

    return ret;
}
    800106c8:	00090513          	mv	a0,s2
    800106cc:	01813083          	ld	ra,24(sp)
    800106d0:	01013403          	ld	s0,16(sp)
    800106d4:	00813483          	ld	s1,8(sp)
    800106d8:	00013903          	ld	s2,0(sp)
    800106dc:	02010113          	addi	sp,sp,32
    800106e0:	00008067          	ret
        ret = cap - head + tail;
    800106e4:	0004a703          	lw	a4,0(s1)
    800106e8:	4127093b          	subw	s2,a4,s2
    800106ec:	00f9093b          	addw	s2,s2,a5
    800106f0:	fc1ff06f          	j	800106b0 <_ZN9BufferCPP6getCntEv+0x44>

00000000800106f4 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800106f4:	fe010113          	addi	sp,sp,-32
    800106f8:	00113c23          	sd	ra,24(sp)
    800106fc:	00813823          	sd	s0,16(sp)
    80010700:	00913423          	sd	s1,8(sp)
    80010704:	02010413          	addi	s0,sp,32
    80010708:	00050493          	mv	s1,a0
    Console::putc('\n');
    8001070c:	00a00513          	li	a0,10
    80010710:	00001097          	auipc	ra,0x1
    80010714:	4c4080e7          	jalr	1220(ra) # 80011bd4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80010718:	00002517          	auipc	a0,0x2
    8001071c:	8e850513          	addi	a0,a0,-1816 # 80012000 <userDataStart>
    80010720:	00001097          	auipc	ra,0x1
    80010724:	d74080e7          	jalr	-652(ra) # 80011494 <_Z11printStringPKc>
    while (getCnt()) {
    80010728:	00048513          	mv	a0,s1
    8001072c:	00000097          	auipc	ra,0x0
    80010730:	f40080e7          	jalr	-192(ra) # 8001066c <_ZN9BufferCPP6getCntEv>
    80010734:	02050c63          	beqz	a0,8001076c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80010738:	0084b783          	ld	a5,8(s1)
    8001073c:	0104a703          	lw	a4,16(s1)
    80010740:	00271713          	slli	a4,a4,0x2
    80010744:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80010748:	0007c503          	lbu	a0,0(a5)
    8001074c:	00001097          	auipc	ra,0x1
    80010750:	488080e7          	jalr	1160(ra) # 80011bd4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80010754:	0104a783          	lw	a5,16(s1)
    80010758:	0017879b          	addiw	a5,a5,1
    8001075c:	0004a703          	lw	a4,0(s1)
    80010760:	02e7e7bb          	remw	a5,a5,a4
    80010764:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80010768:	fc1ff06f          	j	80010728 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8001076c:	02100513          	li	a0,33
    80010770:	00001097          	auipc	ra,0x1
    80010774:	464080e7          	jalr	1124(ra) # 80011bd4 <_ZN7Console4putcEc>
    Console::putc('\n');
    80010778:	00a00513          	li	a0,10
    8001077c:	00001097          	auipc	ra,0x1
    80010780:	458080e7          	jalr	1112(ra) # 80011bd4 <_ZN7Console4putcEc>
    mem_free(buffer);
    80010784:	0084b503          	ld	a0,8(s1)
    80010788:	00000097          	auipc	ra,0x0
    8001078c:	8c8080e7          	jalr	-1848(ra) # 80010050 <_Z8mem_freePv>
    delete itemAvailable;
    80010790:	0204b503          	ld	a0,32(s1)
    80010794:	00050863          	beqz	a0,800107a4 <_ZN9BufferCPPD1Ev+0xb0>
    80010798:	00053783          	ld	a5,0(a0)
    8001079c:	0087b783          	ld	a5,8(a5)
    800107a0:	000780e7          	jalr	a5
    delete spaceAvailable;
    800107a4:	0184b503          	ld	a0,24(s1)
    800107a8:	00050863          	beqz	a0,800107b8 <_ZN9BufferCPPD1Ev+0xc4>
    800107ac:	00053783          	ld	a5,0(a0)
    800107b0:	0087b783          	ld	a5,8(a5)
    800107b4:	000780e7          	jalr	a5
    delete mutexTail;
    800107b8:	0304b503          	ld	a0,48(s1)
    800107bc:	00050863          	beqz	a0,800107cc <_ZN9BufferCPPD1Ev+0xd8>
    800107c0:	00053783          	ld	a5,0(a0)
    800107c4:	0087b783          	ld	a5,8(a5)
    800107c8:	000780e7          	jalr	a5
    delete mutexHead;
    800107cc:	0284b503          	ld	a0,40(s1)
    800107d0:	00050863          	beqz	a0,800107e0 <_ZN9BufferCPPD1Ev+0xec>
    800107d4:	00053783          	ld	a5,0(a0)
    800107d8:	0087b783          	ld	a5,8(a5)
    800107dc:	000780e7          	jalr	a5
}
    800107e0:	01813083          	ld	ra,24(sp)
    800107e4:	01013403          	ld	s0,16(sp)
    800107e8:	00813483          	ld	s1,8(sp)
    800107ec:	02010113          	addi	sp,sp,32
    800107f0:	00008067          	ret

00000000800107f4 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    800107f4:	fe010113          	addi	sp,sp,-32
    800107f8:	00113c23          	sd	ra,24(sp)
    800107fc:	00813823          	sd	s0,16(sp)
    80010800:	00913423          	sd	s1,8(sp)
    80010804:	01213023          	sd	s2,0(sp)
    80010808:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8001080c:	00000913          	li	s2,0
    80010810:	0380006f          	j	80010848 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80010814:	00000097          	auipc	ra,0x0
    80010818:	91c080e7          	jalr	-1764(ra) # 80010130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8001081c:	00148493          	addi	s1,s1,1
    80010820:	000027b7          	lui	a5,0x2
    80010824:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80010828:	0097ee63          	bltu	a5,s1,80010844 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8001082c:	00000713          	li	a4,0
    80010830:	000077b7          	lui	a5,0x7
    80010834:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80010838:	fce7eee3          	bltu	a5,a4,80010814 <_Z11workerBodyAPv+0x20>
    8001083c:	00170713          	addi	a4,a4,1
    80010840:	ff1ff06f          	j	80010830 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80010844:	00190913          	addi	s2,s2,1
    80010848:	00900793          	li	a5,9
    8001084c:	0527e063          	bltu	a5,s2,8001088c <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80010850:	00001517          	auipc	a0,0x1
    80010854:	7c850513          	addi	a0,a0,1992 # 80012018 <userDataStart+0x18>
    80010858:	00001097          	auipc	ra,0x1
    8001085c:	c3c080e7          	jalr	-964(ra) # 80011494 <_Z11printStringPKc>
    80010860:	00000613          	li	a2,0
    80010864:	00a00593          	li	a1,10
    80010868:	0009051b          	sext.w	a0,s2
    8001086c:	00001097          	auipc	ra,0x1
    80010870:	dc0080e7          	jalr	-576(ra) # 8001162c <_Z8printIntiii>
    80010874:	00001517          	auipc	a0,0x1
    80010878:	7ac50513          	addi	a0,a0,1964 # 80012020 <userDataStart+0x20>
    8001087c:	00001097          	auipc	ra,0x1
    80010880:	c18080e7          	jalr	-1000(ra) # 80011494 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80010884:	00000493          	li	s1,0
    80010888:	f99ff06f          	j	80010820 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8001088c:	00001517          	auipc	a0,0x1
    80010890:	79c50513          	addi	a0,a0,1948 # 80012028 <userDataStart+0x28>
    80010894:	00001097          	auipc	ra,0x1
    80010898:	c00080e7          	jalr	-1024(ra) # 80011494 <_Z11printStringPKc>
    finishedA = true;
    8001089c:	00100793          	li	a5,1
    800108a0:	00002717          	auipc	a4,0x2
    800108a4:	96f70c23          	sb	a5,-1672(a4) # 80012218 <finishedA>
}
    800108a8:	01813083          	ld	ra,24(sp)
    800108ac:	01013403          	ld	s0,16(sp)
    800108b0:	00813483          	ld	s1,8(sp)
    800108b4:	00013903          	ld	s2,0(sp)
    800108b8:	02010113          	addi	sp,sp,32
    800108bc:	00008067          	ret

00000000800108c0 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    800108c0:	fe010113          	addi	sp,sp,-32
    800108c4:	00113c23          	sd	ra,24(sp)
    800108c8:	00813823          	sd	s0,16(sp)
    800108cc:	00913423          	sd	s1,8(sp)
    800108d0:	01213023          	sd	s2,0(sp)
    800108d4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800108d8:	00000913          	li	s2,0
    800108dc:	0380006f          	j	80010914 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800108e0:	00000097          	auipc	ra,0x0
    800108e4:	850080e7          	jalr	-1968(ra) # 80010130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800108e8:	00148493          	addi	s1,s1,1
    800108ec:	000027b7          	lui	a5,0x2
    800108f0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800108f4:	0097ee63          	bltu	a5,s1,80010910 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800108f8:	00000713          	li	a4,0
    800108fc:	000077b7          	lui	a5,0x7
    80010900:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80010904:	fce7eee3          	bltu	a5,a4,800108e0 <_Z11workerBodyBPv+0x20>
    80010908:	00170713          	addi	a4,a4,1
    8001090c:	ff1ff06f          	j	800108fc <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80010910:	00190913          	addi	s2,s2,1
    80010914:	00f00793          	li	a5,15
    80010918:	0527e063          	bltu	a5,s2,80010958 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8001091c:	00001517          	auipc	a0,0x1
    80010920:	71c50513          	addi	a0,a0,1820 # 80012038 <userDataStart+0x38>
    80010924:	00001097          	auipc	ra,0x1
    80010928:	b70080e7          	jalr	-1168(ra) # 80011494 <_Z11printStringPKc>
    8001092c:	00000613          	li	a2,0
    80010930:	00a00593          	li	a1,10
    80010934:	0009051b          	sext.w	a0,s2
    80010938:	00001097          	auipc	ra,0x1
    8001093c:	cf4080e7          	jalr	-780(ra) # 8001162c <_Z8printIntiii>
    80010940:	00001517          	auipc	a0,0x1
    80010944:	6e050513          	addi	a0,a0,1760 # 80012020 <userDataStart+0x20>
    80010948:	00001097          	auipc	ra,0x1
    8001094c:	b4c080e7          	jalr	-1204(ra) # 80011494 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80010950:	00000493          	li	s1,0
    80010954:	f99ff06f          	j	800108ec <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    80010958:	00001517          	auipc	a0,0x1
    8001095c:	6e850513          	addi	a0,a0,1768 # 80012040 <userDataStart+0x40>
    80010960:	00001097          	auipc	ra,0x1
    80010964:	b34080e7          	jalr	-1228(ra) # 80011494 <_Z11printStringPKc>
    finishedB = true;
    80010968:	00100793          	li	a5,1
    8001096c:	00002717          	auipc	a4,0x2
    80010970:	8af706a3          	sb	a5,-1875(a4) # 80012219 <finishedB>
    thread_dispatch();
    80010974:	fffff097          	auipc	ra,0xfffff
    80010978:	7bc080e7          	jalr	1980(ra) # 80010130 <_Z15thread_dispatchv>
}
    8001097c:	01813083          	ld	ra,24(sp)
    80010980:	01013403          	ld	s0,16(sp)
    80010984:	00813483          	ld	s1,8(sp)
    80010988:	00013903          	ld	s2,0(sp)
    8001098c:	02010113          	addi	sp,sp,32
    80010990:	00008067          	ret

0000000080010994 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80010994:	fe010113          	addi	sp,sp,-32
    80010998:	00113c23          	sd	ra,24(sp)
    8001099c:	00813823          	sd	s0,16(sp)
    800109a0:	00913423          	sd	s1,8(sp)
    800109a4:	01213023          	sd	s2,0(sp)
    800109a8:	02010413          	addi	s0,sp,32
    800109ac:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800109b0:	00100793          	li	a5,1
    800109b4:	02a7f863          	bgeu	a5,a0,800109e4 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800109b8:	00a00793          	li	a5,10
    800109bc:	02f577b3          	remu	a5,a0,a5
    800109c0:	02078e63          	beqz	a5,800109fc <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800109c4:	fff48513          	addi	a0,s1,-1
    800109c8:	00000097          	auipc	ra,0x0
    800109cc:	fcc080e7          	jalr	-52(ra) # 80010994 <_Z9fibonaccim>
    800109d0:	00050913          	mv	s2,a0
    800109d4:	ffe48513          	addi	a0,s1,-2
    800109d8:	00000097          	auipc	ra,0x0
    800109dc:	fbc080e7          	jalr	-68(ra) # 80010994 <_Z9fibonaccim>
    800109e0:	00a90533          	add	a0,s2,a0
}
    800109e4:	01813083          	ld	ra,24(sp)
    800109e8:	01013403          	ld	s0,16(sp)
    800109ec:	00813483          	ld	s1,8(sp)
    800109f0:	00013903          	ld	s2,0(sp)
    800109f4:	02010113          	addi	sp,sp,32
    800109f8:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800109fc:	fffff097          	auipc	ra,0xfffff
    80010a00:	734080e7          	jalr	1844(ra) # 80010130 <_Z15thread_dispatchv>
    80010a04:	fc1ff06f          	j	800109c4 <_Z9fibonaccim+0x30>

0000000080010a08 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80010a08:	fe010113          	addi	sp,sp,-32
    80010a0c:	00113c23          	sd	ra,24(sp)
    80010a10:	00813823          	sd	s0,16(sp)
    80010a14:	00913423          	sd	s1,8(sp)
    80010a18:	01213023          	sd	s2,0(sp)
    80010a1c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80010a20:	00000493          	li	s1,0
    80010a24:	0400006f          	j	80010a64 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80010a28:	00001517          	auipc	a0,0x1
    80010a2c:	62850513          	addi	a0,a0,1576 # 80012050 <userDataStart+0x50>
    80010a30:	00001097          	auipc	ra,0x1
    80010a34:	a64080e7          	jalr	-1436(ra) # 80011494 <_Z11printStringPKc>
    80010a38:	00000613          	li	a2,0
    80010a3c:	00a00593          	li	a1,10
    80010a40:	00048513          	mv	a0,s1
    80010a44:	00001097          	auipc	ra,0x1
    80010a48:	be8080e7          	jalr	-1048(ra) # 8001162c <_Z8printIntiii>
    80010a4c:	00001517          	auipc	a0,0x1
    80010a50:	5d450513          	addi	a0,a0,1492 # 80012020 <userDataStart+0x20>
    80010a54:	00001097          	auipc	ra,0x1
    80010a58:	a40080e7          	jalr	-1472(ra) # 80011494 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80010a5c:	0014849b          	addiw	s1,s1,1
    80010a60:	0ff4f493          	andi	s1,s1,255
    80010a64:	00200793          	li	a5,2
    80010a68:	fc97f0e3          	bgeu	a5,s1,80010a28 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    80010a6c:	00001517          	auipc	a0,0x1
    80010a70:	5ec50513          	addi	a0,a0,1516 # 80012058 <userDataStart+0x58>
    80010a74:	00001097          	auipc	ra,0x1
    80010a78:	a20080e7          	jalr	-1504(ra) # 80011494 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80010a7c:	00700313          	li	t1,7
    thread_dispatch();
    80010a80:	fffff097          	auipc	ra,0xfffff
    80010a84:	6b0080e7          	jalr	1712(ra) # 80010130 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80010a88:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80010a8c:	00001517          	auipc	a0,0x1
    80010a90:	5dc50513          	addi	a0,a0,1500 # 80012068 <userDataStart+0x68>
    80010a94:	00001097          	auipc	ra,0x1
    80010a98:	a00080e7          	jalr	-1536(ra) # 80011494 <_Z11printStringPKc>
    80010a9c:	00000613          	li	a2,0
    80010aa0:	00a00593          	li	a1,10
    80010aa4:	0009051b          	sext.w	a0,s2
    80010aa8:	00001097          	auipc	ra,0x1
    80010aac:	b84080e7          	jalr	-1148(ra) # 8001162c <_Z8printIntiii>
    80010ab0:	00001517          	auipc	a0,0x1
    80010ab4:	57050513          	addi	a0,a0,1392 # 80012020 <userDataStart+0x20>
    80010ab8:	00001097          	auipc	ra,0x1
    80010abc:	9dc080e7          	jalr	-1572(ra) # 80011494 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80010ac0:	00c00513          	li	a0,12
    80010ac4:	00000097          	auipc	ra,0x0
    80010ac8:	ed0080e7          	jalr	-304(ra) # 80010994 <_Z9fibonaccim>
    80010acc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80010ad0:	00001517          	auipc	a0,0x1
    80010ad4:	5a050513          	addi	a0,a0,1440 # 80012070 <userDataStart+0x70>
    80010ad8:	00001097          	auipc	ra,0x1
    80010adc:	9bc080e7          	jalr	-1604(ra) # 80011494 <_Z11printStringPKc>
    80010ae0:	00000613          	li	a2,0
    80010ae4:	00a00593          	li	a1,10
    80010ae8:	0009051b          	sext.w	a0,s2
    80010aec:	00001097          	auipc	ra,0x1
    80010af0:	b40080e7          	jalr	-1216(ra) # 8001162c <_Z8printIntiii>
    80010af4:	00001517          	auipc	a0,0x1
    80010af8:	52c50513          	addi	a0,a0,1324 # 80012020 <userDataStart+0x20>
    80010afc:	00001097          	auipc	ra,0x1
    80010b00:	998080e7          	jalr	-1640(ra) # 80011494 <_Z11printStringPKc>
    80010b04:	0400006f          	j	80010b44 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80010b08:	00001517          	auipc	a0,0x1
    80010b0c:	54850513          	addi	a0,a0,1352 # 80012050 <userDataStart+0x50>
    80010b10:	00001097          	auipc	ra,0x1
    80010b14:	984080e7          	jalr	-1660(ra) # 80011494 <_Z11printStringPKc>
    80010b18:	00000613          	li	a2,0
    80010b1c:	00a00593          	li	a1,10
    80010b20:	00048513          	mv	a0,s1
    80010b24:	00001097          	auipc	ra,0x1
    80010b28:	b08080e7          	jalr	-1272(ra) # 8001162c <_Z8printIntiii>
    80010b2c:	00001517          	auipc	a0,0x1
    80010b30:	4f450513          	addi	a0,a0,1268 # 80012020 <userDataStart+0x20>
    80010b34:	00001097          	auipc	ra,0x1
    80010b38:	960080e7          	jalr	-1696(ra) # 80011494 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80010b3c:	0014849b          	addiw	s1,s1,1
    80010b40:	0ff4f493          	andi	s1,s1,255
    80010b44:	00500793          	li	a5,5
    80010b48:	fc97f0e3          	bgeu	a5,s1,80010b08 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    80010b4c:	00001517          	auipc	a0,0x1
    80010b50:	4dc50513          	addi	a0,a0,1244 # 80012028 <userDataStart+0x28>
    80010b54:	00001097          	auipc	ra,0x1
    80010b58:	940080e7          	jalr	-1728(ra) # 80011494 <_Z11printStringPKc>
    finishedC = true;
    80010b5c:	00100793          	li	a5,1
    80010b60:	00001717          	auipc	a4,0x1
    80010b64:	6af70d23          	sb	a5,1722(a4) # 8001221a <finishedC>
    thread_dispatch();
    80010b68:	fffff097          	auipc	ra,0xfffff
    80010b6c:	5c8080e7          	jalr	1480(ra) # 80010130 <_Z15thread_dispatchv>
}
    80010b70:	01813083          	ld	ra,24(sp)
    80010b74:	01013403          	ld	s0,16(sp)
    80010b78:	00813483          	ld	s1,8(sp)
    80010b7c:	00013903          	ld	s2,0(sp)
    80010b80:	02010113          	addi	sp,sp,32
    80010b84:	00008067          	ret

0000000080010b88 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    80010b88:	fe010113          	addi	sp,sp,-32
    80010b8c:	00113c23          	sd	ra,24(sp)
    80010b90:	00813823          	sd	s0,16(sp)
    80010b94:	00913423          	sd	s1,8(sp)
    80010b98:	01213023          	sd	s2,0(sp)
    80010b9c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80010ba0:	00a00493          	li	s1,10
    80010ba4:	0400006f          	j	80010be4 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80010ba8:	00001517          	auipc	a0,0x1
    80010bac:	4d850513          	addi	a0,a0,1240 # 80012080 <userDataStart+0x80>
    80010bb0:	00001097          	auipc	ra,0x1
    80010bb4:	8e4080e7          	jalr	-1820(ra) # 80011494 <_Z11printStringPKc>
    80010bb8:	00000613          	li	a2,0
    80010bbc:	00a00593          	li	a1,10
    80010bc0:	00048513          	mv	a0,s1
    80010bc4:	00001097          	auipc	ra,0x1
    80010bc8:	a68080e7          	jalr	-1432(ra) # 8001162c <_Z8printIntiii>
    80010bcc:	00001517          	auipc	a0,0x1
    80010bd0:	45450513          	addi	a0,a0,1108 # 80012020 <userDataStart+0x20>
    80010bd4:	00001097          	auipc	ra,0x1
    80010bd8:	8c0080e7          	jalr	-1856(ra) # 80011494 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80010bdc:	0014849b          	addiw	s1,s1,1
    80010be0:	0ff4f493          	andi	s1,s1,255
    80010be4:	00c00793          	li	a5,12
    80010be8:	fc97f0e3          	bgeu	a5,s1,80010ba8 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80010bec:	00001517          	auipc	a0,0x1
    80010bf0:	49c50513          	addi	a0,a0,1180 # 80012088 <userDataStart+0x88>
    80010bf4:	00001097          	auipc	ra,0x1
    80010bf8:	8a0080e7          	jalr	-1888(ra) # 80011494 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80010bfc:	00500313          	li	t1,5
    thread_dispatch();
    80010c00:	fffff097          	auipc	ra,0xfffff
    80010c04:	530080e7          	jalr	1328(ra) # 80010130 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80010c08:	01000513          	li	a0,16
    80010c0c:	00000097          	auipc	ra,0x0
    80010c10:	d88080e7          	jalr	-632(ra) # 80010994 <_Z9fibonaccim>
    80010c14:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80010c18:	00001517          	auipc	a0,0x1
    80010c1c:	48050513          	addi	a0,a0,1152 # 80012098 <userDataStart+0x98>
    80010c20:	00001097          	auipc	ra,0x1
    80010c24:	874080e7          	jalr	-1932(ra) # 80011494 <_Z11printStringPKc>
    80010c28:	00000613          	li	a2,0
    80010c2c:	00a00593          	li	a1,10
    80010c30:	0009051b          	sext.w	a0,s2
    80010c34:	00001097          	auipc	ra,0x1
    80010c38:	9f8080e7          	jalr	-1544(ra) # 8001162c <_Z8printIntiii>
    80010c3c:	00001517          	auipc	a0,0x1
    80010c40:	3e450513          	addi	a0,a0,996 # 80012020 <userDataStart+0x20>
    80010c44:	00001097          	auipc	ra,0x1
    80010c48:	850080e7          	jalr	-1968(ra) # 80011494 <_Z11printStringPKc>
    80010c4c:	0400006f          	j	80010c8c <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80010c50:	00001517          	auipc	a0,0x1
    80010c54:	43050513          	addi	a0,a0,1072 # 80012080 <userDataStart+0x80>
    80010c58:	00001097          	auipc	ra,0x1
    80010c5c:	83c080e7          	jalr	-1988(ra) # 80011494 <_Z11printStringPKc>
    80010c60:	00000613          	li	a2,0
    80010c64:	00a00593          	li	a1,10
    80010c68:	00048513          	mv	a0,s1
    80010c6c:	00001097          	auipc	ra,0x1
    80010c70:	9c0080e7          	jalr	-1600(ra) # 8001162c <_Z8printIntiii>
    80010c74:	00001517          	auipc	a0,0x1
    80010c78:	3ac50513          	addi	a0,a0,940 # 80012020 <userDataStart+0x20>
    80010c7c:	00001097          	auipc	ra,0x1
    80010c80:	818080e7          	jalr	-2024(ra) # 80011494 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80010c84:	0014849b          	addiw	s1,s1,1
    80010c88:	0ff4f493          	andi	s1,s1,255
    80010c8c:	00f00793          	li	a5,15
    80010c90:	fc97f0e3          	bgeu	a5,s1,80010c50 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80010c94:	00001517          	auipc	a0,0x1
    80010c98:	41450513          	addi	a0,a0,1044 # 800120a8 <userDataStart+0xa8>
    80010c9c:	00000097          	auipc	ra,0x0
    80010ca0:	7f8080e7          	jalr	2040(ra) # 80011494 <_Z11printStringPKc>
    finishedD = true;
    80010ca4:	00100793          	li	a5,1
    80010ca8:	00001717          	auipc	a4,0x1
    80010cac:	56f709a3          	sb	a5,1395(a4) # 8001221b <finishedD>
    thread_dispatch();
    80010cb0:	fffff097          	auipc	ra,0xfffff
    80010cb4:	480080e7          	jalr	1152(ra) # 80010130 <_Z15thread_dispatchv>
}
    80010cb8:	01813083          	ld	ra,24(sp)
    80010cbc:	01013403          	ld	s0,16(sp)
    80010cc0:	00813483          	ld	s1,8(sp)
    80010cc4:	00013903          	ld	s2,0(sp)
    80010cc8:	02010113          	addi	sp,sp,32
    80010ccc:	00008067          	ret

0000000080010cd0 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80010cd0:	fc010113          	addi	sp,sp,-64
    80010cd4:	02113c23          	sd	ra,56(sp)
    80010cd8:	02813823          	sd	s0,48(sp)
    80010cdc:	02913423          	sd	s1,40(sp)
    80010ce0:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80010ce4:	00000613          	li	a2,0
    80010ce8:	00000597          	auipc	a1,0x0
    80010cec:	b0c58593          	addi	a1,a1,-1268 # 800107f4 <_Z11workerBodyAPv>
    80010cf0:	fc040513          	addi	a0,s0,-64
    80010cf4:	fffff097          	auipc	ra,0xfffff
    80010cf8:	388080e7          	jalr	904(ra) # 8001007c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80010cfc:	00001517          	auipc	a0,0x1
    80010d00:	3bc50513          	addi	a0,a0,956 # 800120b8 <userDataStart+0xb8>
    80010d04:	00000097          	auipc	ra,0x0
    80010d08:	790080e7          	jalr	1936(ra) # 80011494 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80010d0c:	00000613          	li	a2,0
    80010d10:	00000597          	auipc	a1,0x0
    80010d14:	bb058593          	addi	a1,a1,-1104 # 800108c0 <_Z11workerBodyBPv>
    80010d18:	fc840513          	addi	a0,s0,-56
    80010d1c:	fffff097          	auipc	ra,0xfffff
    80010d20:	360080e7          	jalr	864(ra) # 8001007c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80010d24:	00001517          	auipc	a0,0x1
    80010d28:	3ac50513          	addi	a0,a0,940 # 800120d0 <userDataStart+0xd0>
    80010d2c:	00000097          	auipc	ra,0x0
    80010d30:	768080e7          	jalr	1896(ra) # 80011494 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80010d34:	00000613          	li	a2,0
    80010d38:	00000597          	auipc	a1,0x0
    80010d3c:	cd058593          	addi	a1,a1,-816 # 80010a08 <_Z11workerBodyCPv>
    80010d40:	fd040513          	addi	a0,s0,-48
    80010d44:	fffff097          	auipc	ra,0xfffff
    80010d48:	338080e7          	jalr	824(ra) # 8001007c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80010d4c:	00001517          	auipc	a0,0x1
    80010d50:	39c50513          	addi	a0,a0,924 # 800120e8 <userDataStart+0xe8>
    80010d54:	00000097          	auipc	ra,0x0
    80010d58:	740080e7          	jalr	1856(ra) # 80011494 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80010d5c:	00000613          	li	a2,0
    80010d60:	00000597          	auipc	a1,0x0
    80010d64:	e2858593          	addi	a1,a1,-472 # 80010b88 <_Z11workerBodyDPv>
    80010d68:	fd840513          	addi	a0,s0,-40
    80010d6c:	fffff097          	auipc	ra,0xfffff
    80010d70:	310080e7          	jalr	784(ra) # 8001007c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80010d74:	00001517          	auipc	a0,0x1
    80010d78:	38c50513          	addi	a0,a0,908 # 80012100 <userDataStart+0x100>
    80010d7c:	00000097          	auipc	ra,0x0
    80010d80:	718080e7          	jalr	1816(ra) # 80011494 <_Z11printStringPKc>
    80010d84:	00c0006f          	j	80010d90 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80010d88:	fffff097          	auipc	ra,0xfffff
    80010d8c:	3a8080e7          	jalr	936(ra) # 80010130 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80010d90:	00001797          	auipc	a5,0x1
    80010d94:	4887c783          	lbu	a5,1160(a5) # 80012218 <finishedA>
    80010d98:	fe0788e3          	beqz	a5,80010d88 <_Z18Threads_C_API_testv+0xb8>
    80010d9c:	00001797          	auipc	a5,0x1
    80010da0:	47d7c783          	lbu	a5,1149(a5) # 80012219 <finishedB>
    80010da4:	fe0782e3          	beqz	a5,80010d88 <_Z18Threads_C_API_testv+0xb8>
    80010da8:	00001797          	auipc	a5,0x1
    80010dac:	4727c783          	lbu	a5,1138(a5) # 8001221a <finishedC>
    80010db0:	fc078ce3          	beqz	a5,80010d88 <_Z18Threads_C_API_testv+0xb8>
    80010db4:	00001797          	auipc	a5,0x1
    80010db8:	4677c783          	lbu	a5,1127(a5) # 8001221b <finishedD>
    80010dbc:	fc0786e3          	beqz	a5,80010d88 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80010dc0:	fc040493          	addi	s1,s0,-64
    80010dc4:	0080006f          	j	80010dcc <_Z18Threads_C_API_testv+0xfc>
    80010dc8:	00848493          	addi	s1,s1,8
    80010dcc:	fe040793          	addi	a5,s0,-32
    80010dd0:	00f48c63          	beq	s1,a5,80010de8 <_Z18Threads_C_API_testv+0x118>
    80010dd4:	0004b503          	ld	a0,0(s1)
    80010dd8:	fe0508e3          	beqz	a0,80010dc8 <_Z18Threads_C_API_testv+0xf8>
    80010ddc:	fffff097          	auipc	ra,0xfffff
    80010de0:	5e8080e7          	jalr	1512(ra) # 800103c4 <_ZN7_threaddlEPv>
    80010de4:	fe5ff06f          	j	80010dc8 <_Z18Threads_C_API_testv+0xf8>
}
    80010de8:	03813083          	ld	ra,56(sp)
    80010dec:	03013403          	ld	s0,48(sp)
    80010df0:	02813483          	ld	s1,40(sp)
    80010df4:	04010113          	addi	sp,sp,64
    80010df8:	00008067          	ret

0000000080010dfc <_Z8testUserv>:
    long id;
    bool finished;
};


void testUser() {
    80010dfc:	fc010113          	addi	sp,sp,-64
    80010e00:	02113c23          	sd	ra,56(sp)
    80010e04:	02813823          	sd	s0,48(sp)
    80010e08:	02913423          	sd	s1,40(sp)
    80010e0c:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80010e10:	fc040493          	addi	s1,s0,-64
    80010e14:	00048513          	mv	a0,s1
    80010e18:	00001097          	auipc	ra,0x1
    80010e1c:	c04080e7          	jalr	-1020(ra) # 80011a1c <_ZN6ThreadC1Ev>
    80010e20:	00001797          	auipc	a5,0x1
    80010e24:	35078793          	addi	a5,a5,848 # 80012170 <_ZTV10ForkThread+0x10>
    80010e28:	fcf43023          	sd	a5,-64(s0)
    80010e2c:	00100793          	li	a5,1
    80010e30:	fcf43823          	sd	a5,-48(s0)
    80010e34:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    80010e38:	00048513          	mv	a0,s1
    80010e3c:	00001097          	auipc	ra,0x1
    80010e40:	cd0080e7          	jalr	-816(ra) # 80011b0c <_ZN6Thread5startEv>
        return finished;
    80010e44:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    80010e48:	00079863          	bnez	a5,80010e58 <_Z8testUserv+0x5c>
        thread_dispatch();
    80010e4c:	fffff097          	auipc	ra,0xfffff
    80010e50:	2e4080e7          	jalr	740(ra) # 80010130 <_Z15thread_dispatchv>
    80010e54:	ff1ff06f          	j	80010e44 <_Z8testUserv+0x48>
    }

//    ConsoleUtil::printString("User main finished\n");
    printString("User main finished\n");
    80010e58:	00001517          	auipc	a0,0x1
    80010e5c:	2c050513          	addi	a0,a0,704 # 80012118 <userDataStart+0x118>
    80010e60:	00000097          	auipc	ra,0x0
    80010e64:	634080e7          	jalr	1588(ra) # 80011494 <_Z11printStringPKc>
class ForkThread : public Thread {
    80010e68:	00001797          	auipc	a5,0x1
    80010e6c:	30878793          	addi	a5,a5,776 # 80012170 <_ZTV10ForkThread+0x10>
    80010e70:	fcf43023          	sd	a5,-64(s0)
    80010e74:	fc040513          	addi	a0,s0,-64
    80010e78:	00001097          	auipc	ra,0x1
    80010e7c:	988080e7          	jalr	-1656(ra) # 80011800 <_ZN6ThreadD1Ev>
    80010e80:	03813083          	ld	ra,56(sp)
    80010e84:	03013403          	ld	s0,48(sp)
    80010e88:	02813483          	ld	s1,40(sp)
    80010e8c:	04010113          	addi	sp,sp,64
    80010e90:	00008067          	ret
    80010e94:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    80010e98:	00001797          	auipc	a5,0x1
    80010e9c:	2d878793          	addi	a5,a5,728 # 80012170 <_ZTV10ForkThread+0x10>
    80010ea0:	fcf43023          	sd	a5,-64(s0)
    80010ea4:	fc040513          	addi	a0,s0,-64
    80010ea8:	00001097          	auipc	ra,0x1
    80010eac:	958080e7          	jalr	-1704(ra) # 80011800 <_ZN6ThreadD1Ev>
    80010eb0:	00048513          	mv	a0,s1
    80010eb4:	ffffd097          	auipc	ra,0xffffd
    80010eb8:	fe4080e7          	jalr	-28(ra) # 8000de98 <_Unwind_Resume>

0000000080010ebc <_Z8userMainv>:

//#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
//#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta
#include "testUser.hpp"

void userMain() {
    80010ebc:	ff010113          	addi	sp,sp,-16
    80010ec0:	00813423          	sd	s0,8(sp)
    80010ec4:	01010413          	addi	s0,sp,16
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
//    testUser();
    80010ec8:	00813403          	ld	s0,8(sp)
    80010ecc:	01010113          	addi	sp,sp,16
    80010ed0:	00008067          	ret

0000000080010ed4 <_ZN10ForkThread3runEv>:
    virtual void run() {
    80010ed4:	fc010113          	addi	sp,sp,-64
    80010ed8:	02113c23          	sd	ra,56(sp)
    80010edc:	02813823          	sd	s0,48(sp)
    80010ee0:	02913423          	sd	s1,40(sp)
    80010ee4:	03213023          	sd	s2,32(sp)
    80010ee8:	01313c23          	sd	s3,24(sp)
    80010eec:	01413823          	sd	s4,16(sp)
    80010ef0:	01513423          	sd	s5,8(sp)
    80010ef4:	01613023          	sd	s6,0(sp)
    80010ef8:	04010413          	addi	s0,sp,64
    80010efc:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    80010f00:	00001517          	auipc	a0,0x1
    80010f04:	23050513          	addi	a0,a0,560 # 80012130 <userDataStart+0x130>
    80010f08:	00000097          	auipc	ra,0x0
    80010f0c:	58c080e7          	jalr	1420(ra) # 80011494 <_Z11printStringPKc>
        printInt(id,10);
    80010f10:	00000613          	li	a2,0
    80010f14:	00a00593          	li	a1,10
    80010f18:	010a2503          	lw	a0,16(s4)
    80010f1c:	00000097          	auipc	ra,0x0
    80010f20:	710080e7          	jalr	1808(ra) # 8001162c <_Z8printIntiii>
        printString("\n");
    80010f24:	00001517          	auipc	a0,0x1
    80010f28:	0fc50513          	addi	a0,a0,252 # 80012020 <userDataStart+0x20>
    80010f2c:	00000097          	auipc	ra,0x0
    80010f30:	568080e7          	jalr	1384(ra) # 80011494 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    80010f34:	02000513          	li	a0,32
    80010f38:	00001097          	auipc	ra,0x1
    80010f3c:	908080e7          	jalr	-1784(ra) # 80011840 <_Znwm>
    80010f40:	00050993          	mv	s3,a0
    80010f44:	02050463          	beqz	a0,80010f6c <_ZN10ForkThread3runEv+0x98>
    80010f48:	010a3483          	ld	s1,16(s4)
    80010f4c:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80010f50:	00001097          	auipc	ra,0x1
    80010f54:	acc080e7          	jalr	-1332(ra) # 80011a1c <_ZN6ThreadC1Ev>
    80010f58:	00001797          	auipc	a5,0x1
    80010f5c:	21878793          	addi	a5,a5,536 # 80012170 <_ZTV10ForkThread+0x10>
    80010f60:	00f9b023          	sd	a5,0(s3)
    80010f64:	0099b823          	sd	s1,16(s3)
    80010f68:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    80010f6c:	010a3503          	ld	a0,16(s4)
    80010f70:	00351513          	slli	a0,a0,0x3
    80010f74:	fffff097          	auipc	ra,0xfffff
    80010f78:	0ac080e7          	jalr	172(ra) # 80010020 <_Z9mem_allocm>
    80010f7c:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    80010f80:	10050863          	beqz	a0,80011090 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    80010f84:	00000913          	li	s2,0
    80010f88:	0140006f          	j	80010f9c <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    80010f8c:	00391793          	slli	a5,s2,0x3
    80010f90:	00fa87b3          	add	a5,s5,a5
    80010f94:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    80010f98:	00190913          	addi	s2,s2,1
    80010f9c:	010a3783          	ld	a5,16(s4)
    80010fa0:	02f95e63          	bge	s2,a5,80010fdc <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    80010fa4:	02000513          	li	a0,32
    80010fa8:	00001097          	auipc	ra,0x1
    80010fac:	898080e7          	jalr	-1896(ra) # 80011840 <_Znwm>
    80010fb0:	00050493          	mv	s1,a0
    80010fb4:	fc050ce3          	beqz	a0,80010f8c <_ZN10ForkThread3runEv+0xb8>
    80010fb8:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80010fbc:	00001097          	auipc	ra,0x1
    80010fc0:	a60080e7          	jalr	-1440(ra) # 80011a1c <_ZN6ThreadC1Ev>
    80010fc4:	00001797          	auipc	a5,0x1
    80010fc8:	1ac78793          	addi	a5,a5,428 # 80012170 <_ZTV10ForkThread+0x10>
    80010fcc:	00f4b023          	sd	a5,0(s1)
    80010fd0:	0164b823          	sd	s6,16(s1)
    80010fd4:	00048c23          	sb	zero,24(s1)
    80010fd8:	fb5ff06f          	j	80010f8c <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    80010fdc:	06098a63          	beqz	s3,80011050 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    80010fe0:	00098513          	mv	a0,s3
    80010fe4:	00001097          	auipc	ra,0x1
    80010fe8:	b28080e7          	jalr	-1240(ra) # 80011b0c <_ZN6Thread5startEv>
    80010fec:	00050913          	mv	s2,a0
    80010ff0:	04051863          	bnez	a0,80011040 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    80010ff4:	00050493          	mv	s1,a0
    80010ff8:	0100006f          	j	80011008 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    80010ffc:	fffff097          	auipc	ra,0xfffff
    80011000:	134080e7          	jalr	308(ra) # 80010130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    80011004:	0014849b          	addiw	s1,s1,1
    80011008:	000017b7          	lui	a5,0x1
    8001100c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80011010:	0097ce63          	blt	a5,s1,8001102c <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    80011014:	00090713          	mv	a4,s2
    80011018:	000017b7          	lui	a5,0x1
    8001101c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80011020:	fce7cee3          	blt	a5,a4,80010ffc <_ZN10ForkThread3runEv+0x128>
    80011024:	0017071b          	addiw	a4,a4,1
    80011028:	ff1ff06f          	j	80011018 <_ZN10ForkThread3runEv+0x144>
        return finished;
    8001102c:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    80011030:	00079863          	bnez	a5,80011040 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    80011034:	fffff097          	auipc	ra,0xfffff
    80011038:	0fc080e7          	jalr	252(ra) # 80010130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8001103c:	ff1ff06f          	j	8001102c <_ZN10ForkThread3runEv+0x158>
                delete thread;
    80011040:	0009b783          	ld	a5,0(s3)
    80011044:	0087b783          	ld	a5,8(a5)
    80011048:	00098513          	mv	a0,s3
    8001104c:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    80011050:	00000493          	li	s1,0
    80011054:	0080006f          	j	8001105c <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    80011058:	00148493          	addi	s1,s1,1
    8001105c:	010a3783          	ld	a5,16(s4)
    80011060:	02f4d263          	bge	s1,a5,80011084 <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    80011064:	00349793          	slli	a5,s1,0x3
    80011068:	00fa87b3          	add	a5,s5,a5
    8001106c:	0007b503          	ld	a0,0(a5)
    80011070:	fe0504e3          	beqz	a0,80011058 <_ZN10ForkThread3runEv+0x184>
    80011074:	00053783          	ld	a5,0(a0)
    80011078:	0087b783          	ld	a5,8(a5)
    8001107c:	000780e7          	jalr	a5
    80011080:	fd9ff06f          	j	80011058 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    80011084:	000a8513          	mv	a0,s5
    80011088:	fffff097          	auipc	ra,0xfffff
    8001108c:	fc8080e7          	jalr	-56(ra) # 80010050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    80011090:	00001517          	auipc	a0,0x1
    80011094:	0b850513          	addi	a0,a0,184 # 80012148 <userDataStart+0x148>
    80011098:	00000097          	auipc	ra,0x0
    8001109c:	3fc080e7          	jalr	1020(ra) # 80011494 <_Z11printStringPKc>
        printInt(id,10);
    800110a0:	00000613          	li	a2,0
    800110a4:	00a00593          	li	a1,10
    800110a8:	010a2503          	lw	a0,16(s4)
    800110ac:	00000097          	auipc	ra,0x0
    800110b0:	580080e7          	jalr	1408(ra) # 8001162c <_Z8printIntiii>
        printString("\n");
    800110b4:	00001517          	auipc	a0,0x1
    800110b8:	f6c50513          	addi	a0,a0,-148 # 80012020 <userDataStart+0x20>
    800110bc:	00000097          	auipc	ra,0x0
    800110c0:	3d8080e7          	jalr	984(ra) # 80011494 <_Z11printStringPKc>
        finished = true;
    800110c4:	00100793          	li	a5,1
    800110c8:	00fa0c23          	sb	a5,24(s4)
    }
    800110cc:	03813083          	ld	ra,56(sp)
    800110d0:	03013403          	ld	s0,48(sp)
    800110d4:	02813483          	ld	s1,40(sp)
    800110d8:	02013903          	ld	s2,32(sp)
    800110dc:	01813983          	ld	s3,24(sp)
    800110e0:	01013a03          	ld	s4,16(sp)
    800110e4:	00813a83          	ld	s5,8(sp)
    800110e8:	00013b03          	ld	s6,0(sp)
    800110ec:	04010113          	addi	sp,sp,64
    800110f0:	00008067          	ret

00000000800110f4 <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    800110f4:	ff010113          	addi	sp,sp,-16
    800110f8:	00113423          	sd	ra,8(sp)
    800110fc:	00813023          	sd	s0,0(sp)
    80011100:	01010413          	addi	s0,sp,16
    80011104:	00001797          	auipc	a5,0x1
    80011108:	06c78793          	addi	a5,a5,108 # 80012170 <_ZTV10ForkThread+0x10>
    8001110c:	00f53023          	sd	a5,0(a0)
    80011110:	00000097          	auipc	ra,0x0
    80011114:	6f0080e7          	jalr	1776(ra) # 80011800 <_ZN6ThreadD1Ev>
    80011118:	00813083          	ld	ra,8(sp)
    8001111c:	00013403          	ld	s0,0(sp)
    80011120:	01010113          	addi	sp,sp,16
    80011124:	00008067          	ret

0000000080011128 <_ZN10ForkThreadD0Ev>:
    80011128:	fe010113          	addi	sp,sp,-32
    8001112c:	00113c23          	sd	ra,24(sp)
    80011130:	00813823          	sd	s0,16(sp)
    80011134:	00913423          	sd	s1,8(sp)
    80011138:	02010413          	addi	s0,sp,32
    8001113c:	00050493          	mv	s1,a0
    80011140:	00001797          	auipc	a5,0x1
    80011144:	03078793          	addi	a5,a5,48 # 80012170 <_ZTV10ForkThread+0x10>
    80011148:	00f53023          	sd	a5,0(a0)
    8001114c:	00000097          	auipc	ra,0x0
    80011150:	6b4080e7          	jalr	1716(ra) # 80011800 <_ZN6ThreadD1Ev>
    80011154:	00048513          	mv	a0,s1
    80011158:	00000097          	auipc	ra,0x0
    8001115c:	738080e7          	jalr	1848(ra) # 80011890 <_ZdlPv>
    80011160:	01813083          	ld	ra,24(sp)
    80011164:	01013403          	ld	s0,16(sp)
    80011168:	00813483          	ld	s1,8(sp)
    8001116c:	02010113          	addi	sp,sp,32
    80011170:	00008067          	ret

0000000080011174 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80011174:	fe010113          	addi	sp,sp,-32
    80011178:	00113c23          	sd	ra,24(sp)
    8001117c:	00813823          	sd	s0,16(sp)
    80011180:	00913423          	sd	s1,8(sp)
    80011184:	01213023          	sd	s2,0(sp)
    80011188:	02010413          	addi	s0,sp,32
    8001118c:	00050493          	mv	s1,a0
    80011190:	00058913          	mv	s2,a1
    80011194:	0015879b          	addiw	a5,a1,1
    80011198:	0007851b          	sext.w	a0,a5
    8001119c:	00f4a023          	sw	a5,0(s1)
    800111a0:	0004a823          	sw	zero,16(s1)
    800111a4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800111a8:	00251513          	slli	a0,a0,0x2
    800111ac:	fffff097          	auipc	ra,0xfffff
    800111b0:	e74080e7          	jalr	-396(ra) # 80010020 <_Z9mem_allocm>
    800111b4:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800111b8:	00000593          	li	a1,0
    800111bc:	02048513          	addi	a0,s1,32
    800111c0:	fffff097          	auipc	ra,0xfffff
    800111c4:	05c080e7          	jalr	92(ra) # 8001021c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    800111c8:	00090593          	mv	a1,s2
    800111cc:	01848513          	addi	a0,s1,24
    800111d0:	fffff097          	auipc	ra,0xfffff
    800111d4:	04c080e7          	jalr	76(ra) # 8001021c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    800111d8:	00100593          	li	a1,1
    800111dc:	02848513          	addi	a0,s1,40
    800111e0:	fffff097          	auipc	ra,0xfffff
    800111e4:	03c080e7          	jalr	60(ra) # 8001021c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    800111e8:	00100593          	li	a1,1
    800111ec:	03048513          	addi	a0,s1,48
    800111f0:	fffff097          	auipc	ra,0xfffff
    800111f4:	02c080e7          	jalr	44(ra) # 8001021c <_Z8sem_openPP10_semaphorej>
}
    800111f8:	01813083          	ld	ra,24(sp)
    800111fc:	01013403          	ld	s0,16(sp)
    80011200:	00813483          	ld	s1,8(sp)
    80011204:	00013903          	ld	s2,0(sp)
    80011208:	02010113          	addi	sp,sp,32
    8001120c:	00008067          	ret

0000000080011210 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80011210:	fe010113          	addi	sp,sp,-32
    80011214:	00113c23          	sd	ra,24(sp)
    80011218:	00813823          	sd	s0,16(sp)
    8001121c:	00913423          	sd	s1,8(sp)
    80011220:	01213023          	sd	s2,0(sp)
    80011224:	02010413          	addi	s0,sp,32
    80011228:	00050493          	mv	s1,a0
    8001122c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80011230:	01853503          	ld	a0,24(a0)
    80011234:	fffff097          	auipc	ra,0xfffff
    80011238:	04c080e7          	jalr	76(ra) # 80010280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    8001123c:	0304b503          	ld	a0,48(s1)
    80011240:	fffff097          	auipc	ra,0xfffff
    80011244:	040080e7          	jalr	64(ra) # 80010280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80011248:	0084b783          	ld	a5,8(s1)
    8001124c:	0144a703          	lw	a4,20(s1)
    80011250:	00271713          	slli	a4,a4,0x2
    80011254:	00e787b3          	add	a5,a5,a4
    80011258:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8001125c:	0144a783          	lw	a5,20(s1)
    80011260:	0017879b          	addiw	a5,a5,1
    80011264:	0004a703          	lw	a4,0(s1)
    80011268:	02e7e7bb          	remw	a5,a5,a4
    8001126c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80011270:	0304b503          	ld	a0,48(s1)
    80011274:	fffff097          	auipc	ra,0xfffff
    80011278:	038080e7          	jalr	56(ra) # 800102ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    8001127c:	0204b503          	ld	a0,32(s1)
    80011280:	fffff097          	auipc	ra,0xfffff
    80011284:	02c080e7          	jalr	44(ra) # 800102ac <_Z10sem_signalP10_semaphore>

}
    80011288:	01813083          	ld	ra,24(sp)
    8001128c:	01013403          	ld	s0,16(sp)
    80011290:	00813483          	ld	s1,8(sp)
    80011294:	00013903          	ld	s2,0(sp)
    80011298:	02010113          	addi	sp,sp,32
    8001129c:	00008067          	ret

00000000800112a0 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800112a0:	fe010113          	addi	sp,sp,-32
    800112a4:	00113c23          	sd	ra,24(sp)
    800112a8:	00813823          	sd	s0,16(sp)
    800112ac:	00913423          	sd	s1,8(sp)
    800112b0:	01213023          	sd	s2,0(sp)
    800112b4:	02010413          	addi	s0,sp,32
    800112b8:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800112bc:	02053503          	ld	a0,32(a0)
    800112c0:	fffff097          	auipc	ra,0xfffff
    800112c4:	fc0080e7          	jalr	-64(ra) # 80010280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    800112c8:	0284b503          	ld	a0,40(s1)
    800112cc:	fffff097          	auipc	ra,0xfffff
    800112d0:	fb4080e7          	jalr	-76(ra) # 80010280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    800112d4:	0084b703          	ld	a4,8(s1)
    800112d8:	0104a783          	lw	a5,16(s1)
    800112dc:	00279693          	slli	a3,a5,0x2
    800112e0:	00d70733          	add	a4,a4,a3
    800112e4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800112e8:	0017879b          	addiw	a5,a5,1
    800112ec:	0004a703          	lw	a4,0(s1)
    800112f0:	02e7e7bb          	remw	a5,a5,a4
    800112f4:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    800112f8:	0284b503          	ld	a0,40(s1)
    800112fc:	fffff097          	auipc	ra,0xfffff
    80011300:	fb0080e7          	jalr	-80(ra) # 800102ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80011304:	0184b503          	ld	a0,24(s1)
    80011308:	fffff097          	auipc	ra,0xfffff
    8001130c:	fa4080e7          	jalr	-92(ra) # 800102ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80011310:	00090513          	mv	a0,s2
    80011314:	01813083          	ld	ra,24(sp)
    80011318:	01013403          	ld	s0,16(sp)
    8001131c:	00813483          	ld	s1,8(sp)
    80011320:	00013903          	ld	s2,0(sp)
    80011324:	02010113          	addi	sp,sp,32
    80011328:	00008067          	ret

000000008001132c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8001132c:	fe010113          	addi	sp,sp,-32
    80011330:	00113c23          	sd	ra,24(sp)
    80011334:	00813823          	sd	s0,16(sp)
    80011338:	00913423          	sd	s1,8(sp)
    8001133c:	01213023          	sd	s2,0(sp)
    80011340:	02010413          	addi	s0,sp,32
    80011344:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80011348:	02853503          	ld	a0,40(a0)
    8001134c:	fffff097          	auipc	ra,0xfffff
    80011350:	f34080e7          	jalr	-204(ra) # 80010280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80011354:	0304b503          	ld	a0,48(s1)
    80011358:	fffff097          	auipc	ra,0xfffff
    8001135c:	f28080e7          	jalr	-216(ra) # 80010280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80011360:	0144a783          	lw	a5,20(s1)
    80011364:	0104a903          	lw	s2,16(s1)
    80011368:	0327ce63          	blt	a5,s2,800113a4 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8001136c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80011370:	0304b503          	ld	a0,48(s1)
    80011374:	fffff097          	auipc	ra,0xfffff
    80011378:	f38080e7          	jalr	-200(ra) # 800102ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8001137c:	0284b503          	ld	a0,40(s1)
    80011380:	fffff097          	auipc	ra,0xfffff
    80011384:	f2c080e7          	jalr	-212(ra) # 800102ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80011388:	00090513          	mv	a0,s2
    8001138c:	01813083          	ld	ra,24(sp)
    80011390:	01013403          	ld	s0,16(sp)
    80011394:	00813483          	ld	s1,8(sp)
    80011398:	00013903          	ld	s2,0(sp)
    8001139c:	02010113          	addi	sp,sp,32
    800113a0:	00008067          	ret
        ret = cap - head + tail;
    800113a4:	0004a703          	lw	a4,0(s1)
    800113a8:	4127093b          	subw	s2,a4,s2
    800113ac:	00f9093b          	addw	s2,s2,a5
    800113b0:	fc1ff06f          	j	80011370 <_ZN6Buffer6getCntEv+0x44>

00000000800113b4 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800113b4:	fe010113          	addi	sp,sp,-32
    800113b8:	00113c23          	sd	ra,24(sp)
    800113bc:	00813823          	sd	s0,16(sp)
    800113c0:	00913423          	sd	s1,8(sp)
    800113c4:	02010413          	addi	s0,sp,32
    800113c8:	00050493          	mv	s1,a0
    putc('\n');
    800113cc:	00a00513          	li	a0,10
    800113d0:	fffff097          	auipc	ra,0xfffff
    800113d4:	f5c080e7          	jalr	-164(ra) # 8001032c <_Z4putcc>
    printString("Buffer deleted!\n");
    800113d8:	00001517          	auipc	a0,0x1
    800113dc:	c2850513          	addi	a0,a0,-984 # 80012000 <userDataStart>
    800113e0:	00000097          	auipc	ra,0x0
    800113e4:	0b4080e7          	jalr	180(ra) # 80011494 <_Z11printStringPKc>
    while (getCnt() > 0) {
    800113e8:	00048513          	mv	a0,s1
    800113ec:	00000097          	auipc	ra,0x0
    800113f0:	f40080e7          	jalr	-192(ra) # 8001132c <_ZN6Buffer6getCntEv>
    800113f4:	02a05c63          	blez	a0,8001142c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800113f8:	0084b783          	ld	a5,8(s1)
    800113fc:	0104a703          	lw	a4,16(s1)
    80011400:	00271713          	slli	a4,a4,0x2
    80011404:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80011408:	0007c503          	lbu	a0,0(a5)
    8001140c:	fffff097          	auipc	ra,0xfffff
    80011410:	f20080e7          	jalr	-224(ra) # 8001032c <_Z4putcc>
        head = (head + 1) % cap;
    80011414:	0104a783          	lw	a5,16(s1)
    80011418:	0017879b          	addiw	a5,a5,1
    8001141c:	0004a703          	lw	a4,0(s1)
    80011420:	02e7e7bb          	remw	a5,a5,a4
    80011424:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80011428:	fc1ff06f          	j	800113e8 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8001142c:	02100513          	li	a0,33
    80011430:	fffff097          	auipc	ra,0xfffff
    80011434:	efc080e7          	jalr	-260(ra) # 8001032c <_Z4putcc>
    putc('\n');
    80011438:	00a00513          	li	a0,10
    8001143c:	fffff097          	auipc	ra,0xfffff
    80011440:	ef0080e7          	jalr	-272(ra) # 8001032c <_Z4putcc>
    mem_free(buffer);
    80011444:	0084b503          	ld	a0,8(s1)
    80011448:	fffff097          	auipc	ra,0xfffff
    8001144c:	c08080e7          	jalr	-1016(ra) # 80010050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80011450:	0204b503          	ld	a0,32(s1)
    80011454:	fffff097          	auipc	ra,0xfffff
    80011458:	e00080e7          	jalr	-512(ra) # 80010254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    8001145c:	0184b503          	ld	a0,24(s1)
    80011460:	fffff097          	auipc	ra,0xfffff
    80011464:	df4080e7          	jalr	-524(ra) # 80010254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80011468:	0304b503          	ld	a0,48(s1)
    8001146c:	fffff097          	auipc	ra,0xfffff
    80011470:	de8080e7          	jalr	-536(ra) # 80010254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80011474:	0284b503          	ld	a0,40(s1)
    80011478:	fffff097          	auipc	ra,0xfffff
    8001147c:	ddc080e7          	jalr	-548(ra) # 80010254 <_Z9sem_closeP10_semaphore>
}
    80011480:	01813083          	ld	ra,24(sp)
    80011484:	01013403          	ld	s0,16(sp)
    80011488:	00813483          	ld	s1,8(sp)
    8001148c:	02010113          	addi	sp,sp,32
    80011490:	00008067          	ret

0000000080011494 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80011494:	fe010113          	addi	sp,sp,-32
    80011498:	00113c23          	sd	ra,24(sp)
    8001149c:	00813823          	sd	s0,16(sp)
    800114a0:	00913423          	sd	s1,8(sp)
    800114a4:	02010413          	addi	s0,sp,32
    800114a8:	00050493          	mv	s1,a0
    LOCK();
    800114ac:	00100613          	li	a2,1
    800114b0:	00000593          	li	a1,0
    800114b4:	00001517          	auipc	a0,0x1
    800114b8:	d6c50513          	addi	a0,a0,-660 # 80012220 <lockPrint>
    800114bc:	fffff097          	auipc	ra,0xfffff
    800114c0:	b44080e7          	jalr	-1212(ra) # 80010000 <copy_and_swap>
    800114c4:	fe0514e3          	bnez	a0,800114ac <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800114c8:	0004c503          	lbu	a0,0(s1)
    800114cc:	00050a63          	beqz	a0,800114e0 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    800114d0:	fffff097          	auipc	ra,0xfffff
    800114d4:	e5c080e7          	jalr	-420(ra) # 8001032c <_Z4putcc>
        string++;
    800114d8:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800114dc:	fedff06f          	j	800114c8 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800114e0:	00000613          	li	a2,0
    800114e4:	00100593          	li	a1,1
    800114e8:	00001517          	auipc	a0,0x1
    800114ec:	d3850513          	addi	a0,a0,-712 # 80012220 <lockPrint>
    800114f0:	fffff097          	auipc	ra,0xfffff
    800114f4:	b10080e7          	jalr	-1264(ra) # 80010000 <copy_and_swap>
    800114f8:	fe0514e3          	bnez	a0,800114e0 <_Z11printStringPKc+0x4c>
}
    800114fc:	01813083          	ld	ra,24(sp)
    80011500:	01013403          	ld	s0,16(sp)
    80011504:	00813483          	ld	s1,8(sp)
    80011508:	02010113          	addi	sp,sp,32
    8001150c:	00008067          	ret

0000000080011510 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80011510:	fd010113          	addi	sp,sp,-48
    80011514:	02113423          	sd	ra,40(sp)
    80011518:	02813023          	sd	s0,32(sp)
    8001151c:	00913c23          	sd	s1,24(sp)
    80011520:	01213823          	sd	s2,16(sp)
    80011524:	01313423          	sd	s3,8(sp)
    80011528:	01413023          	sd	s4,0(sp)
    8001152c:	03010413          	addi	s0,sp,48
    80011530:	00050993          	mv	s3,a0
    80011534:	00058a13          	mv	s4,a1
    LOCK();
    80011538:	00100613          	li	a2,1
    8001153c:	00000593          	li	a1,0
    80011540:	00001517          	auipc	a0,0x1
    80011544:	ce050513          	addi	a0,a0,-800 # 80012220 <lockPrint>
    80011548:	fffff097          	auipc	ra,0xfffff
    8001154c:	ab8080e7          	jalr	-1352(ra) # 80010000 <copy_and_swap>
    80011550:	fe0514e3          	bnez	a0,80011538 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80011554:	00000913          	li	s2,0
    80011558:	00090493          	mv	s1,s2
    8001155c:	0019091b          	addiw	s2,s2,1
    80011560:	03495a63          	bge	s2,s4,80011594 <_Z9getStringPci+0x84>
        cc = getc();
    80011564:	fffff097          	auipc	ra,0xfffff
    80011568:	da0080e7          	jalr	-608(ra) # 80010304 <_Z4getcv>
        if(cc < 1)
    8001156c:	02050463          	beqz	a0,80011594 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80011570:	009984b3          	add	s1,s3,s1
    80011574:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80011578:	00a00793          	li	a5,10
    8001157c:	00f50a63          	beq	a0,a5,80011590 <_Z9getStringPci+0x80>
    80011580:	00d00793          	li	a5,13
    80011584:	fcf51ae3          	bne	a0,a5,80011558 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80011588:	00090493          	mv	s1,s2
    8001158c:	0080006f          	j	80011594 <_Z9getStringPci+0x84>
    80011590:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80011594:	009984b3          	add	s1,s3,s1
    80011598:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8001159c:	00000613          	li	a2,0
    800115a0:	00100593          	li	a1,1
    800115a4:	00001517          	auipc	a0,0x1
    800115a8:	c7c50513          	addi	a0,a0,-900 # 80012220 <lockPrint>
    800115ac:	fffff097          	auipc	ra,0xfffff
    800115b0:	a54080e7          	jalr	-1452(ra) # 80010000 <copy_and_swap>
    800115b4:	fe0514e3          	bnez	a0,8001159c <_Z9getStringPci+0x8c>
    return buf;
}
    800115b8:	00098513          	mv	a0,s3
    800115bc:	02813083          	ld	ra,40(sp)
    800115c0:	02013403          	ld	s0,32(sp)
    800115c4:	01813483          	ld	s1,24(sp)
    800115c8:	01013903          	ld	s2,16(sp)
    800115cc:	00813983          	ld	s3,8(sp)
    800115d0:	00013a03          	ld	s4,0(sp)
    800115d4:	03010113          	addi	sp,sp,48
    800115d8:	00008067          	ret

00000000800115dc <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800115dc:	ff010113          	addi	sp,sp,-16
    800115e0:	00813423          	sd	s0,8(sp)
    800115e4:	01010413          	addi	s0,sp,16
    800115e8:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800115ec:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800115f0:	0006c603          	lbu	a2,0(a3)
    800115f4:	fd06071b          	addiw	a4,a2,-48
    800115f8:	0ff77713          	andi	a4,a4,255
    800115fc:	00900793          	li	a5,9
    80011600:	02e7e063          	bltu	a5,a4,80011620 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80011604:	0025179b          	slliw	a5,a0,0x2
    80011608:	00a787bb          	addw	a5,a5,a0
    8001160c:	0017979b          	slliw	a5,a5,0x1
    80011610:	00168693          	addi	a3,a3,1
    80011614:	00c787bb          	addw	a5,a5,a2
    80011618:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8001161c:	fd5ff06f          	j	800115f0 <_Z11stringToIntPKc+0x14>
    return n;
}
    80011620:	00813403          	ld	s0,8(sp)
    80011624:	01010113          	addi	sp,sp,16
    80011628:	00008067          	ret

000000008001162c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8001162c:	fc010113          	addi	sp,sp,-64
    80011630:	02113c23          	sd	ra,56(sp)
    80011634:	02813823          	sd	s0,48(sp)
    80011638:	02913423          	sd	s1,40(sp)
    8001163c:	03213023          	sd	s2,32(sp)
    80011640:	01313c23          	sd	s3,24(sp)
    80011644:	04010413          	addi	s0,sp,64
    80011648:	00050493          	mv	s1,a0
    8001164c:	00058913          	mv	s2,a1
    80011650:	00060993          	mv	s3,a2
    LOCK();
    80011654:	00100613          	li	a2,1
    80011658:	00000593          	li	a1,0
    8001165c:	00001517          	auipc	a0,0x1
    80011660:	bc450513          	addi	a0,a0,-1084 # 80012220 <lockPrint>
    80011664:	fffff097          	auipc	ra,0xfffff
    80011668:	99c080e7          	jalr	-1636(ra) # 80010000 <copy_and_swap>
    8001166c:	fe0514e3          	bnez	a0,80011654 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80011670:	00098463          	beqz	s3,80011678 <_Z8printIntiii+0x4c>
    80011674:	0804c463          	bltz	s1,800116fc <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80011678:	0004851b          	sext.w	a0,s1
    neg = 0;
    8001167c:	00000593          	li	a1,0
    }

    i = 0;
    80011680:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80011684:	0009079b          	sext.w	a5,s2
    80011688:	0325773b          	remuw	a4,a0,s2
    8001168c:	00048613          	mv	a2,s1
    80011690:	0014849b          	addiw	s1,s1,1
    80011694:	02071693          	slli	a3,a4,0x20
    80011698:	0206d693          	srli	a3,a3,0x20
    8001169c:	00001717          	auipc	a4,0x1
    800116a0:	aec70713          	addi	a4,a4,-1300 # 80012188 <digits>
    800116a4:	00d70733          	add	a4,a4,a3
    800116a8:	00074683          	lbu	a3,0(a4)
    800116ac:	fd040713          	addi	a4,s0,-48
    800116b0:	00c70733          	add	a4,a4,a2
    800116b4:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800116b8:	0005071b          	sext.w	a4,a0
    800116bc:	0325553b          	divuw	a0,a0,s2
    800116c0:	fcf772e3          	bgeu	a4,a5,80011684 <_Z8printIntiii+0x58>
    if(neg)
    800116c4:	00058c63          	beqz	a1,800116dc <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800116c8:	fd040793          	addi	a5,s0,-48
    800116cc:	009784b3          	add	s1,a5,s1
    800116d0:	02d00793          	li	a5,45
    800116d4:	fef48823          	sb	a5,-16(s1)
    800116d8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800116dc:	fff4849b          	addiw	s1,s1,-1
    800116e0:	0204c463          	bltz	s1,80011708 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    800116e4:	fd040793          	addi	a5,s0,-48
    800116e8:	009787b3          	add	a5,a5,s1
    800116ec:	ff07c503          	lbu	a0,-16(a5)
    800116f0:	fffff097          	auipc	ra,0xfffff
    800116f4:	c3c080e7          	jalr	-964(ra) # 8001032c <_Z4putcc>
    800116f8:	fe5ff06f          	j	800116dc <_Z8printIntiii+0xb0>
        x = -xx;
    800116fc:	4090053b          	negw	a0,s1
        neg = 1;
    80011700:	00100593          	li	a1,1
        x = -xx;
    80011704:	f7dff06f          	j	80011680 <_Z8printIntiii+0x54>

    UNLOCK();
    80011708:	00000613          	li	a2,0
    8001170c:	00100593          	li	a1,1
    80011710:	00001517          	auipc	a0,0x1
    80011714:	b1050513          	addi	a0,a0,-1264 # 80012220 <lockPrint>
    80011718:	fffff097          	auipc	ra,0xfffff
    8001171c:	8e8080e7          	jalr	-1816(ra) # 80010000 <copy_and_swap>
    80011720:	fe0514e3          	bnez	a0,80011708 <_Z8printIntiii+0xdc>
    80011724:	03813083          	ld	ra,56(sp)
    80011728:	03013403          	ld	s0,48(sp)
    8001172c:	02813483          	ld	s1,40(sp)
    80011730:	02013903          	ld	s2,32(sp)
    80011734:	01813983          	ld	s3,24(sp)
    80011738:	04010113          	addi	sp,sp,64
    8001173c:	00008067          	ret

0000000080011740 <_Z11bodyWrapperPFvPvES_>:
#include "../../h/userWrappers.hpp"
#include "../../h/syscall_c.h"
#include "../../src/user/tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    80011740:	ff010113          	addi	sp,sp,-16
    80011744:	00113423          	sd	ra,8(sp)
    80011748:	00813023          	sd	s0,0(sp)
    8001174c:	01010413          	addi	s0,sp,16
    80011750:	00050793          	mv	a5,a0
    body(args);
    80011754:	00058513          	mv	a0,a1
    80011758:	000780e7          	jalr	a5
    thread_exit();
    8001175c:	fffff097          	auipc	ra,0xfffff
    80011760:	9ac080e7          	jalr	-1620(ra) # 80010108 <_Z11thread_exitv>
}
    80011764:	00813083          	ld	ra,8(sp)
    80011768:	00013403          	ld	s0,0(sp)
    8001176c:	01010113          	addi	sp,sp,16
    80011770:	00008067          	ret

0000000080011774 <_Z15userMainWrapperPv>:

void userMainWrapper(void* args) {
    80011774:	ff010113          	addi	sp,sp,-16
    80011778:	00113423          	sd	ra,8(sp)
    8001177c:	00813023          	sd	s0,0(sp)
    80011780:	01010413          	addi	s0,sp,16
    userMain();
    80011784:	fffff097          	auipc	ra,0xfffff
    80011788:	738080e7          	jalr	1848(ra) # 80010ebc <_Z8userMainv>
    8001178c:	00813083          	ld	ra,8(sp)
    80011790:	00013403          	ld	s0,0(sp)
    80011794:	01010113          	addi	sp,sp,16
    80011798:	00008067          	ret

000000008001179c <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    8001179c:	ff010113          	addi	sp,sp,-16
    800117a0:	00113423          	sd	ra,8(sp)
    800117a4:	00813023          	sd	s0,0(sp)
    800117a8:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    800117ac:	00053783          	ld	a5,0(a0)
    800117b0:	0107b783          	ld	a5,16(a5)
    800117b4:	000780e7          	jalr	a5
}
    800117b8:	00813083          	ld	ra,8(sp)
    800117bc:	00013403          	ld	s0,0(sp)
    800117c0:	01010113          	addi	sp,sp,16
    800117c4:	00008067          	ret

00000000800117c8 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    800117c8:	ff010113          	addi	sp,sp,-16
    800117cc:	00113423          	sd	ra,8(sp)
    800117d0:	00813023          	sd	s0,0(sp)
    800117d4:	01010413          	addi	s0,sp,16
    800117d8:	00001797          	auipc	a5,0x1
    800117dc:	a0878793          	addi	a5,a5,-1528 # 800121e0 <_ZTV9Semaphore+0x10>
    800117e0:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800117e4:	00853503          	ld	a0,8(a0)
    800117e8:	fffff097          	auipc	ra,0xfffff
    800117ec:	a6c080e7          	jalr	-1428(ra) # 80010254 <_Z9sem_closeP10_semaphore>
};
    800117f0:	00813083          	ld	ra,8(sp)
    800117f4:	00013403          	ld	s0,0(sp)
    800117f8:	01010113          	addi	sp,sp,16
    800117fc:	00008067          	ret

0000000080011800 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80011800:	00001797          	auipc	a5,0x1
    80011804:	a0078793          	addi	a5,a5,-1536 # 80012200 <_ZTV6Thread+0x10>
    80011808:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8001180c:	00853503          	ld	a0,8(a0)
    80011810:	02050663          	beqz	a0,8001183c <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80011814:	ff010113          	addi	sp,sp,-16
    80011818:	00113423          	sd	ra,8(sp)
    8001181c:	00813023          	sd	s0,0(sp)
    80011820:	01010413          	addi	s0,sp,16
    delete myHandle;
    80011824:	fffff097          	auipc	ra,0xfffff
    80011828:	ba0080e7          	jalr	-1120(ra) # 800103c4 <_ZN7_threaddlEPv>
}
    8001182c:	00813083          	ld	ra,8(sp)
    80011830:	00013403          	ld	s0,0(sp)
    80011834:	01010113          	addi	sp,sp,16
    80011838:	00008067          	ret
    8001183c:	00008067          	ret

0000000080011840 <_Znwm>:
void* operator new(size_t sz){
    80011840:	ff010113          	addi	sp,sp,-16
    80011844:	00113423          	sd	ra,8(sp)
    80011848:	00813023          	sd	s0,0(sp)
    8001184c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80011850:	ffffe097          	auipc	ra,0xffffe
    80011854:	7d0080e7          	jalr	2000(ra) # 80010020 <_Z9mem_allocm>
}
    80011858:	00813083          	ld	ra,8(sp)
    8001185c:	00013403          	ld	s0,0(sp)
    80011860:	01010113          	addi	sp,sp,16
    80011864:	00008067          	ret

0000000080011868 <_Znam>:
void* operator new[](size_t sz){
    80011868:	ff010113          	addi	sp,sp,-16
    8001186c:	00113423          	sd	ra,8(sp)
    80011870:	00813023          	sd	s0,0(sp)
    80011874:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80011878:	ffffe097          	auipc	ra,0xffffe
    8001187c:	7a8080e7          	jalr	1960(ra) # 80010020 <_Z9mem_allocm>
}
    80011880:	00813083          	ld	ra,8(sp)
    80011884:	00013403          	ld	s0,0(sp)
    80011888:	01010113          	addi	sp,sp,16
    8001188c:	00008067          	ret

0000000080011890 <_ZdlPv>:
void operator delete(void *ptr){
    80011890:	ff010113          	addi	sp,sp,-16
    80011894:	00113423          	sd	ra,8(sp)
    80011898:	00813023          	sd	s0,0(sp)
    8001189c:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800118a0:	ffffe097          	auipc	ra,0xffffe
    800118a4:	7b0080e7          	jalr	1968(ra) # 80010050 <_Z8mem_freePv>
}
    800118a8:	00813083          	ld	ra,8(sp)
    800118ac:	00013403          	ld	s0,0(sp)
    800118b0:	01010113          	addi	sp,sp,16
    800118b4:	00008067          	ret

00000000800118b8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    800118b8:	fe010113          	addi	sp,sp,-32
    800118bc:	00113c23          	sd	ra,24(sp)
    800118c0:	00813823          	sd	s0,16(sp)
    800118c4:	00913423          	sd	s1,8(sp)
    800118c8:	02010413          	addi	s0,sp,32
    800118cc:	00050493          	mv	s1,a0
};
    800118d0:	00000097          	auipc	ra,0x0
    800118d4:	ef8080e7          	jalr	-264(ra) # 800117c8 <_ZN9SemaphoreD1Ev>
    800118d8:	00048513          	mv	a0,s1
    800118dc:	00000097          	auipc	ra,0x0
    800118e0:	fb4080e7          	jalr	-76(ra) # 80011890 <_ZdlPv>
    800118e4:	01813083          	ld	ra,24(sp)
    800118e8:	01013403          	ld	s0,16(sp)
    800118ec:	00813483          	ld	s1,8(sp)
    800118f0:	02010113          	addi	sp,sp,32
    800118f4:	00008067          	ret

00000000800118f8 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800118f8:	fe010113          	addi	sp,sp,-32
    800118fc:	00113c23          	sd	ra,24(sp)
    80011900:	00813823          	sd	s0,16(sp)
    80011904:	00913423          	sd	s1,8(sp)
    80011908:	02010413          	addi	s0,sp,32
    8001190c:	00050493          	mv	s1,a0
}
    80011910:	00000097          	auipc	ra,0x0
    80011914:	ef0080e7          	jalr	-272(ra) # 80011800 <_ZN6ThreadD1Ev>
    80011918:	00048513          	mv	a0,s1
    8001191c:	00000097          	auipc	ra,0x0
    80011920:	f74080e7          	jalr	-140(ra) # 80011890 <_ZdlPv>
    80011924:	01813083          	ld	ra,24(sp)
    80011928:	01013403          	ld	s0,16(sp)
    8001192c:	00813483          	ld	s1,8(sp)
    80011930:	02010113          	addi	sp,sp,32
    80011934:	00008067          	ret

0000000080011938 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80011938:	ff010113          	addi	sp,sp,-16
    8001193c:	00113423          	sd	ra,8(sp)
    80011940:	00813023          	sd	s0,0(sp)
    80011944:	01010413          	addi	s0,sp,16
    80011948:	00001797          	auipc	a5,0x1
    8001194c:	89878793          	addi	a5,a5,-1896 # 800121e0 <_ZTV9Semaphore+0x10>
    80011950:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80011954:	00850513          	addi	a0,a0,8
    80011958:	fffff097          	auipc	ra,0xfffff
    8001195c:	8c4080e7          	jalr	-1852(ra) # 8001021c <_Z8sem_openPP10_semaphorej>
}
    80011960:	00813083          	ld	ra,8(sp)
    80011964:	00013403          	ld	s0,0(sp)
    80011968:	01010113          	addi	sp,sp,16
    8001196c:	00008067          	ret

0000000080011970 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80011970:	ff010113          	addi	sp,sp,-16
    80011974:	00113423          	sd	ra,8(sp)
    80011978:	00813023          	sd	s0,0(sp)
    8001197c:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80011980:	00853503          	ld	a0,8(a0)
    80011984:	fffff097          	auipc	ra,0xfffff
    80011988:	8fc080e7          	jalr	-1796(ra) # 80010280 <_Z8sem_waitP10_semaphore>
}
    8001198c:	00813083          	ld	ra,8(sp)
    80011990:	00013403          	ld	s0,0(sp)
    80011994:	01010113          	addi	sp,sp,16
    80011998:	00008067          	ret

000000008001199c <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    8001199c:	ff010113          	addi	sp,sp,-16
    800119a0:	00113423          	sd	ra,8(sp)
    800119a4:	00813023          	sd	s0,0(sp)
    800119a8:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800119ac:	00853503          	ld	a0,8(a0)
    800119b0:	fffff097          	auipc	ra,0xfffff
    800119b4:	8fc080e7          	jalr	-1796(ra) # 800102ac <_Z10sem_signalP10_semaphore>
}
    800119b8:	00813083          	ld	ra,8(sp)
    800119bc:	00013403          	ld	s0,0(sp)
    800119c0:	01010113          	addi	sp,sp,16
    800119c4:	00008067          	ret

00000000800119c8 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    800119c8:	fe010113          	addi	sp,sp,-32
    800119cc:	00113c23          	sd	ra,24(sp)
    800119d0:	00813823          	sd	s0,16(sp)
    800119d4:	00913423          	sd	s1,8(sp)
    800119d8:	02010413          	addi	s0,sp,32
    800119dc:	00050493          	mv	s1,a0
    800119e0:	00001797          	auipc	a5,0x1
    800119e4:	82078793          	addi	a5,a5,-2016 # 80012200 <_ZTV6Thread+0x10>
    800119e8:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    800119ec:	00850513          	addi	a0,a0,8
    800119f0:	ffffe097          	auipc	ra,0xffffe
    800119f4:	760080e7          	jalr	1888(ra) # 80010150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    800119f8:	fff00793          	li	a5,-1
    800119fc:	00f50c63          	beq	a0,a5,80011a14 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    80011a00:	01813083          	ld	ra,24(sp)
    80011a04:	01013403          	ld	s0,16(sp)
    80011a08:	00813483          	ld	s1,8(sp)
    80011a0c:	02010113          	addi	sp,sp,32
    80011a10:	00008067          	ret
        myHandle = nullptr;
    80011a14:	0004b423          	sd	zero,8(s1)
}
    80011a18:	fe9ff06f          	j	80011a00 <_ZN6ThreadC1EPFvPvES0_+0x38>

0000000080011a1c <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80011a1c:	fe010113          	addi	sp,sp,-32
    80011a20:	00113c23          	sd	ra,24(sp)
    80011a24:	00813823          	sd	s0,16(sp)
    80011a28:	00913423          	sd	s1,8(sp)
    80011a2c:	02010413          	addi	s0,sp,32
    80011a30:	00050493          	mv	s1,a0
    80011a34:	00000797          	auipc	a5,0x0
    80011a38:	7cc78793          	addi	a5,a5,1996 # 80012200 <_ZTV6Thread+0x10>
    80011a3c:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    80011a40:	00050613          	mv	a2,a0
    80011a44:	00000597          	auipc	a1,0x0
    80011a48:	d5858593          	addi	a1,a1,-680 # 8001179c <_ZN6Thread7wrapperEPv>
    80011a4c:	00850513          	addi	a0,a0,8
    80011a50:	ffffe097          	auipc	ra,0xffffe
    80011a54:	700080e7          	jalr	1792(ra) # 80010150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80011a58:	fff00793          	li	a5,-1
    80011a5c:	00f50c63          	beq	a0,a5,80011a74 <_ZN6ThreadC1Ev+0x58>
}
    80011a60:	01813083          	ld	ra,24(sp)
    80011a64:	01013403          	ld	s0,16(sp)
    80011a68:	00813483          	ld	s1,8(sp)
    80011a6c:	02010113          	addi	sp,sp,32
    80011a70:	00008067          	ret
        myHandle = nullptr;
    80011a74:	0004b423          	sd	zero,8(s1)
}
    80011a78:	fe9ff06f          	j	80011a60 <_ZN6ThreadC1Ev+0x44>

0000000080011a7c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80011a7c:	ff010113          	addi	sp,sp,-16
    80011a80:	00113423          	sd	ra,8(sp)
    80011a84:	00813023          	sd	s0,0(sp)
    80011a88:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80011a8c:	fffff097          	auipc	ra,0xfffff
    80011a90:	84c080e7          	jalr	-1972(ra) # 800102d8 <_Z10time_sleepm>
}
    80011a94:	00813083          	ld	ra,8(sp)
    80011a98:	00013403          	ld	s0,0(sp)
    80011a9c:	01010113          	addi	sp,sp,16
    80011aa0:	00008067          	ret

0000000080011aa4 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80011aa4:	fe010113          	addi	sp,sp,-32
    80011aa8:	00113c23          	sd	ra,24(sp)
    80011aac:	00813823          	sd	s0,16(sp)
    80011ab0:	00913423          	sd	s1,8(sp)
    80011ab4:	01213023          	sd	s2,0(sp)
    80011ab8:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80011abc:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80011ac0:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80011ac4:	0004b783          	ld	a5,0(s1)
    80011ac8:	0187b783          	ld	a5,24(a5)
    80011acc:	00048513          	mv	a0,s1
    80011ad0:	000780e7          	jalr	a5
        pt->sleep(time);
    80011ad4:	00090513          	mv	a0,s2
    80011ad8:	00000097          	auipc	ra,0x0
    80011adc:	fa4080e7          	jalr	-92(ra) # 80011a7c <_ZN6Thread5sleepEm>
    while(true){
    80011ae0:	fe5ff06f          	j	80011ac4 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080011ae4 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80011ae4:	ff010113          	addi	sp,sp,-16
    80011ae8:	00113423          	sd	ra,8(sp)
    80011aec:	00813023          	sd	s0,0(sp)
    80011af0:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80011af4:	ffffe097          	auipc	ra,0xffffe
    80011af8:	63c080e7          	jalr	1596(ra) # 80010130 <_Z15thread_dispatchv>
}
    80011afc:	00813083          	ld	ra,8(sp)
    80011b00:	00013403          	ld	s0,0(sp)
    80011b04:	01010113          	addi	sp,sp,16
    80011b08:	00008067          	ret

0000000080011b0c <_ZN6Thread5startEv>:
int Thread::start() {
    80011b0c:	ff010113          	addi	sp,sp,-16
    80011b10:	00113423          	sd	ra,8(sp)
    80011b14:	00813023          	sd	s0,0(sp)
    80011b18:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80011b1c:	00853503          	ld	a0,8(a0)
    80011b20:	ffffe097          	auipc	ra,0xffffe
    80011b24:	6c4080e7          	jalr	1732(ra) # 800101e4 <_Z12thread_startP7_thread>
}
    80011b28:	00813083          	ld	ra,8(sp)
    80011b2c:	00013403          	ld	s0,0(sp)
    80011b30:	01010113          	addi	sp,sp,16
    80011b34:	00008067          	ret

0000000080011b38 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80011b38:	fe010113          	addi	sp,sp,-32
    80011b3c:	00113c23          	sd	ra,24(sp)
    80011b40:	00813823          	sd	s0,16(sp)
    80011b44:	00913423          	sd	s1,8(sp)
    80011b48:	01213023          	sd	s2,0(sp)
    80011b4c:	02010413          	addi	s0,sp,32
    80011b50:	00050493          	mv	s1,a0
    80011b54:	00058913          	mv	s2,a1
    80011b58:	01000513          	li	a0,16
    80011b5c:	00000097          	auipc	ra,0x0
    80011b60:	ce4080e7          	jalr	-796(ra) # 80011840 <_Znwm>
    80011b64:	00050613          	mv	a2,a0
    80011b68:	00050663          	beqz	a0,80011b74 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    80011b6c:	00953023          	sd	s1,0(a0)
    80011b70:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80011b74:	00000597          	auipc	a1,0x0
    80011b78:	f3058593          	addi	a1,a1,-208 # 80011aa4 <_ZN14PeriodicThread7wrapperEPv>
    80011b7c:	00048513          	mv	a0,s1
    80011b80:	00000097          	auipc	ra,0x0
    80011b84:	e48080e7          	jalr	-440(ra) # 800119c8 <_ZN6ThreadC1EPFvPvES0_>
    80011b88:	00000797          	auipc	a5,0x0
    80011b8c:	62878793          	addi	a5,a5,1576 # 800121b0 <_ZTV14PeriodicThread+0x10>
    80011b90:	00f4b023          	sd	a5,0(s1)
    80011b94:	01813083          	ld	ra,24(sp)
    80011b98:	01013403          	ld	s0,16(sp)
    80011b9c:	00813483          	ld	s1,8(sp)
    80011ba0:	00013903          	ld	s2,0(sp)
    80011ba4:	02010113          	addi	sp,sp,32
    80011ba8:	00008067          	ret

0000000080011bac <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80011bac:	ff010113          	addi	sp,sp,-16
    80011bb0:	00113423          	sd	ra,8(sp)
    80011bb4:	00813023          	sd	s0,0(sp)
    80011bb8:	01010413          	addi	s0,sp,16
    return ::getc();
    80011bbc:	ffffe097          	auipc	ra,0xffffe
    80011bc0:	748080e7          	jalr	1864(ra) # 80010304 <_Z4getcv>
}
    80011bc4:	00813083          	ld	ra,8(sp)
    80011bc8:	00013403          	ld	s0,0(sp)
    80011bcc:	01010113          	addi	sp,sp,16
    80011bd0:	00008067          	ret

0000000080011bd4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80011bd4:	ff010113          	addi	sp,sp,-16
    80011bd8:	00113423          	sd	ra,8(sp)
    80011bdc:	00813023          	sd	s0,0(sp)
    80011be0:	01010413          	addi	s0,sp,16
    ::putc(c);
    80011be4:	ffffe097          	auipc	ra,0xffffe
    80011be8:	748080e7          	jalr	1864(ra) # 8001032c <_Z4putcc>
}
    80011bec:	00813083          	ld	ra,8(sp)
    80011bf0:	00013403          	ld	s0,0(sp)
    80011bf4:	01010113          	addi	sp,sp,16
    80011bf8:	00008067          	ret

0000000080011bfc <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80011bfc:	ff010113          	addi	sp,sp,-16
    80011c00:	00813423          	sd	s0,8(sp)
    80011c04:	01010413          	addi	s0,sp,16
    80011c08:	00813403          	ld	s0,8(sp)
    80011c0c:	01010113          	addi	sp,sp,16
    80011c10:	00008067          	ret

0000000080011c14 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80011c14:	ff010113          	addi	sp,sp,-16
    80011c18:	00813423          	sd	s0,8(sp)
    80011c1c:	01010413          	addi	s0,sp,16
    80011c20:	00813403          	ld	s0,8(sp)
    80011c24:	01010113          	addi	sp,sp,16
    80011c28:	00008067          	ret

0000000080011c2c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80011c2c:	ff010113          	addi	sp,sp,-16
    80011c30:	00113423          	sd	ra,8(sp)
    80011c34:	00813023          	sd	s0,0(sp)
    80011c38:	01010413          	addi	s0,sp,16
    80011c3c:	00000797          	auipc	a5,0x0
    80011c40:	57478793          	addi	a5,a5,1396 # 800121b0 <_ZTV14PeriodicThread+0x10>
    80011c44:	00f53023          	sd	a5,0(a0)
    80011c48:	00000097          	auipc	ra,0x0
    80011c4c:	bb8080e7          	jalr	-1096(ra) # 80011800 <_ZN6ThreadD1Ev>
    80011c50:	00813083          	ld	ra,8(sp)
    80011c54:	00013403          	ld	s0,0(sp)
    80011c58:	01010113          	addi	sp,sp,16
    80011c5c:	00008067          	ret

0000000080011c60 <_ZN14PeriodicThreadD0Ev>:
    80011c60:	fe010113          	addi	sp,sp,-32
    80011c64:	00113c23          	sd	ra,24(sp)
    80011c68:	00813823          	sd	s0,16(sp)
    80011c6c:	00913423          	sd	s1,8(sp)
    80011c70:	02010413          	addi	s0,sp,32
    80011c74:	00050493          	mv	s1,a0
    80011c78:	00000797          	auipc	a5,0x0
    80011c7c:	53878793          	addi	a5,a5,1336 # 800121b0 <_ZTV14PeriodicThread+0x10>
    80011c80:	00f53023          	sd	a5,0(a0)
    80011c84:	00000097          	auipc	ra,0x0
    80011c88:	b7c080e7          	jalr	-1156(ra) # 80011800 <_ZN6ThreadD1Ev>
    80011c8c:	00048513          	mv	a0,s1
    80011c90:	00000097          	auipc	ra,0x0
    80011c94:	c00080e7          	jalr	-1024(ra) # 80011890 <_ZdlPv>
    80011c98:	01813083          	ld	ra,24(sp)
    80011c9c:	01013403          	ld	s0,16(sp)
    80011ca0:	00813483          	ld	s1,8(sp)
    80011ca4:	02010113          	addi	sp,sp,32
    80011ca8:	00008067          	ret
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
    80012020:	000a                	c.slli	zero,0x2
    80012022:	0000                	unimp
    80012024:	0000                	unimp
    80012026:	0000                	unimp
    80012028:	2041                	0x2041
    8001202a:	6966                	ld	s2,88(sp)
    8001202c:	696e                	ld	s2,216(sp)
    8001202e:	64656873          	csrrsi	a6,0x646,10
    80012032:	0a21                	addi	s4,s4,8
    80012034:	0000                	unimp
    80012036:	0000                	unimp
    80012038:	3a42                	fld	fs4,48(sp)
    8001203a:	6920                	ld	s0,80(a0)
    8001203c:	003d                	c.nop	15
    8001203e:	0000                	unimp
    80012040:	2042                	fld	ft0,16(sp)
    80012042:	6966                	ld	s2,88(sp)
    80012044:	696e                	ld	s2,216(sp)
    80012046:	64656873          	csrrsi	a6,0x646,10
    8001204a:	0a21                	addi	s4,s4,8
    8001204c:	0000                	unimp
    8001204e:	0000                	unimp
    80012050:	69203a43          	fmadd.s	fs4,ft0,fs2,fa3,rup
    80012054:	003d                	c.nop	15
    80012056:	0000                	unimp
    80012058:	64203a43          	0x64203a43
    8001205c:	7369                	lui	t1,0xffffa
    8001205e:	6170                	ld	a2,192(a0)
    80012060:	6374                	ld	a3,192(a4)
    80012062:	0a68                	addi	a0,sp,284
    80012064:	0000                	unimp
    80012066:	0000                	unimp
    80012068:	74203a43          	0x74203a43
    8001206c:	3d31                	addiw	s10,s10,-20
    8001206e:	0000                	unimp
    80012070:	66203a43          	fmadd.q	fs4,ft0,ft2,fa2,rup
    80012074:	6269                	lui	tp,0x1a
    80012076:	63616e6f          	jal	t3,800286ac <end+0x156ac>
    8001207a:	3d69                	addiw	s10,s10,-6
    8001207c:	0000                	unimp
    8001207e:	0000                	unimp
    80012080:	3a44                	fld	fs1,176(a2)
    80012082:	6920                	ld	s0,80(a0)
    80012084:	003d                	c.nop	15
    80012086:	0000                	unimp
    80012088:	3a44                	fld	fs1,176(a2)
    8001208a:	6420                	ld	s0,72(s0)
    8001208c:	7369                	lui	t1,0xffffa
    8001208e:	6170                	ld	a2,192(a0)
    80012090:	6374                	ld	a3,192(a4)
    80012092:	0a68                	addi	a0,sp,284
    80012094:	0000                	unimp
    80012096:	0000                	unimp
    80012098:	3a44                	fld	fs1,176(a2)
    8001209a:	6620                	ld	s0,72(a2)
    8001209c:	6269                	lui	tp,0x1a
    8001209e:	63616e6f          	jal	t3,800286d4 <end+0x156d4>
    800120a2:	3d69                	addiw	s10,s10,-6
    800120a4:	0000                	unimp
    800120a6:	0000                	unimp
    800120a8:	2044                	fld	fs1,128(s0)
    800120aa:	6966                	ld	s2,88(sp)
    800120ac:	696e                	ld	s2,216(sp)
    800120ae:	64656873          	csrrsi	a6,0x646,10
    800120b2:	0a21                	addi	s4,s4,8
    800120b4:	0000                	unimp
    800120b6:	0000                	unimp
    800120b8:	6854                	ld	a3,144(s0)
    800120ba:	6572                	ld	a0,280(sp)
    800120bc:	6461                	lui	s0,0x18
    800120be:	2041                	0x2041
    800120c0:	61657263          	bgeu	a0,s6,800126c4 <lockPrint+0x4a4>
    800120c4:	6574                	ld	a3,200(a0)
    800120c6:	0a64                	addi	s1,sp,284
	...
    800120d0:	6854                	ld	a3,144(s0)
    800120d2:	6572                	ld	a0,280(sp)
    800120d4:	6461                	lui	s0,0x18
    800120d6:	2042                	fld	ft0,16(sp)
    800120d8:	61657263          	bgeu	a0,s6,800126dc <lockPrint+0x4bc>
    800120dc:	6574                	ld	a3,200(a0)
    800120de:	0a64                	addi	s1,sp,284
	...
    800120e8:	6854                	ld	a3,144(s0)
    800120ea:	6572                	ld	a0,280(sp)
    800120ec:	6461                	lui	s0,0x18
    800120ee:	72632043          	fmadd.d	ft0,ft6,ft6,fa4,rdn
    800120f2:	6165                	addi	sp,sp,112
    800120f4:	6574                	ld	a3,200(a0)
    800120f6:	0a64                	addi	s1,sp,284
	...
    80012100:	6854                	ld	a3,144(s0)
    80012102:	6572                	ld	a0,280(sp)
    80012104:	6461                	lui	s0,0x18
    80012106:	2044                	fld	fs1,128(s0)
    80012108:	61657263          	bgeu	a0,s6,8001270c <lockPrint+0x4ec>
    8001210c:	6574                	ld	a3,200(a0)
    8001210e:	0a64                	addi	s1,sp,284
	...
    80012118:	7355                	lui	t1,0xffff5
    8001211a:	7265                	lui	tp,0xffff9
    8001211c:	6d20                	ld	s0,88(a0)
    8001211e:	6961                	lui	s2,0x18
    80012120:	206e                	fld	ft0,216(sp)
    80012122:	6966                	ld	s2,88(sp)
    80012124:	696e                	ld	s2,216(sp)
    80012126:	64656873          	csrrsi	a6,0x646,10
    8001212a:	000a                	c.slli	zero,0x2
    8001212c:	0000                	unimp
    8001212e:	0000                	unimp
    80012130:	72617453          	0x72617453
    80012134:	6574                	ld	a3,200(a0)
    80012136:	2064                	fld	fs1,192(s0)
    80012138:	6874                	ld	a3,208(s0)
    8001213a:	6572                	ld	a0,280(sp)
    8001213c:	6461                	lui	s0,0x18
    8001213e:	6920                	ld	s0,80(a0)
    80012140:	3a64                	fld	fs1,240(a2)
    80012142:	0020                	addi	s0,sp,8
    80012144:	0000                	unimp
    80012146:	0000                	unimp
    80012148:	6946                	ld	s2,80(sp)
    8001214a:	696e                	ld	s2,216(sp)
    8001214c:	64656873          	csrrsi	a6,0x646,10
    80012150:	7420                	ld	s0,104(s0)
    80012152:	7268                	ld	a0,224(a2)
    80012154:	6165                	addi	sp,sp,112
    80012156:	2064                	fld	fs1,192(s0)
    80012158:	6469                	lui	s0,0x1a
    8001215a:	203a                	fld	ft0,392(sp)
    8001215c:	0000                	unimp
	...

0000000080012160 <_ZTV10ForkThread>:
	...
    80012170:	10f4 8001 0000 0000 1128 8001 0000 0000     ........(.......
    80012180:	0ed4 8001 0000 0000                         ........

0000000080012188 <digits>:
    80012188:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...

00000000800121a0 <_ZTV14PeriodicThread>:
	...
    800121b0:	1c2c 8001 0000 0000 1c60 8001 0000 0000     ,.......`.......
    800121c0:	1bfc 8001 0000 0000 1c14 8001 0000 0000     ................

00000000800121d0 <_ZTV9Semaphore>:
	...
    800121e0:	17c8 8001 0000 0000 18b8 8001 0000 0000     ................

00000000800121f0 <_ZTV6Thread>:
	...
    80012200:	1800 8001 0000 0000 18f8 8001 0000 0000     ................
    80012210:	1bfc 8001 0000 0000                         ........

0000000080012218 <finishedA>:
	...

0000000080012219 <finishedB>:
	...

000000008001221a <finishedC>:
	...

000000008001221b <finishedD>:
    8001221b:	0000 0000                                    .....

0000000080012220 <lockPrint>:
	...
    80012228:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    80012238:	0d1b 0002 0020 0000 0018 0000 dddc ffff     .... ...........
    80012248:	0030 0000 4400 100e 8844 4402 000c 0000     0....D..D..D....
    80012258:	0c00 1002 0e44 0000 0020 0000 003c 0000     ....D... ...<...
    80012268:	dde8 ffff 002c 0000 4400 100e 8844 4402     ....,....D..D..D
    80012278:	000c 0000 0c00 1002 0e44 0000 0034 0000     ........D...4...
    80012288:	0060 0000 ddf0 ffff 008c 0000 4400 000e     `............D..
	...
    800122a0:	9300 440a 080c 0000 0000 0000 0c00 3002     ...D...........0
    800122b0:	c944 d244 d344 0e44 4400 000b 0020 0000     D.D.D.D..D.. ...
    800122c0:	0098 0000 de44 ffff 0028 0000 4400 100e     ....D...(....D..
    800122d0:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    800122e0:	0020 0000 00bc 0000 de48 ffff 0020 0000      .......H... ...
    800122f0:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012300:	0e44 0000 0034 0000 00e0 0000 de44 ffff     D...4.......D...
    80012310:	0094 0000 4400 000e 0000 0000 0000 0000     .....D..........
    80012320:	9300 440a 080c 0000 0000 0000 0c00 3002     ...D...........0
    80012330:	c944 d244 d344 0e44 4400 000b 0024 0000     D.D.D.D..D..$...
    80012340:	0118 0000 dea0 ffff 0038 0000 4400 100e     ........8....D..
    80012350:	8844 4402 000c 0000 0000 020c 4410 000e     D..D.........D..
    80012360:	0b44 0000 0020 0000 0140 0000 deb0 ffff     D... ...@.......
    80012370:	0038 0000 4400 100e 8844 4402 000c 0000     8....D..D..D....
    80012380:	0c00 1002 0e44 0000 0020 0000 0164 0000     ....D... ...d...
    80012390:	dec4 ffff 002c 0000 4400 100e 8844 4402     ....,....D..D..D
    800123a0:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    800123b0:	0188 0000 decc ffff 002c 0000 4400 100e     ........,....D..
    800123c0:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    800123d0:	0020 0000 01ac 0000 ded4 ffff 002c 0000      ...........,...
    800123e0:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    800123f0:	0e44 0000 0020 0000 01d0 0000 dedc ffff     D... ...........
    80012400:	002c 0000 4400 100e 8844 4402 000c 0000     ,....D..D..D....
    80012410:	0c00 1002 0e44 0000 0020 0000 01f4 0000     ....D... .......
    80012420:	dee4 ffff 0028 0000 4400 100e 8844 4402     ....(....D..D..D
    80012430:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    80012440:	0218 0000 dee8 ffff 0024 0000 4400 100e     ........$....D..
    80012450:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012460:	0020 0000 023c 0000 dee8 ffff 0028 0000      ...<.......(...
    80012470:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012480:	0e44 0000 0020 0000 0260 0000 deec ffff     D... ...`.......
    80012490:	0024 0000 4400 100e 8844 4402 000c 0000     $....D..D..D....
    800124a0:	0c00 1002 0e44 0000 0010 0000 0000 0000     ....D...........
    800124b0:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    800124c0:	0018 0000 ded8 ffff 0028 0000 4400 000e     ........(....D..
    800124d0:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    800124e0:	0e44 0000 0000 0000 0010 0000 0000 0000     D...............
    800124f0:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    80012500:	0018 0000 dec0 ffff 0028 0000 4400 000e     ........(....D..
    80012510:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012520:	0e44 0000 0000 0000 0018 0000 0000 0000     D...............
    80012530:	7a03 4c50 0052 7c01 0701 0d9b ff65 1bff     .zPLR..|....e...
    80012540:	0d1b 0002 0038 0000 0020 0000 dea0 ffff     ....8... .......
    80012550:	0164 0000 4204 ff63 44ff 000e 0000 0000     d....Bc..D......
    80012560:	0000 0000 9300 440a 080c 0000 0000 0000     .......D........
    80012570:	0c00 3002 c944 d244 d344 0e44 4400 000b     ...0D.D.D.D..D..
    80012580:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    80012590:	0d1b 0002 002c 0000 0018 0000 dfb4 ffff     ....,...........
    800125a0:	0090 0000 4400 000e 0000 0000 0000 9200     .....D..........
    800125b0:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    800125c0:	44d2 000e 002c 0000 0048 0000 e014 ffff     .D..,...H.......
    800125d0:	008c 0000 4400 000e 0000 0000 0000 9200     .....D..........
    800125e0:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    800125f0:	44d2 000e 0030 0000 0078 0000 e070 ffff     .D..0...x...p...
    80012600:	0088 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012610:	4408 080c 0000 0000 0000 0c00 2002 c944     .D........... D.
    80012620:	d244 0e44 4400 000b 002c 0000 0104 0000     D.D..D..,.......
    80012630:	e0c4 ffff 0100 0000 ff04 ff62 44ff 000e     ..........b..D..
    80012640:	0000 0000 8900 4406 080c 0200 0000 0000     .......D........
    80012650:	020c 4420 44c9 000e 0010 0000 0000 0000     .. D.D..........
    80012660:	7a03 0052 7c01 0101 0d1b 0002 002c 0000     .zR..|......,...
    80012670:	0018 0000 e180 ffff 00cc 0000 4400 000e     .............D..
    80012680:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    80012690:	0000 020c 4420 44c9 44d2 000e 002c 0000     .... D.D.D..,...
    800126a0:	0048 0000 e21c ffff 00d4 0000 4400 000e     H............D..
    800126b0:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    800126c0:	0000 020c 4420 44c9 44d2 000e 0018 0000     .... D.D.D......
    800126d0:	0000 0000 7a03 4c50 0052 7c01 0701 699b     .....zPLR..|...i
    800126e0:	ff63 1bff 0d1b 0002 0044 0000 0020 0000     c.......D... ...
    800126f0:	e7e4 ffff 0220 0000 6d04 ff62 44ff 000e     .... ....mb..D..
	...
    8001270c:	0000 9600 4410 080c 0300 00d4 0000 0c00     .....D..........
    8001271c:	4002 c944 d244 d344 d444 d544 d644 0e44     .@D.D.D.D.D.D.D.
    8001272c:	0000 0000 0024 0000 00dc 0000 e9bc ffff     ....$...........
    8001273c:	0034 0000 4400 000e 0000 8800 4404 080c     4....D.......D..
    8001274c:	0000 0000 0c00 1002 0e44 0000 0028 0000     ........D...(...
    8001275c:	0104 0000 e9c8 ffff 004c 0000 4400 000e     ........L....D..
    8001276c:	0000 0000 8900 4406 080c 0000 0000 0c00     .......D........
    8001277c:	2002 c944 0e44 0000 0030 0000 0130 0000     . D.D...0...0...
    8001278c:	e208 ffff 0074 0000 4400 000e 0000 0000     ....t....D......
    8001279c:	0000 9200 4408 000c 0000 0000 0000 020c     .....D..........
    800127ac:	4420 44c9 44d2 000e 0b44 0000 0030 0000      D.D.D..D...0...
    800127bc:	0164 0000 e248 ffff 0180 0000 4400 000e     d...H........D..
    800127cc:	0000 0000 0000 9200 4408 080c 0300 0054     .........D....T.
    800127dc:	0000 0c00 2002 c944 d244 0e44 0000 0000     ..... D.D.D.....
    800127ec:	0030 0000 0198 0000 e394 ffff 0148 0000     0...........H...
    800127fc:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    8001280c:	0300 001c 0000 0c00 2002 c944 d244 0e44     ......... D.D.D.
    8001281c:	0000 0000 002c 0000 01cc 0000 e4a8 ffff     ....,...........
    8001282c:	012c 0000 4400 000e 0000 0000 8900 4406     ,....D.........D
    8001283c:	080c 0300 0008 0000 0c00 4002 c944 0e44     ...........@D.D.
    8001284c:	0000 0000 0030 0000 0188 0000 e5a4 ffff     ....0...........
    8001285c:	00c0 0000 db04 ff60 44ff 000e 0000 0000     ......`..D......
    8001286c:	8900 4406 080c 0000 0000 0000 0c00 4002     ...D...........@
    8001287c:	c944 0e44 4400 000b 0020 0000 0230 0000     D.D..D.. ...0...
    8001288c:	e630 ffff 0018 0000 4400 100e 8844 4402     0........D..D..D
    8001289c:	000c 0000 0c00 1002 0e44 0000 0010 0000     ........D.......
    800128ac:	0000 0000 7a03 0052 7c01 0101 0d1b 0002     .....zR..|......
    800128bc:	002c 0000 0018 0000 e8b0 ffff 009c 0000     ,...............
    800128cc:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    800128dc:	0200 0000 0000 020c 4420 44c9 44d2 000e     ........ D.D.D..
    800128ec:	002c 0000 0048 0000 e91c ffff 0090 0000     ,...H...........
    800128fc:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    8001290c:	0200 0000 0000 020c 4420 44c9 44d2 000e     ........ D.D.D..
    8001291c:	002c 0000 0078 0000 e97c ffff 008c 0000     ,...x...|.......
    8001292c:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    8001293c:	0200 0000 0000 020c 4420 44c9 44d2 000e     ........ D.D.D..
    8001294c:	0030 0000 00a8 0000 e9d8 ffff 0088 0000     0...............
    8001295c:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    8001296c:	0000 0000 0000 0c00 2002 c944 d244 0e44     ......... D.D.D.
    8001297c:	4400 000b 0018 0000 0000 0000 7a03 4c50     .D...........zPL
    8001298c:	0052 7c01 0701 b59b ff60 1bff 0d1b 0002     R..|....`.......
    8001299c:	0030 0000 0020 0000 ea10 ffff 00e0 0000     0... ...........
    800129ac:	ad04 ff5f 44ff 000e 0000 0000 8900 4406     .._..D.........D
    800129bc:	080c 0200 0000 0000 020c 4420 44c9 000e     .......... D.D..
    800129cc:	0000 0000 0010 0000 0000 0000 7a03 0052     .............zR.
    800129dc:	7c01 0101 0d1b 0002 0028 0000 0018 0000     .|......(.......
    800129ec:	eaa8 ffff 007c 0000 4400 000e 0000 0000     ....|....D......
    800129fc:	8900 4406 080c 0200 0000 0000 020c 4420     ...D.......... D
    80012a0c:	44c9 000e 0034 0000 0044 0000 eaf8 ffff     .D..4...D.......
    80012a1c:	00cc 0000 4400 000e 0000 0000 0000 0000     .....D..........
    80012a2c:	0000 9400 440c 080c 0200 0000 0000 020c     .....D..........
    80012a3c:	4430 44c9 44d2 44d3 44d4 000e 0020 0000     0D.D.D.D.D.. ...
    80012a4c:	007c 0000 eb8c ffff 0050 0000 4400 100e     |.......P....D..
    80012a5c:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012a6c:	0030 0000 00a0 0000 ebb8 ffff 0114 0000     0...............
    80012a7c:	4400 000e 0000 0000 0000 0000 9300 440a     .D.............D
    80012a8c:	080c 0200 0000 0000 020c 4440 44c9 44d2     ..........@D.D.D
    80012a9c:	44d3 000e 0010 0000 0000 0000 7a03 0052     .D...........zR.
    80012aac:	7c01 0101 0d1b 0002 0024 0000 0018 0000     .|......$.......
    80012abc:	ec84 ffff 0034 0000 4400 000e 0000 8800     ....4....D......
    80012acc:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012adc:	0028 0000 0040 0000 ec90 ffff 0028 0000     (...@.......(...
    80012aec:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012afc:	0c00 1002 0e44 0000 0000 0000 0010 0000     ....D...........
    80012b0c:	0000 0000 7a03 0052 7c01 0101 0d1b 0002     .....zR..|......
    80012b1c:	0020 0000 0018 0000 f0d8 ffff 0018 0000      ...............
    80012b2c:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012b3c:	0e44 0000 0020 0000 003c 0000 f0cc ffff     D... ...<.......
    80012b4c:	0018 0000 4400 100e 8844 4402 000c 0000     .....D..D..D....
    80012b5c:	0c00 1002 0e44 0000 0024 0000 0060 0000     ....D...$...`...
    80012b6c:	ec30 ffff 002c 0000 4400 000e 0000 8800     0...,....D......
    80012b7c:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012b8c:	0018 0000 0000 0000 7a03 4c50 0052 7c01     .........zPLR..|
    80012b9c:	0701 a99b ff5e 1bff 0d1b 0002 0028 0000     ....^.......(...
    80012bac:	0020 0000 ec18 ffff 0038 0000 a504 ff5d      .......8.....].
    80012bbc:	44ff 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012bcc:	0c00 1002 0e44 0000 0028 0000 004c 0000     ....D...(...L...
    80012bdc:	ec24 ffff 0040 0000 7d04 ff5d 58ff 000e     $...@....}]..X..
    80012bec:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012bfc:	0e44 0000 0024 0000 00fc 0000 f024 ffff     D...$.......$...
    80012c0c:	0034 0000 4400 000e 0000 8800 4404 080c     4....D.......D..
    80012c1c:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    80012c2c:	0124 0000 ec10 ffff 0028 0000 4400 000e     $.......(....D..
    80012c3c:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012c4c:	0e44 0000 0024 0000 014c 0000 ec10 ffff     D...$...L.......
    80012c5c:	0028 0000 4400 000e 0000 8800 4404 080c     (....D.......D..
    80012c6c:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    80012c7c:	0174 0000 ec10 ffff 0028 0000 4400 000e     t.......(....D..
    80012c8c:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012c9c:	0e44 0000 0028 0000 019c 0000 ec10 ffff     D...(...........
    80012cac:	0040 0000 4400 000e 0000 0000 8900 4406     @....D.........D
    80012cbc:	080c 0000 0000 0c00 2002 c944 0e44 0000     ......... D.D...
    80012ccc:	0028 0000 01c8 0000 ec24 ffff 0040 0000     (.......$...@...
    80012cdc:	4400 000e 0000 0000 8900 4406 080c 0000     .D.........D....
    80012cec:	0000 0c00 2002 c944 0e44 0000 0028 0000     ..... D.D...(...
    80012cfc:	01f4 0000 ef60 ffff 004c 0000 4400 000e     ....`...L....D..
    80012d0c:	0000 0000 8900 4406 080c 0000 0000 0c00     .......D........
    80012d1c:	2002 c944 0e44 0000 0024 0000 0220 0000     . D.D...$... ...
    80012d2c:	ec0c ffff 0038 0000 4400 000e 0000 8800     ....8....D......
    80012d3c:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012d4c:	0024 0000 0248 0000 ec1c ffff 002c 0000     $...H.......,...
    80012d5c:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012d6c:	0c00 1002 0e44 0000 0024 0000 0270 0000     ....D...$...p...
    80012d7c:	ec20 ffff 002c 0000 4400 000e 0000 8800      ...,....D......
    80012d8c:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012d9c:	002c 0000 0298 0000 ec24 ffff 0054 0000     ,.......$...T...
    80012dac:	4400 000e 0000 0000 8900 4406 000c 0000     .D.........D....
    80012dbc:	0000 0000 020c 4420 44c9 000e 0b44 0000     ...... D.D..D...
    80012dcc:	002c 0000 02c8 0000 ec48 ffff 0060 0000     ,.......H...`...
    80012ddc:	4400 000e 0000 0000 8900 4406 000c 0000     .D.........D....
    80012dec:	0000 0000 020c 4420 44c9 000e 0b44 0000     ...... D.D..D...
    80012dfc:	0024 0000 02f8 0000 ec78 ffff 0028 0000     $.......x...(...
    80012e0c:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012e1c:	0c00 1002 0e44 0000 0020 0000 0320 0000     ....D... ... ...
    80012e2c:	ec78 ffff 0040 0000 4400 000e 0000 0000     x...@....D......
    80012e3c:	0000 9200 4408 080c 0000 0000 0024 0000     .....D......$...
    80012e4c:	0344 0000 ec94 ffff 0028 0000 4400 000e     D.......(....D..
    80012e5c:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012e6c:	0e44 0000 0024 0000 036c 0000 ec94 ffff     D...$...l.......
    80012e7c:	002c 0000 4400 000e 0000 8800 4404 080c     ,....D.......D..
    80012e8c:	0000 0000 0c00 1002 0e44 0000 002c 0000     ........D...,...
    80012e9c:	0394 0000 ec98 ffff 0074 0000 4400 000e     ........t....D..
    80012eac:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    80012ebc:	0000 020c 4420 44c9 44d2 000e 0024 0000     .... D.D.D..$...
    80012ecc:	03c4 0000 ecdc ffff 0028 0000 4400 000e     ........(....D..
    80012edc:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012eec:	0e44 0000 0024 0000 03ec 0000 ecdc ffff     D...$...........
    80012efc:	0028 0000 4400 000e 0000 8800 4404 080c     (....D.......D..
    80012f0c:	0000 0000 0c00 1002 0e44 0000 0000 0000     ........D.......
	...
