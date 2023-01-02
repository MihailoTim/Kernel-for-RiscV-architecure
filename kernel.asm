
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	3a813103          	ld	sp,936(sp) # 8000d3a8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	300070ef          	jal	ra,8000731c <start>

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
    800010a8:	3e8030ef          	jal	ra,80004490 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001184:	478080e7          	jalr	1144(ra) # 800025f8 <_ZN5Buddy4freeEPvm>
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
    800011bc:	14050663          	beqz	a0,80001308 <_ZN13SlabAllocator9printSlabEP4Slab+0x14c>
void SlabAllocator::printSlab(Slab *slab) {
    800011c0:	fe010113          	addi	sp,sp,-32
    800011c4:	00113c23          	sd	ra,24(sp)
    800011c8:	00813823          	sd	s0,16(sp)
    800011cc:	00913423          	sd	s1,8(sp)
    800011d0:	01213023          	sd	s2,0(sp)
    800011d4:	02010413          	addi	s0,sp,32
    800011d8:	00050913          	mv	s2,a0
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    800011dc:	00009617          	auipc	a2,0x9
    800011e0:	16c60613          	addi	a2,a2,364 # 8000a348 <CONSOLE_STATUS+0x338>
    800011e4:	0005059b          	sext.w	a1,a0
    800011e8:	00009517          	auipc	a0,0x9
    800011ec:	e3850513          	addi	a0,a0,-456 # 8000a020 <CONSOLE_STATUS+0x10>
    800011f0:	00004097          	auipc	ra,0x4
    800011f4:	d1c080e7          	jalr	-740(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011f8:	00009617          	auipc	a2,0x9
    800011fc:	15060613          	addi	a2,a2,336 # 8000a348 <CONSOLE_STATUS+0x338>
    80001200:	01892583          	lw	a1,24(s2)
    80001204:	00009517          	auipc	a0,0x9
    80001208:	e2c50513          	addi	a0,a0,-468 # 8000a030 <CONSOLE_STATUS+0x20>
    8000120c:	00004097          	auipc	ra,0x4
    80001210:	d00080e7          	jalr	-768(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    80001214:	00009617          	auipc	a2,0x9
    80001218:	13460613          	addi	a2,a2,308 # 8000a348 <CONSOLE_STATUS+0x338>
    8000121c:	01092583          	lw	a1,16(s2)
    80001220:	00009517          	auipc	a0,0x9
    80001224:	e2850513          	addi	a0,a0,-472 # 8000a048 <CONSOLE_STATUS+0x38>
    80001228:	00004097          	auipc	ra,0x4
    8000122c:	ce4080e7          	jalr	-796(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    80001230:	00009617          	auipc	a2,0x9
    80001234:	11860613          	addi	a2,a2,280 # 8000a348 <CONSOLE_STATUS+0x338>
    80001238:	000014b7          	lui	s1,0x1
    8000123c:	83048593          	addi	a1,s1,-2000 # 830 <_entry-0x7ffff7d0>
    80001240:	00009517          	auipc	a0,0x9
    80001244:	e2050513          	addi	a0,a0,-480 # 8000a060 <CONSOLE_STATUS+0x50>
    80001248:	00004097          	auipc	ra,0x4
    8000124c:	cc4080e7          	jalr	-828(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    80001250:	009904b3          	add	s1,s2,s1
    80001254:	00009617          	auipc	a2,0x9
    80001258:	0f460613          	addi	a2,a2,244 # 8000a348 <CONSOLE_STATUS+0x338>
    8000125c:	8204a583          	lw	a1,-2016(s1)
    80001260:	00009517          	auipc	a0,0x9
    80001264:	e1850513          	addi	a0,a0,-488 # 8000a078 <CONSOLE_STATUS+0x68>
    80001268:	00004097          	auipc	ra,0x4
    8000126c:	ca4080e7          	jalr	-860(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    80001270:	00009617          	auipc	a2,0x9
    80001274:	0d860613          	addi	a2,a2,216 # 8000a348 <CONSOLE_STATUS+0x338>
    80001278:	0209059b          	addiw	a1,s2,32
    8000127c:	00009517          	auipc	a0,0x9
    80001280:	e0c50513          	addi	a0,a0,-500 # 8000a088 <CONSOLE_STATUS+0x78>
    80001284:	00004097          	auipc	ra,0x4
    80001288:	c88080e7          	jalr	-888(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::printString("Allocated status array:\n");
    8000128c:	00009517          	auipc	a0,0x9
    80001290:	e1c50513          	addi	a0,a0,-484 # 8000a0a8 <CONSOLE_STATUS+0x98>
    80001294:	00004097          	auipc	ra,0x4
    80001298:	b58080e7          	jalr	-1192(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    8000129c:	00000493          	li	s1,0
    800012a0:	0240006f          	j	800012c4 <_ZN13SlabAllocator9printSlabEP4Slab+0x108>
            ConsoleUtil::print("", slab->allocated[i] == true ? 1 : 0, " ");
    800012a4:	00000593          	li	a1,0
    800012a8:	00009617          	auipc	a2,0x9
    800012ac:	e4060613          	addi	a2,a2,-448 # 8000a0e8 <CONSOLE_STATUS+0xd8>
    800012b0:	00009517          	auipc	a0,0x9
    800012b4:	0d850513          	addi	a0,a0,216 # 8000a388 <CONSOLE_STATUS+0x378>
    800012b8:	00004097          	auipc	ra,0x4
    800012bc:	c54080e7          	jalr	-940(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800012c0:	00148493          	addi	s1,s1,1
    800012c4:	01893783          	ld	a5,24(s2)
    800012c8:	00f4fc63          	bgeu	s1,a5,800012e0 <_ZN13SlabAllocator9printSlabEP4Slab+0x124>
            ConsoleUtil::print("", slab->allocated[i] == true ? 1 : 0, " ");
    800012cc:	009907b3          	add	a5,s2,s1
    800012d0:	0207c783          	lbu	a5,32(a5)
    800012d4:	fc0788e3          	beqz	a5,800012a4 <_ZN13SlabAllocator9printSlabEP4Slab+0xe8>
    800012d8:	00100593          	li	a1,1
    800012dc:	fcdff06f          	j	800012a8 <_ZN13SlabAllocator9printSlabEP4Slab+0xec>
        }
        ConsoleUtil::printString("\n");
    800012e0:	00009517          	auipc	a0,0x9
    800012e4:	06850513          	addi	a0,a0,104 # 8000a348 <CONSOLE_STATUS+0x338>
    800012e8:	00004097          	auipc	ra,0x4
    800012ec:	b04080e7          	jalr	-1276(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    800012f0:	01813083          	ld	ra,24(sp)
    800012f4:	01013403          	ld	s0,16(sp)
    800012f8:	00813483          	ld	s1,8(sp)
    800012fc:	00013903          	ld	s2,0(sp)
    80001300:	02010113          	addi	sp,sp,32
    80001304:	00008067          	ret
    80001308:	00008067          	ret

000000008000130c <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    8000130c:	fe010113          	addi	sp,sp,-32
    80001310:	00113c23          	sd	ra,24(sp)
    80001314:	00813823          	sd	s0,16(sp)
    80001318:	00913423          	sd	s1,8(sp)
    8000131c:	01213023          	sd	s2,0(sp)
    80001320:	02010413          	addi	s0,sp,32
    80001324:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    80001328:	00009517          	auipc	a0,0x9
    8000132c:	da050513          	addi	a0,a0,-608 # 8000a0c8 <CONSOLE_STATUS+0xb8>
    80001330:	00004097          	auipc	ra,0x4
    80001334:	abc080e7          	jalr	-1348(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001338:	00090513          	mv	a0,s2
    8000133c:	00004097          	auipc	ra,0x4
    80001340:	ab0080e7          	jalr	-1360(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001344:	00009517          	auipc	a0,0x9
    80001348:	00450513          	addi	a0,a0,4 # 8000a348 <CONSOLE_STATUS+0x338>
    8000134c:	00004097          	auipc	ra,0x4
    80001350:	aa0080e7          	jalr	-1376(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001354:	00009617          	auipc	a2,0x9
    80001358:	ff460613          	addi	a2,a2,-12 # 8000a348 <CONSOLE_STATUS+0x338>
    8000135c:	0000c797          	auipc	a5,0xc
    80001360:	0147b783          	ld	a5,20(a5) # 8000d370 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001364:	0007a583          	lw	a1,0(a5)
    80001368:	00009517          	auipc	a0,0x9
    8000136c:	d7050513          	addi	a0,a0,-656 # 8000a0d8 <CONSOLE_STATUS+0xc8>
    80001370:	00004097          	auipc	ra,0x4
    80001374:	b9c080e7          	jalr	-1124(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80001378:	00009617          	auipc	a2,0x9
    8000137c:	fd060613          	addi	a2,a2,-48 # 8000a348 <CONSOLE_STATUS+0x338>
    80001380:	0009059b          	sext.w	a1,s2
    80001384:	00009517          	auipc	a0,0x9
    80001388:	d6c50513          	addi	a0,a0,-660 # 8000a0f0 <CONSOLE_STATUS+0xe0>
    8000138c:	00004097          	auipc	ra,0x4
    80001390:	b80080e7          	jalr	-1152(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    80001394:	00009617          	auipc	a2,0x9
    80001398:	fb460613          	addi	a2,a2,-76 # 8000a348 <CONSOLE_STATUS+0x338>
    8000139c:	04892583          	lw	a1,72(s2)
    800013a0:	00009517          	auipc	a0,0x9
    800013a4:	d6050513          	addi	a0,a0,-672 # 8000a100 <CONSOLE_STATUS+0xf0>
    800013a8:	00004097          	auipc	ra,0x4
    800013ac:	b64080e7          	jalr	-1180(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013b0:	00009617          	auipc	a2,0x9
    800013b4:	f9860613          	addi	a2,a2,-104 # 8000a348 <CONSOLE_STATUS+0x338>
    800013b8:	04092583          	lw	a1,64(s2)
    800013bc:	00009517          	auipc	a0,0x9
    800013c0:	d5c50513          	addi	a0,a0,-676 # 8000a118 <CONSOLE_STATUS+0x108>
    800013c4:	00004097          	auipc	ra,0x4
    800013c8:	b48080e7          	jalr	-1208(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013cc:	00009617          	auipc	a2,0x9
    800013d0:	f7c60613          	addi	a2,a2,-132 # 8000a348 <CONSOLE_STATUS+0x338>
    800013d4:	06092583          	lw	a1,96(s2)
    800013d8:	00009517          	auipc	a0,0x9
    800013dc:	d5850513          	addi	a0,a0,-680 # 8000a130 <CONSOLE_STATUS+0x120>
    800013e0:	00004097          	auipc	ra,0x4
    800013e4:	b2c080e7          	jalr	-1236(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    800013e8:	06093483          	ld	s1,96(s2)
    while(iter){
    800013ec:	02048463          	beqz	s1,80001414 <_ZN13SlabAllocator10printCacheEP5Cache+0x108>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013f0:	00009617          	auipc	a2,0x9
    800013f4:	cf860613          	addi	a2,a2,-776 # 8000a0e8 <CONSOLE_STATUS+0xd8>
    800013f8:	0004859b          	sext.w	a1,s1
    800013fc:	00009517          	auipc	a0,0x9
    80001400:	f8c50513          	addi	a0,a0,-116 # 8000a388 <CONSOLE_STATUS+0x378>
    80001404:	00004097          	auipc	ra,0x4
    80001408:	b08080e7          	jalr	-1272(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    8000140c:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001410:	fddff06f          	j	800013ec <_ZN13SlabAllocator10printCacheEP5Cache+0xe0>
    }
    ConsoleUtil::printString("\n");
    80001414:	00009517          	auipc	a0,0x9
    80001418:	f3450513          	addi	a0,a0,-204 # 8000a348 <CONSOLE_STATUS+0x338>
    8000141c:	00004097          	auipc	ra,0x4
    80001420:	9d0080e7          	jalr	-1584(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80001424:	00009617          	auipc	a2,0x9
    80001428:	f2460613          	addi	a2,a2,-220 # 8000a348 <CONSOLE_STATUS+0x338>
    8000142c:	06892583          	lw	a1,104(s2)
    80001430:	00009517          	auipc	a0,0x9
    80001434:	d1050513          	addi	a0,a0,-752 # 8000a140 <CONSOLE_STATUS+0x130>
    80001438:	00004097          	auipc	ra,0x4
    8000143c:	ad4080e7          	jalr	-1324(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    80001440:	06893483          	ld	s1,104(s2)
    while(iter){
    80001444:	02048463          	beqz	s1,8000146c <_ZN13SlabAllocator10printCacheEP5Cache+0x160>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001448:	00009617          	auipc	a2,0x9
    8000144c:	ca060613          	addi	a2,a2,-864 # 8000a0e8 <CONSOLE_STATUS+0xd8>
    80001450:	0004859b          	sext.w	a1,s1
    80001454:	00009517          	auipc	a0,0x9
    80001458:	f3450513          	addi	a0,a0,-204 # 8000a388 <CONSOLE_STATUS+0x378>
    8000145c:	00004097          	auipc	ra,0x4
    80001460:	ab0080e7          	jalr	-1360(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001464:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001468:	fddff06f          	j	80001444 <_ZN13SlabAllocator10printCacheEP5Cache+0x138>
    }
    ConsoleUtil::printString("\n");
    8000146c:	00009517          	auipc	a0,0x9
    80001470:	edc50513          	addi	a0,a0,-292 # 8000a348 <CONSOLE_STATUS+0x338>
    80001474:	00004097          	auipc	ra,0x4
    80001478:	978080e7          	jalr	-1672(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    8000147c:	00009617          	auipc	a2,0x9
    80001480:	ecc60613          	addi	a2,a2,-308 # 8000a348 <CONSOLE_STATUS+0x338>
    80001484:	07092583          	lw	a1,112(s2)
    80001488:	00009517          	auipc	a0,0x9
    8000148c:	cc850513          	addi	a0,a0,-824 # 8000a150 <CONSOLE_STATUS+0x140>
    80001490:	00004097          	auipc	ra,0x4
    80001494:	a7c080e7          	jalr	-1412(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    80001498:	07093483          	ld	s1,112(s2)
    while(iter){
    8000149c:	02048463          	beqz	s1,800014c4 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
        ConsoleUtil::print("", (uint64)iter, " ");
    800014a0:	00009617          	auipc	a2,0x9
    800014a4:	c4860613          	addi	a2,a2,-952 # 8000a0e8 <CONSOLE_STATUS+0xd8>
    800014a8:	0004859b          	sext.w	a1,s1
    800014ac:	00009517          	auipc	a0,0x9
    800014b0:	edc50513          	addi	a0,a0,-292 # 8000a388 <CONSOLE_STATUS+0x378>
    800014b4:	00004097          	auipc	ra,0x4
    800014b8:	a58080e7          	jalr	-1448(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800014bc:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014c0:	fddff06f          	j	8000149c <_ZN13SlabAllocator10printCacheEP5Cache+0x190>
    }
    ConsoleUtil::printString("\n");
    800014c4:	00009517          	auipc	a0,0x9
    800014c8:	e8450513          	addi	a0,a0,-380 # 8000a348 <CONSOLE_STATUS+0x338>
    800014cc:	00004097          	auipc	ra,0x4
    800014d0:	920080e7          	jalr	-1760(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
    800014d4:	00009617          	auipc	a2,0x9
    800014d8:	e7460613          	addi	a2,a2,-396 # 8000a348 <CONSOLE_STATUS+0x338>
    800014dc:	04092583          	lw	a1,64(s2)
    800014e0:	00009517          	auipc	a0,0x9
    800014e4:	c8050513          	addi	a0,a0,-896 # 8000a160 <CONSOLE_STATUS+0x150>
    800014e8:	00004097          	auipc	ra,0x4
    800014ec:	a24080e7          	jalr	-1500(ra) # 80004f0c <_ZN11ConsoleUtil5printEPKciS1_>
}
    800014f0:	01813083          	ld	ra,24(sp)
    800014f4:	01013403          	ld	s0,16(sp)
    800014f8:	00813483          	ld	s1,8(sp)
    800014fc:	00013903          	ld	s2,0(sp)
    80001500:	02010113          	addi	sp,sp,32
    80001504:	00008067          	ret

0000000080001508 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    80001508:	ff010113          	addi	sp,sp,-16
    8000150c:	00813423          	sd	s0,8(sp)
    80001510:	01010413          	addi	s0,sp,16
    slab->next = head;
    80001514:	00053783          	ld	a5,0(a0)
    80001518:	00f5b423          	sd	a5,8(a1)
    if(head)
    8000151c:	00078463          	beqz	a5,80001524 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    80001520:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    80001524:	0005b023          	sd	zero,0(a1)
    head = slab;
    80001528:	00b53023          	sd	a1,0(a0)
}
    8000152c:	00813403          	ld	s0,8(sp)
    80001530:	01010113          	addi	sp,sp,16
    80001534:	00008067          	ret

0000000080001538 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    80001538:	fe010113          	addi	sp,sp,-32
    8000153c:	00113c23          	sd	ra,24(sp)
    80001540:	00813823          	sd	s0,16(sp)
    80001544:	00913423          	sd	s1,8(sp)
    80001548:	01213023          	sd	s2,0(sp)
    8000154c:	02010413          	addi	s0,sp,32
    80001550:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    80001554:	04853503          	ld	a0,72(a0)
    80001558:	00001097          	auipc	ra,0x1
    8000155c:	178080e7          	jalr	376(ra) # 800026d0 <_ZN5Buddy5allocEm>
    if(!slab)
    80001560:	06050663          	beqz	a0,800015cc <_ZN13SlabAllocator12allocateSlabEP5Cache+0x94>
    80001564:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80001568:	00050593          	mv	a1,a0
    8000156c:	06090513          	addi	a0,s2,96
    80001570:	00000097          	auipc	ra,0x0
    80001574:	f98080e7          	jalr	-104(ra) # 80001508 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80001578:	04893703          	ld	a4,72(s2)
    8000157c:	00c71713          	slli	a4,a4,0xc
    80001580:	fffff7b7          	lui	a5,0xfffff
    80001584:	7d078793          	addi	a5,a5,2000 # fffffffffffff7d0 <end+0xffffffff7ffeced0>
    80001588:	00f70733          	add	a4,a4,a5
    8000158c:	04093783          	ld	a5,64(s2)
    80001590:	02f75733          	divu	a4,a4,a5
    80001594:	00e4b823          	sd	a4,16(s1)
    80001598:	00e4bc23          	sd	a4,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab));
    8000159c:	000017b7          	lui	a5,0x1
    800015a0:	83078693          	addi	a3,a5,-2000 # 830 <_entry-0x7ffff7d0>
    800015a4:	00d486b3          	add	a3,s1,a3
    800015a8:	00f487b3          	add	a5,s1,a5
    800015ac:	82d7b023          	sd	a3,-2016(a5)
    slab->parent = cache;
    800015b0:	8327b423          	sd	s2,-2008(a5)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    800015b4:	00000793          	li	a5,0
    800015b8:	00e7fe63          	bgeu	a5,a4,800015d4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x9c>
        slab->allocated[i] = false;
    800015bc:	00f486b3          	add	a3,s1,a5
    800015c0:	02068023          	sb	zero,32(a3)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    800015c4:	00178793          	addi	a5,a5,1
    800015c8:	ff1ff06f          	j	800015b8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x80>
        return false;
    800015cc:	00000513          	li	a0,0
    800015d0:	0080006f          	j	800015d8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa0>
    return true;
    800015d4:	00100513          	li	a0,1
}
    800015d8:	01813083          	ld	ra,24(sp)
    800015dc:	01013403          	ld	s0,16(sp)
    800015e0:	00813483          	ld	s1,8(sp)
    800015e4:	00013903          	ld	s2,0(sp)
    800015e8:	02010113          	addi	sp,sp,32
    800015ec:	00008067          	ret

00000000800015f0 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    800015f0:	ff010113          	addi	sp,sp,-16
    800015f4:	00813423          	sd	s0,8(sp)
    800015f8:	01010413          	addi	s0,sp,16
    if(slab == head)
    800015fc:	00053783          	ld	a5,0(a0)
    80001600:	02b78c63          	beq	a5,a1,80001638 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80001604:	0085b783          	ld	a5,8(a1)
    80001608:	00078663          	beqz	a5,80001614 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    8000160c:	0005b703          	ld	a4,0(a1)
    80001610:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80001614:	0005b783          	ld	a5,0(a1)
    80001618:	00078663          	beqz	a5,80001624 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    8000161c:	0085b703          	ld	a4,8(a1)
    80001620:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80001624:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80001628:	0005b423          	sd	zero,8(a1)
}
    8000162c:	00813403          	ld	s0,8(sp)
    80001630:	01010113          	addi	sp,sp,16
    80001634:	00008067          	ret
        head = slab->next;
    80001638:	0085b783          	ld	a5,8(a1)
    8000163c:	00f53023          	sd	a5,0(a0)
    80001640:	fc5ff06f          	j	80001604 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

0000000080001644 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    80001644:	fe010113          	addi	sp,sp,-32
    80001648:	00113c23          	sd	ra,24(sp)
    8000164c:	00813823          	sd	s0,16(sp)
    80001650:	00913423          	sd	s1,8(sp)
    80001654:	01213023          	sd	s2,0(sp)
    80001658:	02010413          	addi	s0,sp,32
    8000165c:	00058913          	mv	s2,a1
    80001660:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    80001664:	00060593          	mv	a1,a2
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	f88080e7          	jalr	-120(ra) # 800015f0 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    80001670:	00048593          	mv	a1,s1
    80001674:	00090513          	mv	a0,s2
    80001678:	00000097          	auipc	ra,0x0
    8000167c:	e90080e7          	jalr	-368(ra) # 80001508 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    80001680:	01813083          	ld	ra,24(sp)
    80001684:	01013403          	ld	s0,16(sp)
    80001688:	00813483          	ld	s1,8(sp)
    8000168c:	00013903          	ld	s2,0(sp)
    80001690:	02010113          	addi	sp,sp,32
    80001694:	00008067          	ret

0000000080001698 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    80001698:	fe010113          	addi	sp,sp,-32
    8000169c:	00113c23          	sd	ra,24(sp)
    800016a0:	00813823          	sd	s0,16(sp)
    800016a4:	00913423          	sd	s1,8(sp)
    800016a8:	01213023          	sd	s2,0(sp)
    800016ac:	02010413          	addi	s0,sp,32
    800016b0:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    800016b4:	00000493          	li	s1,0
    800016b8:	01893783          	ld	a5,24(s2)
    800016bc:	0af4fc63          	bgeu	s1,a5,80001774 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xdc>
        if(!slab->allocated[i]){
    800016c0:	00990733          	add	a4,s2,s1
    800016c4:	02074703          	lbu	a4,32(a4)
    800016c8:	00070663          	beqz	a4,800016d4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x3c>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    800016cc:	00148493          	addi	s1,s1,1
    800016d0:	fe9ff06f          	j	800016b8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i] = true;
    800016d4:	00990733          	add	a4,s2,s1
    800016d8:	00100693          	li	a3,1
    800016dc:	02d70023          	sb	a3,32(a4)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    800016e0:	01093703          	ld	a4,16(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800016e4:	06e78463          	beq	a5,a4,8000174c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb4>
    800016e8:	000017b7          	lui	a5,0x1
    800016ec:	00f907b3          	add	a5,s2,a5
    800016f0:	8287b503          	ld	a0,-2008(a5) # 828 <_entry-0x7ffff7d8>
    800016f4:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    800016f8:	fff70793          	addi	a5,a4,-1
    800016fc:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001700:	06079063          	bnez	a5,80001760 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc8>
    80001704:	000017b7          	lui	a5,0x1
    80001708:	00f907b3          	add	a5,s2,a5
    8000170c:	8287b583          	ld	a1,-2008(a5) # 828 <_entry-0x7ffff7d8>
    80001710:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80001714:	0005b703          	ld	a4,0(a1)
    80001718:	00053783          	ld	a5,0(a0)
    8000171c:	00f70863          	beq	a4,a5,8000172c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001720:	00090613          	mv	a2,s2
    80001724:	00000097          	auipc	ra,0x0
    80001728:	f20080e7          	jalr	-224(ra) # 80001644 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    8000172c:	000017b7          	lui	a5,0x1
    80001730:	00f90933          	add	s2,s2,a5
    80001734:	82093503          	ld	a0,-2016(s2)
    80001738:	82893783          	ld	a5,-2008(s2)
    8000173c:	0407b783          	ld	a5,64(a5) # 1040 <_entry-0x7fffefc0>
    80001740:	029784b3          	mul	s1,a5,s1
    80001744:	00950533          	add	a0,a0,s1
    80001748:	0300006f          	j	80001778 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xe0>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    8000174c:	000017b7          	lui	a5,0x1
    80001750:	00f907b3          	add	a5,s2,a5
    80001754:	8287b503          	ld	a0,-2008(a5) # 828 <_entry-0x7ffff7d8>
    80001758:	06050513          	addi	a0,a0,96
    8000175c:	f9dff06f          	j	800016f8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x60>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001760:	000017b7          	lui	a5,0x1
    80001764:	00f907b3          	add	a5,s2,a5
    80001768:	8287b583          	ld	a1,-2008(a5) # 828 <_entry-0x7ffff7d8>
    8000176c:	06858593          	addi	a1,a1,104
    80001770:	fa5ff06f          	j	80001714 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x7c>
    return nullptr;
    80001774:	00000513          	li	a0,0
}
    80001778:	01813083          	ld	ra,24(sp)
    8000177c:	01013403          	ld	s0,16(sp)
    80001780:	00813483          	ld	s1,8(sp)
    80001784:	00013903          	ld	s2,0(sp)
    80001788:	02010113          	addi	sp,sp,32
    8000178c:	00008067          	ret

0000000080001790 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    80001790:	fe010113          	addi	sp,sp,-32
    80001794:	00113c23          	sd	ra,24(sp)
    80001798:	00813823          	sd	s0,16(sp)
    8000179c:	00913423          	sd	s1,8(sp)
    800017a0:	01213023          	sd	s2,0(sp)
    800017a4:	02010413          	addi	s0,sp,32
    800017a8:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    800017ac:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    800017b0:	00048c63          	beqz	s1,800017c8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    800017b4:	00048513          	mv	a0,s1
    800017b8:	00000097          	auipc	ra,0x0
    800017bc:	ee0080e7          	jalr	-288(ra) # 80001698 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    800017c0:	fe0508e3          	beqz	a0,800017b0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    800017c4:	00050493          	mv	s1,a0
    if(ret){
    800017c8:	02048063          	beqz	s1,800017e8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    800017cc:	00048513          	mv	a0,s1
    800017d0:	01813083          	ld	ra,24(sp)
    800017d4:	01013403          	ld	s0,16(sp)
    800017d8:	00813483          	ld	s1,8(sp)
    800017dc:	00013903          	ld	s2,0(sp)
    800017e0:	02010113          	addi	sp,sp,32
    800017e4:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    800017e8:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    800017ec:	00048c63          	beqz	s1,80001804 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    800017f0:	00048513          	mv	a0,s1
    800017f4:	00000097          	auipc	ra,0x0
    800017f8:	ea4080e7          	jalr	-348(ra) # 80001698 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    800017fc:	fe0508e3          	beqz	a0,800017ec <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80001800:	00050493          	mv	s1,a0
    if(ret){
    80001804:	fc0494e3          	bnez	s1,800017cc <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80001808:	00090513          	mv	a0,s2
    8000180c:	00000097          	auipc	ra,0x0
    80001810:	d2c080e7          	jalr	-724(ra) # 80001538 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80001814:	fa050ce3          	beqz	a0,800017cc <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001818:	06093503          	ld	a0,96(s2)
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	e7c080e7          	jalr	-388(ra) # 80001698 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001824:	00050493          	mv	s1,a0
    return ret;
    80001828:	fa5ff06f          	j	800017cc <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

000000008000182c <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    8000182c:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80001830:	0017d513          	srli	a0,a5,0x1
    80001834:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80001838:	0027d713          	srli	a4,a5,0x2
    8000183c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80001840:	0047d713          	srli	a4,a5,0x4
    80001844:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80001848:	0087d713          	srli	a4,a5,0x8
    8000184c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80001850:	0107d713          	srli	a4,a5,0x10
    80001854:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80001858:	0207d713          	srli	a4,a5,0x20
    8000185c:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80001860:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001864:	00000713          	li	a4,0
        while(num>1){
    80001868:	00100693          	li	a3,1
    8000186c:	00f6f863          	bgeu	a3,a5,8000187c <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    80001870:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001874:	00170713          	addi	a4,a4,1
        while(num>1){
    80001878:	ff1ff06f          	j	80001868 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    8000187c:	ffb70713          	addi	a4,a4,-5
    80001880:	00c00793          	li	a5,12
    80001884:	00e7f663          	bgeu	a5,a4,80001890 <_ZN13SlabAllocator14allocateBufferEm+0x64>
}
    80001888:	00000513          	li	a0,0
    8000188c:	00008067          	ret
void* SlabAllocator::allocateBuffer(size_t size) {
    80001890:	ff010113          	addi	sp,sp,-16
    80001894:	00113423          	sd	ra,8(sp)
    80001898:	00813023          	sd	s0,0(sp)
    8000189c:	01010413          	addi	s0,sp,16
    SlabAllocator::allocateObject(sizeN[level]);
    800018a0:	00371713          	slli	a4,a4,0x3
    800018a4:	0000c797          	auipc	a5,0xc
    800018a8:	bac78793          	addi	a5,a5,-1108 # 8000d450 <_ZN13SlabAllocator5sizeNE>
    800018ac:	00e78733          	add	a4,a5,a4
    800018b0:	00073503          	ld	a0,0(a4)
    800018b4:	00000097          	auipc	ra,0x0
    800018b8:	edc080e7          	jalr	-292(ra) # 80001790 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800018bc:	00000513          	li	a0,0
    800018c0:	00813083          	ld	ra,8(sp)
    800018c4:	00013403          	ld	s0,0(sp)
    800018c8:	01010113          	addi	sp,sp,16
    800018cc:	00008067          	ret

00000000800018d0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800018d0:	fc010113          	addi	sp,sp,-64
    800018d4:	02113c23          	sd	ra,56(sp)
    800018d8:	02813823          	sd	s0,48(sp)
    800018dc:	02913423          	sd	s1,40(sp)
    800018e0:	03213023          	sd	s2,32(sp)
    800018e4:	01313c23          	sd	s3,24(sp)
    800018e8:	01413823          	sd	s4,16(sp)
    800018ec:	01513423          	sd	s5,8(sp)
    800018f0:	04010413          	addi	s0,sp,64
    800018f4:	00050913          	mv	s2,a0
    800018f8:	00058993          	mv	s3,a1
    800018fc:	00060a93          	mv	s5,a2
    80001900:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001904:	0000c517          	auipc	a0,0xc
    80001908:	bb453503          	ld	a0,-1100(a0) # 8000d4b8 <_ZN13SlabAllocator5cacheE>
    8000190c:	00000097          	auipc	ra,0x0
    80001910:	e84080e7          	jalr	-380(ra) # 80001790 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001914:	00050493          	mv	s1,a0
    ret->ctor = ctor;
    80001918:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    8000191c:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80001920:	06053823          	sd	zero,112(a0)
    80001924:	06053423          	sd	zero,104(a0)
    80001928:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    8000192c:	05353023          	sd	s3,64(a0)
    ret->slabSize = DEFAULT_SLAB_SIZE;
    80001930:	00200793          	li	a5,2
    80001934:	04f53423          	sd	a5,72(a0)
    strcpy(name, ret->name);
    80001938:	00050593          	mv	a1,a0
    8000193c:	00090513          	mv	a0,s2
    80001940:	00003097          	auipc	ra,0x3
    80001944:	f84080e7          	jalr	-124(ra) # 800048c4 <_Z6strcpyPKcPc>
}
    80001948:	00048513          	mv	a0,s1
    8000194c:	03813083          	ld	ra,56(sp)
    80001950:	03013403          	ld	s0,48(sp)
    80001954:	02813483          	ld	s1,40(sp)
    80001958:	02013903          	ld	s2,32(sp)
    8000195c:	01813983          	ld	s3,24(sp)
    80001960:	01013a03          	ld	s4,16(sp)
    80001964:	00813a83          	ld	s5,8(sp)
    80001968:	04010113          	addi	sp,sp,64
    8000196c:	00008067          	ret

0000000080001970 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80001970:	fe010113          	addi	sp,sp,-32
    80001974:	00113c23          	sd	ra,24(sp)
    80001978:	00813823          	sd	s0,16(sp)
    8000197c:	00913423          	sd	s1,8(sp)
    80001980:	01213023          	sd	s2,0(sp)
    80001984:	02010413          	addi	s0,sp,32
    80001988:	00050913          	mv	s2,a0
    8000198c:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    80001990:	00001097          	auipc	ra,0x1
    80001994:	970080e7          	jalr	-1680(ra) # 80002300 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    80001998:	0000c797          	auipc	a5,0xc
    8000199c:	ab878793          	addi	a5,a5,-1352 # 8000d450 <_ZN13SlabAllocator5sizeNE>
    800019a0:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    800019a4:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    800019a8:	0000c717          	auipc	a4,0xc
    800019ac:	9c873703          	ld	a4,-1592(a4) # 8000d370 <_GLOBAL_OFFSET_TABLE_+0x18>
    800019b0:	00073583          	ld	a1,0(a4)
    800019b4:	00c5d593          	srli	a1,a1,0xc
    800019b8:	00158593          	addi	a1,a1,1
    800019bc:	00c59593          	slli	a1,a1,0xc
    800019c0:	06b7b423          	sd	a1,104(a5)
    cache->ctor = nullptr;
    800019c4:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    800019c8:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    800019cc:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    800019d0:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    800019d4:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    800019d8:	07800793          	li	a5,120
    800019dc:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    800019e0:	00200793          	li	a5,2
    800019e4:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    800019e8:	00008517          	auipc	a0,0x8
    800019ec:	78850513          	addi	a0,a0,1928 # 8000a170 <CONSOLE_STATUS+0x160>
    800019f0:	00003097          	auipc	ra,0x3
    800019f4:	ed4080e7          	jalr	-300(ra) # 800048c4 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800019f8:	00000493          	li	s1,0
    800019fc:	0440006f          	j	80001a40 <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a00:	00349913          	slli	s2,s1,0x3
    80001a04:	0000b797          	auipc	a5,0xb
    80001a08:	6bc78793          	addi	a5,a5,1724 # 8000d0c0 <_ZN13SlabAllocator5namesE>
    80001a0c:	012787b3          	add	a5,a5,s2
    80001a10:	00000693          	li	a3,0
    80001a14:	00000613          	li	a2,0
    80001a18:	00200593          	li	a1,2
    80001a1c:	009595bb          	sllw	a1,a1,s1
    80001a20:	0007b503          	ld	a0,0(a5)
    80001a24:	00000097          	auipc	ra,0x0
    80001a28:	eac080e7          	jalr	-340(ra) # 800018d0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a2c:	0000c797          	auipc	a5,0xc
    80001a30:	a2478793          	addi	a5,a5,-1500 # 8000d450 <_ZN13SlabAllocator5sizeNE>
    80001a34:	012787b3          	add	a5,a5,s2
    80001a38:	00a7b023          	sd	a0,0(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a3c:	0014849b          	addiw	s1,s1,1
    80001a40:	00c00793          	li	a5,12
    80001a44:	fa97dee3          	bge	a5,s1,80001a00 <_ZN13SlabAllocator10initializeEPvm+0x90>
}
    80001a48:	01813083          	ld	ra,24(sp)
    80001a4c:	01013403          	ld	s0,16(sp)
    80001a50:	00813483          	ld	s1,8(sp)
    80001a54:	00013903          	ld	s2,0(sp)
    80001a58:	02010113          	addi	sp,sp,32
    80001a5c:	00008067          	ret

0000000080001a60 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index]) {
    80001a60:	00b507b3          	add	a5,a0,a1
    80001a64:	0207c783          	lbu	a5,32(a5)
    80001a68:	0e078063          	beqz	a5,80001b48 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xe8>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001a6c:	fe010113          	addi	sp,sp,-32
    80001a70:	00113c23          	sd	ra,24(sp)
    80001a74:	00813823          	sd	s0,16(sp)
    80001a78:	00913423          	sd	s1,8(sp)
    80001a7c:	02010413          	addi	s0,sp,32
    80001a80:	00050493          	mv	s1,a0
        slab->allocated[index] = false;
    80001a84:	00b505b3          	add	a1,a0,a1
    80001a88:	02058023          	sb	zero,32(a1)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001a8c:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001a90:	06079263          	bnez	a5,80001af4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001a94:	00001737          	lui	a4,0x1
    80001a98:	00e50733          	add	a4,a0,a4
    80001a9c:	82873503          	ld	a0,-2008(a4) # 828 <_entry-0x7ffff7d8>
    80001aa0:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001aa4:	00178793          	addi	a5,a5,1
    80001aa8:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001aac:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001ab0:	04e78c63          	beq	a5,a4,80001b08 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001ab4:	000016b7          	lui	a3,0x1
    80001ab8:	00d486b3          	add	a3,s1,a3
    80001abc:	8286b583          	ld	a1,-2008(a3) # 828 <_entry-0x7ffff7d8>
    80001ac0:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001ac4:	04e78c63          	beq	a5,a4,80001b1c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xbc>
            if (headTo != headFrom)
    80001ac8:	0005b703          	ld	a4,0(a1)
    80001acc:	00053783          	ld	a5,0(a0)
    80001ad0:	00f70863          	beq	a4,a5,80001ae0 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x80>
                SlabAllocator::move(headFrom, headTo, slab);
    80001ad4:	00048613          	mv	a2,s1
    80001ad8:	00000097          	auipc	ra,0x0
    80001adc:	b6c080e7          	jalr	-1172(ra) # 80001644 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001ae0:	01813083          	ld	ra,24(sp)
    80001ae4:	01013403          	ld	s0,16(sp)
    80001ae8:	00813483          	ld	s1,8(sp)
    80001aec:	02010113          	addi	sp,sp,32
    80001af0:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001af4:	00001737          	lui	a4,0x1
    80001af8:	00e50733          	add	a4,a0,a4
    80001afc:	82873503          	ld	a0,-2008(a4) # 828 <_entry-0x7ffff7d8>
    80001b00:	06850513          	addi	a0,a0,104
    80001b04:	fa1ff06f          	j	80001aa4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x44>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b08:	000016b7          	lui	a3,0x1
    80001b0c:	00d486b3          	add	a3,s1,a3
    80001b10:	8286b583          	ld	a1,-2008(a3) # 828 <_entry-0x7ffff7d8>
    80001b14:	06058593          	addi	a1,a1,96
    80001b18:	fadff06f          	j	80001ac4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x64>
            SlabAllocator::removeFromList(headFrom, slab);
    80001b1c:	00048593          	mv	a1,s1
    80001b20:	00000097          	auipc	ra,0x0
    80001b24:	ad0080e7          	jalr	-1328(ra) # 800015f0 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80001b28:	000017b7          	lui	a5,0x1
    80001b2c:	00f487b3          	add	a5,s1,a5
    80001b30:	8287b783          	ld	a5,-2008(a5) # 828 <_entry-0x7ffff7d8>
    80001b34:	0487b583          	ld	a1,72(a5)
    80001b38:	00048513          	mv	a0,s1
    80001b3c:	00001097          	auipc	ra,0x1
    80001b40:	abc080e7          	jalr	-1348(ra) # 800025f8 <_ZN5Buddy4freeEPvm>
    80001b44:	f9dff06f          	j	80001ae0 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x80>
    80001b48:	00008067          	ret

0000000080001b4c <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001b4c:	fe010113          	addi	sp,sp,-32
    80001b50:	00113c23          	sd	ra,24(sp)
    80001b54:	00813823          	sd	s0,16(sp)
    80001b58:	00913423          	sd	s1,8(sp)
    80001b5c:	01213023          	sd	s2,0(sp)
    80001b60:	02010413          	addi	s0,sp,32
    80001b64:	00050913          	mv	s2,a0
    80001b68:	00058493          	mv	s1,a1
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001b6c:	07053503          	ld	a0,112(a0)
    80001b70:	0080006f          	j	80001b78 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x2c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001b74:	00853503          	ld	a0,8(a0)
        while(head){
    80001b78:	04050263          	beqz	a0,80001bbc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x70>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001b7c:	00001737          	lui	a4,0x1
    80001b80:	00e50733          	add	a4,a0,a4
    80001b84:	82073683          	ld	a3,-2016(a4) # 820 <_entry-0x7ffff7e0>
    80001b88:	01853783          	ld	a5,24(a0)
    80001b8c:	82873703          	ld	a4,-2008(a4)
    80001b90:	04073583          	ld	a1,64(a4)
    80001b94:	02b787b3          	mul	a5,a5,a1
    80001b98:	00f687b3          	add	a5,a3,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001b9c:	fcf4fce3          	bgeu	s1,a5,80001b74 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x28>
    80001ba0:	fcd4eae3          	bltu	s1,a3,80001b74 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x28>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001ba4:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001ba8:	02b6d5b3          	divu	a1,a3,a1
    80001bac:	00000097          	auipc	ra,0x0
    80001bb0:	eb4080e7          	jalr	-332(ra) # 80001a60 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001bb4:	00100513          	li	a0,1
    80001bb8:	0080006f          	j	80001bc0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x74>
        }
        return false;
    80001bbc:	00000513          	li	a0,0
    if(deleted)
    80001bc0:	00050e63          	beqz	a0,80001bdc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
}
    80001bc4:	01813083          	ld	ra,24(sp)
    80001bc8:	01013403          	ld	s0,16(sp)
    80001bcc:	00813483          	ld	s1,8(sp)
    80001bd0:	00013903          	ld	s2,0(sp)
    80001bd4:	02010113          	addi	sp,sp,32
    80001bd8:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001bdc:	06893703          	ld	a4,104(s2)
    80001be0:	0080006f          	j	80001be8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x9c>
            head = head->next;
    80001be4:	00873703          	ld	a4,8(a4)
        while(head){
    80001be8:	fc070ee3          	beqz	a4,80001bc4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x78>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001bec:	000016b7          	lui	a3,0x1
    80001bf0:	00d706b3          	add	a3,a4,a3
    80001bf4:	8206b603          	ld	a2,-2016(a3) # 820 <_entry-0x7ffff7e0>
    80001bf8:	01873783          	ld	a5,24(a4)
    80001bfc:	8286b683          	ld	a3,-2008(a3)
    80001c00:	0406b583          	ld	a1,64(a3)
    80001c04:	02b787b3          	mul	a5,a5,a1
    80001c08:	00f607b3          	add	a5,a2,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c0c:	fcf4fce3          	bgeu	s1,a5,80001be4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x98>
    80001c10:	fcc4eae3          	bltu	s1,a2,80001be4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x98>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c14:	40c48633          	sub	a2,s1,a2
                freeSlot(head, index);
    80001c18:	02b655b3          	divu	a1,a2,a1
    80001c1c:	00070513          	mv	a0,a4
    80001c20:	00000097          	auipc	ra,0x0
    80001c24:	e40080e7          	jalr	-448(ra) # 80001a60 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c28:	00100513          	li	a0,1
    80001c2c:	f99ff06f          	j	80001bc4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x78>

0000000080001c30 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001c30:	fe010113          	addi	sp,sp,-32
    80001c34:	00113c23          	sd	ra,24(sp)
    80001c38:	00813823          	sd	s0,16(sp)
    80001c3c:	00913423          	sd	s1,8(sp)
    80001c40:	01213023          	sd	s2,0(sp)
    80001c44:	02010413          	addi	s0,sp,32
    80001c48:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001c4c:	00000493          	li	s1,0
    80001c50:	00c00793          	li	a5,12
    80001c54:	0297c863          	blt	a5,s1,80001c84 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001c58:	00349713          	slli	a4,s1,0x3
    80001c5c:	0000b797          	auipc	a5,0xb
    80001c60:	7f478793          	addi	a5,a5,2036 # 8000d450 <_ZN13SlabAllocator5sizeNE>
    80001c64:	00e787b3          	add	a5,a5,a4
    80001c68:	00090593          	mv	a1,s2
    80001c6c:	0007b503          	ld	a0,0(a5)
    80001c70:	00000097          	auipc	ra,0x0
    80001c74:	edc080e7          	jalr	-292(ra) # 80001b4c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001c78:	00051663          	bnez	a0,80001c84 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001c7c:	0014849b          	addiw	s1,s1,1
    80001c80:	fd1ff06f          	j	80001c50 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001c84:	01813083          	ld	ra,24(sp)
    80001c88:	01013403          	ld	s0,16(sp)
    80001c8c:	00813483          	ld	s1,8(sp)
    80001c90:	00013903          	ld	s2,0(sp)
    80001c94:	02010113          	addi	sp,sp,32
    80001c98:	00008067          	ret

0000000080001c9c <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001c9c:	fe010113          	addi	sp,sp,-32
    80001ca0:	00113c23          	sd	ra,24(sp)
    80001ca4:	00813823          	sd	s0,16(sp)
    80001ca8:	00913423          	sd	s1,8(sp)
    80001cac:	01213023          	sd	s2,0(sp)
    80001cb0:	02010413          	addi	s0,sp,32
    80001cb4:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001cb8:	00053903          	ld	s2,0(a0)
    80001cbc:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001cc0:	00093503          	ld	a0,0(s2)
    80001cc4:	02050663          	beqz	a0,80001cf0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
            Slab* tmp = head;
    80001cc8:	000017b7          	lui	a5,0x1
    80001ccc:	00f507b3          	add	a5,a0,a5
    80001cd0:	8287b783          	ld	a5,-2008(a5) # 828 <_entry-0x7ffff7d8>
    80001cd4:	0487b583          	ld	a1,72(a5)
    80001cd8:	00001097          	auipc	ra,0x1
    80001cdc:	920080e7          	jalr	-1760(ra) # 800025f8 <_ZN5Buddy4freeEPvm>
            Buddy::free(tmp, head->parent->slabSize);
    80001ce0:	00093783          	ld	a5,0(s2)
    80001ce4:	0087b783          	ld	a5,8(a5)
    80001ce8:	00f93023          	sd	a5,0(s2)
        while(head){
    80001cec:	fd5ff06f          	j	80001cc0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001cf0:	0004b903          	ld	s2,0(s1)
    80001cf4:	06890913          	addi	s2,s2,104
    80001cf8:	00093503          	ld	a0,0(s2)
    80001cfc:	02050663          	beqz	a0,80001d28 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x8c>
            Slab* tmp = head;
    80001d00:	000017b7          	lui	a5,0x1
    80001d04:	00f507b3          	add	a5,a0,a5
    80001d08:	8287b783          	ld	a5,-2008(a5) # 828 <_entry-0x7ffff7d8>
    80001d0c:	0487b583          	ld	a1,72(a5)
    80001d10:	00001097          	auipc	ra,0x1
    80001d14:	8e8080e7          	jalr	-1816(ra) # 800025f8 <_ZN5Buddy4freeEPvm>
            Buddy::free(tmp, head->parent->slabSize);
    80001d18:	00093783          	ld	a5,0(s2)
    80001d1c:	0087b783          	ld	a5,8(a5)
    80001d20:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d24:	fd5ff06f          	j	80001cf8 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x5c>
    deleteList(cache->emptyHead);
    80001d28:	0004b903          	ld	s2,0(s1)
    80001d2c:	06090913          	addi	s2,s2,96
    80001d30:	00093503          	ld	a0,0(s2)
    80001d34:	02050663          	beqz	a0,80001d60 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xc4>
            Slab* tmp = head;
    80001d38:	000017b7          	lui	a5,0x1
    80001d3c:	00f507b3          	add	a5,a0,a5
    80001d40:	8287b783          	ld	a5,-2008(a5) # 828 <_entry-0x7ffff7d8>
    80001d44:	0487b583          	ld	a1,72(a5)
    80001d48:	00001097          	auipc	ra,0x1
    80001d4c:	8b0080e7          	jalr	-1872(ra) # 800025f8 <_ZN5Buddy4freeEPvm>
            Buddy::free(tmp, head->parent->slabSize);
    80001d50:	00093783          	ld	a5,0(s2)
    80001d54:	0087b783          	ld	a5,8(a5)
    80001d58:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d5c:	fd5ff06f          	j	80001d30 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x94>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001d60:	0004b583          	ld	a1,0(s1)
    80001d64:	0000b517          	auipc	a0,0xb
    80001d68:	75453503          	ld	a0,1876(a0) # 8000d4b8 <_ZN13SlabAllocator5cacheE>
    80001d6c:	00000097          	auipc	ra,0x0
    80001d70:	de0080e7          	jalr	-544(ra) # 80001b4c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001d74:	0004b023          	sd	zero,0(s1)
}
    80001d78:	01813083          	ld	ra,24(sp)
    80001d7c:	01013403          	ld	s0,16(sp)
    80001d80:	00813483          	ld	s1,8(sp)
    80001d84:	00013903          	ld	s2,0(sp)
    80001d88:	02010113          	addi	sp,sp,32
    80001d8c:	00008067          	ret

0000000080001d90 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001d90:	ff010113          	addi	sp,sp,-16
    80001d94:	00813423          	sd	s0,8(sp)
    80001d98:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001d9c:	03f50513          	addi	a0,a0,63
    80001da0:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001da4:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001da8:	00100513          	li	a0,1
    asm("ecall");
    80001dac:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001db0:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001db4:	00813403          	ld	s0,8(sp)
    80001db8:	01010113          	addi	sp,sp,16
    80001dbc:	00008067          	ret

0000000080001dc0 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001dc0:	ff010113          	addi	sp,sp,-16
    80001dc4:	00813423          	sd	s0,8(sp)
    80001dc8:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001dcc:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001dd0:	00200513          	li	a0,2
    asm("ecall");
    80001dd4:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80001dd8:	00050513          	mv	a0,a0
    return status;
}
    80001ddc:	0005051b          	sext.w	a0,a0
    80001de0:	00813403          	ld	s0,8(sp)
    80001de4:	01010113          	addi	sp,sp,16
    80001de8:	00008067          	ret

0000000080001dec <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    80001dec:	fd010113          	addi	sp,sp,-48
    80001df0:	02113423          	sd	ra,40(sp)
    80001df4:	02813023          	sd	s0,32(sp)
    80001df8:	00913c23          	sd	s1,24(sp)
    80001dfc:	01213823          	sd	s2,16(sp)
    80001e00:	01313423          	sd	s3,8(sp)
    80001e04:	03010413          	addi	s0,sp,48
    80001e08:	00050913          	mv	s2,a0
    80001e0c:	00058493          	mv	s1,a1
    80001e10:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001e14:	04058663          	beqz	a1,80001e60 <_Z13thread_createPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001e18:	00001537          	lui	a0,0x1
    80001e1c:	00000097          	auipc	ra,0x0
    80001e20:	f74080e7          	jalr	-140(ra) # 80001d90 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001e24:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001e28:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001e2c:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001e30:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80001e34:	01100513          	li	a0,17

    asm("ecall");
    80001e38:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e3c:	00050513          	mv	a0,a0

    return status;
}
    80001e40:	0005051b          	sext.w	a0,a0
    80001e44:	02813083          	ld	ra,40(sp)
    80001e48:	02013403          	ld	s0,32(sp)
    80001e4c:	01813483          	ld	s1,24(sp)
    80001e50:	01013903          	ld	s2,16(sp)
    80001e54:	00813983          	ld	s3,8(sp)
    80001e58:	03010113          	addi	sp,sp,48
    80001e5c:	00008067          	ret
    uint64 istack = 0;
    80001e60:	00000513          	li	a0,0
    80001e64:	fc1ff06f          	j	80001e24 <_Z13thread_createPP7_threadPFvPvES2_+0x38>

0000000080001e68 <_Z11thread_exitv>:

int thread_exit(){
    80001e68:	ff010113          	addi	sp,sp,-16
    80001e6c:	00813423          	sd	s0,8(sp)
    80001e70:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001e74:	01200513          	li	a0,18

    asm("ecall");
    80001e78:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e7c:	00050513          	mv	a0,a0

    return status;
}
    80001e80:	0005051b          	sext.w	a0,a0
    80001e84:	00813403          	ld	s0,8(sp)
    80001e88:	01010113          	addi	sp,sp,16
    80001e8c:	00008067          	ret

0000000080001e90 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001e90:	ff010113          	addi	sp,sp,-16
    80001e94:	00813423          	sd	s0,8(sp)
    80001e98:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001e9c:	01300513          	li	a0,19

    asm("ecall");
    80001ea0:	00000073          	ecall
}
    80001ea4:	00813403          	ld	s0,8(sp)
    80001ea8:	01010113          	addi	sp,sp,16
    80001eac:	00008067          	ret

0000000080001eb0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001eb0:	fd010113          	addi	sp,sp,-48
    80001eb4:	02113423          	sd	ra,40(sp)
    80001eb8:	02813023          	sd	s0,32(sp)
    80001ebc:	00913c23          	sd	s1,24(sp)
    80001ec0:	01213823          	sd	s2,16(sp)
    80001ec4:	01313423          	sd	s3,8(sp)
    80001ec8:	03010413          	addi	s0,sp,48
    80001ecc:	00050913          	mv	s2,a0
    80001ed0:	00058493          	mv	s1,a1
    80001ed4:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001ed8:	04058663          	beqz	a1,80001f24 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001edc:	00001537          	lui	a0,0x1
    80001ee0:	00000097          	auipc	ra,0x0
    80001ee4:	eb0080e7          	jalr	-336(ra) # 80001d90 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001ee8:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001eec:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001ef0:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001ef4:	00090593          	mv	a1,s2
    asm("li a0, 0x14");
    80001ef8:	01400513          	li	a0,20

    asm("ecall");
    80001efc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f00:	00050513          	mv	a0,a0

    return status;
}
    80001f04:	0005051b          	sext.w	a0,a0
    80001f08:	02813083          	ld	ra,40(sp)
    80001f0c:	02013403          	ld	s0,32(sp)
    80001f10:	01813483          	ld	s1,24(sp)
    80001f14:	01013903          	ld	s2,16(sp)
    80001f18:	00813983          	ld	s3,8(sp)
    80001f1c:	03010113          	addi	sp,sp,48
    80001f20:	00008067          	ret
    uint64 istack = 0;
    80001f24:	00000513          	li	a0,0
    80001f28:	fc1ff06f          	j	80001ee8 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x38>

0000000080001f2c <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    80001f2c:	ff010113          	addi	sp,sp,-16
    80001f30:	00813423          	sd	s0,8(sp)
    80001f34:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f38:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001f3c:	01500513          	li	a0,21

    asm("ecall");
    80001f40:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f44:	00050513          	mv	a0,a0

    return status;
}
    80001f48:	0005051b          	sext.w	a0,a0
    80001f4c:	00813403          	ld	s0,8(sp)
    80001f50:	01010113          	addi	sp,sp,16
    80001f54:	00008067          	ret

0000000080001f58 <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    80001f58:	ff010113          	addi	sp,sp,-16
    80001f5c:	00813423          	sd	s0,8(sp)
    80001f60:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001f64:	02059593          	slli	a1,a1,0x20
    80001f68:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001f6c:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f70:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001f74:	02100513          	li	a0,33


    asm("ecall");
    80001f78:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f7c:	00050513          	mv	a0,a0

    return status;

}
    80001f80:	0005051b          	sext.w	a0,a0
    80001f84:	00813403          	ld	s0,8(sp)
    80001f88:	01010113          	addi	sp,sp,16
    80001f8c:	00008067          	ret

0000000080001f90 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001f90:	ff010113          	addi	sp,sp,-16
    80001f94:	00813423          	sd	s0,8(sp)
    80001f98:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f9c:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80001fa0:	02200513          	li	a0,34


    asm("ecall");
    80001fa4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fa8:	00050513          	mv	a0,a0

    return status;
}
    80001fac:	0005051b          	sext.w	a0,a0
    80001fb0:	00813403          	ld	s0,8(sp)
    80001fb4:	01010113          	addi	sp,sp,16
    80001fb8:	00008067          	ret

0000000080001fbc <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80001fbc:	ff010113          	addi	sp,sp,-16
    80001fc0:	00813423          	sd	s0,8(sp)
    80001fc4:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001fc8:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80001fcc:	02300513          	li	a0,35


    asm("ecall");
    80001fd0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fd4:	00050513          	mv	a0,a0

    return status;
}
    80001fd8:	0005051b          	sext.w	a0,a0
    80001fdc:	00813403          	ld	s0,8(sp)
    80001fe0:	01010113          	addi	sp,sp,16
    80001fe4:	00008067          	ret

0000000080001fe8 <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    80001fe8:	ff010113          	addi	sp,sp,-16
    80001fec:	00813423          	sd	s0,8(sp)
    80001ff0:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001ff4:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    80001ff8:	02400513          	li	a0,36


    asm("ecall");
    80001ffc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002000:	00050513          	mv	a0,a0

    return status;
}
    80002004:	0005051b          	sext.w	a0,a0
    80002008:	00813403          	ld	s0,8(sp)
    8000200c:	01010113          	addi	sp,sp,16
    80002010:	00008067          	ret

0000000080002014 <_Z10time_sleepm>:

int time_sleep(time_t time){
    80002014:	ff010113          	addi	sp,sp,-16
    80002018:	00813423          	sd	s0,8(sp)
    8000201c:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    80002020:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    80002024:	03100513          	li	a0,49


    asm("ecall");
    80002028:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000202c:	00050513          	mv	a0,a0

    return status;
}
    80002030:	0005051b          	sext.w	a0,a0
    80002034:	00813403          	ld	s0,8(sp)
    80002038:	01010113          	addi	sp,sp,16
    8000203c:	00008067          	ret

0000000080002040 <_Z4getcv>:

char getc(){
    80002040:	ff010113          	addi	sp,sp,-16
    80002044:	00813423          	sd	s0,8(sp)
    80002048:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    8000204c:	04100513          	li	a0,65

    asm("ecall");
    80002050:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    80002054:	00050513          	mv	a0,a0

    return c;
}
    80002058:	0ff57513          	andi	a0,a0,255
    8000205c:	00813403          	ld	s0,8(sp)
    80002060:	01010113          	addi	sp,sp,16
    80002064:	00008067          	ret

0000000080002068 <_Z4putcc>:

void putc(char c){
    80002068:	ff010113          	addi	sp,sp,-16
    8000206c:	00813423          	sd	s0,8(sp)
    80002070:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    80002074:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    80002078:	04200513          	li	a0,66

    asm("ecall");
    8000207c:	00000073          	ecall
}
    80002080:	00813403          	ld	s0,8(sp)
    80002084:	01010113          	addi	sp,sp,16
    80002088:	00008067          	ret

000000008000208c <_Z4forkv>:


int fork(){
    8000208c:	ff010113          	addi	sp,sp,-16
    80002090:	00813423          	sd	s0,8(sp)
    80002094:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    80002098:	06100513          	li	a0,97

    asm("ecall");
    8000209c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800020a0:	00050513          	mv	a0,a0

    return status;
}
    800020a4:	0005051b          	sext.w	a0,a0
    800020a8:	00813403          	ld	s0,8(sp)
    800020ac:	01010113          	addi	sp,sp,16
    800020b0:	00008067          	ret

00000000800020b4 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    800020b4:	ff010113          	addi	sp,sp,-16
    800020b8:	00113423          	sd	ra,8(sp)
    800020bc:	00813023          	sd	s0,0(sp)
    800020c0:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    800020c4:	00000097          	auipc	ra,0x0
    800020c8:	ecc080e7          	jalr	-308(ra) # 80001f90 <_Z9sem_closeP10_semaphore>
}
    800020cc:	00813083          	ld	ra,8(sp)
    800020d0:	00013403          	ld	s0,0(sp)
    800020d4:	01010113          	addi	sp,sp,16
    800020d8:	00008067          	ret

00000000800020dc <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    800020dc:	ff010113          	addi	sp,sp,-16
    800020e0:	00113423          	sd	ra,8(sp)
    800020e4:	00813023          	sd	s0,0(sp)
    800020e8:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    800020ec:	00001097          	auipc	ra,0x1
    800020f0:	f48080e7          	jalr	-184(ra) # 80003034 <_ZN3TCB11thread_freeEPv>
    800020f4:	00813083          	ld	ra,8(sp)
    800020f8:	00013403          	ld	s0,0(sp)
    800020fc:	01010113          	addi	sp,sp,16
    80002100:	00008067          	ret

0000000080002104 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80002104:	ff010113          	addi	sp,sp,-16
    80002108:	00113423          	sd	ra,8(sp)
    8000210c:	00813023          	sd	s0,0(sp)
    80002110:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    80002114:	00004097          	auipc	ra,0x4
    80002118:	6b4080e7          	jalr	1716(ra) # 800067c8 <_Z8userMainv>
    8000211c:	00813083          	ld	ra,8(sp)
    80002120:	00013403          	ld	s0,0(sp)
    80002124:	01010113          	addi	sp,sp,16
    80002128:	00008067          	ret

000000008000212c <_ZN6SystemC1Ev>:
    if (!initialized) {
    8000212c:	0000b797          	auipc	a5,0xb
    80002130:	3a47c783          	lbu	a5,932(a5) # 8000d4d0 <_ZN6System11initializedE>
    80002134:	00078463          	beqz	a5,8000213c <_ZN6SystemC1Ev+0x10>
    80002138:	00008067          	ret
System::System() {
    8000213c:	99010113          	addi	sp,sp,-1648
    80002140:	66113423          	sd	ra,1640(sp)
    80002144:	66813023          	sd	s0,1632(sp)
    80002148:	64913c23          	sd	s1,1624(sp)
    8000214c:	65213823          	sd	s2,1616(sp)
    80002150:	67010413          	addi	s0,sp,1648
        initialized = true;
    80002154:	00100793          	li	a5,1
    80002158:	0000b717          	auipc	a4,0xb
    8000215c:	36f70c23          	sb	a5,888(a4) # 8000d4d0 <_ZN6System11initializedE>
        RiscV::initialize();
    80002160:	00002097          	auipc	ra,0x2
    80002164:	870080e7          	jalr	-1936(ra) # 800039d0 <_ZN5RiscV10initializeEv>
        kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80002168:	0000b797          	auipc	a5,0xb
    8000216c:	2087b783          	ld	a5,520(a5) # 8000d370 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002170:	0007b503          	ld	a0,0(a5)
    80002174:	00c55513          	srli	a0,a0,0xc
    80002178:	00250513          	addi	a0,a0,2 # 1002 <_entry-0x7fffeffe>
    8000217c:	000015b7          	lui	a1,0x1
    80002180:	00c51513          	slli	a0,a0,0xc
    80002184:	00003097          	auipc	ra,0x3
    80002188:	e10080e7          	jalr	-496(ra) # 80004f94 <_Z9kmem_initPvi>
        kmem_cache_t* cache1 = kmem_cache_create("Cache 1", sizeof(Test), nullptr, nullptr);
    8000218c:	00000693          	li	a3,0
    80002190:	00000613          	li	a2,0
    80002194:	03000593          	li	a1,48
    80002198:	00008517          	auipc	a0,0x8
    8000219c:	12050513          	addi	a0,a0,288 # 8000a2b8 <CONSOLE_STATUS+0x2a8>
    800021a0:	00003097          	auipc	ra,0x3
    800021a4:	e1c080e7          	jalr	-484(ra) # 80004fbc <_Z17kmem_cache_createPKcmPFvPvES3_>
    800021a8:	00050913          	mv	s2,a0
        for(int i = 0; i<size; i++)
    800021ac:	00000493          	li	s1,0
    800021b0:	0c700793          	li	a5,199
    800021b4:	0297c463          	blt	a5,s1,800021dc <_ZN6SystemC1Ev+0xb0>
            mem[i] = kmem_cache_alloc(cache1);
    800021b8:	00090513          	mv	a0,s2
    800021bc:	00003097          	auipc	ra,0x3
    800021c0:	e28080e7          	jalr	-472(ra) # 80004fe4 <_Z16kmem_cache_allocP5Cache>
    800021c4:	00349793          	slli	a5,s1,0x3
    800021c8:	fe040713          	addi	a4,s0,-32
    800021cc:	00f707b3          	add	a5,a4,a5
    800021d0:	9ca7b023          	sd	a0,-1600(a5)
        for(int i = 0; i<size; i++)
    800021d4:	0014849b          	addiw	s1,s1,1
    800021d8:	fd9ff06f          	j	800021b0 <_ZN6SystemC1Ev+0x84>
        for(int i=0;i<size;i++)
    800021dc:	00000493          	li	s1,0
    800021e0:	0c700793          	li	a5,199
    800021e4:	0297c463          	blt	a5,s1,8000220c <_ZN6SystemC1Ev+0xe0>
            kmem_cache_free(cache1, mem[i]);
    800021e8:	00349793          	slli	a5,s1,0x3
    800021ec:	fe040713          	addi	a4,s0,-32
    800021f0:	00f707b3          	add	a5,a4,a5
    800021f4:	9c07b583          	ld	a1,-1600(a5)
    800021f8:	00090513          	mv	a0,s2
    800021fc:	00003097          	auipc	ra,0x3
    80002200:	e10080e7          	jalr	-496(ra) # 8000500c <_Z15kmem_cache_freeP5CachePv>
        for(int i=0;i<size;i++)
    80002204:	0014849b          	addiw	s1,s1,1
    80002208:	fd9ff06f          	j	800021e0 <_ZN6SystemC1Ev+0xb4>
        kmem_cache_destroy(cache1);
    8000220c:	00090513          	mv	a0,s2
    80002210:	00003097          	auipc	ra,0x3
    80002214:	e24080e7          	jalr	-476(ra) # 80005034 <_Z18kmem_cache_destroyP5Cache>
        for(int i=0; i<BUCKET_SIZE;i++)
    80002218:	00000493          	li	s1,0
    8000221c:	00c00793          	li	a5,12
    80002220:	0297c263          	blt	a5,s1,80002244 <_ZN6SystemC1Ev+0x118>
            SlabAllocator::deleteCache(SlabAllocator::sizeN[i]);
    80002224:	00349793          	slli	a5,s1,0x3
    80002228:	0000b517          	auipc	a0,0xb
    8000222c:	15053503          	ld	a0,336(a0) # 8000d378 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002230:	00f50533          	add	a0,a0,a5
    80002234:	00000097          	auipc	ra,0x0
    80002238:	a68080e7          	jalr	-1432(ra) # 80001c9c <_ZN13SlabAllocator11deleteCacheERP5Cache>
        for(int i=0; i<BUCKET_SIZE;i++)
    8000223c:	0014849b          	addiw	s1,s1,1
    80002240:	fddff06f          	j	8000221c <_ZN6SystemC1Ev+0xf0>
        Buddy::printList();
    80002244:	00000097          	auipc	ra,0x0
    80002248:	540080e7          	jalr	1344(ra) # 80002784 <_ZN5Buddy9printListEv>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    8000224c:	00000613          	li	a2,0
    80002250:	00000597          	auipc	a1,0x0
    80002254:	eb458593          	addi	a1,a1,-332 # 80002104 <_ZN6System15userMainWrapperEPv>
    80002258:	99840513          	addi	a0,s0,-1640
    8000225c:	00000097          	auipc	ra,0x0
    80002260:	b90080e7          	jalr	-1136(ra) # 80001dec <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80002264:	99843783          	ld	a5,-1640(s0)
    80002268:	0107a703          	lw	a4,16(a5)
    8000226c:	00200793          	li	a5,2
    80002270:	00f70863          	beq	a4,a5,80002280 <_ZN6SystemC1Ev+0x154>
            thread_dispatch();
    80002274:	00000097          	auipc	ra,0x0
    80002278:	c1c080e7          	jalr	-996(ra) # 80001e90 <_Z15thread_dispatchv>
    8000227c:	fe9ff06f          	j	80002264 <_ZN6SystemC1Ev+0x138>
        RiscV::finalize();
    80002280:	00002097          	auipc	ra,0x2
    80002284:	928080e7          	jalr	-1752(ra) # 80003ba8 <_ZN5RiscV8finalizeEv>
}
    80002288:	66813083          	ld	ra,1640(sp)
    8000228c:	66013403          	ld	s0,1632(sp)
    80002290:	65813483          	ld	s1,1624(sp)
    80002294:	65013903          	ld	s2,1616(sp)
    80002298:	67010113          	addi	sp,sp,1648
    8000229c:	00008067          	ret

00000000800022a0 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    800022a0:	ff010113          	addi	sp,sp,-16
    800022a4:	00813423          	sd	s0,8(sp)
    800022a8:	01010413          	addi	s0,sp,16
    800022ac:	00100793          	li	a5,1
    800022b0:	00f50863          	beq	a0,a5,800022c0 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800022b4:	00813403          	ld	s0,8(sp)
    800022b8:	01010113          	addi	sp,sp,16
    800022bc:	00008067          	ret
    800022c0:	000107b7          	lui	a5,0x10
    800022c4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800022c8:	fef596e3          	bne	a1,a5,800022b4 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    800022cc:	0000b797          	auipc	a5,0xb
    800022d0:	0a47b783          	ld	a5,164(a5) # 8000d370 <_GLOBAL_OFFSET_TABLE_+0x18>
    800022d4:	0007b703          	ld	a4,0(a5)
    800022d8:	00c75793          	srli	a5,a4,0xc
    800022dc:	00278793          	addi	a5,a5,2
    800022e0:	00c79793          	slli	a5,a5,0xc
    800022e4:	0000b697          	auipc	a3,0xb
    800022e8:	1f468693          	addi	a3,a3,500 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022ec:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800022f0:	fffff7b7          	lui	a5,0xfffff
    800022f4:	00f77733          	and	a4,a4,a5
    800022f8:	00e6b423          	sd	a4,8(a3)
    800022fc:	fb9ff06f          	j	800022b4 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002300 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80002300:	ff010113          	addi	sp,sp,-16
    80002304:	00813423          	sd	s0,8(sp)
    80002308:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    8000230c:	0000b717          	auipc	a4,0xb
    80002310:	1cc70713          	addi	a4,a4,460 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002314:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002318:	0000b797          	auipc	a5,0xb
    8000231c:	0587b783          	ld	a5,88(a5) # 8000d370 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002320:	0007b783          	ld	a5,0(a5)
    80002324:	fffff6b7          	lui	a3,0xfffff
    80002328:	00d7f7b3          	and	a5,a5,a3
    8000232c:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80002330:	0000b797          	auipc	a5,0xb
    80002334:	deb7bc23          	sd	a1,-520(a5) # 8000d128 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80002338:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    8000233c:	00000713          	li	a4,0
        while(num>1){
    80002340:	00100693          	li	a3,1
    80002344:	00f6f863          	bgeu	a3,a5,80002354 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80002348:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000234c:	00170713          	addi	a4,a4,1
        while(num>1){
    80002350:	ff1ff06f          	j	80002340 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80002354:	00371713          	slli	a4,a4,0x3
    80002358:	0000b797          	auipc	a5,0xb
    8000235c:	18078793          	addi	a5,a5,384 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002360:	00e78733          	add	a4,a5,a4
    80002364:	00a73823          	sd	a0,16(a4)
    80002368:	00058793          	mv	a5,a1
        uint64 deg = 0;
    8000236c:	00000713          	li	a4,0
        while(num>1){
    80002370:	00100693          	li	a3,1
    80002374:	00f6f863          	bgeu	a3,a5,80002384 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80002378:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000237c:	00170713          	addi	a4,a4,1
        while(num>1){
    80002380:	ff1ff06f          	j	80002370 <_ZN5Buddy10initializeEPvm+0x70>
    80002384:	00371713          	slli	a4,a4,0x3
    80002388:	0000b797          	auipc	a5,0xb
    8000238c:	15078793          	addi	a5,a5,336 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002390:	00e78733          	add	a4,a5,a4
    80002394:	06a73c23          	sd	a0,120(a4)
    80002398:	00058793          	mv	a5,a1
        uint64 deg = 0;
    8000239c:	00000713          	li	a4,0
        while(num>1){
    800023a0:	00100693          	li	a3,1
    800023a4:	00f6f863          	bgeu	a3,a5,800023b4 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    800023a8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800023ac:	00170713          	addi	a4,a4,1
        while(num>1){
    800023b0:	ff1ff06f          	j	800023a0 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    800023b4:	00371713          	slli	a4,a4,0x3
    800023b8:	0000b797          	auipc	a5,0xb
    800023bc:	12078793          	addi	a5,a5,288 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023c0:	00e78733          	add	a4,a5,a4
    800023c4:	01073783          	ld	a5,16(a4)
    800023c8:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    800023cc:	00000793          	li	a5,0
    800023d0:	00c0006f          	j	800023dc <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    800023d4:	0015d593          	srli	a1,a1,0x1
            deg++;
    800023d8:	00178793          	addi	a5,a5,1
        while(num>1){
    800023dc:	00100713          	li	a4,1
    800023e0:	feb76ae3          	bltu	a4,a1,800023d4 <_ZN5Buddy10initializeEPvm+0xd4>
    800023e4:	00379793          	slli	a5,a5,0x3
    800023e8:	0000b717          	auipc	a4,0xb
    800023ec:	0f070713          	addi	a4,a4,240 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023f0:	00f707b3          	add	a5,a4,a5
    800023f4:	0787b783          	ld	a5,120(a5)
    800023f8:	0007b023          	sd	zero,0(a5)
}
    800023fc:	00813403          	ld	s0,8(sp)
    80002400:	01010113          	addi	sp,sp,16
    80002404:	00008067          	ret

0000000080002408 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80002408:	00c00793          	li	a5,12
    8000240c:	10f50063          	beq	a0,a5,8000250c <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80002410:	fd010113          	addi	sp,sp,-48
    80002414:	02113423          	sd	ra,40(sp)
    80002418:	02813023          	sd	s0,32(sp)
    8000241c:	00913c23          	sd	s1,24(sp)
    80002420:	01213823          	sd	s2,16(sp)
    80002424:	01313423          	sd	s3,8(sp)
    80002428:	03010413          	addi	s0,sp,48
    8000242c:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80002430:	00351713          	slli	a4,a0,0x3
    80002434:	0000b797          	auipc	a5,0xb
    80002438:	0a478793          	addi	a5,a5,164 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000243c:	00e787b3          	add	a5,a5,a4
    80002440:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002444:	00000993          	li	s3,0
    80002448:	0180006f          	j	80002460 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    8000244c:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80002450:	04f70463          	beq	a4,a5,80002498 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80002454:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80002458:	08f70063          	beq	a4,a5,800024d8 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    8000245c:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80002460:	08048863          	beqz	s1,800024f0 <_ZN5Buddy8compressEm+0xe8>
    80002464:	0004b683          	ld	a3,0(s1)
    80002468:	08068463          	beqz	a3,800024f0 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    8000246c:	0000b797          	auipc	a5,0xb
    80002470:	06c7b783          	ld	a5,108(a5) # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002474:	40f48733          	sub	a4,s1,a5
    80002478:	00c9061b          	addiw	a2,s2,12
    8000247c:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002480:	40f687b3          	sub	a5,a3,a5
    80002484:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002488:	00177613          	andi	a2,a4,1
    8000248c:	fc0610e3          	bnez	a2,8000244c <_ZN5Buddy8compressEm+0x44>
    80002490:	00170713          	addi	a4,a4,1
    80002494:	fbdff06f          	j	80002450 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80002498:	00098863          	beqz	s3,800024a8 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    8000249c:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffec700>
    800024a0:	00d9b023          	sd	a3,0(s3)
    800024a4:	fb5ff06f          	j	80002458 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    800024a8:	0006b603          	ld	a2,0(a3)
    800024ac:	00391593          	slli	a1,s2,0x3
    800024b0:	0000b697          	auipc	a3,0xb
    800024b4:	02868693          	addi	a3,a3,40 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024b8:	00b686b3          	add	a3,a3,a1
    800024bc:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    800024c0:	f8061ce3          	bnez	a2,80002458 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    800024c4:	0000b697          	auipc	a3,0xb
    800024c8:	01468693          	addi	a3,a3,20 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024cc:	00b686b3          	add	a3,a3,a1
    800024d0:	0006b823          	sd	zero,16(a3)
    800024d4:	f85ff06f          	j	80002458 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    800024d8:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    800024dc:	00190593          	addi	a1,s2,1
    800024e0:	00048513          	mv	a0,s1
    800024e4:	00000097          	auipc	ra,0x0
    800024e8:	02c080e7          	jalr	44(ra) # 80002510 <_ZN5Buddy6insertEPvm>
    800024ec:	f71ff06f          	j	8000245c <_ZN5Buddy8compressEm+0x54>
}
    800024f0:	02813083          	ld	ra,40(sp)
    800024f4:	02013403          	ld	s0,32(sp)
    800024f8:	01813483          	ld	s1,24(sp)
    800024fc:	01013903          	ld	s2,16(sp)
    80002500:	00813983          	ld	s3,8(sp)
    80002504:	03010113          	addi	sp,sp,48
    80002508:	00008067          	ret
    8000250c:	00008067          	ret

0000000080002510 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80002510:	00050693          	mv	a3,a0
    if(!head[size]){
    80002514:	00359713          	slli	a4,a1,0x3
    80002518:	0000b797          	auipc	a5,0xb
    8000251c:	fc078793          	addi	a5,a5,-64 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002520:	00e787b3          	add	a5,a5,a4
    80002524:	0787b783          	ld	a5,120(a5)
    80002528:	02078c63          	beqz	a5,80002560 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    8000252c:	ff010113          	addi	sp,sp,-16
    80002530:	00113423          	sd	ra,8(sp)
    80002534:	00813023          	sd	s0,0(sp)
    80002538:	01010413          	addi	s0,sp,16
    8000253c:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80002540:	00068713          	mv	a4,a3
    80002544:	04f6e063          	bltu	a3,a5,80002584 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80002548:	00000613          	li	a2,0
            while (iter != nullptr) {
    8000254c:	06078863          	beqz	a5,800025bc <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80002550:	04f76c63          	bltu	a4,a5,800025a8 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80002554:	00078613          	mv	a2,a5
                    iter = iter->next;
    80002558:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    8000255c:	ff1ff06f          	j	8000254c <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80002560:	0000b797          	auipc	a5,0xb
    80002564:	f7878793          	addi	a5,a5,-136 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002568:	00e78533          	add	a0,a5,a4
    8000256c:	00d53823          	sd	a3,16(a0)
    80002570:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80002574:	0006b023          	sd	zero,0(a3)
    80002578:	07853783          	ld	a5,120(a0)
    8000257c:	0007b023          	sd	zero,0(a5)
        return;
    80002580:	00008067          	ret
            newHead->next = head[size];
    80002584:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80002588:	00359713          	slli	a4,a1,0x3
    8000258c:	0000b797          	auipc	a5,0xb
    80002590:	f4c78793          	addi	a5,a5,-180 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002594:	00e787b3          	add	a5,a5,a4
    80002598:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    8000259c:	00000097          	auipc	ra,0x0
    800025a0:	e6c080e7          	jalr	-404(ra) # 80002408 <_ZN5Buddy8compressEm>
            return;
    800025a4:	0440006f          	j	800025e8 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    800025a8:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    800025ac:	00d63023          	sd	a3,0(a2)
                    compress(size);
    800025b0:	00000097          	auipc	ra,0x0
    800025b4:	e58080e7          	jalr	-424(ra) # 80002408 <_ZN5Buddy8compressEm>
                    return;
    800025b8:	0300006f          	j	800025e8 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    800025bc:	00351713          	slli	a4,a0,0x3
    800025c0:	0000b797          	auipc	a5,0xb
    800025c4:	f1878793          	addi	a5,a5,-232 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025c8:	00e787b3          	add	a5,a5,a4
    800025cc:	0107b703          	ld	a4,16(a5)
    800025d0:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    800025d4:	0107b703          	ld	a4,16(a5)
    800025d8:	00073703          	ld	a4,0(a4)
    800025dc:	00e7b823          	sd	a4,16(a5)
    compress(size);
    800025e0:	00000097          	auipc	ra,0x0
    800025e4:	e28080e7          	jalr	-472(ra) # 80002408 <_ZN5Buddy8compressEm>
}
    800025e8:	00813083          	ld	ra,8(sp)
    800025ec:	00013403          	ld	s0,0(sp)
    800025f0:	01010113          	addi	sp,sp,16
    800025f4:	00008067          	ret

00000000800025f8 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    800025f8:	02050663          	beqz	a0,80002624 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    800025fc:	ff010113          	addi	sp,sp,-16
    80002600:	00113423          	sd	ra,8(sp)
    80002604:	00813023          	sd	s0,0(sp)
    80002608:	01010413          	addi	s0,sp,16
    insert(addr,size);
    8000260c:	00000097          	auipc	ra,0x0
    80002610:	f04080e7          	jalr	-252(ra) # 80002510 <_ZN5Buddy6insertEPvm>
}
    80002614:	00813083          	ld	ra,8(sp)
    80002618:	00013403          	ld	s0,0(sp)
    8000261c:	01010113          	addi	sp,sp,16
    80002620:	00008067          	ret
    80002624:	00008067          	ret

0000000080002628 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002628:	ff010113          	addi	sp,sp,-16
    8000262c:	00813423          	sd	s0,8(sp)
    80002630:	01010413          	addi	s0,sp,16
    80002634:	03c0006f          	j	80002670 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002638:	00b5859b          	addiw	a1,a1,11
    8000263c:	00100713          	li	a4,1
    80002640:	00b715bb          	sllw	a1,a4,a1
    80002644:	00b505b3          	add	a1,a0,a1
    80002648:	00379693          	slli	a3,a5,0x3
    8000264c:	0000b717          	auipc	a4,0xb
    80002650:	e8c70713          	addi	a4,a4,-372 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002654:	00d70733          	add	a4,a4,a3
    80002658:	00b73823          	sd	a1,16(a4)
    8000265c:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80002660:	0005b023          	sd	zero,0(a1)
    80002664:	07873703          	ld	a4,120(a4)
    80002668:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    8000266c:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80002670:	fff5879b          	addiw	a5,a1,-1
    80002674:	04c7c863          	blt	a5,a2,800026c4 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80002678:	00379693          	slli	a3,a5,0x3
    8000267c:	0000b717          	auipc	a4,0xb
    80002680:	e5c70713          	addi	a4,a4,-420 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002684:	00d70733          	add	a4,a4,a3
    80002688:	01073683          	ld	a3,16(a4)
    8000268c:	fa0686e3          	beqz	a3,80002638 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002690:	00b5859b          	addiw	a1,a1,11
    80002694:	00100713          	li	a4,1
    80002698:	00b715bb          	sllw	a1,a4,a1
    8000269c:	00b505b3          	add	a1,a0,a1
    800026a0:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    800026a4:	00379693          	slli	a3,a5,0x3
    800026a8:	0000b717          	auipc	a4,0xb
    800026ac:	e3070713          	addi	a4,a4,-464 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026b0:	00d70733          	add	a4,a4,a3
    800026b4:	01073683          	ld	a3,16(a4)
    800026b8:	0006b683          	ld	a3,0(a3)
    800026bc:	00d73823          	sd	a3,16(a4)
    800026c0:	fadff06f          	j	8000266c <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    800026c4:	00813403          	ld	s0,8(sp)
    800026c8:	01010113          	addi	sp,sp,16
    800026cc:	00008067          	ret

00000000800026d0 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    800026d0:	fe010113          	addi	sp,sp,-32
    800026d4:	00113c23          	sd	ra,24(sp)
    800026d8:	00813823          	sd	s0,16(sp)
    800026dc:	00913423          	sd	s1,8(sp)
    800026e0:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    800026e4:	00c00793          	li	a5,12
    800026e8:	06a7ec63          	bltu	a5,a0,80002760 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800026ec:	00050593          	mv	a1,a0
    800026f0:	00c00793          	li	a5,12
    800026f4:	06b7ea63          	bltu	a5,a1,80002768 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    800026f8:	00359713          	slli	a4,a1,0x3
    800026fc:	0000b797          	auipc	a5,0xb
    80002700:	ddc78793          	addi	a5,a5,-548 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002704:	00e787b3          	add	a5,a5,a4
    80002708:	0787b483          	ld	s1,120(a5)
    8000270c:	00049663          	bnez	s1,80002718 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002710:	00158593          	addi	a1,a1,1
    80002714:	fddff06f          	j	800026f0 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80002718:	0004b703          	ld	a4,0(s1)
    8000271c:	00359693          	slli	a3,a1,0x3
    80002720:	0000b797          	auipc	a5,0xb
    80002724:	db878793          	addi	a5,a5,-584 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002728:	00d787b3          	add	a5,a5,a3
    8000272c:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002730:	00070e63          	beqz	a4,8000274c <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80002734:	0005061b          	sext.w	a2,a0
    80002738:	0005859b          	sext.w	a1,a1
    8000273c:	00048513          	mv	a0,s1
    80002740:	00000097          	auipc	ra,0x0
    80002744:	ee8080e7          	jalr	-280(ra) # 80002628 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80002748:	0240006f          	j	8000276c <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    8000274c:	0000b797          	auipc	a5,0xb
    80002750:	d8c78793          	addi	a5,a5,-628 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002754:	00d787b3          	add	a5,a5,a3
    80002758:	0007b823          	sd	zero,16(a5)
    8000275c:	fd9ff06f          	j	80002734 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002760:	00000493          	li	s1,0
    80002764:	0080006f          	j	8000276c <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80002768:	00000493          	li	s1,0
}
    8000276c:	00048513          	mv	a0,s1
    80002770:	01813083          	ld	ra,24(sp)
    80002774:	01013403          	ld	s0,16(sp)
    80002778:	00813483          	ld	s1,8(sp)
    8000277c:	02010113          	addi	sp,sp,32
    80002780:	00008067          	ret

0000000080002784 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002784:	fe010113          	addi	sp,sp,-32
    80002788:	00113c23          	sd	ra,24(sp)
    8000278c:	00813823          	sd	s0,16(sp)
    80002790:	00913423          	sd	s1,8(sp)
    80002794:	01213023          	sd	s2,0(sp)
    80002798:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    8000279c:	00000913          	li	s2,0
    800027a0:	0180006f          	j	800027b8 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    800027a4:	00008517          	auipc	a0,0x8
    800027a8:	ba450513          	addi	a0,a0,-1116 # 8000a348 <CONSOLE_STATUS+0x338>
    800027ac:	00002097          	auipc	ra,0x2
    800027b0:	640080e7          	jalr	1600(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800027b4:	0019091b          	addiw	s2,s2,1
    800027b8:	00c00793          	li	a5,12
    800027bc:	0727c663          	blt	a5,s2,80002828 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    800027c0:	00000613          	li	a2,0
    800027c4:	00a00593          	li	a1,10
    800027c8:	00090513          	mv	a0,s2
    800027cc:	00002097          	auipc	ra,0x2
    800027d0:	664080e7          	jalr	1636(ra) # 80004e30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    800027d4:	00008517          	auipc	a0,0x8
    800027d8:	aec50513          	addi	a0,a0,-1300 # 8000a2c0 <CONSOLE_STATUS+0x2b0>
    800027dc:	00002097          	auipc	ra,0x2
    800027e0:	610080e7          	jalr	1552(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    800027e4:	00391713          	slli	a4,s2,0x3
    800027e8:	0000b797          	auipc	a5,0xb
    800027ec:	cf078793          	addi	a5,a5,-784 # 8000d4d8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027f0:	00e787b3          	add	a5,a5,a4
    800027f4:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    800027f8:	fa0486e3          	beqz	s1,800027a4 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    800027fc:	00000613          	li	a2,0
    80002800:	00a00593          	li	a1,10
    80002804:	0004851b          	sext.w	a0,s1
    80002808:	00002097          	auipc	ra,0x2
    8000280c:	628080e7          	jalr	1576(ra) # 80004e30 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002810:	00008517          	auipc	a0,0x8
    80002814:	8d850513          	addi	a0,a0,-1832 # 8000a0e8 <CONSOLE_STATUS+0xd8>
    80002818:	00002097          	auipc	ra,0x2
    8000281c:	5d4080e7          	jalr	1492(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002820:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002824:	fd5ff06f          	j	800027f8 <_ZN5Buddy9printListEv+0x74>
    80002828:	01813083          	ld	ra,24(sp)
    8000282c:	01013403          	ld	s0,16(sp)
    80002830:	00813483          	ld	s1,8(sp)
    80002834:	00013903          	ld	s2,0(sp)
    80002838:	02010113          	addi	sp,sp,32
    8000283c:	00008067          	ret

0000000080002840 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002840:	ff010113          	addi	sp,sp,-16
    80002844:	00113423          	sd	ra,8(sp)
    80002848:	00813023          	sd	s0,0(sp)
    8000284c:	01010413          	addi	s0,sp,16
    80002850:	000105b7          	lui	a1,0x10
    80002854:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002858:	00100513          	li	a0,1
    8000285c:	00000097          	auipc	ra,0x0
    80002860:	a44080e7          	jalr	-1468(ra) # 800022a0 <_Z41__static_initialization_and_destruction_0ii>
    80002864:	00813083          	ld	ra,8(sp)
    80002868:	00013403          	ld	s0,0(sp)
    8000286c:	01010113          	addi	sp,sp,16
    80002870:	00008067          	ret

0000000080002874 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002874:	fe010113          	addi	sp,sp,-32
    80002878:	00113c23          	sd	ra,24(sp)
    8000287c:	00813823          	sd	s0,16(sp)
    80002880:	00913423          	sd	s1,8(sp)
    80002884:	02010413          	addi	s0,sp,32
    80002888:	00050493          	mv	s1,a0
    LOCK();
    8000288c:	00100613          	li	a2,1
    80002890:	00000593          	li	a1,0
    80002894:	0000b517          	auipc	a0,0xb
    80002898:	d2450513          	addi	a0,a0,-732 # 8000d5b8 <lockPrint>
    8000289c:	ffffe097          	auipc	ra,0xffffe
    800028a0:	764080e7          	jalr	1892(ra) # 80001000 <copy_and_swap>
    800028a4:	fe0514e3          	bnez	a0,8000288c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800028a8:	0004c503          	lbu	a0,0(s1)
    800028ac:	00050a63          	beqz	a0,800028c0 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    800028b0:	fffff097          	auipc	ra,0xfffff
    800028b4:	7b8080e7          	jalr	1976(ra) # 80002068 <_Z4putcc>
        string++;
    800028b8:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800028bc:	fedff06f          	j	800028a8 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800028c0:	00000613          	li	a2,0
    800028c4:	00100593          	li	a1,1
    800028c8:	0000b517          	auipc	a0,0xb
    800028cc:	cf050513          	addi	a0,a0,-784 # 8000d5b8 <lockPrint>
    800028d0:	ffffe097          	auipc	ra,0xffffe
    800028d4:	730080e7          	jalr	1840(ra) # 80001000 <copy_and_swap>
    800028d8:	fe0514e3          	bnez	a0,800028c0 <_Z11printStringPKc+0x4c>
}
    800028dc:	01813083          	ld	ra,24(sp)
    800028e0:	01013403          	ld	s0,16(sp)
    800028e4:	00813483          	ld	s1,8(sp)
    800028e8:	02010113          	addi	sp,sp,32
    800028ec:	00008067          	ret

00000000800028f0 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800028f0:	fd010113          	addi	sp,sp,-48
    800028f4:	02113423          	sd	ra,40(sp)
    800028f8:	02813023          	sd	s0,32(sp)
    800028fc:	00913c23          	sd	s1,24(sp)
    80002900:	01213823          	sd	s2,16(sp)
    80002904:	01313423          	sd	s3,8(sp)
    80002908:	01413023          	sd	s4,0(sp)
    8000290c:	03010413          	addi	s0,sp,48
    80002910:	00050993          	mv	s3,a0
    80002914:	00058a13          	mv	s4,a1
    LOCK();
    80002918:	00100613          	li	a2,1
    8000291c:	00000593          	li	a1,0
    80002920:	0000b517          	auipc	a0,0xb
    80002924:	c9850513          	addi	a0,a0,-872 # 8000d5b8 <lockPrint>
    80002928:	ffffe097          	auipc	ra,0xffffe
    8000292c:	6d8080e7          	jalr	1752(ra) # 80001000 <copy_and_swap>
    80002930:	fe0514e3          	bnez	a0,80002918 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002934:	00000913          	li	s2,0
    80002938:	00090493          	mv	s1,s2
    8000293c:	0019091b          	addiw	s2,s2,1
    80002940:	03495a63          	bge	s2,s4,80002974 <_Z9getStringPci+0x84>
        cc = getc();
    80002944:	fffff097          	auipc	ra,0xfffff
    80002948:	6fc080e7          	jalr	1788(ra) # 80002040 <_Z4getcv>
        if(cc < 1)
    8000294c:	02050463          	beqz	a0,80002974 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002950:	009984b3          	add	s1,s3,s1
    80002954:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002958:	00a00793          	li	a5,10
    8000295c:	00f50a63          	beq	a0,a5,80002970 <_Z9getStringPci+0x80>
    80002960:	00d00793          	li	a5,13
    80002964:	fcf51ae3          	bne	a0,a5,80002938 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002968:	00090493          	mv	s1,s2
    8000296c:	0080006f          	j	80002974 <_Z9getStringPci+0x84>
    80002970:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002974:	009984b3          	add	s1,s3,s1
    80002978:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000297c:	00000613          	li	a2,0
    80002980:	00100593          	li	a1,1
    80002984:	0000b517          	auipc	a0,0xb
    80002988:	c3450513          	addi	a0,a0,-972 # 8000d5b8 <lockPrint>
    8000298c:	ffffe097          	auipc	ra,0xffffe
    80002990:	674080e7          	jalr	1652(ra) # 80001000 <copy_and_swap>
    80002994:	fe0514e3          	bnez	a0,8000297c <_Z9getStringPci+0x8c>
    return buf;
}
    80002998:	00098513          	mv	a0,s3
    8000299c:	02813083          	ld	ra,40(sp)
    800029a0:	02013403          	ld	s0,32(sp)
    800029a4:	01813483          	ld	s1,24(sp)
    800029a8:	01013903          	ld	s2,16(sp)
    800029ac:	00813983          	ld	s3,8(sp)
    800029b0:	00013a03          	ld	s4,0(sp)
    800029b4:	03010113          	addi	sp,sp,48
    800029b8:	00008067          	ret

00000000800029bc <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800029bc:	ff010113          	addi	sp,sp,-16
    800029c0:	00813423          	sd	s0,8(sp)
    800029c4:	01010413          	addi	s0,sp,16
    800029c8:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800029cc:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800029d0:	0006c603          	lbu	a2,0(a3)
    800029d4:	fd06071b          	addiw	a4,a2,-48
    800029d8:	0ff77713          	andi	a4,a4,255
    800029dc:	00900793          	li	a5,9
    800029e0:	02e7e063          	bltu	a5,a4,80002a00 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800029e4:	0025179b          	slliw	a5,a0,0x2
    800029e8:	00a787bb          	addw	a5,a5,a0
    800029ec:	0017979b          	slliw	a5,a5,0x1
    800029f0:	00168693          	addi	a3,a3,1
    800029f4:	00c787bb          	addw	a5,a5,a2
    800029f8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800029fc:	fd5ff06f          	j	800029d0 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002a00:	00813403          	ld	s0,8(sp)
    80002a04:	01010113          	addi	sp,sp,16
    80002a08:	00008067          	ret

0000000080002a0c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002a0c:	fc010113          	addi	sp,sp,-64
    80002a10:	02113c23          	sd	ra,56(sp)
    80002a14:	02813823          	sd	s0,48(sp)
    80002a18:	02913423          	sd	s1,40(sp)
    80002a1c:	03213023          	sd	s2,32(sp)
    80002a20:	01313c23          	sd	s3,24(sp)
    80002a24:	04010413          	addi	s0,sp,64
    80002a28:	00050493          	mv	s1,a0
    80002a2c:	00058913          	mv	s2,a1
    80002a30:	00060993          	mv	s3,a2
    LOCK();
    80002a34:	00100613          	li	a2,1
    80002a38:	00000593          	li	a1,0
    80002a3c:	0000b517          	auipc	a0,0xb
    80002a40:	b7c50513          	addi	a0,a0,-1156 # 8000d5b8 <lockPrint>
    80002a44:	ffffe097          	auipc	ra,0xffffe
    80002a48:	5bc080e7          	jalr	1468(ra) # 80001000 <copy_and_swap>
    80002a4c:	fe0514e3          	bnez	a0,80002a34 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002a50:	00098463          	beqz	s3,80002a58 <_Z8printIntiii+0x4c>
    80002a54:	0804c463          	bltz	s1,80002adc <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002a58:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002a5c:	00000593          	li	a1,0
    }

    i = 0;
    80002a60:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002a64:	0009079b          	sext.w	a5,s2
    80002a68:	0325773b          	remuw	a4,a0,s2
    80002a6c:	00048613          	mv	a2,s1
    80002a70:	0014849b          	addiw	s1,s1,1
    80002a74:	02071693          	slli	a3,a4,0x20
    80002a78:	0206d693          	srli	a3,a3,0x20
    80002a7c:	0000a717          	auipc	a4,0xa
    80002a80:	6b470713          	addi	a4,a4,1716 # 8000d130 <digits>
    80002a84:	00d70733          	add	a4,a4,a3
    80002a88:	00074683          	lbu	a3,0(a4)
    80002a8c:	fd040713          	addi	a4,s0,-48
    80002a90:	00c70733          	add	a4,a4,a2
    80002a94:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002a98:	0005071b          	sext.w	a4,a0
    80002a9c:	0325553b          	divuw	a0,a0,s2
    80002aa0:	fcf772e3          	bgeu	a4,a5,80002a64 <_Z8printIntiii+0x58>
    if(neg)
    80002aa4:	00058c63          	beqz	a1,80002abc <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002aa8:	fd040793          	addi	a5,s0,-48
    80002aac:	009784b3          	add	s1,a5,s1
    80002ab0:	02d00793          	li	a5,45
    80002ab4:	fef48823          	sb	a5,-16(s1)
    80002ab8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002abc:	fff4849b          	addiw	s1,s1,-1
    80002ac0:	0204c463          	bltz	s1,80002ae8 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002ac4:	fd040793          	addi	a5,s0,-48
    80002ac8:	009787b3          	add	a5,a5,s1
    80002acc:	ff07c503          	lbu	a0,-16(a5)
    80002ad0:	fffff097          	auipc	ra,0xfffff
    80002ad4:	598080e7          	jalr	1432(ra) # 80002068 <_Z4putcc>
    80002ad8:	fe5ff06f          	j	80002abc <_Z8printIntiii+0xb0>
        x = -xx;
    80002adc:	4090053b          	negw	a0,s1
        neg = 1;
    80002ae0:	00100593          	li	a1,1
        x = -xx;
    80002ae4:	f7dff06f          	j	80002a60 <_Z8printIntiii+0x54>

    UNLOCK();
    80002ae8:	00000613          	li	a2,0
    80002aec:	00100593          	li	a1,1
    80002af0:	0000b517          	auipc	a0,0xb
    80002af4:	ac850513          	addi	a0,a0,-1336 # 8000d5b8 <lockPrint>
    80002af8:	ffffe097          	auipc	ra,0xffffe
    80002afc:	508080e7          	jalr	1288(ra) # 80001000 <copy_and_swap>
    80002b00:	fe0514e3          	bnez	a0,80002ae8 <_Z8printIntiii+0xdc>
    80002b04:	03813083          	ld	ra,56(sp)
    80002b08:	03013403          	ld	s0,48(sp)
    80002b0c:	02813483          	ld	s1,40(sp)
    80002b10:	02013903          	ld	s2,32(sp)
    80002b14:	01813983          	ld	s3,24(sp)
    80002b18:	04010113          	addi	sp,sp,64
    80002b1c:	00008067          	ret

0000000080002b20 <_ZN3SCBC1Em>:
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"


SCB::SCB(uint64 init){
    80002b20:	ff010113          	addi	sp,sp,-16
    80002b24:	00813423          	sd	s0,8(sp)
    80002b28:	01010413          	addi	s0,sp,16
    val = init;
    80002b2c:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    80002b30:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    80002b34:	00053823          	sd	zero,16(a0)
}
    80002b38:	00813403          	ld	s0,8(sp)
    80002b3c:	01010113          	addi	sp,sp,16
    80002b40:	00008067          	ret

0000000080002b44 <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    80002b44:	fe010113          	addi	sp,sp,-32
    80002b48:	00113c23          	sd	ra,24(sp)
    80002b4c:	00813823          	sd	s0,16(sp)
    80002b50:	00913423          	sd	s1,8(sp)
    80002b54:	01213023          	sd	s2,0(sp)
    80002b58:	02010413          	addi	s0,sp,32
    80002b5c:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002b60:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002b64:	02050063          	beqz	a0,80002b84 <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    80002b68:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002b6c:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002b70:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002b74:	00002097          	auipc	ra,0x2
    80002b78:	df4080e7          	jalr	-524(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002b7c:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002b80:	fe5ff06f          	j	80002b64 <_ZN3SCBD1Ev+0x20>
    }
}
    80002b84:	01813083          	ld	ra,24(sp)
    80002b88:	01013403          	ld	s0,16(sp)
    80002b8c:	00813483          	ld	s1,8(sp)
    80002b90:	00013903          	ld	s2,0(sp)
    80002b94:	02010113          	addi	sp,sp,32
    80002b98:	00008067          	ret

0000000080002b9c <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    80002b9c:	ff010113          	addi	sp,sp,-16
    80002ba0:	00113423          	sd	ra,8(sp)
    80002ba4:	00813023          	sd	s0,0(sp)
    80002ba8:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002bac:	00853783          	ld	a5,8(a0)
    80002bb0:	04078063          	beqz	a5,80002bf0 <_ZN3SCB5blockEv+0x54>
    80002bb4:	01053703          	ld	a4,16(a0)
    80002bb8:	0000b797          	auipc	a5,0xb
    80002bbc:	8307b783          	ld	a5,-2000(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002bc0:	0007b783          	ld	a5,0(a5)
    80002bc4:	04f73423          	sd	a5,72(a4)
    80002bc8:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002bcc:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002bd0:	00300713          	li	a4,3
    80002bd4:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002bd8:	00000097          	auipc	ra,0x0
    80002bdc:	2c0080e7          	jalr	704(ra) # 80002e98 <_ZN3TCB8dispatchEv>
}
    80002be0:	00813083          	ld	ra,8(sp)
    80002be4:	00013403          	ld	s0,0(sp)
    80002be8:	01010113          	addi	sp,sp,16
    80002bec:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002bf0:	0000a797          	auipc	a5,0xa
    80002bf4:	7f87b783          	ld	a5,2040(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002bf8:	0007b783          	ld	a5,0(a5)
    80002bfc:	00f53423          	sd	a5,8(a0)
    80002c00:	fc9ff06f          	j	80002bc8 <_ZN3SCB5blockEv+0x2c>

0000000080002c04 <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    80002c04:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002c08:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002c0c:	04853703          	ld	a4,72(a0)
    80002c10:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002c14:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002c18:	02050a63          	beqz	a0,80002c4c <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002c1c:	ff010113          	addi	sp,sp,-16
    80002c20:	00113423          	sd	ra,8(sp)
    80002c24:	00813023          	sd	s0,0(sp)
    80002c28:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002c2c:	00100793          	li	a5,1
    80002c30:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002c34:	00002097          	auipc	ra,0x2
    80002c38:	d34080e7          	jalr	-716(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>
    }
}
    80002c3c:	00813083          	ld	ra,8(sp)
    80002c40:	00013403          	ld	s0,0(sp)
    80002c44:	01010113          	addi	sp,sp,16
    80002c48:	00008067          	ret
    80002c4c:	00008067          	ret

0000000080002c50 <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    80002c50:	0000a797          	auipc	a5,0xa
    80002c54:	7987b783          	ld	a5,1944(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002c58:	0007b783          	ld	a5,0(a5)
    80002c5c:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002c60:	00052783          	lw	a5,0(a0)
    80002c64:	fff7879b          	addiw	a5,a5,-1
    80002c68:	00f52023          	sw	a5,0(a0)
    80002c6c:	02079713          	slli	a4,a5,0x20
    80002c70:	00074463          	bltz	a4,80002c78 <_ZN3SCB4waitEv+0x28>
    80002c74:	00008067          	ret
void SCB::wait() {
    80002c78:	ff010113          	addi	sp,sp,-16
    80002c7c:	00113423          	sd	ra,8(sp)
    80002c80:	00813023          	sd	s0,0(sp)
    80002c84:	01010413          	addi	s0,sp,16
        block();
    80002c88:	00000097          	auipc	ra,0x0
    80002c8c:	f14080e7          	jalr	-236(ra) # 80002b9c <_ZN3SCB5blockEv>
}
    80002c90:	00813083          	ld	ra,8(sp)
    80002c94:	00013403          	ld	s0,0(sp)
    80002c98:	01010113          	addi	sp,sp,16
    80002c9c:	00008067          	ret

0000000080002ca0 <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    80002ca0:	00052783          	lw	a5,0(a0)
    80002ca4:	0017871b          	addiw	a4,a5,1
    80002ca8:	00e52023          	sw	a4,0(a0)
    80002cac:	0007c463          	bltz	a5,80002cb4 <_ZN3SCB6signalEv+0x14>
    80002cb0:	00008067          	ret
void SCB::signal(){
    80002cb4:	ff010113          	addi	sp,sp,-16
    80002cb8:	00113423          	sd	ra,8(sp)
    80002cbc:	00813023          	sd	s0,0(sp)
    80002cc0:	01010413          	addi	s0,sp,16
        deblock();
    80002cc4:	00000097          	auipc	ra,0x0
    80002cc8:	f40080e7          	jalr	-192(ra) # 80002c04 <_ZN3SCB7deblockEv>
}
    80002ccc:	00813083          	ld	ra,8(sp)
    80002cd0:	00013403          	ld	s0,0(sp)
    80002cd4:	01010113          	addi	sp,sp,16
    80002cd8:	00008067          	ret

0000000080002cdc <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    80002cdc:	ff010113          	addi	sp,sp,-16
    80002ce0:	00113423          	sd	ra,8(sp)
    80002ce4:	00813023          	sd	s0,0(sp)
    80002ce8:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002cec:	00000097          	auipc	ra,0x0
    80002cf0:	3f4080e7          	jalr	1012(ra) # 800030e0 <_ZN15MemoryAllocator7kmallocEm>
}
    80002cf4:	00813083          	ld	ra,8(sp)
    80002cf8:	00013403          	ld	s0,0(sp)
    80002cfc:	01010113          	addi	sp,sp,16
    80002d00:	00008067          	ret

0000000080002d04 <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    80002d04:	ff010113          	addi	sp,sp,-16
    80002d08:	00113423          	sd	ra,8(sp)
    80002d0c:	00813023          	sd	s0,0(sp)
    80002d10:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002d14:	00000097          	auipc	ra,0x0
    80002d18:	5f4080e7          	jalr	1524(ra) # 80003308 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002d1c:	00813083          	ld	ra,8(sp)
    80002d20:	00013403          	ld	s0,0(sp)
    80002d24:	01010113          	addi	sp,sp,16
    80002d28:	00008067          	ret

0000000080002d2c <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    80002d2c:	ff010113          	addi	sp,sp,-16
    80002d30:	00813423          	sd	s0,8(sp)
    80002d34:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002d38:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002d3c:	05200513          	li	a0,82
    asm("ecall");
    80002d40:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80002d44:	00050513          	mv	a0,a0
    return status;
}
    80002d48:	0005051b          	sext.w	a0,a0
    80002d4c:	00813403          	ld	s0,8(sp)
    80002d50:	01010113          	addi	sp,sp,16
    80002d54:	00008067          	ret

0000000080002d58 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002d58:	fe010113          	addi	sp,sp,-32
    80002d5c:	00113c23          	sd	ra,24(sp)
    80002d60:	00813823          	sd	s0,16(sp)
    80002d64:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002d68:	fe840513          	addi	a0,s0,-24
    80002d6c:	fffff097          	auipc	ra,0xfffff
    80002d70:	3c0080e7          	jalr	960(ra) # 8000212c <_ZN6SystemC1Ev>

    return 0;
    80002d74:	00000513          	li	a0,0
    80002d78:	01813083          	ld	ra,24(sp)
    80002d7c:	01013403          	ld	s0,16(sp)
    80002d80:	02010113          	addi	sp,sp,32
    80002d84:	00008067          	ret

0000000080002d88 <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    80002d88:	ff010113          	addi	sp,sp,-16
    80002d8c:	00113423          	sd	ra,8(sp)
    80002d90:	00813023          	sd	s0,0(sp)
    80002d94:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002d98:	00001097          	auipc	ra,0x1
    80002d9c:	c98080e7          	jalr	-872(ra) # 80003a30 <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    80002da0:	0000b797          	auipc	a5,0xb
    80002da4:	8207b783          	ld	a5,-2016(a5) # 8000d5c0 <_ZN3TCB7runningE>
    80002da8:	0187b703          	ld	a4,24(a5)
    80002dac:	0207b503          	ld	a0,32(a5)
    80002db0:	000700e7          	jalr	a4

    thread_exit();
    80002db4:	fffff097          	auipc	ra,0xfffff
    80002db8:	0b4080e7          	jalr	180(ra) # 80001e68 <_Z11thread_exitv>
}
    80002dbc:	00813083          	ld	ra,8(sp)
    80002dc0:	00013403          	ld	s0,0(sp)
    80002dc4:	01010113          	addi	sp,sp,16
    80002dc8:	00008067          	ret

0000000080002dcc <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002dcc:	ff010113          	addi	sp,sp,-16
    80002dd0:	00813423          	sd	s0,8(sp)
    80002dd4:	01010413          	addi	s0,sp,16
    80002dd8:	04053823          	sd	zero,80(a0)
    80002ddc:	04053c23          	sd	zero,88(a0)
    80002de0:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002de4:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002de8:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002dec:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002df0:	04058263          	beqz	a1,80002e34 <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    80002df4:	00068793          	mv	a5,a3
    80002df8:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    80002dfc:	00100793          	li	a5,1
    80002e00:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    80002e04:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002e08:	02058a63          	beqz	a1,80002e3c <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    80002e0c:	000017b7          	lui	a5,0x1
    80002e10:	00f686b3          	add	a3,a3,a5
    80002e14:	00d53023          	sd	a3,0(a0)
    80002e18:	00000797          	auipc	a5,0x0
    80002e1c:	f7078793          	addi	a5,a5,-144 # 80002d88 <_ZN3TCB7wrapperEPv>
    80002e20:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    80002e24:	00052a23          	sw	zero,20(a0)
}
    80002e28:	00813403          	ld	s0,8(sp)
    80002e2c:	01010113          	addi	sp,sp,16
    80002e30:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002e34:	00000793          	li	a5,0
    80002e38:	fc1ff06f          	j	80002df8 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002e3c:	00000693          	li	a3,0
    80002e40:	fd5ff06f          	j	80002e14 <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

0000000080002e44 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002e44:	ff010113          	addi	sp,sp,-16
    80002e48:	00113423          	sd	ra,8(sp)
    80002e4c:	00813023          	sd	s0,0(sp)
    80002e50:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(stack);
    80002e54:	02853503          	ld	a0,40(a0)
    80002e58:	00000097          	auipc	ra,0x0
    80002e5c:	4b0080e7          	jalr	1200(ra) # 80003308 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002e60:	00813083          	ld	ra,8(sp)
    80002e64:	00013403          	ld	s0,0(sp)
    80002e68:	01010113          	addi	sp,sp,16
    80002e6c:	00008067          	ret

0000000080002e70 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002e70:	ff010113          	addi	sp,sp,-16
    80002e74:	00113423          	sd	ra,8(sp)
    80002e78:	00813023          	sd	s0,0(sp)
    80002e7c:	01010413          	addi	s0,sp,16
    free();
    80002e80:	00000097          	auipc	ra,0x0
    80002e84:	fc4080e7          	jalr	-60(ra) # 80002e44 <_ZN3TCB4freeEv>
}
    80002e88:	00813083          	ld	ra,8(sp)
    80002e8c:	00013403          	ld	s0,0(sp)
    80002e90:	01010113          	addi	sp,sp,16
    80002e94:	00008067          	ret

0000000080002e98 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002e98:	fe010113          	addi	sp,sp,-32
    80002e9c:	00113c23          	sd	ra,24(sp)
    80002ea0:	00813823          	sd	s0,16(sp)
    80002ea4:	00913423          	sd	s1,8(sp)
    80002ea8:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002eac:	0000a497          	auipc	s1,0xa
    80002eb0:	7144b483          	ld	s1,1812(s1) # 8000d5c0 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002eb4:	0104a703          	lw	a4,16(s1)
    80002eb8:	00100793          	li	a5,1
    80002ebc:	04e7f663          	bgeu	a5,a4,80002f08 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002ec0:	00002097          	auipc	ra,0x2
    80002ec4:	af0080e7          	jalr	-1296(ra) # 800049b0 <_ZN9Scheduler3getEv>
    80002ec8:	0000a797          	auipc	a5,0xa
    80002ecc:	6ea7bc23          	sd	a0,1784(a5) # 8000d5c0 <_ZN3TCB7runningE>
    if(running) {
    80002ed0:	02050263          	beqz	a0,80002ef4 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002ed4:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002ed8:	00001097          	auipc	ra,0x1
    80002edc:	c8c080e7          	jalr	-884(ra) # 80003b64 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002ee0:	0000a597          	auipc	a1,0xa
    80002ee4:	6e05b583          	ld	a1,1760(a1) # 8000d5c0 <_ZN3TCB7runningE>
    80002ee8:	00048513          	mv	a0,s1
    80002eec:	ffffe097          	auipc	ra,0xffffe
    80002ef0:	254080e7          	jalr	596(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002ef4:	01813083          	ld	ra,24(sp)
    80002ef8:	01013403          	ld	s0,16(sp)
    80002efc:	00813483          	ld	s1,8(sp)
    80002f00:	02010113          	addi	sp,sp,32
    80002f04:	00008067          	ret
        Scheduler::put(old);
    80002f08:	00048513          	mv	a0,s1
    80002f0c:	00002097          	auipc	ra,0x2
    80002f10:	a5c080e7          	jalr	-1444(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>
    80002f14:	fadff06f          	j	80002ec0 <_ZN3TCB8dispatchEv+0x28>

0000000080002f18 <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002f18:	ff010113          	addi	sp,sp,-16
    80002f1c:	00113423          	sd	ra,8(sp)
    80002f20:	00813023          	sd	s0,0(sp)
    80002f24:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002f28:	00000097          	auipc	ra,0x0
    80002f2c:	1b8080e7          	jalr	440(ra) # 800030e0 <_ZN15MemoryAllocator7kmallocEm>
}
    80002f30:	00813083          	ld	ra,8(sp)
    80002f34:	00013403          	ld	s0,0(sp)
    80002f38:	01010113          	addi	sp,sp,16
    80002f3c:	00008067          	ret

0000000080002f40 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002f40:	fd010113          	addi	sp,sp,-48
    80002f44:	02113423          	sd	ra,40(sp)
    80002f48:	02813023          	sd	s0,32(sp)
    80002f4c:	00913c23          	sd	s1,24(sp)
    80002f50:	01213823          	sd	s2,16(sp)
    80002f54:	01313423          	sd	s3,8(sp)
    80002f58:	01413023          	sd	s4,0(sp)
    80002f5c:	03010413          	addi	s0,sp,48
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002f60:	07000513          	li	a0,112
    80002f64:	00000097          	auipc	ra,0x0
    80002f68:	fb4080e7          	jalr	-76(ra) # 80002f18 <_ZN3TCBnwEm>
    80002f6c:	00050493          	mv	s1,a0
    80002f70:	00200713          	li	a4,2
    80002f74:	00000693          	li	a3,0
    80002f78:	00000613          	li	a2,0
    80002f7c:	00000593          	li	a1,0
    80002f80:	00000097          	auipc	ra,0x0
    80002f84:	e4c080e7          	jalr	-436(ra) # 80002dcc <_ZN3TCBC1EPFvPvES0_Pmm>
    80002f88:	0000aa17          	auipc	s4,0xa
    80002f8c:	638a0a13          	addi	s4,s4,1592 # 8000d5c0 <_ZN3TCB7runningE>
    80002f90:	009a3023          	sd	s1,0(s4)
    TCB::running->mode = Mode::SUPERVISOR;
    80002f94:	00100993          	li	s3,1
    80002f98:	0134aa23          	sw	s3,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80002f9c:	04000513          	li	a0,64
    80002fa0:	00000097          	auipc	ra,0x0
    80002fa4:	140080e7          	jalr	320(ra) # 800030e0 <_ZN15MemoryAllocator7kmallocEm>
    80002fa8:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002fac:	07000513          	li	a0,112
    80002fb0:	00000097          	auipc	ra,0x0
    80002fb4:	f68080e7          	jalr	-152(ra) # 80002f18 <_ZN3TCBnwEm>
    80002fb8:	00050493          	mv	s1,a0
    80002fbc:	00200713          	li	a4,2
    80002fc0:	00090693          	mv	a3,s2
    80002fc4:	00000613          	li	a2,0
    80002fc8:	0000a597          	auipc	a1,0xa
    80002fcc:	3c05b583          	ld	a1,960(a1) # 8000d388 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002fd0:	00000097          	auipc	ra,0x0
    80002fd4:	dfc080e7          	jalr	-516(ra) # 80002dcc <_ZN3TCBC1EPFvPvES0_Pmm>
    80002fd8:	009a3423          	sd	s1,8(s4)
    putcThread->mode = Mode::SUPERVISOR;
    80002fdc:	0134aa23          	sw	s3,20(s1)
    Scheduler::put(putcThread);
    80002fe0:	00048513          	mv	a0,s1
    80002fe4:	00002097          	auipc	ra,0x2
    80002fe8:	984080e7          	jalr	-1660(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>
}
    80002fec:	02813083          	ld	ra,40(sp)
    80002ff0:	02013403          	ld	s0,32(sp)
    80002ff4:	01813483          	ld	s1,24(sp)
    80002ff8:	01013903          	ld	s2,16(sp)
    80002ffc:	00813983          	ld	s3,8(sp)
    80003000:	00013a03          	ld	s4,0(sp)
    80003004:	03010113          	addi	sp,sp,48
    80003008:	00008067          	ret

000000008000300c <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    8000300c:	ff010113          	addi	sp,sp,-16
    80003010:	00113423          	sd	ra,8(sp)
    80003014:	00813023          	sd	s0,0(sp)
    80003018:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    8000301c:	00000097          	auipc	ra,0x0
    80003020:	2ec080e7          	jalr	748(ra) # 80003308 <_ZN15MemoryAllocator5kfreeEPv>
}
    80003024:	00813083          	ld	ra,8(sp)
    80003028:	00013403          	ld	s0,0(sp)
    8000302c:	01010113          	addi	sp,sp,16
    80003030:	00008067          	ret

0000000080003034 <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    80003034:	ff010113          	addi	sp,sp,-16
    80003038:	00813423          	sd	s0,8(sp)
    8000303c:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80003040:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80003044:	05100513          	li	a0,81
    asm("ecall");
    80003048:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000304c:	00050513          	mv	a0,a0
    return status;
    80003050:	0005051b          	sext.w	a0,a0
    80003054:	00813403          	ld	s0,8(sp)
    80003058:	01010113          	addi	sp,sp,16
    8000305c:	00008067          	ret

0000000080003060 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80003060:	ff010113          	addi	sp,sp,-16
    80003064:	00813423          	sd	s0,8(sp)
    80003068:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    8000306c:	0000a797          	auipc	a5,0xa
    80003070:	3047b783          	ld	a5,772(a5) # 8000d370 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003074:	0007b603          	ld	a2,0(a5)
    80003078:	00c65793          	srli	a5,a2,0xc
    8000307c:	00278793          	addi	a5,a5,2
    80003080:	00c79793          	slli	a5,a5,0xc
    80003084:	01000737          	lui	a4,0x1000
    80003088:	00e787b3          	add	a5,a5,a4
    8000308c:	0000a717          	auipc	a4,0xa
    80003090:	55c70713          	addi	a4,a4,1372 # 8000d5e8 <_ZN15MemoryAllocator11freeMemTailE>
    80003094:	00f73023          	sd	a5,0(a4)
    80003098:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    8000309c:	0007b823          	sd	zero,16(a5)
    800030a0:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    800030a4:	00073823          	sd	zero,16(a4)
    800030a8:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    800030ac:	0000a697          	auipc	a3,0xa
    800030b0:	34c6b683          	ld	a3,844(a3) # 8000d3f8 <_GLOBAL_OFFSET_TABLE_+0xa0>
    800030b4:	0006b683          	ld	a3,0(a3)
    800030b8:	40c686b3          	sub	a3,a3,a2
    800030bc:	fe868693          	addi	a3,a3,-24
    800030c0:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800030c4:	00873783          	ld	a5,8(a4)
    800030c8:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800030cc:	00100793          	li	a5,1
    800030d0:	02f70023          	sb	a5,32(a4)
}
    800030d4:	00813403          	ld	s0,8(sp)
    800030d8:	01010113          	addi	sp,sp,16
    800030dc:	00008067          	ret

00000000800030e0 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800030e0:	ff010113          	addi	sp,sp,-16
    800030e4:	00813423          	sd	s0,8(sp)
    800030e8:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    800030ec:	14050263          	beqz	a0,80003230 <_ZN15MemoryAllocator7kmallocEm+0x150>
    800030f0:	00050793          	mv	a5,a0
    800030f4:	0000a517          	auipc	a0,0xa
    800030f8:	4fc53503          	ld	a0,1276(a0) # 8000d5f0 <_ZN15MemoryAllocator11freeMemHeadE>
    800030fc:	0a050a63          	beqz	a0,800031b0 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80003100:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80003104:	00000613          	li	a2,0
    80003108:	00c0006f          	j	80003114 <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    8000310c:	00050613          	mv	a2,a0
    80003110:	01053503          	ld	a0,16(a0)
    80003114:	00050863          	beqz	a0,80003124 <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80003118:	00053683          	ld	a3,0(a0)
    8000311c:	01878713          	addi	a4,a5,24
    80003120:	fee6e6e3          	bltu	a3,a4,8000310c <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80003124:	08050663          	beqz	a0,800031b0 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    80003128:	00053683          	ld	a3,0(a0)
    8000312c:	01868713          	addi	a4,a3,24
    80003130:	00e50733          	add	a4,a0,a4
    80003134:	0000a597          	auipc	a1,0xa
    80003138:	2c45b583          	ld	a1,708(a1) # 8000d3f8 <_GLOBAL_OFFSET_TABLE_+0xa0>
    8000313c:	0005b583          	ld	a1,0(a1)
    80003140:	00b76463          	bltu	a4,a1,80003148 <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80003144:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80003148:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    8000314c:	05700593          	li	a1,87
    80003150:	08d5f063          	bgeu	a1,a3,800031d0 <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    80003154:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80003158:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    8000315c:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80003160:	01053583          	ld	a1,16(a0)
    80003164:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80003168:	00853583          	ld	a1,8(a0)
    8000316c:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80003170:	fe868693          	addi	a3,a3,-24
    80003174:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80003178:	04060263          	beqz	a2,800031bc <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    8000317c:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80003180:	0000a797          	auipc	a5,0xa
    80003184:	4807b783          	ld	a5,1152(a5) # 8000d600 <_ZN15MemoryAllocator12allocMemHeadE>
    80003188:	06078463          	beqz	a5,800031f0 <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    8000318c:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80003190:	08070063          	beqz	a4,80003210 <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    80003194:	00873783          	ld	a5,8(a4)
    80003198:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    8000319c:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    800031a0:	00873783          	ld	a5,8(a4)
    800031a4:	06078063          	beqz	a5,80003204 <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    800031a8:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    800031ac:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    800031b0:	00813403          	ld	s0,8(sp)
    800031b4:	01010113          	addi	sp,sp,16
    800031b8:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    800031bc:	0000a697          	auipc	a3,0xa
    800031c0:	42c68693          	addi	a3,a3,1068 # 8000d5e8 <_ZN15MemoryAllocator11freeMemTailE>
    800031c4:	00f6b023          	sd	a5,0(a3)
    800031c8:	00f6b423          	sd	a5,8(a3)
    800031cc:	fb5ff06f          	j	80003180 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    800031d0:	00060863          	beqz	a2,800031e0 <_ZN15MemoryAllocator7kmallocEm+0x100>
    800031d4:	01053783          	ld	a5,16(a0)
    800031d8:	00f63823          	sd	a5,16(a2)
    800031dc:	fa5ff06f          	j	80003180 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    800031e0:	01053783          	ld	a5,16(a0)
    800031e4:	0000a697          	auipc	a3,0xa
    800031e8:	40f6b623          	sd	a5,1036(a3) # 8000d5f0 <_ZN15MemoryAllocator11freeMemHeadE>
    800031ec:	f95ff06f          	j	80003180 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    800031f0:	0000a797          	auipc	a5,0xa
    800031f4:	3f878793          	addi	a5,a5,1016 # 8000d5e8 <_ZN15MemoryAllocator11freeMemTailE>
    800031f8:	00a7b823          	sd	a0,16(a5)
    800031fc:	00a7bc23          	sd	a0,24(a5)
    80003200:	fadff06f          	j	800031ac <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    80003204:	0000a797          	auipc	a5,0xa
    80003208:	3ea7be23          	sd	a0,1020(a5) # 8000d600 <_ZN15MemoryAllocator12allocMemHeadE>
    8000320c:	fa1ff06f          	j	800031ac <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    80003210:	0000a797          	auipc	a5,0xa
    80003214:	3d878793          	addi	a5,a5,984 # 8000d5e8 <_ZN15MemoryAllocator11freeMemTailE>
    80003218:	0107b703          	ld	a4,16(a5)
    8000321c:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80003220:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80003224:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80003228:	00a7b823          	sd	a0,16(a5)
    8000322c:	f81ff06f          	j	800031ac <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    80003230:	00000513          	li	a0,0
    80003234:	f7dff06f          	j	800031b0 <_ZN15MemoryAllocator7kmallocEm+0xd0>

0000000080003238 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80003238:	ff010113          	addi	sp,sp,-16
    8000323c:	00813423          	sd	s0,8(sp)
    80003240:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80003244:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003248:	00000713          	li	a4,0
    8000324c:	00078a63          	beqz	a5,80003260 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80003250:	00a7f863          	bgeu	a5,a0,80003260 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003254:	00078713          	mv	a4,a5
    80003258:	0107b783          	ld	a5,16(a5)
    8000325c:	ff1ff06f          	j	8000324c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80003260:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80003264:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80003268:	00078463          	beqz	a5,80003270 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    8000326c:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80003270:	02070263          	beqz	a4,80003294 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003274:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80003278:	0005b703          	ld	a4,0(a1)
    8000327c:	0000a797          	auipc	a5,0xa
    80003280:	3747b783          	ld	a5,884(a5) # 8000d5f0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003284:	00f70c63          	beq	a4,a5,8000329c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80003288:	00813403          	ld	s0,8(sp)
    8000328c:	01010113          	addi	sp,sp,16
    80003290:	00008067          	ret
        *head = blk;
    80003294:	00a5b023          	sd	a0,0(a1)
    80003298:	fe1ff06f          	j	80003278 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    8000329c:	01053783          	ld	a5,16(a0)
    800032a0:	00078a63          	beqz	a5,800032b4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    800032a4:	00053683          	ld	a3,0(a0)
    800032a8:	00d50733          	add	a4,a0,a3
    800032ac:	01870713          	addi	a4,a4,24
    800032b0:	02f70e63          	beq	a4,a5,800032ec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    800032b4:	00853783          	ld	a5,8(a0)
    800032b8:	fc0788e3          	beqz	a5,80003288 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    800032bc:	0007b683          	ld	a3,0(a5)
    800032c0:	00d78733          	add	a4,a5,a3
    800032c4:	01870713          	addi	a4,a4,24
    800032c8:	fca710e3          	bne	a4,a0,80003288 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    800032cc:	00053703          	ld	a4,0(a0)
    800032d0:	00e68733          	add	a4,a3,a4
    800032d4:	01870713          	addi	a4,a4,24
    800032d8:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    800032dc:	00853783          	ld	a5,8(a0)
    800032e0:	01053703          	ld	a4,16(a0)
    800032e4:	00e7b823          	sd	a4,16(a5)
}
    800032e8:	fa1ff06f          	j	80003288 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    800032ec:	0007b703          	ld	a4,0(a5)
    800032f0:	00e68733          	add	a4,a3,a4
    800032f4:	01870713          	addi	a4,a4,24
    800032f8:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    800032fc:	0107b783          	ld	a5,16(a5)
    80003300:	00f53823          	sd	a5,16(a0)
    80003304:	fb1ff06f          	j	800032b4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080003308 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80003308:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    8000330c:	0000a697          	auipc	a3,0xa
    80003310:	2f46b683          	ld	a3,756(a3) # 8000d600 <_ZN15MemoryAllocator12allocMemHeadE>
    80003314:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80003318:	00050a63          	beqz	a0,8000332c <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    8000331c:	fe870793          	addi	a5,a4,-24
    80003320:	00a78663          	beq	a5,a0,8000332c <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80003324:	01053503          	ld	a0,16(a0)
    80003328:	ff1ff06f          	j	80003318 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    8000332c:	08050463          	beqz	a0,800033b4 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80003330:	ff010113          	addi	sp,sp,-16
    80003334:	00113423          	sd	ra,8(sp)
    80003338:	00813023          	sd	s0,0(sp)
    8000333c:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80003340:	0000a797          	auipc	a5,0xa
    80003344:	2b87b783          	ld	a5,696(a5) # 8000d5f8 <_ZN15MemoryAllocator12allocMemTailE>
    80003348:	04a78663          	beq	a5,a0,80003394 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    8000334c:	04d50c63          	beq	a0,a3,800033a4 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80003350:	01053783          	ld	a5,16(a0)
    80003354:	00078663          	beqz	a5,80003360 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80003358:	00853703          	ld	a4,8(a0)
    8000335c:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80003360:	00853783          	ld	a5,8(a0)
    80003364:	00078663          	beqz	a5,80003370 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80003368:	01053703          	ld	a4,16(a0)
    8000336c:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80003370:	0000a597          	auipc	a1,0xa
    80003374:	28058593          	addi	a1,a1,640 # 8000d5f0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003378:	00000097          	auipc	ra,0x0
    8000337c:	ec0080e7          	jalr	-320(ra) # 80003238 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80003380:	00000513          	li	a0,0
}
    80003384:	00813083          	ld	ra,8(sp)
    80003388:	00013403          	ld	s0,0(sp)
    8000338c:	01010113          	addi	sp,sp,16
    80003390:	00008067          	ret
            allocMemTail = blk->prev;
    80003394:	00853783          	ld	a5,8(a0)
    80003398:	0000a717          	auipc	a4,0xa
    8000339c:	26f73023          	sd	a5,608(a4) # 8000d5f8 <_ZN15MemoryAllocator12allocMemTailE>
    800033a0:	fadff06f          	j	8000334c <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    800033a4:	01053783          	ld	a5,16(a0)
    800033a8:	0000a717          	auipc	a4,0xa
    800033ac:	24f73c23          	sd	a5,600(a4) # 8000d600 <_ZN15MemoryAllocator12allocMemHeadE>
    800033b0:	fa1ff06f          	j	80003350 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    800033b4:	fff00513          	li	a0,-1
}
    800033b8:	00008067          	ret

00000000800033bc <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    800033bc:	fe010113          	addi	sp,sp,-32
    800033c0:	00113c23          	sd	ra,24(sp)
    800033c4:	00813823          	sd	s0,16(sp)
    800033c8:	00913423          	sd	s1,8(sp)
    800033cc:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    800033d0:	0000a497          	auipc	s1,0xa
    800033d4:	2304b483          	ld	s1,560(s1) # 8000d600 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    800033d8:	00007517          	auipc	a0,0x7
    800033dc:	ef050513          	addi	a0,a0,-272 # 8000a2c8 <CONSOLE_STATUS+0x2b8>
    800033e0:	fffff097          	auipc	ra,0xfffff
    800033e4:	494080e7          	jalr	1172(ra) # 80002874 <_Z11printStringPKc>
    while(iter!=nullptr){
    800033e8:	04048663          	beqz	s1,80003434 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800033ec:	00000613          	li	a2,0
    800033f0:	00a00593          	li	a1,10
    800033f4:	0004851b          	sext.w	a0,s1
    800033f8:	fffff097          	auipc	ra,0xfffff
    800033fc:	614080e7          	jalr	1556(ra) # 80002a0c <_Z8printIntiii>
        putc(' ');
    80003400:	02000513          	li	a0,32
    80003404:	fffff097          	auipc	ra,0xfffff
    80003408:	c64080e7          	jalr	-924(ra) # 80002068 <_Z4putcc>
        printInt(iter->size);
    8000340c:	00000613          	li	a2,0
    80003410:	00a00593          	li	a1,10
    80003414:	0004a503          	lw	a0,0(s1)
    80003418:	fffff097          	auipc	ra,0xfffff
    8000341c:	5f4080e7          	jalr	1524(ra) # 80002a0c <_Z8printIntiii>
        putc('\n');
    80003420:	00a00513          	li	a0,10
    80003424:	fffff097          	auipc	ra,0xfffff
    80003428:	c44080e7          	jalr	-956(ra) # 80002068 <_Z4putcc>
        iter=iter->next;
    8000342c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003430:	fb9ff06f          	j	800033e8 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80003434:	00007517          	auipc	a0,0x7
    80003438:	eb450513          	addi	a0,a0,-332 # 8000a2e8 <CONSOLE_STATUS+0x2d8>
    8000343c:	fffff097          	auipc	ra,0xfffff
    80003440:	438080e7          	jalr	1080(ra) # 80002874 <_Z11printStringPKc>
    iter = freeMemHead;
    80003444:	0000a497          	auipc	s1,0xa
    80003448:	1ac4b483          	ld	s1,428(s1) # 8000d5f0 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    8000344c:	04048663          	beqz	s1,80003498 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80003450:	00000613          	li	a2,0
    80003454:	00a00593          	li	a1,10
    80003458:	0004851b          	sext.w	a0,s1
    8000345c:	fffff097          	auipc	ra,0xfffff
    80003460:	5b0080e7          	jalr	1456(ra) # 80002a0c <_Z8printIntiii>
        putc(' ');
    80003464:	02000513          	li	a0,32
    80003468:	fffff097          	auipc	ra,0xfffff
    8000346c:	c00080e7          	jalr	-1024(ra) # 80002068 <_Z4putcc>
        printInt(iter->size);
    80003470:	00000613          	li	a2,0
    80003474:	00a00593          	li	a1,10
    80003478:	0004a503          	lw	a0,0(s1)
    8000347c:	fffff097          	auipc	ra,0xfffff
    80003480:	590080e7          	jalr	1424(ra) # 80002a0c <_Z8printIntiii>
        putc('\n');
    80003484:	00a00513          	li	a0,10
    80003488:	fffff097          	auipc	ra,0xfffff
    8000348c:	be0080e7          	jalr	-1056(ra) # 80002068 <_Z4putcc>
        iter=iter->next;
    80003490:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003494:	fb9ff06f          	j	8000344c <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80003498:	00007517          	auipc	a0,0x7
    8000349c:	e7050513          	addi	a0,a0,-400 # 8000a308 <CONSOLE_STATUS+0x2f8>
    800034a0:	fffff097          	auipc	ra,0xfffff
    800034a4:	3d4080e7          	jalr	980(ra) # 80002874 <_Z11printStringPKc>
}
    800034a8:	01813083          	ld	ra,24(sp)
    800034ac:	01013403          	ld	s0,16(sp)
    800034b0:	00813483          	ld	s1,8(sp)
    800034b4:	02010113          	addi	sp,sp,32
    800034b8:	00008067          	ret

00000000800034bc <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    800034bc:	ff010113          	addi	sp,sp,-16
    800034c0:	00813423          	sd	s0,8(sp)
    800034c4:	01010413          	addi	s0,sp,16
    800034c8:	00050813          	mv	a6,a0
    800034cc:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    800034d0:	00000793          	li	a5,0
    800034d4:	00c7fe63          	bgeu	a5,a2,800034f0 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    800034d8:	00f50733          	add	a4,a0,a5
    800034dc:	00f806b3          	add	a3,a6,a5
    800034e0:	0006c683          	lbu	a3,0(a3)
    800034e4:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    800034e8:	00178793          	addi	a5,a5,1
    800034ec:	fe9ff06f          	j	800034d4 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800034f0:	00813403          	ld	s0,8(sp)
    800034f4:	01010113          	addi	sp,sp,16
    800034f8:	00008067          	ret

00000000800034fc <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    800034fc:	ff010113          	addi	sp,sp,-16
    80003500:	00113423          	sd	ra,8(sp)
    80003504:	00813023          	sd	s0,0(sp)
    80003508:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    8000350c:	00053783          	ld	a5,0(a0)
    80003510:	0107b783          	ld	a5,16(a5)
    80003514:	000780e7          	jalr	a5
}
    80003518:	00813083          	ld	ra,8(sp)
    8000351c:	00013403          	ld	s0,0(sp)
    80003520:	01010113          	addi	sp,sp,16
    80003524:	00008067          	ret

0000000080003528 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80003528:	ff010113          	addi	sp,sp,-16
    8000352c:	00113423          	sd	ra,8(sp)
    80003530:	00813023          	sd	s0,0(sp)
    80003534:	01010413          	addi	s0,sp,16
    80003538:	0000a797          	auipc	a5,0xa
    8000353c:	c5878793          	addi	a5,a5,-936 # 8000d190 <_ZTV9Semaphore+0x10>
    80003540:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80003544:	00853503          	ld	a0,8(a0)
    80003548:	fffff097          	auipc	ra,0xfffff
    8000354c:	a48080e7          	jalr	-1464(ra) # 80001f90 <_Z9sem_closeP10_semaphore>
};
    80003550:	00813083          	ld	ra,8(sp)
    80003554:	00013403          	ld	s0,0(sp)
    80003558:	01010113          	addi	sp,sp,16
    8000355c:	00008067          	ret

0000000080003560 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80003560:	0000a797          	auipc	a5,0xa
    80003564:	c5078793          	addi	a5,a5,-944 # 8000d1b0 <_ZTV6Thread+0x10>
    80003568:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000356c:	00853503          	ld	a0,8(a0)
    80003570:	02050663          	beqz	a0,8000359c <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80003574:	ff010113          	addi	sp,sp,-16
    80003578:	00113423          	sd	ra,8(sp)
    8000357c:	00813023          	sd	s0,0(sp)
    80003580:	01010413          	addi	s0,sp,16
    delete myHandle;
    80003584:	fffff097          	auipc	ra,0xfffff
    80003588:	b58080e7          	jalr	-1192(ra) # 800020dc <_ZN7_threaddlEPv>
}
    8000358c:	00813083          	ld	ra,8(sp)
    80003590:	00013403          	ld	s0,0(sp)
    80003594:	01010113          	addi	sp,sp,16
    80003598:	00008067          	ret
    8000359c:	00008067          	ret

00000000800035a0 <_Znwm>:
void* operator new(size_t sz){
    800035a0:	ff010113          	addi	sp,sp,-16
    800035a4:	00113423          	sd	ra,8(sp)
    800035a8:	00813023          	sd	s0,0(sp)
    800035ac:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800035b0:	ffffe097          	auipc	ra,0xffffe
    800035b4:	7e0080e7          	jalr	2016(ra) # 80001d90 <_Z9mem_allocm>
}
    800035b8:	00813083          	ld	ra,8(sp)
    800035bc:	00013403          	ld	s0,0(sp)
    800035c0:	01010113          	addi	sp,sp,16
    800035c4:	00008067          	ret

00000000800035c8 <_Znam>:
void* operator new[](size_t sz){
    800035c8:	ff010113          	addi	sp,sp,-16
    800035cc:	00113423          	sd	ra,8(sp)
    800035d0:	00813023          	sd	s0,0(sp)
    800035d4:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800035d8:	ffffe097          	auipc	ra,0xffffe
    800035dc:	7b8080e7          	jalr	1976(ra) # 80001d90 <_Z9mem_allocm>
}
    800035e0:	00813083          	ld	ra,8(sp)
    800035e4:	00013403          	ld	s0,0(sp)
    800035e8:	01010113          	addi	sp,sp,16
    800035ec:	00008067          	ret

00000000800035f0 <_ZdlPv>:
void operator delete(void *ptr){
    800035f0:	ff010113          	addi	sp,sp,-16
    800035f4:	00113423          	sd	ra,8(sp)
    800035f8:	00813023          	sd	s0,0(sp)
    800035fc:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80003600:	ffffe097          	auipc	ra,0xffffe
    80003604:	7c0080e7          	jalr	1984(ra) # 80001dc0 <_Z8mem_freePv>
}
    80003608:	00813083          	ld	ra,8(sp)
    8000360c:	00013403          	ld	s0,0(sp)
    80003610:	01010113          	addi	sp,sp,16
    80003614:	00008067          	ret

0000000080003618 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80003618:	fe010113          	addi	sp,sp,-32
    8000361c:	00113c23          	sd	ra,24(sp)
    80003620:	00813823          	sd	s0,16(sp)
    80003624:	00913423          	sd	s1,8(sp)
    80003628:	02010413          	addi	s0,sp,32
    8000362c:	00050493          	mv	s1,a0
};
    80003630:	00000097          	auipc	ra,0x0
    80003634:	ef8080e7          	jalr	-264(ra) # 80003528 <_ZN9SemaphoreD1Ev>
    80003638:	00048513          	mv	a0,s1
    8000363c:	00000097          	auipc	ra,0x0
    80003640:	fb4080e7          	jalr	-76(ra) # 800035f0 <_ZdlPv>
    80003644:	01813083          	ld	ra,24(sp)
    80003648:	01013403          	ld	s0,16(sp)
    8000364c:	00813483          	ld	s1,8(sp)
    80003650:	02010113          	addi	sp,sp,32
    80003654:	00008067          	ret

0000000080003658 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80003658:	fe010113          	addi	sp,sp,-32
    8000365c:	00113c23          	sd	ra,24(sp)
    80003660:	00813823          	sd	s0,16(sp)
    80003664:	00913423          	sd	s1,8(sp)
    80003668:	02010413          	addi	s0,sp,32
    8000366c:	00050493          	mv	s1,a0
}
    80003670:	00000097          	auipc	ra,0x0
    80003674:	ef0080e7          	jalr	-272(ra) # 80003560 <_ZN6ThreadD1Ev>
    80003678:	00048513          	mv	a0,s1
    8000367c:	00000097          	auipc	ra,0x0
    80003680:	f74080e7          	jalr	-140(ra) # 800035f0 <_ZdlPv>
    80003684:	01813083          	ld	ra,24(sp)
    80003688:	01013403          	ld	s0,16(sp)
    8000368c:	00813483          	ld	s1,8(sp)
    80003690:	02010113          	addi	sp,sp,32
    80003694:	00008067          	ret

0000000080003698 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80003698:	ff010113          	addi	sp,sp,-16
    8000369c:	00113423          	sd	ra,8(sp)
    800036a0:	00813023          	sd	s0,0(sp)
    800036a4:	01010413          	addi	s0,sp,16
    800036a8:	0000a797          	auipc	a5,0xa
    800036ac:	ae878793          	addi	a5,a5,-1304 # 8000d190 <_ZTV9Semaphore+0x10>
    800036b0:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    800036b4:	00850513          	addi	a0,a0,8
    800036b8:	fffff097          	auipc	ra,0xfffff
    800036bc:	8a0080e7          	jalr	-1888(ra) # 80001f58 <_Z8sem_openPP10_semaphorej>
}
    800036c0:	00813083          	ld	ra,8(sp)
    800036c4:	00013403          	ld	s0,0(sp)
    800036c8:	01010113          	addi	sp,sp,16
    800036cc:	00008067          	ret

00000000800036d0 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    800036d0:	ff010113          	addi	sp,sp,-16
    800036d4:	00113423          	sd	ra,8(sp)
    800036d8:	00813023          	sd	s0,0(sp)
    800036dc:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800036e0:	00853503          	ld	a0,8(a0)
    800036e4:	fffff097          	auipc	ra,0xfffff
    800036e8:	8d8080e7          	jalr	-1832(ra) # 80001fbc <_Z8sem_waitP10_semaphore>
}
    800036ec:	00813083          	ld	ra,8(sp)
    800036f0:	00013403          	ld	s0,0(sp)
    800036f4:	01010113          	addi	sp,sp,16
    800036f8:	00008067          	ret

00000000800036fc <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800036fc:	ff010113          	addi	sp,sp,-16
    80003700:	00113423          	sd	ra,8(sp)
    80003704:	00813023          	sd	s0,0(sp)
    80003708:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    8000370c:	00853503          	ld	a0,8(a0)
    80003710:	fffff097          	auipc	ra,0xfffff
    80003714:	8d8080e7          	jalr	-1832(ra) # 80001fe8 <_Z10sem_signalP10_semaphore>
}
    80003718:	00813083          	ld	ra,8(sp)
    8000371c:	00013403          	ld	s0,0(sp)
    80003720:	01010113          	addi	sp,sp,16
    80003724:	00008067          	ret

0000000080003728 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80003728:	ff010113          	addi	sp,sp,-16
    8000372c:	00113423          	sd	ra,8(sp)
    80003730:	00813023          	sd	s0,0(sp)
    80003734:	01010413          	addi	s0,sp,16
    80003738:	0000a797          	auipc	a5,0xa
    8000373c:	a7878793          	addi	a5,a5,-1416 # 8000d1b0 <_ZTV6Thread+0x10>
    80003740:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    80003744:	00850513          	addi	a0,a0,8
    80003748:	ffffe097          	auipc	ra,0xffffe
    8000374c:	768080e7          	jalr	1896(ra) # 80001eb0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80003750:	00813083          	ld	ra,8(sp)
    80003754:	00013403          	ld	s0,0(sp)
    80003758:	01010113          	addi	sp,sp,16
    8000375c:	00008067          	ret

0000000080003760 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80003760:	ff010113          	addi	sp,sp,-16
    80003764:	00113423          	sd	ra,8(sp)
    80003768:	00813023          	sd	s0,0(sp)
    8000376c:	01010413          	addi	s0,sp,16
    80003770:	0000a797          	auipc	a5,0xa
    80003774:	a4078793          	addi	a5,a5,-1472 # 8000d1b0 <_ZTV6Thread+0x10>
    80003778:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    8000377c:	00050613          	mv	a2,a0
    80003780:	00000597          	auipc	a1,0x0
    80003784:	d7c58593          	addi	a1,a1,-644 # 800034fc <_ZN6Thread7wrapperEPv>
    80003788:	00850513          	addi	a0,a0,8
    8000378c:	ffffe097          	auipc	ra,0xffffe
    80003790:	724080e7          	jalr	1828(ra) # 80001eb0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80003794:	00813083          	ld	ra,8(sp)
    80003798:	00013403          	ld	s0,0(sp)
    8000379c:	01010113          	addi	sp,sp,16
    800037a0:	00008067          	ret

00000000800037a4 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    800037a4:	ff010113          	addi	sp,sp,-16
    800037a8:	00113423          	sd	ra,8(sp)
    800037ac:	00813023          	sd	s0,0(sp)
    800037b0:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    800037b4:	fffff097          	auipc	ra,0xfffff
    800037b8:	860080e7          	jalr	-1952(ra) # 80002014 <_Z10time_sleepm>
}
    800037bc:	00813083          	ld	ra,8(sp)
    800037c0:	00013403          	ld	s0,0(sp)
    800037c4:	01010113          	addi	sp,sp,16
    800037c8:	00008067          	ret

00000000800037cc <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    800037cc:	fe010113          	addi	sp,sp,-32
    800037d0:	00113c23          	sd	ra,24(sp)
    800037d4:	00813823          	sd	s0,16(sp)
    800037d8:	00913423          	sd	s1,8(sp)
    800037dc:	01213023          	sd	s2,0(sp)
    800037e0:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    800037e4:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    800037e8:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    800037ec:	0004b783          	ld	a5,0(s1)
    800037f0:	0187b783          	ld	a5,24(a5)
    800037f4:	00048513          	mv	a0,s1
    800037f8:	000780e7          	jalr	a5
        pt->sleep(time);
    800037fc:	00090513          	mv	a0,s2
    80003800:	00000097          	auipc	ra,0x0
    80003804:	fa4080e7          	jalr	-92(ra) # 800037a4 <_ZN6Thread5sleepEm>
    while(true){
    80003808:	fe5ff06f          	j	800037ec <_ZN14PeriodicThread7wrapperEPv+0x20>

000000008000380c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000380c:	ff010113          	addi	sp,sp,-16
    80003810:	00113423          	sd	ra,8(sp)
    80003814:	00813023          	sd	s0,0(sp)
    80003818:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000381c:	ffffe097          	auipc	ra,0xffffe
    80003820:	674080e7          	jalr	1652(ra) # 80001e90 <_Z15thread_dispatchv>
}
    80003824:	00813083          	ld	ra,8(sp)
    80003828:	00013403          	ld	s0,0(sp)
    8000382c:	01010113          	addi	sp,sp,16
    80003830:	00008067          	ret

0000000080003834 <_ZN6Thread5startEv>:
int Thread::start() {
    80003834:	ff010113          	addi	sp,sp,-16
    80003838:	00113423          	sd	ra,8(sp)
    8000383c:	00813023          	sd	s0,0(sp)
    80003840:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80003844:	00853503          	ld	a0,8(a0)
    80003848:	ffffe097          	auipc	ra,0xffffe
    8000384c:	6e4080e7          	jalr	1764(ra) # 80001f2c <_Z12thread_startP7_thread>
}
    80003850:	00813083          	ld	ra,8(sp)
    80003854:	00013403          	ld	s0,0(sp)
    80003858:	01010113          	addi	sp,sp,16
    8000385c:	00008067          	ret

0000000080003860 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003860:	fe010113          	addi	sp,sp,-32
    80003864:	00113c23          	sd	ra,24(sp)
    80003868:	00813823          	sd	s0,16(sp)
    8000386c:	00913423          	sd	s1,8(sp)
    80003870:	01213023          	sd	s2,0(sp)
    80003874:	02010413          	addi	s0,sp,32
    80003878:	00050493          	mv	s1,a0
    8000387c:	00058913          	mv	s2,a1
    80003880:	01000513          	li	a0,16
    80003884:	00000097          	auipc	ra,0x0
    80003888:	d1c080e7          	jalr	-740(ra) # 800035a0 <_Znwm>
    8000388c:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    80003890:	00953023          	sd	s1,0(a0)
    80003894:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003898:	00000597          	auipc	a1,0x0
    8000389c:	f3458593          	addi	a1,a1,-204 # 800037cc <_ZN14PeriodicThread7wrapperEPv>
    800038a0:	00048513          	mv	a0,s1
    800038a4:	00000097          	auipc	ra,0x0
    800038a8:	e84080e7          	jalr	-380(ra) # 80003728 <_ZN6ThreadC1EPFvPvES0_>
    800038ac:	0000a797          	auipc	a5,0xa
    800038b0:	8b478793          	addi	a5,a5,-1868 # 8000d160 <_ZTV14PeriodicThread+0x10>
    800038b4:	00f4b023          	sd	a5,0(s1)
    800038b8:	01813083          	ld	ra,24(sp)
    800038bc:	01013403          	ld	s0,16(sp)
    800038c0:	00813483          	ld	s1,8(sp)
    800038c4:	00013903          	ld	s2,0(sp)
    800038c8:	02010113          	addi	sp,sp,32
    800038cc:	00008067          	ret

00000000800038d0 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    800038d0:	ff010113          	addi	sp,sp,-16
    800038d4:	00113423          	sd	ra,8(sp)
    800038d8:	00813023          	sd	s0,0(sp)
    800038dc:	01010413          	addi	s0,sp,16
    return ::getc();
    800038e0:	ffffe097          	auipc	ra,0xffffe
    800038e4:	760080e7          	jalr	1888(ra) # 80002040 <_Z4getcv>
}
    800038e8:	00813083          	ld	ra,8(sp)
    800038ec:	00013403          	ld	s0,0(sp)
    800038f0:	01010113          	addi	sp,sp,16
    800038f4:	00008067          	ret

00000000800038f8 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    800038f8:	ff010113          	addi	sp,sp,-16
    800038fc:	00113423          	sd	ra,8(sp)
    80003900:	00813023          	sd	s0,0(sp)
    80003904:	01010413          	addi	s0,sp,16
    ::putc(c);
    80003908:	ffffe097          	auipc	ra,0xffffe
    8000390c:	760080e7          	jalr	1888(ra) # 80002068 <_Z4putcc>
}
    80003910:	00813083          	ld	ra,8(sp)
    80003914:	00013403          	ld	s0,0(sp)
    80003918:	01010113          	addi	sp,sp,16
    8000391c:	00008067          	ret

0000000080003920 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003920:	ff010113          	addi	sp,sp,-16
    80003924:	00813423          	sd	s0,8(sp)
    80003928:	01010413          	addi	s0,sp,16
    8000392c:	00813403          	ld	s0,8(sp)
    80003930:	01010113          	addi	sp,sp,16
    80003934:	00008067          	ret

0000000080003938 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80003938:	ff010113          	addi	sp,sp,-16
    8000393c:	00813423          	sd	s0,8(sp)
    80003940:	01010413          	addi	s0,sp,16
    80003944:	00813403          	ld	s0,8(sp)
    80003948:	01010113          	addi	sp,sp,16
    8000394c:	00008067          	ret

0000000080003950 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80003950:	ff010113          	addi	sp,sp,-16
    80003954:	00113423          	sd	ra,8(sp)
    80003958:	00813023          	sd	s0,0(sp)
    8000395c:	01010413          	addi	s0,sp,16
    80003960:	0000a797          	auipc	a5,0xa
    80003964:	80078793          	addi	a5,a5,-2048 # 8000d160 <_ZTV14PeriodicThread+0x10>
    80003968:	00f53023          	sd	a5,0(a0)
    8000396c:	00000097          	auipc	ra,0x0
    80003970:	bf4080e7          	jalr	-1036(ra) # 80003560 <_ZN6ThreadD1Ev>
    80003974:	00813083          	ld	ra,8(sp)
    80003978:	00013403          	ld	s0,0(sp)
    8000397c:	01010113          	addi	sp,sp,16
    80003980:	00008067          	ret

0000000080003984 <_ZN14PeriodicThreadD0Ev>:
    80003984:	fe010113          	addi	sp,sp,-32
    80003988:	00113c23          	sd	ra,24(sp)
    8000398c:	00813823          	sd	s0,16(sp)
    80003990:	00913423          	sd	s1,8(sp)
    80003994:	02010413          	addi	s0,sp,32
    80003998:	00050493          	mv	s1,a0
    8000399c:	00009797          	auipc	a5,0x9
    800039a0:	7c478793          	addi	a5,a5,1988 # 8000d160 <_ZTV14PeriodicThread+0x10>
    800039a4:	00f53023          	sd	a5,0(a0)
    800039a8:	00000097          	auipc	ra,0x0
    800039ac:	bb8080e7          	jalr	-1096(ra) # 80003560 <_ZN6ThreadD1Ev>
    800039b0:	00048513          	mv	a0,s1
    800039b4:	00000097          	auipc	ra,0x0
    800039b8:	c3c080e7          	jalr	-964(ra) # 800035f0 <_ZdlPv>
    800039bc:	01813083          	ld	ra,24(sp)
    800039c0:	01013403          	ld	s0,16(sp)
    800039c4:	00813483          	ld	s1,8(sp)
    800039c8:	02010113          	addi	sp,sp,32
    800039cc:	00008067          	ret

00000000800039d0 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    800039d0:	ff010113          	addi	sp,sp,-16
    800039d4:	00113423          	sd	ra,8(sp)
    800039d8:	00813023          	sd	s0,0(sp)
    800039dc:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    800039e0:	0000a797          	auipc	a5,0xa
    800039e4:	9e87b783          	ld	a5,-1560(a5) # 8000d3c8 <_GLOBAL_OFFSET_TABLE_+0x70>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    800039e8:	10579073          	csrw	stvec,a5
    MemoryAllocator::initialize();
    800039ec:	fffff097          	auipc	ra,0xfffff
    800039f0:	674080e7          	jalr	1652(ra) # 80003060 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    800039f4:	00001097          	auipc	ra,0x1
    800039f8:	f5c080e7          	jalr	-164(ra) # 80004950 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    800039fc:	fffff097          	auipc	ra,0xfffff
    80003a00:	544080e7          	jalr	1348(ra) # 80002f40 <_ZN3TCB10initializeEv>
    ConsoleUtil::initialize();
    80003a04:	00001097          	auipc	ra,0x1
    80003a08:	160080e7          	jalr	352(ra) # 80004b64 <_ZN11ConsoleUtil10initializeEv>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003a0c:	00200793          	li	a5,2
    80003a10:	1047a073          	csrs	sie,a5
    80003a14:	20000713          	li	a4,512
    80003a18:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003a1c:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80003a20:	00813083          	ld	ra,8(sp)
    80003a24:	00013403          	ld	s0,0(sp)
    80003a28:	01010113          	addi	sp,sp,16
    80003a2c:	00008067          	ret

0000000080003a30 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003a30:	ff010113          	addi	sp,sp,-16
    80003a34:	00813423          	sd	s0,8(sp)
    80003a38:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003a3c:	14109073          	csrw	sepc,ra
    asm("sret");
    80003a40:	10200073          	sret
}
    80003a44:	00813403          	ld	s0,8(sp)
    80003a48:	01010113          	addi	sp,sp,16
    80003a4c:	00008067          	ret

0000000080003a50 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003a50:	ff010113          	addi	sp,sp,-16
    80003a54:	00113423          	sd	ra,8(sp)
    80003a58:	00813023          	sd	s0,0(sp)
    80003a5c:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003a60:	0000a797          	auipc	a5,0xa
    80003a64:	9887b783          	ld	a5,-1656(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003a68:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003a6c:	00100713          	li	a4,1
    80003a70:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003a74:	fffff097          	auipc	ra,0xfffff
    80003a78:	424080e7          	jalr	1060(ra) # 80002e98 <_ZN3TCB8dispatchEv>
}
    80003a7c:	00813083          	ld	ra,8(sp)
    80003a80:	00013403          	ld	s0,0(sp)
    80003a84:	01010113          	addi	sp,sp,16
    80003a88:	00008067          	ret

0000000080003a8c <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003a8c:	ff010113          	addi	sp,sp,-16
    80003a90:	00113423          	sd	ra,8(sp)
    80003a94:	00813023          	sd	s0,0(sp)
    80003a98:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003a9c:	0000a797          	auipc	a5,0xa
    80003aa0:	b747c783          	lbu	a5,-1164(a5) # 8000d610 <_ZN5RiscV16userMainFinishedE>
    80003aa4:	00079c63          	bnez	a5,80003abc <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003aa8:	0000a717          	auipc	a4,0xa
    80003aac:	93873703          	ld	a4,-1736(a4) # 8000d3e0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003ab0:	00073783          	ld	a5,0(a4)
    80003ab4:	00178793          	addi	a5,a5,1
    80003ab8:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003abc:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003ac0:	0ff57513          	andi	a0,a0,255
    80003ac4:	00001097          	auipc	ra,0x1
    80003ac8:	230080e7          	jalr	560(ra) # 80004cf4 <_ZN11ConsoleUtil9putOutputEc>
}
    80003acc:	00813083          	ld	ra,8(sp)
    80003ad0:	00013403          	ld	s0,0(sp)
    80003ad4:	01010113          	addi	sp,sp,16
    80003ad8:	00008067          	ret

0000000080003adc <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003adc:	fe010113          	addi	sp,sp,-32
    80003ae0:	00113c23          	sd	ra,24(sp)
    80003ae4:	00813823          	sd	s0,16(sp)
    80003ae8:	02010413          	addi	s0,sp,32
    80003aec:	00c0006f          	j	80003af8 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80003af0:	ffffe097          	auipc	ra,0xffffe
    80003af4:	3a0080e7          	jalr	928(ra) # 80001e90 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80003af8:	0000a797          	auipc	a5,0xa
    80003afc:	8707b783          	ld	a5,-1936(a5) # 8000d368 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003b00:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003b04:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003b08:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003b0c:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003b10:	0207f793          	andi	a5,a5,32
    80003b14:	fc078ee3          	beqz	a5,80003af0 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003b18:	00001097          	auipc	ra,0x1
    80003b1c:	454080e7          	jalr	1108(ra) # 80004f6c <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003b20:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003b24:	0000a797          	auipc	a5,0xa
    80003b28:	83c7b783          	ld	a5,-1988(a5) # 8000d360 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003b2c:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003b30:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003b34:	fef44783          	lbu	a5,-17(s0)
    80003b38:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003b3c:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003b40:	0000a797          	auipc	a5,0xa
    80003b44:	8a07b783          	ld	a5,-1888(a5) # 8000d3e0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003b48:	0007b783          	ld	a5,0(a5)
    80003b4c:	fa0786e3          	beqz	a5,80003af8 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003b50:	fff78793          	addi	a5,a5,-1
    80003b54:	0000a717          	auipc	a4,0xa
    80003b58:	88c73703          	ld	a4,-1908(a4) # 8000d3e0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003b5c:	00f73023          	sd	a5,0(a4)
    80003b60:	f99ff06f          	j	80003af8 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003b64 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003b64:	ff010113          	addi	sp,sp,-16
    80003b68:	00813423          	sd	s0,8(sp)
    80003b6c:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80003b70:	0000a797          	auipc	a5,0xa
    80003b74:	8787b783          	ld	a5,-1928(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003b78:	0007b783          	ld	a5,0(a5)
    80003b7c:	0147a703          	lw	a4,20(a5)
    80003b80:	00100793          	li	a5,1
    80003b84:	00f70c63          	beq	a4,a5,80003b9c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003b88:	10000793          	li	a5,256
    80003b8c:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    80003b90:	00813403          	ld	s0,8(sp)
    80003b94:	01010113          	addi	sp,sp,16
    80003b98:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003b9c:	10000793          	li	a5,256
    80003ba0:	1007a073          	csrs	sstatus,a5
}
    80003ba4:	fedff06f          	j	80003b90 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080003ba8 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80003ba8:	ff010113          	addi	sp,sp,-16
    80003bac:	00113423          	sd	ra,8(sp)
    80003bb0:	00813023          	sd	s0,0(sp)
    80003bb4:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80003bb8:	00100793          	li	a5,1
    80003bbc:	0000a717          	auipc	a4,0xa
    80003bc0:	a4f70a23          	sb	a5,-1452(a4) # 8000d610 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003bc4:	0000a797          	auipc	a5,0xa
    80003bc8:	81c7b783          	ld	a5,-2020(a5) # 8000d3e0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003bcc:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003bd0:	00009797          	auipc	a5,0x9
    80003bd4:	7c87b783          	ld	a5,1992(a5) # 8000d398 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003bd8:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003bdc:	00200793          	li	a5,2
    80003be0:	1047b073          	csrc	sie,a5
    80003be4:	20000793          	li	a5,512
    80003be8:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003bec:	00009797          	auipc	a5,0x9
    80003bf0:	7cc7b783          	ld	a5,1996(a5) # 8000d3b8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003bf4:	0007b783          	ld	a5,0(a5)
    80003bf8:	00078c63          	beqz	a5,80003c10 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003bfc:	0487b703          	ld	a4,72(a5)
    80003c00:	00009797          	auipc	a5,0x9
    80003c04:	7b87b783          	ld	a5,1976(a5) # 8000d3b8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003c08:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003c0c:	fe1ff06f          	j	80003bec <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003c10:	00009797          	auipc	a5,0x9
    80003c14:	7b07b783          	ld	a5,1968(a5) # 8000d3c0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003c18:	0007b503          	ld	a0,0(a5)
    80003c1c:	00001097          	auipc	ra,0x1
    80003c20:	d4c080e7          	jalr	-692(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003c24:	00009797          	auipc	a5,0x9
    80003c28:	7ac7b783          	ld	a5,1964(a5) # 8000d3d0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003c2c:	0007b703          	ld	a4,0(a5)
    80003c30:	00009797          	auipc	a5,0x9
    80003c34:	7a87b783          	ld	a5,1960(a5) # 8000d3d8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003c38:	0007b783          	ld	a5,0(a5)
    80003c3c:	00f70863          	beq	a4,a5,80003c4c <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80003c40:	ffffe097          	auipc	ra,0xffffe
    80003c44:	250080e7          	jalr	592(ra) # 80001e90 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003c48:	fddff06f          	j	80003c24 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003c4c:	00813083          	ld	ra,8(sp)
    80003c50:	00013403          	ld	s0,0(sp)
    80003c54:	01010113          	addi	sp,sp,16
    80003c58:	00008067          	ret

0000000080003c5c <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003c5c:	ff010113          	addi	sp,sp,-16
    80003c60:	00813423          	sd	s0,8(sp)
    80003c64:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80003c68:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003c6c:	00009717          	auipc	a4,0x9
    80003c70:	77c73703          	ld	a4,1916(a4) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003c74:	00073703          	ld	a4,0(a4)
    80003c78:	06873703          	ld	a4,104(a4)
    80003c7c:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003c80:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003c84:	00078593          	mv	a1,a5
}
    80003c88:	00813403          	ld	s0,8(sp)
    80003c8c:	01010113          	addi	sp,sp,16
    80003c90:	00008067          	ret

0000000080003c94 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003c94:	ff010113          	addi	sp,sp,-16
    80003c98:	00113423          	sd	ra,8(sp)
    80003c9c:	00813023          	sd	s0,0(sp)
    80003ca0:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003ca4:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80003ca8:	fffff097          	auipc	ra,0xfffff
    80003cac:	438080e7          	jalr	1080(ra) # 800030e0 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003cb0:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003cb4:	00000097          	auipc	ra,0x0
    80003cb8:	fa8080e7          	jalr	-88(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003cbc:	00813083          	ld	ra,8(sp)
    80003cc0:	00013403          	ld	s0,0(sp)
    80003cc4:	01010113          	addi	sp,sp,16
    80003cc8:	00008067          	ret

0000000080003ccc <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003ccc:	ff010113          	addi	sp,sp,-16
    80003cd0:	00113423          	sd	ra,8(sp)
    80003cd4:	00813023          	sd	s0,0(sp)
    80003cd8:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003cdc:	00009797          	auipc	a5,0x9
    80003ce0:	7147b783          	ld	a5,1812(a5) # 8000d3f0 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003ce4:	0007c783          	lbu	a5,0(a5)
    80003ce8:	02079263          	bnez	a5,80003d0c <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003cec:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003cf0:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003cf4:	00000097          	auipc	ra,0x0
    80003cf8:	f68080e7          	jalr	-152(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003cfc:	00813083          	ld	ra,8(sp)
    80003d00:	00013403          	ld	s0,0(sp)
    80003d04:	01010113          	addi	sp,sp,16
    80003d08:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003d0c:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003d10:	fffff097          	auipc	ra,0xfffff
    80003d14:	5f8080e7          	jalr	1528(ra) # 80003308 <_ZN15MemoryAllocator5kfreeEPv>
    80003d18:	fd9ff06f          	j	80003cf0 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003d1c <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003d1c:	fc010113          	addi	sp,sp,-64
    80003d20:	02113c23          	sd	ra,56(sp)
    80003d24:	02813823          	sd	s0,48(sp)
    80003d28:	02913423          	sd	s1,40(sp)
    80003d2c:	03213023          	sd	s2,32(sp)
    80003d30:	01313c23          	sd	s3,24(sp)
    80003d34:	01413823          	sd	s4,16(sp)
    80003d38:	01513423          	sd	s5,8(sp)
    80003d3c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003d40:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003d44:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003d48:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003d4c:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003d50:	07000513          	li	a0,112
    80003d54:	fffff097          	auipc	ra,0xfffff
    80003d58:	1c4080e7          	jalr	452(ra) # 80002f18 <_ZN3TCBnwEm>
    80003d5c:	00050493          	mv	s1,a0
    80003d60:	00200713          	li	a4,2
    80003d64:	000a0693          	mv	a3,s4
    80003d68:	00098613          	mv	a2,s3
    80003d6c:	00090593          	mv	a1,s2
    80003d70:	fffff097          	auipc	ra,0xfffff
    80003d74:	05c080e7          	jalr	92(ra) # 80002dcc <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003d78:	04048863          	beqz	s1,80003dc8 <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003d7c:	0184b783          	ld	a5,24(s1)
    80003d80:	00078863          	beqz	a5,80003d90 <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    80003d84:	00048513          	mv	a0,s1
    80003d88:	00001097          	auipc	ra,0x1
    80003d8c:	be0080e7          	jalr	-1056(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003d90:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003d94:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d98:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003d9c:	00000097          	auipc	ra,0x0
    80003da0:	ec0080e7          	jalr	-320(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003da4:	03813083          	ld	ra,56(sp)
    80003da8:	03013403          	ld	s0,48(sp)
    80003dac:	02813483          	ld	s1,40(sp)
    80003db0:	02013903          	ld	s2,32(sp)
    80003db4:	01813983          	ld	s3,24(sp)
    80003db8:	01013a03          	ld	s4,16(sp)
    80003dbc:	00813a83          	ld	s5,8(sp)
    80003dc0:	04010113          	addi	sp,sp,64
    80003dc4:	00008067          	ret
        status = -1;
    80003dc8:	fff00793          	li	a5,-1
    80003dcc:	fcdff06f          	j	80003d98 <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    80003dd0:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003dd4:	00048513          	mv	a0,s1
    80003dd8:	fffff097          	auipc	ra,0xfffff
    80003ddc:	234080e7          	jalr	564(ra) # 8000300c <_ZN3TCBdlEPv>
    80003de0:	00090513          	mv	a0,s2
    80003de4:	0000f097          	auipc	ra,0xf
    80003de8:	984080e7          	jalr	-1660(ra) # 80012768 <_Unwind_Resume>

0000000080003dec <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003dec:	fc010113          	addi	sp,sp,-64
    80003df0:	02113c23          	sd	ra,56(sp)
    80003df4:	02813823          	sd	s0,48(sp)
    80003df8:	02913423          	sd	s1,40(sp)
    80003dfc:	03213023          	sd	s2,32(sp)
    80003e00:	01313c23          	sd	s3,24(sp)
    80003e04:	01413823          	sd	s4,16(sp)
    80003e08:	01513423          	sd	s5,8(sp)
    80003e0c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003e10:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003e14:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003e18:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003e1c:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003e20:	07000513          	li	a0,112
    80003e24:	fffff097          	auipc	ra,0xfffff
    80003e28:	0f4080e7          	jalr	244(ra) # 80002f18 <_ZN3TCBnwEm>
    80003e2c:	00050493          	mv	s1,a0
    80003e30:	00200713          	li	a4,2
    80003e34:	00090693          	mv	a3,s2
    80003e38:	00098613          	mv	a2,s3
    80003e3c:	000a0593          	mv	a1,s4
    80003e40:	fffff097          	auipc	ra,0xfffff
    80003e44:	f8c080e7          	jalr	-116(ra) # 80002dcc <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003e48:	04048263          	beqz	s1,80003e8c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003e4c:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    80003e50:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003e54:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003e58:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003e5c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003e60:	00000097          	auipc	ra,0x0
    80003e64:	dfc080e7          	jalr	-516(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e68:	03813083          	ld	ra,56(sp)
    80003e6c:	03013403          	ld	s0,48(sp)
    80003e70:	02813483          	ld	s1,40(sp)
    80003e74:	02013903          	ld	s2,32(sp)
    80003e78:	01813983          	ld	s3,24(sp)
    80003e7c:	01013a03          	ld	s4,16(sp)
    80003e80:	00813a83          	ld	s5,8(sp)
    80003e84:	04010113          	addi	sp,sp,64
    80003e88:	00008067          	ret
        status = -1;
    80003e8c:	fff00793          	li	a5,-1
    80003e90:	fcdff06f          	j	80003e5c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003e94:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003e98:	00048513          	mv	a0,s1
    80003e9c:	fffff097          	auipc	ra,0xfffff
    80003ea0:	170080e7          	jalr	368(ra) # 8000300c <_ZN3TCBdlEPv>
    80003ea4:	00090513          	mv	a0,s2
    80003ea8:	0000f097          	auipc	ra,0xf
    80003eac:	8c0080e7          	jalr	-1856(ra) # 80012768 <_Unwind_Resume>

0000000080003eb0 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003eb0:	ff010113          	addi	sp,sp,-16
    80003eb4:	00113423          	sd	ra,8(sp)
    80003eb8:	00813023          	sd	s0,0(sp)
    80003ebc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003ec0:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003ec4:	02051263          	bnez	a0,80003ee8 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003ec8:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ecc:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003ed0:	00000097          	auipc	ra,0x0
    80003ed4:	d8c080e7          	jalr	-628(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ed8:	00813083          	ld	ra,8(sp)
    80003edc:	00013403          	ld	s0,0(sp)
    80003ee0:	01010113          	addi	sp,sp,16
    80003ee4:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003ee8:	00100793          	li	a5,1
    80003eec:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003ef0:	00001097          	auipc	ra,0x1
    80003ef4:	a78080e7          	jalr	-1416(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003ef8:	fffff097          	auipc	ra,0xfffff
    80003efc:	fa0080e7          	jalr	-96(ra) # 80002e98 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003f00:	00000793          	li	a5,0
    80003f04:	fc9ff06f          	j	80003ecc <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003f08 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003f08:	ff010113          	addi	sp,sp,-16
    80003f0c:	00113423          	sd	ra,8(sp)
    80003f10:	00813023          	sd	s0,0(sp)
    80003f14:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003f18:	00009797          	auipc	a5,0x9
    80003f1c:	4d07b783          	ld	a5,1232(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003f20:	0007b783          	ld	a5,0(a5)
    80003f24:	02078a63          	beqz	a5,80003f58 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003f28:	00200713          	li	a4,2
    80003f2c:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003f30:	fffff097          	auipc	ra,0xfffff
    80003f34:	f68080e7          	jalr	-152(ra) # 80002e98 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003f38:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003f3c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003f40:	00000097          	auipc	ra,0x0
    80003f44:	d1c080e7          	jalr	-740(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003f48:	00813083          	ld	ra,8(sp)
    80003f4c:	00013403          	ld	s0,0(sp)
    80003f50:	01010113          	addi	sp,sp,16
    80003f54:	00008067          	ret
        status = -1;
    80003f58:	fff00793          	li	a5,-1
    80003f5c:	fe1ff06f          	j	80003f3c <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003f60 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003f60:	fd010113          	addi	sp,sp,-48
    80003f64:	02113423          	sd	ra,40(sp)
    80003f68:	02813023          	sd	s0,32(sp)
    80003f6c:	00913c23          	sd	s1,24(sp)
    80003f70:	01213823          	sd	s2,16(sp)
    80003f74:	01313423          	sd	s3,8(sp)
    80003f78:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003f7c:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003f80:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    80003f84:	01800513          	li	a0,24
    80003f88:	fffff097          	auipc	ra,0xfffff
    80003f8c:	d54080e7          	jalr	-684(ra) # 80002cdc <_ZN3SCBnwEm>
    80003f90:	00050493          	mv	s1,a0
    80003f94:	00090593          	mv	a1,s2
    80003f98:	fffff097          	auipc	ra,0xfffff
    80003f9c:	b88080e7          	jalr	-1144(ra) # 80002b20 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003fa0:	02048a63          	beqz	s1,80003fd4 <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    80003fa4:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    80003fa8:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003fac:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003fb0:	00000097          	auipc	ra,0x0
    80003fb4:	cac080e7          	jalr	-852(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003fb8:	02813083          	ld	ra,40(sp)
    80003fbc:	02013403          	ld	s0,32(sp)
    80003fc0:	01813483          	ld	s1,24(sp)
    80003fc4:	01013903          	ld	s2,16(sp)
    80003fc8:	00813983          	ld	s3,8(sp)
    80003fcc:	03010113          	addi	sp,sp,48
    80003fd0:	00008067          	ret
        status = -1;
    80003fd4:	fff00793          	li	a5,-1
    80003fd8:	fd5ff06f          	j	80003fac <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    80003fdc:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003fe0:	00048513          	mv	a0,s1
    80003fe4:	fffff097          	auipc	ra,0xfffff
    80003fe8:	d20080e7          	jalr	-736(ra) # 80002d04 <_ZN3SCBdlEPv>
    80003fec:	00090513          	mv	a0,s2
    80003ff0:	0000e097          	auipc	ra,0xe
    80003ff4:	778080e7          	jalr	1912(ra) # 80012768 <_Unwind_Resume>

0000000080003ff8 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003ff8:	fe010113          	addi	sp,sp,-32
    80003ffc:	00113c23          	sd	ra,24(sp)
    80004000:	00813823          	sd	s0,16(sp)
    80004004:	00913423          	sd	s1,8(sp)
    80004008:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000400c:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80004010:	02049463          	bnez	s1,80004038 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80004014:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004018:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000401c:	00000097          	auipc	ra,0x0
    80004020:	c40080e7          	jalr	-960(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004024:	01813083          	ld	ra,24(sp)
    80004028:	01013403          	ld	s0,16(sp)
    8000402c:	00813483          	ld	s1,8(sp)
    80004030:	02010113          	addi	sp,sp,32
    80004034:	00008067          	ret
        delete (SCB*)ihandle;
    80004038:	00048513          	mv	a0,s1
    8000403c:	fffff097          	auipc	ra,0xfffff
    80004040:	b08080e7          	jalr	-1272(ra) # 80002b44 <_ZN3SCBD1Ev>
    80004044:	00048513          	mv	a0,s1
    80004048:	fffff097          	auipc	ra,0xfffff
    8000404c:	cbc080e7          	jalr	-836(ra) # 80002d04 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80004050:	00000793          	li	a5,0
    80004054:	fc5ff06f          	j	80004018 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080004058 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80004058:	ff010113          	addi	sp,sp,-16
    8000405c:	00113423          	sd	ra,8(sp)
    80004060:	00813023          	sd	s0,0(sp)
    80004064:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004068:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    8000406c:	02051c63          	bnez	a0,800040a4 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80004070:	00009797          	auipc	a5,0x9
    80004074:	3787b783          	ld	a5,888(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004078:	0007b783          	ld	a5,0(a5)
    8000407c:	0607b783          	ld	a5,96(a5)
    80004080:	02078863          	beqz	a5,800040b0 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80004084:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004088:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000408c:	00000097          	auipc	ra,0x0
    80004090:	bd0080e7          	jalr	-1072(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004094:	00813083          	ld	ra,8(sp)
    80004098:	00013403          	ld	s0,0(sp)
    8000409c:	01010113          	addi	sp,sp,16
    800040a0:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800040a4:	fffff097          	auipc	ra,0xfffff
    800040a8:	bac080e7          	jalr	-1108(ra) # 80002c50 <_ZN3SCB4waitEv>
    800040ac:	fc5ff06f          	j	80004070 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800040b0:	00000793          	li	a5,0
    800040b4:	fd5ff06f          	j	80004088 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800040b8 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800040b8:	ff010113          	addi	sp,sp,-16
    800040bc:	00113423          	sd	ra,8(sp)
    800040c0:	00813023          	sd	s0,0(sp)
    800040c4:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800040c8:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800040cc:	02051263          	bnez	a0,800040f0 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    800040d0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800040d4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800040d8:	00000097          	auipc	ra,0x0
    800040dc:	b84080e7          	jalr	-1148(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    800040e0:	00813083          	ld	ra,8(sp)
    800040e4:	00013403          	ld	s0,0(sp)
    800040e8:	01010113          	addi	sp,sp,16
    800040ec:	00008067          	ret
        ((SCB*)ihandle)->signal();
    800040f0:	fffff097          	auipc	ra,0xfffff
    800040f4:	bb0080e7          	jalr	-1104(ra) # 80002ca0 <_ZN3SCB6signalEv>
    uint64 status = 0;
    800040f8:	00000793          	li	a5,0
    800040fc:	fd9ff06f          	j	800040d4 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080004100 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80004100:	fe010113          	addi	sp,sp,-32
    80004104:	00113c23          	sd	ra,24(sp)
    80004108:	00813823          	sd	s0,16(sp)
    8000410c:	00913423          	sd	s1,8(sp)
    80004110:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80004114:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80004118:	00009797          	auipc	a5,0x9
    8000411c:	2d07b783          	ld	a5,720(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004120:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80004124:	00009797          	auipc	a5,0x9
    80004128:	4f47b783          	ld	a5,1268(a5) # 8000d618 <_ZN5RiscV10globalTimeE>
    8000412c:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80004130:	00e787b3          	add	a5,a5,a4
    80004134:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80004138:	00048513          	mv	a0,s1
    8000413c:	00001097          	auipc	ra,0x1
    80004140:	8a8080e7          	jalr	-1880(ra) # 800049e4 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80004144:	00300793          	li	a5,3
    80004148:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    8000414c:	fffff097          	auipc	ra,0xfffff
    80004150:	d4c080e7          	jalr	-692(ra) # 80002e98 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004154:	00000793          	li	a5,0
    80004158:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000415c:	00000097          	auipc	ra,0x0
    80004160:	b00080e7          	jalr	-1280(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004164:	01813083          	ld	ra,24(sp)
    80004168:	01013403          	ld	s0,16(sp)
    8000416c:	00813483          	ld	s1,8(sp)
    80004170:	02010113          	addi	sp,sp,32
    80004174:	00008067          	ret

0000000080004178 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80004178:	fe010113          	addi	sp,sp,-32
    8000417c:	00113c23          	sd	ra,24(sp)
    80004180:	00813823          	sd	s0,16(sp)
    80004184:	00913423          	sd	s1,8(sp)
    80004188:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    8000418c:	00009797          	auipc	a5,0x9
    80004190:	4847c783          	lbu	a5,1156(a5) # 8000d610 <_ZN5RiscV16userMainFinishedE>
    80004194:	00079c63          	bnez	a5,800041ac <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80004198:	00009717          	auipc	a4,0x9
    8000419c:	20073703          	ld	a4,512(a4) # 8000d398 <_GLOBAL_OFFSET_TABLE_+0x40>
    800041a0:	00073783          	ld	a5,0(a4)
    800041a4:	00178793          	addi	a5,a5,1
    800041a8:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800041ac:	00001097          	auipc	ra,0x1
    800041b0:	ad0080e7          	jalr	-1328(ra) # 80004c7c <_ZN11ConsoleUtil8getInputEv>
    800041b4:	00050493          	mv	s1,a0
    if(c==13) {
    800041b8:	00d00793          	li	a5,13
    800041bc:	02f50663          	beq	a0,a5,800041e8 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    800041c0:	01b00793          	li	a5,27
    800041c4:	04f51063          	bne	a0,a5,80004204 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    800041c8:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    800041cc:	00000097          	auipc	ra,0x0
    800041d0:	a90080e7          	jalr	-1392(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    800041d4:	01813083          	ld	ra,24(sp)
    800041d8:	01013403          	ld	s0,16(sp)
    800041dc:	00813483          	ld	s1,8(sp)
    800041e0:	02010113          	addi	sp,sp,32
    800041e4:	00008067          	ret
        ConsoleUtil::putOutput(13);
    800041e8:	00d00513          	li	a0,13
    800041ec:	00001097          	auipc	ra,0x1
    800041f0:	b08080e7          	jalr	-1272(ra) # 80004cf4 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    800041f4:	00a00513          	li	a0,10
    800041f8:	00001097          	auipc	ra,0x1
    800041fc:	afc080e7          	jalr	-1284(ra) # 80004cf4 <_ZN11ConsoleUtil9putOutputEc>
    80004200:	fc9ff06f          	j	800041c8 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80004204:	00001097          	auipc	ra,0x1
    80004208:	af0080e7          	jalr	-1296(ra) # 80004cf4 <_ZN11ConsoleUtil9putOutputEc>
    8000420c:	fbdff06f          	j	800041c8 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080004210 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80004210:	ff010113          	addi	sp,sp,-16
    80004214:	00113423          	sd	ra,8(sp)
    80004218:	00813023          	sd	s0,0(sp)
    8000421c:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80004220:	00001097          	auipc	ra,0x1
    80004224:	b54080e7          	jalr	-1196(ra) # 80004d74 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80004228:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    8000422c:	00000097          	auipc	ra,0x0
    80004230:	a30080e7          	jalr	-1488(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004234:	00813083          	ld	ra,8(sp)
    80004238:	00013403          	ld	s0,0(sp)
    8000423c:	01010113          	addi	sp,sp,16
    80004240:	00008067          	ret

0000000080004244 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80004244:	fe010113          	addi	sp,sp,-32
    80004248:	00113c23          	sd	ra,24(sp)
    8000424c:	00813823          	sd	s0,16(sp)
    80004250:	00913423          	sd	s1,8(sp)
    80004254:	01213023          	sd	s2,0(sp)
    80004258:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000425c:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80004260:	02049663          	bnez	s1,8000428c <_ZN5RiscV24executeThreadFreeSyscallEv+0x48>
        status = -1;
    80004264:	fff00913          	li	s2,-1
        status = MemoryAllocator::kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004268:	00090513          	mv	a0,s2

    RiscV::saveA0toSscratch();
    8000426c:	00000097          	auipc	ra,0x0
    80004270:	9f0080e7          	jalr	-1552(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004274:	01813083          	ld	ra,24(sp)
    80004278:	01013403          	ld	s0,16(sp)
    8000427c:	00813483          	ld	s1,8(sp)
    80004280:	00013903          	ld	s2,0(sp)
    80004284:	02010113          	addi	sp,sp,32
    80004288:	00008067          	ret
        status = MemoryAllocator::kfree(thr->stack);
    8000428c:	0284b503          	ld	a0,40(s1)
    80004290:	fffff097          	auipc	ra,0xfffff
    80004294:	078080e7          	jalr	120(ra) # 80003308 <_ZN15MemoryAllocator5kfreeEPv>
    80004298:	00050913          	mv	s2,a0
        delete thr;
    8000429c:	00048513          	mv	a0,s1
    800042a0:	fffff097          	auipc	ra,0xfffff
    800042a4:	bd0080e7          	jalr	-1072(ra) # 80002e70 <_ZN3TCBD1Ev>
    800042a8:	00048513          	mv	a0,s1
    800042ac:	fffff097          	auipc	ra,0xfffff
    800042b0:	d60080e7          	jalr	-672(ra) # 8000300c <_ZN3TCBdlEPv>
    800042b4:	fb5ff06f          	j	80004268 <_ZN5RiscV24executeThreadFreeSyscallEv+0x24>

00000000800042b8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    800042b8:	fe010113          	addi	sp,sp,-32
    800042bc:	00113c23          	sd	ra,24(sp)
    800042c0:	00813823          	sd	s0,16(sp)
    800042c4:	00913423          	sd	s1,8(sp)
    800042c8:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800042cc:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    800042d0:	02049463          	bnez	s1,800042f8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800042d4:	fff00793          	li	a5,-1
    800042d8:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800042dc:	00000097          	auipc	ra,0x0
    800042e0:	980080e7          	jalr	-1664(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>
}
    800042e4:	01813083          	ld	ra,24(sp)
    800042e8:	01013403          	ld	s0,16(sp)
    800042ec:	00813483          	ld	s1,8(sp)
    800042f0:	02010113          	addi	sp,sp,32
    800042f4:	00008067          	ret
        delete scb;
    800042f8:	00048513          	mv	a0,s1
    800042fc:	fffff097          	auipc	ra,0xfffff
    80004300:	848080e7          	jalr	-1976(ra) # 80002b44 <_ZN3SCBD1Ev>
    80004304:	00048513          	mv	a0,s1
    80004308:	fffff097          	auipc	ra,0xfffff
    8000430c:	9fc080e7          	jalr	-1540(ra) # 80002d04 <_ZN3SCBdlEPv>
    80004310:	fc5ff06f          	j	800042d4 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080004314 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80004314:	fe010113          	addi	sp,sp,-32
    80004318:	00113c23          	sd	ra,24(sp)
    8000431c:	00813823          	sd	s0,16(sp)
    80004320:	00913423          	sd	s1,8(sp)
    80004324:	01213023          	sd	s2,0(sp)
    80004328:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    8000432c:	04000513          	li	a0,64
    80004330:	fffff097          	auipc	ra,0xfffff
    80004334:	db0080e7          	jalr	-592(ra) # 800030e0 <_ZN15MemoryAllocator7kmallocEm>
    80004338:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    8000433c:	00009797          	auipc	a5,0x9
    80004340:	0ac7b783          	ld	a5,172(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004344:	0007b783          	ld	a5,0(a5)
    80004348:	00001637          	lui	a2,0x1
    8000434c:	00050593          	mv	a1,a0
    80004350:	0287b503          	ld	a0,40(a5)
    80004354:	fffff097          	auipc	ra,0xfffff
    80004358:	168080e7          	jalr	360(ra) # 800034bc <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    8000435c:	07000513          	li	a0,112
    80004360:	fffff097          	auipc	ra,0xfffff
    80004364:	bb8080e7          	jalr	-1096(ra) # 80002f18 <_ZN3TCBnwEm>
    80004368:	00050493          	mv	s1,a0
    8000436c:	00200713          	li	a4,2
    80004370:	00090693          	mv	a3,s2
    80004374:	00000613          	li	a2,0
    80004378:	00000593          	li	a1,0
    8000437c:	fffff097          	auipc	ra,0xfffff
    80004380:	a50080e7          	jalr	-1456(ra) # 80002dcc <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80004384:	0a048e63          	beqz	s1,80004440 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80004388:	00009797          	auipc	a5,0x9
    8000438c:	0287b783          	ld	a5,40(a5) # 8000d3b0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004390:	0007b783          	ld	a5,0(a5)
    80004394:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80004398:	00009797          	auipc	a5,0x9
    8000439c:	0087b783          	ld	a5,8(a5) # 8000d3a0 <_GLOBAL_OFFSET_TABLE_+0x48>
    800043a0:	0007b783          	ld	a5,0(a5)
    800043a4:	00f907b3          	add	a5,s2,a5
    800043a8:	00009717          	auipc	a4,0x9
    800043ac:	04073703          	ld	a4,64(a4) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    800043b0:	00073683          	ld	a3,0(a4)
    800043b4:	0286b683          	ld	a3,40(a3)
    800043b8:	40d787b3          	sub	a5,a5,a3
    800043bc:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    800043c0:	00073783          	ld	a5,0(a4)
    800043c4:	0687b503          	ld	a0,104(a5)
    800043c8:	0287b783          	ld	a5,40(a5)
    800043cc:	40f50533          	sub	a0,a0,a5
    800043d0:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    800043d4:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    800043d8:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    800043dc:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    800043e0:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    800043e4:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    800043e8:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    800043ec:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    800043f0:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800043f4:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    800043f8:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    800043fc:	00073783          	ld	a5,0(a4)
    80004400:	0387b703          	ld	a4,56(a5)
    80004404:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80004408:	0407b783          	ld	a5,64(a5)
    8000440c:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80004410:	00048513          	mv	a0,s1
    80004414:	00000097          	auipc	ra,0x0
    80004418:	554080e7          	jalr	1364(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    8000441c:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80004420:	00000097          	auipc	ra,0x0
    80004424:	83c080e7          	jalr	-1988(ra) # 80003c5c <_ZN5RiscV16saveA0toSscratchEv>

}
    80004428:	01813083          	ld	ra,24(sp)
    8000442c:	01013403          	ld	s0,16(sp)
    80004430:	00813483          	ld	s1,8(sp)
    80004434:	00013903          	ld	s2,0(sp)
    80004438:	02010113          	addi	sp,sp,32
    8000443c:	00008067          	ret
        status = -1;
    80004440:	fff00493          	li	s1,-1
    80004444:	fd9ff06f          	j	8000441c <_ZN5RiscV18executeForkSyscallEv+0x108>
    80004448:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    8000444c:	00048513          	mv	a0,s1
    80004450:	fffff097          	auipc	ra,0xfffff
    80004454:	bbc080e7          	jalr	-1092(ra) # 8000300c <_ZN3TCBdlEPv>
    80004458:	00090513          	mv	a0,s2
    8000445c:	0000e097          	auipc	ra,0xe
    80004460:	30c080e7          	jalr	780(ra) # 80012768 <_Unwind_Resume>

0000000080004464 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80004464:	ff010113          	addi	sp,sp,-16
    80004468:	00813423          	sd	s0,8(sp)
    8000446c:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80004470:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80004474:	00878793          	addi	a5,a5,8
    80004478:	00009717          	auipc	a4,0x9
    8000447c:	f3873703          	ld	a4,-200(a4) # 8000d3b0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004480:	00f73023          	sd	a5,0(a4)
}
    80004484:	00813403          	ld	s0,8(sp)
    80004488:	01010113          	addi	sp,sp,16
    8000448c:	00008067          	ret

0000000080004490 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80004490:	fa010113          	addi	sp,sp,-96
    80004494:	04113c23          	sd	ra,88(sp)
    80004498:	04813823          	sd	s0,80(sp)
    8000449c:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800044a0:	142027f3          	csrr	a5,scause
    800044a4:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    800044a8:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    800044ac:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    800044b0:	00009797          	auipc	a5,0x9
    800044b4:	f387b783          	ld	a5,-200(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    800044b8:	0007b783          	ld	a5,0(a5)
    800044bc:	14002773          	csrr	a4,sscratch
    800044c0:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    800044c4:	fe843703          	ld	a4,-24(s0)
    800044c8:	00900793          	li	a5,9
    800044cc:	0ef70663          	beq	a4,a5,800045b8 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    800044d0:	fe843703          	ld	a4,-24(s0)
    800044d4:	00800793          	li	a5,8
    800044d8:	0ef70063          	beq	a4,a5,800045b8 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    800044dc:	fe843703          	ld	a4,-24(s0)
    800044e0:	fff00793          	li	a5,-1
    800044e4:	03f79793          	slli	a5,a5,0x3f
    800044e8:	00178793          	addi	a5,a5,1
    800044ec:	24f70263          	beq	a4,a5,80004730 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    800044f0:	fe843703          	ld	a4,-24(s0)
    800044f4:	fff00793          	li	a5,-1
    800044f8:	03f79793          	slli	a5,a5,0x3f
    800044fc:	00978793          	addi	a5,a5,9
    80004500:	2cf70063          	beq	a4,a5,800047c0 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80004504:	fe843703          	ld	a4,-24(s0)
    80004508:	00200793          	li	a5,2
    8000450c:	34f70863          	beq	a4,a5,8000485c <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80004510:	00006517          	auipc	a0,0x6
    80004514:	e7050513          	addi	a0,a0,-400 # 8000a380 <CONSOLE_STATUS+0x370>
    80004518:	00001097          	auipc	ra,0x1
    8000451c:	8d4080e7          	jalr	-1836(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80004520:	00006517          	auipc	a0,0x6
    80004524:	e7050513          	addi	a0,a0,-400 # 8000a390 <CONSOLE_STATUS+0x380>
    80004528:	00001097          	auipc	ra,0x1
    8000452c:	8c4080e7          	jalr	-1852(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004530:	142027f3          	csrr	a5,scause
    80004534:	fef43023          	sd	a5,-32(s0)
    return scause;
    80004538:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    8000453c:	00000613          	li	a2,0
    80004540:	00a00593          	li	a1,10
    80004544:	0005051b          	sext.w	a0,a0
    80004548:	00001097          	auipc	ra,0x1
    8000454c:	8e8080e7          	jalr	-1816(ra) # 80004e30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80004550:	00006517          	auipc	a0,0x6
    80004554:	e0050513          	addi	a0,a0,-512 # 8000a350 <CONSOLE_STATUS+0x340>
    80004558:	00001097          	auipc	ra,0x1
    8000455c:	894080e7          	jalr	-1900(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004560:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004564:	00000613          	li	a2,0
    80004568:	01000593          	li	a1,16
    8000456c:	0005051b          	sext.w	a0,a0
    80004570:	00001097          	auipc	ra,0x1
    80004574:	8c0080e7          	jalr	-1856(ra) # 80004e30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004578:	00006517          	auipc	a0,0x6
    8000457c:	dd050513          	addi	a0,a0,-560 # 8000a348 <CONSOLE_STATUS+0x338>
    80004580:	00001097          	auipc	ra,0x1
    80004584:	86c080e7          	jalr	-1940(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    80004588:	00009797          	auipc	a5,0x9
    8000458c:	e607b783          	ld	a5,-416(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004590:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004594:	00200713          	li	a4,2
    80004598:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    8000459c:	00006517          	auipc	a0,0x6
    800045a0:	e0450513          	addi	a0,a0,-508 # 8000a3a0 <CONSOLE_STATUS+0x390>
    800045a4:	00001097          	auipc	ra,0x1
    800045a8:	848080e7          	jalr	-1976(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800045ac:	fffff097          	auipc	ra,0xfffff
    800045b0:	8ec080e7          	jalr	-1812(ra) # 80002e98 <_ZN3TCB8dispatchEv>
    800045b4:	0800006f          	j	80004634 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800045b8:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800045bc:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800045c0:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    800045c4:	00478793          	addi	a5,a5,4
    800045c8:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    800045cc:	00009797          	auipc	a5,0x9
    800045d0:	e1c7b783          	ld	a5,-484(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    800045d4:	0007b783          	ld	a5,0(a5)
    800045d8:	fb043703          	ld	a4,-80(s0)
    800045dc:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800045e0:	fa843703          	ld	a4,-88(s0)
    800045e4:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800045e8:	00050793          	mv	a5,a0
        switch(syscallID){
    800045ec:	06100713          	li	a4,97
    800045f0:	02f76463          	bltu	a4,a5,80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    800045f4:	00279793          	slli	a5,a5,0x2
    800045f8:	00006717          	auipc	a4,0x6
    800045fc:	dbc70713          	addi	a4,a4,-580 # 8000a3b4 <CONSOLE_STATUS+0x3a4>
    80004600:	00e787b3          	add	a5,a5,a4
    80004604:	0007a783          	lw	a5,0(a5)
    80004608:	00e787b3          	add	a5,a5,a4
    8000460c:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004610:	fffff097          	auipc	ra,0xfffff
    80004614:	684080e7          	jalr	1668(ra) # 80003c94 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004618:	00009797          	auipc	a5,0x9
    8000461c:	dd07b783          	ld	a5,-560(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004620:	0007b783          	ld	a5,0(a5)
    80004624:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004628:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    8000462c:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004630:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80004634:	fffff097          	auipc	ra,0xfffff
    80004638:	530080e7          	jalr	1328(ra) # 80003b64 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    8000463c:	05813083          	ld	ra,88(sp)
    80004640:	05013403          	ld	s0,80(sp)
    80004644:	06010113          	addi	sp,sp,96
    80004648:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    8000464c:	fffff097          	auipc	ra,0xfffff
    80004650:	680080e7          	jalr	1664(ra) # 80003ccc <_ZN5RiscV21executeMemFreeSyscallEv>
    80004654:	fc5ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80004658:	fffff097          	auipc	ra,0xfffff
    8000465c:	6c4080e7          	jalr	1732(ra) # 80003d1c <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004660:	fb9ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80004664:	00000097          	auipc	ra,0x0
    80004668:	8a4080e7          	jalr	-1884(ra) # 80003f08 <_ZN5RiscV24executeThreadExitSyscallEv>
    8000466c:	fadff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004670:	fffff097          	auipc	ra,0xfffff
    80004674:	3e0080e7          	jalr	992(ra) # 80003a50 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80004678:	fa1ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    8000467c:	fffff097          	auipc	ra,0xfffff
    80004680:	770080e7          	jalr	1904(ra) # 80003dec <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004684:	f95ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80004688:	00000097          	auipc	ra,0x0
    8000468c:	828080e7          	jalr	-2008(ra) # 80003eb0 <_ZN5RiscV25executeThreadStartSyscallEv>
    80004690:	f89ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80004694:	00000097          	auipc	ra,0x0
    80004698:	8cc080e7          	jalr	-1844(ra) # 80003f60 <_ZN5RiscV21executeSemOpenSyscallEv>
    8000469c:	f7dff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    800046a0:	00000097          	auipc	ra,0x0
    800046a4:	958080e7          	jalr	-1704(ra) # 80003ff8 <_ZN5RiscV22executeSemCloseSyscallEv>
    800046a8:	f71ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    800046ac:	00000097          	auipc	ra,0x0
    800046b0:	9ac080e7          	jalr	-1620(ra) # 80004058 <_ZN5RiscV21executeSemWaitSyscallEv>
    800046b4:	f65ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    800046b8:	00000097          	auipc	ra,0x0
    800046bc:	a00080e7          	jalr	-1536(ra) # 800040b8 <_ZN5RiscV23executeSemSignalSyscallEv>
    800046c0:	f59ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    800046c4:	00000097          	auipc	ra,0x0
    800046c8:	a3c080e7          	jalr	-1476(ra) # 80004100 <_ZN5RiscV23executeTimeSleepSyscallEv>
    800046cc:	f4dff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    800046d0:	00000097          	auipc	ra,0x0
    800046d4:	aa8080e7          	jalr	-1368(ra) # 80004178 <_ZN5RiscV18executeGetcSyscallEv>
    800046d8:	f41ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    800046dc:	fffff097          	auipc	ra,0xfffff
    800046e0:	3b0080e7          	jalr	944(ra) # 80003a8c <_ZN5RiscV18executePutcSyscallEv>
    800046e4:	f35ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    800046e8:	00000097          	auipc	ra,0x0
    800046ec:	b28080e7          	jalr	-1240(ra) # 80004210 <_ZN5RiscV22executePutcUtilSyscallEv>
    800046f0:	f29ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    800046f4:	00000097          	auipc	ra,0x0
    800046f8:	b50080e7          	jalr	-1200(ra) # 80004244 <_ZN5RiscV24executeThreadFreeSyscallEv>
    800046fc:	f1dff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004700:	00000097          	auipc	ra,0x0
    80004704:	bb8080e7          	jalr	-1096(ra) # 800042b8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004708:	f11ff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    8000470c:	00010793          	mv	a5,sp
    80004710:	00009717          	auipc	a4,0x9
    80004714:	c9073703          	ld	a4,-880(a4) # 8000d3a0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004718:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    8000471c:	00000097          	auipc	ra,0x0
    80004720:	d48080e7          	jalr	-696(ra) # 80004464 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004724:	00000097          	auipc	ra,0x0
    80004728:	bf0080e7          	jalr	-1040(ra) # 80004314 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    8000472c:	eedff06f          	j	80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004730:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004734:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004738:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    8000473c:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004740:	00200793          	li	a5,2
    80004744:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80004748:	00009717          	auipc	a4,0x9
    8000474c:	ec870713          	addi	a4,a4,-312 # 8000d610 <_ZN5RiscV16userMainFinishedE>
    80004750:	00873783          	ld	a5,8(a4)
    80004754:	00178793          	addi	a5,a5,1
    80004758:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    8000475c:	00000097          	auipc	ra,0x0
    80004760:	2e0080e7          	jalr	736(ra) # 80004a3c <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80004764:	00009717          	auipc	a4,0x9
    80004768:	c1c73703          	ld	a4,-996(a4) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000476c:	00073783          	ld	a5,0(a4)
    80004770:	00178793          	addi	a5,a5,1
    80004774:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80004778:	00009717          	auipc	a4,0x9
    8000477c:	c7073703          	ld	a4,-912(a4) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004780:	00073703          	ld	a4,0(a4)
    80004784:	03073683          	ld	a3,48(a4)
    80004788:	00d7fc63          	bgeu	a5,a3,800047a0 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    8000478c:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004790:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004794:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004798:	14179073          	csrw	sepc,a5
}
    8000479c:	e99ff06f          	j	80004634 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    800047a0:	00009797          	auipc	a5,0x9
    800047a4:	be07b783          	ld	a5,-1056(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x28>
    800047a8:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    800047ac:	00100793          	li	a5,1
    800047b0:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    800047b4:	ffffe097          	auipc	ra,0xffffe
    800047b8:	6e4080e7          	jalr	1764(ra) # 80002e98 <_ZN3TCB8dispatchEv>
    800047bc:	fd1ff06f          	j	8000478c <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800047c0:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800047c4:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800047c8:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800047cc:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    800047d0:	00009797          	auipc	a5,0x9
    800047d4:	b987b783          	ld	a5,-1128(a5) # 8000d368 <_GLOBAL_OFFSET_TABLE_+0x10>
    800047d8:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800047dc:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800047e0:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800047e4:	00058793          	mv	a5,a1
        if(status & 1UL)
    800047e8:	0017f793          	andi	a5,a5,1
    800047ec:	02078863          	beqz	a5,8000481c <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    800047f0:	00009797          	auipc	a5,0x9
    800047f4:	ba07b783          	ld	a5,-1120(a5) # 8000d390 <_GLOBAL_OFFSET_TABLE_+0x38>
    800047f8:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    800047fc:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004800:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004804:	00058513          	mv	a0,a1
    80004808:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    8000480c:	00009797          	auipc	a5,0x9
    80004810:	b8c7b783          	ld	a5,-1140(a5) # 8000d398 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004814:	0007b783          	ld	a5,0(a5)
    80004818:	02079463          	bnez	a5,80004840 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    8000481c:	00003097          	auipc	ra,0x3
    80004820:	358080e7          	jalr	856(ra) # 80007b74 <plic_claim>
    80004824:	00003097          	auipc	ra,0x3
    80004828:	388080e7          	jalr	904(ra) # 80007bac <plic_complete>
        RiscV::w_sstatus(sstatus);
    8000482c:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004830:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004834:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004838:	14179073          	csrw	sepc,a5
}
    8000483c:	df9ff06f          	j	80004634 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80004840:	fff78793          	addi	a5,a5,-1
    80004844:	00009717          	auipc	a4,0x9
    80004848:	b5473703          	ld	a4,-1196(a4) # 8000d398 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000484c:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004850:	00000097          	auipc	ra,0x0
    80004854:	3c4080e7          	jalr	964(ra) # 80004c14 <_ZN11ConsoleUtil8putInputEc>
    80004858:	fc5ff06f          	j	8000481c <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    8000485c:	00009797          	auipc	a5,0x9
    80004860:	b8c7b783          	ld	a5,-1140(a5) # 8000d3e8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004864:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004868:	00200713          	li	a4,2
    8000486c:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004870:	00006517          	auipc	a0,0x6
    80004874:	ae050513          	addi	a0,a0,-1312 # 8000a350 <CONSOLE_STATUS+0x340>
    80004878:	00000097          	auipc	ra,0x0
    8000487c:	574080e7          	jalr	1396(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004880:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004884:	00000613          	li	a2,0
    80004888:	01000593          	li	a1,16
    8000488c:	0005051b          	sext.w	a0,a0
    80004890:	00000097          	auipc	ra,0x0
    80004894:	5a0080e7          	jalr	1440(ra) # 80004e30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004898:	00006517          	auipc	a0,0x6
    8000489c:	ab050513          	addi	a0,a0,-1360 # 8000a348 <CONSOLE_STATUS+0x338>
    800048a0:	00000097          	auipc	ra,0x0
    800048a4:	54c080e7          	jalr	1356(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    800048a8:	00006517          	auipc	a0,0x6
    800048ac:	ab050513          	addi	a0,a0,-1360 # 8000a358 <CONSOLE_STATUS+0x348>
    800048b0:	00000097          	auipc	ra,0x0
    800048b4:	53c080e7          	jalr	1340(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800048b8:	ffffe097          	auipc	ra,0xffffe
    800048bc:	5e0080e7          	jalr	1504(ra) # 80002e98 <_ZN3TCB8dispatchEv>
    800048c0:	d75ff06f          	j	80004634 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

00000000800048c4 <_Z6strcpyPKcPc>:
//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    800048c4:	ff010113          	addi	sp,sp,-16
    800048c8:	00813423          	sd	s0,8(sp)
    800048cc:	01010413          	addi	s0,sp,16
    800048d0:	00050793          	mv	a5,a0
    800048d4:	00058513          	mv	a0,a1
    while(*src != '\0')
    800048d8:	0007c703          	lbu	a4,0(a5)
    800048dc:	00070a63          	beqz	a4,800048f0 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    800048e0:	00178793          	addi	a5,a5,1
    800048e4:	00e50023          	sb	a4,0(a0)
    800048e8:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    800048ec:	fedff06f          	j	800048d8 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    800048f0:	00e50023          	sb	a4,0(a0)
    return dst;
}
    800048f4:	00813403          	ld	s0,8(sp)
    800048f8:	01010113          	addi	sp,sp,16
    800048fc:	00008067          	ret

0000000080004900 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004900:	fe010113          	addi	sp,sp,-32
    80004904:	00113c23          	sd	ra,24(sp)
    80004908:	00813823          	sd	s0,16(sp)
    8000490c:	00913423          	sd	s1,8(sp)
    80004910:	02010413          	addi	s0,sp,32
    80004914:	00050493          	mv	s1,a0
    80004918:	00058513          	mv	a0,a1
    char *dest = dst;
    8000491c:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004920:	0005c783          	lbu	a5,0(a1)
    80004924:	00078663          	beqz	a5,80004930 <_Z6strcatPcPKc+0x30>
        dest++;
    80004928:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    8000492c:	ff5ff06f          	j	80004920 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004930:	00000097          	auipc	ra,0x0
    80004934:	f94080e7          	jalr	-108(ra) # 800048c4 <_Z6strcpyPKcPc>
    return dst;
}
    80004938:	00048513          	mv	a0,s1
    8000493c:	01813083          	ld	ra,24(sp)
    80004940:	01013403          	ld	s0,16(sp)
    80004944:	00813483          	ld	s1,8(sp)
    80004948:	02010113          	addi	sp,sp,32
    8000494c:	00008067          	ret

0000000080004950 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004950:	ff010113          	addi	sp,sp,-16
    80004954:	00813423          	sd	s0,8(sp)
    80004958:	01010413          	addi	s0,sp,16
}
    8000495c:	00813403          	ld	s0,8(sp)
    80004960:	01010113          	addi	sp,sp,16
    80004964:	00008067          	ret

0000000080004968 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004968:	ff010113          	addi	sp,sp,-16
    8000496c:	00813423          	sd	s0,8(sp)
    80004970:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004974:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004978:	00009797          	auipc	a5,0x9
    8000497c:	ca87b783          	ld	a5,-856(a5) # 8000d620 <_ZN9Scheduler9readyHeadE>
    80004980:	02078263          	beqz	a5,800049a4 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004984:	00009797          	auipc	a5,0x9
    80004988:	ca47b783          	ld	a5,-860(a5) # 8000d628 <_ZN9Scheduler9readyTailE>
    8000498c:	04a7b423          	sd	a0,72(a5)
    80004990:	00009797          	auipc	a5,0x9
    80004994:	c8a7bc23          	sd	a0,-872(a5) # 8000d628 <_ZN9Scheduler9readyTailE>
}
    80004998:	00813403          	ld	s0,8(sp)
    8000499c:	01010113          	addi	sp,sp,16
    800049a0:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800049a4:	00009797          	auipc	a5,0x9
    800049a8:	c6a7be23          	sd	a0,-900(a5) # 8000d620 <_ZN9Scheduler9readyHeadE>
    800049ac:	fe5ff06f          	j	80004990 <_ZN9Scheduler3putEP3TCB+0x28>

00000000800049b0 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    800049b0:	ff010113          	addi	sp,sp,-16
    800049b4:	00813423          	sd	s0,8(sp)
    800049b8:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    800049bc:	00009517          	auipc	a0,0x9
    800049c0:	c6453503          	ld	a0,-924(a0) # 8000d620 <_ZN9Scheduler9readyHeadE>
    800049c4:	00050a63          	beqz	a0,800049d8 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    800049c8:	04853783          	ld	a5,72(a0)
    800049cc:	00009717          	auipc	a4,0x9
    800049d0:	c4f73a23          	sd	a5,-940(a4) # 8000d620 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    800049d4:	04053423          	sd	zero,72(a0)
    return tmp;
}
    800049d8:	00813403          	ld	s0,8(sp)
    800049dc:	01010113          	addi	sp,sp,16
    800049e0:	00008067          	ret

00000000800049e4 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    800049e4:	ff010113          	addi	sp,sp,-16
    800049e8:	00813423          	sd	s0,8(sp)
    800049ec:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    800049f0:	00009797          	auipc	a5,0x9
    800049f4:	c407b783          	ld	a5,-960(a5) # 8000d630 <_ZN9Scheduler12sleepingHeadE>
    800049f8:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800049fc:	00078e63          	beqz	a5,80004a18 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004a00:	0587b683          	ld	a3,88(a5)
    80004a04:	05853703          	ld	a4,88(a0)
    80004a08:	00d76863          	bltu	a4,a3,80004a18 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004a0c:	00078613          	mv	a2,a5
    80004a10:	0487b783          	ld	a5,72(a5)
    80004a14:	fe9ff06f          	j	800049fc <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004a18:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004a1c:	00060a63          	beqz	a2,80004a30 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004a20:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80004a24:	00813403          	ld	s0,8(sp)
    80004a28:	01010113          	addi	sp,sp,16
    80004a2c:	00008067          	ret
        sleepingHead = t;
    80004a30:	00009797          	auipc	a5,0x9
    80004a34:	c0a7b023          	sd	a0,-1024(a5) # 8000d630 <_ZN9Scheduler12sleepingHeadE>
}
    80004a38:	fedff06f          	j	80004a24 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004a3c <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004a3c:	fe010113          	addi	sp,sp,-32
    80004a40:	00113c23          	sd	ra,24(sp)
    80004a44:	00813823          	sd	s0,16(sp)
    80004a48:	00913423          	sd	s1,8(sp)
    80004a4c:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004a50:	00009497          	auipc	s1,0x9
    80004a54:	be04b483          	ld	s1,-1056(s1) # 8000d630 <_ZN9Scheduler12sleepingHeadE>
    80004a58:	02048c63          	beqz	s1,80004a90 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004a5c:	0584b703          	ld	a4,88(s1)
    80004a60:	00009797          	auipc	a5,0x9
    80004a64:	9a07b783          	ld	a5,-1632(a5) # 8000d400 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80004a68:	0007b783          	ld	a5,0(a5)
    80004a6c:	02e7e263          	bltu	a5,a4,80004a90 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004a70:	0484b783          	ld	a5,72(s1)
    80004a74:	00009717          	auipc	a4,0x9
    80004a78:	baf73e23          	sd	a5,-1092(a4) # 8000d630 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004a7c:	00048513          	mv	a0,s1
    80004a80:	00000097          	auipc	ra,0x0
    80004a84:	ee8080e7          	jalr	-280(ra) # 80004968 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004a88:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004a8c:	fc5ff06f          	j	80004a50 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004a90:	01813083          	ld	ra,24(sp)
    80004a94:	01013403          	ld	s0,16(sp)
    80004a98:	00813483          	ld	s1,8(sp)
    80004a9c:	02010113          	addi	sp,sp,32
    80004aa0:	00008067          	ret

0000000080004aa4 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004aa4:	fe010113          	addi	sp,sp,-32
    80004aa8:	00113c23          	sd	ra,24(sp)
    80004aac:	00813823          	sd	s0,16(sp)
    80004ab0:	00913423          	sd	s1,8(sp)
    80004ab4:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004ab8:	00009497          	auipc	s1,0x9
    80004abc:	b684b483          	ld	s1,-1176(s1) # 8000d620 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004ac0:	02048863          	beqz	s1,80004af0 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004ac4:	00000613          	li	a2,0
    80004ac8:	01000593          	li	a1,16
    80004acc:	0004851b          	sext.w	a0,s1
    80004ad0:	00000097          	auipc	ra,0x0
    80004ad4:	360080e7          	jalr	864(ra) # 80004e30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004ad8:	00006517          	auipc	a0,0x6
    80004adc:	87050513          	addi	a0,a0,-1936 # 8000a348 <CONSOLE_STATUS+0x338>
    80004ae0:	00000097          	auipc	ra,0x0
    80004ae4:	30c080e7          	jalr	780(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004ae8:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004aec:	fd5ff06f          	j	80004ac0 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004af0:	01813083          	ld	ra,24(sp)
    80004af4:	01013403          	ld	s0,16(sp)
    80004af8:	00813483          	ld	s1,8(sp)
    80004afc:	02010113          	addi	sp,sp,32
    80004b00:	00008067          	ret

0000000080004b04 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004b04:	fe010113          	addi	sp,sp,-32
    80004b08:	00113c23          	sd	ra,24(sp)
    80004b0c:	00813823          	sd	s0,16(sp)
    80004b10:	00913423          	sd	s1,8(sp)
    80004b14:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004b18:	00009497          	auipc	s1,0x9
    80004b1c:	b184b483          	ld	s1,-1256(s1) # 8000d630 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004b20:	02048863          	beqz	s1,80004b50 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004b24:	00000613          	li	a2,0
    80004b28:	01000593          	li	a1,16
    80004b2c:	0004851b          	sext.w	a0,s1
    80004b30:	ffffe097          	auipc	ra,0xffffe
    80004b34:	edc080e7          	jalr	-292(ra) # 80002a0c <_Z8printIntiii>
        printString("\n");
    80004b38:	00006517          	auipc	a0,0x6
    80004b3c:	81050513          	addi	a0,a0,-2032 # 8000a348 <CONSOLE_STATUS+0x338>
    80004b40:	ffffe097          	auipc	ra,0xffffe
    80004b44:	d34080e7          	jalr	-716(ra) # 80002874 <_Z11printStringPKc>
        iter = iter->next;
    80004b48:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004b4c:	fd5ff06f          	j	80004b20 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004b50:	01813083          	ld	ra,24(sp)
    80004b54:	01013403          	ld	s0,16(sp)
    80004b58:	00813483          	ld	s1,8(sp)
    80004b5c:	02010113          	addi	sp,sp,32
    80004b60:	00008067          	ret

0000000080004b64 <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    80004b64:	fe010113          	addi	sp,sp,-32
    80004b68:	00113c23          	sd	ra,24(sp)
    80004b6c:	00813823          	sd	s0,16(sp)
    80004b70:	00913423          	sd	s1,8(sp)
    80004b74:	01213023          	sd	s2,0(sp)
    80004b78:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004b7c:	01800513          	li	a0,24
    80004b80:	ffffe097          	auipc	ra,0xffffe
    80004b84:	15c080e7          	jalr	348(ra) # 80002cdc <_ZN3SCBnwEm>
    80004b88:	00050493          	mv	s1,a0
    80004b8c:	00000593          	li	a1,0
    80004b90:	ffffe097          	auipc	ra,0xffffe
    80004b94:	f90080e7          	jalr	-112(ra) # 80002b20 <_ZN3SCBC1Em>
    80004b98:	00009797          	auipc	a5,0x9
    80004b9c:	aa97b023          	sd	s1,-1376(a5) # 8000d638 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004ba0:	01800513          	li	a0,24
    80004ba4:	ffffe097          	auipc	ra,0xffffe
    80004ba8:	138080e7          	jalr	312(ra) # 80002cdc <_ZN3SCBnwEm>
    80004bac:	00050493          	mv	s1,a0
    80004bb0:	00000593          	li	a1,0
    80004bb4:	ffffe097          	auipc	ra,0xffffe
    80004bb8:	f6c080e7          	jalr	-148(ra) # 80002b20 <_ZN3SCBC1Em>
    80004bbc:	00009797          	auipc	a5,0x9
    80004bc0:	a897b223          	sd	s1,-1404(a5) # 8000d640 <_ZN11ConsoleUtil9outputSemE>
}
    80004bc4:	01813083          	ld	ra,24(sp)
    80004bc8:	01013403          	ld	s0,16(sp)
    80004bcc:	00813483          	ld	s1,8(sp)
    80004bd0:	00013903          	ld	s2,0(sp)
    80004bd4:	02010113          	addi	sp,sp,32
    80004bd8:	00008067          	ret
    80004bdc:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004be0:	00048513          	mv	a0,s1
    80004be4:	ffffe097          	auipc	ra,0xffffe
    80004be8:	120080e7          	jalr	288(ra) # 80002d04 <_ZN3SCBdlEPv>
    80004bec:	00090513          	mv	a0,s2
    80004bf0:	0000e097          	auipc	ra,0xe
    80004bf4:	b78080e7          	jalr	-1160(ra) # 80012768 <_Unwind_Resume>
    80004bf8:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004bfc:	00048513          	mv	a0,s1
    80004c00:	ffffe097          	auipc	ra,0xffffe
    80004c04:	104080e7          	jalr	260(ra) # 80002d04 <_ZN3SCBdlEPv>
    80004c08:	00090513          	mv	a0,s2
    80004c0c:	0000e097          	auipc	ra,0xe
    80004c10:	b5c080e7          	jalr	-1188(ra) # 80012768 <_Unwind_Resume>

0000000080004c14 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004c14:	00009697          	auipc	a3,0x9
    80004c18:	a2468693          	addi	a3,a3,-1500 # 8000d638 <_ZN11ConsoleUtil8inputSemE>
    80004c1c:	0106b603          	ld	a2,16(a3)
    80004c20:	00160793          	addi	a5,a2,1
    80004c24:	00002737          	lui	a4,0x2
    80004c28:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004c2c:	00e7f7b3          	and	a5,a5,a4
    80004c30:	0186b703          	ld	a4,24(a3)
    80004c34:	04e78263          	beq	a5,a4,80004c78 <_ZN11ConsoleUtil8putInputEc+0x64>
void ConsoleUtil::putInput(char c) {
    80004c38:	ff010113          	addi	sp,sp,-16
    80004c3c:	00113423          	sd	ra,8(sp)
    80004c40:	00813023          	sd	s0,0(sp)
    80004c44:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004c48:	0000b717          	auipc	a4,0xb
    80004c4c:	a2870713          	addi	a4,a4,-1496 # 8000f670 <_ZN11ConsoleUtil11inputBufferE>
    80004c50:	00c70633          	add	a2,a4,a2
    80004c54:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    80004c58:	00f6b823          	sd	a5,16(a3)
    inputSem->signal();
    80004c5c:	0006b503          	ld	a0,0(a3)
    80004c60:	ffffe097          	auipc	ra,0xffffe
    80004c64:	040080e7          	jalr	64(ra) # 80002ca0 <_ZN3SCB6signalEv>
}
    80004c68:	00813083          	ld	ra,8(sp)
    80004c6c:	00013403          	ld	s0,0(sp)
    80004c70:	01010113          	addi	sp,sp,16
    80004c74:	00008067          	ret
    80004c78:	00008067          	ret

0000000080004c7c <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004c7c:	fe010113          	addi	sp,sp,-32
    80004c80:	00113c23          	sd	ra,24(sp)
    80004c84:	00813823          	sd	s0,16(sp)
    80004c88:	00913423          	sd	s1,8(sp)
    80004c8c:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004c90:	00009497          	auipc	s1,0x9
    80004c94:	9a848493          	addi	s1,s1,-1624 # 8000d638 <_ZN11ConsoleUtil8inputSemE>
    80004c98:	0004b503          	ld	a0,0(s1)
    80004c9c:	ffffe097          	auipc	ra,0xffffe
    80004ca0:	fb4080e7          	jalr	-76(ra) # 80002c50 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004ca4:	0184b783          	ld	a5,24(s1)
    80004ca8:	0104b703          	ld	a4,16(s1)
    80004cac:	04e78063          	beq	a5,a4,80004cec <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80004cb0:	0000b717          	auipc	a4,0xb
    80004cb4:	9c070713          	addi	a4,a4,-1600 # 8000f670 <_ZN11ConsoleUtil11inputBufferE>
    80004cb8:	00f70733          	add	a4,a4,a5
    80004cbc:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004cc0:	00178793          	addi	a5,a5,1
    80004cc4:	00002737          	lui	a4,0x2
    80004cc8:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004ccc:	00e7f7b3          	and	a5,a5,a4
    80004cd0:	00009717          	auipc	a4,0x9
    80004cd4:	98f73023          	sd	a5,-1664(a4) # 8000d650 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004cd8:	01813083          	ld	ra,24(sp)
    80004cdc:	01013403          	ld	s0,16(sp)
    80004ce0:	00813483          	ld	s1,8(sp)
    80004ce4:	02010113          	addi	sp,sp,32
    80004ce8:	00008067          	ret
        return -1;
    80004cec:	0ff00513          	li	a0,255
    80004cf0:	fe9ff06f          	j	80004cd8 <_ZN11ConsoleUtil8getInputEv+0x5c>

0000000080004cf4 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004cf4:	00009797          	auipc	a5,0x9
    80004cf8:	94478793          	addi	a5,a5,-1724 # 8000d638 <_ZN11ConsoleUtil8inputSemE>
    80004cfc:	0207b603          	ld	a2,32(a5)
    80004d00:	00160713          	addi	a4,a2,1
    80004d04:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004d08:	0287b583          	ld	a1,40(a5)
    80004d0c:	00158713          	addi	a4,a1,1
    80004d10:	000026b7          	lui	a3,0x2
    80004d14:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004d18:	00d77733          	and	a4,a4,a3
    80004d1c:	0307b783          	ld	a5,48(a5)
    80004d20:	04f70863          	beq	a4,a5,80004d70 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    80004d24:	ff010113          	addi	sp,sp,-16
    80004d28:	00113423          	sd	ra,8(sp)
    80004d2c:	00813023          	sd	s0,0(sp)
    80004d30:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004d34:	00009797          	auipc	a5,0x9
    80004d38:	93c78793          	addi	a5,a5,-1732 # 8000d670 <_ZN11ConsoleUtil12outputBufferE>
    80004d3c:	00b785b3          	add	a1,a5,a1
    80004d40:	00a58023          	sb	a0,0(a1)

    outputTail = (outputTail+1)%bufferSize;
    80004d44:	00009797          	auipc	a5,0x9
    80004d48:	8f478793          	addi	a5,a5,-1804 # 8000d638 <_ZN11ConsoleUtil8inputSemE>
    80004d4c:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    80004d50:	02c7b023          	sd	a2,32(a5)

    outputSem->signal();
    80004d54:	0087b503          	ld	a0,8(a5)
    80004d58:	ffffe097          	auipc	ra,0xffffe
    80004d5c:	f48080e7          	jalr	-184(ra) # 80002ca0 <_ZN3SCB6signalEv>
}
    80004d60:	00813083          	ld	ra,8(sp)
    80004d64:	00013403          	ld	s0,0(sp)
    80004d68:	01010113          	addi	sp,sp,16
    80004d6c:	00008067          	ret
    80004d70:	00008067          	ret

0000000080004d74 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004d74:	fe010113          	addi	sp,sp,-32
    80004d78:	00113c23          	sd	ra,24(sp)
    80004d7c:	00813823          	sd	s0,16(sp)
    80004d80:	00913423          	sd	s1,8(sp)
    80004d84:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004d88:	00009497          	auipc	s1,0x9
    80004d8c:	8b048493          	addi	s1,s1,-1872 # 8000d638 <_ZN11ConsoleUtil8inputSemE>
    80004d90:	0084b503          	ld	a0,8(s1)
    80004d94:	ffffe097          	auipc	ra,0xffffe
    80004d98:	ebc080e7          	jalr	-324(ra) # 80002c50 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004d9c:	0304b783          	ld	a5,48(s1)
    80004da0:	0284b703          	ld	a4,40(s1)
    80004da4:	04e78063          	beq	a5,a4,80004de4 <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004da8:	00009717          	auipc	a4,0x9
    80004dac:	8c870713          	addi	a4,a4,-1848 # 8000d670 <_ZN11ConsoleUtil12outputBufferE>
    80004db0:	00f70733          	add	a4,a4,a5
    80004db4:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004db8:	00178793          	addi	a5,a5,1
    80004dbc:	00002737          	lui	a4,0x2
    80004dc0:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004dc4:	00e7f7b3          	and	a5,a5,a4
    80004dc8:	00009717          	auipc	a4,0x9
    80004dcc:	8af73023          	sd	a5,-1888(a4) # 8000d668 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004dd0:	01813083          	ld	ra,24(sp)
    80004dd4:	01013403          	ld	s0,16(sp)
    80004dd8:	00813483          	ld	s1,8(sp)
    80004ddc:	02010113          	addi	sp,sp,32
    80004de0:	00008067          	ret
        return -1;
    80004de4:	0ff00513          	li	a0,255
    80004de8:	fe9ff06f          	j	80004dd0 <_ZN11ConsoleUtil9getOutputEv+0x5c>

0000000080004dec <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004dec:	fe010113          	addi	sp,sp,-32
    80004df0:	00113c23          	sd	ra,24(sp)
    80004df4:	00813823          	sd	s0,16(sp)
    80004df8:	00913423          	sd	s1,8(sp)
    80004dfc:	02010413          	addi	s0,sp,32
    80004e00:	00050493          	mv	s1,a0
    while (*string != '\0')
    80004e04:	0004c503          	lbu	a0,0(s1)
    80004e08:	00050a63          	beqz	a0,80004e1c <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004e0c:	00000097          	auipc	ra,0x0
    80004e10:	ee8080e7          	jalr	-280(ra) # 80004cf4 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80004e14:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004e18:	fedff06f          	j	80004e04 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004e1c:	01813083          	ld	ra,24(sp)
    80004e20:	01013403          	ld	s0,16(sp)
    80004e24:	00813483          	ld	s1,8(sp)
    80004e28:	02010113          	addi	sp,sp,32
    80004e2c:	00008067          	ret

0000000080004e30 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004e30:	fb010113          	addi	sp,sp,-80
    80004e34:	04113423          	sd	ra,72(sp)
    80004e38:	04813023          	sd	s0,64(sp)
    80004e3c:	02913c23          	sd	s1,56(sp)
    80004e40:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004e44:	00005797          	auipc	a5,0x5
    80004e48:	6fc78793          	addi	a5,a5,1788 # 8000a540 <CONSOLE_STATUS+0x530>
    80004e4c:	0007b703          	ld	a4,0(a5)
    80004e50:	fce43423          	sd	a4,-56(s0)
    80004e54:	0087b703          	ld	a4,8(a5)
    80004e58:	fce43823          	sd	a4,-48(s0)
    80004e5c:	0107c783          	lbu	a5,16(a5)
    80004e60:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004e64:	00060463          	beqz	a2,80004e6c <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004e68:	08054263          	bltz	a0,80004eec <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004e6c:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004e70:	00000813          	li	a6,0
    }

    i = 0;
    80004e74:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004e78:	0005871b          	sext.w	a4,a1
    80004e7c:	02b577bb          	remuw	a5,a0,a1
    80004e80:	00048693          	mv	a3,s1
    80004e84:	0014849b          	addiw	s1,s1,1
    80004e88:	02079793          	slli	a5,a5,0x20
    80004e8c:	0207d793          	srli	a5,a5,0x20
    80004e90:	fe040613          	addi	a2,s0,-32
    80004e94:	00f607b3          	add	a5,a2,a5
    80004e98:	fe87c603          	lbu	a2,-24(a5)
    80004e9c:	fe040793          	addi	a5,s0,-32
    80004ea0:	00d787b3          	add	a5,a5,a3
    80004ea4:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004ea8:	0005061b          	sext.w	a2,a0
    80004eac:	02b5553b          	divuw	a0,a0,a1
    80004eb0:	fce674e3          	bgeu	a2,a4,80004e78 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004eb4:	00080c63          	beqz	a6,80004ecc <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004eb8:	fe040793          	addi	a5,s0,-32
    80004ebc:	009784b3          	add	s1,a5,s1
    80004ec0:	02d00793          	li	a5,45
    80004ec4:	fcf48c23          	sb	a5,-40(s1)
    80004ec8:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004ecc:	fff4849b          	addiw	s1,s1,-1
    80004ed0:	0204c463          	bltz	s1,80004ef8 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004ed4:	fe040793          	addi	a5,s0,-32
    80004ed8:	009787b3          	add	a5,a5,s1
    80004edc:	fd87c503          	lbu	a0,-40(a5)
    80004ee0:	00000097          	auipc	ra,0x0
    80004ee4:	e14080e7          	jalr	-492(ra) # 80004cf4 <_ZN11ConsoleUtil9putOutputEc>
    80004ee8:	fe5ff06f          	j	80004ecc <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004eec:	40a0053b          	negw	a0,a0
        neg = 1;
    80004ef0:	00100813          	li	a6,1
        x = -xx;
    80004ef4:	f81ff06f          	j	80004e74 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004ef8:	04813083          	ld	ra,72(sp)
    80004efc:	04013403          	ld	s0,64(sp)
    80004f00:	03813483          	ld	s1,56(sp)
    80004f04:	05010113          	addi	sp,sp,80
    80004f08:	00008067          	ret

0000000080004f0c <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    80004f0c:	fe010113          	addi	sp,sp,-32
    80004f10:	00113c23          	sd	ra,24(sp)
    80004f14:	00813823          	sd	s0,16(sp)
    80004f18:	00913423          	sd	s1,8(sp)
    80004f1c:	01213023          	sd	s2,0(sp)
    80004f20:	02010413          	addi	s0,sp,32
    80004f24:	00058913          	mv	s2,a1
    80004f28:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    80004f2c:	00000097          	auipc	ra,0x0
    80004f30:	ec0080e7          	jalr	-320(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    80004f34:	00000613          	li	a2,0
    80004f38:	00a00593          	li	a1,10
    80004f3c:	00090513          	mv	a0,s2
    80004f40:	00000097          	auipc	ra,0x0
    80004f44:	ef0080e7          	jalr	-272(ra) # 80004e30 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004f48:	00048513          	mv	a0,s1
    80004f4c:	00000097          	auipc	ra,0x0
    80004f50:	ea0080e7          	jalr	-352(ra) # 80004dec <_ZN11ConsoleUtil11printStringEPKc>
}
    80004f54:	01813083          	ld	ra,24(sp)
    80004f58:	01013403          	ld	s0,16(sp)
    80004f5c:	00813483          	ld	s1,8(sp)
    80004f60:	00013903          	ld	s2,0(sp)
    80004f64:	02010113          	addi	sp,sp,32
    80004f68:	00008067          	ret

0000000080004f6c <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004f6c:	ff010113          	addi	sp,sp,-16
    80004f70:	00813423          	sd	s0,8(sp)
    80004f74:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004f78:	04300513          	li	a0,67

    asm("ecall");
    80004f7c:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004f80:	00050513          	mv	a0,a0

    return (char)status;
}
    80004f84:	0ff57513          	andi	a0,a0,255
    80004f88:	00813403          	ld	s0,8(sp)
    80004f8c:	01010113          	addi	sp,sp,16
    80004f90:	00008067          	ret

0000000080004f94 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004f94:	ff010113          	addi	sp,sp,-16
    80004f98:	00113423          	sd	ra,8(sp)
    80004f9c:	00813023          	sd	s0,0(sp)
    80004fa0:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004fa4:	ffffd097          	auipc	ra,0xffffd
    80004fa8:	9cc080e7          	jalr	-1588(ra) # 80001970 <_ZN13SlabAllocator10initializeEPvm>
}
    80004fac:	00813083          	ld	ra,8(sp)
    80004fb0:	00013403          	ld	s0,0(sp)
    80004fb4:	01010113          	addi	sp,sp,16
    80004fb8:	00008067          	ret

0000000080004fbc <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80004fbc:	ff010113          	addi	sp,sp,-16
    80004fc0:	00113423          	sd	ra,8(sp)
    80004fc4:	00813023          	sd	s0,0(sp)
    80004fc8:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80004fcc:	ffffd097          	auipc	ra,0xffffd
    80004fd0:	904080e7          	jalr	-1788(ra) # 800018d0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004fd4:	00813083          	ld	ra,8(sp)
    80004fd8:	00013403          	ld	s0,0(sp)
    80004fdc:	01010113          	addi	sp,sp,16
    80004fe0:	00008067          	ret

0000000080004fe4 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80004fe4:	ff010113          	addi	sp,sp,-16
    80004fe8:	00113423          	sd	ra,8(sp)
    80004fec:	00813023          	sd	s0,0(sp)
    80004ff0:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80004ff4:	ffffc097          	auipc	ra,0xffffc
    80004ff8:	79c080e7          	jalr	1948(ra) # 80001790 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004ffc:	00813083          	ld	ra,8(sp)
    80005000:	00013403          	ld	s0,0(sp)
    80005004:	01010113          	addi	sp,sp,16
    80005008:	00008067          	ret

000000008000500c <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    8000500c:	ff010113          	addi	sp,sp,-16
    80005010:	00113423          	sd	ra,8(sp)
    80005014:	00813023          	sd	s0,0(sp)
    80005018:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    8000501c:	ffffd097          	auipc	ra,0xffffd
    80005020:	b30080e7          	jalr	-1232(ra) # 80001b4c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80005024:	00813083          	ld	ra,8(sp)
    80005028:	00013403          	ld	s0,0(sp)
    8000502c:	01010113          	addi	sp,sp,16
    80005030:	00008067          	ret

0000000080005034 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    80005034:	fe010113          	addi	sp,sp,-32
    80005038:	00113c23          	sd	ra,24(sp)
    8000503c:	00813823          	sd	s0,16(sp)
    80005040:	02010413          	addi	s0,sp,32
    80005044:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80005048:	fe840513          	addi	a0,s0,-24
    8000504c:	ffffd097          	auipc	ra,0xffffd
    80005050:	c50080e7          	jalr	-944(ra) # 80001c9c <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    80005054:	01813083          	ld	ra,24(sp)
    80005058:	01013403          	ld	s0,16(sp)
    8000505c:	02010113          	addi	sp,sp,32
    80005060:	00008067          	ret

0000000080005064 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80005064:	ff010113          	addi	sp,sp,-16
    80005068:	00113423          	sd	ra,8(sp)
    8000506c:	00813023          	sd	s0,0(sp)
    80005070:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80005074:	ffffc097          	auipc	ra,0xffffc
    80005078:	298080e7          	jalr	664(ra) # 8000130c <_ZN13SlabAllocator10printCacheEP5Cache>
}
    8000507c:	00813083          	ld	ra,8(sp)
    80005080:	00013403          	ld	s0,0(sp)
    80005084:	01010113          	addi	sp,sp,16
    80005088:	00008067          	ret

000000008000508c <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    8000508c:	ff010113          	addi	sp,sp,-16
    80005090:	00113423          	sd	ra,8(sp)
    80005094:	00813023          	sd	s0,0(sp)
    80005098:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    8000509c:	ffffc097          	auipc	ra,0xffffc
    800050a0:	0b8080e7          	jalr	184(ra) # 80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    800050a4:	00813083          	ld	ra,8(sp)
    800050a8:	00013403          	ld	s0,0(sp)
    800050ac:	01010113          	addi	sp,sp,16
    800050b0:	00008067          	ret

00000000800050b4 <_Z7kmallocm>:
void* kmalloc(size_t size){
    800050b4:	ff010113          	addi	sp,sp,-16
    800050b8:	00113423          	sd	ra,8(sp)
    800050bc:	00813023          	sd	s0,0(sp)
    800050c0:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    800050c4:	ffffc097          	auipc	ra,0xffffc
    800050c8:	768080e7          	jalr	1896(ra) # 8000182c <_ZN13SlabAllocator14allocateBufferEm>
}
    800050cc:	00813083          	ld	ra,8(sp)
    800050d0:	00013403          	ld	s0,0(sp)
    800050d4:	01010113          	addi	sp,sp,16
    800050d8:	00008067          	ret

00000000800050dc <_Z5kfreePKv>:

void kfree(const void* objp){
    800050dc:	ff010113          	addi	sp,sp,-16
    800050e0:	00113423          	sd	ra,8(sp)
    800050e4:	00813023          	sd	s0,0(sp)
    800050e8:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    800050ec:	ffffd097          	auipc	ra,0xffffd
    800050f0:	b44080e7          	jalr	-1212(ra) # 80001c30 <_ZN13SlabAllocator10freeBufferEPKv>
    800050f4:	00813083          	ld	ra,8(sp)
    800050f8:	00013403          	ld	s0,0(sp)
    800050fc:	01010113          	addi	sp,sp,16
    80005100:	00008067          	ret

0000000080005104 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005104:	fd010113          	addi	sp,sp,-48
    80005108:	02113423          	sd	ra,40(sp)
    8000510c:	02813023          	sd	s0,32(sp)
    80005110:	00913c23          	sd	s1,24(sp)
    80005114:	01213823          	sd	s2,16(sp)
    80005118:	01313423          	sd	s3,8(sp)
    8000511c:	03010413          	addi	s0,sp,48
    80005120:	00050493          	mv	s1,a0
    80005124:	00058913          	mv	s2,a1
    80005128:	0015879b          	addiw	a5,a1,1
    8000512c:	0007851b          	sext.w	a0,a5
    80005130:	00f4a023          	sw	a5,0(s1)
    80005134:	0004a823          	sw	zero,16(s1)
    80005138:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000513c:	00251513          	slli	a0,a0,0x2
    80005140:	ffffd097          	auipc	ra,0xffffd
    80005144:	c50080e7          	jalr	-944(ra) # 80001d90 <_Z9mem_allocm>
    80005148:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    8000514c:	01000513          	li	a0,16
    80005150:	ffffe097          	auipc	ra,0xffffe
    80005154:	450080e7          	jalr	1104(ra) # 800035a0 <_Znwm>
    80005158:	00050993          	mv	s3,a0
    8000515c:	00000593          	li	a1,0
    80005160:	ffffe097          	auipc	ra,0xffffe
    80005164:	538080e7          	jalr	1336(ra) # 80003698 <_ZN9SemaphoreC1Ej>
    80005168:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000516c:	01000513          	li	a0,16
    80005170:	ffffe097          	auipc	ra,0xffffe
    80005174:	430080e7          	jalr	1072(ra) # 800035a0 <_Znwm>
    80005178:	00050993          	mv	s3,a0
    8000517c:	00090593          	mv	a1,s2
    80005180:	ffffe097          	auipc	ra,0xffffe
    80005184:	518080e7          	jalr	1304(ra) # 80003698 <_ZN9SemaphoreC1Ej>
    80005188:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    8000518c:	01000513          	li	a0,16
    80005190:	ffffe097          	auipc	ra,0xffffe
    80005194:	410080e7          	jalr	1040(ra) # 800035a0 <_Znwm>
    80005198:	00050913          	mv	s2,a0
    8000519c:	00100593          	li	a1,1
    800051a0:	ffffe097          	auipc	ra,0xffffe
    800051a4:	4f8080e7          	jalr	1272(ra) # 80003698 <_ZN9SemaphoreC1Ej>
    800051a8:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800051ac:	01000513          	li	a0,16
    800051b0:	ffffe097          	auipc	ra,0xffffe
    800051b4:	3f0080e7          	jalr	1008(ra) # 800035a0 <_Znwm>
    800051b8:	00050913          	mv	s2,a0
    800051bc:	00100593          	li	a1,1
    800051c0:	ffffe097          	auipc	ra,0xffffe
    800051c4:	4d8080e7          	jalr	1240(ra) # 80003698 <_ZN9SemaphoreC1Ej>
    800051c8:	0324b823          	sd	s2,48(s1)
}
    800051cc:	02813083          	ld	ra,40(sp)
    800051d0:	02013403          	ld	s0,32(sp)
    800051d4:	01813483          	ld	s1,24(sp)
    800051d8:	01013903          	ld	s2,16(sp)
    800051dc:	00813983          	ld	s3,8(sp)
    800051e0:	03010113          	addi	sp,sp,48
    800051e4:	00008067          	ret
    800051e8:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800051ec:	00098513          	mv	a0,s3
    800051f0:	ffffe097          	auipc	ra,0xffffe
    800051f4:	400080e7          	jalr	1024(ra) # 800035f0 <_ZdlPv>
    800051f8:	00048513          	mv	a0,s1
    800051fc:	0000d097          	auipc	ra,0xd
    80005200:	56c080e7          	jalr	1388(ra) # 80012768 <_Unwind_Resume>
    80005204:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80005208:	00098513          	mv	a0,s3
    8000520c:	ffffe097          	auipc	ra,0xffffe
    80005210:	3e4080e7          	jalr	996(ra) # 800035f0 <_ZdlPv>
    80005214:	00048513          	mv	a0,s1
    80005218:	0000d097          	auipc	ra,0xd
    8000521c:	550080e7          	jalr	1360(ra) # 80012768 <_Unwind_Resume>
    80005220:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80005224:	00090513          	mv	a0,s2
    80005228:	ffffe097          	auipc	ra,0xffffe
    8000522c:	3c8080e7          	jalr	968(ra) # 800035f0 <_ZdlPv>
    80005230:	00048513          	mv	a0,s1
    80005234:	0000d097          	auipc	ra,0xd
    80005238:	534080e7          	jalr	1332(ra) # 80012768 <_Unwind_Resume>
    8000523c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80005240:	00090513          	mv	a0,s2
    80005244:	ffffe097          	auipc	ra,0xffffe
    80005248:	3ac080e7          	jalr	940(ra) # 800035f0 <_ZdlPv>
    8000524c:	00048513          	mv	a0,s1
    80005250:	0000d097          	auipc	ra,0xd
    80005254:	518080e7          	jalr	1304(ra) # 80012768 <_Unwind_Resume>

0000000080005258 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80005258:	fe010113          	addi	sp,sp,-32
    8000525c:	00113c23          	sd	ra,24(sp)
    80005260:	00813823          	sd	s0,16(sp)
    80005264:	00913423          	sd	s1,8(sp)
    80005268:	01213023          	sd	s2,0(sp)
    8000526c:	02010413          	addi	s0,sp,32
    80005270:	00050493          	mv	s1,a0
    80005274:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80005278:	01853503          	ld	a0,24(a0)
    8000527c:	ffffe097          	auipc	ra,0xffffe
    80005280:	454080e7          	jalr	1108(ra) # 800036d0 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80005284:	0304b503          	ld	a0,48(s1)
    80005288:	ffffe097          	auipc	ra,0xffffe
    8000528c:	448080e7          	jalr	1096(ra) # 800036d0 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80005290:	0084b783          	ld	a5,8(s1)
    80005294:	0144a703          	lw	a4,20(s1)
    80005298:	00271713          	slli	a4,a4,0x2
    8000529c:	00e787b3          	add	a5,a5,a4
    800052a0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800052a4:	0144a783          	lw	a5,20(s1)
    800052a8:	0017879b          	addiw	a5,a5,1
    800052ac:	0004a703          	lw	a4,0(s1)
    800052b0:	02e7e7bb          	remw	a5,a5,a4
    800052b4:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800052b8:	0304b503          	ld	a0,48(s1)
    800052bc:	ffffe097          	auipc	ra,0xffffe
    800052c0:	440080e7          	jalr	1088(ra) # 800036fc <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800052c4:	0204b503          	ld	a0,32(s1)
    800052c8:	ffffe097          	auipc	ra,0xffffe
    800052cc:	434080e7          	jalr	1076(ra) # 800036fc <_ZN9Semaphore6signalEv>

}
    800052d0:	01813083          	ld	ra,24(sp)
    800052d4:	01013403          	ld	s0,16(sp)
    800052d8:	00813483          	ld	s1,8(sp)
    800052dc:	00013903          	ld	s2,0(sp)
    800052e0:	02010113          	addi	sp,sp,32
    800052e4:	00008067          	ret

00000000800052e8 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800052e8:	fe010113          	addi	sp,sp,-32
    800052ec:	00113c23          	sd	ra,24(sp)
    800052f0:	00813823          	sd	s0,16(sp)
    800052f4:	00913423          	sd	s1,8(sp)
    800052f8:	01213023          	sd	s2,0(sp)
    800052fc:	02010413          	addi	s0,sp,32
    80005300:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80005304:	02053503          	ld	a0,32(a0)
    80005308:	ffffe097          	auipc	ra,0xffffe
    8000530c:	3c8080e7          	jalr	968(ra) # 800036d0 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005310:	0284b503          	ld	a0,40(s1)
    80005314:	ffffe097          	auipc	ra,0xffffe
    80005318:	3bc080e7          	jalr	956(ra) # 800036d0 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000531c:	0084b703          	ld	a4,8(s1)
    80005320:	0104a783          	lw	a5,16(s1)
    80005324:	00279693          	slli	a3,a5,0x2
    80005328:	00d70733          	add	a4,a4,a3
    8000532c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005330:	0017879b          	addiw	a5,a5,1
    80005334:	0004a703          	lw	a4,0(s1)
    80005338:	02e7e7bb          	remw	a5,a5,a4
    8000533c:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005340:	0284b503          	ld	a0,40(s1)
    80005344:	ffffe097          	auipc	ra,0xffffe
    80005348:	3b8080e7          	jalr	952(ra) # 800036fc <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000534c:	0184b503          	ld	a0,24(s1)
    80005350:	ffffe097          	auipc	ra,0xffffe
    80005354:	3ac080e7          	jalr	940(ra) # 800036fc <_ZN9Semaphore6signalEv>

    return ret;
}
    80005358:	00090513          	mv	a0,s2
    8000535c:	01813083          	ld	ra,24(sp)
    80005360:	01013403          	ld	s0,16(sp)
    80005364:	00813483          	ld	s1,8(sp)
    80005368:	00013903          	ld	s2,0(sp)
    8000536c:	02010113          	addi	sp,sp,32
    80005370:	00008067          	ret

0000000080005374 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80005374:	fe010113          	addi	sp,sp,-32
    80005378:	00113c23          	sd	ra,24(sp)
    8000537c:	00813823          	sd	s0,16(sp)
    80005380:	00913423          	sd	s1,8(sp)
    80005384:	01213023          	sd	s2,0(sp)
    80005388:	02010413          	addi	s0,sp,32
    8000538c:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80005390:	02853503          	ld	a0,40(a0)
    80005394:	ffffe097          	auipc	ra,0xffffe
    80005398:	33c080e7          	jalr	828(ra) # 800036d0 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000539c:	0304b503          	ld	a0,48(s1)
    800053a0:	ffffe097          	auipc	ra,0xffffe
    800053a4:	330080e7          	jalr	816(ra) # 800036d0 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800053a8:	0144a783          	lw	a5,20(s1)
    800053ac:	0104a903          	lw	s2,16(s1)
    800053b0:	0327ce63          	blt	a5,s2,800053ec <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800053b4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800053b8:	0304b503          	ld	a0,48(s1)
    800053bc:	ffffe097          	auipc	ra,0xffffe
    800053c0:	340080e7          	jalr	832(ra) # 800036fc <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800053c4:	0284b503          	ld	a0,40(s1)
    800053c8:	ffffe097          	auipc	ra,0xffffe
    800053cc:	334080e7          	jalr	820(ra) # 800036fc <_ZN9Semaphore6signalEv>

    return ret;
}
    800053d0:	00090513          	mv	a0,s2
    800053d4:	01813083          	ld	ra,24(sp)
    800053d8:	01013403          	ld	s0,16(sp)
    800053dc:	00813483          	ld	s1,8(sp)
    800053e0:	00013903          	ld	s2,0(sp)
    800053e4:	02010113          	addi	sp,sp,32
    800053e8:	00008067          	ret
        ret = cap - head + tail;
    800053ec:	0004a703          	lw	a4,0(s1)
    800053f0:	4127093b          	subw	s2,a4,s2
    800053f4:	00f9093b          	addw	s2,s2,a5
    800053f8:	fc1ff06f          	j	800053b8 <_ZN9BufferCPP6getCntEv+0x44>

00000000800053fc <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800053fc:	fe010113          	addi	sp,sp,-32
    80005400:	00113c23          	sd	ra,24(sp)
    80005404:	00813823          	sd	s0,16(sp)
    80005408:	00913423          	sd	s1,8(sp)
    8000540c:	02010413          	addi	s0,sp,32
    80005410:	00050493          	mv	s1,a0
    Console::putc('\n');
    80005414:	00a00513          	li	a0,10
    80005418:	ffffe097          	auipc	ra,0xffffe
    8000541c:	4e0080e7          	jalr	1248(ra) # 800038f8 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80005420:	00005517          	auipc	a0,0x5
    80005424:	13850513          	addi	a0,a0,312 # 8000a558 <CONSOLE_STATUS+0x548>
    80005428:	ffffd097          	auipc	ra,0xffffd
    8000542c:	44c080e7          	jalr	1100(ra) # 80002874 <_Z11printStringPKc>
    while (getCnt()) {
    80005430:	00048513          	mv	a0,s1
    80005434:	00000097          	auipc	ra,0x0
    80005438:	f40080e7          	jalr	-192(ra) # 80005374 <_ZN9BufferCPP6getCntEv>
    8000543c:	02050c63          	beqz	a0,80005474 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005440:	0084b783          	ld	a5,8(s1)
    80005444:	0104a703          	lw	a4,16(s1)
    80005448:	00271713          	slli	a4,a4,0x2
    8000544c:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80005450:	0007c503          	lbu	a0,0(a5)
    80005454:	ffffe097          	auipc	ra,0xffffe
    80005458:	4a4080e7          	jalr	1188(ra) # 800038f8 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000545c:	0104a783          	lw	a5,16(s1)
    80005460:	0017879b          	addiw	a5,a5,1
    80005464:	0004a703          	lw	a4,0(s1)
    80005468:	02e7e7bb          	remw	a5,a5,a4
    8000546c:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80005470:	fc1ff06f          	j	80005430 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80005474:	02100513          	li	a0,33
    80005478:	ffffe097          	auipc	ra,0xffffe
    8000547c:	480080e7          	jalr	1152(ra) # 800038f8 <_ZN7Console4putcEc>
    Console::putc('\n');
    80005480:	00a00513          	li	a0,10
    80005484:	ffffe097          	auipc	ra,0xffffe
    80005488:	474080e7          	jalr	1140(ra) # 800038f8 <_ZN7Console4putcEc>
    mem_free(buffer);
    8000548c:	0084b503          	ld	a0,8(s1)
    80005490:	ffffd097          	auipc	ra,0xffffd
    80005494:	930080e7          	jalr	-1744(ra) # 80001dc0 <_Z8mem_freePv>
    delete itemAvailable;
    80005498:	0204b503          	ld	a0,32(s1)
    8000549c:	00050863          	beqz	a0,800054ac <_ZN9BufferCPPD1Ev+0xb0>
    800054a0:	00053783          	ld	a5,0(a0)
    800054a4:	0087b783          	ld	a5,8(a5)
    800054a8:	000780e7          	jalr	a5
    delete spaceAvailable;
    800054ac:	0184b503          	ld	a0,24(s1)
    800054b0:	00050863          	beqz	a0,800054c0 <_ZN9BufferCPPD1Ev+0xc4>
    800054b4:	00053783          	ld	a5,0(a0)
    800054b8:	0087b783          	ld	a5,8(a5)
    800054bc:	000780e7          	jalr	a5
    delete mutexTail;
    800054c0:	0304b503          	ld	a0,48(s1)
    800054c4:	00050863          	beqz	a0,800054d4 <_ZN9BufferCPPD1Ev+0xd8>
    800054c8:	00053783          	ld	a5,0(a0)
    800054cc:	0087b783          	ld	a5,8(a5)
    800054d0:	000780e7          	jalr	a5
    delete mutexHead;
    800054d4:	0284b503          	ld	a0,40(s1)
    800054d8:	00050863          	beqz	a0,800054e8 <_ZN9BufferCPPD1Ev+0xec>
    800054dc:	00053783          	ld	a5,0(a0)
    800054e0:	0087b783          	ld	a5,8(a5)
    800054e4:	000780e7          	jalr	a5
}
    800054e8:	01813083          	ld	ra,24(sp)
    800054ec:	01013403          	ld	s0,16(sp)
    800054f0:	00813483          	ld	s1,8(sp)
    800054f4:	02010113          	addi	sp,sp,32
    800054f8:	00008067          	ret

00000000800054fc <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    800054fc:	fe010113          	addi	sp,sp,-32
    80005500:	00113c23          	sd	ra,24(sp)
    80005504:	00813823          	sd	s0,16(sp)
    80005508:	00913423          	sd	s1,8(sp)
    8000550c:	01213023          	sd	s2,0(sp)
    80005510:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80005514:	00053903          	ld	s2,0(a0)
    int i = 6;
    80005518:	00600493          	li	s1,6
    while (--i > 0) {
    8000551c:	fff4849b          	addiw	s1,s1,-1
    80005520:	04905463          	blez	s1,80005568 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80005524:	00005517          	auipc	a0,0x5
    80005528:	04c50513          	addi	a0,a0,76 # 8000a570 <CONSOLE_STATUS+0x560>
    8000552c:	ffffd097          	auipc	ra,0xffffd
    80005530:	348080e7          	jalr	840(ra) # 80002874 <_Z11printStringPKc>
        printInt(sleep_time);
    80005534:	00000613          	li	a2,0
    80005538:	00a00593          	li	a1,10
    8000553c:	0009051b          	sext.w	a0,s2
    80005540:	ffffd097          	auipc	ra,0xffffd
    80005544:	4cc080e7          	jalr	1228(ra) # 80002a0c <_Z8printIntiii>
        printString(" !\n");
    80005548:	00005517          	auipc	a0,0x5
    8000554c:	03050513          	addi	a0,a0,48 # 8000a578 <CONSOLE_STATUS+0x568>
    80005550:	ffffd097          	auipc	ra,0xffffd
    80005554:	324080e7          	jalr	804(ra) # 80002874 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80005558:	00090513          	mv	a0,s2
    8000555c:	ffffd097          	auipc	ra,0xffffd
    80005560:	ab8080e7          	jalr	-1352(ra) # 80002014 <_Z10time_sleepm>
    while (--i > 0) {
    80005564:	fb9ff06f          	j	8000551c <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80005568:	00a00793          	li	a5,10
    8000556c:	02f95933          	divu	s2,s2,a5
    80005570:	fff90913          	addi	s2,s2,-1
    80005574:	0000c797          	auipc	a5,0xc
    80005578:	10478793          	addi	a5,a5,260 # 80011678 <_ZN19ConsumerProducerCPP9threadEndE>
    8000557c:	01278933          	add	s2,a5,s2
    80005580:	00100793          	li	a5,1
    80005584:	00f90423          	sb	a5,8(s2)
}
    80005588:	01813083          	ld	ra,24(sp)
    8000558c:	01013403          	ld	s0,16(sp)
    80005590:	00813483          	ld	s1,8(sp)
    80005594:	00013903          	ld	s2,0(sp)
    80005598:	02010113          	addi	sp,sp,32
    8000559c:	00008067          	ret

00000000800055a0 <_Z9fibonaccim>:
bool finishedA = false;
bool finishedB = false;
bool finishedC = false;
bool finishedD = false;

uint64 fibonacci(uint64 n) {
    800055a0:	fe010113          	addi	sp,sp,-32
    800055a4:	00113c23          	sd	ra,24(sp)
    800055a8:	00813823          	sd	s0,16(sp)
    800055ac:	00913423          	sd	s1,8(sp)
    800055b0:	01213023          	sd	s2,0(sp)
    800055b4:	02010413          	addi	s0,sp,32
    800055b8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800055bc:	00100793          	li	a5,1
    800055c0:	02a7f863          	bgeu	a5,a0,800055f0 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800055c4:	00a00793          	li	a5,10
    800055c8:	02f577b3          	remu	a5,a0,a5
    800055cc:	02078e63          	beqz	a5,80005608 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800055d0:	fff48513          	addi	a0,s1,-1
    800055d4:	00000097          	auipc	ra,0x0
    800055d8:	fcc080e7          	jalr	-52(ra) # 800055a0 <_Z9fibonaccim>
    800055dc:	00050913          	mv	s2,a0
    800055e0:	ffe48513          	addi	a0,s1,-2
    800055e4:	00000097          	auipc	ra,0x0
    800055e8:	fbc080e7          	jalr	-68(ra) # 800055a0 <_Z9fibonaccim>
    800055ec:	00a90533          	add	a0,s2,a0
}
    800055f0:	01813083          	ld	ra,24(sp)
    800055f4:	01013403          	ld	s0,16(sp)
    800055f8:	00813483          	ld	s1,8(sp)
    800055fc:	00013903          	ld	s2,0(sp)
    80005600:	02010113          	addi	sp,sp,32
    80005604:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005608:	ffffd097          	auipc	ra,0xffffd
    8000560c:	888080e7          	jalr	-1912(ra) # 80001e90 <_Z15thread_dispatchv>
    80005610:	fc1ff06f          	j	800055d0 <_Z9fibonaccim+0x30>

0000000080005614 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80005614:	fe010113          	addi	sp,sp,-32
    80005618:	00113c23          	sd	ra,24(sp)
    8000561c:	00813823          	sd	s0,16(sp)
    80005620:	00913423          	sd	s1,8(sp)
    80005624:	01213023          	sd	s2,0(sp)
    80005628:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000562c:	00000913          	li	s2,0
    80005630:	0380006f          	j	80005668 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005634:	ffffd097          	auipc	ra,0xffffd
    80005638:	85c080e7          	jalr	-1956(ra) # 80001e90 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000563c:	00148493          	addi	s1,s1,1
    80005640:	000027b7          	lui	a5,0x2
    80005644:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005648:	0097ee63          	bltu	a5,s1,80005664 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000564c:	00000713          	li	a4,0
    80005650:	000077b7          	lui	a5,0x7
    80005654:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005658:	fce7eee3          	bltu	a5,a4,80005634 <_ZN7WorkerA11workerBodyAEPv+0x20>
    8000565c:	00170713          	addi	a4,a4,1
    80005660:	ff1ff06f          	j	80005650 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005664:	00190913          	addi	s2,s2,1
    80005668:	00900793          	li	a5,9
    8000566c:	0527e063          	bltu	a5,s2,800056ac <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005670:	00005517          	auipc	a0,0x5
    80005674:	f1050513          	addi	a0,a0,-240 # 8000a580 <CONSOLE_STATUS+0x570>
    80005678:	ffffd097          	auipc	ra,0xffffd
    8000567c:	1fc080e7          	jalr	508(ra) # 80002874 <_Z11printStringPKc>
    80005680:	00000613          	li	a2,0
    80005684:	00a00593          	li	a1,10
    80005688:	0009051b          	sext.w	a0,s2
    8000568c:	ffffd097          	auipc	ra,0xffffd
    80005690:	380080e7          	jalr	896(ra) # 80002a0c <_Z8printIntiii>
    80005694:	00005517          	auipc	a0,0x5
    80005698:	cb450513          	addi	a0,a0,-844 # 8000a348 <CONSOLE_STATUS+0x338>
    8000569c:	ffffd097          	auipc	ra,0xffffd
    800056a0:	1d8080e7          	jalr	472(ra) # 80002874 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800056a4:	00000493          	li	s1,0
    800056a8:	f99ff06f          	j	80005640 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    800056ac:	00005517          	auipc	a0,0x5
    800056b0:	edc50513          	addi	a0,a0,-292 # 8000a588 <CONSOLE_STATUS+0x578>
    800056b4:	ffffd097          	auipc	ra,0xffffd
    800056b8:	1c0080e7          	jalr	448(ra) # 80002874 <_Z11printStringPKc>
    finishedA = true;
    800056bc:	00100793          	li	a5,1
    800056c0:	0000c717          	auipc	a4,0xc
    800056c4:	fcf70123          	sb	a5,-62(a4) # 80011682 <finishedA>
}
    800056c8:	01813083          	ld	ra,24(sp)
    800056cc:	01013403          	ld	s0,16(sp)
    800056d0:	00813483          	ld	s1,8(sp)
    800056d4:	00013903          	ld	s2,0(sp)
    800056d8:	02010113          	addi	sp,sp,32
    800056dc:	00008067          	ret

00000000800056e0 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    800056e0:	fe010113          	addi	sp,sp,-32
    800056e4:	00113c23          	sd	ra,24(sp)
    800056e8:	00813823          	sd	s0,16(sp)
    800056ec:	00913423          	sd	s1,8(sp)
    800056f0:	01213023          	sd	s2,0(sp)
    800056f4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800056f8:	00000913          	li	s2,0
    800056fc:	0380006f          	j	80005734 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005700:	ffffc097          	auipc	ra,0xffffc
    80005704:	790080e7          	jalr	1936(ra) # 80001e90 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005708:	00148493          	addi	s1,s1,1
    8000570c:	000027b7          	lui	a5,0x2
    80005710:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005714:	0097ee63          	bltu	a5,s1,80005730 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005718:	00000713          	li	a4,0
    8000571c:	000077b7          	lui	a5,0x7
    80005720:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005724:	fce7eee3          	bltu	a5,a4,80005700 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80005728:	00170713          	addi	a4,a4,1
    8000572c:	ff1ff06f          	j	8000571c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005730:	00190913          	addi	s2,s2,1
    80005734:	00f00793          	li	a5,15
    80005738:	0527e063          	bltu	a5,s2,80005778 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000573c:	00005517          	auipc	a0,0x5
    80005740:	e5c50513          	addi	a0,a0,-420 # 8000a598 <CONSOLE_STATUS+0x588>
    80005744:	ffffd097          	auipc	ra,0xffffd
    80005748:	130080e7          	jalr	304(ra) # 80002874 <_Z11printStringPKc>
    8000574c:	00000613          	li	a2,0
    80005750:	00a00593          	li	a1,10
    80005754:	0009051b          	sext.w	a0,s2
    80005758:	ffffd097          	auipc	ra,0xffffd
    8000575c:	2b4080e7          	jalr	692(ra) # 80002a0c <_Z8printIntiii>
    80005760:	00005517          	auipc	a0,0x5
    80005764:	be850513          	addi	a0,a0,-1048 # 8000a348 <CONSOLE_STATUS+0x338>
    80005768:	ffffd097          	auipc	ra,0xffffd
    8000576c:	10c080e7          	jalr	268(ra) # 80002874 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005770:	00000493          	li	s1,0
    80005774:	f99ff06f          	j	8000570c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80005778:	00005517          	auipc	a0,0x5
    8000577c:	e2850513          	addi	a0,a0,-472 # 8000a5a0 <CONSOLE_STATUS+0x590>
    80005780:	ffffd097          	auipc	ra,0xffffd
    80005784:	0f4080e7          	jalr	244(ra) # 80002874 <_Z11printStringPKc>
    finishedB = true;
    80005788:	00100793          	li	a5,1
    8000578c:	0000c717          	auipc	a4,0xc
    80005790:	eef70ba3          	sb	a5,-265(a4) # 80011683 <finishedB>
    thread_dispatch();
    80005794:	ffffc097          	auipc	ra,0xffffc
    80005798:	6fc080e7          	jalr	1788(ra) # 80001e90 <_Z15thread_dispatchv>
}
    8000579c:	01813083          	ld	ra,24(sp)
    800057a0:	01013403          	ld	s0,16(sp)
    800057a4:	00813483          	ld	s1,8(sp)
    800057a8:	00013903          	ld	s2,0(sp)
    800057ac:	02010113          	addi	sp,sp,32
    800057b0:	00008067          	ret

00000000800057b4 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    800057b4:	fe010113          	addi	sp,sp,-32
    800057b8:	00113c23          	sd	ra,24(sp)
    800057bc:	00813823          	sd	s0,16(sp)
    800057c0:	00913423          	sd	s1,8(sp)
    800057c4:	01213023          	sd	s2,0(sp)
    800057c8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800057cc:	00000493          	li	s1,0
    800057d0:	0400006f          	j	80005810 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800057d4:	00005517          	auipc	a0,0x5
    800057d8:	ddc50513          	addi	a0,a0,-548 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    800057dc:	ffffd097          	auipc	ra,0xffffd
    800057e0:	098080e7          	jalr	152(ra) # 80002874 <_Z11printStringPKc>
    800057e4:	00000613          	li	a2,0
    800057e8:	00a00593          	li	a1,10
    800057ec:	00048513          	mv	a0,s1
    800057f0:	ffffd097          	auipc	ra,0xffffd
    800057f4:	21c080e7          	jalr	540(ra) # 80002a0c <_Z8printIntiii>
    800057f8:	00005517          	auipc	a0,0x5
    800057fc:	b5050513          	addi	a0,a0,-1200 # 8000a348 <CONSOLE_STATUS+0x338>
    80005800:	ffffd097          	auipc	ra,0xffffd
    80005804:	074080e7          	jalr	116(ra) # 80002874 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005808:	0014849b          	addiw	s1,s1,1
    8000580c:	0ff4f493          	andi	s1,s1,255
    80005810:	00200793          	li	a5,2
    80005814:	fc97f0e3          	bgeu	a5,s1,800057d4 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80005818:	00005517          	auipc	a0,0x5
    8000581c:	da050513          	addi	a0,a0,-608 # 8000a5b8 <CONSOLE_STATUS+0x5a8>
    80005820:	ffffd097          	auipc	ra,0xffffd
    80005824:	054080e7          	jalr	84(ra) # 80002874 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005828:	00700313          	li	t1,7
    thread_dispatch();
    8000582c:	ffffc097          	auipc	ra,0xffffc
    80005830:	664080e7          	jalr	1636(ra) # 80001e90 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005834:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80005838:	00005517          	auipc	a0,0x5
    8000583c:	d9050513          	addi	a0,a0,-624 # 8000a5c8 <CONSOLE_STATUS+0x5b8>
    80005840:	ffffd097          	auipc	ra,0xffffd
    80005844:	034080e7          	jalr	52(ra) # 80002874 <_Z11printStringPKc>
    80005848:	00000613          	li	a2,0
    8000584c:	00a00593          	li	a1,10
    80005850:	0009051b          	sext.w	a0,s2
    80005854:	ffffd097          	auipc	ra,0xffffd
    80005858:	1b8080e7          	jalr	440(ra) # 80002a0c <_Z8printIntiii>
    8000585c:	00005517          	auipc	a0,0x5
    80005860:	aec50513          	addi	a0,a0,-1300 # 8000a348 <CONSOLE_STATUS+0x338>
    80005864:	ffffd097          	auipc	ra,0xffffd
    80005868:	010080e7          	jalr	16(ra) # 80002874 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000586c:	00c00513          	li	a0,12
    80005870:	00000097          	auipc	ra,0x0
    80005874:	d30080e7          	jalr	-720(ra) # 800055a0 <_Z9fibonaccim>
    80005878:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000587c:	00005517          	auipc	a0,0x5
    80005880:	d5450513          	addi	a0,a0,-684 # 8000a5d0 <CONSOLE_STATUS+0x5c0>
    80005884:	ffffd097          	auipc	ra,0xffffd
    80005888:	ff0080e7          	jalr	-16(ra) # 80002874 <_Z11printStringPKc>
    8000588c:	00000613          	li	a2,0
    80005890:	00a00593          	li	a1,10
    80005894:	0009051b          	sext.w	a0,s2
    80005898:	ffffd097          	auipc	ra,0xffffd
    8000589c:	174080e7          	jalr	372(ra) # 80002a0c <_Z8printIntiii>
    800058a0:	00005517          	auipc	a0,0x5
    800058a4:	aa850513          	addi	a0,a0,-1368 # 8000a348 <CONSOLE_STATUS+0x338>
    800058a8:	ffffd097          	auipc	ra,0xffffd
    800058ac:	fcc080e7          	jalr	-52(ra) # 80002874 <_Z11printStringPKc>
    800058b0:	0400006f          	j	800058f0 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800058b4:	00005517          	auipc	a0,0x5
    800058b8:	cfc50513          	addi	a0,a0,-772 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    800058bc:	ffffd097          	auipc	ra,0xffffd
    800058c0:	fb8080e7          	jalr	-72(ra) # 80002874 <_Z11printStringPKc>
    800058c4:	00000613          	li	a2,0
    800058c8:	00a00593          	li	a1,10
    800058cc:	00048513          	mv	a0,s1
    800058d0:	ffffd097          	auipc	ra,0xffffd
    800058d4:	13c080e7          	jalr	316(ra) # 80002a0c <_Z8printIntiii>
    800058d8:	00005517          	auipc	a0,0x5
    800058dc:	a7050513          	addi	a0,a0,-1424 # 8000a348 <CONSOLE_STATUS+0x338>
    800058e0:	ffffd097          	auipc	ra,0xffffd
    800058e4:	f94080e7          	jalr	-108(ra) # 80002874 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800058e8:	0014849b          	addiw	s1,s1,1
    800058ec:	0ff4f493          	andi	s1,s1,255
    800058f0:	00500793          	li	a5,5
    800058f4:	fc97f0e3          	bgeu	a5,s1,800058b4 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("C finished!\n");
    800058f8:	00005517          	auipc	a0,0x5
    800058fc:	ce850513          	addi	a0,a0,-792 # 8000a5e0 <CONSOLE_STATUS+0x5d0>
    80005900:	ffffd097          	auipc	ra,0xffffd
    80005904:	f74080e7          	jalr	-140(ra) # 80002874 <_Z11printStringPKc>
    finishedC = true;
    80005908:	00100793          	li	a5,1
    8000590c:	0000c717          	auipc	a4,0xc
    80005910:	d6f70c23          	sb	a5,-648(a4) # 80011684 <finishedC>
    thread_dispatch();
    80005914:	ffffc097          	auipc	ra,0xffffc
    80005918:	57c080e7          	jalr	1404(ra) # 80001e90 <_Z15thread_dispatchv>
}
    8000591c:	01813083          	ld	ra,24(sp)
    80005920:	01013403          	ld	s0,16(sp)
    80005924:	00813483          	ld	s1,8(sp)
    80005928:	00013903          	ld	s2,0(sp)
    8000592c:	02010113          	addi	sp,sp,32
    80005930:	00008067          	ret

0000000080005934 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80005934:	fe010113          	addi	sp,sp,-32
    80005938:	00113c23          	sd	ra,24(sp)
    8000593c:	00813823          	sd	s0,16(sp)
    80005940:	00913423          	sd	s1,8(sp)
    80005944:	01213023          	sd	s2,0(sp)
    80005948:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000594c:	00a00493          	li	s1,10
    80005950:	0400006f          	j	80005990 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005954:	00005517          	auipc	a0,0x5
    80005958:	c9c50513          	addi	a0,a0,-868 # 8000a5f0 <CONSOLE_STATUS+0x5e0>
    8000595c:	ffffd097          	auipc	ra,0xffffd
    80005960:	f18080e7          	jalr	-232(ra) # 80002874 <_Z11printStringPKc>
    80005964:	00000613          	li	a2,0
    80005968:	00a00593          	li	a1,10
    8000596c:	00048513          	mv	a0,s1
    80005970:	ffffd097          	auipc	ra,0xffffd
    80005974:	09c080e7          	jalr	156(ra) # 80002a0c <_Z8printIntiii>
    80005978:	00005517          	auipc	a0,0x5
    8000597c:	9d050513          	addi	a0,a0,-1584 # 8000a348 <CONSOLE_STATUS+0x338>
    80005980:	ffffd097          	auipc	ra,0xffffd
    80005984:	ef4080e7          	jalr	-268(ra) # 80002874 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005988:	0014849b          	addiw	s1,s1,1
    8000598c:	0ff4f493          	andi	s1,s1,255
    80005990:	00c00793          	li	a5,12
    80005994:	fc97f0e3          	bgeu	a5,s1,80005954 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80005998:	00005517          	auipc	a0,0x5
    8000599c:	c6050513          	addi	a0,a0,-928 # 8000a5f8 <CONSOLE_STATUS+0x5e8>
    800059a0:	ffffd097          	auipc	ra,0xffffd
    800059a4:	ed4080e7          	jalr	-300(ra) # 80002874 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800059a8:	00500313          	li	t1,5
    thread_dispatch();
    800059ac:	ffffc097          	auipc	ra,0xffffc
    800059b0:	4e4080e7          	jalr	1252(ra) # 80001e90 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800059b4:	01000513          	li	a0,16
    800059b8:	00000097          	auipc	ra,0x0
    800059bc:	be8080e7          	jalr	-1048(ra) # 800055a0 <_Z9fibonaccim>
    800059c0:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800059c4:	00005517          	auipc	a0,0x5
    800059c8:	c4450513          	addi	a0,a0,-956 # 8000a608 <CONSOLE_STATUS+0x5f8>
    800059cc:	ffffd097          	auipc	ra,0xffffd
    800059d0:	ea8080e7          	jalr	-344(ra) # 80002874 <_Z11printStringPKc>
    800059d4:	00000613          	li	a2,0
    800059d8:	00a00593          	li	a1,10
    800059dc:	0009051b          	sext.w	a0,s2
    800059e0:	ffffd097          	auipc	ra,0xffffd
    800059e4:	02c080e7          	jalr	44(ra) # 80002a0c <_Z8printIntiii>
    800059e8:	00005517          	auipc	a0,0x5
    800059ec:	96050513          	addi	a0,a0,-1696 # 8000a348 <CONSOLE_STATUS+0x338>
    800059f0:	ffffd097          	auipc	ra,0xffffd
    800059f4:	e84080e7          	jalr	-380(ra) # 80002874 <_Z11printStringPKc>
    800059f8:	0400006f          	j	80005a38 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800059fc:	00005517          	auipc	a0,0x5
    80005a00:	bf450513          	addi	a0,a0,-1036 # 8000a5f0 <CONSOLE_STATUS+0x5e0>
    80005a04:	ffffd097          	auipc	ra,0xffffd
    80005a08:	e70080e7          	jalr	-400(ra) # 80002874 <_Z11printStringPKc>
    80005a0c:	00000613          	li	a2,0
    80005a10:	00a00593          	li	a1,10
    80005a14:	00048513          	mv	a0,s1
    80005a18:	ffffd097          	auipc	ra,0xffffd
    80005a1c:	ff4080e7          	jalr	-12(ra) # 80002a0c <_Z8printIntiii>
    80005a20:	00005517          	auipc	a0,0x5
    80005a24:	92850513          	addi	a0,a0,-1752 # 8000a348 <CONSOLE_STATUS+0x338>
    80005a28:	ffffd097          	auipc	ra,0xffffd
    80005a2c:	e4c080e7          	jalr	-436(ra) # 80002874 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005a30:	0014849b          	addiw	s1,s1,1
    80005a34:	0ff4f493          	andi	s1,s1,255
    80005a38:	00f00793          	li	a5,15
    80005a3c:	fc97f0e3          	bgeu	a5,s1,800059fc <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80005a40:	00005517          	auipc	a0,0x5
    80005a44:	bd850513          	addi	a0,a0,-1064 # 8000a618 <CONSOLE_STATUS+0x608>
    80005a48:	ffffd097          	auipc	ra,0xffffd
    80005a4c:	e2c080e7          	jalr	-468(ra) # 80002874 <_Z11printStringPKc>
    finishedD = true;
    80005a50:	00100793          	li	a5,1
    80005a54:	0000c717          	auipc	a4,0xc
    80005a58:	c2f708a3          	sb	a5,-975(a4) # 80011685 <finishedD>
    thread_dispatch();
    80005a5c:	ffffc097          	auipc	ra,0xffffc
    80005a60:	434080e7          	jalr	1076(ra) # 80001e90 <_Z15thread_dispatchv>
}
    80005a64:	01813083          	ld	ra,24(sp)
    80005a68:	01013403          	ld	s0,16(sp)
    80005a6c:	00813483          	ld	s1,8(sp)
    80005a70:	00013903          	ld	s2,0(sp)
    80005a74:	02010113          	addi	sp,sp,32
    80005a78:	00008067          	ret

0000000080005a7c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80005a7c:	fc010113          	addi	sp,sp,-64
    80005a80:	02113c23          	sd	ra,56(sp)
    80005a84:	02813823          	sd	s0,48(sp)
    80005a88:	02913423          	sd	s1,40(sp)
    80005a8c:	03213023          	sd	s2,32(sp)
    80005a90:	04010413          	addi	s0,sp,64

    Thread* threads[4];

    threads[0] = new WorkerA();
    80005a94:	01000513          	li	a0,16
    80005a98:	ffffe097          	auipc	ra,0xffffe
    80005a9c:	b08080e7          	jalr	-1272(ra) # 800035a0 <_Znwm>
    80005aa0:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80005aa4:	ffffe097          	auipc	ra,0xffffe
    80005aa8:	cbc080e7          	jalr	-836(ra) # 80003760 <_ZN6ThreadC1Ev>
    80005aac:	00007797          	auipc	a5,0x7
    80005ab0:	72c78793          	addi	a5,a5,1836 # 8000d1d8 <_ZTV7WorkerA+0x10>
    80005ab4:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80005ab8:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80005abc:	00005517          	auipc	a0,0x5
    80005ac0:	b6c50513          	addi	a0,a0,-1172 # 8000a628 <CONSOLE_STATUS+0x618>
    80005ac4:	ffffd097          	auipc	ra,0xffffd
    80005ac8:	db0080e7          	jalr	-592(ra) # 80002874 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80005acc:	01000513          	li	a0,16
    80005ad0:	ffffe097          	auipc	ra,0xffffe
    80005ad4:	ad0080e7          	jalr	-1328(ra) # 800035a0 <_Znwm>
    80005ad8:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80005adc:	ffffe097          	auipc	ra,0xffffe
    80005ae0:	c84080e7          	jalr	-892(ra) # 80003760 <_ZN6ThreadC1Ev>
    80005ae4:	00007797          	auipc	a5,0x7
    80005ae8:	71c78793          	addi	a5,a5,1820 # 8000d200 <_ZTV7WorkerB+0x10>
    80005aec:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80005af0:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80005af4:	00005517          	auipc	a0,0x5
    80005af8:	b4c50513          	addi	a0,a0,-1204 # 8000a640 <CONSOLE_STATUS+0x630>
    80005afc:	ffffd097          	auipc	ra,0xffffd
    80005b00:	d78080e7          	jalr	-648(ra) # 80002874 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80005b04:	01000513          	li	a0,16
    80005b08:	ffffe097          	auipc	ra,0xffffe
    80005b0c:	a98080e7          	jalr	-1384(ra) # 800035a0 <_Znwm>
    80005b10:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80005b14:	ffffe097          	auipc	ra,0xffffe
    80005b18:	c4c080e7          	jalr	-948(ra) # 80003760 <_ZN6ThreadC1Ev>
    80005b1c:	00007797          	auipc	a5,0x7
    80005b20:	70c78793          	addi	a5,a5,1804 # 8000d228 <_ZTV7WorkerC+0x10>
    80005b24:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80005b28:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80005b2c:	00005517          	auipc	a0,0x5
    80005b30:	b2c50513          	addi	a0,a0,-1236 # 8000a658 <CONSOLE_STATUS+0x648>
    80005b34:	ffffd097          	auipc	ra,0xffffd
    80005b38:	d40080e7          	jalr	-704(ra) # 80002874 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80005b3c:	01000513          	li	a0,16
    80005b40:	ffffe097          	auipc	ra,0xffffe
    80005b44:	a60080e7          	jalr	-1440(ra) # 800035a0 <_Znwm>
    80005b48:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80005b4c:	ffffe097          	auipc	ra,0xffffe
    80005b50:	c14080e7          	jalr	-1004(ra) # 80003760 <_ZN6ThreadC1Ev>
    80005b54:	00007797          	auipc	a5,0x7
    80005b58:	6fc78793          	addi	a5,a5,1788 # 8000d250 <_ZTV7WorkerD+0x10>
    80005b5c:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80005b60:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80005b64:	00005517          	auipc	a0,0x5
    80005b68:	b0c50513          	addi	a0,a0,-1268 # 8000a670 <CONSOLE_STATUS+0x660>
    80005b6c:	ffffd097          	auipc	ra,0xffffd
    80005b70:	d08080e7          	jalr	-760(ra) # 80002874 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80005b74:	00000493          	li	s1,0
    80005b78:	00300793          	li	a5,3
    80005b7c:	0297c663          	blt	a5,s1,80005ba8 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80005b80:	00349793          	slli	a5,s1,0x3
    80005b84:	fe040713          	addi	a4,s0,-32
    80005b88:	00f707b3          	add	a5,a4,a5
    80005b8c:	fe07b503          	ld	a0,-32(a5)
    80005b90:	ffffe097          	auipc	ra,0xffffe
    80005b94:	ca4080e7          	jalr	-860(ra) # 80003834 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80005b98:	0014849b          	addiw	s1,s1,1
    80005b9c:	fddff06f          	j	80005b78 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80005ba0:	ffffe097          	auipc	ra,0xffffe
    80005ba4:	c6c080e7          	jalr	-916(ra) # 8000380c <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005ba8:	0000c797          	auipc	a5,0xc
    80005bac:	ada7c783          	lbu	a5,-1318(a5) # 80011682 <finishedA>
    80005bb0:	fe0788e3          	beqz	a5,80005ba0 <_Z20Threads_CPP_API_testv+0x124>
    80005bb4:	0000c797          	auipc	a5,0xc
    80005bb8:	acf7c783          	lbu	a5,-1329(a5) # 80011683 <finishedB>
    80005bbc:	fe0782e3          	beqz	a5,80005ba0 <_Z20Threads_CPP_API_testv+0x124>
    80005bc0:	0000c797          	auipc	a5,0xc
    80005bc4:	ac47c783          	lbu	a5,-1340(a5) # 80011684 <finishedC>
    80005bc8:	fc078ce3          	beqz	a5,80005ba0 <_Z20Threads_CPP_API_testv+0x124>
    80005bcc:	0000c797          	auipc	a5,0xc
    80005bd0:	ab97c783          	lbu	a5,-1351(a5) # 80011685 <finishedD>
    80005bd4:	fc0786e3          	beqz	a5,80005ba0 <_Z20Threads_CPP_API_testv+0x124>
    }

    for (auto thread: threads) { delete thread; }
    80005bd8:	fc040493          	addi	s1,s0,-64
    80005bdc:	0080006f          	j	80005be4 <_Z20Threads_CPP_API_testv+0x168>
    80005be0:	00848493          	addi	s1,s1,8
    80005be4:	fe040793          	addi	a5,s0,-32
    80005be8:	08f48663          	beq	s1,a5,80005c74 <_Z20Threads_CPP_API_testv+0x1f8>
    80005bec:	0004b503          	ld	a0,0(s1)
    80005bf0:	fe0508e3          	beqz	a0,80005be0 <_Z20Threads_CPP_API_testv+0x164>
    80005bf4:	00053783          	ld	a5,0(a0)
    80005bf8:	0087b783          	ld	a5,8(a5)
    80005bfc:	000780e7          	jalr	a5
    80005c00:	fe1ff06f          	j	80005be0 <_Z20Threads_CPP_API_testv+0x164>
    80005c04:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80005c08:	00048513          	mv	a0,s1
    80005c0c:	ffffe097          	auipc	ra,0xffffe
    80005c10:	9e4080e7          	jalr	-1564(ra) # 800035f0 <_ZdlPv>
    80005c14:	00090513          	mv	a0,s2
    80005c18:	0000d097          	auipc	ra,0xd
    80005c1c:	b50080e7          	jalr	-1200(ra) # 80012768 <_Unwind_Resume>
    80005c20:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80005c24:	00048513          	mv	a0,s1
    80005c28:	ffffe097          	auipc	ra,0xffffe
    80005c2c:	9c8080e7          	jalr	-1592(ra) # 800035f0 <_ZdlPv>
    80005c30:	00090513          	mv	a0,s2
    80005c34:	0000d097          	auipc	ra,0xd
    80005c38:	b34080e7          	jalr	-1228(ra) # 80012768 <_Unwind_Resume>
    80005c3c:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80005c40:	00048513          	mv	a0,s1
    80005c44:	ffffe097          	auipc	ra,0xffffe
    80005c48:	9ac080e7          	jalr	-1620(ra) # 800035f0 <_ZdlPv>
    80005c4c:	00090513          	mv	a0,s2
    80005c50:	0000d097          	auipc	ra,0xd
    80005c54:	b18080e7          	jalr	-1256(ra) # 80012768 <_Unwind_Resume>
    80005c58:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80005c5c:	00048513          	mv	a0,s1
    80005c60:	ffffe097          	auipc	ra,0xffffe
    80005c64:	990080e7          	jalr	-1648(ra) # 800035f0 <_ZdlPv>
    80005c68:	00090513          	mv	a0,s2
    80005c6c:	0000d097          	auipc	ra,0xd
    80005c70:	afc080e7          	jalr	-1284(ra) # 80012768 <_Unwind_Resume>
}
    80005c74:	03813083          	ld	ra,56(sp)
    80005c78:	03013403          	ld	s0,48(sp)
    80005c7c:	02813483          	ld	s1,40(sp)
    80005c80:	02013903          	ld	s2,32(sp)
    80005c84:	04010113          	addi	sp,sp,64
    80005c88:	00008067          	ret

0000000080005c8c <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80005c8c:	fd010113          	addi	sp,sp,-48
    80005c90:	02113423          	sd	ra,40(sp)
    80005c94:	02813023          	sd	s0,32(sp)
    80005c98:	00913c23          	sd	s1,24(sp)
    80005c9c:	01213823          	sd	s2,16(sp)
    80005ca0:	01313423          	sd	s3,8(sp)
    80005ca4:	03010413          	addi	s0,sp,48
    80005ca8:	00050993          	mv	s3,a0
    80005cac:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80005cb0:	00000913          	li	s2,0
    80005cb4:	00c0006f          	j	80005cc0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005cb8:	ffffe097          	auipc	ra,0xffffe
    80005cbc:	b54080e7          	jalr	-1196(ra) # 8000380c <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80005cc0:	ffffc097          	auipc	ra,0xffffc
    80005cc4:	380080e7          	jalr	896(ra) # 80002040 <_Z4getcv>
    80005cc8:	0005059b          	sext.w	a1,a0
    80005ccc:	01b00793          	li	a5,27
    80005cd0:	02f58a63          	beq	a1,a5,80005d04 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80005cd4:	0084b503          	ld	a0,8(s1)
    80005cd8:	fffff097          	auipc	ra,0xfffff
    80005cdc:	580080e7          	jalr	1408(ra) # 80005258 <_ZN9BufferCPP3putEi>
        i++;
    80005ce0:	0019071b          	addiw	a4,s2,1
    80005ce4:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005ce8:	0004a683          	lw	a3,0(s1)
    80005cec:	0026979b          	slliw	a5,a3,0x2
    80005cf0:	00d787bb          	addw	a5,a5,a3
    80005cf4:	0017979b          	slliw	a5,a5,0x1
    80005cf8:	02f767bb          	remw	a5,a4,a5
    80005cfc:	fc0792e3          	bnez	a5,80005cc0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80005d00:	fb9ff06f          	j	80005cb8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80005d04:	00100793          	li	a5,1
    80005d08:	0000c717          	auipc	a4,0xc
    80005d0c:	98f72023          	sw	a5,-1664(a4) # 80011688 <threadEnd>
    td->buffer->put('!');
    80005d10:	0109b783          	ld	a5,16(s3)
    80005d14:	02100593          	li	a1,33
    80005d18:	0087b503          	ld	a0,8(a5)
    80005d1c:	fffff097          	auipc	ra,0xfffff
    80005d20:	53c080e7          	jalr	1340(ra) # 80005258 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80005d24:	0104b503          	ld	a0,16(s1)
    80005d28:	ffffe097          	auipc	ra,0xffffe
    80005d2c:	9d4080e7          	jalr	-1580(ra) # 800036fc <_ZN9Semaphore6signalEv>
}
    80005d30:	02813083          	ld	ra,40(sp)
    80005d34:	02013403          	ld	s0,32(sp)
    80005d38:	01813483          	ld	s1,24(sp)
    80005d3c:	01013903          	ld	s2,16(sp)
    80005d40:	00813983          	ld	s3,8(sp)
    80005d44:	03010113          	addi	sp,sp,48
    80005d48:	00008067          	ret

0000000080005d4c <_ZN8Producer8producerEPv>:
    void run() override {
        producer(td);
    }
};

void Producer::producer(void *arg) {
    80005d4c:	fe010113          	addi	sp,sp,-32
    80005d50:	00113c23          	sd	ra,24(sp)
    80005d54:	00813823          	sd	s0,16(sp)
    80005d58:	00913423          	sd	s1,8(sp)
    80005d5c:	01213023          	sd	s2,0(sp)
    80005d60:	02010413          	addi	s0,sp,32
    80005d64:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80005d68:	00000913          	li	s2,0
    80005d6c:	00c0006f          	j	80005d78 <_ZN8Producer8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005d70:	ffffe097          	auipc	ra,0xffffe
    80005d74:	a9c080e7          	jalr	-1380(ra) # 8000380c <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80005d78:	0000c797          	auipc	a5,0xc
    80005d7c:	9107a783          	lw	a5,-1776(a5) # 80011688 <threadEnd>
    80005d80:	02079e63          	bnez	a5,80005dbc <_ZN8Producer8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80005d84:	0004a583          	lw	a1,0(s1)
    80005d88:	0305859b          	addiw	a1,a1,48
    80005d8c:	0084b503          	ld	a0,8(s1)
    80005d90:	fffff097          	auipc	ra,0xfffff
    80005d94:	4c8080e7          	jalr	1224(ra) # 80005258 <_ZN9BufferCPP3putEi>
        i++;
    80005d98:	0019071b          	addiw	a4,s2,1
    80005d9c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005da0:	0004a683          	lw	a3,0(s1)
    80005da4:	0026979b          	slliw	a5,a3,0x2
    80005da8:	00d787bb          	addw	a5,a5,a3
    80005dac:	0017979b          	slliw	a5,a5,0x1
    80005db0:	02f767bb          	remw	a5,a4,a5
    80005db4:	fc0792e3          	bnez	a5,80005d78 <_ZN8Producer8producerEPv+0x2c>
    80005db8:	fb9ff06f          	j	80005d70 <_ZN8Producer8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80005dbc:	0104b503          	ld	a0,16(s1)
    80005dc0:	ffffe097          	auipc	ra,0xffffe
    80005dc4:	93c080e7          	jalr	-1732(ra) # 800036fc <_ZN9Semaphore6signalEv>
}
    80005dc8:	01813083          	ld	ra,24(sp)
    80005dcc:	01013403          	ld	s0,16(sp)
    80005dd0:	00813483          	ld	s1,8(sp)
    80005dd4:	00013903          	ld	s2,0(sp)
    80005dd8:	02010113          	addi	sp,sp,32
    80005ddc:	00008067          	ret

0000000080005de0 <_ZN8Consumer8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void Consumer::consumer(void *arg) {
    80005de0:	fd010113          	addi	sp,sp,-48
    80005de4:	02113423          	sd	ra,40(sp)
    80005de8:	02813023          	sd	s0,32(sp)
    80005dec:	00913c23          	sd	s1,24(sp)
    80005df0:	01213823          	sd	s2,16(sp)
    80005df4:	01313423          	sd	s3,8(sp)
    80005df8:	01413023          	sd	s4,0(sp)
    80005dfc:	03010413          	addi	s0,sp,48
    80005e00:	00050993          	mv	s3,a0
    80005e04:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80005e08:	00000a13          	li	s4,0
    80005e0c:	01c0006f          	j	80005e28 <_ZN8Consumer8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80005e10:	ffffe097          	auipc	ra,0xffffe
    80005e14:	9fc080e7          	jalr	-1540(ra) # 8000380c <_ZN6Thread8dispatchEv>
    80005e18:	0500006f          	j	80005e68 <_ZN8Consumer8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80005e1c:	00a00513          	li	a0,10
    80005e20:	ffffc097          	auipc	ra,0xffffc
    80005e24:	248080e7          	jalr	584(ra) # 80002068 <_Z4putcc>
    while (!threadEnd) {
    80005e28:	0000c797          	auipc	a5,0xc
    80005e2c:	8607a783          	lw	a5,-1952(a5) # 80011688 <threadEnd>
    80005e30:	06079263          	bnez	a5,80005e94 <_ZN8Consumer8consumerEPv+0xb4>
        int key = data->buffer->get();
    80005e34:	00893503          	ld	a0,8(s2)
    80005e38:	fffff097          	auipc	ra,0xfffff
    80005e3c:	4b0080e7          	jalr	1200(ra) # 800052e8 <_ZN9BufferCPP3getEv>
        i++;
    80005e40:	001a049b          	addiw	s1,s4,1
    80005e44:	00048a1b          	sext.w	s4,s1
        putc(key);
    80005e48:	0ff57513          	andi	a0,a0,255
    80005e4c:	ffffc097          	auipc	ra,0xffffc
    80005e50:	21c080e7          	jalr	540(ra) # 80002068 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80005e54:	00092703          	lw	a4,0(s2)
    80005e58:	0027179b          	slliw	a5,a4,0x2
    80005e5c:	00e787bb          	addw	a5,a5,a4
    80005e60:	02f4e7bb          	remw	a5,s1,a5
    80005e64:	fa0786e3          	beqz	a5,80005e10 <_ZN8Consumer8consumerEPv+0x30>
        if (i % 80 == 0) {
    80005e68:	05000793          	li	a5,80
    80005e6c:	02f4e4bb          	remw	s1,s1,a5
    80005e70:	fa049ce3          	bnez	s1,80005e28 <_ZN8Consumer8consumerEPv+0x48>
    80005e74:	fa9ff06f          	j	80005e1c <_ZN8Consumer8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80005e78:	0109b783          	ld	a5,16(s3)
    80005e7c:	0087b503          	ld	a0,8(a5)
    80005e80:	fffff097          	auipc	ra,0xfffff
    80005e84:	468080e7          	jalr	1128(ra) # 800052e8 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80005e88:	0ff57513          	andi	a0,a0,255
    80005e8c:	ffffe097          	auipc	ra,0xffffe
    80005e90:	a6c080e7          	jalr	-1428(ra) # 800038f8 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80005e94:	0109b783          	ld	a5,16(s3)
    80005e98:	0087b503          	ld	a0,8(a5)
    80005e9c:	fffff097          	auipc	ra,0xfffff
    80005ea0:	4d8080e7          	jalr	1240(ra) # 80005374 <_ZN9BufferCPP6getCntEv>
    80005ea4:	fca04ae3          	bgtz	a0,80005e78 <_ZN8Consumer8consumerEPv+0x98>
    }

    data->wait->signal();
    80005ea8:	01093503          	ld	a0,16(s2)
    80005eac:	ffffe097          	auipc	ra,0xffffe
    80005eb0:	850080e7          	jalr	-1968(ra) # 800036fc <_ZN9Semaphore6signalEv>
}
    80005eb4:	02813083          	ld	ra,40(sp)
    80005eb8:	02013403          	ld	s0,32(sp)
    80005ebc:	01813483          	ld	s1,24(sp)
    80005ec0:	01013903          	ld	s2,16(sp)
    80005ec4:	00813983          	ld	s3,8(sp)
    80005ec8:	00013a03          	ld	s4,0(sp)
    80005ecc:	03010113          	addi	sp,sp,48
    80005ed0:	00008067          	ret

0000000080005ed4 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80005ed4:	f8010113          	addi	sp,sp,-128
    80005ed8:	06113c23          	sd	ra,120(sp)
    80005edc:	06813823          	sd	s0,112(sp)
    80005ee0:	06913423          	sd	s1,104(sp)
    80005ee4:	07213023          	sd	s2,96(sp)
    80005ee8:	05313c23          	sd	s3,88(sp)
    80005eec:	05413823          	sd	s4,80(sp)
    80005ef0:	05513423          	sd	s5,72(sp)
    80005ef4:	05613023          	sd	s6,64(sp)
    80005ef8:	03713c23          	sd	s7,56(sp)
    80005efc:	03813823          	sd	s8,48(sp)
    80005f00:	03913423          	sd	s9,40(sp)
    80005f04:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80005f08:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80005f0c:	00004517          	auipc	a0,0x4
    80005f10:	77c50513          	addi	a0,a0,1916 # 8000a688 <CONSOLE_STATUS+0x678>
    80005f14:	ffffd097          	auipc	ra,0xffffd
    80005f18:	960080e7          	jalr	-1696(ra) # 80002874 <_Z11printStringPKc>
    getString(input, 30);
    80005f1c:	01e00593          	li	a1,30
    80005f20:	f8040493          	addi	s1,s0,-128
    80005f24:	00048513          	mv	a0,s1
    80005f28:	ffffd097          	auipc	ra,0xffffd
    80005f2c:	9c8080e7          	jalr	-1592(ra) # 800028f0 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80005f30:	00048513          	mv	a0,s1
    80005f34:	ffffd097          	auipc	ra,0xffffd
    80005f38:	a88080e7          	jalr	-1400(ra) # 800029bc <_Z11stringToIntPKc>
    80005f3c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80005f40:	00004517          	auipc	a0,0x4
    80005f44:	76850513          	addi	a0,a0,1896 # 8000a6a8 <CONSOLE_STATUS+0x698>
    80005f48:	ffffd097          	auipc	ra,0xffffd
    80005f4c:	92c080e7          	jalr	-1748(ra) # 80002874 <_Z11printStringPKc>
    getString(input, 30);
    80005f50:	01e00593          	li	a1,30
    80005f54:	00048513          	mv	a0,s1
    80005f58:	ffffd097          	auipc	ra,0xffffd
    80005f5c:	998080e7          	jalr	-1640(ra) # 800028f0 <_Z9getStringPci>
    n = stringToInt(input);
    80005f60:	00048513          	mv	a0,s1
    80005f64:	ffffd097          	auipc	ra,0xffffd
    80005f68:	a58080e7          	jalr	-1448(ra) # 800029bc <_Z11stringToIntPKc>
    80005f6c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80005f70:	00004517          	auipc	a0,0x4
    80005f74:	75850513          	addi	a0,a0,1880 # 8000a6c8 <CONSOLE_STATUS+0x6b8>
    80005f78:	ffffd097          	auipc	ra,0xffffd
    80005f7c:	8fc080e7          	jalr	-1796(ra) # 80002874 <_Z11printStringPKc>
    80005f80:	00000613          	li	a2,0
    80005f84:	00a00593          	li	a1,10
    80005f88:	00090513          	mv	a0,s2
    80005f8c:	ffffd097          	auipc	ra,0xffffd
    80005f90:	a80080e7          	jalr	-1408(ra) # 80002a0c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80005f94:	00004517          	auipc	a0,0x4
    80005f98:	74c50513          	addi	a0,a0,1868 # 8000a6e0 <CONSOLE_STATUS+0x6d0>
    80005f9c:	ffffd097          	auipc	ra,0xffffd
    80005fa0:	8d8080e7          	jalr	-1832(ra) # 80002874 <_Z11printStringPKc>
    80005fa4:	00000613          	li	a2,0
    80005fa8:	00a00593          	li	a1,10
    80005fac:	00048513          	mv	a0,s1
    80005fb0:	ffffd097          	auipc	ra,0xffffd
    80005fb4:	a5c080e7          	jalr	-1444(ra) # 80002a0c <_Z8printIntiii>
    printString(".\n");
    80005fb8:	00004517          	auipc	a0,0x4
    80005fbc:	3f850513          	addi	a0,a0,1016 # 8000a3b0 <CONSOLE_STATUS+0x3a0>
    80005fc0:	ffffd097          	auipc	ra,0xffffd
    80005fc4:	8b4080e7          	jalr	-1868(ra) # 80002874 <_Z11printStringPKc>
    if(threadNum > n) {
    80005fc8:	0324c463          	blt	s1,s2,80005ff0 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80005fcc:	03205c63          	blez	s2,80006004 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80005fd0:	03800513          	li	a0,56
    80005fd4:	ffffd097          	auipc	ra,0xffffd
    80005fd8:	5cc080e7          	jalr	1484(ra) # 800035a0 <_Znwm>
    80005fdc:	00050a93          	mv	s5,a0
    80005fe0:	00048593          	mv	a1,s1
    80005fe4:	fffff097          	auipc	ra,0xfffff
    80005fe8:	120080e7          	jalr	288(ra) # 80005104 <_ZN9BufferCPPC1Ei>
    80005fec:	0300006f          	j	8000601c <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005ff0:	00004517          	auipc	a0,0x4
    80005ff4:	70850513          	addi	a0,a0,1800 # 8000a6f8 <CONSOLE_STATUS+0x6e8>
    80005ff8:	ffffd097          	auipc	ra,0xffffd
    80005ffc:	87c080e7          	jalr	-1924(ra) # 80002874 <_Z11printStringPKc>
        return;
    80006000:	0140006f          	j	80006014 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80006004:	00004517          	auipc	a0,0x4
    80006008:	73450513          	addi	a0,a0,1844 # 8000a738 <CONSOLE_STATUS+0x728>
    8000600c:	ffffd097          	auipc	ra,0xffffd
    80006010:	868080e7          	jalr	-1944(ra) # 80002874 <_Z11printStringPKc>
        return;
    80006014:	000b8113          	mv	sp,s7
    80006018:	2400006f          	j	80006258 <_Z29producerConsumer_CPP_Sync_APIv+0x384>
    waitForAll = new Semaphore(0);
    8000601c:	01000513          	li	a0,16
    80006020:	ffffd097          	auipc	ra,0xffffd
    80006024:	580080e7          	jalr	1408(ra) # 800035a0 <_Znwm>
    80006028:	00050493          	mv	s1,a0
    8000602c:	00000593          	li	a1,0
    80006030:	ffffd097          	auipc	ra,0xffffd
    80006034:	668080e7          	jalr	1640(ra) # 80003698 <_ZN9SemaphoreC1Ej>
    80006038:	0000b717          	auipc	a4,0xb
    8000603c:	64070713          	addi	a4,a4,1600 # 80011678 <_ZN19ConsumerProducerCPP9threadEndE>
    80006040:	00973c23          	sd	s1,24(a4)
    Thread* threads[threadNum];
    80006044:	00391793          	slli	a5,s2,0x3
    80006048:	00f78793          	addi	a5,a5,15
    8000604c:	ff07f793          	andi	a5,a5,-16
    80006050:	40f10133          	sub	sp,sp,a5
    80006054:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80006058:	0019069b          	addiw	a3,s2,1
    8000605c:	00169793          	slli	a5,a3,0x1
    80006060:	00d787b3          	add	a5,a5,a3
    80006064:	00379793          	slli	a5,a5,0x3
    80006068:	00f78793          	addi	a5,a5,15
    8000606c:	ff07f793          	andi	a5,a5,-16
    80006070:	40f10133          	sub	sp,sp,a5
    80006074:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80006078:	00191493          	slli	s1,s2,0x1
    8000607c:	012487b3          	add	a5,s1,s2
    80006080:	00379793          	slli	a5,a5,0x3
    80006084:	00fa07b3          	add	a5,s4,a5
    80006088:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    8000608c:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80006090:	01873703          	ld	a4,24(a4)
    80006094:	00e7b823          	sd	a4,16(a5)
    consumerThread = new Consumer(data+threadNum);
    80006098:	01800513          	li	a0,24
    8000609c:	ffffd097          	auipc	ra,0xffffd
    800060a0:	504080e7          	jalr	1284(ra) # 800035a0 <_Znwm>
    800060a4:	00050b13          	mv	s6,a0
    800060a8:	012484b3          	add	s1,s1,s2
    800060ac:	00349493          	slli	s1,s1,0x3
    800060b0:	009a04b3          	add	s1,s4,s1
    Consumer(thread_data* _td):Thread(), td(_td) {}
    800060b4:	ffffd097          	auipc	ra,0xffffd
    800060b8:	6ac080e7          	jalr	1708(ra) # 80003760 <_ZN6ThreadC1Ev>
    800060bc:	00007797          	auipc	a5,0x7
    800060c0:	20c78793          	addi	a5,a5,524 # 8000d2c8 <_ZTV8Consumer+0x10>
    800060c4:	00fb3023          	sd	a5,0(s6)
    800060c8:	009b3823          	sd	s1,16(s6)
    consumerThread->start();
    800060cc:	000b0513          	mv	a0,s6
    800060d0:	ffffd097          	auipc	ra,0xffffd
    800060d4:	764080e7          	jalr	1892(ra) # 80003834 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800060d8:	00000493          	li	s1,0
    800060dc:	0380006f          	j	80006114 <_Z29producerConsumer_CPP_Sync_APIv+0x240>
    Producer(thread_data* _td):Thread(), td(_td) {}
    800060e0:	00007797          	auipc	a5,0x7
    800060e4:	1c078793          	addi	a5,a5,448 # 8000d2a0 <_ZTV8Producer+0x10>
    800060e8:	00fcb023          	sd	a5,0(s9)
    800060ec:	018cb823          	sd	s8,16(s9)
            threads[i] = new Producer(data+i);
    800060f0:	00349793          	slli	a5,s1,0x3
    800060f4:	00f987b3          	add	a5,s3,a5
    800060f8:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800060fc:	00349793          	slli	a5,s1,0x3
    80006100:	00f987b3          	add	a5,s3,a5
    80006104:	0007b503          	ld	a0,0(a5)
    80006108:	ffffd097          	auipc	ra,0xffffd
    8000610c:	72c080e7          	jalr	1836(ra) # 80003834 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80006110:	0014849b          	addiw	s1,s1,1
    80006114:	0b24d063          	bge	s1,s2,800061b4 <_Z29producerConsumer_CPP_Sync_APIv+0x2e0>
        data[i].id = i;
    80006118:	00149793          	slli	a5,s1,0x1
    8000611c:	009787b3          	add	a5,a5,s1
    80006120:	00379793          	slli	a5,a5,0x3
    80006124:	00fa07b3          	add	a5,s4,a5
    80006128:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    8000612c:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80006130:	0000b717          	auipc	a4,0xb
    80006134:	56073703          	ld	a4,1376(a4) # 80011690 <waitForAll>
    80006138:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    8000613c:	02905863          	blez	s1,8000616c <_Z29producerConsumer_CPP_Sync_APIv+0x298>
            threads[i] = new Producer(data+i);
    80006140:	01800513          	li	a0,24
    80006144:	ffffd097          	auipc	ra,0xffffd
    80006148:	45c080e7          	jalr	1116(ra) # 800035a0 <_Znwm>
    8000614c:	00050c93          	mv	s9,a0
    80006150:	00149c13          	slli	s8,s1,0x1
    80006154:	009c0c33          	add	s8,s8,s1
    80006158:	003c1c13          	slli	s8,s8,0x3
    8000615c:	018a0c33          	add	s8,s4,s8
    Producer(thread_data* _td):Thread(), td(_td) {}
    80006160:	ffffd097          	auipc	ra,0xffffd
    80006164:	600080e7          	jalr	1536(ra) # 80003760 <_ZN6ThreadC1Ev>
    80006168:	f79ff06f          	j	800060e0 <_Z29producerConsumer_CPP_Sync_APIv+0x20c>
            threads[i] = new ProducerKeyboard(data+i);
    8000616c:	01800513          	li	a0,24
    80006170:	ffffd097          	auipc	ra,0xffffd
    80006174:	430080e7          	jalr	1072(ra) # 800035a0 <_Znwm>
    80006178:	00050c93          	mv	s9,a0
    8000617c:	00149c13          	slli	s8,s1,0x1
    80006180:	009c0c33          	add	s8,s8,s1
    80006184:	003c1c13          	slli	s8,s8,0x3
    80006188:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    8000618c:	ffffd097          	auipc	ra,0xffffd
    80006190:	5d4080e7          	jalr	1492(ra) # 80003760 <_ZN6ThreadC1Ev>
    80006194:	00007797          	auipc	a5,0x7
    80006198:	0e478793          	addi	a5,a5,228 # 8000d278 <_ZTV16ProducerKeyboard+0x10>
    8000619c:	00fcb023          	sd	a5,0(s9)
    800061a0:	018cb823          	sd	s8,16(s9)
            threads[i] = new ProducerKeyboard(data+i);
    800061a4:	00349793          	slli	a5,s1,0x3
    800061a8:	00f987b3          	add	a5,s3,a5
    800061ac:	0197b023          	sd	s9,0(a5)
    800061b0:	f4dff06f          	j	800060fc <_Z29producerConsumer_CPP_Sync_APIv+0x228>
    Thread::dispatch();
    800061b4:	ffffd097          	auipc	ra,0xffffd
    800061b8:	658080e7          	jalr	1624(ra) # 8000380c <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    800061bc:	00000493          	li	s1,0
    800061c0:	00994e63          	blt	s2,s1,800061dc <_Z29producerConsumer_CPP_Sync_APIv+0x308>
        waitForAll->wait();
    800061c4:	0000b517          	auipc	a0,0xb
    800061c8:	4cc53503          	ld	a0,1228(a0) # 80011690 <waitForAll>
    800061cc:	ffffd097          	auipc	ra,0xffffd
    800061d0:	504080e7          	jalr	1284(ra) # 800036d0 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800061d4:	0014849b          	addiw	s1,s1,1
    800061d8:	fe9ff06f          	j	800061c0 <_Z29producerConsumer_CPP_Sync_APIv+0x2ec>
    for (int i = 0; i < threadNum; i++) {
    800061dc:	00000493          	li	s1,0
    800061e0:	0080006f          	j	800061e8 <_Z29producerConsumer_CPP_Sync_APIv+0x314>
    800061e4:	0014849b          	addiw	s1,s1,1
    800061e8:	0324d263          	bge	s1,s2,8000620c <_Z29producerConsumer_CPP_Sync_APIv+0x338>
        delete threads[i];
    800061ec:	00349793          	slli	a5,s1,0x3
    800061f0:	00f987b3          	add	a5,s3,a5
    800061f4:	0007b503          	ld	a0,0(a5)
    800061f8:	fe0506e3          	beqz	a0,800061e4 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    800061fc:	00053783          	ld	a5,0(a0)
    80006200:	0087b783          	ld	a5,8(a5)
    80006204:	000780e7          	jalr	a5
    80006208:	fddff06f          	j	800061e4 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    delete consumerThread;
    8000620c:	000b0a63          	beqz	s6,80006220 <_Z29producerConsumer_CPP_Sync_APIv+0x34c>
    80006210:	000b3783          	ld	a5,0(s6)
    80006214:	0087b783          	ld	a5,8(a5)
    80006218:	000b0513          	mv	a0,s6
    8000621c:	000780e7          	jalr	a5
    delete waitForAll;
    80006220:	0000b517          	auipc	a0,0xb
    80006224:	47053503          	ld	a0,1136(a0) # 80011690 <waitForAll>
    80006228:	00050863          	beqz	a0,80006238 <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    8000622c:	00053783          	ld	a5,0(a0)
    80006230:	0087b783          	ld	a5,8(a5)
    80006234:	000780e7          	jalr	a5
    delete buffer;
    80006238:	000a8e63          	beqz	s5,80006254 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    8000623c:	000a8513          	mv	a0,s5
    80006240:	fffff097          	auipc	ra,0xfffff
    80006244:	1bc080e7          	jalr	444(ra) # 800053fc <_ZN9BufferCPPD1Ev>
    80006248:	000a8513          	mv	a0,s5
    8000624c:	ffffd097          	auipc	ra,0xffffd
    80006250:	3a4080e7          	jalr	932(ra) # 800035f0 <_ZdlPv>
    80006254:	000b8113          	mv	sp,s7

}
    80006258:	f8040113          	addi	sp,s0,-128
    8000625c:	07813083          	ld	ra,120(sp)
    80006260:	07013403          	ld	s0,112(sp)
    80006264:	06813483          	ld	s1,104(sp)
    80006268:	06013903          	ld	s2,96(sp)
    8000626c:	05813983          	ld	s3,88(sp)
    80006270:	05013a03          	ld	s4,80(sp)
    80006274:	04813a83          	ld	s5,72(sp)
    80006278:	04013b03          	ld	s6,64(sp)
    8000627c:	03813b83          	ld	s7,56(sp)
    80006280:	03013c03          	ld	s8,48(sp)
    80006284:	02813c83          	ld	s9,40(sp)
    80006288:	08010113          	addi	sp,sp,128
    8000628c:	00008067          	ret
    80006290:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80006294:	000a8513          	mv	a0,s5
    80006298:	ffffd097          	auipc	ra,0xffffd
    8000629c:	358080e7          	jalr	856(ra) # 800035f0 <_ZdlPv>
    800062a0:	00048513          	mv	a0,s1
    800062a4:	0000c097          	auipc	ra,0xc
    800062a8:	4c4080e7          	jalr	1220(ra) # 80012768 <_Unwind_Resume>
    800062ac:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    800062b0:	00048513          	mv	a0,s1
    800062b4:	ffffd097          	auipc	ra,0xffffd
    800062b8:	33c080e7          	jalr	828(ra) # 800035f0 <_ZdlPv>
    800062bc:	00090513          	mv	a0,s2
    800062c0:	0000c097          	auipc	ra,0xc
    800062c4:	4a8080e7          	jalr	1192(ra) # 80012768 <_Unwind_Resume>
    800062c8:	00050493          	mv	s1,a0
    consumerThread = new Consumer(data+threadNum);
    800062cc:	000b0513          	mv	a0,s6
    800062d0:	ffffd097          	auipc	ra,0xffffd
    800062d4:	320080e7          	jalr	800(ra) # 800035f0 <_ZdlPv>
    800062d8:	00048513          	mv	a0,s1
    800062dc:	0000c097          	auipc	ra,0xc
    800062e0:	48c080e7          	jalr	1164(ra) # 80012768 <_Unwind_Resume>
    800062e4:	00050493          	mv	s1,a0
            threads[i] = new Producer(data+i);
    800062e8:	000c8513          	mv	a0,s9
    800062ec:	ffffd097          	auipc	ra,0xffffd
    800062f0:	304080e7          	jalr	772(ra) # 800035f0 <_ZdlPv>
    800062f4:	00048513          	mv	a0,s1
    800062f8:	0000c097          	auipc	ra,0xc
    800062fc:	470080e7          	jalr	1136(ra) # 80012768 <_Unwind_Resume>
    80006300:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80006304:	000c8513          	mv	a0,s9
    80006308:	ffffd097          	auipc	ra,0xffffd
    8000630c:	2e8080e7          	jalr	744(ra) # 800035f0 <_ZdlPv>
    80006310:	00048513          	mv	a0,s1
    80006314:	0000c097          	auipc	ra,0xc
    80006318:	454080e7          	jalr	1108(ra) # 80012768 <_Unwind_Resume>

000000008000631c <_Z12testSleepingv>:

void testSleeping() {
    8000631c:	fc010113          	addi	sp,sp,-64
    80006320:	02113c23          	sd	ra,56(sp)
    80006324:	02813823          	sd	s0,48(sp)
    80006328:	02913423          	sd	s1,40(sp)
    8000632c:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80006330:	00a00793          	li	a5,10
    80006334:	fcf43823          	sd	a5,-48(s0)
    80006338:	01400793          	li	a5,20
    8000633c:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80006340:	00000493          	li	s1,0
    80006344:	02c0006f          	j	80006370 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80006348:	00349793          	slli	a5,s1,0x3
    8000634c:	fd040613          	addi	a2,s0,-48
    80006350:	00f60633          	add	a2,a2,a5
    80006354:	fffff597          	auipc	a1,0xfffff
    80006358:	1a858593          	addi	a1,a1,424 # 800054fc <_Z9sleepyRunPv>
    8000635c:	fc040513          	addi	a0,s0,-64
    80006360:	00f50533          	add	a0,a0,a5
    80006364:	ffffc097          	auipc	ra,0xffffc
    80006368:	a88080e7          	jalr	-1400(ra) # 80001dec <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    8000636c:	0014849b          	addiw	s1,s1,1
    80006370:	00100793          	li	a5,1
    80006374:	fc97dae3          	bge	a5,s1,80006348 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80006378:	0000b797          	auipc	a5,0xb
    8000637c:	3087c783          	lbu	a5,776(a5) # 80011680 <finished>
    80006380:	fe078ce3          	beqz	a5,80006378 <_Z12testSleepingv+0x5c>
    80006384:	0000b797          	auipc	a5,0xb
    80006388:	2fd7c783          	lbu	a5,765(a5) # 80011681 <finished+0x1>
    8000638c:	fe0786e3          	beqz	a5,80006378 <_Z12testSleepingv+0x5c>
}
    80006390:	03813083          	ld	ra,56(sp)
    80006394:	03013403          	ld	s0,48(sp)
    80006398:	02813483          	ld	s1,40(sp)
    8000639c:	04010113          	addi	sp,sp,64
    800063a0:	00008067          	ret

00000000800063a4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    800063a4:	f8010113          	addi	sp,sp,-128
    800063a8:	06113c23          	sd	ra,120(sp)
    800063ac:	06813823          	sd	s0,112(sp)
    800063b0:	06913423          	sd	s1,104(sp)
    800063b4:	07213023          	sd	s2,96(sp)
    800063b8:	05313c23          	sd	s3,88(sp)
    800063bc:	05413823          	sd	s4,80(sp)
    800063c0:	05513423          	sd	s5,72(sp)
    800063c4:	05613023          	sd	s6,64(sp)
    800063c8:	03713c23          	sd	s7,56(sp)
    800063cc:	03813823          	sd	s8,48(sp)
    800063d0:	03913423          	sd	s9,40(sp)
    800063d4:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    800063d8:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    800063dc:	00004517          	auipc	a0,0x4
    800063e0:	2ac50513          	addi	a0,a0,684 # 8000a688 <CONSOLE_STATUS+0x678>
    800063e4:	ffffc097          	auipc	ra,0xffffc
    800063e8:	490080e7          	jalr	1168(ra) # 80002874 <_Z11printStringPKc>
        getString(input, 30);
    800063ec:	01e00593          	li	a1,30
    800063f0:	f8040493          	addi	s1,s0,-128
    800063f4:	00048513          	mv	a0,s1
    800063f8:	ffffc097          	auipc	ra,0xffffc
    800063fc:	4f8080e7          	jalr	1272(ra) # 800028f0 <_Z9getStringPci>
        threadNum = stringToInt(input);
    80006400:	00048513          	mv	a0,s1
    80006404:	ffffc097          	auipc	ra,0xffffc
    80006408:	5b8080e7          	jalr	1464(ra) # 800029bc <_Z11stringToIntPKc>
    8000640c:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    80006410:	00004517          	auipc	a0,0x4
    80006414:	29850513          	addi	a0,a0,664 # 8000a6a8 <CONSOLE_STATUS+0x698>
    80006418:	ffffc097          	auipc	ra,0xffffc
    8000641c:	45c080e7          	jalr	1116(ra) # 80002874 <_Z11printStringPKc>
        getString(input, 30);
    80006420:	01e00593          	li	a1,30
    80006424:	00048513          	mv	a0,s1
    80006428:	ffffc097          	auipc	ra,0xffffc
    8000642c:	4c8080e7          	jalr	1224(ra) # 800028f0 <_Z9getStringPci>
        n = stringToInt(input);
    80006430:	00048513          	mv	a0,s1
    80006434:	ffffc097          	auipc	ra,0xffffc
    80006438:	588080e7          	jalr	1416(ra) # 800029bc <_Z11stringToIntPKc>
    8000643c:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80006440:	00004517          	auipc	a0,0x4
    80006444:	28850513          	addi	a0,a0,648 # 8000a6c8 <CONSOLE_STATUS+0x6b8>
    80006448:	ffffc097          	auipc	ra,0xffffc
    8000644c:	42c080e7          	jalr	1068(ra) # 80002874 <_Z11printStringPKc>
    80006450:	00000613          	li	a2,0
    80006454:	00a00593          	li	a1,10
    80006458:	00098513          	mv	a0,s3
    8000645c:	ffffc097          	auipc	ra,0xffffc
    80006460:	5b0080e7          	jalr	1456(ra) # 80002a0c <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    80006464:	00004517          	auipc	a0,0x4
    80006468:	27c50513          	addi	a0,a0,636 # 8000a6e0 <CONSOLE_STATUS+0x6d0>
    8000646c:	ffffc097          	auipc	ra,0xffffc
    80006470:	408080e7          	jalr	1032(ra) # 80002874 <_Z11printStringPKc>
    80006474:	00000613          	li	a2,0
    80006478:	00a00593          	li	a1,10
    8000647c:	00048513          	mv	a0,s1
    80006480:	ffffc097          	auipc	ra,0xffffc
    80006484:	58c080e7          	jalr	1420(ra) # 80002a0c <_Z8printIntiii>
        printString(".\n");
    80006488:	00004517          	auipc	a0,0x4
    8000648c:	f2850513          	addi	a0,a0,-216 # 8000a3b0 <CONSOLE_STATUS+0x3a0>
    80006490:	ffffc097          	auipc	ra,0xffffc
    80006494:	3e4080e7          	jalr	996(ra) # 80002874 <_Z11printStringPKc>
        if(threadNum > n) {
    80006498:	0334c463          	blt	s1,s3,800064c0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    8000649c:	03305c63          	blez	s3,800064d4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    800064a0:	03800513          	li	a0,56
    800064a4:	ffffd097          	auipc	ra,0xffffd
    800064a8:	0fc080e7          	jalr	252(ra) # 800035a0 <_Znwm>
    800064ac:	00050a93          	mv	s5,a0
    800064b0:	00048593          	mv	a1,s1
    800064b4:	fffff097          	auipc	ra,0xfffff
    800064b8:	c50080e7          	jalr	-944(ra) # 80005104 <_ZN9BufferCPPC1Ei>
    800064bc:	0300006f          	j	800064ec <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800064c0:	00004517          	auipc	a0,0x4
    800064c4:	23850513          	addi	a0,a0,568 # 8000a6f8 <CONSOLE_STATUS+0x6e8>
    800064c8:	ffffc097          	auipc	ra,0xffffc
    800064cc:	3ac080e7          	jalr	940(ra) # 80002874 <_Z11printStringPKc>
            return;
    800064d0:	0140006f          	j	800064e4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    800064d4:	00004517          	auipc	a0,0x4
    800064d8:	26450513          	addi	a0,a0,612 # 8000a738 <CONSOLE_STATUS+0x728>
    800064dc:	ffffc097          	auipc	ra,0xffffc
    800064e0:	398080e7          	jalr	920(ra) # 80002874 <_Z11printStringPKc>
            return;
    800064e4:	000c0113          	mv	sp,s8
    800064e8:	21c0006f          	j	80006704 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    800064ec:	01000513          	li	a0,16
    800064f0:	ffffd097          	auipc	ra,0xffffd
    800064f4:	0b0080e7          	jalr	176(ra) # 800035a0 <_Znwm>
    800064f8:	00050493          	mv	s1,a0
    800064fc:	00000593          	li	a1,0
    80006500:	ffffd097          	auipc	ra,0xffffd
    80006504:	198080e7          	jalr	408(ra) # 80003698 <_ZN9SemaphoreC1Ej>
    80006508:	0000b717          	auipc	a4,0xb
    8000650c:	17070713          	addi	a4,a4,368 # 80011678 <_ZN19ConsumerProducerCPP9threadEndE>
    80006510:	02973023          	sd	s1,32(a4)
        Thread *producers[threadNum];
    80006514:	00399793          	slli	a5,s3,0x3
    80006518:	00f78793          	addi	a5,a5,15
    8000651c:	ff07f793          	andi	a5,a5,-16
    80006520:	40f10133          	sub	sp,sp,a5
    80006524:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80006528:	0019869b          	addiw	a3,s3,1
    8000652c:	00169793          	slli	a5,a3,0x1
    80006530:	00d787b3          	add	a5,a5,a3
    80006534:	00379793          	slli	a5,a5,0x3
    80006538:	00f78793          	addi	a5,a5,15
    8000653c:	ff07f793          	andi	a5,a5,-16
    80006540:	40f10133          	sub	sp,sp,a5
    80006544:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    80006548:	00199493          	slli	s1,s3,0x1
    8000654c:	013484b3          	add	s1,s1,s3
    80006550:	00349493          	slli	s1,s1,0x3
    80006554:	009b04b3          	add	s1,s6,s1
    80006558:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    8000655c:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80006560:	02073783          	ld	a5,32(a4)
    80006564:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80006568:	01800513          	li	a0,24
    8000656c:	ffffd097          	auipc	ra,0xffffd
    80006570:	034080e7          	jalr	52(ra) # 800035a0 <_Znwm>
    80006574:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    80006578:	ffffd097          	auipc	ra,0xffffd
    8000657c:	1e8080e7          	jalr	488(ra) # 80003760 <_ZN6ThreadC1Ev>
    80006580:	00007797          	auipc	a5,0x7
    80006584:	dc078793          	addi	a5,a5,-576 # 8000d340 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006588:	00fbb023          	sd	a5,0(s7)
    8000658c:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80006590:	000b8513          	mv	a0,s7
    80006594:	ffffd097          	auipc	ra,0xffffd
    80006598:	2a0080e7          	jalr	672(ra) # 80003834 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    8000659c:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    800065a0:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    800065a4:	0000b797          	auipc	a5,0xb
    800065a8:	0f47b783          	ld	a5,244(a5) # 80011698 <_ZN19ConsumerProducerCPP10waitForAllE>
    800065ac:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    800065b0:	01800513          	li	a0,24
    800065b4:	ffffd097          	auipc	ra,0xffffd
    800065b8:	fec080e7          	jalr	-20(ra) # 800035a0 <_Znwm>
    800065bc:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    800065c0:	ffffd097          	auipc	ra,0xffffd
    800065c4:	1a0080e7          	jalr	416(ra) # 80003760 <_ZN6ThreadC1Ev>
    800065c8:	00007797          	auipc	a5,0x7
    800065cc:	d2878793          	addi	a5,a5,-728 # 8000d2f0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800065d0:	00f4b023          	sd	a5,0(s1)
    800065d4:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    800065d8:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    800065dc:	00048513          	mv	a0,s1
    800065e0:	ffffd097          	auipc	ra,0xffffd
    800065e4:	254080e7          	jalr	596(ra) # 80003834 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    800065e8:	00100913          	li	s2,1
    800065ec:	0300006f          	j	8000661c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800065f0:	00007797          	auipc	a5,0x7
    800065f4:	d2878793          	addi	a5,a5,-728 # 8000d318 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800065f8:	00fcb023          	sd	a5,0(s9)
    800065fc:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    80006600:	00391793          	slli	a5,s2,0x3
    80006604:	00fa07b3          	add	a5,s4,a5
    80006608:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    8000660c:	000c8513          	mv	a0,s9
    80006610:	ffffd097          	auipc	ra,0xffffd
    80006614:	224080e7          	jalr	548(ra) # 80003834 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80006618:	0019091b          	addiw	s2,s2,1
    8000661c:	05395263          	bge	s2,s3,80006660 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    80006620:	00191493          	slli	s1,s2,0x1
    80006624:	012484b3          	add	s1,s1,s2
    80006628:	00349493          	slli	s1,s1,0x3
    8000662c:	009b04b3          	add	s1,s6,s1
    80006630:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    80006634:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    80006638:	0000b797          	auipc	a5,0xb
    8000663c:	0607b783          	ld	a5,96(a5) # 80011698 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006640:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    80006644:	01800513          	li	a0,24
    80006648:	ffffd097          	auipc	ra,0xffffd
    8000664c:	f58080e7          	jalr	-168(ra) # 800035a0 <_Znwm>
    80006650:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80006654:	ffffd097          	auipc	ra,0xffffd
    80006658:	10c080e7          	jalr	268(ra) # 80003760 <_ZN6ThreadC1Ev>
    8000665c:	f95ff06f          	j	800065f0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80006660:	ffffd097          	auipc	ra,0xffffd
    80006664:	1ac080e7          	jalr	428(ra) # 8000380c <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    80006668:	00000493          	li	s1,0
    8000666c:	0099ce63          	blt	s3,s1,80006688 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80006670:	0000b517          	auipc	a0,0xb
    80006674:	02853503          	ld	a0,40(a0) # 80011698 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006678:	ffffd097          	auipc	ra,0xffffd
    8000667c:	058080e7          	jalr	88(ra) # 800036d0 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80006680:	0014849b          	addiw	s1,s1,1
    80006684:	fe9ff06f          	j	8000666c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    80006688:	0000b517          	auipc	a0,0xb
    8000668c:	01053503          	ld	a0,16(a0) # 80011698 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006690:	00050863          	beqz	a0,800066a0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80006694:	00053783          	ld	a5,0(a0)
    80006698:	0087b783          	ld	a5,8(a5)
    8000669c:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    800066a0:	00000493          	li	s1,0
    800066a4:	0080006f          	j	800066ac <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    800066a8:	0014849b          	addiw	s1,s1,1
    800066ac:	0334d263          	bge	s1,s3,800066d0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    800066b0:	00349793          	slli	a5,s1,0x3
    800066b4:	00fa07b3          	add	a5,s4,a5
    800066b8:	0007b503          	ld	a0,0(a5)
    800066bc:	fe0506e3          	beqz	a0,800066a8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    800066c0:	00053783          	ld	a5,0(a0)
    800066c4:	0087b783          	ld	a5,8(a5)
    800066c8:	000780e7          	jalr	a5
    800066cc:	fddff06f          	j	800066a8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    800066d0:	000b8a63          	beqz	s7,800066e4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    800066d4:	000bb783          	ld	a5,0(s7)
    800066d8:	0087b783          	ld	a5,8(a5)
    800066dc:	000b8513          	mv	a0,s7
    800066e0:	000780e7          	jalr	a5
        delete buffer;
    800066e4:	000a8e63          	beqz	s5,80006700 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    800066e8:	000a8513          	mv	a0,s5
    800066ec:	fffff097          	auipc	ra,0xfffff
    800066f0:	d10080e7          	jalr	-752(ra) # 800053fc <_ZN9BufferCPPD1Ev>
    800066f4:	000a8513          	mv	a0,s5
    800066f8:	ffffd097          	auipc	ra,0xffffd
    800066fc:	ef8080e7          	jalr	-264(ra) # 800035f0 <_ZdlPv>
    80006700:	000c0113          	mv	sp,s8
    }
    80006704:	f8040113          	addi	sp,s0,-128
    80006708:	07813083          	ld	ra,120(sp)
    8000670c:	07013403          	ld	s0,112(sp)
    80006710:	06813483          	ld	s1,104(sp)
    80006714:	06013903          	ld	s2,96(sp)
    80006718:	05813983          	ld	s3,88(sp)
    8000671c:	05013a03          	ld	s4,80(sp)
    80006720:	04813a83          	ld	s5,72(sp)
    80006724:	04013b03          	ld	s6,64(sp)
    80006728:	03813b83          	ld	s7,56(sp)
    8000672c:	03013c03          	ld	s8,48(sp)
    80006730:	02813c83          	ld	s9,40(sp)
    80006734:	08010113          	addi	sp,sp,128
    80006738:	00008067          	ret
    8000673c:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80006740:	000a8513          	mv	a0,s5
    80006744:	ffffd097          	auipc	ra,0xffffd
    80006748:	eac080e7          	jalr	-340(ra) # 800035f0 <_ZdlPv>
    8000674c:	00048513          	mv	a0,s1
    80006750:	0000c097          	auipc	ra,0xc
    80006754:	018080e7          	jalr	24(ra) # 80012768 <_Unwind_Resume>
    80006758:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    8000675c:	00048513          	mv	a0,s1
    80006760:	ffffd097          	auipc	ra,0xffffd
    80006764:	e90080e7          	jalr	-368(ra) # 800035f0 <_ZdlPv>
    80006768:	00090513          	mv	a0,s2
    8000676c:	0000c097          	auipc	ra,0xc
    80006770:	ffc080e7          	jalr	-4(ra) # 80012768 <_Unwind_Resume>
    80006774:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80006778:	000b8513          	mv	a0,s7
    8000677c:	ffffd097          	auipc	ra,0xffffd
    80006780:	e74080e7          	jalr	-396(ra) # 800035f0 <_ZdlPv>
    80006784:	00048513          	mv	a0,s1
    80006788:	0000c097          	auipc	ra,0xc
    8000678c:	fe0080e7          	jalr	-32(ra) # 80012768 <_Unwind_Resume>
    80006790:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006794:	00048513          	mv	a0,s1
    80006798:	ffffd097          	auipc	ra,0xffffd
    8000679c:	e58080e7          	jalr	-424(ra) # 800035f0 <_ZdlPv>
    800067a0:	00090513          	mv	a0,s2
    800067a4:	0000c097          	auipc	ra,0xc
    800067a8:	fc4080e7          	jalr	-60(ra) # 80012768 <_Unwind_Resume>
    800067ac:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    800067b0:	000c8513          	mv	a0,s9
    800067b4:	ffffd097          	auipc	ra,0xffffd
    800067b8:	e3c080e7          	jalr	-452(ra) # 800035f0 <_ZdlPv>
    800067bc:	00048513          	mv	a0,s1
    800067c0:	0000c097          	auipc	ra,0xc
    800067c4:	fa8080e7          	jalr	-88(ra) # 80012768 <_Unwind_Resume>

00000000800067c8 <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    800067c8:	ff010113          	addi	sp,sp,-16
    800067cc:	00813423          	sd	s0,8(sp)
    800067d0:	01010413          	addi	s0,sp,16
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    800067d4:	00813403          	ld	s0,8(sp)
    800067d8:	01010113          	addi	sp,sp,16
    800067dc:	00008067          	ret

00000000800067e0 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    800067e0:	ff010113          	addi	sp,sp,-16
    800067e4:	00113423          	sd	ra,8(sp)
    800067e8:	00813023          	sd	s0,0(sp)
    800067ec:	01010413          	addi	s0,sp,16
    800067f0:	00007797          	auipc	a5,0x7
    800067f4:	9e878793          	addi	a5,a5,-1560 # 8000d1d8 <_ZTV7WorkerA+0x10>
    800067f8:	00f53023          	sd	a5,0(a0)
    800067fc:	ffffd097          	auipc	ra,0xffffd
    80006800:	d64080e7          	jalr	-668(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006804:	00813083          	ld	ra,8(sp)
    80006808:	00013403          	ld	s0,0(sp)
    8000680c:	01010113          	addi	sp,sp,16
    80006810:	00008067          	ret

0000000080006814 <_ZN7WorkerAD0Ev>:
    80006814:	fe010113          	addi	sp,sp,-32
    80006818:	00113c23          	sd	ra,24(sp)
    8000681c:	00813823          	sd	s0,16(sp)
    80006820:	00913423          	sd	s1,8(sp)
    80006824:	02010413          	addi	s0,sp,32
    80006828:	00050493          	mv	s1,a0
    8000682c:	00007797          	auipc	a5,0x7
    80006830:	9ac78793          	addi	a5,a5,-1620 # 8000d1d8 <_ZTV7WorkerA+0x10>
    80006834:	00f53023          	sd	a5,0(a0)
    80006838:	ffffd097          	auipc	ra,0xffffd
    8000683c:	d28080e7          	jalr	-728(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006840:	00048513          	mv	a0,s1
    80006844:	ffffd097          	auipc	ra,0xffffd
    80006848:	dac080e7          	jalr	-596(ra) # 800035f0 <_ZdlPv>
    8000684c:	01813083          	ld	ra,24(sp)
    80006850:	01013403          	ld	s0,16(sp)
    80006854:	00813483          	ld	s1,8(sp)
    80006858:	02010113          	addi	sp,sp,32
    8000685c:	00008067          	ret

0000000080006860 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80006860:	ff010113          	addi	sp,sp,-16
    80006864:	00113423          	sd	ra,8(sp)
    80006868:	00813023          	sd	s0,0(sp)
    8000686c:	01010413          	addi	s0,sp,16
    80006870:	00007797          	auipc	a5,0x7
    80006874:	99078793          	addi	a5,a5,-1648 # 8000d200 <_ZTV7WorkerB+0x10>
    80006878:	00f53023          	sd	a5,0(a0)
    8000687c:	ffffd097          	auipc	ra,0xffffd
    80006880:	ce4080e7          	jalr	-796(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006884:	00813083          	ld	ra,8(sp)
    80006888:	00013403          	ld	s0,0(sp)
    8000688c:	01010113          	addi	sp,sp,16
    80006890:	00008067          	ret

0000000080006894 <_ZN7WorkerBD0Ev>:
    80006894:	fe010113          	addi	sp,sp,-32
    80006898:	00113c23          	sd	ra,24(sp)
    8000689c:	00813823          	sd	s0,16(sp)
    800068a0:	00913423          	sd	s1,8(sp)
    800068a4:	02010413          	addi	s0,sp,32
    800068a8:	00050493          	mv	s1,a0
    800068ac:	00007797          	auipc	a5,0x7
    800068b0:	95478793          	addi	a5,a5,-1708 # 8000d200 <_ZTV7WorkerB+0x10>
    800068b4:	00f53023          	sd	a5,0(a0)
    800068b8:	ffffd097          	auipc	ra,0xffffd
    800068bc:	ca8080e7          	jalr	-856(ra) # 80003560 <_ZN6ThreadD1Ev>
    800068c0:	00048513          	mv	a0,s1
    800068c4:	ffffd097          	auipc	ra,0xffffd
    800068c8:	d2c080e7          	jalr	-724(ra) # 800035f0 <_ZdlPv>
    800068cc:	01813083          	ld	ra,24(sp)
    800068d0:	01013403          	ld	s0,16(sp)
    800068d4:	00813483          	ld	s1,8(sp)
    800068d8:	02010113          	addi	sp,sp,32
    800068dc:	00008067          	ret

00000000800068e0 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    800068e0:	ff010113          	addi	sp,sp,-16
    800068e4:	00113423          	sd	ra,8(sp)
    800068e8:	00813023          	sd	s0,0(sp)
    800068ec:	01010413          	addi	s0,sp,16
    800068f0:	00007797          	auipc	a5,0x7
    800068f4:	93878793          	addi	a5,a5,-1736 # 8000d228 <_ZTV7WorkerC+0x10>
    800068f8:	00f53023          	sd	a5,0(a0)
    800068fc:	ffffd097          	auipc	ra,0xffffd
    80006900:	c64080e7          	jalr	-924(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006904:	00813083          	ld	ra,8(sp)
    80006908:	00013403          	ld	s0,0(sp)
    8000690c:	01010113          	addi	sp,sp,16
    80006910:	00008067          	ret

0000000080006914 <_ZN7WorkerCD0Ev>:
    80006914:	fe010113          	addi	sp,sp,-32
    80006918:	00113c23          	sd	ra,24(sp)
    8000691c:	00813823          	sd	s0,16(sp)
    80006920:	00913423          	sd	s1,8(sp)
    80006924:	02010413          	addi	s0,sp,32
    80006928:	00050493          	mv	s1,a0
    8000692c:	00007797          	auipc	a5,0x7
    80006930:	8fc78793          	addi	a5,a5,-1796 # 8000d228 <_ZTV7WorkerC+0x10>
    80006934:	00f53023          	sd	a5,0(a0)
    80006938:	ffffd097          	auipc	ra,0xffffd
    8000693c:	c28080e7          	jalr	-984(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006940:	00048513          	mv	a0,s1
    80006944:	ffffd097          	auipc	ra,0xffffd
    80006948:	cac080e7          	jalr	-852(ra) # 800035f0 <_ZdlPv>
    8000694c:	01813083          	ld	ra,24(sp)
    80006950:	01013403          	ld	s0,16(sp)
    80006954:	00813483          	ld	s1,8(sp)
    80006958:	02010113          	addi	sp,sp,32
    8000695c:	00008067          	ret

0000000080006960 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80006960:	ff010113          	addi	sp,sp,-16
    80006964:	00113423          	sd	ra,8(sp)
    80006968:	00813023          	sd	s0,0(sp)
    8000696c:	01010413          	addi	s0,sp,16
    80006970:	00007797          	auipc	a5,0x7
    80006974:	8e078793          	addi	a5,a5,-1824 # 8000d250 <_ZTV7WorkerD+0x10>
    80006978:	00f53023          	sd	a5,0(a0)
    8000697c:	ffffd097          	auipc	ra,0xffffd
    80006980:	be4080e7          	jalr	-1052(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006984:	00813083          	ld	ra,8(sp)
    80006988:	00013403          	ld	s0,0(sp)
    8000698c:	01010113          	addi	sp,sp,16
    80006990:	00008067          	ret

0000000080006994 <_ZN7WorkerDD0Ev>:
    80006994:	fe010113          	addi	sp,sp,-32
    80006998:	00113c23          	sd	ra,24(sp)
    8000699c:	00813823          	sd	s0,16(sp)
    800069a0:	00913423          	sd	s1,8(sp)
    800069a4:	02010413          	addi	s0,sp,32
    800069a8:	00050493          	mv	s1,a0
    800069ac:	00007797          	auipc	a5,0x7
    800069b0:	8a478793          	addi	a5,a5,-1884 # 8000d250 <_ZTV7WorkerD+0x10>
    800069b4:	00f53023          	sd	a5,0(a0)
    800069b8:	ffffd097          	auipc	ra,0xffffd
    800069bc:	ba8080e7          	jalr	-1112(ra) # 80003560 <_ZN6ThreadD1Ev>
    800069c0:	00048513          	mv	a0,s1
    800069c4:	ffffd097          	auipc	ra,0xffffd
    800069c8:	c2c080e7          	jalr	-980(ra) # 800035f0 <_ZdlPv>
    800069cc:	01813083          	ld	ra,24(sp)
    800069d0:	01013403          	ld	s0,16(sp)
    800069d4:	00813483          	ld	s1,8(sp)
    800069d8:	02010113          	addi	sp,sp,32
    800069dc:	00008067          	ret

00000000800069e0 <_ZN8ConsumerD1Ev>:
class Consumer:public Thread {
    800069e0:	ff010113          	addi	sp,sp,-16
    800069e4:	00113423          	sd	ra,8(sp)
    800069e8:	00813023          	sd	s0,0(sp)
    800069ec:	01010413          	addi	s0,sp,16
    800069f0:	00007797          	auipc	a5,0x7
    800069f4:	8d878793          	addi	a5,a5,-1832 # 8000d2c8 <_ZTV8Consumer+0x10>
    800069f8:	00f53023          	sd	a5,0(a0)
    800069fc:	ffffd097          	auipc	ra,0xffffd
    80006a00:	b64080e7          	jalr	-1180(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006a04:	00813083          	ld	ra,8(sp)
    80006a08:	00013403          	ld	s0,0(sp)
    80006a0c:	01010113          	addi	sp,sp,16
    80006a10:	00008067          	ret

0000000080006a14 <_ZN8ConsumerD0Ev>:
    80006a14:	fe010113          	addi	sp,sp,-32
    80006a18:	00113c23          	sd	ra,24(sp)
    80006a1c:	00813823          	sd	s0,16(sp)
    80006a20:	00913423          	sd	s1,8(sp)
    80006a24:	02010413          	addi	s0,sp,32
    80006a28:	00050493          	mv	s1,a0
    80006a2c:	00007797          	auipc	a5,0x7
    80006a30:	89c78793          	addi	a5,a5,-1892 # 8000d2c8 <_ZTV8Consumer+0x10>
    80006a34:	00f53023          	sd	a5,0(a0)
    80006a38:	ffffd097          	auipc	ra,0xffffd
    80006a3c:	b28080e7          	jalr	-1240(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006a40:	00048513          	mv	a0,s1
    80006a44:	ffffd097          	auipc	ra,0xffffd
    80006a48:	bac080e7          	jalr	-1108(ra) # 800035f0 <_ZdlPv>
    80006a4c:	01813083          	ld	ra,24(sp)
    80006a50:	01013403          	ld	s0,16(sp)
    80006a54:	00813483          	ld	s1,8(sp)
    80006a58:	02010113          	addi	sp,sp,32
    80006a5c:	00008067          	ret

0000000080006a60 <_ZN8ProducerD1Ev>:
class Producer:public Thread {
    80006a60:	ff010113          	addi	sp,sp,-16
    80006a64:	00113423          	sd	ra,8(sp)
    80006a68:	00813023          	sd	s0,0(sp)
    80006a6c:	01010413          	addi	s0,sp,16
    80006a70:	00007797          	auipc	a5,0x7
    80006a74:	83078793          	addi	a5,a5,-2000 # 8000d2a0 <_ZTV8Producer+0x10>
    80006a78:	00f53023          	sd	a5,0(a0)
    80006a7c:	ffffd097          	auipc	ra,0xffffd
    80006a80:	ae4080e7          	jalr	-1308(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006a84:	00813083          	ld	ra,8(sp)
    80006a88:	00013403          	ld	s0,0(sp)
    80006a8c:	01010113          	addi	sp,sp,16
    80006a90:	00008067          	ret

0000000080006a94 <_ZN8ProducerD0Ev>:
    80006a94:	fe010113          	addi	sp,sp,-32
    80006a98:	00113c23          	sd	ra,24(sp)
    80006a9c:	00813823          	sd	s0,16(sp)
    80006aa0:	00913423          	sd	s1,8(sp)
    80006aa4:	02010413          	addi	s0,sp,32
    80006aa8:	00050493          	mv	s1,a0
    80006aac:	00006797          	auipc	a5,0x6
    80006ab0:	7f478793          	addi	a5,a5,2036 # 8000d2a0 <_ZTV8Producer+0x10>
    80006ab4:	00f53023          	sd	a5,0(a0)
    80006ab8:	ffffd097          	auipc	ra,0xffffd
    80006abc:	aa8080e7          	jalr	-1368(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006ac0:	00048513          	mv	a0,s1
    80006ac4:	ffffd097          	auipc	ra,0xffffd
    80006ac8:	b2c080e7          	jalr	-1236(ra) # 800035f0 <_ZdlPv>
    80006acc:	01813083          	ld	ra,24(sp)
    80006ad0:	01013403          	ld	s0,16(sp)
    80006ad4:	00813483          	ld	s1,8(sp)
    80006ad8:	02010113          	addi	sp,sp,32
    80006adc:	00008067          	ret

0000000080006ae0 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80006ae0:	ff010113          	addi	sp,sp,-16
    80006ae4:	00113423          	sd	ra,8(sp)
    80006ae8:	00813023          	sd	s0,0(sp)
    80006aec:	01010413          	addi	s0,sp,16
    80006af0:	00006797          	auipc	a5,0x6
    80006af4:	78878793          	addi	a5,a5,1928 # 8000d278 <_ZTV16ProducerKeyboard+0x10>
    80006af8:	00f53023          	sd	a5,0(a0)
    80006afc:	ffffd097          	auipc	ra,0xffffd
    80006b00:	a64080e7          	jalr	-1436(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006b04:	00813083          	ld	ra,8(sp)
    80006b08:	00013403          	ld	s0,0(sp)
    80006b0c:	01010113          	addi	sp,sp,16
    80006b10:	00008067          	ret

0000000080006b14 <_ZN16ProducerKeyboardD0Ev>:
    80006b14:	fe010113          	addi	sp,sp,-32
    80006b18:	00113c23          	sd	ra,24(sp)
    80006b1c:	00813823          	sd	s0,16(sp)
    80006b20:	00913423          	sd	s1,8(sp)
    80006b24:	02010413          	addi	s0,sp,32
    80006b28:	00050493          	mv	s1,a0
    80006b2c:	00006797          	auipc	a5,0x6
    80006b30:	74c78793          	addi	a5,a5,1868 # 8000d278 <_ZTV16ProducerKeyboard+0x10>
    80006b34:	00f53023          	sd	a5,0(a0)
    80006b38:	ffffd097          	auipc	ra,0xffffd
    80006b3c:	a28080e7          	jalr	-1496(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006b40:	00048513          	mv	a0,s1
    80006b44:	ffffd097          	auipc	ra,0xffffd
    80006b48:	aac080e7          	jalr	-1364(ra) # 800035f0 <_ZdlPv>
    80006b4c:	01813083          	ld	ra,24(sp)
    80006b50:	01013403          	ld	s0,16(sp)
    80006b54:	00813483          	ld	s1,8(sp)
    80006b58:	02010113          	addi	sp,sp,32
    80006b5c:	00008067          	ret

0000000080006b60 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80006b60:	ff010113          	addi	sp,sp,-16
    80006b64:	00113423          	sd	ra,8(sp)
    80006b68:	00813023          	sd	s0,0(sp)
    80006b6c:	01010413          	addi	s0,sp,16
    80006b70:	00006797          	auipc	a5,0x6
    80006b74:	7d078793          	addi	a5,a5,2000 # 8000d340 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006b78:	00f53023          	sd	a5,0(a0)
    80006b7c:	ffffd097          	auipc	ra,0xffffd
    80006b80:	9e4080e7          	jalr	-1564(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006b84:	00813083          	ld	ra,8(sp)
    80006b88:	00013403          	ld	s0,0(sp)
    80006b8c:	01010113          	addi	sp,sp,16
    80006b90:	00008067          	ret

0000000080006b94 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80006b94:	fe010113          	addi	sp,sp,-32
    80006b98:	00113c23          	sd	ra,24(sp)
    80006b9c:	00813823          	sd	s0,16(sp)
    80006ba0:	00913423          	sd	s1,8(sp)
    80006ba4:	02010413          	addi	s0,sp,32
    80006ba8:	00050493          	mv	s1,a0
    80006bac:	00006797          	auipc	a5,0x6
    80006bb0:	79478793          	addi	a5,a5,1940 # 8000d340 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006bb4:	00f53023          	sd	a5,0(a0)
    80006bb8:	ffffd097          	auipc	ra,0xffffd
    80006bbc:	9a8080e7          	jalr	-1624(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006bc0:	00048513          	mv	a0,s1
    80006bc4:	ffffd097          	auipc	ra,0xffffd
    80006bc8:	a2c080e7          	jalr	-1492(ra) # 800035f0 <_ZdlPv>
    80006bcc:	01813083          	ld	ra,24(sp)
    80006bd0:	01013403          	ld	s0,16(sp)
    80006bd4:	00813483          	ld	s1,8(sp)
    80006bd8:	02010113          	addi	sp,sp,32
    80006bdc:	00008067          	ret

0000000080006be0 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80006be0:	ff010113          	addi	sp,sp,-16
    80006be4:	00113423          	sd	ra,8(sp)
    80006be8:	00813023          	sd	s0,0(sp)
    80006bec:	01010413          	addi	s0,sp,16
    80006bf0:	00006797          	auipc	a5,0x6
    80006bf4:	70078793          	addi	a5,a5,1792 # 8000d2f0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006bf8:	00f53023          	sd	a5,0(a0)
    80006bfc:	ffffd097          	auipc	ra,0xffffd
    80006c00:	964080e7          	jalr	-1692(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006c04:	00813083          	ld	ra,8(sp)
    80006c08:	00013403          	ld	s0,0(sp)
    80006c0c:	01010113          	addi	sp,sp,16
    80006c10:	00008067          	ret

0000000080006c14 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80006c14:	fe010113          	addi	sp,sp,-32
    80006c18:	00113c23          	sd	ra,24(sp)
    80006c1c:	00813823          	sd	s0,16(sp)
    80006c20:	00913423          	sd	s1,8(sp)
    80006c24:	02010413          	addi	s0,sp,32
    80006c28:	00050493          	mv	s1,a0
    80006c2c:	00006797          	auipc	a5,0x6
    80006c30:	6c478793          	addi	a5,a5,1732 # 8000d2f0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006c34:	00f53023          	sd	a5,0(a0)
    80006c38:	ffffd097          	auipc	ra,0xffffd
    80006c3c:	928080e7          	jalr	-1752(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006c40:	00048513          	mv	a0,s1
    80006c44:	ffffd097          	auipc	ra,0xffffd
    80006c48:	9ac080e7          	jalr	-1620(ra) # 800035f0 <_ZdlPv>
    80006c4c:	01813083          	ld	ra,24(sp)
    80006c50:	01013403          	ld	s0,16(sp)
    80006c54:	00813483          	ld	s1,8(sp)
    80006c58:	02010113          	addi	sp,sp,32
    80006c5c:	00008067          	ret

0000000080006c60 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80006c60:	ff010113          	addi	sp,sp,-16
    80006c64:	00113423          	sd	ra,8(sp)
    80006c68:	00813023          	sd	s0,0(sp)
    80006c6c:	01010413          	addi	s0,sp,16
    80006c70:	00006797          	auipc	a5,0x6
    80006c74:	6a878793          	addi	a5,a5,1704 # 8000d318 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006c78:	00f53023          	sd	a5,0(a0)
    80006c7c:	ffffd097          	auipc	ra,0xffffd
    80006c80:	8e4080e7          	jalr	-1820(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006c84:	00813083          	ld	ra,8(sp)
    80006c88:	00013403          	ld	s0,0(sp)
    80006c8c:	01010113          	addi	sp,sp,16
    80006c90:	00008067          	ret

0000000080006c94 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80006c94:	fe010113          	addi	sp,sp,-32
    80006c98:	00113c23          	sd	ra,24(sp)
    80006c9c:	00813823          	sd	s0,16(sp)
    80006ca0:	00913423          	sd	s1,8(sp)
    80006ca4:	02010413          	addi	s0,sp,32
    80006ca8:	00050493          	mv	s1,a0
    80006cac:	00006797          	auipc	a5,0x6
    80006cb0:	66c78793          	addi	a5,a5,1644 # 8000d318 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006cb4:	00f53023          	sd	a5,0(a0)
    80006cb8:	ffffd097          	auipc	ra,0xffffd
    80006cbc:	8a8080e7          	jalr	-1880(ra) # 80003560 <_ZN6ThreadD1Ev>
    80006cc0:	00048513          	mv	a0,s1
    80006cc4:	ffffd097          	auipc	ra,0xffffd
    80006cc8:	92c080e7          	jalr	-1748(ra) # 800035f0 <_ZdlPv>
    80006ccc:	01813083          	ld	ra,24(sp)
    80006cd0:	01013403          	ld	s0,16(sp)
    80006cd4:	00813483          	ld	s1,8(sp)
    80006cd8:	02010113          	addi	sp,sp,32
    80006cdc:	00008067          	ret

0000000080006ce0 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80006ce0:	fe010113          	addi	sp,sp,-32
    80006ce4:	00113c23          	sd	ra,24(sp)
    80006ce8:	00813823          	sd	s0,16(sp)
    80006cec:	00913423          	sd	s1,8(sp)
    80006cf0:	02010413          	addi	s0,sp,32
    80006cf4:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80006cf8:	ffffb097          	auipc	ra,0xffffb
    80006cfc:	348080e7          	jalr	840(ra) # 80002040 <_Z4getcv>
    80006d00:	0005059b          	sext.w	a1,a0
    80006d04:	01b00793          	li	a5,27
    80006d08:	00f58c63          	beq	a1,a5,80006d20 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80006d0c:	0104b783          	ld	a5,16(s1)
    80006d10:	0087b503          	ld	a0,8(a5)
    80006d14:	ffffe097          	auipc	ra,0xffffe
    80006d18:	544080e7          	jalr	1348(ra) # 80005258 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80006d1c:	fddff06f          	j	80006cf8 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80006d20:	00100793          	li	a5,1
    80006d24:	0000b717          	auipc	a4,0xb
    80006d28:	94f72a23          	sw	a5,-1708(a4) # 80011678 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80006d2c:	0104b783          	ld	a5,16(s1)
    80006d30:	02100593          	li	a1,33
    80006d34:	0087b503          	ld	a0,8(a5)
    80006d38:	ffffe097          	auipc	ra,0xffffe
    80006d3c:	520080e7          	jalr	1312(ra) # 80005258 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80006d40:	0104b783          	ld	a5,16(s1)
    80006d44:	0107b503          	ld	a0,16(a5)
    80006d48:	ffffd097          	auipc	ra,0xffffd
    80006d4c:	9b4080e7          	jalr	-1612(ra) # 800036fc <_ZN9Semaphore6signalEv>
        }
    80006d50:	01813083          	ld	ra,24(sp)
    80006d54:	01013403          	ld	s0,16(sp)
    80006d58:	00813483          	ld	s1,8(sp)
    80006d5c:	02010113          	addi	sp,sp,32
    80006d60:	00008067          	ret

0000000080006d64 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80006d64:	fd010113          	addi	sp,sp,-48
    80006d68:	02113423          	sd	ra,40(sp)
    80006d6c:	02813023          	sd	s0,32(sp)
    80006d70:	00913c23          	sd	s1,24(sp)
    80006d74:	01213823          	sd	s2,16(sp)
    80006d78:	01313423          	sd	s3,8(sp)
    80006d7c:	03010413          	addi	s0,sp,48
    80006d80:	00050913          	mv	s2,a0
            int i = 0;
    80006d84:	00000993          	li	s3,0
    80006d88:	0100006f          	j	80006d98 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80006d8c:	00a00513          	li	a0,10
    80006d90:	ffffd097          	auipc	ra,0xffffd
    80006d94:	b68080e7          	jalr	-1176(ra) # 800038f8 <_ZN7Console4putcEc>
            while (!threadEnd) {
    80006d98:	0000b797          	auipc	a5,0xb
    80006d9c:	8e07a783          	lw	a5,-1824(a5) # 80011678 <_ZN19ConsumerProducerCPP9threadEndE>
    80006da0:	04079a63          	bnez	a5,80006df4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80006da4:	01093783          	ld	a5,16(s2)
    80006da8:	0087b503          	ld	a0,8(a5)
    80006dac:	ffffe097          	auipc	ra,0xffffe
    80006db0:	53c080e7          	jalr	1340(ra) # 800052e8 <_ZN9BufferCPP3getEv>
                i++;
    80006db4:	0019849b          	addiw	s1,s3,1
    80006db8:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80006dbc:	0ff57513          	andi	a0,a0,255
    80006dc0:	ffffd097          	auipc	ra,0xffffd
    80006dc4:	b38080e7          	jalr	-1224(ra) # 800038f8 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80006dc8:	05000793          	li	a5,80
    80006dcc:	02f4e4bb          	remw	s1,s1,a5
    80006dd0:	fc0494e3          	bnez	s1,80006d98 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80006dd4:	fb9ff06f          	j	80006d8c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    80006dd8:	01093783          	ld	a5,16(s2)
    80006ddc:	0087b503          	ld	a0,8(a5)
    80006de0:	ffffe097          	auipc	ra,0xffffe
    80006de4:	508080e7          	jalr	1288(ra) # 800052e8 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80006de8:	0ff57513          	andi	a0,a0,255
    80006dec:	ffffd097          	auipc	ra,0xffffd
    80006df0:	b0c080e7          	jalr	-1268(ra) # 800038f8 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    80006df4:	01093783          	ld	a5,16(s2)
    80006df8:	0087b503          	ld	a0,8(a5)
    80006dfc:	ffffe097          	auipc	ra,0xffffe
    80006e00:	578080e7          	jalr	1400(ra) # 80005374 <_ZN9BufferCPP6getCntEv>
    80006e04:	fca04ae3          	bgtz	a0,80006dd8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80006e08:	01093783          	ld	a5,16(s2)
    80006e0c:	0107b503          	ld	a0,16(a5)
    80006e10:	ffffd097          	auipc	ra,0xffffd
    80006e14:	8ec080e7          	jalr	-1812(ra) # 800036fc <_ZN9Semaphore6signalEv>
        }
    80006e18:	02813083          	ld	ra,40(sp)
    80006e1c:	02013403          	ld	s0,32(sp)
    80006e20:	01813483          	ld	s1,24(sp)
    80006e24:	01013903          	ld	s2,16(sp)
    80006e28:	00813983          	ld	s3,8(sp)
    80006e2c:	03010113          	addi	sp,sp,48
    80006e30:	00008067          	ret

0000000080006e34 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006e34:	fe010113          	addi	sp,sp,-32
    80006e38:	00113c23          	sd	ra,24(sp)
    80006e3c:	00813823          	sd	s0,16(sp)
    80006e40:	00913423          	sd	s1,8(sp)
    80006e44:	01213023          	sd	s2,0(sp)
    80006e48:	02010413          	addi	s0,sp,32
    80006e4c:	00050493          	mv	s1,a0
            int i = 0;
    80006e50:	00000913          	li	s2,0
            while (!threadEnd) {
    80006e54:	0000b797          	auipc	a5,0xb
    80006e58:	8247a783          	lw	a5,-2012(a5) # 80011678 <_ZN19ConsumerProducerCPP9threadEndE>
    80006e5c:	04079263          	bnez	a5,80006ea0 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80006e60:	0104b783          	ld	a5,16(s1)
    80006e64:	0007a583          	lw	a1,0(a5)
    80006e68:	0305859b          	addiw	a1,a1,48
    80006e6c:	0087b503          	ld	a0,8(a5)
    80006e70:	ffffe097          	auipc	ra,0xffffe
    80006e74:	3e8080e7          	jalr	1000(ra) # 80005258 <_ZN9BufferCPP3putEi>
                i++;
    80006e78:	0019071b          	addiw	a4,s2,1
    80006e7c:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80006e80:	0104b783          	ld	a5,16(s1)
    80006e84:	0007a783          	lw	a5,0(a5)
    80006e88:	00e787bb          	addw	a5,a5,a4
    80006e8c:	00500513          	li	a0,5
    80006e90:	02a7e53b          	remw	a0,a5,a0
    80006e94:	ffffd097          	auipc	ra,0xffffd
    80006e98:	910080e7          	jalr	-1776(ra) # 800037a4 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80006e9c:	fb9ff06f          	j	80006e54 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80006ea0:	0104b783          	ld	a5,16(s1)
    80006ea4:	0107b503          	ld	a0,16(a5)
    80006ea8:	ffffd097          	auipc	ra,0xffffd
    80006eac:	854080e7          	jalr	-1964(ra) # 800036fc <_ZN9Semaphore6signalEv>
        }
    80006eb0:	01813083          	ld	ra,24(sp)
    80006eb4:	01013403          	ld	s0,16(sp)
    80006eb8:	00813483          	ld	s1,8(sp)
    80006ebc:	00013903          	ld	s2,0(sp)
    80006ec0:	02010113          	addi	sp,sp,32
    80006ec4:	00008067          	ret

0000000080006ec8 <_ZN7WorkerA3runEv>:
    void run() override {
    80006ec8:	ff010113          	addi	sp,sp,-16
    80006ecc:	00113423          	sd	ra,8(sp)
    80006ed0:	00813023          	sd	s0,0(sp)
    80006ed4:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80006ed8:	00000593          	li	a1,0
    80006edc:	ffffe097          	auipc	ra,0xffffe
    80006ee0:	738080e7          	jalr	1848(ra) # 80005614 <_ZN7WorkerA11workerBodyAEPv>
    }
    80006ee4:	00813083          	ld	ra,8(sp)
    80006ee8:	00013403          	ld	s0,0(sp)
    80006eec:	01010113          	addi	sp,sp,16
    80006ef0:	00008067          	ret

0000000080006ef4 <_ZN7WorkerB3runEv>:
    void run() override {
    80006ef4:	ff010113          	addi	sp,sp,-16
    80006ef8:	00113423          	sd	ra,8(sp)
    80006efc:	00813023          	sd	s0,0(sp)
    80006f00:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80006f04:	00000593          	li	a1,0
    80006f08:	ffffe097          	auipc	ra,0xffffe
    80006f0c:	7d8080e7          	jalr	2008(ra) # 800056e0 <_ZN7WorkerB11workerBodyBEPv>
    }
    80006f10:	00813083          	ld	ra,8(sp)
    80006f14:	00013403          	ld	s0,0(sp)
    80006f18:	01010113          	addi	sp,sp,16
    80006f1c:	00008067          	ret

0000000080006f20 <_ZN7WorkerC3runEv>:
    void run() override {
    80006f20:	ff010113          	addi	sp,sp,-16
    80006f24:	00113423          	sd	ra,8(sp)
    80006f28:	00813023          	sd	s0,0(sp)
    80006f2c:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80006f30:	00000593          	li	a1,0
    80006f34:	fffff097          	auipc	ra,0xfffff
    80006f38:	880080e7          	jalr	-1920(ra) # 800057b4 <_ZN7WorkerC11workerBodyCEPv>
    }
    80006f3c:	00813083          	ld	ra,8(sp)
    80006f40:	00013403          	ld	s0,0(sp)
    80006f44:	01010113          	addi	sp,sp,16
    80006f48:	00008067          	ret

0000000080006f4c <_ZN7WorkerD3runEv>:
    void run() override {
    80006f4c:	ff010113          	addi	sp,sp,-16
    80006f50:	00113423          	sd	ra,8(sp)
    80006f54:	00813023          	sd	s0,0(sp)
    80006f58:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80006f5c:	00000593          	li	a1,0
    80006f60:	fffff097          	auipc	ra,0xfffff
    80006f64:	9d4080e7          	jalr	-1580(ra) # 80005934 <_ZN7WorkerD11workerBodyDEPv>
    }
    80006f68:	00813083          	ld	ra,8(sp)
    80006f6c:	00013403          	ld	s0,0(sp)
    80006f70:	01010113          	addi	sp,sp,16
    80006f74:	00008067          	ret

0000000080006f78 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80006f78:	ff010113          	addi	sp,sp,-16
    80006f7c:	00113423          	sd	ra,8(sp)
    80006f80:	00813023          	sd	s0,0(sp)
    80006f84:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80006f88:	01053583          	ld	a1,16(a0)
    80006f8c:	fffff097          	auipc	ra,0xfffff
    80006f90:	d00080e7          	jalr	-768(ra) # 80005c8c <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80006f94:	00813083          	ld	ra,8(sp)
    80006f98:	00013403          	ld	s0,0(sp)
    80006f9c:	01010113          	addi	sp,sp,16
    80006fa0:	00008067          	ret

0000000080006fa4 <_ZN8Producer3runEv>:
    void run() override {
    80006fa4:	ff010113          	addi	sp,sp,-16
    80006fa8:	00113423          	sd	ra,8(sp)
    80006fac:	00813023          	sd	s0,0(sp)
    80006fb0:	01010413          	addi	s0,sp,16
        producer(td);
    80006fb4:	01053583          	ld	a1,16(a0)
    80006fb8:	fffff097          	auipc	ra,0xfffff
    80006fbc:	d94080e7          	jalr	-620(ra) # 80005d4c <_ZN8Producer8producerEPv>
    }
    80006fc0:	00813083          	ld	ra,8(sp)
    80006fc4:	00013403          	ld	s0,0(sp)
    80006fc8:	01010113          	addi	sp,sp,16
    80006fcc:	00008067          	ret

0000000080006fd0 <_ZN8Consumer3runEv>:
    void run() override {
    80006fd0:	ff010113          	addi	sp,sp,-16
    80006fd4:	00113423          	sd	ra,8(sp)
    80006fd8:	00813023          	sd	s0,0(sp)
    80006fdc:	01010413          	addi	s0,sp,16
        consumer(td);
    80006fe0:	01053583          	ld	a1,16(a0)
    80006fe4:	fffff097          	auipc	ra,0xfffff
    80006fe8:	dfc080e7          	jalr	-516(ra) # 80005de0 <_ZN8Consumer8consumerEPv>
    }
    80006fec:	00813083          	ld	ra,8(sp)
    80006ff0:	00013403          	ld	s0,0(sp)
    80006ff4:	01010113          	addi	sp,sp,16
    80006ff8:	00008067          	ret

0000000080006ffc <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006ffc:	fe010113          	addi	sp,sp,-32
    80007000:	00113c23          	sd	ra,24(sp)
    80007004:	00813823          	sd	s0,16(sp)
    80007008:	00913423          	sd	s1,8(sp)
    8000700c:	01213023          	sd	s2,0(sp)
    80007010:	02010413          	addi	s0,sp,32
    80007014:	00050493          	mv	s1,a0
    80007018:	00058913          	mv	s2,a1
    8000701c:	0015879b          	addiw	a5,a1,1
    80007020:	0007851b          	sext.w	a0,a5
    80007024:	00f4a023          	sw	a5,0(s1)
    80007028:	0004a823          	sw	zero,16(s1)
    8000702c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80007030:	00251513          	slli	a0,a0,0x2
    80007034:	ffffb097          	auipc	ra,0xffffb
    80007038:	d5c080e7          	jalr	-676(ra) # 80001d90 <_Z9mem_allocm>
    8000703c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80007040:	00000593          	li	a1,0
    80007044:	02048513          	addi	a0,s1,32
    80007048:	ffffb097          	auipc	ra,0xffffb
    8000704c:	f10080e7          	jalr	-240(ra) # 80001f58 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80007050:	00090593          	mv	a1,s2
    80007054:	01848513          	addi	a0,s1,24
    80007058:	ffffb097          	auipc	ra,0xffffb
    8000705c:	f00080e7          	jalr	-256(ra) # 80001f58 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80007060:	00100593          	li	a1,1
    80007064:	02848513          	addi	a0,s1,40
    80007068:	ffffb097          	auipc	ra,0xffffb
    8000706c:	ef0080e7          	jalr	-272(ra) # 80001f58 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80007070:	00100593          	li	a1,1
    80007074:	03048513          	addi	a0,s1,48
    80007078:	ffffb097          	auipc	ra,0xffffb
    8000707c:	ee0080e7          	jalr	-288(ra) # 80001f58 <_Z8sem_openPP10_semaphorej>
}
    80007080:	01813083          	ld	ra,24(sp)
    80007084:	01013403          	ld	s0,16(sp)
    80007088:	00813483          	ld	s1,8(sp)
    8000708c:	00013903          	ld	s2,0(sp)
    80007090:	02010113          	addi	sp,sp,32
    80007094:	00008067          	ret

0000000080007098 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80007098:	fe010113          	addi	sp,sp,-32
    8000709c:	00113c23          	sd	ra,24(sp)
    800070a0:	00813823          	sd	s0,16(sp)
    800070a4:	00913423          	sd	s1,8(sp)
    800070a8:	01213023          	sd	s2,0(sp)
    800070ac:	02010413          	addi	s0,sp,32
    800070b0:	00050493          	mv	s1,a0
    800070b4:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800070b8:	01853503          	ld	a0,24(a0)
    800070bc:	ffffb097          	auipc	ra,0xffffb
    800070c0:	f00080e7          	jalr	-256(ra) # 80001fbc <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    800070c4:	0304b503          	ld	a0,48(s1)
    800070c8:	ffffb097          	auipc	ra,0xffffb
    800070cc:	ef4080e7          	jalr	-268(ra) # 80001fbc <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    800070d0:	0084b783          	ld	a5,8(s1)
    800070d4:	0144a703          	lw	a4,20(s1)
    800070d8:	00271713          	slli	a4,a4,0x2
    800070dc:	00e787b3          	add	a5,a5,a4
    800070e0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800070e4:	0144a783          	lw	a5,20(s1)
    800070e8:	0017879b          	addiw	a5,a5,1
    800070ec:	0004a703          	lw	a4,0(s1)
    800070f0:	02e7e7bb          	remw	a5,a5,a4
    800070f4:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800070f8:	0304b503          	ld	a0,48(s1)
    800070fc:	ffffb097          	auipc	ra,0xffffb
    80007100:	eec080e7          	jalr	-276(ra) # 80001fe8 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80007104:	0204b503          	ld	a0,32(s1)
    80007108:	ffffb097          	auipc	ra,0xffffb
    8000710c:	ee0080e7          	jalr	-288(ra) # 80001fe8 <_Z10sem_signalP10_semaphore>

}
    80007110:	01813083          	ld	ra,24(sp)
    80007114:	01013403          	ld	s0,16(sp)
    80007118:	00813483          	ld	s1,8(sp)
    8000711c:	00013903          	ld	s2,0(sp)
    80007120:	02010113          	addi	sp,sp,32
    80007124:	00008067          	ret

0000000080007128 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80007128:	fe010113          	addi	sp,sp,-32
    8000712c:	00113c23          	sd	ra,24(sp)
    80007130:	00813823          	sd	s0,16(sp)
    80007134:	00913423          	sd	s1,8(sp)
    80007138:	01213023          	sd	s2,0(sp)
    8000713c:	02010413          	addi	s0,sp,32
    80007140:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80007144:	02053503          	ld	a0,32(a0)
    80007148:	ffffb097          	auipc	ra,0xffffb
    8000714c:	e74080e7          	jalr	-396(ra) # 80001fbc <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80007150:	0284b503          	ld	a0,40(s1)
    80007154:	ffffb097          	auipc	ra,0xffffb
    80007158:	e68080e7          	jalr	-408(ra) # 80001fbc <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8000715c:	0084b703          	ld	a4,8(s1)
    80007160:	0104a783          	lw	a5,16(s1)
    80007164:	00279693          	slli	a3,a5,0x2
    80007168:	00d70733          	add	a4,a4,a3
    8000716c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80007170:	0017879b          	addiw	a5,a5,1
    80007174:	0004a703          	lw	a4,0(s1)
    80007178:	02e7e7bb          	remw	a5,a5,a4
    8000717c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80007180:	0284b503          	ld	a0,40(s1)
    80007184:	ffffb097          	auipc	ra,0xffffb
    80007188:	e64080e7          	jalr	-412(ra) # 80001fe8 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    8000718c:	0184b503          	ld	a0,24(s1)
    80007190:	ffffb097          	auipc	ra,0xffffb
    80007194:	e58080e7          	jalr	-424(ra) # 80001fe8 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80007198:	00090513          	mv	a0,s2
    8000719c:	01813083          	ld	ra,24(sp)
    800071a0:	01013403          	ld	s0,16(sp)
    800071a4:	00813483          	ld	s1,8(sp)
    800071a8:	00013903          	ld	s2,0(sp)
    800071ac:	02010113          	addi	sp,sp,32
    800071b0:	00008067          	ret

00000000800071b4 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800071b4:	fe010113          	addi	sp,sp,-32
    800071b8:	00113c23          	sd	ra,24(sp)
    800071bc:	00813823          	sd	s0,16(sp)
    800071c0:	00913423          	sd	s1,8(sp)
    800071c4:	01213023          	sd	s2,0(sp)
    800071c8:	02010413          	addi	s0,sp,32
    800071cc:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800071d0:	02853503          	ld	a0,40(a0)
    800071d4:	ffffb097          	auipc	ra,0xffffb
    800071d8:	de8080e7          	jalr	-536(ra) # 80001fbc <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    800071dc:	0304b503          	ld	a0,48(s1)
    800071e0:	ffffb097          	auipc	ra,0xffffb
    800071e4:	ddc080e7          	jalr	-548(ra) # 80001fbc <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    800071e8:	0144a783          	lw	a5,20(s1)
    800071ec:	0104a903          	lw	s2,16(s1)
    800071f0:	0327ce63          	blt	a5,s2,8000722c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800071f4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800071f8:	0304b503          	ld	a0,48(s1)
    800071fc:	ffffb097          	auipc	ra,0xffffb
    80007200:	dec080e7          	jalr	-532(ra) # 80001fe8 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80007204:	0284b503          	ld	a0,40(s1)
    80007208:	ffffb097          	auipc	ra,0xffffb
    8000720c:	de0080e7          	jalr	-544(ra) # 80001fe8 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80007210:	00090513          	mv	a0,s2
    80007214:	01813083          	ld	ra,24(sp)
    80007218:	01013403          	ld	s0,16(sp)
    8000721c:	00813483          	ld	s1,8(sp)
    80007220:	00013903          	ld	s2,0(sp)
    80007224:	02010113          	addi	sp,sp,32
    80007228:	00008067          	ret
        ret = cap - head + tail;
    8000722c:	0004a703          	lw	a4,0(s1)
    80007230:	4127093b          	subw	s2,a4,s2
    80007234:	00f9093b          	addw	s2,s2,a5
    80007238:	fc1ff06f          	j	800071f8 <_ZN6Buffer6getCntEv+0x44>

000000008000723c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000723c:	fe010113          	addi	sp,sp,-32
    80007240:	00113c23          	sd	ra,24(sp)
    80007244:	00813823          	sd	s0,16(sp)
    80007248:	00913423          	sd	s1,8(sp)
    8000724c:	02010413          	addi	s0,sp,32
    80007250:	00050493          	mv	s1,a0
    putc('\n');
    80007254:	00a00513          	li	a0,10
    80007258:	ffffb097          	auipc	ra,0xffffb
    8000725c:	e10080e7          	jalr	-496(ra) # 80002068 <_Z4putcc>
    printString("Buffer deleted!\n");
    80007260:	00003517          	auipc	a0,0x3
    80007264:	2f850513          	addi	a0,a0,760 # 8000a558 <CONSOLE_STATUS+0x548>
    80007268:	ffffb097          	auipc	ra,0xffffb
    8000726c:	60c080e7          	jalr	1548(ra) # 80002874 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80007270:	00048513          	mv	a0,s1
    80007274:	00000097          	auipc	ra,0x0
    80007278:	f40080e7          	jalr	-192(ra) # 800071b4 <_ZN6Buffer6getCntEv>
    8000727c:	02a05c63          	blez	a0,800072b4 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80007280:	0084b783          	ld	a5,8(s1)
    80007284:	0104a703          	lw	a4,16(s1)
    80007288:	00271713          	slli	a4,a4,0x2
    8000728c:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80007290:	0007c503          	lbu	a0,0(a5)
    80007294:	ffffb097          	auipc	ra,0xffffb
    80007298:	dd4080e7          	jalr	-556(ra) # 80002068 <_Z4putcc>
        head = (head + 1) % cap;
    8000729c:	0104a783          	lw	a5,16(s1)
    800072a0:	0017879b          	addiw	a5,a5,1
    800072a4:	0004a703          	lw	a4,0(s1)
    800072a8:	02e7e7bb          	remw	a5,a5,a4
    800072ac:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800072b0:	fc1ff06f          	j	80007270 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800072b4:	02100513          	li	a0,33
    800072b8:	ffffb097          	auipc	ra,0xffffb
    800072bc:	db0080e7          	jalr	-592(ra) # 80002068 <_Z4putcc>
    putc('\n');
    800072c0:	00a00513          	li	a0,10
    800072c4:	ffffb097          	auipc	ra,0xffffb
    800072c8:	da4080e7          	jalr	-604(ra) # 80002068 <_Z4putcc>
    mem_free(buffer);
    800072cc:	0084b503          	ld	a0,8(s1)
    800072d0:	ffffb097          	auipc	ra,0xffffb
    800072d4:	af0080e7          	jalr	-1296(ra) # 80001dc0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800072d8:	0204b503          	ld	a0,32(s1)
    800072dc:	ffffb097          	auipc	ra,0xffffb
    800072e0:	cb4080e7          	jalr	-844(ra) # 80001f90 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    800072e4:	0184b503          	ld	a0,24(s1)
    800072e8:	ffffb097          	auipc	ra,0xffffb
    800072ec:	ca8080e7          	jalr	-856(ra) # 80001f90 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    800072f0:	0304b503          	ld	a0,48(s1)
    800072f4:	ffffb097          	auipc	ra,0xffffb
    800072f8:	c9c080e7          	jalr	-868(ra) # 80001f90 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    800072fc:	0284b503          	ld	a0,40(s1)
    80007300:	ffffb097          	auipc	ra,0xffffb
    80007304:	c90080e7          	jalr	-880(ra) # 80001f90 <_Z9sem_closeP10_semaphore>
}
    80007308:	01813083          	ld	ra,24(sp)
    8000730c:	01013403          	ld	s0,16(sp)
    80007310:	00813483          	ld	s1,8(sp)
    80007314:	02010113          	addi	sp,sp,32
    80007318:	00008067          	ret

000000008000731c <start>:
    8000731c:	ff010113          	addi	sp,sp,-16
    80007320:	00813423          	sd	s0,8(sp)
    80007324:	01010413          	addi	s0,sp,16
    80007328:	300027f3          	csrr	a5,mstatus
    8000732c:	ffffe737          	lui	a4,0xffffe
    80007330:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffebeff>
    80007334:	00e7f7b3          	and	a5,a5,a4
    80007338:	00001737          	lui	a4,0x1
    8000733c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80007340:	00e7e7b3          	or	a5,a5,a4
    80007344:	30079073          	csrw	mstatus,a5
    80007348:	00000797          	auipc	a5,0x0
    8000734c:	16078793          	addi	a5,a5,352 # 800074a8 <system_main>
    80007350:	34179073          	csrw	mepc,a5
    80007354:	00000793          	li	a5,0
    80007358:	18079073          	csrw	satp,a5
    8000735c:	000107b7          	lui	a5,0x10
    80007360:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80007364:	30279073          	csrw	medeleg,a5
    80007368:	30379073          	csrw	mideleg,a5
    8000736c:	104027f3          	csrr	a5,sie
    80007370:	2227e793          	ori	a5,a5,546
    80007374:	10479073          	csrw	sie,a5
    80007378:	fff00793          	li	a5,-1
    8000737c:	00a7d793          	srli	a5,a5,0xa
    80007380:	3b079073          	csrw	pmpaddr0,a5
    80007384:	00f00793          	li	a5,15
    80007388:	3a079073          	csrw	pmpcfg0,a5
    8000738c:	f14027f3          	csrr	a5,mhartid
    80007390:	0200c737          	lui	a4,0x200c
    80007394:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007398:	0007869b          	sext.w	a3,a5
    8000739c:	00269713          	slli	a4,a3,0x2
    800073a0:	000f4637          	lui	a2,0xf4
    800073a4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800073a8:	00d70733          	add	a4,a4,a3
    800073ac:	0037979b          	slliw	a5,a5,0x3
    800073b0:	020046b7          	lui	a3,0x2004
    800073b4:	00d787b3          	add	a5,a5,a3
    800073b8:	00c585b3          	add	a1,a1,a2
    800073bc:	00371693          	slli	a3,a4,0x3
    800073c0:	0000a717          	auipc	a4,0xa
    800073c4:	2e070713          	addi	a4,a4,736 # 800116a0 <timer_scratch>
    800073c8:	00b7b023          	sd	a1,0(a5)
    800073cc:	00d70733          	add	a4,a4,a3
    800073d0:	00f73c23          	sd	a5,24(a4)
    800073d4:	02c73023          	sd	a2,32(a4)
    800073d8:	34071073          	csrw	mscratch,a4
    800073dc:	00000797          	auipc	a5,0x0
    800073e0:	6e478793          	addi	a5,a5,1764 # 80007ac0 <timervec>
    800073e4:	30579073          	csrw	mtvec,a5
    800073e8:	300027f3          	csrr	a5,mstatus
    800073ec:	0087e793          	ori	a5,a5,8
    800073f0:	30079073          	csrw	mstatus,a5
    800073f4:	304027f3          	csrr	a5,mie
    800073f8:	0807e793          	ori	a5,a5,128
    800073fc:	30479073          	csrw	mie,a5
    80007400:	f14027f3          	csrr	a5,mhartid
    80007404:	0007879b          	sext.w	a5,a5
    80007408:	00078213          	mv	tp,a5
    8000740c:	30200073          	mret
    80007410:	00813403          	ld	s0,8(sp)
    80007414:	01010113          	addi	sp,sp,16
    80007418:	00008067          	ret

000000008000741c <timerinit>:
    8000741c:	ff010113          	addi	sp,sp,-16
    80007420:	00813423          	sd	s0,8(sp)
    80007424:	01010413          	addi	s0,sp,16
    80007428:	f14027f3          	csrr	a5,mhartid
    8000742c:	0200c737          	lui	a4,0x200c
    80007430:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007434:	0007869b          	sext.w	a3,a5
    80007438:	00269713          	slli	a4,a3,0x2
    8000743c:	000f4637          	lui	a2,0xf4
    80007440:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007444:	00d70733          	add	a4,a4,a3
    80007448:	0037979b          	slliw	a5,a5,0x3
    8000744c:	020046b7          	lui	a3,0x2004
    80007450:	00d787b3          	add	a5,a5,a3
    80007454:	00c585b3          	add	a1,a1,a2
    80007458:	00371693          	slli	a3,a4,0x3
    8000745c:	0000a717          	auipc	a4,0xa
    80007460:	24470713          	addi	a4,a4,580 # 800116a0 <timer_scratch>
    80007464:	00b7b023          	sd	a1,0(a5)
    80007468:	00d70733          	add	a4,a4,a3
    8000746c:	00f73c23          	sd	a5,24(a4)
    80007470:	02c73023          	sd	a2,32(a4)
    80007474:	34071073          	csrw	mscratch,a4
    80007478:	00000797          	auipc	a5,0x0
    8000747c:	64878793          	addi	a5,a5,1608 # 80007ac0 <timervec>
    80007480:	30579073          	csrw	mtvec,a5
    80007484:	300027f3          	csrr	a5,mstatus
    80007488:	0087e793          	ori	a5,a5,8
    8000748c:	30079073          	csrw	mstatus,a5
    80007490:	304027f3          	csrr	a5,mie
    80007494:	0807e793          	ori	a5,a5,128
    80007498:	30479073          	csrw	mie,a5
    8000749c:	00813403          	ld	s0,8(sp)
    800074a0:	01010113          	addi	sp,sp,16
    800074a4:	00008067          	ret

00000000800074a8 <system_main>:
    800074a8:	fe010113          	addi	sp,sp,-32
    800074ac:	00813823          	sd	s0,16(sp)
    800074b0:	00913423          	sd	s1,8(sp)
    800074b4:	00113c23          	sd	ra,24(sp)
    800074b8:	02010413          	addi	s0,sp,32
    800074bc:	00000097          	auipc	ra,0x0
    800074c0:	0c4080e7          	jalr	196(ra) # 80007580 <cpuid>
    800074c4:	00006497          	auipc	s1,0x6
    800074c8:	f5c48493          	addi	s1,s1,-164 # 8000d420 <started>
    800074cc:	02050263          	beqz	a0,800074f0 <system_main+0x48>
    800074d0:	0004a783          	lw	a5,0(s1)
    800074d4:	0007879b          	sext.w	a5,a5
    800074d8:	fe078ce3          	beqz	a5,800074d0 <system_main+0x28>
    800074dc:	0ff0000f          	fence
    800074e0:	00003517          	auipc	a0,0x3
    800074e4:	2b850513          	addi	a0,a0,696 # 8000a798 <CONSOLE_STATUS+0x788>
    800074e8:	00001097          	auipc	ra,0x1
    800074ec:	a74080e7          	jalr	-1420(ra) # 80007f5c <panic>
    800074f0:	00001097          	auipc	ra,0x1
    800074f4:	9c8080e7          	jalr	-1592(ra) # 80007eb8 <consoleinit>
    800074f8:	00001097          	auipc	ra,0x1
    800074fc:	154080e7          	jalr	340(ra) # 8000864c <printfinit>
    80007500:	00003517          	auipc	a0,0x3
    80007504:	e4850513          	addi	a0,a0,-440 # 8000a348 <CONSOLE_STATUS+0x338>
    80007508:	00001097          	auipc	ra,0x1
    8000750c:	ab0080e7          	jalr	-1360(ra) # 80007fb8 <__printf>
    80007510:	00003517          	auipc	a0,0x3
    80007514:	25850513          	addi	a0,a0,600 # 8000a768 <CONSOLE_STATUS+0x758>
    80007518:	00001097          	auipc	ra,0x1
    8000751c:	aa0080e7          	jalr	-1376(ra) # 80007fb8 <__printf>
    80007520:	00003517          	auipc	a0,0x3
    80007524:	e2850513          	addi	a0,a0,-472 # 8000a348 <CONSOLE_STATUS+0x338>
    80007528:	00001097          	auipc	ra,0x1
    8000752c:	a90080e7          	jalr	-1392(ra) # 80007fb8 <__printf>
    80007530:	00001097          	auipc	ra,0x1
    80007534:	4a8080e7          	jalr	1192(ra) # 800089d8 <kinit>
    80007538:	00000097          	auipc	ra,0x0
    8000753c:	148080e7          	jalr	328(ra) # 80007680 <trapinit>
    80007540:	00000097          	auipc	ra,0x0
    80007544:	16c080e7          	jalr	364(ra) # 800076ac <trapinithart>
    80007548:	00000097          	auipc	ra,0x0
    8000754c:	5b8080e7          	jalr	1464(ra) # 80007b00 <plicinit>
    80007550:	00000097          	auipc	ra,0x0
    80007554:	5d8080e7          	jalr	1496(ra) # 80007b28 <plicinithart>
    80007558:	00000097          	auipc	ra,0x0
    8000755c:	078080e7          	jalr	120(ra) # 800075d0 <userinit>
    80007560:	0ff0000f          	fence
    80007564:	00100793          	li	a5,1
    80007568:	00003517          	auipc	a0,0x3
    8000756c:	21850513          	addi	a0,a0,536 # 8000a780 <CONSOLE_STATUS+0x770>
    80007570:	00f4a023          	sw	a5,0(s1)
    80007574:	00001097          	auipc	ra,0x1
    80007578:	a44080e7          	jalr	-1468(ra) # 80007fb8 <__printf>
    8000757c:	0000006f          	j	8000757c <system_main+0xd4>

0000000080007580 <cpuid>:
    80007580:	ff010113          	addi	sp,sp,-16
    80007584:	00813423          	sd	s0,8(sp)
    80007588:	01010413          	addi	s0,sp,16
    8000758c:	00020513          	mv	a0,tp
    80007590:	00813403          	ld	s0,8(sp)
    80007594:	0005051b          	sext.w	a0,a0
    80007598:	01010113          	addi	sp,sp,16
    8000759c:	00008067          	ret

00000000800075a0 <mycpu>:
    800075a0:	ff010113          	addi	sp,sp,-16
    800075a4:	00813423          	sd	s0,8(sp)
    800075a8:	01010413          	addi	s0,sp,16
    800075ac:	00020793          	mv	a5,tp
    800075b0:	00813403          	ld	s0,8(sp)
    800075b4:	0007879b          	sext.w	a5,a5
    800075b8:	00779793          	slli	a5,a5,0x7
    800075bc:	0000b517          	auipc	a0,0xb
    800075c0:	11450513          	addi	a0,a0,276 # 800126d0 <cpus>
    800075c4:	00f50533          	add	a0,a0,a5
    800075c8:	01010113          	addi	sp,sp,16
    800075cc:	00008067          	ret

00000000800075d0 <userinit>:
    800075d0:	ff010113          	addi	sp,sp,-16
    800075d4:	00813423          	sd	s0,8(sp)
    800075d8:	01010413          	addi	s0,sp,16
    800075dc:	00813403          	ld	s0,8(sp)
    800075e0:	01010113          	addi	sp,sp,16
    800075e4:	ffffb317          	auipc	t1,0xffffb
    800075e8:	77430067          	jr	1908(t1) # 80002d58 <main>

00000000800075ec <either_copyout>:
    800075ec:	ff010113          	addi	sp,sp,-16
    800075f0:	00813023          	sd	s0,0(sp)
    800075f4:	00113423          	sd	ra,8(sp)
    800075f8:	01010413          	addi	s0,sp,16
    800075fc:	02051663          	bnez	a0,80007628 <either_copyout+0x3c>
    80007600:	00058513          	mv	a0,a1
    80007604:	00060593          	mv	a1,a2
    80007608:	0006861b          	sext.w	a2,a3
    8000760c:	00002097          	auipc	ra,0x2
    80007610:	c58080e7          	jalr	-936(ra) # 80009264 <__memmove>
    80007614:	00813083          	ld	ra,8(sp)
    80007618:	00013403          	ld	s0,0(sp)
    8000761c:	00000513          	li	a0,0
    80007620:	01010113          	addi	sp,sp,16
    80007624:	00008067          	ret
    80007628:	00003517          	auipc	a0,0x3
    8000762c:	19850513          	addi	a0,a0,408 # 8000a7c0 <CONSOLE_STATUS+0x7b0>
    80007630:	00001097          	auipc	ra,0x1
    80007634:	92c080e7          	jalr	-1748(ra) # 80007f5c <panic>

0000000080007638 <either_copyin>:
    80007638:	ff010113          	addi	sp,sp,-16
    8000763c:	00813023          	sd	s0,0(sp)
    80007640:	00113423          	sd	ra,8(sp)
    80007644:	01010413          	addi	s0,sp,16
    80007648:	02059463          	bnez	a1,80007670 <either_copyin+0x38>
    8000764c:	00060593          	mv	a1,a2
    80007650:	0006861b          	sext.w	a2,a3
    80007654:	00002097          	auipc	ra,0x2
    80007658:	c10080e7          	jalr	-1008(ra) # 80009264 <__memmove>
    8000765c:	00813083          	ld	ra,8(sp)
    80007660:	00013403          	ld	s0,0(sp)
    80007664:	00000513          	li	a0,0
    80007668:	01010113          	addi	sp,sp,16
    8000766c:	00008067          	ret
    80007670:	00003517          	auipc	a0,0x3
    80007674:	17850513          	addi	a0,a0,376 # 8000a7e8 <CONSOLE_STATUS+0x7d8>
    80007678:	00001097          	auipc	ra,0x1
    8000767c:	8e4080e7          	jalr	-1820(ra) # 80007f5c <panic>

0000000080007680 <trapinit>:
    80007680:	ff010113          	addi	sp,sp,-16
    80007684:	00813423          	sd	s0,8(sp)
    80007688:	01010413          	addi	s0,sp,16
    8000768c:	00813403          	ld	s0,8(sp)
    80007690:	00003597          	auipc	a1,0x3
    80007694:	18058593          	addi	a1,a1,384 # 8000a810 <CONSOLE_STATUS+0x800>
    80007698:	0000b517          	auipc	a0,0xb
    8000769c:	0b850513          	addi	a0,a0,184 # 80012750 <tickslock>
    800076a0:	01010113          	addi	sp,sp,16
    800076a4:	00001317          	auipc	t1,0x1
    800076a8:	5c430067          	jr	1476(t1) # 80008c68 <initlock>

00000000800076ac <trapinithart>:
    800076ac:	ff010113          	addi	sp,sp,-16
    800076b0:	00813423          	sd	s0,8(sp)
    800076b4:	01010413          	addi	s0,sp,16
    800076b8:	00000797          	auipc	a5,0x0
    800076bc:	2f878793          	addi	a5,a5,760 # 800079b0 <kernelvec>
    800076c0:	10579073          	csrw	stvec,a5
    800076c4:	00813403          	ld	s0,8(sp)
    800076c8:	01010113          	addi	sp,sp,16
    800076cc:	00008067          	ret

00000000800076d0 <usertrap>:
    800076d0:	ff010113          	addi	sp,sp,-16
    800076d4:	00813423          	sd	s0,8(sp)
    800076d8:	01010413          	addi	s0,sp,16
    800076dc:	00813403          	ld	s0,8(sp)
    800076e0:	01010113          	addi	sp,sp,16
    800076e4:	00008067          	ret

00000000800076e8 <usertrapret>:
    800076e8:	ff010113          	addi	sp,sp,-16
    800076ec:	00813423          	sd	s0,8(sp)
    800076f0:	01010413          	addi	s0,sp,16
    800076f4:	00813403          	ld	s0,8(sp)
    800076f8:	01010113          	addi	sp,sp,16
    800076fc:	00008067          	ret

0000000080007700 <kerneltrap>:
    80007700:	fe010113          	addi	sp,sp,-32
    80007704:	00813823          	sd	s0,16(sp)
    80007708:	00113c23          	sd	ra,24(sp)
    8000770c:	00913423          	sd	s1,8(sp)
    80007710:	02010413          	addi	s0,sp,32
    80007714:	142025f3          	csrr	a1,scause
    80007718:	100027f3          	csrr	a5,sstatus
    8000771c:	0027f793          	andi	a5,a5,2
    80007720:	10079c63          	bnez	a5,80007838 <kerneltrap+0x138>
    80007724:	142027f3          	csrr	a5,scause
    80007728:	0207ce63          	bltz	a5,80007764 <kerneltrap+0x64>
    8000772c:	00003517          	auipc	a0,0x3
    80007730:	12c50513          	addi	a0,a0,300 # 8000a858 <CONSOLE_STATUS+0x848>
    80007734:	00001097          	auipc	ra,0x1
    80007738:	884080e7          	jalr	-1916(ra) # 80007fb8 <__printf>
    8000773c:	141025f3          	csrr	a1,sepc
    80007740:	14302673          	csrr	a2,stval
    80007744:	00003517          	auipc	a0,0x3
    80007748:	12450513          	addi	a0,a0,292 # 8000a868 <CONSOLE_STATUS+0x858>
    8000774c:	00001097          	auipc	ra,0x1
    80007750:	86c080e7          	jalr	-1940(ra) # 80007fb8 <__printf>
    80007754:	00003517          	auipc	a0,0x3
    80007758:	12c50513          	addi	a0,a0,300 # 8000a880 <CONSOLE_STATUS+0x870>
    8000775c:	00001097          	auipc	ra,0x1
    80007760:	800080e7          	jalr	-2048(ra) # 80007f5c <panic>
    80007764:	0ff7f713          	andi	a4,a5,255
    80007768:	00900693          	li	a3,9
    8000776c:	04d70063          	beq	a4,a3,800077ac <kerneltrap+0xac>
    80007770:	fff00713          	li	a4,-1
    80007774:	03f71713          	slli	a4,a4,0x3f
    80007778:	00170713          	addi	a4,a4,1
    8000777c:	fae798e3          	bne	a5,a4,8000772c <kerneltrap+0x2c>
    80007780:	00000097          	auipc	ra,0x0
    80007784:	e00080e7          	jalr	-512(ra) # 80007580 <cpuid>
    80007788:	06050663          	beqz	a0,800077f4 <kerneltrap+0xf4>
    8000778c:	144027f3          	csrr	a5,sip
    80007790:	ffd7f793          	andi	a5,a5,-3
    80007794:	14479073          	csrw	sip,a5
    80007798:	01813083          	ld	ra,24(sp)
    8000779c:	01013403          	ld	s0,16(sp)
    800077a0:	00813483          	ld	s1,8(sp)
    800077a4:	02010113          	addi	sp,sp,32
    800077a8:	00008067          	ret
    800077ac:	00000097          	auipc	ra,0x0
    800077b0:	3c8080e7          	jalr	968(ra) # 80007b74 <plic_claim>
    800077b4:	00a00793          	li	a5,10
    800077b8:	00050493          	mv	s1,a0
    800077bc:	06f50863          	beq	a0,a5,8000782c <kerneltrap+0x12c>
    800077c0:	fc050ce3          	beqz	a0,80007798 <kerneltrap+0x98>
    800077c4:	00050593          	mv	a1,a0
    800077c8:	00003517          	auipc	a0,0x3
    800077cc:	07050513          	addi	a0,a0,112 # 8000a838 <CONSOLE_STATUS+0x828>
    800077d0:	00000097          	auipc	ra,0x0
    800077d4:	7e8080e7          	jalr	2024(ra) # 80007fb8 <__printf>
    800077d8:	01013403          	ld	s0,16(sp)
    800077dc:	01813083          	ld	ra,24(sp)
    800077e0:	00048513          	mv	a0,s1
    800077e4:	00813483          	ld	s1,8(sp)
    800077e8:	02010113          	addi	sp,sp,32
    800077ec:	00000317          	auipc	t1,0x0
    800077f0:	3c030067          	jr	960(t1) # 80007bac <plic_complete>
    800077f4:	0000b517          	auipc	a0,0xb
    800077f8:	f5c50513          	addi	a0,a0,-164 # 80012750 <tickslock>
    800077fc:	00001097          	auipc	ra,0x1
    80007800:	490080e7          	jalr	1168(ra) # 80008c8c <acquire>
    80007804:	00006717          	auipc	a4,0x6
    80007808:	c2070713          	addi	a4,a4,-992 # 8000d424 <ticks>
    8000780c:	00072783          	lw	a5,0(a4)
    80007810:	0000b517          	auipc	a0,0xb
    80007814:	f4050513          	addi	a0,a0,-192 # 80012750 <tickslock>
    80007818:	0017879b          	addiw	a5,a5,1
    8000781c:	00f72023          	sw	a5,0(a4)
    80007820:	00001097          	auipc	ra,0x1
    80007824:	538080e7          	jalr	1336(ra) # 80008d58 <release>
    80007828:	f65ff06f          	j	8000778c <kerneltrap+0x8c>
    8000782c:	00001097          	auipc	ra,0x1
    80007830:	094080e7          	jalr	148(ra) # 800088c0 <uartintr>
    80007834:	fa5ff06f          	j	800077d8 <kerneltrap+0xd8>
    80007838:	00003517          	auipc	a0,0x3
    8000783c:	fe050513          	addi	a0,a0,-32 # 8000a818 <CONSOLE_STATUS+0x808>
    80007840:	00000097          	auipc	ra,0x0
    80007844:	71c080e7          	jalr	1820(ra) # 80007f5c <panic>

0000000080007848 <clockintr>:
    80007848:	fe010113          	addi	sp,sp,-32
    8000784c:	00813823          	sd	s0,16(sp)
    80007850:	00913423          	sd	s1,8(sp)
    80007854:	00113c23          	sd	ra,24(sp)
    80007858:	02010413          	addi	s0,sp,32
    8000785c:	0000b497          	auipc	s1,0xb
    80007860:	ef448493          	addi	s1,s1,-268 # 80012750 <tickslock>
    80007864:	00048513          	mv	a0,s1
    80007868:	00001097          	auipc	ra,0x1
    8000786c:	424080e7          	jalr	1060(ra) # 80008c8c <acquire>
    80007870:	00006717          	auipc	a4,0x6
    80007874:	bb470713          	addi	a4,a4,-1100 # 8000d424 <ticks>
    80007878:	00072783          	lw	a5,0(a4)
    8000787c:	01013403          	ld	s0,16(sp)
    80007880:	01813083          	ld	ra,24(sp)
    80007884:	00048513          	mv	a0,s1
    80007888:	0017879b          	addiw	a5,a5,1
    8000788c:	00813483          	ld	s1,8(sp)
    80007890:	00f72023          	sw	a5,0(a4)
    80007894:	02010113          	addi	sp,sp,32
    80007898:	00001317          	auipc	t1,0x1
    8000789c:	4c030067          	jr	1216(t1) # 80008d58 <release>

00000000800078a0 <devintr>:
    800078a0:	142027f3          	csrr	a5,scause
    800078a4:	00000513          	li	a0,0
    800078a8:	0007c463          	bltz	a5,800078b0 <devintr+0x10>
    800078ac:	00008067          	ret
    800078b0:	fe010113          	addi	sp,sp,-32
    800078b4:	00813823          	sd	s0,16(sp)
    800078b8:	00113c23          	sd	ra,24(sp)
    800078bc:	00913423          	sd	s1,8(sp)
    800078c0:	02010413          	addi	s0,sp,32
    800078c4:	0ff7f713          	andi	a4,a5,255
    800078c8:	00900693          	li	a3,9
    800078cc:	04d70c63          	beq	a4,a3,80007924 <devintr+0x84>
    800078d0:	fff00713          	li	a4,-1
    800078d4:	03f71713          	slli	a4,a4,0x3f
    800078d8:	00170713          	addi	a4,a4,1
    800078dc:	00e78c63          	beq	a5,a4,800078f4 <devintr+0x54>
    800078e0:	01813083          	ld	ra,24(sp)
    800078e4:	01013403          	ld	s0,16(sp)
    800078e8:	00813483          	ld	s1,8(sp)
    800078ec:	02010113          	addi	sp,sp,32
    800078f0:	00008067          	ret
    800078f4:	00000097          	auipc	ra,0x0
    800078f8:	c8c080e7          	jalr	-884(ra) # 80007580 <cpuid>
    800078fc:	06050663          	beqz	a0,80007968 <devintr+0xc8>
    80007900:	144027f3          	csrr	a5,sip
    80007904:	ffd7f793          	andi	a5,a5,-3
    80007908:	14479073          	csrw	sip,a5
    8000790c:	01813083          	ld	ra,24(sp)
    80007910:	01013403          	ld	s0,16(sp)
    80007914:	00813483          	ld	s1,8(sp)
    80007918:	00200513          	li	a0,2
    8000791c:	02010113          	addi	sp,sp,32
    80007920:	00008067          	ret
    80007924:	00000097          	auipc	ra,0x0
    80007928:	250080e7          	jalr	592(ra) # 80007b74 <plic_claim>
    8000792c:	00a00793          	li	a5,10
    80007930:	00050493          	mv	s1,a0
    80007934:	06f50663          	beq	a0,a5,800079a0 <devintr+0x100>
    80007938:	00100513          	li	a0,1
    8000793c:	fa0482e3          	beqz	s1,800078e0 <devintr+0x40>
    80007940:	00048593          	mv	a1,s1
    80007944:	00003517          	auipc	a0,0x3
    80007948:	ef450513          	addi	a0,a0,-268 # 8000a838 <CONSOLE_STATUS+0x828>
    8000794c:	00000097          	auipc	ra,0x0
    80007950:	66c080e7          	jalr	1644(ra) # 80007fb8 <__printf>
    80007954:	00048513          	mv	a0,s1
    80007958:	00000097          	auipc	ra,0x0
    8000795c:	254080e7          	jalr	596(ra) # 80007bac <plic_complete>
    80007960:	00100513          	li	a0,1
    80007964:	f7dff06f          	j	800078e0 <devintr+0x40>
    80007968:	0000b517          	auipc	a0,0xb
    8000796c:	de850513          	addi	a0,a0,-536 # 80012750 <tickslock>
    80007970:	00001097          	auipc	ra,0x1
    80007974:	31c080e7          	jalr	796(ra) # 80008c8c <acquire>
    80007978:	00006717          	auipc	a4,0x6
    8000797c:	aac70713          	addi	a4,a4,-1364 # 8000d424 <ticks>
    80007980:	00072783          	lw	a5,0(a4)
    80007984:	0000b517          	auipc	a0,0xb
    80007988:	dcc50513          	addi	a0,a0,-564 # 80012750 <tickslock>
    8000798c:	0017879b          	addiw	a5,a5,1
    80007990:	00f72023          	sw	a5,0(a4)
    80007994:	00001097          	auipc	ra,0x1
    80007998:	3c4080e7          	jalr	964(ra) # 80008d58 <release>
    8000799c:	f65ff06f          	j	80007900 <devintr+0x60>
    800079a0:	00001097          	auipc	ra,0x1
    800079a4:	f20080e7          	jalr	-224(ra) # 800088c0 <uartintr>
    800079a8:	fadff06f          	j	80007954 <devintr+0xb4>
    800079ac:	0000                	unimp
	...

00000000800079b0 <kernelvec>:
    800079b0:	f0010113          	addi	sp,sp,-256
    800079b4:	00113023          	sd	ra,0(sp)
    800079b8:	00213423          	sd	sp,8(sp)
    800079bc:	00313823          	sd	gp,16(sp)
    800079c0:	00413c23          	sd	tp,24(sp)
    800079c4:	02513023          	sd	t0,32(sp)
    800079c8:	02613423          	sd	t1,40(sp)
    800079cc:	02713823          	sd	t2,48(sp)
    800079d0:	02813c23          	sd	s0,56(sp)
    800079d4:	04913023          	sd	s1,64(sp)
    800079d8:	04a13423          	sd	a0,72(sp)
    800079dc:	04b13823          	sd	a1,80(sp)
    800079e0:	04c13c23          	sd	a2,88(sp)
    800079e4:	06d13023          	sd	a3,96(sp)
    800079e8:	06e13423          	sd	a4,104(sp)
    800079ec:	06f13823          	sd	a5,112(sp)
    800079f0:	07013c23          	sd	a6,120(sp)
    800079f4:	09113023          	sd	a7,128(sp)
    800079f8:	09213423          	sd	s2,136(sp)
    800079fc:	09313823          	sd	s3,144(sp)
    80007a00:	09413c23          	sd	s4,152(sp)
    80007a04:	0b513023          	sd	s5,160(sp)
    80007a08:	0b613423          	sd	s6,168(sp)
    80007a0c:	0b713823          	sd	s7,176(sp)
    80007a10:	0b813c23          	sd	s8,184(sp)
    80007a14:	0d913023          	sd	s9,192(sp)
    80007a18:	0da13423          	sd	s10,200(sp)
    80007a1c:	0db13823          	sd	s11,208(sp)
    80007a20:	0dc13c23          	sd	t3,216(sp)
    80007a24:	0fd13023          	sd	t4,224(sp)
    80007a28:	0fe13423          	sd	t5,232(sp)
    80007a2c:	0ff13823          	sd	t6,240(sp)
    80007a30:	cd1ff0ef          	jal	ra,80007700 <kerneltrap>
    80007a34:	00013083          	ld	ra,0(sp)
    80007a38:	00813103          	ld	sp,8(sp)
    80007a3c:	01013183          	ld	gp,16(sp)
    80007a40:	02013283          	ld	t0,32(sp)
    80007a44:	02813303          	ld	t1,40(sp)
    80007a48:	03013383          	ld	t2,48(sp)
    80007a4c:	03813403          	ld	s0,56(sp)
    80007a50:	04013483          	ld	s1,64(sp)
    80007a54:	04813503          	ld	a0,72(sp)
    80007a58:	05013583          	ld	a1,80(sp)
    80007a5c:	05813603          	ld	a2,88(sp)
    80007a60:	06013683          	ld	a3,96(sp)
    80007a64:	06813703          	ld	a4,104(sp)
    80007a68:	07013783          	ld	a5,112(sp)
    80007a6c:	07813803          	ld	a6,120(sp)
    80007a70:	08013883          	ld	a7,128(sp)
    80007a74:	08813903          	ld	s2,136(sp)
    80007a78:	09013983          	ld	s3,144(sp)
    80007a7c:	09813a03          	ld	s4,152(sp)
    80007a80:	0a013a83          	ld	s5,160(sp)
    80007a84:	0a813b03          	ld	s6,168(sp)
    80007a88:	0b013b83          	ld	s7,176(sp)
    80007a8c:	0b813c03          	ld	s8,184(sp)
    80007a90:	0c013c83          	ld	s9,192(sp)
    80007a94:	0c813d03          	ld	s10,200(sp)
    80007a98:	0d013d83          	ld	s11,208(sp)
    80007a9c:	0d813e03          	ld	t3,216(sp)
    80007aa0:	0e013e83          	ld	t4,224(sp)
    80007aa4:	0e813f03          	ld	t5,232(sp)
    80007aa8:	0f013f83          	ld	t6,240(sp)
    80007aac:	10010113          	addi	sp,sp,256
    80007ab0:	10200073          	sret
    80007ab4:	00000013          	nop
    80007ab8:	00000013          	nop
    80007abc:	00000013          	nop

0000000080007ac0 <timervec>:
    80007ac0:	34051573          	csrrw	a0,mscratch,a0
    80007ac4:	00b53023          	sd	a1,0(a0)
    80007ac8:	00c53423          	sd	a2,8(a0)
    80007acc:	00d53823          	sd	a3,16(a0)
    80007ad0:	01853583          	ld	a1,24(a0)
    80007ad4:	02053603          	ld	a2,32(a0)
    80007ad8:	0005b683          	ld	a3,0(a1)
    80007adc:	00c686b3          	add	a3,a3,a2
    80007ae0:	00d5b023          	sd	a3,0(a1)
    80007ae4:	00200593          	li	a1,2
    80007ae8:	14459073          	csrw	sip,a1
    80007aec:	01053683          	ld	a3,16(a0)
    80007af0:	00853603          	ld	a2,8(a0)
    80007af4:	00053583          	ld	a1,0(a0)
    80007af8:	34051573          	csrrw	a0,mscratch,a0
    80007afc:	30200073          	mret

0000000080007b00 <plicinit>:
    80007b00:	ff010113          	addi	sp,sp,-16
    80007b04:	00813423          	sd	s0,8(sp)
    80007b08:	01010413          	addi	s0,sp,16
    80007b0c:	00813403          	ld	s0,8(sp)
    80007b10:	0c0007b7          	lui	a5,0xc000
    80007b14:	00100713          	li	a4,1
    80007b18:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80007b1c:	00e7a223          	sw	a4,4(a5)
    80007b20:	01010113          	addi	sp,sp,16
    80007b24:	00008067          	ret

0000000080007b28 <plicinithart>:
    80007b28:	ff010113          	addi	sp,sp,-16
    80007b2c:	00813023          	sd	s0,0(sp)
    80007b30:	00113423          	sd	ra,8(sp)
    80007b34:	01010413          	addi	s0,sp,16
    80007b38:	00000097          	auipc	ra,0x0
    80007b3c:	a48080e7          	jalr	-1464(ra) # 80007580 <cpuid>
    80007b40:	0085171b          	slliw	a4,a0,0x8
    80007b44:	0c0027b7          	lui	a5,0xc002
    80007b48:	00e787b3          	add	a5,a5,a4
    80007b4c:	40200713          	li	a4,1026
    80007b50:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007b54:	00813083          	ld	ra,8(sp)
    80007b58:	00013403          	ld	s0,0(sp)
    80007b5c:	00d5151b          	slliw	a0,a0,0xd
    80007b60:	0c2017b7          	lui	a5,0xc201
    80007b64:	00a78533          	add	a0,a5,a0
    80007b68:	00052023          	sw	zero,0(a0)
    80007b6c:	01010113          	addi	sp,sp,16
    80007b70:	00008067          	ret

0000000080007b74 <plic_claim>:
    80007b74:	ff010113          	addi	sp,sp,-16
    80007b78:	00813023          	sd	s0,0(sp)
    80007b7c:	00113423          	sd	ra,8(sp)
    80007b80:	01010413          	addi	s0,sp,16
    80007b84:	00000097          	auipc	ra,0x0
    80007b88:	9fc080e7          	jalr	-1540(ra) # 80007580 <cpuid>
    80007b8c:	00813083          	ld	ra,8(sp)
    80007b90:	00013403          	ld	s0,0(sp)
    80007b94:	00d5151b          	slliw	a0,a0,0xd
    80007b98:	0c2017b7          	lui	a5,0xc201
    80007b9c:	00a78533          	add	a0,a5,a0
    80007ba0:	00452503          	lw	a0,4(a0)
    80007ba4:	01010113          	addi	sp,sp,16
    80007ba8:	00008067          	ret

0000000080007bac <plic_complete>:
    80007bac:	fe010113          	addi	sp,sp,-32
    80007bb0:	00813823          	sd	s0,16(sp)
    80007bb4:	00913423          	sd	s1,8(sp)
    80007bb8:	00113c23          	sd	ra,24(sp)
    80007bbc:	02010413          	addi	s0,sp,32
    80007bc0:	00050493          	mv	s1,a0
    80007bc4:	00000097          	auipc	ra,0x0
    80007bc8:	9bc080e7          	jalr	-1604(ra) # 80007580 <cpuid>
    80007bcc:	01813083          	ld	ra,24(sp)
    80007bd0:	01013403          	ld	s0,16(sp)
    80007bd4:	00d5179b          	slliw	a5,a0,0xd
    80007bd8:	0c201737          	lui	a4,0xc201
    80007bdc:	00f707b3          	add	a5,a4,a5
    80007be0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80007be4:	00813483          	ld	s1,8(sp)
    80007be8:	02010113          	addi	sp,sp,32
    80007bec:	00008067          	ret

0000000080007bf0 <consolewrite>:
    80007bf0:	fb010113          	addi	sp,sp,-80
    80007bf4:	04813023          	sd	s0,64(sp)
    80007bf8:	04113423          	sd	ra,72(sp)
    80007bfc:	02913c23          	sd	s1,56(sp)
    80007c00:	03213823          	sd	s2,48(sp)
    80007c04:	03313423          	sd	s3,40(sp)
    80007c08:	03413023          	sd	s4,32(sp)
    80007c0c:	01513c23          	sd	s5,24(sp)
    80007c10:	05010413          	addi	s0,sp,80
    80007c14:	06c05c63          	blez	a2,80007c8c <consolewrite+0x9c>
    80007c18:	00060993          	mv	s3,a2
    80007c1c:	00050a13          	mv	s4,a0
    80007c20:	00058493          	mv	s1,a1
    80007c24:	00000913          	li	s2,0
    80007c28:	fff00a93          	li	s5,-1
    80007c2c:	01c0006f          	j	80007c48 <consolewrite+0x58>
    80007c30:	fbf44503          	lbu	a0,-65(s0)
    80007c34:	0019091b          	addiw	s2,s2,1
    80007c38:	00148493          	addi	s1,s1,1
    80007c3c:	00001097          	auipc	ra,0x1
    80007c40:	a9c080e7          	jalr	-1380(ra) # 800086d8 <uartputc>
    80007c44:	03298063          	beq	s3,s2,80007c64 <consolewrite+0x74>
    80007c48:	00048613          	mv	a2,s1
    80007c4c:	00100693          	li	a3,1
    80007c50:	000a0593          	mv	a1,s4
    80007c54:	fbf40513          	addi	a0,s0,-65
    80007c58:	00000097          	auipc	ra,0x0
    80007c5c:	9e0080e7          	jalr	-1568(ra) # 80007638 <either_copyin>
    80007c60:	fd5518e3          	bne	a0,s5,80007c30 <consolewrite+0x40>
    80007c64:	04813083          	ld	ra,72(sp)
    80007c68:	04013403          	ld	s0,64(sp)
    80007c6c:	03813483          	ld	s1,56(sp)
    80007c70:	02813983          	ld	s3,40(sp)
    80007c74:	02013a03          	ld	s4,32(sp)
    80007c78:	01813a83          	ld	s5,24(sp)
    80007c7c:	00090513          	mv	a0,s2
    80007c80:	03013903          	ld	s2,48(sp)
    80007c84:	05010113          	addi	sp,sp,80
    80007c88:	00008067          	ret
    80007c8c:	00000913          	li	s2,0
    80007c90:	fd5ff06f          	j	80007c64 <consolewrite+0x74>

0000000080007c94 <consoleread>:
    80007c94:	f9010113          	addi	sp,sp,-112
    80007c98:	06813023          	sd	s0,96(sp)
    80007c9c:	04913c23          	sd	s1,88(sp)
    80007ca0:	05213823          	sd	s2,80(sp)
    80007ca4:	05313423          	sd	s3,72(sp)
    80007ca8:	05413023          	sd	s4,64(sp)
    80007cac:	03513c23          	sd	s5,56(sp)
    80007cb0:	03613823          	sd	s6,48(sp)
    80007cb4:	03713423          	sd	s7,40(sp)
    80007cb8:	03813023          	sd	s8,32(sp)
    80007cbc:	06113423          	sd	ra,104(sp)
    80007cc0:	01913c23          	sd	s9,24(sp)
    80007cc4:	07010413          	addi	s0,sp,112
    80007cc8:	00060b93          	mv	s7,a2
    80007ccc:	00050913          	mv	s2,a0
    80007cd0:	00058c13          	mv	s8,a1
    80007cd4:	00060b1b          	sext.w	s6,a2
    80007cd8:	0000b497          	auipc	s1,0xb
    80007cdc:	aa048493          	addi	s1,s1,-1376 # 80012778 <cons>
    80007ce0:	00400993          	li	s3,4
    80007ce4:	fff00a13          	li	s4,-1
    80007ce8:	00a00a93          	li	s5,10
    80007cec:	05705e63          	blez	s7,80007d48 <consoleread+0xb4>
    80007cf0:	09c4a703          	lw	a4,156(s1)
    80007cf4:	0984a783          	lw	a5,152(s1)
    80007cf8:	0007071b          	sext.w	a4,a4
    80007cfc:	08e78463          	beq	a5,a4,80007d84 <consoleread+0xf0>
    80007d00:	07f7f713          	andi	a4,a5,127
    80007d04:	00e48733          	add	a4,s1,a4
    80007d08:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80007d0c:	0017869b          	addiw	a3,a5,1
    80007d10:	08d4ac23          	sw	a3,152(s1)
    80007d14:	00070c9b          	sext.w	s9,a4
    80007d18:	0b370663          	beq	a4,s3,80007dc4 <consoleread+0x130>
    80007d1c:	00100693          	li	a3,1
    80007d20:	f9f40613          	addi	a2,s0,-97
    80007d24:	000c0593          	mv	a1,s8
    80007d28:	00090513          	mv	a0,s2
    80007d2c:	f8e40fa3          	sb	a4,-97(s0)
    80007d30:	00000097          	auipc	ra,0x0
    80007d34:	8bc080e7          	jalr	-1860(ra) # 800075ec <either_copyout>
    80007d38:	01450863          	beq	a0,s4,80007d48 <consoleread+0xb4>
    80007d3c:	001c0c13          	addi	s8,s8,1
    80007d40:	fffb8b9b          	addiw	s7,s7,-1
    80007d44:	fb5c94e3          	bne	s9,s5,80007cec <consoleread+0x58>
    80007d48:	000b851b          	sext.w	a0,s7
    80007d4c:	06813083          	ld	ra,104(sp)
    80007d50:	06013403          	ld	s0,96(sp)
    80007d54:	05813483          	ld	s1,88(sp)
    80007d58:	05013903          	ld	s2,80(sp)
    80007d5c:	04813983          	ld	s3,72(sp)
    80007d60:	04013a03          	ld	s4,64(sp)
    80007d64:	03813a83          	ld	s5,56(sp)
    80007d68:	02813b83          	ld	s7,40(sp)
    80007d6c:	02013c03          	ld	s8,32(sp)
    80007d70:	01813c83          	ld	s9,24(sp)
    80007d74:	40ab053b          	subw	a0,s6,a0
    80007d78:	03013b03          	ld	s6,48(sp)
    80007d7c:	07010113          	addi	sp,sp,112
    80007d80:	00008067          	ret
    80007d84:	00001097          	auipc	ra,0x1
    80007d88:	1d8080e7          	jalr	472(ra) # 80008f5c <push_on>
    80007d8c:	0984a703          	lw	a4,152(s1)
    80007d90:	09c4a783          	lw	a5,156(s1)
    80007d94:	0007879b          	sext.w	a5,a5
    80007d98:	fef70ce3          	beq	a4,a5,80007d90 <consoleread+0xfc>
    80007d9c:	00001097          	auipc	ra,0x1
    80007da0:	234080e7          	jalr	564(ra) # 80008fd0 <pop_on>
    80007da4:	0984a783          	lw	a5,152(s1)
    80007da8:	07f7f713          	andi	a4,a5,127
    80007dac:	00e48733          	add	a4,s1,a4
    80007db0:	01874703          	lbu	a4,24(a4)
    80007db4:	0017869b          	addiw	a3,a5,1
    80007db8:	08d4ac23          	sw	a3,152(s1)
    80007dbc:	00070c9b          	sext.w	s9,a4
    80007dc0:	f5371ee3          	bne	a4,s3,80007d1c <consoleread+0x88>
    80007dc4:	000b851b          	sext.w	a0,s7
    80007dc8:	f96bf2e3          	bgeu	s7,s6,80007d4c <consoleread+0xb8>
    80007dcc:	08f4ac23          	sw	a5,152(s1)
    80007dd0:	f7dff06f          	j	80007d4c <consoleread+0xb8>

0000000080007dd4 <consputc>:
    80007dd4:	10000793          	li	a5,256
    80007dd8:	00f50663          	beq	a0,a5,80007de4 <consputc+0x10>
    80007ddc:	00001317          	auipc	t1,0x1
    80007de0:	9f430067          	jr	-1548(t1) # 800087d0 <uartputc_sync>
    80007de4:	ff010113          	addi	sp,sp,-16
    80007de8:	00113423          	sd	ra,8(sp)
    80007dec:	00813023          	sd	s0,0(sp)
    80007df0:	01010413          	addi	s0,sp,16
    80007df4:	00800513          	li	a0,8
    80007df8:	00001097          	auipc	ra,0x1
    80007dfc:	9d8080e7          	jalr	-1576(ra) # 800087d0 <uartputc_sync>
    80007e00:	02000513          	li	a0,32
    80007e04:	00001097          	auipc	ra,0x1
    80007e08:	9cc080e7          	jalr	-1588(ra) # 800087d0 <uartputc_sync>
    80007e0c:	00013403          	ld	s0,0(sp)
    80007e10:	00813083          	ld	ra,8(sp)
    80007e14:	00800513          	li	a0,8
    80007e18:	01010113          	addi	sp,sp,16
    80007e1c:	00001317          	auipc	t1,0x1
    80007e20:	9b430067          	jr	-1612(t1) # 800087d0 <uartputc_sync>

0000000080007e24 <consoleintr>:
    80007e24:	fe010113          	addi	sp,sp,-32
    80007e28:	00813823          	sd	s0,16(sp)
    80007e2c:	00913423          	sd	s1,8(sp)
    80007e30:	01213023          	sd	s2,0(sp)
    80007e34:	00113c23          	sd	ra,24(sp)
    80007e38:	02010413          	addi	s0,sp,32
    80007e3c:	0000b917          	auipc	s2,0xb
    80007e40:	93c90913          	addi	s2,s2,-1732 # 80012778 <cons>
    80007e44:	00050493          	mv	s1,a0
    80007e48:	00090513          	mv	a0,s2
    80007e4c:	00001097          	auipc	ra,0x1
    80007e50:	e40080e7          	jalr	-448(ra) # 80008c8c <acquire>
    80007e54:	02048c63          	beqz	s1,80007e8c <consoleintr+0x68>
    80007e58:	0a092783          	lw	a5,160(s2)
    80007e5c:	09892703          	lw	a4,152(s2)
    80007e60:	07f00693          	li	a3,127
    80007e64:	40e7873b          	subw	a4,a5,a4
    80007e68:	02e6e263          	bltu	a3,a4,80007e8c <consoleintr+0x68>
    80007e6c:	00d00713          	li	a4,13
    80007e70:	04e48063          	beq	s1,a4,80007eb0 <consoleintr+0x8c>
    80007e74:	07f7f713          	andi	a4,a5,127
    80007e78:	00e90733          	add	a4,s2,a4
    80007e7c:	0017879b          	addiw	a5,a5,1
    80007e80:	0af92023          	sw	a5,160(s2)
    80007e84:	00970c23          	sb	s1,24(a4)
    80007e88:	08f92e23          	sw	a5,156(s2)
    80007e8c:	01013403          	ld	s0,16(sp)
    80007e90:	01813083          	ld	ra,24(sp)
    80007e94:	00813483          	ld	s1,8(sp)
    80007e98:	00013903          	ld	s2,0(sp)
    80007e9c:	0000b517          	auipc	a0,0xb
    80007ea0:	8dc50513          	addi	a0,a0,-1828 # 80012778 <cons>
    80007ea4:	02010113          	addi	sp,sp,32
    80007ea8:	00001317          	auipc	t1,0x1
    80007eac:	eb030067          	jr	-336(t1) # 80008d58 <release>
    80007eb0:	00a00493          	li	s1,10
    80007eb4:	fc1ff06f          	j	80007e74 <consoleintr+0x50>

0000000080007eb8 <consoleinit>:
    80007eb8:	fe010113          	addi	sp,sp,-32
    80007ebc:	00113c23          	sd	ra,24(sp)
    80007ec0:	00813823          	sd	s0,16(sp)
    80007ec4:	00913423          	sd	s1,8(sp)
    80007ec8:	02010413          	addi	s0,sp,32
    80007ecc:	0000b497          	auipc	s1,0xb
    80007ed0:	8ac48493          	addi	s1,s1,-1876 # 80012778 <cons>
    80007ed4:	00048513          	mv	a0,s1
    80007ed8:	00003597          	auipc	a1,0x3
    80007edc:	9b858593          	addi	a1,a1,-1608 # 8000a890 <CONSOLE_STATUS+0x880>
    80007ee0:	00001097          	auipc	ra,0x1
    80007ee4:	d88080e7          	jalr	-632(ra) # 80008c68 <initlock>
    80007ee8:	00000097          	auipc	ra,0x0
    80007eec:	7ac080e7          	jalr	1964(ra) # 80008694 <uartinit>
    80007ef0:	01813083          	ld	ra,24(sp)
    80007ef4:	01013403          	ld	s0,16(sp)
    80007ef8:	00000797          	auipc	a5,0x0
    80007efc:	d9c78793          	addi	a5,a5,-612 # 80007c94 <consoleread>
    80007f00:	0af4bc23          	sd	a5,184(s1)
    80007f04:	00000797          	auipc	a5,0x0
    80007f08:	cec78793          	addi	a5,a5,-788 # 80007bf0 <consolewrite>
    80007f0c:	0cf4b023          	sd	a5,192(s1)
    80007f10:	00813483          	ld	s1,8(sp)
    80007f14:	02010113          	addi	sp,sp,32
    80007f18:	00008067          	ret

0000000080007f1c <console_read>:
    80007f1c:	ff010113          	addi	sp,sp,-16
    80007f20:	00813423          	sd	s0,8(sp)
    80007f24:	01010413          	addi	s0,sp,16
    80007f28:	00813403          	ld	s0,8(sp)
    80007f2c:	0000b317          	auipc	t1,0xb
    80007f30:	90433303          	ld	t1,-1788(t1) # 80012830 <devsw+0x10>
    80007f34:	01010113          	addi	sp,sp,16
    80007f38:	00030067          	jr	t1

0000000080007f3c <console_write>:
    80007f3c:	ff010113          	addi	sp,sp,-16
    80007f40:	00813423          	sd	s0,8(sp)
    80007f44:	01010413          	addi	s0,sp,16
    80007f48:	00813403          	ld	s0,8(sp)
    80007f4c:	0000b317          	auipc	t1,0xb
    80007f50:	8ec33303          	ld	t1,-1812(t1) # 80012838 <devsw+0x18>
    80007f54:	01010113          	addi	sp,sp,16
    80007f58:	00030067          	jr	t1

0000000080007f5c <panic>:
    80007f5c:	fe010113          	addi	sp,sp,-32
    80007f60:	00113c23          	sd	ra,24(sp)
    80007f64:	00813823          	sd	s0,16(sp)
    80007f68:	00913423          	sd	s1,8(sp)
    80007f6c:	02010413          	addi	s0,sp,32
    80007f70:	00050493          	mv	s1,a0
    80007f74:	00003517          	auipc	a0,0x3
    80007f78:	92450513          	addi	a0,a0,-1756 # 8000a898 <CONSOLE_STATUS+0x888>
    80007f7c:	0000b797          	auipc	a5,0xb
    80007f80:	9407ae23          	sw	zero,-1700(a5) # 800128d8 <pr+0x18>
    80007f84:	00000097          	auipc	ra,0x0
    80007f88:	034080e7          	jalr	52(ra) # 80007fb8 <__printf>
    80007f8c:	00048513          	mv	a0,s1
    80007f90:	00000097          	auipc	ra,0x0
    80007f94:	028080e7          	jalr	40(ra) # 80007fb8 <__printf>
    80007f98:	00002517          	auipc	a0,0x2
    80007f9c:	3b050513          	addi	a0,a0,944 # 8000a348 <CONSOLE_STATUS+0x338>
    80007fa0:	00000097          	auipc	ra,0x0
    80007fa4:	018080e7          	jalr	24(ra) # 80007fb8 <__printf>
    80007fa8:	00100793          	li	a5,1
    80007fac:	00005717          	auipc	a4,0x5
    80007fb0:	46f72e23          	sw	a5,1148(a4) # 8000d428 <panicked>
    80007fb4:	0000006f          	j	80007fb4 <panic+0x58>

0000000080007fb8 <__printf>:
    80007fb8:	f3010113          	addi	sp,sp,-208
    80007fbc:	08813023          	sd	s0,128(sp)
    80007fc0:	07313423          	sd	s3,104(sp)
    80007fc4:	09010413          	addi	s0,sp,144
    80007fc8:	05813023          	sd	s8,64(sp)
    80007fcc:	08113423          	sd	ra,136(sp)
    80007fd0:	06913c23          	sd	s1,120(sp)
    80007fd4:	07213823          	sd	s2,112(sp)
    80007fd8:	07413023          	sd	s4,96(sp)
    80007fdc:	05513c23          	sd	s5,88(sp)
    80007fe0:	05613823          	sd	s6,80(sp)
    80007fe4:	05713423          	sd	s7,72(sp)
    80007fe8:	03913c23          	sd	s9,56(sp)
    80007fec:	03a13823          	sd	s10,48(sp)
    80007ff0:	03b13423          	sd	s11,40(sp)
    80007ff4:	0000b317          	auipc	t1,0xb
    80007ff8:	8cc30313          	addi	t1,t1,-1844 # 800128c0 <pr>
    80007ffc:	01832c03          	lw	s8,24(t1)
    80008000:	00b43423          	sd	a1,8(s0)
    80008004:	00c43823          	sd	a2,16(s0)
    80008008:	00d43c23          	sd	a3,24(s0)
    8000800c:	02e43023          	sd	a4,32(s0)
    80008010:	02f43423          	sd	a5,40(s0)
    80008014:	03043823          	sd	a6,48(s0)
    80008018:	03143c23          	sd	a7,56(s0)
    8000801c:	00050993          	mv	s3,a0
    80008020:	4a0c1663          	bnez	s8,800084cc <__printf+0x514>
    80008024:	60098c63          	beqz	s3,8000863c <__printf+0x684>
    80008028:	0009c503          	lbu	a0,0(s3)
    8000802c:	00840793          	addi	a5,s0,8
    80008030:	f6f43c23          	sd	a5,-136(s0)
    80008034:	00000493          	li	s1,0
    80008038:	22050063          	beqz	a0,80008258 <__printf+0x2a0>
    8000803c:	00002a37          	lui	s4,0x2
    80008040:	00018ab7          	lui	s5,0x18
    80008044:	000f4b37          	lui	s6,0xf4
    80008048:	00989bb7          	lui	s7,0x989
    8000804c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80008050:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80008054:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80008058:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000805c:	00148c9b          	addiw	s9,s1,1
    80008060:	02500793          	li	a5,37
    80008064:	01998933          	add	s2,s3,s9
    80008068:	38f51263          	bne	a0,a5,800083ec <__printf+0x434>
    8000806c:	00094783          	lbu	a5,0(s2)
    80008070:	00078c9b          	sext.w	s9,a5
    80008074:	1e078263          	beqz	a5,80008258 <__printf+0x2a0>
    80008078:	0024849b          	addiw	s1,s1,2
    8000807c:	07000713          	li	a4,112
    80008080:	00998933          	add	s2,s3,s1
    80008084:	38e78a63          	beq	a5,a4,80008418 <__printf+0x460>
    80008088:	20f76863          	bltu	a4,a5,80008298 <__printf+0x2e0>
    8000808c:	42a78863          	beq	a5,a0,800084bc <__printf+0x504>
    80008090:	06400713          	li	a4,100
    80008094:	40e79663          	bne	a5,a4,800084a0 <__printf+0x4e8>
    80008098:	f7843783          	ld	a5,-136(s0)
    8000809c:	0007a603          	lw	a2,0(a5)
    800080a0:	00878793          	addi	a5,a5,8
    800080a4:	f6f43c23          	sd	a5,-136(s0)
    800080a8:	42064a63          	bltz	a2,800084dc <__printf+0x524>
    800080ac:	00a00713          	li	a4,10
    800080b0:	02e677bb          	remuw	a5,a2,a4
    800080b4:	00003d97          	auipc	s11,0x3
    800080b8:	80cd8d93          	addi	s11,s11,-2036 # 8000a8c0 <digits>
    800080bc:	00900593          	li	a1,9
    800080c0:	0006051b          	sext.w	a0,a2
    800080c4:	00000c93          	li	s9,0
    800080c8:	02079793          	slli	a5,a5,0x20
    800080cc:	0207d793          	srli	a5,a5,0x20
    800080d0:	00fd87b3          	add	a5,s11,a5
    800080d4:	0007c783          	lbu	a5,0(a5)
    800080d8:	02e656bb          	divuw	a3,a2,a4
    800080dc:	f8f40023          	sb	a5,-128(s0)
    800080e0:	14c5d863          	bge	a1,a2,80008230 <__printf+0x278>
    800080e4:	06300593          	li	a1,99
    800080e8:	00100c93          	li	s9,1
    800080ec:	02e6f7bb          	remuw	a5,a3,a4
    800080f0:	02079793          	slli	a5,a5,0x20
    800080f4:	0207d793          	srli	a5,a5,0x20
    800080f8:	00fd87b3          	add	a5,s11,a5
    800080fc:	0007c783          	lbu	a5,0(a5)
    80008100:	02e6d73b          	divuw	a4,a3,a4
    80008104:	f8f400a3          	sb	a5,-127(s0)
    80008108:	12a5f463          	bgeu	a1,a0,80008230 <__printf+0x278>
    8000810c:	00a00693          	li	a3,10
    80008110:	00900593          	li	a1,9
    80008114:	02d777bb          	remuw	a5,a4,a3
    80008118:	02079793          	slli	a5,a5,0x20
    8000811c:	0207d793          	srli	a5,a5,0x20
    80008120:	00fd87b3          	add	a5,s11,a5
    80008124:	0007c503          	lbu	a0,0(a5)
    80008128:	02d757bb          	divuw	a5,a4,a3
    8000812c:	f8a40123          	sb	a0,-126(s0)
    80008130:	48e5f263          	bgeu	a1,a4,800085b4 <__printf+0x5fc>
    80008134:	06300513          	li	a0,99
    80008138:	02d7f5bb          	remuw	a1,a5,a3
    8000813c:	02059593          	slli	a1,a1,0x20
    80008140:	0205d593          	srli	a1,a1,0x20
    80008144:	00bd85b3          	add	a1,s11,a1
    80008148:	0005c583          	lbu	a1,0(a1)
    8000814c:	02d7d7bb          	divuw	a5,a5,a3
    80008150:	f8b401a3          	sb	a1,-125(s0)
    80008154:	48e57263          	bgeu	a0,a4,800085d8 <__printf+0x620>
    80008158:	3e700513          	li	a0,999
    8000815c:	02d7f5bb          	remuw	a1,a5,a3
    80008160:	02059593          	slli	a1,a1,0x20
    80008164:	0205d593          	srli	a1,a1,0x20
    80008168:	00bd85b3          	add	a1,s11,a1
    8000816c:	0005c583          	lbu	a1,0(a1)
    80008170:	02d7d7bb          	divuw	a5,a5,a3
    80008174:	f8b40223          	sb	a1,-124(s0)
    80008178:	46e57663          	bgeu	a0,a4,800085e4 <__printf+0x62c>
    8000817c:	02d7f5bb          	remuw	a1,a5,a3
    80008180:	02059593          	slli	a1,a1,0x20
    80008184:	0205d593          	srli	a1,a1,0x20
    80008188:	00bd85b3          	add	a1,s11,a1
    8000818c:	0005c583          	lbu	a1,0(a1)
    80008190:	02d7d7bb          	divuw	a5,a5,a3
    80008194:	f8b402a3          	sb	a1,-123(s0)
    80008198:	46ea7863          	bgeu	s4,a4,80008608 <__printf+0x650>
    8000819c:	02d7f5bb          	remuw	a1,a5,a3
    800081a0:	02059593          	slli	a1,a1,0x20
    800081a4:	0205d593          	srli	a1,a1,0x20
    800081a8:	00bd85b3          	add	a1,s11,a1
    800081ac:	0005c583          	lbu	a1,0(a1)
    800081b0:	02d7d7bb          	divuw	a5,a5,a3
    800081b4:	f8b40323          	sb	a1,-122(s0)
    800081b8:	3eeaf863          	bgeu	s5,a4,800085a8 <__printf+0x5f0>
    800081bc:	02d7f5bb          	remuw	a1,a5,a3
    800081c0:	02059593          	slli	a1,a1,0x20
    800081c4:	0205d593          	srli	a1,a1,0x20
    800081c8:	00bd85b3          	add	a1,s11,a1
    800081cc:	0005c583          	lbu	a1,0(a1)
    800081d0:	02d7d7bb          	divuw	a5,a5,a3
    800081d4:	f8b403a3          	sb	a1,-121(s0)
    800081d8:	42eb7e63          	bgeu	s6,a4,80008614 <__printf+0x65c>
    800081dc:	02d7f5bb          	remuw	a1,a5,a3
    800081e0:	02059593          	slli	a1,a1,0x20
    800081e4:	0205d593          	srli	a1,a1,0x20
    800081e8:	00bd85b3          	add	a1,s11,a1
    800081ec:	0005c583          	lbu	a1,0(a1)
    800081f0:	02d7d7bb          	divuw	a5,a5,a3
    800081f4:	f8b40423          	sb	a1,-120(s0)
    800081f8:	42ebfc63          	bgeu	s7,a4,80008630 <__printf+0x678>
    800081fc:	02079793          	slli	a5,a5,0x20
    80008200:	0207d793          	srli	a5,a5,0x20
    80008204:	00fd8db3          	add	s11,s11,a5
    80008208:	000dc703          	lbu	a4,0(s11)
    8000820c:	00a00793          	li	a5,10
    80008210:	00900c93          	li	s9,9
    80008214:	f8e404a3          	sb	a4,-119(s0)
    80008218:	00065c63          	bgez	a2,80008230 <__printf+0x278>
    8000821c:	f9040713          	addi	a4,s0,-112
    80008220:	00f70733          	add	a4,a4,a5
    80008224:	02d00693          	li	a3,45
    80008228:	fed70823          	sb	a3,-16(a4)
    8000822c:	00078c93          	mv	s9,a5
    80008230:	f8040793          	addi	a5,s0,-128
    80008234:	01978cb3          	add	s9,a5,s9
    80008238:	f7f40d13          	addi	s10,s0,-129
    8000823c:	000cc503          	lbu	a0,0(s9)
    80008240:	fffc8c93          	addi	s9,s9,-1
    80008244:	00000097          	auipc	ra,0x0
    80008248:	b90080e7          	jalr	-1136(ra) # 80007dd4 <consputc>
    8000824c:	ffac98e3          	bne	s9,s10,8000823c <__printf+0x284>
    80008250:	00094503          	lbu	a0,0(s2)
    80008254:	e00514e3          	bnez	a0,8000805c <__printf+0xa4>
    80008258:	1a0c1663          	bnez	s8,80008404 <__printf+0x44c>
    8000825c:	08813083          	ld	ra,136(sp)
    80008260:	08013403          	ld	s0,128(sp)
    80008264:	07813483          	ld	s1,120(sp)
    80008268:	07013903          	ld	s2,112(sp)
    8000826c:	06813983          	ld	s3,104(sp)
    80008270:	06013a03          	ld	s4,96(sp)
    80008274:	05813a83          	ld	s5,88(sp)
    80008278:	05013b03          	ld	s6,80(sp)
    8000827c:	04813b83          	ld	s7,72(sp)
    80008280:	04013c03          	ld	s8,64(sp)
    80008284:	03813c83          	ld	s9,56(sp)
    80008288:	03013d03          	ld	s10,48(sp)
    8000828c:	02813d83          	ld	s11,40(sp)
    80008290:	0d010113          	addi	sp,sp,208
    80008294:	00008067          	ret
    80008298:	07300713          	li	a4,115
    8000829c:	1ce78a63          	beq	a5,a4,80008470 <__printf+0x4b8>
    800082a0:	07800713          	li	a4,120
    800082a4:	1ee79e63          	bne	a5,a4,800084a0 <__printf+0x4e8>
    800082a8:	f7843783          	ld	a5,-136(s0)
    800082ac:	0007a703          	lw	a4,0(a5)
    800082b0:	00878793          	addi	a5,a5,8
    800082b4:	f6f43c23          	sd	a5,-136(s0)
    800082b8:	28074263          	bltz	a4,8000853c <__printf+0x584>
    800082bc:	00002d97          	auipc	s11,0x2
    800082c0:	604d8d93          	addi	s11,s11,1540 # 8000a8c0 <digits>
    800082c4:	00f77793          	andi	a5,a4,15
    800082c8:	00fd87b3          	add	a5,s11,a5
    800082cc:	0007c683          	lbu	a3,0(a5)
    800082d0:	00f00613          	li	a2,15
    800082d4:	0007079b          	sext.w	a5,a4
    800082d8:	f8d40023          	sb	a3,-128(s0)
    800082dc:	0047559b          	srliw	a1,a4,0x4
    800082e0:	0047569b          	srliw	a3,a4,0x4
    800082e4:	00000c93          	li	s9,0
    800082e8:	0ee65063          	bge	a2,a4,800083c8 <__printf+0x410>
    800082ec:	00f6f693          	andi	a3,a3,15
    800082f0:	00dd86b3          	add	a3,s11,a3
    800082f4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800082f8:	0087d79b          	srliw	a5,a5,0x8
    800082fc:	00100c93          	li	s9,1
    80008300:	f8d400a3          	sb	a3,-127(s0)
    80008304:	0cb67263          	bgeu	a2,a1,800083c8 <__printf+0x410>
    80008308:	00f7f693          	andi	a3,a5,15
    8000830c:	00dd86b3          	add	a3,s11,a3
    80008310:	0006c583          	lbu	a1,0(a3)
    80008314:	00f00613          	li	a2,15
    80008318:	0047d69b          	srliw	a3,a5,0x4
    8000831c:	f8b40123          	sb	a1,-126(s0)
    80008320:	0047d593          	srli	a1,a5,0x4
    80008324:	28f67e63          	bgeu	a2,a5,800085c0 <__printf+0x608>
    80008328:	00f6f693          	andi	a3,a3,15
    8000832c:	00dd86b3          	add	a3,s11,a3
    80008330:	0006c503          	lbu	a0,0(a3)
    80008334:	0087d813          	srli	a6,a5,0x8
    80008338:	0087d69b          	srliw	a3,a5,0x8
    8000833c:	f8a401a3          	sb	a0,-125(s0)
    80008340:	28b67663          	bgeu	a2,a1,800085cc <__printf+0x614>
    80008344:	00f6f693          	andi	a3,a3,15
    80008348:	00dd86b3          	add	a3,s11,a3
    8000834c:	0006c583          	lbu	a1,0(a3)
    80008350:	00c7d513          	srli	a0,a5,0xc
    80008354:	00c7d69b          	srliw	a3,a5,0xc
    80008358:	f8b40223          	sb	a1,-124(s0)
    8000835c:	29067a63          	bgeu	a2,a6,800085f0 <__printf+0x638>
    80008360:	00f6f693          	andi	a3,a3,15
    80008364:	00dd86b3          	add	a3,s11,a3
    80008368:	0006c583          	lbu	a1,0(a3)
    8000836c:	0107d813          	srli	a6,a5,0x10
    80008370:	0107d69b          	srliw	a3,a5,0x10
    80008374:	f8b402a3          	sb	a1,-123(s0)
    80008378:	28a67263          	bgeu	a2,a0,800085fc <__printf+0x644>
    8000837c:	00f6f693          	andi	a3,a3,15
    80008380:	00dd86b3          	add	a3,s11,a3
    80008384:	0006c683          	lbu	a3,0(a3)
    80008388:	0147d79b          	srliw	a5,a5,0x14
    8000838c:	f8d40323          	sb	a3,-122(s0)
    80008390:	21067663          	bgeu	a2,a6,8000859c <__printf+0x5e4>
    80008394:	02079793          	slli	a5,a5,0x20
    80008398:	0207d793          	srli	a5,a5,0x20
    8000839c:	00fd8db3          	add	s11,s11,a5
    800083a0:	000dc683          	lbu	a3,0(s11)
    800083a4:	00800793          	li	a5,8
    800083a8:	00700c93          	li	s9,7
    800083ac:	f8d403a3          	sb	a3,-121(s0)
    800083b0:	00075c63          	bgez	a4,800083c8 <__printf+0x410>
    800083b4:	f9040713          	addi	a4,s0,-112
    800083b8:	00f70733          	add	a4,a4,a5
    800083bc:	02d00693          	li	a3,45
    800083c0:	fed70823          	sb	a3,-16(a4)
    800083c4:	00078c93          	mv	s9,a5
    800083c8:	f8040793          	addi	a5,s0,-128
    800083cc:	01978cb3          	add	s9,a5,s9
    800083d0:	f7f40d13          	addi	s10,s0,-129
    800083d4:	000cc503          	lbu	a0,0(s9)
    800083d8:	fffc8c93          	addi	s9,s9,-1
    800083dc:	00000097          	auipc	ra,0x0
    800083e0:	9f8080e7          	jalr	-1544(ra) # 80007dd4 <consputc>
    800083e4:	ff9d18e3          	bne	s10,s9,800083d4 <__printf+0x41c>
    800083e8:	0100006f          	j	800083f8 <__printf+0x440>
    800083ec:	00000097          	auipc	ra,0x0
    800083f0:	9e8080e7          	jalr	-1560(ra) # 80007dd4 <consputc>
    800083f4:	000c8493          	mv	s1,s9
    800083f8:	00094503          	lbu	a0,0(s2)
    800083fc:	c60510e3          	bnez	a0,8000805c <__printf+0xa4>
    80008400:	e40c0ee3          	beqz	s8,8000825c <__printf+0x2a4>
    80008404:	0000a517          	auipc	a0,0xa
    80008408:	4bc50513          	addi	a0,a0,1212 # 800128c0 <pr>
    8000840c:	00001097          	auipc	ra,0x1
    80008410:	94c080e7          	jalr	-1716(ra) # 80008d58 <release>
    80008414:	e49ff06f          	j	8000825c <__printf+0x2a4>
    80008418:	f7843783          	ld	a5,-136(s0)
    8000841c:	03000513          	li	a0,48
    80008420:	01000d13          	li	s10,16
    80008424:	00878713          	addi	a4,a5,8
    80008428:	0007bc83          	ld	s9,0(a5)
    8000842c:	f6e43c23          	sd	a4,-136(s0)
    80008430:	00000097          	auipc	ra,0x0
    80008434:	9a4080e7          	jalr	-1628(ra) # 80007dd4 <consputc>
    80008438:	07800513          	li	a0,120
    8000843c:	00000097          	auipc	ra,0x0
    80008440:	998080e7          	jalr	-1640(ra) # 80007dd4 <consputc>
    80008444:	00002d97          	auipc	s11,0x2
    80008448:	47cd8d93          	addi	s11,s11,1148 # 8000a8c0 <digits>
    8000844c:	03ccd793          	srli	a5,s9,0x3c
    80008450:	00fd87b3          	add	a5,s11,a5
    80008454:	0007c503          	lbu	a0,0(a5)
    80008458:	fffd0d1b          	addiw	s10,s10,-1
    8000845c:	004c9c93          	slli	s9,s9,0x4
    80008460:	00000097          	auipc	ra,0x0
    80008464:	974080e7          	jalr	-1676(ra) # 80007dd4 <consputc>
    80008468:	fe0d12e3          	bnez	s10,8000844c <__printf+0x494>
    8000846c:	f8dff06f          	j	800083f8 <__printf+0x440>
    80008470:	f7843783          	ld	a5,-136(s0)
    80008474:	0007bc83          	ld	s9,0(a5)
    80008478:	00878793          	addi	a5,a5,8
    8000847c:	f6f43c23          	sd	a5,-136(s0)
    80008480:	000c9a63          	bnez	s9,80008494 <__printf+0x4dc>
    80008484:	1080006f          	j	8000858c <__printf+0x5d4>
    80008488:	001c8c93          	addi	s9,s9,1
    8000848c:	00000097          	auipc	ra,0x0
    80008490:	948080e7          	jalr	-1720(ra) # 80007dd4 <consputc>
    80008494:	000cc503          	lbu	a0,0(s9)
    80008498:	fe0518e3          	bnez	a0,80008488 <__printf+0x4d0>
    8000849c:	f5dff06f          	j	800083f8 <__printf+0x440>
    800084a0:	02500513          	li	a0,37
    800084a4:	00000097          	auipc	ra,0x0
    800084a8:	930080e7          	jalr	-1744(ra) # 80007dd4 <consputc>
    800084ac:	000c8513          	mv	a0,s9
    800084b0:	00000097          	auipc	ra,0x0
    800084b4:	924080e7          	jalr	-1756(ra) # 80007dd4 <consputc>
    800084b8:	f41ff06f          	j	800083f8 <__printf+0x440>
    800084bc:	02500513          	li	a0,37
    800084c0:	00000097          	auipc	ra,0x0
    800084c4:	914080e7          	jalr	-1772(ra) # 80007dd4 <consputc>
    800084c8:	f31ff06f          	j	800083f8 <__printf+0x440>
    800084cc:	00030513          	mv	a0,t1
    800084d0:	00000097          	auipc	ra,0x0
    800084d4:	7bc080e7          	jalr	1980(ra) # 80008c8c <acquire>
    800084d8:	b4dff06f          	j	80008024 <__printf+0x6c>
    800084dc:	40c0053b          	negw	a0,a2
    800084e0:	00a00713          	li	a4,10
    800084e4:	02e576bb          	remuw	a3,a0,a4
    800084e8:	00002d97          	auipc	s11,0x2
    800084ec:	3d8d8d93          	addi	s11,s11,984 # 8000a8c0 <digits>
    800084f0:	ff700593          	li	a1,-9
    800084f4:	02069693          	slli	a3,a3,0x20
    800084f8:	0206d693          	srli	a3,a3,0x20
    800084fc:	00dd86b3          	add	a3,s11,a3
    80008500:	0006c683          	lbu	a3,0(a3)
    80008504:	02e557bb          	divuw	a5,a0,a4
    80008508:	f8d40023          	sb	a3,-128(s0)
    8000850c:	10b65e63          	bge	a2,a1,80008628 <__printf+0x670>
    80008510:	06300593          	li	a1,99
    80008514:	02e7f6bb          	remuw	a3,a5,a4
    80008518:	02069693          	slli	a3,a3,0x20
    8000851c:	0206d693          	srli	a3,a3,0x20
    80008520:	00dd86b3          	add	a3,s11,a3
    80008524:	0006c683          	lbu	a3,0(a3)
    80008528:	02e7d73b          	divuw	a4,a5,a4
    8000852c:	00200793          	li	a5,2
    80008530:	f8d400a3          	sb	a3,-127(s0)
    80008534:	bca5ece3          	bltu	a1,a0,8000810c <__printf+0x154>
    80008538:	ce5ff06f          	j	8000821c <__printf+0x264>
    8000853c:	40e007bb          	negw	a5,a4
    80008540:	00002d97          	auipc	s11,0x2
    80008544:	380d8d93          	addi	s11,s11,896 # 8000a8c0 <digits>
    80008548:	00f7f693          	andi	a3,a5,15
    8000854c:	00dd86b3          	add	a3,s11,a3
    80008550:	0006c583          	lbu	a1,0(a3)
    80008554:	ff100613          	li	a2,-15
    80008558:	0047d69b          	srliw	a3,a5,0x4
    8000855c:	f8b40023          	sb	a1,-128(s0)
    80008560:	0047d59b          	srliw	a1,a5,0x4
    80008564:	0ac75e63          	bge	a4,a2,80008620 <__printf+0x668>
    80008568:	00f6f693          	andi	a3,a3,15
    8000856c:	00dd86b3          	add	a3,s11,a3
    80008570:	0006c603          	lbu	a2,0(a3)
    80008574:	00f00693          	li	a3,15
    80008578:	0087d79b          	srliw	a5,a5,0x8
    8000857c:	f8c400a3          	sb	a2,-127(s0)
    80008580:	d8b6e4e3          	bltu	a3,a1,80008308 <__printf+0x350>
    80008584:	00200793          	li	a5,2
    80008588:	e2dff06f          	j	800083b4 <__printf+0x3fc>
    8000858c:	00002c97          	auipc	s9,0x2
    80008590:	314c8c93          	addi	s9,s9,788 # 8000a8a0 <CONSOLE_STATUS+0x890>
    80008594:	02800513          	li	a0,40
    80008598:	ef1ff06f          	j	80008488 <__printf+0x4d0>
    8000859c:	00700793          	li	a5,7
    800085a0:	00600c93          	li	s9,6
    800085a4:	e0dff06f          	j	800083b0 <__printf+0x3f8>
    800085a8:	00700793          	li	a5,7
    800085ac:	00600c93          	li	s9,6
    800085b0:	c69ff06f          	j	80008218 <__printf+0x260>
    800085b4:	00300793          	li	a5,3
    800085b8:	00200c93          	li	s9,2
    800085bc:	c5dff06f          	j	80008218 <__printf+0x260>
    800085c0:	00300793          	li	a5,3
    800085c4:	00200c93          	li	s9,2
    800085c8:	de9ff06f          	j	800083b0 <__printf+0x3f8>
    800085cc:	00400793          	li	a5,4
    800085d0:	00300c93          	li	s9,3
    800085d4:	dddff06f          	j	800083b0 <__printf+0x3f8>
    800085d8:	00400793          	li	a5,4
    800085dc:	00300c93          	li	s9,3
    800085e0:	c39ff06f          	j	80008218 <__printf+0x260>
    800085e4:	00500793          	li	a5,5
    800085e8:	00400c93          	li	s9,4
    800085ec:	c2dff06f          	j	80008218 <__printf+0x260>
    800085f0:	00500793          	li	a5,5
    800085f4:	00400c93          	li	s9,4
    800085f8:	db9ff06f          	j	800083b0 <__printf+0x3f8>
    800085fc:	00600793          	li	a5,6
    80008600:	00500c93          	li	s9,5
    80008604:	dadff06f          	j	800083b0 <__printf+0x3f8>
    80008608:	00600793          	li	a5,6
    8000860c:	00500c93          	li	s9,5
    80008610:	c09ff06f          	j	80008218 <__printf+0x260>
    80008614:	00800793          	li	a5,8
    80008618:	00700c93          	li	s9,7
    8000861c:	bfdff06f          	j	80008218 <__printf+0x260>
    80008620:	00100793          	li	a5,1
    80008624:	d91ff06f          	j	800083b4 <__printf+0x3fc>
    80008628:	00100793          	li	a5,1
    8000862c:	bf1ff06f          	j	8000821c <__printf+0x264>
    80008630:	00900793          	li	a5,9
    80008634:	00800c93          	li	s9,8
    80008638:	be1ff06f          	j	80008218 <__printf+0x260>
    8000863c:	00002517          	auipc	a0,0x2
    80008640:	26c50513          	addi	a0,a0,620 # 8000a8a8 <CONSOLE_STATUS+0x898>
    80008644:	00000097          	auipc	ra,0x0
    80008648:	918080e7          	jalr	-1768(ra) # 80007f5c <panic>

000000008000864c <printfinit>:
    8000864c:	fe010113          	addi	sp,sp,-32
    80008650:	00813823          	sd	s0,16(sp)
    80008654:	00913423          	sd	s1,8(sp)
    80008658:	00113c23          	sd	ra,24(sp)
    8000865c:	02010413          	addi	s0,sp,32
    80008660:	0000a497          	auipc	s1,0xa
    80008664:	26048493          	addi	s1,s1,608 # 800128c0 <pr>
    80008668:	00048513          	mv	a0,s1
    8000866c:	00002597          	auipc	a1,0x2
    80008670:	24c58593          	addi	a1,a1,588 # 8000a8b8 <CONSOLE_STATUS+0x8a8>
    80008674:	00000097          	auipc	ra,0x0
    80008678:	5f4080e7          	jalr	1524(ra) # 80008c68 <initlock>
    8000867c:	01813083          	ld	ra,24(sp)
    80008680:	01013403          	ld	s0,16(sp)
    80008684:	0004ac23          	sw	zero,24(s1)
    80008688:	00813483          	ld	s1,8(sp)
    8000868c:	02010113          	addi	sp,sp,32
    80008690:	00008067          	ret

0000000080008694 <uartinit>:
    80008694:	ff010113          	addi	sp,sp,-16
    80008698:	00813423          	sd	s0,8(sp)
    8000869c:	01010413          	addi	s0,sp,16
    800086a0:	100007b7          	lui	a5,0x10000
    800086a4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800086a8:	f8000713          	li	a4,-128
    800086ac:	00e781a3          	sb	a4,3(a5)
    800086b0:	00300713          	li	a4,3
    800086b4:	00e78023          	sb	a4,0(a5)
    800086b8:	000780a3          	sb	zero,1(a5)
    800086bc:	00e781a3          	sb	a4,3(a5)
    800086c0:	00700693          	li	a3,7
    800086c4:	00d78123          	sb	a3,2(a5)
    800086c8:	00e780a3          	sb	a4,1(a5)
    800086cc:	00813403          	ld	s0,8(sp)
    800086d0:	01010113          	addi	sp,sp,16
    800086d4:	00008067          	ret

00000000800086d8 <uartputc>:
    800086d8:	00005797          	auipc	a5,0x5
    800086dc:	d507a783          	lw	a5,-688(a5) # 8000d428 <panicked>
    800086e0:	00078463          	beqz	a5,800086e8 <uartputc+0x10>
    800086e4:	0000006f          	j	800086e4 <uartputc+0xc>
    800086e8:	fd010113          	addi	sp,sp,-48
    800086ec:	02813023          	sd	s0,32(sp)
    800086f0:	00913c23          	sd	s1,24(sp)
    800086f4:	01213823          	sd	s2,16(sp)
    800086f8:	01313423          	sd	s3,8(sp)
    800086fc:	02113423          	sd	ra,40(sp)
    80008700:	03010413          	addi	s0,sp,48
    80008704:	00005917          	auipc	s2,0x5
    80008708:	d2c90913          	addi	s2,s2,-724 # 8000d430 <uart_tx_r>
    8000870c:	00093783          	ld	a5,0(s2)
    80008710:	00005497          	auipc	s1,0x5
    80008714:	d2848493          	addi	s1,s1,-728 # 8000d438 <uart_tx_w>
    80008718:	0004b703          	ld	a4,0(s1)
    8000871c:	02078693          	addi	a3,a5,32
    80008720:	00050993          	mv	s3,a0
    80008724:	02e69c63          	bne	a3,a4,8000875c <uartputc+0x84>
    80008728:	00001097          	auipc	ra,0x1
    8000872c:	834080e7          	jalr	-1996(ra) # 80008f5c <push_on>
    80008730:	00093783          	ld	a5,0(s2)
    80008734:	0004b703          	ld	a4,0(s1)
    80008738:	02078793          	addi	a5,a5,32
    8000873c:	00e79463          	bne	a5,a4,80008744 <uartputc+0x6c>
    80008740:	0000006f          	j	80008740 <uartputc+0x68>
    80008744:	00001097          	auipc	ra,0x1
    80008748:	88c080e7          	jalr	-1908(ra) # 80008fd0 <pop_on>
    8000874c:	00093783          	ld	a5,0(s2)
    80008750:	0004b703          	ld	a4,0(s1)
    80008754:	02078693          	addi	a3,a5,32
    80008758:	fce688e3          	beq	a3,a4,80008728 <uartputc+0x50>
    8000875c:	01f77693          	andi	a3,a4,31
    80008760:	0000a597          	auipc	a1,0xa
    80008764:	18058593          	addi	a1,a1,384 # 800128e0 <uart_tx_buf>
    80008768:	00d586b3          	add	a3,a1,a3
    8000876c:	00170713          	addi	a4,a4,1
    80008770:	01368023          	sb	s3,0(a3)
    80008774:	00e4b023          	sd	a4,0(s1)
    80008778:	10000637          	lui	a2,0x10000
    8000877c:	02f71063          	bne	a4,a5,8000879c <uartputc+0xc4>
    80008780:	0340006f          	j	800087b4 <uartputc+0xdc>
    80008784:	00074703          	lbu	a4,0(a4)
    80008788:	00f93023          	sd	a5,0(s2)
    8000878c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008790:	00093783          	ld	a5,0(s2)
    80008794:	0004b703          	ld	a4,0(s1)
    80008798:	00f70e63          	beq	a4,a5,800087b4 <uartputc+0xdc>
    8000879c:	00564683          	lbu	a3,5(a2)
    800087a0:	01f7f713          	andi	a4,a5,31
    800087a4:	00e58733          	add	a4,a1,a4
    800087a8:	0206f693          	andi	a3,a3,32
    800087ac:	00178793          	addi	a5,a5,1
    800087b0:	fc069ae3          	bnez	a3,80008784 <uartputc+0xac>
    800087b4:	02813083          	ld	ra,40(sp)
    800087b8:	02013403          	ld	s0,32(sp)
    800087bc:	01813483          	ld	s1,24(sp)
    800087c0:	01013903          	ld	s2,16(sp)
    800087c4:	00813983          	ld	s3,8(sp)
    800087c8:	03010113          	addi	sp,sp,48
    800087cc:	00008067          	ret

00000000800087d0 <uartputc_sync>:
    800087d0:	ff010113          	addi	sp,sp,-16
    800087d4:	00813423          	sd	s0,8(sp)
    800087d8:	01010413          	addi	s0,sp,16
    800087dc:	00005717          	auipc	a4,0x5
    800087e0:	c4c72703          	lw	a4,-948(a4) # 8000d428 <panicked>
    800087e4:	02071663          	bnez	a4,80008810 <uartputc_sync+0x40>
    800087e8:	00050793          	mv	a5,a0
    800087ec:	100006b7          	lui	a3,0x10000
    800087f0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800087f4:	02077713          	andi	a4,a4,32
    800087f8:	fe070ce3          	beqz	a4,800087f0 <uartputc_sync+0x20>
    800087fc:	0ff7f793          	andi	a5,a5,255
    80008800:	00f68023          	sb	a5,0(a3)
    80008804:	00813403          	ld	s0,8(sp)
    80008808:	01010113          	addi	sp,sp,16
    8000880c:	00008067          	ret
    80008810:	0000006f          	j	80008810 <uartputc_sync+0x40>

0000000080008814 <uartstart>:
    80008814:	ff010113          	addi	sp,sp,-16
    80008818:	00813423          	sd	s0,8(sp)
    8000881c:	01010413          	addi	s0,sp,16
    80008820:	00005617          	auipc	a2,0x5
    80008824:	c1060613          	addi	a2,a2,-1008 # 8000d430 <uart_tx_r>
    80008828:	00005517          	auipc	a0,0x5
    8000882c:	c1050513          	addi	a0,a0,-1008 # 8000d438 <uart_tx_w>
    80008830:	00063783          	ld	a5,0(a2)
    80008834:	00053703          	ld	a4,0(a0)
    80008838:	04f70263          	beq	a4,a5,8000887c <uartstart+0x68>
    8000883c:	100005b7          	lui	a1,0x10000
    80008840:	0000a817          	auipc	a6,0xa
    80008844:	0a080813          	addi	a6,a6,160 # 800128e0 <uart_tx_buf>
    80008848:	01c0006f          	j	80008864 <uartstart+0x50>
    8000884c:	0006c703          	lbu	a4,0(a3)
    80008850:	00f63023          	sd	a5,0(a2)
    80008854:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008858:	00063783          	ld	a5,0(a2)
    8000885c:	00053703          	ld	a4,0(a0)
    80008860:	00f70e63          	beq	a4,a5,8000887c <uartstart+0x68>
    80008864:	01f7f713          	andi	a4,a5,31
    80008868:	00e806b3          	add	a3,a6,a4
    8000886c:	0055c703          	lbu	a4,5(a1)
    80008870:	00178793          	addi	a5,a5,1
    80008874:	02077713          	andi	a4,a4,32
    80008878:	fc071ae3          	bnez	a4,8000884c <uartstart+0x38>
    8000887c:	00813403          	ld	s0,8(sp)
    80008880:	01010113          	addi	sp,sp,16
    80008884:	00008067          	ret

0000000080008888 <uartgetc>:
    80008888:	ff010113          	addi	sp,sp,-16
    8000888c:	00813423          	sd	s0,8(sp)
    80008890:	01010413          	addi	s0,sp,16
    80008894:	10000737          	lui	a4,0x10000
    80008898:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000889c:	0017f793          	andi	a5,a5,1
    800088a0:	00078c63          	beqz	a5,800088b8 <uartgetc+0x30>
    800088a4:	00074503          	lbu	a0,0(a4)
    800088a8:	0ff57513          	andi	a0,a0,255
    800088ac:	00813403          	ld	s0,8(sp)
    800088b0:	01010113          	addi	sp,sp,16
    800088b4:	00008067          	ret
    800088b8:	fff00513          	li	a0,-1
    800088bc:	ff1ff06f          	j	800088ac <uartgetc+0x24>

00000000800088c0 <uartintr>:
    800088c0:	100007b7          	lui	a5,0x10000
    800088c4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800088c8:	0017f793          	andi	a5,a5,1
    800088cc:	0a078463          	beqz	a5,80008974 <uartintr+0xb4>
    800088d0:	fe010113          	addi	sp,sp,-32
    800088d4:	00813823          	sd	s0,16(sp)
    800088d8:	00913423          	sd	s1,8(sp)
    800088dc:	00113c23          	sd	ra,24(sp)
    800088e0:	02010413          	addi	s0,sp,32
    800088e4:	100004b7          	lui	s1,0x10000
    800088e8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800088ec:	0ff57513          	andi	a0,a0,255
    800088f0:	fffff097          	auipc	ra,0xfffff
    800088f4:	534080e7          	jalr	1332(ra) # 80007e24 <consoleintr>
    800088f8:	0054c783          	lbu	a5,5(s1)
    800088fc:	0017f793          	andi	a5,a5,1
    80008900:	fe0794e3          	bnez	a5,800088e8 <uartintr+0x28>
    80008904:	00005617          	auipc	a2,0x5
    80008908:	b2c60613          	addi	a2,a2,-1236 # 8000d430 <uart_tx_r>
    8000890c:	00005517          	auipc	a0,0x5
    80008910:	b2c50513          	addi	a0,a0,-1236 # 8000d438 <uart_tx_w>
    80008914:	00063783          	ld	a5,0(a2)
    80008918:	00053703          	ld	a4,0(a0)
    8000891c:	04f70263          	beq	a4,a5,80008960 <uartintr+0xa0>
    80008920:	100005b7          	lui	a1,0x10000
    80008924:	0000a817          	auipc	a6,0xa
    80008928:	fbc80813          	addi	a6,a6,-68 # 800128e0 <uart_tx_buf>
    8000892c:	01c0006f          	j	80008948 <uartintr+0x88>
    80008930:	0006c703          	lbu	a4,0(a3)
    80008934:	00f63023          	sd	a5,0(a2)
    80008938:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000893c:	00063783          	ld	a5,0(a2)
    80008940:	00053703          	ld	a4,0(a0)
    80008944:	00f70e63          	beq	a4,a5,80008960 <uartintr+0xa0>
    80008948:	01f7f713          	andi	a4,a5,31
    8000894c:	00e806b3          	add	a3,a6,a4
    80008950:	0055c703          	lbu	a4,5(a1)
    80008954:	00178793          	addi	a5,a5,1
    80008958:	02077713          	andi	a4,a4,32
    8000895c:	fc071ae3          	bnez	a4,80008930 <uartintr+0x70>
    80008960:	01813083          	ld	ra,24(sp)
    80008964:	01013403          	ld	s0,16(sp)
    80008968:	00813483          	ld	s1,8(sp)
    8000896c:	02010113          	addi	sp,sp,32
    80008970:	00008067          	ret
    80008974:	00005617          	auipc	a2,0x5
    80008978:	abc60613          	addi	a2,a2,-1348 # 8000d430 <uart_tx_r>
    8000897c:	00005517          	auipc	a0,0x5
    80008980:	abc50513          	addi	a0,a0,-1348 # 8000d438 <uart_tx_w>
    80008984:	00063783          	ld	a5,0(a2)
    80008988:	00053703          	ld	a4,0(a0)
    8000898c:	04f70263          	beq	a4,a5,800089d0 <uartintr+0x110>
    80008990:	100005b7          	lui	a1,0x10000
    80008994:	0000a817          	auipc	a6,0xa
    80008998:	f4c80813          	addi	a6,a6,-180 # 800128e0 <uart_tx_buf>
    8000899c:	01c0006f          	j	800089b8 <uartintr+0xf8>
    800089a0:	0006c703          	lbu	a4,0(a3)
    800089a4:	00f63023          	sd	a5,0(a2)
    800089a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800089ac:	00063783          	ld	a5,0(a2)
    800089b0:	00053703          	ld	a4,0(a0)
    800089b4:	02f70063          	beq	a4,a5,800089d4 <uartintr+0x114>
    800089b8:	01f7f713          	andi	a4,a5,31
    800089bc:	00e806b3          	add	a3,a6,a4
    800089c0:	0055c703          	lbu	a4,5(a1)
    800089c4:	00178793          	addi	a5,a5,1
    800089c8:	02077713          	andi	a4,a4,32
    800089cc:	fc071ae3          	bnez	a4,800089a0 <uartintr+0xe0>
    800089d0:	00008067          	ret
    800089d4:	00008067          	ret

00000000800089d8 <kinit>:
    800089d8:	fc010113          	addi	sp,sp,-64
    800089dc:	02913423          	sd	s1,40(sp)
    800089e0:	fffff7b7          	lui	a5,0xfffff
    800089e4:	0000b497          	auipc	s1,0xb
    800089e8:	f1b48493          	addi	s1,s1,-229 # 800138ff <end+0xfff>
    800089ec:	02813823          	sd	s0,48(sp)
    800089f0:	01313c23          	sd	s3,24(sp)
    800089f4:	00f4f4b3          	and	s1,s1,a5
    800089f8:	02113c23          	sd	ra,56(sp)
    800089fc:	03213023          	sd	s2,32(sp)
    80008a00:	01413823          	sd	s4,16(sp)
    80008a04:	01513423          	sd	s5,8(sp)
    80008a08:	04010413          	addi	s0,sp,64
    80008a0c:	000017b7          	lui	a5,0x1
    80008a10:	01100993          	li	s3,17
    80008a14:	00f487b3          	add	a5,s1,a5
    80008a18:	01b99993          	slli	s3,s3,0x1b
    80008a1c:	06f9e063          	bltu	s3,a5,80008a7c <kinit+0xa4>
    80008a20:	0000aa97          	auipc	s5,0xa
    80008a24:	ee0a8a93          	addi	s5,s5,-288 # 80012900 <end>
    80008a28:	0754ec63          	bltu	s1,s5,80008aa0 <kinit+0xc8>
    80008a2c:	0734fa63          	bgeu	s1,s3,80008aa0 <kinit+0xc8>
    80008a30:	00088a37          	lui	s4,0x88
    80008a34:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008a38:	00005917          	auipc	s2,0x5
    80008a3c:	a0890913          	addi	s2,s2,-1528 # 8000d440 <kmem>
    80008a40:	00ca1a13          	slli	s4,s4,0xc
    80008a44:	0140006f          	j	80008a58 <kinit+0x80>
    80008a48:	000017b7          	lui	a5,0x1
    80008a4c:	00f484b3          	add	s1,s1,a5
    80008a50:	0554e863          	bltu	s1,s5,80008aa0 <kinit+0xc8>
    80008a54:	0534f663          	bgeu	s1,s3,80008aa0 <kinit+0xc8>
    80008a58:	00001637          	lui	a2,0x1
    80008a5c:	00100593          	li	a1,1
    80008a60:	00048513          	mv	a0,s1
    80008a64:	00000097          	auipc	ra,0x0
    80008a68:	5e4080e7          	jalr	1508(ra) # 80009048 <__memset>
    80008a6c:	00093783          	ld	a5,0(s2)
    80008a70:	00f4b023          	sd	a5,0(s1)
    80008a74:	00993023          	sd	s1,0(s2)
    80008a78:	fd4498e3          	bne	s1,s4,80008a48 <kinit+0x70>
    80008a7c:	03813083          	ld	ra,56(sp)
    80008a80:	03013403          	ld	s0,48(sp)
    80008a84:	02813483          	ld	s1,40(sp)
    80008a88:	02013903          	ld	s2,32(sp)
    80008a8c:	01813983          	ld	s3,24(sp)
    80008a90:	01013a03          	ld	s4,16(sp)
    80008a94:	00813a83          	ld	s5,8(sp)
    80008a98:	04010113          	addi	sp,sp,64
    80008a9c:	00008067          	ret
    80008aa0:	00002517          	auipc	a0,0x2
    80008aa4:	e3850513          	addi	a0,a0,-456 # 8000a8d8 <digits+0x18>
    80008aa8:	fffff097          	auipc	ra,0xfffff
    80008aac:	4b4080e7          	jalr	1204(ra) # 80007f5c <panic>

0000000080008ab0 <freerange>:
    80008ab0:	fc010113          	addi	sp,sp,-64
    80008ab4:	000017b7          	lui	a5,0x1
    80008ab8:	02913423          	sd	s1,40(sp)
    80008abc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80008ac0:	009504b3          	add	s1,a0,s1
    80008ac4:	fffff537          	lui	a0,0xfffff
    80008ac8:	02813823          	sd	s0,48(sp)
    80008acc:	02113c23          	sd	ra,56(sp)
    80008ad0:	03213023          	sd	s2,32(sp)
    80008ad4:	01313c23          	sd	s3,24(sp)
    80008ad8:	01413823          	sd	s4,16(sp)
    80008adc:	01513423          	sd	s5,8(sp)
    80008ae0:	01613023          	sd	s6,0(sp)
    80008ae4:	04010413          	addi	s0,sp,64
    80008ae8:	00a4f4b3          	and	s1,s1,a0
    80008aec:	00f487b3          	add	a5,s1,a5
    80008af0:	06f5e463          	bltu	a1,a5,80008b58 <freerange+0xa8>
    80008af4:	0000aa97          	auipc	s5,0xa
    80008af8:	e0ca8a93          	addi	s5,s5,-500 # 80012900 <end>
    80008afc:	0954e263          	bltu	s1,s5,80008b80 <freerange+0xd0>
    80008b00:	01100993          	li	s3,17
    80008b04:	01b99993          	slli	s3,s3,0x1b
    80008b08:	0734fc63          	bgeu	s1,s3,80008b80 <freerange+0xd0>
    80008b0c:	00058a13          	mv	s4,a1
    80008b10:	00005917          	auipc	s2,0x5
    80008b14:	93090913          	addi	s2,s2,-1744 # 8000d440 <kmem>
    80008b18:	00002b37          	lui	s6,0x2
    80008b1c:	0140006f          	j	80008b30 <freerange+0x80>
    80008b20:	000017b7          	lui	a5,0x1
    80008b24:	00f484b3          	add	s1,s1,a5
    80008b28:	0554ec63          	bltu	s1,s5,80008b80 <freerange+0xd0>
    80008b2c:	0534fa63          	bgeu	s1,s3,80008b80 <freerange+0xd0>
    80008b30:	00001637          	lui	a2,0x1
    80008b34:	00100593          	li	a1,1
    80008b38:	00048513          	mv	a0,s1
    80008b3c:	00000097          	auipc	ra,0x0
    80008b40:	50c080e7          	jalr	1292(ra) # 80009048 <__memset>
    80008b44:	00093703          	ld	a4,0(s2)
    80008b48:	016487b3          	add	a5,s1,s6
    80008b4c:	00e4b023          	sd	a4,0(s1)
    80008b50:	00993023          	sd	s1,0(s2)
    80008b54:	fcfa76e3          	bgeu	s4,a5,80008b20 <freerange+0x70>
    80008b58:	03813083          	ld	ra,56(sp)
    80008b5c:	03013403          	ld	s0,48(sp)
    80008b60:	02813483          	ld	s1,40(sp)
    80008b64:	02013903          	ld	s2,32(sp)
    80008b68:	01813983          	ld	s3,24(sp)
    80008b6c:	01013a03          	ld	s4,16(sp)
    80008b70:	00813a83          	ld	s5,8(sp)
    80008b74:	00013b03          	ld	s6,0(sp)
    80008b78:	04010113          	addi	sp,sp,64
    80008b7c:	00008067          	ret
    80008b80:	00002517          	auipc	a0,0x2
    80008b84:	d5850513          	addi	a0,a0,-680 # 8000a8d8 <digits+0x18>
    80008b88:	fffff097          	auipc	ra,0xfffff
    80008b8c:	3d4080e7          	jalr	980(ra) # 80007f5c <panic>

0000000080008b90 <kfree>:
    80008b90:	fe010113          	addi	sp,sp,-32
    80008b94:	00813823          	sd	s0,16(sp)
    80008b98:	00113c23          	sd	ra,24(sp)
    80008b9c:	00913423          	sd	s1,8(sp)
    80008ba0:	02010413          	addi	s0,sp,32
    80008ba4:	03451793          	slli	a5,a0,0x34
    80008ba8:	04079c63          	bnez	a5,80008c00 <kfree+0x70>
    80008bac:	0000a797          	auipc	a5,0xa
    80008bb0:	d5478793          	addi	a5,a5,-684 # 80012900 <end>
    80008bb4:	00050493          	mv	s1,a0
    80008bb8:	04f56463          	bltu	a0,a5,80008c00 <kfree+0x70>
    80008bbc:	01100793          	li	a5,17
    80008bc0:	01b79793          	slli	a5,a5,0x1b
    80008bc4:	02f57e63          	bgeu	a0,a5,80008c00 <kfree+0x70>
    80008bc8:	00001637          	lui	a2,0x1
    80008bcc:	00100593          	li	a1,1
    80008bd0:	00000097          	auipc	ra,0x0
    80008bd4:	478080e7          	jalr	1144(ra) # 80009048 <__memset>
    80008bd8:	00005797          	auipc	a5,0x5
    80008bdc:	86878793          	addi	a5,a5,-1944 # 8000d440 <kmem>
    80008be0:	0007b703          	ld	a4,0(a5)
    80008be4:	01813083          	ld	ra,24(sp)
    80008be8:	01013403          	ld	s0,16(sp)
    80008bec:	00e4b023          	sd	a4,0(s1)
    80008bf0:	0097b023          	sd	s1,0(a5)
    80008bf4:	00813483          	ld	s1,8(sp)
    80008bf8:	02010113          	addi	sp,sp,32
    80008bfc:	00008067          	ret
    80008c00:	00002517          	auipc	a0,0x2
    80008c04:	cd850513          	addi	a0,a0,-808 # 8000a8d8 <digits+0x18>
    80008c08:	fffff097          	auipc	ra,0xfffff
    80008c0c:	354080e7          	jalr	852(ra) # 80007f5c <panic>

0000000080008c10 <kalloc>:
    80008c10:	fe010113          	addi	sp,sp,-32
    80008c14:	00813823          	sd	s0,16(sp)
    80008c18:	00913423          	sd	s1,8(sp)
    80008c1c:	00113c23          	sd	ra,24(sp)
    80008c20:	02010413          	addi	s0,sp,32
    80008c24:	00005797          	auipc	a5,0x5
    80008c28:	81c78793          	addi	a5,a5,-2020 # 8000d440 <kmem>
    80008c2c:	0007b483          	ld	s1,0(a5)
    80008c30:	02048063          	beqz	s1,80008c50 <kalloc+0x40>
    80008c34:	0004b703          	ld	a4,0(s1)
    80008c38:	00001637          	lui	a2,0x1
    80008c3c:	00500593          	li	a1,5
    80008c40:	00048513          	mv	a0,s1
    80008c44:	00e7b023          	sd	a4,0(a5)
    80008c48:	00000097          	auipc	ra,0x0
    80008c4c:	400080e7          	jalr	1024(ra) # 80009048 <__memset>
    80008c50:	01813083          	ld	ra,24(sp)
    80008c54:	01013403          	ld	s0,16(sp)
    80008c58:	00048513          	mv	a0,s1
    80008c5c:	00813483          	ld	s1,8(sp)
    80008c60:	02010113          	addi	sp,sp,32
    80008c64:	00008067          	ret

0000000080008c68 <initlock>:
    80008c68:	ff010113          	addi	sp,sp,-16
    80008c6c:	00813423          	sd	s0,8(sp)
    80008c70:	01010413          	addi	s0,sp,16
    80008c74:	00813403          	ld	s0,8(sp)
    80008c78:	00b53423          	sd	a1,8(a0)
    80008c7c:	00052023          	sw	zero,0(a0)
    80008c80:	00053823          	sd	zero,16(a0)
    80008c84:	01010113          	addi	sp,sp,16
    80008c88:	00008067          	ret

0000000080008c8c <acquire>:
    80008c8c:	fe010113          	addi	sp,sp,-32
    80008c90:	00813823          	sd	s0,16(sp)
    80008c94:	00913423          	sd	s1,8(sp)
    80008c98:	00113c23          	sd	ra,24(sp)
    80008c9c:	01213023          	sd	s2,0(sp)
    80008ca0:	02010413          	addi	s0,sp,32
    80008ca4:	00050493          	mv	s1,a0
    80008ca8:	10002973          	csrr	s2,sstatus
    80008cac:	100027f3          	csrr	a5,sstatus
    80008cb0:	ffd7f793          	andi	a5,a5,-3
    80008cb4:	10079073          	csrw	sstatus,a5
    80008cb8:	fffff097          	auipc	ra,0xfffff
    80008cbc:	8e8080e7          	jalr	-1816(ra) # 800075a0 <mycpu>
    80008cc0:	07852783          	lw	a5,120(a0)
    80008cc4:	06078e63          	beqz	a5,80008d40 <acquire+0xb4>
    80008cc8:	fffff097          	auipc	ra,0xfffff
    80008ccc:	8d8080e7          	jalr	-1832(ra) # 800075a0 <mycpu>
    80008cd0:	07852783          	lw	a5,120(a0)
    80008cd4:	0004a703          	lw	a4,0(s1)
    80008cd8:	0017879b          	addiw	a5,a5,1
    80008cdc:	06f52c23          	sw	a5,120(a0)
    80008ce0:	04071063          	bnez	a4,80008d20 <acquire+0x94>
    80008ce4:	00100713          	li	a4,1
    80008ce8:	00070793          	mv	a5,a4
    80008cec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008cf0:	0007879b          	sext.w	a5,a5
    80008cf4:	fe079ae3          	bnez	a5,80008ce8 <acquire+0x5c>
    80008cf8:	0ff0000f          	fence
    80008cfc:	fffff097          	auipc	ra,0xfffff
    80008d00:	8a4080e7          	jalr	-1884(ra) # 800075a0 <mycpu>
    80008d04:	01813083          	ld	ra,24(sp)
    80008d08:	01013403          	ld	s0,16(sp)
    80008d0c:	00a4b823          	sd	a0,16(s1)
    80008d10:	00013903          	ld	s2,0(sp)
    80008d14:	00813483          	ld	s1,8(sp)
    80008d18:	02010113          	addi	sp,sp,32
    80008d1c:	00008067          	ret
    80008d20:	0104b903          	ld	s2,16(s1)
    80008d24:	fffff097          	auipc	ra,0xfffff
    80008d28:	87c080e7          	jalr	-1924(ra) # 800075a0 <mycpu>
    80008d2c:	faa91ce3          	bne	s2,a0,80008ce4 <acquire+0x58>
    80008d30:	00002517          	auipc	a0,0x2
    80008d34:	bb050513          	addi	a0,a0,-1104 # 8000a8e0 <digits+0x20>
    80008d38:	fffff097          	auipc	ra,0xfffff
    80008d3c:	224080e7          	jalr	548(ra) # 80007f5c <panic>
    80008d40:	00195913          	srli	s2,s2,0x1
    80008d44:	fffff097          	auipc	ra,0xfffff
    80008d48:	85c080e7          	jalr	-1956(ra) # 800075a0 <mycpu>
    80008d4c:	00197913          	andi	s2,s2,1
    80008d50:	07252e23          	sw	s2,124(a0)
    80008d54:	f75ff06f          	j	80008cc8 <acquire+0x3c>

0000000080008d58 <release>:
    80008d58:	fe010113          	addi	sp,sp,-32
    80008d5c:	00813823          	sd	s0,16(sp)
    80008d60:	00113c23          	sd	ra,24(sp)
    80008d64:	00913423          	sd	s1,8(sp)
    80008d68:	01213023          	sd	s2,0(sp)
    80008d6c:	02010413          	addi	s0,sp,32
    80008d70:	00052783          	lw	a5,0(a0)
    80008d74:	00079a63          	bnez	a5,80008d88 <release+0x30>
    80008d78:	00002517          	auipc	a0,0x2
    80008d7c:	b7050513          	addi	a0,a0,-1168 # 8000a8e8 <digits+0x28>
    80008d80:	fffff097          	auipc	ra,0xfffff
    80008d84:	1dc080e7          	jalr	476(ra) # 80007f5c <panic>
    80008d88:	01053903          	ld	s2,16(a0)
    80008d8c:	00050493          	mv	s1,a0
    80008d90:	fffff097          	auipc	ra,0xfffff
    80008d94:	810080e7          	jalr	-2032(ra) # 800075a0 <mycpu>
    80008d98:	fea910e3          	bne	s2,a0,80008d78 <release+0x20>
    80008d9c:	0004b823          	sd	zero,16(s1)
    80008da0:	0ff0000f          	fence
    80008da4:	0f50000f          	fence	iorw,ow
    80008da8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80008dac:	ffffe097          	auipc	ra,0xffffe
    80008db0:	7f4080e7          	jalr	2036(ra) # 800075a0 <mycpu>
    80008db4:	100027f3          	csrr	a5,sstatus
    80008db8:	0027f793          	andi	a5,a5,2
    80008dbc:	04079a63          	bnez	a5,80008e10 <release+0xb8>
    80008dc0:	07852783          	lw	a5,120(a0)
    80008dc4:	02f05e63          	blez	a5,80008e00 <release+0xa8>
    80008dc8:	fff7871b          	addiw	a4,a5,-1
    80008dcc:	06e52c23          	sw	a4,120(a0)
    80008dd0:	00071c63          	bnez	a4,80008de8 <release+0x90>
    80008dd4:	07c52783          	lw	a5,124(a0)
    80008dd8:	00078863          	beqz	a5,80008de8 <release+0x90>
    80008ddc:	100027f3          	csrr	a5,sstatus
    80008de0:	0027e793          	ori	a5,a5,2
    80008de4:	10079073          	csrw	sstatus,a5
    80008de8:	01813083          	ld	ra,24(sp)
    80008dec:	01013403          	ld	s0,16(sp)
    80008df0:	00813483          	ld	s1,8(sp)
    80008df4:	00013903          	ld	s2,0(sp)
    80008df8:	02010113          	addi	sp,sp,32
    80008dfc:	00008067          	ret
    80008e00:	00002517          	auipc	a0,0x2
    80008e04:	b0850513          	addi	a0,a0,-1272 # 8000a908 <digits+0x48>
    80008e08:	fffff097          	auipc	ra,0xfffff
    80008e0c:	154080e7          	jalr	340(ra) # 80007f5c <panic>
    80008e10:	00002517          	auipc	a0,0x2
    80008e14:	ae050513          	addi	a0,a0,-1312 # 8000a8f0 <digits+0x30>
    80008e18:	fffff097          	auipc	ra,0xfffff
    80008e1c:	144080e7          	jalr	324(ra) # 80007f5c <panic>

0000000080008e20 <holding>:
    80008e20:	00052783          	lw	a5,0(a0)
    80008e24:	00079663          	bnez	a5,80008e30 <holding+0x10>
    80008e28:	00000513          	li	a0,0
    80008e2c:	00008067          	ret
    80008e30:	fe010113          	addi	sp,sp,-32
    80008e34:	00813823          	sd	s0,16(sp)
    80008e38:	00913423          	sd	s1,8(sp)
    80008e3c:	00113c23          	sd	ra,24(sp)
    80008e40:	02010413          	addi	s0,sp,32
    80008e44:	01053483          	ld	s1,16(a0)
    80008e48:	ffffe097          	auipc	ra,0xffffe
    80008e4c:	758080e7          	jalr	1880(ra) # 800075a0 <mycpu>
    80008e50:	01813083          	ld	ra,24(sp)
    80008e54:	01013403          	ld	s0,16(sp)
    80008e58:	40a48533          	sub	a0,s1,a0
    80008e5c:	00153513          	seqz	a0,a0
    80008e60:	00813483          	ld	s1,8(sp)
    80008e64:	02010113          	addi	sp,sp,32
    80008e68:	00008067          	ret

0000000080008e6c <push_off>:
    80008e6c:	fe010113          	addi	sp,sp,-32
    80008e70:	00813823          	sd	s0,16(sp)
    80008e74:	00113c23          	sd	ra,24(sp)
    80008e78:	00913423          	sd	s1,8(sp)
    80008e7c:	02010413          	addi	s0,sp,32
    80008e80:	100024f3          	csrr	s1,sstatus
    80008e84:	100027f3          	csrr	a5,sstatus
    80008e88:	ffd7f793          	andi	a5,a5,-3
    80008e8c:	10079073          	csrw	sstatus,a5
    80008e90:	ffffe097          	auipc	ra,0xffffe
    80008e94:	710080e7          	jalr	1808(ra) # 800075a0 <mycpu>
    80008e98:	07852783          	lw	a5,120(a0)
    80008e9c:	02078663          	beqz	a5,80008ec8 <push_off+0x5c>
    80008ea0:	ffffe097          	auipc	ra,0xffffe
    80008ea4:	700080e7          	jalr	1792(ra) # 800075a0 <mycpu>
    80008ea8:	07852783          	lw	a5,120(a0)
    80008eac:	01813083          	ld	ra,24(sp)
    80008eb0:	01013403          	ld	s0,16(sp)
    80008eb4:	0017879b          	addiw	a5,a5,1
    80008eb8:	06f52c23          	sw	a5,120(a0)
    80008ebc:	00813483          	ld	s1,8(sp)
    80008ec0:	02010113          	addi	sp,sp,32
    80008ec4:	00008067          	ret
    80008ec8:	0014d493          	srli	s1,s1,0x1
    80008ecc:	ffffe097          	auipc	ra,0xffffe
    80008ed0:	6d4080e7          	jalr	1748(ra) # 800075a0 <mycpu>
    80008ed4:	0014f493          	andi	s1,s1,1
    80008ed8:	06952e23          	sw	s1,124(a0)
    80008edc:	fc5ff06f          	j	80008ea0 <push_off+0x34>

0000000080008ee0 <pop_off>:
    80008ee0:	ff010113          	addi	sp,sp,-16
    80008ee4:	00813023          	sd	s0,0(sp)
    80008ee8:	00113423          	sd	ra,8(sp)
    80008eec:	01010413          	addi	s0,sp,16
    80008ef0:	ffffe097          	auipc	ra,0xffffe
    80008ef4:	6b0080e7          	jalr	1712(ra) # 800075a0 <mycpu>
    80008ef8:	100027f3          	csrr	a5,sstatus
    80008efc:	0027f793          	andi	a5,a5,2
    80008f00:	04079663          	bnez	a5,80008f4c <pop_off+0x6c>
    80008f04:	07852783          	lw	a5,120(a0)
    80008f08:	02f05a63          	blez	a5,80008f3c <pop_off+0x5c>
    80008f0c:	fff7871b          	addiw	a4,a5,-1
    80008f10:	06e52c23          	sw	a4,120(a0)
    80008f14:	00071c63          	bnez	a4,80008f2c <pop_off+0x4c>
    80008f18:	07c52783          	lw	a5,124(a0)
    80008f1c:	00078863          	beqz	a5,80008f2c <pop_off+0x4c>
    80008f20:	100027f3          	csrr	a5,sstatus
    80008f24:	0027e793          	ori	a5,a5,2
    80008f28:	10079073          	csrw	sstatus,a5
    80008f2c:	00813083          	ld	ra,8(sp)
    80008f30:	00013403          	ld	s0,0(sp)
    80008f34:	01010113          	addi	sp,sp,16
    80008f38:	00008067          	ret
    80008f3c:	00002517          	auipc	a0,0x2
    80008f40:	9cc50513          	addi	a0,a0,-1588 # 8000a908 <digits+0x48>
    80008f44:	fffff097          	auipc	ra,0xfffff
    80008f48:	018080e7          	jalr	24(ra) # 80007f5c <panic>
    80008f4c:	00002517          	auipc	a0,0x2
    80008f50:	9a450513          	addi	a0,a0,-1628 # 8000a8f0 <digits+0x30>
    80008f54:	fffff097          	auipc	ra,0xfffff
    80008f58:	008080e7          	jalr	8(ra) # 80007f5c <panic>

0000000080008f5c <push_on>:
    80008f5c:	fe010113          	addi	sp,sp,-32
    80008f60:	00813823          	sd	s0,16(sp)
    80008f64:	00113c23          	sd	ra,24(sp)
    80008f68:	00913423          	sd	s1,8(sp)
    80008f6c:	02010413          	addi	s0,sp,32
    80008f70:	100024f3          	csrr	s1,sstatus
    80008f74:	100027f3          	csrr	a5,sstatus
    80008f78:	0027e793          	ori	a5,a5,2
    80008f7c:	10079073          	csrw	sstatus,a5
    80008f80:	ffffe097          	auipc	ra,0xffffe
    80008f84:	620080e7          	jalr	1568(ra) # 800075a0 <mycpu>
    80008f88:	07852783          	lw	a5,120(a0)
    80008f8c:	02078663          	beqz	a5,80008fb8 <push_on+0x5c>
    80008f90:	ffffe097          	auipc	ra,0xffffe
    80008f94:	610080e7          	jalr	1552(ra) # 800075a0 <mycpu>
    80008f98:	07852783          	lw	a5,120(a0)
    80008f9c:	01813083          	ld	ra,24(sp)
    80008fa0:	01013403          	ld	s0,16(sp)
    80008fa4:	0017879b          	addiw	a5,a5,1
    80008fa8:	06f52c23          	sw	a5,120(a0)
    80008fac:	00813483          	ld	s1,8(sp)
    80008fb0:	02010113          	addi	sp,sp,32
    80008fb4:	00008067          	ret
    80008fb8:	0014d493          	srli	s1,s1,0x1
    80008fbc:	ffffe097          	auipc	ra,0xffffe
    80008fc0:	5e4080e7          	jalr	1508(ra) # 800075a0 <mycpu>
    80008fc4:	0014f493          	andi	s1,s1,1
    80008fc8:	06952e23          	sw	s1,124(a0)
    80008fcc:	fc5ff06f          	j	80008f90 <push_on+0x34>

0000000080008fd0 <pop_on>:
    80008fd0:	ff010113          	addi	sp,sp,-16
    80008fd4:	00813023          	sd	s0,0(sp)
    80008fd8:	00113423          	sd	ra,8(sp)
    80008fdc:	01010413          	addi	s0,sp,16
    80008fe0:	ffffe097          	auipc	ra,0xffffe
    80008fe4:	5c0080e7          	jalr	1472(ra) # 800075a0 <mycpu>
    80008fe8:	100027f3          	csrr	a5,sstatus
    80008fec:	0027f793          	andi	a5,a5,2
    80008ff0:	04078463          	beqz	a5,80009038 <pop_on+0x68>
    80008ff4:	07852783          	lw	a5,120(a0)
    80008ff8:	02f05863          	blez	a5,80009028 <pop_on+0x58>
    80008ffc:	fff7879b          	addiw	a5,a5,-1
    80009000:	06f52c23          	sw	a5,120(a0)
    80009004:	07853783          	ld	a5,120(a0)
    80009008:	00079863          	bnez	a5,80009018 <pop_on+0x48>
    8000900c:	100027f3          	csrr	a5,sstatus
    80009010:	ffd7f793          	andi	a5,a5,-3
    80009014:	10079073          	csrw	sstatus,a5
    80009018:	00813083          	ld	ra,8(sp)
    8000901c:	00013403          	ld	s0,0(sp)
    80009020:	01010113          	addi	sp,sp,16
    80009024:	00008067          	ret
    80009028:	00002517          	auipc	a0,0x2
    8000902c:	90850513          	addi	a0,a0,-1784 # 8000a930 <digits+0x70>
    80009030:	fffff097          	auipc	ra,0xfffff
    80009034:	f2c080e7          	jalr	-212(ra) # 80007f5c <panic>
    80009038:	00002517          	auipc	a0,0x2
    8000903c:	8d850513          	addi	a0,a0,-1832 # 8000a910 <digits+0x50>
    80009040:	fffff097          	auipc	ra,0xfffff
    80009044:	f1c080e7          	jalr	-228(ra) # 80007f5c <panic>

0000000080009048 <__memset>:
    80009048:	ff010113          	addi	sp,sp,-16
    8000904c:	00813423          	sd	s0,8(sp)
    80009050:	01010413          	addi	s0,sp,16
    80009054:	1a060e63          	beqz	a2,80009210 <__memset+0x1c8>
    80009058:	40a007b3          	neg	a5,a0
    8000905c:	0077f793          	andi	a5,a5,7
    80009060:	00778693          	addi	a3,a5,7
    80009064:	00b00813          	li	a6,11
    80009068:	0ff5f593          	andi	a1,a1,255
    8000906c:	fff6071b          	addiw	a4,a2,-1
    80009070:	1b06e663          	bltu	a3,a6,8000921c <__memset+0x1d4>
    80009074:	1cd76463          	bltu	a4,a3,8000923c <__memset+0x1f4>
    80009078:	1a078e63          	beqz	a5,80009234 <__memset+0x1ec>
    8000907c:	00b50023          	sb	a1,0(a0)
    80009080:	00100713          	li	a4,1
    80009084:	1ae78463          	beq	a5,a4,8000922c <__memset+0x1e4>
    80009088:	00b500a3          	sb	a1,1(a0)
    8000908c:	00200713          	li	a4,2
    80009090:	1ae78a63          	beq	a5,a4,80009244 <__memset+0x1fc>
    80009094:	00b50123          	sb	a1,2(a0)
    80009098:	00300713          	li	a4,3
    8000909c:	18e78463          	beq	a5,a4,80009224 <__memset+0x1dc>
    800090a0:	00b501a3          	sb	a1,3(a0)
    800090a4:	00400713          	li	a4,4
    800090a8:	1ae78263          	beq	a5,a4,8000924c <__memset+0x204>
    800090ac:	00b50223          	sb	a1,4(a0)
    800090b0:	00500713          	li	a4,5
    800090b4:	1ae78063          	beq	a5,a4,80009254 <__memset+0x20c>
    800090b8:	00b502a3          	sb	a1,5(a0)
    800090bc:	00700713          	li	a4,7
    800090c0:	18e79e63          	bne	a5,a4,8000925c <__memset+0x214>
    800090c4:	00b50323          	sb	a1,6(a0)
    800090c8:	00700e93          	li	t4,7
    800090cc:	00859713          	slli	a4,a1,0x8
    800090d0:	00e5e733          	or	a4,a1,a4
    800090d4:	01059e13          	slli	t3,a1,0x10
    800090d8:	01c76e33          	or	t3,a4,t3
    800090dc:	01859313          	slli	t1,a1,0x18
    800090e0:	006e6333          	or	t1,t3,t1
    800090e4:	02059893          	slli	a7,a1,0x20
    800090e8:	40f60e3b          	subw	t3,a2,a5
    800090ec:	011368b3          	or	a7,t1,a7
    800090f0:	02859813          	slli	a6,a1,0x28
    800090f4:	0108e833          	or	a6,a7,a6
    800090f8:	03059693          	slli	a3,a1,0x30
    800090fc:	003e589b          	srliw	a7,t3,0x3
    80009100:	00d866b3          	or	a3,a6,a3
    80009104:	03859713          	slli	a4,a1,0x38
    80009108:	00389813          	slli	a6,a7,0x3
    8000910c:	00f507b3          	add	a5,a0,a5
    80009110:	00e6e733          	or	a4,a3,a4
    80009114:	000e089b          	sext.w	a7,t3
    80009118:	00f806b3          	add	a3,a6,a5
    8000911c:	00e7b023          	sd	a4,0(a5)
    80009120:	00878793          	addi	a5,a5,8
    80009124:	fed79ce3          	bne	a5,a3,8000911c <__memset+0xd4>
    80009128:	ff8e7793          	andi	a5,t3,-8
    8000912c:	0007871b          	sext.w	a4,a5
    80009130:	01d787bb          	addw	a5,a5,t4
    80009134:	0ce88e63          	beq	a7,a4,80009210 <__memset+0x1c8>
    80009138:	00f50733          	add	a4,a0,a5
    8000913c:	00b70023          	sb	a1,0(a4)
    80009140:	0017871b          	addiw	a4,a5,1
    80009144:	0cc77663          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    80009148:	00e50733          	add	a4,a0,a4
    8000914c:	00b70023          	sb	a1,0(a4)
    80009150:	0027871b          	addiw	a4,a5,2
    80009154:	0ac77e63          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    80009158:	00e50733          	add	a4,a0,a4
    8000915c:	00b70023          	sb	a1,0(a4)
    80009160:	0037871b          	addiw	a4,a5,3
    80009164:	0ac77663          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    80009168:	00e50733          	add	a4,a0,a4
    8000916c:	00b70023          	sb	a1,0(a4)
    80009170:	0047871b          	addiw	a4,a5,4
    80009174:	08c77e63          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    80009178:	00e50733          	add	a4,a0,a4
    8000917c:	00b70023          	sb	a1,0(a4)
    80009180:	0057871b          	addiw	a4,a5,5
    80009184:	08c77663          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    80009188:	00e50733          	add	a4,a0,a4
    8000918c:	00b70023          	sb	a1,0(a4)
    80009190:	0067871b          	addiw	a4,a5,6
    80009194:	06c77e63          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    80009198:	00e50733          	add	a4,a0,a4
    8000919c:	00b70023          	sb	a1,0(a4)
    800091a0:	0077871b          	addiw	a4,a5,7
    800091a4:	06c77663          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    800091a8:	00e50733          	add	a4,a0,a4
    800091ac:	00b70023          	sb	a1,0(a4)
    800091b0:	0087871b          	addiw	a4,a5,8
    800091b4:	04c77e63          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    800091b8:	00e50733          	add	a4,a0,a4
    800091bc:	00b70023          	sb	a1,0(a4)
    800091c0:	0097871b          	addiw	a4,a5,9
    800091c4:	04c77663          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    800091c8:	00e50733          	add	a4,a0,a4
    800091cc:	00b70023          	sb	a1,0(a4)
    800091d0:	00a7871b          	addiw	a4,a5,10
    800091d4:	02c77e63          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    800091d8:	00e50733          	add	a4,a0,a4
    800091dc:	00b70023          	sb	a1,0(a4)
    800091e0:	00b7871b          	addiw	a4,a5,11
    800091e4:	02c77663          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    800091e8:	00e50733          	add	a4,a0,a4
    800091ec:	00b70023          	sb	a1,0(a4)
    800091f0:	00c7871b          	addiw	a4,a5,12
    800091f4:	00c77e63          	bgeu	a4,a2,80009210 <__memset+0x1c8>
    800091f8:	00e50733          	add	a4,a0,a4
    800091fc:	00b70023          	sb	a1,0(a4)
    80009200:	00d7879b          	addiw	a5,a5,13
    80009204:	00c7f663          	bgeu	a5,a2,80009210 <__memset+0x1c8>
    80009208:	00f507b3          	add	a5,a0,a5
    8000920c:	00b78023          	sb	a1,0(a5)
    80009210:	00813403          	ld	s0,8(sp)
    80009214:	01010113          	addi	sp,sp,16
    80009218:	00008067          	ret
    8000921c:	00b00693          	li	a3,11
    80009220:	e55ff06f          	j	80009074 <__memset+0x2c>
    80009224:	00300e93          	li	t4,3
    80009228:	ea5ff06f          	j	800090cc <__memset+0x84>
    8000922c:	00100e93          	li	t4,1
    80009230:	e9dff06f          	j	800090cc <__memset+0x84>
    80009234:	00000e93          	li	t4,0
    80009238:	e95ff06f          	j	800090cc <__memset+0x84>
    8000923c:	00000793          	li	a5,0
    80009240:	ef9ff06f          	j	80009138 <__memset+0xf0>
    80009244:	00200e93          	li	t4,2
    80009248:	e85ff06f          	j	800090cc <__memset+0x84>
    8000924c:	00400e93          	li	t4,4
    80009250:	e7dff06f          	j	800090cc <__memset+0x84>
    80009254:	00500e93          	li	t4,5
    80009258:	e75ff06f          	j	800090cc <__memset+0x84>
    8000925c:	00600e93          	li	t4,6
    80009260:	e6dff06f          	j	800090cc <__memset+0x84>

0000000080009264 <__memmove>:
    80009264:	ff010113          	addi	sp,sp,-16
    80009268:	00813423          	sd	s0,8(sp)
    8000926c:	01010413          	addi	s0,sp,16
    80009270:	0e060863          	beqz	a2,80009360 <__memmove+0xfc>
    80009274:	fff6069b          	addiw	a3,a2,-1
    80009278:	0006881b          	sext.w	a6,a3
    8000927c:	0ea5e863          	bltu	a1,a0,8000936c <__memmove+0x108>
    80009280:	00758713          	addi	a4,a1,7
    80009284:	00a5e7b3          	or	a5,a1,a0
    80009288:	40a70733          	sub	a4,a4,a0
    8000928c:	0077f793          	andi	a5,a5,7
    80009290:	00f73713          	sltiu	a4,a4,15
    80009294:	00174713          	xori	a4,a4,1
    80009298:	0017b793          	seqz	a5,a5
    8000929c:	00e7f7b3          	and	a5,a5,a4
    800092a0:	10078863          	beqz	a5,800093b0 <__memmove+0x14c>
    800092a4:	00900793          	li	a5,9
    800092a8:	1107f463          	bgeu	a5,a6,800093b0 <__memmove+0x14c>
    800092ac:	0036581b          	srliw	a6,a2,0x3
    800092b0:	fff8081b          	addiw	a6,a6,-1
    800092b4:	02081813          	slli	a6,a6,0x20
    800092b8:	01d85893          	srli	a7,a6,0x1d
    800092bc:	00858813          	addi	a6,a1,8
    800092c0:	00058793          	mv	a5,a1
    800092c4:	00050713          	mv	a4,a0
    800092c8:	01088833          	add	a6,a7,a6
    800092cc:	0007b883          	ld	a7,0(a5)
    800092d0:	00878793          	addi	a5,a5,8
    800092d4:	00870713          	addi	a4,a4,8
    800092d8:	ff173c23          	sd	a7,-8(a4)
    800092dc:	ff0798e3          	bne	a5,a6,800092cc <__memmove+0x68>
    800092e0:	ff867713          	andi	a4,a2,-8
    800092e4:	02071793          	slli	a5,a4,0x20
    800092e8:	0207d793          	srli	a5,a5,0x20
    800092ec:	00f585b3          	add	a1,a1,a5
    800092f0:	40e686bb          	subw	a3,a3,a4
    800092f4:	00f507b3          	add	a5,a0,a5
    800092f8:	06e60463          	beq	a2,a4,80009360 <__memmove+0xfc>
    800092fc:	0005c703          	lbu	a4,0(a1)
    80009300:	00e78023          	sb	a4,0(a5)
    80009304:	04068e63          	beqz	a3,80009360 <__memmove+0xfc>
    80009308:	0015c603          	lbu	a2,1(a1)
    8000930c:	00100713          	li	a4,1
    80009310:	00c780a3          	sb	a2,1(a5)
    80009314:	04e68663          	beq	a3,a4,80009360 <__memmove+0xfc>
    80009318:	0025c603          	lbu	a2,2(a1)
    8000931c:	00200713          	li	a4,2
    80009320:	00c78123          	sb	a2,2(a5)
    80009324:	02e68e63          	beq	a3,a4,80009360 <__memmove+0xfc>
    80009328:	0035c603          	lbu	a2,3(a1)
    8000932c:	00300713          	li	a4,3
    80009330:	00c781a3          	sb	a2,3(a5)
    80009334:	02e68663          	beq	a3,a4,80009360 <__memmove+0xfc>
    80009338:	0045c603          	lbu	a2,4(a1)
    8000933c:	00400713          	li	a4,4
    80009340:	00c78223          	sb	a2,4(a5)
    80009344:	00e68e63          	beq	a3,a4,80009360 <__memmove+0xfc>
    80009348:	0055c603          	lbu	a2,5(a1)
    8000934c:	00500713          	li	a4,5
    80009350:	00c782a3          	sb	a2,5(a5)
    80009354:	00e68663          	beq	a3,a4,80009360 <__memmove+0xfc>
    80009358:	0065c703          	lbu	a4,6(a1)
    8000935c:	00e78323          	sb	a4,6(a5)
    80009360:	00813403          	ld	s0,8(sp)
    80009364:	01010113          	addi	sp,sp,16
    80009368:	00008067          	ret
    8000936c:	02061713          	slli	a4,a2,0x20
    80009370:	02075713          	srli	a4,a4,0x20
    80009374:	00e587b3          	add	a5,a1,a4
    80009378:	f0f574e3          	bgeu	a0,a5,80009280 <__memmove+0x1c>
    8000937c:	02069613          	slli	a2,a3,0x20
    80009380:	02065613          	srli	a2,a2,0x20
    80009384:	fff64613          	not	a2,a2
    80009388:	00e50733          	add	a4,a0,a4
    8000938c:	00c78633          	add	a2,a5,a2
    80009390:	fff7c683          	lbu	a3,-1(a5)
    80009394:	fff78793          	addi	a5,a5,-1
    80009398:	fff70713          	addi	a4,a4,-1
    8000939c:	00d70023          	sb	a3,0(a4)
    800093a0:	fec798e3          	bne	a5,a2,80009390 <__memmove+0x12c>
    800093a4:	00813403          	ld	s0,8(sp)
    800093a8:	01010113          	addi	sp,sp,16
    800093ac:	00008067          	ret
    800093b0:	02069713          	slli	a4,a3,0x20
    800093b4:	02075713          	srli	a4,a4,0x20
    800093b8:	00170713          	addi	a4,a4,1
    800093bc:	00e50733          	add	a4,a0,a4
    800093c0:	00050793          	mv	a5,a0
    800093c4:	0005c683          	lbu	a3,0(a1)
    800093c8:	00178793          	addi	a5,a5,1
    800093cc:	00158593          	addi	a1,a1,1
    800093d0:	fed78fa3          	sb	a3,-1(a5)
    800093d4:	fee798e3          	bne	a5,a4,800093c4 <__memmove+0x160>
    800093d8:	f89ff06f          	j	80009360 <__memmove+0xfc>
	...
