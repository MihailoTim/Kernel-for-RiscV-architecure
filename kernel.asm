
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	fd013103          	ld	sp,-48(sp) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	3ac050ef          	jal	ra,800053c8 <start>

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
    80001088:	6d8020ef          	jal	ra,80003760 <_ZN5RiscV20handleSupervisorTrapEv>

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

0000000080001134 <_Z6memsetPKvii>:
                                    "tc_1",
                                    "tc_2",
                                    "tc_3",
                                    "tc_4"};

void memset(const void *data, int size, int value) {
    80001134:	ff010113          	addi	sp,sp,-16
    80001138:	00813423          	sd	s0,8(sp)
    8000113c:	01010413          	addi	s0,sp,16
    for (int j = 0; j < size; j++) {
    80001140:	00000793          	li	a5,0
    80001144:	00b7da63          	bge	a5,a1,80001158 <_Z6memsetPKvii+0x24>
        *((char *)data + j) = value;
    80001148:	00f50733          	add	a4,a0,a5
    8000114c:	00c70023          	sb	a2,0(a4)
    for (int j = 0; j < size; j++) {
    80001150:	0017879b          	addiw	a5,a5,1
    80001154:	ff1ff06f          	j	80001144 <_Z6memsetPKvii+0x10>
    }
}
    80001158:	00813403          	ld	s0,8(sp)
    8000115c:	01010113          	addi	sp,sp,16
    80001160:	00008067          	ret

0000000080001164 <_Z9constructPv>:

void construct(void *data) {
    80001164:	ff010113          	addi	sp,sp,-16
    80001168:	00113423          	sd	ra,8(sp)
    8000116c:	00813023          	sd	s0,0(sp)
    80001170:	01010413          	addi	s0,sp,16
//    static int i = 1;
//    printf("%d Shared object constructed.\n", i++);
    memset(data, shared_size, MASK);
    80001174:	0a500613          	li	a2,165
    80001178:	00700593          	li	a1,7
    8000117c:	00000097          	auipc	ra,0x0
    80001180:	fb8080e7          	jalr	-72(ra) # 80001134 <_Z6memsetPKvii>
}
    80001184:	00813083          	ld	ra,8(sp)
    80001188:	00013403          	ld	s0,0(sp)
    8000118c:	01010113          	addi	sp,sp,16
    80001190:	00008067          	ret

0000000080001194 <_Z5checkPvm>:

int check(void *data, size_t size) {
    80001194:	ff010113          	addi	sp,sp,-16
    80001198:	00813423          	sd	s0,8(sp)
    8000119c:	01010413          	addi	s0,sp,16
    800011a0:	00050613          	mv	a2,a0
    int ret = 1;
    for (uint64 i = 0; i < size; i++) {
    800011a4:	00000793          	li	a5,0
    int ret = 1;
    800011a8:	00100513          	li	a0,1
    800011ac:	0080006f          	j	800011b4 <_Z5checkPvm+0x20>
    for (uint64 i = 0; i < size; i++) {
    800011b0:	00178793          	addi	a5,a5,1
    800011b4:	00b7fe63          	bgeu	a5,a1,800011d0 <_Z5checkPvm+0x3c>
        if (((unsigned char *)data)[i] != MASK) {
    800011b8:	00f60733          	add	a4,a2,a5
    800011bc:	00074683          	lbu	a3,0(a4)
    800011c0:	0a500713          	li	a4,165
    800011c4:	fee686e3          	beq	a3,a4,800011b0 <_Z5checkPvm+0x1c>
            ret = 0;
    800011c8:	00000513          	li	a0,0
    800011cc:	fe5ff06f          	j	800011b0 <_Z5checkPvm+0x1c>
        }
    }

    return ret;
}
    800011d0:	00813403          	ld	s0,8(sp)
    800011d4:	01010113          	addi	sp,sp,16
    800011d8:	00008067          	ret

00000000800011dc <_Z4workPv>:
struct objects_s {
    kmem_cache_t *cache;
    void *data;
};

void work(void* pdata) {
    800011dc:	f8010113          	addi	sp,sp,-128
    800011e0:	06113c23          	sd	ra,120(sp)
    800011e4:	06813823          	sd	s0,112(sp)
    800011e8:	06913423          	sd	s1,104(sp)
    800011ec:	07213023          	sd	s2,96(sp)
    800011f0:	05313c23          	sd	s3,88(sp)
    800011f4:	05413823          	sd	s4,80(sp)
    800011f8:	05513423          	sd	s5,72(sp)
    800011fc:	05613023          	sd	s6,64(sp)
    80001200:	03713c23          	sd	s7,56(sp)
    80001204:	03813823          	sd	s8,48(sp)
    80001208:	03913423          	sd	s9,40(sp)
    8000120c:	08010413          	addi	s0,sp,128
    struct data_s data = *(struct data_s*) pdata;
    80001210:	00053c03          	ld	s8,0(a0)
    80001214:	f9843423          	sd	s8,-120(s0)
    80001218:	00853783          	ld	a5,8(a0)
    8000121c:	f8f43823          	sd	a5,-112(s0)
    80001220:	01053783          	ld	a5,16(a0)
    80001224:	f8f43c23          	sd	a5,-104(s0)
    int size = 0;
    int object_size = data.id + 1;
    80001228:	000c079b          	sext.w	a5,s8
    8000122c:	001c0c1b          	addiw	s8,s8,1
    kmem_cache_t *cache = kmem_cache_create(CACHE_NAMES[data.id], object_size, 0, 0);
    80001230:	00379713          	slli	a4,a5,0x3
    80001234:	0000a797          	auipc	a5,0xa
    80001238:	c8c78793          	addi	a5,a5,-884 # 8000aec0 <_ZL11CACHE_NAMES>
    8000123c:	00e787b3          	add	a5,a5,a4
    80001240:	000c0b13          	mv	s6,s8
    80001244:	00000693          	li	a3,0
    80001248:	00000613          	li	a2,0
    8000124c:	000c0593          	mv	a1,s8
    80001250:	0007b503          	ld	a0,0(a5)
    80001254:	00003097          	auipc	ra,0x3
    80001258:	124080e7          	jalr	292(ra) # 80004378 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000125c:	00050a13          	mv	s4,a0

    struct objects_s *objs = (struct objects_s*)(kmalloc(sizeof(struct objects_s) * data.iterations));
    80001260:	f9842b83          	lw	s7,-104(s0)
    80001264:	004b9513          	slli	a0,s7,0x4
    80001268:	00003097          	auipc	ra,0x3
    8000126c:	208080e7          	jalr	520(ra) # 80004470 <_Z7kmallocm>
    80001270:	00050a93          	mv	s5,a0

    for (int i = 0; i < data.iterations; i++) {
    80001274:	00000493          	li	s1,0
    int size = 0;
    80001278:	00000993          	li	s3,0
    8000127c:	0380006f          	j	800012b4 <_Z4workPv+0xd8>
            if (!check(objs[size].data, shared_size)) {
                ConsoleUtil::printString("Value not correct!");
            }
        }
        else {
            objs[size].data = kmem_cache_alloc(cache);
    80001280:	00499913          	slli	s2,s3,0x4
    80001284:	012a8933          	add	s2,s5,s2
    80001288:	000a0513          	mv	a0,s4
    8000128c:	00003097          	auipc	ra,0x3
    80001290:	114080e7          	jalr	276(ra) # 800043a0 <_Z16kmem_cache_allocP5Cache>
    80001294:	00a93423          	sd	a0,8(s2)
            objs[size].cache = cache;
    80001298:	01493023          	sd	s4,0(s2)
            memset(objs[size].data, object_size, MASK);
    8000129c:	0a500613          	li	a2,165
    800012a0:	000c0593          	mv	a1,s8
    800012a4:	00000097          	auipc	ra,0x0
    800012a8:	e90080e7          	jalr	-368(ra) # 80001134 <_Z6memsetPKvii>
        }
        size++;
    800012ac:	0019899b          	addiw	s3,s3,1
    for (int i = 0; i < data.iterations; i++) {
    800012b0:	0014849b          	addiw	s1,s1,1
    800012b4:	0574da63          	bge	s1,s7,80001308 <_Z4workPv+0x12c>
        if (i % 100 == 0) {
    800012b8:	06400793          	li	a5,100
    800012bc:	02f4e7bb          	remw	a5,s1,a5
    800012c0:	fc0790e3          	bnez	a5,80001280 <_Z4workPv+0xa4>
            objs[size].data = kmem_cache_alloc(data.shared);
    800012c4:	f9043c83          	ld	s9,-112(s0)
    800012c8:	00499913          	slli	s2,s3,0x4
    800012cc:	012a8933          	add	s2,s5,s2
    800012d0:	000c8513          	mv	a0,s9
    800012d4:	00003097          	auipc	ra,0x3
    800012d8:	0cc080e7          	jalr	204(ra) # 800043a0 <_Z16kmem_cache_allocP5Cache>
    800012dc:	00a93423          	sd	a0,8(s2)
            objs[size].cache = data.shared;
    800012e0:	01993023          	sd	s9,0(s2)
            if (!check(objs[size].data, shared_size)) {
    800012e4:	00700593          	li	a1,7
    800012e8:	00000097          	auipc	ra,0x0
    800012ec:	eac080e7          	jalr	-340(ra) # 80001194 <_Z5checkPvm>
    800012f0:	fa051ee3          	bnez	a0,800012ac <_Z4workPv+0xd0>
                ConsoleUtil::printString("Value not correct!");
    800012f4:	00007517          	auipc	a0,0x7
    800012f8:	d2c50513          	addi	a0,a0,-724 # 80008020 <CONSOLE_STATUS+0x10>
    800012fc:	00001097          	auipc	ra,0x1
    80001300:	690080e7          	jalr	1680(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    80001304:	fa9ff06f          	j	800012ac <_Z4workPv+0xd0>
    }

    kmem_cache_info(cache);
    80001308:	000a0513          	mv	a0,s4
    8000130c:	00003097          	auipc	ra,0x3
    80001310:	114080e7          	jalr	276(ra) # 80004420 <_Z15kmem_cache_infoP5Cache>
    kmem_cache_info(data.shared);
    80001314:	f9043503          	ld	a0,-112(s0)
    80001318:	00003097          	auipc	ra,0x3
    8000131c:	108080e7          	jalr	264(ra) # 80004420 <_Z15kmem_cache_infoP5Cache>

    for (int i = 0; i < size; i++) {
    80001320:	00000913          	li	s2,0
    80001324:	0300006f          	j	80001354 <_Z4workPv+0x178>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    80001328:	000b0593          	mv	a1,s6
    8000132c:	0440006f          	j	80001370 <_Z4workPv+0x194>
            ConsoleUtil::printString("Value not correct!");
    80001330:	00007517          	auipc	a0,0x7
    80001334:	cf050513          	addi	a0,a0,-784 # 80008020 <CONSOLE_STATUS+0x10>
    80001338:	00001097          	auipc	ra,0x1
    8000133c:	654080e7          	jalr	1620(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        }
        kmem_cache_free(objs[i].cache, objs[i].data);
    80001340:	0084b583          	ld	a1,8(s1)
    80001344:	0004b503          	ld	a0,0(s1)
    80001348:	00003097          	auipc	ra,0x3
    8000134c:	080080e7          	jalr	128(ra) # 800043c8 <_Z15kmem_cache_freeP5CachePv>
    for (int i = 0; i < size; i++) {
    80001350:	0019091b          	addiw	s2,s2,1
    80001354:	03395663          	bge	s2,s3,80001380 <_Z4workPv+0x1a4>
        if (!check(objs[i].data, (cache == objs[i].cache) ? object_size : shared_size)) {
    80001358:	00491493          	slli	s1,s2,0x4
    8000135c:	009a84b3          	add	s1,s5,s1
    80001360:	0084b503          	ld	a0,8(s1)
    80001364:	0004b783          	ld	a5,0(s1)
    80001368:	fd4780e3          	beq	a5,s4,80001328 <_Z4workPv+0x14c>
    8000136c:	00700593          	li	a1,7
    80001370:	00000097          	auipc	ra,0x0
    80001374:	e24080e7          	jalr	-476(ra) # 80001194 <_Z5checkPvm>
    80001378:	fc0514e3          	bnez	a0,80001340 <_Z4workPv+0x164>
    8000137c:	fb5ff06f          	j	80001330 <_Z4workPv+0x154>
    }

    kfree(objs);
    80001380:	000a8513          	mv	a0,s5
    80001384:	00003097          	auipc	ra,0x3
    80001388:	114080e7          	jalr	276(ra) # 80004498 <_Z5kfreePKv>
    kmem_cache_destroy(cache);
    8000138c:	000a0513          	mv	a0,s4
    80001390:	00003097          	auipc	ra,0x3
    80001394:	060080e7          	jalr	96(ra) # 800043f0 <_Z18kmem_cache_destroyP5Cache>
}
    80001398:	07813083          	ld	ra,120(sp)
    8000139c:	07013403          	ld	s0,112(sp)
    800013a0:	06813483          	ld	s1,104(sp)
    800013a4:	06013903          	ld	s2,96(sp)
    800013a8:	05813983          	ld	s3,88(sp)
    800013ac:	05013a03          	ld	s4,80(sp)
    800013b0:	04813a83          	ld	s5,72(sp)
    800013b4:	04013b03          	ld	s6,64(sp)
    800013b8:	03813b83          	ld	s7,56(sp)
    800013bc:	03013c03          	ld	s8,48(sp)
    800013c0:	02813c83          	ld	s9,40(sp)
    800013c4:	08010113          	addi	sp,sp,128
    800013c8:	00008067          	ret

00000000800013cc <_Z4runsPFvPvEP6data_si>:



void runs(void(*work)(void*), struct data_s* data, int num) {
    800013cc:	fb010113          	addi	sp,sp,-80
    800013d0:	04113423          	sd	ra,72(sp)
    800013d4:	04813023          	sd	s0,64(sp)
    800013d8:	02913c23          	sd	s1,56(sp)
    800013dc:	03213823          	sd	s2,48(sp)
    800013e0:	03313423          	sd	s3,40(sp)
    800013e4:	03413023          	sd	s4,32(sp)
    800013e8:	05010413          	addi	s0,sp,80
    800013ec:	00050a13          	mv	s4,a0
    800013f0:	00058913          	mv	s2,a1
    800013f4:	00060993          	mv	s3,a2
    for (int i = 0; i < num; i++) {
    800013f8:	00000493          	li	s1,0
    800013fc:	0334d863          	bge	s1,s3,8000142c <_Z4runsPFvPvEP6data_si+0x60>
        struct data_s private_data;
        private_data = *(struct data_s*) data;
    80001400:	00093783          	ld	a5,0(s2)
    80001404:	faf43c23          	sd	a5,-72(s0)
    80001408:	00893783          	ld	a5,8(s2)
    8000140c:	fcf43023          	sd	a5,-64(s0)
    80001410:	01093783          	ld	a5,16(s2)
    80001414:	fcf43423          	sd	a5,-56(s0)
        private_data.id = i;
    80001418:	fa942c23          	sw	s1,-72(s0)
        work(&private_data);
    8000141c:	fb840513          	addi	a0,s0,-72
    80001420:	000a00e7          	jalr	s4
    for (int i = 0; i < num; i++) {
    80001424:	0014849b          	addiw	s1,s1,1
    80001428:	fd5ff06f          	j	800013fc <_Z4runsPFvPvEP6data_si+0x30>
    }
}
    8000142c:	04813083          	ld	ra,72(sp)
    80001430:	04013403          	ld	s0,64(sp)
    80001434:	03813483          	ld	s1,56(sp)
    80001438:	03013903          	ld	s2,48(sp)
    8000143c:	02813983          	ld	s3,40(sp)
    80001440:	02013a03          	ld	s4,32(sp)
    80001444:	05010113          	addi	sp,sp,80
    80001448:	00008067          	ret

000000008000144c <_Z5test2v>:

void test2() {
    8000144c:	fc010113          	addi	sp,sp,-64
    80001450:	02113c23          	sd	ra,56(sp)
    80001454:	02813823          	sd	s0,48(sp)
    80001458:	02913423          	sd	s1,40(sp)
    8000145c:	04010413          	addi	s0,sp,64
    kmem_cache_t *shared = kmem_cache_create("shared object", shared_size, construct, nullptr);
    80001460:	00000693          	li	a3,0
    80001464:	00000617          	auipc	a2,0x0
    80001468:	d0060613          	addi	a2,a2,-768 # 80001164 <_Z9constructPv>
    8000146c:	00700593          	li	a1,7
    80001470:	00007517          	auipc	a0,0x7
    80001474:	bc850513          	addi	a0,a0,-1080 # 80008038 <CONSOLE_STATUS+0x28>
    80001478:	00003097          	auipc	ra,0x3
    8000147c:	f00080e7          	jalr	-256(ra) # 80004378 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001480:	00050493          	mv	s1,a0

    struct data_s data;
    data.shared = shared;
    80001484:	fca43823          	sd	a0,-48(s0)
    data.iterations = ITERATIONS;
    80001488:	3e800793          	li	a5,1000
    8000148c:	fcf42c23          	sw	a5,-40(s0)
    runs(work, &data, RUN_NUM);
    80001490:	00500613          	li	a2,5
    80001494:	fc840593          	addi	a1,s0,-56
    80001498:	00000517          	auipc	a0,0x0
    8000149c:	d4450513          	addi	a0,a0,-700 # 800011dc <_Z4workPv>
    800014a0:	00000097          	auipc	ra,0x0
    800014a4:	f2c080e7          	jalr	-212(ra) # 800013cc <_Z4runsPFvPvEP6data_si>

    kmem_cache_destroy(shared);
    800014a8:	00048513          	mv	a0,s1
    800014ac:	00003097          	auipc	ra,0x3
    800014b0:	f44080e7          	jalr	-188(ra) # 800043f0 <_Z18kmem_cache_destroyP5Cache>
}
    800014b4:	03813083          	ld	ra,56(sp)
    800014b8:	03013403          	ld	s0,48(sp)
    800014bc:	02813483          	ld	s1,40(sp)
    800014c0:	04010113          	addi	sp,sp,64
    800014c4:	00008067          	ret

00000000800014c8 <_Z4ctorPv>:

struct Test{
    uint64 a,b,c,d,e,f;
};

void ctor(void* tst){
    800014c8:	ff010113          	addi	sp,sp,-16
    800014cc:	00813423          	sd	s0,8(sp)
    800014d0:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    800014d4:	01100793          	li	a5,17
    800014d8:	00f53023          	sd	a5,0(a0)
    ((Test*)tst)->b = 32;
    800014dc:	02000793          	li	a5,32
    800014e0:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    800014e4:	00d00793          	li	a5,13
    800014e8:	00f53823          	sd	a5,16(a0)

}
    800014ec:	00813403          	ld	s0,8(sp)
    800014f0:	01010113          	addi	sp,sp,16
    800014f4:	00008067          	ret

00000000800014f8 <_ZN6SystemC1Ev>:


System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
    800014f8:	0000a797          	auipc	a5,0xa
    800014fc:	ba87c783          	lbu	a5,-1112(a5) # 8000b0a0 <_ZN6System11initializedE>
    80001500:	00078463          	beqz	a5,80001508 <_ZN6SystemC1Ev+0x10>
    80001504:	00008067          	ret
System::System() {
    80001508:	fd010113          	addi	sp,sp,-48
    8000150c:	02113423          	sd	ra,40(sp)
    80001510:	02813023          	sd	s0,32(sp)
    80001514:	00913c23          	sd	s1,24(sp)
    80001518:	03010413          	addi	s0,sp,48
        initialized = true;
    8000151c:	00100793          	li	a5,1
    80001520:	0000a717          	auipc	a4,0xa
    80001524:	b8f70023          	sb	a5,-1152(a4) # 8000b0a0 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    80001528:	00003097          	auipc	ra,0x3
    8000152c:	ac4080e7          	jalr	-1340(ra) # 80003fec <_ZN5RiscV10initializeEv>

        ConsoleUtil::print("",sizeof(Slab),"\n",10);
    80001530:	00a00693          	li	a3,10
    80001534:	00007617          	auipc	a2,0x7
    80001538:	be460613          	addi	a2,a2,-1052 # 80008118 <CONSOLE_STATUS+0x108>
    8000153c:	0b000593          	li	a1,176
    80001540:	00007517          	auipc	a0,0x7
    80001544:	c3050513          	addi	a0,a0,-976 # 80008170 <CONSOLE_STATUS+0x160>
    80001548:	00001097          	auipc	ra,0x1
    8000154c:	564080e7          	jalr	1380(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>

        Cache* cache=kmem_cache_create("",20,nullptr, nullptr);
    80001550:	00000693          	li	a3,0
    80001554:	00000613          	li	a2,0
    80001558:	01400593          	li	a1,20
    8000155c:	00007517          	auipc	a0,0x7
    80001560:	c1450513          	addi	a0,a0,-1004 # 80008170 <CONSOLE_STATUS+0x160>
    80001564:	00003097          	auipc	ra,0x3
    80001568:	e14080e7          	jalr	-492(ra) # 80004378 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000156c:	00050493          	mv	s1,a0
        kmem_cache_alloc(cache);
    80001570:	00003097          	auipc	ra,0x3
    80001574:	e30080e7          	jalr	-464(ra) # 800043a0 <_Z16kmem_cache_allocP5Cache>
        SlabAllocator::printSlab(cache->partialHead);
    80001578:	0704b503          	ld	a0,112(s1)
    8000157c:	00003097          	auipc	ra,0x3
    80001580:	fd4080e7          	jalr	-44(ra) # 80004550 <_ZN13SlabAllocator9printSlabEP4Slab>
//        SlabAllocator::printSlab(cache2->fullHead);
//
//        kmem_cache_info(SlabAllocator::largeSlabCache);
//        SlabAllocator::printSlab(SlabAllocator::largeSlabCache->partialHead);

        test2();
    80001584:	00000097          	auipc	ra,0x0
    80001588:	ec8080e7          	jalr	-312(ra) # 8000144c <_Z5test2v>
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), userMainWrapper, nullptr);
    8000158c:	00000613          	li	a2,0
    80001590:	0000a597          	auipc	a1,0xa
    80001594:	a485b583          	ld	a1,-1464(a1) # 8000afd8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001598:	fd840513          	addi	a0,s0,-40
    8000159c:	00002097          	auipc	ra,0x2
    800015a0:	624080e7          	jalr	1572(ra) # 80003bc0 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    800015a4:	fd843783          	ld	a5,-40(s0)
    800015a8:	0107a703          	lw	a4,16(a5)
    800015ac:	00200793          	li	a5,2
    800015b0:	00f70863          	beq	a4,a5,800015c0 <_ZN6SystemC1Ev+0xc8>
            RiscV::threadDispatchUtil();
    800015b4:	00002097          	auipc	ra,0x2
    800015b8:	e6c080e7          	jalr	-404(ra) # 80003420 <_ZN5RiscV18threadDispatchUtilEv>
    800015bc:	fe9ff06f          	j	800015a4 <_ZN6SystemC1Ev+0xac>
        }

        //finalize the machine
        RiscV::finalize();
    800015c0:	00001097          	auipc	ra,0x1
    800015c4:	6a8080e7          	jalr	1704(ra) # 80002c68 <_ZN5RiscV8finalizeEv>
    }
    800015c8:	02813083          	ld	ra,40(sp)
    800015cc:	02013403          	ld	s0,32(sp)
    800015d0:	01813483          	ld	s1,24(sp)
    800015d4:	03010113          	addi	sp,sp,48
    800015d8:	00008067          	ret

00000000800015dc <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    800015dc:	ff010113          	addi	sp,sp,-16
    800015e0:	00813423          	sd	s0,8(sp)
    800015e4:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    800015e8:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    800015ec:	00053823          	sd	zero,16(a0)
}
    800015f0:	00813403          	ld	s0,8(sp)
    800015f4:	01010113          	addi	sp,sp,16
    800015f8:	00008067          	ret

00000000800015fc <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    800015fc:	ff010113          	addi	sp,sp,-16
    80001600:	00813423          	sd	s0,8(sp)
    80001604:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80001608:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    8000160c:	00053823          	sd	zero,16(a0)
    80001610:	00813403          	ld	s0,8(sp)
    80001614:	01010113          	addi	sp,sp,16
    80001618:	00008067          	ret

000000008000161c <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    8000161c:	ff010113          	addi	sp,sp,-16
    80001620:	00113423          	sd	ra,8(sp)
    80001624:	00813023          	sd	s0,0(sp)
    80001628:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    8000162c:	00000697          	auipc	a3,0x0
    80001630:	fd068693          	addi	a3,a3,-48 # 800015fc <_ZN3SCB4dtorEPv>
    80001634:	00000617          	auipc	a2,0x0
    80001638:	fa860613          	addi	a2,a2,-88 # 800015dc <_ZN3SCB4ctorEPv>
    8000163c:	01800593          	li	a1,24
    80001640:	00007517          	auipc	a0,0x7
    80001644:	a3050513          	addi	a0,a0,-1488 # 80008070 <CONSOLE_STATUS+0x60>
    80001648:	00003097          	auipc	ra,0x3
    8000164c:	d30080e7          	jalr	-720(ra) # 80004378 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001650:	0000a797          	auipc	a5,0xa
    80001654:	a4a7bc23          	sd	a0,-1448(a5) # 8000b0a8 <_ZN3SCB8scbCacheE>
}
    80001658:	00813083          	ld	ra,8(sp)
    8000165c:	00013403          	ld	s0,0(sp)
    80001660:	01010113          	addi	sp,sp,16
    80001664:	00008067          	ret

0000000080001668 <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    80001668:	ff010113          	addi	sp,sp,-16
    8000166c:	00813423          	sd	s0,8(sp)
    80001670:	01010413          	addi	s0,sp,16
    val = init;
    80001674:	00b52023          	sw	a1,0(a0)
}
    80001678:	00813403          	ld	s0,8(sp)
    8000167c:	01010113          	addi	sp,sp,16
    80001680:	00008067          	ret

0000000080001684 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80001684:	fe010113          	addi	sp,sp,-32
    80001688:	00113c23          	sd	ra,24(sp)
    8000168c:	00813823          	sd	s0,16(sp)
    80001690:	00913423          	sd	s1,8(sp)
    80001694:	01213023          	sd	s2,0(sp)
    80001698:	02010413          	addi	s0,sp,32
    8000169c:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    800016a0:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    800016a4:	02050063          	beqz	a0,800016c4 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    800016a8:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    800016ac:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    800016b0:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    800016b4:	00003097          	auipc	ra,0x3
    800016b8:	aa0080e7          	jalr	-1376(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    800016bc:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    800016c0:	fe5ff06f          	j	800016a4 <_ZN3SCBD1Ev+0x20>
}
    800016c4:	01813083          	ld	ra,24(sp)
    800016c8:	01013403          	ld	s0,16(sp)
    800016cc:	00813483          	ld	s1,8(sp)
    800016d0:	00013903          	ld	s2,0(sp)
    800016d4:	02010113          	addi	sp,sp,32
    800016d8:	00008067          	ret

00000000800016dc <_ZN3SCB5blockEv>:
void SCB::block() {
    800016dc:	ff010113          	addi	sp,sp,-16
    800016e0:	00113423          	sd	ra,8(sp)
    800016e4:	00813023          	sd	s0,0(sp)
    800016e8:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800016ec:	00853783          	ld	a5,8(a0)
    800016f0:	04078063          	beqz	a5,80001730 <_ZN3SCB5blockEv+0x54>
    800016f4:	01053703          	ld	a4,16(a0)
    800016f8:	0000a797          	auipc	a5,0xa
    800016fc:	9287b783          	ld	a5,-1752(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80001700:	0007b783          	ld	a5,0(a5)
    80001704:	04f73423          	sd	a5,72(a4)
    80001708:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    8000170c:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80001710:	00300713          	li	a4,3
    80001714:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80001718:	00001097          	auipc	ra,0x1
    8000171c:	8e8080e7          	jalr	-1816(ra) # 80002000 <_ZN3TCB8dispatchEv>
}
    80001720:	00813083          	ld	ra,8(sp)
    80001724:	00013403          	ld	s0,0(sp)
    80001728:	01010113          	addi	sp,sp,16
    8000172c:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80001730:	0000a797          	auipc	a5,0xa
    80001734:	8f07b783          	ld	a5,-1808(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80001738:	0007b783          	ld	a5,0(a5)
    8000173c:	00f53423          	sd	a5,8(a0)
    80001740:	fc9ff06f          	j	80001708 <_ZN3SCB5blockEv+0x2c>

0000000080001744 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    80001744:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80001748:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    8000174c:	04853703          	ld	a4,72(a0)
    80001750:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80001754:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80001758:	02050a63          	beqz	a0,8000178c <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    8000175c:	ff010113          	addi	sp,sp,-16
    80001760:	00113423          	sd	ra,8(sp)
    80001764:	00813023          	sd	s0,0(sp)
    80001768:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    8000176c:	00100793          	li	a5,1
    80001770:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80001774:	00003097          	auipc	ra,0x3
    80001778:	9e0080e7          	jalr	-1568(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>
}
    8000177c:	00813083          	ld	ra,8(sp)
    80001780:	00013403          	ld	s0,0(sp)
    80001784:	01010113          	addi	sp,sp,16
    80001788:	00008067          	ret
    8000178c:	00008067          	ret

0000000080001790 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80001790:	0000a797          	auipc	a5,0xa
    80001794:	8907b783          	ld	a5,-1904(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80001798:	0007b783          	ld	a5,0(a5)
    8000179c:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    800017a0:	00052783          	lw	a5,0(a0)
    800017a4:	fff7879b          	addiw	a5,a5,-1
    800017a8:	00f52023          	sw	a5,0(a0)
    800017ac:	02079713          	slli	a4,a5,0x20
    800017b0:	00074463          	bltz	a4,800017b8 <_ZN3SCB4waitEv+0x28>
    800017b4:	00008067          	ret
void SCB::wait() {
    800017b8:	ff010113          	addi	sp,sp,-16
    800017bc:	00113423          	sd	ra,8(sp)
    800017c0:	00813023          	sd	s0,0(sp)
    800017c4:	01010413          	addi	s0,sp,16
        block();
    800017c8:	00000097          	auipc	ra,0x0
    800017cc:	f14080e7          	jalr	-236(ra) # 800016dc <_ZN3SCB5blockEv>
}
    800017d0:	00813083          	ld	ra,8(sp)
    800017d4:	00013403          	ld	s0,0(sp)
    800017d8:	01010113          	addi	sp,sp,16
    800017dc:	00008067          	ret

00000000800017e0 <_ZN3SCB6signalEv>:
    if(val++<0)
    800017e0:	00052783          	lw	a5,0(a0)
    800017e4:	0017871b          	addiw	a4,a5,1
    800017e8:	00e52023          	sw	a4,0(a0)
    800017ec:	0007c463          	bltz	a5,800017f4 <_ZN3SCB6signalEv+0x14>
    800017f0:	00008067          	ret
void SCB::signal(){
    800017f4:	ff010113          	addi	sp,sp,-16
    800017f8:	00113423          	sd	ra,8(sp)
    800017fc:	00813023          	sd	s0,0(sp)
    80001800:	01010413          	addi	s0,sp,16
        deblock();
    80001804:	00000097          	auipc	ra,0x0
    80001808:	f40080e7          	jalr	-192(ra) # 80001744 <_ZN3SCB7deblockEv>
}
    8000180c:	00813083          	ld	ra,8(sp)
    80001810:	00013403          	ld	s0,0(sp)
    80001814:	01010113          	addi	sp,sp,16
    80001818:	00008067          	ret

000000008000181c <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    8000181c:	ff010113          	addi	sp,sp,-16
    80001820:	00113423          	sd	ra,8(sp)
    80001824:	00813023          	sd	s0,0(sp)
    80001828:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    8000182c:	0000a517          	auipc	a0,0xa
    80001830:	87c53503          	ld	a0,-1924(a0) # 8000b0a8 <_ZN3SCB8scbCacheE>
    80001834:	00003097          	auipc	ra,0x3
    80001838:	b6c080e7          	jalr	-1172(ra) # 800043a0 <_Z16kmem_cache_allocP5Cache>
}
    8000183c:	00813083          	ld	ra,8(sp)
    80001840:	00013403          	ld	s0,0(sp)
    80001844:	01010113          	addi	sp,sp,16
    80001848:	00008067          	ret

000000008000184c <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    8000184c:	ff010113          	addi	sp,sp,-16
    80001850:	00113423          	sd	ra,8(sp)
    80001854:	00813023          	sd	s0,0(sp)
    80001858:	01010413          	addi	s0,sp,16
    8000185c:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80001860:	0000a517          	auipc	a0,0xa
    80001864:	84853503          	ld	a0,-1976(a0) # 8000b0a8 <_ZN3SCB8scbCacheE>
    80001868:	00003097          	auipc	ra,0x3
    8000186c:	b60080e7          	jalr	-1184(ra) # 800043c8 <_Z15kmem_cache_freeP5CachePv>
}
    80001870:	00813083          	ld	ra,8(sp)
    80001874:	00013403          	ld	s0,0(sp)
    80001878:	01010113          	addi	sp,sp,16
    8000187c:	00008067          	ret

0000000080001880 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80001880:	ff010113          	addi	sp,sp,-16
    80001884:	00813423          	sd	s0,8(sp)
    80001888:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    8000188c:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80001890:	05200513          	li	a0,82
    asm("ecall");
    80001894:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80001898:	00050513          	mv	a0,a0
}
    8000189c:	0005051b          	sext.w	a0,a0
    800018a0:	00813403          	ld	s0,8(sp)
    800018a4:	01010113          	addi	sp,sp,16
    800018a8:	00008067          	ret

00000000800018ac <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    800018ac:	ff010113          	addi	sp,sp,-16
    800018b0:	00813423          	sd	s0,8(sp)
    800018b4:	01010413          	addi	s0,sp,16
    800018b8:	00100793          	li	a5,1
    800018bc:	00f50863          	beq	a0,a5,800018cc <_Z41__static_initialization_and_destruction_0ii+0x20>
    800018c0:	00813403          	ld	s0,8(sp)
    800018c4:	01010113          	addi	sp,sp,16
    800018c8:	00008067          	ret
    800018cc:	000107b7          	lui	a5,0x10
    800018d0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800018d4:	fef596e3          	bne	a1,a5,800018c0 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    800018d8:	00009797          	auipc	a5,0x9
    800018dc:	6a87b783          	ld	a5,1704(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x18>
    800018e0:	0007b703          	ld	a4,0(a5)
    800018e4:	00c75793          	srli	a5,a4,0xc
    800018e8:	00278793          	addi	a5,a5,2
    800018ec:	00c79793          	slli	a5,a5,0xc
    800018f0:	00009697          	auipc	a3,0x9
    800018f4:	7c068693          	addi	a3,a3,1984 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800018f8:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800018fc:	fffff7b7          	lui	a5,0xfffff
    80001900:	00f77733          	and	a4,a4,a5
    80001904:	00e6b423          	sd	a4,8(a3)
    80001908:	fb9ff06f          	j	800018c0 <_Z41__static_initialization_and_destruction_0ii+0x14>

000000008000190c <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    8000190c:	ff010113          	addi	sp,sp,-16
    80001910:	00813423          	sd	s0,8(sp)
    80001914:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80001918:	00009717          	auipc	a4,0x9
    8000191c:	79870713          	addi	a4,a4,1944 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001920:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001924:	00009797          	auipc	a5,0x9
    80001928:	65c7b783          	ld	a5,1628(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000192c:	0007b783          	ld	a5,0(a5)
    80001930:	fffff6b7          	lui	a3,0xfffff
    80001934:	00d7f7b3          	and	a5,a5,a3
    80001938:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    8000193c:	00009797          	auipc	a5,0x9
    80001940:	5ab7ba23          	sd	a1,1460(a5) # 8000aef0 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80001944:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001948:	00000713          	li	a4,0
        while(num>1){
    8000194c:	00100693          	li	a3,1
    80001950:	00f6f863          	bgeu	a3,a5,80001960 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80001954:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001958:	00170713          	addi	a4,a4,1
        while(num>1){
    8000195c:	ff1ff06f          	j	8000194c <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80001960:	00371713          	slli	a4,a4,0x3
    80001964:	00009797          	auipc	a5,0x9
    80001968:	74c78793          	addi	a5,a5,1868 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000196c:	00e78733          	add	a4,a5,a4
    80001970:	00a73823          	sd	a0,16(a4)
    80001974:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001978:	00000713          	li	a4,0
        while(num>1){
    8000197c:	00100693          	li	a3,1
    80001980:	00f6f863          	bgeu	a3,a5,80001990 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80001984:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001988:	00170713          	addi	a4,a4,1
        while(num>1){
    8000198c:	ff1ff06f          	j	8000197c <_ZN5Buddy10initializeEPvm+0x70>
    80001990:	00371713          	slli	a4,a4,0x3
    80001994:	00009797          	auipc	a5,0x9
    80001998:	71c78793          	addi	a5,a5,1820 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000199c:	00e78733          	add	a4,a5,a4
    800019a0:	06a73c23          	sd	a0,120(a4)
    800019a4:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800019a8:	00000713          	li	a4,0
        while(num>1){
    800019ac:	00100693          	li	a3,1
    800019b0:	00f6f863          	bgeu	a3,a5,800019c0 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    800019b4:	0017d793          	srli	a5,a5,0x1
            deg++;
    800019b8:	00170713          	addi	a4,a4,1
        while(num>1){
    800019bc:	ff1ff06f          	j	800019ac <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    800019c0:	00371713          	slli	a4,a4,0x3
    800019c4:	00009797          	auipc	a5,0x9
    800019c8:	6ec78793          	addi	a5,a5,1772 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800019cc:	00e78733          	add	a4,a5,a4
    800019d0:	01073783          	ld	a5,16(a4)
    800019d4:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    800019d8:	00000793          	li	a5,0
    800019dc:	00c0006f          	j	800019e8 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    800019e0:	0015d593          	srli	a1,a1,0x1
            deg++;
    800019e4:	00178793          	addi	a5,a5,1
        while(num>1){
    800019e8:	00100713          	li	a4,1
    800019ec:	feb76ae3          	bltu	a4,a1,800019e0 <_ZN5Buddy10initializeEPvm+0xd4>
    800019f0:	00379793          	slli	a5,a5,0x3
    800019f4:	00009717          	auipc	a4,0x9
    800019f8:	6bc70713          	addi	a4,a4,1724 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800019fc:	00f707b3          	add	a5,a4,a5
    80001a00:	0787b783          	ld	a5,120(a5)
    80001a04:	0007b023          	sd	zero,0(a5)
}
    80001a08:	00813403          	ld	s0,8(sp)
    80001a0c:	01010113          	addi	sp,sp,16
    80001a10:	00008067          	ret

0000000080001a14 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001a14:	00c00793          	li	a5,12
    80001a18:	10f50063          	beq	a0,a5,80001b18 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80001a1c:	fd010113          	addi	sp,sp,-48
    80001a20:	02113423          	sd	ra,40(sp)
    80001a24:	02813023          	sd	s0,32(sp)
    80001a28:	00913c23          	sd	s1,24(sp)
    80001a2c:	01213823          	sd	s2,16(sp)
    80001a30:	01313423          	sd	s3,8(sp)
    80001a34:	03010413          	addi	s0,sp,48
    80001a38:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80001a3c:	00351713          	slli	a4,a0,0x3
    80001a40:	00009797          	auipc	a5,0x9
    80001a44:	67078793          	addi	a5,a5,1648 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001a48:	00e787b3          	add	a5,a5,a4
    80001a4c:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80001a50:	00000993          	li	s3,0
    80001a54:	0180006f          	j	80001a6c <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80001a58:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80001a5c:	04f70463          	beq	a4,a5,80001aa4 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80001a60:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80001a64:	08f70063          	beq	a4,a5,80001ae4 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80001a68:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80001a6c:	08048863          	beqz	s1,80001afc <_ZN5Buddy8compressEm+0xe8>
    80001a70:	0004b683          	ld	a3,0(s1)
    80001a74:	08068463          	beqz	a3,80001afc <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80001a78:	00009797          	auipc	a5,0x9
    80001a7c:	6387b783          	ld	a5,1592(a5) # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001a80:	40f48733          	sub	a4,s1,a5
    80001a84:	00c9061b          	addiw	a2,s2,12
    80001a88:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80001a8c:	40f687b3          	sub	a5,a3,a5
    80001a90:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80001a94:	00177613          	andi	a2,a4,1
    80001a98:	fc0610e3          	bnez	a2,80001a58 <_ZN5Buddy8compressEm+0x44>
    80001a9c:	00170713          	addi	a4,a4,1
    80001aa0:	fbdff06f          	j	80001a5c <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80001aa4:	00098863          	beqz	s3,80001ab4 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    80001aa8:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffee000>
    80001aac:	00d9b023          	sd	a3,0(s3)
    80001ab0:	fb5ff06f          	j	80001a64 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80001ab4:	0006b603          	ld	a2,0(a3)
    80001ab8:	00391593          	slli	a1,s2,0x3
    80001abc:	00009697          	auipc	a3,0x9
    80001ac0:	5f468693          	addi	a3,a3,1524 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ac4:	00b686b3          	add	a3,a3,a1
    80001ac8:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    80001acc:	f8061ce3          	bnez	a2,80001a64 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    80001ad0:	00009697          	auipc	a3,0x9
    80001ad4:	5e068693          	addi	a3,a3,1504 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ad8:	00b686b3          	add	a3,a3,a1
    80001adc:	0006b823          	sd	zero,16(a3)
    80001ae0:	f85ff06f          	j	80001a64 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80001ae4:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80001ae8:	00190593          	addi	a1,s2,1
    80001aec:	00048513          	mv	a0,s1
    80001af0:	00000097          	auipc	ra,0x0
    80001af4:	02c080e7          	jalr	44(ra) # 80001b1c <_ZN5Buddy6insertEPvm>
    80001af8:	f71ff06f          	j	80001a68 <_ZN5Buddy8compressEm+0x54>
}
    80001afc:	02813083          	ld	ra,40(sp)
    80001b00:	02013403          	ld	s0,32(sp)
    80001b04:	01813483          	ld	s1,24(sp)
    80001b08:	01013903          	ld	s2,16(sp)
    80001b0c:	00813983          	ld	s3,8(sp)
    80001b10:	03010113          	addi	sp,sp,48
    80001b14:	00008067          	ret
    80001b18:	00008067          	ret

0000000080001b1c <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80001b1c:	00050693          	mv	a3,a0
    if(!head[size]){
    80001b20:	00359713          	slli	a4,a1,0x3
    80001b24:	00009797          	auipc	a5,0x9
    80001b28:	58c78793          	addi	a5,a5,1420 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b2c:	00e787b3          	add	a5,a5,a4
    80001b30:	0787b783          	ld	a5,120(a5)
    80001b34:	02078c63          	beqz	a5,80001b6c <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80001b38:	ff010113          	addi	sp,sp,-16
    80001b3c:	00113423          	sd	ra,8(sp)
    80001b40:	00813023          	sd	s0,0(sp)
    80001b44:	01010413          	addi	s0,sp,16
    80001b48:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80001b4c:	00068713          	mv	a4,a3
    80001b50:	04f6e063          	bltu	a3,a5,80001b90 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80001b54:	00000613          	li	a2,0
            while (iter != nullptr) {
    80001b58:	06078863          	beqz	a5,80001bc8 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80001b5c:	04f76c63          	bltu	a4,a5,80001bb4 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80001b60:	00078613          	mv	a2,a5
                    iter = iter->next;
    80001b64:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80001b68:	ff1ff06f          	j	80001b58 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80001b6c:	00009797          	auipc	a5,0x9
    80001b70:	54478793          	addi	a5,a5,1348 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b74:	00e78533          	add	a0,a5,a4
    80001b78:	00d53823          	sd	a3,16(a0)
    80001b7c:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80001b80:	0006b023          	sd	zero,0(a3)
    80001b84:	07853783          	ld	a5,120(a0)
    80001b88:	0007b023          	sd	zero,0(a5)
        return;
    80001b8c:	00008067          	ret
            newHead->next = head[size];
    80001b90:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80001b94:	00359713          	slli	a4,a1,0x3
    80001b98:	00009797          	auipc	a5,0x9
    80001b9c:	51878793          	addi	a5,a5,1304 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ba0:	00e787b3          	add	a5,a5,a4
    80001ba4:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80001ba8:	00000097          	auipc	ra,0x0
    80001bac:	e6c080e7          	jalr	-404(ra) # 80001a14 <_ZN5Buddy8compressEm>
            return;
    80001bb0:	0440006f          	j	80001bf4 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    80001bb4:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80001bb8:	00d63023          	sd	a3,0(a2)
                    compress(size);
    80001bbc:	00000097          	auipc	ra,0x0
    80001bc0:	e58080e7          	jalr	-424(ra) # 80001a14 <_ZN5Buddy8compressEm>
                    return;
    80001bc4:	0300006f          	j	80001bf4 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    80001bc8:	00351713          	slli	a4,a0,0x3
    80001bcc:	00009797          	auipc	a5,0x9
    80001bd0:	4e478793          	addi	a5,a5,1252 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001bd4:	00e787b3          	add	a5,a5,a4
    80001bd8:	0107b703          	ld	a4,16(a5)
    80001bdc:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80001be0:	0107b703          	ld	a4,16(a5)
    80001be4:	00073703          	ld	a4,0(a4)
    80001be8:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80001bec:	00000097          	auipc	ra,0x0
    80001bf0:	e28080e7          	jalr	-472(ra) # 80001a14 <_ZN5Buddy8compressEm>
}
    80001bf4:	00813083          	ld	ra,8(sp)
    80001bf8:	00013403          	ld	s0,0(sp)
    80001bfc:	01010113          	addi	sp,sp,16
    80001c00:	00008067          	ret

0000000080001c04 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80001c04:	02050663          	beqz	a0,80001c30 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80001c08:	ff010113          	addi	sp,sp,-16
    80001c0c:	00113423          	sd	ra,8(sp)
    80001c10:	00813023          	sd	s0,0(sp)
    80001c14:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80001c18:	00000097          	auipc	ra,0x0
    80001c1c:	f04080e7          	jalr	-252(ra) # 80001b1c <_ZN5Buddy6insertEPvm>
}
    80001c20:	00813083          	ld	ra,8(sp)
    80001c24:	00013403          	ld	s0,0(sp)
    80001c28:	01010113          	addi	sp,sp,16
    80001c2c:	00008067          	ret
    80001c30:	00008067          	ret

0000000080001c34 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001c34:	ff010113          	addi	sp,sp,-16
    80001c38:	00813423          	sd	s0,8(sp)
    80001c3c:	01010413          	addi	s0,sp,16
    80001c40:	03c0006f          	j	80001c7c <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001c44:	00b5859b          	addiw	a1,a1,11
    80001c48:	00100713          	li	a4,1
    80001c4c:	00b715bb          	sllw	a1,a4,a1
    80001c50:	00b505b3          	add	a1,a0,a1
    80001c54:	00379693          	slli	a3,a5,0x3
    80001c58:	00009717          	auipc	a4,0x9
    80001c5c:	45870713          	addi	a4,a4,1112 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c60:	00d70733          	add	a4,a4,a3
    80001c64:	00b73823          	sd	a1,16(a4)
    80001c68:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80001c6c:	0005b023          	sd	zero,0(a1)
    80001c70:	07873703          	ld	a4,120(a4)
    80001c74:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001c78:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80001c7c:	fff5879b          	addiw	a5,a1,-1
    80001c80:	04c7c863          	blt	a5,a2,80001cd0 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80001c84:	00379693          	slli	a3,a5,0x3
    80001c88:	00009717          	auipc	a4,0x9
    80001c8c:	42870713          	addi	a4,a4,1064 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c90:	00d70733          	add	a4,a4,a3
    80001c94:	01073683          	ld	a3,16(a4)
    80001c98:	fa0686e3          	beqz	a3,80001c44 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001c9c:	00b5859b          	addiw	a1,a1,11
    80001ca0:	00100713          	li	a4,1
    80001ca4:	00b715bb          	sllw	a1,a4,a1
    80001ca8:	00b505b3          	add	a1,a0,a1
    80001cac:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80001cb0:	00379693          	slli	a3,a5,0x3
    80001cb4:	00009717          	auipc	a4,0x9
    80001cb8:	3fc70713          	addi	a4,a4,1020 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001cbc:	00d70733          	add	a4,a4,a3
    80001cc0:	01073683          	ld	a3,16(a4)
    80001cc4:	0006b683          	ld	a3,0(a3)
    80001cc8:	00d73823          	sd	a3,16(a4)
    80001ccc:	fadff06f          	j	80001c78 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80001cd0:	00813403          	ld	s0,8(sp)
    80001cd4:	01010113          	addi	sp,sp,16
    80001cd8:	00008067          	ret

0000000080001cdc <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80001cdc:	fe010113          	addi	sp,sp,-32
    80001ce0:	00113c23          	sd	ra,24(sp)
    80001ce4:	00813823          	sd	s0,16(sp)
    80001ce8:	00913423          	sd	s1,8(sp)
    80001cec:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80001cf0:	00c00793          	li	a5,12
    80001cf4:	06a7ec63          	bltu	a5,a0,80001d6c <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001cf8:	00050593          	mv	a1,a0
    80001cfc:	00c00793          	li	a5,12
    80001d00:	06b7ea63          	bltu	a5,a1,80001d74 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80001d04:	00359713          	slli	a4,a1,0x3
    80001d08:	00009797          	auipc	a5,0x9
    80001d0c:	3a878793          	addi	a5,a5,936 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d10:	00e787b3          	add	a5,a5,a4
    80001d14:	0787b483          	ld	s1,120(a5)
    80001d18:	00049663          	bnez	s1,80001d24 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001d1c:	00158593          	addi	a1,a1,1
    80001d20:	fddff06f          	j	80001cfc <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80001d24:	0004b703          	ld	a4,0(s1)
    80001d28:	00359693          	slli	a3,a1,0x3
    80001d2c:	00009797          	auipc	a5,0x9
    80001d30:	38478793          	addi	a5,a5,900 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d34:	00d787b3          	add	a5,a5,a3
    80001d38:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80001d3c:	00070e63          	beqz	a4,80001d58 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80001d40:	0005061b          	sext.w	a2,a0
    80001d44:	0005859b          	sext.w	a1,a1
    80001d48:	00048513          	mv	a0,s1
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	ee8080e7          	jalr	-280(ra) # 80001c34 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80001d54:	0240006f          	j	80001d78 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80001d58:	00009797          	auipc	a5,0x9
    80001d5c:	35878793          	addi	a5,a5,856 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d60:	00d787b3          	add	a5,a5,a3
    80001d64:	0007b823          	sd	zero,16(a5)
    80001d68:	fd9ff06f          	j	80001d40 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80001d6c:	00000493          	li	s1,0
    80001d70:	0080006f          	j	80001d78 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80001d74:	00000493          	li	s1,0
}
    80001d78:	00048513          	mv	a0,s1
    80001d7c:	01813083          	ld	ra,24(sp)
    80001d80:	01013403          	ld	s0,16(sp)
    80001d84:	00813483          	ld	s1,8(sp)
    80001d88:	02010113          	addi	sp,sp,32
    80001d8c:	00008067          	ret

0000000080001d90 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80001d90:	fe010113          	addi	sp,sp,-32
    80001d94:	00113c23          	sd	ra,24(sp)
    80001d98:	00813823          	sd	s0,16(sp)
    80001d9c:	00913423          	sd	s1,8(sp)
    80001da0:	01213023          	sd	s2,0(sp)
    80001da4:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80001da8:	00000913          	li	s2,0
    80001dac:	0180006f          	j	80001dc4 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80001db0:	00006517          	auipc	a0,0x6
    80001db4:	36850513          	addi	a0,a0,872 # 80008118 <CONSOLE_STATUS+0x108>
    80001db8:	00001097          	auipc	ra,0x1
    80001dbc:	bd4080e7          	jalr	-1068(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001dc0:	0019091b          	addiw	s2,s2,1
    80001dc4:	00c00793          	li	a5,12
    80001dc8:	0727c663          	blt	a5,s2,80001e34 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80001dcc:	00000613          	li	a2,0
    80001dd0:	00a00593          	li	a1,10
    80001dd4:	00090513          	mv	a0,s2
    80001dd8:	00001097          	auipc	ra,0x1
    80001ddc:	bf8080e7          	jalr	-1032(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80001de0:	00006517          	auipc	a0,0x6
    80001de4:	2a050513          	addi	a0,a0,672 # 80008080 <CONSOLE_STATUS+0x70>
    80001de8:	00001097          	auipc	ra,0x1
    80001dec:	ba4080e7          	jalr	-1116(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80001df0:	00391713          	slli	a4,s2,0x3
    80001df4:	00009797          	auipc	a5,0x9
    80001df8:	2bc78793          	addi	a5,a5,700 # 8000b0b0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001dfc:	00e787b3          	add	a5,a5,a4
    80001e00:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80001e04:	fa0486e3          	beqz	s1,80001db0 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    80001e08:	00000613          	li	a2,0
    80001e0c:	01000593          	li	a1,16
    80001e10:	0004851b          	sext.w	a0,s1
    80001e14:	00001097          	auipc	ra,0x1
    80001e18:	bbc080e7          	jalr	-1092(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80001e1c:	00006517          	auipc	a0,0x6
    80001e20:	5ec50513          	addi	a0,a0,1516 # 80008408 <CONSOLE_STATUS+0x3f8>
    80001e24:	00001097          	auipc	ra,0x1
    80001e28:	b68080e7          	jalr	-1176(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80001e2c:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80001e30:	fd5ff06f          	j	80001e04 <_ZN5Buddy9printListEv+0x74>
    80001e34:	01813083          	ld	ra,24(sp)
    80001e38:	01013403          	ld	s0,16(sp)
    80001e3c:	00813483          	ld	s1,8(sp)
    80001e40:	00013903          	ld	s2,0(sp)
    80001e44:	02010113          	addi	sp,sp,32
    80001e48:	00008067          	ret

0000000080001e4c <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80001e4c:	ff010113          	addi	sp,sp,-16
    80001e50:	00113423          	sd	ra,8(sp)
    80001e54:	00813023          	sd	s0,0(sp)
    80001e58:	01010413          	addi	s0,sp,16
    80001e5c:	000105b7          	lui	a1,0x10
    80001e60:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001e64:	00100513          	li	a0,1
    80001e68:	00000097          	auipc	ra,0x0
    80001e6c:	a44080e7          	jalr	-1468(ra) # 800018ac <_Z41__static_initialization_and_destruction_0ii>
    80001e70:	00813083          	ld	ra,8(sp)
    80001e74:	00013403          	ld	s0,0(sp)
    80001e78:	01010113          	addi	sp,sp,16
    80001e7c:	00008067          	ret

0000000080001e80 <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/kernel/system.hpp"

int main() {
    80001e80:	fe010113          	addi	sp,sp,-32
    80001e84:	00113c23          	sd	ra,24(sp)
    80001e88:	00813823          	sd	s0,16(sp)
    80001e8c:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80001e90:	fe840513          	addi	a0,s0,-24
    80001e94:	fffff097          	auipc	ra,0xfffff
    80001e98:	664080e7          	jalr	1636(ra) # 800014f8 <_ZN6SystemC1Ev>

    return 0;
    80001e9c:	00000513          	li	a0,0
    80001ea0:	01813083          	ld	ra,24(sp)
    80001ea4:	01013403          	ld	s0,16(sp)
    80001ea8:	02010113          	addi	sp,sp,32
    80001eac:	00008067          	ret

0000000080001eb0 <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80001eb0:	ff010113          	addi	sp,sp,-16
    80001eb4:	00813423          	sd	s0,8(sp)
    80001eb8:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80001ebc:	00100793          	li	a5,1
    80001ec0:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80001ec4:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80001ec8:	00052a23          	sw	zero,20(a0)
}
    80001ecc:	00813403          	ld	s0,8(sp)
    80001ed0:	01010113          	addi	sp,sp,16
    80001ed4:	00008067          	ret

0000000080001ed8 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80001ed8:	ff010113          	addi	sp,sp,-16
    80001edc:	00813423          	sd	s0,8(sp)
    80001ee0:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80001ee4:	00100793          	li	a5,1
    80001ee8:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80001eec:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80001ef0:	00052a23          	sw	zero,20(a0)
    80001ef4:	00813403          	ld	s0,8(sp)
    80001ef8:	01010113          	addi	sp,sp,16
    80001efc:	00008067          	ret

0000000080001f00 <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80001f00:	ff010113          	addi	sp,sp,-16
    80001f04:	00113423          	sd	ra,8(sp)
    80001f08:	00813023          	sd	s0,0(sp)
    80001f0c:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80001f10:	00001097          	auipc	ra,0x1
    80001f14:	c30080e7          	jalr	-976(ra) # 80002b40 <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    80001f18:	00009797          	auipc	a5,0x9
    80001f1c:	2787b783          	ld	a5,632(a5) # 8000b190 <_ZN3TCB7runningE>
    80001f20:	0187b703          	ld	a4,24(a5)
    80001f24:	0207b503          	ld	a0,32(a5)
    80001f28:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    80001f2c:	00001097          	auipc	ra,0x1
    80001f30:	4d4080e7          	jalr	1236(ra) # 80003400 <_ZN5RiscV14threadExitUtilEv>
}
    80001f34:	00813083          	ld	ra,8(sp)
    80001f38:	00013403          	ld	s0,0(sp)
    80001f3c:	01010113          	addi	sp,sp,16
    80001f40:	00008067          	ret

0000000080001f44 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80001f44:	ff010113          	addi	sp,sp,-16
    80001f48:	00813423          	sd	s0,8(sp)
    80001f4c:	01010413          	addi	s0,sp,16
    80001f50:	04053823          	sd	zero,80(a0)
    80001f54:	04053c23          	sd	zero,88(a0)
    80001f58:	06053023          	sd	zero,96(a0)
    this->body = body;
    80001f5c:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80001f60:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80001f64:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80001f68:	02058a63          	beqz	a1,80001f9c <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80001f6c:	00068793          	mv	a5,a3
    80001f70:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80001f74:	02058863          	beqz	a1,80001fa4 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80001f78:	000017b7          	lui	a5,0x1
    80001f7c:	00f686b3          	add	a3,a3,a5
    80001f80:	00d53023          	sd	a3,0(a0)
    80001f84:	00000797          	auipc	a5,0x0
    80001f88:	f7c78793          	addi	a5,a5,-132 # 80001f00 <_ZN3TCB7wrapperEPv>
    80001f8c:	00f53423          	sd	a5,8(a0)
}
    80001f90:	00813403          	ld	s0,8(sp)
    80001f94:	01010113          	addi	sp,sp,16
    80001f98:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80001f9c:	00000793          	li	a5,0
    80001fa0:	fd1ff06f          	j	80001f70 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80001fa4:	00000693          	li	a3,0
    80001fa8:	fd9ff06f          	j	80001f80 <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080001fac <_ZN3TCB4freeEv>:
void TCB::free(){
    80001fac:	ff010113          	addi	sp,sp,-16
    80001fb0:	00113423          	sd	ra,8(sp)
    80001fb4:	00813023          	sd	s0,0(sp)
    80001fb8:	01010413          	addi	s0,sp,16
    kfree(stack);
    80001fbc:	02853503          	ld	a0,40(a0)
    80001fc0:	00002097          	auipc	ra,0x2
    80001fc4:	4d8080e7          	jalr	1240(ra) # 80004498 <_Z5kfreePKv>
}
    80001fc8:	00813083          	ld	ra,8(sp)
    80001fcc:	00013403          	ld	s0,0(sp)
    80001fd0:	01010113          	addi	sp,sp,16
    80001fd4:	00008067          	ret

0000000080001fd8 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80001fd8:	ff010113          	addi	sp,sp,-16
    80001fdc:	00113423          	sd	ra,8(sp)
    80001fe0:	00813023          	sd	s0,0(sp)
    80001fe4:	01010413          	addi	s0,sp,16
    free();
    80001fe8:	00000097          	auipc	ra,0x0
    80001fec:	fc4080e7          	jalr	-60(ra) # 80001fac <_ZN3TCB4freeEv>
}
    80001ff0:	00813083          	ld	ra,8(sp)
    80001ff4:	00013403          	ld	s0,0(sp)
    80001ff8:	01010113          	addi	sp,sp,16
    80001ffc:	00008067          	ret

0000000080002000 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002000:	fe010113          	addi	sp,sp,-32
    80002004:	00113c23          	sd	ra,24(sp)
    80002008:	00813823          	sd	s0,16(sp)
    8000200c:	00913423          	sd	s1,8(sp)
    80002010:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002014:	00009497          	auipc	s1,0x9
    80002018:	17c4b483          	ld	s1,380(s1) # 8000b190 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    8000201c:	0104a703          	lw	a4,16(s1)
    80002020:	00100793          	li	a5,1
    80002024:	04e7f663          	bgeu	a5,a4,80002070 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002028:	00002097          	auipc	ra,0x2
    8000202c:	174080e7          	jalr	372(ra) # 8000419c <_ZN9Scheduler3getEv>
    80002030:	00009797          	auipc	a5,0x9
    80002034:	16a7b023          	sd	a0,352(a5) # 8000b190 <_ZN3TCB7runningE>
    if(running) {
    80002038:	02050263          	beqz	a0,8000205c <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    8000203c:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002040:	00001097          	auipc	ra,0x1
    80002044:	be4080e7          	jalr	-1052(ra) # 80002c24 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002048:	00009597          	auipc	a1,0x9
    8000204c:	1485b583          	ld	a1,328(a1) # 8000b190 <_ZN3TCB7runningE>
    80002050:	00048513          	mv	a0,s1
    80002054:	fffff097          	auipc	ra,0xfffff
    80002058:	0cc080e7          	jalr	204(ra) # 80001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    8000205c:	01813083          	ld	ra,24(sp)
    80002060:	01013403          	ld	s0,16(sp)
    80002064:	00813483          	ld	s1,8(sp)
    80002068:	02010113          	addi	sp,sp,32
    8000206c:	00008067          	ret
        Scheduler::put(old);
    80002070:	00048513          	mv	a0,s1
    80002074:	00002097          	auipc	ra,0x2
    80002078:	0e0080e7          	jalr	224(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>
    8000207c:	fadff06f          	j	80002028 <_ZN3TCB8dispatchEv+0x28>

0000000080002080 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002080:	ff010113          	addi	sp,sp,-16
    80002084:	00113423          	sd	ra,8(sp)
    80002088:	00813023          	sd	s0,0(sp)
    8000208c:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002090:	00009517          	auipc	a0,0x9
    80002094:	10853503          	ld	a0,264(a0) # 8000b198 <_ZN3TCB8tcbCacheE>
    80002098:	00002097          	auipc	ra,0x2
    8000209c:	308080e7          	jalr	776(ra) # 800043a0 <_Z16kmem_cache_allocP5Cache>
}
    800020a0:	00813083          	ld	ra,8(sp)
    800020a4:	00013403          	ld	s0,0(sp)
    800020a8:	01010113          	addi	sp,sp,16
    800020ac:	00008067          	ret

00000000800020b0 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    800020b0:	fe010113          	addi	sp,sp,-32
    800020b4:	00113c23          	sd	ra,24(sp)
    800020b8:	00813823          	sd	s0,16(sp)
    800020bc:	00913423          	sd	s1,8(sp)
    800020c0:	01213023          	sd	s2,0(sp)
    800020c4:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    800020c8:	00000697          	auipc	a3,0x0
    800020cc:	e1068693          	addi	a3,a3,-496 # 80001ed8 <_ZN3TCB4dtorEPv>
    800020d0:	00000617          	auipc	a2,0x0
    800020d4:	de060613          	addi	a2,a2,-544 # 80001eb0 <_ZN3TCB4ctorEPv>
    800020d8:	07000593          	li	a1,112
    800020dc:	00006517          	auipc	a0,0x6
    800020e0:	fac50513          	addi	a0,a0,-84 # 80008088 <CONSOLE_STATUS+0x78>
    800020e4:	00002097          	auipc	ra,0x2
    800020e8:	294080e7          	jalr	660(ra) # 80004378 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800020ec:	00009797          	auipc	a5,0x9
    800020f0:	0aa7b623          	sd	a0,172(a5) # 8000b198 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    800020f4:	07000513          	li	a0,112
    800020f8:	00000097          	auipc	ra,0x0
    800020fc:	f88080e7          	jalr	-120(ra) # 80002080 <_ZN3TCBnwEm>
    80002100:	00050493          	mv	s1,a0
    80002104:	00050e63          	beqz	a0,80002120 <_ZN3TCB10initializeEv+0x70>
    80002108:	00200713          	li	a4,2
    8000210c:	00000693          	li	a3,0
    80002110:	00000613          	li	a2,0
    80002114:	00000593          	li	a1,0
    80002118:	00000097          	auipc	ra,0x0
    8000211c:	e2c080e7          	jalr	-468(ra) # 80001f44 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002120:	00009797          	auipc	a5,0x9
    80002124:	0697b823          	sd	s1,112(a5) # 8000b190 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    80002128:	00100793          	li	a5,1
    8000212c:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80002130:	00001537          	lui	a0,0x1
    80002134:	00002097          	auipc	ra,0x2
    80002138:	33c080e7          	jalr	828(ra) # 80004470 <_Z7kmallocm>
    8000213c:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002140:	07000513          	li	a0,112
    80002144:	00000097          	auipc	ra,0x0
    80002148:	f3c080e7          	jalr	-196(ra) # 80002080 <_ZN3TCBnwEm>
    8000214c:	00050493          	mv	s1,a0
    80002150:	02050063          	beqz	a0,80002170 <_ZN3TCB10initializeEv+0xc0>
    80002154:	00200713          	li	a4,2
    80002158:	00090693          	mv	a3,s2
    8000215c:	00000613          	li	a2,0
    80002160:	00009597          	auipc	a1,0x9
    80002164:	e485b583          	ld	a1,-440(a1) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002168:	00000097          	auipc	ra,0x0
    8000216c:	ddc080e7          	jalr	-548(ra) # 80001f44 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002170:	00009797          	auipc	a5,0x9
    80002174:	0297b823          	sd	s1,48(a5) # 8000b1a0 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    80002178:	00100793          	li	a5,1
    8000217c:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    80002180:	00048513          	mv	a0,s1
    80002184:	00002097          	auipc	ra,0x2
    80002188:	fd0080e7          	jalr	-48(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>
}
    8000218c:	01813083          	ld	ra,24(sp)
    80002190:	01013403          	ld	s0,16(sp)
    80002194:	00813483          	ld	s1,8(sp)
    80002198:	00013903          	ld	s2,0(sp)
    8000219c:	02010113          	addi	sp,sp,32
    800021a0:	00008067          	ret

00000000800021a4 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    800021a4:	ff010113          	addi	sp,sp,-16
    800021a8:	00113423          	sd	ra,8(sp)
    800021ac:	00813023          	sd	s0,0(sp)
    800021b0:	01010413          	addi	s0,sp,16
    800021b4:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    800021b8:	00009517          	auipc	a0,0x9
    800021bc:	fe053503          	ld	a0,-32(a0) # 8000b198 <_ZN3TCB8tcbCacheE>
    800021c0:	00002097          	auipc	ra,0x2
    800021c4:	208080e7          	jalr	520(ra) # 800043c8 <_Z15kmem_cache_freeP5CachePv>
}
    800021c8:	00813083          	ld	ra,8(sp)
    800021cc:	00013403          	ld	s0,0(sp)
    800021d0:	01010113          	addi	sp,sp,16
    800021d4:	00008067          	ret

00000000800021d8 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    800021d8:	ff010113          	addi	sp,sp,-16
    800021dc:	00813423          	sd	s0,8(sp)
    800021e0:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    800021e4:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    800021e8:	05100513          	li	a0,81
    asm("ecall");
    800021ec:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    800021f0:	00050513          	mv	a0,a0
}
    800021f4:	0005051b          	sext.w	a0,a0
    800021f8:	00813403          	ld	s0,8(sp)
    800021fc:	01010113          	addi	sp,sp,16
    80002200:	00008067          	ret

0000000080002204 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80002204:	ff010113          	addi	sp,sp,-16
    80002208:	00813423          	sd	s0,8(sp)
    8000220c:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002210:	00009797          	auipc	a5,0x9
    80002214:	d707b783          	ld	a5,-656(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002218:	0007b783          	ld	a5,0(a5)
    8000221c:	00c7d793          	srli	a5,a5,0xc
    80002220:	00278793          	addi	a5,a5,2
    80002224:	00c79793          	slli	a5,a5,0xc
    80002228:	01000737          	lui	a4,0x1000
    8000222c:	00e787b3          	add	a5,a5,a4
    80002230:	00009717          	auipc	a4,0x9
    80002234:	f9070713          	addi	a4,a4,-112 # 8000b1c0 <_ZN15MemoryAllocator11freeMemTailE>
    80002238:	00f73023          	sd	a5,0(a4)
    8000223c:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002240:	0007b823          	sd	zero,16(a5)
    80002244:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80002248:	00073823          	sd	zero,16(a4)
    8000224c:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    80002250:	00009697          	auipc	a3,0x9
    80002254:	de86b683          	ld	a3,-536(a3) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80002258:	0006b683          	ld	a3,0(a3)
    8000225c:	40f686b3          	sub	a3,a3,a5
    80002260:	fe868693          	addi	a3,a3,-24
    80002264:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80002268:	00873783          	ld	a5,8(a4)
    8000226c:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80002270:	00100793          	li	a5,1
    80002274:	02f70023          	sb	a5,32(a4)
}
    80002278:	00813403          	ld	s0,8(sp)
    8000227c:	01010113          	addi	sp,sp,16
    80002280:	00008067          	ret

0000000080002284 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002284:	ff010113          	addi	sp,sp,-16
    80002288:	00813423          	sd	s0,8(sp)
    8000228c:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    80002290:	14050663          	beqz	a0,800023dc <_ZN15MemoryAllocator7kmallocEm+0x158>
    80002294:	00050793          	mv	a5,a0
    80002298:	00009517          	auipc	a0,0x9
    8000229c:	f3053503          	ld	a0,-208(a0) # 8000b1c8 <_ZN15MemoryAllocator11freeMemHeadE>
    800022a0:	0a050e63          	beqz	a0,8000235c <_ZN15MemoryAllocator7kmallocEm+0xd8>
    800022a4:	00053703          	ld	a4,0(a0)
    800022a8:	12f76e63          	bltu	a4,a5,800023e4 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    800022ac:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    800022b0:	00000613          	li	a2,0
    800022b4:	00c0006f          	j	800022c0 <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    800022b8:	00050613          	mv	a2,a0
    800022bc:	01053503          	ld	a0,16(a0)
    800022c0:	00050863          	beqz	a0,800022d0 <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    800022c4:	00053683          	ld	a3,0(a0)
    800022c8:	01878713          	addi	a4,a5,24
    800022cc:	fee6e6e3          	bltu	a3,a4,800022b8 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    800022d0:	08050663          	beqz	a0,8000235c <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    800022d4:	00053683          	ld	a3,0(a0)
    800022d8:	01868713          	addi	a4,a3,24
    800022dc:	00e50733          	add	a4,a0,a4
    800022e0:	00009597          	auipc	a1,0x9
    800022e4:	d585b583          	ld	a1,-680(a1) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xd0>
    800022e8:	0005b583          	ld	a1,0(a1)
    800022ec:	00b76463          	bltu	a4,a1,800022f4 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    800022f0:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    800022f4:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    800022f8:	05700593          	li	a1,87
    800022fc:	08d5f063          	bgeu	a1,a3,8000237c <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    80002300:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002304:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002308:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    8000230c:	01053583          	ld	a1,16(a0)
    80002310:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002314:	00853583          	ld	a1,8(a0)
    80002318:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    8000231c:	fe868693          	addi	a3,a3,-24
    80002320:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80002324:	04060263          	beqz	a2,80002368 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80002328:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    8000232c:	00009797          	auipc	a5,0x9
    80002330:	eac7b783          	ld	a5,-340(a5) # 8000b1d8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002334:	06078463          	beqz	a5,8000239c <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80002338:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    8000233c:	08070063          	beqz	a4,800023bc <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    80002340:	00873783          	ld	a5,8(a4)
    80002344:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80002348:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    8000234c:	00873783          	ld	a5,8(a4)
    80002350:	06078063          	beqz	a5,800023b0 <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    80002354:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80002358:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    8000235c:	00813403          	ld	s0,8(sp)
    80002360:	01010113          	addi	sp,sp,16
    80002364:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80002368:	00009697          	auipc	a3,0x9
    8000236c:	e5868693          	addi	a3,a3,-424 # 8000b1c0 <_ZN15MemoryAllocator11freeMemTailE>
    80002370:	00f6b023          	sd	a5,0(a3)
    80002374:	00f6b423          	sd	a5,8(a3)
    80002378:	fb5ff06f          	j	8000232c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    8000237c:	00060863          	beqz	a2,8000238c <_ZN15MemoryAllocator7kmallocEm+0x108>
    80002380:	01053783          	ld	a5,16(a0)
    80002384:	00f63823          	sd	a5,16(a2)
    80002388:	fa5ff06f          	j	8000232c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    8000238c:	01053783          	ld	a5,16(a0)
    80002390:	00009697          	auipc	a3,0x9
    80002394:	e2f6bc23          	sd	a5,-456(a3) # 8000b1c8 <_ZN15MemoryAllocator11freeMemHeadE>
    80002398:	f95ff06f          	j	8000232c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    8000239c:	00009797          	auipc	a5,0x9
    800023a0:	e2478793          	addi	a5,a5,-476 # 8000b1c0 <_ZN15MemoryAllocator11freeMemTailE>
    800023a4:	00a7b823          	sd	a0,16(a5)
    800023a8:	00a7bc23          	sd	a0,24(a5)
    800023ac:	fadff06f          	j	80002358 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    800023b0:	00009797          	auipc	a5,0x9
    800023b4:	e2a7b423          	sd	a0,-472(a5) # 8000b1d8 <_ZN15MemoryAllocator12allocMemHeadE>
    800023b8:	fa1ff06f          	j	80002358 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    800023bc:	00009797          	auipc	a5,0x9
    800023c0:	e0478793          	addi	a5,a5,-508 # 8000b1c0 <_ZN15MemoryAllocator11freeMemTailE>
    800023c4:	0107b703          	ld	a4,16(a5)
    800023c8:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    800023cc:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    800023d0:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    800023d4:	00a7b823          	sd	a0,16(a5)
    800023d8:	f81ff06f          	j	80002358 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    800023dc:	00000513          	li	a0,0
    800023e0:	f7dff06f          	j	8000235c <_ZN15MemoryAllocator7kmallocEm+0xd8>
    800023e4:	00000513          	li	a0,0
    800023e8:	f75ff06f          	j	8000235c <_ZN15MemoryAllocator7kmallocEm+0xd8>

00000000800023ec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    800023ec:	ff010113          	addi	sp,sp,-16
    800023f0:	00813423          	sd	s0,8(sp)
    800023f4:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    800023f8:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800023fc:	00000713          	li	a4,0
    80002400:	00078a63          	beqz	a5,80002414 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80002404:	00a7f863          	bgeu	a5,a0,80002414 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002408:	00078713          	mv	a4,a5
    8000240c:	0107b783          	ld	a5,16(a5)
    80002410:	ff1ff06f          	j	80002400 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80002414:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80002418:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    8000241c:	00078463          	beqz	a5,80002424 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80002420:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80002424:	02070263          	beqz	a4,80002448 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80002428:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    8000242c:	0005b703          	ld	a4,0(a1)
    80002430:	00009797          	auipc	a5,0x9
    80002434:	d987b783          	ld	a5,-616(a5) # 8000b1c8 <_ZN15MemoryAllocator11freeMemHeadE>
    80002438:	00f70c63          	beq	a4,a5,80002450 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    8000243c:	00813403          	ld	s0,8(sp)
    80002440:	01010113          	addi	sp,sp,16
    80002444:	00008067          	ret
        *head = blk;
    80002448:	00a5b023          	sd	a0,0(a1)
    8000244c:	fe1ff06f          	j	8000242c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002450:	01053783          	ld	a5,16(a0)
    80002454:	00078a63          	beqz	a5,80002468 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80002458:	00053683          	ld	a3,0(a0)
    8000245c:	00d50733          	add	a4,a0,a3
    80002460:	01870713          	addi	a4,a4,24
    80002464:	02f70e63          	beq	a4,a5,800024a0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80002468:	00853783          	ld	a5,8(a0)
    8000246c:	fc0788e3          	beqz	a5,8000243c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80002470:	0007b683          	ld	a3,0(a5)
    80002474:	00d78733          	add	a4,a5,a3
    80002478:	01870713          	addi	a4,a4,24
    8000247c:	fca710e3          	bne	a4,a0,8000243c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80002480:	00053703          	ld	a4,0(a0)
    80002484:	00e68733          	add	a4,a3,a4
    80002488:	01870713          	addi	a4,a4,24
    8000248c:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80002490:	00853783          	ld	a5,8(a0)
    80002494:	01053703          	ld	a4,16(a0)
    80002498:	00e7b823          	sd	a4,16(a5)
}
    8000249c:	fa1ff06f          	j	8000243c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    800024a0:	0007b703          	ld	a4,0(a5)
    800024a4:	00e68733          	add	a4,a3,a4
    800024a8:	01870713          	addi	a4,a4,24
    800024ac:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    800024b0:	0107b783          	ld	a5,16(a5)
    800024b4:	00f53823          	sd	a5,16(a0)
    800024b8:	fb1ff06f          	j	80002468 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

00000000800024bc <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    800024bc:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    800024c0:	00009697          	auipc	a3,0x9
    800024c4:	d186b683          	ld	a3,-744(a3) # 8000b1d8 <_ZN15MemoryAllocator12allocMemHeadE>
    800024c8:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    800024cc:	00050a63          	beqz	a0,800024e0 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    800024d0:	fe870793          	addi	a5,a4,-24
    800024d4:	00a78663          	beq	a5,a0,800024e0 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    800024d8:	01053503          	ld	a0,16(a0)
    800024dc:	ff1ff06f          	j	800024cc <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    800024e0:	08050463          	beqz	a0,80002568 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    800024e4:	ff010113          	addi	sp,sp,-16
    800024e8:	00113423          	sd	ra,8(sp)
    800024ec:	00813023          	sd	s0,0(sp)
    800024f0:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    800024f4:	00009797          	auipc	a5,0x9
    800024f8:	cdc7b783          	ld	a5,-804(a5) # 8000b1d0 <_ZN15MemoryAllocator12allocMemTailE>
    800024fc:	04a78663          	beq	a5,a0,80002548 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80002500:	04d50c63          	beq	a0,a3,80002558 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80002504:	01053783          	ld	a5,16(a0)
    80002508:	00078663          	beqz	a5,80002514 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    8000250c:	00853703          	ld	a4,8(a0)
    80002510:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80002514:	00853783          	ld	a5,8(a0)
    80002518:	00078663          	beqz	a5,80002524 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    8000251c:	01053703          	ld	a4,16(a0)
    80002520:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80002524:	00009597          	auipc	a1,0x9
    80002528:	ca458593          	addi	a1,a1,-860 # 8000b1c8 <_ZN15MemoryAllocator11freeMemHeadE>
    8000252c:	00000097          	auipc	ra,0x0
    80002530:	ec0080e7          	jalr	-320(ra) # 800023ec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80002534:	00000513          	li	a0,0
}
    80002538:	00813083          	ld	ra,8(sp)
    8000253c:	00013403          	ld	s0,0(sp)
    80002540:	01010113          	addi	sp,sp,16
    80002544:	00008067          	ret
            allocMemTail = blk->prev;
    80002548:	00853783          	ld	a5,8(a0)
    8000254c:	00009717          	auipc	a4,0x9
    80002550:	c8f73223          	sd	a5,-892(a4) # 8000b1d0 <_ZN15MemoryAllocator12allocMemTailE>
    80002554:	fadff06f          	j	80002500 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80002558:	01053783          	ld	a5,16(a0)
    8000255c:	00009717          	auipc	a4,0x9
    80002560:	c6f73e23          	sd	a5,-900(a4) # 8000b1d8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002564:	fa1ff06f          	j	80002504 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80002568:	fff00513          	li	a0,-1
}
    8000256c:	00008067          	ret

0000000080002570 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80002570:	fe010113          	addi	sp,sp,-32
    80002574:	00113c23          	sd	ra,24(sp)
    80002578:	00813823          	sd	s0,16(sp)
    8000257c:	00913423          	sd	s1,8(sp)
    80002580:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80002584:	00009497          	auipc	s1,0x9
    80002588:	c544b483          	ld	s1,-940(s1) # 8000b1d8 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    8000258c:	00006517          	auipc	a0,0x6
    80002590:	b0c50513          	addi	a0,a0,-1268 # 80008098 <CONSOLE_STATUS+0x88>
    80002594:	0000c097          	auipc	ra,0xc
    80002598:	6d0080e7          	jalr	1744(ra) # 8000ec64 <_Z11printStringPKc>
    while(iter!=nullptr){
    8000259c:	04048663          	beqz	s1,800025e8 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800025a0:	00000613          	li	a2,0
    800025a4:	00a00593          	li	a1,10
    800025a8:	0004851b          	sext.w	a0,s1
    800025ac:	0000d097          	auipc	ra,0xd
    800025b0:	850080e7          	jalr	-1968(ra) # 8000edfc <_Z8printIntiii>
        putc(' ');
    800025b4:	02000513          	li	a0,32
    800025b8:	0000b097          	auipc	ra,0xb
    800025bc:	d74080e7          	jalr	-652(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    800025c0:	00000613          	li	a2,0
    800025c4:	00a00593          	li	a1,10
    800025c8:	0004a503          	lw	a0,0(s1)
    800025cc:	0000d097          	auipc	ra,0xd
    800025d0:	830080e7          	jalr	-2000(ra) # 8000edfc <_Z8printIntiii>
        putc('\n');
    800025d4:	00a00513          	li	a0,10
    800025d8:	0000b097          	auipc	ra,0xb
    800025dc:	d54080e7          	jalr	-684(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    800025e0:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800025e4:	fb9ff06f          	j	8000259c <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    800025e8:	00006517          	auipc	a0,0x6
    800025ec:	ad050513          	addi	a0,a0,-1328 # 800080b8 <CONSOLE_STATUS+0xa8>
    800025f0:	0000c097          	auipc	ra,0xc
    800025f4:	674080e7          	jalr	1652(ra) # 8000ec64 <_Z11printStringPKc>
    iter = freeMemHead;
    800025f8:	00009497          	auipc	s1,0x9
    800025fc:	bd04b483          	ld	s1,-1072(s1) # 8000b1c8 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80002600:	04048663          	beqz	s1,8000264c <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80002604:	00000613          	li	a2,0
    80002608:	00a00593          	li	a1,10
    8000260c:	0004851b          	sext.w	a0,s1
    80002610:	0000c097          	auipc	ra,0xc
    80002614:	7ec080e7          	jalr	2028(ra) # 8000edfc <_Z8printIntiii>
        putc(' ');
    80002618:	02000513          	li	a0,32
    8000261c:	0000b097          	auipc	ra,0xb
    80002620:	d10080e7          	jalr	-752(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    80002624:	00000613          	li	a2,0
    80002628:	00a00593          	li	a1,10
    8000262c:	0004a503          	lw	a0,0(s1)
    80002630:	0000c097          	auipc	ra,0xc
    80002634:	7cc080e7          	jalr	1996(ra) # 8000edfc <_Z8printIntiii>
        putc('\n');
    80002638:	00a00513          	li	a0,10
    8000263c:	0000b097          	auipc	ra,0xb
    80002640:	cf0080e7          	jalr	-784(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    80002644:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002648:	fb9ff06f          	j	80002600 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    8000264c:	00006517          	auipc	a0,0x6
    80002650:	a8c50513          	addi	a0,a0,-1396 # 800080d8 <CONSOLE_STATUS+0xc8>
    80002654:	0000c097          	auipc	ra,0xc
    80002658:	610080e7          	jalr	1552(ra) # 8000ec64 <_Z11printStringPKc>
}
    8000265c:	01813083          	ld	ra,24(sp)
    80002660:	01013403          	ld	s0,16(sp)
    80002664:	00813483          	ld	s1,8(sp)
    80002668:	02010113          	addi	sp,sp,32
    8000266c:	00008067          	ret

0000000080002670 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80002670:	ff010113          	addi	sp,sp,-16
    80002674:	00813423          	sd	s0,8(sp)
    80002678:	01010413          	addi	s0,sp,16
    8000267c:	00050813          	mv	a6,a0
    80002680:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80002684:	00000793          	li	a5,0
    80002688:	00c7fe63          	bgeu	a5,a2,800026a4 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    8000268c:	00f50733          	add	a4,a0,a5
    80002690:	00f806b3          	add	a3,a6,a5
    80002694:	0006c683          	lbu	a3,0(a3)
    80002698:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    8000269c:	00178793          	addi	a5,a5,1
    800026a0:	fe9ff06f          	j	80002688 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800026a4:	00813403          	ld	s0,8(sp)
    800026a8:	01010113          	addi	sp,sp,16
    800026ac:	00008067          	ret

00000000800026b0 <_ZN11ConsoleUtil10initializeEv>:
//char ConsoleUtil::inputBuffer[8192];
//char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    800026b0:	fe010113          	addi	sp,sp,-32
    800026b4:	00113c23          	sd	ra,24(sp)
    800026b8:	00813823          	sd	s0,16(sp)
    800026bc:	00913423          	sd	s1,8(sp)
    800026c0:	01213023          	sd	s2,0(sp)
    800026c4:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    800026c8:	01800513          	li	a0,24
    800026cc:	fffff097          	auipc	ra,0xfffff
    800026d0:	150080e7          	jalr	336(ra) # 8000181c <_ZN3SCBnwEm>
    800026d4:	00050493          	mv	s1,a0
    800026d8:	00050863          	beqz	a0,800026e8 <_ZN11ConsoleUtil10initializeEv+0x38>
    800026dc:	00000593          	li	a1,0
    800026e0:	fffff097          	auipc	ra,0xfffff
    800026e4:	f88080e7          	jalr	-120(ra) # 80001668 <_ZN3SCBC1Em>
    800026e8:	00009797          	auipc	a5,0x9
    800026ec:	b097b023          	sd	s1,-1280(a5) # 8000b1e8 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    800026f0:	01800513          	li	a0,24
    800026f4:	fffff097          	auipc	ra,0xfffff
    800026f8:	128080e7          	jalr	296(ra) # 8000181c <_ZN3SCBnwEm>
    800026fc:	00050493          	mv	s1,a0
    80002700:	00050863          	beqz	a0,80002710 <_ZN11ConsoleUtil10initializeEv+0x60>
    80002704:	00000593          	li	a1,0
    80002708:	fffff097          	auipc	ra,0xfffff
    8000270c:	f60080e7          	jalr	-160(ra) # 80001668 <_ZN3SCBC1Em>
    80002710:	00009917          	auipc	s2,0x9
    80002714:	ad890913          	addi	s2,s2,-1320 # 8000b1e8 <_ZN11ConsoleUtil8inputSemE>
    80002718:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    8000271c:	00008497          	auipc	s1,0x8
    80002720:	7dc48493          	addi	s1,s1,2012 # 8000aef8 <_ZN11ConsoleUtil10bufferSizeE>
    80002724:	0004b503          	ld	a0,0(s1)
    80002728:	00002097          	auipc	ra,0x2
    8000272c:	d48080e7          	jalr	-696(ra) # 80004470 <_Z7kmallocm>
    80002730:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80002734:	0004b503          	ld	a0,0(s1)
    80002738:	00002097          	auipc	ra,0x2
    8000273c:	d38080e7          	jalr	-712(ra) # 80004470 <_Z7kmallocm>
    80002740:	00a93c23          	sd	a0,24(s2)
}
    80002744:	01813083          	ld	ra,24(sp)
    80002748:	01013403          	ld	s0,16(sp)
    8000274c:	00813483          	ld	s1,8(sp)
    80002750:	00013903          	ld	s2,0(sp)
    80002754:	02010113          	addi	sp,sp,32
    80002758:	00008067          	ret
    8000275c:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80002760:	00048513          	mv	a0,s1
    80002764:	fffff097          	auipc	ra,0xfffff
    80002768:	0e8080e7          	jalr	232(ra) # 8000184c <_ZN3SCBdlEPv>
    8000276c:	00090513          	mv	a0,s2
    80002770:	0000a097          	auipc	ra,0xa
    80002774:	c48080e7          	jalr	-952(ra) # 8000c3b8 <_Unwind_Resume>
    80002778:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    8000277c:	00048513          	mv	a0,s1
    80002780:	fffff097          	auipc	ra,0xfffff
    80002784:	0cc080e7          	jalr	204(ra) # 8000184c <_ZN3SCBdlEPv>
    80002788:	00090513          	mv	a0,s2
    8000278c:	0000a097          	auipc	ra,0xa
    80002790:	c2c080e7          	jalr	-980(ra) # 8000c3b8 <_Unwind_Resume>

0000000080002794 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80002794:	00009717          	auipc	a4,0x9
    80002798:	a5470713          	addi	a4,a4,-1452 # 8000b1e8 <_ZN11ConsoleUtil8inputSemE>
    8000279c:	02073683          	ld	a3,32(a4)
    800027a0:	00168793          	addi	a5,a3,1
    800027a4:	00008617          	auipc	a2,0x8
    800027a8:	75463603          	ld	a2,1876(a2) # 8000aef8 <_ZN11ConsoleUtil10bufferSizeE>
    800027ac:	02c7f7b3          	remu	a5,a5,a2
    800027b0:	02873703          	ld	a4,40(a4)
    800027b4:	04e78e63          	beq	a5,a4,80002810 <_ZN11ConsoleUtil8putInputEc+0x7c>
void ConsoleUtil::putInput(char c) {
    800027b8:	ff010113          	addi	sp,sp,-16
    800027bc:	00113423          	sd	ra,8(sp)
    800027c0:	00813023          	sd	s0,0(sp)
    800027c4:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    800027c8:	00009717          	auipc	a4,0x9
    800027cc:	a2070713          	addi	a4,a4,-1504 # 8000b1e8 <_ZN11ConsoleUtil8inputSemE>
    800027d0:	01073783          	ld	a5,16(a4)
    800027d4:	00d786b3          	add	a3,a5,a3
    800027d8:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    800027dc:	02073783          	ld	a5,32(a4)
    800027e0:	00178793          	addi	a5,a5,1
    800027e4:	00008697          	auipc	a3,0x8
    800027e8:	7146b683          	ld	a3,1812(a3) # 8000aef8 <_ZN11ConsoleUtil10bufferSizeE>
    800027ec:	02d7f7b3          	remu	a5,a5,a3
    800027f0:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    800027f4:	00073503          	ld	a0,0(a4)
    800027f8:	fffff097          	auipc	ra,0xfffff
    800027fc:	fe8080e7          	jalr	-24(ra) # 800017e0 <_ZN3SCB6signalEv>
}
    80002800:	00813083          	ld	ra,8(sp)
    80002804:	00013403          	ld	s0,0(sp)
    80002808:	01010113          	addi	sp,sp,16
    8000280c:	00008067          	ret
    80002810:	00008067          	ret

0000000080002814 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80002814:	fe010113          	addi	sp,sp,-32
    80002818:	00113c23          	sd	ra,24(sp)
    8000281c:	00813823          	sd	s0,16(sp)
    80002820:	00913423          	sd	s1,8(sp)
    80002824:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80002828:	00009497          	auipc	s1,0x9
    8000282c:	9c048493          	addi	s1,s1,-1600 # 8000b1e8 <_ZN11ConsoleUtil8inputSemE>
    80002830:	0004b503          	ld	a0,0(s1)
    80002834:	fffff097          	auipc	ra,0xfffff
    80002838:	f5c080e7          	jalr	-164(ra) # 80001790 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    8000283c:	0284b783          	ld	a5,40(s1)
    80002840:	0204b703          	ld	a4,32(s1)
    80002844:	02e78c63          	beq	a5,a4,8000287c <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    80002848:	0104b703          	ld	a4,16(s1)
    8000284c:	00f70733          	add	a4,a4,a5
    80002850:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80002854:	00178793          	addi	a5,a5,1
    80002858:	00008717          	auipc	a4,0x8
    8000285c:	6a073703          	ld	a4,1696(a4) # 8000aef8 <_ZN11ConsoleUtil10bufferSizeE>
    80002860:	02e7f7b3          	remu	a5,a5,a4
    80002864:	02f4b423          	sd	a5,40(s1)

    return c;
}
    80002868:	01813083          	ld	ra,24(sp)
    8000286c:	01013403          	ld	s0,16(sp)
    80002870:	00813483          	ld	s1,8(sp)
    80002874:	02010113          	addi	sp,sp,32
    80002878:	00008067          	ret
        return -1;
    8000287c:	0ff00513          	li	a0,255
    80002880:	fe9ff06f          	j	80002868 <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080002884 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80002884:	00009797          	auipc	a5,0x9
    80002888:	96478793          	addi	a5,a5,-1692 # 8000b1e8 <_ZN11ConsoleUtil8inputSemE>
    8000288c:	0307b703          	ld	a4,48(a5)
    80002890:	00170713          	addi	a4,a4,1
    80002894:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80002898:	0387b683          	ld	a3,56(a5)
    8000289c:	00168713          	addi	a4,a3,1
    800028a0:	00008617          	auipc	a2,0x8
    800028a4:	65863603          	ld	a2,1624(a2) # 8000aef8 <_ZN11ConsoleUtil10bufferSizeE>
    800028a8:	02c77733          	remu	a4,a4,a2
    800028ac:	0407b783          	ld	a5,64(a5)
    800028b0:	06f70463          	beq	a4,a5,80002918 <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    800028b4:	ff010113          	addi	sp,sp,-16
    800028b8:	00113423          	sd	ra,8(sp)
    800028bc:	00813023          	sd	s0,0(sp)
    800028c0:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    800028c4:	00009797          	auipc	a5,0x9
    800028c8:	92478793          	addi	a5,a5,-1756 # 8000b1e8 <_ZN11ConsoleUtil8inputSemE>
    800028cc:	0187b703          	ld	a4,24(a5)
    800028d0:	00d706b3          	add	a3,a4,a3
    800028d4:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    800028d8:	0387b703          	ld	a4,56(a5)
    800028dc:	00170713          	addi	a4,a4,1
    800028e0:	00008697          	auipc	a3,0x8
    800028e4:	6186b683          	ld	a3,1560(a3) # 8000aef8 <_ZN11ConsoleUtil10bufferSizeE>
    800028e8:	02d77733          	remu	a4,a4,a3
    800028ec:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    800028f0:	0307b703          	ld	a4,48(a5)
    800028f4:	fff70713          	addi	a4,a4,-1
    800028f8:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    800028fc:	0087b503          	ld	a0,8(a5)
    80002900:	fffff097          	auipc	ra,0xfffff
    80002904:	ee0080e7          	jalr	-288(ra) # 800017e0 <_ZN3SCB6signalEv>
}
    80002908:	00813083          	ld	ra,8(sp)
    8000290c:	00013403          	ld	s0,0(sp)
    80002910:	01010113          	addi	sp,sp,16
    80002914:	00008067          	ret
    80002918:	00008067          	ret

000000008000291c <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    8000291c:	fe010113          	addi	sp,sp,-32
    80002920:	00113c23          	sd	ra,24(sp)
    80002924:	00813823          	sd	s0,16(sp)
    80002928:	00913423          	sd	s1,8(sp)
    8000292c:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80002930:	00009497          	auipc	s1,0x9
    80002934:	8b848493          	addi	s1,s1,-1864 # 8000b1e8 <_ZN11ConsoleUtil8inputSemE>
    80002938:	0084b503          	ld	a0,8(s1)
    8000293c:	fffff097          	auipc	ra,0xfffff
    80002940:	e54080e7          	jalr	-428(ra) # 80001790 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80002944:	0404b783          	ld	a5,64(s1)
    80002948:	0384b703          	ld	a4,56(s1)
    8000294c:	02e78c63          	beq	a5,a4,80002984 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    80002950:	0184b703          	ld	a4,24(s1)
    80002954:	00f70733          	add	a4,a4,a5
    80002958:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    8000295c:	00178793          	addi	a5,a5,1
    80002960:	00008717          	auipc	a4,0x8
    80002964:	59873703          	ld	a4,1432(a4) # 8000aef8 <_ZN11ConsoleUtil10bufferSizeE>
    80002968:	02e7f7b3          	remu	a5,a5,a4
    8000296c:	04f4b023          	sd	a5,64(s1)

    return c;
}
    80002970:	01813083          	ld	ra,24(sp)
    80002974:	01013403          	ld	s0,16(sp)
    80002978:	00813483          	ld	s1,8(sp)
    8000297c:	02010113          	addi	sp,sp,32
    80002980:	00008067          	ret
        return -1;
    80002984:	0ff00513          	li	a0,255
    80002988:	fe9ff06f          	j	80002970 <_ZN11ConsoleUtil9getOutputEv+0x54>

000000008000298c <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    8000298c:	fe010113          	addi	sp,sp,-32
    80002990:	00113c23          	sd	ra,24(sp)
    80002994:	00813823          	sd	s0,16(sp)
    80002998:	00913423          	sd	s1,8(sp)
    8000299c:	02010413          	addi	s0,sp,32
    800029a0:	00050493          	mv	s1,a0
    while (*string != '\0')
    800029a4:	0004c503          	lbu	a0,0(s1)
    800029a8:	00050a63          	beqz	a0,800029bc <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    800029ac:	00000097          	auipc	ra,0x0
    800029b0:	ed8080e7          	jalr	-296(ra) # 80002884 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    800029b4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800029b8:	fedff06f          	j	800029a4 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    800029bc:	01813083          	ld	ra,24(sp)
    800029c0:	01013403          	ld	s0,16(sp)
    800029c4:	00813483          	ld	s1,8(sp)
    800029c8:	02010113          	addi	sp,sp,32
    800029cc:	00008067          	ret

00000000800029d0 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800029d0:	fb010113          	addi	sp,sp,-80
    800029d4:	04113423          	sd	ra,72(sp)
    800029d8:	04813023          	sd	s0,64(sp)
    800029dc:	02913c23          	sd	s1,56(sp)
    800029e0:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800029e4:	00005797          	auipc	a5,0x5
    800029e8:	73c78793          	addi	a5,a5,1852 # 80008120 <CONSOLE_STATUS+0x110>
    800029ec:	0007b703          	ld	a4,0(a5)
    800029f0:	fce43423          	sd	a4,-56(s0)
    800029f4:	0087b703          	ld	a4,8(a5)
    800029f8:	fce43823          	sd	a4,-48(s0)
    800029fc:	0107c783          	lbu	a5,16(a5)
    80002a00:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002a04:	00060463          	beqz	a2,80002a0c <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80002a08:	08054263          	bltz	a0,80002a8c <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002a0c:	0005051b          	sext.w	a0,a0
    neg = 0;
    80002a10:	00000813          	li	a6,0
    }

    i = 0;
    80002a14:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002a18:	0005871b          	sext.w	a4,a1
    80002a1c:	02b577bb          	remuw	a5,a0,a1
    80002a20:	00048693          	mv	a3,s1
    80002a24:	0014849b          	addiw	s1,s1,1
    80002a28:	02079793          	slli	a5,a5,0x20
    80002a2c:	0207d793          	srli	a5,a5,0x20
    80002a30:	fe040613          	addi	a2,s0,-32
    80002a34:	00f607b3          	add	a5,a2,a5
    80002a38:	fe87c603          	lbu	a2,-24(a5)
    80002a3c:	fe040793          	addi	a5,s0,-32
    80002a40:	00d787b3          	add	a5,a5,a3
    80002a44:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80002a48:	0005061b          	sext.w	a2,a0
    80002a4c:	02b5553b          	divuw	a0,a0,a1
    80002a50:	fce674e3          	bgeu	a2,a4,80002a18 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80002a54:	00080c63          	beqz	a6,80002a6c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80002a58:	fe040793          	addi	a5,s0,-32
    80002a5c:	009784b3          	add	s1,a5,s1
    80002a60:	02d00793          	li	a5,45
    80002a64:	fcf48c23          	sb	a5,-40(s1)
    80002a68:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80002a6c:	fff4849b          	addiw	s1,s1,-1
    80002a70:	0204c463          	bltz	s1,80002a98 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80002a74:	fe040793          	addi	a5,s0,-32
    80002a78:	009787b3          	add	a5,a5,s1
    80002a7c:	fd87c503          	lbu	a0,-40(a5)
    80002a80:	00000097          	auipc	ra,0x0
    80002a84:	e04080e7          	jalr	-508(ra) # 80002884 <_ZN11ConsoleUtil9putOutputEc>
    80002a88:	fe5ff06f          	j	80002a6c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80002a8c:	40a0053b          	negw	a0,a0
        neg = 1;
    80002a90:	00100813          	li	a6,1
        x = -xx;
    80002a94:	f81ff06f          	j	80002a14 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80002a98:	04813083          	ld	ra,72(sp)
    80002a9c:	04013403          	ld	s0,64(sp)
    80002aa0:	03813483          	ld	s1,56(sp)
    80002aa4:	05010113          	addi	sp,sp,80
    80002aa8:	00008067          	ret

0000000080002aac <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    80002aac:	fd010113          	addi	sp,sp,-48
    80002ab0:	02113423          	sd	ra,40(sp)
    80002ab4:	02813023          	sd	s0,32(sp)
    80002ab8:	00913c23          	sd	s1,24(sp)
    80002abc:	01213823          	sd	s2,16(sp)
    80002ac0:	01313423          	sd	s3,8(sp)
    80002ac4:	03010413          	addi	s0,sp,48
    80002ac8:	00058913          	mv	s2,a1
    80002acc:	00060493          	mv	s1,a2
    80002ad0:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    80002ad4:	00000097          	auipc	ra,0x0
    80002ad8:	eb8080e7          	jalr	-328(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    80002adc:	00000613          	li	a2,0
    80002ae0:	00098593          	mv	a1,s3
    80002ae4:	00090513          	mv	a0,s2
    80002ae8:	00000097          	auipc	ra,0x0
    80002aec:	ee8080e7          	jalr	-280(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80002af0:	00048513          	mv	a0,s1
    80002af4:	00000097          	auipc	ra,0x0
    80002af8:	e98080e7          	jalr	-360(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
}
    80002afc:	02813083          	ld	ra,40(sp)
    80002b00:	02013403          	ld	s0,32(sp)
    80002b04:	01813483          	ld	s1,24(sp)
    80002b08:	01013903          	ld	s2,16(sp)
    80002b0c:	00813983          	ld	s3,8(sp)
    80002b10:	03010113          	addi	sp,sp,48
    80002b14:	00008067          	ret

0000000080002b18 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80002b18:	ff010113          	addi	sp,sp,-16
    80002b1c:	00813423          	sd	s0,8(sp)
    80002b20:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80002b24:	04300513          	li	a0,67

    asm("ecall");
    80002b28:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80002b2c:	00050513          	mv	a0,a0

    return (char)status;
}
    80002b30:	0ff57513          	andi	a0,a0,255
    80002b34:	00813403          	ld	s0,8(sp)
    80002b38:	01010113          	addi	sp,sp,16
    80002b3c:	00008067          	ret

0000000080002b40 <_ZN5RiscV10popSppSpieEv>:
    RiscV::startVirtualMemory(RiscV::kPMT);
    RiscV::enableInterrupts();
}

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80002b40:	ff010113          	addi	sp,sp,-16
    80002b44:	00813423          	sd	s0,8(sp)
    80002b48:	01010413          	addi	s0,sp,16
    uint64 ra = 0;
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80002b4c:	00008797          	auipc	a5,0x8
    80002b50:	4d47b783          	ld	a5,1236(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002b54:	0007b783          	ld	a5,0(a5)
    80002b58:	0147a683          	lw	a3,20(a5)
    80002b5c:	00100713          	li	a4,1
    80002b60:	02e68863          	beq	a3,a4,80002b90 <_ZN5RiscV10popSppSpieEv+0x50>
        asm("csrw sepc, ra");
    else
    {
        ra = (uint64)bodyWrapper;
        asm("mv a0, %[iarg]" : : [iarg] "r" (TCB::running->body));
    80002b64:	0187b703          	ld	a4,24(a5)
    80002b68:	00070513          	mv	a0,a4
        asm("mv a1, %[iarg]" : : [iarg] "r" (TCB::running->args));
    80002b6c:	0207b783          	ld	a5,32(a5)
    80002b70:	00078593          	mv	a1,a5
        asm("csrw sepc, %[ra]" : : [ra] "r" (ra));
    80002b74:	00008797          	auipc	a5,0x8
    80002b78:	4a47b783          	ld	a5,1188(a5) # 8000b018 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80002b7c:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    80002b80:	10200073          	sret
}
    80002b84:	00813403          	ld	s0,8(sp)
    80002b88:	01010113          	addi	sp,sp,16
    80002b8c:	00008067          	ret
        asm("csrw sepc, ra");
    80002b90:	14109073          	csrw	sepc,ra
    80002b94:	fedff06f          	j	80002b80 <_ZN5RiscV10popSppSpieEv+0x40>

0000000080002b98 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80002b98:	ff010113          	addi	sp,sp,-16
    80002b9c:	00113423          	sd	ra,8(sp)
    80002ba0:	00813023          	sd	s0,0(sp)
    80002ba4:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80002ba8:	00008797          	auipc	a5,0x8
    80002bac:	4787b783          	ld	a5,1144(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002bb0:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80002bb4:	00100713          	li	a4,1
    80002bb8:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002bbc:	fffff097          	auipc	ra,0xfffff
    80002bc0:	444080e7          	jalr	1092(ra) # 80002000 <_ZN3TCB8dispatchEv>
}
    80002bc4:	00813083          	ld	ra,8(sp)
    80002bc8:	00013403          	ld	s0,0(sp)
    80002bcc:	01010113          	addi	sp,sp,16
    80002bd0:	00008067          	ret

0000000080002bd4 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80002bd4:	ff010113          	addi	sp,sp,-16
    80002bd8:	00113423          	sd	ra,8(sp)
    80002bdc:	00813023          	sd	s0,0(sp)
    80002be0:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80002be4:	00008797          	auipc	a5,0x8
    80002be8:	6547c783          	lbu	a5,1620(a5) # 8000b238 <_ZN5RiscV16userMainFinishedE>
    80002bec:	00079c63          	bnez	a5,80002c04 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80002bf0:	00008717          	auipc	a4,0x8
    80002bf4:	42073703          	ld	a4,1056(a4) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80002bf8:	00073783          	ld	a5,0(a4)
    80002bfc:	00178793          	addi	a5,a5,1
    80002c00:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80002c04:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80002c08:	0ff57513          	andi	a0,a0,255
    80002c0c:	00000097          	auipc	ra,0x0
    80002c10:	c78080e7          	jalr	-904(ra) # 80002884 <_ZN11ConsoleUtil9putOutputEc>
}
    80002c14:	00813083          	ld	ra,8(sp)
    80002c18:	00013403          	ld	s0,0(sp)
    80002c1c:	01010113          	addi	sp,sp,16
    80002c20:	00008067          	ret

0000000080002c24 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80002c24:	ff010113          	addi	sp,sp,-16
    80002c28:	00813423          	sd	s0,8(sp)
    80002c2c:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80002c30:	00008797          	auipc	a5,0x8
    80002c34:	3f07b783          	ld	a5,1008(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002c38:	0007b783          	ld	a5,0(a5)
    80002c3c:	0147a703          	lw	a4,20(a5)
    80002c40:	00100793          	li	a5,1
    80002c44:	00f70c63          	beq	a4,a5,80002c5c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sstatus(uint64 mask) {
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80002c48:	10000793          	li	a5,256
    80002c4c:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    80002c50:	00813403          	ld	s0,8(sp)
    80002c54:	01010113          	addi	sp,sp,16
    80002c58:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80002c5c:	10000793          	li	a5,256
    80002c60:	1007a073          	csrs	sstatus,a5
}
    80002c64:	fedff06f          	j	80002c50 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080002c68 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80002c68:	ff010113          	addi	sp,sp,-16
    80002c6c:	00113423          	sd	ra,8(sp)
    80002c70:	00813023          	sd	s0,0(sp)
    80002c74:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80002c78:	00100793          	li	a5,1
    80002c7c:	00008717          	auipc	a4,0x8
    80002c80:	5af70e23          	sb	a5,1468(a4) # 8000b238 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80002c84:	00008797          	auipc	a5,0x8
    80002c88:	38c7b783          	ld	a5,908(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80002c8c:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80002c90:	00008797          	auipc	a5,0x8
    80002c94:	3307b783          	ld	a5,816(a5) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002c98:	0007b023          	sd	zero,0(a5)
inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80002c9c:	00200793          	li	a5,2
    80002ca0:	1047b073          	csrc	sie,a5
    80002ca4:	20000793          	li	a5,512
    80002ca8:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80002cac:	00008797          	auipc	a5,0x8
    80002cb0:	33c7b783          	ld	a5,828(a5) # 8000afe8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002cb4:	0007b783          	ld	a5,0(a5)
    80002cb8:	00078c63          	beqz	a5,80002cd0 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80002cbc:	0487b703          	ld	a4,72(a5)
    80002cc0:	00008797          	auipc	a5,0x8
    80002cc4:	3287b783          	ld	a5,808(a5) # 8000afe8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002cc8:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80002ccc:	fe1ff06f          	j	80002cac <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80002cd0:	00008797          	auipc	a5,0x8
    80002cd4:	3207b783          	ld	a5,800(a5) # 8000aff0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002cd8:	0007b503          	ld	a0,0(a5)
    80002cdc:	00001097          	auipc	ra,0x1
    80002ce0:	478080e7          	jalr	1144(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002ce4:	00008797          	auipc	a5,0x8
    80002ce8:	31c7b783          	ld	a5,796(a5) # 8000b000 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002cec:	0007b703          	ld	a4,0(a5)
    80002cf0:	00008797          	auipc	a5,0x8
    80002cf4:	3187b783          	ld	a5,792(a5) # 8000b008 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002cf8:	0007b783          	ld	a5,0(a5)
    80002cfc:	00f70863          	beq	a4,a5,80002d0c <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    80002d00:	fffff097          	auipc	ra,0xfffff
    80002d04:	300080e7          	jalr	768(ra) # 80002000 <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002d08:	fddff06f          	j	80002ce4 <_ZN5RiscV8finalizeEv+0x7c>
}
    80002d0c:	00813083          	ld	ra,8(sp)
    80002d10:	00013403          	ld	s0,0(sp)
    80002d14:	01010113          	addi	sp,sp,16
    80002d18:	00008067          	ret

0000000080002d1c <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80002d1c:	ff010113          	addi	sp,sp,-16
    80002d20:	00813423          	sd	s0,8(sp)
    80002d24:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80002d28:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80002d2c:	00008717          	auipc	a4,0x8
    80002d30:	2f473703          	ld	a4,756(a4) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002d34:	00073703          	ld	a4,0(a4)
    80002d38:	06873703          	ld	a4,104(a4)
    80002d3c:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80002d40:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80002d44:	00078593          	mv	a1,a5
}
    80002d48:	00813403          	ld	s0,8(sp)
    80002d4c:	01010113          	addi	sp,sp,16
    80002d50:	00008067          	ret

0000000080002d54 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80002d54:	ff010113          	addi	sp,sp,-16
    80002d58:	00113423          	sd	ra,8(sp)
    80002d5c:	00813023          	sd	s0,0(sp)
    80002d60:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80002d64:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80002d68:	fffff097          	auipc	ra,0xfffff
    80002d6c:	51c080e7          	jalr	1308(ra) # 80002284 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80002d70:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80002d74:	00000097          	auipc	ra,0x0
    80002d78:	fa8080e7          	jalr	-88(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80002d7c:	00813083          	ld	ra,8(sp)
    80002d80:	00013403          	ld	s0,0(sp)
    80002d84:	01010113          	addi	sp,sp,16
    80002d88:	00008067          	ret

0000000080002d8c <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80002d8c:	ff010113          	addi	sp,sp,-16
    80002d90:	00113423          	sd	ra,8(sp)
    80002d94:	00813023          	sd	s0,0(sp)
    80002d98:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80002d9c:	00008797          	auipc	a5,0x8
    80002da0:	2947b783          	ld	a5,660(a5) # 8000b030 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80002da4:	0007c783          	lbu	a5,0(a5)
    80002da8:	02079263          	bnez	a5,80002dcc <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80002dac:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002db0:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80002db4:	00000097          	auipc	ra,0x0
    80002db8:	f68080e7          	jalr	-152(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80002dbc:	00813083          	ld	ra,8(sp)
    80002dc0:	00013403          	ld	s0,0(sp)
    80002dc4:	01010113          	addi	sp,sp,16
    80002dc8:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80002dcc:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80002dd0:	fffff097          	auipc	ra,0xfffff
    80002dd4:	6ec080e7          	jalr	1772(ra) # 800024bc <_ZN15MemoryAllocator5kfreeEPv>
    80002dd8:	fd9ff06f          	j	80002db0 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080002ddc <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80002ddc:	fc010113          	addi	sp,sp,-64
    80002de0:	02113c23          	sd	ra,56(sp)
    80002de4:	02813823          	sd	s0,48(sp)
    80002de8:	02913423          	sd	s1,40(sp)
    80002dec:	03213023          	sd	s2,32(sp)
    80002df0:	01313c23          	sd	s3,24(sp)
    80002df4:	01413823          	sd	s4,16(sp)
    80002df8:	01513423          	sd	s5,8(sp)
    80002dfc:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80002e00:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80002e04:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80002e08:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80002e0c:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002e10:	07000513          	li	a0,112
    80002e14:	fffff097          	auipc	ra,0xfffff
    80002e18:	26c080e7          	jalr	620(ra) # 80002080 <_ZN3TCBnwEm>
    80002e1c:	00050493          	mv	s1,a0
    80002e20:	00050e63          	beqz	a0,80002e3c <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    80002e24:	00200713          	li	a4,2
    80002e28:	000a8693          	mv	a3,s5
    80002e2c:	000a0613          	mv	a2,s4
    80002e30:	00098593          	mv	a1,s3
    80002e34:	fffff097          	auipc	ra,0xfffff
    80002e38:	110080e7          	jalr	272(ra) # 80001f44 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80002e3c:	04048863          	beqz	s1,80002e8c <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    80002e40:	0184b783          	ld	a5,24(s1)
    80002e44:	00078863          	beqz	a5,80002e54 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    80002e48:	00048513          	mv	a0,s1
    80002e4c:	00001097          	auipc	ra,0x1
    80002e50:	308080e7          	jalr	776(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80002e54:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80002e58:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002e5c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80002e60:	00000097          	auipc	ra,0x0
    80002e64:	ebc080e7          	jalr	-324(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80002e68:	03813083          	ld	ra,56(sp)
    80002e6c:	03013403          	ld	s0,48(sp)
    80002e70:	02813483          	ld	s1,40(sp)
    80002e74:	02013903          	ld	s2,32(sp)
    80002e78:	01813983          	ld	s3,24(sp)
    80002e7c:	01013a03          	ld	s4,16(sp)
    80002e80:	00813a83          	ld	s5,8(sp)
    80002e84:	04010113          	addi	sp,sp,64
    80002e88:	00008067          	ret
        status = -1;
    80002e8c:	fff00793          	li	a5,-1
    80002e90:	fcdff06f          	j	80002e5c <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    80002e94:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002e98:	00048513          	mv	a0,s1
    80002e9c:	fffff097          	auipc	ra,0xfffff
    80002ea0:	308080e7          	jalr	776(ra) # 800021a4 <_ZN3TCBdlEPv>
    80002ea4:	00090513          	mv	a0,s2
    80002ea8:	00009097          	auipc	ra,0x9
    80002eac:	510080e7          	jalr	1296(ra) # 8000c3b8 <_Unwind_Resume>

0000000080002eb0 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80002eb0:	fc010113          	addi	sp,sp,-64
    80002eb4:	02113c23          	sd	ra,56(sp)
    80002eb8:	02813823          	sd	s0,48(sp)
    80002ebc:	02913423          	sd	s1,40(sp)
    80002ec0:	03213023          	sd	s2,32(sp)
    80002ec4:	01313c23          	sd	s3,24(sp)
    80002ec8:	01413823          	sd	s4,16(sp)
    80002ecc:	01513423          	sd	s5,8(sp)
    80002ed0:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80002ed4:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80002ed8:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80002edc:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80002ee0:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002ee4:	07000513          	li	a0,112
    80002ee8:	fffff097          	auipc	ra,0xfffff
    80002eec:	198080e7          	jalr	408(ra) # 80002080 <_ZN3TCBnwEm>
    80002ef0:	00050493          	mv	s1,a0
    80002ef4:	00050e63          	beqz	a0,80002f10 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80002ef8:	00200713          	li	a4,2
    80002efc:	000a8693          	mv	a3,s5
    80002f00:	00090613          	mv	a2,s2
    80002f04:	00098593          	mv	a1,s3
    80002f08:	fffff097          	auipc	ra,0xfffff
    80002f0c:	03c080e7          	jalr	60(ra) # 80001f44 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80002f10:	04048263          	beqz	s1,80002f54 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    80002f14:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    80002f18:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80002f1c:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    80002f20:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002f24:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80002f28:	00000097          	auipc	ra,0x0
    80002f2c:	df4080e7          	jalr	-524(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80002f30:	03813083          	ld	ra,56(sp)
    80002f34:	03013403          	ld	s0,48(sp)
    80002f38:	02813483          	ld	s1,40(sp)
    80002f3c:	02013903          	ld	s2,32(sp)
    80002f40:	01813983          	ld	s3,24(sp)
    80002f44:	01013a03          	ld	s4,16(sp)
    80002f48:	00813a83          	ld	s5,8(sp)
    80002f4c:	04010113          	addi	sp,sp,64
    80002f50:	00008067          	ret
        status = -1;
    80002f54:	fff00793          	li	a5,-1
    80002f58:	fcdff06f          	j	80002f24 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    80002f5c:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002f60:	00048513          	mv	a0,s1
    80002f64:	fffff097          	auipc	ra,0xfffff
    80002f68:	240080e7          	jalr	576(ra) # 800021a4 <_ZN3TCBdlEPv>
    80002f6c:	00090513          	mv	a0,s2
    80002f70:	00009097          	auipc	ra,0x9
    80002f74:	448080e7          	jalr	1096(ra) # 8000c3b8 <_Unwind_Resume>

0000000080002f78 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80002f78:	ff010113          	addi	sp,sp,-16
    80002f7c:	00113423          	sd	ra,8(sp)
    80002f80:	00813023          	sd	s0,0(sp)
    80002f84:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80002f88:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80002f8c:	02051263          	bnez	a0,80002fb0 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80002f90:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002f94:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80002f98:	00000097          	auipc	ra,0x0
    80002f9c:	d84080e7          	jalr	-636(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80002fa0:	00813083          	ld	ra,8(sp)
    80002fa4:	00013403          	ld	s0,0(sp)
    80002fa8:	01010113          	addi	sp,sp,16
    80002fac:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80002fb0:	00100793          	li	a5,1
    80002fb4:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002fb8:	00001097          	auipc	ra,0x1
    80002fbc:	19c080e7          	jalr	412(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80002fc0:	fffff097          	auipc	ra,0xfffff
    80002fc4:	040080e7          	jalr	64(ra) # 80002000 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80002fc8:	00000793          	li	a5,0
    80002fcc:	fc9ff06f          	j	80002f94 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080002fd0 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80002fd0:	ff010113          	addi	sp,sp,-16
    80002fd4:	00113423          	sd	ra,8(sp)
    80002fd8:	00813023          	sd	s0,0(sp)
    80002fdc:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80002fe0:	00008797          	auipc	a5,0x8
    80002fe4:	0407b783          	ld	a5,64(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002fe8:	0007b783          	ld	a5,0(a5)
    80002fec:	02078a63          	beqz	a5,80003020 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80002ff0:	00200713          	li	a4,2
    80002ff4:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80002ff8:	fffff097          	auipc	ra,0xfffff
    80002ffc:	008080e7          	jalr	8(ra) # 80002000 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003000:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003004:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003008:	00000097          	auipc	ra,0x0
    8000300c:	d14080e7          	jalr	-748(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003010:	00813083          	ld	ra,8(sp)
    80003014:	00013403          	ld	s0,0(sp)
    80003018:	01010113          	addi	sp,sp,16
    8000301c:	00008067          	ret
        status = -1;
    80003020:	fff00793          	li	a5,-1
    80003024:	fe1ff06f          	j	80003004 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003028 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003028:	fd010113          	addi	sp,sp,-48
    8000302c:	02113423          	sd	ra,40(sp)
    80003030:	02813023          	sd	s0,32(sp)
    80003034:	00913c23          	sd	s1,24(sp)
    80003038:	01213823          	sd	s2,16(sp)
    8000303c:	01313423          	sd	s3,8(sp)
    80003040:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003044:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003048:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    8000304c:	01800513          	li	a0,24
    80003050:	ffffe097          	auipc	ra,0xffffe
    80003054:	7cc080e7          	jalr	1996(ra) # 8000181c <_ZN3SCBnwEm>
    80003058:	00050493          	mv	s1,a0
    8000305c:	00050863          	beqz	a0,8000306c <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    80003060:	00098593          	mv	a1,s3
    80003064:	ffffe097          	auipc	ra,0xffffe
    80003068:	604080e7          	jalr	1540(ra) # 80001668 <_ZN3SCBC1Em>
    if(scb == nullptr){
    8000306c:	02048a63          	beqz	s1,800030a0 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    80003070:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80003074:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003078:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000307c:	00000097          	auipc	ra,0x0
    80003080:	ca0080e7          	jalr	-864(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003084:	02813083          	ld	ra,40(sp)
    80003088:	02013403          	ld	s0,32(sp)
    8000308c:	01813483          	ld	s1,24(sp)
    80003090:	01013903          	ld	s2,16(sp)
    80003094:	00813983          	ld	s3,8(sp)
    80003098:	03010113          	addi	sp,sp,48
    8000309c:	00008067          	ret
        status = -1;
    800030a0:	fff00793          	li	a5,-1
    800030a4:	fd5ff06f          	j	80003078 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    800030a8:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    800030ac:	00048513          	mv	a0,s1
    800030b0:	ffffe097          	auipc	ra,0xffffe
    800030b4:	79c080e7          	jalr	1948(ra) # 8000184c <_ZN3SCBdlEPv>
    800030b8:	00090513          	mv	a0,s2
    800030bc:	00009097          	auipc	ra,0x9
    800030c0:	2fc080e7          	jalr	764(ra) # 8000c3b8 <_Unwind_Resume>

00000000800030c4 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    800030c4:	fe010113          	addi	sp,sp,-32
    800030c8:	00113c23          	sd	ra,24(sp)
    800030cc:	00813823          	sd	s0,16(sp)
    800030d0:	00913423          	sd	s1,8(sp)
    800030d4:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800030d8:	00058493          	mv	s1,a1
    if(scb == nullptr){
    800030dc:	02049463          	bnez	s1,80003104 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    800030e0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800030e4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800030e8:	00000097          	auipc	ra,0x0
    800030ec:	c34080e7          	jalr	-972(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    800030f0:	01813083          	ld	ra,24(sp)
    800030f4:	01013403          	ld	s0,16(sp)
    800030f8:	00813483          	ld	s1,8(sp)
    800030fc:	02010113          	addi	sp,sp,32
    80003100:	00008067          	ret
        delete (SCB*)ihandle;
    80003104:	00048513          	mv	a0,s1
    80003108:	ffffe097          	auipc	ra,0xffffe
    8000310c:	57c080e7          	jalr	1404(ra) # 80001684 <_ZN3SCBD1Ev>
    80003110:	00048513          	mv	a0,s1
    80003114:	ffffe097          	auipc	ra,0xffffe
    80003118:	738080e7          	jalr	1848(ra) # 8000184c <_ZN3SCBdlEPv>
    uint64 status = 0;
    8000311c:	00000793          	li	a5,0
    80003120:	fc5ff06f          	j	800030e4 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080003124 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80003124:	ff010113          	addi	sp,sp,-16
    80003128:	00113423          	sd	ra,8(sp)
    8000312c:	00813023          	sd	s0,0(sp)
    80003130:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003134:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003138:	02051c63          	bnez	a0,80003170 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    8000313c:	00008797          	auipc	a5,0x8
    80003140:	ee47b783          	ld	a5,-284(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003144:	0007b783          	ld	a5,0(a5)
    80003148:	0607b783          	ld	a5,96(a5)
    8000314c:	02078863          	beqz	a5,8000317c <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003150:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003154:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003158:	00000097          	auipc	ra,0x0
    8000315c:	bc4080e7          	jalr	-1084(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003160:	00813083          	ld	ra,8(sp)
    80003164:	00013403          	ld	s0,0(sp)
    80003168:	01010113          	addi	sp,sp,16
    8000316c:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003170:	ffffe097          	auipc	ra,0xffffe
    80003174:	620080e7          	jalr	1568(ra) # 80001790 <_ZN3SCB4waitEv>
    80003178:	fc5ff06f          	j	8000313c <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    8000317c:	00000793          	li	a5,0
    80003180:	fd5ff06f          	j	80003154 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003184 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003184:	ff010113          	addi	sp,sp,-16
    80003188:	00113423          	sd	ra,8(sp)
    8000318c:	00813023          	sd	s0,0(sp)
    80003190:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003194:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003198:	02051263          	bnez	a0,800031bc <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    8000319c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800031a0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800031a4:	00000097          	auipc	ra,0x0
    800031a8:	b78080e7          	jalr	-1160(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    800031ac:	00813083          	ld	ra,8(sp)
    800031b0:	00013403          	ld	s0,0(sp)
    800031b4:	01010113          	addi	sp,sp,16
    800031b8:	00008067          	ret
        ((SCB*)ihandle)->signal();
    800031bc:	ffffe097          	auipc	ra,0xffffe
    800031c0:	624080e7          	jalr	1572(ra) # 800017e0 <_ZN3SCB6signalEv>
    uint64 status = 0;
    800031c4:	00000793          	li	a5,0
    800031c8:	fd9ff06f          	j	800031a0 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

00000000800031cc <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    800031cc:	fe010113          	addi	sp,sp,-32
    800031d0:	00113c23          	sd	ra,24(sp)
    800031d4:	00813823          	sd	s0,16(sp)
    800031d8:	00913423          	sd	s1,8(sp)
    800031dc:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    800031e0:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    800031e4:	00008797          	auipc	a5,0x8
    800031e8:	e3c7b783          	ld	a5,-452(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800031ec:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    800031f0:	00008797          	auipc	a5,0x8
    800031f4:	0507b783          	ld	a5,80(a5) # 8000b240 <_ZN5RiscV10globalTimeE>
    800031f8:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    800031fc:	00e787b3          	add	a5,a5,a4
    80003200:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003204:	00048513          	mv	a0,s1
    80003208:	00001097          	auipc	ra,0x1
    8000320c:	fc8080e7          	jalr	-56(ra) # 800041d0 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003210:	00300793          	li	a5,3
    80003214:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003218:	fffff097          	auipc	ra,0xfffff
    8000321c:	de8080e7          	jalr	-536(ra) # 80002000 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003220:	00000793          	li	a5,0
    80003224:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003228:	00000097          	auipc	ra,0x0
    8000322c:	af4080e7          	jalr	-1292(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003230:	01813083          	ld	ra,24(sp)
    80003234:	01013403          	ld	s0,16(sp)
    80003238:	00813483          	ld	s1,8(sp)
    8000323c:	02010113          	addi	sp,sp,32
    80003240:	00008067          	ret

0000000080003244 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003244:	fe010113          	addi	sp,sp,-32
    80003248:	00113c23          	sd	ra,24(sp)
    8000324c:	00813823          	sd	s0,16(sp)
    80003250:	00913423          	sd	s1,8(sp)
    80003254:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003258:	00008797          	auipc	a5,0x8
    8000325c:	fe07c783          	lbu	a5,-32(a5) # 8000b238 <_ZN5RiscV16userMainFinishedE>
    80003260:	00079c63          	bnez	a5,80003278 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003264:	00008717          	auipc	a4,0x8
    80003268:	d5c73703          	ld	a4,-676(a4) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000326c:	00073783          	ld	a5,0(a4)
    80003270:	00178793          	addi	a5,a5,1
    80003274:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003278:	fffff097          	auipc	ra,0xfffff
    8000327c:	59c080e7          	jalr	1436(ra) # 80002814 <_ZN11ConsoleUtil8getInputEv>
    80003280:	00050493          	mv	s1,a0
    if(c==13) {
    80003284:	00d00793          	li	a5,13
    80003288:	02f50663          	beq	a0,a5,800032b4 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    8000328c:	01b00793          	li	a5,27
    80003290:	04f51063          	bne	a0,a5,800032d0 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003294:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003298:	00000097          	auipc	ra,0x0
    8000329c:	a84080e7          	jalr	-1404(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    800032a0:	01813083          	ld	ra,24(sp)
    800032a4:	01013403          	ld	s0,16(sp)
    800032a8:	00813483          	ld	s1,8(sp)
    800032ac:	02010113          	addi	sp,sp,32
    800032b0:	00008067          	ret
        ConsoleUtil::putOutput(13);
    800032b4:	00d00513          	li	a0,13
    800032b8:	fffff097          	auipc	ra,0xfffff
    800032bc:	5cc080e7          	jalr	1484(ra) # 80002884 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    800032c0:	00a00513          	li	a0,10
    800032c4:	fffff097          	auipc	ra,0xfffff
    800032c8:	5c0080e7          	jalr	1472(ra) # 80002884 <_ZN11ConsoleUtil9putOutputEc>
    800032cc:	fc9ff06f          	j	80003294 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    800032d0:	fffff097          	auipc	ra,0xfffff
    800032d4:	5b4080e7          	jalr	1460(ra) # 80002884 <_ZN11ConsoleUtil9putOutputEc>
    800032d8:	fbdff06f          	j	80003294 <_ZN5RiscV18executeGetcSyscallEv+0x50>

00000000800032dc <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    800032dc:	ff010113          	addi	sp,sp,-16
    800032e0:	00113423          	sd	ra,8(sp)
    800032e4:	00813023          	sd	s0,0(sp)
    800032e8:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    800032ec:	fffff097          	auipc	ra,0xfffff
    800032f0:	630080e7          	jalr	1584(ra) # 8000291c <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    800032f4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800032f8:	00000097          	auipc	ra,0x0
    800032fc:	a24080e7          	jalr	-1500(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003300:	00813083          	ld	ra,8(sp)
    80003304:	00013403          	ld	s0,0(sp)
    80003308:	01010113          	addi	sp,sp,16
    8000330c:	00008067          	ret

0000000080003310 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003310:	fe010113          	addi	sp,sp,-32
    80003314:	00113c23          	sd	ra,24(sp)
    80003318:	00813823          	sd	s0,16(sp)
    8000331c:	00913423          	sd	s1,8(sp)
    80003320:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003324:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003328:	02049463          	bnez	s1,80003350 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000332c:	fff00793          	li	a5,-1
    80003330:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003334:	00000097          	auipc	ra,0x0
    80003338:	9e8080e7          	jalr	-1560(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    8000333c:	01813083          	ld	ra,24(sp)
    80003340:	01013403          	ld	s0,16(sp)
    80003344:	00813483          	ld	s1,8(sp)
    80003348:	02010113          	addi	sp,sp,32
    8000334c:	00008067          	ret
        kfree(thr->stack);
    80003350:	0284b503          	ld	a0,40(s1)
    80003354:	00001097          	auipc	ra,0x1
    80003358:	144080e7          	jalr	324(ra) # 80004498 <_Z5kfreePKv>
        delete thr;
    8000335c:	00048513          	mv	a0,s1
    80003360:	fffff097          	auipc	ra,0xfffff
    80003364:	c78080e7          	jalr	-904(ra) # 80001fd8 <_ZN3TCBD1Ev>
    80003368:	00048513          	mv	a0,s1
    8000336c:	fffff097          	auipc	ra,0xfffff
    80003370:	e38080e7          	jalr	-456(ra) # 800021a4 <_ZN3TCBdlEPv>
    80003374:	fb9ff06f          	j	8000332c <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080003378 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003378:	fe010113          	addi	sp,sp,-32
    8000337c:	00113c23          	sd	ra,24(sp)
    80003380:	00813823          	sd	s0,16(sp)
    80003384:	00913423          	sd	s1,8(sp)
    80003388:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000338c:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003390:	02049463          	bnez	s1,800033b8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003394:	fff00793          	li	a5,-1
    80003398:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    8000339c:	00000097          	auipc	ra,0x0
    800033a0:	980080e7          	jalr	-1664(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    800033a4:	01813083          	ld	ra,24(sp)
    800033a8:	01013403          	ld	s0,16(sp)
    800033ac:	00813483          	ld	s1,8(sp)
    800033b0:	02010113          	addi	sp,sp,32
    800033b4:	00008067          	ret
        delete scb;
    800033b8:	00048513          	mv	a0,s1
    800033bc:	ffffe097          	auipc	ra,0xffffe
    800033c0:	2c8080e7          	jalr	712(ra) # 80001684 <_ZN3SCBD1Ev>
    800033c4:	00048513          	mv	a0,s1
    800033c8:	ffffe097          	auipc	ra,0xffffe
    800033cc:	484080e7          	jalr	1156(ra) # 8000184c <_ZN3SCBdlEPv>
    800033d0:	fc5ff06f          	j	80003394 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

00000000800033d4 <_ZN5RiscV5getPCEv>:

    RiscV::saveA0toSscratch();

}

void RiscV::getPC(){
    800033d4:	ff010113          	addi	sp,sp,-16
    800033d8:	00813423          	sd	s0,8(sp)
    800033dc:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    800033e0:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    800033e4:	00878793          	addi	a5,a5,8
    800033e8:	00008717          	auipc	a4,0x8
    800033ec:	bf873703          	ld	a4,-1032(a4) # 8000afe0 <_GLOBAL_OFFSET_TABLE_+0x78>
    800033f0:	00f73023          	sd	a5,0(a4)
}
    800033f4:	00813403          	ld	s0,8(sp)
    800033f8:	01010113          	addi	sp,sp,16
    800033fc:	00008067          	ret

0000000080003400 <_ZN5RiscV14threadExitUtilEv>:

    asm("mv %[status], a0" : [status] "=r" (status));

}

void RiscV::threadExitUtil() {
    80003400:	ff010113          	addi	sp,sp,-16
    80003404:	00813423          	sd	s0,8(sp)
    80003408:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    8000340c:	01200513          	li	a0,18

    asm("ecall");
    80003410:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    80003414:	00813403          	ld	s0,8(sp)
    80003418:	01010113          	addi	sp,sp,16
    8000341c:	00008067          	ret

0000000080003420 <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    80003420:	ff010113          	addi	sp,sp,-16
    80003424:	00813423          	sd	s0,8(sp)
    80003428:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    8000342c:	01300513          	li	a0,19

    asm("ecall");
    80003430:	00000073          	ecall
}
    80003434:	00813403          	ld	s0,8(sp)
    80003438:	01010113          	addi	sp,sp,16
    8000343c:	00008067          	ret

0000000080003440 <_ZN5RiscV11putcWrapperEPv>:
{
    80003440:	fe010113          	addi	sp,sp,-32
    80003444:	00113c23          	sd	ra,24(sp)
    80003448:	00813823          	sd	s0,16(sp)
    8000344c:	02010413          	addi	s0,sp,32
    80003450:	00c0006f          	j	8000345c <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    80003454:	00000097          	auipc	ra,0x0
    80003458:	fcc080e7          	jalr	-52(ra) # 80003420 <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    8000345c:	00008797          	auipc	a5,0x8
    80003460:	b1c7b783          	ld	a5,-1252(a5) # 8000af78 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003464:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003468:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    8000346c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003470:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003474:	0207f793          	andi	a5,a5,32
    80003478:	fc078ee3          	beqz	a5,80003454 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    8000347c:	fffff097          	auipc	ra,0xfffff
    80003480:	69c080e7          	jalr	1692(ra) # 80002b18 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003484:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003488:	00008797          	auipc	a5,0x8
    8000348c:	ae87b783          	ld	a5,-1304(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003490:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003494:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003498:	fef44783          	lbu	a5,-17(s0)
    8000349c:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    800034a0:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    800034a4:	00008797          	auipc	a5,0x8
    800034a8:	b6c7b783          	ld	a5,-1172(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xa8>
    800034ac:	0007b783          	ld	a5,0(a5)
    800034b0:	fa0786e3          	beqz	a5,8000345c <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    800034b4:	fff78793          	addi	a5,a5,-1
    800034b8:	00008717          	auipc	a4,0x8
    800034bc:	b5873703          	ld	a4,-1192(a4) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xa8>
    800034c0:	00f73023          	sd	a5,0(a4)
    800034c4:	f99ff06f          	j	8000345c <_ZN5RiscV11putcWrapperEPv+0x1c>

00000000800034c8 <_ZN5RiscV6getPMTEv>:

    RiscV::mapConsoleRegisters(uPMT);
    RiscV::ms_sstatus(1<<18);
}

void* RiscV::getPMT(){
    800034c8:	ff010113          	addi	sp,sp,-16
    800034cc:	00113423          	sd	ra,8(sp)
    800034d0:	00813023          	sd	s0,0(sp)
    800034d4:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    800034d8:	00100513          	li	a0,1
    800034dc:	fffff097          	auipc	ra,0xfffff
    800034e0:	800080e7          	jalr	-2048(ra) # 80001cdc <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    800034e4:	00000793          	li	a5,0
    800034e8:	1ff00713          	li	a4,511
    800034ec:	00f74c63          	blt	a4,a5,80003504 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    800034f0:	00379713          	slli	a4,a5,0x3
    800034f4:	00e50733          	add	a4,a0,a4
    800034f8:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    800034fc:	0017879b          	addiw	a5,a5,1
    80003500:	fe9ff06f          	j	800034e8 <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    80003504:	00813083          	ld	ra,8(sp)
    80003508:	00013403          	ld	s0,0(sp)
    8000350c:	01010113          	addi	sp,sp,16
    80003510:	00008067          	ret

0000000080003514 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    80003514:	fc010113          	addi	sp,sp,-64
    80003518:	02113c23          	sd	ra,56(sp)
    8000351c:	02813823          	sd	s0,48(sp)
    80003520:	02913423          	sd	s1,40(sp)
    80003524:	03213023          	sd	s2,32(sp)
    80003528:	01313c23          	sd	s3,24(sp)
    8000352c:	01413823          	sd	s4,16(sp)
    80003530:	01513423          	sd	s5,8(sp)
    80003534:	04010413          	addi	s0,sp,64
    80003538:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    8000353c:	01e5d793          	srli	a5,a1,0x1e
    80003540:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    80003544:	0155d913          	srli	s2,a1,0x15
    80003548:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    8000354c:	00c5d493          	srli	s1,a1,0xc
    80003550:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80003554:	00379793          	slli	a5,a5,0x3
    80003558:	00f50ab3          	add	s5,a0,a5
    8000355c:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80003560:	04078e63          	beqz	a5,800035bc <_ZN5RiscV15handlePageFaultEPvmm+0xa8>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80003564:	00a7d513          	srli	a0,a5,0xa
    80003568:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    8000356c:	00391913          	slli	s2,s2,0x3
    80003570:	01250933          	add	s2,a0,s2
    80003574:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    80003578:	06050063          	beqz	a0,800035d8 <_ZN5RiscV15handlePageFaultEPvmm+0xc4>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    8000357c:	00a55513          	srli	a0,a0,0xa
    80003580:	00c51513          	slli	a0,a0,0xc
    ((uint64 *) pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    80003584:	00a49493          	slli	s1,s1,0xa
    80003588:	003a1a13          	slli	s4,s4,0x3
    8000358c:	01450533          	add	a0,a0,s4
    80003590:	0134e9b3          	or	s3,s1,s3
    80003594:	01353023          	sd	s3,0(a0)
}
    80003598:	03813083          	ld	ra,56(sp)
    8000359c:	03013403          	ld	s0,48(sp)
    800035a0:	02813483          	ld	s1,40(sp)
    800035a4:	02013903          	ld	s2,32(sp)
    800035a8:	01813983          	ld	s3,24(sp)
    800035ac:	01013a03          	ld	s4,16(sp)
    800035b0:	00813a83          	ld	s5,8(sp)
    800035b4:	04010113          	addi	sp,sp,64
    800035b8:	00008067          	ret
        pmt1 = RiscV::getPMT();
    800035bc:	00000097          	auipc	ra,0x0
    800035c0:	f0c080e7          	jalr	-244(ra) # 800034c8 <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    800035c4:	00c55793          	srli	a5,a0,0xc
    800035c8:	00a79793          	slli	a5,a5,0xa
    800035cc:	0017e793          	ori	a5,a5,1
    800035d0:	00fab023          	sd	a5,0(s5)
    800035d4:	f99ff06f          	j	8000356c <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    800035d8:	00000097          	auipc	ra,0x0
    800035dc:	ef0080e7          	jalr	-272(ra) # 800034c8 <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    800035e0:	00c55793          	srli	a5,a0,0xc
    800035e4:	00a79793          	slli	a5,a5,0xa
    800035e8:	0017e793          	ori	a5,a5,1
    800035ec:	00f93023          	sd	a5,0(s2)
    800035f0:	f95ff06f          	j	80003584 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

00000000800035f4 <_ZN5RiscV18executeForkSyscallEv>:
void RiscV::executeForkSyscall() {
    800035f4:	fe010113          	addi	sp,sp,-32
    800035f8:	00113c23          	sd	ra,24(sp)
    800035fc:	00813823          	sd	s0,16(sp)
    80003600:	00913423          	sd	s1,8(sp)
    80003604:	01213023          	sd	s2,0(sp)
    80003608:	02010413          	addi	s0,sp,32
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    8000360c:	00001537          	lui	a0,0x1
    80003610:	00001097          	auipc	ra,0x1
    80003614:	e60080e7          	jalr	-416(ra) # 80004470 <_Z7kmallocm>
    80003618:	00050913          	mv	s2,a0
    handlePageFault(kPMT, (uint64)stack, 0x17);
    8000361c:	01700613          	li	a2,23
    80003620:	00050593          	mv	a1,a0
    80003624:	00008517          	auipc	a0,0x8
    80003628:	c2453503          	ld	a0,-988(a0) # 8000b248 <_ZN5RiscV4kPMTE>
    8000362c:	00000097          	auipc	ra,0x0
    80003630:	ee8080e7          	jalr	-280(ra) # 80003514 <_ZN5RiscV15handlePageFaultEPvmm>
    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003634:	00008797          	auipc	a5,0x8
    80003638:	9ec7b783          	ld	a5,-1556(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000363c:	0007b783          	ld	a5,0(a5)
    80003640:	00001637          	lui	a2,0x1
    80003644:	00090593          	mv	a1,s2
    80003648:	0287b503          	ld	a0,40(a5)
    8000364c:	fffff097          	auipc	ra,0xfffff
    80003650:	024080e7          	jalr	36(ra) # 80002670 <_ZN15MemoryAllocator6memcpyEPvS0_m>
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003654:	07000513          	li	a0,112
    80003658:	fffff097          	auipc	ra,0xfffff
    8000365c:	a28080e7          	jalr	-1496(ra) # 80002080 <_ZN3TCBnwEm>
    80003660:	00050493          	mv	s1,a0
    80003664:	00050e63          	beqz	a0,80003680 <_ZN5RiscV18executeForkSyscallEv+0x8c>
    80003668:	00200713          	li	a4,2
    8000366c:	00090693          	mv	a3,s2
    80003670:	00000613          	li	a2,0
    80003674:	00000593          	li	a1,0
    80003678:	fffff097          	auipc	ra,0xfffff
    8000367c:	8cc080e7          	jalr	-1844(ra) # 80001f44 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(forked) {
    80003680:	0a048e63          	beqz	s1,8000373c <_ZN5RiscV18executeForkSyscallEv+0x148>
        forked->context.ra = TCB::currentPC;
    80003684:	00008797          	auipc	a5,0x8
    80003688:	95c7b783          	ld	a5,-1700(a5) # 8000afe0 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000368c:	0007b783          	ld	a5,0(a5)
    80003690:	00f4b423          	sd	a5,8(s1)
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003694:	00008797          	auipc	a5,0x8
    80003698:	9347b783          	ld	a5,-1740(a5) # 8000afc8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000369c:	0007b783          	ld	a5,0(a5)
    800036a0:	00f907b3          	add	a5,s2,a5
    800036a4:	00008717          	auipc	a4,0x8
    800036a8:	97c73703          	ld	a4,-1668(a4) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800036ac:	00073683          	ld	a3,0(a4)
    800036b0:	0286b683          	ld	a3,40(a3)
    800036b4:	40d787b3          	sub	a5,a5,a3
    800036b8:	00f4b023          	sd	a5,0(s1)
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    800036bc:	00073783          	ld	a5,0(a4)
    800036c0:	0687b503          	ld	a0,104(a5)
    800036c4:	0287b783          	ld	a5,40(a5)
    800036c8:	40f50533          	sub	a0,a0,a5
    800036cc:	00a90933          	add	s2,s2,a0
        forked->a0Location = registerStartSP;
    800036d0:	0724b423          	sd	s2,104(s1)
        asm("mv %[a1], a1": [a1] "=r"(a1));
    800036d4:	00058693          	mv	a3,a1
        asm("mv %[a0], a0": [a0] "=r"(a0));
    800036d8:	00050793          	mv	a5,a0
        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    800036dc:	00090513          	mv	a0,s2
        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    800036e0:	00090593          	mv	a1,s2
        asm("sd a0, 16(a1)");
    800036e4:	00a5b823          	sd	a0,16(a1)
        asm("li a0, 0");
    800036e8:	00000513          	li	a0,0
        asm("sd a0, 80(a1)");
    800036ec:	04a5b823          	sd	a0,80(a1)
        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800036f0:	00068593          	mv	a1,a3
        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    800036f4:	00078513          	mv	a0,a5
        forked->sepc = TCB::running->sepc;
    800036f8:	00073783          	ld	a5,0(a4)
    800036fc:	0387b703          	ld	a4,56(a5)
    80003700:	02e4bc23          	sd	a4,56(s1)
        forked->sstatus = TCB::running->sstatus;
    80003704:	0407b783          	ld	a5,64(a5)
    80003708:	04f4b023          	sd	a5,64(s1)
        Scheduler::put(forked);
    8000370c:	00048513          	mv	a0,s1
    80003710:	00001097          	auipc	ra,0x1
    80003714:	a44080e7          	jalr	-1468(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003718:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    8000371c:	fffff097          	auipc	ra,0xfffff
    80003720:	600080e7          	jalr	1536(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003724:	01813083          	ld	ra,24(sp)
    80003728:	01013403          	ld	s0,16(sp)
    8000372c:	00813483          	ld	s1,8(sp)
    80003730:	00013903          	ld	s2,0(sp)
    80003734:	02010113          	addi	sp,sp,32
    80003738:	00008067          	ret
        status = -1;
    8000373c:	fff00493          	li	s1,-1
    80003740:	fd9ff06f          	j	80003718 <_ZN5RiscV18executeForkSyscallEv+0x124>
    80003744:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003748:	00048513          	mv	a0,s1
    8000374c:	fffff097          	auipc	ra,0xfffff
    80003750:	a58080e7          	jalr	-1448(ra) # 800021a4 <_ZN3TCBdlEPv>
    80003754:	00090513          	mv	a0,s2
    80003758:	00009097          	auipc	ra,0x9
    8000375c:	c60080e7          	jalr	-928(ra) # 8000c3b8 <_Unwind_Resume>

0000000080003760 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003760:	f9010113          	addi	sp,sp,-112
    80003764:	06113423          	sd	ra,104(sp)
    80003768:	06813023          	sd	s0,96(sp)
    8000376c:	04913c23          	sd	s1,88(sp)
    80003770:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    80003774:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003778:	142027f3          	csrr	a5,scause
    8000377c:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80003780:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    80003784:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80003788:	00008797          	auipc	a5,0x8
    8000378c:	8987b783          	ld	a5,-1896(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003790:	0007b783          	ld	a5,0(a5)
    80003794:	14002773          	csrr	a4,sscratch
    80003798:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    8000379c:	fd843703          	ld	a4,-40(s0)
    800037a0:	00900793          	li	a5,9
    800037a4:	10f70663          	beq	a4,a5,800038b0 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    800037a8:	fd843703          	ld	a4,-40(s0)
    800037ac:	00800793          	li	a5,8
    800037b0:	10f70063          	beq	a4,a5,800038b0 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    800037b4:	fd843703          	ld	a4,-40(s0)
    800037b8:	fff00793          	li	a5,-1
    800037bc:	03f79793          	slli	a5,a5,0x3f
    800037c0:	00178793          	addi	a5,a5,1
    800037c4:	26f70463          	beq	a4,a5,80003a2c <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    800037c8:	fd843703          	ld	a4,-40(s0)
    800037cc:	fff00793          	li	a5,-1
    800037d0:	03f79793          	slli	a5,a5,0x3f
    800037d4:	00978793          	addi	a5,a5,9
    800037d8:	2ef70263          	beq	a4,a5,80003abc <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    800037dc:	fd843703          	ld	a4,-40(s0)
    800037e0:	00200793          	li	a5,2
    800037e4:	36f70a63          	beq	a4,a5,80003b58 <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    800037e8:	00005517          	auipc	a0,0x5
    800037ec:	98050513          	addi	a0,a0,-1664 # 80008168 <CONSOLE_STATUS+0x158>
    800037f0:	fffff097          	auipc	ra,0xfffff
    800037f4:	19c080e7          	jalr	412(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    800037f8:	00005517          	auipc	a0,0x5
    800037fc:	98050513          	addi	a0,a0,-1664 # 80008178 <CONSOLE_STATUS+0x168>
    80003800:	fffff097          	auipc	ra,0xfffff
    80003804:	18c080e7          	jalr	396(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003808:	142027f3          	csrr	a5,scause
    8000380c:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003810:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80003814:	00000613          	li	a2,0
    80003818:	00a00593          	li	a1,10
    8000381c:	0005051b          	sext.w	a0,a0
    80003820:	fffff097          	auipc	ra,0xfffff
    80003824:	1b0080e7          	jalr	432(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003828:	00005517          	auipc	a0,0x5
    8000382c:	91050513          	addi	a0,a0,-1776 # 80008138 <CONSOLE_STATUS+0x128>
    80003830:	fffff097          	auipc	ra,0xfffff
    80003834:	15c080e7          	jalr	348(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003838:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    8000383c:	00000613          	li	a2,0
    80003840:	01000593          	li	a1,16
    80003844:	0005051b          	sext.w	a0,a0
    80003848:	fffff097          	auipc	ra,0xfffff
    8000384c:	188080e7          	jalr	392(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003850:	00005517          	auipc	a0,0x5
    80003854:	8c850513          	addi	a0,a0,-1848 # 80008118 <CONSOLE_STATUS+0x108>
    80003858:	fffff097          	auipc	ra,0xfffff
    8000385c:	134080e7          	jalr	308(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    80003860:	01000693          	li	a3,16
    80003864:	00005617          	auipc	a2,0x5
    80003868:	8b460613          	addi	a2,a2,-1868 # 80008118 <CONSOLE_STATUS+0x108>
    8000386c:	0004859b          	sext.w	a1,s1
    80003870:	00005517          	auipc	a0,0x5
    80003874:	91850513          	addi	a0,a0,-1768 # 80008188 <CONSOLE_STATUS+0x178>
    80003878:	fffff097          	auipc	ra,0xfffff
    8000387c:	234080e7          	jalr	564(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80003880:	00007797          	auipc	a5,0x7
    80003884:	7a07b783          	ld	a5,1952(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003888:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000388c:	00200713          	li	a4,2
    80003890:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003894:	00005517          	auipc	a0,0x5
    80003898:	8fc50513          	addi	a0,a0,-1796 # 80008190 <CONSOLE_STATUS+0x180>
    8000389c:	fffff097          	auipc	ra,0xfffff
    800038a0:	0f0080e7          	jalr	240(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800038a4:	ffffe097          	auipc	ra,0xffffe
    800038a8:	75c080e7          	jalr	1884(ra) # 80002000 <_ZN3TCB8dispatchEv>
    800038ac:	0800006f          	j	8000392c <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800038b0:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800038b4:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800038b8:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    800038bc:	00478793          	addi	a5,a5,4
    800038c0:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    800038c4:	00007797          	auipc	a5,0x7
    800038c8:	75c7b783          	ld	a5,1884(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800038cc:	0007b783          	ld	a5,0(a5)
    800038d0:	fa043703          	ld	a4,-96(s0)
    800038d4:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800038d8:	f9843703          	ld	a4,-104(s0)
    800038dc:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800038e0:	00050793          	mv	a5,a0
        switch(syscallID){
    800038e4:	06100713          	li	a4,97
    800038e8:	02f76463          	bltu	a4,a5,80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    800038ec:	00279793          	slli	a5,a5,0x2
    800038f0:	00005717          	auipc	a4,0x5
    800038f4:	8b470713          	addi	a4,a4,-1868 # 800081a4 <CONSOLE_STATUS+0x194>
    800038f8:	00e787b3          	add	a5,a5,a4
    800038fc:	0007a783          	lw	a5,0(a5)
    80003900:	00e787b3          	add	a5,a5,a4
    80003904:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003908:	fffff097          	auipc	ra,0xfffff
    8000390c:	44c080e7          	jalr	1100(ra) # 80002d54 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003910:	00007797          	auipc	a5,0x7
    80003914:	7107b783          	ld	a5,1808(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003918:	0007b783          	ld	a5,0(a5)
    8000391c:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003920:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003924:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003928:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    8000392c:	fffff097          	auipc	ra,0xfffff
    80003930:	2f8080e7          	jalr	760(ra) # 80002c24 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003934:	06813083          	ld	ra,104(sp)
    80003938:	06013403          	ld	s0,96(sp)
    8000393c:	05813483          	ld	s1,88(sp)
    80003940:	07010113          	addi	sp,sp,112
    80003944:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003948:	fffff097          	auipc	ra,0xfffff
    8000394c:	444080e7          	jalr	1092(ra) # 80002d8c <_ZN5RiscV21executeMemFreeSyscallEv>
    80003950:	fc1ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    80003954:	fffff097          	auipc	ra,0xfffff
    80003958:	488080e7          	jalr	1160(ra) # 80002ddc <_ZN5RiscV26executeThreadCreateSyscallEv>
    8000395c:	fb5ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    80003960:	fffff097          	auipc	ra,0xfffff
    80003964:	670080e7          	jalr	1648(ra) # 80002fd0 <_ZN5RiscV24executeThreadExitSyscallEv>
    80003968:	fa9ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    8000396c:	fffff097          	auipc	ra,0xfffff
    80003970:	22c080e7          	jalr	556(ra) # 80002b98 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003974:	f9dff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003978:	fffff097          	auipc	ra,0xfffff
    8000397c:	538080e7          	jalr	1336(ra) # 80002eb0 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003980:	f91ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    80003984:	fffff097          	auipc	ra,0xfffff
    80003988:	5f4080e7          	jalr	1524(ra) # 80002f78 <_ZN5RiscV25executeThreadStartSyscallEv>
    8000398c:	f85ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80003990:	fffff097          	auipc	ra,0xfffff
    80003994:	698080e7          	jalr	1688(ra) # 80003028 <_ZN5RiscV21executeSemOpenSyscallEv>
    80003998:	f79ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    8000399c:	fffff097          	auipc	ra,0xfffff
    800039a0:	728080e7          	jalr	1832(ra) # 800030c4 <_ZN5RiscV22executeSemCloseSyscallEv>
    800039a4:	f6dff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    800039a8:	fffff097          	auipc	ra,0xfffff
    800039ac:	77c080e7          	jalr	1916(ra) # 80003124 <_ZN5RiscV21executeSemWaitSyscallEv>
    800039b0:	f61ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    800039b4:	fffff097          	auipc	ra,0xfffff
    800039b8:	7d0080e7          	jalr	2000(ra) # 80003184 <_ZN5RiscV23executeSemSignalSyscallEv>
    800039bc:	f55ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    800039c0:	00000097          	auipc	ra,0x0
    800039c4:	80c080e7          	jalr	-2036(ra) # 800031cc <_ZN5RiscV23executeTimeSleepSyscallEv>
    800039c8:	f49ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    800039cc:	00000097          	auipc	ra,0x0
    800039d0:	878080e7          	jalr	-1928(ra) # 80003244 <_ZN5RiscV18executeGetcSyscallEv>
    800039d4:	f3dff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    800039d8:	fffff097          	auipc	ra,0xfffff
    800039dc:	1fc080e7          	jalr	508(ra) # 80002bd4 <_ZN5RiscV18executePutcSyscallEv>
    800039e0:	f31ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    800039e4:	00000097          	auipc	ra,0x0
    800039e8:	8f8080e7          	jalr	-1800(ra) # 800032dc <_ZN5RiscV22executePutcUtilSyscallEv>
    800039ec:	f25ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    800039f0:	00000097          	auipc	ra,0x0
    800039f4:	920080e7          	jalr	-1760(ra) # 80003310 <_ZN5RiscV24executeThreadFreeSyscallEv>
    800039f8:	f19ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    800039fc:	00000097          	auipc	ra,0x0
    80003a00:	97c080e7          	jalr	-1668(ra) # 80003378 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80003a04:	f0dff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80003a08:	00010793          	mv	a5,sp
    80003a0c:	00007717          	auipc	a4,0x7
    80003a10:	5bc73703          	ld	a4,1468(a4) # 8000afc8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003a14:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80003a18:	00000097          	auipc	ra,0x0
    80003a1c:	9bc080e7          	jalr	-1604(ra) # 800033d4 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80003a20:	00000097          	auipc	ra,0x0
    80003a24:	bd4080e7          	jalr	-1068(ra) # 800035f4 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80003a28:	ee9ff06f          	j	80003910 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003a2c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003a30:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003a34:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003a38:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80003a3c:	00200793          	li	a5,2
    80003a40:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80003a44:	00007717          	auipc	a4,0x7
    80003a48:	7f470713          	addi	a4,a4,2036 # 8000b238 <_ZN5RiscV16userMainFinishedE>
    80003a4c:	00873783          	ld	a5,8(a4)
    80003a50:	00178793          	addi	a5,a5,1
    80003a54:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80003a58:	00000097          	auipc	ra,0x0
    80003a5c:	7d0080e7          	jalr	2000(ra) # 80004228 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80003a60:	00007717          	auipc	a4,0x7
    80003a64:	53073703          	ld	a4,1328(a4) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003a68:	00073783          	ld	a5,0(a4)
    80003a6c:	00178793          	addi	a5,a5,1
    80003a70:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80003a74:	00007717          	auipc	a4,0x7
    80003a78:	5ac73703          	ld	a4,1452(a4) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003a7c:	00073703          	ld	a4,0(a4)
    80003a80:	03073683          	ld	a3,48(a4)
    80003a84:	00d7fc63          	bgeu	a5,a3,80003a9c <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    80003a88:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003a8c:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003a90:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003a94:	14179073          	csrw	sepc,a5
}
    80003a98:	e95ff06f          	j	8000392c <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    80003a9c:	00007797          	auipc	a5,0x7
    80003aa0:	4f47b783          	ld	a5,1268(a5) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003aa4:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80003aa8:	00100793          	li	a5,1
    80003aac:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80003ab0:	ffffe097          	auipc	ra,0xffffe
    80003ab4:	550080e7          	jalr	1360(ra) # 80002000 <_ZN3TCB8dispatchEv>
    80003ab8:	fd1ff06f          	j	80003a88 <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003abc:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003ac0:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003ac4:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003ac8:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    80003acc:	00007797          	auipc	a5,0x7
    80003ad0:	4ac7b783          	ld	a5,1196(a5) # 8000af78 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003ad4:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003ad8:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003adc:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003ae0:	00058793          	mv	a5,a1
        if(status & 1UL)
    80003ae4:	0017f793          	andi	a5,a5,1
    80003ae8:	02078863          	beqz	a5,80003b18 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    80003aec:	00007797          	auipc	a5,0x7
    80003af0:	4cc7b783          	ld	a5,1228(a5) # 8000afb8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003af4:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80003af8:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80003afc:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80003b00:	00058513          	mv	a0,a1
    80003b04:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80003b08:	00007797          	auipc	a5,0x7
    80003b0c:	4b87b783          	ld	a5,1208(a5) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003b10:	0007b783          	ld	a5,0(a5)
    80003b14:	02079463          	bnez	a5,80003b3c <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    80003b18:	00002097          	auipc	ra,0x2
    80003b1c:	10c080e7          	jalr	268(ra) # 80005c24 <plic_claim>
    80003b20:	00002097          	auipc	ra,0x2
    80003b24:	13c080e7          	jalr	316(ra) # 80005c5c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80003b28:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003b2c:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003b30:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003b34:	14179073          	csrw	sepc,a5
}
    80003b38:	df5ff06f          	j	8000392c <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    80003b3c:	fff78793          	addi	a5,a5,-1
    80003b40:	00007717          	auipc	a4,0x7
    80003b44:	48073703          	ld	a4,1152(a4) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003b48:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80003b4c:	fffff097          	auipc	ra,0xfffff
    80003b50:	c48080e7          	jalr	-952(ra) # 80002794 <_ZN11ConsoleUtil8putInputEc>
    80003b54:	fc5ff06f          	j	80003b18 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    80003b58:	00007797          	auipc	a5,0x7
    80003b5c:	4c87b783          	ld	a5,1224(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003b60:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003b64:	00200713          	li	a4,2
    80003b68:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80003b6c:	00004517          	auipc	a0,0x4
    80003b70:	5cc50513          	addi	a0,a0,1484 # 80008138 <CONSOLE_STATUS+0x128>
    80003b74:	fffff097          	auipc	ra,0xfffff
    80003b78:	e18080e7          	jalr	-488(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003b7c:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003b80:	00000613          	li	a2,0
    80003b84:	01000593          	li	a1,16
    80003b88:	0005051b          	sext.w	a0,a0
    80003b8c:	fffff097          	auipc	ra,0xfffff
    80003b90:	e44080e7          	jalr	-444(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003b94:	00004517          	auipc	a0,0x4
    80003b98:	58450513          	addi	a0,a0,1412 # 80008118 <CONSOLE_STATUS+0x108>
    80003b9c:	fffff097          	auipc	ra,0xfffff
    80003ba0:	df0080e7          	jalr	-528(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80003ba4:	00004517          	auipc	a0,0x4
    80003ba8:	59c50513          	addi	a0,a0,1436 # 80008140 <CONSOLE_STATUS+0x130>
    80003bac:	fffff097          	auipc	ra,0xfffff
    80003bb0:	de0080e7          	jalr	-544(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003bb4:	ffffe097          	auipc	ra,0xffffe
    80003bb8:	44c080e7          	jalr	1100(ra) # 80002000 <_ZN3TCB8dispatchEv>
    80003bbc:	d71ff06f          	j	8000392c <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

0000000080003bc0 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:
void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    80003bc0:	fd010113          	addi	sp,sp,-48
    80003bc4:	02113423          	sd	ra,40(sp)
    80003bc8:	02813023          	sd	s0,32(sp)
    80003bcc:	00913c23          	sd	s1,24(sp)
    80003bd0:	01213823          	sd	s2,16(sp)
    80003bd4:	01313423          	sd	s3,8(sp)
    80003bd8:	01413023          	sd	s4,0(sp)
    80003bdc:	03010413          	addi	s0,sp,48
    80003be0:	00050913          	mv	s2,a0
    80003be4:	00058493          	mv	s1,a1
    80003be8:	00060993          	mv	s3,a2
    if(start_routine) {
    80003bec:	02058e63          	beqz	a1,80003c28 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x68>
        istack = (uint64) kmalloc(DEFAULT_STACK_SIZE);
    80003bf0:	00001537          	lui	a0,0x1
    80003bf4:	00001097          	auipc	ra,0x1
    80003bf8:	87c080e7          	jalr	-1924(ra) # 80004470 <_Z7kmallocm>
    80003bfc:	00050a13          	mv	s4,a0
        if(istack == 0) {
    80003c00:	02050063          	beqz	a0,80003c20 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
        handlePageFault(kPMT, istack, 0x17);
    80003c04:	01700613          	li	a2,23
    80003c08:	00050593          	mv	a1,a0
    80003c0c:	00007517          	auipc	a0,0x7
    80003c10:	63c53503          	ld	a0,1596(a0) # 8000b248 <_ZN5RiscV4kPMTE>
    80003c14:	00000097          	auipc	ra,0x0
    80003c18:	900080e7          	jalr	-1792(ra) # 80003514 <_ZN5RiscV15handlePageFaultEPvmm>
    80003c1c:	0100006f          	j	80003c2c <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x6c>
            *handle = nullptr;
    80003c20:	00093023          	sd	zero,0(s2)
            return;
    80003c24:	0200006f          	j	80003c44 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x84>
    uint64 istack = 0;
    80003c28:	00000a13          	li	s4,0
    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80003c2c:	000a0893          	mv	a7,s4
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80003c30:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80003c34:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80003c38:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80003c3c:	01100513          	li	a0,17
    asm("ecall");
    80003c40:	00000073          	ecall
}
    80003c44:	02813083          	ld	ra,40(sp)
    80003c48:	02013403          	ld	s0,32(sp)
    80003c4c:	01813483          	ld	s1,24(sp)
    80003c50:	01013903          	ld	s2,16(sp)
    80003c54:	00813983          	ld	s3,8(sp)
    80003c58:	00013a03          	ld	s4,0(sp)
    80003c5c:	03010113          	addi	sp,sp,48
    80003c60:	00008067          	ret

0000000080003c64 <_ZN5RiscV12buildSectionEPvmmm>:
void RiscV::buildSection(void *PMT, uint64 start, uint64 end, uint64 mask) {
    80003c64:	fd010113          	addi	sp,sp,-48
    80003c68:	02113423          	sd	ra,40(sp)
    80003c6c:	02813023          	sd	s0,32(sp)
    80003c70:	00913c23          	sd	s1,24(sp)
    80003c74:	01213823          	sd	s2,16(sp)
    80003c78:	01313423          	sd	s3,8(sp)
    80003c7c:	01413023          	sd	s4,0(sp)
    80003c80:	03010413          	addi	s0,sp,48
    80003c84:	00050a13          	mv	s4,a0
    80003c88:	00058493          	mv	s1,a1
    80003c8c:	00060913          	mv	s2,a2
    80003c90:	00068993          	mv	s3,a3
    for(uint64 i=start;i< end;i+=0x1000) {
    80003c94:	0324f263          	bgeu	s1,s2,80003cb8 <_ZN5RiscV12buildSectionEPvmmm+0x54>
        handlePageFault(PMT,i, mask);
    80003c98:	00098613          	mv	a2,s3
    80003c9c:	00048593          	mv	a1,s1
    80003ca0:	000a0513          	mv	a0,s4
    80003ca4:	00000097          	auipc	ra,0x0
    80003ca8:	870080e7          	jalr	-1936(ra) # 80003514 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=start;i< end;i+=0x1000) {
    80003cac:	000017b7          	lui	a5,0x1
    80003cb0:	00f484b3          	add	s1,s1,a5
    80003cb4:	fe1ff06f          	j	80003c94 <_ZN5RiscV12buildSectionEPvmmm+0x30>
}
    80003cb8:	02813083          	ld	ra,40(sp)
    80003cbc:	02013403          	ld	s0,32(sp)
    80003cc0:	01813483          	ld	s1,24(sp)
    80003cc4:	01013903          	ld	s2,16(sp)
    80003cc8:	00813983          	ld	s3,8(sp)
    80003ccc:	00013a03          	ld	s4,0(sp)
    80003cd0:	03010113          	addi	sp,sp,48
    80003cd4:	00008067          	ret

0000000080003cd8 <_ZN5RiscV19mapConsoleRegistersEPv>:

void RiscV::mapConsoleRegisters(void *PMT) {
    80003cd8:	fe010113          	addi	sp,sp,-32
    80003cdc:	00113c23          	sd	ra,24(sp)
    80003ce0:	00813823          	sd	s0,16(sp)
    80003ce4:	00913423          	sd	s1,8(sp)
    80003ce8:	02010413          	addi	s0,sp,32
    80003cec:	00050493          	mv	s1,a0
    handlePageFault(PMT, (uint64)CONSOLE_RX_DATA,0xf);
    80003cf0:	00f00613          	li	a2,15
    80003cf4:	00007797          	auipc	a5,0x7
    80003cf8:	27c7b783          	ld	a5,636(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003cfc:	0007b583          	ld	a1,0(a5)
    80003d00:	00000097          	auipc	ra,0x0
    80003d04:	814080e7          	jalr	-2028(ra) # 80003514 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_TX_DATA,0xf);
    80003d08:	00f00613          	li	a2,15
    80003d0c:	00007797          	auipc	a5,0x7
    80003d10:	2ac7b783          	ld	a5,684(a5) # 8000afb8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003d14:	0007b583          	ld	a1,0(a5)
    80003d18:	00048513          	mv	a0,s1
    80003d1c:	fffff097          	auipc	ra,0xfffff
    80003d20:	7f8080e7          	jalr	2040(ra) # 80003514 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_STATUS,0xf);
    80003d24:	00f00613          	li	a2,15
    80003d28:	00007797          	auipc	a5,0x7
    80003d2c:	2507b783          	ld	a5,592(a5) # 8000af78 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003d30:	0007b583          	ld	a1,0(a5)
    80003d34:	00048513          	mv	a0,s1
    80003d38:	fffff097          	auipc	ra,0xfffff
    80003d3c:	7dc080e7          	jalr	2012(ra) # 80003514 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)0xc201004,0xf);
    80003d40:	00f00613          	li	a2,15
    80003d44:	0c2015b7          	lui	a1,0xc201
    80003d48:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    80003d4c:	00048513          	mv	a0,s1
    80003d50:	fffff097          	auipc	ra,0xfffff
    80003d54:	7c4080e7          	jalr	1988(ra) # 80003514 <_ZN5RiscV15handlePageFaultEPvmm>
    80003d58:	01813083          	ld	ra,24(sp)
    80003d5c:	01013403          	ld	s0,16(sp)
    80003d60:	00813483          	ld	s1,8(sp)
    80003d64:	02010113          	addi	sp,sp,32
    80003d68:	00008067          	ret

0000000080003d6c <_ZN5RiscV14buildKernelPMTEv>:
void RiscV::buildKernelPMT() {
    80003d6c:	fd010113          	addi	sp,sp,-48
    80003d70:	02113423          	sd	ra,40(sp)
    80003d74:	02813023          	sd	s0,32(sp)
    80003d78:	00913c23          	sd	s1,24(sp)
    80003d7c:	01213823          	sd	s2,16(sp)
    80003d80:	01313423          	sd	s3,8(sp)
    80003d84:	01413023          	sd	s4,0(sp)
    80003d88:	03010413          	addi	s0,sp,48
    RiscV::kPMT = RiscV::getPMT();
    80003d8c:	fffff097          	auipc	ra,0xfffff
    80003d90:	73c080e7          	jalr	1852(ra) # 800034c8 <_ZN5RiscV6getPMTEv>
    80003d94:	00007497          	auipc	s1,0x7
    80003d98:	4a448493          	addi	s1,s1,1188 # 8000b238 <_ZN5RiscV16userMainFinishedE>
    80003d9c:	00a4b823          	sd	a0,16(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003da0:	00007797          	auipc	a5,0x7
    80003da4:	2007b783          	ld	a5,512(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003da8:	0007b903          	ld	s2,0(a5)
    80003dac:	00c91913          	slli	s2,s2,0xc
    80003db0:	00007797          	auipc	a5,0x7
    80003db4:	2007b783          	ld	a5,512(a5) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003db8:	0007b783          	ld	a5,0(a5)
    80003dbc:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(kPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80003dc0:	00007a17          	auipc	s4,0x7
    80003dc4:	1c8a3a03          	ld	s4,456(s4) # 8000af88 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003dc8:	00b00693          	li	a3,11
    80003dcc:	000a0613          	mv	a2,s4
    80003dd0:	00100593          	li	a1,1
    80003dd4:	01f59593          	slli	a1,a1,0x1f
    80003dd8:	00000097          	auipc	ra,0x0
    80003ddc:	e8c080e7          	jalr	-372(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80003de0:	00007997          	auipc	s3,0x7
    80003de4:	2489b983          	ld	s3,584(s3) # 8000b028 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003de8:	00700693          	li	a3,7
    80003dec:	00098613          	mv	a2,s3
    80003df0:	000a0593          	mv	a1,s4
    80003df4:	0104b503          	ld	a0,16(s1)
    80003df8:	00000097          	auipc	ra,0x0
    80003dfc:	e6c080e7          	jalr	-404(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80003e00:	00007a17          	auipc	s4,0x7
    80003e04:	248a3a03          	ld	s4,584(s4) # 8000b048 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80003e08:	01b00693          	li	a3,27
    80003e0c:	000a0613          	mv	a2,s4
    80003e10:	00098593          	mv	a1,s3
    80003e14:	0104b503          	ld	a0,16(s1)
    80003e18:	00000097          	auipc	ra,0x0
    80003e1c:	e4c080e7          	jalr	-436(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80003e20:	00007997          	auipc	s3,0x7
    80003e24:	1789b983          	ld	s3,376(s3) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003e28:	01700693          	li	a3,23
    80003e2c:	00098613          	mv	a2,s3
    80003e30:	000a0593          	mv	a1,s4
    80003e34:	0104b503          	ld	a0,16(s1)
    80003e38:	00000097          	auipc	ra,0x0
    80003e3c:	e2c080e7          	jalr	-468(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_END, bEnd, 0x7);
    80003e40:	00700693          	li	a3,7
    80003e44:	00090613          	mv	a2,s2
    80003e48:	00098593          	mv	a1,s3
    80003e4c:	0104b503          	ld	a0,16(s1)
    80003e50:	00000097          	auipc	ra,0x0
    80003e54:	e14080e7          	jalr	-492(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, bEnd, HEAP_END, 0x17);
    80003e58:	01700693          	li	a3,23
    80003e5c:	00007797          	auipc	a5,0x7
    80003e60:	1dc7b783          	ld	a5,476(a5) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80003e64:	0007b603          	ld	a2,0(a5)
    80003e68:	00090593          	mv	a1,s2
    80003e6c:	0104b503          	ld	a0,16(s1)
    80003e70:	00000097          	auipc	ra,0x0
    80003e74:	df4080e7          	jalr	-524(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(kPMT);
    80003e78:	0104b503          	ld	a0,16(s1)
    80003e7c:	00000097          	auipc	ra,0x0
    80003e80:	e5c080e7          	jalr	-420(ra) # 80003cd8 <_ZN5RiscV19mapConsoleRegistersEPv>
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003e84:	000407b7          	lui	a5,0x40
    80003e88:	1007a073          	csrs	sstatus,a5
}
    80003e8c:	02813083          	ld	ra,40(sp)
    80003e90:	02013403          	ld	s0,32(sp)
    80003e94:	01813483          	ld	s1,24(sp)
    80003e98:	01013903          	ld	s2,16(sp)
    80003e9c:	00813983          	ld	s3,8(sp)
    80003ea0:	00013a03          	ld	s4,0(sp)
    80003ea4:	03010113          	addi	sp,sp,48
    80003ea8:	00008067          	ret

0000000080003eac <_ZN5RiscV12buildUserPMTEv>:
void RiscV::buildUserPMT() {
    80003eac:	fd010113          	addi	sp,sp,-48
    80003eb0:	02113423          	sd	ra,40(sp)
    80003eb4:	02813023          	sd	s0,32(sp)
    80003eb8:	00913c23          	sd	s1,24(sp)
    80003ebc:	01213823          	sd	s2,16(sp)
    80003ec0:	01313423          	sd	s3,8(sp)
    80003ec4:	01413023          	sd	s4,0(sp)
    80003ec8:	03010413          	addi	s0,sp,48
    RiscV::uPMT = RiscV::getPMT();
    80003ecc:	fffff097          	auipc	ra,0xfffff
    80003ed0:	5fc080e7          	jalr	1532(ra) # 800034c8 <_ZN5RiscV6getPMTEv>
    80003ed4:	00007497          	auipc	s1,0x7
    80003ed8:	36448493          	addi	s1,s1,868 # 8000b238 <_ZN5RiscV16userMainFinishedE>
    80003edc:	00a4bc23          	sd	a0,24(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003ee0:	00007797          	auipc	a5,0x7
    80003ee4:	0c07b783          	ld	a5,192(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003ee8:	0007b903          	ld	s2,0(a5)
    80003eec:	00c91913          	slli	s2,s2,0xc
    80003ef0:	00007797          	auipc	a5,0x7
    80003ef4:	0c07b783          	ld	a5,192(a5) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003ef8:	0007b783          	ld	a5,0(a5)
    80003efc:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(uPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80003f00:	00007a17          	auipc	s4,0x7
    80003f04:	088a3a03          	ld	s4,136(s4) # 8000af88 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003f08:	00b00693          	li	a3,11
    80003f0c:	000a0613          	mv	a2,s4
    80003f10:	00100593          	li	a1,1
    80003f14:	01f59593          	slli	a1,a1,0x1f
    80003f18:	00000097          	auipc	ra,0x0
    80003f1c:	d4c080e7          	jalr	-692(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80003f20:	00007997          	auipc	s3,0x7
    80003f24:	1089b983          	ld	s3,264(s3) # 8000b028 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003f28:	00700693          	li	a3,7
    80003f2c:	00098613          	mv	a2,s3
    80003f30:	000a0593          	mv	a1,s4
    80003f34:	0184b503          	ld	a0,24(s1)
    80003f38:	00000097          	auipc	ra,0x0
    80003f3c:	d2c080e7          	jalr	-724(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80003f40:	00007a17          	auipc	s4,0x7
    80003f44:	108a3a03          	ld	s4,264(s4) # 8000b048 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80003f48:	01b00693          	li	a3,27
    80003f4c:	000a0613          	mv	a2,s4
    80003f50:	00098593          	mv	a1,s3
    80003f54:	0184b503          	ld	a0,24(s1)
    80003f58:	00000097          	auipc	ra,0x0
    80003f5c:	d0c080e7          	jalr	-756(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80003f60:	00007997          	auipc	s3,0x7
    80003f64:	0389b983          	ld	s3,56(s3) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003f68:	01700693          	li	a3,23
    80003f6c:	00098613          	mv	a2,s3
    80003f70:	000a0593          	mv	a1,s4
    80003f74:	0184b503          	ld	a0,24(s1)
    80003f78:	00000097          	auipc	ra,0x0
    80003f7c:	cec080e7          	jalr	-788(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_END, bEnd, 0x7);
    80003f80:	00700693          	li	a3,7
    80003f84:	00090613          	mv	a2,s2
    80003f88:	00098593          	mv	a1,s3
    80003f8c:	0184b503          	ld	a0,24(s1)
    80003f90:	00000097          	auipc	ra,0x0
    80003f94:	cd4080e7          	jalr	-812(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, bEnd, HEAP_END, 0x17);
    80003f98:	01700693          	li	a3,23
    80003f9c:	00007797          	auipc	a5,0x7
    80003fa0:	09c7b783          	ld	a5,156(a5) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80003fa4:	0007b603          	ld	a2,0(a5)
    80003fa8:	00090593          	mv	a1,s2
    80003fac:	0184b503          	ld	a0,24(s1)
    80003fb0:	00000097          	auipc	ra,0x0
    80003fb4:	cb4080e7          	jalr	-844(ra) # 80003c64 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(uPMT);
    80003fb8:	0184b503          	ld	a0,24(s1)
    80003fbc:	00000097          	auipc	ra,0x0
    80003fc0:	d1c080e7          	jalr	-740(ra) # 80003cd8 <_ZN5RiscV19mapConsoleRegistersEPv>
    80003fc4:	000407b7          	lui	a5,0x40
    80003fc8:	1007a073          	csrs	sstatus,a5
}
    80003fcc:	02813083          	ld	ra,40(sp)
    80003fd0:	02013403          	ld	s0,32(sp)
    80003fd4:	01813483          	ld	s1,24(sp)
    80003fd8:	01013903          	ld	s2,16(sp)
    80003fdc:	00813983          	ld	s3,8(sp)
    80003fe0:	00013a03          	ld	s4,0(sp)
    80003fe4:	03010113          	addi	sp,sp,48
    80003fe8:	00008067          	ret

0000000080003fec <_ZN5RiscV10initializeEv>:
void RiscV::initialize(){
    80003fec:	ff010113          	addi	sp,sp,-16
    80003ff0:	00113423          	sd	ra,8(sp)
    80003ff4:	00813023          	sd	s0,0(sp)
    80003ff8:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003ffc:	00007797          	auipc	a5,0x7
    80004000:	ffc7b783          	ld	a5,-4(a5) # 8000aff8 <_GLOBAL_OFFSET_TABLE_+0x90>
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80004004:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80004008:	00007797          	auipc	a5,0x7
    8000400c:	f787b783          	ld	a5,-136(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004010:	0007b503          	ld	a0,0(a5)
    80004014:	00c55513          	srli	a0,a0,0xc
    80004018:	00250513          	addi	a0,a0,2
    8000401c:	000015b7          	lui	a1,0x1
    80004020:	00c51513          	slli	a0,a0,0xc
    80004024:	00000097          	auipc	ra,0x0
    80004028:	32c080e7          	jalr	812(ra) # 80004350 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    8000402c:	ffffe097          	auipc	ra,0xffffe
    80004030:	1d8080e7          	jalr	472(ra) # 80002204 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80004034:	00000097          	auipc	ra,0x0
    80004038:	108080e7          	jalr	264(ra) # 8000413c <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    8000403c:	ffffe097          	auipc	ra,0xffffe
    80004040:	074080e7          	jalr	116(ra) # 800020b0 <_ZN3TCB10initializeEv>
    SCB::initialize();
    80004044:	ffffd097          	auipc	ra,0xffffd
    80004048:	5d8080e7          	jalr	1496(ra) # 8000161c <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    8000404c:	ffffe097          	auipc	ra,0xffffe
    80004050:	664080e7          	jalr	1636(ra) # 800026b0 <_ZN11ConsoleUtil10initializeEv>
    RiscV::buildKernelPMT();
    80004054:	00000097          	auipc	ra,0x0
    80004058:	d18080e7          	jalr	-744(ra) # 80003d6c <_ZN5RiscV14buildKernelPMTEv>
    RiscV::buildUserPMT();
    8000405c:	00000097          	auipc	ra,0x0
    80004060:	e50080e7          	jalr	-432(ra) # 80003eac <_ZN5RiscV12buildUserPMTEv>
    RiscV::initialized = true;
    80004064:	00007797          	auipc	a5,0x7
    80004068:	1d478793          	addi	a5,a5,468 # 8000b238 <_ZN5RiscV16userMainFinishedE>
    8000406c:	00100713          	li	a4,1
    80004070:	02e78023          	sb	a4,32(a5)
    RiscV::startVirtualMemory(RiscV::kPMT);
    80004074:	0107b783          	ld	a5,16(a5)
inline void RiscV::disableTimerInterrupts(){
    RiscV::mc_sie(SIP_SSIE);
}

inline void RiscV::startVirtualMemory(void* PMT) {
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80004078:	00c7d793          	srli	a5,a5,0xc
    8000407c:	fff00713          	li	a4,-1
    80004080:	03f71713          	slli	a4,a4,0x3f
    80004084:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80004088:	18079073          	csrw	satp,a5
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    8000408c:	00200793          	li	a5,2
    80004090:	1047a073          	csrs	sie,a5
    80004094:	20000713          	li	a4,512
    80004098:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    8000409c:	1007a073          	csrs	sstatus,a5
}
    800040a0:	00813083          	ld	ra,8(sp)
    800040a4:	00013403          	ld	s0,0(sp)
    800040a8:	01010113          	addi	sp,sp,16
    800040ac:	00008067          	ret

00000000800040b0 <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/kernel/utility.hpp"

char* strcpy(const char* src, char* dst){
    800040b0:	ff010113          	addi	sp,sp,-16
    800040b4:	00813423          	sd	s0,8(sp)
    800040b8:	01010413          	addi	s0,sp,16
    800040bc:	00050793          	mv	a5,a0
    800040c0:	00058513          	mv	a0,a1
    while(*src != '\0')
    800040c4:	0007c703          	lbu	a4,0(a5)
    800040c8:	00070a63          	beqz	a4,800040dc <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    800040cc:	00178793          	addi	a5,a5,1
    800040d0:	00e50023          	sb	a4,0(a0)
    800040d4:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    800040d8:	fedff06f          	j	800040c4 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    800040dc:	00e50023          	sb	a4,0(a0)
    return dst;
}
    800040e0:	00813403          	ld	s0,8(sp)
    800040e4:	01010113          	addi	sp,sp,16
    800040e8:	00008067          	ret

00000000800040ec <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    800040ec:	fe010113          	addi	sp,sp,-32
    800040f0:	00113c23          	sd	ra,24(sp)
    800040f4:	00813823          	sd	s0,16(sp)
    800040f8:	00913423          	sd	s1,8(sp)
    800040fc:	02010413          	addi	s0,sp,32
    80004100:	00050493          	mv	s1,a0
    80004104:	00058513          	mv	a0,a1
    char *dest = dst;
    80004108:	00048593          	mv	a1,s1
    while(*dest != '\0')
    8000410c:	0005c783          	lbu	a5,0(a1) # 1000 <_entry-0x7ffff000>
    80004110:	00078663          	beqz	a5,8000411c <_Z6strcatPcPKc+0x30>
        dest++;
    80004114:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004118:	ff5ff06f          	j	8000410c <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    8000411c:	00000097          	auipc	ra,0x0
    80004120:	f94080e7          	jalr	-108(ra) # 800040b0 <_Z6strcpyPKcPc>
    return dst;
    80004124:	00048513          	mv	a0,s1
    80004128:	01813083          	ld	ra,24(sp)
    8000412c:	01013403          	ld	s0,16(sp)
    80004130:	00813483          	ld	s1,8(sp)
    80004134:	02010113          	addi	sp,sp,32
    80004138:	00008067          	ret

000000008000413c <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    8000413c:	ff010113          	addi	sp,sp,-16
    80004140:	00813423          	sd	s0,8(sp)
    80004144:	01010413          	addi	s0,sp,16
}
    80004148:	00813403          	ld	s0,8(sp)
    8000414c:	01010113          	addi	sp,sp,16
    80004150:	00008067          	ret

0000000080004154 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004154:	ff010113          	addi	sp,sp,-16
    80004158:	00813423          	sd	s0,8(sp)
    8000415c:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004160:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004164:	00007797          	auipc	a5,0x7
    80004168:	0fc7b783          	ld	a5,252(a5) # 8000b260 <_ZN9Scheduler9readyHeadE>
    8000416c:	02078263          	beqz	a5,80004190 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004170:	00007797          	auipc	a5,0x7
    80004174:	0f87b783          	ld	a5,248(a5) # 8000b268 <_ZN9Scheduler9readyTailE>
    80004178:	04a7b423          	sd	a0,72(a5)
    8000417c:	00007797          	auipc	a5,0x7
    80004180:	0ea7b623          	sd	a0,236(a5) # 8000b268 <_ZN9Scheduler9readyTailE>
}
    80004184:	00813403          	ld	s0,8(sp)
    80004188:	01010113          	addi	sp,sp,16
    8000418c:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004190:	00007797          	auipc	a5,0x7
    80004194:	0ca7b823          	sd	a0,208(a5) # 8000b260 <_ZN9Scheduler9readyHeadE>
    80004198:	fe5ff06f          	j	8000417c <_ZN9Scheduler3putEP3TCB+0x28>

000000008000419c <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    8000419c:	ff010113          	addi	sp,sp,-16
    800041a0:	00813423          	sd	s0,8(sp)
    800041a4:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    800041a8:	00007517          	auipc	a0,0x7
    800041ac:	0b853503          	ld	a0,184(a0) # 8000b260 <_ZN9Scheduler9readyHeadE>
    800041b0:	00050a63          	beqz	a0,800041c4 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    800041b4:	04853783          	ld	a5,72(a0)
    800041b8:	00007717          	auipc	a4,0x7
    800041bc:	0af73423          	sd	a5,168(a4) # 8000b260 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    800041c0:	04053423          	sd	zero,72(a0)
    return tmp;
}
    800041c4:	00813403          	ld	s0,8(sp)
    800041c8:	01010113          	addi	sp,sp,16
    800041cc:	00008067          	ret

00000000800041d0 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    800041d0:	ff010113          	addi	sp,sp,-16
    800041d4:	00813423          	sd	s0,8(sp)
    800041d8:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    800041dc:	00007797          	auipc	a5,0x7
    800041e0:	0947b783          	ld	a5,148(a5) # 8000b270 <_ZN9Scheduler12sleepingHeadE>
    800041e4:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800041e8:	00078e63          	beqz	a5,80004204 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    800041ec:	0587b683          	ld	a3,88(a5)
    800041f0:	05853703          	ld	a4,88(a0)
    800041f4:	00d76863          	bltu	a4,a3,80004204 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800041f8:	00078613          	mv	a2,a5
    800041fc:	0487b783          	ld	a5,72(a5)
    80004200:	fe9ff06f          	j	800041e8 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004204:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004208:	00060a63          	beqz	a2,8000421c <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    8000420c:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    80004210:	00813403          	ld	s0,8(sp)
    80004214:	01010113          	addi	sp,sp,16
    80004218:	00008067          	ret
        sleepingHead = t;
    8000421c:	00007797          	auipc	a5,0x7
    80004220:	04a7ba23          	sd	a0,84(a5) # 8000b270 <_ZN9Scheduler12sleepingHeadE>
}
    80004224:	fedff06f          	j	80004210 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004228 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004228:	fe010113          	addi	sp,sp,-32
    8000422c:	00113c23          	sd	ra,24(sp)
    80004230:	00813823          	sd	s0,16(sp)
    80004234:	00913423          	sd	s1,8(sp)
    80004238:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    8000423c:	00007497          	auipc	s1,0x7
    80004240:	0344b483          	ld	s1,52(s1) # 8000b270 <_ZN9Scheduler12sleepingHeadE>
    80004244:	02048c63          	beqz	s1,8000427c <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004248:	0584b703          	ld	a4,88(s1)
    8000424c:	00007797          	auipc	a5,0x7
    80004250:	df47b783          	ld	a5,-524(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80004254:	0007b783          	ld	a5,0(a5)
    80004258:	02e7e263          	bltu	a5,a4,8000427c <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    8000425c:	0484b783          	ld	a5,72(s1)
    80004260:	00007717          	auipc	a4,0x7
    80004264:	00f73823          	sd	a5,16(a4) # 8000b270 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004268:	00048513          	mv	a0,s1
    8000426c:	00000097          	auipc	ra,0x0
    80004270:	ee8080e7          	jalr	-280(ra) # 80004154 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004274:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004278:	fc5ff06f          	j	8000423c <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    8000427c:	01813083          	ld	ra,24(sp)
    80004280:	01013403          	ld	s0,16(sp)
    80004284:	00813483          	ld	s1,8(sp)
    80004288:	02010113          	addi	sp,sp,32
    8000428c:	00008067          	ret

0000000080004290 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004290:	fe010113          	addi	sp,sp,-32
    80004294:	00113c23          	sd	ra,24(sp)
    80004298:	00813823          	sd	s0,16(sp)
    8000429c:	00913423          	sd	s1,8(sp)
    800042a0:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    800042a4:	00007497          	auipc	s1,0x7
    800042a8:	fbc4b483          	ld	s1,-68(s1) # 8000b260 <_ZN9Scheduler9readyHeadE>
    while(iter){
    800042ac:	02048863          	beqz	s1,800042dc <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    800042b0:	00000613          	li	a2,0
    800042b4:	01000593          	li	a1,16
    800042b8:	0004851b          	sext.w	a0,s1
    800042bc:	ffffe097          	auipc	ra,0xffffe
    800042c0:	714080e7          	jalr	1812(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800042c4:	00004517          	auipc	a0,0x4
    800042c8:	e5450513          	addi	a0,a0,-428 # 80008118 <CONSOLE_STATUS+0x108>
    800042cc:	ffffe097          	auipc	ra,0xffffe
    800042d0:	6c0080e7          	jalr	1728(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    800042d4:	0484b483          	ld	s1,72(s1)
    while(iter){
    800042d8:	fd5ff06f          	j	800042ac <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    800042dc:	01813083          	ld	ra,24(sp)
    800042e0:	01013403          	ld	s0,16(sp)
    800042e4:	00813483          	ld	s1,8(sp)
    800042e8:	02010113          	addi	sp,sp,32
    800042ec:	00008067          	ret

00000000800042f0 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    800042f0:	fe010113          	addi	sp,sp,-32
    800042f4:	00113c23          	sd	ra,24(sp)
    800042f8:	00813823          	sd	s0,16(sp)
    800042fc:	00913423          	sd	s1,8(sp)
    80004300:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004304:	00007497          	auipc	s1,0x7
    80004308:	f6c4b483          	ld	s1,-148(s1) # 8000b270 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    8000430c:	02048863          	beqz	s1,8000433c <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004310:	00000613          	li	a2,0
    80004314:	01000593          	li	a1,16
    80004318:	0004851b          	sext.w	a0,s1
    8000431c:	0000b097          	auipc	ra,0xb
    80004320:	ae0080e7          	jalr	-1312(ra) # 8000edfc <_Z8printIntiii>
        printString("\n");
    80004324:	00004517          	auipc	a0,0x4
    80004328:	df450513          	addi	a0,a0,-524 # 80008118 <CONSOLE_STATUS+0x108>
    8000432c:	0000b097          	auipc	ra,0xb
    80004330:	938080e7          	jalr	-1736(ra) # 8000ec64 <_Z11printStringPKc>
        iter = iter->next;
    80004334:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004338:	fd5ff06f          	j	8000430c <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    8000433c:	01813083          	ld	ra,24(sp)
    80004340:	01013403          	ld	s0,16(sp)
    80004344:	00813483          	ld	s1,8(sp)
    80004348:	02010113          	addi	sp,sp,32
    8000434c:	00008067          	ret

0000000080004350 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/kernel/slab.hpp"

void kmem_init(void* space, int block_num){
    80004350:	ff010113          	addi	sp,sp,-16
    80004354:	00113423          	sd	ra,8(sp)
    80004358:	00813023          	sd	s0,0(sp)
    8000435c:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004360:	00001097          	auipc	ra,0x1
    80004364:	b58080e7          	jalr	-1192(ra) # 80004eb8 <_ZN13SlabAllocator10initializeEPvm>
}
    80004368:	00813083          	ld	ra,8(sp)
    8000436c:	00013403          	ld	s0,0(sp)
    80004370:	01010113          	addi	sp,sp,16
    80004374:	00008067          	ret

0000000080004378 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80004378:	ff010113          	addi	sp,sp,-16
    8000437c:	00113423          	sd	ra,8(sp)
    80004380:	00813023          	sd	s0,0(sp)
    80004384:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80004388:	00001097          	auipc	ra,0x1
    8000438c:	a20080e7          	jalr	-1504(ra) # 80004da8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004390:	00813083          	ld	ra,8(sp)
    80004394:	00013403          	ld	s0,0(sp)
    80004398:	01010113          	addi	sp,sp,16
    8000439c:	00008067          	ret

00000000800043a0 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    800043a0:	ff010113          	addi	sp,sp,-16
    800043a4:	00113423          	sd	ra,8(sp)
    800043a8:	00813023          	sd	s0,0(sp)
    800043ac:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    800043b0:	00000097          	auipc	ra,0x0
    800043b4:	7c8080e7          	jalr	1992(ra) # 80004b78 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800043b8:	00813083          	ld	ra,8(sp)
    800043bc:	00013403          	ld	s0,0(sp)
    800043c0:	01010113          	addi	sp,sp,16
    800043c4:	00008067          	ret

00000000800043c8 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    800043c8:	ff010113          	addi	sp,sp,-16
    800043cc:	00113423          	sd	ra,8(sp)
    800043d0:	00813023          	sd	s0,0(sp)
    800043d4:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    800043d8:	00001097          	auipc	ra,0x1
    800043dc:	d30080e7          	jalr	-720(ra) # 80005108 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    800043e0:	00813083          	ld	ra,8(sp)
    800043e4:	00013403          	ld	s0,0(sp)
    800043e8:	01010113          	addi	sp,sp,16
    800043ec:	00008067          	ret

00000000800043f0 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    800043f0:	fe010113          	addi	sp,sp,-32
    800043f4:	00113c23          	sd	ra,24(sp)
    800043f8:	00813823          	sd	s0,16(sp)
    800043fc:	02010413          	addi	s0,sp,32
    80004400:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80004404:	fe840513          	addi	a0,s0,-24
    80004408:	00001097          	auipc	ra,0x1
    8000440c:	e60080e7          	jalr	-416(ra) # 80005268 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    80004410:	01813083          	ld	ra,24(sp)
    80004414:	01013403          	ld	s0,16(sp)
    80004418:	02010113          	addi	sp,sp,32
    8000441c:	00008067          	ret

0000000080004420 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80004420:	ff010113          	addi	sp,sp,-16
    80004424:	00113423          	sd	ra,8(sp)
    80004428:	00813023          	sd	s0,0(sp)
    8000442c:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80004430:	00000097          	auipc	ra,0x0
    80004434:	27c080e7          	jalr	636(ra) # 800046ac <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80004438:	00813083          	ld	ra,8(sp)
    8000443c:	00013403          	ld	s0,0(sp)
    80004440:	01010113          	addi	sp,sp,16
    80004444:	00008067          	ret

0000000080004448 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80004448:	ff010113          	addi	sp,sp,-16
    8000444c:	00113423          	sd	ra,8(sp)
    80004450:	00813023          	sd	s0,0(sp)
    80004454:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80004458:	00000097          	auipc	ra,0x0
    8000445c:	090080e7          	jalr	144(ra) # 800044e8 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80004460:	00813083          	ld	ra,8(sp)
    80004464:	00013403          	ld	s0,0(sp)
    80004468:	01010113          	addi	sp,sp,16
    8000446c:	00008067          	ret

0000000080004470 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80004470:	ff010113          	addi	sp,sp,-16
    80004474:	00113423          	sd	ra,8(sp)
    80004478:	00813023          	sd	s0,0(sp)
    8000447c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80004480:	00001097          	auipc	ra,0x1
    80004484:	888080e7          	jalr	-1912(ra) # 80004d08 <_ZN13SlabAllocator14allocateBufferEm>
}
    80004488:	00813083          	ld	ra,8(sp)
    8000448c:	00013403          	ld	s0,0(sp)
    80004490:	01010113          	addi	sp,sp,16
    80004494:	00008067          	ret

0000000080004498 <_Z5kfreePKv>:

void kfree(const void* objp){
    80004498:	ff010113          	addi	sp,sp,-16
    8000449c:	00113423          	sd	ra,8(sp)
    800044a0:	00813023          	sd	s0,0(sp)
    800044a4:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    800044a8:	00001097          	auipc	ra,0x1
    800044ac:	d54080e7          	jalr	-684(ra) # 800051fc <_ZN13SlabAllocator10freeBufferEPKv>
}
    800044b0:	00813083          	ld	ra,8(sp)
    800044b4:	00013403          	ld	s0,0(sp)
    800044b8:	01010113          	addi	sp,sp,16
    800044bc:	00008067          	ret

00000000800044c0 <_Z16kmem_cache_errorP5Cache>:

int kmem_cache_error(kmem_cache_t* cachep){
    800044c0:	ff010113          	addi	sp,sp,-16
    800044c4:	00113423          	sd	ra,8(sp)
    800044c8:	00813023          	sd	s0,0(sp)
    800044cc:	01010413          	addi	s0,sp,16
    return SlabAllocator::cacheErrorHandler(cachep);
    800044d0:	00001097          	auipc	ra,0x1
    800044d4:	e74080e7          	jalr	-396(ra) # 80005344 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache>
    800044d8:	00813083          	ld	ra,8(sp)
    800044dc:	00013403          	ld	s0,0(sp)
    800044e0:	01010113          	addi	sp,sp,16
    800044e4:	00008067          	ret

00000000800044e8 <_ZN13SlabAllocator11shrinkCacheEP5Cache>:
    deleteList(cache->emptyHead);
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    cache = nullptr;
}

int SlabAllocator::shrinkCache(Cache *cache) {
    800044e8:	fe010113          	addi	sp,sp,-32
    800044ec:	00113c23          	sd	ra,24(sp)
    800044f0:	00813823          	sd	s0,16(sp)
    800044f4:	00913423          	sd	s1,8(sp)
    800044f8:	01213023          	sd	s2,0(sp)
    800044fc:	02010413          	addi	s0,sp,32
    80004500:	00050493          	mv	s1,a0
    int ret = 0;
    80004504:	00000913          	li	s2,0
    while(cache->emptyHead){
    80004508:	0684b503          	ld	a0,104(s1)
    8000450c:	02050463          	beqz	a0,80004534 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x4c>
        Buddy::free(cache->emptyHead, cache->slabSize);
    80004510:	0484b583          	ld	a1,72(s1)
    80004514:	ffffd097          	auipc	ra,0xffffd
    80004518:	6f0080e7          	jalr	1776(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
        ret += cache->emptyHead->totalNumOfSlots;
    8000451c:	0684b783          	ld	a5,104(s1)
    80004520:	0187b703          	ld	a4,24(a5)
    80004524:	0127093b          	addw	s2,a4,s2
        cache->emptyHead = cache->emptyHead->next;
    80004528:	0087b783          	ld	a5,8(a5)
    8000452c:	06f4b423          	sd	a5,104(s1)
    while(cache->emptyHead){
    80004530:	fd9ff06f          	j	80004508 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x20>
    }
    return ret;
}
    80004534:	00090513          	mv	a0,s2
    80004538:	01813083          	ld	ra,24(sp)
    8000453c:	01013403          	ld	s0,16(sp)
    80004540:	00813483          	ld	s1,8(sp)
    80004544:	00013903          	ld	s2,0(sp)
    80004548:	02010113          	addi	sp,sp,32
    8000454c:	00008067          	ret

0000000080004550 <_ZN13SlabAllocator9printSlabEP4Slab>:

void SlabAllocator::printSlab(Slab *slab) {
    if(slab) {
    80004550:	14050c63          	beqz	a0,800046a8 <_ZN13SlabAllocator9printSlabEP4Slab+0x158>
void SlabAllocator::printSlab(Slab *slab) {
    80004554:	fe010113          	addi	sp,sp,-32
    80004558:	00113c23          	sd	ra,24(sp)
    8000455c:	00813823          	sd	s0,16(sp)
    80004560:	00913423          	sd	s1,8(sp)
    80004564:	01213023          	sd	s2,0(sp)
    80004568:	02010413          	addi	s0,sp,32
    8000456c:	00050913          	mv	s2,a0
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    80004570:	01000693          	li	a3,16
    80004574:	00004617          	auipc	a2,0x4
    80004578:	ba460613          	addi	a2,a2,-1116 # 80008118 <CONSOLE_STATUS+0x108>
    8000457c:	0005059b          	sext.w	a1,a0
    80004580:	00004517          	auipc	a0,0x4
    80004584:	db050513          	addi	a0,a0,-592 # 80008330 <CONSOLE_STATUS+0x320>
    80004588:	ffffe097          	auipc	ra,0xffffe
    8000458c:	524080e7          	jalr	1316(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n",10);
    80004590:	00a00693          	li	a3,10
    80004594:	00004617          	auipc	a2,0x4
    80004598:	b8460613          	addi	a2,a2,-1148 # 80008118 <CONSOLE_STATUS+0x108>
    8000459c:	01892583          	lw	a1,24(s2)
    800045a0:	00004517          	auipc	a0,0x4
    800045a4:	da050513          	addi	a0,a0,-608 # 80008340 <CONSOLE_STATUS+0x330>
    800045a8:	ffffe097          	auipc	ra,0xffffe
    800045ac:	504080e7          	jalr	1284(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n",10);
    800045b0:	00a00693          	li	a3,10
    800045b4:	00004617          	auipc	a2,0x4
    800045b8:	b6460613          	addi	a2,a2,-1180 # 80008118 <CONSOLE_STATUS+0x108>
    800045bc:	01092583          	lw	a1,16(s2)
    800045c0:	00004517          	auipc	a0,0x4
    800045c4:	d9850513          	addi	a0,a0,-616 # 80008358 <CONSOLE_STATUS+0x348>
    800045c8:	ffffe097          	auipc	ra,0xffffe
    800045cc:	4e4080e7          	jalr	1252(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n",10);
    800045d0:	00a00693          	li	a3,10
    800045d4:	00004617          	auipc	a2,0x4
    800045d8:	b4460613          	addi	a2,a2,-1212 # 80008118 <CONSOLE_STATUS+0x108>
    800045dc:	0b000593          	li	a1,176
    800045e0:	00004517          	auipc	a0,0x4
    800045e4:	d9050513          	addi	a0,a0,-624 # 80008370 <CONSOLE_STATUS+0x360>
    800045e8:	ffffe097          	auipc	ra,0xffffe
    800045ec:	4c4080e7          	jalr	1220(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    800045f0:	01000693          	li	a3,16
    800045f4:	00004617          	auipc	a2,0x4
    800045f8:	b2460613          	addi	a2,a2,-1244 # 80008118 <CONSOLE_STATUS+0x108>
    800045fc:	0a092583          	lw	a1,160(s2)
    80004600:	00004517          	auipc	a0,0x4
    80004604:	d8850513          	addi	a0,a0,-632 # 80008388 <CONSOLE_STATUS+0x378>
    80004608:	ffffe097          	auipc	ra,0xffffe
    8000460c:	4a4080e7          	jalr	1188(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) (&slab->allocated), "\n");
    80004610:	01000693          	li	a3,16
    80004614:	00004617          	auipc	a2,0x4
    80004618:	b0460613          	addi	a2,a2,-1276 # 80008118 <CONSOLE_STATUS+0x108>
    8000461c:	0209059b          	addiw	a1,s2,32
    80004620:	00004517          	auipc	a0,0x4
    80004624:	d7850513          	addi	a0,a0,-648 # 80008398 <CONSOLE_STATUS+0x388>
    80004628:	ffffe097          	auipc	ra,0xffffe
    8000462c:	484080e7          	jalr	1156(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array: ");
    80004630:	00004517          	auipc	a0,0x4
    80004634:	d8850513          	addi	a0,a0,-632 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80004638:	ffffe097          	auipc	ra,0xffffe
    8000463c:	354080e7          	jalr	852(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)/8; i++) {
    80004640:	00000493          	li	s1,0
    80004644:	02c0006f          	j	80004670 <_ZN13SlabAllocator9printSlabEP4Slab+0x120>
            ConsoleUtil::print("", slab->allocated[i], " ");
    80004648:	009907b3          	add	a5,s2,s1
    8000464c:	01000693          	li	a3,16
    80004650:	00004617          	auipc	a2,0x4
    80004654:	db860613          	addi	a2,a2,-584 # 80008408 <CONSOLE_STATUS+0x3f8>
    80004658:	0207c583          	lbu	a1,32(a5)
    8000465c:	00004517          	auipc	a0,0x4
    80004660:	b1450513          	addi	a0,a0,-1260 # 80008170 <CONSOLE_STATUS+0x160>
    80004664:	ffffe097          	auipc	ra,0xffffe
    80004668:	448080e7          	jalr	1096(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)/8; i++) {
    8000466c:	00148493          	addi	s1,s1,1
    80004670:	01893783          	ld	a5,24(s2)
    80004674:	00778793          	addi	a5,a5,7
    80004678:	0037d793          	srli	a5,a5,0x3
    8000467c:	fcf4e6e3          	bltu	s1,a5,80004648 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    80004680:	00004517          	auipc	a0,0x4
    80004684:	a9850513          	addi	a0,a0,-1384 # 80008118 <CONSOLE_STATUS+0x108>
    80004688:	ffffe097          	auipc	ra,0xffffe
    8000468c:	304080e7          	jalr	772(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    80004690:	01813083          	ld	ra,24(sp)
    80004694:	01013403          	ld	s0,16(sp)
    80004698:	00813483          	ld	s1,8(sp)
    8000469c:	00013903          	ld	s2,0(sp)
    800046a0:	02010113          	addi	sp,sp,32
    800046a4:	00008067          	ret
    800046a8:	00008067          	ret

00000000800046ac <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    800046ac:	fe010113          	addi	sp,sp,-32
    800046b0:	00113c23          	sd	ra,24(sp)
    800046b4:	00813823          	sd	s0,16(sp)
    800046b8:	00913423          	sd	s1,8(sp)
    800046bc:	01213023          	sd	s2,0(sp)
    800046c0:	02010413          	addi	s0,sp,32
    800046c4:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    800046c8:	00004517          	auipc	a0,0x4
    800046cc:	d1050513          	addi	a0,a0,-752 # 800083d8 <CONSOLE_STATUS+0x3c8>
    800046d0:	ffffe097          	auipc	ra,0xffffe
    800046d4:	2bc080e7          	jalr	700(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    800046d8:	00090513          	mv	a0,s2
    800046dc:	ffffe097          	auipc	ra,0xffffe
    800046e0:	2b0080e7          	jalr	688(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    800046e4:	00004517          	auipc	a0,0x4
    800046e8:	a3450513          	addi	a0,a0,-1484 # 80008118 <CONSOLE_STATUS+0x108>
    800046ec:	ffffe097          	auipc	ra,0xffffe
    800046f0:	2a0080e7          	jalr	672(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    800046f4:	01000693          	li	a3,16
    800046f8:	00004617          	auipc	a2,0x4
    800046fc:	a2060613          	addi	a2,a2,-1504 # 80008118 <CONSOLE_STATUS+0x108>
    80004700:	0009059b          	sext.w	a1,s2
    80004704:	00004517          	auipc	a0,0x4
    80004708:	ce450513          	addi	a0,a0,-796 # 800083e8 <CONSOLE_STATUS+0x3d8>
    8000470c:	ffffe097          	auipc	ra,0xffffe
    80004710:	3a0080e7          	jalr	928(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n",10);
    80004714:	00a00693          	li	a3,10
    80004718:	00004617          	auipc	a2,0x4
    8000471c:	a0060613          	addi	a2,a2,-1536 # 80008118 <CONSOLE_STATUS+0x108>
    80004720:	04892583          	lw	a1,72(s2)
    80004724:	00004517          	auipc	a0,0x4
    80004728:	cd450513          	addi	a0,a0,-812 # 800083f8 <CONSOLE_STATUS+0x3e8>
    8000472c:	ffffe097          	auipc	ra,0xffffe
    80004730:	380080e7          	jalr	896(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n",10);
    80004734:	00a00693          	li	a3,10
    80004738:	00004617          	auipc	a2,0x4
    8000473c:	9e060613          	addi	a2,a2,-1568 # 80008118 <CONSOLE_STATUS+0x108>
    80004740:	04092583          	lw	a1,64(s2)
    80004744:	00004517          	auipc	a0,0x4
    80004748:	ccc50513          	addi	a0,a0,-820 # 80008410 <CONSOLE_STATUS+0x400>
    8000474c:	ffffe097          	auipc	ra,0xffffe
    80004750:	360080e7          	jalr	864(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    80004754:	01000693          	li	a3,16
    80004758:	00004617          	auipc	a2,0x4
    8000475c:	9c060613          	addi	a2,a2,-1600 # 80008118 <CONSOLE_STATUS+0x108>
    80004760:	06892583          	lw	a1,104(s2)
    80004764:	00004517          	auipc	a0,0x4
    80004768:	cc450513          	addi	a0,a0,-828 # 80008428 <CONSOLE_STATUS+0x418>
    8000476c:	ffffe097          	auipc	ra,0xffffe
    80004770:	340080e7          	jalr	832(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>

    Slab* iter = cache->emptyHead;
    80004774:	06893483          	ld	s1,104(s2)
    while(iter){
    80004778:	02048663          	beqz	s1,800047a4 <_ZN13SlabAllocator10printCacheEP5Cache+0xf8>
        ConsoleUtil::print("", (uint64)iter, " ");
    8000477c:	01000693          	li	a3,16
    80004780:	00004617          	auipc	a2,0x4
    80004784:	c8860613          	addi	a2,a2,-888 # 80008408 <CONSOLE_STATUS+0x3f8>
    80004788:	0004859b          	sext.w	a1,s1
    8000478c:	00004517          	auipc	a0,0x4
    80004790:	9e450513          	addi	a0,a0,-1564 # 80008170 <CONSOLE_STATUS+0x160>
    80004794:	ffffe097          	auipc	ra,0xffffe
    80004798:	318080e7          	jalr	792(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    8000479c:	0084b483          	ld	s1,8(s1)
    while(iter){
    800047a0:	fd9ff06f          	j	80004778 <_ZN13SlabAllocator10printCacheEP5Cache+0xcc>
    }
    ConsoleUtil::printString("\n");
    800047a4:	00004517          	auipc	a0,0x4
    800047a8:	97450513          	addi	a0,a0,-1676 # 80008118 <CONSOLE_STATUS+0x108>
    800047ac:	ffffe097          	auipc	ra,0xffffe
    800047b0:	1e0080e7          	jalr	480(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    800047b4:	01000693          	li	a3,16
    800047b8:	00004617          	auipc	a2,0x4
    800047bc:	96060613          	addi	a2,a2,-1696 # 80008118 <CONSOLE_STATUS+0x108>
    800047c0:	07092583          	lw	a1,112(s2)
    800047c4:	00004517          	auipc	a0,0x4
    800047c8:	c7450513          	addi	a0,a0,-908 # 80008438 <CONSOLE_STATUS+0x428>
    800047cc:	ffffe097          	auipc	ra,0xffffe
    800047d0:	2e0080e7          	jalr	736(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->partialHead;
    800047d4:	07093483          	ld	s1,112(s2)
    while(iter){
    800047d8:	02048663          	beqz	s1,80004804 <_ZN13SlabAllocator10printCacheEP5Cache+0x158>
        ConsoleUtil::print("", (uint64)iter, " ");
    800047dc:	01000693          	li	a3,16
    800047e0:	00004617          	auipc	a2,0x4
    800047e4:	c2860613          	addi	a2,a2,-984 # 80008408 <CONSOLE_STATUS+0x3f8>
    800047e8:	0004859b          	sext.w	a1,s1
    800047ec:	00004517          	auipc	a0,0x4
    800047f0:	98450513          	addi	a0,a0,-1660 # 80008170 <CONSOLE_STATUS+0x160>
    800047f4:	ffffe097          	auipc	ra,0xffffe
    800047f8:	2b8080e7          	jalr	696(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800047fc:	0084b483          	ld	s1,8(s1)
    while(iter){
    80004800:	fd9ff06f          	j	800047d8 <_ZN13SlabAllocator10printCacheEP5Cache+0x12c>
    }
    ConsoleUtil::printString("\n");
    80004804:	00004517          	auipc	a0,0x4
    80004808:	91450513          	addi	a0,a0,-1772 # 80008118 <CONSOLE_STATUS+0x108>
    8000480c:	ffffe097          	auipc	ra,0xffffe
    80004810:	180080e7          	jalr	384(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80004814:	01000693          	li	a3,16
    80004818:	00004617          	auipc	a2,0x4
    8000481c:	90060613          	addi	a2,a2,-1792 # 80008118 <CONSOLE_STATUS+0x108>
    80004820:	07892583          	lw	a1,120(s2)
    80004824:	00004517          	auipc	a0,0x4
    80004828:	c2450513          	addi	a0,a0,-988 # 80008448 <CONSOLE_STATUS+0x438>
    8000482c:	ffffe097          	auipc	ra,0xffffe
    80004830:	280080e7          	jalr	640(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->fullHead;
    80004834:	07893483          	ld	s1,120(s2)
    while(iter){
    80004838:	02048663          	beqz	s1,80004864 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
        ConsoleUtil::print("", (uint64)iter, " ");
    8000483c:	01000693          	li	a3,16
    80004840:	00004617          	auipc	a2,0x4
    80004844:	bc860613          	addi	a2,a2,-1080 # 80008408 <CONSOLE_STATUS+0x3f8>
    80004848:	0004859b          	sext.w	a1,s1
    8000484c:	00004517          	auipc	a0,0x4
    80004850:	92450513          	addi	a0,a0,-1756 # 80008170 <CONSOLE_STATUS+0x160>
    80004854:	ffffe097          	auipc	ra,0xffffe
    80004858:	258080e7          	jalr	600(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    8000485c:	0084b483          	ld	s1,8(s1)
    while(iter){
    80004860:	fd9ff06f          	j	80004838 <_ZN13SlabAllocator10printCacheEP5Cache+0x18c>
    }
    ConsoleUtil::printString("\n");
    80004864:	00004517          	auipc	a0,0x4
    80004868:	8b450513          	addi	a0,a0,-1868 # 80008118 <CONSOLE_STATUS+0x108>
    8000486c:	ffffe097          	auipc	ra,0xffffe
    80004870:	120080e7          	jalr	288(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
}
    80004874:	01813083          	ld	ra,24(sp)
    80004878:	01013403          	ld	s0,16(sp)
    8000487c:	00813483          	ld	s1,8(sp)
    80004880:	00013903          	ld	s2,0(sp)
    80004884:	02010113          	addi	sp,sp,32
    80004888:	00008067          	ret

000000008000488c <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    8000488c:	ff010113          	addi	sp,sp,-16
    80004890:	00813423          	sd	s0,8(sp)
    80004894:	01010413          	addi	s0,sp,16
    slab->next = head;
    80004898:	00053783          	ld	a5,0(a0)
    8000489c:	00f5b423          	sd	a5,8(a1)
    if(head)
    800048a0:	00078463          	beqz	a5,800048a8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    800048a4:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    800048a8:	0005b023          	sd	zero,0(a1)
    head = slab;
    800048ac:	00b53023          	sd	a1,0(a0)
}
    800048b0:	00813403          	ld	s0,8(sp)
    800048b4:	01010113          	addi	sp,sp,16
    800048b8:	00008067          	ret

00000000800048bc <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    800048bc:	fd010113          	addi	sp,sp,-48
    800048c0:	02113423          	sd	ra,40(sp)
    800048c4:	02813023          	sd	s0,32(sp)
    800048c8:	00913c23          	sd	s1,24(sp)
    800048cc:	01213823          	sd	s2,16(sp)
    800048d0:	01313423          	sd	s3,8(sp)
    800048d4:	03010413          	addi	s0,sp,48
    800048d8:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    800048dc:	04853503          	ld	a0,72(a0)
    800048e0:	ffffd097          	auipc	ra,0xffffd
    800048e4:	3fc080e7          	jalr	1020(ra) # 80001cdc <_ZN5Buddy5allocEm>
    if(!slab) {
    800048e8:	08050063          	beqz	a0,80004968 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xac>
    800048ec:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    800048f0:	00050593          	mv	a1,a0
    800048f4:	06898513          	addi	a0,s3,104
    800048f8:	00000097          	auipc	ra,0x0
    800048fc:	f94080e7          	jalr	-108(ra) # 8000488c <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80004900:	0489b703          	ld	a4,72(s3)
    80004904:	00100793          	li	a5,1
    80004908:	00e797bb          	sllw	a5,a5,a4
    8000490c:	00c7979b          	slliw	a5,a5,0xc
    80004910:	f5078793          	addi	a5,a5,-176
    80004914:	0409b703          	ld	a4,64(s3)
    80004918:	02e7d7b3          	divu	a5,a5,a4
    8000491c:	00f4b823          	sd	a5,16(s1)
    80004920:	00f4bc23          	sd	a5,24(s1)
    if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
    80004924:	40000713          	li	a4,1024
    80004928:	00f77863          	bgeu	a4,a5,80004938 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x7c>
        slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    8000492c:	40000793          	li	a5,1024
    80004930:	00f4b823          	sd	a5,16(s1)
    80004934:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab));
    80004938:	0b048793          	addi	a5,s1,176
    8000493c:	0af4b023          	sd	a5,160(s1)
    slab->parent = cache;
    80004940:	0b34b423          	sd	s3,168(s1)
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)/8;i++)
    80004944:	00000713          	li	a4,0
    80004948:	0184b783          	ld	a5,24(s1)
    8000494c:	00778793          	addi	a5,a5,7
    80004950:	0037d793          	srli	a5,a5,0x3
    80004954:	02f77263          	bgeu	a4,a5,80004978 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xbc>
        slab->allocated[i] = 0;
    80004958:	00e487b3          	add	a5,s1,a4
    8000495c:	02078023          	sb	zero,32(a5)
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)/8;i++)
    80004960:	00170713          	addi	a4,a4,1
    80004964:	fe5ff06f          	j	80004948 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x8c>
        cache->errCode = 2;
    80004968:	00200793          	li	a5,2
    8000496c:	04f9b823          	sd	a5,80(s3)
        return false;
    80004970:	00000513          	li	a0,0
    80004974:	0480006f          	j	800049bc <_ZN13SlabAllocator12allocateSlabEP5Cache+0x100>
    if(cache->ctor) {
    80004978:	0589b783          	ld	a5,88(s3)
    8000497c:	02078a63          	beqz	a5,800049b0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004980:	00000913          	li	s2,0
    80004984:	0184b783          	ld	a5,24(s1)
    80004988:	02f97863          	bgeu	s2,a5,800049b8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xfc>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    8000498c:	0589b703          	ld	a4,88(s3)
    80004990:	0a04b503          	ld	a0,160(s1)
    80004994:	0a84b783          	ld	a5,168(s1)
    80004998:	0407b783          	ld	a5,64(a5)
    8000499c:	032787b3          	mul	a5,a5,s2
    800049a0:	00f50533          	add	a0,a0,a5
    800049a4:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800049a8:	00190913          	addi	s2,s2,1
    800049ac:	fd9ff06f          	j	80004984 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xc8>
    return true;
    800049b0:	00100513          	li	a0,1
    800049b4:	0080006f          	j	800049bc <_ZN13SlabAllocator12allocateSlabEP5Cache+0x100>
    800049b8:	00100513          	li	a0,1
}
    800049bc:	02813083          	ld	ra,40(sp)
    800049c0:	02013403          	ld	s0,32(sp)
    800049c4:	01813483          	ld	s1,24(sp)
    800049c8:	01013903          	ld	s2,16(sp)
    800049cc:	00813983          	ld	s3,8(sp)
    800049d0:	03010113          	addi	sp,sp,48
    800049d4:	00008067          	ret

00000000800049d8 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    800049d8:	ff010113          	addi	sp,sp,-16
    800049dc:	00813423          	sd	s0,8(sp)
    800049e0:	01010413          	addi	s0,sp,16
    if(slab == head)
    800049e4:	00053783          	ld	a5,0(a0)
    800049e8:	02b78c63          	beq	a5,a1,80004a20 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    800049ec:	0085b783          	ld	a5,8(a1)
    800049f0:	00078663          	beqz	a5,800049fc <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    800049f4:	0005b703          	ld	a4,0(a1)
    800049f8:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    800049fc:	0005b783          	ld	a5,0(a1)
    80004a00:	00078663          	beqz	a5,80004a0c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    80004a04:	0085b703          	ld	a4,8(a1)
    80004a08:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80004a0c:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80004a10:	0005b423          	sd	zero,8(a1)
}
    80004a14:	00813403          	ld	s0,8(sp)
    80004a18:	01010113          	addi	sp,sp,16
    80004a1c:	00008067          	ret
        head = slab->next;
    80004a20:	0085b783          	ld	a5,8(a1)
    80004a24:	00f53023          	sd	a5,0(a0)
    80004a28:	fc5ff06f          	j	800049ec <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

0000000080004a2c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    80004a2c:	fe010113          	addi	sp,sp,-32
    80004a30:	00113c23          	sd	ra,24(sp)
    80004a34:	00813823          	sd	s0,16(sp)
    80004a38:	00913423          	sd	s1,8(sp)
    80004a3c:	01213023          	sd	s2,0(sp)
    80004a40:	02010413          	addi	s0,sp,32
    80004a44:	00058913          	mv	s2,a1
    80004a48:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    80004a4c:	00060593          	mv	a1,a2
    80004a50:	00000097          	auipc	ra,0x0
    80004a54:	f88080e7          	jalr	-120(ra) # 800049d8 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    80004a58:	00048593          	mv	a1,s1
    80004a5c:	00090513          	mv	a0,s2
    80004a60:	00000097          	auipc	ra,0x0
    80004a64:	e2c080e7          	jalr	-468(ra) # 8000488c <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
}
    80004a68:	01813083          	ld	ra,24(sp)
    80004a6c:	01013403          	ld	s0,16(sp)
    80004a70:	00813483          	ld	s1,8(sp)
    80004a74:	00013903          	ld	s2,0(sp)
    80004a78:	02010113          	addi	sp,sp,32
    80004a7c:	00008067          	ret

0000000080004a80 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    80004a80:	fe010113          	addi	sp,sp,-32
    80004a84:	00113c23          	sd	ra,24(sp)
    80004a88:	00813823          	sd	s0,16(sp)
    80004a8c:	00913423          	sd	s1,8(sp)
    80004a90:	01213023          	sd	s2,0(sp)
    80004a94:	02010413          	addi	s0,sp,32
    80004a98:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80004a9c:	00000493          	li	s1,0
    80004aa0:	01893683          	ld	a3,24(s2)
    80004aa4:	0ad4f663          	bgeu	s1,a3,80004b50 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd0>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    80004aa8:	0034d613          	srli	a2,s1,0x3
    80004aac:	00c907b3          	add	a5,s2,a2
    80004ab0:	0207c583          	lbu	a1,32(a5)
    80004ab4:	fff4c793          	not	a5,s1
    80004ab8:	0077f793          	andi	a5,a5,7
    80004abc:	40f5d73b          	sraw	a4,a1,a5
    80004ac0:	00177713          	andi	a4,a4,1
    80004ac4:	00070663          	beqz	a4,80004ad0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x50>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80004ac8:	00148493          	addi	s1,s1,1
    80004acc:	fd5ff06f          	j	80004aa0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    80004ad0:	00100713          	li	a4,1
    80004ad4:	00f717bb          	sllw	a5,a4,a5
    80004ad8:	00c90633          	add	a2,s2,a2
    80004adc:	00f5e5b3          	or	a1,a1,a5
    80004ae0:	02b60023          	sb	a1,32(a2)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80004ae4:	01093783          	ld	a5,16(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004ae8:	04f68863          	beq	a3,a5,80004b38 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb8>
    80004aec:	0a893503          	ld	a0,168(s2)
    80004af0:	07050513          	addi	a0,a0,112
            slab->numOfFreeSlots--;
    80004af4:	fff78793          	addi	a5,a5,-1
    80004af8:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004afc:	04079463          	bnez	a5,80004b44 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc4>
    80004b00:	0a893583          	ld	a1,168(s2)
    80004b04:	07858593          	addi	a1,a1,120
            if(headTo != headFrom)
    80004b08:	0005b703          	ld	a4,0(a1)
    80004b0c:	00053783          	ld	a5,0(a0)
    80004b10:	00f70863          	beq	a4,a5,80004b20 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa0>
                SlabAllocator::move(headFrom, headTo, slab);
    80004b14:	00090613          	mv	a2,s2
    80004b18:	00000097          	auipc	ra,0x0
    80004b1c:	f14080e7          	jalr	-236(ra) # 80004a2c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    80004b20:	0a093503          	ld	a0,160(s2)
    80004b24:	0a893783          	ld	a5,168(s2)
    80004b28:	0407b783          	ld	a5,64(a5)
    80004b2c:	029784b3          	mul	s1,a5,s1
    80004b30:	00950533          	add	a0,a0,s1
    80004b34:	02c0006f          	j	80004b60 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xe0>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004b38:	0a893503          	ld	a0,168(s2)
    80004b3c:	06850513          	addi	a0,a0,104
    80004b40:	fb5ff06f          	j	80004af4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x74>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004b44:	0a893583          	ld	a1,168(s2)
    80004b48:	07058593          	addi	a1,a1,112
    80004b4c:	fbdff06f          	j	80004b08 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x88>
    slab->parent->errCode = 1;
    80004b50:	0a893783          	ld	a5,168(s2)
    80004b54:	00100713          	li	a4,1
    80004b58:	04e7b823          	sd	a4,80(a5)
    return nullptr;
    80004b5c:	00000513          	li	a0,0
}
    80004b60:	01813083          	ld	ra,24(sp)
    80004b64:	01013403          	ld	s0,16(sp)
    80004b68:	00813483          	ld	s1,8(sp)
    80004b6c:	00013903          	ld	s2,0(sp)
    80004b70:	02010113          	addi	sp,sp,32
    80004b74:	00008067          	ret

0000000080004b78 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    80004b78:	fd010113          	addi	sp,sp,-48
    80004b7c:	02113423          	sd	ra,40(sp)
    80004b80:	02813023          	sd	s0,32(sp)
    80004b84:	00913c23          	sd	s1,24(sp)
    80004b88:	01213823          	sd	s2,16(sp)
    80004b8c:	01313423          	sd	s3,8(sp)
    80004b90:	03010413          	addi	s0,sp,48
    80004b94:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    80004b98:	07053483          	ld	s1,112(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    80004b9c:	00048c63          	beqz	s1,80004bb4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
            void* ret = allocateSlot(head);
    80004ba0:	00048513          	mv	a0,s1
    80004ba4:	00000097          	auipc	ra,0x0
    80004ba8:	edc080e7          	jalr	-292(ra) # 80004a80 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80004bac:	fe0508e3          	beqz	a0,80004b9c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x24>
                return ret;
    80004bb0:	00050493          	mv	s1,a0
    if(ret){
    80004bb4:	02048263          	beqz	s1,80004bd8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x60>
}
    80004bb8:	00048513          	mv	a0,s1
    80004bbc:	02813083          	ld	ra,40(sp)
    80004bc0:	02013403          	ld	s0,32(sp)
    80004bc4:	01813483          	ld	s1,24(sp)
    80004bc8:	01013903          	ld	s2,16(sp)
    80004bcc:	00813983          	ld	s3,8(sp)
    80004bd0:	03010113          	addi	sp,sp,48
    80004bd4:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80004bd8:	06893483          	ld	s1,104(s2)
        while(head != nullptr){
    80004bdc:	00048c63          	beqz	s1,80004bf4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x7c>
            void* ret = allocateSlot(head);
    80004be0:	00048513          	mv	a0,s1
    80004be4:	00000097          	auipc	ra,0x0
    80004be8:	e9c080e7          	jalr	-356(ra) # 80004a80 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80004bec:	fe0508e3          	beqz	a0,80004bdc <_ZN13SlabAllocator14allocateObjectEP5Cache+0x64>
                return ret;
    80004bf0:	00050493          	mv	s1,a0
    if(ret){
    80004bf4:	fc0492e3          	bnez	s1,80004bb8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
    if(cache->objectSize <= sizeof(Slab)) {
    80004bf8:	04093703          	ld	a4,64(s2)
    80004bfc:	0b000793          	li	a5,176
    80004c00:	02e7e463          	bltu	a5,a4,80004c28 <_ZN13SlabAllocator14allocateObjectEP5Cache+0xb0>
        if (!SlabAllocator::allocateSlab(cache))
    80004c04:	00090513          	mv	a0,s2
    80004c08:	00000097          	auipc	ra,0x0
    80004c0c:	cb4080e7          	jalr	-844(ra) # 800048bc <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80004c10:	fa0504e3          	beqz	a0,80004bb8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80004c14:	06893503          	ld	a0,104(s2)
    80004c18:	00000097          	auipc	ra,0x0
    80004c1c:	e68080e7          	jalr	-408(ra) # 80004a80 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80004c20:	00050493          	mv	s1,a0
    80004c24:	f95ff06f          	j	80004bb8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        Slab* slab = (Slab*)SlabAllocator::allocateObject(largeSlabCache);
    80004c28:	00006517          	auipc	a0,0x6
    80004c2c:	65053503          	ld	a0,1616(a0) # 8000b278 <_ZN13SlabAllocator14largeSlabCacheE>
    80004c30:	00000097          	auipc	ra,0x0
    80004c34:	f48080e7          	jalr	-184(ra) # 80004b78 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80004c38:	00050493          	mv	s1,a0
        slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS)) / cache->objectSize;
    80004c3c:	04893703          	ld	a4,72(s2)
    80004c40:	00100793          	li	a5,1
    80004c44:	00e797bb          	sllw	a5,a5,a4
    80004c48:	00c7979b          	slliw	a5,a5,0xc
    80004c4c:	04093703          	ld	a4,64(s2)
    80004c50:	02e7d7b3          	divu	a5,a5,a4
    80004c54:	00f53823          	sd	a5,16(a0)
    80004c58:	00f53c23          	sd	a5,24(a0)
        if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
    80004c5c:	40000713          	li	a4,1024
    80004c60:	00f77863          	bgeu	a4,a5,80004c70 <_ZN13SlabAllocator14allocateObjectEP5Cache+0xf8>
            slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    80004c64:	40000793          	li	a5,1024
    80004c68:	00f53823          	sd	a5,16(a0)
    80004c6c:	00f53c23          	sd	a5,24(a0)
        void* slabOffset = Buddy::alloc(cache->slabSize);
    80004c70:	04893503          	ld	a0,72(s2)
    80004c74:	ffffd097          	auipc	ra,0xffffd
    80004c78:	068080e7          	jalr	104(ra) # 80001cdc <_ZN5Buddy5allocEm>
        slab->objectOffset = slabOffset;
    80004c7c:	0aa4b023          	sd	a0,160(s1)
        slab->parent = cache;
    80004c80:	0b24b423          	sd	s2,168(s1)
        slab->next = nullptr;
    80004c84:	0004b423          	sd	zero,8(s1)
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)/8;i++)
    80004c88:	00000713          	li	a4,0
    80004c8c:	0184b783          	ld	a5,24(s1)
    80004c90:	00778793          	addi	a5,a5,7
    80004c94:	0037d793          	srli	a5,a5,0x3
    80004c98:	00f77a63          	bgeu	a4,a5,80004cac <_ZN13SlabAllocator14allocateObjectEP5Cache+0x134>
            slab->allocated[i] = 0;
    80004c9c:	00e487b3          	add	a5,s1,a4
    80004ca0:	02078023          	sb	zero,32(a5)
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)/8;i++)
    80004ca4:	00170713          	addi	a4,a4,1
    80004ca8:	fe5ff06f          	j	80004c8c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x114>
        if(cache->ctor) {
    80004cac:	05893783          	ld	a5,88(s2)
    80004cb0:	02078a63          	beqz	a5,80004ce4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x16c>
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004cb4:	00000993          	li	s3,0
    80004cb8:	0184b783          	ld	a5,24(s1)
    80004cbc:	02f9f463          	bgeu	s3,a5,80004ce4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x16c>
                cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    80004cc0:	05893703          	ld	a4,88(s2)
    80004cc4:	0a04b503          	ld	a0,160(s1)
    80004cc8:	0a84b783          	ld	a5,168(s1)
    80004ccc:	0407b783          	ld	a5,64(a5)
    80004cd0:	033787b3          	mul	a5,a5,s3
    80004cd4:	00f50533          	add	a0,a0,a5
    80004cd8:	000700e7          	jalr	a4
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004cdc:	00198993          	addi	s3,s3,1
    80004ce0:	fd9ff06f          	j	80004cb8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x140>
        SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80004ce4:	00048593          	mv	a1,s1
    80004ce8:	06890513          	addi	a0,s2,104
    80004cec:	00000097          	auipc	ra,0x0
    80004cf0:	ba0080e7          	jalr	-1120(ra) # 8000488c <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80004cf4:	06893503          	ld	a0,104(s2)
    80004cf8:	00000097          	auipc	ra,0x0
    80004cfc:	d88080e7          	jalr	-632(ra) # 80004a80 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80004d00:	00050493          	mv	s1,a0
    80004d04:	eb5ff06f          	j	80004bb8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>

0000000080004d08 <_ZN13SlabAllocator14allocateBufferEm>:
        num--;
    80004d08:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80004d0c:	0017d513          	srli	a0,a5,0x1
    80004d10:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80004d14:	0027d713          	srli	a4,a5,0x2
    80004d18:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80004d1c:	0047d713          	srli	a4,a5,0x4
    80004d20:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80004d24:	0087d713          	srli	a4,a5,0x8
    80004d28:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80004d2c:	0107d713          	srli	a4,a5,0x10
    80004d30:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80004d34:	0207d713          	srli	a4,a5,0x20
    80004d38:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80004d3c:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80004d40:	00000713          	li	a4,0
        while(num>1){
    80004d44:	00100693          	li	a3,1
    80004d48:	00f6f863          	bgeu	a3,a5,80004d58 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    80004d4c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80004d50:	00170713          	addi	a4,a4,1
        while(num>1){
    80004d54:	ff1ff06f          	j	80004d44 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    80004d58:	ffb70713          	addi	a4,a4,-5
    80004d5c:	00c00793          	li	a5,12
    80004d60:	04e7e063          	bltu	a5,a4,80004da0 <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    80004d64:	ff010113          	addi	sp,sp,-16
    80004d68:	00113423          	sd	ra,8(sp)
    80004d6c:	00813023          	sd	s0,0(sp)
    80004d70:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    80004d74:	00371713          	slli	a4,a4,0x3
    80004d78:	00006797          	auipc	a5,0x6
    80004d7c:	50078793          	addi	a5,a5,1280 # 8000b278 <_ZN13SlabAllocator14largeSlabCacheE>
    80004d80:	00e78733          	add	a4,a5,a4
    80004d84:	00873503          	ld	a0,8(a4)
    80004d88:	00000097          	auipc	ra,0x0
    80004d8c:	df0080e7          	jalr	-528(ra) # 80004b78 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004d90:	00813083          	ld	ra,8(sp)
    80004d94:	00013403          	ld	s0,0(sp)
    80004d98:	01010113          	addi	sp,sp,16
    80004d9c:	00008067          	ret
        return nullptr;
    80004da0:	00000513          	li	a0,0
}
    80004da4:	00008067          	ret

0000000080004da8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80004da8:	fc010113          	addi	sp,sp,-64
    80004dac:	02113c23          	sd	ra,56(sp)
    80004db0:	02813823          	sd	s0,48(sp)
    80004db4:	02913423          	sd	s1,40(sp)
    80004db8:	03213023          	sd	s2,32(sp)
    80004dbc:	01313c23          	sd	s3,24(sp)
    80004dc0:	01413823          	sd	s4,16(sp)
    80004dc4:	01513423          	sd	s5,8(sp)
    80004dc8:	04010413          	addi	s0,sp,64
    80004dcc:	00050993          	mv	s3,a0
    80004dd0:	00058913          	mv	s2,a1
    80004dd4:	00060a93          	mv	s5,a2
    80004dd8:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80004ddc:	00006517          	auipc	a0,0x6
    80004de0:	50c53503          	ld	a0,1292(a0) # 8000b2e8 <_ZN13SlabAllocator5cacheE>
    80004de4:	00000097          	auipc	ra,0x0
    80004de8:	d94080e7          	jalr	-620(ra) # 80004b78 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80004dec:	00050493          	mv	s1,a0
    if(ret == nullptr)
    80004df0:	08050a63          	beqz	a0,80004e84 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xdc>
    ret->ctor = ctor;
    80004df4:	05553c23          	sd	s5,88(a0)
    ret->dtor = dtor;
    80004df8:	07453023          	sd	s4,96(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80004dfc:	06053c23          	sd	zero,120(a0)
    80004e00:	06053823          	sd	zero,112(a0)
    80004e04:	06053423          	sd	zero,104(a0)
    ret->objectSize = size;
    80004e08:	05253023          	sd	s2,64(a0)
    ret->errCode = 0;
    80004e0c:	04053823          	sd	zero,80(a0)
        num--;
    80004e10:	fff90793          	addi	a5,s2,-1
        num |= num>>1;
    80004e14:	0017d713          	srli	a4,a5,0x1
    80004e18:	00e7e7b3          	or	a5,a5,a4
        num |= num>>2;
    80004e1c:	0027d713          	srli	a4,a5,0x2
    80004e20:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80004e24:	0047d713          	srli	a4,a5,0x4
    80004e28:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80004e2c:	0087d713          	srli	a4,a5,0x8
    80004e30:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80004e34:	0107d713          	srli	a4,a5,0x10
    80004e38:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80004e3c:	0207d713          	srli	a4,a5,0x20
    80004e40:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80004e44:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80004e48:	00000713          	li	a4,0
        while(num>1){
    80004e4c:	00100693          	li	a3,1
    80004e50:	00f6f863          	bgeu	a3,a5,80004e60 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xb8>
            num/=2;
    80004e54:	0017d793          	srli	a5,a5,0x1
            deg++;
    80004e58:	00170713          	addi	a4,a4,1
        while(num>1){
    80004e5c:	ff1ff06f          	j	80004e4c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xa4>
    int deg = Buddy::getDeg(Buddy::ceil(size));
    80004e60:	0007071b          	sext.w	a4,a4
    if(size <= sizeof(Slab)){
    80004e64:	0b000793          	li	a5,176
    80004e68:	0527e263          	bltu	a5,s2,80004eac <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x104>
        ret->slabSize = SMALL_CACHE_DEFAULT_SLAB_SIZE;
    80004e6c:	00100793          	li	a5,1
    80004e70:	04f4b423          	sd	a5,72(s1)
    strcpy(name, ret->name);
    80004e74:	00048593          	mv	a1,s1
    80004e78:	00098513          	mv	a0,s3
    80004e7c:	fffff097          	auipc	ra,0xfffff
    80004e80:	234080e7          	jalr	564(ra) # 800040b0 <_Z6strcpyPKcPc>
}
    80004e84:	00048513          	mv	a0,s1
    80004e88:	03813083          	ld	ra,56(sp)
    80004e8c:	03013403          	ld	s0,48(sp)
    80004e90:	02813483          	ld	s1,40(sp)
    80004e94:	02013903          	ld	s2,32(sp)
    80004e98:	01813983          	ld	s3,24(sp)
    80004e9c:	01013a03          	ld	s4,16(sp)
    80004ea0:	00813a83          	ld	s5,8(sp)
    80004ea4:	04010113          	addi	sp,sp,64
    80004ea8:	00008067          	ret
        deg-=10;
    80004eac:	ff67071b          	addiw	a4,a4,-10
        ret->slabSize = deg;
    80004eb0:	04e4b423          	sd	a4,72(s1)
    80004eb4:	fc1ff06f          	j	80004e74 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xcc>

0000000080004eb8 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80004eb8:	fe010113          	addi	sp,sp,-32
    80004ebc:	00113c23          	sd	ra,24(sp)
    80004ec0:	00813823          	sd	s0,16(sp)
    80004ec4:	00913423          	sd	s1,8(sp)
    80004ec8:	01213023          	sd	s2,0(sp)
    80004ecc:	02010413          	addi	s0,sp,32
    Buddy::initialize(space, blockNum);
    80004ed0:	ffffd097          	auipc	ra,0xffffd
    80004ed4:	a3c080e7          	jalr	-1476(ra) # 8000190c <_ZN5Buddy10initializeEPvm>
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80004ed8:	00006917          	auipc	s2,0x6
    80004edc:	0a893903          	ld	s2,168(s2) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004ee0:	00093583          	ld	a1,0(s2)
    80004ee4:	00c5d593          	srli	a1,a1,0xc
    80004ee8:	00158593          	addi	a1,a1,1
    80004eec:	00c59593          	slli	a1,a1,0xc
    80004ef0:	00006497          	auipc	s1,0x6
    80004ef4:	38848493          	addi	s1,s1,904 # 8000b278 <_ZN13SlabAllocator14largeSlabCacheE>
    80004ef8:	06b4b823          	sd	a1,112(s1)
    cache->ctor = nullptr;
    80004efc:	0405bc23          	sd	zero,88(a1)
    cache->dtor = nullptr;
    80004f00:	0605b023          	sd	zero,96(a1)
    cache->emptyHead = nullptr;
    80004f04:	0605b423          	sd	zero,104(a1)
    cache->partialHead = nullptr;
    80004f08:	0605b823          	sd	zero,112(a1)
    cache->fullHead = nullptr;
    80004f0c:	0605bc23          	sd	zero,120(a1)
    cache->objectSize = sizeof(Cache);
    80004f10:	08000793          	li	a5,128
    80004f14:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80004f18:	00200793          	li	a5,2
    80004f1c:	04f5b423          	sd	a5,72(a1)
    cache->errCode = 0;
    80004f20:	0405b823          	sd	zero,80(a1)
    strcpy("Main Cache", cache->name);
    80004f24:	00003517          	auipc	a0,0x3
    80004f28:	53450513          	addi	a0,a0,1332 # 80008458 <CONSOLE_STATUS+0x448>
    80004f2c:	fffff097          	auipc	ra,0xfffff
    80004f30:	184080e7          	jalr	388(ra) # 800040b0 <_Z6strcpyPKcPc>
    largeSlabCache = (Cache*)BUDDY_META_ADDR_CONST;
    80004f34:	00093783          	ld	a5,0(s2)
    80004f38:	fffff737          	lui	a4,0xfffff
    80004f3c:	00e7f7b3          	and	a5,a5,a4
    80004f40:	00f4b023          	sd	a5,0(s1)
    largeSlabCache->ctor = nullptr;
    80004f44:	0407bc23          	sd	zero,88(a5)
    largeSlabCache->dtor = nullptr;
    80004f48:	0607b023          	sd	zero,96(a5)
    largeSlabCache->emptyHead = nullptr;
    80004f4c:	0607b423          	sd	zero,104(a5)
    largeSlabCache->partialHead = nullptr;
    80004f50:	0607b823          	sd	zero,112(a5)
    largeSlabCache->fullHead = nullptr;
    80004f54:	0607bc23          	sd	zero,120(a5)
    largeSlabCache->objectSize = sizeof(Slab);
    80004f58:	0b000713          	li	a4,176
    80004f5c:	04e7b023          	sd	a4,64(a5)
    largeSlabCache->slabSize = SLAB_HEADER_DEFAULT_SLAB_SIZE;
    80004f60:	00400713          	li	a4,4
    80004f64:	04e7b423          	sd	a4,72(a5)
    cache->errCode = 0;
    80004f68:	0704b583          	ld	a1,112(s1)
    80004f6c:	0405b823          	sd	zero,80(a1)
    strcpy("Large Slab Cache", cache->name);
    80004f70:	00003517          	auipc	a0,0x3
    80004f74:	4f850513          	addi	a0,a0,1272 # 80008468 <CONSOLE_STATUS+0x458>
    80004f78:	fffff097          	auipc	ra,0xfffff
    80004f7c:	138080e7          	jalr	312(ra) # 800040b0 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80004f80:	00000493          	li	s1,0
    80004f84:	0480006f          	j	80004fcc <_ZN13SlabAllocator10initializeEPvm+0x114>
        sizeN[i] = SlabAllocator::createCache(names[i], 1<<(i+CACHE_LOWER_BOUND), nullptr, nullptr);
    80004f88:	0054871b          	addiw	a4,s1,5
    80004f8c:	00349913          	slli	s2,s1,0x3
    80004f90:	00006797          	auipc	a5,0x6
    80004f94:	f7078793          	addi	a5,a5,-144 # 8000af00 <_ZN13SlabAllocator5namesE>
    80004f98:	012787b3          	add	a5,a5,s2
    80004f9c:	00000693          	li	a3,0
    80004fa0:	00000613          	li	a2,0
    80004fa4:	00100593          	li	a1,1
    80004fa8:	00e595bb          	sllw	a1,a1,a4
    80004fac:	0007b503          	ld	a0,0(a5)
    80004fb0:	00000097          	auipc	ra,0x0
    80004fb4:	df8080e7          	jalr	-520(ra) # 80004da8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80004fb8:	00006797          	auipc	a5,0x6
    80004fbc:	2c078793          	addi	a5,a5,704 # 8000b278 <_ZN13SlabAllocator14largeSlabCacheE>
    80004fc0:	012787b3          	add	a5,a5,s2
    80004fc4:	00a7b423          	sd	a0,8(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80004fc8:	0014849b          	addiw	s1,s1,1
    80004fcc:	00c00793          	li	a5,12
    80004fd0:	fa97dce3          	bge	a5,s1,80004f88 <_ZN13SlabAllocator10initializeEPvm+0xd0>
}
    80004fd4:	01813083          	ld	ra,24(sp)
    80004fd8:	01013403          	ld	s0,16(sp)
    80004fdc:	00813483          	ld	s1,8(sp)
    80004fe0:	00013903          	ld	s2,0(sp)
    80004fe4:	02010113          	addi	sp,sp,32
    80004fe8:	00008067          	ret

0000000080004fec <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80004fec:	0035d713          	srli	a4,a1,0x3
    80004ff0:	00e507b3          	add	a5,a0,a4
    80004ff4:	0207c683          	lbu	a3,32(a5)
    80004ff8:	fff5c593          	not	a1,a1
    80004ffc:	0075f593          	andi	a1,a1,7
    80005000:	40b6d7bb          	sraw	a5,a3,a1
    80005004:	0017f793          	andi	a5,a5,1
    80005008:	0e078e63          	beqz	a5,80005104 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x118>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    8000500c:	fe010113          	addi	sp,sp,-32
    80005010:	00113c23          	sd	ra,24(sp)
    80005014:	00813823          	sd	s0,16(sp)
    80005018:	00913423          	sd	s1,8(sp)
    8000501c:	02010413          	addi	s0,sp,32
    80005020:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80005024:	00100793          	li	a5,1
    80005028:	00b795bb          	sllw	a1,a5,a1
    8000502c:	00e50733          	add	a4,a0,a4
    80005030:	fff5c593          	not	a1,a1
    80005034:	00d5f5b3          	and	a1,a1,a3
    80005038:	02b70023          	sb	a1,32(a4) # fffffffffffff020 <end+0xffffffff7ffee020>
    inline bool isFull(){return numOfFreeSlots == 0;}
    8000503c:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80005040:	04079a63          	bnez	a5,80005094 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80005044:	0a853503          	ld	a0,168(a0)
    80005048:	07850513          	addi	a0,a0,120
        slab->numOfFreeSlots++;
    8000504c:	00178793          	addi	a5,a5,1
    80005050:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80005054:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80005058:	04e78463          	beq	a5,a4,800050a0 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    8000505c:	0a84b583          	ld	a1,168(s1)
    80005060:	07058593          	addi	a1,a1,112
        if(slab->isEmpty()) {
    80005064:	04e78463          	beq	a5,a4,800050ac <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80005068:	0005b703          	ld	a4,0(a1)
    8000506c:	00053783          	ld	a5,0(a0)
    80005070:	00f70863          	beq	a4,a5,80005080 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80005074:	00048613          	mv	a2,s1
    80005078:	00000097          	auipc	ra,0x0
    8000507c:	9b4080e7          	jalr	-1612(ra) # 80004a2c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80005080:	01813083          	ld	ra,24(sp)
    80005084:	01013403          	ld	s0,16(sp)
    80005088:	00813483          	ld	s1,8(sp)
    8000508c:	02010113          	addi	sp,sp,32
    80005090:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80005094:	0a853503          	ld	a0,168(a0)
    80005098:	07050513          	addi	a0,a0,112
    8000509c:	fb1ff06f          	j	8000504c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800050a0:	0a84b583          	ld	a1,168(s1)
    800050a4:	06858593          	addi	a1,a1,104
    800050a8:	fbdff06f          	j	80005064 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    800050ac:	00048593          	mv	a1,s1
    800050b0:	00000097          	auipc	ra,0x0
    800050b4:	928080e7          	jalr	-1752(ra) # 800049d8 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            if(slab->parent->objectSize <= sizeof(Slab)) {
    800050b8:	0a84b783          	ld	a5,168(s1)
    800050bc:	0407b683          	ld	a3,64(a5)
    800050c0:	0b000713          	li	a4,176
    800050c4:	00d76c63          	bltu	a4,a3,800050dc <_ZN13SlabAllocator8freeSlotEP4Slabm+0xf0>
                Buddy::free(slab, slab->parent->slabSize);
    800050c8:	0487b583          	ld	a1,72(a5)
    800050cc:	00048513          	mv	a0,s1
    800050d0:	ffffd097          	auipc	ra,0xffffd
    800050d4:	b34080e7          	jalr	-1228(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
    800050d8:	fa9ff06f          	j	80005080 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                Buddy::free(slab->objectOffset, slab->parent->slabSize);
    800050dc:	0487b583          	ld	a1,72(a5)
    800050e0:	0a04b503          	ld	a0,160(s1)
    800050e4:	ffffd097          	auipc	ra,0xffffd
    800050e8:	b20080e7          	jalr	-1248(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
                SlabAllocator::freeObject(largeSlabCache, slab);
    800050ec:	00048593          	mv	a1,s1
    800050f0:	00006517          	auipc	a0,0x6
    800050f4:	18853503          	ld	a0,392(a0) # 8000b278 <_ZN13SlabAllocator14largeSlabCacheE>
    800050f8:	00000097          	auipc	ra,0x0
    800050fc:	010080e7          	jalr	16(ra) # 80005108 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80005100:	f81ff06f          	j	80005080 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80005104:	00008067          	ret

0000000080005108 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80005108:	fe010113          	addi	sp,sp,-32
    8000510c:	00113c23          	sd	ra,24(sp)
    80005110:	00813823          	sd	s0,16(sp)
    80005114:	00913423          	sd	s1,8(sp)
    80005118:	01213023          	sd	s2,0(sp)
    8000511c:	02010413          	addi	s0,sp,32
    80005120:	00050913          	mv	s2,a0
    80005124:	00058493          	mv	s1,a1
    if(cache->dtor)
    80005128:	06053783          	ld	a5,96(a0)
    8000512c:	00078663          	beqz	a5,80005138 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80005130:	00058513          	mv	a0,a1
    80005134:	000780e7          	jalr	a5
    if(cache->ctor)
    80005138:	05893783          	ld	a5,88(s2)
    8000513c:	00078663          	beqz	a5,80005148 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80005140:	00048513          	mv	a0,s1
    80005144:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80005148:	07893503          	ld	a0,120(s2)
    8000514c:	0080006f          	j	80005154 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80005150:	00853503          	ld	a0,8(a0)
        while(head){
    80005154:	02050e63          	beqz	a0,80005190 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80005158:	0a053703          	ld	a4,160(a0)
    8000515c:	01853783          	ld	a5,24(a0)
    80005160:	0a853683          	ld	a3,168(a0)
    80005164:	0406b583          	ld	a1,64(a3)
    80005168:	02b787b3          	mul	a5,a5,a1
    8000516c:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80005170:	fef4f0e3          	bgeu	s1,a5,80005150 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80005174:	fce4eee3          	bltu	s1,a4,80005150 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80005178:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    8000517c:	02b755b3          	divu	a1,a4,a1
    80005180:	00000097          	auipc	ra,0x0
    80005184:	e6c080e7          	jalr	-404(ra) # 80004fec <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80005188:	00100513          	li	a0,1
    8000518c:	0080006f          	j	80005194 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80005190:	00000513          	li	a0,0
    if(deleted)
    80005194:	00050e63          	beqz	a0,800051b0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80005198:	01813083          	ld	ra,24(sp)
    8000519c:	01013403          	ld	s0,16(sp)
    800051a0:	00813483          	ld	s1,8(sp)
    800051a4:	00013903          	ld	s2,0(sp)
    800051a8:	02010113          	addi	sp,sp,32
    800051ac:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    800051b0:	07093783          	ld	a5,112(s2)
    800051b4:	0080006f          	j	800051bc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    800051b8:	0087b783          	ld	a5,8(a5)
        while(head){
    800051bc:	fc078ee3          	beqz	a5,80005198 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    800051c0:	0a07b683          	ld	a3,160(a5)
    800051c4:	0187b703          	ld	a4,24(a5)
    800051c8:	0a87b603          	ld	a2,168(a5)
    800051cc:	04063583          	ld	a1,64(a2)
    800051d0:	02b70733          	mul	a4,a4,a1
    800051d4:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    800051d8:	fee4f0e3          	bgeu	s1,a4,800051b8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    800051dc:	fcd4eee3          	bltu	s1,a3,800051b8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    800051e0:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    800051e4:	02b6d5b3          	divu	a1,a3,a1
    800051e8:	00078513          	mv	a0,a5
    800051ec:	00000097          	auipc	ra,0x0
    800051f0:	e00080e7          	jalr	-512(ra) # 80004fec <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    800051f4:	00100513          	li	a0,1
    800051f8:	fa1ff06f          	j	80005198 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

00000000800051fc <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    800051fc:	fe010113          	addi	sp,sp,-32
    80005200:	00113c23          	sd	ra,24(sp)
    80005204:	00813823          	sd	s0,16(sp)
    80005208:	00913423          	sd	s1,8(sp)
    8000520c:	01213023          	sd	s2,0(sp)
    80005210:	02010413          	addi	s0,sp,32
    80005214:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80005218:	00000493          	li	s1,0
    8000521c:	00c00793          	li	a5,12
    80005220:	0297c863          	blt	a5,s1,80005250 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80005224:	00349713          	slli	a4,s1,0x3
    80005228:	00006797          	auipc	a5,0x6
    8000522c:	05078793          	addi	a5,a5,80 # 8000b278 <_ZN13SlabAllocator14largeSlabCacheE>
    80005230:	00e787b3          	add	a5,a5,a4
    80005234:	00090593          	mv	a1,s2
    80005238:	0087b503          	ld	a0,8(a5)
    8000523c:	00000097          	auipc	ra,0x0
    80005240:	ecc080e7          	jalr	-308(ra) # 80005108 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80005244:	00051663          	bnez	a0,80005250 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80005248:	0014849b          	addiw	s1,s1,1
    8000524c:	fd1ff06f          	j	8000521c <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80005250:	01813083          	ld	ra,24(sp)
    80005254:	01013403          	ld	s0,16(sp)
    80005258:	00813483          	ld	s1,8(sp)
    8000525c:	00013903          	ld	s2,0(sp)
    80005260:	02010113          	addi	sp,sp,32
    80005264:	00008067          	ret

0000000080005268 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80005268:	fe010113          	addi	sp,sp,-32
    8000526c:	00113c23          	sd	ra,24(sp)
    80005270:	00813823          	sd	s0,16(sp)
    80005274:	00913423          	sd	s1,8(sp)
    80005278:	01213023          	sd	s2,0(sp)
    8000527c:	02010413          	addi	s0,sp,32
    80005280:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80005284:	00053903          	ld	s2,0(a0)
    80005288:	07890913          	addi	s2,s2,120
    }

    static inline void deleteList(Slab* &head){
        while(head){
    8000528c:	00093503          	ld	a0,0(s2)
    80005290:	02050263          	beqz	a0,800052b4 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80005294:	0a853783          	ld	a5,168(a0)
    80005298:	0487b583          	ld	a1,72(a5)
    8000529c:	ffffd097          	auipc	ra,0xffffd
    800052a0:	968080e7          	jalr	-1688(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
            head = head->next;
    800052a4:	00093783          	ld	a5,0(s2)
    800052a8:	0087b783          	ld	a5,8(a5)
    800052ac:	00f93023          	sd	a5,0(s2)
        while(head){
    800052b0:	fddff06f          	j	8000528c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    800052b4:	0004b903          	ld	s2,0(s1)
    800052b8:	07090913          	addi	s2,s2,112
    800052bc:	00093503          	ld	a0,0(s2)
    800052c0:	02050263          	beqz	a0,800052e4 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    800052c4:	0a853783          	ld	a5,168(a0)
    800052c8:	0487b583          	ld	a1,72(a5)
    800052cc:	ffffd097          	auipc	ra,0xffffd
    800052d0:	938080e7          	jalr	-1736(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
            head = head->next;
    800052d4:	00093783          	ld	a5,0(s2)
    800052d8:	0087b783          	ld	a5,8(a5)
    800052dc:	00f93023          	sd	a5,0(s2)
        while(head){
    800052e0:	fddff06f          	j	800052bc <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    800052e4:	0004b903          	ld	s2,0(s1)
    800052e8:	06890913          	addi	s2,s2,104
    800052ec:	00093503          	ld	a0,0(s2)
    800052f0:	02050263          	beqz	a0,80005314 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    800052f4:	0a853783          	ld	a5,168(a0)
    800052f8:	0487b583          	ld	a1,72(a5)
    800052fc:	ffffd097          	auipc	ra,0xffffd
    80005300:	908080e7          	jalr	-1784(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80005304:	00093783          	ld	a5,0(s2)
    80005308:	0087b783          	ld	a5,8(a5)
    8000530c:	00f93023          	sd	a5,0(s2)
        while(head){
    80005310:	fddff06f          	j	800052ec <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80005314:	0004b583          	ld	a1,0(s1)
    80005318:	00006517          	auipc	a0,0x6
    8000531c:	fd053503          	ld	a0,-48(a0) # 8000b2e8 <_ZN13SlabAllocator5cacheE>
    80005320:	00000097          	auipc	ra,0x0
    80005324:	de8080e7          	jalr	-536(ra) # 80005108 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80005328:	0004b023          	sd	zero,0(s1)
}
    8000532c:	01813083          	ld	ra,24(sp)
    80005330:	01013403          	ld	s0,16(sp)
    80005334:	00813483          	ld	s1,8(sp)
    80005338:	00013903          	ld	s2,0(sp)
    8000533c:	02010113          	addi	sp,sp,32
    80005340:	00008067          	ret

0000000080005344 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache>:

int SlabAllocator::cacheErrorHandler(Cache *cache) {
    80005344:	fe010113          	addi	sp,sp,-32
    80005348:	00113c23          	sd	ra,24(sp)
    8000534c:	00813823          	sd	s0,16(sp)
    80005350:	00913423          	sd	s1,8(sp)
    80005354:	02010413          	addi	s0,sp,32
    80005358:	00050493          	mv	s1,a0
    switch(cache->errCode){
    8000535c:	05053783          	ld	a5,80(a0)
    80005360:	00100713          	li	a4,1
    80005364:	02e78e63          	beq	a5,a4,800053a0 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x5c>
    80005368:	00200713          	li	a4,2
    8000536c:	04e78463          	beq	a5,a4,800053b4 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x70>
    80005370:	00078e63          	beqz	a5,8000538c <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x48>
        case 0: ConsoleUtil::printString("No errors\n");break;
        case 1: ConsoleUtil::printString("No available slots\n");break;
        case 2: ConsoleUtil::printString("Couldn't allocate slab\n");break;
    }
    return cache->errCode;
    80005374:	0504a503          	lw	a0,80(s1)
    80005378:	01813083          	ld	ra,24(sp)
    8000537c:	01013403          	ld	s0,16(sp)
    80005380:	00813483          	ld	s1,8(sp)
    80005384:	02010113          	addi	sp,sp,32
    80005388:	00008067          	ret
        case 0: ConsoleUtil::printString("No errors\n");break;
    8000538c:	00003517          	auipc	a0,0x3
    80005390:	0f450513          	addi	a0,a0,244 # 80008480 <CONSOLE_STATUS+0x470>
    80005394:	ffffd097          	auipc	ra,0xffffd
    80005398:	5f8080e7          	jalr	1528(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    8000539c:	fd9ff06f          	j	80005374 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>
        case 1: ConsoleUtil::printString("No available slots\n");break;
    800053a0:	00003517          	auipc	a0,0x3
    800053a4:	0f050513          	addi	a0,a0,240 # 80008490 <CONSOLE_STATUS+0x480>
    800053a8:	ffffd097          	auipc	ra,0xffffd
    800053ac:	5e4080e7          	jalr	1508(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    800053b0:	fc5ff06f          	j	80005374 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>
        case 2: ConsoleUtil::printString("Couldn't allocate slab\n");break;
    800053b4:	00003517          	auipc	a0,0x3
    800053b8:	0f450513          	addi	a0,a0,244 # 800084a8 <CONSOLE_STATUS+0x498>
    800053bc:	ffffd097          	auipc	ra,0xffffd
    800053c0:	5d0080e7          	jalr	1488(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    800053c4:	fb1ff06f          	j	80005374 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>

00000000800053c8 <start>:
    800053c8:	ff010113          	addi	sp,sp,-16
    800053cc:	00813423          	sd	s0,8(sp)
    800053d0:	01010413          	addi	s0,sp,16
    800053d4:	300027f3          	csrr	a5,mstatus
    800053d8:	ffffe737          	lui	a4,0xffffe
    800053dc:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed7ff>
    800053e0:	00e7f7b3          	and	a5,a5,a4
    800053e4:	00001737          	lui	a4,0x1
    800053e8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800053ec:	00e7e7b3          	or	a5,a5,a4
    800053f0:	30079073          	csrw	mstatus,a5
    800053f4:	00000797          	auipc	a5,0x0
    800053f8:	16078793          	addi	a5,a5,352 # 80005554 <system_main>
    800053fc:	34179073          	csrw	mepc,a5
    80005400:	00000793          	li	a5,0
    80005404:	18079073          	csrw	satp,a5
    80005408:	000107b7          	lui	a5,0x10
    8000540c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005410:	30279073          	csrw	medeleg,a5
    80005414:	30379073          	csrw	mideleg,a5
    80005418:	104027f3          	csrr	a5,sie
    8000541c:	2227e793          	ori	a5,a5,546
    80005420:	10479073          	csrw	sie,a5
    80005424:	fff00793          	li	a5,-1
    80005428:	00a7d793          	srli	a5,a5,0xa
    8000542c:	3b079073          	csrw	pmpaddr0,a5
    80005430:	00f00793          	li	a5,15
    80005434:	3a079073          	csrw	pmpcfg0,a5
    80005438:	f14027f3          	csrr	a5,mhartid
    8000543c:	0200c737          	lui	a4,0x200c
    80005440:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005444:	0007869b          	sext.w	a3,a5
    80005448:	00269713          	slli	a4,a3,0x2
    8000544c:	000f4637          	lui	a2,0xf4
    80005450:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005454:	00d70733          	add	a4,a4,a3
    80005458:	0037979b          	slliw	a5,a5,0x3
    8000545c:	020046b7          	lui	a3,0x2004
    80005460:	00d787b3          	add	a5,a5,a3
    80005464:	00c585b3          	add	a1,a1,a2
    80005468:	00371693          	slli	a3,a4,0x3
    8000546c:	00006717          	auipc	a4,0x6
    80005470:	e8470713          	addi	a4,a4,-380 # 8000b2f0 <timer_scratch>
    80005474:	00b7b023          	sd	a1,0(a5)
    80005478:	00d70733          	add	a4,a4,a3
    8000547c:	00f73c23          	sd	a5,24(a4)
    80005480:	02c73023          	sd	a2,32(a4)
    80005484:	34071073          	csrw	mscratch,a4
    80005488:	00000797          	auipc	a5,0x0
    8000548c:	6e878793          	addi	a5,a5,1768 # 80005b70 <timervec>
    80005490:	30579073          	csrw	mtvec,a5
    80005494:	300027f3          	csrr	a5,mstatus
    80005498:	0087e793          	ori	a5,a5,8
    8000549c:	30079073          	csrw	mstatus,a5
    800054a0:	304027f3          	csrr	a5,mie
    800054a4:	0807e793          	ori	a5,a5,128
    800054a8:	30479073          	csrw	mie,a5
    800054ac:	f14027f3          	csrr	a5,mhartid
    800054b0:	0007879b          	sext.w	a5,a5
    800054b4:	00078213          	mv	tp,a5
    800054b8:	30200073          	mret
    800054bc:	00813403          	ld	s0,8(sp)
    800054c0:	01010113          	addi	sp,sp,16
    800054c4:	00008067          	ret

00000000800054c8 <timerinit>:
    800054c8:	ff010113          	addi	sp,sp,-16
    800054cc:	00813423          	sd	s0,8(sp)
    800054d0:	01010413          	addi	s0,sp,16
    800054d4:	f14027f3          	csrr	a5,mhartid
    800054d8:	0200c737          	lui	a4,0x200c
    800054dc:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800054e0:	0007869b          	sext.w	a3,a5
    800054e4:	00269713          	slli	a4,a3,0x2
    800054e8:	000f4637          	lui	a2,0xf4
    800054ec:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800054f0:	00d70733          	add	a4,a4,a3
    800054f4:	0037979b          	slliw	a5,a5,0x3
    800054f8:	020046b7          	lui	a3,0x2004
    800054fc:	00d787b3          	add	a5,a5,a3
    80005500:	00c585b3          	add	a1,a1,a2
    80005504:	00371693          	slli	a3,a4,0x3
    80005508:	00006717          	auipc	a4,0x6
    8000550c:	de870713          	addi	a4,a4,-536 # 8000b2f0 <timer_scratch>
    80005510:	00b7b023          	sd	a1,0(a5)
    80005514:	00d70733          	add	a4,a4,a3
    80005518:	00f73c23          	sd	a5,24(a4)
    8000551c:	02c73023          	sd	a2,32(a4)
    80005520:	34071073          	csrw	mscratch,a4
    80005524:	00000797          	auipc	a5,0x0
    80005528:	64c78793          	addi	a5,a5,1612 # 80005b70 <timervec>
    8000552c:	30579073          	csrw	mtvec,a5
    80005530:	300027f3          	csrr	a5,mstatus
    80005534:	0087e793          	ori	a5,a5,8
    80005538:	30079073          	csrw	mstatus,a5
    8000553c:	304027f3          	csrr	a5,mie
    80005540:	0807e793          	ori	a5,a5,128
    80005544:	30479073          	csrw	mie,a5
    80005548:	00813403          	ld	s0,8(sp)
    8000554c:	01010113          	addi	sp,sp,16
    80005550:	00008067          	ret

0000000080005554 <system_main>:
    80005554:	fe010113          	addi	sp,sp,-32
    80005558:	00813823          	sd	s0,16(sp)
    8000555c:	00913423          	sd	s1,8(sp)
    80005560:	00113c23          	sd	ra,24(sp)
    80005564:	02010413          	addi	s0,sp,32
    80005568:	00000097          	auipc	ra,0x0
    8000556c:	0c4080e7          	jalr	196(ra) # 8000562c <cpuid>
    80005570:	00006497          	auipc	s1,0x6
    80005574:	b0048493          	addi	s1,s1,-1280 # 8000b070 <started>
    80005578:	02050263          	beqz	a0,8000559c <system_main+0x48>
    8000557c:	0004a783          	lw	a5,0(s1)
    80005580:	0007879b          	sext.w	a5,a5
    80005584:	fe078ce3          	beqz	a5,8000557c <system_main+0x28>
    80005588:	0ff0000f          	fence
    8000558c:	00003517          	auipc	a0,0x3
    80005590:	09c50513          	addi	a0,a0,156 # 80008628 <CONSOLE_STATUS+0x618>
    80005594:	00001097          	auipc	ra,0x1
    80005598:	a78080e7          	jalr	-1416(ra) # 8000600c <panic>
    8000559c:	00001097          	auipc	ra,0x1
    800055a0:	9cc080e7          	jalr	-1588(ra) # 80005f68 <consoleinit>
    800055a4:	00001097          	auipc	ra,0x1
    800055a8:	158080e7          	jalr	344(ra) # 800066fc <printfinit>
    800055ac:	00003517          	auipc	a0,0x3
    800055b0:	b6c50513          	addi	a0,a0,-1172 # 80008118 <CONSOLE_STATUS+0x108>
    800055b4:	00001097          	auipc	ra,0x1
    800055b8:	ab4080e7          	jalr	-1356(ra) # 80006068 <__printf>
    800055bc:	00003517          	auipc	a0,0x3
    800055c0:	03c50513          	addi	a0,a0,60 # 800085f8 <CONSOLE_STATUS+0x5e8>
    800055c4:	00001097          	auipc	ra,0x1
    800055c8:	aa4080e7          	jalr	-1372(ra) # 80006068 <__printf>
    800055cc:	00003517          	auipc	a0,0x3
    800055d0:	b4c50513          	addi	a0,a0,-1204 # 80008118 <CONSOLE_STATUS+0x108>
    800055d4:	00001097          	auipc	ra,0x1
    800055d8:	a94080e7          	jalr	-1388(ra) # 80006068 <__printf>
    800055dc:	00001097          	auipc	ra,0x1
    800055e0:	4ac080e7          	jalr	1196(ra) # 80006a88 <kinit>
    800055e4:	00000097          	auipc	ra,0x0
    800055e8:	148080e7          	jalr	328(ra) # 8000572c <trapinit>
    800055ec:	00000097          	auipc	ra,0x0
    800055f0:	16c080e7          	jalr	364(ra) # 80005758 <trapinithart>
    800055f4:	00000097          	auipc	ra,0x0
    800055f8:	5bc080e7          	jalr	1468(ra) # 80005bb0 <plicinit>
    800055fc:	00000097          	auipc	ra,0x0
    80005600:	5dc080e7          	jalr	1500(ra) # 80005bd8 <plicinithart>
    80005604:	00000097          	auipc	ra,0x0
    80005608:	078080e7          	jalr	120(ra) # 8000567c <userinit>
    8000560c:	0ff0000f          	fence
    80005610:	00100793          	li	a5,1
    80005614:	00003517          	auipc	a0,0x3
    80005618:	ffc50513          	addi	a0,a0,-4 # 80008610 <CONSOLE_STATUS+0x600>
    8000561c:	00f4a023          	sw	a5,0(s1)
    80005620:	00001097          	auipc	ra,0x1
    80005624:	a48080e7          	jalr	-1464(ra) # 80006068 <__printf>
    80005628:	0000006f          	j	80005628 <system_main+0xd4>

000000008000562c <cpuid>:
    8000562c:	ff010113          	addi	sp,sp,-16
    80005630:	00813423          	sd	s0,8(sp)
    80005634:	01010413          	addi	s0,sp,16
    80005638:	00020513          	mv	a0,tp
    8000563c:	00813403          	ld	s0,8(sp)
    80005640:	0005051b          	sext.w	a0,a0
    80005644:	01010113          	addi	sp,sp,16
    80005648:	00008067          	ret

000000008000564c <mycpu>:
    8000564c:	ff010113          	addi	sp,sp,-16
    80005650:	00813423          	sd	s0,8(sp)
    80005654:	01010413          	addi	s0,sp,16
    80005658:	00020793          	mv	a5,tp
    8000565c:	00813403          	ld	s0,8(sp)
    80005660:	0007879b          	sext.w	a5,a5
    80005664:	00779793          	slli	a5,a5,0x7
    80005668:	00007517          	auipc	a0,0x7
    8000566c:	cb850513          	addi	a0,a0,-840 # 8000c320 <cpus>
    80005670:	00f50533          	add	a0,a0,a5
    80005674:	01010113          	addi	sp,sp,16
    80005678:	00008067          	ret

000000008000567c <userinit>:
    8000567c:	ff010113          	addi	sp,sp,-16
    80005680:	00813423          	sd	s0,8(sp)
    80005684:	01010413          	addi	s0,sp,16
    80005688:	00813403          	ld	s0,8(sp)
    8000568c:	01010113          	addi	sp,sp,16
    80005690:	ffffc317          	auipc	t1,0xffffc
    80005694:	7f030067          	jr	2032(t1) # 80001e80 <main>

0000000080005698 <either_copyout>:
    80005698:	ff010113          	addi	sp,sp,-16
    8000569c:	00813023          	sd	s0,0(sp)
    800056a0:	00113423          	sd	ra,8(sp)
    800056a4:	01010413          	addi	s0,sp,16
    800056a8:	02051663          	bnez	a0,800056d4 <either_copyout+0x3c>
    800056ac:	00058513          	mv	a0,a1
    800056b0:	00060593          	mv	a1,a2
    800056b4:	0006861b          	sext.w	a2,a3
    800056b8:	00002097          	auipc	ra,0x2
    800056bc:	c5c080e7          	jalr	-932(ra) # 80007314 <__memmove>
    800056c0:	00813083          	ld	ra,8(sp)
    800056c4:	00013403          	ld	s0,0(sp)
    800056c8:	00000513          	li	a0,0
    800056cc:	01010113          	addi	sp,sp,16
    800056d0:	00008067          	ret
    800056d4:	00003517          	auipc	a0,0x3
    800056d8:	f7c50513          	addi	a0,a0,-132 # 80008650 <CONSOLE_STATUS+0x640>
    800056dc:	00001097          	auipc	ra,0x1
    800056e0:	930080e7          	jalr	-1744(ra) # 8000600c <panic>

00000000800056e4 <either_copyin>:
    800056e4:	ff010113          	addi	sp,sp,-16
    800056e8:	00813023          	sd	s0,0(sp)
    800056ec:	00113423          	sd	ra,8(sp)
    800056f0:	01010413          	addi	s0,sp,16
    800056f4:	02059463          	bnez	a1,8000571c <either_copyin+0x38>
    800056f8:	00060593          	mv	a1,a2
    800056fc:	0006861b          	sext.w	a2,a3
    80005700:	00002097          	auipc	ra,0x2
    80005704:	c14080e7          	jalr	-1004(ra) # 80007314 <__memmove>
    80005708:	00813083          	ld	ra,8(sp)
    8000570c:	00013403          	ld	s0,0(sp)
    80005710:	00000513          	li	a0,0
    80005714:	01010113          	addi	sp,sp,16
    80005718:	00008067          	ret
    8000571c:	00003517          	auipc	a0,0x3
    80005720:	f5c50513          	addi	a0,a0,-164 # 80008678 <CONSOLE_STATUS+0x668>
    80005724:	00001097          	auipc	ra,0x1
    80005728:	8e8080e7          	jalr	-1816(ra) # 8000600c <panic>

000000008000572c <trapinit>:
    8000572c:	ff010113          	addi	sp,sp,-16
    80005730:	00813423          	sd	s0,8(sp)
    80005734:	01010413          	addi	s0,sp,16
    80005738:	00813403          	ld	s0,8(sp)
    8000573c:	00003597          	auipc	a1,0x3
    80005740:	f6458593          	addi	a1,a1,-156 # 800086a0 <CONSOLE_STATUS+0x690>
    80005744:	00007517          	auipc	a0,0x7
    80005748:	c5c50513          	addi	a0,a0,-932 # 8000c3a0 <tickslock>
    8000574c:	01010113          	addi	sp,sp,16
    80005750:	00001317          	auipc	t1,0x1
    80005754:	5c830067          	jr	1480(t1) # 80006d18 <initlock>

0000000080005758 <trapinithart>:
    80005758:	ff010113          	addi	sp,sp,-16
    8000575c:	00813423          	sd	s0,8(sp)
    80005760:	01010413          	addi	s0,sp,16
    80005764:	00000797          	auipc	a5,0x0
    80005768:	2fc78793          	addi	a5,a5,764 # 80005a60 <kernelvec>
    8000576c:	10579073          	csrw	stvec,a5
    80005770:	00813403          	ld	s0,8(sp)
    80005774:	01010113          	addi	sp,sp,16
    80005778:	00008067          	ret

000000008000577c <usertrap>:
    8000577c:	ff010113          	addi	sp,sp,-16
    80005780:	00813423          	sd	s0,8(sp)
    80005784:	01010413          	addi	s0,sp,16
    80005788:	00813403          	ld	s0,8(sp)
    8000578c:	01010113          	addi	sp,sp,16
    80005790:	00008067          	ret

0000000080005794 <usertrapret>:
    80005794:	ff010113          	addi	sp,sp,-16
    80005798:	00813423          	sd	s0,8(sp)
    8000579c:	01010413          	addi	s0,sp,16
    800057a0:	00813403          	ld	s0,8(sp)
    800057a4:	01010113          	addi	sp,sp,16
    800057a8:	00008067          	ret

00000000800057ac <kerneltrap>:
    800057ac:	fe010113          	addi	sp,sp,-32
    800057b0:	00813823          	sd	s0,16(sp)
    800057b4:	00113c23          	sd	ra,24(sp)
    800057b8:	00913423          	sd	s1,8(sp)
    800057bc:	02010413          	addi	s0,sp,32
    800057c0:	142025f3          	csrr	a1,scause
    800057c4:	100027f3          	csrr	a5,sstatus
    800057c8:	0027f793          	andi	a5,a5,2
    800057cc:	10079c63          	bnez	a5,800058e4 <kerneltrap+0x138>
    800057d0:	142027f3          	csrr	a5,scause
    800057d4:	0207ce63          	bltz	a5,80005810 <kerneltrap+0x64>
    800057d8:	00003517          	auipc	a0,0x3
    800057dc:	f1050513          	addi	a0,a0,-240 # 800086e8 <CONSOLE_STATUS+0x6d8>
    800057e0:	00001097          	auipc	ra,0x1
    800057e4:	888080e7          	jalr	-1912(ra) # 80006068 <__printf>
    800057e8:	141025f3          	csrr	a1,sepc
    800057ec:	14302673          	csrr	a2,stval
    800057f0:	00003517          	auipc	a0,0x3
    800057f4:	f0850513          	addi	a0,a0,-248 # 800086f8 <CONSOLE_STATUS+0x6e8>
    800057f8:	00001097          	auipc	ra,0x1
    800057fc:	870080e7          	jalr	-1936(ra) # 80006068 <__printf>
    80005800:	00003517          	auipc	a0,0x3
    80005804:	f1050513          	addi	a0,a0,-240 # 80008710 <CONSOLE_STATUS+0x700>
    80005808:	00001097          	auipc	ra,0x1
    8000580c:	804080e7          	jalr	-2044(ra) # 8000600c <panic>
    80005810:	0ff7f713          	andi	a4,a5,255
    80005814:	00900693          	li	a3,9
    80005818:	04d70063          	beq	a4,a3,80005858 <kerneltrap+0xac>
    8000581c:	fff00713          	li	a4,-1
    80005820:	03f71713          	slli	a4,a4,0x3f
    80005824:	00170713          	addi	a4,a4,1
    80005828:	fae798e3          	bne	a5,a4,800057d8 <kerneltrap+0x2c>
    8000582c:	00000097          	auipc	ra,0x0
    80005830:	e00080e7          	jalr	-512(ra) # 8000562c <cpuid>
    80005834:	06050663          	beqz	a0,800058a0 <kerneltrap+0xf4>
    80005838:	144027f3          	csrr	a5,sip
    8000583c:	ffd7f793          	andi	a5,a5,-3
    80005840:	14479073          	csrw	sip,a5
    80005844:	01813083          	ld	ra,24(sp)
    80005848:	01013403          	ld	s0,16(sp)
    8000584c:	00813483          	ld	s1,8(sp)
    80005850:	02010113          	addi	sp,sp,32
    80005854:	00008067          	ret
    80005858:	00000097          	auipc	ra,0x0
    8000585c:	3cc080e7          	jalr	972(ra) # 80005c24 <plic_claim>
    80005860:	00a00793          	li	a5,10
    80005864:	00050493          	mv	s1,a0
    80005868:	06f50863          	beq	a0,a5,800058d8 <kerneltrap+0x12c>
    8000586c:	fc050ce3          	beqz	a0,80005844 <kerneltrap+0x98>
    80005870:	00050593          	mv	a1,a0
    80005874:	00003517          	auipc	a0,0x3
    80005878:	e5450513          	addi	a0,a0,-428 # 800086c8 <CONSOLE_STATUS+0x6b8>
    8000587c:	00000097          	auipc	ra,0x0
    80005880:	7ec080e7          	jalr	2028(ra) # 80006068 <__printf>
    80005884:	01013403          	ld	s0,16(sp)
    80005888:	01813083          	ld	ra,24(sp)
    8000588c:	00048513          	mv	a0,s1
    80005890:	00813483          	ld	s1,8(sp)
    80005894:	02010113          	addi	sp,sp,32
    80005898:	00000317          	auipc	t1,0x0
    8000589c:	3c430067          	jr	964(t1) # 80005c5c <plic_complete>
    800058a0:	00007517          	auipc	a0,0x7
    800058a4:	b0050513          	addi	a0,a0,-1280 # 8000c3a0 <tickslock>
    800058a8:	00001097          	auipc	ra,0x1
    800058ac:	494080e7          	jalr	1172(ra) # 80006d3c <acquire>
    800058b0:	00005717          	auipc	a4,0x5
    800058b4:	7c470713          	addi	a4,a4,1988 # 8000b074 <ticks>
    800058b8:	00072783          	lw	a5,0(a4)
    800058bc:	00007517          	auipc	a0,0x7
    800058c0:	ae450513          	addi	a0,a0,-1308 # 8000c3a0 <tickslock>
    800058c4:	0017879b          	addiw	a5,a5,1
    800058c8:	00f72023          	sw	a5,0(a4)
    800058cc:	00001097          	auipc	ra,0x1
    800058d0:	53c080e7          	jalr	1340(ra) # 80006e08 <release>
    800058d4:	f65ff06f          	j	80005838 <kerneltrap+0x8c>
    800058d8:	00001097          	auipc	ra,0x1
    800058dc:	098080e7          	jalr	152(ra) # 80006970 <uartintr>
    800058e0:	fa5ff06f          	j	80005884 <kerneltrap+0xd8>
    800058e4:	00003517          	auipc	a0,0x3
    800058e8:	dc450513          	addi	a0,a0,-572 # 800086a8 <CONSOLE_STATUS+0x698>
    800058ec:	00000097          	auipc	ra,0x0
    800058f0:	720080e7          	jalr	1824(ra) # 8000600c <panic>

00000000800058f4 <clockintr>:
    800058f4:	fe010113          	addi	sp,sp,-32
    800058f8:	00813823          	sd	s0,16(sp)
    800058fc:	00913423          	sd	s1,8(sp)
    80005900:	00113c23          	sd	ra,24(sp)
    80005904:	02010413          	addi	s0,sp,32
    80005908:	00007497          	auipc	s1,0x7
    8000590c:	a9848493          	addi	s1,s1,-1384 # 8000c3a0 <tickslock>
    80005910:	00048513          	mv	a0,s1
    80005914:	00001097          	auipc	ra,0x1
    80005918:	428080e7          	jalr	1064(ra) # 80006d3c <acquire>
    8000591c:	00005717          	auipc	a4,0x5
    80005920:	75870713          	addi	a4,a4,1880 # 8000b074 <ticks>
    80005924:	00072783          	lw	a5,0(a4)
    80005928:	01013403          	ld	s0,16(sp)
    8000592c:	01813083          	ld	ra,24(sp)
    80005930:	00048513          	mv	a0,s1
    80005934:	0017879b          	addiw	a5,a5,1
    80005938:	00813483          	ld	s1,8(sp)
    8000593c:	00f72023          	sw	a5,0(a4)
    80005940:	02010113          	addi	sp,sp,32
    80005944:	00001317          	auipc	t1,0x1
    80005948:	4c430067          	jr	1220(t1) # 80006e08 <release>

000000008000594c <devintr>:
    8000594c:	142027f3          	csrr	a5,scause
    80005950:	00000513          	li	a0,0
    80005954:	0007c463          	bltz	a5,8000595c <devintr+0x10>
    80005958:	00008067          	ret
    8000595c:	fe010113          	addi	sp,sp,-32
    80005960:	00813823          	sd	s0,16(sp)
    80005964:	00113c23          	sd	ra,24(sp)
    80005968:	00913423          	sd	s1,8(sp)
    8000596c:	02010413          	addi	s0,sp,32
    80005970:	0ff7f713          	andi	a4,a5,255
    80005974:	00900693          	li	a3,9
    80005978:	04d70c63          	beq	a4,a3,800059d0 <devintr+0x84>
    8000597c:	fff00713          	li	a4,-1
    80005980:	03f71713          	slli	a4,a4,0x3f
    80005984:	00170713          	addi	a4,a4,1
    80005988:	00e78c63          	beq	a5,a4,800059a0 <devintr+0x54>
    8000598c:	01813083          	ld	ra,24(sp)
    80005990:	01013403          	ld	s0,16(sp)
    80005994:	00813483          	ld	s1,8(sp)
    80005998:	02010113          	addi	sp,sp,32
    8000599c:	00008067          	ret
    800059a0:	00000097          	auipc	ra,0x0
    800059a4:	c8c080e7          	jalr	-884(ra) # 8000562c <cpuid>
    800059a8:	06050663          	beqz	a0,80005a14 <devintr+0xc8>
    800059ac:	144027f3          	csrr	a5,sip
    800059b0:	ffd7f793          	andi	a5,a5,-3
    800059b4:	14479073          	csrw	sip,a5
    800059b8:	01813083          	ld	ra,24(sp)
    800059bc:	01013403          	ld	s0,16(sp)
    800059c0:	00813483          	ld	s1,8(sp)
    800059c4:	00200513          	li	a0,2
    800059c8:	02010113          	addi	sp,sp,32
    800059cc:	00008067          	ret
    800059d0:	00000097          	auipc	ra,0x0
    800059d4:	254080e7          	jalr	596(ra) # 80005c24 <plic_claim>
    800059d8:	00a00793          	li	a5,10
    800059dc:	00050493          	mv	s1,a0
    800059e0:	06f50663          	beq	a0,a5,80005a4c <devintr+0x100>
    800059e4:	00100513          	li	a0,1
    800059e8:	fa0482e3          	beqz	s1,8000598c <devintr+0x40>
    800059ec:	00048593          	mv	a1,s1
    800059f0:	00003517          	auipc	a0,0x3
    800059f4:	cd850513          	addi	a0,a0,-808 # 800086c8 <CONSOLE_STATUS+0x6b8>
    800059f8:	00000097          	auipc	ra,0x0
    800059fc:	670080e7          	jalr	1648(ra) # 80006068 <__printf>
    80005a00:	00048513          	mv	a0,s1
    80005a04:	00000097          	auipc	ra,0x0
    80005a08:	258080e7          	jalr	600(ra) # 80005c5c <plic_complete>
    80005a0c:	00100513          	li	a0,1
    80005a10:	f7dff06f          	j	8000598c <devintr+0x40>
    80005a14:	00007517          	auipc	a0,0x7
    80005a18:	98c50513          	addi	a0,a0,-1652 # 8000c3a0 <tickslock>
    80005a1c:	00001097          	auipc	ra,0x1
    80005a20:	320080e7          	jalr	800(ra) # 80006d3c <acquire>
    80005a24:	00005717          	auipc	a4,0x5
    80005a28:	65070713          	addi	a4,a4,1616 # 8000b074 <ticks>
    80005a2c:	00072783          	lw	a5,0(a4)
    80005a30:	00007517          	auipc	a0,0x7
    80005a34:	97050513          	addi	a0,a0,-1680 # 8000c3a0 <tickslock>
    80005a38:	0017879b          	addiw	a5,a5,1
    80005a3c:	00f72023          	sw	a5,0(a4)
    80005a40:	00001097          	auipc	ra,0x1
    80005a44:	3c8080e7          	jalr	968(ra) # 80006e08 <release>
    80005a48:	f65ff06f          	j	800059ac <devintr+0x60>
    80005a4c:	00001097          	auipc	ra,0x1
    80005a50:	f24080e7          	jalr	-220(ra) # 80006970 <uartintr>
    80005a54:	fadff06f          	j	80005a00 <devintr+0xb4>
	...

0000000080005a60 <kernelvec>:
    80005a60:	f0010113          	addi	sp,sp,-256
    80005a64:	00113023          	sd	ra,0(sp)
    80005a68:	00213423          	sd	sp,8(sp)
    80005a6c:	00313823          	sd	gp,16(sp)
    80005a70:	00413c23          	sd	tp,24(sp)
    80005a74:	02513023          	sd	t0,32(sp)
    80005a78:	02613423          	sd	t1,40(sp)
    80005a7c:	02713823          	sd	t2,48(sp)
    80005a80:	02813c23          	sd	s0,56(sp)
    80005a84:	04913023          	sd	s1,64(sp)
    80005a88:	04a13423          	sd	a0,72(sp)
    80005a8c:	04b13823          	sd	a1,80(sp)
    80005a90:	04c13c23          	sd	a2,88(sp)
    80005a94:	06d13023          	sd	a3,96(sp)
    80005a98:	06e13423          	sd	a4,104(sp)
    80005a9c:	06f13823          	sd	a5,112(sp)
    80005aa0:	07013c23          	sd	a6,120(sp)
    80005aa4:	09113023          	sd	a7,128(sp)
    80005aa8:	09213423          	sd	s2,136(sp)
    80005aac:	09313823          	sd	s3,144(sp)
    80005ab0:	09413c23          	sd	s4,152(sp)
    80005ab4:	0b513023          	sd	s5,160(sp)
    80005ab8:	0b613423          	sd	s6,168(sp)
    80005abc:	0b713823          	sd	s7,176(sp)
    80005ac0:	0b813c23          	sd	s8,184(sp)
    80005ac4:	0d913023          	sd	s9,192(sp)
    80005ac8:	0da13423          	sd	s10,200(sp)
    80005acc:	0db13823          	sd	s11,208(sp)
    80005ad0:	0dc13c23          	sd	t3,216(sp)
    80005ad4:	0fd13023          	sd	t4,224(sp)
    80005ad8:	0fe13423          	sd	t5,232(sp)
    80005adc:	0ff13823          	sd	t6,240(sp)
    80005ae0:	ccdff0ef          	jal	ra,800057ac <kerneltrap>
    80005ae4:	00013083          	ld	ra,0(sp)
    80005ae8:	00813103          	ld	sp,8(sp)
    80005aec:	01013183          	ld	gp,16(sp)
    80005af0:	02013283          	ld	t0,32(sp)
    80005af4:	02813303          	ld	t1,40(sp)
    80005af8:	03013383          	ld	t2,48(sp)
    80005afc:	03813403          	ld	s0,56(sp)
    80005b00:	04013483          	ld	s1,64(sp)
    80005b04:	04813503          	ld	a0,72(sp)
    80005b08:	05013583          	ld	a1,80(sp)
    80005b0c:	05813603          	ld	a2,88(sp)
    80005b10:	06013683          	ld	a3,96(sp)
    80005b14:	06813703          	ld	a4,104(sp)
    80005b18:	07013783          	ld	a5,112(sp)
    80005b1c:	07813803          	ld	a6,120(sp)
    80005b20:	08013883          	ld	a7,128(sp)
    80005b24:	08813903          	ld	s2,136(sp)
    80005b28:	09013983          	ld	s3,144(sp)
    80005b2c:	09813a03          	ld	s4,152(sp)
    80005b30:	0a013a83          	ld	s5,160(sp)
    80005b34:	0a813b03          	ld	s6,168(sp)
    80005b38:	0b013b83          	ld	s7,176(sp)
    80005b3c:	0b813c03          	ld	s8,184(sp)
    80005b40:	0c013c83          	ld	s9,192(sp)
    80005b44:	0c813d03          	ld	s10,200(sp)
    80005b48:	0d013d83          	ld	s11,208(sp)
    80005b4c:	0d813e03          	ld	t3,216(sp)
    80005b50:	0e013e83          	ld	t4,224(sp)
    80005b54:	0e813f03          	ld	t5,232(sp)
    80005b58:	0f013f83          	ld	t6,240(sp)
    80005b5c:	10010113          	addi	sp,sp,256
    80005b60:	10200073          	sret
    80005b64:	00000013          	nop
    80005b68:	00000013          	nop
    80005b6c:	00000013          	nop

0000000080005b70 <timervec>:
    80005b70:	34051573          	csrrw	a0,mscratch,a0
    80005b74:	00b53023          	sd	a1,0(a0)
    80005b78:	00c53423          	sd	a2,8(a0)
    80005b7c:	00d53823          	sd	a3,16(a0)
    80005b80:	01853583          	ld	a1,24(a0)
    80005b84:	02053603          	ld	a2,32(a0)
    80005b88:	0005b683          	ld	a3,0(a1)
    80005b8c:	00c686b3          	add	a3,a3,a2
    80005b90:	00d5b023          	sd	a3,0(a1)
    80005b94:	00200593          	li	a1,2
    80005b98:	14459073          	csrw	sip,a1
    80005b9c:	01053683          	ld	a3,16(a0)
    80005ba0:	00853603          	ld	a2,8(a0)
    80005ba4:	00053583          	ld	a1,0(a0)
    80005ba8:	34051573          	csrrw	a0,mscratch,a0
    80005bac:	30200073          	mret

0000000080005bb0 <plicinit>:
    80005bb0:	ff010113          	addi	sp,sp,-16
    80005bb4:	00813423          	sd	s0,8(sp)
    80005bb8:	01010413          	addi	s0,sp,16
    80005bbc:	00813403          	ld	s0,8(sp)
    80005bc0:	0c0007b7          	lui	a5,0xc000
    80005bc4:	00100713          	li	a4,1
    80005bc8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80005bcc:	00e7a223          	sw	a4,4(a5)
    80005bd0:	01010113          	addi	sp,sp,16
    80005bd4:	00008067          	ret

0000000080005bd8 <plicinithart>:
    80005bd8:	ff010113          	addi	sp,sp,-16
    80005bdc:	00813023          	sd	s0,0(sp)
    80005be0:	00113423          	sd	ra,8(sp)
    80005be4:	01010413          	addi	s0,sp,16
    80005be8:	00000097          	auipc	ra,0x0
    80005bec:	a44080e7          	jalr	-1468(ra) # 8000562c <cpuid>
    80005bf0:	0085171b          	slliw	a4,a0,0x8
    80005bf4:	0c0027b7          	lui	a5,0xc002
    80005bf8:	00e787b3          	add	a5,a5,a4
    80005bfc:	40200713          	li	a4,1026
    80005c00:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005c04:	00813083          	ld	ra,8(sp)
    80005c08:	00013403          	ld	s0,0(sp)
    80005c0c:	00d5151b          	slliw	a0,a0,0xd
    80005c10:	0c2017b7          	lui	a5,0xc201
    80005c14:	00a78533          	add	a0,a5,a0
    80005c18:	00052023          	sw	zero,0(a0)
    80005c1c:	01010113          	addi	sp,sp,16
    80005c20:	00008067          	ret

0000000080005c24 <plic_claim>:
    80005c24:	ff010113          	addi	sp,sp,-16
    80005c28:	00813023          	sd	s0,0(sp)
    80005c2c:	00113423          	sd	ra,8(sp)
    80005c30:	01010413          	addi	s0,sp,16
    80005c34:	00000097          	auipc	ra,0x0
    80005c38:	9f8080e7          	jalr	-1544(ra) # 8000562c <cpuid>
    80005c3c:	00813083          	ld	ra,8(sp)
    80005c40:	00013403          	ld	s0,0(sp)
    80005c44:	00d5151b          	slliw	a0,a0,0xd
    80005c48:	0c2017b7          	lui	a5,0xc201
    80005c4c:	00a78533          	add	a0,a5,a0
    80005c50:	00452503          	lw	a0,4(a0)
    80005c54:	01010113          	addi	sp,sp,16
    80005c58:	00008067          	ret

0000000080005c5c <plic_complete>:
    80005c5c:	fe010113          	addi	sp,sp,-32
    80005c60:	00813823          	sd	s0,16(sp)
    80005c64:	00913423          	sd	s1,8(sp)
    80005c68:	00113c23          	sd	ra,24(sp)
    80005c6c:	02010413          	addi	s0,sp,32
    80005c70:	00050493          	mv	s1,a0
    80005c74:	00000097          	auipc	ra,0x0
    80005c78:	9b8080e7          	jalr	-1608(ra) # 8000562c <cpuid>
    80005c7c:	01813083          	ld	ra,24(sp)
    80005c80:	01013403          	ld	s0,16(sp)
    80005c84:	00d5179b          	slliw	a5,a0,0xd
    80005c88:	0c201737          	lui	a4,0xc201
    80005c8c:	00f707b3          	add	a5,a4,a5
    80005c90:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005c94:	00813483          	ld	s1,8(sp)
    80005c98:	02010113          	addi	sp,sp,32
    80005c9c:	00008067          	ret

0000000080005ca0 <consolewrite>:
    80005ca0:	fb010113          	addi	sp,sp,-80
    80005ca4:	04813023          	sd	s0,64(sp)
    80005ca8:	04113423          	sd	ra,72(sp)
    80005cac:	02913c23          	sd	s1,56(sp)
    80005cb0:	03213823          	sd	s2,48(sp)
    80005cb4:	03313423          	sd	s3,40(sp)
    80005cb8:	03413023          	sd	s4,32(sp)
    80005cbc:	01513c23          	sd	s5,24(sp)
    80005cc0:	05010413          	addi	s0,sp,80
    80005cc4:	06c05c63          	blez	a2,80005d3c <consolewrite+0x9c>
    80005cc8:	00060993          	mv	s3,a2
    80005ccc:	00050a13          	mv	s4,a0
    80005cd0:	00058493          	mv	s1,a1
    80005cd4:	00000913          	li	s2,0
    80005cd8:	fff00a93          	li	s5,-1
    80005cdc:	01c0006f          	j	80005cf8 <consolewrite+0x58>
    80005ce0:	fbf44503          	lbu	a0,-65(s0)
    80005ce4:	0019091b          	addiw	s2,s2,1
    80005ce8:	00148493          	addi	s1,s1,1
    80005cec:	00001097          	auipc	ra,0x1
    80005cf0:	a9c080e7          	jalr	-1380(ra) # 80006788 <uartputc>
    80005cf4:	03298063          	beq	s3,s2,80005d14 <consolewrite+0x74>
    80005cf8:	00048613          	mv	a2,s1
    80005cfc:	00100693          	li	a3,1
    80005d00:	000a0593          	mv	a1,s4
    80005d04:	fbf40513          	addi	a0,s0,-65
    80005d08:	00000097          	auipc	ra,0x0
    80005d0c:	9dc080e7          	jalr	-1572(ra) # 800056e4 <either_copyin>
    80005d10:	fd5518e3          	bne	a0,s5,80005ce0 <consolewrite+0x40>
    80005d14:	04813083          	ld	ra,72(sp)
    80005d18:	04013403          	ld	s0,64(sp)
    80005d1c:	03813483          	ld	s1,56(sp)
    80005d20:	02813983          	ld	s3,40(sp)
    80005d24:	02013a03          	ld	s4,32(sp)
    80005d28:	01813a83          	ld	s5,24(sp)
    80005d2c:	00090513          	mv	a0,s2
    80005d30:	03013903          	ld	s2,48(sp)
    80005d34:	05010113          	addi	sp,sp,80
    80005d38:	00008067          	ret
    80005d3c:	00000913          	li	s2,0
    80005d40:	fd5ff06f          	j	80005d14 <consolewrite+0x74>

0000000080005d44 <consoleread>:
    80005d44:	f9010113          	addi	sp,sp,-112
    80005d48:	06813023          	sd	s0,96(sp)
    80005d4c:	04913c23          	sd	s1,88(sp)
    80005d50:	05213823          	sd	s2,80(sp)
    80005d54:	05313423          	sd	s3,72(sp)
    80005d58:	05413023          	sd	s4,64(sp)
    80005d5c:	03513c23          	sd	s5,56(sp)
    80005d60:	03613823          	sd	s6,48(sp)
    80005d64:	03713423          	sd	s7,40(sp)
    80005d68:	03813023          	sd	s8,32(sp)
    80005d6c:	06113423          	sd	ra,104(sp)
    80005d70:	01913c23          	sd	s9,24(sp)
    80005d74:	07010413          	addi	s0,sp,112
    80005d78:	00060b93          	mv	s7,a2
    80005d7c:	00050913          	mv	s2,a0
    80005d80:	00058c13          	mv	s8,a1
    80005d84:	00060b1b          	sext.w	s6,a2
    80005d88:	00006497          	auipc	s1,0x6
    80005d8c:	64048493          	addi	s1,s1,1600 # 8000c3c8 <cons>
    80005d90:	00400993          	li	s3,4
    80005d94:	fff00a13          	li	s4,-1
    80005d98:	00a00a93          	li	s5,10
    80005d9c:	05705e63          	blez	s7,80005df8 <consoleread+0xb4>
    80005da0:	09c4a703          	lw	a4,156(s1)
    80005da4:	0984a783          	lw	a5,152(s1)
    80005da8:	0007071b          	sext.w	a4,a4
    80005dac:	08e78463          	beq	a5,a4,80005e34 <consoleread+0xf0>
    80005db0:	07f7f713          	andi	a4,a5,127
    80005db4:	00e48733          	add	a4,s1,a4
    80005db8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005dbc:	0017869b          	addiw	a3,a5,1
    80005dc0:	08d4ac23          	sw	a3,152(s1)
    80005dc4:	00070c9b          	sext.w	s9,a4
    80005dc8:	0b370663          	beq	a4,s3,80005e74 <consoleread+0x130>
    80005dcc:	00100693          	li	a3,1
    80005dd0:	f9f40613          	addi	a2,s0,-97
    80005dd4:	000c0593          	mv	a1,s8
    80005dd8:	00090513          	mv	a0,s2
    80005ddc:	f8e40fa3          	sb	a4,-97(s0)
    80005de0:	00000097          	auipc	ra,0x0
    80005de4:	8b8080e7          	jalr	-1864(ra) # 80005698 <either_copyout>
    80005de8:	01450863          	beq	a0,s4,80005df8 <consoleread+0xb4>
    80005dec:	001c0c13          	addi	s8,s8,1
    80005df0:	fffb8b9b          	addiw	s7,s7,-1
    80005df4:	fb5c94e3          	bne	s9,s5,80005d9c <consoleread+0x58>
    80005df8:	000b851b          	sext.w	a0,s7
    80005dfc:	06813083          	ld	ra,104(sp)
    80005e00:	06013403          	ld	s0,96(sp)
    80005e04:	05813483          	ld	s1,88(sp)
    80005e08:	05013903          	ld	s2,80(sp)
    80005e0c:	04813983          	ld	s3,72(sp)
    80005e10:	04013a03          	ld	s4,64(sp)
    80005e14:	03813a83          	ld	s5,56(sp)
    80005e18:	02813b83          	ld	s7,40(sp)
    80005e1c:	02013c03          	ld	s8,32(sp)
    80005e20:	01813c83          	ld	s9,24(sp)
    80005e24:	40ab053b          	subw	a0,s6,a0
    80005e28:	03013b03          	ld	s6,48(sp)
    80005e2c:	07010113          	addi	sp,sp,112
    80005e30:	00008067          	ret
    80005e34:	00001097          	auipc	ra,0x1
    80005e38:	1d8080e7          	jalr	472(ra) # 8000700c <push_on>
    80005e3c:	0984a703          	lw	a4,152(s1)
    80005e40:	09c4a783          	lw	a5,156(s1)
    80005e44:	0007879b          	sext.w	a5,a5
    80005e48:	fef70ce3          	beq	a4,a5,80005e40 <consoleread+0xfc>
    80005e4c:	00001097          	auipc	ra,0x1
    80005e50:	234080e7          	jalr	564(ra) # 80007080 <pop_on>
    80005e54:	0984a783          	lw	a5,152(s1)
    80005e58:	07f7f713          	andi	a4,a5,127
    80005e5c:	00e48733          	add	a4,s1,a4
    80005e60:	01874703          	lbu	a4,24(a4)
    80005e64:	0017869b          	addiw	a3,a5,1
    80005e68:	08d4ac23          	sw	a3,152(s1)
    80005e6c:	00070c9b          	sext.w	s9,a4
    80005e70:	f5371ee3          	bne	a4,s3,80005dcc <consoleread+0x88>
    80005e74:	000b851b          	sext.w	a0,s7
    80005e78:	f96bf2e3          	bgeu	s7,s6,80005dfc <consoleread+0xb8>
    80005e7c:	08f4ac23          	sw	a5,152(s1)
    80005e80:	f7dff06f          	j	80005dfc <consoleread+0xb8>

0000000080005e84 <consputc>:
    80005e84:	10000793          	li	a5,256
    80005e88:	00f50663          	beq	a0,a5,80005e94 <consputc+0x10>
    80005e8c:	00001317          	auipc	t1,0x1
    80005e90:	9f430067          	jr	-1548(t1) # 80006880 <uartputc_sync>
    80005e94:	ff010113          	addi	sp,sp,-16
    80005e98:	00113423          	sd	ra,8(sp)
    80005e9c:	00813023          	sd	s0,0(sp)
    80005ea0:	01010413          	addi	s0,sp,16
    80005ea4:	00800513          	li	a0,8
    80005ea8:	00001097          	auipc	ra,0x1
    80005eac:	9d8080e7          	jalr	-1576(ra) # 80006880 <uartputc_sync>
    80005eb0:	02000513          	li	a0,32
    80005eb4:	00001097          	auipc	ra,0x1
    80005eb8:	9cc080e7          	jalr	-1588(ra) # 80006880 <uartputc_sync>
    80005ebc:	00013403          	ld	s0,0(sp)
    80005ec0:	00813083          	ld	ra,8(sp)
    80005ec4:	00800513          	li	a0,8
    80005ec8:	01010113          	addi	sp,sp,16
    80005ecc:	00001317          	auipc	t1,0x1
    80005ed0:	9b430067          	jr	-1612(t1) # 80006880 <uartputc_sync>

0000000080005ed4 <consoleintr>:
    80005ed4:	fe010113          	addi	sp,sp,-32
    80005ed8:	00813823          	sd	s0,16(sp)
    80005edc:	00913423          	sd	s1,8(sp)
    80005ee0:	01213023          	sd	s2,0(sp)
    80005ee4:	00113c23          	sd	ra,24(sp)
    80005ee8:	02010413          	addi	s0,sp,32
    80005eec:	00006917          	auipc	s2,0x6
    80005ef0:	4dc90913          	addi	s2,s2,1244 # 8000c3c8 <cons>
    80005ef4:	00050493          	mv	s1,a0
    80005ef8:	00090513          	mv	a0,s2
    80005efc:	00001097          	auipc	ra,0x1
    80005f00:	e40080e7          	jalr	-448(ra) # 80006d3c <acquire>
    80005f04:	02048c63          	beqz	s1,80005f3c <consoleintr+0x68>
    80005f08:	0a092783          	lw	a5,160(s2)
    80005f0c:	09892703          	lw	a4,152(s2)
    80005f10:	07f00693          	li	a3,127
    80005f14:	40e7873b          	subw	a4,a5,a4
    80005f18:	02e6e263          	bltu	a3,a4,80005f3c <consoleintr+0x68>
    80005f1c:	00d00713          	li	a4,13
    80005f20:	04e48063          	beq	s1,a4,80005f60 <consoleintr+0x8c>
    80005f24:	07f7f713          	andi	a4,a5,127
    80005f28:	00e90733          	add	a4,s2,a4
    80005f2c:	0017879b          	addiw	a5,a5,1
    80005f30:	0af92023          	sw	a5,160(s2)
    80005f34:	00970c23          	sb	s1,24(a4)
    80005f38:	08f92e23          	sw	a5,156(s2)
    80005f3c:	01013403          	ld	s0,16(sp)
    80005f40:	01813083          	ld	ra,24(sp)
    80005f44:	00813483          	ld	s1,8(sp)
    80005f48:	00013903          	ld	s2,0(sp)
    80005f4c:	00006517          	auipc	a0,0x6
    80005f50:	47c50513          	addi	a0,a0,1148 # 8000c3c8 <cons>
    80005f54:	02010113          	addi	sp,sp,32
    80005f58:	00001317          	auipc	t1,0x1
    80005f5c:	eb030067          	jr	-336(t1) # 80006e08 <release>
    80005f60:	00a00493          	li	s1,10
    80005f64:	fc1ff06f          	j	80005f24 <consoleintr+0x50>

0000000080005f68 <consoleinit>:
    80005f68:	fe010113          	addi	sp,sp,-32
    80005f6c:	00113c23          	sd	ra,24(sp)
    80005f70:	00813823          	sd	s0,16(sp)
    80005f74:	00913423          	sd	s1,8(sp)
    80005f78:	02010413          	addi	s0,sp,32
    80005f7c:	00006497          	auipc	s1,0x6
    80005f80:	44c48493          	addi	s1,s1,1100 # 8000c3c8 <cons>
    80005f84:	00048513          	mv	a0,s1
    80005f88:	00002597          	auipc	a1,0x2
    80005f8c:	79858593          	addi	a1,a1,1944 # 80008720 <CONSOLE_STATUS+0x710>
    80005f90:	00001097          	auipc	ra,0x1
    80005f94:	d88080e7          	jalr	-632(ra) # 80006d18 <initlock>
    80005f98:	00000097          	auipc	ra,0x0
    80005f9c:	7ac080e7          	jalr	1964(ra) # 80006744 <uartinit>
    80005fa0:	01813083          	ld	ra,24(sp)
    80005fa4:	01013403          	ld	s0,16(sp)
    80005fa8:	00000797          	auipc	a5,0x0
    80005fac:	d9c78793          	addi	a5,a5,-612 # 80005d44 <consoleread>
    80005fb0:	0af4bc23          	sd	a5,184(s1)
    80005fb4:	00000797          	auipc	a5,0x0
    80005fb8:	cec78793          	addi	a5,a5,-788 # 80005ca0 <consolewrite>
    80005fbc:	0cf4b023          	sd	a5,192(s1)
    80005fc0:	00813483          	ld	s1,8(sp)
    80005fc4:	02010113          	addi	sp,sp,32
    80005fc8:	00008067          	ret

0000000080005fcc <console_read>:
    80005fcc:	ff010113          	addi	sp,sp,-16
    80005fd0:	00813423          	sd	s0,8(sp)
    80005fd4:	01010413          	addi	s0,sp,16
    80005fd8:	00813403          	ld	s0,8(sp)
    80005fdc:	00006317          	auipc	t1,0x6
    80005fe0:	4a433303          	ld	t1,1188(t1) # 8000c480 <devsw+0x10>
    80005fe4:	01010113          	addi	sp,sp,16
    80005fe8:	00030067          	jr	t1

0000000080005fec <console_write>:
    80005fec:	ff010113          	addi	sp,sp,-16
    80005ff0:	00813423          	sd	s0,8(sp)
    80005ff4:	01010413          	addi	s0,sp,16
    80005ff8:	00813403          	ld	s0,8(sp)
    80005ffc:	00006317          	auipc	t1,0x6
    80006000:	48c33303          	ld	t1,1164(t1) # 8000c488 <devsw+0x18>
    80006004:	01010113          	addi	sp,sp,16
    80006008:	00030067          	jr	t1

000000008000600c <panic>:
    8000600c:	fe010113          	addi	sp,sp,-32
    80006010:	00113c23          	sd	ra,24(sp)
    80006014:	00813823          	sd	s0,16(sp)
    80006018:	00913423          	sd	s1,8(sp)
    8000601c:	02010413          	addi	s0,sp,32
    80006020:	00050493          	mv	s1,a0
    80006024:	00002517          	auipc	a0,0x2
    80006028:	70450513          	addi	a0,a0,1796 # 80008728 <CONSOLE_STATUS+0x718>
    8000602c:	00006797          	auipc	a5,0x6
    80006030:	4e07ae23          	sw	zero,1276(a5) # 8000c528 <pr+0x18>
    80006034:	00000097          	auipc	ra,0x0
    80006038:	034080e7          	jalr	52(ra) # 80006068 <__printf>
    8000603c:	00048513          	mv	a0,s1
    80006040:	00000097          	auipc	ra,0x0
    80006044:	028080e7          	jalr	40(ra) # 80006068 <__printf>
    80006048:	00002517          	auipc	a0,0x2
    8000604c:	0d050513          	addi	a0,a0,208 # 80008118 <CONSOLE_STATUS+0x108>
    80006050:	00000097          	auipc	ra,0x0
    80006054:	018080e7          	jalr	24(ra) # 80006068 <__printf>
    80006058:	00100793          	li	a5,1
    8000605c:	00005717          	auipc	a4,0x5
    80006060:	00f72e23          	sw	a5,28(a4) # 8000b078 <panicked>
    80006064:	0000006f          	j	80006064 <panic+0x58>

0000000080006068 <__printf>:
    80006068:	f3010113          	addi	sp,sp,-208
    8000606c:	08813023          	sd	s0,128(sp)
    80006070:	07313423          	sd	s3,104(sp)
    80006074:	09010413          	addi	s0,sp,144
    80006078:	05813023          	sd	s8,64(sp)
    8000607c:	08113423          	sd	ra,136(sp)
    80006080:	06913c23          	sd	s1,120(sp)
    80006084:	07213823          	sd	s2,112(sp)
    80006088:	07413023          	sd	s4,96(sp)
    8000608c:	05513c23          	sd	s5,88(sp)
    80006090:	05613823          	sd	s6,80(sp)
    80006094:	05713423          	sd	s7,72(sp)
    80006098:	03913c23          	sd	s9,56(sp)
    8000609c:	03a13823          	sd	s10,48(sp)
    800060a0:	03b13423          	sd	s11,40(sp)
    800060a4:	00006317          	auipc	t1,0x6
    800060a8:	46c30313          	addi	t1,t1,1132 # 8000c510 <pr>
    800060ac:	01832c03          	lw	s8,24(t1)
    800060b0:	00b43423          	sd	a1,8(s0)
    800060b4:	00c43823          	sd	a2,16(s0)
    800060b8:	00d43c23          	sd	a3,24(s0)
    800060bc:	02e43023          	sd	a4,32(s0)
    800060c0:	02f43423          	sd	a5,40(s0)
    800060c4:	03043823          	sd	a6,48(s0)
    800060c8:	03143c23          	sd	a7,56(s0)
    800060cc:	00050993          	mv	s3,a0
    800060d0:	4a0c1663          	bnez	s8,8000657c <__printf+0x514>
    800060d4:	60098c63          	beqz	s3,800066ec <__printf+0x684>
    800060d8:	0009c503          	lbu	a0,0(s3)
    800060dc:	00840793          	addi	a5,s0,8
    800060e0:	f6f43c23          	sd	a5,-136(s0)
    800060e4:	00000493          	li	s1,0
    800060e8:	22050063          	beqz	a0,80006308 <__printf+0x2a0>
    800060ec:	00002a37          	lui	s4,0x2
    800060f0:	00018ab7          	lui	s5,0x18
    800060f4:	000f4b37          	lui	s6,0xf4
    800060f8:	00989bb7          	lui	s7,0x989
    800060fc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006100:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006104:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006108:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000610c:	00148c9b          	addiw	s9,s1,1
    80006110:	02500793          	li	a5,37
    80006114:	01998933          	add	s2,s3,s9
    80006118:	38f51263          	bne	a0,a5,8000649c <__printf+0x434>
    8000611c:	00094783          	lbu	a5,0(s2)
    80006120:	00078c9b          	sext.w	s9,a5
    80006124:	1e078263          	beqz	a5,80006308 <__printf+0x2a0>
    80006128:	0024849b          	addiw	s1,s1,2
    8000612c:	07000713          	li	a4,112
    80006130:	00998933          	add	s2,s3,s1
    80006134:	38e78a63          	beq	a5,a4,800064c8 <__printf+0x460>
    80006138:	20f76863          	bltu	a4,a5,80006348 <__printf+0x2e0>
    8000613c:	42a78863          	beq	a5,a0,8000656c <__printf+0x504>
    80006140:	06400713          	li	a4,100
    80006144:	40e79663          	bne	a5,a4,80006550 <__printf+0x4e8>
    80006148:	f7843783          	ld	a5,-136(s0)
    8000614c:	0007a603          	lw	a2,0(a5)
    80006150:	00878793          	addi	a5,a5,8
    80006154:	f6f43c23          	sd	a5,-136(s0)
    80006158:	42064a63          	bltz	a2,8000658c <__printf+0x524>
    8000615c:	00a00713          	li	a4,10
    80006160:	02e677bb          	remuw	a5,a2,a4
    80006164:	00002d97          	auipc	s11,0x2
    80006168:	5ecd8d93          	addi	s11,s11,1516 # 80008750 <digits>
    8000616c:	00900593          	li	a1,9
    80006170:	0006051b          	sext.w	a0,a2
    80006174:	00000c93          	li	s9,0
    80006178:	02079793          	slli	a5,a5,0x20
    8000617c:	0207d793          	srli	a5,a5,0x20
    80006180:	00fd87b3          	add	a5,s11,a5
    80006184:	0007c783          	lbu	a5,0(a5)
    80006188:	02e656bb          	divuw	a3,a2,a4
    8000618c:	f8f40023          	sb	a5,-128(s0)
    80006190:	14c5d863          	bge	a1,a2,800062e0 <__printf+0x278>
    80006194:	06300593          	li	a1,99
    80006198:	00100c93          	li	s9,1
    8000619c:	02e6f7bb          	remuw	a5,a3,a4
    800061a0:	02079793          	slli	a5,a5,0x20
    800061a4:	0207d793          	srli	a5,a5,0x20
    800061a8:	00fd87b3          	add	a5,s11,a5
    800061ac:	0007c783          	lbu	a5,0(a5)
    800061b0:	02e6d73b          	divuw	a4,a3,a4
    800061b4:	f8f400a3          	sb	a5,-127(s0)
    800061b8:	12a5f463          	bgeu	a1,a0,800062e0 <__printf+0x278>
    800061bc:	00a00693          	li	a3,10
    800061c0:	00900593          	li	a1,9
    800061c4:	02d777bb          	remuw	a5,a4,a3
    800061c8:	02079793          	slli	a5,a5,0x20
    800061cc:	0207d793          	srli	a5,a5,0x20
    800061d0:	00fd87b3          	add	a5,s11,a5
    800061d4:	0007c503          	lbu	a0,0(a5)
    800061d8:	02d757bb          	divuw	a5,a4,a3
    800061dc:	f8a40123          	sb	a0,-126(s0)
    800061e0:	48e5f263          	bgeu	a1,a4,80006664 <__printf+0x5fc>
    800061e4:	06300513          	li	a0,99
    800061e8:	02d7f5bb          	remuw	a1,a5,a3
    800061ec:	02059593          	slli	a1,a1,0x20
    800061f0:	0205d593          	srli	a1,a1,0x20
    800061f4:	00bd85b3          	add	a1,s11,a1
    800061f8:	0005c583          	lbu	a1,0(a1)
    800061fc:	02d7d7bb          	divuw	a5,a5,a3
    80006200:	f8b401a3          	sb	a1,-125(s0)
    80006204:	48e57263          	bgeu	a0,a4,80006688 <__printf+0x620>
    80006208:	3e700513          	li	a0,999
    8000620c:	02d7f5bb          	remuw	a1,a5,a3
    80006210:	02059593          	slli	a1,a1,0x20
    80006214:	0205d593          	srli	a1,a1,0x20
    80006218:	00bd85b3          	add	a1,s11,a1
    8000621c:	0005c583          	lbu	a1,0(a1)
    80006220:	02d7d7bb          	divuw	a5,a5,a3
    80006224:	f8b40223          	sb	a1,-124(s0)
    80006228:	46e57663          	bgeu	a0,a4,80006694 <__printf+0x62c>
    8000622c:	02d7f5bb          	remuw	a1,a5,a3
    80006230:	02059593          	slli	a1,a1,0x20
    80006234:	0205d593          	srli	a1,a1,0x20
    80006238:	00bd85b3          	add	a1,s11,a1
    8000623c:	0005c583          	lbu	a1,0(a1)
    80006240:	02d7d7bb          	divuw	a5,a5,a3
    80006244:	f8b402a3          	sb	a1,-123(s0)
    80006248:	46ea7863          	bgeu	s4,a4,800066b8 <__printf+0x650>
    8000624c:	02d7f5bb          	remuw	a1,a5,a3
    80006250:	02059593          	slli	a1,a1,0x20
    80006254:	0205d593          	srli	a1,a1,0x20
    80006258:	00bd85b3          	add	a1,s11,a1
    8000625c:	0005c583          	lbu	a1,0(a1)
    80006260:	02d7d7bb          	divuw	a5,a5,a3
    80006264:	f8b40323          	sb	a1,-122(s0)
    80006268:	3eeaf863          	bgeu	s5,a4,80006658 <__printf+0x5f0>
    8000626c:	02d7f5bb          	remuw	a1,a5,a3
    80006270:	02059593          	slli	a1,a1,0x20
    80006274:	0205d593          	srli	a1,a1,0x20
    80006278:	00bd85b3          	add	a1,s11,a1
    8000627c:	0005c583          	lbu	a1,0(a1)
    80006280:	02d7d7bb          	divuw	a5,a5,a3
    80006284:	f8b403a3          	sb	a1,-121(s0)
    80006288:	42eb7e63          	bgeu	s6,a4,800066c4 <__printf+0x65c>
    8000628c:	02d7f5bb          	remuw	a1,a5,a3
    80006290:	02059593          	slli	a1,a1,0x20
    80006294:	0205d593          	srli	a1,a1,0x20
    80006298:	00bd85b3          	add	a1,s11,a1
    8000629c:	0005c583          	lbu	a1,0(a1)
    800062a0:	02d7d7bb          	divuw	a5,a5,a3
    800062a4:	f8b40423          	sb	a1,-120(s0)
    800062a8:	42ebfc63          	bgeu	s7,a4,800066e0 <__printf+0x678>
    800062ac:	02079793          	slli	a5,a5,0x20
    800062b0:	0207d793          	srli	a5,a5,0x20
    800062b4:	00fd8db3          	add	s11,s11,a5
    800062b8:	000dc703          	lbu	a4,0(s11)
    800062bc:	00a00793          	li	a5,10
    800062c0:	00900c93          	li	s9,9
    800062c4:	f8e404a3          	sb	a4,-119(s0)
    800062c8:	00065c63          	bgez	a2,800062e0 <__printf+0x278>
    800062cc:	f9040713          	addi	a4,s0,-112
    800062d0:	00f70733          	add	a4,a4,a5
    800062d4:	02d00693          	li	a3,45
    800062d8:	fed70823          	sb	a3,-16(a4)
    800062dc:	00078c93          	mv	s9,a5
    800062e0:	f8040793          	addi	a5,s0,-128
    800062e4:	01978cb3          	add	s9,a5,s9
    800062e8:	f7f40d13          	addi	s10,s0,-129
    800062ec:	000cc503          	lbu	a0,0(s9)
    800062f0:	fffc8c93          	addi	s9,s9,-1
    800062f4:	00000097          	auipc	ra,0x0
    800062f8:	b90080e7          	jalr	-1136(ra) # 80005e84 <consputc>
    800062fc:	ffac98e3          	bne	s9,s10,800062ec <__printf+0x284>
    80006300:	00094503          	lbu	a0,0(s2)
    80006304:	e00514e3          	bnez	a0,8000610c <__printf+0xa4>
    80006308:	1a0c1663          	bnez	s8,800064b4 <__printf+0x44c>
    8000630c:	08813083          	ld	ra,136(sp)
    80006310:	08013403          	ld	s0,128(sp)
    80006314:	07813483          	ld	s1,120(sp)
    80006318:	07013903          	ld	s2,112(sp)
    8000631c:	06813983          	ld	s3,104(sp)
    80006320:	06013a03          	ld	s4,96(sp)
    80006324:	05813a83          	ld	s5,88(sp)
    80006328:	05013b03          	ld	s6,80(sp)
    8000632c:	04813b83          	ld	s7,72(sp)
    80006330:	04013c03          	ld	s8,64(sp)
    80006334:	03813c83          	ld	s9,56(sp)
    80006338:	03013d03          	ld	s10,48(sp)
    8000633c:	02813d83          	ld	s11,40(sp)
    80006340:	0d010113          	addi	sp,sp,208
    80006344:	00008067          	ret
    80006348:	07300713          	li	a4,115
    8000634c:	1ce78a63          	beq	a5,a4,80006520 <__printf+0x4b8>
    80006350:	07800713          	li	a4,120
    80006354:	1ee79e63          	bne	a5,a4,80006550 <__printf+0x4e8>
    80006358:	f7843783          	ld	a5,-136(s0)
    8000635c:	0007a703          	lw	a4,0(a5)
    80006360:	00878793          	addi	a5,a5,8
    80006364:	f6f43c23          	sd	a5,-136(s0)
    80006368:	28074263          	bltz	a4,800065ec <__printf+0x584>
    8000636c:	00002d97          	auipc	s11,0x2
    80006370:	3e4d8d93          	addi	s11,s11,996 # 80008750 <digits>
    80006374:	00f77793          	andi	a5,a4,15
    80006378:	00fd87b3          	add	a5,s11,a5
    8000637c:	0007c683          	lbu	a3,0(a5)
    80006380:	00f00613          	li	a2,15
    80006384:	0007079b          	sext.w	a5,a4
    80006388:	f8d40023          	sb	a3,-128(s0)
    8000638c:	0047559b          	srliw	a1,a4,0x4
    80006390:	0047569b          	srliw	a3,a4,0x4
    80006394:	00000c93          	li	s9,0
    80006398:	0ee65063          	bge	a2,a4,80006478 <__printf+0x410>
    8000639c:	00f6f693          	andi	a3,a3,15
    800063a0:	00dd86b3          	add	a3,s11,a3
    800063a4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800063a8:	0087d79b          	srliw	a5,a5,0x8
    800063ac:	00100c93          	li	s9,1
    800063b0:	f8d400a3          	sb	a3,-127(s0)
    800063b4:	0cb67263          	bgeu	a2,a1,80006478 <__printf+0x410>
    800063b8:	00f7f693          	andi	a3,a5,15
    800063bc:	00dd86b3          	add	a3,s11,a3
    800063c0:	0006c583          	lbu	a1,0(a3)
    800063c4:	00f00613          	li	a2,15
    800063c8:	0047d69b          	srliw	a3,a5,0x4
    800063cc:	f8b40123          	sb	a1,-126(s0)
    800063d0:	0047d593          	srli	a1,a5,0x4
    800063d4:	28f67e63          	bgeu	a2,a5,80006670 <__printf+0x608>
    800063d8:	00f6f693          	andi	a3,a3,15
    800063dc:	00dd86b3          	add	a3,s11,a3
    800063e0:	0006c503          	lbu	a0,0(a3)
    800063e4:	0087d813          	srli	a6,a5,0x8
    800063e8:	0087d69b          	srliw	a3,a5,0x8
    800063ec:	f8a401a3          	sb	a0,-125(s0)
    800063f0:	28b67663          	bgeu	a2,a1,8000667c <__printf+0x614>
    800063f4:	00f6f693          	andi	a3,a3,15
    800063f8:	00dd86b3          	add	a3,s11,a3
    800063fc:	0006c583          	lbu	a1,0(a3)
    80006400:	00c7d513          	srli	a0,a5,0xc
    80006404:	00c7d69b          	srliw	a3,a5,0xc
    80006408:	f8b40223          	sb	a1,-124(s0)
    8000640c:	29067a63          	bgeu	a2,a6,800066a0 <__printf+0x638>
    80006410:	00f6f693          	andi	a3,a3,15
    80006414:	00dd86b3          	add	a3,s11,a3
    80006418:	0006c583          	lbu	a1,0(a3)
    8000641c:	0107d813          	srli	a6,a5,0x10
    80006420:	0107d69b          	srliw	a3,a5,0x10
    80006424:	f8b402a3          	sb	a1,-123(s0)
    80006428:	28a67263          	bgeu	a2,a0,800066ac <__printf+0x644>
    8000642c:	00f6f693          	andi	a3,a3,15
    80006430:	00dd86b3          	add	a3,s11,a3
    80006434:	0006c683          	lbu	a3,0(a3)
    80006438:	0147d79b          	srliw	a5,a5,0x14
    8000643c:	f8d40323          	sb	a3,-122(s0)
    80006440:	21067663          	bgeu	a2,a6,8000664c <__printf+0x5e4>
    80006444:	02079793          	slli	a5,a5,0x20
    80006448:	0207d793          	srli	a5,a5,0x20
    8000644c:	00fd8db3          	add	s11,s11,a5
    80006450:	000dc683          	lbu	a3,0(s11)
    80006454:	00800793          	li	a5,8
    80006458:	00700c93          	li	s9,7
    8000645c:	f8d403a3          	sb	a3,-121(s0)
    80006460:	00075c63          	bgez	a4,80006478 <__printf+0x410>
    80006464:	f9040713          	addi	a4,s0,-112
    80006468:	00f70733          	add	a4,a4,a5
    8000646c:	02d00693          	li	a3,45
    80006470:	fed70823          	sb	a3,-16(a4)
    80006474:	00078c93          	mv	s9,a5
    80006478:	f8040793          	addi	a5,s0,-128
    8000647c:	01978cb3          	add	s9,a5,s9
    80006480:	f7f40d13          	addi	s10,s0,-129
    80006484:	000cc503          	lbu	a0,0(s9)
    80006488:	fffc8c93          	addi	s9,s9,-1
    8000648c:	00000097          	auipc	ra,0x0
    80006490:	9f8080e7          	jalr	-1544(ra) # 80005e84 <consputc>
    80006494:	ff9d18e3          	bne	s10,s9,80006484 <__printf+0x41c>
    80006498:	0100006f          	j	800064a8 <__printf+0x440>
    8000649c:	00000097          	auipc	ra,0x0
    800064a0:	9e8080e7          	jalr	-1560(ra) # 80005e84 <consputc>
    800064a4:	000c8493          	mv	s1,s9
    800064a8:	00094503          	lbu	a0,0(s2)
    800064ac:	c60510e3          	bnez	a0,8000610c <__printf+0xa4>
    800064b0:	e40c0ee3          	beqz	s8,8000630c <__printf+0x2a4>
    800064b4:	00006517          	auipc	a0,0x6
    800064b8:	05c50513          	addi	a0,a0,92 # 8000c510 <pr>
    800064bc:	00001097          	auipc	ra,0x1
    800064c0:	94c080e7          	jalr	-1716(ra) # 80006e08 <release>
    800064c4:	e49ff06f          	j	8000630c <__printf+0x2a4>
    800064c8:	f7843783          	ld	a5,-136(s0)
    800064cc:	03000513          	li	a0,48
    800064d0:	01000d13          	li	s10,16
    800064d4:	00878713          	addi	a4,a5,8
    800064d8:	0007bc83          	ld	s9,0(a5)
    800064dc:	f6e43c23          	sd	a4,-136(s0)
    800064e0:	00000097          	auipc	ra,0x0
    800064e4:	9a4080e7          	jalr	-1628(ra) # 80005e84 <consputc>
    800064e8:	07800513          	li	a0,120
    800064ec:	00000097          	auipc	ra,0x0
    800064f0:	998080e7          	jalr	-1640(ra) # 80005e84 <consputc>
    800064f4:	00002d97          	auipc	s11,0x2
    800064f8:	25cd8d93          	addi	s11,s11,604 # 80008750 <digits>
    800064fc:	03ccd793          	srli	a5,s9,0x3c
    80006500:	00fd87b3          	add	a5,s11,a5
    80006504:	0007c503          	lbu	a0,0(a5)
    80006508:	fffd0d1b          	addiw	s10,s10,-1
    8000650c:	004c9c93          	slli	s9,s9,0x4
    80006510:	00000097          	auipc	ra,0x0
    80006514:	974080e7          	jalr	-1676(ra) # 80005e84 <consputc>
    80006518:	fe0d12e3          	bnez	s10,800064fc <__printf+0x494>
    8000651c:	f8dff06f          	j	800064a8 <__printf+0x440>
    80006520:	f7843783          	ld	a5,-136(s0)
    80006524:	0007bc83          	ld	s9,0(a5)
    80006528:	00878793          	addi	a5,a5,8
    8000652c:	f6f43c23          	sd	a5,-136(s0)
    80006530:	000c9a63          	bnez	s9,80006544 <__printf+0x4dc>
    80006534:	1080006f          	j	8000663c <__printf+0x5d4>
    80006538:	001c8c93          	addi	s9,s9,1
    8000653c:	00000097          	auipc	ra,0x0
    80006540:	948080e7          	jalr	-1720(ra) # 80005e84 <consputc>
    80006544:	000cc503          	lbu	a0,0(s9)
    80006548:	fe0518e3          	bnez	a0,80006538 <__printf+0x4d0>
    8000654c:	f5dff06f          	j	800064a8 <__printf+0x440>
    80006550:	02500513          	li	a0,37
    80006554:	00000097          	auipc	ra,0x0
    80006558:	930080e7          	jalr	-1744(ra) # 80005e84 <consputc>
    8000655c:	000c8513          	mv	a0,s9
    80006560:	00000097          	auipc	ra,0x0
    80006564:	924080e7          	jalr	-1756(ra) # 80005e84 <consputc>
    80006568:	f41ff06f          	j	800064a8 <__printf+0x440>
    8000656c:	02500513          	li	a0,37
    80006570:	00000097          	auipc	ra,0x0
    80006574:	914080e7          	jalr	-1772(ra) # 80005e84 <consputc>
    80006578:	f31ff06f          	j	800064a8 <__printf+0x440>
    8000657c:	00030513          	mv	a0,t1
    80006580:	00000097          	auipc	ra,0x0
    80006584:	7bc080e7          	jalr	1980(ra) # 80006d3c <acquire>
    80006588:	b4dff06f          	j	800060d4 <__printf+0x6c>
    8000658c:	40c0053b          	negw	a0,a2
    80006590:	00a00713          	li	a4,10
    80006594:	02e576bb          	remuw	a3,a0,a4
    80006598:	00002d97          	auipc	s11,0x2
    8000659c:	1b8d8d93          	addi	s11,s11,440 # 80008750 <digits>
    800065a0:	ff700593          	li	a1,-9
    800065a4:	02069693          	slli	a3,a3,0x20
    800065a8:	0206d693          	srli	a3,a3,0x20
    800065ac:	00dd86b3          	add	a3,s11,a3
    800065b0:	0006c683          	lbu	a3,0(a3)
    800065b4:	02e557bb          	divuw	a5,a0,a4
    800065b8:	f8d40023          	sb	a3,-128(s0)
    800065bc:	10b65e63          	bge	a2,a1,800066d8 <__printf+0x670>
    800065c0:	06300593          	li	a1,99
    800065c4:	02e7f6bb          	remuw	a3,a5,a4
    800065c8:	02069693          	slli	a3,a3,0x20
    800065cc:	0206d693          	srli	a3,a3,0x20
    800065d0:	00dd86b3          	add	a3,s11,a3
    800065d4:	0006c683          	lbu	a3,0(a3)
    800065d8:	02e7d73b          	divuw	a4,a5,a4
    800065dc:	00200793          	li	a5,2
    800065e0:	f8d400a3          	sb	a3,-127(s0)
    800065e4:	bca5ece3          	bltu	a1,a0,800061bc <__printf+0x154>
    800065e8:	ce5ff06f          	j	800062cc <__printf+0x264>
    800065ec:	40e007bb          	negw	a5,a4
    800065f0:	00002d97          	auipc	s11,0x2
    800065f4:	160d8d93          	addi	s11,s11,352 # 80008750 <digits>
    800065f8:	00f7f693          	andi	a3,a5,15
    800065fc:	00dd86b3          	add	a3,s11,a3
    80006600:	0006c583          	lbu	a1,0(a3)
    80006604:	ff100613          	li	a2,-15
    80006608:	0047d69b          	srliw	a3,a5,0x4
    8000660c:	f8b40023          	sb	a1,-128(s0)
    80006610:	0047d59b          	srliw	a1,a5,0x4
    80006614:	0ac75e63          	bge	a4,a2,800066d0 <__printf+0x668>
    80006618:	00f6f693          	andi	a3,a3,15
    8000661c:	00dd86b3          	add	a3,s11,a3
    80006620:	0006c603          	lbu	a2,0(a3)
    80006624:	00f00693          	li	a3,15
    80006628:	0087d79b          	srliw	a5,a5,0x8
    8000662c:	f8c400a3          	sb	a2,-127(s0)
    80006630:	d8b6e4e3          	bltu	a3,a1,800063b8 <__printf+0x350>
    80006634:	00200793          	li	a5,2
    80006638:	e2dff06f          	j	80006464 <__printf+0x3fc>
    8000663c:	00002c97          	auipc	s9,0x2
    80006640:	0f4c8c93          	addi	s9,s9,244 # 80008730 <CONSOLE_STATUS+0x720>
    80006644:	02800513          	li	a0,40
    80006648:	ef1ff06f          	j	80006538 <__printf+0x4d0>
    8000664c:	00700793          	li	a5,7
    80006650:	00600c93          	li	s9,6
    80006654:	e0dff06f          	j	80006460 <__printf+0x3f8>
    80006658:	00700793          	li	a5,7
    8000665c:	00600c93          	li	s9,6
    80006660:	c69ff06f          	j	800062c8 <__printf+0x260>
    80006664:	00300793          	li	a5,3
    80006668:	00200c93          	li	s9,2
    8000666c:	c5dff06f          	j	800062c8 <__printf+0x260>
    80006670:	00300793          	li	a5,3
    80006674:	00200c93          	li	s9,2
    80006678:	de9ff06f          	j	80006460 <__printf+0x3f8>
    8000667c:	00400793          	li	a5,4
    80006680:	00300c93          	li	s9,3
    80006684:	dddff06f          	j	80006460 <__printf+0x3f8>
    80006688:	00400793          	li	a5,4
    8000668c:	00300c93          	li	s9,3
    80006690:	c39ff06f          	j	800062c8 <__printf+0x260>
    80006694:	00500793          	li	a5,5
    80006698:	00400c93          	li	s9,4
    8000669c:	c2dff06f          	j	800062c8 <__printf+0x260>
    800066a0:	00500793          	li	a5,5
    800066a4:	00400c93          	li	s9,4
    800066a8:	db9ff06f          	j	80006460 <__printf+0x3f8>
    800066ac:	00600793          	li	a5,6
    800066b0:	00500c93          	li	s9,5
    800066b4:	dadff06f          	j	80006460 <__printf+0x3f8>
    800066b8:	00600793          	li	a5,6
    800066bc:	00500c93          	li	s9,5
    800066c0:	c09ff06f          	j	800062c8 <__printf+0x260>
    800066c4:	00800793          	li	a5,8
    800066c8:	00700c93          	li	s9,7
    800066cc:	bfdff06f          	j	800062c8 <__printf+0x260>
    800066d0:	00100793          	li	a5,1
    800066d4:	d91ff06f          	j	80006464 <__printf+0x3fc>
    800066d8:	00100793          	li	a5,1
    800066dc:	bf1ff06f          	j	800062cc <__printf+0x264>
    800066e0:	00900793          	li	a5,9
    800066e4:	00800c93          	li	s9,8
    800066e8:	be1ff06f          	j	800062c8 <__printf+0x260>
    800066ec:	00002517          	auipc	a0,0x2
    800066f0:	04c50513          	addi	a0,a0,76 # 80008738 <CONSOLE_STATUS+0x728>
    800066f4:	00000097          	auipc	ra,0x0
    800066f8:	918080e7          	jalr	-1768(ra) # 8000600c <panic>

00000000800066fc <printfinit>:
    800066fc:	fe010113          	addi	sp,sp,-32
    80006700:	00813823          	sd	s0,16(sp)
    80006704:	00913423          	sd	s1,8(sp)
    80006708:	00113c23          	sd	ra,24(sp)
    8000670c:	02010413          	addi	s0,sp,32
    80006710:	00006497          	auipc	s1,0x6
    80006714:	e0048493          	addi	s1,s1,-512 # 8000c510 <pr>
    80006718:	00048513          	mv	a0,s1
    8000671c:	00002597          	auipc	a1,0x2
    80006720:	02c58593          	addi	a1,a1,44 # 80008748 <CONSOLE_STATUS+0x738>
    80006724:	00000097          	auipc	ra,0x0
    80006728:	5f4080e7          	jalr	1524(ra) # 80006d18 <initlock>
    8000672c:	01813083          	ld	ra,24(sp)
    80006730:	01013403          	ld	s0,16(sp)
    80006734:	0004ac23          	sw	zero,24(s1)
    80006738:	00813483          	ld	s1,8(sp)
    8000673c:	02010113          	addi	sp,sp,32
    80006740:	00008067          	ret

0000000080006744 <uartinit>:
    80006744:	ff010113          	addi	sp,sp,-16
    80006748:	00813423          	sd	s0,8(sp)
    8000674c:	01010413          	addi	s0,sp,16
    80006750:	100007b7          	lui	a5,0x10000
    80006754:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006758:	f8000713          	li	a4,-128
    8000675c:	00e781a3          	sb	a4,3(a5)
    80006760:	00300713          	li	a4,3
    80006764:	00e78023          	sb	a4,0(a5)
    80006768:	000780a3          	sb	zero,1(a5)
    8000676c:	00e781a3          	sb	a4,3(a5)
    80006770:	00700693          	li	a3,7
    80006774:	00d78123          	sb	a3,2(a5)
    80006778:	00e780a3          	sb	a4,1(a5)
    8000677c:	00813403          	ld	s0,8(sp)
    80006780:	01010113          	addi	sp,sp,16
    80006784:	00008067          	ret

0000000080006788 <uartputc>:
    80006788:	00005797          	auipc	a5,0x5
    8000678c:	8f07a783          	lw	a5,-1808(a5) # 8000b078 <panicked>
    80006790:	00078463          	beqz	a5,80006798 <uartputc+0x10>
    80006794:	0000006f          	j	80006794 <uartputc+0xc>
    80006798:	fd010113          	addi	sp,sp,-48
    8000679c:	02813023          	sd	s0,32(sp)
    800067a0:	00913c23          	sd	s1,24(sp)
    800067a4:	01213823          	sd	s2,16(sp)
    800067a8:	01313423          	sd	s3,8(sp)
    800067ac:	02113423          	sd	ra,40(sp)
    800067b0:	03010413          	addi	s0,sp,48
    800067b4:	00005917          	auipc	s2,0x5
    800067b8:	8cc90913          	addi	s2,s2,-1844 # 8000b080 <uart_tx_r>
    800067bc:	00093783          	ld	a5,0(s2)
    800067c0:	00005497          	auipc	s1,0x5
    800067c4:	8c848493          	addi	s1,s1,-1848 # 8000b088 <uart_tx_w>
    800067c8:	0004b703          	ld	a4,0(s1)
    800067cc:	02078693          	addi	a3,a5,32
    800067d0:	00050993          	mv	s3,a0
    800067d4:	02e69c63          	bne	a3,a4,8000680c <uartputc+0x84>
    800067d8:	00001097          	auipc	ra,0x1
    800067dc:	834080e7          	jalr	-1996(ra) # 8000700c <push_on>
    800067e0:	00093783          	ld	a5,0(s2)
    800067e4:	0004b703          	ld	a4,0(s1)
    800067e8:	02078793          	addi	a5,a5,32
    800067ec:	00e79463          	bne	a5,a4,800067f4 <uartputc+0x6c>
    800067f0:	0000006f          	j	800067f0 <uartputc+0x68>
    800067f4:	00001097          	auipc	ra,0x1
    800067f8:	88c080e7          	jalr	-1908(ra) # 80007080 <pop_on>
    800067fc:	00093783          	ld	a5,0(s2)
    80006800:	0004b703          	ld	a4,0(s1)
    80006804:	02078693          	addi	a3,a5,32
    80006808:	fce688e3          	beq	a3,a4,800067d8 <uartputc+0x50>
    8000680c:	01f77693          	andi	a3,a4,31
    80006810:	00006597          	auipc	a1,0x6
    80006814:	d2058593          	addi	a1,a1,-736 # 8000c530 <uart_tx_buf>
    80006818:	00d586b3          	add	a3,a1,a3
    8000681c:	00170713          	addi	a4,a4,1
    80006820:	01368023          	sb	s3,0(a3)
    80006824:	00e4b023          	sd	a4,0(s1)
    80006828:	10000637          	lui	a2,0x10000
    8000682c:	02f71063          	bne	a4,a5,8000684c <uartputc+0xc4>
    80006830:	0340006f          	j	80006864 <uartputc+0xdc>
    80006834:	00074703          	lbu	a4,0(a4)
    80006838:	00f93023          	sd	a5,0(s2)
    8000683c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006840:	00093783          	ld	a5,0(s2)
    80006844:	0004b703          	ld	a4,0(s1)
    80006848:	00f70e63          	beq	a4,a5,80006864 <uartputc+0xdc>
    8000684c:	00564683          	lbu	a3,5(a2)
    80006850:	01f7f713          	andi	a4,a5,31
    80006854:	00e58733          	add	a4,a1,a4
    80006858:	0206f693          	andi	a3,a3,32
    8000685c:	00178793          	addi	a5,a5,1
    80006860:	fc069ae3          	bnez	a3,80006834 <uartputc+0xac>
    80006864:	02813083          	ld	ra,40(sp)
    80006868:	02013403          	ld	s0,32(sp)
    8000686c:	01813483          	ld	s1,24(sp)
    80006870:	01013903          	ld	s2,16(sp)
    80006874:	00813983          	ld	s3,8(sp)
    80006878:	03010113          	addi	sp,sp,48
    8000687c:	00008067          	ret

0000000080006880 <uartputc_sync>:
    80006880:	ff010113          	addi	sp,sp,-16
    80006884:	00813423          	sd	s0,8(sp)
    80006888:	01010413          	addi	s0,sp,16
    8000688c:	00004717          	auipc	a4,0x4
    80006890:	7ec72703          	lw	a4,2028(a4) # 8000b078 <panicked>
    80006894:	02071663          	bnez	a4,800068c0 <uartputc_sync+0x40>
    80006898:	00050793          	mv	a5,a0
    8000689c:	100006b7          	lui	a3,0x10000
    800068a0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800068a4:	02077713          	andi	a4,a4,32
    800068a8:	fe070ce3          	beqz	a4,800068a0 <uartputc_sync+0x20>
    800068ac:	0ff7f793          	andi	a5,a5,255
    800068b0:	00f68023          	sb	a5,0(a3)
    800068b4:	00813403          	ld	s0,8(sp)
    800068b8:	01010113          	addi	sp,sp,16
    800068bc:	00008067          	ret
    800068c0:	0000006f          	j	800068c0 <uartputc_sync+0x40>

00000000800068c4 <uartstart>:
    800068c4:	ff010113          	addi	sp,sp,-16
    800068c8:	00813423          	sd	s0,8(sp)
    800068cc:	01010413          	addi	s0,sp,16
    800068d0:	00004617          	auipc	a2,0x4
    800068d4:	7b060613          	addi	a2,a2,1968 # 8000b080 <uart_tx_r>
    800068d8:	00004517          	auipc	a0,0x4
    800068dc:	7b050513          	addi	a0,a0,1968 # 8000b088 <uart_tx_w>
    800068e0:	00063783          	ld	a5,0(a2)
    800068e4:	00053703          	ld	a4,0(a0)
    800068e8:	04f70263          	beq	a4,a5,8000692c <uartstart+0x68>
    800068ec:	100005b7          	lui	a1,0x10000
    800068f0:	00006817          	auipc	a6,0x6
    800068f4:	c4080813          	addi	a6,a6,-960 # 8000c530 <uart_tx_buf>
    800068f8:	01c0006f          	j	80006914 <uartstart+0x50>
    800068fc:	0006c703          	lbu	a4,0(a3)
    80006900:	00f63023          	sd	a5,0(a2)
    80006904:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006908:	00063783          	ld	a5,0(a2)
    8000690c:	00053703          	ld	a4,0(a0)
    80006910:	00f70e63          	beq	a4,a5,8000692c <uartstart+0x68>
    80006914:	01f7f713          	andi	a4,a5,31
    80006918:	00e806b3          	add	a3,a6,a4
    8000691c:	0055c703          	lbu	a4,5(a1)
    80006920:	00178793          	addi	a5,a5,1
    80006924:	02077713          	andi	a4,a4,32
    80006928:	fc071ae3          	bnez	a4,800068fc <uartstart+0x38>
    8000692c:	00813403          	ld	s0,8(sp)
    80006930:	01010113          	addi	sp,sp,16
    80006934:	00008067          	ret

0000000080006938 <uartgetc>:
    80006938:	ff010113          	addi	sp,sp,-16
    8000693c:	00813423          	sd	s0,8(sp)
    80006940:	01010413          	addi	s0,sp,16
    80006944:	10000737          	lui	a4,0x10000
    80006948:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000694c:	0017f793          	andi	a5,a5,1
    80006950:	00078c63          	beqz	a5,80006968 <uartgetc+0x30>
    80006954:	00074503          	lbu	a0,0(a4)
    80006958:	0ff57513          	andi	a0,a0,255
    8000695c:	00813403          	ld	s0,8(sp)
    80006960:	01010113          	addi	sp,sp,16
    80006964:	00008067          	ret
    80006968:	fff00513          	li	a0,-1
    8000696c:	ff1ff06f          	j	8000695c <uartgetc+0x24>

0000000080006970 <uartintr>:
    80006970:	100007b7          	lui	a5,0x10000
    80006974:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006978:	0017f793          	andi	a5,a5,1
    8000697c:	0a078463          	beqz	a5,80006a24 <uartintr+0xb4>
    80006980:	fe010113          	addi	sp,sp,-32
    80006984:	00813823          	sd	s0,16(sp)
    80006988:	00913423          	sd	s1,8(sp)
    8000698c:	00113c23          	sd	ra,24(sp)
    80006990:	02010413          	addi	s0,sp,32
    80006994:	100004b7          	lui	s1,0x10000
    80006998:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000699c:	0ff57513          	andi	a0,a0,255
    800069a0:	fffff097          	auipc	ra,0xfffff
    800069a4:	534080e7          	jalr	1332(ra) # 80005ed4 <consoleintr>
    800069a8:	0054c783          	lbu	a5,5(s1)
    800069ac:	0017f793          	andi	a5,a5,1
    800069b0:	fe0794e3          	bnez	a5,80006998 <uartintr+0x28>
    800069b4:	00004617          	auipc	a2,0x4
    800069b8:	6cc60613          	addi	a2,a2,1740 # 8000b080 <uart_tx_r>
    800069bc:	00004517          	auipc	a0,0x4
    800069c0:	6cc50513          	addi	a0,a0,1740 # 8000b088 <uart_tx_w>
    800069c4:	00063783          	ld	a5,0(a2)
    800069c8:	00053703          	ld	a4,0(a0)
    800069cc:	04f70263          	beq	a4,a5,80006a10 <uartintr+0xa0>
    800069d0:	100005b7          	lui	a1,0x10000
    800069d4:	00006817          	auipc	a6,0x6
    800069d8:	b5c80813          	addi	a6,a6,-1188 # 8000c530 <uart_tx_buf>
    800069dc:	01c0006f          	j	800069f8 <uartintr+0x88>
    800069e0:	0006c703          	lbu	a4,0(a3)
    800069e4:	00f63023          	sd	a5,0(a2)
    800069e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800069ec:	00063783          	ld	a5,0(a2)
    800069f0:	00053703          	ld	a4,0(a0)
    800069f4:	00f70e63          	beq	a4,a5,80006a10 <uartintr+0xa0>
    800069f8:	01f7f713          	andi	a4,a5,31
    800069fc:	00e806b3          	add	a3,a6,a4
    80006a00:	0055c703          	lbu	a4,5(a1)
    80006a04:	00178793          	addi	a5,a5,1
    80006a08:	02077713          	andi	a4,a4,32
    80006a0c:	fc071ae3          	bnez	a4,800069e0 <uartintr+0x70>
    80006a10:	01813083          	ld	ra,24(sp)
    80006a14:	01013403          	ld	s0,16(sp)
    80006a18:	00813483          	ld	s1,8(sp)
    80006a1c:	02010113          	addi	sp,sp,32
    80006a20:	00008067          	ret
    80006a24:	00004617          	auipc	a2,0x4
    80006a28:	65c60613          	addi	a2,a2,1628 # 8000b080 <uart_tx_r>
    80006a2c:	00004517          	auipc	a0,0x4
    80006a30:	65c50513          	addi	a0,a0,1628 # 8000b088 <uart_tx_w>
    80006a34:	00063783          	ld	a5,0(a2)
    80006a38:	00053703          	ld	a4,0(a0)
    80006a3c:	04f70263          	beq	a4,a5,80006a80 <uartintr+0x110>
    80006a40:	100005b7          	lui	a1,0x10000
    80006a44:	00006817          	auipc	a6,0x6
    80006a48:	aec80813          	addi	a6,a6,-1300 # 8000c530 <uart_tx_buf>
    80006a4c:	01c0006f          	j	80006a68 <uartintr+0xf8>
    80006a50:	0006c703          	lbu	a4,0(a3)
    80006a54:	00f63023          	sd	a5,0(a2)
    80006a58:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006a5c:	00063783          	ld	a5,0(a2)
    80006a60:	00053703          	ld	a4,0(a0)
    80006a64:	02f70063          	beq	a4,a5,80006a84 <uartintr+0x114>
    80006a68:	01f7f713          	andi	a4,a5,31
    80006a6c:	00e806b3          	add	a3,a6,a4
    80006a70:	0055c703          	lbu	a4,5(a1)
    80006a74:	00178793          	addi	a5,a5,1
    80006a78:	02077713          	andi	a4,a4,32
    80006a7c:	fc071ae3          	bnez	a4,80006a50 <uartintr+0xe0>
    80006a80:	00008067          	ret
    80006a84:	00008067          	ret

0000000080006a88 <kinit>:
    80006a88:	fc010113          	addi	sp,sp,-64
    80006a8c:	02913423          	sd	s1,40(sp)
    80006a90:	fffff7b7          	lui	a5,0xfffff
    80006a94:	0000b497          	auipc	s1,0xb
    80006a98:	56b48493          	addi	s1,s1,1387 # 80011fff <end+0xfff>
    80006a9c:	02813823          	sd	s0,48(sp)
    80006aa0:	01313c23          	sd	s3,24(sp)
    80006aa4:	00f4f4b3          	and	s1,s1,a5
    80006aa8:	02113c23          	sd	ra,56(sp)
    80006aac:	03213023          	sd	s2,32(sp)
    80006ab0:	01413823          	sd	s4,16(sp)
    80006ab4:	01513423          	sd	s5,8(sp)
    80006ab8:	04010413          	addi	s0,sp,64
    80006abc:	000017b7          	lui	a5,0x1
    80006ac0:	01100993          	li	s3,17
    80006ac4:	00f487b3          	add	a5,s1,a5
    80006ac8:	01b99993          	slli	s3,s3,0x1b
    80006acc:	06f9e063          	bltu	s3,a5,80006b2c <kinit+0xa4>
    80006ad0:	0000aa97          	auipc	s5,0xa
    80006ad4:	530a8a93          	addi	s5,s5,1328 # 80011000 <end>
    80006ad8:	0754ec63          	bltu	s1,s5,80006b50 <kinit+0xc8>
    80006adc:	0734fa63          	bgeu	s1,s3,80006b50 <kinit+0xc8>
    80006ae0:	00088a37          	lui	s4,0x88
    80006ae4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006ae8:	00004917          	auipc	s2,0x4
    80006aec:	5a890913          	addi	s2,s2,1448 # 8000b090 <kmem>
    80006af0:	00ca1a13          	slli	s4,s4,0xc
    80006af4:	0140006f          	j	80006b08 <kinit+0x80>
    80006af8:	000017b7          	lui	a5,0x1
    80006afc:	00f484b3          	add	s1,s1,a5
    80006b00:	0554e863          	bltu	s1,s5,80006b50 <kinit+0xc8>
    80006b04:	0534f663          	bgeu	s1,s3,80006b50 <kinit+0xc8>
    80006b08:	00001637          	lui	a2,0x1
    80006b0c:	00100593          	li	a1,1
    80006b10:	00048513          	mv	a0,s1
    80006b14:	00000097          	auipc	ra,0x0
    80006b18:	5e4080e7          	jalr	1508(ra) # 800070f8 <__memset>
    80006b1c:	00093783          	ld	a5,0(s2)
    80006b20:	00f4b023          	sd	a5,0(s1)
    80006b24:	00993023          	sd	s1,0(s2)
    80006b28:	fd4498e3          	bne	s1,s4,80006af8 <kinit+0x70>
    80006b2c:	03813083          	ld	ra,56(sp)
    80006b30:	03013403          	ld	s0,48(sp)
    80006b34:	02813483          	ld	s1,40(sp)
    80006b38:	02013903          	ld	s2,32(sp)
    80006b3c:	01813983          	ld	s3,24(sp)
    80006b40:	01013a03          	ld	s4,16(sp)
    80006b44:	00813a83          	ld	s5,8(sp)
    80006b48:	04010113          	addi	sp,sp,64
    80006b4c:	00008067          	ret
    80006b50:	00002517          	auipc	a0,0x2
    80006b54:	c1850513          	addi	a0,a0,-1000 # 80008768 <digits+0x18>
    80006b58:	fffff097          	auipc	ra,0xfffff
    80006b5c:	4b4080e7          	jalr	1204(ra) # 8000600c <panic>

0000000080006b60 <freerange>:
    80006b60:	fc010113          	addi	sp,sp,-64
    80006b64:	000017b7          	lui	a5,0x1
    80006b68:	02913423          	sd	s1,40(sp)
    80006b6c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006b70:	009504b3          	add	s1,a0,s1
    80006b74:	fffff537          	lui	a0,0xfffff
    80006b78:	02813823          	sd	s0,48(sp)
    80006b7c:	02113c23          	sd	ra,56(sp)
    80006b80:	03213023          	sd	s2,32(sp)
    80006b84:	01313c23          	sd	s3,24(sp)
    80006b88:	01413823          	sd	s4,16(sp)
    80006b8c:	01513423          	sd	s5,8(sp)
    80006b90:	01613023          	sd	s6,0(sp)
    80006b94:	04010413          	addi	s0,sp,64
    80006b98:	00a4f4b3          	and	s1,s1,a0
    80006b9c:	00f487b3          	add	a5,s1,a5
    80006ba0:	06f5e463          	bltu	a1,a5,80006c08 <freerange+0xa8>
    80006ba4:	0000aa97          	auipc	s5,0xa
    80006ba8:	45ca8a93          	addi	s5,s5,1116 # 80011000 <end>
    80006bac:	0954e263          	bltu	s1,s5,80006c30 <freerange+0xd0>
    80006bb0:	01100993          	li	s3,17
    80006bb4:	01b99993          	slli	s3,s3,0x1b
    80006bb8:	0734fc63          	bgeu	s1,s3,80006c30 <freerange+0xd0>
    80006bbc:	00058a13          	mv	s4,a1
    80006bc0:	00004917          	auipc	s2,0x4
    80006bc4:	4d090913          	addi	s2,s2,1232 # 8000b090 <kmem>
    80006bc8:	00002b37          	lui	s6,0x2
    80006bcc:	0140006f          	j	80006be0 <freerange+0x80>
    80006bd0:	000017b7          	lui	a5,0x1
    80006bd4:	00f484b3          	add	s1,s1,a5
    80006bd8:	0554ec63          	bltu	s1,s5,80006c30 <freerange+0xd0>
    80006bdc:	0534fa63          	bgeu	s1,s3,80006c30 <freerange+0xd0>
    80006be0:	00001637          	lui	a2,0x1
    80006be4:	00100593          	li	a1,1
    80006be8:	00048513          	mv	a0,s1
    80006bec:	00000097          	auipc	ra,0x0
    80006bf0:	50c080e7          	jalr	1292(ra) # 800070f8 <__memset>
    80006bf4:	00093703          	ld	a4,0(s2)
    80006bf8:	016487b3          	add	a5,s1,s6
    80006bfc:	00e4b023          	sd	a4,0(s1)
    80006c00:	00993023          	sd	s1,0(s2)
    80006c04:	fcfa76e3          	bgeu	s4,a5,80006bd0 <freerange+0x70>
    80006c08:	03813083          	ld	ra,56(sp)
    80006c0c:	03013403          	ld	s0,48(sp)
    80006c10:	02813483          	ld	s1,40(sp)
    80006c14:	02013903          	ld	s2,32(sp)
    80006c18:	01813983          	ld	s3,24(sp)
    80006c1c:	01013a03          	ld	s4,16(sp)
    80006c20:	00813a83          	ld	s5,8(sp)
    80006c24:	00013b03          	ld	s6,0(sp)
    80006c28:	04010113          	addi	sp,sp,64
    80006c2c:	00008067          	ret
    80006c30:	00002517          	auipc	a0,0x2
    80006c34:	b3850513          	addi	a0,a0,-1224 # 80008768 <digits+0x18>
    80006c38:	fffff097          	auipc	ra,0xfffff
    80006c3c:	3d4080e7          	jalr	980(ra) # 8000600c <panic>

0000000080006c40 <kfree>:
    80006c40:	fe010113          	addi	sp,sp,-32
    80006c44:	00813823          	sd	s0,16(sp)
    80006c48:	00113c23          	sd	ra,24(sp)
    80006c4c:	00913423          	sd	s1,8(sp)
    80006c50:	02010413          	addi	s0,sp,32
    80006c54:	03451793          	slli	a5,a0,0x34
    80006c58:	04079c63          	bnez	a5,80006cb0 <kfree+0x70>
    80006c5c:	0000a797          	auipc	a5,0xa
    80006c60:	3a478793          	addi	a5,a5,932 # 80011000 <end>
    80006c64:	00050493          	mv	s1,a0
    80006c68:	04f56463          	bltu	a0,a5,80006cb0 <kfree+0x70>
    80006c6c:	01100793          	li	a5,17
    80006c70:	01b79793          	slli	a5,a5,0x1b
    80006c74:	02f57e63          	bgeu	a0,a5,80006cb0 <kfree+0x70>
    80006c78:	00001637          	lui	a2,0x1
    80006c7c:	00100593          	li	a1,1
    80006c80:	00000097          	auipc	ra,0x0
    80006c84:	478080e7          	jalr	1144(ra) # 800070f8 <__memset>
    80006c88:	00004797          	auipc	a5,0x4
    80006c8c:	40878793          	addi	a5,a5,1032 # 8000b090 <kmem>
    80006c90:	0007b703          	ld	a4,0(a5)
    80006c94:	01813083          	ld	ra,24(sp)
    80006c98:	01013403          	ld	s0,16(sp)
    80006c9c:	00e4b023          	sd	a4,0(s1)
    80006ca0:	0097b023          	sd	s1,0(a5)
    80006ca4:	00813483          	ld	s1,8(sp)
    80006ca8:	02010113          	addi	sp,sp,32
    80006cac:	00008067          	ret
    80006cb0:	00002517          	auipc	a0,0x2
    80006cb4:	ab850513          	addi	a0,a0,-1352 # 80008768 <digits+0x18>
    80006cb8:	fffff097          	auipc	ra,0xfffff
    80006cbc:	354080e7          	jalr	852(ra) # 8000600c <panic>

0000000080006cc0 <kalloc>:
    80006cc0:	fe010113          	addi	sp,sp,-32
    80006cc4:	00813823          	sd	s0,16(sp)
    80006cc8:	00913423          	sd	s1,8(sp)
    80006ccc:	00113c23          	sd	ra,24(sp)
    80006cd0:	02010413          	addi	s0,sp,32
    80006cd4:	00004797          	auipc	a5,0x4
    80006cd8:	3bc78793          	addi	a5,a5,956 # 8000b090 <kmem>
    80006cdc:	0007b483          	ld	s1,0(a5)
    80006ce0:	02048063          	beqz	s1,80006d00 <kalloc+0x40>
    80006ce4:	0004b703          	ld	a4,0(s1)
    80006ce8:	00001637          	lui	a2,0x1
    80006cec:	00500593          	li	a1,5
    80006cf0:	00048513          	mv	a0,s1
    80006cf4:	00e7b023          	sd	a4,0(a5)
    80006cf8:	00000097          	auipc	ra,0x0
    80006cfc:	400080e7          	jalr	1024(ra) # 800070f8 <__memset>
    80006d00:	01813083          	ld	ra,24(sp)
    80006d04:	01013403          	ld	s0,16(sp)
    80006d08:	00048513          	mv	a0,s1
    80006d0c:	00813483          	ld	s1,8(sp)
    80006d10:	02010113          	addi	sp,sp,32
    80006d14:	00008067          	ret

0000000080006d18 <initlock>:
    80006d18:	ff010113          	addi	sp,sp,-16
    80006d1c:	00813423          	sd	s0,8(sp)
    80006d20:	01010413          	addi	s0,sp,16
    80006d24:	00813403          	ld	s0,8(sp)
    80006d28:	00b53423          	sd	a1,8(a0)
    80006d2c:	00052023          	sw	zero,0(a0)
    80006d30:	00053823          	sd	zero,16(a0)
    80006d34:	01010113          	addi	sp,sp,16
    80006d38:	00008067          	ret

0000000080006d3c <acquire>:
    80006d3c:	fe010113          	addi	sp,sp,-32
    80006d40:	00813823          	sd	s0,16(sp)
    80006d44:	00913423          	sd	s1,8(sp)
    80006d48:	00113c23          	sd	ra,24(sp)
    80006d4c:	01213023          	sd	s2,0(sp)
    80006d50:	02010413          	addi	s0,sp,32
    80006d54:	00050493          	mv	s1,a0
    80006d58:	10002973          	csrr	s2,sstatus
    80006d5c:	100027f3          	csrr	a5,sstatus
    80006d60:	ffd7f793          	andi	a5,a5,-3
    80006d64:	10079073          	csrw	sstatus,a5
    80006d68:	fffff097          	auipc	ra,0xfffff
    80006d6c:	8e4080e7          	jalr	-1820(ra) # 8000564c <mycpu>
    80006d70:	07852783          	lw	a5,120(a0)
    80006d74:	06078e63          	beqz	a5,80006df0 <acquire+0xb4>
    80006d78:	fffff097          	auipc	ra,0xfffff
    80006d7c:	8d4080e7          	jalr	-1836(ra) # 8000564c <mycpu>
    80006d80:	07852783          	lw	a5,120(a0)
    80006d84:	0004a703          	lw	a4,0(s1)
    80006d88:	0017879b          	addiw	a5,a5,1
    80006d8c:	06f52c23          	sw	a5,120(a0)
    80006d90:	04071063          	bnez	a4,80006dd0 <acquire+0x94>
    80006d94:	00100713          	li	a4,1
    80006d98:	00070793          	mv	a5,a4
    80006d9c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006da0:	0007879b          	sext.w	a5,a5
    80006da4:	fe079ae3          	bnez	a5,80006d98 <acquire+0x5c>
    80006da8:	0ff0000f          	fence
    80006dac:	fffff097          	auipc	ra,0xfffff
    80006db0:	8a0080e7          	jalr	-1888(ra) # 8000564c <mycpu>
    80006db4:	01813083          	ld	ra,24(sp)
    80006db8:	01013403          	ld	s0,16(sp)
    80006dbc:	00a4b823          	sd	a0,16(s1)
    80006dc0:	00013903          	ld	s2,0(sp)
    80006dc4:	00813483          	ld	s1,8(sp)
    80006dc8:	02010113          	addi	sp,sp,32
    80006dcc:	00008067          	ret
    80006dd0:	0104b903          	ld	s2,16(s1)
    80006dd4:	fffff097          	auipc	ra,0xfffff
    80006dd8:	878080e7          	jalr	-1928(ra) # 8000564c <mycpu>
    80006ddc:	faa91ce3          	bne	s2,a0,80006d94 <acquire+0x58>
    80006de0:	00002517          	auipc	a0,0x2
    80006de4:	99050513          	addi	a0,a0,-1648 # 80008770 <digits+0x20>
    80006de8:	fffff097          	auipc	ra,0xfffff
    80006dec:	224080e7          	jalr	548(ra) # 8000600c <panic>
    80006df0:	00195913          	srli	s2,s2,0x1
    80006df4:	fffff097          	auipc	ra,0xfffff
    80006df8:	858080e7          	jalr	-1960(ra) # 8000564c <mycpu>
    80006dfc:	00197913          	andi	s2,s2,1
    80006e00:	07252e23          	sw	s2,124(a0)
    80006e04:	f75ff06f          	j	80006d78 <acquire+0x3c>

0000000080006e08 <release>:
    80006e08:	fe010113          	addi	sp,sp,-32
    80006e0c:	00813823          	sd	s0,16(sp)
    80006e10:	00113c23          	sd	ra,24(sp)
    80006e14:	00913423          	sd	s1,8(sp)
    80006e18:	01213023          	sd	s2,0(sp)
    80006e1c:	02010413          	addi	s0,sp,32
    80006e20:	00052783          	lw	a5,0(a0)
    80006e24:	00079a63          	bnez	a5,80006e38 <release+0x30>
    80006e28:	00002517          	auipc	a0,0x2
    80006e2c:	95050513          	addi	a0,a0,-1712 # 80008778 <digits+0x28>
    80006e30:	fffff097          	auipc	ra,0xfffff
    80006e34:	1dc080e7          	jalr	476(ra) # 8000600c <panic>
    80006e38:	01053903          	ld	s2,16(a0)
    80006e3c:	00050493          	mv	s1,a0
    80006e40:	fffff097          	auipc	ra,0xfffff
    80006e44:	80c080e7          	jalr	-2036(ra) # 8000564c <mycpu>
    80006e48:	fea910e3          	bne	s2,a0,80006e28 <release+0x20>
    80006e4c:	0004b823          	sd	zero,16(s1)
    80006e50:	0ff0000f          	fence
    80006e54:	0f50000f          	fence	iorw,ow
    80006e58:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006e5c:	ffffe097          	auipc	ra,0xffffe
    80006e60:	7f0080e7          	jalr	2032(ra) # 8000564c <mycpu>
    80006e64:	100027f3          	csrr	a5,sstatus
    80006e68:	0027f793          	andi	a5,a5,2
    80006e6c:	04079a63          	bnez	a5,80006ec0 <release+0xb8>
    80006e70:	07852783          	lw	a5,120(a0)
    80006e74:	02f05e63          	blez	a5,80006eb0 <release+0xa8>
    80006e78:	fff7871b          	addiw	a4,a5,-1
    80006e7c:	06e52c23          	sw	a4,120(a0)
    80006e80:	00071c63          	bnez	a4,80006e98 <release+0x90>
    80006e84:	07c52783          	lw	a5,124(a0)
    80006e88:	00078863          	beqz	a5,80006e98 <release+0x90>
    80006e8c:	100027f3          	csrr	a5,sstatus
    80006e90:	0027e793          	ori	a5,a5,2
    80006e94:	10079073          	csrw	sstatus,a5
    80006e98:	01813083          	ld	ra,24(sp)
    80006e9c:	01013403          	ld	s0,16(sp)
    80006ea0:	00813483          	ld	s1,8(sp)
    80006ea4:	00013903          	ld	s2,0(sp)
    80006ea8:	02010113          	addi	sp,sp,32
    80006eac:	00008067          	ret
    80006eb0:	00002517          	auipc	a0,0x2
    80006eb4:	8e850513          	addi	a0,a0,-1816 # 80008798 <digits+0x48>
    80006eb8:	fffff097          	auipc	ra,0xfffff
    80006ebc:	154080e7          	jalr	340(ra) # 8000600c <panic>
    80006ec0:	00002517          	auipc	a0,0x2
    80006ec4:	8c050513          	addi	a0,a0,-1856 # 80008780 <digits+0x30>
    80006ec8:	fffff097          	auipc	ra,0xfffff
    80006ecc:	144080e7          	jalr	324(ra) # 8000600c <panic>

0000000080006ed0 <holding>:
    80006ed0:	00052783          	lw	a5,0(a0)
    80006ed4:	00079663          	bnez	a5,80006ee0 <holding+0x10>
    80006ed8:	00000513          	li	a0,0
    80006edc:	00008067          	ret
    80006ee0:	fe010113          	addi	sp,sp,-32
    80006ee4:	00813823          	sd	s0,16(sp)
    80006ee8:	00913423          	sd	s1,8(sp)
    80006eec:	00113c23          	sd	ra,24(sp)
    80006ef0:	02010413          	addi	s0,sp,32
    80006ef4:	01053483          	ld	s1,16(a0)
    80006ef8:	ffffe097          	auipc	ra,0xffffe
    80006efc:	754080e7          	jalr	1876(ra) # 8000564c <mycpu>
    80006f00:	01813083          	ld	ra,24(sp)
    80006f04:	01013403          	ld	s0,16(sp)
    80006f08:	40a48533          	sub	a0,s1,a0
    80006f0c:	00153513          	seqz	a0,a0
    80006f10:	00813483          	ld	s1,8(sp)
    80006f14:	02010113          	addi	sp,sp,32
    80006f18:	00008067          	ret

0000000080006f1c <push_off>:
    80006f1c:	fe010113          	addi	sp,sp,-32
    80006f20:	00813823          	sd	s0,16(sp)
    80006f24:	00113c23          	sd	ra,24(sp)
    80006f28:	00913423          	sd	s1,8(sp)
    80006f2c:	02010413          	addi	s0,sp,32
    80006f30:	100024f3          	csrr	s1,sstatus
    80006f34:	100027f3          	csrr	a5,sstatus
    80006f38:	ffd7f793          	andi	a5,a5,-3
    80006f3c:	10079073          	csrw	sstatus,a5
    80006f40:	ffffe097          	auipc	ra,0xffffe
    80006f44:	70c080e7          	jalr	1804(ra) # 8000564c <mycpu>
    80006f48:	07852783          	lw	a5,120(a0)
    80006f4c:	02078663          	beqz	a5,80006f78 <push_off+0x5c>
    80006f50:	ffffe097          	auipc	ra,0xffffe
    80006f54:	6fc080e7          	jalr	1788(ra) # 8000564c <mycpu>
    80006f58:	07852783          	lw	a5,120(a0)
    80006f5c:	01813083          	ld	ra,24(sp)
    80006f60:	01013403          	ld	s0,16(sp)
    80006f64:	0017879b          	addiw	a5,a5,1
    80006f68:	06f52c23          	sw	a5,120(a0)
    80006f6c:	00813483          	ld	s1,8(sp)
    80006f70:	02010113          	addi	sp,sp,32
    80006f74:	00008067          	ret
    80006f78:	0014d493          	srli	s1,s1,0x1
    80006f7c:	ffffe097          	auipc	ra,0xffffe
    80006f80:	6d0080e7          	jalr	1744(ra) # 8000564c <mycpu>
    80006f84:	0014f493          	andi	s1,s1,1
    80006f88:	06952e23          	sw	s1,124(a0)
    80006f8c:	fc5ff06f          	j	80006f50 <push_off+0x34>

0000000080006f90 <pop_off>:
    80006f90:	ff010113          	addi	sp,sp,-16
    80006f94:	00813023          	sd	s0,0(sp)
    80006f98:	00113423          	sd	ra,8(sp)
    80006f9c:	01010413          	addi	s0,sp,16
    80006fa0:	ffffe097          	auipc	ra,0xffffe
    80006fa4:	6ac080e7          	jalr	1708(ra) # 8000564c <mycpu>
    80006fa8:	100027f3          	csrr	a5,sstatus
    80006fac:	0027f793          	andi	a5,a5,2
    80006fb0:	04079663          	bnez	a5,80006ffc <pop_off+0x6c>
    80006fb4:	07852783          	lw	a5,120(a0)
    80006fb8:	02f05a63          	blez	a5,80006fec <pop_off+0x5c>
    80006fbc:	fff7871b          	addiw	a4,a5,-1
    80006fc0:	06e52c23          	sw	a4,120(a0)
    80006fc4:	00071c63          	bnez	a4,80006fdc <pop_off+0x4c>
    80006fc8:	07c52783          	lw	a5,124(a0)
    80006fcc:	00078863          	beqz	a5,80006fdc <pop_off+0x4c>
    80006fd0:	100027f3          	csrr	a5,sstatus
    80006fd4:	0027e793          	ori	a5,a5,2
    80006fd8:	10079073          	csrw	sstatus,a5
    80006fdc:	00813083          	ld	ra,8(sp)
    80006fe0:	00013403          	ld	s0,0(sp)
    80006fe4:	01010113          	addi	sp,sp,16
    80006fe8:	00008067          	ret
    80006fec:	00001517          	auipc	a0,0x1
    80006ff0:	7ac50513          	addi	a0,a0,1964 # 80008798 <digits+0x48>
    80006ff4:	fffff097          	auipc	ra,0xfffff
    80006ff8:	018080e7          	jalr	24(ra) # 8000600c <panic>
    80006ffc:	00001517          	auipc	a0,0x1
    80007000:	78450513          	addi	a0,a0,1924 # 80008780 <digits+0x30>
    80007004:	fffff097          	auipc	ra,0xfffff
    80007008:	008080e7          	jalr	8(ra) # 8000600c <panic>

000000008000700c <push_on>:
    8000700c:	fe010113          	addi	sp,sp,-32
    80007010:	00813823          	sd	s0,16(sp)
    80007014:	00113c23          	sd	ra,24(sp)
    80007018:	00913423          	sd	s1,8(sp)
    8000701c:	02010413          	addi	s0,sp,32
    80007020:	100024f3          	csrr	s1,sstatus
    80007024:	100027f3          	csrr	a5,sstatus
    80007028:	0027e793          	ori	a5,a5,2
    8000702c:	10079073          	csrw	sstatus,a5
    80007030:	ffffe097          	auipc	ra,0xffffe
    80007034:	61c080e7          	jalr	1564(ra) # 8000564c <mycpu>
    80007038:	07852783          	lw	a5,120(a0)
    8000703c:	02078663          	beqz	a5,80007068 <push_on+0x5c>
    80007040:	ffffe097          	auipc	ra,0xffffe
    80007044:	60c080e7          	jalr	1548(ra) # 8000564c <mycpu>
    80007048:	07852783          	lw	a5,120(a0)
    8000704c:	01813083          	ld	ra,24(sp)
    80007050:	01013403          	ld	s0,16(sp)
    80007054:	0017879b          	addiw	a5,a5,1
    80007058:	06f52c23          	sw	a5,120(a0)
    8000705c:	00813483          	ld	s1,8(sp)
    80007060:	02010113          	addi	sp,sp,32
    80007064:	00008067          	ret
    80007068:	0014d493          	srli	s1,s1,0x1
    8000706c:	ffffe097          	auipc	ra,0xffffe
    80007070:	5e0080e7          	jalr	1504(ra) # 8000564c <mycpu>
    80007074:	0014f493          	andi	s1,s1,1
    80007078:	06952e23          	sw	s1,124(a0)
    8000707c:	fc5ff06f          	j	80007040 <push_on+0x34>

0000000080007080 <pop_on>:
    80007080:	ff010113          	addi	sp,sp,-16
    80007084:	00813023          	sd	s0,0(sp)
    80007088:	00113423          	sd	ra,8(sp)
    8000708c:	01010413          	addi	s0,sp,16
    80007090:	ffffe097          	auipc	ra,0xffffe
    80007094:	5bc080e7          	jalr	1468(ra) # 8000564c <mycpu>
    80007098:	100027f3          	csrr	a5,sstatus
    8000709c:	0027f793          	andi	a5,a5,2
    800070a0:	04078463          	beqz	a5,800070e8 <pop_on+0x68>
    800070a4:	07852783          	lw	a5,120(a0)
    800070a8:	02f05863          	blez	a5,800070d8 <pop_on+0x58>
    800070ac:	fff7879b          	addiw	a5,a5,-1
    800070b0:	06f52c23          	sw	a5,120(a0)
    800070b4:	07853783          	ld	a5,120(a0)
    800070b8:	00079863          	bnez	a5,800070c8 <pop_on+0x48>
    800070bc:	100027f3          	csrr	a5,sstatus
    800070c0:	ffd7f793          	andi	a5,a5,-3
    800070c4:	10079073          	csrw	sstatus,a5
    800070c8:	00813083          	ld	ra,8(sp)
    800070cc:	00013403          	ld	s0,0(sp)
    800070d0:	01010113          	addi	sp,sp,16
    800070d4:	00008067          	ret
    800070d8:	00001517          	auipc	a0,0x1
    800070dc:	6e850513          	addi	a0,a0,1768 # 800087c0 <digits+0x70>
    800070e0:	fffff097          	auipc	ra,0xfffff
    800070e4:	f2c080e7          	jalr	-212(ra) # 8000600c <panic>
    800070e8:	00001517          	auipc	a0,0x1
    800070ec:	6b850513          	addi	a0,a0,1720 # 800087a0 <digits+0x50>
    800070f0:	fffff097          	auipc	ra,0xfffff
    800070f4:	f1c080e7          	jalr	-228(ra) # 8000600c <panic>

00000000800070f8 <__memset>:
    800070f8:	ff010113          	addi	sp,sp,-16
    800070fc:	00813423          	sd	s0,8(sp)
    80007100:	01010413          	addi	s0,sp,16
    80007104:	1a060e63          	beqz	a2,800072c0 <__memset+0x1c8>
    80007108:	40a007b3          	neg	a5,a0
    8000710c:	0077f793          	andi	a5,a5,7
    80007110:	00778693          	addi	a3,a5,7
    80007114:	00b00813          	li	a6,11
    80007118:	0ff5f593          	andi	a1,a1,255
    8000711c:	fff6071b          	addiw	a4,a2,-1
    80007120:	1b06e663          	bltu	a3,a6,800072cc <__memset+0x1d4>
    80007124:	1cd76463          	bltu	a4,a3,800072ec <__memset+0x1f4>
    80007128:	1a078e63          	beqz	a5,800072e4 <__memset+0x1ec>
    8000712c:	00b50023          	sb	a1,0(a0)
    80007130:	00100713          	li	a4,1
    80007134:	1ae78463          	beq	a5,a4,800072dc <__memset+0x1e4>
    80007138:	00b500a3          	sb	a1,1(a0)
    8000713c:	00200713          	li	a4,2
    80007140:	1ae78a63          	beq	a5,a4,800072f4 <__memset+0x1fc>
    80007144:	00b50123          	sb	a1,2(a0)
    80007148:	00300713          	li	a4,3
    8000714c:	18e78463          	beq	a5,a4,800072d4 <__memset+0x1dc>
    80007150:	00b501a3          	sb	a1,3(a0)
    80007154:	00400713          	li	a4,4
    80007158:	1ae78263          	beq	a5,a4,800072fc <__memset+0x204>
    8000715c:	00b50223          	sb	a1,4(a0)
    80007160:	00500713          	li	a4,5
    80007164:	1ae78063          	beq	a5,a4,80007304 <__memset+0x20c>
    80007168:	00b502a3          	sb	a1,5(a0)
    8000716c:	00700713          	li	a4,7
    80007170:	18e79e63          	bne	a5,a4,8000730c <__memset+0x214>
    80007174:	00b50323          	sb	a1,6(a0)
    80007178:	00700e93          	li	t4,7
    8000717c:	00859713          	slli	a4,a1,0x8
    80007180:	00e5e733          	or	a4,a1,a4
    80007184:	01059e13          	slli	t3,a1,0x10
    80007188:	01c76e33          	or	t3,a4,t3
    8000718c:	01859313          	slli	t1,a1,0x18
    80007190:	006e6333          	or	t1,t3,t1
    80007194:	02059893          	slli	a7,a1,0x20
    80007198:	40f60e3b          	subw	t3,a2,a5
    8000719c:	011368b3          	or	a7,t1,a7
    800071a0:	02859813          	slli	a6,a1,0x28
    800071a4:	0108e833          	or	a6,a7,a6
    800071a8:	03059693          	slli	a3,a1,0x30
    800071ac:	003e589b          	srliw	a7,t3,0x3
    800071b0:	00d866b3          	or	a3,a6,a3
    800071b4:	03859713          	slli	a4,a1,0x38
    800071b8:	00389813          	slli	a6,a7,0x3
    800071bc:	00f507b3          	add	a5,a0,a5
    800071c0:	00e6e733          	or	a4,a3,a4
    800071c4:	000e089b          	sext.w	a7,t3
    800071c8:	00f806b3          	add	a3,a6,a5
    800071cc:	00e7b023          	sd	a4,0(a5)
    800071d0:	00878793          	addi	a5,a5,8
    800071d4:	fed79ce3          	bne	a5,a3,800071cc <__memset+0xd4>
    800071d8:	ff8e7793          	andi	a5,t3,-8
    800071dc:	0007871b          	sext.w	a4,a5
    800071e0:	01d787bb          	addw	a5,a5,t4
    800071e4:	0ce88e63          	beq	a7,a4,800072c0 <__memset+0x1c8>
    800071e8:	00f50733          	add	a4,a0,a5
    800071ec:	00b70023          	sb	a1,0(a4)
    800071f0:	0017871b          	addiw	a4,a5,1
    800071f4:	0cc77663          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    800071f8:	00e50733          	add	a4,a0,a4
    800071fc:	00b70023          	sb	a1,0(a4)
    80007200:	0027871b          	addiw	a4,a5,2
    80007204:	0ac77e63          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007208:	00e50733          	add	a4,a0,a4
    8000720c:	00b70023          	sb	a1,0(a4)
    80007210:	0037871b          	addiw	a4,a5,3
    80007214:	0ac77663          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007218:	00e50733          	add	a4,a0,a4
    8000721c:	00b70023          	sb	a1,0(a4)
    80007220:	0047871b          	addiw	a4,a5,4
    80007224:	08c77e63          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007228:	00e50733          	add	a4,a0,a4
    8000722c:	00b70023          	sb	a1,0(a4)
    80007230:	0057871b          	addiw	a4,a5,5
    80007234:	08c77663          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007238:	00e50733          	add	a4,a0,a4
    8000723c:	00b70023          	sb	a1,0(a4)
    80007240:	0067871b          	addiw	a4,a5,6
    80007244:	06c77e63          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007248:	00e50733          	add	a4,a0,a4
    8000724c:	00b70023          	sb	a1,0(a4)
    80007250:	0077871b          	addiw	a4,a5,7
    80007254:	06c77663          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007258:	00e50733          	add	a4,a0,a4
    8000725c:	00b70023          	sb	a1,0(a4)
    80007260:	0087871b          	addiw	a4,a5,8
    80007264:	04c77e63          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007268:	00e50733          	add	a4,a0,a4
    8000726c:	00b70023          	sb	a1,0(a4)
    80007270:	0097871b          	addiw	a4,a5,9
    80007274:	04c77663          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007278:	00e50733          	add	a4,a0,a4
    8000727c:	00b70023          	sb	a1,0(a4)
    80007280:	00a7871b          	addiw	a4,a5,10
    80007284:	02c77e63          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007288:	00e50733          	add	a4,a0,a4
    8000728c:	00b70023          	sb	a1,0(a4)
    80007290:	00b7871b          	addiw	a4,a5,11
    80007294:	02c77663          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    80007298:	00e50733          	add	a4,a0,a4
    8000729c:	00b70023          	sb	a1,0(a4)
    800072a0:	00c7871b          	addiw	a4,a5,12
    800072a4:	00c77e63          	bgeu	a4,a2,800072c0 <__memset+0x1c8>
    800072a8:	00e50733          	add	a4,a0,a4
    800072ac:	00b70023          	sb	a1,0(a4)
    800072b0:	00d7879b          	addiw	a5,a5,13
    800072b4:	00c7f663          	bgeu	a5,a2,800072c0 <__memset+0x1c8>
    800072b8:	00f507b3          	add	a5,a0,a5
    800072bc:	00b78023          	sb	a1,0(a5)
    800072c0:	00813403          	ld	s0,8(sp)
    800072c4:	01010113          	addi	sp,sp,16
    800072c8:	00008067          	ret
    800072cc:	00b00693          	li	a3,11
    800072d0:	e55ff06f          	j	80007124 <__memset+0x2c>
    800072d4:	00300e93          	li	t4,3
    800072d8:	ea5ff06f          	j	8000717c <__memset+0x84>
    800072dc:	00100e93          	li	t4,1
    800072e0:	e9dff06f          	j	8000717c <__memset+0x84>
    800072e4:	00000e93          	li	t4,0
    800072e8:	e95ff06f          	j	8000717c <__memset+0x84>
    800072ec:	00000793          	li	a5,0
    800072f0:	ef9ff06f          	j	800071e8 <__memset+0xf0>
    800072f4:	00200e93          	li	t4,2
    800072f8:	e85ff06f          	j	8000717c <__memset+0x84>
    800072fc:	00400e93          	li	t4,4
    80007300:	e7dff06f          	j	8000717c <__memset+0x84>
    80007304:	00500e93          	li	t4,5
    80007308:	e75ff06f          	j	8000717c <__memset+0x84>
    8000730c:	00600e93          	li	t4,6
    80007310:	e6dff06f          	j	8000717c <__memset+0x84>

0000000080007314 <__memmove>:
    80007314:	ff010113          	addi	sp,sp,-16
    80007318:	00813423          	sd	s0,8(sp)
    8000731c:	01010413          	addi	s0,sp,16
    80007320:	0e060863          	beqz	a2,80007410 <__memmove+0xfc>
    80007324:	fff6069b          	addiw	a3,a2,-1
    80007328:	0006881b          	sext.w	a6,a3
    8000732c:	0ea5e863          	bltu	a1,a0,8000741c <__memmove+0x108>
    80007330:	00758713          	addi	a4,a1,7
    80007334:	00a5e7b3          	or	a5,a1,a0
    80007338:	40a70733          	sub	a4,a4,a0
    8000733c:	0077f793          	andi	a5,a5,7
    80007340:	00f73713          	sltiu	a4,a4,15
    80007344:	00174713          	xori	a4,a4,1
    80007348:	0017b793          	seqz	a5,a5
    8000734c:	00e7f7b3          	and	a5,a5,a4
    80007350:	10078863          	beqz	a5,80007460 <__memmove+0x14c>
    80007354:	00900793          	li	a5,9
    80007358:	1107f463          	bgeu	a5,a6,80007460 <__memmove+0x14c>
    8000735c:	0036581b          	srliw	a6,a2,0x3
    80007360:	fff8081b          	addiw	a6,a6,-1
    80007364:	02081813          	slli	a6,a6,0x20
    80007368:	01d85893          	srli	a7,a6,0x1d
    8000736c:	00858813          	addi	a6,a1,8
    80007370:	00058793          	mv	a5,a1
    80007374:	00050713          	mv	a4,a0
    80007378:	01088833          	add	a6,a7,a6
    8000737c:	0007b883          	ld	a7,0(a5)
    80007380:	00878793          	addi	a5,a5,8
    80007384:	00870713          	addi	a4,a4,8
    80007388:	ff173c23          	sd	a7,-8(a4)
    8000738c:	ff0798e3          	bne	a5,a6,8000737c <__memmove+0x68>
    80007390:	ff867713          	andi	a4,a2,-8
    80007394:	02071793          	slli	a5,a4,0x20
    80007398:	0207d793          	srli	a5,a5,0x20
    8000739c:	00f585b3          	add	a1,a1,a5
    800073a0:	40e686bb          	subw	a3,a3,a4
    800073a4:	00f507b3          	add	a5,a0,a5
    800073a8:	06e60463          	beq	a2,a4,80007410 <__memmove+0xfc>
    800073ac:	0005c703          	lbu	a4,0(a1)
    800073b0:	00e78023          	sb	a4,0(a5)
    800073b4:	04068e63          	beqz	a3,80007410 <__memmove+0xfc>
    800073b8:	0015c603          	lbu	a2,1(a1)
    800073bc:	00100713          	li	a4,1
    800073c0:	00c780a3          	sb	a2,1(a5)
    800073c4:	04e68663          	beq	a3,a4,80007410 <__memmove+0xfc>
    800073c8:	0025c603          	lbu	a2,2(a1)
    800073cc:	00200713          	li	a4,2
    800073d0:	00c78123          	sb	a2,2(a5)
    800073d4:	02e68e63          	beq	a3,a4,80007410 <__memmove+0xfc>
    800073d8:	0035c603          	lbu	a2,3(a1)
    800073dc:	00300713          	li	a4,3
    800073e0:	00c781a3          	sb	a2,3(a5)
    800073e4:	02e68663          	beq	a3,a4,80007410 <__memmove+0xfc>
    800073e8:	0045c603          	lbu	a2,4(a1)
    800073ec:	00400713          	li	a4,4
    800073f0:	00c78223          	sb	a2,4(a5)
    800073f4:	00e68e63          	beq	a3,a4,80007410 <__memmove+0xfc>
    800073f8:	0055c603          	lbu	a2,5(a1)
    800073fc:	00500713          	li	a4,5
    80007400:	00c782a3          	sb	a2,5(a5)
    80007404:	00e68663          	beq	a3,a4,80007410 <__memmove+0xfc>
    80007408:	0065c703          	lbu	a4,6(a1)
    8000740c:	00e78323          	sb	a4,6(a5)
    80007410:	00813403          	ld	s0,8(sp)
    80007414:	01010113          	addi	sp,sp,16
    80007418:	00008067          	ret
    8000741c:	02061713          	slli	a4,a2,0x20
    80007420:	02075713          	srli	a4,a4,0x20
    80007424:	00e587b3          	add	a5,a1,a4
    80007428:	f0f574e3          	bgeu	a0,a5,80007330 <__memmove+0x1c>
    8000742c:	02069613          	slli	a2,a3,0x20
    80007430:	02065613          	srli	a2,a2,0x20
    80007434:	fff64613          	not	a2,a2
    80007438:	00e50733          	add	a4,a0,a4
    8000743c:	00c78633          	add	a2,a5,a2
    80007440:	fff7c683          	lbu	a3,-1(a5)
    80007444:	fff78793          	addi	a5,a5,-1
    80007448:	fff70713          	addi	a4,a4,-1
    8000744c:	00d70023          	sb	a3,0(a4)
    80007450:	fec798e3          	bne	a5,a2,80007440 <__memmove+0x12c>
    80007454:	00813403          	ld	s0,8(sp)
    80007458:	01010113          	addi	sp,sp,16
    8000745c:	00008067          	ret
    80007460:	02069713          	slli	a4,a3,0x20
    80007464:	02075713          	srli	a4,a4,0x20
    80007468:	00170713          	addi	a4,a4,1
    8000746c:	00e50733          	add	a4,a0,a4
    80007470:	00050793          	mv	a5,a0
    80007474:	0005c683          	lbu	a3,0(a1)
    80007478:	00178793          	addi	a5,a5,1
    8000747c:	00158593          	addi	a1,a1,1
    80007480:	fed78fa3          	sb	a3,-1(a5)
    80007484:	fee798e3          	bne	a5,a4,80007474 <__memmove+0x160>
    80007488:	f89ff06f          	j	80007410 <__memmove+0xfc>
	...

Disassembly of section .user:

000000008000c550 <copy_and_swap-0xab0>:
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
    8000d43c:	b7c080e7          	jalr	-1156(ra) # 8000efb4 <_Znwm>
    8000d440:	00050913          	mv	s2,a0
    8000d444:	00050863          	beqz	a0,8000d454 <_ZN9BufferCPPC1Ei+0x68>
    8000d448:	00000593          	li	a1,0
    8000d44c:	00002097          	auipc	ra,0x2
    8000d450:	c60080e7          	jalr	-928(ra) # 8000f0ac <_ZN9SemaphoreC1Ej>
    8000d454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000d458:	01000513          	li	a0,16
    8000d45c:	00002097          	auipc	ra,0x2
    8000d460:	b58080e7          	jalr	-1192(ra) # 8000efb4 <_Znwm>
    8000d464:	00050913          	mv	s2,a0
    8000d468:	00050863          	beqz	a0,8000d478 <_ZN9BufferCPPC1Ei+0x8c>
    8000d46c:	00098593          	mv	a1,s3
    8000d470:	00002097          	auipc	ra,0x2
    8000d474:	c3c080e7          	jalr	-964(ra) # 8000f0ac <_ZN9SemaphoreC1Ej>
    8000d478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000d47c:	01000513          	li	a0,16
    8000d480:	00002097          	auipc	ra,0x2
    8000d484:	b34080e7          	jalr	-1228(ra) # 8000efb4 <_Znwm>
    8000d488:	00050913          	mv	s2,a0
    8000d48c:	00050863          	beqz	a0,8000d49c <_ZN9BufferCPPC1Ei+0xb0>
    8000d490:	00100593          	li	a1,1
    8000d494:	00002097          	auipc	ra,0x2
    8000d498:	c18080e7          	jalr	-1000(ra) # 8000f0ac <_ZN9SemaphoreC1Ej>
    8000d49c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000d4a0:	01000513          	li	a0,16
    8000d4a4:	00002097          	auipc	ra,0x2
    8000d4a8:	b10080e7          	jalr	-1264(ra) # 8000efb4 <_Znwm>
    8000d4ac:	00050913          	mv	s2,a0
    8000d4b0:	00050863          	beqz	a0,8000d4c0 <_ZN9BufferCPPC1Ei+0xd4>
    8000d4b4:	00100593          	li	a1,1
    8000d4b8:	00002097          	auipc	ra,0x2
    8000d4bc:	bf4080e7          	jalr	-1036(ra) # 8000f0ac <_ZN9SemaphoreC1Ej>
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
    8000d4ec:	b1c080e7          	jalr	-1252(ra) # 8000f004 <_ZdlPv>
    8000d4f0:	00048513          	mv	a0,s1
    8000d4f4:	fffff097          	auipc	ra,0xfffff
    8000d4f8:	ec4080e7          	jalr	-316(ra) # 8000c3b8 <_Unwind_Resume>
    8000d4fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000d500:	00090513          	mv	a0,s2
    8000d504:	00002097          	auipc	ra,0x2
    8000d508:	b00080e7          	jalr	-1280(ra) # 8000f004 <_ZdlPv>
    8000d50c:	00048513          	mv	a0,s1
    8000d510:	fffff097          	auipc	ra,0xfffff
    8000d514:	ea8080e7          	jalr	-344(ra) # 8000c3b8 <_Unwind_Resume>
    8000d518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000d51c:	00090513          	mv	a0,s2
    8000d520:	00002097          	auipc	ra,0x2
    8000d524:	ae4080e7          	jalr	-1308(ra) # 8000f004 <_ZdlPv>
    8000d528:	00048513          	mv	a0,s1
    8000d52c:	fffff097          	auipc	ra,0xfffff
    8000d530:	e8c080e7          	jalr	-372(ra) # 8000c3b8 <_Unwind_Resume>
    8000d534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000d538:	00090513          	mv	a0,s2
    8000d53c:	00002097          	auipc	ra,0x2
    8000d540:	ac8080e7          	jalr	-1336(ra) # 8000f004 <_ZdlPv>
    8000d544:	00048513          	mv	a0,s1
    8000d548:	fffff097          	auipc	ra,0xfffff
    8000d54c:	e70080e7          	jalr	-400(ra) # 8000c3b8 <_Unwind_Resume>

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
    8000d578:	b70080e7          	jalr	-1168(ra) # 8000f0e4 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000d57c:	0304b503          	ld	a0,48(s1)
    8000d580:	00002097          	auipc	ra,0x2
    8000d584:	b64080e7          	jalr	-1180(ra) # 8000f0e4 <_ZN9Semaphore4waitEv>
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
    8000d5b8:	b5c080e7          	jalr	-1188(ra) # 8000f110 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000d5bc:	0204b503          	ld	a0,32(s1)
    8000d5c0:	00002097          	auipc	ra,0x2
    8000d5c4:	b50080e7          	jalr	-1200(ra) # 8000f110 <_ZN9Semaphore6signalEv>

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
    8000d604:	ae4080e7          	jalr	-1308(ra) # 8000f0e4 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000d608:	0284b503          	ld	a0,40(s1)
    8000d60c:	00002097          	auipc	ra,0x2
    8000d610:	ad8080e7          	jalr	-1320(ra) # 8000f0e4 <_ZN9Semaphore4waitEv>

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
    8000d640:	ad4080e7          	jalr	-1324(ra) # 8000f110 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000d644:	0184b503          	ld	a0,24(s1)
    8000d648:	00002097          	auipc	ra,0x2
    8000d64c:	ac8080e7          	jalr	-1336(ra) # 8000f110 <_ZN9Semaphore6signalEv>

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
    8000d690:	a58080e7          	jalr	-1448(ra) # 8000f0e4 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000d694:	0304b503          	ld	a0,48(s1)
    8000d698:	00002097          	auipc	ra,0x2
    8000d69c:	a4c080e7          	jalr	-1460(ra) # 8000f0e4 <_ZN9Semaphore4waitEv>

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
    8000d6b8:	a5c080e7          	jalr	-1444(ra) # 8000f110 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000d6bc:	0284b503          	ld	a0,40(s1)
    8000d6c0:	00002097          	auipc	ra,0x2
    8000d6c4:	a50080e7          	jalr	-1456(ra) # 8000f110 <_ZN9Semaphore6signalEv>

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
    8000d714:	c38080e7          	jalr	-968(ra) # 8000f348 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000d718:	00003517          	auipc	a0,0x3
    8000d71c:	8e850513          	addi	a0,a0,-1816 # 80010000 <userDataStart>
    8000d720:	00001097          	auipc	ra,0x1
    8000d724:	544080e7          	jalr	1348(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000d750:	bfc080e7          	jalr	-1028(ra) # 8000f348 <_ZN7Console4putcEc>
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
    8000d774:	bd8080e7          	jalr	-1064(ra) # 8000f348 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000d778:	00a00513          	li	a0,10
    8000d77c:	00002097          	auipc	ra,0x2
    8000d780:	bcc080e7          	jalr	-1076(ra) # 8000f348 <_ZN7Console4putcEc>
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
    8000d85c:	40c080e7          	jalr	1036(ra) # 8000ec64 <_Z11printStringPKc>
    8000d860:	00000613          	li	a2,0
    8000d864:	00a00593          	li	a1,10
    8000d868:	0009051b          	sext.w	a0,s2
    8000d86c:	00001097          	auipc	ra,0x1
    8000d870:	590080e7          	jalr	1424(ra) # 8000edfc <_Z8printIntiii>
    8000d874:	00003517          	auipc	a0,0x3
    8000d878:	8d450513          	addi	a0,a0,-1836 # 80010148 <userDataStart+0x148>
    8000d87c:	00001097          	auipc	ra,0x1
    8000d880:	3e8080e7          	jalr	1000(ra) # 8000ec64 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d884:	00000493          	li	s1,0
    8000d888:	f99ff06f          	j	8000d820 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000d88c:	00002517          	auipc	a0,0x2
    8000d890:	79450513          	addi	a0,a0,1940 # 80010020 <userDataStart+0x20>
    8000d894:	00001097          	auipc	ra,0x1
    8000d898:	3d0080e7          	jalr	976(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000d928:	340080e7          	jalr	832(ra) # 8000ec64 <_Z11printStringPKc>
    8000d92c:	00000613          	li	a2,0
    8000d930:	00a00593          	li	a1,10
    8000d934:	0009051b          	sext.w	a0,s2
    8000d938:	00001097          	auipc	ra,0x1
    8000d93c:	4c4080e7          	jalr	1220(ra) # 8000edfc <_Z8printIntiii>
    8000d940:	00003517          	auipc	a0,0x3
    8000d944:	80850513          	addi	a0,a0,-2040 # 80010148 <userDataStart+0x148>
    8000d948:	00001097          	auipc	ra,0x1
    8000d94c:	31c080e7          	jalr	796(ra) # 8000ec64 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d950:	00000493          	li	s1,0
    8000d954:	f99ff06f          	j	8000d8ec <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000d958:	00002517          	auipc	a0,0x2
    8000d95c:	6e050513          	addi	a0,a0,1760 # 80010038 <userDataStart+0x38>
    8000d960:	00001097          	auipc	ra,0x1
    8000d964:	304080e7          	jalr	772(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000da34:	234080e7          	jalr	564(ra) # 8000ec64 <_Z11printStringPKc>
    8000da38:	00000613          	li	a2,0
    8000da3c:	00a00593          	li	a1,10
    8000da40:	00048513          	mv	a0,s1
    8000da44:	00001097          	auipc	ra,0x1
    8000da48:	3b8080e7          	jalr	952(ra) # 8000edfc <_Z8printIntiii>
    8000da4c:	00002517          	auipc	a0,0x2
    8000da50:	6fc50513          	addi	a0,a0,1788 # 80010148 <userDataStart+0x148>
    8000da54:	00001097          	auipc	ra,0x1
    8000da58:	210080e7          	jalr	528(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000da78:	1f0080e7          	jalr	496(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000da98:	1d0080e7          	jalr	464(ra) # 8000ec64 <_Z11printStringPKc>
    8000da9c:	00000613          	li	a2,0
    8000daa0:	00a00593          	li	a1,10
    8000daa4:	0009051b          	sext.w	a0,s2
    8000daa8:	00001097          	auipc	ra,0x1
    8000daac:	354080e7          	jalr	852(ra) # 8000edfc <_Z8printIntiii>
    8000dab0:	00002517          	auipc	a0,0x2
    8000dab4:	69850513          	addi	a0,a0,1688 # 80010148 <userDataStart+0x148>
    8000dab8:	00001097          	auipc	ra,0x1
    8000dabc:	1ac080e7          	jalr	428(ra) # 8000ec64 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000dac0:	00c00513          	li	a0,12
    8000dac4:	00000097          	auipc	ra,0x0
    8000dac8:	ed0080e7          	jalr	-304(ra) # 8000d994 <_Z9fibonaccim>
    8000dacc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000dad0:	00002517          	auipc	a0,0x2
    8000dad4:	59850513          	addi	a0,a0,1432 # 80010068 <userDataStart+0x68>
    8000dad8:	00001097          	auipc	ra,0x1
    8000dadc:	18c080e7          	jalr	396(ra) # 8000ec64 <_Z11printStringPKc>
    8000dae0:	00000613          	li	a2,0
    8000dae4:	00a00593          	li	a1,10
    8000dae8:	0009051b          	sext.w	a0,s2
    8000daec:	00001097          	auipc	ra,0x1
    8000daf0:	310080e7          	jalr	784(ra) # 8000edfc <_Z8printIntiii>
    8000daf4:	00002517          	auipc	a0,0x2
    8000daf8:	65450513          	addi	a0,a0,1620 # 80010148 <userDataStart+0x148>
    8000dafc:	00001097          	auipc	ra,0x1
    8000db00:	168080e7          	jalr	360(ra) # 8000ec64 <_Z11printStringPKc>
    8000db04:	0400006f          	j	8000db44 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000db08:	00002517          	auipc	a0,0x2
    8000db0c:	54050513          	addi	a0,a0,1344 # 80010048 <userDataStart+0x48>
    8000db10:	00001097          	auipc	ra,0x1
    8000db14:	154080e7          	jalr	340(ra) # 8000ec64 <_Z11printStringPKc>
    8000db18:	00000613          	li	a2,0
    8000db1c:	00a00593          	li	a1,10
    8000db20:	00048513          	mv	a0,s1
    8000db24:	00001097          	auipc	ra,0x1
    8000db28:	2d8080e7          	jalr	728(ra) # 8000edfc <_Z8printIntiii>
    8000db2c:	00002517          	auipc	a0,0x2
    8000db30:	61c50513          	addi	a0,a0,1564 # 80010148 <userDataStart+0x148>
    8000db34:	00001097          	auipc	ra,0x1
    8000db38:	130080e7          	jalr	304(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000db58:	110080e7          	jalr	272(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000dbb4:	0b4080e7          	jalr	180(ra) # 8000ec64 <_Z11printStringPKc>
    8000dbb8:	00000613          	li	a2,0
    8000dbbc:	00a00593          	li	a1,10
    8000dbc0:	00048513          	mv	a0,s1
    8000dbc4:	00001097          	auipc	ra,0x1
    8000dbc8:	238080e7          	jalr	568(ra) # 8000edfc <_Z8printIntiii>
    8000dbcc:	00002517          	auipc	a0,0x2
    8000dbd0:	57c50513          	addi	a0,a0,1404 # 80010148 <userDataStart+0x148>
    8000dbd4:	00001097          	auipc	ra,0x1
    8000dbd8:	090080e7          	jalr	144(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000dbf8:	070080e7          	jalr	112(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000dc24:	044080e7          	jalr	68(ra) # 8000ec64 <_Z11printStringPKc>
    8000dc28:	00000613          	li	a2,0
    8000dc2c:	00a00593          	li	a1,10
    8000dc30:	0009051b          	sext.w	a0,s2
    8000dc34:	00001097          	auipc	ra,0x1
    8000dc38:	1c8080e7          	jalr	456(ra) # 8000edfc <_Z8printIntiii>
    8000dc3c:	00002517          	auipc	a0,0x2
    8000dc40:	50c50513          	addi	a0,a0,1292 # 80010148 <userDataStart+0x148>
    8000dc44:	00001097          	auipc	ra,0x1
    8000dc48:	020080e7          	jalr	32(ra) # 8000ec64 <_Z11printStringPKc>
    8000dc4c:	0400006f          	j	8000dc8c <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000dc50:	00002517          	auipc	a0,0x2
    8000dc54:	42850513          	addi	a0,a0,1064 # 80010078 <userDataStart+0x78>
    8000dc58:	00001097          	auipc	ra,0x1
    8000dc5c:	00c080e7          	jalr	12(ra) # 8000ec64 <_Z11printStringPKc>
    8000dc60:	00000613          	li	a2,0
    8000dc64:	00a00593          	li	a1,10
    8000dc68:	00048513          	mv	a0,s1
    8000dc6c:	00001097          	auipc	ra,0x1
    8000dc70:	190080e7          	jalr	400(ra) # 8000edfc <_Z8printIntiii>
    8000dc74:	00002517          	auipc	a0,0x2
    8000dc78:	4d450513          	addi	a0,a0,1236 # 80010148 <userDataStart+0x148>
    8000dc7c:	00001097          	auipc	ra,0x1
    8000dc80:	fe8080e7          	jalr	-24(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000dca0:	fc8080e7          	jalr	-56(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000dd08:	f60080e7          	jalr	-160(ra) # 8000ec64 <_Z11printStringPKc>

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
    8000dd30:	f38080e7          	jalr	-200(ra) # 8000ec64 <_Z11printStringPKc>

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
    8000dd58:	f10080e7          	jalr	-240(ra) # 8000ec64 <_Z11printStringPKc>

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
    8000dd80:	ee8080e7          	jalr	-280(ra) # 8000ec64 <_Z11printStringPKc>
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
    8000de40:	e28080e7          	jalr	-472(ra) # 8000ec64 <_Z11printStringPKc>
        getString(input, 30);
    8000de44:	01e00593          	li	a1,30
    8000de48:	f8040493          	addi	s1,s0,-128
    8000de4c:	00048513          	mv	a0,s1
    8000de50:	00001097          	auipc	ra,0x1
    8000de54:	e90080e7          	jalr	-368(ra) # 8000ece0 <_Z9getStringPci>
        threadNum = stringToInt(input);
    8000de58:	00048513          	mv	a0,s1
    8000de5c:	00001097          	auipc	ra,0x1
    8000de60:	f50080e7          	jalr	-176(ra) # 8000edac <_Z11stringToIntPKc>
    8000de64:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    8000de68:	00002517          	auipc	a0,0x2
    8000de6c:	2c850513          	addi	a0,a0,712 # 80010130 <userDataStart+0x130>
    8000de70:	00001097          	auipc	ra,0x1
    8000de74:	df4080e7          	jalr	-524(ra) # 8000ec64 <_Z11printStringPKc>
        getString(input, 30);
    8000de78:	01e00593          	li	a1,30
    8000de7c:	00048513          	mv	a0,s1
    8000de80:	00001097          	auipc	ra,0x1
    8000de84:	e60080e7          	jalr	-416(ra) # 8000ece0 <_Z9getStringPci>
        n = stringToInt(input);
    8000de88:	00048513          	mv	a0,s1
    8000de8c:	00001097          	auipc	ra,0x1
    8000de90:	f20080e7          	jalr	-224(ra) # 8000edac <_Z11stringToIntPKc>
    8000de94:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    8000de98:	00002517          	auipc	a0,0x2
    8000de9c:	2b850513          	addi	a0,a0,696 # 80010150 <userDataStart+0x150>
    8000dea0:	00001097          	auipc	ra,0x1
    8000dea4:	dc4080e7          	jalr	-572(ra) # 8000ec64 <_Z11printStringPKc>
    8000dea8:	00000613          	li	a2,0
    8000deac:	00a00593          	li	a1,10
    8000deb0:	00090513          	mv	a0,s2
    8000deb4:	00001097          	auipc	ra,0x1
    8000deb8:	f48080e7          	jalr	-184(ra) # 8000edfc <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000debc:	00002517          	auipc	a0,0x2
    8000dec0:	2ac50513          	addi	a0,a0,684 # 80010168 <userDataStart+0x168>
    8000dec4:	00001097          	auipc	ra,0x1
    8000dec8:	da0080e7          	jalr	-608(ra) # 8000ec64 <_Z11printStringPKc>
    8000decc:	00000613          	li	a2,0
    8000ded0:	00a00593          	li	a1,10
    8000ded4:	00048513          	mv	a0,s1
    8000ded8:	00001097          	auipc	ra,0x1
    8000dedc:	f24080e7          	jalr	-220(ra) # 8000edfc <_Z8printIntiii>
        printString(".\n");
    8000dee0:	00002517          	auipc	a0,0x2
    8000dee4:	2a050513          	addi	a0,a0,672 # 80010180 <userDataStart+0x180>
    8000dee8:	00001097          	auipc	ra,0x1
    8000deec:	d7c080e7          	jalr	-644(ra) # 8000ec64 <_Z11printStringPKc>
        if(threadNum > n) {
    8000def0:	0324c663          	blt	s1,s2,8000df1c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    8000def4:	03205e63          	blez	s2,8000df30 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    8000def8:	03800513          	li	a0,56
    8000defc:	00001097          	auipc	ra,0x1
    8000df00:	0b8080e7          	jalr	184(ra) # 8000efb4 <_Znwm>
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
    8000df28:	d40080e7          	jalr	-704(ra) # 8000ec64 <_Z11printStringPKc>
            return;
    8000df2c:	0140006f          	j	8000df40 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000df30:	00002517          	auipc	a0,0x2
    8000df34:	29850513          	addi	a0,a0,664 # 800101c8 <userDataStart+0x1c8>
    8000df38:	00001097          	auipc	ra,0x1
    8000df3c:	d2c080e7          	jalr	-724(ra) # 8000ec64 <_Z11printStringPKc>
            return;
    8000df40:	000b8113          	mv	sp,s7
    8000df44:	24c0006f          	j	8000e190 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    8000df48:	01000513          	li	a0,16
    8000df4c:	00001097          	auipc	ra,0x1
    8000df50:	068080e7          	jalr	104(ra) # 8000efb4 <_Znwm>
    8000df54:	00050493          	mv	s1,a0
    8000df58:	00050863          	beqz	a0,8000df68 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000df5c:	00000593          	li	a1,0
    8000df60:	00001097          	auipc	ra,0x1
    8000df64:	14c080e7          	jalr	332(ra) # 8000f0ac <_ZN9SemaphoreC1Ej>
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
    8000dfd0:	fe8080e7          	jalr	-24(ra) # 8000efb4 <_Znwm>
    8000dfd4:	00050b13          	mv	s6,a0
    8000dfd8:	02050663          	beqz	a0,8000e004 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    8000dfdc:	00191493          	slli	s1,s2,0x1
    8000dfe0:	012484b3          	add	s1,s1,s2
    8000dfe4:	00349493          	slli	s1,s1,0x3
    8000dfe8:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000dfec:	00001097          	auipc	ra,0x1
    8000dff0:	1a4080e7          	jalr	420(ra) # 8000f190 <_ZN6ThreadC1Ev>
    8000dff4:	00002797          	auipc	a5,0x2
    8000dff8:	2ac78793          	addi	a5,a5,684 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000dffc:	00fb3023          	sd	a5,0(s6) # 2000 <_entry-0x7fffe000>
    8000e000:	009b3823          	sd	s1,16(s6)
        consumer->start();
    8000e004:	000b0513          	mv	a0,s6
    8000e008:	00001097          	auipc	ra,0x1
    8000e00c:	278080e7          	jalr	632(ra) # 8000f280 <_ZN6Thread5startEv>
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
    8000e02c:	f8c080e7          	jalr	-116(ra) # 8000efb4 <_Znwm>
    8000e030:	00050493          	mv	s1,a0
    8000e034:	00050e63          	beqz	a0,8000e050 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    8000e038:	00001097          	auipc	ra,0x1
    8000e03c:	158080e7          	jalr	344(ra) # 8000f190 <_ZN6ThreadC1Ev>
    8000e040:	00002797          	auipc	a5,0x2
    8000e044:	21078793          	addi	a5,a5,528 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e048:	00f4b023          	sd	a5,0(s1)
    8000e04c:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e050:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    8000e054:	00048513          	mv	a0,s1
    8000e058:	00001097          	auipc	ra,0x1
    8000e05c:	228080e7          	jalr	552(ra) # 8000f280 <_ZN6Thread5startEv>
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
    8000e08c:	1f8080e7          	jalr	504(ra) # 8000f280 <_ZN6Thread5startEv>
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
    8000e0c4:	ef4080e7          	jalr	-268(ra) # 8000efb4 <_Znwm>
    8000e0c8:	00050c13          	mv	s8,a0
    8000e0cc:	fa0506e3          	beqz	a0,8000e078 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    8000e0d0:	00149c93          	slli	s9,s1,0x1
    8000e0d4:	009c8cb3          	add	s9,s9,s1
    8000e0d8:	003c9c93          	slli	s9,s9,0x3
    8000e0dc:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000e0e0:	00001097          	auipc	ra,0x1
    8000e0e4:	0b0080e7          	jalr	176(ra) # 8000f190 <_ZN6ThreadC1Ev>
    8000e0e8:	f81ff06f          	j	8000e068 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    8000e0ec:	00001097          	auipc	ra,0x1
    8000e0f0:	16c080e7          	jalr	364(ra) # 8000f258 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000e0f4:	00000493          	li	s1,0
    8000e0f8:	00994e63          	blt	s2,s1,8000e114 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    8000e0fc:	00002517          	auipc	a0,0x2
    8000e100:	28453503          	ld	a0,644(a0) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e104:	00001097          	auipc	ra,0x1
    8000e108:	fe0080e7          	jalr	-32(ra) # 8000f0e4 <_ZN9Semaphore4waitEv>
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
    8000e188:	e80080e7          	jalr	-384(ra) # 8000f004 <_ZdlPv>
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
    8000e1d4:	e34080e7          	jalr	-460(ra) # 8000f004 <_ZdlPv>
    8000e1d8:	00048513          	mv	a0,s1
    8000e1dc:	ffffe097          	auipc	ra,0xffffe
    8000e1e0:	1dc080e7          	jalr	476(ra) # 8000c3b8 <_Unwind_Resume>
    8000e1e4:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    8000e1e8:	00048513          	mv	a0,s1
    8000e1ec:	00001097          	auipc	ra,0x1
    8000e1f0:	e18080e7          	jalr	-488(ra) # 8000f004 <_ZdlPv>
    8000e1f4:	00090513          	mv	a0,s2
    8000e1f8:	ffffe097          	auipc	ra,0xffffe
    8000e1fc:	1c0080e7          	jalr	448(ra) # 8000c3b8 <_Unwind_Resume>
    8000e200:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000e204:	000b0513          	mv	a0,s6
    8000e208:	00001097          	auipc	ra,0x1
    8000e20c:	dfc080e7          	jalr	-516(ra) # 8000f004 <_ZdlPv>
    8000e210:	00048513          	mv	a0,s1
    8000e214:	ffffe097          	auipc	ra,0xffffe
    8000e218:	1a4080e7          	jalr	420(ra) # 8000c3b8 <_Unwind_Resume>
    8000e21c:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e220:	00048513          	mv	a0,s1
    8000e224:	00001097          	auipc	ra,0x1
    8000e228:	de0080e7          	jalr	-544(ra) # 8000f004 <_ZdlPv>
    8000e22c:	00090513          	mv	a0,s2
    8000e230:	ffffe097          	auipc	ra,0xffffe
    8000e234:	188080e7          	jalr	392(ra) # 8000c3b8 <_Unwind_Resume>
    8000e238:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000e23c:	000c0513          	mv	a0,s8
    8000e240:	00001097          	auipc	ra,0x1
    8000e244:	dc4080e7          	jalr	-572(ra) # 8000f004 <_ZdlPv>
    8000e248:	00048513          	mv	a0,s1
    8000e24c:	ffffe097          	auipc	ra,0xffffe
    8000e250:	16c080e7          	jalr	364(ra) # 8000c3b8 <_Unwind_Resume>

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
    8000e274:	f20080e7          	jalr	-224(ra) # 8000f190 <_ZN6ThreadC1Ev>
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
    8000e298:	fec080e7          	jalr	-20(ra) # 8000f280 <_ZN6Thread5startEv>
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
    8000e2bc:	9ac080e7          	jalr	-1620(ra) # 8000ec64 <_Z11printStringPKc>
class ForkThread : public Thread {
    8000e2c0:	00002797          	auipc	a5,0x2
    8000e2c4:	00878793          	addi	a5,a5,8 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e2c8:	fcf43023          	sd	a5,-64(s0)
    8000e2cc:	fc040513          	addi	a0,s0,-64
    8000e2d0:	00001097          	auipc	ra,0x1
    8000e2d4:	ca4080e7          	jalr	-860(ra) # 8000ef74 <_ZN6ThreadD1Ev>
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
    8000e304:	c74080e7          	jalr	-908(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e308:	00048513          	mv	a0,s1
    8000e30c:	ffffe097          	auipc	ra,0xffffe
    8000e310:	0ac080e7          	jalr	172(ra) # 8000c3b8 <_Unwind_Resume>

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
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    testUser();
    8000e324:	00000097          	auipc	ra,0x0
    8000e328:	f30080e7          	jalr	-208(ra) # 8000e254 <_Z8testUserv>
    8000e32c:	00813083          	ld	ra,8(sp)
    8000e330:	00013403          	ld	s0,0(sp)
    8000e334:	01010113          	addi	sp,sp,16
    8000e338:	00008067          	ret

000000008000e33c <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    8000e33c:	fd010113          	addi	sp,sp,-48
    8000e340:	02113423          	sd	ra,40(sp)
    8000e344:	02813023          	sd	s0,32(sp)
    8000e348:	00913c23          	sd	s1,24(sp)
    8000e34c:	01213823          	sd	s2,16(sp)
    8000e350:	01313423          	sd	s3,8(sp)
    8000e354:	03010413          	addi	s0,sp,48
    8000e358:	00050913          	mv	s2,a0
            int i = 0;
    8000e35c:	00000993          	li	s3,0
    8000e360:	0100006f          	j	8000e370 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    8000e364:	00a00513          	li	a0,10
    8000e368:	00001097          	auipc	ra,0x1
    8000e36c:	fe0080e7          	jalr	-32(ra) # 8000f348 <_ZN7Console4putcEc>
            while (!threadEnd) {
    8000e370:	00002797          	auipc	a5,0x2
    8000e374:	0047a783          	lw	a5,4(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e378:	04079a63          	bnez	a5,8000e3cc <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    8000e37c:	01093783          	ld	a5,16(s2)
    8000e380:	0087b503          	ld	a0,8(a5)
    8000e384:	fffff097          	auipc	ra,0xfffff
    8000e388:	25c080e7          	jalr	604(ra) # 8000d5e0 <_ZN9BufferCPP3getEv>
                i++;
    8000e38c:	0019849b          	addiw	s1,s3,1
    8000e390:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    8000e394:	0ff57513          	andi	a0,a0,255
    8000e398:	00001097          	auipc	ra,0x1
    8000e39c:	fb0080e7          	jalr	-80(ra) # 8000f348 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    8000e3a0:	05000793          	li	a5,80
    8000e3a4:	02f4e4bb          	remw	s1,s1,a5
    8000e3a8:	fc0494e3          	bnez	s1,8000e370 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    8000e3ac:	fb9ff06f          	j	8000e364 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    8000e3b0:	01093783          	ld	a5,16(s2)
    8000e3b4:	0087b503          	ld	a0,8(a5)
    8000e3b8:	fffff097          	auipc	ra,0xfffff
    8000e3bc:	228080e7          	jalr	552(ra) # 8000d5e0 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    8000e3c0:	0ff57513          	andi	a0,a0,255
    8000e3c4:	00001097          	auipc	ra,0x1
    8000e3c8:	f84080e7          	jalr	-124(ra) # 8000f348 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    8000e3cc:	01093783          	ld	a5,16(s2)
    8000e3d0:	0087b503          	ld	a0,8(a5)
    8000e3d4:	fffff097          	auipc	ra,0xfffff
    8000e3d8:	298080e7          	jalr	664(ra) # 8000d66c <_ZN9BufferCPP6getCntEv>
    8000e3dc:	fca04ae3          	bgtz	a0,8000e3b0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    8000e3e0:	01093783          	ld	a5,16(s2)
    8000e3e4:	0107b503          	ld	a0,16(a5)
    8000e3e8:	00001097          	auipc	ra,0x1
    8000e3ec:	d28080e7          	jalr	-728(ra) # 8000f110 <_ZN9Semaphore6signalEv>
        }
    8000e3f0:	02813083          	ld	ra,40(sp)
    8000e3f4:	02013403          	ld	s0,32(sp)
    8000e3f8:	01813483          	ld	s1,24(sp)
    8000e3fc:	01013903          	ld	s2,16(sp)
    8000e400:	00813983          	ld	s3,8(sp)
    8000e404:	03010113          	addi	sp,sp,48
    8000e408:	00008067          	ret

000000008000e40c <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    8000e40c:	ff010113          	addi	sp,sp,-16
    8000e410:	00113423          	sd	ra,8(sp)
    8000e414:	00813023          	sd	s0,0(sp)
    8000e418:	01010413          	addi	s0,sp,16
    8000e41c:	00002797          	auipc	a5,0x2
    8000e420:	e8478793          	addi	a5,a5,-380 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e424:	00f53023          	sd	a5,0(a0)
    8000e428:	00001097          	auipc	ra,0x1
    8000e42c:	b4c080e7          	jalr	-1204(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e430:	00813083          	ld	ra,8(sp)
    8000e434:	00013403          	ld	s0,0(sp)
    8000e438:	01010113          	addi	sp,sp,16
    8000e43c:	00008067          	ret

000000008000e440 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    8000e440:	fe010113          	addi	sp,sp,-32
    8000e444:	00113c23          	sd	ra,24(sp)
    8000e448:	00813823          	sd	s0,16(sp)
    8000e44c:	00913423          	sd	s1,8(sp)
    8000e450:	02010413          	addi	s0,sp,32
    8000e454:	00050493          	mv	s1,a0
    8000e458:	00002797          	auipc	a5,0x2
    8000e45c:	e4878793          	addi	a5,a5,-440 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e460:	00f53023          	sd	a5,0(a0)
    8000e464:	00001097          	auipc	ra,0x1
    8000e468:	b10080e7          	jalr	-1264(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e46c:	00048513          	mv	a0,s1
    8000e470:	00001097          	auipc	ra,0x1
    8000e474:	b94080e7          	jalr	-1132(ra) # 8000f004 <_ZdlPv>
    8000e478:	01813083          	ld	ra,24(sp)
    8000e47c:	01013403          	ld	s0,16(sp)
    8000e480:	00813483          	ld	s1,8(sp)
    8000e484:	02010113          	addi	sp,sp,32
    8000e488:	00008067          	ret

000000008000e48c <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    8000e48c:	ff010113          	addi	sp,sp,-16
    8000e490:	00113423          	sd	ra,8(sp)
    8000e494:	00813023          	sd	s0,0(sp)
    8000e498:	01010413          	addi	s0,sp,16
    8000e49c:	00002797          	auipc	a5,0x2
    8000e4a0:	db478793          	addi	a5,a5,-588 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e4a4:	00f53023          	sd	a5,0(a0)
    8000e4a8:	00001097          	auipc	ra,0x1
    8000e4ac:	acc080e7          	jalr	-1332(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e4b0:	00813083          	ld	ra,8(sp)
    8000e4b4:	00013403          	ld	s0,0(sp)
    8000e4b8:	01010113          	addi	sp,sp,16
    8000e4bc:	00008067          	ret

000000008000e4c0 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    8000e4c0:	fe010113          	addi	sp,sp,-32
    8000e4c4:	00113c23          	sd	ra,24(sp)
    8000e4c8:	00813823          	sd	s0,16(sp)
    8000e4cc:	00913423          	sd	s1,8(sp)
    8000e4d0:	02010413          	addi	s0,sp,32
    8000e4d4:	00050493          	mv	s1,a0
    8000e4d8:	00002797          	auipc	a5,0x2
    8000e4dc:	d7878793          	addi	a5,a5,-648 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e4e0:	00f53023          	sd	a5,0(a0)
    8000e4e4:	00001097          	auipc	ra,0x1
    8000e4e8:	a90080e7          	jalr	-1392(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e4ec:	00048513          	mv	a0,s1
    8000e4f0:	00001097          	auipc	ra,0x1
    8000e4f4:	b14080e7          	jalr	-1260(ra) # 8000f004 <_ZdlPv>
    8000e4f8:	01813083          	ld	ra,24(sp)
    8000e4fc:	01013403          	ld	s0,16(sp)
    8000e500:	00813483          	ld	s1,8(sp)
    8000e504:	02010113          	addi	sp,sp,32
    8000e508:	00008067          	ret

000000008000e50c <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    8000e50c:	ff010113          	addi	sp,sp,-16
    8000e510:	00113423          	sd	ra,8(sp)
    8000e514:	00813023          	sd	s0,0(sp)
    8000e518:	01010413          	addi	s0,sp,16
    8000e51c:	00002797          	auipc	a5,0x2
    8000e520:	d5c78793          	addi	a5,a5,-676 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e524:	00f53023          	sd	a5,0(a0)
    8000e528:	00001097          	auipc	ra,0x1
    8000e52c:	a4c080e7          	jalr	-1460(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e530:	00813083          	ld	ra,8(sp)
    8000e534:	00013403          	ld	s0,0(sp)
    8000e538:	01010113          	addi	sp,sp,16
    8000e53c:	00008067          	ret

000000008000e540 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    8000e540:	fe010113          	addi	sp,sp,-32
    8000e544:	00113c23          	sd	ra,24(sp)
    8000e548:	00813823          	sd	s0,16(sp)
    8000e54c:	00913423          	sd	s1,8(sp)
    8000e550:	02010413          	addi	s0,sp,32
    8000e554:	00050493          	mv	s1,a0
    8000e558:	00002797          	auipc	a5,0x2
    8000e55c:	d2078793          	addi	a5,a5,-736 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e560:	00f53023          	sd	a5,0(a0)
    8000e564:	00001097          	auipc	ra,0x1
    8000e568:	a10080e7          	jalr	-1520(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e56c:	00048513          	mv	a0,s1
    8000e570:	00001097          	auipc	ra,0x1
    8000e574:	a94080e7          	jalr	-1388(ra) # 8000f004 <_ZdlPv>
    8000e578:	01813083          	ld	ra,24(sp)
    8000e57c:	01013403          	ld	s0,16(sp)
    8000e580:	00813483          	ld	s1,8(sp)
    8000e584:	02010113          	addi	sp,sp,32
    8000e588:	00008067          	ret

000000008000e58c <_ZN10ForkThreadD1Ev>:
    8000e58c:	ff010113          	addi	sp,sp,-16
    8000e590:	00113423          	sd	ra,8(sp)
    8000e594:	00813023          	sd	s0,0(sp)
    8000e598:	01010413          	addi	s0,sp,16
    8000e59c:	00002797          	auipc	a5,0x2
    8000e5a0:	d2c78793          	addi	a5,a5,-724 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e5a4:	00f53023          	sd	a5,0(a0)
    8000e5a8:	00001097          	auipc	ra,0x1
    8000e5ac:	9cc080e7          	jalr	-1588(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e5b0:	00813083          	ld	ra,8(sp)
    8000e5b4:	00013403          	ld	s0,0(sp)
    8000e5b8:	01010113          	addi	sp,sp,16
    8000e5bc:	00008067          	ret

000000008000e5c0 <_ZN10ForkThreadD0Ev>:
    8000e5c0:	fe010113          	addi	sp,sp,-32
    8000e5c4:	00113c23          	sd	ra,24(sp)
    8000e5c8:	00813823          	sd	s0,16(sp)
    8000e5cc:	00913423          	sd	s1,8(sp)
    8000e5d0:	02010413          	addi	s0,sp,32
    8000e5d4:	00050493          	mv	s1,a0
    8000e5d8:	00002797          	auipc	a5,0x2
    8000e5dc:	cf078793          	addi	a5,a5,-784 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e5e0:	00f53023          	sd	a5,0(a0)
    8000e5e4:	00001097          	auipc	ra,0x1
    8000e5e8:	990080e7          	jalr	-1648(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000e5ec:	00048513          	mv	a0,s1
    8000e5f0:	00001097          	auipc	ra,0x1
    8000e5f4:	a14080e7          	jalr	-1516(ra) # 8000f004 <_ZdlPv>
    8000e5f8:	01813083          	ld	ra,24(sp)
    8000e5fc:	01013403          	ld	s0,16(sp)
    8000e600:	00813483          	ld	s1,8(sp)
    8000e604:	02010113          	addi	sp,sp,32
    8000e608:	00008067          	ret

000000008000e60c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    8000e60c:	fe010113          	addi	sp,sp,-32
    8000e610:	00113c23          	sd	ra,24(sp)
    8000e614:	00813823          	sd	s0,16(sp)
    8000e618:	00913423          	sd	s1,8(sp)
    8000e61c:	02010413          	addi	s0,sp,32
    8000e620:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    8000e624:	fffff097          	auipc	ra,0xfffff
    8000e628:	ce0080e7          	jalr	-800(ra) # 8000d304 <_Z4getcv>
    8000e62c:	0005059b          	sext.w	a1,a0
    8000e630:	01b00793          	li	a5,27
    8000e634:	00f58c63          	beq	a1,a5,8000e64c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    8000e638:	0104b783          	ld	a5,16(s1)
    8000e63c:	0087b503          	ld	a0,8(a5)
    8000e640:	fffff097          	auipc	ra,0xfffff
    8000e644:	f10080e7          	jalr	-240(ra) # 8000d550 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    8000e648:	fddff06f          	j	8000e624 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    8000e64c:	00100793          	li	a5,1
    8000e650:	00002717          	auipc	a4,0x2
    8000e654:	d2f72223          	sw	a5,-732(a4) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    8000e658:	0104b783          	ld	a5,16(s1)
    8000e65c:	02100593          	li	a1,33
    8000e660:	0087b503          	ld	a0,8(a5)
    8000e664:	fffff097          	auipc	ra,0xfffff
    8000e668:	eec080e7          	jalr	-276(ra) # 8000d550 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    8000e66c:	0104b783          	ld	a5,16(s1)
    8000e670:	0107b503          	ld	a0,16(a5)
    8000e674:	00001097          	auipc	ra,0x1
    8000e678:	a9c080e7          	jalr	-1380(ra) # 8000f110 <_ZN9Semaphore6signalEv>
        }
    8000e67c:	01813083          	ld	ra,24(sp)
    8000e680:	01013403          	ld	s0,16(sp)
    8000e684:	00813483          	ld	s1,8(sp)
    8000e688:	02010113          	addi	sp,sp,32
    8000e68c:	00008067          	ret

000000008000e690 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    8000e690:	fe010113          	addi	sp,sp,-32
    8000e694:	00113c23          	sd	ra,24(sp)
    8000e698:	00813823          	sd	s0,16(sp)
    8000e69c:	00913423          	sd	s1,8(sp)
    8000e6a0:	01213023          	sd	s2,0(sp)
    8000e6a4:	02010413          	addi	s0,sp,32
    8000e6a8:	00050493          	mv	s1,a0
            int i = 0;
    8000e6ac:	00000913          	li	s2,0
            while (!threadEnd) {
    8000e6b0:	00002797          	auipc	a5,0x2
    8000e6b4:	cc47a783          	lw	a5,-828(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e6b8:	04079263          	bnez	a5,8000e6fc <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8000e6bc:	0104b783          	ld	a5,16(s1)
    8000e6c0:	0007a583          	lw	a1,0(a5)
    8000e6c4:	0305859b          	addiw	a1,a1,48
    8000e6c8:	0087b503          	ld	a0,8(a5)
    8000e6cc:	fffff097          	auipc	ra,0xfffff
    8000e6d0:	e84080e7          	jalr	-380(ra) # 8000d550 <_ZN9BufferCPP3putEi>
                i++;
    8000e6d4:	0019071b          	addiw	a4,s2,1
    8000e6d8:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    8000e6dc:	0104b783          	ld	a5,16(s1)
    8000e6e0:	0007a783          	lw	a5,0(a5)
    8000e6e4:	00e787bb          	addw	a5,a5,a4
    8000e6e8:	00500513          	li	a0,5
    8000e6ec:	02a7e53b          	remw	a0,a5,a0
    8000e6f0:	00001097          	auipc	ra,0x1
    8000e6f4:	b00080e7          	jalr	-1280(ra) # 8000f1f0 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    8000e6f8:	fb9ff06f          	j	8000e6b0 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    8000e6fc:	0104b783          	ld	a5,16(s1)
    8000e700:	0107b503          	ld	a0,16(a5)
    8000e704:	00001097          	auipc	ra,0x1
    8000e708:	a0c080e7          	jalr	-1524(ra) # 8000f110 <_ZN9Semaphore6signalEv>
        }
    8000e70c:	01813083          	ld	ra,24(sp)
    8000e710:	01013403          	ld	s0,16(sp)
    8000e714:	00813483          	ld	s1,8(sp)
    8000e718:	00013903          	ld	s2,0(sp)
    8000e71c:	02010113          	addi	sp,sp,32
    8000e720:	00008067          	ret

000000008000e724 <_ZN10ForkThread3runEv>:
    virtual void run() {
    8000e724:	fc010113          	addi	sp,sp,-64
    8000e728:	02113c23          	sd	ra,56(sp)
    8000e72c:	02813823          	sd	s0,48(sp)
    8000e730:	02913423          	sd	s1,40(sp)
    8000e734:	03213023          	sd	s2,32(sp)
    8000e738:	01313c23          	sd	s3,24(sp)
    8000e73c:	01413823          	sd	s4,16(sp)
    8000e740:	01513423          	sd	s5,8(sp)
    8000e744:	01613023          	sd	s6,0(sp)
    8000e748:	04010413          	addi	s0,sp,64
    8000e74c:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    8000e750:	00002517          	auipc	a0,0x2
    8000e754:	ac050513          	addi	a0,a0,-1344 # 80010210 <userDataStart+0x210>
    8000e758:	00000097          	auipc	ra,0x0
    8000e75c:	50c080e7          	jalr	1292(ra) # 8000ec64 <_Z11printStringPKc>
        printInt(id,10);
    8000e760:	00000613          	li	a2,0
    8000e764:	00a00593          	li	a1,10
    8000e768:	010a2503          	lw	a0,16(s4)
    8000e76c:	00000097          	auipc	ra,0x0
    8000e770:	690080e7          	jalr	1680(ra) # 8000edfc <_Z8printIntiii>
        printString("\n");
    8000e774:	00002517          	auipc	a0,0x2
    8000e778:	9d450513          	addi	a0,a0,-1580 # 80010148 <userDataStart+0x148>
    8000e77c:	00000097          	auipc	ra,0x0
    8000e780:	4e8080e7          	jalr	1256(ra) # 8000ec64 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    8000e784:	02000513          	li	a0,32
    8000e788:	00001097          	auipc	ra,0x1
    8000e78c:	82c080e7          	jalr	-2004(ra) # 8000efb4 <_Znwm>
    8000e790:	00050993          	mv	s3,a0
    8000e794:	02050463          	beqz	a0,8000e7bc <_ZN10ForkThread3runEv+0x98>
    8000e798:	010a3483          	ld	s1,16(s4)
    8000e79c:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e7a0:	00001097          	auipc	ra,0x1
    8000e7a4:	9f0080e7          	jalr	-1552(ra) # 8000f190 <_ZN6ThreadC1Ev>
    8000e7a8:	00002797          	auipc	a5,0x2
    8000e7ac:	b2078793          	addi	a5,a5,-1248 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e7b0:	00f9b023          	sd	a5,0(s3)
    8000e7b4:	0099b823          	sd	s1,16(s3)
    8000e7b8:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    8000e7bc:	010a3503          	ld	a0,16(s4)
    8000e7c0:	00351513          	slli	a0,a0,0x3
    8000e7c4:	fffff097          	auipc	ra,0xfffff
    8000e7c8:	85c080e7          	jalr	-1956(ra) # 8000d020 <_Z9mem_allocm>
    8000e7cc:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    8000e7d0:	10050863          	beqz	a0,8000e8e0 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    8000e7d4:	00000913          	li	s2,0
    8000e7d8:	0140006f          	j	8000e7ec <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    8000e7dc:	00391793          	slli	a5,s2,0x3
    8000e7e0:	00fa87b3          	add	a5,s5,a5
    8000e7e4:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    8000e7e8:	00190913          	addi	s2,s2,1
    8000e7ec:	010a3783          	ld	a5,16(s4)
    8000e7f0:	02f95e63          	bge	s2,a5,8000e82c <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    8000e7f4:	02000513          	li	a0,32
    8000e7f8:	00000097          	auipc	ra,0x0
    8000e7fc:	7bc080e7          	jalr	1980(ra) # 8000efb4 <_Znwm>
    8000e800:	00050493          	mv	s1,a0
    8000e804:	fc050ce3          	beqz	a0,8000e7dc <_ZN10ForkThread3runEv+0xb8>
    8000e808:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e80c:	00001097          	auipc	ra,0x1
    8000e810:	984080e7          	jalr	-1660(ra) # 8000f190 <_ZN6ThreadC1Ev>
    8000e814:	00002797          	auipc	a5,0x2
    8000e818:	ab478793          	addi	a5,a5,-1356 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e81c:	00f4b023          	sd	a5,0(s1)
    8000e820:	0164b823          	sd	s6,16(s1)
    8000e824:	00048c23          	sb	zero,24(s1)
    8000e828:	fb5ff06f          	j	8000e7dc <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    8000e82c:	06098a63          	beqz	s3,8000e8a0 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    8000e830:	00098513          	mv	a0,s3
    8000e834:	00001097          	auipc	ra,0x1
    8000e838:	a4c080e7          	jalr	-1460(ra) # 8000f280 <_ZN6Thread5startEv>
    8000e83c:	00050913          	mv	s2,a0
    8000e840:	04051863          	bnez	a0,8000e890 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    8000e844:	00050493          	mv	s1,a0
    8000e848:	0100006f          	j	8000e858 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    8000e84c:	fffff097          	auipc	ra,0xfffff
    8000e850:	8e4080e7          	jalr	-1820(ra) # 8000d130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    8000e854:	0014849b          	addiw	s1,s1,1
    8000e858:	000017b7          	lui	a5,0x1
    8000e85c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e860:	0097ce63          	blt	a5,s1,8000e87c <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    8000e864:	00090713          	mv	a4,s2
    8000e868:	000017b7          	lui	a5,0x1
    8000e86c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e870:	fce7cee3          	blt	a5,a4,8000e84c <_ZN10ForkThread3runEv+0x128>
    8000e874:	0017071b          	addiw	a4,a4,1
    8000e878:	ff1ff06f          	j	8000e868 <_ZN10ForkThread3runEv+0x144>
        return finished;
    8000e87c:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    8000e880:	00079863          	bnez	a5,8000e890 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    8000e884:	fffff097          	auipc	ra,0xfffff
    8000e888:	8ac080e7          	jalr	-1876(ra) # 8000d130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8000e88c:	ff1ff06f          	j	8000e87c <_ZN10ForkThread3runEv+0x158>
                delete thread;
    8000e890:	0009b783          	ld	a5,0(s3)
    8000e894:	0087b783          	ld	a5,8(a5)
    8000e898:	00098513          	mv	a0,s3
    8000e89c:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    8000e8a0:	00000493          	li	s1,0
    8000e8a4:	0080006f          	j	8000e8ac <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    8000e8a8:	00148493          	addi	s1,s1,1
    8000e8ac:	010a3783          	ld	a5,16(s4)
    8000e8b0:	02f4d263          	bge	s1,a5,8000e8d4 <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    8000e8b4:	00349793          	slli	a5,s1,0x3
    8000e8b8:	00fa87b3          	add	a5,s5,a5
    8000e8bc:	0007b503          	ld	a0,0(a5)
    8000e8c0:	fe0504e3          	beqz	a0,8000e8a8 <_ZN10ForkThread3runEv+0x184>
    8000e8c4:	00053783          	ld	a5,0(a0)
    8000e8c8:	0087b783          	ld	a5,8(a5)
    8000e8cc:	000780e7          	jalr	a5
    8000e8d0:	fd9ff06f          	j	8000e8a8 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    8000e8d4:	000a8513          	mv	a0,s5
    8000e8d8:	ffffe097          	auipc	ra,0xffffe
    8000e8dc:	778080e7          	jalr	1912(ra) # 8000d050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    8000e8e0:	00002517          	auipc	a0,0x2
    8000e8e4:	94850513          	addi	a0,a0,-1720 # 80010228 <userDataStart+0x228>
    8000e8e8:	00000097          	auipc	ra,0x0
    8000e8ec:	37c080e7          	jalr	892(ra) # 8000ec64 <_Z11printStringPKc>
        printInt(id,10);
    8000e8f0:	00000613          	li	a2,0
    8000e8f4:	00a00593          	li	a1,10
    8000e8f8:	010a2503          	lw	a0,16(s4)
    8000e8fc:	00000097          	auipc	ra,0x0
    8000e900:	500080e7          	jalr	1280(ra) # 8000edfc <_Z8printIntiii>
        printString("\n");
    8000e904:	00002517          	auipc	a0,0x2
    8000e908:	84450513          	addi	a0,a0,-1980 # 80010148 <userDataStart+0x148>
    8000e90c:	00000097          	auipc	ra,0x0
    8000e910:	358080e7          	jalr	856(ra) # 8000ec64 <_Z11printStringPKc>
        finished = true;
    8000e914:	00100793          	li	a5,1
    8000e918:	00fa0c23          	sb	a5,24(s4)
    }
    8000e91c:	03813083          	ld	ra,56(sp)
    8000e920:	03013403          	ld	s0,48(sp)
    8000e924:	02813483          	ld	s1,40(sp)
    8000e928:	02013903          	ld	s2,32(sp)
    8000e92c:	01813983          	ld	s3,24(sp)
    8000e930:	01013a03          	ld	s4,16(sp)
    8000e934:	00813a83          	ld	s5,8(sp)
    8000e938:	00013b03          	ld	s6,0(sp)
    8000e93c:	04010113          	addi	sp,sp,64
    8000e940:	00008067          	ret

000000008000e944 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000e944:	fe010113          	addi	sp,sp,-32
    8000e948:	00113c23          	sd	ra,24(sp)
    8000e94c:	00813823          	sd	s0,16(sp)
    8000e950:	00913423          	sd	s1,8(sp)
    8000e954:	01213023          	sd	s2,0(sp)
    8000e958:	02010413          	addi	s0,sp,32
    8000e95c:	00050493          	mv	s1,a0
    8000e960:	00058913          	mv	s2,a1
    8000e964:	0015879b          	addiw	a5,a1,1
    8000e968:	0007851b          	sext.w	a0,a5
    8000e96c:	00f4a023          	sw	a5,0(s1)
    8000e970:	0004a823          	sw	zero,16(s1)
    8000e974:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000e978:	00251513          	slli	a0,a0,0x2
    8000e97c:	ffffe097          	auipc	ra,0xffffe
    8000e980:	6a4080e7          	jalr	1700(ra) # 8000d020 <_Z9mem_allocm>
    8000e984:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000e988:	00000593          	li	a1,0
    8000e98c:	02048513          	addi	a0,s1,32
    8000e990:	fffff097          	auipc	ra,0xfffff
    8000e994:	88c080e7          	jalr	-1908(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    8000e998:	00090593          	mv	a1,s2
    8000e99c:	01848513          	addi	a0,s1,24
    8000e9a0:	fffff097          	auipc	ra,0xfffff
    8000e9a4:	87c080e7          	jalr	-1924(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    8000e9a8:	00100593          	li	a1,1
    8000e9ac:	02848513          	addi	a0,s1,40
    8000e9b0:	fffff097          	auipc	ra,0xfffff
    8000e9b4:	86c080e7          	jalr	-1940(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    8000e9b8:	00100593          	li	a1,1
    8000e9bc:	03048513          	addi	a0,s1,48
    8000e9c0:	fffff097          	auipc	ra,0xfffff
    8000e9c4:	85c080e7          	jalr	-1956(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000e9c8:	01813083          	ld	ra,24(sp)
    8000e9cc:	01013403          	ld	s0,16(sp)
    8000e9d0:	00813483          	ld	s1,8(sp)
    8000e9d4:	00013903          	ld	s2,0(sp)
    8000e9d8:	02010113          	addi	sp,sp,32
    8000e9dc:	00008067          	ret

000000008000e9e0 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000e9e0:	fe010113          	addi	sp,sp,-32
    8000e9e4:	00113c23          	sd	ra,24(sp)
    8000e9e8:	00813823          	sd	s0,16(sp)
    8000e9ec:	00913423          	sd	s1,8(sp)
    8000e9f0:	01213023          	sd	s2,0(sp)
    8000e9f4:	02010413          	addi	s0,sp,32
    8000e9f8:	00050493          	mv	s1,a0
    8000e9fc:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000ea00:	01853503          	ld	a0,24(a0)
    8000ea04:	fffff097          	auipc	ra,0xfffff
    8000ea08:	87c080e7          	jalr	-1924(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    8000ea0c:	0304b503          	ld	a0,48(s1)
    8000ea10:	fffff097          	auipc	ra,0xfffff
    8000ea14:	870080e7          	jalr	-1936(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    8000ea18:	0084b783          	ld	a5,8(s1)
    8000ea1c:	0144a703          	lw	a4,20(s1)
    8000ea20:	00271713          	slli	a4,a4,0x2
    8000ea24:	00e787b3          	add	a5,a5,a4
    8000ea28:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000ea2c:	0144a783          	lw	a5,20(s1)
    8000ea30:	0017879b          	addiw	a5,a5,1
    8000ea34:	0004a703          	lw	a4,0(s1)
    8000ea38:	02e7e7bb          	remw	a5,a5,a4
    8000ea3c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    8000ea40:	0304b503          	ld	a0,48(s1)
    8000ea44:	fffff097          	auipc	ra,0xfffff
    8000ea48:	868080e7          	jalr	-1944(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    8000ea4c:	0204b503          	ld	a0,32(s1)
    8000ea50:	fffff097          	auipc	ra,0xfffff
    8000ea54:	85c080e7          	jalr	-1956(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

}
    8000ea58:	01813083          	ld	ra,24(sp)
    8000ea5c:	01013403          	ld	s0,16(sp)
    8000ea60:	00813483          	ld	s1,8(sp)
    8000ea64:	00013903          	ld	s2,0(sp)
    8000ea68:	02010113          	addi	sp,sp,32
    8000ea6c:	00008067          	ret

000000008000ea70 <_ZN6Buffer3getEv>:

int Buffer::get() {
    8000ea70:	fe010113          	addi	sp,sp,-32
    8000ea74:	00113c23          	sd	ra,24(sp)
    8000ea78:	00813823          	sd	s0,16(sp)
    8000ea7c:	00913423          	sd	s1,8(sp)
    8000ea80:	01213023          	sd	s2,0(sp)
    8000ea84:	02010413          	addi	s0,sp,32
    8000ea88:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8000ea8c:	02053503          	ld	a0,32(a0)
    8000ea90:	ffffe097          	auipc	ra,0xffffe
    8000ea94:	7f0080e7          	jalr	2032(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    8000ea98:	0284b503          	ld	a0,40(s1)
    8000ea9c:	ffffe097          	auipc	ra,0xffffe
    8000eaa0:	7e4080e7          	jalr	2020(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8000eaa4:	0084b703          	ld	a4,8(s1)
    8000eaa8:	0104a783          	lw	a5,16(s1)
    8000eaac:	00279693          	slli	a3,a5,0x2
    8000eab0:	00d70733          	add	a4,a4,a3
    8000eab4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000eab8:	0017879b          	addiw	a5,a5,1
    8000eabc:	0004a703          	lw	a4,0(s1)
    8000eac0:	02e7e7bb          	remw	a5,a5,a4
    8000eac4:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000eac8:	0284b503          	ld	a0,40(s1)
    8000eacc:	ffffe097          	auipc	ra,0xffffe
    8000ead0:	7e0080e7          	jalr	2016(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    8000ead4:	0184b503          	ld	a0,24(s1)
    8000ead8:	ffffe097          	auipc	ra,0xffffe
    8000eadc:	7d4080e7          	jalr	2004(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000eae0:	00090513          	mv	a0,s2
    8000eae4:	01813083          	ld	ra,24(sp)
    8000eae8:	01013403          	ld	s0,16(sp)
    8000eaec:	00813483          	ld	s1,8(sp)
    8000eaf0:	00013903          	ld	s2,0(sp)
    8000eaf4:	02010113          	addi	sp,sp,32
    8000eaf8:	00008067          	ret

000000008000eafc <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000eafc:	fe010113          	addi	sp,sp,-32
    8000eb00:	00113c23          	sd	ra,24(sp)
    8000eb04:	00813823          	sd	s0,16(sp)
    8000eb08:	00913423          	sd	s1,8(sp)
    8000eb0c:	01213023          	sd	s2,0(sp)
    8000eb10:	02010413          	addi	s0,sp,32
    8000eb14:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    8000eb18:	02853503          	ld	a0,40(a0)
    8000eb1c:	ffffe097          	auipc	ra,0xffffe
    8000eb20:	764080e7          	jalr	1892(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    8000eb24:	0304b503          	ld	a0,48(s1)
    8000eb28:	ffffe097          	auipc	ra,0xffffe
    8000eb2c:	758080e7          	jalr	1880(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    8000eb30:	0144a783          	lw	a5,20(s1)
    8000eb34:	0104a903          	lw	s2,16(s1)
    8000eb38:	0327ce63          	blt	a5,s2,8000eb74 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000eb3c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    8000eb40:	0304b503          	ld	a0,48(s1)
    8000eb44:	ffffe097          	auipc	ra,0xffffe
    8000eb48:	768080e7          	jalr	1896(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8000eb4c:	0284b503          	ld	a0,40(s1)
    8000eb50:	ffffe097          	auipc	ra,0xffffe
    8000eb54:	75c080e7          	jalr	1884(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000eb58:	00090513          	mv	a0,s2
    8000eb5c:	01813083          	ld	ra,24(sp)
    8000eb60:	01013403          	ld	s0,16(sp)
    8000eb64:	00813483          	ld	s1,8(sp)
    8000eb68:	00013903          	ld	s2,0(sp)
    8000eb6c:	02010113          	addi	sp,sp,32
    8000eb70:	00008067          	ret
        ret = cap - head + tail;
    8000eb74:	0004a703          	lw	a4,0(s1)
    8000eb78:	4127093b          	subw	s2,a4,s2
    8000eb7c:	00f9093b          	addw	s2,s2,a5
    8000eb80:	fc1ff06f          	j	8000eb40 <_ZN6Buffer6getCntEv+0x44>

000000008000eb84 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000eb84:	fe010113          	addi	sp,sp,-32
    8000eb88:	00113c23          	sd	ra,24(sp)
    8000eb8c:	00813823          	sd	s0,16(sp)
    8000eb90:	00913423          	sd	s1,8(sp)
    8000eb94:	02010413          	addi	s0,sp,32
    8000eb98:	00050493          	mv	s1,a0
    putc('\n');
    8000eb9c:	00a00513          	li	a0,10
    8000eba0:	ffffe097          	auipc	ra,0xffffe
    8000eba4:	78c080e7          	jalr	1932(ra) # 8000d32c <_Z4putcc>
    printString("Buffer deleted!\n");
    8000eba8:	00001517          	auipc	a0,0x1
    8000ebac:	45850513          	addi	a0,a0,1112 # 80010000 <userDataStart>
    8000ebb0:	00000097          	auipc	ra,0x0
    8000ebb4:	0b4080e7          	jalr	180(ra) # 8000ec64 <_Z11printStringPKc>
    while (getCnt() > 0) {
    8000ebb8:	00048513          	mv	a0,s1
    8000ebbc:	00000097          	auipc	ra,0x0
    8000ebc0:	f40080e7          	jalr	-192(ra) # 8000eafc <_ZN6Buffer6getCntEv>
    8000ebc4:	02a05c63          	blez	a0,8000ebfc <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    8000ebc8:	0084b783          	ld	a5,8(s1)
    8000ebcc:	0104a703          	lw	a4,16(s1)
    8000ebd0:	00271713          	slli	a4,a4,0x2
    8000ebd4:	00e787b3          	add	a5,a5,a4
        putc(ch);
    8000ebd8:	0007c503          	lbu	a0,0(a5)
    8000ebdc:	ffffe097          	auipc	ra,0xffffe
    8000ebe0:	750080e7          	jalr	1872(ra) # 8000d32c <_Z4putcc>
        head = (head + 1) % cap;
    8000ebe4:	0104a783          	lw	a5,16(s1)
    8000ebe8:	0017879b          	addiw	a5,a5,1
    8000ebec:	0004a703          	lw	a4,0(s1)
    8000ebf0:	02e7e7bb          	remw	a5,a5,a4
    8000ebf4:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    8000ebf8:	fc1ff06f          	j	8000ebb8 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000ebfc:	02100513          	li	a0,33
    8000ec00:	ffffe097          	auipc	ra,0xffffe
    8000ec04:	72c080e7          	jalr	1836(ra) # 8000d32c <_Z4putcc>
    putc('\n');
    8000ec08:	00a00513          	li	a0,10
    8000ec0c:	ffffe097          	auipc	ra,0xffffe
    8000ec10:	720080e7          	jalr	1824(ra) # 8000d32c <_Z4putcc>
    mem_free(buffer);
    8000ec14:	0084b503          	ld	a0,8(s1)
    8000ec18:	ffffe097          	auipc	ra,0xffffe
    8000ec1c:	438080e7          	jalr	1080(ra) # 8000d050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    8000ec20:	0204b503          	ld	a0,32(s1)
    8000ec24:	ffffe097          	auipc	ra,0xffffe
    8000ec28:	630080e7          	jalr	1584(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    8000ec2c:	0184b503          	ld	a0,24(s1)
    8000ec30:	ffffe097          	auipc	ra,0xffffe
    8000ec34:	624080e7          	jalr	1572(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    8000ec38:	0304b503          	ld	a0,48(s1)
    8000ec3c:	ffffe097          	auipc	ra,0xffffe
    8000ec40:	618080e7          	jalr	1560(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    8000ec44:	0284b503          	ld	a0,40(s1)
    8000ec48:	ffffe097          	auipc	ra,0xffffe
    8000ec4c:	60c080e7          	jalr	1548(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
}
    8000ec50:	01813083          	ld	ra,24(sp)
    8000ec54:	01013403          	ld	s0,16(sp)
    8000ec58:	00813483          	ld	s1,8(sp)
    8000ec5c:	02010113          	addi	sp,sp,32
    8000ec60:	00008067          	ret

000000008000ec64 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000ec64:	fe010113          	addi	sp,sp,-32
    8000ec68:	00113c23          	sd	ra,24(sp)
    8000ec6c:	00813823          	sd	s0,16(sp)
    8000ec70:	00913423          	sd	s1,8(sp)
    8000ec74:	02010413          	addi	s0,sp,32
    8000ec78:	00050493          	mv	s1,a0
    LOCK();
    8000ec7c:	00100613          	li	a2,1
    8000ec80:	00000593          	li	a1,0
    8000ec84:	00001517          	auipc	a0,0x1
    8000ec88:	70450513          	addi	a0,a0,1796 # 80010388 <lockPrint>
    8000ec8c:	ffffe097          	auipc	ra,0xffffe
    8000ec90:	374080e7          	jalr	884(ra) # 8000d000 <copy_and_swap>
    8000ec94:	fe0514e3          	bnez	a0,8000ec7c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000ec98:	0004c503          	lbu	a0,0(s1)
    8000ec9c:	00050a63          	beqz	a0,8000ecb0 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000eca0:	ffffe097          	auipc	ra,0xffffe
    8000eca4:	68c080e7          	jalr	1676(ra) # 8000d32c <_Z4putcc>
        string++;
    8000eca8:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000ecac:	fedff06f          	j	8000ec98 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000ecb0:	00000613          	li	a2,0
    8000ecb4:	00100593          	li	a1,1
    8000ecb8:	00001517          	auipc	a0,0x1
    8000ecbc:	6d050513          	addi	a0,a0,1744 # 80010388 <lockPrint>
    8000ecc0:	ffffe097          	auipc	ra,0xffffe
    8000ecc4:	340080e7          	jalr	832(ra) # 8000d000 <copy_and_swap>
    8000ecc8:	fe0514e3          	bnez	a0,8000ecb0 <_Z11printStringPKc+0x4c>
}
    8000eccc:	01813083          	ld	ra,24(sp)
    8000ecd0:	01013403          	ld	s0,16(sp)
    8000ecd4:	00813483          	ld	s1,8(sp)
    8000ecd8:	02010113          	addi	sp,sp,32
    8000ecdc:	00008067          	ret

000000008000ece0 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    8000ece0:	fd010113          	addi	sp,sp,-48
    8000ece4:	02113423          	sd	ra,40(sp)
    8000ece8:	02813023          	sd	s0,32(sp)
    8000ecec:	00913c23          	sd	s1,24(sp)
    8000ecf0:	01213823          	sd	s2,16(sp)
    8000ecf4:	01313423          	sd	s3,8(sp)
    8000ecf8:	01413023          	sd	s4,0(sp)
    8000ecfc:	03010413          	addi	s0,sp,48
    8000ed00:	00050993          	mv	s3,a0
    8000ed04:	00058a13          	mv	s4,a1
    LOCK();
    8000ed08:	00100613          	li	a2,1
    8000ed0c:	00000593          	li	a1,0
    8000ed10:	00001517          	auipc	a0,0x1
    8000ed14:	67850513          	addi	a0,a0,1656 # 80010388 <lockPrint>
    8000ed18:	ffffe097          	auipc	ra,0xffffe
    8000ed1c:	2e8080e7          	jalr	744(ra) # 8000d000 <copy_and_swap>
    8000ed20:	fe0514e3          	bnez	a0,8000ed08 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000ed24:	00000913          	li	s2,0
    8000ed28:	00090493          	mv	s1,s2
    8000ed2c:	0019091b          	addiw	s2,s2,1
    8000ed30:	03495a63          	bge	s2,s4,8000ed64 <_Z9getStringPci+0x84>
        cc = getc();
    8000ed34:	ffffe097          	auipc	ra,0xffffe
    8000ed38:	5d0080e7          	jalr	1488(ra) # 8000d304 <_Z4getcv>
        if(cc < 1)
    8000ed3c:	02050463          	beqz	a0,8000ed64 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000ed40:	009984b3          	add	s1,s3,s1
    8000ed44:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000ed48:	00a00793          	li	a5,10
    8000ed4c:	00f50a63          	beq	a0,a5,8000ed60 <_Z9getStringPci+0x80>
    8000ed50:	00d00793          	li	a5,13
    8000ed54:	fcf51ae3          	bne	a0,a5,8000ed28 <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000ed58:	00090493          	mv	s1,s2
    8000ed5c:	0080006f          	j	8000ed64 <_Z9getStringPci+0x84>
    8000ed60:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    8000ed64:	009984b3          	add	s1,s3,s1
    8000ed68:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000ed6c:	00000613          	li	a2,0
    8000ed70:	00100593          	li	a1,1
    8000ed74:	00001517          	auipc	a0,0x1
    8000ed78:	61450513          	addi	a0,a0,1556 # 80010388 <lockPrint>
    8000ed7c:	ffffe097          	auipc	ra,0xffffe
    8000ed80:	284080e7          	jalr	644(ra) # 8000d000 <copy_and_swap>
    8000ed84:	fe0514e3          	bnez	a0,8000ed6c <_Z9getStringPci+0x8c>
    return buf;
}
    8000ed88:	00098513          	mv	a0,s3
    8000ed8c:	02813083          	ld	ra,40(sp)
    8000ed90:	02013403          	ld	s0,32(sp)
    8000ed94:	01813483          	ld	s1,24(sp)
    8000ed98:	01013903          	ld	s2,16(sp)
    8000ed9c:	00813983          	ld	s3,8(sp)
    8000eda0:	00013a03          	ld	s4,0(sp)
    8000eda4:	03010113          	addi	sp,sp,48
    8000eda8:	00008067          	ret

000000008000edac <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000edac:	ff010113          	addi	sp,sp,-16
    8000edb0:	00813423          	sd	s0,8(sp)
    8000edb4:	01010413          	addi	s0,sp,16
    8000edb8:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000edbc:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000edc0:	0006c603          	lbu	a2,0(a3)
    8000edc4:	fd06071b          	addiw	a4,a2,-48
    8000edc8:	0ff77713          	andi	a4,a4,255
    8000edcc:	00900793          	li	a5,9
    8000edd0:	02e7e063          	bltu	a5,a4,8000edf0 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000edd4:	0025179b          	slliw	a5,a0,0x2
    8000edd8:	00a787bb          	addw	a5,a5,a0
    8000eddc:	0017979b          	slliw	a5,a5,0x1
    8000ede0:	00168693          	addi	a3,a3,1
    8000ede4:	00c787bb          	addw	a5,a5,a2
    8000ede8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000edec:	fd5ff06f          	j	8000edc0 <_Z11stringToIntPKc+0x14>
    return n;
}
    8000edf0:	00813403          	ld	s0,8(sp)
    8000edf4:	01010113          	addi	sp,sp,16
    8000edf8:	00008067          	ret

000000008000edfc <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000edfc:	fc010113          	addi	sp,sp,-64
    8000ee00:	02113c23          	sd	ra,56(sp)
    8000ee04:	02813823          	sd	s0,48(sp)
    8000ee08:	02913423          	sd	s1,40(sp)
    8000ee0c:	03213023          	sd	s2,32(sp)
    8000ee10:	01313c23          	sd	s3,24(sp)
    8000ee14:	04010413          	addi	s0,sp,64
    8000ee18:	00050493          	mv	s1,a0
    8000ee1c:	00058913          	mv	s2,a1
    8000ee20:	00060993          	mv	s3,a2
    LOCK();
    8000ee24:	00100613          	li	a2,1
    8000ee28:	00000593          	li	a1,0
    8000ee2c:	00001517          	auipc	a0,0x1
    8000ee30:	55c50513          	addi	a0,a0,1372 # 80010388 <lockPrint>
    8000ee34:	ffffe097          	auipc	ra,0xffffe
    8000ee38:	1cc080e7          	jalr	460(ra) # 8000d000 <copy_and_swap>
    8000ee3c:	fe0514e3          	bnez	a0,8000ee24 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000ee40:	00098463          	beqz	s3,8000ee48 <_Z8printIntiii+0x4c>
    8000ee44:	0804c463          	bltz	s1,8000eecc <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000ee48:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000ee4c:	00000593          	li	a1,0
    }

    i = 0;
    8000ee50:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000ee54:	0009079b          	sext.w	a5,s2
    8000ee58:	0325773b          	remuw	a4,a0,s2
    8000ee5c:	00048613          	mv	a2,s1
    8000ee60:	0014849b          	addiw	s1,s1,1
    8000ee64:	02071693          	slli	a3,a4,0x20
    8000ee68:	0206d693          	srli	a3,a3,0x20
    8000ee6c:	00001717          	auipc	a4,0x1
    8000ee70:	47470713          	addi	a4,a4,1140 # 800102e0 <digits>
    8000ee74:	00d70733          	add	a4,a4,a3
    8000ee78:	00074683          	lbu	a3,0(a4)
    8000ee7c:	fd040713          	addi	a4,s0,-48
    8000ee80:	00c70733          	add	a4,a4,a2
    8000ee84:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    8000ee88:	0005071b          	sext.w	a4,a0
    8000ee8c:	0325553b          	divuw	a0,a0,s2
    8000ee90:	fcf772e3          	bgeu	a4,a5,8000ee54 <_Z8printIntiii+0x58>
    if(neg)
    8000ee94:	00058c63          	beqz	a1,8000eeac <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    8000ee98:	fd040793          	addi	a5,s0,-48
    8000ee9c:	009784b3          	add	s1,a5,s1
    8000eea0:	02d00793          	li	a5,45
    8000eea4:	fef48823          	sb	a5,-16(s1)
    8000eea8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000eeac:	fff4849b          	addiw	s1,s1,-1
    8000eeb0:	0204c463          	bltz	s1,8000eed8 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    8000eeb4:	fd040793          	addi	a5,s0,-48
    8000eeb8:	009787b3          	add	a5,a5,s1
    8000eebc:	ff07c503          	lbu	a0,-16(a5)
    8000eec0:	ffffe097          	auipc	ra,0xffffe
    8000eec4:	46c080e7          	jalr	1132(ra) # 8000d32c <_Z4putcc>
    8000eec8:	fe5ff06f          	j	8000eeac <_Z8printIntiii+0xb0>
        x = -xx;
    8000eecc:	4090053b          	negw	a0,s1
        neg = 1;
    8000eed0:	00100593          	li	a1,1
        x = -xx;
    8000eed4:	f7dff06f          	j	8000ee50 <_Z8printIntiii+0x54>

    UNLOCK();
    8000eed8:	00000613          	li	a2,0
    8000eedc:	00100593          	li	a1,1
    8000eee0:	00001517          	auipc	a0,0x1
    8000eee4:	4a850513          	addi	a0,a0,1192 # 80010388 <lockPrint>
    8000eee8:	ffffe097          	auipc	ra,0xffffe
    8000eeec:	118080e7          	jalr	280(ra) # 8000d000 <copy_and_swap>
    8000eef0:	fe0514e3          	bnez	a0,8000eed8 <_Z8printIntiii+0xdc>
    8000eef4:	03813083          	ld	ra,56(sp)
    8000eef8:	03013403          	ld	s0,48(sp)
    8000eefc:	02813483          	ld	s1,40(sp)
    8000ef00:	02013903          	ld	s2,32(sp)
    8000ef04:	01813983          	ld	s3,24(sp)
    8000ef08:	04010113          	addi	sp,sp,64
    8000ef0c:	00008067          	ret

000000008000ef10 <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    8000ef10:	ff010113          	addi	sp,sp,-16
    8000ef14:	00113423          	sd	ra,8(sp)
    8000ef18:	00813023          	sd	s0,0(sp)
    8000ef1c:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    8000ef20:	00053783          	ld	a5,0(a0)
    8000ef24:	0107b783          	ld	a5,16(a5)
    8000ef28:	000780e7          	jalr	a5
}
    8000ef2c:	00813083          	ld	ra,8(sp)
    8000ef30:	00013403          	ld	s0,0(sp)
    8000ef34:	01010113          	addi	sp,sp,16
    8000ef38:	00008067          	ret

000000008000ef3c <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    8000ef3c:	ff010113          	addi	sp,sp,-16
    8000ef40:	00113423          	sd	ra,8(sp)
    8000ef44:	00813023          	sd	s0,0(sp)
    8000ef48:	01010413          	addi	s0,sp,16
    8000ef4c:	00001797          	auipc	a5,0x1
    8000ef50:	3ec78793          	addi	a5,a5,1004 # 80010338 <_ZTV9Semaphore+0x10>
    8000ef54:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    8000ef58:	00853503          	ld	a0,8(a0)
    8000ef5c:	ffffe097          	auipc	ra,0xffffe
    8000ef60:	2f8080e7          	jalr	760(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
};
    8000ef64:	00813083          	ld	ra,8(sp)
    8000ef68:	00013403          	ld	s0,0(sp)
    8000ef6c:	01010113          	addi	sp,sp,16
    8000ef70:	00008067          	ret

000000008000ef74 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    8000ef74:	00001797          	auipc	a5,0x1
    8000ef78:	3e478793          	addi	a5,a5,996 # 80010358 <_ZTV6Thread+0x10>
    8000ef7c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000ef80:	00853503          	ld	a0,8(a0)
    8000ef84:	02050663          	beqz	a0,8000efb0 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    8000ef88:	ff010113          	addi	sp,sp,-16
    8000ef8c:	00113423          	sd	ra,8(sp)
    8000ef90:	00813023          	sd	s0,0(sp)
    8000ef94:	01010413          	addi	s0,sp,16
    delete myHandle;
    8000ef98:	ffffe097          	auipc	ra,0xffffe
    8000ef9c:	42c080e7          	jalr	1068(ra) # 8000d3c4 <_ZN7_threaddlEPv>
}
    8000efa0:	00813083          	ld	ra,8(sp)
    8000efa4:	00013403          	ld	s0,0(sp)
    8000efa8:	01010113          	addi	sp,sp,16
    8000efac:	00008067          	ret
    8000efb0:	00008067          	ret

000000008000efb4 <_Znwm>:
void* operator new(size_t sz){
    8000efb4:	ff010113          	addi	sp,sp,-16
    8000efb8:	00113423          	sd	ra,8(sp)
    8000efbc:	00813023          	sd	s0,0(sp)
    8000efc0:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000efc4:	ffffe097          	auipc	ra,0xffffe
    8000efc8:	05c080e7          	jalr	92(ra) # 8000d020 <_Z9mem_allocm>
}
    8000efcc:	00813083          	ld	ra,8(sp)
    8000efd0:	00013403          	ld	s0,0(sp)
    8000efd4:	01010113          	addi	sp,sp,16
    8000efd8:	00008067          	ret

000000008000efdc <_Znam>:
void* operator new[](size_t sz){
    8000efdc:	ff010113          	addi	sp,sp,-16
    8000efe0:	00113423          	sd	ra,8(sp)
    8000efe4:	00813023          	sd	s0,0(sp)
    8000efe8:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000efec:	ffffe097          	auipc	ra,0xffffe
    8000eff0:	034080e7          	jalr	52(ra) # 8000d020 <_Z9mem_allocm>
}
    8000eff4:	00813083          	ld	ra,8(sp)
    8000eff8:	00013403          	ld	s0,0(sp)
    8000effc:	01010113          	addi	sp,sp,16
    8000f000:	00008067          	ret

000000008000f004 <_ZdlPv>:
void operator delete(void *ptr){
    8000f004:	ff010113          	addi	sp,sp,-16
    8000f008:	00113423          	sd	ra,8(sp)
    8000f00c:	00813023          	sd	s0,0(sp)
    8000f010:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    8000f014:	ffffe097          	auipc	ra,0xffffe
    8000f018:	03c080e7          	jalr	60(ra) # 8000d050 <_Z8mem_freePv>
}
    8000f01c:	00813083          	ld	ra,8(sp)
    8000f020:	00013403          	ld	s0,0(sp)
    8000f024:	01010113          	addi	sp,sp,16
    8000f028:	00008067          	ret

000000008000f02c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    8000f02c:	fe010113          	addi	sp,sp,-32
    8000f030:	00113c23          	sd	ra,24(sp)
    8000f034:	00813823          	sd	s0,16(sp)
    8000f038:	00913423          	sd	s1,8(sp)
    8000f03c:	02010413          	addi	s0,sp,32
    8000f040:	00050493          	mv	s1,a0
};
    8000f044:	00000097          	auipc	ra,0x0
    8000f048:	ef8080e7          	jalr	-264(ra) # 8000ef3c <_ZN9SemaphoreD1Ev>
    8000f04c:	00048513          	mv	a0,s1
    8000f050:	00000097          	auipc	ra,0x0
    8000f054:	fb4080e7          	jalr	-76(ra) # 8000f004 <_ZdlPv>
    8000f058:	01813083          	ld	ra,24(sp)
    8000f05c:	01013403          	ld	s0,16(sp)
    8000f060:	00813483          	ld	s1,8(sp)
    8000f064:	02010113          	addi	sp,sp,32
    8000f068:	00008067          	ret

000000008000f06c <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    8000f06c:	fe010113          	addi	sp,sp,-32
    8000f070:	00113c23          	sd	ra,24(sp)
    8000f074:	00813823          	sd	s0,16(sp)
    8000f078:	00913423          	sd	s1,8(sp)
    8000f07c:	02010413          	addi	s0,sp,32
    8000f080:	00050493          	mv	s1,a0
}
    8000f084:	00000097          	auipc	ra,0x0
    8000f088:	ef0080e7          	jalr	-272(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000f08c:	00048513          	mv	a0,s1
    8000f090:	00000097          	auipc	ra,0x0
    8000f094:	f74080e7          	jalr	-140(ra) # 8000f004 <_ZdlPv>
    8000f098:	01813083          	ld	ra,24(sp)
    8000f09c:	01013403          	ld	s0,16(sp)
    8000f0a0:	00813483          	ld	s1,8(sp)
    8000f0a4:	02010113          	addi	sp,sp,32
    8000f0a8:	00008067          	ret

000000008000f0ac <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000f0ac:	ff010113          	addi	sp,sp,-16
    8000f0b0:	00113423          	sd	ra,8(sp)
    8000f0b4:	00813023          	sd	s0,0(sp)
    8000f0b8:	01010413          	addi	s0,sp,16
    8000f0bc:	00001797          	auipc	a5,0x1
    8000f0c0:	27c78793          	addi	a5,a5,636 # 80010338 <_ZTV9Semaphore+0x10>
    8000f0c4:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    8000f0c8:	00850513          	addi	a0,a0,8
    8000f0cc:	ffffe097          	auipc	ra,0xffffe
    8000f0d0:	150080e7          	jalr	336(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000f0d4:	00813083          	ld	ra,8(sp)
    8000f0d8:	00013403          	ld	s0,0(sp)
    8000f0dc:	01010113          	addi	sp,sp,16
    8000f0e0:	00008067          	ret

000000008000f0e4 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    8000f0e4:	ff010113          	addi	sp,sp,-16
    8000f0e8:	00113423          	sd	ra,8(sp)
    8000f0ec:	00813023          	sd	s0,0(sp)
    8000f0f0:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    8000f0f4:	00853503          	ld	a0,8(a0)
    8000f0f8:	ffffe097          	auipc	ra,0xffffe
    8000f0fc:	188080e7          	jalr	392(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
}
    8000f100:	00813083          	ld	ra,8(sp)
    8000f104:	00013403          	ld	s0,0(sp)
    8000f108:	01010113          	addi	sp,sp,16
    8000f10c:	00008067          	ret

000000008000f110 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    8000f110:	ff010113          	addi	sp,sp,-16
    8000f114:	00113423          	sd	ra,8(sp)
    8000f118:	00813023          	sd	s0,0(sp)
    8000f11c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    8000f120:	00853503          	ld	a0,8(a0)
    8000f124:	ffffe097          	auipc	ra,0xffffe
    8000f128:	188080e7          	jalr	392(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
}
    8000f12c:	00813083          	ld	ra,8(sp)
    8000f130:	00013403          	ld	s0,0(sp)
    8000f134:	01010113          	addi	sp,sp,16
    8000f138:	00008067          	ret

000000008000f13c <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    8000f13c:	fe010113          	addi	sp,sp,-32
    8000f140:	00113c23          	sd	ra,24(sp)
    8000f144:	00813823          	sd	s0,16(sp)
    8000f148:	00913423          	sd	s1,8(sp)
    8000f14c:	02010413          	addi	s0,sp,32
    8000f150:	00050493          	mv	s1,a0
    8000f154:	00001797          	auipc	a5,0x1
    8000f158:	20478793          	addi	a5,a5,516 # 80010358 <_ZTV6Thread+0x10>
    8000f15c:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    8000f160:	00850513          	addi	a0,a0,8
    8000f164:	ffffe097          	auipc	ra,0xffffe
    8000f168:	fec080e7          	jalr	-20(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f16c:	fff00793          	li	a5,-1
    8000f170:	00f50c63          	beq	a0,a5,8000f188 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    8000f174:	01813083          	ld	ra,24(sp)
    8000f178:	01013403          	ld	s0,16(sp)
    8000f17c:	00813483          	ld	s1,8(sp)
    8000f180:	02010113          	addi	sp,sp,32
    8000f184:	00008067          	ret
        myHandle = nullptr;
    8000f188:	0004b423          	sd	zero,8(s1)
}
    8000f18c:	fe9ff06f          	j	8000f174 <_ZN6ThreadC1EPFvPvES0_+0x38>

000000008000f190 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    8000f190:	fe010113          	addi	sp,sp,-32
    8000f194:	00113c23          	sd	ra,24(sp)
    8000f198:	00813823          	sd	s0,16(sp)
    8000f19c:	00913423          	sd	s1,8(sp)
    8000f1a0:	02010413          	addi	s0,sp,32
    8000f1a4:	00050493          	mv	s1,a0
    8000f1a8:	00001797          	auipc	a5,0x1
    8000f1ac:	1b078793          	addi	a5,a5,432 # 80010358 <_ZTV6Thread+0x10>
    8000f1b0:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    8000f1b4:	00050613          	mv	a2,a0
    8000f1b8:	00000597          	auipc	a1,0x0
    8000f1bc:	d5858593          	addi	a1,a1,-680 # 8000ef10 <_ZN6Thread7wrapperEPv>
    8000f1c0:	00850513          	addi	a0,a0,8
    8000f1c4:	ffffe097          	auipc	ra,0xffffe
    8000f1c8:	f8c080e7          	jalr	-116(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f1cc:	fff00793          	li	a5,-1
    8000f1d0:	00f50c63          	beq	a0,a5,8000f1e8 <_ZN6ThreadC1Ev+0x58>
}
    8000f1d4:	01813083          	ld	ra,24(sp)
    8000f1d8:	01013403          	ld	s0,16(sp)
    8000f1dc:	00813483          	ld	s1,8(sp)
    8000f1e0:	02010113          	addi	sp,sp,32
    8000f1e4:	00008067          	ret
        myHandle = nullptr;
    8000f1e8:	0004b423          	sd	zero,8(s1)
}
    8000f1ec:	fe9ff06f          	j	8000f1d4 <_ZN6ThreadC1Ev+0x44>

000000008000f1f0 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    8000f1f0:	ff010113          	addi	sp,sp,-16
    8000f1f4:	00113423          	sd	ra,8(sp)
    8000f1f8:	00813023          	sd	s0,0(sp)
    8000f1fc:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    8000f200:	ffffe097          	auipc	ra,0xffffe
    8000f204:	0d8080e7          	jalr	216(ra) # 8000d2d8 <_Z10time_sleepm>
}
    8000f208:	00813083          	ld	ra,8(sp)
    8000f20c:	00013403          	ld	s0,0(sp)
    8000f210:	01010113          	addi	sp,sp,16
    8000f214:	00008067          	ret

000000008000f218 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    8000f218:	fe010113          	addi	sp,sp,-32
    8000f21c:	00113c23          	sd	ra,24(sp)
    8000f220:	00813823          	sd	s0,16(sp)
    8000f224:	00913423          	sd	s1,8(sp)
    8000f228:	01213023          	sd	s2,0(sp)
    8000f22c:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    8000f230:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    8000f234:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    8000f238:	0004b783          	ld	a5,0(s1)
    8000f23c:	0187b783          	ld	a5,24(a5)
    8000f240:	00048513          	mv	a0,s1
    8000f244:	000780e7          	jalr	a5
        pt->sleep(time);
    8000f248:	00090513          	mv	a0,s2
    8000f24c:	00000097          	auipc	ra,0x0
    8000f250:	fa4080e7          	jalr	-92(ra) # 8000f1f0 <_ZN6Thread5sleepEm>
    while(true){
    8000f254:	fe5ff06f          	j	8000f238 <_ZN14PeriodicThread7wrapperEPv+0x20>

000000008000f258 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000f258:	ff010113          	addi	sp,sp,-16
    8000f25c:	00113423          	sd	ra,8(sp)
    8000f260:	00813023          	sd	s0,0(sp)
    8000f264:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000f268:	ffffe097          	auipc	ra,0xffffe
    8000f26c:	ec8080e7          	jalr	-312(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000f270:	00813083          	ld	ra,8(sp)
    8000f274:	00013403          	ld	s0,0(sp)
    8000f278:	01010113          	addi	sp,sp,16
    8000f27c:	00008067          	ret

000000008000f280 <_ZN6Thread5startEv>:
int Thread::start() {
    8000f280:	ff010113          	addi	sp,sp,-16
    8000f284:	00113423          	sd	ra,8(sp)
    8000f288:	00813023          	sd	s0,0(sp)
    8000f28c:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    8000f290:	00853503          	ld	a0,8(a0)
    8000f294:	ffffe097          	auipc	ra,0xffffe
    8000f298:	f50080e7          	jalr	-176(ra) # 8000d1e4 <_Z12thread_startP7_thread>
}
    8000f29c:	00813083          	ld	ra,8(sp)
    8000f2a0:	00013403          	ld	s0,0(sp)
    8000f2a4:	01010113          	addi	sp,sp,16
    8000f2a8:	00008067          	ret

000000008000f2ac <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f2ac:	fe010113          	addi	sp,sp,-32
    8000f2b0:	00113c23          	sd	ra,24(sp)
    8000f2b4:	00813823          	sd	s0,16(sp)
    8000f2b8:	00913423          	sd	s1,8(sp)
    8000f2bc:	01213023          	sd	s2,0(sp)
    8000f2c0:	02010413          	addi	s0,sp,32
    8000f2c4:	00050493          	mv	s1,a0
    8000f2c8:	00058913          	mv	s2,a1
    8000f2cc:	01000513          	li	a0,16
    8000f2d0:	00000097          	auipc	ra,0x0
    8000f2d4:	ce4080e7          	jalr	-796(ra) # 8000efb4 <_Znwm>
    8000f2d8:	00050613          	mv	a2,a0
    8000f2dc:	00050663          	beqz	a0,8000f2e8 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    8000f2e0:	00953023          	sd	s1,0(a0)
    8000f2e4:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f2e8:	00000597          	auipc	a1,0x0
    8000f2ec:	f3058593          	addi	a1,a1,-208 # 8000f218 <_ZN14PeriodicThread7wrapperEPv>
    8000f2f0:	00048513          	mv	a0,s1
    8000f2f4:	00000097          	auipc	ra,0x0
    8000f2f8:	e48080e7          	jalr	-440(ra) # 8000f13c <_ZN6ThreadC1EPFvPvES0_>
    8000f2fc:	00001797          	auipc	a5,0x1
    8000f300:	00c78793          	addi	a5,a5,12 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f304:	00f4b023          	sd	a5,0(s1)
    8000f308:	01813083          	ld	ra,24(sp)
    8000f30c:	01013403          	ld	s0,16(sp)
    8000f310:	00813483          	ld	s1,8(sp)
    8000f314:	00013903          	ld	s2,0(sp)
    8000f318:	02010113          	addi	sp,sp,32
    8000f31c:	00008067          	ret

000000008000f320 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    8000f320:	ff010113          	addi	sp,sp,-16
    8000f324:	00113423          	sd	ra,8(sp)
    8000f328:	00813023          	sd	s0,0(sp)
    8000f32c:	01010413          	addi	s0,sp,16
    return ::getc();
    8000f330:	ffffe097          	auipc	ra,0xffffe
    8000f334:	fd4080e7          	jalr	-44(ra) # 8000d304 <_Z4getcv>
}
    8000f338:	00813083          	ld	ra,8(sp)
    8000f33c:	00013403          	ld	s0,0(sp)
    8000f340:	01010113          	addi	sp,sp,16
    8000f344:	00008067          	ret

000000008000f348 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    8000f348:	ff010113          	addi	sp,sp,-16
    8000f34c:	00113423          	sd	ra,8(sp)
    8000f350:	00813023          	sd	s0,0(sp)
    8000f354:	01010413          	addi	s0,sp,16
    ::putc(c);
    8000f358:	ffffe097          	auipc	ra,0xffffe
    8000f35c:	fd4080e7          	jalr	-44(ra) # 8000d32c <_Z4putcc>
}
    8000f360:	00813083          	ld	ra,8(sp)
    8000f364:	00013403          	ld	s0,0(sp)
    8000f368:	01010113          	addi	sp,sp,16
    8000f36c:	00008067          	ret

000000008000f370 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    8000f370:	ff010113          	addi	sp,sp,-16
    8000f374:	00813423          	sd	s0,8(sp)
    8000f378:	01010413          	addi	s0,sp,16
    8000f37c:	00813403          	ld	s0,8(sp)
    8000f380:	01010113          	addi	sp,sp,16
    8000f384:	00008067          	ret

000000008000f388 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    8000f388:	ff010113          	addi	sp,sp,-16
    8000f38c:	00813423          	sd	s0,8(sp)
    8000f390:	01010413          	addi	s0,sp,16
    8000f394:	00813403          	ld	s0,8(sp)
    8000f398:	01010113          	addi	sp,sp,16
    8000f39c:	00008067          	ret

000000008000f3a0 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    8000f3a0:	ff010113          	addi	sp,sp,-16
    8000f3a4:	00113423          	sd	ra,8(sp)
    8000f3a8:	00813023          	sd	s0,0(sp)
    8000f3ac:	01010413          	addi	s0,sp,16
    8000f3b0:	00001797          	auipc	a5,0x1
    8000f3b4:	f5878793          	addi	a5,a5,-168 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f3b8:	00f53023          	sd	a5,0(a0)
    8000f3bc:	00000097          	auipc	ra,0x0
    8000f3c0:	bb8080e7          	jalr	-1096(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000f3c4:	00813083          	ld	ra,8(sp)
    8000f3c8:	00013403          	ld	s0,0(sp)
    8000f3cc:	01010113          	addi	sp,sp,16
    8000f3d0:	00008067          	ret

000000008000f3d4 <_ZN14PeriodicThreadD0Ev>:
    8000f3d4:	fe010113          	addi	sp,sp,-32
    8000f3d8:	00113c23          	sd	ra,24(sp)
    8000f3dc:	00813823          	sd	s0,16(sp)
    8000f3e0:	00913423          	sd	s1,8(sp)
    8000f3e4:	02010413          	addi	s0,sp,32
    8000f3e8:	00050493          	mv	s1,a0
    8000f3ec:	00001797          	auipc	a5,0x1
    8000f3f0:	f1c78793          	addi	a5,a5,-228 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f3f4:	00f53023          	sd	a5,0(a0)
    8000f3f8:	00000097          	auipc	ra,0x0
    8000f3fc:	b7c080e7          	jalr	-1156(ra) # 8000ef74 <_ZN6ThreadD1Ev>
    8000f400:	00048513          	mv	a0,s1
    8000f404:	00000097          	auipc	ra,0x0
    8000f408:	c00080e7          	jalr	-1024(ra) # 8000f004 <_ZdlPv>
    8000f40c:	01813083          	ld	ra,24(sp)
    8000f410:	01013403          	ld	s0,16(sp)
    8000f414:	00813483          	ld	s1,8(sp)
    8000f418:	02010113          	addi	sp,sp,32
    8000f41c:	00008067          	ret

000000008000f420 <_Z11bodyWrapperPFvPvES_>:
#include "../../h/user/user_wrappers.hpp"
#include "../../h/user/syscall_c.h"
#include "tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    8000f420:	ff010113          	addi	sp,sp,-16
    8000f424:	00113423          	sd	ra,8(sp)
    8000f428:	00813023          	sd	s0,0(sp)
    8000f42c:	01010413          	addi	s0,sp,16
    8000f430:	00050793          	mv	a5,a0
    body(args);
    8000f434:	00058513          	mv	a0,a1
    8000f438:	000780e7          	jalr	a5
    thread_exit();
    8000f43c:	ffffe097          	auipc	ra,0xffffe
    8000f440:	ccc080e7          	jalr	-820(ra) # 8000d108 <_Z11thread_exitv>
}
    8000f444:	00813083          	ld	ra,8(sp)
    8000f448:	00013403          	ld	s0,0(sp)
    8000f44c:	01010113          	addi	sp,sp,16
    8000f450:	00008067          	ret

000000008000f454 <_Z15userMainWrapperPv>:

void userMainWrapper(void* args) {
    8000f454:	ff010113          	addi	sp,sp,-16
    8000f458:	00113423          	sd	ra,8(sp)
    8000f45c:	00813023          	sd	s0,0(sp)
    8000f460:	01010413          	addi	s0,sp,16
    userMain();
    8000f464:	fffff097          	auipc	ra,0xfffff
    8000f468:	eb0080e7          	jalr	-336(ra) # 8000e314 <_Z8userMainv>
    8000f46c:	00813083          	ld	ra,8(sp)
    8000f470:	00013403          	ld	s0,0(sp)
    8000f474:	01010113          	addi	sp,sp,16
    8000f478:	00008067          	ret
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
    80010250:	e48c 8000 0000 0000 e4c0 8000 0000 0000     ................
    80010260:	e60c 8000 0000 0000                         ........

0000000080010268 <_ZTVN19ConsumerProducerCPP8ProducerE>:
	...
    80010278:	e50c 8000 0000 0000 e540 8000 0000 0000     ........@.......
    80010288:	e690 8000 0000 0000                         ........

0000000080010290 <_ZTVN19ConsumerProducerCPP8ConsumerE>:
	...
    800102a0:	e40c 8000 0000 0000 e440 8000 0000 0000     ........@.......
    800102b0:	e33c 8000 0000 0000                         <.......

00000000800102b8 <_ZTV10ForkThread>:
	...
    800102c8:	e58c 8000 0000 0000 e5c0 8000 0000 0000     ................
    800102d8:	e724 8000 0000 0000                         $.......

00000000800102e0 <digits>:
    800102e0:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...

00000000800102f8 <_ZTV14PeriodicThread>:
	...
    80010308:	f3a0 8000 0000 0000 f3d4 8000 0000 0000     ................
    80010318:	f370 8000 0000 0000 f388 8000 0000 0000     p...............

0000000080010328 <_ZTV9Semaphore>:
	...
    80010338:	ef3c 8000 0000 0000 f02c 8000 0000 0000     <.......,.......

0000000080010348 <_ZTV6Thread>:
	...
    80010358:	ef74 8000 0000 0000 f06c 8000 0000 0000     t.......l.......
    80010368:	f370 8000 0000 0000                         p.......

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
