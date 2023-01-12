
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	f5813103          	ld	sp,-168(sp) # 8000af58 <_GLOBAL_OFFSET_TABLE_+0x70>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	410050ef          	jal	ra,8000542c <start>

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
    80001088:	7e1020ef          	jal	ra,80004068 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001164:	740080e7          	jalr	1856(ra) # 800028a0 <_ZN5Buddy4freeEPvm>
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
    800011c4:	1f060613          	addi	a2,a2,496 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800011c8:	0005059b          	sext.w	a1,a0
    800011cc:	00007517          	auipc	a0,0x7
    800011d0:	e5450513          	addi	a0,a0,-428 # 80008020 <CONSOLE_STATUS+0x10>
    800011d4:	00004097          	auipc	ra,0x4
    800011d8:	054080e7          	jalr	84(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n",10);
    800011dc:	00a00693          	li	a3,10
    800011e0:	00007617          	auipc	a2,0x7
    800011e4:	1d060613          	addi	a2,a2,464 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800011e8:	01892583          	lw	a1,24(s2)
    800011ec:	00007517          	auipc	a0,0x7
    800011f0:	e4450513          	addi	a0,a0,-444 # 80008030 <CONSOLE_STATUS+0x20>
    800011f4:	00004097          	auipc	ra,0x4
    800011f8:	034080e7          	jalr	52(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n",10);
    800011fc:	00a00693          	li	a3,10
    80001200:	00007617          	auipc	a2,0x7
    80001204:	1b060613          	addi	a2,a2,432 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80001208:	01092583          	lw	a1,16(s2)
    8000120c:	00007517          	auipc	a0,0x7
    80001210:	e3c50513          	addi	a0,a0,-452 # 80008048 <CONSOLE_STATUS+0x38>
    80001214:	00004097          	auipc	ra,0x4
    80001218:	014080e7          	jalr	20(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n",10);
    8000121c:	00a00693          	li	a3,10
    80001220:	00007617          	auipc	a2,0x7
    80001224:	19060613          	addi	a2,a2,400 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80001228:	43000593          	li	a1,1072
    8000122c:	00007517          	auipc	a0,0x7
    80001230:	e3450513          	addi	a0,a0,-460 # 80008060 <CONSOLE_STATUS+0x50>
    80001234:	00004097          	auipc	ra,0x4
    80001238:	ff4080e7          	jalr	-12(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000123c:	01000693          	li	a3,16
    80001240:	00007617          	auipc	a2,0x7
    80001244:	17060613          	addi	a2,a2,368 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80001248:	42092583          	lw	a1,1056(s2)
    8000124c:	00007517          	auipc	a0,0x7
    80001250:	e2c50513          	addi	a0,a0,-468 # 80008078 <CONSOLE_STATUS+0x68>
    80001254:	00004097          	auipc	ra,0x4
    80001258:	fd4080e7          	jalr	-44(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) (&slab->allocated), "\n");
    8000125c:	01000693          	li	a3,16
    80001260:	00007617          	auipc	a2,0x7
    80001264:	15060613          	addi	a2,a2,336 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80001268:	0209059b          	addiw	a1,s2,32
    8000126c:	00007517          	auipc	a0,0x7
    80001270:	e1c50513          	addi	a0,a0,-484 # 80008088 <CONSOLE_STATUS+0x78>
    80001274:	00004097          	auipc	ra,0x4
    80001278:	fb4080e7          	jalr	-76(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000127c:	00007517          	auipc	a0,0x7
    80001280:	e2c50513          	addi	a0,a0,-468 # 800080a8 <CONSOLE_STATUS+0x98>
    80001284:	00004097          	auipc	ra,0x4
    80001288:	e84080e7          	jalr	-380(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
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
    800012ac:	14850513          	addi	a0,a0,328 # 800083f0 <CONSOLE_STATUS+0x3e0>
    800012b0:	00004097          	auipc	ra,0x4
    800012b4:	f78080e7          	jalr	-136(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012b8:	00148493          	addi	s1,s1,1
    800012bc:	01893783          	ld	a5,24(s2)
    800012c0:	0037d793          	srli	a5,a5,0x3
    800012c4:	00178793          	addi	a5,a5,1
    800012c8:	fcf4e6e3          	bltu	s1,a5,80001294 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    800012cc:	00007517          	auipc	a0,0x7
    800012d0:	0e450513          	addi	a0,a0,228 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800012d4:	00004097          	auipc	ra,0x4
    800012d8:	e34080e7          	jalr	-460(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
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
    80001320:	dec080e7          	jalr	-532(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001324:	00090513          	mv	a0,s2
    80001328:	00004097          	auipc	ra,0x4
    8000132c:	de0080e7          	jalr	-544(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001330:	00007517          	auipc	a0,0x7
    80001334:	08050513          	addi	a0,a0,128 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80001338:	00004097          	auipc	ra,0x4
    8000133c:	dd0080e7          	jalr	-560(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80001340:	01000693          	li	a3,16
    80001344:	00007617          	auipc	a2,0x7
    80001348:	06c60613          	addi	a2,a2,108 # 800083b0 <CONSOLE_STATUS+0x3a0>
    8000134c:	0009059b          	sext.w	a1,s2
    80001350:	00007517          	auipc	a0,0x7
    80001354:	d8850513          	addi	a0,a0,-632 # 800080d8 <CONSOLE_STATUS+0xc8>
    80001358:	00004097          	auipc	ra,0x4
    8000135c:	ed0080e7          	jalr	-304(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n",10);
    80001360:	00a00693          	li	a3,10
    80001364:	00007617          	auipc	a2,0x7
    80001368:	04c60613          	addi	a2,a2,76 # 800083b0 <CONSOLE_STATUS+0x3a0>
    8000136c:	04892583          	lw	a1,72(s2)
    80001370:	00007517          	auipc	a0,0x7
    80001374:	d7850513          	addi	a0,a0,-648 # 800080e8 <CONSOLE_STATUS+0xd8>
    80001378:	00004097          	auipc	ra,0x4
    8000137c:	eb0080e7          	jalr	-336(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n",10);
    80001380:	00a00693          	li	a3,10
    80001384:	00007617          	auipc	a2,0x7
    80001388:	02c60613          	addi	a2,a2,44 # 800083b0 <CONSOLE_STATUS+0x3a0>
    8000138c:	04092583          	lw	a1,64(s2)
    80001390:	00007517          	auipc	a0,0x7
    80001394:	d7050513          	addi	a0,a0,-656 # 80008100 <CONSOLE_STATUS+0xf0>
    80001398:	00004097          	auipc	ra,0x4
    8000139c:	e90080e7          	jalr	-368(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013a0:	01000693          	li	a3,16
    800013a4:	00007617          	auipc	a2,0x7
    800013a8:	00c60613          	addi	a2,a2,12 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800013ac:	06092583          	lw	a1,96(s2)
    800013b0:	00007517          	auipc	a0,0x7
    800013b4:	d6850513          	addi	a0,a0,-664 # 80008118 <CONSOLE_STATUS+0x108>
    800013b8:	00004097          	auipc	ra,0x4
    800013bc:	e70080e7          	jalr	-400(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>

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
    800013dc:	01850513          	addi	a0,a0,24 # 800083f0 <CONSOLE_STATUS+0x3e0>
    800013e0:	00004097          	auipc	ra,0x4
    800013e4:	e48080e7          	jalr	-440(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800013e8:	0084b483          	ld	s1,8(s1)
    while(iter){
    800013ec:	fd9ff06f          	j	800013c4 <_ZN13SlabAllocator10printCacheEP5Cache+0xcc>
    }
    ConsoleUtil::printString("\n");
    800013f0:	00007517          	auipc	a0,0x7
    800013f4:	fc050513          	addi	a0,a0,-64 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800013f8:	00004097          	auipc	ra,0x4
    800013fc:	d10080e7          	jalr	-752(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80001400:	01000693          	li	a3,16
    80001404:	00007617          	auipc	a2,0x7
    80001408:	fac60613          	addi	a2,a2,-84 # 800083b0 <CONSOLE_STATUS+0x3a0>
    8000140c:	06892583          	lw	a1,104(s2)
    80001410:	00007517          	auipc	a0,0x7
    80001414:	d1850513          	addi	a0,a0,-744 # 80008128 <CONSOLE_STATUS+0x118>
    80001418:	00004097          	auipc	ra,0x4
    8000141c:	e10080e7          	jalr	-496(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>

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
    8000143c:	fb850513          	addi	a0,a0,-72 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80001440:	00004097          	auipc	ra,0x4
    80001444:	de8080e7          	jalr	-536(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001448:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000144c:	fd9ff06f          	j	80001424 <_ZN13SlabAllocator10printCacheEP5Cache+0x12c>
    }
    ConsoleUtil::printString("\n");
    80001450:	00007517          	auipc	a0,0x7
    80001454:	f6050513          	addi	a0,a0,-160 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80001458:	00004097          	auipc	ra,0x4
    8000145c:	cb0080e7          	jalr	-848(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001460:	01000693          	li	a3,16
    80001464:	00007617          	auipc	a2,0x7
    80001468:	f4c60613          	addi	a2,a2,-180 # 800083b0 <CONSOLE_STATUS+0x3a0>
    8000146c:	07092583          	lw	a1,112(s2)
    80001470:	00007517          	auipc	a0,0x7
    80001474:	cc850513          	addi	a0,a0,-824 # 80008138 <CONSOLE_STATUS+0x128>
    80001478:	00004097          	auipc	ra,0x4
    8000147c:	db0080e7          	jalr	-592(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>

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
    8000149c:	f5850513          	addi	a0,a0,-168 # 800083f0 <CONSOLE_STATUS+0x3e0>
    800014a0:	00004097          	auipc	ra,0x4
    800014a4:	d88080e7          	jalr	-632(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800014a8:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014ac:	fd9ff06f          	j	80001484 <_ZN13SlabAllocator10printCacheEP5Cache+0x18c>
    }
    ConsoleUtil::printString("\n");
    800014b0:	00007517          	auipc	a0,0x7
    800014b4:	f0050513          	addi	a0,a0,-256 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800014b8:	00004097          	auipc	ra,0x4
    800014bc:	c50080e7          	jalr	-944(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
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
    80001530:	44c080e7          	jalr	1100(ra) # 80002978 <_ZN5Buddy5allocEm>
    if(!slab)
    80001534:	0a050a63          	beqz	a0,800015e8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe0>
    80001538:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    8000153c:	00050593          	mv	a1,a0
    80001540:	06098513          	addi	a0,s3,96
    80001544:	00000097          	auipc	ra,0x0
    80001548:	f94080e7          	jalr	-108(ra) # 800014d8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    8000154c:	0489b703          	ld	a4,72(s3)
    80001550:	00100793          	li	a5,1
    80001554:	00e797bb          	sllw	a5,a5,a4
    80001558:	00c7979b          	slliw	a5,a5,0xc
    8000155c:	bd078793          	addi	a5,a5,-1072
    80001560:	0409b703          	ld	a4,64(s3)
    80001564:	02e7d7b3          	divu	a5,a5,a4
    80001568:	00f4b823          	sd	a5,16(s1)
    8000156c:	00f4bc23          	sd	a5,24(s1)
    if(slab->totalNumOfSlots > 1024*8)
    80001570:	00002737          	lui	a4,0x2
    80001574:	00f77663          	bgeu	a4,a5,80001580 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x78>
        slab->totalNumOfSlots = 1024*8;
    80001578:	000027b7          	lui	a5,0x2
    8000157c:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab));
    80001580:	43048793          	addi	a5,s1,1072
    80001584:	42f4b023          	sd	a5,1056(s1)
    slab->parent = cache;
    80001588:	4334b423          	sd	s3,1064(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    8000158c:	00000713          	li	a4,0
    80001590:	0184b783          	ld	a5,24(s1)
    80001594:	0037d793          	srli	a5,a5,0x3
    80001598:	00178793          	addi	a5,a5,1 # 2001 <_entry-0x7fffdfff>
    8000159c:	00f77a63          	bgeu	a4,a5,800015b0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa8>
        slab->allocated[i] = 0;
    800015a0:	00e487b3          	add	a5,s1,a4
    800015a4:	02078023          	sb	zero,32(a5)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800015a8:	00170713          	addi	a4,a4,1 # 2001 <_entry-0x7fffdfff>
    800015ac:	fe5ff06f          	j	80001590 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x88>
    if(cache->ctor) {
    800015b0:	0509b783          	ld	a5,80(s3)
    800015b4:	02078e63          	beqz	a5,800015f0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe8>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800015b8:	00000913          	li	s2,0
    800015bc:	0184b783          	ld	a5,24(s1)
    800015c0:	02f97c63          	bgeu	s2,a5,800015f8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800015c4:	0509b703          	ld	a4,80(s3)
    800015c8:	4204b503          	ld	a0,1056(s1)
    800015cc:	4284b783          	ld	a5,1064(s1)
    800015d0:	0407b783          	ld	a5,64(a5)
    800015d4:	032787b3          	mul	a5,a5,s2
    800015d8:	00f50533          	add	a0,a0,a5
    800015dc:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800015e0:	00190913          	addi	s2,s2,1
    800015e4:	fd9ff06f          	j	800015bc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xb4>
        return false;
    800015e8:	00000513          	li	a0,0
    800015ec:	0100006f          	j	800015fc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf4>
    return true;
    800015f0:	00100513          	li	a0,1
    800015f4:	0080006f          	j	800015fc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf4>
    800015f8:	00100513          	li	a0,1
}
    800015fc:	02813083          	ld	ra,40(sp)
    80001600:	02013403          	ld	s0,32(sp)
    80001604:	01813483          	ld	s1,24(sp)
    80001608:	01013903          	ld	s2,16(sp)
    8000160c:	00813983          	ld	s3,8(sp)
    80001610:	03010113          	addi	sp,sp,48
    80001614:	00008067          	ret

0000000080001618 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80001618:	ff010113          	addi	sp,sp,-16
    8000161c:	00813423          	sd	s0,8(sp)
    80001620:	01010413          	addi	s0,sp,16
    if(slab == head)
    80001624:	00053783          	ld	a5,0(a0)
    80001628:	02b78c63          	beq	a5,a1,80001660 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    8000162c:	0085b783          	ld	a5,8(a1)
    80001630:	00078663          	beqz	a5,8000163c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    80001634:	0005b703          	ld	a4,0(a1)
    80001638:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    8000163c:	0005b783          	ld	a5,0(a1)
    80001640:	00078663          	beqz	a5,8000164c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    80001644:	0085b703          	ld	a4,8(a1)
    80001648:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    8000164c:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80001650:	0005b423          	sd	zero,8(a1)
}
    80001654:	00813403          	ld	s0,8(sp)
    80001658:	01010113          	addi	sp,sp,16
    8000165c:	00008067          	ret
        head = slab->next;
    80001660:	0085b783          	ld	a5,8(a1)
    80001664:	00f53023          	sd	a5,0(a0)
    80001668:	fc5ff06f          	j	8000162c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

000000008000166c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    8000166c:	fe010113          	addi	sp,sp,-32
    80001670:	00113c23          	sd	ra,24(sp)
    80001674:	00813823          	sd	s0,16(sp)
    80001678:	00913423          	sd	s1,8(sp)
    8000167c:	01213023          	sd	s2,0(sp)
    80001680:	02010413          	addi	s0,sp,32
    80001684:	00058913          	mv	s2,a1
    80001688:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    8000168c:	00060593          	mv	a1,a2
    80001690:	00000097          	auipc	ra,0x0
    80001694:	f88080e7          	jalr	-120(ra) # 80001618 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    80001698:	00048593          	mv	a1,s1
    8000169c:	00090513          	mv	a0,s2
    800016a0:	00000097          	auipc	ra,0x0
    800016a4:	e38080e7          	jalr	-456(ra) # 800014d8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    800016a8:	01813083          	ld	ra,24(sp)
    800016ac:	01013403          	ld	s0,16(sp)
    800016b0:	00813483          	ld	s1,8(sp)
    800016b4:	00013903          	ld	s2,0(sp)
    800016b8:	02010113          	addi	sp,sp,32
    800016bc:	00008067          	ret

00000000800016c0 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    800016c0:	fe010113          	addi	sp,sp,-32
    800016c4:	00113c23          	sd	ra,24(sp)
    800016c8:	00813823          	sd	s0,16(sp)
    800016cc:	00913423          	sd	s1,8(sp)
    800016d0:	01213023          	sd	s2,0(sp)
    800016d4:	02010413          	addi	s0,sp,32
    800016d8:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    800016dc:	00000493          	li	s1,0
    800016e0:	01893683          	ld	a3,24(s2)
    800016e4:	0ad4f663          	bgeu	s1,a3,80001790 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd0>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    800016e8:	0034d613          	srli	a2,s1,0x3
    800016ec:	00c907b3          	add	a5,s2,a2
    800016f0:	0207c583          	lbu	a1,32(a5)
    800016f4:	fff4c793          	not	a5,s1
    800016f8:	0077f793          	andi	a5,a5,7
    800016fc:	40f5d73b          	sraw	a4,a1,a5
    80001700:	00177713          	andi	a4,a4,1
    80001704:	00070663          	beqz	a4,80001710 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x50>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001708:	00148493          	addi	s1,s1,1
    8000170c:	fd5ff06f          	j	800016e0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    80001710:	00100713          	li	a4,1
    80001714:	00f717bb          	sllw	a5,a4,a5
    80001718:	00c90633          	add	a2,s2,a2
    8000171c:	00f5e5b3          	or	a1,a1,a5
    80001720:	02b60023          	sb	a1,32(a2)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001724:	01093783          	ld	a5,16(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001728:	04f68863          	beq	a3,a5,80001778 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb8>
    8000172c:	42893503          	ld	a0,1064(s2)
    80001730:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80001734:	fff78793          	addi	a5,a5,-1
    80001738:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    8000173c:	04079463          	bnez	a5,80001784 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc4>
    80001740:	42893583          	ld	a1,1064(s2)
    80001744:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80001748:	0005b703          	ld	a4,0(a1)
    8000174c:	00053783          	ld	a5,0(a0)
    80001750:	00f70863          	beq	a4,a5,80001760 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa0>
                SlabAllocator::move(headFrom, headTo, slab);
    80001754:	00090613          	mv	a2,s2
    80001758:	00000097          	auipc	ra,0x0
    8000175c:	f14080e7          	jalr	-236(ra) # 8000166c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    80001760:	42093503          	ld	a0,1056(s2)
    80001764:	42893783          	ld	a5,1064(s2)
    80001768:	0407b783          	ld	a5,64(a5)
    8000176c:	029784b3          	mul	s1,a5,s1
    80001770:	00950533          	add	a0,a0,s1
    80001774:	0200006f          	j	80001794 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001778:	42893503          	ld	a0,1064(s2)
    8000177c:	06050513          	addi	a0,a0,96
    80001780:	fb5ff06f          	j	80001734 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x74>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001784:	42893583          	ld	a1,1064(s2)
    80001788:	06858593          	addi	a1,a1,104
    8000178c:	fbdff06f          	j	80001748 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x88>
    return nullptr;
    80001790:	00000513          	li	a0,0
}
    80001794:	01813083          	ld	ra,24(sp)
    80001798:	01013403          	ld	s0,16(sp)
    8000179c:	00813483          	ld	s1,8(sp)
    800017a0:	00013903          	ld	s2,0(sp)
    800017a4:	02010113          	addi	sp,sp,32
    800017a8:	00008067          	ret

00000000800017ac <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    800017ac:	fd010113          	addi	sp,sp,-48
    800017b0:	02113423          	sd	ra,40(sp)
    800017b4:	02813023          	sd	s0,32(sp)
    800017b8:	00913c23          	sd	s1,24(sp)
    800017bc:	01213823          	sd	s2,16(sp)
    800017c0:	01313423          	sd	s3,8(sp)
    800017c4:	03010413          	addi	s0,sp,48
    800017c8:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    800017cc:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    800017d0:	00048c63          	beqz	s1,800017e8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
            void* ret = allocateSlot(head);
    800017d4:	00048513          	mv	a0,s1
    800017d8:	00000097          	auipc	ra,0x0
    800017dc:	ee8080e7          	jalr	-280(ra) # 800016c0 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    800017e0:	fe0508e3          	beqz	a0,800017d0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x24>
                return ret;
    800017e4:	00050493          	mv	s1,a0
    if(ret){
    800017e8:	02048263          	beqz	s1,8000180c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x60>
}
    800017ec:	00048513          	mv	a0,s1
    800017f0:	02813083          	ld	ra,40(sp)
    800017f4:	02013403          	ld	s0,32(sp)
    800017f8:	01813483          	ld	s1,24(sp)
    800017fc:	01013903          	ld	s2,16(sp)
    80001800:	00813983          	ld	s3,8(sp)
    80001804:	03010113          	addi	sp,sp,48
    80001808:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    8000180c:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    80001810:	00048c63          	beqz	s1,80001828 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x7c>
            void* ret = allocateSlot(head);
    80001814:	00048513          	mv	a0,s1
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	ea8080e7          	jalr	-344(ra) # 800016c0 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001820:	fe0508e3          	beqz	a0,80001810 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x64>
                return ret;
    80001824:	00050493          	mv	s1,a0
    if(ret){
    80001828:	fc0492e3          	bnez	s1,800017ec <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
    if(cache->objectSize <= sizeof(Slab)) {
    8000182c:	04093703          	ld	a4,64(s2)
    80001830:	43000793          	li	a5,1072
    80001834:	02e7e463          	bltu	a5,a4,8000185c <_ZN13SlabAllocator14allocateObjectEP5Cache+0xb0>
        if (!SlabAllocator::allocateSlab(cache))
    80001838:	00090513          	mv	a0,s2
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	ccc080e7          	jalr	-820(ra) # 80001508 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80001844:	fa0504e3          	beqz	a0,800017ec <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001848:	06093503          	ld	a0,96(s2)
    8000184c:	00000097          	auipc	ra,0x0
    80001850:	e74080e7          	jalr	-396(ra) # 800016c0 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001854:	00050493          	mv	s1,a0
    80001858:	f95ff06f          	j	800017ec <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        Slab* slab = (Slab*)SlabAllocator::allocateObject(largeSlabCache);
    8000185c:	00009517          	auipc	a0,0x9
    80001860:	7c453503          	ld	a0,1988(a0) # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    80001864:	00000097          	auipc	ra,0x0
    80001868:	f48080e7          	jalr	-184(ra) # 800017ac <_ZN13SlabAllocator14allocateObjectEP5Cache>
    8000186c:	00050493          	mv	s1,a0
        slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS)) / cache->objectSize;
    80001870:	04893703          	ld	a4,72(s2)
    80001874:	00100793          	li	a5,1
    80001878:	00e797bb          	sllw	a5,a5,a4
    8000187c:	00c7979b          	slliw	a5,a5,0xc
    80001880:	04093703          	ld	a4,64(s2)
    80001884:	02e7d7b3          	divu	a5,a5,a4
    80001888:	00f53823          	sd	a5,16(a0)
    8000188c:	00f53c23          	sd	a5,24(a0)
        if(slab->totalNumOfSlots > 1024*8)
    80001890:	00002737          	lui	a4,0x2
    80001894:	00f77663          	bgeu	a4,a5,800018a0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0xf4>
            slab->totalNumOfSlots = 1024*8;
    80001898:	000027b7          	lui	a5,0x2
    8000189c:	00f53c23          	sd	a5,24(a0)
        void* slabOffset = Buddy::alloc(cache->slabSize);
    800018a0:	04893503          	ld	a0,72(s2)
    800018a4:	00001097          	auipc	ra,0x1
    800018a8:	0d4080e7          	jalr	212(ra) # 80002978 <_ZN5Buddy5allocEm>
        slab->objectOffset = slabOffset;
    800018ac:	42a4b023          	sd	a0,1056(s1)
        slab->parent = cache;
    800018b0:	4324b423          	sd	s2,1064(s1)
        slab->next = nullptr;
    800018b4:	0004b423          	sd	zero,8(s1)
        for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800018b8:	00000713          	li	a4,0
    800018bc:	0184b783          	ld	a5,24(s1)
    800018c0:	0037d793          	srli	a5,a5,0x3
    800018c4:	00178793          	addi	a5,a5,1 # 2001 <_entry-0x7fffdfff>
    800018c8:	00f77a63          	bgeu	a4,a5,800018dc <_ZN13SlabAllocator14allocateObjectEP5Cache+0x130>
            slab->allocated[i] = 0;
    800018cc:	00e487b3          	add	a5,s1,a4
    800018d0:	02078023          	sb	zero,32(a5)
        for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800018d4:	00170713          	addi	a4,a4,1 # 2001 <_entry-0x7fffdfff>
    800018d8:	fe5ff06f          	j	800018bc <_ZN13SlabAllocator14allocateObjectEP5Cache+0x110>
        if(cache->ctor) {
    800018dc:	05093783          	ld	a5,80(s2)
    800018e0:	02078a63          	beqz	a5,80001914 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x168>
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800018e4:	00000993          	li	s3,0
    800018e8:	0184b783          	ld	a5,24(s1)
    800018ec:	02f9f463          	bgeu	s3,a5,80001914 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x168>
                cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800018f0:	05093703          	ld	a4,80(s2)
    800018f4:	4204b503          	ld	a0,1056(s1)
    800018f8:	4284b783          	ld	a5,1064(s1)
    800018fc:	0407b783          	ld	a5,64(a5)
    80001900:	033787b3          	mul	a5,a5,s3
    80001904:	00f50533          	add	a0,a0,a5
    80001908:	000700e7          	jalr	a4
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    8000190c:	00198993          	addi	s3,s3,1
    80001910:	fd9ff06f          	j	800018e8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x13c>
        SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80001914:	00048593          	mv	a1,s1
    80001918:	06090513          	addi	a0,s2,96
    8000191c:	00000097          	auipc	ra,0x0
    80001920:	bbc080e7          	jalr	-1092(ra) # 800014d8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001924:	06093503          	ld	a0,96(s2)
    80001928:	00000097          	auipc	ra,0x0
    8000192c:	d98080e7          	jalr	-616(ra) # 800016c0 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001930:	00050493          	mv	s1,a0
    80001934:	eb9ff06f          	j	800017ec <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>

0000000080001938 <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    80001938:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    8000193c:	0017d513          	srli	a0,a5,0x1
    80001940:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80001944:	0027d713          	srli	a4,a5,0x2
    80001948:	00e7e7b3          	or	a5,a5,a4
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
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001970:	00000713          	li	a4,0
        while(num>1){
    80001974:	00100693          	li	a3,1
    80001978:	00f6f863          	bgeu	a3,a5,80001988 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    8000197c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001980:	00170713          	addi	a4,a4,1
        while(num>1){
    80001984:	ff1ff06f          	j	80001974 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    80001988:	ffb70713          	addi	a4,a4,-5
    8000198c:	00c00793          	li	a5,12
    80001990:	04e7e063          	bltu	a5,a4,800019d0 <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    80001994:	ff010113          	addi	sp,sp,-16
    80001998:	00113423          	sd	ra,8(sp)
    8000199c:	00813023          	sd	s0,0(sp)
    800019a0:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    800019a4:	00371713          	slli	a4,a4,0x3
    800019a8:	00009797          	auipc	a5,0x9
    800019ac:	67878793          	addi	a5,a5,1656 # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    800019b0:	00e78733          	add	a4,a5,a4
    800019b4:	00873503          	ld	a0,8(a4)
    800019b8:	00000097          	auipc	ra,0x0
    800019bc:	df4080e7          	jalr	-524(ra) # 800017ac <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800019c0:	00813083          	ld	ra,8(sp)
    800019c4:	00013403          	ld	s0,0(sp)
    800019c8:	01010113          	addi	sp,sp,16
    800019cc:	00008067          	ret
        return nullptr;
    800019d0:	00000513          	li	a0,0
}
    800019d4:	00008067          	ret

00000000800019d8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800019d8:	fc010113          	addi	sp,sp,-64
    800019dc:	02113c23          	sd	ra,56(sp)
    800019e0:	02813823          	sd	s0,48(sp)
    800019e4:	02913423          	sd	s1,40(sp)
    800019e8:	03213023          	sd	s2,32(sp)
    800019ec:	01313c23          	sd	s3,24(sp)
    800019f0:	01413823          	sd	s4,16(sp)
    800019f4:	01513423          	sd	s5,8(sp)
    800019f8:	04010413          	addi	s0,sp,64
    800019fc:	00050993          	mv	s3,a0
    80001a00:	00058913          	mv	s2,a1
    80001a04:	00060a93          	mv	s5,a2
    80001a08:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001a0c:	00009517          	auipc	a0,0x9
    80001a10:	68453503          	ld	a0,1668(a0) # 8000b090 <_ZN13SlabAllocator5cacheE>
    80001a14:	00000097          	auipc	ra,0x0
    80001a18:	d98080e7          	jalr	-616(ra) # 800017ac <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001a1c:	00050493          	mv	s1,a0
    if(ret == nullptr)
    80001a20:	08050863          	beqz	a0,80001ab0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xd8>
    ret->ctor = ctor;
    80001a24:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80001a28:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80001a2c:	06053823          	sd	zero,112(a0)
    80001a30:	06053423          	sd	zero,104(a0)
    80001a34:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80001a38:	05253023          	sd	s2,64(a0)
        num--;
    80001a3c:	fff90793          	addi	a5,s2,-1
        num |= num>>1;
    80001a40:	0017d713          	srli	a4,a5,0x1
    80001a44:	00e7e7b3          	or	a5,a5,a4
        num |= num>>2;
    80001a48:	0027d713          	srli	a4,a5,0x2
    80001a4c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80001a50:	0047d713          	srli	a4,a5,0x4
    80001a54:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80001a58:	0087d713          	srli	a4,a5,0x8
    80001a5c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80001a60:	0107d713          	srli	a4,a5,0x10
    80001a64:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80001a68:	0207d713          	srli	a4,a5,0x20
    80001a6c:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80001a70:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80001a74:	00000713          	li	a4,0
        while(num>1){
    80001a78:	00100693          	li	a3,1
    80001a7c:	00f6f863          	bgeu	a3,a5,80001a8c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xb4>
            num/=2;
    80001a80:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001a84:	00170713          	addi	a4,a4,1
        while(num>1){
    80001a88:	ff1ff06f          	j	80001a78 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xa0>
    int deg = Buddy::getDeg(Buddy::ceil(size));
    80001a8c:	0007071b          	sext.w	a4,a4
    if(size <= sizeof(Slab)){
    80001a90:	43000793          	li	a5,1072
    80001a94:	0527e263          	bltu	a5,s2,80001ad8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x100>
        ret->slabSize = DEFAULT_SLAB_SIZE;
    80001a98:	00200793          	li	a5,2
    80001a9c:	04f4b423          	sd	a5,72(s1)
    strcpy(name, ret->name);
    80001aa0:	00048593          	mv	a1,s1
    80001aa4:	00098513          	mv	a0,s3
    80001aa8:	00003097          	auipc	ra,0x3
    80001aac:	0e4080e7          	jalr	228(ra) # 80004b8c <_Z6strcpyPKcPc>
}
    80001ab0:	00048513          	mv	a0,s1
    80001ab4:	03813083          	ld	ra,56(sp)
    80001ab8:	03013403          	ld	s0,48(sp)
    80001abc:	02813483          	ld	s1,40(sp)
    80001ac0:	02013903          	ld	s2,32(sp)
    80001ac4:	01813983          	ld	s3,24(sp)
    80001ac8:	01013a03          	ld	s4,16(sp)
    80001acc:	00813a83          	ld	s5,8(sp)
    80001ad0:	04010113          	addi	sp,sp,64
    80001ad4:	00008067          	ret
        deg-=10;
    80001ad8:	ff67071b          	addiw	a4,a4,-10
        ret->slabSize = deg;
    80001adc:	04e4b423          	sd	a4,72(s1)
    80001ae0:	fc1ff06f          	j	80001aa0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xc8>

0000000080001ae4 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80001ae4:	fd010113          	addi	sp,sp,-48
    80001ae8:	02113423          	sd	ra,40(sp)
    80001aec:	02813023          	sd	s0,32(sp)
    80001af0:	00913c23          	sd	s1,24(sp)
    80001af4:	01213823          	sd	s2,16(sp)
    80001af8:	01313423          	sd	s3,8(sp)
    80001afc:	03010413          	addi	s0,sp,48
    Buddy::initialize(space, blockNum);
    80001b00:	00001097          	auipc	ra,0x1
    80001b04:	aa8080e7          	jalr	-1368(ra) # 800025a8 <_ZN5Buddy10initializeEPvm>
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80001b08:	00009997          	auipc	s3,0x9
    80001b0c:	3f89b983          	ld	s3,1016(s3) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001b10:	0009b583          	ld	a1,0(s3)
    80001b14:	00c5d593          	srli	a1,a1,0xc
    80001b18:	00158593          	addi	a1,a1,1
    80001b1c:	00c59593          	slli	a1,a1,0xc
    80001b20:	00009497          	auipc	s1,0x9
    80001b24:	50048493          	addi	s1,s1,1280 # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    80001b28:	06b4b823          	sd	a1,112(s1)
    cache->ctor = nullptr;
    80001b2c:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80001b30:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80001b34:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80001b38:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80001b3c:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80001b40:	07800913          	li	s2,120
    80001b44:	0525b023          	sd	s2,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001b48:	00200793          	li	a5,2
    80001b4c:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001b50:	00006517          	auipc	a0,0x6
    80001b54:	5f850513          	addi	a0,a0,1528 # 80008148 <CONSOLE_STATUS+0x138>
    80001b58:	00003097          	auipc	ra,0x3
    80001b5c:	034080e7          	jalr	52(ra) # 80004b8c <_Z6strcpyPKcPc>
    largeSlabCache = (Cache*)BUDDY_META_ADDR_CONST;
    80001b60:	0009b783          	ld	a5,0(s3)
    80001b64:	fffff737          	lui	a4,0xfffff
    80001b68:	00e7f7b3          	and	a5,a5,a4
    80001b6c:	00f4b023          	sd	a5,0(s1)
    largeSlabCache->ctor = nullptr;
    80001b70:	0407b823          	sd	zero,80(a5)
    largeSlabCache->dtor = nullptr;
    80001b74:	0407bc23          	sd	zero,88(a5)
    largeSlabCache->emptyHead = nullptr;
    80001b78:	0607b023          	sd	zero,96(a5)
    largeSlabCache->partialHead = nullptr;
    80001b7c:	0607b423          	sd	zero,104(a5)
    largeSlabCache->fullHead = nullptr;
    80001b80:	0607b823          	sd	zero,112(a5)
    largeSlabCache->objectSize = sizeof(Cache);
    80001b84:	0527b023          	sd	s2,64(a5)
    largeSlabCache->slabSize = 4;
    80001b88:	00400713          	li	a4,4
    80001b8c:	04e7b423          	sd	a4,72(a5)
    strcpy("Large Slab Cache", cache->name);
    80001b90:	0704b583          	ld	a1,112(s1)
    80001b94:	00006517          	auipc	a0,0x6
    80001b98:	5c450513          	addi	a0,a0,1476 # 80008158 <CONSOLE_STATUS+0x148>
    80001b9c:	00003097          	auipc	ra,0x3
    80001ba0:	ff0080e7          	jalr	-16(ra) # 80004b8c <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001ba4:	00000493          	li	s1,0
    80001ba8:	0480006f          	j	80001bf0 <_ZN13SlabAllocator10initializeEPvm+0x10c>
        sizeN[i] = SlabAllocator::createCache(names[i], 1<<(i+CACHE_LOWER_BOUND), nullptr, nullptr);
    80001bac:	0054871b          	addiw	a4,s1,5
    80001bb0:	00349913          	slli	s2,s1,0x3
    80001bb4:	00009797          	auipc	a5,0x9
    80001bb8:	28c78793          	addi	a5,a5,652 # 8000ae40 <_ZN13SlabAllocator5namesE>
    80001bbc:	012787b3          	add	a5,a5,s2
    80001bc0:	00000693          	li	a3,0
    80001bc4:	00000613          	li	a2,0
    80001bc8:	00100593          	li	a1,1
    80001bcc:	00e595bb          	sllw	a1,a1,a4
    80001bd0:	0007b503          	ld	a0,0(a5)
    80001bd4:	00000097          	auipc	ra,0x0
    80001bd8:	e04080e7          	jalr	-508(ra) # 800019d8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001bdc:	00009797          	auipc	a5,0x9
    80001be0:	44478793          	addi	a5,a5,1092 # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    80001be4:	012787b3          	add	a5,a5,s2
    80001be8:	00a7b423          	sd	a0,8(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80001bec:	0014849b          	addiw	s1,s1,1
    80001bf0:	00c00793          	li	a5,12
    80001bf4:	fa97dce3          	bge	a5,s1,80001bac <_ZN13SlabAllocator10initializeEPvm+0xc8>
}
    80001bf8:	02813083          	ld	ra,40(sp)
    80001bfc:	02013403          	ld	s0,32(sp)
    80001c00:	01813483          	ld	s1,24(sp)
    80001c04:	01013903          	ld	s2,16(sp)
    80001c08:	00813983          	ld	s3,8(sp)
    80001c0c:	03010113          	addi	sp,sp,48
    80001c10:	00008067          	ret

0000000080001c14 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80001c14:	0035d713          	srli	a4,a1,0x3
    80001c18:	00e507b3          	add	a5,a0,a4
    80001c1c:	0207c683          	lbu	a3,32(a5)
    80001c20:	fff5c593          	not	a1,a1
    80001c24:	0075f593          	andi	a1,a1,7
    80001c28:	40b6d7bb          	sraw	a5,a3,a1
    80001c2c:	0017f793          	andi	a5,a5,1
    80001c30:	0e078e63          	beqz	a5,80001d2c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x118>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001c34:	fe010113          	addi	sp,sp,-32
    80001c38:	00113c23          	sd	ra,24(sp)
    80001c3c:	00813823          	sd	s0,16(sp)
    80001c40:	00913423          	sd	s1,8(sp)
    80001c44:	02010413          	addi	s0,sp,32
    80001c48:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80001c4c:	00100793          	li	a5,1
    80001c50:	00b795bb          	sllw	a1,a5,a1
    80001c54:	00e50733          	add	a4,a0,a4
    80001c58:	fff5c593          	not	a1,a1
    80001c5c:	00d5f5b3          	and	a1,a1,a3
    80001c60:	02b70023          	sb	a1,32(a4) # fffffffffffff020 <end+0xffffffff7ffee020>
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001c64:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001c68:	04079a63          	bnez	a5,80001cbc <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001c6c:	42853503          	ld	a0,1064(a0)
    80001c70:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001c74:	00178793          	addi	a5,a5,1
    80001c78:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001c7c:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001c80:	04e78463          	beq	a5,a4,80001cc8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80001c84:	4284b583          	ld	a1,1064(s1)
    80001c88:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001c8c:	04e78463          	beq	a5,a4,80001cd4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80001c90:	0005b703          	ld	a4,0(a1)
    80001c94:	00053783          	ld	a5,0(a0)
    80001c98:	00f70863          	beq	a4,a5,80001ca8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001c9c:	00048613          	mv	a2,s1
    80001ca0:	00000097          	auipc	ra,0x0
    80001ca4:	9cc080e7          	jalr	-1588(ra) # 8000166c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001ca8:	01813083          	ld	ra,24(sp)
    80001cac:	01013403          	ld	s0,16(sp)
    80001cb0:	00813483          	ld	s1,8(sp)
    80001cb4:	02010113          	addi	sp,sp,32
    80001cb8:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001cbc:	42853503          	ld	a0,1064(a0)
    80001cc0:	06850513          	addi	a0,a0,104
    80001cc4:	fb1ff06f          	j	80001c74 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001cc8:	4284b583          	ld	a1,1064(s1)
    80001ccc:	06058593          	addi	a1,a1,96
    80001cd0:	fbdff06f          	j	80001c8c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80001cd4:	00048593          	mv	a1,s1
    80001cd8:	00000097          	auipc	ra,0x0
    80001cdc:	940080e7          	jalr	-1728(ra) # 80001618 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            if(slab->parent->objectSize <= sizeof(Slab)) {
    80001ce0:	4284b783          	ld	a5,1064(s1)
    80001ce4:	0407b683          	ld	a3,64(a5)
    80001ce8:	43000713          	li	a4,1072
    80001cec:	00d76c63          	bltu	a4,a3,80001d04 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xf0>
                Buddy::free(slab, slab->parent->slabSize);
    80001cf0:	0487b583          	ld	a1,72(a5)
    80001cf4:	00048513          	mv	a0,s1
    80001cf8:	00001097          	auipc	ra,0x1
    80001cfc:	ba8080e7          	jalr	-1112(ra) # 800028a0 <_ZN5Buddy4freeEPvm>
    80001d00:	fa9ff06f          	j	80001ca8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                Buddy::free(slab->objectOffset, slab->parent->slabSize);
    80001d04:	0487b583          	ld	a1,72(a5)
    80001d08:	4204b503          	ld	a0,1056(s1)
    80001d0c:	00001097          	auipc	ra,0x1
    80001d10:	b94080e7          	jalr	-1132(ra) # 800028a0 <_ZN5Buddy4freeEPvm>
                SlabAllocator::freeObject(largeSlabCache, slab);
    80001d14:	00048593          	mv	a1,s1
    80001d18:	00009517          	auipc	a0,0x9
    80001d1c:	30853503          	ld	a0,776(a0) # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    80001d20:	00000097          	auipc	ra,0x0
    80001d24:	010080e7          	jalr	16(ra) # 80001d30 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001d28:	f81ff06f          	j	80001ca8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001d2c:	00008067          	ret

0000000080001d30 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001d30:	fe010113          	addi	sp,sp,-32
    80001d34:	00113c23          	sd	ra,24(sp)
    80001d38:	00813823          	sd	s0,16(sp)
    80001d3c:	00913423          	sd	s1,8(sp)
    80001d40:	01213023          	sd	s2,0(sp)
    80001d44:	02010413          	addi	s0,sp,32
    80001d48:	00050913          	mv	s2,a0
    80001d4c:	00058493          	mv	s1,a1
    if(cache->dtor)
    80001d50:	05853783          	ld	a5,88(a0)
    80001d54:	00078663          	beqz	a5,80001d60 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80001d58:	00058513          	mv	a0,a1
    80001d5c:	000780e7          	jalr	a5
    if(cache->ctor)
    80001d60:	05093783          	ld	a5,80(s2)
    80001d64:	00078663          	beqz	a5,80001d70 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80001d68:	00048513          	mv	a0,s1
    80001d6c:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001d70:	07093503          	ld	a0,112(s2)
    80001d74:	0080006f          	j	80001d7c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001d78:	00853503          	ld	a0,8(a0)
        while(head){
    80001d7c:	02050e63          	beqz	a0,80001db8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001d80:	42053703          	ld	a4,1056(a0)
    80001d84:	01853783          	ld	a5,24(a0)
    80001d88:	42853683          	ld	a3,1064(a0)
    80001d8c:	0406b583          	ld	a1,64(a3)
    80001d90:	02b787b3          	mul	a5,a5,a1
    80001d94:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001d98:	fef4f0e3          	bgeu	s1,a5,80001d78 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80001d9c:	fce4eee3          	bltu	s1,a4,80001d78 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001da0:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80001da4:	02b755b3          	divu	a1,a4,a1
    80001da8:	00000097          	auipc	ra,0x0
    80001dac:	e6c080e7          	jalr	-404(ra) # 80001c14 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001db0:	00100513          	li	a0,1
    80001db4:	0080006f          	j	80001dbc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80001db8:	00000513          	li	a0,0
    if(deleted)
    80001dbc:	00050e63          	beqz	a0,80001dd8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80001dc0:	01813083          	ld	ra,24(sp)
    80001dc4:	01013403          	ld	s0,16(sp)
    80001dc8:	00813483          	ld	s1,8(sp)
    80001dcc:	00013903          	ld	s2,0(sp)
    80001dd0:	02010113          	addi	sp,sp,32
    80001dd4:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001dd8:	06893783          	ld	a5,104(s2)
    80001ddc:	0080006f          	j	80001de4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80001de0:	0087b783          	ld	a5,8(a5)
        while(head){
    80001de4:	fc078ee3          	beqz	a5,80001dc0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001de8:	4207b683          	ld	a3,1056(a5)
    80001dec:	0187b703          	ld	a4,24(a5)
    80001df0:	4287b603          	ld	a2,1064(a5)
    80001df4:	04063583          	ld	a1,64(a2)
    80001df8:	02b70733          	mul	a4,a4,a1
    80001dfc:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001e00:	fee4f0e3          	bgeu	s1,a4,80001de0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80001e04:	fcd4eee3          	bltu	s1,a3,80001de0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001e08:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001e0c:	02b6d5b3          	divu	a1,a3,a1
    80001e10:	00078513          	mv	a0,a5
    80001e14:	00000097          	auipc	ra,0x0
    80001e18:	e00080e7          	jalr	-512(ra) # 80001c14 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001e1c:	00100513          	li	a0,1
    80001e20:	fa1ff06f          	j	80001dc0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080001e24 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001e24:	fe010113          	addi	sp,sp,-32
    80001e28:	00113c23          	sd	ra,24(sp)
    80001e2c:	00813823          	sd	s0,16(sp)
    80001e30:	00913423          	sd	s1,8(sp)
    80001e34:	01213023          	sd	s2,0(sp)
    80001e38:	02010413          	addi	s0,sp,32
    80001e3c:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001e40:	00000493          	li	s1,0
    80001e44:	00c00793          	li	a5,12
    80001e48:	0297c863          	blt	a5,s1,80001e78 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001e4c:	00349713          	slli	a4,s1,0x3
    80001e50:	00009797          	auipc	a5,0x9
    80001e54:	1d078793          	addi	a5,a5,464 # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    80001e58:	00e787b3          	add	a5,a5,a4
    80001e5c:	00090593          	mv	a1,s2
    80001e60:	0087b503          	ld	a0,8(a5)
    80001e64:	00000097          	auipc	ra,0x0
    80001e68:	ecc080e7          	jalr	-308(ra) # 80001d30 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001e6c:	00051663          	bnez	a0,80001e78 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001e70:	0014849b          	addiw	s1,s1,1
    80001e74:	fd1ff06f          	j	80001e44 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001e78:	01813083          	ld	ra,24(sp)
    80001e7c:	01013403          	ld	s0,16(sp)
    80001e80:	00813483          	ld	s1,8(sp)
    80001e84:	00013903          	ld	s2,0(sp)
    80001e88:	02010113          	addi	sp,sp,32
    80001e8c:	00008067          	ret

0000000080001e90 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001e90:	fe010113          	addi	sp,sp,-32
    80001e94:	00113c23          	sd	ra,24(sp)
    80001e98:	00813823          	sd	s0,16(sp)
    80001e9c:	00913423          	sd	s1,8(sp)
    80001ea0:	01213023          	sd	s2,0(sp)
    80001ea4:	02010413          	addi	s0,sp,32
    80001ea8:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001eac:	00053903          	ld	s2,0(a0)
    80001eb0:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001eb4:	00093503          	ld	a0,0(s2)
    80001eb8:	02050263          	beqz	a0,80001edc <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80001ebc:	42853783          	ld	a5,1064(a0)
    80001ec0:	0487b583          	ld	a1,72(a5)
    80001ec4:	00001097          	auipc	ra,0x1
    80001ec8:	9dc080e7          	jalr	-1572(ra) # 800028a0 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001ecc:	00093783          	ld	a5,0(s2)
    80001ed0:	0087b783          	ld	a5,8(a5)
    80001ed4:	00f93023          	sd	a5,0(s2)
        while(head){
    80001ed8:	fddff06f          	j	80001eb4 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001edc:	0004b903          	ld	s2,0(s1)
    80001ee0:	06890913          	addi	s2,s2,104
    80001ee4:	00093503          	ld	a0,0(s2)
    80001ee8:	02050263          	beqz	a0,80001f0c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80001eec:	42853783          	ld	a5,1064(a0)
    80001ef0:	0487b583          	ld	a1,72(a5)
    80001ef4:	00001097          	auipc	ra,0x1
    80001ef8:	9ac080e7          	jalr	-1620(ra) # 800028a0 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001efc:	00093783          	ld	a5,0(s2)
    80001f00:	0087b783          	ld	a5,8(a5)
    80001f04:	00f93023          	sd	a5,0(s2)
        while(head){
    80001f08:	fddff06f          	j	80001ee4 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001f0c:	0004b903          	ld	s2,0(s1)
    80001f10:	06090913          	addi	s2,s2,96
    80001f14:	00093503          	ld	a0,0(s2)
    80001f18:	02050263          	beqz	a0,80001f3c <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80001f1c:	42853783          	ld	a5,1064(a0)
    80001f20:	0487b583          	ld	a1,72(a5)
    80001f24:	00001097          	auipc	ra,0x1
    80001f28:	97c080e7          	jalr	-1668(ra) # 800028a0 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001f2c:	00093783          	ld	a5,0(s2)
    80001f30:	0087b783          	ld	a5,8(a5)
    80001f34:	00f93023          	sd	a5,0(s2)
        while(head){
    80001f38:	fddff06f          	j	80001f14 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001f3c:	0004b583          	ld	a1,0(s1)
    80001f40:	00009517          	auipc	a0,0x9
    80001f44:	15053503          	ld	a0,336(a0) # 8000b090 <_ZN13SlabAllocator5cacheE>
    80001f48:	00000097          	auipc	ra,0x0
    80001f4c:	de8080e7          	jalr	-536(ra) # 80001d30 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001f50:	0004b023          	sd	zero,0(s1)
}
    80001f54:	01813083          	ld	ra,24(sp)
    80001f58:	01013403          	ld	s0,16(sp)
    80001f5c:	00813483          	ld	s1,8(sp)
    80001f60:	00013903          	ld	s2,0(sp)
    80001f64:	02010113          	addi	sp,sp,32
    80001f68:	00008067          	ret

0000000080001f6c <_Z6memsetPKvii>:
                                    "tc_1",
                                    "tc_2",
                                    "tc_3",
                                    "tc_4"};

void memset(const void *data, int size, int value) {
    80001f6c:	ff010113          	addi	sp,sp,-16
    80001f70:	00813423          	sd	s0,8(sp)
    80001f74:	01010413          	addi	s0,sp,16
    for (int j = 0; j < size; j++) {
    80001f78:	00000793          	li	a5,0
    80001f7c:	00b7da63          	bge	a5,a1,80001f90 <_Z6memsetPKvii+0x24>
        *((char *)data + j) = value;
    80001f80:	00f50733          	add	a4,a0,a5
    80001f84:	00c70023          	sb	a2,0(a4)
    for (int j = 0; j < size; j++) {
    80001f88:	0017879b          	addiw	a5,a5,1
    80001f8c:	ff1ff06f          	j	80001f7c <_Z6memsetPKvii+0x10>
    }
}
    80001f90:	00813403          	ld	s0,8(sp)
    80001f94:	01010113          	addi	sp,sp,16
    80001f98:	00008067          	ret

0000000080001f9c <_Z9constructPv>:

void construct(void *data) {
    80001f9c:	ff010113          	addi	sp,sp,-16
    80001fa0:	00113423          	sd	ra,8(sp)
    80001fa4:	00813023          	sd	s0,0(sp)
    80001fa8:	01010413          	addi	s0,sp,16
//    static int i = 1;
//    printf("%d Shared object constructed.\n", i++);
    memset(data, shared_size, MASK);
    80001fac:	0a500613          	li	a2,165
    80001fb0:	00700593          	li	a1,7
    80001fb4:	00000097          	auipc	ra,0x0
    80001fb8:	fb8080e7          	jalr	-72(ra) # 80001f6c <_Z6memsetPKvii>
}
    80001fbc:	00813083          	ld	ra,8(sp)
    80001fc0:	00013403          	ld	s0,0(sp)
    80001fc4:	01010113          	addi	sp,sp,16
    80001fc8:	00008067          	ret

0000000080001fcc <_Z5checkPvm>:

int check(void *data, size_t size) {
    80001fcc:	ff010113          	addi	sp,sp,-16
    80001fd0:	00813423          	sd	s0,8(sp)
    80001fd4:	01010413          	addi	s0,sp,16
    80001fd8:	00050613          	mv	a2,a0
    int ret = 1;
    for (uint64 i = 0; i < size; i++) {
    80001fdc:	00000793          	li	a5,0
    int ret = 1;
    80001fe0:	00100513          	li	a0,1
    80001fe4:	0080006f          	j	80001fec <_Z5checkPvm+0x20>
    for (uint64 i = 0; i < size; i++) {
    80001fe8:	00178793          	addi	a5,a5,1
    80001fec:	00b7fe63          	bgeu	a5,a1,80002008 <_Z5checkPvm+0x3c>
        if (((unsigned char *)data)[i] != MASK) {
    80001ff0:	00f60733          	add	a4,a2,a5
    80001ff4:	00074683          	lbu	a3,0(a4)
    80001ff8:	0a500713          	li	a4,165
    80001ffc:	fee686e3          	beq	a3,a4,80001fe8 <_Z5checkPvm+0x1c>
            ret = 0;
    80002000:	00000513          	li	a0,0
    80002004:	fe5ff06f          	j	80001fe8 <_Z5checkPvm+0x1c>
        }
    }

    return ret;
}
    80002008:	00813403          	ld	s0,8(sp)
    8000200c:	01010113          	addi	sp,sp,16
    80002010:	00008067          	ret

0000000080002014 <_Z4workPv>:
struct objects_s {
    kmem_cache_t *cache;
    void *data;
};

void work(void* pdata) {
    80002014:	f8010113          	addi	sp,sp,-128
    80002018:	06113c23          	sd	ra,120(sp)
    8000201c:	06813823          	sd	s0,112(sp)
    80002020:	06913423          	sd	s1,104(sp)
    80002024:	07213023          	sd	s2,96(sp)
    80002028:	05313c23          	sd	s3,88(sp)
    8000202c:	05413823          	sd	s4,80(sp)
    80002030:	05513423          	sd	s5,72(sp)
    80002034:	05613023          	sd	s6,64(sp)
    80002038:	03713c23          	sd	s7,56(sp)
    8000203c:	03813823          	sd	s8,48(sp)
    80002040:	03913423          	sd	s9,40(sp)
    80002044:	08010413          	addi	s0,sp,128
    struct data_s data = *(struct data_s*) pdata;
    80002048:	00053c03          	ld	s8,0(a0)
    8000204c:	f9843423          	sd	s8,-120(s0)
    80002050:	00853783          	ld	a5,8(a0)
    80002054:	f8f43823          	sd	a5,-112(s0)
    80002058:	01053783          	ld	a5,16(a0)
    8000205c:	f8f43c23          	sd	a5,-104(s0)
    int size = 0;
    int object_size = data.id + 1;
    80002060:	000c079b          	sext.w	a5,s8
    80002064:	001c0c1b          	addiw	s8,s8,1
    kmem_cache_t *cache = kmem_cache_create(CACHE_NAMES[data.id], object_size, 0, 0);
    80002068:	00379713          	slli	a4,a5,0x3
    8000206c:	00009797          	auipc	a5,0x9
    80002070:	e3c78793          	addi	a5,a5,-452 # 8000aea8 <_ZL11CACHE_NAMES>
    80002074:	00e787b3          	add	a5,a5,a4
    80002078:	000c0b13          	mv	s6,s8
    8000207c:	00000693          	li	a3,0
    80002080:	00000613          	li	a2,0
    80002084:	000c0593          	mv	a1,s8
    80002088:	0007b503          	ld	a0,0(a5)
    8000208c:	00003097          	auipc	ra,0x3
    80002090:	258080e7          	jalr	600(ra) # 800052e4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002094:	00050a13          	mv	s4,a0

    struct objects_s *objs = (struct objects_s*)(kmalloc(sizeof(struct objects_s) * data.iterations));
    80002098:	f9842b83          	lw	s7,-104(s0)
    8000209c:	004b9513          	slli	a0,s7,0x4
    800020a0:	00003097          	auipc	ra,0x3
    800020a4:	33c080e7          	jalr	828(ra) # 800053dc <_Z7kmallocm>
    800020a8:	00050a93          	mv	s5,a0

    for (int i = 0; i < data.iterations; i++) {
    800020ac:	00000493          	li	s1,0
    int size = 0;
    800020b0:	00000993          	li	s3,0
    800020b4:	0380006f          	j	800020ec <_Z4workPv+0xd8>
            if (!check(objs[size].data, shared_size)) {
                ConsoleUtil::printString("Value not correct!");
            }
        }
        else {
            objs[size].data = kmem_cache_alloc(cache);
    800020b8:	00499913          	slli	s2,s3,0x4
    800020bc:	012a8933          	add	s2,s5,s2
    800020c0:	000a0513          	mv	a0,s4
    800020c4:	00003097          	auipc	ra,0x3
    800020c8:	248080e7          	jalr	584(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
    800020cc:	00a93423          	sd	a0,8(s2)
            objs[size].cache = cache;
    800020d0:	01493023          	sd	s4,0(s2)
            memset(objs[size].data, object_size, MASK);
    800020d4:	0a500613          	li	a2,165
    800020d8:	000c0593          	mv	a1,s8
    800020dc:	00000097          	auipc	ra,0x0
    800020e0:	e90080e7          	jalr	-368(ra) # 80001f6c <_Z6memsetPKvii>
        }
        size++;
    800020e4:	0019899b          	addiw	s3,s3,1
    for (int i = 0; i < data.iterations; i++) {
    800020e8:	0014849b          	addiw	s1,s1,1
    800020ec:	0574da63          	bge	s1,s7,80002140 <_Z4workPv+0x12c>
        if (i % 100 == 0) {
    800020f0:	06400793          	li	a5,100
    800020f4:	02f4e7bb          	remw	a5,s1,a5
    800020f8:	fc0790e3          	bnez	a5,800020b8 <_Z4workPv+0xa4>
            objs[size].data = kmem_cache_alloc(data.shared);
    800020fc:	f9043c83          	ld	s9,-112(s0)
    80002100:	00499913          	slli	s2,s3,0x4
    80002104:	012a8933          	add	s2,s5,s2
    80002108:	000c8513          	mv	a0,s9
    8000210c:	00003097          	auipc	ra,0x3
    80002110:	200080e7          	jalr	512(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
    80002114:	00a93423          	sd	a0,8(s2)
            objs[size].cache = data.shared;
    80002118:	01993023          	sd	s9,0(s2)
            if (!check(objs[size].data, shared_size)) {
    8000211c:	00700593          	li	a1,7
    80002120:	00000097          	auipc	ra,0x0
    80002124:	eac080e7          	jalr	-340(ra) # 80001fcc <_Z5checkPvm>
    80002128:	fa051ee3          	bnez	a0,800020e4 <_Z4workPv+0xd0>
                ConsoleUtil::printString("Value not correct!");
    8000212c:	00006517          	auipc	a0,0x6
    80002130:	17c50513          	addi	a0,a0,380 # 800082a8 <CONSOLE_STATUS+0x298>
    80002134:	00003097          	auipc	ra,0x3
    80002138:	fd4080e7          	jalr	-44(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    8000213c:	fa9ff06f          	j	800020e4 <_Z4workPv+0xd0>
    }

    kmem_cache_info(cache);
    80002140:	000a0513          	mv	a0,s4
    80002144:	00003097          	auipc	ra,0x3
    80002148:	248080e7          	jalr	584(ra) # 8000538c <_Z15kmem_cache_infoP5Cache>
    kmem_cache_info(data.shared);
    8000214c:	f9043503          	ld	a0,-112(s0)
    80002150:	00003097          	auipc	ra,0x3
    80002154:	23c080e7          	jalr	572(ra) # 8000538c <_Z15kmem_cache_infoP5Cache>

    for (int i = 0; i < size; i++) {
    80002158:	00000913          	li	s2,0
    8000215c:	0300006f          	j	8000218c <_Z4workPv+0x178>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    80002160:	000b0593          	mv	a1,s6
    80002164:	0440006f          	j	800021a8 <_Z4workPv+0x194>
            ConsoleUtil::printString("Value not correct!");
    80002168:	00006517          	auipc	a0,0x6
    8000216c:	14050513          	addi	a0,a0,320 # 800082a8 <CONSOLE_STATUS+0x298>
    80002170:	00003097          	auipc	ra,0x3
    80002174:	f98080e7          	jalr	-104(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
        }
        kmem_cache_free(objs[i].cache, objs[i].data);
    80002178:	0084b583          	ld	a1,8(s1)
    8000217c:	0004b503          	ld	a0,0(s1)
    80002180:	00003097          	auipc	ra,0x3
    80002184:	1b4080e7          	jalr	436(ra) # 80005334 <_Z15kmem_cache_freeP5CachePv>
    for (int i = 0; i < size; i++) {
    80002188:	0019091b          	addiw	s2,s2,1
    8000218c:	03395663          	bge	s2,s3,800021b8 <_Z4workPv+0x1a4>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    80002190:	00491493          	slli	s1,s2,0x4
    80002194:	009a84b3          	add	s1,s5,s1
    80002198:	0084b503          	ld	a0,8(s1)
    8000219c:	0004b783          	ld	a5,0(s1)
    800021a0:	fd4780e3          	beq	a5,s4,80002160 <_Z4workPv+0x14c>
    800021a4:	00700593          	li	a1,7
    800021a8:	00000097          	auipc	ra,0x0
    800021ac:	e24080e7          	jalr	-476(ra) # 80001fcc <_Z5checkPvm>
    800021b0:	fc0514e3          	bnez	a0,80002178 <_Z4workPv+0x164>
    800021b4:	fb5ff06f          	j	80002168 <_Z4workPv+0x154>
    }

    kfree(objs);
    800021b8:	000a8513          	mv	a0,s5
    800021bc:	00003097          	auipc	ra,0x3
    800021c0:	248080e7          	jalr	584(ra) # 80005404 <_Z5kfreePKv>
    kmem_cache_destroy(cache);
    800021c4:	000a0513          	mv	a0,s4
    800021c8:	00003097          	auipc	ra,0x3
    800021cc:	194080e7          	jalr	404(ra) # 8000535c <_Z18kmem_cache_destroyP5Cache>
}
    800021d0:	07813083          	ld	ra,120(sp)
    800021d4:	07013403          	ld	s0,112(sp)
    800021d8:	06813483          	ld	s1,104(sp)
    800021dc:	06013903          	ld	s2,96(sp)
    800021e0:	05813983          	ld	s3,88(sp)
    800021e4:	05013a03          	ld	s4,80(sp)
    800021e8:	04813a83          	ld	s5,72(sp)
    800021ec:	04013b03          	ld	s6,64(sp)
    800021f0:	03813b83          	ld	s7,56(sp)
    800021f4:	03013c03          	ld	s8,48(sp)
    800021f8:	02813c83          	ld	s9,40(sp)
    800021fc:	08010113          	addi	sp,sp,128
    80002200:	00008067          	ret

0000000080002204 <_Z4runsPFvPvEP6data_si>:



void runs(void(*work)(void*), struct data_s* data, int num) {
    80002204:	fb010113          	addi	sp,sp,-80
    80002208:	04113423          	sd	ra,72(sp)
    8000220c:	04813023          	sd	s0,64(sp)
    80002210:	02913c23          	sd	s1,56(sp)
    80002214:	03213823          	sd	s2,48(sp)
    80002218:	03313423          	sd	s3,40(sp)
    8000221c:	03413023          	sd	s4,32(sp)
    80002220:	05010413          	addi	s0,sp,80
    80002224:	00050a13          	mv	s4,a0
    80002228:	00058913          	mv	s2,a1
    8000222c:	00060993          	mv	s3,a2
    for (int i = 0; i < num; i++) {
    80002230:	00000493          	li	s1,0
    80002234:	0334d863          	bge	s1,s3,80002264 <_Z4runsPFvPvEP6data_si+0x60>
        struct data_s private_data;
        private_data = *(struct data_s*) data;
    80002238:	00093783          	ld	a5,0(s2)
    8000223c:	faf43c23          	sd	a5,-72(s0)
    80002240:	00893783          	ld	a5,8(s2)
    80002244:	fcf43023          	sd	a5,-64(s0)
    80002248:	01093783          	ld	a5,16(s2)
    8000224c:	fcf43423          	sd	a5,-56(s0)
        private_data.id = i;
    80002250:	fa942c23          	sw	s1,-72(s0)
        work(&private_data);
    80002254:	fb840513          	addi	a0,s0,-72
    80002258:	000a00e7          	jalr	s4
    for (int i = 0; i < num; i++) {
    8000225c:	0014849b          	addiw	s1,s1,1
    80002260:	fd5ff06f          	j	80002234 <_Z4runsPFvPvEP6data_si+0x30>
    }
}
    80002264:	04813083          	ld	ra,72(sp)
    80002268:	04013403          	ld	s0,64(sp)
    8000226c:	03813483          	ld	s1,56(sp)
    80002270:	03013903          	ld	s2,48(sp)
    80002274:	02813983          	ld	s3,40(sp)
    80002278:	02013a03          	ld	s4,32(sp)
    8000227c:	05010113          	addi	sp,sp,80
    80002280:	00008067          	ret

0000000080002284 <_Z5test2v>:

void test2() {
    80002284:	fc010113          	addi	sp,sp,-64
    80002288:	02113c23          	sd	ra,56(sp)
    8000228c:	02813823          	sd	s0,48(sp)
    80002290:	02913423          	sd	s1,40(sp)
    80002294:	04010413          	addi	s0,sp,64
    kmem_cache_t *shared = kmem_cache_create("shared object", shared_size, construct, nullptr);
    80002298:	00000693          	li	a3,0
    8000229c:	00000617          	auipc	a2,0x0
    800022a0:	d0060613          	addi	a2,a2,-768 # 80001f9c <_Z9constructPv>
    800022a4:	00700593          	li	a1,7
    800022a8:	00006517          	auipc	a0,0x6
    800022ac:	01850513          	addi	a0,a0,24 # 800082c0 <CONSOLE_STATUS+0x2b0>
    800022b0:	00003097          	auipc	ra,0x3
    800022b4:	034080e7          	jalr	52(ra) # 800052e4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800022b8:	00050493          	mv	s1,a0

    struct data_s data;
    data.shared = shared;
    800022bc:	fca43823          	sd	a0,-48(s0)
    data.iterations = ITERATIONS;
    800022c0:	3e800793          	li	a5,1000
    800022c4:	fcf42c23          	sw	a5,-40(s0)
    runs(work, &data, RUN_NUM);
    800022c8:	00500613          	li	a2,5
    800022cc:	fc840593          	addi	a1,s0,-56
    800022d0:	00000517          	auipc	a0,0x0
    800022d4:	d4450513          	addi	a0,a0,-700 # 80002014 <_Z4workPv>
    800022d8:	00000097          	auipc	ra,0x0
    800022dc:	f2c080e7          	jalr	-212(ra) # 80002204 <_Z4runsPFvPvEP6data_si>

    kmem_cache_destroy(shared);
    800022e0:	00048513          	mv	a0,s1
    800022e4:	00003097          	auipc	ra,0x3
    800022e8:	078080e7          	jalr	120(ra) # 8000535c <_Z18kmem_cache_destroyP5Cache>
}
    800022ec:	03813083          	ld	ra,56(sp)
    800022f0:	03013403          	ld	s0,48(sp)
    800022f4:	02813483          	ld	s1,40(sp)
    800022f8:	04010113          	addi	sp,sp,64
    800022fc:	00008067          	ret

0000000080002300 <_Z4ctorPv>:

struct Test{
    uint64 a,b,c,d,e,f;
};

void ctor(void* tst){
    80002300:	ff010113          	addi	sp,sp,-16
    80002304:	00813423          	sd	s0,8(sp)
    80002308:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    8000230c:	01100793          	li	a5,17
    80002310:	00f53023          	sd	a5,0(a0)
    ((Test*)tst)->b = 32;
    80002314:	02000793          	li	a5,32
    80002318:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    8000231c:	00d00793          	li	a5,13
    80002320:	00f53823          	sd	a5,16(a0)

}
    80002324:	00813403          	ld	s0,8(sp)
    80002328:	01010113          	addi	sp,sp,16
    8000232c:	00008067          	ret

0000000080002330 <_ZN6SystemC1Ev>:


System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
    80002330:	00009797          	auipc	a5,0x9
    80002334:	d687c783          	lbu	a5,-664(a5) # 8000b098 <_ZN6System11initializedE>
    80002338:	00078463          	beqz	a5,80002340 <_ZN6SystemC1Ev+0x10>
    8000233c:	00008067          	ret
System::System() {
    80002340:	fc010113          	addi	sp,sp,-64
    80002344:	02113c23          	sd	ra,56(sp)
    80002348:	02813823          	sd	s0,48(sp)
    8000234c:	02913423          	sd	s1,40(sp)
    80002350:	03213023          	sd	s2,32(sp)
    80002354:	01313c23          	sd	s3,24(sp)
    80002358:	04010413          	addi	s0,sp,64
        initialized = true;
    8000235c:	00100793          	li	a5,1
    80002360:	00009717          	auipc	a4,0x9
    80002364:	d2f70c23          	sb	a5,-712(a4) # 8000b098 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    80002368:	00002097          	auipc	ra,0x2
    8000236c:	760080e7          	jalr	1888(ra) # 80004ac8 <_ZN5RiscV10initializeEv>

        kmem_cache_t* cache1 = kmem_cache_create("Cache 1", 512, nullptr, nullptr);
    80002370:	00000693          	li	a3,0
    80002374:	00000613          	li	a2,0
    80002378:	20000593          	li	a1,512
    8000237c:	00006517          	auipc	a0,0x6
    80002380:	f5450513          	addi	a0,a0,-172 # 800082d0 <CONSOLE_STATUS+0x2c0>
    80002384:	00003097          	auipc	ra,0x3
    80002388:	f60080e7          	jalr	-160(ra) # 800052e4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000238c:	00050913          	mv	s2,a0
        kmem_cache_t* cache2 = kmem_cache_create("Cache 1", 1<<15, nullptr, nullptr);
    80002390:	00000693          	li	a3,0
    80002394:	00000613          	li	a2,0
    80002398:	000085b7          	lui	a1,0x8
    8000239c:	00006517          	auipc	a0,0x6
    800023a0:	f3450513          	addi	a0,a0,-204 # 800082d0 <CONSOLE_STATUS+0x2c0>
    800023a4:	00003097          	auipc	ra,0x3
    800023a8:	f40080e7          	jalr	-192(ra) # 800052e4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800023ac:	00050493          	mv	s1,a0
        kmem_cache_alloc(cache1);
    800023b0:	00090513          	mv	a0,s2
    800023b4:	00003097          	auipc	ra,0x3
    800023b8:	f58080e7          	jalr	-168(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
        kmem_cache_alloc(cache2);
    800023bc:	00048513          	mv	a0,s1
    800023c0:	00003097          	auipc	ra,0x3
    800023c4:	f4c080e7          	jalr	-180(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
        kmem_cache_alloc(cache2);
    800023c8:	00048513          	mv	a0,s1
    800023cc:	00003097          	auipc	ra,0x3
    800023d0:	f40080e7          	jalr	-192(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
        kmem_cache_alloc(cache2);
    800023d4:	00048513          	mv	a0,s1
    800023d8:	00003097          	auipc	ra,0x3
    800023dc:	f34080e7          	jalr	-204(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
        void *ret = kmem_cache_alloc(cache2);
    800023e0:	00048513          	mv	a0,s1
    800023e4:	00003097          	auipc	ra,0x3
    800023e8:	f28080e7          	jalr	-216(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
    800023ec:	00050993          	mv	s3,a0

        SlabAllocator::printSlab(cache2->fullHead);
    800023f0:	0704b503          	ld	a0,112(s1)
    800023f4:	fffff097          	auipc	ra,0xfffff
    800023f8:	da8080e7          	jalr	-600(ra) # 8000119c <_ZN13SlabAllocator9printSlabEP4Slab>

        kmem_cache_free(cache2, ret);
    800023fc:	00098593          	mv	a1,s3
    80002400:	00048513          	mv	a0,s1
    80002404:	00003097          	auipc	ra,0x3
    80002408:	f30080e7          	jalr	-208(ra) # 80005334 <_Z15kmem_cache_freeP5CachePv>

        SlabAllocator::printSlab(cache2->partialHead);
    8000240c:	0684b503          	ld	a0,104(s1)
    80002410:	fffff097          	auipc	ra,0xfffff
    80002414:	d8c080e7          	jalr	-628(ra) # 8000119c <_ZN13SlabAllocator9printSlabEP4Slab>

        kmem_cache_info(cache1);
    80002418:	00090513          	mv	a0,s2
    8000241c:	00003097          	auipc	ra,0x3
    80002420:	f70080e7          	jalr	-144(ra) # 8000538c <_Z15kmem_cache_infoP5Cache>
        kmem_cache_info(cache2);
    80002424:	00048513          	mv	a0,s1
    80002428:	00003097          	auipc	ra,0x3
    8000242c:	f64080e7          	jalr	-156(ra) # 8000538c <_Z15kmem_cache_infoP5Cache>
        void* ret1 = kmalloc(1<<17);
    80002430:	00020537          	lui	a0,0x20
    80002434:	00003097          	auipc	ra,0x3
    80002438:	fa8080e7          	jalr	-88(ra) # 800053dc <_Z7kmallocm>
        if(ret1 == nullptr){
    8000243c:	04050e63          	beqz	a0,80002498 <_ZN6SystemC1Ev+0x168>
            ConsoleUtil::printString("ERROR\n");
        }
        else{
            ConsoleUtil::print("",(uint64)ret1,"\n");
    80002440:	01000693          	li	a3,16
    80002444:	00006617          	auipc	a2,0x6
    80002448:	f6c60613          	addi	a2,a2,-148 # 800083b0 <CONSOLE_STATUS+0x3a0>
    8000244c:	0005059b          	sext.w	a1,a0
    80002450:	00006517          	auipc	a0,0x6
    80002454:	fa050513          	addi	a0,a0,-96 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80002458:	00003097          	auipc	ra,0x3
    8000245c:	dd0080e7          	jalr	-560(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        };
        void* ret2 = kmalloc(1<<17);
    80002460:	00020537          	lui	a0,0x20
    80002464:	00003097          	auipc	ra,0x3
    80002468:	f78080e7          	jalr	-136(ra) # 800053dc <_Z7kmallocm>
        if(ret2 == nullptr){
    8000246c:	04050063          	beqz	a0,800024ac <_ZN6SystemC1Ev+0x17c>
            ConsoleUtil::printString("ERROR\n");
        }
        else{
            ConsoleUtil::print("",(uint64)ret2,"\n");
    80002470:	01000693          	li	a3,16
    80002474:	00006617          	auipc	a2,0x6
    80002478:	f3c60613          	addi	a2,a2,-196 # 800083b0 <CONSOLE_STATUS+0x3a0>
    8000247c:	0005059b          	sext.w	a1,a0
    80002480:	00006517          	auipc	a0,0x6
    80002484:	f7050513          	addi	a0,a0,-144 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80002488:	00003097          	auipc	ra,0x3
    8000248c:	da0080e7          	jalr	-608(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
System::System() {
    80002490:	00000493          	li	s1,0
    80002494:	04c0006f          	j	800024e0 <_ZN6SystemC1Ev+0x1b0>
            ConsoleUtil::printString("ERROR\n");
    80002498:	00006517          	auipc	a0,0x6
    8000249c:	e4050513          	addi	a0,a0,-448 # 800082d8 <CONSOLE_STATUS+0x2c8>
    800024a0:	00003097          	auipc	ra,0x3
    800024a4:	c68080e7          	jalr	-920(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    800024a8:	fb9ff06f          	j	80002460 <_ZN6SystemC1Ev+0x130>
            ConsoleUtil::printString("ERROR\n");
    800024ac:	00006517          	auipc	a0,0x6
    800024b0:	e2c50513          	addi	a0,a0,-468 # 800082d8 <CONSOLE_STATUS+0x2c8>
    800024b4:	00003097          	auipc	ra,0x3
    800024b8:	c54080e7          	jalr	-940(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    800024bc:	fd5ff06f          	j	80002490 <_ZN6SystemC1Ev+0x160>
        };
        for(int i=0;i<BUCKET_SIZE;i++){
            kmem_cache_info(SlabAllocator::sizeN[i]);
    800024c0:	00349713          	slli	a4,s1,0x3
    800024c4:	00009797          	auipc	a5,0x9
    800024c8:	a4c7b783          	ld	a5,-1460(a5) # 8000af10 <_GLOBAL_OFFSET_TABLE_+0x28>
    800024cc:	00e787b3          	add	a5,a5,a4
    800024d0:	0007b503          	ld	a0,0(a5)
    800024d4:	00003097          	auipc	ra,0x3
    800024d8:	eb8080e7          	jalr	-328(ra) # 8000538c <_Z15kmem_cache_infoP5Cache>
        for(int i=0;i<BUCKET_SIZE;i++){
    800024dc:	0014849b          	addiw	s1,s1,1
    800024e0:	00c00793          	li	a5,12
    800024e4:	fc97dee3          	bge	a5,s1,800024c0 <_ZN6SystemC1Ev+0x190>
        }
        test2();
    800024e8:	00000097          	auipc	ra,0x0
    800024ec:	d9c080e7          	jalr	-612(ra) # 80002284 <_Z5test2v>
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), userMainWrapper, nullptr);
    800024f0:	00000613          	li	a2,0
    800024f4:	00009597          	auipc	a1,0x9
    800024f8:	a6c5b583          	ld	a1,-1428(a1) # 8000af60 <_GLOBAL_OFFSET_TABLE_+0x78>
    800024fc:	fc840513          	addi	a0,s0,-56
    80002500:	00002097          	auipc	ra,0x2
    80002504:	fc8080e7          	jalr	-56(ra) # 800044c8 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80002508:	fc843783          	ld	a5,-56(s0)
    8000250c:	0107a703          	lw	a4,16(a5)
    80002510:	00200793          	li	a5,2
    80002514:	00f70863          	beq	a4,a5,80002524 <_ZN6SystemC1Ev+0x1f4>
            RiscV::threadDispatchUtil();
    80002518:	00002097          	auipc	ra,0x2
    8000251c:	04c080e7          	jalr	76(ra) # 80004564 <_ZN5RiscV18threadDispatchUtilEv>
    80002520:	fe9ff06f          	j	80002508 <_ZN6SystemC1Ev+0x1d8>
        }

        //finalize the machine
        RiscV::finalize();
    80002524:	00001097          	auipc	ra,0x1
    80002528:	258080e7          	jalr	600(ra) # 8000377c <_ZN5RiscV8finalizeEv>
    }
    8000252c:	03813083          	ld	ra,56(sp)
    80002530:	03013403          	ld	s0,48(sp)
    80002534:	02813483          	ld	s1,40(sp)
    80002538:	02013903          	ld	s2,32(sp)
    8000253c:	01813983          	ld	s3,24(sp)
    80002540:	04010113          	addi	sp,sp,64
    80002544:	00008067          	ret

0000000080002548 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80002548:	ff010113          	addi	sp,sp,-16
    8000254c:	00813423          	sd	s0,8(sp)
    80002550:	01010413          	addi	s0,sp,16
    80002554:	00100793          	li	a5,1
    80002558:	00f50863          	beq	a0,a5,80002568 <_Z41__static_initialization_and_destruction_0ii+0x20>
    8000255c:	00813403          	ld	s0,8(sp)
    80002560:	01010113          	addi	sp,sp,16
    80002564:	00008067          	ret
    80002568:	000107b7          	lui	a5,0x10
    8000256c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002570:	fef596e3          	bne	a1,a5,8000255c <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80002574:	00009797          	auipc	a5,0x9
    80002578:	98c7b783          	ld	a5,-1652(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000257c:	0007b703          	ld	a4,0(a5)
    80002580:	00c75793          	srli	a5,a4,0xc
    80002584:	00278793          	addi	a5,a5,2
    80002588:	00c79793          	slli	a5,a5,0xc
    8000258c:	00009697          	auipc	a3,0x9
    80002590:	b1468693          	addi	a3,a3,-1260 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002594:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002598:	fffff7b7          	lui	a5,0xfffff
    8000259c:	00f77733          	and	a4,a4,a5
    800025a0:	00e6b423          	sd	a4,8(a3)
    800025a4:	fb9ff06f          	j	8000255c <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800025a8 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    800025a8:	ff010113          	addi	sp,sp,-16
    800025ac:	00813423          	sd	s0,8(sp)
    800025b0:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    800025b4:	00009717          	auipc	a4,0x9
    800025b8:	aec70713          	addi	a4,a4,-1300 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025bc:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800025c0:	00009797          	auipc	a5,0x9
    800025c4:	9407b783          	ld	a5,-1728(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    800025c8:	0007b783          	ld	a5,0(a5)
    800025cc:	fffff6b7          	lui	a3,0xfffff
    800025d0:	00d7f7b3          	and	a5,a5,a3
    800025d4:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    800025d8:	00009797          	auipc	a5,0x9
    800025dc:	8eb7bc23          	sd	a1,-1800(a5) # 8000aed0 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    800025e0:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800025e4:	00000713          	li	a4,0
        while(num>1){
    800025e8:	00100693          	li	a3,1
    800025ec:	00f6f863          	bgeu	a3,a5,800025fc <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    800025f0:	0017d793          	srli	a5,a5,0x1
            deg++;
    800025f4:	00170713          	addi	a4,a4,1
        while(num>1){
    800025f8:	ff1ff06f          	j	800025e8 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    800025fc:	00371713          	slli	a4,a4,0x3
    80002600:	00009797          	auipc	a5,0x9
    80002604:	aa078793          	addi	a5,a5,-1376 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002608:	00e78733          	add	a4,a5,a4
    8000260c:	00a73823          	sd	a0,16(a4)
    80002610:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002614:	00000713          	li	a4,0
        while(num>1){
    80002618:	00100693          	li	a3,1
    8000261c:	00f6f863          	bgeu	a3,a5,8000262c <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80002620:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002624:	00170713          	addi	a4,a4,1
        while(num>1){
    80002628:	ff1ff06f          	j	80002618 <_ZN5Buddy10initializeEPvm+0x70>
    8000262c:	00371713          	slli	a4,a4,0x3
    80002630:	00009797          	auipc	a5,0x9
    80002634:	a7078793          	addi	a5,a5,-1424 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002638:	00e78733          	add	a4,a5,a4
    8000263c:	06a73c23          	sd	a0,120(a4)
    80002640:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002644:	00000713          	li	a4,0
        while(num>1){
    80002648:	00100693          	li	a3,1
    8000264c:	00f6f863          	bgeu	a3,a5,8000265c <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80002650:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002654:	00170713          	addi	a4,a4,1
        while(num>1){
    80002658:	ff1ff06f          	j	80002648 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    8000265c:	00371713          	slli	a4,a4,0x3
    80002660:	00009797          	auipc	a5,0x9
    80002664:	a4078793          	addi	a5,a5,-1472 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002668:	00e78733          	add	a4,a5,a4
    8000266c:	01073783          	ld	a5,16(a4)
    80002670:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80002674:	00000793          	li	a5,0
    80002678:	00c0006f          	j	80002684 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    8000267c:	0015d593          	srli	a1,a1,0x1
            deg++;
    80002680:	00178793          	addi	a5,a5,1
        while(num>1){
    80002684:	00100713          	li	a4,1
    80002688:	feb76ae3          	bltu	a4,a1,8000267c <_ZN5Buddy10initializeEPvm+0xd4>
    8000268c:	00379793          	slli	a5,a5,0x3
    80002690:	00009717          	auipc	a4,0x9
    80002694:	a1070713          	addi	a4,a4,-1520 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002698:	00f707b3          	add	a5,a4,a5
    8000269c:	0787b783          	ld	a5,120(a5)
    800026a0:	0007b023          	sd	zero,0(a5)
}
    800026a4:	00813403          	ld	s0,8(sp)
    800026a8:	01010113          	addi	sp,sp,16
    800026ac:	00008067          	ret

00000000800026b0 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    800026b0:	00c00793          	li	a5,12
    800026b4:	10f50063          	beq	a0,a5,800027b4 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    800026b8:	fd010113          	addi	sp,sp,-48
    800026bc:	02113423          	sd	ra,40(sp)
    800026c0:	02813023          	sd	s0,32(sp)
    800026c4:	00913c23          	sd	s1,24(sp)
    800026c8:	01213823          	sd	s2,16(sp)
    800026cc:	01313423          	sd	s3,8(sp)
    800026d0:	03010413          	addi	s0,sp,48
    800026d4:	00050913          	mv	s2,a0
    Block *curr = head[size];
    800026d8:	00351713          	slli	a4,a0,0x3
    800026dc:	00009797          	auipc	a5,0x9
    800026e0:	9c478793          	addi	a5,a5,-1596 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026e4:	00e787b3          	add	a5,a5,a4
    800026e8:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    800026ec:	00000993          	li	s3,0
    800026f0:	0180006f          	j	80002708 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    800026f4:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    800026f8:	04f70463          	beq	a4,a5,80002740 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    800026fc:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80002700:	08f70063          	beq	a4,a5,80002780 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80002704:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80002708:	08048863          	beqz	s1,80002798 <_ZN5Buddy8compressEm+0xe8>
    8000270c:	0004b683          	ld	a3,0(s1)
    80002710:	08068463          	beqz	a3,80002798 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002714:	00009797          	auipc	a5,0x9
    80002718:	98c7b783          	ld	a5,-1652(a5) # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000271c:	40f48733          	sub	a4,s1,a5
    80002720:	00c9061b          	addiw	a2,s2,12
    80002724:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002728:	40f687b3          	sub	a5,a3,a5
    8000272c:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002730:	00177613          	andi	a2,a4,1
    80002734:	fc0610e3          	bnez	a2,800026f4 <_ZN5Buddy8compressEm+0x44>
    80002738:	00170713          	addi	a4,a4,1
    8000273c:	fbdff06f          	j	800026f8 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80002740:	00098863          	beqz	s3,80002750 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    80002744:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffee000>
    80002748:	00d9b023          	sd	a3,0(s3)
    8000274c:	fb5ff06f          	j	80002700 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80002750:	0006b603          	ld	a2,0(a3)
    80002754:	00391593          	slli	a1,s2,0x3
    80002758:	00009697          	auipc	a3,0x9
    8000275c:	94868693          	addi	a3,a3,-1720 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002760:	00b686b3          	add	a3,a3,a1
    80002764:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    80002768:	f8061ce3          	bnez	a2,80002700 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    8000276c:	00009697          	auipc	a3,0x9
    80002770:	93468693          	addi	a3,a3,-1740 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002774:	00b686b3          	add	a3,a3,a1
    80002778:	0006b823          	sd	zero,16(a3)
    8000277c:	f85ff06f          	j	80002700 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80002780:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80002784:	00190593          	addi	a1,s2,1
    80002788:	00048513          	mv	a0,s1
    8000278c:	00000097          	auipc	ra,0x0
    80002790:	02c080e7          	jalr	44(ra) # 800027b8 <_ZN5Buddy6insertEPvm>
    80002794:	f71ff06f          	j	80002704 <_ZN5Buddy8compressEm+0x54>
}
    80002798:	02813083          	ld	ra,40(sp)
    8000279c:	02013403          	ld	s0,32(sp)
    800027a0:	01813483          	ld	s1,24(sp)
    800027a4:	01013903          	ld	s2,16(sp)
    800027a8:	00813983          	ld	s3,8(sp)
    800027ac:	03010113          	addi	sp,sp,48
    800027b0:	00008067          	ret
    800027b4:	00008067          	ret

00000000800027b8 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    800027b8:	00050693          	mv	a3,a0
    if(!head[size]){
    800027bc:	00359713          	slli	a4,a1,0x3
    800027c0:	00009797          	auipc	a5,0x9
    800027c4:	8e078793          	addi	a5,a5,-1824 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027c8:	00e787b3          	add	a5,a5,a4
    800027cc:	0787b783          	ld	a5,120(a5)
    800027d0:	02078c63          	beqz	a5,80002808 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    800027d4:	ff010113          	addi	sp,sp,-16
    800027d8:	00113423          	sd	ra,8(sp)
    800027dc:	00813023          	sd	s0,0(sp)
    800027e0:	01010413          	addi	s0,sp,16
    800027e4:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    800027e8:	00068713          	mv	a4,a3
    800027ec:	04f6e063          	bltu	a3,a5,8000282c <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    800027f0:	00000613          	li	a2,0
            while (iter != nullptr) {
    800027f4:	06078863          	beqz	a5,80002864 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    800027f8:	04f76c63          	bltu	a4,a5,80002850 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    800027fc:	00078613          	mv	a2,a5
                    iter = iter->next;
    80002800:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80002804:	ff1ff06f          	j	800027f4 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80002808:	00009797          	auipc	a5,0x9
    8000280c:	89878793          	addi	a5,a5,-1896 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002810:	00e78533          	add	a0,a5,a4
    80002814:	00d53823          	sd	a3,16(a0)
    80002818:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    8000281c:	0006b023          	sd	zero,0(a3)
    80002820:	07853783          	ld	a5,120(a0)
    80002824:	0007b023          	sd	zero,0(a5)
        return;
    80002828:	00008067          	ret
            newHead->next = head[size];
    8000282c:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80002830:	00359713          	slli	a4,a1,0x3
    80002834:	00009797          	auipc	a5,0x9
    80002838:	86c78793          	addi	a5,a5,-1940 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000283c:	00e787b3          	add	a5,a5,a4
    80002840:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80002844:	00000097          	auipc	ra,0x0
    80002848:	e6c080e7          	jalr	-404(ra) # 800026b0 <_ZN5Buddy8compressEm>
            return;
    8000284c:	0440006f          	j	80002890 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    80002850:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80002854:	00d63023          	sd	a3,0(a2)
                    compress(size);
    80002858:	00000097          	auipc	ra,0x0
    8000285c:	e58080e7          	jalr	-424(ra) # 800026b0 <_ZN5Buddy8compressEm>
                    return;
    80002860:	0300006f          	j	80002890 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    80002864:	00351713          	slli	a4,a0,0x3
    80002868:	00009797          	auipc	a5,0x9
    8000286c:	83878793          	addi	a5,a5,-1992 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002870:	00e787b3          	add	a5,a5,a4
    80002874:	0107b703          	ld	a4,16(a5)
    80002878:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    8000287c:	0107b703          	ld	a4,16(a5)
    80002880:	00073703          	ld	a4,0(a4)
    80002884:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80002888:	00000097          	auipc	ra,0x0
    8000288c:	e28080e7          	jalr	-472(ra) # 800026b0 <_ZN5Buddy8compressEm>
}
    80002890:	00813083          	ld	ra,8(sp)
    80002894:	00013403          	ld	s0,0(sp)
    80002898:	01010113          	addi	sp,sp,16
    8000289c:	00008067          	ret

00000000800028a0 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    800028a0:	02050663          	beqz	a0,800028cc <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    800028a4:	ff010113          	addi	sp,sp,-16
    800028a8:	00113423          	sd	ra,8(sp)
    800028ac:	00813023          	sd	s0,0(sp)
    800028b0:	01010413          	addi	s0,sp,16
    insert(addr,size);
    800028b4:	00000097          	auipc	ra,0x0
    800028b8:	f04080e7          	jalr	-252(ra) # 800027b8 <_ZN5Buddy6insertEPvm>
}
    800028bc:	00813083          	ld	ra,8(sp)
    800028c0:	00013403          	ld	s0,0(sp)
    800028c4:	01010113          	addi	sp,sp,16
    800028c8:	00008067          	ret
    800028cc:	00008067          	ret

00000000800028d0 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800028d0:	ff010113          	addi	sp,sp,-16
    800028d4:	00813423          	sd	s0,8(sp)
    800028d8:	01010413          	addi	s0,sp,16
    800028dc:	03c0006f          	j	80002918 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800028e0:	00b5859b          	addiw	a1,a1,11
    800028e4:	00100713          	li	a4,1
    800028e8:	00b715bb          	sllw	a1,a4,a1
    800028ec:	00b505b3          	add	a1,a0,a1
    800028f0:	00379693          	slli	a3,a5,0x3
    800028f4:	00008717          	auipc	a4,0x8
    800028f8:	7ac70713          	addi	a4,a4,1964 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800028fc:	00d70733          	add	a4,a4,a3
    80002900:	00b73823          	sd	a1,16(a4)
    80002904:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80002908:	0005b023          	sd	zero,0(a1)
    8000290c:	07873703          	ld	a4,120(a4)
    80002910:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002914:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80002918:	fff5879b          	addiw	a5,a1,-1
    8000291c:	04c7c863          	blt	a5,a2,8000296c <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80002920:	00379693          	slli	a3,a5,0x3
    80002924:	00008717          	auipc	a4,0x8
    80002928:	77c70713          	addi	a4,a4,1916 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000292c:	00d70733          	add	a4,a4,a3
    80002930:	01073683          	ld	a3,16(a4)
    80002934:	fa0686e3          	beqz	a3,800028e0 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002938:	00b5859b          	addiw	a1,a1,11
    8000293c:	00100713          	li	a4,1
    80002940:	00b715bb          	sllw	a1,a4,a1
    80002944:	00b505b3          	add	a1,a0,a1
    80002948:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    8000294c:	00379693          	slli	a3,a5,0x3
    80002950:	00008717          	auipc	a4,0x8
    80002954:	75070713          	addi	a4,a4,1872 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002958:	00d70733          	add	a4,a4,a3
    8000295c:	01073683          	ld	a3,16(a4)
    80002960:	0006b683          	ld	a3,0(a3)
    80002964:	00d73823          	sd	a3,16(a4)
    80002968:	fadff06f          	j	80002914 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    8000296c:	00813403          	ld	s0,8(sp)
    80002970:	01010113          	addi	sp,sp,16
    80002974:	00008067          	ret

0000000080002978 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80002978:	fe010113          	addi	sp,sp,-32
    8000297c:	00113c23          	sd	ra,24(sp)
    80002980:	00813823          	sd	s0,16(sp)
    80002984:	00913423          	sd	s1,8(sp)
    80002988:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    8000298c:	00c00793          	li	a5,12
    80002990:	06a7ec63          	bltu	a5,a0,80002a08 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002994:	00050593          	mv	a1,a0
    80002998:	00c00793          	li	a5,12
    8000299c:	06b7ea63          	bltu	a5,a1,80002a10 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    800029a0:	00359713          	slli	a4,a1,0x3
    800029a4:	00008797          	auipc	a5,0x8
    800029a8:	6fc78793          	addi	a5,a5,1788 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800029ac:	00e787b3          	add	a5,a5,a4
    800029b0:	0787b483          	ld	s1,120(a5)
    800029b4:	00049663          	bnez	s1,800029c0 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800029b8:	00158593          	addi	a1,a1,1
    800029bc:	fddff06f          	j	80002998 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    800029c0:	0004b703          	ld	a4,0(s1)
    800029c4:	00359693          	slli	a3,a1,0x3
    800029c8:	00008797          	auipc	a5,0x8
    800029cc:	6d878793          	addi	a5,a5,1752 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800029d0:	00d787b3          	add	a5,a5,a3
    800029d4:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    800029d8:	00070e63          	beqz	a4,800029f4 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    800029dc:	0005061b          	sext.w	a2,a0
    800029e0:	0005859b          	sext.w	a1,a1
    800029e4:	00048513          	mv	a0,s1
    800029e8:	00000097          	auipc	ra,0x0
    800029ec:	ee8080e7          	jalr	-280(ra) # 800028d0 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    800029f0:	0240006f          	j	80002a14 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    800029f4:	00008797          	auipc	a5,0x8
    800029f8:	6ac78793          	addi	a5,a5,1708 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800029fc:	00d787b3          	add	a5,a5,a3
    80002a00:	0007b823          	sd	zero,16(a5)
    80002a04:	fd9ff06f          	j	800029dc <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002a08:	00000493          	li	s1,0
    80002a0c:	0080006f          	j	80002a14 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80002a10:	00000493          	li	s1,0
}
    80002a14:	00048513          	mv	a0,s1
    80002a18:	01813083          	ld	ra,24(sp)
    80002a1c:	01013403          	ld	s0,16(sp)
    80002a20:	00813483          	ld	s1,8(sp)
    80002a24:	02010113          	addi	sp,sp,32
    80002a28:	00008067          	ret

0000000080002a2c <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002a2c:	fe010113          	addi	sp,sp,-32
    80002a30:	00113c23          	sd	ra,24(sp)
    80002a34:	00813823          	sd	s0,16(sp)
    80002a38:	00913423          	sd	s1,8(sp)
    80002a3c:	01213023          	sd	s2,0(sp)
    80002a40:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80002a44:	00000913          	li	s2,0
    80002a48:	0180006f          	j	80002a60 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002a4c:	00006517          	auipc	a0,0x6
    80002a50:	96450513          	addi	a0,a0,-1692 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80002a54:	00002097          	auipc	ra,0x2
    80002a58:	6b4080e7          	jalr	1716(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80002a5c:	0019091b          	addiw	s2,s2,1
    80002a60:	00c00793          	li	a5,12
    80002a64:	0727c663          	blt	a5,s2,80002ad0 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80002a68:	00000613          	li	a2,0
    80002a6c:	00a00593          	li	a1,10
    80002a70:	00090513          	mv	a0,s2
    80002a74:	00002097          	auipc	ra,0x2
    80002a78:	6d8080e7          	jalr	1752(ra) # 8000514c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80002a7c:	00006517          	auipc	a0,0x6
    80002a80:	88c50513          	addi	a0,a0,-1908 # 80008308 <CONSOLE_STATUS+0x2f8>
    80002a84:	00002097          	auipc	ra,0x2
    80002a88:	684080e7          	jalr	1668(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80002a8c:	00391713          	slli	a4,s2,0x3
    80002a90:	00008797          	auipc	a5,0x8
    80002a94:	61078793          	addi	a5,a5,1552 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002a98:	00e787b3          	add	a5,a5,a4
    80002a9c:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002aa0:	fa0486e3          	beqz	s1,80002a4c <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    80002aa4:	00000613          	li	a2,0
    80002aa8:	01000593          	li	a1,16
    80002aac:	0004851b          	sext.w	a0,s1
    80002ab0:	00002097          	auipc	ra,0x2
    80002ab4:	69c080e7          	jalr	1692(ra) # 8000514c <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002ab8:	00005517          	auipc	a0,0x5
    80002abc:	64050513          	addi	a0,a0,1600 # 800080f8 <CONSOLE_STATUS+0xe8>
    80002ac0:	00002097          	auipc	ra,0x2
    80002ac4:	648080e7          	jalr	1608(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002ac8:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002acc:	fd5ff06f          	j	80002aa0 <_ZN5Buddy9printListEv+0x74>
    80002ad0:	01813083          	ld	ra,24(sp)
    80002ad4:	01013403          	ld	s0,16(sp)
    80002ad8:	00813483          	ld	s1,8(sp)
    80002adc:	00013903          	ld	s2,0(sp)
    80002ae0:	02010113          	addi	sp,sp,32
    80002ae4:	00008067          	ret

0000000080002ae8 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002ae8:	ff010113          	addi	sp,sp,-16
    80002aec:	00113423          	sd	ra,8(sp)
    80002af0:	00813023          	sd	s0,0(sp)
    80002af4:	01010413          	addi	s0,sp,16
    80002af8:	000105b7          	lui	a1,0x10
    80002afc:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002b00:	00100513          	li	a0,1
    80002b04:	00000097          	auipc	ra,0x0
    80002b08:	a44080e7          	jalr	-1468(ra) # 80002548 <_Z41__static_initialization_and_destruction_0ii>
    80002b0c:	00813083          	ld	ra,8(sp)
    80002b10:	00013403          	ld	s0,0(sp)
    80002b14:	01010113          	addi	sp,sp,16
    80002b18:	00008067          	ret

0000000080002b1c <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80002b1c:	ff010113          	addi	sp,sp,-16
    80002b20:	00813423          	sd	s0,8(sp)
    80002b24:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002b28:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002b2c:	00053823          	sd	zero,16(a0)
}
    80002b30:	00813403          	ld	s0,8(sp)
    80002b34:	01010113          	addi	sp,sp,16
    80002b38:	00008067          	ret

0000000080002b3c <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80002b3c:	ff010113          	addi	sp,sp,-16
    80002b40:	00813423          	sd	s0,8(sp)
    80002b44:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002b48:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002b4c:	00053823          	sd	zero,16(a0)
    80002b50:	00813403          	ld	s0,8(sp)
    80002b54:	01010113          	addi	sp,sp,16
    80002b58:	00008067          	ret

0000000080002b5c <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    80002b5c:	ff010113          	addi	sp,sp,-16
    80002b60:	00113423          	sd	ra,8(sp)
    80002b64:	00813023          	sd	s0,0(sp)
    80002b68:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    80002b6c:	00000697          	auipc	a3,0x0
    80002b70:	fd068693          	addi	a3,a3,-48 # 80002b3c <_ZN3SCB4dtorEPv>
    80002b74:	00000617          	auipc	a2,0x0
    80002b78:	fa860613          	addi	a2,a2,-88 # 80002b1c <_ZN3SCB4ctorEPv>
    80002b7c:	01800593          	li	a1,24
    80002b80:	00005517          	auipc	a0,0x5
    80002b84:	79050513          	addi	a0,a0,1936 # 80008310 <CONSOLE_STATUS+0x300>
    80002b88:	00002097          	auipc	ra,0x2
    80002b8c:	75c080e7          	jalr	1884(ra) # 800052e4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002b90:	00008797          	auipc	a5,0x8
    80002b94:	5ea7b823          	sd	a0,1520(a5) # 8000b180 <_ZN3SCB8scbCacheE>
}
    80002b98:	00813083          	ld	ra,8(sp)
    80002b9c:	00013403          	ld	s0,0(sp)
    80002ba0:	01010113          	addi	sp,sp,16
    80002ba4:	00008067          	ret

0000000080002ba8 <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    80002ba8:	ff010113          	addi	sp,sp,-16
    80002bac:	00813423          	sd	s0,8(sp)
    80002bb0:	01010413          	addi	s0,sp,16
    val = init;
    80002bb4:	00b52023          	sw	a1,0(a0)
}
    80002bb8:	00813403          	ld	s0,8(sp)
    80002bbc:	01010113          	addi	sp,sp,16
    80002bc0:	00008067          	ret

0000000080002bc4 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80002bc4:	fe010113          	addi	sp,sp,-32
    80002bc8:	00113c23          	sd	ra,24(sp)
    80002bcc:	00813823          	sd	s0,16(sp)
    80002bd0:	00913423          	sd	s1,8(sp)
    80002bd4:	01213023          	sd	s2,0(sp)
    80002bd8:	02010413          	addi	s0,sp,32
    80002bdc:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002be0:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002be4:	02050063          	beqz	a0,80002c04 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80002be8:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002bec:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002bf0:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002bf4:	00002097          	auipc	ra,0x2
    80002bf8:	03c080e7          	jalr	60(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002bfc:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002c00:	fe5ff06f          	j	80002be4 <_ZN3SCBD1Ev+0x20>
}
    80002c04:	01813083          	ld	ra,24(sp)
    80002c08:	01013403          	ld	s0,16(sp)
    80002c0c:	00813483          	ld	s1,8(sp)
    80002c10:	00013903          	ld	s2,0(sp)
    80002c14:	02010113          	addi	sp,sp,32
    80002c18:	00008067          	ret

0000000080002c1c <_ZN3SCB5blockEv>:
void SCB::block() {
    80002c1c:	ff010113          	addi	sp,sp,-16
    80002c20:	00113423          	sd	ra,8(sp)
    80002c24:	00813023          	sd	s0,0(sp)
    80002c28:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002c2c:	00853783          	ld	a5,8(a0)
    80002c30:	04078063          	beqz	a5,80002c70 <_ZN3SCB5blockEv+0x54>
    80002c34:	01053703          	ld	a4,16(a0)
    80002c38:	00008797          	auipc	a5,0x8
    80002c3c:	3707b783          	ld	a5,880(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80002c40:	0007b783          	ld	a5,0(a5)
    80002c44:	04f73423          	sd	a5,72(a4)
    80002c48:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002c4c:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002c50:	00300713          	li	a4,3
    80002c54:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002c58:	00000097          	auipc	ra,0x0
    80002c5c:	314080e7          	jalr	788(ra) # 80002f6c <_ZN3TCB8dispatchEv>
}
    80002c60:	00813083          	ld	ra,8(sp)
    80002c64:	00013403          	ld	s0,0(sp)
    80002c68:	01010113          	addi	sp,sp,16
    80002c6c:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002c70:	00008797          	auipc	a5,0x8
    80002c74:	3387b783          	ld	a5,824(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80002c78:	0007b783          	ld	a5,0(a5)
    80002c7c:	00f53423          	sd	a5,8(a0)
    80002c80:	fc9ff06f          	j	80002c48 <_ZN3SCB5blockEv+0x2c>

0000000080002c84 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    80002c84:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002c88:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002c8c:	04853703          	ld	a4,72(a0)
    80002c90:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002c94:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002c98:	02050a63          	beqz	a0,80002ccc <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002c9c:	ff010113          	addi	sp,sp,-16
    80002ca0:	00113423          	sd	ra,8(sp)
    80002ca4:	00813023          	sd	s0,0(sp)
    80002ca8:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002cac:	00100793          	li	a5,1
    80002cb0:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002cb4:	00002097          	auipc	ra,0x2
    80002cb8:	f7c080e7          	jalr	-132(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>
}
    80002cbc:	00813083          	ld	ra,8(sp)
    80002cc0:	00013403          	ld	s0,0(sp)
    80002cc4:	01010113          	addi	sp,sp,16
    80002cc8:	00008067          	ret
    80002ccc:	00008067          	ret

0000000080002cd0 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80002cd0:	00008797          	auipc	a5,0x8
    80002cd4:	2d87b783          	ld	a5,728(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80002cd8:	0007b783          	ld	a5,0(a5)
    80002cdc:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002ce0:	00052783          	lw	a5,0(a0)
    80002ce4:	fff7879b          	addiw	a5,a5,-1
    80002ce8:	00f52023          	sw	a5,0(a0)
    80002cec:	02079713          	slli	a4,a5,0x20
    80002cf0:	00074463          	bltz	a4,80002cf8 <_ZN3SCB4waitEv+0x28>
    80002cf4:	00008067          	ret
void SCB::wait() {
    80002cf8:	ff010113          	addi	sp,sp,-16
    80002cfc:	00113423          	sd	ra,8(sp)
    80002d00:	00813023          	sd	s0,0(sp)
    80002d04:	01010413          	addi	s0,sp,16
        block();
    80002d08:	00000097          	auipc	ra,0x0
    80002d0c:	f14080e7          	jalr	-236(ra) # 80002c1c <_ZN3SCB5blockEv>
}
    80002d10:	00813083          	ld	ra,8(sp)
    80002d14:	00013403          	ld	s0,0(sp)
    80002d18:	01010113          	addi	sp,sp,16
    80002d1c:	00008067          	ret

0000000080002d20 <_ZN3SCB6signalEv>:
    if(val++<0)
    80002d20:	00052783          	lw	a5,0(a0)
    80002d24:	0017871b          	addiw	a4,a5,1
    80002d28:	00e52023          	sw	a4,0(a0)
    80002d2c:	0007c463          	bltz	a5,80002d34 <_ZN3SCB6signalEv+0x14>
    80002d30:	00008067          	ret
void SCB::signal(){
    80002d34:	ff010113          	addi	sp,sp,-16
    80002d38:	00113423          	sd	ra,8(sp)
    80002d3c:	00813023          	sd	s0,0(sp)
    80002d40:	01010413          	addi	s0,sp,16
        deblock();
    80002d44:	00000097          	auipc	ra,0x0
    80002d48:	f40080e7          	jalr	-192(ra) # 80002c84 <_ZN3SCB7deblockEv>
}
    80002d4c:	00813083          	ld	ra,8(sp)
    80002d50:	00013403          	ld	s0,0(sp)
    80002d54:	01010113          	addi	sp,sp,16
    80002d58:	00008067          	ret

0000000080002d5c <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    80002d5c:	ff010113          	addi	sp,sp,-16
    80002d60:	00113423          	sd	ra,8(sp)
    80002d64:	00813023          	sd	s0,0(sp)
    80002d68:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    80002d6c:	00008517          	auipc	a0,0x8
    80002d70:	41453503          	ld	a0,1044(a0) # 8000b180 <_ZN3SCB8scbCacheE>
    80002d74:	00002097          	auipc	ra,0x2
    80002d78:	598080e7          	jalr	1432(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
}
    80002d7c:	00813083          	ld	ra,8(sp)
    80002d80:	00013403          	ld	s0,0(sp)
    80002d84:	01010113          	addi	sp,sp,16
    80002d88:	00008067          	ret

0000000080002d8c <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    80002d8c:	ff010113          	addi	sp,sp,-16
    80002d90:	00113423          	sd	ra,8(sp)
    80002d94:	00813023          	sd	s0,0(sp)
    80002d98:	01010413          	addi	s0,sp,16
    80002d9c:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80002da0:	00008517          	auipc	a0,0x8
    80002da4:	3e053503          	ld	a0,992(a0) # 8000b180 <_ZN3SCB8scbCacheE>
    80002da8:	00002097          	auipc	ra,0x2
    80002dac:	58c080e7          	jalr	1420(ra) # 80005334 <_Z15kmem_cache_freeP5CachePv>
}
    80002db0:	00813083          	ld	ra,8(sp)
    80002db4:	00013403          	ld	s0,0(sp)
    80002db8:	01010113          	addi	sp,sp,16
    80002dbc:	00008067          	ret

0000000080002dc0 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80002dc0:	ff010113          	addi	sp,sp,-16
    80002dc4:	00813423          	sd	s0,8(sp)
    80002dc8:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002dcc:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002dd0:	05200513          	li	a0,82
    asm("ecall");
    80002dd4:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002dd8:	00050513          	mv	a0,a0
}
    80002ddc:	0005051b          	sext.w	a0,a0
    80002de0:	00813403          	ld	s0,8(sp)
    80002de4:	01010113          	addi	sp,sp,16
    80002de8:	00008067          	ret

0000000080002dec <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/kernel/system.hpp"

int main() {
    80002dec:	fe010113          	addi	sp,sp,-32
    80002df0:	00113c23          	sd	ra,24(sp)
    80002df4:	00813823          	sd	s0,16(sp)
    80002df8:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002dfc:	fe840513          	addi	a0,s0,-24
    80002e00:	fffff097          	auipc	ra,0xfffff
    80002e04:	530080e7          	jalr	1328(ra) # 80002330 <_ZN6SystemC1Ev>

    return 0;
    80002e08:	00000513          	li	a0,0
    80002e0c:	01813083          	ld	ra,24(sp)
    80002e10:	01013403          	ld	s0,16(sp)
    80002e14:	02010113          	addi	sp,sp,32
    80002e18:	00008067          	ret

0000000080002e1c <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80002e1c:	ff010113          	addi	sp,sp,-16
    80002e20:	00813423          	sd	s0,8(sp)
    80002e24:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002e28:	00100793          	li	a5,1
    80002e2c:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002e30:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002e34:	00052a23          	sw	zero,20(a0)
}
    80002e38:	00813403          	ld	s0,8(sp)
    80002e3c:	01010113          	addi	sp,sp,16
    80002e40:	00008067          	ret

0000000080002e44 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80002e44:	ff010113          	addi	sp,sp,-16
    80002e48:	00813423          	sd	s0,8(sp)
    80002e4c:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002e50:	00100793          	li	a5,1
    80002e54:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002e58:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002e5c:	00052a23          	sw	zero,20(a0)
    80002e60:	00813403          	ld	s0,8(sp)
    80002e64:	01010113          	addi	sp,sp,16
    80002e68:	00008067          	ret

0000000080002e6c <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80002e6c:	ff010113          	addi	sp,sp,-16
    80002e70:	00113423          	sd	ra,8(sp)
    80002e74:	00813023          	sd	s0,0(sp)
    80002e78:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002e7c:	00000097          	auipc	ra,0x0
    80002e80:	7a0080e7          	jalr	1952(ra) # 8000361c <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    80002e84:	00008797          	auipc	a5,0x8
    80002e88:	3047b783          	ld	a5,772(a5) # 8000b188 <_ZN3TCB7runningE>
    80002e8c:	0187b703          	ld	a4,24(a5)
    80002e90:	0207b503          	ld	a0,32(a5)
    80002e94:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    80002e98:	00001097          	auipc	ra,0x1
    80002e9c:	6ac080e7          	jalr	1708(ra) # 80004544 <_ZN5RiscV14threadExitUtilEv>
}
    80002ea0:	00813083          	ld	ra,8(sp)
    80002ea4:	00013403          	ld	s0,0(sp)
    80002ea8:	01010113          	addi	sp,sp,16
    80002eac:	00008067          	ret

0000000080002eb0 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002eb0:	ff010113          	addi	sp,sp,-16
    80002eb4:	00813423          	sd	s0,8(sp)
    80002eb8:	01010413          	addi	s0,sp,16
    80002ebc:	04053823          	sd	zero,80(a0)
    80002ec0:	04053c23          	sd	zero,88(a0)
    80002ec4:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002ec8:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002ecc:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002ed0:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002ed4:	02058a63          	beqz	a1,80002f08 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80002ed8:	00068793          	mv	a5,a3
    80002edc:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002ee0:	02058863          	beqz	a1,80002f10 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80002ee4:	000017b7          	lui	a5,0x1
    80002ee8:	00f686b3          	add	a3,a3,a5
    80002eec:	00d53023          	sd	a3,0(a0)
    80002ef0:	00000797          	auipc	a5,0x0
    80002ef4:	f7c78793          	addi	a5,a5,-132 # 80002e6c <_ZN3TCB7wrapperEPv>
    80002ef8:	00f53423          	sd	a5,8(a0)
}
    80002efc:	00813403          	ld	s0,8(sp)
    80002f00:	01010113          	addi	sp,sp,16
    80002f04:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002f08:	00000793          	li	a5,0
    80002f0c:	fd1ff06f          	j	80002edc <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002f10:	00000693          	li	a3,0
    80002f14:	fd9ff06f          	j	80002eec <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080002f18 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002f18:	ff010113          	addi	sp,sp,-16
    80002f1c:	00113423          	sd	ra,8(sp)
    80002f20:	00813023          	sd	s0,0(sp)
    80002f24:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002f28:	02853503          	ld	a0,40(a0)
    80002f2c:	00002097          	auipc	ra,0x2
    80002f30:	4d8080e7          	jalr	1240(ra) # 80005404 <_Z5kfreePKv>
}
    80002f34:	00813083          	ld	ra,8(sp)
    80002f38:	00013403          	ld	s0,0(sp)
    80002f3c:	01010113          	addi	sp,sp,16
    80002f40:	00008067          	ret

0000000080002f44 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002f44:	ff010113          	addi	sp,sp,-16
    80002f48:	00113423          	sd	ra,8(sp)
    80002f4c:	00813023          	sd	s0,0(sp)
    80002f50:	01010413          	addi	s0,sp,16
    free();
    80002f54:	00000097          	auipc	ra,0x0
    80002f58:	fc4080e7          	jalr	-60(ra) # 80002f18 <_ZN3TCB4freeEv>
}
    80002f5c:	00813083          	ld	ra,8(sp)
    80002f60:	00013403          	ld	s0,0(sp)
    80002f64:	01010113          	addi	sp,sp,16
    80002f68:	00008067          	ret

0000000080002f6c <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002f6c:	fe010113          	addi	sp,sp,-32
    80002f70:	00113c23          	sd	ra,24(sp)
    80002f74:	00813823          	sd	s0,16(sp)
    80002f78:	00913423          	sd	s1,8(sp)
    80002f7c:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002f80:	00008497          	auipc	s1,0x8
    80002f84:	2084b483          	ld	s1,520(s1) # 8000b188 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002f88:	0104a703          	lw	a4,16(s1)
    80002f8c:	00100793          	li	a5,1
    80002f90:	04e7f663          	bgeu	a5,a4,80002fdc <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002f94:	00002097          	auipc	ra,0x2
    80002f98:	ce4080e7          	jalr	-796(ra) # 80004c78 <_ZN9Scheduler3getEv>
    80002f9c:	00008797          	auipc	a5,0x8
    80002fa0:	1ea7b623          	sd	a0,492(a5) # 8000b188 <_ZN3TCB7runningE>
    if(running) {
    80002fa4:	02050263          	beqz	a0,80002fc8 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002fa8:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002fac:	00000097          	auipc	ra,0x0
    80002fb0:	754080e7          	jalr	1876(ra) # 80003700 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002fb4:	00008597          	auipc	a1,0x8
    80002fb8:	1d45b583          	ld	a1,468(a1) # 8000b188 <_ZN3TCB7runningE>
    80002fbc:	00048513          	mv	a0,s1
    80002fc0:	ffffe097          	auipc	ra,0xffffe
    80002fc4:	160080e7          	jalr	352(ra) # 80001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002fc8:	01813083          	ld	ra,24(sp)
    80002fcc:	01013403          	ld	s0,16(sp)
    80002fd0:	00813483          	ld	s1,8(sp)
    80002fd4:	02010113          	addi	sp,sp,32
    80002fd8:	00008067          	ret
        Scheduler::put(old);
    80002fdc:	00048513          	mv	a0,s1
    80002fe0:	00002097          	auipc	ra,0x2
    80002fe4:	c50080e7          	jalr	-944(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>
    80002fe8:	fadff06f          	j	80002f94 <_ZN3TCB8dispatchEv+0x28>

0000000080002fec <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002fec:	ff010113          	addi	sp,sp,-16
    80002ff0:	00113423          	sd	ra,8(sp)
    80002ff4:	00813023          	sd	s0,0(sp)
    80002ff8:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002ffc:	00008517          	auipc	a0,0x8
    80003000:	19453503          	ld	a0,404(a0) # 8000b190 <_ZN3TCB8tcbCacheE>
    80003004:	00002097          	auipc	ra,0x2
    80003008:	308080e7          	jalr	776(ra) # 8000530c <_Z16kmem_cache_allocP5Cache>
}
    8000300c:	00813083          	ld	ra,8(sp)
    80003010:	00013403          	ld	s0,0(sp)
    80003014:	01010113          	addi	sp,sp,16
    80003018:	00008067          	ret

000000008000301c <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    8000301c:	fe010113          	addi	sp,sp,-32
    80003020:	00113c23          	sd	ra,24(sp)
    80003024:	00813823          	sd	s0,16(sp)
    80003028:	00913423          	sd	s1,8(sp)
    8000302c:	01213023          	sd	s2,0(sp)
    80003030:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    80003034:	00000697          	auipc	a3,0x0
    80003038:	e1068693          	addi	a3,a3,-496 # 80002e44 <_ZN3TCB4dtorEPv>
    8000303c:	00000617          	auipc	a2,0x0
    80003040:	de060613          	addi	a2,a2,-544 # 80002e1c <_ZN3TCB4ctorEPv>
    80003044:	07000593          	li	a1,112
    80003048:	00005517          	auipc	a0,0x5
    8000304c:	2d850513          	addi	a0,a0,728 # 80008320 <CONSOLE_STATUS+0x310>
    80003050:	00002097          	auipc	ra,0x2
    80003054:	294080e7          	jalr	660(ra) # 800052e4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80003058:	00008797          	auipc	a5,0x8
    8000305c:	12a7bc23          	sd	a0,312(a5) # 8000b190 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80003060:	07000513          	li	a0,112
    80003064:	00000097          	auipc	ra,0x0
    80003068:	f88080e7          	jalr	-120(ra) # 80002fec <_ZN3TCBnwEm>
    8000306c:	00050493          	mv	s1,a0
    80003070:	00050e63          	beqz	a0,8000308c <_ZN3TCB10initializeEv+0x70>
    80003074:	00200713          	li	a4,2
    80003078:	00000693          	li	a3,0
    8000307c:	00000613          	li	a2,0
    80003080:	00000593          	li	a1,0
    80003084:	00000097          	auipc	ra,0x0
    80003088:	e2c080e7          	jalr	-468(ra) # 80002eb0 <_ZN3TCBC1EPFvPvES0_Pmm>
    8000308c:	00008797          	auipc	a5,0x8
    80003090:	0e97be23          	sd	s1,252(a5) # 8000b188 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    80003094:	00100793          	li	a5,1
    80003098:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    8000309c:	00001537          	lui	a0,0x1
    800030a0:	00002097          	auipc	ra,0x2
    800030a4:	33c080e7          	jalr	828(ra) # 800053dc <_Z7kmallocm>
    800030a8:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    800030ac:	07000513          	li	a0,112
    800030b0:	00000097          	auipc	ra,0x0
    800030b4:	f3c080e7          	jalr	-196(ra) # 80002fec <_ZN3TCBnwEm>
    800030b8:	00050493          	mv	s1,a0
    800030bc:	02050063          	beqz	a0,800030dc <_ZN3TCB10initializeEv+0xc0>
    800030c0:	00200713          	li	a4,2
    800030c4:	00090693          	mv	a3,s2
    800030c8:	00000613          	li	a2,0
    800030cc:	00008597          	auipc	a1,0x8
    800030d0:	e645b583          	ld	a1,-412(a1) # 8000af30 <_GLOBAL_OFFSET_TABLE_+0x48>
    800030d4:	00000097          	auipc	ra,0x0
    800030d8:	ddc080e7          	jalr	-548(ra) # 80002eb0 <_ZN3TCBC1EPFvPvES0_Pmm>
    800030dc:	00008797          	auipc	a5,0x8
    800030e0:	0a97be23          	sd	s1,188(a5) # 8000b198 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    800030e4:	00100793          	li	a5,1
    800030e8:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    800030ec:	00048513          	mv	a0,s1
    800030f0:	00002097          	auipc	ra,0x2
    800030f4:	b40080e7          	jalr	-1216(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>
}
    800030f8:	01813083          	ld	ra,24(sp)
    800030fc:	01013403          	ld	s0,16(sp)
    80003100:	00813483          	ld	s1,8(sp)
    80003104:	00013903          	ld	s2,0(sp)
    80003108:	02010113          	addi	sp,sp,32
    8000310c:	00008067          	ret

0000000080003110 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    80003110:	ff010113          	addi	sp,sp,-16
    80003114:	00113423          	sd	ra,8(sp)
    80003118:	00813023          	sd	s0,0(sp)
    8000311c:	01010413          	addi	s0,sp,16
    80003120:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    80003124:	00008517          	auipc	a0,0x8
    80003128:	06c53503          	ld	a0,108(a0) # 8000b190 <_ZN3TCB8tcbCacheE>
    8000312c:	00002097          	auipc	ra,0x2
    80003130:	208080e7          	jalr	520(ra) # 80005334 <_Z15kmem_cache_freeP5CachePv>
}
    80003134:	00813083          	ld	ra,8(sp)
    80003138:	00013403          	ld	s0,0(sp)
    8000313c:	01010113          	addi	sp,sp,16
    80003140:	00008067          	ret

0000000080003144 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    80003144:	ff010113          	addi	sp,sp,-16
    80003148:	00813423          	sd	s0,8(sp)
    8000314c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80003150:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80003154:	05100513          	li	a0,81
    asm("ecall");
    80003158:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000315c:	00050513          	mv	a0,a0
}
    80003160:	0005051b          	sext.w	a0,a0
    80003164:	00813403          	ld	s0,8(sp)
    80003168:	01010113          	addi	sp,sp,16
    8000316c:	00008067          	ret

0000000080003170 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80003170:	ff010113          	addi	sp,sp,-16
    80003174:	00813423          	sd	s0,8(sp)
    80003178:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    8000317c:	00008797          	auipc	a5,0x8
    80003180:	d847b783          	ld	a5,-636(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003184:	0007b783          	ld	a5,0(a5)
    80003188:	00c7d793          	srli	a5,a5,0xc
    8000318c:	00278793          	addi	a5,a5,2
    80003190:	00c79793          	slli	a5,a5,0xc
    80003194:	01000737          	lui	a4,0x1000
    80003198:	00e787b3          	add	a5,a5,a4
    8000319c:	00008717          	auipc	a4,0x8
    800031a0:	01c70713          	addi	a4,a4,28 # 8000b1b8 <_ZN15MemoryAllocator11freeMemTailE>
    800031a4:	00f73023          	sd	a5,0(a4)
    800031a8:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    800031ac:	0007b823          	sd	zero,16(a5)
    800031b0:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    800031b4:	00073823          	sd	zero,16(a4)
    800031b8:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    800031bc:	00008697          	auipc	a3,0x8
    800031c0:	e046b683          	ld	a3,-508(a3) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    800031c4:	0006b683          	ld	a3,0(a3)
    800031c8:	40f686b3          	sub	a3,a3,a5
    800031cc:	fe868693          	addi	a3,a3,-24
    800031d0:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800031d4:	00873783          	ld	a5,8(a4)
    800031d8:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800031dc:	00100793          	li	a5,1
    800031e0:	02f70023          	sb	a5,32(a4)
}
    800031e4:	00813403          	ld	s0,8(sp)
    800031e8:	01010113          	addi	sp,sp,16
    800031ec:	00008067          	ret

00000000800031f0 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800031f0:	ff010113          	addi	sp,sp,-16
    800031f4:	00813423          	sd	s0,8(sp)
    800031f8:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    800031fc:	14050663          	beqz	a0,80003348 <_ZN15MemoryAllocator7kmallocEm+0x158>
    80003200:	00050793          	mv	a5,a0
    80003204:	00008517          	auipc	a0,0x8
    80003208:	fbc53503          	ld	a0,-68(a0) # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    8000320c:	0a050e63          	beqz	a0,800032c8 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80003210:	00053703          	ld	a4,0(a0)
    80003214:	12f76e63          	bltu	a4,a5,80003350 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80003218:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    8000321c:	00000613          	li	a2,0
    80003220:	00c0006f          	j	8000322c <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80003224:	00050613          	mv	a2,a0
    80003228:	01053503          	ld	a0,16(a0)
    8000322c:	00050863          	beqz	a0,8000323c <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80003230:	00053683          	ld	a3,0(a0)
    80003234:	01878713          	addi	a4,a5,24
    80003238:	fee6e6e3          	bltu	a3,a4,80003224 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    8000323c:	08050663          	beqz	a0,800032c8 <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    80003240:	00053683          	ld	a3,0(a0)
    80003244:	01868713          	addi	a4,a3,24
    80003248:	00e50733          	add	a4,a0,a4
    8000324c:	00008597          	auipc	a1,0x8
    80003250:	d745b583          	ld	a1,-652(a1) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80003254:	0005b583          	ld	a1,0(a1)
    80003258:	00b76463          	bltu	a4,a1,80003260 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    8000325c:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80003260:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80003264:	05700593          	li	a1,87
    80003268:	08d5f063          	bgeu	a1,a3,800032e8 <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    8000326c:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80003270:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80003274:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80003278:	01053583          	ld	a1,16(a0)
    8000327c:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80003280:	00853583          	ld	a1,8(a0)
    80003284:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80003288:	fe868693          	addi	a3,a3,-24
    8000328c:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80003290:	04060263          	beqz	a2,800032d4 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80003294:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80003298:	00008797          	auipc	a5,0x8
    8000329c:	f387b783          	ld	a5,-200(a5) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    800032a0:	06078463          	beqz	a5,80003308 <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    800032a4:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    800032a8:	08070063          	beqz	a4,80003328 <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    800032ac:	00873783          	ld	a5,8(a4)
    800032b0:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    800032b4:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    800032b8:	00873783          	ld	a5,8(a4)
    800032bc:	06078063          	beqz	a5,8000331c <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    800032c0:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    800032c4:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    800032c8:	00813403          	ld	s0,8(sp)
    800032cc:	01010113          	addi	sp,sp,16
    800032d0:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    800032d4:	00008697          	auipc	a3,0x8
    800032d8:	ee468693          	addi	a3,a3,-284 # 8000b1b8 <_ZN15MemoryAllocator11freeMemTailE>
    800032dc:	00f6b023          	sd	a5,0(a3)
    800032e0:	00f6b423          	sd	a5,8(a3)
    800032e4:	fb5ff06f          	j	80003298 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    800032e8:	00060863          	beqz	a2,800032f8 <_ZN15MemoryAllocator7kmallocEm+0x108>
    800032ec:	01053783          	ld	a5,16(a0)
    800032f0:	00f63823          	sd	a5,16(a2)
    800032f4:	fa5ff06f          	j	80003298 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    800032f8:	01053783          	ld	a5,16(a0)
    800032fc:	00008697          	auipc	a3,0x8
    80003300:	ecf6b223          	sd	a5,-316(a3) # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003304:	f95ff06f          	j	80003298 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    80003308:	00008797          	auipc	a5,0x8
    8000330c:	eb078793          	addi	a5,a5,-336 # 8000b1b8 <_ZN15MemoryAllocator11freeMemTailE>
    80003310:	00a7b823          	sd	a0,16(a5)
    80003314:	00a7bc23          	sd	a0,24(a5)
    80003318:	fadff06f          	j	800032c4 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    8000331c:	00008797          	auipc	a5,0x8
    80003320:	eaa7ba23          	sd	a0,-332(a5) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    80003324:	fa1ff06f          	j	800032c4 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    80003328:	00008797          	auipc	a5,0x8
    8000332c:	e9078793          	addi	a5,a5,-368 # 8000b1b8 <_ZN15MemoryAllocator11freeMemTailE>
    80003330:	0107b703          	ld	a4,16(a5)
    80003334:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80003338:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    8000333c:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80003340:	00a7b823          	sd	a0,16(a5)
    80003344:	f81ff06f          	j	800032c4 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    80003348:	00000513          	li	a0,0
    8000334c:	f7dff06f          	j	800032c8 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80003350:	00000513          	li	a0,0
    80003354:	f75ff06f          	j	800032c8 <_ZN15MemoryAllocator7kmallocEm+0xd8>

0000000080003358 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80003358:	ff010113          	addi	sp,sp,-16
    8000335c:	00813423          	sd	s0,8(sp)
    80003360:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80003364:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003368:	00000713          	li	a4,0
    8000336c:	00078a63          	beqz	a5,80003380 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80003370:	00a7f863          	bgeu	a5,a0,80003380 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003374:	00078713          	mv	a4,a5
    80003378:	0107b783          	ld	a5,16(a5)
    8000337c:	ff1ff06f          	j	8000336c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80003380:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80003384:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80003388:	00078463          	beqz	a5,80003390 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    8000338c:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80003390:	02070263          	beqz	a4,800033b4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003394:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80003398:	0005b703          	ld	a4,0(a1)
    8000339c:	00008797          	auipc	a5,0x8
    800033a0:	e247b783          	ld	a5,-476(a5) # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    800033a4:	00f70c63          	beq	a4,a5,800033bc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    800033a8:	00813403          	ld	s0,8(sp)
    800033ac:	01010113          	addi	sp,sp,16
    800033b0:	00008067          	ret
        *head = blk;
    800033b4:	00a5b023          	sd	a0,0(a1)
    800033b8:	fe1ff06f          	j	80003398 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    800033bc:	01053783          	ld	a5,16(a0)
    800033c0:	00078a63          	beqz	a5,800033d4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    800033c4:	00053683          	ld	a3,0(a0)
    800033c8:	00d50733          	add	a4,a0,a3
    800033cc:	01870713          	addi	a4,a4,24
    800033d0:	02f70e63          	beq	a4,a5,8000340c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    800033d4:	00853783          	ld	a5,8(a0)
    800033d8:	fc0788e3          	beqz	a5,800033a8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    800033dc:	0007b683          	ld	a3,0(a5)
    800033e0:	00d78733          	add	a4,a5,a3
    800033e4:	01870713          	addi	a4,a4,24
    800033e8:	fca710e3          	bne	a4,a0,800033a8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    800033ec:	00053703          	ld	a4,0(a0)
    800033f0:	00e68733          	add	a4,a3,a4
    800033f4:	01870713          	addi	a4,a4,24
    800033f8:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    800033fc:	00853783          	ld	a5,8(a0)
    80003400:	01053703          	ld	a4,16(a0)
    80003404:	00e7b823          	sd	a4,16(a5)
}
    80003408:	fa1ff06f          	j	800033a8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    8000340c:	0007b703          	ld	a4,0(a5)
    80003410:	00e68733          	add	a4,a3,a4
    80003414:	01870713          	addi	a4,a4,24
    80003418:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    8000341c:	0107b783          	ld	a5,16(a5)
    80003420:	00f53823          	sd	a5,16(a0)
    80003424:	fb1ff06f          	j	800033d4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080003428 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80003428:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    8000342c:	00008697          	auipc	a3,0x8
    80003430:	da46b683          	ld	a3,-604(a3) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    80003434:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80003438:	00050a63          	beqz	a0,8000344c <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    8000343c:	fe870793          	addi	a5,a4,-24
    80003440:	00a78663          	beq	a5,a0,8000344c <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80003444:	01053503          	ld	a0,16(a0)
    80003448:	ff1ff06f          	j	80003438 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    8000344c:	08050463          	beqz	a0,800034d4 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80003450:	ff010113          	addi	sp,sp,-16
    80003454:	00113423          	sd	ra,8(sp)
    80003458:	00813023          	sd	s0,0(sp)
    8000345c:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80003460:	00008797          	auipc	a5,0x8
    80003464:	d687b783          	ld	a5,-664(a5) # 8000b1c8 <_ZN15MemoryAllocator12allocMemTailE>
    80003468:	04a78663          	beq	a5,a0,800034b4 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    8000346c:	04d50c63          	beq	a0,a3,800034c4 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80003470:	01053783          	ld	a5,16(a0)
    80003474:	00078663          	beqz	a5,80003480 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80003478:	00853703          	ld	a4,8(a0)
    8000347c:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80003480:	00853783          	ld	a5,8(a0)
    80003484:	00078663          	beqz	a5,80003490 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80003488:	01053703          	ld	a4,16(a0)
    8000348c:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80003490:	00008597          	auipc	a1,0x8
    80003494:	d3058593          	addi	a1,a1,-720 # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003498:	00000097          	auipc	ra,0x0
    8000349c:	ec0080e7          	jalr	-320(ra) # 80003358 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    800034a0:	00000513          	li	a0,0
}
    800034a4:	00813083          	ld	ra,8(sp)
    800034a8:	00013403          	ld	s0,0(sp)
    800034ac:	01010113          	addi	sp,sp,16
    800034b0:	00008067          	ret
            allocMemTail = blk->prev;
    800034b4:	00853783          	ld	a5,8(a0)
    800034b8:	00008717          	auipc	a4,0x8
    800034bc:	d0f73823          	sd	a5,-752(a4) # 8000b1c8 <_ZN15MemoryAllocator12allocMemTailE>
    800034c0:	fadff06f          	j	8000346c <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    800034c4:	01053783          	ld	a5,16(a0)
    800034c8:	00008717          	auipc	a4,0x8
    800034cc:	d0f73423          	sd	a5,-760(a4) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    800034d0:	fa1ff06f          	j	80003470 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    800034d4:	fff00513          	li	a0,-1
}
    800034d8:	00008067          	ret

00000000800034dc <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    800034dc:	fe010113          	addi	sp,sp,-32
    800034e0:	00113c23          	sd	ra,24(sp)
    800034e4:	00813823          	sd	s0,16(sp)
    800034e8:	00913423          	sd	s1,8(sp)
    800034ec:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    800034f0:	00008497          	auipc	s1,0x8
    800034f4:	ce04b483          	ld	s1,-800(s1) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    800034f8:	00005517          	auipc	a0,0x5
    800034fc:	e3850513          	addi	a0,a0,-456 # 80008330 <CONSOLE_STATUS+0x320>
    80003500:	0000b097          	auipc	ra,0xb
    80003504:	76c080e7          	jalr	1900(ra) # 8000ec6c <_Z11printStringPKc>
    while(iter!=nullptr){
    80003508:	04048663          	beqz	s1,80003554 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    8000350c:	00000613          	li	a2,0
    80003510:	00a00593          	li	a1,10
    80003514:	0004851b          	sext.w	a0,s1
    80003518:	0000c097          	auipc	ra,0xc
    8000351c:	8ec080e7          	jalr	-1812(ra) # 8000ee04 <_Z8printIntiii>
        putc(' ');
    80003520:	02000513          	li	a0,32
    80003524:	0000a097          	auipc	ra,0xa
    80003528:	e08080e7          	jalr	-504(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    8000352c:	00000613          	li	a2,0
    80003530:	00a00593          	li	a1,10
    80003534:	0004a503          	lw	a0,0(s1)
    80003538:	0000c097          	auipc	ra,0xc
    8000353c:	8cc080e7          	jalr	-1844(ra) # 8000ee04 <_Z8printIntiii>
        putc('\n');
    80003540:	00a00513          	li	a0,10
    80003544:	0000a097          	auipc	ra,0xa
    80003548:	de8080e7          	jalr	-536(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    8000354c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003550:	fb9ff06f          	j	80003508 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80003554:	00005517          	auipc	a0,0x5
    80003558:	dfc50513          	addi	a0,a0,-516 # 80008350 <CONSOLE_STATUS+0x340>
    8000355c:	0000b097          	auipc	ra,0xb
    80003560:	710080e7          	jalr	1808(ra) # 8000ec6c <_Z11printStringPKc>
    iter = freeMemHead;
    80003564:	00008497          	auipc	s1,0x8
    80003568:	c5c4b483          	ld	s1,-932(s1) # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    8000356c:	04048663          	beqz	s1,800035b8 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80003570:	00000613          	li	a2,0
    80003574:	00a00593          	li	a1,10
    80003578:	0004851b          	sext.w	a0,s1
    8000357c:	0000c097          	auipc	ra,0xc
    80003580:	888080e7          	jalr	-1912(ra) # 8000ee04 <_Z8printIntiii>
        putc(' ');
    80003584:	02000513          	li	a0,32
    80003588:	0000a097          	auipc	ra,0xa
    8000358c:	da4080e7          	jalr	-604(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    80003590:	00000613          	li	a2,0
    80003594:	00a00593          	li	a1,10
    80003598:	0004a503          	lw	a0,0(s1)
    8000359c:	0000c097          	auipc	ra,0xc
    800035a0:	868080e7          	jalr	-1944(ra) # 8000ee04 <_Z8printIntiii>
        putc('\n');
    800035a4:	00a00513          	li	a0,10
    800035a8:	0000a097          	auipc	ra,0xa
    800035ac:	d84080e7          	jalr	-636(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    800035b0:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800035b4:	fb9ff06f          	j	8000356c <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    800035b8:	00005517          	auipc	a0,0x5
    800035bc:	db850513          	addi	a0,a0,-584 # 80008370 <CONSOLE_STATUS+0x360>
    800035c0:	0000b097          	auipc	ra,0xb
    800035c4:	6ac080e7          	jalr	1708(ra) # 8000ec6c <_Z11printStringPKc>
}
    800035c8:	01813083          	ld	ra,24(sp)
    800035cc:	01013403          	ld	s0,16(sp)
    800035d0:	00813483          	ld	s1,8(sp)
    800035d4:	02010113          	addi	sp,sp,32
    800035d8:	00008067          	ret

00000000800035dc <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    800035dc:	ff010113          	addi	sp,sp,-16
    800035e0:	00813423          	sd	s0,8(sp)
    800035e4:	01010413          	addi	s0,sp,16
    800035e8:	00050813          	mv	a6,a0
    800035ec:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    800035f0:	00000793          	li	a5,0
    800035f4:	00c7fe63          	bgeu	a5,a2,80003610 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    800035f8:	00f50733          	add	a4,a0,a5
    800035fc:	00f806b3          	add	a3,a6,a5
    80003600:	0006c683          	lbu	a3,0(a3)
    80003604:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80003608:	00178793          	addi	a5,a5,1
    8000360c:	fe9ff06f          	j	800035f4 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80003610:	00813403          	ld	s0,8(sp)
    80003614:	01010113          	addi	sp,sp,16
    80003618:	00008067          	ret

000000008000361c <_ZN5RiscV10popSppSpieEv>:
    RiscV::startVirtualMemory(RiscV::kPMT);
    RiscV::enableInterrupts();
}

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    8000361c:	ff010113          	addi	sp,sp,-16
    80003620:	00813423          	sd	s0,8(sp)
    80003624:	01010413          	addi	s0,sp,16
    uint64 ra = 0;
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80003628:	00008797          	auipc	a5,0x8
    8000362c:	9807b783          	ld	a5,-1664(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003630:	0007b783          	ld	a5,0(a5)
    80003634:	0147a683          	lw	a3,20(a5)
    80003638:	00100713          	li	a4,1
    8000363c:	02e68863          	beq	a3,a4,8000366c <_ZN5RiscV10popSppSpieEv+0x50>
        asm("csrw sepc, ra");
    else
    {
        ra = (uint64)bodyWrapper;
        asm("mv a0, %[iarg]" : : [iarg] "r" (TCB::running->body));
    80003640:	0187b703          	ld	a4,24(a5)
    80003644:	00070513          	mv	a0,a4
        asm("mv a1, %[iarg]" : : [iarg] "r" (TCB::running->args));
    80003648:	0207b783          	ld	a5,32(a5)
    8000364c:	00078593          	mv	a1,a5
        asm("csrw sepc, %[ra]" : : [ra] "r" (ra));
    80003650:	00008797          	auipc	a5,0x8
    80003654:	9507b783          	ld	a5,-1712(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003658:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    8000365c:	10200073          	sret
}
    80003660:	00813403          	ld	s0,8(sp)
    80003664:	01010113          	addi	sp,sp,16
    80003668:	00008067          	ret
        asm("csrw sepc, ra");
    8000366c:	14109073          	csrw	sepc,ra
    80003670:	fedff06f          	j	8000365c <_ZN5RiscV10popSppSpieEv+0x40>

0000000080003674 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003674:	ff010113          	addi	sp,sp,-16
    80003678:	00113423          	sd	ra,8(sp)
    8000367c:	00813023          	sd	s0,0(sp)
    80003680:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003684:	00008797          	auipc	a5,0x8
    80003688:	9247b783          	ld	a5,-1756(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    8000368c:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003690:	00100713          	li	a4,1
    80003694:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003698:	00000097          	auipc	ra,0x0
    8000369c:	8d4080e7          	jalr	-1836(ra) # 80002f6c <_ZN3TCB8dispatchEv>
}
    800036a0:	00813083          	ld	ra,8(sp)
    800036a4:	00013403          	ld	s0,0(sp)
    800036a8:	01010113          	addi	sp,sp,16
    800036ac:	00008067          	ret

00000000800036b0 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    800036b0:	ff010113          	addi	sp,sp,-16
    800036b4:	00113423          	sd	ra,8(sp)
    800036b8:	00813023          	sd	s0,0(sp)
    800036bc:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    800036c0:	00008797          	auipc	a5,0x8
    800036c4:	b207c783          	lbu	a5,-1248(a5) # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    800036c8:	00079c63          	bnez	a5,800036e0 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    800036cc:	00008717          	auipc	a4,0x8
    800036d0:	8cc73703          	ld	a4,-1844(a4) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800036d4:	00073783          	ld	a5,0(a4)
    800036d8:	00178793          	addi	a5,a5,1
    800036dc:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    800036e0:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    800036e4:	0ff57513          	andi	a0,a0,255
    800036e8:	00002097          	auipc	ra,0x2
    800036ec:	918080e7          	jalr	-1768(ra) # 80005000 <_ZN11ConsoleUtil9putOutputEc>
}
    800036f0:	00813083          	ld	ra,8(sp)
    800036f4:	00013403          	ld	s0,0(sp)
    800036f8:	01010113          	addi	sp,sp,16
    800036fc:	00008067          	ret

0000000080003700 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003700:	ff010113          	addi	sp,sp,-16
    80003704:	00813423          	sd	s0,8(sp)
    80003708:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    8000370c:	00008797          	auipc	a5,0x8
    80003710:	89c7b783          	ld	a5,-1892(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003714:	0007b783          	ld	a5,0(a5)
    80003718:	0147a703          	lw	a4,20(a5)
    8000371c:	00100793          	li	a5,1
    80003720:	02f70a63          	beq	a4,a5,80003754 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x54>
inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sstatus(uint64 mask) {
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003724:	10000793          	li	a5,256
    80003728:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
        RiscV::startVirtualMemory(RiscV::kPMT);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
        RiscV::startVirtualMemory(RiscV::uPMT);
    8000372c:	00008797          	auipc	a5,0x8
    80003730:	ac47b783          	ld	a5,-1340(a5) # 8000b1f0 <_ZN5RiscV4uPMTE>
inline void RiscV::disableTimerInterrupts(){
    RiscV::mc_sie(SIP_SSIE);
}

inline void RiscV::startVirtualMemory(void* PMT) {
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80003734:	00c7d793          	srli	a5,a5,0xc
    80003738:	fff00713          	li	a4,-1
    8000373c:	03f71713          	slli	a4,a4,0x3f
    80003740:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80003744:	18079073          	csrw	satp,a5
    }
}
    80003748:	00813403          	ld	s0,8(sp)
    8000374c:	01010113          	addi	sp,sp,16
    80003750:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003754:	10000793          	li	a5,256
    80003758:	1007a073          	csrs	sstatus,a5
        RiscV::startVirtualMemory(RiscV::kPMT);
    8000375c:	00008797          	auipc	a5,0x8
    80003760:	a8c7b783          	ld	a5,-1396(a5) # 8000b1e8 <_ZN5RiscV4kPMTE>
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80003764:	00c7d793          	srli	a5,a5,0xc
    80003768:	fff00713          	li	a4,-1
    8000376c:	03f71713          	slli	a4,a4,0x3f
    80003770:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80003774:	18079073          	csrw	satp,a5
}
    80003778:	fd1ff06f          	j	80003748 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x48>

000000008000377c <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    8000377c:	ff010113          	addi	sp,sp,-16
    80003780:	00113423          	sd	ra,8(sp)
    80003784:	00813023          	sd	s0,0(sp)
    80003788:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    8000378c:	00100793          	li	a5,1
    80003790:	00008717          	auipc	a4,0x8
    80003794:	a4f70823          	sb	a5,-1456(a4) # 8000b1e0 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003798:	00008797          	auipc	a5,0x8
    8000379c:	8007b783          	ld	a5,-2048(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800037a0:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    800037a4:	00007797          	auipc	a5,0x7
    800037a8:	7a47b783          	ld	a5,1956(a5) # 8000af48 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037ac:	0007b023          	sd	zero,0(a5)
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    800037b0:	00200793          	li	a5,2
    800037b4:	1047b073          	csrc	sie,a5
    800037b8:	20000793          	li	a5,512
    800037bc:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    800037c0:	00007797          	auipc	a5,0x7
    800037c4:	7b07b783          	ld	a5,1968(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x88>
    800037c8:	0007b783          	ld	a5,0(a5)
    800037cc:	00078c63          	beqz	a5,800037e4 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    800037d0:	0487b703          	ld	a4,72(a5)
    800037d4:	00007797          	auipc	a5,0x7
    800037d8:	79c7b783          	ld	a5,1948(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x88>
    800037dc:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    800037e0:	fe1ff06f          	j	800037c0 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    800037e4:	00007797          	auipc	a5,0x7
    800037e8:	7947b783          	ld	a5,1940(a5) # 8000af78 <_GLOBAL_OFFSET_TABLE_+0x90>
    800037ec:	0007b503          	ld	a0,0(a5)
    800037f0:	00001097          	auipc	ra,0x1
    800037f4:	440080e7          	jalr	1088(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    800037f8:	00007797          	auipc	a5,0x7
    800037fc:	7907b783          	ld	a5,1936(a5) # 8000af88 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80003800:	0007b703          	ld	a4,0(a5)
    80003804:	00007797          	auipc	a5,0x7
    80003808:	78c7b783          	ld	a5,1932(a5) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0xa8>
    8000380c:	0007b783          	ld	a5,0(a5)
    80003810:	00f70863          	beq	a4,a5,80003820 <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    80003814:	fffff097          	auipc	ra,0xfffff
    80003818:	758080e7          	jalr	1880(ra) # 80002f6c <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000381c:	fddff06f          	j	800037f8 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003820:	00813083          	ld	ra,8(sp)
    80003824:	00013403          	ld	s0,0(sp)
    80003828:	01010113          	addi	sp,sp,16
    8000382c:	00008067          	ret

0000000080003830 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003830:	ff010113          	addi	sp,sp,-16
    80003834:	00813423          	sd	s0,8(sp)
    80003838:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    8000383c:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003840:	00007717          	auipc	a4,0x7
    80003844:	76873703          	ld	a4,1896(a4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003848:	00073703          	ld	a4,0(a4)
    8000384c:	06873703          	ld	a4,104(a4)
    80003850:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003854:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003858:	00078593          	mv	a1,a5
}
    8000385c:	00813403          	ld	s0,8(sp)
    80003860:	01010113          	addi	sp,sp,16
    80003864:	00008067          	ret

0000000080003868 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003868:	ff010113          	addi	sp,sp,-16
    8000386c:	00113423          	sd	ra,8(sp)
    80003870:	00813023          	sd	s0,0(sp)
    80003874:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003878:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    8000387c:	00000097          	auipc	ra,0x0
    80003880:	974080e7          	jalr	-1676(ra) # 800031f0 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003884:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003888:	00000097          	auipc	ra,0x0
    8000388c:	fa8080e7          	jalr	-88(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003890:	00813083          	ld	ra,8(sp)
    80003894:	00013403          	ld	s0,0(sp)
    80003898:	01010113          	addi	sp,sp,16
    8000389c:	00008067          	ret

00000000800038a0 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    800038a0:	ff010113          	addi	sp,sp,-16
    800038a4:	00113423          	sd	ra,8(sp)
    800038a8:	00813023          	sd	s0,0(sp)
    800038ac:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    800038b0:	00007797          	auipc	a5,0x7
    800038b4:	7087b783          	ld	a5,1800(a5) # 8000afb8 <_GLOBAL_OFFSET_TABLE_+0xd0>
    800038b8:	0007c783          	lbu	a5,0(a5)
    800038bc:	02079263          	bnez	a5,800038e0 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    800038c0:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800038c4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800038c8:	00000097          	auipc	ra,0x0
    800038cc:	f68080e7          	jalr	-152(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    800038d0:	00813083          	ld	ra,8(sp)
    800038d4:	00013403          	ld	s0,0(sp)
    800038d8:	01010113          	addi	sp,sp,16
    800038dc:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800038e0:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    800038e4:	00000097          	auipc	ra,0x0
    800038e8:	b44080e7          	jalr	-1212(ra) # 80003428 <_ZN15MemoryAllocator5kfreeEPv>
    800038ec:	fd9ff06f          	j	800038c4 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

00000000800038f0 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    800038f0:	fc010113          	addi	sp,sp,-64
    800038f4:	02113c23          	sd	ra,56(sp)
    800038f8:	02813823          	sd	s0,48(sp)
    800038fc:	02913423          	sd	s1,40(sp)
    80003900:	03213023          	sd	s2,32(sp)
    80003904:	01313c23          	sd	s3,24(sp)
    80003908:	01413823          	sd	s4,16(sp)
    8000390c:	01513423          	sd	s5,8(sp)
    80003910:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003914:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003918:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000391c:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003920:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003924:	07000513          	li	a0,112
    80003928:	fffff097          	auipc	ra,0xfffff
    8000392c:	6c4080e7          	jalr	1732(ra) # 80002fec <_ZN3TCBnwEm>
    80003930:	00050493          	mv	s1,a0
    80003934:	00050e63          	beqz	a0,80003950 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    80003938:	00200713          	li	a4,2
    8000393c:	000a8693          	mv	a3,s5
    80003940:	000a0613          	mv	a2,s4
    80003944:	00098593          	mv	a1,s3
    80003948:	fffff097          	auipc	ra,0xfffff
    8000394c:	568080e7          	jalr	1384(ra) # 80002eb0 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003950:	04048863          	beqz	s1,800039a0 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    80003954:	0184b783          	ld	a5,24(s1)
    80003958:	00078863          	beqz	a5,80003968 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    8000395c:	00048513          	mv	a0,s1
    80003960:	00001097          	auipc	ra,0x1
    80003964:	2d0080e7          	jalr	720(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003968:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    8000396c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003970:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003974:	00000097          	auipc	ra,0x0
    80003978:	ebc080e7          	jalr	-324(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
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
    800039a4:	fcdff06f          	j	80003970 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    800039a8:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800039ac:	00048513          	mv	a0,s1
    800039b0:	fffff097          	auipc	ra,0xfffff
    800039b4:	760080e7          	jalr	1888(ra) # 80003110 <_ZN3TCBdlEPv>
    800039b8:	00090513          	mv	a0,s2
    800039bc:	00009097          	auipc	ra,0x9
    800039c0:	97c080e7          	jalr	-1668(ra) # 8000c338 <_Unwind_Resume>

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
    800039e8:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800039ec:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    800039f0:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    800039f4:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800039f8:	07000513          	li	a0,112
    800039fc:	fffff097          	auipc	ra,0xfffff
    80003a00:	5f0080e7          	jalr	1520(ra) # 80002fec <_ZN3TCBnwEm>
    80003a04:	00050493          	mv	s1,a0
    80003a08:	00050e63          	beqz	a0,80003a24 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80003a0c:	00200713          	li	a4,2
    80003a10:	000a8693          	mv	a3,s5
    80003a14:	00090613          	mv	a2,s2
    80003a18:	00098593          	mv	a1,s3
    80003a1c:	fffff097          	auipc	ra,0xfffff
    80003a20:	494080e7          	jalr	1172(ra) # 80002eb0 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003a24:	04048263          	beqz	s1,80003a68 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    80003a28:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    80003a2c:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80003a30:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    80003a34:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a38:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003a3c:	00000097          	auipc	ra,0x0
    80003a40:	df4080e7          	jalr	-524(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a44:	03813083          	ld	ra,56(sp)
    80003a48:	03013403          	ld	s0,48(sp)
    80003a4c:	02813483          	ld	s1,40(sp)
    80003a50:	02013903          	ld	s2,32(sp)
    80003a54:	01813983          	ld	s3,24(sp)
    80003a58:	01013a03          	ld	s4,16(sp)
    80003a5c:	00813a83          	ld	s5,8(sp)
    80003a60:	04010113          	addi	sp,sp,64
    80003a64:	00008067          	ret
        status = -1;
    80003a68:	fff00793          	li	a5,-1
    80003a6c:	fcdff06f          	j	80003a38 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    80003a70:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003a74:	00048513          	mv	a0,s1
    80003a78:	fffff097          	auipc	ra,0xfffff
    80003a7c:	698080e7          	jalr	1688(ra) # 80003110 <_ZN3TCBdlEPv>
    80003a80:	00090513          	mv	a0,s2
    80003a84:	00009097          	auipc	ra,0x9
    80003a88:	8b4080e7          	jalr	-1868(ra) # 8000c338 <_Unwind_Resume>

0000000080003a8c <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003a8c:	ff010113          	addi	sp,sp,-16
    80003a90:	00113423          	sd	ra,8(sp)
    80003a94:	00813023          	sd	s0,0(sp)
    80003a98:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003a9c:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003aa0:	02051263          	bnez	a0,80003ac4 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003aa4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003aa8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003aac:	00000097          	auipc	ra,0x0
    80003ab0:	d84080e7          	jalr	-636(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ab4:	00813083          	ld	ra,8(sp)
    80003ab8:	00013403          	ld	s0,0(sp)
    80003abc:	01010113          	addi	sp,sp,16
    80003ac0:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003ac4:	00100793          	li	a5,1
    80003ac8:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003acc:	00001097          	auipc	ra,0x1
    80003ad0:	164080e7          	jalr	356(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003ad4:	fffff097          	auipc	ra,0xfffff
    80003ad8:	498080e7          	jalr	1176(ra) # 80002f6c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003adc:	00000793          	li	a5,0
    80003ae0:	fc9ff06f          	j	80003aa8 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003ae4 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003ae4:	ff010113          	addi	sp,sp,-16
    80003ae8:	00113423          	sd	ra,8(sp)
    80003aec:	00813023          	sd	s0,0(sp)
    80003af0:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003af4:	00007797          	auipc	a5,0x7
    80003af8:	4b47b783          	ld	a5,1204(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003afc:	0007b783          	ld	a5,0(a5)
    80003b00:	02078a63          	beqz	a5,80003b34 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003b04:	00200713          	li	a4,2
    80003b08:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003b0c:	fffff097          	auipc	ra,0xfffff
    80003b10:	460080e7          	jalr	1120(ra) # 80002f6c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003b14:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b18:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003b1c:	00000097          	auipc	ra,0x0
    80003b20:	d14080e7          	jalr	-748(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b24:	00813083          	ld	ra,8(sp)
    80003b28:	00013403          	ld	s0,0(sp)
    80003b2c:	01010113          	addi	sp,sp,16
    80003b30:	00008067          	ret
        status = -1;
    80003b34:	fff00793          	li	a5,-1
    80003b38:	fe1ff06f          	j	80003b18 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003b3c <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003b3c:	fd010113          	addi	sp,sp,-48
    80003b40:	02113423          	sd	ra,40(sp)
    80003b44:	02813023          	sd	s0,32(sp)
    80003b48:	00913c23          	sd	s1,24(sp)
    80003b4c:	01213823          	sd	s2,16(sp)
    80003b50:	01313423          	sd	s3,8(sp)
    80003b54:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003b58:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003b5c:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    80003b60:	01800513          	li	a0,24
    80003b64:	fffff097          	auipc	ra,0xfffff
    80003b68:	1f8080e7          	jalr	504(ra) # 80002d5c <_ZN3SCBnwEm>
    80003b6c:	00050493          	mv	s1,a0
    80003b70:	00050863          	beqz	a0,80003b80 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    80003b74:	00098593          	mv	a1,s3
    80003b78:	fffff097          	auipc	ra,0xfffff
    80003b7c:	030080e7          	jalr	48(ra) # 80002ba8 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003b80:	02048a63          	beqz	s1,80003bb4 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    80003b84:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80003b88:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b8c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003b90:	00000097          	auipc	ra,0x0
    80003b94:	ca0080e7          	jalr	-864(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b98:	02813083          	ld	ra,40(sp)
    80003b9c:	02013403          	ld	s0,32(sp)
    80003ba0:	01813483          	ld	s1,24(sp)
    80003ba4:	01013903          	ld	s2,16(sp)
    80003ba8:	00813983          	ld	s3,8(sp)
    80003bac:	03010113          	addi	sp,sp,48
    80003bb0:	00008067          	ret
        status = -1;
    80003bb4:	fff00793          	li	a5,-1
    80003bb8:	fd5ff06f          	j	80003b8c <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    80003bbc:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003bc0:	00048513          	mv	a0,s1
    80003bc4:	fffff097          	auipc	ra,0xfffff
    80003bc8:	1c8080e7          	jalr	456(ra) # 80002d8c <_ZN3SCBdlEPv>
    80003bcc:	00090513          	mv	a0,s2
    80003bd0:	00008097          	auipc	ra,0x8
    80003bd4:	768080e7          	jalr	1896(ra) # 8000c338 <_Unwind_Resume>

0000000080003bd8 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003bd8:	fe010113          	addi	sp,sp,-32
    80003bdc:	00113c23          	sd	ra,24(sp)
    80003be0:	00813823          	sd	s0,16(sp)
    80003be4:	00913423          	sd	s1,8(sp)
    80003be8:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003bec:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003bf0:	02049463          	bnez	s1,80003c18 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003bf4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003bf8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003bfc:	00000097          	auipc	ra,0x0
    80003c00:	c34080e7          	jalr	-972(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003c04:	01813083          	ld	ra,24(sp)
    80003c08:	01013403          	ld	s0,16(sp)
    80003c0c:	00813483          	ld	s1,8(sp)
    80003c10:	02010113          	addi	sp,sp,32
    80003c14:	00008067          	ret
        delete (SCB*)ihandle;
    80003c18:	00048513          	mv	a0,s1
    80003c1c:	fffff097          	auipc	ra,0xfffff
    80003c20:	fa8080e7          	jalr	-88(ra) # 80002bc4 <_ZN3SCBD1Ev>
    80003c24:	00048513          	mv	a0,s1
    80003c28:	fffff097          	auipc	ra,0xfffff
    80003c2c:	164080e7          	jalr	356(ra) # 80002d8c <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003c30:	00000793          	li	a5,0
    80003c34:	fc5ff06f          	j	80003bf8 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080003c38 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80003c38:	ff010113          	addi	sp,sp,-16
    80003c3c:	00113423          	sd	ra,8(sp)
    80003c40:	00813023          	sd	s0,0(sp)
    80003c44:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003c48:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003c4c:	02051c63          	bnez	a0,80003c84 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80003c50:	00007797          	auipc	a5,0x7
    80003c54:	3587b783          	ld	a5,856(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003c58:	0007b783          	ld	a5,0(a5)
    80003c5c:	0607b783          	ld	a5,96(a5)
    80003c60:	02078863          	beqz	a5,80003c90 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003c64:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003c68:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003c6c:	00000097          	auipc	ra,0x0
    80003c70:	bc4080e7          	jalr	-1084(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003c74:	00813083          	ld	ra,8(sp)
    80003c78:	00013403          	ld	s0,0(sp)
    80003c7c:	01010113          	addi	sp,sp,16
    80003c80:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003c84:	fffff097          	auipc	ra,0xfffff
    80003c88:	04c080e7          	jalr	76(ra) # 80002cd0 <_ZN3SCB4waitEv>
    80003c8c:	fc5ff06f          	j	80003c50 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80003c90:	00000793          	li	a5,0
    80003c94:	fd5ff06f          	j	80003c68 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003c98 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003c98:	ff010113          	addi	sp,sp,-16
    80003c9c:	00113423          	sd	ra,8(sp)
    80003ca0:	00813023          	sd	s0,0(sp)
    80003ca4:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003ca8:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003cac:	02051263          	bnez	a0,80003cd0 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003cb0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003cb4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003cb8:	00000097          	auipc	ra,0x0
    80003cbc:	b78080e7          	jalr	-1160(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003cc0:	00813083          	ld	ra,8(sp)
    80003cc4:	00013403          	ld	s0,0(sp)
    80003cc8:	01010113          	addi	sp,sp,16
    80003ccc:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003cd0:	fffff097          	auipc	ra,0xfffff
    80003cd4:	050080e7          	jalr	80(ra) # 80002d20 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003cd8:	00000793          	li	a5,0
    80003cdc:	fd9ff06f          	j	80003cb4 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003ce0 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003ce0:	fe010113          	addi	sp,sp,-32
    80003ce4:	00113c23          	sd	ra,24(sp)
    80003ce8:	00813823          	sd	s0,16(sp)
    80003cec:	00913423          	sd	s1,8(sp)
    80003cf0:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003cf4:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003cf8:	00007797          	auipc	a5,0x7
    80003cfc:	2b07b783          	ld	a5,688(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003d00:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003d04:	00007797          	auipc	a5,0x7
    80003d08:	4f47b783          	ld	a5,1268(a5) # 8000b1f8 <_ZN5RiscV10globalTimeE>
    80003d0c:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003d10:	00e787b3          	add	a5,a5,a4
    80003d14:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003d18:	00048513          	mv	a0,s1
    80003d1c:	00001097          	auipc	ra,0x1
    80003d20:	f90080e7          	jalr	-112(ra) # 80004cac <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003d24:	00300793          	li	a5,3
    80003d28:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003d2c:	fffff097          	auipc	ra,0xfffff
    80003d30:	240080e7          	jalr	576(ra) # 80002f6c <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d34:	00000793          	li	a5,0
    80003d38:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003d3c:	00000097          	auipc	ra,0x0
    80003d40:	af4080e7          	jalr	-1292(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003d44:	01813083          	ld	ra,24(sp)
    80003d48:	01013403          	ld	s0,16(sp)
    80003d4c:	00813483          	ld	s1,8(sp)
    80003d50:	02010113          	addi	sp,sp,32
    80003d54:	00008067          	ret

0000000080003d58 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003d58:	fe010113          	addi	sp,sp,-32
    80003d5c:	00113c23          	sd	ra,24(sp)
    80003d60:	00813823          	sd	s0,16(sp)
    80003d64:	00913423          	sd	s1,8(sp)
    80003d68:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003d6c:	00007797          	auipc	a5,0x7
    80003d70:	4747c783          	lbu	a5,1140(a5) # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    80003d74:	00079c63          	bnez	a5,80003d8c <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003d78:	00007717          	auipc	a4,0x7
    80003d7c:	1d073703          	ld	a4,464(a4) # 8000af48 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003d80:	00073783          	ld	a5,0(a4)
    80003d84:	00178793          	addi	a5,a5,1
    80003d88:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003d8c:	00001097          	auipc	ra,0x1
    80003d90:	204080e7          	jalr	516(ra) # 80004f90 <_ZN11ConsoleUtil8getInputEv>
    80003d94:	00050493          	mv	s1,a0
    if(c==13) {
    80003d98:	00d00793          	li	a5,13
    80003d9c:	02f50663          	beq	a0,a5,80003dc8 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80003da0:	01b00793          	li	a5,27
    80003da4:	04f51063          	bne	a0,a5,80003de4 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003da8:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003dac:	00000097          	auipc	ra,0x0
    80003db0:	a84080e7          	jalr	-1404(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003db4:	01813083          	ld	ra,24(sp)
    80003db8:	01013403          	ld	s0,16(sp)
    80003dbc:	00813483          	ld	s1,8(sp)
    80003dc0:	02010113          	addi	sp,sp,32
    80003dc4:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003dc8:	00d00513          	li	a0,13
    80003dcc:	00001097          	auipc	ra,0x1
    80003dd0:	234080e7          	jalr	564(ra) # 80005000 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003dd4:	00a00513          	li	a0,10
    80003dd8:	00001097          	auipc	ra,0x1
    80003ddc:	228080e7          	jalr	552(ra) # 80005000 <_ZN11ConsoleUtil9putOutputEc>
    80003de0:	fc9ff06f          	j	80003da8 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003de4:	00001097          	auipc	ra,0x1
    80003de8:	21c080e7          	jalr	540(ra) # 80005000 <_ZN11ConsoleUtil9putOutputEc>
    80003dec:	fbdff06f          	j	80003da8 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003df0 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003df0:	ff010113          	addi	sp,sp,-16
    80003df4:	00113423          	sd	ra,8(sp)
    80003df8:	00813023          	sd	s0,0(sp)
    80003dfc:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003e00:	00001097          	auipc	ra,0x1
    80003e04:	298080e7          	jalr	664(ra) # 80005098 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003e08:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003e0c:	00000097          	auipc	ra,0x0
    80003e10:	a24080e7          	jalr	-1500(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e14:	00813083          	ld	ra,8(sp)
    80003e18:	00013403          	ld	s0,0(sp)
    80003e1c:	01010113          	addi	sp,sp,16
    80003e20:	00008067          	ret

0000000080003e24 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003e24:	fe010113          	addi	sp,sp,-32
    80003e28:	00113c23          	sd	ra,24(sp)
    80003e2c:	00813823          	sd	s0,16(sp)
    80003e30:	00913423          	sd	s1,8(sp)
    80003e34:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003e38:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003e3c:	02049463          	bnez	s1,80003e64 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003e40:	fff00793          	li	a5,-1
    80003e44:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003e48:	00000097          	auipc	ra,0x0
    80003e4c:	9e8080e7          	jalr	-1560(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e50:	01813083          	ld	ra,24(sp)
    80003e54:	01013403          	ld	s0,16(sp)
    80003e58:	00813483          	ld	s1,8(sp)
    80003e5c:	02010113          	addi	sp,sp,32
    80003e60:	00008067          	ret
        kfree(thr->stack);
    80003e64:	0284b503          	ld	a0,40(s1)
    80003e68:	00001097          	auipc	ra,0x1
    80003e6c:	59c080e7          	jalr	1436(ra) # 80005404 <_Z5kfreePKv>
        delete thr;
    80003e70:	00048513          	mv	a0,s1
    80003e74:	fffff097          	auipc	ra,0xfffff
    80003e78:	0d0080e7          	jalr	208(ra) # 80002f44 <_ZN3TCBD1Ev>
    80003e7c:	00048513          	mv	a0,s1
    80003e80:	fffff097          	auipc	ra,0xfffff
    80003e84:	290080e7          	jalr	656(ra) # 80003110 <_ZN3TCBdlEPv>
    80003e88:	fb9ff06f          	j	80003e40 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080003e8c <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003e8c:	fe010113          	addi	sp,sp,-32
    80003e90:	00113c23          	sd	ra,24(sp)
    80003e94:	00813823          	sd	s0,16(sp)
    80003e98:	00913423          	sd	s1,8(sp)
    80003e9c:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003ea0:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003ea4:	02049463          	bnez	s1,80003ecc <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ea8:	fff00793          	li	a5,-1
    80003eac:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003eb0:	00000097          	auipc	ra,0x0
    80003eb4:	980080e7          	jalr	-1664(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003eb8:	01813083          	ld	ra,24(sp)
    80003ebc:	01013403          	ld	s0,16(sp)
    80003ec0:	00813483          	ld	s1,8(sp)
    80003ec4:	02010113          	addi	sp,sp,32
    80003ec8:	00008067          	ret
        delete scb;
    80003ecc:	00048513          	mv	a0,s1
    80003ed0:	fffff097          	auipc	ra,0xfffff
    80003ed4:	cf4080e7          	jalr	-780(ra) # 80002bc4 <_ZN3SCBD1Ev>
    80003ed8:	00048513          	mv	a0,s1
    80003edc:	fffff097          	auipc	ra,0xfffff
    80003ee0:	eb0080e7          	jalr	-336(ra) # 80002d8c <_ZN3SCBdlEPv>
    80003ee4:	fc5ff06f          	j	80003ea8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003ee8 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003ee8:	fe010113          	addi	sp,sp,-32
    80003eec:	00113c23          	sd	ra,24(sp)
    80003ef0:	00813823          	sd	s0,16(sp)
    80003ef4:	00913423          	sd	s1,8(sp)
    80003ef8:	01213023          	sd	s2,0(sp)
    80003efc:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003f00:	04000513          	li	a0,64
    80003f04:	fffff097          	auipc	ra,0xfffff
    80003f08:	2ec080e7          	jalr	748(ra) # 800031f0 <_ZN15MemoryAllocator7kmallocEm>
    80003f0c:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003f10:	00007797          	auipc	a5,0x7
    80003f14:	0987b783          	ld	a5,152(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003f18:	0007b783          	ld	a5,0(a5)
    80003f1c:	00001637          	lui	a2,0x1
    80003f20:	00050593          	mv	a1,a0
    80003f24:	0287b503          	ld	a0,40(a5)
    80003f28:	fffff097          	auipc	ra,0xfffff
    80003f2c:	6b4080e7          	jalr	1716(ra) # 800035dc <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003f30:	07000513          	li	a0,112
    80003f34:	fffff097          	auipc	ra,0xfffff
    80003f38:	0b8080e7          	jalr	184(ra) # 80002fec <_ZN3TCBnwEm>
    80003f3c:	00050493          	mv	s1,a0
    80003f40:	00050e63          	beqz	a0,80003f5c <_ZN5RiscV18executeForkSyscallEv+0x74>
    80003f44:	00200713          	li	a4,2
    80003f48:	00090693          	mv	a3,s2
    80003f4c:	00000613          	li	a2,0
    80003f50:	00000593          	li	a1,0
    80003f54:	fffff097          	auipc	ra,0xfffff
    80003f58:	f5c080e7          	jalr	-164(ra) # 80002eb0 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003f5c:	0a048e63          	beqz	s1,80004018 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003f60:	00007797          	auipc	a5,0x7
    80003f64:	0087b783          	ld	a5,8(a5) # 8000af68 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003f68:	0007b783          	ld	a5,0(a5)
    80003f6c:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003f70:	00007797          	auipc	a5,0x7
    80003f74:	fe07b783          	ld	a5,-32(a5) # 8000af50 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003f78:	0007b783          	ld	a5,0(a5)
    80003f7c:	00f907b3          	add	a5,s2,a5
    80003f80:	00007717          	auipc	a4,0x7
    80003f84:	02873703          	ld	a4,40(a4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
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
    80003fec:	00001097          	auipc	ra,0x1
    80003ff0:	c44080e7          	jalr	-956(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ff4:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003ff8:	00000097          	auipc	ra,0x0
    80003ffc:	838080e7          	jalr	-1992(ra) # 80003830 <_ZN5RiscV16saveA0toSscratchEv>

}
    80004000:	01813083          	ld	ra,24(sp)
    80004004:	01013403          	ld	s0,16(sp)
    80004008:	00813483          	ld	s1,8(sp)
    8000400c:	00013903          	ld	s2,0(sp)
    80004010:	02010113          	addi	sp,sp,32
    80004014:	00008067          	ret
        status = -1;
    80004018:	fff00493          	li	s1,-1
    8000401c:	fd9ff06f          	j	80003ff4 <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80004020:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80004024:	00048513          	mv	a0,s1
    80004028:	fffff097          	auipc	ra,0xfffff
    8000402c:	0e8080e7          	jalr	232(ra) # 80003110 <_ZN3TCBdlEPv>
    80004030:	00090513          	mv	a0,s2
    80004034:	00008097          	auipc	ra,0x8
    80004038:	304080e7          	jalr	772(ra) # 8000c338 <_Unwind_Resume>

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
    80004050:	00007717          	auipc	a4,0x7
    80004054:	f1873703          	ld	a4,-232(a4) # 8000af68 <_GLOBAL_OFFSET_TABLE_+0x80>
    80004058:	00f73023          	sd	a5,0(a4)
}
    8000405c:	00813403          	ld	s0,8(sp)
    80004060:	01010113          	addi	sp,sp,16
    80004064:	00008067          	ret

0000000080004068 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80004068:	f9010113          	addi	sp,sp,-112
    8000406c:	06113423          	sd	ra,104(sp)
    80004070:	06813023          	sd	s0,96(sp)
    80004074:	04913c23          	sd	s1,88(sp)
    80004078:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    8000407c:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004080:	142027f3          	csrr	a5,scause
    80004084:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80004088:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    8000408c:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80004090:	00007797          	auipc	a5,0x7
    80004094:	f187b783          	ld	a5,-232(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004098:	0007b783          	ld	a5,0(a5)
    8000409c:	14002773          	csrr	a4,sscratch
    800040a0:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    800040a4:	fd843703          	ld	a4,-40(s0)
    800040a8:	00900793          	li	a5,9
    800040ac:	10f70663          	beq	a4,a5,800041b8 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    800040b0:	fd843703          	ld	a4,-40(s0)
    800040b4:	00800793          	li	a5,8
    800040b8:	10f70063          	beq	a4,a5,800041b8 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    800040bc:	fd843703          	ld	a4,-40(s0)
    800040c0:	fff00793          	li	a5,-1
    800040c4:	03f79793          	slli	a5,a5,0x3f
    800040c8:	00178793          	addi	a5,a5,1
    800040cc:	26f70463          	beq	a4,a5,80004334 <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    800040d0:	fd843703          	ld	a4,-40(s0)
    800040d4:	fff00793          	li	a5,-1
    800040d8:	03f79793          	slli	a5,a5,0x3f
    800040dc:	00978793          	addi	a5,a5,9
    800040e0:	2ef70263          	beq	a4,a5,800043c4 <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    800040e4:	fd843703          	ld	a4,-40(s0)
    800040e8:	00200793          	li	a5,2
    800040ec:	36f70a63          	beq	a4,a5,80004460 <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    800040f0:	00004517          	auipc	a0,0x4
    800040f4:	2f850513          	addi	a0,a0,760 # 800083e8 <CONSOLE_STATUS+0x3d8>
    800040f8:	00001097          	auipc	ra,0x1
    800040fc:	010080e7          	jalr	16(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80004100:	00004517          	auipc	a0,0x4
    80004104:	2f850513          	addi	a0,a0,760 # 800083f8 <CONSOLE_STATUS+0x3e8>
    80004108:	00001097          	auipc	ra,0x1
    8000410c:	000080e7          	jalr	ra # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004110:	142027f3          	csrr	a5,scause
    80004114:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80004118:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    8000411c:	00000613          	li	a2,0
    80004120:	00a00593          	li	a1,10
    80004124:	0005051b          	sext.w	a0,a0
    80004128:	00001097          	auipc	ra,0x1
    8000412c:	024080e7          	jalr	36(ra) # 8000514c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80004130:	00004517          	auipc	a0,0x4
    80004134:	28850513          	addi	a0,a0,648 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80004138:	00001097          	auipc	ra,0x1
    8000413c:	fd0080e7          	jalr	-48(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004140:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004144:	00000613          	li	a2,0
    80004148:	01000593          	li	a1,16
    8000414c:	0005051b          	sext.w	a0,a0
    80004150:	00001097          	auipc	ra,0x1
    80004154:	ffc080e7          	jalr	-4(ra) # 8000514c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004158:	00004517          	auipc	a0,0x4
    8000415c:	25850513          	addi	a0,a0,600 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80004160:	00001097          	auipc	ra,0x1
    80004164:	fa8080e7          	jalr	-88(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    80004168:	01000693          	li	a3,16
    8000416c:	00004617          	auipc	a2,0x4
    80004170:	24460613          	addi	a2,a2,580 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80004174:	0004859b          	sext.w	a1,s1
    80004178:	00004517          	auipc	a0,0x4
    8000417c:	29050513          	addi	a0,a0,656 # 80008408 <CONSOLE_STATUS+0x3f8>
    80004180:	00001097          	auipc	ra,0x1
    80004184:	0a8080e7          	jalr	168(ra) # 80005228 <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80004188:	00007797          	auipc	a5,0x7
    8000418c:	e207b783          	ld	a5,-480(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004190:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004194:	00200713          	li	a4,2
    80004198:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    8000419c:	00004517          	auipc	a0,0x4
    800041a0:	27450513          	addi	a0,a0,628 # 80008410 <CONSOLE_STATUS+0x400>
    800041a4:	00001097          	auipc	ra,0x1
    800041a8:	f64080e7          	jalr	-156(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800041ac:	fffff097          	auipc	ra,0xfffff
    800041b0:	dc0080e7          	jalr	-576(ra) # 80002f6c <_ZN3TCB8dispatchEv>
    800041b4:	0800006f          	j	80004234 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800041b8:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800041bc:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800041c0:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    800041c4:	00478793          	addi	a5,a5,4
    800041c8:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    800041cc:	00007797          	auipc	a5,0x7
    800041d0:	ddc7b783          	ld	a5,-548(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    800041d4:	0007b783          	ld	a5,0(a5)
    800041d8:	fa043703          	ld	a4,-96(s0)
    800041dc:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800041e0:	f9843703          	ld	a4,-104(s0)
    800041e4:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800041e8:	00050793          	mv	a5,a0
        switch(syscallID){
    800041ec:	06100713          	li	a4,97
    800041f0:	02f76463          	bltu	a4,a5,80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    800041f4:	00279793          	slli	a5,a5,0x2
    800041f8:	00004717          	auipc	a4,0x4
    800041fc:	22c70713          	addi	a4,a4,556 # 80008424 <CONSOLE_STATUS+0x414>
    80004200:	00e787b3          	add	a5,a5,a4
    80004204:	0007a783          	lw	a5,0(a5)
    80004208:	00e787b3          	add	a5,a5,a4
    8000420c:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004210:	fffff097          	auipc	ra,0xfffff
    80004214:	658080e7          	jalr	1624(ra) # 80003868 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004218:	00007797          	auipc	a5,0x7
    8000421c:	d907b783          	ld	a5,-624(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004220:	0007b783          	ld	a5,0(a5)
    80004224:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004228:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    8000422c:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004230:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80004234:	fffff097          	auipc	ra,0xfffff
    80004238:	4cc080e7          	jalr	1228(ra) # 80003700 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    8000423c:	06813083          	ld	ra,104(sp)
    80004240:	06013403          	ld	s0,96(sp)
    80004244:	05813483          	ld	s1,88(sp)
    80004248:	07010113          	addi	sp,sp,112
    8000424c:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80004250:	fffff097          	auipc	ra,0xfffff
    80004254:	650080e7          	jalr	1616(ra) # 800038a0 <_ZN5RiscV21executeMemFreeSyscallEv>
    80004258:	fc1ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    8000425c:	fffff097          	auipc	ra,0xfffff
    80004260:	694080e7          	jalr	1684(ra) # 800038f0 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004264:	fb5ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    80004268:	00000097          	auipc	ra,0x0
    8000426c:	87c080e7          	jalr	-1924(ra) # 80003ae4 <_ZN5RiscV24executeThreadExitSyscallEv>
    80004270:	fa9ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004274:	fffff097          	auipc	ra,0xfffff
    80004278:	400080e7          	jalr	1024(ra) # 80003674 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    8000427c:	f9dff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80004280:	fffff097          	auipc	ra,0xfffff
    80004284:	744080e7          	jalr	1860(ra) # 800039c4 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004288:	f91ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    8000428c:	00000097          	auipc	ra,0x0
    80004290:	800080e7          	jalr	-2048(ra) # 80003a8c <_ZN5RiscV25executeThreadStartSyscallEv>
    80004294:	f85ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80004298:	00000097          	auipc	ra,0x0
    8000429c:	8a4080e7          	jalr	-1884(ra) # 80003b3c <_ZN5RiscV21executeSemOpenSyscallEv>
    800042a0:	f79ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    800042a4:	00000097          	auipc	ra,0x0
    800042a8:	934080e7          	jalr	-1740(ra) # 80003bd8 <_ZN5RiscV22executeSemCloseSyscallEv>
    800042ac:	f6dff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    800042b0:	00000097          	auipc	ra,0x0
    800042b4:	988080e7          	jalr	-1656(ra) # 80003c38 <_ZN5RiscV21executeSemWaitSyscallEv>
    800042b8:	f61ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    800042bc:	00000097          	auipc	ra,0x0
    800042c0:	9dc080e7          	jalr	-1572(ra) # 80003c98 <_ZN5RiscV23executeSemSignalSyscallEv>
    800042c4:	f55ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    800042c8:	00000097          	auipc	ra,0x0
    800042cc:	a18080e7          	jalr	-1512(ra) # 80003ce0 <_ZN5RiscV23executeTimeSleepSyscallEv>
    800042d0:	f49ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    800042d4:	00000097          	auipc	ra,0x0
    800042d8:	a84080e7          	jalr	-1404(ra) # 80003d58 <_ZN5RiscV18executeGetcSyscallEv>
    800042dc:	f3dff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    800042e0:	fffff097          	auipc	ra,0xfffff
    800042e4:	3d0080e7          	jalr	976(ra) # 800036b0 <_ZN5RiscV18executePutcSyscallEv>
    800042e8:	f31ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    800042ec:	00000097          	auipc	ra,0x0
    800042f0:	b04080e7          	jalr	-1276(ra) # 80003df0 <_ZN5RiscV22executePutcUtilSyscallEv>
    800042f4:	f25ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    800042f8:	00000097          	auipc	ra,0x0
    800042fc:	b2c080e7          	jalr	-1236(ra) # 80003e24 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004300:	f19ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004304:	00000097          	auipc	ra,0x0
    80004308:	b88080e7          	jalr	-1144(ra) # 80003e8c <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    8000430c:	f0dff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004310:	00010793          	mv	a5,sp
    80004314:	00007717          	auipc	a4,0x7
    80004318:	c3c73703          	ld	a4,-964(a4) # 8000af50 <_GLOBAL_OFFSET_TABLE_+0x68>
    8000431c:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004320:	00000097          	auipc	ra,0x0
    80004324:	d1c080e7          	jalr	-740(ra) # 8000403c <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004328:	00000097          	auipc	ra,0x0
    8000432c:	bc0080e7          	jalr	-1088(ra) # 80003ee8 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004330:	ee9ff06f          	j	80004218 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004334:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004338:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000433c:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004340:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004344:	00200793          	li	a5,2
    80004348:	1447b073          	csrc	sip,a5
        globalTime += 1;
    8000434c:	00007717          	auipc	a4,0x7
    80004350:	e9470713          	addi	a4,a4,-364 # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    80004354:	01873783          	ld	a5,24(a4)
    80004358:	00178793          	addi	a5,a5,1
    8000435c:	00f73c23          	sd	a5,24(a4)
        Scheduler::awake();
    80004360:	00001097          	auipc	ra,0x1
    80004364:	9a4080e7          	jalr	-1628(ra) # 80004d04 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80004368:	00007717          	auipc	a4,0x7
    8000436c:	bb073703          	ld	a4,-1104(a4) # 8000af18 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004370:	00073783          	ld	a5,0(a4)
    80004374:	00178793          	addi	a5,a5,1
    80004378:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    8000437c:	00007717          	auipc	a4,0x7
    80004380:	c2c73703          	ld	a4,-980(a4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004384:	00073703          	ld	a4,0(a4)
    80004388:	03073683          	ld	a3,48(a4)
    8000438c:	00d7fc63          	bgeu	a5,a3,800043a4 <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    80004390:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004394:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004398:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000439c:	14179073          	csrw	sepc,a5
}
    800043a0:	e95ff06f          	j	80004234 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    800043a4:	00007797          	auipc	a5,0x7
    800043a8:	b747b783          	ld	a5,-1164(a5) # 8000af18 <_GLOBAL_OFFSET_TABLE_+0x30>
    800043ac:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    800043b0:	00100793          	li	a5,1
    800043b4:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    800043b8:	fffff097          	auipc	ra,0xfffff
    800043bc:	bb4080e7          	jalr	-1100(ra) # 80002f6c <_ZN3TCB8dispatchEv>
    800043c0:	fd1ff06f          	j	80004390 <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800043c4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800043c8:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800043cc:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800043d0:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    800043d4:	00007797          	auipc	a5,0x7
    800043d8:	b247b783          	ld	a5,-1244(a5) # 8000aef8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800043dc:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800043e0:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800043e4:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800043e8:	00058793          	mv	a5,a1
        if(status & 1UL)
    800043ec:	0017f793          	andi	a5,a5,1
    800043f0:	02078863          	beqz	a5,80004420 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    800043f4:	00007797          	auipc	a5,0x7
    800043f8:	b4c7b783          	ld	a5,-1204(a5) # 8000af40 <_GLOBAL_OFFSET_TABLE_+0x58>
    800043fc:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004400:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004404:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004408:	00058513          	mv	a0,a1
    8000440c:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004410:	00007797          	auipc	a5,0x7
    80004414:	b387b783          	ld	a5,-1224(a5) # 8000af48 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004418:	0007b783          	ld	a5,0(a5)
    8000441c:	02079463          	bnez	a5,80004444 <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    80004420:	00002097          	auipc	ra,0x2
    80004424:	864080e7          	jalr	-1948(ra) # 80005c84 <plic_claim>
    80004428:	00002097          	auipc	ra,0x2
    8000442c:	894080e7          	jalr	-1900(ra) # 80005cbc <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004430:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004434:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004438:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000443c:	14179073          	csrw	sepc,a5
}
    80004440:	df5ff06f          	j	80004234 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    80004444:	fff78793          	addi	a5,a5,-1
    80004448:	00007717          	auipc	a4,0x7
    8000444c:	b0073703          	ld	a4,-1280(a4) # 8000af48 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004450:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004454:	00001097          	auipc	ra,0x1
    80004458:	abc080e7          	jalr	-1348(ra) # 80004f10 <_ZN11ConsoleUtil8putInputEc>
    8000445c:	fc5ff06f          	j	80004420 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    80004460:	00007797          	auipc	a5,0x7
    80004464:	b487b783          	ld	a5,-1208(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004468:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000446c:	00200713          	li	a4,2
    80004470:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004474:	00004517          	auipc	a0,0x4
    80004478:	f4450513          	addi	a0,a0,-188 # 800083b8 <CONSOLE_STATUS+0x3a8>
    8000447c:	00001097          	auipc	ra,0x1
    80004480:	c8c080e7          	jalr	-884(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004484:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004488:	00000613          	li	a2,0
    8000448c:	01000593          	li	a1,16
    80004490:	0005051b          	sext.w	a0,a0
    80004494:	00001097          	auipc	ra,0x1
    80004498:	cb8080e7          	jalr	-840(ra) # 8000514c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000449c:	00004517          	auipc	a0,0x4
    800044a0:	f1450513          	addi	a0,a0,-236 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800044a4:	00001097          	auipc	ra,0x1
    800044a8:	c64080e7          	jalr	-924(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    800044ac:	00004517          	auipc	a0,0x4
    800044b0:	f1450513          	addi	a0,a0,-236 # 800083c0 <CONSOLE_STATUS+0x3b0>
    800044b4:	00001097          	auipc	ra,0x1
    800044b8:	c54080e7          	jalr	-940(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800044bc:	fffff097          	auipc	ra,0xfffff
    800044c0:	ab0080e7          	jalr	-1360(ra) # 80002f6c <_ZN3TCB8dispatchEv>
    800044c4:	d71ff06f          	j	80004234 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

00000000800044c8 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    800044c8:	fd010113          	addi	sp,sp,-48
    800044cc:	02113423          	sd	ra,40(sp)
    800044d0:	02813023          	sd	s0,32(sp)
    800044d4:	00913c23          	sd	s1,24(sp)
    800044d8:	01213823          	sd	s2,16(sp)
    800044dc:	01313423          	sd	s3,8(sp)
    800044e0:	03010413          	addi	s0,sp,48
    800044e4:	00050913          	mv	s2,a0
    800044e8:	00058493          	mv	s1,a1
    800044ec:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    800044f0:	00058e63          	beqz	a1,8000450c <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    800044f4:	04000513          	li	a0,64
    800044f8:	fffff097          	auipc	ra,0xfffff
    800044fc:	cf8080e7          	jalr	-776(ra) # 800031f0 <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    80004500:	00051863          	bnez	a0,80004510 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    80004504:	00093023          	sd	zero,0(s2)
            return;
    80004508:	0200006f          	j	80004528 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    8000450c:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80004510:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80004514:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80004518:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000451c:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80004520:	01100513          	li	a0,17

    asm("ecall");
    80004524:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    80004528:	02813083          	ld	ra,40(sp)
    8000452c:	02013403          	ld	s0,32(sp)
    80004530:	01813483          	ld	s1,24(sp)
    80004534:	01013903          	ld	s2,16(sp)
    80004538:	00813983          	ld	s3,8(sp)
    8000453c:	03010113          	addi	sp,sp,48
    80004540:	00008067          	ret

0000000080004544 <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    80004544:	ff010113          	addi	sp,sp,-16
    80004548:	00813423          	sd	s0,8(sp)
    8000454c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80004550:	01200513          	li	a0,18

    asm("ecall");
    80004554:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    80004558:	00813403          	ld	s0,8(sp)
    8000455c:	01010113          	addi	sp,sp,16
    80004560:	00008067          	ret

0000000080004564 <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    80004564:	ff010113          	addi	sp,sp,-16
    80004568:	00813423          	sd	s0,8(sp)
    8000456c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80004570:	01300513          	li	a0,19

    asm("ecall");
    80004574:	00000073          	ecall
}
    80004578:	00813403          	ld	s0,8(sp)
    8000457c:	01010113          	addi	sp,sp,16
    80004580:	00008067          	ret

0000000080004584 <_ZN5RiscV11putcWrapperEPv>:
{
    80004584:	fe010113          	addi	sp,sp,-32
    80004588:	00113c23          	sd	ra,24(sp)
    8000458c:	00813823          	sd	s0,16(sp)
    80004590:	02010413          	addi	s0,sp,32
    80004594:	00c0006f          	j	800045a0 <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    80004598:	00000097          	auipc	ra,0x0
    8000459c:	fcc080e7          	jalr	-52(ra) # 80004564 <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    800045a0:	00007797          	auipc	a5,0x7
    800045a4:	9587b783          	ld	a5,-1704(a5) # 8000aef8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800045a8:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800045ac:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800045b0:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800045b4:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    800045b8:	0207f793          	andi	a5,a5,32
    800045bc:	fc078ee3          	beqz	a5,80004598 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    800045c0:	00001097          	auipc	ra,0x1
    800045c4:	cd4080e7          	jalr	-812(ra) # 80005294 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    800045c8:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    800045cc:	00007797          	auipc	a5,0x7
    800045d0:	9247b783          	ld	a5,-1756(a5) # 8000aef0 <_GLOBAL_OFFSET_TABLE_+0x8>
    800045d4:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    800045d8:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    800045dc:	fef44783          	lbu	a5,-17(s0)
    800045e0:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    800045e4:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    800045e8:	00007797          	auipc	a5,0x7
    800045ec:	9b07b783          	ld	a5,-1616(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800045f0:	0007b783          	ld	a5,0(a5)
    800045f4:	fa0786e3          	beqz	a5,800045a0 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    800045f8:	fff78793          	addi	a5,a5,-1
    800045fc:	00007717          	auipc	a4,0x7
    80004600:	99c73703          	ld	a4,-1636(a4) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80004604:	00f73023          	sd	a5,0(a4)
    80004608:	f99ff06f          	j	800045a0 <_ZN5RiscV11putcWrapperEPv+0x1c>

000000008000460c <_ZN5RiscV6getPMTEv>:

    RiscV::mapConsoleRegisters(uPMT);
    RiscV::ms_sstatus(1<<18);
}

void* RiscV::getPMT(){
    8000460c:	ff010113          	addi	sp,sp,-16
    80004610:	00113423          	sd	ra,8(sp)
    80004614:	00813023          	sd	s0,0(sp)
    80004618:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    8000461c:	00100513          	li	a0,1
    80004620:	ffffe097          	auipc	ra,0xffffe
    80004624:	358080e7          	jalr	856(ra) # 80002978 <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80004628:	00000793          	li	a5,0
    8000462c:	1ff00713          	li	a4,511
    80004630:	00f74c63          	blt	a4,a5,80004648 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    80004634:	00379713          	slli	a4,a5,0x3
    80004638:	00e50733          	add	a4,a0,a4
    8000463c:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    80004640:	0017879b          	addiw	a5,a5,1
    80004644:	fe9ff06f          	j	8000462c <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    80004648:	00813083          	ld	ra,8(sp)
    8000464c:	00013403          	ld	s0,0(sp)
    80004650:	01010113          	addi	sp,sp,16
    80004654:	00008067          	ret

0000000080004658 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    80004658:	fc010113          	addi	sp,sp,-64
    8000465c:	02113c23          	sd	ra,56(sp)
    80004660:	02813823          	sd	s0,48(sp)
    80004664:	02913423          	sd	s1,40(sp)
    80004668:	03213023          	sd	s2,32(sp)
    8000466c:	01313c23          	sd	s3,24(sp)
    80004670:	01413823          	sd	s4,16(sp)
    80004674:	01513423          	sd	s5,8(sp)
    80004678:	04010413          	addi	s0,sp,64
    8000467c:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    80004680:	01e5d793          	srli	a5,a1,0x1e
    80004684:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    80004688:	0155d913          	srli	s2,a1,0x15
    8000468c:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    80004690:	00c5d493          	srli	s1,a1,0xc
    80004694:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80004698:	00379793          	slli	a5,a5,0x3
    8000469c:	00f50ab3          	add	s5,a0,a5
    800046a0:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    800046a4:	06078263          	beqz	a5,80004708 <_ZN5RiscV15handlePageFaultEPvmm+0xb0>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    800046a8:	00a7d513          	srli	a0,a5,0xa
    800046ac:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    800046b0:	00391913          	slli	s2,s2,0x3
    800046b4:	01250933          	add	s2,a0,s2
    800046b8:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    800046bc:	06050463          	beqz	a0,80004724 <_ZN5RiscV15handlePageFaultEPvmm+0xcc>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    800046c0:	00a55513          	srli	a0,a0,0xa
    800046c4:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    800046c8:	003a1a13          	slli	s4,s4,0x3
    800046cc:	01450533          	add	a0,a0,s4
    800046d0:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0) {
    800046d4:	00079863          	bnez	a5,800046e4 <_ZN5RiscV15handlePageFaultEPvmm+0x8c>
        ((uint64 *) pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    800046d8:	00a49493          	slli	s1,s1,0xa
    800046dc:	0134e9b3          	or	s3,s1,s3
    800046e0:	01353023          	sd	s3,0(a0)
    }
}
    800046e4:	03813083          	ld	ra,56(sp)
    800046e8:	03013403          	ld	s0,48(sp)
    800046ec:	02813483          	ld	s1,40(sp)
    800046f0:	02013903          	ld	s2,32(sp)
    800046f4:	01813983          	ld	s3,24(sp)
    800046f8:	01013a03          	ld	s4,16(sp)
    800046fc:	00813a83          	ld	s5,8(sp)
    80004700:	04010113          	addi	sp,sp,64
    80004704:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80004708:	00000097          	auipc	ra,0x0
    8000470c:	f04080e7          	jalr	-252(ra) # 8000460c <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    80004710:	00c55793          	srli	a5,a0,0xc
    80004714:	00a79793          	slli	a5,a5,0xa
    80004718:	0017e793          	ori	a5,a5,1
    8000471c:	00fab023          	sd	a5,0(s5)
    80004720:	f91ff06f          	j	800046b0 <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    80004724:	00000097          	auipc	ra,0x0
    80004728:	ee8080e7          	jalr	-280(ra) # 8000460c <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    8000472c:	00c55793          	srli	a5,a0,0xc
    80004730:	00a79793          	slli	a5,a5,0xa
    80004734:	0017e793          	ori	a5,a5,1
    80004738:	00f93023          	sd	a5,0(s2)
    8000473c:	f8dff06f          	j	800046c8 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

0000000080004740 <_ZN5RiscV12buildSectionEPvmmm>:
void RiscV::buildSection(void *PMT, uint64 start, uint64 end, uint64 mask) {
    80004740:	fd010113          	addi	sp,sp,-48
    80004744:	02113423          	sd	ra,40(sp)
    80004748:	02813023          	sd	s0,32(sp)
    8000474c:	00913c23          	sd	s1,24(sp)
    80004750:	01213823          	sd	s2,16(sp)
    80004754:	01313423          	sd	s3,8(sp)
    80004758:	01413023          	sd	s4,0(sp)
    8000475c:	03010413          	addi	s0,sp,48
    80004760:	00050a13          	mv	s4,a0
    80004764:	00058493          	mv	s1,a1
    80004768:	00060913          	mv	s2,a2
    8000476c:	00068993          	mv	s3,a3
    for(uint64 i=start;i< end;i+=0x1000) {
    80004770:	0324f263          	bgeu	s1,s2,80004794 <_ZN5RiscV12buildSectionEPvmmm+0x54>
        handlePageFault(PMT,i, mask);
    80004774:	00098613          	mv	a2,s3
    80004778:	00048593          	mv	a1,s1
    8000477c:	000a0513          	mv	a0,s4
    80004780:	00000097          	auipc	ra,0x0
    80004784:	ed8080e7          	jalr	-296(ra) # 80004658 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=start;i< end;i+=0x1000) {
    80004788:	000017b7          	lui	a5,0x1
    8000478c:	00f484b3          	add	s1,s1,a5
    80004790:	fe1ff06f          	j	80004770 <_ZN5RiscV12buildSectionEPvmmm+0x30>
}
    80004794:	02813083          	ld	ra,40(sp)
    80004798:	02013403          	ld	s0,32(sp)
    8000479c:	01813483          	ld	s1,24(sp)
    800047a0:	01013903          	ld	s2,16(sp)
    800047a4:	00813983          	ld	s3,8(sp)
    800047a8:	00013a03          	ld	s4,0(sp)
    800047ac:	03010113          	addi	sp,sp,48
    800047b0:	00008067          	ret

00000000800047b4 <_ZN5RiscV19mapConsoleRegistersEPv>:

void RiscV::mapConsoleRegisters(void *PMT) {
    800047b4:	fe010113          	addi	sp,sp,-32
    800047b8:	00113c23          	sd	ra,24(sp)
    800047bc:	00813823          	sd	s0,16(sp)
    800047c0:	00913423          	sd	s1,8(sp)
    800047c4:	02010413          	addi	s0,sp,32
    800047c8:	00050493          	mv	s1,a0
    handlePageFault(PMT, (uint64)CONSOLE_RX_DATA,0xf);
    800047cc:	00f00613          	li	a2,15
    800047d0:	00006797          	auipc	a5,0x6
    800047d4:	7207b783          	ld	a5,1824(a5) # 8000aef0 <_GLOBAL_OFFSET_TABLE_+0x8>
    800047d8:	0007b583          	ld	a1,0(a5)
    800047dc:	00000097          	auipc	ra,0x0
    800047e0:	e7c080e7          	jalr	-388(ra) # 80004658 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_TX_DATA,0xf);
    800047e4:	00f00613          	li	a2,15
    800047e8:	00006797          	auipc	a5,0x6
    800047ec:	7587b783          	ld	a5,1880(a5) # 8000af40 <_GLOBAL_OFFSET_TABLE_+0x58>
    800047f0:	0007b583          	ld	a1,0(a5)
    800047f4:	00048513          	mv	a0,s1
    800047f8:	00000097          	auipc	ra,0x0
    800047fc:	e60080e7          	jalr	-416(ra) # 80004658 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_STATUS,0xf);
    80004800:	00f00613          	li	a2,15
    80004804:	00006797          	auipc	a5,0x6
    80004808:	6f47b783          	ld	a5,1780(a5) # 8000aef8 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000480c:	0007b583          	ld	a1,0(a5)
    80004810:	00048513          	mv	a0,s1
    80004814:	00000097          	auipc	ra,0x0
    80004818:	e44080e7          	jalr	-444(ra) # 80004658 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)0xc201004,0xf);
    8000481c:	00f00613          	li	a2,15
    80004820:	0c2015b7          	lui	a1,0xc201
    80004824:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    80004828:	00048513          	mv	a0,s1
    8000482c:	00000097          	auipc	ra,0x0
    80004830:	e2c080e7          	jalr	-468(ra) # 80004658 <_ZN5RiscV15handlePageFaultEPvmm>
    80004834:	01813083          	ld	ra,24(sp)
    80004838:	01013403          	ld	s0,16(sp)
    8000483c:	00813483          	ld	s1,8(sp)
    80004840:	02010113          	addi	sp,sp,32
    80004844:	00008067          	ret

0000000080004848 <_ZN5RiscV14buildKernelPMTEv>:
void RiscV::buildKernelPMT() {
    80004848:	fd010113          	addi	sp,sp,-48
    8000484c:	02113423          	sd	ra,40(sp)
    80004850:	02813023          	sd	s0,32(sp)
    80004854:	00913c23          	sd	s1,24(sp)
    80004858:	01213823          	sd	s2,16(sp)
    8000485c:	01313423          	sd	s3,8(sp)
    80004860:	01413023          	sd	s4,0(sp)
    80004864:	03010413          	addi	s0,sp,48
    RiscV::kPMT = RiscV::getPMT();
    80004868:	00000097          	auipc	ra,0x0
    8000486c:	da4080e7          	jalr	-604(ra) # 8000460c <_ZN5RiscV6getPMTEv>
    80004870:	00007497          	auipc	s1,0x7
    80004874:	97048493          	addi	s1,s1,-1680 # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    80004878:	00a4b423          	sd	a0,8(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    8000487c:	00006797          	auipc	a5,0x6
    80004880:	6ac7b783          	ld	a5,1708(a5) # 8000af28 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004884:	0007b903          	ld	s2,0(a5)
    80004888:	00c91913          	slli	s2,s2,0xc
    8000488c:	00006797          	auipc	a5,0x6
    80004890:	6ac7b783          	ld	a5,1708(a5) # 8000af38 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004894:	0007b783          	ld	a5,0(a5)
    80004898:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(kPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    8000489c:	00006a17          	auipc	s4,0x6
    800048a0:	66ca3a03          	ld	s4,1644(s4) # 8000af08 <_GLOBAL_OFFSET_TABLE_+0x20>
    800048a4:	00b00693          	li	a3,11
    800048a8:	000a0613          	mv	a2,s4
    800048ac:	00100593          	li	a1,1
    800048b0:	01f59593          	slli	a1,a1,0x1f
    800048b4:	00000097          	auipc	ra,0x0
    800048b8:	e8c080e7          	jalr	-372(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    800048bc:	00006997          	auipc	s3,0x6
    800048c0:	6f49b983          	ld	s3,1780(s3) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0xc8>
    800048c4:	00700693          	li	a3,7
    800048c8:	00098613          	mv	a2,s3
    800048cc:	000a0593          	mv	a1,s4
    800048d0:	0084b503          	ld	a0,8(s1)
    800048d4:	00000097          	auipc	ra,0x0
    800048d8:	e6c080e7          	jalr	-404(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    800048dc:	00006a17          	auipc	s4,0x6
    800048e0:	6f4a3a03          	ld	s4,1780(s4) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0xe8>
    800048e4:	01b00693          	li	a3,27
    800048e8:	000a0613          	mv	a2,s4
    800048ec:	00098593          	mv	a1,s3
    800048f0:	0084b503          	ld	a0,8(s1)
    800048f4:	00000097          	auipc	ra,0x0
    800048f8:	e4c080e7          	jalr	-436(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_START, USER_DATA_END, 0x17);
    800048fc:	00006997          	auipc	s3,0x6
    80004900:	6249b983          	ld	s3,1572(s3) # 8000af20 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004904:	01700693          	li	a3,23
    80004908:	00098613          	mv	a2,s3
    8000490c:	000a0593          	mv	a1,s4
    80004910:	0084b503          	ld	a0,8(s1)
    80004914:	00000097          	auipc	ra,0x0
    80004918:	e2c080e7          	jalr	-468(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_END, bEnd, 0x7);
    8000491c:	00700693          	li	a3,7
    80004920:	00090613          	mv	a2,s2
    80004924:	00098593          	mv	a1,s3
    80004928:	0084b503          	ld	a0,8(s1)
    8000492c:	00000097          	auipc	ra,0x0
    80004930:	e14080e7          	jalr	-492(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, bEnd, HEAP_END, 0x17);
    80004934:	01700693          	li	a3,23
    80004938:	00006797          	auipc	a5,0x6
    8000493c:	6887b783          	ld	a5,1672(a5) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80004940:	0007b603          	ld	a2,0(a5)
    80004944:	00090593          	mv	a1,s2
    80004948:	0084b503          	ld	a0,8(s1)
    8000494c:	00000097          	auipc	ra,0x0
    80004950:	df4080e7          	jalr	-524(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(kPMT);
    80004954:	0084b503          	ld	a0,8(s1)
    80004958:	00000097          	auipc	ra,0x0
    8000495c:	e5c080e7          	jalr	-420(ra) # 800047b4 <_ZN5RiscV19mapConsoleRegistersEPv>
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80004960:	000407b7          	lui	a5,0x40
    80004964:	1007a073          	csrs	sstatus,a5
}
    80004968:	02813083          	ld	ra,40(sp)
    8000496c:	02013403          	ld	s0,32(sp)
    80004970:	01813483          	ld	s1,24(sp)
    80004974:	01013903          	ld	s2,16(sp)
    80004978:	00813983          	ld	s3,8(sp)
    8000497c:	00013a03          	ld	s4,0(sp)
    80004980:	03010113          	addi	sp,sp,48
    80004984:	00008067          	ret

0000000080004988 <_ZN5RiscV12buildUserPMTEv>:
void RiscV::buildUserPMT() {
    80004988:	fd010113          	addi	sp,sp,-48
    8000498c:	02113423          	sd	ra,40(sp)
    80004990:	02813023          	sd	s0,32(sp)
    80004994:	00913c23          	sd	s1,24(sp)
    80004998:	01213823          	sd	s2,16(sp)
    8000499c:	01313423          	sd	s3,8(sp)
    800049a0:	01413023          	sd	s4,0(sp)
    800049a4:	03010413          	addi	s0,sp,48
    RiscV::uPMT = RiscV::getPMT();
    800049a8:	00000097          	auipc	ra,0x0
    800049ac:	c64080e7          	jalr	-924(ra) # 8000460c <_ZN5RiscV6getPMTEv>
    800049b0:	00007497          	auipc	s1,0x7
    800049b4:	83048493          	addi	s1,s1,-2000 # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    800049b8:	00a4b823          	sd	a0,16(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    800049bc:	00006797          	auipc	a5,0x6
    800049c0:	56c7b783          	ld	a5,1388(a5) # 8000af28 <_GLOBAL_OFFSET_TABLE_+0x40>
    800049c4:	0007b903          	ld	s2,0(a5)
    800049c8:	00c91913          	slli	s2,s2,0xc
    800049cc:	00006797          	auipc	a5,0x6
    800049d0:	56c7b783          	ld	a5,1388(a5) # 8000af38 <_GLOBAL_OFFSET_TABLE_+0x50>
    800049d4:	0007b783          	ld	a5,0(a5)
    800049d8:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(uPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    800049dc:	00006a17          	auipc	s4,0x6
    800049e0:	52ca3a03          	ld	s4,1324(s4) # 8000af08 <_GLOBAL_OFFSET_TABLE_+0x20>
    800049e4:	00b00693          	li	a3,11
    800049e8:	000a0613          	mv	a2,s4
    800049ec:	00100593          	li	a1,1
    800049f0:	01f59593          	slli	a1,a1,0x1f
    800049f4:	00000097          	auipc	ra,0x0
    800049f8:	d4c080e7          	jalr	-692(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    800049fc:	00006997          	auipc	s3,0x6
    80004a00:	5b49b983          	ld	s3,1460(s3) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80004a04:	00700693          	li	a3,7
    80004a08:	00098613          	mv	a2,s3
    80004a0c:	000a0593          	mv	a1,s4
    80004a10:	0104b503          	ld	a0,16(s1)
    80004a14:	00000097          	auipc	ra,0x0
    80004a18:	d2c080e7          	jalr	-724(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80004a1c:	00006a17          	auipc	s4,0x6
    80004a20:	5b4a3a03          	ld	s4,1460(s4) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0xe8>
    80004a24:	01b00693          	li	a3,27
    80004a28:	000a0613          	mv	a2,s4
    80004a2c:	00098593          	mv	a1,s3
    80004a30:	0104b503          	ld	a0,16(s1)
    80004a34:	00000097          	auipc	ra,0x0
    80004a38:	d0c080e7          	jalr	-756(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80004a3c:	00006997          	auipc	s3,0x6
    80004a40:	4e49b983          	ld	s3,1252(s3) # 8000af20 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004a44:	01700693          	li	a3,23
    80004a48:	00098613          	mv	a2,s3
    80004a4c:	000a0593          	mv	a1,s4
    80004a50:	0104b503          	ld	a0,16(s1)
    80004a54:	00000097          	auipc	ra,0x0
    80004a58:	cec080e7          	jalr	-788(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_END, bEnd, 0x7);
    80004a5c:	00700693          	li	a3,7
    80004a60:	00090613          	mv	a2,s2
    80004a64:	00098593          	mv	a1,s3
    80004a68:	0104b503          	ld	a0,16(s1)
    80004a6c:	00000097          	auipc	ra,0x0
    80004a70:	cd4080e7          	jalr	-812(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, bEnd, HEAP_END, 0x17);
    80004a74:	01700693          	li	a3,23
    80004a78:	00006797          	auipc	a5,0x6
    80004a7c:	5487b783          	ld	a5,1352(a5) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80004a80:	0007b603          	ld	a2,0(a5)
    80004a84:	00090593          	mv	a1,s2
    80004a88:	0104b503          	ld	a0,16(s1)
    80004a8c:	00000097          	auipc	ra,0x0
    80004a90:	cb4080e7          	jalr	-844(ra) # 80004740 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(uPMT);
    80004a94:	0104b503          	ld	a0,16(s1)
    80004a98:	00000097          	auipc	ra,0x0
    80004a9c:	d1c080e7          	jalr	-740(ra) # 800047b4 <_ZN5RiscV19mapConsoleRegistersEPv>
    80004aa0:	000407b7          	lui	a5,0x40
    80004aa4:	1007a073          	csrs	sstatus,a5
}
    80004aa8:	02813083          	ld	ra,40(sp)
    80004aac:	02013403          	ld	s0,32(sp)
    80004ab0:	01813483          	ld	s1,24(sp)
    80004ab4:	01013903          	ld	s2,16(sp)
    80004ab8:	00813983          	ld	s3,8(sp)
    80004abc:	00013a03          	ld	s4,0(sp)
    80004ac0:	03010113          	addi	sp,sp,48
    80004ac4:	00008067          	ret

0000000080004ac8 <_ZN5RiscV10initializeEv>:
void RiscV::initialize(){
    80004ac8:	ff010113          	addi	sp,sp,-16
    80004acc:	00113423          	sd	ra,8(sp)
    80004ad0:	00813023          	sd	s0,0(sp)
    80004ad4:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80004ad8:	00006797          	auipc	a5,0x6
    80004adc:	4a87b783          	ld	a5,1192(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x98>
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80004ae0:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80004ae4:	00006797          	auipc	a5,0x6
    80004ae8:	41c7b783          	ld	a5,1052(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004aec:	0007b503          	ld	a0,0(a5)
    80004af0:	00c55513          	srli	a0,a0,0xc
    80004af4:	00250513          	addi	a0,a0,2
    80004af8:	000015b7          	lui	a1,0x1
    80004afc:	00c51513          	slli	a0,a0,0xc
    80004b00:	00000097          	auipc	ra,0x0
    80004b04:	7bc080e7          	jalr	1980(ra) # 800052bc <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80004b08:	ffffe097          	auipc	ra,0xffffe
    80004b0c:	668080e7          	jalr	1640(ra) # 80003170 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80004b10:	00000097          	auipc	ra,0x0
    80004b14:	108080e7          	jalr	264(ra) # 80004c18 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80004b18:	ffffe097          	auipc	ra,0xffffe
    80004b1c:	504080e7          	jalr	1284(ra) # 8000301c <_ZN3TCB10initializeEv>
    SCB::initialize();
    80004b20:	ffffe097          	auipc	ra,0xffffe
    80004b24:	03c080e7          	jalr	60(ra) # 80002b5c <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80004b28:	00000097          	auipc	ra,0x0
    80004b2c:	304080e7          	jalr	772(ra) # 80004e2c <_ZN11ConsoleUtil10initializeEv>
    RiscV::buildKernelPMT();
    80004b30:	00000097          	auipc	ra,0x0
    80004b34:	d18080e7          	jalr	-744(ra) # 80004848 <_ZN5RiscV14buildKernelPMTEv>
    RiscV::buildUserPMT();
    80004b38:	00000097          	auipc	ra,0x0
    80004b3c:	e50080e7          	jalr	-432(ra) # 80004988 <_ZN5RiscV12buildUserPMTEv>
    RiscV::initialized = true;
    80004b40:	00006797          	auipc	a5,0x6
    80004b44:	6a078793          	addi	a5,a5,1696 # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    80004b48:	00100713          	li	a4,1
    80004b4c:	02e78023          	sb	a4,32(a5)
    RiscV::startVirtualMemory(RiscV::kPMT);
    80004b50:	0087b783          	ld	a5,8(a5)
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80004b54:	00c7d793          	srli	a5,a5,0xc
    80004b58:	fff00713          	li	a4,-1
    80004b5c:	03f71713          	slli	a4,a4,0x3f
    80004b60:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80004b64:	18079073          	csrw	satp,a5
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80004b68:	00200793          	li	a5,2
    80004b6c:	1047a073          	csrs	sie,a5
    80004b70:	20000713          	li	a4,512
    80004b74:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80004b78:	1007a073          	csrs	sstatus,a5
}
    80004b7c:	00813083          	ld	ra,8(sp)
    80004b80:	00013403          	ld	s0,0(sp)
    80004b84:	01010113          	addi	sp,sp,16
    80004b88:	00008067          	ret

0000000080004b8c <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/kernel/utility.hpp"

char* strcpy(const char* src, char* dst){
    80004b8c:	ff010113          	addi	sp,sp,-16
    80004b90:	00813423          	sd	s0,8(sp)
    80004b94:	01010413          	addi	s0,sp,16
    80004b98:	00050793          	mv	a5,a0
    80004b9c:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004ba0:	0007c703          	lbu	a4,0(a5)
    80004ba4:	00070a63          	beqz	a4,80004bb8 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004ba8:	00178793          	addi	a5,a5,1
    80004bac:	00e50023          	sb	a4,0(a0)
    80004bb0:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004bb4:	fedff06f          	j	80004ba0 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004bb8:	00e50023          	sb	a4,0(a0)
    return dst;
}
    80004bbc:	00813403          	ld	s0,8(sp)
    80004bc0:	01010113          	addi	sp,sp,16
    80004bc4:	00008067          	ret

0000000080004bc8 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004bc8:	fe010113          	addi	sp,sp,-32
    80004bcc:	00113c23          	sd	ra,24(sp)
    80004bd0:	00813823          	sd	s0,16(sp)
    80004bd4:	00913423          	sd	s1,8(sp)
    80004bd8:	02010413          	addi	s0,sp,32
    80004bdc:	00050493          	mv	s1,a0
    80004be0:	00058513          	mv	a0,a1
    char *dest = dst;
    80004be4:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004be8:	0005c783          	lbu	a5,0(a1) # 1000 <_entry-0x7ffff000>
    80004bec:	00078663          	beqz	a5,80004bf8 <_Z6strcatPcPKc+0x30>
        dest++;
    80004bf0:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004bf4:	ff5ff06f          	j	80004be8 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004bf8:	00000097          	auipc	ra,0x0
    80004bfc:	f94080e7          	jalr	-108(ra) # 80004b8c <_Z6strcpyPKcPc>
    return dst;
    80004c00:	00048513          	mv	a0,s1
    80004c04:	01813083          	ld	ra,24(sp)
    80004c08:	01013403          	ld	s0,16(sp)
    80004c0c:	00813483          	ld	s1,8(sp)
    80004c10:	02010113          	addi	sp,sp,32
    80004c14:	00008067          	ret

0000000080004c18 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004c18:	ff010113          	addi	sp,sp,-16
    80004c1c:	00813423          	sd	s0,8(sp)
    80004c20:	01010413          	addi	s0,sp,16
}
    80004c24:	00813403          	ld	s0,8(sp)
    80004c28:	01010113          	addi	sp,sp,16
    80004c2c:	00008067          	ret

0000000080004c30 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004c30:	ff010113          	addi	sp,sp,-16
    80004c34:	00813423          	sd	s0,8(sp)
    80004c38:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004c3c:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004c40:	00006797          	auipc	a5,0x6
    80004c44:	5c87b783          	ld	a5,1480(a5) # 8000b208 <_ZN9Scheduler9readyHeadE>
    80004c48:	02078263          	beqz	a5,80004c6c <_ZN9Scheduler3putEP3TCB+0x3c>
    80004c4c:	00006797          	auipc	a5,0x6
    80004c50:	5c47b783          	ld	a5,1476(a5) # 8000b210 <_ZN9Scheduler9readyTailE>
    80004c54:	04a7b423          	sd	a0,72(a5)
    80004c58:	00006797          	auipc	a5,0x6
    80004c5c:	5aa7bc23          	sd	a0,1464(a5) # 8000b210 <_ZN9Scheduler9readyTailE>
}
    80004c60:	00813403          	ld	s0,8(sp)
    80004c64:	01010113          	addi	sp,sp,16
    80004c68:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004c6c:	00006797          	auipc	a5,0x6
    80004c70:	58a7be23          	sd	a0,1436(a5) # 8000b208 <_ZN9Scheduler9readyHeadE>
    80004c74:	fe5ff06f          	j	80004c58 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004c78 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004c78:	ff010113          	addi	sp,sp,-16
    80004c7c:	00813423          	sd	s0,8(sp)
    80004c80:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004c84:	00006517          	auipc	a0,0x6
    80004c88:	58453503          	ld	a0,1412(a0) # 8000b208 <_ZN9Scheduler9readyHeadE>
    80004c8c:	00050a63          	beqz	a0,80004ca0 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004c90:	04853783          	ld	a5,72(a0)
    80004c94:	00006717          	auipc	a4,0x6
    80004c98:	56f73a23          	sd	a5,1396(a4) # 8000b208 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004c9c:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004ca0:	00813403          	ld	s0,8(sp)
    80004ca4:	01010113          	addi	sp,sp,16
    80004ca8:	00008067          	ret

0000000080004cac <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004cac:	ff010113          	addi	sp,sp,-16
    80004cb0:	00813423          	sd	s0,8(sp)
    80004cb4:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004cb8:	00006797          	auipc	a5,0x6
    80004cbc:	5607b783          	ld	a5,1376(a5) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
    80004cc0:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004cc4:	00078e63          	beqz	a5,80004ce0 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004cc8:	0587b683          	ld	a3,88(a5)
    80004ccc:	05853703          	ld	a4,88(a0)
    80004cd0:	00d76863          	bltu	a4,a3,80004ce0 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004cd4:	00078613          	mv	a2,a5
    80004cd8:	0487b783          	ld	a5,72(a5)
    80004cdc:	fe9ff06f          	j	80004cc4 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004ce0:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004ce4:	00060a63          	beqz	a2,80004cf8 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004ce8:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    80004cec:	00813403          	ld	s0,8(sp)
    80004cf0:	01010113          	addi	sp,sp,16
    80004cf4:	00008067          	ret
        sleepingHead = t;
    80004cf8:	00006797          	auipc	a5,0x6
    80004cfc:	52a7b023          	sd	a0,1312(a5) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
}
    80004d00:	fedff06f          	j	80004cec <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004d04 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004d04:	fe010113          	addi	sp,sp,-32
    80004d08:	00113c23          	sd	ra,24(sp)
    80004d0c:	00813823          	sd	s0,16(sp)
    80004d10:	00913423          	sd	s1,8(sp)
    80004d14:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004d18:	00006497          	auipc	s1,0x6
    80004d1c:	5004b483          	ld	s1,1280(s1) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
    80004d20:	02048c63          	beqz	s1,80004d58 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004d24:	0584b703          	ld	a4,88(s1)
    80004d28:	00006797          	auipc	a5,0x6
    80004d2c:	2a07b783          	ld	a5,672(a5) # 8000afc8 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80004d30:	0007b783          	ld	a5,0(a5)
    80004d34:	02e7e263          	bltu	a5,a4,80004d58 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004d38:	0484b783          	ld	a5,72(s1)
    80004d3c:	00006717          	auipc	a4,0x6
    80004d40:	4cf73e23          	sd	a5,1244(a4) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004d44:	00048513          	mv	a0,s1
    80004d48:	00000097          	auipc	ra,0x0
    80004d4c:	ee8080e7          	jalr	-280(ra) # 80004c30 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004d50:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004d54:	fc5ff06f          	j	80004d18 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004d58:	01813083          	ld	ra,24(sp)
    80004d5c:	01013403          	ld	s0,16(sp)
    80004d60:	00813483          	ld	s1,8(sp)
    80004d64:	02010113          	addi	sp,sp,32
    80004d68:	00008067          	ret

0000000080004d6c <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004d6c:	fe010113          	addi	sp,sp,-32
    80004d70:	00113c23          	sd	ra,24(sp)
    80004d74:	00813823          	sd	s0,16(sp)
    80004d78:	00913423          	sd	s1,8(sp)
    80004d7c:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004d80:	00006497          	auipc	s1,0x6
    80004d84:	4884b483          	ld	s1,1160(s1) # 8000b208 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004d88:	02048863          	beqz	s1,80004db8 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004d8c:	00000613          	li	a2,0
    80004d90:	01000593          	li	a1,16
    80004d94:	0004851b          	sext.w	a0,s1
    80004d98:	00000097          	auipc	ra,0x0
    80004d9c:	3b4080e7          	jalr	948(ra) # 8000514c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004da0:	00003517          	auipc	a0,0x3
    80004da4:	61050513          	addi	a0,a0,1552 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80004da8:	00000097          	auipc	ra,0x0
    80004dac:	360080e7          	jalr	864(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004db0:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004db4:	fd5ff06f          	j	80004d88 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004db8:	01813083          	ld	ra,24(sp)
    80004dbc:	01013403          	ld	s0,16(sp)
    80004dc0:	00813483          	ld	s1,8(sp)
    80004dc4:	02010113          	addi	sp,sp,32
    80004dc8:	00008067          	ret

0000000080004dcc <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004dcc:	fe010113          	addi	sp,sp,-32
    80004dd0:	00113c23          	sd	ra,24(sp)
    80004dd4:	00813823          	sd	s0,16(sp)
    80004dd8:	00913423          	sd	s1,8(sp)
    80004ddc:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004de0:	00006497          	auipc	s1,0x6
    80004de4:	4384b483          	ld	s1,1080(s1) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004de8:	02048863          	beqz	s1,80004e18 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004dec:	00000613          	li	a2,0
    80004df0:	01000593          	li	a1,16
    80004df4:	0004851b          	sext.w	a0,s1
    80004df8:	0000a097          	auipc	ra,0xa
    80004dfc:	00c080e7          	jalr	12(ra) # 8000ee04 <_Z8printIntiii>
        printString("\n");
    80004e00:	00003517          	auipc	a0,0x3
    80004e04:	5b050513          	addi	a0,a0,1456 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80004e08:	0000a097          	auipc	ra,0xa
    80004e0c:	e64080e7          	jalr	-412(ra) # 8000ec6c <_Z11printStringPKc>
        iter = iter->next;
    80004e10:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004e14:	fd5ff06f          	j	80004de8 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004e18:	01813083          	ld	ra,24(sp)
    80004e1c:	01013403          	ld	s0,16(sp)
    80004e20:	00813483          	ld	s1,8(sp)
    80004e24:	02010113          	addi	sp,sp,32
    80004e28:	00008067          	ret

0000000080004e2c <_ZN11ConsoleUtil10initializeEv>:
//char ConsoleUtil::inputBuffer[8192];
//char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    80004e2c:	fe010113          	addi	sp,sp,-32
    80004e30:	00113c23          	sd	ra,24(sp)
    80004e34:	00813823          	sd	s0,16(sp)
    80004e38:	00913423          	sd	s1,8(sp)
    80004e3c:	01213023          	sd	s2,0(sp)
    80004e40:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004e44:	01800513          	li	a0,24
    80004e48:	ffffe097          	auipc	ra,0xffffe
    80004e4c:	f14080e7          	jalr	-236(ra) # 80002d5c <_ZN3SCBnwEm>
    80004e50:	00050493          	mv	s1,a0
    80004e54:	00050863          	beqz	a0,80004e64 <_ZN11ConsoleUtil10initializeEv+0x38>
    80004e58:	00000593          	li	a1,0
    80004e5c:	ffffe097          	auipc	ra,0xffffe
    80004e60:	d4c080e7          	jalr	-692(ra) # 80002ba8 <_ZN3SCBC1Em>
    80004e64:	00006797          	auipc	a5,0x6
    80004e68:	3a97be23          	sd	s1,956(a5) # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004e6c:	01800513          	li	a0,24
    80004e70:	ffffe097          	auipc	ra,0xffffe
    80004e74:	eec080e7          	jalr	-276(ra) # 80002d5c <_ZN3SCBnwEm>
    80004e78:	00050493          	mv	s1,a0
    80004e7c:	00050863          	beqz	a0,80004e8c <_ZN11ConsoleUtil10initializeEv+0x60>
    80004e80:	00000593          	li	a1,0
    80004e84:	ffffe097          	auipc	ra,0xffffe
    80004e88:	d24080e7          	jalr	-732(ra) # 80002ba8 <_ZN3SCBC1Em>
    80004e8c:	00006917          	auipc	s2,0x6
    80004e90:	39490913          	addi	s2,s2,916 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004e94:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80004e98:	00006497          	auipc	s1,0x6
    80004e9c:	04848493          	addi	s1,s1,72 # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004ea0:	0004b503          	ld	a0,0(s1)
    80004ea4:	00000097          	auipc	ra,0x0
    80004ea8:	538080e7          	jalr	1336(ra) # 800053dc <_Z7kmallocm>
    80004eac:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80004eb0:	0004b503          	ld	a0,0(s1)
    80004eb4:	00000097          	auipc	ra,0x0
    80004eb8:	528080e7          	jalr	1320(ra) # 800053dc <_Z7kmallocm>
    80004ebc:	00a93c23          	sd	a0,24(s2)
}
    80004ec0:	01813083          	ld	ra,24(sp)
    80004ec4:	01013403          	ld	s0,16(sp)
    80004ec8:	00813483          	ld	s1,8(sp)
    80004ecc:	00013903          	ld	s2,0(sp)
    80004ed0:	02010113          	addi	sp,sp,32
    80004ed4:	00008067          	ret
    80004ed8:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004edc:	00048513          	mv	a0,s1
    80004ee0:	ffffe097          	auipc	ra,0xffffe
    80004ee4:	eac080e7          	jalr	-340(ra) # 80002d8c <_ZN3SCBdlEPv>
    80004ee8:	00090513          	mv	a0,s2
    80004eec:	00007097          	auipc	ra,0x7
    80004ef0:	44c080e7          	jalr	1100(ra) # 8000c338 <_Unwind_Resume>
    80004ef4:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004ef8:	00048513          	mv	a0,s1
    80004efc:	ffffe097          	auipc	ra,0xffffe
    80004f00:	e90080e7          	jalr	-368(ra) # 80002d8c <_ZN3SCBdlEPv>
    80004f04:	00090513          	mv	a0,s2
    80004f08:	00007097          	auipc	ra,0x7
    80004f0c:	430080e7          	jalr	1072(ra) # 8000c338 <_Unwind_Resume>

0000000080004f10 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004f10:	00006717          	auipc	a4,0x6
    80004f14:	31070713          	addi	a4,a4,784 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004f18:	02073683          	ld	a3,32(a4)
    80004f1c:	00168793          	addi	a5,a3,1
    80004f20:	00006617          	auipc	a2,0x6
    80004f24:	fc063603          	ld	a2,-64(a2) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004f28:	02c7f7b3          	remu	a5,a5,a2
    80004f2c:	02873703          	ld	a4,40(a4)
    80004f30:	04e78e63          	beq	a5,a4,80004f8c <_ZN11ConsoleUtil8putInputEc+0x7c>
void ConsoleUtil::putInput(char c) {
    80004f34:	ff010113          	addi	sp,sp,-16
    80004f38:	00113423          	sd	ra,8(sp)
    80004f3c:	00813023          	sd	s0,0(sp)
    80004f40:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004f44:	00006717          	auipc	a4,0x6
    80004f48:	2dc70713          	addi	a4,a4,732 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004f4c:	01073783          	ld	a5,16(a4)
    80004f50:	00d786b3          	add	a3,a5,a3
    80004f54:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    80004f58:	02073783          	ld	a5,32(a4)
    80004f5c:	00178793          	addi	a5,a5,1
    80004f60:	00006697          	auipc	a3,0x6
    80004f64:	f806b683          	ld	a3,-128(a3) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004f68:	02d7f7b3          	remu	a5,a5,a3
    80004f6c:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    80004f70:	00073503          	ld	a0,0(a4)
    80004f74:	ffffe097          	auipc	ra,0xffffe
    80004f78:	dac080e7          	jalr	-596(ra) # 80002d20 <_ZN3SCB6signalEv>
}
    80004f7c:	00813083          	ld	ra,8(sp)
    80004f80:	00013403          	ld	s0,0(sp)
    80004f84:	01010113          	addi	sp,sp,16
    80004f88:	00008067          	ret
    80004f8c:	00008067          	ret

0000000080004f90 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004f90:	fe010113          	addi	sp,sp,-32
    80004f94:	00113c23          	sd	ra,24(sp)
    80004f98:	00813823          	sd	s0,16(sp)
    80004f9c:	00913423          	sd	s1,8(sp)
    80004fa0:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004fa4:	00006497          	auipc	s1,0x6
    80004fa8:	27c48493          	addi	s1,s1,636 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004fac:	0004b503          	ld	a0,0(s1)
    80004fb0:	ffffe097          	auipc	ra,0xffffe
    80004fb4:	d20080e7          	jalr	-736(ra) # 80002cd0 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004fb8:	0284b783          	ld	a5,40(s1)
    80004fbc:	0204b703          	ld	a4,32(s1)
    80004fc0:	02e78c63          	beq	a5,a4,80004ff8 <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    80004fc4:	0104b703          	ld	a4,16(s1)
    80004fc8:	00f70733          	add	a4,a4,a5
    80004fcc:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004fd0:	00178793          	addi	a5,a5,1
    80004fd4:	00006717          	auipc	a4,0x6
    80004fd8:	f0c73703          	ld	a4,-244(a4) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004fdc:	02e7f7b3          	remu	a5,a5,a4
    80004fe0:	02f4b423          	sd	a5,40(s1)

    return c;
}
    80004fe4:	01813083          	ld	ra,24(sp)
    80004fe8:	01013403          	ld	s0,16(sp)
    80004fec:	00813483          	ld	s1,8(sp)
    80004ff0:	02010113          	addi	sp,sp,32
    80004ff4:	00008067          	ret
        return -1;
    80004ff8:	0ff00513          	li	a0,255
    80004ffc:	fe9ff06f          	j	80004fe4 <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080005000 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80005000:	00006797          	auipc	a5,0x6
    80005004:	22078793          	addi	a5,a5,544 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80005008:	0307b703          	ld	a4,48(a5)
    8000500c:	00170713          	addi	a4,a4,1
    80005010:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80005014:	0387b683          	ld	a3,56(a5)
    80005018:	00168713          	addi	a4,a3,1
    8000501c:	00006617          	auipc	a2,0x6
    80005020:	ec463603          	ld	a2,-316(a2) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80005024:	02c77733          	remu	a4,a4,a2
    80005028:	0407b783          	ld	a5,64(a5)
    8000502c:	06f70463          	beq	a4,a5,80005094 <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    80005030:	ff010113          	addi	sp,sp,-16
    80005034:	00113423          	sd	ra,8(sp)
    80005038:	00813023          	sd	s0,0(sp)
    8000503c:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80005040:	00006797          	auipc	a5,0x6
    80005044:	1e078793          	addi	a5,a5,480 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80005048:	0187b703          	ld	a4,24(a5)
    8000504c:	00d706b3          	add	a3,a4,a3
    80005050:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    80005054:	0387b703          	ld	a4,56(a5)
    80005058:	00170713          	addi	a4,a4,1
    8000505c:	00006697          	auipc	a3,0x6
    80005060:	e846b683          	ld	a3,-380(a3) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80005064:	02d77733          	remu	a4,a4,a3
    80005068:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    8000506c:	0307b703          	ld	a4,48(a5)
    80005070:	fff70713          	addi	a4,a4,-1
    80005074:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    80005078:	0087b503          	ld	a0,8(a5)
    8000507c:	ffffe097          	auipc	ra,0xffffe
    80005080:	ca4080e7          	jalr	-860(ra) # 80002d20 <_ZN3SCB6signalEv>
}
    80005084:	00813083          	ld	ra,8(sp)
    80005088:	00013403          	ld	s0,0(sp)
    8000508c:	01010113          	addi	sp,sp,16
    80005090:	00008067          	ret
    80005094:	00008067          	ret

0000000080005098 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80005098:	fe010113          	addi	sp,sp,-32
    8000509c:	00113c23          	sd	ra,24(sp)
    800050a0:	00813823          	sd	s0,16(sp)
    800050a4:	00913423          	sd	s1,8(sp)
    800050a8:	02010413          	addi	s0,sp,32
    outputSem->wait();
    800050ac:	00006497          	auipc	s1,0x6
    800050b0:	17448493          	addi	s1,s1,372 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    800050b4:	0084b503          	ld	a0,8(s1)
    800050b8:	ffffe097          	auipc	ra,0xffffe
    800050bc:	c18080e7          	jalr	-1000(ra) # 80002cd0 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    800050c0:	0404b783          	ld	a5,64(s1)
    800050c4:	0384b703          	ld	a4,56(s1)
    800050c8:	02e78c63          	beq	a5,a4,80005100 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    800050cc:	0184b703          	ld	a4,24(s1)
    800050d0:	00f70733          	add	a4,a4,a5
    800050d4:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    800050d8:	00178793          	addi	a5,a5,1
    800050dc:	00006717          	auipc	a4,0x6
    800050e0:	e0473703          	ld	a4,-508(a4) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    800050e4:	02e7f7b3          	remu	a5,a5,a4
    800050e8:	04f4b023          	sd	a5,64(s1)

    return c;
}
    800050ec:	01813083          	ld	ra,24(sp)
    800050f0:	01013403          	ld	s0,16(sp)
    800050f4:	00813483          	ld	s1,8(sp)
    800050f8:	02010113          	addi	sp,sp,32
    800050fc:	00008067          	ret
        return -1;
    80005100:	0ff00513          	li	a0,255
    80005104:	fe9ff06f          	j	800050ec <_ZN11ConsoleUtil9getOutputEv+0x54>

0000000080005108 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80005108:	fe010113          	addi	sp,sp,-32
    8000510c:	00113c23          	sd	ra,24(sp)
    80005110:	00813823          	sd	s0,16(sp)
    80005114:	00913423          	sd	s1,8(sp)
    80005118:	02010413          	addi	s0,sp,32
    8000511c:	00050493          	mv	s1,a0
    while (*string != '\0')
    80005120:	0004c503          	lbu	a0,0(s1)
    80005124:	00050a63          	beqz	a0,80005138 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80005128:	00000097          	auipc	ra,0x0
    8000512c:	ed8080e7          	jalr	-296(ra) # 80005000 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80005130:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80005134:	fedff06f          	j	80005120 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80005138:	01813083          	ld	ra,24(sp)
    8000513c:	01013403          	ld	s0,16(sp)
    80005140:	00813483          	ld	s1,8(sp)
    80005144:	02010113          	addi	sp,sp,32
    80005148:	00008067          	ret

000000008000514c <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    8000514c:	fb010113          	addi	sp,sp,-80
    80005150:	04113423          	sd	ra,72(sp)
    80005154:	04813023          	sd	s0,64(sp)
    80005158:	02913c23          	sd	s1,56(sp)
    8000515c:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80005160:	00003797          	auipc	a5,0x3
    80005164:	45078793          	addi	a5,a5,1104 # 800085b0 <CONSOLE_STATUS+0x5a0>
    80005168:	0007b703          	ld	a4,0(a5)
    8000516c:	fce43423          	sd	a4,-56(s0)
    80005170:	0087b703          	ld	a4,8(a5)
    80005174:	fce43823          	sd	a4,-48(s0)
    80005178:	0107c783          	lbu	a5,16(a5)
    8000517c:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80005180:	00060463          	beqz	a2,80005188 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80005184:	08054263          	bltz	a0,80005208 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80005188:	0005051b          	sext.w	a0,a0
    neg = 0;
    8000518c:	00000813          	li	a6,0
    }

    i = 0;
    80005190:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80005194:	0005871b          	sext.w	a4,a1
    80005198:	02b577bb          	remuw	a5,a0,a1
    8000519c:	00048693          	mv	a3,s1
    800051a0:	0014849b          	addiw	s1,s1,1
    800051a4:	02079793          	slli	a5,a5,0x20
    800051a8:	0207d793          	srli	a5,a5,0x20
    800051ac:	fe040613          	addi	a2,s0,-32
    800051b0:	00f607b3          	add	a5,a2,a5
    800051b4:	fe87c603          	lbu	a2,-24(a5)
    800051b8:	fe040793          	addi	a5,s0,-32
    800051bc:	00d787b3          	add	a5,a5,a3
    800051c0:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    800051c4:	0005061b          	sext.w	a2,a0
    800051c8:	02b5553b          	divuw	a0,a0,a1
    800051cc:	fce674e3          	bgeu	a2,a4,80005194 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    800051d0:	00080c63          	beqz	a6,800051e8 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    800051d4:	fe040793          	addi	a5,s0,-32
    800051d8:	009784b3          	add	s1,a5,s1
    800051dc:	02d00793          	li	a5,45
    800051e0:	fcf48c23          	sb	a5,-40(s1)
    800051e4:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    800051e8:	fff4849b          	addiw	s1,s1,-1
    800051ec:	0204c463          	bltz	s1,80005214 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    800051f0:	fe040793          	addi	a5,s0,-32
    800051f4:	009787b3          	add	a5,a5,s1
    800051f8:	fd87c503          	lbu	a0,-40(a5)
    800051fc:	00000097          	auipc	ra,0x0
    80005200:	e04080e7          	jalr	-508(ra) # 80005000 <_ZN11ConsoleUtil9putOutputEc>
    80005204:	fe5ff06f          	j	800051e8 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80005208:	40a0053b          	negw	a0,a0
        neg = 1;
    8000520c:	00100813          	li	a6,1
        x = -xx;
    80005210:	f81ff06f          	j	80005190 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80005214:	04813083          	ld	ra,72(sp)
    80005218:	04013403          	ld	s0,64(sp)
    8000521c:	03813483          	ld	s1,56(sp)
    80005220:	05010113          	addi	sp,sp,80
    80005224:	00008067          	ret

0000000080005228 <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    80005228:	fd010113          	addi	sp,sp,-48
    8000522c:	02113423          	sd	ra,40(sp)
    80005230:	02813023          	sd	s0,32(sp)
    80005234:	00913c23          	sd	s1,24(sp)
    80005238:	01213823          	sd	s2,16(sp)
    8000523c:	01313423          	sd	s3,8(sp)
    80005240:	03010413          	addi	s0,sp,48
    80005244:	00058913          	mv	s2,a1
    80005248:	00060493          	mv	s1,a2
    8000524c:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    80005250:	00000097          	auipc	ra,0x0
    80005254:	eb8080e7          	jalr	-328(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    80005258:	00000613          	li	a2,0
    8000525c:	00098593          	mv	a1,s3
    80005260:	00090513          	mv	a0,s2
    80005264:	00000097          	auipc	ra,0x0
    80005268:	ee8080e7          	jalr	-280(ra) # 8000514c <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    8000526c:	00048513          	mv	a0,s1
    80005270:	00000097          	auipc	ra,0x0
    80005274:	e98080e7          	jalr	-360(ra) # 80005108 <_ZN11ConsoleUtil11printStringEPKc>
}
    80005278:	02813083          	ld	ra,40(sp)
    8000527c:	02013403          	ld	s0,32(sp)
    80005280:	01813483          	ld	s1,24(sp)
    80005284:	01013903          	ld	s2,16(sp)
    80005288:	00813983          	ld	s3,8(sp)
    8000528c:	03010113          	addi	sp,sp,48
    80005290:	00008067          	ret

0000000080005294 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80005294:	ff010113          	addi	sp,sp,-16
    80005298:	00813423          	sd	s0,8(sp)
    8000529c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    800052a0:	04300513          	li	a0,67

    asm("ecall");
    800052a4:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    800052a8:	00050513          	mv	a0,a0

    return (char)status;
}
    800052ac:	0ff57513          	andi	a0,a0,255
    800052b0:	00813403          	ld	s0,8(sp)
    800052b4:	01010113          	addi	sp,sp,16
    800052b8:	00008067          	ret

00000000800052bc <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/kernel/slab.hpp"

void kmem_init(void* space, int block_num){
    800052bc:	ff010113          	addi	sp,sp,-16
    800052c0:	00113423          	sd	ra,8(sp)
    800052c4:	00813023          	sd	s0,0(sp)
    800052c8:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    800052cc:	ffffd097          	auipc	ra,0xffffd
    800052d0:	818080e7          	jalr	-2024(ra) # 80001ae4 <_ZN13SlabAllocator10initializeEPvm>
}
    800052d4:	00813083          	ld	ra,8(sp)
    800052d8:	00013403          	ld	s0,0(sp)
    800052dc:	01010113          	addi	sp,sp,16
    800052e0:	00008067          	ret

00000000800052e4 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    800052e4:	ff010113          	addi	sp,sp,-16
    800052e8:	00113423          	sd	ra,8(sp)
    800052ec:	00813023          	sd	s0,0(sp)
    800052f0:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    800052f4:	ffffc097          	auipc	ra,0xffffc
    800052f8:	6e4080e7          	jalr	1764(ra) # 800019d8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    800052fc:	00813083          	ld	ra,8(sp)
    80005300:	00013403          	ld	s0,0(sp)
    80005304:	01010113          	addi	sp,sp,16
    80005308:	00008067          	ret

000000008000530c <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    8000530c:	ff010113          	addi	sp,sp,-16
    80005310:	00113423          	sd	ra,8(sp)
    80005314:	00813023          	sd	s0,0(sp)
    80005318:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    8000531c:	ffffc097          	auipc	ra,0xffffc
    80005320:	490080e7          	jalr	1168(ra) # 800017ac <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80005324:	00813083          	ld	ra,8(sp)
    80005328:	00013403          	ld	s0,0(sp)
    8000532c:	01010113          	addi	sp,sp,16
    80005330:	00008067          	ret

0000000080005334 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80005334:	ff010113          	addi	sp,sp,-16
    80005338:	00113423          	sd	ra,8(sp)
    8000533c:	00813023          	sd	s0,0(sp)
    80005340:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80005344:	ffffd097          	auipc	ra,0xffffd
    80005348:	9ec080e7          	jalr	-1556(ra) # 80001d30 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    8000534c:	00813083          	ld	ra,8(sp)
    80005350:	00013403          	ld	s0,0(sp)
    80005354:	01010113          	addi	sp,sp,16
    80005358:	00008067          	ret

000000008000535c <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    8000535c:	fe010113          	addi	sp,sp,-32
    80005360:	00113c23          	sd	ra,24(sp)
    80005364:	00813823          	sd	s0,16(sp)
    80005368:	02010413          	addi	s0,sp,32
    8000536c:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80005370:	fe840513          	addi	a0,s0,-24
    80005374:	ffffd097          	auipc	ra,0xffffd
    80005378:	b1c080e7          	jalr	-1252(ra) # 80001e90 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    8000537c:	01813083          	ld	ra,24(sp)
    80005380:	01013403          	ld	s0,16(sp)
    80005384:	02010113          	addi	sp,sp,32
    80005388:	00008067          	ret

000000008000538c <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    8000538c:	ff010113          	addi	sp,sp,-16
    80005390:	00113423          	sd	ra,8(sp)
    80005394:	00813023          	sd	s0,0(sp)
    80005398:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    8000539c:	ffffc097          	auipc	ra,0xffffc
    800053a0:	f5c080e7          	jalr	-164(ra) # 800012f8 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    800053a4:	00813083          	ld	ra,8(sp)
    800053a8:	00013403          	ld	s0,0(sp)
    800053ac:	01010113          	addi	sp,sp,16
    800053b0:	00008067          	ret

00000000800053b4 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    800053b4:	ff010113          	addi	sp,sp,-16
    800053b8:	00113423          	sd	ra,8(sp)
    800053bc:	00813023          	sd	s0,0(sp)
    800053c0:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    800053c4:	ffffc097          	auipc	ra,0xffffc
    800053c8:	d70080e7          	jalr	-656(ra) # 80001134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    800053cc:	00813083          	ld	ra,8(sp)
    800053d0:	00013403          	ld	s0,0(sp)
    800053d4:	01010113          	addi	sp,sp,16
    800053d8:	00008067          	ret

00000000800053dc <_Z7kmallocm>:
void* kmalloc(size_t size){
    800053dc:	ff010113          	addi	sp,sp,-16
    800053e0:	00113423          	sd	ra,8(sp)
    800053e4:	00813023          	sd	s0,0(sp)
    800053e8:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    800053ec:	ffffc097          	auipc	ra,0xffffc
    800053f0:	54c080e7          	jalr	1356(ra) # 80001938 <_ZN13SlabAllocator14allocateBufferEm>
}
    800053f4:	00813083          	ld	ra,8(sp)
    800053f8:	00013403          	ld	s0,0(sp)
    800053fc:	01010113          	addi	sp,sp,16
    80005400:	00008067          	ret

0000000080005404 <_Z5kfreePKv>:

void kfree(const void* objp){
    80005404:	ff010113          	addi	sp,sp,-16
    80005408:	00113423          	sd	ra,8(sp)
    8000540c:	00813023          	sd	s0,0(sp)
    80005410:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80005414:	ffffd097          	auipc	ra,0xffffd
    80005418:	a10080e7          	jalr	-1520(ra) # 80001e24 <_ZN13SlabAllocator10freeBufferEPKv>
    8000541c:	00813083          	ld	ra,8(sp)
    80005420:	00013403          	ld	s0,0(sp)
    80005424:	01010113          	addi	sp,sp,16
    80005428:	00008067          	ret

000000008000542c <start>:
    8000542c:	ff010113          	addi	sp,sp,-16
    80005430:	00813423          	sd	s0,8(sp)
    80005434:	01010413          	addi	s0,sp,16
    80005438:	300027f3          	csrr	a5,mstatus
    8000543c:	ffffe737          	lui	a4,0xffffe
    80005440:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed7ff>
    80005444:	00e7f7b3          	and	a5,a5,a4
    80005448:	00001737          	lui	a4,0x1
    8000544c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005450:	00e7e7b3          	or	a5,a5,a4
    80005454:	30079073          	csrw	mstatus,a5
    80005458:	00000797          	auipc	a5,0x0
    8000545c:	16078793          	addi	a5,a5,352 # 800055b8 <system_main>
    80005460:	34179073          	csrw	mepc,a5
    80005464:	00000793          	li	a5,0
    80005468:	18079073          	csrw	satp,a5
    8000546c:	000107b7          	lui	a5,0x10
    80005470:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005474:	30279073          	csrw	medeleg,a5
    80005478:	30379073          	csrw	mideleg,a5
    8000547c:	104027f3          	csrr	a5,sie
    80005480:	2227e793          	ori	a5,a5,546
    80005484:	10479073          	csrw	sie,a5
    80005488:	fff00793          	li	a5,-1
    8000548c:	00a7d793          	srli	a5,a5,0xa
    80005490:	3b079073          	csrw	pmpaddr0,a5
    80005494:	00f00793          	li	a5,15
    80005498:	3a079073          	csrw	pmpcfg0,a5
    8000549c:	f14027f3          	csrr	a5,mhartid
    800054a0:	0200c737          	lui	a4,0x200c
    800054a4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800054a8:	0007869b          	sext.w	a3,a5
    800054ac:	00269713          	slli	a4,a3,0x2
    800054b0:	000f4637          	lui	a2,0xf4
    800054b4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800054b8:	00d70733          	add	a4,a4,a3
    800054bc:	0037979b          	slliw	a5,a5,0x3
    800054c0:	020046b7          	lui	a3,0x2004
    800054c4:	00d787b3          	add	a5,a5,a3
    800054c8:	00c585b3          	add	a1,a1,a2
    800054cc:	00371693          	slli	a3,a4,0x3
    800054d0:	00006717          	auipc	a4,0x6
    800054d4:	da070713          	addi	a4,a4,-608 # 8000b270 <timer_scratch>
    800054d8:	00b7b023          	sd	a1,0(a5)
    800054dc:	00d70733          	add	a4,a4,a3
    800054e0:	00f73c23          	sd	a5,24(a4)
    800054e4:	02c73023          	sd	a2,32(a4)
    800054e8:	34071073          	csrw	mscratch,a4
    800054ec:	00000797          	auipc	a5,0x0
    800054f0:	6e478793          	addi	a5,a5,1764 # 80005bd0 <timervec>
    800054f4:	30579073          	csrw	mtvec,a5
    800054f8:	300027f3          	csrr	a5,mstatus
    800054fc:	0087e793          	ori	a5,a5,8
    80005500:	30079073          	csrw	mstatus,a5
    80005504:	304027f3          	csrr	a5,mie
    80005508:	0807e793          	ori	a5,a5,128
    8000550c:	30479073          	csrw	mie,a5
    80005510:	f14027f3          	csrr	a5,mhartid
    80005514:	0007879b          	sext.w	a5,a5
    80005518:	00078213          	mv	tp,a5
    8000551c:	30200073          	mret
    80005520:	00813403          	ld	s0,8(sp)
    80005524:	01010113          	addi	sp,sp,16
    80005528:	00008067          	ret

000000008000552c <timerinit>:
    8000552c:	ff010113          	addi	sp,sp,-16
    80005530:	00813423          	sd	s0,8(sp)
    80005534:	01010413          	addi	s0,sp,16
    80005538:	f14027f3          	csrr	a5,mhartid
    8000553c:	0200c737          	lui	a4,0x200c
    80005540:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005544:	0007869b          	sext.w	a3,a5
    80005548:	00269713          	slli	a4,a3,0x2
    8000554c:	000f4637          	lui	a2,0xf4
    80005550:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005554:	00d70733          	add	a4,a4,a3
    80005558:	0037979b          	slliw	a5,a5,0x3
    8000555c:	020046b7          	lui	a3,0x2004
    80005560:	00d787b3          	add	a5,a5,a3
    80005564:	00c585b3          	add	a1,a1,a2
    80005568:	00371693          	slli	a3,a4,0x3
    8000556c:	00006717          	auipc	a4,0x6
    80005570:	d0470713          	addi	a4,a4,-764 # 8000b270 <timer_scratch>
    80005574:	00b7b023          	sd	a1,0(a5)
    80005578:	00d70733          	add	a4,a4,a3
    8000557c:	00f73c23          	sd	a5,24(a4)
    80005580:	02c73023          	sd	a2,32(a4)
    80005584:	34071073          	csrw	mscratch,a4
    80005588:	00000797          	auipc	a5,0x0
    8000558c:	64878793          	addi	a5,a5,1608 # 80005bd0 <timervec>
    80005590:	30579073          	csrw	mtvec,a5
    80005594:	300027f3          	csrr	a5,mstatus
    80005598:	0087e793          	ori	a5,a5,8
    8000559c:	30079073          	csrw	mstatus,a5
    800055a0:	304027f3          	csrr	a5,mie
    800055a4:	0807e793          	ori	a5,a5,128
    800055a8:	30479073          	csrw	mie,a5
    800055ac:	00813403          	ld	s0,8(sp)
    800055b0:	01010113          	addi	sp,sp,16
    800055b4:	00008067          	ret

00000000800055b8 <system_main>:
    800055b8:	fe010113          	addi	sp,sp,-32
    800055bc:	00813823          	sd	s0,16(sp)
    800055c0:	00913423          	sd	s1,8(sp)
    800055c4:	00113c23          	sd	ra,24(sp)
    800055c8:	02010413          	addi	s0,sp,32
    800055cc:	00000097          	auipc	ra,0x0
    800055d0:	0c4080e7          	jalr	196(ra) # 80005690 <cpuid>
    800055d4:	00006497          	auipc	s1,0x6
    800055d8:	a1c48493          	addi	s1,s1,-1508 # 8000aff0 <started>
    800055dc:	02050263          	beqz	a0,80005600 <system_main+0x48>
    800055e0:	0004a783          	lw	a5,0(s1)
    800055e4:	0007879b          	sext.w	a5,a5
    800055e8:	fe078ce3          	beqz	a5,800055e0 <system_main+0x28>
    800055ec:	0ff0000f          	fence
    800055f0:	00003517          	auipc	a0,0x3
    800055f4:	00850513          	addi	a0,a0,8 # 800085f8 <CONSOLE_STATUS+0x5e8>
    800055f8:	00001097          	auipc	ra,0x1
    800055fc:	a74080e7          	jalr	-1420(ra) # 8000606c <panic>
    80005600:	00001097          	auipc	ra,0x1
    80005604:	9c8080e7          	jalr	-1592(ra) # 80005fc8 <consoleinit>
    80005608:	00001097          	auipc	ra,0x1
    8000560c:	154080e7          	jalr	340(ra) # 8000675c <printfinit>
    80005610:	00003517          	auipc	a0,0x3
    80005614:	da050513          	addi	a0,a0,-608 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80005618:	00001097          	auipc	ra,0x1
    8000561c:	ab0080e7          	jalr	-1360(ra) # 800060c8 <__printf>
    80005620:	00003517          	auipc	a0,0x3
    80005624:	fa850513          	addi	a0,a0,-88 # 800085c8 <CONSOLE_STATUS+0x5b8>
    80005628:	00001097          	auipc	ra,0x1
    8000562c:	aa0080e7          	jalr	-1376(ra) # 800060c8 <__printf>
    80005630:	00003517          	auipc	a0,0x3
    80005634:	d8050513          	addi	a0,a0,-640 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80005638:	00001097          	auipc	ra,0x1
    8000563c:	a90080e7          	jalr	-1392(ra) # 800060c8 <__printf>
    80005640:	00001097          	auipc	ra,0x1
    80005644:	4a8080e7          	jalr	1192(ra) # 80006ae8 <kinit>
    80005648:	00000097          	auipc	ra,0x0
    8000564c:	148080e7          	jalr	328(ra) # 80005790 <trapinit>
    80005650:	00000097          	auipc	ra,0x0
    80005654:	16c080e7          	jalr	364(ra) # 800057bc <trapinithart>
    80005658:	00000097          	auipc	ra,0x0
    8000565c:	5b8080e7          	jalr	1464(ra) # 80005c10 <plicinit>
    80005660:	00000097          	auipc	ra,0x0
    80005664:	5d8080e7          	jalr	1496(ra) # 80005c38 <plicinithart>
    80005668:	00000097          	auipc	ra,0x0
    8000566c:	078080e7          	jalr	120(ra) # 800056e0 <userinit>
    80005670:	0ff0000f          	fence
    80005674:	00100793          	li	a5,1
    80005678:	00003517          	auipc	a0,0x3
    8000567c:	f6850513          	addi	a0,a0,-152 # 800085e0 <CONSOLE_STATUS+0x5d0>
    80005680:	00f4a023          	sw	a5,0(s1)
    80005684:	00001097          	auipc	ra,0x1
    80005688:	a44080e7          	jalr	-1468(ra) # 800060c8 <__printf>
    8000568c:	0000006f          	j	8000568c <system_main+0xd4>

0000000080005690 <cpuid>:
    80005690:	ff010113          	addi	sp,sp,-16
    80005694:	00813423          	sd	s0,8(sp)
    80005698:	01010413          	addi	s0,sp,16
    8000569c:	00020513          	mv	a0,tp
    800056a0:	00813403          	ld	s0,8(sp)
    800056a4:	0005051b          	sext.w	a0,a0
    800056a8:	01010113          	addi	sp,sp,16
    800056ac:	00008067          	ret

00000000800056b0 <mycpu>:
    800056b0:	ff010113          	addi	sp,sp,-16
    800056b4:	00813423          	sd	s0,8(sp)
    800056b8:	01010413          	addi	s0,sp,16
    800056bc:	00020793          	mv	a5,tp
    800056c0:	00813403          	ld	s0,8(sp)
    800056c4:	0007879b          	sext.w	a5,a5
    800056c8:	00779793          	slli	a5,a5,0x7
    800056cc:	00007517          	auipc	a0,0x7
    800056d0:	bd450513          	addi	a0,a0,-1068 # 8000c2a0 <cpus>
    800056d4:	00f50533          	add	a0,a0,a5
    800056d8:	01010113          	addi	sp,sp,16
    800056dc:	00008067          	ret

00000000800056e0 <userinit>:
    800056e0:	ff010113          	addi	sp,sp,-16
    800056e4:	00813423          	sd	s0,8(sp)
    800056e8:	01010413          	addi	s0,sp,16
    800056ec:	00813403          	ld	s0,8(sp)
    800056f0:	01010113          	addi	sp,sp,16
    800056f4:	ffffd317          	auipc	t1,0xffffd
    800056f8:	6f830067          	jr	1784(t1) # 80002dec <main>

00000000800056fc <either_copyout>:
    800056fc:	ff010113          	addi	sp,sp,-16
    80005700:	00813023          	sd	s0,0(sp)
    80005704:	00113423          	sd	ra,8(sp)
    80005708:	01010413          	addi	s0,sp,16
    8000570c:	02051663          	bnez	a0,80005738 <either_copyout+0x3c>
    80005710:	00058513          	mv	a0,a1
    80005714:	00060593          	mv	a1,a2
    80005718:	0006861b          	sext.w	a2,a3
    8000571c:	00002097          	auipc	ra,0x2
    80005720:	c58080e7          	jalr	-936(ra) # 80007374 <__memmove>
    80005724:	00813083          	ld	ra,8(sp)
    80005728:	00013403          	ld	s0,0(sp)
    8000572c:	00000513          	li	a0,0
    80005730:	01010113          	addi	sp,sp,16
    80005734:	00008067          	ret
    80005738:	00003517          	auipc	a0,0x3
    8000573c:	ee850513          	addi	a0,a0,-280 # 80008620 <CONSOLE_STATUS+0x610>
    80005740:	00001097          	auipc	ra,0x1
    80005744:	92c080e7          	jalr	-1748(ra) # 8000606c <panic>

0000000080005748 <either_copyin>:
    80005748:	ff010113          	addi	sp,sp,-16
    8000574c:	00813023          	sd	s0,0(sp)
    80005750:	00113423          	sd	ra,8(sp)
    80005754:	01010413          	addi	s0,sp,16
    80005758:	02059463          	bnez	a1,80005780 <either_copyin+0x38>
    8000575c:	00060593          	mv	a1,a2
    80005760:	0006861b          	sext.w	a2,a3
    80005764:	00002097          	auipc	ra,0x2
    80005768:	c10080e7          	jalr	-1008(ra) # 80007374 <__memmove>
    8000576c:	00813083          	ld	ra,8(sp)
    80005770:	00013403          	ld	s0,0(sp)
    80005774:	00000513          	li	a0,0
    80005778:	01010113          	addi	sp,sp,16
    8000577c:	00008067          	ret
    80005780:	00003517          	auipc	a0,0x3
    80005784:	ec850513          	addi	a0,a0,-312 # 80008648 <CONSOLE_STATUS+0x638>
    80005788:	00001097          	auipc	ra,0x1
    8000578c:	8e4080e7          	jalr	-1820(ra) # 8000606c <panic>

0000000080005790 <trapinit>:
    80005790:	ff010113          	addi	sp,sp,-16
    80005794:	00813423          	sd	s0,8(sp)
    80005798:	01010413          	addi	s0,sp,16
    8000579c:	00813403          	ld	s0,8(sp)
    800057a0:	00003597          	auipc	a1,0x3
    800057a4:	ed058593          	addi	a1,a1,-304 # 80008670 <CONSOLE_STATUS+0x660>
    800057a8:	00007517          	auipc	a0,0x7
    800057ac:	b7850513          	addi	a0,a0,-1160 # 8000c320 <tickslock>
    800057b0:	01010113          	addi	sp,sp,16
    800057b4:	00001317          	auipc	t1,0x1
    800057b8:	5c430067          	jr	1476(t1) # 80006d78 <initlock>

00000000800057bc <trapinithart>:
    800057bc:	ff010113          	addi	sp,sp,-16
    800057c0:	00813423          	sd	s0,8(sp)
    800057c4:	01010413          	addi	s0,sp,16
    800057c8:	00000797          	auipc	a5,0x0
    800057cc:	2f878793          	addi	a5,a5,760 # 80005ac0 <kernelvec>
    800057d0:	10579073          	csrw	stvec,a5
    800057d4:	00813403          	ld	s0,8(sp)
    800057d8:	01010113          	addi	sp,sp,16
    800057dc:	00008067          	ret

00000000800057e0 <usertrap>:
    800057e0:	ff010113          	addi	sp,sp,-16
    800057e4:	00813423          	sd	s0,8(sp)
    800057e8:	01010413          	addi	s0,sp,16
    800057ec:	00813403          	ld	s0,8(sp)
    800057f0:	01010113          	addi	sp,sp,16
    800057f4:	00008067          	ret

00000000800057f8 <usertrapret>:
    800057f8:	ff010113          	addi	sp,sp,-16
    800057fc:	00813423          	sd	s0,8(sp)
    80005800:	01010413          	addi	s0,sp,16
    80005804:	00813403          	ld	s0,8(sp)
    80005808:	01010113          	addi	sp,sp,16
    8000580c:	00008067          	ret

0000000080005810 <kerneltrap>:
    80005810:	fe010113          	addi	sp,sp,-32
    80005814:	00813823          	sd	s0,16(sp)
    80005818:	00113c23          	sd	ra,24(sp)
    8000581c:	00913423          	sd	s1,8(sp)
    80005820:	02010413          	addi	s0,sp,32
    80005824:	142025f3          	csrr	a1,scause
    80005828:	100027f3          	csrr	a5,sstatus
    8000582c:	0027f793          	andi	a5,a5,2
    80005830:	10079c63          	bnez	a5,80005948 <kerneltrap+0x138>
    80005834:	142027f3          	csrr	a5,scause
    80005838:	0207ce63          	bltz	a5,80005874 <kerneltrap+0x64>
    8000583c:	00003517          	auipc	a0,0x3
    80005840:	e7c50513          	addi	a0,a0,-388 # 800086b8 <CONSOLE_STATUS+0x6a8>
    80005844:	00001097          	auipc	ra,0x1
    80005848:	884080e7          	jalr	-1916(ra) # 800060c8 <__printf>
    8000584c:	141025f3          	csrr	a1,sepc
    80005850:	14302673          	csrr	a2,stval
    80005854:	00003517          	auipc	a0,0x3
    80005858:	e7450513          	addi	a0,a0,-396 # 800086c8 <CONSOLE_STATUS+0x6b8>
    8000585c:	00001097          	auipc	ra,0x1
    80005860:	86c080e7          	jalr	-1940(ra) # 800060c8 <__printf>
    80005864:	00003517          	auipc	a0,0x3
    80005868:	e7c50513          	addi	a0,a0,-388 # 800086e0 <CONSOLE_STATUS+0x6d0>
    8000586c:	00001097          	auipc	ra,0x1
    80005870:	800080e7          	jalr	-2048(ra) # 8000606c <panic>
    80005874:	0ff7f713          	andi	a4,a5,255
    80005878:	00900693          	li	a3,9
    8000587c:	04d70063          	beq	a4,a3,800058bc <kerneltrap+0xac>
    80005880:	fff00713          	li	a4,-1
    80005884:	03f71713          	slli	a4,a4,0x3f
    80005888:	00170713          	addi	a4,a4,1
    8000588c:	fae798e3          	bne	a5,a4,8000583c <kerneltrap+0x2c>
    80005890:	00000097          	auipc	ra,0x0
    80005894:	e00080e7          	jalr	-512(ra) # 80005690 <cpuid>
    80005898:	06050663          	beqz	a0,80005904 <kerneltrap+0xf4>
    8000589c:	144027f3          	csrr	a5,sip
    800058a0:	ffd7f793          	andi	a5,a5,-3
    800058a4:	14479073          	csrw	sip,a5
    800058a8:	01813083          	ld	ra,24(sp)
    800058ac:	01013403          	ld	s0,16(sp)
    800058b0:	00813483          	ld	s1,8(sp)
    800058b4:	02010113          	addi	sp,sp,32
    800058b8:	00008067          	ret
    800058bc:	00000097          	auipc	ra,0x0
    800058c0:	3c8080e7          	jalr	968(ra) # 80005c84 <plic_claim>
    800058c4:	00a00793          	li	a5,10
    800058c8:	00050493          	mv	s1,a0
    800058cc:	06f50863          	beq	a0,a5,8000593c <kerneltrap+0x12c>
    800058d0:	fc050ce3          	beqz	a0,800058a8 <kerneltrap+0x98>
    800058d4:	00050593          	mv	a1,a0
    800058d8:	00003517          	auipc	a0,0x3
    800058dc:	dc050513          	addi	a0,a0,-576 # 80008698 <CONSOLE_STATUS+0x688>
    800058e0:	00000097          	auipc	ra,0x0
    800058e4:	7e8080e7          	jalr	2024(ra) # 800060c8 <__printf>
    800058e8:	01013403          	ld	s0,16(sp)
    800058ec:	01813083          	ld	ra,24(sp)
    800058f0:	00048513          	mv	a0,s1
    800058f4:	00813483          	ld	s1,8(sp)
    800058f8:	02010113          	addi	sp,sp,32
    800058fc:	00000317          	auipc	t1,0x0
    80005900:	3c030067          	jr	960(t1) # 80005cbc <plic_complete>
    80005904:	00007517          	auipc	a0,0x7
    80005908:	a1c50513          	addi	a0,a0,-1508 # 8000c320 <tickslock>
    8000590c:	00001097          	auipc	ra,0x1
    80005910:	490080e7          	jalr	1168(ra) # 80006d9c <acquire>
    80005914:	00005717          	auipc	a4,0x5
    80005918:	6e070713          	addi	a4,a4,1760 # 8000aff4 <ticks>
    8000591c:	00072783          	lw	a5,0(a4)
    80005920:	00007517          	auipc	a0,0x7
    80005924:	a0050513          	addi	a0,a0,-1536 # 8000c320 <tickslock>
    80005928:	0017879b          	addiw	a5,a5,1
    8000592c:	00f72023          	sw	a5,0(a4)
    80005930:	00001097          	auipc	ra,0x1
    80005934:	538080e7          	jalr	1336(ra) # 80006e68 <release>
    80005938:	f65ff06f          	j	8000589c <kerneltrap+0x8c>
    8000593c:	00001097          	auipc	ra,0x1
    80005940:	094080e7          	jalr	148(ra) # 800069d0 <uartintr>
    80005944:	fa5ff06f          	j	800058e8 <kerneltrap+0xd8>
    80005948:	00003517          	auipc	a0,0x3
    8000594c:	d3050513          	addi	a0,a0,-720 # 80008678 <CONSOLE_STATUS+0x668>
    80005950:	00000097          	auipc	ra,0x0
    80005954:	71c080e7          	jalr	1820(ra) # 8000606c <panic>

0000000080005958 <clockintr>:
    80005958:	fe010113          	addi	sp,sp,-32
    8000595c:	00813823          	sd	s0,16(sp)
    80005960:	00913423          	sd	s1,8(sp)
    80005964:	00113c23          	sd	ra,24(sp)
    80005968:	02010413          	addi	s0,sp,32
    8000596c:	00007497          	auipc	s1,0x7
    80005970:	9b448493          	addi	s1,s1,-1612 # 8000c320 <tickslock>
    80005974:	00048513          	mv	a0,s1
    80005978:	00001097          	auipc	ra,0x1
    8000597c:	424080e7          	jalr	1060(ra) # 80006d9c <acquire>
    80005980:	00005717          	auipc	a4,0x5
    80005984:	67470713          	addi	a4,a4,1652 # 8000aff4 <ticks>
    80005988:	00072783          	lw	a5,0(a4)
    8000598c:	01013403          	ld	s0,16(sp)
    80005990:	01813083          	ld	ra,24(sp)
    80005994:	00048513          	mv	a0,s1
    80005998:	0017879b          	addiw	a5,a5,1
    8000599c:	00813483          	ld	s1,8(sp)
    800059a0:	00f72023          	sw	a5,0(a4)
    800059a4:	02010113          	addi	sp,sp,32
    800059a8:	00001317          	auipc	t1,0x1
    800059ac:	4c030067          	jr	1216(t1) # 80006e68 <release>

00000000800059b0 <devintr>:
    800059b0:	142027f3          	csrr	a5,scause
    800059b4:	00000513          	li	a0,0
    800059b8:	0007c463          	bltz	a5,800059c0 <devintr+0x10>
    800059bc:	00008067          	ret
    800059c0:	fe010113          	addi	sp,sp,-32
    800059c4:	00813823          	sd	s0,16(sp)
    800059c8:	00113c23          	sd	ra,24(sp)
    800059cc:	00913423          	sd	s1,8(sp)
    800059d0:	02010413          	addi	s0,sp,32
    800059d4:	0ff7f713          	andi	a4,a5,255
    800059d8:	00900693          	li	a3,9
    800059dc:	04d70c63          	beq	a4,a3,80005a34 <devintr+0x84>
    800059e0:	fff00713          	li	a4,-1
    800059e4:	03f71713          	slli	a4,a4,0x3f
    800059e8:	00170713          	addi	a4,a4,1
    800059ec:	00e78c63          	beq	a5,a4,80005a04 <devintr+0x54>
    800059f0:	01813083          	ld	ra,24(sp)
    800059f4:	01013403          	ld	s0,16(sp)
    800059f8:	00813483          	ld	s1,8(sp)
    800059fc:	02010113          	addi	sp,sp,32
    80005a00:	00008067          	ret
    80005a04:	00000097          	auipc	ra,0x0
    80005a08:	c8c080e7          	jalr	-884(ra) # 80005690 <cpuid>
    80005a0c:	06050663          	beqz	a0,80005a78 <devintr+0xc8>
    80005a10:	144027f3          	csrr	a5,sip
    80005a14:	ffd7f793          	andi	a5,a5,-3
    80005a18:	14479073          	csrw	sip,a5
    80005a1c:	01813083          	ld	ra,24(sp)
    80005a20:	01013403          	ld	s0,16(sp)
    80005a24:	00813483          	ld	s1,8(sp)
    80005a28:	00200513          	li	a0,2
    80005a2c:	02010113          	addi	sp,sp,32
    80005a30:	00008067          	ret
    80005a34:	00000097          	auipc	ra,0x0
    80005a38:	250080e7          	jalr	592(ra) # 80005c84 <plic_claim>
    80005a3c:	00a00793          	li	a5,10
    80005a40:	00050493          	mv	s1,a0
    80005a44:	06f50663          	beq	a0,a5,80005ab0 <devintr+0x100>
    80005a48:	00100513          	li	a0,1
    80005a4c:	fa0482e3          	beqz	s1,800059f0 <devintr+0x40>
    80005a50:	00048593          	mv	a1,s1
    80005a54:	00003517          	auipc	a0,0x3
    80005a58:	c4450513          	addi	a0,a0,-956 # 80008698 <CONSOLE_STATUS+0x688>
    80005a5c:	00000097          	auipc	ra,0x0
    80005a60:	66c080e7          	jalr	1644(ra) # 800060c8 <__printf>
    80005a64:	00048513          	mv	a0,s1
    80005a68:	00000097          	auipc	ra,0x0
    80005a6c:	254080e7          	jalr	596(ra) # 80005cbc <plic_complete>
    80005a70:	00100513          	li	a0,1
    80005a74:	f7dff06f          	j	800059f0 <devintr+0x40>
    80005a78:	00007517          	auipc	a0,0x7
    80005a7c:	8a850513          	addi	a0,a0,-1880 # 8000c320 <tickslock>
    80005a80:	00001097          	auipc	ra,0x1
    80005a84:	31c080e7          	jalr	796(ra) # 80006d9c <acquire>
    80005a88:	00005717          	auipc	a4,0x5
    80005a8c:	56c70713          	addi	a4,a4,1388 # 8000aff4 <ticks>
    80005a90:	00072783          	lw	a5,0(a4)
    80005a94:	00007517          	auipc	a0,0x7
    80005a98:	88c50513          	addi	a0,a0,-1908 # 8000c320 <tickslock>
    80005a9c:	0017879b          	addiw	a5,a5,1
    80005aa0:	00f72023          	sw	a5,0(a4)
    80005aa4:	00001097          	auipc	ra,0x1
    80005aa8:	3c4080e7          	jalr	964(ra) # 80006e68 <release>
    80005aac:	f65ff06f          	j	80005a10 <devintr+0x60>
    80005ab0:	00001097          	auipc	ra,0x1
    80005ab4:	f20080e7          	jalr	-224(ra) # 800069d0 <uartintr>
    80005ab8:	fadff06f          	j	80005a64 <devintr+0xb4>
    80005abc:	0000                	unimp
	...

0000000080005ac0 <kernelvec>:
    80005ac0:	f0010113          	addi	sp,sp,-256
    80005ac4:	00113023          	sd	ra,0(sp)
    80005ac8:	00213423          	sd	sp,8(sp)
    80005acc:	00313823          	sd	gp,16(sp)
    80005ad0:	00413c23          	sd	tp,24(sp)
    80005ad4:	02513023          	sd	t0,32(sp)
    80005ad8:	02613423          	sd	t1,40(sp)
    80005adc:	02713823          	sd	t2,48(sp)
    80005ae0:	02813c23          	sd	s0,56(sp)
    80005ae4:	04913023          	sd	s1,64(sp)
    80005ae8:	04a13423          	sd	a0,72(sp)
    80005aec:	04b13823          	sd	a1,80(sp)
    80005af0:	04c13c23          	sd	a2,88(sp)
    80005af4:	06d13023          	sd	a3,96(sp)
    80005af8:	06e13423          	sd	a4,104(sp)
    80005afc:	06f13823          	sd	a5,112(sp)
    80005b00:	07013c23          	sd	a6,120(sp)
    80005b04:	09113023          	sd	a7,128(sp)
    80005b08:	09213423          	sd	s2,136(sp)
    80005b0c:	09313823          	sd	s3,144(sp)
    80005b10:	09413c23          	sd	s4,152(sp)
    80005b14:	0b513023          	sd	s5,160(sp)
    80005b18:	0b613423          	sd	s6,168(sp)
    80005b1c:	0b713823          	sd	s7,176(sp)
    80005b20:	0b813c23          	sd	s8,184(sp)
    80005b24:	0d913023          	sd	s9,192(sp)
    80005b28:	0da13423          	sd	s10,200(sp)
    80005b2c:	0db13823          	sd	s11,208(sp)
    80005b30:	0dc13c23          	sd	t3,216(sp)
    80005b34:	0fd13023          	sd	t4,224(sp)
    80005b38:	0fe13423          	sd	t5,232(sp)
    80005b3c:	0ff13823          	sd	t6,240(sp)
    80005b40:	cd1ff0ef          	jal	ra,80005810 <kerneltrap>
    80005b44:	00013083          	ld	ra,0(sp)
    80005b48:	00813103          	ld	sp,8(sp)
    80005b4c:	01013183          	ld	gp,16(sp)
    80005b50:	02013283          	ld	t0,32(sp)
    80005b54:	02813303          	ld	t1,40(sp)
    80005b58:	03013383          	ld	t2,48(sp)
    80005b5c:	03813403          	ld	s0,56(sp)
    80005b60:	04013483          	ld	s1,64(sp)
    80005b64:	04813503          	ld	a0,72(sp)
    80005b68:	05013583          	ld	a1,80(sp)
    80005b6c:	05813603          	ld	a2,88(sp)
    80005b70:	06013683          	ld	a3,96(sp)
    80005b74:	06813703          	ld	a4,104(sp)
    80005b78:	07013783          	ld	a5,112(sp)
    80005b7c:	07813803          	ld	a6,120(sp)
    80005b80:	08013883          	ld	a7,128(sp)
    80005b84:	08813903          	ld	s2,136(sp)
    80005b88:	09013983          	ld	s3,144(sp)
    80005b8c:	09813a03          	ld	s4,152(sp)
    80005b90:	0a013a83          	ld	s5,160(sp)
    80005b94:	0a813b03          	ld	s6,168(sp)
    80005b98:	0b013b83          	ld	s7,176(sp)
    80005b9c:	0b813c03          	ld	s8,184(sp)
    80005ba0:	0c013c83          	ld	s9,192(sp)
    80005ba4:	0c813d03          	ld	s10,200(sp)
    80005ba8:	0d013d83          	ld	s11,208(sp)
    80005bac:	0d813e03          	ld	t3,216(sp)
    80005bb0:	0e013e83          	ld	t4,224(sp)
    80005bb4:	0e813f03          	ld	t5,232(sp)
    80005bb8:	0f013f83          	ld	t6,240(sp)
    80005bbc:	10010113          	addi	sp,sp,256
    80005bc0:	10200073          	sret
    80005bc4:	00000013          	nop
    80005bc8:	00000013          	nop
    80005bcc:	00000013          	nop

0000000080005bd0 <timervec>:
    80005bd0:	34051573          	csrrw	a0,mscratch,a0
    80005bd4:	00b53023          	sd	a1,0(a0)
    80005bd8:	00c53423          	sd	a2,8(a0)
    80005bdc:	00d53823          	sd	a3,16(a0)
    80005be0:	01853583          	ld	a1,24(a0)
    80005be4:	02053603          	ld	a2,32(a0)
    80005be8:	0005b683          	ld	a3,0(a1)
    80005bec:	00c686b3          	add	a3,a3,a2
    80005bf0:	00d5b023          	sd	a3,0(a1)
    80005bf4:	00200593          	li	a1,2
    80005bf8:	14459073          	csrw	sip,a1
    80005bfc:	01053683          	ld	a3,16(a0)
    80005c00:	00853603          	ld	a2,8(a0)
    80005c04:	00053583          	ld	a1,0(a0)
    80005c08:	34051573          	csrrw	a0,mscratch,a0
    80005c0c:	30200073          	mret

0000000080005c10 <plicinit>:
    80005c10:	ff010113          	addi	sp,sp,-16
    80005c14:	00813423          	sd	s0,8(sp)
    80005c18:	01010413          	addi	s0,sp,16
    80005c1c:	00813403          	ld	s0,8(sp)
    80005c20:	0c0007b7          	lui	a5,0xc000
    80005c24:	00100713          	li	a4,1
    80005c28:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80005c2c:	00e7a223          	sw	a4,4(a5)
    80005c30:	01010113          	addi	sp,sp,16
    80005c34:	00008067          	ret

0000000080005c38 <plicinithart>:
    80005c38:	ff010113          	addi	sp,sp,-16
    80005c3c:	00813023          	sd	s0,0(sp)
    80005c40:	00113423          	sd	ra,8(sp)
    80005c44:	01010413          	addi	s0,sp,16
    80005c48:	00000097          	auipc	ra,0x0
    80005c4c:	a48080e7          	jalr	-1464(ra) # 80005690 <cpuid>
    80005c50:	0085171b          	slliw	a4,a0,0x8
    80005c54:	0c0027b7          	lui	a5,0xc002
    80005c58:	00e787b3          	add	a5,a5,a4
    80005c5c:	40200713          	li	a4,1026
    80005c60:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005c64:	00813083          	ld	ra,8(sp)
    80005c68:	00013403          	ld	s0,0(sp)
    80005c6c:	00d5151b          	slliw	a0,a0,0xd
    80005c70:	0c2017b7          	lui	a5,0xc201
    80005c74:	00a78533          	add	a0,a5,a0
    80005c78:	00052023          	sw	zero,0(a0)
    80005c7c:	01010113          	addi	sp,sp,16
    80005c80:	00008067          	ret

0000000080005c84 <plic_claim>:
    80005c84:	ff010113          	addi	sp,sp,-16
    80005c88:	00813023          	sd	s0,0(sp)
    80005c8c:	00113423          	sd	ra,8(sp)
    80005c90:	01010413          	addi	s0,sp,16
    80005c94:	00000097          	auipc	ra,0x0
    80005c98:	9fc080e7          	jalr	-1540(ra) # 80005690 <cpuid>
    80005c9c:	00813083          	ld	ra,8(sp)
    80005ca0:	00013403          	ld	s0,0(sp)
    80005ca4:	00d5151b          	slliw	a0,a0,0xd
    80005ca8:	0c2017b7          	lui	a5,0xc201
    80005cac:	00a78533          	add	a0,a5,a0
    80005cb0:	00452503          	lw	a0,4(a0)
    80005cb4:	01010113          	addi	sp,sp,16
    80005cb8:	00008067          	ret

0000000080005cbc <plic_complete>:
    80005cbc:	fe010113          	addi	sp,sp,-32
    80005cc0:	00813823          	sd	s0,16(sp)
    80005cc4:	00913423          	sd	s1,8(sp)
    80005cc8:	00113c23          	sd	ra,24(sp)
    80005ccc:	02010413          	addi	s0,sp,32
    80005cd0:	00050493          	mv	s1,a0
    80005cd4:	00000097          	auipc	ra,0x0
    80005cd8:	9bc080e7          	jalr	-1604(ra) # 80005690 <cpuid>
    80005cdc:	01813083          	ld	ra,24(sp)
    80005ce0:	01013403          	ld	s0,16(sp)
    80005ce4:	00d5179b          	slliw	a5,a0,0xd
    80005ce8:	0c201737          	lui	a4,0xc201
    80005cec:	00f707b3          	add	a5,a4,a5
    80005cf0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005cf4:	00813483          	ld	s1,8(sp)
    80005cf8:	02010113          	addi	sp,sp,32
    80005cfc:	00008067          	ret

0000000080005d00 <consolewrite>:
    80005d00:	fb010113          	addi	sp,sp,-80
    80005d04:	04813023          	sd	s0,64(sp)
    80005d08:	04113423          	sd	ra,72(sp)
    80005d0c:	02913c23          	sd	s1,56(sp)
    80005d10:	03213823          	sd	s2,48(sp)
    80005d14:	03313423          	sd	s3,40(sp)
    80005d18:	03413023          	sd	s4,32(sp)
    80005d1c:	01513c23          	sd	s5,24(sp)
    80005d20:	05010413          	addi	s0,sp,80
    80005d24:	06c05c63          	blez	a2,80005d9c <consolewrite+0x9c>
    80005d28:	00060993          	mv	s3,a2
    80005d2c:	00050a13          	mv	s4,a0
    80005d30:	00058493          	mv	s1,a1
    80005d34:	00000913          	li	s2,0
    80005d38:	fff00a93          	li	s5,-1
    80005d3c:	01c0006f          	j	80005d58 <consolewrite+0x58>
    80005d40:	fbf44503          	lbu	a0,-65(s0)
    80005d44:	0019091b          	addiw	s2,s2,1
    80005d48:	00148493          	addi	s1,s1,1
    80005d4c:	00001097          	auipc	ra,0x1
    80005d50:	a9c080e7          	jalr	-1380(ra) # 800067e8 <uartputc>
    80005d54:	03298063          	beq	s3,s2,80005d74 <consolewrite+0x74>
    80005d58:	00048613          	mv	a2,s1
    80005d5c:	00100693          	li	a3,1
    80005d60:	000a0593          	mv	a1,s4
    80005d64:	fbf40513          	addi	a0,s0,-65
    80005d68:	00000097          	auipc	ra,0x0
    80005d6c:	9e0080e7          	jalr	-1568(ra) # 80005748 <either_copyin>
    80005d70:	fd5518e3          	bne	a0,s5,80005d40 <consolewrite+0x40>
    80005d74:	04813083          	ld	ra,72(sp)
    80005d78:	04013403          	ld	s0,64(sp)
    80005d7c:	03813483          	ld	s1,56(sp)
    80005d80:	02813983          	ld	s3,40(sp)
    80005d84:	02013a03          	ld	s4,32(sp)
    80005d88:	01813a83          	ld	s5,24(sp)
    80005d8c:	00090513          	mv	a0,s2
    80005d90:	03013903          	ld	s2,48(sp)
    80005d94:	05010113          	addi	sp,sp,80
    80005d98:	00008067          	ret
    80005d9c:	00000913          	li	s2,0
    80005da0:	fd5ff06f          	j	80005d74 <consolewrite+0x74>

0000000080005da4 <consoleread>:
    80005da4:	f9010113          	addi	sp,sp,-112
    80005da8:	06813023          	sd	s0,96(sp)
    80005dac:	04913c23          	sd	s1,88(sp)
    80005db0:	05213823          	sd	s2,80(sp)
    80005db4:	05313423          	sd	s3,72(sp)
    80005db8:	05413023          	sd	s4,64(sp)
    80005dbc:	03513c23          	sd	s5,56(sp)
    80005dc0:	03613823          	sd	s6,48(sp)
    80005dc4:	03713423          	sd	s7,40(sp)
    80005dc8:	03813023          	sd	s8,32(sp)
    80005dcc:	06113423          	sd	ra,104(sp)
    80005dd0:	01913c23          	sd	s9,24(sp)
    80005dd4:	07010413          	addi	s0,sp,112
    80005dd8:	00060b93          	mv	s7,a2
    80005ddc:	00050913          	mv	s2,a0
    80005de0:	00058c13          	mv	s8,a1
    80005de4:	00060b1b          	sext.w	s6,a2
    80005de8:	00006497          	auipc	s1,0x6
    80005dec:	56048493          	addi	s1,s1,1376 # 8000c348 <cons>
    80005df0:	00400993          	li	s3,4
    80005df4:	fff00a13          	li	s4,-1
    80005df8:	00a00a93          	li	s5,10
    80005dfc:	05705e63          	blez	s7,80005e58 <consoleread+0xb4>
    80005e00:	09c4a703          	lw	a4,156(s1)
    80005e04:	0984a783          	lw	a5,152(s1)
    80005e08:	0007071b          	sext.w	a4,a4
    80005e0c:	08e78463          	beq	a5,a4,80005e94 <consoleread+0xf0>
    80005e10:	07f7f713          	andi	a4,a5,127
    80005e14:	00e48733          	add	a4,s1,a4
    80005e18:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005e1c:	0017869b          	addiw	a3,a5,1
    80005e20:	08d4ac23          	sw	a3,152(s1)
    80005e24:	00070c9b          	sext.w	s9,a4
    80005e28:	0b370663          	beq	a4,s3,80005ed4 <consoleread+0x130>
    80005e2c:	00100693          	li	a3,1
    80005e30:	f9f40613          	addi	a2,s0,-97
    80005e34:	000c0593          	mv	a1,s8
    80005e38:	00090513          	mv	a0,s2
    80005e3c:	f8e40fa3          	sb	a4,-97(s0)
    80005e40:	00000097          	auipc	ra,0x0
    80005e44:	8bc080e7          	jalr	-1860(ra) # 800056fc <either_copyout>
    80005e48:	01450863          	beq	a0,s4,80005e58 <consoleread+0xb4>
    80005e4c:	001c0c13          	addi	s8,s8,1
    80005e50:	fffb8b9b          	addiw	s7,s7,-1
    80005e54:	fb5c94e3          	bne	s9,s5,80005dfc <consoleread+0x58>
    80005e58:	000b851b          	sext.w	a0,s7
    80005e5c:	06813083          	ld	ra,104(sp)
    80005e60:	06013403          	ld	s0,96(sp)
    80005e64:	05813483          	ld	s1,88(sp)
    80005e68:	05013903          	ld	s2,80(sp)
    80005e6c:	04813983          	ld	s3,72(sp)
    80005e70:	04013a03          	ld	s4,64(sp)
    80005e74:	03813a83          	ld	s5,56(sp)
    80005e78:	02813b83          	ld	s7,40(sp)
    80005e7c:	02013c03          	ld	s8,32(sp)
    80005e80:	01813c83          	ld	s9,24(sp)
    80005e84:	40ab053b          	subw	a0,s6,a0
    80005e88:	03013b03          	ld	s6,48(sp)
    80005e8c:	07010113          	addi	sp,sp,112
    80005e90:	00008067          	ret
    80005e94:	00001097          	auipc	ra,0x1
    80005e98:	1d8080e7          	jalr	472(ra) # 8000706c <push_on>
    80005e9c:	0984a703          	lw	a4,152(s1)
    80005ea0:	09c4a783          	lw	a5,156(s1)
    80005ea4:	0007879b          	sext.w	a5,a5
    80005ea8:	fef70ce3          	beq	a4,a5,80005ea0 <consoleread+0xfc>
    80005eac:	00001097          	auipc	ra,0x1
    80005eb0:	234080e7          	jalr	564(ra) # 800070e0 <pop_on>
    80005eb4:	0984a783          	lw	a5,152(s1)
    80005eb8:	07f7f713          	andi	a4,a5,127
    80005ebc:	00e48733          	add	a4,s1,a4
    80005ec0:	01874703          	lbu	a4,24(a4)
    80005ec4:	0017869b          	addiw	a3,a5,1
    80005ec8:	08d4ac23          	sw	a3,152(s1)
    80005ecc:	00070c9b          	sext.w	s9,a4
    80005ed0:	f5371ee3          	bne	a4,s3,80005e2c <consoleread+0x88>
    80005ed4:	000b851b          	sext.w	a0,s7
    80005ed8:	f96bf2e3          	bgeu	s7,s6,80005e5c <consoleread+0xb8>
    80005edc:	08f4ac23          	sw	a5,152(s1)
    80005ee0:	f7dff06f          	j	80005e5c <consoleread+0xb8>

0000000080005ee4 <consputc>:
    80005ee4:	10000793          	li	a5,256
    80005ee8:	00f50663          	beq	a0,a5,80005ef4 <consputc+0x10>
    80005eec:	00001317          	auipc	t1,0x1
    80005ef0:	9f430067          	jr	-1548(t1) # 800068e0 <uartputc_sync>
    80005ef4:	ff010113          	addi	sp,sp,-16
    80005ef8:	00113423          	sd	ra,8(sp)
    80005efc:	00813023          	sd	s0,0(sp)
    80005f00:	01010413          	addi	s0,sp,16
    80005f04:	00800513          	li	a0,8
    80005f08:	00001097          	auipc	ra,0x1
    80005f0c:	9d8080e7          	jalr	-1576(ra) # 800068e0 <uartputc_sync>
    80005f10:	02000513          	li	a0,32
    80005f14:	00001097          	auipc	ra,0x1
    80005f18:	9cc080e7          	jalr	-1588(ra) # 800068e0 <uartputc_sync>
    80005f1c:	00013403          	ld	s0,0(sp)
    80005f20:	00813083          	ld	ra,8(sp)
    80005f24:	00800513          	li	a0,8
    80005f28:	01010113          	addi	sp,sp,16
    80005f2c:	00001317          	auipc	t1,0x1
    80005f30:	9b430067          	jr	-1612(t1) # 800068e0 <uartputc_sync>

0000000080005f34 <consoleintr>:
    80005f34:	fe010113          	addi	sp,sp,-32
    80005f38:	00813823          	sd	s0,16(sp)
    80005f3c:	00913423          	sd	s1,8(sp)
    80005f40:	01213023          	sd	s2,0(sp)
    80005f44:	00113c23          	sd	ra,24(sp)
    80005f48:	02010413          	addi	s0,sp,32
    80005f4c:	00006917          	auipc	s2,0x6
    80005f50:	3fc90913          	addi	s2,s2,1020 # 8000c348 <cons>
    80005f54:	00050493          	mv	s1,a0
    80005f58:	00090513          	mv	a0,s2
    80005f5c:	00001097          	auipc	ra,0x1
    80005f60:	e40080e7          	jalr	-448(ra) # 80006d9c <acquire>
    80005f64:	02048c63          	beqz	s1,80005f9c <consoleintr+0x68>
    80005f68:	0a092783          	lw	a5,160(s2)
    80005f6c:	09892703          	lw	a4,152(s2)
    80005f70:	07f00693          	li	a3,127
    80005f74:	40e7873b          	subw	a4,a5,a4
    80005f78:	02e6e263          	bltu	a3,a4,80005f9c <consoleintr+0x68>
    80005f7c:	00d00713          	li	a4,13
    80005f80:	04e48063          	beq	s1,a4,80005fc0 <consoleintr+0x8c>
    80005f84:	07f7f713          	andi	a4,a5,127
    80005f88:	00e90733          	add	a4,s2,a4
    80005f8c:	0017879b          	addiw	a5,a5,1
    80005f90:	0af92023          	sw	a5,160(s2)
    80005f94:	00970c23          	sb	s1,24(a4)
    80005f98:	08f92e23          	sw	a5,156(s2)
    80005f9c:	01013403          	ld	s0,16(sp)
    80005fa0:	01813083          	ld	ra,24(sp)
    80005fa4:	00813483          	ld	s1,8(sp)
    80005fa8:	00013903          	ld	s2,0(sp)
    80005fac:	00006517          	auipc	a0,0x6
    80005fb0:	39c50513          	addi	a0,a0,924 # 8000c348 <cons>
    80005fb4:	02010113          	addi	sp,sp,32
    80005fb8:	00001317          	auipc	t1,0x1
    80005fbc:	eb030067          	jr	-336(t1) # 80006e68 <release>
    80005fc0:	00a00493          	li	s1,10
    80005fc4:	fc1ff06f          	j	80005f84 <consoleintr+0x50>

0000000080005fc8 <consoleinit>:
    80005fc8:	fe010113          	addi	sp,sp,-32
    80005fcc:	00113c23          	sd	ra,24(sp)
    80005fd0:	00813823          	sd	s0,16(sp)
    80005fd4:	00913423          	sd	s1,8(sp)
    80005fd8:	02010413          	addi	s0,sp,32
    80005fdc:	00006497          	auipc	s1,0x6
    80005fe0:	36c48493          	addi	s1,s1,876 # 8000c348 <cons>
    80005fe4:	00048513          	mv	a0,s1
    80005fe8:	00002597          	auipc	a1,0x2
    80005fec:	70858593          	addi	a1,a1,1800 # 800086f0 <CONSOLE_STATUS+0x6e0>
    80005ff0:	00001097          	auipc	ra,0x1
    80005ff4:	d88080e7          	jalr	-632(ra) # 80006d78 <initlock>
    80005ff8:	00000097          	auipc	ra,0x0
    80005ffc:	7ac080e7          	jalr	1964(ra) # 800067a4 <uartinit>
    80006000:	01813083          	ld	ra,24(sp)
    80006004:	01013403          	ld	s0,16(sp)
    80006008:	00000797          	auipc	a5,0x0
    8000600c:	d9c78793          	addi	a5,a5,-612 # 80005da4 <consoleread>
    80006010:	0af4bc23          	sd	a5,184(s1)
    80006014:	00000797          	auipc	a5,0x0
    80006018:	cec78793          	addi	a5,a5,-788 # 80005d00 <consolewrite>
    8000601c:	0cf4b023          	sd	a5,192(s1)
    80006020:	00813483          	ld	s1,8(sp)
    80006024:	02010113          	addi	sp,sp,32
    80006028:	00008067          	ret

000000008000602c <console_read>:
    8000602c:	ff010113          	addi	sp,sp,-16
    80006030:	00813423          	sd	s0,8(sp)
    80006034:	01010413          	addi	s0,sp,16
    80006038:	00813403          	ld	s0,8(sp)
    8000603c:	00006317          	auipc	t1,0x6
    80006040:	3c433303          	ld	t1,964(t1) # 8000c400 <devsw+0x10>
    80006044:	01010113          	addi	sp,sp,16
    80006048:	00030067          	jr	t1

000000008000604c <console_write>:
    8000604c:	ff010113          	addi	sp,sp,-16
    80006050:	00813423          	sd	s0,8(sp)
    80006054:	01010413          	addi	s0,sp,16
    80006058:	00813403          	ld	s0,8(sp)
    8000605c:	00006317          	auipc	t1,0x6
    80006060:	3ac33303          	ld	t1,940(t1) # 8000c408 <devsw+0x18>
    80006064:	01010113          	addi	sp,sp,16
    80006068:	00030067          	jr	t1

000000008000606c <panic>:
    8000606c:	fe010113          	addi	sp,sp,-32
    80006070:	00113c23          	sd	ra,24(sp)
    80006074:	00813823          	sd	s0,16(sp)
    80006078:	00913423          	sd	s1,8(sp)
    8000607c:	02010413          	addi	s0,sp,32
    80006080:	00050493          	mv	s1,a0
    80006084:	00002517          	auipc	a0,0x2
    80006088:	67450513          	addi	a0,a0,1652 # 800086f8 <CONSOLE_STATUS+0x6e8>
    8000608c:	00006797          	auipc	a5,0x6
    80006090:	4007ae23          	sw	zero,1052(a5) # 8000c4a8 <pr+0x18>
    80006094:	00000097          	auipc	ra,0x0
    80006098:	034080e7          	jalr	52(ra) # 800060c8 <__printf>
    8000609c:	00048513          	mv	a0,s1
    800060a0:	00000097          	auipc	ra,0x0
    800060a4:	028080e7          	jalr	40(ra) # 800060c8 <__printf>
    800060a8:	00002517          	auipc	a0,0x2
    800060ac:	30850513          	addi	a0,a0,776 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800060b0:	00000097          	auipc	ra,0x0
    800060b4:	018080e7          	jalr	24(ra) # 800060c8 <__printf>
    800060b8:	00100793          	li	a5,1
    800060bc:	00005717          	auipc	a4,0x5
    800060c0:	f2f72e23          	sw	a5,-196(a4) # 8000aff8 <panicked>
    800060c4:	0000006f          	j	800060c4 <panic+0x58>

00000000800060c8 <__printf>:
    800060c8:	f3010113          	addi	sp,sp,-208
    800060cc:	08813023          	sd	s0,128(sp)
    800060d0:	07313423          	sd	s3,104(sp)
    800060d4:	09010413          	addi	s0,sp,144
    800060d8:	05813023          	sd	s8,64(sp)
    800060dc:	08113423          	sd	ra,136(sp)
    800060e0:	06913c23          	sd	s1,120(sp)
    800060e4:	07213823          	sd	s2,112(sp)
    800060e8:	07413023          	sd	s4,96(sp)
    800060ec:	05513c23          	sd	s5,88(sp)
    800060f0:	05613823          	sd	s6,80(sp)
    800060f4:	05713423          	sd	s7,72(sp)
    800060f8:	03913c23          	sd	s9,56(sp)
    800060fc:	03a13823          	sd	s10,48(sp)
    80006100:	03b13423          	sd	s11,40(sp)
    80006104:	00006317          	auipc	t1,0x6
    80006108:	38c30313          	addi	t1,t1,908 # 8000c490 <pr>
    8000610c:	01832c03          	lw	s8,24(t1)
    80006110:	00b43423          	sd	a1,8(s0)
    80006114:	00c43823          	sd	a2,16(s0)
    80006118:	00d43c23          	sd	a3,24(s0)
    8000611c:	02e43023          	sd	a4,32(s0)
    80006120:	02f43423          	sd	a5,40(s0)
    80006124:	03043823          	sd	a6,48(s0)
    80006128:	03143c23          	sd	a7,56(s0)
    8000612c:	00050993          	mv	s3,a0
    80006130:	4a0c1663          	bnez	s8,800065dc <__printf+0x514>
    80006134:	60098c63          	beqz	s3,8000674c <__printf+0x684>
    80006138:	0009c503          	lbu	a0,0(s3)
    8000613c:	00840793          	addi	a5,s0,8
    80006140:	f6f43c23          	sd	a5,-136(s0)
    80006144:	00000493          	li	s1,0
    80006148:	22050063          	beqz	a0,80006368 <__printf+0x2a0>
    8000614c:	00002a37          	lui	s4,0x2
    80006150:	00018ab7          	lui	s5,0x18
    80006154:	000f4b37          	lui	s6,0xf4
    80006158:	00989bb7          	lui	s7,0x989
    8000615c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006160:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006164:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006168:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000616c:	00148c9b          	addiw	s9,s1,1
    80006170:	02500793          	li	a5,37
    80006174:	01998933          	add	s2,s3,s9
    80006178:	38f51263          	bne	a0,a5,800064fc <__printf+0x434>
    8000617c:	00094783          	lbu	a5,0(s2)
    80006180:	00078c9b          	sext.w	s9,a5
    80006184:	1e078263          	beqz	a5,80006368 <__printf+0x2a0>
    80006188:	0024849b          	addiw	s1,s1,2
    8000618c:	07000713          	li	a4,112
    80006190:	00998933          	add	s2,s3,s1
    80006194:	38e78a63          	beq	a5,a4,80006528 <__printf+0x460>
    80006198:	20f76863          	bltu	a4,a5,800063a8 <__printf+0x2e0>
    8000619c:	42a78863          	beq	a5,a0,800065cc <__printf+0x504>
    800061a0:	06400713          	li	a4,100
    800061a4:	40e79663          	bne	a5,a4,800065b0 <__printf+0x4e8>
    800061a8:	f7843783          	ld	a5,-136(s0)
    800061ac:	0007a603          	lw	a2,0(a5)
    800061b0:	00878793          	addi	a5,a5,8
    800061b4:	f6f43c23          	sd	a5,-136(s0)
    800061b8:	42064a63          	bltz	a2,800065ec <__printf+0x524>
    800061bc:	00a00713          	li	a4,10
    800061c0:	02e677bb          	remuw	a5,a2,a4
    800061c4:	00002d97          	auipc	s11,0x2
    800061c8:	55cd8d93          	addi	s11,s11,1372 # 80008720 <digits>
    800061cc:	00900593          	li	a1,9
    800061d0:	0006051b          	sext.w	a0,a2
    800061d4:	00000c93          	li	s9,0
    800061d8:	02079793          	slli	a5,a5,0x20
    800061dc:	0207d793          	srli	a5,a5,0x20
    800061e0:	00fd87b3          	add	a5,s11,a5
    800061e4:	0007c783          	lbu	a5,0(a5)
    800061e8:	02e656bb          	divuw	a3,a2,a4
    800061ec:	f8f40023          	sb	a5,-128(s0)
    800061f0:	14c5d863          	bge	a1,a2,80006340 <__printf+0x278>
    800061f4:	06300593          	li	a1,99
    800061f8:	00100c93          	li	s9,1
    800061fc:	02e6f7bb          	remuw	a5,a3,a4
    80006200:	02079793          	slli	a5,a5,0x20
    80006204:	0207d793          	srli	a5,a5,0x20
    80006208:	00fd87b3          	add	a5,s11,a5
    8000620c:	0007c783          	lbu	a5,0(a5)
    80006210:	02e6d73b          	divuw	a4,a3,a4
    80006214:	f8f400a3          	sb	a5,-127(s0)
    80006218:	12a5f463          	bgeu	a1,a0,80006340 <__printf+0x278>
    8000621c:	00a00693          	li	a3,10
    80006220:	00900593          	li	a1,9
    80006224:	02d777bb          	remuw	a5,a4,a3
    80006228:	02079793          	slli	a5,a5,0x20
    8000622c:	0207d793          	srli	a5,a5,0x20
    80006230:	00fd87b3          	add	a5,s11,a5
    80006234:	0007c503          	lbu	a0,0(a5)
    80006238:	02d757bb          	divuw	a5,a4,a3
    8000623c:	f8a40123          	sb	a0,-126(s0)
    80006240:	48e5f263          	bgeu	a1,a4,800066c4 <__printf+0x5fc>
    80006244:	06300513          	li	a0,99
    80006248:	02d7f5bb          	remuw	a1,a5,a3
    8000624c:	02059593          	slli	a1,a1,0x20
    80006250:	0205d593          	srli	a1,a1,0x20
    80006254:	00bd85b3          	add	a1,s11,a1
    80006258:	0005c583          	lbu	a1,0(a1)
    8000625c:	02d7d7bb          	divuw	a5,a5,a3
    80006260:	f8b401a3          	sb	a1,-125(s0)
    80006264:	48e57263          	bgeu	a0,a4,800066e8 <__printf+0x620>
    80006268:	3e700513          	li	a0,999
    8000626c:	02d7f5bb          	remuw	a1,a5,a3
    80006270:	02059593          	slli	a1,a1,0x20
    80006274:	0205d593          	srli	a1,a1,0x20
    80006278:	00bd85b3          	add	a1,s11,a1
    8000627c:	0005c583          	lbu	a1,0(a1)
    80006280:	02d7d7bb          	divuw	a5,a5,a3
    80006284:	f8b40223          	sb	a1,-124(s0)
    80006288:	46e57663          	bgeu	a0,a4,800066f4 <__printf+0x62c>
    8000628c:	02d7f5bb          	remuw	a1,a5,a3
    80006290:	02059593          	slli	a1,a1,0x20
    80006294:	0205d593          	srli	a1,a1,0x20
    80006298:	00bd85b3          	add	a1,s11,a1
    8000629c:	0005c583          	lbu	a1,0(a1)
    800062a0:	02d7d7bb          	divuw	a5,a5,a3
    800062a4:	f8b402a3          	sb	a1,-123(s0)
    800062a8:	46ea7863          	bgeu	s4,a4,80006718 <__printf+0x650>
    800062ac:	02d7f5bb          	remuw	a1,a5,a3
    800062b0:	02059593          	slli	a1,a1,0x20
    800062b4:	0205d593          	srli	a1,a1,0x20
    800062b8:	00bd85b3          	add	a1,s11,a1
    800062bc:	0005c583          	lbu	a1,0(a1)
    800062c0:	02d7d7bb          	divuw	a5,a5,a3
    800062c4:	f8b40323          	sb	a1,-122(s0)
    800062c8:	3eeaf863          	bgeu	s5,a4,800066b8 <__printf+0x5f0>
    800062cc:	02d7f5bb          	remuw	a1,a5,a3
    800062d0:	02059593          	slli	a1,a1,0x20
    800062d4:	0205d593          	srli	a1,a1,0x20
    800062d8:	00bd85b3          	add	a1,s11,a1
    800062dc:	0005c583          	lbu	a1,0(a1)
    800062e0:	02d7d7bb          	divuw	a5,a5,a3
    800062e4:	f8b403a3          	sb	a1,-121(s0)
    800062e8:	42eb7e63          	bgeu	s6,a4,80006724 <__printf+0x65c>
    800062ec:	02d7f5bb          	remuw	a1,a5,a3
    800062f0:	02059593          	slli	a1,a1,0x20
    800062f4:	0205d593          	srli	a1,a1,0x20
    800062f8:	00bd85b3          	add	a1,s11,a1
    800062fc:	0005c583          	lbu	a1,0(a1)
    80006300:	02d7d7bb          	divuw	a5,a5,a3
    80006304:	f8b40423          	sb	a1,-120(s0)
    80006308:	42ebfc63          	bgeu	s7,a4,80006740 <__printf+0x678>
    8000630c:	02079793          	slli	a5,a5,0x20
    80006310:	0207d793          	srli	a5,a5,0x20
    80006314:	00fd8db3          	add	s11,s11,a5
    80006318:	000dc703          	lbu	a4,0(s11)
    8000631c:	00a00793          	li	a5,10
    80006320:	00900c93          	li	s9,9
    80006324:	f8e404a3          	sb	a4,-119(s0)
    80006328:	00065c63          	bgez	a2,80006340 <__printf+0x278>
    8000632c:	f9040713          	addi	a4,s0,-112
    80006330:	00f70733          	add	a4,a4,a5
    80006334:	02d00693          	li	a3,45
    80006338:	fed70823          	sb	a3,-16(a4)
    8000633c:	00078c93          	mv	s9,a5
    80006340:	f8040793          	addi	a5,s0,-128
    80006344:	01978cb3          	add	s9,a5,s9
    80006348:	f7f40d13          	addi	s10,s0,-129
    8000634c:	000cc503          	lbu	a0,0(s9)
    80006350:	fffc8c93          	addi	s9,s9,-1
    80006354:	00000097          	auipc	ra,0x0
    80006358:	b90080e7          	jalr	-1136(ra) # 80005ee4 <consputc>
    8000635c:	ffac98e3          	bne	s9,s10,8000634c <__printf+0x284>
    80006360:	00094503          	lbu	a0,0(s2)
    80006364:	e00514e3          	bnez	a0,8000616c <__printf+0xa4>
    80006368:	1a0c1663          	bnez	s8,80006514 <__printf+0x44c>
    8000636c:	08813083          	ld	ra,136(sp)
    80006370:	08013403          	ld	s0,128(sp)
    80006374:	07813483          	ld	s1,120(sp)
    80006378:	07013903          	ld	s2,112(sp)
    8000637c:	06813983          	ld	s3,104(sp)
    80006380:	06013a03          	ld	s4,96(sp)
    80006384:	05813a83          	ld	s5,88(sp)
    80006388:	05013b03          	ld	s6,80(sp)
    8000638c:	04813b83          	ld	s7,72(sp)
    80006390:	04013c03          	ld	s8,64(sp)
    80006394:	03813c83          	ld	s9,56(sp)
    80006398:	03013d03          	ld	s10,48(sp)
    8000639c:	02813d83          	ld	s11,40(sp)
    800063a0:	0d010113          	addi	sp,sp,208
    800063a4:	00008067          	ret
    800063a8:	07300713          	li	a4,115
    800063ac:	1ce78a63          	beq	a5,a4,80006580 <__printf+0x4b8>
    800063b0:	07800713          	li	a4,120
    800063b4:	1ee79e63          	bne	a5,a4,800065b0 <__printf+0x4e8>
    800063b8:	f7843783          	ld	a5,-136(s0)
    800063bc:	0007a703          	lw	a4,0(a5)
    800063c0:	00878793          	addi	a5,a5,8
    800063c4:	f6f43c23          	sd	a5,-136(s0)
    800063c8:	28074263          	bltz	a4,8000664c <__printf+0x584>
    800063cc:	00002d97          	auipc	s11,0x2
    800063d0:	354d8d93          	addi	s11,s11,852 # 80008720 <digits>
    800063d4:	00f77793          	andi	a5,a4,15
    800063d8:	00fd87b3          	add	a5,s11,a5
    800063dc:	0007c683          	lbu	a3,0(a5)
    800063e0:	00f00613          	li	a2,15
    800063e4:	0007079b          	sext.w	a5,a4
    800063e8:	f8d40023          	sb	a3,-128(s0)
    800063ec:	0047559b          	srliw	a1,a4,0x4
    800063f0:	0047569b          	srliw	a3,a4,0x4
    800063f4:	00000c93          	li	s9,0
    800063f8:	0ee65063          	bge	a2,a4,800064d8 <__printf+0x410>
    800063fc:	00f6f693          	andi	a3,a3,15
    80006400:	00dd86b3          	add	a3,s11,a3
    80006404:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80006408:	0087d79b          	srliw	a5,a5,0x8
    8000640c:	00100c93          	li	s9,1
    80006410:	f8d400a3          	sb	a3,-127(s0)
    80006414:	0cb67263          	bgeu	a2,a1,800064d8 <__printf+0x410>
    80006418:	00f7f693          	andi	a3,a5,15
    8000641c:	00dd86b3          	add	a3,s11,a3
    80006420:	0006c583          	lbu	a1,0(a3)
    80006424:	00f00613          	li	a2,15
    80006428:	0047d69b          	srliw	a3,a5,0x4
    8000642c:	f8b40123          	sb	a1,-126(s0)
    80006430:	0047d593          	srli	a1,a5,0x4
    80006434:	28f67e63          	bgeu	a2,a5,800066d0 <__printf+0x608>
    80006438:	00f6f693          	andi	a3,a3,15
    8000643c:	00dd86b3          	add	a3,s11,a3
    80006440:	0006c503          	lbu	a0,0(a3)
    80006444:	0087d813          	srli	a6,a5,0x8
    80006448:	0087d69b          	srliw	a3,a5,0x8
    8000644c:	f8a401a3          	sb	a0,-125(s0)
    80006450:	28b67663          	bgeu	a2,a1,800066dc <__printf+0x614>
    80006454:	00f6f693          	andi	a3,a3,15
    80006458:	00dd86b3          	add	a3,s11,a3
    8000645c:	0006c583          	lbu	a1,0(a3)
    80006460:	00c7d513          	srli	a0,a5,0xc
    80006464:	00c7d69b          	srliw	a3,a5,0xc
    80006468:	f8b40223          	sb	a1,-124(s0)
    8000646c:	29067a63          	bgeu	a2,a6,80006700 <__printf+0x638>
    80006470:	00f6f693          	andi	a3,a3,15
    80006474:	00dd86b3          	add	a3,s11,a3
    80006478:	0006c583          	lbu	a1,0(a3)
    8000647c:	0107d813          	srli	a6,a5,0x10
    80006480:	0107d69b          	srliw	a3,a5,0x10
    80006484:	f8b402a3          	sb	a1,-123(s0)
    80006488:	28a67263          	bgeu	a2,a0,8000670c <__printf+0x644>
    8000648c:	00f6f693          	andi	a3,a3,15
    80006490:	00dd86b3          	add	a3,s11,a3
    80006494:	0006c683          	lbu	a3,0(a3)
    80006498:	0147d79b          	srliw	a5,a5,0x14
    8000649c:	f8d40323          	sb	a3,-122(s0)
    800064a0:	21067663          	bgeu	a2,a6,800066ac <__printf+0x5e4>
    800064a4:	02079793          	slli	a5,a5,0x20
    800064a8:	0207d793          	srli	a5,a5,0x20
    800064ac:	00fd8db3          	add	s11,s11,a5
    800064b0:	000dc683          	lbu	a3,0(s11)
    800064b4:	00800793          	li	a5,8
    800064b8:	00700c93          	li	s9,7
    800064bc:	f8d403a3          	sb	a3,-121(s0)
    800064c0:	00075c63          	bgez	a4,800064d8 <__printf+0x410>
    800064c4:	f9040713          	addi	a4,s0,-112
    800064c8:	00f70733          	add	a4,a4,a5
    800064cc:	02d00693          	li	a3,45
    800064d0:	fed70823          	sb	a3,-16(a4)
    800064d4:	00078c93          	mv	s9,a5
    800064d8:	f8040793          	addi	a5,s0,-128
    800064dc:	01978cb3          	add	s9,a5,s9
    800064e0:	f7f40d13          	addi	s10,s0,-129
    800064e4:	000cc503          	lbu	a0,0(s9)
    800064e8:	fffc8c93          	addi	s9,s9,-1
    800064ec:	00000097          	auipc	ra,0x0
    800064f0:	9f8080e7          	jalr	-1544(ra) # 80005ee4 <consputc>
    800064f4:	ff9d18e3          	bne	s10,s9,800064e4 <__printf+0x41c>
    800064f8:	0100006f          	j	80006508 <__printf+0x440>
    800064fc:	00000097          	auipc	ra,0x0
    80006500:	9e8080e7          	jalr	-1560(ra) # 80005ee4 <consputc>
    80006504:	000c8493          	mv	s1,s9
    80006508:	00094503          	lbu	a0,0(s2)
    8000650c:	c60510e3          	bnez	a0,8000616c <__printf+0xa4>
    80006510:	e40c0ee3          	beqz	s8,8000636c <__printf+0x2a4>
    80006514:	00006517          	auipc	a0,0x6
    80006518:	f7c50513          	addi	a0,a0,-132 # 8000c490 <pr>
    8000651c:	00001097          	auipc	ra,0x1
    80006520:	94c080e7          	jalr	-1716(ra) # 80006e68 <release>
    80006524:	e49ff06f          	j	8000636c <__printf+0x2a4>
    80006528:	f7843783          	ld	a5,-136(s0)
    8000652c:	03000513          	li	a0,48
    80006530:	01000d13          	li	s10,16
    80006534:	00878713          	addi	a4,a5,8
    80006538:	0007bc83          	ld	s9,0(a5)
    8000653c:	f6e43c23          	sd	a4,-136(s0)
    80006540:	00000097          	auipc	ra,0x0
    80006544:	9a4080e7          	jalr	-1628(ra) # 80005ee4 <consputc>
    80006548:	07800513          	li	a0,120
    8000654c:	00000097          	auipc	ra,0x0
    80006550:	998080e7          	jalr	-1640(ra) # 80005ee4 <consputc>
    80006554:	00002d97          	auipc	s11,0x2
    80006558:	1ccd8d93          	addi	s11,s11,460 # 80008720 <digits>
    8000655c:	03ccd793          	srli	a5,s9,0x3c
    80006560:	00fd87b3          	add	a5,s11,a5
    80006564:	0007c503          	lbu	a0,0(a5)
    80006568:	fffd0d1b          	addiw	s10,s10,-1
    8000656c:	004c9c93          	slli	s9,s9,0x4
    80006570:	00000097          	auipc	ra,0x0
    80006574:	974080e7          	jalr	-1676(ra) # 80005ee4 <consputc>
    80006578:	fe0d12e3          	bnez	s10,8000655c <__printf+0x494>
    8000657c:	f8dff06f          	j	80006508 <__printf+0x440>
    80006580:	f7843783          	ld	a5,-136(s0)
    80006584:	0007bc83          	ld	s9,0(a5)
    80006588:	00878793          	addi	a5,a5,8
    8000658c:	f6f43c23          	sd	a5,-136(s0)
    80006590:	000c9a63          	bnez	s9,800065a4 <__printf+0x4dc>
    80006594:	1080006f          	j	8000669c <__printf+0x5d4>
    80006598:	001c8c93          	addi	s9,s9,1
    8000659c:	00000097          	auipc	ra,0x0
    800065a0:	948080e7          	jalr	-1720(ra) # 80005ee4 <consputc>
    800065a4:	000cc503          	lbu	a0,0(s9)
    800065a8:	fe0518e3          	bnez	a0,80006598 <__printf+0x4d0>
    800065ac:	f5dff06f          	j	80006508 <__printf+0x440>
    800065b0:	02500513          	li	a0,37
    800065b4:	00000097          	auipc	ra,0x0
    800065b8:	930080e7          	jalr	-1744(ra) # 80005ee4 <consputc>
    800065bc:	000c8513          	mv	a0,s9
    800065c0:	00000097          	auipc	ra,0x0
    800065c4:	924080e7          	jalr	-1756(ra) # 80005ee4 <consputc>
    800065c8:	f41ff06f          	j	80006508 <__printf+0x440>
    800065cc:	02500513          	li	a0,37
    800065d0:	00000097          	auipc	ra,0x0
    800065d4:	914080e7          	jalr	-1772(ra) # 80005ee4 <consputc>
    800065d8:	f31ff06f          	j	80006508 <__printf+0x440>
    800065dc:	00030513          	mv	a0,t1
    800065e0:	00000097          	auipc	ra,0x0
    800065e4:	7bc080e7          	jalr	1980(ra) # 80006d9c <acquire>
    800065e8:	b4dff06f          	j	80006134 <__printf+0x6c>
    800065ec:	40c0053b          	negw	a0,a2
    800065f0:	00a00713          	li	a4,10
    800065f4:	02e576bb          	remuw	a3,a0,a4
    800065f8:	00002d97          	auipc	s11,0x2
    800065fc:	128d8d93          	addi	s11,s11,296 # 80008720 <digits>
    80006600:	ff700593          	li	a1,-9
    80006604:	02069693          	slli	a3,a3,0x20
    80006608:	0206d693          	srli	a3,a3,0x20
    8000660c:	00dd86b3          	add	a3,s11,a3
    80006610:	0006c683          	lbu	a3,0(a3)
    80006614:	02e557bb          	divuw	a5,a0,a4
    80006618:	f8d40023          	sb	a3,-128(s0)
    8000661c:	10b65e63          	bge	a2,a1,80006738 <__printf+0x670>
    80006620:	06300593          	li	a1,99
    80006624:	02e7f6bb          	remuw	a3,a5,a4
    80006628:	02069693          	slli	a3,a3,0x20
    8000662c:	0206d693          	srli	a3,a3,0x20
    80006630:	00dd86b3          	add	a3,s11,a3
    80006634:	0006c683          	lbu	a3,0(a3)
    80006638:	02e7d73b          	divuw	a4,a5,a4
    8000663c:	00200793          	li	a5,2
    80006640:	f8d400a3          	sb	a3,-127(s0)
    80006644:	bca5ece3          	bltu	a1,a0,8000621c <__printf+0x154>
    80006648:	ce5ff06f          	j	8000632c <__printf+0x264>
    8000664c:	40e007bb          	negw	a5,a4
    80006650:	00002d97          	auipc	s11,0x2
    80006654:	0d0d8d93          	addi	s11,s11,208 # 80008720 <digits>
    80006658:	00f7f693          	andi	a3,a5,15
    8000665c:	00dd86b3          	add	a3,s11,a3
    80006660:	0006c583          	lbu	a1,0(a3)
    80006664:	ff100613          	li	a2,-15
    80006668:	0047d69b          	srliw	a3,a5,0x4
    8000666c:	f8b40023          	sb	a1,-128(s0)
    80006670:	0047d59b          	srliw	a1,a5,0x4
    80006674:	0ac75e63          	bge	a4,a2,80006730 <__printf+0x668>
    80006678:	00f6f693          	andi	a3,a3,15
    8000667c:	00dd86b3          	add	a3,s11,a3
    80006680:	0006c603          	lbu	a2,0(a3)
    80006684:	00f00693          	li	a3,15
    80006688:	0087d79b          	srliw	a5,a5,0x8
    8000668c:	f8c400a3          	sb	a2,-127(s0)
    80006690:	d8b6e4e3          	bltu	a3,a1,80006418 <__printf+0x350>
    80006694:	00200793          	li	a5,2
    80006698:	e2dff06f          	j	800064c4 <__printf+0x3fc>
    8000669c:	00002c97          	auipc	s9,0x2
    800066a0:	064c8c93          	addi	s9,s9,100 # 80008700 <CONSOLE_STATUS+0x6f0>
    800066a4:	02800513          	li	a0,40
    800066a8:	ef1ff06f          	j	80006598 <__printf+0x4d0>
    800066ac:	00700793          	li	a5,7
    800066b0:	00600c93          	li	s9,6
    800066b4:	e0dff06f          	j	800064c0 <__printf+0x3f8>
    800066b8:	00700793          	li	a5,7
    800066bc:	00600c93          	li	s9,6
    800066c0:	c69ff06f          	j	80006328 <__printf+0x260>
    800066c4:	00300793          	li	a5,3
    800066c8:	00200c93          	li	s9,2
    800066cc:	c5dff06f          	j	80006328 <__printf+0x260>
    800066d0:	00300793          	li	a5,3
    800066d4:	00200c93          	li	s9,2
    800066d8:	de9ff06f          	j	800064c0 <__printf+0x3f8>
    800066dc:	00400793          	li	a5,4
    800066e0:	00300c93          	li	s9,3
    800066e4:	dddff06f          	j	800064c0 <__printf+0x3f8>
    800066e8:	00400793          	li	a5,4
    800066ec:	00300c93          	li	s9,3
    800066f0:	c39ff06f          	j	80006328 <__printf+0x260>
    800066f4:	00500793          	li	a5,5
    800066f8:	00400c93          	li	s9,4
    800066fc:	c2dff06f          	j	80006328 <__printf+0x260>
    80006700:	00500793          	li	a5,5
    80006704:	00400c93          	li	s9,4
    80006708:	db9ff06f          	j	800064c0 <__printf+0x3f8>
    8000670c:	00600793          	li	a5,6
    80006710:	00500c93          	li	s9,5
    80006714:	dadff06f          	j	800064c0 <__printf+0x3f8>
    80006718:	00600793          	li	a5,6
    8000671c:	00500c93          	li	s9,5
    80006720:	c09ff06f          	j	80006328 <__printf+0x260>
    80006724:	00800793          	li	a5,8
    80006728:	00700c93          	li	s9,7
    8000672c:	bfdff06f          	j	80006328 <__printf+0x260>
    80006730:	00100793          	li	a5,1
    80006734:	d91ff06f          	j	800064c4 <__printf+0x3fc>
    80006738:	00100793          	li	a5,1
    8000673c:	bf1ff06f          	j	8000632c <__printf+0x264>
    80006740:	00900793          	li	a5,9
    80006744:	00800c93          	li	s9,8
    80006748:	be1ff06f          	j	80006328 <__printf+0x260>
    8000674c:	00002517          	auipc	a0,0x2
    80006750:	fbc50513          	addi	a0,a0,-68 # 80008708 <CONSOLE_STATUS+0x6f8>
    80006754:	00000097          	auipc	ra,0x0
    80006758:	918080e7          	jalr	-1768(ra) # 8000606c <panic>

000000008000675c <printfinit>:
    8000675c:	fe010113          	addi	sp,sp,-32
    80006760:	00813823          	sd	s0,16(sp)
    80006764:	00913423          	sd	s1,8(sp)
    80006768:	00113c23          	sd	ra,24(sp)
    8000676c:	02010413          	addi	s0,sp,32
    80006770:	00006497          	auipc	s1,0x6
    80006774:	d2048493          	addi	s1,s1,-736 # 8000c490 <pr>
    80006778:	00048513          	mv	a0,s1
    8000677c:	00002597          	auipc	a1,0x2
    80006780:	f9c58593          	addi	a1,a1,-100 # 80008718 <CONSOLE_STATUS+0x708>
    80006784:	00000097          	auipc	ra,0x0
    80006788:	5f4080e7          	jalr	1524(ra) # 80006d78 <initlock>
    8000678c:	01813083          	ld	ra,24(sp)
    80006790:	01013403          	ld	s0,16(sp)
    80006794:	0004ac23          	sw	zero,24(s1)
    80006798:	00813483          	ld	s1,8(sp)
    8000679c:	02010113          	addi	sp,sp,32
    800067a0:	00008067          	ret

00000000800067a4 <uartinit>:
    800067a4:	ff010113          	addi	sp,sp,-16
    800067a8:	00813423          	sd	s0,8(sp)
    800067ac:	01010413          	addi	s0,sp,16
    800067b0:	100007b7          	lui	a5,0x10000
    800067b4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800067b8:	f8000713          	li	a4,-128
    800067bc:	00e781a3          	sb	a4,3(a5)
    800067c0:	00300713          	li	a4,3
    800067c4:	00e78023          	sb	a4,0(a5)
    800067c8:	000780a3          	sb	zero,1(a5)
    800067cc:	00e781a3          	sb	a4,3(a5)
    800067d0:	00700693          	li	a3,7
    800067d4:	00d78123          	sb	a3,2(a5)
    800067d8:	00e780a3          	sb	a4,1(a5)
    800067dc:	00813403          	ld	s0,8(sp)
    800067e0:	01010113          	addi	sp,sp,16
    800067e4:	00008067          	ret

00000000800067e8 <uartputc>:
    800067e8:	00005797          	auipc	a5,0x5
    800067ec:	8107a783          	lw	a5,-2032(a5) # 8000aff8 <panicked>
    800067f0:	00078463          	beqz	a5,800067f8 <uartputc+0x10>
    800067f4:	0000006f          	j	800067f4 <uartputc+0xc>
    800067f8:	fd010113          	addi	sp,sp,-48
    800067fc:	02813023          	sd	s0,32(sp)
    80006800:	00913c23          	sd	s1,24(sp)
    80006804:	01213823          	sd	s2,16(sp)
    80006808:	01313423          	sd	s3,8(sp)
    8000680c:	02113423          	sd	ra,40(sp)
    80006810:	03010413          	addi	s0,sp,48
    80006814:	00004917          	auipc	s2,0x4
    80006818:	7ec90913          	addi	s2,s2,2028 # 8000b000 <uart_tx_r>
    8000681c:	00093783          	ld	a5,0(s2)
    80006820:	00004497          	auipc	s1,0x4
    80006824:	7e848493          	addi	s1,s1,2024 # 8000b008 <uart_tx_w>
    80006828:	0004b703          	ld	a4,0(s1)
    8000682c:	02078693          	addi	a3,a5,32
    80006830:	00050993          	mv	s3,a0
    80006834:	02e69c63          	bne	a3,a4,8000686c <uartputc+0x84>
    80006838:	00001097          	auipc	ra,0x1
    8000683c:	834080e7          	jalr	-1996(ra) # 8000706c <push_on>
    80006840:	00093783          	ld	a5,0(s2)
    80006844:	0004b703          	ld	a4,0(s1)
    80006848:	02078793          	addi	a5,a5,32
    8000684c:	00e79463          	bne	a5,a4,80006854 <uartputc+0x6c>
    80006850:	0000006f          	j	80006850 <uartputc+0x68>
    80006854:	00001097          	auipc	ra,0x1
    80006858:	88c080e7          	jalr	-1908(ra) # 800070e0 <pop_on>
    8000685c:	00093783          	ld	a5,0(s2)
    80006860:	0004b703          	ld	a4,0(s1)
    80006864:	02078693          	addi	a3,a5,32
    80006868:	fce688e3          	beq	a3,a4,80006838 <uartputc+0x50>
    8000686c:	01f77693          	andi	a3,a4,31
    80006870:	00006597          	auipc	a1,0x6
    80006874:	c4058593          	addi	a1,a1,-960 # 8000c4b0 <uart_tx_buf>
    80006878:	00d586b3          	add	a3,a1,a3
    8000687c:	00170713          	addi	a4,a4,1
    80006880:	01368023          	sb	s3,0(a3)
    80006884:	00e4b023          	sd	a4,0(s1)
    80006888:	10000637          	lui	a2,0x10000
    8000688c:	02f71063          	bne	a4,a5,800068ac <uartputc+0xc4>
    80006890:	0340006f          	j	800068c4 <uartputc+0xdc>
    80006894:	00074703          	lbu	a4,0(a4)
    80006898:	00f93023          	sd	a5,0(s2)
    8000689c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800068a0:	00093783          	ld	a5,0(s2)
    800068a4:	0004b703          	ld	a4,0(s1)
    800068a8:	00f70e63          	beq	a4,a5,800068c4 <uartputc+0xdc>
    800068ac:	00564683          	lbu	a3,5(a2)
    800068b0:	01f7f713          	andi	a4,a5,31
    800068b4:	00e58733          	add	a4,a1,a4
    800068b8:	0206f693          	andi	a3,a3,32
    800068bc:	00178793          	addi	a5,a5,1
    800068c0:	fc069ae3          	bnez	a3,80006894 <uartputc+0xac>
    800068c4:	02813083          	ld	ra,40(sp)
    800068c8:	02013403          	ld	s0,32(sp)
    800068cc:	01813483          	ld	s1,24(sp)
    800068d0:	01013903          	ld	s2,16(sp)
    800068d4:	00813983          	ld	s3,8(sp)
    800068d8:	03010113          	addi	sp,sp,48
    800068dc:	00008067          	ret

00000000800068e0 <uartputc_sync>:
    800068e0:	ff010113          	addi	sp,sp,-16
    800068e4:	00813423          	sd	s0,8(sp)
    800068e8:	01010413          	addi	s0,sp,16
    800068ec:	00004717          	auipc	a4,0x4
    800068f0:	70c72703          	lw	a4,1804(a4) # 8000aff8 <panicked>
    800068f4:	02071663          	bnez	a4,80006920 <uartputc_sync+0x40>
    800068f8:	00050793          	mv	a5,a0
    800068fc:	100006b7          	lui	a3,0x10000
    80006900:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006904:	02077713          	andi	a4,a4,32
    80006908:	fe070ce3          	beqz	a4,80006900 <uartputc_sync+0x20>
    8000690c:	0ff7f793          	andi	a5,a5,255
    80006910:	00f68023          	sb	a5,0(a3)
    80006914:	00813403          	ld	s0,8(sp)
    80006918:	01010113          	addi	sp,sp,16
    8000691c:	00008067          	ret
    80006920:	0000006f          	j	80006920 <uartputc_sync+0x40>

0000000080006924 <uartstart>:
    80006924:	ff010113          	addi	sp,sp,-16
    80006928:	00813423          	sd	s0,8(sp)
    8000692c:	01010413          	addi	s0,sp,16
    80006930:	00004617          	auipc	a2,0x4
    80006934:	6d060613          	addi	a2,a2,1744 # 8000b000 <uart_tx_r>
    80006938:	00004517          	auipc	a0,0x4
    8000693c:	6d050513          	addi	a0,a0,1744 # 8000b008 <uart_tx_w>
    80006940:	00063783          	ld	a5,0(a2)
    80006944:	00053703          	ld	a4,0(a0)
    80006948:	04f70263          	beq	a4,a5,8000698c <uartstart+0x68>
    8000694c:	100005b7          	lui	a1,0x10000
    80006950:	00006817          	auipc	a6,0x6
    80006954:	b6080813          	addi	a6,a6,-1184 # 8000c4b0 <uart_tx_buf>
    80006958:	01c0006f          	j	80006974 <uartstart+0x50>
    8000695c:	0006c703          	lbu	a4,0(a3)
    80006960:	00f63023          	sd	a5,0(a2)
    80006964:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006968:	00063783          	ld	a5,0(a2)
    8000696c:	00053703          	ld	a4,0(a0)
    80006970:	00f70e63          	beq	a4,a5,8000698c <uartstart+0x68>
    80006974:	01f7f713          	andi	a4,a5,31
    80006978:	00e806b3          	add	a3,a6,a4
    8000697c:	0055c703          	lbu	a4,5(a1)
    80006980:	00178793          	addi	a5,a5,1
    80006984:	02077713          	andi	a4,a4,32
    80006988:	fc071ae3          	bnez	a4,8000695c <uartstart+0x38>
    8000698c:	00813403          	ld	s0,8(sp)
    80006990:	01010113          	addi	sp,sp,16
    80006994:	00008067          	ret

0000000080006998 <uartgetc>:
    80006998:	ff010113          	addi	sp,sp,-16
    8000699c:	00813423          	sd	s0,8(sp)
    800069a0:	01010413          	addi	s0,sp,16
    800069a4:	10000737          	lui	a4,0x10000
    800069a8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800069ac:	0017f793          	andi	a5,a5,1
    800069b0:	00078c63          	beqz	a5,800069c8 <uartgetc+0x30>
    800069b4:	00074503          	lbu	a0,0(a4)
    800069b8:	0ff57513          	andi	a0,a0,255
    800069bc:	00813403          	ld	s0,8(sp)
    800069c0:	01010113          	addi	sp,sp,16
    800069c4:	00008067          	ret
    800069c8:	fff00513          	li	a0,-1
    800069cc:	ff1ff06f          	j	800069bc <uartgetc+0x24>

00000000800069d0 <uartintr>:
    800069d0:	100007b7          	lui	a5,0x10000
    800069d4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800069d8:	0017f793          	andi	a5,a5,1
    800069dc:	0a078463          	beqz	a5,80006a84 <uartintr+0xb4>
    800069e0:	fe010113          	addi	sp,sp,-32
    800069e4:	00813823          	sd	s0,16(sp)
    800069e8:	00913423          	sd	s1,8(sp)
    800069ec:	00113c23          	sd	ra,24(sp)
    800069f0:	02010413          	addi	s0,sp,32
    800069f4:	100004b7          	lui	s1,0x10000
    800069f8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800069fc:	0ff57513          	andi	a0,a0,255
    80006a00:	fffff097          	auipc	ra,0xfffff
    80006a04:	534080e7          	jalr	1332(ra) # 80005f34 <consoleintr>
    80006a08:	0054c783          	lbu	a5,5(s1)
    80006a0c:	0017f793          	andi	a5,a5,1
    80006a10:	fe0794e3          	bnez	a5,800069f8 <uartintr+0x28>
    80006a14:	00004617          	auipc	a2,0x4
    80006a18:	5ec60613          	addi	a2,a2,1516 # 8000b000 <uart_tx_r>
    80006a1c:	00004517          	auipc	a0,0x4
    80006a20:	5ec50513          	addi	a0,a0,1516 # 8000b008 <uart_tx_w>
    80006a24:	00063783          	ld	a5,0(a2)
    80006a28:	00053703          	ld	a4,0(a0)
    80006a2c:	04f70263          	beq	a4,a5,80006a70 <uartintr+0xa0>
    80006a30:	100005b7          	lui	a1,0x10000
    80006a34:	00006817          	auipc	a6,0x6
    80006a38:	a7c80813          	addi	a6,a6,-1412 # 8000c4b0 <uart_tx_buf>
    80006a3c:	01c0006f          	j	80006a58 <uartintr+0x88>
    80006a40:	0006c703          	lbu	a4,0(a3)
    80006a44:	00f63023          	sd	a5,0(a2)
    80006a48:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006a4c:	00063783          	ld	a5,0(a2)
    80006a50:	00053703          	ld	a4,0(a0)
    80006a54:	00f70e63          	beq	a4,a5,80006a70 <uartintr+0xa0>
    80006a58:	01f7f713          	andi	a4,a5,31
    80006a5c:	00e806b3          	add	a3,a6,a4
    80006a60:	0055c703          	lbu	a4,5(a1)
    80006a64:	00178793          	addi	a5,a5,1
    80006a68:	02077713          	andi	a4,a4,32
    80006a6c:	fc071ae3          	bnez	a4,80006a40 <uartintr+0x70>
    80006a70:	01813083          	ld	ra,24(sp)
    80006a74:	01013403          	ld	s0,16(sp)
    80006a78:	00813483          	ld	s1,8(sp)
    80006a7c:	02010113          	addi	sp,sp,32
    80006a80:	00008067          	ret
    80006a84:	00004617          	auipc	a2,0x4
    80006a88:	57c60613          	addi	a2,a2,1404 # 8000b000 <uart_tx_r>
    80006a8c:	00004517          	auipc	a0,0x4
    80006a90:	57c50513          	addi	a0,a0,1404 # 8000b008 <uart_tx_w>
    80006a94:	00063783          	ld	a5,0(a2)
    80006a98:	00053703          	ld	a4,0(a0)
    80006a9c:	04f70263          	beq	a4,a5,80006ae0 <uartintr+0x110>
    80006aa0:	100005b7          	lui	a1,0x10000
    80006aa4:	00006817          	auipc	a6,0x6
    80006aa8:	a0c80813          	addi	a6,a6,-1524 # 8000c4b0 <uart_tx_buf>
    80006aac:	01c0006f          	j	80006ac8 <uartintr+0xf8>
    80006ab0:	0006c703          	lbu	a4,0(a3)
    80006ab4:	00f63023          	sd	a5,0(a2)
    80006ab8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006abc:	00063783          	ld	a5,0(a2)
    80006ac0:	00053703          	ld	a4,0(a0)
    80006ac4:	02f70063          	beq	a4,a5,80006ae4 <uartintr+0x114>
    80006ac8:	01f7f713          	andi	a4,a5,31
    80006acc:	00e806b3          	add	a3,a6,a4
    80006ad0:	0055c703          	lbu	a4,5(a1)
    80006ad4:	00178793          	addi	a5,a5,1
    80006ad8:	02077713          	andi	a4,a4,32
    80006adc:	fc071ae3          	bnez	a4,80006ab0 <uartintr+0xe0>
    80006ae0:	00008067          	ret
    80006ae4:	00008067          	ret

0000000080006ae8 <kinit>:
    80006ae8:	fc010113          	addi	sp,sp,-64
    80006aec:	02913423          	sd	s1,40(sp)
    80006af0:	fffff7b7          	lui	a5,0xfffff
    80006af4:	0000b497          	auipc	s1,0xb
    80006af8:	50b48493          	addi	s1,s1,1291 # 80011fff <end+0xfff>
    80006afc:	02813823          	sd	s0,48(sp)
    80006b00:	01313c23          	sd	s3,24(sp)
    80006b04:	00f4f4b3          	and	s1,s1,a5
    80006b08:	02113c23          	sd	ra,56(sp)
    80006b0c:	03213023          	sd	s2,32(sp)
    80006b10:	01413823          	sd	s4,16(sp)
    80006b14:	01513423          	sd	s5,8(sp)
    80006b18:	04010413          	addi	s0,sp,64
    80006b1c:	000017b7          	lui	a5,0x1
    80006b20:	01100993          	li	s3,17
    80006b24:	00f487b3          	add	a5,s1,a5
    80006b28:	01b99993          	slli	s3,s3,0x1b
    80006b2c:	06f9e063          	bltu	s3,a5,80006b8c <kinit+0xa4>
    80006b30:	0000aa97          	auipc	s5,0xa
    80006b34:	4d0a8a93          	addi	s5,s5,1232 # 80011000 <end>
    80006b38:	0754ec63          	bltu	s1,s5,80006bb0 <kinit+0xc8>
    80006b3c:	0734fa63          	bgeu	s1,s3,80006bb0 <kinit+0xc8>
    80006b40:	00088a37          	lui	s4,0x88
    80006b44:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006b48:	00004917          	auipc	s2,0x4
    80006b4c:	4c890913          	addi	s2,s2,1224 # 8000b010 <kmem>
    80006b50:	00ca1a13          	slli	s4,s4,0xc
    80006b54:	0140006f          	j	80006b68 <kinit+0x80>
    80006b58:	000017b7          	lui	a5,0x1
    80006b5c:	00f484b3          	add	s1,s1,a5
    80006b60:	0554e863          	bltu	s1,s5,80006bb0 <kinit+0xc8>
    80006b64:	0534f663          	bgeu	s1,s3,80006bb0 <kinit+0xc8>
    80006b68:	00001637          	lui	a2,0x1
    80006b6c:	00100593          	li	a1,1
    80006b70:	00048513          	mv	a0,s1
    80006b74:	00000097          	auipc	ra,0x0
    80006b78:	5e4080e7          	jalr	1508(ra) # 80007158 <__memset>
    80006b7c:	00093783          	ld	a5,0(s2)
    80006b80:	00f4b023          	sd	a5,0(s1)
    80006b84:	00993023          	sd	s1,0(s2)
    80006b88:	fd4498e3          	bne	s1,s4,80006b58 <kinit+0x70>
    80006b8c:	03813083          	ld	ra,56(sp)
    80006b90:	03013403          	ld	s0,48(sp)
    80006b94:	02813483          	ld	s1,40(sp)
    80006b98:	02013903          	ld	s2,32(sp)
    80006b9c:	01813983          	ld	s3,24(sp)
    80006ba0:	01013a03          	ld	s4,16(sp)
    80006ba4:	00813a83          	ld	s5,8(sp)
    80006ba8:	04010113          	addi	sp,sp,64
    80006bac:	00008067          	ret
    80006bb0:	00002517          	auipc	a0,0x2
    80006bb4:	b8850513          	addi	a0,a0,-1144 # 80008738 <digits+0x18>
    80006bb8:	fffff097          	auipc	ra,0xfffff
    80006bbc:	4b4080e7          	jalr	1204(ra) # 8000606c <panic>

0000000080006bc0 <freerange>:
    80006bc0:	fc010113          	addi	sp,sp,-64
    80006bc4:	000017b7          	lui	a5,0x1
    80006bc8:	02913423          	sd	s1,40(sp)
    80006bcc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006bd0:	009504b3          	add	s1,a0,s1
    80006bd4:	fffff537          	lui	a0,0xfffff
    80006bd8:	02813823          	sd	s0,48(sp)
    80006bdc:	02113c23          	sd	ra,56(sp)
    80006be0:	03213023          	sd	s2,32(sp)
    80006be4:	01313c23          	sd	s3,24(sp)
    80006be8:	01413823          	sd	s4,16(sp)
    80006bec:	01513423          	sd	s5,8(sp)
    80006bf0:	01613023          	sd	s6,0(sp)
    80006bf4:	04010413          	addi	s0,sp,64
    80006bf8:	00a4f4b3          	and	s1,s1,a0
    80006bfc:	00f487b3          	add	a5,s1,a5
    80006c00:	06f5e463          	bltu	a1,a5,80006c68 <freerange+0xa8>
    80006c04:	0000aa97          	auipc	s5,0xa
    80006c08:	3fca8a93          	addi	s5,s5,1020 # 80011000 <end>
    80006c0c:	0954e263          	bltu	s1,s5,80006c90 <freerange+0xd0>
    80006c10:	01100993          	li	s3,17
    80006c14:	01b99993          	slli	s3,s3,0x1b
    80006c18:	0734fc63          	bgeu	s1,s3,80006c90 <freerange+0xd0>
    80006c1c:	00058a13          	mv	s4,a1
    80006c20:	00004917          	auipc	s2,0x4
    80006c24:	3f090913          	addi	s2,s2,1008 # 8000b010 <kmem>
    80006c28:	00002b37          	lui	s6,0x2
    80006c2c:	0140006f          	j	80006c40 <freerange+0x80>
    80006c30:	000017b7          	lui	a5,0x1
    80006c34:	00f484b3          	add	s1,s1,a5
    80006c38:	0554ec63          	bltu	s1,s5,80006c90 <freerange+0xd0>
    80006c3c:	0534fa63          	bgeu	s1,s3,80006c90 <freerange+0xd0>
    80006c40:	00001637          	lui	a2,0x1
    80006c44:	00100593          	li	a1,1
    80006c48:	00048513          	mv	a0,s1
    80006c4c:	00000097          	auipc	ra,0x0
    80006c50:	50c080e7          	jalr	1292(ra) # 80007158 <__memset>
    80006c54:	00093703          	ld	a4,0(s2)
    80006c58:	016487b3          	add	a5,s1,s6
    80006c5c:	00e4b023          	sd	a4,0(s1)
    80006c60:	00993023          	sd	s1,0(s2)
    80006c64:	fcfa76e3          	bgeu	s4,a5,80006c30 <freerange+0x70>
    80006c68:	03813083          	ld	ra,56(sp)
    80006c6c:	03013403          	ld	s0,48(sp)
    80006c70:	02813483          	ld	s1,40(sp)
    80006c74:	02013903          	ld	s2,32(sp)
    80006c78:	01813983          	ld	s3,24(sp)
    80006c7c:	01013a03          	ld	s4,16(sp)
    80006c80:	00813a83          	ld	s5,8(sp)
    80006c84:	00013b03          	ld	s6,0(sp)
    80006c88:	04010113          	addi	sp,sp,64
    80006c8c:	00008067          	ret
    80006c90:	00002517          	auipc	a0,0x2
    80006c94:	aa850513          	addi	a0,a0,-1368 # 80008738 <digits+0x18>
    80006c98:	fffff097          	auipc	ra,0xfffff
    80006c9c:	3d4080e7          	jalr	980(ra) # 8000606c <panic>

0000000080006ca0 <kfree>:
    80006ca0:	fe010113          	addi	sp,sp,-32
    80006ca4:	00813823          	sd	s0,16(sp)
    80006ca8:	00113c23          	sd	ra,24(sp)
    80006cac:	00913423          	sd	s1,8(sp)
    80006cb0:	02010413          	addi	s0,sp,32
    80006cb4:	03451793          	slli	a5,a0,0x34
    80006cb8:	04079c63          	bnez	a5,80006d10 <kfree+0x70>
    80006cbc:	0000a797          	auipc	a5,0xa
    80006cc0:	34478793          	addi	a5,a5,836 # 80011000 <end>
    80006cc4:	00050493          	mv	s1,a0
    80006cc8:	04f56463          	bltu	a0,a5,80006d10 <kfree+0x70>
    80006ccc:	01100793          	li	a5,17
    80006cd0:	01b79793          	slli	a5,a5,0x1b
    80006cd4:	02f57e63          	bgeu	a0,a5,80006d10 <kfree+0x70>
    80006cd8:	00001637          	lui	a2,0x1
    80006cdc:	00100593          	li	a1,1
    80006ce0:	00000097          	auipc	ra,0x0
    80006ce4:	478080e7          	jalr	1144(ra) # 80007158 <__memset>
    80006ce8:	00004797          	auipc	a5,0x4
    80006cec:	32878793          	addi	a5,a5,808 # 8000b010 <kmem>
    80006cf0:	0007b703          	ld	a4,0(a5)
    80006cf4:	01813083          	ld	ra,24(sp)
    80006cf8:	01013403          	ld	s0,16(sp)
    80006cfc:	00e4b023          	sd	a4,0(s1)
    80006d00:	0097b023          	sd	s1,0(a5)
    80006d04:	00813483          	ld	s1,8(sp)
    80006d08:	02010113          	addi	sp,sp,32
    80006d0c:	00008067          	ret
    80006d10:	00002517          	auipc	a0,0x2
    80006d14:	a2850513          	addi	a0,a0,-1496 # 80008738 <digits+0x18>
    80006d18:	fffff097          	auipc	ra,0xfffff
    80006d1c:	354080e7          	jalr	852(ra) # 8000606c <panic>

0000000080006d20 <kalloc>:
    80006d20:	fe010113          	addi	sp,sp,-32
    80006d24:	00813823          	sd	s0,16(sp)
    80006d28:	00913423          	sd	s1,8(sp)
    80006d2c:	00113c23          	sd	ra,24(sp)
    80006d30:	02010413          	addi	s0,sp,32
    80006d34:	00004797          	auipc	a5,0x4
    80006d38:	2dc78793          	addi	a5,a5,732 # 8000b010 <kmem>
    80006d3c:	0007b483          	ld	s1,0(a5)
    80006d40:	02048063          	beqz	s1,80006d60 <kalloc+0x40>
    80006d44:	0004b703          	ld	a4,0(s1)
    80006d48:	00001637          	lui	a2,0x1
    80006d4c:	00500593          	li	a1,5
    80006d50:	00048513          	mv	a0,s1
    80006d54:	00e7b023          	sd	a4,0(a5)
    80006d58:	00000097          	auipc	ra,0x0
    80006d5c:	400080e7          	jalr	1024(ra) # 80007158 <__memset>
    80006d60:	01813083          	ld	ra,24(sp)
    80006d64:	01013403          	ld	s0,16(sp)
    80006d68:	00048513          	mv	a0,s1
    80006d6c:	00813483          	ld	s1,8(sp)
    80006d70:	02010113          	addi	sp,sp,32
    80006d74:	00008067          	ret

0000000080006d78 <initlock>:
    80006d78:	ff010113          	addi	sp,sp,-16
    80006d7c:	00813423          	sd	s0,8(sp)
    80006d80:	01010413          	addi	s0,sp,16
    80006d84:	00813403          	ld	s0,8(sp)
    80006d88:	00b53423          	sd	a1,8(a0)
    80006d8c:	00052023          	sw	zero,0(a0)
    80006d90:	00053823          	sd	zero,16(a0)
    80006d94:	01010113          	addi	sp,sp,16
    80006d98:	00008067          	ret

0000000080006d9c <acquire>:
    80006d9c:	fe010113          	addi	sp,sp,-32
    80006da0:	00813823          	sd	s0,16(sp)
    80006da4:	00913423          	sd	s1,8(sp)
    80006da8:	00113c23          	sd	ra,24(sp)
    80006dac:	01213023          	sd	s2,0(sp)
    80006db0:	02010413          	addi	s0,sp,32
    80006db4:	00050493          	mv	s1,a0
    80006db8:	10002973          	csrr	s2,sstatus
    80006dbc:	100027f3          	csrr	a5,sstatus
    80006dc0:	ffd7f793          	andi	a5,a5,-3
    80006dc4:	10079073          	csrw	sstatus,a5
    80006dc8:	fffff097          	auipc	ra,0xfffff
    80006dcc:	8e8080e7          	jalr	-1816(ra) # 800056b0 <mycpu>
    80006dd0:	07852783          	lw	a5,120(a0)
    80006dd4:	06078e63          	beqz	a5,80006e50 <acquire+0xb4>
    80006dd8:	fffff097          	auipc	ra,0xfffff
    80006ddc:	8d8080e7          	jalr	-1832(ra) # 800056b0 <mycpu>
    80006de0:	07852783          	lw	a5,120(a0)
    80006de4:	0004a703          	lw	a4,0(s1)
    80006de8:	0017879b          	addiw	a5,a5,1
    80006dec:	06f52c23          	sw	a5,120(a0)
    80006df0:	04071063          	bnez	a4,80006e30 <acquire+0x94>
    80006df4:	00100713          	li	a4,1
    80006df8:	00070793          	mv	a5,a4
    80006dfc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006e00:	0007879b          	sext.w	a5,a5
    80006e04:	fe079ae3          	bnez	a5,80006df8 <acquire+0x5c>
    80006e08:	0ff0000f          	fence
    80006e0c:	fffff097          	auipc	ra,0xfffff
    80006e10:	8a4080e7          	jalr	-1884(ra) # 800056b0 <mycpu>
    80006e14:	01813083          	ld	ra,24(sp)
    80006e18:	01013403          	ld	s0,16(sp)
    80006e1c:	00a4b823          	sd	a0,16(s1)
    80006e20:	00013903          	ld	s2,0(sp)
    80006e24:	00813483          	ld	s1,8(sp)
    80006e28:	02010113          	addi	sp,sp,32
    80006e2c:	00008067          	ret
    80006e30:	0104b903          	ld	s2,16(s1)
    80006e34:	fffff097          	auipc	ra,0xfffff
    80006e38:	87c080e7          	jalr	-1924(ra) # 800056b0 <mycpu>
    80006e3c:	faa91ce3          	bne	s2,a0,80006df4 <acquire+0x58>
    80006e40:	00002517          	auipc	a0,0x2
    80006e44:	90050513          	addi	a0,a0,-1792 # 80008740 <digits+0x20>
    80006e48:	fffff097          	auipc	ra,0xfffff
    80006e4c:	224080e7          	jalr	548(ra) # 8000606c <panic>
    80006e50:	00195913          	srli	s2,s2,0x1
    80006e54:	fffff097          	auipc	ra,0xfffff
    80006e58:	85c080e7          	jalr	-1956(ra) # 800056b0 <mycpu>
    80006e5c:	00197913          	andi	s2,s2,1
    80006e60:	07252e23          	sw	s2,124(a0)
    80006e64:	f75ff06f          	j	80006dd8 <acquire+0x3c>

0000000080006e68 <release>:
    80006e68:	fe010113          	addi	sp,sp,-32
    80006e6c:	00813823          	sd	s0,16(sp)
    80006e70:	00113c23          	sd	ra,24(sp)
    80006e74:	00913423          	sd	s1,8(sp)
    80006e78:	01213023          	sd	s2,0(sp)
    80006e7c:	02010413          	addi	s0,sp,32
    80006e80:	00052783          	lw	a5,0(a0)
    80006e84:	00079a63          	bnez	a5,80006e98 <release+0x30>
    80006e88:	00002517          	auipc	a0,0x2
    80006e8c:	8c050513          	addi	a0,a0,-1856 # 80008748 <digits+0x28>
    80006e90:	fffff097          	auipc	ra,0xfffff
    80006e94:	1dc080e7          	jalr	476(ra) # 8000606c <panic>
    80006e98:	01053903          	ld	s2,16(a0)
    80006e9c:	00050493          	mv	s1,a0
    80006ea0:	fffff097          	auipc	ra,0xfffff
    80006ea4:	810080e7          	jalr	-2032(ra) # 800056b0 <mycpu>
    80006ea8:	fea910e3          	bne	s2,a0,80006e88 <release+0x20>
    80006eac:	0004b823          	sd	zero,16(s1)
    80006eb0:	0ff0000f          	fence
    80006eb4:	0f50000f          	fence	iorw,ow
    80006eb8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006ebc:	ffffe097          	auipc	ra,0xffffe
    80006ec0:	7f4080e7          	jalr	2036(ra) # 800056b0 <mycpu>
    80006ec4:	100027f3          	csrr	a5,sstatus
    80006ec8:	0027f793          	andi	a5,a5,2
    80006ecc:	04079a63          	bnez	a5,80006f20 <release+0xb8>
    80006ed0:	07852783          	lw	a5,120(a0)
    80006ed4:	02f05e63          	blez	a5,80006f10 <release+0xa8>
    80006ed8:	fff7871b          	addiw	a4,a5,-1
    80006edc:	06e52c23          	sw	a4,120(a0)
    80006ee0:	00071c63          	bnez	a4,80006ef8 <release+0x90>
    80006ee4:	07c52783          	lw	a5,124(a0)
    80006ee8:	00078863          	beqz	a5,80006ef8 <release+0x90>
    80006eec:	100027f3          	csrr	a5,sstatus
    80006ef0:	0027e793          	ori	a5,a5,2
    80006ef4:	10079073          	csrw	sstatus,a5
    80006ef8:	01813083          	ld	ra,24(sp)
    80006efc:	01013403          	ld	s0,16(sp)
    80006f00:	00813483          	ld	s1,8(sp)
    80006f04:	00013903          	ld	s2,0(sp)
    80006f08:	02010113          	addi	sp,sp,32
    80006f0c:	00008067          	ret
    80006f10:	00002517          	auipc	a0,0x2
    80006f14:	85850513          	addi	a0,a0,-1960 # 80008768 <digits+0x48>
    80006f18:	fffff097          	auipc	ra,0xfffff
    80006f1c:	154080e7          	jalr	340(ra) # 8000606c <panic>
    80006f20:	00002517          	auipc	a0,0x2
    80006f24:	83050513          	addi	a0,a0,-2000 # 80008750 <digits+0x30>
    80006f28:	fffff097          	auipc	ra,0xfffff
    80006f2c:	144080e7          	jalr	324(ra) # 8000606c <panic>

0000000080006f30 <holding>:
    80006f30:	00052783          	lw	a5,0(a0)
    80006f34:	00079663          	bnez	a5,80006f40 <holding+0x10>
    80006f38:	00000513          	li	a0,0
    80006f3c:	00008067          	ret
    80006f40:	fe010113          	addi	sp,sp,-32
    80006f44:	00813823          	sd	s0,16(sp)
    80006f48:	00913423          	sd	s1,8(sp)
    80006f4c:	00113c23          	sd	ra,24(sp)
    80006f50:	02010413          	addi	s0,sp,32
    80006f54:	01053483          	ld	s1,16(a0)
    80006f58:	ffffe097          	auipc	ra,0xffffe
    80006f5c:	758080e7          	jalr	1880(ra) # 800056b0 <mycpu>
    80006f60:	01813083          	ld	ra,24(sp)
    80006f64:	01013403          	ld	s0,16(sp)
    80006f68:	40a48533          	sub	a0,s1,a0
    80006f6c:	00153513          	seqz	a0,a0
    80006f70:	00813483          	ld	s1,8(sp)
    80006f74:	02010113          	addi	sp,sp,32
    80006f78:	00008067          	ret

0000000080006f7c <push_off>:
    80006f7c:	fe010113          	addi	sp,sp,-32
    80006f80:	00813823          	sd	s0,16(sp)
    80006f84:	00113c23          	sd	ra,24(sp)
    80006f88:	00913423          	sd	s1,8(sp)
    80006f8c:	02010413          	addi	s0,sp,32
    80006f90:	100024f3          	csrr	s1,sstatus
    80006f94:	100027f3          	csrr	a5,sstatus
    80006f98:	ffd7f793          	andi	a5,a5,-3
    80006f9c:	10079073          	csrw	sstatus,a5
    80006fa0:	ffffe097          	auipc	ra,0xffffe
    80006fa4:	710080e7          	jalr	1808(ra) # 800056b0 <mycpu>
    80006fa8:	07852783          	lw	a5,120(a0)
    80006fac:	02078663          	beqz	a5,80006fd8 <push_off+0x5c>
    80006fb0:	ffffe097          	auipc	ra,0xffffe
    80006fb4:	700080e7          	jalr	1792(ra) # 800056b0 <mycpu>
    80006fb8:	07852783          	lw	a5,120(a0)
    80006fbc:	01813083          	ld	ra,24(sp)
    80006fc0:	01013403          	ld	s0,16(sp)
    80006fc4:	0017879b          	addiw	a5,a5,1
    80006fc8:	06f52c23          	sw	a5,120(a0)
    80006fcc:	00813483          	ld	s1,8(sp)
    80006fd0:	02010113          	addi	sp,sp,32
    80006fd4:	00008067          	ret
    80006fd8:	0014d493          	srli	s1,s1,0x1
    80006fdc:	ffffe097          	auipc	ra,0xffffe
    80006fe0:	6d4080e7          	jalr	1748(ra) # 800056b0 <mycpu>
    80006fe4:	0014f493          	andi	s1,s1,1
    80006fe8:	06952e23          	sw	s1,124(a0)
    80006fec:	fc5ff06f          	j	80006fb0 <push_off+0x34>

0000000080006ff0 <pop_off>:
    80006ff0:	ff010113          	addi	sp,sp,-16
    80006ff4:	00813023          	sd	s0,0(sp)
    80006ff8:	00113423          	sd	ra,8(sp)
    80006ffc:	01010413          	addi	s0,sp,16
    80007000:	ffffe097          	auipc	ra,0xffffe
    80007004:	6b0080e7          	jalr	1712(ra) # 800056b0 <mycpu>
    80007008:	100027f3          	csrr	a5,sstatus
    8000700c:	0027f793          	andi	a5,a5,2
    80007010:	04079663          	bnez	a5,8000705c <pop_off+0x6c>
    80007014:	07852783          	lw	a5,120(a0)
    80007018:	02f05a63          	blez	a5,8000704c <pop_off+0x5c>
    8000701c:	fff7871b          	addiw	a4,a5,-1
    80007020:	06e52c23          	sw	a4,120(a0)
    80007024:	00071c63          	bnez	a4,8000703c <pop_off+0x4c>
    80007028:	07c52783          	lw	a5,124(a0)
    8000702c:	00078863          	beqz	a5,8000703c <pop_off+0x4c>
    80007030:	100027f3          	csrr	a5,sstatus
    80007034:	0027e793          	ori	a5,a5,2
    80007038:	10079073          	csrw	sstatus,a5
    8000703c:	00813083          	ld	ra,8(sp)
    80007040:	00013403          	ld	s0,0(sp)
    80007044:	01010113          	addi	sp,sp,16
    80007048:	00008067          	ret
    8000704c:	00001517          	auipc	a0,0x1
    80007050:	71c50513          	addi	a0,a0,1820 # 80008768 <digits+0x48>
    80007054:	fffff097          	auipc	ra,0xfffff
    80007058:	018080e7          	jalr	24(ra) # 8000606c <panic>
    8000705c:	00001517          	auipc	a0,0x1
    80007060:	6f450513          	addi	a0,a0,1780 # 80008750 <digits+0x30>
    80007064:	fffff097          	auipc	ra,0xfffff
    80007068:	008080e7          	jalr	8(ra) # 8000606c <panic>

000000008000706c <push_on>:
    8000706c:	fe010113          	addi	sp,sp,-32
    80007070:	00813823          	sd	s0,16(sp)
    80007074:	00113c23          	sd	ra,24(sp)
    80007078:	00913423          	sd	s1,8(sp)
    8000707c:	02010413          	addi	s0,sp,32
    80007080:	100024f3          	csrr	s1,sstatus
    80007084:	100027f3          	csrr	a5,sstatus
    80007088:	0027e793          	ori	a5,a5,2
    8000708c:	10079073          	csrw	sstatus,a5
    80007090:	ffffe097          	auipc	ra,0xffffe
    80007094:	620080e7          	jalr	1568(ra) # 800056b0 <mycpu>
    80007098:	07852783          	lw	a5,120(a0)
    8000709c:	02078663          	beqz	a5,800070c8 <push_on+0x5c>
    800070a0:	ffffe097          	auipc	ra,0xffffe
    800070a4:	610080e7          	jalr	1552(ra) # 800056b0 <mycpu>
    800070a8:	07852783          	lw	a5,120(a0)
    800070ac:	01813083          	ld	ra,24(sp)
    800070b0:	01013403          	ld	s0,16(sp)
    800070b4:	0017879b          	addiw	a5,a5,1
    800070b8:	06f52c23          	sw	a5,120(a0)
    800070bc:	00813483          	ld	s1,8(sp)
    800070c0:	02010113          	addi	sp,sp,32
    800070c4:	00008067          	ret
    800070c8:	0014d493          	srli	s1,s1,0x1
    800070cc:	ffffe097          	auipc	ra,0xffffe
    800070d0:	5e4080e7          	jalr	1508(ra) # 800056b0 <mycpu>
    800070d4:	0014f493          	andi	s1,s1,1
    800070d8:	06952e23          	sw	s1,124(a0)
    800070dc:	fc5ff06f          	j	800070a0 <push_on+0x34>

00000000800070e0 <pop_on>:
    800070e0:	ff010113          	addi	sp,sp,-16
    800070e4:	00813023          	sd	s0,0(sp)
    800070e8:	00113423          	sd	ra,8(sp)
    800070ec:	01010413          	addi	s0,sp,16
    800070f0:	ffffe097          	auipc	ra,0xffffe
    800070f4:	5c0080e7          	jalr	1472(ra) # 800056b0 <mycpu>
    800070f8:	100027f3          	csrr	a5,sstatus
    800070fc:	0027f793          	andi	a5,a5,2
    80007100:	04078463          	beqz	a5,80007148 <pop_on+0x68>
    80007104:	07852783          	lw	a5,120(a0)
    80007108:	02f05863          	blez	a5,80007138 <pop_on+0x58>
    8000710c:	fff7879b          	addiw	a5,a5,-1
    80007110:	06f52c23          	sw	a5,120(a0)
    80007114:	07853783          	ld	a5,120(a0)
    80007118:	00079863          	bnez	a5,80007128 <pop_on+0x48>
    8000711c:	100027f3          	csrr	a5,sstatus
    80007120:	ffd7f793          	andi	a5,a5,-3
    80007124:	10079073          	csrw	sstatus,a5
    80007128:	00813083          	ld	ra,8(sp)
    8000712c:	00013403          	ld	s0,0(sp)
    80007130:	01010113          	addi	sp,sp,16
    80007134:	00008067          	ret
    80007138:	00001517          	auipc	a0,0x1
    8000713c:	65850513          	addi	a0,a0,1624 # 80008790 <digits+0x70>
    80007140:	fffff097          	auipc	ra,0xfffff
    80007144:	f2c080e7          	jalr	-212(ra) # 8000606c <panic>
    80007148:	00001517          	auipc	a0,0x1
    8000714c:	62850513          	addi	a0,a0,1576 # 80008770 <digits+0x50>
    80007150:	fffff097          	auipc	ra,0xfffff
    80007154:	f1c080e7          	jalr	-228(ra) # 8000606c <panic>

0000000080007158 <__memset>:
    80007158:	ff010113          	addi	sp,sp,-16
    8000715c:	00813423          	sd	s0,8(sp)
    80007160:	01010413          	addi	s0,sp,16
    80007164:	1a060e63          	beqz	a2,80007320 <__memset+0x1c8>
    80007168:	40a007b3          	neg	a5,a0
    8000716c:	0077f793          	andi	a5,a5,7
    80007170:	00778693          	addi	a3,a5,7
    80007174:	00b00813          	li	a6,11
    80007178:	0ff5f593          	andi	a1,a1,255
    8000717c:	fff6071b          	addiw	a4,a2,-1
    80007180:	1b06e663          	bltu	a3,a6,8000732c <__memset+0x1d4>
    80007184:	1cd76463          	bltu	a4,a3,8000734c <__memset+0x1f4>
    80007188:	1a078e63          	beqz	a5,80007344 <__memset+0x1ec>
    8000718c:	00b50023          	sb	a1,0(a0)
    80007190:	00100713          	li	a4,1
    80007194:	1ae78463          	beq	a5,a4,8000733c <__memset+0x1e4>
    80007198:	00b500a3          	sb	a1,1(a0)
    8000719c:	00200713          	li	a4,2
    800071a0:	1ae78a63          	beq	a5,a4,80007354 <__memset+0x1fc>
    800071a4:	00b50123          	sb	a1,2(a0)
    800071a8:	00300713          	li	a4,3
    800071ac:	18e78463          	beq	a5,a4,80007334 <__memset+0x1dc>
    800071b0:	00b501a3          	sb	a1,3(a0)
    800071b4:	00400713          	li	a4,4
    800071b8:	1ae78263          	beq	a5,a4,8000735c <__memset+0x204>
    800071bc:	00b50223          	sb	a1,4(a0)
    800071c0:	00500713          	li	a4,5
    800071c4:	1ae78063          	beq	a5,a4,80007364 <__memset+0x20c>
    800071c8:	00b502a3          	sb	a1,5(a0)
    800071cc:	00700713          	li	a4,7
    800071d0:	18e79e63          	bne	a5,a4,8000736c <__memset+0x214>
    800071d4:	00b50323          	sb	a1,6(a0)
    800071d8:	00700e93          	li	t4,7
    800071dc:	00859713          	slli	a4,a1,0x8
    800071e0:	00e5e733          	or	a4,a1,a4
    800071e4:	01059e13          	slli	t3,a1,0x10
    800071e8:	01c76e33          	or	t3,a4,t3
    800071ec:	01859313          	slli	t1,a1,0x18
    800071f0:	006e6333          	or	t1,t3,t1
    800071f4:	02059893          	slli	a7,a1,0x20
    800071f8:	40f60e3b          	subw	t3,a2,a5
    800071fc:	011368b3          	or	a7,t1,a7
    80007200:	02859813          	slli	a6,a1,0x28
    80007204:	0108e833          	or	a6,a7,a6
    80007208:	03059693          	slli	a3,a1,0x30
    8000720c:	003e589b          	srliw	a7,t3,0x3
    80007210:	00d866b3          	or	a3,a6,a3
    80007214:	03859713          	slli	a4,a1,0x38
    80007218:	00389813          	slli	a6,a7,0x3
    8000721c:	00f507b3          	add	a5,a0,a5
    80007220:	00e6e733          	or	a4,a3,a4
    80007224:	000e089b          	sext.w	a7,t3
    80007228:	00f806b3          	add	a3,a6,a5
    8000722c:	00e7b023          	sd	a4,0(a5)
    80007230:	00878793          	addi	a5,a5,8
    80007234:	fed79ce3          	bne	a5,a3,8000722c <__memset+0xd4>
    80007238:	ff8e7793          	andi	a5,t3,-8
    8000723c:	0007871b          	sext.w	a4,a5
    80007240:	01d787bb          	addw	a5,a5,t4
    80007244:	0ce88e63          	beq	a7,a4,80007320 <__memset+0x1c8>
    80007248:	00f50733          	add	a4,a0,a5
    8000724c:	00b70023          	sb	a1,0(a4)
    80007250:	0017871b          	addiw	a4,a5,1
    80007254:	0cc77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007258:	00e50733          	add	a4,a0,a4
    8000725c:	00b70023          	sb	a1,0(a4)
    80007260:	0027871b          	addiw	a4,a5,2
    80007264:	0ac77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007268:	00e50733          	add	a4,a0,a4
    8000726c:	00b70023          	sb	a1,0(a4)
    80007270:	0037871b          	addiw	a4,a5,3
    80007274:	0ac77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007278:	00e50733          	add	a4,a0,a4
    8000727c:	00b70023          	sb	a1,0(a4)
    80007280:	0047871b          	addiw	a4,a5,4
    80007284:	08c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007288:	00e50733          	add	a4,a0,a4
    8000728c:	00b70023          	sb	a1,0(a4)
    80007290:	0057871b          	addiw	a4,a5,5
    80007294:	08c77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007298:	00e50733          	add	a4,a0,a4
    8000729c:	00b70023          	sb	a1,0(a4)
    800072a0:	0067871b          	addiw	a4,a5,6
    800072a4:	06c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072a8:	00e50733          	add	a4,a0,a4
    800072ac:	00b70023          	sb	a1,0(a4)
    800072b0:	0077871b          	addiw	a4,a5,7
    800072b4:	06c77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072b8:	00e50733          	add	a4,a0,a4
    800072bc:	00b70023          	sb	a1,0(a4)
    800072c0:	0087871b          	addiw	a4,a5,8
    800072c4:	04c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072c8:	00e50733          	add	a4,a0,a4
    800072cc:	00b70023          	sb	a1,0(a4)
    800072d0:	0097871b          	addiw	a4,a5,9
    800072d4:	04c77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072d8:	00e50733          	add	a4,a0,a4
    800072dc:	00b70023          	sb	a1,0(a4)
    800072e0:	00a7871b          	addiw	a4,a5,10
    800072e4:	02c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072e8:	00e50733          	add	a4,a0,a4
    800072ec:	00b70023          	sb	a1,0(a4)
    800072f0:	00b7871b          	addiw	a4,a5,11
    800072f4:	02c77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072f8:	00e50733          	add	a4,a0,a4
    800072fc:	00b70023          	sb	a1,0(a4)
    80007300:	00c7871b          	addiw	a4,a5,12
    80007304:	00c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007308:	00e50733          	add	a4,a0,a4
    8000730c:	00b70023          	sb	a1,0(a4)
    80007310:	00d7879b          	addiw	a5,a5,13
    80007314:	00c7f663          	bgeu	a5,a2,80007320 <__memset+0x1c8>
    80007318:	00f507b3          	add	a5,a0,a5
    8000731c:	00b78023          	sb	a1,0(a5)
    80007320:	00813403          	ld	s0,8(sp)
    80007324:	01010113          	addi	sp,sp,16
    80007328:	00008067          	ret
    8000732c:	00b00693          	li	a3,11
    80007330:	e55ff06f          	j	80007184 <__memset+0x2c>
    80007334:	00300e93          	li	t4,3
    80007338:	ea5ff06f          	j	800071dc <__memset+0x84>
    8000733c:	00100e93          	li	t4,1
    80007340:	e9dff06f          	j	800071dc <__memset+0x84>
    80007344:	00000e93          	li	t4,0
    80007348:	e95ff06f          	j	800071dc <__memset+0x84>
    8000734c:	00000793          	li	a5,0
    80007350:	ef9ff06f          	j	80007248 <__memset+0xf0>
    80007354:	00200e93          	li	t4,2
    80007358:	e85ff06f          	j	800071dc <__memset+0x84>
    8000735c:	00400e93          	li	t4,4
    80007360:	e7dff06f          	j	800071dc <__memset+0x84>
    80007364:	00500e93          	li	t4,5
    80007368:	e75ff06f          	j	800071dc <__memset+0x84>
    8000736c:	00600e93          	li	t4,6
    80007370:	e6dff06f          	j	800071dc <__memset+0x84>

0000000080007374 <__memmove>:
    80007374:	ff010113          	addi	sp,sp,-16
    80007378:	00813423          	sd	s0,8(sp)
    8000737c:	01010413          	addi	s0,sp,16
    80007380:	0e060863          	beqz	a2,80007470 <__memmove+0xfc>
    80007384:	fff6069b          	addiw	a3,a2,-1
    80007388:	0006881b          	sext.w	a6,a3
    8000738c:	0ea5e863          	bltu	a1,a0,8000747c <__memmove+0x108>
    80007390:	00758713          	addi	a4,a1,7
    80007394:	00a5e7b3          	or	a5,a1,a0
    80007398:	40a70733          	sub	a4,a4,a0
    8000739c:	0077f793          	andi	a5,a5,7
    800073a0:	00f73713          	sltiu	a4,a4,15
    800073a4:	00174713          	xori	a4,a4,1
    800073a8:	0017b793          	seqz	a5,a5
    800073ac:	00e7f7b3          	and	a5,a5,a4
    800073b0:	10078863          	beqz	a5,800074c0 <__memmove+0x14c>
    800073b4:	00900793          	li	a5,9
    800073b8:	1107f463          	bgeu	a5,a6,800074c0 <__memmove+0x14c>
    800073bc:	0036581b          	srliw	a6,a2,0x3
    800073c0:	fff8081b          	addiw	a6,a6,-1
    800073c4:	02081813          	slli	a6,a6,0x20
    800073c8:	01d85893          	srli	a7,a6,0x1d
    800073cc:	00858813          	addi	a6,a1,8
    800073d0:	00058793          	mv	a5,a1
    800073d4:	00050713          	mv	a4,a0
    800073d8:	01088833          	add	a6,a7,a6
    800073dc:	0007b883          	ld	a7,0(a5)
    800073e0:	00878793          	addi	a5,a5,8
    800073e4:	00870713          	addi	a4,a4,8
    800073e8:	ff173c23          	sd	a7,-8(a4)
    800073ec:	ff0798e3          	bne	a5,a6,800073dc <__memmove+0x68>
    800073f0:	ff867713          	andi	a4,a2,-8
    800073f4:	02071793          	slli	a5,a4,0x20
    800073f8:	0207d793          	srli	a5,a5,0x20
    800073fc:	00f585b3          	add	a1,a1,a5
    80007400:	40e686bb          	subw	a3,a3,a4
    80007404:	00f507b3          	add	a5,a0,a5
    80007408:	06e60463          	beq	a2,a4,80007470 <__memmove+0xfc>
    8000740c:	0005c703          	lbu	a4,0(a1)
    80007410:	00e78023          	sb	a4,0(a5)
    80007414:	04068e63          	beqz	a3,80007470 <__memmove+0xfc>
    80007418:	0015c603          	lbu	a2,1(a1)
    8000741c:	00100713          	li	a4,1
    80007420:	00c780a3          	sb	a2,1(a5)
    80007424:	04e68663          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007428:	0025c603          	lbu	a2,2(a1)
    8000742c:	00200713          	li	a4,2
    80007430:	00c78123          	sb	a2,2(a5)
    80007434:	02e68e63          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007438:	0035c603          	lbu	a2,3(a1)
    8000743c:	00300713          	li	a4,3
    80007440:	00c781a3          	sb	a2,3(a5)
    80007444:	02e68663          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007448:	0045c603          	lbu	a2,4(a1)
    8000744c:	00400713          	li	a4,4
    80007450:	00c78223          	sb	a2,4(a5)
    80007454:	00e68e63          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007458:	0055c603          	lbu	a2,5(a1)
    8000745c:	00500713          	li	a4,5
    80007460:	00c782a3          	sb	a2,5(a5)
    80007464:	00e68663          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007468:	0065c703          	lbu	a4,6(a1)
    8000746c:	00e78323          	sb	a4,6(a5)
    80007470:	00813403          	ld	s0,8(sp)
    80007474:	01010113          	addi	sp,sp,16
    80007478:	00008067          	ret
    8000747c:	02061713          	slli	a4,a2,0x20
    80007480:	02075713          	srli	a4,a4,0x20
    80007484:	00e587b3          	add	a5,a1,a4
    80007488:	f0f574e3          	bgeu	a0,a5,80007390 <__memmove+0x1c>
    8000748c:	02069613          	slli	a2,a3,0x20
    80007490:	02065613          	srli	a2,a2,0x20
    80007494:	fff64613          	not	a2,a2
    80007498:	00e50733          	add	a4,a0,a4
    8000749c:	00c78633          	add	a2,a5,a2
    800074a0:	fff7c683          	lbu	a3,-1(a5)
    800074a4:	fff78793          	addi	a5,a5,-1
    800074a8:	fff70713          	addi	a4,a4,-1
    800074ac:	00d70023          	sb	a3,0(a4)
    800074b0:	fec798e3          	bne	a5,a2,800074a0 <__memmove+0x12c>
    800074b4:	00813403          	ld	s0,8(sp)
    800074b8:	01010113          	addi	sp,sp,16
    800074bc:	00008067          	ret
    800074c0:	02069713          	slli	a4,a3,0x20
    800074c4:	02075713          	srli	a4,a4,0x20
    800074c8:	00170713          	addi	a4,a4,1
    800074cc:	00e50733          	add	a4,a0,a4
    800074d0:	00050793          	mv	a5,a0
    800074d4:	0005c683          	lbu	a3,0(a1)
    800074d8:	00178793          	addi	a5,a5,1
    800074dc:	00158593          	addi	a1,a1,1
    800074e0:	fed78fa3          	sb	a3,-1(a5)
    800074e4:	fee798e3          	bne	a5,a4,800074d4 <__memmove+0x160>
    800074e8:	f89ff06f          	j	80007470 <__memmove+0xfc>
	...

Disassembly of section .user:

000000008000c4d0 <copy_and_swap-0xb30>:
	...

000000008000d000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    8000d000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    8000d004:	00b29a63          	bne	t0,a1,8000d018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    8000d008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000d00c:	fe029ae3          	bnez	t0,8000d000 <copy_and_swap>
    li a0, 0               # Set return to success.
    8000d010:	00000513          	li	a0,0
    jr ra                  # Return.
    8000d014:	00008067          	ret

000000008000d018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    8000d018:	00100513          	li	a0,1
    8000d01c:	00008067          	ret

000000008000d020 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    8000d020:	ff010113          	addi	sp,sp,-16
    8000d024:	00813423          	sd	s0,8(sp)
    8000d028:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    8000d02c:	03f50513          	addi	a0,a0,63
    8000d030:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    8000d034:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    8000d038:	00100513          	li	a0,1
    asm("ecall");
    8000d03c:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    8000d040:	00050513          	mv	a0,a0

    return (void*)addr;
}
    8000d044:	00813403          	ld	s0,8(sp)
    8000d048:	01010113          	addi	sp,sp,16
    8000d04c:	00008067          	ret

000000008000d050 <_Z8mem_freePv>:

int mem_free(void *ptr){
    8000d050:	ff010113          	addi	sp,sp,-16
    8000d054:	00813423          	sd	s0,8(sp)
    8000d058:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    8000d05c:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    8000d060:	00200513          	li	a0,2
    asm("ecall");
    8000d064:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d068:	00050513          	mv	a0,a0
    return status;
}
    8000d06c:	0005051b          	sext.w	a0,a0
    8000d070:	00813403          	ld	s0,8(sp)
    8000d074:	01010113          	addi	sp,sp,16
    8000d078:	00008067          	ret

000000008000d07c <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    8000d07c:	fd010113          	addi	sp,sp,-48
    8000d080:	02113423          	sd	ra,40(sp)
    8000d084:	02813023          	sd	s0,32(sp)
    8000d088:	00913c23          	sd	s1,24(sp)
    8000d08c:	01213823          	sd	s2,16(sp)
    8000d090:	01313423          	sd	s3,8(sp)
    8000d094:	03010413          	addi	s0,sp,48
    8000d098:	00050913          	mv	s2,a0
    8000d09c:	00058493          	mv	s1,a1
    8000d0a0:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    8000d0a4:	04058e63          	beqz	a1,8000d100 <_Z13thread_createPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    8000d0a8:	00001537          	lui	a0,0x1
    8000d0ac:	00000097          	auipc	ra,0x0
    8000d0b0:	f74080e7          	jalr	-140(ra) # 8000d020 <_Z9mem_allocm>
        if(istack == 0) {
    8000d0b4:	04050063          	beqz	a0,8000d0f4 <_Z13thread_createPP7_threadPFvPvES2_+0x78>
            *handle = nullptr;
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    8000d0b8:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    8000d0bc:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    8000d0c0:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000d0c4:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    8000d0c8:	01100513          	li	a0,17

    asm("ecall");
    8000d0cc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d0d0:	00050513          	mv	a0,a0

    return status;
    8000d0d4:	0005051b          	sext.w	a0,a0
}
    8000d0d8:	02813083          	ld	ra,40(sp)
    8000d0dc:	02013403          	ld	s0,32(sp)
    8000d0e0:	01813483          	ld	s1,24(sp)
    8000d0e4:	01013903          	ld	s2,16(sp)
    8000d0e8:	00813983          	ld	s3,8(sp)
    8000d0ec:	03010113          	addi	sp,sp,48
    8000d0f0:	00008067          	ret
            *handle = nullptr;
    8000d0f4:	00093023          	sd	zero,0(s2)
            return -1;
    8000d0f8:	fff00513          	li	a0,-1
    8000d0fc:	fddff06f          	j	8000d0d8 <_Z13thread_createPP7_threadPFvPvES2_+0x5c>
    uint64 istack = 0;
    8000d100:	00000513          	li	a0,0
    8000d104:	fb5ff06f          	j	8000d0b8 <_Z13thread_createPP7_threadPFvPvES2_+0x3c>

000000008000d108 <_Z11thread_exitv>:

int thread_exit(){
    8000d108:	ff010113          	addi	sp,sp,-16
    8000d10c:	00813423          	sd	s0,8(sp)
    8000d110:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    8000d114:	01200513          	li	a0,18

    asm("ecall");
    8000d118:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d11c:	00050513          	mv	a0,a0

    return status;
}
    8000d120:	0005051b          	sext.w	a0,a0
    8000d124:	00813403          	ld	s0,8(sp)
    8000d128:	01010113          	addi	sp,sp,16
    8000d12c:	00008067          	ret

000000008000d130 <_Z15thread_dispatchv>:

void thread_dispatch(){
    8000d130:	ff010113          	addi	sp,sp,-16
    8000d134:	00813423          	sd	s0,8(sp)
    8000d138:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    8000d13c:	01300513          	li	a0,19

    asm("ecall");
    8000d140:	00000073          	ecall
}
    8000d144:	00813403          	ld	s0,8(sp)
    8000d148:	01010113          	addi	sp,sp,16
    8000d14c:	00008067          	ret

000000008000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    8000d150:	fd010113          	addi	sp,sp,-48
    8000d154:	02113423          	sd	ra,40(sp)
    8000d158:	02813023          	sd	s0,32(sp)
    8000d15c:	00913c23          	sd	s1,24(sp)
    8000d160:	01213823          	sd	s2,16(sp)
    8000d164:	01313423          	sd	s3,8(sp)
    8000d168:	03010413          	addi	s0,sp,48
    8000d16c:	00050493          	mv	s1,a0
    8000d170:	00058913          	mv	s2,a1
    8000d174:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(handle && start_routine) {
    8000d178:	04050a63          	beqz	a0,8000d1cc <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x7c>
    8000d17c:	04058c63          	beqz	a1,8000d1d4 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    8000d180:	00001537          	lui	a0,0x1
    8000d184:	00000097          	auipc	ra,0x0
    8000d188:	e9c080e7          	jalr	-356(ra) # 8000d020 <_Z9mem_allocm>
        if(istack == 0) {
    8000d18c:	04050863          	beqz	a0,8000d1dc <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x8c>
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    8000d190:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    8000d194:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    8000d198:	00090613          	mv	a2,s2
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000d19c:	00048593          	mv	a1,s1
    asm("li a0, 0x14");
    8000d1a0:	01400513          	li	a0,20

    asm("ecall");
    8000d1a4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d1a8:	00050513          	mv	a0,a0

    return status;
    8000d1ac:	0005051b          	sext.w	a0,a0
}
    8000d1b0:	02813083          	ld	ra,40(sp)
    8000d1b4:	02013403          	ld	s0,32(sp)
    8000d1b8:	01813483          	ld	s1,24(sp)
    8000d1bc:	01013903          	ld	s2,16(sp)
    8000d1c0:	00813983          	ld	s3,8(sp)
    8000d1c4:	03010113          	addi	sp,sp,48
    8000d1c8:	00008067          	ret
    uint64 istack = 0;
    8000d1cc:	00000513          	li	a0,0
    8000d1d0:	fc1ff06f          	j	8000d190 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
    8000d1d4:	00000513          	li	a0,0
    8000d1d8:	fb9ff06f          	j	8000d190 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
            return -1;
    8000d1dc:	fff00513          	li	a0,-1
    8000d1e0:	fd1ff06f          	j	8000d1b0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x60>

000000008000d1e4 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    8000d1e4:	ff010113          	addi	sp,sp,-16
    8000d1e8:	00813423          	sd	s0,8(sp)
    8000d1ec:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;
    if(handle == nullptr)
    8000d1f0:	02050263          	beqz	a0,8000d214 <_Z12thread_startP7_thread+0x30>
        return -1;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000d1f4:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    8000d1f8:	01500513          	li	a0,21

    asm("ecall");
    8000d1fc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d200:	00050513          	mv	a0,a0

    return status;
    8000d204:	0005051b          	sext.w	a0,a0
}
    8000d208:	00813403          	ld	s0,8(sp)
    8000d20c:	01010113          	addi	sp,sp,16
    8000d210:	00008067          	ret
        return -1;
    8000d214:	fff00513          	li	a0,-1
    8000d218:	ff1ff06f          	j	8000d208 <_Z12thread_startP7_thread+0x24>

000000008000d21c <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    8000d21c:	ff010113          	addi	sp,sp,-16
    8000d220:	00813423          	sd	s0,8(sp)
    8000d224:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    8000d228:	02059593          	slli	a1,a1,0x20
    8000d22c:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    8000d230:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000d234:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    8000d238:	02100513          	li	a0,33


    asm("ecall");
    8000d23c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d240:	00050513          	mv	a0,a0

    return status;

}
    8000d244:	0005051b          	sext.w	a0,a0
    8000d248:	00813403          	ld	s0,8(sp)
    8000d24c:	01010113          	addi	sp,sp,16
    8000d250:	00008067          	ret

000000008000d254 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    8000d254:	ff010113          	addi	sp,sp,-16
    8000d258:	00813423          	sd	s0,8(sp)
    8000d25c:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000d260:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    8000d264:	02200513          	li	a0,34


    asm("ecall");
    8000d268:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d26c:	00050513          	mv	a0,a0

    return status;
}
    8000d270:	0005051b          	sext.w	a0,a0
    8000d274:	00813403          	ld	s0,8(sp)
    8000d278:	01010113          	addi	sp,sp,16
    8000d27c:	00008067          	ret

000000008000d280 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    8000d280:	ff010113          	addi	sp,sp,-16
    8000d284:	00813423          	sd	s0,8(sp)
    8000d288:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000d28c:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    8000d290:	02300513          	li	a0,35


    asm("ecall");
    8000d294:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d298:	00050513          	mv	a0,a0

    return status;
}
    8000d29c:	0005051b          	sext.w	a0,a0
    8000d2a0:	00813403          	ld	s0,8(sp)
    8000d2a4:	01010113          	addi	sp,sp,16
    8000d2a8:	00008067          	ret

000000008000d2ac <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    8000d2ac:	ff010113          	addi	sp,sp,-16
    8000d2b0:	00813423          	sd	s0,8(sp)
    8000d2b4:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000d2b8:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    8000d2bc:	02400513          	li	a0,36


    asm("ecall");
    8000d2c0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d2c4:	00050513          	mv	a0,a0

    return status;
}
    8000d2c8:	0005051b          	sext.w	a0,a0
    8000d2cc:	00813403          	ld	s0,8(sp)
    8000d2d0:	01010113          	addi	sp,sp,16
    8000d2d4:	00008067          	ret

000000008000d2d8 <_Z10time_sleepm>:

int time_sleep(time_t time){
    8000d2d8:	ff010113          	addi	sp,sp,-16
    8000d2dc:	00813423          	sd	s0,8(sp)
    8000d2e0:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    8000d2e4:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    8000d2e8:	03100513          	li	a0,49


    asm("ecall");
    8000d2ec:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d2f0:	00050513          	mv	a0,a0

    return status;
}
    8000d2f4:	0005051b          	sext.w	a0,a0
    8000d2f8:	00813403          	ld	s0,8(sp)
    8000d2fc:	01010113          	addi	sp,sp,16
    8000d300:	00008067          	ret

000000008000d304 <_Z4getcv>:

char getc(){
    8000d304:	ff010113          	addi	sp,sp,-16
    8000d308:	00813423          	sd	s0,8(sp)
    8000d30c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    8000d310:	04100513          	li	a0,65

    asm("ecall");
    8000d314:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    8000d318:	00050513          	mv	a0,a0

    return c;
}
    8000d31c:	0ff57513          	andi	a0,a0,255
    8000d320:	00813403          	ld	s0,8(sp)
    8000d324:	01010113          	addi	sp,sp,16
    8000d328:	00008067          	ret

000000008000d32c <_Z4putcc>:

void putc(char c){
    8000d32c:	ff010113          	addi	sp,sp,-16
    8000d330:	00813423          	sd	s0,8(sp)
    8000d334:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    8000d338:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    8000d33c:	04200513          	li	a0,66

    asm("ecall");
    8000d340:	00000073          	ecall
}
    8000d344:	00813403          	ld	s0,8(sp)
    8000d348:	01010113          	addi	sp,sp,16
    8000d34c:	00008067          	ret

000000008000d350 <_Z4forkv>:


int fork(){
    8000d350:	ff010113          	addi	sp,sp,-16
    8000d354:	00813423          	sd	s0,8(sp)
    8000d358:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    8000d35c:	06100513          	li	a0,97

    asm("ecall");
    8000d360:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000d364:	00050513          	mv	a0,a0

    return status;
}
    8000d368:	0005051b          	sext.w	a0,a0
    8000d36c:	00813403          	ld	s0,8(sp)
    8000d370:	01010113          	addi	sp,sp,16
    8000d374:	00008067          	ret

000000008000d378 <_Z8tcb_freePv>:

void tcb_free(void* addr){
    8000d378:	ff010113          	addi	sp,sp,-16
    8000d37c:	00813423          	sd	s0,8(sp)
    8000d380:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    8000d384:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    8000d388:	05100513          	li	a0,81
    asm("ecall");
    8000d38c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    8000d390:	00813403          	ld	s0,8(sp)
    8000d394:	01010113          	addi	sp,sp,16
    8000d398:	00008067          	ret

000000008000d39c <_ZN10_semaphoredlEPv>:
#include "../../h/user/_semaphore.hpp"
#include "../../h/user/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    8000d39c:	ff010113          	addi	sp,sp,-16
    8000d3a0:	00113423          	sd	ra,8(sp)
    8000d3a4:	00813023          	sd	s0,0(sp)
    8000d3a8:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    8000d3ac:	00000097          	auipc	ra,0x0
    8000d3b0:	ea8080e7          	jalr	-344(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
}
    8000d3b4:	00813083          	ld	ra,8(sp)
    8000d3b8:	00013403          	ld	s0,0(sp)
    8000d3bc:	01010113          	addi	sp,sp,16
    8000d3c0:	00008067          	ret

000000008000d3c4 <_ZN7_threaddlEPv>:
#include "../../h/user/_thread.hpp"
#include "../../h/kernel/tcb.hpp"
#include "../../h/user/syscall_c.h"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    8000d3c4:	ff010113          	addi	sp,sp,-16
    8000d3c8:	00113423          	sd	ra,8(sp)
    8000d3cc:	00813023          	sd	s0,0(sp)
    8000d3d0:	01010413          	addi	s0,sp,16
    tcb_free(addr);
    8000d3d4:	00000097          	auipc	ra,0x0
    8000d3d8:	fa4080e7          	jalr	-92(ra) # 8000d378 <_Z8tcb_freePv>
    8000d3dc:	00813083          	ld	ra,8(sp)
    8000d3e0:	00013403          	ld	s0,0(sp)
    8000d3e4:	01010113          	addi	sp,sp,16
    8000d3e8:	00008067          	ret

000000008000d3ec <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000d3ec:	fd010113          	addi	sp,sp,-48
    8000d3f0:	02113423          	sd	ra,40(sp)
    8000d3f4:	02813023          	sd	s0,32(sp)
    8000d3f8:	00913c23          	sd	s1,24(sp)
    8000d3fc:	01213823          	sd	s2,16(sp)
    8000d400:	01313423          	sd	s3,8(sp)
    8000d404:	03010413          	addi	s0,sp,48
    8000d408:	00050493          	mv	s1,a0
    8000d40c:	00058993          	mv	s3,a1
    8000d410:	0015879b          	addiw	a5,a1,1
    8000d414:	0007851b          	sext.w	a0,a5
    8000d418:	00f4a023          	sw	a5,0(s1)
    8000d41c:	0004a823          	sw	zero,16(s1)
    8000d420:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000d424:	00251513          	slli	a0,a0,0x2
    8000d428:	00000097          	auipc	ra,0x0
    8000d42c:	bf8080e7          	jalr	-1032(ra) # 8000d020 <_Z9mem_allocm>
    8000d430:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    8000d434:	01000513          	li	a0,16
    8000d438:	00002097          	auipc	ra,0x2
    8000d43c:	be0080e7          	jalr	-1056(ra) # 8000f018 <_Znwm>
    8000d440:	00050913          	mv	s2,a0
    8000d444:	00050863          	beqz	a0,8000d454 <_ZN9BufferCPPC1Ei+0x68>
    8000d448:	00000593          	li	a1,0
    8000d44c:	00002097          	auipc	ra,0x2
    8000d450:	cc4080e7          	jalr	-828(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000d454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000d458:	01000513          	li	a0,16
    8000d45c:	00002097          	auipc	ra,0x2
    8000d460:	bbc080e7          	jalr	-1092(ra) # 8000f018 <_Znwm>
    8000d464:	00050913          	mv	s2,a0
    8000d468:	00050863          	beqz	a0,8000d478 <_ZN9BufferCPPC1Ei+0x8c>
    8000d46c:	00098593          	mv	a1,s3
    8000d470:	00002097          	auipc	ra,0x2
    8000d474:	ca0080e7          	jalr	-864(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000d478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000d47c:	01000513          	li	a0,16
    8000d480:	00002097          	auipc	ra,0x2
    8000d484:	b98080e7          	jalr	-1128(ra) # 8000f018 <_Znwm>
    8000d488:	00050913          	mv	s2,a0
    8000d48c:	00050863          	beqz	a0,8000d49c <_ZN9BufferCPPC1Ei+0xb0>
    8000d490:	00100593          	li	a1,1
    8000d494:	00002097          	auipc	ra,0x2
    8000d498:	c7c080e7          	jalr	-900(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000d49c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000d4a0:	01000513          	li	a0,16
    8000d4a4:	00002097          	auipc	ra,0x2
    8000d4a8:	b74080e7          	jalr	-1164(ra) # 8000f018 <_Znwm>
    8000d4ac:	00050913          	mv	s2,a0
    8000d4b0:	00050863          	beqz	a0,8000d4c0 <_ZN9BufferCPPC1Ei+0xd4>
    8000d4b4:	00100593          	li	a1,1
    8000d4b8:	00002097          	auipc	ra,0x2
    8000d4bc:	c58080e7          	jalr	-936(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000d4c0:	0324b823          	sd	s2,48(s1)
}
    8000d4c4:	02813083          	ld	ra,40(sp)
    8000d4c8:	02013403          	ld	s0,32(sp)
    8000d4cc:	01813483          	ld	s1,24(sp)
    8000d4d0:	01013903          	ld	s2,16(sp)
    8000d4d4:	00813983          	ld	s3,8(sp)
    8000d4d8:	03010113          	addi	sp,sp,48
    8000d4dc:	00008067          	ret
    8000d4e0:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    8000d4e4:	00090513          	mv	a0,s2
    8000d4e8:	00002097          	auipc	ra,0x2
    8000d4ec:	b80080e7          	jalr	-1152(ra) # 8000f068 <_ZdlPv>
    8000d4f0:	00048513          	mv	a0,s1
    8000d4f4:	fffff097          	auipc	ra,0xfffff
    8000d4f8:	e44080e7          	jalr	-444(ra) # 8000c338 <_Unwind_Resume>
    8000d4fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000d500:	00090513          	mv	a0,s2
    8000d504:	00002097          	auipc	ra,0x2
    8000d508:	b64080e7          	jalr	-1180(ra) # 8000f068 <_ZdlPv>
    8000d50c:	00048513          	mv	a0,s1
    8000d510:	fffff097          	auipc	ra,0xfffff
    8000d514:	e28080e7          	jalr	-472(ra) # 8000c338 <_Unwind_Resume>
    8000d518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000d51c:	00090513          	mv	a0,s2
    8000d520:	00002097          	auipc	ra,0x2
    8000d524:	b48080e7          	jalr	-1208(ra) # 8000f068 <_ZdlPv>
    8000d528:	00048513          	mv	a0,s1
    8000d52c:	fffff097          	auipc	ra,0xfffff
    8000d530:	e0c080e7          	jalr	-500(ra) # 8000c338 <_Unwind_Resume>
    8000d534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000d538:	00090513          	mv	a0,s2
    8000d53c:	00002097          	auipc	ra,0x2
    8000d540:	b2c080e7          	jalr	-1236(ra) # 8000f068 <_ZdlPv>
    8000d544:	00048513          	mv	a0,s1
    8000d548:	fffff097          	auipc	ra,0xfffff
    8000d54c:	df0080e7          	jalr	-528(ra) # 8000c338 <_Unwind_Resume>

000000008000d550 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    8000d550:	fe010113          	addi	sp,sp,-32
    8000d554:	00113c23          	sd	ra,24(sp)
    8000d558:	00813823          	sd	s0,16(sp)
    8000d55c:	00913423          	sd	s1,8(sp)
    8000d560:	01213023          	sd	s2,0(sp)
    8000d564:	02010413          	addi	s0,sp,32
    8000d568:	00050493          	mv	s1,a0
    8000d56c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    8000d570:	01853503          	ld	a0,24(a0) # 1018 <_entry-0x7fffefe8>
    8000d574:	00002097          	auipc	ra,0x2
    8000d578:	bd4080e7          	jalr	-1068(ra) # 8000f148 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000d57c:	0304b503          	ld	a0,48(s1)
    8000d580:	00002097          	auipc	ra,0x2
    8000d584:	bc8080e7          	jalr	-1080(ra) # 8000f148 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000d588:	0084b783          	ld	a5,8(s1)
    8000d58c:	0144a703          	lw	a4,20(s1)
    8000d590:	00271713          	slli	a4,a4,0x2
    8000d594:	00e787b3          	add	a5,a5,a4
    8000d598:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000d59c:	0144a783          	lw	a5,20(s1)
    8000d5a0:	0017879b          	addiw	a5,a5,1
    8000d5a4:	0004a703          	lw	a4,0(s1)
    8000d5a8:	02e7e7bb          	remw	a5,a5,a4
    8000d5ac:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    8000d5b0:	0304b503          	ld	a0,48(s1)
    8000d5b4:	00002097          	auipc	ra,0x2
    8000d5b8:	bc0080e7          	jalr	-1088(ra) # 8000f174 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000d5bc:	0204b503          	ld	a0,32(s1)
    8000d5c0:	00002097          	auipc	ra,0x2
    8000d5c4:	bb4080e7          	jalr	-1100(ra) # 8000f174 <_ZN9Semaphore6signalEv>

}
    8000d5c8:	01813083          	ld	ra,24(sp)
    8000d5cc:	01013403          	ld	s0,16(sp)
    8000d5d0:	00813483          	ld	s1,8(sp)
    8000d5d4:	00013903          	ld	s2,0(sp)
    8000d5d8:	02010113          	addi	sp,sp,32
    8000d5dc:	00008067          	ret

000000008000d5e0 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    8000d5e0:	fe010113          	addi	sp,sp,-32
    8000d5e4:	00113c23          	sd	ra,24(sp)
    8000d5e8:	00813823          	sd	s0,16(sp)
    8000d5ec:	00913423          	sd	s1,8(sp)
    8000d5f0:	01213023          	sd	s2,0(sp)
    8000d5f4:	02010413          	addi	s0,sp,32
    8000d5f8:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000d5fc:	02053503          	ld	a0,32(a0)
    8000d600:	00002097          	auipc	ra,0x2
    8000d604:	b48080e7          	jalr	-1208(ra) # 8000f148 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000d608:	0284b503          	ld	a0,40(s1)
    8000d60c:	00002097          	auipc	ra,0x2
    8000d610:	b3c080e7          	jalr	-1220(ra) # 8000f148 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000d614:	0084b703          	ld	a4,8(s1)
    8000d618:	0104a783          	lw	a5,16(s1)
    8000d61c:	00279693          	slli	a3,a5,0x2
    8000d620:	00d70733          	add	a4,a4,a3
    8000d624:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000d628:	0017879b          	addiw	a5,a5,1
    8000d62c:	0004a703          	lw	a4,0(s1)
    8000d630:	02e7e7bb          	remw	a5,a5,a4
    8000d634:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    8000d638:	0284b503          	ld	a0,40(s1)
    8000d63c:	00002097          	auipc	ra,0x2
    8000d640:	b38080e7          	jalr	-1224(ra) # 8000f174 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000d644:	0184b503          	ld	a0,24(s1)
    8000d648:	00002097          	auipc	ra,0x2
    8000d64c:	b2c080e7          	jalr	-1236(ra) # 8000f174 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000d650:	00090513          	mv	a0,s2
    8000d654:	01813083          	ld	ra,24(sp)
    8000d658:	01013403          	ld	s0,16(sp)
    8000d65c:	00813483          	ld	s1,8(sp)
    8000d660:	00013903          	ld	s2,0(sp)
    8000d664:	02010113          	addi	sp,sp,32
    8000d668:	00008067          	ret

000000008000d66c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8000d66c:	fe010113          	addi	sp,sp,-32
    8000d670:	00113c23          	sd	ra,24(sp)
    8000d674:	00813823          	sd	s0,16(sp)
    8000d678:	00913423          	sd	s1,8(sp)
    8000d67c:	01213023          	sd	s2,0(sp)
    8000d680:	02010413          	addi	s0,sp,32
    8000d684:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000d688:	02853503          	ld	a0,40(a0)
    8000d68c:	00002097          	auipc	ra,0x2
    8000d690:	abc080e7          	jalr	-1348(ra) # 8000f148 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000d694:	0304b503          	ld	a0,48(s1)
    8000d698:	00002097          	auipc	ra,0x2
    8000d69c:	ab0080e7          	jalr	-1360(ra) # 8000f148 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    8000d6a0:	0144a783          	lw	a5,20(s1)
    8000d6a4:	0104a903          	lw	s2,16(s1)
    8000d6a8:	0327ce63          	blt	a5,s2,8000d6e4 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000d6ac:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    8000d6b0:	0304b503          	ld	a0,48(s1)
    8000d6b4:	00002097          	auipc	ra,0x2
    8000d6b8:	ac0080e7          	jalr	-1344(ra) # 8000f174 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000d6bc:	0284b503          	ld	a0,40(s1)
    8000d6c0:	00002097          	auipc	ra,0x2
    8000d6c4:	ab4080e7          	jalr	-1356(ra) # 8000f174 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000d6c8:	00090513          	mv	a0,s2
    8000d6cc:	01813083          	ld	ra,24(sp)
    8000d6d0:	01013403          	ld	s0,16(sp)
    8000d6d4:	00813483          	ld	s1,8(sp)
    8000d6d8:	00013903          	ld	s2,0(sp)
    8000d6dc:	02010113          	addi	sp,sp,32
    8000d6e0:	00008067          	ret
        ret = cap - head + tail;
    8000d6e4:	0004a703          	lw	a4,0(s1)
    8000d6e8:	4127093b          	subw	s2,a4,s2
    8000d6ec:	00f9093b          	addw	s2,s2,a5
    8000d6f0:	fc1ff06f          	j	8000d6b0 <_ZN9BufferCPP6getCntEv+0x44>

000000008000d6f4 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000d6f4:	fe010113          	addi	sp,sp,-32
    8000d6f8:	00113c23          	sd	ra,24(sp)
    8000d6fc:	00813823          	sd	s0,16(sp)
    8000d700:	00913423          	sd	s1,8(sp)
    8000d704:	02010413          	addi	s0,sp,32
    8000d708:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000d70c:	00a00513          	li	a0,10
    8000d710:	00002097          	auipc	ra,0x2
    8000d714:	c9c080e7          	jalr	-868(ra) # 8000f3ac <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000d718:	00003517          	auipc	a0,0x3
    8000d71c:	8e850513          	addi	a0,a0,-1816 # 80010000 <userDataStart>
    8000d720:	00001097          	auipc	ra,0x1
    8000d724:	54c080e7          	jalr	1356(ra) # 8000ec6c <_Z11printStringPKc>
    while (getCnt()) {
    8000d728:	00048513          	mv	a0,s1
    8000d72c:	00000097          	auipc	ra,0x0
    8000d730:	f40080e7          	jalr	-192(ra) # 8000d66c <_ZN9BufferCPP6getCntEv>
    8000d734:	02050c63          	beqz	a0,8000d76c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    8000d738:	0084b783          	ld	a5,8(s1)
    8000d73c:	0104a703          	lw	a4,16(s1)
    8000d740:	00271713          	slli	a4,a4,0x2
    8000d744:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    8000d748:	0007c503          	lbu	a0,0(a5)
    8000d74c:	00002097          	auipc	ra,0x2
    8000d750:	c60080e7          	jalr	-928(ra) # 8000f3ac <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000d754:	0104a783          	lw	a5,16(s1)
    8000d758:	0017879b          	addiw	a5,a5,1
    8000d75c:	0004a703          	lw	a4,0(s1)
    8000d760:	02e7e7bb          	remw	a5,a5,a4
    8000d764:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000d768:	fc1ff06f          	j	8000d728 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8000d76c:	02100513          	li	a0,33
    8000d770:	00002097          	auipc	ra,0x2
    8000d774:	c3c080e7          	jalr	-964(ra) # 8000f3ac <_ZN7Console4putcEc>
    Console::putc('\n');
    8000d778:	00a00513          	li	a0,10
    8000d77c:	00002097          	auipc	ra,0x2
    8000d780:	c30080e7          	jalr	-976(ra) # 8000f3ac <_ZN7Console4putcEc>
    mem_free(buffer);
    8000d784:	0084b503          	ld	a0,8(s1)
    8000d788:	00000097          	auipc	ra,0x0
    8000d78c:	8c8080e7          	jalr	-1848(ra) # 8000d050 <_Z8mem_freePv>
    delete itemAvailable;
    8000d790:	0204b503          	ld	a0,32(s1)
    8000d794:	00050863          	beqz	a0,8000d7a4 <_ZN9BufferCPPD1Ev+0xb0>
    8000d798:	00053783          	ld	a5,0(a0)
    8000d79c:	0087b783          	ld	a5,8(a5)
    8000d7a0:	000780e7          	jalr	a5
    delete spaceAvailable;
    8000d7a4:	0184b503          	ld	a0,24(s1)
    8000d7a8:	00050863          	beqz	a0,8000d7b8 <_ZN9BufferCPPD1Ev+0xc4>
    8000d7ac:	00053783          	ld	a5,0(a0)
    8000d7b0:	0087b783          	ld	a5,8(a5)
    8000d7b4:	000780e7          	jalr	a5
    delete mutexTail;
    8000d7b8:	0304b503          	ld	a0,48(s1)
    8000d7bc:	00050863          	beqz	a0,8000d7cc <_ZN9BufferCPPD1Ev+0xd8>
    8000d7c0:	00053783          	ld	a5,0(a0)
    8000d7c4:	0087b783          	ld	a5,8(a5)
    8000d7c8:	000780e7          	jalr	a5
    delete mutexHead;
    8000d7cc:	0284b503          	ld	a0,40(s1)
    8000d7d0:	00050863          	beqz	a0,8000d7e0 <_ZN9BufferCPPD1Ev+0xec>
    8000d7d4:	00053783          	ld	a5,0(a0)
    8000d7d8:	0087b783          	ld	a5,8(a5)
    8000d7dc:	000780e7          	jalr	a5
}
    8000d7e0:	01813083          	ld	ra,24(sp)
    8000d7e4:	01013403          	ld	s0,16(sp)
    8000d7e8:	00813483          	ld	s1,8(sp)
    8000d7ec:	02010113          	addi	sp,sp,32
    8000d7f0:	00008067          	ret

000000008000d7f4 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    8000d7f4:	fe010113          	addi	sp,sp,-32
    8000d7f8:	00113c23          	sd	ra,24(sp)
    8000d7fc:	00813823          	sd	s0,16(sp)
    8000d800:	00913423          	sd	s1,8(sp)
    8000d804:	01213023          	sd	s2,0(sp)
    8000d808:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000d80c:	00000913          	li	s2,0
    8000d810:	0380006f          	j	8000d848 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000d814:	00000097          	auipc	ra,0x0
    8000d818:	91c080e7          	jalr	-1764(ra) # 8000d130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000d81c:	00148493          	addi	s1,s1,1
    8000d820:	000027b7          	lui	a5,0x2
    8000d824:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000d828:	0097ee63          	bltu	a5,s1,8000d844 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000d82c:	00000713          	li	a4,0
    8000d830:	000077b7          	lui	a5,0x7
    8000d834:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000d838:	fce7eee3          	bltu	a5,a4,8000d814 <_Z11workerBodyAPv+0x20>
    8000d83c:	00170713          	addi	a4,a4,1
    8000d840:	ff1ff06f          	j	8000d830 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000d844:	00190913          	addi	s2,s2,1
    8000d848:	00900793          	li	a5,9
    8000d84c:	0527e063          	bltu	a5,s2,8000d88c <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000d850:	00002517          	auipc	a0,0x2
    8000d854:	7c850513          	addi	a0,a0,1992 # 80010018 <userDataStart+0x18>
    8000d858:	00001097          	auipc	ra,0x1
    8000d85c:	414080e7          	jalr	1044(ra) # 8000ec6c <_Z11printStringPKc>
    8000d860:	00000613          	li	a2,0
    8000d864:	00a00593          	li	a1,10
    8000d868:	0009051b          	sext.w	a0,s2
    8000d86c:	00001097          	auipc	ra,0x1
    8000d870:	598080e7          	jalr	1432(ra) # 8000ee04 <_Z8printIntiii>
    8000d874:	00003517          	auipc	a0,0x3
    8000d878:	8d450513          	addi	a0,a0,-1836 # 80010148 <userDataStart+0x148>
    8000d87c:	00001097          	auipc	ra,0x1
    8000d880:	3f0080e7          	jalr	1008(ra) # 8000ec6c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d884:	00000493          	li	s1,0
    8000d888:	f99ff06f          	j	8000d820 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000d88c:	00002517          	auipc	a0,0x2
    8000d890:	79450513          	addi	a0,a0,1940 # 80010020 <userDataStart+0x20>
    8000d894:	00001097          	auipc	ra,0x1
    8000d898:	3d8080e7          	jalr	984(ra) # 8000ec6c <_Z11printStringPKc>
    finishedA = true;
    8000d89c:	00100793          	li	a5,1
    8000d8a0:	00003717          	auipc	a4,0x3
    8000d8a4:	acf70823          	sb	a5,-1328(a4) # 80010370 <finishedA>
}
    8000d8a8:	01813083          	ld	ra,24(sp)
    8000d8ac:	01013403          	ld	s0,16(sp)
    8000d8b0:	00813483          	ld	s1,8(sp)
    8000d8b4:	00013903          	ld	s2,0(sp)
    8000d8b8:	02010113          	addi	sp,sp,32
    8000d8bc:	00008067          	ret

000000008000d8c0 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    8000d8c0:	fe010113          	addi	sp,sp,-32
    8000d8c4:	00113c23          	sd	ra,24(sp)
    8000d8c8:	00813823          	sd	s0,16(sp)
    8000d8cc:	00913423          	sd	s1,8(sp)
    8000d8d0:	01213023          	sd	s2,0(sp)
    8000d8d4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000d8d8:	00000913          	li	s2,0
    8000d8dc:	0380006f          	j	8000d914 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000d8e0:	00000097          	auipc	ra,0x0
    8000d8e4:	850080e7          	jalr	-1968(ra) # 8000d130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000d8e8:	00148493          	addi	s1,s1,1
    8000d8ec:	000027b7          	lui	a5,0x2
    8000d8f0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000d8f4:	0097ee63          	bltu	a5,s1,8000d910 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000d8f8:	00000713          	li	a4,0
    8000d8fc:	000077b7          	lui	a5,0x7
    8000d900:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000d904:	fce7eee3          	bltu	a5,a4,8000d8e0 <_Z11workerBodyBPv+0x20>
    8000d908:	00170713          	addi	a4,a4,1
    8000d90c:	ff1ff06f          	j	8000d8fc <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000d910:	00190913          	addi	s2,s2,1
    8000d914:	00f00793          	li	a5,15
    8000d918:	0527e063          	bltu	a5,s2,8000d958 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000d91c:	00002517          	auipc	a0,0x2
    8000d920:	71450513          	addi	a0,a0,1812 # 80010030 <userDataStart+0x30>
    8000d924:	00001097          	auipc	ra,0x1
    8000d928:	348080e7          	jalr	840(ra) # 8000ec6c <_Z11printStringPKc>
    8000d92c:	00000613          	li	a2,0
    8000d930:	00a00593          	li	a1,10
    8000d934:	0009051b          	sext.w	a0,s2
    8000d938:	00001097          	auipc	ra,0x1
    8000d93c:	4cc080e7          	jalr	1228(ra) # 8000ee04 <_Z8printIntiii>
    8000d940:	00003517          	auipc	a0,0x3
    8000d944:	80850513          	addi	a0,a0,-2040 # 80010148 <userDataStart+0x148>
    8000d948:	00001097          	auipc	ra,0x1
    8000d94c:	324080e7          	jalr	804(ra) # 8000ec6c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d950:	00000493          	li	s1,0
    8000d954:	f99ff06f          	j	8000d8ec <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000d958:	00002517          	auipc	a0,0x2
    8000d95c:	6e050513          	addi	a0,a0,1760 # 80010038 <userDataStart+0x38>
    8000d960:	00001097          	auipc	ra,0x1
    8000d964:	30c080e7          	jalr	780(ra) # 8000ec6c <_Z11printStringPKc>
    finishedB = true;
    8000d968:	00100793          	li	a5,1
    8000d96c:	00003717          	auipc	a4,0x3
    8000d970:	a0f702a3          	sb	a5,-1531(a4) # 80010371 <finishedB>
    thread_dispatch();
    8000d974:	fffff097          	auipc	ra,0xfffff
    8000d978:	7bc080e7          	jalr	1980(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000d97c:	01813083          	ld	ra,24(sp)
    8000d980:	01013403          	ld	s0,16(sp)
    8000d984:	00813483          	ld	s1,8(sp)
    8000d988:	00013903          	ld	s2,0(sp)
    8000d98c:	02010113          	addi	sp,sp,32
    8000d990:	00008067          	ret

000000008000d994 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    8000d994:	fe010113          	addi	sp,sp,-32
    8000d998:	00113c23          	sd	ra,24(sp)
    8000d99c:	00813823          	sd	s0,16(sp)
    8000d9a0:	00913423          	sd	s1,8(sp)
    8000d9a4:	01213023          	sd	s2,0(sp)
    8000d9a8:	02010413          	addi	s0,sp,32
    8000d9ac:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000d9b0:	00100793          	li	a5,1
    8000d9b4:	02a7f863          	bgeu	a5,a0,8000d9e4 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000d9b8:	00a00793          	li	a5,10
    8000d9bc:	02f577b3          	remu	a5,a0,a5
    8000d9c0:	02078e63          	beqz	a5,8000d9fc <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000d9c4:	fff48513          	addi	a0,s1,-1
    8000d9c8:	00000097          	auipc	ra,0x0
    8000d9cc:	fcc080e7          	jalr	-52(ra) # 8000d994 <_Z9fibonaccim>
    8000d9d0:	00050913          	mv	s2,a0
    8000d9d4:	ffe48513          	addi	a0,s1,-2
    8000d9d8:	00000097          	auipc	ra,0x0
    8000d9dc:	fbc080e7          	jalr	-68(ra) # 8000d994 <_Z9fibonaccim>
    8000d9e0:	00a90533          	add	a0,s2,a0
}
    8000d9e4:	01813083          	ld	ra,24(sp)
    8000d9e8:	01013403          	ld	s0,16(sp)
    8000d9ec:	00813483          	ld	s1,8(sp)
    8000d9f0:	00013903          	ld	s2,0(sp)
    8000d9f4:	02010113          	addi	sp,sp,32
    8000d9f8:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000d9fc:	fffff097          	auipc	ra,0xfffff
    8000da00:	734080e7          	jalr	1844(ra) # 8000d130 <_Z15thread_dispatchv>
    8000da04:	fc1ff06f          	j	8000d9c4 <_Z9fibonaccim+0x30>

000000008000da08 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    8000da08:	fe010113          	addi	sp,sp,-32
    8000da0c:	00113c23          	sd	ra,24(sp)
    8000da10:	00813823          	sd	s0,16(sp)
    8000da14:	00913423          	sd	s1,8(sp)
    8000da18:	01213023          	sd	s2,0(sp)
    8000da1c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000da20:	00000493          	li	s1,0
    8000da24:	0400006f          	j	8000da64 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000da28:	00002517          	auipc	a0,0x2
    8000da2c:	62050513          	addi	a0,a0,1568 # 80010048 <userDataStart+0x48>
    8000da30:	00001097          	auipc	ra,0x1
    8000da34:	23c080e7          	jalr	572(ra) # 8000ec6c <_Z11printStringPKc>
    8000da38:	00000613          	li	a2,0
    8000da3c:	00a00593          	li	a1,10
    8000da40:	00048513          	mv	a0,s1
    8000da44:	00001097          	auipc	ra,0x1
    8000da48:	3c0080e7          	jalr	960(ra) # 8000ee04 <_Z8printIntiii>
    8000da4c:	00002517          	auipc	a0,0x2
    8000da50:	6fc50513          	addi	a0,a0,1788 # 80010148 <userDataStart+0x148>
    8000da54:	00001097          	auipc	ra,0x1
    8000da58:	218080e7          	jalr	536(ra) # 8000ec6c <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000da5c:	0014849b          	addiw	s1,s1,1
    8000da60:	0ff4f493          	andi	s1,s1,255
    8000da64:	00200793          	li	a5,2
    8000da68:	fc97f0e3          	bgeu	a5,s1,8000da28 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    8000da6c:	00002517          	auipc	a0,0x2
    8000da70:	5e450513          	addi	a0,a0,1508 # 80010050 <userDataStart+0x50>
    8000da74:	00001097          	auipc	ra,0x1
    8000da78:	1f8080e7          	jalr	504(ra) # 8000ec6c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000da7c:	00700313          	li	t1,7
    thread_dispatch();
    8000da80:	fffff097          	auipc	ra,0xfffff
    8000da84:	6b0080e7          	jalr	1712(ra) # 8000d130 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000da88:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000da8c:	00002517          	auipc	a0,0x2
    8000da90:	5d450513          	addi	a0,a0,1492 # 80010060 <userDataStart+0x60>
    8000da94:	00001097          	auipc	ra,0x1
    8000da98:	1d8080e7          	jalr	472(ra) # 8000ec6c <_Z11printStringPKc>
    8000da9c:	00000613          	li	a2,0
    8000daa0:	00a00593          	li	a1,10
    8000daa4:	0009051b          	sext.w	a0,s2
    8000daa8:	00001097          	auipc	ra,0x1
    8000daac:	35c080e7          	jalr	860(ra) # 8000ee04 <_Z8printIntiii>
    8000dab0:	00002517          	auipc	a0,0x2
    8000dab4:	69850513          	addi	a0,a0,1688 # 80010148 <userDataStart+0x148>
    8000dab8:	00001097          	auipc	ra,0x1
    8000dabc:	1b4080e7          	jalr	436(ra) # 8000ec6c <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000dac0:	00c00513          	li	a0,12
    8000dac4:	00000097          	auipc	ra,0x0
    8000dac8:	ed0080e7          	jalr	-304(ra) # 8000d994 <_Z9fibonaccim>
    8000dacc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000dad0:	00002517          	auipc	a0,0x2
    8000dad4:	59850513          	addi	a0,a0,1432 # 80010068 <userDataStart+0x68>
    8000dad8:	00001097          	auipc	ra,0x1
    8000dadc:	194080e7          	jalr	404(ra) # 8000ec6c <_Z11printStringPKc>
    8000dae0:	00000613          	li	a2,0
    8000dae4:	00a00593          	li	a1,10
    8000dae8:	0009051b          	sext.w	a0,s2
    8000daec:	00001097          	auipc	ra,0x1
    8000daf0:	318080e7          	jalr	792(ra) # 8000ee04 <_Z8printIntiii>
    8000daf4:	00002517          	auipc	a0,0x2
    8000daf8:	65450513          	addi	a0,a0,1620 # 80010148 <userDataStart+0x148>
    8000dafc:	00001097          	auipc	ra,0x1
    8000db00:	170080e7          	jalr	368(ra) # 8000ec6c <_Z11printStringPKc>
    8000db04:	0400006f          	j	8000db44 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000db08:	00002517          	auipc	a0,0x2
    8000db0c:	54050513          	addi	a0,a0,1344 # 80010048 <userDataStart+0x48>
    8000db10:	00001097          	auipc	ra,0x1
    8000db14:	15c080e7          	jalr	348(ra) # 8000ec6c <_Z11printStringPKc>
    8000db18:	00000613          	li	a2,0
    8000db1c:	00a00593          	li	a1,10
    8000db20:	00048513          	mv	a0,s1
    8000db24:	00001097          	auipc	ra,0x1
    8000db28:	2e0080e7          	jalr	736(ra) # 8000ee04 <_Z8printIntiii>
    8000db2c:	00002517          	auipc	a0,0x2
    8000db30:	61c50513          	addi	a0,a0,1564 # 80010148 <userDataStart+0x148>
    8000db34:	00001097          	auipc	ra,0x1
    8000db38:	138080e7          	jalr	312(ra) # 8000ec6c <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000db3c:	0014849b          	addiw	s1,s1,1
    8000db40:	0ff4f493          	andi	s1,s1,255
    8000db44:	00500793          	li	a5,5
    8000db48:	fc97f0e3          	bgeu	a5,s1,8000db08 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    8000db4c:	00002517          	auipc	a0,0x2
    8000db50:	4d450513          	addi	a0,a0,1236 # 80010020 <userDataStart+0x20>
    8000db54:	00001097          	auipc	ra,0x1
    8000db58:	118080e7          	jalr	280(ra) # 8000ec6c <_Z11printStringPKc>
    finishedC = true;
    8000db5c:	00100793          	li	a5,1
    8000db60:	00003717          	auipc	a4,0x3
    8000db64:	80f70c23          	sb	a5,-2024(a4) # 80010378 <finishedC>
    thread_dispatch();
    8000db68:	fffff097          	auipc	ra,0xfffff
    8000db6c:	5c8080e7          	jalr	1480(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000db70:	01813083          	ld	ra,24(sp)
    8000db74:	01013403          	ld	s0,16(sp)
    8000db78:	00813483          	ld	s1,8(sp)
    8000db7c:	00013903          	ld	s2,0(sp)
    8000db80:	02010113          	addi	sp,sp,32
    8000db84:	00008067          	ret

000000008000db88 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    8000db88:	fe010113          	addi	sp,sp,-32
    8000db8c:	00113c23          	sd	ra,24(sp)
    8000db90:	00813823          	sd	s0,16(sp)
    8000db94:	00913423          	sd	s1,8(sp)
    8000db98:	01213023          	sd	s2,0(sp)
    8000db9c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000dba0:	00a00493          	li	s1,10
    8000dba4:	0400006f          	j	8000dbe4 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000dba8:	00002517          	auipc	a0,0x2
    8000dbac:	4d050513          	addi	a0,a0,1232 # 80010078 <userDataStart+0x78>
    8000dbb0:	00001097          	auipc	ra,0x1
    8000dbb4:	0bc080e7          	jalr	188(ra) # 8000ec6c <_Z11printStringPKc>
    8000dbb8:	00000613          	li	a2,0
    8000dbbc:	00a00593          	li	a1,10
    8000dbc0:	00048513          	mv	a0,s1
    8000dbc4:	00001097          	auipc	ra,0x1
    8000dbc8:	240080e7          	jalr	576(ra) # 8000ee04 <_Z8printIntiii>
    8000dbcc:	00002517          	auipc	a0,0x2
    8000dbd0:	57c50513          	addi	a0,a0,1404 # 80010148 <userDataStart+0x148>
    8000dbd4:	00001097          	auipc	ra,0x1
    8000dbd8:	098080e7          	jalr	152(ra) # 8000ec6c <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000dbdc:	0014849b          	addiw	s1,s1,1
    8000dbe0:	0ff4f493          	andi	s1,s1,255
    8000dbe4:	00c00793          	li	a5,12
    8000dbe8:	fc97f0e3          	bgeu	a5,s1,8000dba8 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000dbec:	00002517          	auipc	a0,0x2
    8000dbf0:	49450513          	addi	a0,a0,1172 # 80010080 <userDataStart+0x80>
    8000dbf4:	00001097          	auipc	ra,0x1
    8000dbf8:	078080e7          	jalr	120(ra) # 8000ec6c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000dbfc:	00500313          	li	t1,5
    thread_dispatch();
    8000dc00:	fffff097          	auipc	ra,0xfffff
    8000dc04:	530080e7          	jalr	1328(ra) # 8000d130 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000dc08:	01000513          	li	a0,16
    8000dc0c:	00000097          	auipc	ra,0x0
    8000dc10:	d88080e7          	jalr	-632(ra) # 8000d994 <_Z9fibonaccim>
    8000dc14:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000dc18:	00002517          	auipc	a0,0x2
    8000dc1c:	47850513          	addi	a0,a0,1144 # 80010090 <userDataStart+0x90>
    8000dc20:	00001097          	auipc	ra,0x1
    8000dc24:	04c080e7          	jalr	76(ra) # 8000ec6c <_Z11printStringPKc>
    8000dc28:	00000613          	li	a2,0
    8000dc2c:	00a00593          	li	a1,10
    8000dc30:	0009051b          	sext.w	a0,s2
    8000dc34:	00001097          	auipc	ra,0x1
    8000dc38:	1d0080e7          	jalr	464(ra) # 8000ee04 <_Z8printIntiii>
    8000dc3c:	00002517          	auipc	a0,0x2
    8000dc40:	50c50513          	addi	a0,a0,1292 # 80010148 <userDataStart+0x148>
    8000dc44:	00001097          	auipc	ra,0x1
    8000dc48:	028080e7          	jalr	40(ra) # 8000ec6c <_Z11printStringPKc>
    8000dc4c:	0400006f          	j	8000dc8c <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000dc50:	00002517          	auipc	a0,0x2
    8000dc54:	42850513          	addi	a0,a0,1064 # 80010078 <userDataStart+0x78>
    8000dc58:	00001097          	auipc	ra,0x1
    8000dc5c:	014080e7          	jalr	20(ra) # 8000ec6c <_Z11printStringPKc>
    8000dc60:	00000613          	li	a2,0
    8000dc64:	00a00593          	li	a1,10
    8000dc68:	00048513          	mv	a0,s1
    8000dc6c:	00001097          	auipc	ra,0x1
    8000dc70:	198080e7          	jalr	408(ra) # 8000ee04 <_Z8printIntiii>
    8000dc74:	00002517          	auipc	a0,0x2
    8000dc78:	4d450513          	addi	a0,a0,1236 # 80010148 <userDataStart+0x148>
    8000dc7c:	00001097          	auipc	ra,0x1
    8000dc80:	ff0080e7          	jalr	-16(ra) # 8000ec6c <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000dc84:	0014849b          	addiw	s1,s1,1
    8000dc88:	0ff4f493          	andi	s1,s1,255
    8000dc8c:	00f00793          	li	a5,15
    8000dc90:	fc97f0e3          	bgeu	a5,s1,8000dc50 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000dc94:	00002517          	auipc	a0,0x2
    8000dc98:	40c50513          	addi	a0,a0,1036 # 800100a0 <userDataStart+0xa0>
    8000dc9c:	00001097          	auipc	ra,0x1
    8000dca0:	fd0080e7          	jalr	-48(ra) # 8000ec6c <_Z11printStringPKc>
    finishedD = true;
    8000dca4:	00100793          	li	a5,1
    8000dca8:	00002717          	auipc	a4,0x2
    8000dcac:	6cf708a3          	sb	a5,1745(a4) # 80010379 <finishedD>
    thread_dispatch();
    8000dcb0:	fffff097          	auipc	ra,0xfffff
    8000dcb4:	480080e7          	jalr	1152(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000dcb8:	01813083          	ld	ra,24(sp)
    8000dcbc:	01013403          	ld	s0,16(sp)
    8000dcc0:	00813483          	ld	s1,8(sp)
    8000dcc4:	00013903          	ld	s2,0(sp)
    8000dcc8:	02010113          	addi	sp,sp,32
    8000dccc:	00008067          	ret

000000008000dcd0 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000dcd0:	fc010113          	addi	sp,sp,-64
    8000dcd4:	02113c23          	sd	ra,56(sp)
    8000dcd8:	02813823          	sd	s0,48(sp)
    8000dcdc:	02913423          	sd	s1,40(sp)
    8000dce0:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000dce4:	00000613          	li	a2,0
    8000dce8:	00000597          	auipc	a1,0x0
    8000dcec:	b0c58593          	addi	a1,a1,-1268 # 8000d7f4 <_Z11workerBodyAPv>
    8000dcf0:	fc040513          	addi	a0,s0,-64
    8000dcf4:	fffff097          	auipc	ra,0xfffff
    8000dcf8:	388080e7          	jalr	904(ra) # 8000d07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000dcfc:	00002517          	auipc	a0,0x2
    8000dd00:	3b450513          	addi	a0,a0,948 # 800100b0 <userDataStart+0xb0>
    8000dd04:	00001097          	auipc	ra,0x1
    8000dd08:	f68080e7          	jalr	-152(ra) # 8000ec6c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000dd0c:	00000613          	li	a2,0
    8000dd10:	00000597          	auipc	a1,0x0
    8000dd14:	bb058593          	addi	a1,a1,-1104 # 8000d8c0 <_Z11workerBodyBPv>
    8000dd18:	fc840513          	addi	a0,s0,-56
    8000dd1c:	fffff097          	auipc	ra,0xfffff
    8000dd20:	360080e7          	jalr	864(ra) # 8000d07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    8000dd24:	00002517          	auipc	a0,0x2
    8000dd28:	3a450513          	addi	a0,a0,932 # 800100c8 <userDataStart+0xc8>
    8000dd2c:	00001097          	auipc	ra,0x1
    8000dd30:	f40080e7          	jalr	-192(ra) # 8000ec6c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000dd34:	00000613          	li	a2,0
    8000dd38:	00000597          	auipc	a1,0x0
    8000dd3c:	cd058593          	addi	a1,a1,-816 # 8000da08 <_Z11workerBodyCPv>
    8000dd40:	fd040513          	addi	a0,s0,-48
    8000dd44:	fffff097          	auipc	ra,0xfffff
    8000dd48:	338080e7          	jalr	824(ra) # 8000d07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    8000dd4c:	00002517          	auipc	a0,0x2
    8000dd50:	39450513          	addi	a0,a0,916 # 800100e0 <userDataStart+0xe0>
    8000dd54:	00001097          	auipc	ra,0x1
    8000dd58:	f18080e7          	jalr	-232(ra) # 8000ec6c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000dd5c:	00000613          	li	a2,0
    8000dd60:	00000597          	auipc	a1,0x0
    8000dd64:	e2858593          	addi	a1,a1,-472 # 8000db88 <_Z11workerBodyDPv>
    8000dd68:	fd840513          	addi	a0,s0,-40
    8000dd6c:	fffff097          	auipc	ra,0xfffff
    8000dd70:	310080e7          	jalr	784(ra) # 8000d07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    8000dd74:	00002517          	auipc	a0,0x2
    8000dd78:	38450513          	addi	a0,a0,900 # 800100f8 <userDataStart+0xf8>
    8000dd7c:	00001097          	auipc	ra,0x1
    8000dd80:	ef0080e7          	jalr	-272(ra) # 8000ec6c <_Z11printStringPKc>
    8000dd84:	00c0006f          	j	8000dd90 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000dd88:	fffff097          	auipc	ra,0xfffff
    8000dd8c:	3a8080e7          	jalr	936(ra) # 8000d130 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000dd90:	00002797          	auipc	a5,0x2
    8000dd94:	5e07c783          	lbu	a5,1504(a5) # 80010370 <finishedA>
    8000dd98:	fe0788e3          	beqz	a5,8000dd88 <_Z18Threads_C_API_testv+0xb8>
    8000dd9c:	00002797          	auipc	a5,0x2
    8000dda0:	5d57c783          	lbu	a5,1493(a5) # 80010371 <finishedB>
    8000dda4:	fe0782e3          	beqz	a5,8000dd88 <_Z18Threads_C_API_testv+0xb8>
    8000dda8:	00002797          	auipc	a5,0x2
    8000ddac:	5d07c783          	lbu	a5,1488(a5) # 80010378 <finishedC>
    8000ddb0:	fc078ce3          	beqz	a5,8000dd88 <_Z18Threads_C_API_testv+0xb8>
    8000ddb4:	00002797          	auipc	a5,0x2
    8000ddb8:	5c57c783          	lbu	a5,1477(a5) # 80010379 <finishedD>
    8000ddbc:	fc0786e3          	beqz	a5,8000dd88 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    8000ddc0:	fc040493          	addi	s1,s0,-64
    8000ddc4:	0080006f          	j	8000ddcc <_Z18Threads_C_API_testv+0xfc>
    8000ddc8:	00848493          	addi	s1,s1,8
    8000ddcc:	fe040793          	addi	a5,s0,-32
    8000ddd0:	00f48c63          	beq	s1,a5,8000dde8 <_Z18Threads_C_API_testv+0x118>
    8000ddd4:	0004b503          	ld	a0,0(s1)
    8000ddd8:	fe0508e3          	beqz	a0,8000ddc8 <_Z18Threads_C_API_testv+0xf8>
    8000dddc:	fffff097          	auipc	ra,0xfffff
    8000dde0:	5e8080e7          	jalr	1512(ra) # 8000d3c4 <_ZN7_threaddlEPv>
    8000dde4:	fe5ff06f          	j	8000ddc8 <_Z18Threads_C_API_testv+0xf8>
}
    8000dde8:	03813083          	ld	ra,56(sp)
    8000ddec:	03013403          	ld	s0,48(sp)
    8000ddf0:	02813483          	ld	s1,40(sp)
    8000ddf4:	04010113          	addi	sp,sp,64
    8000ddf8:	00008067          	ret

000000008000ddfc <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    8000ddfc:	f8010113          	addi	sp,sp,-128
    8000de00:	06113c23          	sd	ra,120(sp)
    8000de04:	06813823          	sd	s0,112(sp)
    8000de08:	06913423          	sd	s1,104(sp)
    8000de0c:	07213023          	sd	s2,96(sp)
    8000de10:	05313c23          	sd	s3,88(sp)
    8000de14:	05413823          	sd	s4,80(sp)
    8000de18:	05513423          	sd	s5,72(sp)
    8000de1c:	05613023          	sd	s6,64(sp)
    8000de20:	03713c23          	sd	s7,56(sp)
    8000de24:	03813823          	sd	s8,48(sp)
    8000de28:	03913423          	sd	s9,40(sp)
    8000de2c:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    8000de30:	00010b93          	mv	s7,sp
        printString("Unesite broj proizvodjaca?\n");
    8000de34:	00002517          	auipc	a0,0x2
    8000de38:	2dc50513          	addi	a0,a0,732 # 80010110 <userDataStart+0x110>
    8000de3c:	00001097          	auipc	ra,0x1
    8000de40:	e30080e7          	jalr	-464(ra) # 8000ec6c <_Z11printStringPKc>
        getString(input, 30);
    8000de44:	01e00593          	li	a1,30
    8000de48:	f8040493          	addi	s1,s0,-128
    8000de4c:	00048513          	mv	a0,s1
    8000de50:	00001097          	auipc	ra,0x1
    8000de54:	e98080e7          	jalr	-360(ra) # 8000ece8 <_Z9getStringPci>
        threadNum = stringToInt(input);
    8000de58:	00048513          	mv	a0,s1
    8000de5c:	00001097          	auipc	ra,0x1
    8000de60:	f58080e7          	jalr	-168(ra) # 8000edb4 <_Z11stringToIntPKc>
    8000de64:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    8000de68:	00002517          	auipc	a0,0x2
    8000de6c:	2c850513          	addi	a0,a0,712 # 80010130 <userDataStart+0x130>
    8000de70:	00001097          	auipc	ra,0x1
    8000de74:	dfc080e7          	jalr	-516(ra) # 8000ec6c <_Z11printStringPKc>
        getString(input, 30);
    8000de78:	01e00593          	li	a1,30
    8000de7c:	00048513          	mv	a0,s1
    8000de80:	00001097          	auipc	ra,0x1
    8000de84:	e68080e7          	jalr	-408(ra) # 8000ece8 <_Z9getStringPci>
        n = stringToInt(input);
    8000de88:	00048513          	mv	a0,s1
    8000de8c:	00001097          	auipc	ra,0x1
    8000de90:	f28080e7          	jalr	-216(ra) # 8000edb4 <_Z11stringToIntPKc>
    8000de94:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    8000de98:	00002517          	auipc	a0,0x2
    8000de9c:	2b850513          	addi	a0,a0,696 # 80010150 <userDataStart+0x150>
    8000dea0:	00001097          	auipc	ra,0x1
    8000dea4:	dcc080e7          	jalr	-564(ra) # 8000ec6c <_Z11printStringPKc>
    8000dea8:	00000613          	li	a2,0
    8000deac:	00a00593          	li	a1,10
    8000deb0:	00090513          	mv	a0,s2
    8000deb4:	00001097          	auipc	ra,0x1
    8000deb8:	f50080e7          	jalr	-176(ra) # 8000ee04 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000debc:	00002517          	auipc	a0,0x2
    8000dec0:	2ac50513          	addi	a0,a0,684 # 80010168 <userDataStart+0x168>
    8000dec4:	00001097          	auipc	ra,0x1
    8000dec8:	da8080e7          	jalr	-600(ra) # 8000ec6c <_Z11printStringPKc>
    8000decc:	00000613          	li	a2,0
    8000ded0:	00a00593          	li	a1,10
    8000ded4:	00048513          	mv	a0,s1
    8000ded8:	00001097          	auipc	ra,0x1
    8000dedc:	f2c080e7          	jalr	-212(ra) # 8000ee04 <_Z8printIntiii>
        printString(".\n");
    8000dee0:	00002517          	auipc	a0,0x2
    8000dee4:	2a050513          	addi	a0,a0,672 # 80010180 <userDataStart+0x180>
    8000dee8:	00001097          	auipc	ra,0x1
    8000deec:	d84080e7          	jalr	-636(ra) # 8000ec6c <_Z11printStringPKc>
        if(threadNum > n) {
    8000def0:	0324c663          	blt	s1,s2,8000df1c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    8000def4:	03205e63          	blez	s2,8000df30 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    8000def8:	03800513          	li	a0,56
    8000defc:	00001097          	auipc	ra,0x1
    8000df00:	11c080e7          	jalr	284(ra) # 8000f018 <_Znwm>
    8000df04:	00050a93          	mv	s5,a0
    8000df08:	04050063          	beqz	a0,8000df48 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
    8000df0c:	00048593          	mv	a1,s1
    8000df10:	fffff097          	auipc	ra,0xfffff
    8000df14:	4dc080e7          	jalr	1244(ra) # 8000d3ec <_ZN9BufferCPPC1Ei>
    8000df18:	0300006f          	j	8000df48 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000df1c:	00002517          	auipc	a0,0x2
    8000df20:	26c50513          	addi	a0,a0,620 # 80010188 <userDataStart+0x188>
    8000df24:	00001097          	auipc	ra,0x1
    8000df28:	d48080e7          	jalr	-696(ra) # 8000ec6c <_Z11printStringPKc>
            return;
    8000df2c:	0140006f          	j	8000df40 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000df30:	00002517          	auipc	a0,0x2
    8000df34:	29850513          	addi	a0,a0,664 # 800101c8 <userDataStart+0x1c8>
    8000df38:	00001097          	auipc	ra,0x1
    8000df3c:	d34080e7          	jalr	-716(ra) # 8000ec6c <_Z11printStringPKc>
            return;
    8000df40:	000b8113          	mv	sp,s7
    8000df44:	24c0006f          	j	8000e190 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    8000df48:	01000513          	li	a0,16
    8000df4c:	00001097          	auipc	ra,0x1
    8000df50:	0cc080e7          	jalr	204(ra) # 8000f018 <_Znwm>
    8000df54:	00050493          	mv	s1,a0
    8000df58:	00050863          	beqz	a0,8000df68 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000df5c:	00000593          	li	a1,0
    8000df60:	00001097          	auipc	ra,0x1
    8000df64:	1b0080e7          	jalr	432(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000df68:	00002717          	auipc	a4,0x2
    8000df6c:	40870713          	addi	a4,a4,1032 # 80010370 <finishedA>
    8000df70:	00973823          	sd	s1,16(a4)
        Thread *producers[threadNum];
    8000df74:	00391793          	slli	a5,s2,0x3
    8000df78:	00f78793          	addi	a5,a5,15
    8000df7c:	ff07f793          	andi	a5,a5,-16
    8000df80:	40f10133          	sub	sp,sp,a5
    8000df84:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    8000df88:	0019069b          	addiw	a3,s2,1
    8000df8c:	00169793          	slli	a5,a3,0x1
    8000df90:	00d787b3          	add	a5,a5,a3
    8000df94:	00379793          	slli	a5,a5,0x3
    8000df98:	00f78793          	addi	a5,a5,15
    8000df9c:	ff07f793          	andi	a5,a5,-16
    8000dfa0:	40f10133          	sub	sp,sp,a5
    8000dfa4:	00010993          	mv	s3,sp
        threadData[threadNum].id = threadNum;
    8000dfa8:	00191793          	slli	a5,s2,0x1
    8000dfac:	012787b3          	add	a5,a5,s2
    8000dfb0:	00379793          	slli	a5,a5,0x3
    8000dfb4:	00f987b3          	add	a5,s3,a5
    8000dfb8:	0127a023          	sw	s2,0(a5)
        threadData[threadNum].buffer = buffer;
    8000dfbc:	0157b423          	sd	s5,8(a5)
        threadData[threadNum].sem = waitForAll;
    8000dfc0:	01073703          	ld	a4,16(a4)
    8000dfc4:	00e7b823          	sd	a4,16(a5)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000dfc8:	01800513          	li	a0,24
    8000dfcc:	00001097          	auipc	ra,0x1
    8000dfd0:	04c080e7          	jalr	76(ra) # 8000f018 <_Znwm>
    8000dfd4:	00050b13          	mv	s6,a0
    8000dfd8:	02050663          	beqz	a0,8000e004 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    8000dfdc:	00191493          	slli	s1,s2,0x1
    8000dfe0:	012484b3          	add	s1,s1,s2
    8000dfe4:	00349493          	slli	s1,s1,0x3
    8000dfe8:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000dfec:	00001097          	auipc	ra,0x1
    8000dff0:	208080e7          	jalr	520(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000dff4:	00002797          	auipc	a5,0x2
    8000dff8:	2ac78793          	addi	a5,a5,684 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000dffc:	00fb3023          	sd	a5,0(s6) # 2000 <_entry-0x7fffe000>
    8000e000:	009b3823          	sd	s1,16(s6)
        consumer->start();
    8000e004:	000b0513          	mv	a0,s6
    8000e008:	00001097          	auipc	ra,0x1
    8000e00c:	2dc080e7          	jalr	732(ra) # 8000f2e4 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    8000e010:	0009a023          	sw	zero,0(s3)
        threadData[0].buffer = buffer;
    8000e014:	0159b423          	sd	s5,8(s3)
        threadData[0].sem = waitForAll;
    8000e018:	00002797          	auipc	a5,0x2
    8000e01c:	3687b783          	ld	a5,872(a5) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e020:	00f9b823          	sd	a5,16(s3)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e024:	01800513          	li	a0,24
    8000e028:	00001097          	auipc	ra,0x1
    8000e02c:	ff0080e7          	jalr	-16(ra) # 8000f018 <_Znwm>
    8000e030:	00050493          	mv	s1,a0
    8000e034:	00050e63          	beqz	a0,8000e050 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    8000e038:	00001097          	auipc	ra,0x1
    8000e03c:	1bc080e7          	jalr	444(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e040:	00002797          	auipc	a5,0x2
    8000e044:	21078793          	addi	a5,a5,528 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e048:	00f4b023          	sd	a5,0(s1)
    8000e04c:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e050:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    8000e054:	00048513          	mv	a0,s1
    8000e058:	00001097          	auipc	ra,0x1
    8000e05c:	28c080e7          	jalr	652(ra) # 8000f2e4 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    8000e060:	00100493          	li	s1,1
    8000e064:	0300006f          	j	8000e094 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x298>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000e068:	00002797          	auipc	a5,0x2
    8000e06c:	21078793          	addi	a5,a5,528 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e070:	00fc3023          	sd	a5,0(s8)
    8000e074:	019c3823          	sd	s9,16(s8)
            producers[i] = new Producer(&threadData[i]);
    8000e078:	00349793          	slli	a5,s1,0x3
    8000e07c:	00fa07b3          	add	a5,s4,a5
    8000e080:	0187b023          	sd	s8,0(a5)
            producers[i]->start();
    8000e084:	000c0513          	mv	a0,s8
    8000e088:	00001097          	auipc	ra,0x1
    8000e08c:	25c080e7          	jalr	604(ra) # 8000f2e4 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    8000e090:	0014849b          	addiw	s1,s1,1
    8000e094:	0524dc63          	bge	s1,s2,8000e0ec <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2f0>
            threadData[i].id = i;
    8000e098:	00149793          	slli	a5,s1,0x1
    8000e09c:	009787b3          	add	a5,a5,s1
    8000e0a0:	00379793          	slli	a5,a5,0x3
    8000e0a4:	00f987b3          	add	a5,s3,a5
    8000e0a8:	0097a023          	sw	s1,0(a5)
            threadData[i].buffer = buffer;
    8000e0ac:	0157b423          	sd	s5,8(a5)
            threadData[i].sem = waitForAll;
    8000e0b0:	00002717          	auipc	a4,0x2
    8000e0b4:	2d073703          	ld	a4,720(a4) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e0b8:	00e7b823          	sd	a4,16(a5)
            producers[i] = new Producer(&threadData[i]);
    8000e0bc:	01800513          	li	a0,24
    8000e0c0:	00001097          	auipc	ra,0x1
    8000e0c4:	f58080e7          	jalr	-168(ra) # 8000f018 <_Znwm>
    8000e0c8:	00050c13          	mv	s8,a0
    8000e0cc:	fa0506e3          	beqz	a0,8000e078 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    8000e0d0:	00149c93          	slli	s9,s1,0x1
    8000e0d4:	009c8cb3          	add	s9,s9,s1
    8000e0d8:	003c9c93          	slli	s9,s9,0x3
    8000e0dc:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000e0e0:	00001097          	auipc	ra,0x1
    8000e0e4:	114080e7          	jalr	276(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e0e8:	f81ff06f          	j	8000e068 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    8000e0ec:	00001097          	auipc	ra,0x1
    8000e0f0:	1d0080e7          	jalr	464(ra) # 8000f2bc <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000e0f4:	00000493          	li	s1,0
    8000e0f8:	00994e63          	blt	s2,s1,8000e114 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    8000e0fc:	00002517          	auipc	a0,0x2
    8000e100:	28453503          	ld	a0,644(a0) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e104:	00001097          	auipc	ra,0x1
    8000e108:	044080e7          	jalr	68(ra) # 8000f148 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    8000e10c:	0014849b          	addiw	s1,s1,1
    8000e110:	fe9ff06f          	j	8000e0f8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
        delete waitForAll;
    8000e114:	00002517          	auipc	a0,0x2
    8000e118:	26c53503          	ld	a0,620(a0) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e11c:	00050863          	beqz	a0,8000e12c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x330>
    8000e120:	00053783          	ld	a5,0(a0)
    8000e124:	0087b783          	ld	a5,8(a5)
    8000e128:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    8000e12c:	00000493          	li	s1,0
    8000e130:	0080006f          	j	8000e138 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x33c>
        for (int i = 0; i < threadNum; i++) {
    8000e134:	0014849b          	addiw	s1,s1,1
    8000e138:	0324d263          	bge	s1,s2,8000e15c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
            delete producers[i];
    8000e13c:	00349793          	slli	a5,s1,0x3
    8000e140:	00fa07b3          	add	a5,s4,a5
    8000e144:	0007b503          	ld	a0,0(a5)
    8000e148:	fe0506e3          	beqz	a0,8000e134 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
    8000e14c:	00053783          	ld	a5,0(a0)
    8000e150:	0087b783          	ld	a5,8(a5)
    8000e154:	000780e7          	jalr	a5
    8000e158:	fddff06f          	j	8000e134 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
        delete consumer;
    8000e15c:	000b0a63          	beqz	s6,8000e170 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x374>
    8000e160:	000b3783          	ld	a5,0(s6)
    8000e164:	0087b783          	ld	a5,8(a5)
    8000e168:	000b0513          	mv	a0,s6
    8000e16c:	000780e7          	jalr	a5
        delete buffer;
    8000e170:	000a8e63          	beqz	s5,8000e18c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x390>
    8000e174:	000a8513          	mv	a0,s5
    8000e178:	fffff097          	auipc	ra,0xfffff
    8000e17c:	57c080e7          	jalr	1404(ra) # 8000d6f4 <_ZN9BufferCPPD1Ev>
    8000e180:	000a8513          	mv	a0,s5
    8000e184:	00001097          	auipc	ra,0x1
    8000e188:	ee4080e7          	jalr	-284(ra) # 8000f068 <_ZdlPv>
    8000e18c:	000b8113          	mv	sp,s7
    }
    8000e190:	f8040113          	addi	sp,s0,-128
    8000e194:	07813083          	ld	ra,120(sp)
    8000e198:	07013403          	ld	s0,112(sp)
    8000e19c:	06813483          	ld	s1,104(sp)
    8000e1a0:	06013903          	ld	s2,96(sp)
    8000e1a4:	05813983          	ld	s3,88(sp)
    8000e1a8:	05013a03          	ld	s4,80(sp)
    8000e1ac:	04813a83          	ld	s5,72(sp)
    8000e1b0:	04013b03          	ld	s6,64(sp)
    8000e1b4:	03813b83          	ld	s7,56(sp)
    8000e1b8:	03013c03          	ld	s8,48(sp)
    8000e1bc:	02813c83          	ld	s9,40(sp)
    8000e1c0:	08010113          	addi	sp,sp,128
    8000e1c4:	00008067          	ret
    8000e1c8:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    8000e1cc:	000a8513          	mv	a0,s5
    8000e1d0:	00001097          	auipc	ra,0x1
    8000e1d4:	e98080e7          	jalr	-360(ra) # 8000f068 <_ZdlPv>
    8000e1d8:	00048513          	mv	a0,s1
    8000e1dc:	ffffe097          	auipc	ra,0xffffe
    8000e1e0:	15c080e7          	jalr	348(ra) # 8000c338 <_Unwind_Resume>
    8000e1e4:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    8000e1e8:	00048513          	mv	a0,s1
    8000e1ec:	00001097          	auipc	ra,0x1
    8000e1f0:	e7c080e7          	jalr	-388(ra) # 8000f068 <_ZdlPv>
    8000e1f4:	00090513          	mv	a0,s2
    8000e1f8:	ffffe097          	auipc	ra,0xffffe
    8000e1fc:	140080e7          	jalr	320(ra) # 8000c338 <_Unwind_Resume>
    8000e200:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000e204:	000b0513          	mv	a0,s6
    8000e208:	00001097          	auipc	ra,0x1
    8000e20c:	e60080e7          	jalr	-416(ra) # 8000f068 <_ZdlPv>
    8000e210:	00048513          	mv	a0,s1
    8000e214:	ffffe097          	auipc	ra,0xffffe
    8000e218:	124080e7          	jalr	292(ra) # 8000c338 <_Unwind_Resume>
    8000e21c:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e220:	00048513          	mv	a0,s1
    8000e224:	00001097          	auipc	ra,0x1
    8000e228:	e44080e7          	jalr	-444(ra) # 8000f068 <_ZdlPv>
    8000e22c:	00090513          	mv	a0,s2
    8000e230:	ffffe097          	auipc	ra,0xffffe
    8000e234:	108080e7          	jalr	264(ra) # 8000c338 <_Unwind_Resume>
    8000e238:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000e23c:	000c0513          	mv	a0,s8
    8000e240:	00001097          	auipc	ra,0x1
    8000e244:	e28080e7          	jalr	-472(ra) # 8000f068 <_ZdlPv>
    8000e248:	00048513          	mv	a0,s1
    8000e24c:	ffffe097          	auipc	ra,0xffffe
    8000e250:	0ec080e7          	jalr	236(ra) # 8000c338 <_Unwind_Resume>

000000008000e254 <_Z8testUserv>:
    long id;
    bool finished;
};


void testUser() {
    8000e254:	fc010113          	addi	sp,sp,-64
    8000e258:	02113c23          	sd	ra,56(sp)
    8000e25c:	02813823          	sd	s0,48(sp)
    8000e260:	02913423          	sd	s1,40(sp)
    8000e264:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e268:	fc040493          	addi	s1,s0,-64
    8000e26c:	00048513          	mv	a0,s1
    8000e270:	00001097          	auipc	ra,0x1
    8000e274:	f84080e7          	jalr	-124(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e278:	00002797          	auipc	a5,0x2
    8000e27c:	05078793          	addi	a5,a5,80 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e280:	fcf43023          	sd	a5,-64(s0)
    8000e284:	00100793          	li	a5,1
    8000e288:	fcf43823          	sd	a5,-48(s0)
    8000e28c:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    8000e290:	00048513          	mv	a0,s1
    8000e294:	00001097          	auipc	ra,0x1
    8000e298:	050080e7          	jalr	80(ra) # 8000f2e4 <_ZN6Thread5startEv>
        return finished;
    8000e29c:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    8000e2a0:	00079863          	bnez	a5,8000e2b0 <_Z8testUserv+0x5c>
        thread_dispatch();
    8000e2a4:	fffff097          	auipc	ra,0xfffff
    8000e2a8:	e8c080e7          	jalr	-372(ra) # 8000d130 <_Z15thread_dispatchv>
    8000e2ac:	ff1ff06f          	j	8000e29c <_Z8testUserv+0x48>
    }

//    ConsoleUtil::printString("User main finished\n");
    printString("User main finished\n");
    8000e2b0:	00002517          	auipc	a0,0x2
    8000e2b4:	f4850513          	addi	a0,a0,-184 # 800101f8 <userDataStart+0x1f8>
    8000e2b8:	00001097          	auipc	ra,0x1
    8000e2bc:	9b4080e7          	jalr	-1612(ra) # 8000ec6c <_Z11printStringPKc>
class ForkThread : public Thread {
    8000e2c0:	00002797          	auipc	a5,0x2
    8000e2c4:	00878793          	addi	a5,a5,8 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e2c8:	fcf43023          	sd	a5,-64(s0)
    8000e2cc:	fc040513          	addi	a0,s0,-64
    8000e2d0:	00001097          	auipc	ra,0x1
    8000e2d4:	d08080e7          	jalr	-760(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e2d8:	03813083          	ld	ra,56(sp)
    8000e2dc:	03013403          	ld	s0,48(sp)
    8000e2e0:	02813483          	ld	s1,40(sp)
    8000e2e4:	04010113          	addi	sp,sp,64
    8000e2e8:	00008067          	ret
    8000e2ec:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    8000e2f0:	00002797          	auipc	a5,0x2
    8000e2f4:	fd878793          	addi	a5,a5,-40 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e2f8:	fcf43023          	sd	a5,-64(s0)
    8000e2fc:	fc040513          	addi	a0,s0,-64
    8000e300:	00001097          	auipc	ra,0x1
    8000e304:	cd8080e7          	jalr	-808(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e308:	00048513          	mv	a0,s1
    8000e30c:	ffffe097          	auipc	ra,0xffffe
    8000e310:	02c080e7          	jalr	44(ra) # 8000c338 <_Unwind_Resume>

000000008000e314 <_Z8userMainv>:

//#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta
#include "testUser.hpp"

void userMain() {
    8000e314:	ff010113          	addi	sp,sp,-16
    8000e318:	00113423          	sd	ra,8(sp)
    8000e31c:	00813023          	sd	s0,0(sp)
    8000e320:	01010413          	addi	s0,sp,16

//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    8000e324:	00000097          	auipc	ra,0x0
    8000e328:	ad8080e7          	jalr	-1320(ra) # 8000ddfc <_ZN19ConsumerProducerCPP20testConsumerProducerEv>
    testUser();
    8000e32c:	00000097          	auipc	ra,0x0
    8000e330:	f28080e7          	jalr	-216(ra) # 8000e254 <_Z8testUserv>
    8000e334:	00813083          	ld	ra,8(sp)
    8000e338:	00013403          	ld	s0,0(sp)
    8000e33c:	01010113          	addi	sp,sp,16
    8000e340:	00008067          	ret

000000008000e344 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    8000e344:	fd010113          	addi	sp,sp,-48
    8000e348:	02113423          	sd	ra,40(sp)
    8000e34c:	02813023          	sd	s0,32(sp)
    8000e350:	00913c23          	sd	s1,24(sp)
    8000e354:	01213823          	sd	s2,16(sp)
    8000e358:	01313423          	sd	s3,8(sp)
    8000e35c:	03010413          	addi	s0,sp,48
    8000e360:	00050913          	mv	s2,a0
            int i = 0;
    8000e364:	00000993          	li	s3,0
    8000e368:	0100006f          	j	8000e378 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    8000e36c:	00a00513          	li	a0,10
    8000e370:	00001097          	auipc	ra,0x1
    8000e374:	03c080e7          	jalr	60(ra) # 8000f3ac <_ZN7Console4putcEc>
            while (!threadEnd) {
    8000e378:	00002797          	auipc	a5,0x2
    8000e37c:	ffc7a783          	lw	a5,-4(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e380:	04079a63          	bnez	a5,8000e3d4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    8000e384:	01093783          	ld	a5,16(s2)
    8000e388:	0087b503          	ld	a0,8(a5)
    8000e38c:	fffff097          	auipc	ra,0xfffff
    8000e390:	254080e7          	jalr	596(ra) # 8000d5e0 <_ZN9BufferCPP3getEv>
                i++;
    8000e394:	0019849b          	addiw	s1,s3,1
    8000e398:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    8000e39c:	0ff57513          	andi	a0,a0,255
    8000e3a0:	00001097          	auipc	ra,0x1
    8000e3a4:	00c080e7          	jalr	12(ra) # 8000f3ac <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    8000e3a8:	05000793          	li	a5,80
    8000e3ac:	02f4e4bb          	remw	s1,s1,a5
    8000e3b0:	fc0494e3          	bnez	s1,8000e378 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    8000e3b4:	fb9ff06f          	j	8000e36c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    8000e3b8:	01093783          	ld	a5,16(s2)
    8000e3bc:	0087b503          	ld	a0,8(a5)
    8000e3c0:	fffff097          	auipc	ra,0xfffff
    8000e3c4:	220080e7          	jalr	544(ra) # 8000d5e0 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    8000e3c8:	0ff57513          	andi	a0,a0,255
    8000e3cc:	00001097          	auipc	ra,0x1
    8000e3d0:	fe0080e7          	jalr	-32(ra) # 8000f3ac <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    8000e3d4:	01093783          	ld	a5,16(s2)
    8000e3d8:	0087b503          	ld	a0,8(a5)
    8000e3dc:	fffff097          	auipc	ra,0xfffff
    8000e3e0:	290080e7          	jalr	656(ra) # 8000d66c <_ZN9BufferCPP6getCntEv>
    8000e3e4:	fca04ae3          	bgtz	a0,8000e3b8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    8000e3e8:	01093783          	ld	a5,16(s2)
    8000e3ec:	0107b503          	ld	a0,16(a5)
    8000e3f0:	00001097          	auipc	ra,0x1
    8000e3f4:	d84080e7          	jalr	-636(ra) # 8000f174 <_ZN9Semaphore6signalEv>
        }
    8000e3f8:	02813083          	ld	ra,40(sp)
    8000e3fc:	02013403          	ld	s0,32(sp)
    8000e400:	01813483          	ld	s1,24(sp)
    8000e404:	01013903          	ld	s2,16(sp)
    8000e408:	00813983          	ld	s3,8(sp)
    8000e40c:	03010113          	addi	sp,sp,48
    8000e410:	00008067          	ret

000000008000e414 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    8000e414:	ff010113          	addi	sp,sp,-16
    8000e418:	00113423          	sd	ra,8(sp)
    8000e41c:	00813023          	sd	s0,0(sp)
    8000e420:	01010413          	addi	s0,sp,16
    8000e424:	00002797          	auipc	a5,0x2
    8000e428:	e7c78793          	addi	a5,a5,-388 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e42c:	00f53023          	sd	a5,0(a0)
    8000e430:	00001097          	auipc	ra,0x1
    8000e434:	ba8080e7          	jalr	-1112(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e438:	00813083          	ld	ra,8(sp)
    8000e43c:	00013403          	ld	s0,0(sp)
    8000e440:	01010113          	addi	sp,sp,16
    8000e444:	00008067          	ret

000000008000e448 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    8000e448:	fe010113          	addi	sp,sp,-32
    8000e44c:	00113c23          	sd	ra,24(sp)
    8000e450:	00813823          	sd	s0,16(sp)
    8000e454:	00913423          	sd	s1,8(sp)
    8000e458:	02010413          	addi	s0,sp,32
    8000e45c:	00050493          	mv	s1,a0
    8000e460:	00002797          	auipc	a5,0x2
    8000e464:	e4078793          	addi	a5,a5,-448 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e468:	00f53023          	sd	a5,0(a0)
    8000e46c:	00001097          	auipc	ra,0x1
    8000e470:	b6c080e7          	jalr	-1172(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e474:	00048513          	mv	a0,s1
    8000e478:	00001097          	auipc	ra,0x1
    8000e47c:	bf0080e7          	jalr	-1040(ra) # 8000f068 <_ZdlPv>
    8000e480:	01813083          	ld	ra,24(sp)
    8000e484:	01013403          	ld	s0,16(sp)
    8000e488:	00813483          	ld	s1,8(sp)
    8000e48c:	02010113          	addi	sp,sp,32
    8000e490:	00008067          	ret

000000008000e494 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    8000e494:	ff010113          	addi	sp,sp,-16
    8000e498:	00113423          	sd	ra,8(sp)
    8000e49c:	00813023          	sd	s0,0(sp)
    8000e4a0:	01010413          	addi	s0,sp,16
    8000e4a4:	00002797          	auipc	a5,0x2
    8000e4a8:	dac78793          	addi	a5,a5,-596 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e4ac:	00f53023          	sd	a5,0(a0)
    8000e4b0:	00001097          	auipc	ra,0x1
    8000e4b4:	b28080e7          	jalr	-1240(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e4b8:	00813083          	ld	ra,8(sp)
    8000e4bc:	00013403          	ld	s0,0(sp)
    8000e4c0:	01010113          	addi	sp,sp,16
    8000e4c4:	00008067          	ret

000000008000e4c8 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    8000e4c8:	fe010113          	addi	sp,sp,-32
    8000e4cc:	00113c23          	sd	ra,24(sp)
    8000e4d0:	00813823          	sd	s0,16(sp)
    8000e4d4:	00913423          	sd	s1,8(sp)
    8000e4d8:	02010413          	addi	s0,sp,32
    8000e4dc:	00050493          	mv	s1,a0
    8000e4e0:	00002797          	auipc	a5,0x2
    8000e4e4:	d7078793          	addi	a5,a5,-656 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e4e8:	00f53023          	sd	a5,0(a0)
    8000e4ec:	00001097          	auipc	ra,0x1
    8000e4f0:	aec080e7          	jalr	-1300(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e4f4:	00048513          	mv	a0,s1
    8000e4f8:	00001097          	auipc	ra,0x1
    8000e4fc:	b70080e7          	jalr	-1168(ra) # 8000f068 <_ZdlPv>
    8000e500:	01813083          	ld	ra,24(sp)
    8000e504:	01013403          	ld	s0,16(sp)
    8000e508:	00813483          	ld	s1,8(sp)
    8000e50c:	02010113          	addi	sp,sp,32
    8000e510:	00008067          	ret

000000008000e514 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    8000e514:	ff010113          	addi	sp,sp,-16
    8000e518:	00113423          	sd	ra,8(sp)
    8000e51c:	00813023          	sd	s0,0(sp)
    8000e520:	01010413          	addi	s0,sp,16
    8000e524:	00002797          	auipc	a5,0x2
    8000e528:	d5478793          	addi	a5,a5,-684 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e52c:	00f53023          	sd	a5,0(a0)
    8000e530:	00001097          	auipc	ra,0x1
    8000e534:	aa8080e7          	jalr	-1368(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e538:	00813083          	ld	ra,8(sp)
    8000e53c:	00013403          	ld	s0,0(sp)
    8000e540:	01010113          	addi	sp,sp,16
    8000e544:	00008067          	ret

000000008000e548 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    8000e548:	fe010113          	addi	sp,sp,-32
    8000e54c:	00113c23          	sd	ra,24(sp)
    8000e550:	00813823          	sd	s0,16(sp)
    8000e554:	00913423          	sd	s1,8(sp)
    8000e558:	02010413          	addi	s0,sp,32
    8000e55c:	00050493          	mv	s1,a0
    8000e560:	00002797          	auipc	a5,0x2
    8000e564:	d1878793          	addi	a5,a5,-744 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e568:	00f53023          	sd	a5,0(a0)
    8000e56c:	00001097          	auipc	ra,0x1
    8000e570:	a6c080e7          	jalr	-1428(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e574:	00048513          	mv	a0,s1
    8000e578:	00001097          	auipc	ra,0x1
    8000e57c:	af0080e7          	jalr	-1296(ra) # 8000f068 <_ZdlPv>
    8000e580:	01813083          	ld	ra,24(sp)
    8000e584:	01013403          	ld	s0,16(sp)
    8000e588:	00813483          	ld	s1,8(sp)
    8000e58c:	02010113          	addi	sp,sp,32
    8000e590:	00008067          	ret

000000008000e594 <_ZN10ForkThreadD1Ev>:
    8000e594:	ff010113          	addi	sp,sp,-16
    8000e598:	00113423          	sd	ra,8(sp)
    8000e59c:	00813023          	sd	s0,0(sp)
    8000e5a0:	01010413          	addi	s0,sp,16
    8000e5a4:	00002797          	auipc	a5,0x2
    8000e5a8:	d2478793          	addi	a5,a5,-732 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e5ac:	00f53023          	sd	a5,0(a0)
    8000e5b0:	00001097          	auipc	ra,0x1
    8000e5b4:	a28080e7          	jalr	-1496(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e5b8:	00813083          	ld	ra,8(sp)
    8000e5bc:	00013403          	ld	s0,0(sp)
    8000e5c0:	01010113          	addi	sp,sp,16
    8000e5c4:	00008067          	ret

000000008000e5c8 <_ZN10ForkThreadD0Ev>:
    8000e5c8:	fe010113          	addi	sp,sp,-32
    8000e5cc:	00113c23          	sd	ra,24(sp)
    8000e5d0:	00813823          	sd	s0,16(sp)
    8000e5d4:	00913423          	sd	s1,8(sp)
    8000e5d8:	02010413          	addi	s0,sp,32
    8000e5dc:	00050493          	mv	s1,a0
    8000e5e0:	00002797          	auipc	a5,0x2
    8000e5e4:	ce878793          	addi	a5,a5,-792 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e5e8:	00f53023          	sd	a5,0(a0)
    8000e5ec:	00001097          	auipc	ra,0x1
    8000e5f0:	9ec080e7          	jalr	-1556(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e5f4:	00048513          	mv	a0,s1
    8000e5f8:	00001097          	auipc	ra,0x1
    8000e5fc:	a70080e7          	jalr	-1424(ra) # 8000f068 <_ZdlPv>
    8000e600:	01813083          	ld	ra,24(sp)
    8000e604:	01013403          	ld	s0,16(sp)
    8000e608:	00813483          	ld	s1,8(sp)
    8000e60c:	02010113          	addi	sp,sp,32
    8000e610:	00008067          	ret

000000008000e614 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    8000e614:	fe010113          	addi	sp,sp,-32
    8000e618:	00113c23          	sd	ra,24(sp)
    8000e61c:	00813823          	sd	s0,16(sp)
    8000e620:	00913423          	sd	s1,8(sp)
    8000e624:	02010413          	addi	s0,sp,32
    8000e628:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    8000e62c:	fffff097          	auipc	ra,0xfffff
    8000e630:	cd8080e7          	jalr	-808(ra) # 8000d304 <_Z4getcv>
    8000e634:	0005059b          	sext.w	a1,a0
    8000e638:	01b00793          	li	a5,27
    8000e63c:	00f58c63          	beq	a1,a5,8000e654 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    8000e640:	0104b783          	ld	a5,16(s1)
    8000e644:	0087b503          	ld	a0,8(a5)
    8000e648:	fffff097          	auipc	ra,0xfffff
    8000e64c:	f08080e7          	jalr	-248(ra) # 8000d550 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    8000e650:	fddff06f          	j	8000e62c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    8000e654:	00100793          	li	a5,1
    8000e658:	00002717          	auipc	a4,0x2
    8000e65c:	d0f72e23          	sw	a5,-740(a4) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    8000e660:	0104b783          	ld	a5,16(s1)
    8000e664:	02100593          	li	a1,33
    8000e668:	0087b503          	ld	a0,8(a5)
    8000e66c:	fffff097          	auipc	ra,0xfffff
    8000e670:	ee4080e7          	jalr	-284(ra) # 8000d550 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    8000e674:	0104b783          	ld	a5,16(s1)
    8000e678:	0107b503          	ld	a0,16(a5)
    8000e67c:	00001097          	auipc	ra,0x1
    8000e680:	af8080e7          	jalr	-1288(ra) # 8000f174 <_ZN9Semaphore6signalEv>
        }
    8000e684:	01813083          	ld	ra,24(sp)
    8000e688:	01013403          	ld	s0,16(sp)
    8000e68c:	00813483          	ld	s1,8(sp)
    8000e690:	02010113          	addi	sp,sp,32
    8000e694:	00008067          	ret

000000008000e698 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    8000e698:	fe010113          	addi	sp,sp,-32
    8000e69c:	00113c23          	sd	ra,24(sp)
    8000e6a0:	00813823          	sd	s0,16(sp)
    8000e6a4:	00913423          	sd	s1,8(sp)
    8000e6a8:	01213023          	sd	s2,0(sp)
    8000e6ac:	02010413          	addi	s0,sp,32
    8000e6b0:	00050493          	mv	s1,a0
            int i = 0;
    8000e6b4:	00000913          	li	s2,0
            while (!threadEnd) {
    8000e6b8:	00002797          	auipc	a5,0x2
    8000e6bc:	cbc7a783          	lw	a5,-836(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e6c0:	04079263          	bnez	a5,8000e704 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8000e6c4:	0104b783          	ld	a5,16(s1)
    8000e6c8:	0007a583          	lw	a1,0(a5)
    8000e6cc:	0305859b          	addiw	a1,a1,48
    8000e6d0:	0087b503          	ld	a0,8(a5)
    8000e6d4:	fffff097          	auipc	ra,0xfffff
    8000e6d8:	e7c080e7          	jalr	-388(ra) # 8000d550 <_ZN9BufferCPP3putEi>
                i++;
    8000e6dc:	0019071b          	addiw	a4,s2,1
    8000e6e0:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    8000e6e4:	0104b783          	ld	a5,16(s1)
    8000e6e8:	0007a783          	lw	a5,0(a5)
    8000e6ec:	00e787bb          	addw	a5,a5,a4
    8000e6f0:	00500513          	li	a0,5
    8000e6f4:	02a7e53b          	remw	a0,a5,a0
    8000e6f8:	00001097          	auipc	ra,0x1
    8000e6fc:	b5c080e7          	jalr	-1188(ra) # 8000f254 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    8000e700:	fb9ff06f          	j	8000e6b8 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    8000e704:	0104b783          	ld	a5,16(s1)
    8000e708:	0107b503          	ld	a0,16(a5)
    8000e70c:	00001097          	auipc	ra,0x1
    8000e710:	a68080e7          	jalr	-1432(ra) # 8000f174 <_ZN9Semaphore6signalEv>
        }
    8000e714:	01813083          	ld	ra,24(sp)
    8000e718:	01013403          	ld	s0,16(sp)
    8000e71c:	00813483          	ld	s1,8(sp)
    8000e720:	00013903          	ld	s2,0(sp)
    8000e724:	02010113          	addi	sp,sp,32
    8000e728:	00008067          	ret

000000008000e72c <_ZN10ForkThread3runEv>:
    virtual void run() {
    8000e72c:	fc010113          	addi	sp,sp,-64
    8000e730:	02113c23          	sd	ra,56(sp)
    8000e734:	02813823          	sd	s0,48(sp)
    8000e738:	02913423          	sd	s1,40(sp)
    8000e73c:	03213023          	sd	s2,32(sp)
    8000e740:	01313c23          	sd	s3,24(sp)
    8000e744:	01413823          	sd	s4,16(sp)
    8000e748:	01513423          	sd	s5,8(sp)
    8000e74c:	01613023          	sd	s6,0(sp)
    8000e750:	04010413          	addi	s0,sp,64
    8000e754:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    8000e758:	00002517          	auipc	a0,0x2
    8000e75c:	ab850513          	addi	a0,a0,-1352 # 80010210 <userDataStart+0x210>
    8000e760:	00000097          	auipc	ra,0x0
    8000e764:	50c080e7          	jalr	1292(ra) # 8000ec6c <_Z11printStringPKc>
        printInt(id,10);
    8000e768:	00000613          	li	a2,0
    8000e76c:	00a00593          	li	a1,10
    8000e770:	010a2503          	lw	a0,16(s4)
    8000e774:	00000097          	auipc	ra,0x0
    8000e778:	690080e7          	jalr	1680(ra) # 8000ee04 <_Z8printIntiii>
        printString("\n");
    8000e77c:	00002517          	auipc	a0,0x2
    8000e780:	9cc50513          	addi	a0,a0,-1588 # 80010148 <userDataStart+0x148>
    8000e784:	00000097          	auipc	ra,0x0
    8000e788:	4e8080e7          	jalr	1256(ra) # 8000ec6c <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    8000e78c:	02000513          	li	a0,32
    8000e790:	00001097          	auipc	ra,0x1
    8000e794:	888080e7          	jalr	-1912(ra) # 8000f018 <_Znwm>
    8000e798:	00050993          	mv	s3,a0
    8000e79c:	02050463          	beqz	a0,8000e7c4 <_ZN10ForkThread3runEv+0x98>
    8000e7a0:	010a3483          	ld	s1,16(s4)
    8000e7a4:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e7a8:	00001097          	auipc	ra,0x1
    8000e7ac:	a4c080e7          	jalr	-1460(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e7b0:	00002797          	auipc	a5,0x2
    8000e7b4:	b1878793          	addi	a5,a5,-1256 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e7b8:	00f9b023          	sd	a5,0(s3)
    8000e7bc:	0099b823          	sd	s1,16(s3)
    8000e7c0:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    8000e7c4:	010a3503          	ld	a0,16(s4)
    8000e7c8:	00351513          	slli	a0,a0,0x3
    8000e7cc:	fffff097          	auipc	ra,0xfffff
    8000e7d0:	854080e7          	jalr	-1964(ra) # 8000d020 <_Z9mem_allocm>
    8000e7d4:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    8000e7d8:	10050863          	beqz	a0,8000e8e8 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    8000e7dc:	00000913          	li	s2,0
    8000e7e0:	0140006f          	j	8000e7f4 <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    8000e7e4:	00391793          	slli	a5,s2,0x3
    8000e7e8:	00fa87b3          	add	a5,s5,a5
    8000e7ec:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    8000e7f0:	00190913          	addi	s2,s2,1
    8000e7f4:	010a3783          	ld	a5,16(s4)
    8000e7f8:	02f95e63          	bge	s2,a5,8000e834 <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    8000e7fc:	02000513          	li	a0,32
    8000e800:	00001097          	auipc	ra,0x1
    8000e804:	818080e7          	jalr	-2024(ra) # 8000f018 <_Znwm>
    8000e808:	00050493          	mv	s1,a0
    8000e80c:	fc050ce3          	beqz	a0,8000e7e4 <_ZN10ForkThread3runEv+0xb8>
    8000e810:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e814:	00001097          	auipc	ra,0x1
    8000e818:	9e0080e7          	jalr	-1568(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e81c:	00002797          	auipc	a5,0x2
    8000e820:	aac78793          	addi	a5,a5,-1364 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e824:	00f4b023          	sd	a5,0(s1)
    8000e828:	0164b823          	sd	s6,16(s1)
    8000e82c:	00048c23          	sb	zero,24(s1)
    8000e830:	fb5ff06f          	j	8000e7e4 <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    8000e834:	06098a63          	beqz	s3,8000e8a8 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    8000e838:	00098513          	mv	a0,s3
    8000e83c:	00001097          	auipc	ra,0x1
    8000e840:	aa8080e7          	jalr	-1368(ra) # 8000f2e4 <_ZN6Thread5startEv>
    8000e844:	00050913          	mv	s2,a0
    8000e848:	04051863          	bnez	a0,8000e898 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    8000e84c:	00050493          	mv	s1,a0
    8000e850:	0100006f          	j	8000e860 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    8000e854:	fffff097          	auipc	ra,0xfffff
    8000e858:	8dc080e7          	jalr	-1828(ra) # 8000d130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    8000e85c:	0014849b          	addiw	s1,s1,1
    8000e860:	000017b7          	lui	a5,0x1
    8000e864:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e868:	0097ce63          	blt	a5,s1,8000e884 <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    8000e86c:	00090713          	mv	a4,s2
    8000e870:	000017b7          	lui	a5,0x1
    8000e874:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e878:	fce7cee3          	blt	a5,a4,8000e854 <_ZN10ForkThread3runEv+0x128>
    8000e87c:	0017071b          	addiw	a4,a4,1
    8000e880:	ff1ff06f          	j	8000e870 <_ZN10ForkThread3runEv+0x144>
        return finished;
    8000e884:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    8000e888:	00079863          	bnez	a5,8000e898 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    8000e88c:	fffff097          	auipc	ra,0xfffff
    8000e890:	8a4080e7          	jalr	-1884(ra) # 8000d130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8000e894:	ff1ff06f          	j	8000e884 <_ZN10ForkThread3runEv+0x158>
                delete thread;
    8000e898:	0009b783          	ld	a5,0(s3)
    8000e89c:	0087b783          	ld	a5,8(a5)
    8000e8a0:	00098513          	mv	a0,s3
    8000e8a4:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    8000e8a8:	00000493          	li	s1,0
    8000e8ac:	0080006f          	j	8000e8b4 <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    8000e8b0:	00148493          	addi	s1,s1,1
    8000e8b4:	010a3783          	ld	a5,16(s4)
    8000e8b8:	02f4d263          	bge	s1,a5,8000e8dc <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    8000e8bc:	00349793          	slli	a5,s1,0x3
    8000e8c0:	00fa87b3          	add	a5,s5,a5
    8000e8c4:	0007b503          	ld	a0,0(a5)
    8000e8c8:	fe0504e3          	beqz	a0,8000e8b0 <_ZN10ForkThread3runEv+0x184>
    8000e8cc:	00053783          	ld	a5,0(a0)
    8000e8d0:	0087b783          	ld	a5,8(a5)
    8000e8d4:	000780e7          	jalr	a5
    8000e8d8:	fd9ff06f          	j	8000e8b0 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    8000e8dc:	000a8513          	mv	a0,s5
    8000e8e0:	ffffe097          	auipc	ra,0xffffe
    8000e8e4:	770080e7          	jalr	1904(ra) # 8000d050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    8000e8e8:	00002517          	auipc	a0,0x2
    8000e8ec:	94050513          	addi	a0,a0,-1728 # 80010228 <userDataStart+0x228>
    8000e8f0:	00000097          	auipc	ra,0x0
    8000e8f4:	37c080e7          	jalr	892(ra) # 8000ec6c <_Z11printStringPKc>
        printInt(id,10);
    8000e8f8:	00000613          	li	a2,0
    8000e8fc:	00a00593          	li	a1,10
    8000e900:	010a2503          	lw	a0,16(s4)
    8000e904:	00000097          	auipc	ra,0x0
    8000e908:	500080e7          	jalr	1280(ra) # 8000ee04 <_Z8printIntiii>
        printString("\n");
    8000e90c:	00002517          	auipc	a0,0x2
    8000e910:	83c50513          	addi	a0,a0,-1988 # 80010148 <userDataStart+0x148>
    8000e914:	00000097          	auipc	ra,0x0
    8000e918:	358080e7          	jalr	856(ra) # 8000ec6c <_Z11printStringPKc>
        finished = true;
    8000e91c:	00100793          	li	a5,1
    8000e920:	00fa0c23          	sb	a5,24(s4)
    }
    8000e924:	03813083          	ld	ra,56(sp)
    8000e928:	03013403          	ld	s0,48(sp)
    8000e92c:	02813483          	ld	s1,40(sp)
    8000e930:	02013903          	ld	s2,32(sp)
    8000e934:	01813983          	ld	s3,24(sp)
    8000e938:	01013a03          	ld	s4,16(sp)
    8000e93c:	00813a83          	ld	s5,8(sp)
    8000e940:	00013b03          	ld	s6,0(sp)
    8000e944:	04010113          	addi	sp,sp,64
    8000e948:	00008067          	ret

000000008000e94c <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000e94c:	fe010113          	addi	sp,sp,-32
    8000e950:	00113c23          	sd	ra,24(sp)
    8000e954:	00813823          	sd	s0,16(sp)
    8000e958:	00913423          	sd	s1,8(sp)
    8000e95c:	01213023          	sd	s2,0(sp)
    8000e960:	02010413          	addi	s0,sp,32
    8000e964:	00050493          	mv	s1,a0
    8000e968:	00058913          	mv	s2,a1
    8000e96c:	0015879b          	addiw	a5,a1,1
    8000e970:	0007851b          	sext.w	a0,a5
    8000e974:	00f4a023          	sw	a5,0(s1)
    8000e978:	0004a823          	sw	zero,16(s1)
    8000e97c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000e980:	00251513          	slli	a0,a0,0x2
    8000e984:	ffffe097          	auipc	ra,0xffffe
    8000e988:	69c080e7          	jalr	1692(ra) # 8000d020 <_Z9mem_allocm>
    8000e98c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000e990:	00000593          	li	a1,0
    8000e994:	02048513          	addi	a0,s1,32
    8000e998:	fffff097          	auipc	ra,0xfffff
    8000e99c:	884080e7          	jalr	-1916(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    8000e9a0:	00090593          	mv	a1,s2
    8000e9a4:	01848513          	addi	a0,s1,24
    8000e9a8:	fffff097          	auipc	ra,0xfffff
    8000e9ac:	874080e7          	jalr	-1932(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    8000e9b0:	00100593          	li	a1,1
    8000e9b4:	02848513          	addi	a0,s1,40
    8000e9b8:	fffff097          	auipc	ra,0xfffff
    8000e9bc:	864080e7          	jalr	-1948(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    8000e9c0:	00100593          	li	a1,1
    8000e9c4:	03048513          	addi	a0,s1,48
    8000e9c8:	fffff097          	auipc	ra,0xfffff
    8000e9cc:	854080e7          	jalr	-1964(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000e9d0:	01813083          	ld	ra,24(sp)
    8000e9d4:	01013403          	ld	s0,16(sp)
    8000e9d8:	00813483          	ld	s1,8(sp)
    8000e9dc:	00013903          	ld	s2,0(sp)
    8000e9e0:	02010113          	addi	sp,sp,32
    8000e9e4:	00008067          	ret

000000008000e9e8 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000e9e8:	fe010113          	addi	sp,sp,-32
    8000e9ec:	00113c23          	sd	ra,24(sp)
    8000e9f0:	00813823          	sd	s0,16(sp)
    8000e9f4:	00913423          	sd	s1,8(sp)
    8000e9f8:	01213023          	sd	s2,0(sp)
    8000e9fc:	02010413          	addi	s0,sp,32
    8000ea00:	00050493          	mv	s1,a0
    8000ea04:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000ea08:	01853503          	ld	a0,24(a0)
    8000ea0c:	fffff097          	auipc	ra,0xfffff
    8000ea10:	874080e7          	jalr	-1932(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    8000ea14:	0304b503          	ld	a0,48(s1)
    8000ea18:	fffff097          	auipc	ra,0xfffff
    8000ea1c:	868080e7          	jalr	-1944(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    8000ea20:	0084b783          	ld	a5,8(s1)
    8000ea24:	0144a703          	lw	a4,20(s1)
    8000ea28:	00271713          	slli	a4,a4,0x2
    8000ea2c:	00e787b3          	add	a5,a5,a4
    8000ea30:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000ea34:	0144a783          	lw	a5,20(s1)
    8000ea38:	0017879b          	addiw	a5,a5,1
    8000ea3c:	0004a703          	lw	a4,0(s1)
    8000ea40:	02e7e7bb          	remw	a5,a5,a4
    8000ea44:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    8000ea48:	0304b503          	ld	a0,48(s1)
    8000ea4c:	fffff097          	auipc	ra,0xfffff
    8000ea50:	860080e7          	jalr	-1952(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    8000ea54:	0204b503          	ld	a0,32(s1)
    8000ea58:	fffff097          	auipc	ra,0xfffff
    8000ea5c:	854080e7          	jalr	-1964(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

}
    8000ea60:	01813083          	ld	ra,24(sp)
    8000ea64:	01013403          	ld	s0,16(sp)
    8000ea68:	00813483          	ld	s1,8(sp)
    8000ea6c:	00013903          	ld	s2,0(sp)
    8000ea70:	02010113          	addi	sp,sp,32
    8000ea74:	00008067          	ret

000000008000ea78 <_ZN6Buffer3getEv>:

int Buffer::get() {
    8000ea78:	fe010113          	addi	sp,sp,-32
    8000ea7c:	00113c23          	sd	ra,24(sp)
    8000ea80:	00813823          	sd	s0,16(sp)
    8000ea84:	00913423          	sd	s1,8(sp)
    8000ea88:	01213023          	sd	s2,0(sp)
    8000ea8c:	02010413          	addi	s0,sp,32
    8000ea90:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8000ea94:	02053503          	ld	a0,32(a0)
    8000ea98:	ffffe097          	auipc	ra,0xffffe
    8000ea9c:	7e8080e7          	jalr	2024(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    8000eaa0:	0284b503          	ld	a0,40(s1)
    8000eaa4:	ffffe097          	auipc	ra,0xffffe
    8000eaa8:	7dc080e7          	jalr	2012(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8000eaac:	0084b703          	ld	a4,8(s1)
    8000eab0:	0104a783          	lw	a5,16(s1)
    8000eab4:	00279693          	slli	a3,a5,0x2
    8000eab8:	00d70733          	add	a4,a4,a3
    8000eabc:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000eac0:	0017879b          	addiw	a5,a5,1
    8000eac4:	0004a703          	lw	a4,0(s1)
    8000eac8:	02e7e7bb          	remw	a5,a5,a4
    8000eacc:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000ead0:	0284b503          	ld	a0,40(s1)
    8000ead4:	ffffe097          	auipc	ra,0xffffe
    8000ead8:	7d8080e7          	jalr	2008(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    8000eadc:	0184b503          	ld	a0,24(s1)
    8000eae0:	ffffe097          	auipc	ra,0xffffe
    8000eae4:	7cc080e7          	jalr	1996(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000eae8:	00090513          	mv	a0,s2
    8000eaec:	01813083          	ld	ra,24(sp)
    8000eaf0:	01013403          	ld	s0,16(sp)
    8000eaf4:	00813483          	ld	s1,8(sp)
    8000eaf8:	00013903          	ld	s2,0(sp)
    8000eafc:	02010113          	addi	sp,sp,32
    8000eb00:	00008067          	ret

000000008000eb04 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000eb04:	fe010113          	addi	sp,sp,-32
    8000eb08:	00113c23          	sd	ra,24(sp)
    8000eb0c:	00813823          	sd	s0,16(sp)
    8000eb10:	00913423          	sd	s1,8(sp)
    8000eb14:	01213023          	sd	s2,0(sp)
    8000eb18:	02010413          	addi	s0,sp,32
    8000eb1c:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    8000eb20:	02853503          	ld	a0,40(a0)
    8000eb24:	ffffe097          	auipc	ra,0xffffe
    8000eb28:	75c080e7          	jalr	1884(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    8000eb2c:	0304b503          	ld	a0,48(s1)
    8000eb30:	ffffe097          	auipc	ra,0xffffe
    8000eb34:	750080e7          	jalr	1872(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    8000eb38:	0144a783          	lw	a5,20(s1)
    8000eb3c:	0104a903          	lw	s2,16(s1)
    8000eb40:	0327ce63          	blt	a5,s2,8000eb7c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000eb44:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    8000eb48:	0304b503          	ld	a0,48(s1)
    8000eb4c:	ffffe097          	auipc	ra,0xffffe
    8000eb50:	760080e7          	jalr	1888(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8000eb54:	0284b503          	ld	a0,40(s1)
    8000eb58:	ffffe097          	auipc	ra,0xffffe
    8000eb5c:	754080e7          	jalr	1876(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000eb60:	00090513          	mv	a0,s2
    8000eb64:	01813083          	ld	ra,24(sp)
    8000eb68:	01013403          	ld	s0,16(sp)
    8000eb6c:	00813483          	ld	s1,8(sp)
    8000eb70:	00013903          	ld	s2,0(sp)
    8000eb74:	02010113          	addi	sp,sp,32
    8000eb78:	00008067          	ret
        ret = cap - head + tail;
    8000eb7c:	0004a703          	lw	a4,0(s1)
    8000eb80:	4127093b          	subw	s2,a4,s2
    8000eb84:	00f9093b          	addw	s2,s2,a5
    8000eb88:	fc1ff06f          	j	8000eb48 <_ZN6Buffer6getCntEv+0x44>

000000008000eb8c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000eb8c:	fe010113          	addi	sp,sp,-32
    8000eb90:	00113c23          	sd	ra,24(sp)
    8000eb94:	00813823          	sd	s0,16(sp)
    8000eb98:	00913423          	sd	s1,8(sp)
    8000eb9c:	02010413          	addi	s0,sp,32
    8000eba0:	00050493          	mv	s1,a0
    putc('\n');
    8000eba4:	00a00513          	li	a0,10
    8000eba8:	ffffe097          	auipc	ra,0xffffe
    8000ebac:	784080e7          	jalr	1924(ra) # 8000d32c <_Z4putcc>
    printString("Buffer deleted!\n");
    8000ebb0:	00001517          	auipc	a0,0x1
    8000ebb4:	45050513          	addi	a0,a0,1104 # 80010000 <userDataStart>
    8000ebb8:	00000097          	auipc	ra,0x0
    8000ebbc:	0b4080e7          	jalr	180(ra) # 8000ec6c <_Z11printStringPKc>
    while (getCnt() > 0) {
    8000ebc0:	00048513          	mv	a0,s1
    8000ebc4:	00000097          	auipc	ra,0x0
    8000ebc8:	f40080e7          	jalr	-192(ra) # 8000eb04 <_ZN6Buffer6getCntEv>
    8000ebcc:	02a05c63          	blez	a0,8000ec04 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    8000ebd0:	0084b783          	ld	a5,8(s1)
    8000ebd4:	0104a703          	lw	a4,16(s1)
    8000ebd8:	00271713          	slli	a4,a4,0x2
    8000ebdc:	00e787b3          	add	a5,a5,a4
        putc(ch);
    8000ebe0:	0007c503          	lbu	a0,0(a5)
    8000ebe4:	ffffe097          	auipc	ra,0xffffe
    8000ebe8:	748080e7          	jalr	1864(ra) # 8000d32c <_Z4putcc>
        head = (head + 1) % cap;
    8000ebec:	0104a783          	lw	a5,16(s1)
    8000ebf0:	0017879b          	addiw	a5,a5,1
    8000ebf4:	0004a703          	lw	a4,0(s1)
    8000ebf8:	02e7e7bb          	remw	a5,a5,a4
    8000ebfc:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    8000ec00:	fc1ff06f          	j	8000ebc0 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000ec04:	02100513          	li	a0,33
    8000ec08:	ffffe097          	auipc	ra,0xffffe
    8000ec0c:	724080e7          	jalr	1828(ra) # 8000d32c <_Z4putcc>
    putc('\n');
    8000ec10:	00a00513          	li	a0,10
    8000ec14:	ffffe097          	auipc	ra,0xffffe
    8000ec18:	718080e7          	jalr	1816(ra) # 8000d32c <_Z4putcc>
    mem_free(buffer);
    8000ec1c:	0084b503          	ld	a0,8(s1)
    8000ec20:	ffffe097          	auipc	ra,0xffffe
    8000ec24:	430080e7          	jalr	1072(ra) # 8000d050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    8000ec28:	0204b503          	ld	a0,32(s1)
    8000ec2c:	ffffe097          	auipc	ra,0xffffe
    8000ec30:	628080e7          	jalr	1576(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    8000ec34:	0184b503          	ld	a0,24(s1)
    8000ec38:	ffffe097          	auipc	ra,0xffffe
    8000ec3c:	61c080e7          	jalr	1564(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    8000ec40:	0304b503          	ld	a0,48(s1)
    8000ec44:	ffffe097          	auipc	ra,0xffffe
    8000ec48:	610080e7          	jalr	1552(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    8000ec4c:	0284b503          	ld	a0,40(s1)
    8000ec50:	ffffe097          	auipc	ra,0xffffe
    8000ec54:	604080e7          	jalr	1540(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
}
    8000ec58:	01813083          	ld	ra,24(sp)
    8000ec5c:	01013403          	ld	s0,16(sp)
    8000ec60:	00813483          	ld	s1,8(sp)
    8000ec64:	02010113          	addi	sp,sp,32
    8000ec68:	00008067          	ret

000000008000ec6c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000ec6c:	fe010113          	addi	sp,sp,-32
    8000ec70:	00113c23          	sd	ra,24(sp)
    8000ec74:	00813823          	sd	s0,16(sp)
    8000ec78:	00913423          	sd	s1,8(sp)
    8000ec7c:	02010413          	addi	s0,sp,32
    8000ec80:	00050493          	mv	s1,a0
    LOCK();
    8000ec84:	00100613          	li	a2,1
    8000ec88:	00000593          	li	a1,0
    8000ec8c:	00001517          	auipc	a0,0x1
    8000ec90:	6fc50513          	addi	a0,a0,1788 # 80010388 <lockPrint>
    8000ec94:	ffffe097          	auipc	ra,0xffffe
    8000ec98:	36c080e7          	jalr	876(ra) # 8000d000 <copy_and_swap>
    8000ec9c:	fe0514e3          	bnez	a0,8000ec84 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000eca0:	0004c503          	lbu	a0,0(s1)
    8000eca4:	00050a63          	beqz	a0,8000ecb8 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000eca8:	ffffe097          	auipc	ra,0xffffe
    8000ecac:	684080e7          	jalr	1668(ra) # 8000d32c <_Z4putcc>
        string++;
    8000ecb0:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000ecb4:	fedff06f          	j	8000eca0 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000ecb8:	00000613          	li	a2,0
    8000ecbc:	00100593          	li	a1,1
    8000ecc0:	00001517          	auipc	a0,0x1
    8000ecc4:	6c850513          	addi	a0,a0,1736 # 80010388 <lockPrint>
    8000ecc8:	ffffe097          	auipc	ra,0xffffe
    8000eccc:	338080e7          	jalr	824(ra) # 8000d000 <copy_and_swap>
    8000ecd0:	fe0514e3          	bnez	a0,8000ecb8 <_Z11printStringPKc+0x4c>
}
    8000ecd4:	01813083          	ld	ra,24(sp)
    8000ecd8:	01013403          	ld	s0,16(sp)
    8000ecdc:	00813483          	ld	s1,8(sp)
    8000ece0:	02010113          	addi	sp,sp,32
    8000ece4:	00008067          	ret

000000008000ece8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    8000ece8:	fd010113          	addi	sp,sp,-48
    8000ecec:	02113423          	sd	ra,40(sp)
    8000ecf0:	02813023          	sd	s0,32(sp)
    8000ecf4:	00913c23          	sd	s1,24(sp)
    8000ecf8:	01213823          	sd	s2,16(sp)
    8000ecfc:	01313423          	sd	s3,8(sp)
    8000ed00:	01413023          	sd	s4,0(sp)
    8000ed04:	03010413          	addi	s0,sp,48
    8000ed08:	00050993          	mv	s3,a0
    8000ed0c:	00058a13          	mv	s4,a1
    LOCK();
    8000ed10:	00100613          	li	a2,1
    8000ed14:	00000593          	li	a1,0
    8000ed18:	00001517          	auipc	a0,0x1
    8000ed1c:	67050513          	addi	a0,a0,1648 # 80010388 <lockPrint>
    8000ed20:	ffffe097          	auipc	ra,0xffffe
    8000ed24:	2e0080e7          	jalr	736(ra) # 8000d000 <copy_and_swap>
    8000ed28:	fe0514e3          	bnez	a0,8000ed10 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000ed2c:	00000913          	li	s2,0
    8000ed30:	00090493          	mv	s1,s2
    8000ed34:	0019091b          	addiw	s2,s2,1
    8000ed38:	03495a63          	bge	s2,s4,8000ed6c <_Z9getStringPci+0x84>
        cc = getc();
    8000ed3c:	ffffe097          	auipc	ra,0xffffe
    8000ed40:	5c8080e7          	jalr	1480(ra) # 8000d304 <_Z4getcv>
        if(cc < 1)
    8000ed44:	02050463          	beqz	a0,8000ed6c <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000ed48:	009984b3          	add	s1,s3,s1
    8000ed4c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000ed50:	00a00793          	li	a5,10
    8000ed54:	00f50a63          	beq	a0,a5,8000ed68 <_Z9getStringPci+0x80>
    8000ed58:	00d00793          	li	a5,13
    8000ed5c:	fcf51ae3          	bne	a0,a5,8000ed30 <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000ed60:	00090493          	mv	s1,s2
    8000ed64:	0080006f          	j	8000ed6c <_Z9getStringPci+0x84>
    8000ed68:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    8000ed6c:	009984b3          	add	s1,s3,s1
    8000ed70:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000ed74:	00000613          	li	a2,0
    8000ed78:	00100593          	li	a1,1
    8000ed7c:	00001517          	auipc	a0,0x1
    8000ed80:	60c50513          	addi	a0,a0,1548 # 80010388 <lockPrint>
    8000ed84:	ffffe097          	auipc	ra,0xffffe
    8000ed88:	27c080e7          	jalr	636(ra) # 8000d000 <copy_and_swap>
    8000ed8c:	fe0514e3          	bnez	a0,8000ed74 <_Z9getStringPci+0x8c>
    return buf;
}
    8000ed90:	00098513          	mv	a0,s3
    8000ed94:	02813083          	ld	ra,40(sp)
    8000ed98:	02013403          	ld	s0,32(sp)
    8000ed9c:	01813483          	ld	s1,24(sp)
    8000eda0:	01013903          	ld	s2,16(sp)
    8000eda4:	00813983          	ld	s3,8(sp)
    8000eda8:	00013a03          	ld	s4,0(sp)
    8000edac:	03010113          	addi	sp,sp,48
    8000edb0:	00008067          	ret

000000008000edb4 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000edb4:	ff010113          	addi	sp,sp,-16
    8000edb8:	00813423          	sd	s0,8(sp)
    8000edbc:	01010413          	addi	s0,sp,16
    8000edc0:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000edc4:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000edc8:	0006c603          	lbu	a2,0(a3)
    8000edcc:	fd06071b          	addiw	a4,a2,-48
    8000edd0:	0ff77713          	andi	a4,a4,255
    8000edd4:	00900793          	li	a5,9
    8000edd8:	02e7e063          	bltu	a5,a4,8000edf8 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000eddc:	0025179b          	slliw	a5,a0,0x2
    8000ede0:	00a787bb          	addw	a5,a5,a0
    8000ede4:	0017979b          	slliw	a5,a5,0x1
    8000ede8:	00168693          	addi	a3,a3,1
    8000edec:	00c787bb          	addw	a5,a5,a2
    8000edf0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000edf4:	fd5ff06f          	j	8000edc8 <_Z11stringToIntPKc+0x14>
    return n;
}
    8000edf8:	00813403          	ld	s0,8(sp)
    8000edfc:	01010113          	addi	sp,sp,16
    8000ee00:	00008067          	ret

000000008000ee04 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000ee04:	fc010113          	addi	sp,sp,-64
    8000ee08:	02113c23          	sd	ra,56(sp)
    8000ee0c:	02813823          	sd	s0,48(sp)
    8000ee10:	02913423          	sd	s1,40(sp)
    8000ee14:	03213023          	sd	s2,32(sp)
    8000ee18:	01313c23          	sd	s3,24(sp)
    8000ee1c:	04010413          	addi	s0,sp,64
    8000ee20:	00050493          	mv	s1,a0
    8000ee24:	00058913          	mv	s2,a1
    8000ee28:	00060993          	mv	s3,a2
    LOCK();
    8000ee2c:	00100613          	li	a2,1
    8000ee30:	00000593          	li	a1,0
    8000ee34:	00001517          	auipc	a0,0x1
    8000ee38:	55450513          	addi	a0,a0,1364 # 80010388 <lockPrint>
    8000ee3c:	ffffe097          	auipc	ra,0xffffe
    8000ee40:	1c4080e7          	jalr	452(ra) # 8000d000 <copy_and_swap>
    8000ee44:	fe0514e3          	bnez	a0,8000ee2c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000ee48:	00098463          	beqz	s3,8000ee50 <_Z8printIntiii+0x4c>
    8000ee4c:	0804c463          	bltz	s1,8000eed4 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000ee50:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000ee54:	00000593          	li	a1,0
    }

    i = 0;
    8000ee58:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000ee5c:	0009079b          	sext.w	a5,s2
    8000ee60:	0325773b          	remuw	a4,a0,s2
    8000ee64:	00048613          	mv	a2,s1
    8000ee68:	0014849b          	addiw	s1,s1,1
    8000ee6c:	02071693          	slli	a3,a4,0x20
    8000ee70:	0206d693          	srli	a3,a3,0x20
    8000ee74:	00001717          	auipc	a4,0x1
    8000ee78:	46c70713          	addi	a4,a4,1132 # 800102e0 <digits>
    8000ee7c:	00d70733          	add	a4,a4,a3
    8000ee80:	00074683          	lbu	a3,0(a4)
    8000ee84:	fd040713          	addi	a4,s0,-48
    8000ee88:	00c70733          	add	a4,a4,a2
    8000ee8c:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    8000ee90:	0005071b          	sext.w	a4,a0
    8000ee94:	0325553b          	divuw	a0,a0,s2
    8000ee98:	fcf772e3          	bgeu	a4,a5,8000ee5c <_Z8printIntiii+0x58>
    if(neg)
    8000ee9c:	00058c63          	beqz	a1,8000eeb4 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    8000eea0:	fd040793          	addi	a5,s0,-48
    8000eea4:	009784b3          	add	s1,a5,s1
    8000eea8:	02d00793          	li	a5,45
    8000eeac:	fef48823          	sb	a5,-16(s1)
    8000eeb0:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000eeb4:	fff4849b          	addiw	s1,s1,-1
    8000eeb8:	0204c463          	bltz	s1,8000eee0 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    8000eebc:	fd040793          	addi	a5,s0,-48
    8000eec0:	009787b3          	add	a5,a5,s1
    8000eec4:	ff07c503          	lbu	a0,-16(a5)
    8000eec8:	ffffe097          	auipc	ra,0xffffe
    8000eecc:	464080e7          	jalr	1124(ra) # 8000d32c <_Z4putcc>
    8000eed0:	fe5ff06f          	j	8000eeb4 <_Z8printIntiii+0xb0>
        x = -xx;
    8000eed4:	4090053b          	negw	a0,s1
        neg = 1;
    8000eed8:	00100593          	li	a1,1
        x = -xx;
    8000eedc:	f7dff06f          	j	8000ee58 <_Z8printIntiii+0x54>

    UNLOCK();
    8000eee0:	00000613          	li	a2,0
    8000eee4:	00100593          	li	a1,1
    8000eee8:	00001517          	auipc	a0,0x1
    8000eeec:	4a050513          	addi	a0,a0,1184 # 80010388 <lockPrint>
    8000eef0:	ffffe097          	auipc	ra,0xffffe
    8000eef4:	110080e7          	jalr	272(ra) # 8000d000 <copy_and_swap>
    8000eef8:	fe0514e3          	bnez	a0,8000eee0 <_Z8printIntiii+0xdc>
    8000eefc:	03813083          	ld	ra,56(sp)
    8000ef00:	03013403          	ld	s0,48(sp)
    8000ef04:	02813483          	ld	s1,40(sp)
    8000ef08:	02013903          	ld	s2,32(sp)
    8000ef0c:	01813983          	ld	s3,24(sp)
    8000ef10:	04010113          	addi	sp,sp,64
    8000ef14:	00008067          	ret

000000008000ef18 <_Z11bodyWrapperPFvPvES_>:
#include "../../h/user/userWrappers.hpp"
#include "../../h/user/syscall_c.h"
#include "tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    8000ef18:	ff010113          	addi	sp,sp,-16
    8000ef1c:	00113423          	sd	ra,8(sp)
    8000ef20:	00813023          	sd	s0,0(sp)
    8000ef24:	01010413          	addi	s0,sp,16
    8000ef28:	00050793          	mv	a5,a0
    body(args);
    8000ef2c:	00058513          	mv	a0,a1
    8000ef30:	000780e7          	jalr	a5
    thread_exit();
    8000ef34:	ffffe097          	auipc	ra,0xffffe
    8000ef38:	1d4080e7          	jalr	468(ra) # 8000d108 <_Z11thread_exitv>
}
    8000ef3c:	00813083          	ld	ra,8(sp)
    8000ef40:	00013403          	ld	s0,0(sp)
    8000ef44:	01010113          	addi	sp,sp,16
    8000ef48:	00008067          	ret

000000008000ef4c <_Z15userMainWrapperPv>:

void userMainWrapper(void* args) {
    8000ef4c:	ff010113          	addi	sp,sp,-16
    8000ef50:	00113423          	sd	ra,8(sp)
    8000ef54:	00813023          	sd	s0,0(sp)
    8000ef58:	01010413          	addi	s0,sp,16
    userMain();
    8000ef5c:	fffff097          	auipc	ra,0xfffff
    8000ef60:	3b8080e7          	jalr	952(ra) # 8000e314 <_Z8userMainv>
    8000ef64:	00813083          	ld	ra,8(sp)
    8000ef68:	00013403          	ld	s0,0(sp)
    8000ef6c:	01010113          	addi	sp,sp,16
    8000ef70:	00008067          	ret

000000008000ef74 <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    8000ef74:	ff010113          	addi	sp,sp,-16
    8000ef78:	00113423          	sd	ra,8(sp)
    8000ef7c:	00813023          	sd	s0,0(sp)
    8000ef80:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    8000ef84:	00053783          	ld	a5,0(a0)
    8000ef88:	0107b783          	ld	a5,16(a5)
    8000ef8c:	000780e7          	jalr	a5
}
    8000ef90:	00813083          	ld	ra,8(sp)
    8000ef94:	00013403          	ld	s0,0(sp)
    8000ef98:	01010113          	addi	sp,sp,16
    8000ef9c:	00008067          	ret

000000008000efa0 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    8000efa0:	ff010113          	addi	sp,sp,-16
    8000efa4:	00113423          	sd	ra,8(sp)
    8000efa8:	00813023          	sd	s0,0(sp)
    8000efac:	01010413          	addi	s0,sp,16
    8000efb0:	00001797          	auipc	a5,0x1
    8000efb4:	38878793          	addi	a5,a5,904 # 80010338 <_ZTV9Semaphore+0x10>
    8000efb8:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    8000efbc:	00853503          	ld	a0,8(a0)
    8000efc0:	ffffe097          	auipc	ra,0xffffe
    8000efc4:	294080e7          	jalr	660(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
};
    8000efc8:	00813083          	ld	ra,8(sp)
    8000efcc:	00013403          	ld	s0,0(sp)
    8000efd0:	01010113          	addi	sp,sp,16
    8000efd4:	00008067          	ret

000000008000efd8 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    8000efd8:	00001797          	auipc	a5,0x1
    8000efdc:	38078793          	addi	a5,a5,896 # 80010358 <_ZTV6Thread+0x10>
    8000efe0:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000efe4:	00853503          	ld	a0,8(a0)
    8000efe8:	02050663          	beqz	a0,8000f014 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    8000efec:	ff010113          	addi	sp,sp,-16
    8000eff0:	00113423          	sd	ra,8(sp)
    8000eff4:	00813023          	sd	s0,0(sp)
    8000eff8:	01010413          	addi	s0,sp,16
    delete myHandle;
    8000effc:	ffffe097          	auipc	ra,0xffffe
    8000f000:	3c8080e7          	jalr	968(ra) # 8000d3c4 <_ZN7_threaddlEPv>
}
    8000f004:	00813083          	ld	ra,8(sp)
    8000f008:	00013403          	ld	s0,0(sp)
    8000f00c:	01010113          	addi	sp,sp,16
    8000f010:	00008067          	ret
    8000f014:	00008067          	ret

000000008000f018 <_Znwm>:
void* operator new(size_t sz){
    8000f018:	ff010113          	addi	sp,sp,-16
    8000f01c:	00113423          	sd	ra,8(sp)
    8000f020:	00813023          	sd	s0,0(sp)
    8000f024:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000f028:	ffffe097          	auipc	ra,0xffffe
    8000f02c:	ff8080e7          	jalr	-8(ra) # 8000d020 <_Z9mem_allocm>
}
    8000f030:	00813083          	ld	ra,8(sp)
    8000f034:	00013403          	ld	s0,0(sp)
    8000f038:	01010113          	addi	sp,sp,16
    8000f03c:	00008067          	ret

000000008000f040 <_Znam>:
void* operator new[](size_t sz){
    8000f040:	ff010113          	addi	sp,sp,-16
    8000f044:	00113423          	sd	ra,8(sp)
    8000f048:	00813023          	sd	s0,0(sp)
    8000f04c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000f050:	ffffe097          	auipc	ra,0xffffe
    8000f054:	fd0080e7          	jalr	-48(ra) # 8000d020 <_Z9mem_allocm>
}
    8000f058:	00813083          	ld	ra,8(sp)
    8000f05c:	00013403          	ld	s0,0(sp)
    8000f060:	01010113          	addi	sp,sp,16
    8000f064:	00008067          	ret

000000008000f068 <_ZdlPv>:
void operator delete(void *ptr){
    8000f068:	ff010113          	addi	sp,sp,-16
    8000f06c:	00113423          	sd	ra,8(sp)
    8000f070:	00813023          	sd	s0,0(sp)
    8000f074:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    8000f078:	ffffe097          	auipc	ra,0xffffe
    8000f07c:	fd8080e7          	jalr	-40(ra) # 8000d050 <_Z8mem_freePv>
}
    8000f080:	00813083          	ld	ra,8(sp)
    8000f084:	00013403          	ld	s0,0(sp)
    8000f088:	01010113          	addi	sp,sp,16
    8000f08c:	00008067          	ret

000000008000f090 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    8000f090:	fe010113          	addi	sp,sp,-32
    8000f094:	00113c23          	sd	ra,24(sp)
    8000f098:	00813823          	sd	s0,16(sp)
    8000f09c:	00913423          	sd	s1,8(sp)
    8000f0a0:	02010413          	addi	s0,sp,32
    8000f0a4:	00050493          	mv	s1,a0
};
    8000f0a8:	00000097          	auipc	ra,0x0
    8000f0ac:	ef8080e7          	jalr	-264(ra) # 8000efa0 <_ZN9SemaphoreD1Ev>
    8000f0b0:	00048513          	mv	a0,s1
    8000f0b4:	00000097          	auipc	ra,0x0
    8000f0b8:	fb4080e7          	jalr	-76(ra) # 8000f068 <_ZdlPv>
    8000f0bc:	01813083          	ld	ra,24(sp)
    8000f0c0:	01013403          	ld	s0,16(sp)
    8000f0c4:	00813483          	ld	s1,8(sp)
    8000f0c8:	02010113          	addi	sp,sp,32
    8000f0cc:	00008067          	ret

000000008000f0d0 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    8000f0d0:	fe010113          	addi	sp,sp,-32
    8000f0d4:	00113c23          	sd	ra,24(sp)
    8000f0d8:	00813823          	sd	s0,16(sp)
    8000f0dc:	00913423          	sd	s1,8(sp)
    8000f0e0:	02010413          	addi	s0,sp,32
    8000f0e4:	00050493          	mv	s1,a0
}
    8000f0e8:	00000097          	auipc	ra,0x0
    8000f0ec:	ef0080e7          	jalr	-272(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000f0f0:	00048513          	mv	a0,s1
    8000f0f4:	00000097          	auipc	ra,0x0
    8000f0f8:	f74080e7          	jalr	-140(ra) # 8000f068 <_ZdlPv>
    8000f0fc:	01813083          	ld	ra,24(sp)
    8000f100:	01013403          	ld	s0,16(sp)
    8000f104:	00813483          	ld	s1,8(sp)
    8000f108:	02010113          	addi	sp,sp,32
    8000f10c:	00008067          	ret

000000008000f110 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000f110:	ff010113          	addi	sp,sp,-16
    8000f114:	00113423          	sd	ra,8(sp)
    8000f118:	00813023          	sd	s0,0(sp)
    8000f11c:	01010413          	addi	s0,sp,16
    8000f120:	00001797          	auipc	a5,0x1
    8000f124:	21878793          	addi	a5,a5,536 # 80010338 <_ZTV9Semaphore+0x10>
    8000f128:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    8000f12c:	00850513          	addi	a0,a0,8
    8000f130:	ffffe097          	auipc	ra,0xffffe
    8000f134:	0ec080e7          	jalr	236(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000f138:	00813083          	ld	ra,8(sp)
    8000f13c:	00013403          	ld	s0,0(sp)
    8000f140:	01010113          	addi	sp,sp,16
    8000f144:	00008067          	ret

000000008000f148 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    8000f148:	ff010113          	addi	sp,sp,-16
    8000f14c:	00113423          	sd	ra,8(sp)
    8000f150:	00813023          	sd	s0,0(sp)
    8000f154:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    8000f158:	00853503          	ld	a0,8(a0)
    8000f15c:	ffffe097          	auipc	ra,0xffffe
    8000f160:	124080e7          	jalr	292(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
}
    8000f164:	00813083          	ld	ra,8(sp)
    8000f168:	00013403          	ld	s0,0(sp)
    8000f16c:	01010113          	addi	sp,sp,16
    8000f170:	00008067          	ret

000000008000f174 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    8000f174:	ff010113          	addi	sp,sp,-16
    8000f178:	00113423          	sd	ra,8(sp)
    8000f17c:	00813023          	sd	s0,0(sp)
    8000f180:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    8000f184:	00853503          	ld	a0,8(a0)
    8000f188:	ffffe097          	auipc	ra,0xffffe
    8000f18c:	124080e7          	jalr	292(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
}
    8000f190:	00813083          	ld	ra,8(sp)
    8000f194:	00013403          	ld	s0,0(sp)
    8000f198:	01010113          	addi	sp,sp,16
    8000f19c:	00008067          	ret

000000008000f1a0 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    8000f1a0:	fe010113          	addi	sp,sp,-32
    8000f1a4:	00113c23          	sd	ra,24(sp)
    8000f1a8:	00813823          	sd	s0,16(sp)
    8000f1ac:	00913423          	sd	s1,8(sp)
    8000f1b0:	02010413          	addi	s0,sp,32
    8000f1b4:	00050493          	mv	s1,a0
    8000f1b8:	00001797          	auipc	a5,0x1
    8000f1bc:	1a078793          	addi	a5,a5,416 # 80010358 <_ZTV6Thread+0x10>
    8000f1c0:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    8000f1c4:	00850513          	addi	a0,a0,8
    8000f1c8:	ffffe097          	auipc	ra,0xffffe
    8000f1cc:	f88080e7          	jalr	-120(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f1d0:	fff00793          	li	a5,-1
    8000f1d4:	00f50c63          	beq	a0,a5,8000f1ec <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    8000f1d8:	01813083          	ld	ra,24(sp)
    8000f1dc:	01013403          	ld	s0,16(sp)
    8000f1e0:	00813483          	ld	s1,8(sp)
    8000f1e4:	02010113          	addi	sp,sp,32
    8000f1e8:	00008067          	ret
        myHandle = nullptr;
    8000f1ec:	0004b423          	sd	zero,8(s1)
}
    8000f1f0:	fe9ff06f          	j	8000f1d8 <_ZN6ThreadC1EPFvPvES0_+0x38>

000000008000f1f4 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    8000f1f4:	fe010113          	addi	sp,sp,-32
    8000f1f8:	00113c23          	sd	ra,24(sp)
    8000f1fc:	00813823          	sd	s0,16(sp)
    8000f200:	00913423          	sd	s1,8(sp)
    8000f204:	02010413          	addi	s0,sp,32
    8000f208:	00050493          	mv	s1,a0
    8000f20c:	00001797          	auipc	a5,0x1
    8000f210:	14c78793          	addi	a5,a5,332 # 80010358 <_ZTV6Thread+0x10>
    8000f214:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    8000f218:	00050613          	mv	a2,a0
    8000f21c:	00000597          	auipc	a1,0x0
    8000f220:	d5858593          	addi	a1,a1,-680 # 8000ef74 <_ZN6Thread7wrapperEPv>
    8000f224:	00850513          	addi	a0,a0,8
    8000f228:	ffffe097          	auipc	ra,0xffffe
    8000f22c:	f28080e7          	jalr	-216(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f230:	fff00793          	li	a5,-1
    8000f234:	00f50c63          	beq	a0,a5,8000f24c <_ZN6ThreadC1Ev+0x58>
}
    8000f238:	01813083          	ld	ra,24(sp)
    8000f23c:	01013403          	ld	s0,16(sp)
    8000f240:	00813483          	ld	s1,8(sp)
    8000f244:	02010113          	addi	sp,sp,32
    8000f248:	00008067          	ret
        myHandle = nullptr;
    8000f24c:	0004b423          	sd	zero,8(s1)
}
    8000f250:	fe9ff06f          	j	8000f238 <_ZN6ThreadC1Ev+0x44>

000000008000f254 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    8000f254:	ff010113          	addi	sp,sp,-16
    8000f258:	00113423          	sd	ra,8(sp)
    8000f25c:	00813023          	sd	s0,0(sp)
    8000f260:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    8000f264:	ffffe097          	auipc	ra,0xffffe
    8000f268:	074080e7          	jalr	116(ra) # 8000d2d8 <_Z10time_sleepm>
}
    8000f26c:	00813083          	ld	ra,8(sp)
    8000f270:	00013403          	ld	s0,0(sp)
    8000f274:	01010113          	addi	sp,sp,16
    8000f278:	00008067          	ret

000000008000f27c <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    8000f27c:	fe010113          	addi	sp,sp,-32
    8000f280:	00113c23          	sd	ra,24(sp)
    8000f284:	00813823          	sd	s0,16(sp)
    8000f288:	00913423          	sd	s1,8(sp)
    8000f28c:	01213023          	sd	s2,0(sp)
    8000f290:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    8000f294:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    8000f298:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    8000f29c:	0004b783          	ld	a5,0(s1)
    8000f2a0:	0187b783          	ld	a5,24(a5)
    8000f2a4:	00048513          	mv	a0,s1
    8000f2a8:	000780e7          	jalr	a5
        pt->sleep(time);
    8000f2ac:	00090513          	mv	a0,s2
    8000f2b0:	00000097          	auipc	ra,0x0
    8000f2b4:	fa4080e7          	jalr	-92(ra) # 8000f254 <_ZN6Thread5sleepEm>
    while(true){
    8000f2b8:	fe5ff06f          	j	8000f29c <_ZN14PeriodicThread7wrapperEPv+0x20>

000000008000f2bc <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000f2bc:	ff010113          	addi	sp,sp,-16
    8000f2c0:	00113423          	sd	ra,8(sp)
    8000f2c4:	00813023          	sd	s0,0(sp)
    8000f2c8:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000f2cc:	ffffe097          	auipc	ra,0xffffe
    8000f2d0:	e64080e7          	jalr	-412(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000f2d4:	00813083          	ld	ra,8(sp)
    8000f2d8:	00013403          	ld	s0,0(sp)
    8000f2dc:	01010113          	addi	sp,sp,16
    8000f2e0:	00008067          	ret

000000008000f2e4 <_ZN6Thread5startEv>:
int Thread::start() {
    8000f2e4:	ff010113          	addi	sp,sp,-16
    8000f2e8:	00113423          	sd	ra,8(sp)
    8000f2ec:	00813023          	sd	s0,0(sp)
    8000f2f0:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    8000f2f4:	00853503          	ld	a0,8(a0)
    8000f2f8:	ffffe097          	auipc	ra,0xffffe
    8000f2fc:	eec080e7          	jalr	-276(ra) # 8000d1e4 <_Z12thread_startP7_thread>
}
    8000f300:	00813083          	ld	ra,8(sp)
    8000f304:	00013403          	ld	s0,0(sp)
    8000f308:	01010113          	addi	sp,sp,16
    8000f30c:	00008067          	ret

000000008000f310 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f310:	fe010113          	addi	sp,sp,-32
    8000f314:	00113c23          	sd	ra,24(sp)
    8000f318:	00813823          	sd	s0,16(sp)
    8000f31c:	00913423          	sd	s1,8(sp)
    8000f320:	01213023          	sd	s2,0(sp)
    8000f324:	02010413          	addi	s0,sp,32
    8000f328:	00050493          	mv	s1,a0
    8000f32c:	00058913          	mv	s2,a1
    8000f330:	01000513          	li	a0,16
    8000f334:	00000097          	auipc	ra,0x0
    8000f338:	ce4080e7          	jalr	-796(ra) # 8000f018 <_Znwm>
    8000f33c:	00050613          	mv	a2,a0
    8000f340:	00050663          	beqz	a0,8000f34c <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    8000f344:	00953023          	sd	s1,0(a0)
    8000f348:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f34c:	00000597          	auipc	a1,0x0
    8000f350:	f3058593          	addi	a1,a1,-208 # 8000f27c <_ZN14PeriodicThread7wrapperEPv>
    8000f354:	00048513          	mv	a0,s1
    8000f358:	00000097          	auipc	ra,0x0
    8000f35c:	e48080e7          	jalr	-440(ra) # 8000f1a0 <_ZN6ThreadC1EPFvPvES0_>
    8000f360:	00001797          	auipc	a5,0x1
    8000f364:	fa878793          	addi	a5,a5,-88 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f368:	00f4b023          	sd	a5,0(s1)
    8000f36c:	01813083          	ld	ra,24(sp)
    8000f370:	01013403          	ld	s0,16(sp)
    8000f374:	00813483          	ld	s1,8(sp)
    8000f378:	00013903          	ld	s2,0(sp)
    8000f37c:	02010113          	addi	sp,sp,32
    8000f380:	00008067          	ret

000000008000f384 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    8000f384:	ff010113          	addi	sp,sp,-16
    8000f388:	00113423          	sd	ra,8(sp)
    8000f38c:	00813023          	sd	s0,0(sp)
    8000f390:	01010413          	addi	s0,sp,16
    return ::getc();
    8000f394:	ffffe097          	auipc	ra,0xffffe
    8000f398:	f70080e7          	jalr	-144(ra) # 8000d304 <_Z4getcv>
}
    8000f39c:	00813083          	ld	ra,8(sp)
    8000f3a0:	00013403          	ld	s0,0(sp)
    8000f3a4:	01010113          	addi	sp,sp,16
    8000f3a8:	00008067          	ret

000000008000f3ac <_ZN7Console4putcEc>:

void Console::putc(char c) {
    8000f3ac:	ff010113          	addi	sp,sp,-16
    8000f3b0:	00113423          	sd	ra,8(sp)
    8000f3b4:	00813023          	sd	s0,0(sp)
    8000f3b8:	01010413          	addi	s0,sp,16
    ::putc(c);
    8000f3bc:	ffffe097          	auipc	ra,0xffffe
    8000f3c0:	f70080e7          	jalr	-144(ra) # 8000d32c <_Z4putcc>
}
    8000f3c4:	00813083          	ld	ra,8(sp)
    8000f3c8:	00013403          	ld	s0,0(sp)
    8000f3cc:	01010113          	addi	sp,sp,16
    8000f3d0:	00008067          	ret

000000008000f3d4 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    8000f3d4:	ff010113          	addi	sp,sp,-16
    8000f3d8:	00813423          	sd	s0,8(sp)
    8000f3dc:	01010413          	addi	s0,sp,16
    8000f3e0:	00813403          	ld	s0,8(sp)
    8000f3e4:	01010113          	addi	sp,sp,16
    8000f3e8:	00008067          	ret

000000008000f3ec <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    8000f3ec:	ff010113          	addi	sp,sp,-16
    8000f3f0:	00813423          	sd	s0,8(sp)
    8000f3f4:	01010413          	addi	s0,sp,16
    8000f3f8:	00813403          	ld	s0,8(sp)
    8000f3fc:	01010113          	addi	sp,sp,16
    8000f400:	00008067          	ret

000000008000f404 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    8000f404:	ff010113          	addi	sp,sp,-16
    8000f408:	00113423          	sd	ra,8(sp)
    8000f40c:	00813023          	sd	s0,0(sp)
    8000f410:	01010413          	addi	s0,sp,16
    8000f414:	00001797          	auipc	a5,0x1
    8000f418:	ef478793          	addi	a5,a5,-268 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f41c:	00f53023          	sd	a5,0(a0)
    8000f420:	00000097          	auipc	ra,0x0
    8000f424:	bb8080e7          	jalr	-1096(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000f428:	00813083          	ld	ra,8(sp)
    8000f42c:	00013403          	ld	s0,0(sp)
    8000f430:	01010113          	addi	sp,sp,16
    8000f434:	00008067          	ret

000000008000f438 <_ZN14PeriodicThreadD0Ev>:
    8000f438:	fe010113          	addi	sp,sp,-32
    8000f43c:	00113c23          	sd	ra,24(sp)
    8000f440:	00813823          	sd	s0,16(sp)
    8000f444:	00913423          	sd	s1,8(sp)
    8000f448:	02010413          	addi	s0,sp,32
    8000f44c:	00050493          	mv	s1,a0
    8000f450:	00001797          	auipc	a5,0x1
    8000f454:	eb878793          	addi	a5,a5,-328 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f458:	00f53023          	sd	a5,0(a0)
    8000f45c:	00000097          	auipc	ra,0x0
    8000f460:	b7c080e7          	jalr	-1156(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000f464:	00048513          	mv	a0,s1
    8000f468:	00000097          	auipc	ra,0x0
    8000f46c:	c00080e7          	jalr	-1024(ra) # 8000f068 <_ZdlPv>
    8000f470:	01813083          	ld	ra,24(sp)
    8000f474:	01013403          	ld	s0,16(sp)
    8000f478:	00813483          	ld	s1,8(sp)
    8000f47c:	02010113          	addi	sp,sp,32
    8000f480:	00008067          	ret
	...

0000000080010000 <userDataStart>:
    80010000:	7542                	ld	a0,48(sp)
    80010002:	6666                	ld	a2,88(sp)
    80010004:	7265                	lui	tp,0xffff9
    80010006:	6420                	ld	s0,72(s0)
    80010008:	6c65                	lui	s8,0x19
    8001000a:	7465                	lui	s0,0xffff9
    8001000c:	6465                	lui	s0,0x19
    8001000e:	0a21                	addi	s4,s4,8
	...
    80010018:	3a41                	addiw	s4,s4,-16
    8001001a:	6920                	ld	s0,80(a0)
    8001001c:	003d                	c.nop	15
    8001001e:	0000                	unimp
    80010020:	2041                	0x2041
    80010022:	6966                	ld	s2,88(sp)
    80010024:	696e                	ld	s2,216(sp)
    80010026:	64656873          	csrrsi	a6,0x646,10
    8001002a:	0a21                	addi	s4,s4,8
    8001002c:	0000                	unimp
    8001002e:	0000                	unimp
    80010030:	3a42                	fld	fs4,48(sp)
    80010032:	6920                	ld	s0,80(a0)
    80010034:	003d                	c.nop	15
    80010036:	0000                	unimp
    80010038:	2042                	fld	ft0,16(sp)
    8001003a:	6966                	ld	s2,88(sp)
    8001003c:	696e                	ld	s2,216(sp)
    8001003e:	64656873          	csrrsi	a6,0x646,10
    80010042:	0a21                	addi	s4,s4,8
    80010044:	0000                	unimp
    80010046:	0000                	unimp
    80010048:	69203a43          	fmadd.s	fs4,ft0,fs2,fa3,rup
    8001004c:	003d                	c.nop	15
    8001004e:	0000                	unimp
    80010050:	64203a43          	0x64203a43
    80010054:	7369                	lui	t1,0xffffa
    80010056:	6170                	ld	a2,192(a0)
    80010058:	6374                	ld	a3,192(a4)
    8001005a:	0a68                	addi	a0,sp,284
    8001005c:	0000                	unimp
    8001005e:	0000                	unimp
    80010060:	74203a43          	0x74203a43
    80010064:	3d31                	addiw	s10,s10,-20
    80010066:	0000                	unimp
    80010068:	66203a43          	fmadd.q	fs4,ft0,ft2,fa2,rup
    8001006c:	6269                	lui	tp,0x1a
    8001006e:	63616e6f          	jal	t3,800266a4 <end+0x156a4>
    80010072:	3d69                	addiw	s10,s10,-6
    80010074:	0000                	unimp
    80010076:	0000                	unimp
    80010078:	3a44                	fld	fs1,176(a2)
    8001007a:	6920                	ld	s0,80(a0)
    8001007c:	003d                	c.nop	15
    8001007e:	0000                	unimp
    80010080:	3a44                	fld	fs1,176(a2)
    80010082:	6420                	ld	s0,72(s0)
    80010084:	7369                	lui	t1,0xffffa
    80010086:	6170                	ld	a2,192(a0)
    80010088:	6374                	ld	a3,192(a4)
    8001008a:	0a68                	addi	a0,sp,284
    8001008c:	0000                	unimp
    8001008e:	0000                	unimp
    80010090:	3a44                	fld	fs1,176(a2)
    80010092:	6620                	ld	s0,72(a2)
    80010094:	6269                	lui	tp,0x1a
    80010096:	63616e6f          	jal	t3,800266cc <end+0x156cc>
    8001009a:	3d69                	addiw	s10,s10,-6
    8001009c:	0000                	unimp
    8001009e:	0000                	unimp
    800100a0:	2044                	fld	fs1,128(s0)
    800100a2:	6966                	ld	s2,88(sp)
    800100a4:	696e                	ld	s2,216(sp)
    800100a6:	64656873          	csrrsi	a6,0x646,10
    800100aa:	0a21                	addi	s4,s4,8
    800100ac:	0000                	unimp
    800100ae:	0000                	unimp
    800100b0:	6854                	ld	a3,144(s0)
    800100b2:	6572                	ld	a0,280(sp)
    800100b4:	6461                	lui	s0,0x18
    800100b6:	2041                	0x2041
    800100b8:	61657263          	bgeu	a0,s6,800106bc <lockPrint+0x334>
    800100bc:	6574                	ld	a3,200(a0)
    800100be:	0a64                	addi	s1,sp,284
	...
    800100c8:	6854                	ld	a3,144(s0)
    800100ca:	6572                	ld	a0,280(sp)
    800100cc:	6461                	lui	s0,0x18
    800100ce:	2042                	fld	ft0,16(sp)
    800100d0:	61657263          	bgeu	a0,s6,800106d4 <lockPrint+0x34c>
    800100d4:	6574                	ld	a3,200(a0)
    800100d6:	0a64                	addi	s1,sp,284
	...
    800100e0:	6854                	ld	a3,144(s0)
    800100e2:	6572                	ld	a0,280(sp)
    800100e4:	6461                	lui	s0,0x18
    800100e6:	72632043          	fmadd.d	ft0,ft6,ft6,fa4,rdn
    800100ea:	6165                	addi	sp,sp,112
    800100ec:	6574                	ld	a3,200(a0)
    800100ee:	0a64                	addi	s1,sp,284
	...
    800100f8:	6854                	ld	a3,144(s0)
    800100fa:	6572                	ld	a0,280(sp)
    800100fc:	6461                	lui	s0,0x18
    800100fe:	2044                	fld	fs1,128(s0)
    80010100:	61657263          	bgeu	a0,s6,80010704 <lockPrint+0x37c>
    80010104:	6574                	ld	a3,200(a0)
    80010106:	0a64                	addi	s1,sp,284
	...
    80010110:	6e55                	lui	t3,0x15
    80010112:	7365                	lui	t1,0xffff9
    80010114:	7469                	lui	s0,0xffffa
    80010116:	2065                	0x2065
    80010118:	7262                	ld	tp,56(sp)
    8001011a:	70206a6f          	jal	s4,8001681c <end+0x581c>
    8001011e:	6f72                	ld	t5,280(sp)
    80010120:	7a69                	lui	s4,0xffffa
    80010122:	6f76                	ld	t5,344(sp)
    80010124:	6a64                	ld	s1,208(a2)
    80010126:	6361                	lui	t1,0x18
    80010128:	3f61                	addiw	t5,t5,-8
    8001012a:	000a                	c.slli	zero,0x2
    8001012c:	0000                	unimp
    8001012e:	0000                	unimp
    80010130:	6e55                	lui	t3,0x15
    80010132:	7365                	lui	t1,0xffff9
    80010134:	7469                	lui	s0,0xffffa
    80010136:	2065                	0x2065
    80010138:	6576                	ld	a0,344(sp)
    8001013a:	696c                	ld	a1,208(a0)
    8001013c:	756e6963          	bltu	t3,s6,8001088e <lockPrint+0x506>
    80010140:	6220                	ld	s0,64(a2)
    80010142:	6661                	lui	a2,0x18
    80010144:	7265                	lui	tp,0xffff9
    80010146:	3f61                	addiw	t5,t5,-8
    80010148:	000a                	c.slli	zero,0x2
    8001014a:	0000                	unimp
    8001014c:	0000                	unimp
    8001014e:	0000                	unimp
    80010150:	7242                	ld	tp,48(sp)
    80010152:	70206a6f          	jal	s4,80016854 <end+0x5854>
    80010156:	6f72                	ld	t5,280(sp)
    80010158:	7a69                	lui	s4,0xffffa
    8001015a:	6f76                	ld	t5,344(sp)
    8001015c:	6a64                	ld	s1,208(a2)
    8001015e:	6361                	lui	t1,0x18
    80010160:	2061                	0x2061
    80010162:	0000                	unimp
    80010164:	0000                	unimp
    80010166:	0000                	unimp
    80010168:	6920                	ld	s0,80(a0)
    8001016a:	7620                	ld	s0,104(a2)
    8001016c:	6c65                	lui	s8,0x19
    8001016e:	6369                	lui	t1,0x1a
    80010170:	6e69                	lui	t3,0x1a
    80010172:	2061                	0x2061
    80010174:	6162                	ld	sp,24(sp)
    80010176:	6566                	ld	a0,88(sp)
    80010178:	6172                	ld	sp,280(sp)
    8001017a:	0020                	addi	s0,sp,8
    8001017c:	0000                	unimp
    8001017e:	0000                	unimp
    80010180:	0a2e                	slli	s4,s4,0xb
    80010182:	0000                	unimp
    80010184:	0000                	unimp
    80010186:	0000                	unimp
    80010188:	7242                	ld	tp,48(sp)
    8001018a:	70206a6f          	jal	s4,8001688c <end+0x588c>
    8001018e:	6f72                	ld	t5,280(sp)
    80010190:	7a69                	lui	s4,0xffffa
    80010192:	6f76                	ld	t5,344(sp)
    80010194:	6a64                	ld	s1,208(a2)
    80010196:	6361                	lui	t1,0x18
    80010198:	2061                	0x2061
    8001019a:	656e                	ld	a0,216(sp)
    8001019c:	7320                	ld	s0,96(a4)
    8001019e:	656d                	lui	a0,0x1b
    800101a0:	6220                	ld	s0,64(a2)
    800101a2:	7469                	lui	s0,0xffffa
    800101a4:	2069                	0x2069
    800101a6:	616d                	addi	sp,sp,240
    800101a8:	6a6e                	ld	s4,216(sp)
    800101aa:	2069                	0x2069
    800101ac:	7620646f          	jal	s0,8001690e <end+0x590e>
    800101b0:	6c65                	lui	s8,0x19
    800101b2:	6369                	lui	t1,0x1a
    800101b4:	6e69                	lui	t3,0x1a
    800101b6:	2065                	0x2065
    800101b8:	6162                	ld	sp,24(sp)
    800101ba:	6566                	ld	a0,88(sp)
    800101bc:	6172                	ld	sp,280(sp)
    800101be:	0a21                	addi	s4,s4,8
	...
    800101c8:	7242                	ld	tp,48(sp)
    800101ca:	70206a6f          	jal	s4,800168cc <end+0x58cc>
    800101ce:	6f72                	ld	t5,280(sp)
    800101d0:	7a69                	lui	s4,0xffffa
    800101d2:	6f76                	ld	t5,344(sp)
    800101d4:	6a64                	ld	s1,208(a2)
    800101d6:	6361                	lui	t1,0x18
    800101d8:	2061                	0x2061
    800101da:	6f6d                	lui	t5,0x1b
    800101dc:	6172                	ld	sp,280(sp)
    800101de:	6220                	ld	s0,64(a2)
    800101e0:	7469                	lui	s0,0xffffa
    800101e2:	2069                	0x2069
    800101e4:	6576                	ld	a0,344(sp)
    800101e6:	6f206963          	bltu	zero,s2,800108d8 <lockPrint+0x550>
    800101ea:	2064                	fld	fs1,192(s0)
    800101ec:	756e                	ld	a0,248(sp)
    800101ee:	616c                	ld	a1,192(a0)
    800101f0:	0a21                	addi	s4,s4,8
    800101f2:	0000                	unimp
    800101f4:	0000                	unimp
    800101f6:	0000                	unimp
    800101f8:	7355                	lui	t1,0xffff5
    800101fa:	7265                	lui	tp,0xffff9
    800101fc:	6d20                	ld	s0,88(a0)
    800101fe:	6961                	lui	s2,0x18
    80010200:	206e                	fld	ft0,216(sp)
    80010202:	6966                	ld	s2,88(sp)
    80010204:	696e                	ld	s2,216(sp)
    80010206:	64656873          	csrrsi	a6,0x646,10
    8001020a:	000a                	c.slli	zero,0x2
    8001020c:	0000                	unimp
    8001020e:	0000                	unimp
    80010210:	72617453          	0x72617453
    80010214:	6574                	ld	a3,200(a0)
    80010216:	2064                	fld	fs1,192(s0)
    80010218:	6874                	ld	a3,208(s0)
    8001021a:	6572                	ld	a0,280(sp)
    8001021c:	6461                	lui	s0,0x18
    8001021e:	6920                	ld	s0,80(a0)
    80010220:	3a64                	fld	fs1,240(a2)
    80010222:	0020                	addi	s0,sp,8
    80010224:	0000                	unimp
    80010226:	0000                	unimp
    80010228:	6946                	ld	s2,80(sp)
    8001022a:	696e                	ld	s2,216(sp)
    8001022c:	64656873          	csrrsi	a6,0x646,10
    80010230:	7420                	ld	s0,104(s0)
    80010232:	7268                	ld	a0,224(a2)
    80010234:	6165                	addi	sp,sp,112
    80010236:	2064                	fld	fs1,192(s0)
    80010238:	6469                	lui	s0,0x1a
    8001023a:	203a                	fld	ft0,392(sp)
    8001023c:	0000                	unimp
	...

0000000080010240 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE>:
	...
    80010250:	e494 8000 0000 0000 e4c8 8000 0000 0000     ................
    80010260:	e614 8000 0000 0000                         ........

0000000080010268 <_ZTVN19ConsumerProducerCPP8ProducerE>:
	...
    80010278:	e514 8000 0000 0000 e548 8000 0000 0000     ........H.......
    80010288:	e698 8000 0000 0000                         ........

0000000080010290 <_ZTVN19ConsumerProducerCPP8ConsumerE>:
	...
    800102a0:	e414 8000 0000 0000 e448 8000 0000 0000     ........H.......
    800102b0:	e344 8000 0000 0000                         D.......

00000000800102b8 <_ZTV10ForkThread>:
	...
    800102c8:	e594 8000 0000 0000 e5c8 8000 0000 0000     ................
    800102d8:	e72c 8000 0000 0000                         ,.......

00000000800102e0 <digits>:
    800102e0:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...

00000000800102f8 <_ZTV14PeriodicThread>:
	...
    80010308:	f404 8000 0000 0000 f438 8000 0000 0000     ........8.......
    80010318:	f3d4 8000 0000 0000 f3ec 8000 0000 0000     ................

0000000080010328 <_ZTV9Semaphore>:
	...
    80010338:	efa0 8000 0000 0000 f090 8000 0000 0000     ................

0000000080010348 <_ZTV6Thread>:
	...
    80010358:	efd8 8000 0000 0000 f0d0 8000 0000 0000     ................
    80010368:	f3d4 8000 0000 0000                         ........

0000000080010370 <finishedA>:
	...

0000000080010371 <finishedB>:
    80010371:	0000                                         ...

0000000080010374 <_ZN19ConsumerProducerCPP9threadEndE>:
    80010374:	0000 0000                                   ....

0000000080010378 <finishedC>:
	...

0000000080010379 <finishedD>:
    80010379:	0000 0000 0000                               .......

0000000080010380 <_ZN19ConsumerProducerCPP10waitForAllE>:
	...

0000000080010388 <lockPrint>:
	...
