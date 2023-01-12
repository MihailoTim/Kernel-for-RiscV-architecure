
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	f5013103          	ld	sp,-176(sp) # 8000af50 <_GLOBAL_OFFSET_TABLE_+0x68>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	38c050ef          	jal	ra,800053a8 <start>

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
    80001088:	75d020ef          	jal	ra,80003fe4 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001164:	6bc080e7          	jalr	1724(ra) # 8000281c <_ZN5Buddy4freeEPvm>
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
    800011c4:	1e860613          	addi	a2,a2,488 # 800083a8 <CONSOLE_STATUS+0x398>
    800011c8:	0005059b          	sext.w	a1,a0
    800011cc:	00007517          	auipc	a0,0x7
    800011d0:	e5450513          	addi	a0,a0,-428 # 80008020 <CONSOLE_STATUS+0x10>
    800011d4:	00004097          	auipc	ra,0x4
    800011d8:	fd0080e7          	jalr	-48(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n",10);
    800011dc:	00a00693          	li	a3,10
    800011e0:	00007617          	auipc	a2,0x7
    800011e4:	1c860613          	addi	a2,a2,456 # 800083a8 <CONSOLE_STATUS+0x398>
    800011e8:	01892583          	lw	a1,24(s2)
    800011ec:	00007517          	auipc	a0,0x7
    800011f0:	e4450513          	addi	a0,a0,-444 # 80008030 <CONSOLE_STATUS+0x20>
    800011f4:	00004097          	auipc	ra,0x4
    800011f8:	fb0080e7          	jalr	-80(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n",10);
    800011fc:	00a00693          	li	a3,10
    80001200:	00007617          	auipc	a2,0x7
    80001204:	1a860613          	addi	a2,a2,424 # 800083a8 <CONSOLE_STATUS+0x398>
    80001208:	01092583          	lw	a1,16(s2)
    8000120c:	00007517          	auipc	a0,0x7
    80001210:	e3c50513          	addi	a0,a0,-452 # 80008048 <CONSOLE_STATUS+0x38>
    80001214:	00004097          	auipc	ra,0x4
    80001218:	f90080e7          	jalr	-112(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n",10);
    8000121c:	00a00693          	li	a3,10
    80001220:	00007617          	auipc	a2,0x7
    80001224:	18860613          	addi	a2,a2,392 # 800083a8 <CONSOLE_STATUS+0x398>
    80001228:	43000593          	li	a1,1072
    8000122c:	00007517          	auipc	a0,0x7
    80001230:	e3450513          	addi	a0,a0,-460 # 80008060 <CONSOLE_STATUS+0x50>
    80001234:	00004097          	auipc	ra,0x4
    80001238:	f70080e7          	jalr	-144(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000123c:	01000693          	li	a3,16
    80001240:	00007617          	auipc	a2,0x7
    80001244:	16860613          	addi	a2,a2,360 # 800083a8 <CONSOLE_STATUS+0x398>
    80001248:	42092583          	lw	a1,1056(s2)
    8000124c:	00007517          	auipc	a0,0x7
    80001250:	e2c50513          	addi	a0,a0,-468 # 80008078 <CONSOLE_STATUS+0x68>
    80001254:	00004097          	auipc	ra,0x4
    80001258:	f50080e7          	jalr	-176(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) (&slab->allocated), "\n");
    8000125c:	01000693          	li	a3,16
    80001260:	00007617          	auipc	a2,0x7
    80001264:	14860613          	addi	a2,a2,328 # 800083a8 <CONSOLE_STATUS+0x398>
    80001268:	0209059b          	addiw	a1,s2,32
    8000126c:	00007517          	auipc	a0,0x7
    80001270:	e1c50513          	addi	a0,a0,-484 # 80008088 <CONSOLE_STATUS+0x78>
    80001274:	00004097          	auipc	ra,0x4
    80001278:	f30080e7          	jalr	-208(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000127c:	00007517          	auipc	a0,0x7
    80001280:	e2c50513          	addi	a0,a0,-468 # 800080a8 <CONSOLE_STATUS+0x98>
    80001284:	00004097          	auipc	ra,0x4
    80001288:	e00080e7          	jalr	-512(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
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
    800012ac:	14050513          	addi	a0,a0,320 # 800083e8 <CONSOLE_STATUS+0x3d8>
    800012b0:	00004097          	auipc	ra,0x4
    800012b4:	ef4080e7          	jalr	-268(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012b8:	00148493          	addi	s1,s1,1
    800012bc:	01893783          	ld	a5,24(s2)
    800012c0:	0037d793          	srli	a5,a5,0x3
    800012c4:	00178793          	addi	a5,a5,1
    800012c8:	fcf4e6e3          	bltu	s1,a5,80001294 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    800012cc:	00007517          	auipc	a0,0x7
    800012d0:	0dc50513          	addi	a0,a0,220 # 800083a8 <CONSOLE_STATUS+0x398>
    800012d4:	00004097          	auipc	ra,0x4
    800012d8:	db0080e7          	jalr	-592(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
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
    80001320:	d68080e7          	jalr	-664(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001324:	00090513          	mv	a0,s2
    80001328:	00004097          	auipc	ra,0x4
    8000132c:	d5c080e7          	jalr	-676(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001330:	00007517          	auipc	a0,0x7
    80001334:	07850513          	addi	a0,a0,120 # 800083a8 <CONSOLE_STATUS+0x398>
    80001338:	00004097          	auipc	ra,0x4
    8000133c:	d4c080e7          	jalr	-692(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80001340:	01000693          	li	a3,16
    80001344:	00007617          	auipc	a2,0x7
    80001348:	06460613          	addi	a2,a2,100 # 800083a8 <CONSOLE_STATUS+0x398>
    8000134c:	0009059b          	sext.w	a1,s2
    80001350:	00007517          	auipc	a0,0x7
    80001354:	d8850513          	addi	a0,a0,-632 # 800080d8 <CONSOLE_STATUS+0xc8>
    80001358:	00004097          	auipc	ra,0x4
    8000135c:	e4c080e7          	jalr	-436(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n",10);
    80001360:	00a00693          	li	a3,10
    80001364:	00007617          	auipc	a2,0x7
    80001368:	04460613          	addi	a2,a2,68 # 800083a8 <CONSOLE_STATUS+0x398>
    8000136c:	04892583          	lw	a1,72(s2)
    80001370:	00007517          	auipc	a0,0x7
    80001374:	d7850513          	addi	a0,a0,-648 # 800080e8 <CONSOLE_STATUS+0xd8>
    80001378:	00004097          	auipc	ra,0x4
    8000137c:	e2c080e7          	jalr	-468(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n",10);
    80001380:	00a00693          	li	a3,10
    80001384:	00007617          	auipc	a2,0x7
    80001388:	02460613          	addi	a2,a2,36 # 800083a8 <CONSOLE_STATUS+0x398>
    8000138c:	04092583          	lw	a1,64(s2)
    80001390:	00007517          	auipc	a0,0x7
    80001394:	d7050513          	addi	a0,a0,-656 # 80008100 <CONSOLE_STATUS+0xf0>
    80001398:	00004097          	auipc	ra,0x4
    8000139c:	e0c080e7          	jalr	-500(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013a0:	01000693          	li	a3,16
    800013a4:	00007617          	auipc	a2,0x7
    800013a8:	00460613          	addi	a2,a2,4 # 800083a8 <CONSOLE_STATUS+0x398>
    800013ac:	06092583          	lw	a1,96(s2)
    800013b0:	00007517          	auipc	a0,0x7
    800013b4:	d6850513          	addi	a0,a0,-664 # 80008118 <CONSOLE_STATUS+0x108>
    800013b8:	00004097          	auipc	ra,0x4
    800013bc:	dec080e7          	jalr	-532(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>

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
    800013dc:	01050513          	addi	a0,a0,16 # 800083e8 <CONSOLE_STATUS+0x3d8>
    800013e0:	00004097          	auipc	ra,0x4
    800013e4:	dc4080e7          	jalr	-572(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800013e8:	0084b483          	ld	s1,8(s1)
    while(iter){
    800013ec:	fd9ff06f          	j	800013c4 <_ZN13SlabAllocator10printCacheEP5Cache+0xcc>
    }
    ConsoleUtil::printString("\n");
    800013f0:	00007517          	auipc	a0,0x7
    800013f4:	fb850513          	addi	a0,a0,-72 # 800083a8 <CONSOLE_STATUS+0x398>
    800013f8:	00004097          	auipc	ra,0x4
    800013fc:	c8c080e7          	jalr	-884(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80001400:	01000693          	li	a3,16
    80001404:	00007617          	auipc	a2,0x7
    80001408:	fa460613          	addi	a2,a2,-92 # 800083a8 <CONSOLE_STATUS+0x398>
    8000140c:	06892583          	lw	a1,104(s2)
    80001410:	00007517          	auipc	a0,0x7
    80001414:	d1850513          	addi	a0,a0,-744 # 80008128 <CONSOLE_STATUS+0x118>
    80001418:	00004097          	auipc	ra,0x4
    8000141c:	d8c080e7          	jalr	-628(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>

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
    8000143c:	fb050513          	addi	a0,a0,-80 # 800083e8 <CONSOLE_STATUS+0x3d8>
    80001440:	00004097          	auipc	ra,0x4
    80001444:	d64080e7          	jalr	-668(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001448:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000144c:	fd9ff06f          	j	80001424 <_ZN13SlabAllocator10printCacheEP5Cache+0x12c>
    }
    ConsoleUtil::printString("\n");
    80001450:	00007517          	auipc	a0,0x7
    80001454:	f5850513          	addi	a0,a0,-168 # 800083a8 <CONSOLE_STATUS+0x398>
    80001458:	00004097          	auipc	ra,0x4
    8000145c:	c2c080e7          	jalr	-980(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001460:	01000693          	li	a3,16
    80001464:	00007617          	auipc	a2,0x7
    80001468:	f4460613          	addi	a2,a2,-188 # 800083a8 <CONSOLE_STATUS+0x398>
    8000146c:	07092583          	lw	a1,112(s2)
    80001470:	00007517          	auipc	a0,0x7
    80001474:	cc850513          	addi	a0,a0,-824 # 80008138 <CONSOLE_STATUS+0x128>
    80001478:	00004097          	auipc	ra,0x4
    8000147c:	d2c080e7          	jalr	-724(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>

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
    8000149c:	f5050513          	addi	a0,a0,-176 # 800083e8 <CONSOLE_STATUS+0x3d8>
    800014a0:	00004097          	auipc	ra,0x4
    800014a4:	d04080e7          	jalr	-764(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800014a8:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014ac:	fd9ff06f          	j	80001484 <_ZN13SlabAllocator10printCacheEP5Cache+0x18c>
    }
    ConsoleUtil::printString("\n");
    800014b0:	00007517          	auipc	a0,0x7
    800014b4:	ef850513          	addi	a0,a0,-264 # 800083a8 <CONSOLE_STATUS+0x398>
    800014b8:	00004097          	auipc	ra,0x4
    800014bc:	bcc080e7          	jalr	-1076(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
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
    80001530:	3c8080e7          	jalr	968(ra) # 800028f4 <_ZN5Buddy5allocEm>
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
    800018a8:	050080e7          	jalr	80(ra) # 800028f4 <_ZN5Buddy5allocEm>
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
    80001aac:	060080e7          	jalr	96(ra) # 80004b08 <_Z6strcpyPKcPc>
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
    80001ae4:	fe010113          	addi	sp,sp,-32
    80001ae8:	00113c23          	sd	ra,24(sp)
    80001aec:	00813823          	sd	s0,16(sp)
    80001af0:	00913423          	sd	s1,8(sp)
    80001af4:	01213023          	sd	s2,0(sp)
    80001af8:	02010413          	addi	s0,sp,32
    Buddy::initialize(space, blockNum);
    80001afc:	00001097          	auipc	ra,0x1
    80001b00:	a28080e7          	jalr	-1496(ra) # 80002524 <_ZN5Buddy10initializeEPvm>
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80001b04:	00009917          	auipc	s2,0x9
    80001b08:	3fc93903          	ld	s2,1020(s2) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001b0c:	00093583          	ld	a1,0(s2)
    80001b10:	00c5d593          	srli	a1,a1,0xc
    80001b14:	00158593          	addi	a1,a1,1
    80001b18:	00c59593          	slli	a1,a1,0xc
    80001b1c:	00009497          	auipc	s1,0x9
    80001b20:	50448493          	addi	s1,s1,1284 # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    80001b24:	06b4b823          	sd	a1,112(s1)
    cache->ctor = nullptr;
    80001b28:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80001b2c:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80001b30:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80001b34:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80001b38:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80001b3c:	07800793          	li	a5,120
    80001b40:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001b44:	00200793          	li	a5,2
    80001b48:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001b4c:	00006517          	auipc	a0,0x6
    80001b50:	5fc50513          	addi	a0,a0,1532 # 80008148 <CONSOLE_STATUS+0x138>
    80001b54:	00003097          	auipc	ra,0x3
    80001b58:	fb4080e7          	jalr	-76(ra) # 80004b08 <_Z6strcpyPKcPc>
    largeSlabCache = (Cache*)BUDDY_META_ADDR_CONST;
    80001b5c:	00093783          	ld	a5,0(s2)
    80001b60:	fffff737          	lui	a4,0xfffff
    80001b64:	00e7f7b3          	and	a5,a5,a4
    80001b68:	00f4b023          	sd	a5,0(s1)
    largeSlabCache->ctor = nullptr;
    80001b6c:	0407b823          	sd	zero,80(a5)
    largeSlabCache->dtor = nullptr;
    80001b70:	0407bc23          	sd	zero,88(a5)
    largeSlabCache->emptyHead = nullptr;
    80001b74:	0607b023          	sd	zero,96(a5)
    largeSlabCache->partialHead = nullptr;
    80001b78:	0607b423          	sd	zero,104(a5)
    largeSlabCache->fullHead = nullptr;
    80001b7c:	0607b823          	sd	zero,112(a5)
    largeSlabCache->objectSize = sizeof(Slab);
    80001b80:	43000713          	li	a4,1072
    80001b84:	04e7b023          	sd	a4,64(a5)
    largeSlabCache->slabSize = 4;
    80001b88:	00400713          	li	a4,4
    80001b8c:	04e7b423          	sd	a4,72(a5)
    strcpy("Large Slab Cache", cache->name);
    80001b90:	0704b583          	ld	a1,112(s1)
    80001b94:	00006517          	auipc	a0,0x6
    80001b98:	5c450513          	addi	a0,a0,1476 # 80008158 <CONSOLE_STATUS+0x148>
    80001b9c:	00003097          	auipc	ra,0x3
    80001ba0:	f6c080e7          	jalr	-148(ra) # 80004b08 <_Z6strcpyPKcPc>
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
    80001bf8:	01813083          	ld	ra,24(sp)
    80001bfc:	01013403          	ld	s0,16(sp)
    80001c00:	00813483          	ld	s1,8(sp)
    80001c04:	00013903          	ld	s2,0(sp)
    80001c08:	02010113          	addi	sp,sp,32
    80001c0c:	00008067          	ret

0000000080001c10 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80001c10:	0035d713          	srli	a4,a1,0x3
    80001c14:	00e507b3          	add	a5,a0,a4
    80001c18:	0207c683          	lbu	a3,32(a5)
    80001c1c:	fff5c593          	not	a1,a1
    80001c20:	0075f593          	andi	a1,a1,7
    80001c24:	40b6d7bb          	sraw	a5,a3,a1
    80001c28:	0017f793          	andi	a5,a5,1
    80001c2c:	0e078e63          	beqz	a5,80001d28 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x118>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001c30:	fe010113          	addi	sp,sp,-32
    80001c34:	00113c23          	sd	ra,24(sp)
    80001c38:	00813823          	sd	s0,16(sp)
    80001c3c:	00913423          	sd	s1,8(sp)
    80001c40:	02010413          	addi	s0,sp,32
    80001c44:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80001c48:	00100793          	li	a5,1
    80001c4c:	00b795bb          	sllw	a1,a5,a1
    80001c50:	00e50733          	add	a4,a0,a4
    80001c54:	fff5c593          	not	a1,a1
    80001c58:	00d5f5b3          	and	a1,a1,a3
    80001c5c:	02b70023          	sb	a1,32(a4) # fffffffffffff020 <end+0xffffffff7ffee020>
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001c60:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001c64:	04079a63          	bnez	a5,80001cb8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001c68:	42853503          	ld	a0,1064(a0)
    80001c6c:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001c70:	00178793          	addi	a5,a5,1
    80001c74:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001c78:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001c7c:	04e78463          	beq	a5,a4,80001cc4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80001c80:	4284b583          	ld	a1,1064(s1)
    80001c84:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001c88:	04e78463          	beq	a5,a4,80001cd0 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80001c8c:	0005b703          	ld	a4,0(a1)
    80001c90:	00053783          	ld	a5,0(a0)
    80001c94:	00f70863          	beq	a4,a5,80001ca4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001c98:	00048613          	mv	a2,s1
    80001c9c:	00000097          	auipc	ra,0x0
    80001ca0:	9d0080e7          	jalr	-1584(ra) # 8000166c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001ca4:	01813083          	ld	ra,24(sp)
    80001ca8:	01013403          	ld	s0,16(sp)
    80001cac:	00813483          	ld	s1,8(sp)
    80001cb0:	02010113          	addi	sp,sp,32
    80001cb4:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001cb8:	42853503          	ld	a0,1064(a0)
    80001cbc:	06850513          	addi	a0,a0,104
    80001cc0:	fb1ff06f          	j	80001c70 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001cc4:	4284b583          	ld	a1,1064(s1)
    80001cc8:	06058593          	addi	a1,a1,96
    80001ccc:	fbdff06f          	j	80001c88 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80001cd0:	00048593          	mv	a1,s1
    80001cd4:	00000097          	auipc	ra,0x0
    80001cd8:	944080e7          	jalr	-1724(ra) # 80001618 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            if(slab->parent->objectSize <= sizeof(Slab)) {
    80001cdc:	4284b783          	ld	a5,1064(s1)
    80001ce0:	0407b683          	ld	a3,64(a5)
    80001ce4:	43000713          	li	a4,1072
    80001ce8:	00d76c63          	bltu	a4,a3,80001d00 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xf0>
                Buddy::free(slab, slab->parent->slabSize);
    80001cec:	0487b583          	ld	a1,72(a5)
    80001cf0:	00048513          	mv	a0,s1
    80001cf4:	00001097          	auipc	ra,0x1
    80001cf8:	b28080e7          	jalr	-1240(ra) # 8000281c <_ZN5Buddy4freeEPvm>
    80001cfc:	fa9ff06f          	j	80001ca4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                Buddy::free(slab->objectOffset, slab->parent->slabSize);
    80001d00:	0487b583          	ld	a1,72(a5)
    80001d04:	4204b503          	ld	a0,1056(s1)
    80001d08:	00001097          	auipc	ra,0x1
    80001d0c:	b14080e7          	jalr	-1260(ra) # 8000281c <_ZN5Buddy4freeEPvm>
                SlabAllocator::freeObject(largeSlabCache, slab);
    80001d10:	00048593          	mv	a1,s1
    80001d14:	00009517          	auipc	a0,0x9
    80001d18:	30c53503          	ld	a0,780(a0) # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    80001d1c:	00000097          	auipc	ra,0x0
    80001d20:	010080e7          	jalr	16(ra) # 80001d2c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001d24:	f81ff06f          	j	80001ca4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001d28:	00008067          	ret

0000000080001d2c <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001d2c:	fe010113          	addi	sp,sp,-32
    80001d30:	00113c23          	sd	ra,24(sp)
    80001d34:	00813823          	sd	s0,16(sp)
    80001d38:	00913423          	sd	s1,8(sp)
    80001d3c:	01213023          	sd	s2,0(sp)
    80001d40:	02010413          	addi	s0,sp,32
    80001d44:	00050913          	mv	s2,a0
    80001d48:	00058493          	mv	s1,a1
    if(cache->dtor)
    80001d4c:	05853783          	ld	a5,88(a0)
    80001d50:	00078663          	beqz	a5,80001d5c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80001d54:	00058513          	mv	a0,a1
    80001d58:	000780e7          	jalr	a5
    if(cache->ctor)
    80001d5c:	05093783          	ld	a5,80(s2)
    80001d60:	00078663          	beqz	a5,80001d6c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80001d64:	00048513          	mv	a0,s1
    80001d68:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001d6c:	07093503          	ld	a0,112(s2)
    80001d70:	0080006f          	j	80001d78 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001d74:	00853503          	ld	a0,8(a0)
        while(head){
    80001d78:	02050e63          	beqz	a0,80001db4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001d7c:	42053703          	ld	a4,1056(a0)
    80001d80:	01853783          	ld	a5,24(a0)
    80001d84:	42853683          	ld	a3,1064(a0)
    80001d88:	0406b583          	ld	a1,64(a3)
    80001d8c:	02b787b3          	mul	a5,a5,a1
    80001d90:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001d94:	fef4f0e3          	bgeu	s1,a5,80001d74 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80001d98:	fce4eee3          	bltu	s1,a4,80001d74 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001d9c:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80001da0:	02b755b3          	divu	a1,a4,a1
    80001da4:	00000097          	auipc	ra,0x0
    80001da8:	e6c080e7          	jalr	-404(ra) # 80001c10 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001dac:	00100513          	li	a0,1
    80001db0:	0080006f          	j	80001db8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80001db4:	00000513          	li	a0,0
    if(deleted)
    80001db8:	00050e63          	beqz	a0,80001dd4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80001dbc:	01813083          	ld	ra,24(sp)
    80001dc0:	01013403          	ld	s0,16(sp)
    80001dc4:	00813483          	ld	s1,8(sp)
    80001dc8:	00013903          	ld	s2,0(sp)
    80001dcc:	02010113          	addi	sp,sp,32
    80001dd0:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001dd4:	06893783          	ld	a5,104(s2)
    80001dd8:	0080006f          	j	80001de0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80001ddc:	0087b783          	ld	a5,8(a5)
        while(head){
    80001de0:	fc078ee3          	beqz	a5,80001dbc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001de4:	4207b683          	ld	a3,1056(a5)
    80001de8:	0187b703          	ld	a4,24(a5)
    80001dec:	4287b603          	ld	a2,1064(a5)
    80001df0:	04063583          	ld	a1,64(a2)
    80001df4:	02b70733          	mul	a4,a4,a1
    80001df8:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001dfc:	fee4f0e3          	bgeu	s1,a4,80001ddc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80001e00:	fcd4eee3          	bltu	s1,a3,80001ddc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001e04:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001e08:	02b6d5b3          	divu	a1,a3,a1
    80001e0c:	00078513          	mv	a0,a5
    80001e10:	00000097          	auipc	ra,0x0
    80001e14:	e00080e7          	jalr	-512(ra) # 80001c10 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001e18:	00100513          	li	a0,1
    80001e1c:	fa1ff06f          	j	80001dbc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080001e20 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001e20:	fe010113          	addi	sp,sp,-32
    80001e24:	00113c23          	sd	ra,24(sp)
    80001e28:	00813823          	sd	s0,16(sp)
    80001e2c:	00913423          	sd	s1,8(sp)
    80001e30:	01213023          	sd	s2,0(sp)
    80001e34:	02010413          	addi	s0,sp,32
    80001e38:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001e3c:	00000493          	li	s1,0
    80001e40:	00c00793          	li	a5,12
    80001e44:	0297c863          	blt	a5,s1,80001e74 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001e48:	00349713          	slli	a4,s1,0x3
    80001e4c:	00009797          	auipc	a5,0x9
    80001e50:	1d478793          	addi	a5,a5,468 # 8000b020 <_ZN13SlabAllocator14largeSlabCacheE>
    80001e54:	00e787b3          	add	a5,a5,a4
    80001e58:	00090593          	mv	a1,s2
    80001e5c:	0087b503          	ld	a0,8(a5)
    80001e60:	00000097          	auipc	ra,0x0
    80001e64:	ecc080e7          	jalr	-308(ra) # 80001d2c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001e68:	00051663          	bnez	a0,80001e74 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001e6c:	0014849b          	addiw	s1,s1,1
    80001e70:	fd1ff06f          	j	80001e40 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001e74:	01813083          	ld	ra,24(sp)
    80001e78:	01013403          	ld	s0,16(sp)
    80001e7c:	00813483          	ld	s1,8(sp)
    80001e80:	00013903          	ld	s2,0(sp)
    80001e84:	02010113          	addi	sp,sp,32
    80001e88:	00008067          	ret

0000000080001e8c <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001e8c:	fe010113          	addi	sp,sp,-32
    80001e90:	00113c23          	sd	ra,24(sp)
    80001e94:	00813823          	sd	s0,16(sp)
    80001e98:	00913423          	sd	s1,8(sp)
    80001e9c:	01213023          	sd	s2,0(sp)
    80001ea0:	02010413          	addi	s0,sp,32
    80001ea4:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001ea8:	00053903          	ld	s2,0(a0)
    80001eac:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001eb0:	00093503          	ld	a0,0(s2)
    80001eb4:	02050263          	beqz	a0,80001ed8 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80001eb8:	42853783          	ld	a5,1064(a0)
    80001ebc:	0487b583          	ld	a1,72(a5)
    80001ec0:	00001097          	auipc	ra,0x1
    80001ec4:	95c080e7          	jalr	-1700(ra) # 8000281c <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001ec8:	00093783          	ld	a5,0(s2)
    80001ecc:	0087b783          	ld	a5,8(a5)
    80001ed0:	00f93023          	sd	a5,0(s2)
        while(head){
    80001ed4:	fddff06f          	j	80001eb0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001ed8:	0004b903          	ld	s2,0(s1)
    80001edc:	06890913          	addi	s2,s2,104
    80001ee0:	00093503          	ld	a0,0(s2)
    80001ee4:	02050263          	beqz	a0,80001f08 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80001ee8:	42853783          	ld	a5,1064(a0)
    80001eec:	0487b583          	ld	a1,72(a5)
    80001ef0:	00001097          	auipc	ra,0x1
    80001ef4:	92c080e7          	jalr	-1748(ra) # 8000281c <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001ef8:	00093783          	ld	a5,0(s2)
    80001efc:	0087b783          	ld	a5,8(a5)
    80001f00:	00f93023          	sd	a5,0(s2)
        while(head){
    80001f04:	fddff06f          	j	80001ee0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001f08:	0004b903          	ld	s2,0(s1)
    80001f0c:	06090913          	addi	s2,s2,96
    80001f10:	00093503          	ld	a0,0(s2)
    80001f14:	02050263          	beqz	a0,80001f38 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80001f18:	42853783          	ld	a5,1064(a0)
    80001f1c:	0487b583          	ld	a1,72(a5)
    80001f20:	00001097          	auipc	ra,0x1
    80001f24:	8fc080e7          	jalr	-1796(ra) # 8000281c <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001f28:	00093783          	ld	a5,0(s2)
    80001f2c:	0087b783          	ld	a5,8(a5)
    80001f30:	00f93023          	sd	a5,0(s2)
        while(head){
    80001f34:	fddff06f          	j	80001f10 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001f38:	0004b583          	ld	a1,0(s1)
    80001f3c:	00009517          	auipc	a0,0x9
    80001f40:	15453503          	ld	a0,340(a0) # 8000b090 <_ZN13SlabAllocator5cacheE>
    80001f44:	00000097          	auipc	ra,0x0
    80001f48:	de8080e7          	jalr	-536(ra) # 80001d2c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001f4c:	0004b023          	sd	zero,0(s1)
}
    80001f50:	01813083          	ld	ra,24(sp)
    80001f54:	01013403          	ld	s0,16(sp)
    80001f58:	00813483          	ld	s1,8(sp)
    80001f5c:	00013903          	ld	s2,0(sp)
    80001f60:	02010113          	addi	sp,sp,32
    80001f64:	00008067          	ret

0000000080001f68 <_Z6memsetPKvii>:
                                    "tc_1",
                                    "tc_2",
                                    "tc_3",
                                    "tc_4"};

void memset(const void *data, int size, int value) {
    80001f68:	ff010113          	addi	sp,sp,-16
    80001f6c:	00813423          	sd	s0,8(sp)
    80001f70:	01010413          	addi	s0,sp,16
    for (int j = 0; j < size; j++) {
    80001f74:	00000793          	li	a5,0
    80001f78:	00b7da63          	bge	a5,a1,80001f8c <_Z6memsetPKvii+0x24>
        *((char *)data + j) = value;
    80001f7c:	00f50733          	add	a4,a0,a5
    80001f80:	00c70023          	sb	a2,0(a4)
    for (int j = 0; j < size; j++) {
    80001f84:	0017879b          	addiw	a5,a5,1
    80001f88:	ff1ff06f          	j	80001f78 <_Z6memsetPKvii+0x10>
    }
}
    80001f8c:	00813403          	ld	s0,8(sp)
    80001f90:	01010113          	addi	sp,sp,16
    80001f94:	00008067          	ret

0000000080001f98 <_Z9constructPv>:

void construct(void *data) {
    80001f98:	ff010113          	addi	sp,sp,-16
    80001f9c:	00113423          	sd	ra,8(sp)
    80001fa0:	00813023          	sd	s0,0(sp)
    80001fa4:	01010413          	addi	s0,sp,16
//    static int i = 1;
//    printf("%d Shared object constructed.\n", i++);
    memset(data, shared_size, MASK);
    80001fa8:	0a500613          	li	a2,165
    80001fac:	00700593          	li	a1,7
    80001fb0:	00000097          	auipc	ra,0x0
    80001fb4:	fb8080e7          	jalr	-72(ra) # 80001f68 <_Z6memsetPKvii>
}
    80001fb8:	00813083          	ld	ra,8(sp)
    80001fbc:	00013403          	ld	s0,0(sp)
    80001fc0:	01010113          	addi	sp,sp,16
    80001fc4:	00008067          	ret

0000000080001fc8 <_Z5checkPvm>:

int check(void *data, size_t size) {
    80001fc8:	ff010113          	addi	sp,sp,-16
    80001fcc:	00813423          	sd	s0,8(sp)
    80001fd0:	01010413          	addi	s0,sp,16
    80001fd4:	00050613          	mv	a2,a0
    int ret = 1;
    for (uint64 i = 0; i < size; i++) {
    80001fd8:	00000793          	li	a5,0
    int ret = 1;
    80001fdc:	00100513          	li	a0,1
    80001fe0:	0080006f          	j	80001fe8 <_Z5checkPvm+0x20>
    for (uint64 i = 0; i < size; i++) {
    80001fe4:	00178793          	addi	a5,a5,1
    80001fe8:	00b7fe63          	bgeu	a5,a1,80002004 <_Z5checkPvm+0x3c>
        if (((unsigned char *)data)[i] != MASK) {
    80001fec:	00f60733          	add	a4,a2,a5
    80001ff0:	00074683          	lbu	a3,0(a4)
    80001ff4:	0a500713          	li	a4,165
    80001ff8:	fee686e3          	beq	a3,a4,80001fe4 <_Z5checkPvm+0x1c>
            ret = 0;
    80001ffc:	00000513          	li	a0,0
    80002000:	fe5ff06f          	j	80001fe4 <_Z5checkPvm+0x1c>
        }
    }

    return ret;
}
    80002004:	00813403          	ld	s0,8(sp)
    80002008:	01010113          	addi	sp,sp,16
    8000200c:	00008067          	ret

0000000080002010 <_Z4workPv>:
struct objects_s {
    kmem_cache_t *cache;
    void *data;
};

void work(void* pdata) {
    80002010:	f8010113          	addi	sp,sp,-128
    80002014:	06113c23          	sd	ra,120(sp)
    80002018:	06813823          	sd	s0,112(sp)
    8000201c:	06913423          	sd	s1,104(sp)
    80002020:	07213023          	sd	s2,96(sp)
    80002024:	05313c23          	sd	s3,88(sp)
    80002028:	05413823          	sd	s4,80(sp)
    8000202c:	05513423          	sd	s5,72(sp)
    80002030:	05613023          	sd	s6,64(sp)
    80002034:	03713c23          	sd	s7,56(sp)
    80002038:	03813823          	sd	s8,48(sp)
    8000203c:	03913423          	sd	s9,40(sp)
    80002040:	08010413          	addi	s0,sp,128
    struct data_s data = *(struct data_s*) pdata;
    80002044:	00053c03          	ld	s8,0(a0)
    80002048:	f9843423          	sd	s8,-120(s0)
    8000204c:	00853783          	ld	a5,8(a0)
    80002050:	f8f43823          	sd	a5,-112(s0)
    80002054:	01053783          	ld	a5,16(a0)
    80002058:	f8f43c23          	sd	a5,-104(s0)
    int size = 0;
    int object_size = data.id + 1;
    8000205c:	000c079b          	sext.w	a5,s8
    80002060:	001c0c1b          	addiw	s8,s8,1
    kmem_cache_t *cache = kmem_cache_create(CACHE_NAMES[data.id], object_size, 0, 0);
    80002064:	00379713          	slli	a4,a5,0x3
    80002068:	00009797          	auipc	a5,0x9
    8000206c:	e4078793          	addi	a5,a5,-448 # 8000aea8 <_ZL11CACHE_NAMES>
    80002070:	00e787b3          	add	a5,a5,a4
    80002074:	000c0b13          	mv	s6,s8
    80002078:	00000693          	li	a3,0
    8000207c:	00000613          	li	a2,0
    80002080:	000c0593          	mv	a1,s8
    80002084:	0007b503          	ld	a0,0(a5)
    80002088:	00003097          	auipc	ra,0x3
    8000208c:	1d8080e7          	jalr	472(ra) # 80005260 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002090:	00050a13          	mv	s4,a0

    struct objects_s *objs = (struct objects_s*)(kmalloc(sizeof(struct objects_s) * data.iterations));
    80002094:	f9842b83          	lw	s7,-104(s0)
    80002098:	004b9513          	slli	a0,s7,0x4
    8000209c:	00003097          	auipc	ra,0x3
    800020a0:	2bc080e7          	jalr	700(ra) # 80005358 <_Z7kmallocm>
    800020a4:	00050a93          	mv	s5,a0

    for (int i = 0; i < data.iterations; i++) {
    800020a8:	00000493          	li	s1,0
    int size = 0;
    800020ac:	00000993          	li	s3,0
    800020b0:	0380006f          	j	800020e8 <_Z4workPv+0xd8>
            if (!check(objs[size].data, shared_size)) {
                ConsoleUtil::printString("Value not correct!");
            }
        }
        else {
            objs[size].data = kmem_cache_alloc(cache);
    800020b4:	00499913          	slli	s2,s3,0x4
    800020b8:	012a8933          	add	s2,s5,s2
    800020bc:	000a0513          	mv	a0,s4
    800020c0:	00003097          	auipc	ra,0x3
    800020c4:	1c8080e7          	jalr	456(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
    800020c8:	00a93423          	sd	a0,8(s2)
            objs[size].cache = cache;
    800020cc:	01493023          	sd	s4,0(s2)
            memset(objs[size].data, object_size, MASK);
    800020d0:	0a500613          	li	a2,165
    800020d4:	000c0593          	mv	a1,s8
    800020d8:	00000097          	auipc	ra,0x0
    800020dc:	e90080e7          	jalr	-368(ra) # 80001f68 <_Z6memsetPKvii>
        }
        size++;
    800020e0:	0019899b          	addiw	s3,s3,1
    for (int i = 0; i < data.iterations; i++) {
    800020e4:	0014849b          	addiw	s1,s1,1
    800020e8:	0574da63          	bge	s1,s7,8000213c <_Z4workPv+0x12c>
        if (i % 100 == 0) {
    800020ec:	06400793          	li	a5,100
    800020f0:	02f4e7bb          	remw	a5,s1,a5
    800020f4:	fc0790e3          	bnez	a5,800020b4 <_Z4workPv+0xa4>
            objs[size].data = kmem_cache_alloc(data.shared);
    800020f8:	f9043c83          	ld	s9,-112(s0)
    800020fc:	00499913          	slli	s2,s3,0x4
    80002100:	012a8933          	add	s2,s5,s2
    80002104:	000c8513          	mv	a0,s9
    80002108:	00003097          	auipc	ra,0x3
    8000210c:	180080e7          	jalr	384(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
    80002110:	00a93423          	sd	a0,8(s2)
            objs[size].cache = data.shared;
    80002114:	01993023          	sd	s9,0(s2)
            if (!check(objs[size].data, shared_size)) {
    80002118:	00700593          	li	a1,7
    8000211c:	00000097          	auipc	ra,0x0
    80002120:	eac080e7          	jalr	-340(ra) # 80001fc8 <_Z5checkPvm>
    80002124:	fa051ee3          	bnez	a0,800020e0 <_Z4workPv+0xd0>
                ConsoleUtil::printString("Value not correct!");
    80002128:	00006517          	auipc	a0,0x6
    8000212c:	18050513          	addi	a0,a0,384 # 800082a8 <CONSOLE_STATUS+0x298>
    80002130:	00003097          	auipc	ra,0x3
    80002134:	f54080e7          	jalr	-172(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    80002138:	fa9ff06f          	j	800020e0 <_Z4workPv+0xd0>
    }

    kmem_cache_info(cache);
    8000213c:	000a0513          	mv	a0,s4
    80002140:	00003097          	auipc	ra,0x3
    80002144:	1c8080e7          	jalr	456(ra) # 80005308 <_Z15kmem_cache_infoP5Cache>
    kmem_cache_info(data.shared);
    80002148:	f9043503          	ld	a0,-112(s0)
    8000214c:	00003097          	auipc	ra,0x3
    80002150:	1bc080e7          	jalr	444(ra) # 80005308 <_Z15kmem_cache_infoP5Cache>

    for (int i = 0; i < size; i++) {
    80002154:	00000913          	li	s2,0
    80002158:	0300006f          	j	80002188 <_Z4workPv+0x178>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    8000215c:	000b0593          	mv	a1,s6
    80002160:	0440006f          	j	800021a4 <_Z4workPv+0x194>
            ConsoleUtil::printString("Value not correct!");
    80002164:	00006517          	auipc	a0,0x6
    80002168:	14450513          	addi	a0,a0,324 # 800082a8 <CONSOLE_STATUS+0x298>
    8000216c:	00003097          	auipc	ra,0x3
    80002170:	f18080e7          	jalr	-232(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
        }
        kmem_cache_free(objs[i].cache, objs[i].data);
    80002174:	0084b583          	ld	a1,8(s1)
    80002178:	0004b503          	ld	a0,0(s1)
    8000217c:	00003097          	auipc	ra,0x3
    80002180:	134080e7          	jalr	308(ra) # 800052b0 <_Z15kmem_cache_freeP5CachePv>
    for (int i = 0; i < size; i++) {
    80002184:	0019091b          	addiw	s2,s2,1
    80002188:	03395663          	bge	s2,s3,800021b4 <_Z4workPv+0x1a4>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    8000218c:	00491493          	slli	s1,s2,0x4
    80002190:	009a84b3          	add	s1,s5,s1
    80002194:	0084b503          	ld	a0,8(s1)
    80002198:	0004b783          	ld	a5,0(s1)
    8000219c:	fd4780e3          	beq	a5,s4,8000215c <_Z4workPv+0x14c>
    800021a0:	00700593          	li	a1,7
    800021a4:	00000097          	auipc	ra,0x0
    800021a8:	e24080e7          	jalr	-476(ra) # 80001fc8 <_Z5checkPvm>
    800021ac:	fc0514e3          	bnez	a0,80002174 <_Z4workPv+0x164>
    800021b0:	fb5ff06f          	j	80002164 <_Z4workPv+0x154>
    }

    kfree(objs);
    800021b4:	000a8513          	mv	a0,s5
    800021b8:	00003097          	auipc	ra,0x3
    800021bc:	1c8080e7          	jalr	456(ra) # 80005380 <_Z5kfreePKv>
    kmem_cache_destroy(cache);
    800021c0:	000a0513          	mv	a0,s4
    800021c4:	00003097          	auipc	ra,0x3
    800021c8:	114080e7          	jalr	276(ra) # 800052d8 <_Z18kmem_cache_destroyP5Cache>
}
    800021cc:	07813083          	ld	ra,120(sp)
    800021d0:	07013403          	ld	s0,112(sp)
    800021d4:	06813483          	ld	s1,104(sp)
    800021d8:	06013903          	ld	s2,96(sp)
    800021dc:	05813983          	ld	s3,88(sp)
    800021e0:	05013a03          	ld	s4,80(sp)
    800021e4:	04813a83          	ld	s5,72(sp)
    800021e8:	04013b03          	ld	s6,64(sp)
    800021ec:	03813b83          	ld	s7,56(sp)
    800021f0:	03013c03          	ld	s8,48(sp)
    800021f4:	02813c83          	ld	s9,40(sp)
    800021f8:	08010113          	addi	sp,sp,128
    800021fc:	00008067          	ret

0000000080002200 <_Z4runsPFvPvEP6data_si>:



void runs(void(*work)(void*), struct data_s* data, int num) {
    80002200:	fb010113          	addi	sp,sp,-80
    80002204:	04113423          	sd	ra,72(sp)
    80002208:	04813023          	sd	s0,64(sp)
    8000220c:	02913c23          	sd	s1,56(sp)
    80002210:	03213823          	sd	s2,48(sp)
    80002214:	03313423          	sd	s3,40(sp)
    80002218:	03413023          	sd	s4,32(sp)
    8000221c:	05010413          	addi	s0,sp,80
    80002220:	00050a13          	mv	s4,a0
    80002224:	00058913          	mv	s2,a1
    80002228:	00060993          	mv	s3,a2
    for (int i = 0; i < num; i++) {
    8000222c:	00000493          	li	s1,0
    80002230:	0334d863          	bge	s1,s3,80002260 <_Z4runsPFvPvEP6data_si+0x60>
        struct data_s private_data;
        private_data = *(struct data_s*) data;
    80002234:	00093783          	ld	a5,0(s2)
    80002238:	faf43c23          	sd	a5,-72(s0)
    8000223c:	00893783          	ld	a5,8(s2)
    80002240:	fcf43023          	sd	a5,-64(s0)
    80002244:	01093783          	ld	a5,16(s2)
    80002248:	fcf43423          	sd	a5,-56(s0)
        private_data.id = i;
    8000224c:	fa942c23          	sw	s1,-72(s0)
        work(&private_data);
    80002250:	fb840513          	addi	a0,s0,-72
    80002254:	000a00e7          	jalr	s4
    for (int i = 0; i < num; i++) {
    80002258:	0014849b          	addiw	s1,s1,1
    8000225c:	fd5ff06f          	j	80002230 <_Z4runsPFvPvEP6data_si+0x30>
    }
}
    80002260:	04813083          	ld	ra,72(sp)
    80002264:	04013403          	ld	s0,64(sp)
    80002268:	03813483          	ld	s1,56(sp)
    8000226c:	03013903          	ld	s2,48(sp)
    80002270:	02813983          	ld	s3,40(sp)
    80002274:	02013a03          	ld	s4,32(sp)
    80002278:	05010113          	addi	sp,sp,80
    8000227c:	00008067          	ret

0000000080002280 <_Z5test2v>:

void test2() {
    80002280:	fc010113          	addi	sp,sp,-64
    80002284:	02113c23          	sd	ra,56(sp)
    80002288:	02813823          	sd	s0,48(sp)
    8000228c:	02913423          	sd	s1,40(sp)
    80002290:	04010413          	addi	s0,sp,64
    kmem_cache_t *shared = kmem_cache_create("shared object", shared_size, construct, nullptr);
    80002294:	00000693          	li	a3,0
    80002298:	00000617          	auipc	a2,0x0
    8000229c:	d0060613          	addi	a2,a2,-768 # 80001f98 <_Z9constructPv>
    800022a0:	00700593          	li	a1,7
    800022a4:	00006517          	auipc	a0,0x6
    800022a8:	01c50513          	addi	a0,a0,28 # 800082c0 <CONSOLE_STATUS+0x2b0>
    800022ac:	00003097          	auipc	ra,0x3
    800022b0:	fb4080e7          	jalr	-76(ra) # 80005260 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800022b4:	00050493          	mv	s1,a0

    struct data_s data;
    data.shared = shared;
    800022b8:	fca43823          	sd	a0,-48(s0)
    data.iterations = ITERATIONS;
    800022bc:	3e800793          	li	a5,1000
    800022c0:	fcf42c23          	sw	a5,-40(s0)
    runs(work, &data, RUN_NUM);
    800022c4:	00500613          	li	a2,5
    800022c8:	fc840593          	addi	a1,s0,-56
    800022cc:	00000517          	auipc	a0,0x0
    800022d0:	d4450513          	addi	a0,a0,-700 # 80002010 <_Z4workPv>
    800022d4:	00000097          	auipc	ra,0x0
    800022d8:	f2c080e7          	jalr	-212(ra) # 80002200 <_Z4runsPFvPvEP6data_si>

    kmem_cache_destroy(shared);
    800022dc:	00048513          	mv	a0,s1
    800022e0:	00003097          	auipc	ra,0x3
    800022e4:	ff8080e7          	jalr	-8(ra) # 800052d8 <_Z18kmem_cache_destroyP5Cache>
}
    800022e8:	03813083          	ld	ra,56(sp)
    800022ec:	03013403          	ld	s0,48(sp)
    800022f0:	02813483          	ld	s1,40(sp)
    800022f4:	04010113          	addi	sp,sp,64
    800022f8:	00008067          	ret

00000000800022fc <_Z4ctorPv>:

struct Test{
    uint64 a,b,c,d,e,f;
};

void ctor(void* tst){
    800022fc:	ff010113          	addi	sp,sp,-16
    80002300:	00813423          	sd	s0,8(sp)
    80002304:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    80002308:	01100793          	li	a5,17
    8000230c:	00f53023          	sd	a5,0(a0)
    ((Test*)tst)->b = 32;
    80002310:	02000793          	li	a5,32
    80002314:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    80002318:	00d00793          	li	a5,13
    8000231c:	00f53823          	sd	a5,16(a0)

}
    80002320:	00813403          	ld	s0,8(sp)
    80002324:	01010113          	addi	sp,sp,16
    80002328:	00008067          	ret

000000008000232c <_ZN6SystemC1Ev>:


System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
    8000232c:	00009797          	auipc	a5,0x9
    80002330:	d6c7c783          	lbu	a5,-660(a5) # 8000b098 <_ZN6System11initializedE>
    80002334:	00078463          	beqz	a5,8000233c <_ZN6SystemC1Ev+0x10>
    80002338:	00008067          	ret
System::System() {
    8000233c:	fc010113          	addi	sp,sp,-64
    80002340:	02113c23          	sd	ra,56(sp)
    80002344:	02813823          	sd	s0,48(sp)
    80002348:	02913423          	sd	s1,40(sp)
    8000234c:	03213023          	sd	s2,32(sp)
    80002350:	01313c23          	sd	s3,24(sp)
    80002354:	04010413          	addi	s0,sp,64
        initialized = true;
    80002358:	00100793          	li	a5,1
    8000235c:	00009717          	auipc	a4,0x9
    80002360:	d2f70e23          	sb	a5,-708(a4) # 8000b098 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    80002364:	00002097          	auipc	ra,0x2
    80002368:	6e0080e7          	jalr	1760(ra) # 80004a44 <_ZN5RiscV10initializeEv>

        kmem_cache_info(SlabAllocator::largeSlabCache);
    8000236c:	00009917          	auipc	s2,0x9
    80002370:	c1493903          	ld	s2,-1004(s2) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002374:	00093503          	ld	a0,0(s2)
    80002378:	00003097          	auipc	ra,0x3
    8000237c:	f90080e7          	jalr	-112(ra) # 80005308 <_Z15kmem_cache_infoP5Cache>
        SlabAllocator::printSlab(SlabAllocator::largeSlabCache->partialHead);
    80002380:	00093783          	ld	a5,0(s2)
    80002384:	0687b503          	ld	a0,104(a5)
    80002388:	fffff097          	auipc	ra,0xfffff
    8000238c:	e14080e7          	jalr	-492(ra) # 8000119c <_ZN13SlabAllocator9printSlabEP4Slab>

        kmem_cache_t* cache1 = kmem_cache_create("Cache 1", 512, nullptr, nullptr);
    80002390:	00000693          	li	a3,0
    80002394:	00000613          	li	a2,0
    80002398:	20000593          	li	a1,512
    8000239c:	00006517          	auipc	a0,0x6
    800023a0:	f3450513          	addi	a0,a0,-204 # 800082d0 <CONSOLE_STATUS+0x2c0>
    800023a4:	00003097          	auipc	ra,0x3
    800023a8:	ebc080e7          	jalr	-324(ra) # 80005260 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800023ac:	00050993          	mv	s3,a0
        kmem_cache_t* cache2 = kmem_cache_create("Cache 1", 1<<15, nullptr, nullptr);
    800023b0:	00000693          	li	a3,0
    800023b4:	00000613          	li	a2,0
    800023b8:	000085b7          	lui	a1,0x8
    800023bc:	00006517          	auipc	a0,0x6
    800023c0:	f1450513          	addi	a0,a0,-236 # 800082d0 <CONSOLE_STATUS+0x2c0>
    800023c4:	00003097          	auipc	ra,0x3
    800023c8:	e9c080e7          	jalr	-356(ra) # 80005260 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800023cc:	00050493          	mv	s1,a0
        kmem_cache_alloc(cache1);
    800023d0:	00098513          	mv	a0,s3
    800023d4:	00003097          	auipc	ra,0x3
    800023d8:	eb4080e7          	jalr	-332(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
        void* ret1 =kmem_cache_alloc(cache2);
    800023dc:	00048513          	mv	a0,s1
    800023e0:	00003097          	auipc	ra,0x3
    800023e4:	ea8080e7          	jalr	-344(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
    800023e8:	00050993          	mv	s3,a0
        kmem_cache_alloc(cache2);
    800023ec:	00048513          	mv	a0,s1
    800023f0:	00003097          	auipc	ra,0x3
    800023f4:	e98080e7          	jalr	-360(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
        kmem_cache_alloc(cache2);
    800023f8:	00048513          	mv	a0,s1
    800023fc:	00003097          	auipc	ra,0x3
    80002400:	e8c080e7          	jalr	-372(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
        kmem_cache_alloc(cache2);
    80002404:	00048513          	mv	a0,s1
    80002408:	00003097          	auipc	ra,0x3
    8000240c:	e80080e7          	jalr	-384(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
        kmem_cache_alloc(cache2);
    80002410:	00048513          	mv	a0,s1
    80002414:	00003097          	auipc	ra,0x3
    80002418:	e74080e7          	jalr	-396(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
        kmem_cache_info(cache2);
    8000241c:	00048513          	mv	a0,s1
    80002420:	00003097          	auipc	ra,0x3
    80002424:	ee8080e7          	jalr	-280(ra) # 80005308 <_Z15kmem_cache_infoP5Cache>
        kmem_cache_free(cache2,ret1);
    80002428:	00098593          	mv	a1,s3
    8000242c:	00048513          	mv	a0,s1
    80002430:	00003097          	auipc	ra,0x3
    80002434:	e80080e7          	jalr	-384(ra) # 800052b0 <_Z15kmem_cache_freeP5CachePv>
        SlabAllocator::printSlab(cache2->partialHead);
    80002438:	0684b503          	ld	a0,104(s1)
    8000243c:	fffff097          	auipc	ra,0xfffff
    80002440:	d60080e7          	jalr	-672(ra) # 8000119c <_ZN13SlabAllocator9printSlabEP4Slab>
        SlabAllocator::printSlab(cache2->fullHead);
    80002444:	0704b503          	ld	a0,112(s1)
    80002448:	fffff097          	auipc	ra,0xfffff
    8000244c:	d54080e7          	jalr	-684(ra) # 8000119c <_ZN13SlabAllocator9printSlabEP4Slab>

        kmem_cache_info(SlabAllocator::largeSlabCache);
    80002450:	00093503          	ld	a0,0(s2)
    80002454:	00003097          	auipc	ra,0x3
    80002458:	eb4080e7          	jalr	-332(ra) # 80005308 <_Z15kmem_cache_infoP5Cache>
        SlabAllocator::printSlab(SlabAllocator::largeSlabCache->partialHead);
    8000245c:	00093783          	ld	a5,0(s2)
    80002460:	0687b503          	ld	a0,104(a5)
    80002464:	fffff097          	auipc	ra,0xfffff
    80002468:	d38080e7          	jalr	-712(ra) # 8000119c <_ZN13SlabAllocator9printSlabEP4Slab>
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), userMainWrapper, nullptr);
    8000246c:	00000613          	li	a2,0
    80002470:	00009597          	auipc	a1,0x9
    80002474:	ae85b583          	ld	a1,-1304(a1) # 8000af58 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002478:	fc840513          	addi	a0,s0,-56
    8000247c:	00002097          	auipc	ra,0x2
    80002480:	fc8080e7          	jalr	-56(ra) # 80004444 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80002484:	fc843783          	ld	a5,-56(s0)
    80002488:	0107a703          	lw	a4,16(a5)
    8000248c:	00200793          	li	a5,2
    80002490:	00f70863          	beq	a4,a5,800024a0 <_ZN6SystemC1Ev+0x174>
            RiscV::threadDispatchUtil();
    80002494:	00002097          	auipc	ra,0x2
    80002498:	04c080e7          	jalr	76(ra) # 800044e0 <_ZN5RiscV18threadDispatchUtilEv>
    8000249c:	fe9ff06f          	j	80002484 <_ZN6SystemC1Ev+0x158>
        }

        //finalize the machine
        RiscV::finalize();
    800024a0:	00001097          	auipc	ra,0x1
    800024a4:	258080e7          	jalr	600(ra) # 800036f8 <_ZN5RiscV8finalizeEv>
    }
    800024a8:	03813083          	ld	ra,56(sp)
    800024ac:	03013403          	ld	s0,48(sp)
    800024b0:	02813483          	ld	s1,40(sp)
    800024b4:	02013903          	ld	s2,32(sp)
    800024b8:	01813983          	ld	s3,24(sp)
    800024bc:	04010113          	addi	sp,sp,64
    800024c0:	00008067          	ret

00000000800024c4 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    800024c4:	ff010113          	addi	sp,sp,-16
    800024c8:	00813423          	sd	s0,8(sp)
    800024cc:	01010413          	addi	s0,sp,16
    800024d0:	00100793          	li	a5,1
    800024d4:	00f50863          	beq	a0,a5,800024e4 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800024d8:	00813403          	ld	s0,8(sp)
    800024dc:	01010113          	addi	sp,sp,16
    800024e0:	00008067          	ret
    800024e4:	000107b7          	lui	a5,0x10
    800024e8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800024ec:	fef596e3          	bne	a1,a5,800024d8 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    800024f0:	00009797          	auipc	a5,0x9
    800024f4:	a107b783          	ld	a5,-1520(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    800024f8:	0007b703          	ld	a4,0(a5)
    800024fc:	00c75793          	srli	a5,a4,0xc
    80002500:	00278793          	addi	a5,a5,2
    80002504:	00c79793          	slli	a5,a5,0xc
    80002508:	00009697          	auipc	a3,0x9
    8000250c:	b9868693          	addi	a3,a3,-1128 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002510:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002514:	fffff7b7          	lui	a5,0xfffff
    80002518:	00f77733          	and	a4,a4,a5
    8000251c:	00e6b423          	sd	a4,8(a3)
    80002520:	fb9ff06f          	j	800024d8 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002524 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80002524:	ff010113          	addi	sp,sp,-16
    80002528:	00813423          	sd	s0,8(sp)
    8000252c:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80002530:	00009717          	auipc	a4,0x9
    80002534:	b7070713          	addi	a4,a4,-1168 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002538:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    8000253c:	00009797          	auipc	a5,0x9
    80002540:	9c47b783          	ld	a5,-1596(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002544:	0007b783          	ld	a5,0(a5)
    80002548:	fffff6b7          	lui	a3,0xfffff
    8000254c:	00d7f7b3          	and	a5,a5,a3
    80002550:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80002554:	00009797          	auipc	a5,0x9
    80002558:	96b7be23          	sd	a1,-1668(a5) # 8000aed0 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    8000255c:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002560:	00000713          	li	a4,0
        while(num>1){
    80002564:	00100693          	li	a3,1
    80002568:	00f6f863          	bgeu	a3,a5,80002578 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    8000256c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002570:	00170713          	addi	a4,a4,1
        while(num>1){
    80002574:	ff1ff06f          	j	80002564 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80002578:	00371713          	slli	a4,a4,0x3
    8000257c:	00009797          	auipc	a5,0x9
    80002580:	b2478793          	addi	a5,a5,-1244 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002584:	00e78733          	add	a4,a5,a4
    80002588:	00a73823          	sd	a0,16(a4)
    8000258c:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002590:	00000713          	li	a4,0
        while(num>1){
    80002594:	00100693          	li	a3,1
    80002598:	00f6f863          	bgeu	a3,a5,800025a8 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    8000259c:	0017d793          	srli	a5,a5,0x1
            deg++;
    800025a0:	00170713          	addi	a4,a4,1
        while(num>1){
    800025a4:	ff1ff06f          	j	80002594 <_ZN5Buddy10initializeEPvm+0x70>
    800025a8:	00371713          	slli	a4,a4,0x3
    800025ac:	00009797          	auipc	a5,0x9
    800025b0:	af478793          	addi	a5,a5,-1292 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025b4:	00e78733          	add	a4,a5,a4
    800025b8:	06a73c23          	sd	a0,120(a4)
    800025bc:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800025c0:	00000713          	li	a4,0
        while(num>1){
    800025c4:	00100693          	li	a3,1
    800025c8:	00f6f863          	bgeu	a3,a5,800025d8 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    800025cc:	0017d793          	srli	a5,a5,0x1
            deg++;
    800025d0:	00170713          	addi	a4,a4,1
        while(num>1){
    800025d4:	ff1ff06f          	j	800025c4 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    800025d8:	00371713          	slli	a4,a4,0x3
    800025dc:	00009797          	auipc	a5,0x9
    800025e0:	ac478793          	addi	a5,a5,-1340 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025e4:	00e78733          	add	a4,a5,a4
    800025e8:	01073783          	ld	a5,16(a4)
    800025ec:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    800025f0:	00000793          	li	a5,0
    800025f4:	00c0006f          	j	80002600 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    800025f8:	0015d593          	srli	a1,a1,0x1
            deg++;
    800025fc:	00178793          	addi	a5,a5,1
        while(num>1){
    80002600:	00100713          	li	a4,1
    80002604:	feb76ae3          	bltu	a4,a1,800025f8 <_ZN5Buddy10initializeEPvm+0xd4>
    80002608:	00379793          	slli	a5,a5,0x3
    8000260c:	00009717          	auipc	a4,0x9
    80002610:	a9470713          	addi	a4,a4,-1388 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002614:	00f707b3          	add	a5,a4,a5
    80002618:	0787b783          	ld	a5,120(a5)
    8000261c:	0007b023          	sd	zero,0(a5)
}
    80002620:	00813403          	ld	s0,8(sp)
    80002624:	01010113          	addi	sp,sp,16
    80002628:	00008067          	ret

000000008000262c <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    8000262c:	00c00793          	li	a5,12
    80002630:	10f50063          	beq	a0,a5,80002730 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80002634:	fd010113          	addi	sp,sp,-48
    80002638:	02113423          	sd	ra,40(sp)
    8000263c:	02813023          	sd	s0,32(sp)
    80002640:	00913c23          	sd	s1,24(sp)
    80002644:	01213823          	sd	s2,16(sp)
    80002648:	01313423          	sd	s3,8(sp)
    8000264c:	03010413          	addi	s0,sp,48
    80002650:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80002654:	00351713          	slli	a4,a0,0x3
    80002658:	00009797          	auipc	a5,0x9
    8000265c:	a4878793          	addi	a5,a5,-1464 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002660:	00e787b3          	add	a5,a5,a4
    80002664:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002668:	00000993          	li	s3,0
    8000266c:	0180006f          	j	80002684 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002670:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80002674:	04f70463          	beq	a4,a5,800026bc <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80002678:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    8000267c:	08f70063          	beq	a4,a5,800026fc <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80002680:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80002684:	08048863          	beqz	s1,80002714 <_ZN5Buddy8compressEm+0xe8>
    80002688:	0004b683          	ld	a3,0(s1)
    8000268c:	08068463          	beqz	a3,80002714 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002690:	00009797          	auipc	a5,0x9
    80002694:	a107b783          	ld	a5,-1520(a5) # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002698:	40f48733          	sub	a4,s1,a5
    8000269c:	00c9061b          	addiw	a2,s2,12
    800026a0:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    800026a4:	40f687b3          	sub	a5,a3,a5
    800026a8:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    800026ac:	00177613          	andi	a2,a4,1
    800026b0:	fc0610e3          	bnez	a2,80002670 <_ZN5Buddy8compressEm+0x44>
    800026b4:	00170713          	addi	a4,a4,1
    800026b8:	fbdff06f          	j	80002674 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    800026bc:	00098863          	beqz	s3,800026cc <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    800026c0:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffee000>
    800026c4:	00d9b023          	sd	a3,0(s3)
    800026c8:	fb5ff06f          	j	8000267c <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    800026cc:	0006b603          	ld	a2,0(a3)
    800026d0:	00391593          	slli	a1,s2,0x3
    800026d4:	00009697          	auipc	a3,0x9
    800026d8:	9cc68693          	addi	a3,a3,-1588 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026dc:	00b686b3          	add	a3,a3,a1
    800026e0:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    800026e4:	f8061ce3          	bnez	a2,8000267c <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    800026e8:	00009697          	auipc	a3,0x9
    800026ec:	9b868693          	addi	a3,a3,-1608 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026f0:	00b686b3          	add	a3,a3,a1
    800026f4:	0006b823          	sd	zero,16(a3)
    800026f8:	f85ff06f          	j	8000267c <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    800026fc:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80002700:	00190593          	addi	a1,s2,1
    80002704:	00048513          	mv	a0,s1
    80002708:	00000097          	auipc	ra,0x0
    8000270c:	02c080e7          	jalr	44(ra) # 80002734 <_ZN5Buddy6insertEPvm>
    80002710:	f71ff06f          	j	80002680 <_ZN5Buddy8compressEm+0x54>
}
    80002714:	02813083          	ld	ra,40(sp)
    80002718:	02013403          	ld	s0,32(sp)
    8000271c:	01813483          	ld	s1,24(sp)
    80002720:	01013903          	ld	s2,16(sp)
    80002724:	00813983          	ld	s3,8(sp)
    80002728:	03010113          	addi	sp,sp,48
    8000272c:	00008067          	ret
    80002730:	00008067          	ret

0000000080002734 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80002734:	00050693          	mv	a3,a0
    if(!head[size]){
    80002738:	00359713          	slli	a4,a1,0x3
    8000273c:	00009797          	auipc	a5,0x9
    80002740:	96478793          	addi	a5,a5,-1692 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002744:	00e787b3          	add	a5,a5,a4
    80002748:	0787b783          	ld	a5,120(a5)
    8000274c:	02078c63          	beqz	a5,80002784 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80002750:	ff010113          	addi	sp,sp,-16
    80002754:	00113423          	sd	ra,8(sp)
    80002758:	00813023          	sd	s0,0(sp)
    8000275c:	01010413          	addi	s0,sp,16
    80002760:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80002764:	00068713          	mv	a4,a3
    80002768:	04f6e063          	bltu	a3,a5,800027a8 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    8000276c:	00000613          	li	a2,0
            while (iter != nullptr) {
    80002770:	06078863          	beqz	a5,800027e0 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80002774:	04f76c63          	bltu	a4,a5,800027cc <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80002778:	00078613          	mv	a2,a5
                    iter = iter->next;
    8000277c:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80002780:	ff1ff06f          	j	80002770 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80002784:	00009797          	auipc	a5,0x9
    80002788:	91c78793          	addi	a5,a5,-1764 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000278c:	00e78533          	add	a0,a5,a4
    80002790:	00d53823          	sd	a3,16(a0)
    80002794:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80002798:	0006b023          	sd	zero,0(a3)
    8000279c:	07853783          	ld	a5,120(a0)
    800027a0:	0007b023          	sd	zero,0(a5)
        return;
    800027a4:	00008067          	ret
            newHead->next = head[size];
    800027a8:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    800027ac:	00359713          	slli	a4,a1,0x3
    800027b0:	00009797          	auipc	a5,0x9
    800027b4:	8f078793          	addi	a5,a5,-1808 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027b8:	00e787b3          	add	a5,a5,a4
    800027bc:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    800027c0:	00000097          	auipc	ra,0x0
    800027c4:	e6c080e7          	jalr	-404(ra) # 8000262c <_ZN5Buddy8compressEm>
            return;
    800027c8:	0440006f          	j	8000280c <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    800027cc:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    800027d0:	00d63023          	sd	a3,0(a2)
                    compress(size);
    800027d4:	00000097          	auipc	ra,0x0
    800027d8:	e58080e7          	jalr	-424(ra) # 8000262c <_ZN5Buddy8compressEm>
                    return;
    800027dc:	0300006f          	j	8000280c <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    800027e0:	00351713          	slli	a4,a0,0x3
    800027e4:	00009797          	auipc	a5,0x9
    800027e8:	8bc78793          	addi	a5,a5,-1860 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027ec:	00e787b3          	add	a5,a5,a4
    800027f0:	0107b703          	ld	a4,16(a5)
    800027f4:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    800027f8:	0107b703          	ld	a4,16(a5)
    800027fc:	00073703          	ld	a4,0(a4)
    80002800:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80002804:	00000097          	auipc	ra,0x0
    80002808:	e28080e7          	jalr	-472(ra) # 8000262c <_ZN5Buddy8compressEm>
}
    8000280c:	00813083          	ld	ra,8(sp)
    80002810:	00013403          	ld	s0,0(sp)
    80002814:	01010113          	addi	sp,sp,16
    80002818:	00008067          	ret

000000008000281c <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    8000281c:	02050663          	beqz	a0,80002848 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80002820:	ff010113          	addi	sp,sp,-16
    80002824:	00113423          	sd	ra,8(sp)
    80002828:	00813023          	sd	s0,0(sp)
    8000282c:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80002830:	00000097          	auipc	ra,0x0
    80002834:	f04080e7          	jalr	-252(ra) # 80002734 <_ZN5Buddy6insertEPvm>
}
    80002838:	00813083          	ld	ra,8(sp)
    8000283c:	00013403          	ld	s0,0(sp)
    80002840:	01010113          	addi	sp,sp,16
    80002844:	00008067          	ret
    80002848:	00008067          	ret

000000008000284c <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    8000284c:	ff010113          	addi	sp,sp,-16
    80002850:	00813423          	sd	s0,8(sp)
    80002854:	01010413          	addi	s0,sp,16
    80002858:	03c0006f          	j	80002894 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    8000285c:	00b5859b          	addiw	a1,a1,11
    80002860:	00100713          	li	a4,1
    80002864:	00b715bb          	sllw	a1,a4,a1
    80002868:	00b505b3          	add	a1,a0,a1
    8000286c:	00379693          	slli	a3,a5,0x3
    80002870:	00009717          	auipc	a4,0x9
    80002874:	83070713          	addi	a4,a4,-2000 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002878:	00d70733          	add	a4,a4,a3
    8000287c:	00b73823          	sd	a1,16(a4)
    80002880:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80002884:	0005b023          	sd	zero,0(a1)
    80002888:	07873703          	ld	a4,120(a4)
    8000288c:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002890:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80002894:	fff5879b          	addiw	a5,a1,-1
    80002898:	04c7c863          	blt	a5,a2,800028e8 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    8000289c:	00379693          	slli	a3,a5,0x3
    800028a0:	00009717          	auipc	a4,0x9
    800028a4:	80070713          	addi	a4,a4,-2048 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800028a8:	00d70733          	add	a4,a4,a3
    800028ac:	01073683          	ld	a3,16(a4)
    800028b0:	fa0686e3          	beqz	a3,8000285c <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800028b4:	00b5859b          	addiw	a1,a1,11
    800028b8:	00100713          	li	a4,1
    800028bc:	00b715bb          	sllw	a1,a4,a1
    800028c0:	00b505b3          	add	a1,a0,a1
    800028c4:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    800028c8:	00379693          	slli	a3,a5,0x3
    800028cc:	00008717          	auipc	a4,0x8
    800028d0:	7d470713          	addi	a4,a4,2004 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800028d4:	00d70733          	add	a4,a4,a3
    800028d8:	01073683          	ld	a3,16(a4)
    800028dc:	0006b683          	ld	a3,0(a3)
    800028e0:	00d73823          	sd	a3,16(a4)
    800028e4:	fadff06f          	j	80002890 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    800028e8:	00813403          	ld	s0,8(sp)
    800028ec:	01010113          	addi	sp,sp,16
    800028f0:	00008067          	ret

00000000800028f4 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    800028f4:	fe010113          	addi	sp,sp,-32
    800028f8:	00113c23          	sd	ra,24(sp)
    800028fc:	00813823          	sd	s0,16(sp)
    80002900:	00913423          	sd	s1,8(sp)
    80002904:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80002908:	00c00793          	li	a5,12
    8000290c:	06a7ec63          	bltu	a5,a0,80002984 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002910:	00050593          	mv	a1,a0
    80002914:	00c00793          	li	a5,12
    80002918:	06b7ea63          	bltu	a5,a1,8000298c <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    8000291c:	00359713          	slli	a4,a1,0x3
    80002920:	00008797          	auipc	a5,0x8
    80002924:	78078793          	addi	a5,a5,1920 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002928:	00e787b3          	add	a5,a5,a4
    8000292c:	0787b483          	ld	s1,120(a5)
    80002930:	00049663          	bnez	s1,8000293c <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002934:	00158593          	addi	a1,a1,1
    80002938:	fddff06f          	j	80002914 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    8000293c:	0004b703          	ld	a4,0(s1)
    80002940:	00359693          	slli	a3,a1,0x3
    80002944:	00008797          	auipc	a5,0x8
    80002948:	75c78793          	addi	a5,a5,1884 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000294c:	00d787b3          	add	a5,a5,a3
    80002950:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002954:	00070e63          	beqz	a4,80002970 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80002958:	0005061b          	sext.w	a2,a0
    8000295c:	0005859b          	sext.w	a1,a1
    80002960:	00048513          	mv	a0,s1
    80002964:	00000097          	auipc	ra,0x0
    80002968:	ee8080e7          	jalr	-280(ra) # 8000284c <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    8000296c:	0240006f          	j	80002990 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002970:	00008797          	auipc	a5,0x8
    80002974:	73078793          	addi	a5,a5,1840 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002978:	00d787b3          	add	a5,a5,a3
    8000297c:	0007b823          	sd	zero,16(a5)
    80002980:	fd9ff06f          	j	80002958 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002984:	00000493          	li	s1,0
    80002988:	0080006f          	j	80002990 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    8000298c:	00000493          	li	s1,0
}
    80002990:	00048513          	mv	a0,s1
    80002994:	01813083          	ld	ra,24(sp)
    80002998:	01013403          	ld	s0,16(sp)
    8000299c:	00813483          	ld	s1,8(sp)
    800029a0:	02010113          	addi	sp,sp,32
    800029a4:	00008067          	ret

00000000800029a8 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    800029a8:	fe010113          	addi	sp,sp,-32
    800029ac:	00113c23          	sd	ra,24(sp)
    800029b0:	00813823          	sd	s0,16(sp)
    800029b4:	00913423          	sd	s1,8(sp)
    800029b8:	01213023          	sd	s2,0(sp)
    800029bc:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    800029c0:	00000913          	li	s2,0
    800029c4:	0180006f          	j	800029dc <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    800029c8:	00006517          	auipc	a0,0x6
    800029cc:	9e050513          	addi	a0,a0,-1568 # 800083a8 <CONSOLE_STATUS+0x398>
    800029d0:	00002097          	auipc	ra,0x2
    800029d4:	6b4080e7          	jalr	1716(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800029d8:	0019091b          	addiw	s2,s2,1
    800029dc:	00c00793          	li	a5,12
    800029e0:	0727c663          	blt	a5,s2,80002a4c <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    800029e4:	00000613          	li	a2,0
    800029e8:	00a00593          	li	a1,10
    800029ec:	00090513          	mv	a0,s2
    800029f0:	00002097          	auipc	ra,0x2
    800029f4:	6d8080e7          	jalr	1752(ra) # 800050c8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    800029f8:	00006517          	auipc	a0,0x6
    800029fc:	90850513          	addi	a0,a0,-1784 # 80008300 <CONSOLE_STATUS+0x2f0>
    80002a00:	00002097          	auipc	ra,0x2
    80002a04:	684080e7          	jalr	1668(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80002a08:	00391713          	slli	a4,s2,0x3
    80002a0c:	00008797          	auipc	a5,0x8
    80002a10:	69478793          	addi	a5,a5,1684 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002a14:	00e787b3          	add	a5,a5,a4
    80002a18:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002a1c:	fa0486e3          	beqz	s1,800029c8 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    80002a20:	00000613          	li	a2,0
    80002a24:	01000593          	li	a1,16
    80002a28:	0004851b          	sext.w	a0,s1
    80002a2c:	00002097          	auipc	ra,0x2
    80002a30:	69c080e7          	jalr	1692(ra) # 800050c8 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002a34:	00005517          	auipc	a0,0x5
    80002a38:	6c450513          	addi	a0,a0,1732 # 800080f8 <CONSOLE_STATUS+0xe8>
    80002a3c:	00002097          	auipc	ra,0x2
    80002a40:	648080e7          	jalr	1608(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002a44:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002a48:	fd5ff06f          	j	80002a1c <_ZN5Buddy9printListEv+0x74>
    80002a4c:	01813083          	ld	ra,24(sp)
    80002a50:	01013403          	ld	s0,16(sp)
    80002a54:	00813483          	ld	s1,8(sp)
    80002a58:	00013903          	ld	s2,0(sp)
    80002a5c:	02010113          	addi	sp,sp,32
    80002a60:	00008067          	ret

0000000080002a64 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002a64:	ff010113          	addi	sp,sp,-16
    80002a68:	00113423          	sd	ra,8(sp)
    80002a6c:	00813023          	sd	s0,0(sp)
    80002a70:	01010413          	addi	s0,sp,16
    80002a74:	000105b7          	lui	a1,0x10
    80002a78:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002a7c:	00100513          	li	a0,1
    80002a80:	00000097          	auipc	ra,0x0
    80002a84:	a44080e7          	jalr	-1468(ra) # 800024c4 <_Z41__static_initialization_and_destruction_0ii>
    80002a88:	00813083          	ld	ra,8(sp)
    80002a8c:	00013403          	ld	s0,0(sp)
    80002a90:	01010113          	addi	sp,sp,16
    80002a94:	00008067          	ret

0000000080002a98 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80002a98:	ff010113          	addi	sp,sp,-16
    80002a9c:	00813423          	sd	s0,8(sp)
    80002aa0:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002aa4:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002aa8:	00053823          	sd	zero,16(a0)
}
    80002aac:	00813403          	ld	s0,8(sp)
    80002ab0:	01010113          	addi	sp,sp,16
    80002ab4:	00008067          	ret

0000000080002ab8 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80002ab8:	ff010113          	addi	sp,sp,-16
    80002abc:	00813423          	sd	s0,8(sp)
    80002ac0:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002ac4:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002ac8:	00053823          	sd	zero,16(a0)
    80002acc:	00813403          	ld	s0,8(sp)
    80002ad0:	01010113          	addi	sp,sp,16
    80002ad4:	00008067          	ret

0000000080002ad8 <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    80002ad8:	ff010113          	addi	sp,sp,-16
    80002adc:	00113423          	sd	ra,8(sp)
    80002ae0:	00813023          	sd	s0,0(sp)
    80002ae4:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    80002ae8:	00000697          	auipc	a3,0x0
    80002aec:	fd068693          	addi	a3,a3,-48 # 80002ab8 <_ZN3SCB4dtorEPv>
    80002af0:	00000617          	auipc	a2,0x0
    80002af4:	fa860613          	addi	a2,a2,-88 # 80002a98 <_ZN3SCB4ctorEPv>
    80002af8:	01800593          	li	a1,24
    80002afc:	00006517          	auipc	a0,0x6
    80002b00:	80c50513          	addi	a0,a0,-2036 # 80008308 <CONSOLE_STATUS+0x2f8>
    80002b04:	00002097          	auipc	ra,0x2
    80002b08:	75c080e7          	jalr	1884(ra) # 80005260 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002b0c:	00008797          	auipc	a5,0x8
    80002b10:	66a7ba23          	sd	a0,1652(a5) # 8000b180 <_ZN3SCB8scbCacheE>
}
    80002b14:	00813083          	ld	ra,8(sp)
    80002b18:	00013403          	ld	s0,0(sp)
    80002b1c:	01010113          	addi	sp,sp,16
    80002b20:	00008067          	ret

0000000080002b24 <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    80002b24:	ff010113          	addi	sp,sp,-16
    80002b28:	00813423          	sd	s0,8(sp)
    80002b2c:	01010413          	addi	s0,sp,16
    val = init;
    80002b30:	00b52023          	sw	a1,0(a0)
}
    80002b34:	00813403          	ld	s0,8(sp)
    80002b38:	01010113          	addi	sp,sp,16
    80002b3c:	00008067          	ret

0000000080002b40 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80002b40:	fe010113          	addi	sp,sp,-32
    80002b44:	00113c23          	sd	ra,24(sp)
    80002b48:	00813823          	sd	s0,16(sp)
    80002b4c:	00913423          	sd	s1,8(sp)
    80002b50:	01213023          	sd	s2,0(sp)
    80002b54:	02010413          	addi	s0,sp,32
    80002b58:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002b5c:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002b60:	02050063          	beqz	a0,80002b80 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80002b64:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002b68:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002b6c:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002b70:	00002097          	auipc	ra,0x2
    80002b74:	03c080e7          	jalr	60(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002b78:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002b7c:	fe5ff06f          	j	80002b60 <_ZN3SCBD1Ev+0x20>
}
    80002b80:	01813083          	ld	ra,24(sp)
    80002b84:	01013403          	ld	s0,16(sp)
    80002b88:	00813483          	ld	s1,8(sp)
    80002b8c:	00013903          	ld	s2,0(sp)
    80002b90:	02010113          	addi	sp,sp,32
    80002b94:	00008067          	ret

0000000080002b98 <_ZN3SCB5blockEv>:
void SCB::block() {
    80002b98:	ff010113          	addi	sp,sp,-16
    80002b9c:	00113423          	sd	ra,8(sp)
    80002ba0:	00813023          	sd	s0,0(sp)
    80002ba4:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002ba8:	00853783          	ld	a5,8(a0)
    80002bac:	04078063          	beqz	a5,80002bec <_ZN3SCB5blockEv+0x54>
    80002bb0:	01053703          	ld	a4,16(a0)
    80002bb4:	00008797          	auipc	a5,0x8
    80002bb8:	3f47b783          	ld	a5,1012(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80002bbc:	0007b783          	ld	a5,0(a5)
    80002bc0:	04f73423          	sd	a5,72(a4)
    80002bc4:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002bc8:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002bcc:	00300713          	li	a4,3
    80002bd0:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002bd4:	00000097          	auipc	ra,0x0
    80002bd8:	314080e7          	jalr	788(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
}
    80002bdc:	00813083          	ld	ra,8(sp)
    80002be0:	00013403          	ld	s0,0(sp)
    80002be4:	01010113          	addi	sp,sp,16
    80002be8:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002bec:	00008797          	auipc	a5,0x8
    80002bf0:	3bc7b783          	ld	a5,956(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80002bf4:	0007b783          	ld	a5,0(a5)
    80002bf8:	00f53423          	sd	a5,8(a0)
    80002bfc:	fc9ff06f          	j	80002bc4 <_ZN3SCB5blockEv+0x2c>

0000000080002c00 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    80002c00:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002c04:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002c08:	04853703          	ld	a4,72(a0)
    80002c0c:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002c10:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002c14:	02050a63          	beqz	a0,80002c48 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002c18:	ff010113          	addi	sp,sp,-16
    80002c1c:	00113423          	sd	ra,8(sp)
    80002c20:	00813023          	sd	s0,0(sp)
    80002c24:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002c28:	00100793          	li	a5,1
    80002c2c:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002c30:	00002097          	auipc	ra,0x2
    80002c34:	f7c080e7          	jalr	-132(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>
}
    80002c38:	00813083          	ld	ra,8(sp)
    80002c3c:	00013403          	ld	s0,0(sp)
    80002c40:	01010113          	addi	sp,sp,16
    80002c44:	00008067          	ret
    80002c48:	00008067          	ret

0000000080002c4c <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80002c4c:	00008797          	auipc	a5,0x8
    80002c50:	35c7b783          	ld	a5,860(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80002c54:	0007b783          	ld	a5,0(a5)
    80002c58:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002c5c:	00052783          	lw	a5,0(a0)
    80002c60:	fff7879b          	addiw	a5,a5,-1
    80002c64:	00f52023          	sw	a5,0(a0)
    80002c68:	02079713          	slli	a4,a5,0x20
    80002c6c:	00074463          	bltz	a4,80002c74 <_ZN3SCB4waitEv+0x28>
    80002c70:	00008067          	ret
void SCB::wait() {
    80002c74:	ff010113          	addi	sp,sp,-16
    80002c78:	00113423          	sd	ra,8(sp)
    80002c7c:	00813023          	sd	s0,0(sp)
    80002c80:	01010413          	addi	s0,sp,16
        block();
    80002c84:	00000097          	auipc	ra,0x0
    80002c88:	f14080e7          	jalr	-236(ra) # 80002b98 <_ZN3SCB5blockEv>
}
    80002c8c:	00813083          	ld	ra,8(sp)
    80002c90:	00013403          	ld	s0,0(sp)
    80002c94:	01010113          	addi	sp,sp,16
    80002c98:	00008067          	ret

0000000080002c9c <_ZN3SCB6signalEv>:
    if(val++<0)
    80002c9c:	00052783          	lw	a5,0(a0)
    80002ca0:	0017871b          	addiw	a4,a5,1
    80002ca4:	00e52023          	sw	a4,0(a0)
    80002ca8:	0007c463          	bltz	a5,80002cb0 <_ZN3SCB6signalEv+0x14>
    80002cac:	00008067          	ret
void SCB::signal(){
    80002cb0:	ff010113          	addi	sp,sp,-16
    80002cb4:	00113423          	sd	ra,8(sp)
    80002cb8:	00813023          	sd	s0,0(sp)
    80002cbc:	01010413          	addi	s0,sp,16
        deblock();
    80002cc0:	00000097          	auipc	ra,0x0
    80002cc4:	f40080e7          	jalr	-192(ra) # 80002c00 <_ZN3SCB7deblockEv>
}
    80002cc8:	00813083          	ld	ra,8(sp)
    80002ccc:	00013403          	ld	s0,0(sp)
    80002cd0:	01010113          	addi	sp,sp,16
    80002cd4:	00008067          	ret

0000000080002cd8 <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    80002cd8:	ff010113          	addi	sp,sp,-16
    80002cdc:	00113423          	sd	ra,8(sp)
    80002ce0:	00813023          	sd	s0,0(sp)
    80002ce4:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    80002ce8:	00008517          	auipc	a0,0x8
    80002cec:	49853503          	ld	a0,1176(a0) # 8000b180 <_ZN3SCB8scbCacheE>
    80002cf0:	00002097          	auipc	ra,0x2
    80002cf4:	598080e7          	jalr	1432(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
}
    80002cf8:	00813083          	ld	ra,8(sp)
    80002cfc:	00013403          	ld	s0,0(sp)
    80002d00:	01010113          	addi	sp,sp,16
    80002d04:	00008067          	ret

0000000080002d08 <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    80002d08:	ff010113          	addi	sp,sp,-16
    80002d0c:	00113423          	sd	ra,8(sp)
    80002d10:	00813023          	sd	s0,0(sp)
    80002d14:	01010413          	addi	s0,sp,16
    80002d18:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80002d1c:	00008517          	auipc	a0,0x8
    80002d20:	46453503          	ld	a0,1124(a0) # 8000b180 <_ZN3SCB8scbCacheE>
    80002d24:	00002097          	auipc	ra,0x2
    80002d28:	58c080e7          	jalr	1420(ra) # 800052b0 <_Z15kmem_cache_freeP5CachePv>
}
    80002d2c:	00813083          	ld	ra,8(sp)
    80002d30:	00013403          	ld	s0,0(sp)
    80002d34:	01010113          	addi	sp,sp,16
    80002d38:	00008067          	ret

0000000080002d3c <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80002d3c:	ff010113          	addi	sp,sp,-16
    80002d40:	00813423          	sd	s0,8(sp)
    80002d44:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002d48:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002d4c:	05200513          	li	a0,82
    asm("ecall");
    80002d50:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002d54:	00050513          	mv	a0,a0
}
    80002d58:	0005051b          	sext.w	a0,a0
    80002d5c:	00813403          	ld	s0,8(sp)
    80002d60:	01010113          	addi	sp,sp,16
    80002d64:	00008067          	ret

0000000080002d68 <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/kernel/system.hpp"

int main() {
    80002d68:	fe010113          	addi	sp,sp,-32
    80002d6c:	00113c23          	sd	ra,24(sp)
    80002d70:	00813823          	sd	s0,16(sp)
    80002d74:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002d78:	fe840513          	addi	a0,s0,-24
    80002d7c:	fffff097          	auipc	ra,0xfffff
    80002d80:	5b0080e7          	jalr	1456(ra) # 8000232c <_ZN6SystemC1Ev>

    return 0;
    80002d84:	00000513          	li	a0,0
    80002d88:	01813083          	ld	ra,24(sp)
    80002d8c:	01013403          	ld	s0,16(sp)
    80002d90:	02010113          	addi	sp,sp,32
    80002d94:	00008067          	ret

0000000080002d98 <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80002d98:	ff010113          	addi	sp,sp,-16
    80002d9c:	00813423          	sd	s0,8(sp)
    80002da0:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002da4:	00100793          	li	a5,1
    80002da8:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002dac:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002db0:	00052a23          	sw	zero,20(a0)
}
    80002db4:	00813403          	ld	s0,8(sp)
    80002db8:	01010113          	addi	sp,sp,16
    80002dbc:	00008067          	ret

0000000080002dc0 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80002dc0:	ff010113          	addi	sp,sp,-16
    80002dc4:	00813423          	sd	s0,8(sp)
    80002dc8:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002dcc:	00100793          	li	a5,1
    80002dd0:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002dd4:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002dd8:	00052a23          	sw	zero,20(a0)
    80002ddc:	00813403          	ld	s0,8(sp)
    80002de0:	01010113          	addi	sp,sp,16
    80002de4:	00008067          	ret

0000000080002de8 <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80002de8:	ff010113          	addi	sp,sp,-16
    80002dec:	00113423          	sd	ra,8(sp)
    80002df0:	00813023          	sd	s0,0(sp)
    80002df4:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002df8:	00000097          	auipc	ra,0x0
    80002dfc:	7a0080e7          	jalr	1952(ra) # 80003598 <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    80002e00:	00008797          	auipc	a5,0x8
    80002e04:	3887b783          	ld	a5,904(a5) # 8000b188 <_ZN3TCB7runningE>
    80002e08:	0187b703          	ld	a4,24(a5)
    80002e0c:	0207b503          	ld	a0,32(a5)
    80002e10:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    80002e14:	00001097          	auipc	ra,0x1
    80002e18:	6ac080e7          	jalr	1708(ra) # 800044c0 <_ZN5RiscV14threadExitUtilEv>
}
    80002e1c:	00813083          	ld	ra,8(sp)
    80002e20:	00013403          	ld	s0,0(sp)
    80002e24:	01010113          	addi	sp,sp,16
    80002e28:	00008067          	ret

0000000080002e2c <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002e2c:	ff010113          	addi	sp,sp,-16
    80002e30:	00813423          	sd	s0,8(sp)
    80002e34:	01010413          	addi	s0,sp,16
    80002e38:	04053823          	sd	zero,80(a0)
    80002e3c:	04053c23          	sd	zero,88(a0)
    80002e40:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002e44:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002e48:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002e4c:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002e50:	02058a63          	beqz	a1,80002e84 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80002e54:	00068793          	mv	a5,a3
    80002e58:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002e5c:	02058863          	beqz	a1,80002e8c <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80002e60:	000017b7          	lui	a5,0x1
    80002e64:	00f686b3          	add	a3,a3,a5
    80002e68:	00d53023          	sd	a3,0(a0)
    80002e6c:	00000797          	auipc	a5,0x0
    80002e70:	f7c78793          	addi	a5,a5,-132 # 80002de8 <_ZN3TCB7wrapperEPv>
    80002e74:	00f53423          	sd	a5,8(a0)
}
    80002e78:	00813403          	ld	s0,8(sp)
    80002e7c:	01010113          	addi	sp,sp,16
    80002e80:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002e84:	00000793          	li	a5,0
    80002e88:	fd1ff06f          	j	80002e58 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002e8c:	00000693          	li	a3,0
    80002e90:	fd9ff06f          	j	80002e68 <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080002e94 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002e94:	ff010113          	addi	sp,sp,-16
    80002e98:	00113423          	sd	ra,8(sp)
    80002e9c:	00813023          	sd	s0,0(sp)
    80002ea0:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002ea4:	02853503          	ld	a0,40(a0)
    80002ea8:	00002097          	auipc	ra,0x2
    80002eac:	4d8080e7          	jalr	1240(ra) # 80005380 <_Z5kfreePKv>
}
    80002eb0:	00813083          	ld	ra,8(sp)
    80002eb4:	00013403          	ld	s0,0(sp)
    80002eb8:	01010113          	addi	sp,sp,16
    80002ebc:	00008067          	ret

0000000080002ec0 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002ec0:	ff010113          	addi	sp,sp,-16
    80002ec4:	00113423          	sd	ra,8(sp)
    80002ec8:	00813023          	sd	s0,0(sp)
    80002ecc:	01010413          	addi	s0,sp,16
    free();
    80002ed0:	00000097          	auipc	ra,0x0
    80002ed4:	fc4080e7          	jalr	-60(ra) # 80002e94 <_ZN3TCB4freeEv>
}
    80002ed8:	00813083          	ld	ra,8(sp)
    80002edc:	00013403          	ld	s0,0(sp)
    80002ee0:	01010113          	addi	sp,sp,16
    80002ee4:	00008067          	ret

0000000080002ee8 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002ee8:	fe010113          	addi	sp,sp,-32
    80002eec:	00113c23          	sd	ra,24(sp)
    80002ef0:	00813823          	sd	s0,16(sp)
    80002ef4:	00913423          	sd	s1,8(sp)
    80002ef8:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002efc:	00008497          	auipc	s1,0x8
    80002f00:	28c4b483          	ld	s1,652(s1) # 8000b188 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002f04:	0104a703          	lw	a4,16(s1)
    80002f08:	00100793          	li	a5,1
    80002f0c:	04e7f663          	bgeu	a5,a4,80002f58 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002f10:	00002097          	auipc	ra,0x2
    80002f14:	ce4080e7          	jalr	-796(ra) # 80004bf4 <_ZN9Scheduler3getEv>
    80002f18:	00008797          	auipc	a5,0x8
    80002f1c:	26a7b823          	sd	a0,624(a5) # 8000b188 <_ZN3TCB7runningE>
    if(running) {
    80002f20:	02050263          	beqz	a0,80002f44 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002f24:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002f28:	00000097          	auipc	ra,0x0
    80002f2c:	754080e7          	jalr	1876(ra) # 8000367c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002f30:	00008597          	auipc	a1,0x8
    80002f34:	2585b583          	ld	a1,600(a1) # 8000b188 <_ZN3TCB7runningE>
    80002f38:	00048513          	mv	a0,s1
    80002f3c:	ffffe097          	auipc	ra,0xffffe
    80002f40:	1e4080e7          	jalr	484(ra) # 80001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002f44:	01813083          	ld	ra,24(sp)
    80002f48:	01013403          	ld	s0,16(sp)
    80002f4c:	00813483          	ld	s1,8(sp)
    80002f50:	02010113          	addi	sp,sp,32
    80002f54:	00008067          	ret
        Scheduler::put(old);
    80002f58:	00048513          	mv	a0,s1
    80002f5c:	00002097          	auipc	ra,0x2
    80002f60:	c50080e7          	jalr	-944(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>
    80002f64:	fadff06f          	j	80002f10 <_ZN3TCB8dispatchEv+0x28>

0000000080002f68 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002f68:	ff010113          	addi	sp,sp,-16
    80002f6c:	00113423          	sd	ra,8(sp)
    80002f70:	00813023          	sd	s0,0(sp)
    80002f74:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002f78:	00008517          	auipc	a0,0x8
    80002f7c:	21853503          	ld	a0,536(a0) # 8000b190 <_ZN3TCB8tcbCacheE>
    80002f80:	00002097          	auipc	ra,0x2
    80002f84:	308080e7          	jalr	776(ra) # 80005288 <_Z16kmem_cache_allocP5Cache>
}
    80002f88:	00813083          	ld	ra,8(sp)
    80002f8c:	00013403          	ld	s0,0(sp)
    80002f90:	01010113          	addi	sp,sp,16
    80002f94:	00008067          	ret

0000000080002f98 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002f98:	fe010113          	addi	sp,sp,-32
    80002f9c:	00113c23          	sd	ra,24(sp)
    80002fa0:	00813823          	sd	s0,16(sp)
    80002fa4:	00913423          	sd	s1,8(sp)
    80002fa8:	01213023          	sd	s2,0(sp)
    80002fac:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    80002fb0:	00000697          	auipc	a3,0x0
    80002fb4:	e1068693          	addi	a3,a3,-496 # 80002dc0 <_ZN3TCB4dtorEPv>
    80002fb8:	00000617          	auipc	a2,0x0
    80002fbc:	de060613          	addi	a2,a2,-544 # 80002d98 <_ZN3TCB4ctorEPv>
    80002fc0:	07000593          	li	a1,112
    80002fc4:	00005517          	auipc	a0,0x5
    80002fc8:	35450513          	addi	a0,a0,852 # 80008318 <CONSOLE_STATUS+0x308>
    80002fcc:	00002097          	auipc	ra,0x2
    80002fd0:	294080e7          	jalr	660(ra) # 80005260 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002fd4:	00008797          	auipc	a5,0x8
    80002fd8:	1aa7be23          	sd	a0,444(a5) # 8000b190 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002fdc:	07000513          	li	a0,112
    80002fe0:	00000097          	auipc	ra,0x0
    80002fe4:	f88080e7          	jalr	-120(ra) # 80002f68 <_ZN3TCBnwEm>
    80002fe8:	00050493          	mv	s1,a0
    80002fec:	00050e63          	beqz	a0,80003008 <_ZN3TCB10initializeEv+0x70>
    80002ff0:	00200713          	li	a4,2
    80002ff4:	00000693          	li	a3,0
    80002ff8:	00000613          	li	a2,0
    80002ffc:	00000593          	li	a1,0
    80003000:	00000097          	auipc	ra,0x0
    80003004:	e2c080e7          	jalr	-468(ra) # 80002e2c <_ZN3TCBC1EPFvPvES0_Pmm>
    80003008:	00008797          	auipc	a5,0x8
    8000300c:	1897b023          	sd	s1,384(a5) # 8000b188 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    80003010:	00100793          	li	a5,1
    80003014:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80003018:	00001537          	lui	a0,0x1
    8000301c:	00002097          	auipc	ra,0x2
    80003020:	33c080e7          	jalr	828(ra) # 80005358 <_Z7kmallocm>
    80003024:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80003028:	07000513          	li	a0,112
    8000302c:	00000097          	auipc	ra,0x0
    80003030:	f3c080e7          	jalr	-196(ra) # 80002f68 <_ZN3TCBnwEm>
    80003034:	00050493          	mv	s1,a0
    80003038:	02050063          	beqz	a0,80003058 <_ZN3TCB10initializeEv+0xc0>
    8000303c:	00200713          	li	a4,2
    80003040:	00090693          	mv	a3,s2
    80003044:	00000613          	li	a2,0
    80003048:	00008597          	auipc	a1,0x8
    8000304c:	ee05b583          	ld	a1,-288(a1) # 8000af28 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003050:	00000097          	auipc	ra,0x0
    80003054:	ddc080e7          	jalr	-548(ra) # 80002e2c <_ZN3TCBC1EPFvPvES0_Pmm>
    80003058:	00008797          	auipc	a5,0x8
    8000305c:	1497b023          	sd	s1,320(a5) # 8000b198 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    80003060:	00100793          	li	a5,1
    80003064:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    80003068:	00048513          	mv	a0,s1
    8000306c:	00002097          	auipc	ra,0x2
    80003070:	b40080e7          	jalr	-1216(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>
}
    80003074:	01813083          	ld	ra,24(sp)
    80003078:	01013403          	ld	s0,16(sp)
    8000307c:	00813483          	ld	s1,8(sp)
    80003080:	00013903          	ld	s2,0(sp)
    80003084:	02010113          	addi	sp,sp,32
    80003088:	00008067          	ret

000000008000308c <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    8000308c:	ff010113          	addi	sp,sp,-16
    80003090:	00113423          	sd	ra,8(sp)
    80003094:	00813023          	sd	s0,0(sp)
    80003098:	01010413          	addi	s0,sp,16
    8000309c:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    800030a0:	00008517          	auipc	a0,0x8
    800030a4:	0f053503          	ld	a0,240(a0) # 8000b190 <_ZN3TCB8tcbCacheE>
    800030a8:	00002097          	auipc	ra,0x2
    800030ac:	208080e7          	jalr	520(ra) # 800052b0 <_Z15kmem_cache_freeP5CachePv>
}
    800030b0:	00813083          	ld	ra,8(sp)
    800030b4:	00013403          	ld	s0,0(sp)
    800030b8:	01010113          	addi	sp,sp,16
    800030bc:	00008067          	ret

00000000800030c0 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    800030c0:	ff010113          	addi	sp,sp,-16
    800030c4:	00813423          	sd	s0,8(sp)
    800030c8:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    800030cc:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    800030d0:	05100513          	li	a0,81
    asm("ecall");
    800030d4:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    800030d8:	00050513          	mv	a0,a0
}
    800030dc:	0005051b          	sext.w	a0,a0
    800030e0:	00813403          	ld	s0,8(sp)
    800030e4:	01010113          	addi	sp,sp,16
    800030e8:	00008067          	ret

00000000800030ec <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    800030ec:	ff010113          	addi	sp,sp,-16
    800030f0:	00813423          	sd	s0,8(sp)
    800030f4:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    800030f8:	00008797          	auipc	a5,0x8
    800030fc:	e087b783          	ld	a5,-504(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003100:	0007b783          	ld	a5,0(a5)
    80003104:	00c7d793          	srli	a5,a5,0xc
    80003108:	00278793          	addi	a5,a5,2
    8000310c:	00c79793          	slli	a5,a5,0xc
    80003110:	01000737          	lui	a4,0x1000
    80003114:	00e787b3          	add	a5,a5,a4
    80003118:	00008717          	auipc	a4,0x8
    8000311c:	0a070713          	addi	a4,a4,160 # 8000b1b8 <_ZN15MemoryAllocator11freeMemTailE>
    80003120:	00f73023          	sd	a5,0(a4)
    80003124:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80003128:	0007b823          	sd	zero,16(a5)
    8000312c:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80003130:	00073823          	sd	zero,16(a4)
    80003134:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    80003138:	00008697          	auipc	a3,0x8
    8000313c:	e886b683          	ld	a3,-376(a3) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80003140:	0006b683          	ld	a3,0(a3)
    80003144:	40f686b3          	sub	a3,a3,a5
    80003148:	fe868693          	addi	a3,a3,-24
    8000314c:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80003150:	00873783          	ld	a5,8(a4)
    80003154:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80003158:	00100793          	li	a5,1
    8000315c:	02f70023          	sb	a5,32(a4)
}
    80003160:	00813403          	ld	s0,8(sp)
    80003164:	01010113          	addi	sp,sp,16
    80003168:	00008067          	ret

000000008000316c <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    8000316c:	ff010113          	addi	sp,sp,-16
    80003170:	00813423          	sd	s0,8(sp)
    80003174:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    80003178:	14050663          	beqz	a0,800032c4 <_ZN15MemoryAllocator7kmallocEm+0x158>
    8000317c:	00050793          	mv	a5,a0
    80003180:	00008517          	auipc	a0,0x8
    80003184:	04053503          	ld	a0,64(a0) # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003188:	0a050e63          	beqz	a0,80003244 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    8000318c:	00053703          	ld	a4,0(a0)
    80003190:	12f76e63          	bltu	a4,a5,800032cc <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80003194:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80003198:	00000613          	li	a2,0
    8000319c:	00c0006f          	j	800031a8 <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    800031a0:	00050613          	mv	a2,a0
    800031a4:	01053503          	ld	a0,16(a0)
    800031a8:	00050863          	beqz	a0,800031b8 <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    800031ac:	00053683          	ld	a3,0(a0)
    800031b0:	01878713          	addi	a4,a5,24
    800031b4:	fee6e6e3          	bltu	a3,a4,800031a0 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    800031b8:	08050663          	beqz	a0,80003244 <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    800031bc:	00053683          	ld	a3,0(a0)
    800031c0:	01868713          	addi	a4,a3,24
    800031c4:	00e50733          	add	a4,a0,a4
    800031c8:	00008597          	auipc	a1,0x8
    800031cc:	df85b583          	ld	a1,-520(a1) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    800031d0:	0005b583          	ld	a1,0(a1)
    800031d4:	00b76463          	bltu	a4,a1,800031dc <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    800031d8:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    800031dc:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    800031e0:	05700593          	li	a1,87
    800031e4:	08d5f063          	bgeu	a1,a3,80003264 <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    800031e8:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    800031ec:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    800031f0:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    800031f4:	01053583          	ld	a1,16(a0)
    800031f8:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    800031fc:	00853583          	ld	a1,8(a0)
    80003200:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80003204:	fe868693          	addi	a3,a3,-24
    80003208:	00d7b023          	sd	a3,0(a5)

            if(prev)
    8000320c:	04060263          	beqz	a2,80003250 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80003210:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80003214:	00008797          	auipc	a5,0x8
    80003218:	fbc7b783          	ld	a5,-68(a5) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    8000321c:	06078463          	beqz	a5,80003284 <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80003220:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80003224:	08070063          	beqz	a4,800032a4 <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    80003228:	00873783          	ld	a5,8(a4)
    8000322c:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80003230:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80003234:	00873783          	ld	a5,8(a4)
    80003238:	06078063          	beqz	a5,80003298 <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    8000323c:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80003240:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80003244:	00813403          	ld	s0,8(sp)
    80003248:	01010113          	addi	sp,sp,16
    8000324c:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80003250:	00008697          	auipc	a3,0x8
    80003254:	f6868693          	addi	a3,a3,-152 # 8000b1b8 <_ZN15MemoryAllocator11freeMemTailE>
    80003258:	00f6b023          	sd	a5,0(a3)
    8000325c:	00f6b423          	sd	a5,8(a3)
    80003260:	fb5ff06f          	j	80003214 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    80003264:	00060863          	beqz	a2,80003274 <_ZN15MemoryAllocator7kmallocEm+0x108>
    80003268:	01053783          	ld	a5,16(a0)
    8000326c:	00f63823          	sd	a5,16(a2)
    80003270:	fa5ff06f          	j	80003214 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    80003274:	01053783          	ld	a5,16(a0)
    80003278:	00008697          	auipc	a3,0x8
    8000327c:	f4f6b423          	sd	a5,-184(a3) # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003280:	f95ff06f          	j	80003214 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    80003284:	00008797          	auipc	a5,0x8
    80003288:	f3478793          	addi	a5,a5,-204 # 8000b1b8 <_ZN15MemoryAllocator11freeMemTailE>
    8000328c:	00a7b823          	sd	a0,16(a5)
    80003290:	00a7bc23          	sd	a0,24(a5)
    80003294:	fadff06f          	j	80003240 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    80003298:	00008797          	auipc	a5,0x8
    8000329c:	f2a7bc23          	sd	a0,-200(a5) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    800032a0:	fa1ff06f          	j	80003240 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    800032a4:	00008797          	auipc	a5,0x8
    800032a8:	f1478793          	addi	a5,a5,-236 # 8000b1b8 <_ZN15MemoryAllocator11freeMemTailE>
    800032ac:	0107b703          	ld	a4,16(a5)
    800032b0:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    800032b4:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    800032b8:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    800032bc:	00a7b823          	sd	a0,16(a5)
    800032c0:	f81ff06f          	j	80003240 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    800032c4:	00000513          	li	a0,0
    800032c8:	f7dff06f          	j	80003244 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    800032cc:	00000513          	li	a0,0
    800032d0:	f75ff06f          	j	80003244 <_ZN15MemoryAllocator7kmallocEm+0xd8>

00000000800032d4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    800032d4:	ff010113          	addi	sp,sp,-16
    800032d8:	00813423          	sd	s0,8(sp)
    800032dc:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    800032e0:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800032e4:	00000713          	li	a4,0
    800032e8:	00078a63          	beqz	a5,800032fc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    800032ec:	00a7f863          	bgeu	a5,a0,800032fc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800032f0:	00078713          	mv	a4,a5
    800032f4:	0107b783          	ld	a5,16(a5)
    800032f8:	ff1ff06f          	j	800032e8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    800032fc:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80003300:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80003304:	00078463          	beqz	a5,8000330c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80003308:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    8000330c:	02070263          	beqz	a4,80003330 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003310:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80003314:	0005b703          	ld	a4,0(a1)
    80003318:	00008797          	auipc	a5,0x8
    8000331c:	ea87b783          	ld	a5,-344(a5) # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003320:	00f70c63          	beq	a4,a5,80003338 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80003324:	00813403          	ld	s0,8(sp)
    80003328:	01010113          	addi	sp,sp,16
    8000332c:	00008067          	ret
        *head = blk;
    80003330:	00a5b023          	sd	a0,0(a1)
    80003334:	fe1ff06f          	j	80003314 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80003338:	01053783          	ld	a5,16(a0)
    8000333c:	00078a63          	beqz	a5,80003350 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80003340:	00053683          	ld	a3,0(a0)
    80003344:	00d50733          	add	a4,a0,a3
    80003348:	01870713          	addi	a4,a4,24
    8000334c:	02f70e63          	beq	a4,a5,80003388 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80003350:	00853783          	ld	a5,8(a0)
    80003354:	fc0788e3          	beqz	a5,80003324 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80003358:	0007b683          	ld	a3,0(a5)
    8000335c:	00d78733          	add	a4,a5,a3
    80003360:	01870713          	addi	a4,a4,24
    80003364:	fca710e3          	bne	a4,a0,80003324 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80003368:	00053703          	ld	a4,0(a0)
    8000336c:	00e68733          	add	a4,a3,a4
    80003370:	01870713          	addi	a4,a4,24
    80003374:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80003378:	00853783          	ld	a5,8(a0)
    8000337c:	01053703          	ld	a4,16(a0)
    80003380:	00e7b823          	sd	a4,16(a5)
}
    80003384:	fa1ff06f          	j	80003324 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80003388:	0007b703          	ld	a4,0(a5)
    8000338c:	00e68733          	add	a4,a3,a4
    80003390:	01870713          	addi	a4,a4,24
    80003394:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80003398:	0107b783          	ld	a5,16(a5)
    8000339c:	00f53823          	sd	a5,16(a0)
    800033a0:	fb1ff06f          	j	80003350 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

00000000800033a4 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    800033a4:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    800033a8:	00008697          	auipc	a3,0x8
    800033ac:	e286b683          	ld	a3,-472(a3) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    800033b0:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    800033b4:	00050a63          	beqz	a0,800033c8 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    800033b8:	fe870793          	addi	a5,a4,-24
    800033bc:	00a78663          	beq	a5,a0,800033c8 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    800033c0:	01053503          	ld	a0,16(a0)
    800033c4:	ff1ff06f          	j	800033b4 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    800033c8:	08050463          	beqz	a0,80003450 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    800033cc:	ff010113          	addi	sp,sp,-16
    800033d0:	00113423          	sd	ra,8(sp)
    800033d4:	00813023          	sd	s0,0(sp)
    800033d8:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    800033dc:	00008797          	auipc	a5,0x8
    800033e0:	dec7b783          	ld	a5,-532(a5) # 8000b1c8 <_ZN15MemoryAllocator12allocMemTailE>
    800033e4:	04a78663          	beq	a5,a0,80003430 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    800033e8:	04d50c63          	beq	a0,a3,80003440 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    800033ec:	01053783          	ld	a5,16(a0)
    800033f0:	00078663          	beqz	a5,800033fc <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    800033f4:	00853703          	ld	a4,8(a0)
    800033f8:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    800033fc:	00853783          	ld	a5,8(a0)
    80003400:	00078663          	beqz	a5,8000340c <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80003404:	01053703          	ld	a4,16(a0)
    80003408:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    8000340c:	00008597          	auipc	a1,0x8
    80003410:	db458593          	addi	a1,a1,-588 # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003414:	00000097          	auipc	ra,0x0
    80003418:	ec0080e7          	jalr	-320(ra) # 800032d4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    8000341c:	00000513          	li	a0,0
}
    80003420:	00813083          	ld	ra,8(sp)
    80003424:	00013403          	ld	s0,0(sp)
    80003428:	01010113          	addi	sp,sp,16
    8000342c:	00008067          	ret
            allocMemTail = blk->prev;
    80003430:	00853783          	ld	a5,8(a0)
    80003434:	00008717          	auipc	a4,0x8
    80003438:	d8f73a23          	sd	a5,-620(a4) # 8000b1c8 <_ZN15MemoryAllocator12allocMemTailE>
    8000343c:	fadff06f          	j	800033e8 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80003440:	01053783          	ld	a5,16(a0)
    80003444:	00008717          	auipc	a4,0x8
    80003448:	d8f73623          	sd	a5,-628(a4) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    8000344c:	fa1ff06f          	j	800033ec <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80003450:	fff00513          	li	a0,-1
}
    80003454:	00008067          	ret

0000000080003458 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80003458:	fe010113          	addi	sp,sp,-32
    8000345c:	00113c23          	sd	ra,24(sp)
    80003460:	00813823          	sd	s0,16(sp)
    80003464:	00913423          	sd	s1,8(sp)
    80003468:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    8000346c:	00008497          	auipc	s1,0x8
    80003470:	d644b483          	ld	s1,-668(s1) # 8000b1d0 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80003474:	00005517          	auipc	a0,0x5
    80003478:	eb450513          	addi	a0,a0,-332 # 80008328 <CONSOLE_STATUS+0x318>
    8000347c:	0000b097          	auipc	ra,0xb
    80003480:	7d8080e7          	jalr	2008(ra) # 8000ec54 <_Z11printStringPKc>
    while(iter!=nullptr){
    80003484:	04048663          	beqz	s1,800034d0 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80003488:	00000613          	li	a2,0
    8000348c:	00a00593          	li	a1,10
    80003490:	0004851b          	sext.w	a0,s1
    80003494:	0000c097          	auipc	ra,0xc
    80003498:	958080e7          	jalr	-1704(ra) # 8000edec <_Z8printIntiii>
        putc(' ');
    8000349c:	02000513          	li	a0,32
    800034a0:	0000a097          	auipc	ra,0xa
    800034a4:	e8c080e7          	jalr	-372(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    800034a8:	00000613          	li	a2,0
    800034ac:	00a00593          	li	a1,10
    800034b0:	0004a503          	lw	a0,0(s1)
    800034b4:	0000c097          	auipc	ra,0xc
    800034b8:	938080e7          	jalr	-1736(ra) # 8000edec <_Z8printIntiii>
        putc('\n');
    800034bc:	00a00513          	li	a0,10
    800034c0:	0000a097          	auipc	ra,0xa
    800034c4:	e6c080e7          	jalr	-404(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    800034c8:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800034cc:	fb9ff06f          	j	80003484 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    800034d0:	00005517          	auipc	a0,0x5
    800034d4:	e7850513          	addi	a0,a0,-392 # 80008348 <CONSOLE_STATUS+0x338>
    800034d8:	0000b097          	auipc	ra,0xb
    800034dc:	77c080e7          	jalr	1916(ra) # 8000ec54 <_Z11printStringPKc>
    iter = freeMemHead;
    800034e0:	00008497          	auipc	s1,0x8
    800034e4:	ce04b483          	ld	s1,-800(s1) # 8000b1c0 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    800034e8:	04048663          	beqz	s1,80003534 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    800034ec:	00000613          	li	a2,0
    800034f0:	00a00593          	li	a1,10
    800034f4:	0004851b          	sext.w	a0,s1
    800034f8:	0000c097          	auipc	ra,0xc
    800034fc:	8f4080e7          	jalr	-1804(ra) # 8000edec <_Z8printIntiii>
        putc(' ');
    80003500:	02000513          	li	a0,32
    80003504:	0000a097          	auipc	ra,0xa
    80003508:	e28080e7          	jalr	-472(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    8000350c:	00000613          	li	a2,0
    80003510:	00a00593          	li	a1,10
    80003514:	0004a503          	lw	a0,0(s1)
    80003518:	0000c097          	auipc	ra,0xc
    8000351c:	8d4080e7          	jalr	-1836(ra) # 8000edec <_Z8printIntiii>
        putc('\n');
    80003520:	00a00513          	li	a0,10
    80003524:	0000a097          	auipc	ra,0xa
    80003528:	e08080e7          	jalr	-504(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    8000352c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003530:	fb9ff06f          	j	800034e8 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80003534:	00005517          	auipc	a0,0x5
    80003538:	e3450513          	addi	a0,a0,-460 # 80008368 <CONSOLE_STATUS+0x358>
    8000353c:	0000b097          	auipc	ra,0xb
    80003540:	718080e7          	jalr	1816(ra) # 8000ec54 <_Z11printStringPKc>
}
    80003544:	01813083          	ld	ra,24(sp)
    80003548:	01013403          	ld	s0,16(sp)
    8000354c:	00813483          	ld	s1,8(sp)
    80003550:	02010113          	addi	sp,sp,32
    80003554:	00008067          	ret

0000000080003558 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80003558:	ff010113          	addi	sp,sp,-16
    8000355c:	00813423          	sd	s0,8(sp)
    80003560:	01010413          	addi	s0,sp,16
    80003564:	00050813          	mv	a6,a0
    80003568:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    8000356c:	00000793          	li	a5,0
    80003570:	00c7fe63          	bgeu	a5,a2,8000358c <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80003574:	00f50733          	add	a4,a0,a5
    80003578:	00f806b3          	add	a3,a6,a5
    8000357c:	0006c683          	lbu	a3,0(a3)
    80003580:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80003584:	00178793          	addi	a5,a5,1
    80003588:	fe9ff06f          	j	80003570 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    8000358c:	00813403          	ld	s0,8(sp)
    80003590:	01010113          	addi	sp,sp,16
    80003594:	00008067          	ret

0000000080003598 <_ZN5RiscV10popSppSpieEv>:
    RiscV::startVirtualMemory(RiscV::kPMT);
    RiscV::enableInterrupts();
}

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003598:	ff010113          	addi	sp,sp,-16
    8000359c:	00813423          	sd	s0,8(sp)
    800035a0:	01010413          	addi	s0,sp,16
    uint64 ra = 0;
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    800035a4:	00008797          	auipc	a5,0x8
    800035a8:	a047b783          	ld	a5,-1532(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    800035ac:	0007b783          	ld	a5,0(a5)
    800035b0:	0147a683          	lw	a3,20(a5)
    800035b4:	00100713          	li	a4,1
    800035b8:	02e68863          	beq	a3,a4,800035e8 <_ZN5RiscV10popSppSpieEv+0x50>
        asm("csrw sepc, ra");
    else
    {
        ra = (uint64)bodyWrapper;
        asm("mv a0, %[iarg]" : : [iarg] "r" (TCB::running->body));
    800035bc:	0187b703          	ld	a4,24(a5)
    800035c0:	00070513          	mv	a0,a4
        asm("mv a1, %[iarg]" : : [iarg] "r" (TCB::running->args));
    800035c4:	0207b783          	ld	a5,32(a5)
    800035c8:	00078593          	mv	a1,a5
        asm("csrw sepc, %[ra]" : : [ra] "r" (ra));
    800035cc:	00008797          	auipc	a5,0x8
    800035d0:	9d47b783          	ld	a5,-1580(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800035d4:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    800035d8:	10200073          	sret
}
    800035dc:	00813403          	ld	s0,8(sp)
    800035e0:	01010113          	addi	sp,sp,16
    800035e4:	00008067          	ret
        asm("csrw sepc, ra");
    800035e8:	14109073          	csrw	sepc,ra
    800035ec:	fedff06f          	j	800035d8 <_ZN5RiscV10popSppSpieEv+0x40>

00000000800035f0 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    800035f0:	ff010113          	addi	sp,sp,-16
    800035f4:	00113423          	sd	ra,8(sp)
    800035f8:	00813023          	sd	s0,0(sp)
    800035fc:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003600:	00008797          	auipc	a5,0x8
    80003604:	9a87b783          	ld	a5,-1624(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003608:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    8000360c:	00100713          	li	a4,1
    80003610:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003614:	00000097          	auipc	ra,0x0
    80003618:	8d4080e7          	jalr	-1836(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
}
    8000361c:	00813083          	ld	ra,8(sp)
    80003620:	00013403          	ld	s0,0(sp)
    80003624:	01010113          	addi	sp,sp,16
    80003628:	00008067          	ret

000000008000362c <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    8000362c:	ff010113          	addi	sp,sp,-16
    80003630:	00113423          	sd	ra,8(sp)
    80003634:	00813023          	sd	s0,0(sp)
    80003638:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    8000363c:	00008797          	auipc	a5,0x8
    80003640:	ba47c783          	lbu	a5,-1116(a5) # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    80003644:	00079c63          	bnez	a5,8000365c <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003648:	00008717          	auipc	a4,0x8
    8000364c:	95073703          	ld	a4,-1712(a4) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003650:	00073783          	ld	a5,0(a4)
    80003654:	00178793          	addi	a5,a5,1
    80003658:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    8000365c:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003660:	0ff57513          	andi	a0,a0,255
    80003664:	00002097          	auipc	ra,0x2
    80003668:	918080e7          	jalr	-1768(ra) # 80004f7c <_ZN11ConsoleUtil9putOutputEc>
}
    8000366c:	00813083          	ld	ra,8(sp)
    80003670:	00013403          	ld	s0,0(sp)
    80003674:	01010113          	addi	sp,sp,16
    80003678:	00008067          	ret

000000008000367c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    8000367c:	ff010113          	addi	sp,sp,-16
    80003680:	00813423          	sd	s0,8(sp)
    80003684:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80003688:	00008797          	auipc	a5,0x8
    8000368c:	9207b783          	ld	a5,-1760(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003690:	0007b783          	ld	a5,0(a5)
    80003694:	0147a703          	lw	a4,20(a5)
    80003698:	00100793          	li	a5,1
    8000369c:	02f70a63          	beq	a4,a5,800036d0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x54>
inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sstatus(uint64 mask) {
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    800036a0:	10000793          	li	a5,256
    800036a4:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
        RiscV::startVirtualMemory(RiscV::kPMT);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
        RiscV::startVirtualMemory(RiscV::uPMT);
    800036a8:	00008797          	auipc	a5,0x8
    800036ac:	b487b783          	ld	a5,-1208(a5) # 8000b1f0 <_ZN5RiscV4uPMTE>
inline void RiscV::disableTimerInterrupts(){
    RiscV::mc_sie(SIP_SSIE);
}

inline void RiscV::startVirtualMemory(void* PMT) {
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    800036b0:	00c7d793          	srli	a5,a5,0xc
    800036b4:	fff00713          	li	a4,-1
    800036b8:	03f71713          	slli	a4,a4,0x3f
    800036bc:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    800036c0:	18079073          	csrw	satp,a5
    }
}
    800036c4:	00813403          	ld	s0,8(sp)
    800036c8:	01010113          	addi	sp,sp,16
    800036cc:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800036d0:	10000793          	li	a5,256
    800036d4:	1007a073          	csrs	sstatus,a5
        RiscV::startVirtualMemory(RiscV::kPMT);
    800036d8:	00008797          	auipc	a5,0x8
    800036dc:	b107b783          	ld	a5,-1264(a5) # 8000b1e8 <_ZN5RiscV4kPMTE>
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    800036e0:	00c7d793          	srli	a5,a5,0xc
    800036e4:	fff00713          	li	a4,-1
    800036e8:	03f71713          	slli	a4,a4,0x3f
    800036ec:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    800036f0:	18079073          	csrw	satp,a5
}
    800036f4:	fd1ff06f          	j	800036c4 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x48>

00000000800036f8 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    800036f8:	ff010113          	addi	sp,sp,-16
    800036fc:	00113423          	sd	ra,8(sp)
    80003700:	00813023          	sd	s0,0(sp)
    80003704:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80003708:	00100793          	li	a5,1
    8000370c:	00008717          	auipc	a4,0x8
    80003710:	acf70a23          	sb	a5,-1324(a4) # 8000b1e0 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003714:	00008797          	auipc	a5,0x8
    80003718:	8847b783          	ld	a5,-1916(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000371c:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003720:	00008797          	auipc	a5,0x8
    80003724:	8207b783          	ld	a5,-2016(a5) # 8000af40 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003728:	0007b023          	sd	zero,0(a5)
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    8000372c:	00200793          	li	a5,2
    80003730:	1047b073          	csrc	sie,a5
    80003734:	20000793          	li	a5,512
    80003738:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    8000373c:	00008797          	auipc	a5,0x8
    80003740:	82c7b783          	ld	a5,-2004(a5) # 8000af68 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003744:	0007b783          	ld	a5,0(a5)
    80003748:	00078c63          	beqz	a5,80003760 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    8000374c:	0487b703          	ld	a4,72(a5)
    80003750:	00008797          	auipc	a5,0x8
    80003754:	8187b783          	ld	a5,-2024(a5) # 8000af68 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003758:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    8000375c:	fe1ff06f          	j	8000373c <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003760:	00008797          	auipc	a5,0x8
    80003764:	8107b783          	ld	a5,-2032(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003768:	0007b503          	ld	a0,0(a5)
    8000376c:	00001097          	auipc	ra,0x1
    80003770:	440080e7          	jalr	1088(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003774:	00008797          	auipc	a5,0x8
    80003778:	8147b783          	ld	a5,-2028(a5) # 8000af88 <_GLOBAL_OFFSET_TABLE_+0xa0>
    8000377c:	0007b703          	ld	a4,0(a5)
    80003780:	00008797          	auipc	a5,0x8
    80003784:	8107b783          	ld	a5,-2032(a5) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003788:	0007b783          	ld	a5,0(a5)
    8000378c:	00f70863          	beq	a4,a5,8000379c <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    80003790:	fffff097          	auipc	ra,0xfffff
    80003794:	758080e7          	jalr	1880(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003798:	fddff06f          	j	80003774 <_ZN5RiscV8finalizeEv+0x7c>
}
    8000379c:	00813083          	ld	ra,8(sp)
    800037a0:	00013403          	ld	s0,0(sp)
    800037a4:	01010113          	addi	sp,sp,16
    800037a8:	00008067          	ret

00000000800037ac <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    800037ac:	ff010113          	addi	sp,sp,-16
    800037b0:	00813423          	sd	s0,8(sp)
    800037b4:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    800037b8:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    800037bc:	00007717          	auipc	a4,0x7
    800037c0:	7ec73703          	ld	a4,2028(a4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    800037c4:	00073703          	ld	a4,0(a4)
    800037c8:	06873703          	ld	a4,104(a4)
    800037cc:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    800037d0:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800037d4:	00078593          	mv	a1,a5
}
    800037d8:	00813403          	ld	s0,8(sp)
    800037dc:	01010113          	addi	sp,sp,16
    800037e0:	00008067          	ret

00000000800037e4 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    800037e4:	ff010113          	addi	sp,sp,-16
    800037e8:	00113423          	sd	ra,8(sp)
    800037ec:	00813023          	sd	s0,0(sp)
    800037f0:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    800037f4:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    800037f8:	00000097          	auipc	ra,0x0
    800037fc:	974080e7          	jalr	-1676(ra) # 8000316c <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003800:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003804:	00000097          	auipc	ra,0x0
    80003808:	fa8080e7          	jalr	-88(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    8000380c:	00813083          	ld	ra,8(sp)
    80003810:	00013403          	ld	s0,0(sp)
    80003814:	01010113          	addi	sp,sp,16
    80003818:	00008067          	ret

000000008000381c <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    8000381c:	ff010113          	addi	sp,sp,-16
    80003820:	00113423          	sd	ra,8(sp)
    80003824:	00813023          	sd	s0,0(sp)
    80003828:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    8000382c:	00007797          	auipc	a5,0x7
    80003830:	78c7b783          	ld	a5,1932(a5) # 8000afb8 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80003834:	0007c783          	lbu	a5,0(a5)
    80003838:	02079263          	bnez	a5,8000385c <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    8000383c:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003840:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003844:	00000097          	auipc	ra,0x0
    80003848:	f68080e7          	jalr	-152(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    8000384c:	00813083          	ld	ra,8(sp)
    80003850:	00013403          	ld	s0,0(sp)
    80003854:	01010113          	addi	sp,sp,16
    80003858:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000385c:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003860:	00000097          	auipc	ra,0x0
    80003864:	b44080e7          	jalr	-1212(ra) # 800033a4 <_ZN15MemoryAllocator5kfreeEPv>
    80003868:	fd9ff06f          	j	80003840 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

000000008000386c <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    8000386c:	fc010113          	addi	sp,sp,-64
    80003870:	02113c23          	sd	ra,56(sp)
    80003874:	02813823          	sd	s0,48(sp)
    80003878:	02913423          	sd	s1,40(sp)
    8000387c:	03213023          	sd	s2,32(sp)
    80003880:	01313c23          	sd	s3,24(sp)
    80003884:	01413823          	sd	s4,16(sp)
    80003888:	01513423          	sd	s5,8(sp)
    8000388c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003890:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003894:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003898:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    8000389c:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800038a0:	07000513          	li	a0,112
    800038a4:	fffff097          	auipc	ra,0xfffff
    800038a8:	6c4080e7          	jalr	1732(ra) # 80002f68 <_ZN3TCBnwEm>
    800038ac:	00050493          	mv	s1,a0
    800038b0:	00050e63          	beqz	a0,800038cc <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    800038b4:	00200713          	li	a4,2
    800038b8:	000a8693          	mv	a3,s5
    800038bc:	000a0613          	mv	a2,s4
    800038c0:	00098593          	mv	a1,s3
    800038c4:	fffff097          	auipc	ra,0xfffff
    800038c8:	568080e7          	jalr	1384(ra) # 80002e2c <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800038cc:	04048863          	beqz	s1,8000391c <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    800038d0:	0184b783          	ld	a5,24(s1)
    800038d4:	00078863          	beqz	a5,800038e4 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    800038d8:	00048513          	mv	a0,s1
    800038dc:	00001097          	auipc	ra,0x1
    800038e0:	2d0080e7          	jalr	720(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    800038e4:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800038e8:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800038ec:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800038f0:	00000097          	auipc	ra,0x0
    800038f4:	ebc080e7          	jalr	-324(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    800038f8:	03813083          	ld	ra,56(sp)
    800038fc:	03013403          	ld	s0,48(sp)
    80003900:	02813483          	ld	s1,40(sp)
    80003904:	02013903          	ld	s2,32(sp)
    80003908:	01813983          	ld	s3,24(sp)
    8000390c:	01013a03          	ld	s4,16(sp)
    80003910:	00813a83          	ld	s5,8(sp)
    80003914:	04010113          	addi	sp,sp,64
    80003918:	00008067          	ret
        status = -1;
    8000391c:	fff00793          	li	a5,-1
    80003920:	fcdff06f          	j	800038ec <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    80003924:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003928:	00048513          	mv	a0,s1
    8000392c:	fffff097          	auipc	ra,0xfffff
    80003930:	760080e7          	jalr	1888(ra) # 8000308c <_ZN3TCBdlEPv>
    80003934:	00090513          	mv	a0,s2
    80003938:	00009097          	auipc	ra,0x9
    8000393c:	a00080e7          	jalr	-1536(ra) # 8000c338 <_Unwind_Resume>

0000000080003940 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003940:	fc010113          	addi	sp,sp,-64
    80003944:	02113c23          	sd	ra,56(sp)
    80003948:	02813823          	sd	s0,48(sp)
    8000394c:	02913423          	sd	s1,40(sp)
    80003950:	03213023          	sd	s2,32(sp)
    80003954:	01313c23          	sd	s3,24(sp)
    80003958:	01413823          	sd	s4,16(sp)
    8000395c:	01513423          	sd	s5,8(sp)
    80003960:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003964:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003968:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000396c:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003970:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003974:	07000513          	li	a0,112
    80003978:	fffff097          	auipc	ra,0xfffff
    8000397c:	5f0080e7          	jalr	1520(ra) # 80002f68 <_ZN3TCBnwEm>
    80003980:	00050493          	mv	s1,a0
    80003984:	00050e63          	beqz	a0,800039a0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80003988:	00200713          	li	a4,2
    8000398c:	000a8693          	mv	a3,s5
    80003990:	00090613          	mv	a2,s2
    80003994:	00098593          	mv	a1,s3
    80003998:	fffff097          	auipc	ra,0xfffff
    8000399c:	494080e7          	jalr	1172(ra) # 80002e2c <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800039a0:	04048263          	beqz	s1,800039e4 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    800039a4:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    800039a8:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    800039ac:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    800039b0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800039b4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800039b8:	00000097          	auipc	ra,0x0
    800039bc:	df4080e7          	jalr	-524(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    800039c0:	03813083          	ld	ra,56(sp)
    800039c4:	03013403          	ld	s0,48(sp)
    800039c8:	02813483          	ld	s1,40(sp)
    800039cc:	02013903          	ld	s2,32(sp)
    800039d0:	01813983          	ld	s3,24(sp)
    800039d4:	01013a03          	ld	s4,16(sp)
    800039d8:	00813a83          	ld	s5,8(sp)
    800039dc:	04010113          	addi	sp,sp,64
    800039e0:	00008067          	ret
        status = -1;
    800039e4:	fff00793          	li	a5,-1
    800039e8:	fcdff06f          	j	800039b4 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    800039ec:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800039f0:	00048513          	mv	a0,s1
    800039f4:	fffff097          	auipc	ra,0xfffff
    800039f8:	698080e7          	jalr	1688(ra) # 8000308c <_ZN3TCBdlEPv>
    800039fc:	00090513          	mv	a0,s2
    80003a00:	00009097          	auipc	ra,0x9
    80003a04:	938080e7          	jalr	-1736(ra) # 8000c338 <_Unwind_Resume>

0000000080003a08 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003a08:	ff010113          	addi	sp,sp,-16
    80003a0c:	00113423          	sd	ra,8(sp)
    80003a10:	00813023          	sd	s0,0(sp)
    80003a14:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003a18:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003a1c:	02051263          	bnez	a0,80003a40 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003a20:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a24:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003a28:	00000097          	auipc	ra,0x0
    80003a2c:	d84080e7          	jalr	-636(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a30:	00813083          	ld	ra,8(sp)
    80003a34:	00013403          	ld	s0,0(sp)
    80003a38:	01010113          	addi	sp,sp,16
    80003a3c:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003a40:	00100793          	li	a5,1
    80003a44:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003a48:	00001097          	auipc	ra,0x1
    80003a4c:	164080e7          	jalr	356(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003a50:	fffff097          	auipc	ra,0xfffff
    80003a54:	498080e7          	jalr	1176(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003a58:	00000793          	li	a5,0
    80003a5c:	fc9ff06f          	j	80003a24 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003a60 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003a60:	ff010113          	addi	sp,sp,-16
    80003a64:	00113423          	sd	ra,8(sp)
    80003a68:	00813023          	sd	s0,0(sp)
    80003a6c:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003a70:	00007797          	auipc	a5,0x7
    80003a74:	5387b783          	ld	a5,1336(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003a78:	0007b783          	ld	a5,0(a5)
    80003a7c:	02078a63          	beqz	a5,80003ab0 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003a80:	00200713          	li	a4,2
    80003a84:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003a88:	fffff097          	auipc	ra,0xfffff
    80003a8c:	460080e7          	jalr	1120(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003a90:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a94:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003a98:	00000097          	auipc	ra,0x0
    80003a9c:	d14080e7          	jalr	-748(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003aa0:	00813083          	ld	ra,8(sp)
    80003aa4:	00013403          	ld	s0,0(sp)
    80003aa8:	01010113          	addi	sp,sp,16
    80003aac:	00008067          	ret
        status = -1;
    80003ab0:	fff00793          	li	a5,-1
    80003ab4:	fe1ff06f          	j	80003a94 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003ab8 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003ab8:	fd010113          	addi	sp,sp,-48
    80003abc:	02113423          	sd	ra,40(sp)
    80003ac0:	02813023          	sd	s0,32(sp)
    80003ac4:	00913c23          	sd	s1,24(sp)
    80003ac8:	01213823          	sd	s2,16(sp)
    80003acc:	01313423          	sd	s3,8(sp)
    80003ad0:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003ad4:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003ad8:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    80003adc:	01800513          	li	a0,24
    80003ae0:	fffff097          	auipc	ra,0xfffff
    80003ae4:	1f8080e7          	jalr	504(ra) # 80002cd8 <_ZN3SCBnwEm>
    80003ae8:	00050493          	mv	s1,a0
    80003aec:	00050863          	beqz	a0,80003afc <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    80003af0:	00098593          	mv	a1,s3
    80003af4:	fffff097          	auipc	ra,0xfffff
    80003af8:	030080e7          	jalr	48(ra) # 80002b24 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003afc:	02048a63          	beqz	s1,80003b30 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    80003b00:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80003b04:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b08:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003b0c:	00000097          	auipc	ra,0x0
    80003b10:	ca0080e7          	jalr	-864(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b14:	02813083          	ld	ra,40(sp)
    80003b18:	02013403          	ld	s0,32(sp)
    80003b1c:	01813483          	ld	s1,24(sp)
    80003b20:	01013903          	ld	s2,16(sp)
    80003b24:	00813983          	ld	s3,8(sp)
    80003b28:	03010113          	addi	sp,sp,48
    80003b2c:	00008067          	ret
        status = -1;
    80003b30:	fff00793          	li	a5,-1
    80003b34:	fd5ff06f          	j	80003b08 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    80003b38:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003b3c:	00048513          	mv	a0,s1
    80003b40:	fffff097          	auipc	ra,0xfffff
    80003b44:	1c8080e7          	jalr	456(ra) # 80002d08 <_ZN3SCBdlEPv>
    80003b48:	00090513          	mv	a0,s2
    80003b4c:	00008097          	auipc	ra,0x8
    80003b50:	7ec080e7          	jalr	2028(ra) # 8000c338 <_Unwind_Resume>

0000000080003b54 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003b54:	fe010113          	addi	sp,sp,-32
    80003b58:	00113c23          	sd	ra,24(sp)
    80003b5c:	00813823          	sd	s0,16(sp)
    80003b60:	00913423          	sd	s1,8(sp)
    80003b64:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003b68:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003b6c:	02049463          	bnez	s1,80003b94 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003b70:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b74:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003b78:	00000097          	auipc	ra,0x0
    80003b7c:	c34080e7          	jalr	-972(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b80:	01813083          	ld	ra,24(sp)
    80003b84:	01013403          	ld	s0,16(sp)
    80003b88:	00813483          	ld	s1,8(sp)
    80003b8c:	02010113          	addi	sp,sp,32
    80003b90:	00008067          	ret
        delete (SCB*)ihandle;
    80003b94:	00048513          	mv	a0,s1
    80003b98:	fffff097          	auipc	ra,0xfffff
    80003b9c:	fa8080e7          	jalr	-88(ra) # 80002b40 <_ZN3SCBD1Ev>
    80003ba0:	00048513          	mv	a0,s1
    80003ba4:	fffff097          	auipc	ra,0xfffff
    80003ba8:	164080e7          	jalr	356(ra) # 80002d08 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003bac:	00000793          	li	a5,0
    80003bb0:	fc5ff06f          	j	80003b74 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080003bb4 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80003bb4:	ff010113          	addi	sp,sp,-16
    80003bb8:	00113423          	sd	ra,8(sp)
    80003bbc:	00813023          	sd	s0,0(sp)
    80003bc0:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003bc4:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003bc8:	02051c63          	bnez	a0,80003c00 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80003bcc:	00007797          	auipc	a5,0x7
    80003bd0:	3dc7b783          	ld	a5,988(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003bd4:	0007b783          	ld	a5,0(a5)
    80003bd8:	0607b783          	ld	a5,96(a5)
    80003bdc:	02078863          	beqz	a5,80003c0c <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003be0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003be4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003be8:	00000097          	auipc	ra,0x0
    80003bec:	bc4080e7          	jalr	-1084(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003bf0:	00813083          	ld	ra,8(sp)
    80003bf4:	00013403          	ld	s0,0(sp)
    80003bf8:	01010113          	addi	sp,sp,16
    80003bfc:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003c00:	fffff097          	auipc	ra,0xfffff
    80003c04:	04c080e7          	jalr	76(ra) # 80002c4c <_ZN3SCB4waitEv>
    80003c08:	fc5ff06f          	j	80003bcc <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80003c0c:	00000793          	li	a5,0
    80003c10:	fd5ff06f          	j	80003be4 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003c14 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003c14:	ff010113          	addi	sp,sp,-16
    80003c18:	00113423          	sd	ra,8(sp)
    80003c1c:	00813023          	sd	s0,0(sp)
    80003c20:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003c24:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003c28:	02051263          	bnez	a0,80003c4c <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003c2c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003c30:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003c34:	00000097          	auipc	ra,0x0
    80003c38:	b78080e7          	jalr	-1160(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003c3c:	00813083          	ld	ra,8(sp)
    80003c40:	00013403          	ld	s0,0(sp)
    80003c44:	01010113          	addi	sp,sp,16
    80003c48:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003c4c:	fffff097          	auipc	ra,0xfffff
    80003c50:	050080e7          	jalr	80(ra) # 80002c9c <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003c54:	00000793          	li	a5,0
    80003c58:	fd9ff06f          	j	80003c30 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003c5c <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003c5c:	fe010113          	addi	sp,sp,-32
    80003c60:	00113c23          	sd	ra,24(sp)
    80003c64:	00813823          	sd	s0,16(sp)
    80003c68:	00913423          	sd	s1,8(sp)
    80003c6c:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003c70:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003c74:	00007797          	auipc	a5,0x7
    80003c78:	3347b783          	ld	a5,820(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003c7c:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003c80:	00007797          	auipc	a5,0x7
    80003c84:	5787b783          	ld	a5,1400(a5) # 8000b1f8 <_ZN5RiscV10globalTimeE>
    80003c88:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003c8c:	00e787b3          	add	a5,a5,a4
    80003c90:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003c94:	00048513          	mv	a0,s1
    80003c98:	00001097          	auipc	ra,0x1
    80003c9c:	f90080e7          	jalr	-112(ra) # 80004c28 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003ca0:	00300793          	li	a5,3
    80003ca4:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003ca8:	fffff097          	auipc	ra,0xfffff
    80003cac:	240080e7          	jalr	576(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003cb0:	00000793          	li	a5,0
    80003cb4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003cb8:	00000097          	auipc	ra,0x0
    80003cbc:	af4080e7          	jalr	-1292(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003cc0:	01813083          	ld	ra,24(sp)
    80003cc4:	01013403          	ld	s0,16(sp)
    80003cc8:	00813483          	ld	s1,8(sp)
    80003ccc:	02010113          	addi	sp,sp,32
    80003cd0:	00008067          	ret

0000000080003cd4 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003cd4:	fe010113          	addi	sp,sp,-32
    80003cd8:	00113c23          	sd	ra,24(sp)
    80003cdc:	00813823          	sd	s0,16(sp)
    80003ce0:	00913423          	sd	s1,8(sp)
    80003ce4:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003ce8:	00007797          	auipc	a5,0x7
    80003cec:	4f87c783          	lbu	a5,1272(a5) # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    80003cf0:	00079c63          	bnez	a5,80003d08 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003cf4:	00007717          	auipc	a4,0x7
    80003cf8:	24c73703          	ld	a4,588(a4) # 8000af40 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003cfc:	00073783          	ld	a5,0(a4)
    80003d00:	00178793          	addi	a5,a5,1
    80003d04:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003d08:	00001097          	auipc	ra,0x1
    80003d0c:	204080e7          	jalr	516(ra) # 80004f0c <_ZN11ConsoleUtil8getInputEv>
    80003d10:	00050493          	mv	s1,a0
    if(c==13) {
    80003d14:	00d00793          	li	a5,13
    80003d18:	02f50663          	beq	a0,a5,80003d44 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80003d1c:	01b00793          	li	a5,27
    80003d20:	04f51063          	bne	a0,a5,80003d60 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003d24:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003d28:	00000097          	auipc	ra,0x0
    80003d2c:	a84080e7          	jalr	-1404(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003d30:	01813083          	ld	ra,24(sp)
    80003d34:	01013403          	ld	s0,16(sp)
    80003d38:	00813483          	ld	s1,8(sp)
    80003d3c:	02010113          	addi	sp,sp,32
    80003d40:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003d44:	00d00513          	li	a0,13
    80003d48:	00001097          	auipc	ra,0x1
    80003d4c:	234080e7          	jalr	564(ra) # 80004f7c <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003d50:	00a00513          	li	a0,10
    80003d54:	00001097          	auipc	ra,0x1
    80003d58:	228080e7          	jalr	552(ra) # 80004f7c <_ZN11ConsoleUtil9putOutputEc>
    80003d5c:	fc9ff06f          	j	80003d24 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003d60:	00001097          	auipc	ra,0x1
    80003d64:	21c080e7          	jalr	540(ra) # 80004f7c <_ZN11ConsoleUtil9putOutputEc>
    80003d68:	fbdff06f          	j	80003d24 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003d6c <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003d6c:	ff010113          	addi	sp,sp,-16
    80003d70:	00113423          	sd	ra,8(sp)
    80003d74:	00813023          	sd	s0,0(sp)
    80003d78:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003d7c:	00001097          	auipc	ra,0x1
    80003d80:	298080e7          	jalr	664(ra) # 80005014 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003d84:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003d88:	00000097          	auipc	ra,0x0
    80003d8c:	a24080e7          	jalr	-1500(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003d90:	00813083          	ld	ra,8(sp)
    80003d94:	00013403          	ld	s0,0(sp)
    80003d98:	01010113          	addi	sp,sp,16
    80003d9c:	00008067          	ret

0000000080003da0 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003da0:	fe010113          	addi	sp,sp,-32
    80003da4:	00113c23          	sd	ra,24(sp)
    80003da8:	00813823          	sd	s0,16(sp)
    80003dac:	00913423          	sd	s1,8(sp)
    80003db0:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003db4:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003db8:	02049463          	bnez	s1,80003de0 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003dbc:	fff00793          	li	a5,-1
    80003dc0:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003dc4:	00000097          	auipc	ra,0x0
    80003dc8:	9e8080e7          	jalr	-1560(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003dcc:	01813083          	ld	ra,24(sp)
    80003dd0:	01013403          	ld	s0,16(sp)
    80003dd4:	00813483          	ld	s1,8(sp)
    80003dd8:	02010113          	addi	sp,sp,32
    80003ddc:	00008067          	ret
        kfree(thr->stack);
    80003de0:	0284b503          	ld	a0,40(s1)
    80003de4:	00001097          	auipc	ra,0x1
    80003de8:	59c080e7          	jalr	1436(ra) # 80005380 <_Z5kfreePKv>
        delete thr;
    80003dec:	00048513          	mv	a0,s1
    80003df0:	fffff097          	auipc	ra,0xfffff
    80003df4:	0d0080e7          	jalr	208(ra) # 80002ec0 <_ZN3TCBD1Ev>
    80003df8:	00048513          	mv	a0,s1
    80003dfc:	fffff097          	auipc	ra,0xfffff
    80003e00:	290080e7          	jalr	656(ra) # 8000308c <_ZN3TCBdlEPv>
    80003e04:	fb9ff06f          	j	80003dbc <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080003e08 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003e08:	fe010113          	addi	sp,sp,-32
    80003e0c:	00113c23          	sd	ra,24(sp)
    80003e10:	00813823          	sd	s0,16(sp)
    80003e14:	00913423          	sd	s1,8(sp)
    80003e18:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003e1c:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003e20:	02049463          	bnez	s1,80003e48 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003e24:	fff00793          	li	a5,-1
    80003e28:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003e2c:	00000097          	auipc	ra,0x0
    80003e30:	980080e7          	jalr	-1664(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e34:	01813083          	ld	ra,24(sp)
    80003e38:	01013403          	ld	s0,16(sp)
    80003e3c:	00813483          	ld	s1,8(sp)
    80003e40:	02010113          	addi	sp,sp,32
    80003e44:	00008067          	ret
        delete scb;
    80003e48:	00048513          	mv	a0,s1
    80003e4c:	fffff097          	auipc	ra,0xfffff
    80003e50:	cf4080e7          	jalr	-780(ra) # 80002b40 <_ZN3SCBD1Ev>
    80003e54:	00048513          	mv	a0,s1
    80003e58:	fffff097          	auipc	ra,0xfffff
    80003e5c:	eb0080e7          	jalr	-336(ra) # 80002d08 <_ZN3SCBdlEPv>
    80003e60:	fc5ff06f          	j	80003e24 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003e64 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003e64:	fe010113          	addi	sp,sp,-32
    80003e68:	00113c23          	sd	ra,24(sp)
    80003e6c:	00813823          	sd	s0,16(sp)
    80003e70:	00913423          	sd	s1,8(sp)
    80003e74:	01213023          	sd	s2,0(sp)
    80003e78:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003e7c:	04000513          	li	a0,64
    80003e80:	fffff097          	auipc	ra,0xfffff
    80003e84:	2ec080e7          	jalr	748(ra) # 8000316c <_ZN15MemoryAllocator7kmallocEm>
    80003e88:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003e8c:	00007797          	auipc	a5,0x7
    80003e90:	11c7b783          	ld	a5,284(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003e94:	0007b783          	ld	a5,0(a5)
    80003e98:	00001637          	lui	a2,0x1
    80003e9c:	00050593          	mv	a1,a0
    80003ea0:	0287b503          	ld	a0,40(a5)
    80003ea4:	fffff097          	auipc	ra,0xfffff
    80003ea8:	6b4080e7          	jalr	1716(ra) # 80003558 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003eac:	07000513          	li	a0,112
    80003eb0:	fffff097          	auipc	ra,0xfffff
    80003eb4:	0b8080e7          	jalr	184(ra) # 80002f68 <_ZN3TCBnwEm>
    80003eb8:	00050493          	mv	s1,a0
    80003ebc:	00050e63          	beqz	a0,80003ed8 <_ZN5RiscV18executeForkSyscallEv+0x74>
    80003ec0:	00200713          	li	a4,2
    80003ec4:	00090693          	mv	a3,s2
    80003ec8:	00000613          	li	a2,0
    80003ecc:	00000593          	li	a1,0
    80003ed0:	fffff097          	auipc	ra,0xfffff
    80003ed4:	f5c080e7          	jalr	-164(ra) # 80002e2c <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003ed8:	0a048e63          	beqz	s1,80003f94 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003edc:	00007797          	auipc	a5,0x7
    80003ee0:	0847b783          	ld	a5,132(a5) # 8000af60 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003ee4:	0007b783          	ld	a5,0(a5)
    80003ee8:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003eec:	00007797          	auipc	a5,0x7
    80003ef0:	05c7b783          	ld	a5,92(a5) # 8000af48 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003ef4:	0007b783          	ld	a5,0(a5)
    80003ef8:	00f907b3          	add	a5,s2,a5
    80003efc:	00007717          	auipc	a4,0x7
    80003f00:	0ac73703          	ld	a4,172(a4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003f04:	00073683          	ld	a3,0(a4)
    80003f08:	0286b683          	ld	a3,40(a3)
    80003f0c:	40d787b3          	sub	a5,a5,a3
    80003f10:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003f14:	00073783          	ld	a5,0(a4)
    80003f18:	0687b503          	ld	a0,104(a5)
    80003f1c:	0287b783          	ld	a5,40(a5)
    80003f20:	40f50533          	sub	a0,a0,a5
    80003f24:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003f28:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003f2c:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80003f30:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003f34:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80003f38:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80003f3c:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80003f40:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80003f44:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003f48:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003f4c:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003f50:	00073783          	ld	a5,0(a4)
    80003f54:	0387b703          	ld	a4,56(a5)
    80003f58:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003f5c:	0407b783          	ld	a5,64(a5)
    80003f60:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003f64:	00048513          	mv	a0,s1
    80003f68:	00001097          	auipc	ra,0x1
    80003f6c:	c44080e7          	jalr	-956(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003f70:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003f74:	00000097          	auipc	ra,0x0
    80003f78:	838080e7          	jalr	-1992(ra) # 800037ac <_ZN5RiscV16saveA0toSscratchEv>

}
    80003f7c:	01813083          	ld	ra,24(sp)
    80003f80:	01013403          	ld	s0,16(sp)
    80003f84:	00813483          	ld	s1,8(sp)
    80003f88:	00013903          	ld	s2,0(sp)
    80003f8c:	02010113          	addi	sp,sp,32
    80003f90:	00008067          	ret
        status = -1;
    80003f94:	fff00493          	li	s1,-1
    80003f98:	fd9ff06f          	j	80003f70 <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80003f9c:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003fa0:	00048513          	mv	a0,s1
    80003fa4:	fffff097          	auipc	ra,0xfffff
    80003fa8:	0e8080e7          	jalr	232(ra) # 8000308c <_ZN3TCBdlEPv>
    80003fac:	00090513          	mv	a0,s2
    80003fb0:	00008097          	auipc	ra,0x8
    80003fb4:	388080e7          	jalr	904(ra) # 8000c338 <_Unwind_Resume>

0000000080003fb8 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003fb8:	ff010113          	addi	sp,sp,-16
    80003fbc:	00813423          	sd	s0,8(sp)
    80003fc0:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003fc4:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003fc8:	00878793          	addi	a5,a5,8
    80003fcc:	00007717          	auipc	a4,0x7
    80003fd0:	f9473703          	ld	a4,-108(a4) # 8000af60 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003fd4:	00f73023          	sd	a5,0(a4)
}
    80003fd8:	00813403          	ld	s0,8(sp)
    80003fdc:	01010113          	addi	sp,sp,16
    80003fe0:	00008067          	ret

0000000080003fe4 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003fe4:	f9010113          	addi	sp,sp,-112
    80003fe8:	06113423          	sd	ra,104(sp)
    80003fec:	06813023          	sd	s0,96(sp)
    80003ff0:	04913c23          	sd	s1,88(sp)
    80003ff4:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    80003ff8:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003ffc:	142027f3          	csrr	a5,scause
    80004000:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80004004:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    80004008:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    8000400c:	00007797          	auipc	a5,0x7
    80004010:	f9c7b783          	ld	a5,-100(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004014:	0007b783          	ld	a5,0(a5)
    80004018:	14002773          	csrr	a4,sscratch
    8000401c:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80004020:	fd843703          	ld	a4,-40(s0)
    80004024:	00900793          	li	a5,9
    80004028:	10f70663          	beq	a4,a5,80004134 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    8000402c:	fd843703          	ld	a4,-40(s0)
    80004030:	00800793          	li	a5,8
    80004034:	10f70063          	beq	a4,a5,80004134 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    80004038:	fd843703          	ld	a4,-40(s0)
    8000403c:	fff00793          	li	a5,-1
    80004040:	03f79793          	slli	a5,a5,0x3f
    80004044:	00178793          	addi	a5,a5,1
    80004048:	26f70463          	beq	a4,a5,800042b0 <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    8000404c:	fd843703          	ld	a4,-40(s0)
    80004050:	fff00793          	li	a5,-1
    80004054:	03f79793          	slli	a5,a5,0x3f
    80004058:	00978793          	addi	a5,a5,9
    8000405c:	2ef70263          	beq	a4,a5,80004340 <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    80004060:	fd843703          	ld	a4,-40(s0)
    80004064:	00200793          	li	a5,2
    80004068:	36f70a63          	beq	a4,a5,800043dc <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    8000406c:	00004517          	auipc	a0,0x4
    80004070:	37450513          	addi	a0,a0,884 # 800083e0 <CONSOLE_STATUS+0x3d0>
    80004074:	00001097          	auipc	ra,0x1
    80004078:	010080e7          	jalr	16(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    8000407c:	00004517          	auipc	a0,0x4
    80004080:	37450513          	addi	a0,a0,884 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80004084:	00001097          	auipc	ra,0x1
    80004088:	000080e7          	jalr	ra # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    8000408c:	142027f3          	csrr	a5,scause
    80004090:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80004094:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80004098:	00000613          	li	a2,0
    8000409c:	00a00593          	li	a1,10
    800040a0:	0005051b          	sext.w	a0,a0
    800040a4:	00001097          	auipc	ra,0x1
    800040a8:	024080e7          	jalr	36(ra) # 800050c8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    800040ac:	00004517          	auipc	a0,0x4
    800040b0:	30450513          	addi	a0,a0,772 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800040b4:	00001097          	auipc	ra,0x1
    800040b8:	fd0080e7          	jalr	-48(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800040bc:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800040c0:	00000613          	li	a2,0
    800040c4:	01000593          	li	a1,16
    800040c8:	0005051b          	sext.w	a0,a0
    800040cc:	00001097          	auipc	ra,0x1
    800040d0:	ffc080e7          	jalr	-4(ra) # 800050c8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800040d4:	00004517          	auipc	a0,0x4
    800040d8:	2d450513          	addi	a0,a0,724 # 800083a8 <CONSOLE_STATUS+0x398>
    800040dc:	00001097          	auipc	ra,0x1
    800040e0:	fa8080e7          	jalr	-88(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    800040e4:	01000693          	li	a3,16
    800040e8:	00004617          	auipc	a2,0x4
    800040ec:	2c060613          	addi	a2,a2,704 # 800083a8 <CONSOLE_STATUS+0x398>
    800040f0:	0004859b          	sext.w	a1,s1
    800040f4:	00004517          	auipc	a0,0x4
    800040f8:	30c50513          	addi	a0,a0,780 # 80008400 <CONSOLE_STATUS+0x3f0>
    800040fc:	00001097          	auipc	ra,0x1
    80004100:	0a8080e7          	jalr	168(ra) # 800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80004104:	00007797          	auipc	a5,0x7
    80004108:	ea47b783          	ld	a5,-348(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    8000410c:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004110:	00200713          	li	a4,2
    80004114:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80004118:	00004517          	auipc	a0,0x4
    8000411c:	2f050513          	addi	a0,a0,752 # 80008408 <CONSOLE_STATUS+0x3f8>
    80004120:	00001097          	auipc	ra,0x1
    80004124:	f64080e7          	jalr	-156(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004128:	fffff097          	auipc	ra,0xfffff
    8000412c:	dc0080e7          	jalr	-576(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
    80004130:	0800006f          	j	800041b0 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004134:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004138:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000413c:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80004140:	00478793          	addi	a5,a5,4
    80004144:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    80004148:	00007797          	auipc	a5,0x7
    8000414c:	e607b783          	ld	a5,-416(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004150:	0007b783          	ld	a5,0(a5)
    80004154:	fa043703          	ld	a4,-96(s0)
    80004158:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    8000415c:	f9843703          	ld	a4,-104(s0)
    80004160:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80004164:	00050793          	mv	a5,a0
        switch(syscallID){
    80004168:	06100713          	li	a4,97
    8000416c:	02f76463          	bltu	a4,a5,80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    80004170:	00279793          	slli	a5,a5,0x2
    80004174:	00004717          	auipc	a4,0x4
    80004178:	2a870713          	addi	a4,a4,680 # 8000841c <CONSOLE_STATUS+0x40c>
    8000417c:	00e787b3          	add	a5,a5,a4
    80004180:	0007a783          	lw	a5,0(a5)
    80004184:	00e787b3          	add	a5,a5,a4
    80004188:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    8000418c:	fffff097          	auipc	ra,0xfffff
    80004190:	658080e7          	jalr	1624(ra) # 800037e4 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004194:	00007797          	auipc	a5,0x7
    80004198:	e147b783          	ld	a5,-492(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    8000419c:	0007b783          	ld	a5,0(a5)
    800041a0:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800041a4:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    800041a8:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800041ac:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    800041b0:	fffff097          	auipc	ra,0xfffff
    800041b4:	4cc080e7          	jalr	1228(ra) # 8000367c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    800041b8:	06813083          	ld	ra,104(sp)
    800041bc:	06013403          	ld	s0,96(sp)
    800041c0:	05813483          	ld	s1,88(sp)
    800041c4:	07010113          	addi	sp,sp,112
    800041c8:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    800041cc:	fffff097          	auipc	ra,0xfffff
    800041d0:	650080e7          	jalr	1616(ra) # 8000381c <_ZN5RiscV21executeMemFreeSyscallEv>
    800041d4:	fc1ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    800041d8:	fffff097          	auipc	ra,0xfffff
    800041dc:	694080e7          	jalr	1684(ra) # 8000386c <_ZN5RiscV26executeThreadCreateSyscallEv>
    800041e0:	fb5ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    800041e4:	00000097          	auipc	ra,0x0
    800041e8:	87c080e7          	jalr	-1924(ra) # 80003a60 <_ZN5RiscV24executeThreadExitSyscallEv>
    800041ec:	fa9ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    800041f0:	fffff097          	auipc	ra,0xfffff
    800041f4:	400080e7          	jalr	1024(ra) # 800035f0 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    800041f8:	f9dff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    800041fc:	fffff097          	auipc	ra,0xfffff
    80004200:	744080e7          	jalr	1860(ra) # 80003940 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004204:	f91ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    80004208:	00000097          	auipc	ra,0x0
    8000420c:	800080e7          	jalr	-2048(ra) # 80003a08 <_ZN5RiscV25executeThreadStartSyscallEv>
    80004210:	f85ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80004214:	00000097          	auipc	ra,0x0
    80004218:	8a4080e7          	jalr	-1884(ra) # 80003ab8 <_ZN5RiscV21executeSemOpenSyscallEv>
    8000421c:	f79ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    80004220:	00000097          	auipc	ra,0x0
    80004224:	934080e7          	jalr	-1740(ra) # 80003b54 <_ZN5RiscV22executeSemCloseSyscallEv>
    80004228:	f6dff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    8000422c:	00000097          	auipc	ra,0x0
    80004230:	988080e7          	jalr	-1656(ra) # 80003bb4 <_ZN5RiscV21executeSemWaitSyscallEv>
    80004234:	f61ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    80004238:	00000097          	auipc	ra,0x0
    8000423c:	9dc080e7          	jalr	-1572(ra) # 80003c14 <_ZN5RiscV23executeSemSignalSyscallEv>
    80004240:	f55ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    80004244:	00000097          	auipc	ra,0x0
    80004248:	a18080e7          	jalr	-1512(ra) # 80003c5c <_ZN5RiscV23executeTimeSleepSyscallEv>
    8000424c:	f49ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    80004250:	00000097          	auipc	ra,0x0
    80004254:	a84080e7          	jalr	-1404(ra) # 80003cd4 <_ZN5RiscV18executeGetcSyscallEv>
    80004258:	f3dff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    8000425c:	fffff097          	auipc	ra,0xfffff
    80004260:	3d0080e7          	jalr	976(ra) # 8000362c <_ZN5RiscV18executePutcSyscallEv>
    80004264:	f31ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    80004268:	00000097          	auipc	ra,0x0
    8000426c:	b04080e7          	jalr	-1276(ra) # 80003d6c <_ZN5RiscV22executePutcUtilSyscallEv>
    80004270:	f25ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    80004274:	00000097          	auipc	ra,0x0
    80004278:	b2c080e7          	jalr	-1236(ra) # 80003da0 <_ZN5RiscV24executeThreadFreeSyscallEv>
    8000427c:	f19ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004280:	00000097          	auipc	ra,0x0
    80004284:	b88080e7          	jalr	-1144(ra) # 80003e08 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004288:	f0dff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    8000428c:	00010793          	mv	a5,sp
    80004290:	00007717          	auipc	a4,0x7
    80004294:	cb873703          	ld	a4,-840(a4) # 8000af48 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004298:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    8000429c:	00000097          	auipc	ra,0x0
    800042a0:	d1c080e7          	jalr	-740(ra) # 80003fb8 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    800042a4:	00000097          	auipc	ra,0x0
    800042a8:	bc0080e7          	jalr	-1088(ra) # 80003e64 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    800042ac:	ee9ff06f          	j	80004194 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800042b0:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800042b4:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800042b8:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800042bc:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    800042c0:	00200793          	li	a5,2
    800042c4:	1447b073          	csrc	sip,a5
        globalTime += 1;
    800042c8:	00007717          	auipc	a4,0x7
    800042cc:	f1870713          	addi	a4,a4,-232 # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    800042d0:	01873783          	ld	a5,24(a4)
    800042d4:	00178793          	addi	a5,a5,1
    800042d8:	00f73c23          	sd	a5,24(a4)
        Scheduler::awake();
    800042dc:	00001097          	auipc	ra,0x1
    800042e0:	9a4080e7          	jalr	-1628(ra) # 80004c80 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    800042e4:	00007717          	auipc	a4,0x7
    800042e8:	c2c73703          	ld	a4,-980(a4) # 8000af10 <_GLOBAL_OFFSET_TABLE_+0x28>
    800042ec:	00073783          	ld	a5,0(a4)
    800042f0:	00178793          	addi	a5,a5,1
    800042f4:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    800042f8:	00007717          	auipc	a4,0x7
    800042fc:	cb073703          	ld	a4,-848(a4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004300:	00073703          	ld	a4,0(a4)
    80004304:	03073683          	ld	a3,48(a4)
    80004308:	00d7fc63          	bgeu	a5,a3,80004320 <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    8000430c:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004310:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004314:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004318:	14179073          	csrw	sepc,a5
}
    8000431c:	e95ff06f          	j	800041b0 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    80004320:	00007797          	auipc	a5,0x7
    80004324:	bf07b783          	ld	a5,-1040(a5) # 8000af10 <_GLOBAL_OFFSET_TABLE_+0x28>
    80004328:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    8000432c:	00100793          	li	a5,1
    80004330:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80004334:	fffff097          	auipc	ra,0xfffff
    80004338:	bb4080e7          	jalr	-1100(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
    8000433c:	fd1ff06f          	j	8000430c <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004340:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004344:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004348:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    8000434c:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    80004350:	00007797          	auipc	a5,0x7
    80004354:	ba87b783          	ld	a5,-1112(a5) # 8000aef8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004358:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    8000435c:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004360:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004364:	00058793          	mv	a5,a1
        if(status & 1UL)
    80004368:	0017f793          	andi	a5,a5,1
    8000436c:	02078863          	beqz	a5,8000439c <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    80004370:	00007797          	auipc	a5,0x7
    80004374:	bc87b783          	ld	a5,-1080(a5) # 8000af38 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004378:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    8000437c:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004380:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004384:	00058513          	mv	a0,a1
    80004388:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    8000438c:	00007797          	auipc	a5,0x7
    80004390:	bb47b783          	ld	a5,-1100(a5) # 8000af40 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004394:	0007b783          	ld	a5,0(a5)
    80004398:	02079463          	bnez	a5,800043c0 <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    8000439c:	00002097          	auipc	ra,0x2
    800043a0:	868080e7          	jalr	-1944(ra) # 80005c04 <plic_claim>
    800043a4:	00002097          	auipc	ra,0x2
    800043a8:	898080e7          	jalr	-1896(ra) # 80005c3c <plic_complete>
        RiscV::w_sstatus(sstatus);
    800043ac:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800043b0:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    800043b4:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800043b8:	14179073          	csrw	sepc,a5
}
    800043bc:	df5ff06f          	j	800041b0 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    800043c0:	fff78793          	addi	a5,a5,-1
    800043c4:	00007717          	auipc	a4,0x7
    800043c8:	b7c73703          	ld	a4,-1156(a4) # 8000af40 <_GLOBAL_OFFSET_TABLE_+0x58>
    800043cc:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    800043d0:	00001097          	auipc	ra,0x1
    800043d4:	abc080e7          	jalr	-1348(ra) # 80004e8c <_ZN11ConsoleUtil8putInputEc>
    800043d8:	fc5ff06f          	j	8000439c <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    800043dc:	00007797          	auipc	a5,0x7
    800043e0:	bcc7b783          	ld	a5,-1076(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    800043e4:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800043e8:	00200713          	li	a4,2
    800043ec:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    800043f0:	00004517          	auipc	a0,0x4
    800043f4:	fc050513          	addi	a0,a0,-64 # 800083b0 <CONSOLE_STATUS+0x3a0>
    800043f8:	00001097          	auipc	ra,0x1
    800043fc:	c8c080e7          	jalr	-884(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004400:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004404:	00000613          	li	a2,0
    80004408:	01000593          	li	a1,16
    8000440c:	0005051b          	sext.w	a0,a0
    80004410:	00001097          	auipc	ra,0x1
    80004414:	cb8080e7          	jalr	-840(ra) # 800050c8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004418:	00004517          	auipc	a0,0x4
    8000441c:	f9050513          	addi	a0,a0,-112 # 800083a8 <CONSOLE_STATUS+0x398>
    80004420:	00001097          	auipc	ra,0x1
    80004424:	c64080e7          	jalr	-924(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80004428:	00004517          	auipc	a0,0x4
    8000442c:	f9050513          	addi	a0,a0,-112 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80004430:	00001097          	auipc	ra,0x1
    80004434:	c54080e7          	jalr	-940(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004438:	fffff097          	auipc	ra,0xfffff
    8000443c:	ab0080e7          	jalr	-1360(ra) # 80002ee8 <_ZN3TCB8dispatchEv>
    80004440:	d71ff06f          	j	800041b0 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

0000000080004444 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    80004444:	fd010113          	addi	sp,sp,-48
    80004448:	02113423          	sd	ra,40(sp)
    8000444c:	02813023          	sd	s0,32(sp)
    80004450:	00913c23          	sd	s1,24(sp)
    80004454:	01213823          	sd	s2,16(sp)
    80004458:	01313423          	sd	s3,8(sp)
    8000445c:	03010413          	addi	s0,sp,48
    80004460:	00050913          	mv	s2,a0
    80004464:	00058493          	mv	s1,a1
    80004468:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    8000446c:	00058e63          	beqz	a1,80004488 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80004470:	04000513          	li	a0,64
    80004474:	fffff097          	auipc	ra,0xfffff
    80004478:	cf8080e7          	jalr	-776(ra) # 8000316c <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    8000447c:	00051863          	bnez	a0,8000448c <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    80004480:	00093023          	sd	zero,0(s2)
            return;
    80004484:	0200006f          	j	800044a4 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    80004488:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    8000448c:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80004490:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80004494:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80004498:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    8000449c:	01100513          	li	a0,17

    asm("ecall");
    800044a0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    800044a4:	02813083          	ld	ra,40(sp)
    800044a8:	02013403          	ld	s0,32(sp)
    800044ac:	01813483          	ld	s1,24(sp)
    800044b0:	01013903          	ld	s2,16(sp)
    800044b4:	00813983          	ld	s3,8(sp)
    800044b8:	03010113          	addi	sp,sp,48
    800044bc:	00008067          	ret

00000000800044c0 <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    800044c0:	ff010113          	addi	sp,sp,-16
    800044c4:	00813423          	sd	s0,8(sp)
    800044c8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    800044cc:	01200513          	li	a0,18

    asm("ecall");
    800044d0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    800044d4:	00813403          	ld	s0,8(sp)
    800044d8:	01010113          	addi	sp,sp,16
    800044dc:	00008067          	ret

00000000800044e0 <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    800044e0:	ff010113          	addi	sp,sp,-16
    800044e4:	00813423          	sd	s0,8(sp)
    800044e8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    800044ec:	01300513          	li	a0,19

    asm("ecall");
    800044f0:	00000073          	ecall
}
    800044f4:	00813403          	ld	s0,8(sp)
    800044f8:	01010113          	addi	sp,sp,16
    800044fc:	00008067          	ret

0000000080004500 <_ZN5RiscV11putcWrapperEPv>:
{
    80004500:	fe010113          	addi	sp,sp,-32
    80004504:	00113c23          	sd	ra,24(sp)
    80004508:	00813823          	sd	s0,16(sp)
    8000450c:	02010413          	addi	s0,sp,32
    80004510:	00c0006f          	j	8000451c <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    80004514:	00000097          	auipc	ra,0x0
    80004518:	fcc080e7          	jalr	-52(ra) # 800044e0 <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    8000451c:	00007797          	auipc	a5,0x7
    80004520:	9dc7b783          	ld	a5,-1572(a5) # 8000aef8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004524:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004528:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    8000452c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004530:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80004534:	0207f793          	andi	a5,a5,32
    80004538:	fc078ee3          	beqz	a5,80004514 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    8000453c:	00001097          	auipc	ra,0x1
    80004540:	cd4080e7          	jalr	-812(ra) # 80005210 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80004544:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80004548:	00007797          	auipc	a5,0x7
    8000454c:	9a87b783          	ld	a5,-1624(a5) # 8000aef0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80004550:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80004554:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80004558:	fef44783          	lbu	a5,-17(s0)
    8000455c:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80004560:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80004564:	00007797          	auipc	a5,0x7
    80004568:	a347b783          	ld	a5,-1484(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000456c:	0007b783          	ld	a5,0(a5)
    80004570:	fa0786e3          	beqz	a5,8000451c <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80004574:	fff78793          	addi	a5,a5,-1
    80004578:	00007717          	auipc	a4,0x7
    8000457c:	a2073703          	ld	a4,-1504(a4) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80004580:	00f73023          	sd	a5,0(a4)
    80004584:	f99ff06f          	j	8000451c <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080004588 <_ZN5RiscV6getPMTEv>:

    RiscV::mapConsoleRegisters(uPMT);
    RiscV::ms_sstatus(1<<18);
}

void* RiscV::getPMT(){
    80004588:	ff010113          	addi	sp,sp,-16
    8000458c:	00113423          	sd	ra,8(sp)
    80004590:	00813023          	sd	s0,0(sp)
    80004594:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    80004598:	00100513          	li	a0,1
    8000459c:	ffffe097          	auipc	ra,0xffffe
    800045a0:	358080e7          	jalr	856(ra) # 800028f4 <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    800045a4:	00000793          	li	a5,0
    800045a8:	1ff00713          	li	a4,511
    800045ac:	00f74c63          	blt	a4,a5,800045c4 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    800045b0:	00379713          	slli	a4,a5,0x3
    800045b4:	00e50733          	add	a4,a0,a4
    800045b8:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    800045bc:	0017879b          	addiw	a5,a5,1
    800045c0:	fe9ff06f          	j	800045a8 <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    800045c4:	00813083          	ld	ra,8(sp)
    800045c8:	00013403          	ld	s0,0(sp)
    800045cc:	01010113          	addi	sp,sp,16
    800045d0:	00008067          	ret

00000000800045d4 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    800045d4:	fc010113          	addi	sp,sp,-64
    800045d8:	02113c23          	sd	ra,56(sp)
    800045dc:	02813823          	sd	s0,48(sp)
    800045e0:	02913423          	sd	s1,40(sp)
    800045e4:	03213023          	sd	s2,32(sp)
    800045e8:	01313c23          	sd	s3,24(sp)
    800045ec:	01413823          	sd	s4,16(sp)
    800045f0:	01513423          	sd	s5,8(sp)
    800045f4:	04010413          	addi	s0,sp,64
    800045f8:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    800045fc:	01e5d793          	srli	a5,a1,0x1e
    80004600:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    80004604:	0155d913          	srli	s2,a1,0x15
    80004608:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    8000460c:	00c5d493          	srli	s1,a1,0xc
    80004610:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80004614:	00379793          	slli	a5,a5,0x3
    80004618:	00f50ab3          	add	s5,a0,a5
    8000461c:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80004620:	06078263          	beqz	a5,80004684 <_ZN5RiscV15handlePageFaultEPvmm+0xb0>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80004624:	00a7d513          	srli	a0,a5,0xa
    80004628:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    8000462c:	00391913          	slli	s2,s2,0x3
    80004630:	01250933          	add	s2,a0,s2
    80004634:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    80004638:	06050463          	beqz	a0,800046a0 <_ZN5RiscV15handlePageFaultEPvmm+0xcc>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    8000463c:	00a55513          	srli	a0,a0,0xa
    80004640:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    80004644:	003a1a13          	slli	s4,s4,0x3
    80004648:	01450533          	add	a0,a0,s4
    8000464c:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0) {
    80004650:	00079863          	bnez	a5,80004660 <_ZN5RiscV15handlePageFaultEPvmm+0x8c>
        ((uint64 *) pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    80004654:	00a49493          	slli	s1,s1,0xa
    80004658:	0134e9b3          	or	s3,s1,s3
    8000465c:	01353023          	sd	s3,0(a0)
    }
}
    80004660:	03813083          	ld	ra,56(sp)
    80004664:	03013403          	ld	s0,48(sp)
    80004668:	02813483          	ld	s1,40(sp)
    8000466c:	02013903          	ld	s2,32(sp)
    80004670:	01813983          	ld	s3,24(sp)
    80004674:	01013a03          	ld	s4,16(sp)
    80004678:	00813a83          	ld	s5,8(sp)
    8000467c:	04010113          	addi	sp,sp,64
    80004680:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80004684:	00000097          	auipc	ra,0x0
    80004688:	f04080e7          	jalr	-252(ra) # 80004588 <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    8000468c:	00c55793          	srli	a5,a0,0xc
    80004690:	00a79793          	slli	a5,a5,0xa
    80004694:	0017e793          	ori	a5,a5,1
    80004698:	00fab023          	sd	a5,0(s5)
    8000469c:	f91ff06f          	j	8000462c <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    800046a0:	00000097          	auipc	ra,0x0
    800046a4:	ee8080e7          	jalr	-280(ra) # 80004588 <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    800046a8:	00c55793          	srli	a5,a0,0xc
    800046ac:	00a79793          	slli	a5,a5,0xa
    800046b0:	0017e793          	ori	a5,a5,1
    800046b4:	00f93023          	sd	a5,0(s2)
    800046b8:	f8dff06f          	j	80004644 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

00000000800046bc <_ZN5RiscV12buildSectionEPvmmm>:
void RiscV::buildSection(void *PMT, uint64 start, uint64 end, uint64 mask) {
    800046bc:	fd010113          	addi	sp,sp,-48
    800046c0:	02113423          	sd	ra,40(sp)
    800046c4:	02813023          	sd	s0,32(sp)
    800046c8:	00913c23          	sd	s1,24(sp)
    800046cc:	01213823          	sd	s2,16(sp)
    800046d0:	01313423          	sd	s3,8(sp)
    800046d4:	01413023          	sd	s4,0(sp)
    800046d8:	03010413          	addi	s0,sp,48
    800046dc:	00050a13          	mv	s4,a0
    800046e0:	00058493          	mv	s1,a1
    800046e4:	00060913          	mv	s2,a2
    800046e8:	00068993          	mv	s3,a3
    for(uint64 i=start;i< end;i+=0x1000) {
    800046ec:	0324f263          	bgeu	s1,s2,80004710 <_ZN5RiscV12buildSectionEPvmmm+0x54>
        handlePageFault(PMT,i, mask);
    800046f0:	00098613          	mv	a2,s3
    800046f4:	00048593          	mv	a1,s1
    800046f8:	000a0513          	mv	a0,s4
    800046fc:	00000097          	auipc	ra,0x0
    80004700:	ed8080e7          	jalr	-296(ra) # 800045d4 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=start;i< end;i+=0x1000) {
    80004704:	000017b7          	lui	a5,0x1
    80004708:	00f484b3          	add	s1,s1,a5
    8000470c:	fe1ff06f          	j	800046ec <_ZN5RiscV12buildSectionEPvmmm+0x30>
}
    80004710:	02813083          	ld	ra,40(sp)
    80004714:	02013403          	ld	s0,32(sp)
    80004718:	01813483          	ld	s1,24(sp)
    8000471c:	01013903          	ld	s2,16(sp)
    80004720:	00813983          	ld	s3,8(sp)
    80004724:	00013a03          	ld	s4,0(sp)
    80004728:	03010113          	addi	sp,sp,48
    8000472c:	00008067          	ret

0000000080004730 <_ZN5RiscV19mapConsoleRegistersEPv>:

void RiscV::mapConsoleRegisters(void *PMT) {
    80004730:	fe010113          	addi	sp,sp,-32
    80004734:	00113c23          	sd	ra,24(sp)
    80004738:	00813823          	sd	s0,16(sp)
    8000473c:	00913423          	sd	s1,8(sp)
    80004740:	02010413          	addi	s0,sp,32
    80004744:	00050493          	mv	s1,a0
    handlePageFault(PMT, (uint64)CONSOLE_RX_DATA,0xf);
    80004748:	00f00613          	li	a2,15
    8000474c:	00006797          	auipc	a5,0x6
    80004750:	7a47b783          	ld	a5,1956(a5) # 8000aef0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80004754:	0007b583          	ld	a1,0(a5)
    80004758:	00000097          	auipc	ra,0x0
    8000475c:	e7c080e7          	jalr	-388(ra) # 800045d4 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_TX_DATA,0xf);
    80004760:	00f00613          	li	a2,15
    80004764:	00006797          	auipc	a5,0x6
    80004768:	7d47b783          	ld	a5,2004(a5) # 8000af38 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000476c:	0007b583          	ld	a1,0(a5)
    80004770:	00048513          	mv	a0,s1
    80004774:	00000097          	auipc	ra,0x0
    80004778:	e60080e7          	jalr	-416(ra) # 800045d4 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_STATUS,0xf);
    8000477c:	00f00613          	li	a2,15
    80004780:	00006797          	auipc	a5,0x6
    80004784:	7787b783          	ld	a5,1912(a5) # 8000aef8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004788:	0007b583          	ld	a1,0(a5)
    8000478c:	00048513          	mv	a0,s1
    80004790:	00000097          	auipc	ra,0x0
    80004794:	e44080e7          	jalr	-444(ra) # 800045d4 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)0xc201004,0xf);
    80004798:	00f00613          	li	a2,15
    8000479c:	0c2015b7          	lui	a1,0xc201
    800047a0:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    800047a4:	00048513          	mv	a0,s1
    800047a8:	00000097          	auipc	ra,0x0
    800047ac:	e2c080e7          	jalr	-468(ra) # 800045d4 <_ZN5RiscV15handlePageFaultEPvmm>
    800047b0:	01813083          	ld	ra,24(sp)
    800047b4:	01013403          	ld	s0,16(sp)
    800047b8:	00813483          	ld	s1,8(sp)
    800047bc:	02010113          	addi	sp,sp,32
    800047c0:	00008067          	ret

00000000800047c4 <_ZN5RiscV14buildKernelPMTEv>:
void RiscV::buildKernelPMT() {
    800047c4:	fd010113          	addi	sp,sp,-48
    800047c8:	02113423          	sd	ra,40(sp)
    800047cc:	02813023          	sd	s0,32(sp)
    800047d0:	00913c23          	sd	s1,24(sp)
    800047d4:	01213823          	sd	s2,16(sp)
    800047d8:	01313423          	sd	s3,8(sp)
    800047dc:	01413023          	sd	s4,0(sp)
    800047e0:	03010413          	addi	s0,sp,48
    RiscV::kPMT = RiscV::getPMT();
    800047e4:	00000097          	auipc	ra,0x0
    800047e8:	da4080e7          	jalr	-604(ra) # 80004588 <_ZN5RiscV6getPMTEv>
    800047ec:	00007497          	auipc	s1,0x7
    800047f0:	9f448493          	addi	s1,s1,-1548 # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    800047f4:	00a4b423          	sd	a0,8(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    800047f8:	00006797          	auipc	a5,0x6
    800047fc:	7287b783          	ld	a5,1832(a5) # 8000af20 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004800:	0007b903          	ld	s2,0(a5)
    80004804:	00c91913          	slli	s2,s2,0xc
    80004808:	00006797          	auipc	a5,0x6
    8000480c:	7287b783          	ld	a5,1832(a5) # 8000af30 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004810:	0007b783          	ld	a5,0(a5)
    80004814:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(kPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80004818:	00006a17          	auipc	s4,0x6
    8000481c:	6f0a3a03          	ld	s4,1776(s4) # 8000af08 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004820:	00b00693          	li	a3,11
    80004824:	000a0613          	mv	a2,s4
    80004828:	00100593          	li	a1,1
    8000482c:	01f59593          	slli	a1,a1,0x1f
    80004830:	00000097          	auipc	ra,0x0
    80004834:	e8c080e7          	jalr	-372(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80004838:	00006997          	auipc	s3,0x6
    8000483c:	7789b983          	ld	s3,1912(s3) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80004840:	00700693          	li	a3,7
    80004844:	00098613          	mv	a2,s3
    80004848:	000a0593          	mv	a1,s4
    8000484c:	0084b503          	ld	a0,8(s1)
    80004850:	00000097          	auipc	ra,0x0
    80004854:	e6c080e7          	jalr	-404(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80004858:	00006a17          	auipc	s4,0x6
    8000485c:	778a3a03          	ld	s4,1912(s4) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0xe8>
    80004860:	01b00693          	li	a3,27
    80004864:	000a0613          	mv	a2,s4
    80004868:	00098593          	mv	a1,s3
    8000486c:	0084b503          	ld	a0,8(s1)
    80004870:	00000097          	auipc	ra,0x0
    80004874:	e4c080e7          	jalr	-436(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80004878:	00006997          	auipc	s3,0x6
    8000487c:	6a09b983          	ld	s3,1696(s3) # 8000af18 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004880:	01700693          	li	a3,23
    80004884:	00098613          	mv	a2,s3
    80004888:	000a0593          	mv	a1,s4
    8000488c:	0084b503          	ld	a0,8(s1)
    80004890:	00000097          	auipc	ra,0x0
    80004894:	e2c080e7          	jalr	-468(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_END, bEnd, 0x7);
    80004898:	00700693          	li	a3,7
    8000489c:	00090613          	mv	a2,s2
    800048a0:	00098593          	mv	a1,s3
    800048a4:	0084b503          	ld	a0,8(s1)
    800048a8:	00000097          	auipc	ra,0x0
    800048ac:	e14080e7          	jalr	-492(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, bEnd, HEAP_END, 0x17);
    800048b0:	01700693          	li	a3,23
    800048b4:	00006797          	auipc	a5,0x6
    800048b8:	70c7b783          	ld	a5,1804(a5) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    800048bc:	0007b603          	ld	a2,0(a5)
    800048c0:	00090593          	mv	a1,s2
    800048c4:	0084b503          	ld	a0,8(s1)
    800048c8:	00000097          	auipc	ra,0x0
    800048cc:	df4080e7          	jalr	-524(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(kPMT);
    800048d0:	0084b503          	ld	a0,8(s1)
    800048d4:	00000097          	auipc	ra,0x0
    800048d8:	e5c080e7          	jalr	-420(ra) # 80004730 <_ZN5RiscV19mapConsoleRegistersEPv>
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800048dc:	000407b7          	lui	a5,0x40
    800048e0:	1007a073          	csrs	sstatus,a5
}
    800048e4:	02813083          	ld	ra,40(sp)
    800048e8:	02013403          	ld	s0,32(sp)
    800048ec:	01813483          	ld	s1,24(sp)
    800048f0:	01013903          	ld	s2,16(sp)
    800048f4:	00813983          	ld	s3,8(sp)
    800048f8:	00013a03          	ld	s4,0(sp)
    800048fc:	03010113          	addi	sp,sp,48
    80004900:	00008067          	ret

0000000080004904 <_ZN5RiscV12buildUserPMTEv>:
void RiscV::buildUserPMT() {
    80004904:	fd010113          	addi	sp,sp,-48
    80004908:	02113423          	sd	ra,40(sp)
    8000490c:	02813023          	sd	s0,32(sp)
    80004910:	00913c23          	sd	s1,24(sp)
    80004914:	01213823          	sd	s2,16(sp)
    80004918:	01313423          	sd	s3,8(sp)
    8000491c:	01413023          	sd	s4,0(sp)
    80004920:	03010413          	addi	s0,sp,48
    RiscV::uPMT = RiscV::getPMT();
    80004924:	00000097          	auipc	ra,0x0
    80004928:	c64080e7          	jalr	-924(ra) # 80004588 <_ZN5RiscV6getPMTEv>
    8000492c:	00007497          	auipc	s1,0x7
    80004930:	8b448493          	addi	s1,s1,-1868 # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    80004934:	00a4b823          	sd	a0,16(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80004938:	00006797          	auipc	a5,0x6
    8000493c:	5e87b783          	ld	a5,1512(a5) # 8000af20 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004940:	0007b903          	ld	s2,0(a5)
    80004944:	00c91913          	slli	s2,s2,0xc
    80004948:	00006797          	auipc	a5,0x6
    8000494c:	5e87b783          	ld	a5,1512(a5) # 8000af30 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004950:	0007b783          	ld	a5,0(a5)
    80004954:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(uPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80004958:	00006a17          	auipc	s4,0x6
    8000495c:	5b0a3a03          	ld	s4,1456(s4) # 8000af08 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004960:	00b00693          	li	a3,11
    80004964:	000a0613          	mv	a2,s4
    80004968:	00100593          	li	a1,1
    8000496c:	01f59593          	slli	a1,a1,0x1f
    80004970:	00000097          	auipc	ra,0x0
    80004974:	d4c080e7          	jalr	-692(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80004978:	00006997          	auipc	s3,0x6
    8000497c:	6389b983          	ld	s3,1592(s3) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80004980:	00700693          	li	a3,7
    80004984:	00098613          	mv	a2,s3
    80004988:	000a0593          	mv	a1,s4
    8000498c:	0104b503          	ld	a0,16(s1)
    80004990:	00000097          	auipc	ra,0x0
    80004994:	d2c080e7          	jalr	-724(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80004998:	00006a17          	auipc	s4,0x6
    8000499c:	638a3a03          	ld	s4,1592(s4) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0xe8>
    800049a0:	01b00693          	li	a3,27
    800049a4:	000a0613          	mv	a2,s4
    800049a8:	00098593          	mv	a1,s3
    800049ac:	0104b503          	ld	a0,16(s1)
    800049b0:	00000097          	auipc	ra,0x0
    800049b4:	d0c080e7          	jalr	-756(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_START, USER_DATA_END, 0x17);
    800049b8:	00006997          	auipc	s3,0x6
    800049bc:	5609b983          	ld	s3,1376(s3) # 8000af18 <_GLOBAL_OFFSET_TABLE_+0x30>
    800049c0:	01700693          	li	a3,23
    800049c4:	00098613          	mv	a2,s3
    800049c8:	000a0593          	mv	a1,s4
    800049cc:	0104b503          	ld	a0,16(s1)
    800049d0:	00000097          	auipc	ra,0x0
    800049d4:	cec080e7          	jalr	-788(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_END, bEnd, 0x7);
    800049d8:	00700693          	li	a3,7
    800049dc:	00090613          	mv	a2,s2
    800049e0:	00098593          	mv	a1,s3
    800049e4:	0104b503          	ld	a0,16(s1)
    800049e8:	00000097          	auipc	ra,0x0
    800049ec:	cd4080e7          	jalr	-812(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, bEnd, HEAP_END, 0x17);
    800049f0:	01700693          	li	a3,23
    800049f4:	00006797          	auipc	a5,0x6
    800049f8:	5cc7b783          	ld	a5,1484(a5) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    800049fc:	0007b603          	ld	a2,0(a5)
    80004a00:	00090593          	mv	a1,s2
    80004a04:	0104b503          	ld	a0,16(s1)
    80004a08:	00000097          	auipc	ra,0x0
    80004a0c:	cb4080e7          	jalr	-844(ra) # 800046bc <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(uPMT);
    80004a10:	0104b503          	ld	a0,16(s1)
    80004a14:	00000097          	auipc	ra,0x0
    80004a18:	d1c080e7          	jalr	-740(ra) # 80004730 <_ZN5RiscV19mapConsoleRegistersEPv>
    80004a1c:	000407b7          	lui	a5,0x40
    80004a20:	1007a073          	csrs	sstatus,a5
}
    80004a24:	02813083          	ld	ra,40(sp)
    80004a28:	02013403          	ld	s0,32(sp)
    80004a2c:	01813483          	ld	s1,24(sp)
    80004a30:	01013903          	ld	s2,16(sp)
    80004a34:	00813983          	ld	s3,8(sp)
    80004a38:	00013a03          	ld	s4,0(sp)
    80004a3c:	03010113          	addi	sp,sp,48
    80004a40:	00008067          	ret

0000000080004a44 <_ZN5RiscV10initializeEv>:
void RiscV::initialize(){
    80004a44:	ff010113          	addi	sp,sp,-16
    80004a48:	00113423          	sd	ra,8(sp)
    80004a4c:	00813023          	sd	s0,0(sp)
    80004a50:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80004a54:	00006797          	auipc	a5,0x6
    80004a58:	5247b783          	ld	a5,1316(a5) # 8000af78 <_GLOBAL_OFFSET_TABLE_+0x90>
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80004a5c:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80004a60:	00006797          	auipc	a5,0x6
    80004a64:	4a07b783          	ld	a5,1184(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004a68:	0007b503          	ld	a0,0(a5)
    80004a6c:	00c55513          	srli	a0,a0,0xc
    80004a70:	00250513          	addi	a0,a0,2
    80004a74:	000015b7          	lui	a1,0x1
    80004a78:	00c51513          	slli	a0,a0,0xc
    80004a7c:	00000097          	auipc	ra,0x0
    80004a80:	7bc080e7          	jalr	1980(ra) # 80005238 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80004a84:	ffffe097          	auipc	ra,0xffffe
    80004a88:	668080e7          	jalr	1640(ra) # 800030ec <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80004a8c:	00000097          	auipc	ra,0x0
    80004a90:	108080e7          	jalr	264(ra) # 80004b94 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80004a94:	ffffe097          	auipc	ra,0xffffe
    80004a98:	504080e7          	jalr	1284(ra) # 80002f98 <_ZN3TCB10initializeEv>
    SCB::initialize();
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	03c080e7          	jalr	60(ra) # 80002ad8 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80004aa4:	00000097          	auipc	ra,0x0
    80004aa8:	304080e7          	jalr	772(ra) # 80004da8 <_ZN11ConsoleUtil10initializeEv>
    RiscV::buildKernelPMT();
    80004aac:	00000097          	auipc	ra,0x0
    80004ab0:	d18080e7          	jalr	-744(ra) # 800047c4 <_ZN5RiscV14buildKernelPMTEv>
    RiscV::buildUserPMT();
    80004ab4:	00000097          	auipc	ra,0x0
    80004ab8:	e50080e7          	jalr	-432(ra) # 80004904 <_ZN5RiscV12buildUserPMTEv>
    RiscV::initialized = true;
    80004abc:	00006797          	auipc	a5,0x6
    80004ac0:	72478793          	addi	a5,a5,1828 # 8000b1e0 <_ZN5RiscV16userMainFinishedE>
    80004ac4:	00100713          	li	a4,1
    80004ac8:	02e78023          	sb	a4,32(a5)
    RiscV::startVirtualMemory(RiscV::kPMT);
    80004acc:	0087b783          	ld	a5,8(a5)
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80004ad0:	00c7d793          	srli	a5,a5,0xc
    80004ad4:	fff00713          	li	a4,-1
    80004ad8:	03f71713          	slli	a4,a4,0x3f
    80004adc:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80004ae0:	18079073          	csrw	satp,a5
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80004ae4:	00200793          	li	a5,2
    80004ae8:	1047a073          	csrs	sie,a5
    80004aec:	20000713          	li	a4,512
    80004af0:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80004af4:	1007a073          	csrs	sstatus,a5
}
    80004af8:	00813083          	ld	ra,8(sp)
    80004afc:	00013403          	ld	s0,0(sp)
    80004b00:	01010113          	addi	sp,sp,16
    80004b04:	00008067          	ret

0000000080004b08 <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/kernel/utility.hpp"

char* strcpy(const char* src, char* dst){
    80004b08:	ff010113          	addi	sp,sp,-16
    80004b0c:	00813423          	sd	s0,8(sp)
    80004b10:	01010413          	addi	s0,sp,16
    80004b14:	00050793          	mv	a5,a0
    80004b18:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004b1c:	0007c703          	lbu	a4,0(a5)
    80004b20:	00070a63          	beqz	a4,80004b34 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004b24:	00178793          	addi	a5,a5,1
    80004b28:	00e50023          	sb	a4,0(a0)
    80004b2c:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004b30:	fedff06f          	j	80004b1c <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004b34:	00e50023          	sb	a4,0(a0)
    return dst;
}
    80004b38:	00813403          	ld	s0,8(sp)
    80004b3c:	01010113          	addi	sp,sp,16
    80004b40:	00008067          	ret

0000000080004b44 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004b44:	fe010113          	addi	sp,sp,-32
    80004b48:	00113c23          	sd	ra,24(sp)
    80004b4c:	00813823          	sd	s0,16(sp)
    80004b50:	00913423          	sd	s1,8(sp)
    80004b54:	02010413          	addi	s0,sp,32
    80004b58:	00050493          	mv	s1,a0
    80004b5c:	00058513          	mv	a0,a1
    char *dest = dst;
    80004b60:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004b64:	0005c783          	lbu	a5,0(a1) # 1000 <_entry-0x7ffff000>
    80004b68:	00078663          	beqz	a5,80004b74 <_Z6strcatPcPKc+0x30>
        dest++;
    80004b6c:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004b70:	ff5ff06f          	j	80004b64 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004b74:	00000097          	auipc	ra,0x0
    80004b78:	f94080e7          	jalr	-108(ra) # 80004b08 <_Z6strcpyPKcPc>
    return dst;
    80004b7c:	00048513          	mv	a0,s1
    80004b80:	01813083          	ld	ra,24(sp)
    80004b84:	01013403          	ld	s0,16(sp)
    80004b88:	00813483          	ld	s1,8(sp)
    80004b8c:	02010113          	addi	sp,sp,32
    80004b90:	00008067          	ret

0000000080004b94 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004b94:	ff010113          	addi	sp,sp,-16
    80004b98:	00813423          	sd	s0,8(sp)
    80004b9c:	01010413          	addi	s0,sp,16
}
    80004ba0:	00813403          	ld	s0,8(sp)
    80004ba4:	01010113          	addi	sp,sp,16
    80004ba8:	00008067          	ret

0000000080004bac <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004bac:	ff010113          	addi	sp,sp,-16
    80004bb0:	00813423          	sd	s0,8(sp)
    80004bb4:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004bb8:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004bbc:	00006797          	auipc	a5,0x6
    80004bc0:	64c7b783          	ld	a5,1612(a5) # 8000b208 <_ZN9Scheduler9readyHeadE>
    80004bc4:	02078263          	beqz	a5,80004be8 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004bc8:	00006797          	auipc	a5,0x6
    80004bcc:	6487b783          	ld	a5,1608(a5) # 8000b210 <_ZN9Scheduler9readyTailE>
    80004bd0:	04a7b423          	sd	a0,72(a5)
    80004bd4:	00006797          	auipc	a5,0x6
    80004bd8:	62a7be23          	sd	a0,1596(a5) # 8000b210 <_ZN9Scheduler9readyTailE>
}
    80004bdc:	00813403          	ld	s0,8(sp)
    80004be0:	01010113          	addi	sp,sp,16
    80004be4:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004be8:	00006797          	auipc	a5,0x6
    80004bec:	62a7b023          	sd	a0,1568(a5) # 8000b208 <_ZN9Scheduler9readyHeadE>
    80004bf0:	fe5ff06f          	j	80004bd4 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004bf4 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004bf4:	ff010113          	addi	sp,sp,-16
    80004bf8:	00813423          	sd	s0,8(sp)
    80004bfc:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004c00:	00006517          	auipc	a0,0x6
    80004c04:	60853503          	ld	a0,1544(a0) # 8000b208 <_ZN9Scheduler9readyHeadE>
    80004c08:	00050a63          	beqz	a0,80004c1c <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004c0c:	04853783          	ld	a5,72(a0)
    80004c10:	00006717          	auipc	a4,0x6
    80004c14:	5ef73c23          	sd	a5,1528(a4) # 8000b208 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004c18:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004c1c:	00813403          	ld	s0,8(sp)
    80004c20:	01010113          	addi	sp,sp,16
    80004c24:	00008067          	ret

0000000080004c28 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004c28:	ff010113          	addi	sp,sp,-16
    80004c2c:	00813423          	sd	s0,8(sp)
    80004c30:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004c34:	00006797          	auipc	a5,0x6
    80004c38:	5e47b783          	ld	a5,1508(a5) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
    80004c3c:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004c40:	00078e63          	beqz	a5,80004c5c <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004c44:	0587b683          	ld	a3,88(a5)
    80004c48:	05853703          	ld	a4,88(a0)
    80004c4c:	00d76863          	bltu	a4,a3,80004c5c <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004c50:	00078613          	mv	a2,a5
    80004c54:	0487b783          	ld	a5,72(a5)
    80004c58:	fe9ff06f          	j	80004c40 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004c5c:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004c60:	00060a63          	beqz	a2,80004c74 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004c64:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    80004c68:	00813403          	ld	s0,8(sp)
    80004c6c:	01010113          	addi	sp,sp,16
    80004c70:	00008067          	ret
        sleepingHead = t;
    80004c74:	00006797          	auipc	a5,0x6
    80004c78:	5aa7b223          	sd	a0,1444(a5) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
}
    80004c7c:	fedff06f          	j	80004c68 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004c80 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004c80:	fe010113          	addi	sp,sp,-32
    80004c84:	00113c23          	sd	ra,24(sp)
    80004c88:	00813823          	sd	s0,16(sp)
    80004c8c:	00913423          	sd	s1,8(sp)
    80004c90:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004c94:	00006497          	auipc	s1,0x6
    80004c98:	5844b483          	ld	s1,1412(s1) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
    80004c9c:	02048c63          	beqz	s1,80004cd4 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004ca0:	0584b703          	ld	a4,88(s1)
    80004ca4:	00006797          	auipc	a5,0x6
    80004ca8:	3247b783          	ld	a5,804(a5) # 8000afc8 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80004cac:	0007b783          	ld	a5,0(a5)
    80004cb0:	02e7e263          	bltu	a5,a4,80004cd4 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004cb4:	0484b783          	ld	a5,72(s1)
    80004cb8:	00006717          	auipc	a4,0x6
    80004cbc:	56f73023          	sd	a5,1376(a4) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004cc0:	00048513          	mv	a0,s1
    80004cc4:	00000097          	auipc	ra,0x0
    80004cc8:	ee8080e7          	jalr	-280(ra) # 80004bac <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004ccc:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004cd0:	fc5ff06f          	j	80004c94 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004cd4:	01813083          	ld	ra,24(sp)
    80004cd8:	01013403          	ld	s0,16(sp)
    80004cdc:	00813483          	ld	s1,8(sp)
    80004ce0:	02010113          	addi	sp,sp,32
    80004ce4:	00008067          	ret

0000000080004ce8 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004ce8:	fe010113          	addi	sp,sp,-32
    80004cec:	00113c23          	sd	ra,24(sp)
    80004cf0:	00813823          	sd	s0,16(sp)
    80004cf4:	00913423          	sd	s1,8(sp)
    80004cf8:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004cfc:	00006497          	auipc	s1,0x6
    80004d00:	50c4b483          	ld	s1,1292(s1) # 8000b208 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004d04:	02048863          	beqz	s1,80004d34 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004d08:	00000613          	li	a2,0
    80004d0c:	01000593          	li	a1,16
    80004d10:	0004851b          	sext.w	a0,s1
    80004d14:	00000097          	auipc	ra,0x0
    80004d18:	3b4080e7          	jalr	948(ra) # 800050c8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004d1c:	00003517          	auipc	a0,0x3
    80004d20:	68c50513          	addi	a0,a0,1676 # 800083a8 <CONSOLE_STATUS+0x398>
    80004d24:	00000097          	auipc	ra,0x0
    80004d28:	360080e7          	jalr	864(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004d2c:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004d30:	fd5ff06f          	j	80004d04 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004d34:	01813083          	ld	ra,24(sp)
    80004d38:	01013403          	ld	s0,16(sp)
    80004d3c:	00813483          	ld	s1,8(sp)
    80004d40:	02010113          	addi	sp,sp,32
    80004d44:	00008067          	ret

0000000080004d48 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004d48:	fe010113          	addi	sp,sp,-32
    80004d4c:	00113c23          	sd	ra,24(sp)
    80004d50:	00813823          	sd	s0,16(sp)
    80004d54:	00913423          	sd	s1,8(sp)
    80004d58:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004d5c:	00006497          	auipc	s1,0x6
    80004d60:	4bc4b483          	ld	s1,1212(s1) # 8000b218 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004d64:	02048863          	beqz	s1,80004d94 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004d68:	00000613          	li	a2,0
    80004d6c:	01000593          	li	a1,16
    80004d70:	0004851b          	sext.w	a0,s1
    80004d74:	0000a097          	auipc	ra,0xa
    80004d78:	078080e7          	jalr	120(ra) # 8000edec <_Z8printIntiii>
        printString("\n");
    80004d7c:	00003517          	auipc	a0,0x3
    80004d80:	62c50513          	addi	a0,a0,1580 # 800083a8 <CONSOLE_STATUS+0x398>
    80004d84:	0000a097          	auipc	ra,0xa
    80004d88:	ed0080e7          	jalr	-304(ra) # 8000ec54 <_Z11printStringPKc>
        iter = iter->next;
    80004d8c:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004d90:	fd5ff06f          	j	80004d64 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004d94:	01813083          	ld	ra,24(sp)
    80004d98:	01013403          	ld	s0,16(sp)
    80004d9c:	00813483          	ld	s1,8(sp)
    80004da0:	02010113          	addi	sp,sp,32
    80004da4:	00008067          	ret

0000000080004da8 <_ZN11ConsoleUtil10initializeEv>:
//char ConsoleUtil::inputBuffer[8192];
//char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    80004da8:	fe010113          	addi	sp,sp,-32
    80004dac:	00113c23          	sd	ra,24(sp)
    80004db0:	00813823          	sd	s0,16(sp)
    80004db4:	00913423          	sd	s1,8(sp)
    80004db8:	01213023          	sd	s2,0(sp)
    80004dbc:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004dc0:	01800513          	li	a0,24
    80004dc4:	ffffe097          	auipc	ra,0xffffe
    80004dc8:	f14080e7          	jalr	-236(ra) # 80002cd8 <_ZN3SCBnwEm>
    80004dcc:	00050493          	mv	s1,a0
    80004dd0:	00050863          	beqz	a0,80004de0 <_ZN11ConsoleUtil10initializeEv+0x38>
    80004dd4:	00000593          	li	a1,0
    80004dd8:	ffffe097          	auipc	ra,0xffffe
    80004ddc:	d4c080e7          	jalr	-692(ra) # 80002b24 <_ZN3SCBC1Em>
    80004de0:	00006797          	auipc	a5,0x6
    80004de4:	4497b023          	sd	s1,1088(a5) # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004de8:	01800513          	li	a0,24
    80004dec:	ffffe097          	auipc	ra,0xffffe
    80004df0:	eec080e7          	jalr	-276(ra) # 80002cd8 <_ZN3SCBnwEm>
    80004df4:	00050493          	mv	s1,a0
    80004df8:	00050863          	beqz	a0,80004e08 <_ZN11ConsoleUtil10initializeEv+0x60>
    80004dfc:	00000593          	li	a1,0
    80004e00:	ffffe097          	auipc	ra,0xffffe
    80004e04:	d24080e7          	jalr	-732(ra) # 80002b24 <_ZN3SCBC1Em>
    80004e08:	00006917          	auipc	s2,0x6
    80004e0c:	41890913          	addi	s2,s2,1048 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004e10:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80004e14:	00006497          	auipc	s1,0x6
    80004e18:	0cc48493          	addi	s1,s1,204 # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004e1c:	0004b503          	ld	a0,0(s1)
    80004e20:	00000097          	auipc	ra,0x0
    80004e24:	538080e7          	jalr	1336(ra) # 80005358 <_Z7kmallocm>
    80004e28:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80004e2c:	0004b503          	ld	a0,0(s1)
    80004e30:	00000097          	auipc	ra,0x0
    80004e34:	528080e7          	jalr	1320(ra) # 80005358 <_Z7kmallocm>
    80004e38:	00a93c23          	sd	a0,24(s2)
}
    80004e3c:	01813083          	ld	ra,24(sp)
    80004e40:	01013403          	ld	s0,16(sp)
    80004e44:	00813483          	ld	s1,8(sp)
    80004e48:	00013903          	ld	s2,0(sp)
    80004e4c:	02010113          	addi	sp,sp,32
    80004e50:	00008067          	ret
    80004e54:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004e58:	00048513          	mv	a0,s1
    80004e5c:	ffffe097          	auipc	ra,0xffffe
    80004e60:	eac080e7          	jalr	-340(ra) # 80002d08 <_ZN3SCBdlEPv>
    80004e64:	00090513          	mv	a0,s2
    80004e68:	00007097          	auipc	ra,0x7
    80004e6c:	4d0080e7          	jalr	1232(ra) # 8000c338 <_Unwind_Resume>
    80004e70:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004e74:	00048513          	mv	a0,s1
    80004e78:	ffffe097          	auipc	ra,0xffffe
    80004e7c:	e90080e7          	jalr	-368(ra) # 80002d08 <_ZN3SCBdlEPv>
    80004e80:	00090513          	mv	a0,s2
    80004e84:	00007097          	auipc	ra,0x7
    80004e88:	4b4080e7          	jalr	1204(ra) # 8000c338 <_Unwind_Resume>

0000000080004e8c <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004e8c:	00006717          	auipc	a4,0x6
    80004e90:	39470713          	addi	a4,a4,916 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004e94:	02073683          	ld	a3,32(a4)
    80004e98:	00168793          	addi	a5,a3,1
    80004e9c:	00006617          	auipc	a2,0x6
    80004ea0:	04463603          	ld	a2,68(a2) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004ea4:	02c7f7b3          	remu	a5,a5,a2
    80004ea8:	02873703          	ld	a4,40(a4)
    80004eac:	04e78e63          	beq	a5,a4,80004f08 <_ZN11ConsoleUtil8putInputEc+0x7c>
void ConsoleUtil::putInput(char c) {
    80004eb0:	ff010113          	addi	sp,sp,-16
    80004eb4:	00113423          	sd	ra,8(sp)
    80004eb8:	00813023          	sd	s0,0(sp)
    80004ebc:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004ec0:	00006717          	auipc	a4,0x6
    80004ec4:	36070713          	addi	a4,a4,864 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004ec8:	01073783          	ld	a5,16(a4)
    80004ecc:	00d786b3          	add	a3,a5,a3
    80004ed0:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    80004ed4:	02073783          	ld	a5,32(a4)
    80004ed8:	00178793          	addi	a5,a5,1
    80004edc:	00006697          	auipc	a3,0x6
    80004ee0:	0046b683          	ld	a3,4(a3) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004ee4:	02d7f7b3          	remu	a5,a5,a3
    80004ee8:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    80004eec:	00073503          	ld	a0,0(a4)
    80004ef0:	ffffe097          	auipc	ra,0xffffe
    80004ef4:	dac080e7          	jalr	-596(ra) # 80002c9c <_ZN3SCB6signalEv>
}
    80004ef8:	00813083          	ld	ra,8(sp)
    80004efc:	00013403          	ld	s0,0(sp)
    80004f00:	01010113          	addi	sp,sp,16
    80004f04:	00008067          	ret
    80004f08:	00008067          	ret

0000000080004f0c <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004f0c:	fe010113          	addi	sp,sp,-32
    80004f10:	00113c23          	sd	ra,24(sp)
    80004f14:	00813823          	sd	s0,16(sp)
    80004f18:	00913423          	sd	s1,8(sp)
    80004f1c:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004f20:	00006497          	auipc	s1,0x6
    80004f24:	30048493          	addi	s1,s1,768 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004f28:	0004b503          	ld	a0,0(s1)
    80004f2c:	ffffe097          	auipc	ra,0xffffe
    80004f30:	d20080e7          	jalr	-736(ra) # 80002c4c <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004f34:	0284b783          	ld	a5,40(s1)
    80004f38:	0204b703          	ld	a4,32(s1)
    80004f3c:	02e78c63          	beq	a5,a4,80004f74 <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    80004f40:	0104b703          	ld	a4,16(s1)
    80004f44:	00f70733          	add	a4,a4,a5
    80004f48:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004f4c:	00178793          	addi	a5,a5,1
    80004f50:	00006717          	auipc	a4,0x6
    80004f54:	f9073703          	ld	a4,-112(a4) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004f58:	02e7f7b3          	remu	a5,a5,a4
    80004f5c:	02f4b423          	sd	a5,40(s1)

    return c;
}
    80004f60:	01813083          	ld	ra,24(sp)
    80004f64:	01013403          	ld	s0,16(sp)
    80004f68:	00813483          	ld	s1,8(sp)
    80004f6c:	02010113          	addi	sp,sp,32
    80004f70:	00008067          	ret
        return -1;
    80004f74:	0ff00513          	li	a0,255
    80004f78:	fe9ff06f          	j	80004f60 <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080004f7c <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004f7c:	00006797          	auipc	a5,0x6
    80004f80:	2a478793          	addi	a5,a5,676 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004f84:	0307b703          	ld	a4,48(a5)
    80004f88:	00170713          	addi	a4,a4,1
    80004f8c:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004f90:	0387b683          	ld	a3,56(a5)
    80004f94:	00168713          	addi	a4,a3,1
    80004f98:	00006617          	auipc	a2,0x6
    80004f9c:	f4863603          	ld	a2,-184(a2) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004fa0:	02c77733          	remu	a4,a4,a2
    80004fa4:	0407b783          	ld	a5,64(a5)
    80004fa8:	06f70463          	beq	a4,a5,80005010 <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    80004fac:	ff010113          	addi	sp,sp,-16
    80004fb0:	00113423          	sd	ra,8(sp)
    80004fb4:	00813023          	sd	s0,0(sp)
    80004fb8:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004fbc:	00006797          	auipc	a5,0x6
    80004fc0:	26478793          	addi	a5,a5,612 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80004fc4:	0187b703          	ld	a4,24(a5)
    80004fc8:	00d706b3          	add	a3,a4,a3
    80004fcc:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    80004fd0:	0387b703          	ld	a4,56(a5)
    80004fd4:	00170713          	addi	a4,a4,1
    80004fd8:	00006697          	auipc	a3,0x6
    80004fdc:	f086b683          	ld	a3,-248(a3) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80004fe0:	02d77733          	remu	a4,a4,a3
    80004fe4:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    80004fe8:	0307b703          	ld	a4,48(a5)
    80004fec:	fff70713          	addi	a4,a4,-1
    80004ff0:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    80004ff4:	0087b503          	ld	a0,8(a5)
    80004ff8:	ffffe097          	auipc	ra,0xffffe
    80004ffc:	ca4080e7          	jalr	-860(ra) # 80002c9c <_ZN3SCB6signalEv>
}
    80005000:	00813083          	ld	ra,8(sp)
    80005004:	00013403          	ld	s0,0(sp)
    80005008:	01010113          	addi	sp,sp,16
    8000500c:	00008067          	ret
    80005010:	00008067          	ret

0000000080005014 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80005014:	fe010113          	addi	sp,sp,-32
    80005018:	00113c23          	sd	ra,24(sp)
    8000501c:	00813823          	sd	s0,16(sp)
    80005020:	00913423          	sd	s1,8(sp)
    80005024:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80005028:	00006497          	auipc	s1,0x6
    8000502c:	1f848493          	addi	s1,s1,504 # 8000b220 <_ZN11ConsoleUtil8inputSemE>
    80005030:	0084b503          	ld	a0,8(s1)
    80005034:	ffffe097          	auipc	ra,0xffffe
    80005038:	c18080e7          	jalr	-1000(ra) # 80002c4c <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    8000503c:	0404b783          	ld	a5,64(s1)
    80005040:	0384b703          	ld	a4,56(s1)
    80005044:	02e78c63          	beq	a5,a4,8000507c <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    80005048:	0184b703          	ld	a4,24(s1)
    8000504c:	00f70733          	add	a4,a4,a5
    80005050:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80005054:	00178793          	addi	a5,a5,1
    80005058:	00006717          	auipc	a4,0x6
    8000505c:	e8873703          	ld	a4,-376(a4) # 8000aee0 <_ZN11ConsoleUtil10bufferSizeE>
    80005060:	02e7f7b3          	remu	a5,a5,a4
    80005064:	04f4b023          	sd	a5,64(s1)

    return c;
}
    80005068:	01813083          	ld	ra,24(sp)
    8000506c:	01013403          	ld	s0,16(sp)
    80005070:	00813483          	ld	s1,8(sp)
    80005074:	02010113          	addi	sp,sp,32
    80005078:	00008067          	ret
        return -1;
    8000507c:	0ff00513          	li	a0,255
    80005080:	fe9ff06f          	j	80005068 <_ZN11ConsoleUtil9getOutputEv+0x54>

0000000080005084 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80005084:	fe010113          	addi	sp,sp,-32
    80005088:	00113c23          	sd	ra,24(sp)
    8000508c:	00813823          	sd	s0,16(sp)
    80005090:	00913423          	sd	s1,8(sp)
    80005094:	02010413          	addi	s0,sp,32
    80005098:	00050493          	mv	s1,a0
    while (*string != '\0')
    8000509c:	0004c503          	lbu	a0,0(s1)
    800050a0:	00050a63          	beqz	a0,800050b4 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    800050a4:	00000097          	auipc	ra,0x0
    800050a8:	ed8080e7          	jalr	-296(ra) # 80004f7c <_ZN11ConsoleUtil9putOutputEc>
        string++;
    800050ac:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800050b0:	fedff06f          	j	8000509c <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    800050b4:	01813083          	ld	ra,24(sp)
    800050b8:	01013403          	ld	s0,16(sp)
    800050bc:	00813483          	ld	s1,8(sp)
    800050c0:	02010113          	addi	sp,sp,32
    800050c4:	00008067          	ret

00000000800050c8 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800050c8:	fb010113          	addi	sp,sp,-80
    800050cc:	04113423          	sd	ra,72(sp)
    800050d0:	04813023          	sd	s0,64(sp)
    800050d4:	02913c23          	sd	s1,56(sp)
    800050d8:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800050dc:	00003797          	auipc	a5,0x3
    800050e0:	4cc78793          	addi	a5,a5,1228 # 800085a8 <CONSOLE_STATUS+0x598>
    800050e4:	0007b703          	ld	a4,0(a5)
    800050e8:	fce43423          	sd	a4,-56(s0)
    800050ec:	0087b703          	ld	a4,8(a5)
    800050f0:	fce43823          	sd	a4,-48(s0)
    800050f4:	0107c783          	lbu	a5,16(a5)
    800050f8:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800050fc:	00060463          	beqz	a2,80005104 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80005100:	08054263          	bltz	a0,80005184 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80005104:	0005051b          	sext.w	a0,a0
    neg = 0;
    80005108:	00000813          	li	a6,0
    }

    i = 0;
    8000510c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80005110:	0005871b          	sext.w	a4,a1
    80005114:	02b577bb          	remuw	a5,a0,a1
    80005118:	00048693          	mv	a3,s1
    8000511c:	0014849b          	addiw	s1,s1,1
    80005120:	02079793          	slli	a5,a5,0x20
    80005124:	0207d793          	srli	a5,a5,0x20
    80005128:	fe040613          	addi	a2,s0,-32
    8000512c:	00f607b3          	add	a5,a2,a5
    80005130:	fe87c603          	lbu	a2,-24(a5)
    80005134:	fe040793          	addi	a5,s0,-32
    80005138:	00d787b3          	add	a5,a5,a3
    8000513c:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80005140:	0005061b          	sext.w	a2,a0
    80005144:	02b5553b          	divuw	a0,a0,a1
    80005148:	fce674e3          	bgeu	a2,a4,80005110 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    8000514c:	00080c63          	beqz	a6,80005164 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80005150:	fe040793          	addi	a5,s0,-32
    80005154:	009784b3          	add	s1,a5,s1
    80005158:	02d00793          	li	a5,45
    8000515c:	fcf48c23          	sb	a5,-40(s1)
    80005160:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80005164:	fff4849b          	addiw	s1,s1,-1
    80005168:	0204c463          	bltz	s1,80005190 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    8000516c:	fe040793          	addi	a5,s0,-32
    80005170:	009787b3          	add	a5,a5,s1
    80005174:	fd87c503          	lbu	a0,-40(a5)
    80005178:	00000097          	auipc	ra,0x0
    8000517c:	e04080e7          	jalr	-508(ra) # 80004f7c <_ZN11ConsoleUtil9putOutputEc>
    80005180:	fe5ff06f          	j	80005164 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80005184:	40a0053b          	negw	a0,a0
        neg = 1;
    80005188:	00100813          	li	a6,1
        x = -xx;
    8000518c:	f81ff06f          	j	8000510c <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80005190:	04813083          	ld	ra,72(sp)
    80005194:	04013403          	ld	s0,64(sp)
    80005198:	03813483          	ld	s1,56(sp)
    8000519c:	05010113          	addi	sp,sp,80
    800051a0:	00008067          	ret

00000000800051a4 <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    800051a4:	fd010113          	addi	sp,sp,-48
    800051a8:	02113423          	sd	ra,40(sp)
    800051ac:	02813023          	sd	s0,32(sp)
    800051b0:	00913c23          	sd	s1,24(sp)
    800051b4:	01213823          	sd	s2,16(sp)
    800051b8:	01313423          	sd	s3,8(sp)
    800051bc:	03010413          	addi	s0,sp,48
    800051c0:	00058913          	mv	s2,a1
    800051c4:	00060493          	mv	s1,a2
    800051c8:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    800051cc:	00000097          	auipc	ra,0x0
    800051d0:	eb8080e7          	jalr	-328(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    800051d4:	00000613          	li	a2,0
    800051d8:	00098593          	mv	a1,s3
    800051dc:	00090513          	mv	a0,s2
    800051e0:	00000097          	auipc	ra,0x0
    800051e4:	ee8080e7          	jalr	-280(ra) # 800050c8 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    800051e8:	00048513          	mv	a0,s1
    800051ec:	00000097          	auipc	ra,0x0
    800051f0:	e98080e7          	jalr	-360(ra) # 80005084 <_ZN11ConsoleUtil11printStringEPKc>
}
    800051f4:	02813083          	ld	ra,40(sp)
    800051f8:	02013403          	ld	s0,32(sp)
    800051fc:	01813483          	ld	s1,24(sp)
    80005200:	01013903          	ld	s2,16(sp)
    80005204:	00813983          	ld	s3,8(sp)
    80005208:	03010113          	addi	sp,sp,48
    8000520c:	00008067          	ret

0000000080005210 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80005210:	ff010113          	addi	sp,sp,-16
    80005214:	00813423          	sd	s0,8(sp)
    80005218:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    8000521c:	04300513          	li	a0,67

    asm("ecall");
    80005220:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80005224:	00050513          	mv	a0,a0

    return (char)status;
}
    80005228:	0ff57513          	andi	a0,a0,255
    8000522c:	00813403          	ld	s0,8(sp)
    80005230:	01010113          	addi	sp,sp,16
    80005234:	00008067          	ret

0000000080005238 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/kernel/slab.hpp"

void kmem_init(void* space, int block_num){
    80005238:	ff010113          	addi	sp,sp,-16
    8000523c:	00113423          	sd	ra,8(sp)
    80005240:	00813023          	sd	s0,0(sp)
    80005244:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80005248:	ffffd097          	auipc	ra,0xffffd
    8000524c:	89c080e7          	jalr	-1892(ra) # 80001ae4 <_ZN13SlabAllocator10initializeEPvm>
}
    80005250:	00813083          	ld	ra,8(sp)
    80005254:	00013403          	ld	s0,0(sp)
    80005258:	01010113          	addi	sp,sp,16
    8000525c:	00008067          	ret

0000000080005260 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80005260:	ff010113          	addi	sp,sp,-16
    80005264:	00113423          	sd	ra,8(sp)
    80005268:	00813023          	sd	s0,0(sp)
    8000526c:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80005270:	ffffc097          	auipc	ra,0xffffc
    80005274:	768080e7          	jalr	1896(ra) # 800019d8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80005278:	00813083          	ld	ra,8(sp)
    8000527c:	00013403          	ld	s0,0(sp)
    80005280:	01010113          	addi	sp,sp,16
    80005284:	00008067          	ret

0000000080005288 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80005288:	ff010113          	addi	sp,sp,-16
    8000528c:	00113423          	sd	ra,8(sp)
    80005290:	00813023          	sd	s0,0(sp)
    80005294:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80005298:	ffffc097          	auipc	ra,0xffffc
    8000529c:	514080e7          	jalr	1300(ra) # 800017ac <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800052a0:	00813083          	ld	ra,8(sp)
    800052a4:	00013403          	ld	s0,0(sp)
    800052a8:	01010113          	addi	sp,sp,16
    800052ac:	00008067          	ret

00000000800052b0 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    800052b0:	ff010113          	addi	sp,sp,-16
    800052b4:	00113423          	sd	ra,8(sp)
    800052b8:	00813023          	sd	s0,0(sp)
    800052bc:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    800052c0:	ffffd097          	auipc	ra,0xffffd
    800052c4:	a6c080e7          	jalr	-1428(ra) # 80001d2c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    800052c8:	00813083          	ld	ra,8(sp)
    800052cc:	00013403          	ld	s0,0(sp)
    800052d0:	01010113          	addi	sp,sp,16
    800052d4:	00008067          	ret

00000000800052d8 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    800052d8:	fe010113          	addi	sp,sp,-32
    800052dc:	00113c23          	sd	ra,24(sp)
    800052e0:	00813823          	sd	s0,16(sp)
    800052e4:	02010413          	addi	s0,sp,32
    800052e8:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    800052ec:	fe840513          	addi	a0,s0,-24
    800052f0:	ffffd097          	auipc	ra,0xffffd
    800052f4:	b9c080e7          	jalr	-1124(ra) # 80001e8c <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    800052f8:	01813083          	ld	ra,24(sp)
    800052fc:	01013403          	ld	s0,16(sp)
    80005300:	02010113          	addi	sp,sp,32
    80005304:	00008067          	ret

0000000080005308 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80005308:	ff010113          	addi	sp,sp,-16
    8000530c:	00113423          	sd	ra,8(sp)
    80005310:	00813023          	sd	s0,0(sp)
    80005314:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80005318:	ffffc097          	auipc	ra,0xffffc
    8000531c:	fe0080e7          	jalr	-32(ra) # 800012f8 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80005320:	00813083          	ld	ra,8(sp)
    80005324:	00013403          	ld	s0,0(sp)
    80005328:	01010113          	addi	sp,sp,16
    8000532c:	00008067          	ret

0000000080005330 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80005330:	ff010113          	addi	sp,sp,-16
    80005334:	00113423          	sd	ra,8(sp)
    80005338:	00813023          	sd	s0,0(sp)
    8000533c:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80005340:	ffffc097          	auipc	ra,0xffffc
    80005344:	df4080e7          	jalr	-524(ra) # 80001134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80005348:	00813083          	ld	ra,8(sp)
    8000534c:	00013403          	ld	s0,0(sp)
    80005350:	01010113          	addi	sp,sp,16
    80005354:	00008067          	ret

0000000080005358 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80005358:	ff010113          	addi	sp,sp,-16
    8000535c:	00113423          	sd	ra,8(sp)
    80005360:	00813023          	sd	s0,0(sp)
    80005364:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80005368:	ffffc097          	auipc	ra,0xffffc
    8000536c:	5d0080e7          	jalr	1488(ra) # 80001938 <_ZN13SlabAllocator14allocateBufferEm>
}
    80005370:	00813083          	ld	ra,8(sp)
    80005374:	00013403          	ld	s0,0(sp)
    80005378:	01010113          	addi	sp,sp,16
    8000537c:	00008067          	ret

0000000080005380 <_Z5kfreePKv>:

void kfree(const void* objp){
    80005380:	ff010113          	addi	sp,sp,-16
    80005384:	00113423          	sd	ra,8(sp)
    80005388:	00813023          	sd	s0,0(sp)
    8000538c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80005390:	ffffd097          	auipc	ra,0xffffd
    80005394:	a90080e7          	jalr	-1392(ra) # 80001e20 <_ZN13SlabAllocator10freeBufferEPKv>
    80005398:	00813083          	ld	ra,8(sp)
    8000539c:	00013403          	ld	s0,0(sp)
    800053a0:	01010113          	addi	sp,sp,16
    800053a4:	00008067          	ret

00000000800053a8 <start>:
    800053a8:	ff010113          	addi	sp,sp,-16
    800053ac:	00813423          	sd	s0,8(sp)
    800053b0:	01010413          	addi	s0,sp,16
    800053b4:	300027f3          	csrr	a5,mstatus
    800053b8:	ffffe737          	lui	a4,0xffffe
    800053bc:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed7ff>
    800053c0:	00e7f7b3          	and	a5,a5,a4
    800053c4:	00001737          	lui	a4,0x1
    800053c8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800053cc:	00e7e7b3          	or	a5,a5,a4
    800053d0:	30079073          	csrw	mstatus,a5
    800053d4:	00000797          	auipc	a5,0x0
    800053d8:	16078793          	addi	a5,a5,352 # 80005534 <system_main>
    800053dc:	34179073          	csrw	mepc,a5
    800053e0:	00000793          	li	a5,0
    800053e4:	18079073          	csrw	satp,a5
    800053e8:	000107b7          	lui	a5,0x10
    800053ec:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800053f0:	30279073          	csrw	medeleg,a5
    800053f4:	30379073          	csrw	mideleg,a5
    800053f8:	104027f3          	csrr	a5,sie
    800053fc:	2227e793          	ori	a5,a5,546
    80005400:	10479073          	csrw	sie,a5
    80005404:	fff00793          	li	a5,-1
    80005408:	00a7d793          	srli	a5,a5,0xa
    8000540c:	3b079073          	csrw	pmpaddr0,a5
    80005410:	00f00793          	li	a5,15
    80005414:	3a079073          	csrw	pmpcfg0,a5
    80005418:	f14027f3          	csrr	a5,mhartid
    8000541c:	0200c737          	lui	a4,0x200c
    80005420:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005424:	0007869b          	sext.w	a3,a5
    80005428:	00269713          	slli	a4,a3,0x2
    8000542c:	000f4637          	lui	a2,0xf4
    80005430:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005434:	00d70733          	add	a4,a4,a3
    80005438:	0037979b          	slliw	a5,a5,0x3
    8000543c:	020046b7          	lui	a3,0x2004
    80005440:	00d787b3          	add	a5,a5,a3
    80005444:	00c585b3          	add	a1,a1,a2
    80005448:	00371693          	slli	a3,a4,0x3
    8000544c:	00006717          	auipc	a4,0x6
    80005450:	e2470713          	addi	a4,a4,-476 # 8000b270 <timer_scratch>
    80005454:	00b7b023          	sd	a1,0(a5)
    80005458:	00d70733          	add	a4,a4,a3
    8000545c:	00f73c23          	sd	a5,24(a4)
    80005460:	02c73023          	sd	a2,32(a4)
    80005464:	34071073          	csrw	mscratch,a4
    80005468:	00000797          	auipc	a5,0x0
    8000546c:	6e878793          	addi	a5,a5,1768 # 80005b50 <timervec>
    80005470:	30579073          	csrw	mtvec,a5
    80005474:	300027f3          	csrr	a5,mstatus
    80005478:	0087e793          	ori	a5,a5,8
    8000547c:	30079073          	csrw	mstatus,a5
    80005480:	304027f3          	csrr	a5,mie
    80005484:	0807e793          	ori	a5,a5,128
    80005488:	30479073          	csrw	mie,a5
    8000548c:	f14027f3          	csrr	a5,mhartid
    80005490:	0007879b          	sext.w	a5,a5
    80005494:	00078213          	mv	tp,a5
    80005498:	30200073          	mret
    8000549c:	00813403          	ld	s0,8(sp)
    800054a0:	01010113          	addi	sp,sp,16
    800054a4:	00008067          	ret

00000000800054a8 <timerinit>:
    800054a8:	ff010113          	addi	sp,sp,-16
    800054ac:	00813423          	sd	s0,8(sp)
    800054b0:	01010413          	addi	s0,sp,16
    800054b4:	f14027f3          	csrr	a5,mhartid
    800054b8:	0200c737          	lui	a4,0x200c
    800054bc:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800054c0:	0007869b          	sext.w	a3,a5
    800054c4:	00269713          	slli	a4,a3,0x2
    800054c8:	000f4637          	lui	a2,0xf4
    800054cc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800054d0:	00d70733          	add	a4,a4,a3
    800054d4:	0037979b          	slliw	a5,a5,0x3
    800054d8:	020046b7          	lui	a3,0x2004
    800054dc:	00d787b3          	add	a5,a5,a3
    800054e0:	00c585b3          	add	a1,a1,a2
    800054e4:	00371693          	slli	a3,a4,0x3
    800054e8:	00006717          	auipc	a4,0x6
    800054ec:	d8870713          	addi	a4,a4,-632 # 8000b270 <timer_scratch>
    800054f0:	00b7b023          	sd	a1,0(a5)
    800054f4:	00d70733          	add	a4,a4,a3
    800054f8:	00f73c23          	sd	a5,24(a4)
    800054fc:	02c73023          	sd	a2,32(a4)
    80005500:	34071073          	csrw	mscratch,a4
    80005504:	00000797          	auipc	a5,0x0
    80005508:	64c78793          	addi	a5,a5,1612 # 80005b50 <timervec>
    8000550c:	30579073          	csrw	mtvec,a5
    80005510:	300027f3          	csrr	a5,mstatus
    80005514:	0087e793          	ori	a5,a5,8
    80005518:	30079073          	csrw	mstatus,a5
    8000551c:	304027f3          	csrr	a5,mie
    80005520:	0807e793          	ori	a5,a5,128
    80005524:	30479073          	csrw	mie,a5
    80005528:	00813403          	ld	s0,8(sp)
    8000552c:	01010113          	addi	sp,sp,16
    80005530:	00008067          	ret

0000000080005534 <system_main>:
    80005534:	fe010113          	addi	sp,sp,-32
    80005538:	00813823          	sd	s0,16(sp)
    8000553c:	00913423          	sd	s1,8(sp)
    80005540:	00113c23          	sd	ra,24(sp)
    80005544:	02010413          	addi	s0,sp,32
    80005548:	00000097          	auipc	ra,0x0
    8000554c:	0c4080e7          	jalr	196(ra) # 8000560c <cpuid>
    80005550:	00006497          	auipc	s1,0x6
    80005554:	aa048493          	addi	s1,s1,-1376 # 8000aff0 <started>
    80005558:	02050263          	beqz	a0,8000557c <system_main+0x48>
    8000555c:	0004a783          	lw	a5,0(s1)
    80005560:	0007879b          	sext.w	a5,a5
    80005564:	fe078ce3          	beqz	a5,8000555c <system_main+0x28>
    80005568:	0ff0000f          	fence
    8000556c:	00003517          	auipc	a0,0x3
    80005570:	08450513          	addi	a0,a0,132 # 800085f0 <CONSOLE_STATUS+0x5e0>
    80005574:	00001097          	auipc	ra,0x1
    80005578:	a78080e7          	jalr	-1416(ra) # 80005fec <panic>
    8000557c:	00001097          	auipc	ra,0x1
    80005580:	9cc080e7          	jalr	-1588(ra) # 80005f48 <consoleinit>
    80005584:	00001097          	auipc	ra,0x1
    80005588:	158080e7          	jalr	344(ra) # 800066dc <printfinit>
    8000558c:	00003517          	auipc	a0,0x3
    80005590:	e1c50513          	addi	a0,a0,-484 # 800083a8 <CONSOLE_STATUS+0x398>
    80005594:	00001097          	auipc	ra,0x1
    80005598:	ab4080e7          	jalr	-1356(ra) # 80006048 <__printf>
    8000559c:	00003517          	auipc	a0,0x3
    800055a0:	02450513          	addi	a0,a0,36 # 800085c0 <CONSOLE_STATUS+0x5b0>
    800055a4:	00001097          	auipc	ra,0x1
    800055a8:	aa4080e7          	jalr	-1372(ra) # 80006048 <__printf>
    800055ac:	00003517          	auipc	a0,0x3
    800055b0:	dfc50513          	addi	a0,a0,-516 # 800083a8 <CONSOLE_STATUS+0x398>
    800055b4:	00001097          	auipc	ra,0x1
    800055b8:	a94080e7          	jalr	-1388(ra) # 80006048 <__printf>
    800055bc:	00001097          	auipc	ra,0x1
    800055c0:	4ac080e7          	jalr	1196(ra) # 80006a68 <kinit>
    800055c4:	00000097          	auipc	ra,0x0
    800055c8:	148080e7          	jalr	328(ra) # 8000570c <trapinit>
    800055cc:	00000097          	auipc	ra,0x0
    800055d0:	16c080e7          	jalr	364(ra) # 80005738 <trapinithart>
    800055d4:	00000097          	auipc	ra,0x0
    800055d8:	5bc080e7          	jalr	1468(ra) # 80005b90 <plicinit>
    800055dc:	00000097          	auipc	ra,0x0
    800055e0:	5dc080e7          	jalr	1500(ra) # 80005bb8 <plicinithart>
    800055e4:	00000097          	auipc	ra,0x0
    800055e8:	078080e7          	jalr	120(ra) # 8000565c <userinit>
    800055ec:	0ff0000f          	fence
    800055f0:	00100793          	li	a5,1
    800055f4:	00003517          	auipc	a0,0x3
    800055f8:	fe450513          	addi	a0,a0,-28 # 800085d8 <CONSOLE_STATUS+0x5c8>
    800055fc:	00f4a023          	sw	a5,0(s1)
    80005600:	00001097          	auipc	ra,0x1
    80005604:	a48080e7          	jalr	-1464(ra) # 80006048 <__printf>
    80005608:	0000006f          	j	80005608 <system_main+0xd4>

000000008000560c <cpuid>:
    8000560c:	ff010113          	addi	sp,sp,-16
    80005610:	00813423          	sd	s0,8(sp)
    80005614:	01010413          	addi	s0,sp,16
    80005618:	00020513          	mv	a0,tp
    8000561c:	00813403          	ld	s0,8(sp)
    80005620:	0005051b          	sext.w	a0,a0
    80005624:	01010113          	addi	sp,sp,16
    80005628:	00008067          	ret

000000008000562c <mycpu>:
    8000562c:	ff010113          	addi	sp,sp,-16
    80005630:	00813423          	sd	s0,8(sp)
    80005634:	01010413          	addi	s0,sp,16
    80005638:	00020793          	mv	a5,tp
    8000563c:	00813403          	ld	s0,8(sp)
    80005640:	0007879b          	sext.w	a5,a5
    80005644:	00779793          	slli	a5,a5,0x7
    80005648:	00007517          	auipc	a0,0x7
    8000564c:	c5850513          	addi	a0,a0,-936 # 8000c2a0 <cpus>
    80005650:	00f50533          	add	a0,a0,a5
    80005654:	01010113          	addi	sp,sp,16
    80005658:	00008067          	ret

000000008000565c <userinit>:
    8000565c:	ff010113          	addi	sp,sp,-16
    80005660:	00813423          	sd	s0,8(sp)
    80005664:	01010413          	addi	s0,sp,16
    80005668:	00813403          	ld	s0,8(sp)
    8000566c:	01010113          	addi	sp,sp,16
    80005670:	ffffd317          	auipc	t1,0xffffd
    80005674:	6f830067          	jr	1784(t1) # 80002d68 <main>

0000000080005678 <either_copyout>:
    80005678:	ff010113          	addi	sp,sp,-16
    8000567c:	00813023          	sd	s0,0(sp)
    80005680:	00113423          	sd	ra,8(sp)
    80005684:	01010413          	addi	s0,sp,16
    80005688:	02051663          	bnez	a0,800056b4 <either_copyout+0x3c>
    8000568c:	00058513          	mv	a0,a1
    80005690:	00060593          	mv	a1,a2
    80005694:	0006861b          	sext.w	a2,a3
    80005698:	00002097          	auipc	ra,0x2
    8000569c:	c5c080e7          	jalr	-932(ra) # 800072f4 <__memmove>
    800056a0:	00813083          	ld	ra,8(sp)
    800056a4:	00013403          	ld	s0,0(sp)
    800056a8:	00000513          	li	a0,0
    800056ac:	01010113          	addi	sp,sp,16
    800056b0:	00008067          	ret
    800056b4:	00003517          	auipc	a0,0x3
    800056b8:	f6450513          	addi	a0,a0,-156 # 80008618 <CONSOLE_STATUS+0x608>
    800056bc:	00001097          	auipc	ra,0x1
    800056c0:	930080e7          	jalr	-1744(ra) # 80005fec <panic>

00000000800056c4 <either_copyin>:
    800056c4:	ff010113          	addi	sp,sp,-16
    800056c8:	00813023          	sd	s0,0(sp)
    800056cc:	00113423          	sd	ra,8(sp)
    800056d0:	01010413          	addi	s0,sp,16
    800056d4:	02059463          	bnez	a1,800056fc <either_copyin+0x38>
    800056d8:	00060593          	mv	a1,a2
    800056dc:	0006861b          	sext.w	a2,a3
    800056e0:	00002097          	auipc	ra,0x2
    800056e4:	c14080e7          	jalr	-1004(ra) # 800072f4 <__memmove>
    800056e8:	00813083          	ld	ra,8(sp)
    800056ec:	00013403          	ld	s0,0(sp)
    800056f0:	00000513          	li	a0,0
    800056f4:	01010113          	addi	sp,sp,16
    800056f8:	00008067          	ret
    800056fc:	00003517          	auipc	a0,0x3
    80005700:	f4450513          	addi	a0,a0,-188 # 80008640 <CONSOLE_STATUS+0x630>
    80005704:	00001097          	auipc	ra,0x1
    80005708:	8e8080e7          	jalr	-1816(ra) # 80005fec <panic>

000000008000570c <trapinit>:
    8000570c:	ff010113          	addi	sp,sp,-16
    80005710:	00813423          	sd	s0,8(sp)
    80005714:	01010413          	addi	s0,sp,16
    80005718:	00813403          	ld	s0,8(sp)
    8000571c:	00003597          	auipc	a1,0x3
    80005720:	f4c58593          	addi	a1,a1,-180 # 80008668 <CONSOLE_STATUS+0x658>
    80005724:	00007517          	auipc	a0,0x7
    80005728:	bfc50513          	addi	a0,a0,-1028 # 8000c320 <tickslock>
    8000572c:	01010113          	addi	sp,sp,16
    80005730:	00001317          	auipc	t1,0x1
    80005734:	5c830067          	jr	1480(t1) # 80006cf8 <initlock>

0000000080005738 <trapinithart>:
    80005738:	ff010113          	addi	sp,sp,-16
    8000573c:	00813423          	sd	s0,8(sp)
    80005740:	01010413          	addi	s0,sp,16
    80005744:	00000797          	auipc	a5,0x0
    80005748:	2fc78793          	addi	a5,a5,764 # 80005a40 <kernelvec>
    8000574c:	10579073          	csrw	stvec,a5
    80005750:	00813403          	ld	s0,8(sp)
    80005754:	01010113          	addi	sp,sp,16
    80005758:	00008067          	ret

000000008000575c <usertrap>:
    8000575c:	ff010113          	addi	sp,sp,-16
    80005760:	00813423          	sd	s0,8(sp)
    80005764:	01010413          	addi	s0,sp,16
    80005768:	00813403          	ld	s0,8(sp)
    8000576c:	01010113          	addi	sp,sp,16
    80005770:	00008067          	ret

0000000080005774 <usertrapret>:
    80005774:	ff010113          	addi	sp,sp,-16
    80005778:	00813423          	sd	s0,8(sp)
    8000577c:	01010413          	addi	s0,sp,16
    80005780:	00813403          	ld	s0,8(sp)
    80005784:	01010113          	addi	sp,sp,16
    80005788:	00008067          	ret

000000008000578c <kerneltrap>:
    8000578c:	fe010113          	addi	sp,sp,-32
    80005790:	00813823          	sd	s0,16(sp)
    80005794:	00113c23          	sd	ra,24(sp)
    80005798:	00913423          	sd	s1,8(sp)
    8000579c:	02010413          	addi	s0,sp,32
    800057a0:	142025f3          	csrr	a1,scause
    800057a4:	100027f3          	csrr	a5,sstatus
    800057a8:	0027f793          	andi	a5,a5,2
    800057ac:	10079c63          	bnez	a5,800058c4 <kerneltrap+0x138>
    800057b0:	142027f3          	csrr	a5,scause
    800057b4:	0207ce63          	bltz	a5,800057f0 <kerneltrap+0x64>
    800057b8:	00003517          	auipc	a0,0x3
    800057bc:	ef850513          	addi	a0,a0,-264 # 800086b0 <CONSOLE_STATUS+0x6a0>
    800057c0:	00001097          	auipc	ra,0x1
    800057c4:	888080e7          	jalr	-1912(ra) # 80006048 <__printf>
    800057c8:	141025f3          	csrr	a1,sepc
    800057cc:	14302673          	csrr	a2,stval
    800057d0:	00003517          	auipc	a0,0x3
    800057d4:	ef050513          	addi	a0,a0,-272 # 800086c0 <CONSOLE_STATUS+0x6b0>
    800057d8:	00001097          	auipc	ra,0x1
    800057dc:	870080e7          	jalr	-1936(ra) # 80006048 <__printf>
    800057e0:	00003517          	auipc	a0,0x3
    800057e4:	ef850513          	addi	a0,a0,-264 # 800086d8 <CONSOLE_STATUS+0x6c8>
    800057e8:	00001097          	auipc	ra,0x1
    800057ec:	804080e7          	jalr	-2044(ra) # 80005fec <panic>
    800057f0:	0ff7f713          	andi	a4,a5,255
    800057f4:	00900693          	li	a3,9
    800057f8:	04d70063          	beq	a4,a3,80005838 <kerneltrap+0xac>
    800057fc:	fff00713          	li	a4,-1
    80005800:	03f71713          	slli	a4,a4,0x3f
    80005804:	00170713          	addi	a4,a4,1
    80005808:	fae798e3          	bne	a5,a4,800057b8 <kerneltrap+0x2c>
    8000580c:	00000097          	auipc	ra,0x0
    80005810:	e00080e7          	jalr	-512(ra) # 8000560c <cpuid>
    80005814:	06050663          	beqz	a0,80005880 <kerneltrap+0xf4>
    80005818:	144027f3          	csrr	a5,sip
    8000581c:	ffd7f793          	andi	a5,a5,-3
    80005820:	14479073          	csrw	sip,a5
    80005824:	01813083          	ld	ra,24(sp)
    80005828:	01013403          	ld	s0,16(sp)
    8000582c:	00813483          	ld	s1,8(sp)
    80005830:	02010113          	addi	sp,sp,32
    80005834:	00008067          	ret
    80005838:	00000097          	auipc	ra,0x0
    8000583c:	3cc080e7          	jalr	972(ra) # 80005c04 <plic_claim>
    80005840:	00a00793          	li	a5,10
    80005844:	00050493          	mv	s1,a0
    80005848:	06f50863          	beq	a0,a5,800058b8 <kerneltrap+0x12c>
    8000584c:	fc050ce3          	beqz	a0,80005824 <kerneltrap+0x98>
    80005850:	00050593          	mv	a1,a0
    80005854:	00003517          	auipc	a0,0x3
    80005858:	e3c50513          	addi	a0,a0,-452 # 80008690 <CONSOLE_STATUS+0x680>
    8000585c:	00000097          	auipc	ra,0x0
    80005860:	7ec080e7          	jalr	2028(ra) # 80006048 <__printf>
    80005864:	01013403          	ld	s0,16(sp)
    80005868:	01813083          	ld	ra,24(sp)
    8000586c:	00048513          	mv	a0,s1
    80005870:	00813483          	ld	s1,8(sp)
    80005874:	02010113          	addi	sp,sp,32
    80005878:	00000317          	auipc	t1,0x0
    8000587c:	3c430067          	jr	964(t1) # 80005c3c <plic_complete>
    80005880:	00007517          	auipc	a0,0x7
    80005884:	aa050513          	addi	a0,a0,-1376 # 8000c320 <tickslock>
    80005888:	00001097          	auipc	ra,0x1
    8000588c:	494080e7          	jalr	1172(ra) # 80006d1c <acquire>
    80005890:	00005717          	auipc	a4,0x5
    80005894:	76470713          	addi	a4,a4,1892 # 8000aff4 <ticks>
    80005898:	00072783          	lw	a5,0(a4)
    8000589c:	00007517          	auipc	a0,0x7
    800058a0:	a8450513          	addi	a0,a0,-1404 # 8000c320 <tickslock>
    800058a4:	0017879b          	addiw	a5,a5,1
    800058a8:	00f72023          	sw	a5,0(a4)
    800058ac:	00001097          	auipc	ra,0x1
    800058b0:	53c080e7          	jalr	1340(ra) # 80006de8 <release>
    800058b4:	f65ff06f          	j	80005818 <kerneltrap+0x8c>
    800058b8:	00001097          	auipc	ra,0x1
    800058bc:	098080e7          	jalr	152(ra) # 80006950 <uartintr>
    800058c0:	fa5ff06f          	j	80005864 <kerneltrap+0xd8>
    800058c4:	00003517          	auipc	a0,0x3
    800058c8:	dac50513          	addi	a0,a0,-596 # 80008670 <CONSOLE_STATUS+0x660>
    800058cc:	00000097          	auipc	ra,0x0
    800058d0:	720080e7          	jalr	1824(ra) # 80005fec <panic>

00000000800058d4 <clockintr>:
    800058d4:	fe010113          	addi	sp,sp,-32
    800058d8:	00813823          	sd	s0,16(sp)
    800058dc:	00913423          	sd	s1,8(sp)
    800058e0:	00113c23          	sd	ra,24(sp)
    800058e4:	02010413          	addi	s0,sp,32
    800058e8:	00007497          	auipc	s1,0x7
    800058ec:	a3848493          	addi	s1,s1,-1480 # 8000c320 <tickslock>
    800058f0:	00048513          	mv	a0,s1
    800058f4:	00001097          	auipc	ra,0x1
    800058f8:	428080e7          	jalr	1064(ra) # 80006d1c <acquire>
    800058fc:	00005717          	auipc	a4,0x5
    80005900:	6f870713          	addi	a4,a4,1784 # 8000aff4 <ticks>
    80005904:	00072783          	lw	a5,0(a4)
    80005908:	01013403          	ld	s0,16(sp)
    8000590c:	01813083          	ld	ra,24(sp)
    80005910:	00048513          	mv	a0,s1
    80005914:	0017879b          	addiw	a5,a5,1
    80005918:	00813483          	ld	s1,8(sp)
    8000591c:	00f72023          	sw	a5,0(a4)
    80005920:	02010113          	addi	sp,sp,32
    80005924:	00001317          	auipc	t1,0x1
    80005928:	4c430067          	jr	1220(t1) # 80006de8 <release>

000000008000592c <devintr>:
    8000592c:	142027f3          	csrr	a5,scause
    80005930:	00000513          	li	a0,0
    80005934:	0007c463          	bltz	a5,8000593c <devintr+0x10>
    80005938:	00008067          	ret
    8000593c:	fe010113          	addi	sp,sp,-32
    80005940:	00813823          	sd	s0,16(sp)
    80005944:	00113c23          	sd	ra,24(sp)
    80005948:	00913423          	sd	s1,8(sp)
    8000594c:	02010413          	addi	s0,sp,32
    80005950:	0ff7f713          	andi	a4,a5,255
    80005954:	00900693          	li	a3,9
    80005958:	04d70c63          	beq	a4,a3,800059b0 <devintr+0x84>
    8000595c:	fff00713          	li	a4,-1
    80005960:	03f71713          	slli	a4,a4,0x3f
    80005964:	00170713          	addi	a4,a4,1
    80005968:	00e78c63          	beq	a5,a4,80005980 <devintr+0x54>
    8000596c:	01813083          	ld	ra,24(sp)
    80005970:	01013403          	ld	s0,16(sp)
    80005974:	00813483          	ld	s1,8(sp)
    80005978:	02010113          	addi	sp,sp,32
    8000597c:	00008067          	ret
    80005980:	00000097          	auipc	ra,0x0
    80005984:	c8c080e7          	jalr	-884(ra) # 8000560c <cpuid>
    80005988:	06050663          	beqz	a0,800059f4 <devintr+0xc8>
    8000598c:	144027f3          	csrr	a5,sip
    80005990:	ffd7f793          	andi	a5,a5,-3
    80005994:	14479073          	csrw	sip,a5
    80005998:	01813083          	ld	ra,24(sp)
    8000599c:	01013403          	ld	s0,16(sp)
    800059a0:	00813483          	ld	s1,8(sp)
    800059a4:	00200513          	li	a0,2
    800059a8:	02010113          	addi	sp,sp,32
    800059ac:	00008067          	ret
    800059b0:	00000097          	auipc	ra,0x0
    800059b4:	254080e7          	jalr	596(ra) # 80005c04 <plic_claim>
    800059b8:	00a00793          	li	a5,10
    800059bc:	00050493          	mv	s1,a0
    800059c0:	06f50663          	beq	a0,a5,80005a2c <devintr+0x100>
    800059c4:	00100513          	li	a0,1
    800059c8:	fa0482e3          	beqz	s1,8000596c <devintr+0x40>
    800059cc:	00048593          	mv	a1,s1
    800059d0:	00003517          	auipc	a0,0x3
    800059d4:	cc050513          	addi	a0,a0,-832 # 80008690 <CONSOLE_STATUS+0x680>
    800059d8:	00000097          	auipc	ra,0x0
    800059dc:	670080e7          	jalr	1648(ra) # 80006048 <__printf>
    800059e0:	00048513          	mv	a0,s1
    800059e4:	00000097          	auipc	ra,0x0
    800059e8:	258080e7          	jalr	600(ra) # 80005c3c <plic_complete>
    800059ec:	00100513          	li	a0,1
    800059f0:	f7dff06f          	j	8000596c <devintr+0x40>
    800059f4:	00007517          	auipc	a0,0x7
    800059f8:	92c50513          	addi	a0,a0,-1748 # 8000c320 <tickslock>
    800059fc:	00001097          	auipc	ra,0x1
    80005a00:	320080e7          	jalr	800(ra) # 80006d1c <acquire>
    80005a04:	00005717          	auipc	a4,0x5
    80005a08:	5f070713          	addi	a4,a4,1520 # 8000aff4 <ticks>
    80005a0c:	00072783          	lw	a5,0(a4)
    80005a10:	00007517          	auipc	a0,0x7
    80005a14:	91050513          	addi	a0,a0,-1776 # 8000c320 <tickslock>
    80005a18:	0017879b          	addiw	a5,a5,1
    80005a1c:	00f72023          	sw	a5,0(a4)
    80005a20:	00001097          	auipc	ra,0x1
    80005a24:	3c8080e7          	jalr	968(ra) # 80006de8 <release>
    80005a28:	f65ff06f          	j	8000598c <devintr+0x60>
    80005a2c:	00001097          	auipc	ra,0x1
    80005a30:	f24080e7          	jalr	-220(ra) # 80006950 <uartintr>
    80005a34:	fadff06f          	j	800059e0 <devintr+0xb4>
	...

0000000080005a40 <kernelvec>:
    80005a40:	f0010113          	addi	sp,sp,-256
    80005a44:	00113023          	sd	ra,0(sp)
    80005a48:	00213423          	sd	sp,8(sp)
    80005a4c:	00313823          	sd	gp,16(sp)
    80005a50:	00413c23          	sd	tp,24(sp)
    80005a54:	02513023          	sd	t0,32(sp)
    80005a58:	02613423          	sd	t1,40(sp)
    80005a5c:	02713823          	sd	t2,48(sp)
    80005a60:	02813c23          	sd	s0,56(sp)
    80005a64:	04913023          	sd	s1,64(sp)
    80005a68:	04a13423          	sd	a0,72(sp)
    80005a6c:	04b13823          	sd	a1,80(sp)
    80005a70:	04c13c23          	sd	a2,88(sp)
    80005a74:	06d13023          	sd	a3,96(sp)
    80005a78:	06e13423          	sd	a4,104(sp)
    80005a7c:	06f13823          	sd	a5,112(sp)
    80005a80:	07013c23          	sd	a6,120(sp)
    80005a84:	09113023          	sd	a7,128(sp)
    80005a88:	09213423          	sd	s2,136(sp)
    80005a8c:	09313823          	sd	s3,144(sp)
    80005a90:	09413c23          	sd	s4,152(sp)
    80005a94:	0b513023          	sd	s5,160(sp)
    80005a98:	0b613423          	sd	s6,168(sp)
    80005a9c:	0b713823          	sd	s7,176(sp)
    80005aa0:	0b813c23          	sd	s8,184(sp)
    80005aa4:	0d913023          	sd	s9,192(sp)
    80005aa8:	0da13423          	sd	s10,200(sp)
    80005aac:	0db13823          	sd	s11,208(sp)
    80005ab0:	0dc13c23          	sd	t3,216(sp)
    80005ab4:	0fd13023          	sd	t4,224(sp)
    80005ab8:	0fe13423          	sd	t5,232(sp)
    80005abc:	0ff13823          	sd	t6,240(sp)
    80005ac0:	ccdff0ef          	jal	ra,8000578c <kerneltrap>
    80005ac4:	00013083          	ld	ra,0(sp)
    80005ac8:	00813103          	ld	sp,8(sp)
    80005acc:	01013183          	ld	gp,16(sp)
    80005ad0:	02013283          	ld	t0,32(sp)
    80005ad4:	02813303          	ld	t1,40(sp)
    80005ad8:	03013383          	ld	t2,48(sp)
    80005adc:	03813403          	ld	s0,56(sp)
    80005ae0:	04013483          	ld	s1,64(sp)
    80005ae4:	04813503          	ld	a0,72(sp)
    80005ae8:	05013583          	ld	a1,80(sp)
    80005aec:	05813603          	ld	a2,88(sp)
    80005af0:	06013683          	ld	a3,96(sp)
    80005af4:	06813703          	ld	a4,104(sp)
    80005af8:	07013783          	ld	a5,112(sp)
    80005afc:	07813803          	ld	a6,120(sp)
    80005b00:	08013883          	ld	a7,128(sp)
    80005b04:	08813903          	ld	s2,136(sp)
    80005b08:	09013983          	ld	s3,144(sp)
    80005b0c:	09813a03          	ld	s4,152(sp)
    80005b10:	0a013a83          	ld	s5,160(sp)
    80005b14:	0a813b03          	ld	s6,168(sp)
    80005b18:	0b013b83          	ld	s7,176(sp)
    80005b1c:	0b813c03          	ld	s8,184(sp)
    80005b20:	0c013c83          	ld	s9,192(sp)
    80005b24:	0c813d03          	ld	s10,200(sp)
    80005b28:	0d013d83          	ld	s11,208(sp)
    80005b2c:	0d813e03          	ld	t3,216(sp)
    80005b30:	0e013e83          	ld	t4,224(sp)
    80005b34:	0e813f03          	ld	t5,232(sp)
    80005b38:	0f013f83          	ld	t6,240(sp)
    80005b3c:	10010113          	addi	sp,sp,256
    80005b40:	10200073          	sret
    80005b44:	00000013          	nop
    80005b48:	00000013          	nop
    80005b4c:	00000013          	nop

0000000080005b50 <timervec>:
    80005b50:	34051573          	csrrw	a0,mscratch,a0
    80005b54:	00b53023          	sd	a1,0(a0)
    80005b58:	00c53423          	sd	a2,8(a0)
    80005b5c:	00d53823          	sd	a3,16(a0)
    80005b60:	01853583          	ld	a1,24(a0)
    80005b64:	02053603          	ld	a2,32(a0)
    80005b68:	0005b683          	ld	a3,0(a1)
    80005b6c:	00c686b3          	add	a3,a3,a2
    80005b70:	00d5b023          	sd	a3,0(a1)
    80005b74:	00200593          	li	a1,2
    80005b78:	14459073          	csrw	sip,a1
    80005b7c:	01053683          	ld	a3,16(a0)
    80005b80:	00853603          	ld	a2,8(a0)
    80005b84:	00053583          	ld	a1,0(a0)
    80005b88:	34051573          	csrrw	a0,mscratch,a0
    80005b8c:	30200073          	mret

0000000080005b90 <plicinit>:
    80005b90:	ff010113          	addi	sp,sp,-16
    80005b94:	00813423          	sd	s0,8(sp)
    80005b98:	01010413          	addi	s0,sp,16
    80005b9c:	00813403          	ld	s0,8(sp)
    80005ba0:	0c0007b7          	lui	a5,0xc000
    80005ba4:	00100713          	li	a4,1
    80005ba8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80005bac:	00e7a223          	sw	a4,4(a5)
    80005bb0:	01010113          	addi	sp,sp,16
    80005bb4:	00008067          	ret

0000000080005bb8 <plicinithart>:
    80005bb8:	ff010113          	addi	sp,sp,-16
    80005bbc:	00813023          	sd	s0,0(sp)
    80005bc0:	00113423          	sd	ra,8(sp)
    80005bc4:	01010413          	addi	s0,sp,16
    80005bc8:	00000097          	auipc	ra,0x0
    80005bcc:	a44080e7          	jalr	-1468(ra) # 8000560c <cpuid>
    80005bd0:	0085171b          	slliw	a4,a0,0x8
    80005bd4:	0c0027b7          	lui	a5,0xc002
    80005bd8:	00e787b3          	add	a5,a5,a4
    80005bdc:	40200713          	li	a4,1026
    80005be0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005be4:	00813083          	ld	ra,8(sp)
    80005be8:	00013403          	ld	s0,0(sp)
    80005bec:	00d5151b          	slliw	a0,a0,0xd
    80005bf0:	0c2017b7          	lui	a5,0xc201
    80005bf4:	00a78533          	add	a0,a5,a0
    80005bf8:	00052023          	sw	zero,0(a0)
    80005bfc:	01010113          	addi	sp,sp,16
    80005c00:	00008067          	ret

0000000080005c04 <plic_claim>:
    80005c04:	ff010113          	addi	sp,sp,-16
    80005c08:	00813023          	sd	s0,0(sp)
    80005c0c:	00113423          	sd	ra,8(sp)
    80005c10:	01010413          	addi	s0,sp,16
    80005c14:	00000097          	auipc	ra,0x0
    80005c18:	9f8080e7          	jalr	-1544(ra) # 8000560c <cpuid>
    80005c1c:	00813083          	ld	ra,8(sp)
    80005c20:	00013403          	ld	s0,0(sp)
    80005c24:	00d5151b          	slliw	a0,a0,0xd
    80005c28:	0c2017b7          	lui	a5,0xc201
    80005c2c:	00a78533          	add	a0,a5,a0
    80005c30:	00452503          	lw	a0,4(a0)
    80005c34:	01010113          	addi	sp,sp,16
    80005c38:	00008067          	ret

0000000080005c3c <plic_complete>:
    80005c3c:	fe010113          	addi	sp,sp,-32
    80005c40:	00813823          	sd	s0,16(sp)
    80005c44:	00913423          	sd	s1,8(sp)
    80005c48:	00113c23          	sd	ra,24(sp)
    80005c4c:	02010413          	addi	s0,sp,32
    80005c50:	00050493          	mv	s1,a0
    80005c54:	00000097          	auipc	ra,0x0
    80005c58:	9b8080e7          	jalr	-1608(ra) # 8000560c <cpuid>
    80005c5c:	01813083          	ld	ra,24(sp)
    80005c60:	01013403          	ld	s0,16(sp)
    80005c64:	00d5179b          	slliw	a5,a0,0xd
    80005c68:	0c201737          	lui	a4,0xc201
    80005c6c:	00f707b3          	add	a5,a4,a5
    80005c70:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005c74:	00813483          	ld	s1,8(sp)
    80005c78:	02010113          	addi	sp,sp,32
    80005c7c:	00008067          	ret

0000000080005c80 <consolewrite>:
    80005c80:	fb010113          	addi	sp,sp,-80
    80005c84:	04813023          	sd	s0,64(sp)
    80005c88:	04113423          	sd	ra,72(sp)
    80005c8c:	02913c23          	sd	s1,56(sp)
    80005c90:	03213823          	sd	s2,48(sp)
    80005c94:	03313423          	sd	s3,40(sp)
    80005c98:	03413023          	sd	s4,32(sp)
    80005c9c:	01513c23          	sd	s5,24(sp)
    80005ca0:	05010413          	addi	s0,sp,80
    80005ca4:	06c05c63          	blez	a2,80005d1c <consolewrite+0x9c>
    80005ca8:	00060993          	mv	s3,a2
    80005cac:	00050a13          	mv	s4,a0
    80005cb0:	00058493          	mv	s1,a1
    80005cb4:	00000913          	li	s2,0
    80005cb8:	fff00a93          	li	s5,-1
    80005cbc:	01c0006f          	j	80005cd8 <consolewrite+0x58>
    80005cc0:	fbf44503          	lbu	a0,-65(s0)
    80005cc4:	0019091b          	addiw	s2,s2,1
    80005cc8:	00148493          	addi	s1,s1,1
    80005ccc:	00001097          	auipc	ra,0x1
    80005cd0:	a9c080e7          	jalr	-1380(ra) # 80006768 <uartputc>
    80005cd4:	03298063          	beq	s3,s2,80005cf4 <consolewrite+0x74>
    80005cd8:	00048613          	mv	a2,s1
    80005cdc:	00100693          	li	a3,1
    80005ce0:	000a0593          	mv	a1,s4
    80005ce4:	fbf40513          	addi	a0,s0,-65
    80005ce8:	00000097          	auipc	ra,0x0
    80005cec:	9dc080e7          	jalr	-1572(ra) # 800056c4 <either_copyin>
    80005cf0:	fd5518e3          	bne	a0,s5,80005cc0 <consolewrite+0x40>
    80005cf4:	04813083          	ld	ra,72(sp)
    80005cf8:	04013403          	ld	s0,64(sp)
    80005cfc:	03813483          	ld	s1,56(sp)
    80005d00:	02813983          	ld	s3,40(sp)
    80005d04:	02013a03          	ld	s4,32(sp)
    80005d08:	01813a83          	ld	s5,24(sp)
    80005d0c:	00090513          	mv	a0,s2
    80005d10:	03013903          	ld	s2,48(sp)
    80005d14:	05010113          	addi	sp,sp,80
    80005d18:	00008067          	ret
    80005d1c:	00000913          	li	s2,0
    80005d20:	fd5ff06f          	j	80005cf4 <consolewrite+0x74>

0000000080005d24 <consoleread>:
    80005d24:	f9010113          	addi	sp,sp,-112
    80005d28:	06813023          	sd	s0,96(sp)
    80005d2c:	04913c23          	sd	s1,88(sp)
    80005d30:	05213823          	sd	s2,80(sp)
    80005d34:	05313423          	sd	s3,72(sp)
    80005d38:	05413023          	sd	s4,64(sp)
    80005d3c:	03513c23          	sd	s5,56(sp)
    80005d40:	03613823          	sd	s6,48(sp)
    80005d44:	03713423          	sd	s7,40(sp)
    80005d48:	03813023          	sd	s8,32(sp)
    80005d4c:	06113423          	sd	ra,104(sp)
    80005d50:	01913c23          	sd	s9,24(sp)
    80005d54:	07010413          	addi	s0,sp,112
    80005d58:	00060b93          	mv	s7,a2
    80005d5c:	00050913          	mv	s2,a0
    80005d60:	00058c13          	mv	s8,a1
    80005d64:	00060b1b          	sext.w	s6,a2
    80005d68:	00006497          	auipc	s1,0x6
    80005d6c:	5e048493          	addi	s1,s1,1504 # 8000c348 <cons>
    80005d70:	00400993          	li	s3,4
    80005d74:	fff00a13          	li	s4,-1
    80005d78:	00a00a93          	li	s5,10
    80005d7c:	05705e63          	blez	s7,80005dd8 <consoleread+0xb4>
    80005d80:	09c4a703          	lw	a4,156(s1)
    80005d84:	0984a783          	lw	a5,152(s1)
    80005d88:	0007071b          	sext.w	a4,a4
    80005d8c:	08e78463          	beq	a5,a4,80005e14 <consoleread+0xf0>
    80005d90:	07f7f713          	andi	a4,a5,127
    80005d94:	00e48733          	add	a4,s1,a4
    80005d98:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005d9c:	0017869b          	addiw	a3,a5,1
    80005da0:	08d4ac23          	sw	a3,152(s1)
    80005da4:	00070c9b          	sext.w	s9,a4
    80005da8:	0b370663          	beq	a4,s3,80005e54 <consoleread+0x130>
    80005dac:	00100693          	li	a3,1
    80005db0:	f9f40613          	addi	a2,s0,-97
    80005db4:	000c0593          	mv	a1,s8
    80005db8:	00090513          	mv	a0,s2
    80005dbc:	f8e40fa3          	sb	a4,-97(s0)
    80005dc0:	00000097          	auipc	ra,0x0
    80005dc4:	8b8080e7          	jalr	-1864(ra) # 80005678 <either_copyout>
    80005dc8:	01450863          	beq	a0,s4,80005dd8 <consoleread+0xb4>
    80005dcc:	001c0c13          	addi	s8,s8,1
    80005dd0:	fffb8b9b          	addiw	s7,s7,-1
    80005dd4:	fb5c94e3          	bne	s9,s5,80005d7c <consoleread+0x58>
    80005dd8:	000b851b          	sext.w	a0,s7
    80005ddc:	06813083          	ld	ra,104(sp)
    80005de0:	06013403          	ld	s0,96(sp)
    80005de4:	05813483          	ld	s1,88(sp)
    80005de8:	05013903          	ld	s2,80(sp)
    80005dec:	04813983          	ld	s3,72(sp)
    80005df0:	04013a03          	ld	s4,64(sp)
    80005df4:	03813a83          	ld	s5,56(sp)
    80005df8:	02813b83          	ld	s7,40(sp)
    80005dfc:	02013c03          	ld	s8,32(sp)
    80005e00:	01813c83          	ld	s9,24(sp)
    80005e04:	40ab053b          	subw	a0,s6,a0
    80005e08:	03013b03          	ld	s6,48(sp)
    80005e0c:	07010113          	addi	sp,sp,112
    80005e10:	00008067          	ret
    80005e14:	00001097          	auipc	ra,0x1
    80005e18:	1d8080e7          	jalr	472(ra) # 80006fec <push_on>
    80005e1c:	0984a703          	lw	a4,152(s1)
    80005e20:	09c4a783          	lw	a5,156(s1)
    80005e24:	0007879b          	sext.w	a5,a5
    80005e28:	fef70ce3          	beq	a4,a5,80005e20 <consoleread+0xfc>
    80005e2c:	00001097          	auipc	ra,0x1
    80005e30:	234080e7          	jalr	564(ra) # 80007060 <pop_on>
    80005e34:	0984a783          	lw	a5,152(s1)
    80005e38:	07f7f713          	andi	a4,a5,127
    80005e3c:	00e48733          	add	a4,s1,a4
    80005e40:	01874703          	lbu	a4,24(a4)
    80005e44:	0017869b          	addiw	a3,a5,1
    80005e48:	08d4ac23          	sw	a3,152(s1)
    80005e4c:	00070c9b          	sext.w	s9,a4
    80005e50:	f5371ee3          	bne	a4,s3,80005dac <consoleread+0x88>
    80005e54:	000b851b          	sext.w	a0,s7
    80005e58:	f96bf2e3          	bgeu	s7,s6,80005ddc <consoleread+0xb8>
    80005e5c:	08f4ac23          	sw	a5,152(s1)
    80005e60:	f7dff06f          	j	80005ddc <consoleread+0xb8>

0000000080005e64 <consputc>:
    80005e64:	10000793          	li	a5,256
    80005e68:	00f50663          	beq	a0,a5,80005e74 <consputc+0x10>
    80005e6c:	00001317          	auipc	t1,0x1
    80005e70:	9f430067          	jr	-1548(t1) # 80006860 <uartputc_sync>
    80005e74:	ff010113          	addi	sp,sp,-16
    80005e78:	00113423          	sd	ra,8(sp)
    80005e7c:	00813023          	sd	s0,0(sp)
    80005e80:	01010413          	addi	s0,sp,16
    80005e84:	00800513          	li	a0,8
    80005e88:	00001097          	auipc	ra,0x1
    80005e8c:	9d8080e7          	jalr	-1576(ra) # 80006860 <uartputc_sync>
    80005e90:	02000513          	li	a0,32
    80005e94:	00001097          	auipc	ra,0x1
    80005e98:	9cc080e7          	jalr	-1588(ra) # 80006860 <uartputc_sync>
    80005e9c:	00013403          	ld	s0,0(sp)
    80005ea0:	00813083          	ld	ra,8(sp)
    80005ea4:	00800513          	li	a0,8
    80005ea8:	01010113          	addi	sp,sp,16
    80005eac:	00001317          	auipc	t1,0x1
    80005eb0:	9b430067          	jr	-1612(t1) # 80006860 <uartputc_sync>

0000000080005eb4 <consoleintr>:
    80005eb4:	fe010113          	addi	sp,sp,-32
    80005eb8:	00813823          	sd	s0,16(sp)
    80005ebc:	00913423          	sd	s1,8(sp)
    80005ec0:	01213023          	sd	s2,0(sp)
    80005ec4:	00113c23          	sd	ra,24(sp)
    80005ec8:	02010413          	addi	s0,sp,32
    80005ecc:	00006917          	auipc	s2,0x6
    80005ed0:	47c90913          	addi	s2,s2,1148 # 8000c348 <cons>
    80005ed4:	00050493          	mv	s1,a0
    80005ed8:	00090513          	mv	a0,s2
    80005edc:	00001097          	auipc	ra,0x1
    80005ee0:	e40080e7          	jalr	-448(ra) # 80006d1c <acquire>
    80005ee4:	02048c63          	beqz	s1,80005f1c <consoleintr+0x68>
    80005ee8:	0a092783          	lw	a5,160(s2)
    80005eec:	09892703          	lw	a4,152(s2)
    80005ef0:	07f00693          	li	a3,127
    80005ef4:	40e7873b          	subw	a4,a5,a4
    80005ef8:	02e6e263          	bltu	a3,a4,80005f1c <consoleintr+0x68>
    80005efc:	00d00713          	li	a4,13
    80005f00:	04e48063          	beq	s1,a4,80005f40 <consoleintr+0x8c>
    80005f04:	07f7f713          	andi	a4,a5,127
    80005f08:	00e90733          	add	a4,s2,a4
    80005f0c:	0017879b          	addiw	a5,a5,1
    80005f10:	0af92023          	sw	a5,160(s2)
    80005f14:	00970c23          	sb	s1,24(a4)
    80005f18:	08f92e23          	sw	a5,156(s2)
    80005f1c:	01013403          	ld	s0,16(sp)
    80005f20:	01813083          	ld	ra,24(sp)
    80005f24:	00813483          	ld	s1,8(sp)
    80005f28:	00013903          	ld	s2,0(sp)
    80005f2c:	00006517          	auipc	a0,0x6
    80005f30:	41c50513          	addi	a0,a0,1052 # 8000c348 <cons>
    80005f34:	02010113          	addi	sp,sp,32
    80005f38:	00001317          	auipc	t1,0x1
    80005f3c:	eb030067          	jr	-336(t1) # 80006de8 <release>
    80005f40:	00a00493          	li	s1,10
    80005f44:	fc1ff06f          	j	80005f04 <consoleintr+0x50>

0000000080005f48 <consoleinit>:
    80005f48:	fe010113          	addi	sp,sp,-32
    80005f4c:	00113c23          	sd	ra,24(sp)
    80005f50:	00813823          	sd	s0,16(sp)
    80005f54:	00913423          	sd	s1,8(sp)
    80005f58:	02010413          	addi	s0,sp,32
    80005f5c:	00006497          	auipc	s1,0x6
    80005f60:	3ec48493          	addi	s1,s1,1004 # 8000c348 <cons>
    80005f64:	00048513          	mv	a0,s1
    80005f68:	00002597          	auipc	a1,0x2
    80005f6c:	78058593          	addi	a1,a1,1920 # 800086e8 <CONSOLE_STATUS+0x6d8>
    80005f70:	00001097          	auipc	ra,0x1
    80005f74:	d88080e7          	jalr	-632(ra) # 80006cf8 <initlock>
    80005f78:	00000097          	auipc	ra,0x0
    80005f7c:	7ac080e7          	jalr	1964(ra) # 80006724 <uartinit>
    80005f80:	01813083          	ld	ra,24(sp)
    80005f84:	01013403          	ld	s0,16(sp)
    80005f88:	00000797          	auipc	a5,0x0
    80005f8c:	d9c78793          	addi	a5,a5,-612 # 80005d24 <consoleread>
    80005f90:	0af4bc23          	sd	a5,184(s1)
    80005f94:	00000797          	auipc	a5,0x0
    80005f98:	cec78793          	addi	a5,a5,-788 # 80005c80 <consolewrite>
    80005f9c:	0cf4b023          	sd	a5,192(s1)
    80005fa0:	00813483          	ld	s1,8(sp)
    80005fa4:	02010113          	addi	sp,sp,32
    80005fa8:	00008067          	ret

0000000080005fac <console_read>:
    80005fac:	ff010113          	addi	sp,sp,-16
    80005fb0:	00813423          	sd	s0,8(sp)
    80005fb4:	01010413          	addi	s0,sp,16
    80005fb8:	00813403          	ld	s0,8(sp)
    80005fbc:	00006317          	auipc	t1,0x6
    80005fc0:	44433303          	ld	t1,1092(t1) # 8000c400 <devsw+0x10>
    80005fc4:	01010113          	addi	sp,sp,16
    80005fc8:	00030067          	jr	t1

0000000080005fcc <console_write>:
    80005fcc:	ff010113          	addi	sp,sp,-16
    80005fd0:	00813423          	sd	s0,8(sp)
    80005fd4:	01010413          	addi	s0,sp,16
    80005fd8:	00813403          	ld	s0,8(sp)
    80005fdc:	00006317          	auipc	t1,0x6
    80005fe0:	42c33303          	ld	t1,1068(t1) # 8000c408 <devsw+0x18>
    80005fe4:	01010113          	addi	sp,sp,16
    80005fe8:	00030067          	jr	t1

0000000080005fec <panic>:
    80005fec:	fe010113          	addi	sp,sp,-32
    80005ff0:	00113c23          	sd	ra,24(sp)
    80005ff4:	00813823          	sd	s0,16(sp)
    80005ff8:	00913423          	sd	s1,8(sp)
    80005ffc:	02010413          	addi	s0,sp,32
    80006000:	00050493          	mv	s1,a0
    80006004:	00002517          	auipc	a0,0x2
    80006008:	6ec50513          	addi	a0,a0,1772 # 800086f0 <CONSOLE_STATUS+0x6e0>
    8000600c:	00006797          	auipc	a5,0x6
    80006010:	4807ae23          	sw	zero,1180(a5) # 8000c4a8 <pr+0x18>
    80006014:	00000097          	auipc	ra,0x0
    80006018:	034080e7          	jalr	52(ra) # 80006048 <__printf>
    8000601c:	00048513          	mv	a0,s1
    80006020:	00000097          	auipc	ra,0x0
    80006024:	028080e7          	jalr	40(ra) # 80006048 <__printf>
    80006028:	00002517          	auipc	a0,0x2
    8000602c:	38050513          	addi	a0,a0,896 # 800083a8 <CONSOLE_STATUS+0x398>
    80006030:	00000097          	auipc	ra,0x0
    80006034:	018080e7          	jalr	24(ra) # 80006048 <__printf>
    80006038:	00100793          	li	a5,1
    8000603c:	00005717          	auipc	a4,0x5
    80006040:	faf72e23          	sw	a5,-68(a4) # 8000aff8 <panicked>
    80006044:	0000006f          	j	80006044 <panic+0x58>

0000000080006048 <__printf>:
    80006048:	f3010113          	addi	sp,sp,-208
    8000604c:	08813023          	sd	s0,128(sp)
    80006050:	07313423          	sd	s3,104(sp)
    80006054:	09010413          	addi	s0,sp,144
    80006058:	05813023          	sd	s8,64(sp)
    8000605c:	08113423          	sd	ra,136(sp)
    80006060:	06913c23          	sd	s1,120(sp)
    80006064:	07213823          	sd	s2,112(sp)
    80006068:	07413023          	sd	s4,96(sp)
    8000606c:	05513c23          	sd	s5,88(sp)
    80006070:	05613823          	sd	s6,80(sp)
    80006074:	05713423          	sd	s7,72(sp)
    80006078:	03913c23          	sd	s9,56(sp)
    8000607c:	03a13823          	sd	s10,48(sp)
    80006080:	03b13423          	sd	s11,40(sp)
    80006084:	00006317          	auipc	t1,0x6
    80006088:	40c30313          	addi	t1,t1,1036 # 8000c490 <pr>
    8000608c:	01832c03          	lw	s8,24(t1)
    80006090:	00b43423          	sd	a1,8(s0)
    80006094:	00c43823          	sd	a2,16(s0)
    80006098:	00d43c23          	sd	a3,24(s0)
    8000609c:	02e43023          	sd	a4,32(s0)
    800060a0:	02f43423          	sd	a5,40(s0)
    800060a4:	03043823          	sd	a6,48(s0)
    800060a8:	03143c23          	sd	a7,56(s0)
    800060ac:	00050993          	mv	s3,a0
    800060b0:	4a0c1663          	bnez	s8,8000655c <__printf+0x514>
    800060b4:	60098c63          	beqz	s3,800066cc <__printf+0x684>
    800060b8:	0009c503          	lbu	a0,0(s3)
    800060bc:	00840793          	addi	a5,s0,8
    800060c0:	f6f43c23          	sd	a5,-136(s0)
    800060c4:	00000493          	li	s1,0
    800060c8:	22050063          	beqz	a0,800062e8 <__printf+0x2a0>
    800060cc:	00002a37          	lui	s4,0x2
    800060d0:	00018ab7          	lui	s5,0x18
    800060d4:	000f4b37          	lui	s6,0xf4
    800060d8:	00989bb7          	lui	s7,0x989
    800060dc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800060e0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800060e4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800060e8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800060ec:	00148c9b          	addiw	s9,s1,1
    800060f0:	02500793          	li	a5,37
    800060f4:	01998933          	add	s2,s3,s9
    800060f8:	38f51263          	bne	a0,a5,8000647c <__printf+0x434>
    800060fc:	00094783          	lbu	a5,0(s2)
    80006100:	00078c9b          	sext.w	s9,a5
    80006104:	1e078263          	beqz	a5,800062e8 <__printf+0x2a0>
    80006108:	0024849b          	addiw	s1,s1,2
    8000610c:	07000713          	li	a4,112
    80006110:	00998933          	add	s2,s3,s1
    80006114:	38e78a63          	beq	a5,a4,800064a8 <__printf+0x460>
    80006118:	20f76863          	bltu	a4,a5,80006328 <__printf+0x2e0>
    8000611c:	42a78863          	beq	a5,a0,8000654c <__printf+0x504>
    80006120:	06400713          	li	a4,100
    80006124:	40e79663          	bne	a5,a4,80006530 <__printf+0x4e8>
    80006128:	f7843783          	ld	a5,-136(s0)
    8000612c:	0007a603          	lw	a2,0(a5)
    80006130:	00878793          	addi	a5,a5,8
    80006134:	f6f43c23          	sd	a5,-136(s0)
    80006138:	42064a63          	bltz	a2,8000656c <__printf+0x524>
    8000613c:	00a00713          	li	a4,10
    80006140:	02e677bb          	remuw	a5,a2,a4
    80006144:	00002d97          	auipc	s11,0x2
    80006148:	5d4d8d93          	addi	s11,s11,1492 # 80008718 <digits>
    8000614c:	00900593          	li	a1,9
    80006150:	0006051b          	sext.w	a0,a2
    80006154:	00000c93          	li	s9,0
    80006158:	02079793          	slli	a5,a5,0x20
    8000615c:	0207d793          	srli	a5,a5,0x20
    80006160:	00fd87b3          	add	a5,s11,a5
    80006164:	0007c783          	lbu	a5,0(a5)
    80006168:	02e656bb          	divuw	a3,a2,a4
    8000616c:	f8f40023          	sb	a5,-128(s0)
    80006170:	14c5d863          	bge	a1,a2,800062c0 <__printf+0x278>
    80006174:	06300593          	li	a1,99
    80006178:	00100c93          	li	s9,1
    8000617c:	02e6f7bb          	remuw	a5,a3,a4
    80006180:	02079793          	slli	a5,a5,0x20
    80006184:	0207d793          	srli	a5,a5,0x20
    80006188:	00fd87b3          	add	a5,s11,a5
    8000618c:	0007c783          	lbu	a5,0(a5)
    80006190:	02e6d73b          	divuw	a4,a3,a4
    80006194:	f8f400a3          	sb	a5,-127(s0)
    80006198:	12a5f463          	bgeu	a1,a0,800062c0 <__printf+0x278>
    8000619c:	00a00693          	li	a3,10
    800061a0:	00900593          	li	a1,9
    800061a4:	02d777bb          	remuw	a5,a4,a3
    800061a8:	02079793          	slli	a5,a5,0x20
    800061ac:	0207d793          	srli	a5,a5,0x20
    800061b0:	00fd87b3          	add	a5,s11,a5
    800061b4:	0007c503          	lbu	a0,0(a5)
    800061b8:	02d757bb          	divuw	a5,a4,a3
    800061bc:	f8a40123          	sb	a0,-126(s0)
    800061c0:	48e5f263          	bgeu	a1,a4,80006644 <__printf+0x5fc>
    800061c4:	06300513          	li	a0,99
    800061c8:	02d7f5bb          	remuw	a1,a5,a3
    800061cc:	02059593          	slli	a1,a1,0x20
    800061d0:	0205d593          	srli	a1,a1,0x20
    800061d4:	00bd85b3          	add	a1,s11,a1
    800061d8:	0005c583          	lbu	a1,0(a1)
    800061dc:	02d7d7bb          	divuw	a5,a5,a3
    800061e0:	f8b401a3          	sb	a1,-125(s0)
    800061e4:	48e57263          	bgeu	a0,a4,80006668 <__printf+0x620>
    800061e8:	3e700513          	li	a0,999
    800061ec:	02d7f5bb          	remuw	a1,a5,a3
    800061f0:	02059593          	slli	a1,a1,0x20
    800061f4:	0205d593          	srli	a1,a1,0x20
    800061f8:	00bd85b3          	add	a1,s11,a1
    800061fc:	0005c583          	lbu	a1,0(a1)
    80006200:	02d7d7bb          	divuw	a5,a5,a3
    80006204:	f8b40223          	sb	a1,-124(s0)
    80006208:	46e57663          	bgeu	a0,a4,80006674 <__printf+0x62c>
    8000620c:	02d7f5bb          	remuw	a1,a5,a3
    80006210:	02059593          	slli	a1,a1,0x20
    80006214:	0205d593          	srli	a1,a1,0x20
    80006218:	00bd85b3          	add	a1,s11,a1
    8000621c:	0005c583          	lbu	a1,0(a1)
    80006220:	02d7d7bb          	divuw	a5,a5,a3
    80006224:	f8b402a3          	sb	a1,-123(s0)
    80006228:	46ea7863          	bgeu	s4,a4,80006698 <__printf+0x650>
    8000622c:	02d7f5bb          	remuw	a1,a5,a3
    80006230:	02059593          	slli	a1,a1,0x20
    80006234:	0205d593          	srli	a1,a1,0x20
    80006238:	00bd85b3          	add	a1,s11,a1
    8000623c:	0005c583          	lbu	a1,0(a1)
    80006240:	02d7d7bb          	divuw	a5,a5,a3
    80006244:	f8b40323          	sb	a1,-122(s0)
    80006248:	3eeaf863          	bgeu	s5,a4,80006638 <__printf+0x5f0>
    8000624c:	02d7f5bb          	remuw	a1,a5,a3
    80006250:	02059593          	slli	a1,a1,0x20
    80006254:	0205d593          	srli	a1,a1,0x20
    80006258:	00bd85b3          	add	a1,s11,a1
    8000625c:	0005c583          	lbu	a1,0(a1)
    80006260:	02d7d7bb          	divuw	a5,a5,a3
    80006264:	f8b403a3          	sb	a1,-121(s0)
    80006268:	42eb7e63          	bgeu	s6,a4,800066a4 <__printf+0x65c>
    8000626c:	02d7f5bb          	remuw	a1,a5,a3
    80006270:	02059593          	slli	a1,a1,0x20
    80006274:	0205d593          	srli	a1,a1,0x20
    80006278:	00bd85b3          	add	a1,s11,a1
    8000627c:	0005c583          	lbu	a1,0(a1)
    80006280:	02d7d7bb          	divuw	a5,a5,a3
    80006284:	f8b40423          	sb	a1,-120(s0)
    80006288:	42ebfc63          	bgeu	s7,a4,800066c0 <__printf+0x678>
    8000628c:	02079793          	slli	a5,a5,0x20
    80006290:	0207d793          	srli	a5,a5,0x20
    80006294:	00fd8db3          	add	s11,s11,a5
    80006298:	000dc703          	lbu	a4,0(s11)
    8000629c:	00a00793          	li	a5,10
    800062a0:	00900c93          	li	s9,9
    800062a4:	f8e404a3          	sb	a4,-119(s0)
    800062a8:	00065c63          	bgez	a2,800062c0 <__printf+0x278>
    800062ac:	f9040713          	addi	a4,s0,-112
    800062b0:	00f70733          	add	a4,a4,a5
    800062b4:	02d00693          	li	a3,45
    800062b8:	fed70823          	sb	a3,-16(a4)
    800062bc:	00078c93          	mv	s9,a5
    800062c0:	f8040793          	addi	a5,s0,-128
    800062c4:	01978cb3          	add	s9,a5,s9
    800062c8:	f7f40d13          	addi	s10,s0,-129
    800062cc:	000cc503          	lbu	a0,0(s9)
    800062d0:	fffc8c93          	addi	s9,s9,-1
    800062d4:	00000097          	auipc	ra,0x0
    800062d8:	b90080e7          	jalr	-1136(ra) # 80005e64 <consputc>
    800062dc:	ffac98e3          	bne	s9,s10,800062cc <__printf+0x284>
    800062e0:	00094503          	lbu	a0,0(s2)
    800062e4:	e00514e3          	bnez	a0,800060ec <__printf+0xa4>
    800062e8:	1a0c1663          	bnez	s8,80006494 <__printf+0x44c>
    800062ec:	08813083          	ld	ra,136(sp)
    800062f0:	08013403          	ld	s0,128(sp)
    800062f4:	07813483          	ld	s1,120(sp)
    800062f8:	07013903          	ld	s2,112(sp)
    800062fc:	06813983          	ld	s3,104(sp)
    80006300:	06013a03          	ld	s4,96(sp)
    80006304:	05813a83          	ld	s5,88(sp)
    80006308:	05013b03          	ld	s6,80(sp)
    8000630c:	04813b83          	ld	s7,72(sp)
    80006310:	04013c03          	ld	s8,64(sp)
    80006314:	03813c83          	ld	s9,56(sp)
    80006318:	03013d03          	ld	s10,48(sp)
    8000631c:	02813d83          	ld	s11,40(sp)
    80006320:	0d010113          	addi	sp,sp,208
    80006324:	00008067          	ret
    80006328:	07300713          	li	a4,115
    8000632c:	1ce78a63          	beq	a5,a4,80006500 <__printf+0x4b8>
    80006330:	07800713          	li	a4,120
    80006334:	1ee79e63          	bne	a5,a4,80006530 <__printf+0x4e8>
    80006338:	f7843783          	ld	a5,-136(s0)
    8000633c:	0007a703          	lw	a4,0(a5)
    80006340:	00878793          	addi	a5,a5,8
    80006344:	f6f43c23          	sd	a5,-136(s0)
    80006348:	28074263          	bltz	a4,800065cc <__printf+0x584>
    8000634c:	00002d97          	auipc	s11,0x2
    80006350:	3ccd8d93          	addi	s11,s11,972 # 80008718 <digits>
    80006354:	00f77793          	andi	a5,a4,15
    80006358:	00fd87b3          	add	a5,s11,a5
    8000635c:	0007c683          	lbu	a3,0(a5)
    80006360:	00f00613          	li	a2,15
    80006364:	0007079b          	sext.w	a5,a4
    80006368:	f8d40023          	sb	a3,-128(s0)
    8000636c:	0047559b          	srliw	a1,a4,0x4
    80006370:	0047569b          	srliw	a3,a4,0x4
    80006374:	00000c93          	li	s9,0
    80006378:	0ee65063          	bge	a2,a4,80006458 <__printf+0x410>
    8000637c:	00f6f693          	andi	a3,a3,15
    80006380:	00dd86b3          	add	a3,s11,a3
    80006384:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80006388:	0087d79b          	srliw	a5,a5,0x8
    8000638c:	00100c93          	li	s9,1
    80006390:	f8d400a3          	sb	a3,-127(s0)
    80006394:	0cb67263          	bgeu	a2,a1,80006458 <__printf+0x410>
    80006398:	00f7f693          	andi	a3,a5,15
    8000639c:	00dd86b3          	add	a3,s11,a3
    800063a0:	0006c583          	lbu	a1,0(a3)
    800063a4:	00f00613          	li	a2,15
    800063a8:	0047d69b          	srliw	a3,a5,0x4
    800063ac:	f8b40123          	sb	a1,-126(s0)
    800063b0:	0047d593          	srli	a1,a5,0x4
    800063b4:	28f67e63          	bgeu	a2,a5,80006650 <__printf+0x608>
    800063b8:	00f6f693          	andi	a3,a3,15
    800063bc:	00dd86b3          	add	a3,s11,a3
    800063c0:	0006c503          	lbu	a0,0(a3)
    800063c4:	0087d813          	srli	a6,a5,0x8
    800063c8:	0087d69b          	srliw	a3,a5,0x8
    800063cc:	f8a401a3          	sb	a0,-125(s0)
    800063d0:	28b67663          	bgeu	a2,a1,8000665c <__printf+0x614>
    800063d4:	00f6f693          	andi	a3,a3,15
    800063d8:	00dd86b3          	add	a3,s11,a3
    800063dc:	0006c583          	lbu	a1,0(a3)
    800063e0:	00c7d513          	srli	a0,a5,0xc
    800063e4:	00c7d69b          	srliw	a3,a5,0xc
    800063e8:	f8b40223          	sb	a1,-124(s0)
    800063ec:	29067a63          	bgeu	a2,a6,80006680 <__printf+0x638>
    800063f0:	00f6f693          	andi	a3,a3,15
    800063f4:	00dd86b3          	add	a3,s11,a3
    800063f8:	0006c583          	lbu	a1,0(a3)
    800063fc:	0107d813          	srli	a6,a5,0x10
    80006400:	0107d69b          	srliw	a3,a5,0x10
    80006404:	f8b402a3          	sb	a1,-123(s0)
    80006408:	28a67263          	bgeu	a2,a0,8000668c <__printf+0x644>
    8000640c:	00f6f693          	andi	a3,a3,15
    80006410:	00dd86b3          	add	a3,s11,a3
    80006414:	0006c683          	lbu	a3,0(a3)
    80006418:	0147d79b          	srliw	a5,a5,0x14
    8000641c:	f8d40323          	sb	a3,-122(s0)
    80006420:	21067663          	bgeu	a2,a6,8000662c <__printf+0x5e4>
    80006424:	02079793          	slli	a5,a5,0x20
    80006428:	0207d793          	srli	a5,a5,0x20
    8000642c:	00fd8db3          	add	s11,s11,a5
    80006430:	000dc683          	lbu	a3,0(s11)
    80006434:	00800793          	li	a5,8
    80006438:	00700c93          	li	s9,7
    8000643c:	f8d403a3          	sb	a3,-121(s0)
    80006440:	00075c63          	bgez	a4,80006458 <__printf+0x410>
    80006444:	f9040713          	addi	a4,s0,-112
    80006448:	00f70733          	add	a4,a4,a5
    8000644c:	02d00693          	li	a3,45
    80006450:	fed70823          	sb	a3,-16(a4)
    80006454:	00078c93          	mv	s9,a5
    80006458:	f8040793          	addi	a5,s0,-128
    8000645c:	01978cb3          	add	s9,a5,s9
    80006460:	f7f40d13          	addi	s10,s0,-129
    80006464:	000cc503          	lbu	a0,0(s9)
    80006468:	fffc8c93          	addi	s9,s9,-1
    8000646c:	00000097          	auipc	ra,0x0
    80006470:	9f8080e7          	jalr	-1544(ra) # 80005e64 <consputc>
    80006474:	ff9d18e3          	bne	s10,s9,80006464 <__printf+0x41c>
    80006478:	0100006f          	j	80006488 <__printf+0x440>
    8000647c:	00000097          	auipc	ra,0x0
    80006480:	9e8080e7          	jalr	-1560(ra) # 80005e64 <consputc>
    80006484:	000c8493          	mv	s1,s9
    80006488:	00094503          	lbu	a0,0(s2)
    8000648c:	c60510e3          	bnez	a0,800060ec <__printf+0xa4>
    80006490:	e40c0ee3          	beqz	s8,800062ec <__printf+0x2a4>
    80006494:	00006517          	auipc	a0,0x6
    80006498:	ffc50513          	addi	a0,a0,-4 # 8000c490 <pr>
    8000649c:	00001097          	auipc	ra,0x1
    800064a0:	94c080e7          	jalr	-1716(ra) # 80006de8 <release>
    800064a4:	e49ff06f          	j	800062ec <__printf+0x2a4>
    800064a8:	f7843783          	ld	a5,-136(s0)
    800064ac:	03000513          	li	a0,48
    800064b0:	01000d13          	li	s10,16
    800064b4:	00878713          	addi	a4,a5,8
    800064b8:	0007bc83          	ld	s9,0(a5)
    800064bc:	f6e43c23          	sd	a4,-136(s0)
    800064c0:	00000097          	auipc	ra,0x0
    800064c4:	9a4080e7          	jalr	-1628(ra) # 80005e64 <consputc>
    800064c8:	07800513          	li	a0,120
    800064cc:	00000097          	auipc	ra,0x0
    800064d0:	998080e7          	jalr	-1640(ra) # 80005e64 <consputc>
    800064d4:	00002d97          	auipc	s11,0x2
    800064d8:	244d8d93          	addi	s11,s11,580 # 80008718 <digits>
    800064dc:	03ccd793          	srli	a5,s9,0x3c
    800064e0:	00fd87b3          	add	a5,s11,a5
    800064e4:	0007c503          	lbu	a0,0(a5)
    800064e8:	fffd0d1b          	addiw	s10,s10,-1
    800064ec:	004c9c93          	slli	s9,s9,0x4
    800064f0:	00000097          	auipc	ra,0x0
    800064f4:	974080e7          	jalr	-1676(ra) # 80005e64 <consputc>
    800064f8:	fe0d12e3          	bnez	s10,800064dc <__printf+0x494>
    800064fc:	f8dff06f          	j	80006488 <__printf+0x440>
    80006500:	f7843783          	ld	a5,-136(s0)
    80006504:	0007bc83          	ld	s9,0(a5)
    80006508:	00878793          	addi	a5,a5,8
    8000650c:	f6f43c23          	sd	a5,-136(s0)
    80006510:	000c9a63          	bnez	s9,80006524 <__printf+0x4dc>
    80006514:	1080006f          	j	8000661c <__printf+0x5d4>
    80006518:	001c8c93          	addi	s9,s9,1
    8000651c:	00000097          	auipc	ra,0x0
    80006520:	948080e7          	jalr	-1720(ra) # 80005e64 <consputc>
    80006524:	000cc503          	lbu	a0,0(s9)
    80006528:	fe0518e3          	bnez	a0,80006518 <__printf+0x4d0>
    8000652c:	f5dff06f          	j	80006488 <__printf+0x440>
    80006530:	02500513          	li	a0,37
    80006534:	00000097          	auipc	ra,0x0
    80006538:	930080e7          	jalr	-1744(ra) # 80005e64 <consputc>
    8000653c:	000c8513          	mv	a0,s9
    80006540:	00000097          	auipc	ra,0x0
    80006544:	924080e7          	jalr	-1756(ra) # 80005e64 <consputc>
    80006548:	f41ff06f          	j	80006488 <__printf+0x440>
    8000654c:	02500513          	li	a0,37
    80006550:	00000097          	auipc	ra,0x0
    80006554:	914080e7          	jalr	-1772(ra) # 80005e64 <consputc>
    80006558:	f31ff06f          	j	80006488 <__printf+0x440>
    8000655c:	00030513          	mv	a0,t1
    80006560:	00000097          	auipc	ra,0x0
    80006564:	7bc080e7          	jalr	1980(ra) # 80006d1c <acquire>
    80006568:	b4dff06f          	j	800060b4 <__printf+0x6c>
    8000656c:	40c0053b          	negw	a0,a2
    80006570:	00a00713          	li	a4,10
    80006574:	02e576bb          	remuw	a3,a0,a4
    80006578:	00002d97          	auipc	s11,0x2
    8000657c:	1a0d8d93          	addi	s11,s11,416 # 80008718 <digits>
    80006580:	ff700593          	li	a1,-9
    80006584:	02069693          	slli	a3,a3,0x20
    80006588:	0206d693          	srli	a3,a3,0x20
    8000658c:	00dd86b3          	add	a3,s11,a3
    80006590:	0006c683          	lbu	a3,0(a3)
    80006594:	02e557bb          	divuw	a5,a0,a4
    80006598:	f8d40023          	sb	a3,-128(s0)
    8000659c:	10b65e63          	bge	a2,a1,800066b8 <__printf+0x670>
    800065a0:	06300593          	li	a1,99
    800065a4:	02e7f6bb          	remuw	a3,a5,a4
    800065a8:	02069693          	slli	a3,a3,0x20
    800065ac:	0206d693          	srli	a3,a3,0x20
    800065b0:	00dd86b3          	add	a3,s11,a3
    800065b4:	0006c683          	lbu	a3,0(a3)
    800065b8:	02e7d73b          	divuw	a4,a5,a4
    800065bc:	00200793          	li	a5,2
    800065c0:	f8d400a3          	sb	a3,-127(s0)
    800065c4:	bca5ece3          	bltu	a1,a0,8000619c <__printf+0x154>
    800065c8:	ce5ff06f          	j	800062ac <__printf+0x264>
    800065cc:	40e007bb          	negw	a5,a4
    800065d0:	00002d97          	auipc	s11,0x2
    800065d4:	148d8d93          	addi	s11,s11,328 # 80008718 <digits>
    800065d8:	00f7f693          	andi	a3,a5,15
    800065dc:	00dd86b3          	add	a3,s11,a3
    800065e0:	0006c583          	lbu	a1,0(a3)
    800065e4:	ff100613          	li	a2,-15
    800065e8:	0047d69b          	srliw	a3,a5,0x4
    800065ec:	f8b40023          	sb	a1,-128(s0)
    800065f0:	0047d59b          	srliw	a1,a5,0x4
    800065f4:	0ac75e63          	bge	a4,a2,800066b0 <__printf+0x668>
    800065f8:	00f6f693          	andi	a3,a3,15
    800065fc:	00dd86b3          	add	a3,s11,a3
    80006600:	0006c603          	lbu	a2,0(a3)
    80006604:	00f00693          	li	a3,15
    80006608:	0087d79b          	srliw	a5,a5,0x8
    8000660c:	f8c400a3          	sb	a2,-127(s0)
    80006610:	d8b6e4e3          	bltu	a3,a1,80006398 <__printf+0x350>
    80006614:	00200793          	li	a5,2
    80006618:	e2dff06f          	j	80006444 <__printf+0x3fc>
    8000661c:	00002c97          	auipc	s9,0x2
    80006620:	0dcc8c93          	addi	s9,s9,220 # 800086f8 <CONSOLE_STATUS+0x6e8>
    80006624:	02800513          	li	a0,40
    80006628:	ef1ff06f          	j	80006518 <__printf+0x4d0>
    8000662c:	00700793          	li	a5,7
    80006630:	00600c93          	li	s9,6
    80006634:	e0dff06f          	j	80006440 <__printf+0x3f8>
    80006638:	00700793          	li	a5,7
    8000663c:	00600c93          	li	s9,6
    80006640:	c69ff06f          	j	800062a8 <__printf+0x260>
    80006644:	00300793          	li	a5,3
    80006648:	00200c93          	li	s9,2
    8000664c:	c5dff06f          	j	800062a8 <__printf+0x260>
    80006650:	00300793          	li	a5,3
    80006654:	00200c93          	li	s9,2
    80006658:	de9ff06f          	j	80006440 <__printf+0x3f8>
    8000665c:	00400793          	li	a5,4
    80006660:	00300c93          	li	s9,3
    80006664:	dddff06f          	j	80006440 <__printf+0x3f8>
    80006668:	00400793          	li	a5,4
    8000666c:	00300c93          	li	s9,3
    80006670:	c39ff06f          	j	800062a8 <__printf+0x260>
    80006674:	00500793          	li	a5,5
    80006678:	00400c93          	li	s9,4
    8000667c:	c2dff06f          	j	800062a8 <__printf+0x260>
    80006680:	00500793          	li	a5,5
    80006684:	00400c93          	li	s9,4
    80006688:	db9ff06f          	j	80006440 <__printf+0x3f8>
    8000668c:	00600793          	li	a5,6
    80006690:	00500c93          	li	s9,5
    80006694:	dadff06f          	j	80006440 <__printf+0x3f8>
    80006698:	00600793          	li	a5,6
    8000669c:	00500c93          	li	s9,5
    800066a0:	c09ff06f          	j	800062a8 <__printf+0x260>
    800066a4:	00800793          	li	a5,8
    800066a8:	00700c93          	li	s9,7
    800066ac:	bfdff06f          	j	800062a8 <__printf+0x260>
    800066b0:	00100793          	li	a5,1
    800066b4:	d91ff06f          	j	80006444 <__printf+0x3fc>
    800066b8:	00100793          	li	a5,1
    800066bc:	bf1ff06f          	j	800062ac <__printf+0x264>
    800066c0:	00900793          	li	a5,9
    800066c4:	00800c93          	li	s9,8
    800066c8:	be1ff06f          	j	800062a8 <__printf+0x260>
    800066cc:	00002517          	auipc	a0,0x2
    800066d0:	03450513          	addi	a0,a0,52 # 80008700 <CONSOLE_STATUS+0x6f0>
    800066d4:	00000097          	auipc	ra,0x0
    800066d8:	918080e7          	jalr	-1768(ra) # 80005fec <panic>

00000000800066dc <printfinit>:
    800066dc:	fe010113          	addi	sp,sp,-32
    800066e0:	00813823          	sd	s0,16(sp)
    800066e4:	00913423          	sd	s1,8(sp)
    800066e8:	00113c23          	sd	ra,24(sp)
    800066ec:	02010413          	addi	s0,sp,32
    800066f0:	00006497          	auipc	s1,0x6
    800066f4:	da048493          	addi	s1,s1,-608 # 8000c490 <pr>
    800066f8:	00048513          	mv	a0,s1
    800066fc:	00002597          	auipc	a1,0x2
    80006700:	01458593          	addi	a1,a1,20 # 80008710 <CONSOLE_STATUS+0x700>
    80006704:	00000097          	auipc	ra,0x0
    80006708:	5f4080e7          	jalr	1524(ra) # 80006cf8 <initlock>
    8000670c:	01813083          	ld	ra,24(sp)
    80006710:	01013403          	ld	s0,16(sp)
    80006714:	0004ac23          	sw	zero,24(s1)
    80006718:	00813483          	ld	s1,8(sp)
    8000671c:	02010113          	addi	sp,sp,32
    80006720:	00008067          	ret

0000000080006724 <uartinit>:
    80006724:	ff010113          	addi	sp,sp,-16
    80006728:	00813423          	sd	s0,8(sp)
    8000672c:	01010413          	addi	s0,sp,16
    80006730:	100007b7          	lui	a5,0x10000
    80006734:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006738:	f8000713          	li	a4,-128
    8000673c:	00e781a3          	sb	a4,3(a5)
    80006740:	00300713          	li	a4,3
    80006744:	00e78023          	sb	a4,0(a5)
    80006748:	000780a3          	sb	zero,1(a5)
    8000674c:	00e781a3          	sb	a4,3(a5)
    80006750:	00700693          	li	a3,7
    80006754:	00d78123          	sb	a3,2(a5)
    80006758:	00e780a3          	sb	a4,1(a5)
    8000675c:	00813403          	ld	s0,8(sp)
    80006760:	01010113          	addi	sp,sp,16
    80006764:	00008067          	ret

0000000080006768 <uartputc>:
    80006768:	00005797          	auipc	a5,0x5
    8000676c:	8907a783          	lw	a5,-1904(a5) # 8000aff8 <panicked>
    80006770:	00078463          	beqz	a5,80006778 <uartputc+0x10>
    80006774:	0000006f          	j	80006774 <uartputc+0xc>
    80006778:	fd010113          	addi	sp,sp,-48
    8000677c:	02813023          	sd	s0,32(sp)
    80006780:	00913c23          	sd	s1,24(sp)
    80006784:	01213823          	sd	s2,16(sp)
    80006788:	01313423          	sd	s3,8(sp)
    8000678c:	02113423          	sd	ra,40(sp)
    80006790:	03010413          	addi	s0,sp,48
    80006794:	00005917          	auipc	s2,0x5
    80006798:	86c90913          	addi	s2,s2,-1940 # 8000b000 <uart_tx_r>
    8000679c:	00093783          	ld	a5,0(s2)
    800067a0:	00005497          	auipc	s1,0x5
    800067a4:	86848493          	addi	s1,s1,-1944 # 8000b008 <uart_tx_w>
    800067a8:	0004b703          	ld	a4,0(s1)
    800067ac:	02078693          	addi	a3,a5,32
    800067b0:	00050993          	mv	s3,a0
    800067b4:	02e69c63          	bne	a3,a4,800067ec <uartputc+0x84>
    800067b8:	00001097          	auipc	ra,0x1
    800067bc:	834080e7          	jalr	-1996(ra) # 80006fec <push_on>
    800067c0:	00093783          	ld	a5,0(s2)
    800067c4:	0004b703          	ld	a4,0(s1)
    800067c8:	02078793          	addi	a5,a5,32
    800067cc:	00e79463          	bne	a5,a4,800067d4 <uartputc+0x6c>
    800067d0:	0000006f          	j	800067d0 <uartputc+0x68>
    800067d4:	00001097          	auipc	ra,0x1
    800067d8:	88c080e7          	jalr	-1908(ra) # 80007060 <pop_on>
    800067dc:	00093783          	ld	a5,0(s2)
    800067e0:	0004b703          	ld	a4,0(s1)
    800067e4:	02078693          	addi	a3,a5,32
    800067e8:	fce688e3          	beq	a3,a4,800067b8 <uartputc+0x50>
    800067ec:	01f77693          	andi	a3,a4,31
    800067f0:	00006597          	auipc	a1,0x6
    800067f4:	cc058593          	addi	a1,a1,-832 # 8000c4b0 <uart_tx_buf>
    800067f8:	00d586b3          	add	a3,a1,a3
    800067fc:	00170713          	addi	a4,a4,1
    80006800:	01368023          	sb	s3,0(a3)
    80006804:	00e4b023          	sd	a4,0(s1)
    80006808:	10000637          	lui	a2,0x10000
    8000680c:	02f71063          	bne	a4,a5,8000682c <uartputc+0xc4>
    80006810:	0340006f          	j	80006844 <uartputc+0xdc>
    80006814:	00074703          	lbu	a4,0(a4)
    80006818:	00f93023          	sd	a5,0(s2)
    8000681c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006820:	00093783          	ld	a5,0(s2)
    80006824:	0004b703          	ld	a4,0(s1)
    80006828:	00f70e63          	beq	a4,a5,80006844 <uartputc+0xdc>
    8000682c:	00564683          	lbu	a3,5(a2)
    80006830:	01f7f713          	andi	a4,a5,31
    80006834:	00e58733          	add	a4,a1,a4
    80006838:	0206f693          	andi	a3,a3,32
    8000683c:	00178793          	addi	a5,a5,1
    80006840:	fc069ae3          	bnez	a3,80006814 <uartputc+0xac>
    80006844:	02813083          	ld	ra,40(sp)
    80006848:	02013403          	ld	s0,32(sp)
    8000684c:	01813483          	ld	s1,24(sp)
    80006850:	01013903          	ld	s2,16(sp)
    80006854:	00813983          	ld	s3,8(sp)
    80006858:	03010113          	addi	sp,sp,48
    8000685c:	00008067          	ret

0000000080006860 <uartputc_sync>:
    80006860:	ff010113          	addi	sp,sp,-16
    80006864:	00813423          	sd	s0,8(sp)
    80006868:	01010413          	addi	s0,sp,16
    8000686c:	00004717          	auipc	a4,0x4
    80006870:	78c72703          	lw	a4,1932(a4) # 8000aff8 <panicked>
    80006874:	02071663          	bnez	a4,800068a0 <uartputc_sync+0x40>
    80006878:	00050793          	mv	a5,a0
    8000687c:	100006b7          	lui	a3,0x10000
    80006880:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006884:	02077713          	andi	a4,a4,32
    80006888:	fe070ce3          	beqz	a4,80006880 <uartputc_sync+0x20>
    8000688c:	0ff7f793          	andi	a5,a5,255
    80006890:	00f68023          	sb	a5,0(a3)
    80006894:	00813403          	ld	s0,8(sp)
    80006898:	01010113          	addi	sp,sp,16
    8000689c:	00008067          	ret
    800068a0:	0000006f          	j	800068a0 <uartputc_sync+0x40>

00000000800068a4 <uartstart>:
    800068a4:	ff010113          	addi	sp,sp,-16
    800068a8:	00813423          	sd	s0,8(sp)
    800068ac:	01010413          	addi	s0,sp,16
    800068b0:	00004617          	auipc	a2,0x4
    800068b4:	75060613          	addi	a2,a2,1872 # 8000b000 <uart_tx_r>
    800068b8:	00004517          	auipc	a0,0x4
    800068bc:	75050513          	addi	a0,a0,1872 # 8000b008 <uart_tx_w>
    800068c0:	00063783          	ld	a5,0(a2)
    800068c4:	00053703          	ld	a4,0(a0)
    800068c8:	04f70263          	beq	a4,a5,8000690c <uartstart+0x68>
    800068cc:	100005b7          	lui	a1,0x10000
    800068d0:	00006817          	auipc	a6,0x6
    800068d4:	be080813          	addi	a6,a6,-1056 # 8000c4b0 <uart_tx_buf>
    800068d8:	01c0006f          	j	800068f4 <uartstart+0x50>
    800068dc:	0006c703          	lbu	a4,0(a3)
    800068e0:	00f63023          	sd	a5,0(a2)
    800068e4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800068e8:	00063783          	ld	a5,0(a2)
    800068ec:	00053703          	ld	a4,0(a0)
    800068f0:	00f70e63          	beq	a4,a5,8000690c <uartstart+0x68>
    800068f4:	01f7f713          	andi	a4,a5,31
    800068f8:	00e806b3          	add	a3,a6,a4
    800068fc:	0055c703          	lbu	a4,5(a1)
    80006900:	00178793          	addi	a5,a5,1
    80006904:	02077713          	andi	a4,a4,32
    80006908:	fc071ae3          	bnez	a4,800068dc <uartstart+0x38>
    8000690c:	00813403          	ld	s0,8(sp)
    80006910:	01010113          	addi	sp,sp,16
    80006914:	00008067          	ret

0000000080006918 <uartgetc>:
    80006918:	ff010113          	addi	sp,sp,-16
    8000691c:	00813423          	sd	s0,8(sp)
    80006920:	01010413          	addi	s0,sp,16
    80006924:	10000737          	lui	a4,0x10000
    80006928:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000692c:	0017f793          	andi	a5,a5,1
    80006930:	00078c63          	beqz	a5,80006948 <uartgetc+0x30>
    80006934:	00074503          	lbu	a0,0(a4)
    80006938:	0ff57513          	andi	a0,a0,255
    8000693c:	00813403          	ld	s0,8(sp)
    80006940:	01010113          	addi	sp,sp,16
    80006944:	00008067          	ret
    80006948:	fff00513          	li	a0,-1
    8000694c:	ff1ff06f          	j	8000693c <uartgetc+0x24>

0000000080006950 <uartintr>:
    80006950:	100007b7          	lui	a5,0x10000
    80006954:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006958:	0017f793          	andi	a5,a5,1
    8000695c:	0a078463          	beqz	a5,80006a04 <uartintr+0xb4>
    80006960:	fe010113          	addi	sp,sp,-32
    80006964:	00813823          	sd	s0,16(sp)
    80006968:	00913423          	sd	s1,8(sp)
    8000696c:	00113c23          	sd	ra,24(sp)
    80006970:	02010413          	addi	s0,sp,32
    80006974:	100004b7          	lui	s1,0x10000
    80006978:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000697c:	0ff57513          	andi	a0,a0,255
    80006980:	fffff097          	auipc	ra,0xfffff
    80006984:	534080e7          	jalr	1332(ra) # 80005eb4 <consoleintr>
    80006988:	0054c783          	lbu	a5,5(s1)
    8000698c:	0017f793          	andi	a5,a5,1
    80006990:	fe0794e3          	bnez	a5,80006978 <uartintr+0x28>
    80006994:	00004617          	auipc	a2,0x4
    80006998:	66c60613          	addi	a2,a2,1644 # 8000b000 <uart_tx_r>
    8000699c:	00004517          	auipc	a0,0x4
    800069a0:	66c50513          	addi	a0,a0,1644 # 8000b008 <uart_tx_w>
    800069a4:	00063783          	ld	a5,0(a2)
    800069a8:	00053703          	ld	a4,0(a0)
    800069ac:	04f70263          	beq	a4,a5,800069f0 <uartintr+0xa0>
    800069b0:	100005b7          	lui	a1,0x10000
    800069b4:	00006817          	auipc	a6,0x6
    800069b8:	afc80813          	addi	a6,a6,-1284 # 8000c4b0 <uart_tx_buf>
    800069bc:	01c0006f          	j	800069d8 <uartintr+0x88>
    800069c0:	0006c703          	lbu	a4,0(a3)
    800069c4:	00f63023          	sd	a5,0(a2)
    800069c8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800069cc:	00063783          	ld	a5,0(a2)
    800069d0:	00053703          	ld	a4,0(a0)
    800069d4:	00f70e63          	beq	a4,a5,800069f0 <uartintr+0xa0>
    800069d8:	01f7f713          	andi	a4,a5,31
    800069dc:	00e806b3          	add	a3,a6,a4
    800069e0:	0055c703          	lbu	a4,5(a1)
    800069e4:	00178793          	addi	a5,a5,1
    800069e8:	02077713          	andi	a4,a4,32
    800069ec:	fc071ae3          	bnez	a4,800069c0 <uartintr+0x70>
    800069f0:	01813083          	ld	ra,24(sp)
    800069f4:	01013403          	ld	s0,16(sp)
    800069f8:	00813483          	ld	s1,8(sp)
    800069fc:	02010113          	addi	sp,sp,32
    80006a00:	00008067          	ret
    80006a04:	00004617          	auipc	a2,0x4
    80006a08:	5fc60613          	addi	a2,a2,1532 # 8000b000 <uart_tx_r>
    80006a0c:	00004517          	auipc	a0,0x4
    80006a10:	5fc50513          	addi	a0,a0,1532 # 8000b008 <uart_tx_w>
    80006a14:	00063783          	ld	a5,0(a2)
    80006a18:	00053703          	ld	a4,0(a0)
    80006a1c:	04f70263          	beq	a4,a5,80006a60 <uartintr+0x110>
    80006a20:	100005b7          	lui	a1,0x10000
    80006a24:	00006817          	auipc	a6,0x6
    80006a28:	a8c80813          	addi	a6,a6,-1396 # 8000c4b0 <uart_tx_buf>
    80006a2c:	01c0006f          	j	80006a48 <uartintr+0xf8>
    80006a30:	0006c703          	lbu	a4,0(a3)
    80006a34:	00f63023          	sd	a5,0(a2)
    80006a38:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006a3c:	00063783          	ld	a5,0(a2)
    80006a40:	00053703          	ld	a4,0(a0)
    80006a44:	02f70063          	beq	a4,a5,80006a64 <uartintr+0x114>
    80006a48:	01f7f713          	andi	a4,a5,31
    80006a4c:	00e806b3          	add	a3,a6,a4
    80006a50:	0055c703          	lbu	a4,5(a1)
    80006a54:	00178793          	addi	a5,a5,1
    80006a58:	02077713          	andi	a4,a4,32
    80006a5c:	fc071ae3          	bnez	a4,80006a30 <uartintr+0xe0>
    80006a60:	00008067          	ret
    80006a64:	00008067          	ret

0000000080006a68 <kinit>:
    80006a68:	fc010113          	addi	sp,sp,-64
    80006a6c:	02913423          	sd	s1,40(sp)
    80006a70:	fffff7b7          	lui	a5,0xfffff
    80006a74:	0000b497          	auipc	s1,0xb
    80006a78:	58b48493          	addi	s1,s1,1419 # 80011fff <end+0xfff>
    80006a7c:	02813823          	sd	s0,48(sp)
    80006a80:	01313c23          	sd	s3,24(sp)
    80006a84:	00f4f4b3          	and	s1,s1,a5
    80006a88:	02113c23          	sd	ra,56(sp)
    80006a8c:	03213023          	sd	s2,32(sp)
    80006a90:	01413823          	sd	s4,16(sp)
    80006a94:	01513423          	sd	s5,8(sp)
    80006a98:	04010413          	addi	s0,sp,64
    80006a9c:	000017b7          	lui	a5,0x1
    80006aa0:	01100993          	li	s3,17
    80006aa4:	00f487b3          	add	a5,s1,a5
    80006aa8:	01b99993          	slli	s3,s3,0x1b
    80006aac:	06f9e063          	bltu	s3,a5,80006b0c <kinit+0xa4>
    80006ab0:	0000aa97          	auipc	s5,0xa
    80006ab4:	550a8a93          	addi	s5,s5,1360 # 80011000 <end>
    80006ab8:	0754ec63          	bltu	s1,s5,80006b30 <kinit+0xc8>
    80006abc:	0734fa63          	bgeu	s1,s3,80006b30 <kinit+0xc8>
    80006ac0:	00088a37          	lui	s4,0x88
    80006ac4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006ac8:	00004917          	auipc	s2,0x4
    80006acc:	54890913          	addi	s2,s2,1352 # 8000b010 <kmem>
    80006ad0:	00ca1a13          	slli	s4,s4,0xc
    80006ad4:	0140006f          	j	80006ae8 <kinit+0x80>
    80006ad8:	000017b7          	lui	a5,0x1
    80006adc:	00f484b3          	add	s1,s1,a5
    80006ae0:	0554e863          	bltu	s1,s5,80006b30 <kinit+0xc8>
    80006ae4:	0534f663          	bgeu	s1,s3,80006b30 <kinit+0xc8>
    80006ae8:	00001637          	lui	a2,0x1
    80006aec:	00100593          	li	a1,1
    80006af0:	00048513          	mv	a0,s1
    80006af4:	00000097          	auipc	ra,0x0
    80006af8:	5e4080e7          	jalr	1508(ra) # 800070d8 <__memset>
    80006afc:	00093783          	ld	a5,0(s2)
    80006b00:	00f4b023          	sd	a5,0(s1)
    80006b04:	00993023          	sd	s1,0(s2)
    80006b08:	fd4498e3          	bne	s1,s4,80006ad8 <kinit+0x70>
    80006b0c:	03813083          	ld	ra,56(sp)
    80006b10:	03013403          	ld	s0,48(sp)
    80006b14:	02813483          	ld	s1,40(sp)
    80006b18:	02013903          	ld	s2,32(sp)
    80006b1c:	01813983          	ld	s3,24(sp)
    80006b20:	01013a03          	ld	s4,16(sp)
    80006b24:	00813a83          	ld	s5,8(sp)
    80006b28:	04010113          	addi	sp,sp,64
    80006b2c:	00008067          	ret
    80006b30:	00002517          	auipc	a0,0x2
    80006b34:	c0050513          	addi	a0,a0,-1024 # 80008730 <digits+0x18>
    80006b38:	fffff097          	auipc	ra,0xfffff
    80006b3c:	4b4080e7          	jalr	1204(ra) # 80005fec <panic>

0000000080006b40 <freerange>:
    80006b40:	fc010113          	addi	sp,sp,-64
    80006b44:	000017b7          	lui	a5,0x1
    80006b48:	02913423          	sd	s1,40(sp)
    80006b4c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006b50:	009504b3          	add	s1,a0,s1
    80006b54:	fffff537          	lui	a0,0xfffff
    80006b58:	02813823          	sd	s0,48(sp)
    80006b5c:	02113c23          	sd	ra,56(sp)
    80006b60:	03213023          	sd	s2,32(sp)
    80006b64:	01313c23          	sd	s3,24(sp)
    80006b68:	01413823          	sd	s4,16(sp)
    80006b6c:	01513423          	sd	s5,8(sp)
    80006b70:	01613023          	sd	s6,0(sp)
    80006b74:	04010413          	addi	s0,sp,64
    80006b78:	00a4f4b3          	and	s1,s1,a0
    80006b7c:	00f487b3          	add	a5,s1,a5
    80006b80:	06f5e463          	bltu	a1,a5,80006be8 <freerange+0xa8>
    80006b84:	0000aa97          	auipc	s5,0xa
    80006b88:	47ca8a93          	addi	s5,s5,1148 # 80011000 <end>
    80006b8c:	0954e263          	bltu	s1,s5,80006c10 <freerange+0xd0>
    80006b90:	01100993          	li	s3,17
    80006b94:	01b99993          	slli	s3,s3,0x1b
    80006b98:	0734fc63          	bgeu	s1,s3,80006c10 <freerange+0xd0>
    80006b9c:	00058a13          	mv	s4,a1
    80006ba0:	00004917          	auipc	s2,0x4
    80006ba4:	47090913          	addi	s2,s2,1136 # 8000b010 <kmem>
    80006ba8:	00002b37          	lui	s6,0x2
    80006bac:	0140006f          	j	80006bc0 <freerange+0x80>
    80006bb0:	000017b7          	lui	a5,0x1
    80006bb4:	00f484b3          	add	s1,s1,a5
    80006bb8:	0554ec63          	bltu	s1,s5,80006c10 <freerange+0xd0>
    80006bbc:	0534fa63          	bgeu	s1,s3,80006c10 <freerange+0xd0>
    80006bc0:	00001637          	lui	a2,0x1
    80006bc4:	00100593          	li	a1,1
    80006bc8:	00048513          	mv	a0,s1
    80006bcc:	00000097          	auipc	ra,0x0
    80006bd0:	50c080e7          	jalr	1292(ra) # 800070d8 <__memset>
    80006bd4:	00093703          	ld	a4,0(s2)
    80006bd8:	016487b3          	add	a5,s1,s6
    80006bdc:	00e4b023          	sd	a4,0(s1)
    80006be0:	00993023          	sd	s1,0(s2)
    80006be4:	fcfa76e3          	bgeu	s4,a5,80006bb0 <freerange+0x70>
    80006be8:	03813083          	ld	ra,56(sp)
    80006bec:	03013403          	ld	s0,48(sp)
    80006bf0:	02813483          	ld	s1,40(sp)
    80006bf4:	02013903          	ld	s2,32(sp)
    80006bf8:	01813983          	ld	s3,24(sp)
    80006bfc:	01013a03          	ld	s4,16(sp)
    80006c00:	00813a83          	ld	s5,8(sp)
    80006c04:	00013b03          	ld	s6,0(sp)
    80006c08:	04010113          	addi	sp,sp,64
    80006c0c:	00008067          	ret
    80006c10:	00002517          	auipc	a0,0x2
    80006c14:	b2050513          	addi	a0,a0,-1248 # 80008730 <digits+0x18>
    80006c18:	fffff097          	auipc	ra,0xfffff
    80006c1c:	3d4080e7          	jalr	980(ra) # 80005fec <panic>

0000000080006c20 <kfree>:
    80006c20:	fe010113          	addi	sp,sp,-32
    80006c24:	00813823          	sd	s0,16(sp)
    80006c28:	00113c23          	sd	ra,24(sp)
    80006c2c:	00913423          	sd	s1,8(sp)
    80006c30:	02010413          	addi	s0,sp,32
    80006c34:	03451793          	slli	a5,a0,0x34
    80006c38:	04079c63          	bnez	a5,80006c90 <kfree+0x70>
    80006c3c:	0000a797          	auipc	a5,0xa
    80006c40:	3c478793          	addi	a5,a5,964 # 80011000 <end>
    80006c44:	00050493          	mv	s1,a0
    80006c48:	04f56463          	bltu	a0,a5,80006c90 <kfree+0x70>
    80006c4c:	01100793          	li	a5,17
    80006c50:	01b79793          	slli	a5,a5,0x1b
    80006c54:	02f57e63          	bgeu	a0,a5,80006c90 <kfree+0x70>
    80006c58:	00001637          	lui	a2,0x1
    80006c5c:	00100593          	li	a1,1
    80006c60:	00000097          	auipc	ra,0x0
    80006c64:	478080e7          	jalr	1144(ra) # 800070d8 <__memset>
    80006c68:	00004797          	auipc	a5,0x4
    80006c6c:	3a878793          	addi	a5,a5,936 # 8000b010 <kmem>
    80006c70:	0007b703          	ld	a4,0(a5)
    80006c74:	01813083          	ld	ra,24(sp)
    80006c78:	01013403          	ld	s0,16(sp)
    80006c7c:	00e4b023          	sd	a4,0(s1)
    80006c80:	0097b023          	sd	s1,0(a5)
    80006c84:	00813483          	ld	s1,8(sp)
    80006c88:	02010113          	addi	sp,sp,32
    80006c8c:	00008067          	ret
    80006c90:	00002517          	auipc	a0,0x2
    80006c94:	aa050513          	addi	a0,a0,-1376 # 80008730 <digits+0x18>
    80006c98:	fffff097          	auipc	ra,0xfffff
    80006c9c:	354080e7          	jalr	852(ra) # 80005fec <panic>

0000000080006ca0 <kalloc>:
    80006ca0:	fe010113          	addi	sp,sp,-32
    80006ca4:	00813823          	sd	s0,16(sp)
    80006ca8:	00913423          	sd	s1,8(sp)
    80006cac:	00113c23          	sd	ra,24(sp)
    80006cb0:	02010413          	addi	s0,sp,32
    80006cb4:	00004797          	auipc	a5,0x4
    80006cb8:	35c78793          	addi	a5,a5,860 # 8000b010 <kmem>
    80006cbc:	0007b483          	ld	s1,0(a5)
    80006cc0:	02048063          	beqz	s1,80006ce0 <kalloc+0x40>
    80006cc4:	0004b703          	ld	a4,0(s1)
    80006cc8:	00001637          	lui	a2,0x1
    80006ccc:	00500593          	li	a1,5
    80006cd0:	00048513          	mv	a0,s1
    80006cd4:	00e7b023          	sd	a4,0(a5)
    80006cd8:	00000097          	auipc	ra,0x0
    80006cdc:	400080e7          	jalr	1024(ra) # 800070d8 <__memset>
    80006ce0:	01813083          	ld	ra,24(sp)
    80006ce4:	01013403          	ld	s0,16(sp)
    80006ce8:	00048513          	mv	a0,s1
    80006cec:	00813483          	ld	s1,8(sp)
    80006cf0:	02010113          	addi	sp,sp,32
    80006cf4:	00008067          	ret

0000000080006cf8 <initlock>:
    80006cf8:	ff010113          	addi	sp,sp,-16
    80006cfc:	00813423          	sd	s0,8(sp)
    80006d00:	01010413          	addi	s0,sp,16
    80006d04:	00813403          	ld	s0,8(sp)
    80006d08:	00b53423          	sd	a1,8(a0)
    80006d0c:	00052023          	sw	zero,0(a0)
    80006d10:	00053823          	sd	zero,16(a0)
    80006d14:	01010113          	addi	sp,sp,16
    80006d18:	00008067          	ret

0000000080006d1c <acquire>:
    80006d1c:	fe010113          	addi	sp,sp,-32
    80006d20:	00813823          	sd	s0,16(sp)
    80006d24:	00913423          	sd	s1,8(sp)
    80006d28:	00113c23          	sd	ra,24(sp)
    80006d2c:	01213023          	sd	s2,0(sp)
    80006d30:	02010413          	addi	s0,sp,32
    80006d34:	00050493          	mv	s1,a0
    80006d38:	10002973          	csrr	s2,sstatus
    80006d3c:	100027f3          	csrr	a5,sstatus
    80006d40:	ffd7f793          	andi	a5,a5,-3
    80006d44:	10079073          	csrw	sstatus,a5
    80006d48:	fffff097          	auipc	ra,0xfffff
    80006d4c:	8e4080e7          	jalr	-1820(ra) # 8000562c <mycpu>
    80006d50:	07852783          	lw	a5,120(a0)
    80006d54:	06078e63          	beqz	a5,80006dd0 <acquire+0xb4>
    80006d58:	fffff097          	auipc	ra,0xfffff
    80006d5c:	8d4080e7          	jalr	-1836(ra) # 8000562c <mycpu>
    80006d60:	07852783          	lw	a5,120(a0)
    80006d64:	0004a703          	lw	a4,0(s1)
    80006d68:	0017879b          	addiw	a5,a5,1
    80006d6c:	06f52c23          	sw	a5,120(a0)
    80006d70:	04071063          	bnez	a4,80006db0 <acquire+0x94>
    80006d74:	00100713          	li	a4,1
    80006d78:	00070793          	mv	a5,a4
    80006d7c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006d80:	0007879b          	sext.w	a5,a5
    80006d84:	fe079ae3          	bnez	a5,80006d78 <acquire+0x5c>
    80006d88:	0ff0000f          	fence
    80006d8c:	fffff097          	auipc	ra,0xfffff
    80006d90:	8a0080e7          	jalr	-1888(ra) # 8000562c <mycpu>
    80006d94:	01813083          	ld	ra,24(sp)
    80006d98:	01013403          	ld	s0,16(sp)
    80006d9c:	00a4b823          	sd	a0,16(s1)
    80006da0:	00013903          	ld	s2,0(sp)
    80006da4:	00813483          	ld	s1,8(sp)
    80006da8:	02010113          	addi	sp,sp,32
    80006dac:	00008067          	ret
    80006db0:	0104b903          	ld	s2,16(s1)
    80006db4:	fffff097          	auipc	ra,0xfffff
    80006db8:	878080e7          	jalr	-1928(ra) # 8000562c <mycpu>
    80006dbc:	faa91ce3          	bne	s2,a0,80006d74 <acquire+0x58>
    80006dc0:	00002517          	auipc	a0,0x2
    80006dc4:	97850513          	addi	a0,a0,-1672 # 80008738 <digits+0x20>
    80006dc8:	fffff097          	auipc	ra,0xfffff
    80006dcc:	224080e7          	jalr	548(ra) # 80005fec <panic>
    80006dd0:	00195913          	srli	s2,s2,0x1
    80006dd4:	fffff097          	auipc	ra,0xfffff
    80006dd8:	858080e7          	jalr	-1960(ra) # 8000562c <mycpu>
    80006ddc:	00197913          	andi	s2,s2,1
    80006de0:	07252e23          	sw	s2,124(a0)
    80006de4:	f75ff06f          	j	80006d58 <acquire+0x3c>

0000000080006de8 <release>:
    80006de8:	fe010113          	addi	sp,sp,-32
    80006dec:	00813823          	sd	s0,16(sp)
    80006df0:	00113c23          	sd	ra,24(sp)
    80006df4:	00913423          	sd	s1,8(sp)
    80006df8:	01213023          	sd	s2,0(sp)
    80006dfc:	02010413          	addi	s0,sp,32
    80006e00:	00052783          	lw	a5,0(a0)
    80006e04:	00079a63          	bnez	a5,80006e18 <release+0x30>
    80006e08:	00002517          	auipc	a0,0x2
    80006e0c:	93850513          	addi	a0,a0,-1736 # 80008740 <digits+0x28>
    80006e10:	fffff097          	auipc	ra,0xfffff
    80006e14:	1dc080e7          	jalr	476(ra) # 80005fec <panic>
    80006e18:	01053903          	ld	s2,16(a0)
    80006e1c:	00050493          	mv	s1,a0
    80006e20:	fffff097          	auipc	ra,0xfffff
    80006e24:	80c080e7          	jalr	-2036(ra) # 8000562c <mycpu>
    80006e28:	fea910e3          	bne	s2,a0,80006e08 <release+0x20>
    80006e2c:	0004b823          	sd	zero,16(s1)
    80006e30:	0ff0000f          	fence
    80006e34:	0f50000f          	fence	iorw,ow
    80006e38:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006e3c:	ffffe097          	auipc	ra,0xffffe
    80006e40:	7f0080e7          	jalr	2032(ra) # 8000562c <mycpu>
    80006e44:	100027f3          	csrr	a5,sstatus
    80006e48:	0027f793          	andi	a5,a5,2
    80006e4c:	04079a63          	bnez	a5,80006ea0 <release+0xb8>
    80006e50:	07852783          	lw	a5,120(a0)
    80006e54:	02f05e63          	blez	a5,80006e90 <release+0xa8>
    80006e58:	fff7871b          	addiw	a4,a5,-1
    80006e5c:	06e52c23          	sw	a4,120(a0)
    80006e60:	00071c63          	bnez	a4,80006e78 <release+0x90>
    80006e64:	07c52783          	lw	a5,124(a0)
    80006e68:	00078863          	beqz	a5,80006e78 <release+0x90>
    80006e6c:	100027f3          	csrr	a5,sstatus
    80006e70:	0027e793          	ori	a5,a5,2
    80006e74:	10079073          	csrw	sstatus,a5
    80006e78:	01813083          	ld	ra,24(sp)
    80006e7c:	01013403          	ld	s0,16(sp)
    80006e80:	00813483          	ld	s1,8(sp)
    80006e84:	00013903          	ld	s2,0(sp)
    80006e88:	02010113          	addi	sp,sp,32
    80006e8c:	00008067          	ret
    80006e90:	00002517          	auipc	a0,0x2
    80006e94:	8d050513          	addi	a0,a0,-1840 # 80008760 <digits+0x48>
    80006e98:	fffff097          	auipc	ra,0xfffff
    80006e9c:	154080e7          	jalr	340(ra) # 80005fec <panic>
    80006ea0:	00002517          	auipc	a0,0x2
    80006ea4:	8a850513          	addi	a0,a0,-1880 # 80008748 <digits+0x30>
    80006ea8:	fffff097          	auipc	ra,0xfffff
    80006eac:	144080e7          	jalr	324(ra) # 80005fec <panic>

0000000080006eb0 <holding>:
    80006eb0:	00052783          	lw	a5,0(a0)
    80006eb4:	00079663          	bnez	a5,80006ec0 <holding+0x10>
    80006eb8:	00000513          	li	a0,0
    80006ebc:	00008067          	ret
    80006ec0:	fe010113          	addi	sp,sp,-32
    80006ec4:	00813823          	sd	s0,16(sp)
    80006ec8:	00913423          	sd	s1,8(sp)
    80006ecc:	00113c23          	sd	ra,24(sp)
    80006ed0:	02010413          	addi	s0,sp,32
    80006ed4:	01053483          	ld	s1,16(a0)
    80006ed8:	ffffe097          	auipc	ra,0xffffe
    80006edc:	754080e7          	jalr	1876(ra) # 8000562c <mycpu>
    80006ee0:	01813083          	ld	ra,24(sp)
    80006ee4:	01013403          	ld	s0,16(sp)
    80006ee8:	40a48533          	sub	a0,s1,a0
    80006eec:	00153513          	seqz	a0,a0
    80006ef0:	00813483          	ld	s1,8(sp)
    80006ef4:	02010113          	addi	sp,sp,32
    80006ef8:	00008067          	ret

0000000080006efc <push_off>:
    80006efc:	fe010113          	addi	sp,sp,-32
    80006f00:	00813823          	sd	s0,16(sp)
    80006f04:	00113c23          	sd	ra,24(sp)
    80006f08:	00913423          	sd	s1,8(sp)
    80006f0c:	02010413          	addi	s0,sp,32
    80006f10:	100024f3          	csrr	s1,sstatus
    80006f14:	100027f3          	csrr	a5,sstatus
    80006f18:	ffd7f793          	andi	a5,a5,-3
    80006f1c:	10079073          	csrw	sstatus,a5
    80006f20:	ffffe097          	auipc	ra,0xffffe
    80006f24:	70c080e7          	jalr	1804(ra) # 8000562c <mycpu>
    80006f28:	07852783          	lw	a5,120(a0)
    80006f2c:	02078663          	beqz	a5,80006f58 <push_off+0x5c>
    80006f30:	ffffe097          	auipc	ra,0xffffe
    80006f34:	6fc080e7          	jalr	1788(ra) # 8000562c <mycpu>
    80006f38:	07852783          	lw	a5,120(a0)
    80006f3c:	01813083          	ld	ra,24(sp)
    80006f40:	01013403          	ld	s0,16(sp)
    80006f44:	0017879b          	addiw	a5,a5,1
    80006f48:	06f52c23          	sw	a5,120(a0)
    80006f4c:	00813483          	ld	s1,8(sp)
    80006f50:	02010113          	addi	sp,sp,32
    80006f54:	00008067          	ret
    80006f58:	0014d493          	srli	s1,s1,0x1
    80006f5c:	ffffe097          	auipc	ra,0xffffe
    80006f60:	6d0080e7          	jalr	1744(ra) # 8000562c <mycpu>
    80006f64:	0014f493          	andi	s1,s1,1
    80006f68:	06952e23          	sw	s1,124(a0)
    80006f6c:	fc5ff06f          	j	80006f30 <push_off+0x34>

0000000080006f70 <pop_off>:
    80006f70:	ff010113          	addi	sp,sp,-16
    80006f74:	00813023          	sd	s0,0(sp)
    80006f78:	00113423          	sd	ra,8(sp)
    80006f7c:	01010413          	addi	s0,sp,16
    80006f80:	ffffe097          	auipc	ra,0xffffe
    80006f84:	6ac080e7          	jalr	1708(ra) # 8000562c <mycpu>
    80006f88:	100027f3          	csrr	a5,sstatus
    80006f8c:	0027f793          	andi	a5,a5,2
    80006f90:	04079663          	bnez	a5,80006fdc <pop_off+0x6c>
    80006f94:	07852783          	lw	a5,120(a0)
    80006f98:	02f05a63          	blez	a5,80006fcc <pop_off+0x5c>
    80006f9c:	fff7871b          	addiw	a4,a5,-1
    80006fa0:	06e52c23          	sw	a4,120(a0)
    80006fa4:	00071c63          	bnez	a4,80006fbc <pop_off+0x4c>
    80006fa8:	07c52783          	lw	a5,124(a0)
    80006fac:	00078863          	beqz	a5,80006fbc <pop_off+0x4c>
    80006fb0:	100027f3          	csrr	a5,sstatus
    80006fb4:	0027e793          	ori	a5,a5,2
    80006fb8:	10079073          	csrw	sstatus,a5
    80006fbc:	00813083          	ld	ra,8(sp)
    80006fc0:	00013403          	ld	s0,0(sp)
    80006fc4:	01010113          	addi	sp,sp,16
    80006fc8:	00008067          	ret
    80006fcc:	00001517          	auipc	a0,0x1
    80006fd0:	79450513          	addi	a0,a0,1940 # 80008760 <digits+0x48>
    80006fd4:	fffff097          	auipc	ra,0xfffff
    80006fd8:	018080e7          	jalr	24(ra) # 80005fec <panic>
    80006fdc:	00001517          	auipc	a0,0x1
    80006fe0:	76c50513          	addi	a0,a0,1900 # 80008748 <digits+0x30>
    80006fe4:	fffff097          	auipc	ra,0xfffff
    80006fe8:	008080e7          	jalr	8(ra) # 80005fec <panic>

0000000080006fec <push_on>:
    80006fec:	fe010113          	addi	sp,sp,-32
    80006ff0:	00813823          	sd	s0,16(sp)
    80006ff4:	00113c23          	sd	ra,24(sp)
    80006ff8:	00913423          	sd	s1,8(sp)
    80006ffc:	02010413          	addi	s0,sp,32
    80007000:	100024f3          	csrr	s1,sstatus
    80007004:	100027f3          	csrr	a5,sstatus
    80007008:	0027e793          	ori	a5,a5,2
    8000700c:	10079073          	csrw	sstatus,a5
    80007010:	ffffe097          	auipc	ra,0xffffe
    80007014:	61c080e7          	jalr	1564(ra) # 8000562c <mycpu>
    80007018:	07852783          	lw	a5,120(a0)
    8000701c:	02078663          	beqz	a5,80007048 <push_on+0x5c>
    80007020:	ffffe097          	auipc	ra,0xffffe
    80007024:	60c080e7          	jalr	1548(ra) # 8000562c <mycpu>
    80007028:	07852783          	lw	a5,120(a0)
    8000702c:	01813083          	ld	ra,24(sp)
    80007030:	01013403          	ld	s0,16(sp)
    80007034:	0017879b          	addiw	a5,a5,1
    80007038:	06f52c23          	sw	a5,120(a0)
    8000703c:	00813483          	ld	s1,8(sp)
    80007040:	02010113          	addi	sp,sp,32
    80007044:	00008067          	ret
    80007048:	0014d493          	srli	s1,s1,0x1
    8000704c:	ffffe097          	auipc	ra,0xffffe
    80007050:	5e0080e7          	jalr	1504(ra) # 8000562c <mycpu>
    80007054:	0014f493          	andi	s1,s1,1
    80007058:	06952e23          	sw	s1,124(a0)
    8000705c:	fc5ff06f          	j	80007020 <push_on+0x34>

0000000080007060 <pop_on>:
    80007060:	ff010113          	addi	sp,sp,-16
    80007064:	00813023          	sd	s0,0(sp)
    80007068:	00113423          	sd	ra,8(sp)
    8000706c:	01010413          	addi	s0,sp,16
    80007070:	ffffe097          	auipc	ra,0xffffe
    80007074:	5bc080e7          	jalr	1468(ra) # 8000562c <mycpu>
    80007078:	100027f3          	csrr	a5,sstatus
    8000707c:	0027f793          	andi	a5,a5,2
    80007080:	04078463          	beqz	a5,800070c8 <pop_on+0x68>
    80007084:	07852783          	lw	a5,120(a0)
    80007088:	02f05863          	blez	a5,800070b8 <pop_on+0x58>
    8000708c:	fff7879b          	addiw	a5,a5,-1
    80007090:	06f52c23          	sw	a5,120(a0)
    80007094:	07853783          	ld	a5,120(a0)
    80007098:	00079863          	bnez	a5,800070a8 <pop_on+0x48>
    8000709c:	100027f3          	csrr	a5,sstatus
    800070a0:	ffd7f793          	andi	a5,a5,-3
    800070a4:	10079073          	csrw	sstatus,a5
    800070a8:	00813083          	ld	ra,8(sp)
    800070ac:	00013403          	ld	s0,0(sp)
    800070b0:	01010113          	addi	sp,sp,16
    800070b4:	00008067          	ret
    800070b8:	00001517          	auipc	a0,0x1
    800070bc:	6d050513          	addi	a0,a0,1744 # 80008788 <digits+0x70>
    800070c0:	fffff097          	auipc	ra,0xfffff
    800070c4:	f2c080e7          	jalr	-212(ra) # 80005fec <panic>
    800070c8:	00001517          	auipc	a0,0x1
    800070cc:	6a050513          	addi	a0,a0,1696 # 80008768 <digits+0x50>
    800070d0:	fffff097          	auipc	ra,0xfffff
    800070d4:	f1c080e7          	jalr	-228(ra) # 80005fec <panic>

00000000800070d8 <__memset>:
    800070d8:	ff010113          	addi	sp,sp,-16
    800070dc:	00813423          	sd	s0,8(sp)
    800070e0:	01010413          	addi	s0,sp,16
    800070e4:	1a060e63          	beqz	a2,800072a0 <__memset+0x1c8>
    800070e8:	40a007b3          	neg	a5,a0
    800070ec:	0077f793          	andi	a5,a5,7
    800070f0:	00778693          	addi	a3,a5,7
    800070f4:	00b00813          	li	a6,11
    800070f8:	0ff5f593          	andi	a1,a1,255
    800070fc:	fff6071b          	addiw	a4,a2,-1
    80007100:	1b06e663          	bltu	a3,a6,800072ac <__memset+0x1d4>
    80007104:	1cd76463          	bltu	a4,a3,800072cc <__memset+0x1f4>
    80007108:	1a078e63          	beqz	a5,800072c4 <__memset+0x1ec>
    8000710c:	00b50023          	sb	a1,0(a0)
    80007110:	00100713          	li	a4,1
    80007114:	1ae78463          	beq	a5,a4,800072bc <__memset+0x1e4>
    80007118:	00b500a3          	sb	a1,1(a0)
    8000711c:	00200713          	li	a4,2
    80007120:	1ae78a63          	beq	a5,a4,800072d4 <__memset+0x1fc>
    80007124:	00b50123          	sb	a1,2(a0)
    80007128:	00300713          	li	a4,3
    8000712c:	18e78463          	beq	a5,a4,800072b4 <__memset+0x1dc>
    80007130:	00b501a3          	sb	a1,3(a0)
    80007134:	00400713          	li	a4,4
    80007138:	1ae78263          	beq	a5,a4,800072dc <__memset+0x204>
    8000713c:	00b50223          	sb	a1,4(a0)
    80007140:	00500713          	li	a4,5
    80007144:	1ae78063          	beq	a5,a4,800072e4 <__memset+0x20c>
    80007148:	00b502a3          	sb	a1,5(a0)
    8000714c:	00700713          	li	a4,7
    80007150:	18e79e63          	bne	a5,a4,800072ec <__memset+0x214>
    80007154:	00b50323          	sb	a1,6(a0)
    80007158:	00700e93          	li	t4,7
    8000715c:	00859713          	slli	a4,a1,0x8
    80007160:	00e5e733          	or	a4,a1,a4
    80007164:	01059e13          	slli	t3,a1,0x10
    80007168:	01c76e33          	or	t3,a4,t3
    8000716c:	01859313          	slli	t1,a1,0x18
    80007170:	006e6333          	or	t1,t3,t1
    80007174:	02059893          	slli	a7,a1,0x20
    80007178:	40f60e3b          	subw	t3,a2,a5
    8000717c:	011368b3          	or	a7,t1,a7
    80007180:	02859813          	slli	a6,a1,0x28
    80007184:	0108e833          	or	a6,a7,a6
    80007188:	03059693          	slli	a3,a1,0x30
    8000718c:	003e589b          	srliw	a7,t3,0x3
    80007190:	00d866b3          	or	a3,a6,a3
    80007194:	03859713          	slli	a4,a1,0x38
    80007198:	00389813          	slli	a6,a7,0x3
    8000719c:	00f507b3          	add	a5,a0,a5
    800071a0:	00e6e733          	or	a4,a3,a4
    800071a4:	000e089b          	sext.w	a7,t3
    800071a8:	00f806b3          	add	a3,a6,a5
    800071ac:	00e7b023          	sd	a4,0(a5)
    800071b0:	00878793          	addi	a5,a5,8
    800071b4:	fed79ce3          	bne	a5,a3,800071ac <__memset+0xd4>
    800071b8:	ff8e7793          	andi	a5,t3,-8
    800071bc:	0007871b          	sext.w	a4,a5
    800071c0:	01d787bb          	addw	a5,a5,t4
    800071c4:	0ce88e63          	beq	a7,a4,800072a0 <__memset+0x1c8>
    800071c8:	00f50733          	add	a4,a0,a5
    800071cc:	00b70023          	sb	a1,0(a4)
    800071d0:	0017871b          	addiw	a4,a5,1
    800071d4:	0cc77663          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    800071d8:	00e50733          	add	a4,a0,a4
    800071dc:	00b70023          	sb	a1,0(a4)
    800071e0:	0027871b          	addiw	a4,a5,2
    800071e4:	0ac77e63          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    800071e8:	00e50733          	add	a4,a0,a4
    800071ec:	00b70023          	sb	a1,0(a4)
    800071f0:	0037871b          	addiw	a4,a5,3
    800071f4:	0ac77663          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    800071f8:	00e50733          	add	a4,a0,a4
    800071fc:	00b70023          	sb	a1,0(a4)
    80007200:	0047871b          	addiw	a4,a5,4
    80007204:	08c77e63          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007208:	00e50733          	add	a4,a0,a4
    8000720c:	00b70023          	sb	a1,0(a4)
    80007210:	0057871b          	addiw	a4,a5,5
    80007214:	08c77663          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007218:	00e50733          	add	a4,a0,a4
    8000721c:	00b70023          	sb	a1,0(a4)
    80007220:	0067871b          	addiw	a4,a5,6
    80007224:	06c77e63          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007228:	00e50733          	add	a4,a0,a4
    8000722c:	00b70023          	sb	a1,0(a4)
    80007230:	0077871b          	addiw	a4,a5,7
    80007234:	06c77663          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007238:	00e50733          	add	a4,a0,a4
    8000723c:	00b70023          	sb	a1,0(a4)
    80007240:	0087871b          	addiw	a4,a5,8
    80007244:	04c77e63          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007248:	00e50733          	add	a4,a0,a4
    8000724c:	00b70023          	sb	a1,0(a4)
    80007250:	0097871b          	addiw	a4,a5,9
    80007254:	04c77663          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007258:	00e50733          	add	a4,a0,a4
    8000725c:	00b70023          	sb	a1,0(a4)
    80007260:	00a7871b          	addiw	a4,a5,10
    80007264:	02c77e63          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007268:	00e50733          	add	a4,a0,a4
    8000726c:	00b70023          	sb	a1,0(a4)
    80007270:	00b7871b          	addiw	a4,a5,11
    80007274:	02c77663          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007278:	00e50733          	add	a4,a0,a4
    8000727c:	00b70023          	sb	a1,0(a4)
    80007280:	00c7871b          	addiw	a4,a5,12
    80007284:	00c77e63          	bgeu	a4,a2,800072a0 <__memset+0x1c8>
    80007288:	00e50733          	add	a4,a0,a4
    8000728c:	00b70023          	sb	a1,0(a4)
    80007290:	00d7879b          	addiw	a5,a5,13
    80007294:	00c7f663          	bgeu	a5,a2,800072a0 <__memset+0x1c8>
    80007298:	00f507b3          	add	a5,a0,a5
    8000729c:	00b78023          	sb	a1,0(a5)
    800072a0:	00813403          	ld	s0,8(sp)
    800072a4:	01010113          	addi	sp,sp,16
    800072a8:	00008067          	ret
    800072ac:	00b00693          	li	a3,11
    800072b0:	e55ff06f          	j	80007104 <__memset+0x2c>
    800072b4:	00300e93          	li	t4,3
    800072b8:	ea5ff06f          	j	8000715c <__memset+0x84>
    800072bc:	00100e93          	li	t4,1
    800072c0:	e9dff06f          	j	8000715c <__memset+0x84>
    800072c4:	00000e93          	li	t4,0
    800072c8:	e95ff06f          	j	8000715c <__memset+0x84>
    800072cc:	00000793          	li	a5,0
    800072d0:	ef9ff06f          	j	800071c8 <__memset+0xf0>
    800072d4:	00200e93          	li	t4,2
    800072d8:	e85ff06f          	j	8000715c <__memset+0x84>
    800072dc:	00400e93          	li	t4,4
    800072e0:	e7dff06f          	j	8000715c <__memset+0x84>
    800072e4:	00500e93          	li	t4,5
    800072e8:	e75ff06f          	j	8000715c <__memset+0x84>
    800072ec:	00600e93          	li	t4,6
    800072f0:	e6dff06f          	j	8000715c <__memset+0x84>

00000000800072f4 <__memmove>:
    800072f4:	ff010113          	addi	sp,sp,-16
    800072f8:	00813423          	sd	s0,8(sp)
    800072fc:	01010413          	addi	s0,sp,16
    80007300:	0e060863          	beqz	a2,800073f0 <__memmove+0xfc>
    80007304:	fff6069b          	addiw	a3,a2,-1
    80007308:	0006881b          	sext.w	a6,a3
    8000730c:	0ea5e863          	bltu	a1,a0,800073fc <__memmove+0x108>
    80007310:	00758713          	addi	a4,a1,7
    80007314:	00a5e7b3          	or	a5,a1,a0
    80007318:	40a70733          	sub	a4,a4,a0
    8000731c:	0077f793          	andi	a5,a5,7
    80007320:	00f73713          	sltiu	a4,a4,15
    80007324:	00174713          	xori	a4,a4,1
    80007328:	0017b793          	seqz	a5,a5
    8000732c:	00e7f7b3          	and	a5,a5,a4
    80007330:	10078863          	beqz	a5,80007440 <__memmove+0x14c>
    80007334:	00900793          	li	a5,9
    80007338:	1107f463          	bgeu	a5,a6,80007440 <__memmove+0x14c>
    8000733c:	0036581b          	srliw	a6,a2,0x3
    80007340:	fff8081b          	addiw	a6,a6,-1
    80007344:	02081813          	slli	a6,a6,0x20
    80007348:	01d85893          	srli	a7,a6,0x1d
    8000734c:	00858813          	addi	a6,a1,8
    80007350:	00058793          	mv	a5,a1
    80007354:	00050713          	mv	a4,a0
    80007358:	01088833          	add	a6,a7,a6
    8000735c:	0007b883          	ld	a7,0(a5)
    80007360:	00878793          	addi	a5,a5,8
    80007364:	00870713          	addi	a4,a4,8
    80007368:	ff173c23          	sd	a7,-8(a4)
    8000736c:	ff0798e3          	bne	a5,a6,8000735c <__memmove+0x68>
    80007370:	ff867713          	andi	a4,a2,-8
    80007374:	02071793          	slli	a5,a4,0x20
    80007378:	0207d793          	srli	a5,a5,0x20
    8000737c:	00f585b3          	add	a1,a1,a5
    80007380:	40e686bb          	subw	a3,a3,a4
    80007384:	00f507b3          	add	a5,a0,a5
    80007388:	06e60463          	beq	a2,a4,800073f0 <__memmove+0xfc>
    8000738c:	0005c703          	lbu	a4,0(a1)
    80007390:	00e78023          	sb	a4,0(a5)
    80007394:	04068e63          	beqz	a3,800073f0 <__memmove+0xfc>
    80007398:	0015c603          	lbu	a2,1(a1)
    8000739c:	00100713          	li	a4,1
    800073a0:	00c780a3          	sb	a2,1(a5)
    800073a4:	04e68663          	beq	a3,a4,800073f0 <__memmove+0xfc>
    800073a8:	0025c603          	lbu	a2,2(a1)
    800073ac:	00200713          	li	a4,2
    800073b0:	00c78123          	sb	a2,2(a5)
    800073b4:	02e68e63          	beq	a3,a4,800073f0 <__memmove+0xfc>
    800073b8:	0035c603          	lbu	a2,3(a1)
    800073bc:	00300713          	li	a4,3
    800073c0:	00c781a3          	sb	a2,3(a5)
    800073c4:	02e68663          	beq	a3,a4,800073f0 <__memmove+0xfc>
    800073c8:	0045c603          	lbu	a2,4(a1)
    800073cc:	00400713          	li	a4,4
    800073d0:	00c78223          	sb	a2,4(a5)
    800073d4:	00e68e63          	beq	a3,a4,800073f0 <__memmove+0xfc>
    800073d8:	0055c603          	lbu	a2,5(a1)
    800073dc:	00500713          	li	a4,5
    800073e0:	00c782a3          	sb	a2,5(a5)
    800073e4:	00e68663          	beq	a3,a4,800073f0 <__memmove+0xfc>
    800073e8:	0065c703          	lbu	a4,6(a1)
    800073ec:	00e78323          	sb	a4,6(a5)
    800073f0:	00813403          	ld	s0,8(sp)
    800073f4:	01010113          	addi	sp,sp,16
    800073f8:	00008067          	ret
    800073fc:	02061713          	slli	a4,a2,0x20
    80007400:	02075713          	srli	a4,a4,0x20
    80007404:	00e587b3          	add	a5,a1,a4
    80007408:	f0f574e3          	bgeu	a0,a5,80007310 <__memmove+0x1c>
    8000740c:	02069613          	slli	a2,a3,0x20
    80007410:	02065613          	srli	a2,a2,0x20
    80007414:	fff64613          	not	a2,a2
    80007418:	00e50733          	add	a4,a0,a4
    8000741c:	00c78633          	add	a2,a5,a2
    80007420:	fff7c683          	lbu	a3,-1(a5)
    80007424:	fff78793          	addi	a5,a5,-1
    80007428:	fff70713          	addi	a4,a4,-1
    8000742c:	00d70023          	sb	a3,0(a4)
    80007430:	fec798e3          	bne	a5,a2,80007420 <__memmove+0x12c>
    80007434:	00813403          	ld	s0,8(sp)
    80007438:	01010113          	addi	sp,sp,16
    8000743c:	00008067          	ret
    80007440:	02069713          	slli	a4,a3,0x20
    80007444:	02075713          	srli	a4,a4,0x20
    80007448:	00170713          	addi	a4,a4,1
    8000744c:	00e50733          	add	a4,a0,a4
    80007450:	00050793          	mv	a5,a0
    80007454:	0005c683          	lbu	a3,0(a1)
    80007458:	00178793          	addi	a5,a5,1
    8000745c:	00158593          	addi	a1,a1,1
    80007460:	fed78fa3          	sb	a3,-1(a5)
    80007464:	fee798e3          	bne	a5,a4,80007454 <__memmove+0x160>
    80007468:	f89ff06f          	j	800073f0 <__memmove+0xfc>
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
    8000d43c:	bc8080e7          	jalr	-1080(ra) # 8000f000 <_Znwm>
    8000d440:	00050913          	mv	s2,a0
    8000d444:	00050863          	beqz	a0,8000d454 <_ZN9BufferCPPC1Ei+0x68>
    8000d448:	00000593          	li	a1,0
    8000d44c:	00002097          	auipc	ra,0x2
    8000d450:	cac080e7          	jalr	-852(ra) # 8000f0f8 <_ZN9SemaphoreC1Ej>
    8000d454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000d458:	01000513          	li	a0,16
    8000d45c:	00002097          	auipc	ra,0x2
    8000d460:	ba4080e7          	jalr	-1116(ra) # 8000f000 <_Znwm>
    8000d464:	00050913          	mv	s2,a0
    8000d468:	00050863          	beqz	a0,8000d478 <_ZN9BufferCPPC1Ei+0x8c>
    8000d46c:	00098593          	mv	a1,s3
    8000d470:	00002097          	auipc	ra,0x2
    8000d474:	c88080e7          	jalr	-888(ra) # 8000f0f8 <_ZN9SemaphoreC1Ej>
    8000d478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000d47c:	01000513          	li	a0,16
    8000d480:	00002097          	auipc	ra,0x2
    8000d484:	b80080e7          	jalr	-1152(ra) # 8000f000 <_Znwm>
    8000d488:	00050913          	mv	s2,a0
    8000d48c:	00050863          	beqz	a0,8000d49c <_ZN9BufferCPPC1Ei+0xb0>
    8000d490:	00100593          	li	a1,1
    8000d494:	00002097          	auipc	ra,0x2
    8000d498:	c64080e7          	jalr	-924(ra) # 8000f0f8 <_ZN9SemaphoreC1Ej>
    8000d49c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000d4a0:	01000513          	li	a0,16
    8000d4a4:	00002097          	auipc	ra,0x2
    8000d4a8:	b5c080e7          	jalr	-1188(ra) # 8000f000 <_Znwm>
    8000d4ac:	00050913          	mv	s2,a0
    8000d4b0:	00050863          	beqz	a0,8000d4c0 <_ZN9BufferCPPC1Ei+0xd4>
    8000d4b4:	00100593          	li	a1,1
    8000d4b8:	00002097          	auipc	ra,0x2
    8000d4bc:	c40080e7          	jalr	-960(ra) # 8000f0f8 <_ZN9SemaphoreC1Ej>
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
    8000d4ec:	b68080e7          	jalr	-1176(ra) # 8000f050 <_ZdlPv>
    8000d4f0:	00048513          	mv	a0,s1
    8000d4f4:	fffff097          	auipc	ra,0xfffff
    8000d4f8:	e44080e7          	jalr	-444(ra) # 8000c338 <_Unwind_Resume>
    8000d4fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000d500:	00090513          	mv	a0,s2
    8000d504:	00002097          	auipc	ra,0x2
    8000d508:	b4c080e7          	jalr	-1204(ra) # 8000f050 <_ZdlPv>
    8000d50c:	00048513          	mv	a0,s1
    8000d510:	fffff097          	auipc	ra,0xfffff
    8000d514:	e28080e7          	jalr	-472(ra) # 8000c338 <_Unwind_Resume>
    8000d518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000d51c:	00090513          	mv	a0,s2
    8000d520:	00002097          	auipc	ra,0x2
    8000d524:	b30080e7          	jalr	-1232(ra) # 8000f050 <_ZdlPv>
    8000d528:	00048513          	mv	a0,s1
    8000d52c:	fffff097          	auipc	ra,0xfffff
    8000d530:	e0c080e7          	jalr	-500(ra) # 8000c338 <_Unwind_Resume>
    8000d534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000d538:	00090513          	mv	a0,s2
    8000d53c:	00002097          	auipc	ra,0x2
    8000d540:	b14080e7          	jalr	-1260(ra) # 8000f050 <_ZdlPv>
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
    8000d578:	bbc080e7          	jalr	-1092(ra) # 8000f130 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000d57c:	0304b503          	ld	a0,48(s1)
    8000d580:	00002097          	auipc	ra,0x2
    8000d584:	bb0080e7          	jalr	-1104(ra) # 8000f130 <_ZN9Semaphore4waitEv>
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
    8000d5b8:	ba8080e7          	jalr	-1112(ra) # 8000f15c <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000d5bc:	0204b503          	ld	a0,32(s1)
    8000d5c0:	00002097          	auipc	ra,0x2
    8000d5c4:	b9c080e7          	jalr	-1124(ra) # 8000f15c <_ZN9Semaphore6signalEv>

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
    8000d604:	b30080e7          	jalr	-1232(ra) # 8000f130 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000d608:	0284b503          	ld	a0,40(s1)
    8000d60c:	00002097          	auipc	ra,0x2
    8000d610:	b24080e7          	jalr	-1244(ra) # 8000f130 <_ZN9Semaphore4waitEv>

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
    8000d640:	b20080e7          	jalr	-1248(ra) # 8000f15c <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000d644:	0184b503          	ld	a0,24(s1)
    8000d648:	00002097          	auipc	ra,0x2
    8000d64c:	b14080e7          	jalr	-1260(ra) # 8000f15c <_ZN9Semaphore6signalEv>

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
    8000d690:	aa4080e7          	jalr	-1372(ra) # 8000f130 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000d694:	0304b503          	ld	a0,48(s1)
    8000d698:	00002097          	auipc	ra,0x2
    8000d69c:	a98080e7          	jalr	-1384(ra) # 8000f130 <_ZN9Semaphore4waitEv>

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
    8000d6b8:	aa8080e7          	jalr	-1368(ra) # 8000f15c <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000d6bc:	0284b503          	ld	a0,40(s1)
    8000d6c0:	00002097          	auipc	ra,0x2
    8000d6c4:	a9c080e7          	jalr	-1380(ra) # 8000f15c <_ZN9Semaphore6signalEv>

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
    8000d714:	c84080e7          	jalr	-892(ra) # 8000f394 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000d718:	00003517          	auipc	a0,0x3
    8000d71c:	8e850513          	addi	a0,a0,-1816 # 80010000 <userDataStart>
    8000d720:	00001097          	auipc	ra,0x1
    8000d724:	534080e7          	jalr	1332(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000d750:	c48080e7          	jalr	-952(ra) # 8000f394 <_ZN7Console4putcEc>
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
    8000d774:	c24080e7          	jalr	-988(ra) # 8000f394 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000d778:	00a00513          	li	a0,10
    8000d77c:	00002097          	auipc	ra,0x2
    8000d780:	c18080e7          	jalr	-1000(ra) # 8000f394 <_ZN7Console4putcEc>
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
    8000d85c:	3fc080e7          	jalr	1020(ra) # 8000ec54 <_Z11printStringPKc>
    8000d860:	00000613          	li	a2,0
    8000d864:	00a00593          	li	a1,10
    8000d868:	0009051b          	sext.w	a0,s2
    8000d86c:	00001097          	auipc	ra,0x1
    8000d870:	580080e7          	jalr	1408(ra) # 8000edec <_Z8printIntiii>
    8000d874:	00003517          	auipc	a0,0x3
    8000d878:	8d450513          	addi	a0,a0,-1836 # 80010148 <userDataStart+0x148>
    8000d87c:	00001097          	auipc	ra,0x1
    8000d880:	3d8080e7          	jalr	984(ra) # 8000ec54 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d884:	00000493          	li	s1,0
    8000d888:	f99ff06f          	j	8000d820 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000d88c:	00002517          	auipc	a0,0x2
    8000d890:	79450513          	addi	a0,a0,1940 # 80010020 <userDataStart+0x20>
    8000d894:	00001097          	auipc	ra,0x1
    8000d898:	3c0080e7          	jalr	960(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000d928:	330080e7          	jalr	816(ra) # 8000ec54 <_Z11printStringPKc>
    8000d92c:	00000613          	li	a2,0
    8000d930:	00a00593          	li	a1,10
    8000d934:	0009051b          	sext.w	a0,s2
    8000d938:	00001097          	auipc	ra,0x1
    8000d93c:	4b4080e7          	jalr	1204(ra) # 8000edec <_Z8printIntiii>
    8000d940:	00003517          	auipc	a0,0x3
    8000d944:	80850513          	addi	a0,a0,-2040 # 80010148 <userDataStart+0x148>
    8000d948:	00001097          	auipc	ra,0x1
    8000d94c:	30c080e7          	jalr	780(ra) # 8000ec54 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d950:	00000493          	li	s1,0
    8000d954:	f99ff06f          	j	8000d8ec <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000d958:	00002517          	auipc	a0,0x2
    8000d95c:	6e050513          	addi	a0,a0,1760 # 80010038 <userDataStart+0x38>
    8000d960:	00001097          	auipc	ra,0x1
    8000d964:	2f4080e7          	jalr	756(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000da34:	224080e7          	jalr	548(ra) # 8000ec54 <_Z11printStringPKc>
    8000da38:	00000613          	li	a2,0
    8000da3c:	00a00593          	li	a1,10
    8000da40:	00048513          	mv	a0,s1
    8000da44:	00001097          	auipc	ra,0x1
    8000da48:	3a8080e7          	jalr	936(ra) # 8000edec <_Z8printIntiii>
    8000da4c:	00002517          	auipc	a0,0x2
    8000da50:	6fc50513          	addi	a0,a0,1788 # 80010148 <userDataStart+0x148>
    8000da54:	00001097          	auipc	ra,0x1
    8000da58:	200080e7          	jalr	512(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000da78:	1e0080e7          	jalr	480(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000da98:	1c0080e7          	jalr	448(ra) # 8000ec54 <_Z11printStringPKc>
    8000da9c:	00000613          	li	a2,0
    8000daa0:	00a00593          	li	a1,10
    8000daa4:	0009051b          	sext.w	a0,s2
    8000daa8:	00001097          	auipc	ra,0x1
    8000daac:	344080e7          	jalr	836(ra) # 8000edec <_Z8printIntiii>
    8000dab0:	00002517          	auipc	a0,0x2
    8000dab4:	69850513          	addi	a0,a0,1688 # 80010148 <userDataStart+0x148>
    8000dab8:	00001097          	auipc	ra,0x1
    8000dabc:	19c080e7          	jalr	412(ra) # 8000ec54 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000dac0:	00c00513          	li	a0,12
    8000dac4:	00000097          	auipc	ra,0x0
    8000dac8:	ed0080e7          	jalr	-304(ra) # 8000d994 <_Z9fibonaccim>
    8000dacc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000dad0:	00002517          	auipc	a0,0x2
    8000dad4:	59850513          	addi	a0,a0,1432 # 80010068 <userDataStart+0x68>
    8000dad8:	00001097          	auipc	ra,0x1
    8000dadc:	17c080e7          	jalr	380(ra) # 8000ec54 <_Z11printStringPKc>
    8000dae0:	00000613          	li	a2,0
    8000dae4:	00a00593          	li	a1,10
    8000dae8:	0009051b          	sext.w	a0,s2
    8000daec:	00001097          	auipc	ra,0x1
    8000daf0:	300080e7          	jalr	768(ra) # 8000edec <_Z8printIntiii>
    8000daf4:	00002517          	auipc	a0,0x2
    8000daf8:	65450513          	addi	a0,a0,1620 # 80010148 <userDataStart+0x148>
    8000dafc:	00001097          	auipc	ra,0x1
    8000db00:	158080e7          	jalr	344(ra) # 8000ec54 <_Z11printStringPKc>
    8000db04:	0400006f          	j	8000db44 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000db08:	00002517          	auipc	a0,0x2
    8000db0c:	54050513          	addi	a0,a0,1344 # 80010048 <userDataStart+0x48>
    8000db10:	00001097          	auipc	ra,0x1
    8000db14:	144080e7          	jalr	324(ra) # 8000ec54 <_Z11printStringPKc>
    8000db18:	00000613          	li	a2,0
    8000db1c:	00a00593          	li	a1,10
    8000db20:	00048513          	mv	a0,s1
    8000db24:	00001097          	auipc	ra,0x1
    8000db28:	2c8080e7          	jalr	712(ra) # 8000edec <_Z8printIntiii>
    8000db2c:	00002517          	auipc	a0,0x2
    8000db30:	61c50513          	addi	a0,a0,1564 # 80010148 <userDataStart+0x148>
    8000db34:	00001097          	auipc	ra,0x1
    8000db38:	120080e7          	jalr	288(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000db58:	100080e7          	jalr	256(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000dbb4:	0a4080e7          	jalr	164(ra) # 8000ec54 <_Z11printStringPKc>
    8000dbb8:	00000613          	li	a2,0
    8000dbbc:	00a00593          	li	a1,10
    8000dbc0:	00048513          	mv	a0,s1
    8000dbc4:	00001097          	auipc	ra,0x1
    8000dbc8:	228080e7          	jalr	552(ra) # 8000edec <_Z8printIntiii>
    8000dbcc:	00002517          	auipc	a0,0x2
    8000dbd0:	57c50513          	addi	a0,a0,1404 # 80010148 <userDataStart+0x148>
    8000dbd4:	00001097          	auipc	ra,0x1
    8000dbd8:	080080e7          	jalr	128(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000dbf8:	060080e7          	jalr	96(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000dc24:	034080e7          	jalr	52(ra) # 8000ec54 <_Z11printStringPKc>
    8000dc28:	00000613          	li	a2,0
    8000dc2c:	00a00593          	li	a1,10
    8000dc30:	0009051b          	sext.w	a0,s2
    8000dc34:	00001097          	auipc	ra,0x1
    8000dc38:	1b8080e7          	jalr	440(ra) # 8000edec <_Z8printIntiii>
    8000dc3c:	00002517          	auipc	a0,0x2
    8000dc40:	50c50513          	addi	a0,a0,1292 # 80010148 <userDataStart+0x148>
    8000dc44:	00001097          	auipc	ra,0x1
    8000dc48:	010080e7          	jalr	16(ra) # 8000ec54 <_Z11printStringPKc>
    8000dc4c:	0400006f          	j	8000dc8c <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000dc50:	00002517          	auipc	a0,0x2
    8000dc54:	42850513          	addi	a0,a0,1064 # 80010078 <userDataStart+0x78>
    8000dc58:	00001097          	auipc	ra,0x1
    8000dc5c:	ffc080e7          	jalr	-4(ra) # 8000ec54 <_Z11printStringPKc>
    8000dc60:	00000613          	li	a2,0
    8000dc64:	00a00593          	li	a1,10
    8000dc68:	00048513          	mv	a0,s1
    8000dc6c:	00001097          	auipc	ra,0x1
    8000dc70:	180080e7          	jalr	384(ra) # 8000edec <_Z8printIntiii>
    8000dc74:	00002517          	auipc	a0,0x2
    8000dc78:	4d450513          	addi	a0,a0,1236 # 80010148 <userDataStart+0x148>
    8000dc7c:	00001097          	auipc	ra,0x1
    8000dc80:	fd8080e7          	jalr	-40(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000dca0:	fb8080e7          	jalr	-72(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000dd08:	f50080e7          	jalr	-176(ra) # 8000ec54 <_Z11printStringPKc>

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
    8000dd30:	f28080e7          	jalr	-216(ra) # 8000ec54 <_Z11printStringPKc>

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
    8000dd58:	f00080e7          	jalr	-256(ra) # 8000ec54 <_Z11printStringPKc>

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
    8000dd80:	ed8080e7          	jalr	-296(ra) # 8000ec54 <_Z11printStringPKc>
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
    8000de40:	e18080e7          	jalr	-488(ra) # 8000ec54 <_Z11printStringPKc>
        getString(input, 30);
    8000de44:	01e00593          	li	a1,30
    8000de48:	f8040493          	addi	s1,s0,-128
    8000de4c:	00048513          	mv	a0,s1
    8000de50:	00001097          	auipc	ra,0x1
    8000de54:	e80080e7          	jalr	-384(ra) # 8000ecd0 <_Z9getStringPci>
        threadNum = stringToInt(input);
    8000de58:	00048513          	mv	a0,s1
    8000de5c:	00001097          	auipc	ra,0x1
    8000de60:	f40080e7          	jalr	-192(ra) # 8000ed9c <_Z11stringToIntPKc>
    8000de64:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    8000de68:	00002517          	auipc	a0,0x2
    8000de6c:	2c850513          	addi	a0,a0,712 # 80010130 <userDataStart+0x130>
    8000de70:	00001097          	auipc	ra,0x1
    8000de74:	de4080e7          	jalr	-540(ra) # 8000ec54 <_Z11printStringPKc>
        getString(input, 30);
    8000de78:	01e00593          	li	a1,30
    8000de7c:	00048513          	mv	a0,s1
    8000de80:	00001097          	auipc	ra,0x1
    8000de84:	e50080e7          	jalr	-432(ra) # 8000ecd0 <_Z9getStringPci>
        n = stringToInt(input);
    8000de88:	00048513          	mv	a0,s1
    8000de8c:	00001097          	auipc	ra,0x1
    8000de90:	f10080e7          	jalr	-240(ra) # 8000ed9c <_Z11stringToIntPKc>
    8000de94:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    8000de98:	00002517          	auipc	a0,0x2
    8000de9c:	2b850513          	addi	a0,a0,696 # 80010150 <userDataStart+0x150>
    8000dea0:	00001097          	auipc	ra,0x1
    8000dea4:	db4080e7          	jalr	-588(ra) # 8000ec54 <_Z11printStringPKc>
    8000dea8:	00000613          	li	a2,0
    8000deac:	00a00593          	li	a1,10
    8000deb0:	00090513          	mv	a0,s2
    8000deb4:	00001097          	auipc	ra,0x1
    8000deb8:	f38080e7          	jalr	-200(ra) # 8000edec <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000debc:	00002517          	auipc	a0,0x2
    8000dec0:	2ac50513          	addi	a0,a0,684 # 80010168 <userDataStart+0x168>
    8000dec4:	00001097          	auipc	ra,0x1
    8000dec8:	d90080e7          	jalr	-624(ra) # 8000ec54 <_Z11printStringPKc>
    8000decc:	00000613          	li	a2,0
    8000ded0:	00a00593          	li	a1,10
    8000ded4:	00048513          	mv	a0,s1
    8000ded8:	00001097          	auipc	ra,0x1
    8000dedc:	f14080e7          	jalr	-236(ra) # 8000edec <_Z8printIntiii>
        printString(".\n");
    8000dee0:	00002517          	auipc	a0,0x2
    8000dee4:	2a050513          	addi	a0,a0,672 # 80010180 <userDataStart+0x180>
    8000dee8:	00001097          	auipc	ra,0x1
    8000deec:	d6c080e7          	jalr	-660(ra) # 8000ec54 <_Z11printStringPKc>
        if(threadNum > n) {
    8000def0:	0324c663          	blt	s1,s2,8000df1c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    8000def4:	03205e63          	blez	s2,8000df30 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    8000def8:	03800513          	li	a0,56
    8000defc:	00001097          	auipc	ra,0x1
    8000df00:	104080e7          	jalr	260(ra) # 8000f000 <_Znwm>
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
    8000df28:	d30080e7          	jalr	-720(ra) # 8000ec54 <_Z11printStringPKc>
            return;
    8000df2c:	0140006f          	j	8000df40 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000df30:	00002517          	auipc	a0,0x2
    8000df34:	29850513          	addi	a0,a0,664 # 800101c8 <userDataStart+0x1c8>
    8000df38:	00001097          	auipc	ra,0x1
    8000df3c:	d1c080e7          	jalr	-740(ra) # 8000ec54 <_Z11printStringPKc>
            return;
    8000df40:	000b8113          	mv	sp,s7
    8000df44:	24c0006f          	j	8000e190 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    8000df48:	01000513          	li	a0,16
    8000df4c:	00001097          	auipc	ra,0x1
    8000df50:	0b4080e7          	jalr	180(ra) # 8000f000 <_Znwm>
    8000df54:	00050493          	mv	s1,a0
    8000df58:	00050863          	beqz	a0,8000df68 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000df5c:	00000593          	li	a1,0
    8000df60:	00001097          	auipc	ra,0x1
    8000df64:	198080e7          	jalr	408(ra) # 8000f0f8 <_ZN9SemaphoreC1Ej>
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
    8000dfd0:	034080e7          	jalr	52(ra) # 8000f000 <_Znwm>
    8000dfd4:	00050b13          	mv	s6,a0
    8000dfd8:	02050663          	beqz	a0,8000e004 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    8000dfdc:	00191493          	slli	s1,s2,0x1
    8000dfe0:	012484b3          	add	s1,s1,s2
    8000dfe4:	00349493          	slli	s1,s1,0x3
    8000dfe8:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000dfec:	00001097          	auipc	ra,0x1
    8000dff0:	1f0080e7          	jalr	496(ra) # 8000f1dc <_ZN6ThreadC1Ev>
    8000dff4:	00002797          	auipc	a5,0x2
    8000dff8:	2ac78793          	addi	a5,a5,684 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000dffc:	00fb3023          	sd	a5,0(s6) # 2000 <_entry-0x7fffe000>
    8000e000:	009b3823          	sd	s1,16(s6)
        consumer->start();
    8000e004:	000b0513          	mv	a0,s6
    8000e008:	00001097          	auipc	ra,0x1
    8000e00c:	2c4080e7          	jalr	708(ra) # 8000f2cc <_ZN6Thread5startEv>
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
    8000e02c:	fd8080e7          	jalr	-40(ra) # 8000f000 <_Znwm>
    8000e030:	00050493          	mv	s1,a0
    8000e034:	00050e63          	beqz	a0,8000e050 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    8000e038:	00001097          	auipc	ra,0x1
    8000e03c:	1a4080e7          	jalr	420(ra) # 8000f1dc <_ZN6ThreadC1Ev>
    8000e040:	00002797          	auipc	a5,0x2
    8000e044:	21078793          	addi	a5,a5,528 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e048:	00f4b023          	sd	a5,0(s1)
    8000e04c:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e050:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    8000e054:	00048513          	mv	a0,s1
    8000e058:	00001097          	auipc	ra,0x1
    8000e05c:	274080e7          	jalr	628(ra) # 8000f2cc <_ZN6Thread5startEv>
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
    8000e08c:	244080e7          	jalr	580(ra) # 8000f2cc <_ZN6Thread5startEv>
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
    8000e0c4:	f40080e7          	jalr	-192(ra) # 8000f000 <_Znwm>
    8000e0c8:	00050c13          	mv	s8,a0
    8000e0cc:	fa0506e3          	beqz	a0,8000e078 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    8000e0d0:	00149c93          	slli	s9,s1,0x1
    8000e0d4:	009c8cb3          	add	s9,s9,s1
    8000e0d8:	003c9c93          	slli	s9,s9,0x3
    8000e0dc:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000e0e0:	00001097          	auipc	ra,0x1
    8000e0e4:	0fc080e7          	jalr	252(ra) # 8000f1dc <_ZN6ThreadC1Ev>
    8000e0e8:	f81ff06f          	j	8000e068 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    8000e0ec:	00001097          	auipc	ra,0x1
    8000e0f0:	1b8080e7          	jalr	440(ra) # 8000f2a4 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000e0f4:	00000493          	li	s1,0
    8000e0f8:	00994e63          	blt	s2,s1,8000e114 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    8000e0fc:	00002517          	auipc	a0,0x2
    8000e100:	28453503          	ld	a0,644(a0) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e104:	00001097          	auipc	ra,0x1
    8000e108:	02c080e7          	jalr	44(ra) # 8000f130 <_ZN9Semaphore4waitEv>
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
    8000e188:	ecc080e7          	jalr	-308(ra) # 8000f050 <_ZdlPv>
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
    8000e1d4:	e80080e7          	jalr	-384(ra) # 8000f050 <_ZdlPv>
    8000e1d8:	00048513          	mv	a0,s1
    8000e1dc:	ffffe097          	auipc	ra,0xffffe
    8000e1e0:	15c080e7          	jalr	348(ra) # 8000c338 <_Unwind_Resume>
    8000e1e4:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    8000e1e8:	00048513          	mv	a0,s1
    8000e1ec:	00001097          	auipc	ra,0x1
    8000e1f0:	e64080e7          	jalr	-412(ra) # 8000f050 <_ZdlPv>
    8000e1f4:	00090513          	mv	a0,s2
    8000e1f8:	ffffe097          	auipc	ra,0xffffe
    8000e1fc:	140080e7          	jalr	320(ra) # 8000c338 <_Unwind_Resume>
    8000e200:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000e204:	000b0513          	mv	a0,s6
    8000e208:	00001097          	auipc	ra,0x1
    8000e20c:	e48080e7          	jalr	-440(ra) # 8000f050 <_ZdlPv>
    8000e210:	00048513          	mv	a0,s1
    8000e214:	ffffe097          	auipc	ra,0xffffe
    8000e218:	124080e7          	jalr	292(ra) # 8000c338 <_Unwind_Resume>
    8000e21c:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e220:	00048513          	mv	a0,s1
    8000e224:	00001097          	auipc	ra,0x1
    8000e228:	e2c080e7          	jalr	-468(ra) # 8000f050 <_ZdlPv>
    8000e22c:	00090513          	mv	a0,s2
    8000e230:	ffffe097          	auipc	ra,0xffffe
    8000e234:	108080e7          	jalr	264(ra) # 8000c338 <_Unwind_Resume>
    8000e238:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000e23c:	000c0513          	mv	a0,s8
    8000e240:	00001097          	auipc	ra,0x1
    8000e244:	e10080e7          	jalr	-496(ra) # 8000f050 <_ZdlPv>
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
    8000e274:	f6c080e7          	jalr	-148(ra) # 8000f1dc <_ZN6ThreadC1Ev>
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
    8000e298:	038080e7          	jalr	56(ra) # 8000f2cc <_ZN6Thread5startEv>
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
    8000e2bc:	99c080e7          	jalr	-1636(ra) # 8000ec54 <_Z11printStringPKc>
class ForkThread : public Thread {
    8000e2c0:	00002797          	auipc	a5,0x2
    8000e2c4:	00878793          	addi	a5,a5,8 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e2c8:	fcf43023          	sd	a5,-64(s0)
    8000e2cc:	fc040513          	addi	a0,s0,-64
    8000e2d0:	00001097          	auipc	ra,0x1
    8000e2d4:	cf0080e7          	jalr	-784(ra) # 8000efc0 <_ZN6ThreadD1Ev>
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
    8000e304:	cc0080e7          	jalr	-832(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e308:	00048513          	mv	a0,s1
    8000e30c:	ffffe097          	auipc	ra,0xffffe
    8000e310:	02c080e7          	jalr	44(ra) # 8000c338 <_Unwind_Resume>

000000008000e314 <_Z8userMainv>:

//#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta
#include "testUser.hpp"

void userMain() {
    8000e314:	ff010113          	addi	sp,sp,-16
    8000e318:	00813423          	sd	s0,8(sp)
    8000e31c:	01010413          	addi	s0,sp,16
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
//    testUser();
    8000e320:	00813403          	ld	s0,8(sp)
    8000e324:	01010113          	addi	sp,sp,16
    8000e328:	00008067          	ret

000000008000e32c <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    8000e32c:	fd010113          	addi	sp,sp,-48
    8000e330:	02113423          	sd	ra,40(sp)
    8000e334:	02813023          	sd	s0,32(sp)
    8000e338:	00913c23          	sd	s1,24(sp)
    8000e33c:	01213823          	sd	s2,16(sp)
    8000e340:	01313423          	sd	s3,8(sp)
    8000e344:	03010413          	addi	s0,sp,48
    8000e348:	00050913          	mv	s2,a0
            int i = 0;
    8000e34c:	00000993          	li	s3,0
    8000e350:	0100006f          	j	8000e360 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    8000e354:	00a00513          	li	a0,10
    8000e358:	00001097          	auipc	ra,0x1
    8000e35c:	03c080e7          	jalr	60(ra) # 8000f394 <_ZN7Console4putcEc>
            while (!threadEnd) {
    8000e360:	00002797          	auipc	a5,0x2
    8000e364:	0147a783          	lw	a5,20(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e368:	04079a63          	bnez	a5,8000e3bc <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    8000e36c:	01093783          	ld	a5,16(s2)
    8000e370:	0087b503          	ld	a0,8(a5)
    8000e374:	fffff097          	auipc	ra,0xfffff
    8000e378:	26c080e7          	jalr	620(ra) # 8000d5e0 <_ZN9BufferCPP3getEv>
                i++;
    8000e37c:	0019849b          	addiw	s1,s3,1
    8000e380:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    8000e384:	0ff57513          	andi	a0,a0,255
    8000e388:	00001097          	auipc	ra,0x1
    8000e38c:	00c080e7          	jalr	12(ra) # 8000f394 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    8000e390:	05000793          	li	a5,80
    8000e394:	02f4e4bb          	remw	s1,s1,a5
    8000e398:	fc0494e3          	bnez	s1,8000e360 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    8000e39c:	fb9ff06f          	j	8000e354 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    8000e3a0:	01093783          	ld	a5,16(s2)
    8000e3a4:	0087b503          	ld	a0,8(a5)
    8000e3a8:	fffff097          	auipc	ra,0xfffff
    8000e3ac:	238080e7          	jalr	568(ra) # 8000d5e0 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    8000e3b0:	0ff57513          	andi	a0,a0,255
    8000e3b4:	00001097          	auipc	ra,0x1
    8000e3b8:	fe0080e7          	jalr	-32(ra) # 8000f394 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    8000e3bc:	01093783          	ld	a5,16(s2)
    8000e3c0:	0087b503          	ld	a0,8(a5)
    8000e3c4:	fffff097          	auipc	ra,0xfffff
    8000e3c8:	2a8080e7          	jalr	680(ra) # 8000d66c <_ZN9BufferCPP6getCntEv>
    8000e3cc:	fca04ae3          	bgtz	a0,8000e3a0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    8000e3d0:	01093783          	ld	a5,16(s2)
    8000e3d4:	0107b503          	ld	a0,16(a5)
    8000e3d8:	00001097          	auipc	ra,0x1
    8000e3dc:	d84080e7          	jalr	-636(ra) # 8000f15c <_ZN9Semaphore6signalEv>
        }
    8000e3e0:	02813083          	ld	ra,40(sp)
    8000e3e4:	02013403          	ld	s0,32(sp)
    8000e3e8:	01813483          	ld	s1,24(sp)
    8000e3ec:	01013903          	ld	s2,16(sp)
    8000e3f0:	00813983          	ld	s3,8(sp)
    8000e3f4:	03010113          	addi	sp,sp,48
    8000e3f8:	00008067          	ret

000000008000e3fc <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    8000e3fc:	ff010113          	addi	sp,sp,-16
    8000e400:	00113423          	sd	ra,8(sp)
    8000e404:	00813023          	sd	s0,0(sp)
    8000e408:	01010413          	addi	s0,sp,16
    8000e40c:	00002797          	auipc	a5,0x2
    8000e410:	e9478793          	addi	a5,a5,-364 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e414:	00f53023          	sd	a5,0(a0)
    8000e418:	00001097          	auipc	ra,0x1
    8000e41c:	ba8080e7          	jalr	-1112(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e420:	00813083          	ld	ra,8(sp)
    8000e424:	00013403          	ld	s0,0(sp)
    8000e428:	01010113          	addi	sp,sp,16
    8000e42c:	00008067          	ret

000000008000e430 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    8000e430:	fe010113          	addi	sp,sp,-32
    8000e434:	00113c23          	sd	ra,24(sp)
    8000e438:	00813823          	sd	s0,16(sp)
    8000e43c:	00913423          	sd	s1,8(sp)
    8000e440:	02010413          	addi	s0,sp,32
    8000e444:	00050493          	mv	s1,a0
    8000e448:	00002797          	auipc	a5,0x2
    8000e44c:	e5878793          	addi	a5,a5,-424 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e450:	00f53023          	sd	a5,0(a0)
    8000e454:	00001097          	auipc	ra,0x1
    8000e458:	b6c080e7          	jalr	-1172(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e45c:	00048513          	mv	a0,s1
    8000e460:	00001097          	auipc	ra,0x1
    8000e464:	bf0080e7          	jalr	-1040(ra) # 8000f050 <_ZdlPv>
    8000e468:	01813083          	ld	ra,24(sp)
    8000e46c:	01013403          	ld	s0,16(sp)
    8000e470:	00813483          	ld	s1,8(sp)
    8000e474:	02010113          	addi	sp,sp,32
    8000e478:	00008067          	ret

000000008000e47c <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    8000e47c:	ff010113          	addi	sp,sp,-16
    8000e480:	00113423          	sd	ra,8(sp)
    8000e484:	00813023          	sd	s0,0(sp)
    8000e488:	01010413          	addi	s0,sp,16
    8000e48c:	00002797          	auipc	a5,0x2
    8000e490:	dc478793          	addi	a5,a5,-572 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e494:	00f53023          	sd	a5,0(a0)
    8000e498:	00001097          	auipc	ra,0x1
    8000e49c:	b28080e7          	jalr	-1240(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e4a0:	00813083          	ld	ra,8(sp)
    8000e4a4:	00013403          	ld	s0,0(sp)
    8000e4a8:	01010113          	addi	sp,sp,16
    8000e4ac:	00008067          	ret

000000008000e4b0 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    8000e4b0:	fe010113          	addi	sp,sp,-32
    8000e4b4:	00113c23          	sd	ra,24(sp)
    8000e4b8:	00813823          	sd	s0,16(sp)
    8000e4bc:	00913423          	sd	s1,8(sp)
    8000e4c0:	02010413          	addi	s0,sp,32
    8000e4c4:	00050493          	mv	s1,a0
    8000e4c8:	00002797          	auipc	a5,0x2
    8000e4cc:	d8878793          	addi	a5,a5,-632 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e4d0:	00f53023          	sd	a5,0(a0)
    8000e4d4:	00001097          	auipc	ra,0x1
    8000e4d8:	aec080e7          	jalr	-1300(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e4dc:	00048513          	mv	a0,s1
    8000e4e0:	00001097          	auipc	ra,0x1
    8000e4e4:	b70080e7          	jalr	-1168(ra) # 8000f050 <_ZdlPv>
    8000e4e8:	01813083          	ld	ra,24(sp)
    8000e4ec:	01013403          	ld	s0,16(sp)
    8000e4f0:	00813483          	ld	s1,8(sp)
    8000e4f4:	02010113          	addi	sp,sp,32
    8000e4f8:	00008067          	ret

000000008000e4fc <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    8000e4fc:	ff010113          	addi	sp,sp,-16
    8000e500:	00113423          	sd	ra,8(sp)
    8000e504:	00813023          	sd	s0,0(sp)
    8000e508:	01010413          	addi	s0,sp,16
    8000e50c:	00002797          	auipc	a5,0x2
    8000e510:	d6c78793          	addi	a5,a5,-660 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e514:	00f53023          	sd	a5,0(a0)
    8000e518:	00001097          	auipc	ra,0x1
    8000e51c:	aa8080e7          	jalr	-1368(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e520:	00813083          	ld	ra,8(sp)
    8000e524:	00013403          	ld	s0,0(sp)
    8000e528:	01010113          	addi	sp,sp,16
    8000e52c:	00008067          	ret

000000008000e530 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    8000e530:	fe010113          	addi	sp,sp,-32
    8000e534:	00113c23          	sd	ra,24(sp)
    8000e538:	00813823          	sd	s0,16(sp)
    8000e53c:	00913423          	sd	s1,8(sp)
    8000e540:	02010413          	addi	s0,sp,32
    8000e544:	00050493          	mv	s1,a0
    8000e548:	00002797          	auipc	a5,0x2
    8000e54c:	d3078793          	addi	a5,a5,-720 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e550:	00f53023          	sd	a5,0(a0)
    8000e554:	00001097          	auipc	ra,0x1
    8000e558:	a6c080e7          	jalr	-1428(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e55c:	00048513          	mv	a0,s1
    8000e560:	00001097          	auipc	ra,0x1
    8000e564:	af0080e7          	jalr	-1296(ra) # 8000f050 <_ZdlPv>
    8000e568:	01813083          	ld	ra,24(sp)
    8000e56c:	01013403          	ld	s0,16(sp)
    8000e570:	00813483          	ld	s1,8(sp)
    8000e574:	02010113          	addi	sp,sp,32
    8000e578:	00008067          	ret

000000008000e57c <_ZN10ForkThreadD1Ev>:
    8000e57c:	ff010113          	addi	sp,sp,-16
    8000e580:	00113423          	sd	ra,8(sp)
    8000e584:	00813023          	sd	s0,0(sp)
    8000e588:	01010413          	addi	s0,sp,16
    8000e58c:	00002797          	auipc	a5,0x2
    8000e590:	d3c78793          	addi	a5,a5,-708 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e594:	00f53023          	sd	a5,0(a0)
    8000e598:	00001097          	auipc	ra,0x1
    8000e59c:	a28080e7          	jalr	-1496(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e5a0:	00813083          	ld	ra,8(sp)
    8000e5a4:	00013403          	ld	s0,0(sp)
    8000e5a8:	01010113          	addi	sp,sp,16
    8000e5ac:	00008067          	ret

000000008000e5b0 <_ZN10ForkThreadD0Ev>:
    8000e5b0:	fe010113          	addi	sp,sp,-32
    8000e5b4:	00113c23          	sd	ra,24(sp)
    8000e5b8:	00813823          	sd	s0,16(sp)
    8000e5bc:	00913423          	sd	s1,8(sp)
    8000e5c0:	02010413          	addi	s0,sp,32
    8000e5c4:	00050493          	mv	s1,a0
    8000e5c8:	00002797          	auipc	a5,0x2
    8000e5cc:	d0078793          	addi	a5,a5,-768 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e5d0:	00f53023          	sd	a5,0(a0)
    8000e5d4:	00001097          	auipc	ra,0x1
    8000e5d8:	9ec080e7          	jalr	-1556(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000e5dc:	00048513          	mv	a0,s1
    8000e5e0:	00001097          	auipc	ra,0x1
    8000e5e4:	a70080e7          	jalr	-1424(ra) # 8000f050 <_ZdlPv>
    8000e5e8:	01813083          	ld	ra,24(sp)
    8000e5ec:	01013403          	ld	s0,16(sp)
    8000e5f0:	00813483          	ld	s1,8(sp)
    8000e5f4:	02010113          	addi	sp,sp,32
    8000e5f8:	00008067          	ret

000000008000e5fc <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    8000e5fc:	fe010113          	addi	sp,sp,-32
    8000e600:	00113c23          	sd	ra,24(sp)
    8000e604:	00813823          	sd	s0,16(sp)
    8000e608:	00913423          	sd	s1,8(sp)
    8000e60c:	02010413          	addi	s0,sp,32
    8000e610:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    8000e614:	fffff097          	auipc	ra,0xfffff
    8000e618:	cf0080e7          	jalr	-784(ra) # 8000d304 <_Z4getcv>
    8000e61c:	0005059b          	sext.w	a1,a0
    8000e620:	01b00793          	li	a5,27
    8000e624:	00f58c63          	beq	a1,a5,8000e63c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    8000e628:	0104b783          	ld	a5,16(s1)
    8000e62c:	0087b503          	ld	a0,8(a5)
    8000e630:	fffff097          	auipc	ra,0xfffff
    8000e634:	f20080e7          	jalr	-224(ra) # 8000d550 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    8000e638:	fddff06f          	j	8000e614 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    8000e63c:	00100793          	li	a5,1
    8000e640:	00002717          	auipc	a4,0x2
    8000e644:	d2f72a23          	sw	a5,-716(a4) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    8000e648:	0104b783          	ld	a5,16(s1)
    8000e64c:	02100593          	li	a1,33
    8000e650:	0087b503          	ld	a0,8(a5)
    8000e654:	fffff097          	auipc	ra,0xfffff
    8000e658:	efc080e7          	jalr	-260(ra) # 8000d550 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    8000e65c:	0104b783          	ld	a5,16(s1)
    8000e660:	0107b503          	ld	a0,16(a5)
    8000e664:	00001097          	auipc	ra,0x1
    8000e668:	af8080e7          	jalr	-1288(ra) # 8000f15c <_ZN9Semaphore6signalEv>
        }
    8000e66c:	01813083          	ld	ra,24(sp)
    8000e670:	01013403          	ld	s0,16(sp)
    8000e674:	00813483          	ld	s1,8(sp)
    8000e678:	02010113          	addi	sp,sp,32
    8000e67c:	00008067          	ret

000000008000e680 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    8000e680:	fe010113          	addi	sp,sp,-32
    8000e684:	00113c23          	sd	ra,24(sp)
    8000e688:	00813823          	sd	s0,16(sp)
    8000e68c:	00913423          	sd	s1,8(sp)
    8000e690:	01213023          	sd	s2,0(sp)
    8000e694:	02010413          	addi	s0,sp,32
    8000e698:	00050493          	mv	s1,a0
            int i = 0;
    8000e69c:	00000913          	li	s2,0
            while (!threadEnd) {
    8000e6a0:	00002797          	auipc	a5,0x2
    8000e6a4:	cd47a783          	lw	a5,-812(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e6a8:	04079263          	bnez	a5,8000e6ec <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8000e6ac:	0104b783          	ld	a5,16(s1)
    8000e6b0:	0007a583          	lw	a1,0(a5)
    8000e6b4:	0305859b          	addiw	a1,a1,48
    8000e6b8:	0087b503          	ld	a0,8(a5)
    8000e6bc:	fffff097          	auipc	ra,0xfffff
    8000e6c0:	e94080e7          	jalr	-364(ra) # 8000d550 <_ZN9BufferCPP3putEi>
                i++;
    8000e6c4:	0019071b          	addiw	a4,s2,1
    8000e6c8:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    8000e6cc:	0104b783          	ld	a5,16(s1)
    8000e6d0:	0007a783          	lw	a5,0(a5)
    8000e6d4:	00e787bb          	addw	a5,a5,a4
    8000e6d8:	00500513          	li	a0,5
    8000e6dc:	02a7e53b          	remw	a0,a5,a0
    8000e6e0:	00001097          	auipc	ra,0x1
    8000e6e4:	b5c080e7          	jalr	-1188(ra) # 8000f23c <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    8000e6e8:	fb9ff06f          	j	8000e6a0 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    8000e6ec:	0104b783          	ld	a5,16(s1)
    8000e6f0:	0107b503          	ld	a0,16(a5)
    8000e6f4:	00001097          	auipc	ra,0x1
    8000e6f8:	a68080e7          	jalr	-1432(ra) # 8000f15c <_ZN9Semaphore6signalEv>
        }
    8000e6fc:	01813083          	ld	ra,24(sp)
    8000e700:	01013403          	ld	s0,16(sp)
    8000e704:	00813483          	ld	s1,8(sp)
    8000e708:	00013903          	ld	s2,0(sp)
    8000e70c:	02010113          	addi	sp,sp,32
    8000e710:	00008067          	ret

000000008000e714 <_ZN10ForkThread3runEv>:
    virtual void run() {
    8000e714:	fc010113          	addi	sp,sp,-64
    8000e718:	02113c23          	sd	ra,56(sp)
    8000e71c:	02813823          	sd	s0,48(sp)
    8000e720:	02913423          	sd	s1,40(sp)
    8000e724:	03213023          	sd	s2,32(sp)
    8000e728:	01313c23          	sd	s3,24(sp)
    8000e72c:	01413823          	sd	s4,16(sp)
    8000e730:	01513423          	sd	s5,8(sp)
    8000e734:	01613023          	sd	s6,0(sp)
    8000e738:	04010413          	addi	s0,sp,64
    8000e73c:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    8000e740:	00002517          	auipc	a0,0x2
    8000e744:	ad050513          	addi	a0,a0,-1328 # 80010210 <userDataStart+0x210>
    8000e748:	00000097          	auipc	ra,0x0
    8000e74c:	50c080e7          	jalr	1292(ra) # 8000ec54 <_Z11printStringPKc>
        printInt(id,10);
    8000e750:	00000613          	li	a2,0
    8000e754:	00a00593          	li	a1,10
    8000e758:	010a2503          	lw	a0,16(s4)
    8000e75c:	00000097          	auipc	ra,0x0
    8000e760:	690080e7          	jalr	1680(ra) # 8000edec <_Z8printIntiii>
        printString("\n");
    8000e764:	00002517          	auipc	a0,0x2
    8000e768:	9e450513          	addi	a0,a0,-1564 # 80010148 <userDataStart+0x148>
    8000e76c:	00000097          	auipc	ra,0x0
    8000e770:	4e8080e7          	jalr	1256(ra) # 8000ec54 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    8000e774:	02000513          	li	a0,32
    8000e778:	00001097          	auipc	ra,0x1
    8000e77c:	888080e7          	jalr	-1912(ra) # 8000f000 <_Znwm>
    8000e780:	00050993          	mv	s3,a0
    8000e784:	02050463          	beqz	a0,8000e7ac <_ZN10ForkThread3runEv+0x98>
    8000e788:	010a3483          	ld	s1,16(s4)
    8000e78c:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e790:	00001097          	auipc	ra,0x1
    8000e794:	a4c080e7          	jalr	-1460(ra) # 8000f1dc <_ZN6ThreadC1Ev>
    8000e798:	00002797          	auipc	a5,0x2
    8000e79c:	b3078793          	addi	a5,a5,-1232 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e7a0:	00f9b023          	sd	a5,0(s3)
    8000e7a4:	0099b823          	sd	s1,16(s3)
    8000e7a8:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    8000e7ac:	010a3503          	ld	a0,16(s4)
    8000e7b0:	00351513          	slli	a0,a0,0x3
    8000e7b4:	fffff097          	auipc	ra,0xfffff
    8000e7b8:	86c080e7          	jalr	-1940(ra) # 8000d020 <_Z9mem_allocm>
    8000e7bc:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    8000e7c0:	10050863          	beqz	a0,8000e8d0 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    8000e7c4:	00000913          	li	s2,0
    8000e7c8:	0140006f          	j	8000e7dc <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    8000e7cc:	00391793          	slli	a5,s2,0x3
    8000e7d0:	00fa87b3          	add	a5,s5,a5
    8000e7d4:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    8000e7d8:	00190913          	addi	s2,s2,1
    8000e7dc:	010a3783          	ld	a5,16(s4)
    8000e7e0:	02f95e63          	bge	s2,a5,8000e81c <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    8000e7e4:	02000513          	li	a0,32
    8000e7e8:	00001097          	auipc	ra,0x1
    8000e7ec:	818080e7          	jalr	-2024(ra) # 8000f000 <_Znwm>
    8000e7f0:	00050493          	mv	s1,a0
    8000e7f4:	fc050ce3          	beqz	a0,8000e7cc <_ZN10ForkThread3runEv+0xb8>
    8000e7f8:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e7fc:	00001097          	auipc	ra,0x1
    8000e800:	9e0080e7          	jalr	-1568(ra) # 8000f1dc <_ZN6ThreadC1Ev>
    8000e804:	00002797          	auipc	a5,0x2
    8000e808:	ac478793          	addi	a5,a5,-1340 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e80c:	00f4b023          	sd	a5,0(s1)
    8000e810:	0164b823          	sd	s6,16(s1)
    8000e814:	00048c23          	sb	zero,24(s1)
    8000e818:	fb5ff06f          	j	8000e7cc <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    8000e81c:	06098a63          	beqz	s3,8000e890 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    8000e820:	00098513          	mv	a0,s3
    8000e824:	00001097          	auipc	ra,0x1
    8000e828:	aa8080e7          	jalr	-1368(ra) # 8000f2cc <_ZN6Thread5startEv>
    8000e82c:	00050913          	mv	s2,a0
    8000e830:	04051863          	bnez	a0,8000e880 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    8000e834:	00050493          	mv	s1,a0
    8000e838:	0100006f          	j	8000e848 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    8000e83c:	fffff097          	auipc	ra,0xfffff
    8000e840:	8f4080e7          	jalr	-1804(ra) # 8000d130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    8000e844:	0014849b          	addiw	s1,s1,1
    8000e848:	000017b7          	lui	a5,0x1
    8000e84c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e850:	0097ce63          	blt	a5,s1,8000e86c <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    8000e854:	00090713          	mv	a4,s2
    8000e858:	000017b7          	lui	a5,0x1
    8000e85c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e860:	fce7cee3          	blt	a5,a4,8000e83c <_ZN10ForkThread3runEv+0x128>
    8000e864:	0017071b          	addiw	a4,a4,1
    8000e868:	ff1ff06f          	j	8000e858 <_ZN10ForkThread3runEv+0x144>
        return finished;
    8000e86c:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    8000e870:	00079863          	bnez	a5,8000e880 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    8000e874:	fffff097          	auipc	ra,0xfffff
    8000e878:	8bc080e7          	jalr	-1860(ra) # 8000d130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8000e87c:	ff1ff06f          	j	8000e86c <_ZN10ForkThread3runEv+0x158>
                delete thread;
    8000e880:	0009b783          	ld	a5,0(s3)
    8000e884:	0087b783          	ld	a5,8(a5)
    8000e888:	00098513          	mv	a0,s3
    8000e88c:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    8000e890:	00000493          	li	s1,0
    8000e894:	0080006f          	j	8000e89c <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    8000e898:	00148493          	addi	s1,s1,1
    8000e89c:	010a3783          	ld	a5,16(s4)
    8000e8a0:	02f4d263          	bge	s1,a5,8000e8c4 <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    8000e8a4:	00349793          	slli	a5,s1,0x3
    8000e8a8:	00fa87b3          	add	a5,s5,a5
    8000e8ac:	0007b503          	ld	a0,0(a5)
    8000e8b0:	fe0504e3          	beqz	a0,8000e898 <_ZN10ForkThread3runEv+0x184>
    8000e8b4:	00053783          	ld	a5,0(a0)
    8000e8b8:	0087b783          	ld	a5,8(a5)
    8000e8bc:	000780e7          	jalr	a5
    8000e8c0:	fd9ff06f          	j	8000e898 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    8000e8c4:	000a8513          	mv	a0,s5
    8000e8c8:	ffffe097          	auipc	ra,0xffffe
    8000e8cc:	788080e7          	jalr	1928(ra) # 8000d050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    8000e8d0:	00002517          	auipc	a0,0x2
    8000e8d4:	95850513          	addi	a0,a0,-1704 # 80010228 <userDataStart+0x228>
    8000e8d8:	00000097          	auipc	ra,0x0
    8000e8dc:	37c080e7          	jalr	892(ra) # 8000ec54 <_Z11printStringPKc>
        printInt(id,10);
    8000e8e0:	00000613          	li	a2,0
    8000e8e4:	00a00593          	li	a1,10
    8000e8e8:	010a2503          	lw	a0,16(s4)
    8000e8ec:	00000097          	auipc	ra,0x0
    8000e8f0:	500080e7          	jalr	1280(ra) # 8000edec <_Z8printIntiii>
        printString("\n");
    8000e8f4:	00002517          	auipc	a0,0x2
    8000e8f8:	85450513          	addi	a0,a0,-1964 # 80010148 <userDataStart+0x148>
    8000e8fc:	00000097          	auipc	ra,0x0
    8000e900:	358080e7          	jalr	856(ra) # 8000ec54 <_Z11printStringPKc>
        finished = true;
    8000e904:	00100793          	li	a5,1
    8000e908:	00fa0c23          	sb	a5,24(s4)
    }
    8000e90c:	03813083          	ld	ra,56(sp)
    8000e910:	03013403          	ld	s0,48(sp)
    8000e914:	02813483          	ld	s1,40(sp)
    8000e918:	02013903          	ld	s2,32(sp)
    8000e91c:	01813983          	ld	s3,24(sp)
    8000e920:	01013a03          	ld	s4,16(sp)
    8000e924:	00813a83          	ld	s5,8(sp)
    8000e928:	00013b03          	ld	s6,0(sp)
    8000e92c:	04010113          	addi	sp,sp,64
    8000e930:	00008067          	ret

000000008000e934 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000e934:	fe010113          	addi	sp,sp,-32
    8000e938:	00113c23          	sd	ra,24(sp)
    8000e93c:	00813823          	sd	s0,16(sp)
    8000e940:	00913423          	sd	s1,8(sp)
    8000e944:	01213023          	sd	s2,0(sp)
    8000e948:	02010413          	addi	s0,sp,32
    8000e94c:	00050493          	mv	s1,a0
    8000e950:	00058913          	mv	s2,a1
    8000e954:	0015879b          	addiw	a5,a1,1
    8000e958:	0007851b          	sext.w	a0,a5
    8000e95c:	00f4a023          	sw	a5,0(s1)
    8000e960:	0004a823          	sw	zero,16(s1)
    8000e964:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000e968:	00251513          	slli	a0,a0,0x2
    8000e96c:	ffffe097          	auipc	ra,0xffffe
    8000e970:	6b4080e7          	jalr	1716(ra) # 8000d020 <_Z9mem_allocm>
    8000e974:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000e978:	00000593          	li	a1,0
    8000e97c:	02048513          	addi	a0,s1,32
    8000e980:	fffff097          	auipc	ra,0xfffff
    8000e984:	89c080e7          	jalr	-1892(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    8000e988:	00090593          	mv	a1,s2
    8000e98c:	01848513          	addi	a0,s1,24
    8000e990:	fffff097          	auipc	ra,0xfffff
    8000e994:	88c080e7          	jalr	-1908(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    8000e998:	00100593          	li	a1,1
    8000e99c:	02848513          	addi	a0,s1,40
    8000e9a0:	fffff097          	auipc	ra,0xfffff
    8000e9a4:	87c080e7          	jalr	-1924(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    8000e9a8:	00100593          	li	a1,1
    8000e9ac:	03048513          	addi	a0,s1,48
    8000e9b0:	fffff097          	auipc	ra,0xfffff
    8000e9b4:	86c080e7          	jalr	-1940(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000e9b8:	01813083          	ld	ra,24(sp)
    8000e9bc:	01013403          	ld	s0,16(sp)
    8000e9c0:	00813483          	ld	s1,8(sp)
    8000e9c4:	00013903          	ld	s2,0(sp)
    8000e9c8:	02010113          	addi	sp,sp,32
    8000e9cc:	00008067          	ret

000000008000e9d0 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000e9d0:	fe010113          	addi	sp,sp,-32
    8000e9d4:	00113c23          	sd	ra,24(sp)
    8000e9d8:	00813823          	sd	s0,16(sp)
    8000e9dc:	00913423          	sd	s1,8(sp)
    8000e9e0:	01213023          	sd	s2,0(sp)
    8000e9e4:	02010413          	addi	s0,sp,32
    8000e9e8:	00050493          	mv	s1,a0
    8000e9ec:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000e9f0:	01853503          	ld	a0,24(a0)
    8000e9f4:	fffff097          	auipc	ra,0xfffff
    8000e9f8:	88c080e7          	jalr	-1908(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    8000e9fc:	0304b503          	ld	a0,48(s1)
    8000ea00:	fffff097          	auipc	ra,0xfffff
    8000ea04:	880080e7          	jalr	-1920(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    8000ea08:	0084b783          	ld	a5,8(s1)
    8000ea0c:	0144a703          	lw	a4,20(s1)
    8000ea10:	00271713          	slli	a4,a4,0x2
    8000ea14:	00e787b3          	add	a5,a5,a4
    8000ea18:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000ea1c:	0144a783          	lw	a5,20(s1)
    8000ea20:	0017879b          	addiw	a5,a5,1
    8000ea24:	0004a703          	lw	a4,0(s1)
    8000ea28:	02e7e7bb          	remw	a5,a5,a4
    8000ea2c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    8000ea30:	0304b503          	ld	a0,48(s1)
    8000ea34:	fffff097          	auipc	ra,0xfffff
    8000ea38:	878080e7          	jalr	-1928(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    8000ea3c:	0204b503          	ld	a0,32(s1)
    8000ea40:	fffff097          	auipc	ra,0xfffff
    8000ea44:	86c080e7          	jalr	-1940(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

}
    8000ea48:	01813083          	ld	ra,24(sp)
    8000ea4c:	01013403          	ld	s0,16(sp)
    8000ea50:	00813483          	ld	s1,8(sp)
    8000ea54:	00013903          	ld	s2,0(sp)
    8000ea58:	02010113          	addi	sp,sp,32
    8000ea5c:	00008067          	ret

000000008000ea60 <_ZN6Buffer3getEv>:

int Buffer::get() {
    8000ea60:	fe010113          	addi	sp,sp,-32
    8000ea64:	00113c23          	sd	ra,24(sp)
    8000ea68:	00813823          	sd	s0,16(sp)
    8000ea6c:	00913423          	sd	s1,8(sp)
    8000ea70:	01213023          	sd	s2,0(sp)
    8000ea74:	02010413          	addi	s0,sp,32
    8000ea78:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8000ea7c:	02053503          	ld	a0,32(a0)
    8000ea80:	fffff097          	auipc	ra,0xfffff
    8000ea84:	800080e7          	jalr	-2048(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    8000ea88:	0284b503          	ld	a0,40(s1)
    8000ea8c:	ffffe097          	auipc	ra,0xffffe
    8000ea90:	7f4080e7          	jalr	2036(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8000ea94:	0084b703          	ld	a4,8(s1)
    8000ea98:	0104a783          	lw	a5,16(s1)
    8000ea9c:	00279693          	slli	a3,a5,0x2
    8000eaa0:	00d70733          	add	a4,a4,a3
    8000eaa4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000eaa8:	0017879b          	addiw	a5,a5,1
    8000eaac:	0004a703          	lw	a4,0(s1)
    8000eab0:	02e7e7bb          	remw	a5,a5,a4
    8000eab4:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000eab8:	0284b503          	ld	a0,40(s1)
    8000eabc:	ffffe097          	auipc	ra,0xffffe
    8000eac0:	7f0080e7          	jalr	2032(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    8000eac4:	0184b503          	ld	a0,24(s1)
    8000eac8:	ffffe097          	auipc	ra,0xffffe
    8000eacc:	7e4080e7          	jalr	2020(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000ead0:	00090513          	mv	a0,s2
    8000ead4:	01813083          	ld	ra,24(sp)
    8000ead8:	01013403          	ld	s0,16(sp)
    8000eadc:	00813483          	ld	s1,8(sp)
    8000eae0:	00013903          	ld	s2,0(sp)
    8000eae4:	02010113          	addi	sp,sp,32
    8000eae8:	00008067          	ret

000000008000eaec <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000eaec:	fe010113          	addi	sp,sp,-32
    8000eaf0:	00113c23          	sd	ra,24(sp)
    8000eaf4:	00813823          	sd	s0,16(sp)
    8000eaf8:	00913423          	sd	s1,8(sp)
    8000eafc:	01213023          	sd	s2,0(sp)
    8000eb00:	02010413          	addi	s0,sp,32
    8000eb04:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    8000eb08:	02853503          	ld	a0,40(a0)
    8000eb0c:	ffffe097          	auipc	ra,0xffffe
    8000eb10:	774080e7          	jalr	1908(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    8000eb14:	0304b503          	ld	a0,48(s1)
    8000eb18:	ffffe097          	auipc	ra,0xffffe
    8000eb1c:	768080e7          	jalr	1896(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    8000eb20:	0144a783          	lw	a5,20(s1)
    8000eb24:	0104a903          	lw	s2,16(s1)
    8000eb28:	0327ce63          	blt	a5,s2,8000eb64 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000eb2c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    8000eb30:	0304b503          	ld	a0,48(s1)
    8000eb34:	ffffe097          	auipc	ra,0xffffe
    8000eb38:	778080e7          	jalr	1912(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8000eb3c:	0284b503          	ld	a0,40(s1)
    8000eb40:	ffffe097          	auipc	ra,0xffffe
    8000eb44:	76c080e7          	jalr	1900(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000eb48:	00090513          	mv	a0,s2
    8000eb4c:	01813083          	ld	ra,24(sp)
    8000eb50:	01013403          	ld	s0,16(sp)
    8000eb54:	00813483          	ld	s1,8(sp)
    8000eb58:	00013903          	ld	s2,0(sp)
    8000eb5c:	02010113          	addi	sp,sp,32
    8000eb60:	00008067          	ret
        ret = cap - head + tail;
    8000eb64:	0004a703          	lw	a4,0(s1)
    8000eb68:	4127093b          	subw	s2,a4,s2
    8000eb6c:	00f9093b          	addw	s2,s2,a5
    8000eb70:	fc1ff06f          	j	8000eb30 <_ZN6Buffer6getCntEv+0x44>

000000008000eb74 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000eb74:	fe010113          	addi	sp,sp,-32
    8000eb78:	00113c23          	sd	ra,24(sp)
    8000eb7c:	00813823          	sd	s0,16(sp)
    8000eb80:	00913423          	sd	s1,8(sp)
    8000eb84:	02010413          	addi	s0,sp,32
    8000eb88:	00050493          	mv	s1,a0
    putc('\n');
    8000eb8c:	00a00513          	li	a0,10
    8000eb90:	ffffe097          	auipc	ra,0xffffe
    8000eb94:	79c080e7          	jalr	1948(ra) # 8000d32c <_Z4putcc>
    printString("Buffer deleted!\n");
    8000eb98:	00001517          	auipc	a0,0x1
    8000eb9c:	46850513          	addi	a0,a0,1128 # 80010000 <userDataStart>
    8000eba0:	00000097          	auipc	ra,0x0
    8000eba4:	0b4080e7          	jalr	180(ra) # 8000ec54 <_Z11printStringPKc>
    while (getCnt() > 0) {
    8000eba8:	00048513          	mv	a0,s1
    8000ebac:	00000097          	auipc	ra,0x0
    8000ebb0:	f40080e7          	jalr	-192(ra) # 8000eaec <_ZN6Buffer6getCntEv>
    8000ebb4:	02a05c63          	blez	a0,8000ebec <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    8000ebb8:	0084b783          	ld	a5,8(s1)
    8000ebbc:	0104a703          	lw	a4,16(s1)
    8000ebc0:	00271713          	slli	a4,a4,0x2
    8000ebc4:	00e787b3          	add	a5,a5,a4
        putc(ch);
    8000ebc8:	0007c503          	lbu	a0,0(a5)
    8000ebcc:	ffffe097          	auipc	ra,0xffffe
    8000ebd0:	760080e7          	jalr	1888(ra) # 8000d32c <_Z4putcc>
        head = (head + 1) % cap;
    8000ebd4:	0104a783          	lw	a5,16(s1)
    8000ebd8:	0017879b          	addiw	a5,a5,1
    8000ebdc:	0004a703          	lw	a4,0(s1)
    8000ebe0:	02e7e7bb          	remw	a5,a5,a4
    8000ebe4:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    8000ebe8:	fc1ff06f          	j	8000eba8 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000ebec:	02100513          	li	a0,33
    8000ebf0:	ffffe097          	auipc	ra,0xffffe
    8000ebf4:	73c080e7          	jalr	1852(ra) # 8000d32c <_Z4putcc>
    putc('\n');
    8000ebf8:	00a00513          	li	a0,10
    8000ebfc:	ffffe097          	auipc	ra,0xffffe
    8000ec00:	730080e7          	jalr	1840(ra) # 8000d32c <_Z4putcc>
    mem_free(buffer);
    8000ec04:	0084b503          	ld	a0,8(s1)
    8000ec08:	ffffe097          	auipc	ra,0xffffe
    8000ec0c:	448080e7          	jalr	1096(ra) # 8000d050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    8000ec10:	0204b503          	ld	a0,32(s1)
    8000ec14:	ffffe097          	auipc	ra,0xffffe
    8000ec18:	640080e7          	jalr	1600(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    8000ec1c:	0184b503          	ld	a0,24(s1)
    8000ec20:	ffffe097          	auipc	ra,0xffffe
    8000ec24:	634080e7          	jalr	1588(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    8000ec28:	0304b503          	ld	a0,48(s1)
    8000ec2c:	ffffe097          	auipc	ra,0xffffe
    8000ec30:	628080e7          	jalr	1576(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    8000ec34:	0284b503          	ld	a0,40(s1)
    8000ec38:	ffffe097          	auipc	ra,0xffffe
    8000ec3c:	61c080e7          	jalr	1564(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
}
    8000ec40:	01813083          	ld	ra,24(sp)
    8000ec44:	01013403          	ld	s0,16(sp)
    8000ec48:	00813483          	ld	s1,8(sp)
    8000ec4c:	02010113          	addi	sp,sp,32
    8000ec50:	00008067          	ret

000000008000ec54 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000ec54:	fe010113          	addi	sp,sp,-32
    8000ec58:	00113c23          	sd	ra,24(sp)
    8000ec5c:	00813823          	sd	s0,16(sp)
    8000ec60:	00913423          	sd	s1,8(sp)
    8000ec64:	02010413          	addi	s0,sp,32
    8000ec68:	00050493          	mv	s1,a0
    LOCK();
    8000ec6c:	00100613          	li	a2,1
    8000ec70:	00000593          	li	a1,0
    8000ec74:	00001517          	auipc	a0,0x1
    8000ec78:	71450513          	addi	a0,a0,1812 # 80010388 <lockPrint>
    8000ec7c:	ffffe097          	auipc	ra,0xffffe
    8000ec80:	384080e7          	jalr	900(ra) # 8000d000 <copy_and_swap>
    8000ec84:	fe0514e3          	bnez	a0,8000ec6c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000ec88:	0004c503          	lbu	a0,0(s1)
    8000ec8c:	00050a63          	beqz	a0,8000eca0 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000ec90:	ffffe097          	auipc	ra,0xffffe
    8000ec94:	69c080e7          	jalr	1692(ra) # 8000d32c <_Z4putcc>
        string++;
    8000ec98:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000ec9c:	fedff06f          	j	8000ec88 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000eca0:	00000613          	li	a2,0
    8000eca4:	00100593          	li	a1,1
    8000eca8:	00001517          	auipc	a0,0x1
    8000ecac:	6e050513          	addi	a0,a0,1760 # 80010388 <lockPrint>
    8000ecb0:	ffffe097          	auipc	ra,0xffffe
    8000ecb4:	350080e7          	jalr	848(ra) # 8000d000 <copy_and_swap>
    8000ecb8:	fe0514e3          	bnez	a0,8000eca0 <_Z11printStringPKc+0x4c>
}
    8000ecbc:	01813083          	ld	ra,24(sp)
    8000ecc0:	01013403          	ld	s0,16(sp)
    8000ecc4:	00813483          	ld	s1,8(sp)
    8000ecc8:	02010113          	addi	sp,sp,32
    8000eccc:	00008067          	ret

000000008000ecd0 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    8000ecd0:	fd010113          	addi	sp,sp,-48
    8000ecd4:	02113423          	sd	ra,40(sp)
    8000ecd8:	02813023          	sd	s0,32(sp)
    8000ecdc:	00913c23          	sd	s1,24(sp)
    8000ece0:	01213823          	sd	s2,16(sp)
    8000ece4:	01313423          	sd	s3,8(sp)
    8000ece8:	01413023          	sd	s4,0(sp)
    8000ecec:	03010413          	addi	s0,sp,48
    8000ecf0:	00050993          	mv	s3,a0
    8000ecf4:	00058a13          	mv	s4,a1
    LOCK();
    8000ecf8:	00100613          	li	a2,1
    8000ecfc:	00000593          	li	a1,0
    8000ed00:	00001517          	auipc	a0,0x1
    8000ed04:	68850513          	addi	a0,a0,1672 # 80010388 <lockPrint>
    8000ed08:	ffffe097          	auipc	ra,0xffffe
    8000ed0c:	2f8080e7          	jalr	760(ra) # 8000d000 <copy_and_swap>
    8000ed10:	fe0514e3          	bnez	a0,8000ecf8 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000ed14:	00000913          	li	s2,0
    8000ed18:	00090493          	mv	s1,s2
    8000ed1c:	0019091b          	addiw	s2,s2,1
    8000ed20:	03495a63          	bge	s2,s4,8000ed54 <_Z9getStringPci+0x84>
        cc = getc();
    8000ed24:	ffffe097          	auipc	ra,0xffffe
    8000ed28:	5e0080e7          	jalr	1504(ra) # 8000d304 <_Z4getcv>
        if(cc < 1)
    8000ed2c:	02050463          	beqz	a0,8000ed54 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000ed30:	009984b3          	add	s1,s3,s1
    8000ed34:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000ed38:	00a00793          	li	a5,10
    8000ed3c:	00f50a63          	beq	a0,a5,8000ed50 <_Z9getStringPci+0x80>
    8000ed40:	00d00793          	li	a5,13
    8000ed44:	fcf51ae3          	bne	a0,a5,8000ed18 <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000ed48:	00090493          	mv	s1,s2
    8000ed4c:	0080006f          	j	8000ed54 <_Z9getStringPci+0x84>
    8000ed50:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    8000ed54:	009984b3          	add	s1,s3,s1
    8000ed58:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000ed5c:	00000613          	li	a2,0
    8000ed60:	00100593          	li	a1,1
    8000ed64:	00001517          	auipc	a0,0x1
    8000ed68:	62450513          	addi	a0,a0,1572 # 80010388 <lockPrint>
    8000ed6c:	ffffe097          	auipc	ra,0xffffe
    8000ed70:	294080e7          	jalr	660(ra) # 8000d000 <copy_and_swap>
    8000ed74:	fe0514e3          	bnez	a0,8000ed5c <_Z9getStringPci+0x8c>
    return buf;
}
    8000ed78:	00098513          	mv	a0,s3
    8000ed7c:	02813083          	ld	ra,40(sp)
    8000ed80:	02013403          	ld	s0,32(sp)
    8000ed84:	01813483          	ld	s1,24(sp)
    8000ed88:	01013903          	ld	s2,16(sp)
    8000ed8c:	00813983          	ld	s3,8(sp)
    8000ed90:	00013a03          	ld	s4,0(sp)
    8000ed94:	03010113          	addi	sp,sp,48
    8000ed98:	00008067          	ret

000000008000ed9c <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000ed9c:	ff010113          	addi	sp,sp,-16
    8000eda0:	00813423          	sd	s0,8(sp)
    8000eda4:	01010413          	addi	s0,sp,16
    8000eda8:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000edac:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000edb0:	0006c603          	lbu	a2,0(a3)
    8000edb4:	fd06071b          	addiw	a4,a2,-48
    8000edb8:	0ff77713          	andi	a4,a4,255
    8000edbc:	00900793          	li	a5,9
    8000edc0:	02e7e063          	bltu	a5,a4,8000ede0 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000edc4:	0025179b          	slliw	a5,a0,0x2
    8000edc8:	00a787bb          	addw	a5,a5,a0
    8000edcc:	0017979b          	slliw	a5,a5,0x1
    8000edd0:	00168693          	addi	a3,a3,1
    8000edd4:	00c787bb          	addw	a5,a5,a2
    8000edd8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000eddc:	fd5ff06f          	j	8000edb0 <_Z11stringToIntPKc+0x14>
    return n;
}
    8000ede0:	00813403          	ld	s0,8(sp)
    8000ede4:	01010113          	addi	sp,sp,16
    8000ede8:	00008067          	ret

000000008000edec <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000edec:	fc010113          	addi	sp,sp,-64
    8000edf0:	02113c23          	sd	ra,56(sp)
    8000edf4:	02813823          	sd	s0,48(sp)
    8000edf8:	02913423          	sd	s1,40(sp)
    8000edfc:	03213023          	sd	s2,32(sp)
    8000ee00:	01313c23          	sd	s3,24(sp)
    8000ee04:	04010413          	addi	s0,sp,64
    8000ee08:	00050493          	mv	s1,a0
    8000ee0c:	00058913          	mv	s2,a1
    8000ee10:	00060993          	mv	s3,a2
    LOCK();
    8000ee14:	00100613          	li	a2,1
    8000ee18:	00000593          	li	a1,0
    8000ee1c:	00001517          	auipc	a0,0x1
    8000ee20:	56c50513          	addi	a0,a0,1388 # 80010388 <lockPrint>
    8000ee24:	ffffe097          	auipc	ra,0xffffe
    8000ee28:	1dc080e7          	jalr	476(ra) # 8000d000 <copy_and_swap>
    8000ee2c:	fe0514e3          	bnez	a0,8000ee14 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000ee30:	00098463          	beqz	s3,8000ee38 <_Z8printIntiii+0x4c>
    8000ee34:	0804c463          	bltz	s1,8000eebc <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000ee38:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000ee3c:	00000593          	li	a1,0
    }

    i = 0;
    8000ee40:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000ee44:	0009079b          	sext.w	a5,s2
    8000ee48:	0325773b          	remuw	a4,a0,s2
    8000ee4c:	00048613          	mv	a2,s1
    8000ee50:	0014849b          	addiw	s1,s1,1
    8000ee54:	02071693          	slli	a3,a4,0x20
    8000ee58:	0206d693          	srli	a3,a3,0x20
    8000ee5c:	00001717          	auipc	a4,0x1
    8000ee60:	48470713          	addi	a4,a4,1156 # 800102e0 <digits>
    8000ee64:	00d70733          	add	a4,a4,a3
    8000ee68:	00074683          	lbu	a3,0(a4)
    8000ee6c:	fd040713          	addi	a4,s0,-48
    8000ee70:	00c70733          	add	a4,a4,a2
    8000ee74:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    8000ee78:	0005071b          	sext.w	a4,a0
    8000ee7c:	0325553b          	divuw	a0,a0,s2
    8000ee80:	fcf772e3          	bgeu	a4,a5,8000ee44 <_Z8printIntiii+0x58>
    if(neg)
    8000ee84:	00058c63          	beqz	a1,8000ee9c <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    8000ee88:	fd040793          	addi	a5,s0,-48
    8000ee8c:	009784b3          	add	s1,a5,s1
    8000ee90:	02d00793          	li	a5,45
    8000ee94:	fef48823          	sb	a5,-16(s1)
    8000ee98:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000ee9c:	fff4849b          	addiw	s1,s1,-1
    8000eea0:	0204c463          	bltz	s1,8000eec8 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    8000eea4:	fd040793          	addi	a5,s0,-48
    8000eea8:	009787b3          	add	a5,a5,s1
    8000eeac:	ff07c503          	lbu	a0,-16(a5)
    8000eeb0:	ffffe097          	auipc	ra,0xffffe
    8000eeb4:	47c080e7          	jalr	1148(ra) # 8000d32c <_Z4putcc>
    8000eeb8:	fe5ff06f          	j	8000ee9c <_Z8printIntiii+0xb0>
        x = -xx;
    8000eebc:	4090053b          	negw	a0,s1
        neg = 1;
    8000eec0:	00100593          	li	a1,1
        x = -xx;
    8000eec4:	f7dff06f          	j	8000ee40 <_Z8printIntiii+0x54>

    UNLOCK();
    8000eec8:	00000613          	li	a2,0
    8000eecc:	00100593          	li	a1,1
    8000eed0:	00001517          	auipc	a0,0x1
    8000eed4:	4b850513          	addi	a0,a0,1208 # 80010388 <lockPrint>
    8000eed8:	ffffe097          	auipc	ra,0xffffe
    8000eedc:	128080e7          	jalr	296(ra) # 8000d000 <copy_and_swap>
    8000eee0:	fe0514e3          	bnez	a0,8000eec8 <_Z8printIntiii+0xdc>
    8000eee4:	03813083          	ld	ra,56(sp)
    8000eee8:	03013403          	ld	s0,48(sp)
    8000eeec:	02813483          	ld	s1,40(sp)
    8000eef0:	02013903          	ld	s2,32(sp)
    8000eef4:	01813983          	ld	s3,24(sp)
    8000eef8:	04010113          	addi	sp,sp,64
    8000eefc:	00008067          	ret

000000008000ef00 <_Z11bodyWrapperPFvPvES_>:
#include "../../h/user/userWrappers.hpp"
#include "../../h/user/syscall_c.h"
#include "tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    8000ef00:	ff010113          	addi	sp,sp,-16
    8000ef04:	00113423          	sd	ra,8(sp)
    8000ef08:	00813023          	sd	s0,0(sp)
    8000ef0c:	01010413          	addi	s0,sp,16
    8000ef10:	00050793          	mv	a5,a0
    body(args);
    8000ef14:	00058513          	mv	a0,a1
    8000ef18:	000780e7          	jalr	a5
    thread_exit();
    8000ef1c:	ffffe097          	auipc	ra,0xffffe
    8000ef20:	1ec080e7          	jalr	492(ra) # 8000d108 <_Z11thread_exitv>
}
    8000ef24:	00813083          	ld	ra,8(sp)
    8000ef28:	00013403          	ld	s0,0(sp)
    8000ef2c:	01010113          	addi	sp,sp,16
    8000ef30:	00008067          	ret

000000008000ef34 <_Z15userMainWrapperPv>:

void userMainWrapper(void* args) {
    8000ef34:	ff010113          	addi	sp,sp,-16
    8000ef38:	00113423          	sd	ra,8(sp)
    8000ef3c:	00813023          	sd	s0,0(sp)
    8000ef40:	01010413          	addi	s0,sp,16
    userMain();
    8000ef44:	fffff097          	auipc	ra,0xfffff
    8000ef48:	3d0080e7          	jalr	976(ra) # 8000e314 <_Z8userMainv>
    8000ef4c:	00813083          	ld	ra,8(sp)
    8000ef50:	00013403          	ld	s0,0(sp)
    8000ef54:	01010113          	addi	sp,sp,16
    8000ef58:	00008067          	ret

000000008000ef5c <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    8000ef5c:	ff010113          	addi	sp,sp,-16
    8000ef60:	00113423          	sd	ra,8(sp)
    8000ef64:	00813023          	sd	s0,0(sp)
    8000ef68:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    8000ef6c:	00053783          	ld	a5,0(a0)
    8000ef70:	0107b783          	ld	a5,16(a5)
    8000ef74:	000780e7          	jalr	a5
}
    8000ef78:	00813083          	ld	ra,8(sp)
    8000ef7c:	00013403          	ld	s0,0(sp)
    8000ef80:	01010113          	addi	sp,sp,16
    8000ef84:	00008067          	ret

000000008000ef88 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    8000ef88:	ff010113          	addi	sp,sp,-16
    8000ef8c:	00113423          	sd	ra,8(sp)
    8000ef90:	00813023          	sd	s0,0(sp)
    8000ef94:	01010413          	addi	s0,sp,16
    8000ef98:	00001797          	auipc	a5,0x1
    8000ef9c:	3a078793          	addi	a5,a5,928 # 80010338 <_ZTV9Semaphore+0x10>
    8000efa0:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    8000efa4:	00853503          	ld	a0,8(a0)
    8000efa8:	ffffe097          	auipc	ra,0xffffe
    8000efac:	2ac080e7          	jalr	684(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
};
    8000efb0:	00813083          	ld	ra,8(sp)
    8000efb4:	00013403          	ld	s0,0(sp)
    8000efb8:	01010113          	addi	sp,sp,16
    8000efbc:	00008067          	ret

000000008000efc0 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    8000efc0:	00001797          	auipc	a5,0x1
    8000efc4:	39878793          	addi	a5,a5,920 # 80010358 <_ZTV6Thread+0x10>
    8000efc8:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000efcc:	00853503          	ld	a0,8(a0)
    8000efd0:	02050663          	beqz	a0,8000effc <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    8000efd4:	ff010113          	addi	sp,sp,-16
    8000efd8:	00113423          	sd	ra,8(sp)
    8000efdc:	00813023          	sd	s0,0(sp)
    8000efe0:	01010413          	addi	s0,sp,16
    delete myHandle;
    8000efe4:	ffffe097          	auipc	ra,0xffffe
    8000efe8:	3e0080e7          	jalr	992(ra) # 8000d3c4 <_ZN7_threaddlEPv>
}
    8000efec:	00813083          	ld	ra,8(sp)
    8000eff0:	00013403          	ld	s0,0(sp)
    8000eff4:	01010113          	addi	sp,sp,16
    8000eff8:	00008067          	ret
    8000effc:	00008067          	ret

000000008000f000 <_Znwm>:
void* operator new(size_t sz){
    8000f000:	ff010113          	addi	sp,sp,-16
    8000f004:	00113423          	sd	ra,8(sp)
    8000f008:	00813023          	sd	s0,0(sp)
    8000f00c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000f010:	ffffe097          	auipc	ra,0xffffe
    8000f014:	010080e7          	jalr	16(ra) # 8000d020 <_Z9mem_allocm>
}
    8000f018:	00813083          	ld	ra,8(sp)
    8000f01c:	00013403          	ld	s0,0(sp)
    8000f020:	01010113          	addi	sp,sp,16
    8000f024:	00008067          	ret

000000008000f028 <_Znam>:
void* operator new[](size_t sz){
    8000f028:	ff010113          	addi	sp,sp,-16
    8000f02c:	00113423          	sd	ra,8(sp)
    8000f030:	00813023          	sd	s0,0(sp)
    8000f034:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000f038:	ffffe097          	auipc	ra,0xffffe
    8000f03c:	fe8080e7          	jalr	-24(ra) # 8000d020 <_Z9mem_allocm>
}
    8000f040:	00813083          	ld	ra,8(sp)
    8000f044:	00013403          	ld	s0,0(sp)
    8000f048:	01010113          	addi	sp,sp,16
    8000f04c:	00008067          	ret

000000008000f050 <_ZdlPv>:
void operator delete(void *ptr){
    8000f050:	ff010113          	addi	sp,sp,-16
    8000f054:	00113423          	sd	ra,8(sp)
    8000f058:	00813023          	sd	s0,0(sp)
    8000f05c:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    8000f060:	ffffe097          	auipc	ra,0xffffe
    8000f064:	ff0080e7          	jalr	-16(ra) # 8000d050 <_Z8mem_freePv>
}
    8000f068:	00813083          	ld	ra,8(sp)
    8000f06c:	00013403          	ld	s0,0(sp)
    8000f070:	01010113          	addi	sp,sp,16
    8000f074:	00008067          	ret

000000008000f078 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    8000f078:	fe010113          	addi	sp,sp,-32
    8000f07c:	00113c23          	sd	ra,24(sp)
    8000f080:	00813823          	sd	s0,16(sp)
    8000f084:	00913423          	sd	s1,8(sp)
    8000f088:	02010413          	addi	s0,sp,32
    8000f08c:	00050493          	mv	s1,a0
};
    8000f090:	00000097          	auipc	ra,0x0
    8000f094:	ef8080e7          	jalr	-264(ra) # 8000ef88 <_ZN9SemaphoreD1Ev>
    8000f098:	00048513          	mv	a0,s1
    8000f09c:	00000097          	auipc	ra,0x0
    8000f0a0:	fb4080e7          	jalr	-76(ra) # 8000f050 <_ZdlPv>
    8000f0a4:	01813083          	ld	ra,24(sp)
    8000f0a8:	01013403          	ld	s0,16(sp)
    8000f0ac:	00813483          	ld	s1,8(sp)
    8000f0b0:	02010113          	addi	sp,sp,32
    8000f0b4:	00008067          	ret

000000008000f0b8 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    8000f0b8:	fe010113          	addi	sp,sp,-32
    8000f0bc:	00113c23          	sd	ra,24(sp)
    8000f0c0:	00813823          	sd	s0,16(sp)
    8000f0c4:	00913423          	sd	s1,8(sp)
    8000f0c8:	02010413          	addi	s0,sp,32
    8000f0cc:	00050493          	mv	s1,a0
}
    8000f0d0:	00000097          	auipc	ra,0x0
    8000f0d4:	ef0080e7          	jalr	-272(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000f0d8:	00048513          	mv	a0,s1
    8000f0dc:	00000097          	auipc	ra,0x0
    8000f0e0:	f74080e7          	jalr	-140(ra) # 8000f050 <_ZdlPv>
    8000f0e4:	01813083          	ld	ra,24(sp)
    8000f0e8:	01013403          	ld	s0,16(sp)
    8000f0ec:	00813483          	ld	s1,8(sp)
    8000f0f0:	02010113          	addi	sp,sp,32
    8000f0f4:	00008067          	ret

000000008000f0f8 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000f0f8:	ff010113          	addi	sp,sp,-16
    8000f0fc:	00113423          	sd	ra,8(sp)
    8000f100:	00813023          	sd	s0,0(sp)
    8000f104:	01010413          	addi	s0,sp,16
    8000f108:	00001797          	auipc	a5,0x1
    8000f10c:	23078793          	addi	a5,a5,560 # 80010338 <_ZTV9Semaphore+0x10>
    8000f110:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    8000f114:	00850513          	addi	a0,a0,8
    8000f118:	ffffe097          	auipc	ra,0xffffe
    8000f11c:	104080e7          	jalr	260(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000f120:	00813083          	ld	ra,8(sp)
    8000f124:	00013403          	ld	s0,0(sp)
    8000f128:	01010113          	addi	sp,sp,16
    8000f12c:	00008067          	ret

000000008000f130 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    8000f130:	ff010113          	addi	sp,sp,-16
    8000f134:	00113423          	sd	ra,8(sp)
    8000f138:	00813023          	sd	s0,0(sp)
    8000f13c:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    8000f140:	00853503          	ld	a0,8(a0)
    8000f144:	ffffe097          	auipc	ra,0xffffe
    8000f148:	13c080e7          	jalr	316(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
}
    8000f14c:	00813083          	ld	ra,8(sp)
    8000f150:	00013403          	ld	s0,0(sp)
    8000f154:	01010113          	addi	sp,sp,16
    8000f158:	00008067          	ret

000000008000f15c <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    8000f15c:	ff010113          	addi	sp,sp,-16
    8000f160:	00113423          	sd	ra,8(sp)
    8000f164:	00813023          	sd	s0,0(sp)
    8000f168:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    8000f16c:	00853503          	ld	a0,8(a0)
    8000f170:	ffffe097          	auipc	ra,0xffffe
    8000f174:	13c080e7          	jalr	316(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
}
    8000f178:	00813083          	ld	ra,8(sp)
    8000f17c:	00013403          	ld	s0,0(sp)
    8000f180:	01010113          	addi	sp,sp,16
    8000f184:	00008067          	ret

000000008000f188 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    8000f188:	fe010113          	addi	sp,sp,-32
    8000f18c:	00113c23          	sd	ra,24(sp)
    8000f190:	00813823          	sd	s0,16(sp)
    8000f194:	00913423          	sd	s1,8(sp)
    8000f198:	02010413          	addi	s0,sp,32
    8000f19c:	00050493          	mv	s1,a0
    8000f1a0:	00001797          	auipc	a5,0x1
    8000f1a4:	1b878793          	addi	a5,a5,440 # 80010358 <_ZTV6Thread+0x10>
    8000f1a8:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    8000f1ac:	00850513          	addi	a0,a0,8
    8000f1b0:	ffffe097          	auipc	ra,0xffffe
    8000f1b4:	fa0080e7          	jalr	-96(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f1b8:	fff00793          	li	a5,-1
    8000f1bc:	00f50c63          	beq	a0,a5,8000f1d4 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    8000f1c0:	01813083          	ld	ra,24(sp)
    8000f1c4:	01013403          	ld	s0,16(sp)
    8000f1c8:	00813483          	ld	s1,8(sp)
    8000f1cc:	02010113          	addi	sp,sp,32
    8000f1d0:	00008067          	ret
        myHandle = nullptr;
    8000f1d4:	0004b423          	sd	zero,8(s1)
}
    8000f1d8:	fe9ff06f          	j	8000f1c0 <_ZN6ThreadC1EPFvPvES0_+0x38>

000000008000f1dc <_ZN6ThreadC1Ev>:
Thread::Thread() {
    8000f1dc:	fe010113          	addi	sp,sp,-32
    8000f1e0:	00113c23          	sd	ra,24(sp)
    8000f1e4:	00813823          	sd	s0,16(sp)
    8000f1e8:	00913423          	sd	s1,8(sp)
    8000f1ec:	02010413          	addi	s0,sp,32
    8000f1f0:	00050493          	mv	s1,a0
    8000f1f4:	00001797          	auipc	a5,0x1
    8000f1f8:	16478793          	addi	a5,a5,356 # 80010358 <_ZTV6Thread+0x10>
    8000f1fc:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    8000f200:	00050613          	mv	a2,a0
    8000f204:	00000597          	auipc	a1,0x0
    8000f208:	d5858593          	addi	a1,a1,-680 # 8000ef5c <_ZN6Thread7wrapperEPv>
    8000f20c:	00850513          	addi	a0,a0,8
    8000f210:	ffffe097          	auipc	ra,0xffffe
    8000f214:	f40080e7          	jalr	-192(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f218:	fff00793          	li	a5,-1
    8000f21c:	00f50c63          	beq	a0,a5,8000f234 <_ZN6ThreadC1Ev+0x58>
}
    8000f220:	01813083          	ld	ra,24(sp)
    8000f224:	01013403          	ld	s0,16(sp)
    8000f228:	00813483          	ld	s1,8(sp)
    8000f22c:	02010113          	addi	sp,sp,32
    8000f230:	00008067          	ret
        myHandle = nullptr;
    8000f234:	0004b423          	sd	zero,8(s1)
}
    8000f238:	fe9ff06f          	j	8000f220 <_ZN6ThreadC1Ev+0x44>

000000008000f23c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    8000f23c:	ff010113          	addi	sp,sp,-16
    8000f240:	00113423          	sd	ra,8(sp)
    8000f244:	00813023          	sd	s0,0(sp)
    8000f248:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    8000f24c:	ffffe097          	auipc	ra,0xffffe
    8000f250:	08c080e7          	jalr	140(ra) # 8000d2d8 <_Z10time_sleepm>
}
    8000f254:	00813083          	ld	ra,8(sp)
    8000f258:	00013403          	ld	s0,0(sp)
    8000f25c:	01010113          	addi	sp,sp,16
    8000f260:	00008067          	ret

000000008000f264 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    8000f264:	fe010113          	addi	sp,sp,-32
    8000f268:	00113c23          	sd	ra,24(sp)
    8000f26c:	00813823          	sd	s0,16(sp)
    8000f270:	00913423          	sd	s1,8(sp)
    8000f274:	01213023          	sd	s2,0(sp)
    8000f278:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    8000f27c:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    8000f280:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    8000f284:	0004b783          	ld	a5,0(s1)
    8000f288:	0187b783          	ld	a5,24(a5)
    8000f28c:	00048513          	mv	a0,s1
    8000f290:	000780e7          	jalr	a5
        pt->sleep(time);
    8000f294:	00090513          	mv	a0,s2
    8000f298:	00000097          	auipc	ra,0x0
    8000f29c:	fa4080e7          	jalr	-92(ra) # 8000f23c <_ZN6Thread5sleepEm>
    while(true){
    8000f2a0:	fe5ff06f          	j	8000f284 <_ZN14PeriodicThread7wrapperEPv+0x20>

000000008000f2a4 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000f2a4:	ff010113          	addi	sp,sp,-16
    8000f2a8:	00113423          	sd	ra,8(sp)
    8000f2ac:	00813023          	sd	s0,0(sp)
    8000f2b0:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000f2b4:	ffffe097          	auipc	ra,0xffffe
    8000f2b8:	e7c080e7          	jalr	-388(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000f2bc:	00813083          	ld	ra,8(sp)
    8000f2c0:	00013403          	ld	s0,0(sp)
    8000f2c4:	01010113          	addi	sp,sp,16
    8000f2c8:	00008067          	ret

000000008000f2cc <_ZN6Thread5startEv>:
int Thread::start() {
    8000f2cc:	ff010113          	addi	sp,sp,-16
    8000f2d0:	00113423          	sd	ra,8(sp)
    8000f2d4:	00813023          	sd	s0,0(sp)
    8000f2d8:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    8000f2dc:	00853503          	ld	a0,8(a0)
    8000f2e0:	ffffe097          	auipc	ra,0xffffe
    8000f2e4:	f04080e7          	jalr	-252(ra) # 8000d1e4 <_Z12thread_startP7_thread>
}
    8000f2e8:	00813083          	ld	ra,8(sp)
    8000f2ec:	00013403          	ld	s0,0(sp)
    8000f2f0:	01010113          	addi	sp,sp,16
    8000f2f4:	00008067          	ret

000000008000f2f8 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f2f8:	fe010113          	addi	sp,sp,-32
    8000f2fc:	00113c23          	sd	ra,24(sp)
    8000f300:	00813823          	sd	s0,16(sp)
    8000f304:	00913423          	sd	s1,8(sp)
    8000f308:	01213023          	sd	s2,0(sp)
    8000f30c:	02010413          	addi	s0,sp,32
    8000f310:	00050493          	mv	s1,a0
    8000f314:	00058913          	mv	s2,a1
    8000f318:	01000513          	li	a0,16
    8000f31c:	00000097          	auipc	ra,0x0
    8000f320:	ce4080e7          	jalr	-796(ra) # 8000f000 <_Znwm>
    8000f324:	00050613          	mv	a2,a0
    8000f328:	00050663          	beqz	a0,8000f334 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    8000f32c:	00953023          	sd	s1,0(a0)
    8000f330:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f334:	00000597          	auipc	a1,0x0
    8000f338:	f3058593          	addi	a1,a1,-208 # 8000f264 <_ZN14PeriodicThread7wrapperEPv>
    8000f33c:	00048513          	mv	a0,s1
    8000f340:	00000097          	auipc	ra,0x0
    8000f344:	e48080e7          	jalr	-440(ra) # 8000f188 <_ZN6ThreadC1EPFvPvES0_>
    8000f348:	00001797          	auipc	a5,0x1
    8000f34c:	fc078793          	addi	a5,a5,-64 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f350:	00f4b023          	sd	a5,0(s1)
    8000f354:	01813083          	ld	ra,24(sp)
    8000f358:	01013403          	ld	s0,16(sp)
    8000f35c:	00813483          	ld	s1,8(sp)
    8000f360:	00013903          	ld	s2,0(sp)
    8000f364:	02010113          	addi	sp,sp,32
    8000f368:	00008067          	ret

000000008000f36c <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    8000f36c:	ff010113          	addi	sp,sp,-16
    8000f370:	00113423          	sd	ra,8(sp)
    8000f374:	00813023          	sd	s0,0(sp)
    8000f378:	01010413          	addi	s0,sp,16
    return ::getc();
    8000f37c:	ffffe097          	auipc	ra,0xffffe
    8000f380:	f88080e7          	jalr	-120(ra) # 8000d304 <_Z4getcv>
}
    8000f384:	00813083          	ld	ra,8(sp)
    8000f388:	00013403          	ld	s0,0(sp)
    8000f38c:	01010113          	addi	sp,sp,16
    8000f390:	00008067          	ret

000000008000f394 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    8000f394:	ff010113          	addi	sp,sp,-16
    8000f398:	00113423          	sd	ra,8(sp)
    8000f39c:	00813023          	sd	s0,0(sp)
    8000f3a0:	01010413          	addi	s0,sp,16
    ::putc(c);
    8000f3a4:	ffffe097          	auipc	ra,0xffffe
    8000f3a8:	f88080e7          	jalr	-120(ra) # 8000d32c <_Z4putcc>
}
    8000f3ac:	00813083          	ld	ra,8(sp)
    8000f3b0:	00013403          	ld	s0,0(sp)
    8000f3b4:	01010113          	addi	sp,sp,16
    8000f3b8:	00008067          	ret

000000008000f3bc <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    8000f3bc:	ff010113          	addi	sp,sp,-16
    8000f3c0:	00813423          	sd	s0,8(sp)
    8000f3c4:	01010413          	addi	s0,sp,16
    8000f3c8:	00813403          	ld	s0,8(sp)
    8000f3cc:	01010113          	addi	sp,sp,16
    8000f3d0:	00008067          	ret

000000008000f3d4 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    8000f3d4:	ff010113          	addi	sp,sp,-16
    8000f3d8:	00813423          	sd	s0,8(sp)
    8000f3dc:	01010413          	addi	s0,sp,16
    8000f3e0:	00813403          	ld	s0,8(sp)
    8000f3e4:	01010113          	addi	sp,sp,16
    8000f3e8:	00008067          	ret

000000008000f3ec <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    8000f3ec:	ff010113          	addi	sp,sp,-16
    8000f3f0:	00113423          	sd	ra,8(sp)
    8000f3f4:	00813023          	sd	s0,0(sp)
    8000f3f8:	01010413          	addi	s0,sp,16
    8000f3fc:	00001797          	auipc	a5,0x1
    8000f400:	f0c78793          	addi	a5,a5,-244 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f404:	00f53023          	sd	a5,0(a0)
    8000f408:	00000097          	auipc	ra,0x0
    8000f40c:	bb8080e7          	jalr	-1096(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000f410:	00813083          	ld	ra,8(sp)
    8000f414:	00013403          	ld	s0,0(sp)
    8000f418:	01010113          	addi	sp,sp,16
    8000f41c:	00008067          	ret

000000008000f420 <_ZN14PeriodicThreadD0Ev>:
    8000f420:	fe010113          	addi	sp,sp,-32
    8000f424:	00113c23          	sd	ra,24(sp)
    8000f428:	00813823          	sd	s0,16(sp)
    8000f42c:	00913423          	sd	s1,8(sp)
    8000f430:	02010413          	addi	s0,sp,32
    8000f434:	00050493          	mv	s1,a0
    8000f438:	00001797          	auipc	a5,0x1
    8000f43c:	ed078793          	addi	a5,a5,-304 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f440:	00f53023          	sd	a5,0(a0)
    8000f444:	00000097          	auipc	ra,0x0
    8000f448:	b7c080e7          	jalr	-1156(ra) # 8000efc0 <_ZN6ThreadD1Ev>
    8000f44c:	00048513          	mv	a0,s1
    8000f450:	00000097          	auipc	ra,0x0
    8000f454:	c00080e7          	jalr	-1024(ra) # 8000f050 <_ZdlPv>
    8000f458:	01813083          	ld	ra,24(sp)
    8000f45c:	01013403          	ld	s0,16(sp)
    8000f460:	00813483          	ld	s1,8(sp)
    8000f464:	02010113          	addi	sp,sp,32
    8000f468:	00008067          	ret
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
    80010250:	e47c 8000 0000 0000 e4b0 8000 0000 0000     |...............
    80010260:	e5fc 8000 0000 0000                         ........

0000000080010268 <_ZTVN19ConsumerProducerCPP8ProducerE>:
	...
    80010278:	e4fc 8000 0000 0000 e530 8000 0000 0000     ........0.......
    80010288:	e680 8000 0000 0000                         ........

0000000080010290 <_ZTVN19ConsumerProducerCPP8ConsumerE>:
	...
    800102a0:	e3fc 8000 0000 0000 e430 8000 0000 0000     ........0.......
    800102b0:	e32c 8000 0000 0000                         ,.......

00000000800102b8 <_ZTV10ForkThread>:
	...
    800102c8:	e57c 8000 0000 0000 e5b0 8000 0000 0000     |...............
    800102d8:	e714 8000 0000 0000                         ........

00000000800102e0 <digits>:
    800102e0:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...

00000000800102f8 <_ZTV14PeriodicThread>:
	...
    80010308:	f3ec 8000 0000 0000 f420 8000 0000 0000     ........ .......
    80010318:	f3bc 8000 0000 0000 f3d4 8000 0000 0000     ................

0000000080010328 <_ZTV9Semaphore>:
	...
    80010338:	ef88 8000 0000 0000 f078 8000 0000 0000     ........x.......

0000000080010348 <_ZTV6Thread>:
	...
    80010358:	efc0 8000 0000 0000 f0b8 8000 0000 0000     ................
    80010368:	f3bc 8000 0000 0000                         ........

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
