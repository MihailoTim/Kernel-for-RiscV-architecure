
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	fa013103          	ld	sp,-96(sp) # 8000bfa0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	6a1060ef          	jal	ra,80006ebc <start>

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
    800010a8:	325030ef          	jal	ra,80004bcc <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001184:	7e8080e7          	jalr	2024(ra) # 80002968 <_ZN5Buddy4freeEPvm>
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
    800011bc:	14050e63          	beqz	a0,80001318 <_ZN13SlabAllocator9printSlabEP4Slab+0x15c>
void SlabAllocator::printSlab(Slab *slab) {
    800011c0:	fe010113          	addi	sp,sp,-32
    800011c4:	00113c23          	sd	ra,24(sp)
    800011c8:	00813823          	sd	s0,16(sp)
    800011cc:	00913423          	sd	s1,8(sp)
    800011d0:	01213023          	sd	s2,0(sp)
    800011d4:	02010413          	addi	s0,sp,32
    800011d8:	00050913          	mv	s2,a0
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    800011dc:	01000693          	li	a3,16
    800011e0:	00008617          	auipc	a2,0x8
    800011e4:	1e060613          	addi	a2,a2,480 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800011e8:	0005059b          	sext.w	a1,a0
    800011ec:	00008517          	auipc	a0,0x8
    800011f0:	e3450513          	addi	a0,a0,-460 # 80009020 <CONSOLE_STATUS+0x10>
    800011f4:	00004097          	auipc	ra,0x4
    800011f8:	4a8080e7          	jalr	1192(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011fc:	01000693          	li	a3,16
    80001200:	00008617          	auipc	a2,0x8
    80001204:	1c060613          	addi	a2,a2,448 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001208:	01892583          	lw	a1,24(s2)
    8000120c:	00008517          	auipc	a0,0x8
    80001210:	e2450513          	addi	a0,a0,-476 # 80009030 <CONSOLE_STATUS+0x20>
    80001214:	00004097          	auipc	ra,0x4
    80001218:	488080e7          	jalr	1160(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    8000121c:	01000693          	li	a3,16
    80001220:	00008617          	auipc	a2,0x8
    80001224:	1a060613          	addi	a2,a2,416 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001228:	01092583          	lw	a1,16(s2)
    8000122c:	00008517          	auipc	a0,0x8
    80001230:	e1c50513          	addi	a0,a0,-484 # 80009048 <CONSOLE_STATUS+0x38>
    80001234:	00004097          	auipc	ra,0x4
    80001238:	468080e7          	jalr	1128(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    8000123c:	01000693          	li	a3,16
    80001240:	00008617          	auipc	a2,0x8
    80001244:	18060613          	addi	a2,a2,384 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001248:	03800593          	li	a1,56
    8000124c:	00008517          	auipc	a0,0x8
    80001250:	e1450513          	addi	a0,a0,-492 # 80009060 <CONSOLE_STATUS+0x50>
    80001254:	00004097          	auipc	ra,0x4
    80001258:	448080e7          	jalr	1096(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000125c:	01000693          	li	a3,16
    80001260:	00008617          	auipc	a2,0x8
    80001264:	16060613          	addi	a2,a2,352 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001268:	02892583          	lw	a1,40(s2)
    8000126c:	00008517          	auipc	a0,0x8
    80001270:	e0c50513          	addi	a0,a0,-500 # 80009078 <CONSOLE_STATUS+0x68>
    80001274:	00004097          	auipc	ra,0x4
    80001278:	428080e7          	jalr	1064(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    8000127c:	01000693          	li	a3,16
    80001280:	00008617          	auipc	a2,0x8
    80001284:	14060613          	addi	a2,a2,320 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001288:	02092583          	lw	a1,32(s2)
    8000128c:	00008517          	auipc	a0,0x8
    80001290:	dfc50513          	addi	a0,a0,-516 # 80009088 <CONSOLE_STATUS+0x78>
    80001294:	00004097          	auipc	ra,0x4
    80001298:	408080e7          	jalr	1032(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000129c:	00008517          	auipc	a0,0x8
    800012a0:	e0c50513          	addi	a0,a0,-500 # 800090a8 <CONSOLE_STATUS+0x98>
    800012a4:	00004097          	auipc	ra,0x4
    800012a8:	2d8080e7          	jalr	728(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012ac:	00000493          	li	s1,0
    800012b0:	0300006f          	j	800012e0 <_ZN13SlabAllocator9printSlabEP4Slab+0x124>
            ConsoleUtil::print("", slab->allocated[i], " ");
    800012b4:	02093783          	ld	a5,32(s2)
    800012b8:	009787b3          	add	a5,a5,s1
    800012bc:	01000693          	li	a3,16
    800012c0:	00008617          	auipc	a2,0x8
    800012c4:	e2860613          	addi	a2,a2,-472 # 800090e8 <CONSOLE_STATUS+0xd8>
    800012c8:	0007c583          	lbu	a1,0(a5)
    800012cc:	00008517          	auipc	a0,0x8
    800012d0:	13450513          	addi	a0,a0,308 # 80009400 <CONSOLE_STATUS+0x3f0>
    800012d4:	00004097          	auipc	ra,0x4
    800012d8:	3c8080e7          	jalr	968(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012dc:	00148493          	addi	s1,s1,1
    800012e0:	01893783          	ld	a5,24(s2)
    800012e4:	0037d793          	srli	a5,a5,0x3
    800012e8:	00178793          	addi	a5,a5,1
    800012ec:	fcf4e4e3          	bltu	s1,a5,800012b4 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    800012f0:	00008517          	auipc	a0,0x8
    800012f4:	0d050513          	addi	a0,a0,208 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800012f8:	00004097          	auipc	ra,0x4
    800012fc:	284080e7          	jalr	644(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    80001300:	01813083          	ld	ra,24(sp)
    80001304:	01013403          	ld	s0,16(sp)
    80001308:	00813483          	ld	s1,8(sp)
    8000130c:	00013903          	ld	s2,0(sp)
    80001310:	02010113          	addi	sp,sp,32
    80001314:	00008067          	ret
    80001318:	00008067          	ret

000000008000131c <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    8000131c:	fe010113          	addi	sp,sp,-32
    80001320:	00113c23          	sd	ra,24(sp)
    80001324:	00813823          	sd	s0,16(sp)
    80001328:	00913423          	sd	s1,8(sp)
    8000132c:	01213023          	sd	s2,0(sp)
    80001330:	02010413          	addi	s0,sp,32
    80001334:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    80001338:	00008517          	auipc	a0,0x8
    8000133c:	d9050513          	addi	a0,a0,-624 # 800090c8 <CONSOLE_STATUS+0xb8>
    80001340:	00004097          	auipc	ra,0x4
    80001344:	23c080e7          	jalr	572(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001348:	00090513          	mv	a0,s2
    8000134c:	00004097          	auipc	ra,0x4
    80001350:	230080e7          	jalr	560(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001354:	00008517          	auipc	a0,0x8
    80001358:	06c50513          	addi	a0,a0,108 # 800093c0 <CONSOLE_STATUS+0x3b0>
    8000135c:	00004097          	auipc	ra,0x4
    80001360:	220080e7          	jalr	544(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001364:	01000693          	li	a3,16
    80001368:	00008617          	auipc	a2,0x8
    8000136c:	05860613          	addi	a2,a2,88 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001370:	0000b797          	auipc	a5,0xb
    80001374:	c007b783          	ld	a5,-1024(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001378:	0007a583          	lw	a1,0(a5)
    8000137c:	00008517          	auipc	a0,0x8
    80001380:	d5c50513          	addi	a0,a0,-676 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001384:	00004097          	auipc	ra,0x4
    80001388:	318080e7          	jalr	792(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000138c:	01000693          	li	a3,16
    80001390:	00008617          	auipc	a2,0x8
    80001394:	03060613          	addi	a2,a2,48 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001398:	0009059b          	sext.w	a1,s2
    8000139c:	00008517          	auipc	a0,0x8
    800013a0:	d5450513          	addi	a0,a0,-684 # 800090f0 <CONSOLE_STATUS+0xe0>
    800013a4:	00004097          	auipc	ra,0x4
    800013a8:	2f8080e7          	jalr	760(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    800013ac:	01000693          	li	a3,16
    800013b0:	00008617          	auipc	a2,0x8
    800013b4:	01060613          	addi	a2,a2,16 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800013b8:	04892583          	lw	a1,72(s2)
    800013bc:	00008517          	auipc	a0,0x8
    800013c0:	d4450513          	addi	a0,a0,-700 # 80009100 <CONSOLE_STATUS+0xf0>
    800013c4:	00004097          	auipc	ra,0x4
    800013c8:	2d8080e7          	jalr	728(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013cc:	01000693          	li	a3,16
    800013d0:	00008617          	auipc	a2,0x8
    800013d4:	ff060613          	addi	a2,a2,-16 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800013d8:	04092583          	lw	a1,64(s2)
    800013dc:	00008517          	auipc	a0,0x8
    800013e0:	d3c50513          	addi	a0,a0,-708 # 80009118 <CONSOLE_STATUS+0x108>
    800013e4:	00004097          	auipc	ra,0x4
    800013e8:	2b8080e7          	jalr	696(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013ec:	01000693          	li	a3,16
    800013f0:	00008617          	auipc	a2,0x8
    800013f4:	fd060613          	addi	a2,a2,-48 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800013f8:	06092583          	lw	a1,96(s2)
    800013fc:	00008517          	auipc	a0,0x8
    80001400:	d3450513          	addi	a0,a0,-716 # 80009130 <CONSOLE_STATUS+0x120>
    80001404:	00004097          	auipc	ra,0x4
    80001408:	298080e7          	jalr	664(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>

    Slab* iter = cache->emptyHead;
    8000140c:	06093483          	ld	s1,96(s2)
    while(iter){
    80001410:	02048663          	beqz	s1,8000143c <_ZN13SlabAllocator10printCacheEP5Cache+0x120>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001414:	01000693          	li	a3,16
    80001418:	00008617          	auipc	a2,0x8
    8000141c:	cd060613          	addi	a2,a2,-816 # 800090e8 <CONSOLE_STATUS+0xd8>
    80001420:	0004859b          	sext.w	a1,s1
    80001424:	00008517          	auipc	a0,0x8
    80001428:	fdc50513          	addi	a0,a0,-36 # 80009400 <CONSOLE_STATUS+0x3f0>
    8000142c:	00004097          	auipc	ra,0x4
    80001430:	270080e7          	jalr	624(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001434:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001438:	fd9ff06f          	j	80001410 <_ZN13SlabAllocator10printCacheEP5Cache+0xf4>
    }
    ConsoleUtil::printString("\n");
    8000143c:	00008517          	auipc	a0,0x8
    80001440:	f8450513          	addi	a0,a0,-124 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001444:	00004097          	auipc	ra,0x4
    80001448:	138080e7          	jalr	312(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    8000144c:	01000693          	li	a3,16
    80001450:	00008617          	auipc	a2,0x8
    80001454:	f7060613          	addi	a2,a2,-144 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001458:	06892583          	lw	a1,104(s2)
    8000145c:	00008517          	auipc	a0,0x8
    80001460:	ce450513          	addi	a0,a0,-796 # 80009140 <CONSOLE_STATUS+0x130>
    80001464:	00004097          	auipc	ra,0x4
    80001468:	238080e7          	jalr	568(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->partialHead;
    8000146c:	06893483          	ld	s1,104(s2)
    while(iter){
    80001470:	02048663          	beqz	s1,8000149c <_ZN13SlabAllocator10printCacheEP5Cache+0x180>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001474:	01000693          	li	a3,16
    80001478:	00008617          	auipc	a2,0x8
    8000147c:	c7060613          	addi	a2,a2,-912 # 800090e8 <CONSOLE_STATUS+0xd8>
    80001480:	0004859b          	sext.w	a1,s1
    80001484:	00008517          	auipc	a0,0x8
    80001488:	f7c50513          	addi	a0,a0,-132 # 80009400 <CONSOLE_STATUS+0x3f0>
    8000148c:	00004097          	auipc	ra,0x4
    80001490:	210080e7          	jalr	528(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001494:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001498:	fd9ff06f          	j	80001470 <_ZN13SlabAllocator10printCacheEP5Cache+0x154>
    }
    ConsoleUtil::printString("\n");
    8000149c:	00008517          	auipc	a0,0x8
    800014a0:	f2450513          	addi	a0,a0,-220 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800014a4:	00004097          	auipc	ra,0x4
    800014a8:	0d8080e7          	jalr	216(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    800014ac:	01000693          	li	a3,16
    800014b0:	00008617          	auipc	a2,0x8
    800014b4:	f1060613          	addi	a2,a2,-240 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800014b8:	07092583          	lw	a1,112(s2)
    800014bc:	00008517          	auipc	a0,0x8
    800014c0:	c9450513          	addi	a0,a0,-876 # 80009150 <CONSOLE_STATUS+0x140>
    800014c4:	00004097          	auipc	ra,0x4
    800014c8:	1d8080e7          	jalr	472(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->fullHead;
    800014cc:	07093483          	ld	s1,112(s2)
    while(iter){
    800014d0:	02048663          	beqz	s1,800014fc <_ZN13SlabAllocator10printCacheEP5Cache+0x1e0>
        ConsoleUtil::print("", (uint64)iter, " ");
    800014d4:	01000693          	li	a3,16
    800014d8:	00008617          	auipc	a2,0x8
    800014dc:	c1060613          	addi	a2,a2,-1008 # 800090e8 <CONSOLE_STATUS+0xd8>
    800014e0:	0004859b          	sext.w	a1,s1
    800014e4:	00008517          	auipc	a0,0x8
    800014e8:	f1c50513          	addi	a0,a0,-228 # 80009400 <CONSOLE_STATUS+0x3f0>
    800014ec:	00004097          	auipc	ra,0x4
    800014f0:	1b0080e7          	jalr	432(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800014f4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014f8:	fd9ff06f          	j	800014d0 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b4>
    }
    ConsoleUtil::printString("\n");
    800014fc:	00008517          	auipc	a0,0x8
    80001500:	ec450513          	addi	a0,a0,-316 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80001504:	00004097          	auipc	ra,0x4
    80001508:	078080e7          	jalr	120(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
}
    8000150c:	01813083          	ld	ra,24(sp)
    80001510:	01013403          	ld	s0,16(sp)
    80001514:	00813483          	ld	s1,8(sp)
    80001518:	00013903          	ld	s2,0(sp)
    8000151c:	02010113          	addi	sp,sp,32
    80001520:	00008067          	ret

0000000080001524 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    80001524:	ff010113          	addi	sp,sp,-16
    80001528:	00813423          	sd	s0,8(sp)
    8000152c:	01010413          	addi	s0,sp,16
    slab->next = head;
    80001530:	00053783          	ld	a5,0(a0)
    80001534:	00f5b423          	sd	a5,8(a1)
    if(head)
    80001538:	00078463          	beqz	a5,80001540 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    8000153c:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    80001540:	0005b023          	sd	zero,0(a1)
    head = slab;
    80001544:	00b53023          	sd	a1,0(a0)
}
    80001548:	00813403          	ld	s0,8(sp)
    8000154c:	01010113          	addi	sp,sp,16
    80001550:	00008067          	ret

0000000080001554 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    80001554:	fd010113          	addi	sp,sp,-48
    80001558:	02113423          	sd	ra,40(sp)
    8000155c:	02813023          	sd	s0,32(sp)
    80001560:	00913c23          	sd	s1,24(sp)
    80001564:	01213823          	sd	s2,16(sp)
    80001568:	01313423          	sd	s3,8(sp)
    8000156c:	03010413          	addi	s0,sp,48
    80001570:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    80001574:	04853503          	ld	a0,72(a0)
    80001578:	00001097          	auipc	ra,0x1
    8000157c:	4c8080e7          	jalr	1224(ra) # 80002a40 <_ZN5Buddy5allocEm>
    if(!slab)
    80001580:	0a050863          	beqz	a0,80001630 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xdc>
    80001584:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80001588:	00050593          	mv	a1,a0
    8000158c:	06098513          	addi	a0,s3,96
    80001590:	00000097          	auipc	ra,0x0
    80001594:	f94080e7          	jalr	-108(ra) # 80001524 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80001598:	0489b783          	ld	a5,72(s3)
    8000159c:	00c79793          	slli	a5,a5,0xc
    800015a0:	fc878793          	addi	a5,a5,-56
    800015a4:	0409b703          	ld	a4,64(s3)
    800015a8:	02e7d7b3          	divu	a5,a5,a4
    800015ac:	00f4b823          	sd	a5,16(s1)
    800015b0:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + slab->totalNumOfSlots/8 + 1);
    800015b4:	0037d793          	srli	a5,a5,0x3
    800015b8:	009787b3          	add	a5,a5,s1
    800015bc:	03978793          	addi	a5,a5,57
    800015c0:	02f4b423          	sd	a5,40(s1)
    slab->allocated = (char*)((uint64)slab + sizeof(Slab));
    800015c4:	03848793          	addi	a5,s1,56
    800015c8:	02f4b023          	sd	a5,32(s1)
    slab->parent = cache;
    800015cc:	0334b823          	sd	s3,48(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800015d0:	00000713          	li	a4,0
    800015d4:	0184b783          	ld	a5,24(s1)
    800015d8:	0037d793          	srli	a5,a5,0x3
    800015dc:	00178793          	addi	a5,a5,1
    800015e0:	00f77c63          	bgeu	a4,a5,800015f8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa4>
        slab->allocated[i] = 0;
    800015e4:	0204b783          	ld	a5,32(s1)
    800015e8:	00e787b3          	add	a5,a5,a4
    800015ec:	00078023          	sb	zero,0(a5)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800015f0:	00170713          	addi	a4,a4,1
    800015f4:	fe1ff06f          	j	800015d4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x80>
    if(cache->ctor) {
    800015f8:	0509b783          	ld	a5,80(s3)
    800015fc:	02078e63          	beqz	a5,80001638 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80001600:	00000913          	li	s2,0
    80001604:	0184b783          	ld	a5,24(s1)
    80001608:	02f97c63          	bgeu	s2,a5,80001640 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xec>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    8000160c:	0509b703          	ld	a4,80(s3)
    80001610:	0284b503          	ld	a0,40(s1)
    80001614:	0304b783          	ld	a5,48(s1)
    80001618:	0407b783          	ld	a5,64(a5)
    8000161c:	032787b3          	mul	a5,a5,s2
    80001620:	00f50533          	add	a0,a0,a5
    80001624:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80001628:	00190913          	addi	s2,s2,1
    8000162c:	fd9ff06f          	j	80001604 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xb0>
        return false;
    80001630:	00000513          	li	a0,0
    80001634:	0100006f          	j	80001644 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    return true;
    80001638:	00100513          	li	a0,1
    8000163c:	0080006f          	j	80001644 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    80001640:	00100513          	li	a0,1
}
    80001644:	02813083          	ld	ra,40(sp)
    80001648:	02013403          	ld	s0,32(sp)
    8000164c:	01813483          	ld	s1,24(sp)
    80001650:	01013903          	ld	s2,16(sp)
    80001654:	00813983          	ld	s3,8(sp)
    80001658:	03010113          	addi	sp,sp,48
    8000165c:	00008067          	ret

0000000080001660 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80001660:	ff010113          	addi	sp,sp,-16
    80001664:	00813423          	sd	s0,8(sp)
    80001668:	01010413          	addi	s0,sp,16
    if(slab == head)
    8000166c:	00053783          	ld	a5,0(a0)
    80001670:	02b78c63          	beq	a5,a1,800016a8 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80001674:	0085b783          	ld	a5,8(a1)
    80001678:	00078663          	beqz	a5,80001684 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    8000167c:	0005b703          	ld	a4,0(a1)
    80001680:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80001684:	0005b783          	ld	a5,0(a1)
    80001688:	00078663          	beqz	a5,80001694 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    8000168c:	0085b703          	ld	a4,8(a1)
    80001690:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80001694:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80001698:	0005b423          	sd	zero,8(a1)
}
    8000169c:	00813403          	ld	s0,8(sp)
    800016a0:	01010113          	addi	sp,sp,16
    800016a4:	00008067          	ret
        head = slab->next;
    800016a8:	0085b783          	ld	a5,8(a1)
    800016ac:	00f53023          	sd	a5,0(a0)
    800016b0:	fc5ff06f          	j	80001674 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

00000000800016b4 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    800016b4:	fe010113          	addi	sp,sp,-32
    800016b8:	00113c23          	sd	ra,24(sp)
    800016bc:	00813823          	sd	s0,16(sp)
    800016c0:	00913423          	sd	s1,8(sp)
    800016c4:	01213023          	sd	s2,0(sp)
    800016c8:	02010413          	addi	s0,sp,32
    800016cc:	00058913          	mv	s2,a1
    800016d0:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    800016d4:	00060593          	mv	a1,a2
    800016d8:	00000097          	auipc	ra,0x0
    800016dc:	f88080e7          	jalr	-120(ra) # 80001660 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    800016e0:	00048593          	mv	a1,s1
    800016e4:	00090513          	mv	a0,s2
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	e3c080e7          	jalr	-452(ra) # 80001524 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    800016f0:	01813083          	ld	ra,24(sp)
    800016f4:	01013403          	ld	s0,16(sp)
    800016f8:	00813483          	ld	s1,8(sp)
    800016fc:	00013903          	ld	s2,0(sp)
    80001700:	02010113          	addi	sp,sp,32
    80001704:	00008067          	ret

0000000080001708 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    80001708:	fe010113          	addi	sp,sp,-32
    8000170c:	00113c23          	sd	ra,24(sp)
    80001710:	00813823          	sd	s0,16(sp)
    80001714:	00913423          	sd	s1,8(sp)
    80001718:	01213023          	sd	s2,0(sp)
    8000171c:	02010413          	addi	s0,sp,32
    80001720:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001724:	00000493          	li	s1,0
    80001728:	01893783          	ld	a5,24(s2)
    8000172c:	0af4f863          	bgeu	s1,a5,800017dc <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    80001730:	02093783          	ld	a5,32(s2)
    80001734:	0034d713          	srli	a4,s1,0x3
    80001738:	00e787b3          	add	a5,a5,a4
    8000173c:	0007c603          	lbu	a2,0(a5)
    80001740:	fff4c713          	not	a4,s1
    80001744:	00777713          	andi	a4,a4,7
    80001748:	40e656bb          	sraw	a3,a2,a4
    8000174c:	0016f693          	andi	a3,a3,1
    80001750:	00068663          	beqz	a3,8000175c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x54>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001754:	00148493          	addi	s1,s1,1
    80001758:	fd1ff06f          	j	80001728 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    8000175c:	00100693          	li	a3,1
    80001760:	00e6973b          	sllw	a4,a3,a4
    80001764:	00e66633          	or	a2,a2,a4
    80001768:	00c78023          	sb	a2,0(a5)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    8000176c:	01093783          	ld	a5,16(s2)
    80001770:	01893703          	ld	a4,24(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001774:	04f70863          	beq	a4,a5,800017c4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xbc>
    80001778:	03093503          	ld	a0,48(s2)
    8000177c:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80001780:	fff78793          	addi	a5,a5,-1
    80001784:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001788:	04079463          	bnez	a5,800017d0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc8>
    8000178c:	03093583          	ld	a1,48(s2)
    80001790:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80001794:	0005b703          	ld	a4,0(a1)
    80001798:	00053783          	ld	a5,0(a0)
    8000179c:	00f70863          	beq	a4,a5,800017ac <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa4>
                SlabAllocator::move(headFrom, headTo, slab);
    800017a0:	00090613          	mv	a2,s2
    800017a4:	00000097          	auipc	ra,0x0
    800017a8:	f10080e7          	jalr	-240(ra) # 800016b4 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    800017ac:	02893503          	ld	a0,40(s2)
    800017b0:	03093783          	ld	a5,48(s2)
    800017b4:	0407b783          	ld	a5,64(a5)
    800017b8:	029784b3          	mul	s1,a5,s1
    800017bc:	00950533          	add	a0,a0,s1
    800017c0:	0200006f          	j	800017e0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd8>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800017c4:	03093503          	ld	a0,48(s2)
    800017c8:	06050513          	addi	a0,a0,96
    800017cc:	fb5ff06f          	j	80001780 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x78>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800017d0:	03093583          	ld	a1,48(s2)
    800017d4:	06858593          	addi	a1,a1,104
    800017d8:	fbdff06f          	j	80001794 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x8c>
    return nullptr;
    800017dc:	00000513          	li	a0,0
}
    800017e0:	01813083          	ld	ra,24(sp)
    800017e4:	01013403          	ld	s0,16(sp)
    800017e8:	00813483          	ld	s1,8(sp)
    800017ec:	00013903          	ld	s2,0(sp)
    800017f0:	02010113          	addi	sp,sp,32
    800017f4:	00008067          	ret

00000000800017f8 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    800017f8:	fe010113          	addi	sp,sp,-32
    800017fc:	00113c23          	sd	ra,24(sp)
    80001800:	00813823          	sd	s0,16(sp)
    80001804:	00913423          	sd	s1,8(sp)
    80001808:	01213023          	sd	s2,0(sp)
    8000180c:	02010413          	addi	s0,sp,32
    80001810:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    80001814:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    80001818:	00048c63          	beqz	s1,80001830 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    8000181c:	00048513          	mv	a0,s1
    80001820:	00000097          	auipc	ra,0x0
    80001824:	ee8080e7          	jalr	-280(ra) # 80001708 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001828:	fe0508e3          	beqz	a0,80001818 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    8000182c:	00050493          	mv	s1,a0
    if(ret){
    80001830:	02048063          	beqz	s1,80001850 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    80001834:	00048513          	mv	a0,s1
    80001838:	01813083          	ld	ra,24(sp)
    8000183c:	01013403          	ld	s0,16(sp)
    80001840:	00813483          	ld	s1,8(sp)
    80001844:	00013903          	ld	s2,0(sp)
    80001848:	02010113          	addi	sp,sp,32
    8000184c:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80001850:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    80001854:	00048c63          	beqz	s1,8000186c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    80001858:	00048513          	mv	a0,s1
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	eac080e7          	jalr	-340(ra) # 80001708 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001864:	fe0508e3          	beqz	a0,80001854 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80001868:	00050493          	mv	s1,a0
    if(ret){
    8000186c:	fc0494e3          	bnez	s1,80001834 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80001870:	00090513          	mv	a0,s2
    80001874:	00000097          	auipc	ra,0x0
    80001878:	ce0080e7          	jalr	-800(ra) # 80001554 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    8000187c:	fa050ce3          	beqz	a0,80001834 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001880:	06093503          	ld	a0,96(s2)
    80001884:	00000097          	auipc	ra,0x0
    80001888:	e84080e7          	jalr	-380(ra) # 80001708 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    8000188c:	00050493          	mv	s1,a0
    return ret;
    80001890:	fa5ff06f          	j	80001834 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

0000000080001894 <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    80001894:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80001898:	0017d513          	srli	a0,a5,0x1
    8000189c:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    800018a0:	0027d713          	srli	a4,a5,0x2
    800018a4:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    800018a8:	0047d713          	srli	a4,a5,0x4
    800018ac:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    800018b0:	0087d713          	srli	a4,a5,0x8
    800018b4:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    800018b8:	0107d713          	srli	a4,a5,0x10
    800018bc:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    800018c0:	0207d713          	srli	a4,a5,0x20
    800018c4:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    800018c8:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800018cc:	00000713          	li	a4,0
        while(num>1){
    800018d0:	00100693          	li	a3,1
    800018d4:	00f6f863          	bgeu	a3,a5,800018e4 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    800018d8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800018dc:	00170713          	addi	a4,a4,1
        while(num>1){
    800018e0:	ff1ff06f          	j	800018d0 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    800018e4:	ffb70713          	addi	a4,a4,-5
    800018e8:	00c00793          	li	a5,12
    800018ec:	04e7e063          	bltu	a5,a4,8000192c <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    800018f0:	ff010113          	addi	sp,sp,-16
    800018f4:	00113423          	sd	ra,8(sp)
    800018f8:	00813023          	sd	s0,0(sp)
    800018fc:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    80001900:	00371713          	slli	a4,a4,0x3
    80001904:	0000a797          	auipc	a5,0xa
    80001908:	74c78793          	addi	a5,a5,1868 # 8000c050 <_ZN13SlabAllocator5sizeNE>
    8000190c:	00e78733          	add	a4,a5,a4
    80001910:	00073503          	ld	a0,0(a4)
    80001914:	00000097          	auipc	ra,0x0
    80001918:	ee4080e7          	jalr	-284(ra) # 800017f8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    8000191c:	00813083          	ld	ra,8(sp)
    80001920:	00013403          	ld	s0,0(sp)
    80001924:	01010113          	addi	sp,sp,16
    80001928:	00008067          	ret
        return nullptr;
    8000192c:	00000513          	li	a0,0
}
    80001930:	00008067          	ret

0000000080001934 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80001934:	fc010113          	addi	sp,sp,-64
    80001938:	02113c23          	sd	ra,56(sp)
    8000193c:	02813823          	sd	s0,48(sp)
    80001940:	02913423          	sd	s1,40(sp)
    80001944:	03213023          	sd	s2,32(sp)
    80001948:	01313c23          	sd	s3,24(sp)
    8000194c:	01413823          	sd	s4,16(sp)
    80001950:	01513423          	sd	s5,8(sp)
    80001954:	04010413          	addi	s0,sp,64
    80001958:	00050913          	mv	s2,a0
    8000195c:	00058993          	mv	s3,a1
    80001960:	00060a93          	mv	s5,a2
    80001964:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001968:	0000a517          	auipc	a0,0xa
    8000196c:	75053503          	ld	a0,1872(a0) # 8000c0b8 <_ZN13SlabAllocator5cacheE>
    80001970:	00000097          	auipc	ra,0x0
    80001974:	e88080e7          	jalr	-376(ra) # 800017f8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001978:	00050493          	mv	s1,a0
    if(ret == nullptr)
    8000197c:	02050a63          	beqz	a0,800019b0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x7c>
    ret->ctor = ctor;
    80001980:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80001984:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80001988:	06053823          	sd	zero,112(a0)
    8000198c:	06053423          	sd	zero,104(a0)
    80001990:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80001994:	05353023          	sd	s3,64(a0)
    ret->slabSize = DEFAULT_SLAB_SIZE;
    80001998:	00200793          	li	a5,2
    8000199c:	04f53423          	sd	a5,72(a0)
    strcpy(name, ret->name);
    800019a0:	00050593          	mv	a1,a0
    800019a4:	00090513          	mv	a0,s2
    800019a8:	00003097          	auipc	ra,0x3
    800019ac:	658080e7          	jalr	1624(ra) # 80005000 <_Z6strcpyPKcPc>
}
    800019b0:	00048513          	mv	a0,s1
    800019b4:	03813083          	ld	ra,56(sp)
    800019b8:	03013403          	ld	s0,48(sp)
    800019bc:	02813483          	ld	s1,40(sp)
    800019c0:	02013903          	ld	s2,32(sp)
    800019c4:	01813983          	ld	s3,24(sp)
    800019c8:	01013a03          	ld	s4,16(sp)
    800019cc:	00813a83          	ld	s5,8(sp)
    800019d0:	04010113          	addi	sp,sp,64
    800019d4:	00008067          	ret

00000000800019d8 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    800019d8:	fe010113          	addi	sp,sp,-32
    800019dc:	00113c23          	sd	ra,24(sp)
    800019e0:	00813823          	sd	s0,16(sp)
    800019e4:	00913423          	sd	s1,8(sp)
    800019e8:	01213023          	sd	s2,0(sp)
    800019ec:	02010413          	addi	s0,sp,32
    800019f0:	00050913          	mv	s2,a0
    800019f4:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    800019f8:	00001097          	auipc	ra,0x1
    800019fc:	c78080e7          	jalr	-904(ra) # 80002670 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    80001a00:	0000a797          	auipc	a5,0xa
    80001a04:	65078793          	addi	a5,a5,1616 # 8000c050 <_ZN13SlabAllocator5sizeNE>
    80001a08:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    80001a0c:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80001a10:	0000a717          	auipc	a4,0xa
    80001a14:	56073703          	ld	a4,1376(a4) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001a18:	00073583          	ld	a1,0(a4)
    80001a1c:	00c5d593          	srli	a1,a1,0xc
    80001a20:	00158593          	addi	a1,a1,1
    80001a24:	00c59593          	slli	a1,a1,0xc
    80001a28:	06b7b423          	sd	a1,104(a5)
    cache->ctor = nullptr;
    80001a2c:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80001a30:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80001a34:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80001a38:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80001a3c:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80001a40:	07800793          	li	a5,120
    80001a44:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001a48:	00200793          	li	a5,2
    80001a4c:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001a50:	00007517          	auipc	a0,0x7
    80001a54:	71050513          	addi	a0,a0,1808 # 80009160 <CONSOLE_STATUS+0x150>
    80001a58:	00003097          	auipc	ra,0x3
    80001a5c:	5a8080e7          	jalr	1448(ra) # 80005000 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a60:	00000493          	li	s1,0
    80001a64:	0440006f          	j	80001aa8 <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a68:	00349913          	slli	s2,s1,0x3
    80001a6c:	0000a797          	auipc	a5,0xa
    80001a70:	33478793          	addi	a5,a5,820 # 8000bda0 <_ZN13SlabAllocator5namesE>
    80001a74:	012787b3          	add	a5,a5,s2
    80001a78:	00000693          	li	a3,0
    80001a7c:	00000613          	li	a2,0
    80001a80:	00200593          	li	a1,2
    80001a84:	009595bb          	sllw	a1,a1,s1
    80001a88:	0007b503          	ld	a0,0(a5)
    80001a8c:	00000097          	auipc	ra,0x0
    80001a90:	ea8080e7          	jalr	-344(ra) # 80001934 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a94:	0000a797          	auipc	a5,0xa
    80001a98:	5bc78793          	addi	a5,a5,1468 # 8000c050 <_ZN13SlabAllocator5sizeNE>
    80001a9c:	012787b3          	add	a5,a5,s2
    80001aa0:	00a7b023          	sd	a0,0(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80001aa4:	0014849b          	addiw	s1,s1,1
    80001aa8:	00c00793          	li	a5,12
    80001aac:	fa97dee3          	bge	a5,s1,80001a68 <_ZN13SlabAllocator10initializeEPvm+0x90>
}
    80001ab0:	01813083          	ld	ra,24(sp)
    80001ab4:	01013403          	ld	s0,16(sp)
    80001ab8:	00813483          	ld	s1,8(sp)
    80001abc:	00013903          	ld	s2,0(sp)
    80001ac0:	02010113          	addi	sp,sp,32
    80001ac4:	00008067          	ret

0000000080001ac8 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80001ac8:	02053783          	ld	a5,32(a0)
    80001acc:	0035d713          	srli	a4,a1,0x3
    80001ad0:	00e787b3          	add	a5,a5,a4
    80001ad4:	0007c683          	lbu	a3,0(a5)
    80001ad8:	fff5c593          	not	a1,a1
    80001adc:	0075f593          	andi	a1,a1,7
    80001ae0:	40b6d73b          	sraw	a4,a3,a1
    80001ae4:	00177713          	andi	a4,a4,1
    80001ae8:	0c070263          	beqz	a4,80001bac <_ZN13SlabAllocator8freeSlotEP4Slabm+0xe4>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001aec:	fe010113          	addi	sp,sp,-32
    80001af0:	00113c23          	sd	ra,24(sp)
    80001af4:	00813823          	sd	s0,16(sp)
    80001af8:	00913423          	sd	s1,8(sp)
    80001afc:	02010413          	addi	s0,sp,32
    80001b00:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80001b04:	00100713          	li	a4,1
    80001b08:	00b715bb          	sllw	a1,a4,a1
    80001b0c:	fff5c593          	not	a1,a1
    80001b10:	00d5f5b3          	and	a1,a1,a3
    80001b14:	00b78023          	sb	a1,0(a5)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001b18:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b1c:	04079a63          	bnez	a5,80001b70 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001b20:	03053503          	ld	a0,48(a0)
    80001b24:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001b28:	00178793          	addi	a5,a5,1
    80001b2c:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001b30:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b34:	04e78463          	beq	a5,a4,80001b7c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80001b38:	0304b583          	ld	a1,48(s1)
    80001b3c:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001b40:	04e78463          	beq	a5,a4,80001b88 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80001b44:	0005b703          	ld	a4,0(a1)
    80001b48:	00053783          	ld	a5,0(a0)
    80001b4c:	00f70863          	beq	a4,a5,80001b5c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001b50:	00048613          	mv	a2,s1
    80001b54:	00000097          	auipc	ra,0x0
    80001b58:	b60080e7          	jalr	-1184(ra) # 800016b4 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001b5c:	01813083          	ld	ra,24(sp)
    80001b60:	01013403          	ld	s0,16(sp)
    80001b64:	00813483          	ld	s1,8(sp)
    80001b68:	02010113          	addi	sp,sp,32
    80001b6c:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b70:	03053503          	ld	a0,48(a0)
    80001b74:	06850513          	addi	a0,a0,104
    80001b78:	fb1ff06f          	j	80001b28 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b7c:	0304b583          	ld	a1,48(s1)
    80001b80:	06058593          	addi	a1,a1,96
    80001b84:	fbdff06f          	j	80001b40 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80001b88:	00048593          	mv	a1,s1
    80001b8c:	00000097          	auipc	ra,0x0
    80001b90:	ad4080e7          	jalr	-1324(ra) # 80001660 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80001b94:	0304b783          	ld	a5,48(s1)
    80001b98:	0487b583          	ld	a1,72(a5)
    80001b9c:	00048513          	mv	a0,s1
    80001ba0:	00001097          	auipc	ra,0x1
    80001ba4:	dc8080e7          	jalr	-568(ra) # 80002968 <_ZN5Buddy4freeEPvm>
    80001ba8:	fb5ff06f          	j	80001b5c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001bac:	00008067          	ret

0000000080001bb0 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001bb0:	fe010113          	addi	sp,sp,-32
    80001bb4:	00113c23          	sd	ra,24(sp)
    80001bb8:	00813823          	sd	s0,16(sp)
    80001bbc:	00913423          	sd	s1,8(sp)
    80001bc0:	01213023          	sd	s2,0(sp)
    80001bc4:	02010413          	addi	s0,sp,32
    80001bc8:	00050913          	mv	s2,a0
    80001bcc:	00058493          	mv	s1,a1
    if(cache->dtor)
    80001bd0:	05853783          	ld	a5,88(a0)
    80001bd4:	00078663          	beqz	a5,80001be0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80001bd8:	00058513          	mv	a0,a1
    80001bdc:	000780e7          	jalr	a5
    if(cache->ctor)
    80001be0:	05093783          	ld	a5,80(s2)
    80001be4:	00078663          	beqz	a5,80001bf0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80001be8:	00048513          	mv	a0,s1
    80001bec:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001bf0:	07093503          	ld	a0,112(s2)
    80001bf4:	0080006f          	j	80001bfc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001bf8:	00853503          	ld	a0,8(a0)
        while(head){
    80001bfc:	02050e63          	beqz	a0,80001c38 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001c00:	02853703          	ld	a4,40(a0)
    80001c04:	01853783          	ld	a5,24(a0)
    80001c08:	03053683          	ld	a3,48(a0)
    80001c0c:	0406b583          	ld	a1,64(a3)
    80001c10:	02b787b3          	mul	a5,a5,a1
    80001c14:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c18:	fef4f0e3          	bgeu	s1,a5,80001bf8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80001c1c:	fce4eee3          	bltu	s1,a4,80001bf8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c20:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80001c24:	02b755b3          	divu	a1,a4,a1
    80001c28:	00000097          	auipc	ra,0x0
    80001c2c:	ea0080e7          	jalr	-352(ra) # 80001ac8 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c30:	00100513          	li	a0,1
    80001c34:	0080006f          	j	80001c3c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80001c38:	00000513          	li	a0,0
    if(deleted)
    80001c3c:	00050e63          	beqz	a0,80001c58 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80001c40:	01813083          	ld	ra,24(sp)
    80001c44:	01013403          	ld	s0,16(sp)
    80001c48:	00813483          	ld	s1,8(sp)
    80001c4c:	00013903          	ld	s2,0(sp)
    80001c50:	02010113          	addi	sp,sp,32
    80001c54:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001c58:	06893783          	ld	a5,104(s2)
    80001c5c:	0080006f          	j	80001c64 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80001c60:	0087b783          	ld	a5,8(a5)
        while(head){
    80001c64:	fc078ee3          	beqz	a5,80001c40 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001c68:	0287b683          	ld	a3,40(a5)
    80001c6c:	0187b703          	ld	a4,24(a5)
    80001c70:	0307b603          	ld	a2,48(a5)
    80001c74:	04063583          	ld	a1,64(a2)
    80001c78:	02b70733          	mul	a4,a4,a1
    80001c7c:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c80:	fee4f0e3          	bgeu	s1,a4,80001c60 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80001c84:	fcd4eee3          	bltu	s1,a3,80001c60 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c88:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001c8c:	02b6d5b3          	divu	a1,a3,a1
    80001c90:	00078513          	mv	a0,a5
    80001c94:	00000097          	auipc	ra,0x0
    80001c98:	e34080e7          	jalr	-460(ra) # 80001ac8 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c9c:	00100513          	li	a0,1
    80001ca0:	fa1ff06f          	j	80001c40 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080001ca4 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001ca4:	fe010113          	addi	sp,sp,-32
    80001ca8:	00113c23          	sd	ra,24(sp)
    80001cac:	00813823          	sd	s0,16(sp)
    80001cb0:	00913423          	sd	s1,8(sp)
    80001cb4:	01213023          	sd	s2,0(sp)
    80001cb8:	02010413          	addi	s0,sp,32
    80001cbc:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001cc0:	00000493          	li	s1,0
    80001cc4:	00c00793          	li	a5,12
    80001cc8:	0297c863          	blt	a5,s1,80001cf8 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001ccc:	00349713          	slli	a4,s1,0x3
    80001cd0:	0000a797          	auipc	a5,0xa
    80001cd4:	38078793          	addi	a5,a5,896 # 8000c050 <_ZN13SlabAllocator5sizeNE>
    80001cd8:	00e787b3          	add	a5,a5,a4
    80001cdc:	00090593          	mv	a1,s2
    80001ce0:	0007b503          	ld	a0,0(a5)
    80001ce4:	00000097          	auipc	ra,0x0
    80001ce8:	ecc080e7          	jalr	-308(ra) # 80001bb0 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001cec:	00051663          	bnez	a0,80001cf8 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001cf0:	0014849b          	addiw	s1,s1,1
    80001cf4:	fd1ff06f          	j	80001cc4 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001cf8:	01813083          	ld	ra,24(sp)
    80001cfc:	01013403          	ld	s0,16(sp)
    80001d00:	00813483          	ld	s1,8(sp)
    80001d04:	00013903          	ld	s2,0(sp)
    80001d08:	02010113          	addi	sp,sp,32
    80001d0c:	00008067          	ret

0000000080001d10 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001d10:	fe010113          	addi	sp,sp,-32
    80001d14:	00113c23          	sd	ra,24(sp)
    80001d18:	00813823          	sd	s0,16(sp)
    80001d1c:	00913423          	sd	s1,8(sp)
    80001d20:	01213023          	sd	s2,0(sp)
    80001d24:	02010413          	addi	s0,sp,32
    80001d28:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001d2c:	00053903          	ld	s2,0(a0)
    80001d30:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001d34:	00093503          	ld	a0,0(s2)
    80001d38:	02050263          	beqz	a0,80001d5c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80001d3c:	03053783          	ld	a5,48(a0)
    80001d40:	0487b583          	ld	a1,72(a5)
    80001d44:	00001097          	auipc	ra,0x1
    80001d48:	c24080e7          	jalr	-988(ra) # 80002968 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d4c:	00093783          	ld	a5,0(s2)
    80001d50:	0087b783          	ld	a5,8(a5)
    80001d54:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d58:	fddff06f          	j	80001d34 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001d5c:	0004b903          	ld	s2,0(s1)
    80001d60:	06890913          	addi	s2,s2,104
    80001d64:	00093503          	ld	a0,0(s2)
    80001d68:	02050263          	beqz	a0,80001d8c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80001d6c:	03053783          	ld	a5,48(a0)
    80001d70:	0487b583          	ld	a1,72(a5)
    80001d74:	00001097          	auipc	ra,0x1
    80001d78:	bf4080e7          	jalr	-1036(ra) # 80002968 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d7c:	00093783          	ld	a5,0(s2)
    80001d80:	0087b783          	ld	a5,8(a5)
    80001d84:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d88:	fddff06f          	j	80001d64 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001d8c:	0004b903          	ld	s2,0(s1)
    80001d90:	06090913          	addi	s2,s2,96
    80001d94:	00093503          	ld	a0,0(s2)
    80001d98:	02050263          	beqz	a0,80001dbc <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80001d9c:	03053783          	ld	a5,48(a0)
    80001da0:	0487b583          	ld	a1,72(a5)
    80001da4:	00001097          	auipc	ra,0x1
    80001da8:	bc4080e7          	jalr	-1084(ra) # 80002968 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001dac:	00093783          	ld	a5,0(s2)
    80001db0:	0087b783          	ld	a5,8(a5)
    80001db4:	00f93023          	sd	a5,0(s2)
        while(head){
    80001db8:	fddff06f          	j	80001d94 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001dbc:	0004b583          	ld	a1,0(s1)
    80001dc0:	0000a517          	auipc	a0,0xa
    80001dc4:	2f853503          	ld	a0,760(a0) # 8000c0b8 <_ZN13SlabAllocator5cacheE>
    80001dc8:	00000097          	auipc	ra,0x0
    80001dcc:	de8080e7          	jalr	-536(ra) # 80001bb0 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001dd0:	0004b023          	sd	zero,0(s1)
}
    80001dd4:	01813083          	ld	ra,24(sp)
    80001dd8:	01013403          	ld	s0,16(sp)
    80001ddc:	00813483          	ld	s1,8(sp)
    80001de0:	00013903          	ld	s2,0(sp)
    80001de4:	02010113          	addi	sp,sp,32
    80001de8:	00008067          	ret

0000000080001dec <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001dec:	ff010113          	addi	sp,sp,-16
    80001df0:	00813423          	sd	s0,8(sp)
    80001df4:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001df8:	03f50513          	addi	a0,a0,63
    80001dfc:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001e00:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001e04:	00100513          	li	a0,1
    asm("ecall");
    80001e08:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001e0c:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001e10:	00813403          	ld	s0,8(sp)
    80001e14:	01010113          	addi	sp,sp,16
    80001e18:	00008067          	ret

0000000080001e1c <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001e1c:	ff010113          	addi	sp,sp,-16
    80001e20:	00813423          	sd	s0,8(sp)
    80001e24:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001e28:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001e2c:	00200513          	li	a0,2
    asm("ecall");
    80001e30:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e34:	00050513          	mv	a0,a0
    return status;
}
    80001e38:	0005051b          	sext.w	a0,a0
    80001e3c:	00813403          	ld	s0,8(sp)
    80001e40:	01010113          	addi	sp,sp,16
    80001e44:	00008067          	ret

0000000080001e48 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    80001e48:	fd010113          	addi	sp,sp,-48
    80001e4c:	02113423          	sd	ra,40(sp)
    80001e50:	02813023          	sd	s0,32(sp)
    80001e54:	00913c23          	sd	s1,24(sp)
    80001e58:	01213823          	sd	s2,16(sp)
    80001e5c:	01313423          	sd	s3,8(sp)
    80001e60:	03010413          	addi	s0,sp,48
    80001e64:	00050913          	mv	s2,a0
    80001e68:	00058493          	mv	s1,a1
    80001e6c:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    80001e70:	04058e63          	beqz	a1,80001ecc <_Z13thread_createPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001e74:	00001537          	lui	a0,0x1
    80001e78:	00000097          	auipc	ra,0x0
    80001e7c:	f74080e7          	jalr	-140(ra) # 80001dec <_Z9mem_allocm>
        if(istack == 0) {
    80001e80:	04050063          	beqz	a0,80001ec0 <_Z13thread_createPP7_threadPFvPvES2_+0x78>
            *handle = nullptr;
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001e84:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001e88:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001e8c:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001e90:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80001e94:	01100513          	li	a0,17

    asm("ecall");
    80001e98:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e9c:	00050513          	mv	a0,a0

    return status;
    80001ea0:	0005051b          	sext.w	a0,a0
}
    80001ea4:	02813083          	ld	ra,40(sp)
    80001ea8:	02013403          	ld	s0,32(sp)
    80001eac:	01813483          	ld	s1,24(sp)
    80001eb0:	01013903          	ld	s2,16(sp)
    80001eb4:	00813983          	ld	s3,8(sp)
    80001eb8:	03010113          	addi	sp,sp,48
    80001ebc:	00008067          	ret
            *handle = nullptr;
    80001ec0:	00093023          	sd	zero,0(s2)
            return -1;
    80001ec4:	fff00513          	li	a0,-1
    80001ec8:	fddff06f          	j	80001ea4 <_Z13thread_createPP7_threadPFvPvES2_+0x5c>
    uint64 istack = 0;
    80001ecc:	00000513          	li	a0,0
    80001ed0:	fb5ff06f          	j	80001e84 <_Z13thread_createPP7_threadPFvPvES2_+0x3c>

0000000080001ed4 <_Z11thread_exitv>:

int thread_exit(){
    80001ed4:	ff010113          	addi	sp,sp,-16
    80001ed8:	00813423          	sd	s0,8(sp)
    80001edc:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001ee0:	01200513          	li	a0,18

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

0000000080001efc <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001efc:	ff010113          	addi	sp,sp,-16
    80001f00:	00813423          	sd	s0,8(sp)
    80001f04:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001f08:	01300513          	li	a0,19

    asm("ecall");
    80001f0c:	00000073          	ecall
}
    80001f10:	00813403          	ld	s0,8(sp)
    80001f14:	01010113          	addi	sp,sp,16
    80001f18:	00008067          	ret

0000000080001f1c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001f1c:	fd010113          	addi	sp,sp,-48
    80001f20:	02113423          	sd	ra,40(sp)
    80001f24:	02813023          	sd	s0,32(sp)
    80001f28:	00913c23          	sd	s1,24(sp)
    80001f2c:	01213823          	sd	s2,16(sp)
    80001f30:	01313423          	sd	s3,8(sp)
    80001f34:	03010413          	addi	s0,sp,48
    80001f38:	00050493          	mv	s1,a0
    80001f3c:	00058913          	mv	s2,a1
    80001f40:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(handle && start_routine) {
    80001f44:	04050a63          	beqz	a0,80001f98 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x7c>
    80001f48:	04058c63          	beqz	a1,80001fa0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001f4c:	00001537          	lui	a0,0x1
    80001f50:	00000097          	auipc	ra,0x0
    80001f54:	e9c080e7          	jalr	-356(ra) # 80001dec <_Z9mem_allocm>
        if(istack == 0) {
    80001f58:	04050863          	beqz	a0,80001fa8 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x8c>
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001f5c:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001f60:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001f64:	00090613          	mv	a2,s2
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f68:	00048593          	mv	a1,s1
    asm("li a0, 0x14");
    80001f6c:	01400513          	li	a0,20

    asm("ecall");
    80001f70:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f74:	00050513          	mv	a0,a0

    return status;
    80001f78:	0005051b          	sext.w	a0,a0
}
    80001f7c:	02813083          	ld	ra,40(sp)
    80001f80:	02013403          	ld	s0,32(sp)
    80001f84:	01813483          	ld	s1,24(sp)
    80001f88:	01013903          	ld	s2,16(sp)
    80001f8c:	00813983          	ld	s3,8(sp)
    80001f90:	03010113          	addi	sp,sp,48
    80001f94:	00008067          	ret
    uint64 istack = 0;
    80001f98:	00000513          	li	a0,0
    80001f9c:	fc1ff06f          	j	80001f5c <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
    80001fa0:	00000513          	li	a0,0
    80001fa4:	fb9ff06f          	j	80001f5c <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
            return -1;
    80001fa8:	fff00513          	li	a0,-1
    80001fac:	fd1ff06f          	j	80001f7c <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x60>

0000000080001fb0 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    80001fb0:	ff010113          	addi	sp,sp,-16
    80001fb4:	00813423          	sd	s0,8(sp)
    80001fb8:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;
    if(handle == nullptr)
    80001fbc:	02050263          	beqz	a0,80001fe0 <_Z12thread_startP7_thread+0x30>
        return -1;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001fc0:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001fc4:	01500513          	li	a0,21

    asm("ecall");
    80001fc8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fcc:	00050513          	mv	a0,a0

    return status;
    80001fd0:	0005051b          	sext.w	a0,a0
}
    80001fd4:	00813403          	ld	s0,8(sp)
    80001fd8:	01010113          	addi	sp,sp,16
    80001fdc:	00008067          	ret
        return -1;
    80001fe0:	fff00513          	li	a0,-1
    80001fe4:	ff1ff06f          	j	80001fd4 <_Z12thread_startP7_thread+0x24>

0000000080001fe8 <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    80001fe8:	ff010113          	addi	sp,sp,-16
    80001fec:	00813423          	sd	s0,8(sp)
    80001ff0:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001ff4:	02059593          	slli	a1,a1,0x20
    80001ff8:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001ffc:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80002000:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80002004:	02100513          	li	a0,33


    asm("ecall");
    80002008:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000200c:	00050513          	mv	a0,a0

    return status;

}
    80002010:	0005051b          	sext.w	a0,a0
    80002014:	00813403          	ld	s0,8(sp)
    80002018:	01010113          	addi	sp,sp,16
    8000201c:	00008067          	ret

0000000080002020 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80002020:	ff010113          	addi	sp,sp,-16
    80002024:	00813423          	sd	s0,8(sp)
    80002028:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000202c:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80002030:	02200513          	li	a0,34


    asm("ecall");
    80002034:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002038:	00050513          	mv	a0,a0

    return status;
}
    8000203c:	0005051b          	sext.w	a0,a0
    80002040:	00813403          	ld	s0,8(sp)
    80002044:	01010113          	addi	sp,sp,16
    80002048:	00008067          	ret

000000008000204c <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    8000204c:	ff010113          	addi	sp,sp,-16
    80002050:	00813423          	sd	s0,8(sp)
    80002054:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80002058:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    8000205c:	02300513          	li	a0,35


    asm("ecall");
    80002060:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002064:	00050513          	mv	a0,a0

    return status;
}
    80002068:	0005051b          	sext.w	a0,a0
    8000206c:	00813403          	ld	s0,8(sp)
    80002070:	01010113          	addi	sp,sp,16
    80002074:	00008067          	ret

0000000080002078 <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    80002078:	ff010113          	addi	sp,sp,-16
    8000207c:	00813423          	sd	s0,8(sp)
    80002080:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80002084:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    80002088:	02400513          	li	a0,36


    asm("ecall");
    8000208c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002090:	00050513          	mv	a0,a0

    return status;
}
    80002094:	0005051b          	sext.w	a0,a0
    80002098:	00813403          	ld	s0,8(sp)
    8000209c:	01010113          	addi	sp,sp,16
    800020a0:	00008067          	ret

00000000800020a4 <_Z10time_sleepm>:

int time_sleep(time_t time){
    800020a4:	ff010113          	addi	sp,sp,-16
    800020a8:	00813423          	sd	s0,8(sp)
    800020ac:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    800020b0:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    800020b4:	03100513          	li	a0,49


    asm("ecall");
    800020b8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800020bc:	00050513          	mv	a0,a0

    return status;
}
    800020c0:	0005051b          	sext.w	a0,a0
    800020c4:	00813403          	ld	s0,8(sp)
    800020c8:	01010113          	addi	sp,sp,16
    800020cc:	00008067          	ret

00000000800020d0 <_Z4getcv>:

char getc(){
    800020d0:	ff010113          	addi	sp,sp,-16
    800020d4:	00813423          	sd	s0,8(sp)
    800020d8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    800020dc:	04100513          	li	a0,65

    asm("ecall");
    800020e0:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    800020e4:	00050513          	mv	a0,a0

    return c;
}
    800020e8:	0ff57513          	andi	a0,a0,255
    800020ec:	00813403          	ld	s0,8(sp)
    800020f0:	01010113          	addi	sp,sp,16
    800020f4:	00008067          	ret

00000000800020f8 <_Z4putcc>:

void putc(char c){
    800020f8:	ff010113          	addi	sp,sp,-16
    800020fc:	00813423          	sd	s0,8(sp)
    80002100:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    80002104:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    80002108:	04200513          	li	a0,66

    asm("ecall");
    8000210c:	00000073          	ecall
}
    80002110:	00813403          	ld	s0,8(sp)
    80002114:	01010113          	addi	sp,sp,16
    80002118:	00008067          	ret

000000008000211c <_Z4forkv>:


int fork(){
    8000211c:	ff010113          	addi	sp,sp,-16
    80002120:	00813423          	sd	s0,8(sp)
    80002124:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    80002128:	06100513          	li	a0,97

    asm("ecall");
    8000212c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002130:	00050513          	mv	a0,a0

    return status;
}
    80002134:	0005051b          	sext.w	a0,a0
    80002138:	00813403          	ld	s0,8(sp)
    8000213c:	01010113          	addi	sp,sp,16
    80002140:	00008067          	ret

0000000080002144 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80002144:	ff010113          	addi	sp,sp,-16
    80002148:	00113423          	sd	ra,8(sp)
    8000214c:	00813023          	sd	s0,0(sp)
    80002150:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80002154:	00000097          	auipc	ra,0x0
    80002158:	ecc080e7          	jalr	-308(ra) # 80002020 <_Z9sem_closeP10_semaphore>
}
    8000215c:	00813083          	ld	ra,8(sp)
    80002160:	00013403          	ld	s0,0(sp)
    80002164:	01010113          	addi	sp,sp,16
    80002168:	00008067          	ret

000000008000216c <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    8000216c:	ff010113          	addi	sp,sp,-16
    80002170:	00113423          	sd	ra,8(sp)
    80002174:	00813023          	sd	s0,0(sp)
    80002178:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    8000217c:	00001097          	auipc	ra,0x1
    80002180:	33c080e7          	jalr	828(ra) # 800034b8 <_ZN3TCB11thread_freeEPv>
    80002184:	00813083          	ld	ra,8(sp)
    80002188:	00013403          	ld	s0,0(sp)
    8000218c:	01010113          	addi	sp,sp,16
    80002190:	00008067          	ret

0000000080002194 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80002194:	ff010113          	addi	sp,sp,-16
    80002198:	00813423          	sd	s0,8(sp)
    8000219c:	01010413          	addi	s0,sp,16
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
//    userMain();
    800021a0:	00813403          	ld	s0,8(sp)
    800021a4:	01010113          	addi	sp,sp,16
    800021a8:	00008067          	ret

00000000800021ac <_Z6memsetPKvii>:
                                    "tc_1",
                                    "tc_2",
                                    "tc_3",
                                    "tc_4"};

void memset(const void *data, int size, int value) {
    800021ac:	ff010113          	addi	sp,sp,-16
    800021b0:	00813423          	sd	s0,8(sp)
    800021b4:	01010413          	addi	s0,sp,16
    for (int j = 0; j < size; j++) {
    800021b8:	00000793          	li	a5,0
    800021bc:	00b7d863          	bge	a5,a1,800021cc <_Z6memsetPKvii+0x20>
        *(char *)data = value;
    800021c0:	00c50023          	sb	a2,0(a0) # 1000 <_entry-0x7ffff000>
    for (int j = 0; j < size; j++) {
    800021c4:	0017879b          	addiw	a5,a5,1
    800021c8:	ff5ff06f          	j	800021bc <_Z6memsetPKvii+0x10>
    }
}
    800021cc:	00813403          	ld	s0,8(sp)
    800021d0:	01010113          	addi	sp,sp,16
    800021d4:	00008067          	ret

00000000800021d8 <_Z9constructPv>:

void construct(void *data) {
    800021d8:	fe010113          	addi	sp,sp,-32
    800021dc:	00113c23          	sd	ra,24(sp)
    800021e0:	00813823          	sd	s0,16(sp)
    800021e4:	00913423          	sd	s1,8(sp)
    800021e8:	02010413          	addi	s0,sp,32
    800021ec:	00050493          	mv	s1,a0
    static int i = 1;
    ConsoleUtil::print("", i++," Shared object constructed.\n");
    800021f0:	0000a797          	auipc	a5,0xa
    800021f4:	c1878793          	addi	a5,a5,-1000 # 8000be08 <_ZZ9constructPvE1i>
    800021f8:	0007a583          	lw	a1,0(a5)
    800021fc:	0015871b          	addiw	a4,a1,1
    80002200:	00e7a023          	sw	a4,0(a5)
    80002204:	01000693          	li	a3,16
    80002208:	00007617          	auipc	a2,0x7
    8000220c:	0a060613          	addi	a2,a2,160 # 800092a8 <CONSOLE_STATUS+0x298>
    80002210:	00007517          	auipc	a0,0x7
    80002214:	1f050513          	addi	a0,a0,496 # 80009400 <CONSOLE_STATUS+0x3f0>
    80002218:	00003097          	auipc	ra,0x3
    8000221c:	484080e7          	jalr	1156(ra) # 8000569c <_ZN11ConsoleUtil5printEPKciS1_i>
    memset(data, shared_size, MASK);
    80002220:	0a500613          	li	a2,165
    80002224:	00700593          	li	a1,7
    80002228:	00048513          	mv	a0,s1
    8000222c:	00000097          	auipc	ra,0x0
    80002230:	f80080e7          	jalr	-128(ra) # 800021ac <_Z6memsetPKvii>
}
    80002234:	01813083          	ld	ra,24(sp)
    80002238:	01013403          	ld	s0,16(sp)
    8000223c:	00813483          	ld	s1,8(sp)
    80002240:	02010113          	addi	sp,sp,32
    80002244:	00008067          	ret

0000000080002248 <_Z5checkPvm>:

int check(void *data, size_t size) {
    80002248:	ff010113          	addi	sp,sp,-16
    8000224c:	00813423          	sd	s0,8(sp)
    80002250:	01010413          	addi	s0,sp,16
    80002254:	00050613          	mv	a2,a0
    int ret = 1;
    for (uint64 i = 0; i < size; i++) {
    80002258:	00000793          	li	a5,0
    int ret = 1;
    8000225c:	00100513          	li	a0,1
    80002260:	0080006f          	j	80002268 <_Z5checkPvm+0x20>
    for (uint64 i = 0; i < size; i++) {
    80002264:	00178793          	addi	a5,a5,1
    80002268:	00b7fe63          	bgeu	a5,a1,80002284 <_Z5checkPvm+0x3c>
        if (((unsigned char *)data)[i] != MASK) {
    8000226c:	00f60733          	add	a4,a2,a5
    80002270:	00074683          	lbu	a3,0(a4)
    80002274:	0a500713          	li	a4,165
    80002278:	fee686e3          	beq	a3,a4,80002264 <_Z5checkPvm+0x1c>
            ret = 0;
    8000227c:	00000513          	li	a0,0
    80002280:	fe5ff06f          	j	80002264 <_Z5checkPvm+0x1c>
        }
    }

    return ret;
}
    80002284:	00813403          	ld	s0,8(sp)
    80002288:	01010113          	addi	sp,sp,16
    8000228c:	00008067          	ret

0000000080002290 <_Z4workPv>:
struct objects_s {
    kmem_cache_t *cache;
    void *data;
};

void work(void* pdata) {
    80002290:	f8010113          	addi	sp,sp,-128
    80002294:	06113c23          	sd	ra,120(sp)
    80002298:	06813823          	sd	s0,112(sp)
    8000229c:	06913423          	sd	s1,104(sp)
    800022a0:	07213023          	sd	s2,96(sp)
    800022a4:	05313c23          	sd	s3,88(sp)
    800022a8:	05413823          	sd	s4,80(sp)
    800022ac:	05513423          	sd	s5,72(sp)
    800022b0:	05613023          	sd	s6,64(sp)
    800022b4:	03713c23          	sd	s7,56(sp)
    800022b8:	03813823          	sd	s8,48(sp)
    800022bc:	03913423          	sd	s9,40(sp)
    800022c0:	08010413          	addi	s0,sp,128
    struct data_s data = *(struct data_s*) pdata;
    800022c4:	00053c03          	ld	s8,0(a0)
    800022c8:	f9843423          	sd	s8,-120(s0)
    800022cc:	00853783          	ld	a5,8(a0)
    800022d0:	f8f43823          	sd	a5,-112(s0)
    800022d4:	01053783          	ld	a5,16(a0)
    800022d8:	f8f43c23          	sd	a5,-104(s0)
    int size = 0;
    int object_size = data.id + 1;
    800022dc:	000c079b          	sext.w	a5,s8
    800022e0:	001c0c1b          	addiw	s8,s8,1
    kmem_cache_t *cache = kmem_cache_create(CACHE_NAMES[data.id], object_size, 0, 0);
    800022e4:	00379713          	slli	a4,a5,0x3
    800022e8:	0000a797          	auipc	a5,0xa
    800022ec:	b2878793          	addi	a5,a5,-1240 # 8000be10 <_ZL11CACHE_NAMES>
    800022f0:	00e787b3          	add	a5,a5,a4
    800022f4:	000c0b13          	mv	s6,s8
    800022f8:	00000693          	li	a3,0
    800022fc:	00000613          	li	a2,0
    80002300:	000c0593          	mv	a1,s8
    80002304:	0007b503          	ld	a0,0(a5)
    80002308:	00003097          	auipc	ra,0x3
    8000230c:	450080e7          	jalr	1104(ra) # 80005758 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002310:	00050a13          	mv	s4,a0

    struct objects_s *objs = (struct objects_s*)(kmalloc(sizeof(struct objects_s) * data.iterations));
    80002314:	f9842b83          	lw	s7,-104(s0)
    80002318:	004b9513          	slli	a0,s7,0x4
    8000231c:	00003097          	auipc	ra,0x3
    80002320:	534080e7          	jalr	1332(ra) # 80005850 <_Z7kmallocm>
    80002324:	00050a93          	mv	s5,a0

    for (int i = 0; i < data.iterations; i++) {
    80002328:	00000493          	li	s1,0
    int size = 0;
    8000232c:	00000993          	li	s3,0
    80002330:	0380006f          	j	80002368 <_Z4workPv+0xd8>
            if (!check(objs[size].data, shared_size)) {
                ConsoleUtil::printString("Value not correct!");
            }
        }
        else {
            objs[size].data = kmem_cache_alloc(cache);
    80002334:	00499913          	slli	s2,s3,0x4
    80002338:	012a8933          	add	s2,s5,s2
    8000233c:	000a0513          	mv	a0,s4
    80002340:	00003097          	auipc	ra,0x3
    80002344:	440080e7          	jalr	1088(ra) # 80005780 <_Z16kmem_cache_allocP5Cache>
    80002348:	00a93423          	sd	a0,8(s2)
            objs[size].cache = cache;
    8000234c:	01493023          	sd	s4,0(s2)
            memset(objs[size].data, object_size, MASK);
    80002350:	0a500613          	li	a2,165
    80002354:	000c0593          	mv	a1,s8
    80002358:	00000097          	auipc	ra,0x0
    8000235c:	e54080e7          	jalr	-428(ra) # 800021ac <_Z6memsetPKvii>
        }
        size++;
    80002360:	0019899b          	addiw	s3,s3,1
    for (int i = 0; i < data.iterations; i++) {
    80002364:	0014849b          	addiw	s1,s1,1
    80002368:	0574da63          	bge	s1,s7,800023bc <_Z4workPv+0x12c>
        if (i % 100 == 0) {
    8000236c:	06400793          	li	a5,100
    80002370:	02f4e7bb          	remw	a5,s1,a5
    80002374:	fc0790e3          	bnez	a5,80002334 <_Z4workPv+0xa4>
            objs[size].data = kmem_cache_alloc(data.shared);
    80002378:	f9043c83          	ld	s9,-112(s0)
    8000237c:	00499913          	slli	s2,s3,0x4
    80002380:	012a8933          	add	s2,s5,s2
    80002384:	000c8513          	mv	a0,s9
    80002388:	00003097          	auipc	ra,0x3
    8000238c:	3f8080e7          	jalr	1016(ra) # 80005780 <_Z16kmem_cache_allocP5Cache>
    80002390:	00a93423          	sd	a0,8(s2)
            objs[size].cache = data.shared;
    80002394:	01993023          	sd	s9,0(s2)
            if (!check(objs[size].data, shared_size)) {
    80002398:	00700593          	li	a1,7
    8000239c:	00000097          	auipc	ra,0x0
    800023a0:	eac080e7          	jalr	-340(ra) # 80002248 <_Z5checkPvm>
    800023a4:	fa051ee3          	bnez	a0,80002360 <_Z4workPv+0xd0>
                ConsoleUtil::printString("Value not correct!");
    800023a8:	00007517          	auipc	a0,0x7
    800023ac:	f2050513          	addi	a0,a0,-224 # 800092c8 <CONSOLE_STATUS+0x2b8>
    800023b0:	00003097          	auipc	ra,0x3
    800023b4:	1cc080e7          	jalr	460(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    800023b8:	fa9ff06f          	j	80002360 <_Z4workPv+0xd0>
    }

    kmem_cache_info(cache);
    800023bc:	000a0513          	mv	a0,s4
    800023c0:	00003097          	auipc	ra,0x3
    800023c4:	440080e7          	jalr	1088(ra) # 80005800 <_Z15kmem_cache_infoP5Cache>
    kmem_cache_info(data.shared);
    800023c8:	f9043503          	ld	a0,-112(s0)
    800023cc:	00003097          	auipc	ra,0x3
    800023d0:	434080e7          	jalr	1076(ra) # 80005800 <_Z15kmem_cache_infoP5Cache>

    for (int i = 0; i < size; i++) {
    800023d4:	00000913          	li	s2,0
    800023d8:	0300006f          	j	80002408 <_Z4workPv+0x178>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    800023dc:	000b0593          	mv	a1,s6
    800023e0:	0440006f          	j	80002424 <_Z4workPv+0x194>
            ConsoleUtil::printString("Value not correct!");
    800023e4:	00007517          	auipc	a0,0x7
    800023e8:	ee450513          	addi	a0,a0,-284 # 800092c8 <CONSOLE_STATUS+0x2b8>
    800023ec:	00003097          	auipc	ra,0x3
    800023f0:	190080e7          	jalr	400(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        }
        kmem_cache_free(objs[i].cache, objs[i].data);
    800023f4:	0084b583          	ld	a1,8(s1)
    800023f8:	0004b503          	ld	a0,0(s1)
    800023fc:	00003097          	auipc	ra,0x3
    80002400:	3ac080e7          	jalr	940(ra) # 800057a8 <_Z15kmem_cache_freeP5CachePv>
    for (int i = 0; i < size; i++) {
    80002404:	0019091b          	addiw	s2,s2,1
    80002408:	03395663          	bge	s2,s3,80002434 <_Z4workPv+0x1a4>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    8000240c:	00491493          	slli	s1,s2,0x4
    80002410:	009a84b3          	add	s1,s5,s1
    80002414:	0084b503          	ld	a0,8(s1)
    80002418:	0004b783          	ld	a5,0(s1)
    8000241c:	fd4780e3          	beq	a5,s4,800023dc <_Z4workPv+0x14c>
    80002420:	00700593          	li	a1,7
    80002424:	00000097          	auipc	ra,0x0
    80002428:	e24080e7          	jalr	-476(ra) # 80002248 <_Z5checkPvm>
    8000242c:	fc0514e3          	bnez	a0,800023f4 <_Z4workPv+0x164>
    80002430:	fb5ff06f          	j	800023e4 <_Z4workPv+0x154>
    }

    kfree(objs);
    80002434:	000a8513          	mv	a0,s5
    80002438:	00003097          	auipc	ra,0x3
    8000243c:	440080e7          	jalr	1088(ra) # 80005878 <_Z5kfreePKv>
    kmem_cache_destroy(cache);
    80002440:	000a0513          	mv	a0,s4
    80002444:	00003097          	auipc	ra,0x3
    80002448:	38c080e7          	jalr	908(ra) # 800057d0 <_Z18kmem_cache_destroyP5Cache>
}
    8000244c:	07813083          	ld	ra,120(sp)
    80002450:	07013403          	ld	s0,112(sp)
    80002454:	06813483          	ld	s1,104(sp)
    80002458:	06013903          	ld	s2,96(sp)
    8000245c:	05813983          	ld	s3,88(sp)
    80002460:	05013a03          	ld	s4,80(sp)
    80002464:	04813a83          	ld	s5,72(sp)
    80002468:	04013b03          	ld	s6,64(sp)
    8000246c:	03813b83          	ld	s7,56(sp)
    80002470:	03013c03          	ld	s8,48(sp)
    80002474:	02813c83          	ld	s9,40(sp)
    80002478:	08010113          	addi	sp,sp,128
    8000247c:	00008067          	ret

0000000080002480 <_Z4runsPFvPvEP6data_si>:



void runs(void(*work)(void*), struct data_s* data, int num) {
    80002480:	fb010113          	addi	sp,sp,-80
    80002484:	04113423          	sd	ra,72(sp)
    80002488:	04813023          	sd	s0,64(sp)
    8000248c:	02913c23          	sd	s1,56(sp)
    80002490:	03213823          	sd	s2,48(sp)
    80002494:	03313423          	sd	s3,40(sp)
    80002498:	03413023          	sd	s4,32(sp)
    8000249c:	05010413          	addi	s0,sp,80
    800024a0:	00050a13          	mv	s4,a0
    800024a4:	00058913          	mv	s2,a1
    800024a8:	00060993          	mv	s3,a2
    for (int i = 0; i < num; i++) {
    800024ac:	00000493          	li	s1,0
    800024b0:	0334d863          	bge	s1,s3,800024e0 <_Z4runsPFvPvEP6data_si+0x60>
        struct data_s private_data;
        private_data = *(struct data_s*) data;
    800024b4:	00093783          	ld	a5,0(s2)
    800024b8:	faf43c23          	sd	a5,-72(s0)
    800024bc:	00893783          	ld	a5,8(s2)
    800024c0:	fcf43023          	sd	a5,-64(s0)
    800024c4:	01093783          	ld	a5,16(s2)
    800024c8:	fcf43423          	sd	a5,-56(s0)
        private_data.id = i;
    800024cc:	fa942c23          	sw	s1,-72(s0)
        work(&private_data);
    800024d0:	fb840513          	addi	a0,s0,-72
    800024d4:	000a00e7          	jalr	s4
    for (int i = 0; i < num; i++) {
    800024d8:	0014849b          	addiw	s1,s1,1
    800024dc:	fd5ff06f          	j	800024b0 <_Z4runsPFvPvEP6data_si+0x30>
    }
}
    800024e0:	04813083          	ld	ra,72(sp)
    800024e4:	04013403          	ld	s0,64(sp)
    800024e8:	03813483          	ld	s1,56(sp)
    800024ec:	03013903          	ld	s2,48(sp)
    800024f0:	02813983          	ld	s3,40(sp)
    800024f4:	02013a03          	ld	s4,32(sp)
    800024f8:	05010113          	addi	sp,sp,80
    800024fc:	00008067          	ret

0000000080002500 <_Z8userMainv>:

void userMain() {
    80002500:	fc010113          	addi	sp,sp,-64
    80002504:	02113c23          	sd	ra,56(sp)
    80002508:	02813823          	sd	s0,48(sp)
    8000250c:	02913423          	sd	s1,40(sp)
    80002510:	04010413          	addi	s0,sp,64
    kmem_cache_t *shared = kmem_cache_create("shared object", shared_size, construct, nullptr);
    80002514:	00000693          	li	a3,0
    80002518:	00000617          	auipc	a2,0x0
    8000251c:	cc060613          	addi	a2,a2,-832 # 800021d8 <_Z9constructPv>
    80002520:	00700593          	li	a1,7
    80002524:	00007517          	auipc	a0,0x7
    80002528:	dbc50513          	addi	a0,a0,-580 # 800092e0 <CONSOLE_STATUS+0x2d0>
    8000252c:	00003097          	auipc	ra,0x3
    80002530:	22c080e7          	jalr	556(ra) # 80005758 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002534:	00050493          	mv	s1,a0

    struct data_s data;
    data.shared = shared;
    80002538:	fca43823          	sd	a0,-48(s0)
    data.iterations = ITERATIONS;
    8000253c:	3e800793          	li	a5,1000
    80002540:	fcf42c23          	sw	a5,-40(s0)
    runs(work, &data, RUN_NUM);
    80002544:	00500613          	li	a2,5
    80002548:	fc840593          	addi	a1,s0,-56
    8000254c:	00000517          	auipc	a0,0x0
    80002550:	d4450513          	addi	a0,a0,-700 # 80002290 <_Z4workPv>
    80002554:	00000097          	auipc	ra,0x0
    80002558:	f2c080e7          	jalr	-212(ra) # 80002480 <_Z4runsPFvPvEP6data_si>

    kmem_cache_destroy(shared);
    8000255c:	00048513          	mv	a0,s1
    80002560:	00003097          	auipc	ra,0x3
    80002564:	270080e7          	jalr	624(ra) # 800057d0 <_Z18kmem_cache_destroyP5Cache>
}
    80002568:	03813083          	ld	ra,56(sp)
    8000256c:	03013403          	ld	s0,48(sp)
    80002570:	02813483          	ld	s1,40(sp)
    80002574:	04010113          	addi	sp,sp,64
    80002578:	00008067          	ret

000000008000257c <_Z4ctorPv>:
void ctor(void* tst){
    8000257c:	ff010113          	addi	sp,sp,-16
    80002580:	00813423          	sd	s0,8(sp)
    80002584:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    80002588:	01100793          	li	a5,17
    8000258c:	00f53023          	sd	a5,0(a0)
    ((Test*)tst)->b = 32;
    80002590:	02000793          	li	a5,32
    80002594:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    80002598:	00d00793          	li	a5,13
    8000259c:	00f53823          	sd	a5,16(a0)
}
    800025a0:	00813403          	ld	s0,8(sp)
    800025a4:	01010113          	addi	sp,sp,16
    800025a8:	00008067          	ret

00000000800025ac <_ZN6SystemC1Ev>:
    if (!initialized) {
    800025ac:	0000a797          	auipc	a5,0xa
    800025b0:	b247c783          	lbu	a5,-1244(a5) # 8000c0d0 <_ZN6System11initializedE>
    800025b4:	00078463          	beqz	a5,800025bc <_ZN6SystemC1Ev+0x10>
    800025b8:	00008067          	ret
System::System() {
    800025bc:	fe010113          	addi	sp,sp,-32
    800025c0:	00113c23          	sd	ra,24(sp)
    800025c4:	00813823          	sd	s0,16(sp)
    800025c8:	02010413          	addi	s0,sp,32
        initialized = true;
    800025cc:	00100793          	li	a5,1
    800025d0:	0000a717          	auipc	a4,0xa
    800025d4:	b0f70023          	sb	a5,-1280(a4) # 8000c0d0 <_ZN6System11initializedE>
        RiscV::initialize();
    800025d8:	00002097          	auipc	ra,0x2
    800025dc:	a10080e7          	jalr	-1520(ra) # 80003fe8 <_ZN5RiscV10initializeEv>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    800025e0:	00000613          	li	a2,0
    800025e4:	00000597          	auipc	a1,0x0
    800025e8:	bb058593          	addi	a1,a1,-1104 # 80002194 <_ZN6System15userMainWrapperEPv>
    800025ec:	fe840513          	addi	a0,s0,-24
    800025f0:	00000097          	auipc	ra,0x0
    800025f4:	858080e7          	jalr	-1960(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
        RiscV::finalize();
    800025f8:	00002097          	auipc	ra,0x2
    800025fc:	ce8080e7          	jalr	-792(ra) # 800042e0 <_ZN5RiscV8finalizeEv>
}
    80002600:	01813083          	ld	ra,24(sp)
    80002604:	01013403          	ld	s0,16(sp)
    80002608:	02010113          	addi	sp,sp,32
    8000260c:	00008067          	ret

0000000080002610 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80002610:	ff010113          	addi	sp,sp,-16
    80002614:	00813423          	sd	s0,8(sp)
    80002618:	01010413          	addi	s0,sp,16
    8000261c:	00100793          	li	a5,1
    80002620:	00f50863          	beq	a0,a5,80002630 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002624:	00813403          	ld	s0,8(sp)
    80002628:	01010113          	addi	sp,sp,16
    8000262c:	00008067          	ret
    80002630:	000107b7          	lui	a5,0x10
    80002634:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002638:	fef596e3          	bne	a1,a5,80002624 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    8000263c:	0000a797          	auipc	a5,0xa
    80002640:	9347b783          	ld	a5,-1740(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002644:	0007b703          	ld	a4,0(a5)
    80002648:	00c75793          	srli	a5,a4,0xc
    8000264c:	00278793          	addi	a5,a5,2
    80002650:	00c79793          	slli	a5,a5,0xc
    80002654:	0000a697          	auipc	a3,0xa
    80002658:	a8468693          	addi	a3,a3,-1404 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000265c:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002660:	fffff7b7          	lui	a5,0xfffff
    80002664:	00f77733          	and	a4,a4,a5
    80002668:	00e6b423          	sd	a4,8(a3)
    8000266c:	fb9ff06f          	j	80002624 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002670 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80002670:	ff010113          	addi	sp,sp,-16
    80002674:	00813423          	sd	s0,8(sp)
    80002678:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    8000267c:	0000a717          	auipc	a4,0xa
    80002680:	a5c70713          	addi	a4,a4,-1444 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002684:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002688:	0000a797          	auipc	a5,0xa
    8000268c:	8e87b783          	ld	a5,-1816(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002690:	0007b783          	ld	a5,0(a5)
    80002694:	fffff6b7          	lui	a3,0xfffff
    80002698:	00d7f7b3          	and	a5,a5,a3
    8000269c:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    800026a0:	00009797          	auipc	a5,0x9
    800026a4:	78b7bc23          	sd	a1,1944(a5) # 8000be38 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    800026a8:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800026ac:	00000713          	li	a4,0
        while(num>1){
    800026b0:	00100693          	li	a3,1
    800026b4:	00f6f863          	bgeu	a3,a5,800026c4 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    800026b8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800026bc:	00170713          	addi	a4,a4,1
        while(num>1){
    800026c0:	ff1ff06f          	j	800026b0 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    800026c4:	00371713          	slli	a4,a4,0x3
    800026c8:	0000a797          	auipc	a5,0xa
    800026cc:	a1078793          	addi	a5,a5,-1520 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026d0:	00e78733          	add	a4,a5,a4
    800026d4:	00a73823          	sd	a0,16(a4)
    800026d8:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800026dc:	00000713          	li	a4,0
        while(num>1){
    800026e0:	00100693          	li	a3,1
    800026e4:	00f6f863          	bgeu	a3,a5,800026f4 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    800026e8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800026ec:	00170713          	addi	a4,a4,1
        while(num>1){
    800026f0:	ff1ff06f          	j	800026e0 <_ZN5Buddy10initializeEPvm+0x70>
    800026f4:	00371713          	slli	a4,a4,0x3
    800026f8:	0000a797          	auipc	a5,0xa
    800026fc:	9e078793          	addi	a5,a5,-1568 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002700:	00e78733          	add	a4,a5,a4
    80002704:	06a73c23          	sd	a0,120(a4)
    80002708:	00058793          	mv	a5,a1
        uint64 deg = 0;
    8000270c:	00000713          	li	a4,0
        while(num>1){
    80002710:	00100693          	li	a3,1
    80002714:	00f6f863          	bgeu	a3,a5,80002724 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80002718:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000271c:	00170713          	addi	a4,a4,1
        while(num>1){
    80002720:	ff1ff06f          	j	80002710 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80002724:	00371713          	slli	a4,a4,0x3
    80002728:	0000a797          	auipc	a5,0xa
    8000272c:	9b078793          	addi	a5,a5,-1616 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002730:	00e78733          	add	a4,a5,a4
    80002734:	01073783          	ld	a5,16(a4)
    80002738:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    8000273c:	00000793          	li	a5,0
    80002740:	00c0006f          	j	8000274c <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80002744:	0015d593          	srli	a1,a1,0x1
            deg++;
    80002748:	00178793          	addi	a5,a5,1
        while(num>1){
    8000274c:	00100713          	li	a4,1
    80002750:	feb76ae3          	bltu	a4,a1,80002744 <_ZN5Buddy10initializeEPvm+0xd4>
    80002754:	00379793          	slli	a5,a5,0x3
    80002758:	0000a717          	auipc	a4,0xa
    8000275c:	98070713          	addi	a4,a4,-1664 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002760:	00f707b3          	add	a5,a4,a5
    80002764:	0787b783          	ld	a5,120(a5)
    80002768:	0007b023          	sd	zero,0(a5)
}
    8000276c:	00813403          	ld	s0,8(sp)
    80002770:	01010113          	addi	sp,sp,16
    80002774:	00008067          	ret

0000000080002778 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80002778:	00c00793          	li	a5,12
    8000277c:	10f50063          	beq	a0,a5,8000287c <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80002780:	fd010113          	addi	sp,sp,-48
    80002784:	02113423          	sd	ra,40(sp)
    80002788:	02813023          	sd	s0,32(sp)
    8000278c:	00913c23          	sd	s1,24(sp)
    80002790:	01213823          	sd	s2,16(sp)
    80002794:	01313423          	sd	s3,8(sp)
    80002798:	03010413          	addi	s0,sp,48
    8000279c:	00050913          	mv	s2,a0
    Block *curr = head[size];
    800027a0:	00351713          	slli	a4,a0,0x3
    800027a4:	0000a797          	auipc	a5,0xa
    800027a8:	93478793          	addi	a5,a5,-1740 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027ac:	00e787b3          	add	a5,a5,a4
    800027b0:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    800027b4:	00000993          	li	s3,0
    800027b8:	0180006f          	j	800027d0 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    800027bc:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    800027c0:	04f70463          	beq	a4,a5,80002808 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    800027c4:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    800027c8:	08f70063          	beq	a4,a5,80002848 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    800027cc:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    800027d0:	08048863          	beqz	s1,80002860 <_ZN5Buddy8compressEm+0xe8>
    800027d4:	0004b683          	ld	a3,0(s1)
    800027d8:	08068463          	beqz	a3,80002860 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    800027dc:	0000a797          	auipc	a5,0xa
    800027e0:	8fc7b783          	ld	a5,-1796(a5) # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027e4:	40f48733          	sub	a4,s1,a5
    800027e8:	00c9061b          	addiw	a2,s2,12
    800027ec:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    800027f0:	40f687b3          	sub	a5,a3,a5
    800027f4:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    800027f8:	00177613          	andi	a2,a4,1
    800027fc:	fc0610e3          	bnez	a2,800027bc <_ZN5Buddy8compressEm+0x44>
    80002800:	00170713          	addi	a4,a4,1
    80002804:	fbdff06f          	j	800027c0 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80002808:	00098863          	beqz	s3,80002818 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    8000280c:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7fff1ae0>
    80002810:	00d9b023          	sd	a3,0(s3)
    80002814:	fb5ff06f          	j	800027c8 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80002818:	0006b603          	ld	a2,0(a3)
    8000281c:	00391593          	slli	a1,s2,0x3
    80002820:	0000a697          	auipc	a3,0xa
    80002824:	8b868693          	addi	a3,a3,-1864 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002828:	00b686b3          	add	a3,a3,a1
    8000282c:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    80002830:	f8061ce3          	bnez	a2,800027c8 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    80002834:	0000a697          	auipc	a3,0xa
    80002838:	8a468693          	addi	a3,a3,-1884 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000283c:	00b686b3          	add	a3,a3,a1
    80002840:	0006b823          	sd	zero,16(a3)
    80002844:	f85ff06f          	j	800027c8 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80002848:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    8000284c:	00190593          	addi	a1,s2,1
    80002850:	00048513          	mv	a0,s1
    80002854:	00000097          	auipc	ra,0x0
    80002858:	02c080e7          	jalr	44(ra) # 80002880 <_ZN5Buddy6insertEPvm>
    8000285c:	f71ff06f          	j	800027cc <_ZN5Buddy8compressEm+0x54>
}
    80002860:	02813083          	ld	ra,40(sp)
    80002864:	02013403          	ld	s0,32(sp)
    80002868:	01813483          	ld	s1,24(sp)
    8000286c:	01013903          	ld	s2,16(sp)
    80002870:	00813983          	ld	s3,8(sp)
    80002874:	03010113          	addi	sp,sp,48
    80002878:	00008067          	ret
    8000287c:	00008067          	ret

0000000080002880 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80002880:	00050693          	mv	a3,a0
    if(!head[size]){
    80002884:	00359713          	slli	a4,a1,0x3
    80002888:	0000a797          	auipc	a5,0xa
    8000288c:	85078793          	addi	a5,a5,-1968 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002890:	00e787b3          	add	a5,a5,a4
    80002894:	0787b783          	ld	a5,120(a5)
    80002898:	02078c63          	beqz	a5,800028d0 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    8000289c:	ff010113          	addi	sp,sp,-16
    800028a0:	00113423          	sd	ra,8(sp)
    800028a4:	00813023          	sd	s0,0(sp)
    800028a8:	01010413          	addi	s0,sp,16
    800028ac:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    800028b0:	00068713          	mv	a4,a3
    800028b4:	04f6e063          	bltu	a3,a5,800028f4 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    800028b8:	00000613          	li	a2,0
            while (iter != nullptr) {
    800028bc:	06078863          	beqz	a5,8000292c <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    800028c0:	04f76c63          	bltu	a4,a5,80002918 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    800028c4:	00078613          	mv	a2,a5
                    iter = iter->next;
    800028c8:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    800028cc:	ff1ff06f          	j	800028bc <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    800028d0:	0000a797          	auipc	a5,0xa
    800028d4:	80878793          	addi	a5,a5,-2040 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800028d8:	00e78533          	add	a0,a5,a4
    800028dc:	00d53823          	sd	a3,16(a0)
    800028e0:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    800028e4:	0006b023          	sd	zero,0(a3)
    800028e8:	07853783          	ld	a5,120(a0)
    800028ec:	0007b023          	sd	zero,0(a5)
        return;
    800028f0:	00008067          	ret
            newHead->next = head[size];
    800028f4:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    800028f8:	00359713          	slli	a4,a1,0x3
    800028fc:	00009797          	auipc	a5,0x9
    80002900:	7dc78793          	addi	a5,a5,2012 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002904:	00e787b3          	add	a5,a5,a4
    80002908:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    8000290c:	00000097          	auipc	ra,0x0
    80002910:	e6c080e7          	jalr	-404(ra) # 80002778 <_ZN5Buddy8compressEm>
            return;
    80002914:	0440006f          	j	80002958 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    80002918:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    8000291c:	00d63023          	sd	a3,0(a2)
                    compress(size);
    80002920:	00000097          	auipc	ra,0x0
    80002924:	e58080e7          	jalr	-424(ra) # 80002778 <_ZN5Buddy8compressEm>
                    return;
    80002928:	0300006f          	j	80002958 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    8000292c:	00351713          	slli	a4,a0,0x3
    80002930:	00009797          	auipc	a5,0x9
    80002934:	7a878793          	addi	a5,a5,1960 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002938:	00e787b3          	add	a5,a5,a4
    8000293c:	0107b703          	ld	a4,16(a5)
    80002940:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80002944:	0107b703          	ld	a4,16(a5)
    80002948:	00073703          	ld	a4,0(a4)
    8000294c:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80002950:	00000097          	auipc	ra,0x0
    80002954:	e28080e7          	jalr	-472(ra) # 80002778 <_ZN5Buddy8compressEm>
}
    80002958:	00813083          	ld	ra,8(sp)
    8000295c:	00013403          	ld	s0,0(sp)
    80002960:	01010113          	addi	sp,sp,16
    80002964:	00008067          	ret

0000000080002968 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80002968:	02050663          	beqz	a0,80002994 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    8000296c:	ff010113          	addi	sp,sp,-16
    80002970:	00113423          	sd	ra,8(sp)
    80002974:	00813023          	sd	s0,0(sp)
    80002978:	01010413          	addi	s0,sp,16
    insert(addr,size);
    8000297c:	00000097          	auipc	ra,0x0
    80002980:	f04080e7          	jalr	-252(ra) # 80002880 <_ZN5Buddy6insertEPvm>
}
    80002984:	00813083          	ld	ra,8(sp)
    80002988:	00013403          	ld	s0,0(sp)
    8000298c:	01010113          	addi	sp,sp,16
    80002990:	00008067          	ret
    80002994:	00008067          	ret

0000000080002998 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002998:	ff010113          	addi	sp,sp,-16
    8000299c:	00813423          	sd	s0,8(sp)
    800029a0:	01010413          	addi	s0,sp,16
    800029a4:	03c0006f          	j	800029e0 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800029a8:	00b5859b          	addiw	a1,a1,11
    800029ac:	00100713          	li	a4,1
    800029b0:	00b715bb          	sllw	a1,a4,a1
    800029b4:	00b505b3          	add	a1,a0,a1
    800029b8:	00379693          	slli	a3,a5,0x3
    800029bc:	00009717          	auipc	a4,0x9
    800029c0:	71c70713          	addi	a4,a4,1820 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800029c4:	00d70733          	add	a4,a4,a3
    800029c8:	00b73823          	sd	a1,16(a4)
    800029cc:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    800029d0:	0005b023          	sd	zero,0(a1)
    800029d4:	07873703          	ld	a4,120(a4)
    800029d8:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800029dc:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    800029e0:	fff5879b          	addiw	a5,a1,-1
    800029e4:	04c7c863          	blt	a5,a2,80002a34 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    800029e8:	00379693          	slli	a3,a5,0x3
    800029ec:	00009717          	auipc	a4,0x9
    800029f0:	6ec70713          	addi	a4,a4,1772 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800029f4:	00d70733          	add	a4,a4,a3
    800029f8:	01073683          	ld	a3,16(a4)
    800029fc:	fa0686e3          	beqz	a3,800029a8 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002a00:	00b5859b          	addiw	a1,a1,11
    80002a04:	00100713          	li	a4,1
    80002a08:	00b715bb          	sllw	a1,a4,a1
    80002a0c:	00b505b3          	add	a1,a0,a1
    80002a10:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80002a14:	00379693          	slli	a3,a5,0x3
    80002a18:	00009717          	auipc	a4,0x9
    80002a1c:	6c070713          	addi	a4,a4,1728 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002a20:	00d70733          	add	a4,a4,a3
    80002a24:	01073683          	ld	a3,16(a4)
    80002a28:	0006b683          	ld	a3,0(a3)
    80002a2c:	00d73823          	sd	a3,16(a4)
    80002a30:	fadff06f          	j	800029dc <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80002a34:	00813403          	ld	s0,8(sp)
    80002a38:	01010113          	addi	sp,sp,16
    80002a3c:	00008067          	ret

0000000080002a40 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80002a40:	fe010113          	addi	sp,sp,-32
    80002a44:	00113c23          	sd	ra,24(sp)
    80002a48:	00813823          	sd	s0,16(sp)
    80002a4c:	00913423          	sd	s1,8(sp)
    80002a50:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80002a54:	00c00793          	li	a5,12
    80002a58:	06a7ec63          	bltu	a5,a0,80002ad0 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002a5c:	00050593          	mv	a1,a0
    80002a60:	00c00793          	li	a5,12
    80002a64:	06b7ea63          	bltu	a5,a1,80002ad8 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80002a68:	00359713          	slli	a4,a1,0x3
    80002a6c:	00009797          	auipc	a5,0x9
    80002a70:	66c78793          	addi	a5,a5,1644 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002a74:	00e787b3          	add	a5,a5,a4
    80002a78:	0787b483          	ld	s1,120(a5)
    80002a7c:	00049663          	bnez	s1,80002a88 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002a80:	00158593          	addi	a1,a1,1
    80002a84:	fddff06f          	j	80002a60 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80002a88:	0004b703          	ld	a4,0(s1)
    80002a8c:	00359693          	slli	a3,a1,0x3
    80002a90:	00009797          	auipc	a5,0x9
    80002a94:	64878793          	addi	a5,a5,1608 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002a98:	00d787b3          	add	a5,a5,a3
    80002a9c:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002aa0:	00070e63          	beqz	a4,80002abc <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80002aa4:	0005061b          	sext.w	a2,a0
    80002aa8:	0005859b          	sext.w	a1,a1
    80002aac:	00048513          	mv	a0,s1
    80002ab0:	00000097          	auipc	ra,0x0
    80002ab4:	ee8080e7          	jalr	-280(ra) # 80002998 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80002ab8:	0240006f          	j	80002adc <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002abc:	00009797          	auipc	a5,0x9
    80002ac0:	61c78793          	addi	a5,a5,1564 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002ac4:	00d787b3          	add	a5,a5,a3
    80002ac8:	0007b823          	sd	zero,16(a5)
    80002acc:	fd9ff06f          	j	80002aa4 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002ad0:	00000493          	li	s1,0
    80002ad4:	0080006f          	j	80002adc <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80002ad8:	00000493          	li	s1,0
}
    80002adc:	00048513          	mv	a0,s1
    80002ae0:	01813083          	ld	ra,24(sp)
    80002ae4:	01013403          	ld	s0,16(sp)
    80002ae8:	00813483          	ld	s1,8(sp)
    80002aec:	02010113          	addi	sp,sp,32
    80002af0:	00008067          	ret

0000000080002af4 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002af4:	fe010113          	addi	sp,sp,-32
    80002af8:	00113c23          	sd	ra,24(sp)
    80002afc:	00813823          	sd	s0,16(sp)
    80002b00:	00913423          	sd	s1,8(sp)
    80002b04:	01213023          	sd	s2,0(sp)
    80002b08:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80002b0c:	00000913          	li	s2,0
    80002b10:	0180006f          	j	80002b28 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002b14:	00007517          	auipc	a0,0x7
    80002b18:	8ac50513          	addi	a0,a0,-1876 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80002b1c:	00003097          	auipc	ra,0x3
    80002b20:	a60080e7          	jalr	-1440(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80002b24:	0019091b          	addiw	s2,s2,1
    80002b28:	00c00793          	li	a5,12
    80002b2c:	0727c663          	blt	a5,s2,80002b98 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80002b30:	00000613          	li	a2,0
    80002b34:	00a00593          	li	a1,10
    80002b38:	00090513          	mv	a0,s2
    80002b3c:	00003097          	auipc	ra,0x3
    80002b40:	a84080e7          	jalr	-1404(ra) # 800055c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80002b44:	00006517          	auipc	a0,0x6
    80002b48:	7d450513          	addi	a0,a0,2004 # 80009318 <CONSOLE_STATUS+0x308>
    80002b4c:	00003097          	auipc	ra,0x3
    80002b50:	a30080e7          	jalr	-1488(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80002b54:	00391713          	slli	a4,s2,0x3
    80002b58:	00009797          	auipc	a5,0x9
    80002b5c:	58078793          	addi	a5,a5,1408 # 8000c0d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002b60:	00e787b3          	add	a5,a5,a4
    80002b64:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002b68:	fa0486e3          	beqz	s1,80002b14 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    80002b6c:	00000613          	li	a2,0
    80002b70:	01000593          	li	a1,16
    80002b74:	0004851b          	sext.w	a0,s1
    80002b78:	00003097          	auipc	ra,0x3
    80002b7c:	a48080e7          	jalr	-1464(ra) # 800055c0 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002b80:	00006517          	auipc	a0,0x6
    80002b84:	56850513          	addi	a0,a0,1384 # 800090e8 <CONSOLE_STATUS+0xd8>
    80002b88:	00003097          	auipc	ra,0x3
    80002b8c:	9f4080e7          	jalr	-1548(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002b90:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002b94:	fd5ff06f          	j	80002b68 <_ZN5Buddy9printListEv+0x74>
    80002b98:	01813083          	ld	ra,24(sp)
    80002b9c:	01013403          	ld	s0,16(sp)
    80002ba0:	00813483          	ld	s1,8(sp)
    80002ba4:	00013903          	ld	s2,0(sp)
    80002ba8:	02010113          	addi	sp,sp,32
    80002bac:	00008067          	ret

0000000080002bb0 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002bb0:	ff010113          	addi	sp,sp,-16
    80002bb4:	00113423          	sd	ra,8(sp)
    80002bb8:	00813023          	sd	s0,0(sp)
    80002bbc:	01010413          	addi	s0,sp,16
    80002bc0:	000105b7          	lui	a1,0x10
    80002bc4:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002bc8:	00100513          	li	a0,1
    80002bcc:	00000097          	auipc	ra,0x0
    80002bd0:	a44080e7          	jalr	-1468(ra) # 80002610 <_Z41__static_initialization_and_destruction_0ii>
    80002bd4:	00813083          	ld	ra,8(sp)
    80002bd8:	00013403          	ld	s0,0(sp)
    80002bdc:	01010113          	addi	sp,sp,16
    80002be0:	00008067          	ret

0000000080002be4 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002be4:	fe010113          	addi	sp,sp,-32
    80002be8:	00113c23          	sd	ra,24(sp)
    80002bec:	00813823          	sd	s0,16(sp)
    80002bf0:	00913423          	sd	s1,8(sp)
    80002bf4:	02010413          	addi	s0,sp,32
    80002bf8:	00050493          	mv	s1,a0
    LOCK();
    80002bfc:	00100613          	li	a2,1
    80002c00:	00000593          	li	a1,0
    80002c04:	00009517          	auipc	a0,0x9
    80002c08:	5b450513          	addi	a0,a0,1460 # 8000c1b8 <lockPrint>
    80002c0c:	ffffe097          	auipc	ra,0xffffe
    80002c10:	3f4080e7          	jalr	1012(ra) # 80001000 <copy_and_swap>
    80002c14:	fe0514e3          	bnez	a0,80002bfc <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002c18:	0004c503          	lbu	a0,0(s1)
    80002c1c:	00050a63          	beqz	a0,80002c30 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002c20:	fffff097          	auipc	ra,0xfffff
    80002c24:	4d8080e7          	jalr	1240(ra) # 800020f8 <_Z4putcc>
        string++;
    80002c28:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002c2c:	fedff06f          	j	80002c18 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002c30:	00000613          	li	a2,0
    80002c34:	00100593          	li	a1,1
    80002c38:	00009517          	auipc	a0,0x9
    80002c3c:	58050513          	addi	a0,a0,1408 # 8000c1b8 <lockPrint>
    80002c40:	ffffe097          	auipc	ra,0xffffe
    80002c44:	3c0080e7          	jalr	960(ra) # 80001000 <copy_and_swap>
    80002c48:	fe0514e3          	bnez	a0,80002c30 <_Z11printStringPKc+0x4c>
}
    80002c4c:	01813083          	ld	ra,24(sp)
    80002c50:	01013403          	ld	s0,16(sp)
    80002c54:	00813483          	ld	s1,8(sp)
    80002c58:	02010113          	addi	sp,sp,32
    80002c5c:	00008067          	ret

0000000080002c60 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002c60:	fd010113          	addi	sp,sp,-48
    80002c64:	02113423          	sd	ra,40(sp)
    80002c68:	02813023          	sd	s0,32(sp)
    80002c6c:	00913c23          	sd	s1,24(sp)
    80002c70:	01213823          	sd	s2,16(sp)
    80002c74:	01313423          	sd	s3,8(sp)
    80002c78:	01413023          	sd	s4,0(sp)
    80002c7c:	03010413          	addi	s0,sp,48
    80002c80:	00050993          	mv	s3,a0
    80002c84:	00058a13          	mv	s4,a1
    LOCK();
    80002c88:	00100613          	li	a2,1
    80002c8c:	00000593          	li	a1,0
    80002c90:	00009517          	auipc	a0,0x9
    80002c94:	52850513          	addi	a0,a0,1320 # 8000c1b8 <lockPrint>
    80002c98:	ffffe097          	auipc	ra,0xffffe
    80002c9c:	368080e7          	jalr	872(ra) # 80001000 <copy_and_swap>
    80002ca0:	fe0514e3          	bnez	a0,80002c88 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002ca4:	00000913          	li	s2,0
    80002ca8:	00090493          	mv	s1,s2
    80002cac:	0019091b          	addiw	s2,s2,1
    80002cb0:	03495a63          	bge	s2,s4,80002ce4 <_Z9getStringPci+0x84>
        cc = getc();
    80002cb4:	fffff097          	auipc	ra,0xfffff
    80002cb8:	41c080e7          	jalr	1052(ra) # 800020d0 <_Z4getcv>
        if(cc < 1)
    80002cbc:	02050463          	beqz	a0,80002ce4 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002cc0:	009984b3          	add	s1,s3,s1
    80002cc4:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002cc8:	00a00793          	li	a5,10
    80002ccc:	00f50a63          	beq	a0,a5,80002ce0 <_Z9getStringPci+0x80>
    80002cd0:	00d00793          	li	a5,13
    80002cd4:	fcf51ae3          	bne	a0,a5,80002ca8 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002cd8:	00090493          	mv	s1,s2
    80002cdc:	0080006f          	j	80002ce4 <_Z9getStringPci+0x84>
    80002ce0:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002ce4:	009984b3          	add	s1,s3,s1
    80002ce8:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002cec:	00000613          	li	a2,0
    80002cf0:	00100593          	li	a1,1
    80002cf4:	00009517          	auipc	a0,0x9
    80002cf8:	4c450513          	addi	a0,a0,1220 # 8000c1b8 <lockPrint>
    80002cfc:	ffffe097          	auipc	ra,0xffffe
    80002d00:	304080e7          	jalr	772(ra) # 80001000 <copy_and_swap>
    80002d04:	fe0514e3          	bnez	a0,80002cec <_Z9getStringPci+0x8c>
    return buf;
}
    80002d08:	00098513          	mv	a0,s3
    80002d0c:	02813083          	ld	ra,40(sp)
    80002d10:	02013403          	ld	s0,32(sp)
    80002d14:	01813483          	ld	s1,24(sp)
    80002d18:	01013903          	ld	s2,16(sp)
    80002d1c:	00813983          	ld	s3,8(sp)
    80002d20:	00013a03          	ld	s4,0(sp)
    80002d24:	03010113          	addi	sp,sp,48
    80002d28:	00008067          	ret

0000000080002d2c <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002d2c:	ff010113          	addi	sp,sp,-16
    80002d30:	00813423          	sd	s0,8(sp)
    80002d34:	01010413          	addi	s0,sp,16
    80002d38:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002d3c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002d40:	0006c603          	lbu	a2,0(a3)
    80002d44:	fd06071b          	addiw	a4,a2,-48
    80002d48:	0ff77713          	andi	a4,a4,255
    80002d4c:	00900793          	li	a5,9
    80002d50:	02e7e063          	bltu	a5,a4,80002d70 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002d54:	0025179b          	slliw	a5,a0,0x2
    80002d58:	00a787bb          	addw	a5,a5,a0
    80002d5c:	0017979b          	slliw	a5,a5,0x1
    80002d60:	00168693          	addi	a3,a3,1
    80002d64:	00c787bb          	addw	a5,a5,a2
    80002d68:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002d6c:	fd5ff06f          	j	80002d40 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002d70:	00813403          	ld	s0,8(sp)
    80002d74:	01010113          	addi	sp,sp,16
    80002d78:	00008067          	ret

0000000080002d7c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002d7c:	fc010113          	addi	sp,sp,-64
    80002d80:	02113c23          	sd	ra,56(sp)
    80002d84:	02813823          	sd	s0,48(sp)
    80002d88:	02913423          	sd	s1,40(sp)
    80002d8c:	03213023          	sd	s2,32(sp)
    80002d90:	01313c23          	sd	s3,24(sp)
    80002d94:	04010413          	addi	s0,sp,64
    80002d98:	00050493          	mv	s1,a0
    80002d9c:	00058913          	mv	s2,a1
    80002da0:	00060993          	mv	s3,a2
    LOCK();
    80002da4:	00100613          	li	a2,1
    80002da8:	00000593          	li	a1,0
    80002dac:	00009517          	auipc	a0,0x9
    80002db0:	40c50513          	addi	a0,a0,1036 # 8000c1b8 <lockPrint>
    80002db4:	ffffe097          	auipc	ra,0xffffe
    80002db8:	24c080e7          	jalr	588(ra) # 80001000 <copy_and_swap>
    80002dbc:	fe0514e3          	bnez	a0,80002da4 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002dc0:	00098463          	beqz	s3,80002dc8 <_Z8printIntiii+0x4c>
    80002dc4:	0804c463          	bltz	s1,80002e4c <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002dc8:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002dcc:	00000593          	li	a1,0
    }

    i = 0;
    80002dd0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002dd4:	0009079b          	sext.w	a5,s2
    80002dd8:	0325773b          	remuw	a4,a0,s2
    80002ddc:	00048613          	mv	a2,s1
    80002de0:	0014849b          	addiw	s1,s1,1
    80002de4:	02071693          	slli	a3,a4,0x20
    80002de8:	0206d693          	srli	a3,a3,0x20
    80002dec:	00009717          	auipc	a4,0x9
    80002df0:	05470713          	addi	a4,a4,84 # 8000be40 <digits>
    80002df4:	00d70733          	add	a4,a4,a3
    80002df8:	00074683          	lbu	a3,0(a4)
    80002dfc:	fd040713          	addi	a4,s0,-48
    80002e00:	00c70733          	add	a4,a4,a2
    80002e04:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002e08:	0005071b          	sext.w	a4,a0
    80002e0c:	0325553b          	divuw	a0,a0,s2
    80002e10:	fcf772e3          	bgeu	a4,a5,80002dd4 <_Z8printIntiii+0x58>
    if(neg)
    80002e14:	00058c63          	beqz	a1,80002e2c <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002e18:	fd040793          	addi	a5,s0,-48
    80002e1c:	009784b3          	add	s1,a5,s1
    80002e20:	02d00793          	li	a5,45
    80002e24:	fef48823          	sb	a5,-16(s1)
    80002e28:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002e2c:	fff4849b          	addiw	s1,s1,-1
    80002e30:	0204c463          	bltz	s1,80002e58 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002e34:	fd040793          	addi	a5,s0,-48
    80002e38:	009787b3          	add	a5,a5,s1
    80002e3c:	ff07c503          	lbu	a0,-16(a5)
    80002e40:	fffff097          	auipc	ra,0xfffff
    80002e44:	2b8080e7          	jalr	696(ra) # 800020f8 <_Z4putcc>
    80002e48:	fe5ff06f          	j	80002e2c <_Z8printIntiii+0xb0>
        x = -xx;
    80002e4c:	4090053b          	negw	a0,s1
        neg = 1;
    80002e50:	00100593          	li	a1,1
        x = -xx;
    80002e54:	f7dff06f          	j	80002dd0 <_Z8printIntiii+0x54>

    UNLOCK();
    80002e58:	00000613          	li	a2,0
    80002e5c:	00100593          	li	a1,1
    80002e60:	00009517          	auipc	a0,0x9
    80002e64:	35850513          	addi	a0,a0,856 # 8000c1b8 <lockPrint>
    80002e68:	ffffe097          	auipc	ra,0xffffe
    80002e6c:	198080e7          	jalr	408(ra) # 80001000 <copy_and_swap>
    80002e70:	fe0514e3          	bnez	a0,80002e58 <_Z8printIntiii+0xdc>
    80002e74:	03813083          	ld	ra,56(sp)
    80002e78:	03013403          	ld	s0,48(sp)
    80002e7c:	02813483          	ld	s1,40(sp)
    80002e80:	02013903          	ld	s2,32(sp)
    80002e84:	01813983          	ld	s3,24(sp)
    80002e88:	04010113          	addi	sp,sp,64
    80002e8c:	00008067          	ret

0000000080002e90 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80002e90:	ff010113          	addi	sp,sp,-16
    80002e94:	00813423          	sd	s0,8(sp)
    80002e98:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002e9c:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002ea0:	00053823          	sd	zero,16(a0)
}
    80002ea4:	00813403          	ld	s0,8(sp)
    80002ea8:	01010113          	addi	sp,sp,16
    80002eac:	00008067          	ret

0000000080002eb0 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80002eb0:	ff010113          	addi	sp,sp,-16
    80002eb4:	00813423          	sd	s0,8(sp)
    80002eb8:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002ebc:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002ec0:	00053823          	sd	zero,16(a0)
    80002ec4:	00813403          	ld	s0,8(sp)
    80002ec8:	01010113          	addi	sp,sp,16
    80002ecc:	00008067          	ret

0000000080002ed0 <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    80002ed0:	ff010113          	addi	sp,sp,-16
    80002ed4:	00113423          	sd	ra,8(sp)
    80002ed8:	00813023          	sd	s0,0(sp)
    80002edc:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    80002ee0:	00000697          	auipc	a3,0x0
    80002ee4:	fd068693          	addi	a3,a3,-48 # 80002eb0 <_ZN3SCB4dtorEPv>
    80002ee8:	00000617          	auipc	a2,0x0
    80002eec:	fa860613          	addi	a2,a2,-88 # 80002e90 <_ZN3SCB4ctorEPv>
    80002ef0:	01800593          	li	a1,24
    80002ef4:	00006517          	auipc	a0,0x6
    80002ef8:	42c50513          	addi	a0,a0,1068 # 80009320 <CONSOLE_STATUS+0x310>
    80002efc:	00003097          	auipc	ra,0x3
    80002f00:	85c080e7          	jalr	-1956(ra) # 80005758 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002f04:	00009797          	auipc	a5,0x9
    80002f08:	2aa7be23          	sd	a0,700(a5) # 8000c1c0 <_ZN3SCB8scbCacheE>
}
    80002f0c:	00813083          	ld	ra,8(sp)
    80002f10:	00013403          	ld	s0,0(sp)
    80002f14:	01010113          	addi	sp,sp,16
    80002f18:	00008067          	ret

0000000080002f1c <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    80002f1c:	ff010113          	addi	sp,sp,-16
    80002f20:	00813423          	sd	s0,8(sp)
    80002f24:	01010413          	addi	s0,sp,16
    val = init;
    80002f28:	00b52023          	sw	a1,0(a0)
}
    80002f2c:	00813403          	ld	s0,8(sp)
    80002f30:	01010113          	addi	sp,sp,16
    80002f34:	00008067          	ret

0000000080002f38 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80002f38:	fe010113          	addi	sp,sp,-32
    80002f3c:	00113c23          	sd	ra,24(sp)
    80002f40:	00813823          	sd	s0,16(sp)
    80002f44:	00913423          	sd	s1,8(sp)
    80002f48:	01213023          	sd	s2,0(sp)
    80002f4c:	02010413          	addi	s0,sp,32
    80002f50:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002f54:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002f58:	02050063          	beqz	a0,80002f78 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80002f5c:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002f60:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002f64:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002f68:	00002097          	auipc	ra,0x2
    80002f6c:	13c080e7          	jalr	316(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002f70:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002f74:	fe5ff06f          	j	80002f58 <_ZN3SCBD1Ev+0x20>
}
    80002f78:	01813083          	ld	ra,24(sp)
    80002f7c:	01013403          	ld	s0,16(sp)
    80002f80:	00813483          	ld	s1,8(sp)
    80002f84:	00013903          	ld	s2,0(sp)
    80002f88:	02010113          	addi	sp,sp,32
    80002f8c:	00008067          	ret

0000000080002f90 <_ZN3SCB5blockEv>:
void SCB::block() {
    80002f90:	ff010113          	addi	sp,sp,-16
    80002f94:	00113423          	sd	ra,8(sp)
    80002f98:	00813023          	sd	s0,0(sp)
    80002f9c:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002fa0:	00853783          	ld	a5,8(a0)
    80002fa4:	04078063          	beqz	a5,80002fe4 <_ZN3SCB5blockEv+0x54>
    80002fa8:	01053703          	ld	a4,16(a0)
    80002fac:	00009797          	auipc	a5,0x9
    80002fb0:	0347b783          	ld	a5,52(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002fb4:	0007b783          	ld	a5,0(a5)
    80002fb8:	04f73423          	sd	a5,72(a4)
    80002fbc:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002fc0:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002fc4:	00300713          	li	a4,3
    80002fc8:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002fcc:	00000097          	auipc	ra,0x0
    80002fd0:	314080e7          	jalr	788(ra) # 800032e0 <_ZN3TCB8dispatchEv>
}
    80002fd4:	00813083          	ld	ra,8(sp)
    80002fd8:	00013403          	ld	s0,0(sp)
    80002fdc:	01010113          	addi	sp,sp,16
    80002fe0:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002fe4:	00009797          	auipc	a5,0x9
    80002fe8:	ffc7b783          	ld	a5,-4(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002fec:	0007b783          	ld	a5,0(a5)
    80002ff0:	00f53423          	sd	a5,8(a0)
    80002ff4:	fc9ff06f          	j	80002fbc <_ZN3SCB5blockEv+0x2c>

0000000080002ff8 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    80002ff8:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002ffc:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80003000:	04853703          	ld	a4,72(a0)
    80003004:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80003008:	04053423          	sd	zero,72(a0)
    if(tcb) {
    8000300c:	02050a63          	beqz	a0,80003040 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80003010:	ff010113          	addi	sp,sp,-16
    80003014:	00113423          	sd	ra,8(sp)
    80003018:	00813023          	sd	s0,0(sp)
    8000301c:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80003020:	00100793          	li	a5,1
    80003024:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003028:	00002097          	auipc	ra,0x2
    8000302c:	07c080e7          	jalr	124(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>
}
    80003030:	00813083          	ld	ra,8(sp)
    80003034:	00013403          	ld	s0,0(sp)
    80003038:	01010113          	addi	sp,sp,16
    8000303c:	00008067          	ret
    80003040:	00008067          	ret

0000000080003044 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80003044:	00009797          	auipc	a5,0x9
    80003048:	f9c7b783          	ld	a5,-100(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000304c:	0007b783          	ld	a5,0(a5)
    80003050:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80003054:	00052783          	lw	a5,0(a0)
    80003058:	fff7879b          	addiw	a5,a5,-1
    8000305c:	00f52023          	sw	a5,0(a0)
    80003060:	02079713          	slli	a4,a5,0x20
    80003064:	00074463          	bltz	a4,8000306c <_ZN3SCB4waitEv+0x28>
    80003068:	00008067          	ret
void SCB::wait() {
    8000306c:	ff010113          	addi	sp,sp,-16
    80003070:	00113423          	sd	ra,8(sp)
    80003074:	00813023          	sd	s0,0(sp)
    80003078:	01010413          	addi	s0,sp,16
        block();
    8000307c:	00000097          	auipc	ra,0x0
    80003080:	f14080e7          	jalr	-236(ra) # 80002f90 <_ZN3SCB5blockEv>
}
    80003084:	00813083          	ld	ra,8(sp)
    80003088:	00013403          	ld	s0,0(sp)
    8000308c:	01010113          	addi	sp,sp,16
    80003090:	00008067          	ret

0000000080003094 <_ZN3SCB6signalEv>:
    if(val++<0)
    80003094:	00052783          	lw	a5,0(a0)
    80003098:	0017871b          	addiw	a4,a5,1
    8000309c:	00e52023          	sw	a4,0(a0)
    800030a0:	0007c463          	bltz	a5,800030a8 <_ZN3SCB6signalEv+0x14>
    800030a4:	00008067          	ret
void SCB::signal(){
    800030a8:	ff010113          	addi	sp,sp,-16
    800030ac:	00113423          	sd	ra,8(sp)
    800030b0:	00813023          	sd	s0,0(sp)
    800030b4:	01010413          	addi	s0,sp,16
        deblock();
    800030b8:	00000097          	auipc	ra,0x0
    800030bc:	f40080e7          	jalr	-192(ra) # 80002ff8 <_ZN3SCB7deblockEv>
}
    800030c0:	00813083          	ld	ra,8(sp)
    800030c4:	00013403          	ld	s0,0(sp)
    800030c8:	01010113          	addi	sp,sp,16
    800030cc:	00008067          	ret

00000000800030d0 <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    800030d0:	ff010113          	addi	sp,sp,-16
    800030d4:	00113423          	sd	ra,8(sp)
    800030d8:	00813023          	sd	s0,0(sp)
    800030dc:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    800030e0:	00009517          	auipc	a0,0x9
    800030e4:	0e053503          	ld	a0,224(a0) # 8000c1c0 <_ZN3SCB8scbCacheE>
    800030e8:	00002097          	auipc	ra,0x2
    800030ec:	698080e7          	jalr	1688(ra) # 80005780 <_Z16kmem_cache_allocP5Cache>
}
    800030f0:	00813083          	ld	ra,8(sp)
    800030f4:	00013403          	ld	s0,0(sp)
    800030f8:	01010113          	addi	sp,sp,16
    800030fc:	00008067          	ret

0000000080003100 <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    80003100:	ff010113          	addi	sp,sp,-16
    80003104:	00113423          	sd	ra,8(sp)
    80003108:	00813023          	sd	s0,0(sp)
    8000310c:	01010413          	addi	s0,sp,16
    80003110:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80003114:	00009517          	auipc	a0,0x9
    80003118:	0ac53503          	ld	a0,172(a0) # 8000c1c0 <_ZN3SCB8scbCacheE>
    8000311c:	00002097          	auipc	ra,0x2
    80003120:	68c080e7          	jalr	1676(ra) # 800057a8 <_Z15kmem_cache_freeP5CachePv>
}
    80003124:	00813083          	ld	ra,8(sp)
    80003128:	00013403          	ld	s0,0(sp)
    8000312c:	01010113          	addi	sp,sp,16
    80003130:	00008067          	ret

0000000080003134 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80003134:	ff010113          	addi	sp,sp,-16
    80003138:	00813423          	sd	s0,8(sp)
    8000313c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80003140:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80003144:	05200513          	li	a0,82
    asm("ecall");
    80003148:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000314c:	00050513          	mv	a0,a0
}
    80003150:	0005051b          	sext.w	a0,a0
    80003154:	00813403          	ld	s0,8(sp)
    80003158:	01010113          	addi	sp,sp,16
    8000315c:	00008067          	ret

0000000080003160 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80003160:	fe010113          	addi	sp,sp,-32
    80003164:	00113c23          	sd	ra,24(sp)
    80003168:	00813823          	sd	s0,16(sp)
    8000316c:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80003170:	fe840513          	addi	a0,s0,-24
    80003174:	fffff097          	auipc	ra,0xfffff
    80003178:	438080e7          	jalr	1080(ra) # 800025ac <_ZN6SystemC1Ev>

    return 0;
    8000317c:	00000513          	li	a0,0
    80003180:	01813083          	ld	ra,24(sp)
    80003184:	01013403          	ld	s0,16(sp)
    80003188:	02010113          	addi	sp,sp,32
    8000318c:	00008067          	ret

0000000080003190 <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80003190:	ff010113          	addi	sp,sp,-16
    80003194:	00813423          	sd	s0,8(sp)
    80003198:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    8000319c:	00100793          	li	a5,1
    800031a0:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    800031a4:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    800031a8:	00052a23          	sw	zero,20(a0)
}
    800031ac:	00813403          	ld	s0,8(sp)
    800031b0:	01010113          	addi	sp,sp,16
    800031b4:	00008067          	ret

00000000800031b8 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    800031b8:	ff010113          	addi	sp,sp,-16
    800031bc:	00813423          	sd	s0,8(sp)
    800031c0:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    800031c4:	00100793          	li	a5,1
    800031c8:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    800031cc:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    800031d0:	00052a23          	sw	zero,20(a0)
    800031d4:	00813403          	ld	s0,8(sp)
    800031d8:	01010113          	addi	sp,sp,16
    800031dc:	00008067          	ret

00000000800031e0 <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    800031e0:	ff010113          	addi	sp,sp,-16
    800031e4:	00113423          	sd	ra,8(sp)
    800031e8:	00813023          	sd	s0,0(sp)
    800031ec:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    800031f0:	00001097          	auipc	ra,0x1
    800031f4:	f78080e7          	jalr	-136(ra) # 80004168 <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    800031f8:	00009797          	auipc	a5,0x9
    800031fc:	fd07b783          	ld	a5,-48(a5) # 8000c1c8 <_ZN3TCB7runningE>
    80003200:	0187b703          	ld	a4,24(a5)
    80003204:	0207b503          	ld	a0,32(a5)
    80003208:	000700e7          	jalr	a4
    thread_exit();
    8000320c:	fffff097          	auipc	ra,0xfffff
    80003210:	cc8080e7          	jalr	-824(ra) # 80001ed4 <_Z11thread_exitv>
}
    80003214:	00813083          	ld	ra,8(sp)
    80003218:	00013403          	ld	s0,0(sp)
    8000321c:	01010113          	addi	sp,sp,16
    80003220:	00008067          	ret

0000000080003224 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80003224:	ff010113          	addi	sp,sp,-16
    80003228:	00813423          	sd	s0,8(sp)
    8000322c:	01010413          	addi	s0,sp,16
    80003230:	04053823          	sd	zero,80(a0)
    80003234:	04053c23          	sd	zero,88(a0)
    80003238:	06053023          	sd	zero,96(a0)
    this->body = body;
    8000323c:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80003240:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80003244:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80003248:	02058a63          	beqz	a1,8000327c <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    8000324c:	00068793          	mv	a5,a3
    80003250:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80003254:	02058863          	beqz	a1,80003284 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80003258:	000017b7          	lui	a5,0x1
    8000325c:	00f686b3          	add	a3,a3,a5
    80003260:	00d53023          	sd	a3,0(a0)
    80003264:	00000797          	auipc	a5,0x0
    80003268:	f7c78793          	addi	a5,a5,-132 # 800031e0 <_ZN3TCB7wrapperEPv>
    8000326c:	00f53423          	sd	a5,8(a0)
}
    80003270:	00813403          	ld	s0,8(sp)
    80003274:	01010113          	addi	sp,sp,16
    80003278:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    8000327c:	00000793          	li	a5,0
    80003280:	fd1ff06f          	j	80003250 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80003284:	00000693          	li	a3,0
    80003288:	fd9ff06f          	j	80003260 <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

000000008000328c <_ZN3TCB4freeEv>:
void TCB::free(){
    8000328c:	ff010113          	addi	sp,sp,-16
    80003290:	00113423          	sd	ra,8(sp)
    80003294:	00813023          	sd	s0,0(sp)
    80003298:	01010413          	addi	s0,sp,16
    kfree(stack);
    8000329c:	02853503          	ld	a0,40(a0)
    800032a0:	00002097          	auipc	ra,0x2
    800032a4:	5d8080e7          	jalr	1496(ra) # 80005878 <_Z5kfreePKv>
}
    800032a8:	00813083          	ld	ra,8(sp)
    800032ac:	00013403          	ld	s0,0(sp)
    800032b0:	01010113          	addi	sp,sp,16
    800032b4:	00008067          	ret

00000000800032b8 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    800032b8:	ff010113          	addi	sp,sp,-16
    800032bc:	00113423          	sd	ra,8(sp)
    800032c0:	00813023          	sd	s0,0(sp)
    800032c4:	01010413          	addi	s0,sp,16
    free();
    800032c8:	00000097          	auipc	ra,0x0
    800032cc:	fc4080e7          	jalr	-60(ra) # 8000328c <_ZN3TCB4freeEv>
}
    800032d0:	00813083          	ld	ra,8(sp)
    800032d4:	00013403          	ld	s0,0(sp)
    800032d8:	01010113          	addi	sp,sp,16
    800032dc:	00008067          	ret

00000000800032e0 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    800032e0:	fe010113          	addi	sp,sp,-32
    800032e4:	00113c23          	sd	ra,24(sp)
    800032e8:	00813823          	sd	s0,16(sp)
    800032ec:	00913423          	sd	s1,8(sp)
    800032f0:	02010413          	addi	s0,sp,32
    TCB* old = running;
    800032f4:	00009497          	auipc	s1,0x9
    800032f8:	ed44b483          	ld	s1,-300(s1) # 8000c1c8 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    800032fc:	0104a703          	lw	a4,16(s1)
    80003300:	00100793          	li	a5,1
    80003304:	04e7f663          	bgeu	a5,a4,80003350 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80003308:	00002097          	auipc	ra,0x2
    8000330c:	de4080e7          	jalr	-540(ra) # 800050ec <_ZN9Scheduler3getEv>
    80003310:	00009797          	auipc	a5,0x9
    80003314:	eaa7bc23          	sd	a0,-328(a5) # 8000c1c8 <_ZN3TCB7runningE>
    if(running) {
    80003318:	02050263          	beqz	a0,8000333c <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    8000331c:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80003320:	00001097          	auipc	ra,0x1
    80003324:	f7c080e7          	jalr	-132(ra) # 8000429c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80003328:	00009597          	auipc	a1,0x9
    8000332c:	ea05b583          	ld	a1,-352(a1) # 8000c1c8 <_ZN3TCB7runningE>
    80003330:	00048513          	mv	a0,s1
    80003334:	ffffe097          	auipc	ra,0xffffe
    80003338:	e0c080e7          	jalr	-500(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    8000333c:	01813083          	ld	ra,24(sp)
    80003340:	01013403          	ld	s0,16(sp)
    80003344:	00813483          	ld	s1,8(sp)
    80003348:	02010113          	addi	sp,sp,32
    8000334c:	00008067          	ret
        Scheduler::put(old);
    80003350:	00048513          	mv	a0,s1
    80003354:	00002097          	auipc	ra,0x2
    80003358:	d50080e7          	jalr	-688(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>
    8000335c:	fadff06f          	j	80003308 <_ZN3TCB8dispatchEv+0x28>

0000000080003360 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80003360:	ff010113          	addi	sp,sp,-16
    80003364:	00113423          	sd	ra,8(sp)
    80003368:	00813023          	sd	s0,0(sp)
    8000336c:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80003370:	00009517          	auipc	a0,0x9
    80003374:	e6053503          	ld	a0,-416(a0) # 8000c1d0 <_ZN3TCB8tcbCacheE>
    80003378:	00002097          	auipc	ra,0x2
    8000337c:	408080e7          	jalr	1032(ra) # 80005780 <_Z16kmem_cache_allocP5Cache>
}
    80003380:	00813083          	ld	ra,8(sp)
    80003384:	00013403          	ld	s0,0(sp)
    80003388:	01010113          	addi	sp,sp,16
    8000338c:	00008067          	ret

0000000080003390 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80003390:	fe010113          	addi	sp,sp,-32
    80003394:	00113c23          	sd	ra,24(sp)
    80003398:	00813823          	sd	s0,16(sp)
    8000339c:	00913423          	sd	s1,8(sp)
    800033a0:	01213023          	sd	s2,0(sp)
    800033a4:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    800033a8:	00000697          	auipc	a3,0x0
    800033ac:	e1068693          	addi	a3,a3,-496 # 800031b8 <_ZN3TCB4dtorEPv>
    800033b0:	00000617          	auipc	a2,0x0
    800033b4:	de060613          	addi	a2,a2,-544 # 80003190 <_ZN3TCB4ctorEPv>
    800033b8:	07000593          	li	a1,112
    800033bc:	00006517          	auipc	a0,0x6
    800033c0:	f7450513          	addi	a0,a0,-140 # 80009330 <CONSOLE_STATUS+0x320>
    800033c4:	00002097          	auipc	ra,0x2
    800033c8:	394080e7          	jalr	916(ra) # 80005758 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800033cc:	00009797          	auipc	a5,0x9
    800033d0:	e0a7b223          	sd	a0,-508(a5) # 8000c1d0 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    800033d4:	07000513          	li	a0,112
    800033d8:	00000097          	auipc	ra,0x0
    800033dc:	f88080e7          	jalr	-120(ra) # 80003360 <_ZN3TCBnwEm>
    800033e0:	00050493          	mv	s1,a0
    800033e4:	00050e63          	beqz	a0,80003400 <_ZN3TCB10initializeEv+0x70>
    800033e8:	00200713          	li	a4,2
    800033ec:	00000693          	li	a3,0
    800033f0:	00000613          	li	a2,0
    800033f4:	00000593          	li	a1,0
    800033f8:	00000097          	auipc	ra,0x0
    800033fc:	e2c080e7          	jalr	-468(ra) # 80003224 <_ZN3TCBC1EPFvPvES0_Pmm>
    80003400:	00009797          	auipc	a5,0x9
    80003404:	dc97b423          	sd	s1,-568(a5) # 8000c1c8 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    80003408:	00100793          	li	a5,1
    8000340c:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80003410:	00001537          	lui	a0,0x1
    80003414:	00002097          	auipc	ra,0x2
    80003418:	43c080e7          	jalr	1084(ra) # 80005850 <_Z7kmallocm>
    8000341c:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80003420:	07000513          	li	a0,112
    80003424:	00000097          	auipc	ra,0x0
    80003428:	f3c080e7          	jalr	-196(ra) # 80003360 <_ZN3TCBnwEm>
    8000342c:	00050493          	mv	s1,a0
    80003430:	02050063          	beqz	a0,80003450 <_ZN3TCB10initializeEv+0xc0>
    80003434:	00200713          	li	a4,2
    80003438:	00090693          	mv	a3,s2
    8000343c:	00000613          	li	a2,0
    80003440:	00009597          	auipc	a1,0x9
    80003444:	b405b583          	ld	a1,-1216(a1) # 8000bf80 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003448:	00000097          	auipc	ra,0x0
    8000344c:	ddc080e7          	jalr	-548(ra) # 80003224 <_ZN3TCBC1EPFvPvES0_Pmm>
    80003450:	00009797          	auipc	a5,0x9
    80003454:	d897b423          	sd	s1,-632(a5) # 8000c1d8 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    80003458:	00100793          	li	a5,1
    8000345c:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    80003460:	00048513          	mv	a0,s1
    80003464:	00002097          	auipc	ra,0x2
    80003468:	c40080e7          	jalr	-960(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>
}
    8000346c:	01813083          	ld	ra,24(sp)
    80003470:	01013403          	ld	s0,16(sp)
    80003474:	00813483          	ld	s1,8(sp)
    80003478:	00013903          	ld	s2,0(sp)
    8000347c:	02010113          	addi	sp,sp,32
    80003480:	00008067          	ret

0000000080003484 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    80003484:	ff010113          	addi	sp,sp,-16
    80003488:	00113423          	sd	ra,8(sp)
    8000348c:	00813023          	sd	s0,0(sp)
    80003490:	01010413          	addi	s0,sp,16
    80003494:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    80003498:	00009517          	auipc	a0,0x9
    8000349c:	d3853503          	ld	a0,-712(a0) # 8000c1d0 <_ZN3TCB8tcbCacheE>
    800034a0:	00002097          	auipc	ra,0x2
    800034a4:	308080e7          	jalr	776(ra) # 800057a8 <_Z15kmem_cache_freeP5CachePv>
}
    800034a8:	00813083          	ld	ra,8(sp)
    800034ac:	00013403          	ld	s0,0(sp)
    800034b0:	01010113          	addi	sp,sp,16
    800034b4:	00008067          	ret

00000000800034b8 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    800034b8:	ff010113          	addi	sp,sp,-16
    800034bc:	00813423          	sd	s0,8(sp)
    800034c0:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    800034c4:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    800034c8:	05100513          	li	a0,81
    asm("ecall");
    800034cc:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    800034d0:	00050513          	mv	a0,a0
}
    800034d4:	0005051b          	sext.w	a0,a0
    800034d8:	00813403          	ld	s0,8(sp)
    800034dc:	01010113          	addi	sp,sp,16
    800034e0:	00008067          	ret

00000000800034e4 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    800034e4:	ff010113          	addi	sp,sp,-16
    800034e8:	00813423          	sd	s0,8(sp)
    800034ec:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    800034f0:	00009797          	auipc	a5,0x9
    800034f4:	a807b783          	ld	a5,-1408(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x18>
    800034f8:	0007b783          	ld	a5,0(a5)
    800034fc:	00c7d793          	srli	a5,a5,0xc
    80003500:	00278793          	addi	a5,a5,2
    80003504:	00c79793          	slli	a5,a5,0xc
    80003508:	01000737          	lui	a4,0x1000
    8000350c:	00e787b3          	add	a5,a5,a4
    80003510:	00009717          	auipc	a4,0x9
    80003514:	ce870713          	addi	a4,a4,-792 # 8000c1f8 <_ZN15MemoryAllocator11freeMemTailE>
    80003518:	00f73023          	sd	a5,0(a4)
    8000351c:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80003520:	0007b823          	sd	zero,16(a5)
    80003524:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80003528:	00073823          	sd	zero,16(a4)
    8000352c:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    80003530:	00009697          	auipc	a3,0x9
    80003534:	ac06b683          	ld	a3,-1344(a3) # 8000bff0 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003538:	0006b683          	ld	a3,0(a3)
    8000353c:	40f686b3          	sub	a3,a3,a5
    80003540:	fe868693          	addi	a3,a3,-24
    80003544:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80003548:	00873783          	ld	a5,8(a4)
    8000354c:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80003550:	00100793          	li	a5,1
    80003554:	02f70023          	sb	a5,32(a4)
}
    80003558:	00813403          	ld	s0,8(sp)
    8000355c:	01010113          	addi	sp,sp,16
    80003560:	00008067          	ret

0000000080003564 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80003564:	ff010113          	addi	sp,sp,-16
    80003568:	00813423          	sd	s0,8(sp)
    8000356c:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    80003570:	14050663          	beqz	a0,800036bc <_ZN15MemoryAllocator7kmallocEm+0x158>
    80003574:	00050793          	mv	a5,a0
    80003578:	00009517          	auipc	a0,0x9
    8000357c:	c8853503          	ld	a0,-888(a0) # 8000c200 <_ZN15MemoryAllocator11freeMemHeadE>
    80003580:	0a050e63          	beqz	a0,8000363c <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80003584:	00053703          	ld	a4,0(a0)
    80003588:	12f76e63          	bltu	a4,a5,800036c4 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    8000358c:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80003590:	00000613          	li	a2,0
    80003594:	00c0006f          	j	800035a0 <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80003598:	00050613          	mv	a2,a0
    8000359c:	01053503          	ld	a0,16(a0)
    800035a0:	00050863          	beqz	a0,800035b0 <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    800035a4:	00053683          	ld	a3,0(a0)
    800035a8:	01878713          	addi	a4,a5,24
    800035ac:	fee6e6e3          	bltu	a3,a4,80003598 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    800035b0:	08050663          	beqz	a0,8000363c <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    800035b4:	00053683          	ld	a3,0(a0)
    800035b8:	01868713          	addi	a4,a3,24
    800035bc:	00e50733          	add	a4,a0,a4
    800035c0:	00009597          	auipc	a1,0x9
    800035c4:	a305b583          	ld	a1,-1488(a1) # 8000bff0 <_GLOBAL_OFFSET_TABLE_+0x98>
    800035c8:	0005b583          	ld	a1,0(a1)
    800035cc:	00b76463          	bltu	a4,a1,800035d4 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    800035d0:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    800035d4:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    800035d8:	05700593          	li	a1,87
    800035dc:	08d5f063          	bgeu	a1,a3,8000365c <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    800035e0:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    800035e4:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    800035e8:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    800035ec:	01053583          	ld	a1,16(a0)
    800035f0:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    800035f4:	00853583          	ld	a1,8(a0)
    800035f8:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    800035fc:	fe868693          	addi	a3,a3,-24
    80003600:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80003604:	04060263          	beqz	a2,80003648 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80003608:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    8000360c:	00009797          	auipc	a5,0x9
    80003610:	c047b783          	ld	a5,-1020(a5) # 8000c210 <_ZN15MemoryAllocator12allocMemHeadE>
    80003614:	06078463          	beqz	a5,8000367c <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80003618:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    8000361c:	08070063          	beqz	a4,8000369c <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    80003620:	00873783          	ld	a5,8(a4)
    80003624:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80003628:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    8000362c:	00873783          	ld	a5,8(a4)
    80003630:	06078063          	beqz	a5,80003690 <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    80003634:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80003638:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    8000363c:	00813403          	ld	s0,8(sp)
    80003640:	01010113          	addi	sp,sp,16
    80003644:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80003648:	00009697          	auipc	a3,0x9
    8000364c:	bb068693          	addi	a3,a3,-1104 # 8000c1f8 <_ZN15MemoryAllocator11freeMemTailE>
    80003650:	00f6b023          	sd	a5,0(a3)
    80003654:	00f6b423          	sd	a5,8(a3)
    80003658:	fb5ff06f          	j	8000360c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    8000365c:	00060863          	beqz	a2,8000366c <_ZN15MemoryAllocator7kmallocEm+0x108>
    80003660:	01053783          	ld	a5,16(a0)
    80003664:	00f63823          	sd	a5,16(a2)
    80003668:	fa5ff06f          	j	8000360c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    8000366c:	01053783          	ld	a5,16(a0)
    80003670:	00009697          	auipc	a3,0x9
    80003674:	b8f6b823          	sd	a5,-1136(a3) # 8000c200 <_ZN15MemoryAllocator11freeMemHeadE>
    80003678:	f95ff06f          	j	8000360c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    8000367c:	00009797          	auipc	a5,0x9
    80003680:	b7c78793          	addi	a5,a5,-1156 # 8000c1f8 <_ZN15MemoryAllocator11freeMemTailE>
    80003684:	00a7b823          	sd	a0,16(a5)
    80003688:	00a7bc23          	sd	a0,24(a5)
    8000368c:	fadff06f          	j	80003638 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    80003690:	00009797          	auipc	a5,0x9
    80003694:	b8a7b023          	sd	a0,-1152(a5) # 8000c210 <_ZN15MemoryAllocator12allocMemHeadE>
    80003698:	fa1ff06f          	j	80003638 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    8000369c:	00009797          	auipc	a5,0x9
    800036a0:	b5c78793          	addi	a5,a5,-1188 # 8000c1f8 <_ZN15MemoryAllocator11freeMemTailE>
    800036a4:	0107b703          	ld	a4,16(a5)
    800036a8:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    800036ac:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    800036b0:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    800036b4:	00a7b823          	sd	a0,16(a5)
    800036b8:	f81ff06f          	j	80003638 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    800036bc:	00000513          	li	a0,0
    800036c0:	f7dff06f          	j	8000363c <_ZN15MemoryAllocator7kmallocEm+0xd8>
    800036c4:	00000513          	li	a0,0
    800036c8:	f75ff06f          	j	8000363c <_ZN15MemoryAllocator7kmallocEm+0xd8>

00000000800036cc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    800036cc:	ff010113          	addi	sp,sp,-16
    800036d0:	00813423          	sd	s0,8(sp)
    800036d4:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    800036d8:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800036dc:	00000713          	li	a4,0
    800036e0:	00078a63          	beqz	a5,800036f4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    800036e4:	00a7f863          	bgeu	a5,a0,800036f4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800036e8:	00078713          	mv	a4,a5
    800036ec:	0107b783          	ld	a5,16(a5)
    800036f0:	ff1ff06f          	j	800036e0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    800036f4:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    800036f8:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    800036fc:	00078463          	beqz	a5,80003704 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80003700:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80003704:	02070263          	beqz	a4,80003728 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003708:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    8000370c:	0005b703          	ld	a4,0(a1)
    80003710:	00009797          	auipc	a5,0x9
    80003714:	af07b783          	ld	a5,-1296(a5) # 8000c200 <_ZN15MemoryAllocator11freeMemHeadE>
    80003718:	00f70c63          	beq	a4,a5,80003730 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    8000371c:	00813403          	ld	s0,8(sp)
    80003720:	01010113          	addi	sp,sp,16
    80003724:	00008067          	ret
        *head = blk;
    80003728:	00a5b023          	sd	a0,0(a1)
    8000372c:	fe1ff06f          	j	8000370c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80003730:	01053783          	ld	a5,16(a0)
    80003734:	00078a63          	beqz	a5,80003748 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80003738:	00053683          	ld	a3,0(a0)
    8000373c:	00d50733          	add	a4,a0,a3
    80003740:	01870713          	addi	a4,a4,24
    80003744:	02f70e63          	beq	a4,a5,80003780 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80003748:	00853783          	ld	a5,8(a0)
    8000374c:	fc0788e3          	beqz	a5,8000371c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80003750:	0007b683          	ld	a3,0(a5)
    80003754:	00d78733          	add	a4,a5,a3
    80003758:	01870713          	addi	a4,a4,24
    8000375c:	fca710e3          	bne	a4,a0,8000371c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80003760:	00053703          	ld	a4,0(a0)
    80003764:	00e68733          	add	a4,a3,a4
    80003768:	01870713          	addi	a4,a4,24
    8000376c:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80003770:	00853783          	ld	a5,8(a0)
    80003774:	01053703          	ld	a4,16(a0)
    80003778:	00e7b823          	sd	a4,16(a5)
}
    8000377c:	fa1ff06f          	j	8000371c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80003780:	0007b703          	ld	a4,0(a5)
    80003784:	00e68733          	add	a4,a3,a4
    80003788:	01870713          	addi	a4,a4,24
    8000378c:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80003790:	0107b783          	ld	a5,16(a5)
    80003794:	00f53823          	sd	a5,16(a0)
    80003798:	fb1ff06f          	j	80003748 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

000000008000379c <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    8000379c:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    800037a0:	00009697          	auipc	a3,0x9
    800037a4:	a706b683          	ld	a3,-1424(a3) # 8000c210 <_ZN15MemoryAllocator12allocMemHeadE>
    800037a8:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    800037ac:	00050a63          	beqz	a0,800037c0 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    800037b0:	fe870793          	addi	a5,a4,-24
    800037b4:	00a78663          	beq	a5,a0,800037c0 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    800037b8:	01053503          	ld	a0,16(a0)
    800037bc:	ff1ff06f          	j	800037ac <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    800037c0:	08050463          	beqz	a0,80003848 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    800037c4:	ff010113          	addi	sp,sp,-16
    800037c8:	00113423          	sd	ra,8(sp)
    800037cc:	00813023          	sd	s0,0(sp)
    800037d0:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    800037d4:	00009797          	auipc	a5,0x9
    800037d8:	a347b783          	ld	a5,-1484(a5) # 8000c208 <_ZN15MemoryAllocator12allocMemTailE>
    800037dc:	04a78663          	beq	a5,a0,80003828 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    800037e0:	04d50c63          	beq	a0,a3,80003838 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    800037e4:	01053783          	ld	a5,16(a0)
    800037e8:	00078663          	beqz	a5,800037f4 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    800037ec:	00853703          	ld	a4,8(a0)
    800037f0:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    800037f4:	00853783          	ld	a5,8(a0)
    800037f8:	00078663          	beqz	a5,80003804 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    800037fc:	01053703          	ld	a4,16(a0)
    80003800:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80003804:	00009597          	auipc	a1,0x9
    80003808:	9fc58593          	addi	a1,a1,-1540 # 8000c200 <_ZN15MemoryAllocator11freeMemHeadE>
    8000380c:	00000097          	auipc	ra,0x0
    80003810:	ec0080e7          	jalr	-320(ra) # 800036cc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80003814:	00000513          	li	a0,0
}
    80003818:	00813083          	ld	ra,8(sp)
    8000381c:	00013403          	ld	s0,0(sp)
    80003820:	01010113          	addi	sp,sp,16
    80003824:	00008067          	ret
            allocMemTail = blk->prev;
    80003828:	00853783          	ld	a5,8(a0)
    8000382c:	00009717          	auipc	a4,0x9
    80003830:	9cf73e23          	sd	a5,-1572(a4) # 8000c208 <_ZN15MemoryAllocator12allocMemTailE>
    80003834:	fadff06f          	j	800037e0 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80003838:	01053783          	ld	a5,16(a0)
    8000383c:	00009717          	auipc	a4,0x9
    80003840:	9cf73a23          	sd	a5,-1580(a4) # 8000c210 <_ZN15MemoryAllocator12allocMemHeadE>
    80003844:	fa1ff06f          	j	800037e4 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80003848:	fff00513          	li	a0,-1
}
    8000384c:	00008067          	ret

0000000080003850 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80003850:	fe010113          	addi	sp,sp,-32
    80003854:	00113c23          	sd	ra,24(sp)
    80003858:	00813823          	sd	s0,16(sp)
    8000385c:	00913423          	sd	s1,8(sp)
    80003860:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80003864:	00009497          	auipc	s1,0x9
    80003868:	9ac4b483          	ld	s1,-1620(s1) # 8000c210 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    8000386c:	00006517          	auipc	a0,0x6
    80003870:	ad450513          	addi	a0,a0,-1324 # 80009340 <CONSOLE_STATUS+0x330>
    80003874:	fffff097          	auipc	ra,0xfffff
    80003878:	370080e7          	jalr	880(ra) # 80002be4 <_Z11printStringPKc>
    while(iter!=nullptr){
    8000387c:	04048663          	beqz	s1,800038c8 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80003880:	00000613          	li	a2,0
    80003884:	00a00593          	li	a1,10
    80003888:	0004851b          	sext.w	a0,s1
    8000388c:	fffff097          	auipc	ra,0xfffff
    80003890:	4f0080e7          	jalr	1264(ra) # 80002d7c <_Z8printIntiii>
        putc(' ');
    80003894:	02000513          	li	a0,32
    80003898:	fffff097          	auipc	ra,0xfffff
    8000389c:	860080e7          	jalr	-1952(ra) # 800020f8 <_Z4putcc>
        printInt(iter->size);
    800038a0:	00000613          	li	a2,0
    800038a4:	00a00593          	li	a1,10
    800038a8:	0004a503          	lw	a0,0(s1)
    800038ac:	fffff097          	auipc	ra,0xfffff
    800038b0:	4d0080e7          	jalr	1232(ra) # 80002d7c <_Z8printIntiii>
        putc('\n');
    800038b4:	00a00513          	li	a0,10
    800038b8:	fffff097          	auipc	ra,0xfffff
    800038bc:	840080e7          	jalr	-1984(ra) # 800020f8 <_Z4putcc>
        iter=iter->next;
    800038c0:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800038c4:	fb9ff06f          	j	8000387c <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    800038c8:	00006517          	auipc	a0,0x6
    800038cc:	a9850513          	addi	a0,a0,-1384 # 80009360 <CONSOLE_STATUS+0x350>
    800038d0:	fffff097          	auipc	ra,0xfffff
    800038d4:	314080e7          	jalr	788(ra) # 80002be4 <_Z11printStringPKc>
    iter = freeMemHead;
    800038d8:	00009497          	auipc	s1,0x9
    800038dc:	9284b483          	ld	s1,-1752(s1) # 8000c200 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    800038e0:	04048663          	beqz	s1,8000392c <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    800038e4:	00000613          	li	a2,0
    800038e8:	00a00593          	li	a1,10
    800038ec:	0004851b          	sext.w	a0,s1
    800038f0:	fffff097          	auipc	ra,0xfffff
    800038f4:	48c080e7          	jalr	1164(ra) # 80002d7c <_Z8printIntiii>
        putc(' ');
    800038f8:	02000513          	li	a0,32
    800038fc:	ffffe097          	auipc	ra,0xffffe
    80003900:	7fc080e7          	jalr	2044(ra) # 800020f8 <_Z4putcc>
        printInt(iter->size);
    80003904:	00000613          	li	a2,0
    80003908:	00a00593          	li	a1,10
    8000390c:	0004a503          	lw	a0,0(s1)
    80003910:	fffff097          	auipc	ra,0xfffff
    80003914:	46c080e7          	jalr	1132(ra) # 80002d7c <_Z8printIntiii>
        putc('\n');
    80003918:	00a00513          	li	a0,10
    8000391c:	ffffe097          	auipc	ra,0xffffe
    80003920:	7dc080e7          	jalr	2012(ra) # 800020f8 <_Z4putcc>
        iter=iter->next;
    80003924:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003928:	fb9ff06f          	j	800038e0 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    8000392c:	00006517          	auipc	a0,0x6
    80003930:	a5450513          	addi	a0,a0,-1452 # 80009380 <CONSOLE_STATUS+0x370>
    80003934:	fffff097          	auipc	ra,0xfffff
    80003938:	2b0080e7          	jalr	688(ra) # 80002be4 <_Z11printStringPKc>
}
    8000393c:	01813083          	ld	ra,24(sp)
    80003940:	01013403          	ld	s0,16(sp)
    80003944:	00813483          	ld	s1,8(sp)
    80003948:	02010113          	addi	sp,sp,32
    8000394c:	00008067          	ret

0000000080003950 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80003950:	ff010113          	addi	sp,sp,-16
    80003954:	00813423          	sd	s0,8(sp)
    80003958:	01010413          	addi	s0,sp,16
    8000395c:	00050813          	mv	a6,a0
    80003960:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80003964:	00000793          	li	a5,0
    80003968:	00c7fe63          	bgeu	a5,a2,80003984 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    8000396c:	00f50733          	add	a4,a0,a5
    80003970:	00f806b3          	add	a3,a6,a5
    80003974:	0006c683          	lbu	a3,0(a3)
    80003978:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    8000397c:	00178793          	addi	a5,a5,1
    80003980:	fe9ff06f          	j	80003968 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80003984:	00813403          	ld	s0,8(sp)
    80003988:	01010113          	addi	sp,sp,16
    8000398c:	00008067          	ret

0000000080003990 <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    80003990:	ff010113          	addi	sp,sp,-16
    80003994:	00113423          	sd	ra,8(sp)
    80003998:	00813023          	sd	s0,0(sp)
    8000399c:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    800039a0:	00053783          	ld	a5,0(a0)
    800039a4:	0107b783          	ld	a5,16(a5)
    800039a8:	000780e7          	jalr	a5
}
    800039ac:	00813083          	ld	ra,8(sp)
    800039b0:	00013403          	ld	s0,0(sp)
    800039b4:	01010113          	addi	sp,sp,16
    800039b8:	00008067          	ret

00000000800039bc <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    800039bc:	ff010113          	addi	sp,sp,-16
    800039c0:	00113423          	sd	ra,8(sp)
    800039c4:	00813023          	sd	s0,0(sp)
    800039c8:	01010413          	addi	s0,sp,16
    800039cc:	00008797          	auipc	a5,0x8
    800039d0:	4d478793          	addi	a5,a5,1236 # 8000bea0 <_ZTV9Semaphore+0x10>
    800039d4:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800039d8:	00853503          	ld	a0,8(a0)
    800039dc:	ffffe097          	auipc	ra,0xffffe
    800039e0:	644080e7          	jalr	1604(ra) # 80002020 <_Z9sem_closeP10_semaphore>
};
    800039e4:	00813083          	ld	ra,8(sp)
    800039e8:	00013403          	ld	s0,0(sp)
    800039ec:	01010113          	addi	sp,sp,16
    800039f0:	00008067          	ret

00000000800039f4 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    800039f4:	00008797          	auipc	a5,0x8
    800039f8:	4cc78793          	addi	a5,a5,1228 # 8000bec0 <_ZTV6Thread+0x10>
    800039fc:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80003a00:	00853503          	ld	a0,8(a0)
    80003a04:	02050663          	beqz	a0,80003a30 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80003a08:	ff010113          	addi	sp,sp,-16
    80003a0c:	00113423          	sd	ra,8(sp)
    80003a10:	00813023          	sd	s0,0(sp)
    80003a14:	01010413          	addi	s0,sp,16
    delete myHandle;
    80003a18:	ffffe097          	auipc	ra,0xffffe
    80003a1c:	754080e7          	jalr	1876(ra) # 8000216c <_ZN7_threaddlEPv>
}
    80003a20:	00813083          	ld	ra,8(sp)
    80003a24:	00013403          	ld	s0,0(sp)
    80003a28:	01010113          	addi	sp,sp,16
    80003a2c:	00008067          	ret
    80003a30:	00008067          	ret

0000000080003a34 <_Znwm>:
void* operator new(size_t sz){
    80003a34:	ff010113          	addi	sp,sp,-16
    80003a38:	00113423          	sd	ra,8(sp)
    80003a3c:	00813023          	sd	s0,0(sp)
    80003a40:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003a44:	ffffe097          	auipc	ra,0xffffe
    80003a48:	3a8080e7          	jalr	936(ra) # 80001dec <_Z9mem_allocm>
}
    80003a4c:	00813083          	ld	ra,8(sp)
    80003a50:	00013403          	ld	s0,0(sp)
    80003a54:	01010113          	addi	sp,sp,16
    80003a58:	00008067          	ret

0000000080003a5c <_Znam>:
void* operator new[](size_t sz){
    80003a5c:	ff010113          	addi	sp,sp,-16
    80003a60:	00113423          	sd	ra,8(sp)
    80003a64:	00813023          	sd	s0,0(sp)
    80003a68:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003a6c:	ffffe097          	auipc	ra,0xffffe
    80003a70:	380080e7          	jalr	896(ra) # 80001dec <_Z9mem_allocm>
}
    80003a74:	00813083          	ld	ra,8(sp)
    80003a78:	00013403          	ld	s0,0(sp)
    80003a7c:	01010113          	addi	sp,sp,16
    80003a80:	00008067          	ret

0000000080003a84 <_ZdlPv>:
void operator delete(void *ptr){
    80003a84:	ff010113          	addi	sp,sp,-16
    80003a88:	00113423          	sd	ra,8(sp)
    80003a8c:	00813023          	sd	s0,0(sp)
    80003a90:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80003a94:	ffffe097          	auipc	ra,0xffffe
    80003a98:	388080e7          	jalr	904(ra) # 80001e1c <_Z8mem_freePv>
}
    80003a9c:	00813083          	ld	ra,8(sp)
    80003aa0:	00013403          	ld	s0,0(sp)
    80003aa4:	01010113          	addi	sp,sp,16
    80003aa8:	00008067          	ret

0000000080003aac <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80003aac:	fe010113          	addi	sp,sp,-32
    80003ab0:	00113c23          	sd	ra,24(sp)
    80003ab4:	00813823          	sd	s0,16(sp)
    80003ab8:	00913423          	sd	s1,8(sp)
    80003abc:	02010413          	addi	s0,sp,32
    80003ac0:	00050493          	mv	s1,a0
};
    80003ac4:	00000097          	auipc	ra,0x0
    80003ac8:	ef8080e7          	jalr	-264(ra) # 800039bc <_ZN9SemaphoreD1Ev>
    80003acc:	00048513          	mv	a0,s1
    80003ad0:	00000097          	auipc	ra,0x0
    80003ad4:	fb4080e7          	jalr	-76(ra) # 80003a84 <_ZdlPv>
    80003ad8:	01813083          	ld	ra,24(sp)
    80003adc:	01013403          	ld	s0,16(sp)
    80003ae0:	00813483          	ld	s1,8(sp)
    80003ae4:	02010113          	addi	sp,sp,32
    80003ae8:	00008067          	ret

0000000080003aec <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80003aec:	fe010113          	addi	sp,sp,-32
    80003af0:	00113c23          	sd	ra,24(sp)
    80003af4:	00813823          	sd	s0,16(sp)
    80003af8:	00913423          	sd	s1,8(sp)
    80003afc:	02010413          	addi	s0,sp,32
    80003b00:	00050493          	mv	s1,a0
}
    80003b04:	00000097          	auipc	ra,0x0
    80003b08:	ef0080e7          	jalr	-272(ra) # 800039f4 <_ZN6ThreadD1Ev>
    80003b0c:	00048513          	mv	a0,s1
    80003b10:	00000097          	auipc	ra,0x0
    80003b14:	f74080e7          	jalr	-140(ra) # 80003a84 <_ZdlPv>
    80003b18:	01813083          	ld	ra,24(sp)
    80003b1c:	01013403          	ld	s0,16(sp)
    80003b20:	00813483          	ld	s1,8(sp)
    80003b24:	02010113          	addi	sp,sp,32
    80003b28:	00008067          	ret

0000000080003b2c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80003b2c:	ff010113          	addi	sp,sp,-16
    80003b30:	00113423          	sd	ra,8(sp)
    80003b34:	00813023          	sd	s0,0(sp)
    80003b38:	01010413          	addi	s0,sp,16
    80003b3c:	00008797          	auipc	a5,0x8
    80003b40:	36478793          	addi	a5,a5,868 # 8000bea0 <_ZTV9Semaphore+0x10>
    80003b44:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80003b48:	00850513          	addi	a0,a0,8
    80003b4c:	ffffe097          	auipc	ra,0xffffe
    80003b50:	49c080e7          	jalr	1180(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
}
    80003b54:	00813083          	ld	ra,8(sp)
    80003b58:	00013403          	ld	s0,0(sp)
    80003b5c:	01010113          	addi	sp,sp,16
    80003b60:	00008067          	ret

0000000080003b64 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80003b64:	ff010113          	addi	sp,sp,-16
    80003b68:	00113423          	sd	ra,8(sp)
    80003b6c:	00813023          	sd	s0,0(sp)
    80003b70:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80003b74:	00853503          	ld	a0,8(a0)
    80003b78:	ffffe097          	auipc	ra,0xffffe
    80003b7c:	4d4080e7          	jalr	1236(ra) # 8000204c <_Z8sem_waitP10_semaphore>
}
    80003b80:	00813083          	ld	ra,8(sp)
    80003b84:	00013403          	ld	s0,0(sp)
    80003b88:	01010113          	addi	sp,sp,16
    80003b8c:	00008067          	ret

0000000080003b90 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80003b90:	ff010113          	addi	sp,sp,-16
    80003b94:	00113423          	sd	ra,8(sp)
    80003b98:	00813023          	sd	s0,0(sp)
    80003b9c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003ba0:	00853503          	ld	a0,8(a0)
    80003ba4:	ffffe097          	auipc	ra,0xffffe
    80003ba8:	4d4080e7          	jalr	1236(ra) # 80002078 <_Z10sem_signalP10_semaphore>
}
    80003bac:	00813083          	ld	ra,8(sp)
    80003bb0:	00013403          	ld	s0,0(sp)
    80003bb4:	01010113          	addi	sp,sp,16
    80003bb8:	00008067          	ret

0000000080003bbc <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80003bbc:	fe010113          	addi	sp,sp,-32
    80003bc0:	00113c23          	sd	ra,24(sp)
    80003bc4:	00813823          	sd	s0,16(sp)
    80003bc8:	00913423          	sd	s1,8(sp)
    80003bcc:	02010413          	addi	s0,sp,32
    80003bd0:	00050493          	mv	s1,a0
    80003bd4:	00008797          	auipc	a5,0x8
    80003bd8:	2ec78793          	addi	a5,a5,748 # 8000bec0 <_ZTV6Thread+0x10>
    80003bdc:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    80003be0:	00850513          	addi	a0,a0,8
    80003be4:	ffffe097          	auipc	ra,0xffffe
    80003be8:	338080e7          	jalr	824(ra) # 80001f1c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80003bec:	fff00793          	li	a5,-1
    80003bf0:	00f50c63          	beq	a0,a5,80003c08 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    80003bf4:	01813083          	ld	ra,24(sp)
    80003bf8:	01013403          	ld	s0,16(sp)
    80003bfc:	00813483          	ld	s1,8(sp)
    80003c00:	02010113          	addi	sp,sp,32
    80003c04:	00008067          	ret
        myHandle = nullptr;
    80003c08:	0004b423          	sd	zero,8(s1)
}
    80003c0c:	fe9ff06f          	j	80003bf4 <_ZN6ThreadC1EPFvPvES0_+0x38>

0000000080003c10 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80003c10:	fe010113          	addi	sp,sp,-32
    80003c14:	00113c23          	sd	ra,24(sp)
    80003c18:	00813823          	sd	s0,16(sp)
    80003c1c:	00913423          	sd	s1,8(sp)
    80003c20:	02010413          	addi	s0,sp,32
    80003c24:	00050493          	mv	s1,a0
    80003c28:	00008797          	auipc	a5,0x8
    80003c2c:	29878793          	addi	a5,a5,664 # 8000bec0 <_ZTV6Thread+0x10>
    80003c30:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    80003c34:	00050613          	mv	a2,a0
    80003c38:	00000597          	auipc	a1,0x0
    80003c3c:	d5858593          	addi	a1,a1,-680 # 80003990 <_ZN6Thread7wrapperEPv>
    80003c40:	00850513          	addi	a0,a0,8
    80003c44:	ffffe097          	auipc	ra,0xffffe
    80003c48:	2d8080e7          	jalr	728(ra) # 80001f1c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80003c4c:	fff00793          	li	a5,-1
    80003c50:	00f50c63          	beq	a0,a5,80003c68 <_ZN6ThreadC1Ev+0x58>
}
    80003c54:	01813083          	ld	ra,24(sp)
    80003c58:	01013403          	ld	s0,16(sp)
    80003c5c:	00813483          	ld	s1,8(sp)
    80003c60:	02010113          	addi	sp,sp,32
    80003c64:	00008067          	ret
        myHandle = nullptr;
    80003c68:	0004b423          	sd	zero,8(s1)
}
    80003c6c:	fe9ff06f          	j	80003c54 <_ZN6ThreadC1Ev+0x44>

0000000080003c70 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003c70:	ff010113          	addi	sp,sp,-16
    80003c74:	00113423          	sd	ra,8(sp)
    80003c78:	00813023          	sd	s0,0(sp)
    80003c7c:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003c80:	ffffe097          	auipc	ra,0xffffe
    80003c84:	424080e7          	jalr	1060(ra) # 800020a4 <_Z10time_sleepm>
}
    80003c88:	00813083          	ld	ra,8(sp)
    80003c8c:	00013403          	ld	s0,0(sp)
    80003c90:	01010113          	addi	sp,sp,16
    80003c94:	00008067          	ret

0000000080003c98 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80003c98:	fe010113          	addi	sp,sp,-32
    80003c9c:	00113c23          	sd	ra,24(sp)
    80003ca0:	00813823          	sd	s0,16(sp)
    80003ca4:	00913423          	sd	s1,8(sp)
    80003ca8:	01213023          	sd	s2,0(sp)
    80003cac:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80003cb0:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80003cb4:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80003cb8:	0004b783          	ld	a5,0(s1)
    80003cbc:	0187b783          	ld	a5,24(a5)
    80003cc0:	00048513          	mv	a0,s1
    80003cc4:	000780e7          	jalr	a5
        pt->sleep(time);
    80003cc8:	00090513          	mv	a0,s2
    80003ccc:	00000097          	auipc	ra,0x0
    80003cd0:	fa4080e7          	jalr	-92(ra) # 80003c70 <_ZN6Thread5sleepEm>
    while(true){
    80003cd4:	fe5ff06f          	j	80003cb8 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080003cd8 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80003cd8:	ff010113          	addi	sp,sp,-16
    80003cdc:	00113423          	sd	ra,8(sp)
    80003ce0:	00813023          	sd	s0,0(sp)
    80003ce4:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003ce8:	ffffe097          	auipc	ra,0xffffe
    80003cec:	214080e7          	jalr	532(ra) # 80001efc <_Z15thread_dispatchv>
}
    80003cf0:	00813083          	ld	ra,8(sp)
    80003cf4:	00013403          	ld	s0,0(sp)
    80003cf8:	01010113          	addi	sp,sp,16
    80003cfc:	00008067          	ret

0000000080003d00 <_ZN6Thread5startEv>:
int Thread::start() {
    80003d00:	ff010113          	addi	sp,sp,-16
    80003d04:	00113423          	sd	ra,8(sp)
    80003d08:	00813023          	sd	s0,0(sp)
    80003d0c:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80003d10:	00853503          	ld	a0,8(a0)
    80003d14:	ffffe097          	auipc	ra,0xffffe
    80003d18:	29c080e7          	jalr	668(ra) # 80001fb0 <_Z12thread_startP7_thread>
}
    80003d1c:	00813083          	ld	ra,8(sp)
    80003d20:	00013403          	ld	s0,0(sp)
    80003d24:	01010113          	addi	sp,sp,16
    80003d28:	00008067          	ret

0000000080003d2c <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003d2c:	fe010113          	addi	sp,sp,-32
    80003d30:	00113c23          	sd	ra,24(sp)
    80003d34:	00813823          	sd	s0,16(sp)
    80003d38:	00913423          	sd	s1,8(sp)
    80003d3c:	01213023          	sd	s2,0(sp)
    80003d40:	02010413          	addi	s0,sp,32
    80003d44:	00050493          	mv	s1,a0
    80003d48:	00058913          	mv	s2,a1
    80003d4c:	01000513          	li	a0,16
    80003d50:	00000097          	auipc	ra,0x0
    80003d54:	ce4080e7          	jalr	-796(ra) # 80003a34 <_Znwm>
    80003d58:	00050613          	mv	a2,a0
    80003d5c:	00050663          	beqz	a0,80003d68 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    80003d60:	00953023          	sd	s1,0(a0)
    80003d64:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003d68:	00000597          	auipc	a1,0x0
    80003d6c:	f3058593          	addi	a1,a1,-208 # 80003c98 <_ZN14PeriodicThread7wrapperEPv>
    80003d70:	00048513          	mv	a0,s1
    80003d74:	00000097          	auipc	ra,0x0
    80003d78:	e48080e7          	jalr	-440(ra) # 80003bbc <_ZN6ThreadC1EPFvPvES0_>
    80003d7c:	00008797          	auipc	a5,0x8
    80003d80:	0f478793          	addi	a5,a5,244 # 8000be70 <_ZTV14PeriodicThread+0x10>
    80003d84:	00f4b023          	sd	a5,0(s1)
    80003d88:	01813083          	ld	ra,24(sp)
    80003d8c:	01013403          	ld	s0,16(sp)
    80003d90:	00813483          	ld	s1,8(sp)
    80003d94:	00013903          	ld	s2,0(sp)
    80003d98:	02010113          	addi	sp,sp,32
    80003d9c:	00008067          	ret

0000000080003da0 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80003da0:	ff010113          	addi	sp,sp,-16
    80003da4:	00113423          	sd	ra,8(sp)
    80003da8:	00813023          	sd	s0,0(sp)
    80003dac:	01010413          	addi	s0,sp,16
    return ::getc();
    80003db0:	ffffe097          	auipc	ra,0xffffe
    80003db4:	320080e7          	jalr	800(ra) # 800020d0 <_Z4getcv>
}
    80003db8:	00813083          	ld	ra,8(sp)
    80003dbc:	00013403          	ld	s0,0(sp)
    80003dc0:	01010113          	addi	sp,sp,16
    80003dc4:	00008067          	ret

0000000080003dc8 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003dc8:	ff010113          	addi	sp,sp,-16
    80003dcc:	00113423          	sd	ra,8(sp)
    80003dd0:	00813023          	sd	s0,0(sp)
    80003dd4:	01010413          	addi	s0,sp,16
    ::putc(c);
    80003dd8:	ffffe097          	auipc	ra,0xffffe
    80003ddc:	320080e7          	jalr	800(ra) # 800020f8 <_Z4putcc>
}
    80003de0:	00813083          	ld	ra,8(sp)
    80003de4:	00013403          	ld	s0,0(sp)
    80003de8:	01010113          	addi	sp,sp,16
    80003dec:	00008067          	ret

0000000080003df0 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003df0:	ff010113          	addi	sp,sp,-16
    80003df4:	00813423          	sd	s0,8(sp)
    80003df8:	01010413          	addi	s0,sp,16
    80003dfc:	00813403          	ld	s0,8(sp)
    80003e00:	01010113          	addi	sp,sp,16
    80003e04:	00008067          	ret

0000000080003e08 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80003e08:	ff010113          	addi	sp,sp,-16
    80003e0c:	00813423          	sd	s0,8(sp)
    80003e10:	01010413          	addi	s0,sp,16
    80003e14:	00813403          	ld	s0,8(sp)
    80003e18:	01010113          	addi	sp,sp,16
    80003e1c:	00008067          	ret

0000000080003e20 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80003e20:	ff010113          	addi	sp,sp,-16
    80003e24:	00113423          	sd	ra,8(sp)
    80003e28:	00813023          	sd	s0,0(sp)
    80003e2c:	01010413          	addi	s0,sp,16
    80003e30:	00008797          	auipc	a5,0x8
    80003e34:	04078793          	addi	a5,a5,64 # 8000be70 <_ZTV14PeriodicThread+0x10>
    80003e38:	00f53023          	sd	a5,0(a0)
    80003e3c:	00000097          	auipc	ra,0x0
    80003e40:	bb8080e7          	jalr	-1096(ra) # 800039f4 <_ZN6ThreadD1Ev>
    80003e44:	00813083          	ld	ra,8(sp)
    80003e48:	00013403          	ld	s0,0(sp)
    80003e4c:	01010113          	addi	sp,sp,16
    80003e50:	00008067          	ret

0000000080003e54 <_ZN14PeriodicThreadD0Ev>:
    80003e54:	fe010113          	addi	sp,sp,-32
    80003e58:	00113c23          	sd	ra,24(sp)
    80003e5c:	00813823          	sd	s0,16(sp)
    80003e60:	00913423          	sd	s1,8(sp)
    80003e64:	02010413          	addi	s0,sp,32
    80003e68:	00050493          	mv	s1,a0
    80003e6c:	00008797          	auipc	a5,0x8
    80003e70:	00478793          	addi	a5,a5,4 # 8000be70 <_ZTV14PeriodicThread+0x10>
    80003e74:	00f53023          	sd	a5,0(a0)
    80003e78:	00000097          	auipc	ra,0x0
    80003e7c:	b7c080e7          	jalr	-1156(ra) # 800039f4 <_ZN6ThreadD1Ev>
    80003e80:	00048513          	mv	a0,s1
    80003e84:	00000097          	auipc	ra,0x0
    80003e88:	c00080e7          	jalr	-1024(ra) # 80003a84 <_ZdlPv>
    80003e8c:	01813083          	ld	ra,24(sp)
    80003e90:	01013403          	ld	s0,16(sp)
    80003e94:	00813483          	ld	s1,8(sp)
    80003e98:	02010113          	addi	sp,sp,32
    80003e9c:	00008067          	ret

0000000080003ea0 <_ZN5RiscV6getPMTEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;
void* RiscV::PMT = nullptr;

void* RiscV::getPMT(){
    80003ea0:	ff010113          	addi	sp,sp,-16
    80003ea4:	00113423          	sd	ra,8(sp)
    80003ea8:	00813023          	sd	s0,0(sp)
    80003eac:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    80003eb0:	00100513          	li	a0,1
    80003eb4:	fffff097          	auipc	ra,0xfffff
    80003eb8:	b8c080e7          	jalr	-1140(ra) # 80002a40 <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80003ebc:	00000793          	li	a5,0
    80003ec0:	1ff00713          	li	a4,511
    80003ec4:	00f74c63          	blt	a4,a5,80003edc <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    80003ec8:	00379713          	slli	a4,a5,0x3
    80003ecc:	00e50733          	add	a4,a0,a4
    80003ed0:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    80003ed4:	0017879b          	addiw	a5,a5,1
    80003ed8:	fe9ff06f          	j	80003ec0 <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    80003edc:	00813083          	ld	ra,8(sp)
    80003ee0:	00013403          	ld	s0,0(sp)
    80003ee4:	01010113          	addi	sp,sp,16
    80003ee8:	00008067          	ret

0000000080003eec <_ZN5RiscV15handlePageFaultEmm>:

void RiscV::handlePageFault(uint64 addr, uint64 mask){
    80003eec:	fc010113          	addi	sp,sp,-64
    80003ef0:	02113c23          	sd	ra,56(sp)
    80003ef4:	02813823          	sd	s0,48(sp)
    80003ef8:	02913423          	sd	s1,40(sp)
    80003efc:	03213023          	sd	s2,32(sp)
    80003f00:	01313c23          	sd	s3,24(sp)
    80003f04:	01413823          	sd	s4,16(sp)
    80003f08:	01513423          	sd	s5,8(sp)
    80003f0c:	04010413          	addi	s0,sp,64
    80003f10:	00058993          	mv	s3,a1
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    80003f14:	01e55a93          	srli	s5,a0,0x1e
    80003f18:	1ffafa93          	andi	s5,s5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    80003f1c:	01555913          	srli	s2,a0,0x15
    80003f20:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    80003f24:	00c55493          	srli	s1,a0,0xc
    80003f28:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80003f2c:	003a9a93          	slli	s5,s5,0x3
    80003f30:	00008797          	auipc	a5,0x8
    80003f34:	2f07b783          	ld	a5,752(a5) # 8000c220 <_ZN5RiscV3PMTE>
    80003f38:	015787b3          	add	a5,a5,s5
    80003f3c:	0007b503          	ld	a0,0(a5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80003f40:	06050263          	beqz	a0,80003fa4 <_ZN5RiscV15handlePageFaultEmm+0xb8>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80003f44:	00a55513          	srli	a0,a0,0xa
    80003f48:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    80003f4c:	00391913          	slli	s2,s2,0x3
    80003f50:	01250933          	add	s2,a0,s2
    80003f54:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    80003f58:	06050a63          	beqz	a0,80003fcc <_ZN5RiscV15handlePageFaultEmm+0xe0>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    80003f5c:	00a55513          	srli	a0,a0,0xa
    80003f60:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    80003f64:	003a1a13          	slli	s4,s4,0x3
    80003f68:	01450533          	add	a0,a0,s4
    80003f6c:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0)
    80003f70:	00079863          	bnez	a5,80003f80 <_ZN5RiscV15handlePageFaultEmm+0x94>
        ((uint64*)pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    80003f74:	00a49493          	slli	s1,s1,0xa
    80003f78:	0134e9b3          	or	s3,s1,s3
    80003f7c:	01353023          	sd	s3,0(a0)
}
    80003f80:	03813083          	ld	ra,56(sp)
    80003f84:	03013403          	ld	s0,48(sp)
    80003f88:	02813483          	ld	s1,40(sp)
    80003f8c:	02013903          	ld	s2,32(sp)
    80003f90:	01813983          	ld	s3,24(sp)
    80003f94:	01013a03          	ld	s4,16(sp)
    80003f98:	00813a83          	ld	s5,8(sp)
    80003f9c:	04010113          	addi	sp,sp,64
    80003fa0:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80003fa4:	00000097          	auipc	ra,0x0
    80003fa8:	efc080e7          	jalr	-260(ra) # 80003ea0 <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    80003fac:	00c55793          	srli	a5,a0,0xc
    80003fb0:	00a79793          	slli	a5,a5,0xa
    80003fb4:	00008717          	auipc	a4,0x8
    80003fb8:	26c73703          	ld	a4,620(a4) # 8000c220 <_ZN5RiscV3PMTE>
    80003fbc:	01570ab3          	add	s5,a4,s5
    80003fc0:	0017e793          	ori	a5,a5,1
    80003fc4:	00fab023          	sd	a5,0(s5)
    80003fc8:	f85ff06f          	j	80003f4c <_ZN5RiscV15handlePageFaultEmm+0x60>
        pmt0 = RiscV::getPMT();
    80003fcc:	00000097          	auipc	ra,0x0
    80003fd0:	ed4080e7          	jalr	-300(ra) # 80003ea0 <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    80003fd4:	00c55793          	srli	a5,a0,0xc
    80003fd8:	00a79793          	slli	a5,a5,0xa
    80003fdc:	0017e793          	ori	a5,a5,1
    80003fe0:	00f93023          	sd	a5,0(s2)
    80003fe4:	f81ff06f          	j	80003f64 <_ZN5RiscV15handlePageFaultEmm+0x78>

0000000080003fe8 <_ZN5RiscV10initializeEv>:
//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80003fe8:	fe010113          	addi	sp,sp,-32
    80003fec:	00113c23          	sd	ra,24(sp)
    80003ff0:	00813823          	sd	s0,16(sp)
    80003ff4:	00913423          	sd	s1,8(sp)
    80003ff8:	02010413          	addi	s0,sp,32
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003ffc:	00008797          	auipc	a5,0x8
    80004000:	fc47b783          	ld	a5,-60(a5) # 8000bfc0 <_GLOBAL_OFFSET_TABLE_+0x68>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80004004:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80004008:	00008797          	auipc	a5,0x8
    8000400c:	f687b783          	ld	a5,-152(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004010:	0007b503          	ld	a0,0(a5)
    80004014:	00c55513          	srli	a0,a0,0xc
    80004018:	00250513          	addi	a0,a0,2
    8000401c:	000015b7          	lui	a1,0x1
    80004020:	00c51513          	slli	a0,a0,0xc
    80004024:	00001097          	auipc	ra,0x1
    80004028:	70c080e7          	jalr	1804(ra) # 80005730 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    8000402c:	fffff097          	auipc	ra,0xfffff
    80004030:	4b8080e7          	jalr	1208(ra) # 800034e4 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80004034:	00001097          	auipc	ra,0x1
    80004038:	058080e7          	jalr	88(ra) # 8000508c <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    8000403c:	fffff097          	auipc	ra,0xfffff
    80004040:	354080e7          	jalr	852(ra) # 80003390 <_ZN3TCB10initializeEv>
    SCB::initialize();
    80004044:	fffff097          	auipc	ra,0xfffff
    80004048:	e8c080e7          	jalr	-372(ra) # 80002ed0 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    8000404c:	00001097          	auipc	ra,0x1
    80004050:	254080e7          	jalr	596(ra) # 800052a0 <_ZN11ConsoleUtil10initializeEv>
    RiscV::PMT = getPMT();
    80004054:	00000097          	auipc	ra,0x0
    80004058:	e4c080e7          	jalr	-436(ra) # 80003ea0 <_ZN5RiscV6getPMTEv>
    8000405c:	00008797          	auipc	a5,0x8
    80004060:	1ca7b223          	sd	a0,452(a5) # 8000c220 <_ZN5RiscV3PMTE>
    for(uint64 i=0x80000000;i<(uint64)HEAP_END_ADDR;i+=4096)
    80004064:	00100493          	li	s1,1
    80004068:	01f49493          	slli	s1,s1,0x1f
    8000406c:	00008797          	auipc	a5,0x8
    80004070:	f847b783          	ld	a5,-124(a5) # 8000bff0 <_GLOBAL_OFFSET_TABLE_+0x98>
    80004074:	0007b783          	ld	a5,0(a5)
    80004078:	02f4f063          	bgeu	s1,a5,80004098 <_ZN5RiscV10initializeEv+0xb0>
        handlePageFault(i,0xf);
    8000407c:	00f00593          	li	a1,15
    80004080:	00048513          	mv	a0,s1
    80004084:	00000097          	auipc	ra,0x0
    80004088:	e68080e7          	jalr	-408(ra) # 80003eec <_ZN5RiscV15handlePageFaultEmm>
    for(uint64 i=0x80000000;i<(uint64)HEAP_END_ADDR;i+=4096)
    8000408c:	000017b7          	lui	a5,0x1
    80004090:	00f484b3          	add	s1,s1,a5
    80004094:	fd9ff06f          	j	8000406c <_ZN5RiscV10initializeEv+0x84>
//                            ConsoleUtil::print("desc: ",((uint64*)pmt0)[i]>>10,"\n",16);
//                        }
//                }
//        }

    handlePageFault((uint64)CONSOLE_IRQ,0xf);
    80004098:	00f00593          	li	a1,15
    8000409c:	00a00513          	li	a0,10
    800040a0:	00000097          	auipc	ra,0x0
    800040a4:	e4c080e7          	jalr	-436(ra) # 80003eec <_ZN5RiscV15handlePageFaultEmm>
    handlePageFault((uint64)CONSOLE_RX_STATUS_BIT,0xf);
    800040a8:	00f00593          	li	a1,15
    800040ac:	00100513          	li	a0,1
    800040b0:	00000097          	auipc	ra,0x0
    800040b4:	e3c080e7          	jalr	-452(ra) # 80003eec <_ZN5RiscV15handlePageFaultEmm>
    handlePageFault((uint64)CONSOLE_TX_STATUS_BIT,0xf);
    800040b8:	00f00593          	li	a1,15
    800040bc:	02000513          	li	a0,32
    800040c0:	00000097          	auipc	ra,0x0
    800040c4:	e2c080e7          	jalr	-468(ra) # 80003eec <_ZN5RiscV15handlePageFaultEmm>
    handlePageFault((uint64)CONSOLE_RX_DATA,0xf);
    800040c8:	00f00593          	li	a1,15
    800040cc:	00008797          	auipc	a5,0x8
    800040d0:	e947b783          	ld	a5,-364(a5) # 8000bf60 <_GLOBAL_OFFSET_TABLE_+0x8>
    800040d4:	0007b503          	ld	a0,0(a5)
    800040d8:	00000097          	auipc	ra,0x0
    800040dc:	e14080e7          	jalr	-492(ra) # 80003eec <_ZN5RiscV15handlePageFaultEmm>
    handlePageFault((uint64)CONSOLE_TX_DATA,0xf);
    800040e0:	00f00593          	li	a1,15
    800040e4:	00008797          	auipc	a5,0x8
    800040e8:	ea47b783          	ld	a5,-348(a5) # 8000bf88 <_GLOBAL_OFFSET_TABLE_+0x30>
    800040ec:	0007b503          	ld	a0,0(a5)
    800040f0:	00000097          	auipc	ra,0x0
    800040f4:	dfc080e7          	jalr	-516(ra) # 80003eec <_ZN5RiscV15handlePageFaultEmm>
    handlePageFault((uint64)CONSOLE_STATUS,0xf);
    800040f8:	00f00593          	li	a1,15
    800040fc:	00008797          	auipc	a5,0x8
    80004100:	e6c7b783          	ld	a5,-404(a5) # 8000bf68 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004104:	0007b503          	ld	a0,0(a5)
    80004108:	00000097          	auipc	ra,0x0
    8000410c:	de4080e7          	jalr	-540(ra) # 80003eec <_ZN5RiscV15handlePageFaultEmm>
    handlePageFault((uint64)0xc201004,0xf);
    80004110:	00f00593          	li	a1,15
    80004114:	0c201537          	lui	a0,0xc201
    80004118:	00450513          	addi	a0,a0,4 # c201004 <_entry-0x73dfeffc>
    8000411c:	00000097          	auipc	ra,0x0
    80004120:	dd0080e7          	jalr	-560(ra) # 80003eec <_ZN5RiscV15handlePageFaultEmm>

    uint64 satp = ((uint64)1<<63) | ((uint64)(RiscV::PMT)>>12);
    80004124:	00008797          	auipc	a5,0x8
    80004128:	0fc7b783          	ld	a5,252(a5) # 8000c220 <_ZN5RiscV3PMTE>
    8000412c:	00c7d793          	srli	a5,a5,0xc
    80004130:	fff00713          	li	a4,-1
    80004134:	03f71713          	slli	a4,a4,0x3f
    80004138:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    8000413c:	18079073          	csrw	satp,a5
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80004140:	00200793          	li	a5,2
    80004144:	1047a073          	csrs	sie,a5
    80004148:	20000713          	li	a4,512
    8000414c:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80004150:	1007a073          	csrs	sstatus,a5

    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80004154:	01813083          	ld	ra,24(sp)
    80004158:	01013403          	ld	s0,16(sp)
    8000415c:	00813483          	ld	s1,8(sp)
    80004160:	02010113          	addi	sp,sp,32
    80004164:	00008067          	ret

0000000080004168 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80004168:	ff010113          	addi	sp,sp,-16
    8000416c:	00813423          	sd	s0,8(sp)
    80004170:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80004174:	14109073          	csrw	sepc,ra
    asm("sret");
    80004178:	10200073          	sret
}
    8000417c:	00813403          	ld	s0,8(sp)
    80004180:	01010113          	addi	sp,sp,16
    80004184:	00008067          	ret

0000000080004188 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80004188:	ff010113          	addi	sp,sp,-16
    8000418c:	00113423          	sd	ra,8(sp)
    80004190:	00813023          	sd	s0,0(sp)
    80004194:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80004198:	00008797          	auipc	a5,0x8
    8000419c:	e487b783          	ld	a5,-440(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    800041a0:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    800041a4:	00100713          	li	a4,1
    800041a8:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800041ac:	fffff097          	auipc	ra,0xfffff
    800041b0:	134080e7          	jalr	308(ra) # 800032e0 <_ZN3TCB8dispatchEv>
}
    800041b4:	00813083          	ld	ra,8(sp)
    800041b8:	00013403          	ld	s0,0(sp)
    800041bc:	01010113          	addi	sp,sp,16
    800041c0:	00008067          	ret

00000000800041c4 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    800041c4:	ff010113          	addi	sp,sp,-16
    800041c8:	00113423          	sd	ra,8(sp)
    800041cc:	00813023          	sd	s0,0(sp)
    800041d0:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    800041d4:	00008797          	auipc	a5,0x8
    800041d8:	0547c783          	lbu	a5,84(a5) # 8000c228 <_ZN5RiscV16userMainFinishedE>
    800041dc:	00079c63          	bnez	a5,800041f4 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    800041e0:	00008717          	auipc	a4,0x8
    800041e4:	df873703          	ld	a4,-520(a4) # 8000bfd8 <_GLOBAL_OFFSET_TABLE_+0x80>
    800041e8:	00073783          	ld	a5,0(a4)
    800041ec:	00178793          	addi	a5,a5,1
    800041f0:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    800041f4:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    800041f8:	0ff57513          	andi	a0,a0,255
    800041fc:	00001097          	auipc	ra,0x1
    80004200:	278080e7          	jalr	632(ra) # 80005474 <_ZN11ConsoleUtil9putOutputEc>
}
    80004204:	00813083          	ld	ra,8(sp)
    80004208:	00013403          	ld	s0,0(sp)
    8000420c:	01010113          	addi	sp,sp,16
    80004210:	00008067          	ret

0000000080004214 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80004214:	fe010113          	addi	sp,sp,-32
    80004218:	00113c23          	sd	ra,24(sp)
    8000421c:	00813823          	sd	s0,16(sp)
    80004220:	02010413          	addi	s0,sp,32
    80004224:	00c0006f          	j	80004230 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80004228:	ffffe097          	auipc	ra,0xffffe
    8000422c:	cd4080e7          	jalr	-812(ra) # 80001efc <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80004230:	00008797          	auipc	a5,0x8
    80004234:	d387b783          	ld	a5,-712(a5) # 8000bf68 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004238:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    8000423c:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004240:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004244:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80004248:	0207f793          	andi	a5,a5,32
    8000424c:	fc078ee3          	beqz	a5,80004228 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80004250:	00001097          	auipc	ra,0x1
    80004254:	4b8080e7          	jalr	1208(ra) # 80005708 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80004258:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    8000425c:	00008797          	auipc	a5,0x8
    80004260:	d047b783          	ld	a5,-764(a5) # 8000bf60 <_GLOBAL_OFFSET_TABLE_+0x8>
    80004264:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80004268:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    8000426c:	fef44783          	lbu	a5,-17(s0)
    80004270:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80004274:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80004278:	00008797          	auipc	a5,0x8
    8000427c:	d607b783          	ld	a5,-672(a5) # 8000bfd8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80004280:	0007b783          	ld	a5,0(a5)
    80004284:	fa0786e3          	beqz	a5,80004230 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80004288:	fff78793          	addi	a5,a5,-1
    8000428c:	00008717          	auipc	a4,0x8
    80004290:	d4c73703          	ld	a4,-692(a4) # 8000bfd8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80004294:	00f73023          	sd	a5,0(a4)
    80004298:	f99ff06f          	j	80004230 <_ZN5RiscV11putcWrapperEPv+0x1c>

000000008000429c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    8000429c:	ff010113          	addi	sp,sp,-16
    800042a0:	00813423          	sd	s0,8(sp)
    800042a4:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    800042a8:	00008797          	auipc	a5,0x8
    800042ac:	d387b783          	ld	a5,-712(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    800042b0:	0007b783          	ld	a5,0(a5)
    800042b4:	0147a703          	lw	a4,20(a5)
    800042b8:	00100793          	li	a5,1
    800042bc:	00f70c63          	beq	a4,a5,800042d4 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    800042c0:	10000793          	li	a5,256
    800042c4:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    800042c8:	00813403          	ld	s0,8(sp)
    800042cc:	01010113          	addi	sp,sp,16
    800042d0:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800042d4:	10000793          	li	a5,256
    800042d8:	1007a073          	csrs	sstatus,a5
}
    800042dc:	fedff06f          	j	800042c8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

00000000800042e0 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    800042e0:	ff010113          	addi	sp,sp,-16
    800042e4:	00113423          	sd	ra,8(sp)
    800042e8:	00813023          	sd	s0,0(sp)
    800042ec:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    800042f0:	00100793          	li	a5,1
    800042f4:	00008717          	auipc	a4,0x8
    800042f8:	f2f70a23          	sb	a5,-204(a4) # 8000c228 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    800042fc:	00008797          	auipc	a5,0x8
    80004300:	cdc7b783          	ld	a5,-804(a5) # 8000bfd8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80004304:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80004308:	00008797          	auipc	a5,0x8
    8000430c:	c887b783          	ld	a5,-888(a5) # 8000bf90 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004310:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80004314:	00200793          	li	a5,2
    80004318:	1047b073          	csrc	sie,a5
    8000431c:	20000793          	li	a5,512
    80004320:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80004324:	00008797          	auipc	a5,0x8
    80004328:	c8c7b783          	ld	a5,-884(a5) # 8000bfb0 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000432c:	0007b783          	ld	a5,0(a5)
    80004330:	00078c63          	beqz	a5,80004348 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80004334:	0487b703          	ld	a4,72(a5)
    80004338:	00008797          	auipc	a5,0x8
    8000433c:	c787b783          	ld	a5,-904(a5) # 8000bfb0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004340:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80004344:	fe1ff06f          	j	80004324 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80004348:	00008797          	auipc	a5,0x8
    8000434c:	c707b783          	ld	a5,-912(a5) # 8000bfb8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004350:	0007b503          	ld	a0,0(a5)
    80004354:	00001097          	auipc	ra,0x1
    80004358:	d50080e7          	jalr	-688(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000435c:	00008797          	auipc	a5,0x8
    80004360:	c6c7b783          	ld	a5,-916(a5) # 8000bfc8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80004364:	0007b703          	ld	a4,0(a5)
    80004368:	00008797          	auipc	a5,0x8
    8000436c:	c687b783          	ld	a5,-920(a5) # 8000bfd0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80004370:	0007b783          	ld	a5,0(a5)
    80004374:	00f70863          	beq	a4,a5,80004384 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80004378:	ffffe097          	auipc	ra,0xffffe
    8000437c:	b84080e7          	jalr	-1148(ra) # 80001efc <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80004380:	fddff06f          	j	8000435c <_ZN5RiscV8finalizeEv+0x7c>
}
    80004384:	00813083          	ld	ra,8(sp)
    80004388:	00013403          	ld	s0,0(sp)
    8000438c:	01010113          	addi	sp,sp,16
    80004390:	00008067          	ret

0000000080004394 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80004394:	ff010113          	addi	sp,sp,-16
    80004398:	00813423          	sd	s0,8(sp)
    8000439c:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    800043a0:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    800043a4:	00008717          	auipc	a4,0x8
    800043a8:	c3c73703          	ld	a4,-964(a4) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    800043ac:	00073703          	ld	a4,0(a4)
    800043b0:	06873703          	ld	a4,104(a4)
    800043b4:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    800043b8:	04a5b823          	sd	a0,80(a1) # 1050 <_entry-0x7fffefb0>
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800043bc:	00078593          	mv	a1,a5
}
    800043c0:	00813403          	ld	s0,8(sp)
    800043c4:	01010113          	addi	sp,sp,16
    800043c8:	00008067          	ret

00000000800043cc <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    800043cc:	ff010113          	addi	sp,sp,-16
    800043d0:	00113423          	sd	ra,8(sp)
    800043d4:	00813023          	sd	s0,0(sp)
    800043d8:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    800043dc:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    800043e0:	fffff097          	auipc	ra,0xfffff
    800043e4:	184080e7          	jalr	388(ra) # 80003564 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    800043e8:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800043ec:	00000097          	auipc	ra,0x0
    800043f0:	fa8080e7          	jalr	-88(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    800043f4:	00813083          	ld	ra,8(sp)
    800043f8:	00013403          	ld	s0,0(sp)
    800043fc:	01010113          	addi	sp,sp,16
    80004400:	00008067          	ret

0000000080004404 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80004404:	ff010113          	addi	sp,sp,-16
    80004408:	00113423          	sd	ra,8(sp)
    8000440c:	00813023          	sd	s0,0(sp)
    80004410:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80004414:	00008797          	auipc	a5,0x8
    80004418:	bd47b783          	ld	a5,-1068(a5) # 8000bfe8 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000441c:	0007c783          	lbu	a5,0(a5)
    80004420:	02079263          	bnez	a5,80004444 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80004424:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004428:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    8000442c:	00000097          	auipc	ra,0x0
    80004430:	f68080e7          	jalr	-152(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004434:	00813083          	ld	ra,8(sp)
    80004438:	00013403          	ld	s0,0(sp)
    8000443c:	01010113          	addi	sp,sp,16
    80004440:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004444:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80004448:	fffff097          	auipc	ra,0xfffff
    8000444c:	354080e7          	jalr	852(ra) # 8000379c <_ZN15MemoryAllocator5kfreeEPv>
    80004450:	fd9ff06f          	j	80004428 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080004454 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80004454:	fc010113          	addi	sp,sp,-64
    80004458:	02113c23          	sd	ra,56(sp)
    8000445c:	02813823          	sd	s0,48(sp)
    80004460:	02913423          	sd	s1,40(sp)
    80004464:	03213023          	sd	s2,32(sp)
    80004468:	01313c23          	sd	s3,24(sp)
    8000446c:	01413823          	sd	s4,16(sp)
    80004470:	01513423          	sd	s5,8(sp)
    80004474:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80004478:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000447c:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80004480:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80004484:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80004488:	07000513          	li	a0,112
    8000448c:	fffff097          	auipc	ra,0xfffff
    80004490:	ed4080e7          	jalr	-300(ra) # 80003360 <_ZN3TCBnwEm>
    80004494:	00050493          	mv	s1,a0
    80004498:	00050e63          	beqz	a0,800044b4 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    8000449c:	00200713          	li	a4,2
    800044a0:	000a8693          	mv	a3,s5
    800044a4:	000a0613          	mv	a2,s4
    800044a8:	00098593          	mv	a1,s3
    800044ac:	fffff097          	auipc	ra,0xfffff
    800044b0:	d78080e7          	jalr	-648(ra) # 80003224 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800044b4:	04048863          	beqz	s1,80004504 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    800044b8:	0184b783          	ld	a5,24(s1)
    800044bc:	00078863          	beqz	a5,800044cc <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    800044c0:	00048513          	mv	a0,s1
    800044c4:	00001097          	auipc	ra,0x1
    800044c8:	be0080e7          	jalr	-1056(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    800044cc:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800044d0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800044d4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800044d8:	00000097          	auipc	ra,0x0
    800044dc:	ebc080e7          	jalr	-324(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    800044e0:	03813083          	ld	ra,56(sp)
    800044e4:	03013403          	ld	s0,48(sp)
    800044e8:	02813483          	ld	s1,40(sp)
    800044ec:	02013903          	ld	s2,32(sp)
    800044f0:	01813983          	ld	s3,24(sp)
    800044f4:	01013a03          	ld	s4,16(sp)
    800044f8:	00813a83          	ld	s5,8(sp)
    800044fc:	04010113          	addi	sp,sp,64
    80004500:	00008067          	ret
        status = -1;
    80004504:	fff00793          	li	a5,-1
    80004508:	fcdff06f          	j	800044d4 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    8000450c:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80004510:	00048513          	mv	a0,s1
    80004514:	fffff097          	auipc	ra,0xfffff
    80004518:	f70080e7          	jalr	-144(ra) # 80003484 <_ZN3TCBdlEPv>
    8000451c:	00090513          	mv	a0,s2
    80004520:	00009097          	auipc	ra,0x9
    80004524:	e68080e7          	jalr	-408(ra) # 8000d388 <_Unwind_Resume>

0000000080004528 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80004528:	fc010113          	addi	sp,sp,-64
    8000452c:	02113c23          	sd	ra,56(sp)
    80004530:	02813823          	sd	s0,48(sp)
    80004534:	02913423          	sd	s1,40(sp)
    80004538:	03213023          	sd	s2,32(sp)
    8000453c:	01313c23          	sd	s3,24(sp)
    80004540:	01413823          	sd	s4,16(sp)
    80004544:	01513423          	sd	s5,8(sp)
    80004548:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000454c:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004550:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80004554:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80004558:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000455c:	07000513          	li	a0,112
    80004560:	fffff097          	auipc	ra,0xfffff
    80004564:	e00080e7          	jalr	-512(ra) # 80003360 <_ZN3TCBnwEm>
    80004568:	00050493          	mv	s1,a0
    8000456c:	00050e63          	beqz	a0,80004588 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80004570:	00200713          	li	a4,2
    80004574:	000a8693          	mv	a3,s5
    80004578:	00090613          	mv	a2,s2
    8000457c:	00098593          	mv	a1,s3
    80004580:	fffff097          	auipc	ra,0xfffff
    80004584:	ca4080e7          	jalr	-860(ra) # 80003224 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80004588:	04048263          	beqz	s1,800045cc <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    8000458c:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    80004590:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80004594:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    80004598:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000459c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800045a0:	00000097          	auipc	ra,0x0
    800045a4:	df4080e7          	jalr	-524(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    800045a8:	03813083          	ld	ra,56(sp)
    800045ac:	03013403          	ld	s0,48(sp)
    800045b0:	02813483          	ld	s1,40(sp)
    800045b4:	02013903          	ld	s2,32(sp)
    800045b8:	01813983          	ld	s3,24(sp)
    800045bc:	01013a03          	ld	s4,16(sp)
    800045c0:	00813a83          	ld	s5,8(sp)
    800045c4:	04010113          	addi	sp,sp,64
    800045c8:	00008067          	ret
        status = -1;
    800045cc:	fff00793          	li	a5,-1
    800045d0:	fcdff06f          	j	8000459c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    800045d4:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800045d8:	00048513          	mv	a0,s1
    800045dc:	fffff097          	auipc	ra,0xfffff
    800045e0:	ea8080e7          	jalr	-344(ra) # 80003484 <_ZN3TCBdlEPv>
    800045e4:	00090513          	mv	a0,s2
    800045e8:	00009097          	auipc	ra,0x9
    800045ec:	da0080e7          	jalr	-608(ra) # 8000d388 <_Unwind_Resume>

00000000800045f0 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    800045f0:	ff010113          	addi	sp,sp,-16
    800045f4:	00113423          	sd	ra,8(sp)
    800045f8:	00813023          	sd	s0,0(sp)
    800045fc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004600:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80004604:	02051263          	bnez	a0,80004628 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80004608:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000460c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004610:	00000097          	auipc	ra,0x0
    80004614:	d84080e7          	jalr	-636(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004618:	00813083          	ld	ra,8(sp)
    8000461c:	00013403          	ld	s0,0(sp)
    80004620:	01010113          	addi	sp,sp,16
    80004624:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80004628:	00100793          	li	a5,1
    8000462c:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80004630:	00001097          	auipc	ra,0x1
    80004634:	a74080e7          	jalr	-1420(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80004638:	fffff097          	auipc	ra,0xfffff
    8000463c:	ca8080e7          	jalr	-856(ra) # 800032e0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80004640:	00000793          	li	a5,0
    80004644:	fc9ff06f          	j	8000460c <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080004648 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80004648:	ff010113          	addi	sp,sp,-16
    8000464c:	00113423          	sd	ra,8(sp)
    80004650:	00813023          	sd	s0,0(sp)
    80004654:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80004658:	00008797          	auipc	a5,0x8
    8000465c:	9887b783          	ld	a5,-1656(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004660:	0007b783          	ld	a5,0(a5)
    80004664:	02078a63          	beqz	a5,80004698 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80004668:	00200713          	li	a4,2
    8000466c:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80004670:	fffff097          	auipc	ra,0xfffff
    80004674:	c70080e7          	jalr	-912(ra) # 800032e0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80004678:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000467c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004680:	00000097          	auipc	ra,0x0
    80004684:	d14080e7          	jalr	-748(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004688:	00813083          	ld	ra,8(sp)
    8000468c:	00013403          	ld	s0,0(sp)
    80004690:	01010113          	addi	sp,sp,16
    80004694:	00008067          	ret
        status = -1;
    80004698:	fff00793          	li	a5,-1
    8000469c:	fe1ff06f          	j	8000467c <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

00000000800046a0 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    800046a0:	fd010113          	addi	sp,sp,-48
    800046a4:	02113423          	sd	ra,40(sp)
    800046a8:	02813023          	sd	s0,32(sp)
    800046ac:	00913c23          	sd	s1,24(sp)
    800046b0:	01213823          	sd	s2,16(sp)
    800046b4:	01313423          	sd	s3,8(sp)
    800046b8:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800046bc:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    800046c0:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    800046c4:	01800513          	li	a0,24
    800046c8:	fffff097          	auipc	ra,0xfffff
    800046cc:	a08080e7          	jalr	-1528(ra) # 800030d0 <_ZN3SCBnwEm>
    800046d0:	00050493          	mv	s1,a0
    800046d4:	00050863          	beqz	a0,800046e4 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    800046d8:	00098593          	mv	a1,s3
    800046dc:	fffff097          	auipc	ra,0xfffff
    800046e0:	840080e7          	jalr	-1984(ra) # 80002f1c <_ZN3SCBC1Em>
    if(scb == nullptr){
    800046e4:	02048a63          	beqz	s1,80004718 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    800046e8:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800046ec:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800046f0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800046f4:	00000097          	auipc	ra,0x0
    800046f8:	ca0080e7          	jalr	-864(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    800046fc:	02813083          	ld	ra,40(sp)
    80004700:	02013403          	ld	s0,32(sp)
    80004704:	01813483          	ld	s1,24(sp)
    80004708:	01013903          	ld	s2,16(sp)
    8000470c:	00813983          	ld	s3,8(sp)
    80004710:	03010113          	addi	sp,sp,48
    80004714:	00008067          	ret
        status = -1;
    80004718:	fff00793          	li	a5,-1
    8000471c:	fd5ff06f          	j	800046f0 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    80004720:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80004724:	00048513          	mv	a0,s1
    80004728:	fffff097          	auipc	ra,0xfffff
    8000472c:	9d8080e7          	jalr	-1576(ra) # 80003100 <_ZN3SCBdlEPv>
    80004730:	00090513          	mv	a0,s2
    80004734:	00009097          	auipc	ra,0x9
    80004738:	c54080e7          	jalr	-940(ra) # 8000d388 <_Unwind_Resume>

000000008000473c <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    8000473c:	fe010113          	addi	sp,sp,-32
    80004740:	00113c23          	sd	ra,24(sp)
    80004744:	00813823          	sd	s0,16(sp)
    80004748:	00913423          	sd	s1,8(sp)
    8000474c:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004750:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80004754:	02049463          	bnez	s1,8000477c <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80004758:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000475c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004760:	00000097          	auipc	ra,0x0
    80004764:	c34080e7          	jalr	-972(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004768:	01813083          	ld	ra,24(sp)
    8000476c:	01013403          	ld	s0,16(sp)
    80004770:	00813483          	ld	s1,8(sp)
    80004774:	02010113          	addi	sp,sp,32
    80004778:	00008067          	ret
        delete (SCB*)ihandle;
    8000477c:	00048513          	mv	a0,s1
    80004780:	ffffe097          	auipc	ra,0xffffe
    80004784:	7b8080e7          	jalr	1976(ra) # 80002f38 <_ZN3SCBD1Ev>
    80004788:	00048513          	mv	a0,s1
    8000478c:	fffff097          	auipc	ra,0xfffff
    80004790:	974080e7          	jalr	-1676(ra) # 80003100 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80004794:	00000793          	li	a5,0
    80004798:	fc5ff06f          	j	8000475c <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

000000008000479c <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    8000479c:	ff010113          	addi	sp,sp,-16
    800047a0:	00113423          	sd	ra,8(sp)
    800047a4:	00813023          	sd	s0,0(sp)
    800047a8:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800047ac:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800047b0:	02051c63          	bnez	a0,800047e8 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    800047b4:	00008797          	auipc	a5,0x8
    800047b8:	82c7b783          	ld	a5,-2004(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    800047bc:	0007b783          	ld	a5,0(a5)
    800047c0:	0607b783          	ld	a5,96(a5)
    800047c4:	02078863          	beqz	a5,800047f4 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    800047c8:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800047cc:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800047d0:	00000097          	auipc	ra,0x0
    800047d4:	bc4080e7          	jalr	-1084(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    800047d8:	00813083          	ld	ra,8(sp)
    800047dc:	00013403          	ld	s0,0(sp)
    800047e0:	01010113          	addi	sp,sp,16
    800047e4:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800047e8:	fffff097          	auipc	ra,0xfffff
    800047ec:	85c080e7          	jalr	-1956(ra) # 80003044 <_ZN3SCB4waitEv>
    800047f0:	fc5ff06f          	j	800047b4 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800047f4:	00000793          	li	a5,0
    800047f8:	fd5ff06f          	j	800047cc <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800047fc <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800047fc:	ff010113          	addi	sp,sp,-16
    80004800:	00113423          	sd	ra,8(sp)
    80004804:	00813023          	sd	s0,0(sp)
    80004808:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000480c:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80004810:	02051263          	bnez	a0,80004834 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80004814:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004818:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000481c:	00000097          	auipc	ra,0x0
    80004820:	b78080e7          	jalr	-1160(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004824:	00813083          	ld	ra,8(sp)
    80004828:	00013403          	ld	s0,0(sp)
    8000482c:	01010113          	addi	sp,sp,16
    80004830:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80004834:	fffff097          	auipc	ra,0xfffff
    80004838:	860080e7          	jalr	-1952(ra) # 80003094 <_ZN3SCB6signalEv>
    uint64 status = 0;
    8000483c:	00000793          	li	a5,0
    80004840:	fd9ff06f          	j	80004818 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080004844 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80004844:	fe010113          	addi	sp,sp,-32
    80004848:	00113c23          	sd	ra,24(sp)
    8000484c:	00813823          	sd	s0,16(sp)
    80004850:	00913423          	sd	s1,8(sp)
    80004854:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80004858:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    8000485c:	00007797          	auipc	a5,0x7
    80004860:	7847b783          	ld	a5,1924(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004864:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80004868:	00008797          	auipc	a5,0x8
    8000486c:	9c87b783          	ld	a5,-1592(a5) # 8000c230 <_ZN5RiscV10globalTimeE>
    80004870:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80004874:	00e787b3          	add	a5,a5,a4
    80004878:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    8000487c:	00048513          	mv	a0,s1
    80004880:	00001097          	auipc	ra,0x1
    80004884:	8a0080e7          	jalr	-1888(ra) # 80005120 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80004888:	00300793          	li	a5,3
    8000488c:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80004890:	fffff097          	auipc	ra,0xfffff
    80004894:	a50080e7          	jalr	-1456(ra) # 800032e0 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004898:	00000793          	li	a5,0
    8000489c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800048a0:	00000097          	auipc	ra,0x0
    800048a4:	af4080e7          	jalr	-1292(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    800048a8:	01813083          	ld	ra,24(sp)
    800048ac:	01013403          	ld	s0,16(sp)
    800048b0:	00813483          	ld	s1,8(sp)
    800048b4:	02010113          	addi	sp,sp,32
    800048b8:	00008067          	ret

00000000800048bc <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    800048bc:	fe010113          	addi	sp,sp,-32
    800048c0:	00113c23          	sd	ra,24(sp)
    800048c4:	00813823          	sd	s0,16(sp)
    800048c8:	00913423          	sd	s1,8(sp)
    800048cc:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    800048d0:	00008797          	auipc	a5,0x8
    800048d4:	9587c783          	lbu	a5,-1704(a5) # 8000c228 <_ZN5RiscV16userMainFinishedE>
    800048d8:	00079c63          	bnez	a5,800048f0 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    800048dc:	00007717          	auipc	a4,0x7
    800048e0:	6b473703          	ld	a4,1716(a4) # 8000bf90 <_GLOBAL_OFFSET_TABLE_+0x38>
    800048e4:	00073783          	ld	a5,0(a4)
    800048e8:	00178793          	addi	a5,a5,1
    800048ec:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800048f0:	00001097          	auipc	ra,0x1
    800048f4:	b14080e7          	jalr	-1260(ra) # 80005404 <_ZN11ConsoleUtil8getInputEv>
    800048f8:	00050493          	mv	s1,a0
    if(c==13) {
    800048fc:	00d00793          	li	a5,13
    80004900:	02f50663          	beq	a0,a5,8000492c <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80004904:	01b00793          	li	a5,27
    80004908:	04f51063          	bne	a0,a5,80004948 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    8000490c:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80004910:	00000097          	auipc	ra,0x0
    80004914:	a84080e7          	jalr	-1404(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004918:	01813083          	ld	ra,24(sp)
    8000491c:	01013403          	ld	s0,16(sp)
    80004920:	00813483          	ld	s1,8(sp)
    80004924:	02010113          	addi	sp,sp,32
    80004928:	00008067          	ret
        ConsoleUtil::putOutput(13);
    8000492c:	00d00513          	li	a0,13
    80004930:	00001097          	auipc	ra,0x1
    80004934:	b44080e7          	jalr	-1212(ra) # 80005474 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80004938:	00a00513          	li	a0,10
    8000493c:	00001097          	auipc	ra,0x1
    80004940:	b38080e7          	jalr	-1224(ra) # 80005474 <_ZN11ConsoleUtil9putOutputEc>
    80004944:	fc9ff06f          	j	8000490c <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80004948:	00001097          	auipc	ra,0x1
    8000494c:	b2c080e7          	jalr	-1236(ra) # 80005474 <_ZN11ConsoleUtil9putOutputEc>
    80004950:	fbdff06f          	j	8000490c <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080004954 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80004954:	ff010113          	addi	sp,sp,-16
    80004958:	00113423          	sd	ra,8(sp)
    8000495c:	00813023          	sd	s0,0(sp)
    80004960:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80004964:	00001097          	auipc	ra,0x1
    80004968:	ba8080e7          	jalr	-1112(ra) # 8000550c <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    8000496c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80004970:	00000097          	auipc	ra,0x0
    80004974:	a24080e7          	jalr	-1500(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004978:	00813083          	ld	ra,8(sp)
    8000497c:	00013403          	ld	s0,0(sp)
    80004980:	01010113          	addi	sp,sp,16
    80004984:	00008067          	ret

0000000080004988 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80004988:	fe010113          	addi	sp,sp,-32
    8000498c:	00113c23          	sd	ra,24(sp)
    80004990:	00813823          	sd	s0,16(sp)
    80004994:	00913423          	sd	s1,8(sp)
    80004998:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000499c:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    800049a0:	02049463          	bnez	s1,800049c8 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800049a4:	fff00793          	li	a5,-1
    800049a8:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800049ac:	00000097          	auipc	ra,0x0
    800049b0:	9e8080e7          	jalr	-1560(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    800049b4:	01813083          	ld	ra,24(sp)
    800049b8:	01013403          	ld	s0,16(sp)
    800049bc:	00813483          	ld	s1,8(sp)
    800049c0:	02010113          	addi	sp,sp,32
    800049c4:	00008067          	ret
        kfree(thr->stack);
    800049c8:	0284b503          	ld	a0,40(s1)
    800049cc:	00001097          	auipc	ra,0x1
    800049d0:	eac080e7          	jalr	-340(ra) # 80005878 <_Z5kfreePKv>
        delete thr;
    800049d4:	00048513          	mv	a0,s1
    800049d8:	fffff097          	auipc	ra,0xfffff
    800049dc:	8e0080e7          	jalr	-1824(ra) # 800032b8 <_ZN3TCBD1Ev>
    800049e0:	00048513          	mv	a0,s1
    800049e4:	fffff097          	auipc	ra,0xfffff
    800049e8:	aa0080e7          	jalr	-1376(ra) # 80003484 <_ZN3TCBdlEPv>
    800049ec:	fb9ff06f          	j	800049a4 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

00000000800049f0 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    800049f0:	fe010113          	addi	sp,sp,-32
    800049f4:	00113c23          	sd	ra,24(sp)
    800049f8:	00813823          	sd	s0,16(sp)
    800049fc:	00913423          	sd	s1,8(sp)
    80004a00:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004a04:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80004a08:	02049463          	bnez	s1,80004a30 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004a0c:	fff00793          	li	a5,-1
    80004a10:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80004a14:	00000097          	auipc	ra,0x0
    80004a18:	980080e7          	jalr	-1664(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004a1c:	01813083          	ld	ra,24(sp)
    80004a20:	01013403          	ld	s0,16(sp)
    80004a24:	00813483          	ld	s1,8(sp)
    80004a28:	02010113          	addi	sp,sp,32
    80004a2c:	00008067          	ret
        delete scb;
    80004a30:	00048513          	mv	a0,s1
    80004a34:	ffffe097          	auipc	ra,0xffffe
    80004a38:	504080e7          	jalr	1284(ra) # 80002f38 <_ZN3SCBD1Ev>
    80004a3c:	00048513          	mv	a0,s1
    80004a40:	ffffe097          	auipc	ra,0xffffe
    80004a44:	6c0080e7          	jalr	1728(ra) # 80003100 <_ZN3SCBdlEPv>
    80004a48:	fc5ff06f          	j	80004a0c <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080004a4c <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80004a4c:	fe010113          	addi	sp,sp,-32
    80004a50:	00113c23          	sd	ra,24(sp)
    80004a54:	00813823          	sd	s0,16(sp)
    80004a58:	00913423          	sd	s1,8(sp)
    80004a5c:	01213023          	sd	s2,0(sp)
    80004a60:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80004a64:	00001537          	lui	a0,0x1
    80004a68:	00001097          	auipc	ra,0x1
    80004a6c:	de8080e7          	jalr	-536(ra) # 80005850 <_Z7kmallocm>
    80004a70:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80004a74:	00007797          	auipc	a5,0x7
    80004a78:	56c7b783          	ld	a5,1388(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004a7c:	0007b783          	ld	a5,0(a5)
    80004a80:	00001637          	lui	a2,0x1
    80004a84:	00050593          	mv	a1,a0
    80004a88:	0287b503          	ld	a0,40(a5)
    80004a8c:	fffff097          	auipc	ra,0xfffff
    80004a90:	ec4080e7          	jalr	-316(ra) # 80003950 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80004a94:	07000513          	li	a0,112
    80004a98:	fffff097          	auipc	ra,0xfffff
    80004a9c:	8c8080e7          	jalr	-1848(ra) # 80003360 <_ZN3TCBnwEm>
    80004aa0:	00050493          	mv	s1,a0
    80004aa4:	00050e63          	beqz	a0,80004ac0 <_ZN5RiscV18executeForkSyscallEv+0x74>
    80004aa8:	00200713          	li	a4,2
    80004aac:	00090693          	mv	a3,s2
    80004ab0:	00000613          	li	a2,0
    80004ab4:	00000593          	li	a1,0
    80004ab8:	ffffe097          	auipc	ra,0xffffe
    80004abc:	76c080e7          	jalr	1900(ra) # 80003224 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80004ac0:	0a048e63          	beqz	s1,80004b7c <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80004ac4:	00007797          	auipc	a5,0x7
    80004ac8:	4e47b783          	ld	a5,1252(a5) # 8000bfa8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004acc:	0007b783          	ld	a5,0(a5)
    80004ad0:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80004ad4:	00007797          	auipc	a5,0x7
    80004ad8:	4c47b783          	ld	a5,1220(a5) # 8000bf98 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004adc:	0007b783          	ld	a5,0(a5)
    80004ae0:	00f907b3          	add	a5,s2,a5
    80004ae4:	00007717          	auipc	a4,0x7
    80004ae8:	4fc73703          	ld	a4,1276(a4) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004aec:	00073683          	ld	a3,0(a4)
    80004af0:	0286b683          	ld	a3,40(a3)
    80004af4:	40d787b3          	sub	a5,a5,a3
    80004af8:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80004afc:	00073783          	ld	a5,0(a4)
    80004b00:	0687b503          	ld	a0,104(a5)
    80004b04:	0287b783          	ld	a5,40(a5)
    80004b08:	40f50533          	sub	a0,a0,a5
    80004b0c:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80004b10:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80004b14:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80004b18:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80004b1c:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80004b20:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80004b24:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80004b28:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80004b2c:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80004b30:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80004b34:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80004b38:	00073783          	ld	a5,0(a4)
    80004b3c:	0387b703          	ld	a4,56(a5)
    80004b40:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80004b44:	0407b783          	ld	a5,64(a5)
    80004b48:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80004b4c:	00048513          	mv	a0,s1
    80004b50:	00000097          	auipc	ra,0x0
    80004b54:	554080e7          	jalr	1364(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80004b58:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80004b5c:	00000097          	auipc	ra,0x0
    80004b60:	838080e7          	jalr	-1992(ra) # 80004394 <_ZN5RiscV16saveA0toSscratchEv>

}
    80004b64:	01813083          	ld	ra,24(sp)
    80004b68:	01013403          	ld	s0,16(sp)
    80004b6c:	00813483          	ld	s1,8(sp)
    80004b70:	00013903          	ld	s2,0(sp)
    80004b74:	02010113          	addi	sp,sp,32
    80004b78:	00008067          	ret
        status = -1;
    80004b7c:	fff00493          	li	s1,-1
    80004b80:	fd9ff06f          	j	80004b58 <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80004b84:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80004b88:	00048513          	mv	a0,s1
    80004b8c:	fffff097          	auipc	ra,0xfffff
    80004b90:	8f8080e7          	jalr	-1800(ra) # 80003484 <_ZN3TCBdlEPv>
    80004b94:	00090513          	mv	a0,s2
    80004b98:	00008097          	auipc	ra,0x8
    80004b9c:	7f0080e7          	jalr	2032(ra) # 8000d388 <_Unwind_Resume>

0000000080004ba0 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80004ba0:	ff010113          	addi	sp,sp,-16
    80004ba4:	00813423          	sd	s0,8(sp)
    80004ba8:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80004bac:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80004bb0:	00878793          	addi	a5,a5,8
    80004bb4:	00007717          	auipc	a4,0x7
    80004bb8:	3f473703          	ld	a4,1012(a4) # 8000bfa8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004bbc:	00f73023          	sd	a5,0(a4)
}
    80004bc0:	00813403          	ld	s0,8(sp)
    80004bc4:	01010113          	addi	sp,sp,16
    80004bc8:	00008067          	ret

0000000080004bcc <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80004bcc:	fa010113          	addi	sp,sp,-96
    80004bd0:	04113c23          	sd	ra,88(sp)
    80004bd4:	04813823          	sd	s0,80(sp)
    80004bd8:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004bdc:	142027f3          	csrr	a5,scause
    80004be0:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80004be4:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    80004be8:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80004bec:	00007797          	auipc	a5,0x7
    80004bf0:	3f47b783          	ld	a5,1012(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004bf4:	0007b783          	ld	a5,0(a5)
    80004bf8:	14002773          	csrr	a4,sscratch
    80004bfc:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80004c00:	fe843703          	ld	a4,-24(s0)
    80004c04:	00900793          	li	a5,9
    80004c08:	0ef70663          	beq	a4,a5,80004cf4 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    80004c0c:	fe843703          	ld	a4,-24(s0)
    80004c10:	00800793          	li	a5,8
    80004c14:	0ef70063          	beq	a4,a5,80004cf4 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    80004c18:	fe843703          	ld	a4,-24(s0)
    80004c1c:	fff00793          	li	a5,-1
    80004c20:	03f79793          	slli	a5,a5,0x3f
    80004c24:	00178793          	addi	a5,a5,1
    80004c28:	24f70263          	beq	a4,a5,80004e6c <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    80004c2c:	fe843703          	ld	a4,-24(s0)
    80004c30:	fff00793          	li	a5,-1
    80004c34:	03f79793          	slli	a5,a5,0x3f
    80004c38:	00978793          	addi	a5,a5,9
    80004c3c:	2cf70063          	beq	a4,a5,80004efc <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80004c40:	fe843703          	ld	a4,-24(s0)
    80004c44:	00200793          	li	a5,2
    80004c48:	34f70863          	beq	a4,a5,80004f98 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80004c4c:	00004517          	auipc	a0,0x4
    80004c50:	7ac50513          	addi	a0,a0,1964 # 800093f8 <CONSOLE_STATUS+0x3e8>
    80004c54:	00001097          	auipc	ra,0x1
    80004c58:	928080e7          	jalr	-1752(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80004c5c:	00004517          	auipc	a0,0x4
    80004c60:	7ac50513          	addi	a0,a0,1964 # 80009408 <CONSOLE_STATUS+0x3f8>
    80004c64:	00001097          	auipc	ra,0x1
    80004c68:	918080e7          	jalr	-1768(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004c6c:	142027f3          	csrr	a5,scause
    80004c70:	fef43023          	sd	a5,-32(s0)
    return scause;
    80004c74:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80004c78:	00000613          	li	a2,0
    80004c7c:	00a00593          	li	a1,10
    80004c80:	0005051b          	sext.w	a0,a0
    80004c84:	00001097          	auipc	ra,0x1
    80004c88:	93c080e7          	jalr	-1732(ra) # 800055c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80004c8c:	00004517          	auipc	a0,0x4
    80004c90:	73c50513          	addi	a0,a0,1852 # 800093c8 <CONSOLE_STATUS+0x3b8>
    80004c94:	00001097          	auipc	ra,0x1
    80004c98:	8e8080e7          	jalr	-1816(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004c9c:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004ca0:	00000613          	li	a2,0
    80004ca4:	01000593          	li	a1,16
    80004ca8:	0005051b          	sext.w	a0,a0
    80004cac:	00001097          	auipc	ra,0x1
    80004cb0:	914080e7          	jalr	-1772(ra) # 800055c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004cb4:	00004517          	auipc	a0,0x4
    80004cb8:	70c50513          	addi	a0,a0,1804 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80004cbc:	00001097          	auipc	ra,0x1
    80004cc0:	8c0080e7          	jalr	-1856(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    80004cc4:	00007797          	auipc	a5,0x7
    80004cc8:	31c7b783          	ld	a5,796(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004ccc:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004cd0:	00200713          	li	a4,2
    80004cd4:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80004cd8:	00004517          	auipc	a0,0x4
    80004cdc:	74050513          	addi	a0,a0,1856 # 80009418 <CONSOLE_STATUS+0x408>
    80004ce0:	00001097          	auipc	ra,0x1
    80004ce4:	89c080e7          	jalr	-1892(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004ce8:	ffffe097          	auipc	ra,0xffffe
    80004cec:	5f8080e7          	jalr	1528(ra) # 800032e0 <_ZN3TCB8dispatchEv>
    80004cf0:	0800006f          	j	80004d70 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004cf4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004cf8:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004cfc:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80004d00:	00478793          	addi	a5,a5,4
    80004d04:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    80004d08:	00007797          	auipc	a5,0x7
    80004d0c:	2d87b783          	ld	a5,728(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004d10:	0007b783          	ld	a5,0(a5)
    80004d14:	fb043703          	ld	a4,-80(s0)
    80004d18:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80004d1c:	fa843703          	ld	a4,-88(s0)
    80004d20:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80004d24:	00050793          	mv	a5,a0
        switch(syscallID){
    80004d28:	06100713          	li	a4,97
    80004d2c:	02f76463          	bltu	a4,a5,80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    80004d30:	00279793          	slli	a5,a5,0x2
    80004d34:	00004717          	auipc	a4,0x4
    80004d38:	6f870713          	addi	a4,a4,1784 # 8000942c <CONSOLE_STATUS+0x41c>
    80004d3c:	00e787b3          	add	a5,a5,a4
    80004d40:	0007a783          	lw	a5,0(a5)
    80004d44:	00e787b3          	add	a5,a5,a4
    80004d48:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004d4c:	fffff097          	auipc	ra,0xfffff
    80004d50:	680080e7          	jalr	1664(ra) # 800043cc <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004d54:	00007797          	auipc	a5,0x7
    80004d58:	28c7b783          	ld	a5,652(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004d5c:	0007b783          	ld	a5,0(a5)
    80004d60:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004d64:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80004d68:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004d6c:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80004d70:	fffff097          	auipc	ra,0xfffff
    80004d74:	52c080e7          	jalr	1324(ra) # 8000429c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80004d78:	05813083          	ld	ra,88(sp)
    80004d7c:	05013403          	ld	s0,80(sp)
    80004d80:	06010113          	addi	sp,sp,96
    80004d84:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80004d88:	fffff097          	auipc	ra,0xfffff
    80004d8c:	67c080e7          	jalr	1660(ra) # 80004404 <_ZN5RiscV21executeMemFreeSyscallEv>
    80004d90:	fc5ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80004d94:	fffff097          	auipc	ra,0xfffff
    80004d98:	6c0080e7          	jalr	1728(ra) # 80004454 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004d9c:	fb9ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80004da0:	00000097          	auipc	ra,0x0
    80004da4:	8a8080e7          	jalr	-1880(ra) # 80004648 <_ZN5RiscV24executeThreadExitSyscallEv>
    80004da8:	fadff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004dac:	fffff097          	auipc	ra,0xfffff
    80004db0:	3dc080e7          	jalr	988(ra) # 80004188 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80004db4:	fa1ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80004db8:	fffff097          	auipc	ra,0xfffff
    80004dbc:	770080e7          	jalr	1904(ra) # 80004528 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004dc0:	f95ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80004dc4:	00000097          	auipc	ra,0x0
    80004dc8:	82c080e7          	jalr	-2004(ra) # 800045f0 <_ZN5RiscV25executeThreadStartSyscallEv>
    80004dcc:	f89ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80004dd0:	00000097          	auipc	ra,0x0
    80004dd4:	8d0080e7          	jalr	-1840(ra) # 800046a0 <_ZN5RiscV21executeSemOpenSyscallEv>
    80004dd8:	f7dff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    80004ddc:	00000097          	auipc	ra,0x0
    80004de0:	960080e7          	jalr	-1696(ra) # 8000473c <_ZN5RiscV22executeSemCloseSyscallEv>
    80004de4:	f71ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80004de8:	00000097          	auipc	ra,0x0
    80004dec:	9b4080e7          	jalr	-1612(ra) # 8000479c <_ZN5RiscV21executeSemWaitSyscallEv>
    80004df0:	f65ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80004df4:	00000097          	auipc	ra,0x0
    80004df8:	a08080e7          	jalr	-1528(ra) # 800047fc <_ZN5RiscV23executeSemSignalSyscallEv>
    80004dfc:	f59ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    80004e00:	00000097          	auipc	ra,0x0
    80004e04:	a44080e7          	jalr	-1468(ra) # 80004844 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80004e08:	f4dff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    80004e0c:	00000097          	auipc	ra,0x0
    80004e10:	ab0080e7          	jalr	-1360(ra) # 800048bc <_ZN5RiscV18executeGetcSyscallEv>
    80004e14:	f41ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    80004e18:	fffff097          	auipc	ra,0xfffff
    80004e1c:	3ac080e7          	jalr	940(ra) # 800041c4 <_ZN5RiscV18executePutcSyscallEv>
    80004e20:	f35ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    80004e24:	00000097          	auipc	ra,0x0
    80004e28:	b30080e7          	jalr	-1232(ra) # 80004954 <_ZN5RiscV22executePutcUtilSyscallEv>
    80004e2c:	f29ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    80004e30:	00000097          	auipc	ra,0x0
    80004e34:	b58080e7          	jalr	-1192(ra) # 80004988 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004e38:	f1dff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004e3c:	00000097          	auipc	ra,0x0
    80004e40:	bb4080e7          	jalr	-1100(ra) # 800049f0 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004e44:	f11ff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004e48:	00010793          	mv	a5,sp
    80004e4c:	00007717          	auipc	a4,0x7
    80004e50:	14c73703          	ld	a4,332(a4) # 8000bf98 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004e54:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004e58:	00000097          	auipc	ra,0x0
    80004e5c:	d48080e7          	jalr	-696(ra) # 80004ba0 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004e60:	00000097          	auipc	ra,0x0
    80004e64:	bec080e7          	jalr	-1044(ra) # 80004a4c <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004e68:	eedff06f          	j	80004d54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004e6c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004e70:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004e74:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004e78:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004e7c:	00200793          	li	a5,2
    80004e80:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80004e84:	00007717          	auipc	a4,0x7
    80004e88:	39c70713          	addi	a4,a4,924 # 8000c220 <_ZN5RiscV3PMTE>
    80004e8c:	01073783          	ld	a5,16(a4)
    80004e90:	00178793          	addi	a5,a5,1
    80004e94:	00f73823          	sd	a5,16(a4)
        Scheduler::awake();
    80004e98:	00000097          	auipc	ra,0x0
    80004e9c:	2e0080e7          	jalr	736(ra) # 80005178 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80004ea0:	00007717          	auipc	a4,0x7
    80004ea4:	0d873703          	ld	a4,216(a4) # 8000bf78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004ea8:	00073783          	ld	a5,0(a4)
    80004eac:	00178793          	addi	a5,a5,1
    80004eb0:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80004eb4:	00007717          	auipc	a4,0x7
    80004eb8:	12c73703          	ld	a4,300(a4) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004ebc:	00073703          	ld	a4,0(a4)
    80004ec0:	03073683          	ld	a3,48(a4)
    80004ec4:	00d7fc63          	bgeu	a5,a3,80004edc <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80004ec8:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004ecc:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004ed0:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004ed4:	14179073          	csrw	sepc,a5
}
    80004ed8:	e99ff06f          	j	80004d70 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80004edc:	00007797          	auipc	a5,0x7
    80004ee0:	09c7b783          	ld	a5,156(a5) # 8000bf78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004ee4:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004ee8:	00100793          	li	a5,1
    80004eec:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80004ef0:	ffffe097          	auipc	ra,0xffffe
    80004ef4:	3f0080e7          	jalr	1008(ra) # 800032e0 <_ZN3TCB8dispatchEv>
    80004ef8:	fd1ff06f          	j	80004ec8 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004efc:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004f00:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004f04:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004f08:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80004f0c:	00007797          	auipc	a5,0x7
    80004f10:	05c7b783          	ld	a5,92(a5) # 8000bf68 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004f14:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004f18:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004f1c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004f20:	00058793          	mv	a5,a1
        if(status & 1UL)
    80004f24:	0017f793          	andi	a5,a5,1
    80004f28:	02078863          	beqz	a5,80004f58 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    80004f2c:	00007797          	auipc	a5,0x7
    80004f30:	05c7b783          	ld	a5,92(a5) # 8000bf88 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004f34:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004f38:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004f3c:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004f40:	00058513          	mv	a0,a1
    80004f44:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004f48:	00007797          	auipc	a5,0x7
    80004f4c:	0487b783          	ld	a5,72(a5) # 8000bf90 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004f50:	0007b783          	ld	a5,0(a5)
    80004f54:	02079463          	bnez	a5,80004f7c <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    80004f58:	00002097          	auipc	ra,0x2
    80004f5c:	7bc080e7          	jalr	1980(ra) # 80007714 <plic_claim>
    80004f60:	00002097          	auipc	ra,0x2
    80004f64:	7ec080e7          	jalr	2028(ra) # 8000774c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004f68:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004f6c:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004f70:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004f74:	14179073          	csrw	sepc,a5
}
    80004f78:	df9ff06f          	j	80004d70 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80004f7c:	fff78793          	addi	a5,a5,-1
    80004f80:	00007717          	auipc	a4,0x7
    80004f84:	01073703          	ld	a4,16(a4) # 8000bf90 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004f88:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004f8c:	00000097          	auipc	ra,0x0
    80004f90:	3f8080e7          	jalr	1016(ra) # 80005384 <_ZN11ConsoleUtil8putInputEc>
    80004f94:	fc5ff06f          	j	80004f58 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    80004f98:	00007797          	auipc	a5,0x7
    80004f9c:	0487b783          	ld	a5,72(a5) # 8000bfe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004fa0:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004fa4:	00200713          	li	a4,2
    80004fa8:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004fac:	00004517          	auipc	a0,0x4
    80004fb0:	41c50513          	addi	a0,a0,1052 # 800093c8 <CONSOLE_STATUS+0x3b8>
    80004fb4:	00000097          	auipc	ra,0x0
    80004fb8:	5c8080e7          	jalr	1480(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004fbc:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004fc0:	00000613          	li	a2,0
    80004fc4:	01000593          	li	a1,16
    80004fc8:	0005051b          	sext.w	a0,a0
    80004fcc:	00000097          	auipc	ra,0x0
    80004fd0:	5f4080e7          	jalr	1524(ra) # 800055c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004fd4:	00004517          	auipc	a0,0x4
    80004fd8:	3ec50513          	addi	a0,a0,1004 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80004fdc:	00000097          	auipc	ra,0x0
    80004fe0:	5a0080e7          	jalr	1440(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80004fe4:	00004517          	auipc	a0,0x4
    80004fe8:	3ec50513          	addi	a0,a0,1004 # 800093d0 <CONSOLE_STATUS+0x3c0>
    80004fec:	00000097          	auipc	ra,0x0
    80004ff0:	590080e7          	jalr	1424(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004ff4:	ffffe097          	auipc	ra,0xffffe
    80004ff8:	2ec080e7          	jalr	748(ra) # 800032e0 <_ZN3TCB8dispatchEv>
    80004ffc:	d75ff06f          	j	80004d70 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

0000000080005000 <_Z6strcpyPKcPc>:
//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    80005000:	ff010113          	addi	sp,sp,-16
    80005004:	00813423          	sd	s0,8(sp)
    80005008:	01010413          	addi	s0,sp,16
    8000500c:	00050793          	mv	a5,a0
    80005010:	00058513          	mv	a0,a1
    while(*src != '\0')
    80005014:	0007c703          	lbu	a4,0(a5)
    80005018:	00070a63          	beqz	a4,8000502c <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    8000501c:	00178793          	addi	a5,a5,1
    80005020:	00e50023          	sb	a4,0(a0)
    80005024:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80005028:	fedff06f          	j	80005014 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    8000502c:	00e50023          	sb	a4,0(a0)
    return dst;
}
    80005030:	00813403          	ld	s0,8(sp)
    80005034:	01010113          	addi	sp,sp,16
    80005038:	00008067          	ret

000000008000503c <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    8000503c:	fe010113          	addi	sp,sp,-32
    80005040:	00113c23          	sd	ra,24(sp)
    80005044:	00813823          	sd	s0,16(sp)
    80005048:	00913423          	sd	s1,8(sp)
    8000504c:	02010413          	addi	s0,sp,32
    80005050:	00050493          	mv	s1,a0
    80005054:	00058513          	mv	a0,a1
    char *dest = dst;
    80005058:	00048593          	mv	a1,s1
    while(*dest != '\0')
    8000505c:	0005c783          	lbu	a5,0(a1)
    80005060:	00078663          	beqz	a5,8000506c <_Z6strcatPcPKc+0x30>
        dest++;
    80005064:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80005068:	ff5ff06f          	j	8000505c <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    8000506c:	00000097          	auipc	ra,0x0
    80005070:	f94080e7          	jalr	-108(ra) # 80005000 <_Z6strcpyPKcPc>
    return dst;
}
    80005074:	00048513          	mv	a0,s1
    80005078:	01813083          	ld	ra,24(sp)
    8000507c:	01013403          	ld	s0,16(sp)
    80005080:	00813483          	ld	s1,8(sp)
    80005084:	02010113          	addi	sp,sp,32
    80005088:	00008067          	ret

000000008000508c <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    8000508c:	ff010113          	addi	sp,sp,-16
    80005090:	00813423          	sd	s0,8(sp)
    80005094:	01010413          	addi	s0,sp,16
}
    80005098:	00813403          	ld	s0,8(sp)
    8000509c:	01010113          	addi	sp,sp,16
    800050a0:	00008067          	ret

00000000800050a4 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    800050a4:	ff010113          	addi	sp,sp,-16
    800050a8:	00813423          	sd	s0,8(sp)
    800050ac:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    800050b0:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800050b4:	00007797          	auipc	a5,0x7
    800050b8:	1847b783          	ld	a5,388(a5) # 8000c238 <_ZN9Scheduler9readyHeadE>
    800050bc:	02078263          	beqz	a5,800050e0 <_ZN9Scheduler3putEP3TCB+0x3c>
    800050c0:	00007797          	auipc	a5,0x7
    800050c4:	1807b783          	ld	a5,384(a5) # 8000c240 <_ZN9Scheduler9readyTailE>
    800050c8:	04a7b423          	sd	a0,72(a5)
    800050cc:	00007797          	auipc	a5,0x7
    800050d0:	16a7ba23          	sd	a0,372(a5) # 8000c240 <_ZN9Scheduler9readyTailE>
}
    800050d4:	00813403          	ld	s0,8(sp)
    800050d8:	01010113          	addi	sp,sp,16
    800050dc:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800050e0:	00007797          	auipc	a5,0x7
    800050e4:	14a7bc23          	sd	a0,344(a5) # 8000c238 <_ZN9Scheduler9readyHeadE>
    800050e8:	fe5ff06f          	j	800050cc <_ZN9Scheduler3putEP3TCB+0x28>

00000000800050ec <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    800050ec:	ff010113          	addi	sp,sp,-16
    800050f0:	00813423          	sd	s0,8(sp)
    800050f4:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    800050f8:	00007517          	auipc	a0,0x7
    800050fc:	14053503          	ld	a0,320(a0) # 8000c238 <_ZN9Scheduler9readyHeadE>
    80005100:	00050a63          	beqz	a0,80005114 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80005104:	04853783          	ld	a5,72(a0)
    80005108:	00007717          	auipc	a4,0x7
    8000510c:	12f73823          	sd	a5,304(a4) # 8000c238 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80005110:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80005114:	00813403          	ld	s0,8(sp)
    80005118:	01010113          	addi	sp,sp,16
    8000511c:	00008067          	ret

0000000080005120 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80005120:	ff010113          	addi	sp,sp,-16
    80005124:	00813423          	sd	s0,8(sp)
    80005128:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    8000512c:	00007797          	auipc	a5,0x7
    80005130:	11c7b783          	ld	a5,284(a5) # 8000c248 <_ZN9Scheduler12sleepingHeadE>
    80005134:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80005138:	00078e63          	beqz	a5,80005154 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    8000513c:	0587b683          	ld	a3,88(a5)
    80005140:	05853703          	ld	a4,88(a0)
    80005144:	00d76863          	bltu	a4,a3,80005154 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80005148:	00078613          	mv	a2,a5
    8000514c:	0487b783          	ld	a5,72(a5)
    80005150:	fe9ff06f          	j	80005138 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80005154:	04f53423          	sd	a5,72(a0)
    if(prev)
    80005158:	00060a63          	beqz	a2,8000516c <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    8000515c:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80005160:	00813403          	ld	s0,8(sp)
    80005164:	01010113          	addi	sp,sp,16
    80005168:	00008067          	ret
        sleepingHead = t;
    8000516c:	00007797          	auipc	a5,0x7
    80005170:	0ca7be23          	sd	a0,220(a5) # 8000c248 <_ZN9Scheduler12sleepingHeadE>
}
    80005174:	fedff06f          	j	80005160 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080005178 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80005178:	fe010113          	addi	sp,sp,-32
    8000517c:	00113c23          	sd	ra,24(sp)
    80005180:	00813823          	sd	s0,16(sp)
    80005184:	00913423          	sd	s1,8(sp)
    80005188:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    8000518c:	00007497          	auipc	s1,0x7
    80005190:	0bc4b483          	ld	s1,188(s1) # 8000c248 <_ZN9Scheduler12sleepingHeadE>
    80005194:	02048c63          	beqz	s1,800051cc <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80005198:	0584b703          	ld	a4,88(s1)
    8000519c:	00007797          	auipc	a5,0x7
    800051a0:	e5c7b783          	ld	a5,-420(a5) # 8000bff8 <_GLOBAL_OFFSET_TABLE_+0xa0>
    800051a4:	0007b783          	ld	a5,0(a5)
    800051a8:	02e7e263          	bltu	a5,a4,800051cc <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    800051ac:	0484b783          	ld	a5,72(s1)
    800051b0:	00007717          	auipc	a4,0x7
    800051b4:	08f73c23          	sd	a5,152(a4) # 8000c248 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    800051b8:	00048513          	mv	a0,s1
    800051bc:	00000097          	auipc	ra,0x0
    800051c0:	ee8080e7          	jalr	-280(ra) # 800050a4 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    800051c4:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    800051c8:	fc5ff06f          	j	8000518c <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    800051cc:	01813083          	ld	ra,24(sp)
    800051d0:	01013403          	ld	s0,16(sp)
    800051d4:	00813483          	ld	s1,8(sp)
    800051d8:	02010113          	addi	sp,sp,32
    800051dc:	00008067          	ret

00000000800051e0 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    800051e0:	fe010113          	addi	sp,sp,-32
    800051e4:	00113c23          	sd	ra,24(sp)
    800051e8:	00813823          	sd	s0,16(sp)
    800051ec:	00913423          	sd	s1,8(sp)
    800051f0:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    800051f4:	00007497          	auipc	s1,0x7
    800051f8:	0444b483          	ld	s1,68(s1) # 8000c238 <_ZN9Scheduler9readyHeadE>
    while(iter){
    800051fc:	02048863          	beqz	s1,8000522c <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80005200:	00000613          	li	a2,0
    80005204:	01000593          	li	a1,16
    80005208:	0004851b          	sext.w	a0,s1
    8000520c:	00000097          	auipc	ra,0x0
    80005210:	3b4080e7          	jalr	948(ra) # 800055c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80005214:	00004517          	auipc	a0,0x4
    80005218:	1ac50513          	addi	a0,a0,428 # 800093c0 <CONSOLE_STATUS+0x3b0>
    8000521c:	00000097          	auipc	ra,0x0
    80005220:	360080e7          	jalr	864(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80005224:	0484b483          	ld	s1,72(s1)
    while(iter){
    80005228:	fd5ff06f          	j	800051fc <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    8000522c:	01813083          	ld	ra,24(sp)
    80005230:	01013403          	ld	s0,16(sp)
    80005234:	00813483          	ld	s1,8(sp)
    80005238:	02010113          	addi	sp,sp,32
    8000523c:	00008067          	ret

0000000080005240 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80005240:	fe010113          	addi	sp,sp,-32
    80005244:	00113c23          	sd	ra,24(sp)
    80005248:	00813823          	sd	s0,16(sp)
    8000524c:	00913423          	sd	s1,8(sp)
    80005250:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80005254:	00007497          	auipc	s1,0x7
    80005258:	ff44b483          	ld	s1,-12(s1) # 8000c248 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    8000525c:	02048863          	beqz	s1,8000528c <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80005260:	00000613          	li	a2,0
    80005264:	01000593          	li	a1,16
    80005268:	0004851b          	sext.w	a0,s1
    8000526c:	ffffe097          	auipc	ra,0xffffe
    80005270:	b10080e7          	jalr	-1264(ra) # 80002d7c <_Z8printIntiii>
        printString("\n");
    80005274:	00004517          	auipc	a0,0x4
    80005278:	14c50513          	addi	a0,a0,332 # 800093c0 <CONSOLE_STATUS+0x3b0>
    8000527c:	ffffe097          	auipc	ra,0xffffe
    80005280:	968080e7          	jalr	-1688(ra) # 80002be4 <_Z11printStringPKc>
        iter = iter->next;
    80005284:	0484b483          	ld	s1,72(s1)
    while(iter){
    80005288:	fd5ff06f          	j	8000525c <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    8000528c:	01813083          	ld	ra,24(sp)
    80005290:	01013403          	ld	s0,16(sp)
    80005294:	00813483          	ld	s1,8(sp)
    80005298:	02010113          	addi	sp,sp,32
    8000529c:	00008067          	ret

00000000800052a0 <_ZN11ConsoleUtil10initializeEv>:
char* ConsoleUtil::inputBuffer = nullptr;
char* ConsoleUtil::outputBuffer = nullptr;

uint64 ConsoleUtil::bufferSize = 2*8192;

void ConsoleUtil::initialize() {
    800052a0:	fe010113          	addi	sp,sp,-32
    800052a4:	00113c23          	sd	ra,24(sp)
    800052a8:	00813823          	sd	s0,16(sp)
    800052ac:	00913423          	sd	s1,8(sp)
    800052b0:	01213023          	sd	s2,0(sp)
    800052b4:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    800052b8:	01800513          	li	a0,24
    800052bc:	ffffe097          	auipc	ra,0xffffe
    800052c0:	e14080e7          	jalr	-492(ra) # 800030d0 <_ZN3SCBnwEm>
    800052c4:	00050493          	mv	s1,a0
    800052c8:	00050863          	beqz	a0,800052d8 <_ZN11ConsoleUtil10initializeEv+0x38>
    800052cc:	00000593          	li	a1,0
    800052d0:	ffffe097          	auipc	ra,0xffffe
    800052d4:	c4c080e7          	jalr	-948(ra) # 80002f1c <_ZN3SCBC1Em>
    800052d8:	00007797          	auipc	a5,0x7
    800052dc:	f697bc23          	sd	s1,-136(a5) # 8000c250 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    800052e0:	01800513          	li	a0,24
    800052e4:	ffffe097          	auipc	ra,0xffffe
    800052e8:	dec080e7          	jalr	-532(ra) # 800030d0 <_ZN3SCBnwEm>
    800052ec:	00050493          	mv	s1,a0
    800052f0:	00050863          	beqz	a0,80005300 <_ZN11ConsoleUtil10initializeEv+0x60>
    800052f4:	00000593          	li	a1,0
    800052f8:	ffffe097          	auipc	ra,0xffffe
    800052fc:	c24080e7          	jalr	-988(ra) # 80002f1c <_ZN3SCBC1Em>
    80005300:	00007917          	auipc	s2,0x7
    80005304:	f5090913          	addi	s2,s2,-176 # 8000c250 <_ZN11ConsoleUtil8inputSemE>
    80005308:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    8000530c:	00007497          	auipc	s1,0x7
    80005310:	bcc48493          	addi	s1,s1,-1076 # 8000bed8 <_ZN11ConsoleUtil10bufferSizeE>
    80005314:	0004b503          	ld	a0,0(s1)
    80005318:	00000097          	auipc	ra,0x0
    8000531c:	538080e7          	jalr	1336(ra) # 80005850 <_Z7kmallocm>
    80005320:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80005324:	0004b503          	ld	a0,0(s1)
    80005328:	00000097          	auipc	ra,0x0
    8000532c:	528080e7          	jalr	1320(ra) # 80005850 <_Z7kmallocm>
    80005330:	00a93c23          	sd	a0,24(s2)
}
    80005334:	01813083          	ld	ra,24(sp)
    80005338:	01013403          	ld	s0,16(sp)
    8000533c:	00813483          	ld	s1,8(sp)
    80005340:	00013903          	ld	s2,0(sp)
    80005344:	02010113          	addi	sp,sp,32
    80005348:	00008067          	ret
    8000534c:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80005350:	00048513          	mv	a0,s1
    80005354:	ffffe097          	auipc	ra,0xffffe
    80005358:	dac080e7          	jalr	-596(ra) # 80003100 <_ZN3SCBdlEPv>
    8000535c:	00090513          	mv	a0,s2
    80005360:	00008097          	auipc	ra,0x8
    80005364:	028080e7          	jalr	40(ra) # 8000d388 <_Unwind_Resume>
    80005368:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    8000536c:	00048513          	mv	a0,s1
    80005370:	ffffe097          	auipc	ra,0xffffe
    80005374:	d90080e7          	jalr	-624(ra) # 80003100 <_ZN3SCBdlEPv>
    80005378:	00090513          	mv	a0,s2
    8000537c:	00008097          	auipc	ra,0x8
    80005380:	00c080e7          	jalr	12(ra) # 8000d388 <_Unwind_Resume>

0000000080005384 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80005384:	00007717          	auipc	a4,0x7
    80005388:	ecc70713          	addi	a4,a4,-308 # 8000c250 <_ZN11ConsoleUtil8inputSemE>
    8000538c:	02073683          	ld	a3,32(a4)
    80005390:	00168793          	addi	a5,a3,1
    80005394:	00007617          	auipc	a2,0x7
    80005398:	b4463603          	ld	a2,-1212(a2) # 8000bed8 <_ZN11ConsoleUtil10bufferSizeE>
    8000539c:	02c7f7b3          	remu	a5,a5,a2
    800053a0:	02873703          	ld	a4,40(a4)
    800053a4:	04e78e63          	beq	a5,a4,80005400 <_ZN11ConsoleUtil8putInputEc+0x7c>
void ConsoleUtil::putInput(char c) {
    800053a8:	ff010113          	addi	sp,sp,-16
    800053ac:	00113423          	sd	ra,8(sp)
    800053b0:	00813023          	sd	s0,0(sp)
    800053b4:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    800053b8:	00007717          	auipc	a4,0x7
    800053bc:	e9870713          	addi	a4,a4,-360 # 8000c250 <_ZN11ConsoleUtil8inputSemE>
    800053c0:	01073783          	ld	a5,16(a4)
    800053c4:	00d786b3          	add	a3,a5,a3
    800053c8:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    800053cc:	02073783          	ld	a5,32(a4)
    800053d0:	00178793          	addi	a5,a5,1
    800053d4:	00007697          	auipc	a3,0x7
    800053d8:	b046b683          	ld	a3,-1276(a3) # 8000bed8 <_ZN11ConsoleUtil10bufferSizeE>
    800053dc:	02d7f7b3          	remu	a5,a5,a3
    800053e0:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    800053e4:	00073503          	ld	a0,0(a4)
    800053e8:	ffffe097          	auipc	ra,0xffffe
    800053ec:	cac080e7          	jalr	-852(ra) # 80003094 <_ZN3SCB6signalEv>
}
    800053f0:	00813083          	ld	ra,8(sp)
    800053f4:	00013403          	ld	s0,0(sp)
    800053f8:	01010113          	addi	sp,sp,16
    800053fc:	00008067          	ret
    80005400:	00008067          	ret

0000000080005404 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80005404:	fe010113          	addi	sp,sp,-32
    80005408:	00113c23          	sd	ra,24(sp)
    8000540c:	00813823          	sd	s0,16(sp)
    80005410:	00913423          	sd	s1,8(sp)
    80005414:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80005418:	00007497          	auipc	s1,0x7
    8000541c:	e3848493          	addi	s1,s1,-456 # 8000c250 <_ZN11ConsoleUtil8inputSemE>
    80005420:	0004b503          	ld	a0,0(s1)
    80005424:	ffffe097          	auipc	ra,0xffffe
    80005428:	c20080e7          	jalr	-992(ra) # 80003044 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    8000542c:	0284b783          	ld	a5,40(s1)
    80005430:	0204b703          	ld	a4,32(s1)
    80005434:	02e78c63          	beq	a5,a4,8000546c <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    80005438:	0104b703          	ld	a4,16(s1)
    8000543c:	00f70733          	add	a4,a4,a5
    80005440:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80005444:	00178793          	addi	a5,a5,1
    80005448:	00007717          	auipc	a4,0x7
    8000544c:	a9073703          	ld	a4,-1392(a4) # 8000bed8 <_ZN11ConsoleUtil10bufferSizeE>
    80005450:	02e7f7b3          	remu	a5,a5,a4
    80005454:	02f4b423          	sd	a5,40(s1)

    return c;
}
    80005458:	01813083          	ld	ra,24(sp)
    8000545c:	01013403          	ld	s0,16(sp)
    80005460:	00813483          	ld	s1,8(sp)
    80005464:	02010113          	addi	sp,sp,32
    80005468:	00008067          	ret
        return -1;
    8000546c:	0ff00513          	li	a0,255
    80005470:	fe9ff06f          	j	80005458 <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080005474 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80005474:	00007797          	auipc	a5,0x7
    80005478:	ddc78793          	addi	a5,a5,-548 # 8000c250 <_ZN11ConsoleUtil8inputSemE>
    8000547c:	0307b703          	ld	a4,48(a5)
    80005480:	00170713          	addi	a4,a4,1
    80005484:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80005488:	0387b683          	ld	a3,56(a5)
    8000548c:	00168713          	addi	a4,a3,1
    80005490:	00007617          	auipc	a2,0x7
    80005494:	a4863603          	ld	a2,-1464(a2) # 8000bed8 <_ZN11ConsoleUtil10bufferSizeE>
    80005498:	02c77733          	remu	a4,a4,a2
    8000549c:	0407b783          	ld	a5,64(a5)
    800054a0:	06f70463          	beq	a4,a5,80005508 <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    800054a4:	ff010113          	addi	sp,sp,-16
    800054a8:	00113423          	sd	ra,8(sp)
    800054ac:	00813023          	sd	s0,0(sp)
    800054b0:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    800054b4:	00007797          	auipc	a5,0x7
    800054b8:	d9c78793          	addi	a5,a5,-612 # 8000c250 <_ZN11ConsoleUtil8inputSemE>
    800054bc:	0187b703          	ld	a4,24(a5)
    800054c0:	00d706b3          	add	a3,a4,a3
    800054c4:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    800054c8:	0387b703          	ld	a4,56(a5)
    800054cc:	00170713          	addi	a4,a4,1
    800054d0:	00007697          	auipc	a3,0x7
    800054d4:	a086b683          	ld	a3,-1528(a3) # 8000bed8 <_ZN11ConsoleUtil10bufferSizeE>
    800054d8:	02d77733          	remu	a4,a4,a3
    800054dc:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    800054e0:	0307b703          	ld	a4,48(a5)
    800054e4:	fff70713          	addi	a4,a4,-1
    800054e8:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    800054ec:	0087b503          	ld	a0,8(a5)
    800054f0:	ffffe097          	auipc	ra,0xffffe
    800054f4:	ba4080e7          	jalr	-1116(ra) # 80003094 <_ZN3SCB6signalEv>
}
    800054f8:	00813083          	ld	ra,8(sp)
    800054fc:	00013403          	ld	s0,0(sp)
    80005500:	01010113          	addi	sp,sp,16
    80005504:	00008067          	ret
    80005508:	00008067          	ret

000000008000550c <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    8000550c:	fe010113          	addi	sp,sp,-32
    80005510:	00113c23          	sd	ra,24(sp)
    80005514:	00813823          	sd	s0,16(sp)
    80005518:	00913423          	sd	s1,8(sp)
    8000551c:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80005520:	00007497          	auipc	s1,0x7
    80005524:	d3048493          	addi	s1,s1,-720 # 8000c250 <_ZN11ConsoleUtil8inputSemE>
    80005528:	0084b503          	ld	a0,8(s1)
    8000552c:	ffffe097          	auipc	ra,0xffffe
    80005530:	b18080e7          	jalr	-1256(ra) # 80003044 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80005534:	0404b783          	ld	a5,64(s1)
    80005538:	0384b703          	ld	a4,56(s1)
    8000553c:	02e78c63          	beq	a5,a4,80005574 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    80005540:	0184b703          	ld	a4,24(s1)
    80005544:	00f70733          	add	a4,a4,a5
    80005548:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    8000554c:	00178793          	addi	a5,a5,1
    80005550:	00007717          	auipc	a4,0x7
    80005554:	98873703          	ld	a4,-1656(a4) # 8000bed8 <_ZN11ConsoleUtil10bufferSizeE>
    80005558:	02e7f7b3          	remu	a5,a5,a4
    8000555c:	04f4b023          	sd	a5,64(s1)

    return c;
}
    80005560:	01813083          	ld	ra,24(sp)
    80005564:	01013403          	ld	s0,16(sp)
    80005568:	00813483          	ld	s1,8(sp)
    8000556c:	02010113          	addi	sp,sp,32
    80005570:	00008067          	ret
        return -1;
    80005574:	0ff00513          	li	a0,255
    80005578:	fe9ff06f          	j	80005560 <_ZN11ConsoleUtil9getOutputEv+0x54>

000000008000557c <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    8000557c:	fe010113          	addi	sp,sp,-32
    80005580:	00113c23          	sd	ra,24(sp)
    80005584:	00813823          	sd	s0,16(sp)
    80005588:	00913423          	sd	s1,8(sp)
    8000558c:	02010413          	addi	s0,sp,32
    80005590:	00050493          	mv	s1,a0
    while (*string != '\0')
    80005594:	0004c503          	lbu	a0,0(s1)
    80005598:	00050a63          	beqz	a0,800055ac <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    8000559c:	00000097          	auipc	ra,0x0
    800055a0:	ed8080e7          	jalr	-296(ra) # 80005474 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    800055a4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800055a8:	fedff06f          	j	80005594 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    800055ac:	01813083          	ld	ra,24(sp)
    800055b0:	01013403          	ld	s0,16(sp)
    800055b4:	00813483          	ld	s1,8(sp)
    800055b8:	02010113          	addi	sp,sp,32
    800055bc:	00008067          	ret

00000000800055c0 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800055c0:	fb010113          	addi	sp,sp,-80
    800055c4:	04113423          	sd	ra,72(sp)
    800055c8:	04813023          	sd	s0,64(sp)
    800055cc:	02913c23          	sd	s1,56(sp)
    800055d0:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800055d4:	00004797          	auipc	a5,0x4
    800055d8:	fe478793          	addi	a5,a5,-28 # 800095b8 <CONSOLE_STATUS+0x5a8>
    800055dc:	0007b703          	ld	a4,0(a5)
    800055e0:	fce43423          	sd	a4,-56(s0)
    800055e4:	0087b703          	ld	a4,8(a5)
    800055e8:	fce43823          	sd	a4,-48(s0)
    800055ec:	0107c783          	lbu	a5,16(a5)
    800055f0:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800055f4:	00060463          	beqz	a2,800055fc <_ZN11ConsoleUtil8printIntEiii+0x3c>
    800055f8:	08054263          	bltz	a0,8000567c <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800055fc:	0005051b          	sext.w	a0,a0
    neg = 0;
    80005600:	00000813          	li	a6,0
    }

    i = 0;
    80005604:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80005608:	0005871b          	sext.w	a4,a1
    8000560c:	02b577bb          	remuw	a5,a0,a1
    80005610:	00048693          	mv	a3,s1
    80005614:	0014849b          	addiw	s1,s1,1
    80005618:	02079793          	slli	a5,a5,0x20
    8000561c:	0207d793          	srli	a5,a5,0x20
    80005620:	fe040613          	addi	a2,s0,-32
    80005624:	00f607b3          	add	a5,a2,a5
    80005628:	fe87c603          	lbu	a2,-24(a5)
    8000562c:	fe040793          	addi	a5,s0,-32
    80005630:	00d787b3          	add	a5,a5,a3
    80005634:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80005638:	0005061b          	sext.w	a2,a0
    8000563c:	02b5553b          	divuw	a0,a0,a1
    80005640:	fce674e3          	bgeu	a2,a4,80005608 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80005644:	00080c63          	beqz	a6,8000565c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80005648:	fe040793          	addi	a5,s0,-32
    8000564c:	009784b3          	add	s1,a5,s1
    80005650:	02d00793          	li	a5,45
    80005654:	fcf48c23          	sb	a5,-40(s1)
    80005658:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    8000565c:	fff4849b          	addiw	s1,s1,-1
    80005660:	0204c463          	bltz	s1,80005688 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80005664:	fe040793          	addi	a5,s0,-32
    80005668:	009787b3          	add	a5,a5,s1
    8000566c:	fd87c503          	lbu	a0,-40(a5)
    80005670:	00000097          	auipc	ra,0x0
    80005674:	e04080e7          	jalr	-508(ra) # 80005474 <_ZN11ConsoleUtil9putOutputEc>
    80005678:	fe5ff06f          	j	8000565c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    8000567c:	40a0053b          	negw	a0,a0
        neg = 1;
    80005680:	00100813          	li	a6,1
        x = -xx;
    80005684:	f81ff06f          	j	80005604 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80005688:	04813083          	ld	ra,72(sp)
    8000568c:	04013403          	ld	s0,64(sp)
    80005690:	03813483          	ld	s1,56(sp)
    80005694:	05010113          	addi	sp,sp,80
    80005698:	00008067          	ret

000000008000569c <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    8000569c:	fd010113          	addi	sp,sp,-48
    800056a0:	02113423          	sd	ra,40(sp)
    800056a4:	02813023          	sd	s0,32(sp)
    800056a8:	00913c23          	sd	s1,24(sp)
    800056ac:	01213823          	sd	s2,16(sp)
    800056b0:	01313423          	sd	s3,8(sp)
    800056b4:	03010413          	addi	s0,sp,48
    800056b8:	00058913          	mv	s2,a1
    800056bc:	00060493          	mv	s1,a2
    800056c0:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    800056c4:	00000097          	auipc	ra,0x0
    800056c8:	eb8080e7          	jalr	-328(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    800056cc:	00000613          	li	a2,0
    800056d0:	00098593          	mv	a1,s3
    800056d4:	00090513          	mv	a0,s2
    800056d8:	00000097          	auipc	ra,0x0
    800056dc:	ee8080e7          	jalr	-280(ra) # 800055c0 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    800056e0:	00048513          	mv	a0,s1
    800056e4:	00000097          	auipc	ra,0x0
    800056e8:	e98080e7          	jalr	-360(ra) # 8000557c <_ZN11ConsoleUtil11printStringEPKc>
}
    800056ec:	02813083          	ld	ra,40(sp)
    800056f0:	02013403          	ld	s0,32(sp)
    800056f4:	01813483          	ld	s1,24(sp)
    800056f8:	01013903          	ld	s2,16(sp)
    800056fc:	00813983          	ld	s3,8(sp)
    80005700:	03010113          	addi	sp,sp,48
    80005704:	00008067          	ret

0000000080005708 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80005708:	ff010113          	addi	sp,sp,-16
    8000570c:	00813423          	sd	s0,8(sp)
    80005710:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80005714:	04300513          	li	a0,67

    asm("ecall");
    80005718:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    8000571c:	00050513          	mv	a0,a0

    return (char)status;
}
    80005720:	0ff57513          	andi	a0,a0,255
    80005724:	00813403          	ld	s0,8(sp)
    80005728:	01010113          	addi	sp,sp,16
    8000572c:	00008067          	ret

0000000080005730 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80005730:	ff010113          	addi	sp,sp,-16
    80005734:	00113423          	sd	ra,8(sp)
    80005738:	00813023          	sd	s0,0(sp)
    8000573c:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80005740:	ffffc097          	auipc	ra,0xffffc
    80005744:	298080e7          	jalr	664(ra) # 800019d8 <_ZN13SlabAllocator10initializeEPvm>
}
    80005748:	00813083          	ld	ra,8(sp)
    8000574c:	00013403          	ld	s0,0(sp)
    80005750:	01010113          	addi	sp,sp,16
    80005754:	00008067          	ret

0000000080005758 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80005758:	ff010113          	addi	sp,sp,-16
    8000575c:	00113423          	sd	ra,8(sp)
    80005760:	00813023          	sd	s0,0(sp)
    80005764:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80005768:	ffffc097          	auipc	ra,0xffffc
    8000576c:	1cc080e7          	jalr	460(ra) # 80001934 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80005770:	00813083          	ld	ra,8(sp)
    80005774:	00013403          	ld	s0,0(sp)
    80005778:	01010113          	addi	sp,sp,16
    8000577c:	00008067          	ret

0000000080005780 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80005780:	ff010113          	addi	sp,sp,-16
    80005784:	00113423          	sd	ra,8(sp)
    80005788:	00813023          	sd	s0,0(sp)
    8000578c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80005790:	ffffc097          	auipc	ra,0xffffc
    80005794:	068080e7          	jalr	104(ra) # 800017f8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80005798:	00813083          	ld	ra,8(sp)
    8000579c:	00013403          	ld	s0,0(sp)
    800057a0:	01010113          	addi	sp,sp,16
    800057a4:	00008067          	ret

00000000800057a8 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    800057a8:	ff010113          	addi	sp,sp,-16
    800057ac:	00113423          	sd	ra,8(sp)
    800057b0:	00813023          	sd	s0,0(sp)
    800057b4:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    800057b8:	ffffc097          	auipc	ra,0xffffc
    800057bc:	3f8080e7          	jalr	1016(ra) # 80001bb0 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    800057c0:	00813083          	ld	ra,8(sp)
    800057c4:	00013403          	ld	s0,0(sp)
    800057c8:	01010113          	addi	sp,sp,16
    800057cc:	00008067          	ret

00000000800057d0 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    800057d0:	fe010113          	addi	sp,sp,-32
    800057d4:	00113c23          	sd	ra,24(sp)
    800057d8:	00813823          	sd	s0,16(sp)
    800057dc:	02010413          	addi	s0,sp,32
    800057e0:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    800057e4:	fe840513          	addi	a0,s0,-24
    800057e8:	ffffc097          	auipc	ra,0xffffc
    800057ec:	528080e7          	jalr	1320(ra) # 80001d10 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    800057f0:	01813083          	ld	ra,24(sp)
    800057f4:	01013403          	ld	s0,16(sp)
    800057f8:	02010113          	addi	sp,sp,32
    800057fc:	00008067          	ret

0000000080005800 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80005800:	ff010113          	addi	sp,sp,-16
    80005804:	00113423          	sd	ra,8(sp)
    80005808:	00813023          	sd	s0,0(sp)
    8000580c:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80005810:	ffffc097          	auipc	ra,0xffffc
    80005814:	b0c080e7          	jalr	-1268(ra) # 8000131c <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80005818:	00813083          	ld	ra,8(sp)
    8000581c:	00013403          	ld	s0,0(sp)
    80005820:	01010113          	addi	sp,sp,16
    80005824:	00008067          	ret

0000000080005828 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80005828:	ff010113          	addi	sp,sp,-16
    8000582c:	00113423          	sd	ra,8(sp)
    80005830:	00813023          	sd	s0,0(sp)
    80005834:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80005838:	ffffc097          	auipc	ra,0xffffc
    8000583c:	91c080e7          	jalr	-1764(ra) # 80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80005840:	00813083          	ld	ra,8(sp)
    80005844:	00013403          	ld	s0,0(sp)
    80005848:	01010113          	addi	sp,sp,16
    8000584c:	00008067          	ret

0000000080005850 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80005850:	ff010113          	addi	sp,sp,-16
    80005854:	00113423          	sd	ra,8(sp)
    80005858:	00813023          	sd	s0,0(sp)
    8000585c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80005860:	ffffc097          	auipc	ra,0xffffc
    80005864:	034080e7          	jalr	52(ra) # 80001894 <_ZN13SlabAllocator14allocateBufferEm>
}
    80005868:	00813083          	ld	ra,8(sp)
    8000586c:	00013403          	ld	s0,0(sp)
    80005870:	01010113          	addi	sp,sp,16
    80005874:	00008067          	ret

0000000080005878 <_Z5kfreePKv>:

void kfree(const void* objp){
    80005878:	ff010113          	addi	sp,sp,-16
    8000587c:	00113423          	sd	ra,8(sp)
    80005880:	00813023          	sd	s0,0(sp)
    80005884:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80005888:	ffffc097          	auipc	ra,0xffffc
    8000588c:	41c080e7          	jalr	1052(ra) # 80001ca4 <_ZN13SlabAllocator10freeBufferEPKv>
    80005890:	00813083          	ld	ra,8(sp)
    80005894:	00013403          	ld	s0,0(sp)
    80005898:	01010113          	addi	sp,sp,16
    8000589c:	00008067          	ret

00000000800058a0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800058a0:	fd010113          	addi	sp,sp,-48
    800058a4:	02113423          	sd	ra,40(sp)
    800058a8:	02813023          	sd	s0,32(sp)
    800058ac:	00913c23          	sd	s1,24(sp)
    800058b0:	01213823          	sd	s2,16(sp)
    800058b4:	01313423          	sd	s3,8(sp)
    800058b8:	03010413          	addi	s0,sp,48
    800058bc:	00050493          	mv	s1,a0
    800058c0:	00058993          	mv	s3,a1
    800058c4:	0015879b          	addiw	a5,a1,1
    800058c8:	0007851b          	sext.w	a0,a5
    800058cc:	00f4a023          	sw	a5,0(s1)
    800058d0:	0004a823          	sw	zero,16(s1)
    800058d4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800058d8:	00251513          	slli	a0,a0,0x2
    800058dc:	ffffc097          	auipc	ra,0xffffc
    800058e0:	510080e7          	jalr	1296(ra) # 80001dec <_Z9mem_allocm>
    800058e4:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800058e8:	01000513          	li	a0,16
    800058ec:	ffffe097          	auipc	ra,0xffffe
    800058f0:	148080e7          	jalr	328(ra) # 80003a34 <_Znwm>
    800058f4:	00050913          	mv	s2,a0
    800058f8:	00050863          	beqz	a0,80005908 <_ZN9BufferCPPC1Ei+0x68>
    800058fc:	00000593          	li	a1,0
    80005900:	ffffe097          	auipc	ra,0xffffe
    80005904:	22c080e7          	jalr	556(ra) # 80003b2c <_ZN9SemaphoreC1Ej>
    80005908:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000590c:	01000513          	li	a0,16
    80005910:	ffffe097          	auipc	ra,0xffffe
    80005914:	124080e7          	jalr	292(ra) # 80003a34 <_Znwm>
    80005918:	00050913          	mv	s2,a0
    8000591c:	00050863          	beqz	a0,8000592c <_ZN9BufferCPPC1Ei+0x8c>
    80005920:	00098593          	mv	a1,s3
    80005924:	ffffe097          	auipc	ra,0xffffe
    80005928:	208080e7          	jalr	520(ra) # 80003b2c <_ZN9SemaphoreC1Ej>
    8000592c:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80005930:	01000513          	li	a0,16
    80005934:	ffffe097          	auipc	ra,0xffffe
    80005938:	100080e7          	jalr	256(ra) # 80003a34 <_Znwm>
    8000593c:	00050913          	mv	s2,a0
    80005940:	00050863          	beqz	a0,80005950 <_ZN9BufferCPPC1Ei+0xb0>
    80005944:	00100593          	li	a1,1
    80005948:	ffffe097          	auipc	ra,0xffffe
    8000594c:	1e4080e7          	jalr	484(ra) # 80003b2c <_ZN9SemaphoreC1Ej>
    80005950:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80005954:	01000513          	li	a0,16
    80005958:	ffffe097          	auipc	ra,0xffffe
    8000595c:	0dc080e7          	jalr	220(ra) # 80003a34 <_Znwm>
    80005960:	00050913          	mv	s2,a0
    80005964:	00050863          	beqz	a0,80005974 <_ZN9BufferCPPC1Ei+0xd4>
    80005968:	00100593          	li	a1,1
    8000596c:	ffffe097          	auipc	ra,0xffffe
    80005970:	1c0080e7          	jalr	448(ra) # 80003b2c <_ZN9SemaphoreC1Ej>
    80005974:	0324b823          	sd	s2,48(s1)
}
    80005978:	02813083          	ld	ra,40(sp)
    8000597c:	02013403          	ld	s0,32(sp)
    80005980:	01813483          	ld	s1,24(sp)
    80005984:	01013903          	ld	s2,16(sp)
    80005988:	00813983          	ld	s3,8(sp)
    8000598c:	03010113          	addi	sp,sp,48
    80005990:	00008067          	ret
    80005994:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80005998:	00090513          	mv	a0,s2
    8000599c:	ffffe097          	auipc	ra,0xffffe
    800059a0:	0e8080e7          	jalr	232(ra) # 80003a84 <_ZdlPv>
    800059a4:	00048513          	mv	a0,s1
    800059a8:	00008097          	auipc	ra,0x8
    800059ac:	9e0080e7          	jalr	-1568(ra) # 8000d388 <_Unwind_Resume>
    800059b0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800059b4:	00090513          	mv	a0,s2
    800059b8:	ffffe097          	auipc	ra,0xffffe
    800059bc:	0cc080e7          	jalr	204(ra) # 80003a84 <_ZdlPv>
    800059c0:	00048513          	mv	a0,s1
    800059c4:	00008097          	auipc	ra,0x8
    800059c8:	9c4080e7          	jalr	-1596(ra) # 8000d388 <_Unwind_Resume>
    800059cc:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800059d0:	00090513          	mv	a0,s2
    800059d4:	ffffe097          	auipc	ra,0xffffe
    800059d8:	0b0080e7          	jalr	176(ra) # 80003a84 <_ZdlPv>
    800059dc:	00048513          	mv	a0,s1
    800059e0:	00008097          	auipc	ra,0x8
    800059e4:	9a8080e7          	jalr	-1624(ra) # 8000d388 <_Unwind_Resume>
    800059e8:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800059ec:	00090513          	mv	a0,s2
    800059f0:	ffffe097          	auipc	ra,0xffffe
    800059f4:	094080e7          	jalr	148(ra) # 80003a84 <_ZdlPv>
    800059f8:	00048513          	mv	a0,s1
    800059fc:	00008097          	auipc	ra,0x8
    80005a00:	98c080e7          	jalr	-1652(ra) # 8000d388 <_Unwind_Resume>

0000000080005a04 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80005a04:	fe010113          	addi	sp,sp,-32
    80005a08:	00113c23          	sd	ra,24(sp)
    80005a0c:	00813823          	sd	s0,16(sp)
    80005a10:	00913423          	sd	s1,8(sp)
    80005a14:	01213023          	sd	s2,0(sp)
    80005a18:	02010413          	addi	s0,sp,32
    80005a1c:	00050493          	mv	s1,a0
    80005a20:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80005a24:	01853503          	ld	a0,24(a0)
    80005a28:	ffffe097          	auipc	ra,0xffffe
    80005a2c:	13c080e7          	jalr	316(ra) # 80003b64 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80005a30:	0304b503          	ld	a0,48(s1)
    80005a34:	ffffe097          	auipc	ra,0xffffe
    80005a38:	130080e7          	jalr	304(ra) # 80003b64 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80005a3c:	0084b783          	ld	a5,8(s1)
    80005a40:	0144a703          	lw	a4,20(s1)
    80005a44:	00271713          	slli	a4,a4,0x2
    80005a48:	00e787b3          	add	a5,a5,a4
    80005a4c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005a50:	0144a783          	lw	a5,20(s1)
    80005a54:	0017879b          	addiw	a5,a5,1
    80005a58:	0004a703          	lw	a4,0(s1)
    80005a5c:	02e7e7bb          	remw	a5,a5,a4
    80005a60:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80005a64:	0304b503          	ld	a0,48(s1)
    80005a68:	ffffe097          	auipc	ra,0xffffe
    80005a6c:	128080e7          	jalr	296(ra) # 80003b90 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80005a70:	0204b503          	ld	a0,32(s1)
    80005a74:	ffffe097          	auipc	ra,0xffffe
    80005a78:	11c080e7          	jalr	284(ra) # 80003b90 <_ZN9Semaphore6signalEv>

}
    80005a7c:	01813083          	ld	ra,24(sp)
    80005a80:	01013403          	ld	s0,16(sp)
    80005a84:	00813483          	ld	s1,8(sp)
    80005a88:	00013903          	ld	s2,0(sp)
    80005a8c:	02010113          	addi	sp,sp,32
    80005a90:	00008067          	ret

0000000080005a94 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80005a94:	fe010113          	addi	sp,sp,-32
    80005a98:	00113c23          	sd	ra,24(sp)
    80005a9c:	00813823          	sd	s0,16(sp)
    80005aa0:	00913423          	sd	s1,8(sp)
    80005aa4:	01213023          	sd	s2,0(sp)
    80005aa8:	02010413          	addi	s0,sp,32
    80005aac:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80005ab0:	02053503          	ld	a0,32(a0)
    80005ab4:	ffffe097          	auipc	ra,0xffffe
    80005ab8:	0b0080e7          	jalr	176(ra) # 80003b64 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005abc:	0284b503          	ld	a0,40(s1)
    80005ac0:	ffffe097          	auipc	ra,0xffffe
    80005ac4:	0a4080e7          	jalr	164(ra) # 80003b64 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80005ac8:	0084b703          	ld	a4,8(s1)
    80005acc:	0104a783          	lw	a5,16(s1)
    80005ad0:	00279693          	slli	a3,a5,0x2
    80005ad4:	00d70733          	add	a4,a4,a3
    80005ad8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005adc:	0017879b          	addiw	a5,a5,1
    80005ae0:	0004a703          	lw	a4,0(s1)
    80005ae4:	02e7e7bb          	remw	a5,a5,a4
    80005ae8:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005aec:	0284b503          	ld	a0,40(s1)
    80005af0:	ffffe097          	auipc	ra,0xffffe
    80005af4:	0a0080e7          	jalr	160(ra) # 80003b90 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80005af8:	0184b503          	ld	a0,24(s1)
    80005afc:	ffffe097          	auipc	ra,0xffffe
    80005b00:	094080e7          	jalr	148(ra) # 80003b90 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005b04:	00090513          	mv	a0,s2
    80005b08:	01813083          	ld	ra,24(sp)
    80005b0c:	01013403          	ld	s0,16(sp)
    80005b10:	00813483          	ld	s1,8(sp)
    80005b14:	00013903          	ld	s2,0(sp)
    80005b18:	02010113          	addi	sp,sp,32
    80005b1c:	00008067          	ret

0000000080005b20 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80005b20:	fe010113          	addi	sp,sp,-32
    80005b24:	00113c23          	sd	ra,24(sp)
    80005b28:	00813823          	sd	s0,16(sp)
    80005b2c:	00913423          	sd	s1,8(sp)
    80005b30:	01213023          	sd	s2,0(sp)
    80005b34:	02010413          	addi	s0,sp,32
    80005b38:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80005b3c:	02853503          	ld	a0,40(a0)
    80005b40:	ffffe097          	auipc	ra,0xffffe
    80005b44:	024080e7          	jalr	36(ra) # 80003b64 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80005b48:	0304b503          	ld	a0,48(s1)
    80005b4c:	ffffe097          	auipc	ra,0xffffe
    80005b50:	018080e7          	jalr	24(ra) # 80003b64 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005b54:	0144a783          	lw	a5,20(s1)
    80005b58:	0104a903          	lw	s2,16(s1)
    80005b5c:	0327ce63          	blt	a5,s2,80005b98 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80005b60:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005b64:	0304b503          	ld	a0,48(s1)
    80005b68:	ffffe097          	auipc	ra,0xffffe
    80005b6c:	028080e7          	jalr	40(ra) # 80003b90 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80005b70:	0284b503          	ld	a0,40(s1)
    80005b74:	ffffe097          	auipc	ra,0xffffe
    80005b78:	01c080e7          	jalr	28(ra) # 80003b90 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005b7c:	00090513          	mv	a0,s2
    80005b80:	01813083          	ld	ra,24(sp)
    80005b84:	01013403          	ld	s0,16(sp)
    80005b88:	00813483          	ld	s1,8(sp)
    80005b8c:	00013903          	ld	s2,0(sp)
    80005b90:	02010113          	addi	sp,sp,32
    80005b94:	00008067          	ret
        ret = cap - head + tail;
    80005b98:	0004a703          	lw	a4,0(s1)
    80005b9c:	4127093b          	subw	s2,a4,s2
    80005ba0:	00f9093b          	addw	s2,s2,a5
    80005ba4:	fc1ff06f          	j	80005b64 <_ZN9BufferCPP6getCntEv+0x44>

0000000080005ba8 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80005ba8:	fe010113          	addi	sp,sp,-32
    80005bac:	00113c23          	sd	ra,24(sp)
    80005bb0:	00813823          	sd	s0,16(sp)
    80005bb4:	00913423          	sd	s1,8(sp)
    80005bb8:	02010413          	addi	s0,sp,32
    80005bbc:	00050493          	mv	s1,a0
    Console::putc('\n');
    80005bc0:	00a00513          	li	a0,10
    80005bc4:	ffffe097          	auipc	ra,0xffffe
    80005bc8:	204080e7          	jalr	516(ra) # 80003dc8 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80005bcc:	00004517          	auipc	a0,0x4
    80005bd0:	a0450513          	addi	a0,a0,-1532 # 800095d0 <CONSOLE_STATUS+0x5c0>
    80005bd4:	ffffd097          	auipc	ra,0xffffd
    80005bd8:	010080e7          	jalr	16(ra) # 80002be4 <_Z11printStringPKc>
    while (getCnt()) {
    80005bdc:	00048513          	mv	a0,s1
    80005be0:	00000097          	auipc	ra,0x0
    80005be4:	f40080e7          	jalr	-192(ra) # 80005b20 <_ZN9BufferCPP6getCntEv>
    80005be8:	02050c63          	beqz	a0,80005c20 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005bec:	0084b783          	ld	a5,8(s1)
    80005bf0:	0104a703          	lw	a4,16(s1)
    80005bf4:	00271713          	slli	a4,a4,0x2
    80005bf8:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80005bfc:	0007c503          	lbu	a0,0(a5)
    80005c00:	ffffe097          	auipc	ra,0xffffe
    80005c04:	1c8080e7          	jalr	456(ra) # 80003dc8 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80005c08:	0104a783          	lw	a5,16(s1)
    80005c0c:	0017879b          	addiw	a5,a5,1
    80005c10:	0004a703          	lw	a4,0(s1)
    80005c14:	02e7e7bb          	remw	a5,a5,a4
    80005c18:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80005c1c:	fc1ff06f          	j	80005bdc <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80005c20:	02100513          	li	a0,33
    80005c24:	ffffe097          	auipc	ra,0xffffe
    80005c28:	1a4080e7          	jalr	420(ra) # 80003dc8 <_ZN7Console4putcEc>
    Console::putc('\n');
    80005c2c:	00a00513          	li	a0,10
    80005c30:	ffffe097          	auipc	ra,0xffffe
    80005c34:	198080e7          	jalr	408(ra) # 80003dc8 <_ZN7Console4putcEc>
    mem_free(buffer);
    80005c38:	0084b503          	ld	a0,8(s1)
    80005c3c:	ffffc097          	auipc	ra,0xffffc
    80005c40:	1e0080e7          	jalr	480(ra) # 80001e1c <_Z8mem_freePv>
    delete itemAvailable;
    80005c44:	0204b503          	ld	a0,32(s1)
    80005c48:	00050863          	beqz	a0,80005c58 <_ZN9BufferCPPD1Ev+0xb0>
    80005c4c:	00053783          	ld	a5,0(a0)
    80005c50:	0087b783          	ld	a5,8(a5)
    80005c54:	000780e7          	jalr	a5
    delete spaceAvailable;
    80005c58:	0184b503          	ld	a0,24(s1)
    80005c5c:	00050863          	beqz	a0,80005c6c <_ZN9BufferCPPD1Ev+0xc4>
    80005c60:	00053783          	ld	a5,0(a0)
    80005c64:	0087b783          	ld	a5,8(a5)
    80005c68:	000780e7          	jalr	a5
    delete mutexTail;
    80005c6c:	0304b503          	ld	a0,48(s1)
    80005c70:	00050863          	beqz	a0,80005c80 <_ZN9BufferCPPD1Ev+0xd8>
    80005c74:	00053783          	ld	a5,0(a0)
    80005c78:	0087b783          	ld	a5,8(a5)
    80005c7c:	000780e7          	jalr	a5
    delete mutexHead;
    80005c80:	0284b503          	ld	a0,40(s1)
    80005c84:	00050863          	beqz	a0,80005c94 <_ZN9BufferCPPD1Ev+0xec>
    80005c88:	00053783          	ld	a5,0(a0)
    80005c8c:	0087b783          	ld	a5,8(a5)
    80005c90:	000780e7          	jalr	a5
}
    80005c94:	01813083          	ld	ra,24(sp)
    80005c98:	01013403          	ld	s0,16(sp)
    80005c9c:	00813483          	ld	s1,8(sp)
    80005ca0:	02010113          	addi	sp,sp,32
    80005ca4:	00008067          	ret

0000000080005ca8 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    80005ca8:	fe010113          	addi	sp,sp,-32
    80005cac:	00113c23          	sd	ra,24(sp)
    80005cb0:	00813823          	sd	s0,16(sp)
    80005cb4:	00913423          	sd	s1,8(sp)
    80005cb8:	01213023          	sd	s2,0(sp)
    80005cbc:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005cc0:	00000913          	li	s2,0
    80005cc4:	0380006f          	j	80005cfc <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005cc8:	ffffc097          	auipc	ra,0xffffc
    80005ccc:	234080e7          	jalr	564(ra) # 80001efc <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005cd0:	00148493          	addi	s1,s1,1
    80005cd4:	000027b7          	lui	a5,0x2
    80005cd8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005cdc:	0097ee63          	bltu	a5,s1,80005cf8 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005ce0:	00000713          	li	a4,0
    80005ce4:	000077b7          	lui	a5,0x7
    80005ce8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005cec:	fce7eee3          	bltu	a5,a4,80005cc8 <_Z11workerBodyAPv+0x20>
    80005cf0:	00170713          	addi	a4,a4,1
    80005cf4:	ff1ff06f          	j	80005ce4 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005cf8:	00190913          	addi	s2,s2,1
    80005cfc:	00900793          	li	a5,9
    80005d00:	0527e063          	bltu	a5,s2,80005d40 <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005d04:	00004517          	auipc	a0,0x4
    80005d08:	8e450513          	addi	a0,a0,-1820 # 800095e8 <CONSOLE_STATUS+0x5d8>
    80005d0c:	ffffd097          	auipc	ra,0xffffd
    80005d10:	ed8080e7          	jalr	-296(ra) # 80002be4 <_Z11printStringPKc>
    80005d14:	00000613          	li	a2,0
    80005d18:	00a00593          	li	a1,10
    80005d1c:	0009051b          	sext.w	a0,s2
    80005d20:	ffffd097          	auipc	ra,0xffffd
    80005d24:	05c080e7          	jalr	92(ra) # 80002d7c <_Z8printIntiii>
    80005d28:	00003517          	auipc	a0,0x3
    80005d2c:	69850513          	addi	a0,a0,1688 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80005d30:	ffffd097          	auipc	ra,0xffffd
    80005d34:	eb4080e7          	jalr	-332(ra) # 80002be4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005d38:	00000493          	li	s1,0
    80005d3c:	f99ff06f          	j	80005cd4 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    80005d40:	00004517          	auipc	a0,0x4
    80005d44:	8b050513          	addi	a0,a0,-1872 # 800095f0 <CONSOLE_STATUS+0x5e0>
    80005d48:	ffffd097          	auipc	ra,0xffffd
    80005d4c:	e9c080e7          	jalr	-356(ra) # 80002be4 <_Z11printStringPKc>
    finishedA = true;
    80005d50:	00100793          	li	a5,1
    80005d54:	00006717          	auipc	a4,0x6
    80005d58:	54f70623          	sb	a5,1356(a4) # 8000c2a0 <finishedA>
}
    80005d5c:	01813083          	ld	ra,24(sp)
    80005d60:	01013403          	ld	s0,16(sp)
    80005d64:	00813483          	ld	s1,8(sp)
    80005d68:	00013903          	ld	s2,0(sp)
    80005d6c:	02010113          	addi	sp,sp,32
    80005d70:	00008067          	ret

0000000080005d74 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80005d74:	fe010113          	addi	sp,sp,-32
    80005d78:	00113c23          	sd	ra,24(sp)
    80005d7c:	00813823          	sd	s0,16(sp)
    80005d80:	00913423          	sd	s1,8(sp)
    80005d84:	01213023          	sd	s2,0(sp)
    80005d88:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005d8c:	00000913          	li	s2,0
    80005d90:	0380006f          	j	80005dc8 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005d94:	ffffc097          	auipc	ra,0xffffc
    80005d98:	168080e7          	jalr	360(ra) # 80001efc <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005d9c:	00148493          	addi	s1,s1,1
    80005da0:	000027b7          	lui	a5,0x2
    80005da4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005da8:	0097ee63          	bltu	a5,s1,80005dc4 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005dac:	00000713          	li	a4,0
    80005db0:	000077b7          	lui	a5,0x7
    80005db4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005db8:	fce7eee3          	bltu	a5,a4,80005d94 <_Z11workerBodyBPv+0x20>
    80005dbc:	00170713          	addi	a4,a4,1
    80005dc0:	ff1ff06f          	j	80005db0 <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005dc4:	00190913          	addi	s2,s2,1
    80005dc8:	00f00793          	li	a5,15
    80005dcc:	0527e063          	bltu	a5,s2,80005e0c <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005dd0:	00004517          	auipc	a0,0x4
    80005dd4:	83050513          	addi	a0,a0,-2000 # 80009600 <CONSOLE_STATUS+0x5f0>
    80005dd8:	ffffd097          	auipc	ra,0xffffd
    80005ddc:	e0c080e7          	jalr	-500(ra) # 80002be4 <_Z11printStringPKc>
    80005de0:	00000613          	li	a2,0
    80005de4:	00a00593          	li	a1,10
    80005de8:	0009051b          	sext.w	a0,s2
    80005dec:	ffffd097          	auipc	ra,0xffffd
    80005df0:	f90080e7          	jalr	-112(ra) # 80002d7c <_Z8printIntiii>
    80005df4:	00003517          	auipc	a0,0x3
    80005df8:	5cc50513          	addi	a0,a0,1484 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80005dfc:	ffffd097          	auipc	ra,0xffffd
    80005e00:	de8080e7          	jalr	-536(ra) # 80002be4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005e04:	00000493          	li	s1,0
    80005e08:	f99ff06f          	j	80005da0 <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    80005e0c:	00003517          	auipc	a0,0x3
    80005e10:	7fc50513          	addi	a0,a0,2044 # 80009608 <CONSOLE_STATUS+0x5f8>
    80005e14:	ffffd097          	auipc	ra,0xffffd
    80005e18:	dd0080e7          	jalr	-560(ra) # 80002be4 <_Z11printStringPKc>
    finishedB = true;
    80005e1c:	00100793          	li	a5,1
    80005e20:	00006717          	auipc	a4,0x6
    80005e24:	48f700a3          	sb	a5,1153(a4) # 8000c2a1 <finishedB>
    thread_dispatch();
    80005e28:	ffffc097          	auipc	ra,0xffffc
    80005e2c:	0d4080e7          	jalr	212(ra) # 80001efc <_Z15thread_dispatchv>
}
    80005e30:	01813083          	ld	ra,24(sp)
    80005e34:	01013403          	ld	s0,16(sp)
    80005e38:	00813483          	ld	s1,8(sp)
    80005e3c:	00013903          	ld	s2,0(sp)
    80005e40:	02010113          	addi	sp,sp,32
    80005e44:	00008067          	ret

0000000080005e48 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80005e48:	fe010113          	addi	sp,sp,-32
    80005e4c:	00113c23          	sd	ra,24(sp)
    80005e50:	00813823          	sd	s0,16(sp)
    80005e54:	00913423          	sd	s1,8(sp)
    80005e58:	01213023          	sd	s2,0(sp)
    80005e5c:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80005e60:	00053903          	ld	s2,0(a0)
    int i = 6;
    80005e64:	00600493          	li	s1,6
    while (--i > 0) {
    80005e68:	fff4849b          	addiw	s1,s1,-1
    80005e6c:	04905463          	blez	s1,80005eb4 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80005e70:	00003517          	auipc	a0,0x3
    80005e74:	7a850513          	addi	a0,a0,1960 # 80009618 <CONSOLE_STATUS+0x608>
    80005e78:	ffffd097          	auipc	ra,0xffffd
    80005e7c:	d6c080e7          	jalr	-660(ra) # 80002be4 <_Z11printStringPKc>
        printInt(sleep_time);
    80005e80:	00000613          	li	a2,0
    80005e84:	00a00593          	li	a1,10
    80005e88:	0009051b          	sext.w	a0,s2
    80005e8c:	ffffd097          	auipc	ra,0xffffd
    80005e90:	ef0080e7          	jalr	-272(ra) # 80002d7c <_Z8printIntiii>
        printString(" !\n");
    80005e94:	00003517          	auipc	a0,0x3
    80005e98:	78c50513          	addi	a0,a0,1932 # 80009620 <CONSOLE_STATUS+0x610>
    80005e9c:	ffffd097          	auipc	ra,0xffffd
    80005ea0:	d48080e7          	jalr	-696(ra) # 80002be4 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80005ea4:	00090513          	mv	a0,s2
    80005ea8:	ffffc097          	auipc	ra,0xffffc
    80005eac:	1fc080e7          	jalr	508(ra) # 800020a4 <_Z10time_sleepm>
    while (--i > 0) {
    80005eb0:	fb9ff06f          	j	80005e68 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80005eb4:	00a00793          	li	a5,10
    80005eb8:	02f95933          	divu	s2,s2,a5
    80005ebc:	fff90913          	addi	s2,s2,-1
    80005ec0:	00006797          	auipc	a5,0x6
    80005ec4:	3e078793          	addi	a5,a5,992 # 8000c2a0 <finishedA>
    80005ec8:	01278933          	add	s2,a5,s2
    80005ecc:	00100793          	li	a5,1
    80005ed0:	00f90423          	sb	a5,8(s2)
}
    80005ed4:	01813083          	ld	ra,24(sp)
    80005ed8:	01013403          	ld	s0,16(sp)
    80005edc:	00813483          	ld	s1,8(sp)
    80005ee0:	00013903          	ld	s2,0(sp)
    80005ee4:	02010113          	addi	sp,sp,32
    80005ee8:	00008067          	ret

0000000080005eec <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80005eec:	fe010113          	addi	sp,sp,-32
    80005ef0:	00113c23          	sd	ra,24(sp)
    80005ef4:	00813823          	sd	s0,16(sp)
    80005ef8:	00913423          	sd	s1,8(sp)
    80005efc:	01213023          	sd	s2,0(sp)
    80005f00:	02010413          	addi	s0,sp,32
    80005f04:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005f08:	00100793          	li	a5,1
    80005f0c:	02a7f863          	bgeu	a5,a0,80005f3c <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005f10:	00a00793          	li	a5,10
    80005f14:	02f577b3          	remu	a5,a0,a5
    80005f18:	02078e63          	beqz	a5,80005f54 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005f1c:	fff48513          	addi	a0,s1,-1
    80005f20:	00000097          	auipc	ra,0x0
    80005f24:	fcc080e7          	jalr	-52(ra) # 80005eec <_Z9fibonaccim>
    80005f28:	00050913          	mv	s2,a0
    80005f2c:	ffe48513          	addi	a0,s1,-2
    80005f30:	00000097          	auipc	ra,0x0
    80005f34:	fbc080e7          	jalr	-68(ra) # 80005eec <_Z9fibonaccim>
    80005f38:	00a90533          	add	a0,s2,a0
}
    80005f3c:	01813083          	ld	ra,24(sp)
    80005f40:	01013403          	ld	s0,16(sp)
    80005f44:	00813483          	ld	s1,8(sp)
    80005f48:	00013903          	ld	s2,0(sp)
    80005f4c:	02010113          	addi	sp,sp,32
    80005f50:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005f54:	ffffc097          	auipc	ra,0xffffc
    80005f58:	fa8080e7          	jalr	-88(ra) # 80001efc <_Z15thread_dispatchv>
    80005f5c:	fc1ff06f          	j	80005f1c <_Z9fibonaccim+0x30>

0000000080005f60 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80005f60:	fe010113          	addi	sp,sp,-32
    80005f64:	00113c23          	sd	ra,24(sp)
    80005f68:	00813823          	sd	s0,16(sp)
    80005f6c:	00913423          	sd	s1,8(sp)
    80005f70:	01213023          	sd	s2,0(sp)
    80005f74:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005f78:	00000493          	li	s1,0
    80005f7c:	0400006f          	j	80005fbc <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005f80:	00003517          	auipc	a0,0x3
    80005f84:	6a850513          	addi	a0,a0,1704 # 80009628 <CONSOLE_STATUS+0x618>
    80005f88:	ffffd097          	auipc	ra,0xffffd
    80005f8c:	c5c080e7          	jalr	-932(ra) # 80002be4 <_Z11printStringPKc>
    80005f90:	00000613          	li	a2,0
    80005f94:	00a00593          	li	a1,10
    80005f98:	00048513          	mv	a0,s1
    80005f9c:	ffffd097          	auipc	ra,0xffffd
    80005fa0:	de0080e7          	jalr	-544(ra) # 80002d7c <_Z8printIntiii>
    80005fa4:	00003517          	auipc	a0,0x3
    80005fa8:	41c50513          	addi	a0,a0,1052 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80005fac:	ffffd097          	auipc	ra,0xffffd
    80005fb0:	c38080e7          	jalr	-968(ra) # 80002be4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005fb4:	0014849b          	addiw	s1,s1,1
    80005fb8:	0ff4f493          	andi	s1,s1,255
    80005fbc:	00200793          	li	a5,2
    80005fc0:	fc97f0e3          	bgeu	a5,s1,80005f80 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    80005fc4:	00003517          	auipc	a0,0x3
    80005fc8:	66c50513          	addi	a0,a0,1644 # 80009630 <CONSOLE_STATUS+0x620>
    80005fcc:	ffffd097          	auipc	ra,0xffffd
    80005fd0:	c18080e7          	jalr	-1000(ra) # 80002be4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005fd4:	00700313          	li	t1,7
    thread_dispatch();
    80005fd8:	ffffc097          	auipc	ra,0xffffc
    80005fdc:	f24080e7          	jalr	-220(ra) # 80001efc <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005fe0:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80005fe4:	00003517          	auipc	a0,0x3
    80005fe8:	65c50513          	addi	a0,a0,1628 # 80009640 <CONSOLE_STATUS+0x630>
    80005fec:	ffffd097          	auipc	ra,0xffffd
    80005ff0:	bf8080e7          	jalr	-1032(ra) # 80002be4 <_Z11printStringPKc>
    80005ff4:	00000613          	li	a2,0
    80005ff8:	00a00593          	li	a1,10
    80005ffc:	0009051b          	sext.w	a0,s2
    80006000:	ffffd097          	auipc	ra,0xffffd
    80006004:	d7c080e7          	jalr	-644(ra) # 80002d7c <_Z8printIntiii>
    80006008:	00003517          	auipc	a0,0x3
    8000600c:	3b850513          	addi	a0,a0,952 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80006010:	ffffd097          	auipc	ra,0xffffd
    80006014:	bd4080e7          	jalr	-1068(ra) # 80002be4 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80006018:	00c00513          	li	a0,12
    8000601c:	00000097          	auipc	ra,0x0
    80006020:	ed0080e7          	jalr	-304(ra) # 80005eec <_Z9fibonaccim>
    80006024:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80006028:	00003517          	auipc	a0,0x3
    8000602c:	62050513          	addi	a0,a0,1568 # 80009648 <CONSOLE_STATUS+0x638>
    80006030:	ffffd097          	auipc	ra,0xffffd
    80006034:	bb4080e7          	jalr	-1100(ra) # 80002be4 <_Z11printStringPKc>
    80006038:	00000613          	li	a2,0
    8000603c:	00a00593          	li	a1,10
    80006040:	0009051b          	sext.w	a0,s2
    80006044:	ffffd097          	auipc	ra,0xffffd
    80006048:	d38080e7          	jalr	-712(ra) # 80002d7c <_Z8printIntiii>
    8000604c:	00003517          	auipc	a0,0x3
    80006050:	37450513          	addi	a0,a0,884 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80006054:	ffffd097          	auipc	ra,0xffffd
    80006058:	b90080e7          	jalr	-1136(ra) # 80002be4 <_Z11printStringPKc>
    8000605c:	0400006f          	j	8000609c <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80006060:	00003517          	auipc	a0,0x3
    80006064:	5c850513          	addi	a0,a0,1480 # 80009628 <CONSOLE_STATUS+0x618>
    80006068:	ffffd097          	auipc	ra,0xffffd
    8000606c:	b7c080e7          	jalr	-1156(ra) # 80002be4 <_Z11printStringPKc>
    80006070:	00000613          	li	a2,0
    80006074:	00a00593          	li	a1,10
    80006078:	00048513          	mv	a0,s1
    8000607c:	ffffd097          	auipc	ra,0xffffd
    80006080:	d00080e7          	jalr	-768(ra) # 80002d7c <_Z8printIntiii>
    80006084:	00003517          	auipc	a0,0x3
    80006088:	33c50513          	addi	a0,a0,828 # 800093c0 <CONSOLE_STATUS+0x3b0>
    8000608c:	ffffd097          	auipc	ra,0xffffd
    80006090:	b58080e7          	jalr	-1192(ra) # 80002be4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80006094:	0014849b          	addiw	s1,s1,1
    80006098:	0ff4f493          	andi	s1,s1,255
    8000609c:	00500793          	li	a5,5
    800060a0:	fc97f0e3          	bgeu	a5,s1,80006060 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    800060a4:	00003517          	auipc	a0,0x3
    800060a8:	54c50513          	addi	a0,a0,1356 # 800095f0 <CONSOLE_STATUS+0x5e0>
    800060ac:	ffffd097          	auipc	ra,0xffffd
    800060b0:	b38080e7          	jalr	-1224(ra) # 80002be4 <_Z11printStringPKc>
    finishedC = true;
    800060b4:	00100793          	li	a5,1
    800060b8:	00006717          	auipc	a4,0x6
    800060bc:	1ef70c23          	sb	a5,504(a4) # 8000c2b0 <finishedC>
    thread_dispatch();
    800060c0:	ffffc097          	auipc	ra,0xffffc
    800060c4:	e3c080e7          	jalr	-452(ra) # 80001efc <_Z15thread_dispatchv>
}
    800060c8:	01813083          	ld	ra,24(sp)
    800060cc:	01013403          	ld	s0,16(sp)
    800060d0:	00813483          	ld	s1,8(sp)
    800060d4:	00013903          	ld	s2,0(sp)
    800060d8:	02010113          	addi	sp,sp,32
    800060dc:	00008067          	ret

00000000800060e0 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    800060e0:	fe010113          	addi	sp,sp,-32
    800060e4:	00113c23          	sd	ra,24(sp)
    800060e8:	00813823          	sd	s0,16(sp)
    800060ec:	00913423          	sd	s1,8(sp)
    800060f0:	01213023          	sd	s2,0(sp)
    800060f4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800060f8:	00a00493          	li	s1,10
    800060fc:	0400006f          	j	8000613c <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80006100:	00003517          	auipc	a0,0x3
    80006104:	55850513          	addi	a0,a0,1368 # 80009658 <CONSOLE_STATUS+0x648>
    80006108:	ffffd097          	auipc	ra,0xffffd
    8000610c:	adc080e7          	jalr	-1316(ra) # 80002be4 <_Z11printStringPKc>
    80006110:	00000613          	li	a2,0
    80006114:	00a00593          	li	a1,10
    80006118:	00048513          	mv	a0,s1
    8000611c:	ffffd097          	auipc	ra,0xffffd
    80006120:	c60080e7          	jalr	-928(ra) # 80002d7c <_Z8printIntiii>
    80006124:	00003517          	auipc	a0,0x3
    80006128:	29c50513          	addi	a0,a0,668 # 800093c0 <CONSOLE_STATUS+0x3b0>
    8000612c:	ffffd097          	auipc	ra,0xffffd
    80006130:	ab8080e7          	jalr	-1352(ra) # 80002be4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80006134:	0014849b          	addiw	s1,s1,1
    80006138:	0ff4f493          	andi	s1,s1,255
    8000613c:	00c00793          	li	a5,12
    80006140:	fc97f0e3          	bgeu	a5,s1,80006100 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80006144:	00003517          	auipc	a0,0x3
    80006148:	51c50513          	addi	a0,a0,1308 # 80009660 <CONSOLE_STATUS+0x650>
    8000614c:	ffffd097          	auipc	ra,0xffffd
    80006150:	a98080e7          	jalr	-1384(ra) # 80002be4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80006154:	00500313          	li	t1,5
    thread_dispatch();
    80006158:	ffffc097          	auipc	ra,0xffffc
    8000615c:	da4080e7          	jalr	-604(ra) # 80001efc <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80006160:	01000513          	li	a0,16
    80006164:	00000097          	auipc	ra,0x0
    80006168:	d88080e7          	jalr	-632(ra) # 80005eec <_Z9fibonaccim>
    8000616c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80006170:	00003517          	auipc	a0,0x3
    80006174:	50050513          	addi	a0,a0,1280 # 80009670 <CONSOLE_STATUS+0x660>
    80006178:	ffffd097          	auipc	ra,0xffffd
    8000617c:	a6c080e7          	jalr	-1428(ra) # 80002be4 <_Z11printStringPKc>
    80006180:	00000613          	li	a2,0
    80006184:	00a00593          	li	a1,10
    80006188:	0009051b          	sext.w	a0,s2
    8000618c:	ffffd097          	auipc	ra,0xffffd
    80006190:	bf0080e7          	jalr	-1040(ra) # 80002d7c <_Z8printIntiii>
    80006194:	00003517          	auipc	a0,0x3
    80006198:	22c50513          	addi	a0,a0,556 # 800093c0 <CONSOLE_STATUS+0x3b0>
    8000619c:	ffffd097          	auipc	ra,0xffffd
    800061a0:	a48080e7          	jalr	-1464(ra) # 80002be4 <_Z11printStringPKc>
    800061a4:	0400006f          	j	800061e4 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800061a8:	00003517          	auipc	a0,0x3
    800061ac:	4b050513          	addi	a0,a0,1200 # 80009658 <CONSOLE_STATUS+0x648>
    800061b0:	ffffd097          	auipc	ra,0xffffd
    800061b4:	a34080e7          	jalr	-1484(ra) # 80002be4 <_Z11printStringPKc>
    800061b8:	00000613          	li	a2,0
    800061bc:	00a00593          	li	a1,10
    800061c0:	00048513          	mv	a0,s1
    800061c4:	ffffd097          	auipc	ra,0xffffd
    800061c8:	bb8080e7          	jalr	-1096(ra) # 80002d7c <_Z8printIntiii>
    800061cc:	00003517          	auipc	a0,0x3
    800061d0:	1f450513          	addi	a0,a0,500 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800061d4:	ffffd097          	auipc	ra,0xffffd
    800061d8:	a10080e7          	jalr	-1520(ra) # 80002be4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800061dc:	0014849b          	addiw	s1,s1,1
    800061e0:	0ff4f493          	andi	s1,s1,255
    800061e4:	00f00793          	li	a5,15
    800061e8:	fc97f0e3          	bgeu	a5,s1,800061a8 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800061ec:	00003517          	auipc	a0,0x3
    800061f0:	49450513          	addi	a0,a0,1172 # 80009680 <CONSOLE_STATUS+0x670>
    800061f4:	ffffd097          	auipc	ra,0xffffd
    800061f8:	9f0080e7          	jalr	-1552(ra) # 80002be4 <_Z11printStringPKc>
    finishedD = true;
    800061fc:	00100793          	li	a5,1
    80006200:	00006717          	auipc	a4,0x6
    80006204:	0af708a3          	sb	a5,177(a4) # 8000c2b1 <finishedD>
    thread_dispatch();
    80006208:	ffffc097          	auipc	ra,0xffffc
    8000620c:	cf4080e7          	jalr	-780(ra) # 80001efc <_Z15thread_dispatchv>
}
    80006210:	01813083          	ld	ra,24(sp)
    80006214:	01013403          	ld	s0,16(sp)
    80006218:	00813483          	ld	s1,8(sp)
    8000621c:	00013903          	ld	s2,0(sp)
    80006220:	02010113          	addi	sp,sp,32
    80006224:	00008067          	ret

0000000080006228 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80006228:	fc010113          	addi	sp,sp,-64
    8000622c:	02113c23          	sd	ra,56(sp)
    80006230:	02813823          	sd	s0,48(sp)
    80006234:	02913423          	sd	s1,40(sp)
    80006238:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000623c:	00000613          	li	a2,0
    80006240:	00000597          	auipc	a1,0x0
    80006244:	a6858593          	addi	a1,a1,-1432 # 80005ca8 <_Z11workerBodyAPv>
    80006248:	fc040513          	addi	a0,s0,-64
    8000624c:	ffffc097          	auipc	ra,0xffffc
    80006250:	bfc080e7          	jalr	-1028(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80006254:	00003517          	auipc	a0,0x3
    80006258:	43c50513          	addi	a0,a0,1084 # 80009690 <CONSOLE_STATUS+0x680>
    8000625c:	ffffd097          	auipc	ra,0xffffd
    80006260:	988080e7          	jalr	-1656(ra) # 80002be4 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80006264:	00000613          	li	a2,0
    80006268:	00000597          	auipc	a1,0x0
    8000626c:	b0c58593          	addi	a1,a1,-1268 # 80005d74 <_Z11workerBodyBPv>
    80006270:	fc840513          	addi	a0,s0,-56
    80006274:	ffffc097          	auipc	ra,0xffffc
    80006278:	bd4080e7          	jalr	-1068(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    8000627c:	00003517          	auipc	a0,0x3
    80006280:	42c50513          	addi	a0,a0,1068 # 800096a8 <CONSOLE_STATUS+0x698>
    80006284:	ffffd097          	auipc	ra,0xffffd
    80006288:	960080e7          	jalr	-1696(ra) # 80002be4 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000628c:	00000613          	li	a2,0
    80006290:	00000597          	auipc	a1,0x0
    80006294:	cd058593          	addi	a1,a1,-816 # 80005f60 <_Z11workerBodyCPv>
    80006298:	fd040513          	addi	a0,s0,-48
    8000629c:	ffffc097          	auipc	ra,0xffffc
    800062a0:	bac080e7          	jalr	-1108(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    800062a4:	00003517          	auipc	a0,0x3
    800062a8:	41c50513          	addi	a0,a0,1052 # 800096c0 <CONSOLE_STATUS+0x6b0>
    800062ac:	ffffd097          	auipc	ra,0xffffd
    800062b0:	938080e7          	jalr	-1736(ra) # 80002be4 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800062b4:	00000613          	li	a2,0
    800062b8:	00000597          	auipc	a1,0x0
    800062bc:	e2858593          	addi	a1,a1,-472 # 800060e0 <_Z11workerBodyDPv>
    800062c0:	fd840513          	addi	a0,s0,-40
    800062c4:	ffffc097          	auipc	ra,0xffffc
    800062c8:	b84080e7          	jalr	-1148(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    800062cc:	00003517          	auipc	a0,0x3
    800062d0:	40c50513          	addi	a0,a0,1036 # 800096d8 <CONSOLE_STATUS+0x6c8>
    800062d4:	ffffd097          	auipc	ra,0xffffd
    800062d8:	910080e7          	jalr	-1776(ra) # 80002be4 <_Z11printStringPKc>
    800062dc:	00c0006f          	j	800062e8 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800062e0:	ffffc097          	auipc	ra,0xffffc
    800062e4:	c1c080e7          	jalr	-996(ra) # 80001efc <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800062e8:	00006797          	auipc	a5,0x6
    800062ec:	fb87c783          	lbu	a5,-72(a5) # 8000c2a0 <finishedA>
    800062f0:	fe0788e3          	beqz	a5,800062e0 <_Z18Threads_C_API_testv+0xb8>
    800062f4:	00006797          	auipc	a5,0x6
    800062f8:	fad7c783          	lbu	a5,-83(a5) # 8000c2a1 <finishedB>
    800062fc:	fe0782e3          	beqz	a5,800062e0 <_Z18Threads_C_API_testv+0xb8>
    80006300:	00006797          	auipc	a5,0x6
    80006304:	fb07c783          	lbu	a5,-80(a5) # 8000c2b0 <finishedC>
    80006308:	fc078ce3          	beqz	a5,800062e0 <_Z18Threads_C_API_testv+0xb8>
    8000630c:	00006797          	auipc	a5,0x6
    80006310:	fa57c783          	lbu	a5,-91(a5) # 8000c2b1 <finishedD>
    80006314:	fc0786e3          	beqz	a5,800062e0 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80006318:	fc040493          	addi	s1,s0,-64
    8000631c:	0080006f          	j	80006324 <_Z18Threads_C_API_testv+0xfc>
    80006320:	00848493          	addi	s1,s1,8
    80006324:	fe040793          	addi	a5,s0,-32
    80006328:	00f48c63          	beq	s1,a5,80006340 <_Z18Threads_C_API_testv+0x118>
    8000632c:	0004b503          	ld	a0,0(s1)
    80006330:	fe0508e3          	beqz	a0,80006320 <_Z18Threads_C_API_testv+0xf8>
    80006334:	ffffc097          	auipc	ra,0xffffc
    80006338:	e38080e7          	jalr	-456(ra) # 8000216c <_ZN7_threaddlEPv>
    8000633c:	fe5ff06f          	j	80006320 <_Z18Threads_C_API_testv+0xf8>
}
    80006340:	03813083          	ld	ra,56(sp)
    80006344:	03013403          	ld	s0,48(sp)
    80006348:	02813483          	ld	s1,40(sp)
    8000634c:	04010113          	addi	sp,sp,64
    80006350:	00008067          	ret

0000000080006354 <_Z12testSleepingv>:

void testSleeping() {
    80006354:	fc010113          	addi	sp,sp,-64
    80006358:	02113c23          	sd	ra,56(sp)
    8000635c:	02813823          	sd	s0,48(sp)
    80006360:	02913423          	sd	s1,40(sp)
    80006364:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80006368:	00a00793          	li	a5,10
    8000636c:	fcf43823          	sd	a5,-48(s0)
    80006370:	01400793          	li	a5,20
    80006374:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80006378:	00000493          	li	s1,0
    8000637c:	02c0006f          	j	800063a8 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80006380:	00349793          	slli	a5,s1,0x3
    80006384:	fd040613          	addi	a2,s0,-48
    80006388:	00f60633          	add	a2,a2,a5
    8000638c:	00000597          	auipc	a1,0x0
    80006390:	abc58593          	addi	a1,a1,-1348 # 80005e48 <_Z9sleepyRunPv>
    80006394:	fc040513          	addi	a0,s0,-64
    80006398:	00f50533          	add	a0,a0,a5
    8000639c:	ffffc097          	auipc	ra,0xffffc
    800063a0:	aac080e7          	jalr	-1364(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800063a4:	0014849b          	addiw	s1,s1,1
    800063a8:	00100793          	li	a5,1
    800063ac:	fc97dae3          	bge	a5,s1,80006380 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800063b0:	00006797          	auipc	a5,0x6
    800063b4:	ef87c783          	lbu	a5,-264(a5) # 8000c2a8 <finished>
    800063b8:	fe078ce3          	beqz	a5,800063b0 <_Z12testSleepingv+0x5c>
    800063bc:	00006797          	auipc	a5,0x6
    800063c0:	eed7c783          	lbu	a5,-275(a5) # 8000c2a9 <finished+0x1>
    800063c4:	fe0786e3          	beqz	a5,800063b0 <_Z12testSleepingv+0x5c>
}
    800063c8:	03813083          	ld	ra,56(sp)
    800063cc:	03013403          	ld	s0,48(sp)
    800063d0:	02813483          	ld	s1,40(sp)
    800063d4:	04010113          	addi	sp,sp,64
    800063d8:	00008067          	ret

00000000800063dc <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    800063dc:	f8010113          	addi	sp,sp,-128
    800063e0:	06113c23          	sd	ra,120(sp)
    800063e4:	06813823          	sd	s0,112(sp)
    800063e8:	06913423          	sd	s1,104(sp)
    800063ec:	07213023          	sd	s2,96(sp)
    800063f0:	05313c23          	sd	s3,88(sp)
    800063f4:	05413823          	sd	s4,80(sp)
    800063f8:	05513423          	sd	s5,72(sp)
    800063fc:	05613023          	sd	s6,64(sp)
    80006400:	03713c23          	sd	s7,56(sp)
    80006404:	03813823          	sd	s8,48(sp)
    80006408:	03913423          	sd	s9,40(sp)
    8000640c:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    80006410:	00010b93          	mv	s7,sp
        printString("Unesite broj proizvodjaca?\n");
    80006414:	00003517          	auipc	a0,0x3
    80006418:	2dc50513          	addi	a0,a0,732 # 800096f0 <CONSOLE_STATUS+0x6e0>
    8000641c:	ffffc097          	auipc	ra,0xffffc
    80006420:	7c8080e7          	jalr	1992(ra) # 80002be4 <_Z11printStringPKc>
        getString(input, 30);
    80006424:	01e00593          	li	a1,30
    80006428:	f8040493          	addi	s1,s0,-128
    8000642c:	00048513          	mv	a0,s1
    80006430:	ffffd097          	auipc	ra,0xffffd
    80006434:	830080e7          	jalr	-2000(ra) # 80002c60 <_Z9getStringPci>
        threadNum = stringToInt(input);
    80006438:	00048513          	mv	a0,s1
    8000643c:	ffffd097          	auipc	ra,0xffffd
    80006440:	8f0080e7          	jalr	-1808(ra) # 80002d2c <_Z11stringToIntPKc>
    80006444:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    80006448:	00003517          	auipc	a0,0x3
    8000644c:	2c850513          	addi	a0,a0,712 # 80009710 <CONSOLE_STATUS+0x700>
    80006450:	ffffc097          	auipc	ra,0xffffc
    80006454:	794080e7          	jalr	1940(ra) # 80002be4 <_Z11printStringPKc>
        getString(input, 30);
    80006458:	01e00593          	li	a1,30
    8000645c:	00048513          	mv	a0,s1
    80006460:	ffffd097          	auipc	ra,0xffffd
    80006464:	800080e7          	jalr	-2048(ra) # 80002c60 <_Z9getStringPci>
        n = stringToInt(input);
    80006468:	00048513          	mv	a0,s1
    8000646c:	ffffd097          	auipc	ra,0xffffd
    80006470:	8c0080e7          	jalr	-1856(ra) # 80002d2c <_Z11stringToIntPKc>
    80006474:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80006478:	00003517          	auipc	a0,0x3
    8000647c:	2b850513          	addi	a0,a0,696 # 80009730 <CONSOLE_STATUS+0x720>
    80006480:	ffffc097          	auipc	ra,0xffffc
    80006484:	764080e7          	jalr	1892(ra) # 80002be4 <_Z11printStringPKc>
    80006488:	00000613          	li	a2,0
    8000648c:	00a00593          	li	a1,10
    80006490:	00090513          	mv	a0,s2
    80006494:	ffffd097          	auipc	ra,0xffffd
    80006498:	8e8080e7          	jalr	-1816(ra) # 80002d7c <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000649c:	00003517          	auipc	a0,0x3
    800064a0:	2ac50513          	addi	a0,a0,684 # 80009748 <CONSOLE_STATUS+0x738>
    800064a4:	ffffc097          	auipc	ra,0xffffc
    800064a8:	740080e7          	jalr	1856(ra) # 80002be4 <_Z11printStringPKc>
    800064ac:	00000613          	li	a2,0
    800064b0:	00a00593          	li	a1,10
    800064b4:	00048513          	mv	a0,s1
    800064b8:	ffffd097          	auipc	ra,0xffffd
    800064bc:	8c4080e7          	jalr	-1852(ra) # 80002d7c <_Z8printIntiii>
        printString(".\n");
    800064c0:	00003517          	auipc	a0,0x3
    800064c4:	f6850513          	addi	a0,a0,-152 # 80009428 <CONSOLE_STATUS+0x418>
    800064c8:	ffffc097          	auipc	ra,0xffffc
    800064cc:	71c080e7          	jalr	1820(ra) # 80002be4 <_Z11printStringPKc>
        if(threadNum > n) {
    800064d0:	0324c663          	blt	s1,s2,800064fc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    800064d4:	03205e63          	blez	s2,80006510 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    800064d8:	03800513          	li	a0,56
    800064dc:	ffffd097          	auipc	ra,0xffffd
    800064e0:	558080e7          	jalr	1368(ra) # 80003a34 <_Znwm>
    800064e4:	00050a93          	mv	s5,a0
    800064e8:	04050063          	beqz	a0,80006528 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
    800064ec:	00048593          	mv	a1,s1
    800064f0:	fffff097          	auipc	ra,0xfffff
    800064f4:	3b0080e7          	jalr	944(ra) # 800058a0 <_ZN9BufferCPPC1Ei>
    800064f8:	0300006f          	j	80006528 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800064fc:	00003517          	auipc	a0,0x3
    80006500:	26450513          	addi	a0,a0,612 # 80009760 <CONSOLE_STATUS+0x750>
    80006504:	ffffc097          	auipc	ra,0xffffc
    80006508:	6e0080e7          	jalr	1760(ra) # 80002be4 <_Z11printStringPKc>
            return;
    8000650c:	0140006f          	j	80006520 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80006510:	00003517          	auipc	a0,0x3
    80006514:	29050513          	addi	a0,a0,656 # 800097a0 <CONSOLE_STATUS+0x790>
    80006518:	ffffc097          	auipc	ra,0xffffc
    8000651c:	6cc080e7          	jalr	1740(ra) # 80002be4 <_Z11printStringPKc>
            return;
    80006520:	000b8113          	mv	sp,s7
    80006524:	24c0006f          	j	80006770 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    80006528:	01000513          	li	a0,16
    8000652c:	ffffd097          	auipc	ra,0xffffd
    80006530:	508080e7          	jalr	1288(ra) # 80003a34 <_Znwm>
    80006534:	00050493          	mv	s1,a0
    80006538:	00050863          	beqz	a0,80006548 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000653c:	00000593          	li	a1,0
    80006540:	ffffd097          	auipc	ra,0xffffd
    80006544:	5ec080e7          	jalr	1516(ra) # 80003b2c <_ZN9SemaphoreC1Ej>
    80006548:	00006717          	auipc	a4,0x6
    8000654c:	d5870713          	addi	a4,a4,-680 # 8000c2a0 <finishedA>
    80006550:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    80006554:	00391793          	slli	a5,s2,0x3
    80006558:	00f78793          	addi	a5,a5,15
    8000655c:	ff07f793          	andi	a5,a5,-16
    80006560:	40f10133          	sub	sp,sp,a5
    80006564:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80006568:	0019069b          	addiw	a3,s2,1
    8000656c:	00169793          	slli	a5,a3,0x1
    80006570:	00d787b3          	add	a5,a5,a3
    80006574:	00379793          	slli	a5,a5,0x3
    80006578:	00f78793          	addi	a5,a5,15
    8000657c:	ff07f793          	andi	a5,a5,-16
    80006580:	40f10133          	sub	sp,sp,a5
    80006584:	00010993          	mv	s3,sp
        threadData[threadNum].id = threadNum;
    80006588:	00191793          	slli	a5,s2,0x1
    8000658c:	012787b3          	add	a5,a5,s2
    80006590:	00379793          	slli	a5,a5,0x3
    80006594:	00f987b3          	add	a5,s3,a5
    80006598:	0127a023          	sw	s2,0(a5)
        threadData[threadNum].buffer = buffer;
    8000659c:	0157b423          	sd	s5,8(a5)
        threadData[threadNum].sem = waitForAll;
    800065a0:	01873703          	ld	a4,24(a4)
    800065a4:	00e7b823          	sd	a4,16(a5)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800065a8:	01800513          	li	a0,24
    800065ac:	ffffd097          	auipc	ra,0xffffd
    800065b0:	488080e7          	jalr	1160(ra) # 80003a34 <_Znwm>
    800065b4:	00050b13          	mv	s6,a0
    800065b8:	02050663          	beqz	a0,800065e4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    800065bc:	00191493          	slli	s1,s2,0x1
    800065c0:	012484b3          	add	s1,s1,s2
    800065c4:	00349493          	slli	s1,s1,0x3
    800065c8:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    800065cc:	ffffd097          	auipc	ra,0xffffd
    800065d0:	644080e7          	jalr	1604(ra) # 80003c10 <_ZN6ThreadC1Ev>
    800065d4:	00006797          	auipc	a5,0x6
    800065d8:	96c78793          	addi	a5,a5,-1684 # 8000bf40 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800065dc:	00fb3023          	sd	a5,0(s6)
    800065e0:	009b3823          	sd	s1,16(s6)
        consumer->start();
    800065e4:	000b0513          	mv	a0,s6
    800065e8:	ffffd097          	auipc	ra,0xffffd
    800065ec:	718080e7          	jalr	1816(ra) # 80003d00 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    800065f0:	0009a023          	sw	zero,0(s3)
        threadData[0].buffer = buffer;
    800065f4:	0159b423          	sd	s5,8(s3)
        threadData[0].sem = waitForAll;
    800065f8:	00006797          	auipc	a5,0x6
    800065fc:	cc07b783          	ld	a5,-832(a5) # 8000c2b8 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006600:	00f9b823          	sd	a5,16(s3)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006604:	01800513          	li	a0,24
    80006608:	ffffd097          	auipc	ra,0xffffd
    8000660c:	42c080e7          	jalr	1068(ra) # 80003a34 <_Znwm>
    80006610:	00050493          	mv	s1,a0
    80006614:	00050e63          	beqz	a0,80006630 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80006618:	ffffd097          	auipc	ra,0xffffd
    8000661c:	5f8080e7          	jalr	1528(ra) # 80003c10 <_ZN6ThreadC1Ev>
    80006620:	00006797          	auipc	a5,0x6
    80006624:	8d078793          	addi	a5,a5,-1840 # 8000bef0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006628:	00f4b023          	sd	a5,0(s1)
    8000662c:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006630:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80006634:	00048513          	mv	a0,s1
    80006638:	ffffd097          	auipc	ra,0xffffd
    8000663c:	6c8080e7          	jalr	1736(ra) # 80003d00 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80006640:	00100493          	li	s1,1
    80006644:	0300006f          	j	80006674 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x298>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80006648:	00006797          	auipc	a5,0x6
    8000664c:	8d078793          	addi	a5,a5,-1840 # 8000bf18 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006650:	00fc3023          	sd	a5,0(s8)
    80006654:	019c3823          	sd	s9,16(s8)
            producers[i] = new Producer(&threadData[i]);
    80006658:	00349793          	slli	a5,s1,0x3
    8000665c:	00fa07b3          	add	a5,s4,a5
    80006660:	0187b023          	sd	s8,0(a5)
            producers[i]->start();
    80006664:	000c0513          	mv	a0,s8
    80006668:	ffffd097          	auipc	ra,0xffffd
    8000666c:	698080e7          	jalr	1688(ra) # 80003d00 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80006670:	0014849b          	addiw	s1,s1,1
    80006674:	0524dc63          	bge	s1,s2,800066cc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2f0>
            threadData[i].id = i;
    80006678:	00149793          	slli	a5,s1,0x1
    8000667c:	009787b3          	add	a5,a5,s1
    80006680:	00379793          	slli	a5,a5,0x3
    80006684:	00f987b3          	add	a5,s3,a5
    80006688:	0097a023          	sw	s1,0(a5)
            threadData[i].buffer = buffer;
    8000668c:	0157b423          	sd	s5,8(a5)
            threadData[i].sem = waitForAll;
    80006690:	00006717          	auipc	a4,0x6
    80006694:	c2873703          	ld	a4,-984(a4) # 8000c2b8 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006698:	00e7b823          	sd	a4,16(a5)
            producers[i] = new Producer(&threadData[i]);
    8000669c:	01800513          	li	a0,24
    800066a0:	ffffd097          	auipc	ra,0xffffd
    800066a4:	394080e7          	jalr	916(ra) # 80003a34 <_Znwm>
    800066a8:	00050c13          	mv	s8,a0
    800066ac:	fa0506e3          	beqz	a0,80006658 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    800066b0:	00149c93          	slli	s9,s1,0x1
    800066b4:	009c8cb3          	add	s9,s9,s1
    800066b8:	003c9c93          	slli	s9,s9,0x3
    800066bc:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800066c0:	ffffd097          	auipc	ra,0xffffd
    800066c4:	550080e7          	jalr	1360(ra) # 80003c10 <_ZN6ThreadC1Ev>
    800066c8:	f81ff06f          	j	80006648 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    800066cc:	ffffd097          	auipc	ra,0xffffd
    800066d0:	60c080e7          	jalr	1548(ra) # 80003cd8 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    800066d4:	00000493          	li	s1,0
    800066d8:	00994e63          	blt	s2,s1,800066f4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    800066dc:	00006517          	auipc	a0,0x6
    800066e0:	bdc53503          	ld	a0,-1060(a0) # 8000c2b8 <_ZN19ConsumerProducerCPP10waitForAllE>
    800066e4:	ffffd097          	auipc	ra,0xffffd
    800066e8:	480080e7          	jalr	1152(ra) # 80003b64 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    800066ec:	0014849b          	addiw	s1,s1,1
    800066f0:	fe9ff06f          	j	800066d8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
        delete waitForAll;
    800066f4:	00006517          	auipc	a0,0x6
    800066f8:	bc453503          	ld	a0,-1084(a0) # 8000c2b8 <_ZN19ConsumerProducerCPP10waitForAllE>
    800066fc:	00050863          	beqz	a0,8000670c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x330>
    80006700:	00053783          	ld	a5,0(a0)
    80006704:	0087b783          	ld	a5,8(a5)
    80006708:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    8000670c:	00000493          	li	s1,0
    80006710:	0080006f          	j	80006718 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x33c>
        for (int i = 0; i < threadNum; i++) {
    80006714:	0014849b          	addiw	s1,s1,1
    80006718:	0324d263          	bge	s1,s2,8000673c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
            delete producers[i];
    8000671c:	00349793          	slli	a5,s1,0x3
    80006720:	00fa07b3          	add	a5,s4,a5
    80006724:	0007b503          	ld	a0,0(a5)
    80006728:	fe0506e3          	beqz	a0,80006714 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
    8000672c:	00053783          	ld	a5,0(a0)
    80006730:	0087b783          	ld	a5,8(a5)
    80006734:	000780e7          	jalr	a5
    80006738:	fddff06f          	j	80006714 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
        delete consumer;
    8000673c:	000b0a63          	beqz	s6,80006750 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x374>
    80006740:	000b3783          	ld	a5,0(s6)
    80006744:	0087b783          	ld	a5,8(a5)
    80006748:	000b0513          	mv	a0,s6
    8000674c:	000780e7          	jalr	a5
        delete buffer;
    80006750:	000a8e63          	beqz	s5,8000676c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x390>
    80006754:	000a8513          	mv	a0,s5
    80006758:	fffff097          	auipc	ra,0xfffff
    8000675c:	450080e7          	jalr	1104(ra) # 80005ba8 <_ZN9BufferCPPD1Ev>
    80006760:	000a8513          	mv	a0,s5
    80006764:	ffffd097          	auipc	ra,0xffffd
    80006768:	320080e7          	jalr	800(ra) # 80003a84 <_ZdlPv>
    8000676c:	000b8113          	mv	sp,s7
    }
    80006770:	f8040113          	addi	sp,s0,-128
    80006774:	07813083          	ld	ra,120(sp)
    80006778:	07013403          	ld	s0,112(sp)
    8000677c:	06813483          	ld	s1,104(sp)
    80006780:	06013903          	ld	s2,96(sp)
    80006784:	05813983          	ld	s3,88(sp)
    80006788:	05013a03          	ld	s4,80(sp)
    8000678c:	04813a83          	ld	s5,72(sp)
    80006790:	04013b03          	ld	s6,64(sp)
    80006794:	03813b83          	ld	s7,56(sp)
    80006798:	03013c03          	ld	s8,48(sp)
    8000679c:	02813c83          	ld	s9,40(sp)
    800067a0:	08010113          	addi	sp,sp,128
    800067a4:	00008067          	ret
    800067a8:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    800067ac:	000a8513          	mv	a0,s5
    800067b0:	ffffd097          	auipc	ra,0xffffd
    800067b4:	2d4080e7          	jalr	724(ra) # 80003a84 <_ZdlPv>
    800067b8:	00048513          	mv	a0,s1
    800067bc:	00007097          	auipc	ra,0x7
    800067c0:	bcc080e7          	jalr	-1076(ra) # 8000d388 <_Unwind_Resume>
    800067c4:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    800067c8:	00048513          	mv	a0,s1
    800067cc:	ffffd097          	auipc	ra,0xffffd
    800067d0:	2b8080e7          	jalr	696(ra) # 80003a84 <_ZdlPv>
    800067d4:	00090513          	mv	a0,s2
    800067d8:	00007097          	auipc	ra,0x7
    800067dc:	bb0080e7          	jalr	-1104(ra) # 8000d388 <_Unwind_Resume>
    800067e0:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800067e4:	000b0513          	mv	a0,s6
    800067e8:	ffffd097          	auipc	ra,0xffffd
    800067ec:	29c080e7          	jalr	668(ra) # 80003a84 <_ZdlPv>
    800067f0:	00048513          	mv	a0,s1
    800067f4:	00007097          	auipc	ra,0x7
    800067f8:	b94080e7          	jalr	-1132(ra) # 8000d388 <_Unwind_Resume>
    800067fc:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006800:	00048513          	mv	a0,s1
    80006804:	ffffd097          	auipc	ra,0xffffd
    80006808:	280080e7          	jalr	640(ra) # 80003a84 <_ZdlPv>
    8000680c:	00090513          	mv	a0,s2
    80006810:	00007097          	auipc	ra,0x7
    80006814:	b78080e7          	jalr	-1160(ra) # 8000d388 <_Unwind_Resume>
    80006818:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000681c:	000c0513          	mv	a0,s8
    80006820:	ffffd097          	auipc	ra,0xffffd
    80006824:	264080e7          	jalr	612(ra) # 80003a84 <_ZdlPv>
    80006828:	00048513          	mv	a0,s1
    8000682c:	00007097          	auipc	ra,0x7
    80006830:	b5c080e7          	jalr	-1188(ra) # 8000d388 <_Unwind_Resume>

0000000080006834 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80006834:	fd010113          	addi	sp,sp,-48
    80006838:	02113423          	sd	ra,40(sp)
    8000683c:	02813023          	sd	s0,32(sp)
    80006840:	00913c23          	sd	s1,24(sp)
    80006844:	01213823          	sd	s2,16(sp)
    80006848:	01313423          	sd	s3,8(sp)
    8000684c:	03010413          	addi	s0,sp,48
    80006850:	00050913          	mv	s2,a0
            int i = 0;
    80006854:	00000993          	li	s3,0
    80006858:	0100006f          	j	80006868 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    8000685c:	00a00513          	li	a0,10
    80006860:	ffffd097          	auipc	ra,0xffffd
    80006864:	568080e7          	jalr	1384(ra) # 80003dc8 <_ZN7Console4putcEc>
            while (!threadEnd) {
    80006868:	00006797          	auipc	a5,0x6
    8000686c:	a447a783          	lw	a5,-1468(a5) # 8000c2ac <_ZN19ConsumerProducerCPP9threadEndE>
    80006870:	04079a63          	bnez	a5,800068c4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80006874:	01093783          	ld	a5,16(s2)
    80006878:	0087b503          	ld	a0,8(a5)
    8000687c:	fffff097          	auipc	ra,0xfffff
    80006880:	218080e7          	jalr	536(ra) # 80005a94 <_ZN9BufferCPP3getEv>
                i++;
    80006884:	0019849b          	addiw	s1,s3,1
    80006888:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    8000688c:	0ff57513          	andi	a0,a0,255
    80006890:	ffffd097          	auipc	ra,0xffffd
    80006894:	538080e7          	jalr	1336(ra) # 80003dc8 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80006898:	05000793          	li	a5,80
    8000689c:	02f4e4bb          	remw	s1,s1,a5
    800068a0:	fc0494e3          	bnez	s1,80006868 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    800068a4:	fb9ff06f          	j	8000685c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    800068a8:	01093783          	ld	a5,16(s2)
    800068ac:	0087b503          	ld	a0,8(a5)
    800068b0:	fffff097          	auipc	ra,0xfffff
    800068b4:	1e4080e7          	jalr	484(ra) # 80005a94 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    800068b8:	0ff57513          	andi	a0,a0,255
    800068bc:	ffffd097          	auipc	ra,0xffffd
    800068c0:	50c080e7          	jalr	1292(ra) # 80003dc8 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    800068c4:	01093783          	ld	a5,16(s2)
    800068c8:	0087b503          	ld	a0,8(a5)
    800068cc:	fffff097          	auipc	ra,0xfffff
    800068d0:	254080e7          	jalr	596(ra) # 80005b20 <_ZN9BufferCPP6getCntEv>
    800068d4:	fca04ae3          	bgtz	a0,800068a8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    800068d8:	01093783          	ld	a5,16(s2)
    800068dc:	0107b503          	ld	a0,16(a5)
    800068e0:	ffffd097          	auipc	ra,0xffffd
    800068e4:	2b0080e7          	jalr	688(ra) # 80003b90 <_ZN9Semaphore6signalEv>
        }
    800068e8:	02813083          	ld	ra,40(sp)
    800068ec:	02013403          	ld	s0,32(sp)
    800068f0:	01813483          	ld	s1,24(sp)
    800068f4:	01013903          	ld	s2,16(sp)
    800068f8:	00813983          	ld	s3,8(sp)
    800068fc:	03010113          	addi	sp,sp,48
    80006900:	00008067          	ret

0000000080006904 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80006904:	ff010113          	addi	sp,sp,-16
    80006908:	00113423          	sd	ra,8(sp)
    8000690c:	00813023          	sd	s0,0(sp)
    80006910:	01010413          	addi	s0,sp,16
    80006914:	00005797          	auipc	a5,0x5
    80006918:	62c78793          	addi	a5,a5,1580 # 8000bf40 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000691c:	00f53023          	sd	a5,0(a0)
    80006920:	ffffd097          	auipc	ra,0xffffd
    80006924:	0d4080e7          	jalr	212(ra) # 800039f4 <_ZN6ThreadD1Ev>
    80006928:	00813083          	ld	ra,8(sp)
    8000692c:	00013403          	ld	s0,0(sp)
    80006930:	01010113          	addi	sp,sp,16
    80006934:	00008067          	ret

0000000080006938 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80006938:	fe010113          	addi	sp,sp,-32
    8000693c:	00113c23          	sd	ra,24(sp)
    80006940:	00813823          	sd	s0,16(sp)
    80006944:	00913423          	sd	s1,8(sp)
    80006948:	02010413          	addi	s0,sp,32
    8000694c:	00050493          	mv	s1,a0
    80006950:	00005797          	auipc	a5,0x5
    80006954:	5f078793          	addi	a5,a5,1520 # 8000bf40 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006958:	00f53023          	sd	a5,0(a0)
    8000695c:	ffffd097          	auipc	ra,0xffffd
    80006960:	098080e7          	jalr	152(ra) # 800039f4 <_ZN6ThreadD1Ev>
    80006964:	00048513          	mv	a0,s1
    80006968:	ffffd097          	auipc	ra,0xffffd
    8000696c:	11c080e7          	jalr	284(ra) # 80003a84 <_ZdlPv>
    80006970:	01813083          	ld	ra,24(sp)
    80006974:	01013403          	ld	s0,16(sp)
    80006978:	00813483          	ld	s1,8(sp)
    8000697c:	02010113          	addi	sp,sp,32
    80006980:	00008067          	ret

0000000080006984 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80006984:	ff010113          	addi	sp,sp,-16
    80006988:	00113423          	sd	ra,8(sp)
    8000698c:	00813023          	sd	s0,0(sp)
    80006990:	01010413          	addi	s0,sp,16
    80006994:	00005797          	auipc	a5,0x5
    80006998:	55c78793          	addi	a5,a5,1372 # 8000bef0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000699c:	00f53023          	sd	a5,0(a0)
    800069a0:	ffffd097          	auipc	ra,0xffffd
    800069a4:	054080e7          	jalr	84(ra) # 800039f4 <_ZN6ThreadD1Ev>
    800069a8:	00813083          	ld	ra,8(sp)
    800069ac:	00013403          	ld	s0,0(sp)
    800069b0:	01010113          	addi	sp,sp,16
    800069b4:	00008067          	ret

00000000800069b8 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    800069b8:	fe010113          	addi	sp,sp,-32
    800069bc:	00113c23          	sd	ra,24(sp)
    800069c0:	00813823          	sd	s0,16(sp)
    800069c4:	00913423          	sd	s1,8(sp)
    800069c8:	02010413          	addi	s0,sp,32
    800069cc:	00050493          	mv	s1,a0
    800069d0:	00005797          	auipc	a5,0x5
    800069d4:	52078793          	addi	a5,a5,1312 # 8000bef0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800069d8:	00f53023          	sd	a5,0(a0)
    800069dc:	ffffd097          	auipc	ra,0xffffd
    800069e0:	018080e7          	jalr	24(ra) # 800039f4 <_ZN6ThreadD1Ev>
    800069e4:	00048513          	mv	a0,s1
    800069e8:	ffffd097          	auipc	ra,0xffffd
    800069ec:	09c080e7          	jalr	156(ra) # 80003a84 <_ZdlPv>
    800069f0:	01813083          	ld	ra,24(sp)
    800069f4:	01013403          	ld	s0,16(sp)
    800069f8:	00813483          	ld	s1,8(sp)
    800069fc:	02010113          	addi	sp,sp,32
    80006a00:	00008067          	ret

0000000080006a04 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80006a04:	ff010113          	addi	sp,sp,-16
    80006a08:	00113423          	sd	ra,8(sp)
    80006a0c:	00813023          	sd	s0,0(sp)
    80006a10:	01010413          	addi	s0,sp,16
    80006a14:	00005797          	auipc	a5,0x5
    80006a18:	50478793          	addi	a5,a5,1284 # 8000bf18 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006a1c:	00f53023          	sd	a5,0(a0)
    80006a20:	ffffd097          	auipc	ra,0xffffd
    80006a24:	fd4080e7          	jalr	-44(ra) # 800039f4 <_ZN6ThreadD1Ev>
    80006a28:	00813083          	ld	ra,8(sp)
    80006a2c:	00013403          	ld	s0,0(sp)
    80006a30:	01010113          	addi	sp,sp,16
    80006a34:	00008067          	ret

0000000080006a38 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80006a38:	fe010113          	addi	sp,sp,-32
    80006a3c:	00113c23          	sd	ra,24(sp)
    80006a40:	00813823          	sd	s0,16(sp)
    80006a44:	00913423          	sd	s1,8(sp)
    80006a48:	02010413          	addi	s0,sp,32
    80006a4c:	00050493          	mv	s1,a0
    80006a50:	00005797          	auipc	a5,0x5
    80006a54:	4c878793          	addi	a5,a5,1224 # 8000bf18 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006a58:	00f53023          	sd	a5,0(a0)
    80006a5c:	ffffd097          	auipc	ra,0xffffd
    80006a60:	f98080e7          	jalr	-104(ra) # 800039f4 <_ZN6ThreadD1Ev>
    80006a64:	00048513          	mv	a0,s1
    80006a68:	ffffd097          	auipc	ra,0xffffd
    80006a6c:	01c080e7          	jalr	28(ra) # 80003a84 <_ZdlPv>
    80006a70:	01813083          	ld	ra,24(sp)
    80006a74:	01013403          	ld	s0,16(sp)
    80006a78:	00813483          	ld	s1,8(sp)
    80006a7c:	02010113          	addi	sp,sp,32
    80006a80:	00008067          	ret

0000000080006a84 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80006a84:	fe010113          	addi	sp,sp,-32
    80006a88:	00113c23          	sd	ra,24(sp)
    80006a8c:	00813823          	sd	s0,16(sp)
    80006a90:	00913423          	sd	s1,8(sp)
    80006a94:	02010413          	addi	s0,sp,32
    80006a98:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80006a9c:	ffffb097          	auipc	ra,0xffffb
    80006aa0:	634080e7          	jalr	1588(ra) # 800020d0 <_Z4getcv>
    80006aa4:	0005059b          	sext.w	a1,a0
    80006aa8:	01b00793          	li	a5,27
    80006aac:	00f58c63          	beq	a1,a5,80006ac4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80006ab0:	0104b783          	ld	a5,16(s1)
    80006ab4:	0087b503          	ld	a0,8(a5)
    80006ab8:	fffff097          	auipc	ra,0xfffff
    80006abc:	f4c080e7          	jalr	-180(ra) # 80005a04 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80006ac0:	fddff06f          	j	80006a9c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80006ac4:	00100793          	li	a5,1
    80006ac8:	00005717          	auipc	a4,0x5
    80006acc:	7ef72223          	sw	a5,2020(a4) # 8000c2ac <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80006ad0:	0104b783          	ld	a5,16(s1)
    80006ad4:	02100593          	li	a1,33
    80006ad8:	0087b503          	ld	a0,8(a5)
    80006adc:	fffff097          	auipc	ra,0xfffff
    80006ae0:	f28080e7          	jalr	-216(ra) # 80005a04 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80006ae4:	0104b783          	ld	a5,16(s1)
    80006ae8:	0107b503          	ld	a0,16(a5)
    80006aec:	ffffd097          	auipc	ra,0xffffd
    80006af0:	0a4080e7          	jalr	164(ra) # 80003b90 <_ZN9Semaphore6signalEv>
        }
    80006af4:	01813083          	ld	ra,24(sp)
    80006af8:	01013403          	ld	s0,16(sp)
    80006afc:	00813483          	ld	s1,8(sp)
    80006b00:	02010113          	addi	sp,sp,32
    80006b04:	00008067          	ret

0000000080006b08 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006b08:	fe010113          	addi	sp,sp,-32
    80006b0c:	00113c23          	sd	ra,24(sp)
    80006b10:	00813823          	sd	s0,16(sp)
    80006b14:	00913423          	sd	s1,8(sp)
    80006b18:	01213023          	sd	s2,0(sp)
    80006b1c:	02010413          	addi	s0,sp,32
    80006b20:	00050493          	mv	s1,a0
            int i = 0;
    80006b24:	00000913          	li	s2,0
            while (!threadEnd) {
    80006b28:	00005797          	auipc	a5,0x5
    80006b2c:	7847a783          	lw	a5,1924(a5) # 8000c2ac <_ZN19ConsumerProducerCPP9threadEndE>
    80006b30:	04079263          	bnez	a5,80006b74 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80006b34:	0104b783          	ld	a5,16(s1)
    80006b38:	0007a583          	lw	a1,0(a5)
    80006b3c:	0305859b          	addiw	a1,a1,48
    80006b40:	0087b503          	ld	a0,8(a5)
    80006b44:	fffff097          	auipc	ra,0xfffff
    80006b48:	ec0080e7          	jalr	-320(ra) # 80005a04 <_ZN9BufferCPP3putEi>
                i++;
    80006b4c:	0019071b          	addiw	a4,s2,1
    80006b50:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80006b54:	0104b783          	ld	a5,16(s1)
    80006b58:	0007a783          	lw	a5,0(a5)
    80006b5c:	00e787bb          	addw	a5,a5,a4
    80006b60:	00500513          	li	a0,5
    80006b64:	02a7e53b          	remw	a0,a5,a0
    80006b68:	ffffd097          	auipc	ra,0xffffd
    80006b6c:	108080e7          	jalr	264(ra) # 80003c70 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80006b70:	fb9ff06f          	j	80006b28 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80006b74:	0104b783          	ld	a5,16(s1)
    80006b78:	0107b503          	ld	a0,16(a5)
    80006b7c:	ffffd097          	auipc	ra,0xffffd
    80006b80:	014080e7          	jalr	20(ra) # 80003b90 <_ZN9Semaphore6signalEv>
        }
    80006b84:	01813083          	ld	ra,24(sp)
    80006b88:	01013403          	ld	s0,16(sp)
    80006b8c:	00813483          	ld	s1,8(sp)
    80006b90:	00013903          	ld	s2,0(sp)
    80006b94:	02010113          	addi	sp,sp,32
    80006b98:	00008067          	ret

0000000080006b9c <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006b9c:	fe010113          	addi	sp,sp,-32
    80006ba0:	00113c23          	sd	ra,24(sp)
    80006ba4:	00813823          	sd	s0,16(sp)
    80006ba8:	00913423          	sd	s1,8(sp)
    80006bac:	01213023          	sd	s2,0(sp)
    80006bb0:	02010413          	addi	s0,sp,32
    80006bb4:	00050493          	mv	s1,a0
    80006bb8:	00058913          	mv	s2,a1
    80006bbc:	0015879b          	addiw	a5,a1,1
    80006bc0:	0007851b          	sext.w	a0,a5
    80006bc4:	00f4a023          	sw	a5,0(s1)
    80006bc8:	0004a823          	sw	zero,16(s1)
    80006bcc:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006bd0:	00251513          	slli	a0,a0,0x2
    80006bd4:	ffffb097          	auipc	ra,0xffffb
    80006bd8:	218080e7          	jalr	536(ra) # 80001dec <_Z9mem_allocm>
    80006bdc:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006be0:	00000593          	li	a1,0
    80006be4:	02048513          	addi	a0,s1,32
    80006be8:	ffffb097          	auipc	ra,0xffffb
    80006bec:	400080e7          	jalr	1024(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80006bf0:	00090593          	mv	a1,s2
    80006bf4:	01848513          	addi	a0,s1,24
    80006bf8:	ffffb097          	auipc	ra,0xffffb
    80006bfc:	3f0080e7          	jalr	1008(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80006c00:	00100593          	li	a1,1
    80006c04:	02848513          	addi	a0,s1,40
    80006c08:	ffffb097          	auipc	ra,0xffffb
    80006c0c:	3e0080e7          	jalr	992(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80006c10:	00100593          	li	a1,1
    80006c14:	03048513          	addi	a0,s1,48
    80006c18:	ffffb097          	auipc	ra,0xffffb
    80006c1c:	3d0080e7          	jalr	976(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
}
    80006c20:	01813083          	ld	ra,24(sp)
    80006c24:	01013403          	ld	s0,16(sp)
    80006c28:	00813483          	ld	s1,8(sp)
    80006c2c:	00013903          	ld	s2,0(sp)
    80006c30:	02010113          	addi	sp,sp,32
    80006c34:	00008067          	ret

0000000080006c38 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80006c38:	fe010113          	addi	sp,sp,-32
    80006c3c:	00113c23          	sd	ra,24(sp)
    80006c40:	00813823          	sd	s0,16(sp)
    80006c44:	00913423          	sd	s1,8(sp)
    80006c48:	01213023          	sd	s2,0(sp)
    80006c4c:	02010413          	addi	s0,sp,32
    80006c50:	00050493          	mv	s1,a0
    80006c54:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80006c58:	01853503          	ld	a0,24(a0)
    80006c5c:	ffffb097          	auipc	ra,0xffffb
    80006c60:	3f0080e7          	jalr	1008(ra) # 8000204c <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80006c64:	0304b503          	ld	a0,48(s1)
    80006c68:	ffffb097          	auipc	ra,0xffffb
    80006c6c:	3e4080e7          	jalr	996(ra) # 8000204c <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80006c70:	0084b783          	ld	a5,8(s1)
    80006c74:	0144a703          	lw	a4,20(s1)
    80006c78:	00271713          	slli	a4,a4,0x2
    80006c7c:	00e787b3          	add	a5,a5,a4
    80006c80:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006c84:	0144a783          	lw	a5,20(s1)
    80006c88:	0017879b          	addiw	a5,a5,1
    80006c8c:	0004a703          	lw	a4,0(s1)
    80006c90:	02e7e7bb          	remw	a5,a5,a4
    80006c94:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006c98:	0304b503          	ld	a0,48(s1)
    80006c9c:	ffffb097          	auipc	ra,0xffffb
    80006ca0:	3dc080e7          	jalr	988(ra) # 80002078 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80006ca4:	0204b503          	ld	a0,32(s1)
    80006ca8:	ffffb097          	auipc	ra,0xffffb
    80006cac:	3d0080e7          	jalr	976(ra) # 80002078 <_Z10sem_signalP10_semaphore>

}
    80006cb0:	01813083          	ld	ra,24(sp)
    80006cb4:	01013403          	ld	s0,16(sp)
    80006cb8:	00813483          	ld	s1,8(sp)
    80006cbc:	00013903          	ld	s2,0(sp)
    80006cc0:	02010113          	addi	sp,sp,32
    80006cc4:	00008067          	ret

0000000080006cc8 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006cc8:	fe010113          	addi	sp,sp,-32
    80006ccc:	00113c23          	sd	ra,24(sp)
    80006cd0:	00813823          	sd	s0,16(sp)
    80006cd4:	00913423          	sd	s1,8(sp)
    80006cd8:	01213023          	sd	s2,0(sp)
    80006cdc:	02010413          	addi	s0,sp,32
    80006ce0:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006ce4:	02053503          	ld	a0,32(a0)
    80006ce8:	ffffb097          	auipc	ra,0xffffb
    80006cec:	364080e7          	jalr	868(ra) # 8000204c <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80006cf0:	0284b503          	ld	a0,40(s1)
    80006cf4:	ffffb097          	auipc	ra,0xffffb
    80006cf8:	358080e7          	jalr	856(ra) # 8000204c <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80006cfc:	0084b703          	ld	a4,8(s1)
    80006d00:	0104a783          	lw	a5,16(s1)
    80006d04:	00279693          	slli	a3,a5,0x2
    80006d08:	00d70733          	add	a4,a4,a3
    80006d0c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006d10:	0017879b          	addiw	a5,a5,1
    80006d14:	0004a703          	lw	a4,0(s1)
    80006d18:	02e7e7bb          	remw	a5,a5,a4
    80006d1c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006d20:	0284b503          	ld	a0,40(s1)
    80006d24:	ffffb097          	auipc	ra,0xffffb
    80006d28:	354080e7          	jalr	852(ra) # 80002078 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80006d2c:	0184b503          	ld	a0,24(s1)
    80006d30:	ffffb097          	auipc	ra,0xffffb
    80006d34:	348080e7          	jalr	840(ra) # 80002078 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006d38:	00090513          	mv	a0,s2
    80006d3c:	01813083          	ld	ra,24(sp)
    80006d40:	01013403          	ld	s0,16(sp)
    80006d44:	00813483          	ld	s1,8(sp)
    80006d48:	00013903          	ld	s2,0(sp)
    80006d4c:	02010113          	addi	sp,sp,32
    80006d50:	00008067          	ret

0000000080006d54 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80006d54:	fe010113          	addi	sp,sp,-32
    80006d58:	00113c23          	sd	ra,24(sp)
    80006d5c:	00813823          	sd	s0,16(sp)
    80006d60:	00913423          	sd	s1,8(sp)
    80006d64:	01213023          	sd	s2,0(sp)
    80006d68:	02010413          	addi	s0,sp,32
    80006d6c:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80006d70:	02853503          	ld	a0,40(a0)
    80006d74:	ffffb097          	auipc	ra,0xffffb
    80006d78:	2d8080e7          	jalr	728(ra) # 8000204c <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80006d7c:	0304b503          	ld	a0,48(s1)
    80006d80:	ffffb097          	auipc	ra,0xffffb
    80006d84:	2cc080e7          	jalr	716(ra) # 8000204c <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80006d88:	0144a783          	lw	a5,20(s1)
    80006d8c:	0104a903          	lw	s2,16(s1)
    80006d90:	0327ce63          	blt	a5,s2,80006dcc <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006d94:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006d98:	0304b503          	ld	a0,48(s1)
    80006d9c:	ffffb097          	auipc	ra,0xffffb
    80006da0:	2dc080e7          	jalr	732(ra) # 80002078 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80006da4:	0284b503          	ld	a0,40(s1)
    80006da8:	ffffb097          	auipc	ra,0xffffb
    80006dac:	2d0080e7          	jalr	720(ra) # 80002078 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006db0:	00090513          	mv	a0,s2
    80006db4:	01813083          	ld	ra,24(sp)
    80006db8:	01013403          	ld	s0,16(sp)
    80006dbc:	00813483          	ld	s1,8(sp)
    80006dc0:	00013903          	ld	s2,0(sp)
    80006dc4:	02010113          	addi	sp,sp,32
    80006dc8:	00008067          	ret
        ret = cap - head + tail;
    80006dcc:	0004a703          	lw	a4,0(s1)
    80006dd0:	4127093b          	subw	s2,a4,s2
    80006dd4:	00f9093b          	addw	s2,s2,a5
    80006dd8:	fc1ff06f          	j	80006d98 <_ZN6Buffer6getCntEv+0x44>

0000000080006ddc <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006ddc:	fe010113          	addi	sp,sp,-32
    80006de0:	00113c23          	sd	ra,24(sp)
    80006de4:	00813823          	sd	s0,16(sp)
    80006de8:	00913423          	sd	s1,8(sp)
    80006dec:	02010413          	addi	s0,sp,32
    80006df0:	00050493          	mv	s1,a0
    putc('\n');
    80006df4:	00a00513          	li	a0,10
    80006df8:	ffffb097          	auipc	ra,0xffffb
    80006dfc:	300080e7          	jalr	768(ra) # 800020f8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006e00:	00002517          	auipc	a0,0x2
    80006e04:	7d050513          	addi	a0,a0,2000 # 800095d0 <CONSOLE_STATUS+0x5c0>
    80006e08:	ffffc097          	auipc	ra,0xffffc
    80006e0c:	ddc080e7          	jalr	-548(ra) # 80002be4 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006e10:	00048513          	mv	a0,s1
    80006e14:	00000097          	auipc	ra,0x0
    80006e18:	f40080e7          	jalr	-192(ra) # 80006d54 <_ZN6Buffer6getCntEv>
    80006e1c:	02a05c63          	blez	a0,80006e54 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006e20:	0084b783          	ld	a5,8(s1)
    80006e24:	0104a703          	lw	a4,16(s1)
    80006e28:	00271713          	slli	a4,a4,0x2
    80006e2c:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006e30:	0007c503          	lbu	a0,0(a5)
    80006e34:	ffffb097          	auipc	ra,0xffffb
    80006e38:	2c4080e7          	jalr	708(ra) # 800020f8 <_Z4putcc>
        head = (head + 1) % cap;
    80006e3c:	0104a783          	lw	a5,16(s1)
    80006e40:	0017879b          	addiw	a5,a5,1
    80006e44:	0004a703          	lw	a4,0(s1)
    80006e48:	02e7e7bb          	remw	a5,a5,a4
    80006e4c:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80006e50:	fc1ff06f          	j	80006e10 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80006e54:	02100513          	li	a0,33
    80006e58:	ffffb097          	auipc	ra,0xffffb
    80006e5c:	2a0080e7          	jalr	672(ra) # 800020f8 <_Z4putcc>
    putc('\n');
    80006e60:	00a00513          	li	a0,10
    80006e64:	ffffb097          	auipc	ra,0xffffb
    80006e68:	294080e7          	jalr	660(ra) # 800020f8 <_Z4putcc>
    mem_free(buffer);
    80006e6c:	0084b503          	ld	a0,8(s1)
    80006e70:	ffffb097          	auipc	ra,0xffffb
    80006e74:	fac080e7          	jalr	-84(ra) # 80001e1c <_Z8mem_freePv>
    sem_close(itemAvailable);
    80006e78:	0204b503          	ld	a0,32(s1)
    80006e7c:	ffffb097          	auipc	ra,0xffffb
    80006e80:	1a4080e7          	jalr	420(ra) # 80002020 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80006e84:	0184b503          	ld	a0,24(s1)
    80006e88:	ffffb097          	auipc	ra,0xffffb
    80006e8c:	198080e7          	jalr	408(ra) # 80002020 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80006e90:	0304b503          	ld	a0,48(s1)
    80006e94:	ffffb097          	auipc	ra,0xffffb
    80006e98:	18c080e7          	jalr	396(ra) # 80002020 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006e9c:	0284b503          	ld	a0,40(s1)
    80006ea0:	ffffb097          	auipc	ra,0xffffb
    80006ea4:	180080e7          	jalr	384(ra) # 80002020 <_Z9sem_closeP10_semaphore>
}
    80006ea8:	01813083          	ld	ra,24(sp)
    80006eac:	01013403          	ld	s0,16(sp)
    80006eb0:	00813483          	ld	s1,8(sp)
    80006eb4:	02010113          	addi	sp,sp,32
    80006eb8:	00008067          	ret

0000000080006ebc <start>:
    80006ebc:	ff010113          	addi	sp,sp,-16
    80006ec0:	00813423          	sd	s0,8(sp)
    80006ec4:	01010413          	addi	s0,sp,16
    80006ec8:	300027f3          	csrr	a5,mstatus
    80006ecc:	ffffe737          	lui	a4,0xffffe
    80006ed0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff12df>
    80006ed4:	00e7f7b3          	and	a5,a5,a4
    80006ed8:	00001737          	lui	a4,0x1
    80006edc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006ee0:	00e7e7b3          	or	a5,a5,a4
    80006ee4:	30079073          	csrw	mstatus,a5
    80006ee8:	00000797          	auipc	a5,0x0
    80006eec:	16078793          	addi	a5,a5,352 # 80007048 <system_main>
    80006ef0:	34179073          	csrw	mepc,a5
    80006ef4:	00000793          	li	a5,0
    80006ef8:	18079073          	csrw	satp,a5
    80006efc:	000107b7          	lui	a5,0x10
    80006f00:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006f04:	30279073          	csrw	medeleg,a5
    80006f08:	30379073          	csrw	mideleg,a5
    80006f0c:	104027f3          	csrr	a5,sie
    80006f10:	2227e793          	ori	a5,a5,546
    80006f14:	10479073          	csrw	sie,a5
    80006f18:	fff00793          	li	a5,-1
    80006f1c:	00a7d793          	srli	a5,a5,0xa
    80006f20:	3b079073          	csrw	pmpaddr0,a5
    80006f24:	00f00793          	li	a5,15
    80006f28:	3a079073          	csrw	pmpcfg0,a5
    80006f2c:	f14027f3          	csrr	a5,mhartid
    80006f30:	0200c737          	lui	a4,0x200c
    80006f34:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006f38:	0007869b          	sext.w	a3,a5
    80006f3c:	00269713          	slli	a4,a3,0x2
    80006f40:	000f4637          	lui	a2,0xf4
    80006f44:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006f48:	00d70733          	add	a4,a4,a3
    80006f4c:	0037979b          	slliw	a5,a5,0x3
    80006f50:	020046b7          	lui	a3,0x2004
    80006f54:	00d787b3          	add	a5,a5,a3
    80006f58:	00c585b3          	add	a1,a1,a2
    80006f5c:	00371693          	slli	a3,a4,0x3
    80006f60:	00005717          	auipc	a4,0x5
    80006f64:	36070713          	addi	a4,a4,864 # 8000c2c0 <timer_scratch>
    80006f68:	00b7b023          	sd	a1,0(a5)
    80006f6c:	00d70733          	add	a4,a4,a3
    80006f70:	00f73c23          	sd	a5,24(a4)
    80006f74:	02c73023          	sd	a2,32(a4)
    80006f78:	34071073          	csrw	mscratch,a4
    80006f7c:	00000797          	auipc	a5,0x0
    80006f80:	6e478793          	addi	a5,a5,1764 # 80007660 <timervec>
    80006f84:	30579073          	csrw	mtvec,a5
    80006f88:	300027f3          	csrr	a5,mstatus
    80006f8c:	0087e793          	ori	a5,a5,8
    80006f90:	30079073          	csrw	mstatus,a5
    80006f94:	304027f3          	csrr	a5,mie
    80006f98:	0807e793          	ori	a5,a5,128
    80006f9c:	30479073          	csrw	mie,a5
    80006fa0:	f14027f3          	csrr	a5,mhartid
    80006fa4:	0007879b          	sext.w	a5,a5
    80006fa8:	00078213          	mv	tp,a5
    80006fac:	30200073          	mret
    80006fb0:	00813403          	ld	s0,8(sp)
    80006fb4:	01010113          	addi	sp,sp,16
    80006fb8:	00008067          	ret

0000000080006fbc <timerinit>:
    80006fbc:	ff010113          	addi	sp,sp,-16
    80006fc0:	00813423          	sd	s0,8(sp)
    80006fc4:	01010413          	addi	s0,sp,16
    80006fc8:	f14027f3          	csrr	a5,mhartid
    80006fcc:	0200c737          	lui	a4,0x200c
    80006fd0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006fd4:	0007869b          	sext.w	a3,a5
    80006fd8:	00269713          	slli	a4,a3,0x2
    80006fdc:	000f4637          	lui	a2,0xf4
    80006fe0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006fe4:	00d70733          	add	a4,a4,a3
    80006fe8:	0037979b          	slliw	a5,a5,0x3
    80006fec:	020046b7          	lui	a3,0x2004
    80006ff0:	00d787b3          	add	a5,a5,a3
    80006ff4:	00c585b3          	add	a1,a1,a2
    80006ff8:	00371693          	slli	a3,a4,0x3
    80006ffc:	00005717          	auipc	a4,0x5
    80007000:	2c470713          	addi	a4,a4,708 # 8000c2c0 <timer_scratch>
    80007004:	00b7b023          	sd	a1,0(a5)
    80007008:	00d70733          	add	a4,a4,a3
    8000700c:	00f73c23          	sd	a5,24(a4)
    80007010:	02c73023          	sd	a2,32(a4)
    80007014:	34071073          	csrw	mscratch,a4
    80007018:	00000797          	auipc	a5,0x0
    8000701c:	64878793          	addi	a5,a5,1608 # 80007660 <timervec>
    80007020:	30579073          	csrw	mtvec,a5
    80007024:	300027f3          	csrr	a5,mstatus
    80007028:	0087e793          	ori	a5,a5,8
    8000702c:	30079073          	csrw	mstatus,a5
    80007030:	304027f3          	csrr	a5,mie
    80007034:	0807e793          	ori	a5,a5,128
    80007038:	30479073          	csrw	mie,a5
    8000703c:	00813403          	ld	s0,8(sp)
    80007040:	01010113          	addi	sp,sp,16
    80007044:	00008067          	ret

0000000080007048 <system_main>:
    80007048:	fe010113          	addi	sp,sp,-32
    8000704c:	00813823          	sd	s0,16(sp)
    80007050:	00913423          	sd	s1,8(sp)
    80007054:	00113c23          	sd	ra,24(sp)
    80007058:	02010413          	addi	s0,sp,32
    8000705c:	00000097          	auipc	ra,0x0
    80007060:	0c4080e7          	jalr	196(ra) # 80007120 <cpuid>
    80007064:	00005497          	auipc	s1,0x5
    80007068:	fbc48493          	addi	s1,s1,-68 # 8000c020 <started>
    8000706c:	02050263          	beqz	a0,80007090 <system_main+0x48>
    80007070:	0004a783          	lw	a5,0(s1)
    80007074:	0007879b          	sext.w	a5,a5
    80007078:	fe078ce3          	beqz	a5,80007070 <system_main+0x28>
    8000707c:	0ff0000f          	fence
    80007080:	00002517          	auipc	a0,0x2
    80007084:	78050513          	addi	a0,a0,1920 # 80009800 <CONSOLE_STATUS+0x7f0>
    80007088:	00001097          	auipc	ra,0x1
    8000708c:	a74080e7          	jalr	-1420(ra) # 80007afc <panic>
    80007090:	00001097          	auipc	ra,0x1
    80007094:	9c8080e7          	jalr	-1592(ra) # 80007a58 <consoleinit>
    80007098:	00001097          	auipc	ra,0x1
    8000709c:	154080e7          	jalr	340(ra) # 800081ec <printfinit>
    800070a0:	00002517          	auipc	a0,0x2
    800070a4:	32050513          	addi	a0,a0,800 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800070a8:	00001097          	auipc	ra,0x1
    800070ac:	ab0080e7          	jalr	-1360(ra) # 80007b58 <__printf>
    800070b0:	00002517          	auipc	a0,0x2
    800070b4:	72050513          	addi	a0,a0,1824 # 800097d0 <CONSOLE_STATUS+0x7c0>
    800070b8:	00001097          	auipc	ra,0x1
    800070bc:	aa0080e7          	jalr	-1376(ra) # 80007b58 <__printf>
    800070c0:	00002517          	auipc	a0,0x2
    800070c4:	30050513          	addi	a0,a0,768 # 800093c0 <CONSOLE_STATUS+0x3b0>
    800070c8:	00001097          	auipc	ra,0x1
    800070cc:	a90080e7          	jalr	-1392(ra) # 80007b58 <__printf>
    800070d0:	00001097          	auipc	ra,0x1
    800070d4:	4a8080e7          	jalr	1192(ra) # 80008578 <kinit>
    800070d8:	00000097          	auipc	ra,0x0
    800070dc:	148080e7          	jalr	328(ra) # 80007220 <trapinit>
    800070e0:	00000097          	auipc	ra,0x0
    800070e4:	16c080e7          	jalr	364(ra) # 8000724c <trapinithart>
    800070e8:	00000097          	auipc	ra,0x0
    800070ec:	5b8080e7          	jalr	1464(ra) # 800076a0 <plicinit>
    800070f0:	00000097          	auipc	ra,0x0
    800070f4:	5d8080e7          	jalr	1496(ra) # 800076c8 <plicinithart>
    800070f8:	00000097          	auipc	ra,0x0
    800070fc:	078080e7          	jalr	120(ra) # 80007170 <userinit>
    80007100:	0ff0000f          	fence
    80007104:	00100793          	li	a5,1
    80007108:	00002517          	auipc	a0,0x2
    8000710c:	6e050513          	addi	a0,a0,1760 # 800097e8 <CONSOLE_STATUS+0x7d8>
    80007110:	00f4a023          	sw	a5,0(s1)
    80007114:	00001097          	auipc	ra,0x1
    80007118:	a44080e7          	jalr	-1468(ra) # 80007b58 <__printf>
    8000711c:	0000006f          	j	8000711c <system_main+0xd4>

0000000080007120 <cpuid>:
    80007120:	ff010113          	addi	sp,sp,-16
    80007124:	00813423          	sd	s0,8(sp)
    80007128:	01010413          	addi	s0,sp,16
    8000712c:	00020513          	mv	a0,tp
    80007130:	00813403          	ld	s0,8(sp)
    80007134:	0005051b          	sext.w	a0,a0
    80007138:	01010113          	addi	sp,sp,16
    8000713c:	00008067          	ret

0000000080007140 <mycpu>:
    80007140:	ff010113          	addi	sp,sp,-16
    80007144:	00813423          	sd	s0,8(sp)
    80007148:	01010413          	addi	s0,sp,16
    8000714c:	00020793          	mv	a5,tp
    80007150:	00813403          	ld	s0,8(sp)
    80007154:	0007879b          	sext.w	a5,a5
    80007158:	00779793          	slli	a5,a5,0x7
    8000715c:	00006517          	auipc	a0,0x6
    80007160:	19450513          	addi	a0,a0,404 # 8000d2f0 <cpus>
    80007164:	00f50533          	add	a0,a0,a5
    80007168:	01010113          	addi	sp,sp,16
    8000716c:	00008067          	ret

0000000080007170 <userinit>:
    80007170:	ff010113          	addi	sp,sp,-16
    80007174:	00813423          	sd	s0,8(sp)
    80007178:	01010413          	addi	s0,sp,16
    8000717c:	00813403          	ld	s0,8(sp)
    80007180:	01010113          	addi	sp,sp,16
    80007184:	ffffc317          	auipc	t1,0xffffc
    80007188:	fdc30067          	jr	-36(t1) # 80003160 <main>

000000008000718c <either_copyout>:
    8000718c:	ff010113          	addi	sp,sp,-16
    80007190:	00813023          	sd	s0,0(sp)
    80007194:	00113423          	sd	ra,8(sp)
    80007198:	01010413          	addi	s0,sp,16
    8000719c:	02051663          	bnez	a0,800071c8 <either_copyout+0x3c>
    800071a0:	00058513          	mv	a0,a1
    800071a4:	00060593          	mv	a1,a2
    800071a8:	0006861b          	sext.w	a2,a3
    800071ac:	00002097          	auipc	ra,0x2
    800071b0:	c58080e7          	jalr	-936(ra) # 80008e04 <__memmove>
    800071b4:	00813083          	ld	ra,8(sp)
    800071b8:	00013403          	ld	s0,0(sp)
    800071bc:	00000513          	li	a0,0
    800071c0:	01010113          	addi	sp,sp,16
    800071c4:	00008067          	ret
    800071c8:	00002517          	auipc	a0,0x2
    800071cc:	66050513          	addi	a0,a0,1632 # 80009828 <CONSOLE_STATUS+0x818>
    800071d0:	00001097          	auipc	ra,0x1
    800071d4:	92c080e7          	jalr	-1748(ra) # 80007afc <panic>

00000000800071d8 <either_copyin>:
    800071d8:	ff010113          	addi	sp,sp,-16
    800071dc:	00813023          	sd	s0,0(sp)
    800071e0:	00113423          	sd	ra,8(sp)
    800071e4:	01010413          	addi	s0,sp,16
    800071e8:	02059463          	bnez	a1,80007210 <either_copyin+0x38>
    800071ec:	00060593          	mv	a1,a2
    800071f0:	0006861b          	sext.w	a2,a3
    800071f4:	00002097          	auipc	ra,0x2
    800071f8:	c10080e7          	jalr	-1008(ra) # 80008e04 <__memmove>
    800071fc:	00813083          	ld	ra,8(sp)
    80007200:	00013403          	ld	s0,0(sp)
    80007204:	00000513          	li	a0,0
    80007208:	01010113          	addi	sp,sp,16
    8000720c:	00008067          	ret
    80007210:	00002517          	auipc	a0,0x2
    80007214:	64050513          	addi	a0,a0,1600 # 80009850 <CONSOLE_STATUS+0x840>
    80007218:	00001097          	auipc	ra,0x1
    8000721c:	8e4080e7          	jalr	-1820(ra) # 80007afc <panic>

0000000080007220 <trapinit>:
    80007220:	ff010113          	addi	sp,sp,-16
    80007224:	00813423          	sd	s0,8(sp)
    80007228:	01010413          	addi	s0,sp,16
    8000722c:	00813403          	ld	s0,8(sp)
    80007230:	00002597          	auipc	a1,0x2
    80007234:	64858593          	addi	a1,a1,1608 # 80009878 <CONSOLE_STATUS+0x868>
    80007238:	00006517          	auipc	a0,0x6
    8000723c:	13850513          	addi	a0,a0,312 # 8000d370 <tickslock>
    80007240:	01010113          	addi	sp,sp,16
    80007244:	00001317          	auipc	t1,0x1
    80007248:	5c430067          	jr	1476(t1) # 80008808 <initlock>

000000008000724c <trapinithart>:
    8000724c:	ff010113          	addi	sp,sp,-16
    80007250:	00813423          	sd	s0,8(sp)
    80007254:	01010413          	addi	s0,sp,16
    80007258:	00000797          	auipc	a5,0x0
    8000725c:	2f878793          	addi	a5,a5,760 # 80007550 <kernelvec>
    80007260:	10579073          	csrw	stvec,a5
    80007264:	00813403          	ld	s0,8(sp)
    80007268:	01010113          	addi	sp,sp,16
    8000726c:	00008067          	ret

0000000080007270 <usertrap>:
    80007270:	ff010113          	addi	sp,sp,-16
    80007274:	00813423          	sd	s0,8(sp)
    80007278:	01010413          	addi	s0,sp,16
    8000727c:	00813403          	ld	s0,8(sp)
    80007280:	01010113          	addi	sp,sp,16
    80007284:	00008067          	ret

0000000080007288 <usertrapret>:
    80007288:	ff010113          	addi	sp,sp,-16
    8000728c:	00813423          	sd	s0,8(sp)
    80007290:	01010413          	addi	s0,sp,16
    80007294:	00813403          	ld	s0,8(sp)
    80007298:	01010113          	addi	sp,sp,16
    8000729c:	00008067          	ret

00000000800072a0 <kerneltrap>:
    800072a0:	fe010113          	addi	sp,sp,-32
    800072a4:	00813823          	sd	s0,16(sp)
    800072a8:	00113c23          	sd	ra,24(sp)
    800072ac:	00913423          	sd	s1,8(sp)
    800072b0:	02010413          	addi	s0,sp,32
    800072b4:	142025f3          	csrr	a1,scause
    800072b8:	100027f3          	csrr	a5,sstatus
    800072bc:	0027f793          	andi	a5,a5,2
    800072c0:	10079c63          	bnez	a5,800073d8 <kerneltrap+0x138>
    800072c4:	142027f3          	csrr	a5,scause
    800072c8:	0207ce63          	bltz	a5,80007304 <kerneltrap+0x64>
    800072cc:	00002517          	auipc	a0,0x2
    800072d0:	5f450513          	addi	a0,a0,1524 # 800098c0 <CONSOLE_STATUS+0x8b0>
    800072d4:	00001097          	auipc	ra,0x1
    800072d8:	884080e7          	jalr	-1916(ra) # 80007b58 <__printf>
    800072dc:	141025f3          	csrr	a1,sepc
    800072e0:	14302673          	csrr	a2,stval
    800072e4:	00002517          	auipc	a0,0x2
    800072e8:	5ec50513          	addi	a0,a0,1516 # 800098d0 <CONSOLE_STATUS+0x8c0>
    800072ec:	00001097          	auipc	ra,0x1
    800072f0:	86c080e7          	jalr	-1940(ra) # 80007b58 <__printf>
    800072f4:	00002517          	auipc	a0,0x2
    800072f8:	5f450513          	addi	a0,a0,1524 # 800098e8 <CONSOLE_STATUS+0x8d8>
    800072fc:	00001097          	auipc	ra,0x1
    80007300:	800080e7          	jalr	-2048(ra) # 80007afc <panic>
    80007304:	0ff7f713          	andi	a4,a5,255
    80007308:	00900693          	li	a3,9
    8000730c:	04d70063          	beq	a4,a3,8000734c <kerneltrap+0xac>
    80007310:	fff00713          	li	a4,-1
    80007314:	03f71713          	slli	a4,a4,0x3f
    80007318:	00170713          	addi	a4,a4,1
    8000731c:	fae798e3          	bne	a5,a4,800072cc <kerneltrap+0x2c>
    80007320:	00000097          	auipc	ra,0x0
    80007324:	e00080e7          	jalr	-512(ra) # 80007120 <cpuid>
    80007328:	06050663          	beqz	a0,80007394 <kerneltrap+0xf4>
    8000732c:	144027f3          	csrr	a5,sip
    80007330:	ffd7f793          	andi	a5,a5,-3
    80007334:	14479073          	csrw	sip,a5
    80007338:	01813083          	ld	ra,24(sp)
    8000733c:	01013403          	ld	s0,16(sp)
    80007340:	00813483          	ld	s1,8(sp)
    80007344:	02010113          	addi	sp,sp,32
    80007348:	00008067          	ret
    8000734c:	00000097          	auipc	ra,0x0
    80007350:	3c8080e7          	jalr	968(ra) # 80007714 <plic_claim>
    80007354:	00a00793          	li	a5,10
    80007358:	00050493          	mv	s1,a0
    8000735c:	06f50863          	beq	a0,a5,800073cc <kerneltrap+0x12c>
    80007360:	fc050ce3          	beqz	a0,80007338 <kerneltrap+0x98>
    80007364:	00050593          	mv	a1,a0
    80007368:	00002517          	auipc	a0,0x2
    8000736c:	53850513          	addi	a0,a0,1336 # 800098a0 <CONSOLE_STATUS+0x890>
    80007370:	00000097          	auipc	ra,0x0
    80007374:	7e8080e7          	jalr	2024(ra) # 80007b58 <__printf>
    80007378:	01013403          	ld	s0,16(sp)
    8000737c:	01813083          	ld	ra,24(sp)
    80007380:	00048513          	mv	a0,s1
    80007384:	00813483          	ld	s1,8(sp)
    80007388:	02010113          	addi	sp,sp,32
    8000738c:	00000317          	auipc	t1,0x0
    80007390:	3c030067          	jr	960(t1) # 8000774c <plic_complete>
    80007394:	00006517          	auipc	a0,0x6
    80007398:	fdc50513          	addi	a0,a0,-36 # 8000d370 <tickslock>
    8000739c:	00001097          	auipc	ra,0x1
    800073a0:	490080e7          	jalr	1168(ra) # 8000882c <acquire>
    800073a4:	00005717          	auipc	a4,0x5
    800073a8:	c8070713          	addi	a4,a4,-896 # 8000c024 <ticks>
    800073ac:	00072783          	lw	a5,0(a4)
    800073b0:	00006517          	auipc	a0,0x6
    800073b4:	fc050513          	addi	a0,a0,-64 # 8000d370 <tickslock>
    800073b8:	0017879b          	addiw	a5,a5,1
    800073bc:	00f72023          	sw	a5,0(a4)
    800073c0:	00001097          	auipc	ra,0x1
    800073c4:	538080e7          	jalr	1336(ra) # 800088f8 <release>
    800073c8:	f65ff06f          	j	8000732c <kerneltrap+0x8c>
    800073cc:	00001097          	auipc	ra,0x1
    800073d0:	094080e7          	jalr	148(ra) # 80008460 <uartintr>
    800073d4:	fa5ff06f          	j	80007378 <kerneltrap+0xd8>
    800073d8:	00002517          	auipc	a0,0x2
    800073dc:	4a850513          	addi	a0,a0,1192 # 80009880 <CONSOLE_STATUS+0x870>
    800073e0:	00000097          	auipc	ra,0x0
    800073e4:	71c080e7          	jalr	1820(ra) # 80007afc <panic>

00000000800073e8 <clockintr>:
    800073e8:	fe010113          	addi	sp,sp,-32
    800073ec:	00813823          	sd	s0,16(sp)
    800073f0:	00913423          	sd	s1,8(sp)
    800073f4:	00113c23          	sd	ra,24(sp)
    800073f8:	02010413          	addi	s0,sp,32
    800073fc:	00006497          	auipc	s1,0x6
    80007400:	f7448493          	addi	s1,s1,-140 # 8000d370 <tickslock>
    80007404:	00048513          	mv	a0,s1
    80007408:	00001097          	auipc	ra,0x1
    8000740c:	424080e7          	jalr	1060(ra) # 8000882c <acquire>
    80007410:	00005717          	auipc	a4,0x5
    80007414:	c1470713          	addi	a4,a4,-1004 # 8000c024 <ticks>
    80007418:	00072783          	lw	a5,0(a4)
    8000741c:	01013403          	ld	s0,16(sp)
    80007420:	01813083          	ld	ra,24(sp)
    80007424:	00048513          	mv	a0,s1
    80007428:	0017879b          	addiw	a5,a5,1
    8000742c:	00813483          	ld	s1,8(sp)
    80007430:	00f72023          	sw	a5,0(a4)
    80007434:	02010113          	addi	sp,sp,32
    80007438:	00001317          	auipc	t1,0x1
    8000743c:	4c030067          	jr	1216(t1) # 800088f8 <release>

0000000080007440 <devintr>:
    80007440:	142027f3          	csrr	a5,scause
    80007444:	00000513          	li	a0,0
    80007448:	0007c463          	bltz	a5,80007450 <devintr+0x10>
    8000744c:	00008067          	ret
    80007450:	fe010113          	addi	sp,sp,-32
    80007454:	00813823          	sd	s0,16(sp)
    80007458:	00113c23          	sd	ra,24(sp)
    8000745c:	00913423          	sd	s1,8(sp)
    80007460:	02010413          	addi	s0,sp,32
    80007464:	0ff7f713          	andi	a4,a5,255
    80007468:	00900693          	li	a3,9
    8000746c:	04d70c63          	beq	a4,a3,800074c4 <devintr+0x84>
    80007470:	fff00713          	li	a4,-1
    80007474:	03f71713          	slli	a4,a4,0x3f
    80007478:	00170713          	addi	a4,a4,1
    8000747c:	00e78c63          	beq	a5,a4,80007494 <devintr+0x54>
    80007480:	01813083          	ld	ra,24(sp)
    80007484:	01013403          	ld	s0,16(sp)
    80007488:	00813483          	ld	s1,8(sp)
    8000748c:	02010113          	addi	sp,sp,32
    80007490:	00008067          	ret
    80007494:	00000097          	auipc	ra,0x0
    80007498:	c8c080e7          	jalr	-884(ra) # 80007120 <cpuid>
    8000749c:	06050663          	beqz	a0,80007508 <devintr+0xc8>
    800074a0:	144027f3          	csrr	a5,sip
    800074a4:	ffd7f793          	andi	a5,a5,-3
    800074a8:	14479073          	csrw	sip,a5
    800074ac:	01813083          	ld	ra,24(sp)
    800074b0:	01013403          	ld	s0,16(sp)
    800074b4:	00813483          	ld	s1,8(sp)
    800074b8:	00200513          	li	a0,2
    800074bc:	02010113          	addi	sp,sp,32
    800074c0:	00008067          	ret
    800074c4:	00000097          	auipc	ra,0x0
    800074c8:	250080e7          	jalr	592(ra) # 80007714 <plic_claim>
    800074cc:	00a00793          	li	a5,10
    800074d0:	00050493          	mv	s1,a0
    800074d4:	06f50663          	beq	a0,a5,80007540 <devintr+0x100>
    800074d8:	00100513          	li	a0,1
    800074dc:	fa0482e3          	beqz	s1,80007480 <devintr+0x40>
    800074e0:	00048593          	mv	a1,s1
    800074e4:	00002517          	auipc	a0,0x2
    800074e8:	3bc50513          	addi	a0,a0,956 # 800098a0 <CONSOLE_STATUS+0x890>
    800074ec:	00000097          	auipc	ra,0x0
    800074f0:	66c080e7          	jalr	1644(ra) # 80007b58 <__printf>
    800074f4:	00048513          	mv	a0,s1
    800074f8:	00000097          	auipc	ra,0x0
    800074fc:	254080e7          	jalr	596(ra) # 8000774c <plic_complete>
    80007500:	00100513          	li	a0,1
    80007504:	f7dff06f          	j	80007480 <devintr+0x40>
    80007508:	00006517          	auipc	a0,0x6
    8000750c:	e6850513          	addi	a0,a0,-408 # 8000d370 <tickslock>
    80007510:	00001097          	auipc	ra,0x1
    80007514:	31c080e7          	jalr	796(ra) # 8000882c <acquire>
    80007518:	00005717          	auipc	a4,0x5
    8000751c:	b0c70713          	addi	a4,a4,-1268 # 8000c024 <ticks>
    80007520:	00072783          	lw	a5,0(a4)
    80007524:	00006517          	auipc	a0,0x6
    80007528:	e4c50513          	addi	a0,a0,-436 # 8000d370 <tickslock>
    8000752c:	0017879b          	addiw	a5,a5,1
    80007530:	00f72023          	sw	a5,0(a4)
    80007534:	00001097          	auipc	ra,0x1
    80007538:	3c4080e7          	jalr	964(ra) # 800088f8 <release>
    8000753c:	f65ff06f          	j	800074a0 <devintr+0x60>
    80007540:	00001097          	auipc	ra,0x1
    80007544:	f20080e7          	jalr	-224(ra) # 80008460 <uartintr>
    80007548:	fadff06f          	j	800074f4 <devintr+0xb4>
    8000754c:	0000                	unimp
	...

0000000080007550 <kernelvec>:
    80007550:	f0010113          	addi	sp,sp,-256
    80007554:	00113023          	sd	ra,0(sp)
    80007558:	00213423          	sd	sp,8(sp)
    8000755c:	00313823          	sd	gp,16(sp)
    80007560:	00413c23          	sd	tp,24(sp)
    80007564:	02513023          	sd	t0,32(sp)
    80007568:	02613423          	sd	t1,40(sp)
    8000756c:	02713823          	sd	t2,48(sp)
    80007570:	02813c23          	sd	s0,56(sp)
    80007574:	04913023          	sd	s1,64(sp)
    80007578:	04a13423          	sd	a0,72(sp)
    8000757c:	04b13823          	sd	a1,80(sp)
    80007580:	04c13c23          	sd	a2,88(sp)
    80007584:	06d13023          	sd	a3,96(sp)
    80007588:	06e13423          	sd	a4,104(sp)
    8000758c:	06f13823          	sd	a5,112(sp)
    80007590:	07013c23          	sd	a6,120(sp)
    80007594:	09113023          	sd	a7,128(sp)
    80007598:	09213423          	sd	s2,136(sp)
    8000759c:	09313823          	sd	s3,144(sp)
    800075a0:	09413c23          	sd	s4,152(sp)
    800075a4:	0b513023          	sd	s5,160(sp)
    800075a8:	0b613423          	sd	s6,168(sp)
    800075ac:	0b713823          	sd	s7,176(sp)
    800075b0:	0b813c23          	sd	s8,184(sp)
    800075b4:	0d913023          	sd	s9,192(sp)
    800075b8:	0da13423          	sd	s10,200(sp)
    800075bc:	0db13823          	sd	s11,208(sp)
    800075c0:	0dc13c23          	sd	t3,216(sp)
    800075c4:	0fd13023          	sd	t4,224(sp)
    800075c8:	0fe13423          	sd	t5,232(sp)
    800075cc:	0ff13823          	sd	t6,240(sp)
    800075d0:	cd1ff0ef          	jal	ra,800072a0 <kerneltrap>
    800075d4:	00013083          	ld	ra,0(sp)
    800075d8:	00813103          	ld	sp,8(sp)
    800075dc:	01013183          	ld	gp,16(sp)
    800075e0:	02013283          	ld	t0,32(sp)
    800075e4:	02813303          	ld	t1,40(sp)
    800075e8:	03013383          	ld	t2,48(sp)
    800075ec:	03813403          	ld	s0,56(sp)
    800075f0:	04013483          	ld	s1,64(sp)
    800075f4:	04813503          	ld	a0,72(sp)
    800075f8:	05013583          	ld	a1,80(sp)
    800075fc:	05813603          	ld	a2,88(sp)
    80007600:	06013683          	ld	a3,96(sp)
    80007604:	06813703          	ld	a4,104(sp)
    80007608:	07013783          	ld	a5,112(sp)
    8000760c:	07813803          	ld	a6,120(sp)
    80007610:	08013883          	ld	a7,128(sp)
    80007614:	08813903          	ld	s2,136(sp)
    80007618:	09013983          	ld	s3,144(sp)
    8000761c:	09813a03          	ld	s4,152(sp)
    80007620:	0a013a83          	ld	s5,160(sp)
    80007624:	0a813b03          	ld	s6,168(sp)
    80007628:	0b013b83          	ld	s7,176(sp)
    8000762c:	0b813c03          	ld	s8,184(sp)
    80007630:	0c013c83          	ld	s9,192(sp)
    80007634:	0c813d03          	ld	s10,200(sp)
    80007638:	0d013d83          	ld	s11,208(sp)
    8000763c:	0d813e03          	ld	t3,216(sp)
    80007640:	0e013e83          	ld	t4,224(sp)
    80007644:	0e813f03          	ld	t5,232(sp)
    80007648:	0f013f83          	ld	t6,240(sp)
    8000764c:	10010113          	addi	sp,sp,256
    80007650:	10200073          	sret
    80007654:	00000013          	nop
    80007658:	00000013          	nop
    8000765c:	00000013          	nop

0000000080007660 <timervec>:
    80007660:	34051573          	csrrw	a0,mscratch,a0
    80007664:	00b53023          	sd	a1,0(a0)
    80007668:	00c53423          	sd	a2,8(a0)
    8000766c:	00d53823          	sd	a3,16(a0)
    80007670:	01853583          	ld	a1,24(a0)
    80007674:	02053603          	ld	a2,32(a0)
    80007678:	0005b683          	ld	a3,0(a1)
    8000767c:	00c686b3          	add	a3,a3,a2
    80007680:	00d5b023          	sd	a3,0(a1)
    80007684:	00200593          	li	a1,2
    80007688:	14459073          	csrw	sip,a1
    8000768c:	01053683          	ld	a3,16(a0)
    80007690:	00853603          	ld	a2,8(a0)
    80007694:	00053583          	ld	a1,0(a0)
    80007698:	34051573          	csrrw	a0,mscratch,a0
    8000769c:	30200073          	mret

00000000800076a0 <plicinit>:
    800076a0:	ff010113          	addi	sp,sp,-16
    800076a4:	00813423          	sd	s0,8(sp)
    800076a8:	01010413          	addi	s0,sp,16
    800076ac:	00813403          	ld	s0,8(sp)
    800076b0:	0c0007b7          	lui	a5,0xc000
    800076b4:	00100713          	li	a4,1
    800076b8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800076bc:	00e7a223          	sw	a4,4(a5)
    800076c0:	01010113          	addi	sp,sp,16
    800076c4:	00008067          	ret

00000000800076c8 <plicinithart>:
    800076c8:	ff010113          	addi	sp,sp,-16
    800076cc:	00813023          	sd	s0,0(sp)
    800076d0:	00113423          	sd	ra,8(sp)
    800076d4:	01010413          	addi	s0,sp,16
    800076d8:	00000097          	auipc	ra,0x0
    800076dc:	a48080e7          	jalr	-1464(ra) # 80007120 <cpuid>
    800076e0:	0085171b          	slliw	a4,a0,0x8
    800076e4:	0c0027b7          	lui	a5,0xc002
    800076e8:	00e787b3          	add	a5,a5,a4
    800076ec:	40200713          	li	a4,1026
    800076f0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800076f4:	00813083          	ld	ra,8(sp)
    800076f8:	00013403          	ld	s0,0(sp)
    800076fc:	00d5151b          	slliw	a0,a0,0xd
    80007700:	0c2017b7          	lui	a5,0xc201
    80007704:	00a78533          	add	a0,a5,a0
    80007708:	00052023          	sw	zero,0(a0)
    8000770c:	01010113          	addi	sp,sp,16
    80007710:	00008067          	ret

0000000080007714 <plic_claim>:
    80007714:	ff010113          	addi	sp,sp,-16
    80007718:	00813023          	sd	s0,0(sp)
    8000771c:	00113423          	sd	ra,8(sp)
    80007720:	01010413          	addi	s0,sp,16
    80007724:	00000097          	auipc	ra,0x0
    80007728:	9fc080e7          	jalr	-1540(ra) # 80007120 <cpuid>
    8000772c:	00813083          	ld	ra,8(sp)
    80007730:	00013403          	ld	s0,0(sp)
    80007734:	00d5151b          	slliw	a0,a0,0xd
    80007738:	0c2017b7          	lui	a5,0xc201
    8000773c:	00a78533          	add	a0,a5,a0
    80007740:	00452503          	lw	a0,4(a0)
    80007744:	01010113          	addi	sp,sp,16
    80007748:	00008067          	ret

000000008000774c <plic_complete>:
    8000774c:	fe010113          	addi	sp,sp,-32
    80007750:	00813823          	sd	s0,16(sp)
    80007754:	00913423          	sd	s1,8(sp)
    80007758:	00113c23          	sd	ra,24(sp)
    8000775c:	02010413          	addi	s0,sp,32
    80007760:	00050493          	mv	s1,a0
    80007764:	00000097          	auipc	ra,0x0
    80007768:	9bc080e7          	jalr	-1604(ra) # 80007120 <cpuid>
    8000776c:	01813083          	ld	ra,24(sp)
    80007770:	01013403          	ld	s0,16(sp)
    80007774:	00d5179b          	slliw	a5,a0,0xd
    80007778:	0c201737          	lui	a4,0xc201
    8000777c:	00f707b3          	add	a5,a4,a5
    80007780:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80007784:	00813483          	ld	s1,8(sp)
    80007788:	02010113          	addi	sp,sp,32
    8000778c:	00008067          	ret

0000000080007790 <consolewrite>:
    80007790:	fb010113          	addi	sp,sp,-80
    80007794:	04813023          	sd	s0,64(sp)
    80007798:	04113423          	sd	ra,72(sp)
    8000779c:	02913c23          	sd	s1,56(sp)
    800077a0:	03213823          	sd	s2,48(sp)
    800077a4:	03313423          	sd	s3,40(sp)
    800077a8:	03413023          	sd	s4,32(sp)
    800077ac:	01513c23          	sd	s5,24(sp)
    800077b0:	05010413          	addi	s0,sp,80
    800077b4:	06c05c63          	blez	a2,8000782c <consolewrite+0x9c>
    800077b8:	00060993          	mv	s3,a2
    800077bc:	00050a13          	mv	s4,a0
    800077c0:	00058493          	mv	s1,a1
    800077c4:	00000913          	li	s2,0
    800077c8:	fff00a93          	li	s5,-1
    800077cc:	01c0006f          	j	800077e8 <consolewrite+0x58>
    800077d0:	fbf44503          	lbu	a0,-65(s0)
    800077d4:	0019091b          	addiw	s2,s2,1
    800077d8:	00148493          	addi	s1,s1,1
    800077dc:	00001097          	auipc	ra,0x1
    800077e0:	a9c080e7          	jalr	-1380(ra) # 80008278 <uartputc>
    800077e4:	03298063          	beq	s3,s2,80007804 <consolewrite+0x74>
    800077e8:	00048613          	mv	a2,s1
    800077ec:	00100693          	li	a3,1
    800077f0:	000a0593          	mv	a1,s4
    800077f4:	fbf40513          	addi	a0,s0,-65
    800077f8:	00000097          	auipc	ra,0x0
    800077fc:	9e0080e7          	jalr	-1568(ra) # 800071d8 <either_copyin>
    80007800:	fd5518e3          	bne	a0,s5,800077d0 <consolewrite+0x40>
    80007804:	04813083          	ld	ra,72(sp)
    80007808:	04013403          	ld	s0,64(sp)
    8000780c:	03813483          	ld	s1,56(sp)
    80007810:	02813983          	ld	s3,40(sp)
    80007814:	02013a03          	ld	s4,32(sp)
    80007818:	01813a83          	ld	s5,24(sp)
    8000781c:	00090513          	mv	a0,s2
    80007820:	03013903          	ld	s2,48(sp)
    80007824:	05010113          	addi	sp,sp,80
    80007828:	00008067          	ret
    8000782c:	00000913          	li	s2,0
    80007830:	fd5ff06f          	j	80007804 <consolewrite+0x74>

0000000080007834 <consoleread>:
    80007834:	f9010113          	addi	sp,sp,-112
    80007838:	06813023          	sd	s0,96(sp)
    8000783c:	04913c23          	sd	s1,88(sp)
    80007840:	05213823          	sd	s2,80(sp)
    80007844:	05313423          	sd	s3,72(sp)
    80007848:	05413023          	sd	s4,64(sp)
    8000784c:	03513c23          	sd	s5,56(sp)
    80007850:	03613823          	sd	s6,48(sp)
    80007854:	03713423          	sd	s7,40(sp)
    80007858:	03813023          	sd	s8,32(sp)
    8000785c:	06113423          	sd	ra,104(sp)
    80007860:	01913c23          	sd	s9,24(sp)
    80007864:	07010413          	addi	s0,sp,112
    80007868:	00060b93          	mv	s7,a2
    8000786c:	00050913          	mv	s2,a0
    80007870:	00058c13          	mv	s8,a1
    80007874:	00060b1b          	sext.w	s6,a2
    80007878:	00006497          	auipc	s1,0x6
    8000787c:	b2048493          	addi	s1,s1,-1248 # 8000d398 <cons>
    80007880:	00400993          	li	s3,4
    80007884:	fff00a13          	li	s4,-1
    80007888:	00a00a93          	li	s5,10
    8000788c:	05705e63          	blez	s7,800078e8 <consoleread+0xb4>
    80007890:	09c4a703          	lw	a4,156(s1)
    80007894:	0984a783          	lw	a5,152(s1)
    80007898:	0007071b          	sext.w	a4,a4
    8000789c:	08e78463          	beq	a5,a4,80007924 <consoleread+0xf0>
    800078a0:	07f7f713          	andi	a4,a5,127
    800078a4:	00e48733          	add	a4,s1,a4
    800078a8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800078ac:	0017869b          	addiw	a3,a5,1
    800078b0:	08d4ac23          	sw	a3,152(s1)
    800078b4:	00070c9b          	sext.w	s9,a4
    800078b8:	0b370663          	beq	a4,s3,80007964 <consoleread+0x130>
    800078bc:	00100693          	li	a3,1
    800078c0:	f9f40613          	addi	a2,s0,-97
    800078c4:	000c0593          	mv	a1,s8
    800078c8:	00090513          	mv	a0,s2
    800078cc:	f8e40fa3          	sb	a4,-97(s0)
    800078d0:	00000097          	auipc	ra,0x0
    800078d4:	8bc080e7          	jalr	-1860(ra) # 8000718c <either_copyout>
    800078d8:	01450863          	beq	a0,s4,800078e8 <consoleread+0xb4>
    800078dc:	001c0c13          	addi	s8,s8,1
    800078e0:	fffb8b9b          	addiw	s7,s7,-1
    800078e4:	fb5c94e3          	bne	s9,s5,8000788c <consoleread+0x58>
    800078e8:	000b851b          	sext.w	a0,s7
    800078ec:	06813083          	ld	ra,104(sp)
    800078f0:	06013403          	ld	s0,96(sp)
    800078f4:	05813483          	ld	s1,88(sp)
    800078f8:	05013903          	ld	s2,80(sp)
    800078fc:	04813983          	ld	s3,72(sp)
    80007900:	04013a03          	ld	s4,64(sp)
    80007904:	03813a83          	ld	s5,56(sp)
    80007908:	02813b83          	ld	s7,40(sp)
    8000790c:	02013c03          	ld	s8,32(sp)
    80007910:	01813c83          	ld	s9,24(sp)
    80007914:	40ab053b          	subw	a0,s6,a0
    80007918:	03013b03          	ld	s6,48(sp)
    8000791c:	07010113          	addi	sp,sp,112
    80007920:	00008067          	ret
    80007924:	00001097          	auipc	ra,0x1
    80007928:	1d8080e7          	jalr	472(ra) # 80008afc <push_on>
    8000792c:	0984a703          	lw	a4,152(s1)
    80007930:	09c4a783          	lw	a5,156(s1)
    80007934:	0007879b          	sext.w	a5,a5
    80007938:	fef70ce3          	beq	a4,a5,80007930 <consoleread+0xfc>
    8000793c:	00001097          	auipc	ra,0x1
    80007940:	234080e7          	jalr	564(ra) # 80008b70 <pop_on>
    80007944:	0984a783          	lw	a5,152(s1)
    80007948:	07f7f713          	andi	a4,a5,127
    8000794c:	00e48733          	add	a4,s1,a4
    80007950:	01874703          	lbu	a4,24(a4)
    80007954:	0017869b          	addiw	a3,a5,1
    80007958:	08d4ac23          	sw	a3,152(s1)
    8000795c:	00070c9b          	sext.w	s9,a4
    80007960:	f5371ee3          	bne	a4,s3,800078bc <consoleread+0x88>
    80007964:	000b851b          	sext.w	a0,s7
    80007968:	f96bf2e3          	bgeu	s7,s6,800078ec <consoleread+0xb8>
    8000796c:	08f4ac23          	sw	a5,152(s1)
    80007970:	f7dff06f          	j	800078ec <consoleread+0xb8>

0000000080007974 <consputc>:
    80007974:	10000793          	li	a5,256
    80007978:	00f50663          	beq	a0,a5,80007984 <consputc+0x10>
    8000797c:	00001317          	auipc	t1,0x1
    80007980:	9f430067          	jr	-1548(t1) # 80008370 <uartputc_sync>
    80007984:	ff010113          	addi	sp,sp,-16
    80007988:	00113423          	sd	ra,8(sp)
    8000798c:	00813023          	sd	s0,0(sp)
    80007990:	01010413          	addi	s0,sp,16
    80007994:	00800513          	li	a0,8
    80007998:	00001097          	auipc	ra,0x1
    8000799c:	9d8080e7          	jalr	-1576(ra) # 80008370 <uartputc_sync>
    800079a0:	02000513          	li	a0,32
    800079a4:	00001097          	auipc	ra,0x1
    800079a8:	9cc080e7          	jalr	-1588(ra) # 80008370 <uartputc_sync>
    800079ac:	00013403          	ld	s0,0(sp)
    800079b0:	00813083          	ld	ra,8(sp)
    800079b4:	00800513          	li	a0,8
    800079b8:	01010113          	addi	sp,sp,16
    800079bc:	00001317          	auipc	t1,0x1
    800079c0:	9b430067          	jr	-1612(t1) # 80008370 <uartputc_sync>

00000000800079c4 <consoleintr>:
    800079c4:	fe010113          	addi	sp,sp,-32
    800079c8:	00813823          	sd	s0,16(sp)
    800079cc:	00913423          	sd	s1,8(sp)
    800079d0:	01213023          	sd	s2,0(sp)
    800079d4:	00113c23          	sd	ra,24(sp)
    800079d8:	02010413          	addi	s0,sp,32
    800079dc:	00006917          	auipc	s2,0x6
    800079e0:	9bc90913          	addi	s2,s2,-1604 # 8000d398 <cons>
    800079e4:	00050493          	mv	s1,a0
    800079e8:	00090513          	mv	a0,s2
    800079ec:	00001097          	auipc	ra,0x1
    800079f0:	e40080e7          	jalr	-448(ra) # 8000882c <acquire>
    800079f4:	02048c63          	beqz	s1,80007a2c <consoleintr+0x68>
    800079f8:	0a092783          	lw	a5,160(s2)
    800079fc:	09892703          	lw	a4,152(s2)
    80007a00:	07f00693          	li	a3,127
    80007a04:	40e7873b          	subw	a4,a5,a4
    80007a08:	02e6e263          	bltu	a3,a4,80007a2c <consoleintr+0x68>
    80007a0c:	00d00713          	li	a4,13
    80007a10:	04e48063          	beq	s1,a4,80007a50 <consoleintr+0x8c>
    80007a14:	07f7f713          	andi	a4,a5,127
    80007a18:	00e90733          	add	a4,s2,a4
    80007a1c:	0017879b          	addiw	a5,a5,1
    80007a20:	0af92023          	sw	a5,160(s2)
    80007a24:	00970c23          	sb	s1,24(a4)
    80007a28:	08f92e23          	sw	a5,156(s2)
    80007a2c:	01013403          	ld	s0,16(sp)
    80007a30:	01813083          	ld	ra,24(sp)
    80007a34:	00813483          	ld	s1,8(sp)
    80007a38:	00013903          	ld	s2,0(sp)
    80007a3c:	00006517          	auipc	a0,0x6
    80007a40:	95c50513          	addi	a0,a0,-1700 # 8000d398 <cons>
    80007a44:	02010113          	addi	sp,sp,32
    80007a48:	00001317          	auipc	t1,0x1
    80007a4c:	eb030067          	jr	-336(t1) # 800088f8 <release>
    80007a50:	00a00493          	li	s1,10
    80007a54:	fc1ff06f          	j	80007a14 <consoleintr+0x50>

0000000080007a58 <consoleinit>:
    80007a58:	fe010113          	addi	sp,sp,-32
    80007a5c:	00113c23          	sd	ra,24(sp)
    80007a60:	00813823          	sd	s0,16(sp)
    80007a64:	00913423          	sd	s1,8(sp)
    80007a68:	02010413          	addi	s0,sp,32
    80007a6c:	00006497          	auipc	s1,0x6
    80007a70:	92c48493          	addi	s1,s1,-1748 # 8000d398 <cons>
    80007a74:	00048513          	mv	a0,s1
    80007a78:	00002597          	auipc	a1,0x2
    80007a7c:	e8058593          	addi	a1,a1,-384 # 800098f8 <CONSOLE_STATUS+0x8e8>
    80007a80:	00001097          	auipc	ra,0x1
    80007a84:	d88080e7          	jalr	-632(ra) # 80008808 <initlock>
    80007a88:	00000097          	auipc	ra,0x0
    80007a8c:	7ac080e7          	jalr	1964(ra) # 80008234 <uartinit>
    80007a90:	01813083          	ld	ra,24(sp)
    80007a94:	01013403          	ld	s0,16(sp)
    80007a98:	00000797          	auipc	a5,0x0
    80007a9c:	d9c78793          	addi	a5,a5,-612 # 80007834 <consoleread>
    80007aa0:	0af4bc23          	sd	a5,184(s1)
    80007aa4:	00000797          	auipc	a5,0x0
    80007aa8:	cec78793          	addi	a5,a5,-788 # 80007790 <consolewrite>
    80007aac:	0cf4b023          	sd	a5,192(s1)
    80007ab0:	00813483          	ld	s1,8(sp)
    80007ab4:	02010113          	addi	sp,sp,32
    80007ab8:	00008067          	ret

0000000080007abc <console_read>:
    80007abc:	ff010113          	addi	sp,sp,-16
    80007ac0:	00813423          	sd	s0,8(sp)
    80007ac4:	01010413          	addi	s0,sp,16
    80007ac8:	00813403          	ld	s0,8(sp)
    80007acc:	00006317          	auipc	t1,0x6
    80007ad0:	98433303          	ld	t1,-1660(t1) # 8000d450 <devsw+0x10>
    80007ad4:	01010113          	addi	sp,sp,16
    80007ad8:	00030067          	jr	t1

0000000080007adc <console_write>:
    80007adc:	ff010113          	addi	sp,sp,-16
    80007ae0:	00813423          	sd	s0,8(sp)
    80007ae4:	01010413          	addi	s0,sp,16
    80007ae8:	00813403          	ld	s0,8(sp)
    80007aec:	00006317          	auipc	t1,0x6
    80007af0:	96c33303          	ld	t1,-1684(t1) # 8000d458 <devsw+0x18>
    80007af4:	01010113          	addi	sp,sp,16
    80007af8:	00030067          	jr	t1

0000000080007afc <panic>:
    80007afc:	fe010113          	addi	sp,sp,-32
    80007b00:	00113c23          	sd	ra,24(sp)
    80007b04:	00813823          	sd	s0,16(sp)
    80007b08:	00913423          	sd	s1,8(sp)
    80007b0c:	02010413          	addi	s0,sp,32
    80007b10:	00050493          	mv	s1,a0
    80007b14:	00002517          	auipc	a0,0x2
    80007b18:	dec50513          	addi	a0,a0,-532 # 80009900 <CONSOLE_STATUS+0x8f0>
    80007b1c:	00006797          	auipc	a5,0x6
    80007b20:	9c07ae23          	sw	zero,-1572(a5) # 8000d4f8 <pr+0x18>
    80007b24:	00000097          	auipc	ra,0x0
    80007b28:	034080e7          	jalr	52(ra) # 80007b58 <__printf>
    80007b2c:	00048513          	mv	a0,s1
    80007b30:	00000097          	auipc	ra,0x0
    80007b34:	028080e7          	jalr	40(ra) # 80007b58 <__printf>
    80007b38:	00002517          	auipc	a0,0x2
    80007b3c:	88850513          	addi	a0,a0,-1912 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80007b40:	00000097          	auipc	ra,0x0
    80007b44:	018080e7          	jalr	24(ra) # 80007b58 <__printf>
    80007b48:	00100793          	li	a5,1
    80007b4c:	00004717          	auipc	a4,0x4
    80007b50:	4cf72e23          	sw	a5,1244(a4) # 8000c028 <panicked>
    80007b54:	0000006f          	j	80007b54 <panic+0x58>

0000000080007b58 <__printf>:
    80007b58:	f3010113          	addi	sp,sp,-208
    80007b5c:	08813023          	sd	s0,128(sp)
    80007b60:	07313423          	sd	s3,104(sp)
    80007b64:	09010413          	addi	s0,sp,144
    80007b68:	05813023          	sd	s8,64(sp)
    80007b6c:	08113423          	sd	ra,136(sp)
    80007b70:	06913c23          	sd	s1,120(sp)
    80007b74:	07213823          	sd	s2,112(sp)
    80007b78:	07413023          	sd	s4,96(sp)
    80007b7c:	05513c23          	sd	s5,88(sp)
    80007b80:	05613823          	sd	s6,80(sp)
    80007b84:	05713423          	sd	s7,72(sp)
    80007b88:	03913c23          	sd	s9,56(sp)
    80007b8c:	03a13823          	sd	s10,48(sp)
    80007b90:	03b13423          	sd	s11,40(sp)
    80007b94:	00006317          	auipc	t1,0x6
    80007b98:	94c30313          	addi	t1,t1,-1716 # 8000d4e0 <pr>
    80007b9c:	01832c03          	lw	s8,24(t1)
    80007ba0:	00b43423          	sd	a1,8(s0)
    80007ba4:	00c43823          	sd	a2,16(s0)
    80007ba8:	00d43c23          	sd	a3,24(s0)
    80007bac:	02e43023          	sd	a4,32(s0)
    80007bb0:	02f43423          	sd	a5,40(s0)
    80007bb4:	03043823          	sd	a6,48(s0)
    80007bb8:	03143c23          	sd	a7,56(s0)
    80007bbc:	00050993          	mv	s3,a0
    80007bc0:	4a0c1663          	bnez	s8,8000806c <__printf+0x514>
    80007bc4:	60098c63          	beqz	s3,800081dc <__printf+0x684>
    80007bc8:	0009c503          	lbu	a0,0(s3)
    80007bcc:	00840793          	addi	a5,s0,8
    80007bd0:	f6f43c23          	sd	a5,-136(s0)
    80007bd4:	00000493          	li	s1,0
    80007bd8:	22050063          	beqz	a0,80007df8 <__printf+0x2a0>
    80007bdc:	00002a37          	lui	s4,0x2
    80007be0:	00018ab7          	lui	s5,0x18
    80007be4:	000f4b37          	lui	s6,0xf4
    80007be8:	00989bb7          	lui	s7,0x989
    80007bec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007bf0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007bf4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007bf8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80007bfc:	00148c9b          	addiw	s9,s1,1
    80007c00:	02500793          	li	a5,37
    80007c04:	01998933          	add	s2,s3,s9
    80007c08:	38f51263          	bne	a0,a5,80007f8c <__printf+0x434>
    80007c0c:	00094783          	lbu	a5,0(s2)
    80007c10:	00078c9b          	sext.w	s9,a5
    80007c14:	1e078263          	beqz	a5,80007df8 <__printf+0x2a0>
    80007c18:	0024849b          	addiw	s1,s1,2
    80007c1c:	07000713          	li	a4,112
    80007c20:	00998933          	add	s2,s3,s1
    80007c24:	38e78a63          	beq	a5,a4,80007fb8 <__printf+0x460>
    80007c28:	20f76863          	bltu	a4,a5,80007e38 <__printf+0x2e0>
    80007c2c:	42a78863          	beq	a5,a0,8000805c <__printf+0x504>
    80007c30:	06400713          	li	a4,100
    80007c34:	40e79663          	bne	a5,a4,80008040 <__printf+0x4e8>
    80007c38:	f7843783          	ld	a5,-136(s0)
    80007c3c:	0007a603          	lw	a2,0(a5)
    80007c40:	00878793          	addi	a5,a5,8
    80007c44:	f6f43c23          	sd	a5,-136(s0)
    80007c48:	42064a63          	bltz	a2,8000807c <__printf+0x524>
    80007c4c:	00a00713          	li	a4,10
    80007c50:	02e677bb          	remuw	a5,a2,a4
    80007c54:	00002d97          	auipc	s11,0x2
    80007c58:	cd4d8d93          	addi	s11,s11,-812 # 80009928 <digits>
    80007c5c:	00900593          	li	a1,9
    80007c60:	0006051b          	sext.w	a0,a2
    80007c64:	00000c93          	li	s9,0
    80007c68:	02079793          	slli	a5,a5,0x20
    80007c6c:	0207d793          	srli	a5,a5,0x20
    80007c70:	00fd87b3          	add	a5,s11,a5
    80007c74:	0007c783          	lbu	a5,0(a5)
    80007c78:	02e656bb          	divuw	a3,a2,a4
    80007c7c:	f8f40023          	sb	a5,-128(s0)
    80007c80:	14c5d863          	bge	a1,a2,80007dd0 <__printf+0x278>
    80007c84:	06300593          	li	a1,99
    80007c88:	00100c93          	li	s9,1
    80007c8c:	02e6f7bb          	remuw	a5,a3,a4
    80007c90:	02079793          	slli	a5,a5,0x20
    80007c94:	0207d793          	srli	a5,a5,0x20
    80007c98:	00fd87b3          	add	a5,s11,a5
    80007c9c:	0007c783          	lbu	a5,0(a5)
    80007ca0:	02e6d73b          	divuw	a4,a3,a4
    80007ca4:	f8f400a3          	sb	a5,-127(s0)
    80007ca8:	12a5f463          	bgeu	a1,a0,80007dd0 <__printf+0x278>
    80007cac:	00a00693          	li	a3,10
    80007cb0:	00900593          	li	a1,9
    80007cb4:	02d777bb          	remuw	a5,a4,a3
    80007cb8:	02079793          	slli	a5,a5,0x20
    80007cbc:	0207d793          	srli	a5,a5,0x20
    80007cc0:	00fd87b3          	add	a5,s11,a5
    80007cc4:	0007c503          	lbu	a0,0(a5)
    80007cc8:	02d757bb          	divuw	a5,a4,a3
    80007ccc:	f8a40123          	sb	a0,-126(s0)
    80007cd0:	48e5f263          	bgeu	a1,a4,80008154 <__printf+0x5fc>
    80007cd4:	06300513          	li	a0,99
    80007cd8:	02d7f5bb          	remuw	a1,a5,a3
    80007cdc:	02059593          	slli	a1,a1,0x20
    80007ce0:	0205d593          	srli	a1,a1,0x20
    80007ce4:	00bd85b3          	add	a1,s11,a1
    80007ce8:	0005c583          	lbu	a1,0(a1)
    80007cec:	02d7d7bb          	divuw	a5,a5,a3
    80007cf0:	f8b401a3          	sb	a1,-125(s0)
    80007cf4:	48e57263          	bgeu	a0,a4,80008178 <__printf+0x620>
    80007cf8:	3e700513          	li	a0,999
    80007cfc:	02d7f5bb          	remuw	a1,a5,a3
    80007d00:	02059593          	slli	a1,a1,0x20
    80007d04:	0205d593          	srli	a1,a1,0x20
    80007d08:	00bd85b3          	add	a1,s11,a1
    80007d0c:	0005c583          	lbu	a1,0(a1)
    80007d10:	02d7d7bb          	divuw	a5,a5,a3
    80007d14:	f8b40223          	sb	a1,-124(s0)
    80007d18:	46e57663          	bgeu	a0,a4,80008184 <__printf+0x62c>
    80007d1c:	02d7f5bb          	remuw	a1,a5,a3
    80007d20:	02059593          	slli	a1,a1,0x20
    80007d24:	0205d593          	srli	a1,a1,0x20
    80007d28:	00bd85b3          	add	a1,s11,a1
    80007d2c:	0005c583          	lbu	a1,0(a1)
    80007d30:	02d7d7bb          	divuw	a5,a5,a3
    80007d34:	f8b402a3          	sb	a1,-123(s0)
    80007d38:	46ea7863          	bgeu	s4,a4,800081a8 <__printf+0x650>
    80007d3c:	02d7f5bb          	remuw	a1,a5,a3
    80007d40:	02059593          	slli	a1,a1,0x20
    80007d44:	0205d593          	srli	a1,a1,0x20
    80007d48:	00bd85b3          	add	a1,s11,a1
    80007d4c:	0005c583          	lbu	a1,0(a1)
    80007d50:	02d7d7bb          	divuw	a5,a5,a3
    80007d54:	f8b40323          	sb	a1,-122(s0)
    80007d58:	3eeaf863          	bgeu	s5,a4,80008148 <__printf+0x5f0>
    80007d5c:	02d7f5bb          	remuw	a1,a5,a3
    80007d60:	02059593          	slli	a1,a1,0x20
    80007d64:	0205d593          	srli	a1,a1,0x20
    80007d68:	00bd85b3          	add	a1,s11,a1
    80007d6c:	0005c583          	lbu	a1,0(a1)
    80007d70:	02d7d7bb          	divuw	a5,a5,a3
    80007d74:	f8b403a3          	sb	a1,-121(s0)
    80007d78:	42eb7e63          	bgeu	s6,a4,800081b4 <__printf+0x65c>
    80007d7c:	02d7f5bb          	remuw	a1,a5,a3
    80007d80:	02059593          	slli	a1,a1,0x20
    80007d84:	0205d593          	srli	a1,a1,0x20
    80007d88:	00bd85b3          	add	a1,s11,a1
    80007d8c:	0005c583          	lbu	a1,0(a1)
    80007d90:	02d7d7bb          	divuw	a5,a5,a3
    80007d94:	f8b40423          	sb	a1,-120(s0)
    80007d98:	42ebfc63          	bgeu	s7,a4,800081d0 <__printf+0x678>
    80007d9c:	02079793          	slli	a5,a5,0x20
    80007da0:	0207d793          	srli	a5,a5,0x20
    80007da4:	00fd8db3          	add	s11,s11,a5
    80007da8:	000dc703          	lbu	a4,0(s11)
    80007dac:	00a00793          	li	a5,10
    80007db0:	00900c93          	li	s9,9
    80007db4:	f8e404a3          	sb	a4,-119(s0)
    80007db8:	00065c63          	bgez	a2,80007dd0 <__printf+0x278>
    80007dbc:	f9040713          	addi	a4,s0,-112
    80007dc0:	00f70733          	add	a4,a4,a5
    80007dc4:	02d00693          	li	a3,45
    80007dc8:	fed70823          	sb	a3,-16(a4)
    80007dcc:	00078c93          	mv	s9,a5
    80007dd0:	f8040793          	addi	a5,s0,-128
    80007dd4:	01978cb3          	add	s9,a5,s9
    80007dd8:	f7f40d13          	addi	s10,s0,-129
    80007ddc:	000cc503          	lbu	a0,0(s9)
    80007de0:	fffc8c93          	addi	s9,s9,-1
    80007de4:	00000097          	auipc	ra,0x0
    80007de8:	b90080e7          	jalr	-1136(ra) # 80007974 <consputc>
    80007dec:	ffac98e3          	bne	s9,s10,80007ddc <__printf+0x284>
    80007df0:	00094503          	lbu	a0,0(s2)
    80007df4:	e00514e3          	bnez	a0,80007bfc <__printf+0xa4>
    80007df8:	1a0c1663          	bnez	s8,80007fa4 <__printf+0x44c>
    80007dfc:	08813083          	ld	ra,136(sp)
    80007e00:	08013403          	ld	s0,128(sp)
    80007e04:	07813483          	ld	s1,120(sp)
    80007e08:	07013903          	ld	s2,112(sp)
    80007e0c:	06813983          	ld	s3,104(sp)
    80007e10:	06013a03          	ld	s4,96(sp)
    80007e14:	05813a83          	ld	s5,88(sp)
    80007e18:	05013b03          	ld	s6,80(sp)
    80007e1c:	04813b83          	ld	s7,72(sp)
    80007e20:	04013c03          	ld	s8,64(sp)
    80007e24:	03813c83          	ld	s9,56(sp)
    80007e28:	03013d03          	ld	s10,48(sp)
    80007e2c:	02813d83          	ld	s11,40(sp)
    80007e30:	0d010113          	addi	sp,sp,208
    80007e34:	00008067          	ret
    80007e38:	07300713          	li	a4,115
    80007e3c:	1ce78a63          	beq	a5,a4,80008010 <__printf+0x4b8>
    80007e40:	07800713          	li	a4,120
    80007e44:	1ee79e63          	bne	a5,a4,80008040 <__printf+0x4e8>
    80007e48:	f7843783          	ld	a5,-136(s0)
    80007e4c:	0007a703          	lw	a4,0(a5)
    80007e50:	00878793          	addi	a5,a5,8
    80007e54:	f6f43c23          	sd	a5,-136(s0)
    80007e58:	28074263          	bltz	a4,800080dc <__printf+0x584>
    80007e5c:	00002d97          	auipc	s11,0x2
    80007e60:	accd8d93          	addi	s11,s11,-1332 # 80009928 <digits>
    80007e64:	00f77793          	andi	a5,a4,15
    80007e68:	00fd87b3          	add	a5,s11,a5
    80007e6c:	0007c683          	lbu	a3,0(a5)
    80007e70:	00f00613          	li	a2,15
    80007e74:	0007079b          	sext.w	a5,a4
    80007e78:	f8d40023          	sb	a3,-128(s0)
    80007e7c:	0047559b          	srliw	a1,a4,0x4
    80007e80:	0047569b          	srliw	a3,a4,0x4
    80007e84:	00000c93          	li	s9,0
    80007e88:	0ee65063          	bge	a2,a4,80007f68 <__printf+0x410>
    80007e8c:	00f6f693          	andi	a3,a3,15
    80007e90:	00dd86b3          	add	a3,s11,a3
    80007e94:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007e98:	0087d79b          	srliw	a5,a5,0x8
    80007e9c:	00100c93          	li	s9,1
    80007ea0:	f8d400a3          	sb	a3,-127(s0)
    80007ea4:	0cb67263          	bgeu	a2,a1,80007f68 <__printf+0x410>
    80007ea8:	00f7f693          	andi	a3,a5,15
    80007eac:	00dd86b3          	add	a3,s11,a3
    80007eb0:	0006c583          	lbu	a1,0(a3)
    80007eb4:	00f00613          	li	a2,15
    80007eb8:	0047d69b          	srliw	a3,a5,0x4
    80007ebc:	f8b40123          	sb	a1,-126(s0)
    80007ec0:	0047d593          	srli	a1,a5,0x4
    80007ec4:	28f67e63          	bgeu	a2,a5,80008160 <__printf+0x608>
    80007ec8:	00f6f693          	andi	a3,a3,15
    80007ecc:	00dd86b3          	add	a3,s11,a3
    80007ed0:	0006c503          	lbu	a0,0(a3)
    80007ed4:	0087d813          	srli	a6,a5,0x8
    80007ed8:	0087d69b          	srliw	a3,a5,0x8
    80007edc:	f8a401a3          	sb	a0,-125(s0)
    80007ee0:	28b67663          	bgeu	a2,a1,8000816c <__printf+0x614>
    80007ee4:	00f6f693          	andi	a3,a3,15
    80007ee8:	00dd86b3          	add	a3,s11,a3
    80007eec:	0006c583          	lbu	a1,0(a3)
    80007ef0:	00c7d513          	srli	a0,a5,0xc
    80007ef4:	00c7d69b          	srliw	a3,a5,0xc
    80007ef8:	f8b40223          	sb	a1,-124(s0)
    80007efc:	29067a63          	bgeu	a2,a6,80008190 <__printf+0x638>
    80007f00:	00f6f693          	andi	a3,a3,15
    80007f04:	00dd86b3          	add	a3,s11,a3
    80007f08:	0006c583          	lbu	a1,0(a3)
    80007f0c:	0107d813          	srli	a6,a5,0x10
    80007f10:	0107d69b          	srliw	a3,a5,0x10
    80007f14:	f8b402a3          	sb	a1,-123(s0)
    80007f18:	28a67263          	bgeu	a2,a0,8000819c <__printf+0x644>
    80007f1c:	00f6f693          	andi	a3,a3,15
    80007f20:	00dd86b3          	add	a3,s11,a3
    80007f24:	0006c683          	lbu	a3,0(a3)
    80007f28:	0147d79b          	srliw	a5,a5,0x14
    80007f2c:	f8d40323          	sb	a3,-122(s0)
    80007f30:	21067663          	bgeu	a2,a6,8000813c <__printf+0x5e4>
    80007f34:	02079793          	slli	a5,a5,0x20
    80007f38:	0207d793          	srli	a5,a5,0x20
    80007f3c:	00fd8db3          	add	s11,s11,a5
    80007f40:	000dc683          	lbu	a3,0(s11)
    80007f44:	00800793          	li	a5,8
    80007f48:	00700c93          	li	s9,7
    80007f4c:	f8d403a3          	sb	a3,-121(s0)
    80007f50:	00075c63          	bgez	a4,80007f68 <__printf+0x410>
    80007f54:	f9040713          	addi	a4,s0,-112
    80007f58:	00f70733          	add	a4,a4,a5
    80007f5c:	02d00693          	li	a3,45
    80007f60:	fed70823          	sb	a3,-16(a4)
    80007f64:	00078c93          	mv	s9,a5
    80007f68:	f8040793          	addi	a5,s0,-128
    80007f6c:	01978cb3          	add	s9,a5,s9
    80007f70:	f7f40d13          	addi	s10,s0,-129
    80007f74:	000cc503          	lbu	a0,0(s9)
    80007f78:	fffc8c93          	addi	s9,s9,-1
    80007f7c:	00000097          	auipc	ra,0x0
    80007f80:	9f8080e7          	jalr	-1544(ra) # 80007974 <consputc>
    80007f84:	ff9d18e3          	bne	s10,s9,80007f74 <__printf+0x41c>
    80007f88:	0100006f          	j	80007f98 <__printf+0x440>
    80007f8c:	00000097          	auipc	ra,0x0
    80007f90:	9e8080e7          	jalr	-1560(ra) # 80007974 <consputc>
    80007f94:	000c8493          	mv	s1,s9
    80007f98:	00094503          	lbu	a0,0(s2)
    80007f9c:	c60510e3          	bnez	a0,80007bfc <__printf+0xa4>
    80007fa0:	e40c0ee3          	beqz	s8,80007dfc <__printf+0x2a4>
    80007fa4:	00005517          	auipc	a0,0x5
    80007fa8:	53c50513          	addi	a0,a0,1340 # 8000d4e0 <pr>
    80007fac:	00001097          	auipc	ra,0x1
    80007fb0:	94c080e7          	jalr	-1716(ra) # 800088f8 <release>
    80007fb4:	e49ff06f          	j	80007dfc <__printf+0x2a4>
    80007fb8:	f7843783          	ld	a5,-136(s0)
    80007fbc:	03000513          	li	a0,48
    80007fc0:	01000d13          	li	s10,16
    80007fc4:	00878713          	addi	a4,a5,8
    80007fc8:	0007bc83          	ld	s9,0(a5)
    80007fcc:	f6e43c23          	sd	a4,-136(s0)
    80007fd0:	00000097          	auipc	ra,0x0
    80007fd4:	9a4080e7          	jalr	-1628(ra) # 80007974 <consputc>
    80007fd8:	07800513          	li	a0,120
    80007fdc:	00000097          	auipc	ra,0x0
    80007fe0:	998080e7          	jalr	-1640(ra) # 80007974 <consputc>
    80007fe4:	00002d97          	auipc	s11,0x2
    80007fe8:	944d8d93          	addi	s11,s11,-1724 # 80009928 <digits>
    80007fec:	03ccd793          	srli	a5,s9,0x3c
    80007ff0:	00fd87b3          	add	a5,s11,a5
    80007ff4:	0007c503          	lbu	a0,0(a5)
    80007ff8:	fffd0d1b          	addiw	s10,s10,-1
    80007ffc:	004c9c93          	slli	s9,s9,0x4
    80008000:	00000097          	auipc	ra,0x0
    80008004:	974080e7          	jalr	-1676(ra) # 80007974 <consputc>
    80008008:	fe0d12e3          	bnez	s10,80007fec <__printf+0x494>
    8000800c:	f8dff06f          	j	80007f98 <__printf+0x440>
    80008010:	f7843783          	ld	a5,-136(s0)
    80008014:	0007bc83          	ld	s9,0(a5)
    80008018:	00878793          	addi	a5,a5,8
    8000801c:	f6f43c23          	sd	a5,-136(s0)
    80008020:	000c9a63          	bnez	s9,80008034 <__printf+0x4dc>
    80008024:	1080006f          	j	8000812c <__printf+0x5d4>
    80008028:	001c8c93          	addi	s9,s9,1
    8000802c:	00000097          	auipc	ra,0x0
    80008030:	948080e7          	jalr	-1720(ra) # 80007974 <consputc>
    80008034:	000cc503          	lbu	a0,0(s9)
    80008038:	fe0518e3          	bnez	a0,80008028 <__printf+0x4d0>
    8000803c:	f5dff06f          	j	80007f98 <__printf+0x440>
    80008040:	02500513          	li	a0,37
    80008044:	00000097          	auipc	ra,0x0
    80008048:	930080e7          	jalr	-1744(ra) # 80007974 <consputc>
    8000804c:	000c8513          	mv	a0,s9
    80008050:	00000097          	auipc	ra,0x0
    80008054:	924080e7          	jalr	-1756(ra) # 80007974 <consputc>
    80008058:	f41ff06f          	j	80007f98 <__printf+0x440>
    8000805c:	02500513          	li	a0,37
    80008060:	00000097          	auipc	ra,0x0
    80008064:	914080e7          	jalr	-1772(ra) # 80007974 <consputc>
    80008068:	f31ff06f          	j	80007f98 <__printf+0x440>
    8000806c:	00030513          	mv	a0,t1
    80008070:	00000097          	auipc	ra,0x0
    80008074:	7bc080e7          	jalr	1980(ra) # 8000882c <acquire>
    80008078:	b4dff06f          	j	80007bc4 <__printf+0x6c>
    8000807c:	40c0053b          	negw	a0,a2
    80008080:	00a00713          	li	a4,10
    80008084:	02e576bb          	remuw	a3,a0,a4
    80008088:	00002d97          	auipc	s11,0x2
    8000808c:	8a0d8d93          	addi	s11,s11,-1888 # 80009928 <digits>
    80008090:	ff700593          	li	a1,-9
    80008094:	02069693          	slli	a3,a3,0x20
    80008098:	0206d693          	srli	a3,a3,0x20
    8000809c:	00dd86b3          	add	a3,s11,a3
    800080a0:	0006c683          	lbu	a3,0(a3)
    800080a4:	02e557bb          	divuw	a5,a0,a4
    800080a8:	f8d40023          	sb	a3,-128(s0)
    800080ac:	10b65e63          	bge	a2,a1,800081c8 <__printf+0x670>
    800080b0:	06300593          	li	a1,99
    800080b4:	02e7f6bb          	remuw	a3,a5,a4
    800080b8:	02069693          	slli	a3,a3,0x20
    800080bc:	0206d693          	srli	a3,a3,0x20
    800080c0:	00dd86b3          	add	a3,s11,a3
    800080c4:	0006c683          	lbu	a3,0(a3)
    800080c8:	02e7d73b          	divuw	a4,a5,a4
    800080cc:	00200793          	li	a5,2
    800080d0:	f8d400a3          	sb	a3,-127(s0)
    800080d4:	bca5ece3          	bltu	a1,a0,80007cac <__printf+0x154>
    800080d8:	ce5ff06f          	j	80007dbc <__printf+0x264>
    800080dc:	40e007bb          	negw	a5,a4
    800080e0:	00002d97          	auipc	s11,0x2
    800080e4:	848d8d93          	addi	s11,s11,-1976 # 80009928 <digits>
    800080e8:	00f7f693          	andi	a3,a5,15
    800080ec:	00dd86b3          	add	a3,s11,a3
    800080f0:	0006c583          	lbu	a1,0(a3)
    800080f4:	ff100613          	li	a2,-15
    800080f8:	0047d69b          	srliw	a3,a5,0x4
    800080fc:	f8b40023          	sb	a1,-128(s0)
    80008100:	0047d59b          	srliw	a1,a5,0x4
    80008104:	0ac75e63          	bge	a4,a2,800081c0 <__printf+0x668>
    80008108:	00f6f693          	andi	a3,a3,15
    8000810c:	00dd86b3          	add	a3,s11,a3
    80008110:	0006c603          	lbu	a2,0(a3)
    80008114:	00f00693          	li	a3,15
    80008118:	0087d79b          	srliw	a5,a5,0x8
    8000811c:	f8c400a3          	sb	a2,-127(s0)
    80008120:	d8b6e4e3          	bltu	a3,a1,80007ea8 <__printf+0x350>
    80008124:	00200793          	li	a5,2
    80008128:	e2dff06f          	j	80007f54 <__printf+0x3fc>
    8000812c:	00001c97          	auipc	s9,0x1
    80008130:	7dcc8c93          	addi	s9,s9,2012 # 80009908 <CONSOLE_STATUS+0x8f8>
    80008134:	02800513          	li	a0,40
    80008138:	ef1ff06f          	j	80008028 <__printf+0x4d0>
    8000813c:	00700793          	li	a5,7
    80008140:	00600c93          	li	s9,6
    80008144:	e0dff06f          	j	80007f50 <__printf+0x3f8>
    80008148:	00700793          	li	a5,7
    8000814c:	00600c93          	li	s9,6
    80008150:	c69ff06f          	j	80007db8 <__printf+0x260>
    80008154:	00300793          	li	a5,3
    80008158:	00200c93          	li	s9,2
    8000815c:	c5dff06f          	j	80007db8 <__printf+0x260>
    80008160:	00300793          	li	a5,3
    80008164:	00200c93          	li	s9,2
    80008168:	de9ff06f          	j	80007f50 <__printf+0x3f8>
    8000816c:	00400793          	li	a5,4
    80008170:	00300c93          	li	s9,3
    80008174:	dddff06f          	j	80007f50 <__printf+0x3f8>
    80008178:	00400793          	li	a5,4
    8000817c:	00300c93          	li	s9,3
    80008180:	c39ff06f          	j	80007db8 <__printf+0x260>
    80008184:	00500793          	li	a5,5
    80008188:	00400c93          	li	s9,4
    8000818c:	c2dff06f          	j	80007db8 <__printf+0x260>
    80008190:	00500793          	li	a5,5
    80008194:	00400c93          	li	s9,4
    80008198:	db9ff06f          	j	80007f50 <__printf+0x3f8>
    8000819c:	00600793          	li	a5,6
    800081a0:	00500c93          	li	s9,5
    800081a4:	dadff06f          	j	80007f50 <__printf+0x3f8>
    800081a8:	00600793          	li	a5,6
    800081ac:	00500c93          	li	s9,5
    800081b0:	c09ff06f          	j	80007db8 <__printf+0x260>
    800081b4:	00800793          	li	a5,8
    800081b8:	00700c93          	li	s9,7
    800081bc:	bfdff06f          	j	80007db8 <__printf+0x260>
    800081c0:	00100793          	li	a5,1
    800081c4:	d91ff06f          	j	80007f54 <__printf+0x3fc>
    800081c8:	00100793          	li	a5,1
    800081cc:	bf1ff06f          	j	80007dbc <__printf+0x264>
    800081d0:	00900793          	li	a5,9
    800081d4:	00800c93          	li	s9,8
    800081d8:	be1ff06f          	j	80007db8 <__printf+0x260>
    800081dc:	00001517          	auipc	a0,0x1
    800081e0:	73450513          	addi	a0,a0,1844 # 80009910 <CONSOLE_STATUS+0x900>
    800081e4:	00000097          	auipc	ra,0x0
    800081e8:	918080e7          	jalr	-1768(ra) # 80007afc <panic>

00000000800081ec <printfinit>:
    800081ec:	fe010113          	addi	sp,sp,-32
    800081f0:	00813823          	sd	s0,16(sp)
    800081f4:	00913423          	sd	s1,8(sp)
    800081f8:	00113c23          	sd	ra,24(sp)
    800081fc:	02010413          	addi	s0,sp,32
    80008200:	00005497          	auipc	s1,0x5
    80008204:	2e048493          	addi	s1,s1,736 # 8000d4e0 <pr>
    80008208:	00048513          	mv	a0,s1
    8000820c:	00001597          	auipc	a1,0x1
    80008210:	71458593          	addi	a1,a1,1812 # 80009920 <CONSOLE_STATUS+0x910>
    80008214:	00000097          	auipc	ra,0x0
    80008218:	5f4080e7          	jalr	1524(ra) # 80008808 <initlock>
    8000821c:	01813083          	ld	ra,24(sp)
    80008220:	01013403          	ld	s0,16(sp)
    80008224:	0004ac23          	sw	zero,24(s1)
    80008228:	00813483          	ld	s1,8(sp)
    8000822c:	02010113          	addi	sp,sp,32
    80008230:	00008067          	ret

0000000080008234 <uartinit>:
    80008234:	ff010113          	addi	sp,sp,-16
    80008238:	00813423          	sd	s0,8(sp)
    8000823c:	01010413          	addi	s0,sp,16
    80008240:	100007b7          	lui	a5,0x10000
    80008244:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008248:	f8000713          	li	a4,-128
    8000824c:	00e781a3          	sb	a4,3(a5)
    80008250:	00300713          	li	a4,3
    80008254:	00e78023          	sb	a4,0(a5)
    80008258:	000780a3          	sb	zero,1(a5)
    8000825c:	00e781a3          	sb	a4,3(a5)
    80008260:	00700693          	li	a3,7
    80008264:	00d78123          	sb	a3,2(a5)
    80008268:	00e780a3          	sb	a4,1(a5)
    8000826c:	00813403          	ld	s0,8(sp)
    80008270:	01010113          	addi	sp,sp,16
    80008274:	00008067          	ret

0000000080008278 <uartputc>:
    80008278:	00004797          	auipc	a5,0x4
    8000827c:	db07a783          	lw	a5,-592(a5) # 8000c028 <panicked>
    80008280:	00078463          	beqz	a5,80008288 <uartputc+0x10>
    80008284:	0000006f          	j	80008284 <uartputc+0xc>
    80008288:	fd010113          	addi	sp,sp,-48
    8000828c:	02813023          	sd	s0,32(sp)
    80008290:	00913c23          	sd	s1,24(sp)
    80008294:	01213823          	sd	s2,16(sp)
    80008298:	01313423          	sd	s3,8(sp)
    8000829c:	02113423          	sd	ra,40(sp)
    800082a0:	03010413          	addi	s0,sp,48
    800082a4:	00004917          	auipc	s2,0x4
    800082a8:	d8c90913          	addi	s2,s2,-628 # 8000c030 <uart_tx_r>
    800082ac:	00093783          	ld	a5,0(s2)
    800082b0:	00004497          	auipc	s1,0x4
    800082b4:	d8848493          	addi	s1,s1,-632 # 8000c038 <uart_tx_w>
    800082b8:	0004b703          	ld	a4,0(s1)
    800082bc:	02078693          	addi	a3,a5,32
    800082c0:	00050993          	mv	s3,a0
    800082c4:	02e69c63          	bne	a3,a4,800082fc <uartputc+0x84>
    800082c8:	00001097          	auipc	ra,0x1
    800082cc:	834080e7          	jalr	-1996(ra) # 80008afc <push_on>
    800082d0:	00093783          	ld	a5,0(s2)
    800082d4:	0004b703          	ld	a4,0(s1)
    800082d8:	02078793          	addi	a5,a5,32
    800082dc:	00e79463          	bne	a5,a4,800082e4 <uartputc+0x6c>
    800082e0:	0000006f          	j	800082e0 <uartputc+0x68>
    800082e4:	00001097          	auipc	ra,0x1
    800082e8:	88c080e7          	jalr	-1908(ra) # 80008b70 <pop_on>
    800082ec:	00093783          	ld	a5,0(s2)
    800082f0:	0004b703          	ld	a4,0(s1)
    800082f4:	02078693          	addi	a3,a5,32
    800082f8:	fce688e3          	beq	a3,a4,800082c8 <uartputc+0x50>
    800082fc:	01f77693          	andi	a3,a4,31
    80008300:	00005597          	auipc	a1,0x5
    80008304:	20058593          	addi	a1,a1,512 # 8000d500 <uart_tx_buf>
    80008308:	00d586b3          	add	a3,a1,a3
    8000830c:	00170713          	addi	a4,a4,1
    80008310:	01368023          	sb	s3,0(a3)
    80008314:	00e4b023          	sd	a4,0(s1)
    80008318:	10000637          	lui	a2,0x10000
    8000831c:	02f71063          	bne	a4,a5,8000833c <uartputc+0xc4>
    80008320:	0340006f          	j	80008354 <uartputc+0xdc>
    80008324:	00074703          	lbu	a4,0(a4)
    80008328:	00f93023          	sd	a5,0(s2)
    8000832c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008330:	00093783          	ld	a5,0(s2)
    80008334:	0004b703          	ld	a4,0(s1)
    80008338:	00f70e63          	beq	a4,a5,80008354 <uartputc+0xdc>
    8000833c:	00564683          	lbu	a3,5(a2)
    80008340:	01f7f713          	andi	a4,a5,31
    80008344:	00e58733          	add	a4,a1,a4
    80008348:	0206f693          	andi	a3,a3,32
    8000834c:	00178793          	addi	a5,a5,1
    80008350:	fc069ae3          	bnez	a3,80008324 <uartputc+0xac>
    80008354:	02813083          	ld	ra,40(sp)
    80008358:	02013403          	ld	s0,32(sp)
    8000835c:	01813483          	ld	s1,24(sp)
    80008360:	01013903          	ld	s2,16(sp)
    80008364:	00813983          	ld	s3,8(sp)
    80008368:	03010113          	addi	sp,sp,48
    8000836c:	00008067          	ret

0000000080008370 <uartputc_sync>:
    80008370:	ff010113          	addi	sp,sp,-16
    80008374:	00813423          	sd	s0,8(sp)
    80008378:	01010413          	addi	s0,sp,16
    8000837c:	00004717          	auipc	a4,0x4
    80008380:	cac72703          	lw	a4,-852(a4) # 8000c028 <panicked>
    80008384:	02071663          	bnez	a4,800083b0 <uartputc_sync+0x40>
    80008388:	00050793          	mv	a5,a0
    8000838c:	100006b7          	lui	a3,0x10000
    80008390:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008394:	02077713          	andi	a4,a4,32
    80008398:	fe070ce3          	beqz	a4,80008390 <uartputc_sync+0x20>
    8000839c:	0ff7f793          	andi	a5,a5,255
    800083a0:	00f68023          	sb	a5,0(a3)
    800083a4:	00813403          	ld	s0,8(sp)
    800083a8:	01010113          	addi	sp,sp,16
    800083ac:	00008067          	ret
    800083b0:	0000006f          	j	800083b0 <uartputc_sync+0x40>

00000000800083b4 <uartstart>:
    800083b4:	ff010113          	addi	sp,sp,-16
    800083b8:	00813423          	sd	s0,8(sp)
    800083bc:	01010413          	addi	s0,sp,16
    800083c0:	00004617          	auipc	a2,0x4
    800083c4:	c7060613          	addi	a2,a2,-912 # 8000c030 <uart_tx_r>
    800083c8:	00004517          	auipc	a0,0x4
    800083cc:	c7050513          	addi	a0,a0,-912 # 8000c038 <uart_tx_w>
    800083d0:	00063783          	ld	a5,0(a2)
    800083d4:	00053703          	ld	a4,0(a0)
    800083d8:	04f70263          	beq	a4,a5,8000841c <uartstart+0x68>
    800083dc:	100005b7          	lui	a1,0x10000
    800083e0:	00005817          	auipc	a6,0x5
    800083e4:	12080813          	addi	a6,a6,288 # 8000d500 <uart_tx_buf>
    800083e8:	01c0006f          	j	80008404 <uartstart+0x50>
    800083ec:	0006c703          	lbu	a4,0(a3)
    800083f0:	00f63023          	sd	a5,0(a2)
    800083f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800083f8:	00063783          	ld	a5,0(a2)
    800083fc:	00053703          	ld	a4,0(a0)
    80008400:	00f70e63          	beq	a4,a5,8000841c <uartstart+0x68>
    80008404:	01f7f713          	andi	a4,a5,31
    80008408:	00e806b3          	add	a3,a6,a4
    8000840c:	0055c703          	lbu	a4,5(a1)
    80008410:	00178793          	addi	a5,a5,1
    80008414:	02077713          	andi	a4,a4,32
    80008418:	fc071ae3          	bnez	a4,800083ec <uartstart+0x38>
    8000841c:	00813403          	ld	s0,8(sp)
    80008420:	01010113          	addi	sp,sp,16
    80008424:	00008067          	ret

0000000080008428 <uartgetc>:
    80008428:	ff010113          	addi	sp,sp,-16
    8000842c:	00813423          	sd	s0,8(sp)
    80008430:	01010413          	addi	s0,sp,16
    80008434:	10000737          	lui	a4,0x10000
    80008438:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000843c:	0017f793          	andi	a5,a5,1
    80008440:	00078c63          	beqz	a5,80008458 <uartgetc+0x30>
    80008444:	00074503          	lbu	a0,0(a4)
    80008448:	0ff57513          	andi	a0,a0,255
    8000844c:	00813403          	ld	s0,8(sp)
    80008450:	01010113          	addi	sp,sp,16
    80008454:	00008067          	ret
    80008458:	fff00513          	li	a0,-1
    8000845c:	ff1ff06f          	j	8000844c <uartgetc+0x24>

0000000080008460 <uartintr>:
    80008460:	100007b7          	lui	a5,0x10000
    80008464:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008468:	0017f793          	andi	a5,a5,1
    8000846c:	0a078463          	beqz	a5,80008514 <uartintr+0xb4>
    80008470:	fe010113          	addi	sp,sp,-32
    80008474:	00813823          	sd	s0,16(sp)
    80008478:	00913423          	sd	s1,8(sp)
    8000847c:	00113c23          	sd	ra,24(sp)
    80008480:	02010413          	addi	s0,sp,32
    80008484:	100004b7          	lui	s1,0x10000
    80008488:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000848c:	0ff57513          	andi	a0,a0,255
    80008490:	fffff097          	auipc	ra,0xfffff
    80008494:	534080e7          	jalr	1332(ra) # 800079c4 <consoleintr>
    80008498:	0054c783          	lbu	a5,5(s1)
    8000849c:	0017f793          	andi	a5,a5,1
    800084a0:	fe0794e3          	bnez	a5,80008488 <uartintr+0x28>
    800084a4:	00004617          	auipc	a2,0x4
    800084a8:	b8c60613          	addi	a2,a2,-1140 # 8000c030 <uart_tx_r>
    800084ac:	00004517          	auipc	a0,0x4
    800084b0:	b8c50513          	addi	a0,a0,-1140 # 8000c038 <uart_tx_w>
    800084b4:	00063783          	ld	a5,0(a2)
    800084b8:	00053703          	ld	a4,0(a0)
    800084bc:	04f70263          	beq	a4,a5,80008500 <uartintr+0xa0>
    800084c0:	100005b7          	lui	a1,0x10000
    800084c4:	00005817          	auipc	a6,0x5
    800084c8:	03c80813          	addi	a6,a6,60 # 8000d500 <uart_tx_buf>
    800084cc:	01c0006f          	j	800084e8 <uartintr+0x88>
    800084d0:	0006c703          	lbu	a4,0(a3)
    800084d4:	00f63023          	sd	a5,0(a2)
    800084d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800084dc:	00063783          	ld	a5,0(a2)
    800084e0:	00053703          	ld	a4,0(a0)
    800084e4:	00f70e63          	beq	a4,a5,80008500 <uartintr+0xa0>
    800084e8:	01f7f713          	andi	a4,a5,31
    800084ec:	00e806b3          	add	a3,a6,a4
    800084f0:	0055c703          	lbu	a4,5(a1)
    800084f4:	00178793          	addi	a5,a5,1
    800084f8:	02077713          	andi	a4,a4,32
    800084fc:	fc071ae3          	bnez	a4,800084d0 <uartintr+0x70>
    80008500:	01813083          	ld	ra,24(sp)
    80008504:	01013403          	ld	s0,16(sp)
    80008508:	00813483          	ld	s1,8(sp)
    8000850c:	02010113          	addi	sp,sp,32
    80008510:	00008067          	ret
    80008514:	00004617          	auipc	a2,0x4
    80008518:	b1c60613          	addi	a2,a2,-1252 # 8000c030 <uart_tx_r>
    8000851c:	00004517          	auipc	a0,0x4
    80008520:	b1c50513          	addi	a0,a0,-1252 # 8000c038 <uart_tx_w>
    80008524:	00063783          	ld	a5,0(a2)
    80008528:	00053703          	ld	a4,0(a0)
    8000852c:	04f70263          	beq	a4,a5,80008570 <uartintr+0x110>
    80008530:	100005b7          	lui	a1,0x10000
    80008534:	00005817          	auipc	a6,0x5
    80008538:	fcc80813          	addi	a6,a6,-52 # 8000d500 <uart_tx_buf>
    8000853c:	01c0006f          	j	80008558 <uartintr+0xf8>
    80008540:	0006c703          	lbu	a4,0(a3)
    80008544:	00f63023          	sd	a5,0(a2)
    80008548:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000854c:	00063783          	ld	a5,0(a2)
    80008550:	00053703          	ld	a4,0(a0)
    80008554:	02f70063          	beq	a4,a5,80008574 <uartintr+0x114>
    80008558:	01f7f713          	andi	a4,a5,31
    8000855c:	00e806b3          	add	a3,a6,a4
    80008560:	0055c703          	lbu	a4,5(a1)
    80008564:	00178793          	addi	a5,a5,1
    80008568:	02077713          	andi	a4,a4,32
    8000856c:	fc071ae3          	bnez	a4,80008540 <uartintr+0xe0>
    80008570:	00008067          	ret
    80008574:	00008067          	ret

0000000080008578 <kinit>:
    80008578:	fc010113          	addi	sp,sp,-64
    8000857c:	02913423          	sd	s1,40(sp)
    80008580:	fffff7b7          	lui	a5,0xfffff
    80008584:	00006497          	auipc	s1,0x6
    80008588:	f9b48493          	addi	s1,s1,-101 # 8000e51f <end+0xfff>
    8000858c:	02813823          	sd	s0,48(sp)
    80008590:	01313c23          	sd	s3,24(sp)
    80008594:	00f4f4b3          	and	s1,s1,a5
    80008598:	02113c23          	sd	ra,56(sp)
    8000859c:	03213023          	sd	s2,32(sp)
    800085a0:	01413823          	sd	s4,16(sp)
    800085a4:	01513423          	sd	s5,8(sp)
    800085a8:	04010413          	addi	s0,sp,64
    800085ac:	000017b7          	lui	a5,0x1
    800085b0:	01100993          	li	s3,17
    800085b4:	00f487b3          	add	a5,s1,a5
    800085b8:	01b99993          	slli	s3,s3,0x1b
    800085bc:	06f9e063          	bltu	s3,a5,8000861c <kinit+0xa4>
    800085c0:	00005a97          	auipc	s5,0x5
    800085c4:	f60a8a93          	addi	s5,s5,-160 # 8000d520 <end>
    800085c8:	0754ec63          	bltu	s1,s5,80008640 <kinit+0xc8>
    800085cc:	0734fa63          	bgeu	s1,s3,80008640 <kinit+0xc8>
    800085d0:	00088a37          	lui	s4,0x88
    800085d4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800085d8:	00004917          	auipc	s2,0x4
    800085dc:	a6890913          	addi	s2,s2,-1432 # 8000c040 <kmem>
    800085e0:	00ca1a13          	slli	s4,s4,0xc
    800085e4:	0140006f          	j	800085f8 <kinit+0x80>
    800085e8:	000017b7          	lui	a5,0x1
    800085ec:	00f484b3          	add	s1,s1,a5
    800085f0:	0554e863          	bltu	s1,s5,80008640 <kinit+0xc8>
    800085f4:	0534f663          	bgeu	s1,s3,80008640 <kinit+0xc8>
    800085f8:	00001637          	lui	a2,0x1
    800085fc:	00100593          	li	a1,1
    80008600:	00048513          	mv	a0,s1
    80008604:	00000097          	auipc	ra,0x0
    80008608:	5e4080e7          	jalr	1508(ra) # 80008be8 <__memset>
    8000860c:	00093783          	ld	a5,0(s2)
    80008610:	00f4b023          	sd	a5,0(s1)
    80008614:	00993023          	sd	s1,0(s2)
    80008618:	fd4498e3          	bne	s1,s4,800085e8 <kinit+0x70>
    8000861c:	03813083          	ld	ra,56(sp)
    80008620:	03013403          	ld	s0,48(sp)
    80008624:	02813483          	ld	s1,40(sp)
    80008628:	02013903          	ld	s2,32(sp)
    8000862c:	01813983          	ld	s3,24(sp)
    80008630:	01013a03          	ld	s4,16(sp)
    80008634:	00813a83          	ld	s5,8(sp)
    80008638:	04010113          	addi	sp,sp,64
    8000863c:	00008067          	ret
    80008640:	00001517          	auipc	a0,0x1
    80008644:	30050513          	addi	a0,a0,768 # 80009940 <digits+0x18>
    80008648:	fffff097          	auipc	ra,0xfffff
    8000864c:	4b4080e7          	jalr	1204(ra) # 80007afc <panic>

0000000080008650 <freerange>:
    80008650:	fc010113          	addi	sp,sp,-64
    80008654:	000017b7          	lui	a5,0x1
    80008658:	02913423          	sd	s1,40(sp)
    8000865c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80008660:	009504b3          	add	s1,a0,s1
    80008664:	fffff537          	lui	a0,0xfffff
    80008668:	02813823          	sd	s0,48(sp)
    8000866c:	02113c23          	sd	ra,56(sp)
    80008670:	03213023          	sd	s2,32(sp)
    80008674:	01313c23          	sd	s3,24(sp)
    80008678:	01413823          	sd	s4,16(sp)
    8000867c:	01513423          	sd	s5,8(sp)
    80008680:	01613023          	sd	s6,0(sp)
    80008684:	04010413          	addi	s0,sp,64
    80008688:	00a4f4b3          	and	s1,s1,a0
    8000868c:	00f487b3          	add	a5,s1,a5
    80008690:	06f5e463          	bltu	a1,a5,800086f8 <freerange+0xa8>
    80008694:	00005a97          	auipc	s5,0x5
    80008698:	e8ca8a93          	addi	s5,s5,-372 # 8000d520 <end>
    8000869c:	0954e263          	bltu	s1,s5,80008720 <freerange+0xd0>
    800086a0:	01100993          	li	s3,17
    800086a4:	01b99993          	slli	s3,s3,0x1b
    800086a8:	0734fc63          	bgeu	s1,s3,80008720 <freerange+0xd0>
    800086ac:	00058a13          	mv	s4,a1
    800086b0:	00004917          	auipc	s2,0x4
    800086b4:	99090913          	addi	s2,s2,-1648 # 8000c040 <kmem>
    800086b8:	00002b37          	lui	s6,0x2
    800086bc:	0140006f          	j	800086d0 <freerange+0x80>
    800086c0:	000017b7          	lui	a5,0x1
    800086c4:	00f484b3          	add	s1,s1,a5
    800086c8:	0554ec63          	bltu	s1,s5,80008720 <freerange+0xd0>
    800086cc:	0534fa63          	bgeu	s1,s3,80008720 <freerange+0xd0>
    800086d0:	00001637          	lui	a2,0x1
    800086d4:	00100593          	li	a1,1
    800086d8:	00048513          	mv	a0,s1
    800086dc:	00000097          	auipc	ra,0x0
    800086e0:	50c080e7          	jalr	1292(ra) # 80008be8 <__memset>
    800086e4:	00093703          	ld	a4,0(s2)
    800086e8:	016487b3          	add	a5,s1,s6
    800086ec:	00e4b023          	sd	a4,0(s1)
    800086f0:	00993023          	sd	s1,0(s2)
    800086f4:	fcfa76e3          	bgeu	s4,a5,800086c0 <freerange+0x70>
    800086f8:	03813083          	ld	ra,56(sp)
    800086fc:	03013403          	ld	s0,48(sp)
    80008700:	02813483          	ld	s1,40(sp)
    80008704:	02013903          	ld	s2,32(sp)
    80008708:	01813983          	ld	s3,24(sp)
    8000870c:	01013a03          	ld	s4,16(sp)
    80008710:	00813a83          	ld	s5,8(sp)
    80008714:	00013b03          	ld	s6,0(sp)
    80008718:	04010113          	addi	sp,sp,64
    8000871c:	00008067          	ret
    80008720:	00001517          	auipc	a0,0x1
    80008724:	22050513          	addi	a0,a0,544 # 80009940 <digits+0x18>
    80008728:	fffff097          	auipc	ra,0xfffff
    8000872c:	3d4080e7          	jalr	980(ra) # 80007afc <panic>

0000000080008730 <kfree>:
    80008730:	fe010113          	addi	sp,sp,-32
    80008734:	00813823          	sd	s0,16(sp)
    80008738:	00113c23          	sd	ra,24(sp)
    8000873c:	00913423          	sd	s1,8(sp)
    80008740:	02010413          	addi	s0,sp,32
    80008744:	03451793          	slli	a5,a0,0x34
    80008748:	04079c63          	bnez	a5,800087a0 <kfree+0x70>
    8000874c:	00005797          	auipc	a5,0x5
    80008750:	dd478793          	addi	a5,a5,-556 # 8000d520 <end>
    80008754:	00050493          	mv	s1,a0
    80008758:	04f56463          	bltu	a0,a5,800087a0 <kfree+0x70>
    8000875c:	01100793          	li	a5,17
    80008760:	01b79793          	slli	a5,a5,0x1b
    80008764:	02f57e63          	bgeu	a0,a5,800087a0 <kfree+0x70>
    80008768:	00001637          	lui	a2,0x1
    8000876c:	00100593          	li	a1,1
    80008770:	00000097          	auipc	ra,0x0
    80008774:	478080e7          	jalr	1144(ra) # 80008be8 <__memset>
    80008778:	00004797          	auipc	a5,0x4
    8000877c:	8c878793          	addi	a5,a5,-1848 # 8000c040 <kmem>
    80008780:	0007b703          	ld	a4,0(a5)
    80008784:	01813083          	ld	ra,24(sp)
    80008788:	01013403          	ld	s0,16(sp)
    8000878c:	00e4b023          	sd	a4,0(s1)
    80008790:	0097b023          	sd	s1,0(a5)
    80008794:	00813483          	ld	s1,8(sp)
    80008798:	02010113          	addi	sp,sp,32
    8000879c:	00008067          	ret
    800087a0:	00001517          	auipc	a0,0x1
    800087a4:	1a050513          	addi	a0,a0,416 # 80009940 <digits+0x18>
    800087a8:	fffff097          	auipc	ra,0xfffff
    800087ac:	354080e7          	jalr	852(ra) # 80007afc <panic>

00000000800087b0 <kalloc>:
    800087b0:	fe010113          	addi	sp,sp,-32
    800087b4:	00813823          	sd	s0,16(sp)
    800087b8:	00913423          	sd	s1,8(sp)
    800087bc:	00113c23          	sd	ra,24(sp)
    800087c0:	02010413          	addi	s0,sp,32
    800087c4:	00004797          	auipc	a5,0x4
    800087c8:	87c78793          	addi	a5,a5,-1924 # 8000c040 <kmem>
    800087cc:	0007b483          	ld	s1,0(a5)
    800087d0:	02048063          	beqz	s1,800087f0 <kalloc+0x40>
    800087d4:	0004b703          	ld	a4,0(s1)
    800087d8:	00001637          	lui	a2,0x1
    800087dc:	00500593          	li	a1,5
    800087e0:	00048513          	mv	a0,s1
    800087e4:	00e7b023          	sd	a4,0(a5)
    800087e8:	00000097          	auipc	ra,0x0
    800087ec:	400080e7          	jalr	1024(ra) # 80008be8 <__memset>
    800087f0:	01813083          	ld	ra,24(sp)
    800087f4:	01013403          	ld	s0,16(sp)
    800087f8:	00048513          	mv	a0,s1
    800087fc:	00813483          	ld	s1,8(sp)
    80008800:	02010113          	addi	sp,sp,32
    80008804:	00008067          	ret

0000000080008808 <initlock>:
    80008808:	ff010113          	addi	sp,sp,-16
    8000880c:	00813423          	sd	s0,8(sp)
    80008810:	01010413          	addi	s0,sp,16
    80008814:	00813403          	ld	s0,8(sp)
    80008818:	00b53423          	sd	a1,8(a0)
    8000881c:	00052023          	sw	zero,0(a0)
    80008820:	00053823          	sd	zero,16(a0)
    80008824:	01010113          	addi	sp,sp,16
    80008828:	00008067          	ret

000000008000882c <acquire>:
    8000882c:	fe010113          	addi	sp,sp,-32
    80008830:	00813823          	sd	s0,16(sp)
    80008834:	00913423          	sd	s1,8(sp)
    80008838:	00113c23          	sd	ra,24(sp)
    8000883c:	01213023          	sd	s2,0(sp)
    80008840:	02010413          	addi	s0,sp,32
    80008844:	00050493          	mv	s1,a0
    80008848:	10002973          	csrr	s2,sstatus
    8000884c:	100027f3          	csrr	a5,sstatus
    80008850:	ffd7f793          	andi	a5,a5,-3
    80008854:	10079073          	csrw	sstatus,a5
    80008858:	fffff097          	auipc	ra,0xfffff
    8000885c:	8e8080e7          	jalr	-1816(ra) # 80007140 <mycpu>
    80008860:	07852783          	lw	a5,120(a0)
    80008864:	06078e63          	beqz	a5,800088e0 <acquire+0xb4>
    80008868:	fffff097          	auipc	ra,0xfffff
    8000886c:	8d8080e7          	jalr	-1832(ra) # 80007140 <mycpu>
    80008870:	07852783          	lw	a5,120(a0)
    80008874:	0004a703          	lw	a4,0(s1)
    80008878:	0017879b          	addiw	a5,a5,1
    8000887c:	06f52c23          	sw	a5,120(a0)
    80008880:	04071063          	bnez	a4,800088c0 <acquire+0x94>
    80008884:	00100713          	li	a4,1
    80008888:	00070793          	mv	a5,a4
    8000888c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008890:	0007879b          	sext.w	a5,a5
    80008894:	fe079ae3          	bnez	a5,80008888 <acquire+0x5c>
    80008898:	0ff0000f          	fence
    8000889c:	fffff097          	auipc	ra,0xfffff
    800088a0:	8a4080e7          	jalr	-1884(ra) # 80007140 <mycpu>
    800088a4:	01813083          	ld	ra,24(sp)
    800088a8:	01013403          	ld	s0,16(sp)
    800088ac:	00a4b823          	sd	a0,16(s1)
    800088b0:	00013903          	ld	s2,0(sp)
    800088b4:	00813483          	ld	s1,8(sp)
    800088b8:	02010113          	addi	sp,sp,32
    800088bc:	00008067          	ret
    800088c0:	0104b903          	ld	s2,16(s1)
    800088c4:	fffff097          	auipc	ra,0xfffff
    800088c8:	87c080e7          	jalr	-1924(ra) # 80007140 <mycpu>
    800088cc:	faa91ce3          	bne	s2,a0,80008884 <acquire+0x58>
    800088d0:	00001517          	auipc	a0,0x1
    800088d4:	07850513          	addi	a0,a0,120 # 80009948 <digits+0x20>
    800088d8:	fffff097          	auipc	ra,0xfffff
    800088dc:	224080e7          	jalr	548(ra) # 80007afc <panic>
    800088e0:	00195913          	srli	s2,s2,0x1
    800088e4:	fffff097          	auipc	ra,0xfffff
    800088e8:	85c080e7          	jalr	-1956(ra) # 80007140 <mycpu>
    800088ec:	00197913          	andi	s2,s2,1
    800088f0:	07252e23          	sw	s2,124(a0)
    800088f4:	f75ff06f          	j	80008868 <acquire+0x3c>

00000000800088f8 <release>:
    800088f8:	fe010113          	addi	sp,sp,-32
    800088fc:	00813823          	sd	s0,16(sp)
    80008900:	00113c23          	sd	ra,24(sp)
    80008904:	00913423          	sd	s1,8(sp)
    80008908:	01213023          	sd	s2,0(sp)
    8000890c:	02010413          	addi	s0,sp,32
    80008910:	00052783          	lw	a5,0(a0)
    80008914:	00079a63          	bnez	a5,80008928 <release+0x30>
    80008918:	00001517          	auipc	a0,0x1
    8000891c:	03850513          	addi	a0,a0,56 # 80009950 <digits+0x28>
    80008920:	fffff097          	auipc	ra,0xfffff
    80008924:	1dc080e7          	jalr	476(ra) # 80007afc <panic>
    80008928:	01053903          	ld	s2,16(a0)
    8000892c:	00050493          	mv	s1,a0
    80008930:	fffff097          	auipc	ra,0xfffff
    80008934:	810080e7          	jalr	-2032(ra) # 80007140 <mycpu>
    80008938:	fea910e3          	bne	s2,a0,80008918 <release+0x20>
    8000893c:	0004b823          	sd	zero,16(s1)
    80008940:	0ff0000f          	fence
    80008944:	0f50000f          	fence	iorw,ow
    80008948:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000894c:	ffffe097          	auipc	ra,0xffffe
    80008950:	7f4080e7          	jalr	2036(ra) # 80007140 <mycpu>
    80008954:	100027f3          	csrr	a5,sstatus
    80008958:	0027f793          	andi	a5,a5,2
    8000895c:	04079a63          	bnez	a5,800089b0 <release+0xb8>
    80008960:	07852783          	lw	a5,120(a0)
    80008964:	02f05e63          	blez	a5,800089a0 <release+0xa8>
    80008968:	fff7871b          	addiw	a4,a5,-1
    8000896c:	06e52c23          	sw	a4,120(a0)
    80008970:	00071c63          	bnez	a4,80008988 <release+0x90>
    80008974:	07c52783          	lw	a5,124(a0)
    80008978:	00078863          	beqz	a5,80008988 <release+0x90>
    8000897c:	100027f3          	csrr	a5,sstatus
    80008980:	0027e793          	ori	a5,a5,2
    80008984:	10079073          	csrw	sstatus,a5
    80008988:	01813083          	ld	ra,24(sp)
    8000898c:	01013403          	ld	s0,16(sp)
    80008990:	00813483          	ld	s1,8(sp)
    80008994:	00013903          	ld	s2,0(sp)
    80008998:	02010113          	addi	sp,sp,32
    8000899c:	00008067          	ret
    800089a0:	00001517          	auipc	a0,0x1
    800089a4:	fd050513          	addi	a0,a0,-48 # 80009970 <digits+0x48>
    800089a8:	fffff097          	auipc	ra,0xfffff
    800089ac:	154080e7          	jalr	340(ra) # 80007afc <panic>
    800089b0:	00001517          	auipc	a0,0x1
    800089b4:	fa850513          	addi	a0,a0,-88 # 80009958 <digits+0x30>
    800089b8:	fffff097          	auipc	ra,0xfffff
    800089bc:	144080e7          	jalr	324(ra) # 80007afc <panic>

00000000800089c0 <holding>:
    800089c0:	00052783          	lw	a5,0(a0)
    800089c4:	00079663          	bnez	a5,800089d0 <holding+0x10>
    800089c8:	00000513          	li	a0,0
    800089cc:	00008067          	ret
    800089d0:	fe010113          	addi	sp,sp,-32
    800089d4:	00813823          	sd	s0,16(sp)
    800089d8:	00913423          	sd	s1,8(sp)
    800089dc:	00113c23          	sd	ra,24(sp)
    800089e0:	02010413          	addi	s0,sp,32
    800089e4:	01053483          	ld	s1,16(a0)
    800089e8:	ffffe097          	auipc	ra,0xffffe
    800089ec:	758080e7          	jalr	1880(ra) # 80007140 <mycpu>
    800089f0:	01813083          	ld	ra,24(sp)
    800089f4:	01013403          	ld	s0,16(sp)
    800089f8:	40a48533          	sub	a0,s1,a0
    800089fc:	00153513          	seqz	a0,a0
    80008a00:	00813483          	ld	s1,8(sp)
    80008a04:	02010113          	addi	sp,sp,32
    80008a08:	00008067          	ret

0000000080008a0c <push_off>:
    80008a0c:	fe010113          	addi	sp,sp,-32
    80008a10:	00813823          	sd	s0,16(sp)
    80008a14:	00113c23          	sd	ra,24(sp)
    80008a18:	00913423          	sd	s1,8(sp)
    80008a1c:	02010413          	addi	s0,sp,32
    80008a20:	100024f3          	csrr	s1,sstatus
    80008a24:	100027f3          	csrr	a5,sstatus
    80008a28:	ffd7f793          	andi	a5,a5,-3
    80008a2c:	10079073          	csrw	sstatus,a5
    80008a30:	ffffe097          	auipc	ra,0xffffe
    80008a34:	710080e7          	jalr	1808(ra) # 80007140 <mycpu>
    80008a38:	07852783          	lw	a5,120(a0)
    80008a3c:	02078663          	beqz	a5,80008a68 <push_off+0x5c>
    80008a40:	ffffe097          	auipc	ra,0xffffe
    80008a44:	700080e7          	jalr	1792(ra) # 80007140 <mycpu>
    80008a48:	07852783          	lw	a5,120(a0)
    80008a4c:	01813083          	ld	ra,24(sp)
    80008a50:	01013403          	ld	s0,16(sp)
    80008a54:	0017879b          	addiw	a5,a5,1
    80008a58:	06f52c23          	sw	a5,120(a0)
    80008a5c:	00813483          	ld	s1,8(sp)
    80008a60:	02010113          	addi	sp,sp,32
    80008a64:	00008067          	ret
    80008a68:	0014d493          	srli	s1,s1,0x1
    80008a6c:	ffffe097          	auipc	ra,0xffffe
    80008a70:	6d4080e7          	jalr	1748(ra) # 80007140 <mycpu>
    80008a74:	0014f493          	andi	s1,s1,1
    80008a78:	06952e23          	sw	s1,124(a0)
    80008a7c:	fc5ff06f          	j	80008a40 <push_off+0x34>

0000000080008a80 <pop_off>:
    80008a80:	ff010113          	addi	sp,sp,-16
    80008a84:	00813023          	sd	s0,0(sp)
    80008a88:	00113423          	sd	ra,8(sp)
    80008a8c:	01010413          	addi	s0,sp,16
    80008a90:	ffffe097          	auipc	ra,0xffffe
    80008a94:	6b0080e7          	jalr	1712(ra) # 80007140 <mycpu>
    80008a98:	100027f3          	csrr	a5,sstatus
    80008a9c:	0027f793          	andi	a5,a5,2
    80008aa0:	04079663          	bnez	a5,80008aec <pop_off+0x6c>
    80008aa4:	07852783          	lw	a5,120(a0)
    80008aa8:	02f05a63          	blez	a5,80008adc <pop_off+0x5c>
    80008aac:	fff7871b          	addiw	a4,a5,-1
    80008ab0:	06e52c23          	sw	a4,120(a0)
    80008ab4:	00071c63          	bnez	a4,80008acc <pop_off+0x4c>
    80008ab8:	07c52783          	lw	a5,124(a0)
    80008abc:	00078863          	beqz	a5,80008acc <pop_off+0x4c>
    80008ac0:	100027f3          	csrr	a5,sstatus
    80008ac4:	0027e793          	ori	a5,a5,2
    80008ac8:	10079073          	csrw	sstatus,a5
    80008acc:	00813083          	ld	ra,8(sp)
    80008ad0:	00013403          	ld	s0,0(sp)
    80008ad4:	01010113          	addi	sp,sp,16
    80008ad8:	00008067          	ret
    80008adc:	00001517          	auipc	a0,0x1
    80008ae0:	e9450513          	addi	a0,a0,-364 # 80009970 <digits+0x48>
    80008ae4:	fffff097          	auipc	ra,0xfffff
    80008ae8:	018080e7          	jalr	24(ra) # 80007afc <panic>
    80008aec:	00001517          	auipc	a0,0x1
    80008af0:	e6c50513          	addi	a0,a0,-404 # 80009958 <digits+0x30>
    80008af4:	fffff097          	auipc	ra,0xfffff
    80008af8:	008080e7          	jalr	8(ra) # 80007afc <panic>

0000000080008afc <push_on>:
    80008afc:	fe010113          	addi	sp,sp,-32
    80008b00:	00813823          	sd	s0,16(sp)
    80008b04:	00113c23          	sd	ra,24(sp)
    80008b08:	00913423          	sd	s1,8(sp)
    80008b0c:	02010413          	addi	s0,sp,32
    80008b10:	100024f3          	csrr	s1,sstatus
    80008b14:	100027f3          	csrr	a5,sstatus
    80008b18:	0027e793          	ori	a5,a5,2
    80008b1c:	10079073          	csrw	sstatus,a5
    80008b20:	ffffe097          	auipc	ra,0xffffe
    80008b24:	620080e7          	jalr	1568(ra) # 80007140 <mycpu>
    80008b28:	07852783          	lw	a5,120(a0)
    80008b2c:	02078663          	beqz	a5,80008b58 <push_on+0x5c>
    80008b30:	ffffe097          	auipc	ra,0xffffe
    80008b34:	610080e7          	jalr	1552(ra) # 80007140 <mycpu>
    80008b38:	07852783          	lw	a5,120(a0)
    80008b3c:	01813083          	ld	ra,24(sp)
    80008b40:	01013403          	ld	s0,16(sp)
    80008b44:	0017879b          	addiw	a5,a5,1
    80008b48:	06f52c23          	sw	a5,120(a0)
    80008b4c:	00813483          	ld	s1,8(sp)
    80008b50:	02010113          	addi	sp,sp,32
    80008b54:	00008067          	ret
    80008b58:	0014d493          	srli	s1,s1,0x1
    80008b5c:	ffffe097          	auipc	ra,0xffffe
    80008b60:	5e4080e7          	jalr	1508(ra) # 80007140 <mycpu>
    80008b64:	0014f493          	andi	s1,s1,1
    80008b68:	06952e23          	sw	s1,124(a0)
    80008b6c:	fc5ff06f          	j	80008b30 <push_on+0x34>

0000000080008b70 <pop_on>:
    80008b70:	ff010113          	addi	sp,sp,-16
    80008b74:	00813023          	sd	s0,0(sp)
    80008b78:	00113423          	sd	ra,8(sp)
    80008b7c:	01010413          	addi	s0,sp,16
    80008b80:	ffffe097          	auipc	ra,0xffffe
    80008b84:	5c0080e7          	jalr	1472(ra) # 80007140 <mycpu>
    80008b88:	100027f3          	csrr	a5,sstatus
    80008b8c:	0027f793          	andi	a5,a5,2
    80008b90:	04078463          	beqz	a5,80008bd8 <pop_on+0x68>
    80008b94:	07852783          	lw	a5,120(a0)
    80008b98:	02f05863          	blez	a5,80008bc8 <pop_on+0x58>
    80008b9c:	fff7879b          	addiw	a5,a5,-1
    80008ba0:	06f52c23          	sw	a5,120(a0)
    80008ba4:	07853783          	ld	a5,120(a0)
    80008ba8:	00079863          	bnez	a5,80008bb8 <pop_on+0x48>
    80008bac:	100027f3          	csrr	a5,sstatus
    80008bb0:	ffd7f793          	andi	a5,a5,-3
    80008bb4:	10079073          	csrw	sstatus,a5
    80008bb8:	00813083          	ld	ra,8(sp)
    80008bbc:	00013403          	ld	s0,0(sp)
    80008bc0:	01010113          	addi	sp,sp,16
    80008bc4:	00008067          	ret
    80008bc8:	00001517          	auipc	a0,0x1
    80008bcc:	dd050513          	addi	a0,a0,-560 # 80009998 <digits+0x70>
    80008bd0:	fffff097          	auipc	ra,0xfffff
    80008bd4:	f2c080e7          	jalr	-212(ra) # 80007afc <panic>
    80008bd8:	00001517          	auipc	a0,0x1
    80008bdc:	da050513          	addi	a0,a0,-608 # 80009978 <digits+0x50>
    80008be0:	fffff097          	auipc	ra,0xfffff
    80008be4:	f1c080e7          	jalr	-228(ra) # 80007afc <panic>

0000000080008be8 <__memset>:
    80008be8:	ff010113          	addi	sp,sp,-16
    80008bec:	00813423          	sd	s0,8(sp)
    80008bf0:	01010413          	addi	s0,sp,16
    80008bf4:	1a060e63          	beqz	a2,80008db0 <__memset+0x1c8>
    80008bf8:	40a007b3          	neg	a5,a0
    80008bfc:	0077f793          	andi	a5,a5,7
    80008c00:	00778693          	addi	a3,a5,7
    80008c04:	00b00813          	li	a6,11
    80008c08:	0ff5f593          	andi	a1,a1,255
    80008c0c:	fff6071b          	addiw	a4,a2,-1
    80008c10:	1b06e663          	bltu	a3,a6,80008dbc <__memset+0x1d4>
    80008c14:	1cd76463          	bltu	a4,a3,80008ddc <__memset+0x1f4>
    80008c18:	1a078e63          	beqz	a5,80008dd4 <__memset+0x1ec>
    80008c1c:	00b50023          	sb	a1,0(a0)
    80008c20:	00100713          	li	a4,1
    80008c24:	1ae78463          	beq	a5,a4,80008dcc <__memset+0x1e4>
    80008c28:	00b500a3          	sb	a1,1(a0)
    80008c2c:	00200713          	li	a4,2
    80008c30:	1ae78a63          	beq	a5,a4,80008de4 <__memset+0x1fc>
    80008c34:	00b50123          	sb	a1,2(a0)
    80008c38:	00300713          	li	a4,3
    80008c3c:	18e78463          	beq	a5,a4,80008dc4 <__memset+0x1dc>
    80008c40:	00b501a3          	sb	a1,3(a0)
    80008c44:	00400713          	li	a4,4
    80008c48:	1ae78263          	beq	a5,a4,80008dec <__memset+0x204>
    80008c4c:	00b50223          	sb	a1,4(a0)
    80008c50:	00500713          	li	a4,5
    80008c54:	1ae78063          	beq	a5,a4,80008df4 <__memset+0x20c>
    80008c58:	00b502a3          	sb	a1,5(a0)
    80008c5c:	00700713          	li	a4,7
    80008c60:	18e79e63          	bne	a5,a4,80008dfc <__memset+0x214>
    80008c64:	00b50323          	sb	a1,6(a0)
    80008c68:	00700e93          	li	t4,7
    80008c6c:	00859713          	slli	a4,a1,0x8
    80008c70:	00e5e733          	or	a4,a1,a4
    80008c74:	01059e13          	slli	t3,a1,0x10
    80008c78:	01c76e33          	or	t3,a4,t3
    80008c7c:	01859313          	slli	t1,a1,0x18
    80008c80:	006e6333          	or	t1,t3,t1
    80008c84:	02059893          	slli	a7,a1,0x20
    80008c88:	40f60e3b          	subw	t3,a2,a5
    80008c8c:	011368b3          	or	a7,t1,a7
    80008c90:	02859813          	slli	a6,a1,0x28
    80008c94:	0108e833          	or	a6,a7,a6
    80008c98:	03059693          	slli	a3,a1,0x30
    80008c9c:	003e589b          	srliw	a7,t3,0x3
    80008ca0:	00d866b3          	or	a3,a6,a3
    80008ca4:	03859713          	slli	a4,a1,0x38
    80008ca8:	00389813          	slli	a6,a7,0x3
    80008cac:	00f507b3          	add	a5,a0,a5
    80008cb0:	00e6e733          	or	a4,a3,a4
    80008cb4:	000e089b          	sext.w	a7,t3
    80008cb8:	00f806b3          	add	a3,a6,a5
    80008cbc:	00e7b023          	sd	a4,0(a5)
    80008cc0:	00878793          	addi	a5,a5,8
    80008cc4:	fed79ce3          	bne	a5,a3,80008cbc <__memset+0xd4>
    80008cc8:	ff8e7793          	andi	a5,t3,-8
    80008ccc:	0007871b          	sext.w	a4,a5
    80008cd0:	01d787bb          	addw	a5,a5,t4
    80008cd4:	0ce88e63          	beq	a7,a4,80008db0 <__memset+0x1c8>
    80008cd8:	00f50733          	add	a4,a0,a5
    80008cdc:	00b70023          	sb	a1,0(a4)
    80008ce0:	0017871b          	addiw	a4,a5,1
    80008ce4:	0cc77663          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008ce8:	00e50733          	add	a4,a0,a4
    80008cec:	00b70023          	sb	a1,0(a4)
    80008cf0:	0027871b          	addiw	a4,a5,2
    80008cf4:	0ac77e63          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008cf8:	00e50733          	add	a4,a0,a4
    80008cfc:	00b70023          	sb	a1,0(a4)
    80008d00:	0037871b          	addiw	a4,a5,3
    80008d04:	0ac77663          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d08:	00e50733          	add	a4,a0,a4
    80008d0c:	00b70023          	sb	a1,0(a4)
    80008d10:	0047871b          	addiw	a4,a5,4
    80008d14:	08c77e63          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d18:	00e50733          	add	a4,a0,a4
    80008d1c:	00b70023          	sb	a1,0(a4)
    80008d20:	0057871b          	addiw	a4,a5,5
    80008d24:	08c77663          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d28:	00e50733          	add	a4,a0,a4
    80008d2c:	00b70023          	sb	a1,0(a4)
    80008d30:	0067871b          	addiw	a4,a5,6
    80008d34:	06c77e63          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d38:	00e50733          	add	a4,a0,a4
    80008d3c:	00b70023          	sb	a1,0(a4)
    80008d40:	0077871b          	addiw	a4,a5,7
    80008d44:	06c77663          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d48:	00e50733          	add	a4,a0,a4
    80008d4c:	00b70023          	sb	a1,0(a4)
    80008d50:	0087871b          	addiw	a4,a5,8
    80008d54:	04c77e63          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d58:	00e50733          	add	a4,a0,a4
    80008d5c:	00b70023          	sb	a1,0(a4)
    80008d60:	0097871b          	addiw	a4,a5,9
    80008d64:	04c77663          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d68:	00e50733          	add	a4,a0,a4
    80008d6c:	00b70023          	sb	a1,0(a4)
    80008d70:	00a7871b          	addiw	a4,a5,10
    80008d74:	02c77e63          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d78:	00e50733          	add	a4,a0,a4
    80008d7c:	00b70023          	sb	a1,0(a4)
    80008d80:	00b7871b          	addiw	a4,a5,11
    80008d84:	02c77663          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d88:	00e50733          	add	a4,a0,a4
    80008d8c:	00b70023          	sb	a1,0(a4)
    80008d90:	00c7871b          	addiw	a4,a5,12
    80008d94:	00c77e63          	bgeu	a4,a2,80008db0 <__memset+0x1c8>
    80008d98:	00e50733          	add	a4,a0,a4
    80008d9c:	00b70023          	sb	a1,0(a4)
    80008da0:	00d7879b          	addiw	a5,a5,13
    80008da4:	00c7f663          	bgeu	a5,a2,80008db0 <__memset+0x1c8>
    80008da8:	00f507b3          	add	a5,a0,a5
    80008dac:	00b78023          	sb	a1,0(a5)
    80008db0:	00813403          	ld	s0,8(sp)
    80008db4:	01010113          	addi	sp,sp,16
    80008db8:	00008067          	ret
    80008dbc:	00b00693          	li	a3,11
    80008dc0:	e55ff06f          	j	80008c14 <__memset+0x2c>
    80008dc4:	00300e93          	li	t4,3
    80008dc8:	ea5ff06f          	j	80008c6c <__memset+0x84>
    80008dcc:	00100e93          	li	t4,1
    80008dd0:	e9dff06f          	j	80008c6c <__memset+0x84>
    80008dd4:	00000e93          	li	t4,0
    80008dd8:	e95ff06f          	j	80008c6c <__memset+0x84>
    80008ddc:	00000793          	li	a5,0
    80008de0:	ef9ff06f          	j	80008cd8 <__memset+0xf0>
    80008de4:	00200e93          	li	t4,2
    80008de8:	e85ff06f          	j	80008c6c <__memset+0x84>
    80008dec:	00400e93          	li	t4,4
    80008df0:	e7dff06f          	j	80008c6c <__memset+0x84>
    80008df4:	00500e93          	li	t4,5
    80008df8:	e75ff06f          	j	80008c6c <__memset+0x84>
    80008dfc:	00600e93          	li	t4,6
    80008e00:	e6dff06f          	j	80008c6c <__memset+0x84>

0000000080008e04 <__memmove>:
    80008e04:	ff010113          	addi	sp,sp,-16
    80008e08:	00813423          	sd	s0,8(sp)
    80008e0c:	01010413          	addi	s0,sp,16
    80008e10:	0e060863          	beqz	a2,80008f00 <__memmove+0xfc>
    80008e14:	fff6069b          	addiw	a3,a2,-1
    80008e18:	0006881b          	sext.w	a6,a3
    80008e1c:	0ea5e863          	bltu	a1,a0,80008f0c <__memmove+0x108>
    80008e20:	00758713          	addi	a4,a1,7
    80008e24:	00a5e7b3          	or	a5,a1,a0
    80008e28:	40a70733          	sub	a4,a4,a0
    80008e2c:	0077f793          	andi	a5,a5,7
    80008e30:	00f73713          	sltiu	a4,a4,15
    80008e34:	00174713          	xori	a4,a4,1
    80008e38:	0017b793          	seqz	a5,a5
    80008e3c:	00e7f7b3          	and	a5,a5,a4
    80008e40:	10078863          	beqz	a5,80008f50 <__memmove+0x14c>
    80008e44:	00900793          	li	a5,9
    80008e48:	1107f463          	bgeu	a5,a6,80008f50 <__memmove+0x14c>
    80008e4c:	0036581b          	srliw	a6,a2,0x3
    80008e50:	fff8081b          	addiw	a6,a6,-1
    80008e54:	02081813          	slli	a6,a6,0x20
    80008e58:	01d85893          	srli	a7,a6,0x1d
    80008e5c:	00858813          	addi	a6,a1,8
    80008e60:	00058793          	mv	a5,a1
    80008e64:	00050713          	mv	a4,a0
    80008e68:	01088833          	add	a6,a7,a6
    80008e6c:	0007b883          	ld	a7,0(a5)
    80008e70:	00878793          	addi	a5,a5,8
    80008e74:	00870713          	addi	a4,a4,8
    80008e78:	ff173c23          	sd	a7,-8(a4)
    80008e7c:	ff0798e3          	bne	a5,a6,80008e6c <__memmove+0x68>
    80008e80:	ff867713          	andi	a4,a2,-8
    80008e84:	02071793          	slli	a5,a4,0x20
    80008e88:	0207d793          	srli	a5,a5,0x20
    80008e8c:	00f585b3          	add	a1,a1,a5
    80008e90:	40e686bb          	subw	a3,a3,a4
    80008e94:	00f507b3          	add	a5,a0,a5
    80008e98:	06e60463          	beq	a2,a4,80008f00 <__memmove+0xfc>
    80008e9c:	0005c703          	lbu	a4,0(a1)
    80008ea0:	00e78023          	sb	a4,0(a5)
    80008ea4:	04068e63          	beqz	a3,80008f00 <__memmove+0xfc>
    80008ea8:	0015c603          	lbu	a2,1(a1)
    80008eac:	00100713          	li	a4,1
    80008eb0:	00c780a3          	sb	a2,1(a5)
    80008eb4:	04e68663          	beq	a3,a4,80008f00 <__memmove+0xfc>
    80008eb8:	0025c603          	lbu	a2,2(a1)
    80008ebc:	00200713          	li	a4,2
    80008ec0:	00c78123          	sb	a2,2(a5)
    80008ec4:	02e68e63          	beq	a3,a4,80008f00 <__memmove+0xfc>
    80008ec8:	0035c603          	lbu	a2,3(a1)
    80008ecc:	00300713          	li	a4,3
    80008ed0:	00c781a3          	sb	a2,3(a5)
    80008ed4:	02e68663          	beq	a3,a4,80008f00 <__memmove+0xfc>
    80008ed8:	0045c603          	lbu	a2,4(a1)
    80008edc:	00400713          	li	a4,4
    80008ee0:	00c78223          	sb	a2,4(a5)
    80008ee4:	00e68e63          	beq	a3,a4,80008f00 <__memmove+0xfc>
    80008ee8:	0055c603          	lbu	a2,5(a1)
    80008eec:	00500713          	li	a4,5
    80008ef0:	00c782a3          	sb	a2,5(a5)
    80008ef4:	00e68663          	beq	a3,a4,80008f00 <__memmove+0xfc>
    80008ef8:	0065c703          	lbu	a4,6(a1)
    80008efc:	00e78323          	sb	a4,6(a5)
    80008f00:	00813403          	ld	s0,8(sp)
    80008f04:	01010113          	addi	sp,sp,16
    80008f08:	00008067          	ret
    80008f0c:	02061713          	slli	a4,a2,0x20
    80008f10:	02075713          	srli	a4,a4,0x20
    80008f14:	00e587b3          	add	a5,a1,a4
    80008f18:	f0f574e3          	bgeu	a0,a5,80008e20 <__memmove+0x1c>
    80008f1c:	02069613          	slli	a2,a3,0x20
    80008f20:	02065613          	srli	a2,a2,0x20
    80008f24:	fff64613          	not	a2,a2
    80008f28:	00e50733          	add	a4,a0,a4
    80008f2c:	00c78633          	add	a2,a5,a2
    80008f30:	fff7c683          	lbu	a3,-1(a5)
    80008f34:	fff78793          	addi	a5,a5,-1
    80008f38:	fff70713          	addi	a4,a4,-1
    80008f3c:	00d70023          	sb	a3,0(a4)
    80008f40:	fec798e3          	bne	a5,a2,80008f30 <__memmove+0x12c>
    80008f44:	00813403          	ld	s0,8(sp)
    80008f48:	01010113          	addi	sp,sp,16
    80008f4c:	00008067          	ret
    80008f50:	02069713          	slli	a4,a3,0x20
    80008f54:	02075713          	srli	a4,a4,0x20
    80008f58:	00170713          	addi	a4,a4,1
    80008f5c:	00e50733          	add	a4,a0,a4
    80008f60:	00050793          	mv	a5,a0
    80008f64:	0005c683          	lbu	a3,0(a1)
    80008f68:	00178793          	addi	a5,a5,1
    80008f6c:	00158593          	addi	a1,a1,1
    80008f70:	fed78fa3          	sb	a3,-1(a5)
    80008f74:	fee798e3          	bne	a5,a4,80008f64 <__memmove+0x160>
    80008f78:	f89ff06f          	j	80008f00 <__memmove+0xfc>
	...
