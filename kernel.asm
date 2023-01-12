
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	fc013103          	ld	sp,-64(sp) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	3d4050ef          	jal	ra,800053f0 <start>

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
    80001088:	558020ef          	jal	ra,800035e0 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001238:	c7c78793          	addi	a5,a5,-900 # 8000aeb0 <_ZL11CACHE_NAMES>
    8000123c:	00e787b3          	add	a5,a5,a4
    80001240:	000c0b13          	mv	s6,s8
    80001244:	00000693          	li	a3,0
    80001248:	00000613          	li	a2,0
    8000124c:	000c0593          	mv	a1,s8
    80001250:	0007b503          	ld	a0,0(a5)
    80001254:	00003097          	auipc	ra,0x3
    80001258:	170080e7          	jalr	368(ra) # 800043c4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000125c:	00050a13          	mv	s4,a0

    struct objects_s *objs = (struct objects_s*)(kmalloc(sizeof(struct objects_s) * data.iterations));
    80001260:	f9842b83          	lw	s7,-104(s0)
    80001264:	004b9513          	slli	a0,s7,0x4
    80001268:	00003097          	auipc	ra,0x3
    8000126c:	254080e7          	jalr	596(ra) # 800044bc <_Z7kmallocm>
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
    80001290:	160080e7          	jalr	352(ra) # 800043ec <_Z16kmem_cache_allocP5Cache>
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
    800012d8:	118080e7          	jalr	280(ra) # 800043ec <_Z16kmem_cache_allocP5Cache>
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
    80001300:	71c080e7          	jalr	1820(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    80001304:	fa9ff06f          	j	800012ac <_Z4workPv+0xd0>
    }

    kmem_cache_info(cache);
    80001308:	000a0513          	mv	a0,s4
    8000130c:	00003097          	auipc	ra,0x3
    80001310:	160080e7          	jalr	352(ra) # 8000446c <_Z15kmem_cache_infoP5Cache>
    kmem_cache_info(data.shared);
    80001314:	f9043503          	ld	a0,-112(s0)
    80001318:	00003097          	auipc	ra,0x3
    8000131c:	154080e7          	jalr	340(ra) # 8000446c <_Z15kmem_cache_infoP5Cache>

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
    8000133c:	6e0080e7          	jalr	1760(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        }
        kmem_cache_free(objs[i].cache, objs[i].data);
    80001340:	0084b583          	ld	a1,8(s1)
    80001344:	0004b503          	ld	a0,0(s1)
    80001348:	00003097          	auipc	ra,0x3
    8000134c:	0cc080e7          	jalr	204(ra) # 80004414 <_Z15kmem_cache_freeP5CachePv>
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
    80001388:	160080e7          	jalr	352(ra) # 800044e4 <_Z5kfreePKv>
    kmem_cache_destroy(cache);
    8000138c:	000a0513          	mv	a0,s4
    80001390:	00003097          	auipc	ra,0x3
    80001394:	0ac080e7          	jalr	172(ra) # 8000443c <_Z18kmem_cache_destroyP5Cache>
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
    8000147c:	f4c080e7          	jalr	-180(ra) # 800043c4 <_Z17kmem_cache_createPKcmPFvPvES3_>
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
    800014b0:	f90080e7          	jalr	-112(ra) # 8000443c <_Z18kmem_cache_destroyP5Cache>
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
    800014fc:	b987c783          	lbu	a5,-1128(a5) # 8000b090 <_ZN6System11initializedE>
    80001500:	00078463          	beqz	a5,80001508 <_ZN6SystemC1Ev+0x10>
    80001504:	00008067          	ret
System::System() {
    80001508:	fc010113          	addi	sp,sp,-64
    8000150c:	02113c23          	sd	ra,56(sp)
    80001510:	02813823          	sd	s0,48(sp)
    80001514:	02913423          	sd	s1,40(sp)
    80001518:	03213023          	sd	s2,32(sp)
    8000151c:	01313c23          	sd	s3,24(sp)
    80001520:	01413823          	sd	s4,16(sp)
    80001524:	04010413          	addi	s0,sp,64
        initialized = true;
    80001528:	00100793          	li	a5,1
    8000152c:	0000a717          	auipc	a4,0xa
    80001530:	b6f70223          	sb	a5,-1180(a4) # 8000b090 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    80001534:	00003097          	auipc	ra,0x3
    80001538:	b04080e7          	jalr	-1276(ra) # 80004038 <_ZN5RiscV10initializeEv>

        Cache *tmp1 = kmem_cache_create("TMP1", 2048, nullptr, nullptr);
    8000153c:	00000693          	li	a3,0
    80001540:	00000613          	li	a2,0
    80001544:	000015b7          	lui	a1,0x1
    80001548:	80058593          	addi	a1,a1,-2048 # 800 <_entry-0x7ffff800>
    8000154c:	00007517          	auipc	a0,0x7
    80001550:	afc50513          	addi	a0,a0,-1284 # 80008048 <CONSOLE_STATUS+0x38>
    80001554:	00003097          	auipc	ra,0x3
    80001558:	e70080e7          	jalr	-400(ra) # 800043c4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000155c:	00050493          	mv	s1,a0
//        Cache *tmp2 = kmem_cache_create("TMP2", 2048, nullptr, nullptr);
        void* ret1 = kmem_cache_alloc(tmp1);
    80001560:	00003097          	auipc	ra,0x3
    80001564:	e8c080e7          	jalr	-372(ra) # 800043ec <_Z16kmem_cache_allocP5Cache>
    80001568:	00050913          	mv	s2,a0
        void* ret2 = kmem_cache_alloc(tmp1);
    8000156c:	00048513          	mv	a0,s1
    80001570:	00003097          	auipc	ra,0x3
    80001574:	e7c080e7          	jalr	-388(ra) # 800043ec <_Z16kmem_cache_allocP5Cache>
    80001578:	00050993          	mv	s3,a0
        void* ret3 = kmem_cache_alloc(tmp1);
    8000157c:	00048513          	mv	a0,s1
    80001580:	00003097          	auipc	ra,0x3
    80001584:	e6c080e7          	jalr	-404(ra) # 800043ec <_Z16kmem_cache_allocP5Cache>
    80001588:	00050a13          	mv	s4,a0
        if(ret1 && ret2 && ret3){
    8000158c:	06090c63          	beqz	s2,80001604 <_ZN6SystemC1Ev+0x10c>
    80001590:	06098a63          	beqz	s3,80001604 <_ZN6SystemC1Ev+0x10c>
    80001594:	06050863          	beqz	a0,80001604 <_ZN6SystemC1Ev+0x10c>
            SlabAllocator::printSlab(tmp1->partialHead);
    80001598:	0704b503          	ld	a0,112(s1)
    8000159c:	00003097          	auipc	ra,0x3
    800015a0:	000080e7          	jalr	ra # 8000459c <_ZN13SlabAllocator9printSlabEP4Slab>
            kmem_cache_free(tmp1, ret3);
    800015a4:	000a0593          	mv	a1,s4
    800015a8:	00048513          	mv	a0,s1
    800015ac:	00003097          	auipc	ra,0x3
    800015b0:	e68080e7          	jalr	-408(ra) # 80004414 <_Z15kmem_cache_freeP5CachePv>
            SlabAllocator::printSlab(tmp1->partialHead);
    800015b4:	0704b503          	ld	a0,112(s1)
    800015b8:	00003097          	auipc	ra,0x3
    800015bc:	fe4080e7          	jalr	-28(ra) # 8000459c <_ZN13SlabAllocator9printSlabEP4Slab>
            kmem_cache_free(tmp1, ret2);
    800015c0:	00098593          	mv	a1,s3
    800015c4:	00048513          	mv	a0,s1
    800015c8:	00003097          	auipc	ra,0x3
    800015cc:	e4c080e7          	jalr	-436(ra) # 80004414 <_Z15kmem_cache_freeP5CachePv>
            kmem_cache_free(tmp1, ret1);
    800015d0:	00090593          	mv	a1,s2
    800015d4:	00048513          	mv	a0,s1
    800015d8:	00003097          	auipc	ra,0x3
    800015dc:	e3c080e7          	jalr	-452(ra) # 80004414 <_Z15kmem_cache_freeP5CachePv>
            kmem_cache_info(tmp1);
    800015e0:	00048513          	mv	a0,s1
    800015e4:	00003097          	auipc	ra,0x3
    800015e8:	e88080e7          	jalr	-376(ra) # 8000446c <_Z15kmem_cache_infoP5Cache>
            kmem_cache_alloc(tmp1);
    800015ec:	00048513          	mv	a0,s1
    800015f0:	00003097          	auipc	ra,0x3
    800015f4:	dfc080e7          	jalr	-516(ra) # 800043ec <_Z16kmem_cache_allocP5Cache>
            SlabAllocator::printSlab(tmp1->partialHead);
    800015f8:	0704b503          	ld	a0,112(s1)
    800015fc:	00003097          	auipc	ra,0x3
    80001600:	fa0080e7          	jalr	-96(ra) # 8000459c <_ZN13SlabAllocator9printSlabEP4Slab>
        }

        test2();
    80001604:	00000097          	auipc	ra,0x0
    80001608:	e48080e7          	jalr	-440(ra) # 8000144c <_Z5test2v>
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), userMainWrapper, nullptr);
    8000160c:	00000613          	li	a2,0
    80001610:	0000a597          	auipc	a1,0xa
    80001614:	9b85b583          	ld	a1,-1608(a1) # 8000afc8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001618:	fc840513          	addi	a0,s0,-56
    8000161c:	00002097          	auipc	ra,0x2
    80001620:	424080e7          	jalr	1060(ra) # 80003a40 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001624:	fc843783          	ld	a5,-56(s0)
    80001628:	0107a703          	lw	a4,16(a5)
    8000162c:	00200793          	li	a5,2
    80001630:	00f70863          	beq	a4,a5,80001640 <_ZN6SystemC1Ev+0x148>
            RiscV::threadDispatchUtil();
    80001634:	00002097          	auipc	ra,0x2
    80001638:	4a8080e7          	jalr	1192(ra) # 80003adc <_ZN5RiscV18threadDispatchUtilEv>
    8000163c:	fe9ff06f          	j	80001624 <_ZN6SystemC1Ev+0x12c>
        }

        //finalize the machine
        RiscV::finalize();
    80001640:	00001097          	auipc	ra,0x1
    80001644:	6b4080e7          	jalr	1716(ra) # 80002cf4 <_ZN5RiscV8finalizeEv>
    }
    80001648:	03813083          	ld	ra,56(sp)
    8000164c:	03013403          	ld	s0,48(sp)
    80001650:	02813483          	ld	s1,40(sp)
    80001654:	02013903          	ld	s2,32(sp)
    80001658:	01813983          	ld	s3,24(sp)
    8000165c:	01013a03          	ld	s4,16(sp)
    80001660:	04010113          	addi	sp,sp,64
    80001664:	00008067          	ret

0000000080001668 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80001668:	ff010113          	addi	sp,sp,-16
    8000166c:	00813423          	sd	s0,8(sp)
    80001670:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80001674:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80001678:	00053823          	sd	zero,16(a0)
}
    8000167c:	00813403          	ld	s0,8(sp)
    80001680:	01010113          	addi	sp,sp,16
    80001684:	00008067          	ret

0000000080001688 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80001688:	ff010113          	addi	sp,sp,-16
    8000168c:	00813423          	sd	s0,8(sp)
    80001690:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80001694:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80001698:	00053823          	sd	zero,16(a0)
    8000169c:	00813403          	ld	s0,8(sp)
    800016a0:	01010113          	addi	sp,sp,16
    800016a4:	00008067          	ret

00000000800016a8 <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    800016a8:	ff010113          	addi	sp,sp,-16
    800016ac:	00113423          	sd	ra,8(sp)
    800016b0:	00813023          	sd	s0,0(sp)
    800016b4:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    800016b8:	00000697          	auipc	a3,0x0
    800016bc:	fd068693          	addi	a3,a3,-48 # 80001688 <_ZN3SCB4dtorEPv>
    800016c0:	00000617          	auipc	a2,0x0
    800016c4:	fa860613          	addi	a2,a2,-88 # 80001668 <_ZN3SCB4ctorEPv>
    800016c8:	01800593          	li	a1,24
    800016cc:	00007517          	auipc	a0,0x7
    800016d0:	9ac50513          	addi	a0,a0,-1620 # 80008078 <CONSOLE_STATUS+0x68>
    800016d4:	00003097          	auipc	ra,0x3
    800016d8:	cf0080e7          	jalr	-784(ra) # 800043c4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800016dc:	0000a797          	auipc	a5,0xa
    800016e0:	9aa7be23          	sd	a0,-1604(a5) # 8000b098 <_ZN3SCB8scbCacheE>
}
    800016e4:	00813083          	ld	ra,8(sp)
    800016e8:	00013403          	ld	s0,0(sp)
    800016ec:	01010113          	addi	sp,sp,16
    800016f0:	00008067          	ret

00000000800016f4 <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    800016f4:	ff010113          	addi	sp,sp,-16
    800016f8:	00813423          	sd	s0,8(sp)
    800016fc:	01010413          	addi	s0,sp,16
    val = init;
    80001700:	00b52023          	sw	a1,0(a0)
}
    80001704:	00813403          	ld	s0,8(sp)
    80001708:	01010113          	addi	sp,sp,16
    8000170c:	00008067          	ret

0000000080001710 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80001710:	fe010113          	addi	sp,sp,-32
    80001714:	00113c23          	sd	ra,24(sp)
    80001718:	00813823          	sd	s0,16(sp)
    8000171c:	00913423          	sd	s1,8(sp)
    80001720:	01213023          	sd	s2,0(sp)
    80001724:	02010413          	addi	s0,sp,32
    80001728:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    8000172c:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80001730:	02050063          	beqz	a0,80001750 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80001734:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80001738:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    8000173c:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80001740:	00003097          	auipc	ra,0x3
    80001744:	a60080e7          	jalr	-1440(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80001748:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    8000174c:	fe5ff06f          	j	80001730 <_ZN3SCBD1Ev+0x20>
}
    80001750:	01813083          	ld	ra,24(sp)
    80001754:	01013403          	ld	s0,16(sp)
    80001758:	00813483          	ld	s1,8(sp)
    8000175c:	00013903          	ld	s2,0(sp)
    80001760:	02010113          	addi	sp,sp,32
    80001764:	00008067          	ret

0000000080001768 <_ZN3SCB5blockEv>:
void SCB::block() {
    80001768:	ff010113          	addi	sp,sp,-16
    8000176c:	00113423          	sd	ra,8(sp)
    80001770:	00813023          	sd	s0,0(sp)
    80001774:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80001778:	00853783          	ld	a5,8(a0)
    8000177c:	04078063          	beqz	a5,800017bc <_ZN3SCB5blockEv+0x54>
    80001780:	01053703          	ld	a4,16(a0)
    80001784:	0000a797          	auipc	a5,0xa
    80001788:	88c7b783          	ld	a5,-1908(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000178c:	0007b783          	ld	a5,0(a5)
    80001790:	04f73423          	sd	a5,72(a4)
    80001794:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80001798:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    8000179c:	00300713          	li	a4,3
    800017a0:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800017a4:	00001097          	auipc	ra,0x1
    800017a8:	8e8080e7          	jalr	-1816(ra) # 8000208c <_ZN3TCB8dispatchEv>
}
    800017ac:	00813083          	ld	ra,8(sp)
    800017b0:	00013403          	ld	s0,0(sp)
    800017b4:	01010113          	addi	sp,sp,16
    800017b8:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800017bc:	0000a797          	auipc	a5,0xa
    800017c0:	8547b783          	ld	a5,-1964(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800017c4:	0007b783          	ld	a5,0(a5)
    800017c8:	00f53423          	sd	a5,8(a0)
    800017cc:	fc9ff06f          	j	80001794 <_ZN3SCB5blockEv+0x2c>

00000000800017d0 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    800017d0:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    800017d4:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    800017d8:	04853703          	ld	a4,72(a0)
    800017dc:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    800017e0:	04053423          	sd	zero,72(a0)
    if(tcb) {
    800017e4:	02050a63          	beqz	a0,80001818 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    800017e8:	ff010113          	addi	sp,sp,-16
    800017ec:	00113423          	sd	ra,8(sp)
    800017f0:	00813023          	sd	s0,0(sp)
    800017f4:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    800017f8:	00100793          	li	a5,1
    800017fc:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80001800:	00003097          	auipc	ra,0x3
    80001804:	9a0080e7          	jalr	-1632(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>
}
    80001808:	00813083          	ld	ra,8(sp)
    8000180c:	00013403          	ld	s0,0(sp)
    80001810:	01010113          	addi	sp,sp,16
    80001814:	00008067          	ret
    80001818:	00008067          	ret

000000008000181c <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    8000181c:	00009797          	auipc	a5,0x9
    80001820:	7f47b783          	ld	a5,2036(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80001824:	0007b783          	ld	a5,0(a5)
    80001828:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    8000182c:	00052783          	lw	a5,0(a0)
    80001830:	fff7879b          	addiw	a5,a5,-1
    80001834:	00f52023          	sw	a5,0(a0)
    80001838:	02079713          	slli	a4,a5,0x20
    8000183c:	00074463          	bltz	a4,80001844 <_ZN3SCB4waitEv+0x28>
    80001840:	00008067          	ret
void SCB::wait() {
    80001844:	ff010113          	addi	sp,sp,-16
    80001848:	00113423          	sd	ra,8(sp)
    8000184c:	00813023          	sd	s0,0(sp)
    80001850:	01010413          	addi	s0,sp,16
        block();
    80001854:	00000097          	auipc	ra,0x0
    80001858:	f14080e7          	jalr	-236(ra) # 80001768 <_ZN3SCB5blockEv>
}
    8000185c:	00813083          	ld	ra,8(sp)
    80001860:	00013403          	ld	s0,0(sp)
    80001864:	01010113          	addi	sp,sp,16
    80001868:	00008067          	ret

000000008000186c <_ZN3SCB6signalEv>:
    if(val++<0)
    8000186c:	00052783          	lw	a5,0(a0)
    80001870:	0017871b          	addiw	a4,a5,1
    80001874:	00e52023          	sw	a4,0(a0)
    80001878:	0007c463          	bltz	a5,80001880 <_ZN3SCB6signalEv+0x14>
    8000187c:	00008067          	ret
void SCB::signal(){
    80001880:	ff010113          	addi	sp,sp,-16
    80001884:	00113423          	sd	ra,8(sp)
    80001888:	00813023          	sd	s0,0(sp)
    8000188c:	01010413          	addi	s0,sp,16
        deblock();
    80001890:	00000097          	auipc	ra,0x0
    80001894:	f40080e7          	jalr	-192(ra) # 800017d0 <_ZN3SCB7deblockEv>
}
    80001898:	00813083          	ld	ra,8(sp)
    8000189c:	00013403          	ld	s0,0(sp)
    800018a0:	01010113          	addi	sp,sp,16
    800018a4:	00008067          	ret

00000000800018a8 <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    800018a8:	ff010113          	addi	sp,sp,-16
    800018ac:	00113423          	sd	ra,8(sp)
    800018b0:	00813023          	sd	s0,0(sp)
    800018b4:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    800018b8:	00009517          	auipc	a0,0x9
    800018bc:	7e053503          	ld	a0,2016(a0) # 8000b098 <_ZN3SCB8scbCacheE>
    800018c0:	00003097          	auipc	ra,0x3
    800018c4:	b2c080e7          	jalr	-1236(ra) # 800043ec <_Z16kmem_cache_allocP5Cache>
}
    800018c8:	00813083          	ld	ra,8(sp)
    800018cc:	00013403          	ld	s0,0(sp)
    800018d0:	01010113          	addi	sp,sp,16
    800018d4:	00008067          	ret

00000000800018d8 <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    800018d8:	ff010113          	addi	sp,sp,-16
    800018dc:	00113423          	sd	ra,8(sp)
    800018e0:	00813023          	sd	s0,0(sp)
    800018e4:	01010413          	addi	s0,sp,16
    800018e8:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    800018ec:	00009517          	auipc	a0,0x9
    800018f0:	7ac53503          	ld	a0,1964(a0) # 8000b098 <_ZN3SCB8scbCacheE>
    800018f4:	00003097          	auipc	ra,0x3
    800018f8:	b20080e7          	jalr	-1248(ra) # 80004414 <_Z15kmem_cache_freeP5CachePv>
}
    800018fc:	00813083          	ld	ra,8(sp)
    80001900:	00013403          	ld	s0,0(sp)
    80001904:	01010113          	addi	sp,sp,16
    80001908:	00008067          	ret

000000008000190c <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    8000190c:	ff010113          	addi	sp,sp,-16
    80001910:	00813423          	sd	s0,8(sp)
    80001914:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001918:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    8000191c:	05200513          	li	a0,82
    asm("ecall");
    80001920:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80001924:	00050513          	mv	a0,a0
}
    80001928:	0005051b          	sext.w	a0,a0
    8000192c:	00813403          	ld	s0,8(sp)
    80001930:	01010113          	addi	sp,sp,16
    80001934:	00008067          	ret

0000000080001938 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80001938:	ff010113          	addi	sp,sp,-16
    8000193c:	00813423          	sd	s0,8(sp)
    80001940:	01010413          	addi	s0,sp,16
    80001944:	00100793          	li	a5,1
    80001948:	00f50863          	beq	a0,a5,80001958 <_Z41__static_initialization_and_destruction_0ii+0x20>
    8000194c:	00813403          	ld	s0,8(sp)
    80001950:	01010113          	addi	sp,sp,16
    80001954:	00008067          	ret
    80001958:	000107b7          	lui	a5,0x10
    8000195c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001960:	fef596e3          	bne	a1,a5,8000194c <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80001964:	00009797          	auipc	a5,0x9
    80001968:	60c7b783          	ld	a5,1548(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000196c:	0007b703          	ld	a4,0(a5)
    80001970:	00c75793          	srli	a5,a4,0xc
    80001974:	00278793          	addi	a5,a5,2
    80001978:	00c79793          	slli	a5,a5,0xc
    8000197c:	00009697          	auipc	a3,0x9
    80001980:	72468693          	addi	a3,a3,1828 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001984:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001988:	fffff7b7          	lui	a5,0xfffff
    8000198c:	00f77733          	and	a4,a4,a5
    80001990:	00e6b423          	sd	a4,8(a3)
    80001994:	fb9ff06f          	j	8000194c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001998 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80001998:	ff010113          	addi	sp,sp,-16
    8000199c:	00813423          	sd	s0,8(sp)
    800019a0:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    800019a4:	00009717          	auipc	a4,0x9
    800019a8:	6fc70713          	addi	a4,a4,1788 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800019ac:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800019b0:	00009797          	auipc	a5,0x9
    800019b4:	5c07b783          	ld	a5,1472(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x18>
    800019b8:	0007b783          	ld	a5,0(a5)
    800019bc:	fffff6b7          	lui	a3,0xfffff
    800019c0:	00d7f7b3          	and	a5,a5,a3
    800019c4:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    800019c8:	00009797          	auipc	a5,0x9
    800019cc:	50b7bc23          	sd	a1,1304(a5) # 8000aee0 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    800019d0:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800019d4:	00000713          	li	a4,0
        while(num>1){
    800019d8:	00100693          	li	a3,1
    800019dc:	00f6f863          	bgeu	a3,a5,800019ec <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    800019e0:	0017d793          	srli	a5,a5,0x1
            deg++;
    800019e4:	00170713          	addi	a4,a4,1
        while(num>1){
    800019e8:	ff1ff06f          	j	800019d8 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    800019ec:	00371713          	slli	a4,a4,0x3
    800019f0:	00009797          	auipc	a5,0x9
    800019f4:	6b078793          	addi	a5,a5,1712 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800019f8:	00e78733          	add	a4,a5,a4
    800019fc:	00a73823          	sd	a0,16(a4)
    80001a00:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001a04:	00000713          	li	a4,0
        while(num>1){
    80001a08:	00100693          	li	a3,1
    80001a0c:	00f6f863          	bgeu	a3,a5,80001a1c <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80001a10:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001a14:	00170713          	addi	a4,a4,1
        while(num>1){
    80001a18:	ff1ff06f          	j	80001a08 <_ZN5Buddy10initializeEPvm+0x70>
    80001a1c:	00371713          	slli	a4,a4,0x3
    80001a20:	00009797          	auipc	a5,0x9
    80001a24:	68078793          	addi	a5,a5,1664 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001a28:	00e78733          	add	a4,a5,a4
    80001a2c:	06a73c23          	sd	a0,120(a4)
    80001a30:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001a34:	00000713          	li	a4,0
        while(num>1){
    80001a38:	00100693          	li	a3,1
    80001a3c:	00f6f863          	bgeu	a3,a5,80001a4c <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80001a40:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001a44:	00170713          	addi	a4,a4,1
        while(num>1){
    80001a48:	ff1ff06f          	j	80001a38 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80001a4c:	00371713          	slli	a4,a4,0x3
    80001a50:	00009797          	auipc	a5,0x9
    80001a54:	65078793          	addi	a5,a5,1616 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001a58:	00e78733          	add	a4,a5,a4
    80001a5c:	01073783          	ld	a5,16(a4)
    80001a60:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80001a64:	00000793          	li	a5,0
    80001a68:	00c0006f          	j	80001a74 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80001a6c:	0015d593          	srli	a1,a1,0x1
            deg++;
    80001a70:	00178793          	addi	a5,a5,1
        while(num>1){
    80001a74:	00100713          	li	a4,1
    80001a78:	feb76ae3          	bltu	a4,a1,80001a6c <_ZN5Buddy10initializeEPvm+0xd4>
    80001a7c:	00379793          	slli	a5,a5,0x3
    80001a80:	00009717          	auipc	a4,0x9
    80001a84:	62070713          	addi	a4,a4,1568 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001a88:	00f707b3          	add	a5,a4,a5
    80001a8c:	0787b783          	ld	a5,120(a5)
    80001a90:	0007b023          	sd	zero,0(a5)
}
    80001a94:	00813403          	ld	s0,8(sp)
    80001a98:	01010113          	addi	sp,sp,16
    80001a9c:	00008067          	ret

0000000080001aa0 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001aa0:	00c00793          	li	a5,12
    80001aa4:	10f50063          	beq	a0,a5,80001ba4 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80001aa8:	fd010113          	addi	sp,sp,-48
    80001aac:	02113423          	sd	ra,40(sp)
    80001ab0:	02813023          	sd	s0,32(sp)
    80001ab4:	00913c23          	sd	s1,24(sp)
    80001ab8:	01213823          	sd	s2,16(sp)
    80001abc:	01313423          	sd	s3,8(sp)
    80001ac0:	03010413          	addi	s0,sp,48
    80001ac4:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80001ac8:	00351713          	slli	a4,a0,0x3
    80001acc:	00009797          	auipc	a5,0x9
    80001ad0:	5d478793          	addi	a5,a5,1492 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ad4:	00e787b3          	add	a5,a5,a4
    80001ad8:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80001adc:	00000993          	li	s3,0
    80001ae0:	0180006f          	j	80001af8 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80001ae4:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80001ae8:	04f70463          	beq	a4,a5,80001b30 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80001aec:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80001af0:	08f70063          	beq	a4,a5,80001b70 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80001af4:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80001af8:	08048863          	beqz	s1,80001b88 <_ZN5Buddy8compressEm+0xe8>
    80001afc:	0004b683          	ld	a3,0(s1)
    80001b00:	08068463          	beqz	a3,80001b88 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80001b04:	00009797          	auipc	a5,0x9
    80001b08:	59c7b783          	ld	a5,1436(a5) # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b0c:	40f48733          	sub	a4,s1,a5
    80001b10:	00c9061b          	addiw	a2,s2,12
    80001b14:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80001b18:	40f687b3          	sub	a5,a3,a5
    80001b1c:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80001b20:	00177613          	andi	a2,a4,1
    80001b24:	fc0610e3          	bnez	a2,80001ae4 <_ZN5Buddy8compressEm+0x44>
    80001b28:	00170713          	addi	a4,a4,1
    80001b2c:	fbdff06f          	j	80001ae8 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80001b30:	00098863          	beqz	s3,80001b40 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    80001b34:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffee000>
    80001b38:	00d9b023          	sd	a3,0(s3)
    80001b3c:	fb5ff06f          	j	80001af0 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80001b40:	0006b603          	ld	a2,0(a3)
    80001b44:	00391593          	slli	a1,s2,0x3
    80001b48:	00009697          	auipc	a3,0x9
    80001b4c:	55868693          	addi	a3,a3,1368 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b50:	00b686b3          	add	a3,a3,a1
    80001b54:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    80001b58:	f8061ce3          	bnez	a2,80001af0 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    80001b5c:	00009697          	auipc	a3,0x9
    80001b60:	54468693          	addi	a3,a3,1348 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b64:	00b686b3          	add	a3,a3,a1
    80001b68:	0006b823          	sd	zero,16(a3)
    80001b6c:	f85ff06f          	j	80001af0 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80001b70:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80001b74:	00190593          	addi	a1,s2,1
    80001b78:	00048513          	mv	a0,s1
    80001b7c:	00000097          	auipc	ra,0x0
    80001b80:	02c080e7          	jalr	44(ra) # 80001ba8 <_ZN5Buddy6insertEPvm>
    80001b84:	f71ff06f          	j	80001af4 <_ZN5Buddy8compressEm+0x54>
}
    80001b88:	02813083          	ld	ra,40(sp)
    80001b8c:	02013403          	ld	s0,32(sp)
    80001b90:	01813483          	ld	s1,24(sp)
    80001b94:	01013903          	ld	s2,16(sp)
    80001b98:	00813983          	ld	s3,8(sp)
    80001b9c:	03010113          	addi	sp,sp,48
    80001ba0:	00008067          	ret
    80001ba4:	00008067          	ret

0000000080001ba8 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80001ba8:	00050693          	mv	a3,a0
    if(!head[size]){
    80001bac:	00359713          	slli	a4,a1,0x3
    80001bb0:	00009797          	auipc	a5,0x9
    80001bb4:	4f078793          	addi	a5,a5,1264 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001bb8:	00e787b3          	add	a5,a5,a4
    80001bbc:	0787b783          	ld	a5,120(a5)
    80001bc0:	02078c63          	beqz	a5,80001bf8 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80001bc4:	ff010113          	addi	sp,sp,-16
    80001bc8:	00113423          	sd	ra,8(sp)
    80001bcc:	00813023          	sd	s0,0(sp)
    80001bd0:	01010413          	addi	s0,sp,16
    80001bd4:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80001bd8:	00068713          	mv	a4,a3
    80001bdc:	04f6e063          	bltu	a3,a5,80001c1c <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80001be0:	00000613          	li	a2,0
            while (iter != nullptr) {
    80001be4:	06078863          	beqz	a5,80001c54 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80001be8:	04f76c63          	bltu	a4,a5,80001c40 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80001bec:	00078613          	mv	a2,a5
                    iter = iter->next;
    80001bf0:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80001bf4:	ff1ff06f          	j	80001be4 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80001bf8:	00009797          	auipc	a5,0x9
    80001bfc:	4a878793          	addi	a5,a5,1192 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c00:	00e78533          	add	a0,a5,a4
    80001c04:	00d53823          	sd	a3,16(a0)
    80001c08:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80001c0c:	0006b023          	sd	zero,0(a3)
    80001c10:	07853783          	ld	a5,120(a0)
    80001c14:	0007b023          	sd	zero,0(a5)
        return;
    80001c18:	00008067          	ret
            newHead->next = head[size];
    80001c1c:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80001c20:	00359713          	slli	a4,a1,0x3
    80001c24:	00009797          	auipc	a5,0x9
    80001c28:	47c78793          	addi	a5,a5,1148 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c2c:	00e787b3          	add	a5,a5,a4
    80001c30:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80001c34:	00000097          	auipc	ra,0x0
    80001c38:	e6c080e7          	jalr	-404(ra) # 80001aa0 <_ZN5Buddy8compressEm>
            return;
    80001c3c:	0440006f          	j	80001c80 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    80001c40:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80001c44:	00d63023          	sd	a3,0(a2)
                    compress(size);
    80001c48:	00000097          	auipc	ra,0x0
    80001c4c:	e58080e7          	jalr	-424(ra) # 80001aa0 <_ZN5Buddy8compressEm>
                    return;
    80001c50:	0300006f          	j	80001c80 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    80001c54:	00351713          	slli	a4,a0,0x3
    80001c58:	00009797          	auipc	a5,0x9
    80001c5c:	44878793          	addi	a5,a5,1096 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c60:	00e787b3          	add	a5,a5,a4
    80001c64:	0107b703          	ld	a4,16(a5)
    80001c68:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80001c6c:	0107b703          	ld	a4,16(a5)
    80001c70:	00073703          	ld	a4,0(a4)
    80001c74:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	e28080e7          	jalr	-472(ra) # 80001aa0 <_ZN5Buddy8compressEm>
}
    80001c80:	00813083          	ld	ra,8(sp)
    80001c84:	00013403          	ld	s0,0(sp)
    80001c88:	01010113          	addi	sp,sp,16
    80001c8c:	00008067          	ret

0000000080001c90 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80001c90:	02050663          	beqz	a0,80001cbc <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80001c94:	ff010113          	addi	sp,sp,-16
    80001c98:	00113423          	sd	ra,8(sp)
    80001c9c:	00813023          	sd	s0,0(sp)
    80001ca0:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80001ca4:	00000097          	auipc	ra,0x0
    80001ca8:	f04080e7          	jalr	-252(ra) # 80001ba8 <_ZN5Buddy6insertEPvm>
}
    80001cac:	00813083          	ld	ra,8(sp)
    80001cb0:	00013403          	ld	s0,0(sp)
    80001cb4:	01010113          	addi	sp,sp,16
    80001cb8:	00008067          	ret
    80001cbc:	00008067          	ret

0000000080001cc0 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001cc0:	ff010113          	addi	sp,sp,-16
    80001cc4:	00813423          	sd	s0,8(sp)
    80001cc8:	01010413          	addi	s0,sp,16
    80001ccc:	03c0006f          	j	80001d08 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001cd0:	00b5859b          	addiw	a1,a1,11
    80001cd4:	00100713          	li	a4,1
    80001cd8:	00b715bb          	sllw	a1,a4,a1
    80001cdc:	00b505b3          	add	a1,a0,a1
    80001ce0:	00379693          	slli	a3,a5,0x3
    80001ce4:	00009717          	auipc	a4,0x9
    80001ce8:	3bc70713          	addi	a4,a4,956 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001cec:	00d70733          	add	a4,a4,a3
    80001cf0:	00b73823          	sd	a1,16(a4)
    80001cf4:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80001cf8:	0005b023          	sd	zero,0(a1)
    80001cfc:	07873703          	ld	a4,120(a4)
    80001d00:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001d04:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80001d08:	fff5879b          	addiw	a5,a1,-1
    80001d0c:	04c7c863          	blt	a5,a2,80001d5c <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80001d10:	00379693          	slli	a3,a5,0x3
    80001d14:	00009717          	auipc	a4,0x9
    80001d18:	38c70713          	addi	a4,a4,908 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d1c:	00d70733          	add	a4,a4,a3
    80001d20:	01073683          	ld	a3,16(a4)
    80001d24:	fa0686e3          	beqz	a3,80001cd0 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001d28:	00b5859b          	addiw	a1,a1,11
    80001d2c:	00100713          	li	a4,1
    80001d30:	00b715bb          	sllw	a1,a4,a1
    80001d34:	00b505b3          	add	a1,a0,a1
    80001d38:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80001d3c:	00379693          	slli	a3,a5,0x3
    80001d40:	00009717          	auipc	a4,0x9
    80001d44:	36070713          	addi	a4,a4,864 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d48:	00d70733          	add	a4,a4,a3
    80001d4c:	01073683          	ld	a3,16(a4)
    80001d50:	0006b683          	ld	a3,0(a3)
    80001d54:	00d73823          	sd	a3,16(a4)
    80001d58:	fadff06f          	j	80001d04 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80001d5c:	00813403          	ld	s0,8(sp)
    80001d60:	01010113          	addi	sp,sp,16
    80001d64:	00008067          	ret

0000000080001d68 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80001d68:	fe010113          	addi	sp,sp,-32
    80001d6c:	00113c23          	sd	ra,24(sp)
    80001d70:	00813823          	sd	s0,16(sp)
    80001d74:	00913423          	sd	s1,8(sp)
    80001d78:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80001d7c:	00c00793          	li	a5,12
    80001d80:	06a7ec63          	bltu	a5,a0,80001df8 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001d84:	00050593          	mv	a1,a0
    80001d88:	00c00793          	li	a5,12
    80001d8c:	06b7ea63          	bltu	a5,a1,80001e00 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80001d90:	00359713          	slli	a4,a1,0x3
    80001d94:	00009797          	auipc	a5,0x9
    80001d98:	30c78793          	addi	a5,a5,780 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d9c:	00e787b3          	add	a5,a5,a4
    80001da0:	0787b483          	ld	s1,120(a5)
    80001da4:	00049663          	bnez	s1,80001db0 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001da8:	00158593          	addi	a1,a1,1
    80001dac:	fddff06f          	j	80001d88 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80001db0:	0004b703          	ld	a4,0(s1)
    80001db4:	00359693          	slli	a3,a1,0x3
    80001db8:	00009797          	auipc	a5,0x9
    80001dbc:	2e878793          	addi	a5,a5,744 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001dc0:	00d787b3          	add	a5,a5,a3
    80001dc4:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80001dc8:	00070e63          	beqz	a4,80001de4 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80001dcc:	0005061b          	sext.w	a2,a0
    80001dd0:	0005859b          	sext.w	a1,a1
    80001dd4:	00048513          	mv	a0,s1
    80001dd8:	00000097          	auipc	ra,0x0
    80001ddc:	ee8080e7          	jalr	-280(ra) # 80001cc0 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80001de0:	0240006f          	j	80001e04 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80001de4:	00009797          	auipc	a5,0x9
    80001de8:	2bc78793          	addi	a5,a5,700 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001dec:	00d787b3          	add	a5,a5,a3
    80001df0:	0007b823          	sd	zero,16(a5)
    80001df4:	fd9ff06f          	j	80001dcc <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80001df8:	00000493          	li	s1,0
    80001dfc:	0080006f          	j	80001e04 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80001e00:	00000493          	li	s1,0
}
    80001e04:	00048513          	mv	a0,s1
    80001e08:	01813083          	ld	ra,24(sp)
    80001e0c:	01013403          	ld	s0,16(sp)
    80001e10:	00813483          	ld	s1,8(sp)
    80001e14:	02010113          	addi	sp,sp,32
    80001e18:	00008067          	ret

0000000080001e1c <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80001e1c:	fe010113          	addi	sp,sp,-32
    80001e20:	00113c23          	sd	ra,24(sp)
    80001e24:	00813823          	sd	s0,16(sp)
    80001e28:	00913423          	sd	s1,8(sp)
    80001e2c:	01213023          	sd	s2,0(sp)
    80001e30:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80001e34:	00000913          	li	s2,0
    80001e38:	0180006f          	j	80001e50 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80001e3c:	00006517          	auipc	a0,0x6
    80001e40:	2e450513          	addi	a0,a0,740 # 80008120 <CONSOLE_STATUS+0x110>
    80001e44:	00001097          	auipc	ra,0x1
    80001e48:	bd4080e7          	jalr	-1068(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001e4c:	0019091b          	addiw	s2,s2,1
    80001e50:	00c00793          	li	a5,12
    80001e54:	0727c663          	blt	a5,s2,80001ec0 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80001e58:	00000613          	li	a2,0
    80001e5c:	00a00593          	li	a1,10
    80001e60:	00090513          	mv	a0,s2
    80001e64:	00001097          	auipc	ra,0x1
    80001e68:	bf8080e7          	jalr	-1032(ra) # 80002a5c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80001e6c:	00006517          	auipc	a0,0x6
    80001e70:	21c50513          	addi	a0,a0,540 # 80008088 <CONSOLE_STATUS+0x78>
    80001e74:	00001097          	auipc	ra,0x1
    80001e78:	ba4080e7          	jalr	-1116(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80001e7c:	00391713          	slli	a4,s2,0x3
    80001e80:	00009797          	auipc	a5,0x9
    80001e84:	22078793          	addi	a5,a5,544 # 8000b0a0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001e88:	00e787b3          	add	a5,a5,a4
    80001e8c:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80001e90:	fa0486e3          	beqz	s1,80001e3c <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    80001e94:	00000613          	li	a2,0
    80001e98:	01000593          	li	a1,16
    80001e9c:	0004851b          	sext.w	a0,s1
    80001ea0:	00001097          	auipc	ra,0x1
    80001ea4:	bbc080e7          	jalr	-1092(ra) # 80002a5c <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80001ea8:	00006517          	auipc	a0,0x6
    80001eac:	54850513          	addi	a0,a0,1352 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80001eb0:	00001097          	auipc	ra,0x1
    80001eb4:	b68080e7          	jalr	-1176(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80001eb8:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80001ebc:	fd5ff06f          	j	80001e90 <_ZN5Buddy9printListEv+0x74>
    80001ec0:	01813083          	ld	ra,24(sp)
    80001ec4:	01013403          	ld	s0,16(sp)
    80001ec8:	00813483          	ld	s1,8(sp)
    80001ecc:	00013903          	ld	s2,0(sp)
    80001ed0:	02010113          	addi	sp,sp,32
    80001ed4:	00008067          	ret

0000000080001ed8 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80001ed8:	ff010113          	addi	sp,sp,-16
    80001edc:	00113423          	sd	ra,8(sp)
    80001ee0:	00813023          	sd	s0,0(sp)
    80001ee4:	01010413          	addi	s0,sp,16
    80001ee8:	000105b7          	lui	a1,0x10
    80001eec:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001ef0:	00100513          	li	a0,1
    80001ef4:	00000097          	auipc	ra,0x0
    80001ef8:	a44080e7          	jalr	-1468(ra) # 80001938 <_Z41__static_initialization_and_destruction_0ii>
    80001efc:	00813083          	ld	ra,8(sp)
    80001f00:	00013403          	ld	s0,0(sp)
    80001f04:	01010113          	addi	sp,sp,16
    80001f08:	00008067          	ret

0000000080001f0c <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/kernel/system.hpp"

int main() {
    80001f0c:	fe010113          	addi	sp,sp,-32
    80001f10:	00113c23          	sd	ra,24(sp)
    80001f14:	00813823          	sd	s0,16(sp)
    80001f18:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80001f1c:	fe840513          	addi	a0,s0,-24
    80001f20:	fffff097          	auipc	ra,0xfffff
    80001f24:	5d8080e7          	jalr	1496(ra) # 800014f8 <_ZN6SystemC1Ev>

    return 0;
    80001f28:	00000513          	li	a0,0
    80001f2c:	01813083          	ld	ra,24(sp)
    80001f30:	01013403          	ld	s0,16(sp)
    80001f34:	02010113          	addi	sp,sp,32
    80001f38:	00008067          	ret

0000000080001f3c <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80001f3c:	ff010113          	addi	sp,sp,-16
    80001f40:	00813423          	sd	s0,8(sp)
    80001f44:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80001f48:	00100793          	li	a5,1
    80001f4c:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80001f50:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80001f54:	00052a23          	sw	zero,20(a0)
}
    80001f58:	00813403          	ld	s0,8(sp)
    80001f5c:	01010113          	addi	sp,sp,16
    80001f60:	00008067          	ret

0000000080001f64 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80001f64:	ff010113          	addi	sp,sp,-16
    80001f68:	00813423          	sd	s0,8(sp)
    80001f6c:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80001f70:	00100793          	li	a5,1
    80001f74:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80001f78:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80001f7c:	00052a23          	sw	zero,20(a0)
    80001f80:	00813403          	ld	s0,8(sp)
    80001f84:	01010113          	addi	sp,sp,16
    80001f88:	00008067          	ret

0000000080001f8c <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80001f8c:	ff010113          	addi	sp,sp,-16
    80001f90:	00113423          	sd	ra,8(sp)
    80001f94:	00813023          	sd	s0,0(sp)
    80001f98:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80001f9c:	00001097          	auipc	ra,0x1
    80001fa0:	c30080e7          	jalr	-976(ra) # 80002bcc <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    80001fa4:	00009797          	auipc	a5,0x9
    80001fa8:	1dc7b783          	ld	a5,476(a5) # 8000b180 <_ZN3TCB7runningE>
    80001fac:	0187b703          	ld	a4,24(a5)
    80001fb0:	0207b503          	ld	a0,32(a5)
    80001fb4:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    80001fb8:	00002097          	auipc	ra,0x2
    80001fbc:	b04080e7          	jalr	-1276(ra) # 80003abc <_ZN5RiscV14threadExitUtilEv>
}
    80001fc0:	00813083          	ld	ra,8(sp)
    80001fc4:	00013403          	ld	s0,0(sp)
    80001fc8:	01010113          	addi	sp,sp,16
    80001fcc:	00008067          	ret

0000000080001fd0 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80001fd0:	ff010113          	addi	sp,sp,-16
    80001fd4:	00813423          	sd	s0,8(sp)
    80001fd8:	01010413          	addi	s0,sp,16
    80001fdc:	04053823          	sd	zero,80(a0)
    80001fe0:	04053c23          	sd	zero,88(a0)
    80001fe4:	06053023          	sd	zero,96(a0)
    this->body = body;
    80001fe8:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80001fec:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80001ff0:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80001ff4:	02058a63          	beqz	a1,80002028 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80001ff8:	00068793          	mv	a5,a3
    80001ffc:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002000:	02058863          	beqz	a1,80002030 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80002004:	000017b7          	lui	a5,0x1
    80002008:	00f686b3          	add	a3,a3,a5
    8000200c:	00d53023          	sd	a3,0(a0)
    80002010:	00000797          	auipc	a5,0x0
    80002014:	f7c78793          	addi	a5,a5,-132 # 80001f8c <_ZN3TCB7wrapperEPv>
    80002018:	00f53423          	sd	a5,8(a0)
}
    8000201c:	00813403          	ld	s0,8(sp)
    80002020:	01010113          	addi	sp,sp,16
    80002024:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002028:	00000793          	li	a5,0
    8000202c:	fd1ff06f          	j	80001ffc <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002030:	00000693          	li	a3,0
    80002034:	fd9ff06f          	j	8000200c <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080002038 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002038:	ff010113          	addi	sp,sp,-16
    8000203c:	00113423          	sd	ra,8(sp)
    80002040:	00813023          	sd	s0,0(sp)
    80002044:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002048:	02853503          	ld	a0,40(a0)
    8000204c:	00002097          	auipc	ra,0x2
    80002050:	498080e7          	jalr	1176(ra) # 800044e4 <_Z5kfreePKv>
}
    80002054:	00813083          	ld	ra,8(sp)
    80002058:	00013403          	ld	s0,0(sp)
    8000205c:	01010113          	addi	sp,sp,16
    80002060:	00008067          	ret

0000000080002064 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002064:	ff010113          	addi	sp,sp,-16
    80002068:	00113423          	sd	ra,8(sp)
    8000206c:	00813023          	sd	s0,0(sp)
    80002070:	01010413          	addi	s0,sp,16
    free();
    80002074:	00000097          	auipc	ra,0x0
    80002078:	fc4080e7          	jalr	-60(ra) # 80002038 <_ZN3TCB4freeEv>
}
    8000207c:	00813083          	ld	ra,8(sp)
    80002080:	00013403          	ld	s0,0(sp)
    80002084:	01010113          	addi	sp,sp,16
    80002088:	00008067          	ret

000000008000208c <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    8000208c:	fe010113          	addi	sp,sp,-32
    80002090:	00113c23          	sd	ra,24(sp)
    80002094:	00813823          	sd	s0,16(sp)
    80002098:	00913423          	sd	s1,8(sp)
    8000209c:	02010413          	addi	s0,sp,32
    TCB* old = running;
    800020a0:	00009497          	auipc	s1,0x9
    800020a4:	0e04b483          	ld	s1,224(s1) # 8000b180 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    800020a8:	0104a703          	lw	a4,16(s1)
    800020ac:	00100793          	li	a5,1
    800020b0:	04e7f663          	bgeu	a5,a4,800020fc <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    800020b4:	00002097          	auipc	ra,0x2
    800020b8:	134080e7          	jalr	308(ra) # 800041e8 <_ZN9Scheduler3getEv>
    800020bc:	00009797          	auipc	a5,0x9
    800020c0:	0ca7b223          	sd	a0,196(a5) # 8000b180 <_ZN3TCB7runningE>
    if(running) {
    800020c4:	02050263          	beqz	a0,800020e8 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    800020c8:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    800020cc:	00001097          	auipc	ra,0x1
    800020d0:	be4080e7          	jalr	-1052(ra) # 80002cb0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    800020d4:	00009597          	auipc	a1,0x9
    800020d8:	0ac5b583          	ld	a1,172(a1) # 8000b180 <_ZN3TCB7runningE>
    800020dc:	00048513          	mv	a0,s1
    800020e0:	fffff097          	auipc	ra,0xfffff
    800020e4:	040080e7          	jalr	64(ra) # 80001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    800020e8:	01813083          	ld	ra,24(sp)
    800020ec:	01013403          	ld	s0,16(sp)
    800020f0:	00813483          	ld	s1,8(sp)
    800020f4:	02010113          	addi	sp,sp,32
    800020f8:	00008067          	ret
        Scheduler::put(old);
    800020fc:	00048513          	mv	a0,s1
    80002100:	00002097          	auipc	ra,0x2
    80002104:	0a0080e7          	jalr	160(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>
    80002108:	fadff06f          	j	800020b4 <_ZN3TCB8dispatchEv+0x28>

000000008000210c <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    8000210c:	ff010113          	addi	sp,sp,-16
    80002110:	00113423          	sd	ra,8(sp)
    80002114:	00813023          	sd	s0,0(sp)
    80002118:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    8000211c:	00009517          	auipc	a0,0x9
    80002120:	06c53503          	ld	a0,108(a0) # 8000b188 <_ZN3TCB8tcbCacheE>
    80002124:	00002097          	auipc	ra,0x2
    80002128:	2c8080e7          	jalr	712(ra) # 800043ec <_Z16kmem_cache_allocP5Cache>
}
    8000212c:	00813083          	ld	ra,8(sp)
    80002130:	00013403          	ld	s0,0(sp)
    80002134:	01010113          	addi	sp,sp,16
    80002138:	00008067          	ret

000000008000213c <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    8000213c:	fe010113          	addi	sp,sp,-32
    80002140:	00113c23          	sd	ra,24(sp)
    80002144:	00813823          	sd	s0,16(sp)
    80002148:	00913423          	sd	s1,8(sp)
    8000214c:	01213023          	sd	s2,0(sp)
    80002150:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    80002154:	00000697          	auipc	a3,0x0
    80002158:	e1068693          	addi	a3,a3,-496 # 80001f64 <_ZN3TCB4dtorEPv>
    8000215c:	00000617          	auipc	a2,0x0
    80002160:	de060613          	addi	a2,a2,-544 # 80001f3c <_ZN3TCB4ctorEPv>
    80002164:	07000593          	li	a1,112
    80002168:	00006517          	auipc	a0,0x6
    8000216c:	f2850513          	addi	a0,a0,-216 # 80008090 <CONSOLE_STATUS+0x80>
    80002170:	00002097          	auipc	ra,0x2
    80002174:	254080e7          	jalr	596(ra) # 800043c4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002178:	00009797          	auipc	a5,0x9
    8000217c:	00a7b823          	sd	a0,16(a5) # 8000b188 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002180:	07000513          	li	a0,112
    80002184:	00000097          	auipc	ra,0x0
    80002188:	f88080e7          	jalr	-120(ra) # 8000210c <_ZN3TCBnwEm>
    8000218c:	00050493          	mv	s1,a0
    80002190:	00050e63          	beqz	a0,800021ac <_ZN3TCB10initializeEv+0x70>
    80002194:	00200713          	li	a4,2
    80002198:	00000693          	li	a3,0
    8000219c:	00000613          	li	a2,0
    800021a0:	00000593          	li	a1,0
    800021a4:	00000097          	auipc	ra,0x0
    800021a8:	e2c080e7          	jalr	-468(ra) # 80001fd0 <_ZN3TCBC1EPFvPvES0_Pmm>
    800021ac:	00009797          	auipc	a5,0x9
    800021b0:	fc97ba23          	sd	s1,-44(a5) # 8000b180 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    800021b4:	00100793          	li	a5,1
    800021b8:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    800021bc:	00001537          	lui	a0,0x1
    800021c0:	00002097          	auipc	ra,0x2
    800021c4:	2fc080e7          	jalr	764(ra) # 800044bc <_Z7kmallocm>
    800021c8:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    800021cc:	07000513          	li	a0,112
    800021d0:	00000097          	auipc	ra,0x0
    800021d4:	f3c080e7          	jalr	-196(ra) # 8000210c <_ZN3TCBnwEm>
    800021d8:	00050493          	mv	s1,a0
    800021dc:	02050063          	beqz	a0,800021fc <_ZN3TCB10initializeEv+0xc0>
    800021e0:	00200713          	li	a4,2
    800021e4:	00090693          	mv	a3,s2
    800021e8:	00000613          	li	a2,0
    800021ec:	00009597          	auipc	a1,0x9
    800021f0:	dac5b583          	ld	a1,-596(a1) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0x40>
    800021f4:	00000097          	auipc	ra,0x0
    800021f8:	ddc080e7          	jalr	-548(ra) # 80001fd0 <_ZN3TCBC1EPFvPvES0_Pmm>
    800021fc:	00009797          	auipc	a5,0x9
    80002200:	f897ba23          	sd	s1,-108(a5) # 8000b190 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    80002204:	00100793          	li	a5,1
    80002208:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    8000220c:	00048513          	mv	a0,s1
    80002210:	00002097          	auipc	ra,0x2
    80002214:	f90080e7          	jalr	-112(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>
}
    80002218:	01813083          	ld	ra,24(sp)
    8000221c:	01013403          	ld	s0,16(sp)
    80002220:	00813483          	ld	s1,8(sp)
    80002224:	00013903          	ld	s2,0(sp)
    80002228:	02010113          	addi	sp,sp,32
    8000222c:	00008067          	ret

0000000080002230 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    80002230:	ff010113          	addi	sp,sp,-16
    80002234:	00113423          	sd	ra,8(sp)
    80002238:	00813023          	sd	s0,0(sp)
    8000223c:	01010413          	addi	s0,sp,16
    80002240:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    80002244:	00009517          	auipc	a0,0x9
    80002248:	f4453503          	ld	a0,-188(a0) # 8000b188 <_ZN3TCB8tcbCacheE>
    8000224c:	00002097          	auipc	ra,0x2
    80002250:	1c8080e7          	jalr	456(ra) # 80004414 <_Z15kmem_cache_freeP5CachePv>
}
    80002254:	00813083          	ld	ra,8(sp)
    80002258:	00013403          	ld	s0,0(sp)
    8000225c:	01010113          	addi	sp,sp,16
    80002260:	00008067          	ret

0000000080002264 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    80002264:	ff010113          	addi	sp,sp,-16
    80002268:	00813423          	sd	s0,8(sp)
    8000226c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80002270:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80002274:	05100513          	li	a0,81
    asm("ecall");
    80002278:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000227c:	00050513          	mv	a0,a0
}
    80002280:	0005051b          	sext.w	a0,a0
    80002284:	00813403          	ld	s0,8(sp)
    80002288:	01010113          	addi	sp,sp,16
    8000228c:	00008067          	ret

0000000080002290 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80002290:	ff010113          	addi	sp,sp,-16
    80002294:	00813423          	sd	s0,8(sp)
    80002298:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    8000229c:	00009797          	auipc	a5,0x9
    800022a0:	cd47b783          	ld	a5,-812(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x18>
    800022a4:	0007b783          	ld	a5,0(a5)
    800022a8:	00c7d793          	srli	a5,a5,0xc
    800022ac:	00278793          	addi	a5,a5,2
    800022b0:	00c79793          	slli	a5,a5,0xc
    800022b4:	01000737          	lui	a4,0x1000
    800022b8:	00e787b3          	add	a5,a5,a4
    800022bc:	00009717          	auipc	a4,0x9
    800022c0:	ef470713          	addi	a4,a4,-268 # 8000b1b0 <_ZN15MemoryAllocator11freeMemTailE>
    800022c4:	00f73023          	sd	a5,0(a4)
    800022c8:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    800022cc:	0007b823          	sd	zero,16(a5)
    800022d0:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    800022d4:	00073823          	sd	zero,16(a4)
    800022d8:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    800022dc:	00009697          	auipc	a3,0x9
    800022e0:	d4c6b683          	ld	a3,-692(a3) # 8000b028 <_GLOBAL_OFFSET_TABLE_+0xd0>
    800022e4:	0006b683          	ld	a3,0(a3)
    800022e8:	40f686b3          	sub	a3,a3,a5
    800022ec:	fe868693          	addi	a3,a3,-24
    800022f0:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800022f4:	00873783          	ld	a5,8(a4)
    800022f8:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800022fc:	00100793          	li	a5,1
    80002300:	02f70023          	sb	a5,32(a4)
}
    80002304:	00813403          	ld	s0,8(sp)
    80002308:	01010113          	addi	sp,sp,16
    8000230c:	00008067          	ret

0000000080002310 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002310:	ff010113          	addi	sp,sp,-16
    80002314:	00813423          	sd	s0,8(sp)
    80002318:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    8000231c:	14050663          	beqz	a0,80002468 <_ZN15MemoryAllocator7kmallocEm+0x158>
    80002320:	00050793          	mv	a5,a0
    80002324:	00009517          	auipc	a0,0x9
    80002328:	e9453503          	ld	a0,-364(a0) # 8000b1b8 <_ZN15MemoryAllocator11freeMemHeadE>
    8000232c:	0a050e63          	beqz	a0,800023e8 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80002330:	00053703          	ld	a4,0(a0)
    80002334:	12f76e63          	bltu	a4,a5,80002470 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002338:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    8000233c:	00000613          	li	a2,0
    80002340:	00c0006f          	j	8000234c <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80002344:	00050613          	mv	a2,a0
    80002348:	01053503          	ld	a0,16(a0)
    8000234c:	00050863          	beqz	a0,8000235c <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002350:	00053683          	ld	a3,0(a0)
    80002354:	01878713          	addi	a4,a5,24
    80002358:	fee6e6e3          	bltu	a3,a4,80002344 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    8000235c:	08050663          	beqz	a0,800023e8 <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    80002360:	00053683          	ld	a3,0(a0)
    80002364:	01868713          	addi	a4,a3,24
    80002368:	00e50733          	add	a4,a0,a4
    8000236c:	00009597          	auipc	a1,0x9
    80002370:	cbc5b583          	ld	a1,-836(a1) # 8000b028 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80002374:	0005b583          	ld	a1,0(a1)
    80002378:	00b76463          	bltu	a4,a1,80002380 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    8000237c:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002380:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002384:	05700593          	li	a1,87
    80002388:	08d5f063          	bgeu	a1,a3,80002408 <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    8000238c:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002390:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002394:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80002398:	01053583          	ld	a1,16(a0)
    8000239c:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    800023a0:	00853583          	ld	a1,8(a0)
    800023a4:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    800023a8:	fe868693          	addi	a3,a3,-24
    800023ac:	00d7b023          	sd	a3,0(a5)

            if(prev)
    800023b0:	04060263          	beqz	a2,800023f4 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    800023b4:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    800023b8:	00009797          	auipc	a5,0x9
    800023bc:	e107b783          	ld	a5,-496(a5) # 8000b1c8 <_ZN15MemoryAllocator12allocMemHeadE>
    800023c0:	06078463          	beqz	a5,80002428 <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    800023c4:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    800023c8:	08070063          	beqz	a4,80002448 <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    800023cc:	00873783          	ld	a5,8(a4)
    800023d0:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    800023d4:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    800023d8:	00873783          	ld	a5,8(a4)
    800023dc:	06078063          	beqz	a5,8000243c <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    800023e0:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    800023e4:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    800023e8:	00813403          	ld	s0,8(sp)
    800023ec:	01010113          	addi	sp,sp,16
    800023f0:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    800023f4:	00009697          	auipc	a3,0x9
    800023f8:	dbc68693          	addi	a3,a3,-580 # 8000b1b0 <_ZN15MemoryAllocator11freeMemTailE>
    800023fc:	00f6b023          	sd	a5,0(a3)
    80002400:	00f6b423          	sd	a5,8(a3)
    80002404:	fb5ff06f          	j	800023b8 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    80002408:	00060863          	beqz	a2,80002418 <_ZN15MemoryAllocator7kmallocEm+0x108>
    8000240c:	01053783          	ld	a5,16(a0)
    80002410:	00f63823          	sd	a5,16(a2)
    80002414:	fa5ff06f          	j	800023b8 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    80002418:	01053783          	ld	a5,16(a0)
    8000241c:	00009697          	auipc	a3,0x9
    80002420:	d8f6be23          	sd	a5,-612(a3) # 8000b1b8 <_ZN15MemoryAllocator11freeMemHeadE>
    80002424:	f95ff06f          	j	800023b8 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    80002428:	00009797          	auipc	a5,0x9
    8000242c:	d8878793          	addi	a5,a5,-632 # 8000b1b0 <_ZN15MemoryAllocator11freeMemTailE>
    80002430:	00a7b823          	sd	a0,16(a5)
    80002434:	00a7bc23          	sd	a0,24(a5)
    80002438:	fadff06f          	j	800023e4 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    8000243c:	00009797          	auipc	a5,0x9
    80002440:	d8a7b623          	sd	a0,-628(a5) # 8000b1c8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002444:	fa1ff06f          	j	800023e4 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    80002448:	00009797          	auipc	a5,0x9
    8000244c:	d6878793          	addi	a5,a5,-664 # 8000b1b0 <_ZN15MemoryAllocator11freeMemTailE>
    80002450:	0107b703          	ld	a4,16(a5)
    80002454:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80002458:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    8000245c:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002460:	00a7b823          	sd	a0,16(a5)
    80002464:	f81ff06f          	j	800023e4 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    80002468:	00000513          	li	a0,0
    8000246c:	f7dff06f          	j	800023e8 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80002470:	00000513          	li	a0,0
    80002474:	f75ff06f          	j	800023e8 <_ZN15MemoryAllocator7kmallocEm+0xd8>

0000000080002478 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80002478:	ff010113          	addi	sp,sp,-16
    8000247c:	00813423          	sd	s0,8(sp)
    80002480:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80002484:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002488:	00000713          	li	a4,0
    8000248c:	00078a63          	beqz	a5,800024a0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80002490:	00a7f863          	bgeu	a5,a0,800024a0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002494:	00078713          	mv	a4,a5
    80002498:	0107b783          	ld	a5,16(a5)
    8000249c:	ff1ff06f          	j	8000248c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    800024a0:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    800024a4:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    800024a8:	00078463          	beqz	a5,800024b0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    800024ac:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    800024b0:	02070263          	beqz	a4,800024d4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    800024b4:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    800024b8:	0005b703          	ld	a4,0(a1)
    800024bc:	00009797          	auipc	a5,0x9
    800024c0:	cfc7b783          	ld	a5,-772(a5) # 8000b1b8 <_ZN15MemoryAllocator11freeMemHeadE>
    800024c4:	00f70c63          	beq	a4,a5,800024dc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    800024c8:	00813403          	ld	s0,8(sp)
    800024cc:	01010113          	addi	sp,sp,16
    800024d0:	00008067          	ret
        *head = blk;
    800024d4:	00a5b023          	sd	a0,0(a1)
    800024d8:	fe1ff06f          	j	800024b8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    800024dc:	01053783          	ld	a5,16(a0)
    800024e0:	00078a63          	beqz	a5,800024f4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    800024e4:	00053683          	ld	a3,0(a0)
    800024e8:	00d50733          	add	a4,a0,a3
    800024ec:	01870713          	addi	a4,a4,24
    800024f0:	02f70e63          	beq	a4,a5,8000252c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    800024f4:	00853783          	ld	a5,8(a0)
    800024f8:	fc0788e3          	beqz	a5,800024c8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    800024fc:	0007b683          	ld	a3,0(a5)
    80002500:	00d78733          	add	a4,a5,a3
    80002504:	01870713          	addi	a4,a4,24
    80002508:	fca710e3          	bne	a4,a0,800024c8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    8000250c:	00053703          	ld	a4,0(a0)
    80002510:	00e68733          	add	a4,a3,a4
    80002514:	01870713          	addi	a4,a4,24
    80002518:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    8000251c:	00853783          	ld	a5,8(a0)
    80002520:	01053703          	ld	a4,16(a0)
    80002524:	00e7b823          	sd	a4,16(a5)
}
    80002528:	fa1ff06f          	j	800024c8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    8000252c:	0007b703          	ld	a4,0(a5)
    80002530:	00e68733          	add	a4,a3,a4
    80002534:	01870713          	addi	a4,a4,24
    80002538:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    8000253c:	0107b783          	ld	a5,16(a5)
    80002540:	00f53823          	sd	a5,16(a0)
    80002544:	fb1ff06f          	j	800024f4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080002548 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80002548:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    8000254c:	00009697          	auipc	a3,0x9
    80002550:	c7c6b683          	ld	a3,-900(a3) # 8000b1c8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002554:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002558:	00050a63          	beqz	a0,8000256c <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    8000255c:	fe870793          	addi	a5,a4,-24
    80002560:	00a78663          	beq	a5,a0,8000256c <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80002564:	01053503          	ld	a0,16(a0)
    80002568:	ff1ff06f          	j	80002558 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    8000256c:	08050463          	beqz	a0,800025f4 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80002570:	ff010113          	addi	sp,sp,-16
    80002574:	00113423          	sd	ra,8(sp)
    80002578:	00813023          	sd	s0,0(sp)
    8000257c:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80002580:	00009797          	auipc	a5,0x9
    80002584:	c407b783          	ld	a5,-960(a5) # 8000b1c0 <_ZN15MemoryAllocator12allocMemTailE>
    80002588:	04a78663          	beq	a5,a0,800025d4 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    8000258c:	04d50c63          	beq	a0,a3,800025e4 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80002590:	01053783          	ld	a5,16(a0)
    80002594:	00078663          	beqz	a5,800025a0 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80002598:	00853703          	ld	a4,8(a0)
    8000259c:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    800025a0:	00853783          	ld	a5,8(a0)
    800025a4:	00078663          	beqz	a5,800025b0 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    800025a8:	01053703          	ld	a4,16(a0)
    800025ac:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    800025b0:	00009597          	auipc	a1,0x9
    800025b4:	c0858593          	addi	a1,a1,-1016 # 8000b1b8 <_ZN15MemoryAllocator11freeMemHeadE>
    800025b8:	00000097          	auipc	ra,0x0
    800025bc:	ec0080e7          	jalr	-320(ra) # 80002478 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    800025c0:	00000513          	li	a0,0
}
    800025c4:	00813083          	ld	ra,8(sp)
    800025c8:	00013403          	ld	s0,0(sp)
    800025cc:	01010113          	addi	sp,sp,16
    800025d0:	00008067          	ret
            allocMemTail = blk->prev;
    800025d4:	00853783          	ld	a5,8(a0)
    800025d8:	00009717          	auipc	a4,0x9
    800025dc:	bef73423          	sd	a5,-1048(a4) # 8000b1c0 <_ZN15MemoryAllocator12allocMemTailE>
    800025e0:	fadff06f          	j	8000258c <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    800025e4:	01053783          	ld	a5,16(a0)
    800025e8:	00009717          	auipc	a4,0x9
    800025ec:	bef73023          	sd	a5,-1056(a4) # 8000b1c8 <_ZN15MemoryAllocator12allocMemHeadE>
    800025f0:	fa1ff06f          	j	80002590 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    800025f4:	fff00513          	li	a0,-1
}
    800025f8:	00008067          	ret

00000000800025fc <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    800025fc:	fe010113          	addi	sp,sp,-32
    80002600:	00113c23          	sd	ra,24(sp)
    80002604:	00813823          	sd	s0,16(sp)
    80002608:	00913423          	sd	s1,8(sp)
    8000260c:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80002610:	00009497          	auipc	s1,0x9
    80002614:	bb84b483          	ld	s1,-1096(s1) # 8000b1c8 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80002618:	00006517          	auipc	a0,0x6
    8000261c:	a8850513          	addi	a0,a0,-1400 # 800080a0 <CONSOLE_STATUS+0x90>
    80002620:	0000c097          	auipc	ra,0xc
    80002624:	660080e7          	jalr	1632(ra) # 8000ec80 <_Z11printStringPKc>
    while(iter!=nullptr){
    80002628:	04048663          	beqz	s1,80002674 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    8000262c:	00000613          	li	a2,0
    80002630:	00a00593          	li	a1,10
    80002634:	0004851b          	sext.w	a0,s1
    80002638:	0000c097          	auipc	ra,0xc
    8000263c:	7e0080e7          	jalr	2016(ra) # 8000ee18 <_Z8printIntiii>
        putc(' ');
    80002640:	02000513          	li	a0,32
    80002644:	0000b097          	auipc	ra,0xb
    80002648:	ce8080e7          	jalr	-792(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    8000264c:	00000613          	li	a2,0
    80002650:	00a00593          	li	a1,10
    80002654:	0004a503          	lw	a0,0(s1)
    80002658:	0000c097          	auipc	ra,0xc
    8000265c:	7c0080e7          	jalr	1984(ra) # 8000ee18 <_Z8printIntiii>
        putc('\n');
    80002660:	00a00513          	li	a0,10
    80002664:	0000b097          	auipc	ra,0xb
    80002668:	cc8080e7          	jalr	-824(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    8000266c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002670:	fb9ff06f          	j	80002628 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80002674:	00006517          	auipc	a0,0x6
    80002678:	a4c50513          	addi	a0,a0,-1460 # 800080c0 <CONSOLE_STATUS+0xb0>
    8000267c:	0000c097          	auipc	ra,0xc
    80002680:	604080e7          	jalr	1540(ra) # 8000ec80 <_Z11printStringPKc>
    iter = freeMemHead;
    80002684:	00009497          	auipc	s1,0x9
    80002688:	b344b483          	ld	s1,-1228(s1) # 8000b1b8 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    8000268c:	04048663          	beqz	s1,800026d8 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80002690:	00000613          	li	a2,0
    80002694:	00a00593          	li	a1,10
    80002698:	0004851b          	sext.w	a0,s1
    8000269c:	0000c097          	auipc	ra,0xc
    800026a0:	77c080e7          	jalr	1916(ra) # 8000ee18 <_Z8printIntiii>
        putc(' ');
    800026a4:	02000513          	li	a0,32
    800026a8:	0000b097          	auipc	ra,0xb
    800026ac:	c84080e7          	jalr	-892(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    800026b0:	00000613          	li	a2,0
    800026b4:	00a00593          	li	a1,10
    800026b8:	0004a503          	lw	a0,0(s1)
    800026bc:	0000c097          	auipc	ra,0xc
    800026c0:	75c080e7          	jalr	1884(ra) # 8000ee18 <_Z8printIntiii>
        putc('\n');
    800026c4:	00a00513          	li	a0,10
    800026c8:	0000b097          	auipc	ra,0xb
    800026cc:	c64080e7          	jalr	-924(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    800026d0:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800026d4:	fb9ff06f          	j	8000268c <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    800026d8:	00006517          	auipc	a0,0x6
    800026dc:	a0850513          	addi	a0,a0,-1528 # 800080e0 <CONSOLE_STATUS+0xd0>
    800026e0:	0000c097          	auipc	ra,0xc
    800026e4:	5a0080e7          	jalr	1440(ra) # 8000ec80 <_Z11printStringPKc>
}
    800026e8:	01813083          	ld	ra,24(sp)
    800026ec:	01013403          	ld	s0,16(sp)
    800026f0:	00813483          	ld	s1,8(sp)
    800026f4:	02010113          	addi	sp,sp,32
    800026f8:	00008067          	ret

00000000800026fc <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    800026fc:	ff010113          	addi	sp,sp,-16
    80002700:	00813423          	sd	s0,8(sp)
    80002704:	01010413          	addi	s0,sp,16
    80002708:	00050813          	mv	a6,a0
    8000270c:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80002710:	00000793          	li	a5,0
    80002714:	00c7fe63          	bgeu	a5,a2,80002730 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80002718:	00f50733          	add	a4,a0,a5
    8000271c:	00f806b3          	add	a3,a6,a5
    80002720:	0006c683          	lbu	a3,0(a3)
    80002724:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80002728:	00178793          	addi	a5,a5,1
    8000272c:	fe9ff06f          	j	80002714 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80002730:	00813403          	ld	s0,8(sp)
    80002734:	01010113          	addi	sp,sp,16
    80002738:	00008067          	ret

000000008000273c <_ZN11ConsoleUtil10initializeEv>:
//char ConsoleUtil::inputBuffer[8192];
//char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    8000273c:	fe010113          	addi	sp,sp,-32
    80002740:	00113c23          	sd	ra,24(sp)
    80002744:	00813823          	sd	s0,16(sp)
    80002748:	00913423          	sd	s1,8(sp)
    8000274c:	01213023          	sd	s2,0(sp)
    80002750:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80002754:	01800513          	li	a0,24
    80002758:	fffff097          	auipc	ra,0xfffff
    8000275c:	150080e7          	jalr	336(ra) # 800018a8 <_ZN3SCBnwEm>
    80002760:	00050493          	mv	s1,a0
    80002764:	00050863          	beqz	a0,80002774 <_ZN11ConsoleUtil10initializeEv+0x38>
    80002768:	00000593          	li	a1,0
    8000276c:	fffff097          	auipc	ra,0xfffff
    80002770:	f88080e7          	jalr	-120(ra) # 800016f4 <_ZN3SCBC1Em>
    80002774:	00009797          	auipc	a5,0x9
    80002778:	a697b223          	sd	s1,-1436(a5) # 8000b1d8 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    8000277c:	01800513          	li	a0,24
    80002780:	fffff097          	auipc	ra,0xfffff
    80002784:	128080e7          	jalr	296(ra) # 800018a8 <_ZN3SCBnwEm>
    80002788:	00050493          	mv	s1,a0
    8000278c:	00050863          	beqz	a0,8000279c <_ZN11ConsoleUtil10initializeEv+0x60>
    80002790:	00000593          	li	a1,0
    80002794:	fffff097          	auipc	ra,0xfffff
    80002798:	f60080e7          	jalr	-160(ra) # 800016f4 <_ZN3SCBC1Em>
    8000279c:	00009917          	auipc	s2,0x9
    800027a0:	a3c90913          	addi	s2,s2,-1476 # 8000b1d8 <_ZN11ConsoleUtil8inputSemE>
    800027a4:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    800027a8:	00008497          	auipc	s1,0x8
    800027ac:	74048493          	addi	s1,s1,1856 # 8000aee8 <_ZN11ConsoleUtil10bufferSizeE>
    800027b0:	0004b503          	ld	a0,0(s1)
    800027b4:	00002097          	auipc	ra,0x2
    800027b8:	d08080e7          	jalr	-760(ra) # 800044bc <_Z7kmallocm>
    800027bc:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    800027c0:	0004b503          	ld	a0,0(s1)
    800027c4:	00002097          	auipc	ra,0x2
    800027c8:	cf8080e7          	jalr	-776(ra) # 800044bc <_Z7kmallocm>
    800027cc:	00a93c23          	sd	a0,24(s2)
}
    800027d0:	01813083          	ld	ra,24(sp)
    800027d4:	01013403          	ld	s0,16(sp)
    800027d8:	00813483          	ld	s1,8(sp)
    800027dc:	00013903          	ld	s2,0(sp)
    800027e0:	02010113          	addi	sp,sp,32
    800027e4:	00008067          	ret
    800027e8:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    800027ec:	00048513          	mv	a0,s1
    800027f0:	fffff097          	auipc	ra,0xfffff
    800027f4:	0e8080e7          	jalr	232(ra) # 800018d8 <_ZN3SCBdlEPv>
    800027f8:	00090513          	mv	a0,s2
    800027fc:	0000a097          	auipc	ra,0xa
    80002800:	bac080e7          	jalr	-1108(ra) # 8000c3a8 <_Unwind_Resume>
    80002804:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80002808:	00048513          	mv	a0,s1
    8000280c:	fffff097          	auipc	ra,0xfffff
    80002810:	0cc080e7          	jalr	204(ra) # 800018d8 <_ZN3SCBdlEPv>
    80002814:	00090513          	mv	a0,s2
    80002818:	0000a097          	auipc	ra,0xa
    8000281c:	b90080e7          	jalr	-1136(ra) # 8000c3a8 <_Unwind_Resume>

0000000080002820 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80002820:	00009717          	auipc	a4,0x9
    80002824:	9b870713          	addi	a4,a4,-1608 # 8000b1d8 <_ZN11ConsoleUtil8inputSemE>
    80002828:	02073683          	ld	a3,32(a4)
    8000282c:	00168793          	addi	a5,a3,1
    80002830:	00008617          	auipc	a2,0x8
    80002834:	6b863603          	ld	a2,1720(a2) # 8000aee8 <_ZN11ConsoleUtil10bufferSizeE>
    80002838:	02c7f7b3          	remu	a5,a5,a2
    8000283c:	02873703          	ld	a4,40(a4)
    80002840:	04e78e63          	beq	a5,a4,8000289c <_ZN11ConsoleUtil8putInputEc+0x7c>
void ConsoleUtil::putInput(char c) {
    80002844:	ff010113          	addi	sp,sp,-16
    80002848:	00113423          	sd	ra,8(sp)
    8000284c:	00813023          	sd	s0,0(sp)
    80002850:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80002854:	00009717          	auipc	a4,0x9
    80002858:	98470713          	addi	a4,a4,-1660 # 8000b1d8 <_ZN11ConsoleUtil8inputSemE>
    8000285c:	01073783          	ld	a5,16(a4)
    80002860:	00d786b3          	add	a3,a5,a3
    80002864:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    80002868:	02073783          	ld	a5,32(a4)
    8000286c:	00178793          	addi	a5,a5,1
    80002870:	00008697          	auipc	a3,0x8
    80002874:	6786b683          	ld	a3,1656(a3) # 8000aee8 <_ZN11ConsoleUtil10bufferSizeE>
    80002878:	02d7f7b3          	remu	a5,a5,a3
    8000287c:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    80002880:	00073503          	ld	a0,0(a4)
    80002884:	fffff097          	auipc	ra,0xfffff
    80002888:	fe8080e7          	jalr	-24(ra) # 8000186c <_ZN3SCB6signalEv>
}
    8000288c:	00813083          	ld	ra,8(sp)
    80002890:	00013403          	ld	s0,0(sp)
    80002894:	01010113          	addi	sp,sp,16
    80002898:	00008067          	ret
    8000289c:	00008067          	ret

00000000800028a0 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    800028a0:	fe010113          	addi	sp,sp,-32
    800028a4:	00113c23          	sd	ra,24(sp)
    800028a8:	00813823          	sd	s0,16(sp)
    800028ac:	00913423          	sd	s1,8(sp)
    800028b0:	02010413          	addi	s0,sp,32
    inputSem->wait();
    800028b4:	00009497          	auipc	s1,0x9
    800028b8:	92448493          	addi	s1,s1,-1756 # 8000b1d8 <_ZN11ConsoleUtil8inputSemE>
    800028bc:	0004b503          	ld	a0,0(s1)
    800028c0:	fffff097          	auipc	ra,0xfffff
    800028c4:	f5c080e7          	jalr	-164(ra) # 8000181c <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    800028c8:	0284b783          	ld	a5,40(s1)
    800028cc:	0204b703          	ld	a4,32(s1)
    800028d0:	02e78c63          	beq	a5,a4,80002908 <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    800028d4:	0104b703          	ld	a4,16(s1)
    800028d8:	00f70733          	add	a4,a4,a5
    800028dc:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    800028e0:	00178793          	addi	a5,a5,1
    800028e4:	00008717          	auipc	a4,0x8
    800028e8:	60473703          	ld	a4,1540(a4) # 8000aee8 <_ZN11ConsoleUtil10bufferSizeE>
    800028ec:	02e7f7b3          	remu	a5,a5,a4
    800028f0:	02f4b423          	sd	a5,40(s1)

    return c;
}
    800028f4:	01813083          	ld	ra,24(sp)
    800028f8:	01013403          	ld	s0,16(sp)
    800028fc:	00813483          	ld	s1,8(sp)
    80002900:	02010113          	addi	sp,sp,32
    80002904:	00008067          	ret
        return -1;
    80002908:	0ff00513          	li	a0,255
    8000290c:	fe9ff06f          	j	800028f4 <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080002910 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80002910:	00009797          	auipc	a5,0x9
    80002914:	8c878793          	addi	a5,a5,-1848 # 8000b1d8 <_ZN11ConsoleUtil8inputSemE>
    80002918:	0307b703          	ld	a4,48(a5)
    8000291c:	00170713          	addi	a4,a4,1
    80002920:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80002924:	0387b683          	ld	a3,56(a5)
    80002928:	00168713          	addi	a4,a3,1
    8000292c:	00008617          	auipc	a2,0x8
    80002930:	5bc63603          	ld	a2,1468(a2) # 8000aee8 <_ZN11ConsoleUtil10bufferSizeE>
    80002934:	02c77733          	remu	a4,a4,a2
    80002938:	0407b783          	ld	a5,64(a5)
    8000293c:	06f70463          	beq	a4,a5,800029a4 <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    80002940:	ff010113          	addi	sp,sp,-16
    80002944:	00113423          	sd	ra,8(sp)
    80002948:	00813023          	sd	s0,0(sp)
    8000294c:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80002950:	00009797          	auipc	a5,0x9
    80002954:	88878793          	addi	a5,a5,-1912 # 8000b1d8 <_ZN11ConsoleUtil8inputSemE>
    80002958:	0187b703          	ld	a4,24(a5)
    8000295c:	00d706b3          	add	a3,a4,a3
    80002960:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    80002964:	0387b703          	ld	a4,56(a5)
    80002968:	00170713          	addi	a4,a4,1
    8000296c:	00008697          	auipc	a3,0x8
    80002970:	57c6b683          	ld	a3,1404(a3) # 8000aee8 <_ZN11ConsoleUtil10bufferSizeE>
    80002974:	02d77733          	remu	a4,a4,a3
    80002978:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    8000297c:	0307b703          	ld	a4,48(a5)
    80002980:	fff70713          	addi	a4,a4,-1
    80002984:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    80002988:	0087b503          	ld	a0,8(a5)
    8000298c:	fffff097          	auipc	ra,0xfffff
    80002990:	ee0080e7          	jalr	-288(ra) # 8000186c <_ZN3SCB6signalEv>
}
    80002994:	00813083          	ld	ra,8(sp)
    80002998:	00013403          	ld	s0,0(sp)
    8000299c:	01010113          	addi	sp,sp,16
    800029a0:	00008067          	ret
    800029a4:	00008067          	ret

00000000800029a8 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    800029a8:	fe010113          	addi	sp,sp,-32
    800029ac:	00113c23          	sd	ra,24(sp)
    800029b0:	00813823          	sd	s0,16(sp)
    800029b4:	00913423          	sd	s1,8(sp)
    800029b8:	02010413          	addi	s0,sp,32
    outputSem->wait();
    800029bc:	00009497          	auipc	s1,0x9
    800029c0:	81c48493          	addi	s1,s1,-2020 # 8000b1d8 <_ZN11ConsoleUtil8inputSemE>
    800029c4:	0084b503          	ld	a0,8(s1)
    800029c8:	fffff097          	auipc	ra,0xfffff
    800029cc:	e54080e7          	jalr	-428(ra) # 8000181c <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    800029d0:	0404b783          	ld	a5,64(s1)
    800029d4:	0384b703          	ld	a4,56(s1)
    800029d8:	02e78c63          	beq	a5,a4,80002a10 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    800029dc:	0184b703          	ld	a4,24(s1)
    800029e0:	00f70733          	add	a4,a4,a5
    800029e4:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    800029e8:	00178793          	addi	a5,a5,1
    800029ec:	00008717          	auipc	a4,0x8
    800029f0:	4fc73703          	ld	a4,1276(a4) # 8000aee8 <_ZN11ConsoleUtil10bufferSizeE>
    800029f4:	02e7f7b3          	remu	a5,a5,a4
    800029f8:	04f4b023          	sd	a5,64(s1)

    return c;
}
    800029fc:	01813083          	ld	ra,24(sp)
    80002a00:	01013403          	ld	s0,16(sp)
    80002a04:	00813483          	ld	s1,8(sp)
    80002a08:	02010113          	addi	sp,sp,32
    80002a0c:	00008067          	ret
        return -1;
    80002a10:	0ff00513          	li	a0,255
    80002a14:	fe9ff06f          	j	800029fc <_ZN11ConsoleUtil9getOutputEv+0x54>

0000000080002a18 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80002a18:	fe010113          	addi	sp,sp,-32
    80002a1c:	00113c23          	sd	ra,24(sp)
    80002a20:	00813823          	sd	s0,16(sp)
    80002a24:	00913423          	sd	s1,8(sp)
    80002a28:	02010413          	addi	s0,sp,32
    80002a2c:	00050493          	mv	s1,a0
    while (*string != '\0')
    80002a30:	0004c503          	lbu	a0,0(s1)
    80002a34:	00050a63          	beqz	a0,80002a48 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80002a38:	00000097          	auipc	ra,0x0
    80002a3c:	ed8080e7          	jalr	-296(ra) # 80002910 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80002a40:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002a44:	fedff06f          	j	80002a30 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80002a48:	01813083          	ld	ra,24(sp)
    80002a4c:	01013403          	ld	s0,16(sp)
    80002a50:	00813483          	ld	s1,8(sp)
    80002a54:	02010113          	addi	sp,sp,32
    80002a58:	00008067          	ret

0000000080002a5c <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80002a5c:	fb010113          	addi	sp,sp,-80
    80002a60:	04113423          	sd	ra,72(sp)
    80002a64:	04813023          	sd	s0,64(sp)
    80002a68:	02913c23          	sd	s1,56(sp)
    80002a6c:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80002a70:	00005797          	auipc	a5,0x5
    80002a74:	6b878793          	addi	a5,a5,1720 # 80008128 <CONSOLE_STATUS+0x118>
    80002a78:	0007b703          	ld	a4,0(a5)
    80002a7c:	fce43423          	sd	a4,-56(s0)
    80002a80:	0087b703          	ld	a4,8(a5)
    80002a84:	fce43823          	sd	a4,-48(s0)
    80002a88:	0107c783          	lbu	a5,16(a5)
    80002a8c:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002a90:	00060463          	beqz	a2,80002a98 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80002a94:	08054263          	bltz	a0,80002b18 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002a98:	0005051b          	sext.w	a0,a0
    neg = 0;
    80002a9c:	00000813          	li	a6,0
    }

    i = 0;
    80002aa0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002aa4:	0005871b          	sext.w	a4,a1
    80002aa8:	02b577bb          	remuw	a5,a0,a1
    80002aac:	00048693          	mv	a3,s1
    80002ab0:	0014849b          	addiw	s1,s1,1
    80002ab4:	02079793          	slli	a5,a5,0x20
    80002ab8:	0207d793          	srli	a5,a5,0x20
    80002abc:	fe040613          	addi	a2,s0,-32
    80002ac0:	00f607b3          	add	a5,a2,a5
    80002ac4:	fe87c603          	lbu	a2,-24(a5)
    80002ac8:	fe040793          	addi	a5,s0,-32
    80002acc:	00d787b3          	add	a5,a5,a3
    80002ad0:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80002ad4:	0005061b          	sext.w	a2,a0
    80002ad8:	02b5553b          	divuw	a0,a0,a1
    80002adc:	fce674e3          	bgeu	a2,a4,80002aa4 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80002ae0:	00080c63          	beqz	a6,80002af8 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80002ae4:	fe040793          	addi	a5,s0,-32
    80002ae8:	009784b3          	add	s1,a5,s1
    80002aec:	02d00793          	li	a5,45
    80002af0:	fcf48c23          	sb	a5,-40(s1)
    80002af4:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80002af8:	fff4849b          	addiw	s1,s1,-1
    80002afc:	0204c463          	bltz	s1,80002b24 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80002b00:	fe040793          	addi	a5,s0,-32
    80002b04:	009787b3          	add	a5,a5,s1
    80002b08:	fd87c503          	lbu	a0,-40(a5)
    80002b0c:	00000097          	auipc	ra,0x0
    80002b10:	e04080e7          	jalr	-508(ra) # 80002910 <_ZN11ConsoleUtil9putOutputEc>
    80002b14:	fe5ff06f          	j	80002af8 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80002b18:	40a0053b          	negw	a0,a0
        neg = 1;
    80002b1c:	00100813          	li	a6,1
        x = -xx;
    80002b20:	f81ff06f          	j	80002aa0 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80002b24:	04813083          	ld	ra,72(sp)
    80002b28:	04013403          	ld	s0,64(sp)
    80002b2c:	03813483          	ld	s1,56(sp)
    80002b30:	05010113          	addi	sp,sp,80
    80002b34:	00008067          	ret

0000000080002b38 <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    80002b38:	fd010113          	addi	sp,sp,-48
    80002b3c:	02113423          	sd	ra,40(sp)
    80002b40:	02813023          	sd	s0,32(sp)
    80002b44:	00913c23          	sd	s1,24(sp)
    80002b48:	01213823          	sd	s2,16(sp)
    80002b4c:	01313423          	sd	s3,8(sp)
    80002b50:	03010413          	addi	s0,sp,48
    80002b54:	00058913          	mv	s2,a1
    80002b58:	00060493          	mv	s1,a2
    80002b5c:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    80002b60:	00000097          	auipc	ra,0x0
    80002b64:	eb8080e7          	jalr	-328(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    80002b68:	00000613          	li	a2,0
    80002b6c:	00098593          	mv	a1,s3
    80002b70:	00090513          	mv	a0,s2
    80002b74:	00000097          	auipc	ra,0x0
    80002b78:	ee8080e7          	jalr	-280(ra) # 80002a5c <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80002b7c:	00048513          	mv	a0,s1
    80002b80:	00000097          	auipc	ra,0x0
    80002b84:	e98080e7          	jalr	-360(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
}
    80002b88:	02813083          	ld	ra,40(sp)
    80002b8c:	02013403          	ld	s0,32(sp)
    80002b90:	01813483          	ld	s1,24(sp)
    80002b94:	01013903          	ld	s2,16(sp)
    80002b98:	00813983          	ld	s3,8(sp)
    80002b9c:	03010113          	addi	sp,sp,48
    80002ba0:	00008067          	ret

0000000080002ba4 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80002ba4:	ff010113          	addi	sp,sp,-16
    80002ba8:	00813423          	sd	s0,8(sp)
    80002bac:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80002bb0:	04300513          	li	a0,67

    asm("ecall");
    80002bb4:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80002bb8:	00050513          	mv	a0,a0

    return (char)status;
}
    80002bbc:	0ff57513          	andi	a0,a0,255
    80002bc0:	00813403          	ld	s0,8(sp)
    80002bc4:	01010113          	addi	sp,sp,16
    80002bc8:	00008067          	ret

0000000080002bcc <_ZN5RiscV10popSppSpieEv>:
    RiscV::startVirtualMemory(RiscV::kPMT);
    RiscV::enableInterrupts();
}

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80002bcc:	ff010113          	addi	sp,sp,-16
    80002bd0:	00813423          	sd	s0,8(sp)
    80002bd4:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80002bd8:	00008797          	auipc	a5,0x8
    80002bdc:	4387b783          	ld	a5,1080(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002be0:	0007b783          	ld	a5,0(a5)
    80002be4:	0147a683          	lw	a3,20(a5)
    80002be8:	00100713          	li	a4,1
    80002bec:	02e68863          	beq	a3,a4,80002c1c <_ZN5RiscV10popSppSpieEv+0x50>
        asm("csrw sepc, ra");
    else{
        asm("mv a0, %[iarg]" : : [iarg] "r" (TCB::running->body));
    80002bf0:	0187b703          	ld	a4,24(a5)
    80002bf4:	00070513          	mv	a0,a4
        asm("mv a1, %[iarg]" : : [iarg] "r" (TCB::running->args));
    80002bf8:	0207b783          	ld	a5,32(a5)
    80002bfc:	00078593          	mv	a1,a5
        asm("csrw sepc, %[ra]" : : [ra] "r" ((uint64)bodyWrapper));
    80002c00:	00008797          	auipc	a5,0x8
    80002c04:	4087b783          	ld	a5,1032(a5) # 8000b008 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80002c08:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    80002c0c:	10200073          	sret
}
    80002c10:	00813403          	ld	s0,8(sp)
    80002c14:	01010113          	addi	sp,sp,16
    80002c18:	00008067          	ret
        asm("csrw sepc, ra");
    80002c1c:	14109073          	csrw	sepc,ra
    80002c20:	fedff06f          	j	80002c0c <_ZN5RiscV10popSppSpieEv+0x40>

0000000080002c24 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80002c24:	ff010113          	addi	sp,sp,-16
    80002c28:	00113423          	sd	ra,8(sp)
    80002c2c:	00813023          	sd	s0,0(sp)
    80002c30:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80002c34:	00008797          	auipc	a5,0x8
    80002c38:	3dc7b783          	ld	a5,988(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002c3c:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80002c40:	00100713          	li	a4,1
    80002c44:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002c48:	fffff097          	auipc	ra,0xfffff
    80002c4c:	444080e7          	jalr	1092(ra) # 8000208c <_ZN3TCB8dispatchEv>
}
    80002c50:	00813083          	ld	ra,8(sp)
    80002c54:	00013403          	ld	s0,0(sp)
    80002c58:	01010113          	addi	sp,sp,16
    80002c5c:	00008067          	ret

0000000080002c60 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80002c60:	ff010113          	addi	sp,sp,-16
    80002c64:	00113423          	sd	ra,8(sp)
    80002c68:	00813023          	sd	s0,0(sp)
    80002c6c:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80002c70:	00008797          	auipc	a5,0x8
    80002c74:	5b87c783          	lbu	a5,1464(a5) # 8000b228 <_ZN5RiscV16userMainFinishedE>
    80002c78:	00079c63          	bnez	a5,80002c90 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80002c7c:	00008717          	auipc	a4,0x8
    80002c80:	38473703          	ld	a4,900(a4) # 8000b000 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80002c84:	00073783          	ld	a5,0(a4)
    80002c88:	00178793          	addi	a5,a5,1
    80002c8c:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80002c90:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80002c94:	0ff57513          	andi	a0,a0,255
    80002c98:	00000097          	auipc	ra,0x0
    80002c9c:	c78080e7          	jalr	-904(ra) # 80002910 <_ZN11ConsoleUtil9putOutputEc>
}
    80002ca0:	00813083          	ld	ra,8(sp)
    80002ca4:	00013403          	ld	s0,0(sp)
    80002ca8:	01010113          	addi	sp,sp,16
    80002cac:	00008067          	ret

0000000080002cb0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80002cb0:	ff010113          	addi	sp,sp,-16
    80002cb4:	00813423          	sd	s0,8(sp)
    80002cb8:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80002cbc:	00008797          	auipc	a5,0x8
    80002cc0:	3547b783          	ld	a5,852(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002cc4:	0007b783          	ld	a5,0(a5)
    80002cc8:	0147a703          	lw	a4,20(a5)
    80002ccc:	00100793          	li	a5,1
    80002cd0:	00f70c63          	beq	a4,a5,80002ce8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sstatus(uint64 mask) {
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80002cd4:	10000793          	li	a5,256
    80002cd8:	1007b073          	csrc	sstatus,a5
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
//        RiscV::startVirtualMemory(RiscV::uPMT);
    }
}
    80002cdc:	00813403          	ld	s0,8(sp)
    80002ce0:	01010113          	addi	sp,sp,16
    80002ce4:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80002ce8:	10000793          	li	a5,256
    80002cec:	1007a073          	csrs	sstatus,a5
}
    80002cf0:	fedff06f          	j	80002cdc <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080002cf4 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80002cf4:	ff010113          	addi	sp,sp,-16
    80002cf8:	00113423          	sd	ra,8(sp)
    80002cfc:	00813023          	sd	s0,0(sp)
    80002d00:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80002d04:	00100793          	li	a5,1
    80002d08:	00008717          	auipc	a4,0x8
    80002d0c:	52f70023          	sb	a5,1312(a4) # 8000b228 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80002d10:	00008797          	auipc	a5,0x8
    80002d14:	2f07b783          	ld	a5,752(a5) # 8000b000 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80002d18:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80002d1c:	00008797          	auipc	a5,0x8
    80002d20:	2947b783          	ld	a5,660(a5) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002d24:	0007b023          	sd	zero,0(a5)
inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80002d28:	00200793          	li	a5,2
    80002d2c:	1047b073          	csrc	sie,a5
    80002d30:	20000793          	li	a5,512
    80002d34:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80002d38:	00008797          	auipc	a5,0x8
    80002d3c:	2a07b783          	ld	a5,672(a5) # 8000afd8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002d40:	0007b783          	ld	a5,0(a5)
    80002d44:	00078c63          	beqz	a5,80002d5c <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80002d48:	0487b703          	ld	a4,72(a5)
    80002d4c:	00008797          	auipc	a5,0x8
    80002d50:	28c7b783          	ld	a5,652(a5) # 8000afd8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002d54:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80002d58:	fe1ff06f          	j	80002d38 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80002d5c:	00008797          	auipc	a5,0x8
    80002d60:	2847b783          	ld	a5,644(a5) # 8000afe0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002d64:	0007b503          	ld	a0,0(a5)
    80002d68:	00001097          	auipc	ra,0x1
    80002d6c:	438080e7          	jalr	1080(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002d70:	00008797          	auipc	a5,0x8
    80002d74:	2807b783          	ld	a5,640(a5) # 8000aff0 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002d78:	0007b703          	ld	a4,0(a5)
    80002d7c:	00008797          	auipc	a5,0x8
    80002d80:	27c7b783          	ld	a5,636(a5) # 8000aff8 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002d84:	0007b783          	ld	a5,0(a5)
    80002d88:	00f70863          	beq	a4,a5,80002d98 <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    80002d8c:	fffff097          	auipc	ra,0xfffff
    80002d90:	300080e7          	jalr	768(ra) # 8000208c <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002d94:	fddff06f          	j	80002d70 <_ZN5RiscV8finalizeEv+0x7c>
}
    80002d98:	00813083          	ld	ra,8(sp)
    80002d9c:	00013403          	ld	s0,0(sp)
    80002da0:	01010113          	addi	sp,sp,16
    80002da4:	00008067          	ret

0000000080002da8 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80002da8:	ff010113          	addi	sp,sp,-16
    80002dac:	00813423          	sd	s0,8(sp)
    80002db0:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80002db4:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80002db8:	00008717          	auipc	a4,0x8
    80002dbc:	25873703          	ld	a4,600(a4) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002dc0:	00073703          	ld	a4,0(a4)
    80002dc4:	06873703          	ld	a4,104(a4)
    80002dc8:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80002dcc:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80002dd0:	00078593          	mv	a1,a5
}
    80002dd4:	00813403          	ld	s0,8(sp)
    80002dd8:	01010113          	addi	sp,sp,16
    80002ddc:	00008067          	ret

0000000080002de0 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80002de0:	ff010113          	addi	sp,sp,-16
    80002de4:	00113423          	sd	ra,8(sp)
    80002de8:	00813023          	sd	s0,0(sp)
    80002dec:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80002df0:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80002df4:	fffff097          	auipc	ra,0xfffff
    80002df8:	51c080e7          	jalr	1308(ra) # 80002310 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80002dfc:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80002e00:	00000097          	auipc	ra,0x0
    80002e04:	fa8080e7          	jalr	-88(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80002e08:	00813083          	ld	ra,8(sp)
    80002e0c:	00013403          	ld	s0,0(sp)
    80002e10:	01010113          	addi	sp,sp,16
    80002e14:	00008067          	ret

0000000080002e18 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80002e18:	ff010113          	addi	sp,sp,-16
    80002e1c:	00113423          	sd	ra,8(sp)
    80002e20:	00813023          	sd	s0,0(sp)
    80002e24:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80002e28:	00008797          	auipc	a5,0x8
    80002e2c:	1f87b783          	ld	a5,504(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80002e30:	0007c783          	lbu	a5,0(a5)
    80002e34:	02079263          	bnez	a5,80002e58 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80002e38:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002e3c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80002e40:	00000097          	auipc	ra,0x0
    80002e44:	f68080e7          	jalr	-152(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80002e48:	00813083          	ld	ra,8(sp)
    80002e4c:	00013403          	ld	s0,0(sp)
    80002e50:	01010113          	addi	sp,sp,16
    80002e54:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80002e58:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80002e5c:	fffff097          	auipc	ra,0xfffff
    80002e60:	6ec080e7          	jalr	1772(ra) # 80002548 <_ZN15MemoryAllocator5kfreeEPv>
    80002e64:	fd9ff06f          	j	80002e3c <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080002e68 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80002e68:	fc010113          	addi	sp,sp,-64
    80002e6c:	02113c23          	sd	ra,56(sp)
    80002e70:	02813823          	sd	s0,48(sp)
    80002e74:	02913423          	sd	s1,40(sp)
    80002e78:	03213023          	sd	s2,32(sp)
    80002e7c:	01313c23          	sd	s3,24(sp)
    80002e80:	01413823          	sd	s4,16(sp)
    80002e84:	01513423          	sd	s5,8(sp)
    80002e88:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80002e8c:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80002e90:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80002e94:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80002e98:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002e9c:	07000513          	li	a0,112
    80002ea0:	fffff097          	auipc	ra,0xfffff
    80002ea4:	26c080e7          	jalr	620(ra) # 8000210c <_ZN3TCBnwEm>
    80002ea8:	00050493          	mv	s1,a0
    80002eac:	00050e63          	beqz	a0,80002ec8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    80002eb0:	00200713          	li	a4,2
    80002eb4:	000a8693          	mv	a3,s5
    80002eb8:	000a0613          	mv	a2,s4
    80002ebc:	00098593          	mv	a1,s3
    80002ec0:	fffff097          	auipc	ra,0xfffff
    80002ec4:	110080e7          	jalr	272(ra) # 80001fd0 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80002ec8:	04048863          	beqz	s1,80002f18 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    80002ecc:	0184b783          	ld	a5,24(s1)
    80002ed0:	00078863          	beqz	a5,80002ee0 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    80002ed4:	00048513          	mv	a0,s1
    80002ed8:	00001097          	auipc	ra,0x1
    80002edc:	2c8080e7          	jalr	712(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80002ee0:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80002ee4:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002ee8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80002eec:	00000097          	auipc	ra,0x0
    80002ef0:	ebc080e7          	jalr	-324(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80002ef4:	03813083          	ld	ra,56(sp)
    80002ef8:	03013403          	ld	s0,48(sp)
    80002efc:	02813483          	ld	s1,40(sp)
    80002f00:	02013903          	ld	s2,32(sp)
    80002f04:	01813983          	ld	s3,24(sp)
    80002f08:	01013a03          	ld	s4,16(sp)
    80002f0c:	00813a83          	ld	s5,8(sp)
    80002f10:	04010113          	addi	sp,sp,64
    80002f14:	00008067          	ret
        status = -1;
    80002f18:	fff00793          	li	a5,-1
    80002f1c:	fcdff06f          	j	80002ee8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    80002f20:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002f24:	00048513          	mv	a0,s1
    80002f28:	fffff097          	auipc	ra,0xfffff
    80002f2c:	308080e7          	jalr	776(ra) # 80002230 <_ZN3TCBdlEPv>
    80002f30:	00090513          	mv	a0,s2
    80002f34:	00009097          	auipc	ra,0x9
    80002f38:	474080e7          	jalr	1140(ra) # 8000c3a8 <_Unwind_Resume>

0000000080002f3c <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80002f3c:	fc010113          	addi	sp,sp,-64
    80002f40:	02113c23          	sd	ra,56(sp)
    80002f44:	02813823          	sd	s0,48(sp)
    80002f48:	02913423          	sd	s1,40(sp)
    80002f4c:	03213023          	sd	s2,32(sp)
    80002f50:	01313c23          	sd	s3,24(sp)
    80002f54:	01413823          	sd	s4,16(sp)
    80002f58:	01513423          	sd	s5,8(sp)
    80002f5c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80002f60:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80002f64:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80002f68:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80002f6c:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002f70:	07000513          	li	a0,112
    80002f74:	fffff097          	auipc	ra,0xfffff
    80002f78:	198080e7          	jalr	408(ra) # 8000210c <_ZN3TCBnwEm>
    80002f7c:	00050493          	mv	s1,a0
    80002f80:	00050e63          	beqz	a0,80002f9c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80002f84:	00200713          	li	a4,2
    80002f88:	000a8693          	mv	a3,s5
    80002f8c:	00090613          	mv	a2,s2
    80002f90:	00098593          	mv	a1,s3
    80002f94:	fffff097          	auipc	ra,0xfffff
    80002f98:	03c080e7          	jalr	60(ra) # 80001fd0 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80002f9c:	04048263          	beqz	s1,80002fe0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    80002fa0:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    80002fa4:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80002fa8:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    80002fac:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002fb0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80002fb4:	00000097          	auipc	ra,0x0
    80002fb8:	df4080e7          	jalr	-524(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80002fbc:	03813083          	ld	ra,56(sp)
    80002fc0:	03013403          	ld	s0,48(sp)
    80002fc4:	02813483          	ld	s1,40(sp)
    80002fc8:	02013903          	ld	s2,32(sp)
    80002fcc:	01813983          	ld	s3,24(sp)
    80002fd0:	01013a03          	ld	s4,16(sp)
    80002fd4:	00813a83          	ld	s5,8(sp)
    80002fd8:	04010113          	addi	sp,sp,64
    80002fdc:	00008067          	ret
        status = -1;
    80002fe0:	fff00793          	li	a5,-1
    80002fe4:	fcdff06f          	j	80002fb0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    80002fe8:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002fec:	00048513          	mv	a0,s1
    80002ff0:	fffff097          	auipc	ra,0xfffff
    80002ff4:	240080e7          	jalr	576(ra) # 80002230 <_ZN3TCBdlEPv>
    80002ff8:	00090513          	mv	a0,s2
    80002ffc:	00009097          	auipc	ra,0x9
    80003000:	3ac080e7          	jalr	940(ra) # 8000c3a8 <_Unwind_Resume>

0000000080003004 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003004:	ff010113          	addi	sp,sp,-16
    80003008:	00113423          	sd	ra,8(sp)
    8000300c:	00813023          	sd	s0,0(sp)
    80003010:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003014:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003018:	02051263          	bnez	a0,8000303c <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    8000301c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003020:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003024:	00000097          	auipc	ra,0x0
    80003028:	d84080e7          	jalr	-636(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000302c:	00813083          	ld	ra,8(sp)
    80003030:	00013403          	ld	s0,0(sp)
    80003034:	01010113          	addi	sp,sp,16
    80003038:	00008067          	ret
        tcb->status = TCB::Status::READY;
    8000303c:	00100793          	li	a5,1
    80003040:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003044:	00001097          	auipc	ra,0x1
    80003048:	15c080e7          	jalr	348(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    8000304c:	fffff097          	auipc	ra,0xfffff
    80003050:	040080e7          	jalr	64(ra) # 8000208c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003054:	00000793          	li	a5,0
    80003058:	fc9ff06f          	j	80003020 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

000000008000305c <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    8000305c:	ff010113          	addi	sp,sp,-16
    80003060:	00113423          	sd	ra,8(sp)
    80003064:	00813023          	sd	s0,0(sp)
    80003068:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    8000306c:	00008797          	auipc	a5,0x8
    80003070:	fa47b783          	ld	a5,-92(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003074:	0007b783          	ld	a5,0(a5)
    80003078:	02078a63          	beqz	a5,800030ac <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    8000307c:	00200713          	li	a4,2
    80003080:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003084:	fffff097          	auipc	ra,0xfffff
    80003088:	008080e7          	jalr	8(ra) # 8000208c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000308c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003090:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003094:	00000097          	auipc	ra,0x0
    80003098:	d14080e7          	jalr	-748(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000309c:	00813083          	ld	ra,8(sp)
    800030a0:	00013403          	ld	s0,0(sp)
    800030a4:	01010113          	addi	sp,sp,16
    800030a8:	00008067          	ret
        status = -1;
    800030ac:	fff00793          	li	a5,-1
    800030b0:	fe1ff06f          	j	80003090 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

00000000800030b4 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    800030b4:	fd010113          	addi	sp,sp,-48
    800030b8:	02113423          	sd	ra,40(sp)
    800030bc:	02813023          	sd	s0,32(sp)
    800030c0:	00913c23          	sd	s1,24(sp)
    800030c4:	01213823          	sd	s2,16(sp)
    800030c8:	01313423          	sd	s3,8(sp)
    800030cc:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800030d0:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    800030d4:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    800030d8:	01800513          	li	a0,24
    800030dc:	ffffe097          	auipc	ra,0xffffe
    800030e0:	7cc080e7          	jalr	1996(ra) # 800018a8 <_ZN3SCBnwEm>
    800030e4:	00050493          	mv	s1,a0
    800030e8:	00050863          	beqz	a0,800030f8 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    800030ec:	00098593          	mv	a1,s3
    800030f0:	ffffe097          	auipc	ra,0xffffe
    800030f4:	604080e7          	jalr	1540(ra) # 800016f4 <_ZN3SCBC1Em>
    if(scb == nullptr){
    800030f8:	02048a63          	beqz	s1,8000312c <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    800030fc:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80003100:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003104:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003108:	00000097          	auipc	ra,0x0
    8000310c:	ca0080e7          	jalr	-864(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003110:	02813083          	ld	ra,40(sp)
    80003114:	02013403          	ld	s0,32(sp)
    80003118:	01813483          	ld	s1,24(sp)
    8000311c:	01013903          	ld	s2,16(sp)
    80003120:	00813983          	ld	s3,8(sp)
    80003124:	03010113          	addi	sp,sp,48
    80003128:	00008067          	ret
        status = -1;
    8000312c:	fff00793          	li	a5,-1
    80003130:	fd5ff06f          	j	80003104 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    80003134:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003138:	00048513          	mv	a0,s1
    8000313c:	ffffe097          	auipc	ra,0xffffe
    80003140:	79c080e7          	jalr	1948(ra) # 800018d8 <_ZN3SCBdlEPv>
    80003144:	00090513          	mv	a0,s2
    80003148:	00009097          	auipc	ra,0x9
    8000314c:	260080e7          	jalr	608(ra) # 8000c3a8 <_Unwind_Resume>

0000000080003150 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003150:	fe010113          	addi	sp,sp,-32
    80003154:	00113c23          	sd	ra,24(sp)
    80003158:	00813823          	sd	s0,16(sp)
    8000315c:	00913423          	sd	s1,8(sp)
    80003160:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003164:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003168:	02049463          	bnez	s1,80003190 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    8000316c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003170:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003174:	00000097          	auipc	ra,0x0
    80003178:	c34080e7          	jalr	-972(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000317c:	01813083          	ld	ra,24(sp)
    80003180:	01013403          	ld	s0,16(sp)
    80003184:	00813483          	ld	s1,8(sp)
    80003188:	02010113          	addi	sp,sp,32
    8000318c:	00008067          	ret
        delete (SCB*)ihandle;
    80003190:	00048513          	mv	a0,s1
    80003194:	ffffe097          	auipc	ra,0xffffe
    80003198:	57c080e7          	jalr	1404(ra) # 80001710 <_ZN3SCBD1Ev>
    8000319c:	00048513          	mv	a0,s1
    800031a0:	ffffe097          	auipc	ra,0xffffe
    800031a4:	738080e7          	jalr	1848(ra) # 800018d8 <_ZN3SCBdlEPv>
    uint64 status = 0;
    800031a8:	00000793          	li	a5,0
    800031ac:	fc5ff06f          	j	80003170 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

00000000800031b0 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    800031b0:	ff010113          	addi	sp,sp,-16
    800031b4:	00113423          	sd	ra,8(sp)
    800031b8:	00813023          	sd	s0,0(sp)
    800031bc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800031c0:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800031c4:	02051c63          	bnez	a0,800031fc <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    800031c8:	00008797          	auipc	a5,0x8
    800031cc:	e487b783          	ld	a5,-440(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800031d0:	0007b783          	ld	a5,0(a5)
    800031d4:	0607b783          	ld	a5,96(a5)
    800031d8:	02078863          	beqz	a5,80003208 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    800031dc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800031e0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800031e4:	00000097          	auipc	ra,0x0
    800031e8:	bc4080e7          	jalr	-1084(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    800031ec:	00813083          	ld	ra,8(sp)
    800031f0:	00013403          	ld	s0,0(sp)
    800031f4:	01010113          	addi	sp,sp,16
    800031f8:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800031fc:	ffffe097          	auipc	ra,0xffffe
    80003200:	620080e7          	jalr	1568(ra) # 8000181c <_ZN3SCB4waitEv>
    80003204:	fc5ff06f          	j	800031c8 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80003208:	00000793          	li	a5,0
    8000320c:	fd5ff06f          	j	800031e0 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003210 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003210:	ff010113          	addi	sp,sp,-16
    80003214:	00113423          	sd	ra,8(sp)
    80003218:	00813023          	sd	s0,0(sp)
    8000321c:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003220:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003224:	02051263          	bnez	a0,80003248 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003228:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000322c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003230:	00000097          	auipc	ra,0x0
    80003234:	b78080e7          	jalr	-1160(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003238:	00813083          	ld	ra,8(sp)
    8000323c:	00013403          	ld	s0,0(sp)
    80003240:	01010113          	addi	sp,sp,16
    80003244:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003248:	ffffe097          	auipc	ra,0xffffe
    8000324c:	624080e7          	jalr	1572(ra) # 8000186c <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003250:	00000793          	li	a5,0
    80003254:	fd9ff06f          	j	8000322c <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003258 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003258:	fe010113          	addi	sp,sp,-32
    8000325c:	00113c23          	sd	ra,24(sp)
    80003260:	00813823          	sd	s0,16(sp)
    80003264:	00913423          	sd	s1,8(sp)
    80003268:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    8000326c:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003270:	00008797          	auipc	a5,0x8
    80003274:	da07b783          	ld	a5,-608(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003278:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    8000327c:	00008797          	auipc	a5,0x8
    80003280:	fb47b783          	ld	a5,-76(a5) # 8000b230 <_ZN5RiscV10globalTimeE>
    80003284:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003288:	00e787b3          	add	a5,a5,a4
    8000328c:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003290:	00048513          	mv	a0,s1
    80003294:	00001097          	auipc	ra,0x1
    80003298:	f88080e7          	jalr	-120(ra) # 8000421c <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    8000329c:	00300793          	li	a5,3
    800032a0:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    800032a4:	fffff097          	auipc	ra,0xfffff
    800032a8:	de8080e7          	jalr	-536(ra) # 8000208c <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    800032ac:	00000793          	li	a5,0
    800032b0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800032b4:	00000097          	auipc	ra,0x0
    800032b8:	af4080e7          	jalr	-1292(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    800032bc:	01813083          	ld	ra,24(sp)
    800032c0:	01013403          	ld	s0,16(sp)
    800032c4:	00813483          	ld	s1,8(sp)
    800032c8:	02010113          	addi	sp,sp,32
    800032cc:	00008067          	ret

00000000800032d0 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    800032d0:	fe010113          	addi	sp,sp,-32
    800032d4:	00113c23          	sd	ra,24(sp)
    800032d8:	00813823          	sd	s0,16(sp)
    800032dc:	00913423          	sd	s1,8(sp)
    800032e0:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    800032e4:	00008797          	auipc	a5,0x8
    800032e8:	f447c783          	lbu	a5,-188(a5) # 8000b228 <_ZN5RiscV16userMainFinishedE>
    800032ec:	00079c63          	bnez	a5,80003304 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    800032f0:	00008717          	auipc	a4,0x8
    800032f4:	cc073703          	ld	a4,-832(a4) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0x58>
    800032f8:	00073783          	ld	a5,0(a4)
    800032fc:	00178793          	addi	a5,a5,1
    80003300:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003304:	fffff097          	auipc	ra,0xfffff
    80003308:	59c080e7          	jalr	1436(ra) # 800028a0 <_ZN11ConsoleUtil8getInputEv>
    8000330c:	00050493          	mv	s1,a0
    if(c==13) {
    80003310:	00d00793          	li	a5,13
    80003314:	02f50663          	beq	a0,a5,80003340 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80003318:	01b00793          	li	a5,27
    8000331c:	04f51063          	bne	a0,a5,8000335c <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003320:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003324:	00000097          	auipc	ra,0x0
    80003328:	a84080e7          	jalr	-1404(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000332c:	01813083          	ld	ra,24(sp)
    80003330:	01013403          	ld	s0,16(sp)
    80003334:	00813483          	ld	s1,8(sp)
    80003338:	02010113          	addi	sp,sp,32
    8000333c:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003340:	00d00513          	li	a0,13
    80003344:	fffff097          	auipc	ra,0xfffff
    80003348:	5cc080e7          	jalr	1484(ra) # 80002910 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    8000334c:	00a00513          	li	a0,10
    80003350:	fffff097          	auipc	ra,0xfffff
    80003354:	5c0080e7          	jalr	1472(ra) # 80002910 <_ZN11ConsoleUtil9putOutputEc>
    80003358:	fc9ff06f          	j	80003320 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    8000335c:	fffff097          	auipc	ra,0xfffff
    80003360:	5b4080e7          	jalr	1460(ra) # 80002910 <_ZN11ConsoleUtil9putOutputEc>
    80003364:	fbdff06f          	j	80003320 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003368 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003368:	ff010113          	addi	sp,sp,-16
    8000336c:	00113423          	sd	ra,8(sp)
    80003370:	00813023          	sd	s0,0(sp)
    80003374:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003378:	fffff097          	auipc	ra,0xfffff
    8000337c:	630080e7          	jalr	1584(ra) # 800029a8 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003380:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003384:	00000097          	auipc	ra,0x0
    80003388:	a24080e7          	jalr	-1500(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000338c:	00813083          	ld	ra,8(sp)
    80003390:	00013403          	ld	s0,0(sp)
    80003394:	01010113          	addi	sp,sp,16
    80003398:	00008067          	ret

000000008000339c <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    8000339c:	fe010113          	addi	sp,sp,-32
    800033a0:	00113c23          	sd	ra,24(sp)
    800033a4:	00813823          	sd	s0,16(sp)
    800033a8:	00913423          	sd	s1,8(sp)
    800033ac:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800033b0:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    800033b4:	02049463          	bnez	s1,800033dc <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800033b8:	fff00793          	li	a5,-1
    800033bc:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800033c0:	00000097          	auipc	ra,0x0
    800033c4:	9e8080e7          	jalr	-1560(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    800033c8:	01813083          	ld	ra,24(sp)
    800033cc:	01013403          	ld	s0,16(sp)
    800033d0:	00813483          	ld	s1,8(sp)
    800033d4:	02010113          	addi	sp,sp,32
    800033d8:	00008067          	ret
        kfree(thr->stack);
    800033dc:	0284b503          	ld	a0,40(s1)
    800033e0:	00001097          	auipc	ra,0x1
    800033e4:	104080e7          	jalr	260(ra) # 800044e4 <_Z5kfreePKv>
        delete thr;
    800033e8:	00048513          	mv	a0,s1
    800033ec:	fffff097          	auipc	ra,0xfffff
    800033f0:	c78080e7          	jalr	-904(ra) # 80002064 <_ZN3TCBD1Ev>
    800033f4:	00048513          	mv	a0,s1
    800033f8:	fffff097          	auipc	ra,0xfffff
    800033fc:	e38080e7          	jalr	-456(ra) # 80002230 <_ZN3TCBdlEPv>
    80003400:	fb9ff06f          	j	800033b8 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080003404 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003404:	fe010113          	addi	sp,sp,-32
    80003408:	00113c23          	sd	ra,24(sp)
    8000340c:	00813823          	sd	s0,16(sp)
    80003410:	00913423          	sd	s1,8(sp)
    80003414:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003418:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    8000341c:	02049463          	bnez	s1,80003444 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003420:	fff00793          	li	a5,-1
    80003424:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003428:	00000097          	auipc	ra,0x0
    8000342c:	980080e7          	jalr	-1664(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003430:	01813083          	ld	ra,24(sp)
    80003434:	01013403          	ld	s0,16(sp)
    80003438:	00813483          	ld	s1,8(sp)
    8000343c:	02010113          	addi	sp,sp,32
    80003440:	00008067          	ret
        delete scb;
    80003444:	00048513          	mv	a0,s1
    80003448:	ffffe097          	auipc	ra,0xffffe
    8000344c:	2c8080e7          	jalr	712(ra) # 80001710 <_ZN3SCBD1Ev>
    80003450:	00048513          	mv	a0,s1
    80003454:	ffffe097          	auipc	ra,0xffffe
    80003458:	484080e7          	jalr	1156(ra) # 800018d8 <_ZN3SCBdlEPv>
    8000345c:	fc5ff06f          	j	80003420 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003460 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003460:	fe010113          	addi	sp,sp,-32
    80003464:	00113c23          	sd	ra,24(sp)
    80003468:	00813823          	sd	s0,16(sp)
    8000346c:	00913423          	sd	s1,8(sp)
    80003470:	01213023          	sd	s2,0(sp)
    80003474:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003478:	04000513          	li	a0,64
    8000347c:	fffff097          	auipc	ra,0xfffff
    80003480:	e94080e7          	jalr	-364(ra) # 80002310 <_ZN15MemoryAllocator7kmallocEm>
    80003484:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003488:	00008797          	auipc	a5,0x8
    8000348c:	b887b783          	ld	a5,-1144(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003490:	0007b783          	ld	a5,0(a5)
    80003494:	00001637          	lui	a2,0x1
    80003498:	00050593          	mv	a1,a0
    8000349c:	0287b503          	ld	a0,40(a5)
    800034a0:	fffff097          	auipc	ra,0xfffff
    800034a4:	25c080e7          	jalr	604(ra) # 800026fc <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    800034a8:	07000513          	li	a0,112
    800034ac:	fffff097          	auipc	ra,0xfffff
    800034b0:	c60080e7          	jalr	-928(ra) # 8000210c <_ZN3TCBnwEm>
    800034b4:	00050493          	mv	s1,a0
    800034b8:	00050e63          	beqz	a0,800034d4 <_ZN5RiscV18executeForkSyscallEv+0x74>
    800034bc:	00200713          	li	a4,2
    800034c0:	00090693          	mv	a3,s2
    800034c4:	00000613          	li	a2,0
    800034c8:	00000593          	li	a1,0
    800034cc:	fffff097          	auipc	ra,0xfffff
    800034d0:	b04080e7          	jalr	-1276(ra) # 80001fd0 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    800034d4:	0a048e63          	beqz	s1,80003590 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    800034d8:	00008797          	auipc	a5,0x8
    800034dc:	af87b783          	ld	a5,-1288(a5) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0x78>
    800034e0:	0007b783          	ld	a5,0(a5)
    800034e4:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    800034e8:	00008797          	auipc	a5,0x8
    800034ec:	ad07b783          	ld	a5,-1328(a5) # 8000afb8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800034f0:	0007b783          	ld	a5,0(a5)
    800034f4:	00f907b3          	add	a5,s2,a5
    800034f8:	00008717          	auipc	a4,0x8
    800034fc:	b1873703          	ld	a4,-1256(a4) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003500:	00073683          	ld	a3,0(a4)
    80003504:	0286b683          	ld	a3,40(a3)
    80003508:	40d787b3          	sub	a5,a5,a3
    8000350c:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003510:	00073783          	ld	a5,0(a4)
    80003514:	0687b503          	ld	a0,104(a5)
    80003518:	0287b783          	ld	a5,40(a5)
    8000351c:	40f50533          	sub	a0,a0,a5
    80003520:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003524:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003528:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    8000352c:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003530:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80003534:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80003538:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    8000353c:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80003540:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003544:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003548:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    8000354c:	00073783          	ld	a5,0(a4)
    80003550:	0387b703          	ld	a4,56(a5)
    80003554:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003558:	0407b783          	ld	a5,64(a5)
    8000355c:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003560:	00048513          	mv	a0,s1
    80003564:	00001097          	auipc	ra,0x1
    80003568:	c3c080e7          	jalr	-964(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    8000356c:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003570:	00000097          	auipc	ra,0x0
    80003574:	838080e7          	jalr	-1992(ra) # 80002da8 <_ZN5RiscV16saveA0toSscratchEv>

}
    80003578:	01813083          	ld	ra,24(sp)
    8000357c:	01013403          	ld	s0,16(sp)
    80003580:	00813483          	ld	s1,8(sp)
    80003584:	00013903          	ld	s2,0(sp)
    80003588:	02010113          	addi	sp,sp,32
    8000358c:	00008067          	ret
        status = -1;
    80003590:	fff00493          	li	s1,-1
    80003594:	fd9ff06f          	j	8000356c <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80003598:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    8000359c:	00048513          	mv	a0,s1
    800035a0:	fffff097          	auipc	ra,0xfffff
    800035a4:	c90080e7          	jalr	-880(ra) # 80002230 <_ZN3TCBdlEPv>
    800035a8:	00090513          	mv	a0,s2
    800035ac:	00009097          	auipc	ra,0x9
    800035b0:	dfc080e7          	jalr	-516(ra) # 8000c3a8 <_Unwind_Resume>

00000000800035b4 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    800035b4:	ff010113          	addi	sp,sp,-16
    800035b8:	00813423          	sd	s0,8(sp)
    800035bc:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    800035c0:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    800035c4:	00878793          	addi	a5,a5,8
    800035c8:	00008717          	auipc	a4,0x8
    800035cc:	a0873703          	ld	a4,-1528(a4) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0x78>
    800035d0:	00f73023          	sd	a5,0(a4)
}
    800035d4:	00813403          	ld	s0,8(sp)
    800035d8:	01010113          	addi	sp,sp,16
    800035dc:	00008067          	ret

00000000800035e0 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    800035e0:	f9010113          	addi	sp,sp,-112
    800035e4:	06113423          	sd	ra,104(sp)
    800035e8:	06813023          	sd	s0,96(sp)
    800035ec:	04913c23          	sd	s1,88(sp)
    800035f0:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    800035f4:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800035f8:	142027f3          	csrr	a5,scause
    800035fc:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80003600:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    80003604:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80003608:	00008797          	auipc	a5,0x8
    8000360c:	a087b783          	ld	a5,-1528(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003610:	0007b783          	ld	a5,0(a5)
    80003614:	14002773          	csrr	a4,sscratch
    80003618:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    8000361c:	fd843703          	ld	a4,-40(s0)
    80003620:	00900793          	li	a5,9
    80003624:	10f70663          	beq	a4,a5,80003730 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    80003628:	fd843703          	ld	a4,-40(s0)
    8000362c:	00800793          	li	a5,8
    80003630:	10f70063          	beq	a4,a5,80003730 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    80003634:	fd843703          	ld	a4,-40(s0)
    80003638:	fff00793          	li	a5,-1
    8000363c:	03f79793          	slli	a5,a5,0x3f
    80003640:	00178793          	addi	a5,a5,1
    80003644:	26f70463          	beq	a4,a5,800038ac <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    80003648:	fd843703          	ld	a4,-40(s0)
    8000364c:	fff00793          	li	a5,-1
    80003650:	03f79793          	slli	a5,a5,0x3f
    80003654:	00978793          	addi	a5,a5,9
    80003658:	2ef70263          	beq	a4,a5,8000393c <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    8000365c:	fd843703          	ld	a4,-40(s0)
    80003660:	00200793          	li	a5,2
    80003664:	36f70a63          	beq	a4,a5,800039d8 <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    80003668:	00005517          	auipc	a0,0x5
    8000366c:	b0850513          	addi	a0,a0,-1272 # 80008170 <CONSOLE_STATUS+0x160>
    80003670:	fffff097          	auipc	ra,0xfffff
    80003674:	3a8080e7          	jalr	936(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003678:	00005517          	auipc	a0,0x5
    8000367c:	b0850513          	addi	a0,a0,-1272 # 80008180 <CONSOLE_STATUS+0x170>
    80003680:	fffff097          	auipc	ra,0xfffff
    80003684:	398080e7          	jalr	920(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003688:	142027f3          	csrr	a5,scause
    8000368c:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003690:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80003694:	00000613          	li	a2,0
    80003698:	00a00593          	li	a1,10
    8000369c:	0005051b          	sext.w	a0,a0
    800036a0:	fffff097          	auipc	ra,0xfffff
    800036a4:	3bc080e7          	jalr	956(ra) # 80002a5c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    800036a8:	00005517          	auipc	a0,0x5
    800036ac:	a9850513          	addi	a0,a0,-1384 # 80008140 <CONSOLE_STATUS+0x130>
    800036b0:	fffff097          	auipc	ra,0xfffff
    800036b4:	368080e7          	jalr	872(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800036b8:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800036bc:	00000613          	li	a2,0
    800036c0:	01000593          	li	a1,16
    800036c4:	0005051b          	sext.w	a0,a0
    800036c8:	fffff097          	auipc	ra,0xfffff
    800036cc:	394080e7          	jalr	916(ra) # 80002a5c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800036d0:	00005517          	auipc	a0,0x5
    800036d4:	a5050513          	addi	a0,a0,-1456 # 80008120 <CONSOLE_STATUS+0x110>
    800036d8:	fffff097          	auipc	ra,0xfffff
    800036dc:	340080e7          	jalr	832(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    800036e0:	01000693          	li	a3,16
    800036e4:	00005617          	auipc	a2,0x5
    800036e8:	a3c60613          	addi	a2,a2,-1476 # 80008120 <CONSOLE_STATUS+0x110>
    800036ec:	0004859b          	sext.w	a1,s1
    800036f0:	00005517          	auipc	a0,0x5
    800036f4:	aa050513          	addi	a0,a0,-1376 # 80008190 <CONSOLE_STATUS+0x180>
    800036f8:	fffff097          	auipc	ra,0xfffff
    800036fc:	440080e7          	jalr	1088(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80003700:	00008797          	auipc	a5,0x8
    80003704:	9107b783          	ld	a5,-1776(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003708:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000370c:	00200713          	li	a4,2
    80003710:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003714:	00005517          	auipc	a0,0x5
    80003718:	a8450513          	addi	a0,a0,-1404 # 80008198 <CONSOLE_STATUS+0x188>
    8000371c:	fffff097          	auipc	ra,0xfffff
    80003720:	2fc080e7          	jalr	764(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003724:	fffff097          	auipc	ra,0xfffff
    80003728:	968080e7          	jalr	-1688(ra) # 8000208c <_ZN3TCB8dispatchEv>
    8000372c:	0800006f          	j	800037ac <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003730:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003734:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003738:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    8000373c:	00478793          	addi	a5,a5,4
    80003740:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    80003744:	00008797          	auipc	a5,0x8
    80003748:	8cc7b783          	ld	a5,-1844(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000374c:	0007b783          	ld	a5,0(a5)
    80003750:	fa043703          	ld	a4,-96(s0)
    80003754:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80003758:	f9843703          	ld	a4,-104(s0)
    8000375c:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80003760:	00050793          	mv	a5,a0
        switch(syscallID){
    80003764:	06100713          	li	a4,97
    80003768:	02f76463          	bltu	a4,a5,80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    8000376c:	00279793          	slli	a5,a5,0x2
    80003770:	00005717          	auipc	a4,0x5
    80003774:	a3c70713          	addi	a4,a4,-1476 # 800081ac <CONSOLE_STATUS+0x19c>
    80003778:	00e787b3          	add	a5,a5,a4
    8000377c:	0007a783          	lw	a5,0(a5)
    80003780:	00e787b3          	add	a5,a5,a4
    80003784:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003788:	fffff097          	auipc	ra,0xfffff
    8000378c:	658080e7          	jalr	1624(ra) # 80002de0 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003790:	00008797          	auipc	a5,0x8
    80003794:	8807b783          	ld	a5,-1920(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003798:	0007b783          	ld	a5,0(a5)
    8000379c:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800037a0:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    800037a4:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800037a8:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    800037ac:	fffff097          	auipc	ra,0xfffff
    800037b0:	504080e7          	jalr	1284(ra) # 80002cb0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    800037b4:	06813083          	ld	ra,104(sp)
    800037b8:	06013403          	ld	s0,96(sp)
    800037bc:	05813483          	ld	s1,88(sp)
    800037c0:	07010113          	addi	sp,sp,112
    800037c4:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    800037c8:	fffff097          	auipc	ra,0xfffff
    800037cc:	650080e7          	jalr	1616(ra) # 80002e18 <_ZN5RiscV21executeMemFreeSyscallEv>
    800037d0:	fc1ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    800037d4:	fffff097          	auipc	ra,0xfffff
    800037d8:	694080e7          	jalr	1684(ra) # 80002e68 <_ZN5RiscV26executeThreadCreateSyscallEv>
    800037dc:	fb5ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    800037e0:	00000097          	auipc	ra,0x0
    800037e4:	87c080e7          	jalr	-1924(ra) # 8000305c <_ZN5RiscV24executeThreadExitSyscallEv>
    800037e8:	fa9ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    800037ec:	fffff097          	auipc	ra,0xfffff
    800037f0:	438080e7          	jalr	1080(ra) # 80002c24 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    800037f4:	f9dff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    800037f8:	fffff097          	auipc	ra,0xfffff
    800037fc:	744080e7          	jalr	1860(ra) # 80002f3c <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003800:	f91ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    80003804:	00000097          	auipc	ra,0x0
    80003808:	800080e7          	jalr	-2048(ra) # 80003004 <_ZN5RiscV25executeThreadStartSyscallEv>
    8000380c:	f85ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80003810:	00000097          	auipc	ra,0x0
    80003814:	8a4080e7          	jalr	-1884(ra) # 800030b4 <_ZN5RiscV21executeSemOpenSyscallEv>
    80003818:	f79ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    8000381c:	00000097          	auipc	ra,0x0
    80003820:	934080e7          	jalr	-1740(ra) # 80003150 <_ZN5RiscV22executeSemCloseSyscallEv>
    80003824:	f6dff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    80003828:	00000097          	auipc	ra,0x0
    8000382c:	988080e7          	jalr	-1656(ra) # 800031b0 <_ZN5RiscV21executeSemWaitSyscallEv>
    80003830:	f61ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    80003834:	00000097          	auipc	ra,0x0
    80003838:	9dc080e7          	jalr	-1572(ra) # 80003210 <_ZN5RiscV23executeSemSignalSyscallEv>
    8000383c:	f55ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    80003840:	00000097          	auipc	ra,0x0
    80003844:	a18080e7          	jalr	-1512(ra) # 80003258 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80003848:	f49ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    8000384c:	00000097          	auipc	ra,0x0
    80003850:	a84080e7          	jalr	-1404(ra) # 800032d0 <_ZN5RiscV18executeGetcSyscallEv>
    80003854:	f3dff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    80003858:	fffff097          	auipc	ra,0xfffff
    8000385c:	408080e7          	jalr	1032(ra) # 80002c60 <_ZN5RiscV18executePutcSyscallEv>
    80003860:	f31ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    80003864:	00000097          	auipc	ra,0x0
    80003868:	b04080e7          	jalr	-1276(ra) # 80003368 <_ZN5RiscV22executePutcUtilSyscallEv>
    8000386c:	f25ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    80003870:	00000097          	auipc	ra,0x0
    80003874:	b2c080e7          	jalr	-1236(ra) # 8000339c <_ZN5RiscV24executeThreadFreeSyscallEv>
    80003878:	f19ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    8000387c:	00000097          	auipc	ra,0x0
    80003880:	b88080e7          	jalr	-1144(ra) # 80003404 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80003884:	f0dff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80003888:	00010793          	mv	a5,sp
    8000388c:	00007717          	auipc	a4,0x7
    80003890:	72c73703          	ld	a4,1836(a4) # 8000afb8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003894:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80003898:	00000097          	auipc	ra,0x0
    8000389c:	d1c080e7          	jalr	-740(ra) # 800035b4 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    800038a0:	00000097          	auipc	ra,0x0
    800038a4:	bc0080e7          	jalr	-1088(ra) # 80003460 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    800038a8:	ee9ff06f          	j	80003790 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800038ac:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800038b0:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800038b4:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800038b8:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    800038bc:	00200793          	li	a5,2
    800038c0:	1447b073          	csrc	sip,a5
        globalTime += 1;
    800038c4:	00008717          	auipc	a4,0x8
    800038c8:	96470713          	addi	a4,a4,-1692 # 8000b228 <_ZN5RiscV16userMainFinishedE>
    800038cc:	00873783          	ld	a5,8(a4)
    800038d0:	00178793          	addi	a5,a5,1
    800038d4:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    800038d8:	00001097          	auipc	ra,0x1
    800038dc:	99c080e7          	jalr	-1636(ra) # 80004274 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    800038e0:	00007717          	auipc	a4,0x7
    800038e4:	6a073703          	ld	a4,1696(a4) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x28>
    800038e8:	00073783          	ld	a5,0(a4)
    800038ec:	00178793          	addi	a5,a5,1
    800038f0:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    800038f4:	00007717          	auipc	a4,0x7
    800038f8:	71c73703          	ld	a4,1820(a4) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800038fc:	00073703          	ld	a4,0(a4)
    80003900:	03073683          	ld	a3,48(a4)
    80003904:	00d7fc63          	bgeu	a5,a3,8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    80003908:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    8000390c:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003910:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003914:	14179073          	csrw	sepc,a5
}
    80003918:	e95ff06f          	j	800037ac <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    8000391c:	00007797          	auipc	a5,0x7
    80003920:	6647b783          	ld	a5,1636(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003924:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80003928:	00100793          	li	a5,1
    8000392c:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80003930:	ffffe097          	auipc	ra,0xffffe
    80003934:	75c080e7          	jalr	1884(ra) # 8000208c <_ZN3TCB8dispatchEv>
    80003938:	fd1ff06f          	j	80003908 <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    8000393c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003940:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003944:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003948:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    8000394c:	00007797          	auipc	a5,0x7
    80003950:	61c7b783          	ld	a5,1564(a5) # 8000af68 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003954:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003958:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    8000395c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003960:	00058793          	mv	a5,a1
        if(status & 1UL)
    80003964:	0017f793          	andi	a5,a5,1
    80003968:	02078863          	beqz	a5,80003998 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    8000396c:	00007797          	auipc	a5,0x7
    80003970:	63c7b783          	ld	a5,1596(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003974:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80003978:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    8000397c:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80003980:	00058513          	mv	a0,a1
    80003984:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80003988:	00007797          	auipc	a5,0x7
    8000398c:	6287b783          	ld	a5,1576(a5) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003990:	0007b783          	ld	a5,0(a5)
    80003994:	02079463          	bnez	a5,800039bc <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    80003998:	00002097          	auipc	ra,0x2
    8000399c:	2ac080e7          	jalr	684(ra) # 80005c44 <plic_claim>
    800039a0:	00002097          	auipc	ra,0x2
    800039a4:	2dc080e7          	jalr	732(ra) # 80005c7c <plic_complete>
        RiscV::w_sstatus(sstatus);
    800039a8:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800039ac:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    800039b0:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800039b4:	14179073          	csrw	sepc,a5
}
    800039b8:	df5ff06f          	j	800037ac <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    800039bc:	fff78793          	addi	a5,a5,-1
    800039c0:	00007717          	auipc	a4,0x7
    800039c4:	5f073703          	ld	a4,1520(a4) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0x58>
    800039c8:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    800039cc:	fffff097          	auipc	ra,0xfffff
    800039d0:	e54080e7          	jalr	-428(ra) # 80002820 <_ZN11ConsoleUtil8putInputEc>
    800039d4:	fc5ff06f          	j	80003998 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    800039d8:	00007797          	auipc	a5,0x7
    800039dc:	6387b783          	ld	a5,1592(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800039e0:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800039e4:	00200713          	li	a4,2
    800039e8:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    800039ec:	00004517          	auipc	a0,0x4
    800039f0:	75450513          	addi	a0,a0,1876 # 80008140 <CONSOLE_STATUS+0x130>
    800039f4:	fffff097          	auipc	ra,0xfffff
    800039f8:	024080e7          	jalr	36(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800039fc:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003a00:	00000613          	li	a2,0
    80003a04:	01000593          	li	a1,16
    80003a08:	0005051b          	sext.w	a0,a0
    80003a0c:	fffff097          	auipc	ra,0xfffff
    80003a10:	050080e7          	jalr	80(ra) # 80002a5c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003a14:	00004517          	auipc	a0,0x4
    80003a18:	70c50513          	addi	a0,a0,1804 # 80008120 <CONSOLE_STATUS+0x110>
    80003a1c:	fffff097          	auipc	ra,0xfffff
    80003a20:	ffc080e7          	jalr	-4(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80003a24:	00004517          	auipc	a0,0x4
    80003a28:	72450513          	addi	a0,a0,1828 # 80008148 <CONSOLE_STATUS+0x138>
    80003a2c:	fffff097          	auipc	ra,0xfffff
    80003a30:	fec080e7          	jalr	-20(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003a34:	ffffe097          	auipc	ra,0xffffe
    80003a38:	658080e7          	jalr	1624(ra) # 8000208c <_ZN3TCB8dispatchEv>
    80003a3c:	d71ff06f          	j	800037ac <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

0000000080003a40 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    80003a40:	fd010113          	addi	sp,sp,-48
    80003a44:	02113423          	sd	ra,40(sp)
    80003a48:	02813023          	sd	s0,32(sp)
    80003a4c:	00913c23          	sd	s1,24(sp)
    80003a50:	01213823          	sd	s2,16(sp)
    80003a54:	01313423          	sd	s3,8(sp)
    80003a58:	03010413          	addi	s0,sp,48
    80003a5c:	00050913          	mv	s2,a0
    80003a60:	00058493          	mv	s1,a1
    80003a64:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    80003a68:	00058e63          	beqz	a1,80003a84 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003a6c:	04000513          	li	a0,64
    80003a70:	fffff097          	auipc	ra,0xfffff
    80003a74:	8a0080e7          	jalr	-1888(ra) # 80002310 <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    80003a78:	00051863          	bnez	a0,80003a88 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    80003a7c:	00093023          	sd	zero,0(s2)
            return;
    80003a80:	0200006f          	j	80003aa0 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    80003a84:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80003a88:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80003a8c:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80003a90:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80003a94:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80003a98:	01100513          	li	a0,17

    asm("ecall");
    80003a9c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    80003aa0:	02813083          	ld	ra,40(sp)
    80003aa4:	02013403          	ld	s0,32(sp)
    80003aa8:	01813483          	ld	s1,24(sp)
    80003aac:	01013903          	ld	s2,16(sp)
    80003ab0:	00813983          	ld	s3,8(sp)
    80003ab4:	03010113          	addi	sp,sp,48
    80003ab8:	00008067          	ret

0000000080003abc <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    80003abc:	ff010113          	addi	sp,sp,-16
    80003ac0:	00813423          	sd	s0,8(sp)
    80003ac4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80003ac8:	01200513          	li	a0,18

    asm("ecall");
    80003acc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    80003ad0:	00813403          	ld	s0,8(sp)
    80003ad4:	01010113          	addi	sp,sp,16
    80003ad8:	00008067          	ret

0000000080003adc <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    80003adc:	ff010113          	addi	sp,sp,-16
    80003ae0:	00813423          	sd	s0,8(sp)
    80003ae4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80003ae8:	01300513          	li	a0,19

    asm("ecall");
    80003aec:	00000073          	ecall
}
    80003af0:	00813403          	ld	s0,8(sp)
    80003af4:	01010113          	addi	sp,sp,16
    80003af8:	00008067          	ret

0000000080003afc <_ZN5RiscV11putcWrapperEPv>:
{
    80003afc:	fe010113          	addi	sp,sp,-32
    80003b00:	00113c23          	sd	ra,24(sp)
    80003b04:	00813823          	sd	s0,16(sp)
    80003b08:	02010413          	addi	s0,sp,32
    80003b0c:	00c0006f          	j	80003b18 <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    80003b10:	00000097          	auipc	ra,0x0
    80003b14:	fcc080e7          	jalr	-52(ra) # 80003adc <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    80003b18:	00007797          	auipc	a5,0x7
    80003b1c:	4507b783          	ld	a5,1104(a5) # 8000af68 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003b20:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003b24:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003b28:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003b2c:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003b30:	0207f793          	andi	a5,a5,32
    80003b34:	fc078ee3          	beqz	a5,80003b10 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003b38:	fffff097          	auipc	ra,0xfffff
    80003b3c:	06c080e7          	jalr	108(ra) # 80002ba4 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003b40:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003b44:	00007797          	auipc	a5,0x7
    80003b48:	41c7b783          	ld	a5,1052(a5) # 8000af60 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003b4c:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003b50:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003b54:	fef44783          	lbu	a5,-17(s0)
    80003b58:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003b5c:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003b60:	00007797          	auipc	a5,0x7
    80003b64:	4a07b783          	ld	a5,1184(a5) # 8000b000 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003b68:	0007b783          	ld	a5,0(a5)
    80003b6c:	fa0786e3          	beqz	a5,80003b18 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003b70:	fff78793          	addi	a5,a5,-1
    80003b74:	00007717          	auipc	a4,0x7
    80003b78:	48c73703          	ld	a4,1164(a4) # 8000b000 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003b7c:	00f73023          	sd	a5,0(a4)
    80003b80:	f99ff06f          	j	80003b18 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003b84 <_ZN5RiscV6getPMTEv>:

    RiscV::mapConsoleRegisters(uPMT);
    RiscV::ms_sstatus(1<<18);
}

void* RiscV::getPMT(){
    80003b84:	ff010113          	addi	sp,sp,-16
    80003b88:	00113423          	sd	ra,8(sp)
    80003b8c:	00813023          	sd	s0,0(sp)
    80003b90:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    80003b94:	00100513          	li	a0,1
    80003b98:	ffffe097          	auipc	ra,0xffffe
    80003b9c:	1d0080e7          	jalr	464(ra) # 80001d68 <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80003ba0:	00000793          	li	a5,0
    80003ba4:	1ff00713          	li	a4,511
    80003ba8:	00f74c63          	blt	a4,a5,80003bc0 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    80003bac:	00379713          	slli	a4,a5,0x3
    80003bb0:	00e50733          	add	a4,a0,a4
    80003bb4:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    80003bb8:	0017879b          	addiw	a5,a5,1
    80003bbc:	fe9ff06f          	j	80003ba4 <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    80003bc0:	00813083          	ld	ra,8(sp)
    80003bc4:	00013403          	ld	s0,0(sp)
    80003bc8:	01010113          	addi	sp,sp,16
    80003bcc:	00008067          	ret

0000000080003bd0 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    80003bd0:	fc010113          	addi	sp,sp,-64
    80003bd4:	02113c23          	sd	ra,56(sp)
    80003bd8:	02813823          	sd	s0,48(sp)
    80003bdc:	02913423          	sd	s1,40(sp)
    80003be0:	03213023          	sd	s2,32(sp)
    80003be4:	01313c23          	sd	s3,24(sp)
    80003be8:	01413823          	sd	s4,16(sp)
    80003bec:	01513423          	sd	s5,8(sp)
    80003bf0:	04010413          	addi	s0,sp,64
    80003bf4:	00060993          	mv	s3,a2
    uint64 satp = 0;
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
}

inline uint64 RiscV::getPMT2Entry(uint64 addr) {
    return (addr >> 30) & (0x1ff);
    80003bf8:	01e5d793          	srli	a5,a1,0x1e
    80003bfc:	1ff7f793          	andi	a5,a5,511
}

inline uint64 RiscV::getPMT1Entry(uint64 addr) {
    return (addr >> 21) & (0x1ff);
    80003c00:	0155d913          	srli	s2,a1,0x15
    80003c04:	1ff97913          	andi	s2,s2,511
}

inline uint64 RiscV::getPMT0Entry(uint64 addr) {
    return (addr >> 12) & (0x1ff);
    80003c08:	00c5d493          	srli	s1,a1,0xc
    80003c0c:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Entry = RiscV::getPMT2Entry(addr);
    uint64 pmt1Entry = RiscV::getPMT1Entry(addr);
    uint64 pmt0Entry = RiscV::getPMT0Entry(addr);
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80003c10:	00379793          	slli	a5,a5,0x3
    80003c14:	00f50ab3          	add	s5,a0,a5
    80003c18:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80003c1c:	04078e63          	beqz	a5,80003c78 <_ZN5RiscV15handlePageFaultEPvmm+0xa8>
        pmt1 = RiscV::getPMT();
        uint64 frame = (uint64)pmt1 >> 12;
        ((uint64*)PMT)[pmt2Entry] = (frame << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80003c20:	00a7d513          	srli	a0,a5,0xa
    80003c24:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    80003c28:	00391913          	slli	s2,s2,0x3
    80003c2c:	01250933          	add	s2,a0,s2
    80003c30:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    80003c34:	06050063          	beqz	a0,80003c94 <_ZN5RiscV15handlePageFaultEPvmm+0xc4>
        pmt0 = RiscV::getPMT();
        uint64 frame = (uint64)pmt0 >> 12;
        ((uint64*)pmt1)[pmt1Entry] = (frame << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    80003c38:	00a55513          	srli	a0,a0,0xa
    80003c3c:	00c51513          	slli	a0,a0,0xc
    uint64 frame = addr >> 12;
    ((uint64 *) pmt0)[pmt0Entry] = (frame << 10) | mask;
    80003c40:	00a49493          	slli	s1,s1,0xa
    80003c44:	003a1a13          	slli	s4,s4,0x3
    80003c48:	01450533          	add	a0,a0,s4
    80003c4c:	0134e9b3          	or	s3,s1,s3
    80003c50:	01353023          	sd	s3,0(a0)
}
    80003c54:	03813083          	ld	ra,56(sp)
    80003c58:	03013403          	ld	s0,48(sp)
    80003c5c:	02813483          	ld	s1,40(sp)
    80003c60:	02013903          	ld	s2,32(sp)
    80003c64:	01813983          	ld	s3,24(sp)
    80003c68:	01013a03          	ld	s4,16(sp)
    80003c6c:	00813a83          	ld	s5,8(sp)
    80003c70:	04010113          	addi	sp,sp,64
    80003c74:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80003c78:	00000097          	auipc	ra,0x0
    80003c7c:	f0c080e7          	jalr	-244(ra) # 80003b84 <_ZN5RiscV6getPMTEv>
        uint64 frame = (uint64)pmt1 >> 12;
    80003c80:	00c55793          	srli	a5,a0,0xc
        ((uint64*)PMT)[pmt2Entry] = (frame << 10) | (uint64)1;
    80003c84:	00a79793          	slli	a5,a5,0xa
    80003c88:	0017e793          	ori	a5,a5,1
    80003c8c:	00fab023          	sd	a5,0(s5)
    80003c90:	f99ff06f          	j	80003c28 <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    80003c94:	00000097          	auipc	ra,0x0
    80003c98:	ef0080e7          	jalr	-272(ra) # 80003b84 <_ZN5RiscV6getPMTEv>
        uint64 frame = (uint64)pmt0 >> 12;
    80003c9c:	00c55793          	srli	a5,a0,0xc
        ((uint64*)pmt1)[pmt1Entry] = (frame << 10) | (uint64)1;
    80003ca0:	00a79793          	slli	a5,a5,0xa
    80003ca4:	0017e793          	ori	a5,a5,1
    80003ca8:	00f93023          	sd	a5,0(s2)
    80003cac:	f95ff06f          	j	80003c40 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

0000000080003cb0 <_ZN5RiscV12buildSectionEPvmmm>:
void RiscV::buildSection(void *PMT, uint64 start, uint64 end, uint64 mask) {
    80003cb0:	fd010113          	addi	sp,sp,-48
    80003cb4:	02113423          	sd	ra,40(sp)
    80003cb8:	02813023          	sd	s0,32(sp)
    80003cbc:	00913c23          	sd	s1,24(sp)
    80003cc0:	01213823          	sd	s2,16(sp)
    80003cc4:	01313423          	sd	s3,8(sp)
    80003cc8:	01413023          	sd	s4,0(sp)
    80003ccc:	03010413          	addi	s0,sp,48
    80003cd0:	00050a13          	mv	s4,a0
    80003cd4:	00058493          	mv	s1,a1
    80003cd8:	00060913          	mv	s2,a2
    80003cdc:	00068993          	mv	s3,a3
    for(uint64 i=start;i< end;i+=0x1000) {
    80003ce0:	0324f263          	bgeu	s1,s2,80003d04 <_ZN5RiscV12buildSectionEPvmmm+0x54>
        handlePageFault(PMT,i, mask);
    80003ce4:	00098613          	mv	a2,s3
    80003ce8:	00048593          	mv	a1,s1
    80003cec:	000a0513          	mv	a0,s4
    80003cf0:	00000097          	auipc	ra,0x0
    80003cf4:	ee0080e7          	jalr	-288(ra) # 80003bd0 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=start;i< end;i+=0x1000) {
    80003cf8:	000017b7          	lui	a5,0x1
    80003cfc:	00f484b3          	add	s1,s1,a5
    80003d00:	fe1ff06f          	j	80003ce0 <_ZN5RiscV12buildSectionEPvmmm+0x30>
}
    80003d04:	02813083          	ld	ra,40(sp)
    80003d08:	02013403          	ld	s0,32(sp)
    80003d0c:	01813483          	ld	s1,24(sp)
    80003d10:	01013903          	ld	s2,16(sp)
    80003d14:	00813983          	ld	s3,8(sp)
    80003d18:	00013a03          	ld	s4,0(sp)
    80003d1c:	03010113          	addi	sp,sp,48
    80003d20:	00008067          	ret

0000000080003d24 <_ZN5RiscV19mapConsoleRegistersEPv>:

void RiscV::mapConsoleRegisters(void *PMT) {
    80003d24:	fe010113          	addi	sp,sp,-32
    80003d28:	00113c23          	sd	ra,24(sp)
    80003d2c:	00813823          	sd	s0,16(sp)
    80003d30:	00913423          	sd	s1,8(sp)
    80003d34:	02010413          	addi	s0,sp,32
    80003d38:	00050493          	mv	s1,a0
    handlePageFault(PMT, (uint64)CONSOLE_STATUS,0x1f);
    80003d3c:	01f00613          	li	a2,31
    80003d40:	00007797          	auipc	a5,0x7
    80003d44:	2287b783          	ld	a5,552(a5) # 8000af68 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003d48:	0007b583          	ld	a1,0(a5)
    80003d4c:	00000097          	auipc	ra,0x0
    80003d50:	e84080e7          	jalr	-380(ra) # 80003bd0 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_TX_DATA,0x1f);
    80003d54:	01f00613          	li	a2,31
    80003d58:	00007797          	auipc	a5,0x7
    80003d5c:	2507b783          	ld	a5,592(a5) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003d60:	0007b583          	ld	a1,0(a5)
    80003d64:	00048513          	mv	a0,s1
    80003d68:	00000097          	auipc	ra,0x0
    80003d6c:	e68080e7          	jalr	-408(ra) # 80003bd0 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_RX_DATA,0x1f);
    80003d70:	01f00613          	li	a2,31
    80003d74:	00007797          	auipc	a5,0x7
    80003d78:	1ec7b783          	ld	a5,492(a5) # 8000af60 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003d7c:	0007b583          	ld	a1,0(a5)
    80003d80:	00048513          	mv	a0,s1
    80003d84:	00000097          	auipc	ra,0x0
    80003d88:	e4c080e7          	jalr	-436(ra) # 80003bd0 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)PLIC_CLAIM_PF,0x1f);
    80003d8c:	01f00613          	li	a2,31
    80003d90:	0c2015b7          	lui	a1,0xc201
    80003d94:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    80003d98:	00048513          	mv	a0,s1
    80003d9c:	00000097          	auipc	ra,0x0
    80003da0:	e34080e7          	jalr	-460(ra) # 80003bd0 <_ZN5RiscV15handlePageFaultEPvmm>
    80003da4:	01813083          	ld	ra,24(sp)
    80003da8:	01013403          	ld	s0,16(sp)
    80003dac:	00813483          	ld	s1,8(sp)
    80003db0:	02010113          	addi	sp,sp,32
    80003db4:	00008067          	ret

0000000080003db8 <_ZN5RiscV14buildKernelPMTEv>:
void RiscV::buildKernelPMT() {
    80003db8:	fd010113          	addi	sp,sp,-48
    80003dbc:	02113423          	sd	ra,40(sp)
    80003dc0:	02813023          	sd	s0,32(sp)
    80003dc4:	00913c23          	sd	s1,24(sp)
    80003dc8:	01213823          	sd	s2,16(sp)
    80003dcc:	01313423          	sd	s3,8(sp)
    80003dd0:	01413023          	sd	s4,0(sp)
    80003dd4:	03010413          	addi	s0,sp,48
    RiscV::kPMT = RiscV::getPMT();
    80003dd8:	00000097          	auipc	ra,0x0
    80003ddc:	dac080e7          	jalr	-596(ra) # 80003b84 <_ZN5RiscV6getPMTEv>
    80003de0:	00007497          	auipc	s1,0x7
    80003de4:	44848493          	addi	s1,s1,1096 # 8000b228 <_ZN5RiscV16userMainFinishedE>
    80003de8:	00a4b823          	sd	a0,16(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003dec:	00007797          	auipc	a5,0x7
    80003df0:	1a47b783          	ld	a5,420(a5) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003df4:	0007b903          	ld	s2,0(a5)
    80003df8:	00c91913          	slli	s2,s2,0xc
    80003dfc:	00007797          	auipc	a5,0x7
    80003e00:	1a47b783          	ld	a5,420(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003e04:	0007b783          	ld	a5,0(a5)
    80003e08:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(kPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80003e0c:	00007a17          	auipc	s4,0x7
    80003e10:	16ca3a03          	ld	s4,364(s4) # 8000af78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003e14:	00b00693          	li	a3,11
    80003e18:	000a0613          	mv	a2,s4
    80003e1c:	00100593          	li	a1,1
    80003e20:	01f59593          	slli	a1,a1,0x1f
    80003e24:	00000097          	auipc	ra,0x0
    80003e28:	e8c080e7          	jalr	-372(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80003e2c:	00007997          	auipc	s3,0x7
    80003e30:	1ec9b983          	ld	s3,492(s3) # 8000b018 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003e34:	00700693          	li	a3,7
    80003e38:	00098613          	mv	a2,s3
    80003e3c:	000a0593          	mv	a1,s4
    80003e40:	0104b503          	ld	a0,16(s1)
    80003e44:	00000097          	auipc	ra,0x0
    80003e48:	e6c080e7          	jalr	-404(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80003e4c:	00007a17          	auipc	s4,0x7
    80003e50:	1eca3a03          	ld	s4,492(s4) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80003e54:	01b00693          	li	a3,27
    80003e58:	000a0613          	mv	a2,s4
    80003e5c:	00098593          	mv	a1,s3
    80003e60:	0104b503          	ld	a0,16(s1)
    80003e64:	00000097          	auipc	ra,0x0
    80003e68:	e4c080e7          	jalr	-436(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80003e6c:	00007997          	auipc	s3,0x7
    80003e70:	11c9b983          	ld	s3,284(s3) # 8000af88 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003e74:	01700693          	li	a3,23
    80003e78:	00098613          	mv	a2,s3
    80003e7c:	000a0593          	mv	a1,s4
    80003e80:	0104b503          	ld	a0,16(s1)
    80003e84:	00000097          	auipc	ra,0x0
    80003e88:	e2c080e7          	jalr	-468(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_END, bEnd, 0x7);
    80003e8c:	00700693          	li	a3,7
    80003e90:	00090613          	mv	a2,s2
    80003e94:	00098593          	mv	a1,s3
    80003e98:	0104b503          	ld	a0,16(s1)
    80003e9c:	00000097          	auipc	ra,0x0
    80003ea0:	e14080e7          	jalr	-492(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, bEnd, HEAP_END, 0x17);
    80003ea4:	01700693          	li	a3,23
    80003ea8:	00007797          	auipc	a5,0x7
    80003eac:	1807b783          	ld	a5,384(a5) # 8000b028 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80003eb0:	0007b603          	ld	a2,0(a5)
    80003eb4:	00090593          	mv	a1,s2
    80003eb8:	0104b503          	ld	a0,16(s1)
    80003ebc:	00000097          	auipc	ra,0x0
    80003ec0:	df4080e7          	jalr	-524(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(kPMT);
    80003ec4:	0104b503          	ld	a0,16(s1)
    80003ec8:	00000097          	auipc	ra,0x0
    80003ecc:	e5c080e7          	jalr	-420(ra) # 80003d24 <_ZN5RiscV19mapConsoleRegistersEPv>
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003ed0:	000407b7          	lui	a5,0x40
    80003ed4:	1007a073          	csrs	sstatus,a5
}
    80003ed8:	02813083          	ld	ra,40(sp)
    80003edc:	02013403          	ld	s0,32(sp)
    80003ee0:	01813483          	ld	s1,24(sp)
    80003ee4:	01013903          	ld	s2,16(sp)
    80003ee8:	00813983          	ld	s3,8(sp)
    80003eec:	00013a03          	ld	s4,0(sp)
    80003ef0:	03010113          	addi	sp,sp,48
    80003ef4:	00008067          	ret

0000000080003ef8 <_ZN5RiscV12buildUserPMTEv>:
void RiscV::buildUserPMT() {
    80003ef8:	fd010113          	addi	sp,sp,-48
    80003efc:	02113423          	sd	ra,40(sp)
    80003f00:	02813023          	sd	s0,32(sp)
    80003f04:	00913c23          	sd	s1,24(sp)
    80003f08:	01213823          	sd	s2,16(sp)
    80003f0c:	01313423          	sd	s3,8(sp)
    80003f10:	01413023          	sd	s4,0(sp)
    80003f14:	03010413          	addi	s0,sp,48
    RiscV::uPMT = RiscV::getPMT();
    80003f18:	00000097          	auipc	ra,0x0
    80003f1c:	c6c080e7          	jalr	-916(ra) # 80003b84 <_ZN5RiscV6getPMTEv>
    80003f20:	00007497          	auipc	s1,0x7
    80003f24:	30848493          	addi	s1,s1,776 # 8000b228 <_ZN5RiscV16userMainFinishedE>
    80003f28:	00a4bc23          	sd	a0,24(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003f2c:	00007797          	auipc	a5,0x7
    80003f30:	0647b783          	ld	a5,100(a5) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003f34:	0007b903          	ld	s2,0(a5)
    80003f38:	00c91913          	slli	s2,s2,0xc
    80003f3c:	00007797          	auipc	a5,0x7
    80003f40:	0647b783          	ld	a5,100(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003f44:	0007b783          	ld	a5,0(a5)
    80003f48:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(uPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80003f4c:	00007a17          	auipc	s4,0x7
    80003f50:	02ca3a03          	ld	s4,44(s4) # 8000af78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003f54:	00b00693          	li	a3,11
    80003f58:	000a0613          	mv	a2,s4
    80003f5c:	00100593          	li	a1,1
    80003f60:	01f59593          	slli	a1,a1,0x1f
    80003f64:	00000097          	auipc	ra,0x0
    80003f68:	d4c080e7          	jalr	-692(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80003f6c:	00007997          	auipc	s3,0x7
    80003f70:	0ac9b983          	ld	s3,172(s3) # 8000b018 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003f74:	00700693          	li	a3,7
    80003f78:	00098613          	mv	a2,s3
    80003f7c:	000a0593          	mv	a1,s4
    80003f80:	0184b503          	ld	a0,24(s1)
    80003f84:	00000097          	auipc	ra,0x0
    80003f88:	d2c080e7          	jalr	-724(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80003f8c:	00007a17          	auipc	s4,0x7
    80003f90:	0aca3a03          	ld	s4,172(s4) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80003f94:	01b00693          	li	a3,27
    80003f98:	000a0613          	mv	a2,s4
    80003f9c:	00098593          	mv	a1,s3
    80003fa0:	0184b503          	ld	a0,24(s1)
    80003fa4:	00000097          	auipc	ra,0x0
    80003fa8:	d0c080e7          	jalr	-756(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80003fac:	00007997          	auipc	s3,0x7
    80003fb0:	fdc9b983          	ld	s3,-36(s3) # 8000af88 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003fb4:	01700693          	li	a3,23
    80003fb8:	00098613          	mv	a2,s3
    80003fbc:	000a0593          	mv	a1,s4
    80003fc0:	0184b503          	ld	a0,24(s1)
    80003fc4:	00000097          	auipc	ra,0x0
    80003fc8:	cec080e7          	jalr	-788(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_END, bEnd, 0x7);
    80003fcc:	00700693          	li	a3,7
    80003fd0:	00090613          	mv	a2,s2
    80003fd4:	00098593          	mv	a1,s3
    80003fd8:	0184b503          	ld	a0,24(s1)
    80003fdc:	00000097          	auipc	ra,0x0
    80003fe0:	cd4080e7          	jalr	-812(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, bEnd, HEAP_END, 0x17);
    80003fe4:	01700693          	li	a3,23
    80003fe8:	00007797          	auipc	a5,0x7
    80003fec:	0407b783          	ld	a5,64(a5) # 8000b028 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80003ff0:	0007b603          	ld	a2,0(a5)
    80003ff4:	00090593          	mv	a1,s2
    80003ff8:	0184b503          	ld	a0,24(s1)
    80003ffc:	00000097          	auipc	ra,0x0
    80004000:	cb4080e7          	jalr	-844(ra) # 80003cb0 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(uPMT);
    80004004:	0184b503          	ld	a0,24(s1)
    80004008:	00000097          	auipc	ra,0x0
    8000400c:	d1c080e7          	jalr	-740(ra) # 80003d24 <_ZN5RiscV19mapConsoleRegistersEPv>
    80004010:	000407b7          	lui	a5,0x40
    80004014:	1007a073          	csrs	sstatus,a5
}
    80004018:	02813083          	ld	ra,40(sp)
    8000401c:	02013403          	ld	s0,32(sp)
    80004020:	01813483          	ld	s1,24(sp)
    80004024:	01013903          	ld	s2,16(sp)
    80004028:	00813983          	ld	s3,8(sp)
    8000402c:	00013a03          	ld	s4,0(sp)
    80004030:	03010113          	addi	sp,sp,48
    80004034:	00008067          	ret

0000000080004038 <_ZN5RiscV10initializeEv>:
void RiscV::initialize(){
    80004038:	ff010113          	addi	sp,sp,-16
    8000403c:	00113423          	sd	ra,8(sp)
    80004040:	00813023          	sd	s0,0(sp)
    80004044:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80004048:	00007797          	auipc	a5,0x7
    8000404c:	fa07b783          	ld	a5,-96(a5) # 8000afe8 <_GLOBAL_OFFSET_TABLE_+0x90>
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80004050:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80004054:	00007797          	auipc	a5,0x7
    80004058:	f1c7b783          	ld	a5,-228(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000405c:	0007b503          	ld	a0,0(a5)
    80004060:	00c55513          	srli	a0,a0,0xc
    80004064:	00250513          	addi	a0,a0,2
    80004068:	000015b7          	lui	a1,0x1
    8000406c:	00c51513          	slli	a0,a0,0xc
    80004070:	00000097          	auipc	ra,0x0
    80004074:	32c080e7          	jalr	812(ra) # 8000439c <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80004078:	ffffe097          	auipc	ra,0xffffe
    8000407c:	218080e7          	jalr	536(ra) # 80002290 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80004080:	00000097          	auipc	ra,0x0
    80004084:	108080e7          	jalr	264(ra) # 80004188 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80004088:	ffffe097          	auipc	ra,0xffffe
    8000408c:	0b4080e7          	jalr	180(ra) # 8000213c <_ZN3TCB10initializeEv>
    SCB::initialize();
    80004090:	ffffd097          	auipc	ra,0xffffd
    80004094:	618080e7          	jalr	1560(ra) # 800016a8 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80004098:	ffffe097          	auipc	ra,0xffffe
    8000409c:	6a4080e7          	jalr	1700(ra) # 8000273c <_ZN11ConsoleUtil10initializeEv>
    RiscV::buildKernelPMT();
    800040a0:	00000097          	auipc	ra,0x0
    800040a4:	d18080e7          	jalr	-744(ra) # 80003db8 <_ZN5RiscV14buildKernelPMTEv>
    RiscV::buildUserPMT();
    800040a8:	00000097          	auipc	ra,0x0
    800040ac:	e50080e7          	jalr	-432(ra) # 80003ef8 <_ZN5RiscV12buildUserPMTEv>
    RiscV::initialized = true;
    800040b0:	00007797          	auipc	a5,0x7
    800040b4:	17878793          	addi	a5,a5,376 # 8000b228 <_ZN5RiscV16userMainFinishedE>
    800040b8:	00100713          	li	a4,1
    800040bc:	02e78023          	sb	a4,32(a5)
    RiscV::startVirtualMemory(RiscV::kPMT);
    800040c0:	0107b783          	ld	a5,16(a5)
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    800040c4:	00c7d793          	srli	a5,a5,0xc
    800040c8:	fff00713          	li	a4,-1
    800040cc:	03f71713          	slli	a4,a4,0x3f
    800040d0:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    800040d4:	18079073          	csrw	satp,a5
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    800040d8:	00200793          	li	a5,2
    800040dc:	1047a073          	csrs	sie,a5
    800040e0:	20000713          	li	a4,512
    800040e4:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800040e8:	1007a073          	csrs	sstatus,a5
}
    800040ec:	00813083          	ld	ra,8(sp)
    800040f0:	00013403          	ld	s0,0(sp)
    800040f4:	01010113          	addi	sp,sp,16
    800040f8:	00008067          	ret

00000000800040fc <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/kernel/utility.hpp"

char* strcpy(const char* src, char* dst){
    800040fc:	ff010113          	addi	sp,sp,-16
    80004100:	00813423          	sd	s0,8(sp)
    80004104:	01010413          	addi	s0,sp,16
    80004108:	00050793          	mv	a5,a0
    8000410c:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004110:	0007c703          	lbu	a4,0(a5)
    80004114:	00070a63          	beqz	a4,80004128 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004118:	00178793          	addi	a5,a5,1
    8000411c:	00e50023          	sb	a4,0(a0)
    80004120:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004124:	fedff06f          	j	80004110 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004128:	00e50023          	sb	a4,0(a0)
    return dst;
}
    8000412c:	00813403          	ld	s0,8(sp)
    80004130:	01010113          	addi	sp,sp,16
    80004134:	00008067          	ret

0000000080004138 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004138:	fe010113          	addi	sp,sp,-32
    8000413c:	00113c23          	sd	ra,24(sp)
    80004140:	00813823          	sd	s0,16(sp)
    80004144:	00913423          	sd	s1,8(sp)
    80004148:	02010413          	addi	s0,sp,32
    8000414c:	00050493          	mv	s1,a0
    80004150:	00058513          	mv	a0,a1
    char *dest = dst;
    80004154:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004158:	0005c783          	lbu	a5,0(a1) # 1000 <_entry-0x7ffff000>
    8000415c:	00078663          	beqz	a5,80004168 <_Z6strcatPcPKc+0x30>
        dest++;
    80004160:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004164:	ff5ff06f          	j	80004158 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004168:	00000097          	auipc	ra,0x0
    8000416c:	f94080e7          	jalr	-108(ra) # 800040fc <_Z6strcpyPKcPc>
    return dst;
    80004170:	00048513          	mv	a0,s1
    80004174:	01813083          	ld	ra,24(sp)
    80004178:	01013403          	ld	s0,16(sp)
    8000417c:	00813483          	ld	s1,8(sp)
    80004180:	02010113          	addi	sp,sp,32
    80004184:	00008067          	ret

0000000080004188 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004188:	ff010113          	addi	sp,sp,-16
    8000418c:	00813423          	sd	s0,8(sp)
    80004190:	01010413          	addi	s0,sp,16
}
    80004194:	00813403          	ld	s0,8(sp)
    80004198:	01010113          	addi	sp,sp,16
    8000419c:	00008067          	ret

00000000800041a0 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    800041a0:	ff010113          	addi	sp,sp,-16
    800041a4:	00813423          	sd	s0,8(sp)
    800041a8:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    800041ac:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800041b0:	00007797          	auipc	a5,0x7
    800041b4:	0a07b783          	ld	a5,160(a5) # 8000b250 <_ZN9Scheduler9readyHeadE>
    800041b8:	02078263          	beqz	a5,800041dc <_ZN9Scheduler3putEP3TCB+0x3c>
    800041bc:	00007797          	auipc	a5,0x7
    800041c0:	09c7b783          	ld	a5,156(a5) # 8000b258 <_ZN9Scheduler9readyTailE>
    800041c4:	04a7b423          	sd	a0,72(a5)
    800041c8:	00007797          	auipc	a5,0x7
    800041cc:	08a7b823          	sd	a0,144(a5) # 8000b258 <_ZN9Scheduler9readyTailE>
}
    800041d0:	00813403          	ld	s0,8(sp)
    800041d4:	01010113          	addi	sp,sp,16
    800041d8:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800041dc:	00007797          	auipc	a5,0x7
    800041e0:	06a7ba23          	sd	a0,116(a5) # 8000b250 <_ZN9Scheduler9readyHeadE>
    800041e4:	fe5ff06f          	j	800041c8 <_ZN9Scheduler3putEP3TCB+0x28>

00000000800041e8 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    800041e8:	ff010113          	addi	sp,sp,-16
    800041ec:	00813423          	sd	s0,8(sp)
    800041f0:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    800041f4:	00007517          	auipc	a0,0x7
    800041f8:	05c53503          	ld	a0,92(a0) # 8000b250 <_ZN9Scheduler9readyHeadE>
    800041fc:	00050a63          	beqz	a0,80004210 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004200:	04853783          	ld	a5,72(a0)
    80004204:	00007717          	auipc	a4,0x7
    80004208:	04f73623          	sd	a5,76(a4) # 8000b250 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    8000420c:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004210:	00813403          	ld	s0,8(sp)
    80004214:	01010113          	addi	sp,sp,16
    80004218:	00008067          	ret

000000008000421c <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    8000421c:	ff010113          	addi	sp,sp,-16
    80004220:	00813423          	sd	s0,8(sp)
    80004224:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004228:	00007797          	auipc	a5,0x7
    8000422c:	0387b783          	ld	a5,56(a5) # 8000b260 <_ZN9Scheduler12sleepingHeadE>
    80004230:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004234:	00078e63          	beqz	a5,80004250 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004238:	0587b683          	ld	a3,88(a5)
    8000423c:	05853703          	ld	a4,88(a0)
    80004240:	00d76863          	bltu	a4,a3,80004250 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004244:	00078613          	mv	a2,a5
    80004248:	0487b783          	ld	a5,72(a5)
    8000424c:	fe9ff06f          	j	80004234 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004250:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004254:	00060a63          	beqz	a2,80004268 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004258:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    8000425c:	00813403          	ld	s0,8(sp)
    80004260:	01010113          	addi	sp,sp,16
    80004264:	00008067          	ret
        sleepingHead = t;
    80004268:	00007797          	auipc	a5,0x7
    8000426c:	fea7bc23          	sd	a0,-8(a5) # 8000b260 <_ZN9Scheduler12sleepingHeadE>
}
    80004270:	fedff06f          	j	8000425c <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004274 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004274:	fe010113          	addi	sp,sp,-32
    80004278:	00113c23          	sd	ra,24(sp)
    8000427c:	00813823          	sd	s0,16(sp)
    80004280:	00913423          	sd	s1,8(sp)
    80004284:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004288:	00007497          	auipc	s1,0x7
    8000428c:	fd84b483          	ld	s1,-40(s1) # 8000b260 <_ZN9Scheduler12sleepingHeadE>
    80004290:	02048c63          	beqz	s1,800042c8 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004294:	0584b703          	ld	a4,88(s1)
    80004298:	00007797          	auipc	a5,0x7
    8000429c:	d987b783          	ld	a5,-616(a5) # 8000b030 <_GLOBAL_OFFSET_TABLE_+0xd8>
    800042a0:	0007b783          	ld	a5,0(a5)
    800042a4:	02e7e263          	bltu	a5,a4,800042c8 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    800042a8:	0484b783          	ld	a5,72(s1)
    800042ac:	00007717          	auipc	a4,0x7
    800042b0:	faf73a23          	sd	a5,-76(a4) # 8000b260 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    800042b4:	00048513          	mv	a0,s1
    800042b8:	00000097          	auipc	ra,0x0
    800042bc:	ee8080e7          	jalr	-280(ra) # 800041a0 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    800042c0:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    800042c4:	fc5ff06f          	j	80004288 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    800042c8:	01813083          	ld	ra,24(sp)
    800042cc:	01013403          	ld	s0,16(sp)
    800042d0:	00813483          	ld	s1,8(sp)
    800042d4:	02010113          	addi	sp,sp,32
    800042d8:	00008067          	ret

00000000800042dc <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    800042dc:	fe010113          	addi	sp,sp,-32
    800042e0:	00113c23          	sd	ra,24(sp)
    800042e4:	00813823          	sd	s0,16(sp)
    800042e8:	00913423          	sd	s1,8(sp)
    800042ec:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    800042f0:	00007497          	auipc	s1,0x7
    800042f4:	f604b483          	ld	s1,-160(s1) # 8000b250 <_ZN9Scheduler9readyHeadE>
    while(iter){
    800042f8:	02048863          	beqz	s1,80004328 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    800042fc:	00000613          	li	a2,0
    80004300:	01000593          	li	a1,16
    80004304:	0004851b          	sext.w	a0,s1
    80004308:	ffffe097          	auipc	ra,0xffffe
    8000430c:	754080e7          	jalr	1876(ra) # 80002a5c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004310:	00004517          	auipc	a0,0x4
    80004314:	e1050513          	addi	a0,a0,-496 # 80008120 <CONSOLE_STATUS+0x110>
    80004318:	ffffe097          	auipc	ra,0xffffe
    8000431c:	700080e7          	jalr	1792(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004320:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004324:	fd5ff06f          	j	800042f8 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004328:	01813083          	ld	ra,24(sp)
    8000432c:	01013403          	ld	s0,16(sp)
    80004330:	00813483          	ld	s1,8(sp)
    80004334:	02010113          	addi	sp,sp,32
    80004338:	00008067          	ret

000000008000433c <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    8000433c:	fe010113          	addi	sp,sp,-32
    80004340:	00113c23          	sd	ra,24(sp)
    80004344:	00813823          	sd	s0,16(sp)
    80004348:	00913423          	sd	s1,8(sp)
    8000434c:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004350:	00007497          	auipc	s1,0x7
    80004354:	f104b483          	ld	s1,-240(s1) # 8000b260 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004358:	02048863          	beqz	s1,80004388 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    8000435c:	00000613          	li	a2,0
    80004360:	01000593          	li	a1,16
    80004364:	0004851b          	sext.w	a0,s1
    80004368:	0000b097          	auipc	ra,0xb
    8000436c:	ab0080e7          	jalr	-1360(ra) # 8000ee18 <_Z8printIntiii>
        printString("\n");
    80004370:	00004517          	auipc	a0,0x4
    80004374:	db050513          	addi	a0,a0,-592 # 80008120 <CONSOLE_STATUS+0x110>
    80004378:	0000b097          	auipc	ra,0xb
    8000437c:	908080e7          	jalr	-1784(ra) # 8000ec80 <_Z11printStringPKc>
        iter = iter->next;
    80004380:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004384:	fd5ff06f          	j	80004358 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004388:	01813083          	ld	ra,24(sp)
    8000438c:	01013403          	ld	s0,16(sp)
    80004390:	00813483          	ld	s1,8(sp)
    80004394:	02010113          	addi	sp,sp,32
    80004398:	00008067          	ret

000000008000439c <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/kernel/slab.hpp"

void kmem_init(void* space, int block_num){
    8000439c:	ff010113          	addi	sp,sp,-16
    800043a0:	00113423          	sd	ra,8(sp)
    800043a4:	00813023          	sd	s0,0(sp)
    800043a8:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    800043ac:	00001097          	auipc	ra,0x1
    800043b0:	b34080e7          	jalr	-1228(ra) # 80004ee0 <_ZN13SlabAllocator10initializeEPvm>
}
    800043b4:	00813083          	ld	ra,8(sp)
    800043b8:	00013403          	ld	s0,0(sp)
    800043bc:	01010113          	addi	sp,sp,16
    800043c0:	00008067          	ret

00000000800043c4 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    800043c4:	ff010113          	addi	sp,sp,-16
    800043c8:	00113423          	sd	ra,8(sp)
    800043cc:	00813023          	sd	s0,0(sp)
    800043d0:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    800043d4:	00001097          	auipc	ra,0x1
    800043d8:	a00080e7          	jalr	-1536(ra) # 80004dd4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    800043dc:	00813083          	ld	ra,8(sp)
    800043e0:	00013403          	ld	s0,0(sp)
    800043e4:	01010113          	addi	sp,sp,16
    800043e8:	00008067          	ret

00000000800043ec <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    800043ec:	ff010113          	addi	sp,sp,-16
    800043f0:	00113423          	sd	ra,8(sp)
    800043f4:	00813023          	sd	s0,0(sp)
    800043f8:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    800043fc:	00000097          	auipc	ra,0x0
    80004400:	7a8080e7          	jalr	1960(ra) # 80004ba4 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004404:	00813083          	ld	ra,8(sp)
    80004408:	00013403          	ld	s0,0(sp)
    8000440c:	01010113          	addi	sp,sp,16
    80004410:	00008067          	ret

0000000080004414 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80004414:	ff010113          	addi	sp,sp,-16
    80004418:	00113423          	sd	ra,8(sp)
    8000441c:	00813023          	sd	s0,0(sp)
    80004420:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80004424:	00001097          	auipc	ra,0x1
    80004428:	d0c080e7          	jalr	-756(ra) # 80005130 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    8000442c:	00813083          	ld	ra,8(sp)
    80004430:	00013403          	ld	s0,0(sp)
    80004434:	01010113          	addi	sp,sp,16
    80004438:	00008067          	ret

000000008000443c <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    8000443c:	fe010113          	addi	sp,sp,-32
    80004440:	00113c23          	sd	ra,24(sp)
    80004444:	00813823          	sd	s0,16(sp)
    80004448:	02010413          	addi	s0,sp,32
    8000444c:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80004450:	fe840513          	addi	a0,s0,-24
    80004454:	00001097          	auipc	ra,0x1
    80004458:	e3c080e7          	jalr	-452(ra) # 80005290 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    8000445c:	01813083          	ld	ra,24(sp)
    80004460:	01013403          	ld	s0,16(sp)
    80004464:	02010113          	addi	sp,sp,32
    80004468:	00008067          	ret

000000008000446c <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    8000446c:	ff010113          	addi	sp,sp,-16
    80004470:	00113423          	sd	ra,8(sp)
    80004474:	00813023          	sd	s0,0(sp)
    80004478:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    8000447c:	00000097          	auipc	ra,0x0
    80004480:	25c080e7          	jalr	604(ra) # 800046d8 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80004484:	00813083          	ld	ra,8(sp)
    80004488:	00013403          	ld	s0,0(sp)
    8000448c:	01010113          	addi	sp,sp,16
    80004490:	00008067          	ret

0000000080004494 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80004494:	ff010113          	addi	sp,sp,-16
    80004498:	00113423          	sd	ra,8(sp)
    8000449c:	00813023          	sd	s0,0(sp)
    800044a0:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    800044a4:	00000097          	auipc	ra,0x0
    800044a8:	090080e7          	jalr	144(ra) # 80004534 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    800044ac:	00813083          	ld	ra,8(sp)
    800044b0:	00013403          	ld	s0,0(sp)
    800044b4:	01010113          	addi	sp,sp,16
    800044b8:	00008067          	ret

00000000800044bc <_Z7kmallocm>:
void* kmalloc(size_t size){
    800044bc:	ff010113          	addi	sp,sp,-16
    800044c0:	00113423          	sd	ra,8(sp)
    800044c4:	00813023          	sd	s0,0(sp)
    800044c8:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    800044cc:	00001097          	auipc	ra,0x1
    800044d0:	868080e7          	jalr	-1944(ra) # 80004d34 <_ZN13SlabAllocator14allocateBufferEm>
}
    800044d4:	00813083          	ld	ra,8(sp)
    800044d8:	00013403          	ld	s0,0(sp)
    800044dc:	01010113          	addi	sp,sp,16
    800044e0:	00008067          	ret

00000000800044e4 <_Z5kfreePKv>:

void kfree(const void* objp){
    800044e4:	ff010113          	addi	sp,sp,-16
    800044e8:	00113423          	sd	ra,8(sp)
    800044ec:	00813023          	sd	s0,0(sp)
    800044f0:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    800044f4:	00001097          	auipc	ra,0x1
    800044f8:	d30080e7          	jalr	-720(ra) # 80005224 <_ZN13SlabAllocator10freeBufferEPKv>
}
    800044fc:	00813083          	ld	ra,8(sp)
    80004500:	00013403          	ld	s0,0(sp)
    80004504:	01010113          	addi	sp,sp,16
    80004508:	00008067          	ret

000000008000450c <_Z16kmem_cache_errorP5Cache>:

int kmem_cache_error(kmem_cache_t* cachep){
    8000450c:	ff010113          	addi	sp,sp,-16
    80004510:	00113423          	sd	ra,8(sp)
    80004514:	00813023          	sd	s0,0(sp)
    80004518:	01010413          	addi	s0,sp,16
    return SlabAllocator::cacheErrorHandler(cachep);
    8000451c:	00001097          	auipc	ra,0x1
    80004520:	e50080e7          	jalr	-432(ra) # 8000536c <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache>
    80004524:	00813083          	ld	ra,8(sp)
    80004528:	00013403          	ld	s0,0(sp)
    8000452c:	01010113          	addi	sp,sp,16
    80004530:	00008067          	ret

0000000080004534 <_ZN13SlabAllocator11shrinkCacheEP5Cache>:
    deleteList(cache->emptyHead);
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    cache = nullptr;
}

int SlabAllocator::shrinkCache(Cache *cache) {
    80004534:	fe010113          	addi	sp,sp,-32
    80004538:	00113c23          	sd	ra,24(sp)
    8000453c:	00813823          	sd	s0,16(sp)
    80004540:	00913423          	sd	s1,8(sp)
    80004544:	01213023          	sd	s2,0(sp)
    80004548:	02010413          	addi	s0,sp,32
    8000454c:	00050493          	mv	s1,a0
    int ret = 0;
    80004550:	00000913          	li	s2,0
    while(cache->emptyHead){
    80004554:	0684b503          	ld	a0,104(s1)
    80004558:	02050463          	beqz	a0,80004580 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x4c>
        Buddy::free(cache->emptyHead, cache->slabSize);
    8000455c:	0484b583          	ld	a1,72(s1)
    80004560:	ffffd097          	auipc	ra,0xffffd
    80004564:	730080e7          	jalr	1840(ra) # 80001c90 <_ZN5Buddy4freeEPvm>
        ret += cache->emptyHead->totalNumOfSlots;
    80004568:	0684b783          	ld	a5,104(s1)
    8000456c:	0187b703          	ld	a4,24(a5)
    80004570:	0127093b          	addw	s2,a4,s2
        cache->emptyHead = cache->emptyHead->next;
    80004574:	0087b783          	ld	a5,8(a5)
    80004578:	06f4b423          	sd	a5,104(s1)
    while(cache->emptyHead){
    8000457c:	fd9ff06f          	j	80004554 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x20>
    }
    return ret;
}
    80004580:	00090513          	mv	a0,s2
    80004584:	01813083          	ld	ra,24(sp)
    80004588:	01013403          	ld	s0,16(sp)
    8000458c:	00813483          	ld	s1,8(sp)
    80004590:	00013903          	ld	s2,0(sp)
    80004594:	02010113          	addi	sp,sp,32
    80004598:	00008067          	ret

000000008000459c <_ZN13SlabAllocator9printSlabEP4Slab>:

void SlabAllocator::printSlab(Slab *slab) {
    if(slab) {
    8000459c:	12050c63          	beqz	a0,800046d4 <_ZN13SlabAllocator9printSlabEP4Slab+0x138>
void SlabAllocator::printSlab(Slab *slab) {
    800045a0:	fe010113          	addi	sp,sp,-32
    800045a4:	00113c23          	sd	ra,24(sp)
    800045a8:	00813823          	sd	s0,16(sp)
    800045ac:	00913423          	sd	s1,8(sp)
    800045b0:	01213023          	sd	s2,0(sp)
    800045b4:	02010413          	addi	s0,sp,32
    800045b8:	00050913          	mv	s2,a0
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    800045bc:	01000693          	li	a3,16
    800045c0:	00004617          	auipc	a2,0x4
    800045c4:	b6060613          	addi	a2,a2,-1184 # 80008120 <CONSOLE_STATUS+0x110>
    800045c8:	0005059b          	sext.w	a1,a0
    800045cc:	00004517          	auipc	a0,0x4
    800045d0:	d6c50513          	addi	a0,a0,-660 # 80008338 <CONSOLE_STATUS+0x328>
    800045d4:	ffffe097          	auipc	ra,0xffffe
    800045d8:	564080e7          	jalr	1380(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n",10);
    800045dc:	00a00693          	li	a3,10
    800045e0:	00004617          	auipc	a2,0x4
    800045e4:	b4060613          	addi	a2,a2,-1216 # 80008120 <CONSOLE_STATUS+0x110>
    800045e8:	01892583          	lw	a1,24(s2)
    800045ec:	00004517          	auipc	a0,0x4
    800045f0:	d5c50513          	addi	a0,a0,-676 # 80008348 <CONSOLE_STATUS+0x338>
    800045f4:	ffffe097          	auipc	ra,0xffffe
    800045f8:	544080e7          	jalr	1348(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n",10);
    800045fc:	00a00693          	li	a3,10
    80004600:	00004617          	auipc	a2,0x4
    80004604:	b2060613          	addi	a2,a2,-1248 # 80008120 <CONSOLE_STATUS+0x110>
    80004608:	01092583          	lw	a1,16(s2)
    8000460c:	00004517          	auipc	a0,0x4
    80004610:	d5450513          	addi	a0,a0,-684 # 80008360 <CONSOLE_STATUS+0x350>
    80004614:	ffffe097          	auipc	ra,0xffffe
    80004618:	524080e7          	jalr	1316(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n",10);
    8000461c:	00a00693          	li	a3,10
    80004620:	00004617          	auipc	a2,0x4
    80004624:	b0060613          	addi	a2,a2,-1280 # 80008120 <CONSOLE_STATUS+0x110>
    80004628:	0b000593          	li	a1,176
    8000462c:	00004517          	auipc	a0,0x4
    80004630:	d4c50513          	addi	a0,a0,-692 # 80008378 <CONSOLE_STATUS+0x368>
    80004634:	ffffe097          	auipc	ra,0xffffe
    80004638:	504080e7          	jalr	1284(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000463c:	01000693          	li	a3,16
    80004640:	00004617          	auipc	a2,0x4
    80004644:	ae060613          	addi	a2,a2,-1312 # 80008120 <CONSOLE_STATUS+0x110>
    80004648:	0a092583          	lw	a1,160(s2)
    8000464c:	00004517          	auipc	a0,0x4
    80004650:	d4450513          	addi	a0,a0,-700 # 80008390 <CONSOLE_STATUS+0x380>
    80004654:	ffffe097          	auipc	ra,0xffffe
    80004658:	4e4080e7          	jalr	1252(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array: ");
    8000465c:	00004517          	auipc	a0,0x4
    80004660:	d4450513          	addi	a0,a0,-700 # 800083a0 <CONSOLE_STATUS+0x390>
    80004664:	ffffe097          	auipc	ra,0xffffe
    80004668:	3b4080e7          	jalr	948(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)>>3; i++) {
    8000466c:	00000493          	li	s1,0
    80004670:	02c0006f          	j	8000469c <_ZN13SlabAllocator9printSlabEP4Slab+0x100>
            ConsoleUtil::print("", slab->allocated[i], " ");
    80004674:	009907b3          	add	a5,s2,s1
    80004678:	01000693          	li	a3,16
    8000467c:	00004617          	auipc	a2,0x4
    80004680:	d7460613          	addi	a2,a2,-652 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80004684:	0207c583          	lbu	a1,32(a5)
    80004688:	00004517          	auipc	a0,0x4
    8000468c:	af050513          	addi	a0,a0,-1296 # 80008178 <CONSOLE_STATUS+0x168>
    80004690:	ffffe097          	auipc	ra,0xffffe
    80004694:	4a8080e7          	jalr	1192(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)>>3; i++) {
    80004698:	00148493          	addi	s1,s1,1
    8000469c:	01893783          	ld	a5,24(s2)
    800046a0:	00778793          	addi	a5,a5,7
    800046a4:	0037d793          	srli	a5,a5,0x3
    800046a8:	fcf4e6e3          	bltu	s1,a5,80004674 <_ZN13SlabAllocator9printSlabEP4Slab+0xd8>
        }
        ConsoleUtil::printString("\n");
    800046ac:	00004517          	auipc	a0,0x4
    800046b0:	a7450513          	addi	a0,a0,-1420 # 80008120 <CONSOLE_STATUS+0x110>
    800046b4:	ffffe097          	auipc	ra,0xffffe
    800046b8:	364080e7          	jalr	868(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    800046bc:	01813083          	ld	ra,24(sp)
    800046c0:	01013403          	ld	s0,16(sp)
    800046c4:	00813483          	ld	s1,8(sp)
    800046c8:	00013903          	ld	s2,0(sp)
    800046cc:	02010113          	addi	sp,sp,32
    800046d0:	00008067          	ret
    800046d4:	00008067          	ret

00000000800046d8 <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    800046d8:	fe010113          	addi	sp,sp,-32
    800046dc:	00113c23          	sd	ra,24(sp)
    800046e0:	00813823          	sd	s0,16(sp)
    800046e4:	00913423          	sd	s1,8(sp)
    800046e8:	01213023          	sd	s2,0(sp)
    800046ec:	02010413          	addi	s0,sp,32
    800046f0:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    800046f4:	00004517          	auipc	a0,0x4
    800046f8:	ccc50513          	addi	a0,a0,-820 # 800083c0 <CONSOLE_STATUS+0x3b0>
    800046fc:	ffffe097          	auipc	ra,0xffffe
    80004700:	31c080e7          	jalr	796(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80004704:	00090513          	mv	a0,s2
    80004708:	ffffe097          	auipc	ra,0xffffe
    8000470c:	310080e7          	jalr	784(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80004710:	00004517          	auipc	a0,0x4
    80004714:	a1050513          	addi	a0,a0,-1520 # 80008120 <CONSOLE_STATUS+0x110>
    80004718:	ffffe097          	auipc	ra,0xffffe
    8000471c:	300080e7          	jalr	768(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80004720:	01000693          	li	a3,16
    80004724:	00004617          	auipc	a2,0x4
    80004728:	9fc60613          	addi	a2,a2,-1540 # 80008120 <CONSOLE_STATUS+0x110>
    8000472c:	0009059b          	sext.w	a1,s2
    80004730:	00004517          	auipc	a0,0x4
    80004734:	ca050513          	addi	a0,a0,-864 # 800083d0 <CONSOLE_STATUS+0x3c0>
    80004738:	ffffe097          	auipc	ra,0xffffe
    8000473c:	400080e7          	jalr	1024(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n",10);
    80004740:	00a00693          	li	a3,10
    80004744:	00004617          	auipc	a2,0x4
    80004748:	9dc60613          	addi	a2,a2,-1572 # 80008120 <CONSOLE_STATUS+0x110>
    8000474c:	04892583          	lw	a1,72(s2)
    80004750:	00004517          	auipc	a0,0x4
    80004754:	c9050513          	addi	a0,a0,-880 # 800083e0 <CONSOLE_STATUS+0x3d0>
    80004758:	ffffe097          	auipc	ra,0xffffe
    8000475c:	3e0080e7          	jalr	992(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n",10);
    80004760:	00a00693          	li	a3,10
    80004764:	00004617          	auipc	a2,0x4
    80004768:	9bc60613          	addi	a2,a2,-1604 # 80008120 <CONSOLE_STATUS+0x110>
    8000476c:	04092583          	lw	a1,64(s2)
    80004770:	00004517          	auipc	a0,0x4
    80004774:	c8850513          	addi	a0,a0,-888 # 800083f8 <CONSOLE_STATUS+0x3e8>
    80004778:	ffffe097          	auipc	ra,0xffffe
    8000477c:	3c0080e7          	jalr	960(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    80004780:	01000693          	li	a3,16
    80004784:	00004617          	auipc	a2,0x4
    80004788:	99c60613          	addi	a2,a2,-1636 # 80008120 <CONSOLE_STATUS+0x110>
    8000478c:	06892583          	lw	a1,104(s2)
    80004790:	00004517          	auipc	a0,0x4
    80004794:	c8050513          	addi	a0,a0,-896 # 80008410 <CONSOLE_STATUS+0x400>
    80004798:	ffffe097          	auipc	ra,0xffffe
    8000479c:	3a0080e7          	jalr	928(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>

    Slab* iter = cache->emptyHead;
    800047a0:	06893483          	ld	s1,104(s2)
    while(iter){
    800047a4:	02048663          	beqz	s1,800047d0 <_ZN13SlabAllocator10printCacheEP5Cache+0xf8>
        ConsoleUtil::print("", (uint64)iter, " ");
    800047a8:	01000693          	li	a3,16
    800047ac:	00004617          	auipc	a2,0x4
    800047b0:	c4460613          	addi	a2,a2,-956 # 800083f0 <CONSOLE_STATUS+0x3e0>
    800047b4:	0004859b          	sext.w	a1,s1
    800047b8:	00004517          	auipc	a0,0x4
    800047bc:	9c050513          	addi	a0,a0,-1600 # 80008178 <CONSOLE_STATUS+0x168>
    800047c0:	ffffe097          	auipc	ra,0xffffe
    800047c4:	378080e7          	jalr	888(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800047c8:	0084b483          	ld	s1,8(s1)
    while(iter){
    800047cc:	fd9ff06f          	j	800047a4 <_ZN13SlabAllocator10printCacheEP5Cache+0xcc>
    }
    ConsoleUtil::printString("\n");
    800047d0:	00004517          	auipc	a0,0x4
    800047d4:	95050513          	addi	a0,a0,-1712 # 80008120 <CONSOLE_STATUS+0x110>
    800047d8:	ffffe097          	auipc	ra,0xffffe
    800047dc:	240080e7          	jalr	576(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    800047e0:	01000693          	li	a3,16
    800047e4:	00004617          	auipc	a2,0x4
    800047e8:	93c60613          	addi	a2,a2,-1732 # 80008120 <CONSOLE_STATUS+0x110>
    800047ec:	07092583          	lw	a1,112(s2)
    800047f0:	00004517          	auipc	a0,0x4
    800047f4:	c3050513          	addi	a0,a0,-976 # 80008420 <CONSOLE_STATUS+0x410>
    800047f8:	ffffe097          	auipc	ra,0xffffe
    800047fc:	340080e7          	jalr	832(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->partialHead;
    80004800:	07093483          	ld	s1,112(s2)
    while(iter){
    80004804:	02048663          	beqz	s1,80004830 <_ZN13SlabAllocator10printCacheEP5Cache+0x158>
        ConsoleUtil::print("", (uint64)iter, " ");
    80004808:	01000693          	li	a3,16
    8000480c:	00004617          	auipc	a2,0x4
    80004810:	be460613          	addi	a2,a2,-1052 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80004814:	0004859b          	sext.w	a1,s1
    80004818:	00004517          	auipc	a0,0x4
    8000481c:	96050513          	addi	a0,a0,-1696 # 80008178 <CONSOLE_STATUS+0x168>
    80004820:	ffffe097          	auipc	ra,0xffffe
    80004824:	318080e7          	jalr	792(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80004828:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000482c:	fd9ff06f          	j	80004804 <_ZN13SlabAllocator10printCacheEP5Cache+0x12c>
    }
    ConsoleUtil::printString("\n");
    80004830:	00004517          	auipc	a0,0x4
    80004834:	8f050513          	addi	a0,a0,-1808 # 80008120 <CONSOLE_STATUS+0x110>
    80004838:	ffffe097          	auipc	ra,0xffffe
    8000483c:	1e0080e7          	jalr	480(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80004840:	01000693          	li	a3,16
    80004844:	00004617          	auipc	a2,0x4
    80004848:	8dc60613          	addi	a2,a2,-1828 # 80008120 <CONSOLE_STATUS+0x110>
    8000484c:	07892583          	lw	a1,120(s2)
    80004850:	00004517          	auipc	a0,0x4
    80004854:	be050513          	addi	a0,a0,-1056 # 80008430 <CONSOLE_STATUS+0x420>
    80004858:	ffffe097          	auipc	ra,0xffffe
    8000485c:	2e0080e7          	jalr	736(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->fullHead;
    80004860:	07893483          	ld	s1,120(s2)
    while(iter){
    80004864:	02048663          	beqz	s1,80004890 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
        ConsoleUtil::print("", (uint64)iter, " ");
    80004868:	01000693          	li	a3,16
    8000486c:	00004617          	auipc	a2,0x4
    80004870:	b8460613          	addi	a2,a2,-1148 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80004874:	0004859b          	sext.w	a1,s1
    80004878:	00004517          	auipc	a0,0x4
    8000487c:	90050513          	addi	a0,a0,-1792 # 80008178 <CONSOLE_STATUS+0x168>
    80004880:	ffffe097          	auipc	ra,0xffffe
    80004884:	2b8080e7          	jalr	696(ra) # 80002b38 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80004888:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000488c:	fd9ff06f          	j	80004864 <_ZN13SlabAllocator10printCacheEP5Cache+0x18c>
    }
    ConsoleUtil::printString("\n");
    80004890:	00004517          	auipc	a0,0x4
    80004894:	89050513          	addi	a0,a0,-1904 # 80008120 <CONSOLE_STATUS+0x110>
    80004898:	ffffe097          	auipc	ra,0xffffe
    8000489c:	180080e7          	jalr	384(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
}
    800048a0:	01813083          	ld	ra,24(sp)
    800048a4:	01013403          	ld	s0,16(sp)
    800048a8:	00813483          	ld	s1,8(sp)
    800048ac:	00013903          	ld	s2,0(sp)
    800048b0:	02010113          	addi	sp,sp,32
    800048b4:	00008067          	ret

00000000800048b8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    800048b8:	ff010113          	addi	sp,sp,-16
    800048bc:	00813423          	sd	s0,8(sp)
    800048c0:	01010413          	addi	s0,sp,16
    slab->next = head;
    800048c4:	00053783          	ld	a5,0(a0)
    800048c8:	00f5b423          	sd	a5,8(a1)
    if(head)
    800048cc:	00078463          	beqz	a5,800048d4 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    800048d0:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    800048d4:	0005b023          	sd	zero,0(a1)
    head = slab;
    800048d8:	00b53023          	sd	a1,0(a0)
}
    800048dc:	00813403          	ld	s0,8(sp)
    800048e0:	01010113          	addi	sp,sp,16
    800048e4:	00008067          	ret

00000000800048e8 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    800048e8:	fd010113          	addi	sp,sp,-48
    800048ec:	02113423          	sd	ra,40(sp)
    800048f0:	02813023          	sd	s0,32(sp)
    800048f4:	00913c23          	sd	s1,24(sp)
    800048f8:	01213823          	sd	s2,16(sp)
    800048fc:	01313423          	sd	s3,8(sp)
    80004900:	03010413          	addi	s0,sp,48
    80004904:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    80004908:	04853503          	ld	a0,72(a0)
    8000490c:	ffffd097          	auipc	ra,0xffffd
    80004910:	45c080e7          	jalr	1116(ra) # 80001d68 <_ZN5Buddy5allocEm>
    if(!slab) {
    80004914:	08050063          	beqz	a0,80004994 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xac>
    80004918:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    8000491c:	00050593          	mv	a1,a0
    80004920:	06898513          	addi	a0,s3,104
    80004924:	00000097          	auipc	ra,0x0
    80004928:	f94080e7          	jalr	-108(ra) # 800048b8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    8000492c:	0489b703          	ld	a4,72(s3)
    80004930:	00100793          	li	a5,1
    80004934:	00e797bb          	sllw	a5,a5,a4
    80004938:	00c7979b          	slliw	a5,a5,0xc
    8000493c:	f5078793          	addi	a5,a5,-176
    80004940:	0409b703          	ld	a4,64(s3)
    80004944:	02e7d7b3          	divu	a5,a5,a4
    80004948:	00f4b823          	sd	a5,16(s1)
    8000494c:	00f4bc23          	sd	a5,24(s1)
    if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
    80004950:	40000713          	li	a4,1024
    80004954:	00f77863          	bgeu	a4,a5,80004964 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x7c>
        slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    80004958:	40000793          	li	a5,1024
    8000495c:	00f4b823          	sd	a5,16(s1)
    80004960:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab));
    80004964:	0b048793          	addi	a5,s1,176
    80004968:	0af4b023          	sd	a5,160(s1)
    slab->parent = cache;
    8000496c:	0b34b423          	sd	s3,168(s1)
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
    80004970:	00000713          	li	a4,0
    80004974:	0184b783          	ld	a5,24(s1)
    80004978:	00778793          	addi	a5,a5,7
    8000497c:	0037d793          	srli	a5,a5,0x3
    80004980:	02f77263          	bgeu	a4,a5,800049a4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xbc>
        slab->allocated[i] = 0;
    80004984:	00e487b3          	add	a5,s1,a4
    80004988:	02078023          	sb	zero,32(a5)
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
    8000498c:	00170713          	addi	a4,a4,1
    80004990:	fe5ff06f          	j	80004974 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x8c>
        cache->errCode = 2;
    80004994:	00200793          	li	a5,2
    80004998:	04f9b823          	sd	a5,80(s3)
        return false;
    8000499c:	00000513          	li	a0,0
    800049a0:	0480006f          	j	800049e8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x100>
    if(cache->ctor) {
    800049a4:	0589b783          	ld	a5,88(s3)
    800049a8:	02078a63          	beqz	a5,800049dc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800049ac:	00000913          	li	s2,0
    800049b0:	0184b783          	ld	a5,24(s1)
    800049b4:	02f97863          	bgeu	s2,a5,800049e4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xfc>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800049b8:	0589b703          	ld	a4,88(s3)
    800049bc:	0a04b503          	ld	a0,160(s1)
    800049c0:	0a84b783          	ld	a5,168(s1)
    800049c4:	0407b783          	ld	a5,64(a5)
    800049c8:	032787b3          	mul	a5,a5,s2
    800049cc:	00f50533          	add	a0,a0,a5
    800049d0:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800049d4:	00190913          	addi	s2,s2,1
    800049d8:	fd9ff06f          	j	800049b0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xc8>
    return true;
    800049dc:	00100513          	li	a0,1
    800049e0:	0080006f          	j	800049e8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x100>
    800049e4:	00100513          	li	a0,1
}
    800049e8:	02813083          	ld	ra,40(sp)
    800049ec:	02013403          	ld	s0,32(sp)
    800049f0:	01813483          	ld	s1,24(sp)
    800049f4:	01013903          	ld	s2,16(sp)
    800049f8:	00813983          	ld	s3,8(sp)
    800049fc:	03010113          	addi	sp,sp,48
    80004a00:	00008067          	ret

0000000080004a04 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80004a04:	ff010113          	addi	sp,sp,-16
    80004a08:	00813423          	sd	s0,8(sp)
    80004a0c:	01010413          	addi	s0,sp,16
    if(slab == head)
    80004a10:	00053783          	ld	a5,0(a0)
    80004a14:	02b78c63          	beq	a5,a1,80004a4c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80004a18:	0085b783          	ld	a5,8(a1)
    80004a1c:	00078663          	beqz	a5,80004a28 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    80004a20:	0005b703          	ld	a4,0(a1)
    80004a24:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80004a28:	0005b783          	ld	a5,0(a1)
    80004a2c:	00078663          	beqz	a5,80004a38 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    80004a30:	0085b703          	ld	a4,8(a1)
    80004a34:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80004a38:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80004a3c:	0005b423          	sd	zero,8(a1)
}
    80004a40:	00813403          	ld	s0,8(sp)
    80004a44:	01010113          	addi	sp,sp,16
    80004a48:	00008067          	ret
        head = slab->next;
    80004a4c:	0085b783          	ld	a5,8(a1)
    80004a50:	00f53023          	sd	a5,0(a0)
    80004a54:	fc5ff06f          	j	80004a18 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

0000000080004a58 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    80004a58:	fe010113          	addi	sp,sp,-32
    80004a5c:	00113c23          	sd	ra,24(sp)
    80004a60:	00813823          	sd	s0,16(sp)
    80004a64:	00913423          	sd	s1,8(sp)
    80004a68:	01213023          	sd	s2,0(sp)
    80004a6c:	02010413          	addi	s0,sp,32
    80004a70:	00058913          	mv	s2,a1
    80004a74:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    80004a78:	00060593          	mv	a1,a2
    80004a7c:	00000097          	auipc	ra,0x0
    80004a80:	f88080e7          	jalr	-120(ra) # 80004a04 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    80004a84:	00048593          	mv	a1,s1
    80004a88:	00090513          	mv	a0,s2
    80004a8c:	00000097          	auipc	ra,0x0
    80004a90:	e2c080e7          	jalr	-468(ra) # 800048b8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
}
    80004a94:	01813083          	ld	ra,24(sp)
    80004a98:	01013403          	ld	s0,16(sp)
    80004a9c:	00813483          	ld	s1,8(sp)
    80004aa0:	00013903          	ld	s2,0(sp)
    80004aa4:	02010113          	addi	sp,sp,32
    80004aa8:	00008067          	ret

0000000080004aac <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    80004aac:	fe010113          	addi	sp,sp,-32
    80004ab0:	00113c23          	sd	ra,24(sp)
    80004ab4:	00813823          	sd	s0,16(sp)
    80004ab8:	00913423          	sd	s1,8(sp)
    80004abc:	01213023          	sd	s2,0(sp)
    80004ac0:	02010413          	addi	s0,sp,32
    80004ac4:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80004ac8:	00000493          	li	s1,0
    80004acc:	01893683          	ld	a3,24(s2)
    80004ad0:	0ad4f663          	bgeu	s1,a3,80004b7c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd0>
        if(!(slab->allocated[i>>3] & (1<<(7 - (i&7))))){
    80004ad4:	0034d613          	srli	a2,s1,0x3
    80004ad8:	00c907b3          	add	a5,s2,a2
    80004adc:	0207c583          	lbu	a1,32(a5)
    80004ae0:	fff4c793          	not	a5,s1
    80004ae4:	0077f793          	andi	a5,a5,7
    80004ae8:	40f5d73b          	sraw	a4,a1,a5
    80004aec:	00177713          	andi	a4,a4,1
    80004af0:	00070663          	beqz	a4,80004afc <_ZN13SlabAllocator12allocateSlotEP4Slab+0x50>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80004af4:	00148493          	addi	s1,s1,1
    80004af8:	fd5ff06f          	j	80004acc <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i>>3] |= (1<<(7 - (i&7)));
    80004afc:	00100713          	li	a4,1
    80004b00:	00f717bb          	sllw	a5,a4,a5
    80004b04:	00c90633          	add	a2,s2,a2
    80004b08:	00f5e5b3          	or	a1,a1,a5
    80004b0c:	02b60023          	sb	a1,32(a2)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80004b10:	01093783          	ld	a5,16(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004b14:	04f68863          	beq	a3,a5,80004b64 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb8>
    80004b18:	0a893503          	ld	a0,168(s2)
    80004b1c:	07050513          	addi	a0,a0,112
            slab->numOfFreeSlots--;
    80004b20:	fff78793          	addi	a5,a5,-1
    80004b24:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004b28:	04079463          	bnez	a5,80004b70 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc4>
    80004b2c:	0a893583          	ld	a1,168(s2)
    80004b30:	07858593          	addi	a1,a1,120
            if(headTo != headFrom)
    80004b34:	0005b703          	ld	a4,0(a1)
    80004b38:	00053783          	ld	a5,0(a0)
    80004b3c:	00f70863          	beq	a4,a5,80004b4c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa0>
                SlabAllocator::move(headFrom, headTo, slab);
    80004b40:	00090613          	mv	a2,s2
    80004b44:	00000097          	auipc	ra,0x0
    80004b48:	f14080e7          	jalr	-236(ra) # 80004a58 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    80004b4c:	0a093503          	ld	a0,160(s2)
    80004b50:	0a893783          	ld	a5,168(s2)
    80004b54:	0407b783          	ld	a5,64(a5)
    80004b58:	029784b3          	mul	s1,a5,s1
    80004b5c:	00950533          	add	a0,a0,s1
    80004b60:	02c0006f          	j	80004b8c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xe0>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004b64:	0a893503          	ld	a0,168(s2)
    80004b68:	06850513          	addi	a0,a0,104
    80004b6c:	fb5ff06f          	j	80004b20 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x74>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004b70:	0a893583          	ld	a1,168(s2)
    80004b74:	07058593          	addi	a1,a1,112
    80004b78:	fbdff06f          	j	80004b34 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x88>
    slab->parent->errCode = 1;
    80004b7c:	0a893783          	ld	a5,168(s2)
    80004b80:	00100713          	li	a4,1
    80004b84:	04e7b823          	sd	a4,80(a5)
    return nullptr;
    80004b88:	00000513          	li	a0,0
}
    80004b8c:	01813083          	ld	ra,24(sp)
    80004b90:	01013403          	ld	s0,16(sp)
    80004b94:	00813483          	ld	s1,8(sp)
    80004b98:	00013903          	ld	s2,0(sp)
    80004b9c:	02010113          	addi	sp,sp,32
    80004ba0:	00008067          	ret

0000000080004ba4 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    80004ba4:	fd010113          	addi	sp,sp,-48
    80004ba8:	02113423          	sd	ra,40(sp)
    80004bac:	02813023          	sd	s0,32(sp)
    80004bb0:	00913c23          	sd	s1,24(sp)
    80004bb4:	01213823          	sd	s2,16(sp)
    80004bb8:	01313423          	sd	s3,8(sp)
    80004bbc:	03010413          	addi	s0,sp,48
    80004bc0:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    80004bc4:	07053483          	ld	s1,112(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    80004bc8:	00048c63          	beqz	s1,80004be0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
            void* ret = allocateSlot(head);
    80004bcc:	00048513          	mv	a0,s1
    80004bd0:	00000097          	auipc	ra,0x0
    80004bd4:	edc080e7          	jalr	-292(ra) # 80004aac <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80004bd8:	fe0508e3          	beqz	a0,80004bc8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x24>
                return ret;
    80004bdc:	00050493          	mv	s1,a0
    if(ret){
    80004be0:	02048263          	beqz	s1,80004c04 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x60>
}
    80004be4:	00048513          	mv	a0,s1
    80004be8:	02813083          	ld	ra,40(sp)
    80004bec:	02013403          	ld	s0,32(sp)
    80004bf0:	01813483          	ld	s1,24(sp)
    80004bf4:	01013903          	ld	s2,16(sp)
    80004bf8:	00813983          	ld	s3,8(sp)
    80004bfc:	03010113          	addi	sp,sp,48
    80004c00:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80004c04:	06893483          	ld	s1,104(s2)
        while(head != nullptr){
    80004c08:	00048c63          	beqz	s1,80004c20 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x7c>
            void* ret = allocateSlot(head);
    80004c0c:	00048513          	mv	a0,s1
    80004c10:	00000097          	auipc	ra,0x0
    80004c14:	e9c080e7          	jalr	-356(ra) # 80004aac <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80004c18:	fe0508e3          	beqz	a0,80004c08 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x64>
                return ret;
    80004c1c:	00050493          	mv	s1,a0
    if(ret){
    80004c20:	fc0492e3          	bnez	s1,80004be4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
    if(cache->objectSize <= sizeof(Slab)) {
    80004c24:	04093703          	ld	a4,64(s2)
    80004c28:	0b000793          	li	a5,176
    80004c2c:	02e7e463          	bltu	a5,a4,80004c54 <_ZN13SlabAllocator14allocateObjectEP5Cache+0xb0>
        if (!SlabAllocator::allocateSlab(cache))
    80004c30:	00090513          	mv	a0,s2
    80004c34:	00000097          	auipc	ra,0x0
    80004c38:	cb4080e7          	jalr	-844(ra) # 800048e8 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80004c3c:	fa0504e3          	beqz	a0,80004be4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80004c40:	06893503          	ld	a0,104(s2)
    80004c44:	00000097          	auipc	ra,0x0
    80004c48:	e68080e7          	jalr	-408(ra) # 80004aac <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80004c4c:	00050493          	mv	s1,a0
    80004c50:	f95ff06f          	j	80004be4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        Slab* slab = (Slab*)SlabAllocator::allocateObject(largeSlabCache);
    80004c54:	00006517          	auipc	a0,0x6
    80004c58:	61453503          	ld	a0,1556(a0) # 8000b268 <_ZN13SlabAllocator14largeSlabCacheE>
    80004c5c:	00000097          	auipc	ra,0x0
    80004c60:	f48080e7          	jalr	-184(ra) # 80004ba4 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80004c64:	00050493          	mv	s1,a0
        slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS)) / cache->objectSize;
    80004c68:	04893703          	ld	a4,72(s2)
    80004c6c:	00100793          	li	a5,1
    80004c70:	00e797bb          	sllw	a5,a5,a4
    80004c74:	00c7979b          	slliw	a5,a5,0xc
    80004c78:	04093703          	ld	a4,64(s2)
    80004c7c:	02e7d7b3          	divu	a5,a5,a4
    80004c80:	00f53823          	sd	a5,16(a0)
    80004c84:	00f53c23          	sd	a5,24(a0)
        if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
    80004c88:	40000713          	li	a4,1024
    80004c8c:	00f77863          	bgeu	a4,a5,80004c9c <_ZN13SlabAllocator14allocateObjectEP5Cache+0xf8>
            slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    80004c90:	40000793          	li	a5,1024
    80004c94:	00f53823          	sd	a5,16(a0)
    80004c98:	00f53c23          	sd	a5,24(a0)
        void* slabOffset = Buddy::alloc(cache->slabSize);
    80004c9c:	04893503          	ld	a0,72(s2)
    80004ca0:	ffffd097          	auipc	ra,0xffffd
    80004ca4:	0c8080e7          	jalr	200(ra) # 80001d68 <_ZN5Buddy5allocEm>
        slab->objectOffset = slabOffset;
    80004ca8:	0aa4b023          	sd	a0,160(s1)
        slab->parent = cache;
    80004cac:	0b24b423          	sd	s2,168(s1)
        slab->next = nullptr;
    80004cb0:	0004b423          	sd	zero,8(s1)
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
    80004cb4:	00000713          	li	a4,0
    80004cb8:	0184b783          	ld	a5,24(s1)
    80004cbc:	00778793          	addi	a5,a5,7
    80004cc0:	0037d793          	srli	a5,a5,0x3
    80004cc4:	00f77a63          	bgeu	a4,a5,80004cd8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x134>
            slab->allocated[i] = 0;
    80004cc8:	00e487b3          	add	a5,s1,a4
    80004ccc:	02078023          	sb	zero,32(a5)
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
    80004cd0:	00170713          	addi	a4,a4,1
    80004cd4:	fe5ff06f          	j	80004cb8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x114>
        if(cache->ctor) {
    80004cd8:	05893783          	ld	a5,88(s2)
    80004cdc:	02078a63          	beqz	a5,80004d10 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x16c>
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004ce0:	00000993          	li	s3,0
    80004ce4:	0184b783          	ld	a5,24(s1)
    80004ce8:	02f9f463          	bgeu	s3,a5,80004d10 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x16c>
                cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    80004cec:	05893703          	ld	a4,88(s2)
    80004cf0:	0a04b503          	ld	a0,160(s1)
    80004cf4:	0a84b783          	ld	a5,168(s1)
    80004cf8:	0407b783          	ld	a5,64(a5)
    80004cfc:	033787b3          	mul	a5,a5,s3
    80004d00:	00f50533          	add	a0,a0,a5
    80004d04:	000700e7          	jalr	a4
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004d08:	00198993          	addi	s3,s3,1
    80004d0c:	fd9ff06f          	j	80004ce4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x140>
        SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80004d10:	00048593          	mv	a1,s1
    80004d14:	06890513          	addi	a0,s2,104
    80004d18:	00000097          	auipc	ra,0x0
    80004d1c:	ba0080e7          	jalr	-1120(ra) # 800048b8 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80004d20:	06893503          	ld	a0,104(s2)
    80004d24:	00000097          	auipc	ra,0x0
    80004d28:	d88080e7          	jalr	-632(ra) # 80004aac <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80004d2c:	00050493          	mv	s1,a0
    80004d30:	eb5ff06f          	j	80004be4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>

0000000080004d34 <_ZN13SlabAllocator14allocateBufferEm>:
        num--;
    80004d34:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80004d38:	0017d513          	srli	a0,a5,0x1
    80004d3c:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80004d40:	0027d713          	srli	a4,a5,0x2
    80004d44:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80004d48:	0047d713          	srli	a4,a5,0x4
    80004d4c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80004d50:	0087d713          	srli	a4,a5,0x8
    80004d54:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80004d58:	0107d713          	srli	a4,a5,0x10
    80004d5c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80004d60:	0207d713          	srli	a4,a5,0x20
    80004d64:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80004d68:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80004d6c:	00000713          	li	a4,0
        while(num>1){
    80004d70:	00100693          	li	a3,1
    80004d74:	00f6f863          	bgeu	a3,a5,80004d84 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    80004d78:	0017d793          	srli	a5,a5,0x1
            deg++;
    80004d7c:	00170713          	addi	a4,a4,1
        while(num>1){
    80004d80:	ff1ff06f          	j	80004d70 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    80004d84:	ffb70713          	addi	a4,a4,-5
    80004d88:	00c00793          	li	a5,12
    80004d8c:	04e7e063          	bltu	a5,a4,80004dcc <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    80004d90:	ff010113          	addi	sp,sp,-16
    80004d94:	00113423          	sd	ra,8(sp)
    80004d98:	00813023          	sd	s0,0(sp)
    80004d9c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    80004da0:	00371713          	slli	a4,a4,0x3
    80004da4:	00006797          	auipc	a5,0x6
    80004da8:	4c478793          	addi	a5,a5,1220 # 8000b268 <_ZN13SlabAllocator14largeSlabCacheE>
    80004dac:	00e78733          	add	a4,a5,a4
    80004db0:	00873503          	ld	a0,8(a4)
    80004db4:	00000097          	auipc	ra,0x0
    80004db8:	df0080e7          	jalr	-528(ra) # 80004ba4 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004dbc:	00813083          	ld	ra,8(sp)
    80004dc0:	00013403          	ld	s0,0(sp)
    80004dc4:	01010113          	addi	sp,sp,16
    80004dc8:	00008067          	ret
        return nullptr;
    80004dcc:	00000513          	li	a0,0
}
    80004dd0:	00008067          	ret

0000000080004dd4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80004dd4:	fc010113          	addi	sp,sp,-64
    80004dd8:	02113c23          	sd	ra,56(sp)
    80004ddc:	02813823          	sd	s0,48(sp)
    80004de0:	02913423          	sd	s1,40(sp)
    80004de4:	03213023          	sd	s2,32(sp)
    80004de8:	01313c23          	sd	s3,24(sp)
    80004dec:	01413823          	sd	s4,16(sp)
    80004df0:	01513423          	sd	s5,8(sp)
    80004df4:	04010413          	addi	s0,sp,64
    80004df8:	00050a93          	mv	s5,a0
    80004dfc:	00058493          	mv	s1,a1
    80004e00:	00060a13          	mv	s4,a2
    80004e04:	00068993          	mv	s3,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80004e08:	00006517          	auipc	a0,0x6
    80004e0c:	4d053503          	ld	a0,1232(a0) # 8000b2d8 <_ZN13SlabAllocator5cacheE>
    80004e10:	00000097          	auipc	ra,0x0
    80004e14:	d94080e7          	jalr	-620(ra) # 80004ba4 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80004e18:	00050913          	mv	s2,a0
    if(ret == nullptr)
    80004e1c:	08050e63          	beqz	a0,80004eb8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xe4>
    strcpy(name, ret->name);
    80004e20:	00050593          	mv	a1,a0
    80004e24:	000a8513          	mv	a0,s5
    80004e28:	fffff097          	auipc	ra,0xfffff
    80004e2c:	2d4080e7          	jalr	724(ra) # 800040fc <_Z6strcpyPKcPc>
    ret->ctor = ctor;
    80004e30:	05493c23          	sd	s4,88(s2)
    ret->dtor = dtor;
    80004e34:	07393023          	sd	s3,96(s2)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80004e38:	06093c23          	sd	zero,120(s2)
    80004e3c:	06093823          	sd	zero,112(s2)
    80004e40:	06093423          	sd	zero,104(s2)
    ret->objectSize = size;
    80004e44:	04993023          	sd	s1,64(s2)
    ret->errCode = 0;
    80004e48:	04093823          	sd	zero,80(s2)
    if(size <= sizeof(Slab))
    80004e4c:	0b000793          	li	a5,176
    80004e50:	0097e863          	bltu	a5,s1,80004e60 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x8c>
        ret->slabSize = SMALL_CACHE_DEFAULT_SLAB_SIZE;
    80004e54:	00100793          	li	a5,1
    80004e58:	04f93423          	sd	a5,72(s2)
    80004e5c:	05c0006f          	j	80004eb8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xe4>
        num--;
    80004e60:	fff48793          	addi	a5,s1,-1
        num |= num>>1;
    80004e64:	0017d493          	srli	s1,a5,0x1
    80004e68:	0097e7b3          	or	a5,a5,s1
        num |= num>>2;
    80004e6c:	0027d493          	srli	s1,a5,0x2
    80004e70:	0097e7b3          	or	a5,a5,s1
        num |= num>>4;
    80004e74:	0047d713          	srli	a4,a5,0x4
    80004e78:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80004e7c:	0087d713          	srli	a4,a5,0x8
    80004e80:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80004e84:	0107d713          	srli	a4,a5,0x10
    80004e88:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80004e8c:	0207d713          	srli	a4,a5,0x20
    80004e90:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80004e94:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80004e98:	00000713          	li	a4,0
        while(num>1){
    80004e9c:	00100693          	li	a3,1
    80004ea0:	00f6f863          	bgeu	a3,a5,80004eb0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xdc>
            num/=2;
    80004ea4:	0017d793          	srli	a5,a5,0x1
            deg++;
    80004ea8:	00170713          	addi	a4,a4,1
        while(num>1){
    80004eac:	ff1ff06f          	j	80004e9c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xc8>
        ret->slabSize = Buddy::getDeg(Buddy::ceil(size))-10;
    80004eb0:	ff670713          	addi	a4,a4,-10
    80004eb4:	04e93423          	sd	a4,72(s2)
}
    80004eb8:	00090513          	mv	a0,s2
    80004ebc:	03813083          	ld	ra,56(sp)
    80004ec0:	03013403          	ld	s0,48(sp)
    80004ec4:	02813483          	ld	s1,40(sp)
    80004ec8:	02013903          	ld	s2,32(sp)
    80004ecc:	01813983          	ld	s3,24(sp)
    80004ed0:	01013a03          	ld	s4,16(sp)
    80004ed4:	00813a83          	ld	s5,8(sp)
    80004ed8:	04010113          	addi	sp,sp,64
    80004edc:	00008067          	ret

0000000080004ee0 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80004ee0:	fe010113          	addi	sp,sp,-32
    80004ee4:	00113c23          	sd	ra,24(sp)
    80004ee8:	00813823          	sd	s0,16(sp)
    80004eec:	00913423          	sd	s1,8(sp)
    80004ef0:	01213023          	sd	s2,0(sp)
    80004ef4:	02010413          	addi	s0,sp,32
    Buddy::initialize(space, blockNum);
    80004ef8:	ffffd097          	auipc	ra,0xffffd
    80004efc:	aa0080e7          	jalr	-1376(ra) # 80001998 <_ZN5Buddy10initializeEPvm>
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80004f00:	00006917          	auipc	s2,0x6
    80004f04:	07093903          	ld	s2,112(s2) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004f08:	00093583          	ld	a1,0(s2)
    80004f0c:	00c5d593          	srli	a1,a1,0xc
    80004f10:	00158593          	addi	a1,a1,1
    80004f14:	00c59593          	slli	a1,a1,0xc
    80004f18:	00006497          	auipc	s1,0x6
    80004f1c:	35048493          	addi	s1,s1,848 # 8000b268 <_ZN13SlabAllocator14largeSlabCacheE>
    80004f20:	06b4b823          	sd	a1,112(s1)
    cache->ctor = nullptr;
    80004f24:	0405bc23          	sd	zero,88(a1)
    cache->dtor = nullptr;
    80004f28:	0605b023          	sd	zero,96(a1)
    cache->emptyHead = nullptr;
    80004f2c:	0605b423          	sd	zero,104(a1)
    cache->partialHead = nullptr;
    80004f30:	0605b823          	sd	zero,112(a1)
    cache->fullHead = nullptr;
    80004f34:	0605bc23          	sd	zero,120(a1)
    cache->objectSize = sizeof(Cache);
    80004f38:	08000793          	li	a5,128
    80004f3c:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80004f40:	00200793          	li	a5,2
    80004f44:	04f5b423          	sd	a5,72(a1)
    cache->errCode = 0;
    80004f48:	0405b823          	sd	zero,80(a1)
    strcpy("Main Cache", cache->name);
    80004f4c:	00003517          	auipc	a0,0x3
    80004f50:	4f450513          	addi	a0,a0,1268 # 80008440 <CONSOLE_STATUS+0x430>
    80004f54:	fffff097          	auipc	ra,0xfffff
    80004f58:	1a8080e7          	jalr	424(ra) # 800040fc <_Z6strcpyPKcPc>
    largeSlabCache = (Cache*)BUDDY_META_ADDR_CONST;
    80004f5c:	00093783          	ld	a5,0(s2)
    80004f60:	fffff737          	lui	a4,0xfffff
    80004f64:	00e7f7b3          	and	a5,a5,a4
    80004f68:	00f4b023          	sd	a5,0(s1)
    largeSlabCache->ctor = nullptr;
    80004f6c:	0407bc23          	sd	zero,88(a5)
    largeSlabCache->dtor = nullptr;
    80004f70:	0607b023          	sd	zero,96(a5)
    largeSlabCache->emptyHead = nullptr;
    80004f74:	0607b423          	sd	zero,104(a5)
    largeSlabCache->partialHead = nullptr;
    80004f78:	0607b823          	sd	zero,112(a5)
    largeSlabCache->fullHead = nullptr;
    80004f7c:	0607bc23          	sd	zero,120(a5)
    largeSlabCache->objectSize = sizeof(Slab);
    80004f80:	0b000713          	li	a4,176
    80004f84:	04e7b023          	sd	a4,64(a5)
    largeSlabCache->slabSize = SLAB_HEADER_DEFAULT_SLAB_SIZE;
    80004f88:	00400713          	li	a4,4
    80004f8c:	04e7b423          	sd	a4,72(a5)
    cache->errCode = 0;
    80004f90:	0704b583          	ld	a1,112(s1)
    80004f94:	0405b823          	sd	zero,80(a1)
    strcpy("Large Slab Cache", cache->name);
    80004f98:	00003517          	auipc	a0,0x3
    80004f9c:	4b850513          	addi	a0,a0,1208 # 80008450 <CONSOLE_STATUS+0x440>
    80004fa0:	fffff097          	auipc	ra,0xfffff
    80004fa4:	15c080e7          	jalr	348(ra) # 800040fc <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80004fa8:	00000493          	li	s1,0
    80004fac:	0480006f          	j	80004ff4 <_ZN13SlabAllocator10initializeEPvm+0x114>
        sizeN[i] = SlabAllocator::createCache(names[i], 1<<(i+CACHE_LOWER_BOUND), nullptr, nullptr);
    80004fb0:	0054871b          	addiw	a4,s1,5
    80004fb4:	00349913          	slli	s2,s1,0x3
    80004fb8:	00006797          	auipc	a5,0x6
    80004fbc:	f3878793          	addi	a5,a5,-200 # 8000aef0 <_ZN13SlabAllocator5namesE>
    80004fc0:	012787b3          	add	a5,a5,s2
    80004fc4:	00000693          	li	a3,0
    80004fc8:	00000613          	li	a2,0
    80004fcc:	00100593          	li	a1,1
    80004fd0:	00e595bb          	sllw	a1,a1,a4
    80004fd4:	0007b503          	ld	a0,0(a5)
    80004fd8:	00000097          	auipc	ra,0x0
    80004fdc:	dfc080e7          	jalr	-516(ra) # 80004dd4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80004fe0:	00006797          	auipc	a5,0x6
    80004fe4:	28878793          	addi	a5,a5,648 # 8000b268 <_ZN13SlabAllocator14largeSlabCacheE>
    80004fe8:	012787b3          	add	a5,a5,s2
    80004fec:	00a7b423          	sd	a0,8(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80004ff0:	0014849b          	addiw	s1,s1,1
    80004ff4:	00c00793          	li	a5,12
    80004ff8:	fa97dce3          	bge	a5,s1,80004fb0 <_ZN13SlabAllocator10initializeEPvm+0xd0>
}
    80004ffc:	01813083          	ld	ra,24(sp)
    80005000:	01013403          	ld	s0,16(sp)
    80005004:	00813483          	ld	s1,8(sp)
    80005008:	00013903          	ld	s2,0(sp)
    8000500c:	02010113          	addi	sp,sp,32
    80005010:	00008067          	ret

0000000080005014 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index>>3] & (1<<(7 - (index&7)))) {
    80005014:	0035d713          	srli	a4,a1,0x3
    80005018:	00e507b3          	add	a5,a0,a4
    8000501c:	0207c683          	lbu	a3,32(a5)
    80005020:	fff5c593          	not	a1,a1
    80005024:	0075f593          	andi	a1,a1,7
    80005028:	40b6d7bb          	sraw	a5,a3,a1
    8000502c:	0017f793          	andi	a5,a5,1
    80005030:	0e078e63          	beqz	a5,8000512c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x118>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80005034:	fe010113          	addi	sp,sp,-32
    80005038:	00113c23          	sd	ra,24(sp)
    8000503c:	00813823          	sd	s0,16(sp)
    80005040:	00913423          	sd	s1,8(sp)
    80005044:	02010413          	addi	s0,sp,32
    80005048:	00050493          	mv	s1,a0
        slab->allocated[index>>3] &= ~(1<<(7 - (index&7)));
    8000504c:	00100793          	li	a5,1
    80005050:	00b795bb          	sllw	a1,a5,a1
    80005054:	00e50733          	add	a4,a0,a4
    80005058:	fff5c593          	not	a1,a1
    8000505c:	00d5f5b3          	and	a1,a1,a3
    80005060:	02b70023          	sb	a1,32(a4) # fffffffffffff020 <end+0xffffffff7ffee020>
    inline bool isFull(){return numOfFreeSlots == 0;}
    80005064:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80005068:	04079a63          	bnez	a5,800050bc <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    8000506c:	0a853503          	ld	a0,168(a0)
    80005070:	07850513          	addi	a0,a0,120
        slab->numOfFreeSlots++;
    80005074:	00178793          	addi	a5,a5,1
    80005078:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    8000507c:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80005080:	04e78463          	beq	a5,a4,800050c8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80005084:	0a84b583          	ld	a1,168(s1)
    80005088:	07058593          	addi	a1,a1,112
        if(slab->isEmpty()) {
    8000508c:	04e78463          	beq	a5,a4,800050d4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80005090:	0005b703          	ld	a4,0(a1)
    80005094:	00053783          	ld	a5,0(a0)
    80005098:	00f70863          	beq	a4,a5,800050a8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    8000509c:	00048613          	mv	a2,s1
    800050a0:	00000097          	auipc	ra,0x0
    800050a4:	9b8080e7          	jalr	-1608(ra) # 80004a58 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    800050a8:	01813083          	ld	ra,24(sp)
    800050ac:	01013403          	ld	s0,16(sp)
    800050b0:	00813483          	ld	s1,8(sp)
    800050b4:	02010113          	addi	sp,sp,32
    800050b8:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800050bc:	0a853503          	ld	a0,168(a0)
    800050c0:	07050513          	addi	a0,a0,112
    800050c4:	fb1ff06f          	j	80005074 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800050c8:	0a84b583          	ld	a1,168(s1)
    800050cc:	06858593          	addi	a1,a1,104
    800050d0:	fbdff06f          	j	8000508c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    800050d4:	00048593          	mv	a1,s1
    800050d8:	00000097          	auipc	ra,0x0
    800050dc:	92c080e7          	jalr	-1748(ra) # 80004a04 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            if(slab->parent->objectSize <= sizeof(Slab)) {
    800050e0:	0a84b783          	ld	a5,168(s1)
    800050e4:	0407b683          	ld	a3,64(a5)
    800050e8:	0b000713          	li	a4,176
    800050ec:	00d76c63          	bltu	a4,a3,80005104 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xf0>
                Buddy::free(slab, slab->parent->slabSize);
    800050f0:	0487b583          	ld	a1,72(a5)
    800050f4:	00048513          	mv	a0,s1
    800050f8:	ffffd097          	auipc	ra,0xffffd
    800050fc:	b98080e7          	jalr	-1128(ra) # 80001c90 <_ZN5Buddy4freeEPvm>
    80005100:	fa9ff06f          	j	800050a8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                Buddy::free(slab->objectOffset, slab->parent->slabSize);
    80005104:	0487b583          	ld	a1,72(a5)
    80005108:	0a04b503          	ld	a0,160(s1)
    8000510c:	ffffd097          	auipc	ra,0xffffd
    80005110:	b84080e7          	jalr	-1148(ra) # 80001c90 <_ZN5Buddy4freeEPvm>
                SlabAllocator::freeObject(largeSlabCache, slab);
    80005114:	00048593          	mv	a1,s1
    80005118:	00006517          	auipc	a0,0x6
    8000511c:	15053503          	ld	a0,336(a0) # 8000b268 <_ZN13SlabAllocator14largeSlabCacheE>
    80005120:	00000097          	auipc	ra,0x0
    80005124:	010080e7          	jalr	16(ra) # 80005130 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80005128:	f81ff06f          	j	800050a8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    8000512c:	00008067          	ret

0000000080005130 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80005130:	fe010113          	addi	sp,sp,-32
    80005134:	00113c23          	sd	ra,24(sp)
    80005138:	00813823          	sd	s0,16(sp)
    8000513c:	00913423          	sd	s1,8(sp)
    80005140:	01213023          	sd	s2,0(sp)
    80005144:	02010413          	addi	s0,sp,32
    80005148:	00050913          	mv	s2,a0
    8000514c:	00058493          	mv	s1,a1
    if(cache->dtor)
    80005150:	06053783          	ld	a5,96(a0)
    80005154:	00078663          	beqz	a5,80005160 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80005158:	00058513          	mv	a0,a1
    8000515c:	000780e7          	jalr	a5
    if(cache->ctor)
    80005160:	05893783          	ld	a5,88(s2)
    80005164:	00078663          	beqz	a5,80005170 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80005168:	00048513          	mv	a0,s1
    8000516c:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80005170:	07893503          	ld	a0,120(s2)
    80005174:	0080006f          	j	8000517c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80005178:	00853503          	ld	a0,8(a0)
        while(head){
    8000517c:	02050e63          	beqz	a0,800051b8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80005180:	0a053703          	ld	a4,160(a0)
    80005184:	01853783          	ld	a5,24(a0)
    80005188:	0a853683          	ld	a3,168(a0)
    8000518c:	0406b583          	ld	a1,64(a3)
    80005190:	02b787b3          	mul	a5,a5,a1
    80005194:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80005198:	fef4f0e3          	bgeu	s1,a5,80005178 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    8000519c:	fce4eee3          	bltu	s1,a4,80005178 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    800051a0:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    800051a4:	02b755b3          	divu	a1,a4,a1
    800051a8:	00000097          	auipc	ra,0x0
    800051ac:	e6c080e7          	jalr	-404(ra) # 80005014 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    800051b0:	00100513          	li	a0,1
    800051b4:	0080006f          	j	800051bc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    800051b8:	00000513          	li	a0,0
    if(deleted)
    800051bc:	00050e63          	beqz	a0,800051d8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    800051c0:	01813083          	ld	ra,24(sp)
    800051c4:	01013403          	ld	s0,16(sp)
    800051c8:	00813483          	ld	s1,8(sp)
    800051cc:	00013903          	ld	s2,0(sp)
    800051d0:	02010113          	addi	sp,sp,32
    800051d4:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    800051d8:	07093783          	ld	a5,112(s2)
    800051dc:	0080006f          	j	800051e4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    800051e0:	0087b783          	ld	a5,8(a5)
        while(head){
    800051e4:	fc078ee3          	beqz	a5,800051c0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    800051e8:	0a07b683          	ld	a3,160(a5)
    800051ec:	0187b703          	ld	a4,24(a5)
    800051f0:	0a87b603          	ld	a2,168(a5)
    800051f4:	04063583          	ld	a1,64(a2)
    800051f8:	02b70733          	mul	a4,a4,a1
    800051fc:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80005200:	fee4f0e3          	bgeu	s1,a4,800051e0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80005204:	fcd4eee3          	bltu	s1,a3,800051e0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80005208:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    8000520c:	02b6d5b3          	divu	a1,a3,a1
    80005210:	00078513          	mv	a0,a5
    80005214:	00000097          	auipc	ra,0x0
    80005218:	e00080e7          	jalr	-512(ra) # 80005014 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    8000521c:	00100513          	li	a0,1
    80005220:	fa1ff06f          	j	800051c0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080005224 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80005224:	fe010113          	addi	sp,sp,-32
    80005228:	00113c23          	sd	ra,24(sp)
    8000522c:	00813823          	sd	s0,16(sp)
    80005230:	00913423          	sd	s1,8(sp)
    80005234:	01213023          	sd	s2,0(sp)
    80005238:	02010413          	addi	s0,sp,32
    8000523c:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80005240:	00000493          	li	s1,0
    80005244:	00c00793          	li	a5,12
    80005248:	0297c863          	blt	a5,s1,80005278 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    8000524c:	00349713          	slli	a4,s1,0x3
    80005250:	00006797          	auipc	a5,0x6
    80005254:	01878793          	addi	a5,a5,24 # 8000b268 <_ZN13SlabAllocator14largeSlabCacheE>
    80005258:	00e787b3          	add	a5,a5,a4
    8000525c:	00090593          	mv	a1,s2
    80005260:	0087b503          	ld	a0,8(a5)
    80005264:	00000097          	auipc	ra,0x0
    80005268:	ecc080e7          	jalr	-308(ra) # 80005130 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    8000526c:	00051663          	bnez	a0,80005278 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80005270:	0014849b          	addiw	s1,s1,1
    80005274:	fd1ff06f          	j	80005244 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80005278:	01813083          	ld	ra,24(sp)
    8000527c:	01013403          	ld	s0,16(sp)
    80005280:	00813483          	ld	s1,8(sp)
    80005284:	00013903          	ld	s2,0(sp)
    80005288:	02010113          	addi	sp,sp,32
    8000528c:	00008067          	ret

0000000080005290 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80005290:	fe010113          	addi	sp,sp,-32
    80005294:	00113c23          	sd	ra,24(sp)
    80005298:	00813823          	sd	s0,16(sp)
    8000529c:	00913423          	sd	s1,8(sp)
    800052a0:	01213023          	sd	s2,0(sp)
    800052a4:	02010413          	addi	s0,sp,32
    800052a8:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    800052ac:	00053903          	ld	s2,0(a0)
    800052b0:	07890913          	addi	s2,s2,120
    }

    static inline void deleteList(Slab* &head){
        while(head){
    800052b4:	00093503          	ld	a0,0(s2)
    800052b8:	02050263          	beqz	a0,800052dc <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    800052bc:	0a853783          	ld	a5,168(a0)
    800052c0:	0487b583          	ld	a1,72(a5)
    800052c4:	ffffd097          	auipc	ra,0xffffd
    800052c8:	9cc080e7          	jalr	-1588(ra) # 80001c90 <_ZN5Buddy4freeEPvm>
            head = head->next;
    800052cc:	00093783          	ld	a5,0(s2)
    800052d0:	0087b783          	ld	a5,8(a5)
    800052d4:	00f93023          	sd	a5,0(s2)
        while(head){
    800052d8:	fddff06f          	j	800052b4 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    800052dc:	0004b903          	ld	s2,0(s1)
    800052e0:	07090913          	addi	s2,s2,112
    800052e4:	00093503          	ld	a0,0(s2)
    800052e8:	02050263          	beqz	a0,8000530c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    800052ec:	0a853783          	ld	a5,168(a0)
    800052f0:	0487b583          	ld	a1,72(a5)
    800052f4:	ffffd097          	auipc	ra,0xffffd
    800052f8:	99c080e7          	jalr	-1636(ra) # 80001c90 <_ZN5Buddy4freeEPvm>
            head = head->next;
    800052fc:	00093783          	ld	a5,0(s2)
    80005300:	0087b783          	ld	a5,8(a5)
    80005304:	00f93023          	sd	a5,0(s2)
        while(head){
    80005308:	fddff06f          	j	800052e4 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    8000530c:	0004b903          	ld	s2,0(s1)
    80005310:	06890913          	addi	s2,s2,104
    80005314:	00093503          	ld	a0,0(s2)
    80005318:	02050263          	beqz	a0,8000533c <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    8000531c:	0a853783          	ld	a5,168(a0)
    80005320:	0487b583          	ld	a1,72(a5)
    80005324:	ffffd097          	auipc	ra,0xffffd
    80005328:	96c080e7          	jalr	-1684(ra) # 80001c90 <_ZN5Buddy4freeEPvm>
            head = head->next;
    8000532c:	00093783          	ld	a5,0(s2)
    80005330:	0087b783          	ld	a5,8(a5)
    80005334:	00f93023          	sd	a5,0(s2)
        while(head){
    80005338:	fddff06f          	j	80005314 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    8000533c:	0004b583          	ld	a1,0(s1)
    80005340:	00006517          	auipc	a0,0x6
    80005344:	f9853503          	ld	a0,-104(a0) # 8000b2d8 <_ZN13SlabAllocator5cacheE>
    80005348:	00000097          	auipc	ra,0x0
    8000534c:	de8080e7          	jalr	-536(ra) # 80005130 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80005350:	0004b023          	sd	zero,0(s1)
}
    80005354:	01813083          	ld	ra,24(sp)
    80005358:	01013403          	ld	s0,16(sp)
    8000535c:	00813483          	ld	s1,8(sp)
    80005360:	00013903          	ld	s2,0(sp)
    80005364:	02010113          	addi	sp,sp,32
    80005368:	00008067          	ret

000000008000536c <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache>:

int SlabAllocator::cacheErrorHandler(Cache *cache) {
    8000536c:	fe010113          	addi	sp,sp,-32
    80005370:	00113c23          	sd	ra,24(sp)
    80005374:	00813823          	sd	s0,16(sp)
    80005378:	00913423          	sd	s1,8(sp)
    8000537c:	02010413          	addi	s0,sp,32
    80005380:	00050493          	mv	s1,a0
    switch(cache->errCode){
    80005384:	05053783          	ld	a5,80(a0)
    80005388:	00100713          	li	a4,1
    8000538c:	02e78e63          	beq	a5,a4,800053c8 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x5c>
    80005390:	00200713          	li	a4,2
    80005394:	04e78463          	beq	a5,a4,800053dc <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x70>
    80005398:	00078e63          	beqz	a5,800053b4 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x48>
        case 0: ConsoleUtil::printString("No errors\n");break;
        case 1: ConsoleUtil::printString("No available slots\n");break;
        case 2: ConsoleUtil::printString("Couldn't allocate slab\n");break;
    }
    return cache->errCode;
    8000539c:	0504a503          	lw	a0,80(s1)
    800053a0:	01813083          	ld	ra,24(sp)
    800053a4:	01013403          	ld	s0,16(sp)
    800053a8:	00813483          	ld	s1,8(sp)
    800053ac:	02010113          	addi	sp,sp,32
    800053b0:	00008067          	ret
        case 0: ConsoleUtil::printString("No errors\n");break;
    800053b4:	00003517          	auipc	a0,0x3
    800053b8:	0b450513          	addi	a0,a0,180 # 80008468 <CONSOLE_STATUS+0x458>
    800053bc:	ffffd097          	auipc	ra,0xffffd
    800053c0:	65c080e7          	jalr	1628(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    800053c4:	fd9ff06f          	j	8000539c <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>
        case 1: ConsoleUtil::printString("No available slots\n");break;
    800053c8:	00003517          	auipc	a0,0x3
    800053cc:	0b050513          	addi	a0,a0,176 # 80008478 <CONSOLE_STATUS+0x468>
    800053d0:	ffffd097          	auipc	ra,0xffffd
    800053d4:	648080e7          	jalr	1608(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    800053d8:	fc5ff06f          	j	8000539c <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>
        case 2: ConsoleUtil::printString("Couldn't allocate slab\n");break;
    800053dc:	00003517          	auipc	a0,0x3
    800053e0:	0b450513          	addi	a0,a0,180 # 80008490 <CONSOLE_STATUS+0x480>
    800053e4:	ffffd097          	auipc	ra,0xffffd
    800053e8:	634080e7          	jalr	1588(ra) # 80002a18 <_ZN11ConsoleUtil11printStringEPKc>
    800053ec:	fb1ff06f          	j	8000539c <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>

00000000800053f0 <start>:
    800053f0:	ff010113          	addi	sp,sp,-16
    800053f4:	00813423          	sd	s0,8(sp)
    800053f8:	01010413          	addi	s0,sp,16
    800053fc:	300027f3          	csrr	a5,mstatus
    80005400:	ffffe737          	lui	a4,0xffffe
    80005404:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed7ff>
    80005408:	00e7f7b3          	and	a5,a5,a4
    8000540c:	00001737          	lui	a4,0x1
    80005410:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005414:	00e7e7b3          	or	a5,a5,a4
    80005418:	30079073          	csrw	mstatus,a5
    8000541c:	00000797          	auipc	a5,0x0
    80005420:	16078793          	addi	a5,a5,352 # 8000557c <system_main>
    80005424:	34179073          	csrw	mepc,a5
    80005428:	00000793          	li	a5,0
    8000542c:	18079073          	csrw	satp,a5
    80005430:	000107b7          	lui	a5,0x10
    80005434:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005438:	30279073          	csrw	medeleg,a5
    8000543c:	30379073          	csrw	mideleg,a5
    80005440:	104027f3          	csrr	a5,sie
    80005444:	2227e793          	ori	a5,a5,546
    80005448:	10479073          	csrw	sie,a5
    8000544c:	fff00793          	li	a5,-1
    80005450:	00a7d793          	srli	a5,a5,0xa
    80005454:	3b079073          	csrw	pmpaddr0,a5
    80005458:	00f00793          	li	a5,15
    8000545c:	3a079073          	csrw	pmpcfg0,a5
    80005460:	f14027f3          	csrr	a5,mhartid
    80005464:	0200c737          	lui	a4,0x200c
    80005468:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000546c:	0007869b          	sext.w	a3,a5
    80005470:	00269713          	slli	a4,a3,0x2
    80005474:	000f4637          	lui	a2,0xf4
    80005478:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000547c:	00d70733          	add	a4,a4,a3
    80005480:	0037979b          	slliw	a5,a5,0x3
    80005484:	020046b7          	lui	a3,0x2004
    80005488:	00d787b3          	add	a5,a5,a3
    8000548c:	00c585b3          	add	a1,a1,a2
    80005490:	00371693          	slli	a3,a4,0x3
    80005494:	00006717          	auipc	a4,0x6
    80005498:	e4c70713          	addi	a4,a4,-436 # 8000b2e0 <timer_scratch>
    8000549c:	00b7b023          	sd	a1,0(a5)
    800054a0:	00d70733          	add	a4,a4,a3
    800054a4:	00f73c23          	sd	a5,24(a4)
    800054a8:	02c73023          	sd	a2,32(a4)
    800054ac:	34071073          	csrw	mscratch,a4
    800054b0:	00000797          	auipc	a5,0x0
    800054b4:	6e078793          	addi	a5,a5,1760 # 80005b90 <timervec>
    800054b8:	30579073          	csrw	mtvec,a5
    800054bc:	300027f3          	csrr	a5,mstatus
    800054c0:	0087e793          	ori	a5,a5,8
    800054c4:	30079073          	csrw	mstatus,a5
    800054c8:	304027f3          	csrr	a5,mie
    800054cc:	0807e793          	ori	a5,a5,128
    800054d0:	30479073          	csrw	mie,a5
    800054d4:	f14027f3          	csrr	a5,mhartid
    800054d8:	0007879b          	sext.w	a5,a5
    800054dc:	00078213          	mv	tp,a5
    800054e0:	30200073          	mret
    800054e4:	00813403          	ld	s0,8(sp)
    800054e8:	01010113          	addi	sp,sp,16
    800054ec:	00008067          	ret

00000000800054f0 <timerinit>:
    800054f0:	ff010113          	addi	sp,sp,-16
    800054f4:	00813423          	sd	s0,8(sp)
    800054f8:	01010413          	addi	s0,sp,16
    800054fc:	f14027f3          	csrr	a5,mhartid
    80005500:	0200c737          	lui	a4,0x200c
    80005504:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005508:	0007869b          	sext.w	a3,a5
    8000550c:	00269713          	slli	a4,a3,0x2
    80005510:	000f4637          	lui	a2,0xf4
    80005514:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005518:	00d70733          	add	a4,a4,a3
    8000551c:	0037979b          	slliw	a5,a5,0x3
    80005520:	020046b7          	lui	a3,0x2004
    80005524:	00d787b3          	add	a5,a5,a3
    80005528:	00c585b3          	add	a1,a1,a2
    8000552c:	00371693          	slli	a3,a4,0x3
    80005530:	00006717          	auipc	a4,0x6
    80005534:	db070713          	addi	a4,a4,-592 # 8000b2e0 <timer_scratch>
    80005538:	00b7b023          	sd	a1,0(a5)
    8000553c:	00d70733          	add	a4,a4,a3
    80005540:	00f73c23          	sd	a5,24(a4)
    80005544:	02c73023          	sd	a2,32(a4)
    80005548:	34071073          	csrw	mscratch,a4
    8000554c:	00000797          	auipc	a5,0x0
    80005550:	64478793          	addi	a5,a5,1604 # 80005b90 <timervec>
    80005554:	30579073          	csrw	mtvec,a5
    80005558:	300027f3          	csrr	a5,mstatus
    8000555c:	0087e793          	ori	a5,a5,8
    80005560:	30079073          	csrw	mstatus,a5
    80005564:	304027f3          	csrr	a5,mie
    80005568:	0807e793          	ori	a5,a5,128
    8000556c:	30479073          	csrw	mie,a5
    80005570:	00813403          	ld	s0,8(sp)
    80005574:	01010113          	addi	sp,sp,16
    80005578:	00008067          	ret

000000008000557c <system_main>:
    8000557c:	fe010113          	addi	sp,sp,-32
    80005580:	00813823          	sd	s0,16(sp)
    80005584:	00913423          	sd	s1,8(sp)
    80005588:	00113c23          	sd	ra,24(sp)
    8000558c:	02010413          	addi	s0,sp,32
    80005590:	00000097          	auipc	ra,0x0
    80005594:	0c4080e7          	jalr	196(ra) # 80005654 <cpuid>
    80005598:	00006497          	auipc	s1,0x6
    8000559c:	ac848493          	addi	s1,s1,-1336 # 8000b060 <started>
    800055a0:	02050263          	beqz	a0,800055c4 <system_main+0x48>
    800055a4:	0004a783          	lw	a5,0(s1)
    800055a8:	0007879b          	sext.w	a5,a5
    800055ac:	fe078ce3          	beqz	a5,800055a4 <system_main+0x28>
    800055b0:	0ff0000f          	fence
    800055b4:	00003517          	auipc	a0,0x3
    800055b8:	05c50513          	addi	a0,a0,92 # 80008610 <CONSOLE_STATUS+0x600>
    800055bc:	00001097          	auipc	ra,0x1
    800055c0:	a70080e7          	jalr	-1424(ra) # 8000602c <panic>
    800055c4:	00001097          	auipc	ra,0x1
    800055c8:	9c4080e7          	jalr	-1596(ra) # 80005f88 <consoleinit>
    800055cc:	00001097          	auipc	ra,0x1
    800055d0:	150080e7          	jalr	336(ra) # 8000671c <printfinit>
    800055d4:	00003517          	auipc	a0,0x3
    800055d8:	b4c50513          	addi	a0,a0,-1204 # 80008120 <CONSOLE_STATUS+0x110>
    800055dc:	00001097          	auipc	ra,0x1
    800055e0:	aac080e7          	jalr	-1364(ra) # 80006088 <__printf>
    800055e4:	00003517          	auipc	a0,0x3
    800055e8:	ffc50513          	addi	a0,a0,-4 # 800085e0 <CONSOLE_STATUS+0x5d0>
    800055ec:	00001097          	auipc	ra,0x1
    800055f0:	a9c080e7          	jalr	-1380(ra) # 80006088 <__printf>
    800055f4:	00003517          	auipc	a0,0x3
    800055f8:	b2c50513          	addi	a0,a0,-1236 # 80008120 <CONSOLE_STATUS+0x110>
    800055fc:	00001097          	auipc	ra,0x1
    80005600:	a8c080e7          	jalr	-1396(ra) # 80006088 <__printf>
    80005604:	00001097          	auipc	ra,0x1
    80005608:	4a4080e7          	jalr	1188(ra) # 80006aa8 <kinit>
    8000560c:	00000097          	auipc	ra,0x0
    80005610:	148080e7          	jalr	328(ra) # 80005754 <trapinit>
    80005614:	00000097          	auipc	ra,0x0
    80005618:	16c080e7          	jalr	364(ra) # 80005780 <trapinithart>
    8000561c:	00000097          	auipc	ra,0x0
    80005620:	5b4080e7          	jalr	1460(ra) # 80005bd0 <plicinit>
    80005624:	00000097          	auipc	ra,0x0
    80005628:	5d4080e7          	jalr	1492(ra) # 80005bf8 <plicinithart>
    8000562c:	00000097          	auipc	ra,0x0
    80005630:	078080e7          	jalr	120(ra) # 800056a4 <userinit>
    80005634:	0ff0000f          	fence
    80005638:	00100793          	li	a5,1
    8000563c:	00003517          	auipc	a0,0x3
    80005640:	fbc50513          	addi	a0,a0,-68 # 800085f8 <CONSOLE_STATUS+0x5e8>
    80005644:	00f4a023          	sw	a5,0(s1)
    80005648:	00001097          	auipc	ra,0x1
    8000564c:	a40080e7          	jalr	-1472(ra) # 80006088 <__printf>
    80005650:	0000006f          	j	80005650 <system_main+0xd4>

0000000080005654 <cpuid>:
    80005654:	ff010113          	addi	sp,sp,-16
    80005658:	00813423          	sd	s0,8(sp)
    8000565c:	01010413          	addi	s0,sp,16
    80005660:	00020513          	mv	a0,tp
    80005664:	00813403          	ld	s0,8(sp)
    80005668:	0005051b          	sext.w	a0,a0
    8000566c:	01010113          	addi	sp,sp,16
    80005670:	00008067          	ret

0000000080005674 <mycpu>:
    80005674:	ff010113          	addi	sp,sp,-16
    80005678:	00813423          	sd	s0,8(sp)
    8000567c:	01010413          	addi	s0,sp,16
    80005680:	00020793          	mv	a5,tp
    80005684:	00813403          	ld	s0,8(sp)
    80005688:	0007879b          	sext.w	a5,a5
    8000568c:	00779793          	slli	a5,a5,0x7
    80005690:	00007517          	auipc	a0,0x7
    80005694:	c8050513          	addi	a0,a0,-896 # 8000c310 <cpus>
    80005698:	00f50533          	add	a0,a0,a5
    8000569c:	01010113          	addi	sp,sp,16
    800056a0:	00008067          	ret

00000000800056a4 <userinit>:
    800056a4:	ff010113          	addi	sp,sp,-16
    800056a8:	00813423          	sd	s0,8(sp)
    800056ac:	01010413          	addi	s0,sp,16
    800056b0:	00813403          	ld	s0,8(sp)
    800056b4:	01010113          	addi	sp,sp,16
    800056b8:	ffffd317          	auipc	t1,0xffffd
    800056bc:	85430067          	jr	-1964(t1) # 80001f0c <main>

00000000800056c0 <either_copyout>:
    800056c0:	ff010113          	addi	sp,sp,-16
    800056c4:	00813023          	sd	s0,0(sp)
    800056c8:	00113423          	sd	ra,8(sp)
    800056cc:	01010413          	addi	s0,sp,16
    800056d0:	02051663          	bnez	a0,800056fc <either_copyout+0x3c>
    800056d4:	00058513          	mv	a0,a1
    800056d8:	00060593          	mv	a1,a2
    800056dc:	0006861b          	sext.w	a2,a3
    800056e0:	00002097          	auipc	ra,0x2
    800056e4:	c54080e7          	jalr	-940(ra) # 80007334 <__memmove>
    800056e8:	00813083          	ld	ra,8(sp)
    800056ec:	00013403          	ld	s0,0(sp)
    800056f0:	00000513          	li	a0,0
    800056f4:	01010113          	addi	sp,sp,16
    800056f8:	00008067          	ret
    800056fc:	00003517          	auipc	a0,0x3
    80005700:	f3c50513          	addi	a0,a0,-196 # 80008638 <CONSOLE_STATUS+0x628>
    80005704:	00001097          	auipc	ra,0x1
    80005708:	928080e7          	jalr	-1752(ra) # 8000602c <panic>

000000008000570c <either_copyin>:
    8000570c:	ff010113          	addi	sp,sp,-16
    80005710:	00813023          	sd	s0,0(sp)
    80005714:	00113423          	sd	ra,8(sp)
    80005718:	01010413          	addi	s0,sp,16
    8000571c:	02059463          	bnez	a1,80005744 <either_copyin+0x38>
    80005720:	00060593          	mv	a1,a2
    80005724:	0006861b          	sext.w	a2,a3
    80005728:	00002097          	auipc	ra,0x2
    8000572c:	c0c080e7          	jalr	-1012(ra) # 80007334 <__memmove>
    80005730:	00813083          	ld	ra,8(sp)
    80005734:	00013403          	ld	s0,0(sp)
    80005738:	00000513          	li	a0,0
    8000573c:	01010113          	addi	sp,sp,16
    80005740:	00008067          	ret
    80005744:	00003517          	auipc	a0,0x3
    80005748:	f1c50513          	addi	a0,a0,-228 # 80008660 <CONSOLE_STATUS+0x650>
    8000574c:	00001097          	auipc	ra,0x1
    80005750:	8e0080e7          	jalr	-1824(ra) # 8000602c <panic>

0000000080005754 <trapinit>:
    80005754:	ff010113          	addi	sp,sp,-16
    80005758:	00813423          	sd	s0,8(sp)
    8000575c:	01010413          	addi	s0,sp,16
    80005760:	00813403          	ld	s0,8(sp)
    80005764:	00003597          	auipc	a1,0x3
    80005768:	f2458593          	addi	a1,a1,-220 # 80008688 <CONSOLE_STATUS+0x678>
    8000576c:	00007517          	auipc	a0,0x7
    80005770:	c2450513          	addi	a0,a0,-988 # 8000c390 <tickslock>
    80005774:	01010113          	addi	sp,sp,16
    80005778:	00001317          	auipc	t1,0x1
    8000577c:	5c030067          	jr	1472(t1) # 80006d38 <initlock>

0000000080005780 <trapinithart>:
    80005780:	ff010113          	addi	sp,sp,-16
    80005784:	00813423          	sd	s0,8(sp)
    80005788:	01010413          	addi	s0,sp,16
    8000578c:	00000797          	auipc	a5,0x0
    80005790:	2f478793          	addi	a5,a5,756 # 80005a80 <kernelvec>
    80005794:	10579073          	csrw	stvec,a5
    80005798:	00813403          	ld	s0,8(sp)
    8000579c:	01010113          	addi	sp,sp,16
    800057a0:	00008067          	ret

00000000800057a4 <usertrap>:
    800057a4:	ff010113          	addi	sp,sp,-16
    800057a8:	00813423          	sd	s0,8(sp)
    800057ac:	01010413          	addi	s0,sp,16
    800057b0:	00813403          	ld	s0,8(sp)
    800057b4:	01010113          	addi	sp,sp,16
    800057b8:	00008067          	ret

00000000800057bc <usertrapret>:
    800057bc:	ff010113          	addi	sp,sp,-16
    800057c0:	00813423          	sd	s0,8(sp)
    800057c4:	01010413          	addi	s0,sp,16
    800057c8:	00813403          	ld	s0,8(sp)
    800057cc:	01010113          	addi	sp,sp,16
    800057d0:	00008067          	ret

00000000800057d4 <kerneltrap>:
    800057d4:	fe010113          	addi	sp,sp,-32
    800057d8:	00813823          	sd	s0,16(sp)
    800057dc:	00113c23          	sd	ra,24(sp)
    800057e0:	00913423          	sd	s1,8(sp)
    800057e4:	02010413          	addi	s0,sp,32
    800057e8:	142025f3          	csrr	a1,scause
    800057ec:	100027f3          	csrr	a5,sstatus
    800057f0:	0027f793          	andi	a5,a5,2
    800057f4:	10079c63          	bnez	a5,8000590c <kerneltrap+0x138>
    800057f8:	142027f3          	csrr	a5,scause
    800057fc:	0207ce63          	bltz	a5,80005838 <kerneltrap+0x64>
    80005800:	00003517          	auipc	a0,0x3
    80005804:	ed050513          	addi	a0,a0,-304 # 800086d0 <CONSOLE_STATUS+0x6c0>
    80005808:	00001097          	auipc	ra,0x1
    8000580c:	880080e7          	jalr	-1920(ra) # 80006088 <__printf>
    80005810:	141025f3          	csrr	a1,sepc
    80005814:	14302673          	csrr	a2,stval
    80005818:	00003517          	auipc	a0,0x3
    8000581c:	ec850513          	addi	a0,a0,-312 # 800086e0 <CONSOLE_STATUS+0x6d0>
    80005820:	00001097          	auipc	ra,0x1
    80005824:	868080e7          	jalr	-1944(ra) # 80006088 <__printf>
    80005828:	00003517          	auipc	a0,0x3
    8000582c:	ed050513          	addi	a0,a0,-304 # 800086f8 <CONSOLE_STATUS+0x6e8>
    80005830:	00000097          	auipc	ra,0x0
    80005834:	7fc080e7          	jalr	2044(ra) # 8000602c <panic>
    80005838:	0ff7f713          	andi	a4,a5,255
    8000583c:	00900693          	li	a3,9
    80005840:	04d70063          	beq	a4,a3,80005880 <kerneltrap+0xac>
    80005844:	fff00713          	li	a4,-1
    80005848:	03f71713          	slli	a4,a4,0x3f
    8000584c:	00170713          	addi	a4,a4,1
    80005850:	fae798e3          	bne	a5,a4,80005800 <kerneltrap+0x2c>
    80005854:	00000097          	auipc	ra,0x0
    80005858:	e00080e7          	jalr	-512(ra) # 80005654 <cpuid>
    8000585c:	06050663          	beqz	a0,800058c8 <kerneltrap+0xf4>
    80005860:	144027f3          	csrr	a5,sip
    80005864:	ffd7f793          	andi	a5,a5,-3
    80005868:	14479073          	csrw	sip,a5
    8000586c:	01813083          	ld	ra,24(sp)
    80005870:	01013403          	ld	s0,16(sp)
    80005874:	00813483          	ld	s1,8(sp)
    80005878:	02010113          	addi	sp,sp,32
    8000587c:	00008067          	ret
    80005880:	00000097          	auipc	ra,0x0
    80005884:	3c4080e7          	jalr	964(ra) # 80005c44 <plic_claim>
    80005888:	00a00793          	li	a5,10
    8000588c:	00050493          	mv	s1,a0
    80005890:	06f50863          	beq	a0,a5,80005900 <kerneltrap+0x12c>
    80005894:	fc050ce3          	beqz	a0,8000586c <kerneltrap+0x98>
    80005898:	00050593          	mv	a1,a0
    8000589c:	00003517          	auipc	a0,0x3
    800058a0:	e1450513          	addi	a0,a0,-492 # 800086b0 <CONSOLE_STATUS+0x6a0>
    800058a4:	00000097          	auipc	ra,0x0
    800058a8:	7e4080e7          	jalr	2020(ra) # 80006088 <__printf>
    800058ac:	01013403          	ld	s0,16(sp)
    800058b0:	01813083          	ld	ra,24(sp)
    800058b4:	00048513          	mv	a0,s1
    800058b8:	00813483          	ld	s1,8(sp)
    800058bc:	02010113          	addi	sp,sp,32
    800058c0:	00000317          	auipc	t1,0x0
    800058c4:	3bc30067          	jr	956(t1) # 80005c7c <plic_complete>
    800058c8:	00007517          	auipc	a0,0x7
    800058cc:	ac850513          	addi	a0,a0,-1336 # 8000c390 <tickslock>
    800058d0:	00001097          	auipc	ra,0x1
    800058d4:	48c080e7          	jalr	1164(ra) # 80006d5c <acquire>
    800058d8:	00005717          	auipc	a4,0x5
    800058dc:	78c70713          	addi	a4,a4,1932 # 8000b064 <ticks>
    800058e0:	00072783          	lw	a5,0(a4)
    800058e4:	00007517          	auipc	a0,0x7
    800058e8:	aac50513          	addi	a0,a0,-1364 # 8000c390 <tickslock>
    800058ec:	0017879b          	addiw	a5,a5,1
    800058f0:	00f72023          	sw	a5,0(a4)
    800058f4:	00001097          	auipc	ra,0x1
    800058f8:	534080e7          	jalr	1332(ra) # 80006e28 <release>
    800058fc:	f65ff06f          	j	80005860 <kerneltrap+0x8c>
    80005900:	00001097          	auipc	ra,0x1
    80005904:	090080e7          	jalr	144(ra) # 80006990 <uartintr>
    80005908:	fa5ff06f          	j	800058ac <kerneltrap+0xd8>
    8000590c:	00003517          	auipc	a0,0x3
    80005910:	d8450513          	addi	a0,a0,-636 # 80008690 <CONSOLE_STATUS+0x680>
    80005914:	00000097          	auipc	ra,0x0
    80005918:	718080e7          	jalr	1816(ra) # 8000602c <panic>

000000008000591c <clockintr>:
    8000591c:	fe010113          	addi	sp,sp,-32
    80005920:	00813823          	sd	s0,16(sp)
    80005924:	00913423          	sd	s1,8(sp)
    80005928:	00113c23          	sd	ra,24(sp)
    8000592c:	02010413          	addi	s0,sp,32
    80005930:	00007497          	auipc	s1,0x7
    80005934:	a6048493          	addi	s1,s1,-1440 # 8000c390 <tickslock>
    80005938:	00048513          	mv	a0,s1
    8000593c:	00001097          	auipc	ra,0x1
    80005940:	420080e7          	jalr	1056(ra) # 80006d5c <acquire>
    80005944:	00005717          	auipc	a4,0x5
    80005948:	72070713          	addi	a4,a4,1824 # 8000b064 <ticks>
    8000594c:	00072783          	lw	a5,0(a4)
    80005950:	01013403          	ld	s0,16(sp)
    80005954:	01813083          	ld	ra,24(sp)
    80005958:	00048513          	mv	a0,s1
    8000595c:	0017879b          	addiw	a5,a5,1
    80005960:	00813483          	ld	s1,8(sp)
    80005964:	00f72023          	sw	a5,0(a4)
    80005968:	02010113          	addi	sp,sp,32
    8000596c:	00001317          	auipc	t1,0x1
    80005970:	4bc30067          	jr	1212(t1) # 80006e28 <release>

0000000080005974 <devintr>:
    80005974:	142027f3          	csrr	a5,scause
    80005978:	00000513          	li	a0,0
    8000597c:	0007c463          	bltz	a5,80005984 <devintr+0x10>
    80005980:	00008067          	ret
    80005984:	fe010113          	addi	sp,sp,-32
    80005988:	00813823          	sd	s0,16(sp)
    8000598c:	00113c23          	sd	ra,24(sp)
    80005990:	00913423          	sd	s1,8(sp)
    80005994:	02010413          	addi	s0,sp,32
    80005998:	0ff7f713          	andi	a4,a5,255
    8000599c:	00900693          	li	a3,9
    800059a0:	04d70c63          	beq	a4,a3,800059f8 <devintr+0x84>
    800059a4:	fff00713          	li	a4,-1
    800059a8:	03f71713          	slli	a4,a4,0x3f
    800059ac:	00170713          	addi	a4,a4,1
    800059b0:	00e78c63          	beq	a5,a4,800059c8 <devintr+0x54>
    800059b4:	01813083          	ld	ra,24(sp)
    800059b8:	01013403          	ld	s0,16(sp)
    800059bc:	00813483          	ld	s1,8(sp)
    800059c0:	02010113          	addi	sp,sp,32
    800059c4:	00008067          	ret
    800059c8:	00000097          	auipc	ra,0x0
    800059cc:	c8c080e7          	jalr	-884(ra) # 80005654 <cpuid>
    800059d0:	06050663          	beqz	a0,80005a3c <devintr+0xc8>
    800059d4:	144027f3          	csrr	a5,sip
    800059d8:	ffd7f793          	andi	a5,a5,-3
    800059dc:	14479073          	csrw	sip,a5
    800059e0:	01813083          	ld	ra,24(sp)
    800059e4:	01013403          	ld	s0,16(sp)
    800059e8:	00813483          	ld	s1,8(sp)
    800059ec:	00200513          	li	a0,2
    800059f0:	02010113          	addi	sp,sp,32
    800059f4:	00008067          	ret
    800059f8:	00000097          	auipc	ra,0x0
    800059fc:	24c080e7          	jalr	588(ra) # 80005c44 <plic_claim>
    80005a00:	00a00793          	li	a5,10
    80005a04:	00050493          	mv	s1,a0
    80005a08:	06f50663          	beq	a0,a5,80005a74 <devintr+0x100>
    80005a0c:	00100513          	li	a0,1
    80005a10:	fa0482e3          	beqz	s1,800059b4 <devintr+0x40>
    80005a14:	00048593          	mv	a1,s1
    80005a18:	00003517          	auipc	a0,0x3
    80005a1c:	c9850513          	addi	a0,a0,-872 # 800086b0 <CONSOLE_STATUS+0x6a0>
    80005a20:	00000097          	auipc	ra,0x0
    80005a24:	668080e7          	jalr	1640(ra) # 80006088 <__printf>
    80005a28:	00048513          	mv	a0,s1
    80005a2c:	00000097          	auipc	ra,0x0
    80005a30:	250080e7          	jalr	592(ra) # 80005c7c <plic_complete>
    80005a34:	00100513          	li	a0,1
    80005a38:	f7dff06f          	j	800059b4 <devintr+0x40>
    80005a3c:	00007517          	auipc	a0,0x7
    80005a40:	95450513          	addi	a0,a0,-1708 # 8000c390 <tickslock>
    80005a44:	00001097          	auipc	ra,0x1
    80005a48:	318080e7          	jalr	792(ra) # 80006d5c <acquire>
    80005a4c:	00005717          	auipc	a4,0x5
    80005a50:	61870713          	addi	a4,a4,1560 # 8000b064 <ticks>
    80005a54:	00072783          	lw	a5,0(a4)
    80005a58:	00007517          	auipc	a0,0x7
    80005a5c:	93850513          	addi	a0,a0,-1736 # 8000c390 <tickslock>
    80005a60:	0017879b          	addiw	a5,a5,1
    80005a64:	00f72023          	sw	a5,0(a4)
    80005a68:	00001097          	auipc	ra,0x1
    80005a6c:	3c0080e7          	jalr	960(ra) # 80006e28 <release>
    80005a70:	f65ff06f          	j	800059d4 <devintr+0x60>
    80005a74:	00001097          	auipc	ra,0x1
    80005a78:	f1c080e7          	jalr	-228(ra) # 80006990 <uartintr>
    80005a7c:	fadff06f          	j	80005a28 <devintr+0xb4>

0000000080005a80 <kernelvec>:
    80005a80:	f0010113          	addi	sp,sp,-256
    80005a84:	00113023          	sd	ra,0(sp)
    80005a88:	00213423          	sd	sp,8(sp)
    80005a8c:	00313823          	sd	gp,16(sp)
    80005a90:	00413c23          	sd	tp,24(sp)
    80005a94:	02513023          	sd	t0,32(sp)
    80005a98:	02613423          	sd	t1,40(sp)
    80005a9c:	02713823          	sd	t2,48(sp)
    80005aa0:	02813c23          	sd	s0,56(sp)
    80005aa4:	04913023          	sd	s1,64(sp)
    80005aa8:	04a13423          	sd	a0,72(sp)
    80005aac:	04b13823          	sd	a1,80(sp)
    80005ab0:	04c13c23          	sd	a2,88(sp)
    80005ab4:	06d13023          	sd	a3,96(sp)
    80005ab8:	06e13423          	sd	a4,104(sp)
    80005abc:	06f13823          	sd	a5,112(sp)
    80005ac0:	07013c23          	sd	a6,120(sp)
    80005ac4:	09113023          	sd	a7,128(sp)
    80005ac8:	09213423          	sd	s2,136(sp)
    80005acc:	09313823          	sd	s3,144(sp)
    80005ad0:	09413c23          	sd	s4,152(sp)
    80005ad4:	0b513023          	sd	s5,160(sp)
    80005ad8:	0b613423          	sd	s6,168(sp)
    80005adc:	0b713823          	sd	s7,176(sp)
    80005ae0:	0b813c23          	sd	s8,184(sp)
    80005ae4:	0d913023          	sd	s9,192(sp)
    80005ae8:	0da13423          	sd	s10,200(sp)
    80005aec:	0db13823          	sd	s11,208(sp)
    80005af0:	0dc13c23          	sd	t3,216(sp)
    80005af4:	0fd13023          	sd	t4,224(sp)
    80005af8:	0fe13423          	sd	t5,232(sp)
    80005afc:	0ff13823          	sd	t6,240(sp)
    80005b00:	cd5ff0ef          	jal	ra,800057d4 <kerneltrap>
    80005b04:	00013083          	ld	ra,0(sp)
    80005b08:	00813103          	ld	sp,8(sp)
    80005b0c:	01013183          	ld	gp,16(sp)
    80005b10:	02013283          	ld	t0,32(sp)
    80005b14:	02813303          	ld	t1,40(sp)
    80005b18:	03013383          	ld	t2,48(sp)
    80005b1c:	03813403          	ld	s0,56(sp)
    80005b20:	04013483          	ld	s1,64(sp)
    80005b24:	04813503          	ld	a0,72(sp)
    80005b28:	05013583          	ld	a1,80(sp)
    80005b2c:	05813603          	ld	a2,88(sp)
    80005b30:	06013683          	ld	a3,96(sp)
    80005b34:	06813703          	ld	a4,104(sp)
    80005b38:	07013783          	ld	a5,112(sp)
    80005b3c:	07813803          	ld	a6,120(sp)
    80005b40:	08013883          	ld	a7,128(sp)
    80005b44:	08813903          	ld	s2,136(sp)
    80005b48:	09013983          	ld	s3,144(sp)
    80005b4c:	09813a03          	ld	s4,152(sp)
    80005b50:	0a013a83          	ld	s5,160(sp)
    80005b54:	0a813b03          	ld	s6,168(sp)
    80005b58:	0b013b83          	ld	s7,176(sp)
    80005b5c:	0b813c03          	ld	s8,184(sp)
    80005b60:	0c013c83          	ld	s9,192(sp)
    80005b64:	0c813d03          	ld	s10,200(sp)
    80005b68:	0d013d83          	ld	s11,208(sp)
    80005b6c:	0d813e03          	ld	t3,216(sp)
    80005b70:	0e013e83          	ld	t4,224(sp)
    80005b74:	0e813f03          	ld	t5,232(sp)
    80005b78:	0f013f83          	ld	t6,240(sp)
    80005b7c:	10010113          	addi	sp,sp,256
    80005b80:	10200073          	sret
    80005b84:	00000013          	nop
    80005b88:	00000013          	nop
    80005b8c:	00000013          	nop

0000000080005b90 <timervec>:
    80005b90:	34051573          	csrrw	a0,mscratch,a0
    80005b94:	00b53023          	sd	a1,0(a0)
    80005b98:	00c53423          	sd	a2,8(a0)
    80005b9c:	00d53823          	sd	a3,16(a0)
    80005ba0:	01853583          	ld	a1,24(a0)
    80005ba4:	02053603          	ld	a2,32(a0)
    80005ba8:	0005b683          	ld	a3,0(a1)
    80005bac:	00c686b3          	add	a3,a3,a2
    80005bb0:	00d5b023          	sd	a3,0(a1)
    80005bb4:	00200593          	li	a1,2
    80005bb8:	14459073          	csrw	sip,a1
    80005bbc:	01053683          	ld	a3,16(a0)
    80005bc0:	00853603          	ld	a2,8(a0)
    80005bc4:	00053583          	ld	a1,0(a0)
    80005bc8:	34051573          	csrrw	a0,mscratch,a0
    80005bcc:	30200073          	mret

0000000080005bd0 <plicinit>:
    80005bd0:	ff010113          	addi	sp,sp,-16
    80005bd4:	00813423          	sd	s0,8(sp)
    80005bd8:	01010413          	addi	s0,sp,16
    80005bdc:	00813403          	ld	s0,8(sp)
    80005be0:	0c0007b7          	lui	a5,0xc000
    80005be4:	00100713          	li	a4,1
    80005be8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80005bec:	00e7a223          	sw	a4,4(a5)
    80005bf0:	01010113          	addi	sp,sp,16
    80005bf4:	00008067          	ret

0000000080005bf8 <plicinithart>:
    80005bf8:	ff010113          	addi	sp,sp,-16
    80005bfc:	00813023          	sd	s0,0(sp)
    80005c00:	00113423          	sd	ra,8(sp)
    80005c04:	01010413          	addi	s0,sp,16
    80005c08:	00000097          	auipc	ra,0x0
    80005c0c:	a4c080e7          	jalr	-1460(ra) # 80005654 <cpuid>
    80005c10:	0085171b          	slliw	a4,a0,0x8
    80005c14:	0c0027b7          	lui	a5,0xc002
    80005c18:	00e787b3          	add	a5,a5,a4
    80005c1c:	40200713          	li	a4,1026
    80005c20:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005c24:	00813083          	ld	ra,8(sp)
    80005c28:	00013403          	ld	s0,0(sp)
    80005c2c:	00d5151b          	slliw	a0,a0,0xd
    80005c30:	0c2017b7          	lui	a5,0xc201
    80005c34:	00a78533          	add	a0,a5,a0
    80005c38:	00052023          	sw	zero,0(a0)
    80005c3c:	01010113          	addi	sp,sp,16
    80005c40:	00008067          	ret

0000000080005c44 <plic_claim>:
    80005c44:	ff010113          	addi	sp,sp,-16
    80005c48:	00813023          	sd	s0,0(sp)
    80005c4c:	00113423          	sd	ra,8(sp)
    80005c50:	01010413          	addi	s0,sp,16
    80005c54:	00000097          	auipc	ra,0x0
    80005c58:	a00080e7          	jalr	-1536(ra) # 80005654 <cpuid>
    80005c5c:	00813083          	ld	ra,8(sp)
    80005c60:	00013403          	ld	s0,0(sp)
    80005c64:	00d5151b          	slliw	a0,a0,0xd
    80005c68:	0c2017b7          	lui	a5,0xc201
    80005c6c:	00a78533          	add	a0,a5,a0
    80005c70:	00452503          	lw	a0,4(a0)
    80005c74:	01010113          	addi	sp,sp,16
    80005c78:	00008067          	ret

0000000080005c7c <plic_complete>:
    80005c7c:	fe010113          	addi	sp,sp,-32
    80005c80:	00813823          	sd	s0,16(sp)
    80005c84:	00913423          	sd	s1,8(sp)
    80005c88:	00113c23          	sd	ra,24(sp)
    80005c8c:	02010413          	addi	s0,sp,32
    80005c90:	00050493          	mv	s1,a0
    80005c94:	00000097          	auipc	ra,0x0
    80005c98:	9c0080e7          	jalr	-1600(ra) # 80005654 <cpuid>
    80005c9c:	01813083          	ld	ra,24(sp)
    80005ca0:	01013403          	ld	s0,16(sp)
    80005ca4:	00d5179b          	slliw	a5,a0,0xd
    80005ca8:	0c201737          	lui	a4,0xc201
    80005cac:	00f707b3          	add	a5,a4,a5
    80005cb0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005cb4:	00813483          	ld	s1,8(sp)
    80005cb8:	02010113          	addi	sp,sp,32
    80005cbc:	00008067          	ret

0000000080005cc0 <consolewrite>:
    80005cc0:	fb010113          	addi	sp,sp,-80
    80005cc4:	04813023          	sd	s0,64(sp)
    80005cc8:	04113423          	sd	ra,72(sp)
    80005ccc:	02913c23          	sd	s1,56(sp)
    80005cd0:	03213823          	sd	s2,48(sp)
    80005cd4:	03313423          	sd	s3,40(sp)
    80005cd8:	03413023          	sd	s4,32(sp)
    80005cdc:	01513c23          	sd	s5,24(sp)
    80005ce0:	05010413          	addi	s0,sp,80
    80005ce4:	06c05c63          	blez	a2,80005d5c <consolewrite+0x9c>
    80005ce8:	00060993          	mv	s3,a2
    80005cec:	00050a13          	mv	s4,a0
    80005cf0:	00058493          	mv	s1,a1
    80005cf4:	00000913          	li	s2,0
    80005cf8:	fff00a93          	li	s5,-1
    80005cfc:	01c0006f          	j	80005d18 <consolewrite+0x58>
    80005d00:	fbf44503          	lbu	a0,-65(s0)
    80005d04:	0019091b          	addiw	s2,s2,1
    80005d08:	00148493          	addi	s1,s1,1
    80005d0c:	00001097          	auipc	ra,0x1
    80005d10:	a9c080e7          	jalr	-1380(ra) # 800067a8 <uartputc>
    80005d14:	03298063          	beq	s3,s2,80005d34 <consolewrite+0x74>
    80005d18:	00048613          	mv	a2,s1
    80005d1c:	00100693          	li	a3,1
    80005d20:	000a0593          	mv	a1,s4
    80005d24:	fbf40513          	addi	a0,s0,-65
    80005d28:	00000097          	auipc	ra,0x0
    80005d2c:	9e4080e7          	jalr	-1564(ra) # 8000570c <either_copyin>
    80005d30:	fd5518e3          	bne	a0,s5,80005d00 <consolewrite+0x40>
    80005d34:	04813083          	ld	ra,72(sp)
    80005d38:	04013403          	ld	s0,64(sp)
    80005d3c:	03813483          	ld	s1,56(sp)
    80005d40:	02813983          	ld	s3,40(sp)
    80005d44:	02013a03          	ld	s4,32(sp)
    80005d48:	01813a83          	ld	s5,24(sp)
    80005d4c:	00090513          	mv	a0,s2
    80005d50:	03013903          	ld	s2,48(sp)
    80005d54:	05010113          	addi	sp,sp,80
    80005d58:	00008067          	ret
    80005d5c:	00000913          	li	s2,0
    80005d60:	fd5ff06f          	j	80005d34 <consolewrite+0x74>

0000000080005d64 <consoleread>:
    80005d64:	f9010113          	addi	sp,sp,-112
    80005d68:	06813023          	sd	s0,96(sp)
    80005d6c:	04913c23          	sd	s1,88(sp)
    80005d70:	05213823          	sd	s2,80(sp)
    80005d74:	05313423          	sd	s3,72(sp)
    80005d78:	05413023          	sd	s4,64(sp)
    80005d7c:	03513c23          	sd	s5,56(sp)
    80005d80:	03613823          	sd	s6,48(sp)
    80005d84:	03713423          	sd	s7,40(sp)
    80005d88:	03813023          	sd	s8,32(sp)
    80005d8c:	06113423          	sd	ra,104(sp)
    80005d90:	01913c23          	sd	s9,24(sp)
    80005d94:	07010413          	addi	s0,sp,112
    80005d98:	00060b93          	mv	s7,a2
    80005d9c:	00050913          	mv	s2,a0
    80005da0:	00058c13          	mv	s8,a1
    80005da4:	00060b1b          	sext.w	s6,a2
    80005da8:	00006497          	auipc	s1,0x6
    80005dac:	61048493          	addi	s1,s1,1552 # 8000c3b8 <cons>
    80005db0:	00400993          	li	s3,4
    80005db4:	fff00a13          	li	s4,-1
    80005db8:	00a00a93          	li	s5,10
    80005dbc:	05705e63          	blez	s7,80005e18 <consoleread+0xb4>
    80005dc0:	09c4a703          	lw	a4,156(s1)
    80005dc4:	0984a783          	lw	a5,152(s1)
    80005dc8:	0007071b          	sext.w	a4,a4
    80005dcc:	08e78463          	beq	a5,a4,80005e54 <consoleread+0xf0>
    80005dd0:	07f7f713          	andi	a4,a5,127
    80005dd4:	00e48733          	add	a4,s1,a4
    80005dd8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005ddc:	0017869b          	addiw	a3,a5,1
    80005de0:	08d4ac23          	sw	a3,152(s1)
    80005de4:	00070c9b          	sext.w	s9,a4
    80005de8:	0b370663          	beq	a4,s3,80005e94 <consoleread+0x130>
    80005dec:	00100693          	li	a3,1
    80005df0:	f9f40613          	addi	a2,s0,-97
    80005df4:	000c0593          	mv	a1,s8
    80005df8:	00090513          	mv	a0,s2
    80005dfc:	f8e40fa3          	sb	a4,-97(s0)
    80005e00:	00000097          	auipc	ra,0x0
    80005e04:	8c0080e7          	jalr	-1856(ra) # 800056c0 <either_copyout>
    80005e08:	01450863          	beq	a0,s4,80005e18 <consoleread+0xb4>
    80005e0c:	001c0c13          	addi	s8,s8,1
    80005e10:	fffb8b9b          	addiw	s7,s7,-1
    80005e14:	fb5c94e3          	bne	s9,s5,80005dbc <consoleread+0x58>
    80005e18:	000b851b          	sext.w	a0,s7
    80005e1c:	06813083          	ld	ra,104(sp)
    80005e20:	06013403          	ld	s0,96(sp)
    80005e24:	05813483          	ld	s1,88(sp)
    80005e28:	05013903          	ld	s2,80(sp)
    80005e2c:	04813983          	ld	s3,72(sp)
    80005e30:	04013a03          	ld	s4,64(sp)
    80005e34:	03813a83          	ld	s5,56(sp)
    80005e38:	02813b83          	ld	s7,40(sp)
    80005e3c:	02013c03          	ld	s8,32(sp)
    80005e40:	01813c83          	ld	s9,24(sp)
    80005e44:	40ab053b          	subw	a0,s6,a0
    80005e48:	03013b03          	ld	s6,48(sp)
    80005e4c:	07010113          	addi	sp,sp,112
    80005e50:	00008067          	ret
    80005e54:	00001097          	auipc	ra,0x1
    80005e58:	1d8080e7          	jalr	472(ra) # 8000702c <push_on>
    80005e5c:	0984a703          	lw	a4,152(s1)
    80005e60:	09c4a783          	lw	a5,156(s1)
    80005e64:	0007879b          	sext.w	a5,a5
    80005e68:	fef70ce3          	beq	a4,a5,80005e60 <consoleread+0xfc>
    80005e6c:	00001097          	auipc	ra,0x1
    80005e70:	234080e7          	jalr	564(ra) # 800070a0 <pop_on>
    80005e74:	0984a783          	lw	a5,152(s1)
    80005e78:	07f7f713          	andi	a4,a5,127
    80005e7c:	00e48733          	add	a4,s1,a4
    80005e80:	01874703          	lbu	a4,24(a4)
    80005e84:	0017869b          	addiw	a3,a5,1
    80005e88:	08d4ac23          	sw	a3,152(s1)
    80005e8c:	00070c9b          	sext.w	s9,a4
    80005e90:	f5371ee3          	bne	a4,s3,80005dec <consoleread+0x88>
    80005e94:	000b851b          	sext.w	a0,s7
    80005e98:	f96bf2e3          	bgeu	s7,s6,80005e1c <consoleread+0xb8>
    80005e9c:	08f4ac23          	sw	a5,152(s1)
    80005ea0:	f7dff06f          	j	80005e1c <consoleread+0xb8>

0000000080005ea4 <consputc>:
    80005ea4:	10000793          	li	a5,256
    80005ea8:	00f50663          	beq	a0,a5,80005eb4 <consputc+0x10>
    80005eac:	00001317          	auipc	t1,0x1
    80005eb0:	9f430067          	jr	-1548(t1) # 800068a0 <uartputc_sync>
    80005eb4:	ff010113          	addi	sp,sp,-16
    80005eb8:	00113423          	sd	ra,8(sp)
    80005ebc:	00813023          	sd	s0,0(sp)
    80005ec0:	01010413          	addi	s0,sp,16
    80005ec4:	00800513          	li	a0,8
    80005ec8:	00001097          	auipc	ra,0x1
    80005ecc:	9d8080e7          	jalr	-1576(ra) # 800068a0 <uartputc_sync>
    80005ed0:	02000513          	li	a0,32
    80005ed4:	00001097          	auipc	ra,0x1
    80005ed8:	9cc080e7          	jalr	-1588(ra) # 800068a0 <uartputc_sync>
    80005edc:	00013403          	ld	s0,0(sp)
    80005ee0:	00813083          	ld	ra,8(sp)
    80005ee4:	00800513          	li	a0,8
    80005ee8:	01010113          	addi	sp,sp,16
    80005eec:	00001317          	auipc	t1,0x1
    80005ef0:	9b430067          	jr	-1612(t1) # 800068a0 <uartputc_sync>

0000000080005ef4 <consoleintr>:
    80005ef4:	fe010113          	addi	sp,sp,-32
    80005ef8:	00813823          	sd	s0,16(sp)
    80005efc:	00913423          	sd	s1,8(sp)
    80005f00:	01213023          	sd	s2,0(sp)
    80005f04:	00113c23          	sd	ra,24(sp)
    80005f08:	02010413          	addi	s0,sp,32
    80005f0c:	00006917          	auipc	s2,0x6
    80005f10:	4ac90913          	addi	s2,s2,1196 # 8000c3b8 <cons>
    80005f14:	00050493          	mv	s1,a0
    80005f18:	00090513          	mv	a0,s2
    80005f1c:	00001097          	auipc	ra,0x1
    80005f20:	e40080e7          	jalr	-448(ra) # 80006d5c <acquire>
    80005f24:	02048c63          	beqz	s1,80005f5c <consoleintr+0x68>
    80005f28:	0a092783          	lw	a5,160(s2)
    80005f2c:	09892703          	lw	a4,152(s2)
    80005f30:	07f00693          	li	a3,127
    80005f34:	40e7873b          	subw	a4,a5,a4
    80005f38:	02e6e263          	bltu	a3,a4,80005f5c <consoleintr+0x68>
    80005f3c:	00d00713          	li	a4,13
    80005f40:	04e48063          	beq	s1,a4,80005f80 <consoleintr+0x8c>
    80005f44:	07f7f713          	andi	a4,a5,127
    80005f48:	00e90733          	add	a4,s2,a4
    80005f4c:	0017879b          	addiw	a5,a5,1
    80005f50:	0af92023          	sw	a5,160(s2)
    80005f54:	00970c23          	sb	s1,24(a4)
    80005f58:	08f92e23          	sw	a5,156(s2)
    80005f5c:	01013403          	ld	s0,16(sp)
    80005f60:	01813083          	ld	ra,24(sp)
    80005f64:	00813483          	ld	s1,8(sp)
    80005f68:	00013903          	ld	s2,0(sp)
    80005f6c:	00006517          	auipc	a0,0x6
    80005f70:	44c50513          	addi	a0,a0,1100 # 8000c3b8 <cons>
    80005f74:	02010113          	addi	sp,sp,32
    80005f78:	00001317          	auipc	t1,0x1
    80005f7c:	eb030067          	jr	-336(t1) # 80006e28 <release>
    80005f80:	00a00493          	li	s1,10
    80005f84:	fc1ff06f          	j	80005f44 <consoleintr+0x50>

0000000080005f88 <consoleinit>:
    80005f88:	fe010113          	addi	sp,sp,-32
    80005f8c:	00113c23          	sd	ra,24(sp)
    80005f90:	00813823          	sd	s0,16(sp)
    80005f94:	00913423          	sd	s1,8(sp)
    80005f98:	02010413          	addi	s0,sp,32
    80005f9c:	00006497          	auipc	s1,0x6
    80005fa0:	41c48493          	addi	s1,s1,1052 # 8000c3b8 <cons>
    80005fa4:	00048513          	mv	a0,s1
    80005fa8:	00002597          	auipc	a1,0x2
    80005fac:	76058593          	addi	a1,a1,1888 # 80008708 <CONSOLE_STATUS+0x6f8>
    80005fb0:	00001097          	auipc	ra,0x1
    80005fb4:	d88080e7          	jalr	-632(ra) # 80006d38 <initlock>
    80005fb8:	00000097          	auipc	ra,0x0
    80005fbc:	7ac080e7          	jalr	1964(ra) # 80006764 <uartinit>
    80005fc0:	01813083          	ld	ra,24(sp)
    80005fc4:	01013403          	ld	s0,16(sp)
    80005fc8:	00000797          	auipc	a5,0x0
    80005fcc:	d9c78793          	addi	a5,a5,-612 # 80005d64 <consoleread>
    80005fd0:	0af4bc23          	sd	a5,184(s1)
    80005fd4:	00000797          	auipc	a5,0x0
    80005fd8:	cec78793          	addi	a5,a5,-788 # 80005cc0 <consolewrite>
    80005fdc:	0cf4b023          	sd	a5,192(s1)
    80005fe0:	00813483          	ld	s1,8(sp)
    80005fe4:	02010113          	addi	sp,sp,32
    80005fe8:	00008067          	ret

0000000080005fec <console_read>:
    80005fec:	ff010113          	addi	sp,sp,-16
    80005ff0:	00813423          	sd	s0,8(sp)
    80005ff4:	01010413          	addi	s0,sp,16
    80005ff8:	00813403          	ld	s0,8(sp)
    80005ffc:	00006317          	auipc	t1,0x6
    80006000:	47433303          	ld	t1,1140(t1) # 8000c470 <devsw+0x10>
    80006004:	01010113          	addi	sp,sp,16
    80006008:	00030067          	jr	t1

000000008000600c <console_write>:
    8000600c:	ff010113          	addi	sp,sp,-16
    80006010:	00813423          	sd	s0,8(sp)
    80006014:	01010413          	addi	s0,sp,16
    80006018:	00813403          	ld	s0,8(sp)
    8000601c:	00006317          	auipc	t1,0x6
    80006020:	45c33303          	ld	t1,1116(t1) # 8000c478 <devsw+0x18>
    80006024:	01010113          	addi	sp,sp,16
    80006028:	00030067          	jr	t1

000000008000602c <panic>:
    8000602c:	fe010113          	addi	sp,sp,-32
    80006030:	00113c23          	sd	ra,24(sp)
    80006034:	00813823          	sd	s0,16(sp)
    80006038:	00913423          	sd	s1,8(sp)
    8000603c:	02010413          	addi	s0,sp,32
    80006040:	00050493          	mv	s1,a0
    80006044:	00002517          	auipc	a0,0x2
    80006048:	6cc50513          	addi	a0,a0,1740 # 80008710 <CONSOLE_STATUS+0x700>
    8000604c:	00006797          	auipc	a5,0x6
    80006050:	4c07a623          	sw	zero,1228(a5) # 8000c518 <pr+0x18>
    80006054:	00000097          	auipc	ra,0x0
    80006058:	034080e7          	jalr	52(ra) # 80006088 <__printf>
    8000605c:	00048513          	mv	a0,s1
    80006060:	00000097          	auipc	ra,0x0
    80006064:	028080e7          	jalr	40(ra) # 80006088 <__printf>
    80006068:	00002517          	auipc	a0,0x2
    8000606c:	0b850513          	addi	a0,a0,184 # 80008120 <CONSOLE_STATUS+0x110>
    80006070:	00000097          	auipc	ra,0x0
    80006074:	018080e7          	jalr	24(ra) # 80006088 <__printf>
    80006078:	00100793          	li	a5,1
    8000607c:	00005717          	auipc	a4,0x5
    80006080:	fef72623          	sw	a5,-20(a4) # 8000b068 <panicked>
    80006084:	0000006f          	j	80006084 <panic+0x58>

0000000080006088 <__printf>:
    80006088:	f3010113          	addi	sp,sp,-208
    8000608c:	08813023          	sd	s0,128(sp)
    80006090:	07313423          	sd	s3,104(sp)
    80006094:	09010413          	addi	s0,sp,144
    80006098:	05813023          	sd	s8,64(sp)
    8000609c:	08113423          	sd	ra,136(sp)
    800060a0:	06913c23          	sd	s1,120(sp)
    800060a4:	07213823          	sd	s2,112(sp)
    800060a8:	07413023          	sd	s4,96(sp)
    800060ac:	05513c23          	sd	s5,88(sp)
    800060b0:	05613823          	sd	s6,80(sp)
    800060b4:	05713423          	sd	s7,72(sp)
    800060b8:	03913c23          	sd	s9,56(sp)
    800060bc:	03a13823          	sd	s10,48(sp)
    800060c0:	03b13423          	sd	s11,40(sp)
    800060c4:	00006317          	auipc	t1,0x6
    800060c8:	43c30313          	addi	t1,t1,1084 # 8000c500 <pr>
    800060cc:	01832c03          	lw	s8,24(t1)
    800060d0:	00b43423          	sd	a1,8(s0)
    800060d4:	00c43823          	sd	a2,16(s0)
    800060d8:	00d43c23          	sd	a3,24(s0)
    800060dc:	02e43023          	sd	a4,32(s0)
    800060e0:	02f43423          	sd	a5,40(s0)
    800060e4:	03043823          	sd	a6,48(s0)
    800060e8:	03143c23          	sd	a7,56(s0)
    800060ec:	00050993          	mv	s3,a0
    800060f0:	4a0c1663          	bnez	s8,8000659c <__printf+0x514>
    800060f4:	60098c63          	beqz	s3,8000670c <__printf+0x684>
    800060f8:	0009c503          	lbu	a0,0(s3)
    800060fc:	00840793          	addi	a5,s0,8
    80006100:	f6f43c23          	sd	a5,-136(s0)
    80006104:	00000493          	li	s1,0
    80006108:	22050063          	beqz	a0,80006328 <__printf+0x2a0>
    8000610c:	00002a37          	lui	s4,0x2
    80006110:	00018ab7          	lui	s5,0x18
    80006114:	000f4b37          	lui	s6,0xf4
    80006118:	00989bb7          	lui	s7,0x989
    8000611c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006120:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006124:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006128:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000612c:	00148c9b          	addiw	s9,s1,1
    80006130:	02500793          	li	a5,37
    80006134:	01998933          	add	s2,s3,s9
    80006138:	38f51263          	bne	a0,a5,800064bc <__printf+0x434>
    8000613c:	00094783          	lbu	a5,0(s2)
    80006140:	00078c9b          	sext.w	s9,a5
    80006144:	1e078263          	beqz	a5,80006328 <__printf+0x2a0>
    80006148:	0024849b          	addiw	s1,s1,2
    8000614c:	07000713          	li	a4,112
    80006150:	00998933          	add	s2,s3,s1
    80006154:	38e78a63          	beq	a5,a4,800064e8 <__printf+0x460>
    80006158:	20f76863          	bltu	a4,a5,80006368 <__printf+0x2e0>
    8000615c:	42a78863          	beq	a5,a0,8000658c <__printf+0x504>
    80006160:	06400713          	li	a4,100
    80006164:	40e79663          	bne	a5,a4,80006570 <__printf+0x4e8>
    80006168:	f7843783          	ld	a5,-136(s0)
    8000616c:	0007a603          	lw	a2,0(a5)
    80006170:	00878793          	addi	a5,a5,8
    80006174:	f6f43c23          	sd	a5,-136(s0)
    80006178:	42064a63          	bltz	a2,800065ac <__printf+0x524>
    8000617c:	00a00713          	li	a4,10
    80006180:	02e677bb          	remuw	a5,a2,a4
    80006184:	00002d97          	auipc	s11,0x2
    80006188:	5b4d8d93          	addi	s11,s11,1460 # 80008738 <digits>
    8000618c:	00900593          	li	a1,9
    80006190:	0006051b          	sext.w	a0,a2
    80006194:	00000c93          	li	s9,0
    80006198:	02079793          	slli	a5,a5,0x20
    8000619c:	0207d793          	srli	a5,a5,0x20
    800061a0:	00fd87b3          	add	a5,s11,a5
    800061a4:	0007c783          	lbu	a5,0(a5)
    800061a8:	02e656bb          	divuw	a3,a2,a4
    800061ac:	f8f40023          	sb	a5,-128(s0)
    800061b0:	14c5d863          	bge	a1,a2,80006300 <__printf+0x278>
    800061b4:	06300593          	li	a1,99
    800061b8:	00100c93          	li	s9,1
    800061bc:	02e6f7bb          	remuw	a5,a3,a4
    800061c0:	02079793          	slli	a5,a5,0x20
    800061c4:	0207d793          	srli	a5,a5,0x20
    800061c8:	00fd87b3          	add	a5,s11,a5
    800061cc:	0007c783          	lbu	a5,0(a5)
    800061d0:	02e6d73b          	divuw	a4,a3,a4
    800061d4:	f8f400a3          	sb	a5,-127(s0)
    800061d8:	12a5f463          	bgeu	a1,a0,80006300 <__printf+0x278>
    800061dc:	00a00693          	li	a3,10
    800061e0:	00900593          	li	a1,9
    800061e4:	02d777bb          	remuw	a5,a4,a3
    800061e8:	02079793          	slli	a5,a5,0x20
    800061ec:	0207d793          	srli	a5,a5,0x20
    800061f0:	00fd87b3          	add	a5,s11,a5
    800061f4:	0007c503          	lbu	a0,0(a5)
    800061f8:	02d757bb          	divuw	a5,a4,a3
    800061fc:	f8a40123          	sb	a0,-126(s0)
    80006200:	48e5f263          	bgeu	a1,a4,80006684 <__printf+0x5fc>
    80006204:	06300513          	li	a0,99
    80006208:	02d7f5bb          	remuw	a1,a5,a3
    8000620c:	02059593          	slli	a1,a1,0x20
    80006210:	0205d593          	srli	a1,a1,0x20
    80006214:	00bd85b3          	add	a1,s11,a1
    80006218:	0005c583          	lbu	a1,0(a1)
    8000621c:	02d7d7bb          	divuw	a5,a5,a3
    80006220:	f8b401a3          	sb	a1,-125(s0)
    80006224:	48e57263          	bgeu	a0,a4,800066a8 <__printf+0x620>
    80006228:	3e700513          	li	a0,999
    8000622c:	02d7f5bb          	remuw	a1,a5,a3
    80006230:	02059593          	slli	a1,a1,0x20
    80006234:	0205d593          	srli	a1,a1,0x20
    80006238:	00bd85b3          	add	a1,s11,a1
    8000623c:	0005c583          	lbu	a1,0(a1)
    80006240:	02d7d7bb          	divuw	a5,a5,a3
    80006244:	f8b40223          	sb	a1,-124(s0)
    80006248:	46e57663          	bgeu	a0,a4,800066b4 <__printf+0x62c>
    8000624c:	02d7f5bb          	remuw	a1,a5,a3
    80006250:	02059593          	slli	a1,a1,0x20
    80006254:	0205d593          	srli	a1,a1,0x20
    80006258:	00bd85b3          	add	a1,s11,a1
    8000625c:	0005c583          	lbu	a1,0(a1)
    80006260:	02d7d7bb          	divuw	a5,a5,a3
    80006264:	f8b402a3          	sb	a1,-123(s0)
    80006268:	46ea7863          	bgeu	s4,a4,800066d8 <__printf+0x650>
    8000626c:	02d7f5bb          	remuw	a1,a5,a3
    80006270:	02059593          	slli	a1,a1,0x20
    80006274:	0205d593          	srli	a1,a1,0x20
    80006278:	00bd85b3          	add	a1,s11,a1
    8000627c:	0005c583          	lbu	a1,0(a1)
    80006280:	02d7d7bb          	divuw	a5,a5,a3
    80006284:	f8b40323          	sb	a1,-122(s0)
    80006288:	3eeaf863          	bgeu	s5,a4,80006678 <__printf+0x5f0>
    8000628c:	02d7f5bb          	remuw	a1,a5,a3
    80006290:	02059593          	slli	a1,a1,0x20
    80006294:	0205d593          	srli	a1,a1,0x20
    80006298:	00bd85b3          	add	a1,s11,a1
    8000629c:	0005c583          	lbu	a1,0(a1)
    800062a0:	02d7d7bb          	divuw	a5,a5,a3
    800062a4:	f8b403a3          	sb	a1,-121(s0)
    800062a8:	42eb7e63          	bgeu	s6,a4,800066e4 <__printf+0x65c>
    800062ac:	02d7f5bb          	remuw	a1,a5,a3
    800062b0:	02059593          	slli	a1,a1,0x20
    800062b4:	0205d593          	srli	a1,a1,0x20
    800062b8:	00bd85b3          	add	a1,s11,a1
    800062bc:	0005c583          	lbu	a1,0(a1)
    800062c0:	02d7d7bb          	divuw	a5,a5,a3
    800062c4:	f8b40423          	sb	a1,-120(s0)
    800062c8:	42ebfc63          	bgeu	s7,a4,80006700 <__printf+0x678>
    800062cc:	02079793          	slli	a5,a5,0x20
    800062d0:	0207d793          	srli	a5,a5,0x20
    800062d4:	00fd8db3          	add	s11,s11,a5
    800062d8:	000dc703          	lbu	a4,0(s11)
    800062dc:	00a00793          	li	a5,10
    800062e0:	00900c93          	li	s9,9
    800062e4:	f8e404a3          	sb	a4,-119(s0)
    800062e8:	00065c63          	bgez	a2,80006300 <__printf+0x278>
    800062ec:	f9040713          	addi	a4,s0,-112
    800062f0:	00f70733          	add	a4,a4,a5
    800062f4:	02d00693          	li	a3,45
    800062f8:	fed70823          	sb	a3,-16(a4)
    800062fc:	00078c93          	mv	s9,a5
    80006300:	f8040793          	addi	a5,s0,-128
    80006304:	01978cb3          	add	s9,a5,s9
    80006308:	f7f40d13          	addi	s10,s0,-129
    8000630c:	000cc503          	lbu	a0,0(s9)
    80006310:	fffc8c93          	addi	s9,s9,-1
    80006314:	00000097          	auipc	ra,0x0
    80006318:	b90080e7          	jalr	-1136(ra) # 80005ea4 <consputc>
    8000631c:	ffac98e3          	bne	s9,s10,8000630c <__printf+0x284>
    80006320:	00094503          	lbu	a0,0(s2)
    80006324:	e00514e3          	bnez	a0,8000612c <__printf+0xa4>
    80006328:	1a0c1663          	bnez	s8,800064d4 <__printf+0x44c>
    8000632c:	08813083          	ld	ra,136(sp)
    80006330:	08013403          	ld	s0,128(sp)
    80006334:	07813483          	ld	s1,120(sp)
    80006338:	07013903          	ld	s2,112(sp)
    8000633c:	06813983          	ld	s3,104(sp)
    80006340:	06013a03          	ld	s4,96(sp)
    80006344:	05813a83          	ld	s5,88(sp)
    80006348:	05013b03          	ld	s6,80(sp)
    8000634c:	04813b83          	ld	s7,72(sp)
    80006350:	04013c03          	ld	s8,64(sp)
    80006354:	03813c83          	ld	s9,56(sp)
    80006358:	03013d03          	ld	s10,48(sp)
    8000635c:	02813d83          	ld	s11,40(sp)
    80006360:	0d010113          	addi	sp,sp,208
    80006364:	00008067          	ret
    80006368:	07300713          	li	a4,115
    8000636c:	1ce78a63          	beq	a5,a4,80006540 <__printf+0x4b8>
    80006370:	07800713          	li	a4,120
    80006374:	1ee79e63          	bne	a5,a4,80006570 <__printf+0x4e8>
    80006378:	f7843783          	ld	a5,-136(s0)
    8000637c:	0007a703          	lw	a4,0(a5)
    80006380:	00878793          	addi	a5,a5,8
    80006384:	f6f43c23          	sd	a5,-136(s0)
    80006388:	28074263          	bltz	a4,8000660c <__printf+0x584>
    8000638c:	00002d97          	auipc	s11,0x2
    80006390:	3acd8d93          	addi	s11,s11,940 # 80008738 <digits>
    80006394:	00f77793          	andi	a5,a4,15
    80006398:	00fd87b3          	add	a5,s11,a5
    8000639c:	0007c683          	lbu	a3,0(a5)
    800063a0:	00f00613          	li	a2,15
    800063a4:	0007079b          	sext.w	a5,a4
    800063a8:	f8d40023          	sb	a3,-128(s0)
    800063ac:	0047559b          	srliw	a1,a4,0x4
    800063b0:	0047569b          	srliw	a3,a4,0x4
    800063b4:	00000c93          	li	s9,0
    800063b8:	0ee65063          	bge	a2,a4,80006498 <__printf+0x410>
    800063bc:	00f6f693          	andi	a3,a3,15
    800063c0:	00dd86b3          	add	a3,s11,a3
    800063c4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800063c8:	0087d79b          	srliw	a5,a5,0x8
    800063cc:	00100c93          	li	s9,1
    800063d0:	f8d400a3          	sb	a3,-127(s0)
    800063d4:	0cb67263          	bgeu	a2,a1,80006498 <__printf+0x410>
    800063d8:	00f7f693          	andi	a3,a5,15
    800063dc:	00dd86b3          	add	a3,s11,a3
    800063e0:	0006c583          	lbu	a1,0(a3)
    800063e4:	00f00613          	li	a2,15
    800063e8:	0047d69b          	srliw	a3,a5,0x4
    800063ec:	f8b40123          	sb	a1,-126(s0)
    800063f0:	0047d593          	srli	a1,a5,0x4
    800063f4:	28f67e63          	bgeu	a2,a5,80006690 <__printf+0x608>
    800063f8:	00f6f693          	andi	a3,a3,15
    800063fc:	00dd86b3          	add	a3,s11,a3
    80006400:	0006c503          	lbu	a0,0(a3)
    80006404:	0087d813          	srli	a6,a5,0x8
    80006408:	0087d69b          	srliw	a3,a5,0x8
    8000640c:	f8a401a3          	sb	a0,-125(s0)
    80006410:	28b67663          	bgeu	a2,a1,8000669c <__printf+0x614>
    80006414:	00f6f693          	andi	a3,a3,15
    80006418:	00dd86b3          	add	a3,s11,a3
    8000641c:	0006c583          	lbu	a1,0(a3)
    80006420:	00c7d513          	srli	a0,a5,0xc
    80006424:	00c7d69b          	srliw	a3,a5,0xc
    80006428:	f8b40223          	sb	a1,-124(s0)
    8000642c:	29067a63          	bgeu	a2,a6,800066c0 <__printf+0x638>
    80006430:	00f6f693          	andi	a3,a3,15
    80006434:	00dd86b3          	add	a3,s11,a3
    80006438:	0006c583          	lbu	a1,0(a3)
    8000643c:	0107d813          	srli	a6,a5,0x10
    80006440:	0107d69b          	srliw	a3,a5,0x10
    80006444:	f8b402a3          	sb	a1,-123(s0)
    80006448:	28a67263          	bgeu	a2,a0,800066cc <__printf+0x644>
    8000644c:	00f6f693          	andi	a3,a3,15
    80006450:	00dd86b3          	add	a3,s11,a3
    80006454:	0006c683          	lbu	a3,0(a3)
    80006458:	0147d79b          	srliw	a5,a5,0x14
    8000645c:	f8d40323          	sb	a3,-122(s0)
    80006460:	21067663          	bgeu	a2,a6,8000666c <__printf+0x5e4>
    80006464:	02079793          	slli	a5,a5,0x20
    80006468:	0207d793          	srli	a5,a5,0x20
    8000646c:	00fd8db3          	add	s11,s11,a5
    80006470:	000dc683          	lbu	a3,0(s11)
    80006474:	00800793          	li	a5,8
    80006478:	00700c93          	li	s9,7
    8000647c:	f8d403a3          	sb	a3,-121(s0)
    80006480:	00075c63          	bgez	a4,80006498 <__printf+0x410>
    80006484:	f9040713          	addi	a4,s0,-112
    80006488:	00f70733          	add	a4,a4,a5
    8000648c:	02d00693          	li	a3,45
    80006490:	fed70823          	sb	a3,-16(a4)
    80006494:	00078c93          	mv	s9,a5
    80006498:	f8040793          	addi	a5,s0,-128
    8000649c:	01978cb3          	add	s9,a5,s9
    800064a0:	f7f40d13          	addi	s10,s0,-129
    800064a4:	000cc503          	lbu	a0,0(s9)
    800064a8:	fffc8c93          	addi	s9,s9,-1
    800064ac:	00000097          	auipc	ra,0x0
    800064b0:	9f8080e7          	jalr	-1544(ra) # 80005ea4 <consputc>
    800064b4:	ff9d18e3          	bne	s10,s9,800064a4 <__printf+0x41c>
    800064b8:	0100006f          	j	800064c8 <__printf+0x440>
    800064bc:	00000097          	auipc	ra,0x0
    800064c0:	9e8080e7          	jalr	-1560(ra) # 80005ea4 <consputc>
    800064c4:	000c8493          	mv	s1,s9
    800064c8:	00094503          	lbu	a0,0(s2)
    800064cc:	c60510e3          	bnez	a0,8000612c <__printf+0xa4>
    800064d0:	e40c0ee3          	beqz	s8,8000632c <__printf+0x2a4>
    800064d4:	00006517          	auipc	a0,0x6
    800064d8:	02c50513          	addi	a0,a0,44 # 8000c500 <pr>
    800064dc:	00001097          	auipc	ra,0x1
    800064e0:	94c080e7          	jalr	-1716(ra) # 80006e28 <release>
    800064e4:	e49ff06f          	j	8000632c <__printf+0x2a4>
    800064e8:	f7843783          	ld	a5,-136(s0)
    800064ec:	03000513          	li	a0,48
    800064f0:	01000d13          	li	s10,16
    800064f4:	00878713          	addi	a4,a5,8
    800064f8:	0007bc83          	ld	s9,0(a5)
    800064fc:	f6e43c23          	sd	a4,-136(s0)
    80006500:	00000097          	auipc	ra,0x0
    80006504:	9a4080e7          	jalr	-1628(ra) # 80005ea4 <consputc>
    80006508:	07800513          	li	a0,120
    8000650c:	00000097          	auipc	ra,0x0
    80006510:	998080e7          	jalr	-1640(ra) # 80005ea4 <consputc>
    80006514:	00002d97          	auipc	s11,0x2
    80006518:	224d8d93          	addi	s11,s11,548 # 80008738 <digits>
    8000651c:	03ccd793          	srli	a5,s9,0x3c
    80006520:	00fd87b3          	add	a5,s11,a5
    80006524:	0007c503          	lbu	a0,0(a5)
    80006528:	fffd0d1b          	addiw	s10,s10,-1
    8000652c:	004c9c93          	slli	s9,s9,0x4
    80006530:	00000097          	auipc	ra,0x0
    80006534:	974080e7          	jalr	-1676(ra) # 80005ea4 <consputc>
    80006538:	fe0d12e3          	bnez	s10,8000651c <__printf+0x494>
    8000653c:	f8dff06f          	j	800064c8 <__printf+0x440>
    80006540:	f7843783          	ld	a5,-136(s0)
    80006544:	0007bc83          	ld	s9,0(a5)
    80006548:	00878793          	addi	a5,a5,8
    8000654c:	f6f43c23          	sd	a5,-136(s0)
    80006550:	000c9a63          	bnez	s9,80006564 <__printf+0x4dc>
    80006554:	1080006f          	j	8000665c <__printf+0x5d4>
    80006558:	001c8c93          	addi	s9,s9,1
    8000655c:	00000097          	auipc	ra,0x0
    80006560:	948080e7          	jalr	-1720(ra) # 80005ea4 <consputc>
    80006564:	000cc503          	lbu	a0,0(s9)
    80006568:	fe0518e3          	bnez	a0,80006558 <__printf+0x4d0>
    8000656c:	f5dff06f          	j	800064c8 <__printf+0x440>
    80006570:	02500513          	li	a0,37
    80006574:	00000097          	auipc	ra,0x0
    80006578:	930080e7          	jalr	-1744(ra) # 80005ea4 <consputc>
    8000657c:	000c8513          	mv	a0,s9
    80006580:	00000097          	auipc	ra,0x0
    80006584:	924080e7          	jalr	-1756(ra) # 80005ea4 <consputc>
    80006588:	f41ff06f          	j	800064c8 <__printf+0x440>
    8000658c:	02500513          	li	a0,37
    80006590:	00000097          	auipc	ra,0x0
    80006594:	914080e7          	jalr	-1772(ra) # 80005ea4 <consputc>
    80006598:	f31ff06f          	j	800064c8 <__printf+0x440>
    8000659c:	00030513          	mv	a0,t1
    800065a0:	00000097          	auipc	ra,0x0
    800065a4:	7bc080e7          	jalr	1980(ra) # 80006d5c <acquire>
    800065a8:	b4dff06f          	j	800060f4 <__printf+0x6c>
    800065ac:	40c0053b          	negw	a0,a2
    800065b0:	00a00713          	li	a4,10
    800065b4:	02e576bb          	remuw	a3,a0,a4
    800065b8:	00002d97          	auipc	s11,0x2
    800065bc:	180d8d93          	addi	s11,s11,384 # 80008738 <digits>
    800065c0:	ff700593          	li	a1,-9
    800065c4:	02069693          	slli	a3,a3,0x20
    800065c8:	0206d693          	srli	a3,a3,0x20
    800065cc:	00dd86b3          	add	a3,s11,a3
    800065d0:	0006c683          	lbu	a3,0(a3)
    800065d4:	02e557bb          	divuw	a5,a0,a4
    800065d8:	f8d40023          	sb	a3,-128(s0)
    800065dc:	10b65e63          	bge	a2,a1,800066f8 <__printf+0x670>
    800065e0:	06300593          	li	a1,99
    800065e4:	02e7f6bb          	remuw	a3,a5,a4
    800065e8:	02069693          	slli	a3,a3,0x20
    800065ec:	0206d693          	srli	a3,a3,0x20
    800065f0:	00dd86b3          	add	a3,s11,a3
    800065f4:	0006c683          	lbu	a3,0(a3)
    800065f8:	02e7d73b          	divuw	a4,a5,a4
    800065fc:	00200793          	li	a5,2
    80006600:	f8d400a3          	sb	a3,-127(s0)
    80006604:	bca5ece3          	bltu	a1,a0,800061dc <__printf+0x154>
    80006608:	ce5ff06f          	j	800062ec <__printf+0x264>
    8000660c:	40e007bb          	negw	a5,a4
    80006610:	00002d97          	auipc	s11,0x2
    80006614:	128d8d93          	addi	s11,s11,296 # 80008738 <digits>
    80006618:	00f7f693          	andi	a3,a5,15
    8000661c:	00dd86b3          	add	a3,s11,a3
    80006620:	0006c583          	lbu	a1,0(a3)
    80006624:	ff100613          	li	a2,-15
    80006628:	0047d69b          	srliw	a3,a5,0x4
    8000662c:	f8b40023          	sb	a1,-128(s0)
    80006630:	0047d59b          	srliw	a1,a5,0x4
    80006634:	0ac75e63          	bge	a4,a2,800066f0 <__printf+0x668>
    80006638:	00f6f693          	andi	a3,a3,15
    8000663c:	00dd86b3          	add	a3,s11,a3
    80006640:	0006c603          	lbu	a2,0(a3)
    80006644:	00f00693          	li	a3,15
    80006648:	0087d79b          	srliw	a5,a5,0x8
    8000664c:	f8c400a3          	sb	a2,-127(s0)
    80006650:	d8b6e4e3          	bltu	a3,a1,800063d8 <__printf+0x350>
    80006654:	00200793          	li	a5,2
    80006658:	e2dff06f          	j	80006484 <__printf+0x3fc>
    8000665c:	00002c97          	auipc	s9,0x2
    80006660:	0bcc8c93          	addi	s9,s9,188 # 80008718 <CONSOLE_STATUS+0x708>
    80006664:	02800513          	li	a0,40
    80006668:	ef1ff06f          	j	80006558 <__printf+0x4d0>
    8000666c:	00700793          	li	a5,7
    80006670:	00600c93          	li	s9,6
    80006674:	e0dff06f          	j	80006480 <__printf+0x3f8>
    80006678:	00700793          	li	a5,7
    8000667c:	00600c93          	li	s9,6
    80006680:	c69ff06f          	j	800062e8 <__printf+0x260>
    80006684:	00300793          	li	a5,3
    80006688:	00200c93          	li	s9,2
    8000668c:	c5dff06f          	j	800062e8 <__printf+0x260>
    80006690:	00300793          	li	a5,3
    80006694:	00200c93          	li	s9,2
    80006698:	de9ff06f          	j	80006480 <__printf+0x3f8>
    8000669c:	00400793          	li	a5,4
    800066a0:	00300c93          	li	s9,3
    800066a4:	dddff06f          	j	80006480 <__printf+0x3f8>
    800066a8:	00400793          	li	a5,4
    800066ac:	00300c93          	li	s9,3
    800066b0:	c39ff06f          	j	800062e8 <__printf+0x260>
    800066b4:	00500793          	li	a5,5
    800066b8:	00400c93          	li	s9,4
    800066bc:	c2dff06f          	j	800062e8 <__printf+0x260>
    800066c0:	00500793          	li	a5,5
    800066c4:	00400c93          	li	s9,4
    800066c8:	db9ff06f          	j	80006480 <__printf+0x3f8>
    800066cc:	00600793          	li	a5,6
    800066d0:	00500c93          	li	s9,5
    800066d4:	dadff06f          	j	80006480 <__printf+0x3f8>
    800066d8:	00600793          	li	a5,6
    800066dc:	00500c93          	li	s9,5
    800066e0:	c09ff06f          	j	800062e8 <__printf+0x260>
    800066e4:	00800793          	li	a5,8
    800066e8:	00700c93          	li	s9,7
    800066ec:	bfdff06f          	j	800062e8 <__printf+0x260>
    800066f0:	00100793          	li	a5,1
    800066f4:	d91ff06f          	j	80006484 <__printf+0x3fc>
    800066f8:	00100793          	li	a5,1
    800066fc:	bf1ff06f          	j	800062ec <__printf+0x264>
    80006700:	00900793          	li	a5,9
    80006704:	00800c93          	li	s9,8
    80006708:	be1ff06f          	j	800062e8 <__printf+0x260>
    8000670c:	00002517          	auipc	a0,0x2
    80006710:	01450513          	addi	a0,a0,20 # 80008720 <CONSOLE_STATUS+0x710>
    80006714:	00000097          	auipc	ra,0x0
    80006718:	918080e7          	jalr	-1768(ra) # 8000602c <panic>

000000008000671c <printfinit>:
    8000671c:	fe010113          	addi	sp,sp,-32
    80006720:	00813823          	sd	s0,16(sp)
    80006724:	00913423          	sd	s1,8(sp)
    80006728:	00113c23          	sd	ra,24(sp)
    8000672c:	02010413          	addi	s0,sp,32
    80006730:	00006497          	auipc	s1,0x6
    80006734:	dd048493          	addi	s1,s1,-560 # 8000c500 <pr>
    80006738:	00048513          	mv	a0,s1
    8000673c:	00002597          	auipc	a1,0x2
    80006740:	ff458593          	addi	a1,a1,-12 # 80008730 <CONSOLE_STATUS+0x720>
    80006744:	00000097          	auipc	ra,0x0
    80006748:	5f4080e7          	jalr	1524(ra) # 80006d38 <initlock>
    8000674c:	01813083          	ld	ra,24(sp)
    80006750:	01013403          	ld	s0,16(sp)
    80006754:	0004ac23          	sw	zero,24(s1)
    80006758:	00813483          	ld	s1,8(sp)
    8000675c:	02010113          	addi	sp,sp,32
    80006760:	00008067          	ret

0000000080006764 <uartinit>:
    80006764:	ff010113          	addi	sp,sp,-16
    80006768:	00813423          	sd	s0,8(sp)
    8000676c:	01010413          	addi	s0,sp,16
    80006770:	100007b7          	lui	a5,0x10000
    80006774:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006778:	f8000713          	li	a4,-128
    8000677c:	00e781a3          	sb	a4,3(a5)
    80006780:	00300713          	li	a4,3
    80006784:	00e78023          	sb	a4,0(a5)
    80006788:	000780a3          	sb	zero,1(a5)
    8000678c:	00e781a3          	sb	a4,3(a5)
    80006790:	00700693          	li	a3,7
    80006794:	00d78123          	sb	a3,2(a5)
    80006798:	00e780a3          	sb	a4,1(a5)
    8000679c:	00813403          	ld	s0,8(sp)
    800067a0:	01010113          	addi	sp,sp,16
    800067a4:	00008067          	ret

00000000800067a8 <uartputc>:
    800067a8:	00005797          	auipc	a5,0x5
    800067ac:	8c07a783          	lw	a5,-1856(a5) # 8000b068 <panicked>
    800067b0:	00078463          	beqz	a5,800067b8 <uartputc+0x10>
    800067b4:	0000006f          	j	800067b4 <uartputc+0xc>
    800067b8:	fd010113          	addi	sp,sp,-48
    800067bc:	02813023          	sd	s0,32(sp)
    800067c0:	00913c23          	sd	s1,24(sp)
    800067c4:	01213823          	sd	s2,16(sp)
    800067c8:	01313423          	sd	s3,8(sp)
    800067cc:	02113423          	sd	ra,40(sp)
    800067d0:	03010413          	addi	s0,sp,48
    800067d4:	00005917          	auipc	s2,0x5
    800067d8:	89c90913          	addi	s2,s2,-1892 # 8000b070 <uart_tx_r>
    800067dc:	00093783          	ld	a5,0(s2)
    800067e0:	00005497          	auipc	s1,0x5
    800067e4:	89848493          	addi	s1,s1,-1896 # 8000b078 <uart_tx_w>
    800067e8:	0004b703          	ld	a4,0(s1)
    800067ec:	02078693          	addi	a3,a5,32
    800067f0:	00050993          	mv	s3,a0
    800067f4:	02e69c63          	bne	a3,a4,8000682c <uartputc+0x84>
    800067f8:	00001097          	auipc	ra,0x1
    800067fc:	834080e7          	jalr	-1996(ra) # 8000702c <push_on>
    80006800:	00093783          	ld	a5,0(s2)
    80006804:	0004b703          	ld	a4,0(s1)
    80006808:	02078793          	addi	a5,a5,32
    8000680c:	00e79463          	bne	a5,a4,80006814 <uartputc+0x6c>
    80006810:	0000006f          	j	80006810 <uartputc+0x68>
    80006814:	00001097          	auipc	ra,0x1
    80006818:	88c080e7          	jalr	-1908(ra) # 800070a0 <pop_on>
    8000681c:	00093783          	ld	a5,0(s2)
    80006820:	0004b703          	ld	a4,0(s1)
    80006824:	02078693          	addi	a3,a5,32
    80006828:	fce688e3          	beq	a3,a4,800067f8 <uartputc+0x50>
    8000682c:	01f77693          	andi	a3,a4,31
    80006830:	00006597          	auipc	a1,0x6
    80006834:	cf058593          	addi	a1,a1,-784 # 8000c520 <uart_tx_buf>
    80006838:	00d586b3          	add	a3,a1,a3
    8000683c:	00170713          	addi	a4,a4,1
    80006840:	01368023          	sb	s3,0(a3)
    80006844:	00e4b023          	sd	a4,0(s1)
    80006848:	10000637          	lui	a2,0x10000
    8000684c:	02f71063          	bne	a4,a5,8000686c <uartputc+0xc4>
    80006850:	0340006f          	j	80006884 <uartputc+0xdc>
    80006854:	00074703          	lbu	a4,0(a4)
    80006858:	00f93023          	sd	a5,0(s2)
    8000685c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006860:	00093783          	ld	a5,0(s2)
    80006864:	0004b703          	ld	a4,0(s1)
    80006868:	00f70e63          	beq	a4,a5,80006884 <uartputc+0xdc>
    8000686c:	00564683          	lbu	a3,5(a2)
    80006870:	01f7f713          	andi	a4,a5,31
    80006874:	00e58733          	add	a4,a1,a4
    80006878:	0206f693          	andi	a3,a3,32
    8000687c:	00178793          	addi	a5,a5,1
    80006880:	fc069ae3          	bnez	a3,80006854 <uartputc+0xac>
    80006884:	02813083          	ld	ra,40(sp)
    80006888:	02013403          	ld	s0,32(sp)
    8000688c:	01813483          	ld	s1,24(sp)
    80006890:	01013903          	ld	s2,16(sp)
    80006894:	00813983          	ld	s3,8(sp)
    80006898:	03010113          	addi	sp,sp,48
    8000689c:	00008067          	ret

00000000800068a0 <uartputc_sync>:
    800068a0:	ff010113          	addi	sp,sp,-16
    800068a4:	00813423          	sd	s0,8(sp)
    800068a8:	01010413          	addi	s0,sp,16
    800068ac:	00004717          	auipc	a4,0x4
    800068b0:	7bc72703          	lw	a4,1980(a4) # 8000b068 <panicked>
    800068b4:	02071663          	bnez	a4,800068e0 <uartputc_sync+0x40>
    800068b8:	00050793          	mv	a5,a0
    800068bc:	100006b7          	lui	a3,0x10000
    800068c0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800068c4:	02077713          	andi	a4,a4,32
    800068c8:	fe070ce3          	beqz	a4,800068c0 <uartputc_sync+0x20>
    800068cc:	0ff7f793          	andi	a5,a5,255
    800068d0:	00f68023          	sb	a5,0(a3)
    800068d4:	00813403          	ld	s0,8(sp)
    800068d8:	01010113          	addi	sp,sp,16
    800068dc:	00008067          	ret
    800068e0:	0000006f          	j	800068e0 <uartputc_sync+0x40>

00000000800068e4 <uartstart>:
    800068e4:	ff010113          	addi	sp,sp,-16
    800068e8:	00813423          	sd	s0,8(sp)
    800068ec:	01010413          	addi	s0,sp,16
    800068f0:	00004617          	auipc	a2,0x4
    800068f4:	78060613          	addi	a2,a2,1920 # 8000b070 <uart_tx_r>
    800068f8:	00004517          	auipc	a0,0x4
    800068fc:	78050513          	addi	a0,a0,1920 # 8000b078 <uart_tx_w>
    80006900:	00063783          	ld	a5,0(a2)
    80006904:	00053703          	ld	a4,0(a0)
    80006908:	04f70263          	beq	a4,a5,8000694c <uartstart+0x68>
    8000690c:	100005b7          	lui	a1,0x10000
    80006910:	00006817          	auipc	a6,0x6
    80006914:	c1080813          	addi	a6,a6,-1008 # 8000c520 <uart_tx_buf>
    80006918:	01c0006f          	j	80006934 <uartstart+0x50>
    8000691c:	0006c703          	lbu	a4,0(a3)
    80006920:	00f63023          	sd	a5,0(a2)
    80006924:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006928:	00063783          	ld	a5,0(a2)
    8000692c:	00053703          	ld	a4,0(a0)
    80006930:	00f70e63          	beq	a4,a5,8000694c <uartstart+0x68>
    80006934:	01f7f713          	andi	a4,a5,31
    80006938:	00e806b3          	add	a3,a6,a4
    8000693c:	0055c703          	lbu	a4,5(a1)
    80006940:	00178793          	addi	a5,a5,1
    80006944:	02077713          	andi	a4,a4,32
    80006948:	fc071ae3          	bnez	a4,8000691c <uartstart+0x38>
    8000694c:	00813403          	ld	s0,8(sp)
    80006950:	01010113          	addi	sp,sp,16
    80006954:	00008067          	ret

0000000080006958 <uartgetc>:
    80006958:	ff010113          	addi	sp,sp,-16
    8000695c:	00813423          	sd	s0,8(sp)
    80006960:	01010413          	addi	s0,sp,16
    80006964:	10000737          	lui	a4,0x10000
    80006968:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000696c:	0017f793          	andi	a5,a5,1
    80006970:	00078c63          	beqz	a5,80006988 <uartgetc+0x30>
    80006974:	00074503          	lbu	a0,0(a4)
    80006978:	0ff57513          	andi	a0,a0,255
    8000697c:	00813403          	ld	s0,8(sp)
    80006980:	01010113          	addi	sp,sp,16
    80006984:	00008067          	ret
    80006988:	fff00513          	li	a0,-1
    8000698c:	ff1ff06f          	j	8000697c <uartgetc+0x24>

0000000080006990 <uartintr>:
    80006990:	100007b7          	lui	a5,0x10000
    80006994:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006998:	0017f793          	andi	a5,a5,1
    8000699c:	0a078463          	beqz	a5,80006a44 <uartintr+0xb4>
    800069a0:	fe010113          	addi	sp,sp,-32
    800069a4:	00813823          	sd	s0,16(sp)
    800069a8:	00913423          	sd	s1,8(sp)
    800069ac:	00113c23          	sd	ra,24(sp)
    800069b0:	02010413          	addi	s0,sp,32
    800069b4:	100004b7          	lui	s1,0x10000
    800069b8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800069bc:	0ff57513          	andi	a0,a0,255
    800069c0:	fffff097          	auipc	ra,0xfffff
    800069c4:	534080e7          	jalr	1332(ra) # 80005ef4 <consoleintr>
    800069c8:	0054c783          	lbu	a5,5(s1)
    800069cc:	0017f793          	andi	a5,a5,1
    800069d0:	fe0794e3          	bnez	a5,800069b8 <uartintr+0x28>
    800069d4:	00004617          	auipc	a2,0x4
    800069d8:	69c60613          	addi	a2,a2,1692 # 8000b070 <uart_tx_r>
    800069dc:	00004517          	auipc	a0,0x4
    800069e0:	69c50513          	addi	a0,a0,1692 # 8000b078 <uart_tx_w>
    800069e4:	00063783          	ld	a5,0(a2)
    800069e8:	00053703          	ld	a4,0(a0)
    800069ec:	04f70263          	beq	a4,a5,80006a30 <uartintr+0xa0>
    800069f0:	100005b7          	lui	a1,0x10000
    800069f4:	00006817          	auipc	a6,0x6
    800069f8:	b2c80813          	addi	a6,a6,-1236 # 8000c520 <uart_tx_buf>
    800069fc:	01c0006f          	j	80006a18 <uartintr+0x88>
    80006a00:	0006c703          	lbu	a4,0(a3)
    80006a04:	00f63023          	sd	a5,0(a2)
    80006a08:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006a0c:	00063783          	ld	a5,0(a2)
    80006a10:	00053703          	ld	a4,0(a0)
    80006a14:	00f70e63          	beq	a4,a5,80006a30 <uartintr+0xa0>
    80006a18:	01f7f713          	andi	a4,a5,31
    80006a1c:	00e806b3          	add	a3,a6,a4
    80006a20:	0055c703          	lbu	a4,5(a1)
    80006a24:	00178793          	addi	a5,a5,1
    80006a28:	02077713          	andi	a4,a4,32
    80006a2c:	fc071ae3          	bnez	a4,80006a00 <uartintr+0x70>
    80006a30:	01813083          	ld	ra,24(sp)
    80006a34:	01013403          	ld	s0,16(sp)
    80006a38:	00813483          	ld	s1,8(sp)
    80006a3c:	02010113          	addi	sp,sp,32
    80006a40:	00008067          	ret
    80006a44:	00004617          	auipc	a2,0x4
    80006a48:	62c60613          	addi	a2,a2,1580 # 8000b070 <uart_tx_r>
    80006a4c:	00004517          	auipc	a0,0x4
    80006a50:	62c50513          	addi	a0,a0,1580 # 8000b078 <uart_tx_w>
    80006a54:	00063783          	ld	a5,0(a2)
    80006a58:	00053703          	ld	a4,0(a0)
    80006a5c:	04f70263          	beq	a4,a5,80006aa0 <uartintr+0x110>
    80006a60:	100005b7          	lui	a1,0x10000
    80006a64:	00006817          	auipc	a6,0x6
    80006a68:	abc80813          	addi	a6,a6,-1348 # 8000c520 <uart_tx_buf>
    80006a6c:	01c0006f          	j	80006a88 <uartintr+0xf8>
    80006a70:	0006c703          	lbu	a4,0(a3)
    80006a74:	00f63023          	sd	a5,0(a2)
    80006a78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006a7c:	00063783          	ld	a5,0(a2)
    80006a80:	00053703          	ld	a4,0(a0)
    80006a84:	02f70063          	beq	a4,a5,80006aa4 <uartintr+0x114>
    80006a88:	01f7f713          	andi	a4,a5,31
    80006a8c:	00e806b3          	add	a3,a6,a4
    80006a90:	0055c703          	lbu	a4,5(a1)
    80006a94:	00178793          	addi	a5,a5,1
    80006a98:	02077713          	andi	a4,a4,32
    80006a9c:	fc071ae3          	bnez	a4,80006a70 <uartintr+0xe0>
    80006aa0:	00008067          	ret
    80006aa4:	00008067          	ret

0000000080006aa8 <kinit>:
    80006aa8:	fc010113          	addi	sp,sp,-64
    80006aac:	02913423          	sd	s1,40(sp)
    80006ab0:	fffff7b7          	lui	a5,0xfffff
    80006ab4:	0000b497          	auipc	s1,0xb
    80006ab8:	54b48493          	addi	s1,s1,1355 # 80011fff <end+0xfff>
    80006abc:	02813823          	sd	s0,48(sp)
    80006ac0:	01313c23          	sd	s3,24(sp)
    80006ac4:	00f4f4b3          	and	s1,s1,a5
    80006ac8:	02113c23          	sd	ra,56(sp)
    80006acc:	03213023          	sd	s2,32(sp)
    80006ad0:	01413823          	sd	s4,16(sp)
    80006ad4:	01513423          	sd	s5,8(sp)
    80006ad8:	04010413          	addi	s0,sp,64
    80006adc:	000017b7          	lui	a5,0x1
    80006ae0:	01100993          	li	s3,17
    80006ae4:	00f487b3          	add	a5,s1,a5
    80006ae8:	01b99993          	slli	s3,s3,0x1b
    80006aec:	06f9e063          	bltu	s3,a5,80006b4c <kinit+0xa4>
    80006af0:	0000aa97          	auipc	s5,0xa
    80006af4:	510a8a93          	addi	s5,s5,1296 # 80011000 <end>
    80006af8:	0754ec63          	bltu	s1,s5,80006b70 <kinit+0xc8>
    80006afc:	0734fa63          	bgeu	s1,s3,80006b70 <kinit+0xc8>
    80006b00:	00088a37          	lui	s4,0x88
    80006b04:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006b08:	00004917          	auipc	s2,0x4
    80006b0c:	57890913          	addi	s2,s2,1400 # 8000b080 <kmem>
    80006b10:	00ca1a13          	slli	s4,s4,0xc
    80006b14:	0140006f          	j	80006b28 <kinit+0x80>
    80006b18:	000017b7          	lui	a5,0x1
    80006b1c:	00f484b3          	add	s1,s1,a5
    80006b20:	0554e863          	bltu	s1,s5,80006b70 <kinit+0xc8>
    80006b24:	0534f663          	bgeu	s1,s3,80006b70 <kinit+0xc8>
    80006b28:	00001637          	lui	a2,0x1
    80006b2c:	00100593          	li	a1,1
    80006b30:	00048513          	mv	a0,s1
    80006b34:	00000097          	auipc	ra,0x0
    80006b38:	5e4080e7          	jalr	1508(ra) # 80007118 <__memset>
    80006b3c:	00093783          	ld	a5,0(s2)
    80006b40:	00f4b023          	sd	a5,0(s1)
    80006b44:	00993023          	sd	s1,0(s2)
    80006b48:	fd4498e3          	bne	s1,s4,80006b18 <kinit+0x70>
    80006b4c:	03813083          	ld	ra,56(sp)
    80006b50:	03013403          	ld	s0,48(sp)
    80006b54:	02813483          	ld	s1,40(sp)
    80006b58:	02013903          	ld	s2,32(sp)
    80006b5c:	01813983          	ld	s3,24(sp)
    80006b60:	01013a03          	ld	s4,16(sp)
    80006b64:	00813a83          	ld	s5,8(sp)
    80006b68:	04010113          	addi	sp,sp,64
    80006b6c:	00008067          	ret
    80006b70:	00002517          	auipc	a0,0x2
    80006b74:	be050513          	addi	a0,a0,-1056 # 80008750 <digits+0x18>
    80006b78:	fffff097          	auipc	ra,0xfffff
    80006b7c:	4b4080e7          	jalr	1204(ra) # 8000602c <panic>

0000000080006b80 <freerange>:
    80006b80:	fc010113          	addi	sp,sp,-64
    80006b84:	000017b7          	lui	a5,0x1
    80006b88:	02913423          	sd	s1,40(sp)
    80006b8c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006b90:	009504b3          	add	s1,a0,s1
    80006b94:	fffff537          	lui	a0,0xfffff
    80006b98:	02813823          	sd	s0,48(sp)
    80006b9c:	02113c23          	sd	ra,56(sp)
    80006ba0:	03213023          	sd	s2,32(sp)
    80006ba4:	01313c23          	sd	s3,24(sp)
    80006ba8:	01413823          	sd	s4,16(sp)
    80006bac:	01513423          	sd	s5,8(sp)
    80006bb0:	01613023          	sd	s6,0(sp)
    80006bb4:	04010413          	addi	s0,sp,64
    80006bb8:	00a4f4b3          	and	s1,s1,a0
    80006bbc:	00f487b3          	add	a5,s1,a5
    80006bc0:	06f5e463          	bltu	a1,a5,80006c28 <freerange+0xa8>
    80006bc4:	0000aa97          	auipc	s5,0xa
    80006bc8:	43ca8a93          	addi	s5,s5,1084 # 80011000 <end>
    80006bcc:	0954e263          	bltu	s1,s5,80006c50 <freerange+0xd0>
    80006bd0:	01100993          	li	s3,17
    80006bd4:	01b99993          	slli	s3,s3,0x1b
    80006bd8:	0734fc63          	bgeu	s1,s3,80006c50 <freerange+0xd0>
    80006bdc:	00058a13          	mv	s4,a1
    80006be0:	00004917          	auipc	s2,0x4
    80006be4:	4a090913          	addi	s2,s2,1184 # 8000b080 <kmem>
    80006be8:	00002b37          	lui	s6,0x2
    80006bec:	0140006f          	j	80006c00 <freerange+0x80>
    80006bf0:	000017b7          	lui	a5,0x1
    80006bf4:	00f484b3          	add	s1,s1,a5
    80006bf8:	0554ec63          	bltu	s1,s5,80006c50 <freerange+0xd0>
    80006bfc:	0534fa63          	bgeu	s1,s3,80006c50 <freerange+0xd0>
    80006c00:	00001637          	lui	a2,0x1
    80006c04:	00100593          	li	a1,1
    80006c08:	00048513          	mv	a0,s1
    80006c0c:	00000097          	auipc	ra,0x0
    80006c10:	50c080e7          	jalr	1292(ra) # 80007118 <__memset>
    80006c14:	00093703          	ld	a4,0(s2)
    80006c18:	016487b3          	add	a5,s1,s6
    80006c1c:	00e4b023          	sd	a4,0(s1)
    80006c20:	00993023          	sd	s1,0(s2)
    80006c24:	fcfa76e3          	bgeu	s4,a5,80006bf0 <freerange+0x70>
    80006c28:	03813083          	ld	ra,56(sp)
    80006c2c:	03013403          	ld	s0,48(sp)
    80006c30:	02813483          	ld	s1,40(sp)
    80006c34:	02013903          	ld	s2,32(sp)
    80006c38:	01813983          	ld	s3,24(sp)
    80006c3c:	01013a03          	ld	s4,16(sp)
    80006c40:	00813a83          	ld	s5,8(sp)
    80006c44:	00013b03          	ld	s6,0(sp)
    80006c48:	04010113          	addi	sp,sp,64
    80006c4c:	00008067          	ret
    80006c50:	00002517          	auipc	a0,0x2
    80006c54:	b0050513          	addi	a0,a0,-1280 # 80008750 <digits+0x18>
    80006c58:	fffff097          	auipc	ra,0xfffff
    80006c5c:	3d4080e7          	jalr	980(ra) # 8000602c <panic>

0000000080006c60 <kfree>:
    80006c60:	fe010113          	addi	sp,sp,-32
    80006c64:	00813823          	sd	s0,16(sp)
    80006c68:	00113c23          	sd	ra,24(sp)
    80006c6c:	00913423          	sd	s1,8(sp)
    80006c70:	02010413          	addi	s0,sp,32
    80006c74:	03451793          	slli	a5,a0,0x34
    80006c78:	04079c63          	bnez	a5,80006cd0 <kfree+0x70>
    80006c7c:	0000a797          	auipc	a5,0xa
    80006c80:	38478793          	addi	a5,a5,900 # 80011000 <end>
    80006c84:	00050493          	mv	s1,a0
    80006c88:	04f56463          	bltu	a0,a5,80006cd0 <kfree+0x70>
    80006c8c:	01100793          	li	a5,17
    80006c90:	01b79793          	slli	a5,a5,0x1b
    80006c94:	02f57e63          	bgeu	a0,a5,80006cd0 <kfree+0x70>
    80006c98:	00001637          	lui	a2,0x1
    80006c9c:	00100593          	li	a1,1
    80006ca0:	00000097          	auipc	ra,0x0
    80006ca4:	478080e7          	jalr	1144(ra) # 80007118 <__memset>
    80006ca8:	00004797          	auipc	a5,0x4
    80006cac:	3d878793          	addi	a5,a5,984 # 8000b080 <kmem>
    80006cb0:	0007b703          	ld	a4,0(a5)
    80006cb4:	01813083          	ld	ra,24(sp)
    80006cb8:	01013403          	ld	s0,16(sp)
    80006cbc:	00e4b023          	sd	a4,0(s1)
    80006cc0:	0097b023          	sd	s1,0(a5)
    80006cc4:	00813483          	ld	s1,8(sp)
    80006cc8:	02010113          	addi	sp,sp,32
    80006ccc:	00008067          	ret
    80006cd0:	00002517          	auipc	a0,0x2
    80006cd4:	a8050513          	addi	a0,a0,-1408 # 80008750 <digits+0x18>
    80006cd8:	fffff097          	auipc	ra,0xfffff
    80006cdc:	354080e7          	jalr	852(ra) # 8000602c <panic>

0000000080006ce0 <kalloc>:
    80006ce0:	fe010113          	addi	sp,sp,-32
    80006ce4:	00813823          	sd	s0,16(sp)
    80006ce8:	00913423          	sd	s1,8(sp)
    80006cec:	00113c23          	sd	ra,24(sp)
    80006cf0:	02010413          	addi	s0,sp,32
    80006cf4:	00004797          	auipc	a5,0x4
    80006cf8:	38c78793          	addi	a5,a5,908 # 8000b080 <kmem>
    80006cfc:	0007b483          	ld	s1,0(a5)
    80006d00:	02048063          	beqz	s1,80006d20 <kalloc+0x40>
    80006d04:	0004b703          	ld	a4,0(s1)
    80006d08:	00001637          	lui	a2,0x1
    80006d0c:	00500593          	li	a1,5
    80006d10:	00048513          	mv	a0,s1
    80006d14:	00e7b023          	sd	a4,0(a5)
    80006d18:	00000097          	auipc	ra,0x0
    80006d1c:	400080e7          	jalr	1024(ra) # 80007118 <__memset>
    80006d20:	01813083          	ld	ra,24(sp)
    80006d24:	01013403          	ld	s0,16(sp)
    80006d28:	00048513          	mv	a0,s1
    80006d2c:	00813483          	ld	s1,8(sp)
    80006d30:	02010113          	addi	sp,sp,32
    80006d34:	00008067          	ret

0000000080006d38 <initlock>:
    80006d38:	ff010113          	addi	sp,sp,-16
    80006d3c:	00813423          	sd	s0,8(sp)
    80006d40:	01010413          	addi	s0,sp,16
    80006d44:	00813403          	ld	s0,8(sp)
    80006d48:	00b53423          	sd	a1,8(a0)
    80006d4c:	00052023          	sw	zero,0(a0)
    80006d50:	00053823          	sd	zero,16(a0)
    80006d54:	01010113          	addi	sp,sp,16
    80006d58:	00008067          	ret

0000000080006d5c <acquire>:
    80006d5c:	fe010113          	addi	sp,sp,-32
    80006d60:	00813823          	sd	s0,16(sp)
    80006d64:	00913423          	sd	s1,8(sp)
    80006d68:	00113c23          	sd	ra,24(sp)
    80006d6c:	01213023          	sd	s2,0(sp)
    80006d70:	02010413          	addi	s0,sp,32
    80006d74:	00050493          	mv	s1,a0
    80006d78:	10002973          	csrr	s2,sstatus
    80006d7c:	100027f3          	csrr	a5,sstatus
    80006d80:	ffd7f793          	andi	a5,a5,-3
    80006d84:	10079073          	csrw	sstatus,a5
    80006d88:	fffff097          	auipc	ra,0xfffff
    80006d8c:	8ec080e7          	jalr	-1812(ra) # 80005674 <mycpu>
    80006d90:	07852783          	lw	a5,120(a0)
    80006d94:	06078e63          	beqz	a5,80006e10 <acquire+0xb4>
    80006d98:	fffff097          	auipc	ra,0xfffff
    80006d9c:	8dc080e7          	jalr	-1828(ra) # 80005674 <mycpu>
    80006da0:	07852783          	lw	a5,120(a0)
    80006da4:	0004a703          	lw	a4,0(s1)
    80006da8:	0017879b          	addiw	a5,a5,1
    80006dac:	06f52c23          	sw	a5,120(a0)
    80006db0:	04071063          	bnez	a4,80006df0 <acquire+0x94>
    80006db4:	00100713          	li	a4,1
    80006db8:	00070793          	mv	a5,a4
    80006dbc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006dc0:	0007879b          	sext.w	a5,a5
    80006dc4:	fe079ae3          	bnez	a5,80006db8 <acquire+0x5c>
    80006dc8:	0ff0000f          	fence
    80006dcc:	fffff097          	auipc	ra,0xfffff
    80006dd0:	8a8080e7          	jalr	-1880(ra) # 80005674 <mycpu>
    80006dd4:	01813083          	ld	ra,24(sp)
    80006dd8:	01013403          	ld	s0,16(sp)
    80006ddc:	00a4b823          	sd	a0,16(s1)
    80006de0:	00013903          	ld	s2,0(sp)
    80006de4:	00813483          	ld	s1,8(sp)
    80006de8:	02010113          	addi	sp,sp,32
    80006dec:	00008067          	ret
    80006df0:	0104b903          	ld	s2,16(s1)
    80006df4:	fffff097          	auipc	ra,0xfffff
    80006df8:	880080e7          	jalr	-1920(ra) # 80005674 <mycpu>
    80006dfc:	faa91ce3          	bne	s2,a0,80006db4 <acquire+0x58>
    80006e00:	00002517          	auipc	a0,0x2
    80006e04:	95850513          	addi	a0,a0,-1704 # 80008758 <digits+0x20>
    80006e08:	fffff097          	auipc	ra,0xfffff
    80006e0c:	224080e7          	jalr	548(ra) # 8000602c <panic>
    80006e10:	00195913          	srli	s2,s2,0x1
    80006e14:	fffff097          	auipc	ra,0xfffff
    80006e18:	860080e7          	jalr	-1952(ra) # 80005674 <mycpu>
    80006e1c:	00197913          	andi	s2,s2,1
    80006e20:	07252e23          	sw	s2,124(a0)
    80006e24:	f75ff06f          	j	80006d98 <acquire+0x3c>

0000000080006e28 <release>:
    80006e28:	fe010113          	addi	sp,sp,-32
    80006e2c:	00813823          	sd	s0,16(sp)
    80006e30:	00113c23          	sd	ra,24(sp)
    80006e34:	00913423          	sd	s1,8(sp)
    80006e38:	01213023          	sd	s2,0(sp)
    80006e3c:	02010413          	addi	s0,sp,32
    80006e40:	00052783          	lw	a5,0(a0)
    80006e44:	00079a63          	bnez	a5,80006e58 <release+0x30>
    80006e48:	00002517          	auipc	a0,0x2
    80006e4c:	91850513          	addi	a0,a0,-1768 # 80008760 <digits+0x28>
    80006e50:	fffff097          	auipc	ra,0xfffff
    80006e54:	1dc080e7          	jalr	476(ra) # 8000602c <panic>
    80006e58:	01053903          	ld	s2,16(a0)
    80006e5c:	00050493          	mv	s1,a0
    80006e60:	fffff097          	auipc	ra,0xfffff
    80006e64:	814080e7          	jalr	-2028(ra) # 80005674 <mycpu>
    80006e68:	fea910e3          	bne	s2,a0,80006e48 <release+0x20>
    80006e6c:	0004b823          	sd	zero,16(s1)
    80006e70:	0ff0000f          	fence
    80006e74:	0f50000f          	fence	iorw,ow
    80006e78:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006e7c:	ffffe097          	auipc	ra,0xffffe
    80006e80:	7f8080e7          	jalr	2040(ra) # 80005674 <mycpu>
    80006e84:	100027f3          	csrr	a5,sstatus
    80006e88:	0027f793          	andi	a5,a5,2
    80006e8c:	04079a63          	bnez	a5,80006ee0 <release+0xb8>
    80006e90:	07852783          	lw	a5,120(a0)
    80006e94:	02f05e63          	blez	a5,80006ed0 <release+0xa8>
    80006e98:	fff7871b          	addiw	a4,a5,-1
    80006e9c:	06e52c23          	sw	a4,120(a0)
    80006ea0:	00071c63          	bnez	a4,80006eb8 <release+0x90>
    80006ea4:	07c52783          	lw	a5,124(a0)
    80006ea8:	00078863          	beqz	a5,80006eb8 <release+0x90>
    80006eac:	100027f3          	csrr	a5,sstatus
    80006eb0:	0027e793          	ori	a5,a5,2
    80006eb4:	10079073          	csrw	sstatus,a5
    80006eb8:	01813083          	ld	ra,24(sp)
    80006ebc:	01013403          	ld	s0,16(sp)
    80006ec0:	00813483          	ld	s1,8(sp)
    80006ec4:	00013903          	ld	s2,0(sp)
    80006ec8:	02010113          	addi	sp,sp,32
    80006ecc:	00008067          	ret
    80006ed0:	00002517          	auipc	a0,0x2
    80006ed4:	8b050513          	addi	a0,a0,-1872 # 80008780 <digits+0x48>
    80006ed8:	fffff097          	auipc	ra,0xfffff
    80006edc:	154080e7          	jalr	340(ra) # 8000602c <panic>
    80006ee0:	00002517          	auipc	a0,0x2
    80006ee4:	88850513          	addi	a0,a0,-1912 # 80008768 <digits+0x30>
    80006ee8:	fffff097          	auipc	ra,0xfffff
    80006eec:	144080e7          	jalr	324(ra) # 8000602c <panic>

0000000080006ef0 <holding>:
    80006ef0:	00052783          	lw	a5,0(a0)
    80006ef4:	00079663          	bnez	a5,80006f00 <holding+0x10>
    80006ef8:	00000513          	li	a0,0
    80006efc:	00008067          	ret
    80006f00:	fe010113          	addi	sp,sp,-32
    80006f04:	00813823          	sd	s0,16(sp)
    80006f08:	00913423          	sd	s1,8(sp)
    80006f0c:	00113c23          	sd	ra,24(sp)
    80006f10:	02010413          	addi	s0,sp,32
    80006f14:	01053483          	ld	s1,16(a0)
    80006f18:	ffffe097          	auipc	ra,0xffffe
    80006f1c:	75c080e7          	jalr	1884(ra) # 80005674 <mycpu>
    80006f20:	01813083          	ld	ra,24(sp)
    80006f24:	01013403          	ld	s0,16(sp)
    80006f28:	40a48533          	sub	a0,s1,a0
    80006f2c:	00153513          	seqz	a0,a0
    80006f30:	00813483          	ld	s1,8(sp)
    80006f34:	02010113          	addi	sp,sp,32
    80006f38:	00008067          	ret

0000000080006f3c <push_off>:
    80006f3c:	fe010113          	addi	sp,sp,-32
    80006f40:	00813823          	sd	s0,16(sp)
    80006f44:	00113c23          	sd	ra,24(sp)
    80006f48:	00913423          	sd	s1,8(sp)
    80006f4c:	02010413          	addi	s0,sp,32
    80006f50:	100024f3          	csrr	s1,sstatus
    80006f54:	100027f3          	csrr	a5,sstatus
    80006f58:	ffd7f793          	andi	a5,a5,-3
    80006f5c:	10079073          	csrw	sstatus,a5
    80006f60:	ffffe097          	auipc	ra,0xffffe
    80006f64:	714080e7          	jalr	1812(ra) # 80005674 <mycpu>
    80006f68:	07852783          	lw	a5,120(a0)
    80006f6c:	02078663          	beqz	a5,80006f98 <push_off+0x5c>
    80006f70:	ffffe097          	auipc	ra,0xffffe
    80006f74:	704080e7          	jalr	1796(ra) # 80005674 <mycpu>
    80006f78:	07852783          	lw	a5,120(a0)
    80006f7c:	01813083          	ld	ra,24(sp)
    80006f80:	01013403          	ld	s0,16(sp)
    80006f84:	0017879b          	addiw	a5,a5,1
    80006f88:	06f52c23          	sw	a5,120(a0)
    80006f8c:	00813483          	ld	s1,8(sp)
    80006f90:	02010113          	addi	sp,sp,32
    80006f94:	00008067          	ret
    80006f98:	0014d493          	srli	s1,s1,0x1
    80006f9c:	ffffe097          	auipc	ra,0xffffe
    80006fa0:	6d8080e7          	jalr	1752(ra) # 80005674 <mycpu>
    80006fa4:	0014f493          	andi	s1,s1,1
    80006fa8:	06952e23          	sw	s1,124(a0)
    80006fac:	fc5ff06f          	j	80006f70 <push_off+0x34>

0000000080006fb0 <pop_off>:
    80006fb0:	ff010113          	addi	sp,sp,-16
    80006fb4:	00813023          	sd	s0,0(sp)
    80006fb8:	00113423          	sd	ra,8(sp)
    80006fbc:	01010413          	addi	s0,sp,16
    80006fc0:	ffffe097          	auipc	ra,0xffffe
    80006fc4:	6b4080e7          	jalr	1716(ra) # 80005674 <mycpu>
    80006fc8:	100027f3          	csrr	a5,sstatus
    80006fcc:	0027f793          	andi	a5,a5,2
    80006fd0:	04079663          	bnez	a5,8000701c <pop_off+0x6c>
    80006fd4:	07852783          	lw	a5,120(a0)
    80006fd8:	02f05a63          	blez	a5,8000700c <pop_off+0x5c>
    80006fdc:	fff7871b          	addiw	a4,a5,-1
    80006fe0:	06e52c23          	sw	a4,120(a0)
    80006fe4:	00071c63          	bnez	a4,80006ffc <pop_off+0x4c>
    80006fe8:	07c52783          	lw	a5,124(a0)
    80006fec:	00078863          	beqz	a5,80006ffc <pop_off+0x4c>
    80006ff0:	100027f3          	csrr	a5,sstatus
    80006ff4:	0027e793          	ori	a5,a5,2
    80006ff8:	10079073          	csrw	sstatus,a5
    80006ffc:	00813083          	ld	ra,8(sp)
    80007000:	00013403          	ld	s0,0(sp)
    80007004:	01010113          	addi	sp,sp,16
    80007008:	00008067          	ret
    8000700c:	00001517          	auipc	a0,0x1
    80007010:	77450513          	addi	a0,a0,1908 # 80008780 <digits+0x48>
    80007014:	fffff097          	auipc	ra,0xfffff
    80007018:	018080e7          	jalr	24(ra) # 8000602c <panic>
    8000701c:	00001517          	auipc	a0,0x1
    80007020:	74c50513          	addi	a0,a0,1868 # 80008768 <digits+0x30>
    80007024:	fffff097          	auipc	ra,0xfffff
    80007028:	008080e7          	jalr	8(ra) # 8000602c <panic>

000000008000702c <push_on>:
    8000702c:	fe010113          	addi	sp,sp,-32
    80007030:	00813823          	sd	s0,16(sp)
    80007034:	00113c23          	sd	ra,24(sp)
    80007038:	00913423          	sd	s1,8(sp)
    8000703c:	02010413          	addi	s0,sp,32
    80007040:	100024f3          	csrr	s1,sstatus
    80007044:	100027f3          	csrr	a5,sstatus
    80007048:	0027e793          	ori	a5,a5,2
    8000704c:	10079073          	csrw	sstatus,a5
    80007050:	ffffe097          	auipc	ra,0xffffe
    80007054:	624080e7          	jalr	1572(ra) # 80005674 <mycpu>
    80007058:	07852783          	lw	a5,120(a0)
    8000705c:	02078663          	beqz	a5,80007088 <push_on+0x5c>
    80007060:	ffffe097          	auipc	ra,0xffffe
    80007064:	614080e7          	jalr	1556(ra) # 80005674 <mycpu>
    80007068:	07852783          	lw	a5,120(a0)
    8000706c:	01813083          	ld	ra,24(sp)
    80007070:	01013403          	ld	s0,16(sp)
    80007074:	0017879b          	addiw	a5,a5,1
    80007078:	06f52c23          	sw	a5,120(a0)
    8000707c:	00813483          	ld	s1,8(sp)
    80007080:	02010113          	addi	sp,sp,32
    80007084:	00008067          	ret
    80007088:	0014d493          	srli	s1,s1,0x1
    8000708c:	ffffe097          	auipc	ra,0xffffe
    80007090:	5e8080e7          	jalr	1512(ra) # 80005674 <mycpu>
    80007094:	0014f493          	andi	s1,s1,1
    80007098:	06952e23          	sw	s1,124(a0)
    8000709c:	fc5ff06f          	j	80007060 <push_on+0x34>

00000000800070a0 <pop_on>:
    800070a0:	ff010113          	addi	sp,sp,-16
    800070a4:	00813023          	sd	s0,0(sp)
    800070a8:	00113423          	sd	ra,8(sp)
    800070ac:	01010413          	addi	s0,sp,16
    800070b0:	ffffe097          	auipc	ra,0xffffe
    800070b4:	5c4080e7          	jalr	1476(ra) # 80005674 <mycpu>
    800070b8:	100027f3          	csrr	a5,sstatus
    800070bc:	0027f793          	andi	a5,a5,2
    800070c0:	04078463          	beqz	a5,80007108 <pop_on+0x68>
    800070c4:	07852783          	lw	a5,120(a0)
    800070c8:	02f05863          	blez	a5,800070f8 <pop_on+0x58>
    800070cc:	fff7879b          	addiw	a5,a5,-1
    800070d0:	06f52c23          	sw	a5,120(a0)
    800070d4:	07853783          	ld	a5,120(a0)
    800070d8:	00079863          	bnez	a5,800070e8 <pop_on+0x48>
    800070dc:	100027f3          	csrr	a5,sstatus
    800070e0:	ffd7f793          	andi	a5,a5,-3
    800070e4:	10079073          	csrw	sstatus,a5
    800070e8:	00813083          	ld	ra,8(sp)
    800070ec:	00013403          	ld	s0,0(sp)
    800070f0:	01010113          	addi	sp,sp,16
    800070f4:	00008067          	ret
    800070f8:	00001517          	auipc	a0,0x1
    800070fc:	6b050513          	addi	a0,a0,1712 # 800087a8 <digits+0x70>
    80007100:	fffff097          	auipc	ra,0xfffff
    80007104:	f2c080e7          	jalr	-212(ra) # 8000602c <panic>
    80007108:	00001517          	auipc	a0,0x1
    8000710c:	68050513          	addi	a0,a0,1664 # 80008788 <digits+0x50>
    80007110:	fffff097          	auipc	ra,0xfffff
    80007114:	f1c080e7          	jalr	-228(ra) # 8000602c <panic>

0000000080007118 <__memset>:
    80007118:	ff010113          	addi	sp,sp,-16
    8000711c:	00813423          	sd	s0,8(sp)
    80007120:	01010413          	addi	s0,sp,16
    80007124:	1a060e63          	beqz	a2,800072e0 <__memset+0x1c8>
    80007128:	40a007b3          	neg	a5,a0
    8000712c:	0077f793          	andi	a5,a5,7
    80007130:	00778693          	addi	a3,a5,7
    80007134:	00b00813          	li	a6,11
    80007138:	0ff5f593          	andi	a1,a1,255
    8000713c:	fff6071b          	addiw	a4,a2,-1
    80007140:	1b06e663          	bltu	a3,a6,800072ec <__memset+0x1d4>
    80007144:	1cd76463          	bltu	a4,a3,8000730c <__memset+0x1f4>
    80007148:	1a078e63          	beqz	a5,80007304 <__memset+0x1ec>
    8000714c:	00b50023          	sb	a1,0(a0)
    80007150:	00100713          	li	a4,1
    80007154:	1ae78463          	beq	a5,a4,800072fc <__memset+0x1e4>
    80007158:	00b500a3          	sb	a1,1(a0)
    8000715c:	00200713          	li	a4,2
    80007160:	1ae78a63          	beq	a5,a4,80007314 <__memset+0x1fc>
    80007164:	00b50123          	sb	a1,2(a0)
    80007168:	00300713          	li	a4,3
    8000716c:	18e78463          	beq	a5,a4,800072f4 <__memset+0x1dc>
    80007170:	00b501a3          	sb	a1,3(a0)
    80007174:	00400713          	li	a4,4
    80007178:	1ae78263          	beq	a5,a4,8000731c <__memset+0x204>
    8000717c:	00b50223          	sb	a1,4(a0)
    80007180:	00500713          	li	a4,5
    80007184:	1ae78063          	beq	a5,a4,80007324 <__memset+0x20c>
    80007188:	00b502a3          	sb	a1,5(a0)
    8000718c:	00700713          	li	a4,7
    80007190:	18e79e63          	bne	a5,a4,8000732c <__memset+0x214>
    80007194:	00b50323          	sb	a1,6(a0)
    80007198:	00700e93          	li	t4,7
    8000719c:	00859713          	slli	a4,a1,0x8
    800071a0:	00e5e733          	or	a4,a1,a4
    800071a4:	01059e13          	slli	t3,a1,0x10
    800071a8:	01c76e33          	or	t3,a4,t3
    800071ac:	01859313          	slli	t1,a1,0x18
    800071b0:	006e6333          	or	t1,t3,t1
    800071b4:	02059893          	slli	a7,a1,0x20
    800071b8:	40f60e3b          	subw	t3,a2,a5
    800071bc:	011368b3          	or	a7,t1,a7
    800071c0:	02859813          	slli	a6,a1,0x28
    800071c4:	0108e833          	or	a6,a7,a6
    800071c8:	03059693          	slli	a3,a1,0x30
    800071cc:	003e589b          	srliw	a7,t3,0x3
    800071d0:	00d866b3          	or	a3,a6,a3
    800071d4:	03859713          	slli	a4,a1,0x38
    800071d8:	00389813          	slli	a6,a7,0x3
    800071dc:	00f507b3          	add	a5,a0,a5
    800071e0:	00e6e733          	or	a4,a3,a4
    800071e4:	000e089b          	sext.w	a7,t3
    800071e8:	00f806b3          	add	a3,a6,a5
    800071ec:	00e7b023          	sd	a4,0(a5)
    800071f0:	00878793          	addi	a5,a5,8
    800071f4:	fed79ce3          	bne	a5,a3,800071ec <__memset+0xd4>
    800071f8:	ff8e7793          	andi	a5,t3,-8
    800071fc:	0007871b          	sext.w	a4,a5
    80007200:	01d787bb          	addw	a5,a5,t4
    80007204:	0ce88e63          	beq	a7,a4,800072e0 <__memset+0x1c8>
    80007208:	00f50733          	add	a4,a0,a5
    8000720c:	00b70023          	sb	a1,0(a4)
    80007210:	0017871b          	addiw	a4,a5,1
    80007214:	0cc77663          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007218:	00e50733          	add	a4,a0,a4
    8000721c:	00b70023          	sb	a1,0(a4)
    80007220:	0027871b          	addiw	a4,a5,2
    80007224:	0ac77e63          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007228:	00e50733          	add	a4,a0,a4
    8000722c:	00b70023          	sb	a1,0(a4)
    80007230:	0037871b          	addiw	a4,a5,3
    80007234:	0ac77663          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007238:	00e50733          	add	a4,a0,a4
    8000723c:	00b70023          	sb	a1,0(a4)
    80007240:	0047871b          	addiw	a4,a5,4
    80007244:	08c77e63          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007248:	00e50733          	add	a4,a0,a4
    8000724c:	00b70023          	sb	a1,0(a4)
    80007250:	0057871b          	addiw	a4,a5,5
    80007254:	08c77663          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007258:	00e50733          	add	a4,a0,a4
    8000725c:	00b70023          	sb	a1,0(a4)
    80007260:	0067871b          	addiw	a4,a5,6
    80007264:	06c77e63          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007268:	00e50733          	add	a4,a0,a4
    8000726c:	00b70023          	sb	a1,0(a4)
    80007270:	0077871b          	addiw	a4,a5,7
    80007274:	06c77663          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007278:	00e50733          	add	a4,a0,a4
    8000727c:	00b70023          	sb	a1,0(a4)
    80007280:	0087871b          	addiw	a4,a5,8
    80007284:	04c77e63          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007288:	00e50733          	add	a4,a0,a4
    8000728c:	00b70023          	sb	a1,0(a4)
    80007290:	0097871b          	addiw	a4,a5,9
    80007294:	04c77663          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    80007298:	00e50733          	add	a4,a0,a4
    8000729c:	00b70023          	sb	a1,0(a4)
    800072a0:	00a7871b          	addiw	a4,a5,10
    800072a4:	02c77e63          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    800072a8:	00e50733          	add	a4,a0,a4
    800072ac:	00b70023          	sb	a1,0(a4)
    800072b0:	00b7871b          	addiw	a4,a5,11
    800072b4:	02c77663          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    800072b8:	00e50733          	add	a4,a0,a4
    800072bc:	00b70023          	sb	a1,0(a4)
    800072c0:	00c7871b          	addiw	a4,a5,12
    800072c4:	00c77e63          	bgeu	a4,a2,800072e0 <__memset+0x1c8>
    800072c8:	00e50733          	add	a4,a0,a4
    800072cc:	00b70023          	sb	a1,0(a4)
    800072d0:	00d7879b          	addiw	a5,a5,13
    800072d4:	00c7f663          	bgeu	a5,a2,800072e0 <__memset+0x1c8>
    800072d8:	00f507b3          	add	a5,a0,a5
    800072dc:	00b78023          	sb	a1,0(a5)
    800072e0:	00813403          	ld	s0,8(sp)
    800072e4:	01010113          	addi	sp,sp,16
    800072e8:	00008067          	ret
    800072ec:	00b00693          	li	a3,11
    800072f0:	e55ff06f          	j	80007144 <__memset+0x2c>
    800072f4:	00300e93          	li	t4,3
    800072f8:	ea5ff06f          	j	8000719c <__memset+0x84>
    800072fc:	00100e93          	li	t4,1
    80007300:	e9dff06f          	j	8000719c <__memset+0x84>
    80007304:	00000e93          	li	t4,0
    80007308:	e95ff06f          	j	8000719c <__memset+0x84>
    8000730c:	00000793          	li	a5,0
    80007310:	ef9ff06f          	j	80007208 <__memset+0xf0>
    80007314:	00200e93          	li	t4,2
    80007318:	e85ff06f          	j	8000719c <__memset+0x84>
    8000731c:	00400e93          	li	t4,4
    80007320:	e7dff06f          	j	8000719c <__memset+0x84>
    80007324:	00500e93          	li	t4,5
    80007328:	e75ff06f          	j	8000719c <__memset+0x84>
    8000732c:	00600e93          	li	t4,6
    80007330:	e6dff06f          	j	8000719c <__memset+0x84>

0000000080007334 <__memmove>:
    80007334:	ff010113          	addi	sp,sp,-16
    80007338:	00813423          	sd	s0,8(sp)
    8000733c:	01010413          	addi	s0,sp,16
    80007340:	0e060863          	beqz	a2,80007430 <__memmove+0xfc>
    80007344:	fff6069b          	addiw	a3,a2,-1
    80007348:	0006881b          	sext.w	a6,a3
    8000734c:	0ea5e863          	bltu	a1,a0,8000743c <__memmove+0x108>
    80007350:	00758713          	addi	a4,a1,7
    80007354:	00a5e7b3          	or	a5,a1,a0
    80007358:	40a70733          	sub	a4,a4,a0
    8000735c:	0077f793          	andi	a5,a5,7
    80007360:	00f73713          	sltiu	a4,a4,15
    80007364:	00174713          	xori	a4,a4,1
    80007368:	0017b793          	seqz	a5,a5
    8000736c:	00e7f7b3          	and	a5,a5,a4
    80007370:	10078863          	beqz	a5,80007480 <__memmove+0x14c>
    80007374:	00900793          	li	a5,9
    80007378:	1107f463          	bgeu	a5,a6,80007480 <__memmove+0x14c>
    8000737c:	0036581b          	srliw	a6,a2,0x3
    80007380:	fff8081b          	addiw	a6,a6,-1
    80007384:	02081813          	slli	a6,a6,0x20
    80007388:	01d85893          	srli	a7,a6,0x1d
    8000738c:	00858813          	addi	a6,a1,8
    80007390:	00058793          	mv	a5,a1
    80007394:	00050713          	mv	a4,a0
    80007398:	01088833          	add	a6,a7,a6
    8000739c:	0007b883          	ld	a7,0(a5)
    800073a0:	00878793          	addi	a5,a5,8
    800073a4:	00870713          	addi	a4,a4,8
    800073a8:	ff173c23          	sd	a7,-8(a4)
    800073ac:	ff0798e3          	bne	a5,a6,8000739c <__memmove+0x68>
    800073b0:	ff867713          	andi	a4,a2,-8
    800073b4:	02071793          	slli	a5,a4,0x20
    800073b8:	0207d793          	srli	a5,a5,0x20
    800073bc:	00f585b3          	add	a1,a1,a5
    800073c0:	40e686bb          	subw	a3,a3,a4
    800073c4:	00f507b3          	add	a5,a0,a5
    800073c8:	06e60463          	beq	a2,a4,80007430 <__memmove+0xfc>
    800073cc:	0005c703          	lbu	a4,0(a1)
    800073d0:	00e78023          	sb	a4,0(a5)
    800073d4:	04068e63          	beqz	a3,80007430 <__memmove+0xfc>
    800073d8:	0015c603          	lbu	a2,1(a1)
    800073dc:	00100713          	li	a4,1
    800073e0:	00c780a3          	sb	a2,1(a5)
    800073e4:	04e68663          	beq	a3,a4,80007430 <__memmove+0xfc>
    800073e8:	0025c603          	lbu	a2,2(a1)
    800073ec:	00200713          	li	a4,2
    800073f0:	00c78123          	sb	a2,2(a5)
    800073f4:	02e68e63          	beq	a3,a4,80007430 <__memmove+0xfc>
    800073f8:	0035c603          	lbu	a2,3(a1)
    800073fc:	00300713          	li	a4,3
    80007400:	00c781a3          	sb	a2,3(a5)
    80007404:	02e68663          	beq	a3,a4,80007430 <__memmove+0xfc>
    80007408:	0045c603          	lbu	a2,4(a1)
    8000740c:	00400713          	li	a4,4
    80007410:	00c78223          	sb	a2,4(a5)
    80007414:	00e68e63          	beq	a3,a4,80007430 <__memmove+0xfc>
    80007418:	0055c603          	lbu	a2,5(a1)
    8000741c:	00500713          	li	a4,5
    80007420:	00c782a3          	sb	a2,5(a5)
    80007424:	00e68663          	beq	a3,a4,80007430 <__memmove+0xfc>
    80007428:	0065c703          	lbu	a4,6(a1)
    8000742c:	00e78323          	sb	a4,6(a5)
    80007430:	00813403          	ld	s0,8(sp)
    80007434:	01010113          	addi	sp,sp,16
    80007438:	00008067          	ret
    8000743c:	02061713          	slli	a4,a2,0x20
    80007440:	02075713          	srli	a4,a4,0x20
    80007444:	00e587b3          	add	a5,a1,a4
    80007448:	f0f574e3          	bgeu	a0,a5,80007350 <__memmove+0x1c>
    8000744c:	02069613          	slli	a2,a3,0x20
    80007450:	02065613          	srli	a2,a2,0x20
    80007454:	fff64613          	not	a2,a2
    80007458:	00e50733          	add	a4,a0,a4
    8000745c:	00c78633          	add	a2,a5,a2
    80007460:	fff7c683          	lbu	a3,-1(a5)
    80007464:	fff78793          	addi	a5,a5,-1
    80007468:	fff70713          	addi	a4,a4,-1
    8000746c:	00d70023          	sb	a3,0(a4)
    80007470:	fec798e3          	bne	a5,a2,80007460 <__memmove+0x12c>
    80007474:	00813403          	ld	s0,8(sp)
    80007478:	01010113          	addi	sp,sp,16
    8000747c:	00008067          	ret
    80007480:	02069713          	slli	a4,a3,0x20
    80007484:	02075713          	srli	a4,a4,0x20
    80007488:	00170713          	addi	a4,a4,1
    8000748c:	00e50733          	add	a4,a0,a4
    80007490:	00050793          	mv	a5,a0
    80007494:	0005c683          	lbu	a3,0(a1)
    80007498:	00178793          	addi	a5,a5,1
    8000749c:	00158593          	addi	a1,a1,1
    800074a0:	fed78fa3          	sb	a3,-1(a5)
    800074a4:	fee798e3          	bne	a5,a4,80007494 <__memmove+0x160>
    800074a8:	f89ff06f          	j	80007430 <__memmove+0xfc>
	...

Disassembly of section .user:

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

    uint64 status = 0;

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
    8000d43c:	b98080e7          	jalr	-1128(ra) # 8000efd0 <_Znwm>
    8000d440:	00050913          	mv	s2,a0
    8000d444:	00050863          	beqz	a0,8000d454 <_ZN9BufferCPPC1Ei+0x68>
    8000d448:	00000593          	li	a1,0
    8000d44c:	00002097          	auipc	ra,0x2
    8000d450:	c7c080e7          	jalr	-900(ra) # 8000f0c8 <_ZN9SemaphoreC1Ej>
    8000d454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000d458:	01000513          	li	a0,16
    8000d45c:	00002097          	auipc	ra,0x2
    8000d460:	b74080e7          	jalr	-1164(ra) # 8000efd0 <_Znwm>
    8000d464:	00050913          	mv	s2,a0
    8000d468:	00050863          	beqz	a0,8000d478 <_ZN9BufferCPPC1Ei+0x8c>
    8000d46c:	00098593          	mv	a1,s3
    8000d470:	00002097          	auipc	ra,0x2
    8000d474:	c58080e7          	jalr	-936(ra) # 8000f0c8 <_ZN9SemaphoreC1Ej>
    8000d478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000d47c:	01000513          	li	a0,16
    8000d480:	00002097          	auipc	ra,0x2
    8000d484:	b50080e7          	jalr	-1200(ra) # 8000efd0 <_Znwm>
    8000d488:	00050913          	mv	s2,a0
    8000d48c:	00050863          	beqz	a0,8000d49c <_ZN9BufferCPPC1Ei+0xb0>
    8000d490:	00100593          	li	a1,1
    8000d494:	00002097          	auipc	ra,0x2
    8000d498:	c34080e7          	jalr	-972(ra) # 8000f0c8 <_ZN9SemaphoreC1Ej>
    8000d49c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000d4a0:	01000513          	li	a0,16
    8000d4a4:	00002097          	auipc	ra,0x2
    8000d4a8:	b2c080e7          	jalr	-1236(ra) # 8000efd0 <_Znwm>
    8000d4ac:	00050913          	mv	s2,a0
    8000d4b0:	00050863          	beqz	a0,8000d4c0 <_ZN9BufferCPPC1Ei+0xd4>
    8000d4b4:	00100593          	li	a1,1
    8000d4b8:	00002097          	auipc	ra,0x2
    8000d4bc:	c10080e7          	jalr	-1008(ra) # 8000f0c8 <_ZN9SemaphoreC1Ej>
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
    8000d4ec:	b38080e7          	jalr	-1224(ra) # 8000f020 <_ZdlPv>
    8000d4f0:	00048513          	mv	a0,s1
    8000d4f4:	fffff097          	auipc	ra,0xfffff
    8000d4f8:	eb4080e7          	jalr	-332(ra) # 8000c3a8 <_Unwind_Resume>
    8000d4fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000d500:	00090513          	mv	a0,s2
    8000d504:	00002097          	auipc	ra,0x2
    8000d508:	b1c080e7          	jalr	-1252(ra) # 8000f020 <_ZdlPv>
    8000d50c:	00048513          	mv	a0,s1
    8000d510:	fffff097          	auipc	ra,0xfffff
    8000d514:	e98080e7          	jalr	-360(ra) # 8000c3a8 <_Unwind_Resume>
    8000d518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000d51c:	00090513          	mv	a0,s2
    8000d520:	00002097          	auipc	ra,0x2
    8000d524:	b00080e7          	jalr	-1280(ra) # 8000f020 <_ZdlPv>
    8000d528:	00048513          	mv	a0,s1
    8000d52c:	fffff097          	auipc	ra,0xfffff
    8000d530:	e7c080e7          	jalr	-388(ra) # 8000c3a8 <_Unwind_Resume>
    8000d534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000d538:	00090513          	mv	a0,s2
    8000d53c:	00002097          	auipc	ra,0x2
    8000d540:	ae4080e7          	jalr	-1308(ra) # 8000f020 <_ZdlPv>
    8000d544:	00048513          	mv	a0,s1
    8000d548:	fffff097          	auipc	ra,0xfffff
    8000d54c:	e60080e7          	jalr	-416(ra) # 8000c3a8 <_Unwind_Resume>

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
    8000d578:	b8c080e7          	jalr	-1140(ra) # 8000f100 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000d57c:	0304b503          	ld	a0,48(s1)
    8000d580:	00002097          	auipc	ra,0x2
    8000d584:	b80080e7          	jalr	-1152(ra) # 8000f100 <_ZN9Semaphore4waitEv>
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
    8000d5b8:	b78080e7          	jalr	-1160(ra) # 8000f12c <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000d5bc:	0204b503          	ld	a0,32(s1)
    8000d5c0:	00002097          	auipc	ra,0x2
    8000d5c4:	b6c080e7          	jalr	-1172(ra) # 8000f12c <_ZN9Semaphore6signalEv>

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
    8000d604:	b00080e7          	jalr	-1280(ra) # 8000f100 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000d608:	0284b503          	ld	a0,40(s1)
    8000d60c:	00002097          	auipc	ra,0x2
    8000d610:	af4080e7          	jalr	-1292(ra) # 8000f100 <_ZN9Semaphore4waitEv>

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
    8000d640:	af0080e7          	jalr	-1296(ra) # 8000f12c <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000d644:	0184b503          	ld	a0,24(s1)
    8000d648:	00002097          	auipc	ra,0x2
    8000d64c:	ae4080e7          	jalr	-1308(ra) # 8000f12c <_ZN9Semaphore6signalEv>

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
    8000d690:	a74080e7          	jalr	-1420(ra) # 8000f100 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000d694:	0304b503          	ld	a0,48(s1)
    8000d698:	00002097          	auipc	ra,0x2
    8000d69c:	a68080e7          	jalr	-1432(ra) # 8000f100 <_ZN9Semaphore4waitEv>

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
    8000d6b8:	a78080e7          	jalr	-1416(ra) # 8000f12c <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000d6bc:	0284b503          	ld	a0,40(s1)
    8000d6c0:	00002097          	auipc	ra,0x2
    8000d6c4:	a6c080e7          	jalr	-1428(ra) # 8000f12c <_ZN9Semaphore6signalEv>

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
    8000d714:	c54080e7          	jalr	-940(ra) # 8000f364 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000d718:	00003517          	auipc	a0,0x3
    8000d71c:	8e850513          	addi	a0,a0,-1816 # 80010000 <userDataStart>
    8000d720:	00001097          	auipc	ra,0x1
    8000d724:	560080e7          	jalr	1376(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000d750:	c18080e7          	jalr	-1000(ra) # 8000f364 <_ZN7Console4putcEc>
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
    8000d774:	bf4080e7          	jalr	-1036(ra) # 8000f364 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000d778:	00a00513          	li	a0,10
    8000d77c:	00002097          	auipc	ra,0x2
    8000d780:	be8080e7          	jalr	-1048(ra) # 8000f364 <_ZN7Console4putcEc>
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
    8000d85c:	428080e7          	jalr	1064(ra) # 8000ec80 <_Z11printStringPKc>
    8000d860:	00000613          	li	a2,0
    8000d864:	00a00593          	li	a1,10
    8000d868:	0009051b          	sext.w	a0,s2
    8000d86c:	00001097          	auipc	ra,0x1
    8000d870:	5ac080e7          	jalr	1452(ra) # 8000ee18 <_Z8printIntiii>
    8000d874:	00003517          	auipc	a0,0x3
    8000d878:	8d450513          	addi	a0,a0,-1836 # 80010148 <userDataStart+0x148>
    8000d87c:	00001097          	auipc	ra,0x1
    8000d880:	404080e7          	jalr	1028(ra) # 8000ec80 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d884:	00000493          	li	s1,0
    8000d888:	f99ff06f          	j	8000d820 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000d88c:	00002517          	auipc	a0,0x2
    8000d890:	79450513          	addi	a0,a0,1940 # 80010020 <userDataStart+0x20>
    8000d894:	00001097          	auipc	ra,0x1
    8000d898:	3ec080e7          	jalr	1004(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000d928:	35c080e7          	jalr	860(ra) # 8000ec80 <_Z11printStringPKc>
    8000d92c:	00000613          	li	a2,0
    8000d930:	00a00593          	li	a1,10
    8000d934:	0009051b          	sext.w	a0,s2
    8000d938:	00001097          	auipc	ra,0x1
    8000d93c:	4e0080e7          	jalr	1248(ra) # 8000ee18 <_Z8printIntiii>
    8000d940:	00003517          	auipc	a0,0x3
    8000d944:	80850513          	addi	a0,a0,-2040 # 80010148 <userDataStart+0x148>
    8000d948:	00001097          	auipc	ra,0x1
    8000d94c:	338080e7          	jalr	824(ra) # 8000ec80 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d950:	00000493          	li	s1,0
    8000d954:	f99ff06f          	j	8000d8ec <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000d958:	00002517          	auipc	a0,0x2
    8000d95c:	6e050513          	addi	a0,a0,1760 # 80010038 <userDataStart+0x38>
    8000d960:	00001097          	auipc	ra,0x1
    8000d964:	320080e7          	jalr	800(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000da34:	250080e7          	jalr	592(ra) # 8000ec80 <_Z11printStringPKc>
    8000da38:	00000613          	li	a2,0
    8000da3c:	00a00593          	li	a1,10
    8000da40:	00048513          	mv	a0,s1
    8000da44:	00001097          	auipc	ra,0x1
    8000da48:	3d4080e7          	jalr	980(ra) # 8000ee18 <_Z8printIntiii>
    8000da4c:	00002517          	auipc	a0,0x2
    8000da50:	6fc50513          	addi	a0,a0,1788 # 80010148 <userDataStart+0x148>
    8000da54:	00001097          	auipc	ra,0x1
    8000da58:	22c080e7          	jalr	556(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000da78:	20c080e7          	jalr	524(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000da98:	1ec080e7          	jalr	492(ra) # 8000ec80 <_Z11printStringPKc>
    8000da9c:	00000613          	li	a2,0
    8000daa0:	00a00593          	li	a1,10
    8000daa4:	0009051b          	sext.w	a0,s2
    8000daa8:	00001097          	auipc	ra,0x1
    8000daac:	370080e7          	jalr	880(ra) # 8000ee18 <_Z8printIntiii>
    8000dab0:	00002517          	auipc	a0,0x2
    8000dab4:	69850513          	addi	a0,a0,1688 # 80010148 <userDataStart+0x148>
    8000dab8:	00001097          	auipc	ra,0x1
    8000dabc:	1c8080e7          	jalr	456(ra) # 8000ec80 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000dac0:	00c00513          	li	a0,12
    8000dac4:	00000097          	auipc	ra,0x0
    8000dac8:	ed0080e7          	jalr	-304(ra) # 8000d994 <_Z9fibonaccim>
    8000dacc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000dad0:	00002517          	auipc	a0,0x2
    8000dad4:	59850513          	addi	a0,a0,1432 # 80010068 <userDataStart+0x68>
    8000dad8:	00001097          	auipc	ra,0x1
    8000dadc:	1a8080e7          	jalr	424(ra) # 8000ec80 <_Z11printStringPKc>
    8000dae0:	00000613          	li	a2,0
    8000dae4:	00a00593          	li	a1,10
    8000dae8:	0009051b          	sext.w	a0,s2
    8000daec:	00001097          	auipc	ra,0x1
    8000daf0:	32c080e7          	jalr	812(ra) # 8000ee18 <_Z8printIntiii>
    8000daf4:	00002517          	auipc	a0,0x2
    8000daf8:	65450513          	addi	a0,a0,1620 # 80010148 <userDataStart+0x148>
    8000dafc:	00001097          	auipc	ra,0x1
    8000db00:	184080e7          	jalr	388(ra) # 8000ec80 <_Z11printStringPKc>
    8000db04:	0400006f          	j	8000db44 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000db08:	00002517          	auipc	a0,0x2
    8000db0c:	54050513          	addi	a0,a0,1344 # 80010048 <userDataStart+0x48>
    8000db10:	00001097          	auipc	ra,0x1
    8000db14:	170080e7          	jalr	368(ra) # 8000ec80 <_Z11printStringPKc>
    8000db18:	00000613          	li	a2,0
    8000db1c:	00a00593          	li	a1,10
    8000db20:	00048513          	mv	a0,s1
    8000db24:	00001097          	auipc	ra,0x1
    8000db28:	2f4080e7          	jalr	756(ra) # 8000ee18 <_Z8printIntiii>
    8000db2c:	00002517          	auipc	a0,0x2
    8000db30:	61c50513          	addi	a0,a0,1564 # 80010148 <userDataStart+0x148>
    8000db34:	00001097          	auipc	ra,0x1
    8000db38:	14c080e7          	jalr	332(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000db58:	12c080e7          	jalr	300(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000dbb4:	0d0080e7          	jalr	208(ra) # 8000ec80 <_Z11printStringPKc>
    8000dbb8:	00000613          	li	a2,0
    8000dbbc:	00a00593          	li	a1,10
    8000dbc0:	00048513          	mv	a0,s1
    8000dbc4:	00001097          	auipc	ra,0x1
    8000dbc8:	254080e7          	jalr	596(ra) # 8000ee18 <_Z8printIntiii>
    8000dbcc:	00002517          	auipc	a0,0x2
    8000dbd0:	57c50513          	addi	a0,a0,1404 # 80010148 <userDataStart+0x148>
    8000dbd4:	00001097          	auipc	ra,0x1
    8000dbd8:	0ac080e7          	jalr	172(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000dbf8:	08c080e7          	jalr	140(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000dc24:	060080e7          	jalr	96(ra) # 8000ec80 <_Z11printStringPKc>
    8000dc28:	00000613          	li	a2,0
    8000dc2c:	00a00593          	li	a1,10
    8000dc30:	0009051b          	sext.w	a0,s2
    8000dc34:	00001097          	auipc	ra,0x1
    8000dc38:	1e4080e7          	jalr	484(ra) # 8000ee18 <_Z8printIntiii>
    8000dc3c:	00002517          	auipc	a0,0x2
    8000dc40:	50c50513          	addi	a0,a0,1292 # 80010148 <userDataStart+0x148>
    8000dc44:	00001097          	auipc	ra,0x1
    8000dc48:	03c080e7          	jalr	60(ra) # 8000ec80 <_Z11printStringPKc>
    8000dc4c:	0400006f          	j	8000dc8c <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000dc50:	00002517          	auipc	a0,0x2
    8000dc54:	42850513          	addi	a0,a0,1064 # 80010078 <userDataStart+0x78>
    8000dc58:	00001097          	auipc	ra,0x1
    8000dc5c:	028080e7          	jalr	40(ra) # 8000ec80 <_Z11printStringPKc>
    8000dc60:	00000613          	li	a2,0
    8000dc64:	00a00593          	li	a1,10
    8000dc68:	00048513          	mv	a0,s1
    8000dc6c:	00001097          	auipc	ra,0x1
    8000dc70:	1ac080e7          	jalr	428(ra) # 8000ee18 <_Z8printIntiii>
    8000dc74:	00002517          	auipc	a0,0x2
    8000dc78:	4d450513          	addi	a0,a0,1236 # 80010148 <userDataStart+0x148>
    8000dc7c:	00001097          	auipc	ra,0x1
    8000dc80:	004080e7          	jalr	4(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000dca0:	fe4080e7          	jalr	-28(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000dd08:	f7c080e7          	jalr	-132(ra) # 8000ec80 <_Z11printStringPKc>

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
    8000dd30:	f54080e7          	jalr	-172(ra) # 8000ec80 <_Z11printStringPKc>

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
    8000dd58:	f2c080e7          	jalr	-212(ra) # 8000ec80 <_Z11printStringPKc>

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
    8000dd80:	f04080e7          	jalr	-252(ra) # 8000ec80 <_Z11printStringPKc>
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
    8000de40:	e44080e7          	jalr	-444(ra) # 8000ec80 <_Z11printStringPKc>
        getString(input, 30);
    8000de44:	01e00593          	li	a1,30
    8000de48:	f8040493          	addi	s1,s0,-128
    8000de4c:	00048513          	mv	a0,s1
    8000de50:	00001097          	auipc	ra,0x1
    8000de54:	eac080e7          	jalr	-340(ra) # 8000ecfc <_Z9getStringPci>
        threadNum = stringToInt(input);
    8000de58:	00048513          	mv	a0,s1
    8000de5c:	00001097          	auipc	ra,0x1
    8000de60:	f6c080e7          	jalr	-148(ra) # 8000edc8 <_Z11stringToIntPKc>
    8000de64:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    8000de68:	00002517          	auipc	a0,0x2
    8000de6c:	2c850513          	addi	a0,a0,712 # 80010130 <userDataStart+0x130>
    8000de70:	00001097          	auipc	ra,0x1
    8000de74:	e10080e7          	jalr	-496(ra) # 8000ec80 <_Z11printStringPKc>
        getString(input, 30);
    8000de78:	01e00593          	li	a1,30
    8000de7c:	00048513          	mv	a0,s1
    8000de80:	00001097          	auipc	ra,0x1
    8000de84:	e7c080e7          	jalr	-388(ra) # 8000ecfc <_Z9getStringPci>
        n = stringToInt(input);
    8000de88:	00048513          	mv	a0,s1
    8000de8c:	00001097          	auipc	ra,0x1
    8000de90:	f3c080e7          	jalr	-196(ra) # 8000edc8 <_Z11stringToIntPKc>
    8000de94:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    8000de98:	00002517          	auipc	a0,0x2
    8000de9c:	2b850513          	addi	a0,a0,696 # 80010150 <userDataStart+0x150>
    8000dea0:	00001097          	auipc	ra,0x1
    8000dea4:	de0080e7          	jalr	-544(ra) # 8000ec80 <_Z11printStringPKc>
    8000dea8:	00000613          	li	a2,0
    8000deac:	00a00593          	li	a1,10
    8000deb0:	00090513          	mv	a0,s2
    8000deb4:	00001097          	auipc	ra,0x1
    8000deb8:	f64080e7          	jalr	-156(ra) # 8000ee18 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000debc:	00002517          	auipc	a0,0x2
    8000dec0:	2ac50513          	addi	a0,a0,684 # 80010168 <userDataStart+0x168>
    8000dec4:	00001097          	auipc	ra,0x1
    8000dec8:	dbc080e7          	jalr	-580(ra) # 8000ec80 <_Z11printStringPKc>
    8000decc:	00000613          	li	a2,0
    8000ded0:	00a00593          	li	a1,10
    8000ded4:	00048513          	mv	a0,s1
    8000ded8:	00001097          	auipc	ra,0x1
    8000dedc:	f40080e7          	jalr	-192(ra) # 8000ee18 <_Z8printIntiii>
        printString(".\n");
    8000dee0:	00002517          	auipc	a0,0x2
    8000dee4:	2a050513          	addi	a0,a0,672 # 80010180 <userDataStart+0x180>
    8000dee8:	00001097          	auipc	ra,0x1
    8000deec:	d98080e7          	jalr	-616(ra) # 8000ec80 <_Z11printStringPKc>
        if(threadNum > n) {
    8000def0:	0324c663          	blt	s1,s2,8000df1c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    8000def4:	03205e63          	blez	s2,8000df30 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    8000def8:	03800513          	li	a0,56
    8000defc:	00001097          	auipc	ra,0x1
    8000df00:	0d4080e7          	jalr	212(ra) # 8000efd0 <_Znwm>
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
    8000df28:	d5c080e7          	jalr	-676(ra) # 8000ec80 <_Z11printStringPKc>
            return;
    8000df2c:	0140006f          	j	8000df40 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000df30:	00002517          	auipc	a0,0x2
    8000df34:	29850513          	addi	a0,a0,664 # 800101c8 <userDataStart+0x1c8>
    8000df38:	00001097          	auipc	ra,0x1
    8000df3c:	d48080e7          	jalr	-696(ra) # 8000ec80 <_Z11printStringPKc>
            return;
    8000df40:	000b8113          	mv	sp,s7
    8000df44:	24c0006f          	j	8000e190 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    8000df48:	01000513          	li	a0,16
    8000df4c:	00001097          	auipc	ra,0x1
    8000df50:	084080e7          	jalr	132(ra) # 8000efd0 <_Znwm>
    8000df54:	00050493          	mv	s1,a0
    8000df58:	00050863          	beqz	a0,8000df68 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000df5c:	00000593          	li	a1,0
    8000df60:	00001097          	auipc	ra,0x1
    8000df64:	168080e7          	jalr	360(ra) # 8000f0c8 <_ZN9SemaphoreC1Ej>
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
    8000dfd0:	004080e7          	jalr	4(ra) # 8000efd0 <_Znwm>
    8000dfd4:	00050b13          	mv	s6,a0
    8000dfd8:	02050663          	beqz	a0,8000e004 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    8000dfdc:	00191493          	slli	s1,s2,0x1
    8000dfe0:	012484b3          	add	s1,s1,s2
    8000dfe4:	00349493          	slli	s1,s1,0x3
    8000dfe8:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000dfec:	00001097          	auipc	ra,0x1
    8000dff0:	1c0080e7          	jalr	448(ra) # 8000f1ac <_ZN6ThreadC1Ev>
    8000dff4:	00002797          	auipc	a5,0x2
    8000dff8:	2ac78793          	addi	a5,a5,684 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000dffc:	00fb3023          	sd	a5,0(s6) # 2000 <_entry-0x7fffe000>
    8000e000:	009b3823          	sd	s1,16(s6)
        consumer->start();
    8000e004:	000b0513          	mv	a0,s6
    8000e008:	00001097          	auipc	ra,0x1
    8000e00c:	294080e7          	jalr	660(ra) # 8000f29c <_ZN6Thread5startEv>
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
    8000e02c:	fa8080e7          	jalr	-88(ra) # 8000efd0 <_Znwm>
    8000e030:	00050493          	mv	s1,a0
    8000e034:	00050e63          	beqz	a0,8000e050 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    8000e038:	00001097          	auipc	ra,0x1
    8000e03c:	174080e7          	jalr	372(ra) # 8000f1ac <_ZN6ThreadC1Ev>
    8000e040:	00002797          	auipc	a5,0x2
    8000e044:	21078793          	addi	a5,a5,528 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e048:	00f4b023          	sd	a5,0(s1)
    8000e04c:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e050:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    8000e054:	00048513          	mv	a0,s1
    8000e058:	00001097          	auipc	ra,0x1
    8000e05c:	244080e7          	jalr	580(ra) # 8000f29c <_ZN6Thread5startEv>
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
    8000e08c:	214080e7          	jalr	532(ra) # 8000f29c <_ZN6Thread5startEv>
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
    8000e0c4:	f10080e7          	jalr	-240(ra) # 8000efd0 <_Znwm>
    8000e0c8:	00050c13          	mv	s8,a0
    8000e0cc:	fa0506e3          	beqz	a0,8000e078 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    8000e0d0:	00149c93          	slli	s9,s1,0x1
    8000e0d4:	009c8cb3          	add	s9,s9,s1
    8000e0d8:	003c9c93          	slli	s9,s9,0x3
    8000e0dc:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000e0e0:	00001097          	auipc	ra,0x1
    8000e0e4:	0cc080e7          	jalr	204(ra) # 8000f1ac <_ZN6ThreadC1Ev>
    8000e0e8:	f81ff06f          	j	8000e068 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    8000e0ec:	00001097          	auipc	ra,0x1
    8000e0f0:	188080e7          	jalr	392(ra) # 8000f274 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000e0f4:	00000493          	li	s1,0
    8000e0f8:	00994e63          	blt	s2,s1,8000e114 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    8000e0fc:	00002517          	auipc	a0,0x2
    8000e100:	28453503          	ld	a0,644(a0) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e104:	00001097          	auipc	ra,0x1
    8000e108:	ffc080e7          	jalr	-4(ra) # 8000f100 <_ZN9Semaphore4waitEv>
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
    8000e188:	e9c080e7          	jalr	-356(ra) # 8000f020 <_ZdlPv>
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
    8000e1d4:	e50080e7          	jalr	-432(ra) # 8000f020 <_ZdlPv>
    8000e1d8:	00048513          	mv	a0,s1
    8000e1dc:	ffffe097          	auipc	ra,0xffffe
    8000e1e0:	1cc080e7          	jalr	460(ra) # 8000c3a8 <_Unwind_Resume>
    8000e1e4:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    8000e1e8:	00048513          	mv	a0,s1
    8000e1ec:	00001097          	auipc	ra,0x1
    8000e1f0:	e34080e7          	jalr	-460(ra) # 8000f020 <_ZdlPv>
    8000e1f4:	00090513          	mv	a0,s2
    8000e1f8:	ffffe097          	auipc	ra,0xffffe
    8000e1fc:	1b0080e7          	jalr	432(ra) # 8000c3a8 <_Unwind_Resume>
    8000e200:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000e204:	000b0513          	mv	a0,s6
    8000e208:	00001097          	auipc	ra,0x1
    8000e20c:	e18080e7          	jalr	-488(ra) # 8000f020 <_ZdlPv>
    8000e210:	00048513          	mv	a0,s1
    8000e214:	ffffe097          	auipc	ra,0xffffe
    8000e218:	194080e7          	jalr	404(ra) # 8000c3a8 <_Unwind_Resume>
    8000e21c:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e220:	00048513          	mv	a0,s1
    8000e224:	00001097          	auipc	ra,0x1
    8000e228:	dfc080e7          	jalr	-516(ra) # 8000f020 <_ZdlPv>
    8000e22c:	00090513          	mv	a0,s2
    8000e230:	ffffe097          	auipc	ra,0xffffe
    8000e234:	178080e7          	jalr	376(ra) # 8000c3a8 <_Unwind_Resume>
    8000e238:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000e23c:	000c0513          	mv	a0,s8
    8000e240:	00001097          	auipc	ra,0x1
    8000e244:	de0080e7          	jalr	-544(ra) # 8000f020 <_ZdlPv>
    8000e248:	00048513          	mv	a0,s1
    8000e24c:	ffffe097          	auipc	ra,0xffffe
    8000e250:	15c080e7          	jalr	348(ra) # 8000c3a8 <_Unwind_Resume>

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
    8000e274:	f3c080e7          	jalr	-196(ra) # 8000f1ac <_ZN6ThreadC1Ev>
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
    8000e298:	008080e7          	jalr	8(ra) # 8000f29c <_ZN6Thread5startEv>
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
    8000e2bc:	9c8080e7          	jalr	-1592(ra) # 8000ec80 <_Z11printStringPKc>
class ForkThread : public Thread {
    8000e2c0:	00002797          	auipc	a5,0x2
    8000e2c4:	00878793          	addi	a5,a5,8 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e2c8:	fcf43023          	sd	a5,-64(s0)
    8000e2cc:	fc040513          	addi	a0,s0,-64
    8000e2d0:	00001097          	auipc	ra,0x1
    8000e2d4:	cc0080e7          	jalr	-832(ra) # 8000ef90 <_ZN6ThreadD1Ev>
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
    8000e304:	c90080e7          	jalr	-880(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e308:	00048513          	mv	a0,s1
    8000e30c:	ffffe097          	auipc	ra,0xffffe
    8000e310:	09c080e7          	jalr	156(ra) # 8000c3a8 <_Unwind_Resume>

000000008000e314 <_Z8userMainv>:
//#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta
#include "testUser.hpp"
#include "../../../h/kernel/buddy_allocator.hpp"

void userMain() {
    8000e314:	ff010113          	addi	sp,sp,-16
    8000e318:	00113423          	sd	ra,8(sp)
    8000e31c:	00813023          	sd	s0,0(sp)
    8000e320:	01010413          	addi	s0,sp,16
    uint64 *x = (uint64*)HEAP_START_ADDR;
    8000e324:	ffffd797          	auipc	a5,0xffffd
    8000e328:	c4c7b783          	ld	a5,-948(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000e32c:	0007b783          	ld	a5,0(a5)
    *x=3;
    8000e330:	00300713          	li	a4,3
    8000e334:	00e7b023          	sd	a4,0(a5)

//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    8000e338:	00000097          	auipc	ra,0x0
    8000e33c:	ac4080e7          	jalr	-1340(ra) # 8000ddfc <_ZN19ConsumerProducerCPP20testConsumerProducerEv>
    testUser();
    8000e340:	00000097          	auipc	ra,0x0
    8000e344:	f14080e7          	jalr	-236(ra) # 8000e254 <_Z8testUserv>
    8000e348:	00813083          	ld	ra,8(sp)
    8000e34c:	00013403          	ld	s0,0(sp)
    8000e350:	01010113          	addi	sp,sp,16
    8000e354:	00008067          	ret

000000008000e358 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    8000e358:	fd010113          	addi	sp,sp,-48
    8000e35c:	02113423          	sd	ra,40(sp)
    8000e360:	02813023          	sd	s0,32(sp)
    8000e364:	00913c23          	sd	s1,24(sp)
    8000e368:	01213823          	sd	s2,16(sp)
    8000e36c:	01313423          	sd	s3,8(sp)
    8000e370:	03010413          	addi	s0,sp,48
    8000e374:	00050913          	mv	s2,a0
            int i = 0;
    8000e378:	00000993          	li	s3,0
    8000e37c:	0100006f          	j	8000e38c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    8000e380:	00a00513          	li	a0,10
    8000e384:	00001097          	auipc	ra,0x1
    8000e388:	fe0080e7          	jalr	-32(ra) # 8000f364 <_ZN7Console4putcEc>
            while (!threadEnd) {
    8000e38c:	00002797          	auipc	a5,0x2
    8000e390:	fe87a783          	lw	a5,-24(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e394:	04079a63          	bnez	a5,8000e3e8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    8000e398:	01093783          	ld	a5,16(s2)
    8000e39c:	0087b503          	ld	a0,8(a5)
    8000e3a0:	fffff097          	auipc	ra,0xfffff
    8000e3a4:	240080e7          	jalr	576(ra) # 8000d5e0 <_ZN9BufferCPP3getEv>
                i++;
    8000e3a8:	0019849b          	addiw	s1,s3,1
    8000e3ac:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    8000e3b0:	0ff57513          	andi	a0,a0,255
    8000e3b4:	00001097          	auipc	ra,0x1
    8000e3b8:	fb0080e7          	jalr	-80(ra) # 8000f364 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    8000e3bc:	05000793          	li	a5,80
    8000e3c0:	02f4e4bb          	remw	s1,s1,a5
    8000e3c4:	fc0494e3          	bnez	s1,8000e38c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    8000e3c8:	fb9ff06f          	j	8000e380 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    8000e3cc:	01093783          	ld	a5,16(s2)
    8000e3d0:	0087b503          	ld	a0,8(a5)
    8000e3d4:	fffff097          	auipc	ra,0xfffff
    8000e3d8:	20c080e7          	jalr	524(ra) # 8000d5e0 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    8000e3dc:	0ff57513          	andi	a0,a0,255
    8000e3e0:	00001097          	auipc	ra,0x1
    8000e3e4:	f84080e7          	jalr	-124(ra) # 8000f364 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    8000e3e8:	01093783          	ld	a5,16(s2)
    8000e3ec:	0087b503          	ld	a0,8(a5)
    8000e3f0:	fffff097          	auipc	ra,0xfffff
    8000e3f4:	27c080e7          	jalr	636(ra) # 8000d66c <_ZN9BufferCPP6getCntEv>
    8000e3f8:	fca04ae3          	bgtz	a0,8000e3cc <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    8000e3fc:	01093783          	ld	a5,16(s2)
    8000e400:	0107b503          	ld	a0,16(a5)
    8000e404:	00001097          	auipc	ra,0x1
    8000e408:	d28080e7          	jalr	-728(ra) # 8000f12c <_ZN9Semaphore6signalEv>
        }
    8000e40c:	02813083          	ld	ra,40(sp)
    8000e410:	02013403          	ld	s0,32(sp)
    8000e414:	01813483          	ld	s1,24(sp)
    8000e418:	01013903          	ld	s2,16(sp)
    8000e41c:	00813983          	ld	s3,8(sp)
    8000e420:	03010113          	addi	sp,sp,48
    8000e424:	00008067          	ret

000000008000e428 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    8000e428:	ff010113          	addi	sp,sp,-16
    8000e42c:	00113423          	sd	ra,8(sp)
    8000e430:	00813023          	sd	s0,0(sp)
    8000e434:	01010413          	addi	s0,sp,16
    8000e438:	00002797          	auipc	a5,0x2
    8000e43c:	e6878793          	addi	a5,a5,-408 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e440:	00f53023          	sd	a5,0(a0)
    8000e444:	00001097          	auipc	ra,0x1
    8000e448:	b4c080e7          	jalr	-1204(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e44c:	00813083          	ld	ra,8(sp)
    8000e450:	00013403          	ld	s0,0(sp)
    8000e454:	01010113          	addi	sp,sp,16
    8000e458:	00008067          	ret

000000008000e45c <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    8000e45c:	fe010113          	addi	sp,sp,-32
    8000e460:	00113c23          	sd	ra,24(sp)
    8000e464:	00813823          	sd	s0,16(sp)
    8000e468:	00913423          	sd	s1,8(sp)
    8000e46c:	02010413          	addi	s0,sp,32
    8000e470:	00050493          	mv	s1,a0
    8000e474:	00002797          	auipc	a5,0x2
    8000e478:	e2c78793          	addi	a5,a5,-468 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e47c:	00f53023          	sd	a5,0(a0)
    8000e480:	00001097          	auipc	ra,0x1
    8000e484:	b10080e7          	jalr	-1264(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e488:	00048513          	mv	a0,s1
    8000e48c:	00001097          	auipc	ra,0x1
    8000e490:	b94080e7          	jalr	-1132(ra) # 8000f020 <_ZdlPv>
    8000e494:	01813083          	ld	ra,24(sp)
    8000e498:	01013403          	ld	s0,16(sp)
    8000e49c:	00813483          	ld	s1,8(sp)
    8000e4a0:	02010113          	addi	sp,sp,32
    8000e4a4:	00008067          	ret

000000008000e4a8 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    8000e4a8:	ff010113          	addi	sp,sp,-16
    8000e4ac:	00113423          	sd	ra,8(sp)
    8000e4b0:	00813023          	sd	s0,0(sp)
    8000e4b4:	01010413          	addi	s0,sp,16
    8000e4b8:	00002797          	auipc	a5,0x2
    8000e4bc:	d9878793          	addi	a5,a5,-616 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e4c0:	00f53023          	sd	a5,0(a0)
    8000e4c4:	00001097          	auipc	ra,0x1
    8000e4c8:	acc080e7          	jalr	-1332(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e4cc:	00813083          	ld	ra,8(sp)
    8000e4d0:	00013403          	ld	s0,0(sp)
    8000e4d4:	01010113          	addi	sp,sp,16
    8000e4d8:	00008067          	ret

000000008000e4dc <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    8000e4dc:	fe010113          	addi	sp,sp,-32
    8000e4e0:	00113c23          	sd	ra,24(sp)
    8000e4e4:	00813823          	sd	s0,16(sp)
    8000e4e8:	00913423          	sd	s1,8(sp)
    8000e4ec:	02010413          	addi	s0,sp,32
    8000e4f0:	00050493          	mv	s1,a0
    8000e4f4:	00002797          	auipc	a5,0x2
    8000e4f8:	d5c78793          	addi	a5,a5,-676 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e4fc:	00f53023          	sd	a5,0(a0)
    8000e500:	00001097          	auipc	ra,0x1
    8000e504:	a90080e7          	jalr	-1392(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e508:	00048513          	mv	a0,s1
    8000e50c:	00001097          	auipc	ra,0x1
    8000e510:	b14080e7          	jalr	-1260(ra) # 8000f020 <_ZdlPv>
    8000e514:	01813083          	ld	ra,24(sp)
    8000e518:	01013403          	ld	s0,16(sp)
    8000e51c:	00813483          	ld	s1,8(sp)
    8000e520:	02010113          	addi	sp,sp,32
    8000e524:	00008067          	ret

000000008000e528 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    8000e528:	ff010113          	addi	sp,sp,-16
    8000e52c:	00113423          	sd	ra,8(sp)
    8000e530:	00813023          	sd	s0,0(sp)
    8000e534:	01010413          	addi	s0,sp,16
    8000e538:	00002797          	auipc	a5,0x2
    8000e53c:	d4078793          	addi	a5,a5,-704 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e540:	00f53023          	sd	a5,0(a0)
    8000e544:	00001097          	auipc	ra,0x1
    8000e548:	a4c080e7          	jalr	-1460(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e54c:	00813083          	ld	ra,8(sp)
    8000e550:	00013403          	ld	s0,0(sp)
    8000e554:	01010113          	addi	sp,sp,16
    8000e558:	00008067          	ret

000000008000e55c <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    8000e55c:	fe010113          	addi	sp,sp,-32
    8000e560:	00113c23          	sd	ra,24(sp)
    8000e564:	00813823          	sd	s0,16(sp)
    8000e568:	00913423          	sd	s1,8(sp)
    8000e56c:	02010413          	addi	s0,sp,32
    8000e570:	00050493          	mv	s1,a0
    8000e574:	00002797          	auipc	a5,0x2
    8000e578:	d0478793          	addi	a5,a5,-764 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e57c:	00f53023          	sd	a5,0(a0)
    8000e580:	00001097          	auipc	ra,0x1
    8000e584:	a10080e7          	jalr	-1520(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e588:	00048513          	mv	a0,s1
    8000e58c:	00001097          	auipc	ra,0x1
    8000e590:	a94080e7          	jalr	-1388(ra) # 8000f020 <_ZdlPv>
    8000e594:	01813083          	ld	ra,24(sp)
    8000e598:	01013403          	ld	s0,16(sp)
    8000e59c:	00813483          	ld	s1,8(sp)
    8000e5a0:	02010113          	addi	sp,sp,32
    8000e5a4:	00008067          	ret

000000008000e5a8 <_ZN10ForkThreadD1Ev>:
    8000e5a8:	ff010113          	addi	sp,sp,-16
    8000e5ac:	00113423          	sd	ra,8(sp)
    8000e5b0:	00813023          	sd	s0,0(sp)
    8000e5b4:	01010413          	addi	s0,sp,16
    8000e5b8:	00002797          	auipc	a5,0x2
    8000e5bc:	d1078793          	addi	a5,a5,-752 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e5c0:	00f53023          	sd	a5,0(a0)
    8000e5c4:	00001097          	auipc	ra,0x1
    8000e5c8:	9cc080e7          	jalr	-1588(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e5cc:	00813083          	ld	ra,8(sp)
    8000e5d0:	00013403          	ld	s0,0(sp)
    8000e5d4:	01010113          	addi	sp,sp,16
    8000e5d8:	00008067          	ret

000000008000e5dc <_ZN10ForkThreadD0Ev>:
    8000e5dc:	fe010113          	addi	sp,sp,-32
    8000e5e0:	00113c23          	sd	ra,24(sp)
    8000e5e4:	00813823          	sd	s0,16(sp)
    8000e5e8:	00913423          	sd	s1,8(sp)
    8000e5ec:	02010413          	addi	s0,sp,32
    8000e5f0:	00050493          	mv	s1,a0
    8000e5f4:	00002797          	auipc	a5,0x2
    8000e5f8:	cd478793          	addi	a5,a5,-812 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e5fc:	00f53023          	sd	a5,0(a0)
    8000e600:	00001097          	auipc	ra,0x1
    8000e604:	990080e7          	jalr	-1648(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000e608:	00048513          	mv	a0,s1
    8000e60c:	00001097          	auipc	ra,0x1
    8000e610:	a14080e7          	jalr	-1516(ra) # 8000f020 <_ZdlPv>
    8000e614:	01813083          	ld	ra,24(sp)
    8000e618:	01013403          	ld	s0,16(sp)
    8000e61c:	00813483          	ld	s1,8(sp)
    8000e620:	02010113          	addi	sp,sp,32
    8000e624:	00008067          	ret

000000008000e628 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    8000e628:	fe010113          	addi	sp,sp,-32
    8000e62c:	00113c23          	sd	ra,24(sp)
    8000e630:	00813823          	sd	s0,16(sp)
    8000e634:	00913423          	sd	s1,8(sp)
    8000e638:	02010413          	addi	s0,sp,32
    8000e63c:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    8000e640:	fffff097          	auipc	ra,0xfffff
    8000e644:	cc4080e7          	jalr	-828(ra) # 8000d304 <_Z4getcv>
    8000e648:	0005059b          	sext.w	a1,a0
    8000e64c:	01b00793          	li	a5,27
    8000e650:	00f58c63          	beq	a1,a5,8000e668 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    8000e654:	0104b783          	ld	a5,16(s1)
    8000e658:	0087b503          	ld	a0,8(a5)
    8000e65c:	fffff097          	auipc	ra,0xfffff
    8000e660:	ef4080e7          	jalr	-268(ra) # 8000d550 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    8000e664:	fddff06f          	j	8000e640 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    8000e668:	00100793          	li	a5,1
    8000e66c:	00002717          	auipc	a4,0x2
    8000e670:	d0f72423          	sw	a5,-760(a4) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    8000e674:	0104b783          	ld	a5,16(s1)
    8000e678:	02100593          	li	a1,33
    8000e67c:	0087b503          	ld	a0,8(a5)
    8000e680:	fffff097          	auipc	ra,0xfffff
    8000e684:	ed0080e7          	jalr	-304(ra) # 8000d550 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    8000e688:	0104b783          	ld	a5,16(s1)
    8000e68c:	0107b503          	ld	a0,16(a5)
    8000e690:	00001097          	auipc	ra,0x1
    8000e694:	a9c080e7          	jalr	-1380(ra) # 8000f12c <_ZN9Semaphore6signalEv>
        }
    8000e698:	01813083          	ld	ra,24(sp)
    8000e69c:	01013403          	ld	s0,16(sp)
    8000e6a0:	00813483          	ld	s1,8(sp)
    8000e6a4:	02010113          	addi	sp,sp,32
    8000e6a8:	00008067          	ret

000000008000e6ac <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    8000e6ac:	fe010113          	addi	sp,sp,-32
    8000e6b0:	00113c23          	sd	ra,24(sp)
    8000e6b4:	00813823          	sd	s0,16(sp)
    8000e6b8:	00913423          	sd	s1,8(sp)
    8000e6bc:	01213023          	sd	s2,0(sp)
    8000e6c0:	02010413          	addi	s0,sp,32
    8000e6c4:	00050493          	mv	s1,a0
            int i = 0;
    8000e6c8:	00000913          	li	s2,0
            while (!threadEnd) {
    8000e6cc:	00002797          	auipc	a5,0x2
    8000e6d0:	ca87a783          	lw	a5,-856(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e6d4:	04079263          	bnez	a5,8000e718 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8000e6d8:	0104b783          	ld	a5,16(s1)
    8000e6dc:	0007a583          	lw	a1,0(a5)
    8000e6e0:	0305859b          	addiw	a1,a1,48
    8000e6e4:	0087b503          	ld	a0,8(a5)
    8000e6e8:	fffff097          	auipc	ra,0xfffff
    8000e6ec:	e68080e7          	jalr	-408(ra) # 8000d550 <_ZN9BufferCPP3putEi>
                i++;
    8000e6f0:	0019071b          	addiw	a4,s2,1
    8000e6f4:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    8000e6f8:	0104b783          	ld	a5,16(s1)
    8000e6fc:	0007a783          	lw	a5,0(a5)
    8000e700:	00e787bb          	addw	a5,a5,a4
    8000e704:	00500513          	li	a0,5
    8000e708:	02a7e53b          	remw	a0,a5,a0
    8000e70c:	00001097          	auipc	ra,0x1
    8000e710:	b00080e7          	jalr	-1280(ra) # 8000f20c <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    8000e714:	fb9ff06f          	j	8000e6cc <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    8000e718:	0104b783          	ld	a5,16(s1)
    8000e71c:	0107b503          	ld	a0,16(a5)
    8000e720:	00001097          	auipc	ra,0x1
    8000e724:	a0c080e7          	jalr	-1524(ra) # 8000f12c <_ZN9Semaphore6signalEv>
        }
    8000e728:	01813083          	ld	ra,24(sp)
    8000e72c:	01013403          	ld	s0,16(sp)
    8000e730:	00813483          	ld	s1,8(sp)
    8000e734:	00013903          	ld	s2,0(sp)
    8000e738:	02010113          	addi	sp,sp,32
    8000e73c:	00008067          	ret

000000008000e740 <_ZN10ForkThread3runEv>:
    virtual void run() {
    8000e740:	fc010113          	addi	sp,sp,-64
    8000e744:	02113c23          	sd	ra,56(sp)
    8000e748:	02813823          	sd	s0,48(sp)
    8000e74c:	02913423          	sd	s1,40(sp)
    8000e750:	03213023          	sd	s2,32(sp)
    8000e754:	01313c23          	sd	s3,24(sp)
    8000e758:	01413823          	sd	s4,16(sp)
    8000e75c:	01513423          	sd	s5,8(sp)
    8000e760:	01613023          	sd	s6,0(sp)
    8000e764:	04010413          	addi	s0,sp,64
    8000e768:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    8000e76c:	00002517          	auipc	a0,0x2
    8000e770:	aa450513          	addi	a0,a0,-1372 # 80010210 <userDataStart+0x210>
    8000e774:	00000097          	auipc	ra,0x0
    8000e778:	50c080e7          	jalr	1292(ra) # 8000ec80 <_Z11printStringPKc>
        printInt(id,10);
    8000e77c:	00000613          	li	a2,0
    8000e780:	00a00593          	li	a1,10
    8000e784:	010a2503          	lw	a0,16(s4)
    8000e788:	00000097          	auipc	ra,0x0
    8000e78c:	690080e7          	jalr	1680(ra) # 8000ee18 <_Z8printIntiii>
        printString("\n");
    8000e790:	00002517          	auipc	a0,0x2
    8000e794:	9b850513          	addi	a0,a0,-1608 # 80010148 <userDataStart+0x148>
    8000e798:	00000097          	auipc	ra,0x0
    8000e79c:	4e8080e7          	jalr	1256(ra) # 8000ec80 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    8000e7a0:	02000513          	li	a0,32
    8000e7a4:	00001097          	auipc	ra,0x1
    8000e7a8:	82c080e7          	jalr	-2004(ra) # 8000efd0 <_Znwm>
    8000e7ac:	00050993          	mv	s3,a0
    8000e7b0:	02050463          	beqz	a0,8000e7d8 <_ZN10ForkThread3runEv+0x98>
    8000e7b4:	010a3483          	ld	s1,16(s4)
    8000e7b8:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e7bc:	00001097          	auipc	ra,0x1
    8000e7c0:	9f0080e7          	jalr	-1552(ra) # 8000f1ac <_ZN6ThreadC1Ev>
    8000e7c4:	00002797          	auipc	a5,0x2
    8000e7c8:	b0478793          	addi	a5,a5,-1276 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e7cc:	00f9b023          	sd	a5,0(s3)
    8000e7d0:	0099b823          	sd	s1,16(s3)
    8000e7d4:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    8000e7d8:	010a3503          	ld	a0,16(s4)
    8000e7dc:	00351513          	slli	a0,a0,0x3
    8000e7e0:	fffff097          	auipc	ra,0xfffff
    8000e7e4:	840080e7          	jalr	-1984(ra) # 8000d020 <_Z9mem_allocm>
    8000e7e8:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    8000e7ec:	10050863          	beqz	a0,8000e8fc <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    8000e7f0:	00000913          	li	s2,0
    8000e7f4:	0140006f          	j	8000e808 <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    8000e7f8:	00391793          	slli	a5,s2,0x3
    8000e7fc:	00fa87b3          	add	a5,s5,a5
    8000e800:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    8000e804:	00190913          	addi	s2,s2,1
    8000e808:	010a3783          	ld	a5,16(s4)
    8000e80c:	02f95e63          	bge	s2,a5,8000e848 <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    8000e810:	02000513          	li	a0,32
    8000e814:	00000097          	auipc	ra,0x0
    8000e818:	7bc080e7          	jalr	1980(ra) # 8000efd0 <_Znwm>
    8000e81c:	00050493          	mv	s1,a0
    8000e820:	fc050ce3          	beqz	a0,8000e7f8 <_ZN10ForkThread3runEv+0xb8>
    8000e824:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e828:	00001097          	auipc	ra,0x1
    8000e82c:	984080e7          	jalr	-1660(ra) # 8000f1ac <_ZN6ThreadC1Ev>
    8000e830:	00002797          	auipc	a5,0x2
    8000e834:	a9878793          	addi	a5,a5,-1384 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e838:	00f4b023          	sd	a5,0(s1)
    8000e83c:	0164b823          	sd	s6,16(s1)
    8000e840:	00048c23          	sb	zero,24(s1)
    8000e844:	fb5ff06f          	j	8000e7f8 <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    8000e848:	06098a63          	beqz	s3,8000e8bc <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    8000e84c:	00098513          	mv	a0,s3
    8000e850:	00001097          	auipc	ra,0x1
    8000e854:	a4c080e7          	jalr	-1460(ra) # 8000f29c <_ZN6Thread5startEv>
    8000e858:	00050913          	mv	s2,a0
    8000e85c:	04051863          	bnez	a0,8000e8ac <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    8000e860:	00050493          	mv	s1,a0
    8000e864:	0100006f          	j	8000e874 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    8000e868:	fffff097          	auipc	ra,0xfffff
    8000e86c:	8c8080e7          	jalr	-1848(ra) # 8000d130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    8000e870:	0014849b          	addiw	s1,s1,1
    8000e874:	000017b7          	lui	a5,0x1
    8000e878:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e87c:	0097ce63          	blt	a5,s1,8000e898 <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    8000e880:	00090713          	mv	a4,s2
    8000e884:	000017b7          	lui	a5,0x1
    8000e888:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e88c:	fce7cee3          	blt	a5,a4,8000e868 <_ZN10ForkThread3runEv+0x128>
    8000e890:	0017071b          	addiw	a4,a4,1
    8000e894:	ff1ff06f          	j	8000e884 <_ZN10ForkThread3runEv+0x144>
        return finished;
    8000e898:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    8000e89c:	00079863          	bnez	a5,8000e8ac <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    8000e8a0:	fffff097          	auipc	ra,0xfffff
    8000e8a4:	890080e7          	jalr	-1904(ra) # 8000d130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8000e8a8:	ff1ff06f          	j	8000e898 <_ZN10ForkThread3runEv+0x158>
                delete thread;
    8000e8ac:	0009b783          	ld	a5,0(s3)
    8000e8b0:	0087b783          	ld	a5,8(a5)
    8000e8b4:	00098513          	mv	a0,s3
    8000e8b8:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    8000e8bc:	00000493          	li	s1,0
    8000e8c0:	0080006f          	j	8000e8c8 <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    8000e8c4:	00148493          	addi	s1,s1,1
    8000e8c8:	010a3783          	ld	a5,16(s4)
    8000e8cc:	02f4d263          	bge	s1,a5,8000e8f0 <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    8000e8d0:	00349793          	slli	a5,s1,0x3
    8000e8d4:	00fa87b3          	add	a5,s5,a5
    8000e8d8:	0007b503          	ld	a0,0(a5)
    8000e8dc:	fe0504e3          	beqz	a0,8000e8c4 <_ZN10ForkThread3runEv+0x184>
    8000e8e0:	00053783          	ld	a5,0(a0)
    8000e8e4:	0087b783          	ld	a5,8(a5)
    8000e8e8:	000780e7          	jalr	a5
    8000e8ec:	fd9ff06f          	j	8000e8c4 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    8000e8f0:	000a8513          	mv	a0,s5
    8000e8f4:	ffffe097          	auipc	ra,0xffffe
    8000e8f8:	75c080e7          	jalr	1884(ra) # 8000d050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    8000e8fc:	00002517          	auipc	a0,0x2
    8000e900:	92c50513          	addi	a0,a0,-1748 # 80010228 <userDataStart+0x228>
    8000e904:	00000097          	auipc	ra,0x0
    8000e908:	37c080e7          	jalr	892(ra) # 8000ec80 <_Z11printStringPKc>
        printInt(id,10);
    8000e90c:	00000613          	li	a2,0
    8000e910:	00a00593          	li	a1,10
    8000e914:	010a2503          	lw	a0,16(s4)
    8000e918:	00000097          	auipc	ra,0x0
    8000e91c:	500080e7          	jalr	1280(ra) # 8000ee18 <_Z8printIntiii>
        printString("\n");
    8000e920:	00002517          	auipc	a0,0x2
    8000e924:	82850513          	addi	a0,a0,-2008 # 80010148 <userDataStart+0x148>
    8000e928:	00000097          	auipc	ra,0x0
    8000e92c:	358080e7          	jalr	856(ra) # 8000ec80 <_Z11printStringPKc>
        finished = true;
    8000e930:	00100793          	li	a5,1
    8000e934:	00fa0c23          	sb	a5,24(s4)
    }
    8000e938:	03813083          	ld	ra,56(sp)
    8000e93c:	03013403          	ld	s0,48(sp)
    8000e940:	02813483          	ld	s1,40(sp)
    8000e944:	02013903          	ld	s2,32(sp)
    8000e948:	01813983          	ld	s3,24(sp)
    8000e94c:	01013a03          	ld	s4,16(sp)
    8000e950:	00813a83          	ld	s5,8(sp)
    8000e954:	00013b03          	ld	s6,0(sp)
    8000e958:	04010113          	addi	sp,sp,64
    8000e95c:	00008067          	ret

000000008000e960 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000e960:	fe010113          	addi	sp,sp,-32
    8000e964:	00113c23          	sd	ra,24(sp)
    8000e968:	00813823          	sd	s0,16(sp)
    8000e96c:	00913423          	sd	s1,8(sp)
    8000e970:	01213023          	sd	s2,0(sp)
    8000e974:	02010413          	addi	s0,sp,32
    8000e978:	00050493          	mv	s1,a0
    8000e97c:	00058913          	mv	s2,a1
    8000e980:	0015879b          	addiw	a5,a1,1
    8000e984:	0007851b          	sext.w	a0,a5
    8000e988:	00f4a023          	sw	a5,0(s1)
    8000e98c:	0004a823          	sw	zero,16(s1)
    8000e990:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000e994:	00251513          	slli	a0,a0,0x2
    8000e998:	ffffe097          	auipc	ra,0xffffe
    8000e99c:	688080e7          	jalr	1672(ra) # 8000d020 <_Z9mem_allocm>
    8000e9a0:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000e9a4:	00000593          	li	a1,0
    8000e9a8:	02048513          	addi	a0,s1,32
    8000e9ac:	fffff097          	auipc	ra,0xfffff
    8000e9b0:	870080e7          	jalr	-1936(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    8000e9b4:	00090593          	mv	a1,s2
    8000e9b8:	01848513          	addi	a0,s1,24
    8000e9bc:	fffff097          	auipc	ra,0xfffff
    8000e9c0:	860080e7          	jalr	-1952(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    8000e9c4:	00100593          	li	a1,1
    8000e9c8:	02848513          	addi	a0,s1,40
    8000e9cc:	fffff097          	auipc	ra,0xfffff
    8000e9d0:	850080e7          	jalr	-1968(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    8000e9d4:	00100593          	li	a1,1
    8000e9d8:	03048513          	addi	a0,s1,48
    8000e9dc:	fffff097          	auipc	ra,0xfffff
    8000e9e0:	840080e7          	jalr	-1984(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000e9e4:	01813083          	ld	ra,24(sp)
    8000e9e8:	01013403          	ld	s0,16(sp)
    8000e9ec:	00813483          	ld	s1,8(sp)
    8000e9f0:	00013903          	ld	s2,0(sp)
    8000e9f4:	02010113          	addi	sp,sp,32
    8000e9f8:	00008067          	ret

000000008000e9fc <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000e9fc:	fe010113          	addi	sp,sp,-32
    8000ea00:	00113c23          	sd	ra,24(sp)
    8000ea04:	00813823          	sd	s0,16(sp)
    8000ea08:	00913423          	sd	s1,8(sp)
    8000ea0c:	01213023          	sd	s2,0(sp)
    8000ea10:	02010413          	addi	s0,sp,32
    8000ea14:	00050493          	mv	s1,a0
    8000ea18:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000ea1c:	01853503          	ld	a0,24(a0)
    8000ea20:	fffff097          	auipc	ra,0xfffff
    8000ea24:	860080e7          	jalr	-1952(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    8000ea28:	0304b503          	ld	a0,48(s1)
    8000ea2c:	fffff097          	auipc	ra,0xfffff
    8000ea30:	854080e7          	jalr	-1964(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    8000ea34:	0084b783          	ld	a5,8(s1)
    8000ea38:	0144a703          	lw	a4,20(s1)
    8000ea3c:	00271713          	slli	a4,a4,0x2
    8000ea40:	00e787b3          	add	a5,a5,a4
    8000ea44:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000ea48:	0144a783          	lw	a5,20(s1)
    8000ea4c:	0017879b          	addiw	a5,a5,1
    8000ea50:	0004a703          	lw	a4,0(s1)
    8000ea54:	02e7e7bb          	remw	a5,a5,a4
    8000ea58:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    8000ea5c:	0304b503          	ld	a0,48(s1)
    8000ea60:	fffff097          	auipc	ra,0xfffff
    8000ea64:	84c080e7          	jalr	-1972(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    8000ea68:	0204b503          	ld	a0,32(s1)
    8000ea6c:	fffff097          	auipc	ra,0xfffff
    8000ea70:	840080e7          	jalr	-1984(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

}
    8000ea74:	01813083          	ld	ra,24(sp)
    8000ea78:	01013403          	ld	s0,16(sp)
    8000ea7c:	00813483          	ld	s1,8(sp)
    8000ea80:	00013903          	ld	s2,0(sp)
    8000ea84:	02010113          	addi	sp,sp,32
    8000ea88:	00008067          	ret

000000008000ea8c <_ZN6Buffer3getEv>:

int Buffer::get() {
    8000ea8c:	fe010113          	addi	sp,sp,-32
    8000ea90:	00113c23          	sd	ra,24(sp)
    8000ea94:	00813823          	sd	s0,16(sp)
    8000ea98:	00913423          	sd	s1,8(sp)
    8000ea9c:	01213023          	sd	s2,0(sp)
    8000eaa0:	02010413          	addi	s0,sp,32
    8000eaa4:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8000eaa8:	02053503          	ld	a0,32(a0)
    8000eaac:	ffffe097          	auipc	ra,0xffffe
    8000eab0:	7d4080e7          	jalr	2004(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    8000eab4:	0284b503          	ld	a0,40(s1)
    8000eab8:	ffffe097          	auipc	ra,0xffffe
    8000eabc:	7c8080e7          	jalr	1992(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8000eac0:	0084b703          	ld	a4,8(s1)
    8000eac4:	0104a783          	lw	a5,16(s1)
    8000eac8:	00279693          	slli	a3,a5,0x2
    8000eacc:	00d70733          	add	a4,a4,a3
    8000ead0:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000ead4:	0017879b          	addiw	a5,a5,1
    8000ead8:	0004a703          	lw	a4,0(s1)
    8000eadc:	02e7e7bb          	remw	a5,a5,a4
    8000eae0:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000eae4:	0284b503          	ld	a0,40(s1)
    8000eae8:	ffffe097          	auipc	ra,0xffffe
    8000eaec:	7c4080e7          	jalr	1988(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    8000eaf0:	0184b503          	ld	a0,24(s1)
    8000eaf4:	ffffe097          	auipc	ra,0xffffe
    8000eaf8:	7b8080e7          	jalr	1976(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000eafc:	00090513          	mv	a0,s2
    8000eb00:	01813083          	ld	ra,24(sp)
    8000eb04:	01013403          	ld	s0,16(sp)
    8000eb08:	00813483          	ld	s1,8(sp)
    8000eb0c:	00013903          	ld	s2,0(sp)
    8000eb10:	02010113          	addi	sp,sp,32
    8000eb14:	00008067          	ret

000000008000eb18 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000eb18:	fe010113          	addi	sp,sp,-32
    8000eb1c:	00113c23          	sd	ra,24(sp)
    8000eb20:	00813823          	sd	s0,16(sp)
    8000eb24:	00913423          	sd	s1,8(sp)
    8000eb28:	01213023          	sd	s2,0(sp)
    8000eb2c:	02010413          	addi	s0,sp,32
    8000eb30:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    8000eb34:	02853503          	ld	a0,40(a0)
    8000eb38:	ffffe097          	auipc	ra,0xffffe
    8000eb3c:	748080e7          	jalr	1864(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    8000eb40:	0304b503          	ld	a0,48(s1)
    8000eb44:	ffffe097          	auipc	ra,0xffffe
    8000eb48:	73c080e7          	jalr	1852(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    8000eb4c:	0144a783          	lw	a5,20(s1)
    8000eb50:	0104a903          	lw	s2,16(s1)
    8000eb54:	0327ce63          	blt	a5,s2,8000eb90 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000eb58:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    8000eb5c:	0304b503          	ld	a0,48(s1)
    8000eb60:	ffffe097          	auipc	ra,0xffffe
    8000eb64:	74c080e7          	jalr	1868(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8000eb68:	0284b503          	ld	a0,40(s1)
    8000eb6c:	ffffe097          	auipc	ra,0xffffe
    8000eb70:	740080e7          	jalr	1856(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000eb74:	00090513          	mv	a0,s2
    8000eb78:	01813083          	ld	ra,24(sp)
    8000eb7c:	01013403          	ld	s0,16(sp)
    8000eb80:	00813483          	ld	s1,8(sp)
    8000eb84:	00013903          	ld	s2,0(sp)
    8000eb88:	02010113          	addi	sp,sp,32
    8000eb8c:	00008067          	ret
        ret = cap - head + tail;
    8000eb90:	0004a703          	lw	a4,0(s1)
    8000eb94:	4127093b          	subw	s2,a4,s2
    8000eb98:	00f9093b          	addw	s2,s2,a5
    8000eb9c:	fc1ff06f          	j	8000eb5c <_ZN6Buffer6getCntEv+0x44>

000000008000eba0 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000eba0:	fe010113          	addi	sp,sp,-32
    8000eba4:	00113c23          	sd	ra,24(sp)
    8000eba8:	00813823          	sd	s0,16(sp)
    8000ebac:	00913423          	sd	s1,8(sp)
    8000ebb0:	02010413          	addi	s0,sp,32
    8000ebb4:	00050493          	mv	s1,a0
    putc('\n');
    8000ebb8:	00a00513          	li	a0,10
    8000ebbc:	ffffe097          	auipc	ra,0xffffe
    8000ebc0:	770080e7          	jalr	1904(ra) # 8000d32c <_Z4putcc>
    printString("Buffer deleted!\n");
    8000ebc4:	00001517          	auipc	a0,0x1
    8000ebc8:	43c50513          	addi	a0,a0,1084 # 80010000 <userDataStart>
    8000ebcc:	00000097          	auipc	ra,0x0
    8000ebd0:	0b4080e7          	jalr	180(ra) # 8000ec80 <_Z11printStringPKc>
    while (getCnt() > 0) {
    8000ebd4:	00048513          	mv	a0,s1
    8000ebd8:	00000097          	auipc	ra,0x0
    8000ebdc:	f40080e7          	jalr	-192(ra) # 8000eb18 <_ZN6Buffer6getCntEv>
    8000ebe0:	02a05c63          	blez	a0,8000ec18 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    8000ebe4:	0084b783          	ld	a5,8(s1)
    8000ebe8:	0104a703          	lw	a4,16(s1)
    8000ebec:	00271713          	slli	a4,a4,0x2
    8000ebf0:	00e787b3          	add	a5,a5,a4
        putc(ch);
    8000ebf4:	0007c503          	lbu	a0,0(a5)
    8000ebf8:	ffffe097          	auipc	ra,0xffffe
    8000ebfc:	734080e7          	jalr	1844(ra) # 8000d32c <_Z4putcc>
        head = (head + 1) % cap;
    8000ec00:	0104a783          	lw	a5,16(s1)
    8000ec04:	0017879b          	addiw	a5,a5,1
    8000ec08:	0004a703          	lw	a4,0(s1)
    8000ec0c:	02e7e7bb          	remw	a5,a5,a4
    8000ec10:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    8000ec14:	fc1ff06f          	j	8000ebd4 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000ec18:	02100513          	li	a0,33
    8000ec1c:	ffffe097          	auipc	ra,0xffffe
    8000ec20:	710080e7          	jalr	1808(ra) # 8000d32c <_Z4putcc>
    putc('\n');
    8000ec24:	00a00513          	li	a0,10
    8000ec28:	ffffe097          	auipc	ra,0xffffe
    8000ec2c:	704080e7          	jalr	1796(ra) # 8000d32c <_Z4putcc>
    mem_free(buffer);
    8000ec30:	0084b503          	ld	a0,8(s1)
    8000ec34:	ffffe097          	auipc	ra,0xffffe
    8000ec38:	41c080e7          	jalr	1052(ra) # 8000d050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    8000ec3c:	0204b503          	ld	a0,32(s1)
    8000ec40:	ffffe097          	auipc	ra,0xffffe
    8000ec44:	614080e7          	jalr	1556(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    8000ec48:	0184b503          	ld	a0,24(s1)
    8000ec4c:	ffffe097          	auipc	ra,0xffffe
    8000ec50:	608080e7          	jalr	1544(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    8000ec54:	0304b503          	ld	a0,48(s1)
    8000ec58:	ffffe097          	auipc	ra,0xffffe
    8000ec5c:	5fc080e7          	jalr	1532(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    8000ec60:	0284b503          	ld	a0,40(s1)
    8000ec64:	ffffe097          	auipc	ra,0xffffe
    8000ec68:	5f0080e7          	jalr	1520(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
}
    8000ec6c:	01813083          	ld	ra,24(sp)
    8000ec70:	01013403          	ld	s0,16(sp)
    8000ec74:	00813483          	ld	s1,8(sp)
    8000ec78:	02010113          	addi	sp,sp,32
    8000ec7c:	00008067          	ret

000000008000ec80 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000ec80:	fe010113          	addi	sp,sp,-32
    8000ec84:	00113c23          	sd	ra,24(sp)
    8000ec88:	00813823          	sd	s0,16(sp)
    8000ec8c:	00913423          	sd	s1,8(sp)
    8000ec90:	02010413          	addi	s0,sp,32
    8000ec94:	00050493          	mv	s1,a0
    LOCK();
    8000ec98:	00100613          	li	a2,1
    8000ec9c:	00000593          	li	a1,0
    8000eca0:	00001517          	auipc	a0,0x1
    8000eca4:	6e850513          	addi	a0,a0,1768 # 80010388 <lockPrint>
    8000eca8:	ffffe097          	auipc	ra,0xffffe
    8000ecac:	358080e7          	jalr	856(ra) # 8000d000 <copy_and_swap>
    8000ecb0:	fe0514e3          	bnez	a0,8000ec98 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000ecb4:	0004c503          	lbu	a0,0(s1)
    8000ecb8:	00050a63          	beqz	a0,8000eccc <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000ecbc:	ffffe097          	auipc	ra,0xffffe
    8000ecc0:	670080e7          	jalr	1648(ra) # 8000d32c <_Z4putcc>
        string++;
    8000ecc4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000ecc8:	fedff06f          	j	8000ecb4 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000eccc:	00000613          	li	a2,0
    8000ecd0:	00100593          	li	a1,1
    8000ecd4:	00001517          	auipc	a0,0x1
    8000ecd8:	6b450513          	addi	a0,a0,1716 # 80010388 <lockPrint>
    8000ecdc:	ffffe097          	auipc	ra,0xffffe
    8000ece0:	324080e7          	jalr	804(ra) # 8000d000 <copy_and_swap>
    8000ece4:	fe0514e3          	bnez	a0,8000eccc <_Z11printStringPKc+0x4c>
}
    8000ece8:	01813083          	ld	ra,24(sp)
    8000ecec:	01013403          	ld	s0,16(sp)
    8000ecf0:	00813483          	ld	s1,8(sp)
    8000ecf4:	02010113          	addi	sp,sp,32
    8000ecf8:	00008067          	ret

000000008000ecfc <_Z9getStringPci>:

char* getString(char *buf, int max) {
    8000ecfc:	fd010113          	addi	sp,sp,-48
    8000ed00:	02113423          	sd	ra,40(sp)
    8000ed04:	02813023          	sd	s0,32(sp)
    8000ed08:	00913c23          	sd	s1,24(sp)
    8000ed0c:	01213823          	sd	s2,16(sp)
    8000ed10:	01313423          	sd	s3,8(sp)
    8000ed14:	01413023          	sd	s4,0(sp)
    8000ed18:	03010413          	addi	s0,sp,48
    8000ed1c:	00050993          	mv	s3,a0
    8000ed20:	00058a13          	mv	s4,a1
    LOCK();
    8000ed24:	00100613          	li	a2,1
    8000ed28:	00000593          	li	a1,0
    8000ed2c:	00001517          	auipc	a0,0x1
    8000ed30:	65c50513          	addi	a0,a0,1628 # 80010388 <lockPrint>
    8000ed34:	ffffe097          	auipc	ra,0xffffe
    8000ed38:	2cc080e7          	jalr	716(ra) # 8000d000 <copy_and_swap>
    8000ed3c:	fe0514e3          	bnez	a0,8000ed24 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000ed40:	00000913          	li	s2,0
    8000ed44:	00090493          	mv	s1,s2
    8000ed48:	0019091b          	addiw	s2,s2,1
    8000ed4c:	03495a63          	bge	s2,s4,8000ed80 <_Z9getStringPci+0x84>
        cc = getc();
    8000ed50:	ffffe097          	auipc	ra,0xffffe
    8000ed54:	5b4080e7          	jalr	1460(ra) # 8000d304 <_Z4getcv>
        if(cc < 1)
    8000ed58:	02050463          	beqz	a0,8000ed80 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000ed5c:	009984b3          	add	s1,s3,s1
    8000ed60:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000ed64:	00a00793          	li	a5,10
    8000ed68:	00f50a63          	beq	a0,a5,8000ed7c <_Z9getStringPci+0x80>
    8000ed6c:	00d00793          	li	a5,13
    8000ed70:	fcf51ae3          	bne	a0,a5,8000ed44 <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000ed74:	00090493          	mv	s1,s2
    8000ed78:	0080006f          	j	8000ed80 <_Z9getStringPci+0x84>
    8000ed7c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    8000ed80:	009984b3          	add	s1,s3,s1
    8000ed84:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000ed88:	00000613          	li	a2,0
    8000ed8c:	00100593          	li	a1,1
    8000ed90:	00001517          	auipc	a0,0x1
    8000ed94:	5f850513          	addi	a0,a0,1528 # 80010388 <lockPrint>
    8000ed98:	ffffe097          	auipc	ra,0xffffe
    8000ed9c:	268080e7          	jalr	616(ra) # 8000d000 <copy_and_swap>
    8000eda0:	fe0514e3          	bnez	a0,8000ed88 <_Z9getStringPci+0x8c>
    return buf;
}
    8000eda4:	00098513          	mv	a0,s3
    8000eda8:	02813083          	ld	ra,40(sp)
    8000edac:	02013403          	ld	s0,32(sp)
    8000edb0:	01813483          	ld	s1,24(sp)
    8000edb4:	01013903          	ld	s2,16(sp)
    8000edb8:	00813983          	ld	s3,8(sp)
    8000edbc:	00013a03          	ld	s4,0(sp)
    8000edc0:	03010113          	addi	sp,sp,48
    8000edc4:	00008067          	ret

000000008000edc8 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000edc8:	ff010113          	addi	sp,sp,-16
    8000edcc:	00813423          	sd	s0,8(sp)
    8000edd0:	01010413          	addi	s0,sp,16
    8000edd4:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000edd8:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000eddc:	0006c603          	lbu	a2,0(a3)
    8000ede0:	fd06071b          	addiw	a4,a2,-48
    8000ede4:	0ff77713          	andi	a4,a4,255
    8000ede8:	00900793          	li	a5,9
    8000edec:	02e7e063          	bltu	a5,a4,8000ee0c <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000edf0:	0025179b          	slliw	a5,a0,0x2
    8000edf4:	00a787bb          	addw	a5,a5,a0
    8000edf8:	0017979b          	slliw	a5,a5,0x1
    8000edfc:	00168693          	addi	a3,a3,1
    8000ee00:	00c787bb          	addw	a5,a5,a2
    8000ee04:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000ee08:	fd5ff06f          	j	8000eddc <_Z11stringToIntPKc+0x14>
    return n;
}
    8000ee0c:	00813403          	ld	s0,8(sp)
    8000ee10:	01010113          	addi	sp,sp,16
    8000ee14:	00008067          	ret

000000008000ee18 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000ee18:	fc010113          	addi	sp,sp,-64
    8000ee1c:	02113c23          	sd	ra,56(sp)
    8000ee20:	02813823          	sd	s0,48(sp)
    8000ee24:	02913423          	sd	s1,40(sp)
    8000ee28:	03213023          	sd	s2,32(sp)
    8000ee2c:	01313c23          	sd	s3,24(sp)
    8000ee30:	04010413          	addi	s0,sp,64
    8000ee34:	00050493          	mv	s1,a0
    8000ee38:	00058913          	mv	s2,a1
    8000ee3c:	00060993          	mv	s3,a2
    LOCK();
    8000ee40:	00100613          	li	a2,1
    8000ee44:	00000593          	li	a1,0
    8000ee48:	00001517          	auipc	a0,0x1
    8000ee4c:	54050513          	addi	a0,a0,1344 # 80010388 <lockPrint>
    8000ee50:	ffffe097          	auipc	ra,0xffffe
    8000ee54:	1b0080e7          	jalr	432(ra) # 8000d000 <copy_and_swap>
    8000ee58:	fe0514e3          	bnez	a0,8000ee40 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000ee5c:	00098463          	beqz	s3,8000ee64 <_Z8printIntiii+0x4c>
    8000ee60:	0804c463          	bltz	s1,8000eee8 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000ee64:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000ee68:	00000593          	li	a1,0
    }

    i = 0;
    8000ee6c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000ee70:	0009079b          	sext.w	a5,s2
    8000ee74:	0325773b          	remuw	a4,a0,s2
    8000ee78:	00048613          	mv	a2,s1
    8000ee7c:	0014849b          	addiw	s1,s1,1
    8000ee80:	02071693          	slli	a3,a4,0x20
    8000ee84:	0206d693          	srli	a3,a3,0x20
    8000ee88:	00001717          	auipc	a4,0x1
    8000ee8c:	45870713          	addi	a4,a4,1112 # 800102e0 <digits>
    8000ee90:	00d70733          	add	a4,a4,a3
    8000ee94:	00074683          	lbu	a3,0(a4)
    8000ee98:	fd040713          	addi	a4,s0,-48
    8000ee9c:	00c70733          	add	a4,a4,a2
    8000eea0:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    8000eea4:	0005071b          	sext.w	a4,a0
    8000eea8:	0325553b          	divuw	a0,a0,s2
    8000eeac:	fcf772e3          	bgeu	a4,a5,8000ee70 <_Z8printIntiii+0x58>
    if(neg)
    8000eeb0:	00058c63          	beqz	a1,8000eec8 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    8000eeb4:	fd040793          	addi	a5,s0,-48
    8000eeb8:	009784b3          	add	s1,a5,s1
    8000eebc:	02d00793          	li	a5,45
    8000eec0:	fef48823          	sb	a5,-16(s1)
    8000eec4:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000eec8:	fff4849b          	addiw	s1,s1,-1
    8000eecc:	0204c463          	bltz	s1,8000eef4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    8000eed0:	fd040793          	addi	a5,s0,-48
    8000eed4:	009787b3          	add	a5,a5,s1
    8000eed8:	ff07c503          	lbu	a0,-16(a5)
    8000eedc:	ffffe097          	auipc	ra,0xffffe
    8000eee0:	450080e7          	jalr	1104(ra) # 8000d32c <_Z4putcc>
    8000eee4:	fe5ff06f          	j	8000eec8 <_Z8printIntiii+0xb0>
        x = -xx;
    8000eee8:	4090053b          	negw	a0,s1
        neg = 1;
    8000eeec:	00100593          	li	a1,1
        x = -xx;
    8000eef0:	f7dff06f          	j	8000ee6c <_Z8printIntiii+0x54>

    UNLOCK();
    8000eef4:	00000613          	li	a2,0
    8000eef8:	00100593          	li	a1,1
    8000eefc:	00001517          	auipc	a0,0x1
    8000ef00:	48c50513          	addi	a0,a0,1164 # 80010388 <lockPrint>
    8000ef04:	ffffe097          	auipc	ra,0xffffe
    8000ef08:	0fc080e7          	jalr	252(ra) # 8000d000 <copy_and_swap>
    8000ef0c:	fe0514e3          	bnez	a0,8000eef4 <_Z8printIntiii+0xdc>
    8000ef10:	03813083          	ld	ra,56(sp)
    8000ef14:	03013403          	ld	s0,48(sp)
    8000ef18:	02813483          	ld	s1,40(sp)
    8000ef1c:	02013903          	ld	s2,32(sp)
    8000ef20:	01813983          	ld	s3,24(sp)
    8000ef24:	04010113          	addi	sp,sp,64
    8000ef28:	00008067          	ret

000000008000ef2c <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    8000ef2c:	ff010113          	addi	sp,sp,-16
    8000ef30:	00113423          	sd	ra,8(sp)
    8000ef34:	00813023          	sd	s0,0(sp)
    8000ef38:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    8000ef3c:	00053783          	ld	a5,0(a0)
    8000ef40:	0107b783          	ld	a5,16(a5)
    8000ef44:	000780e7          	jalr	a5
}
    8000ef48:	00813083          	ld	ra,8(sp)
    8000ef4c:	00013403          	ld	s0,0(sp)
    8000ef50:	01010113          	addi	sp,sp,16
    8000ef54:	00008067          	ret

000000008000ef58 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    8000ef58:	ff010113          	addi	sp,sp,-16
    8000ef5c:	00113423          	sd	ra,8(sp)
    8000ef60:	00813023          	sd	s0,0(sp)
    8000ef64:	01010413          	addi	s0,sp,16
    8000ef68:	00001797          	auipc	a5,0x1
    8000ef6c:	3d078793          	addi	a5,a5,976 # 80010338 <_ZTV9Semaphore+0x10>
    8000ef70:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    8000ef74:	00853503          	ld	a0,8(a0)
    8000ef78:	ffffe097          	auipc	ra,0xffffe
    8000ef7c:	2dc080e7          	jalr	732(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
};
    8000ef80:	00813083          	ld	ra,8(sp)
    8000ef84:	00013403          	ld	s0,0(sp)
    8000ef88:	01010113          	addi	sp,sp,16
    8000ef8c:	00008067          	ret

000000008000ef90 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    8000ef90:	00001797          	auipc	a5,0x1
    8000ef94:	3c878793          	addi	a5,a5,968 # 80010358 <_ZTV6Thread+0x10>
    8000ef98:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000ef9c:	00853503          	ld	a0,8(a0)
    8000efa0:	02050663          	beqz	a0,8000efcc <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    8000efa4:	ff010113          	addi	sp,sp,-16
    8000efa8:	00113423          	sd	ra,8(sp)
    8000efac:	00813023          	sd	s0,0(sp)
    8000efb0:	01010413          	addi	s0,sp,16
    delete myHandle;
    8000efb4:	ffffe097          	auipc	ra,0xffffe
    8000efb8:	410080e7          	jalr	1040(ra) # 8000d3c4 <_ZN7_threaddlEPv>
}
    8000efbc:	00813083          	ld	ra,8(sp)
    8000efc0:	00013403          	ld	s0,0(sp)
    8000efc4:	01010113          	addi	sp,sp,16
    8000efc8:	00008067          	ret
    8000efcc:	00008067          	ret

000000008000efd0 <_Znwm>:
void* operator new(size_t sz){
    8000efd0:	ff010113          	addi	sp,sp,-16
    8000efd4:	00113423          	sd	ra,8(sp)
    8000efd8:	00813023          	sd	s0,0(sp)
    8000efdc:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000efe0:	ffffe097          	auipc	ra,0xffffe
    8000efe4:	040080e7          	jalr	64(ra) # 8000d020 <_Z9mem_allocm>
}
    8000efe8:	00813083          	ld	ra,8(sp)
    8000efec:	00013403          	ld	s0,0(sp)
    8000eff0:	01010113          	addi	sp,sp,16
    8000eff4:	00008067          	ret

000000008000eff8 <_Znam>:
void* operator new[](size_t sz){
    8000eff8:	ff010113          	addi	sp,sp,-16
    8000effc:	00113423          	sd	ra,8(sp)
    8000f000:	00813023          	sd	s0,0(sp)
    8000f004:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000f008:	ffffe097          	auipc	ra,0xffffe
    8000f00c:	018080e7          	jalr	24(ra) # 8000d020 <_Z9mem_allocm>
}
    8000f010:	00813083          	ld	ra,8(sp)
    8000f014:	00013403          	ld	s0,0(sp)
    8000f018:	01010113          	addi	sp,sp,16
    8000f01c:	00008067          	ret

000000008000f020 <_ZdlPv>:
void operator delete(void *ptr){
    8000f020:	ff010113          	addi	sp,sp,-16
    8000f024:	00113423          	sd	ra,8(sp)
    8000f028:	00813023          	sd	s0,0(sp)
    8000f02c:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    8000f030:	ffffe097          	auipc	ra,0xffffe
    8000f034:	020080e7          	jalr	32(ra) # 8000d050 <_Z8mem_freePv>
}
    8000f038:	00813083          	ld	ra,8(sp)
    8000f03c:	00013403          	ld	s0,0(sp)
    8000f040:	01010113          	addi	sp,sp,16
    8000f044:	00008067          	ret

000000008000f048 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    8000f048:	fe010113          	addi	sp,sp,-32
    8000f04c:	00113c23          	sd	ra,24(sp)
    8000f050:	00813823          	sd	s0,16(sp)
    8000f054:	00913423          	sd	s1,8(sp)
    8000f058:	02010413          	addi	s0,sp,32
    8000f05c:	00050493          	mv	s1,a0
};
    8000f060:	00000097          	auipc	ra,0x0
    8000f064:	ef8080e7          	jalr	-264(ra) # 8000ef58 <_ZN9SemaphoreD1Ev>
    8000f068:	00048513          	mv	a0,s1
    8000f06c:	00000097          	auipc	ra,0x0
    8000f070:	fb4080e7          	jalr	-76(ra) # 8000f020 <_ZdlPv>
    8000f074:	01813083          	ld	ra,24(sp)
    8000f078:	01013403          	ld	s0,16(sp)
    8000f07c:	00813483          	ld	s1,8(sp)
    8000f080:	02010113          	addi	sp,sp,32
    8000f084:	00008067          	ret

000000008000f088 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    8000f088:	fe010113          	addi	sp,sp,-32
    8000f08c:	00113c23          	sd	ra,24(sp)
    8000f090:	00813823          	sd	s0,16(sp)
    8000f094:	00913423          	sd	s1,8(sp)
    8000f098:	02010413          	addi	s0,sp,32
    8000f09c:	00050493          	mv	s1,a0
}
    8000f0a0:	00000097          	auipc	ra,0x0
    8000f0a4:	ef0080e7          	jalr	-272(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000f0a8:	00048513          	mv	a0,s1
    8000f0ac:	00000097          	auipc	ra,0x0
    8000f0b0:	f74080e7          	jalr	-140(ra) # 8000f020 <_ZdlPv>
    8000f0b4:	01813083          	ld	ra,24(sp)
    8000f0b8:	01013403          	ld	s0,16(sp)
    8000f0bc:	00813483          	ld	s1,8(sp)
    8000f0c0:	02010113          	addi	sp,sp,32
    8000f0c4:	00008067          	ret

000000008000f0c8 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000f0c8:	ff010113          	addi	sp,sp,-16
    8000f0cc:	00113423          	sd	ra,8(sp)
    8000f0d0:	00813023          	sd	s0,0(sp)
    8000f0d4:	01010413          	addi	s0,sp,16
    8000f0d8:	00001797          	auipc	a5,0x1
    8000f0dc:	26078793          	addi	a5,a5,608 # 80010338 <_ZTV9Semaphore+0x10>
    8000f0e0:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    8000f0e4:	00850513          	addi	a0,a0,8
    8000f0e8:	ffffe097          	auipc	ra,0xffffe
    8000f0ec:	134080e7          	jalr	308(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000f0f0:	00813083          	ld	ra,8(sp)
    8000f0f4:	00013403          	ld	s0,0(sp)
    8000f0f8:	01010113          	addi	sp,sp,16
    8000f0fc:	00008067          	ret

000000008000f100 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    8000f100:	ff010113          	addi	sp,sp,-16
    8000f104:	00113423          	sd	ra,8(sp)
    8000f108:	00813023          	sd	s0,0(sp)
    8000f10c:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    8000f110:	00853503          	ld	a0,8(a0)
    8000f114:	ffffe097          	auipc	ra,0xffffe
    8000f118:	16c080e7          	jalr	364(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
}
    8000f11c:	00813083          	ld	ra,8(sp)
    8000f120:	00013403          	ld	s0,0(sp)
    8000f124:	01010113          	addi	sp,sp,16
    8000f128:	00008067          	ret

000000008000f12c <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    8000f12c:	ff010113          	addi	sp,sp,-16
    8000f130:	00113423          	sd	ra,8(sp)
    8000f134:	00813023          	sd	s0,0(sp)
    8000f138:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    8000f13c:	00853503          	ld	a0,8(a0)
    8000f140:	ffffe097          	auipc	ra,0xffffe
    8000f144:	16c080e7          	jalr	364(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
}
    8000f148:	00813083          	ld	ra,8(sp)
    8000f14c:	00013403          	ld	s0,0(sp)
    8000f150:	01010113          	addi	sp,sp,16
    8000f154:	00008067          	ret

000000008000f158 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    8000f158:	fe010113          	addi	sp,sp,-32
    8000f15c:	00113c23          	sd	ra,24(sp)
    8000f160:	00813823          	sd	s0,16(sp)
    8000f164:	00913423          	sd	s1,8(sp)
    8000f168:	02010413          	addi	s0,sp,32
    8000f16c:	00050493          	mv	s1,a0
    8000f170:	00001797          	auipc	a5,0x1
    8000f174:	1e878793          	addi	a5,a5,488 # 80010358 <_ZTV6Thread+0x10>
    8000f178:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    8000f17c:	00850513          	addi	a0,a0,8
    8000f180:	ffffe097          	auipc	ra,0xffffe
    8000f184:	fd0080e7          	jalr	-48(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f188:	fff00793          	li	a5,-1
    8000f18c:	00f50c63          	beq	a0,a5,8000f1a4 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    8000f190:	01813083          	ld	ra,24(sp)
    8000f194:	01013403          	ld	s0,16(sp)
    8000f198:	00813483          	ld	s1,8(sp)
    8000f19c:	02010113          	addi	sp,sp,32
    8000f1a0:	00008067          	ret
        myHandle = nullptr;
    8000f1a4:	0004b423          	sd	zero,8(s1)
}
    8000f1a8:	fe9ff06f          	j	8000f190 <_ZN6ThreadC1EPFvPvES0_+0x38>

000000008000f1ac <_ZN6ThreadC1Ev>:
Thread::Thread() {
    8000f1ac:	fe010113          	addi	sp,sp,-32
    8000f1b0:	00113c23          	sd	ra,24(sp)
    8000f1b4:	00813823          	sd	s0,16(sp)
    8000f1b8:	00913423          	sd	s1,8(sp)
    8000f1bc:	02010413          	addi	s0,sp,32
    8000f1c0:	00050493          	mv	s1,a0
    8000f1c4:	00001797          	auipc	a5,0x1
    8000f1c8:	19478793          	addi	a5,a5,404 # 80010358 <_ZTV6Thread+0x10>
    8000f1cc:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    8000f1d0:	00050613          	mv	a2,a0
    8000f1d4:	00000597          	auipc	a1,0x0
    8000f1d8:	d5858593          	addi	a1,a1,-680 # 8000ef2c <_ZN6Thread7wrapperEPv>
    8000f1dc:	00850513          	addi	a0,a0,8
    8000f1e0:	ffffe097          	auipc	ra,0xffffe
    8000f1e4:	f70080e7          	jalr	-144(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f1e8:	fff00793          	li	a5,-1
    8000f1ec:	00f50c63          	beq	a0,a5,8000f204 <_ZN6ThreadC1Ev+0x58>
}
    8000f1f0:	01813083          	ld	ra,24(sp)
    8000f1f4:	01013403          	ld	s0,16(sp)
    8000f1f8:	00813483          	ld	s1,8(sp)
    8000f1fc:	02010113          	addi	sp,sp,32
    8000f200:	00008067          	ret
        myHandle = nullptr;
    8000f204:	0004b423          	sd	zero,8(s1)
}
    8000f208:	fe9ff06f          	j	8000f1f0 <_ZN6ThreadC1Ev+0x44>

000000008000f20c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    8000f20c:	ff010113          	addi	sp,sp,-16
    8000f210:	00113423          	sd	ra,8(sp)
    8000f214:	00813023          	sd	s0,0(sp)
    8000f218:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    8000f21c:	ffffe097          	auipc	ra,0xffffe
    8000f220:	0bc080e7          	jalr	188(ra) # 8000d2d8 <_Z10time_sleepm>
}
    8000f224:	00813083          	ld	ra,8(sp)
    8000f228:	00013403          	ld	s0,0(sp)
    8000f22c:	01010113          	addi	sp,sp,16
    8000f230:	00008067          	ret

000000008000f234 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    8000f234:	fe010113          	addi	sp,sp,-32
    8000f238:	00113c23          	sd	ra,24(sp)
    8000f23c:	00813823          	sd	s0,16(sp)
    8000f240:	00913423          	sd	s1,8(sp)
    8000f244:	01213023          	sd	s2,0(sp)
    8000f248:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    8000f24c:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    8000f250:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    8000f254:	0004b783          	ld	a5,0(s1)
    8000f258:	0187b783          	ld	a5,24(a5)
    8000f25c:	00048513          	mv	a0,s1
    8000f260:	000780e7          	jalr	a5
        pt->sleep(time);
    8000f264:	00090513          	mv	a0,s2
    8000f268:	00000097          	auipc	ra,0x0
    8000f26c:	fa4080e7          	jalr	-92(ra) # 8000f20c <_ZN6Thread5sleepEm>
    while(true){
    8000f270:	fe5ff06f          	j	8000f254 <_ZN14PeriodicThread7wrapperEPv+0x20>

000000008000f274 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000f274:	ff010113          	addi	sp,sp,-16
    8000f278:	00113423          	sd	ra,8(sp)
    8000f27c:	00813023          	sd	s0,0(sp)
    8000f280:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000f284:	ffffe097          	auipc	ra,0xffffe
    8000f288:	eac080e7          	jalr	-340(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000f28c:	00813083          	ld	ra,8(sp)
    8000f290:	00013403          	ld	s0,0(sp)
    8000f294:	01010113          	addi	sp,sp,16
    8000f298:	00008067          	ret

000000008000f29c <_ZN6Thread5startEv>:
int Thread::start() {
    8000f29c:	ff010113          	addi	sp,sp,-16
    8000f2a0:	00113423          	sd	ra,8(sp)
    8000f2a4:	00813023          	sd	s0,0(sp)
    8000f2a8:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    8000f2ac:	00853503          	ld	a0,8(a0)
    8000f2b0:	ffffe097          	auipc	ra,0xffffe
    8000f2b4:	f34080e7          	jalr	-204(ra) # 8000d1e4 <_Z12thread_startP7_thread>
}
    8000f2b8:	00813083          	ld	ra,8(sp)
    8000f2bc:	00013403          	ld	s0,0(sp)
    8000f2c0:	01010113          	addi	sp,sp,16
    8000f2c4:	00008067          	ret

000000008000f2c8 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f2c8:	fe010113          	addi	sp,sp,-32
    8000f2cc:	00113c23          	sd	ra,24(sp)
    8000f2d0:	00813823          	sd	s0,16(sp)
    8000f2d4:	00913423          	sd	s1,8(sp)
    8000f2d8:	01213023          	sd	s2,0(sp)
    8000f2dc:	02010413          	addi	s0,sp,32
    8000f2e0:	00050493          	mv	s1,a0
    8000f2e4:	00058913          	mv	s2,a1
    8000f2e8:	01000513          	li	a0,16
    8000f2ec:	00000097          	auipc	ra,0x0
    8000f2f0:	ce4080e7          	jalr	-796(ra) # 8000efd0 <_Znwm>
    8000f2f4:	00050613          	mv	a2,a0
    8000f2f8:	00050663          	beqz	a0,8000f304 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    8000f2fc:	00953023          	sd	s1,0(a0)
    8000f300:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f304:	00000597          	auipc	a1,0x0
    8000f308:	f3058593          	addi	a1,a1,-208 # 8000f234 <_ZN14PeriodicThread7wrapperEPv>
    8000f30c:	00048513          	mv	a0,s1
    8000f310:	00000097          	auipc	ra,0x0
    8000f314:	e48080e7          	jalr	-440(ra) # 8000f158 <_ZN6ThreadC1EPFvPvES0_>
    8000f318:	00001797          	auipc	a5,0x1
    8000f31c:	ff078793          	addi	a5,a5,-16 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f320:	00f4b023          	sd	a5,0(s1)
    8000f324:	01813083          	ld	ra,24(sp)
    8000f328:	01013403          	ld	s0,16(sp)
    8000f32c:	00813483          	ld	s1,8(sp)
    8000f330:	00013903          	ld	s2,0(sp)
    8000f334:	02010113          	addi	sp,sp,32
    8000f338:	00008067          	ret

000000008000f33c <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    8000f33c:	ff010113          	addi	sp,sp,-16
    8000f340:	00113423          	sd	ra,8(sp)
    8000f344:	00813023          	sd	s0,0(sp)
    8000f348:	01010413          	addi	s0,sp,16
    return ::getc();
    8000f34c:	ffffe097          	auipc	ra,0xffffe
    8000f350:	fb8080e7          	jalr	-72(ra) # 8000d304 <_Z4getcv>
}
    8000f354:	00813083          	ld	ra,8(sp)
    8000f358:	00013403          	ld	s0,0(sp)
    8000f35c:	01010113          	addi	sp,sp,16
    8000f360:	00008067          	ret

000000008000f364 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    8000f364:	ff010113          	addi	sp,sp,-16
    8000f368:	00113423          	sd	ra,8(sp)
    8000f36c:	00813023          	sd	s0,0(sp)
    8000f370:	01010413          	addi	s0,sp,16
    ::putc(c);
    8000f374:	ffffe097          	auipc	ra,0xffffe
    8000f378:	fb8080e7          	jalr	-72(ra) # 8000d32c <_Z4putcc>
}
    8000f37c:	00813083          	ld	ra,8(sp)
    8000f380:	00013403          	ld	s0,0(sp)
    8000f384:	01010113          	addi	sp,sp,16
    8000f388:	00008067          	ret

000000008000f38c <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    8000f38c:	ff010113          	addi	sp,sp,-16
    8000f390:	00813423          	sd	s0,8(sp)
    8000f394:	01010413          	addi	s0,sp,16
    8000f398:	00813403          	ld	s0,8(sp)
    8000f39c:	01010113          	addi	sp,sp,16
    8000f3a0:	00008067          	ret

000000008000f3a4 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    8000f3a4:	ff010113          	addi	sp,sp,-16
    8000f3a8:	00813423          	sd	s0,8(sp)
    8000f3ac:	01010413          	addi	s0,sp,16
    8000f3b0:	00813403          	ld	s0,8(sp)
    8000f3b4:	01010113          	addi	sp,sp,16
    8000f3b8:	00008067          	ret

000000008000f3bc <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    8000f3bc:	ff010113          	addi	sp,sp,-16
    8000f3c0:	00113423          	sd	ra,8(sp)
    8000f3c4:	00813023          	sd	s0,0(sp)
    8000f3c8:	01010413          	addi	s0,sp,16
    8000f3cc:	00001797          	auipc	a5,0x1
    8000f3d0:	f3c78793          	addi	a5,a5,-196 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f3d4:	00f53023          	sd	a5,0(a0)
    8000f3d8:	00000097          	auipc	ra,0x0
    8000f3dc:	bb8080e7          	jalr	-1096(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000f3e0:	00813083          	ld	ra,8(sp)
    8000f3e4:	00013403          	ld	s0,0(sp)
    8000f3e8:	01010113          	addi	sp,sp,16
    8000f3ec:	00008067          	ret

000000008000f3f0 <_ZN14PeriodicThreadD0Ev>:
    8000f3f0:	fe010113          	addi	sp,sp,-32
    8000f3f4:	00113c23          	sd	ra,24(sp)
    8000f3f8:	00813823          	sd	s0,16(sp)
    8000f3fc:	00913423          	sd	s1,8(sp)
    8000f400:	02010413          	addi	s0,sp,32
    8000f404:	00050493          	mv	s1,a0
    8000f408:	00001797          	auipc	a5,0x1
    8000f40c:	f0078793          	addi	a5,a5,-256 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f410:	00f53023          	sd	a5,0(a0)
    8000f414:	00000097          	auipc	ra,0x0
    8000f418:	b7c080e7          	jalr	-1156(ra) # 8000ef90 <_ZN6ThreadD1Ev>
    8000f41c:	00048513          	mv	a0,s1
    8000f420:	00000097          	auipc	ra,0x0
    8000f424:	c00080e7          	jalr	-1024(ra) # 8000f020 <_ZdlPv>
    8000f428:	01813083          	ld	ra,24(sp)
    8000f42c:	01013403          	ld	s0,16(sp)
    8000f430:	00813483          	ld	s1,8(sp)
    8000f434:	02010113          	addi	sp,sp,32
    8000f438:	00008067          	ret

000000008000f43c <_Z11bodyWrapperPFvPvES_>:
#include "../../h/user/user_wrappers.hpp"
#include "../../h/user/syscall_c.h"
#include "tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    8000f43c:	ff010113          	addi	sp,sp,-16
    8000f440:	00113423          	sd	ra,8(sp)
    8000f444:	00813023          	sd	s0,0(sp)
    8000f448:	01010413          	addi	s0,sp,16
    8000f44c:	00050793          	mv	a5,a0
    body(args);
    8000f450:	00058513          	mv	a0,a1
    8000f454:	000780e7          	jalr	a5
    thread_exit();
    8000f458:	ffffe097          	auipc	ra,0xffffe
    8000f45c:	cb0080e7          	jalr	-848(ra) # 8000d108 <_Z11thread_exitv>
}
    8000f460:	00813083          	ld	ra,8(sp)
    8000f464:	00013403          	ld	s0,0(sp)
    8000f468:	01010113          	addi	sp,sp,16
    8000f46c:	00008067          	ret

000000008000f470 <_Z15userMainWrapperPv>:

void userMainWrapper(void* args) {
    8000f470:	ff010113          	addi	sp,sp,-16
    8000f474:	00113423          	sd	ra,8(sp)
    8000f478:	00813023          	sd	s0,0(sp)
    8000f47c:	01010413          	addi	s0,sp,16
    userMain();
    8000f480:	fffff097          	auipc	ra,0xfffff
    8000f484:	e94080e7          	jalr	-364(ra) # 8000e314 <_Z8userMainv>
    8000f488:	00813083          	ld	ra,8(sp)
    8000f48c:	00013403          	ld	s0,0(sp)
    8000f490:	01010113          	addi	sp,sp,16
    8000f494:	00008067          	ret
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
    80010250:	e4a8 8000 0000 0000 e4dc 8000 0000 0000     ................
    80010260:	e628 8000 0000 0000                         (.......

0000000080010268 <_ZTVN19ConsumerProducerCPP8ProducerE>:
	...
    80010278:	e528 8000 0000 0000 e55c 8000 0000 0000     (.......\.......
    80010288:	e6ac 8000 0000 0000                         ........

0000000080010290 <_ZTVN19ConsumerProducerCPP8ConsumerE>:
	...
    800102a0:	e428 8000 0000 0000 e45c 8000 0000 0000     (.......\.......
    800102b0:	e358 8000 0000 0000                         X.......

00000000800102b8 <_ZTV10ForkThread>:
	...
    800102c8:	e5a8 8000 0000 0000 e5dc 8000 0000 0000     ................
    800102d8:	e740 8000 0000 0000                         @.......

00000000800102e0 <digits>:
    800102e0:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...

00000000800102f8 <_ZTV14PeriodicThread>:
	...
    80010308:	f3bc 8000 0000 0000 f3f0 8000 0000 0000     ................
    80010318:	f38c 8000 0000 0000 f3a4 8000 0000 0000     ................

0000000080010328 <_ZTV9Semaphore>:
	...
    80010338:	ef58 8000 0000 0000 f048 8000 0000 0000     X.......H.......

0000000080010348 <_ZTV6Thread>:
	...
    80010358:	ef90 8000 0000 0000 f088 8000 0000 0000     ................
    80010368:	f38c 8000 0000 0000                         ........

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
