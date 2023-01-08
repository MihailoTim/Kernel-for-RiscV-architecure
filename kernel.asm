
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	e1013103          	ld	sp,-496(sp) # 8000be10 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	3c9060ef          	jal	ra,80006be4 <start>

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
    800010a8:	025030ef          	jal	ra,800048cc <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001184:	434080e7          	jalr	1076(ra) # 800025b4 <_ZN5Buddy4freeEPvm>
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
    800011e4:	17060613          	addi	a2,a2,368 # 80009350 <CONSOLE_STATUS+0x340>
    800011e8:	0005059b          	sext.w	a1,a0
    800011ec:	00008517          	auipc	a0,0x8
    800011f0:	e3450513          	addi	a0,a0,-460 # 80009020 <CONSOLE_STATUS+0x10>
    800011f4:	00004097          	auipc	ra,0x4
    800011f8:	1a8080e7          	jalr	424(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011fc:	01000693          	li	a3,16
    80001200:	00008617          	auipc	a2,0x8
    80001204:	15060613          	addi	a2,a2,336 # 80009350 <CONSOLE_STATUS+0x340>
    80001208:	01892583          	lw	a1,24(s2)
    8000120c:	00008517          	auipc	a0,0x8
    80001210:	e2450513          	addi	a0,a0,-476 # 80009030 <CONSOLE_STATUS+0x20>
    80001214:	00004097          	auipc	ra,0x4
    80001218:	188080e7          	jalr	392(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    8000121c:	01000693          	li	a3,16
    80001220:	00008617          	auipc	a2,0x8
    80001224:	13060613          	addi	a2,a2,304 # 80009350 <CONSOLE_STATUS+0x340>
    80001228:	01092583          	lw	a1,16(s2)
    8000122c:	00008517          	auipc	a0,0x8
    80001230:	e1c50513          	addi	a0,a0,-484 # 80009048 <CONSOLE_STATUS+0x38>
    80001234:	00004097          	auipc	ra,0x4
    80001238:	168080e7          	jalr	360(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    8000123c:	01000693          	li	a3,16
    80001240:	00008617          	auipc	a2,0x8
    80001244:	11060613          	addi	a2,a2,272 # 80009350 <CONSOLE_STATUS+0x340>
    80001248:	03800593          	li	a1,56
    8000124c:	00008517          	auipc	a0,0x8
    80001250:	e1450513          	addi	a0,a0,-492 # 80009060 <CONSOLE_STATUS+0x50>
    80001254:	00004097          	auipc	ra,0x4
    80001258:	148080e7          	jalr	328(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000125c:	01000693          	li	a3,16
    80001260:	00008617          	auipc	a2,0x8
    80001264:	0f060613          	addi	a2,a2,240 # 80009350 <CONSOLE_STATUS+0x340>
    80001268:	02892583          	lw	a1,40(s2)
    8000126c:	00008517          	auipc	a0,0x8
    80001270:	e0c50513          	addi	a0,a0,-500 # 80009078 <CONSOLE_STATUS+0x68>
    80001274:	00004097          	auipc	ra,0x4
    80001278:	128080e7          	jalr	296(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    8000127c:	01000693          	li	a3,16
    80001280:	00008617          	auipc	a2,0x8
    80001284:	0d060613          	addi	a2,a2,208 # 80009350 <CONSOLE_STATUS+0x340>
    80001288:	02092583          	lw	a1,32(s2)
    8000128c:	00008517          	auipc	a0,0x8
    80001290:	dfc50513          	addi	a0,a0,-516 # 80009088 <CONSOLE_STATUS+0x78>
    80001294:	00004097          	auipc	ra,0x4
    80001298:	108080e7          	jalr	264(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000129c:	00008517          	auipc	a0,0x8
    800012a0:	e0c50513          	addi	a0,a0,-500 # 800090a8 <CONSOLE_STATUS+0x98>
    800012a4:	00004097          	auipc	ra,0x4
    800012a8:	fd8080e7          	jalr	-40(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
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
    800012d0:	0c450513          	addi	a0,a0,196 # 80009390 <CONSOLE_STATUS+0x380>
    800012d4:	00004097          	auipc	ra,0x4
    800012d8:	0c8080e7          	jalr	200(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012dc:	00148493          	addi	s1,s1,1
    800012e0:	01893783          	ld	a5,24(s2)
    800012e4:	0037d793          	srli	a5,a5,0x3
    800012e8:	00178793          	addi	a5,a5,1
    800012ec:	fcf4e4e3          	bltu	s1,a5,800012b4 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    800012f0:	00008517          	auipc	a0,0x8
    800012f4:	06050513          	addi	a0,a0,96 # 80009350 <CONSOLE_STATUS+0x340>
    800012f8:	00004097          	auipc	ra,0x4
    800012fc:	f84080e7          	jalr	-124(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
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
    80001344:	f3c080e7          	jalr	-196(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001348:	00090513          	mv	a0,s2
    8000134c:	00004097          	auipc	ra,0x4
    80001350:	f30080e7          	jalr	-208(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001354:	00008517          	auipc	a0,0x8
    80001358:	ffc50513          	addi	a0,a0,-4 # 80009350 <CONSOLE_STATUS+0x340>
    8000135c:	00004097          	auipc	ra,0x4
    80001360:	f20080e7          	jalr	-224(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001364:	01000693          	li	a3,16
    80001368:	00008617          	auipc	a2,0x8
    8000136c:	fe860613          	addi	a2,a2,-24 # 80009350 <CONSOLE_STATUS+0x340>
    80001370:	0000b797          	auipc	a5,0xb
    80001374:	a707b783          	ld	a5,-1424(a5) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001378:	0007a583          	lw	a1,0(a5)
    8000137c:	00008517          	auipc	a0,0x8
    80001380:	d5c50513          	addi	a0,a0,-676 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001384:	00004097          	auipc	ra,0x4
    80001388:	018080e7          	jalr	24(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000138c:	01000693          	li	a3,16
    80001390:	00008617          	auipc	a2,0x8
    80001394:	fc060613          	addi	a2,a2,-64 # 80009350 <CONSOLE_STATUS+0x340>
    80001398:	0009059b          	sext.w	a1,s2
    8000139c:	00008517          	auipc	a0,0x8
    800013a0:	d5450513          	addi	a0,a0,-684 # 800090f0 <CONSOLE_STATUS+0xe0>
    800013a4:	00004097          	auipc	ra,0x4
    800013a8:	ff8080e7          	jalr	-8(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    800013ac:	01000693          	li	a3,16
    800013b0:	00008617          	auipc	a2,0x8
    800013b4:	fa060613          	addi	a2,a2,-96 # 80009350 <CONSOLE_STATUS+0x340>
    800013b8:	04892583          	lw	a1,72(s2)
    800013bc:	00008517          	auipc	a0,0x8
    800013c0:	d4450513          	addi	a0,a0,-700 # 80009100 <CONSOLE_STATUS+0xf0>
    800013c4:	00004097          	auipc	ra,0x4
    800013c8:	fd8080e7          	jalr	-40(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013cc:	01000693          	li	a3,16
    800013d0:	00008617          	auipc	a2,0x8
    800013d4:	f8060613          	addi	a2,a2,-128 # 80009350 <CONSOLE_STATUS+0x340>
    800013d8:	04092583          	lw	a1,64(s2)
    800013dc:	00008517          	auipc	a0,0x8
    800013e0:	d3c50513          	addi	a0,a0,-708 # 80009118 <CONSOLE_STATUS+0x108>
    800013e4:	00004097          	auipc	ra,0x4
    800013e8:	fb8080e7          	jalr	-72(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013ec:	01000693          	li	a3,16
    800013f0:	00008617          	auipc	a2,0x8
    800013f4:	f6060613          	addi	a2,a2,-160 # 80009350 <CONSOLE_STATUS+0x340>
    800013f8:	06092583          	lw	a1,96(s2)
    800013fc:	00008517          	auipc	a0,0x8
    80001400:	d3450513          	addi	a0,a0,-716 # 80009130 <CONSOLE_STATUS+0x120>
    80001404:	00004097          	auipc	ra,0x4
    80001408:	f98080e7          	jalr	-104(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>

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
    80001428:	f6c50513          	addi	a0,a0,-148 # 80009390 <CONSOLE_STATUS+0x380>
    8000142c:	00004097          	auipc	ra,0x4
    80001430:	f70080e7          	jalr	-144(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001434:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001438:	fd9ff06f          	j	80001410 <_ZN13SlabAllocator10printCacheEP5Cache+0xf4>
    }
    ConsoleUtil::printString("\n");
    8000143c:	00008517          	auipc	a0,0x8
    80001440:	f1450513          	addi	a0,a0,-236 # 80009350 <CONSOLE_STATUS+0x340>
    80001444:	00004097          	auipc	ra,0x4
    80001448:	e38080e7          	jalr	-456(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    8000144c:	01000693          	li	a3,16
    80001450:	00008617          	auipc	a2,0x8
    80001454:	f0060613          	addi	a2,a2,-256 # 80009350 <CONSOLE_STATUS+0x340>
    80001458:	06892583          	lw	a1,104(s2)
    8000145c:	00008517          	auipc	a0,0x8
    80001460:	ce450513          	addi	a0,a0,-796 # 80009140 <CONSOLE_STATUS+0x130>
    80001464:	00004097          	auipc	ra,0x4
    80001468:	f38080e7          	jalr	-200(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>

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
    80001488:	f0c50513          	addi	a0,a0,-244 # 80009390 <CONSOLE_STATUS+0x380>
    8000148c:	00004097          	auipc	ra,0x4
    80001490:	f10080e7          	jalr	-240(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001494:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001498:	fd9ff06f          	j	80001470 <_ZN13SlabAllocator10printCacheEP5Cache+0x154>
    }
    ConsoleUtil::printString("\n");
    8000149c:	00008517          	auipc	a0,0x8
    800014a0:	eb450513          	addi	a0,a0,-332 # 80009350 <CONSOLE_STATUS+0x340>
    800014a4:	00004097          	auipc	ra,0x4
    800014a8:	dd8080e7          	jalr	-552(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    800014ac:	01000693          	li	a3,16
    800014b0:	00008617          	auipc	a2,0x8
    800014b4:	ea060613          	addi	a2,a2,-352 # 80009350 <CONSOLE_STATUS+0x340>
    800014b8:	07092583          	lw	a1,112(s2)
    800014bc:	00008517          	auipc	a0,0x8
    800014c0:	c9450513          	addi	a0,a0,-876 # 80009150 <CONSOLE_STATUS+0x140>
    800014c4:	00004097          	auipc	ra,0x4
    800014c8:	ed8080e7          	jalr	-296(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>

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
    800014e8:	eac50513          	addi	a0,a0,-340 # 80009390 <CONSOLE_STATUS+0x380>
    800014ec:	00004097          	auipc	ra,0x4
    800014f0:	eb0080e7          	jalr	-336(ra) # 8000539c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800014f4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014f8:	fd9ff06f          	j	800014d0 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b4>
    }
    ConsoleUtil::printString("\n");
    800014fc:	00008517          	auipc	a0,0x8
    80001500:	e5450513          	addi	a0,a0,-428 # 80009350 <CONSOLE_STATUS+0x340>
    80001504:	00004097          	auipc	ra,0x4
    80001508:	d78080e7          	jalr	-648(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
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
    8000157c:	114080e7          	jalr	276(ra) # 8000268c <_ZN5Buddy5allocEm>
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
    80001908:	5bc78793          	addi	a5,a5,1468 # 8000bec0 <_ZN13SlabAllocator5sizeNE>
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
    8000196c:	5c053503          	ld	a0,1472(a0) # 8000bf28 <_ZN13SlabAllocator5cacheE>
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
    800019ac:	358080e7          	jalr	856(ra) # 80004d00 <_Z6strcpyPKcPc>
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
    800019fc:	8c4080e7          	jalr	-1852(ra) # 800022bc <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    80001a00:	0000a797          	auipc	a5,0xa
    80001a04:	4c078793          	addi	a5,a5,1216 # 8000bec0 <_ZN13SlabAllocator5sizeNE>
    80001a08:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    80001a0c:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80001a10:	0000a717          	auipc	a4,0xa
    80001a14:	3d073703          	ld	a4,976(a4) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x18>
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
    80001a5c:	2a8080e7          	jalr	680(ra) # 80004d00 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a60:	00000493          	li	s1,0
    80001a64:	0440006f          	j	80001aa8 <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a68:	00349913          	slli	s2,s1,0x3
    80001a6c:	0000a797          	auipc	a5,0xa
    80001a70:	1d478793          	addi	a5,a5,468 # 8000bc40 <_ZN13SlabAllocator5namesE>
    80001a74:	012787b3          	add	a5,a5,s2
    80001a78:	00000693          	li	a3,0
    80001a7c:	00000613          	li	a2,0
    80001a80:	00200593          	li	a1,2
    80001a84:	009595bb          	sllw	a1,a1,s1
    80001a88:	0007b503          	ld	a0,0(a5)
    80001a8c:	00000097          	auipc	ra,0x0
    80001a90:	ea8080e7          	jalr	-344(ra) # 80001934 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a94:	0000a797          	auipc	a5,0xa
    80001a98:	42c78793          	addi	a5,a5,1068 # 8000bec0 <_ZN13SlabAllocator5sizeNE>
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
    80001ba4:	a14080e7          	jalr	-1516(ra) # 800025b4 <_ZN5Buddy4freeEPvm>
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
    80001cd4:	1f078793          	addi	a5,a5,496 # 8000bec0 <_ZN13SlabAllocator5sizeNE>
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
    80001d48:	870080e7          	jalr	-1936(ra) # 800025b4 <_ZN5Buddy4freeEPvm>
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
    80001d78:	840080e7          	jalr	-1984(ra) # 800025b4 <_ZN5Buddy4freeEPvm>
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
    80001da8:	810080e7          	jalr	-2032(ra) # 800025b4 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001dac:	00093783          	ld	a5,0(s2)
    80001db0:	0087b783          	ld	a5,8(a5)
    80001db4:	00f93023          	sd	a5,0(s2)
        while(head){
    80001db8:	fddff06f          	j	80001d94 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001dbc:	0004b583          	ld	a1,0(s1)
    80001dc0:	0000a517          	auipc	a0,0xa
    80001dc4:	16853503          	ld	a0,360(a0) # 8000bf28 <_ZN13SlabAllocator5cacheE>
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
    80002180:	f88080e7          	jalr	-120(ra) # 80003104 <_ZN3TCB11thread_freeEPv>
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

00000000800021ac <_Z4ctorPv>:
void ctor(void* tst){
    800021ac:	ff010113          	addi	sp,sp,-16
    800021b0:	00813423          	sd	s0,8(sp)
    800021b4:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    800021b8:	01100793          	li	a5,17
    800021bc:	00f53023          	sd	a5,0(a0) # 1000 <_entry-0x7ffff000>
    ((Test*)tst)->b = 32;
    800021c0:	02000793          	li	a5,32
    800021c4:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    800021c8:	00d00793          	li	a5,13
    800021cc:	00f53823          	sd	a5,16(a0)
}
    800021d0:	00813403          	ld	s0,8(sp)
    800021d4:	01010113          	addi	sp,sp,16
    800021d8:	00008067          	ret

00000000800021dc <_ZN6SystemC1Ev>:
    if (!initialized) {
    800021dc:	0000a797          	auipc	a5,0xa
    800021e0:	d647c783          	lbu	a5,-668(a5) # 8000bf40 <_ZN6System11initializedE>
    800021e4:	00078463          	beqz	a5,800021ec <_ZN6SystemC1Ev+0x10>
    800021e8:	00008067          	ret
System::System() {
    800021ec:	fe010113          	addi	sp,sp,-32
    800021f0:	00113c23          	sd	ra,24(sp)
    800021f4:	00813823          	sd	s0,16(sp)
    800021f8:	02010413          	addi	s0,sp,32
        initialized = true;
    800021fc:	00100793          	li	a5,1
    80002200:	0000a717          	auipc	a4,0xa
    80002204:	d4f70023          	sb	a5,-704(a4) # 8000bf40 <_ZN6System11initializedE>
        RiscV::initialize();
    80002208:	00002097          	auipc	ra,0x2
    8000220c:	a18080e7          	jalr	-1512(ra) # 80003c20 <_ZN5RiscV10initializeEv>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80002210:	00000613          	li	a2,0
    80002214:	00000597          	auipc	a1,0x0
    80002218:	f8058593          	addi	a1,a1,-128 # 80002194 <_ZN6System15userMainWrapperEPv>
    8000221c:	fe840513          	addi	a0,s0,-24
    80002220:	00000097          	auipc	ra,0x0
    80002224:	c28080e7          	jalr	-984(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80002228:	fe843783          	ld	a5,-24(s0)
    8000222c:	0107a703          	lw	a4,16(a5)
    80002230:	00200793          	li	a5,2
    80002234:	00f70863          	beq	a4,a5,80002244 <_ZN6SystemC1Ev+0x68>
            thread_dispatch();
    80002238:	00000097          	auipc	ra,0x0
    8000223c:	cc4080e7          	jalr	-828(ra) # 80001efc <_Z15thread_dispatchv>
    80002240:	fe9ff06f          	j	80002228 <_ZN6SystemC1Ev+0x4c>
        RiscV::finalize();
    80002244:	00002097          	auipc	ra,0x2
    80002248:	d9c080e7          	jalr	-612(ra) # 80003fe0 <_ZN5RiscV8finalizeEv>
}
    8000224c:	01813083          	ld	ra,24(sp)
    80002250:	01013403          	ld	s0,16(sp)
    80002254:	02010113          	addi	sp,sp,32
    80002258:	00008067          	ret

000000008000225c <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    8000225c:	ff010113          	addi	sp,sp,-16
    80002260:	00813423          	sd	s0,8(sp)
    80002264:	01010413          	addi	s0,sp,16
    80002268:	00100793          	li	a5,1
    8000226c:	00f50863          	beq	a0,a5,8000227c <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002270:	00813403          	ld	s0,8(sp)
    80002274:	01010113          	addi	sp,sp,16
    80002278:	00008067          	ret
    8000227c:	000107b7          	lui	a5,0x10
    80002280:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002284:	fef596e3          	bne	a1,a5,80002270 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80002288:	0000a797          	auipc	a5,0xa
    8000228c:	b587b783          	ld	a5,-1192(a5) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002290:	0007b703          	ld	a4,0(a5)
    80002294:	00c75793          	srli	a5,a4,0xc
    80002298:	00278793          	addi	a5,a5,2
    8000229c:	00c79793          	slli	a5,a5,0xc
    800022a0:	0000a697          	auipc	a3,0xa
    800022a4:	ca868693          	addi	a3,a3,-856 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022a8:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800022ac:	fffff7b7          	lui	a5,0xfffff
    800022b0:	00f77733          	and	a4,a4,a5
    800022b4:	00e6b423          	sd	a4,8(a3)
    800022b8:	fb9ff06f          	j	80002270 <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800022bc <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    800022bc:	ff010113          	addi	sp,sp,-16
    800022c0:	00813423          	sd	s0,8(sp)
    800022c4:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    800022c8:	0000a717          	auipc	a4,0xa
    800022cc:	c8070713          	addi	a4,a4,-896 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022d0:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800022d4:	0000a797          	auipc	a5,0xa
    800022d8:	b0c7b783          	ld	a5,-1268(a5) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800022dc:	0007b783          	ld	a5,0(a5)
    800022e0:	fffff6b7          	lui	a3,0xfffff
    800022e4:	00d7f7b3          	and	a5,a5,a3
    800022e8:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    800022ec:	0000a797          	auipc	a5,0xa
    800022f0:	9ab7be23          	sd	a1,-1604(a5) # 8000bca8 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    800022f4:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800022f8:	00000713          	li	a4,0
        while(num>1){
    800022fc:	00100693          	li	a3,1
    80002300:	00f6f863          	bgeu	a3,a5,80002310 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80002304:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002308:	00170713          	addi	a4,a4,1
        while(num>1){
    8000230c:	ff1ff06f          	j	800022fc <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80002310:	00371713          	slli	a4,a4,0x3
    80002314:	0000a797          	auipc	a5,0xa
    80002318:	c3478793          	addi	a5,a5,-972 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000231c:	00e78733          	add	a4,a5,a4
    80002320:	00a73823          	sd	a0,16(a4)
    80002324:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002328:	00000713          	li	a4,0
        while(num>1){
    8000232c:	00100693          	li	a3,1
    80002330:	00f6f863          	bgeu	a3,a5,80002340 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80002334:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002338:	00170713          	addi	a4,a4,1
        while(num>1){
    8000233c:	ff1ff06f          	j	8000232c <_ZN5Buddy10initializeEPvm+0x70>
    80002340:	00371713          	slli	a4,a4,0x3
    80002344:	0000a797          	auipc	a5,0xa
    80002348:	c0478793          	addi	a5,a5,-1020 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000234c:	00e78733          	add	a4,a5,a4
    80002350:	06a73c23          	sd	a0,120(a4)
    80002354:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002358:	00000713          	li	a4,0
        while(num>1){
    8000235c:	00100693          	li	a3,1
    80002360:	00f6f863          	bgeu	a3,a5,80002370 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80002364:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002368:	00170713          	addi	a4,a4,1
        while(num>1){
    8000236c:	ff1ff06f          	j	8000235c <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80002370:	00371713          	slli	a4,a4,0x3
    80002374:	0000a797          	auipc	a5,0xa
    80002378:	bd478793          	addi	a5,a5,-1068 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000237c:	00e78733          	add	a4,a5,a4
    80002380:	01073783          	ld	a5,16(a4)
    80002384:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80002388:	00000793          	li	a5,0
    8000238c:	00c0006f          	j	80002398 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80002390:	0015d593          	srli	a1,a1,0x1
            deg++;
    80002394:	00178793          	addi	a5,a5,1
        while(num>1){
    80002398:	00100713          	li	a4,1
    8000239c:	feb76ae3          	bltu	a4,a1,80002390 <_ZN5Buddy10initializeEPvm+0xd4>
    800023a0:	00379793          	slli	a5,a5,0x3
    800023a4:	0000a717          	auipc	a4,0xa
    800023a8:	ba470713          	addi	a4,a4,-1116 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023ac:	00f707b3          	add	a5,a4,a5
    800023b0:	0787b783          	ld	a5,120(a5)
    800023b4:	0007b023          	sd	zero,0(a5)
}
    800023b8:	00813403          	ld	s0,8(sp)
    800023bc:	01010113          	addi	sp,sp,16
    800023c0:	00008067          	ret

00000000800023c4 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    800023c4:	00c00793          	li	a5,12
    800023c8:	10f50063          	beq	a0,a5,800024c8 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    800023cc:	fd010113          	addi	sp,sp,-48
    800023d0:	02113423          	sd	ra,40(sp)
    800023d4:	02813023          	sd	s0,32(sp)
    800023d8:	00913c23          	sd	s1,24(sp)
    800023dc:	01213823          	sd	s2,16(sp)
    800023e0:	01313423          	sd	s3,8(sp)
    800023e4:	03010413          	addi	s0,sp,48
    800023e8:	00050913          	mv	s2,a0
    Block *curr = head[size];
    800023ec:	00351713          	slli	a4,a0,0x3
    800023f0:	0000a797          	auipc	a5,0xa
    800023f4:	b5878793          	addi	a5,a5,-1192 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023f8:	00e787b3          	add	a5,a5,a4
    800023fc:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002400:	00000993          	li	s3,0
    80002404:	0180006f          	j	8000241c <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002408:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    8000240c:	04f70463          	beq	a4,a5,80002454 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80002410:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80002414:	08f70063          	beq	a4,a5,80002494 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80002418:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    8000241c:	08048863          	beqz	s1,800024ac <_ZN5Buddy8compressEm+0xe8>
    80002420:	0004b683          	ld	a3,0(s1)
    80002424:	08068463          	beqz	a3,800024ac <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002428:	0000a797          	auipc	a5,0xa
    8000242c:	b207b783          	ld	a5,-1248(a5) # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002430:	40f48733          	sub	a4,s1,a5
    80002434:	00c9061b          	addiw	a2,s2,12
    80002438:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    8000243c:	40f687b3          	sub	a5,a3,a5
    80002440:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002444:	00177613          	andi	a2,a4,1
    80002448:	fc0610e3          	bnez	a2,80002408 <_ZN5Buddy8compressEm+0x44>
    8000244c:	00170713          	addi	a4,a4,1
    80002450:	fbdff06f          	j	8000240c <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80002454:	00098863          	beqz	s3,80002464 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    80002458:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7fff1c60>
    8000245c:	00d9b023          	sd	a3,0(s3)
    80002460:	fb5ff06f          	j	80002414 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80002464:	0006b603          	ld	a2,0(a3)
    80002468:	00391593          	slli	a1,s2,0x3
    8000246c:	0000a697          	auipc	a3,0xa
    80002470:	adc68693          	addi	a3,a3,-1316 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002474:	00b686b3          	add	a3,a3,a1
    80002478:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    8000247c:	f8061ce3          	bnez	a2,80002414 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    80002480:	0000a697          	auipc	a3,0xa
    80002484:	ac868693          	addi	a3,a3,-1336 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002488:	00b686b3          	add	a3,a3,a1
    8000248c:	0006b823          	sd	zero,16(a3)
    80002490:	f85ff06f          	j	80002414 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80002494:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80002498:	00190593          	addi	a1,s2,1
    8000249c:	00048513          	mv	a0,s1
    800024a0:	00000097          	auipc	ra,0x0
    800024a4:	02c080e7          	jalr	44(ra) # 800024cc <_ZN5Buddy6insertEPvm>
    800024a8:	f71ff06f          	j	80002418 <_ZN5Buddy8compressEm+0x54>
}
    800024ac:	02813083          	ld	ra,40(sp)
    800024b0:	02013403          	ld	s0,32(sp)
    800024b4:	01813483          	ld	s1,24(sp)
    800024b8:	01013903          	ld	s2,16(sp)
    800024bc:	00813983          	ld	s3,8(sp)
    800024c0:	03010113          	addi	sp,sp,48
    800024c4:	00008067          	ret
    800024c8:	00008067          	ret

00000000800024cc <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    800024cc:	00050693          	mv	a3,a0
    if(!head[size]){
    800024d0:	00359713          	slli	a4,a1,0x3
    800024d4:	0000a797          	auipc	a5,0xa
    800024d8:	a7478793          	addi	a5,a5,-1420 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024dc:	00e787b3          	add	a5,a5,a4
    800024e0:	0787b783          	ld	a5,120(a5)
    800024e4:	02078c63          	beqz	a5,8000251c <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    800024e8:	ff010113          	addi	sp,sp,-16
    800024ec:	00113423          	sd	ra,8(sp)
    800024f0:	00813023          	sd	s0,0(sp)
    800024f4:	01010413          	addi	s0,sp,16
    800024f8:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    800024fc:	00068713          	mv	a4,a3
    80002500:	04f6e063          	bltu	a3,a5,80002540 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80002504:	00000613          	li	a2,0
            while (iter != nullptr) {
    80002508:	06078863          	beqz	a5,80002578 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    8000250c:	04f76c63          	bltu	a4,a5,80002564 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80002510:	00078613          	mv	a2,a5
                    iter = iter->next;
    80002514:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80002518:	ff1ff06f          	j	80002508 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    8000251c:	0000a797          	auipc	a5,0xa
    80002520:	a2c78793          	addi	a5,a5,-1492 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002524:	00e78533          	add	a0,a5,a4
    80002528:	00d53823          	sd	a3,16(a0)
    8000252c:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80002530:	0006b023          	sd	zero,0(a3)
    80002534:	07853783          	ld	a5,120(a0)
    80002538:	0007b023          	sd	zero,0(a5)
        return;
    8000253c:	00008067          	ret
            newHead->next = head[size];
    80002540:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80002544:	00359713          	slli	a4,a1,0x3
    80002548:	0000a797          	auipc	a5,0xa
    8000254c:	a0078793          	addi	a5,a5,-1536 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002550:	00e787b3          	add	a5,a5,a4
    80002554:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80002558:	00000097          	auipc	ra,0x0
    8000255c:	e6c080e7          	jalr	-404(ra) # 800023c4 <_ZN5Buddy8compressEm>
            return;
    80002560:	0440006f          	j	800025a4 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    80002564:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80002568:	00d63023          	sd	a3,0(a2)
                    compress(size);
    8000256c:	00000097          	auipc	ra,0x0
    80002570:	e58080e7          	jalr	-424(ra) # 800023c4 <_ZN5Buddy8compressEm>
                    return;
    80002574:	0300006f          	j	800025a4 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    80002578:	00351713          	slli	a4,a0,0x3
    8000257c:	0000a797          	auipc	a5,0xa
    80002580:	9cc78793          	addi	a5,a5,-1588 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002584:	00e787b3          	add	a5,a5,a4
    80002588:	0107b703          	ld	a4,16(a5)
    8000258c:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80002590:	0107b703          	ld	a4,16(a5)
    80002594:	00073703          	ld	a4,0(a4)
    80002598:	00e7b823          	sd	a4,16(a5)
    compress(size);
    8000259c:	00000097          	auipc	ra,0x0
    800025a0:	e28080e7          	jalr	-472(ra) # 800023c4 <_ZN5Buddy8compressEm>
}
    800025a4:	00813083          	ld	ra,8(sp)
    800025a8:	00013403          	ld	s0,0(sp)
    800025ac:	01010113          	addi	sp,sp,16
    800025b0:	00008067          	ret

00000000800025b4 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    800025b4:	02050663          	beqz	a0,800025e0 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    800025b8:	ff010113          	addi	sp,sp,-16
    800025bc:	00113423          	sd	ra,8(sp)
    800025c0:	00813023          	sd	s0,0(sp)
    800025c4:	01010413          	addi	s0,sp,16
    insert(addr,size);
    800025c8:	00000097          	auipc	ra,0x0
    800025cc:	f04080e7          	jalr	-252(ra) # 800024cc <_ZN5Buddy6insertEPvm>
}
    800025d0:	00813083          	ld	ra,8(sp)
    800025d4:	00013403          	ld	s0,0(sp)
    800025d8:	01010113          	addi	sp,sp,16
    800025dc:	00008067          	ret
    800025e0:	00008067          	ret

00000000800025e4 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800025e4:	ff010113          	addi	sp,sp,-16
    800025e8:	00813423          	sd	s0,8(sp)
    800025ec:	01010413          	addi	s0,sp,16
    800025f0:	03c0006f          	j	8000262c <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800025f4:	00b5859b          	addiw	a1,a1,11
    800025f8:	00100713          	li	a4,1
    800025fc:	00b715bb          	sllw	a1,a4,a1
    80002600:	00b505b3          	add	a1,a0,a1
    80002604:	00379693          	slli	a3,a5,0x3
    80002608:	0000a717          	auipc	a4,0xa
    8000260c:	94070713          	addi	a4,a4,-1728 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002610:	00d70733          	add	a4,a4,a3
    80002614:	00b73823          	sd	a1,16(a4)
    80002618:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    8000261c:	0005b023          	sd	zero,0(a1)
    80002620:	07873703          	ld	a4,120(a4)
    80002624:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002628:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    8000262c:	fff5879b          	addiw	a5,a1,-1
    80002630:	04c7c863          	blt	a5,a2,80002680 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80002634:	00379693          	slli	a3,a5,0x3
    80002638:	0000a717          	auipc	a4,0xa
    8000263c:	91070713          	addi	a4,a4,-1776 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002640:	00d70733          	add	a4,a4,a3
    80002644:	01073683          	ld	a3,16(a4)
    80002648:	fa0686e3          	beqz	a3,800025f4 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    8000264c:	00b5859b          	addiw	a1,a1,11
    80002650:	00100713          	li	a4,1
    80002654:	00b715bb          	sllw	a1,a4,a1
    80002658:	00b505b3          	add	a1,a0,a1
    8000265c:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80002660:	00379693          	slli	a3,a5,0x3
    80002664:	0000a717          	auipc	a4,0xa
    80002668:	8e470713          	addi	a4,a4,-1820 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000266c:	00d70733          	add	a4,a4,a3
    80002670:	01073683          	ld	a3,16(a4)
    80002674:	0006b683          	ld	a3,0(a3)
    80002678:	00d73823          	sd	a3,16(a4)
    8000267c:	fadff06f          	j	80002628 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80002680:	00813403          	ld	s0,8(sp)
    80002684:	01010113          	addi	sp,sp,16
    80002688:	00008067          	ret

000000008000268c <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    8000268c:	fe010113          	addi	sp,sp,-32
    80002690:	00113c23          	sd	ra,24(sp)
    80002694:	00813823          	sd	s0,16(sp)
    80002698:	00913423          	sd	s1,8(sp)
    8000269c:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    800026a0:	00c00793          	li	a5,12
    800026a4:	06a7ec63          	bltu	a5,a0,8000271c <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800026a8:	00050593          	mv	a1,a0
    800026ac:	00c00793          	li	a5,12
    800026b0:	06b7ea63          	bltu	a5,a1,80002724 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    800026b4:	00359713          	slli	a4,a1,0x3
    800026b8:	0000a797          	auipc	a5,0xa
    800026bc:	89078793          	addi	a5,a5,-1904 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026c0:	00e787b3          	add	a5,a5,a4
    800026c4:	0787b483          	ld	s1,120(a5)
    800026c8:	00049663          	bnez	s1,800026d4 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800026cc:	00158593          	addi	a1,a1,1
    800026d0:	fddff06f          	j	800026ac <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    800026d4:	0004b703          	ld	a4,0(s1)
    800026d8:	00359693          	slli	a3,a1,0x3
    800026dc:	0000a797          	auipc	a5,0xa
    800026e0:	86c78793          	addi	a5,a5,-1940 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026e4:	00d787b3          	add	a5,a5,a3
    800026e8:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    800026ec:	00070e63          	beqz	a4,80002708 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    800026f0:	0005061b          	sext.w	a2,a0
    800026f4:	0005859b          	sext.w	a1,a1
    800026f8:	00048513          	mv	a0,s1
    800026fc:	00000097          	auipc	ra,0x0
    80002700:	ee8080e7          	jalr	-280(ra) # 800025e4 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80002704:	0240006f          	j	80002728 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002708:	0000a797          	auipc	a5,0xa
    8000270c:	84078793          	addi	a5,a5,-1984 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002710:	00d787b3          	add	a5,a5,a3
    80002714:	0007b823          	sd	zero,16(a5)
    80002718:	fd9ff06f          	j	800026f0 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    8000271c:	00000493          	li	s1,0
    80002720:	0080006f          	j	80002728 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80002724:	00000493          	li	s1,0
}
    80002728:	00048513          	mv	a0,s1
    8000272c:	01813083          	ld	ra,24(sp)
    80002730:	01013403          	ld	s0,16(sp)
    80002734:	00813483          	ld	s1,8(sp)
    80002738:	02010113          	addi	sp,sp,32
    8000273c:	00008067          	ret

0000000080002740 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002740:	fe010113          	addi	sp,sp,-32
    80002744:	00113c23          	sd	ra,24(sp)
    80002748:	00813823          	sd	s0,16(sp)
    8000274c:	00913423          	sd	s1,8(sp)
    80002750:	01213023          	sd	s2,0(sp)
    80002754:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80002758:	00000913          	li	s2,0
    8000275c:	0180006f          	j	80002774 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002760:	00007517          	auipc	a0,0x7
    80002764:	bf050513          	addi	a0,a0,-1040 # 80009350 <CONSOLE_STATUS+0x340>
    80002768:	00003097          	auipc	ra,0x3
    8000276c:	b14080e7          	jalr	-1260(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80002770:	0019091b          	addiw	s2,s2,1
    80002774:	00c00793          	li	a5,12
    80002778:	0727c663          	blt	a5,s2,800027e4 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    8000277c:	00000613          	li	a2,0
    80002780:	00a00593          	li	a1,10
    80002784:	00090513          	mv	a0,s2
    80002788:	00003097          	auipc	ra,0x3
    8000278c:	b38080e7          	jalr	-1224(ra) # 800052c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80002790:	00007517          	auipc	a0,0x7
    80002794:	b1850513          	addi	a0,a0,-1256 # 800092a8 <CONSOLE_STATUS+0x298>
    80002798:	00003097          	auipc	ra,0x3
    8000279c:	ae4080e7          	jalr	-1308(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    800027a0:	00391713          	slli	a4,s2,0x3
    800027a4:	00009797          	auipc	a5,0x9
    800027a8:	7a478793          	addi	a5,a5,1956 # 8000bf48 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027ac:	00e787b3          	add	a5,a5,a4
    800027b0:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    800027b4:	fa0486e3          	beqz	s1,80002760 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    800027b8:	00000613          	li	a2,0
    800027bc:	01000593          	li	a1,16
    800027c0:	0004851b          	sext.w	a0,s1
    800027c4:	00003097          	auipc	ra,0x3
    800027c8:	afc080e7          	jalr	-1284(ra) # 800052c0 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    800027cc:	00007517          	auipc	a0,0x7
    800027d0:	91c50513          	addi	a0,a0,-1764 # 800090e8 <CONSOLE_STATUS+0xd8>
    800027d4:	00003097          	auipc	ra,0x3
    800027d8:	aa8080e7          	jalr	-1368(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    800027dc:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    800027e0:	fd5ff06f          	j	800027b4 <_ZN5Buddy9printListEv+0x74>
    800027e4:	01813083          	ld	ra,24(sp)
    800027e8:	01013403          	ld	s0,16(sp)
    800027ec:	00813483          	ld	s1,8(sp)
    800027f0:	00013903          	ld	s2,0(sp)
    800027f4:	02010113          	addi	sp,sp,32
    800027f8:	00008067          	ret

00000000800027fc <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    800027fc:	ff010113          	addi	sp,sp,-16
    80002800:	00113423          	sd	ra,8(sp)
    80002804:	00813023          	sd	s0,0(sp)
    80002808:	01010413          	addi	s0,sp,16
    8000280c:	000105b7          	lui	a1,0x10
    80002810:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002814:	00100513          	li	a0,1
    80002818:	00000097          	auipc	ra,0x0
    8000281c:	a44080e7          	jalr	-1468(ra) # 8000225c <_Z41__static_initialization_and_destruction_0ii>
    80002820:	00813083          	ld	ra,8(sp)
    80002824:	00013403          	ld	s0,0(sp)
    80002828:	01010113          	addi	sp,sp,16
    8000282c:	00008067          	ret

0000000080002830 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002830:	fe010113          	addi	sp,sp,-32
    80002834:	00113c23          	sd	ra,24(sp)
    80002838:	00813823          	sd	s0,16(sp)
    8000283c:	00913423          	sd	s1,8(sp)
    80002840:	02010413          	addi	s0,sp,32
    80002844:	00050493          	mv	s1,a0
    LOCK();
    80002848:	00100613          	li	a2,1
    8000284c:	00000593          	li	a1,0
    80002850:	00009517          	auipc	a0,0x9
    80002854:	7d850513          	addi	a0,a0,2008 # 8000c028 <lockPrint>
    80002858:	ffffe097          	auipc	ra,0xffffe
    8000285c:	7a8080e7          	jalr	1960(ra) # 80001000 <copy_and_swap>
    80002860:	fe0514e3          	bnez	a0,80002848 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002864:	0004c503          	lbu	a0,0(s1)
    80002868:	00050a63          	beqz	a0,8000287c <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	88c080e7          	jalr	-1908(ra) # 800020f8 <_Z4putcc>
        string++;
    80002874:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002878:	fedff06f          	j	80002864 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000287c:	00000613          	li	a2,0
    80002880:	00100593          	li	a1,1
    80002884:	00009517          	auipc	a0,0x9
    80002888:	7a450513          	addi	a0,a0,1956 # 8000c028 <lockPrint>
    8000288c:	ffffe097          	auipc	ra,0xffffe
    80002890:	774080e7          	jalr	1908(ra) # 80001000 <copy_and_swap>
    80002894:	fe0514e3          	bnez	a0,8000287c <_Z11printStringPKc+0x4c>
}
    80002898:	01813083          	ld	ra,24(sp)
    8000289c:	01013403          	ld	s0,16(sp)
    800028a0:	00813483          	ld	s1,8(sp)
    800028a4:	02010113          	addi	sp,sp,32
    800028a8:	00008067          	ret

00000000800028ac <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800028ac:	fd010113          	addi	sp,sp,-48
    800028b0:	02113423          	sd	ra,40(sp)
    800028b4:	02813023          	sd	s0,32(sp)
    800028b8:	00913c23          	sd	s1,24(sp)
    800028bc:	01213823          	sd	s2,16(sp)
    800028c0:	01313423          	sd	s3,8(sp)
    800028c4:	01413023          	sd	s4,0(sp)
    800028c8:	03010413          	addi	s0,sp,48
    800028cc:	00050993          	mv	s3,a0
    800028d0:	00058a13          	mv	s4,a1
    LOCK();
    800028d4:	00100613          	li	a2,1
    800028d8:	00000593          	li	a1,0
    800028dc:	00009517          	auipc	a0,0x9
    800028e0:	74c50513          	addi	a0,a0,1868 # 8000c028 <lockPrint>
    800028e4:	ffffe097          	auipc	ra,0xffffe
    800028e8:	71c080e7          	jalr	1820(ra) # 80001000 <copy_and_swap>
    800028ec:	fe0514e3          	bnez	a0,800028d4 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800028f0:	00000913          	li	s2,0
    800028f4:	00090493          	mv	s1,s2
    800028f8:	0019091b          	addiw	s2,s2,1
    800028fc:	03495a63          	bge	s2,s4,80002930 <_Z9getStringPci+0x84>
        cc = getc();
    80002900:	fffff097          	auipc	ra,0xfffff
    80002904:	7d0080e7          	jalr	2000(ra) # 800020d0 <_Z4getcv>
        if(cc < 1)
    80002908:	02050463          	beqz	a0,80002930 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000290c:	009984b3          	add	s1,s3,s1
    80002910:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002914:	00a00793          	li	a5,10
    80002918:	00f50a63          	beq	a0,a5,8000292c <_Z9getStringPci+0x80>
    8000291c:	00d00793          	li	a5,13
    80002920:	fcf51ae3          	bne	a0,a5,800028f4 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002924:	00090493          	mv	s1,s2
    80002928:	0080006f          	j	80002930 <_Z9getStringPci+0x84>
    8000292c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002930:	009984b3          	add	s1,s3,s1
    80002934:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002938:	00000613          	li	a2,0
    8000293c:	00100593          	li	a1,1
    80002940:	00009517          	auipc	a0,0x9
    80002944:	6e850513          	addi	a0,a0,1768 # 8000c028 <lockPrint>
    80002948:	ffffe097          	auipc	ra,0xffffe
    8000294c:	6b8080e7          	jalr	1720(ra) # 80001000 <copy_and_swap>
    80002950:	fe0514e3          	bnez	a0,80002938 <_Z9getStringPci+0x8c>
    return buf;
}
    80002954:	00098513          	mv	a0,s3
    80002958:	02813083          	ld	ra,40(sp)
    8000295c:	02013403          	ld	s0,32(sp)
    80002960:	01813483          	ld	s1,24(sp)
    80002964:	01013903          	ld	s2,16(sp)
    80002968:	00813983          	ld	s3,8(sp)
    8000296c:	00013a03          	ld	s4,0(sp)
    80002970:	03010113          	addi	sp,sp,48
    80002974:	00008067          	ret

0000000080002978 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002978:	ff010113          	addi	sp,sp,-16
    8000297c:	00813423          	sd	s0,8(sp)
    80002980:	01010413          	addi	s0,sp,16
    80002984:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002988:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000298c:	0006c603          	lbu	a2,0(a3)
    80002990:	fd06071b          	addiw	a4,a2,-48
    80002994:	0ff77713          	andi	a4,a4,255
    80002998:	00900793          	li	a5,9
    8000299c:	02e7e063          	bltu	a5,a4,800029bc <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800029a0:	0025179b          	slliw	a5,a0,0x2
    800029a4:	00a787bb          	addw	a5,a5,a0
    800029a8:	0017979b          	slliw	a5,a5,0x1
    800029ac:	00168693          	addi	a3,a3,1
    800029b0:	00c787bb          	addw	a5,a5,a2
    800029b4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800029b8:	fd5ff06f          	j	8000298c <_Z11stringToIntPKc+0x14>
    return n;
}
    800029bc:	00813403          	ld	s0,8(sp)
    800029c0:	01010113          	addi	sp,sp,16
    800029c4:	00008067          	ret

00000000800029c8 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800029c8:	fc010113          	addi	sp,sp,-64
    800029cc:	02113c23          	sd	ra,56(sp)
    800029d0:	02813823          	sd	s0,48(sp)
    800029d4:	02913423          	sd	s1,40(sp)
    800029d8:	03213023          	sd	s2,32(sp)
    800029dc:	01313c23          	sd	s3,24(sp)
    800029e0:	04010413          	addi	s0,sp,64
    800029e4:	00050493          	mv	s1,a0
    800029e8:	00058913          	mv	s2,a1
    800029ec:	00060993          	mv	s3,a2
    LOCK();
    800029f0:	00100613          	li	a2,1
    800029f4:	00000593          	li	a1,0
    800029f8:	00009517          	auipc	a0,0x9
    800029fc:	63050513          	addi	a0,a0,1584 # 8000c028 <lockPrint>
    80002a00:	ffffe097          	auipc	ra,0xffffe
    80002a04:	600080e7          	jalr	1536(ra) # 80001000 <copy_and_swap>
    80002a08:	fe0514e3          	bnez	a0,800029f0 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002a0c:	00098463          	beqz	s3,80002a14 <_Z8printIntiii+0x4c>
    80002a10:	0804c463          	bltz	s1,80002a98 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002a14:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002a18:	00000593          	li	a1,0
    }

    i = 0;
    80002a1c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002a20:	0009079b          	sext.w	a5,s2
    80002a24:	0325773b          	remuw	a4,a0,s2
    80002a28:	00048613          	mv	a2,s1
    80002a2c:	0014849b          	addiw	s1,s1,1
    80002a30:	02071693          	slli	a3,a4,0x20
    80002a34:	0206d693          	srli	a3,a3,0x20
    80002a38:	00009717          	auipc	a4,0x9
    80002a3c:	27870713          	addi	a4,a4,632 # 8000bcb0 <digits>
    80002a40:	00d70733          	add	a4,a4,a3
    80002a44:	00074683          	lbu	a3,0(a4)
    80002a48:	fd040713          	addi	a4,s0,-48
    80002a4c:	00c70733          	add	a4,a4,a2
    80002a50:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002a54:	0005071b          	sext.w	a4,a0
    80002a58:	0325553b          	divuw	a0,a0,s2
    80002a5c:	fcf772e3          	bgeu	a4,a5,80002a20 <_Z8printIntiii+0x58>
    if(neg)
    80002a60:	00058c63          	beqz	a1,80002a78 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002a64:	fd040793          	addi	a5,s0,-48
    80002a68:	009784b3          	add	s1,a5,s1
    80002a6c:	02d00793          	li	a5,45
    80002a70:	fef48823          	sb	a5,-16(s1)
    80002a74:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002a78:	fff4849b          	addiw	s1,s1,-1
    80002a7c:	0204c463          	bltz	s1,80002aa4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002a80:	fd040793          	addi	a5,s0,-48
    80002a84:	009787b3          	add	a5,a5,s1
    80002a88:	ff07c503          	lbu	a0,-16(a5)
    80002a8c:	fffff097          	auipc	ra,0xfffff
    80002a90:	66c080e7          	jalr	1644(ra) # 800020f8 <_Z4putcc>
    80002a94:	fe5ff06f          	j	80002a78 <_Z8printIntiii+0xb0>
        x = -xx;
    80002a98:	4090053b          	negw	a0,s1
        neg = 1;
    80002a9c:	00100593          	li	a1,1
        x = -xx;
    80002aa0:	f7dff06f          	j	80002a1c <_Z8printIntiii+0x54>

    UNLOCK();
    80002aa4:	00000613          	li	a2,0
    80002aa8:	00100593          	li	a1,1
    80002aac:	00009517          	auipc	a0,0x9
    80002ab0:	57c50513          	addi	a0,a0,1404 # 8000c028 <lockPrint>
    80002ab4:	ffffe097          	auipc	ra,0xffffe
    80002ab8:	54c080e7          	jalr	1356(ra) # 80001000 <copy_and_swap>
    80002abc:	fe0514e3          	bnez	a0,80002aa4 <_Z8printIntiii+0xdc>
    80002ac0:	03813083          	ld	ra,56(sp)
    80002ac4:	03013403          	ld	s0,48(sp)
    80002ac8:	02813483          	ld	s1,40(sp)
    80002acc:	02013903          	ld	s2,32(sp)
    80002ad0:	01813983          	ld	s3,24(sp)
    80002ad4:	04010113          	addi	sp,sp,64
    80002ad8:	00008067          	ret

0000000080002adc <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80002adc:	ff010113          	addi	sp,sp,-16
    80002ae0:	00813423          	sd	s0,8(sp)
    80002ae4:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002ae8:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002aec:	00053823          	sd	zero,16(a0)
}
    80002af0:	00813403          	ld	s0,8(sp)
    80002af4:	01010113          	addi	sp,sp,16
    80002af8:	00008067          	ret

0000000080002afc <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80002afc:	ff010113          	addi	sp,sp,-16
    80002b00:	00813423          	sd	s0,8(sp)
    80002b04:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002b08:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002b0c:	00053823          	sd	zero,16(a0)
    80002b10:	00813403          	ld	s0,8(sp)
    80002b14:	01010113          	addi	sp,sp,16
    80002b18:	00008067          	ret

0000000080002b1c <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    80002b1c:	ff010113          	addi	sp,sp,-16
    80002b20:	00113423          	sd	ra,8(sp)
    80002b24:	00813023          	sd	s0,0(sp)
    80002b28:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    80002b2c:	00000697          	auipc	a3,0x0
    80002b30:	fd068693          	addi	a3,a3,-48 # 80002afc <_ZN3SCB4dtorEPv>
    80002b34:	00000617          	auipc	a2,0x0
    80002b38:	fa860613          	addi	a2,a2,-88 # 80002adc <_ZN3SCB4ctorEPv>
    80002b3c:	01800593          	li	a1,24
    80002b40:	00006517          	auipc	a0,0x6
    80002b44:	77050513          	addi	a0,a0,1904 # 800092b0 <CONSOLE_STATUS+0x2a0>
    80002b48:	00003097          	auipc	ra,0x3
    80002b4c:	910080e7          	jalr	-1776(ra) # 80005458 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002b50:	00009797          	auipc	a5,0x9
    80002b54:	4ea7b023          	sd	a0,1248(a5) # 8000c030 <_ZN3SCB8scbCacheE>
}
    80002b58:	00813083          	ld	ra,8(sp)
    80002b5c:	00013403          	ld	s0,0(sp)
    80002b60:	01010113          	addi	sp,sp,16
    80002b64:	00008067          	ret

0000000080002b68 <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    80002b68:	ff010113          	addi	sp,sp,-16
    80002b6c:	00813423          	sd	s0,8(sp)
    80002b70:	01010413          	addi	s0,sp,16
    val = init;
    80002b74:	00b52023          	sw	a1,0(a0)
}
    80002b78:	00813403          	ld	s0,8(sp)
    80002b7c:	01010113          	addi	sp,sp,16
    80002b80:	00008067          	ret

0000000080002b84 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80002b84:	fe010113          	addi	sp,sp,-32
    80002b88:	00113c23          	sd	ra,24(sp)
    80002b8c:	00813823          	sd	s0,16(sp)
    80002b90:	00913423          	sd	s1,8(sp)
    80002b94:	01213023          	sd	s2,0(sp)
    80002b98:	02010413          	addi	s0,sp,32
    80002b9c:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002ba0:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002ba4:	02050063          	beqz	a0,80002bc4 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80002ba8:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002bac:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002bb0:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002bb4:	00002097          	auipc	ra,0x2
    80002bb8:	1f0080e7          	jalr	496(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002bbc:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002bc0:	fe5ff06f          	j	80002ba4 <_ZN3SCBD1Ev+0x20>
}
    80002bc4:	01813083          	ld	ra,24(sp)
    80002bc8:	01013403          	ld	s0,16(sp)
    80002bcc:	00813483          	ld	s1,8(sp)
    80002bd0:	00013903          	ld	s2,0(sp)
    80002bd4:	02010113          	addi	sp,sp,32
    80002bd8:	00008067          	ret

0000000080002bdc <_ZN3SCB5blockEv>:
void SCB::block() {
    80002bdc:	ff010113          	addi	sp,sp,-16
    80002be0:	00113423          	sd	ra,8(sp)
    80002be4:	00813023          	sd	s0,0(sp)
    80002be8:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002bec:	00853783          	ld	a5,8(a0)
    80002bf0:	04078063          	beqz	a5,80002c30 <_ZN3SCB5blockEv+0x54>
    80002bf4:	01053703          	ld	a4,16(a0)
    80002bf8:	00009797          	auipc	a5,0x9
    80002bfc:	2587b783          	ld	a5,600(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002c00:	0007b783          	ld	a5,0(a5)
    80002c04:	04f73423          	sd	a5,72(a4)
    80002c08:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002c0c:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002c10:	00300713          	li	a4,3
    80002c14:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002c18:	00000097          	auipc	ra,0x0
    80002c1c:	314080e7          	jalr	788(ra) # 80002f2c <_ZN3TCB8dispatchEv>
}
    80002c20:	00813083          	ld	ra,8(sp)
    80002c24:	00013403          	ld	s0,0(sp)
    80002c28:	01010113          	addi	sp,sp,16
    80002c2c:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002c30:	00009797          	auipc	a5,0x9
    80002c34:	2207b783          	ld	a5,544(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002c38:	0007b783          	ld	a5,0(a5)
    80002c3c:	00f53423          	sd	a5,8(a0)
    80002c40:	fc9ff06f          	j	80002c08 <_ZN3SCB5blockEv+0x2c>

0000000080002c44 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    80002c44:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002c48:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002c4c:	04853703          	ld	a4,72(a0)
    80002c50:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002c54:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002c58:	02050a63          	beqz	a0,80002c8c <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002c5c:	ff010113          	addi	sp,sp,-16
    80002c60:	00113423          	sd	ra,8(sp)
    80002c64:	00813023          	sd	s0,0(sp)
    80002c68:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002c6c:	00100793          	li	a5,1
    80002c70:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002c74:	00002097          	auipc	ra,0x2
    80002c78:	130080e7          	jalr	304(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>
}
    80002c7c:	00813083          	ld	ra,8(sp)
    80002c80:	00013403          	ld	s0,0(sp)
    80002c84:	01010113          	addi	sp,sp,16
    80002c88:	00008067          	ret
    80002c8c:	00008067          	ret

0000000080002c90 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80002c90:	00009797          	auipc	a5,0x9
    80002c94:	1c07b783          	ld	a5,448(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002c98:	0007b783          	ld	a5,0(a5)
    80002c9c:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002ca0:	00052783          	lw	a5,0(a0)
    80002ca4:	fff7879b          	addiw	a5,a5,-1
    80002ca8:	00f52023          	sw	a5,0(a0)
    80002cac:	02079713          	slli	a4,a5,0x20
    80002cb0:	00074463          	bltz	a4,80002cb8 <_ZN3SCB4waitEv+0x28>
    80002cb4:	00008067          	ret
void SCB::wait() {
    80002cb8:	ff010113          	addi	sp,sp,-16
    80002cbc:	00113423          	sd	ra,8(sp)
    80002cc0:	00813023          	sd	s0,0(sp)
    80002cc4:	01010413          	addi	s0,sp,16
        block();
    80002cc8:	00000097          	auipc	ra,0x0
    80002ccc:	f14080e7          	jalr	-236(ra) # 80002bdc <_ZN3SCB5blockEv>
}
    80002cd0:	00813083          	ld	ra,8(sp)
    80002cd4:	00013403          	ld	s0,0(sp)
    80002cd8:	01010113          	addi	sp,sp,16
    80002cdc:	00008067          	ret

0000000080002ce0 <_ZN3SCB6signalEv>:
    if(val++<0)
    80002ce0:	00052783          	lw	a5,0(a0)
    80002ce4:	0017871b          	addiw	a4,a5,1
    80002ce8:	00e52023          	sw	a4,0(a0)
    80002cec:	0007c463          	bltz	a5,80002cf4 <_ZN3SCB6signalEv+0x14>
    80002cf0:	00008067          	ret
void SCB::signal(){
    80002cf4:	ff010113          	addi	sp,sp,-16
    80002cf8:	00113423          	sd	ra,8(sp)
    80002cfc:	00813023          	sd	s0,0(sp)
    80002d00:	01010413          	addi	s0,sp,16
        deblock();
    80002d04:	00000097          	auipc	ra,0x0
    80002d08:	f40080e7          	jalr	-192(ra) # 80002c44 <_ZN3SCB7deblockEv>
}
    80002d0c:	00813083          	ld	ra,8(sp)
    80002d10:	00013403          	ld	s0,0(sp)
    80002d14:	01010113          	addi	sp,sp,16
    80002d18:	00008067          	ret

0000000080002d1c <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    80002d1c:	ff010113          	addi	sp,sp,-16
    80002d20:	00113423          	sd	ra,8(sp)
    80002d24:	00813023          	sd	s0,0(sp)
    80002d28:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    80002d2c:	00009517          	auipc	a0,0x9
    80002d30:	30453503          	ld	a0,772(a0) # 8000c030 <_ZN3SCB8scbCacheE>
    80002d34:	00002097          	auipc	ra,0x2
    80002d38:	74c080e7          	jalr	1868(ra) # 80005480 <_Z16kmem_cache_allocP5Cache>
}
    80002d3c:	00813083          	ld	ra,8(sp)
    80002d40:	00013403          	ld	s0,0(sp)
    80002d44:	01010113          	addi	sp,sp,16
    80002d48:	00008067          	ret

0000000080002d4c <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    80002d4c:	ff010113          	addi	sp,sp,-16
    80002d50:	00113423          	sd	ra,8(sp)
    80002d54:	00813023          	sd	s0,0(sp)
    80002d58:	01010413          	addi	s0,sp,16
    80002d5c:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80002d60:	00009517          	auipc	a0,0x9
    80002d64:	2d053503          	ld	a0,720(a0) # 8000c030 <_ZN3SCB8scbCacheE>
    80002d68:	00002097          	auipc	ra,0x2
    80002d6c:	740080e7          	jalr	1856(ra) # 800054a8 <_Z15kmem_cache_freeP5CachePv>
}
    80002d70:	00813083          	ld	ra,8(sp)
    80002d74:	00013403          	ld	s0,0(sp)
    80002d78:	01010113          	addi	sp,sp,16
    80002d7c:	00008067          	ret

0000000080002d80 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80002d80:	ff010113          	addi	sp,sp,-16
    80002d84:	00813423          	sd	s0,8(sp)
    80002d88:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002d8c:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002d90:	05200513          	li	a0,82
    asm("ecall");
    80002d94:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002d98:	00050513          	mv	a0,a0
}
    80002d9c:	0005051b          	sext.w	a0,a0
    80002da0:	00813403          	ld	s0,8(sp)
    80002da4:	01010113          	addi	sp,sp,16
    80002da8:	00008067          	ret

0000000080002dac <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002dac:	fe010113          	addi	sp,sp,-32
    80002db0:	00113c23          	sd	ra,24(sp)
    80002db4:	00813823          	sd	s0,16(sp)
    80002db8:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002dbc:	fe840513          	addi	a0,s0,-24
    80002dc0:	fffff097          	auipc	ra,0xfffff
    80002dc4:	41c080e7          	jalr	1052(ra) # 800021dc <_ZN6SystemC1Ev>

    return 0;
    80002dc8:	00000513          	li	a0,0
    80002dcc:	01813083          	ld	ra,24(sp)
    80002dd0:	01013403          	ld	s0,16(sp)
    80002dd4:	02010113          	addi	sp,sp,32
    80002dd8:	00008067          	ret

0000000080002ddc <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80002ddc:	ff010113          	addi	sp,sp,-16
    80002de0:	00813423          	sd	s0,8(sp)
    80002de4:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002de8:	00100793          	li	a5,1
    80002dec:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002df0:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002df4:	00052a23          	sw	zero,20(a0)
}
    80002df8:	00813403          	ld	s0,8(sp)
    80002dfc:	01010113          	addi	sp,sp,16
    80002e00:	00008067          	ret

0000000080002e04 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80002e04:	ff010113          	addi	sp,sp,-16
    80002e08:	00813423          	sd	s0,8(sp)
    80002e0c:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002e10:	00100793          	li	a5,1
    80002e14:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002e18:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002e1c:	00052a23          	sw	zero,20(a0)
    80002e20:	00813403          	ld	s0,8(sp)
    80002e24:	01010113          	addi	sp,sp,16
    80002e28:	00008067          	ret

0000000080002e2c <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80002e2c:	ff010113          	addi	sp,sp,-16
    80002e30:	00113423          	sd	ra,8(sp)
    80002e34:	00813023          	sd	s0,0(sp)
    80002e38:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002e3c:	00001097          	auipc	ra,0x1
    80002e40:	ff4080e7          	jalr	-12(ra) # 80003e30 <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    80002e44:	00009797          	auipc	a5,0x9
    80002e48:	1f47b783          	ld	a5,500(a5) # 8000c038 <_ZN3TCB7runningE>
    80002e4c:	0187b703          	ld	a4,24(a5)
    80002e50:	0207b503          	ld	a0,32(a5)
    80002e54:	000700e7          	jalr	a4
    thread_exit();
    80002e58:	fffff097          	auipc	ra,0xfffff
    80002e5c:	07c080e7          	jalr	124(ra) # 80001ed4 <_Z11thread_exitv>
}
    80002e60:	00813083          	ld	ra,8(sp)
    80002e64:	00013403          	ld	s0,0(sp)
    80002e68:	01010113          	addi	sp,sp,16
    80002e6c:	00008067          	ret

0000000080002e70 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002e70:	ff010113          	addi	sp,sp,-16
    80002e74:	00813423          	sd	s0,8(sp)
    80002e78:	01010413          	addi	s0,sp,16
    80002e7c:	04053823          	sd	zero,80(a0)
    80002e80:	04053c23          	sd	zero,88(a0)
    80002e84:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002e88:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002e8c:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002e90:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002e94:	02058a63          	beqz	a1,80002ec8 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80002e98:	00068793          	mv	a5,a3
    80002e9c:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002ea0:	02058863          	beqz	a1,80002ed0 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80002ea4:	000017b7          	lui	a5,0x1
    80002ea8:	00f686b3          	add	a3,a3,a5
    80002eac:	00d53023          	sd	a3,0(a0)
    80002eb0:	00000797          	auipc	a5,0x0
    80002eb4:	f7c78793          	addi	a5,a5,-132 # 80002e2c <_ZN3TCB7wrapperEPv>
    80002eb8:	00f53423          	sd	a5,8(a0)
}
    80002ebc:	00813403          	ld	s0,8(sp)
    80002ec0:	01010113          	addi	sp,sp,16
    80002ec4:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002ec8:	00000793          	li	a5,0
    80002ecc:	fd1ff06f          	j	80002e9c <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002ed0:	00000693          	li	a3,0
    80002ed4:	fd9ff06f          	j	80002eac <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080002ed8 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002ed8:	ff010113          	addi	sp,sp,-16
    80002edc:	00113423          	sd	ra,8(sp)
    80002ee0:	00813023          	sd	s0,0(sp)
    80002ee4:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002ee8:	02853503          	ld	a0,40(a0)
    80002eec:	00002097          	auipc	ra,0x2
    80002ef0:	68c080e7          	jalr	1676(ra) # 80005578 <_Z5kfreePKv>
}
    80002ef4:	00813083          	ld	ra,8(sp)
    80002ef8:	00013403          	ld	s0,0(sp)
    80002efc:	01010113          	addi	sp,sp,16
    80002f00:	00008067          	ret

0000000080002f04 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002f04:	ff010113          	addi	sp,sp,-16
    80002f08:	00113423          	sd	ra,8(sp)
    80002f0c:	00813023          	sd	s0,0(sp)
    80002f10:	01010413          	addi	s0,sp,16
    free();
    80002f14:	00000097          	auipc	ra,0x0
    80002f18:	fc4080e7          	jalr	-60(ra) # 80002ed8 <_ZN3TCB4freeEv>
}
    80002f1c:	00813083          	ld	ra,8(sp)
    80002f20:	00013403          	ld	s0,0(sp)
    80002f24:	01010113          	addi	sp,sp,16
    80002f28:	00008067          	ret

0000000080002f2c <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002f2c:	fe010113          	addi	sp,sp,-32
    80002f30:	00113c23          	sd	ra,24(sp)
    80002f34:	00813823          	sd	s0,16(sp)
    80002f38:	00913423          	sd	s1,8(sp)
    80002f3c:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002f40:	00009497          	auipc	s1,0x9
    80002f44:	0f84b483          	ld	s1,248(s1) # 8000c038 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002f48:	0104a703          	lw	a4,16(s1)
    80002f4c:	00100793          	li	a5,1
    80002f50:	04e7f663          	bgeu	a5,a4,80002f9c <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002f54:	00002097          	auipc	ra,0x2
    80002f58:	e98080e7          	jalr	-360(ra) # 80004dec <_ZN9Scheduler3getEv>
    80002f5c:	00009797          	auipc	a5,0x9
    80002f60:	0ca7be23          	sd	a0,220(a5) # 8000c038 <_ZN3TCB7runningE>
    if(running) {
    80002f64:	02050263          	beqz	a0,80002f88 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002f68:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002f6c:	00001097          	auipc	ra,0x1
    80002f70:	ff8080e7          	jalr	-8(ra) # 80003f64 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002f74:	00009597          	auipc	a1,0x9
    80002f78:	0c45b583          	ld	a1,196(a1) # 8000c038 <_ZN3TCB7runningE>
    80002f7c:	00048513          	mv	a0,s1
    80002f80:	ffffe097          	auipc	ra,0xffffe
    80002f84:	1c0080e7          	jalr	448(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002f88:	01813083          	ld	ra,24(sp)
    80002f8c:	01013403          	ld	s0,16(sp)
    80002f90:	00813483          	ld	s1,8(sp)
    80002f94:	02010113          	addi	sp,sp,32
    80002f98:	00008067          	ret
        Scheduler::put(old);
    80002f9c:	00048513          	mv	a0,s1
    80002fa0:	00002097          	auipc	ra,0x2
    80002fa4:	e04080e7          	jalr	-508(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>
    80002fa8:	fadff06f          	j	80002f54 <_ZN3TCB8dispatchEv+0x28>

0000000080002fac <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002fac:	ff010113          	addi	sp,sp,-16
    80002fb0:	00113423          	sd	ra,8(sp)
    80002fb4:	00813023          	sd	s0,0(sp)
    80002fb8:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002fbc:	00009517          	auipc	a0,0x9
    80002fc0:	08453503          	ld	a0,132(a0) # 8000c040 <_ZN3TCB8tcbCacheE>
    80002fc4:	00002097          	auipc	ra,0x2
    80002fc8:	4bc080e7          	jalr	1212(ra) # 80005480 <_Z16kmem_cache_allocP5Cache>
}
    80002fcc:	00813083          	ld	ra,8(sp)
    80002fd0:	00013403          	ld	s0,0(sp)
    80002fd4:	01010113          	addi	sp,sp,16
    80002fd8:	00008067          	ret

0000000080002fdc <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002fdc:	fe010113          	addi	sp,sp,-32
    80002fe0:	00113c23          	sd	ra,24(sp)
    80002fe4:	00813823          	sd	s0,16(sp)
    80002fe8:	00913423          	sd	s1,8(sp)
    80002fec:	01213023          	sd	s2,0(sp)
    80002ff0:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    80002ff4:	00000697          	auipc	a3,0x0
    80002ff8:	e1068693          	addi	a3,a3,-496 # 80002e04 <_ZN3TCB4dtorEPv>
    80002ffc:	00000617          	auipc	a2,0x0
    80003000:	de060613          	addi	a2,a2,-544 # 80002ddc <_ZN3TCB4ctorEPv>
    80003004:	07000593          	li	a1,112
    80003008:	00006517          	auipc	a0,0x6
    8000300c:	2b850513          	addi	a0,a0,696 # 800092c0 <CONSOLE_STATUS+0x2b0>
    80003010:	00002097          	auipc	ra,0x2
    80003014:	448080e7          	jalr	1096(ra) # 80005458 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80003018:	00009797          	auipc	a5,0x9
    8000301c:	02a7b423          	sd	a0,40(a5) # 8000c040 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80003020:	07000513          	li	a0,112
    80003024:	00000097          	auipc	ra,0x0
    80003028:	f88080e7          	jalr	-120(ra) # 80002fac <_ZN3TCBnwEm>
    8000302c:	00050493          	mv	s1,a0
    80003030:	00050e63          	beqz	a0,8000304c <_ZN3TCB10initializeEv+0x70>
    80003034:	00200713          	li	a4,2
    80003038:	00000693          	li	a3,0
    8000303c:	00000613          	li	a2,0
    80003040:	00000593          	li	a1,0
    80003044:	00000097          	auipc	ra,0x0
    80003048:	e2c080e7          	jalr	-468(ra) # 80002e70 <_ZN3TCBC1EPFvPvES0_Pmm>
    8000304c:	00009797          	auipc	a5,0x9
    80003050:	fe97b623          	sd	s1,-20(a5) # 8000c038 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    80003054:	00100793          	li	a5,1
    80003058:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    8000305c:	00001537          	lui	a0,0x1
    80003060:	00002097          	auipc	ra,0x2
    80003064:	4f0080e7          	jalr	1264(ra) # 80005550 <_Z7kmallocm>
    80003068:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    8000306c:	07000513          	li	a0,112
    80003070:	00000097          	auipc	ra,0x0
    80003074:	f3c080e7          	jalr	-196(ra) # 80002fac <_ZN3TCBnwEm>
    80003078:	00050493          	mv	s1,a0
    8000307c:	02050063          	beqz	a0,8000309c <_ZN3TCB10initializeEv+0xc0>
    80003080:	00200713          	li	a4,2
    80003084:	00090693          	mv	a3,s2
    80003088:	00000613          	li	a2,0
    8000308c:	00009597          	auipc	a1,0x9
    80003090:	d645b583          	ld	a1,-668(a1) # 8000bdf0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003094:	00000097          	auipc	ra,0x0
    80003098:	ddc080e7          	jalr	-548(ra) # 80002e70 <_ZN3TCBC1EPFvPvES0_Pmm>
    8000309c:	00009797          	auipc	a5,0x9
    800030a0:	fa97b623          	sd	s1,-84(a5) # 8000c048 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    800030a4:	00100793          	li	a5,1
    800030a8:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    800030ac:	00048513          	mv	a0,s1
    800030b0:	00002097          	auipc	ra,0x2
    800030b4:	cf4080e7          	jalr	-780(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>
}
    800030b8:	01813083          	ld	ra,24(sp)
    800030bc:	01013403          	ld	s0,16(sp)
    800030c0:	00813483          	ld	s1,8(sp)
    800030c4:	00013903          	ld	s2,0(sp)
    800030c8:	02010113          	addi	sp,sp,32
    800030cc:	00008067          	ret

00000000800030d0 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    800030d0:	ff010113          	addi	sp,sp,-16
    800030d4:	00113423          	sd	ra,8(sp)
    800030d8:	00813023          	sd	s0,0(sp)
    800030dc:	01010413          	addi	s0,sp,16
    800030e0:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    800030e4:	00009517          	auipc	a0,0x9
    800030e8:	f5c53503          	ld	a0,-164(a0) # 8000c040 <_ZN3TCB8tcbCacheE>
    800030ec:	00002097          	auipc	ra,0x2
    800030f0:	3bc080e7          	jalr	956(ra) # 800054a8 <_Z15kmem_cache_freeP5CachePv>
}
    800030f4:	00813083          	ld	ra,8(sp)
    800030f8:	00013403          	ld	s0,0(sp)
    800030fc:	01010113          	addi	sp,sp,16
    80003100:	00008067          	ret

0000000080003104 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    80003104:	ff010113          	addi	sp,sp,-16
    80003108:	00813423          	sd	s0,8(sp)
    8000310c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80003110:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80003114:	05100513          	li	a0,81
    asm("ecall");
    80003118:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000311c:	00050513          	mv	a0,a0
}
    80003120:	0005051b          	sext.w	a0,a0
    80003124:	00813403          	ld	s0,8(sp)
    80003128:	01010113          	addi	sp,sp,16
    8000312c:	00008067          	ret

0000000080003130 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80003130:	ff010113          	addi	sp,sp,-16
    80003134:	00813423          	sd	s0,8(sp)
    80003138:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    8000313c:	00009797          	auipc	a5,0x9
    80003140:	ca47b783          	ld	a5,-860(a5) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003144:	0007b783          	ld	a5,0(a5)
    80003148:	00c7d793          	srli	a5,a5,0xc
    8000314c:	00278793          	addi	a5,a5,2
    80003150:	00c79793          	slli	a5,a5,0xc
    80003154:	01000737          	lui	a4,0x1000
    80003158:	00e787b3          	add	a5,a5,a4
    8000315c:	00009717          	auipc	a4,0x9
    80003160:	f0c70713          	addi	a4,a4,-244 # 8000c068 <_ZN15MemoryAllocator11freeMemTailE>
    80003164:	00f73023          	sd	a5,0(a4)
    80003168:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    8000316c:	0007b823          	sd	zero,16(a5)
    80003170:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80003174:	00073823          	sd	zero,16(a4)
    80003178:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    8000317c:	00009697          	auipc	a3,0x9
    80003180:	ce46b683          	ld	a3,-796(a3) # 8000be60 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003184:	0006b683          	ld	a3,0(a3)
    80003188:	40f686b3          	sub	a3,a3,a5
    8000318c:	fe868693          	addi	a3,a3,-24
    80003190:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80003194:	00873783          	ld	a5,8(a4)
    80003198:	0007b823          	sd	zero,16(a5)

    initialized = true;
    8000319c:	00100793          	li	a5,1
    800031a0:	02f70023          	sb	a5,32(a4)
}
    800031a4:	00813403          	ld	s0,8(sp)
    800031a8:	01010113          	addi	sp,sp,16
    800031ac:	00008067          	ret

00000000800031b0 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800031b0:	ff010113          	addi	sp,sp,-16
    800031b4:	00813423          	sd	s0,8(sp)
    800031b8:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    800031bc:	14050663          	beqz	a0,80003308 <_ZN15MemoryAllocator7kmallocEm+0x158>
    800031c0:	00050793          	mv	a5,a0
    800031c4:	00009517          	auipc	a0,0x9
    800031c8:	eac53503          	ld	a0,-340(a0) # 8000c070 <_ZN15MemoryAllocator11freeMemHeadE>
    800031cc:	0a050e63          	beqz	a0,80003288 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    800031d0:	00053703          	ld	a4,0(a0)
    800031d4:	12f76e63          	bltu	a4,a5,80003310 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    800031d8:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    800031dc:	00000613          	li	a2,0
    800031e0:	00c0006f          	j	800031ec <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    800031e4:	00050613          	mv	a2,a0
    800031e8:	01053503          	ld	a0,16(a0)
    800031ec:	00050863          	beqz	a0,800031fc <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    800031f0:	00053683          	ld	a3,0(a0)
    800031f4:	01878713          	addi	a4,a5,24
    800031f8:	fee6e6e3          	bltu	a3,a4,800031e4 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    800031fc:	08050663          	beqz	a0,80003288 <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    80003200:	00053683          	ld	a3,0(a0)
    80003204:	01868713          	addi	a4,a3,24
    80003208:	00e50733          	add	a4,a0,a4
    8000320c:	00009597          	auipc	a1,0x9
    80003210:	c545b583          	ld	a1,-940(a1) # 8000be60 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003214:	0005b583          	ld	a1,0(a1)
    80003218:	00b76463          	bltu	a4,a1,80003220 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    8000321c:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80003220:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80003224:	05700593          	li	a1,87
    80003228:	08d5f063          	bgeu	a1,a3,800032a8 <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    8000322c:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80003230:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80003234:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80003238:	01053583          	ld	a1,16(a0)
    8000323c:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80003240:	00853583          	ld	a1,8(a0)
    80003244:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80003248:	fe868693          	addi	a3,a3,-24
    8000324c:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80003250:	04060263          	beqz	a2,80003294 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80003254:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80003258:	00009797          	auipc	a5,0x9
    8000325c:	e287b783          	ld	a5,-472(a5) # 8000c080 <_ZN15MemoryAllocator12allocMemHeadE>
    80003260:	06078463          	beqz	a5,800032c8 <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80003264:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80003268:	08070063          	beqz	a4,800032e8 <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    8000326c:	00873783          	ld	a5,8(a4)
    80003270:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80003274:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80003278:	00873783          	ld	a5,8(a4)
    8000327c:	06078063          	beqz	a5,800032dc <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    80003280:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80003284:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80003288:	00813403          	ld	s0,8(sp)
    8000328c:	01010113          	addi	sp,sp,16
    80003290:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80003294:	00009697          	auipc	a3,0x9
    80003298:	dd468693          	addi	a3,a3,-556 # 8000c068 <_ZN15MemoryAllocator11freeMemTailE>
    8000329c:	00f6b023          	sd	a5,0(a3)
    800032a0:	00f6b423          	sd	a5,8(a3)
    800032a4:	fb5ff06f          	j	80003258 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    800032a8:	00060863          	beqz	a2,800032b8 <_ZN15MemoryAllocator7kmallocEm+0x108>
    800032ac:	01053783          	ld	a5,16(a0)
    800032b0:	00f63823          	sd	a5,16(a2)
    800032b4:	fa5ff06f          	j	80003258 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    800032b8:	01053783          	ld	a5,16(a0)
    800032bc:	00009697          	auipc	a3,0x9
    800032c0:	daf6ba23          	sd	a5,-588(a3) # 8000c070 <_ZN15MemoryAllocator11freeMemHeadE>
    800032c4:	f95ff06f          	j	80003258 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    800032c8:	00009797          	auipc	a5,0x9
    800032cc:	da078793          	addi	a5,a5,-608 # 8000c068 <_ZN15MemoryAllocator11freeMemTailE>
    800032d0:	00a7b823          	sd	a0,16(a5)
    800032d4:	00a7bc23          	sd	a0,24(a5)
    800032d8:	fadff06f          	j	80003284 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    800032dc:	00009797          	auipc	a5,0x9
    800032e0:	daa7b223          	sd	a0,-604(a5) # 8000c080 <_ZN15MemoryAllocator12allocMemHeadE>
    800032e4:	fa1ff06f          	j	80003284 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    800032e8:	00009797          	auipc	a5,0x9
    800032ec:	d8078793          	addi	a5,a5,-640 # 8000c068 <_ZN15MemoryAllocator11freeMemTailE>
    800032f0:	0107b703          	ld	a4,16(a5)
    800032f4:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    800032f8:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    800032fc:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80003300:	00a7b823          	sd	a0,16(a5)
    80003304:	f81ff06f          	j	80003284 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    80003308:	00000513          	li	a0,0
    8000330c:	f7dff06f          	j	80003288 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80003310:	00000513          	li	a0,0
    80003314:	f75ff06f          	j	80003288 <_ZN15MemoryAllocator7kmallocEm+0xd8>

0000000080003318 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80003318:	ff010113          	addi	sp,sp,-16
    8000331c:	00813423          	sd	s0,8(sp)
    80003320:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80003324:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003328:	00000713          	li	a4,0
    8000332c:	00078a63          	beqz	a5,80003340 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80003330:	00a7f863          	bgeu	a5,a0,80003340 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003334:	00078713          	mv	a4,a5
    80003338:	0107b783          	ld	a5,16(a5)
    8000333c:	ff1ff06f          	j	8000332c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80003340:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80003344:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80003348:	00078463          	beqz	a5,80003350 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    8000334c:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80003350:	02070263          	beqz	a4,80003374 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003354:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80003358:	0005b703          	ld	a4,0(a1)
    8000335c:	00009797          	auipc	a5,0x9
    80003360:	d147b783          	ld	a5,-748(a5) # 8000c070 <_ZN15MemoryAllocator11freeMemHeadE>
    80003364:	00f70c63          	beq	a4,a5,8000337c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80003368:	00813403          	ld	s0,8(sp)
    8000336c:	01010113          	addi	sp,sp,16
    80003370:	00008067          	ret
        *head = blk;
    80003374:	00a5b023          	sd	a0,0(a1)
    80003378:	fe1ff06f          	j	80003358 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    8000337c:	01053783          	ld	a5,16(a0)
    80003380:	00078a63          	beqz	a5,80003394 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80003384:	00053683          	ld	a3,0(a0)
    80003388:	00d50733          	add	a4,a0,a3
    8000338c:	01870713          	addi	a4,a4,24
    80003390:	02f70e63          	beq	a4,a5,800033cc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80003394:	00853783          	ld	a5,8(a0)
    80003398:	fc0788e3          	beqz	a5,80003368 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    8000339c:	0007b683          	ld	a3,0(a5)
    800033a0:	00d78733          	add	a4,a5,a3
    800033a4:	01870713          	addi	a4,a4,24
    800033a8:	fca710e3          	bne	a4,a0,80003368 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    800033ac:	00053703          	ld	a4,0(a0)
    800033b0:	00e68733          	add	a4,a3,a4
    800033b4:	01870713          	addi	a4,a4,24
    800033b8:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    800033bc:	00853783          	ld	a5,8(a0)
    800033c0:	01053703          	ld	a4,16(a0)
    800033c4:	00e7b823          	sd	a4,16(a5)
}
    800033c8:	fa1ff06f          	j	80003368 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    800033cc:	0007b703          	ld	a4,0(a5)
    800033d0:	00e68733          	add	a4,a3,a4
    800033d4:	01870713          	addi	a4,a4,24
    800033d8:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    800033dc:	0107b783          	ld	a5,16(a5)
    800033e0:	00f53823          	sd	a5,16(a0)
    800033e4:	fb1ff06f          	j	80003394 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

00000000800033e8 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    800033e8:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    800033ec:	00009697          	auipc	a3,0x9
    800033f0:	c946b683          	ld	a3,-876(a3) # 8000c080 <_ZN15MemoryAllocator12allocMemHeadE>
    800033f4:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    800033f8:	00050a63          	beqz	a0,8000340c <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    800033fc:	fe870793          	addi	a5,a4,-24
    80003400:	00a78663          	beq	a5,a0,8000340c <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80003404:	01053503          	ld	a0,16(a0)
    80003408:	ff1ff06f          	j	800033f8 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    8000340c:	08050463          	beqz	a0,80003494 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80003410:	ff010113          	addi	sp,sp,-16
    80003414:	00113423          	sd	ra,8(sp)
    80003418:	00813023          	sd	s0,0(sp)
    8000341c:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80003420:	00009797          	auipc	a5,0x9
    80003424:	c587b783          	ld	a5,-936(a5) # 8000c078 <_ZN15MemoryAllocator12allocMemTailE>
    80003428:	04a78663          	beq	a5,a0,80003474 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    8000342c:	04d50c63          	beq	a0,a3,80003484 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80003430:	01053783          	ld	a5,16(a0)
    80003434:	00078663          	beqz	a5,80003440 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80003438:	00853703          	ld	a4,8(a0)
    8000343c:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80003440:	00853783          	ld	a5,8(a0)
    80003444:	00078663          	beqz	a5,80003450 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80003448:	01053703          	ld	a4,16(a0)
    8000344c:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80003450:	00009597          	auipc	a1,0x9
    80003454:	c2058593          	addi	a1,a1,-992 # 8000c070 <_ZN15MemoryAllocator11freeMemHeadE>
    80003458:	00000097          	auipc	ra,0x0
    8000345c:	ec0080e7          	jalr	-320(ra) # 80003318 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80003460:	00000513          	li	a0,0
}
    80003464:	00813083          	ld	ra,8(sp)
    80003468:	00013403          	ld	s0,0(sp)
    8000346c:	01010113          	addi	sp,sp,16
    80003470:	00008067          	ret
            allocMemTail = blk->prev;
    80003474:	00853783          	ld	a5,8(a0)
    80003478:	00009717          	auipc	a4,0x9
    8000347c:	c0f73023          	sd	a5,-1024(a4) # 8000c078 <_ZN15MemoryAllocator12allocMemTailE>
    80003480:	fadff06f          	j	8000342c <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80003484:	01053783          	ld	a5,16(a0)
    80003488:	00009717          	auipc	a4,0x9
    8000348c:	bef73c23          	sd	a5,-1032(a4) # 8000c080 <_ZN15MemoryAllocator12allocMemHeadE>
    80003490:	fa1ff06f          	j	80003430 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80003494:	fff00513          	li	a0,-1
}
    80003498:	00008067          	ret

000000008000349c <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    8000349c:	fe010113          	addi	sp,sp,-32
    800034a0:	00113c23          	sd	ra,24(sp)
    800034a4:	00813823          	sd	s0,16(sp)
    800034a8:	00913423          	sd	s1,8(sp)
    800034ac:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    800034b0:	00009497          	auipc	s1,0x9
    800034b4:	bd04b483          	ld	s1,-1072(s1) # 8000c080 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    800034b8:	00006517          	auipc	a0,0x6
    800034bc:	e1850513          	addi	a0,a0,-488 # 800092d0 <CONSOLE_STATUS+0x2c0>
    800034c0:	fffff097          	auipc	ra,0xfffff
    800034c4:	370080e7          	jalr	880(ra) # 80002830 <_Z11printStringPKc>
    while(iter!=nullptr){
    800034c8:	04048663          	beqz	s1,80003514 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800034cc:	00000613          	li	a2,0
    800034d0:	00a00593          	li	a1,10
    800034d4:	0004851b          	sext.w	a0,s1
    800034d8:	fffff097          	auipc	ra,0xfffff
    800034dc:	4f0080e7          	jalr	1264(ra) # 800029c8 <_Z8printIntiii>
        putc(' ');
    800034e0:	02000513          	li	a0,32
    800034e4:	fffff097          	auipc	ra,0xfffff
    800034e8:	c14080e7          	jalr	-1004(ra) # 800020f8 <_Z4putcc>
        printInt(iter->size);
    800034ec:	00000613          	li	a2,0
    800034f0:	00a00593          	li	a1,10
    800034f4:	0004a503          	lw	a0,0(s1)
    800034f8:	fffff097          	auipc	ra,0xfffff
    800034fc:	4d0080e7          	jalr	1232(ra) # 800029c8 <_Z8printIntiii>
        putc('\n');
    80003500:	00a00513          	li	a0,10
    80003504:	fffff097          	auipc	ra,0xfffff
    80003508:	bf4080e7          	jalr	-1036(ra) # 800020f8 <_Z4putcc>
        iter=iter->next;
    8000350c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003510:	fb9ff06f          	j	800034c8 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80003514:	00006517          	auipc	a0,0x6
    80003518:	ddc50513          	addi	a0,a0,-548 # 800092f0 <CONSOLE_STATUS+0x2e0>
    8000351c:	fffff097          	auipc	ra,0xfffff
    80003520:	314080e7          	jalr	788(ra) # 80002830 <_Z11printStringPKc>
    iter = freeMemHead;
    80003524:	00009497          	auipc	s1,0x9
    80003528:	b4c4b483          	ld	s1,-1204(s1) # 8000c070 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    8000352c:	04048663          	beqz	s1,80003578 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80003530:	00000613          	li	a2,0
    80003534:	00a00593          	li	a1,10
    80003538:	0004851b          	sext.w	a0,s1
    8000353c:	fffff097          	auipc	ra,0xfffff
    80003540:	48c080e7          	jalr	1164(ra) # 800029c8 <_Z8printIntiii>
        putc(' ');
    80003544:	02000513          	li	a0,32
    80003548:	fffff097          	auipc	ra,0xfffff
    8000354c:	bb0080e7          	jalr	-1104(ra) # 800020f8 <_Z4putcc>
        printInt(iter->size);
    80003550:	00000613          	li	a2,0
    80003554:	00a00593          	li	a1,10
    80003558:	0004a503          	lw	a0,0(s1)
    8000355c:	fffff097          	auipc	ra,0xfffff
    80003560:	46c080e7          	jalr	1132(ra) # 800029c8 <_Z8printIntiii>
        putc('\n');
    80003564:	00a00513          	li	a0,10
    80003568:	fffff097          	auipc	ra,0xfffff
    8000356c:	b90080e7          	jalr	-1136(ra) # 800020f8 <_Z4putcc>
        iter=iter->next;
    80003570:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003574:	fb9ff06f          	j	8000352c <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80003578:	00006517          	auipc	a0,0x6
    8000357c:	d9850513          	addi	a0,a0,-616 # 80009310 <CONSOLE_STATUS+0x300>
    80003580:	fffff097          	auipc	ra,0xfffff
    80003584:	2b0080e7          	jalr	688(ra) # 80002830 <_Z11printStringPKc>
}
    80003588:	01813083          	ld	ra,24(sp)
    8000358c:	01013403          	ld	s0,16(sp)
    80003590:	00813483          	ld	s1,8(sp)
    80003594:	02010113          	addi	sp,sp,32
    80003598:	00008067          	ret

000000008000359c <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    8000359c:	ff010113          	addi	sp,sp,-16
    800035a0:	00813423          	sd	s0,8(sp)
    800035a4:	01010413          	addi	s0,sp,16
    800035a8:	00050813          	mv	a6,a0
    800035ac:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    800035b0:	00000793          	li	a5,0
    800035b4:	00c7fe63          	bgeu	a5,a2,800035d0 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    800035b8:	00f50733          	add	a4,a0,a5
    800035bc:	00f806b3          	add	a3,a6,a5
    800035c0:	0006c683          	lbu	a3,0(a3)
    800035c4:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    800035c8:	00178793          	addi	a5,a5,1
    800035cc:	fe9ff06f          	j	800035b4 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800035d0:	00813403          	ld	s0,8(sp)
    800035d4:	01010113          	addi	sp,sp,16
    800035d8:	00008067          	ret

00000000800035dc <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    800035dc:	ff010113          	addi	sp,sp,-16
    800035e0:	00113423          	sd	ra,8(sp)
    800035e4:	00813023          	sd	s0,0(sp)
    800035e8:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    800035ec:	00053783          	ld	a5,0(a0)
    800035f0:	0107b783          	ld	a5,16(a5)
    800035f4:	000780e7          	jalr	a5
}
    800035f8:	00813083          	ld	ra,8(sp)
    800035fc:	00013403          	ld	s0,0(sp)
    80003600:	01010113          	addi	sp,sp,16
    80003604:	00008067          	ret

0000000080003608 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80003608:	ff010113          	addi	sp,sp,-16
    8000360c:	00113423          	sd	ra,8(sp)
    80003610:	00813023          	sd	s0,0(sp)
    80003614:	01010413          	addi	s0,sp,16
    80003618:	00008797          	auipc	a5,0x8
    8000361c:	6f878793          	addi	a5,a5,1784 # 8000bd10 <_ZTV9Semaphore+0x10>
    80003620:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80003624:	00853503          	ld	a0,8(a0)
    80003628:	fffff097          	auipc	ra,0xfffff
    8000362c:	9f8080e7          	jalr	-1544(ra) # 80002020 <_Z9sem_closeP10_semaphore>
};
    80003630:	00813083          	ld	ra,8(sp)
    80003634:	00013403          	ld	s0,0(sp)
    80003638:	01010113          	addi	sp,sp,16
    8000363c:	00008067          	ret

0000000080003640 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80003640:	00008797          	auipc	a5,0x8
    80003644:	6f078793          	addi	a5,a5,1776 # 8000bd30 <_ZTV6Thread+0x10>
    80003648:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000364c:	00853503          	ld	a0,8(a0)
    80003650:	02050663          	beqz	a0,8000367c <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80003654:	ff010113          	addi	sp,sp,-16
    80003658:	00113423          	sd	ra,8(sp)
    8000365c:	00813023          	sd	s0,0(sp)
    80003660:	01010413          	addi	s0,sp,16
    delete myHandle;
    80003664:	fffff097          	auipc	ra,0xfffff
    80003668:	b08080e7          	jalr	-1272(ra) # 8000216c <_ZN7_threaddlEPv>
}
    8000366c:	00813083          	ld	ra,8(sp)
    80003670:	00013403          	ld	s0,0(sp)
    80003674:	01010113          	addi	sp,sp,16
    80003678:	00008067          	ret
    8000367c:	00008067          	ret

0000000080003680 <_Znwm>:
void* operator new(size_t sz){
    80003680:	ff010113          	addi	sp,sp,-16
    80003684:	00113423          	sd	ra,8(sp)
    80003688:	00813023          	sd	s0,0(sp)
    8000368c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003690:	ffffe097          	auipc	ra,0xffffe
    80003694:	75c080e7          	jalr	1884(ra) # 80001dec <_Z9mem_allocm>
}
    80003698:	00813083          	ld	ra,8(sp)
    8000369c:	00013403          	ld	s0,0(sp)
    800036a0:	01010113          	addi	sp,sp,16
    800036a4:	00008067          	ret

00000000800036a8 <_Znam>:
void* operator new[](size_t sz){
    800036a8:	ff010113          	addi	sp,sp,-16
    800036ac:	00113423          	sd	ra,8(sp)
    800036b0:	00813023          	sd	s0,0(sp)
    800036b4:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800036b8:	ffffe097          	auipc	ra,0xffffe
    800036bc:	734080e7          	jalr	1844(ra) # 80001dec <_Z9mem_allocm>
}
    800036c0:	00813083          	ld	ra,8(sp)
    800036c4:	00013403          	ld	s0,0(sp)
    800036c8:	01010113          	addi	sp,sp,16
    800036cc:	00008067          	ret

00000000800036d0 <_ZdlPv>:
void operator delete(void *ptr){
    800036d0:	ff010113          	addi	sp,sp,-16
    800036d4:	00113423          	sd	ra,8(sp)
    800036d8:	00813023          	sd	s0,0(sp)
    800036dc:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800036e0:	ffffe097          	auipc	ra,0xffffe
    800036e4:	73c080e7          	jalr	1852(ra) # 80001e1c <_Z8mem_freePv>
}
    800036e8:	00813083          	ld	ra,8(sp)
    800036ec:	00013403          	ld	s0,0(sp)
    800036f0:	01010113          	addi	sp,sp,16
    800036f4:	00008067          	ret

00000000800036f8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    800036f8:	fe010113          	addi	sp,sp,-32
    800036fc:	00113c23          	sd	ra,24(sp)
    80003700:	00813823          	sd	s0,16(sp)
    80003704:	00913423          	sd	s1,8(sp)
    80003708:	02010413          	addi	s0,sp,32
    8000370c:	00050493          	mv	s1,a0
};
    80003710:	00000097          	auipc	ra,0x0
    80003714:	ef8080e7          	jalr	-264(ra) # 80003608 <_ZN9SemaphoreD1Ev>
    80003718:	00048513          	mv	a0,s1
    8000371c:	00000097          	auipc	ra,0x0
    80003720:	fb4080e7          	jalr	-76(ra) # 800036d0 <_ZdlPv>
    80003724:	01813083          	ld	ra,24(sp)
    80003728:	01013403          	ld	s0,16(sp)
    8000372c:	00813483          	ld	s1,8(sp)
    80003730:	02010113          	addi	sp,sp,32
    80003734:	00008067          	ret

0000000080003738 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80003738:	fe010113          	addi	sp,sp,-32
    8000373c:	00113c23          	sd	ra,24(sp)
    80003740:	00813823          	sd	s0,16(sp)
    80003744:	00913423          	sd	s1,8(sp)
    80003748:	02010413          	addi	s0,sp,32
    8000374c:	00050493          	mv	s1,a0
}
    80003750:	00000097          	auipc	ra,0x0
    80003754:	ef0080e7          	jalr	-272(ra) # 80003640 <_ZN6ThreadD1Ev>
    80003758:	00048513          	mv	a0,s1
    8000375c:	00000097          	auipc	ra,0x0
    80003760:	f74080e7          	jalr	-140(ra) # 800036d0 <_ZdlPv>
    80003764:	01813083          	ld	ra,24(sp)
    80003768:	01013403          	ld	s0,16(sp)
    8000376c:	00813483          	ld	s1,8(sp)
    80003770:	02010113          	addi	sp,sp,32
    80003774:	00008067          	ret

0000000080003778 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80003778:	ff010113          	addi	sp,sp,-16
    8000377c:	00113423          	sd	ra,8(sp)
    80003780:	00813023          	sd	s0,0(sp)
    80003784:	01010413          	addi	s0,sp,16
    80003788:	00008797          	auipc	a5,0x8
    8000378c:	58878793          	addi	a5,a5,1416 # 8000bd10 <_ZTV9Semaphore+0x10>
    80003790:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80003794:	00850513          	addi	a0,a0,8
    80003798:	fffff097          	auipc	ra,0xfffff
    8000379c:	850080e7          	jalr	-1968(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
}
    800037a0:	00813083          	ld	ra,8(sp)
    800037a4:	00013403          	ld	s0,0(sp)
    800037a8:	01010113          	addi	sp,sp,16
    800037ac:	00008067          	ret

00000000800037b0 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    800037b0:	ff010113          	addi	sp,sp,-16
    800037b4:	00113423          	sd	ra,8(sp)
    800037b8:	00813023          	sd	s0,0(sp)
    800037bc:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800037c0:	00853503          	ld	a0,8(a0)
    800037c4:	fffff097          	auipc	ra,0xfffff
    800037c8:	888080e7          	jalr	-1912(ra) # 8000204c <_Z8sem_waitP10_semaphore>
}
    800037cc:	00813083          	ld	ra,8(sp)
    800037d0:	00013403          	ld	s0,0(sp)
    800037d4:	01010113          	addi	sp,sp,16
    800037d8:	00008067          	ret

00000000800037dc <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800037dc:	ff010113          	addi	sp,sp,-16
    800037e0:	00113423          	sd	ra,8(sp)
    800037e4:	00813023          	sd	s0,0(sp)
    800037e8:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800037ec:	00853503          	ld	a0,8(a0)
    800037f0:	fffff097          	auipc	ra,0xfffff
    800037f4:	888080e7          	jalr	-1912(ra) # 80002078 <_Z10sem_signalP10_semaphore>
}
    800037f8:	00813083          	ld	ra,8(sp)
    800037fc:	00013403          	ld	s0,0(sp)
    80003800:	01010113          	addi	sp,sp,16
    80003804:	00008067          	ret

0000000080003808 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80003808:	fe010113          	addi	sp,sp,-32
    8000380c:	00113c23          	sd	ra,24(sp)
    80003810:	00813823          	sd	s0,16(sp)
    80003814:	00913423          	sd	s1,8(sp)
    80003818:	02010413          	addi	s0,sp,32
    8000381c:	00050493          	mv	s1,a0
    80003820:	00008797          	auipc	a5,0x8
    80003824:	51078793          	addi	a5,a5,1296 # 8000bd30 <_ZTV6Thread+0x10>
    80003828:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    8000382c:	00850513          	addi	a0,a0,8
    80003830:	ffffe097          	auipc	ra,0xffffe
    80003834:	6ec080e7          	jalr	1772(ra) # 80001f1c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80003838:	fff00793          	li	a5,-1
    8000383c:	00f50c63          	beq	a0,a5,80003854 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    80003840:	01813083          	ld	ra,24(sp)
    80003844:	01013403          	ld	s0,16(sp)
    80003848:	00813483          	ld	s1,8(sp)
    8000384c:	02010113          	addi	sp,sp,32
    80003850:	00008067          	ret
        myHandle = nullptr;
    80003854:	0004b423          	sd	zero,8(s1)
}
    80003858:	fe9ff06f          	j	80003840 <_ZN6ThreadC1EPFvPvES0_+0x38>

000000008000385c <_ZN6ThreadC1Ev>:
Thread::Thread() {
    8000385c:	fe010113          	addi	sp,sp,-32
    80003860:	00113c23          	sd	ra,24(sp)
    80003864:	00813823          	sd	s0,16(sp)
    80003868:	00913423          	sd	s1,8(sp)
    8000386c:	02010413          	addi	s0,sp,32
    80003870:	00050493          	mv	s1,a0
    80003874:	00008797          	auipc	a5,0x8
    80003878:	4bc78793          	addi	a5,a5,1212 # 8000bd30 <_ZTV6Thread+0x10>
    8000387c:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    80003880:	00050613          	mv	a2,a0
    80003884:	00000597          	auipc	a1,0x0
    80003888:	d5858593          	addi	a1,a1,-680 # 800035dc <_ZN6Thread7wrapperEPv>
    8000388c:	00850513          	addi	a0,a0,8
    80003890:	ffffe097          	auipc	ra,0xffffe
    80003894:	68c080e7          	jalr	1676(ra) # 80001f1c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80003898:	fff00793          	li	a5,-1
    8000389c:	00f50c63          	beq	a0,a5,800038b4 <_ZN6ThreadC1Ev+0x58>
}
    800038a0:	01813083          	ld	ra,24(sp)
    800038a4:	01013403          	ld	s0,16(sp)
    800038a8:	00813483          	ld	s1,8(sp)
    800038ac:	02010113          	addi	sp,sp,32
    800038b0:	00008067          	ret
        myHandle = nullptr;
    800038b4:	0004b423          	sd	zero,8(s1)
}
    800038b8:	fe9ff06f          	j	800038a0 <_ZN6ThreadC1Ev+0x44>

00000000800038bc <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    800038bc:	ff010113          	addi	sp,sp,-16
    800038c0:	00113423          	sd	ra,8(sp)
    800038c4:	00813023          	sd	s0,0(sp)
    800038c8:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    800038cc:	ffffe097          	auipc	ra,0xffffe
    800038d0:	7d8080e7          	jalr	2008(ra) # 800020a4 <_Z10time_sleepm>
}
    800038d4:	00813083          	ld	ra,8(sp)
    800038d8:	00013403          	ld	s0,0(sp)
    800038dc:	01010113          	addi	sp,sp,16
    800038e0:	00008067          	ret

00000000800038e4 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    800038e4:	fe010113          	addi	sp,sp,-32
    800038e8:	00113c23          	sd	ra,24(sp)
    800038ec:	00813823          	sd	s0,16(sp)
    800038f0:	00913423          	sd	s1,8(sp)
    800038f4:	01213023          	sd	s2,0(sp)
    800038f8:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    800038fc:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80003900:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80003904:	0004b783          	ld	a5,0(s1)
    80003908:	0187b783          	ld	a5,24(a5)
    8000390c:	00048513          	mv	a0,s1
    80003910:	000780e7          	jalr	a5
        pt->sleep(time);
    80003914:	00090513          	mv	a0,s2
    80003918:	00000097          	auipc	ra,0x0
    8000391c:	fa4080e7          	jalr	-92(ra) # 800038bc <_ZN6Thread5sleepEm>
    while(true){
    80003920:	fe5ff06f          	j	80003904 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080003924 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80003924:	ff010113          	addi	sp,sp,-16
    80003928:	00113423          	sd	ra,8(sp)
    8000392c:	00813023          	sd	s0,0(sp)
    80003930:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003934:	ffffe097          	auipc	ra,0xffffe
    80003938:	5c8080e7          	jalr	1480(ra) # 80001efc <_Z15thread_dispatchv>
}
    8000393c:	00813083          	ld	ra,8(sp)
    80003940:	00013403          	ld	s0,0(sp)
    80003944:	01010113          	addi	sp,sp,16
    80003948:	00008067          	ret

000000008000394c <_ZN6Thread5startEv>:
int Thread::start() {
    8000394c:	ff010113          	addi	sp,sp,-16
    80003950:	00113423          	sd	ra,8(sp)
    80003954:	00813023          	sd	s0,0(sp)
    80003958:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    8000395c:	00853503          	ld	a0,8(a0)
    80003960:	ffffe097          	auipc	ra,0xffffe
    80003964:	650080e7          	jalr	1616(ra) # 80001fb0 <_Z12thread_startP7_thread>
}
    80003968:	00813083          	ld	ra,8(sp)
    8000396c:	00013403          	ld	s0,0(sp)
    80003970:	01010113          	addi	sp,sp,16
    80003974:	00008067          	ret

0000000080003978 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003978:	fe010113          	addi	sp,sp,-32
    8000397c:	00113c23          	sd	ra,24(sp)
    80003980:	00813823          	sd	s0,16(sp)
    80003984:	00913423          	sd	s1,8(sp)
    80003988:	01213023          	sd	s2,0(sp)
    8000398c:	02010413          	addi	s0,sp,32
    80003990:	00050493          	mv	s1,a0
    80003994:	00058913          	mv	s2,a1
    80003998:	01000513          	li	a0,16
    8000399c:	00000097          	auipc	ra,0x0
    800039a0:	ce4080e7          	jalr	-796(ra) # 80003680 <_Znwm>
    800039a4:	00050613          	mv	a2,a0
    800039a8:	00050663          	beqz	a0,800039b4 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    800039ac:	00953023          	sd	s1,0(a0)
    800039b0:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800039b4:	00000597          	auipc	a1,0x0
    800039b8:	f3058593          	addi	a1,a1,-208 # 800038e4 <_ZN14PeriodicThread7wrapperEPv>
    800039bc:	00048513          	mv	a0,s1
    800039c0:	00000097          	auipc	ra,0x0
    800039c4:	e48080e7          	jalr	-440(ra) # 80003808 <_ZN6ThreadC1EPFvPvES0_>
    800039c8:	00008797          	auipc	a5,0x8
    800039cc:	31878793          	addi	a5,a5,792 # 8000bce0 <_ZTV14PeriodicThread+0x10>
    800039d0:	00f4b023          	sd	a5,0(s1)
    800039d4:	01813083          	ld	ra,24(sp)
    800039d8:	01013403          	ld	s0,16(sp)
    800039dc:	00813483          	ld	s1,8(sp)
    800039e0:	00013903          	ld	s2,0(sp)
    800039e4:	02010113          	addi	sp,sp,32
    800039e8:	00008067          	ret

00000000800039ec <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    800039ec:	ff010113          	addi	sp,sp,-16
    800039f0:	00113423          	sd	ra,8(sp)
    800039f4:	00813023          	sd	s0,0(sp)
    800039f8:	01010413          	addi	s0,sp,16
    return ::getc();
    800039fc:	ffffe097          	auipc	ra,0xffffe
    80003a00:	6d4080e7          	jalr	1748(ra) # 800020d0 <_Z4getcv>
}
    80003a04:	00813083          	ld	ra,8(sp)
    80003a08:	00013403          	ld	s0,0(sp)
    80003a0c:	01010113          	addi	sp,sp,16
    80003a10:	00008067          	ret

0000000080003a14 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003a14:	ff010113          	addi	sp,sp,-16
    80003a18:	00113423          	sd	ra,8(sp)
    80003a1c:	00813023          	sd	s0,0(sp)
    80003a20:	01010413          	addi	s0,sp,16
    ::putc(c);
    80003a24:	ffffe097          	auipc	ra,0xffffe
    80003a28:	6d4080e7          	jalr	1748(ra) # 800020f8 <_Z4putcc>
}
    80003a2c:	00813083          	ld	ra,8(sp)
    80003a30:	00013403          	ld	s0,0(sp)
    80003a34:	01010113          	addi	sp,sp,16
    80003a38:	00008067          	ret

0000000080003a3c <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003a3c:	ff010113          	addi	sp,sp,-16
    80003a40:	00813423          	sd	s0,8(sp)
    80003a44:	01010413          	addi	s0,sp,16
    80003a48:	00813403          	ld	s0,8(sp)
    80003a4c:	01010113          	addi	sp,sp,16
    80003a50:	00008067          	ret

0000000080003a54 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80003a54:	ff010113          	addi	sp,sp,-16
    80003a58:	00813423          	sd	s0,8(sp)
    80003a5c:	01010413          	addi	s0,sp,16
    80003a60:	00813403          	ld	s0,8(sp)
    80003a64:	01010113          	addi	sp,sp,16
    80003a68:	00008067          	ret

0000000080003a6c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80003a6c:	ff010113          	addi	sp,sp,-16
    80003a70:	00113423          	sd	ra,8(sp)
    80003a74:	00813023          	sd	s0,0(sp)
    80003a78:	01010413          	addi	s0,sp,16
    80003a7c:	00008797          	auipc	a5,0x8
    80003a80:	26478793          	addi	a5,a5,612 # 8000bce0 <_ZTV14PeriodicThread+0x10>
    80003a84:	00f53023          	sd	a5,0(a0)
    80003a88:	00000097          	auipc	ra,0x0
    80003a8c:	bb8080e7          	jalr	-1096(ra) # 80003640 <_ZN6ThreadD1Ev>
    80003a90:	00813083          	ld	ra,8(sp)
    80003a94:	00013403          	ld	s0,0(sp)
    80003a98:	01010113          	addi	sp,sp,16
    80003a9c:	00008067          	ret

0000000080003aa0 <_ZN14PeriodicThreadD0Ev>:
    80003aa0:	fe010113          	addi	sp,sp,-32
    80003aa4:	00113c23          	sd	ra,24(sp)
    80003aa8:	00813823          	sd	s0,16(sp)
    80003aac:	00913423          	sd	s1,8(sp)
    80003ab0:	02010413          	addi	s0,sp,32
    80003ab4:	00050493          	mv	s1,a0
    80003ab8:	00008797          	auipc	a5,0x8
    80003abc:	22878793          	addi	a5,a5,552 # 8000bce0 <_ZTV14PeriodicThread+0x10>
    80003ac0:	00f53023          	sd	a5,0(a0)
    80003ac4:	00000097          	auipc	ra,0x0
    80003ac8:	b7c080e7          	jalr	-1156(ra) # 80003640 <_ZN6ThreadD1Ev>
    80003acc:	00048513          	mv	a0,s1
    80003ad0:	00000097          	auipc	ra,0x0
    80003ad4:	c00080e7          	jalr	-1024(ra) # 800036d0 <_ZdlPv>
    80003ad8:	01813083          	ld	ra,24(sp)
    80003adc:	01013403          	ld	s0,16(sp)
    80003ae0:	00813483          	ld	s1,8(sp)
    80003ae4:	02010113          	addi	sp,sp,32
    80003ae8:	00008067          	ret

0000000080003aec <_ZN5RiscV6getPMTEv>:
uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;
void* RiscV::kPMT = nullptr;
void* RiscV::uPMT = nullptr;

void* RiscV::getPMT(){
    80003aec:	ff010113          	addi	sp,sp,-16
    80003af0:	00113423          	sd	ra,8(sp)
    80003af4:	00813023          	sd	s0,0(sp)
    80003af8:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    80003afc:	00100513          	li	a0,1
    80003b00:	fffff097          	auipc	ra,0xfffff
    80003b04:	b8c080e7          	jalr	-1140(ra) # 8000268c <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80003b08:	00000793          	li	a5,0
    80003b0c:	1ff00713          	li	a4,511
    80003b10:	00f74c63          	blt	a4,a5,80003b28 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    80003b14:	00379713          	slli	a4,a5,0x3
    80003b18:	00e50733          	add	a4,a0,a4
    80003b1c:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    80003b20:	0017879b          	addiw	a5,a5,1
    80003b24:	fe9ff06f          	j	80003b0c <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    80003b28:	00813083          	ld	ra,8(sp)
    80003b2c:	00013403          	ld	s0,0(sp)
    80003b30:	01010113          	addi	sp,sp,16
    80003b34:	00008067          	ret

0000000080003b38 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    80003b38:	fc010113          	addi	sp,sp,-64
    80003b3c:	02113c23          	sd	ra,56(sp)
    80003b40:	02813823          	sd	s0,48(sp)
    80003b44:	02913423          	sd	s1,40(sp)
    80003b48:	03213023          	sd	s2,32(sp)
    80003b4c:	01313c23          	sd	s3,24(sp)
    80003b50:	01413823          	sd	s4,16(sp)
    80003b54:	01513423          	sd	s5,8(sp)
    80003b58:	04010413          	addi	s0,sp,64
    80003b5c:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    80003b60:	01e5d793          	srli	a5,a1,0x1e
    80003b64:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    80003b68:	0155d913          	srli	s2,a1,0x15
    80003b6c:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    80003b70:	00c5d493          	srli	s1,a1,0xc
    80003b74:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80003b78:	00379793          	slli	a5,a5,0x3
    80003b7c:	00f50ab3          	add	s5,a0,a5
    80003b80:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80003b84:	06078263          	beqz	a5,80003be8 <_ZN5RiscV15handlePageFaultEPvmm+0xb0>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80003b88:	00a7d513          	srli	a0,a5,0xa
    80003b8c:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    80003b90:	00391913          	slli	s2,s2,0x3
    80003b94:	01250933          	add	s2,a0,s2
    80003b98:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    80003b9c:	06050463          	beqz	a0,80003c04 <_ZN5RiscV15handlePageFaultEPvmm+0xcc>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    80003ba0:	00a55513          	srli	a0,a0,0xa
    80003ba4:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    80003ba8:	003a1a13          	slli	s4,s4,0x3
    80003bac:	01450533          	add	a0,a0,s4
    80003bb0:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0)
    80003bb4:	00079863          	bnez	a5,80003bc4 <_ZN5RiscV15handlePageFaultEPvmm+0x8c>
        ((uint64*)pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    80003bb8:	00a49493          	slli	s1,s1,0xa
    80003bbc:	0134e9b3          	or	s3,s1,s3
    80003bc0:	01353023          	sd	s3,0(a0)
}
    80003bc4:	03813083          	ld	ra,56(sp)
    80003bc8:	03013403          	ld	s0,48(sp)
    80003bcc:	02813483          	ld	s1,40(sp)
    80003bd0:	02013903          	ld	s2,32(sp)
    80003bd4:	01813983          	ld	s3,24(sp)
    80003bd8:	01013a03          	ld	s4,16(sp)
    80003bdc:	00813a83          	ld	s5,8(sp)
    80003be0:	04010113          	addi	sp,sp,64
    80003be4:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80003be8:	00000097          	auipc	ra,0x0
    80003bec:	f04080e7          	jalr	-252(ra) # 80003aec <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    80003bf0:	00c55793          	srli	a5,a0,0xc
    80003bf4:	00a79793          	slli	a5,a5,0xa
    80003bf8:	0017e793          	ori	a5,a5,1
    80003bfc:	00fab023          	sd	a5,0(s5)
    80003c00:	f91ff06f          	j	80003b90 <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    80003c04:	00000097          	auipc	ra,0x0
    80003c08:	ee8080e7          	jalr	-280(ra) # 80003aec <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    80003c0c:	00c55793          	srli	a5,a0,0xc
    80003c10:	00a79793          	slli	a5,a5,0xa
    80003c14:	0017e793          	ori	a5,a5,1
    80003c18:	00f93023          	sd	a5,0(s2)
    80003c1c:	f8dff06f          	j	80003ba8 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

0000000080003c20 <_ZN5RiscV10initializeEv>:
//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80003c20:	fc010113          	addi	sp,sp,-64
    80003c24:	02113c23          	sd	ra,56(sp)
    80003c28:	02813823          	sd	s0,48(sp)
    80003c2c:	02913423          	sd	s1,40(sp)
    80003c30:	03213023          	sd	s2,32(sp)
    80003c34:	01313c23          	sd	s3,24(sp)
    80003c38:	01413823          	sd	s4,16(sp)
    80003c3c:	01513423          	sd	s5,8(sp)
    80003c40:	04010413          	addi	s0,sp,64
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003c44:	00008797          	auipc	a5,0x8
    80003c48:	1ec7b783          	ld	a5,492(a5) # 8000be30 <_GLOBAL_OFFSET_TABLE_+0x68>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80003c4c:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80003c50:	00008797          	auipc	a5,0x8
    80003c54:	1907b783          	ld	a5,400(a5) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003c58:	0007b503          	ld	a0,0(a5)
    80003c5c:	00c55513          	srli	a0,a0,0xc
    80003c60:	00250513          	addi	a0,a0,2
    80003c64:	000015b7          	lui	a1,0x1
    80003c68:	00c51513          	slli	a0,a0,0xc
    80003c6c:	00001097          	auipc	ra,0x1
    80003c70:	7c4080e7          	jalr	1988(ra) # 80005430 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80003c74:	fffff097          	auipc	ra,0xfffff
    80003c78:	4bc080e7          	jalr	1212(ra) # 80003130 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80003c7c:	00001097          	auipc	ra,0x1
    80003c80:	110080e7          	jalr	272(ra) # 80004d8c <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80003c84:	fffff097          	auipc	ra,0xfffff
    80003c88:	358080e7          	jalr	856(ra) # 80002fdc <_ZN3TCB10initializeEv>
    SCB::initialize();
    80003c8c:	fffff097          	auipc	ra,0xfffff
    80003c90:	e90080e7          	jalr	-368(ra) # 80002b1c <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80003c94:	00001097          	auipc	ra,0x1
    80003c98:	30c080e7          	jalr	780(ra) # 80004fa0 <_ZN11ConsoleUtil10initializeEv>
    RiscV::kPMT = RiscV::getPMT();
    80003c9c:	00000097          	auipc	ra,0x0
    80003ca0:	e50080e7          	jalr	-432(ra) # 80003aec <_ZN5RiscV6getPMTEv>
    80003ca4:	00008497          	auipc	s1,0x8
    80003ca8:	3ec48493          	addi	s1,s1,1004 # 8000c090 <_ZN5RiscV4kPMTE>
    80003cac:	00a4b023          	sd	a0,0(s1)
    RiscV::uPMT = RiscV::getPMT();
    80003cb0:	00000097          	auipc	ra,0x0
    80003cb4:	e3c080e7          	jalr	-452(ra) # 80003aec <_ZN5RiscV6getPMTEv>
    80003cb8:	00a4b423          	sd	a0,8(s1)
    for(uint64 i=0x80000000;i<(uint64)HEAP_END_ADDR;i+=4096) {
    80003cbc:	00100493          	li	s1,1
    80003cc0:	01f49493          	slli	s1,s1,0x1f
    80003cc4:	00008797          	auipc	a5,0x8
    80003cc8:	19c7b783          	ld	a5,412(a5) # 8000be60 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003ccc:	0007b783          	ld	a5,0(a5)
    80003cd0:	04f4f063          	bgeu	s1,a5,80003d10 <_ZN5RiscV10initializeEv+0xf0>
        handlePageFault(kPMT,i, 0xf);
    80003cd4:	00008917          	auipc	s2,0x8
    80003cd8:	3bc90913          	addi	s2,s2,956 # 8000c090 <_ZN5RiscV4kPMTE>
    80003cdc:	00f00613          	li	a2,15
    80003ce0:	00048593          	mv	a1,s1
    80003ce4:	00093503          	ld	a0,0(s2)
    80003ce8:	00000097          	auipc	ra,0x0
    80003cec:	e50080e7          	jalr	-432(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
        handlePageFault(uPMT,i, 0x1f);
    80003cf0:	01f00613          	li	a2,31
    80003cf4:	00048593          	mv	a1,s1
    80003cf8:	00893503          	ld	a0,8(s2)
    80003cfc:	00000097          	auipc	ra,0x0
    80003d00:	e3c080e7          	jalr	-452(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=0x80000000;i<(uint64)HEAP_END_ADDR;i+=4096) {
    80003d04:	000017b7          	lui	a5,0x1
    80003d08:	00f484b3          	add	s1,s1,a5
    80003d0c:	fb9ff06f          	j	80003cc4 <_ZN5RiscV10initializeEv+0xa4>
    }

    handlePageFault(kPMT, (uint64)CONSOLE_RX_DATA,0xf);
    80003d10:	00008797          	auipc	a5,0x8
    80003d14:	0c07b783          	ld	a5,192(a5) # 8000bdd0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003d18:	0007ba83          	ld	s5,0(a5)
    80003d1c:	00008497          	auipc	s1,0x8
    80003d20:	37448493          	addi	s1,s1,884 # 8000c090 <_ZN5RiscV4kPMTE>
    80003d24:	00f00613          	li	a2,15
    80003d28:	000a8593          	mv	a1,s5
    80003d2c:	0004b503          	ld	a0,0(s1)
    80003d30:	00000097          	auipc	ra,0x0
    80003d34:	e08080e7          	jalr	-504(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)CONSOLE_TX_DATA,0xf);
    80003d38:	00008797          	auipc	a5,0x8
    80003d3c:	0c07b783          	ld	a5,192(a5) # 8000bdf8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003d40:	0007ba03          	ld	s4,0(a5)
    80003d44:	00f00613          	li	a2,15
    80003d48:	000a0593          	mv	a1,s4
    80003d4c:	0004b503          	ld	a0,0(s1)
    80003d50:	00000097          	auipc	ra,0x0
    80003d54:	de8080e7          	jalr	-536(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)CONSOLE_STATUS,0xf);
    80003d58:	00008797          	auipc	a5,0x8
    80003d5c:	0807b783          	ld	a5,128(a5) # 8000bdd8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003d60:	0007b983          	ld	s3,0(a5)
    80003d64:	00f00613          	li	a2,15
    80003d68:	00098593          	mv	a1,s3
    80003d6c:	0004b503          	ld	a0,0(s1)
    80003d70:	00000097          	auipc	ra,0x0
    80003d74:	dc8080e7          	jalr	-568(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)0xc201004,0xf);
    80003d78:	00f00613          	li	a2,15
    80003d7c:	0c201937          	lui	s2,0xc201
    80003d80:	00490593          	addi	a1,s2,4 # c201004 <_entry-0x73dfeffc>
    80003d84:	0004b503          	ld	a0,0(s1)
    80003d88:	00000097          	auipc	ra,0x0
    80003d8c:	db0080e7          	jalr	-592(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(uPMT, (uint64)CONSOLE_RX_DATA,0x1f);
    80003d90:	01f00613          	li	a2,31
    80003d94:	000a8593          	mv	a1,s5
    80003d98:	0084b503          	ld	a0,8(s1)
    80003d9c:	00000097          	auipc	ra,0x0
    80003da0:	d9c080e7          	jalr	-612(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(uPMT, (uint64)CONSOLE_TX_DATA,0x1f);
    80003da4:	01f00613          	li	a2,31
    80003da8:	000a0593          	mv	a1,s4
    80003dac:	0084b503          	ld	a0,8(s1)
    80003db0:	00000097          	auipc	ra,0x0
    80003db4:	d88080e7          	jalr	-632(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(uPMT, (uint64)CONSOLE_STATUS,0x1f);
    80003db8:	01f00613          	li	a2,31
    80003dbc:	00098593          	mv	a1,s3
    80003dc0:	0084b503          	ld	a0,8(s1)
    80003dc4:	00000097          	auipc	ra,0x0
    80003dc8:	d74080e7          	jalr	-652(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(uPMT, (uint64)0xc201004,0x1f);
    80003dcc:	01f00613          	li	a2,31
    80003dd0:	00490593          	addi	a1,s2,4
    80003dd4:	0084b503          	ld	a0,8(s1)
    80003dd8:	00000097          	auipc	ra,0x0
    80003ddc:	d60080e7          	jalr	-672(ra) # 80003b38 <_ZN5RiscV15handlePageFaultEPvmm>

    uint64 satp = ((uint64)1<<63) | ((uint64)(RiscV::kPMT)>>12);
    80003de0:	0004b783          	ld	a5,0(s1)
    80003de4:	00c7d793          	srli	a5,a5,0xc
    80003de8:	fff00713          	li	a4,-1
    80003dec:	03f71713          	slli	a4,a4,0x3f
    80003df0:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80003df4:	18079073          	csrw	satp,a5
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003df8:	00200793          	li	a5,2
    80003dfc:	1047a073          	csrs	sie,a5
    80003e00:	20000713          	li	a4,512
    80003e04:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003e08:	1007a073          	csrs	sstatus,a5

    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80003e0c:	03813083          	ld	ra,56(sp)
    80003e10:	03013403          	ld	s0,48(sp)
    80003e14:	02813483          	ld	s1,40(sp)
    80003e18:	02013903          	ld	s2,32(sp)
    80003e1c:	01813983          	ld	s3,24(sp)
    80003e20:	01013a03          	ld	s4,16(sp)
    80003e24:	00813a83          	ld	s5,8(sp)
    80003e28:	04010113          	addi	sp,sp,64
    80003e2c:	00008067          	ret

0000000080003e30 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003e30:	ff010113          	addi	sp,sp,-16
    80003e34:	00813423          	sd	s0,8(sp)
    80003e38:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003e3c:	14109073          	csrw	sepc,ra
    asm("sret");
    80003e40:	10200073          	sret
}
    80003e44:	00813403          	ld	s0,8(sp)
    80003e48:	01010113          	addi	sp,sp,16
    80003e4c:	00008067          	ret

0000000080003e50 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003e50:	ff010113          	addi	sp,sp,-16
    80003e54:	00113423          	sd	ra,8(sp)
    80003e58:	00813023          	sd	s0,0(sp)
    80003e5c:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003e60:	00008797          	auipc	a5,0x8
    80003e64:	ff07b783          	ld	a5,-16(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003e68:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003e6c:	00100713          	li	a4,1
    80003e70:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003e74:	fffff097          	auipc	ra,0xfffff
    80003e78:	0b8080e7          	jalr	184(ra) # 80002f2c <_ZN3TCB8dispatchEv>
}
    80003e7c:	00813083          	ld	ra,8(sp)
    80003e80:	00013403          	ld	s0,0(sp)
    80003e84:	01010113          	addi	sp,sp,16
    80003e88:	00008067          	ret

0000000080003e8c <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003e8c:	ff010113          	addi	sp,sp,-16
    80003e90:	00113423          	sd	ra,8(sp)
    80003e94:	00813023          	sd	s0,0(sp)
    80003e98:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003e9c:	00008797          	auipc	a5,0x8
    80003ea0:	2047c783          	lbu	a5,516(a5) # 8000c0a0 <_ZN5RiscV16userMainFinishedE>
    80003ea4:	00079c63          	bnez	a5,80003ebc <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003ea8:	00008717          	auipc	a4,0x8
    80003eac:	fa073703          	ld	a4,-96(a4) # 8000be48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003eb0:	00073783          	ld	a5,0(a4)
    80003eb4:	00178793          	addi	a5,a5,1
    80003eb8:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003ebc:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003ec0:	0ff57513          	andi	a0,a0,255
    80003ec4:	00001097          	auipc	ra,0x1
    80003ec8:	2b0080e7          	jalr	688(ra) # 80005174 <_ZN11ConsoleUtil9putOutputEc>
}
    80003ecc:	00813083          	ld	ra,8(sp)
    80003ed0:	00013403          	ld	s0,0(sp)
    80003ed4:	01010113          	addi	sp,sp,16
    80003ed8:	00008067          	ret

0000000080003edc <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003edc:	fe010113          	addi	sp,sp,-32
    80003ee0:	00113c23          	sd	ra,24(sp)
    80003ee4:	00813823          	sd	s0,16(sp)
    80003ee8:	02010413          	addi	s0,sp,32
    80003eec:	00c0006f          	j	80003ef8 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80003ef0:	ffffe097          	auipc	ra,0xffffe
    80003ef4:	00c080e7          	jalr	12(ra) # 80001efc <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80003ef8:	00008797          	auipc	a5,0x8
    80003efc:	ee07b783          	ld	a5,-288(a5) # 8000bdd8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003f00:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003f04:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003f08:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003f0c:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003f10:	0207f793          	andi	a5,a5,32
    80003f14:	fc078ee3          	beqz	a5,80003ef0 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003f18:	00001097          	auipc	ra,0x1
    80003f1c:	4f0080e7          	jalr	1264(ra) # 80005408 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003f20:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003f24:	00008797          	auipc	a5,0x8
    80003f28:	eac7b783          	ld	a5,-340(a5) # 8000bdd0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003f2c:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003f30:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003f34:	fef44783          	lbu	a5,-17(s0)
    80003f38:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003f3c:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003f40:	00008797          	auipc	a5,0x8
    80003f44:	f087b783          	ld	a5,-248(a5) # 8000be48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003f48:	0007b783          	ld	a5,0(a5)
    80003f4c:	fa0786e3          	beqz	a5,80003ef8 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003f50:	fff78793          	addi	a5,a5,-1
    80003f54:	00008717          	auipc	a4,0x8
    80003f58:	ef473703          	ld	a4,-268(a4) # 8000be48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003f5c:	00f73023          	sd	a5,0(a4)
    80003f60:	f99ff06f          	j	80003ef8 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003f64 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003f64:	ff010113          	addi	sp,sp,-16
    80003f68:	00813423          	sd	s0,8(sp)
    80003f6c:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80003f70:	00008797          	auipc	a5,0x8
    80003f74:	ee07b783          	ld	a5,-288(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003f78:	0007b783          	ld	a5,0(a5)
    80003f7c:	0147a703          	lw	a4,20(a5)
    80003f80:	00100793          	li	a5,1
    80003f84:	02f70a63          	beq	a4,a5,80003fb8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x54>
        uint64 satp = ((uint64)1<<63) | ((uint64)(RiscV::kPMT)>>12);
        asm("csrw satp, %[satp]" : : [satp] "r" (satp));
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        uint64 satp = ((uint64)1<<63) | ((uint64)(RiscV::uPMT)>>12);
    80003f88:	00008797          	auipc	a5,0x8
    80003f8c:	1107b783          	ld	a5,272(a5) # 8000c098 <_ZN5RiscV4uPMTE>
    80003f90:	00c7d793          	srli	a5,a5,0xc
    80003f94:	fff00713          	li	a4,-1
    80003f98:	03f71713          	slli	a4,a4,0x3f
    80003f9c:	00e7e7b3          	or	a5,a5,a4
        asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80003fa0:	18079073          	csrw	satp,a5
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003fa4:	10000793          	li	a5,256
    80003fa8:	1007b073          	csrc	sstatus,a5
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    80003fac:	00813403          	ld	s0,8(sp)
    80003fb0:	01010113          	addi	sp,sp,16
    80003fb4:	00008067          	ret
        uint64 satp = ((uint64)1<<63) | ((uint64)(RiscV::kPMT)>>12);
    80003fb8:	00008797          	auipc	a5,0x8
    80003fbc:	0d87b783          	ld	a5,216(a5) # 8000c090 <_ZN5RiscV4kPMTE>
    80003fc0:	00c7d793          	srli	a5,a5,0xc
    80003fc4:	fff00713          	li	a4,-1
    80003fc8:	03f71713          	slli	a4,a4,0x3f
    80003fcc:	00e7e7b3          	or	a5,a5,a4
        asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80003fd0:	18079073          	csrw	satp,a5
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003fd4:	10000793          	li	a5,256
    80003fd8:	1007a073          	csrs	sstatus,a5
}
    80003fdc:	fd1ff06f          	j	80003fac <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x48>

0000000080003fe0 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80003fe0:	ff010113          	addi	sp,sp,-16
    80003fe4:	00113423          	sd	ra,8(sp)
    80003fe8:	00813023          	sd	s0,0(sp)
    80003fec:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80003ff0:	00100793          	li	a5,1
    80003ff4:	00008717          	auipc	a4,0x8
    80003ff8:	0af70623          	sb	a5,172(a4) # 8000c0a0 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003ffc:	00008797          	auipc	a5,0x8
    80004000:	e4c7b783          	ld	a5,-436(a5) # 8000be48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80004004:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80004008:	00008797          	auipc	a5,0x8
    8000400c:	df87b783          	ld	a5,-520(a5) # 8000be00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004010:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80004014:	00200793          	li	a5,2
    80004018:	1047b073          	csrc	sie,a5
    8000401c:	20000793          	li	a5,512
    80004020:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80004024:	00008797          	auipc	a5,0x8
    80004028:	dfc7b783          	ld	a5,-516(a5) # 8000be20 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000402c:	0007b783          	ld	a5,0(a5)
    80004030:	00078c63          	beqz	a5,80004048 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80004034:	0487b703          	ld	a4,72(a5)
    80004038:	00008797          	auipc	a5,0x8
    8000403c:	de87b783          	ld	a5,-536(a5) # 8000be20 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004040:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80004044:	fe1ff06f          	j	80004024 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80004048:	00008797          	auipc	a5,0x8
    8000404c:	de07b783          	ld	a5,-544(a5) # 8000be28 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004050:	0007b503          	ld	a0,0(a5)
    80004054:	00001097          	auipc	ra,0x1
    80004058:	d50080e7          	jalr	-688(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000405c:	00008797          	auipc	a5,0x8
    80004060:	ddc7b783          	ld	a5,-548(a5) # 8000be38 <_GLOBAL_OFFSET_TABLE_+0x70>
    80004064:	0007b703          	ld	a4,0(a5)
    80004068:	00008797          	auipc	a5,0x8
    8000406c:	dd87b783          	ld	a5,-552(a5) # 8000be40 <_GLOBAL_OFFSET_TABLE_+0x78>
    80004070:	0007b783          	ld	a5,0(a5)
    80004074:	00f70863          	beq	a4,a5,80004084 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80004078:	ffffe097          	auipc	ra,0xffffe
    8000407c:	e84080e7          	jalr	-380(ra) # 80001efc <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80004080:	fddff06f          	j	8000405c <_ZN5RiscV8finalizeEv+0x7c>
}
    80004084:	00813083          	ld	ra,8(sp)
    80004088:	00013403          	ld	s0,0(sp)
    8000408c:	01010113          	addi	sp,sp,16
    80004090:	00008067          	ret

0000000080004094 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80004094:	ff010113          	addi	sp,sp,-16
    80004098:	00813423          	sd	s0,8(sp)
    8000409c:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    800040a0:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    800040a4:	00008717          	auipc	a4,0x8
    800040a8:	dac73703          	ld	a4,-596(a4) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800040ac:	00073703          	ld	a4,0(a4)
    800040b0:	06873703          	ld	a4,104(a4)
    800040b4:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    800040b8:	04a5b823          	sd	a0,80(a1) # 1050 <_entry-0x7fffefb0>
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800040bc:	00078593          	mv	a1,a5
}
    800040c0:	00813403          	ld	s0,8(sp)
    800040c4:	01010113          	addi	sp,sp,16
    800040c8:	00008067          	ret

00000000800040cc <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    800040cc:	ff010113          	addi	sp,sp,-16
    800040d0:	00113423          	sd	ra,8(sp)
    800040d4:	00813023          	sd	s0,0(sp)
    800040d8:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    800040dc:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    800040e0:	fffff097          	auipc	ra,0xfffff
    800040e4:	0d0080e7          	jalr	208(ra) # 800031b0 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    800040e8:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800040ec:	00000097          	auipc	ra,0x0
    800040f0:	fa8080e7          	jalr	-88(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    800040f4:	00813083          	ld	ra,8(sp)
    800040f8:	00013403          	ld	s0,0(sp)
    800040fc:	01010113          	addi	sp,sp,16
    80004100:	00008067          	ret

0000000080004104 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80004104:	ff010113          	addi	sp,sp,-16
    80004108:	00113423          	sd	ra,8(sp)
    8000410c:	00813023          	sd	s0,0(sp)
    80004110:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80004114:	00008797          	auipc	a5,0x8
    80004118:	d447b783          	ld	a5,-700(a5) # 8000be58 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000411c:	0007c783          	lbu	a5,0(a5)
    80004120:	02079263          	bnez	a5,80004144 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80004124:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004128:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    8000412c:	00000097          	auipc	ra,0x0
    80004130:	f68080e7          	jalr	-152(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004134:	00813083          	ld	ra,8(sp)
    80004138:	00013403          	ld	s0,0(sp)
    8000413c:	01010113          	addi	sp,sp,16
    80004140:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004144:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80004148:	fffff097          	auipc	ra,0xfffff
    8000414c:	2a0080e7          	jalr	672(ra) # 800033e8 <_ZN15MemoryAllocator5kfreeEPv>
    80004150:	fd9ff06f          	j	80004128 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080004154 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80004154:	fc010113          	addi	sp,sp,-64
    80004158:	02113c23          	sd	ra,56(sp)
    8000415c:	02813823          	sd	s0,48(sp)
    80004160:	02913423          	sd	s1,40(sp)
    80004164:	03213023          	sd	s2,32(sp)
    80004168:	01313c23          	sd	s3,24(sp)
    8000416c:	01413823          	sd	s4,16(sp)
    80004170:	01513423          	sd	s5,8(sp)
    80004174:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80004178:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000417c:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80004180:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80004184:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80004188:	07000513          	li	a0,112
    8000418c:	fffff097          	auipc	ra,0xfffff
    80004190:	e20080e7          	jalr	-480(ra) # 80002fac <_ZN3TCBnwEm>
    80004194:	00050493          	mv	s1,a0
    80004198:	00050e63          	beqz	a0,800041b4 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    8000419c:	00200713          	li	a4,2
    800041a0:	000a8693          	mv	a3,s5
    800041a4:	000a0613          	mv	a2,s4
    800041a8:	00098593          	mv	a1,s3
    800041ac:	fffff097          	auipc	ra,0xfffff
    800041b0:	cc4080e7          	jalr	-828(ra) # 80002e70 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800041b4:	04048863          	beqz	s1,80004204 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    800041b8:	0184b783          	ld	a5,24(s1)
    800041bc:	00078863          	beqz	a5,800041cc <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    800041c0:	00048513          	mv	a0,s1
    800041c4:	00001097          	auipc	ra,0x1
    800041c8:	be0080e7          	jalr	-1056(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    800041cc:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800041d0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800041d4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800041d8:	00000097          	auipc	ra,0x0
    800041dc:	ebc080e7          	jalr	-324(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    800041e0:	03813083          	ld	ra,56(sp)
    800041e4:	03013403          	ld	s0,48(sp)
    800041e8:	02813483          	ld	s1,40(sp)
    800041ec:	02013903          	ld	s2,32(sp)
    800041f0:	01813983          	ld	s3,24(sp)
    800041f4:	01013a03          	ld	s4,16(sp)
    800041f8:	00813a83          	ld	s5,8(sp)
    800041fc:	04010113          	addi	sp,sp,64
    80004200:	00008067          	ret
        status = -1;
    80004204:	fff00793          	li	a5,-1
    80004208:	fcdff06f          	j	800041d4 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    8000420c:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80004210:	00048513          	mv	a0,s1
    80004214:	fffff097          	auipc	ra,0xfffff
    80004218:	ebc080e7          	jalr	-324(ra) # 800030d0 <_ZN3TCBdlEPv>
    8000421c:	00090513          	mv	a0,s2
    80004220:	00009097          	auipc	ra,0x9
    80004224:	fe8080e7          	jalr	-24(ra) # 8000d208 <_Unwind_Resume>

0000000080004228 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80004228:	fc010113          	addi	sp,sp,-64
    8000422c:	02113c23          	sd	ra,56(sp)
    80004230:	02813823          	sd	s0,48(sp)
    80004234:	02913423          	sd	s1,40(sp)
    80004238:	03213023          	sd	s2,32(sp)
    8000423c:	01313c23          	sd	s3,24(sp)
    80004240:	01413823          	sd	s4,16(sp)
    80004244:	01513423          	sd	s5,8(sp)
    80004248:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000424c:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004250:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80004254:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80004258:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000425c:	07000513          	li	a0,112
    80004260:	fffff097          	auipc	ra,0xfffff
    80004264:	d4c080e7          	jalr	-692(ra) # 80002fac <_ZN3TCBnwEm>
    80004268:	00050493          	mv	s1,a0
    8000426c:	00050e63          	beqz	a0,80004288 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80004270:	00200713          	li	a4,2
    80004274:	000a8693          	mv	a3,s5
    80004278:	00090613          	mv	a2,s2
    8000427c:	00098593          	mv	a1,s3
    80004280:	fffff097          	auipc	ra,0xfffff
    80004284:	bf0080e7          	jalr	-1040(ra) # 80002e70 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80004288:	04048263          	beqz	s1,800042cc <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    8000428c:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    80004290:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80004294:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    80004298:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000429c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800042a0:	00000097          	auipc	ra,0x0
    800042a4:	df4080e7          	jalr	-524(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    800042a8:	03813083          	ld	ra,56(sp)
    800042ac:	03013403          	ld	s0,48(sp)
    800042b0:	02813483          	ld	s1,40(sp)
    800042b4:	02013903          	ld	s2,32(sp)
    800042b8:	01813983          	ld	s3,24(sp)
    800042bc:	01013a03          	ld	s4,16(sp)
    800042c0:	00813a83          	ld	s5,8(sp)
    800042c4:	04010113          	addi	sp,sp,64
    800042c8:	00008067          	ret
        status = -1;
    800042cc:	fff00793          	li	a5,-1
    800042d0:	fcdff06f          	j	8000429c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    800042d4:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800042d8:	00048513          	mv	a0,s1
    800042dc:	fffff097          	auipc	ra,0xfffff
    800042e0:	df4080e7          	jalr	-524(ra) # 800030d0 <_ZN3TCBdlEPv>
    800042e4:	00090513          	mv	a0,s2
    800042e8:	00009097          	auipc	ra,0x9
    800042ec:	f20080e7          	jalr	-224(ra) # 8000d208 <_Unwind_Resume>

00000000800042f0 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    800042f0:	ff010113          	addi	sp,sp,-16
    800042f4:	00113423          	sd	ra,8(sp)
    800042f8:	00813023          	sd	s0,0(sp)
    800042fc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004300:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80004304:	02051263          	bnez	a0,80004328 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80004308:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000430c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004310:	00000097          	auipc	ra,0x0
    80004314:	d84080e7          	jalr	-636(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004318:	00813083          	ld	ra,8(sp)
    8000431c:	00013403          	ld	s0,0(sp)
    80004320:	01010113          	addi	sp,sp,16
    80004324:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80004328:	00100793          	li	a5,1
    8000432c:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80004330:	00001097          	auipc	ra,0x1
    80004334:	a74080e7          	jalr	-1420(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80004338:	fffff097          	auipc	ra,0xfffff
    8000433c:	bf4080e7          	jalr	-1036(ra) # 80002f2c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80004340:	00000793          	li	a5,0
    80004344:	fc9ff06f          	j	8000430c <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080004348 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80004348:	ff010113          	addi	sp,sp,-16
    8000434c:	00113423          	sd	ra,8(sp)
    80004350:	00813023          	sd	s0,0(sp)
    80004354:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80004358:	00008797          	auipc	a5,0x8
    8000435c:	af87b783          	ld	a5,-1288(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004360:	0007b783          	ld	a5,0(a5)
    80004364:	02078a63          	beqz	a5,80004398 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80004368:	00200713          	li	a4,2
    8000436c:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80004370:	fffff097          	auipc	ra,0xfffff
    80004374:	bbc080e7          	jalr	-1092(ra) # 80002f2c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80004378:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000437c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004380:	00000097          	auipc	ra,0x0
    80004384:	d14080e7          	jalr	-748(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004388:	00813083          	ld	ra,8(sp)
    8000438c:	00013403          	ld	s0,0(sp)
    80004390:	01010113          	addi	sp,sp,16
    80004394:	00008067          	ret
        status = -1;
    80004398:	fff00793          	li	a5,-1
    8000439c:	fe1ff06f          	j	8000437c <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

00000000800043a0 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    800043a0:	fd010113          	addi	sp,sp,-48
    800043a4:	02113423          	sd	ra,40(sp)
    800043a8:	02813023          	sd	s0,32(sp)
    800043ac:	00913c23          	sd	s1,24(sp)
    800043b0:	01213823          	sd	s2,16(sp)
    800043b4:	01313423          	sd	s3,8(sp)
    800043b8:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800043bc:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    800043c0:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    800043c4:	01800513          	li	a0,24
    800043c8:	fffff097          	auipc	ra,0xfffff
    800043cc:	954080e7          	jalr	-1708(ra) # 80002d1c <_ZN3SCBnwEm>
    800043d0:	00050493          	mv	s1,a0
    800043d4:	00050863          	beqz	a0,800043e4 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    800043d8:	00098593          	mv	a1,s3
    800043dc:	ffffe097          	auipc	ra,0xffffe
    800043e0:	78c080e7          	jalr	1932(ra) # 80002b68 <_ZN3SCBC1Em>
    if(scb == nullptr){
    800043e4:	02048a63          	beqz	s1,80004418 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    800043e8:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800043ec:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800043f0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800043f4:	00000097          	auipc	ra,0x0
    800043f8:	ca0080e7          	jalr	-864(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    800043fc:	02813083          	ld	ra,40(sp)
    80004400:	02013403          	ld	s0,32(sp)
    80004404:	01813483          	ld	s1,24(sp)
    80004408:	01013903          	ld	s2,16(sp)
    8000440c:	00813983          	ld	s3,8(sp)
    80004410:	03010113          	addi	sp,sp,48
    80004414:	00008067          	ret
        status = -1;
    80004418:	fff00793          	li	a5,-1
    8000441c:	fd5ff06f          	j	800043f0 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    80004420:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80004424:	00048513          	mv	a0,s1
    80004428:	fffff097          	auipc	ra,0xfffff
    8000442c:	924080e7          	jalr	-1756(ra) # 80002d4c <_ZN3SCBdlEPv>
    80004430:	00090513          	mv	a0,s2
    80004434:	00009097          	auipc	ra,0x9
    80004438:	dd4080e7          	jalr	-556(ra) # 8000d208 <_Unwind_Resume>

000000008000443c <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    8000443c:	fe010113          	addi	sp,sp,-32
    80004440:	00113c23          	sd	ra,24(sp)
    80004444:	00813823          	sd	s0,16(sp)
    80004448:	00913423          	sd	s1,8(sp)
    8000444c:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004450:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80004454:	02049463          	bnez	s1,8000447c <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80004458:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000445c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004460:	00000097          	auipc	ra,0x0
    80004464:	c34080e7          	jalr	-972(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004468:	01813083          	ld	ra,24(sp)
    8000446c:	01013403          	ld	s0,16(sp)
    80004470:	00813483          	ld	s1,8(sp)
    80004474:	02010113          	addi	sp,sp,32
    80004478:	00008067          	ret
        delete (SCB*)ihandle;
    8000447c:	00048513          	mv	a0,s1
    80004480:	ffffe097          	auipc	ra,0xffffe
    80004484:	704080e7          	jalr	1796(ra) # 80002b84 <_ZN3SCBD1Ev>
    80004488:	00048513          	mv	a0,s1
    8000448c:	fffff097          	auipc	ra,0xfffff
    80004490:	8c0080e7          	jalr	-1856(ra) # 80002d4c <_ZN3SCBdlEPv>
    uint64 status = 0;
    80004494:	00000793          	li	a5,0
    80004498:	fc5ff06f          	j	8000445c <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

000000008000449c <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    8000449c:	ff010113          	addi	sp,sp,-16
    800044a0:	00113423          	sd	ra,8(sp)
    800044a4:	00813023          	sd	s0,0(sp)
    800044a8:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800044ac:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800044b0:	02051c63          	bnez	a0,800044e8 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    800044b4:	00008797          	auipc	a5,0x8
    800044b8:	99c7b783          	ld	a5,-1636(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800044bc:	0007b783          	ld	a5,0(a5)
    800044c0:	0607b783          	ld	a5,96(a5)
    800044c4:	02078863          	beqz	a5,800044f4 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    800044c8:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800044cc:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800044d0:	00000097          	auipc	ra,0x0
    800044d4:	bc4080e7          	jalr	-1084(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    800044d8:	00813083          	ld	ra,8(sp)
    800044dc:	00013403          	ld	s0,0(sp)
    800044e0:	01010113          	addi	sp,sp,16
    800044e4:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800044e8:	ffffe097          	auipc	ra,0xffffe
    800044ec:	7a8080e7          	jalr	1960(ra) # 80002c90 <_ZN3SCB4waitEv>
    800044f0:	fc5ff06f          	j	800044b4 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800044f4:	00000793          	li	a5,0
    800044f8:	fd5ff06f          	j	800044cc <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800044fc <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800044fc:	ff010113          	addi	sp,sp,-16
    80004500:	00113423          	sd	ra,8(sp)
    80004504:	00813023          	sd	s0,0(sp)
    80004508:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000450c:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80004510:	02051263          	bnez	a0,80004534 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80004514:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004518:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000451c:	00000097          	auipc	ra,0x0
    80004520:	b78080e7          	jalr	-1160(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004524:	00813083          	ld	ra,8(sp)
    80004528:	00013403          	ld	s0,0(sp)
    8000452c:	01010113          	addi	sp,sp,16
    80004530:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80004534:	ffffe097          	auipc	ra,0xffffe
    80004538:	7ac080e7          	jalr	1964(ra) # 80002ce0 <_ZN3SCB6signalEv>
    uint64 status = 0;
    8000453c:	00000793          	li	a5,0
    80004540:	fd9ff06f          	j	80004518 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080004544 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80004544:	fe010113          	addi	sp,sp,-32
    80004548:	00113c23          	sd	ra,24(sp)
    8000454c:	00813823          	sd	s0,16(sp)
    80004550:	00913423          	sd	s1,8(sp)
    80004554:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80004558:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    8000455c:	00008797          	auipc	a5,0x8
    80004560:	8f47b783          	ld	a5,-1804(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004564:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80004568:	00008797          	auipc	a5,0x8
    8000456c:	b407b783          	ld	a5,-1216(a5) # 8000c0a8 <_ZN5RiscV10globalTimeE>
    80004570:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80004574:	00e787b3          	add	a5,a5,a4
    80004578:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    8000457c:	00048513          	mv	a0,s1
    80004580:	00001097          	auipc	ra,0x1
    80004584:	8a0080e7          	jalr	-1888(ra) # 80004e20 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80004588:	00300793          	li	a5,3
    8000458c:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80004590:	fffff097          	auipc	ra,0xfffff
    80004594:	99c080e7          	jalr	-1636(ra) # 80002f2c <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004598:	00000793          	li	a5,0
    8000459c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800045a0:	00000097          	auipc	ra,0x0
    800045a4:	af4080e7          	jalr	-1292(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    800045a8:	01813083          	ld	ra,24(sp)
    800045ac:	01013403          	ld	s0,16(sp)
    800045b0:	00813483          	ld	s1,8(sp)
    800045b4:	02010113          	addi	sp,sp,32
    800045b8:	00008067          	ret

00000000800045bc <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    800045bc:	fe010113          	addi	sp,sp,-32
    800045c0:	00113c23          	sd	ra,24(sp)
    800045c4:	00813823          	sd	s0,16(sp)
    800045c8:	00913423          	sd	s1,8(sp)
    800045cc:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    800045d0:	00008797          	auipc	a5,0x8
    800045d4:	ad07c783          	lbu	a5,-1328(a5) # 8000c0a0 <_ZN5RiscV16userMainFinishedE>
    800045d8:	00079c63          	bnez	a5,800045f0 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    800045dc:	00008717          	auipc	a4,0x8
    800045e0:	82473703          	ld	a4,-2012(a4) # 8000be00 <_GLOBAL_OFFSET_TABLE_+0x38>
    800045e4:	00073783          	ld	a5,0(a4)
    800045e8:	00178793          	addi	a5,a5,1
    800045ec:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800045f0:	00001097          	auipc	ra,0x1
    800045f4:	b14080e7          	jalr	-1260(ra) # 80005104 <_ZN11ConsoleUtil8getInputEv>
    800045f8:	00050493          	mv	s1,a0
    if(c==13) {
    800045fc:	00d00793          	li	a5,13
    80004600:	02f50663          	beq	a0,a5,8000462c <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80004604:	01b00793          	li	a5,27
    80004608:	04f51063          	bne	a0,a5,80004648 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    8000460c:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80004610:	00000097          	auipc	ra,0x0
    80004614:	a84080e7          	jalr	-1404(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004618:	01813083          	ld	ra,24(sp)
    8000461c:	01013403          	ld	s0,16(sp)
    80004620:	00813483          	ld	s1,8(sp)
    80004624:	02010113          	addi	sp,sp,32
    80004628:	00008067          	ret
        ConsoleUtil::putOutput(13);
    8000462c:	00d00513          	li	a0,13
    80004630:	00001097          	auipc	ra,0x1
    80004634:	b44080e7          	jalr	-1212(ra) # 80005174 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80004638:	00a00513          	li	a0,10
    8000463c:	00001097          	auipc	ra,0x1
    80004640:	b38080e7          	jalr	-1224(ra) # 80005174 <_ZN11ConsoleUtil9putOutputEc>
    80004644:	fc9ff06f          	j	8000460c <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80004648:	00001097          	auipc	ra,0x1
    8000464c:	b2c080e7          	jalr	-1236(ra) # 80005174 <_ZN11ConsoleUtil9putOutputEc>
    80004650:	fbdff06f          	j	8000460c <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080004654 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80004654:	ff010113          	addi	sp,sp,-16
    80004658:	00113423          	sd	ra,8(sp)
    8000465c:	00813023          	sd	s0,0(sp)
    80004660:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80004664:	00001097          	auipc	ra,0x1
    80004668:	ba8080e7          	jalr	-1112(ra) # 8000520c <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    8000466c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80004670:	00000097          	auipc	ra,0x0
    80004674:	a24080e7          	jalr	-1500(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004678:	00813083          	ld	ra,8(sp)
    8000467c:	00013403          	ld	s0,0(sp)
    80004680:	01010113          	addi	sp,sp,16
    80004684:	00008067          	ret

0000000080004688 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80004688:	fe010113          	addi	sp,sp,-32
    8000468c:	00113c23          	sd	ra,24(sp)
    80004690:	00813823          	sd	s0,16(sp)
    80004694:	00913423          	sd	s1,8(sp)
    80004698:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000469c:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    800046a0:	02049463          	bnez	s1,800046c8 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800046a4:	fff00793          	li	a5,-1
    800046a8:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800046ac:	00000097          	auipc	ra,0x0
    800046b0:	9e8080e7          	jalr	-1560(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    800046b4:	01813083          	ld	ra,24(sp)
    800046b8:	01013403          	ld	s0,16(sp)
    800046bc:	00813483          	ld	s1,8(sp)
    800046c0:	02010113          	addi	sp,sp,32
    800046c4:	00008067          	ret
        kfree(thr->stack);
    800046c8:	0284b503          	ld	a0,40(s1)
    800046cc:	00001097          	auipc	ra,0x1
    800046d0:	eac080e7          	jalr	-340(ra) # 80005578 <_Z5kfreePKv>
        delete thr;
    800046d4:	00048513          	mv	a0,s1
    800046d8:	fffff097          	auipc	ra,0xfffff
    800046dc:	82c080e7          	jalr	-2004(ra) # 80002f04 <_ZN3TCBD1Ev>
    800046e0:	00048513          	mv	a0,s1
    800046e4:	fffff097          	auipc	ra,0xfffff
    800046e8:	9ec080e7          	jalr	-1556(ra) # 800030d0 <_ZN3TCBdlEPv>
    800046ec:	fb9ff06f          	j	800046a4 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

00000000800046f0 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    800046f0:	fe010113          	addi	sp,sp,-32
    800046f4:	00113c23          	sd	ra,24(sp)
    800046f8:	00813823          	sd	s0,16(sp)
    800046fc:	00913423          	sd	s1,8(sp)
    80004700:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004704:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80004708:	02049463          	bnez	s1,80004730 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000470c:	fff00793          	li	a5,-1
    80004710:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80004714:	00000097          	auipc	ra,0x0
    80004718:	980080e7          	jalr	-1664(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000471c:	01813083          	ld	ra,24(sp)
    80004720:	01013403          	ld	s0,16(sp)
    80004724:	00813483          	ld	s1,8(sp)
    80004728:	02010113          	addi	sp,sp,32
    8000472c:	00008067          	ret
        delete scb;
    80004730:	00048513          	mv	a0,s1
    80004734:	ffffe097          	auipc	ra,0xffffe
    80004738:	450080e7          	jalr	1104(ra) # 80002b84 <_ZN3SCBD1Ev>
    8000473c:	00048513          	mv	a0,s1
    80004740:	ffffe097          	auipc	ra,0xffffe
    80004744:	60c080e7          	jalr	1548(ra) # 80002d4c <_ZN3SCBdlEPv>
    80004748:	fc5ff06f          	j	8000470c <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

000000008000474c <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    8000474c:	fe010113          	addi	sp,sp,-32
    80004750:	00113c23          	sd	ra,24(sp)
    80004754:	00813823          	sd	s0,16(sp)
    80004758:	00913423          	sd	s1,8(sp)
    8000475c:	01213023          	sd	s2,0(sp)
    80004760:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80004764:	00001537          	lui	a0,0x1
    80004768:	00001097          	auipc	ra,0x1
    8000476c:	de8080e7          	jalr	-536(ra) # 80005550 <_Z7kmallocm>
    80004770:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80004774:	00007797          	auipc	a5,0x7
    80004778:	6dc7b783          	ld	a5,1756(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000477c:	0007b783          	ld	a5,0(a5)
    80004780:	00001637          	lui	a2,0x1
    80004784:	00050593          	mv	a1,a0
    80004788:	0287b503          	ld	a0,40(a5)
    8000478c:	fffff097          	auipc	ra,0xfffff
    80004790:	e10080e7          	jalr	-496(ra) # 8000359c <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80004794:	07000513          	li	a0,112
    80004798:	fffff097          	auipc	ra,0xfffff
    8000479c:	814080e7          	jalr	-2028(ra) # 80002fac <_ZN3TCBnwEm>
    800047a0:	00050493          	mv	s1,a0
    800047a4:	00050e63          	beqz	a0,800047c0 <_ZN5RiscV18executeForkSyscallEv+0x74>
    800047a8:	00200713          	li	a4,2
    800047ac:	00090693          	mv	a3,s2
    800047b0:	00000613          	li	a2,0
    800047b4:	00000593          	li	a1,0
    800047b8:	ffffe097          	auipc	ra,0xffffe
    800047bc:	6b8080e7          	jalr	1720(ra) # 80002e70 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    800047c0:	0a048e63          	beqz	s1,8000487c <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    800047c4:	00007797          	auipc	a5,0x7
    800047c8:	6547b783          	ld	a5,1620(a5) # 8000be18 <_GLOBAL_OFFSET_TABLE_+0x50>
    800047cc:	0007b783          	ld	a5,0(a5)
    800047d0:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    800047d4:	00007797          	auipc	a5,0x7
    800047d8:	6347b783          	ld	a5,1588(a5) # 8000be08 <_GLOBAL_OFFSET_TABLE_+0x40>
    800047dc:	0007b783          	ld	a5,0(a5)
    800047e0:	00f907b3          	add	a5,s2,a5
    800047e4:	00007717          	auipc	a4,0x7
    800047e8:	66c73703          	ld	a4,1644(a4) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800047ec:	00073683          	ld	a3,0(a4)
    800047f0:	0286b683          	ld	a3,40(a3)
    800047f4:	40d787b3          	sub	a5,a5,a3
    800047f8:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    800047fc:	00073783          	ld	a5,0(a4)
    80004800:	0687b503          	ld	a0,104(a5)
    80004804:	0287b783          	ld	a5,40(a5)
    80004808:	40f50533          	sub	a0,a0,a5
    8000480c:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80004810:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80004814:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80004818:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    8000481c:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80004820:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80004824:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80004828:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    8000482c:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80004830:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80004834:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80004838:	00073783          	ld	a5,0(a4)
    8000483c:	0387b703          	ld	a4,56(a5)
    80004840:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80004844:	0407b783          	ld	a5,64(a5)
    80004848:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    8000484c:	00048513          	mv	a0,s1
    80004850:	00000097          	auipc	ra,0x0
    80004854:	554080e7          	jalr	1364(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80004858:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    8000485c:	00000097          	auipc	ra,0x0
    80004860:	838080e7          	jalr	-1992(ra) # 80004094 <_ZN5RiscV16saveA0toSscratchEv>

}
    80004864:	01813083          	ld	ra,24(sp)
    80004868:	01013403          	ld	s0,16(sp)
    8000486c:	00813483          	ld	s1,8(sp)
    80004870:	00013903          	ld	s2,0(sp)
    80004874:	02010113          	addi	sp,sp,32
    80004878:	00008067          	ret
        status = -1;
    8000487c:	fff00493          	li	s1,-1
    80004880:	fd9ff06f          	j	80004858 <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80004884:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80004888:	00048513          	mv	a0,s1
    8000488c:	fffff097          	auipc	ra,0xfffff
    80004890:	844080e7          	jalr	-1980(ra) # 800030d0 <_ZN3TCBdlEPv>
    80004894:	00090513          	mv	a0,s2
    80004898:	00009097          	auipc	ra,0x9
    8000489c:	970080e7          	jalr	-1680(ra) # 8000d208 <_Unwind_Resume>

00000000800048a0 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    800048a0:	ff010113          	addi	sp,sp,-16
    800048a4:	00813423          	sd	s0,8(sp)
    800048a8:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    800048ac:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    800048b0:	00878793          	addi	a5,a5,8
    800048b4:	00007717          	auipc	a4,0x7
    800048b8:	56473703          	ld	a4,1380(a4) # 8000be18 <_GLOBAL_OFFSET_TABLE_+0x50>
    800048bc:	00f73023          	sd	a5,0(a4)
}
    800048c0:	00813403          	ld	s0,8(sp)
    800048c4:	01010113          	addi	sp,sp,16
    800048c8:	00008067          	ret

00000000800048cc <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    800048cc:	fa010113          	addi	sp,sp,-96
    800048d0:	04113c23          	sd	ra,88(sp)
    800048d4:	04813823          	sd	s0,80(sp)
    800048d8:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800048dc:	142027f3          	csrr	a5,scause
    800048e0:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    800048e4:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    800048e8:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    800048ec:	00007797          	auipc	a5,0x7
    800048f0:	5647b783          	ld	a5,1380(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800048f4:	0007b783          	ld	a5,0(a5)
    800048f8:	14002773          	csrr	a4,sscratch
    800048fc:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80004900:	fe843703          	ld	a4,-24(s0)
    80004904:	00900793          	li	a5,9
    80004908:	0ef70663          	beq	a4,a5,800049f4 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    8000490c:	fe843703          	ld	a4,-24(s0)
    80004910:	00800793          	li	a5,8
    80004914:	0ef70063          	beq	a4,a5,800049f4 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    80004918:	fe843703          	ld	a4,-24(s0)
    8000491c:	fff00793          	li	a5,-1
    80004920:	03f79793          	slli	a5,a5,0x3f
    80004924:	00178793          	addi	a5,a5,1
    80004928:	24f70263          	beq	a4,a5,80004b6c <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    8000492c:	fe843703          	ld	a4,-24(s0)
    80004930:	fff00793          	li	a5,-1
    80004934:	03f79793          	slli	a5,a5,0x3f
    80004938:	00978793          	addi	a5,a5,9
    8000493c:	2cf70063          	beq	a4,a5,80004bfc <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80004940:	fe843703          	ld	a4,-24(s0)
    80004944:	00200793          	li	a5,2
    80004948:	34f70863          	beq	a4,a5,80004c98 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    8000494c:	00005517          	auipc	a0,0x5
    80004950:	a3c50513          	addi	a0,a0,-1476 # 80009388 <CONSOLE_STATUS+0x378>
    80004954:	00001097          	auipc	ra,0x1
    80004958:	928080e7          	jalr	-1752(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    8000495c:	00005517          	auipc	a0,0x5
    80004960:	a3c50513          	addi	a0,a0,-1476 # 80009398 <CONSOLE_STATUS+0x388>
    80004964:	00001097          	auipc	ra,0x1
    80004968:	918080e7          	jalr	-1768(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    8000496c:	142027f3          	csrr	a5,scause
    80004970:	fef43023          	sd	a5,-32(s0)
    return scause;
    80004974:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80004978:	00000613          	li	a2,0
    8000497c:	00a00593          	li	a1,10
    80004980:	0005051b          	sext.w	a0,a0
    80004984:	00001097          	auipc	ra,0x1
    80004988:	93c080e7          	jalr	-1732(ra) # 800052c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    8000498c:	00005517          	auipc	a0,0x5
    80004990:	9cc50513          	addi	a0,a0,-1588 # 80009358 <CONSOLE_STATUS+0x348>
    80004994:	00001097          	auipc	ra,0x1
    80004998:	8e8080e7          	jalr	-1816(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000499c:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800049a0:	00000613          	li	a2,0
    800049a4:	01000593          	li	a1,16
    800049a8:	0005051b          	sext.w	a0,a0
    800049ac:	00001097          	auipc	ra,0x1
    800049b0:	914080e7          	jalr	-1772(ra) # 800052c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800049b4:	00005517          	auipc	a0,0x5
    800049b8:	99c50513          	addi	a0,a0,-1636 # 80009350 <CONSOLE_STATUS+0x340>
    800049bc:	00001097          	auipc	ra,0x1
    800049c0:	8c0080e7          	jalr	-1856(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    800049c4:	00007797          	auipc	a5,0x7
    800049c8:	48c7b783          	ld	a5,1164(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800049cc:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800049d0:	00200713          	li	a4,2
    800049d4:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    800049d8:	00005517          	auipc	a0,0x5
    800049dc:	9d050513          	addi	a0,a0,-1584 # 800093a8 <CONSOLE_STATUS+0x398>
    800049e0:	00001097          	auipc	ra,0x1
    800049e4:	89c080e7          	jalr	-1892(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800049e8:	ffffe097          	auipc	ra,0xffffe
    800049ec:	544080e7          	jalr	1348(ra) # 80002f2c <_ZN3TCB8dispatchEv>
    800049f0:	0800006f          	j	80004a70 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800049f4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800049f8:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800049fc:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80004a00:	00478793          	addi	a5,a5,4
    80004a04:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    80004a08:	00007797          	auipc	a5,0x7
    80004a0c:	4487b783          	ld	a5,1096(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004a10:	0007b783          	ld	a5,0(a5)
    80004a14:	fb043703          	ld	a4,-80(s0)
    80004a18:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80004a1c:	fa843703          	ld	a4,-88(s0)
    80004a20:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80004a24:	00050793          	mv	a5,a0
        switch(syscallID){
    80004a28:	06100713          	li	a4,97
    80004a2c:	02f76463          	bltu	a4,a5,80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    80004a30:	00279793          	slli	a5,a5,0x2
    80004a34:	00005717          	auipc	a4,0x5
    80004a38:	98870713          	addi	a4,a4,-1656 # 800093bc <CONSOLE_STATUS+0x3ac>
    80004a3c:	00e787b3          	add	a5,a5,a4
    80004a40:	0007a783          	lw	a5,0(a5)
    80004a44:	00e787b3          	add	a5,a5,a4
    80004a48:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004a4c:	fffff097          	auipc	ra,0xfffff
    80004a50:	680080e7          	jalr	1664(ra) # 800040cc <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004a54:	00007797          	auipc	a5,0x7
    80004a58:	3fc7b783          	ld	a5,1020(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004a5c:	0007b783          	ld	a5,0(a5)
    80004a60:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004a64:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80004a68:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004a6c:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80004a70:	fffff097          	auipc	ra,0xfffff
    80004a74:	4f4080e7          	jalr	1268(ra) # 80003f64 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80004a78:	05813083          	ld	ra,88(sp)
    80004a7c:	05013403          	ld	s0,80(sp)
    80004a80:	06010113          	addi	sp,sp,96
    80004a84:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80004a88:	fffff097          	auipc	ra,0xfffff
    80004a8c:	67c080e7          	jalr	1660(ra) # 80004104 <_ZN5RiscV21executeMemFreeSyscallEv>
    80004a90:	fc5ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80004a94:	fffff097          	auipc	ra,0xfffff
    80004a98:	6c0080e7          	jalr	1728(ra) # 80004154 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004a9c:	fb9ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80004aa0:	00000097          	auipc	ra,0x0
    80004aa4:	8a8080e7          	jalr	-1880(ra) # 80004348 <_ZN5RiscV24executeThreadExitSyscallEv>
    80004aa8:	fadff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004aac:	fffff097          	auipc	ra,0xfffff
    80004ab0:	3a4080e7          	jalr	932(ra) # 80003e50 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80004ab4:	fa1ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80004ab8:	fffff097          	auipc	ra,0xfffff
    80004abc:	770080e7          	jalr	1904(ra) # 80004228 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004ac0:	f95ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80004ac4:	00000097          	auipc	ra,0x0
    80004ac8:	82c080e7          	jalr	-2004(ra) # 800042f0 <_ZN5RiscV25executeThreadStartSyscallEv>
    80004acc:	f89ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80004ad0:	00000097          	auipc	ra,0x0
    80004ad4:	8d0080e7          	jalr	-1840(ra) # 800043a0 <_ZN5RiscV21executeSemOpenSyscallEv>
    80004ad8:	f7dff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    80004adc:	00000097          	auipc	ra,0x0
    80004ae0:	960080e7          	jalr	-1696(ra) # 8000443c <_ZN5RiscV22executeSemCloseSyscallEv>
    80004ae4:	f71ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80004ae8:	00000097          	auipc	ra,0x0
    80004aec:	9b4080e7          	jalr	-1612(ra) # 8000449c <_ZN5RiscV21executeSemWaitSyscallEv>
    80004af0:	f65ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80004af4:	00000097          	auipc	ra,0x0
    80004af8:	a08080e7          	jalr	-1528(ra) # 800044fc <_ZN5RiscV23executeSemSignalSyscallEv>
    80004afc:	f59ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    80004b00:	00000097          	auipc	ra,0x0
    80004b04:	a44080e7          	jalr	-1468(ra) # 80004544 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80004b08:	f4dff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    80004b0c:	00000097          	auipc	ra,0x0
    80004b10:	ab0080e7          	jalr	-1360(ra) # 800045bc <_ZN5RiscV18executeGetcSyscallEv>
    80004b14:	f41ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    80004b18:	fffff097          	auipc	ra,0xfffff
    80004b1c:	374080e7          	jalr	884(ra) # 80003e8c <_ZN5RiscV18executePutcSyscallEv>
    80004b20:	f35ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    80004b24:	00000097          	auipc	ra,0x0
    80004b28:	b30080e7          	jalr	-1232(ra) # 80004654 <_ZN5RiscV22executePutcUtilSyscallEv>
    80004b2c:	f29ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    80004b30:	00000097          	auipc	ra,0x0
    80004b34:	b58080e7          	jalr	-1192(ra) # 80004688 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004b38:	f1dff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004b3c:	00000097          	auipc	ra,0x0
    80004b40:	bb4080e7          	jalr	-1100(ra) # 800046f0 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004b44:	f11ff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004b48:	00010793          	mv	a5,sp
    80004b4c:	00007717          	auipc	a4,0x7
    80004b50:	2bc73703          	ld	a4,700(a4) # 8000be08 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004b54:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004b58:	00000097          	auipc	ra,0x0
    80004b5c:	d48080e7          	jalr	-696(ra) # 800048a0 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004b60:	00000097          	auipc	ra,0x0
    80004b64:	bec080e7          	jalr	-1044(ra) # 8000474c <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004b68:	eedff06f          	j	80004a54 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004b6c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004b70:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004b74:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004b78:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004b7c:	00200793          	li	a5,2
    80004b80:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80004b84:	00007717          	auipc	a4,0x7
    80004b88:	50c70713          	addi	a4,a4,1292 # 8000c090 <_ZN5RiscV4kPMTE>
    80004b8c:	01873783          	ld	a5,24(a4)
    80004b90:	00178793          	addi	a5,a5,1
    80004b94:	00f73c23          	sd	a5,24(a4)
        Scheduler::awake();
    80004b98:	00000097          	auipc	ra,0x0
    80004b9c:	2e0080e7          	jalr	736(ra) # 80004e78 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80004ba0:	00007717          	auipc	a4,0x7
    80004ba4:	24873703          	ld	a4,584(a4) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004ba8:	00073783          	ld	a5,0(a4)
    80004bac:	00178793          	addi	a5,a5,1
    80004bb0:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80004bb4:	00007717          	auipc	a4,0x7
    80004bb8:	29c73703          	ld	a4,668(a4) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004bbc:	00073703          	ld	a4,0(a4)
    80004bc0:	03073683          	ld	a3,48(a4)
    80004bc4:	00d7fc63          	bgeu	a5,a3,80004bdc <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80004bc8:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004bcc:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004bd0:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004bd4:	14179073          	csrw	sepc,a5
}
    80004bd8:	e99ff06f          	j	80004a70 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80004bdc:	00007797          	auipc	a5,0x7
    80004be0:	20c7b783          	ld	a5,524(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004be4:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004be8:	00100793          	li	a5,1
    80004bec:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80004bf0:	ffffe097          	auipc	ra,0xffffe
    80004bf4:	33c080e7          	jalr	828(ra) # 80002f2c <_ZN3TCB8dispatchEv>
    80004bf8:	fd1ff06f          	j	80004bc8 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004bfc:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004c00:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004c04:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004c08:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80004c0c:	00007797          	auipc	a5,0x7
    80004c10:	1cc7b783          	ld	a5,460(a5) # 8000bdd8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004c14:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004c18:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004c1c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004c20:	00058793          	mv	a5,a1
        if(status & 1UL)
    80004c24:	0017f793          	andi	a5,a5,1
    80004c28:	02078863          	beqz	a5,80004c58 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    80004c2c:	00007797          	auipc	a5,0x7
    80004c30:	1cc7b783          	ld	a5,460(a5) # 8000bdf8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004c34:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004c38:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004c3c:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004c40:	00058513          	mv	a0,a1
    80004c44:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004c48:	00007797          	auipc	a5,0x7
    80004c4c:	1b87b783          	ld	a5,440(a5) # 8000be00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004c50:	0007b783          	ld	a5,0(a5)
    80004c54:	02079463          	bnez	a5,80004c7c <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    80004c58:	00002097          	auipc	ra,0x2
    80004c5c:	7ec080e7          	jalr	2028(ra) # 80007444 <plic_claim>
    80004c60:	00003097          	auipc	ra,0x3
    80004c64:	81c080e7          	jalr	-2020(ra) # 8000747c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004c68:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004c6c:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004c70:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004c74:	14179073          	csrw	sepc,a5
}
    80004c78:	df9ff06f          	j	80004a70 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80004c7c:	fff78793          	addi	a5,a5,-1
    80004c80:	00007717          	auipc	a4,0x7
    80004c84:	18073703          	ld	a4,384(a4) # 8000be00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004c88:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004c8c:	00000097          	auipc	ra,0x0
    80004c90:	3f8080e7          	jalr	1016(ra) # 80005084 <_ZN11ConsoleUtil8putInputEc>
    80004c94:	fc5ff06f          	j	80004c58 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    80004c98:	00007797          	auipc	a5,0x7
    80004c9c:	1b87b783          	ld	a5,440(a5) # 8000be50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004ca0:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004ca4:	00200713          	li	a4,2
    80004ca8:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004cac:	00004517          	auipc	a0,0x4
    80004cb0:	6ac50513          	addi	a0,a0,1708 # 80009358 <CONSOLE_STATUS+0x348>
    80004cb4:	00000097          	auipc	ra,0x0
    80004cb8:	5c8080e7          	jalr	1480(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004cbc:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004cc0:	00000613          	li	a2,0
    80004cc4:	01000593          	li	a1,16
    80004cc8:	0005051b          	sext.w	a0,a0
    80004ccc:	00000097          	auipc	ra,0x0
    80004cd0:	5f4080e7          	jalr	1524(ra) # 800052c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004cd4:	00004517          	auipc	a0,0x4
    80004cd8:	67c50513          	addi	a0,a0,1660 # 80009350 <CONSOLE_STATUS+0x340>
    80004cdc:	00000097          	auipc	ra,0x0
    80004ce0:	5a0080e7          	jalr	1440(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80004ce4:	00004517          	auipc	a0,0x4
    80004ce8:	67c50513          	addi	a0,a0,1660 # 80009360 <CONSOLE_STATUS+0x350>
    80004cec:	00000097          	auipc	ra,0x0
    80004cf0:	590080e7          	jalr	1424(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004cf4:	ffffe097          	auipc	ra,0xffffe
    80004cf8:	238080e7          	jalr	568(ra) # 80002f2c <_ZN3TCB8dispatchEv>
    80004cfc:	d75ff06f          	j	80004a70 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

0000000080004d00 <_Z6strcpyPKcPc>:
//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    80004d00:	ff010113          	addi	sp,sp,-16
    80004d04:	00813423          	sd	s0,8(sp)
    80004d08:	01010413          	addi	s0,sp,16
    80004d0c:	00050793          	mv	a5,a0
    80004d10:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004d14:	0007c703          	lbu	a4,0(a5)
    80004d18:	00070a63          	beqz	a4,80004d2c <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004d1c:	00178793          	addi	a5,a5,1
    80004d20:	00e50023          	sb	a4,0(a0)
    80004d24:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004d28:	fedff06f          	j	80004d14 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004d2c:	00e50023          	sb	a4,0(a0)
    return dst;
}
    80004d30:	00813403          	ld	s0,8(sp)
    80004d34:	01010113          	addi	sp,sp,16
    80004d38:	00008067          	ret

0000000080004d3c <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004d3c:	fe010113          	addi	sp,sp,-32
    80004d40:	00113c23          	sd	ra,24(sp)
    80004d44:	00813823          	sd	s0,16(sp)
    80004d48:	00913423          	sd	s1,8(sp)
    80004d4c:	02010413          	addi	s0,sp,32
    80004d50:	00050493          	mv	s1,a0
    80004d54:	00058513          	mv	a0,a1
    char *dest = dst;
    80004d58:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004d5c:	0005c783          	lbu	a5,0(a1)
    80004d60:	00078663          	beqz	a5,80004d6c <_Z6strcatPcPKc+0x30>
        dest++;
    80004d64:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004d68:	ff5ff06f          	j	80004d5c <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004d6c:	00000097          	auipc	ra,0x0
    80004d70:	f94080e7          	jalr	-108(ra) # 80004d00 <_Z6strcpyPKcPc>
    return dst;
}
    80004d74:	00048513          	mv	a0,s1
    80004d78:	01813083          	ld	ra,24(sp)
    80004d7c:	01013403          	ld	s0,16(sp)
    80004d80:	00813483          	ld	s1,8(sp)
    80004d84:	02010113          	addi	sp,sp,32
    80004d88:	00008067          	ret

0000000080004d8c <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004d8c:	ff010113          	addi	sp,sp,-16
    80004d90:	00813423          	sd	s0,8(sp)
    80004d94:	01010413          	addi	s0,sp,16
}
    80004d98:	00813403          	ld	s0,8(sp)
    80004d9c:	01010113          	addi	sp,sp,16
    80004da0:	00008067          	ret

0000000080004da4 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004da4:	ff010113          	addi	sp,sp,-16
    80004da8:	00813423          	sd	s0,8(sp)
    80004dac:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004db0:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004db4:	00007797          	auipc	a5,0x7
    80004db8:	2fc7b783          	ld	a5,764(a5) # 8000c0b0 <_ZN9Scheduler9readyHeadE>
    80004dbc:	02078263          	beqz	a5,80004de0 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004dc0:	00007797          	auipc	a5,0x7
    80004dc4:	2f87b783          	ld	a5,760(a5) # 8000c0b8 <_ZN9Scheduler9readyTailE>
    80004dc8:	04a7b423          	sd	a0,72(a5)
    80004dcc:	00007797          	auipc	a5,0x7
    80004dd0:	2ea7b623          	sd	a0,748(a5) # 8000c0b8 <_ZN9Scheduler9readyTailE>
}
    80004dd4:	00813403          	ld	s0,8(sp)
    80004dd8:	01010113          	addi	sp,sp,16
    80004ddc:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004de0:	00007797          	auipc	a5,0x7
    80004de4:	2ca7b823          	sd	a0,720(a5) # 8000c0b0 <_ZN9Scheduler9readyHeadE>
    80004de8:	fe5ff06f          	j	80004dcc <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004dec <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004dec:	ff010113          	addi	sp,sp,-16
    80004df0:	00813423          	sd	s0,8(sp)
    80004df4:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004df8:	00007517          	auipc	a0,0x7
    80004dfc:	2b853503          	ld	a0,696(a0) # 8000c0b0 <_ZN9Scheduler9readyHeadE>
    80004e00:	00050a63          	beqz	a0,80004e14 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004e04:	04853783          	ld	a5,72(a0)
    80004e08:	00007717          	auipc	a4,0x7
    80004e0c:	2af73423          	sd	a5,680(a4) # 8000c0b0 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004e10:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004e14:	00813403          	ld	s0,8(sp)
    80004e18:	01010113          	addi	sp,sp,16
    80004e1c:	00008067          	ret

0000000080004e20 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004e20:	ff010113          	addi	sp,sp,-16
    80004e24:	00813423          	sd	s0,8(sp)
    80004e28:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004e2c:	00007797          	auipc	a5,0x7
    80004e30:	2947b783          	ld	a5,660(a5) # 8000c0c0 <_ZN9Scheduler12sleepingHeadE>
    80004e34:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004e38:	00078e63          	beqz	a5,80004e54 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004e3c:	0587b683          	ld	a3,88(a5)
    80004e40:	05853703          	ld	a4,88(a0)
    80004e44:	00d76863          	bltu	a4,a3,80004e54 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004e48:	00078613          	mv	a2,a5
    80004e4c:	0487b783          	ld	a5,72(a5)
    80004e50:	fe9ff06f          	j	80004e38 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004e54:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004e58:	00060a63          	beqz	a2,80004e6c <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004e5c:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80004e60:	00813403          	ld	s0,8(sp)
    80004e64:	01010113          	addi	sp,sp,16
    80004e68:	00008067          	ret
        sleepingHead = t;
    80004e6c:	00007797          	auipc	a5,0x7
    80004e70:	24a7ba23          	sd	a0,596(a5) # 8000c0c0 <_ZN9Scheduler12sleepingHeadE>
}
    80004e74:	fedff06f          	j	80004e60 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004e78 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004e78:	fe010113          	addi	sp,sp,-32
    80004e7c:	00113c23          	sd	ra,24(sp)
    80004e80:	00813823          	sd	s0,16(sp)
    80004e84:	00913423          	sd	s1,8(sp)
    80004e88:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004e8c:	00007497          	auipc	s1,0x7
    80004e90:	2344b483          	ld	s1,564(s1) # 8000c0c0 <_ZN9Scheduler12sleepingHeadE>
    80004e94:	02048c63          	beqz	s1,80004ecc <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004e98:	0584b703          	ld	a4,88(s1)
    80004e9c:	00007797          	auipc	a5,0x7
    80004ea0:	fcc7b783          	ld	a5,-52(a5) # 8000be68 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80004ea4:	0007b783          	ld	a5,0(a5)
    80004ea8:	02e7e263          	bltu	a5,a4,80004ecc <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004eac:	0484b783          	ld	a5,72(s1)
    80004eb0:	00007717          	auipc	a4,0x7
    80004eb4:	20f73823          	sd	a5,528(a4) # 8000c0c0 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004eb8:	00048513          	mv	a0,s1
    80004ebc:	00000097          	auipc	ra,0x0
    80004ec0:	ee8080e7          	jalr	-280(ra) # 80004da4 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004ec4:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004ec8:	fc5ff06f          	j	80004e8c <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004ecc:	01813083          	ld	ra,24(sp)
    80004ed0:	01013403          	ld	s0,16(sp)
    80004ed4:	00813483          	ld	s1,8(sp)
    80004ed8:	02010113          	addi	sp,sp,32
    80004edc:	00008067          	ret

0000000080004ee0 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004ee0:	fe010113          	addi	sp,sp,-32
    80004ee4:	00113c23          	sd	ra,24(sp)
    80004ee8:	00813823          	sd	s0,16(sp)
    80004eec:	00913423          	sd	s1,8(sp)
    80004ef0:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004ef4:	00007497          	auipc	s1,0x7
    80004ef8:	1bc4b483          	ld	s1,444(s1) # 8000c0b0 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004efc:	02048863          	beqz	s1,80004f2c <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004f00:	00000613          	li	a2,0
    80004f04:	01000593          	li	a1,16
    80004f08:	0004851b          	sext.w	a0,s1
    80004f0c:	00000097          	auipc	ra,0x0
    80004f10:	3b4080e7          	jalr	948(ra) # 800052c0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004f14:	00004517          	auipc	a0,0x4
    80004f18:	43c50513          	addi	a0,a0,1084 # 80009350 <CONSOLE_STATUS+0x340>
    80004f1c:	00000097          	auipc	ra,0x0
    80004f20:	360080e7          	jalr	864(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004f24:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004f28:	fd5ff06f          	j	80004efc <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004f2c:	01813083          	ld	ra,24(sp)
    80004f30:	01013403          	ld	s0,16(sp)
    80004f34:	00813483          	ld	s1,8(sp)
    80004f38:	02010113          	addi	sp,sp,32
    80004f3c:	00008067          	ret

0000000080004f40 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004f40:	fe010113          	addi	sp,sp,-32
    80004f44:	00113c23          	sd	ra,24(sp)
    80004f48:	00813823          	sd	s0,16(sp)
    80004f4c:	00913423          	sd	s1,8(sp)
    80004f50:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004f54:	00007497          	auipc	s1,0x7
    80004f58:	16c4b483          	ld	s1,364(s1) # 8000c0c0 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004f5c:	02048863          	beqz	s1,80004f8c <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004f60:	00000613          	li	a2,0
    80004f64:	01000593          	li	a1,16
    80004f68:	0004851b          	sext.w	a0,s1
    80004f6c:	ffffe097          	auipc	ra,0xffffe
    80004f70:	a5c080e7          	jalr	-1444(ra) # 800029c8 <_Z8printIntiii>
        printString("\n");
    80004f74:	00004517          	auipc	a0,0x4
    80004f78:	3dc50513          	addi	a0,a0,988 # 80009350 <CONSOLE_STATUS+0x340>
    80004f7c:	ffffe097          	auipc	ra,0xffffe
    80004f80:	8b4080e7          	jalr	-1868(ra) # 80002830 <_Z11printStringPKc>
        iter = iter->next;
    80004f84:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004f88:	fd5ff06f          	j	80004f5c <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004f8c:	01813083          	ld	ra,24(sp)
    80004f90:	01013403          	ld	s0,16(sp)
    80004f94:	00813483          	ld	s1,8(sp)
    80004f98:	02010113          	addi	sp,sp,32
    80004f9c:	00008067          	ret

0000000080004fa0 <_ZN11ConsoleUtil10initializeEv>:
char* ConsoleUtil::inputBuffer = nullptr;
char* ConsoleUtil::outputBuffer = nullptr;

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    80004fa0:	fe010113          	addi	sp,sp,-32
    80004fa4:	00113c23          	sd	ra,24(sp)
    80004fa8:	00813823          	sd	s0,16(sp)
    80004fac:	00913423          	sd	s1,8(sp)
    80004fb0:	01213023          	sd	s2,0(sp)
    80004fb4:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004fb8:	01800513          	li	a0,24
    80004fbc:	ffffe097          	auipc	ra,0xffffe
    80004fc0:	d60080e7          	jalr	-672(ra) # 80002d1c <_ZN3SCBnwEm>
    80004fc4:	00050493          	mv	s1,a0
    80004fc8:	00050863          	beqz	a0,80004fd8 <_ZN11ConsoleUtil10initializeEv+0x38>
    80004fcc:	00000593          	li	a1,0
    80004fd0:	ffffe097          	auipc	ra,0xffffe
    80004fd4:	b98080e7          	jalr	-1128(ra) # 80002b68 <_ZN3SCBC1Em>
    80004fd8:	00007797          	auipc	a5,0x7
    80004fdc:	0e97b823          	sd	s1,240(a5) # 8000c0c8 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004fe0:	01800513          	li	a0,24
    80004fe4:	ffffe097          	auipc	ra,0xffffe
    80004fe8:	d38080e7          	jalr	-712(ra) # 80002d1c <_ZN3SCBnwEm>
    80004fec:	00050493          	mv	s1,a0
    80004ff0:	00050863          	beqz	a0,80005000 <_ZN11ConsoleUtil10initializeEv+0x60>
    80004ff4:	00000593          	li	a1,0
    80004ff8:	ffffe097          	auipc	ra,0xffffe
    80004ffc:	b70080e7          	jalr	-1168(ra) # 80002b68 <_ZN3SCBC1Em>
    80005000:	00007917          	auipc	s2,0x7
    80005004:	0c890913          	addi	s2,s2,200 # 8000c0c8 <_ZN11ConsoleUtil8inputSemE>
    80005008:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    8000500c:	00007497          	auipc	s1,0x7
    80005010:	d3c48493          	addi	s1,s1,-708 # 8000bd48 <_ZN11ConsoleUtil10bufferSizeE>
    80005014:	0004b503          	ld	a0,0(s1)
    80005018:	00000097          	auipc	ra,0x0
    8000501c:	538080e7          	jalr	1336(ra) # 80005550 <_Z7kmallocm>
    80005020:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80005024:	0004b503          	ld	a0,0(s1)
    80005028:	00000097          	auipc	ra,0x0
    8000502c:	528080e7          	jalr	1320(ra) # 80005550 <_Z7kmallocm>
    80005030:	00a93c23          	sd	a0,24(s2)
}
    80005034:	01813083          	ld	ra,24(sp)
    80005038:	01013403          	ld	s0,16(sp)
    8000503c:	00813483          	ld	s1,8(sp)
    80005040:	00013903          	ld	s2,0(sp)
    80005044:	02010113          	addi	sp,sp,32
    80005048:	00008067          	ret
    8000504c:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80005050:	00048513          	mv	a0,s1
    80005054:	ffffe097          	auipc	ra,0xffffe
    80005058:	cf8080e7          	jalr	-776(ra) # 80002d4c <_ZN3SCBdlEPv>
    8000505c:	00090513          	mv	a0,s2
    80005060:	00008097          	auipc	ra,0x8
    80005064:	1a8080e7          	jalr	424(ra) # 8000d208 <_Unwind_Resume>
    80005068:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    8000506c:	00048513          	mv	a0,s1
    80005070:	ffffe097          	auipc	ra,0xffffe
    80005074:	cdc080e7          	jalr	-804(ra) # 80002d4c <_ZN3SCBdlEPv>
    80005078:	00090513          	mv	a0,s2
    8000507c:	00008097          	auipc	ra,0x8
    80005080:	18c080e7          	jalr	396(ra) # 8000d208 <_Unwind_Resume>

0000000080005084 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80005084:	00007717          	auipc	a4,0x7
    80005088:	04470713          	addi	a4,a4,68 # 8000c0c8 <_ZN11ConsoleUtil8inputSemE>
    8000508c:	02073683          	ld	a3,32(a4)
    80005090:	00168793          	addi	a5,a3,1
    80005094:	00007617          	auipc	a2,0x7
    80005098:	cb463603          	ld	a2,-844(a2) # 8000bd48 <_ZN11ConsoleUtil10bufferSizeE>
    8000509c:	02c7f7b3          	remu	a5,a5,a2
    800050a0:	02873703          	ld	a4,40(a4)
    800050a4:	04e78e63          	beq	a5,a4,80005100 <_ZN11ConsoleUtil8putInputEc+0x7c>
void ConsoleUtil::putInput(char c) {
    800050a8:	ff010113          	addi	sp,sp,-16
    800050ac:	00113423          	sd	ra,8(sp)
    800050b0:	00813023          	sd	s0,0(sp)
    800050b4:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    800050b8:	00007717          	auipc	a4,0x7
    800050bc:	01070713          	addi	a4,a4,16 # 8000c0c8 <_ZN11ConsoleUtil8inputSemE>
    800050c0:	01073783          	ld	a5,16(a4)
    800050c4:	00d786b3          	add	a3,a5,a3
    800050c8:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    800050cc:	02073783          	ld	a5,32(a4)
    800050d0:	00178793          	addi	a5,a5,1
    800050d4:	00007697          	auipc	a3,0x7
    800050d8:	c746b683          	ld	a3,-908(a3) # 8000bd48 <_ZN11ConsoleUtil10bufferSizeE>
    800050dc:	02d7f7b3          	remu	a5,a5,a3
    800050e0:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    800050e4:	00073503          	ld	a0,0(a4)
    800050e8:	ffffe097          	auipc	ra,0xffffe
    800050ec:	bf8080e7          	jalr	-1032(ra) # 80002ce0 <_ZN3SCB6signalEv>
}
    800050f0:	00813083          	ld	ra,8(sp)
    800050f4:	00013403          	ld	s0,0(sp)
    800050f8:	01010113          	addi	sp,sp,16
    800050fc:	00008067          	ret
    80005100:	00008067          	ret

0000000080005104 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80005104:	fe010113          	addi	sp,sp,-32
    80005108:	00113c23          	sd	ra,24(sp)
    8000510c:	00813823          	sd	s0,16(sp)
    80005110:	00913423          	sd	s1,8(sp)
    80005114:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80005118:	00007497          	auipc	s1,0x7
    8000511c:	fb048493          	addi	s1,s1,-80 # 8000c0c8 <_ZN11ConsoleUtil8inputSemE>
    80005120:	0004b503          	ld	a0,0(s1)
    80005124:	ffffe097          	auipc	ra,0xffffe
    80005128:	b6c080e7          	jalr	-1172(ra) # 80002c90 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    8000512c:	0284b783          	ld	a5,40(s1)
    80005130:	0204b703          	ld	a4,32(s1)
    80005134:	02e78c63          	beq	a5,a4,8000516c <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    80005138:	0104b703          	ld	a4,16(s1)
    8000513c:	00f70733          	add	a4,a4,a5
    80005140:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80005144:	00178793          	addi	a5,a5,1
    80005148:	00007717          	auipc	a4,0x7
    8000514c:	c0073703          	ld	a4,-1024(a4) # 8000bd48 <_ZN11ConsoleUtil10bufferSizeE>
    80005150:	02e7f7b3          	remu	a5,a5,a4
    80005154:	02f4b423          	sd	a5,40(s1)

    return c;
}
    80005158:	01813083          	ld	ra,24(sp)
    8000515c:	01013403          	ld	s0,16(sp)
    80005160:	00813483          	ld	s1,8(sp)
    80005164:	02010113          	addi	sp,sp,32
    80005168:	00008067          	ret
        return -1;
    8000516c:	0ff00513          	li	a0,255
    80005170:	fe9ff06f          	j	80005158 <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080005174 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80005174:	00007797          	auipc	a5,0x7
    80005178:	f5478793          	addi	a5,a5,-172 # 8000c0c8 <_ZN11ConsoleUtil8inputSemE>
    8000517c:	0307b703          	ld	a4,48(a5)
    80005180:	00170713          	addi	a4,a4,1
    80005184:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80005188:	0387b683          	ld	a3,56(a5)
    8000518c:	00168713          	addi	a4,a3,1
    80005190:	00007617          	auipc	a2,0x7
    80005194:	bb863603          	ld	a2,-1096(a2) # 8000bd48 <_ZN11ConsoleUtil10bufferSizeE>
    80005198:	02c77733          	remu	a4,a4,a2
    8000519c:	0407b783          	ld	a5,64(a5)
    800051a0:	06f70463          	beq	a4,a5,80005208 <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    800051a4:	ff010113          	addi	sp,sp,-16
    800051a8:	00113423          	sd	ra,8(sp)
    800051ac:	00813023          	sd	s0,0(sp)
    800051b0:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    800051b4:	00007797          	auipc	a5,0x7
    800051b8:	f1478793          	addi	a5,a5,-236 # 8000c0c8 <_ZN11ConsoleUtil8inputSemE>
    800051bc:	0187b703          	ld	a4,24(a5)
    800051c0:	00d706b3          	add	a3,a4,a3
    800051c4:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    800051c8:	0387b703          	ld	a4,56(a5)
    800051cc:	00170713          	addi	a4,a4,1
    800051d0:	00007697          	auipc	a3,0x7
    800051d4:	b786b683          	ld	a3,-1160(a3) # 8000bd48 <_ZN11ConsoleUtil10bufferSizeE>
    800051d8:	02d77733          	remu	a4,a4,a3
    800051dc:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    800051e0:	0307b703          	ld	a4,48(a5)
    800051e4:	fff70713          	addi	a4,a4,-1
    800051e8:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    800051ec:	0087b503          	ld	a0,8(a5)
    800051f0:	ffffe097          	auipc	ra,0xffffe
    800051f4:	af0080e7          	jalr	-1296(ra) # 80002ce0 <_ZN3SCB6signalEv>
}
    800051f8:	00813083          	ld	ra,8(sp)
    800051fc:	00013403          	ld	s0,0(sp)
    80005200:	01010113          	addi	sp,sp,16
    80005204:	00008067          	ret
    80005208:	00008067          	ret

000000008000520c <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    8000520c:	fe010113          	addi	sp,sp,-32
    80005210:	00113c23          	sd	ra,24(sp)
    80005214:	00813823          	sd	s0,16(sp)
    80005218:	00913423          	sd	s1,8(sp)
    8000521c:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80005220:	00007497          	auipc	s1,0x7
    80005224:	ea848493          	addi	s1,s1,-344 # 8000c0c8 <_ZN11ConsoleUtil8inputSemE>
    80005228:	0084b503          	ld	a0,8(s1)
    8000522c:	ffffe097          	auipc	ra,0xffffe
    80005230:	a64080e7          	jalr	-1436(ra) # 80002c90 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80005234:	0404b783          	ld	a5,64(s1)
    80005238:	0384b703          	ld	a4,56(s1)
    8000523c:	02e78c63          	beq	a5,a4,80005274 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    80005240:	0184b703          	ld	a4,24(s1)
    80005244:	00f70733          	add	a4,a4,a5
    80005248:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    8000524c:	00178793          	addi	a5,a5,1
    80005250:	00007717          	auipc	a4,0x7
    80005254:	af873703          	ld	a4,-1288(a4) # 8000bd48 <_ZN11ConsoleUtil10bufferSizeE>
    80005258:	02e7f7b3          	remu	a5,a5,a4
    8000525c:	04f4b023          	sd	a5,64(s1)

    return c;
}
    80005260:	01813083          	ld	ra,24(sp)
    80005264:	01013403          	ld	s0,16(sp)
    80005268:	00813483          	ld	s1,8(sp)
    8000526c:	02010113          	addi	sp,sp,32
    80005270:	00008067          	ret
        return -1;
    80005274:	0ff00513          	li	a0,255
    80005278:	fe9ff06f          	j	80005260 <_ZN11ConsoleUtil9getOutputEv+0x54>

000000008000527c <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    8000527c:	fe010113          	addi	sp,sp,-32
    80005280:	00113c23          	sd	ra,24(sp)
    80005284:	00813823          	sd	s0,16(sp)
    80005288:	00913423          	sd	s1,8(sp)
    8000528c:	02010413          	addi	s0,sp,32
    80005290:	00050493          	mv	s1,a0
    while (*string != '\0')
    80005294:	0004c503          	lbu	a0,0(s1)
    80005298:	00050a63          	beqz	a0,800052ac <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    8000529c:	00000097          	auipc	ra,0x0
    800052a0:	ed8080e7          	jalr	-296(ra) # 80005174 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    800052a4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800052a8:	fedff06f          	j	80005294 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    800052ac:	01813083          	ld	ra,24(sp)
    800052b0:	01013403          	ld	s0,16(sp)
    800052b4:	00813483          	ld	s1,8(sp)
    800052b8:	02010113          	addi	sp,sp,32
    800052bc:	00008067          	ret

00000000800052c0 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800052c0:	fb010113          	addi	sp,sp,-80
    800052c4:	04113423          	sd	ra,72(sp)
    800052c8:	04813023          	sd	s0,64(sp)
    800052cc:	02913c23          	sd	s1,56(sp)
    800052d0:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800052d4:	00004797          	auipc	a5,0x4
    800052d8:	27478793          	addi	a5,a5,628 # 80009548 <CONSOLE_STATUS+0x538>
    800052dc:	0007b703          	ld	a4,0(a5)
    800052e0:	fce43423          	sd	a4,-56(s0)
    800052e4:	0087b703          	ld	a4,8(a5)
    800052e8:	fce43823          	sd	a4,-48(s0)
    800052ec:	0107c783          	lbu	a5,16(a5)
    800052f0:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800052f4:	00060463          	beqz	a2,800052fc <_ZN11ConsoleUtil8printIntEiii+0x3c>
    800052f8:	08054263          	bltz	a0,8000537c <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800052fc:	0005051b          	sext.w	a0,a0
    neg = 0;
    80005300:	00000813          	li	a6,0
    }

    i = 0;
    80005304:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80005308:	0005871b          	sext.w	a4,a1
    8000530c:	02b577bb          	remuw	a5,a0,a1
    80005310:	00048693          	mv	a3,s1
    80005314:	0014849b          	addiw	s1,s1,1
    80005318:	02079793          	slli	a5,a5,0x20
    8000531c:	0207d793          	srli	a5,a5,0x20
    80005320:	fe040613          	addi	a2,s0,-32
    80005324:	00f607b3          	add	a5,a2,a5
    80005328:	fe87c603          	lbu	a2,-24(a5)
    8000532c:	fe040793          	addi	a5,s0,-32
    80005330:	00d787b3          	add	a5,a5,a3
    80005334:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80005338:	0005061b          	sext.w	a2,a0
    8000533c:	02b5553b          	divuw	a0,a0,a1
    80005340:	fce674e3          	bgeu	a2,a4,80005308 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80005344:	00080c63          	beqz	a6,8000535c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80005348:	fe040793          	addi	a5,s0,-32
    8000534c:	009784b3          	add	s1,a5,s1
    80005350:	02d00793          	li	a5,45
    80005354:	fcf48c23          	sb	a5,-40(s1)
    80005358:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    8000535c:	fff4849b          	addiw	s1,s1,-1
    80005360:	0204c463          	bltz	s1,80005388 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80005364:	fe040793          	addi	a5,s0,-32
    80005368:	009787b3          	add	a5,a5,s1
    8000536c:	fd87c503          	lbu	a0,-40(a5)
    80005370:	00000097          	auipc	ra,0x0
    80005374:	e04080e7          	jalr	-508(ra) # 80005174 <_ZN11ConsoleUtil9putOutputEc>
    80005378:	fe5ff06f          	j	8000535c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    8000537c:	40a0053b          	negw	a0,a0
        neg = 1;
    80005380:	00100813          	li	a6,1
        x = -xx;
    80005384:	f81ff06f          	j	80005304 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80005388:	04813083          	ld	ra,72(sp)
    8000538c:	04013403          	ld	s0,64(sp)
    80005390:	03813483          	ld	s1,56(sp)
    80005394:	05010113          	addi	sp,sp,80
    80005398:	00008067          	ret

000000008000539c <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    8000539c:	fd010113          	addi	sp,sp,-48
    800053a0:	02113423          	sd	ra,40(sp)
    800053a4:	02813023          	sd	s0,32(sp)
    800053a8:	00913c23          	sd	s1,24(sp)
    800053ac:	01213823          	sd	s2,16(sp)
    800053b0:	01313423          	sd	s3,8(sp)
    800053b4:	03010413          	addi	s0,sp,48
    800053b8:	00058913          	mv	s2,a1
    800053bc:	00060493          	mv	s1,a2
    800053c0:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    800053c4:	00000097          	auipc	ra,0x0
    800053c8:	eb8080e7          	jalr	-328(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    800053cc:	00000613          	li	a2,0
    800053d0:	00098593          	mv	a1,s3
    800053d4:	00090513          	mv	a0,s2
    800053d8:	00000097          	auipc	ra,0x0
    800053dc:	ee8080e7          	jalr	-280(ra) # 800052c0 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    800053e0:	00048513          	mv	a0,s1
    800053e4:	00000097          	auipc	ra,0x0
    800053e8:	e98080e7          	jalr	-360(ra) # 8000527c <_ZN11ConsoleUtil11printStringEPKc>
}
    800053ec:	02813083          	ld	ra,40(sp)
    800053f0:	02013403          	ld	s0,32(sp)
    800053f4:	01813483          	ld	s1,24(sp)
    800053f8:	01013903          	ld	s2,16(sp)
    800053fc:	00813983          	ld	s3,8(sp)
    80005400:	03010113          	addi	sp,sp,48
    80005404:	00008067          	ret

0000000080005408 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80005408:	ff010113          	addi	sp,sp,-16
    8000540c:	00813423          	sd	s0,8(sp)
    80005410:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80005414:	04300513          	li	a0,67

    asm("ecall");
    80005418:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    8000541c:	00050513          	mv	a0,a0

    return (char)status;
}
    80005420:	0ff57513          	andi	a0,a0,255
    80005424:	00813403          	ld	s0,8(sp)
    80005428:	01010113          	addi	sp,sp,16
    8000542c:	00008067          	ret

0000000080005430 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80005430:	ff010113          	addi	sp,sp,-16
    80005434:	00113423          	sd	ra,8(sp)
    80005438:	00813023          	sd	s0,0(sp)
    8000543c:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80005440:	ffffc097          	auipc	ra,0xffffc
    80005444:	598080e7          	jalr	1432(ra) # 800019d8 <_ZN13SlabAllocator10initializeEPvm>
}
    80005448:	00813083          	ld	ra,8(sp)
    8000544c:	00013403          	ld	s0,0(sp)
    80005450:	01010113          	addi	sp,sp,16
    80005454:	00008067          	ret

0000000080005458 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80005458:	ff010113          	addi	sp,sp,-16
    8000545c:	00113423          	sd	ra,8(sp)
    80005460:	00813023          	sd	s0,0(sp)
    80005464:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80005468:	ffffc097          	auipc	ra,0xffffc
    8000546c:	4cc080e7          	jalr	1228(ra) # 80001934 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80005470:	00813083          	ld	ra,8(sp)
    80005474:	00013403          	ld	s0,0(sp)
    80005478:	01010113          	addi	sp,sp,16
    8000547c:	00008067          	ret

0000000080005480 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80005480:	ff010113          	addi	sp,sp,-16
    80005484:	00113423          	sd	ra,8(sp)
    80005488:	00813023          	sd	s0,0(sp)
    8000548c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80005490:	ffffc097          	auipc	ra,0xffffc
    80005494:	368080e7          	jalr	872(ra) # 800017f8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80005498:	00813083          	ld	ra,8(sp)
    8000549c:	00013403          	ld	s0,0(sp)
    800054a0:	01010113          	addi	sp,sp,16
    800054a4:	00008067          	ret

00000000800054a8 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    800054a8:	ff010113          	addi	sp,sp,-16
    800054ac:	00113423          	sd	ra,8(sp)
    800054b0:	00813023          	sd	s0,0(sp)
    800054b4:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    800054b8:	ffffc097          	auipc	ra,0xffffc
    800054bc:	6f8080e7          	jalr	1784(ra) # 80001bb0 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    800054c0:	00813083          	ld	ra,8(sp)
    800054c4:	00013403          	ld	s0,0(sp)
    800054c8:	01010113          	addi	sp,sp,16
    800054cc:	00008067          	ret

00000000800054d0 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    800054d0:	fe010113          	addi	sp,sp,-32
    800054d4:	00113c23          	sd	ra,24(sp)
    800054d8:	00813823          	sd	s0,16(sp)
    800054dc:	02010413          	addi	s0,sp,32
    800054e0:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    800054e4:	fe840513          	addi	a0,s0,-24
    800054e8:	ffffd097          	auipc	ra,0xffffd
    800054ec:	828080e7          	jalr	-2008(ra) # 80001d10 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    800054f0:	01813083          	ld	ra,24(sp)
    800054f4:	01013403          	ld	s0,16(sp)
    800054f8:	02010113          	addi	sp,sp,32
    800054fc:	00008067          	ret

0000000080005500 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80005500:	ff010113          	addi	sp,sp,-16
    80005504:	00113423          	sd	ra,8(sp)
    80005508:	00813023          	sd	s0,0(sp)
    8000550c:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80005510:	ffffc097          	auipc	ra,0xffffc
    80005514:	e0c080e7          	jalr	-500(ra) # 8000131c <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80005518:	00813083          	ld	ra,8(sp)
    8000551c:	00013403          	ld	s0,0(sp)
    80005520:	01010113          	addi	sp,sp,16
    80005524:	00008067          	ret

0000000080005528 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80005528:	ff010113          	addi	sp,sp,-16
    8000552c:	00113423          	sd	ra,8(sp)
    80005530:	00813023          	sd	s0,0(sp)
    80005534:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80005538:	ffffc097          	auipc	ra,0xffffc
    8000553c:	c1c080e7          	jalr	-996(ra) # 80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80005540:	00813083          	ld	ra,8(sp)
    80005544:	00013403          	ld	s0,0(sp)
    80005548:	01010113          	addi	sp,sp,16
    8000554c:	00008067          	ret

0000000080005550 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80005550:	ff010113          	addi	sp,sp,-16
    80005554:	00113423          	sd	ra,8(sp)
    80005558:	00813023          	sd	s0,0(sp)
    8000555c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80005560:	ffffc097          	auipc	ra,0xffffc
    80005564:	334080e7          	jalr	820(ra) # 80001894 <_ZN13SlabAllocator14allocateBufferEm>
}
    80005568:	00813083          	ld	ra,8(sp)
    8000556c:	00013403          	ld	s0,0(sp)
    80005570:	01010113          	addi	sp,sp,16
    80005574:	00008067          	ret

0000000080005578 <_Z5kfreePKv>:

void kfree(const void* objp){
    80005578:	ff010113          	addi	sp,sp,-16
    8000557c:	00113423          	sd	ra,8(sp)
    80005580:	00813023          	sd	s0,0(sp)
    80005584:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80005588:	ffffc097          	auipc	ra,0xffffc
    8000558c:	71c080e7          	jalr	1820(ra) # 80001ca4 <_ZN13SlabAllocator10freeBufferEPKv>
    80005590:	00813083          	ld	ra,8(sp)
    80005594:	00013403          	ld	s0,0(sp)
    80005598:	01010113          	addi	sp,sp,16
    8000559c:	00008067          	ret

00000000800055a0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800055a0:	fd010113          	addi	sp,sp,-48
    800055a4:	02113423          	sd	ra,40(sp)
    800055a8:	02813023          	sd	s0,32(sp)
    800055ac:	00913c23          	sd	s1,24(sp)
    800055b0:	01213823          	sd	s2,16(sp)
    800055b4:	01313423          	sd	s3,8(sp)
    800055b8:	03010413          	addi	s0,sp,48
    800055bc:	00050493          	mv	s1,a0
    800055c0:	00058993          	mv	s3,a1
    800055c4:	0015879b          	addiw	a5,a1,1
    800055c8:	0007851b          	sext.w	a0,a5
    800055cc:	00f4a023          	sw	a5,0(s1)
    800055d0:	0004a823          	sw	zero,16(s1)
    800055d4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800055d8:	00251513          	slli	a0,a0,0x2
    800055dc:	ffffd097          	auipc	ra,0xffffd
    800055e0:	810080e7          	jalr	-2032(ra) # 80001dec <_Z9mem_allocm>
    800055e4:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800055e8:	01000513          	li	a0,16
    800055ec:	ffffe097          	auipc	ra,0xffffe
    800055f0:	094080e7          	jalr	148(ra) # 80003680 <_Znwm>
    800055f4:	00050913          	mv	s2,a0
    800055f8:	00050863          	beqz	a0,80005608 <_ZN9BufferCPPC1Ei+0x68>
    800055fc:	00000593          	li	a1,0
    80005600:	ffffe097          	auipc	ra,0xffffe
    80005604:	178080e7          	jalr	376(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    80005608:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000560c:	01000513          	li	a0,16
    80005610:	ffffe097          	auipc	ra,0xffffe
    80005614:	070080e7          	jalr	112(ra) # 80003680 <_Znwm>
    80005618:	00050913          	mv	s2,a0
    8000561c:	00050863          	beqz	a0,8000562c <_ZN9BufferCPPC1Ei+0x8c>
    80005620:	00098593          	mv	a1,s3
    80005624:	ffffe097          	auipc	ra,0xffffe
    80005628:	154080e7          	jalr	340(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    8000562c:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80005630:	01000513          	li	a0,16
    80005634:	ffffe097          	auipc	ra,0xffffe
    80005638:	04c080e7          	jalr	76(ra) # 80003680 <_Znwm>
    8000563c:	00050913          	mv	s2,a0
    80005640:	00050863          	beqz	a0,80005650 <_ZN9BufferCPPC1Ei+0xb0>
    80005644:	00100593          	li	a1,1
    80005648:	ffffe097          	auipc	ra,0xffffe
    8000564c:	130080e7          	jalr	304(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    80005650:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80005654:	01000513          	li	a0,16
    80005658:	ffffe097          	auipc	ra,0xffffe
    8000565c:	028080e7          	jalr	40(ra) # 80003680 <_Znwm>
    80005660:	00050913          	mv	s2,a0
    80005664:	00050863          	beqz	a0,80005674 <_ZN9BufferCPPC1Ei+0xd4>
    80005668:	00100593          	li	a1,1
    8000566c:	ffffe097          	auipc	ra,0xffffe
    80005670:	10c080e7          	jalr	268(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    80005674:	0324b823          	sd	s2,48(s1)
}
    80005678:	02813083          	ld	ra,40(sp)
    8000567c:	02013403          	ld	s0,32(sp)
    80005680:	01813483          	ld	s1,24(sp)
    80005684:	01013903          	ld	s2,16(sp)
    80005688:	00813983          	ld	s3,8(sp)
    8000568c:	03010113          	addi	sp,sp,48
    80005690:	00008067          	ret
    80005694:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80005698:	00090513          	mv	a0,s2
    8000569c:	ffffe097          	auipc	ra,0xffffe
    800056a0:	034080e7          	jalr	52(ra) # 800036d0 <_ZdlPv>
    800056a4:	00048513          	mv	a0,s1
    800056a8:	00008097          	auipc	ra,0x8
    800056ac:	b60080e7          	jalr	-1184(ra) # 8000d208 <_Unwind_Resume>
    800056b0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800056b4:	00090513          	mv	a0,s2
    800056b8:	ffffe097          	auipc	ra,0xffffe
    800056bc:	018080e7          	jalr	24(ra) # 800036d0 <_ZdlPv>
    800056c0:	00048513          	mv	a0,s1
    800056c4:	00008097          	auipc	ra,0x8
    800056c8:	b44080e7          	jalr	-1212(ra) # 8000d208 <_Unwind_Resume>
    800056cc:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800056d0:	00090513          	mv	a0,s2
    800056d4:	ffffe097          	auipc	ra,0xffffe
    800056d8:	ffc080e7          	jalr	-4(ra) # 800036d0 <_ZdlPv>
    800056dc:	00048513          	mv	a0,s1
    800056e0:	00008097          	auipc	ra,0x8
    800056e4:	b28080e7          	jalr	-1240(ra) # 8000d208 <_Unwind_Resume>
    800056e8:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800056ec:	00090513          	mv	a0,s2
    800056f0:	ffffe097          	auipc	ra,0xffffe
    800056f4:	fe0080e7          	jalr	-32(ra) # 800036d0 <_ZdlPv>
    800056f8:	00048513          	mv	a0,s1
    800056fc:	00008097          	auipc	ra,0x8
    80005700:	b0c080e7          	jalr	-1268(ra) # 8000d208 <_Unwind_Resume>

0000000080005704 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80005704:	fe010113          	addi	sp,sp,-32
    80005708:	00113c23          	sd	ra,24(sp)
    8000570c:	00813823          	sd	s0,16(sp)
    80005710:	00913423          	sd	s1,8(sp)
    80005714:	01213023          	sd	s2,0(sp)
    80005718:	02010413          	addi	s0,sp,32
    8000571c:	00050493          	mv	s1,a0
    80005720:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80005724:	01853503          	ld	a0,24(a0)
    80005728:	ffffe097          	auipc	ra,0xffffe
    8000572c:	088080e7          	jalr	136(ra) # 800037b0 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80005730:	0304b503          	ld	a0,48(s1)
    80005734:	ffffe097          	auipc	ra,0xffffe
    80005738:	07c080e7          	jalr	124(ra) # 800037b0 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000573c:	0084b783          	ld	a5,8(s1)
    80005740:	0144a703          	lw	a4,20(s1)
    80005744:	00271713          	slli	a4,a4,0x2
    80005748:	00e787b3          	add	a5,a5,a4
    8000574c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005750:	0144a783          	lw	a5,20(s1)
    80005754:	0017879b          	addiw	a5,a5,1
    80005758:	0004a703          	lw	a4,0(s1)
    8000575c:	02e7e7bb          	remw	a5,a5,a4
    80005760:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80005764:	0304b503          	ld	a0,48(s1)
    80005768:	ffffe097          	auipc	ra,0xffffe
    8000576c:	074080e7          	jalr	116(ra) # 800037dc <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80005770:	0204b503          	ld	a0,32(s1)
    80005774:	ffffe097          	auipc	ra,0xffffe
    80005778:	068080e7          	jalr	104(ra) # 800037dc <_ZN9Semaphore6signalEv>

}
    8000577c:	01813083          	ld	ra,24(sp)
    80005780:	01013403          	ld	s0,16(sp)
    80005784:	00813483          	ld	s1,8(sp)
    80005788:	00013903          	ld	s2,0(sp)
    8000578c:	02010113          	addi	sp,sp,32
    80005790:	00008067          	ret

0000000080005794 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80005794:	fe010113          	addi	sp,sp,-32
    80005798:	00113c23          	sd	ra,24(sp)
    8000579c:	00813823          	sd	s0,16(sp)
    800057a0:	00913423          	sd	s1,8(sp)
    800057a4:	01213023          	sd	s2,0(sp)
    800057a8:	02010413          	addi	s0,sp,32
    800057ac:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800057b0:	02053503          	ld	a0,32(a0)
    800057b4:	ffffe097          	auipc	ra,0xffffe
    800057b8:	ffc080e7          	jalr	-4(ra) # 800037b0 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800057bc:	0284b503          	ld	a0,40(s1)
    800057c0:	ffffe097          	auipc	ra,0xffffe
    800057c4:	ff0080e7          	jalr	-16(ra) # 800037b0 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800057c8:	0084b703          	ld	a4,8(s1)
    800057cc:	0104a783          	lw	a5,16(s1)
    800057d0:	00279693          	slli	a3,a5,0x2
    800057d4:	00d70733          	add	a4,a4,a3
    800057d8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800057dc:	0017879b          	addiw	a5,a5,1
    800057e0:	0004a703          	lw	a4,0(s1)
    800057e4:	02e7e7bb          	remw	a5,a5,a4
    800057e8:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800057ec:	0284b503          	ld	a0,40(s1)
    800057f0:	ffffe097          	auipc	ra,0xffffe
    800057f4:	fec080e7          	jalr	-20(ra) # 800037dc <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800057f8:	0184b503          	ld	a0,24(s1)
    800057fc:	ffffe097          	auipc	ra,0xffffe
    80005800:	fe0080e7          	jalr	-32(ra) # 800037dc <_ZN9Semaphore6signalEv>

    return ret;
}
    80005804:	00090513          	mv	a0,s2
    80005808:	01813083          	ld	ra,24(sp)
    8000580c:	01013403          	ld	s0,16(sp)
    80005810:	00813483          	ld	s1,8(sp)
    80005814:	00013903          	ld	s2,0(sp)
    80005818:	02010113          	addi	sp,sp,32
    8000581c:	00008067          	ret

0000000080005820 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80005820:	fe010113          	addi	sp,sp,-32
    80005824:	00113c23          	sd	ra,24(sp)
    80005828:	00813823          	sd	s0,16(sp)
    8000582c:	00913423          	sd	s1,8(sp)
    80005830:	01213023          	sd	s2,0(sp)
    80005834:	02010413          	addi	s0,sp,32
    80005838:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000583c:	02853503          	ld	a0,40(a0)
    80005840:	ffffe097          	auipc	ra,0xffffe
    80005844:	f70080e7          	jalr	-144(ra) # 800037b0 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80005848:	0304b503          	ld	a0,48(s1)
    8000584c:	ffffe097          	auipc	ra,0xffffe
    80005850:	f64080e7          	jalr	-156(ra) # 800037b0 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005854:	0144a783          	lw	a5,20(s1)
    80005858:	0104a903          	lw	s2,16(s1)
    8000585c:	0327ce63          	blt	a5,s2,80005898 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80005860:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005864:	0304b503          	ld	a0,48(s1)
    80005868:	ffffe097          	auipc	ra,0xffffe
    8000586c:	f74080e7          	jalr	-140(ra) # 800037dc <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80005870:	0284b503          	ld	a0,40(s1)
    80005874:	ffffe097          	auipc	ra,0xffffe
    80005878:	f68080e7          	jalr	-152(ra) # 800037dc <_ZN9Semaphore6signalEv>

    return ret;
}
    8000587c:	00090513          	mv	a0,s2
    80005880:	01813083          	ld	ra,24(sp)
    80005884:	01013403          	ld	s0,16(sp)
    80005888:	00813483          	ld	s1,8(sp)
    8000588c:	00013903          	ld	s2,0(sp)
    80005890:	02010113          	addi	sp,sp,32
    80005894:	00008067          	ret
        ret = cap - head + tail;
    80005898:	0004a703          	lw	a4,0(s1)
    8000589c:	4127093b          	subw	s2,a4,s2
    800058a0:	00f9093b          	addw	s2,s2,a5
    800058a4:	fc1ff06f          	j	80005864 <_ZN9BufferCPP6getCntEv+0x44>

00000000800058a8 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800058a8:	fe010113          	addi	sp,sp,-32
    800058ac:	00113c23          	sd	ra,24(sp)
    800058b0:	00813823          	sd	s0,16(sp)
    800058b4:	00913423          	sd	s1,8(sp)
    800058b8:	02010413          	addi	s0,sp,32
    800058bc:	00050493          	mv	s1,a0
    Console::putc('\n');
    800058c0:	00a00513          	li	a0,10
    800058c4:	ffffe097          	auipc	ra,0xffffe
    800058c8:	150080e7          	jalr	336(ra) # 80003a14 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800058cc:	00004517          	auipc	a0,0x4
    800058d0:	c9450513          	addi	a0,a0,-876 # 80009560 <CONSOLE_STATUS+0x550>
    800058d4:	ffffd097          	auipc	ra,0xffffd
    800058d8:	f5c080e7          	jalr	-164(ra) # 80002830 <_Z11printStringPKc>
    while (getCnt()) {
    800058dc:	00048513          	mv	a0,s1
    800058e0:	00000097          	auipc	ra,0x0
    800058e4:	f40080e7          	jalr	-192(ra) # 80005820 <_ZN9BufferCPP6getCntEv>
    800058e8:	02050c63          	beqz	a0,80005920 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800058ec:	0084b783          	ld	a5,8(s1)
    800058f0:	0104a703          	lw	a4,16(s1)
    800058f4:	00271713          	slli	a4,a4,0x2
    800058f8:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800058fc:	0007c503          	lbu	a0,0(a5)
    80005900:	ffffe097          	auipc	ra,0xffffe
    80005904:	114080e7          	jalr	276(ra) # 80003a14 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80005908:	0104a783          	lw	a5,16(s1)
    8000590c:	0017879b          	addiw	a5,a5,1
    80005910:	0004a703          	lw	a4,0(s1)
    80005914:	02e7e7bb          	remw	a5,a5,a4
    80005918:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000591c:	fc1ff06f          	j	800058dc <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80005920:	02100513          	li	a0,33
    80005924:	ffffe097          	auipc	ra,0xffffe
    80005928:	0f0080e7          	jalr	240(ra) # 80003a14 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000592c:	00a00513          	li	a0,10
    80005930:	ffffe097          	auipc	ra,0xffffe
    80005934:	0e4080e7          	jalr	228(ra) # 80003a14 <_ZN7Console4putcEc>
    mem_free(buffer);
    80005938:	0084b503          	ld	a0,8(s1)
    8000593c:	ffffc097          	auipc	ra,0xffffc
    80005940:	4e0080e7          	jalr	1248(ra) # 80001e1c <_Z8mem_freePv>
    delete itemAvailable;
    80005944:	0204b503          	ld	a0,32(s1)
    80005948:	00050863          	beqz	a0,80005958 <_ZN9BufferCPPD1Ev+0xb0>
    8000594c:	00053783          	ld	a5,0(a0)
    80005950:	0087b783          	ld	a5,8(a5)
    80005954:	000780e7          	jalr	a5
    delete spaceAvailable;
    80005958:	0184b503          	ld	a0,24(s1)
    8000595c:	00050863          	beqz	a0,8000596c <_ZN9BufferCPPD1Ev+0xc4>
    80005960:	00053783          	ld	a5,0(a0)
    80005964:	0087b783          	ld	a5,8(a5)
    80005968:	000780e7          	jalr	a5
    delete mutexTail;
    8000596c:	0304b503          	ld	a0,48(s1)
    80005970:	00050863          	beqz	a0,80005980 <_ZN9BufferCPPD1Ev+0xd8>
    80005974:	00053783          	ld	a5,0(a0)
    80005978:	0087b783          	ld	a5,8(a5)
    8000597c:	000780e7          	jalr	a5
    delete mutexHead;
    80005980:	0284b503          	ld	a0,40(s1)
    80005984:	00050863          	beqz	a0,80005994 <_ZN9BufferCPPD1Ev+0xec>
    80005988:	00053783          	ld	a5,0(a0)
    8000598c:	0087b783          	ld	a5,8(a5)
    80005990:	000780e7          	jalr	a5
}
    80005994:	01813083          	ld	ra,24(sp)
    80005998:	01013403          	ld	s0,16(sp)
    8000599c:	00813483          	ld	s1,8(sp)
    800059a0:	02010113          	addi	sp,sp,32
    800059a4:	00008067          	ret

00000000800059a8 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    800059a8:	fe010113          	addi	sp,sp,-32
    800059ac:	00113c23          	sd	ra,24(sp)
    800059b0:	00813823          	sd	s0,16(sp)
    800059b4:	00913423          	sd	s1,8(sp)
    800059b8:	01213023          	sd	s2,0(sp)
    800059bc:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800059c0:	00000913          	li	s2,0
    800059c4:	0380006f          	j	800059fc <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800059c8:	ffffc097          	auipc	ra,0xffffc
    800059cc:	534080e7          	jalr	1332(ra) # 80001efc <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800059d0:	00148493          	addi	s1,s1,1
    800059d4:	000027b7          	lui	a5,0x2
    800059d8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800059dc:	0097ee63          	bltu	a5,s1,800059f8 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800059e0:	00000713          	li	a4,0
    800059e4:	000077b7          	lui	a5,0x7
    800059e8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800059ec:	fce7eee3          	bltu	a5,a4,800059c8 <_Z11workerBodyAPv+0x20>
    800059f0:	00170713          	addi	a4,a4,1
    800059f4:	ff1ff06f          	j	800059e4 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800059f8:	00190913          	addi	s2,s2,1
    800059fc:	00900793          	li	a5,9
    80005a00:	0527e063          	bltu	a5,s2,80005a40 <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005a04:	00004517          	auipc	a0,0x4
    80005a08:	b7450513          	addi	a0,a0,-1164 # 80009578 <CONSOLE_STATUS+0x568>
    80005a0c:	ffffd097          	auipc	ra,0xffffd
    80005a10:	e24080e7          	jalr	-476(ra) # 80002830 <_Z11printStringPKc>
    80005a14:	00000613          	li	a2,0
    80005a18:	00a00593          	li	a1,10
    80005a1c:	0009051b          	sext.w	a0,s2
    80005a20:	ffffd097          	auipc	ra,0xffffd
    80005a24:	fa8080e7          	jalr	-88(ra) # 800029c8 <_Z8printIntiii>
    80005a28:	00004517          	auipc	a0,0x4
    80005a2c:	92850513          	addi	a0,a0,-1752 # 80009350 <CONSOLE_STATUS+0x340>
    80005a30:	ffffd097          	auipc	ra,0xffffd
    80005a34:	e00080e7          	jalr	-512(ra) # 80002830 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005a38:	00000493          	li	s1,0
    80005a3c:	f99ff06f          	j	800059d4 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    80005a40:	00004517          	auipc	a0,0x4
    80005a44:	b4050513          	addi	a0,a0,-1216 # 80009580 <CONSOLE_STATUS+0x570>
    80005a48:	ffffd097          	auipc	ra,0xffffd
    80005a4c:	de8080e7          	jalr	-536(ra) # 80002830 <_Z11printStringPKc>
    finishedA = true;
    80005a50:	00100793          	li	a5,1
    80005a54:	00006717          	auipc	a4,0x6
    80005a58:	6cf70223          	sb	a5,1732(a4) # 8000c118 <finishedA>
}
    80005a5c:	01813083          	ld	ra,24(sp)
    80005a60:	01013403          	ld	s0,16(sp)
    80005a64:	00813483          	ld	s1,8(sp)
    80005a68:	00013903          	ld	s2,0(sp)
    80005a6c:	02010113          	addi	sp,sp,32
    80005a70:	00008067          	ret

0000000080005a74 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80005a74:	fe010113          	addi	sp,sp,-32
    80005a78:	00113c23          	sd	ra,24(sp)
    80005a7c:	00813823          	sd	s0,16(sp)
    80005a80:	00913423          	sd	s1,8(sp)
    80005a84:	01213023          	sd	s2,0(sp)
    80005a88:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005a8c:	00000913          	li	s2,0
    80005a90:	0380006f          	j	80005ac8 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005a94:	ffffc097          	auipc	ra,0xffffc
    80005a98:	468080e7          	jalr	1128(ra) # 80001efc <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005a9c:	00148493          	addi	s1,s1,1
    80005aa0:	000027b7          	lui	a5,0x2
    80005aa4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005aa8:	0097ee63          	bltu	a5,s1,80005ac4 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005aac:	00000713          	li	a4,0
    80005ab0:	000077b7          	lui	a5,0x7
    80005ab4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005ab8:	fce7eee3          	bltu	a5,a4,80005a94 <_Z11workerBodyBPv+0x20>
    80005abc:	00170713          	addi	a4,a4,1
    80005ac0:	ff1ff06f          	j	80005ab0 <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005ac4:	00190913          	addi	s2,s2,1
    80005ac8:	00f00793          	li	a5,15
    80005acc:	0527e063          	bltu	a5,s2,80005b0c <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005ad0:	00004517          	auipc	a0,0x4
    80005ad4:	ac050513          	addi	a0,a0,-1344 # 80009590 <CONSOLE_STATUS+0x580>
    80005ad8:	ffffd097          	auipc	ra,0xffffd
    80005adc:	d58080e7          	jalr	-680(ra) # 80002830 <_Z11printStringPKc>
    80005ae0:	00000613          	li	a2,0
    80005ae4:	00a00593          	li	a1,10
    80005ae8:	0009051b          	sext.w	a0,s2
    80005aec:	ffffd097          	auipc	ra,0xffffd
    80005af0:	edc080e7          	jalr	-292(ra) # 800029c8 <_Z8printIntiii>
    80005af4:	00004517          	auipc	a0,0x4
    80005af8:	85c50513          	addi	a0,a0,-1956 # 80009350 <CONSOLE_STATUS+0x340>
    80005afc:	ffffd097          	auipc	ra,0xffffd
    80005b00:	d34080e7          	jalr	-716(ra) # 80002830 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005b04:	00000493          	li	s1,0
    80005b08:	f99ff06f          	j	80005aa0 <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    80005b0c:	00004517          	auipc	a0,0x4
    80005b10:	a8c50513          	addi	a0,a0,-1396 # 80009598 <CONSOLE_STATUS+0x588>
    80005b14:	ffffd097          	auipc	ra,0xffffd
    80005b18:	d1c080e7          	jalr	-740(ra) # 80002830 <_Z11printStringPKc>
    finishedB = true;
    80005b1c:	00100793          	li	a5,1
    80005b20:	00006717          	auipc	a4,0x6
    80005b24:	5ef70ca3          	sb	a5,1529(a4) # 8000c119 <finishedB>
    thread_dispatch();
    80005b28:	ffffc097          	auipc	ra,0xffffc
    80005b2c:	3d4080e7          	jalr	980(ra) # 80001efc <_Z15thread_dispatchv>
}
    80005b30:	01813083          	ld	ra,24(sp)
    80005b34:	01013403          	ld	s0,16(sp)
    80005b38:	00813483          	ld	s1,8(sp)
    80005b3c:	00013903          	ld	s2,0(sp)
    80005b40:	02010113          	addi	sp,sp,32
    80005b44:	00008067          	ret

0000000080005b48 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80005b48:	fe010113          	addi	sp,sp,-32
    80005b4c:	00113c23          	sd	ra,24(sp)
    80005b50:	00813823          	sd	s0,16(sp)
    80005b54:	00913423          	sd	s1,8(sp)
    80005b58:	01213023          	sd	s2,0(sp)
    80005b5c:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80005b60:	00053903          	ld	s2,0(a0)
    int i = 6;
    80005b64:	00600493          	li	s1,6
    while (--i > 0) {
    80005b68:	fff4849b          	addiw	s1,s1,-1
    80005b6c:	04905463          	blez	s1,80005bb4 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80005b70:	00004517          	auipc	a0,0x4
    80005b74:	a3850513          	addi	a0,a0,-1480 # 800095a8 <CONSOLE_STATUS+0x598>
    80005b78:	ffffd097          	auipc	ra,0xffffd
    80005b7c:	cb8080e7          	jalr	-840(ra) # 80002830 <_Z11printStringPKc>
        printInt(sleep_time);
    80005b80:	00000613          	li	a2,0
    80005b84:	00a00593          	li	a1,10
    80005b88:	0009051b          	sext.w	a0,s2
    80005b8c:	ffffd097          	auipc	ra,0xffffd
    80005b90:	e3c080e7          	jalr	-452(ra) # 800029c8 <_Z8printIntiii>
        printString(" !\n");
    80005b94:	00004517          	auipc	a0,0x4
    80005b98:	a1c50513          	addi	a0,a0,-1508 # 800095b0 <CONSOLE_STATUS+0x5a0>
    80005b9c:	ffffd097          	auipc	ra,0xffffd
    80005ba0:	c94080e7          	jalr	-876(ra) # 80002830 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80005ba4:	00090513          	mv	a0,s2
    80005ba8:	ffffc097          	auipc	ra,0xffffc
    80005bac:	4fc080e7          	jalr	1276(ra) # 800020a4 <_Z10time_sleepm>
    while (--i > 0) {
    80005bb0:	fb9ff06f          	j	80005b68 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80005bb4:	00a00793          	li	a5,10
    80005bb8:	02f95933          	divu	s2,s2,a5
    80005bbc:	fff90913          	addi	s2,s2,-1
    80005bc0:	00006797          	auipc	a5,0x6
    80005bc4:	55878793          	addi	a5,a5,1368 # 8000c118 <finishedA>
    80005bc8:	01278933          	add	s2,a5,s2
    80005bcc:	00100793          	li	a5,1
    80005bd0:	00f90423          	sb	a5,8(s2)
}
    80005bd4:	01813083          	ld	ra,24(sp)
    80005bd8:	01013403          	ld	s0,16(sp)
    80005bdc:	00813483          	ld	s1,8(sp)
    80005be0:	00013903          	ld	s2,0(sp)
    80005be4:	02010113          	addi	sp,sp,32
    80005be8:	00008067          	ret

0000000080005bec <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80005bec:	fe010113          	addi	sp,sp,-32
    80005bf0:	00113c23          	sd	ra,24(sp)
    80005bf4:	00813823          	sd	s0,16(sp)
    80005bf8:	00913423          	sd	s1,8(sp)
    80005bfc:	01213023          	sd	s2,0(sp)
    80005c00:	02010413          	addi	s0,sp,32
    80005c04:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005c08:	00100793          	li	a5,1
    80005c0c:	02a7f863          	bgeu	a5,a0,80005c3c <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005c10:	00a00793          	li	a5,10
    80005c14:	02f577b3          	remu	a5,a0,a5
    80005c18:	02078e63          	beqz	a5,80005c54 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005c1c:	fff48513          	addi	a0,s1,-1
    80005c20:	00000097          	auipc	ra,0x0
    80005c24:	fcc080e7          	jalr	-52(ra) # 80005bec <_Z9fibonaccim>
    80005c28:	00050913          	mv	s2,a0
    80005c2c:	ffe48513          	addi	a0,s1,-2
    80005c30:	00000097          	auipc	ra,0x0
    80005c34:	fbc080e7          	jalr	-68(ra) # 80005bec <_Z9fibonaccim>
    80005c38:	00a90533          	add	a0,s2,a0
}
    80005c3c:	01813083          	ld	ra,24(sp)
    80005c40:	01013403          	ld	s0,16(sp)
    80005c44:	00813483          	ld	s1,8(sp)
    80005c48:	00013903          	ld	s2,0(sp)
    80005c4c:	02010113          	addi	sp,sp,32
    80005c50:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005c54:	ffffc097          	auipc	ra,0xffffc
    80005c58:	2a8080e7          	jalr	680(ra) # 80001efc <_Z15thread_dispatchv>
    80005c5c:	fc1ff06f          	j	80005c1c <_Z9fibonaccim+0x30>

0000000080005c60 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80005c60:	fe010113          	addi	sp,sp,-32
    80005c64:	00113c23          	sd	ra,24(sp)
    80005c68:	00813823          	sd	s0,16(sp)
    80005c6c:	00913423          	sd	s1,8(sp)
    80005c70:	01213023          	sd	s2,0(sp)
    80005c74:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005c78:	00000493          	li	s1,0
    80005c7c:	0400006f          	j	80005cbc <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005c80:	00004517          	auipc	a0,0x4
    80005c84:	93850513          	addi	a0,a0,-1736 # 800095b8 <CONSOLE_STATUS+0x5a8>
    80005c88:	ffffd097          	auipc	ra,0xffffd
    80005c8c:	ba8080e7          	jalr	-1112(ra) # 80002830 <_Z11printStringPKc>
    80005c90:	00000613          	li	a2,0
    80005c94:	00a00593          	li	a1,10
    80005c98:	00048513          	mv	a0,s1
    80005c9c:	ffffd097          	auipc	ra,0xffffd
    80005ca0:	d2c080e7          	jalr	-724(ra) # 800029c8 <_Z8printIntiii>
    80005ca4:	00003517          	auipc	a0,0x3
    80005ca8:	6ac50513          	addi	a0,a0,1708 # 80009350 <CONSOLE_STATUS+0x340>
    80005cac:	ffffd097          	auipc	ra,0xffffd
    80005cb0:	b84080e7          	jalr	-1148(ra) # 80002830 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005cb4:	0014849b          	addiw	s1,s1,1
    80005cb8:	0ff4f493          	andi	s1,s1,255
    80005cbc:	00200793          	li	a5,2
    80005cc0:	fc97f0e3          	bgeu	a5,s1,80005c80 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    80005cc4:	00004517          	auipc	a0,0x4
    80005cc8:	8fc50513          	addi	a0,a0,-1796 # 800095c0 <CONSOLE_STATUS+0x5b0>
    80005ccc:	ffffd097          	auipc	ra,0xffffd
    80005cd0:	b64080e7          	jalr	-1180(ra) # 80002830 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005cd4:	00700313          	li	t1,7
    thread_dispatch();
    80005cd8:	ffffc097          	auipc	ra,0xffffc
    80005cdc:	224080e7          	jalr	548(ra) # 80001efc <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005ce0:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80005ce4:	00004517          	auipc	a0,0x4
    80005ce8:	8ec50513          	addi	a0,a0,-1812 # 800095d0 <CONSOLE_STATUS+0x5c0>
    80005cec:	ffffd097          	auipc	ra,0xffffd
    80005cf0:	b44080e7          	jalr	-1212(ra) # 80002830 <_Z11printStringPKc>
    80005cf4:	00000613          	li	a2,0
    80005cf8:	00a00593          	li	a1,10
    80005cfc:	0009051b          	sext.w	a0,s2
    80005d00:	ffffd097          	auipc	ra,0xffffd
    80005d04:	cc8080e7          	jalr	-824(ra) # 800029c8 <_Z8printIntiii>
    80005d08:	00003517          	auipc	a0,0x3
    80005d0c:	64850513          	addi	a0,a0,1608 # 80009350 <CONSOLE_STATUS+0x340>
    80005d10:	ffffd097          	auipc	ra,0xffffd
    80005d14:	b20080e7          	jalr	-1248(ra) # 80002830 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80005d18:	00c00513          	li	a0,12
    80005d1c:	00000097          	auipc	ra,0x0
    80005d20:	ed0080e7          	jalr	-304(ra) # 80005bec <_Z9fibonaccim>
    80005d24:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005d28:	00004517          	auipc	a0,0x4
    80005d2c:	8b050513          	addi	a0,a0,-1872 # 800095d8 <CONSOLE_STATUS+0x5c8>
    80005d30:	ffffd097          	auipc	ra,0xffffd
    80005d34:	b00080e7          	jalr	-1280(ra) # 80002830 <_Z11printStringPKc>
    80005d38:	00000613          	li	a2,0
    80005d3c:	00a00593          	li	a1,10
    80005d40:	0009051b          	sext.w	a0,s2
    80005d44:	ffffd097          	auipc	ra,0xffffd
    80005d48:	c84080e7          	jalr	-892(ra) # 800029c8 <_Z8printIntiii>
    80005d4c:	00003517          	auipc	a0,0x3
    80005d50:	60450513          	addi	a0,a0,1540 # 80009350 <CONSOLE_STATUS+0x340>
    80005d54:	ffffd097          	auipc	ra,0xffffd
    80005d58:	adc080e7          	jalr	-1316(ra) # 80002830 <_Z11printStringPKc>
    80005d5c:	0400006f          	j	80005d9c <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005d60:	00004517          	auipc	a0,0x4
    80005d64:	85850513          	addi	a0,a0,-1960 # 800095b8 <CONSOLE_STATUS+0x5a8>
    80005d68:	ffffd097          	auipc	ra,0xffffd
    80005d6c:	ac8080e7          	jalr	-1336(ra) # 80002830 <_Z11printStringPKc>
    80005d70:	00000613          	li	a2,0
    80005d74:	00a00593          	li	a1,10
    80005d78:	00048513          	mv	a0,s1
    80005d7c:	ffffd097          	auipc	ra,0xffffd
    80005d80:	c4c080e7          	jalr	-948(ra) # 800029c8 <_Z8printIntiii>
    80005d84:	00003517          	auipc	a0,0x3
    80005d88:	5cc50513          	addi	a0,a0,1484 # 80009350 <CONSOLE_STATUS+0x340>
    80005d8c:	ffffd097          	auipc	ra,0xffffd
    80005d90:	aa4080e7          	jalr	-1372(ra) # 80002830 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005d94:	0014849b          	addiw	s1,s1,1
    80005d98:	0ff4f493          	andi	s1,s1,255
    80005d9c:	00500793          	li	a5,5
    80005da0:	fc97f0e3          	bgeu	a5,s1,80005d60 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    80005da4:	00003517          	auipc	a0,0x3
    80005da8:	7dc50513          	addi	a0,a0,2012 # 80009580 <CONSOLE_STATUS+0x570>
    80005dac:	ffffd097          	auipc	ra,0xffffd
    80005db0:	a84080e7          	jalr	-1404(ra) # 80002830 <_Z11printStringPKc>
    finishedC = true;
    80005db4:	00100793          	li	a5,1
    80005db8:	00006717          	auipc	a4,0x6
    80005dbc:	36f70823          	sb	a5,880(a4) # 8000c128 <finishedC>
    thread_dispatch();
    80005dc0:	ffffc097          	auipc	ra,0xffffc
    80005dc4:	13c080e7          	jalr	316(ra) # 80001efc <_Z15thread_dispatchv>
}
    80005dc8:	01813083          	ld	ra,24(sp)
    80005dcc:	01013403          	ld	s0,16(sp)
    80005dd0:	00813483          	ld	s1,8(sp)
    80005dd4:	00013903          	ld	s2,0(sp)
    80005dd8:	02010113          	addi	sp,sp,32
    80005ddc:	00008067          	ret

0000000080005de0 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    80005de0:	fe010113          	addi	sp,sp,-32
    80005de4:	00113c23          	sd	ra,24(sp)
    80005de8:	00813823          	sd	s0,16(sp)
    80005dec:	00913423          	sd	s1,8(sp)
    80005df0:	01213023          	sd	s2,0(sp)
    80005df4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005df8:	00a00493          	li	s1,10
    80005dfc:	0400006f          	j	80005e3c <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005e00:	00003517          	auipc	a0,0x3
    80005e04:	7e850513          	addi	a0,a0,2024 # 800095e8 <CONSOLE_STATUS+0x5d8>
    80005e08:	ffffd097          	auipc	ra,0xffffd
    80005e0c:	a28080e7          	jalr	-1496(ra) # 80002830 <_Z11printStringPKc>
    80005e10:	00000613          	li	a2,0
    80005e14:	00a00593          	li	a1,10
    80005e18:	00048513          	mv	a0,s1
    80005e1c:	ffffd097          	auipc	ra,0xffffd
    80005e20:	bac080e7          	jalr	-1108(ra) # 800029c8 <_Z8printIntiii>
    80005e24:	00003517          	auipc	a0,0x3
    80005e28:	52c50513          	addi	a0,a0,1324 # 80009350 <CONSOLE_STATUS+0x340>
    80005e2c:	ffffd097          	auipc	ra,0xffffd
    80005e30:	a04080e7          	jalr	-1532(ra) # 80002830 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005e34:	0014849b          	addiw	s1,s1,1
    80005e38:	0ff4f493          	andi	s1,s1,255
    80005e3c:	00c00793          	li	a5,12
    80005e40:	fc97f0e3          	bgeu	a5,s1,80005e00 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005e44:	00003517          	auipc	a0,0x3
    80005e48:	7ac50513          	addi	a0,a0,1964 # 800095f0 <CONSOLE_STATUS+0x5e0>
    80005e4c:	ffffd097          	auipc	ra,0xffffd
    80005e50:	9e4080e7          	jalr	-1564(ra) # 80002830 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005e54:	00500313          	li	t1,5
    thread_dispatch();
    80005e58:	ffffc097          	auipc	ra,0xffffc
    80005e5c:	0a4080e7          	jalr	164(ra) # 80001efc <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005e60:	01000513          	li	a0,16
    80005e64:	00000097          	auipc	ra,0x0
    80005e68:	d88080e7          	jalr	-632(ra) # 80005bec <_Z9fibonaccim>
    80005e6c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005e70:	00003517          	auipc	a0,0x3
    80005e74:	79050513          	addi	a0,a0,1936 # 80009600 <CONSOLE_STATUS+0x5f0>
    80005e78:	ffffd097          	auipc	ra,0xffffd
    80005e7c:	9b8080e7          	jalr	-1608(ra) # 80002830 <_Z11printStringPKc>
    80005e80:	00000613          	li	a2,0
    80005e84:	00a00593          	li	a1,10
    80005e88:	0009051b          	sext.w	a0,s2
    80005e8c:	ffffd097          	auipc	ra,0xffffd
    80005e90:	b3c080e7          	jalr	-1220(ra) # 800029c8 <_Z8printIntiii>
    80005e94:	00003517          	auipc	a0,0x3
    80005e98:	4bc50513          	addi	a0,a0,1212 # 80009350 <CONSOLE_STATUS+0x340>
    80005e9c:	ffffd097          	auipc	ra,0xffffd
    80005ea0:	994080e7          	jalr	-1644(ra) # 80002830 <_Z11printStringPKc>
    80005ea4:	0400006f          	j	80005ee4 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005ea8:	00003517          	auipc	a0,0x3
    80005eac:	74050513          	addi	a0,a0,1856 # 800095e8 <CONSOLE_STATUS+0x5d8>
    80005eb0:	ffffd097          	auipc	ra,0xffffd
    80005eb4:	980080e7          	jalr	-1664(ra) # 80002830 <_Z11printStringPKc>
    80005eb8:	00000613          	li	a2,0
    80005ebc:	00a00593          	li	a1,10
    80005ec0:	00048513          	mv	a0,s1
    80005ec4:	ffffd097          	auipc	ra,0xffffd
    80005ec8:	b04080e7          	jalr	-1276(ra) # 800029c8 <_Z8printIntiii>
    80005ecc:	00003517          	auipc	a0,0x3
    80005ed0:	48450513          	addi	a0,a0,1156 # 80009350 <CONSOLE_STATUS+0x340>
    80005ed4:	ffffd097          	auipc	ra,0xffffd
    80005ed8:	95c080e7          	jalr	-1700(ra) # 80002830 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005edc:	0014849b          	addiw	s1,s1,1
    80005ee0:	0ff4f493          	andi	s1,s1,255
    80005ee4:	00f00793          	li	a5,15
    80005ee8:	fc97f0e3          	bgeu	a5,s1,80005ea8 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005eec:	00003517          	auipc	a0,0x3
    80005ef0:	72450513          	addi	a0,a0,1828 # 80009610 <CONSOLE_STATUS+0x600>
    80005ef4:	ffffd097          	auipc	ra,0xffffd
    80005ef8:	93c080e7          	jalr	-1732(ra) # 80002830 <_Z11printStringPKc>
    finishedD = true;
    80005efc:	00100793          	li	a5,1
    80005f00:	00006717          	auipc	a4,0x6
    80005f04:	22f704a3          	sb	a5,553(a4) # 8000c129 <finishedD>
    thread_dispatch();
    80005f08:	ffffc097          	auipc	ra,0xffffc
    80005f0c:	ff4080e7          	jalr	-12(ra) # 80001efc <_Z15thread_dispatchv>
}
    80005f10:	01813083          	ld	ra,24(sp)
    80005f14:	01013403          	ld	s0,16(sp)
    80005f18:	00813483          	ld	s1,8(sp)
    80005f1c:	00013903          	ld	s2,0(sp)
    80005f20:	02010113          	addi	sp,sp,32
    80005f24:	00008067          	ret

0000000080005f28 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80005f28:	fc010113          	addi	sp,sp,-64
    80005f2c:	02113c23          	sd	ra,56(sp)
    80005f30:	02813823          	sd	s0,48(sp)
    80005f34:	02913423          	sd	s1,40(sp)
    80005f38:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005f3c:	00000613          	li	a2,0
    80005f40:	00000597          	auipc	a1,0x0
    80005f44:	a6858593          	addi	a1,a1,-1432 # 800059a8 <_Z11workerBodyAPv>
    80005f48:	fc040513          	addi	a0,s0,-64
    80005f4c:	ffffc097          	auipc	ra,0xffffc
    80005f50:	efc080e7          	jalr	-260(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80005f54:	00003517          	auipc	a0,0x3
    80005f58:	6cc50513          	addi	a0,a0,1740 # 80009620 <CONSOLE_STATUS+0x610>
    80005f5c:	ffffd097          	auipc	ra,0xffffd
    80005f60:	8d4080e7          	jalr	-1836(ra) # 80002830 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005f64:	00000613          	li	a2,0
    80005f68:	00000597          	auipc	a1,0x0
    80005f6c:	b0c58593          	addi	a1,a1,-1268 # 80005a74 <_Z11workerBodyBPv>
    80005f70:	fc840513          	addi	a0,s0,-56
    80005f74:	ffffc097          	auipc	ra,0xffffc
    80005f78:	ed4080e7          	jalr	-300(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80005f7c:	00003517          	auipc	a0,0x3
    80005f80:	6bc50513          	addi	a0,a0,1724 # 80009638 <CONSOLE_STATUS+0x628>
    80005f84:	ffffd097          	auipc	ra,0xffffd
    80005f88:	8ac080e7          	jalr	-1876(ra) # 80002830 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005f8c:	00000613          	li	a2,0
    80005f90:	00000597          	auipc	a1,0x0
    80005f94:	cd058593          	addi	a1,a1,-816 # 80005c60 <_Z11workerBodyCPv>
    80005f98:	fd040513          	addi	a0,s0,-48
    80005f9c:	ffffc097          	auipc	ra,0xffffc
    80005fa0:	eac080e7          	jalr	-340(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80005fa4:	00003517          	auipc	a0,0x3
    80005fa8:	6ac50513          	addi	a0,a0,1708 # 80009650 <CONSOLE_STATUS+0x640>
    80005fac:	ffffd097          	auipc	ra,0xffffd
    80005fb0:	884080e7          	jalr	-1916(ra) # 80002830 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005fb4:	00000613          	li	a2,0
    80005fb8:	00000597          	auipc	a1,0x0
    80005fbc:	e2858593          	addi	a1,a1,-472 # 80005de0 <_Z11workerBodyDPv>
    80005fc0:	fd840513          	addi	a0,s0,-40
    80005fc4:	ffffc097          	auipc	ra,0xffffc
    80005fc8:	e84080e7          	jalr	-380(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80005fcc:	00003517          	auipc	a0,0x3
    80005fd0:	69c50513          	addi	a0,a0,1692 # 80009668 <CONSOLE_STATUS+0x658>
    80005fd4:	ffffd097          	auipc	ra,0xffffd
    80005fd8:	85c080e7          	jalr	-1956(ra) # 80002830 <_Z11printStringPKc>
    80005fdc:	00c0006f          	j	80005fe8 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80005fe0:	ffffc097          	auipc	ra,0xffffc
    80005fe4:	f1c080e7          	jalr	-228(ra) # 80001efc <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005fe8:	00006797          	auipc	a5,0x6
    80005fec:	1307c783          	lbu	a5,304(a5) # 8000c118 <finishedA>
    80005ff0:	fe0788e3          	beqz	a5,80005fe0 <_Z18Threads_C_API_testv+0xb8>
    80005ff4:	00006797          	auipc	a5,0x6
    80005ff8:	1257c783          	lbu	a5,293(a5) # 8000c119 <finishedB>
    80005ffc:	fe0782e3          	beqz	a5,80005fe0 <_Z18Threads_C_API_testv+0xb8>
    80006000:	00006797          	auipc	a5,0x6
    80006004:	1287c783          	lbu	a5,296(a5) # 8000c128 <finishedC>
    80006008:	fc078ce3          	beqz	a5,80005fe0 <_Z18Threads_C_API_testv+0xb8>
    8000600c:	00006797          	auipc	a5,0x6
    80006010:	11d7c783          	lbu	a5,285(a5) # 8000c129 <finishedD>
    80006014:	fc0786e3          	beqz	a5,80005fe0 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80006018:	fc040493          	addi	s1,s0,-64
    8000601c:	0080006f          	j	80006024 <_Z18Threads_C_API_testv+0xfc>
    80006020:	00848493          	addi	s1,s1,8
    80006024:	fe040793          	addi	a5,s0,-32
    80006028:	00f48c63          	beq	s1,a5,80006040 <_Z18Threads_C_API_testv+0x118>
    8000602c:	0004b503          	ld	a0,0(s1)
    80006030:	fe0508e3          	beqz	a0,80006020 <_Z18Threads_C_API_testv+0xf8>
    80006034:	ffffc097          	auipc	ra,0xffffc
    80006038:	138080e7          	jalr	312(ra) # 8000216c <_ZN7_threaddlEPv>
    8000603c:	fe5ff06f          	j	80006020 <_Z18Threads_C_API_testv+0xf8>
}
    80006040:	03813083          	ld	ra,56(sp)
    80006044:	03013403          	ld	s0,48(sp)
    80006048:	02813483          	ld	s1,40(sp)
    8000604c:	04010113          	addi	sp,sp,64
    80006050:	00008067          	ret

0000000080006054 <_Z12testSleepingv>:

void testSleeping() {
    80006054:	fc010113          	addi	sp,sp,-64
    80006058:	02113c23          	sd	ra,56(sp)
    8000605c:	02813823          	sd	s0,48(sp)
    80006060:	02913423          	sd	s1,40(sp)
    80006064:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80006068:	00a00793          	li	a5,10
    8000606c:	fcf43823          	sd	a5,-48(s0)
    80006070:	01400793          	li	a5,20
    80006074:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80006078:	00000493          	li	s1,0
    8000607c:	02c0006f          	j	800060a8 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80006080:	00349793          	slli	a5,s1,0x3
    80006084:	fd040613          	addi	a2,s0,-48
    80006088:	00f60633          	add	a2,a2,a5
    8000608c:	00000597          	auipc	a1,0x0
    80006090:	abc58593          	addi	a1,a1,-1348 # 80005b48 <_Z9sleepyRunPv>
    80006094:	fc040513          	addi	a0,s0,-64
    80006098:	00f50533          	add	a0,a0,a5
    8000609c:	ffffc097          	auipc	ra,0xffffc
    800060a0:	dac080e7          	jalr	-596(ra) # 80001e48 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800060a4:	0014849b          	addiw	s1,s1,1
    800060a8:	00100793          	li	a5,1
    800060ac:	fc97dae3          	bge	a5,s1,80006080 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800060b0:	00006797          	auipc	a5,0x6
    800060b4:	0707c783          	lbu	a5,112(a5) # 8000c120 <finished>
    800060b8:	fe078ce3          	beqz	a5,800060b0 <_Z12testSleepingv+0x5c>
    800060bc:	00006797          	auipc	a5,0x6
    800060c0:	0657c783          	lbu	a5,101(a5) # 8000c121 <finished+0x1>
    800060c4:	fe0786e3          	beqz	a5,800060b0 <_Z12testSleepingv+0x5c>
}
    800060c8:	03813083          	ld	ra,56(sp)
    800060cc:	03013403          	ld	s0,48(sp)
    800060d0:	02813483          	ld	s1,40(sp)
    800060d4:	04010113          	addi	sp,sp,64
    800060d8:	00008067          	ret

00000000800060dc <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    800060dc:	f8010113          	addi	sp,sp,-128
    800060e0:	06113c23          	sd	ra,120(sp)
    800060e4:	06813823          	sd	s0,112(sp)
    800060e8:	06913423          	sd	s1,104(sp)
    800060ec:	07213023          	sd	s2,96(sp)
    800060f0:	05313c23          	sd	s3,88(sp)
    800060f4:	05413823          	sd	s4,80(sp)
    800060f8:	05513423          	sd	s5,72(sp)
    800060fc:	05613023          	sd	s6,64(sp)
    80006100:	03713c23          	sd	s7,56(sp)
    80006104:	03813823          	sd	s8,48(sp)
    80006108:	03913423          	sd	s9,40(sp)
    8000610c:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    80006110:	00010b93          	mv	s7,sp
        printString("Unesite broj proizvodjaca?\n");
    80006114:	00003517          	auipc	a0,0x3
    80006118:	56c50513          	addi	a0,a0,1388 # 80009680 <CONSOLE_STATUS+0x670>
    8000611c:	ffffc097          	auipc	ra,0xffffc
    80006120:	714080e7          	jalr	1812(ra) # 80002830 <_Z11printStringPKc>
        getString(input, 30);
    80006124:	01e00593          	li	a1,30
    80006128:	f8040493          	addi	s1,s0,-128
    8000612c:	00048513          	mv	a0,s1
    80006130:	ffffc097          	auipc	ra,0xffffc
    80006134:	77c080e7          	jalr	1916(ra) # 800028ac <_Z9getStringPci>
        threadNum = stringToInt(input);
    80006138:	00048513          	mv	a0,s1
    8000613c:	ffffd097          	auipc	ra,0xffffd
    80006140:	83c080e7          	jalr	-1988(ra) # 80002978 <_Z11stringToIntPKc>
    80006144:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    80006148:	00003517          	auipc	a0,0x3
    8000614c:	55850513          	addi	a0,a0,1368 # 800096a0 <CONSOLE_STATUS+0x690>
    80006150:	ffffc097          	auipc	ra,0xffffc
    80006154:	6e0080e7          	jalr	1760(ra) # 80002830 <_Z11printStringPKc>
        getString(input, 30);
    80006158:	01e00593          	li	a1,30
    8000615c:	00048513          	mv	a0,s1
    80006160:	ffffc097          	auipc	ra,0xffffc
    80006164:	74c080e7          	jalr	1868(ra) # 800028ac <_Z9getStringPci>
        n = stringToInt(input);
    80006168:	00048513          	mv	a0,s1
    8000616c:	ffffd097          	auipc	ra,0xffffd
    80006170:	80c080e7          	jalr	-2036(ra) # 80002978 <_Z11stringToIntPKc>
    80006174:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80006178:	00003517          	auipc	a0,0x3
    8000617c:	54850513          	addi	a0,a0,1352 # 800096c0 <CONSOLE_STATUS+0x6b0>
    80006180:	ffffc097          	auipc	ra,0xffffc
    80006184:	6b0080e7          	jalr	1712(ra) # 80002830 <_Z11printStringPKc>
    80006188:	00000613          	li	a2,0
    8000618c:	00a00593          	li	a1,10
    80006190:	00090513          	mv	a0,s2
    80006194:	ffffd097          	auipc	ra,0xffffd
    80006198:	834080e7          	jalr	-1996(ra) # 800029c8 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000619c:	00003517          	auipc	a0,0x3
    800061a0:	53c50513          	addi	a0,a0,1340 # 800096d8 <CONSOLE_STATUS+0x6c8>
    800061a4:	ffffc097          	auipc	ra,0xffffc
    800061a8:	68c080e7          	jalr	1676(ra) # 80002830 <_Z11printStringPKc>
    800061ac:	00000613          	li	a2,0
    800061b0:	00a00593          	li	a1,10
    800061b4:	00048513          	mv	a0,s1
    800061b8:	ffffd097          	auipc	ra,0xffffd
    800061bc:	810080e7          	jalr	-2032(ra) # 800029c8 <_Z8printIntiii>
        printString(".\n");
    800061c0:	00003517          	auipc	a0,0x3
    800061c4:	1f850513          	addi	a0,a0,504 # 800093b8 <CONSOLE_STATUS+0x3a8>
    800061c8:	ffffc097          	auipc	ra,0xffffc
    800061cc:	668080e7          	jalr	1640(ra) # 80002830 <_Z11printStringPKc>
        if(threadNum > n) {
    800061d0:	0324c663          	blt	s1,s2,800061fc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    800061d4:	03205e63          	blez	s2,80006210 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    800061d8:	03800513          	li	a0,56
    800061dc:	ffffd097          	auipc	ra,0xffffd
    800061e0:	4a4080e7          	jalr	1188(ra) # 80003680 <_Znwm>
    800061e4:	00050a93          	mv	s5,a0
    800061e8:	04050063          	beqz	a0,80006228 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
    800061ec:	00048593          	mv	a1,s1
    800061f0:	fffff097          	auipc	ra,0xfffff
    800061f4:	3b0080e7          	jalr	944(ra) # 800055a0 <_ZN9BufferCPPC1Ei>
    800061f8:	0300006f          	j	80006228 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800061fc:	00003517          	auipc	a0,0x3
    80006200:	4f450513          	addi	a0,a0,1268 # 800096f0 <CONSOLE_STATUS+0x6e0>
    80006204:	ffffc097          	auipc	ra,0xffffc
    80006208:	62c080e7          	jalr	1580(ra) # 80002830 <_Z11printStringPKc>
            return;
    8000620c:	0140006f          	j	80006220 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80006210:	00003517          	auipc	a0,0x3
    80006214:	52050513          	addi	a0,a0,1312 # 80009730 <CONSOLE_STATUS+0x720>
    80006218:	ffffc097          	auipc	ra,0xffffc
    8000621c:	618080e7          	jalr	1560(ra) # 80002830 <_Z11printStringPKc>
            return;
    80006220:	000b8113          	mv	sp,s7
    80006224:	24c0006f          	j	80006470 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    80006228:	01000513          	li	a0,16
    8000622c:	ffffd097          	auipc	ra,0xffffd
    80006230:	454080e7          	jalr	1108(ra) # 80003680 <_Znwm>
    80006234:	00050493          	mv	s1,a0
    80006238:	00050863          	beqz	a0,80006248 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000623c:	00000593          	li	a1,0
    80006240:	ffffd097          	auipc	ra,0xffffd
    80006244:	538080e7          	jalr	1336(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    80006248:	00006717          	auipc	a4,0x6
    8000624c:	ed070713          	addi	a4,a4,-304 # 8000c118 <finishedA>
    80006250:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    80006254:	00391793          	slli	a5,s2,0x3
    80006258:	00f78793          	addi	a5,a5,15
    8000625c:	ff07f793          	andi	a5,a5,-16
    80006260:	40f10133          	sub	sp,sp,a5
    80006264:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80006268:	0019069b          	addiw	a3,s2,1
    8000626c:	00169793          	slli	a5,a3,0x1
    80006270:	00d787b3          	add	a5,a5,a3
    80006274:	00379793          	slli	a5,a5,0x3
    80006278:	00f78793          	addi	a5,a5,15
    8000627c:	ff07f793          	andi	a5,a5,-16
    80006280:	40f10133          	sub	sp,sp,a5
    80006284:	00010993          	mv	s3,sp
        threadData[threadNum].id = threadNum;
    80006288:	00191793          	slli	a5,s2,0x1
    8000628c:	012787b3          	add	a5,a5,s2
    80006290:	00379793          	slli	a5,a5,0x3
    80006294:	00f987b3          	add	a5,s3,a5
    80006298:	0127a023          	sw	s2,0(a5)
        threadData[threadNum].buffer = buffer;
    8000629c:	0157b423          	sd	s5,8(a5)
        threadData[threadNum].sem = waitForAll;
    800062a0:	01873703          	ld	a4,24(a4)
    800062a4:	00e7b823          	sd	a4,16(a5)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800062a8:	01800513          	li	a0,24
    800062ac:	ffffd097          	auipc	ra,0xffffd
    800062b0:	3d4080e7          	jalr	980(ra) # 80003680 <_Znwm>
    800062b4:	00050b13          	mv	s6,a0
    800062b8:	02050663          	beqz	a0,800062e4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    800062bc:	00191493          	slli	s1,s2,0x1
    800062c0:	012484b3          	add	s1,s1,s2
    800062c4:	00349493          	slli	s1,s1,0x3
    800062c8:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    800062cc:	ffffd097          	auipc	ra,0xffffd
    800062d0:	590080e7          	jalr	1424(ra) # 8000385c <_ZN6ThreadC1Ev>
    800062d4:	00006797          	auipc	a5,0x6
    800062d8:	adc78793          	addi	a5,a5,-1316 # 8000bdb0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800062dc:	00fb3023          	sd	a5,0(s6)
    800062e0:	009b3823          	sd	s1,16(s6)
        consumer->start();
    800062e4:	000b0513          	mv	a0,s6
    800062e8:	ffffd097          	auipc	ra,0xffffd
    800062ec:	664080e7          	jalr	1636(ra) # 8000394c <_ZN6Thread5startEv>
        threadData[0].id = 0;
    800062f0:	0009a023          	sw	zero,0(s3)
        threadData[0].buffer = buffer;
    800062f4:	0159b423          	sd	s5,8(s3)
        threadData[0].sem = waitForAll;
    800062f8:	00006797          	auipc	a5,0x6
    800062fc:	e387b783          	ld	a5,-456(a5) # 8000c130 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006300:	00f9b823          	sd	a5,16(s3)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006304:	01800513          	li	a0,24
    80006308:	ffffd097          	auipc	ra,0xffffd
    8000630c:	378080e7          	jalr	888(ra) # 80003680 <_Znwm>
    80006310:	00050493          	mv	s1,a0
    80006314:	00050e63          	beqz	a0,80006330 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80006318:	ffffd097          	auipc	ra,0xffffd
    8000631c:	544080e7          	jalr	1348(ra) # 8000385c <_ZN6ThreadC1Ev>
    80006320:	00006797          	auipc	a5,0x6
    80006324:	a4078793          	addi	a5,a5,-1472 # 8000bd60 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006328:	00f4b023          	sd	a5,0(s1)
    8000632c:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006330:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80006334:	00048513          	mv	a0,s1
    80006338:	ffffd097          	auipc	ra,0xffffd
    8000633c:	614080e7          	jalr	1556(ra) # 8000394c <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80006340:	00100493          	li	s1,1
    80006344:	0300006f          	j	80006374 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x298>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80006348:	00006797          	auipc	a5,0x6
    8000634c:	a4078793          	addi	a5,a5,-1472 # 8000bd88 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006350:	00fc3023          	sd	a5,0(s8)
    80006354:	019c3823          	sd	s9,16(s8)
            producers[i] = new Producer(&threadData[i]);
    80006358:	00349793          	slli	a5,s1,0x3
    8000635c:	00fa07b3          	add	a5,s4,a5
    80006360:	0187b023          	sd	s8,0(a5)
            producers[i]->start();
    80006364:	000c0513          	mv	a0,s8
    80006368:	ffffd097          	auipc	ra,0xffffd
    8000636c:	5e4080e7          	jalr	1508(ra) # 8000394c <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80006370:	0014849b          	addiw	s1,s1,1
    80006374:	0524dc63          	bge	s1,s2,800063cc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2f0>
            threadData[i].id = i;
    80006378:	00149793          	slli	a5,s1,0x1
    8000637c:	009787b3          	add	a5,a5,s1
    80006380:	00379793          	slli	a5,a5,0x3
    80006384:	00f987b3          	add	a5,s3,a5
    80006388:	0097a023          	sw	s1,0(a5)
            threadData[i].buffer = buffer;
    8000638c:	0157b423          	sd	s5,8(a5)
            threadData[i].sem = waitForAll;
    80006390:	00006717          	auipc	a4,0x6
    80006394:	da073703          	ld	a4,-608(a4) # 8000c130 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006398:	00e7b823          	sd	a4,16(a5)
            producers[i] = new Producer(&threadData[i]);
    8000639c:	01800513          	li	a0,24
    800063a0:	ffffd097          	auipc	ra,0xffffd
    800063a4:	2e0080e7          	jalr	736(ra) # 80003680 <_Znwm>
    800063a8:	00050c13          	mv	s8,a0
    800063ac:	fa0506e3          	beqz	a0,80006358 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    800063b0:	00149c93          	slli	s9,s1,0x1
    800063b4:	009c8cb3          	add	s9,s9,s1
    800063b8:	003c9c93          	slli	s9,s9,0x3
    800063bc:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800063c0:	ffffd097          	auipc	ra,0xffffd
    800063c4:	49c080e7          	jalr	1180(ra) # 8000385c <_ZN6ThreadC1Ev>
    800063c8:	f81ff06f          	j	80006348 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    800063cc:	ffffd097          	auipc	ra,0xffffd
    800063d0:	558080e7          	jalr	1368(ra) # 80003924 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    800063d4:	00000493          	li	s1,0
    800063d8:	00994e63          	blt	s2,s1,800063f4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    800063dc:	00006517          	auipc	a0,0x6
    800063e0:	d5453503          	ld	a0,-684(a0) # 8000c130 <_ZN19ConsumerProducerCPP10waitForAllE>
    800063e4:	ffffd097          	auipc	ra,0xffffd
    800063e8:	3cc080e7          	jalr	972(ra) # 800037b0 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    800063ec:	0014849b          	addiw	s1,s1,1
    800063f0:	fe9ff06f          	j	800063d8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
        delete waitForAll;
    800063f4:	00006517          	auipc	a0,0x6
    800063f8:	d3c53503          	ld	a0,-708(a0) # 8000c130 <_ZN19ConsumerProducerCPP10waitForAllE>
    800063fc:	00050863          	beqz	a0,8000640c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x330>
    80006400:	00053783          	ld	a5,0(a0)
    80006404:	0087b783          	ld	a5,8(a5)
    80006408:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    8000640c:	00000493          	li	s1,0
    80006410:	0080006f          	j	80006418 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x33c>
        for (int i = 0; i < threadNum; i++) {
    80006414:	0014849b          	addiw	s1,s1,1
    80006418:	0324d263          	bge	s1,s2,8000643c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
            delete producers[i];
    8000641c:	00349793          	slli	a5,s1,0x3
    80006420:	00fa07b3          	add	a5,s4,a5
    80006424:	0007b503          	ld	a0,0(a5)
    80006428:	fe0506e3          	beqz	a0,80006414 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
    8000642c:	00053783          	ld	a5,0(a0)
    80006430:	0087b783          	ld	a5,8(a5)
    80006434:	000780e7          	jalr	a5
    80006438:	fddff06f          	j	80006414 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
        delete consumer;
    8000643c:	000b0a63          	beqz	s6,80006450 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x374>
    80006440:	000b3783          	ld	a5,0(s6)
    80006444:	0087b783          	ld	a5,8(a5)
    80006448:	000b0513          	mv	a0,s6
    8000644c:	000780e7          	jalr	a5
        delete buffer;
    80006450:	000a8e63          	beqz	s5,8000646c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x390>
    80006454:	000a8513          	mv	a0,s5
    80006458:	fffff097          	auipc	ra,0xfffff
    8000645c:	450080e7          	jalr	1104(ra) # 800058a8 <_ZN9BufferCPPD1Ev>
    80006460:	000a8513          	mv	a0,s5
    80006464:	ffffd097          	auipc	ra,0xffffd
    80006468:	26c080e7          	jalr	620(ra) # 800036d0 <_ZdlPv>
    8000646c:	000b8113          	mv	sp,s7
    }
    80006470:	f8040113          	addi	sp,s0,-128
    80006474:	07813083          	ld	ra,120(sp)
    80006478:	07013403          	ld	s0,112(sp)
    8000647c:	06813483          	ld	s1,104(sp)
    80006480:	06013903          	ld	s2,96(sp)
    80006484:	05813983          	ld	s3,88(sp)
    80006488:	05013a03          	ld	s4,80(sp)
    8000648c:	04813a83          	ld	s5,72(sp)
    80006490:	04013b03          	ld	s6,64(sp)
    80006494:	03813b83          	ld	s7,56(sp)
    80006498:	03013c03          	ld	s8,48(sp)
    8000649c:	02813c83          	ld	s9,40(sp)
    800064a0:	08010113          	addi	sp,sp,128
    800064a4:	00008067          	ret
    800064a8:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    800064ac:	000a8513          	mv	a0,s5
    800064b0:	ffffd097          	auipc	ra,0xffffd
    800064b4:	220080e7          	jalr	544(ra) # 800036d0 <_ZdlPv>
    800064b8:	00048513          	mv	a0,s1
    800064bc:	00007097          	auipc	ra,0x7
    800064c0:	d4c080e7          	jalr	-692(ra) # 8000d208 <_Unwind_Resume>
    800064c4:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    800064c8:	00048513          	mv	a0,s1
    800064cc:	ffffd097          	auipc	ra,0xffffd
    800064d0:	204080e7          	jalr	516(ra) # 800036d0 <_ZdlPv>
    800064d4:	00090513          	mv	a0,s2
    800064d8:	00007097          	auipc	ra,0x7
    800064dc:	d30080e7          	jalr	-720(ra) # 8000d208 <_Unwind_Resume>
    800064e0:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800064e4:	000b0513          	mv	a0,s6
    800064e8:	ffffd097          	auipc	ra,0xffffd
    800064ec:	1e8080e7          	jalr	488(ra) # 800036d0 <_ZdlPv>
    800064f0:	00048513          	mv	a0,s1
    800064f4:	00007097          	auipc	ra,0x7
    800064f8:	d14080e7          	jalr	-748(ra) # 8000d208 <_Unwind_Resume>
    800064fc:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006500:	00048513          	mv	a0,s1
    80006504:	ffffd097          	auipc	ra,0xffffd
    80006508:	1cc080e7          	jalr	460(ra) # 800036d0 <_ZdlPv>
    8000650c:	00090513          	mv	a0,s2
    80006510:	00007097          	auipc	ra,0x7
    80006514:	cf8080e7          	jalr	-776(ra) # 8000d208 <_Unwind_Resume>
    80006518:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000651c:	000c0513          	mv	a0,s8
    80006520:	ffffd097          	auipc	ra,0xffffd
    80006524:	1b0080e7          	jalr	432(ra) # 800036d0 <_ZdlPv>
    80006528:	00048513          	mv	a0,s1
    8000652c:	00007097          	auipc	ra,0x7
    80006530:	cdc080e7          	jalr	-804(ra) # 8000d208 <_Unwind_Resume>

0000000080006534 <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    80006534:	ff010113          	addi	sp,sp,-16
    80006538:	00113423          	sd	ra,8(sp)
    8000653c:	00813023          	sd	s0,0(sp)
    80006540:	01010413          	addi	s0,sp,16
    Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
    80006544:	00000097          	auipc	ra,0x0
    80006548:	9e4080e7          	jalr	-1564(ra) # 80005f28 <_Z18Threads_C_API_testv>
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    8000654c:	00813083          	ld	ra,8(sp)
    80006550:	00013403          	ld	s0,0(sp)
    80006554:	01010113          	addi	sp,sp,16
    80006558:	00008067          	ret

000000008000655c <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    8000655c:	fd010113          	addi	sp,sp,-48
    80006560:	02113423          	sd	ra,40(sp)
    80006564:	02813023          	sd	s0,32(sp)
    80006568:	00913c23          	sd	s1,24(sp)
    8000656c:	01213823          	sd	s2,16(sp)
    80006570:	01313423          	sd	s3,8(sp)
    80006574:	03010413          	addi	s0,sp,48
    80006578:	00050913          	mv	s2,a0
            int i = 0;
    8000657c:	00000993          	li	s3,0
    80006580:	0100006f          	j	80006590 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80006584:	00a00513          	li	a0,10
    80006588:	ffffd097          	auipc	ra,0xffffd
    8000658c:	48c080e7          	jalr	1164(ra) # 80003a14 <_ZN7Console4putcEc>
            while (!threadEnd) {
    80006590:	00006797          	auipc	a5,0x6
    80006594:	b947a783          	lw	a5,-1132(a5) # 8000c124 <_ZN19ConsumerProducerCPP9threadEndE>
    80006598:	04079a63          	bnez	a5,800065ec <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    8000659c:	01093783          	ld	a5,16(s2)
    800065a0:	0087b503          	ld	a0,8(a5)
    800065a4:	fffff097          	auipc	ra,0xfffff
    800065a8:	1f0080e7          	jalr	496(ra) # 80005794 <_ZN9BufferCPP3getEv>
                i++;
    800065ac:	0019849b          	addiw	s1,s3,1
    800065b0:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    800065b4:	0ff57513          	andi	a0,a0,255
    800065b8:	ffffd097          	auipc	ra,0xffffd
    800065bc:	45c080e7          	jalr	1116(ra) # 80003a14 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    800065c0:	05000793          	li	a5,80
    800065c4:	02f4e4bb          	remw	s1,s1,a5
    800065c8:	fc0494e3          	bnez	s1,80006590 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    800065cc:	fb9ff06f          	j	80006584 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    800065d0:	01093783          	ld	a5,16(s2)
    800065d4:	0087b503          	ld	a0,8(a5)
    800065d8:	fffff097          	auipc	ra,0xfffff
    800065dc:	1bc080e7          	jalr	444(ra) # 80005794 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    800065e0:	0ff57513          	andi	a0,a0,255
    800065e4:	ffffd097          	auipc	ra,0xffffd
    800065e8:	430080e7          	jalr	1072(ra) # 80003a14 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    800065ec:	01093783          	ld	a5,16(s2)
    800065f0:	0087b503          	ld	a0,8(a5)
    800065f4:	fffff097          	auipc	ra,0xfffff
    800065f8:	22c080e7          	jalr	556(ra) # 80005820 <_ZN9BufferCPP6getCntEv>
    800065fc:	fca04ae3          	bgtz	a0,800065d0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80006600:	01093783          	ld	a5,16(s2)
    80006604:	0107b503          	ld	a0,16(a5)
    80006608:	ffffd097          	auipc	ra,0xffffd
    8000660c:	1d4080e7          	jalr	468(ra) # 800037dc <_ZN9Semaphore6signalEv>
        }
    80006610:	02813083          	ld	ra,40(sp)
    80006614:	02013403          	ld	s0,32(sp)
    80006618:	01813483          	ld	s1,24(sp)
    8000661c:	01013903          	ld	s2,16(sp)
    80006620:	00813983          	ld	s3,8(sp)
    80006624:	03010113          	addi	sp,sp,48
    80006628:	00008067          	ret

000000008000662c <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    8000662c:	ff010113          	addi	sp,sp,-16
    80006630:	00113423          	sd	ra,8(sp)
    80006634:	00813023          	sd	s0,0(sp)
    80006638:	01010413          	addi	s0,sp,16
    8000663c:	00005797          	auipc	a5,0x5
    80006640:	77478793          	addi	a5,a5,1908 # 8000bdb0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006644:	00f53023          	sd	a5,0(a0)
    80006648:	ffffd097          	auipc	ra,0xffffd
    8000664c:	ff8080e7          	jalr	-8(ra) # 80003640 <_ZN6ThreadD1Ev>
    80006650:	00813083          	ld	ra,8(sp)
    80006654:	00013403          	ld	s0,0(sp)
    80006658:	01010113          	addi	sp,sp,16
    8000665c:	00008067          	ret

0000000080006660 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80006660:	fe010113          	addi	sp,sp,-32
    80006664:	00113c23          	sd	ra,24(sp)
    80006668:	00813823          	sd	s0,16(sp)
    8000666c:	00913423          	sd	s1,8(sp)
    80006670:	02010413          	addi	s0,sp,32
    80006674:	00050493          	mv	s1,a0
    80006678:	00005797          	auipc	a5,0x5
    8000667c:	73878793          	addi	a5,a5,1848 # 8000bdb0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006680:	00f53023          	sd	a5,0(a0)
    80006684:	ffffd097          	auipc	ra,0xffffd
    80006688:	fbc080e7          	jalr	-68(ra) # 80003640 <_ZN6ThreadD1Ev>
    8000668c:	00048513          	mv	a0,s1
    80006690:	ffffd097          	auipc	ra,0xffffd
    80006694:	040080e7          	jalr	64(ra) # 800036d0 <_ZdlPv>
    80006698:	01813083          	ld	ra,24(sp)
    8000669c:	01013403          	ld	s0,16(sp)
    800066a0:	00813483          	ld	s1,8(sp)
    800066a4:	02010113          	addi	sp,sp,32
    800066a8:	00008067          	ret

00000000800066ac <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    800066ac:	ff010113          	addi	sp,sp,-16
    800066b0:	00113423          	sd	ra,8(sp)
    800066b4:	00813023          	sd	s0,0(sp)
    800066b8:	01010413          	addi	s0,sp,16
    800066bc:	00005797          	auipc	a5,0x5
    800066c0:	6a478793          	addi	a5,a5,1700 # 8000bd60 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800066c4:	00f53023          	sd	a5,0(a0)
    800066c8:	ffffd097          	auipc	ra,0xffffd
    800066cc:	f78080e7          	jalr	-136(ra) # 80003640 <_ZN6ThreadD1Ev>
    800066d0:	00813083          	ld	ra,8(sp)
    800066d4:	00013403          	ld	s0,0(sp)
    800066d8:	01010113          	addi	sp,sp,16
    800066dc:	00008067          	ret

00000000800066e0 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    800066e0:	fe010113          	addi	sp,sp,-32
    800066e4:	00113c23          	sd	ra,24(sp)
    800066e8:	00813823          	sd	s0,16(sp)
    800066ec:	00913423          	sd	s1,8(sp)
    800066f0:	02010413          	addi	s0,sp,32
    800066f4:	00050493          	mv	s1,a0
    800066f8:	00005797          	auipc	a5,0x5
    800066fc:	66878793          	addi	a5,a5,1640 # 8000bd60 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006700:	00f53023          	sd	a5,0(a0)
    80006704:	ffffd097          	auipc	ra,0xffffd
    80006708:	f3c080e7          	jalr	-196(ra) # 80003640 <_ZN6ThreadD1Ev>
    8000670c:	00048513          	mv	a0,s1
    80006710:	ffffd097          	auipc	ra,0xffffd
    80006714:	fc0080e7          	jalr	-64(ra) # 800036d0 <_ZdlPv>
    80006718:	01813083          	ld	ra,24(sp)
    8000671c:	01013403          	ld	s0,16(sp)
    80006720:	00813483          	ld	s1,8(sp)
    80006724:	02010113          	addi	sp,sp,32
    80006728:	00008067          	ret

000000008000672c <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    8000672c:	ff010113          	addi	sp,sp,-16
    80006730:	00113423          	sd	ra,8(sp)
    80006734:	00813023          	sd	s0,0(sp)
    80006738:	01010413          	addi	s0,sp,16
    8000673c:	00005797          	auipc	a5,0x5
    80006740:	64c78793          	addi	a5,a5,1612 # 8000bd88 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006744:	00f53023          	sd	a5,0(a0)
    80006748:	ffffd097          	auipc	ra,0xffffd
    8000674c:	ef8080e7          	jalr	-264(ra) # 80003640 <_ZN6ThreadD1Ev>
    80006750:	00813083          	ld	ra,8(sp)
    80006754:	00013403          	ld	s0,0(sp)
    80006758:	01010113          	addi	sp,sp,16
    8000675c:	00008067          	ret

0000000080006760 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80006760:	fe010113          	addi	sp,sp,-32
    80006764:	00113c23          	sd	ra,24(sp)
    80006768:	00813823          	sd	s0,16(sp)
    8000676c:	00913423          	sd	s1,8(sp)
    80006770:	02010413          	addi	s0,sp,32
    80006774:	00050493          	mv	s1,a0
    80006778:	00005797          	auipc	a5,0x5
    8000677c:	61078793          	addi	a5,a5,1552 # 8000bd88 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006780:	00f53023          	sd	a5,0(a0)
    80006784:	ffffd097          	auipc	ra,0xffffd
    80006788:	ebc080e7          	jalr	-324(ra) # 80003640 <_ZN6ThreadD1Ev>
    8000678c:	00048513          	mv	a0,s1
    80006790:	ffffd097          	auipc	ra,0xffffd
    80006794:	f40080e7          	jalr	-192(ra) # 800036d0 <_ZdlPv>
    80006798:	01813083          	ld	ra,24(sp)
    8000679c:	01013403          	ld	s0,16(sp)
    800067a0:	00813483          	ld	s1,8(sp)
    800067a4:	02010113          	addi	sp,sp,32
    800067a8:	00008067          	ret

00000000800067ac <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    800067ac:	fe010113          	addi	sp,sp,-32
    800067b0:	00113c23          	sd	ra,24(sp)
    800067b4:	00813823          	sd	s0,16(sp)
    800067b8:	00913423          	sd	s1,8(sp)
    800067bc:	02010413          	addi	s0,sp,32
    800067c0:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    800067c4:	ffffc097          	auipc	ra,0xffffc
    800067c8:	90c080e7          	jalr	-1780(ra) # 800020d0 <_Z4getcv>
    800067cc:	0005059b          	sext.w	a1,a0
    800067d0:	01b00793          	li	a5,27
    800067d4:	00f58c63          	beq	a1,a5,800067ec <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    800067d8:	0104b783          	ld	a5,16(s1)
    800067dc:	0087b503          	ld	a0,8(a5)
    800067e0:	fffff097          	auipc	ra,0xfffff
    800067e4:	f24080e7          	jalr	-220(ra) # 80005704 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    800067e8:	fddff06f          	j	800067c4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    800067ec:	00100793          	li	a5,1
    800067f0:	00006717          	auipc	a4,0x6
    800067f4:	92f72a23          	sw	a5,-1740(a4) # 8000c124 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    800067f8:	0104b783          	ld	a5,16(s1)
    800067fc:	02100593          	li	a1,33
    80006800:	0087b503          	ld	a0,8(a5)
    80006804:	fffff097          	auipc	ra,0xfffff
    80006808:	f00080e7          	jalr	-256(ra) # 80005704 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    8000680c:	0104b783          	ld	a5,16(s1)
    80006810:	0107b503          	ld	a0,16(a5)
    80006814:	ffffd097          	auipc	ra,0xffffd
    80006818:	fc8080e7          	jalr	-56(ra) # 800037dc <_ZN9Semaphore6signalEv>
        }
    8000681c:	01813083          	ld	ra,24(sp)
    80006820:	01013403          	ld	s0,16(sp)
    80006824:	00813483          	ld	s1,8(sp)
    80006828:	02010113          	addi	sp,sp,32
    8000682c:	00008067          	ret

0000000080006830 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006830:	fe010113          	addi	sp,sp,-32
    80006834:	00113c23          	sd	ra,24(sp)
    80006838:	00813823          	sd	s0,16(sp)
    8000683c:	00913423          	sd	s1,8(sp)
    80006840:	01213023          	sd	s2,0(sp)
    80006844:	02010413          	addi	s0,sp,32
    80006848:	00050493          	mv	s1,a0
            int i = 0;
    8000684c:	00000913          	li	s2,0
            while (!threadEnd) {
    80006850:	00006797          	auipc	a5,0x6
    80006854:	8d47a783          	lw	a5,-1836(a5) # 8000c124 <_ZN19ConsumerProducerCPP9threadEndE>
    80006858:	04079263          	bnez	a5,8000689c <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8000685c:	0104b783          	ld	a5,16(s1)
    80006860:	0007a583          	lw	a1,0(a5)
    80006864:	0305859b          	addiw	a1,a1,48
    80006868:	0087b503          	ld	a0,8(a5)
    8000686c:	fffff097          	auipc	ra,0xfffff
    80006870:	e98080e7          	jalr	-360(ra) # 80005704 <_ZN9BufferCPP3putEi>
                i++;
    80006874:	0019071b          	addiw	a4,s2,1
    80006878:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    8000687c:	0104b783          	ld	a5,16(s1)
    80006880:	0007a783          	lw	a5,0(a5)
    80006884:	00e787bb          	addw	a5,a5,a4
    80006888:	00500513          	li	a0,5
    8000688c:	02a7e53b          	remw	a0,a5,a0
    80006890:	ffffd097          	auipc	ra,0xffffd
    80006894:	02c080e7          	jalr	44(ra) # 800038bc <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80006898:	fb9ff06f          	j	80006850 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    8000689c:	0104b783          	ld	a5,16(s1)
    800068a0:	0107b503          	ld	a0,16(a5)
    800068a4:	ffffd097          	auipc	ra,0xffffd
    800068a8:	f38080e7          	jalr	-200(ra) # 800037dc <_ZN9Semaphore6signalEv>
        }
    800068ac:	01813083          	ld	ra,24(sp)
    800068b0:	01013403          	ld	s0,16(sp)
    800068b4:	00813483          	ld	s1,8(sp)
    800068b8:	00013903          	ld	s2,0(sp)
    800068bc:	02010113          	addi	sp,sp,32
    800068c0:	00008067          	ret

00000000800068c4 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800068c4:	fe010113          	addi	sp,sp,-32
    800068c8:	00113c23          	sd	ra,24(sp)
    800068cc:	00813823          	sd	s0,16(sp)
    800068d0:	00913423          	sd	s1,8(sp)
    800068d4:	01213023          	sd	s2,0(sp)
    800068d8:	02010413          	addi	s0,sp,32
    800068dc:	00050493          	mv	s1,a0
    800068e0:	00058913          	mv	s2,a1
    800068e4:	0015879b          	addiw	a5,a1,1
    800068e8:	0007851b          	sext.w	a0,a5
    800068ec:	00f4a023          	sw	a5,0(s1)
    800068f0:	0004a823          	sw	zero,16(s1)
    800068f4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800068f8:	00251513          	slli	a0,a0,0x2
    800068fc:	ffffb097          	auipc	ra,0xffffb
    80006900:	4f0080e7          	jalr	1264(ra) # 80001dec <_Z9mem_allocm>
    80006904:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006908:	00000593          	li	a1,0
    8000690c:	02048513          	addi	a0,s1,32
    80006910:	ffffb097          	auipc	ra,0xffffb
    80006914:	6d8080e7          	jalr	1752(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80006918:	00090593          	mv	a1,s2
    8000691c:	01848513          	addi	a0,s1,24
    80006920:	ffffb097          	auipc	ra,0xffffb
    80006924:	6c8080e7          	jalr	1736(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80006928:	00100593          	li	a1,1
    8000692c:	02848513          	addi	a0,s1,40
    80006930:	ffffb097          	auipc	ra,0xffffb
    80006934:	6b8080e7          	jalr	1720(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80006938:	00100593          	li	a1,1
    8000693c:	03048513          	addi	a0,s1,48
    80006940:	ffffb097          	auipc	ra,0xffffb
    80006944:	6a8080e7          	jalr	1704(ra) # 80001fe8 <_Z8sem_openPP10_semaphorej>
}
    80006948:	01813083          	ld	ra,24(sp)
    8000694c:	01013403          	ld	s0,16(sp)
    80006950:	00813483          	ld	s1,8(sp)
    80006954:	00013903          	ld	s2,0(sp)
    80006958:	02010113          	addi	sp,sp,32
    8000695c:	00008067          	ret

0000000080006960 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80006960:	fe010113          	addi	sp,sp,-32
    80006964:	00113c23          	sd	ra,24(sp)
    80006968:	00813823          	sd	s0,16(sp)
    8000696c:	00913423          	sd	s1,8(sp)
    80006970:	01213023          	sd	s2,0(sp)
    80006974:	02010413          	addi	s0,sp,32
    80006978:	00050493          	mv	s1,a0
    8000697c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80006980:	01853503          	ld	a0,24(a0)
    80006984:	ffffb097          	auipc	ra,0xffffb
    80006988:	6c8080e7          	jalr	1736(ra) # 8000204c <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    8000698c:	0304b503          	ld	a0,48(s1)
    80006990:	ffffb097          	auipc	ra,0xffffb
    80006994:	6bc080e7          	jalr	1724(ra) # 8000204c <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80006998:	0084b783          	ld	a5,8(s1)
    8000699c:	0144a703          	lw	a4,20(s1)
    800069a0:	00271713          	slli	a4,a4,0x2
    800069a4:	00e787b3          	add	a5,a5,a4
    800069a8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800069ac:	0144a783          	lw	a5,20(s1)
    800069b0:	0017879b          	addiw	a5,a5,1
    800069b4:	0004a703          	lw	a4,0(s1)
    800069b8:	02e7e7bb          	remw	a5,a5,a4
    800069bc:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800069c0:	0304b503          	ld	a0,48(s1)
    800069c4:	ffffb097          	auipc	ra,0xffffb
    800069c8:	6b4080e7          	jalr	1716(ra) # 80002078 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    800069cc:	0204b503          	ld	a0,32(s1)
    800069d0:	ffffb097          	auipc	ra,0xffffb
    800069d4:	6a8080e7          	jalr	1704(ra) # 80002078 <_Z10sem_signalP10_semaphore>

}
    800069d8:	01813083          	ld	ra,24(sp)
    800069dc:	01013403          	ld	s0,16(sp)
    800069e0:	00813483          	ld	s1,8(sp)
    800069e4:	00013903          	ld	s2,0(sp)
    800069e8:	02010113          	addi	sp,sp,32
    800069ec:	00008067          	ret

00000000800069f0 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800069f0:	fe010113          	addi	sp,sp,-32
    800069f4:	00113c23          	sd	ra,24(sp)
    800069f8:	00813823          	sd	s0,16(sp)
    800069fc:	00913423          	sd	s1,8(sp)
    80006a00:	01213023          	sd	s2,0(sp)
    80006a04:	02010413          	addi	s0,sp,32
    80006a08:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006a0c:	02053503          	ld	a0,32(a0)
    80006a10:	ffffb097          	auipc	ra,0xffffb
    80006a14:	63c080e7          	jalr	1596(ra) # 8000204c <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80006a18:	0284b503          	ld	a0,40(s1)
    80006a1c:	ffffb097          	auipc	ra,0xffffb
    80006a20:	630080e7          	jalr	1584(ra) # 8000204c <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80006a24:	0084b703          	ld	a4,8(s1)
    80006a28:	0104a783          	lw	a5,16(s1)
    80006a2c:	00279693          	slli	a3,a5,0x2
    80006a30:	00d70733          	add	a4,a4,a3
    80006a34:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006a38:	0017879b          	addiw	a5,a5,1
    80006a3c:	0004a703          	lw	a4,0(s1)
    80006a40:	02e7e7bb          	remw	a5,a5,a4
    80006a44:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006a48:	0284b503          	ld	a0,40(s1)
    80006a4c:	ffffb097          	auipc	ra,0xffffb
    80006a50:	62c080e7          	jalr	1580(ra) # 80002078 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80006a54:	0184b503          	ld	a0,24(s1)
    80006a58:	ffffb097          	auipc	ra,0xffffb
    80006a5c:	620080e7          	jalr	1568(ra) # 80002078 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006a60:	00090513          	mv	a0,s2
    80006a64:	01813083          	ld	ra,24(sp)
    80006a68:	01013403          	ld	s0,16(sp)
    80006a6c:	00813483          	ld	s1,8(sp)
    80006a70:	00013903          	ld	s2,0(sp)
    80006a74:	02010113          	addi	sp,sp,32
    80006a78:	00008067          	ret

0000000080006a7c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80006a7c:	fe010113          	addi	sp,sp,-32
    80006a80:	00113c23          	sd	ra,24(sp)
    80006a84:	00813823          	sd	s0,16(sp)
    80006a88:	00913423          	sd	s1,8(sp)
    80006a8c:	01213023          	sd	s2,0(sp)
    80006a90:	02010413          	addi	s0,sp,32
    80006a94:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80006a98:	02853503          	ld	a0,40(a0)
    80006a9c:	ffffb097          	auipc	ra,0xffffb
    80006aa0:	5b0080e7          	jalr	1456(ra) # 8000204c <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80006aa4:	0304b503          	ld	a0,48(s1)
    80006aa8:	ffffb097          	auipc	ra,0xffffb
    80006aac:	5a4080e7          	jalr	1444(ra) # 8000204c <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80006ab0:	0144a783          	lw	a5,20(s1)
    80006ab4:	0104a903          	lw	s2,16(s1)
    80006ab8:	0327ce63          	blt	a5,s2,80006af4 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006abc:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006ac0:	0304b503          	ld	a0,48(s1)
    80006ac4:	ffffb097          	auipc	ra,0xffffb
    80006ac8:	5b4080e7          	jalr	1460(ra) # 80002078 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80006acc:	0284b503          	ld	a0,40(s1)
    80006ad0:	ffffb097          	auipc	ra,0xffffb
    80006ad4:	5a8080e7          	jalr	1448(ra) # 80002078 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006ad8:	00090513          	mv	a0,s2
    80006adc:	01813083          	ld	ra,24(sp)
    80006ae0:	01013403          	ld	s0,16(sp)
    80006ae4:	00813483          	ld	s1,8(sp)
    80006ae8:	00013903          	ld	s2,0(sp)
    80006aec:	02010113          	addi	sp,sp,32
    80006af0:	00008067          	ret
        ret = cap - head + tail;
    80006af4:	0004a703          	lw	a4,0(s1)
    80006af8:	4127093b          	subw	s2,a4,s2
    80006afc:	00f9093b          	addw	s2,s2,a5
    80006b00:	fc1ff06f          	j	80006ac0 <_ZN6Buffer6getCntEv+0x44>

0000000080006b04 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006b04:	fe010113          	addi	sp,sp,-32
    80006b08:	00113c23          	sd	ra,24(sp)
    80006b0c:	00813823          	sd	s0,16(sp)
    80006b10:	00913423          	sd	s1,8(sp)
    80006b14:	02010413          	addi	s0,sp,32
    80006b18:	00050493          	mv	s1,a0
    putc('\n');
    80006b1c:	00a00513          	li	a0,10
    80006b20:	ffffb097          	auipc	ra,0xffffb
    80006b24:	5d8080e7          	jalr	1496(ra) # 800020f8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006b28:	00003517          	auipc	a0,0x3
    80006b2c:	a3850513          	addi	a0,a0,-1480 # 80009560 <CONSOLE_STATUS+0x550>
    80006b30:	ffffc097          	auipc	ra,0xffffc
    80006b34:	d00080e7          	jalr	-768(ra) # 80002830 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006b38:	00048513          	mv	a0,s1
    80006b3c:	00000097          	auipc	ra,0x0
    80006b40:	f40080e7          	jalr	-192(ra) # 80006a7c <_ZN6Buffer6getCntEv>
    80006b44:	02a05c63          	blez	a0,80006b7c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006b48:	0084b783          	ld	a5,8(s1)
    80006b4c:	0104a703          	lw	a4,16(s1)
    80006b50:	00271713          	slli	a4,a4,0x2
    80006b54:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006b58:	0007c503          	lbu	a0,0(a5)
    80006b5c:	ffffb097          	auipc	ra,0xffffb
    80006b60:	59c080e7          	jalr	1436(ra) # 800020f8 <_Z4putcc>
        head = (head + 1) % cap;
    80006b64:	0104a783          	lw	a5,16(s1)
    80006b68:	0017879b          	addiw	a5,a5,1
    80006b6c:	0004a703          	lw	a4,0(s1)
    80006b70:	02e7e7bb          	remw	a5,a5,a4
    80006b74:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80006b78:	fc1ff06f          	j	80006b38 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80006b7c:	02100513          	li	a0,33
    80006b80:	ffffb097          	auipc	ra,0xffffb
    80006b84:	578080e7          	jalr	1400(ra) # 800020f8 <_Z4putcc>
    putc('\n');
    80006b88:	00a00513          	li	a0,10
    80006b8c:	ffffb097          	auipc	ra,0xffffb
    80006b90:	56c080e7          	jalr	1388(ra) # 800020f8 <_Z4putcc>
    mem_free(buffer);
    80006b94:	0084b503          	ld	a0,8(s1)
    80006b98:	ffffb097          	auipc	ra,0xffffb
    80006b9c:	284080e7          	jalr	644(ra) # 80001e1c <_Z8mem_freePv>
    sem_close(itemAvailable);
    80006ba0:	0204b503          	ld	a0,32(s1)
    80006ba4:	ffffb097          	auipc	ra,0xffffb
    80006ba8:	47c080e7          	jalr	1148(ra) # 80002020 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80006bac:	0184b503          	ld	a0,24(s1)
    80006bb0:	ffffb097          	auipc	ra,0xffffb
    80006bb4:	470080e7          	jalr	1136(ra) # 80002020 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80006bb8:	0304b503          	ld	a0,48(s1)
    80006bbc:	ffffb097          	auipc	ra,0xffffb
    80006bc0:	464080e7          	jalr	1124(ra) # 80002020 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006bc4:	0284b503          	ld	a0,40(s1)
    80006bc8:	ffffb097          	auipc	ra,0xffffb
    80006bcc:	458080e7          	jalr	1112(ra) # 80002020 <_Z9sem_closeP10_semaphore>
}
    80006bd0:	01813083          	ld	ra,24(sp)
    80006bd4:	01013403          	ld	s0,16(sp)
    80006bd8:	00813483          	ld	s1,8(sp)
    80006bdc:	02010113          	addi	sp,sp,32
    80006be0:	00008067          	ret

0000000080006be4 <start>:
    80006be4:	ff010113          	addi	sp,sp,-16
    80006be8:	00813423          	sd	s0,8(sp)
    80006bec:	01010413          	addi	s0,sp,16
    80006bf0:	300027f3          	csrr	a5,mstatus
    80006bf4:	ffffe737          	lui	a4,0xffffe
    80006bf8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff145f>
    80006bfc:	00e7f7b3          	and	a5,a5,a4
    80006c00:	00001737          	lui	a4,0x1
    80006c04:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006c08:	00e7e7b3          	or	a5,a5,a4
    80006c0c:	30079073          	csrw	mstatus,a5
    80006c10:	00000797          	auipc	a5,0x0
    80006c14:	16078793          	addi	a5,a5,352 # 80006d70 <system_main>
    80006c18:	34179073          	csrw	mepc,a5
    80006c1c:	00000793          	li	a5,0
    80006c20:	18079073          	csrw	satp,a5
    80006c24:	000107b7          	lui	a5,0x10
    80006c28:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006c2c:	30279073          	csrw	medeleg,a5
    80006c30:	30379073          	csrw	mideleg,a5
    80006c34:	104027f3          	csrr	a5,sie
    80006c38:	2227e793          	ori	a5,a5,546
    80006c3c:	10479073          	csrw	sie,a5
    80006c40:	fff00793          	li	a5,-1
    80006c44:	00a7d793          	srli	a5,a5,0xa
    80006c48:	3b079073          	csrw	pmpaddr0,a5
    80006c4c:	00f00793          	li	a5,15
    80006c50:	3a079073          	csrw	pmpcfg0,a5
    80006c54:	f14027f3          	csrr	a5,mhartid
    80006c58:	0200c737          	lui	a4,0x200c
    80006c5c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006c60:	0007869b          	sext.w	a3,a5
    80006c64:	00269713          	slli	a4,a3,0x2
    80006c68:	000f4637          	lui	a2,0xf4
    80006c6c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006c70:	00d70733          	add	a4,a4,a3
    80006c74:	0037979b          	slliw	a5,a5,0x3
    80006c78:	020046b7          	lui	a3,0x2004
    80006c7c:	00d787b3          	add	a5,a5,a3
    80006c80:	00c585b3          	add	a1,a1,a2
    80006c84:	00371693          	slli	a3,a4,0x3
    80006c88:	00005717          	auipc	a4,0x5
    80006c8c:	4b870713          	addi	a4,a4,1208 # 8000c140 <timer_scratch>
    80006c90:	00b7b023          	sd	a1,0(a5)
    80006c94:	00d70733          	add	a4,a4,a3
    80006c98:	00f73c23          	sd	a5,24(a4)
    80006c9c:	02c73023          	sd	a2,32(a4)
    80006ca0:	34071073          	csrw	mscratch,a4
    80006ca4:	00000797          	auipc	a5,0x0
    80006ca8:	6ec78793          	addi	a5,a5,1772 # 80007390 <timervec>
    80006cac:	30579073          	csrw	mtvec,a5
    80006cb0:	300027f3          	csrr	a5,mstatus
    80006cb4:	0087e793          	ori	a5,a5,8
    80006cb8:	30079073          	csrw	mstatus,a5
    80006cbc:	304027f3          	csrr	a5,mie
    80006cc0:	0807e793          	ori	a5,a5,128
    80006cc4:	30479073          	csrw	mie,a5
    80006cc8:	f14027f3          	csrr	a5,mhartid
    80006ccc:	0007879b          	sext.w	a5,a5
    80006cd0:	00078213          	mv	tp,a5
    80006cd4:	30200073          	mret
    80006cd8:	00813403          	ld	s0,8(sp)
    80006cdc:	01010113          	addi	sp,sp,16
    80006ce0:	00008067          	ret

0000000080006ce4 <timerinit>:
    80006ce4:	ff010113          	addi	sp,sp,-16
    80006ce8:	00813423          	sd	s0,8(sp)
    80006cec:	01010413          	addi	s0,sp,16
    80006cf0:	f14027f3          	csrr	a5,mhartid
    80006cf4:	0200c737          	lui	a4,0x200c
    80006cf8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006cfc:	0007869b          	sext.w	a3,a5
    80006d00:	00269713          	slli	a4,a3,0x2
    80006d04:	000f4637          	lui	a2,0xf4
    80006d08:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006d0c:	00d70733          	add	a4,a4,a3
    80006d10:	0037979b          	slliw	a5,a5,0x3
    80006d14:	020046b7          	lui	a3,0x2004
    80006d18:	00d787b3          	add	a5,a5,a3
    80006d1c:	00c585b3          	add	a1,a1,a2
    80006d20:	00371693          	slli	a3,a4,0x3
    80006d24:	00005717          	auipc	a4,0x5
    80006d28:	41c70713          	addi	a4,a4,1052 # 8000c140 <timer_scratch>
    80006d2c:	00b7b023          	sd	a1,0(a5)
    80006d30:	00d70733          	add	a4,a4,a3
    80006d34:	00f73c23          	sd	a5,24(a4)
    80006d38:	02c73023          	sd	a2,32(a4)
    80006d3c:	34071073          	csrw	mscratch,a4
    80006d40:	00000797          	auipc	a5,0x0
    80006d44:	65078793          	addi	a5,a5,1616 # 80007390 <timervec>
    80006d48:	30579073          	csrw	mtvec,a5
    80006d4c:	300027f3          	csrr	a5,mstatus
    80006d50:	0087e793          	ori	a5,a5,8
    80006d54:	30079073          	csrw	mstatus,a5
    80006d58:	304027f3          	csrr	a5,mie
    80006d5c:	0807e793          	ori	a5,a5,128
    80006d60:	30479073          	csrw	mie,a5
    80006d64:	00813403          	ld	s0,8(sp)
    80006d68:	01010113          	addi	sp,sp,16
    80006d6c:	00008067          	ret

0000000080006d70 <system_main>:
    80006d70:	fe010113          	addi	sp,sp,-32
    80006d74:	00813823          	sd	s0,16(sp)
    80006d78:	00913423          	sd	s1,8(sp)
    80006d7c:	00113c23          	sd	ra,24(sp)
    80006d80:	02010413          	addi	s0,sp,32
    80006d84:	00000097          	auipc	ra,0x0
    80006d88:	0c4080e7          	jalr	196(ra) # 80006e48 <cpuid>
    80006d8c:	00005497          	auipc	s1,0x5
    80006d90:	10448493          	addi	s1,s1,260 # 8000be90 <started>
    80006d94:	02050263          	beqz	a0,80006db8 <system_main+0x48>
    80006d98:	0004a783          	lw	a5,0(s1)
    80006d9c:	0007879b          	sext.w	a5,a5
    80006da0:	fe078ce3          	beqz	a5,80006d98 <system_main+0x28>
    80006da4:	0ff0000f          	fence
    80006da8:	00003517          	auipc	a0,0x3
    80006dac:	9e850513          	addi	a0,a0,-1560 # 80009790 <CONSOLE_STATUS+0x780>
    80006db0:	00001097          	auipc	ra,0x1
    80006db4:	a7c080e7          	jalr	-1412(ra) # 8000782c <panic>
    80006db8:	00001097          	auipc	ra,0x1
    80006dbc:	9d0080e7          	jalr	-1584(ra) # 80007788 <consoleinit>
    80006dc0:	00001097          	auipc	ra,0x1
    80006dc4:	15c080e7          	jalr	348(ra) # 80007f1c <printfinit>
    80006dc8:	00002517          	auipc	a0,0x2
    80006dcc:	58850513          	addi	a0,a0,1416 # 80009350 <CONSOLE_STATUS+0x340>
    80006dd0:	00001097          	auipc	ra,0x1
    80006dd4:	ab8080e7          	jalr	-1352(ra) # 80007888 <__printf>
    80006dd8:	00003517          	auipc	a0,0x3
    80006ddc:	98850513          	addi	a0,a0,-1656 # 80009760 <CONSOLE_STATUS+0x750>
    80006de0:	00001097          	auipc	ra,0x1
    80006de4:	aa8080e7          	jalr	-1368(ra) # 80007888 <__printf>
    80006de8:	00002517          	auipc	a0,0x2
    80006dec:	56850513          	addi	a0,a0,1384 # 80009350 <CONSOLE_STATUS+0x340>
    80006df0:	00001097          	auipc	ra,0x1
    80006df4:	a98080e7          	jalr	-1384(ra) # 80007888 <__printf>
    80006df8:	00001097          	auipc	ra,0x1
    80006dfc:	4b0080e7          	jalr	1200(ra) # 800082a8 <kinit>
    80006e00:	00000097          	auipc	ra,0x0
    80006e04:	148080e7          	jalr	328(ra) # 80006f48 <trapinit>
    80006e08:	00000097          	auipc	ra,0x0
    80006e0c:	16c080e7          	jalr	364(ra) # 80006f74 <trapinithart>
    80006e10:	00000097          	auipc	ra,0x0
    80006e14:	5c0080e7          	jalr	1472(ra) # 800073d0 <plicinit>
    80006e18:	00000097          	auipc	ra,0x0
    80006e1c:	5e0080e7          	jalr	1504(ra) # 800073f8 <plicinithart>
    80006e20:	00000097          	auipc	ra,0x0
    80006e24:	078080e7          	jalr	120(ra) # 80006e98 <userinit>
    80006e28:	0ff0000f          	fence
    80006e2c:	00100793          	li	a5,1
    80006e30:	00003517          	auipc	a0,0x3
    80006e34:	94850513          	addi	a0,a0,-1720 # 80009778 <CONSOLE_STATUS+0x768>
    80006e38:	00f4a023          	sw	a5,0(s1)
    80006e3c:	00001097          	auipc	ra,0x1
    80006e40:	a4c080e7          	jalr	-1460(ra) # 80007888 <__printf>
    80006e44:	0000006f          	j	80006e44 <system_main+0xd4>

0000000080006e48 <cpuid>:
    80006e48:	ff010113          	addi	sp,sp,-16
    80006e4c:	00813423          	sd	s0,8(sp)
    80006e50:	01010413          	addi	s0,sp,16
    80006e54:	00020513          	mv	a0,tp
    80006e58:	00813403          	ld	s0,8(sp)
    80006e5c:	0005051b          	sext.w	a0,a0
    80006e60:	01010113          	addi	sp,sp,16
    80006e64:	00008067          	ret

0000000080006e68 <mycpu>:
    80006e68:	ff010113          	addi	sp,sp,-16
    80006e6c:	00813423          	sd	s0,8(sp)
    80006e70:	01010413          	addi	s0,sp,16
    80006e74:	00020793          	mv	a5,tp
    80006e78:	00813403          	ld	s0,8(sp)
    80006e7c:	0007879b          	sext.w	a5,a5
    80006e80:	00779793          	slli	a5,a5,0x7
    80006e84:	00006517          	auipc	a0,0x6
    80006e88:	2ec50513          	addi	a0,a0,748 # 8000d170 <cpus>
    80006e8c:	00f50533          	add	a0,a0,a5
    80006e90:	01010113          	addi	sp,sp,16
    80006e94:	00008067          	ret

0000000080006e98 <userinit>:
    80006e98:	ff010113          	addi	sp,sp,-16
    80006e9c:	00813423          	sd	s0,8(sp)
    80006ea0:	01010413          	addi	s0,sp,16
    80006ea4:	00813403          	ld	s0,8(sp)
    80006ea8:	01010113          	addi	sp,sp,16
    80006eac:	ffffc317          	auipc	t1,0xffffc
    80006eb0:	f0030067          	jr	-256(t1) # 80002dac <main>

0000000080006eb4 <either_copyout>:
    80006eb4:	ff010113          	addi	sp,sp,-16
    80006eb8:	00813023          	sd	s0,0(sp)
    80006ebc:	00113423          	sd	ra,8(sp)
    80006ec0:	01010413          	addi	s0,sp,16
    80006ec4:	02051663          	bnez	a0,80006ef0 <either_copyout+0x3c>
    80006ec8:	00058513          	mv	a0,a1
    80006ecc:	00060593          	mv	a1,a2
    80006ed0:	0006861b          	sext.w	a2,a3
    80006ed4:	00002097          	auipc	ra,0x2
    80006ed8:	c60080e7          	jalr	-928(ra) # 80008b34 <__memmove>
    80006edc:	00813083          	ld	ra,8(sp)
    80006ee0:	00013403          	ld	s0,0(sp)
    80006ee4:	00000513          	li	a0,0
    80006ee8:	01010113          	addi	sp,sp,16
    80006eec:	00008067          	ret
    80006ef0:	00003517          	auipc	a0,0x3
    80006ef4:	8c850513          	addi	a0,a0,-1848 # 800097b8 <CONSOLE_STATUS+0x7a8>
    80006ef8:	00001097          	auipc	ra,0x1
    80006efc:	934080e7          	jalr	-1740(ra) # 8000782c <panic>

0000000080006f00 <either_copyin>:
    80006f00:	ff010113          	addi	sp,sp,-16
    80006f04:	00813023          	sd	s0,0(sp)
    80006f08:	00113423          	sd	ra,8(sp)
    80006f0c:	01010413          	addi	s0,sp,16
    80006f10:	02059463          	bnez	a1,80006f38 <either_copyin+0x38>
    80006f14:	00060593          	mv	a1,a2
    80006f18:	0006861b          	sext.w	a2,a3
    80006f1c:	00002097          	auipc	ra,0x2
    80006f20:	c18080e7          	jalr	-1000(ra) # 80008b34 <__memmove>
    80006f24:	00813083          	ld	ra,8(sp)
    80006f28:	00013403          	ld	s0,0(sp)
    80006f2c:	00000513          	li	a0,0
    80006f30:	01010113          	addi	sp,sp,16
    80006f34:	00008067          	ret
    80006f38:	00003517          	auipc	a0,0x3
    80006f3c:	8a850513          	addi	a0,a0,-1880 # 800097e0 <CONSOLE_STATUS+0x7d0>
    80006f40:	00001097          	auipc	ra,0x1
    80006f44:	8ec080e7          	jalr	-1812(ra) # 8000782c <panic>

0000000080006f48 <trapinit>:
    80006f48:	ff010113          	addi	sp,sp,-16
    80006f4c:	00813423          	sd	s0,8(sp)
    80006f50:	01010413          	addi	s0,sp,16
    80006f54:	00813403          	ld	s0,8(sp)
    80006f58:	00003597          	auipc	a1,0x3
    80006f5c:	8b058593          	addi	a1,a1,-1872 # 80009808 <CONSOLE_STATUS+0x7f8>
    80006f60:	00006517          	auipc	a0,0x6
    80006f64:	29050513          	addi	a0,a0,656 # 8000d1f0 <tickslock>
    80006f68:	01010113          	addi	sp,sp,16
    80006f6c:	00001317          	auipc	t1,0x1
    80006f70:	5cc30067          	jr	1484(t1) # 80008538 <initlock>

0000000080006f74 <trapinithart>:
    80006f74:	ff010113          	addi	sp,sp,-16
    80006f78:	00813423          	sd	s0,8(sp)
    80006f7c:	01010413          	addi	s0,sp,16
    80006f80:	00000797          	auipc	a5,0x0
    80006f84:	30078793          	addi	a5,a5,768 # 80007280 <kernelvec>
    80006f88:	10579073          	csrw	stvec,a5
    80006f8c:	00813403          	ld	s0,8(sp)
    80006f90:	01010113          	addi	sp,sp,16
    80006f94:	00008067          	ret

0000000080006f98 <usertrap>:
    80006f98:	ff010113          	addi	sp,sp,-16
    80006f9c:	00813423          	sd	s0,8(sp)
    80006fa0:	01010413          	addi	s0,sp,16
    80006fa4:	00813403          	ld	s0,8(sp)
    80006fa8:	01010113          	addi	sp,sp,16
    80006fac:	00008067          	ret

0000000080006fb0 <usertrapret>:
    80006fb0:	ff010113          	addi	sp,sp,-16
    80006fb4:	00813423          	sd	s0,8(sp)
    80006fb8:	01010413          	addi	s0,sp,16
    80006fbc:	00813403          	ld	s0,8(sp)
    80006fc0:	01010113          	addi	sp,sp,16
    80006fc4:	00008067          	ret

0000000080006fc8 <kerneltrap>:
    80006fc8:	fe010113          	addi	sp,sp,-32
    80006fcc:	00813823          	sd	s0,16(sp)
    80006fd0:	00113c23          	sd	ra,24(sp)
    80006fd4:	00913423          	sd	s1,8(sp)
    80006fd8:	02010413          	addi	s0,sp,32
    80006fdc:	142025f3          	csrr	a1,scause
    80006fe0:	100027f3          	csrr	a5,sstatus
    80006fe4:	0027f793          	andi	a5,a5,2
    80006fe8:	10079c63          	bnez	a5,80007100 <kerneltrap+0x138>
    80006fec:	142027f3          	csrr	a5,scause
    80006ff0:	0207ce63          	bltz	a5,8000702c <kerneltrap+0x64>
    80006ff4:	00003517          	auipc	a0,0x3
    80006ff8:	85c50513          	addi	a0,a0,-1956 # 80009850 <CONSOLE_STATUS+0x840>
    80006ffc:	00001097          	auipc	ra,0x1
    80007000:	88c080e7          	jalr	-1908(ra) # 80007888 <__printf>
    80007004:	141025f3          	csrr	a1,sepc
    80007008:	14302673          	csrr	a2,stval
    8000700c:	00003517          	auipc	a0,0x3
    80007010:	85450513          	addi	a0,a0,-1964 # 80009860 <CONSOLE_STATUS+0x850>
    80007014:	00001097          	auipc	ra,0x1
    80007018:	874080e7          	jalr	-1932(ra) # 80007888 <__printf>
    8000701c:	00003517          	auipc	a0,0x3
    80007020:	85c50513          	addi	a0,a0,-1956 # 80009878 <CONSOLE_STATUS+0x868>
    80007024:	00001097          	auipc	ra,0x1
    80007028:	808080e7          	jalr	-2040(ra) # 8000782c <panic>
    8000702c:	0ff7f713          	andi	a4,a5,255
    80007030:	00900693          	li	a3,9
    80007034:	04d70063          	beq	a4,a3,80007074 <kerneltrap+0xac>
    80007038:	fff00713          	li	a4,-1
    8000703c:	03f71713          	slli	a4,a4,0x3f
    80007040:	00170713          	addi	a4,a4,1
    80007044:	fae798e3          	bne	a5,a4,80006ff4 <kerneltrap+0x2c>
    80007048:	00000097          	auipc	ra,0x0
    8000704c:	e00080e7          	jalr	-512(ra) # 80006e48 <cpuid>
    80007050:	06050663          	beqz	a0,800070bc <kerneltrap+0xf4>
    80007054:	144027f3          	csrr	a5,sip
    80007058:	ffd7f793          	andi	a5,a5,-3
    8000705c:	14479073          	csrw	sip,a5
    80007060:	01813083          	ld	ra,24(sp)
    80007064:	01013403          	ld	s0,16(sp)
    80007068:	00813483          	ld	s1,8(sp)
    8000706c:	02010113          	addi	sp,sp,32
    80007070:	00008067          	ret
    80007074:	00000097          	auipc	ra,0x0
    80007078:	3d0080e7          	jalr	976(ra) # 80007444 <plic_claim>
    8000707c:	00a00793          	li	a5,10
    80007080:	00050493          	mv	s1,a0
    80007084:	06f50863          	beq	a0,a5,800070f4 <kerneltrap+0x12c>
    80007088:	fc050ce3          	beqz	a0,80007060 <kerneltrap+0x98>
    8000708c:	00050593          	mv	a1,a0
    80007090:	00002517          	auipc	a0,0x2
    80007094:	7a050513          	addi	a0,a0,1952 # 80009830 <CONSOLE_STATUS+0x820>
    80007098:	00000097          	auipc	ra,0x0
    8000709c:	7f0080e7          	jalr	2032(ra) # 80007888 <__printf>
    800070a0:	01013403          	ld	s0,16(sp)
    800070a4:	01813083          	ld	ra,24(sp)
    800070a8:	00048513          	mv	a0,s1
    800070ac:	00813483          	ld	s1,8(sp)
    800070b0:	02010113          	addi	sp,sp,32
    800070b4:	00000317          	auipc	t1,0x0
    800070b8:	3c830067          	jr	968(t1) # 8000747c <plic_complete>
    800070bc:	00006517          	auipc	a0,0x6
    800070c0:	13450513          	addi	a0,a0,308 # 8000d1f0 <tickslock>
    800070c4:	00001097          	auipc	ra,0x1
    800070c8:	498080e7          	jalr	1176(ra) # 8000855c <acquire>
    800070cc:	00005717          	auipc	a4,0x5
    800070d0:	dc870713          	addi	a4,a4,-568 # 8000be94 <ticks>
    800070d4:	00072783          	lw	a5,0(a4)
    800070d8:	00006517          	auipc	a0,0x6
    800070dc:	11850513          	addi	a0,a0,280 # 8000d1f0 <tickslock>
    800070e0:	0017879b          	addiw	a5,a5,1
    800070e4:	00f72023          	sw	a5,0(a4)
    800070e8:	00001097          	auipc	ra,0x1
    800070ec:	540080e7          	jalr	1344(ra) # 80008628 <release>
    800070f0:	f65ff06f          	j	80007054 <kerneltrap+0x8c>
    800070f4:	00001097          	auipc	ra,0x1
    800070f8:	09c080e7          	jalr	156(ra) # 80008190 <uartintr>
    800070fc:	fa5ff06f          	j	800070a0 <kerneltrap+0xd8>
    80007100:	00002517          	auipc	a0,0x2
    80007104:	71050513          	addi	a0,a0,1808 # 80009810 <CONSOLE_STATUS+0x800>
    80007108:	00000097          	auipc	ra,0x0
    8000710c:	724080e7          	jalr	1828(ra) # 8000782c <panic>

0000000080007110 <clockintr>:
    80007110:	fe010113          	addi	sp,sp,-32
    80007114:	00813823          	sd	s0,16(sp)
    80007118:	00913423          	sd	s1,8(sp)
    8000711c:	00113c23          	sd	ra,24(sp)
    80007120:	02010413          	addi	s0,sp,32
    80007124:	00006497          	auipc	s1,0x6
    80007128:	0cc48493          	addi	s1,s1,204 # 8000d1f0 <tickslock>
    8000712c:	00048513          	mv	a0,s1
    80007130:	00001097          	auipc	ra,0x1
    80007134:	42c080e7          	jalr	1068(ra) # 8000855c <acquire>
    80007138:	00005717          	auipc	a4,0x5
    8000713c:	d5c70713          	addi	a4,a4,-676 # 8000be94 <ticks>
    80007140:	00072783          	lw	a5,0(a4)
    80007144:	01013403          	ld	s0,16(sp)
    80007148:	01813083          	ld	ra,24(sp)
    8000714c:	00048513          	mv	a0,s1
    80007150:	0017879b          	addiw	a5,a5,1
    80007154:	00813483          	ld	s1,8(sp)
    80007158:	00f72023          	sw	a5,0(a4)
    8000715c:	02010113          	addi	sp,sp,32
    80007160:	00001317          	auipc	t1,0x1
    80007164:	4c830067          	jr	1224(t1) # 80008628 <release>

0000000080007168 <devintr>:
    80007168:	142027f3          	csrr	a5,scause
    8000716c:	00000513          	li	a0,0
    80007170:	0007c463          	bltz	a5,80007178 <devintr+0x10>
    80007174:	00008067          	ret
    80007178:	fe010113          	addi	sp,sp,-32
    8000717c:	00813823          	sd	s0,16(sp)
    80007180:	00113c23          	sd	ra,24(sp)
    80007184:	00913423          	sd	s1,8(sp)
    80007188:	02010413          	addi	s0,sp,32
    8000718c:	0ff7f713          	andi	a4,a5,255
    80007190:	00900693          	li	a3,9
    80007194:	04d70c63          	beq	a4,a3,800071ec <devintr+0x84>
    80007198:	fff00713          	li	a4,-1
    8000719c:	03f71713          	slli	a4,a4,0x3f
    800071a0:	00170713          	addi	a4,a4,1
    800071a4:	00e78c63          	beq	a5,a4,800071bc <devintr+0x54>
    800071a8:	01813083          	ld	ra,24(sp)
    800071ac:	01013403          	ld	s0,16(sp)
    800071b0:	00813483          	ld	s1,8(sp)
    800071b4:	02010113          	addi	sp,sp,32
    800071b8:	00008067          	ret
    800071bc:	00000097          	auipc	ra,0x0
    800071c0:	c8c080e7          	jalr	-884(ra) # 80006e48 <cpuid>
    800071c4:	06050663          	beqz	a0,80007230 <devintr+0xc8>
    800071c8:	144027f3          	csrr	a5,sip
    800071cc:	ffd7f793          	andi	a5,a5,-3
    800071d0:	14479073          	csrw	sip,a5
    800071d4:	01813083          	ld	ra,24(sp)
    800071d8:	01013403          	ld	s0,16(sp)
    800071dc:	00813483          	ld	s1,8(sp)
    800071e0:	00200513          	li	a0,2
    800071e4:	02010113          	addi	sp,sp,32
    800071e8:	00008067          	ret
    800071ec:	00000097          	auipc	ra,0x0
    800071f0:	258080e7          	jalr	600(ra) # 80007444 <plic_claim>
    800071f4:	00a00793          	li	a5,10
    800071f8:	00050493          	mv	s1,a0
    800071fc:	06f50663          	beq	a0,a5,80007268 <devintr+0x100>
    80007200:	00100513          	li	a0,1
    80007204:	fa0482e3          	beqz	s1,800071a8 <devintr+0x40>
    80007208:	00048593          	mv	a1,s1
    8000720c:	00002517          	auipc	a0,0x2
    80007210:	62450513          	addi	a0,a0,1572 # 80009830 <CONSOLE_STATUS+0x820>
    80007214:	00000097          	auipc	ra,0x0
    80007218:	674080e7          	jalr	1652(ra) # 80007888 <__printf>
    8000721c:	00048513          	mv	a0,s1
    80007220:	00000097          	auipc	ra,0x0
    80007224:	25c080e7          	jalr	604(ra) # 8000747c <plic_complete>
    80007228:	00100513          	li	a0,1
    8000722c:	f7dff06f          	j	800071a8 <devintr+0x40>
    80007230:	00006517          	auipc	a0,0x6
    80007234:	fc050513          	addi	a0,a0,-64 # 8000d1f0 <tickslock>
    80007238:	00001097          	auipc	ra,0x1
    8000723c:	324080e7          	jalr	804(ra) # 8000855c <acquire>
    80007240:	00005717          	auipc	a4,0x5
    80007244:	c5470713          	addi	a4,a4,-940 # 8000be94 <ticks>
    80007248:	00072783          	lw	a5,0(a4)
    8000724c:	00006517          	auipc	a0,0x6
    80007250:	fa450513          	addi	a0,a0,-92 # 8000d1f0 <tickslock>
    80007254:	0017879b          	addiw	a5,a5,1
    80007258:	00f72023          	sw	a5,0(a4)
    8000725c:	00001097          	auipc	ra,0x1
    80007260:	3cc080e7          	jalr	972(ra) # 80008628 <release>
    80007264:	f65ff06f          	j	800071c8 <devintr+0x60>
    80007268:	00001097          	auipc	ra,0x1
    8000726c:	f28080e7          	jalr	-216(ra) # 80008190 <uartintr>
    80007270:	fadff06f          	j	8000721c <devintr+0xb4>
	...

0000000080007280 <kernelvec>:
    80007280:	f0010113          	addi	sp,sp,-256
    80007284:	00113023          	sd	ra,0(sp)
    80007288:	00213423          	sd	sp,8(sp)
    8000728c:	00313823          	sd	gp,16(sp)
    80007290:	00413c23          	sd	tp,24(sp)
    80007294:	02513023          	sd	t0,32(sp)
    80007298:	02613423          	sd	t1,40(sp)
    8000729c:	02713823          	sd	t2,48(sp)
    800072a0:	02813c23          	sd	s0,56(sp)
    800072a4:	04913023          	sd	s1,64(sp)
    800072a8:	04a13423          	sd	a0,72(sp)
    800072ac:	04b13823          	sd	a1,80(sp)
    800072b0:	04c13c23          	sd	a2,88(sp)
    800072b4:	06d13023          	sd	a3,96(sp)
    800072b8:	06e13423          	sd	a4,104(sp)
    800072bc:	06f13823          	sd	a5,112(sp)
    800072c0:	07013c23          	sd	a6,120(sp)
    800072c4:	09113023          	sd	a7,128(sp)
    800072c8:	09213423          	sd	s2,136(sp)
    800072cc:	09313823          	sd	s3,144(sp)
    800072d0:	09413c23          	sd	s4,152(sp)
    800072d4:	0b513023          	sd	s5,160(sp)
    800072d8:	0b613423          	sd	s6,168(sp)
    800072dc:	0b713823          	sd	s7,176(sp)
    800072e0:	0b813c23          	sd	s8,184(sp)
    800072e4:	0d913023          	sd	s9,192(sp)
    800072e8:	0da13423          	sd	s10,200(sp)
    800072ec:	0db13823          	sd	s11,208(sp)
    800072f0:	0dc13c23          	sd	t3,216(sp)
    800072f4:	0fd13023          	sd	t4,224(sp)
    800072f8:	0fe13423          	sd	t5,232(sp)
    800072fc:	0ff13823          	sd	t6,240(sp)
    80007300:	cc9ff0ef          	jal	ra,80006fc8 <kerneltrap>
    80007304:	00013083          	ld	ra,0(sp)
    80007308:	00813103          	ld	sp,8(sp)
    8000730c:	01013183          	ld	gp,16(sp)
    80007310:	02013283          	ld	t0,32(sp)
    80007314:	02813303          	ld	t1,40(sp)
    80007318:	03013383          	ld	t2,48(sp)
    8000731c:	03813403          	ld	s0,56(sp)
    80007320:	04013483          	ld	s1,64(sp)
    80007324:	04813503          	ld	a0,72(sp)
    80007328:	05013583          	ld	a1,80(sp)
    8000732c:	05813603          	ld	a2,88(sp)
    80007330:	06013683          	ld	a3,96(sp)
    80007334:	06813703          	ld	a4,104(sp)
    80007338:	07013783          	ld	a5,112(sp)
    8000733c:	07813803          	ld	a6,120(sp)
    80007340:	08013883          	ld	a7,128(sp)
    80007344:	08813903          	ld	s2,136(sp)
    80007348:	09013983          	ld	s3,144(sp)
    8000734c:	09813a03          	ld	s4,152(sp)
    80007350:	0a013a83          	ld	s5,160(sp)
    80007354:	0a813b03          	ld	s6,168(sp)
    80007358:	0b013b83          	ld	s7,176(sp)
    8000735c:	0b813c03          	ld	s8,184(sp)
    80007360:	0c013c83          	ld	s9,192(sp)
    80007364:	0c813d03          	ld	s10,200(sp)
    80007368:	0d013d83          	ld	s11,208(sp)
    8000736c:	0d813e03          	ld	t3,216(sp)
    80007370:	0e013e83          	ld	t4,224(sp)
    80007374:	0e813f03          	ld	t5,232(sp)
    80007378:	0f013f83          	ld	t6,240(sp)
    8000737c:	10010113          	addi	sp,sp,256
    80007380:	10200073          	sret
    80007384:	00000013          	nop
    80007388:	00000013          	nop
    8000738c:	00000013          	nop

0000000080007390 <timervec>:
    80007390:	34051573          	csrrw	a0,mscratch,a0
    80007394:	00b53023          	sd	a1,0(a0)
    80007398:	00c53423          	sd	a2,8(a0)
    8000739c:	00d53823          	sd	a3,16(a0)
    800073a0:	01853583          	ld	a1,24(a0)
    800073a4:	02053603          	ld	a2,32(a0)
    800073a8:	0005b683          	ld	a3,0(a1)
    800073ac:	00c686b3          	add	a3,a3,a2
    800073b0:	00d5b023          	sd	a3,0(a1)
    800073b4:	00200593          	li	a1,2
    800073b8:	14459073          	csrw	sip,a1
    800073bc:	01053683          	ld	a3,16(a0)
    800073c0:	00853603          	ld	a2,8(a0)
    800073c4:	00053583          	ld	a1,0(a0)
    800073c8:	34051573          	csrrw	a0,mscratch,a0
    800073cc:	30200073          	mret

00000000800073d0 <plicinit>:
    800073d0:	ff010113          	addi	sp,sp,-16
    800073d4:	00813423          	sd	s0,8(sp)
    800073d8:	01010413          	addi	s0,sp,16
    800073dc:	00813403          	ld	s0,8(sp)
    800073e0:	0c0007b7          	lui	a5,0xc000
    800073e4:	00100713          	li	a4,1
    800073e8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800073ec:	00e7a223          	sw	a4,4(a5)
    800073f0:	01010113          	addi	sp,sp,16
    800073f4:	00008067          	ret

00000000800073f8 <plicinithart>:
    800073f8:	ff010113          	addi	sp,sp,-16
    800073fc:	00813023          	sd	s0,0(sp)
    80007400:	00113423          	sd	ra,8(sp)
    80007404:	01010413          	addi	s0,sp,16
    80007408:	00000097          	auipc	ra,0x0
    8000740c:	a40080e7          	jalr	-1472(ra) # 80006e48 <cpuid>
    80007410:	0085171b          	slliw	a4,a0,0x8
    80007414:	0c0027b7          	lui	a5,0xc002
    80007418:	00e787b3          	add	a5,a5,a4
    8000741c:	40200713          	li	a4,1026
    80007420:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007424:	00813083          	ld	ra,8(sp)
    80007428:	00013403          	ld	s0,0(sp)
    8000742c:	00d5151b          	slliw	a0,a0,0xd
    80007430:	0c2017b7          	lui	a5,0xc201
    80007434:	00a78533          	add	a0,a5,a0
    80007438:	00052023          	sw	zero,0(a0)
    8000743c:	01010113          	addi	sp,sp,16
    80007440:	00008067          	ret

0000000080007444 <plic_claim>:
    80007444:	ff010113          	addi	sp,sp,-16
    80007448:	00813023          	sd	s0,0(sp)
    8000744c:	00113423          	sd	ra,8(sp)
    80007450:	01010413          	addi	s0,sp,16
    80007454:	00000097          	auipc	ra,0x0
    80007458:	9f4080e7          	jalr	-1548(ra) # 80006e48 <cpuid>
    8000745c:	00813083          	ld	ra,8(sp)
    80007460:	00013403          	ld	s0,0(sp)
    80007464:	00d5151b          	slliw	a0,a0,0xd
    80007468:	0c2017b7          	lui	a5,0xc201
    8000746c:	00a78533          	add	a0,a5,a0
    80007470:	00452503          	lw	a0,4(a0)
    80007474:	01010113          	addi	sp,sp,16
    80007478:	00008067          	ret

000000008000747c <plic_complete>:
    8000747c:	fe010113          	addi	sp,sp,-32
    80007480:	00813823          	sd	s0,16(sp)
    80007484:	00913423          	sd	s1,8(sp)
    80007488:	00113c23          	sd	ra,24(sp)
    8000748c:	02010413          	addi	s0,sp,32
    80007490:	00050493          	mv	s1,a0
    80007494:	00000097          	auipc	ra,0x0
    80007498:	9b4080e7          	jalr	-1612(ra) # 80006e48 <cpuid>
    8000749c:	01813083          	ld	ra,24(sp)
    800074a0:	01013403          	ld	s0,16(sp)
    800074a4:	00d5179b          	slliw	a5,a0,0xd
    800074a8:	0c201737          	lui	a4,0xc201
    800074ac:	00f707b3          	add	a5,a4,a5
    800074b0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800074b4:	00813483          	ld	s1,8(sp)
    800074b8:	02010113          	addi	sp,sp,32
    800074bc:	00008067          	ret

00000000800074c0 <consolewrite>:
    800074c0:	fb010113          	addi	sp,sp,-80
    800074c4:	04813023          	sd	s0,64(sp)
    800074c8:	04113423          	sd	ra,72(sp)
    800074cc:	02913c23          	sd	s1,56(sp)
    800074d0:	03213823          	sd	s2,48(sp)
    800074d4:	03313423          	sd	s3,40(sp)
    800074d8:	03413023          	sd	s4,32(sp)
    800074dc:	01513c23          	sd	s5,24(sp)
    800074e0:	05010413          	addi	s0,sp,80
    800074e4:	06c05c63          	blez	a2,8000755c <consolewrite+0x9c>
    800074e8:	00060993          	mv	s3,a2
    800074ec:	00050a13          	mv	s4,a0
    800074f0:	00058493          	mv	s1,a1
    800074f4:	00000913          	li	s2,0
    800074f8:	fff00a93          	li	s5,-1
    800074fc:	01c0006f          	j	80007518 <consolewrite+0x58>
    80007500:	fbf44503          	lbu	a0,-65(s0)
    80007504:	0019091b          	addiw	s2,s2,1
    80007508:	00148493          	addi	s1,s1,1
    8000750c:	00001097          	auipc	ra,0x1
    80007510:	a9c080e7          	jalr	-1380(ra) # 80007fa8 <uartputc>
    80007514:	03298063          	beq	s3,s2,80007534 <consolewrite+0x74>
    80007518:	00048613          	mv	a2,s1
    8000751c:	00100693          	li	a3,1
    80007520:	000a0593          	mv	a1,s4
    80007524:	fbf40513          	addi	a0,s0,-65
    80007528:	00000097          	auipc	ra,0x0
    8000752c:	9d8080e7          	jalr	-1576(ra) # 80006f00 <either_copyin>
    80007530:	fd5518e3          	bne	a0,s5,80007500 <consolewrite+0x40>
    80007534:	04813083          	ld	ra,72(sp)
    80007538:	04013403          	ld	s0,64(sp)
    8000753c:	03813483          	ld	s1,56(sp)
    80007540:	02813983          	ld	s3,40(sp)
    80007544:	02013a03          	ld	s4,32(sp)
    80007548:	01813a83          	ld	s5,24(sp)
    8000754c:	00090513          	mv	a0,s2
    80007550:	03013903          	ld	s2,48(sp)
    80007554:	05010113          	addi	sp,sp,80
    80007558:	00008067          	ret
    8000755c:	00000913          	li	s2,0
    80007560:	fd5ff06f          	j	80007534 <consolewrite+0x74>

0000000080007564 <consoleread>:
    80007564:	f9010113          	addi	sp,sp,-112
    80007568:	06813023          	sd	s0,96(sp)
    8000756c:	04913c23          	sd	s1,88(sp)
    80007570:	05213823          	sd	s2,80(sp)
    80007574:	05313423          	sd	s3,72(sp)
    80007578:	05413023          	sd	s4,64(sp)
    8000757c:	03513c23          	sd	s5,56(sp)
    80007580:	03613823          	sd	s6,48(sp)
    80007584:	03713423          	sd	s7,40(sp)
    80007588:	03813023          	sd	s8,32(sp)
    8000758c:	06113423          	sd	ra,104(sp)
    80007590:	01913c23          	sd	s9,24(sp)
    80007594:	07010413          	addi	s0,sp,112
    80007598:	00060b93          	mv	s7,a2
    8000759c:	00050913          	mv	s2,a0
    800075a0:	00058c13          	mv	s8,a1
    800075a4:	00060b1b          	sext.w	s6,a2
    800075a8:	00006497          	auipc	s1,0x6
    800075ac:	c7048493          	addi	s1,s1,-912 # 8000d218 <cons>
    800075b0:	00400993          	li	s3,4
    800075b4:	fff00a13          	li	s4,-1
    800075b8:	00a00a93          	li	s5,10
    800075bc:	05705e63          	blez	s7,80007618 <consoleread+0xb4>
    800075c0:	09c4a703          	lw	a4,156(s1)
    800075c4:	0984a783          	lw	a5,152(s1)
    800075c8:	0007071b          	sext.w	a4,a4
    800075cc:	08e78463          	beq	a5,a4,80007654 <consoleread+0xf0>
    800075d0:	07f7f713          	andi	a4,a5,127
    800075d4:	00e48733          	add	a4,s1,a4
    800075d8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800075dc:	0017869b          	addiw	a3,a5,1
    800075e0:	08d4ac23          	sw	a3,152(s1)
    800075e4:	00070c9b          	sext.w	s9,a4
    800075e8:	0b370663          	beq	a4,s3,80007694 <consoleread+0x130>
    800075ec:	00100693          	li	a3,1
    800075f0:	f9f40613          	addi	a2,s0,-97
    800075f4:	000c0593          	mv	a1,s8
    800075f8:	00090513          	mv	a0,s2
    800075fc:	f8e40fa3          	sb	a4,-97(s0)
    80007600:	00000097          	auipc	ra,0x0
    80007604:	8b4080e7          	jalr	-1868(ra) # 80006eb4 <either_copyout>
    80007608:	01450863          	beq	a0,s4,80007618 <consoleread+0xb4>
    8000760c:	001c0c13          	addi	s8,s8,1
    80007610:	fffb8b9b          	addiw	s7,s7,-1
    80007614:	fb5c94e3          	bne	s9,s5,800075bc <consoleread+0x58>
    80007618:	000b851b          	sext.w	a0,s7
    8000761c:	06813083          	ld	ra,104(sp)
    80007620:	06013403          	ld	s0,96(sp)
    80007624:	05813483          	ld	s1,88(sp)
    80007628:	05013903          	ld	s2,80(sp)
    8000762c:	04813983          	ld	s3,72(sp)
    80007630:	04013a03          	ld	s4,64(sp)
    80007634:	03813a83          	ld	s5,56(sp)
    80007638:	02813b83          	ld	s7,40(sp)
    8000763c:	02013c03          	ld	s8,32(sp)
    80007640:	01813c83          	ld	s9,24(sp)
    80007644:	40ab053b          	subw	a0,s6,a0
    80007648:	03013b03          	ld	s6,48(sp)
    8000764c:	07010113          	addi	sp,sp,112
    80007650:	00008067          	ret
    80007654:	00001097          	auipc	ra,0x1
    80007658:	1d8080e7          	jalr	472(ra) # 8000882c <push_on>
    8000765c:	0984a703          	lw	a4,152(s1)
    80007660:	09c4a783          	lw	a5,156(s1)
    80007664:	0007879b          	sext.w	a5,a5
    80007668:	fef70ce3          	beq	a4,a5,80007660 <consoleread+0xfc>
    8000766c:	00001097          	auipc	ra,0x1
    80007670:	234080e7          	jalr	564(ra) # 800088a0 <pop_on>
    80007674:	0984a783          	lw	a5,152(s1)
    80007678:	07f7f713          	andi	a4,a5,127
    8000767c:	00e48733          	add	a4,s1,a4
    80007680:	01874703          	lbu	a4,24(a4)
    80007684:	0017869b          	addiw	a3,a5,1
    80007688:	08d4ac23          	sw	a3,152(s1)
    8000768c:	00070c9b          	sext.w	s9,a4
    80007690:	f5371ee3          	bne	a4,s3,800075ec <consoleread+0x88>
    80007694:	000b851b          	sext.w	a0,s7
    80007698:	f96bf2e3          	bgeu	s7,s6,8000761c <consoleread+0xb8>
    8000769c:	08f4ac23          	sw	a5,152(s1)
    800076a0:	f7dff06f          	j	8000761c <consoleread+0xb8>

00000000800076a4 <consputc>:
    800076a4:	10000793          	li	a5,256
    800076a8:	00f50663          	beq	a0,a5,800076b4 <consputc+0x10>
    800076ac:	00001317          	auipc	t1,0x1
    800076b0:	9f430067          	jr	-1548(t1) # 800080a0 <uartputc_sync>
    800076b4:	ff010113          	addi	sp,sp,-16
    800076b8:	00113423          	sd	ra,8(sp)
    800076bc:	00813023          	sd	s0,0(sp)
    800076c0:	01010413          	addi	s0,sp,16
    800076c4:	00800513          	li	a0,8
    800076c8:	00001097          	auipc	ra,0x1
    800076cc:	9d8080e7          	jalr	-1576(ra) # 800080a0 <uartputc_sync>
    800076d0:	02000513          	li	a0,32
    800076d4:	00001097          	auipc	ra,0x1
    800076d8:	9cc080e7          	jalr	-1588(ra) # 800080a0 <uartputc_sync>
    800076dc:	00013403          	ld	s0,0(sp)
    800076e0:	00813083          	ld	ra,8(sp)
    800076e4:	00800513          	li	a0,8
    800076e8:	01010113          	addi	sp,sp,16
    800076ec:	00001317          	auipc	t1,0x1
    800076f0:	9b430067          	jr	-1612(t1) # 800080a0 <uartputc_sync>

00000000800076f4 <consoleintr>:
    800076f4:	fe010113          	addi	sp,sp,-32
    800076f8:	00813823          	sd	s0,16(sp)
    800076fc:	00913423          	sd	s1,8(sp)
    80007700:	01213023          	sd	s2,0(sp)
    80007704:	00113c23          	sd	ra,24(sp)
    80007708:	02010413          	addi	s0,sp,32
    8000770c:	00006917          	auipc	s2,0x6
    80007710:	b0c90913          	addi	s2,s2,-1268 # 8000d218 <cons>
    80007714:	00050493          	mv	s1,a0
    80007718:	00090513          	mv	a0,s2
    8000771c:	00001097          	auipc	ra,0x1
    80007720:	e40080e7          	jalr	-448(ra) # 8000855c <acquire>
    80007724:	02048c63          	beqz	s1,8000775c <consoleintr+0x68>
    80007728:	0a092783          	lw	a5,160(s2)
    8000772c:	09892703          	lw	a4,152(s2)
    80007730:	07f00693          	li	a3,127
    80007734:	40e7873b          	subw	a4,a5,a4
    80007738:	02e6e263          	bltu	a3,a4,8000775c <consoleintr+0x68>
    8000773c:	00d00713          	li	a4,13
    80007740:	04e48063          	beq	s1,a4,80007780 <consoleintr+0x8c>
    80007744:	07f7f713          	andi	a4,a5,127
    80007748:	00e90733          	add	a4,s2,a4
    8000774c:	0017879b          	addiw	a5,a5,1
    80007750:	0af92023          	sw	a5,160(s2)
    80007754:	00970c23          	sb	s1,24(a4)
    80007758:	08f92e23          	sw	a5,156(s2)
    8000775c:	01013403          	ld	s0,16(sp)
    80007760:	01813083          	ld	ra,24(sp)
    80007764:	00813483          	ld	s1,8(sp)
    80007768:	00013903          	ld	s2,0(sp)
    8000776c:	00006517          	auipc	a0,0x6
    80007770:	aac50513          	addi	a0,a0,-1364 # 8000d218 <cons>
    80007774:	02010113          	addi	sp,sp,32
    80007778:	00001317          	auipc	t1,0x1
    8000777c:	eb030067          	jr	-336(t1) # 80008628 <release>
    80007780:	00a00493          	li	s1,10
    80007784:	fc1ff06f          	j	80007744 <consoleintr+0x50>

0000000080007788 <consoleinit>:
    80007788:	fe010113          	addi	sp,sp,-32
    8000778c:	00113c23          	sd	ra,24(sp)
    80007790:	00813823          	sd	s0,16(sp)
    80007794:	00913423          	sd	s1,8(sp)
    80007798:	02010413          	addi	s0,sp,32
    8000779c:	00006497          	auipc	s1,0x6
    800077a0:	a7c48493          	addi	s1,s1,-1412 # 8000d218 <cons>
    800077a4:	00048513          	mv	a0,s1
    800077a8:	00002597          	auipc	a1,0x2
    800077ac:	0e058593          	addi	a1,a1,224 # 80009888 <CONSOLE_STATUS+0x878>
    800077b0:	00001097          	auipc	ra,0x1
    800077b4:	d88080e7          	jalr	-632(ra) # 80008538 <initlock>
    800077b8:	00000097          	auipc	ra,0x0
    800077bc:	7ac080e7          	jalr	1964(ra) # 80007f64 <uartinit>
    800077c0:	01813083          	ld	ra,24(sp)
    800077c4:	01013403          	ld	s0,16(sp)
    800077c8:	00000797          	auipc	a5,0x0
    800077cc:	d9c78793          	addi	a5,a5,-612 # 80007564 <consoleread>
    800077d0:	0af4bc23          	sd	a5,184(s1)
    800077d4:	00000797          	auipc	a5,0x0
    800077d8:	cec78793          	addi	a5,a5,-788 # 800074c0 <consolewrite>
    800077dc:	0cf4b023          	sd	a5,192(s1)
    800077e0:	00813483          	ld	s1,8(sp)
    800077e4:	02010113          	addi	sp,sp,32
    800077e8:	00008067          	ret

00000000800077ec <console_read>:
    800077ec:	ff010113          	addi	sp,sp,-16
    800077f0:	00813423          	sd	s0,8(sp)
    800077f4:	01010413          	addi	s0,sp,16
    800077f8:	00813403          	ld	s0,8(sp)
    800077fc:	00006317          	auipc	t1,0x6
    80007800:	ad433303          	ld	t1,-1324(t1) # 8000d2d0 <devsw+0x10>
    80007804:	01010113          	addi	sp,sp,16
    80007808:	00030067          	jr	t1

000000008000780c <console_write>:
    8000780c:	ff010113          	addi	sp,sp,-16
    80007810:	00813423          	sd	s0,8(sp)
    80007814:	01010413          	addi	s0,sp,16
    80007818:	00813403          	ld	s0,8(sp)
    8000781c:	00006317          	auipc	t1,0x6
    80007820:	abc33303          	ld	t1,-1348(t1) # 8000d2d8 <devsw+0x18>
    80007824:	01010113          	addi	sp,sp,16
    80007828:	00030067          	jr	t1

000000008000782c <panic>:
    8000782c:	fe010113          	addi	sp,sp,-32
    80007830:	00113c23          	sd	ra,24(sp)
    80007834:	00813823          	sd	s0,16(sp)
    80007838:	00913423          	sd	s1,8(sp)
    8000783c:	02010413          	addi	s0,sp,32
    80007840:	00050493          	mv	s1,a0
    80007844:	00002517          	auipc	a0,0x2
    80007848:	04c50513          	addi	a0,a0,76 # 80009890 <CONSOLE_STATUS+0x880>
    8000784c:	00006797          	auipc	a5,0x6
    80007850:	b207a623          	sw	zero,-1236(a5) # 8000d378 <pr+0x18>
    80007854:	00000097          	auipc	ra,0x0
    80007858:	034080e7          	jalr	52(ra) # 80007888 <__printf>
    8000785c:	00048513          	mv	a0,s1
    80007860:	00000097          	auipc	ra,0x0
    80007864:	028080e7          	jalr	40(ra) # 80007888 <__printf>
    80007868:	00002517          	auipc	a0,0x2
    8000786c:	ae850513          	addi	a0,a0,-1304 # 80009350 <CONSOLE_STATUS+0x340>
    80007870:	00000097          	auipc	ra,0x0
    80007874:	018080e7          	jalr	24(ra) # 80007888 <__printf>
    80007878:	00100793          	li	a5,1
    8000787c:	00004717          	auipc	a4,0x4
    80007880:	60f72e23          	sw	a5,1564(a4) # 8000be98 <panicked>
    80007884:	0000006f          	j	80007884 <panic+0x58>

0000000080007888 <__printf>:
    80007888:	f3010113          	addi	sp,sp,-208
    8000788c:	08813023          	sd	s0,128(sp)
    80007890:	07313423          	sd	s3,104(sp)
    80007894:	09010413          	addi	s0,sp,144
    80007898:	05813023          	sd	s8,64(sp)
    8000789c:	08113423          	sd	ra,136(sp)
    800078a0:	06913c23          	sd	s1,120(sp)
    800078a4:	07213823          	sd	s2,112(sp)
    800078a8:	07413023          	sd	s4,96(sp)
    800078ac:	05513c23          	sd	s5,88(sp)
    800078b0:	05613823          	sd	s6,80(sp)
    800078b4:	05713423          	sd	s7,72(sp)
    800078b8:	03913c23          	sd	s9,56(sp)
    800078bc:	03a13823          	sd	s10,48(sp)
    800078c0:	03b13423          	sd	s11,40(sp)
    800078c4:	00006317          	auipc	t1,0x6
    800078c8:	a9c30313          	addi	t1,t1,-1380 # 8000d360 <pr>
    800078cc:	01832c03          	lw	s8,24(t1)
    800078d0:	00b43423          	sd	a1,8(s0)
    800078d4:	00c43823          	sd	a2,16(s0)
    800078d8:	00d43c23          	sd	a3,24(s0)
    800078dc:	02e43023          	sd	a4,32(s0)
    800078e0:	02f43423          	sd	a5,40(s0)
    800078e4:	03043823          	sd	a6,48(s0)
    800078e8:	03143c23          	sd	a7,56(s0)
    800078ec:	00050993          	mv	s3,a0
    800078f0:	4a0c1663          	bnez	s8,80007d9c <__printf+0x514>
    800078f4:	60098c63          	beqz	s3,80007f0c <__printf+0x684>
    800078f8:	0009c503          	lbu	a0,0(s3)
    800078fc:	00840793          	addi	a5,s0,8
    80007900:	f6f43c23          	sd	a5,-136(s0)
    80007904:	00000493          	li	s1,0
    80007908:	22050063          	beqz	a0,80007b28 <__printf+0x2a0>
    8000790c:	00002a37          	lui	s4,0x2
    80007910:	00018ab7          	lui	s5,0x18
    80007914:	000f4b37          	lui	s6,0xf4
    80007918:	00989bb7          	lui	s7,0x989
    8000791c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007920:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007924:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007928:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000792c:	00148c9b          	addiw	s9,s1,1
    80007930:	02500793          	li	a5,37
    80007934:	01998933          	add	s2,s3,s9
    80007938:	38f51263          	bne	a0,a5,80007cbc <__printf+0x434>
    8000793c:	00094783          	lbu	a5,0(s2)
    80007940:	00078c9b          	sext.w	s9,a5
    80007944:	1e078263          	beqz	a5,80007b28 <__printf+0x2a0>
    80007948:	0024849b          	addiw	s1,s1,2
    8000794c:	07000713          	li	a4,112
    80007950:	00998933          	add	s2,s3,s1
    80007954:	38e78a63          	beq	a5,a4,80007ce8 <__printf+0x460>
    80007958:	20f76863          	bltu	a4,a5,80007b68 <__printf+0x2e0>
    8000795c:	42a78863          	beq	a5,a0,80007d8c <__printf+0x504>
    80007960:	06400713          	li	a4,100
    80007964:	40e79663          	bne	a5,a4,80007d70 <__printf+0x4e8>
    80007968:	f7843783          	ld	a5,-136(s0)
    8000796c:	0007a603          	lw	a2,0(a5)
    80007970:	00878793          	addi	a5,a5,8
    80007974:	f6f43c23          	sd	a5,-136(s0)
    80007978:	42064a63          	bltz	a2,80007dac <__printf+0x524>
    8000797c:	00a00713          	li	a4,10
    80007980:	02e677bb          	remuw	a5,a2,a4
    80007984:	00002d97          	auipc	s11,0x2
    80007988:	f34d8d93          	addi	s11,s11,-204 # 800098b8 <digits>
    8000798c:	00900593          	li	a1,9
    80007990:	0006051b          	sext.w	a0,a2
    80007994:	00000c93          	li	s9,0
    80007998:	02079793          	slli	a5,a5,0x20
    8000799c:	0207d793          	srli	a5,a5,0x20
    800079a0:	00fd87b3          	add	a5,s11,a5
    800079a4:	0007c783          	lbu	a5,0(a5)
    800079a8:	02e656bb          	divuw	a3,a2,a4
    800079ac:	f8f40023          	sb	a5,-128(s0)
    800079b0:	14c5d863          	bge	a1,a2,80007b00 <__printf+0x278>
    800079b4:	06300593          	li	a1,99
    800079b8:	00100c93          	li	s9,1
    800079bc:	02e6f7bb          	remuw	a5,a3,a4
    800079c0:	02079793          	slli	a5,a5,0x20
    800079c4:	0207d793          	srli	a5,a5,0x20
    800079c8:	00fd87b3          	add	a5,s11,a5
    800079cc:	0007c783          	lbu	a5,0(a5)
    800079d0:	02e6d73b          	divuw	a4,a3,a4
    800079d4:	f8f400a3          	sb	a5,-127(s0)
    800079d8:	12a5f463          	bgeu	a1,a0,80007b00 <__printf+0x278>
    800079dc:	00a00693          	li	a3,10
    800079e0:	00900593          	li	a1,9
    800079e4:	02d777bb          	remuw	a5,a4,a3
    800079e8:	02079793          	slli	a5,a5,0x20
    800079ec:	0207d793          	srli	a5,a5,0x20
    800079f0:	00fd87b3          	add	a5,s11,a5
    800079f4:	0007c503          	lbu	a0,0(a5)
    800079f8:	02d757bb          	divuw	a5,a4,a3
    800079fc:	f8a40123          	sb	a0,-126(s0)
    80007a00:	48e5f263          	bgeu	a1,a4,80007e84 <__printf+0x5fc>
    80007a04:	06300513          	li	a0,99
    80007a08:	02d7f5bb          	remuw	a1,a5,a3
    80007a0c:	02059593          	slli	a1,a1,0x20
    80007a10:	0205d593          	srli	a1,a1,0x20
    80007a14:	00bd85b3          	add	a1,s11,a1
    80007a18:	0005c583          	lbu	a1,0(a1)
    80007a1c:	02d7d7bb          	divuw	a5,a5,a3
    80007a20:	f8b401a3          	sb	a1,-125(s0)
    80007a24:	48e57263          	bgeu	a0,a4,80007ea8 <__printf+0x620>
    80007a28:	3e700513          	li	a0,999
    80007a2c:	02d7f5bb          	remuw	a1,a5,a3
    80007a30:	02059593          	slli	a1,a1,0x20
    80007a34:	0205d593          	srli	a1,a1,0x20
    80007a38:	00bd85b3          	add	a1,s11,a1
    80007a3c:	0005c583          	lbu	a1,0(a1)
    80007a40:	02d7d7bb          	divuw	a5,a5,a3
    80007a44:	f8b40223          	sb	a1,-124(s0)
    80007a48:	46e57663          	bgeu	a0,a4,80007eb4 <__printf+0x62c>
    80007a4c:	02d7f5bb          	remuw	a1,a5,a3
    80007a50:	02059593          	slli	a1,a1,0x20
    80007a54:	0205d593          	srli	a1,a1,0x20
    80007a58:	00bd85b3          	add	a1,s11,a1
    80007a5c:	0005c583          	lbu	a1,0(a1)
    80007a60:	02d7d7bb          	divuw	a5,a5,a3
    80007a64:	f8b402a3          	sb	a1,-123(s0)
    80007a68:	46ea7863          	bgeu	s4,a4,80007ed8 <__printf+0x650>
    80007a6c:	02d7f5bb          	remuw	a1,a5,a3
    80007a70:	02059593          	slli	a1,a1,0x20
    80007a74:	0205d593          	srli	a1,a1,0x20
    80007a78:	00bd85b3          	add	a1,s11,a1
    80007a7c:	0005c583          	lbu	a1,0(a1)
    80007a80:	02d7d7bb          	divuw	a5,a5,a3
    80007a84:	f8b40323          	sb	a1,-122(s0)
    80007a88:	3eeaf863          	bgeu	s5,a4,80007e78 <__printf+0x5f0>
    80007a8c:	02d7f5bb          	remuw	a1,a5,a3
    80007a90:	02059593          	slli	a1,a1,0x20
    80007a94:	0205d593          	srli	a1,a1,0x20
    80007a98:	00bd85b3          	add	a1,s11,a1
    80007a9c:	0005c583          	lbu	a1,0(a1)
    80007aa0:	02d7d7bb          	divuw	a5,a5,a3
    80007aa4:	f8b403a3          	sb	a1,-121(s0)
    80007aa8:	42eb7e63          	bgeu	s6,a4,80007ee4 <__printf+0x65c>
    80007aac:	02d7f5bb          	remuw	a1,a5,a3
    80007ab0:	02059593          	slli	a1,a1,0x20
    80007ab4:	0205d593          	srli	a1,a1,0x20
    80007ab8:	00bd85b3          	add	a1,s11,a1
    80007abc:	0005c583          	lbu	a1,0(a1)
    80007ac0:	02d7d7bb          	divuw	a5,a5,a3
    80007ac4:	f8b40423          	sb	a1,-120(s0)
    80007ac8:	42ebfc63          	bgeu	s7,a4,80007f00 <__printf+0x678>
    80007acc:	02079793          	slli	a5,a5,0x20
    80007ad0:	0207d793          	srli	a5,a5,0x20
    80007ad4:	00fd8db3          	add	s11,s11,a5
    80007ad8:	000dc703          	lbu	a4,0(s11)
    80007adc:	00a00793          	li	a5,10
    80007ae0:	00900c93          	li	s9,9
    80007ae4:	f8e404a3          	sb	a4,-119(s0)
    80007ae8:	00065c63          	bgez	a2,80007b00 <__printf+0x278>
    80007aec:	f9040713          	addi	a4,s0,-112
    80007af0:	00f70733          	add	a4,a4,a5
    80007af4:	02d00693          	li	a3,45
    80007af8:	fed70823          	sb	a3,-16(a4)
    80007afc:	00078c93          	mv	s9,a5
    80007b00:	f8040793          	addi	a5,s0,-128
    80007b04:	01978cb3          	add	s9,a5,s9
    80007b08:	f7f40d13          	addi	s10,s0,-129
    80007b0c:	000cc503          	lbu	a0,0(s9)
    80007b10:	fffc8c93          	addi	s9,s9,-1
    80007b14:	00000097          	auipc	ra,0x0
    80007b18:	b90080e7          	jalr	-1136(ra) # 800076a4 <consputc>
    80007b1c:	ffac98e3          	bne	s9,s10,80007b0c <__printf+0x284>
    80007b20:	00094503          	lbu	a0,0(s2)
    80007b24:	e00514e3          	bnez	a0,8000792c <__printf+0xa4>
    80007b28:	1a0c1663          	bnez	s8,80007cd4 <__printf+0x44c>
    80007b2c:	08813083          	ld	ra,136(sp)
    80007b30:	08013403          	ld	s0,128(sp)
    80007b34:	07813483          	ld	s1,120(sp)
    80007b38:	07013903          	ld	s2,112(sp)
    80007b3c:	06813983          	ld	s3,104(sp)
    80007b40:	06013a03          	ld	s4,96(sp)
    80007b44:	05813a83          	ld	s5,88(sp)
    80007b48:	05013b03          	ld	s6,80(sp)
    80007b4c:	04813b83          	ld	s7,72(sp)
    80007b50:	04013c03          	ld	s8,64(sp)
    80007b54:	03813c83          	ld	s9,56(sp)
    80007b58:	03013d03          	ld	s10,48(sp)
    80007b5c:	02813d83          	ld	s11,40(sp)
    80007b60:	0d010113          	addi	sp,sp,208
    80007b64:	00008067          	ret
    80007b68:	07300713          	li	a4,115
    80007b6c:	1ce78a63          	beq	a5,a4,80007d40 <__printf+0x4b8>
    80007b70:	07800713          	li	a4,120
    80007b74:	1ee79e63          	bne	a5,a4,80007d70 <__printf+0x4e8>
    80007b78:	f7843783          	ld	a5,-136(s0)
    80007b7c:	0007a703          	lw	a4,0(a5)
    80007b80:	00878793          	addi	a5,a5,8
    80007b84:	f6f43c23          	sd	a5,-136(s0)
    80007b88:	28074263          	bltz	a4,80007e0c <__printf+0x584>
    80007b8c:	00002d97          	auipc	s11,0x2
    80007b90:	d2cd8d93          	addi	s11,s11,-724 # 800098b8 <digits>
    80007b94:	00f77793          	andi	a5,a4,15
    80007b98:	00fd87b3          	add	a5,s11,a5
    80007b9c:	0007c683          	lbu	a3,0(a5)
    80007ba0:	00f00613          	li	a2,15
    80007ba4:	0007079b          	sext.w	a5,a4
    80007ba8:	f8d40023          	sb	a3,-128(s0)
    80007bac:	0047559b          	srliw	a1,a4,0x4
    80007bb0:	0047569b          	srliw	a3,a4,0x4
    80007bb4:	00000c93          	li	s9,0
    80007bb8:	0ee65063          	bge	a2,a4,80007c98 <__printf+0x410>
    80007bbc:	00f6f693          	andi	a3,a3,15
    80007bc0:	00dd86b3          	add	a3,s11,a3
    80007bc4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007bc8:	0087d79b          	srliw	a5,a5,0x8
    80007bcc:	00100c93          	li	s9,1
    80007bd0:	f8d400a3          	sb	a3,-127(s0)
    80007bd4:	0cb67263          	bgeu	a2,a1,80007c98 <__printf+0x410>
    80007bd8:	00f7f693          	andi	a3,a5,15
    80007bdc:	00dd86b3          	add	a3,s11,a3
    80007be0:	0006c583          	lbu	a1,0(a3)
    80007be4:	00f00613          	li	a2,15
    80007be8:	0047d69b          	srliw	a3,a5,0x4
    80007bec:	f8b40123          	sb	a1,-126(s0)
    80007bf0:	0047d593          	srli	a1,a5,0x4
    80007bf4:	28f67e63          	bgeu	a2,a5,80007e90 <__printf+0x608>
    80007bf8:	00f6f693          	andi	a3,a3,15
    80007bfc:	00dd86b3          	add	a3,s11,a3
    80007c00:	0006c503          	lbu	a0,0(a3)
    80007c04:	0087d813          	srli	a6,a5,0x8
    80007c08:	0087d69b          	srliw	a3,a5,0x8
    80007c0c:	f8a401a3          	sb	a0,-125(s0)
    80007c10:	28b67663          	bgeu	a2,a1,80007e9c <__printf+0x614>
    80007c14:	00f6f693          	andi	a3,a3,15
    80007c18:	00dd86b3          	add	a3,s11,a3
    80007c1c:	0006c583          	lbu	a1,0(a3)
    80007c20:	00c7d513          	srli	a0,a5,0xc
    80007c24:	00c7d69b          	srliw	a3,a5,0xc
    80007c28:	f8b40223          	sb	a1,-124(s0)
    80007c2c:	29067a63          	bgeu	a2,a6,80007ec0 <__printf+0x638>
    80007c30:	00f6f693          	andi	a3,a3,15
    80007c34:	00dd86b3          	add	a3,s11,a3
    80007c38:	0006c583          	lbu	a1,0(a3)
    80007c3c:	0107d813          	srli	a6,a5,0x10
    80007c40:	0107d69b          	srliw	a3,a5,0x10
    80007c44:	f8b402a3          	sb	a1,-123(s0)
    80007c48:	28a67263          	bgeu	a2,a0,80007ecc <__printf+0x644>
    80007c4c:	00f6f693          	andi	a3,a3,15
    80007c50:	00dd86b3          	add	a3,s11,a3
    80007c54:	0006c683          	lbu	a3,0(a3)
    80007c58:	0147d79b          	srliw	a5,a5,0x14
    80007c5c:	f8d40323          	sb	a3,-122(s0)
    80007c60:	21067663          	bgeu	a2,a6,80007e6c <__printf+0x5e4>
    80007c64:	02079793          	slli	a5,a5,0x20
    80007c68:	0207d793          	srli	a5,a5,0x20
    80007c6c:	00fd8db3          	add	s11,s11,a5
    80007c70:	000dc683          	lbu	a3,0(s11)
    80007c74:	00800793          	li	a5,8
    80007c78:	00700c93          	li	s9,7
    80007c7c:	f8d403a3          	sb	a3,-121(s0)
    80007c80:	00075c63          	bgez	a4,80007c98 <__printf+0x410>
    80007c84:	f9040713          	addi	a4,s0,-112
    80007c88:	00f70733          	add	a4,a4,a5
    80007c8c:	02d00693          	li	a3,45
    80007c90:	fed70823          	sb	a3,-16(a4)
    80007c94:	00078c93          	mv	s9,a5
    80007c98:	f8040793          	addi	a5,s0,-128
    80007c9c:	01978cb3          	add	s9,a5,s9
    80007ca0:	f7f40d13          	addi	s10,s0,-129
    80007ca4:	000cc503          	lbu	a0,0(s9)
    80007ca8:	fffc8c93          	addi	s9,s9,-1
    80007cac:	00000097          	auipc	ra,0x0
    80007cb0:	9f8080e7          	jalr	-1544(ra) # 800076a4 <consputc>
    80007cb4:	ff9d18e3          	bne	s10,s9,80007ca4 <__printf+0x41c>
    80007cb8:	0100006f          	j	80007cc8 <__printf+0x440>
    80007cbc:	00000097          	auipc	ra,0x0
    80007cc0:	9e8080e7          	jalr	-1560(ra) # 800076a4 <consputc>
    80007cc4:	000c8493          	mv	s1,s9
    80007cc8:	00094503          	lbu	a0,0(s2)
    80007ccc:	c60510e3          	bnez	a0,8000792c <__printf+0xa4>
    80007cd0:	e40c0ee3          	beqz	s8,80007b2c <__printf+0x2a4>
    80007cd4:	00005517          	auipc	a0,0x5
    80007cd8:	68c50513          	addi	a0,a0,1676 # 8000d360 <pr>
    80007cdc:	00001097          	auipc	ra,0x1
    80007ce0:	94c080e7          	jalr	-1716(ra) # 80008628 <release>
    80007ce4:	e49ff06f          	j	80007b2c <__printf+0x2a4>
    80007ce8:	f7843783          	ld	a5,-136(s0)
    80007cec:	03000513          	li	a0,48
    80007cf0:	01000d13          	li	s10,16
    80007cf4:	00878713          	addi	a4,a5,8
    80007cf8:	0007bc83          	ld	s9,0(a5)
    80007cfc:	f6e43c23          	sd	a4,-136(s0)
    80007d00:	00000097          	auipc	ra,0x0
    80007d04:	9a4080e7          	jalr	-1628(ra) # 800076a4 <consputc>
    80007d08:	07800513          	li	a0,120
    80007d0c:	00000097          	auipc	ra,0x0
    80007d10:	998080e7          	jalr	-1640(ra) # 800076a4 <consputc>
    80007d14:	00002d97          	auipc	s11,0x2
    80007d18:	ba4d8d93          	addi	s11,s11,-1116 # 800098b8 <digits>
    80007d1c:	03ccd793          	srli	a5,s9,0x3c
    80007d20:	00fd87b3          	add	a5,s11,a5
    80007d24:	0007c503          	lbu	a0,0(a5)
    80007d28:	fffd0d1b          	addiw	s10,s10,-1
    80007d2c:	004c9c93          	slli	s9,s9,0x4
    80007d30:	00000097          	auipc	ra,0x0
    80007d34:	974080e7          	jalr	-1676(ra) # 800076a4 <consputc>
    80007d38:	fe0d12e3          	bnez	s10,80007d1c <__printf+0x494>
    80007d3c:	f8dff06f          	j	80007cc8 <__printf+0x440>
    80007d40:	f7843783          	ld	a5,-136(s0)
    80007d44:	0007bc83          	ld	s9,0(a5)
    80007d48:	00878793          	addi	a5,a5,8
    80007d4c:	f6f43c23          	sd	a5,-136(s0)
    80007d50:	000c9a63          	bnez	s9,80007d64 <__printf+0x4dc>
    80007d54:	1080006f          	j	80007e5c <__printf+0x5d4>
    80007d58:	001c8c93          	addi	s9,s9,1
    80007d5c:	00000097          	auipc	ra,0x0
    80007d60:	948080e7          	jalr	-1720(ra) # 800076a4 <consputc>
    80007d64:	000cc503          	lbu	a0,0(s9)
    80007d68:	fe0518e3          	bnez	a0,80007d58 <__printf+0x4d0>
    80007d6c:	f5dff06f          	j	80007cc8 <__printf+0x440>
    80007d70:	02500513          	li	a0,37
    80007d74:	00000097          	auipc	ra,0x0
    80007d78:	930080e7          	jalr	-1744(ra) # 800076a4 <consputc>
    80007d7c:	000c8513          	mv	a0,s9
    80007d80:	00000097          	auipc	ra,0x0
    80007d84:	924080e7          	jalr	-1756(ra) # 800076a4 <consputc>
    80007d88:	f41ff06f          	j	80007cc8 <__printf+0x440>
    80007d8c:	02500513          	li	a0,37
    80007d90:	00000097          	auipc	ra,0x0
    80007d94:	914080e7          	jalr	-1772(ra) # 800076a4 <consputc>
    80007d98:	f31ff06f          	j	80007cc8 <__printf+0x440>
    80007d9c:	00030513          	mv	a0,t1
    80007da0:	00000097          	auipc	ra,0x0
    80007da4:	7bc080e7          	jalr	1980(ra) # 8000855c <acquire>
    80007da8:	b4dff06f          	j	800078f4 <__printf+0x6c>
    80007dac:	40c0053b          	negw	a0,a2
    80007db0:	00a00713          	li	a4,10
    80007db4:	02e576bb          	remuw	a3,a0,a4
    80007db8:	00002d97          	auipc	s11,0x2
    80007dbc:	b00d8d93          	addi	s11,s11,-1280 # 800098b8 <digits>
    80007dc0:	ff700593          	li	a1,-9
    80007dc4:	02069693          	slli	a3,a3,0x20
    80007dc8:	0206d693          	srli	a3,a3,0x20
    80007dcc:	00dd86b3          	add	a3,s11,a3
    80007dd0:	0006c683          	lbu	a3,0(a3)
    80007dd4:	02e557bb          	divuw	a5,a0,a4
    80007dd8:	f8d40023          	sb	a3,-128(s0)
    80007ddc:	10b65e63          	bge	a2,a1,80007ef8 <__printf+0x670>
    80007de0:	06300593          	li	a1,99
    80007de4:	02e7f6bb          	remuw	a3,a5,a4
    80007de8:	02069693          	slli	a3,a3,0x20
    80007dec:	0206d693          	srli	a3,a3,0x20
    80007df0:	00dd86b3          	add	a3,s11,a3
    80007df4:	0006c683          	lbu	a3,0(a3)
    80007df8:	02e7d73b          	divuw	a4,a5,a4
    80007dfc:	00200793          	li	a5,2
    80007e00:	f8d400a3          	sb	a3,-127(s0)
    80007e04:	bca5ece3          	bltu	a1,a0,800079dc <__printf+0x154>
    80007e08:	ce5ff06f          	j	80007aec <__printf+0x264>
    80007e0c:	40e007bb          	negw	a5,a4
    80007e10:	00002d97          	auipc	s11,0x2
    80007e14:	aa8d8d93          	addi	s11,s11,-1368 # 800098b8 <digits>
    80007e18:	00f7f693          	andi	a3,a5,15
    80007e1c:	00dd86b3          	add	a3,s11,a3
    80007e20:	0006c583          	lbu	a1,0(a3)
    80007e24:	ff100613          	li	a2,-15
    80007e28:	0047d69b          	srliw	a3,a5,0x4
    80007e2c:	f8b40023          	sb	a1,-128(s0)
    80007e30:	0047d59b          	srliw	a1,a5,0x4
    80007e34:	0ac75e63          	bge	a4,a2,80007ef0 <__printf+0x668>
    80007e38:	00f6f693          	andi	a3,a3,15
    80007e3c:	00dd86b3          	add	a3,s11,a3
    80007e40:	0006c603          	lbu	a2,0(a3)
    80007e44:	00f00693          	li	a3,15
    80007e48:	0087d79b          	srliw	a5,a5,0x8
    80007e4c:	f8c400a3          	sb	a2,-127(s0)
    80007e50:	d8b6e4e3          	bltu	a3,a1,80007bd8 <__printf+0x350>
    80007e54:	00200793          	li	a5,2
    80007e58:	e2dff06f          	j	80007c84 <__printf+0x3fc>
    80007e5c:	00002c97          	auipc	s9,0x2
    80007e60:	a3cc8c93          	addi	s9,s9,-1476 # 80009898 <CONSOLE_STATUS+0x888>
    80007e64:	02800513          	li	a0,40
    80007e68:	ef1ff06f          	j	80007d58 <__printf+0x4d0>
    80007e6c:	00700793          	li	a5,7
    80007e70:	00600c93          	li	s9,6
    80007e74:	e0dff06f          	j	80007c80 <__printf+0x3f8>
    80007e78:	00700793          	li	a5,7
    80007e7c:	00600c93          	li	s9,6
    80007e80:	c69ff06f          	j	80007ae8 <__printf+0x260>
    80007e84:	00300793          	li	a5,3
    80007e88:	00200c93          	li	s9,2
    80007e8c:	c5dff06f          	j	80007ae8 <__printf+0x260>
    80007e90:	00300793          	li	a5,3
    80007e94:	00200c93          	li	s9,2
    80007e98:	de9ff06f          	j	80007c80 <__printf+0x3f8>
    80007e9c:	00400793          	li	a5,4
    80007ea0:	00300c93          	li	s9,3
    80007ea4:	dddff06f          	j	80007c80 <__printf+0x3f8>
    80007ea8:	00400793          	li	a5,4
    80007eac:	00300c93          	li	s9,3
    80007eb0:	c39ff06f          	j	80007ae8 <__printf+0x260>
    80007eb4:	00500793          	li	a5,5
    80007eb8:	00400c93          	li	s9,4
    80007ebc:	c2dff06f          	j	80007ae8 <__printf+0x260>
    80007ec0:	00500793          	li	a5,5
    80007ec4:	00400c93          	li	s9,4
    80007ec8:	db9ff06f          	j	80007c80 <__printf+0x3f8>
    80007ecc:	00600793          	li	a5,6
    80007ed0:	00500c93          	li	s9,5
    80007ed4:	dadff06f          	j	80007c80 <__printf+0x3f8>
    80007ed8:	00600793          	li	a5,6
    80007edc:	00500c93          	li	s9,5
    80007ee0:	c09ff06f          	j	80007ae8 <__printf+0x260>
    80007ee4:	00800793          	li	a5,8
    80007ee8:	00700c93          	li	s9,7
    80007eec:	bfdff06f          	j	80007ae8 <__printf+0x260>
    80007ef0:	00100793          	li	a5,1
    80007ef4:	d91ff06f          	j	80007c84 <__printf+0x3fc>
    80007ef8:	00100793          	li	a5,1
    80007efc:	bf1ff06f          	j	80007aec <__printf+0x264>
    80007f00:	00900793          	li	a5,9
    80007f04:	00800c93          	li	s9,8
    80007f08:	be1ff06f          	j	80007ae8 <__printf+0x260>
    80007f0c:	00002517          	auipc	a0,0x2
    80007f10:	99450513          	addi	a0,a0,-1644 # 800098a0 <CONSOLE_STATUS+0x890>
    80007f14:	00000097          	auipc	ra,0x0
    80007f18:	918080e7          	jalr	-1768(ra) # 8000782c <panic>

0000000080007f1c <printfinit>:
    80007f1c:	fe010113          	addi	sp,sp,-32
    80007f20:	00813823          	sd	s0,16(sp)
    80007f24:	00913423          	sd	s1,8(sp)
    80007f28:	00113c23          	sd	ra,24(sp)
    80007f2c:	02010413          	addi	s0,sp,32
    80007f30:	00005497          	auipc	s1,0x5
    80007f34:	43048493          	addi	s1,s1,1072 # 8000d360 <pr>
    80007f38:	00048513          	mv	a0,s1
    80007f3c:	00002597          	auipc	a1,0x2
    80007f40:	97458593          	addi	a1,a1,-1676 # 800098b0 <CONSOLE_STATUS+0x8a0>
    80007f44:	00000097          	auipc	ra,0x0
    80007f48:	5f4080e7          	jalr	1524(ra) # 80008538 <initlock>
    80007f4c:	01813083          	ld	ra,24(sp)
    80007f50:	01013403          	ld	s0,16(sp)
    80007f54:	0004ac23          	sw	zero,24(s1)
    80007f58:	00813483          	ld	s1,8(sp)
    80007f5c:	02010113          	addi	sp,sp,32
    80007f60:	00008067          	ret

0000000080007f64 <uartinit>:
    80007f64:	ff010113          	addi	sp,sp,-16
    80007f68:	00813423          	sd	s0,8(sp)
    80007f6c:	01010413          	addi	s0,sp,16
    80007f70:	100007b7          	lui	a5,0x10000
    80007f74:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007f78:	f8000713          	li	a4,-128
    80007f7c:	00e781a3          	sb	a4,3(a5)
    80007f80:	00300713          	li	a4,3
    80007f84:	00e78023          	sb	a4,0(a5)
    80007f88:	000780a3          	sb	zero,1(a5)
    80007f8c:	00e781a3          	sb	a4,3(a5)
    80007f90:	00700693          	li	a3,7
    80007f94:	00d78123          	sb	a3,2(a5)
    80007f98:	00e780a3          	sb	a4,1(a5)
    80007f9c:	00813403          	ld	s0,8(sp)
    80007fa0:	01010113          	addi	sp,sp,16
    80007fa4:	00008067          	ret

0000000080007fa8 <uartputc>:
    80007fa8:	00004797          	auipc	a5,0x4
    80007fac:	ef07a783          	lw	a5,-272(a5) # 8000be98 <panicked>
    80007fb0:	00078463          	beqz	a5,80007fb8 <uartputc+0x10>
    80007fb4:	0000006f          	j	80007fb4 <uartputc+0xc>
    80007fb8:	fd010113          	addi	sp,sp,-48
    80007fbc:	02813023          	sd	s0,32(sp)
    80007fc0:	00913c23          	sd	s1,24(sp)
    80007fc4:	01213823          	sd	s2,16(sp)
    80007fc8:	01313423          	sd	s3,8(sp)
    80007fcc:	02113423          	sd	ra,40(sp)
    80007fd0:	03010413          	addi	s0,sp,48
    80007fd4:	00004917          	auipc	s2,0x4
    80007fd8:	ecc90913          	addi	s2,s2,-308 # 8000bea0 <uart_tx_r>
    80007fdc:	00093783          	ld	a5,0(s2)
    80007fe0:	00004497          	auipc	s1,0x4
    80007fe4:	ec848493          	addi	s1,s1,-312 # 8000bea8 <uart_tx_w>
    80007fe8:	0004b703          	ld	a4,0(s1)
    80007fec:	02078693          	addi	a3,a5,32
    80007ff0:	00050993          	mv	s3,a0
    80007ff4:	02e69c63          	bne	a3,a4,8000802c <uartputc+0x84>
    80007ff8:	00001097          	auipc	ra,0x1
    80007ffc:	834080e7          	jalr	-1996(ra) # 8000882c <push_on>
    80008000:	00093783          	ld	a5,0(s2)
    80008004:	0004b703          	ld	a4,0(s1)
    80008008:	02078793          	addi	a5,a5,32
    8000800c:	00e79463          	bne	a5,a4,80008014 <uartputc+0x6c>
    80008010:	0000006f          	j	80008010 <uartputc+0x68>
    80008014:	00001097          	auipc	ra,0x1
    80008018:	88c080e7          	jalr	-1908(ra) # 800088a0 <pop_on>
    8000801c:	00093783          	ld	a5,0(s2)
    80008020:	0004b703          	ld	a4,0(s1)
    80008024:	02078693          	addi	a3,a5,32
    80008028:	fce688e3          	beq	a3,a4,80007ff8 <uartputc+0x50>
    8000802c:	01f77693          	andi	a3,a4,31
    80008030:	00005597          	auipc	a1,0x5
    80008034:	35058593          	addi	a1,a1,848 # 8000d380 <uart_tx_buf>
    80008038:	00d586b3          	add	a3,a1,a3
    8000803c:	00170713          	addi	a4,a4,1
    80008040:	01368023          	sb	s3,0(a3)
    80008044:	00e4b023          	sd	a4,0(s1)
    80008048:	10000637          	lui	a2,0x10000
    8000804c:	02f71063          	bne	a4,a5,8000806c <uartputc+0xc4>
    80008050:	0340006f          	j	80008084 <uartputc+0xdc>
    80008054:	00074703          	lbu	a4,0(a4)
    80008058:	00f93023          	sd	a5,0(s2)
    8000805c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008060:	00093783          	ld	a5,0(s2)
    80008064:	0004b703          	ld	a4,0(s1)
    80008068:	00f70e63          	beq	a4,a5,80008084 <uartputc+0xdc>
    8000806c:	00564683          	lbu	a3,5(a2)
    80008070:	01f7f713          	andi	a4,a5,31
    80008074:	00e58733          	add	a4,a1,a4
    80008078:	0206f693          	andi	a3,a3,32
    8000807c:	00178793          	addi	a5,a5,1
    80008080:	fc069ae3          	bnez	a3,80008054 <uartputc+0xac>
    80008084:	02813083          	ld	ra,40(sp)
    80008088:	02013403          	ld	s0,32(sp)
    8000808c:	01813483          	ld	s1,24(sp)
    80008090:	01013903          	ld	s2,16(sp)
    80008094:	00813983          	ld	s3,8(sp)
    80008098:	03010113          	addi	sp,sp,48
    8000809c:	00008067          	ret

00000000800080a0 <uartputc_sync>:
    800080a0:	ff010113          	addi	sp,sp,-16
    800080a4:	00813423          	sd	s0,8(sp)
    800080a8:	01010413          	addi	s0,sp,16
    800080ac:	00004717          	auipc	a4,0x4
    800080b0:	dec72703          	lw	a4,-532(a4) # 8000be98 <panicked>
    800080b4:	02071663          	bnez	a4,800080e0 <uartputc_sync+0x40>
    800080b8:	00050793          	mv	a5,a0
    800080bc:	100006b7          	lui	a3,0x10000
    800080c0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800080c4:	02077713          	andi	a4,a4,32
    800080c8:	fe070ce3          	beqz	a4,800080c0 <uartputc_sync+0x20>
    800080cc:	0ff7f793          	andi	a5,a5,255
    800080d0:	00f68023          	sb	a5,0(a3)
    800080d4:	00813403          	ld	s0,8(sp)
    800080d8:	01010113          	addi	sp,sp,16
    800080dc:	00008067          	ret
    800080e0:	0000006f          	j	800080e0 <uartputc_sync+0x40>

00000000800080e4 <uartstart>:
    800080e4:	ff010113          	addi	sp,sp,-16
    800080e8:	00813423          	sd	s0,8(sp)
    800080ec:	01010413          	addi	s0,sp,16
    800080f0:	00004617          	auipc	a2,0x4
    800080f4:	db060613          	addi	a2,a2,-592 # 8000bea0 <uart_tx_r>
    800080f8:	00004517          	auipc	a0,0x4
    800080fc:	db050513          	addi	a0,a0,-592 # 8000bea8 <uart_tx_w>
    80008100:	00063783          	ld	a5,0(a2)
    80008104:	00053703          	ld	a4,0(a0)
    80008108:	04f70263          	beq	a4,a5,8000814c <uartstart+0x68>
    8000810c:	100005b7          	lui	a1,0x10000
    80008110:	00005817          	auipc	a6,0x5
    80008114:	27080813          	addi	a6,a6,624 # 8000d380 <uart_tx_buf>
    80008118:	01c0006f          	j	80008134 <uartstart+0x50>
    8000811c:	0006c703          	lbu	a4,0(a3)
    80008120:	00f63023          	sd	a5,0(a2)
    80008124:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008128:	00063783          	ld	a5,0(a2)
    8000812c:	00053703          	ld	a4,0(a0)
    80008130:	00f70e63          	beq	a4,a5,8000814c <uartstart+0x68>
    80008134:	01f7f713          	andi	a4,a5,31
    80008138:	00e806b3          	add	a3,a6,a4
    8000813c:	0055c703          	lbu	a4,5(a1)
    80008140:	00178793          	addi	a5,a5,1
    80008144:	02077713          	andi	a4,a4,32
    80008148:	fc071ae3          	bnez	a4,8000811c <uartstart+0x38>
    8000814c:	00813403          	ld	s0,8(sp)
    80008150:	01010113          	addi	sp,sp,16
    80008154:	00008067          	ret

0000000080008158 <uartgetc>:
    80008158:	ff010113          	addi	sp,sp,-16
    8000815c:	00813423          	sd	s0,8(sp)
    80008160:	01010413          	addi	s0,sp,16
    80008164:	10000737          	lui	a4,0x10000
    80008168:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000816c:	0017f793          	andi	a5,a5,1
    80008170:	00078c63          	beqz	a5,80008188 <uartgetc+0x30>
    80008174:	00074503          	lbu	a0,0(a4)
    80008178:	0ff57513          	andi	a0,a0,255
    8000817c:	00813403          	ld	s0,8(sp)
    80008180:	01010113          	addi	sp,sp,16
    80008184:	00008067          	ret
    80008188:	fff00513          	li	a0,-1
    8000818c:	ff1ff06f          	j	8000817c <uartgetc+0x24>

0000000080008190 <uartintr>:
    80008190:	100007b7          	lui	a5,0x10000
    80008194:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008198:	0017f793          	andi	a5,a5,1
    8000819c:	0a078463          	beqz	a5,80008244 <uartintr+0xb4>
    800081a0:	fe010113          	addi	sp,sp,-32
    800081a4:	00813823          	sd	s0,16(sp)
    800081a8:	00913423          	sd	s1,8(sp)
    800081ac:	00113c23          	sd	ra,24(sp)
    800081b0:	02010413          	addi	s0,sp,32
    800081b4:	100004b7          	lui	s1,0x10000
    800081b8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800081bc:	0ff57513          	andi	a0,a0,255
    800081c0:	fffff097          	auipc	ra,0xfffff
    800081c4:	534080e7          	jalr	1332(ra) # 800076f4 <consoleintr>
    800081c8:	0054c783          	lbu	a5,5(s1)
    800081cc:	0017f793          	andi	a5,a5,1
    800081d0:	fe0794e3          	bnez	a5,800081b8 <uartintr+0x28>
    800081d4:	00004617          	auipc	a2,0x4
    800081d8:	ccc60613          	addi	a2,a2,-820 # 8000bea0 <uart_tx_r>
    800081dc:	00004517          	auipc	a0,0x4
    800081e0:	ccc50513          	addi	a0,a0,-820 # 8000bea8 <uart_tx_w>
    800081e4:	00063783          	ld	a5,0(a2)
    800081e8:	00053703          	ld	a4,0(a0)
    800081ec:	04f70263          	beq	a4,a5,80008230 <uartintr+0xa0>
    800081f0:	100005b7          	lui	a1,0x10000
    800081f4:	00005817          	auipc	a6,0x5
    800081f8:	18c80813          	addi	a6,a6,396 # 8000d380 <uart_tx_buf>
    800081fc:	01c0006f          	j	80008218 <uartintr+0x88>
    80008200:	0006c703          	lbu	a4,0(a3)
    80008204:	00f63023          	sd	a5,0(a2)
    80008208:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000820c:	00063783          	ld	a5,0(a2)
    80008210:	00053703          	ld	a4,0(a0)
    80008214:	00f70e63          	beq	a4,a5,80008230 <uartintr+0xa0>
    80008218:	01f7f713          	andi	a4,a5,31
    8000821c:	00e806b3          	add	a3,a6,a4
    80008220:	0055c703          	lbu	a4,5(a1)
    80008224:	00178793          	addi	a5,a5,1
    80008228:	02077713          	andi	a4,a4,32
    8000822c:	fc071ae3          	bnez	a4,80008200 <uartintr+0x70>
    80008230:	01813083          	ld	ra,24(sp)
    80008234:	01013403          	ld	s0,16(sp)
    80008238:	00813483          	ld	s1,8(sp)
    8000823c:	02010113          	addi	sp,sp,32
    80008240:	00008067          	ret
    80008244:	00004617          	auipc	a2,0x4
    80008248:	c5c60613          	addi	a2,a2,-932 # 8000bea0 <uart_tx_r>
    8000824c:	00004517          	auipc	a0,0x4
    80008250:	c5c50513          	addi	a0,a0,-932 # 8000bea8 <uart_tx_w>
    80008254:	00063783          	ld	a5,0(a2)
    80008258:	00053703          	ld	a4,0(a0)
    8000825c:	04f70263          	beq	a4,a5,800082a0 <uartintr+0x110>
    80008260:	100005b7          	lui	a1,0x10000
    80008264:	00005817          	auipc	a6,0x5
    80008268:	11c80813          	addi	a6,a6,284 # 8000d380 <uart_tx_buf>
    8000826c:	01c0006f          	j	80008288 <uartintr+0xf8>
    80008270:	0006c703          	lbu	a4,0(a3)
    80008274:	00f63023          	sd	a5,0(a2)
    80008278:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000827c:	00063783          	ld	a5,0(a2)
    80008280:	00053703          	ld	a4,0(a0)
    80008284:	02f70063          	beq	a4,a5,800082a4 <uartintr+0x114>
    80008288:	01f7f713          	andi	a4,a5,31
    8000828c:	00e806b3          	add	a3,a6,a4
    80008290:	0055c703          	lbu	a4,5(a1)
    80008294:	00178793          	addi	a5,a5,1
    80008298:	02077713          	andi	a4,a4,32
    8000829c:	fc071ae3          	bnez	a4,80008270 <uartintr+0xe0>
    800082a0:	00008067          	ret
    800082a4:	00008067          	ret

00000000800082a8 <kinit>:
    800082a8:	fc010113          	addi	sp,sp,-64
    800082ac:	02913423          	sd	s1,40(sp)
    800082b0:	fffff7b7          	lui	a5,0xfffff
    800082b4:	00006497          	auipc	s1,0x6
    800082b8:	0eb48493          	addi	s1,s1,235 # 8000e39f <end+0xfff>
    800082bc:	02813823          	sd	s0,48(sp)
    800082c0:	01313c23          	sd	s3,24(sp)
    800082c4:	00f4f4b3          	and	s1,s1,a5
    800082c8:	02113c23          	sd	ra,56(sp)
    800082cc:	03213023          	sd	s2,32(sp)
    800082d0:	01413823          	sd	s4,16(sp)
    800082d4:	01513423          	sd	s5,8(sp)
    800082d8:	04010413          	addi	s0,sp,64
    800082dc:	000017b7          	lui	a5,0x1
    800082e0:	01100993          	li	s3,17
    800082e4:	00f487b3          	add	a5,s1,a5
    800082e8:	01b99993          	slli	s3,s3,0x1b
    800082ec:	06f9e063          	bltu	s3,a5,8000834c <kinit+0xa4>
    800082f0:	00005a97          	auipc	s5,0x5
    800082f4:	0b0a8a93          	addi	s5,s5,176 # 8000d3a0 <end>
    800082f8:	0754ec63          	bltu	s1,s5,80008370 <kinit+0xc8>
    800082fc:	0734fa63          	bgeu	s1,s3,80008370 <kinit+0xc8>
    80008300:	00088a37          	lui	s4,0x88
    80008304:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008308:	00004917          	auipc	s2,0x4
    8000830c:	ba890913          	addi	s2,s2,-1112 # 8000beb0 <kmem>
    80008310:	00ca1a13          	slli	s4,s4,0xc
    80008314:	0140006f          	j	80008328 <kinit+0x80>
    80008318:	000017b7          	lui	a5,0x1
    8000831c:	00f484b3          	add	s1,s1,a5
    80008320:	0554e863          	bltu	s1,s5,80008370 <kinit+0xc8>
    80008324:	0534f663          	bgeu	s1,s3,80008370 <kinit+0xc8>
    80008328:	00001637          	lui	a2,0x1
    8000832c:	00100593          	li	a1,1
    80008330:	00048513          	mv	a0,s1
    80008334:	00000097          	auipc	ra,0x0
    80008338:	5e4080e7          	jalr	1508(ra) # 80008918 <__memset>
    8000833c:	00093783          	ld	a5,0(s2)
    80008340:	00f4b023          	sd	a5,0(s1)
    80008344:	00993023          	sd	s1,0(s2)
    80008348:	fd4498e3          	bne	s1,s4,80008318 <kinit+0x70>
    8000834c:	03813083          	ld	ra,56(sp)
    80008350:	03013403          	ld	s0,48(sp)
    80008354:	02813483          	ld	s1,40(sp)
    80008358:	02013903          	ld	s2,32(sp)
    8000835c:	01813983          	ld	s3,24(sp)
    80008360:	01013a03          	ld	s4,16(sp)
    80008364:	00813a83          	ld	s5,8(sp)
    80008368:	04010113          	addi	sp,sp,64
    8000836c:	00008067          	ret
    80008370:	00001517          	auipc	a0,0x1
    80008374:	56050513          	addi	a0,a0,1376 # 800098d0 <digits+0x18>
    80008378:	fffff097          	auipc	ra,0xfffff
    8000837c:	4b4080e7          	jalr	1204(ra) # 8000782c <panic>

0000000080008380 <freerange>:
    80008380:	fc010113          	addi	sp,sp,-64
    80008384:	000017b7          	lui	a5,0x1
    80008388:	02913423          	sd	s1,40(sp)
    8000838c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80008390:	009504b3          	add	s1,a0,s1
    80008394:	fffff537          	lui	a0,0xfffff
    80008398:	02813823          	sd	s0,48(sp)
    8000839c:	02113c23          	sd	ra,56(sp)
    800083a0:	03213023          	sd	s2,32(sp)
    800083a4:	01313c23          	sd	s3,24(sp)
    800083a8:	01413823          	sd	s4,16(sp)
    800083ac:	01513423          	sd	s5,8(sp)
    800083b0:	01613023          	sd	s6,0(sp)
    800083b4:	04010413          	addi	s0,sp,64
    800083b8:	00a4f4b3          	and	s1,s1,a0
    800083bc:	00f487b3          	add	a5,s1,a5
    800083c0:	06f5e463          	bltu	a1,a5,80008428 <freerange+0xa8>
    800083c4:	00005a97          	auipc	s5,0x5
    800083c8:	fdca8a93          	addi	s5,s5,-36 # 8000d3a0 <end>
    800083cc:	0954e263          	bltu	s1,s5,80008450 <freerange+0xd0>
    800083d0:	01100993          	li	s3,17
    800083d4:	01b99993          	slli	s3,s3,0x1b
    800083d8:	0734fc63          	bgeu	s1,s3,80008450 <freerange+0xd0>
    800083dc:	00058a13          	mv	s4,a1
    800083e0:	00004917          	auipc	s2,0x4
    800083e4:	ad090913          	addi	s2,s2,-1328 # 8000beb0 <kmem>
    800083e8:	00002b37          	lui	s6,0x2
    800083ec:	0140006f          	j	80008400 <freerange+0x80>
    800083f0:	000017b7          	lui	a5,0x1
    800083f4:	00f484b3          	add	s1,s1,a5
    800083f8:	0554ec63          	bltu	s1,s5,80008450 <freerange+0xd0>
    800083fc:	0534fa63          	bgeu	s1,s3,80008450 <freerange+0xd0>
    80008400:	00001637          	lui	a2,0x1
    80008404:	00100593          	li	a1,1
    80008408:	00048513          	mv	a0,s1
    8000840c:	00000097          	auipc	ra,0x0
    80008410:	50c080e7          	jalr	1292(ra) # 80008918 <__memset>
    80008414:	00093703          	ld	a4,0(s2)
    80008418:	016487b3          	add	a5,s1,s6
    8000841c:	00e4b023          	sd	a4,0(s1)
    80008420:	00993023          	sd	s1,0(s2)
    80008424:	fcfa76e3          	bgeu	s4,a5,800083f0 <freerange+0x70>
    80008428:	03813083          	ld	ra,56(sp)
    8000842c:	03013403          	ld	s0,48(sp)
    80008430:	02813483          	ld	s1,40(sp)
    80008434:	02013903          	ld	s2,32(sp)
    80008438:	01813983          	ld	s3,24(sp)
    8000843c:	01013a03          	ld	s4,16(sp)
    80008440:	00813a83          	ld	s5,8(sp)
    80008444:	00013b03          	ld	s6,0(sp)
    80008448:	04010113          	addi	sp,sp,64
    8000844c:	00008067          	ret
    80008450:	00001517          	auipc	a0,0x1
    80008454:	48050513          	addi	a0,a0,1152 # 800098d0 <digits+0x18>
    80008458:	fffff097          	auipc	ra,0xfffff
    8000845c:	3d4080e7          	jalr	980(ra) # 8000782c <panic>

0000000080008460 <kfree>:
    80008460:	fe010113          	addi	sp,sp,-32
    80008464:	00813823          	sd	s0,16(sp)
    80008468:	00113c23          	sd	ra,24(sp)
    8000846c:	00913423          	sd	s1,8(sp)
    80008470:	02010413          	addi	s0,sp,32
    80008474:	03451793          	slli	a5,a0,0x34
    80008478:	04079c63          	bnez	a5,800084d0 <kfree+0x70>
    8000847c:	00005797          	auipc	a5,0x5
    80008480:	f2478793          	addi	a5,a5,-220 # 8000d3a0 <end>
    80008484:	00050493          	mv	s1,a0
    80008488:	04f56463          	bltu	a0,a5,800084d0 <kfree+0x70>
    8000848c:	01100793          	li	a5,17
    80008490:	01b79793          	slli	a5,a5,0x1b
    80008494:	02f57e63          	bgeu	a0,a5,800084d0 <kfree+0x70>
    80008498:	00001637          	lui	a2,0x1
    8000849c:	00100593          	li	a1,1
    800084a0:	00000097          	auipc	ra,0x0
    800084a4:	478080e7          	jalr	1144(ra) # 80008918 <__memset>
    800084a8:	00004797          	auipc	a5,0x4
    800084ac:	a0878793          	addi	a5,a5,-1528 # 8000beb0 <kmem>
    800084b0:	0007b703          	ld	a4,0(a5)
    800084b4:	01813083          	ld	ra,24(sp)
    800084b8:	01013403          	ld	s0,16(sp)
    800084bc:	00e4b023          	sd	a4,0(s1)
    800084c0:	0097b023          	sd	s1,0(a5)
    800084c4:	00813483          	ld	s1,8(sp)
    800084c8:	02010113          	addi	sp,sp,32
    800084cc:	00008067          	ret
    800084d0:	00001517          	auipc	a0,0x1
    800084d4:	40050513          	addi	a0,a0,1024 # 800098d0 <digits+0x18>
    800084d8:	fffff097          	auipc	ra,0xfffff
    800084dc:	354080e7          	jalr	852(ra) # 8000782c <panic>

00000000800084e0 <kalloc>:
    800084e0:	fe010113          	addi	sp,sp,-32
    800084e4:	00813823          	sd	s0,16(sp)
    800084e8:	00913423          	sd	s1,8(sp)
    800084ec:	00113c23          	sd	ra,24(sp)
    800084f0:	02010413          	addi	s0,sp,32
    800084f4:	00004797          	auipc	a5,0x4
    800084f8:	9bc78793          	addi	a5,a5,-1604 # 8000beb0 <kmem>
    800084fc:	0007b483          	ld	s1,0(a5)
    80008500:	02048063          	beqz	s1,80008520 <kalloc+0x40>
    80008504:	0004b703          	ld	a4,0(s1)
    80008508:	00001637          	lui	a2,0x1
    8000850c:	00500593          	li	a1,5
    80008510:	00048513          	mv	a0,s1
    80008514:	00e7b023          	sd	a4,0(a5)
    80008518:	00000097          	auipc	ra,0x0
    8000851c:	400080e7          	jalr	1024(ra) # 80008918 <__memset>
    80008520:	01813083          	ld	ra,24(sp)
    80008524:	01013403          	ld	s0,16(sp)
    80008528:	00048513          	mv	a0,s1
    8000852c:	00813483          	ld	s1,8(sp)
    80008530:	02010113          	addi	sp,sp,32
    80008534:	00008067          	ret

0000000080008538 <initlock>:
    80008538:	ff010113          	addi	sp,sp,-16
    8000853c:	00813423          	sd	s0,8(sp)
    80008540:	01010413          	addi	s0,sp,16
    80008544:	00813403          	ld	s0,8(sp)
    80008548:	00b53423          	sd	a1,8(a0)
    8000854c:	00052023          	sw	zero,0(a0)
    80008550:	00053823          	sd	zero,16(a0)
    80008554:	01010113          	addi	sp,sp,16
    80008558:	00008067          	ret

000000008000855c <acquire>:
    8000855c:	fe010113          	addi	sp,sp,-32
    80008560:	00813823          	sd	s0,16(sp)
    80008564:	00913423          	sd	s1,8(sp)
    80008568:	00113c23          	sd	ra,24(sp)
    8000856c:	01213023          	sd	s2,0(sp)
    80008570:	02010413          	addi	s0,sp,32
    80008574:	00050493          	mv	s1,a0
    80008578:	10002973          	csrr	s2,sstatus
    8000857c:	100027f3          	csrr	a5,sstatus
    80008580:	ffd7f793          	andi	a5,a5,-3
    80008584:	10079073          	csrw	sstatus,a5
    80008588:	fffff097          	auipc	ra,0xfffff
    8000858c:	8e0080e7          	jalr	-1824(ra) # 80006e68 <mycpu>
    80008590:	07852783          	lw	a5,120(a0)
    80008594:	06078e63          	beqz	a5,80008610 <acquire+0xb4>
    80008598:	fffff097          	auipc	ra,0xfffff
    8000859c:	8d0080e7          	jalr	-1840(ra) # 80006e68 <mycpu>
    800085a0:	07852783          	lw	a5,120(a0)
    800085a4:	0004a703          	lw	a4,0(s1)
    800085a8:	0017879b          	addiw	a5,a5,1
    800085ac:	06f52c23          	sw	a5,120(a0)
    800085b0:	04071063          	bnez	a4,800085f0 <acquire+0x94>
    800085b4:	00100713          	li	a4,1
    800085b8:	00070793          	mv	a5,a4
    800085bc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800085c0:	0007879b          	sext.w	a5,a5
    800085c4:	fe079ae3          	bnez	a5,800085b8 <acquire+0x5c>
    800085c8:	0ff0000f          	fence
    800085cc:	fffff097          	auipc	ra,0xfffff
    800085d0:	89c080e7          	jalr	-1892(ra) # 80006e68 <mycpu>
    800085d4:	01813083          	ld	ra,24(sp)
    800085d8:	01013403          	ld	s0,16(sp)
    800085dc:	00a4b823          	sd	a0,16(s1)
    800085e0:	00013903          	ld	s2,0(sp)
    800085e4:	00813483          	ld	s1,8(sp)
    800085e8:	02010113          	addi	sp,sp,32
    800085ec:	00008067          	ret
    800085f0:	0104b903          	ld	s2,16(s1)
    800085f4:	fffff097          	auipc	ra,0xfffff
    800085f8:	874080e7          	jalr	-1932(ra) # 80006e68 <mycpu>
    800085fc:	faa91ce3          	bne	s2,a0,800085b4 <acquire+0x58>
    80008600:	00001517          	auipc	a0,0x1
    80008604:	2d850513          	addi	a0,a0,728 # 800098d8 <digits+0x20>
    80008608:	fffff097          	auipc	ra,0xfffff
    8000860c:	224080e7          	jalr	548(ra) # 8000782c <panic>
    80008610:	00195913          	srli	s2,s2,0x1
    80008614:	fffff097          	auipc	ra,0xfffff
    80008618:	854080e7          	jalr	-1964(ra) # 80006e68 <mycpu>
    8000861c:	00197913          	andi	s2,s2,1
    80008620:	07252e23          	sw	s2,124(a0)
    80008624:	f75ff06f          	j	80008598 <acquire+0x3c>

0000000080008628 <release>:
    80008628:	fe010113          	addi	sp,sp,-32
    8000862c:	00813823          	sd	s0,16(sp)
    80008630:	00113c23          	sd	ra,24(sp)
    80008634:	00913423          	sd	s1,8(sp)
    80008638:	01213023          	sd	s2,0(sp)
    8000863c:	02010413          	addi	s0,sp,32
    80008640:	00052783          	lw	a5,0(a0)
    80008644:	00079a63          	bnez	a5,80008658 <release+0x30>
    80008648:	00001517          	auipc	a0,0x1
    8000864c:	29850513          	addi	a0,a0,664 # 800098e0 <digits+0x28>
    80008650:	fffff097          	auipc	ra,0xfffff
    80008654:	1dc080e7          	jalr	476(ra) # 8000782c <panic>
    80008658:	01053903          	ld	s2,16(a0)
    8000865c:	00050493          	mv	s1,a0
    80008660:	fffff097          	auipc	ra,0xfffff
    80008664:	808080e7          	jalr	-2040(ra) # 80006e68 <mycpu>
    80008668:	fea910e3          	bne	s2,a0,80008648 <release+0x20>
    8000866c:	0004b823          	sd	zero,16(s1)
    80008670:	0ff0000f          	fence
    80008674:	0f50000f          	fence	iorw,ow
    80008678:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000867c:	ffffe097          	auipc	ra,0xffffe
    80008680:	7ec080e7          	jalr	2028(ra) # 80006e68 <mycpu>
    80008684:	100027f3          	csrr	a5,sstatus
    80008688:	0027f793          	andi	a5,a5,2
    8000868c:	04079a63          	bnez	a5,800086e0 <release+0xb8>
    80008690:	07852783          	lw	a5,120(a0)
    80008694:	02f05e63          	blez	a5,800086d0 <release+0xa8>
    80008698:	fff7871b          	addiw	a4,a5,-1
    8000869c:	06e52c23          	sw	a4,120(a0)
    800086a0:	00071c63          	bnez	a4,800086b8 <release+0x90>
    800086a4:	07c52783          	lw	a5,124(a0)
    800086a8:	00078863          	beqz	a5,800086b8 <release+0x90>
    800086ac:	100027f3          	csrr	a5,sstatus
    800086b0:	0027e793          	ori	a5,a5,2
    800086b4:	10079073          	csrw	sstatus,a5
    800086b8:	01813083          	ld	ra,24(sp)
    800086bc:	01013403          	ld	s0,16(sp)
    800086c0:	00813483          	ld	s1,8(sp)
    800086c4:	00013903          	ld	s2,0(sp)
    800086c8:	02010113          	addi	sp,sp,32
    800086cc:	00008067          	ret
    800086d0:	00001517          	auipc	a0,0x1
    800086d4:	23050513          	addi	a0,a0,560 # 80009900 <digits+0x48>
    800086d8:	fffff097          	auipc	ra,0xfffff
    800086dc:	154080e7          	jalr	340(ra) # 8000782c <panic>
    800086e0:	00001517          	auipc	a0,0x1
    800086e4:	20850513          	addi	a0,a0,520 # 800098e8 <digits+0x30>
    800086e8:	fffff097          	auipc	ra,0xfffff
    800086ec:	144080e7          	jalr	324(ra) # 8000782c <panic>

00000000800086f0 <holding>:
    800086f0:	00052783          	lw	a5,0(a0)
    800086f4:	00079663          	bnez	a5,80008700 <holding+0x10>
    800086f8:	00000513          	li	a0,0
    800086fc:	00008067          	ret
    80008700:	fe010113          	addi	sp,sp,-32
    80008704:	00813823          	sd	s0,16(sp)
    80008708:	00913423          	sd	s1,8(sp)
    8000870c:	00113c23          	sd	ra,24(sp)
    80008710:	02010413          	addi	s0,sp,32
    80008714:	01053483          	ld	s1,16(a0)
    80008718:	ffffe097          	auipc	ra,0xffffe
    8000871c:	750080e7          	jalr	1872(ra) # 80006e68 <mycpu>
    80008720:	01813083          	ld	ra,24(sp)
    80008724:	01013403          	ld	s0,16(sp)
    80008728:	40a48533          	sub	a0,s1,a0
    8000872c:	00153513          	seqz	a0,a0
    80008730:	00813483          	ld	s1,8(sp)
    80008734:	02010113          	addi	sp,sp,32
    80008738:	00008067          	ret

000000008000873c <push_off>:
    8000873c:	fe010113          	addi	sp,sp,-32
    80008740:	00813823          	sd	s0,16(sp)
    80008744:	00113c23          	sd	ra,24(sp)
    80008748:	00913423          	sd	s1,8(sp)
    8000874c:	02010413          	addi	s0,sp,32
    80008750:	100024f3          	csrr	s1,sstatus
    80008754:	100027f3          	csrr	a5,sstatus
    80008758:	ffd7f793          	andi	a5,a5,-3
    8000875c:	10079073          	csrw	sstatus,a5
    80008760:	ffffe097          	auipc	ra,0xffffe
    80008764:	708080e7          	jalr	1800(ra) # 80006e68 <mycpu>
    80008768:	07852783          	lw	a5,120(a0)
    8000876c:	02078663          	beqz	a5,80008798 <push_off+0x5c>
    80008770:	ffffe097          	auipc	ra,0xffffe
    80008774:	6f8080e7          	jalr	1784(ra) # 80006e68 <mycpu>
    80008778:	07852783          	lw	a5,120(a0)
    8000877c:	01813083          	ld	ra,24(sp)
    80008780:	01013403          	ld	s0,16(sp)
    80008784:	0017879b          	addiw	a5,a5,1
    80008788:	06f52c23          	sw	a5,120(a0)
    8000878c:	00813483          	ld	s1,8(sp)
    80008790:	02010113          	addi	sp,sp,32
    80008794:	00008067          	ret
    80008798:	0014d493          	srli	s1,s1,0x1
    8000879c:	ffffe097          	auipc	ra,0xffffe
    800087a0:	6cc080e7          	jalr	1740(ra) # 80006e68 <mycpu>
    800087a4:	0014f493          	andi	s1,s1,1
    800087a8:	06952e23          	sw	s1,124(a0)
    800087ac:	fc5ff06f          	j	80008770 <push_off+0x34>

00000000800087b0 <pop_off>:
    800087b0:	ff010113          	addi	sp,sp,-16
    800087b4:	00813023          	sd	s0,0(sp)
    800087b8:	00113423          	sd	ra,8(sp)
    800087bc:	01010413          	addi	s0,sp,16
    800087c0:	ffffe097          	auipc	ra,0xffffe
    800087c4:	6a8080e7          	jalr	1704(ra) # 80006e68 <mycpu>
    800087c8:	100027f3          	csrr	a5,sstatus
    800087cc:	0027f793          	andi	a5,a5,2
    800087d0:	04079663          	bnez	a5,8000881c <pop_off+0x6c>
    800087d4:	07852783          	lw	a5,120(a0)
    800087d8:	02f05a63          	blez	a5,8000880c <pop_off+0x5c>
    800087dc:	fff7871b          	addiw	a4,a5,-1
    800087e0:	06e52c23          	sw	a4,120(a0)
    800087e4:	00071c63          	bnez	a4,800087fc <pop_off+0x4c>
    800087e8:	07c52783          	lw	a5,124(a0)
    800087ec:	00078863          	beqz	a5,800087fc <pop_off+0x4c>
    800087f0:	100027f3          	csrr	a5,sstatus
    800087f4:	0027e793          	ori	a5,a5,2
    800087f8:	10079073          	csrw	sstatus,a5
    800087fc:	00813083          	ld	ra,8(sp)
    80008800:	00013403          	ld	s0,0(sp)
    80008804:	01010113          	addi	sp,sp,16
    80008808:	00008067          	ret
    8000880c:	00001517          	auipc	a0,0x1
    80008810:	0f450513          	addi	a0,a0,244 # 80009900 <digits+0x48>
    80008814:	fffff097          	auipc	ra,0xfffff
    80008818:	018080e7          	jalr	24(ra) # 8000782c <panic>
    8000881c:	00001517          	auipc	a0,0x1
    80008820:	0cc50513          	addi	a0,a0,204 # 800098e8 <digits+0x30>
    80008824:	fffff097          	auipc	ra,0xfffff
    80008828:	008080e7          	jalr	8(ra) # 8000782c <panic>

000000008000882c <push_on>:
    8000882c:	fe010113          	addi	sp,sp,-32
    80008830:	00813823          	sd	s0,16(sp)
    80008834:	00113c23          	sd	ra,24(sp)
    80008838:	00913423          	sd	s1,8(sp)
    8000883c:	02010413          	addi	s0,sp,32
    80008840:	100024f3          	csrr	s1,sstatus
    80008844:	100027f3          	csrr	a5,sstatus
    80008848:	0027e793          	ori	a5,a5,2
    8000884c:	10079073          	csrw	sstatus,a5
    80008850:	ffffe097          	auipc	ra,0xffffe
    80008854:	618080e7          	jalr	1560(ra) # 80006e68 <mycpu>
    80008858:	07852783          	lw	a5,120(a0)
    8000885c:	02078663          	beqz	a5,80008888 <push_on+0x5c>
    80008860:	ffffe097          	auipc	ra,0xffffe
    80008864:	608080e7          	jalr	1544(ra) # 80006e68 <mycpu>
    80008868:	07852783          	lw	a5,120(a0)
    8000886c:	01813083          	ld	ra,24(sp)
    80008870:	01013403          	ld	s0,16(sp)
    80008874:	0017879b          	addiw	a5,a5,1
    80008878:	06f52c23          	sw	a5,120(a0)
    8000887c:	00813483          	ld	s1,8(sp)
    80008880:	02010113          	addi	sp,sp,32
    80008884:	00008067          	ret
    80008888:	0014d493          	srli	s1,s1,0x1
    8000888c:	ffffe097          	auipc	ra,0xffffe
    80008890:	5dc080e7          	jalr	1500(ra) # 80006e68 <mycpu>
    80008894:	0014f493          	andi	s1,s1,1
    80008898:	06952e23          	sw	s1,124(a0)
    8000889c:	fc5ff06f          	j	80008860 <push_on+0x34>

00000000800088a0 <pop_on>:
    800088a0:	ff010113          	addi	sp,sp,-16
    800088a4:	00813023          	sd	s0,0(sp)
    800088a8:	00113423          	sd	ra,8(sp)
    800088ac:	01010413          	addi	s0,sp,16
    800088b0:	ffffe097          	auipc	ra,0xffffe
    800088b4:	5b8080e7          	jalr	1464(ra) # 80006e68 <mycpu>
    800088b8:	100027f3          	csrr	a5,sstatus
    800088bc:	0027f793          	andi	a5,a5,2
    800088c0:	04078463          	beqz	a5,80008908 <pop_on+0x68>
    800088c4:	07852783          	lw	a5,120(a0)
    800088c8:	02f05863          	blez	a5,800088f8 <pop_on+0x58>
    800088cc:	fff7879b          	addiw	a5,a5,-1
    800088d0:	06f52c23          	sw	a5,120(a0)
    800088d4:	07853783          	ld	a5,120(a0)
    800088d8:	00079863          	bnez	a5,800088e8 <pop_on+0x48>
    800088dc:	100027f3          	csrr	a5,sstatus
    800088e0:	ffd7f793          	andi	a5,a5,-3
    800088e4:	10079073          	csrw	sstatus,a5
    800088e8:	00813083          	ld	ra,8(sp)
    800088ec:	00013403          	ld	s0,0(sp)
    800088f0:	01010113          	addi	sp,sp,16
    800088f4:	00008067          	ret
    800088f8:	00001517          	auipc	a0,0x1
    800088fc:	03050513          	addi	a0,a0,48 # 80009928 <digits+0x70>
    80008900:	fffff097          	auipc	ra,0xfffff
    80008904:	f2c080e7          	jalr	-212(ra) # 8000782c <panic>
    80008908:	00001517          	auipc	a0,0x1
    8000890c:	00050513          	mv	a0,a0
    80008910:	fffff097          	auipc	ra,0xfffff
    80008914:	f1c080e7          	jalr	-228(ra) # 8000782c <panic>

0000000080008918 <__memset>:
    80008918:	ff010113          	addi	sp,sp,-16
    8000891c:	00813423          	sd	s0,8(sp)
    80008920:	01010413          	addi	s0,sp,16
    80008924:	1a060e63          	beqz	a2,80008ae0 <__memset+0x1c8>
    80008928:	40a007b3          	neg	a5,a0
    8000892c:	0077f793          	andi	a5,a5,7
    80008930:	00778693          	addi	a3,a5,7
    80008934:	00b00813          	li	a6,11
    80008938:	0ff5f593          	andi	a1,a1,255
    8000893c:	fff6071b          	addiw	a4,a2,-1
    80008940:	1b06e663          	bltu	a3,a6,80008aec <__memset+0x1d4>
    80008944:	1cd76463          	bltu	a4,a3,80008b0c <__memset+0x1f4>
    80008948:	1a078e63          	beqz	a5,80008b04 <__memset+0x1ec>
    8000894c:	00b50023          	sb	a1,0(a0) # 80009908 <digits+0x50>
    80008950:	00100713          	li	a4,1
    80008954:	1ae78463          	beq	a5,a4,80008afc <__memset+0x1e4>
    80008958:	00b500a3          	sb	a1,1(a0)
    8000895c:	00200713          	li	a4,2
    80008960:	1ae78a63          	beq	a5,a4,80008b14 <__memset+0x1fc>
    80008964:	00b50123          	sb	a1,2(a0)
    80008968:	00300713          	li	a4,3
    8000896c:	18e78463          	beq	a5,a4,80008af4 <__memset+0x1dc>
    80008970:	00b501a3          	sb	a1,3(a0)
    80008974:	00400713          	li	a4,4
    80008978:	1ae78263          	beq	a5,a4,80008b1c <__memset+0x204>
    8000897c:	00b50223          	sb	a1,4(a0)
    80008980:	00500713          	li	a4,5
    80008984:	1ae78063          	beq	a5,a4,80008b24 <__memset+0x20c>
    80008988:	00b502a3          	sb	a1,5(a0)
    8000898c:	00700713          	li	a4,7
    80008990:	18e79e63          	bne	a5,a4,80008b2c <__memset+0x214>
    80008994:	00b50323          	sb	a1,6(a0)
    80008998:	00700e93          	li	t4,7
    8000899c:	00859713          	slli	a4,a1,0x8
    800089a0:	00e5e733          	or	a4,a1,a4
    800089a4:	01059e13          	slli	t3,a1,0x10
    800089a8:	01c76e33          	or	t3,a4,t3
    800089ac:	01859313          	slli	t1,a1,0x18
    800089b0:	006e6333          	or	t1,t3,t1
    800089b4:	02059893          	slli	a7,a1,0x20
    800089b8:	40f60e3b          	subw	t3,a2,a5
    800089bc:	011368b3          	or	a7,t1,a7
    800089c0:	02859813          	slli	a6,a1,0x28
    800089c4:	0108e833          	or	a6,a7,a6
    800089c8:	03059693          	slli	a3,a1,0x30
    800089cc:	003e589b          	srliw	a7,t3,0x3
    800089d0:	00d866b3          	or	a3,a6,a3
    800089d4:	03859713          	slli	a4,a1,0x38
    800089d8:	00389813          	slli	a6,a7,0x3
    800089dc:	00f507b3          	add	a5,a0,a5
    800089e0:	00e6e733          	or	a4,a3,a4
    800089e4:	000e089b          	sext.w	a7,t3
    800089e8:	00f806b3          	add	a3,a6,a5
    800089ec:	00e7b023          	sd	a4,0(a5)
    800089f0:	00878793          	addi	a5,a5,8
    800089f4:	fed79ce3          	bne	a5,a3,800089ec <__memset+0xd4>
    800089f8:	ff8e7793          	andi	a5,t3,-8
    800089fc:	0007871b          	sext.w	a4,a5
    80008a00:	01d787bb          	addw	a5,a5,t4
    80008a04:	0ce88e63          	beq	a7,a4,80008ae0 <__memset+0x1c8>
    80008a08:	00f50733          	add	a4,a0,a5
    80008a0c:	00b70023          	sb	a1,0(a4)
    80008a10:	0017871b          	addiw	a4,a5,1
    80008a14:	0cc77663          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a18:	00e50733          	add	a4,a0,a4
    80008a1c:	00b70023          	sb	a1,0(a4)
    80008a20:	0027871b          	addiw	a4,a5,2
    80008a24:	0ac77e63          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a28:	00e50733          	add	a4,a0,a4
    80008a2c:	00b70023          	sb	a1,0(a4)
    80008a30:	0037871b          	addiw	a4,a5,3
    80008a34:	0ac77663          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a38:	00e50733          	add	a4,a0,a4
    80008a3c:	00b70023          	sb	a1,0(a4)
    80008a40:	0047871b          	addiw	a4,a5,4
    80008a44:	08c77e63          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a48:	00e50733          	add	a4,a0,a4
    80008a4c:	00b70023          	sb	a1,0(a4)
    80008a50:	0057871b          	addiw	a4,a5,5
    80008a54:	08c77663          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a58:	00e50733          	add	a4,a0,a4
    80008a5c:	00b70023          	sb	a1,0(a4)
    80008a60:	0067871b          	addiw	a4,a5,6
    80008a64:	06c77e63          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a68:	00e50733          	add	a4,a0,a4
    80008a6c:	00b70023          	sb	a1,0(a4)
    80008a70:	0077871b          	addiw	a4,a5,7
    80008a74:	06c77663          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a78:	00e50733          	add	a4,a0,a4
    80008a7c:	00b70023          	sb	a1,0(a4)
    80008a80:	0087871b          	addiw	a4,a5,8
    80008a84:	04c77e63          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a88:	00e50733          	add	a4,a0,a4
    80008a8c:	00b70023          	sb	a1,0(a4)
    80008a90:	0097871b          	addiw	a4,a5,9
    80008a94:	04c77663          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008a98:	00e50733          	add	a4,a0,a4
    80008a9c:	00b70023          	sb	a1,0(a4)
    80008aa0:	00a7871b          	addiw	a4,a5,10
    80008aa4:	02c77e63          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008aa8:	00e50733          	add	a4,a0,a4
    80008aac:	00b70023          	sb	a1,0(a4)
    80008ab0:	00b7871b          	addiw	a4,a5,11
    80008ab4:	02c77663          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008ab8:	00e50733          	add	a4,a0,a4
    80008abc:	00b70023          	sb	a1,0(a4)
    80008ac0:	00c7871b          	addiw	a4,a5,12
    80008ac4:	00c77e63          	bgeu	a4,a2,80008ae0 <__memset+0x1c8>
    80008ac8:	00e50733          	add	a4,a0,a4
    80008acc:	00b70023          	sb	a1,0(a4)
    80008ad0:	00d7879b          	addiw	a5,a5,13
    80008ad4:	00c7f663          	bgeu	a5,a2,80008ae0 <__memset+0x1c8>
    80008ad8:	00f507b3          	add	a5,a0,a5
    80008adc:	00b78023          	sb	a1,0(a5)
    80008ae0:	00813403          	ld	s0,8(sp)
    80008ae4:	01010113          	addi	sp,sp,16
    80008ae8:	00008067          	ret
    80008aec:	00b00693          	li	a3,11
    80008af0:	e55ff06f          	j	80008944 <__memset+0x2c>
    80008af4:	00300e93          	li	t4,3
    80008af8:	ea5ff06f          	j	8000899c <__memset+0x84>
    80008afc:	00100e93          	li	t4,1
    80008b00:	e9dff06f          	j	8000899c <__memset+0x84>
    80008b04:	00000e93          	li	t4,0
    80008b08:	e95ff06f          	j	8000899c <__memset+0x84>
    80008b0c:	00000793          	li	a5,0
    80008b10:	ef9ff06f          	j	80008a08 <__memset+0xf0>
    80008b14:	00200e93          	li	t4,2
    80008b18:	e85ff06f          	j	8000899c <__memset+0x84>
    80008b1c:	00400e93          	li	t4,4
    80008b20:	e7dff06f          	j	8000899c <__memset+0x84>
    80008b24:	00500e93          	li	t4,5
    80008b28:	e75ff06f          	j	8000899c <__memset+0x84>
    80008b2c:	00600e93          	li	t4,6
    80008b30:	e6dff06f          	j	8000899c <__memset+0x84>

0000000080008b34 <__memmove>:
    80008b34:	ff010113          	addi	sp,sp,-16
    80008b38:	00813423          	sd	s0,8(sp)
    80008b3c:	01010413          	addi	s0,sp,16
    80008b40:	0e060863          	beqz	a2,80008c30 <__memmove+0xfc>
    80008b44:	fff6069b          	addiw	a3,a2,-1
    80008b48:	0006881b          	sext.w	a6,a3
    80008b4c:	0ea5e863          	bltu	a1,a0,80008c3c <__memmove+0x108>
    80008b50:	00758713          	addi	a4,a1,7
    80008b54:	00a5e7b3          	or	a5,a1,a0
    80008b58:	40a70733          	sub	a4,a4,a0
    80008b5c:	0077f793          	andi	a5,a5,7
    80008b60:	00f73713          	sltiu	a4,a4,15
    80008b64:	00174713          	xori	a4,a4,1
    80008b68:	0017b793          	seqz	a5,a5
    80008b6c:	00e7f7b3          	and	a5,a5,a4
    80008b70:	10078863          	beqz	a5,80008c80 <__memmove+0x14c>
    80008b74:	00900793          	li	a5,9
    80008b78:	1107f463          	bgeu	a5,a6,80008c80 <__memmove+0x14c>
    80008b7c:	0036581b          	srliw	a6,a2,0x3
    80008b80:	fff8081b          	addiw	a6,a6,-1
    80008b84:	02081813          	slli	a6,a6,0x20
    80008b88:	01d85893          	srli	a7,a6,0x1d
    80008b8c:	00858813          	addi	a6,a1,8
    80008b90:	00058793          	mv	a5,a1
    80008b94:	00050713          	mv	a4,a0
    80008b98:	01088833          	add	a6,a7,a6
    80008b9c:	0007b883          	ld	a7,0(a5)
    80008ba0:	00878793          	addi	a5,a5,8
    80008ba4:	00870713          	addi	a4,a4,8
    80008ba8:	ff173c23          	sd	a7,-8(a4)
    80008bac:	ff0798e3          	bne	a5,a6,80008b9c <__memmove+0x68>
    80008bb0:	ff867713          	andi	a4,a2,-8
    80008bb4:	02071793          	slli	a5,a4,0x20
    80008bb8:	0207d793          	srli	a5,a5,0x20
    80008bbc:	00f585b3          	add	a1,a1,a5
    80008bc0:	40e686bb          	subw	a3,a3,a4
    80008bc4:	00f507b3          	add	a5,a0,a5
    80008bc8:	06e60463          	beq	a2,a4,80008c30 <__memmove+0xfc>
    80008bcc:	0005c703          	lbu	a4,0(a1)
    80008bd0:	00e78023          	sb	a4,0(a5)
    80008bd4:	04068e63          	beqz	a3,80008c30 <__memmove+0xfc>
    80008bd8:	0015c603          	lbu	a2,1(a1)
    80008bdc:	00100713          	li	a4,1
    80008be0:	00c780a3          	sb	a2,1(a5)
    80008be4:	04e68663          	beq	a3,a4,80008c30 <__memmove+0xfc>
    80008be8:	0025c603          	lbu	a2,2(a1)
    80008bec:	00200713          	li	a4,2
    80008bf0:	00c78123          	sb	a2,2(a5)
    80008bf4:	02e68e63          	beq	a3,a4,80008c30 <__memmove+0xfc>
    80008bf8:	0035c603          	lbu	a2,3(a1)
    80008bfc:	00300713          	li	a4,3
    80008c00:	00c781a3          	sb	a2,3(a5)
    80008c04:	02e68663          	beq	a3,a4,80008c30 <__memmove+0xfc>
    80008c08:	0045c603          	lbu	a2,4(a1)
    80008c0c:	00400713          	li	a4,4
    80008c10:	00c78223          	sb	a2,4(a5)
    80008c14:	00e68e63          	beq	a3,a4,80008c30 <__memmove+0xfc>
    80008c18:	0055c603          	lbu	a2,5(a1)
    80008c1c:	00500713          	li	a4,5
    80008c20:	00c782a3          	sb	a2,5(a5)
    80008c24:	00e68663          	beq	a3,a4,80008c30 <__memmove+0xfc>
    80008c28:	0065c703          	lbu	a4,6(a1)
    80008c2c:	00e78323          	sb	a4,6(a5)
    80008c30:	00813403          	ld	s0,8(sp)
    80008c34:	01010113          	addi	sp,sp,16
    80008c38:	00008067          	ret
    80008c3c:	02061713          	slli	a4,a2,0x20
    80008c40:	02075713          	srli	a4,a4,0x20
    80008c44:	00e587b3          	add	a5,a1,a4
    80008c48:	f0f574e3          	bgeu	a0,a5,80008b50 <__memmove+0x1c>
    80008c4c:	02069613          	slli	a2,a3,0x20
    80008c50:	02065613          	srli	a2,a2,0x20
    80008c54:	fff64613          	not	a2,a2
    80008c58:	00e50733          	add	a4,a0,a4
    80008c5c:	00c78633          	add	a2,a5,a2
    80008c60:	fff7c683          	lbu	a3,-1(a5)
    80008c64:	fff78793          	addi	a5,a5,-1
    80008c68:	fff70713          	addi	a4,a4,-1
    80008c6c:	00d70023          	sb	a3,0(a4)
    80008c70:	fec798e3          	bne	a5,a2,80008c60 <__memmove+0x12c>
    80008c74:	00813403          	ld	s0,8(sp)
    80008c78:	01010113          	addi	sp,sp,16
    80008c7c:	00008067          	ret
    80008c80:	02069713          	slli	a4,a3,0x20
    80008c84:	02075713          	srli	a4,a4,0x20
    80008c88:	00170713          	addi	a4,a4,1
    80008c8c:	00e50733          	add	a4,a0,a4
    80008c90:	00050793          	mv	a5,a0
    80008c94:	0005c683          	lbu	a3,0(a1)
    80008c98:	00178793          	addi	a5,a5,1
    80008c9c:	00158593          	addi	a1,a1,1
    80008ca0:	fed78fa3          	sb	a3,-1(a5)
    80008ca4:	fee798e3          	bne	a5,a4,80008c94 <__memmove+0x160>
    80008ca8:	f89ff06f          	j	80008c30 <__memmove+0xfc>
	...
