
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	f3013103          	ld	sp,-208(sp) # 8000af30 <_GLOBAL_OFFSET_TABLE_+0x68>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	2a8050ef          	jal	ra,800052c4 <start>

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
    80001088:	4cc020ef          	jal	ra,80003554 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001238:	bec78793          	addi	a5,a5,-1044 # 8000ae20 <_ZL11CACHE_NAMES>
    8000123c:	00e787b3          	add	a5,a5,a4
    80001240:	000c0b13          	mv	s6,s8
    80001244:	00000693          	li	a3,0
    80001248:	00000613          	li	a2,0
    8000124c:	000c0593          	mv	a1,s8
    80001250:	0007b503          	ld	a0,0(a5)
    80001254:	00003097          	auipc	ra,0x3
    80001258:	0ec080e7          	jalr	236(ra) # 80004340 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000125c:	00050a13          	mv	s4,a0

    struct objects_s *objs = (struct objects_s*)(kmalloc(sizeof(struct objects_s) * data.iterations));
    80001260:	f9842b83          	lw	s7,-104(s0)
    80001264:	004b9513          	slli	a0,s7,0x4
    80001268:	00003097          	auipc	ra,0x3
    8000126c:	1d0080e7          	jalr	464(ra) # 80004438 <_Z7kmallocm>
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
    80001290:	0dc080e7          	jalr	220(ra) # 80004368 <_Z16kmem_cache_allocP5Cache>
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
    800012d8:	094080e7          	jalr	148(ra) # 80004368 <_Z16kmem_cache_allocP5Cache>
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
    80001310:	0dc080e7          	jalr	220(ra) # 800043e8 <_Z15kmem_cache_infoP5Cache>
    kmem_cache_info(data.shared);
    80001314:	f9043503          	ld	a0,-112(s0)
    80001318:	00003097          	auipc	ra,0x3
    8000131c:	0d0080e7          	jalr	208(ra) # 800043e8 <_Z15kmem_cache_infoP5Cache>

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
    8000134c:	048080e7          	jalr	72(ra) # 80004390 <_Z15kmem_cache_freeP5CachePv>
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
    80001388:	0dc080e7          	jalr	220(ra) # 80004460 <_Z5kfreePKv>
    kmem_cache_destroy(cache);
    8000138c:	000a0513          	mv	a0,s4
    80001390:	00003097          	auipc	ra,0x3
    80001394:	028080e7          	jalr	40(ra) # 800043b8 <_Z18kmem_cache_destroyP5Cache>
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
    8000147c:	ec8080e7          	jalr	-312(ra) # 80004340 <_Z17kmem_cache_createPKcmPFvPvES3_>
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
    800014b0:	f0c080e7          	jalr	-244(ra) # 800043b8 <_Z18kmem_cache_destroyP5Cache>
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
    800014fc:	b087c783          	lbu	a5,-1272(a5) # 8000b000 <_ZN6System11initializedE>
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
    80001524:	aef70023          	sb	a5,-1312(a4) # 8000b000 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    80001528:	00003097          	auipc	ra,0x3
    8000152c:	a8c080e7          	jalr	-1396(ra) # 80003fb4 <_ZN5RiscV10initializeEv>

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
    80001568:	ddc080e7          	jalr	-548(ra) # 80004340 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000156c:	00050493          	mv	s1,a0
        kmem_cache_alloc(cache);
    80001570:	00003097          	auipc	ra,0x3
    80001574:	df8080e7          	jalr	-520(ra) # 80004368 <_Z16kmem_cache_allocP5Cache>
        SlabAllocator::printSlab(cache->partialHead);
    80001578:	0684b503          	ld	a0,104(s1)
    8000157c:	00003097          	auipc	ra,0x3
    80001580:	f74080e7          	jalr	-140(ra) # 800044f0 <_ZN13SlabAllocator9printSlabEP4Slab>
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
    80001594:	9a85b583          	ld	a1,-1624(a1) # 8000af38 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001598:	fd840513          	addi	a0,s0,-40
    8000159c:	00002097          	auipc	ra,0x2
    800015a0:	418080e7          	jalr	1048(ra) # 800039b4 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    800015a4:	fd843783          	ld	a5,-40(s0)
    800015a8:	0107a703          	lw	a4,16(a5)
    800015ac:	00200793          	li	a5,2
    800015b0:	00f70863          	beq	a4,a5,800015c0 <_ZN6SystemC1Ev+0xc8>
            RiscV::threadDispatchUtil();
    800015b4:	00002097          	auipc	ra,0x2
    800015b8:	49c080e7          	jalr	1180(ra) # 80003a50 <_ZN5RiscV18threadDispatchUtilEv>
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
    8000164c:	cf8080e7          	jalr	-776(ra) # 80004340 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001650:	0000a797          	auipc	a5,0xa
    80001654:	9aa7bc23          	sd	a0,-1608(a5) # 8000b008 <_ZN3SCB8scbCacheE>
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
    800016b8:	a68080e7          	jalr	-1432(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>
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
    800016fc:	8887b783          	ld	a5,-1912(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    80001734:	8507b783          	ld	a5,-1968(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    80001778:	9a8080e7          	jalr	-1624(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>
}
    8000177c:	00813083          	ld	ra,8(sp)
    80001780:	00013403          	ld	s0,0(sp)
    80001784:	01010113          	addi	sp,sp,16
    80001788:	00008067          	ret
    8000178c:	00008067          	ret

0000000080001790 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80001790:	00009797          	auipc	a5,0x9
    80001794:	7f07b783          	ld	a5,2032(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    8000182c:	00009517          	auipc	a0,0x9
    80001830:	7dc53503          	ld	a0,2012(a0) # 8000b008 <_ZN3SCB8scbCacheE>
    80001834:	00003097          	auipc	ra,0x3
    80001838:	b34080e7          	jalr	-1228(ra) # 80004368 <_Z16kmem_cache_allocP5Cache>
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
    80001860:	00009517          	auipc	a0,0x9
    80001864:	7a853503          	ld	a0,1960(a0) # 8000b008 <_ZN3SCB8scbCacheE>
    80001868:	00003097          	auipc	ra,0x3
    8000186c:	b28080e7          	jalr	-1240(ra) # 80004390 <_Z15kmem_cache_freeP5CachePv>
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
    800018dc:	6087b783          	ld	a5,1544(a5) # 8000aee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800018e0:	0007b703          	ld	a4,0(a5)
    800018e4:	00c75793          	srli	a5,a4,0xc
    800018e8:	00278793          	addi	a5,a5,2
    800018ec:	00c79793          	slli	a5,a5,0xc
    800018f0:	00009697          	auipc	a3,0x9
    800018f4:	72068693          	addi	a3,a3,1824 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    8000191c:	6f870713          	addi	a4,a4,1784 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001920:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001924:	00009797          	auipc	a5,0x9
    80001928:	5bc7b783          	ld	a5,1468(a5) # 8000aee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000192c:	0007b783          	ld	a5,0(a5)
    80001930:	fffff6b7          	lui	a3,0xfffff
    80001934:	00d7f7b3          	and	a5,a5,a3
    80001938:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    8000193c:	00009797          	auipc	a5,0x9
    80001940:	50b7ba23          	sd	a1,1300(a5) # 8000ae50 <_ZN5Buddy16BLOCKS_AVAILABLEE>
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
    80001968:	6ac78793          	addi	a5,a5,1708 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001998:	67c78793          	addi	a5,a5,1660 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    800019c8:	64c78793          	addi	a5,a5,1612 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    800019f8:	61c70713          	addi	a4,a4,1564 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001a44:	5d078793          	addi	a5,a5,1488 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001a7c:	5987b783          	ld	a5,1432(a5) # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001ac0:	55468693          	addi	a3,a3,1364 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ac4:	00b686b3          	add	a3,a3,a1
    80001ac8:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    80001acc:	f8061ce3          	bnez	a2,80001a64 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    80001ad0:	00009697          	auipc	a3,0x9
    80001ad4:	54068693          	addi	a3,a3,1344 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001b28:	4ec78793          	addi	a5,a5,1260 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001b70:	4a478793          	addi	a5,a5,1188 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001b9c:	47878793          	addi	a5,a5,1144 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001bd0:	44478793          	addi	a5,a5,1092 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001c5c:	3b870713          	addi	a4,a4,952 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001c8c:	38870713          	addi	a4,a4,904 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001cb8:	35c70713          	addi	a4,a4,860 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001d0c:	30878793          	addi	a5,a5,776 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001d30:	2e478793          	addi	a5,a5,740 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001d5c:	2b878793          	addi	a5,a5,696 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001df8:	21c78793          	addi	a5,a5,540 # 8000b010 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    80001f1c:	1d87b783          	ld	a5,472(a5) # 8000b0f0 <_ZN3TCB7runningE>
    80001f20:	0187b703          	ld	a4,24(a5)
    80001f24:	0207b503          	ld	a0,32(a5)
    80001f28:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    80001f2c:	00002097          	auipc	ra,0x2
    80001f30:	b04080e7          	jalr	-1276(ra) # 80003a30 <_ZN5RiscV14threadExitUtilEv>
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
    80001fc4:	4a0080e7          	jalr	1184(ra) # 80004460 <_Z5kfreePKv>
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
    80002018:	0dc4b483          	ld	s1,220(s1) # 8000b0f0 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    8000201c:	0104a703          	lw	a4,16(s1)
    80002020:	00100793          	li	a5,1
    80002024:	04e7f663          	bgeu	a5,a4,80002070 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002028:	00002097          	auipc	ra,0x2
    8000202c:	13c080e7          	jalr	316(ra) # 80004164 <_ZN9Scheduler3getEv>
    80002030:	00009797          	auipc	a5,0x9
    80002034:	0ca7b023          	sd	a0,192(a5) # 8000b0f0 <_ZN3TCB7runningE>
    if(running) {
    80002038:	02050263          	beqz	a0,8000205c <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    8000203c:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002040:	00001097          	auipc	ra,0x1
    80002044:	be4080e7          	jalr	-1052(ra) # 80002c24 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002048:	00009597          	auipc	a1,0x9
    8000204c:	0a85b583          	ld	a1,168(a1) # 8000b0f0 <_ZN3TCB7runningE>
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
    80002078:	0a8080e7          	jalr	168(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>
    8000207c:	fadff06f          	j	80002028 <_ZN3TCB8dispatchEv+0x28>

0000000080002080 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002080:	ff010113          	addi	sp,sp,-16
    80002084:	00113423          	sd	ra,8(sp)
    80002088:	00813023          	sd	s0,0(sp)
    8000208c:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002090:	00009517          	auipc	a0,0x9
    80002094:	06853503          	ld	a0,104(a0) # 8000b0f8 <_ZN3TCB8tcbCacheE>
    80002098:	00002097          	auipc	ra,0x2
    8000209c:	2d0080e7          	jalr	720(ra) # 80004368 <_Z16kmem_cache_allocP5Cache>
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
    800020e8:	25c080e7          	jalr	604(ra) # 80004340 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800020ec:	00009797          	auipc	a5,0x9
    800020f0:	00a7b623          	sd	a0,12(a5) # 8000b0f8 <_ZN3TCB8tcbCacheE>
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
    80002124:	fc97b823          	sd	s1,-48(a5) # 8000b0f0 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    80002128:	00100793          	li	a5,1
    8000212c:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80002130:	00001537          	lui	a0,0x1
    80002134:	00002097          	auipc	ra,0x2
    80002138:	304080e7          	jalr	772(ra) # 80004438 <_Z7kmallocm>
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
    80002164:	da85b583          	ld	a1,-600(a1) # 8000af08 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002168:	00000097          	auipc	ra,0x0
    8000216c:	ddc080e7          	jalr	-548(ra) # 80001f44 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002170:	00009797          	auipc	a5,0x9
    80002174:	f897b823          	sd	s1,-112(a5) # 8000b100 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    80002178:	00100793          	li	a5,1
    8000217c:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    80002180:	00048513          	mv	a0,s1
    80002184:	00002097          	auipc	ra,0x2
    80002188:	f98080e7          	jalr	-104(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>
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
    800021bc:	f4053503          	ld	a0,-192(a0) # 8000b0f8 <_ZN3TCB8tcbCacheE>
    800021c0:	00002097          	auipc	ra,0x2
    800021c4:	1d0080e7          	jalr	464(ra) # 80004390 <_Z15kmem_cache_freeP5CachePv>
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
    80002214:	cd07b783          	ld	a5,-816(a5) # 8000aee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002218:	0007b783          	ld	a5,0(a5)
    8000221c:	00c7d793          	srli	a5,a5,0xc
    80002220:	00278793          	addi	a5,a5,2
    80002224:	00c79793          	slli	a5,a5,0xc
    80002228:	01000737          	lui	a4,0x1000
    8000222c:	00e787b3          	add	a5,a5,a4
    80002230:	00009717          	auipc	a4,0x9
    80002234:	ef070713          	addi	a4,a4,-272 # 8000b120 <_ZN15MemoryAllocator11freeMemTailE>
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
    80002254:	d486b683          	ld	a3,-696(a3) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xd0>
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
    8000229c:	e9053503          	ld	a0,-368(a0) # 8000b128 <_ZN15MemoryAllocator11freeMemHeadE>
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
    800022e4:	cb85b583          	ld	a1,-840(a1) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xd0>
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
    80002330:	e0c7b783          	ld	a5,-500(a5) # 8000b138 <_ZN15MemoryAllocator12allocMemHeadE>
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
    8000236c:	db868693          	addi	a3,a3,-584 # 8000b120 <_ZN15MemoryAllocator11freeMemTailE>
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
    80002394:	d8f6bc23          	sd	a5,-616(a3) # 8000b128 <_ZN15MemoryAllocator11freeMemHeadE>
    80002398:	f95ff06f          	j	8000232c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    8000239c:	00009797          	auipc	a5,0x9
    800023a0:	d8478793          	addi	a5,a5,-636 # 8000b120 <_ZN15MemoryAllocator11freeMemTailE>
    800023a4:	00a7b823          	sd	a0,16(a5)
    800023a8:	00a7bc23          	sd	a0,24(a5)
    800023ac:	fadff06f          	j	80002358 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    800023b0:	00009797          	auipc	a5,0x9
    800023b4:	d8a7b423          	sd	a0,-632(a5) # 8000b138 <_ZN15MemoryAllocator12allocMemHeadE>
    800023b8:	fa1ff06f          	j	80002358 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    800023bc:	00009797          	auipc	a5,0x9
    800023c0:	d6478793          	addi	a5,a5,-668 # 8000b120 <_ZN15MemoryAllocator11freeMemTailE>
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
    80002434:	cf87b783          	ld	a5,-776(a5) # 8000b128 <_ZN15MemoryAllocator11freeMemHeadE>
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
    800024c4:	c786b683          	ld	a3,-904(a3) # 8000b138 <_ZN15MemoryAllocator12allocMemHeadE>
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
    800024f8:	c3c7b783          	ld	a5,-964(a5) # 8000b130 <_ZN15MemoryAllocator12allocMemTailE>
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
    80002528:	c0458593          	addi	a1,a1,-1020 # 8000b128 <_ZN15MemoryAllocator11freeMemHeadE>
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
    80002550:	bef73223          	sd	a5,-1052(a4) # 8000b130 <_ZN15MemoryAllocator12allocMemTailE>
    80002554:	fadff06f          	j	80002500 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80002558:	01053783          	ld	a5,16(a0)
    8000255c:	00009717          	auipc	a4,0x9
    80002560:	bcf73e23          	sd	a5,-1060(a4) # 8000b138 <_ZN15MemoryAllocator12allocMemHeadE>
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
    80002588:	bb44b483          	ld	s1,-1100(s1) # 8000b138 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    8000258c:	00006517          	auipc	a0,0x6
    80002590:	b0c50513          	addi	a0,a0,-1268 # 80008098 <CONSOLE_STATUS+0x88>
    80002594:	0000c097          	auipc	ra,0xc
    80002598:	6d8080e7          	jalr	1752(ra) # 8000ec6c <_Z11printStringPKc>
    while(iter!=nullptr){
    8000259c:	04048663          	beqz	s1,800025e8 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800025a0:	00000613          	li	a2,0
    800025a4:	00a00593          	li	a1,10
    800025a8:	0004851b          	sext.w	a0,s1
    800025ac:	0000d097          	auipc	ra,0xd
    800025b0:	858080e7          	jalr	-1960(ra) # 8000ee04 <_Z8printIntiii>
        putc(' ');
    800025b4:	02000513          	li	a0,32
    800025b8:	0000b097          	auipc	ra,0xb
    800025bc:	d74080e7          	jalr	-652(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    800025c0:	00000613          	li	a2,0
    800025c4:	00a00593          	li	a1,10
    800025c8:	0004a503          	lw	a0,0(s1)
    800025cc:	0000d097          	auipc	ra,0xd
    800025d0:	838080e7          	jalr	-1992(ra) # 8000ee04 <_Z8printIntiii>
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
    800025f4:	67c080e7          	jalr	1660(ra) # 8000ec6c <_Z11printStringPKc>
    iter = freeMemHead;
    800025f8:	00009497          	auipc	s1,0x9
    800025fc:	b304b483          	ld	s1,-1232(s1) # 8000b128 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80002600:	04048663          	beqz	s1,8000264c <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80002604:	00000613          	li	a2,0
    80002608:	00a00593          	li	a1,10
    8000260c:	0004851b          	sext.w	a0,s1
    80002610:	0000c097          	auipc	ra,0xc
    80002614:	7f4080e7          	jalr	2036(ra) # 8000ee04 <_Z8printIntiii>
        putc(' ');
    80002618:	02000513          	li	a0,32
    8000261c:	0000b097          	auipc	ra,0xb
    80002620:	d10080e7          	jalr	-752(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    80002624:	00000613          	li	a2,0
    80002628:	00a00593          	li	a1,10
    8000262c:	0004a503          	lw	a0,0(s1)
    80002630:	0000c097          	auipc	ra,0xc
    80002634:	7d4080e7          	jalr	2004(ra) # 8000ee04 <_Z8printIntiii>
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
    80002658:	618080e7          	jalr	1560(ra) # 8000ec6c <_Z11printStringPKc>
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
    800026ec:	a697b023          	sd	s1,-1440(a5) # 8000b148 <_ZN11ConsoleUtil8inputSemE>
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
    80002714:	a3890913          	addi	s2,s2,-1480 # 8000b148 <_ZN11ConsoleUtil8inputSemE>
    80002718:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    8000271c:	00008497          	auipc	s1,0x8
    80002720:	73c48493          	addi	s1,s1,1852 # 8000ae58 <_ZN11ConsoleUtil10bufferSizeE>
    80002724:	0004b503          	ld	a0,0(s1)
    80002728:	00002097          	auipc	ra,0x2
    8000272c:	d10080e7          	jalr	-752(ra) # 80004438 <_Z7kmallocm>
    80002730:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80002734:	0004b503          	ld	a0,0(s1)
    80002738:	00002097          	auipc	ra,0x2
    8000273c:	d00080e7          	jalr	-768(ra) # 80004438 <_Z7kmallocm>
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
    80002774:	ba8080e7          	jalr	-1112(ra) # 8000c318 <_Unwind_Resume>
    80002778:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    8000277c:	00048513          	mv	a0,s1
    80002780:	fffff097          	auipc	ra,0xfffff
    80002784:	0cc080e7          	jalr	204(ra) # 8000184c <_ZN3SCBdlEPv>
    80002788:	00090513          	mv	a0,s2
    8000278c:	0000a097          	auipc	ra,0xa
    80002790:	b8c080e7          	jalr	-1140(ra) # 8000c318 <_Unwind_Resume>

0000000080002794 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80002794:	00009717          	auipc	a4,0x9
    80002798:	9b470713          	addi	a4,a4,-1612 # 8000b148 <_ZN11ConsoleUtil8inputSemE>
    8000279c:	02073683          	ld	a3,32(a4)
    800027a0:	00168793          	addi	a5,a3,1
    800027a4:	00008617          	auipc	a2,0x8
    800027a8:	6b463603          	ld	a2,1716(a2) # 8000ae58 <_ZN11ConsoleUtil10bufferSizeE>
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
    800027cc:	98070713          	addi	a4,a4,-1664 # 8000b148 <_ZN11ConsoleUtil8inputSemE>
    800027d0:	01073783          	ld	a5,16(a4)
    800027d4:	00d786b3          	add	a3,a5,a3
    800027d8:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    800027dc:	02073783          	ld	a5,32(a4)
    800027e0:	00178793          	addi	a5,a5,1
    800027e4:	00008697          	auipc	a3,0x8
    800027e8:	6746b683          	ld	a3,1652(a3) # 8000ae58 <_ZN11ConsoleUtil10bufferSizeE>
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
    8000282c:	92048493          	addi	s1,s1,-1760 # 8000b148 <_ZN11ConsoleUtil8inputSemE>
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
    8000285c:	60073703          	ld	a4,1536(a4) # 8000ae58 <_ZN11ConsoleUtil10bufferSizeE>
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
    80002888:	8c478793          	addi	a5,a5,-1852 # 8000b148 <_ZN11ConsoleUtil8inputSemE>
    8000288c:	0307b703          	ld	a4,48(a5)
    80002890:	00170713          	addi	a4,a4,1
    80002894:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80002898:	0387b683          	ld	a3,56(a5)
    8000289c:	00168713          	addi	a4,a3,1
    800028a0:	00008617          	auipc	a2,0x8
    800028a4:	5b863603          	ld	a2,1464(a2) # 8000ae58 <_ZN11ConsoleUtil10bufferSizeE>
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
    800028c8:	88478793          	addi	a5,a5,-1916 # 8000b148 <_ZN11ConsoleUtil8inputSemE>
    800028cc:	0187b703          	ld	a4,24(a5)
    800028d0:	00d706b3          	add	a3,a4,a3
    800028d4:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    800028d8:	0387b703          	ld	a4,56(a5)
    800028dc:	00170713          	addi	a4,a4,1
    800028e0:	00008697          	auipc	a3,0x8
    800028e4:	5786b683          	ld	a3,1400(a3) # 8000ae58 <_ZN11ConsoleUtil10bufferSizeE>
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
    80002934:	81848493          	addi	s1,s1,-2024 # 8000b148 <_ZN11ConsoleUtil8inputSemE>
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
    80002964:	4f873703          	ld	a4,1272(a4) # 8000ae58 <_ZN11ConsoleUtil10bufferSizeE>
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
    80002b50:	4347b783          	ld	a5,1076(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    80002b78:	4047b783          	ld	a5,1028(a5) # 8000af78 <_GLOBAL_OFFSET_TABLE_+0xb0>
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
    80002bac:	3d87b783          	ld	a5,984(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    80002be8:	5b47c783          	lbu	a5,1460(a5) # 8000b198 <_ZN5RiscV16userMainFinishedE>
    80002bec:	00079c63          	bnez	a5,80002c04 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80002bf0:	00008717          	auipc	a4,0x8
    80002bf4:	38073703          	ld	a4,896(a4) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0xa8>
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
    80002c34:	3507b783          	ld	a5,848(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
//        RiscV::startVirtualMemory(RiscV::uPMT);
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
    80002c80:	50f70e23          	sb	a5,1308(a4) # 8000b198 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80002c84:	00008797          	auipc	a5,0x8
    80002c88:	2ec7b783          	ld	a5,748(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80002c8c:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80002c90:	00008797          	auipc	a5,0x8
    80002c94:	2907b783          	ld	a5,656(a5) # 8000af20 <_GLOBAL_OFFSET_TABLE_+0x58>
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
    80002cb0:	29c7b783          	ld	a5,668(a5) # 8000af48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002cb4:	0007b783          	ld	a5,0(a5)
    80002cb8:	00078c63          	beqz	a5,80002cd0 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80002cbc:	0487b703          	ld	a4,72(a5)
    80002cc0:	00008797          	auipc	a5,0x8
    80002cc4:	2887b783          	ld	a5,648(a5) # 8000af48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002cc8:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80002ccc:	fe1ff06f          	j	80002cac <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80002cd0:	00008797          	auipc	a5,0x8
    80002cd4:	2807b783          	ld	a5,640(a5) # 8000af50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002cd8:	0007b503          	ld	a0,0(a5)
    80002cdc:	00001097          	auipc	ra,0x1
    80002ce0:	440080e7          	jalr	1088(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002ce4:	00008797          	auipc	a5,0x8
    80002ce8:	27c7b783          	ld	a5,636(a5) # 8000af60 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002cec:	0007b703          	ld	a4,0(a5)
    80002cf0:	00008797          	auipc	a5,0x8
    80002cf4:	2787b783          	ld	a5,632(a5) # 8000af68 <_GLOBAL_OFFSET_TABLE_+0xa0>
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
    80002d30:	25473703          	ld	a4,596(a4) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    80002da0:	1f47b783          	ld	a5,500(a5) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0xc8>
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
    80002e50:	2d0080e7          	jalr	720(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>
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
    80002eac:	470080e7          	jalr	1136(ra) # 8000c318 <_Unwind_Resume>

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
    80002f74:	3a8080e7          	jalr	936(ra) # 8000c318 <_Unwind_Resume>

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
    80002fbc:	164080e7          	jalr	356(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>
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
    80002fe4:	fa07b783          	ld	a5,-96(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    800030c0:	25c080e7          	jalr	604(ra) # 8000c318 <_Unwind_Resume>

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
    80003140:	e447b783          	ld	a5,-444(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
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
    800031e8:	d9c7b783          	ld	a5,-612(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800031ec:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    800031f0:	00008797          	auipc	a5,0x8
    800031f4:	fb07b783          	ld	a5,-80(a5) # 8000b1a0 <_ZN5RiscV10globalTimeE>
    800031f8:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    800031fc:	00e787b3          	add	a5,a5,a4
    80003200:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003204:	00048513          	mv	a0,s1
    80003208:	00001097          	auipc	ra,0x1
    8000320c:	f90080e7          	jalr	-112(ra) # 80004198 <_ZN9Scheduler5sleepEP3TCB>
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
    8000325c:	f407c783          	lbu	a5,-192(a5) # 8000b198 <_ZN5RiscV16userMainFinishedE>
    80003260:	00079c63          	bnez	a5,80003278 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003264:	00008717          	auipc	a4,0x8
    80003268:	cbc73703          	ld	a4,-836(a4) # 8000af20 <_GLOBAL_OFFSET_TABLE_+0x58>
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
    80003358:	10c080e7          	jalr	268(ra) # 80004460 <_Z5kfreePKv>
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

00000000800033d4 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    800033d4:	fe010113          	addi	sp,sp,-32
    800033d8:	00113c23          	sd	ra,24(sp)
    800033dc:	00813823          	sd	s0,16(sp)
    800033e0:	00913423          	sd	s1,8(sp)
    800033e4:	01213023          	sd	s2,0(sp)
    800033e8:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    800033ec:	04000513          	li	a0,64
    800033f0:	fffff097          	auipc	ra,0xfffff
    800033f4:	e94080e7          	jalr	-364(ra) # 80002284 <_ZN15MemoryAllocator7kmallocEm>
    800033f8:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    800033fc:	00008797          	auipc	a5,0x8
    80003400:	b847b783          	ld	a5,-1148(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003404:	0007b783          	ld	a5,0(a5)
    80003408:	00001637          	lui	a2,0x1
    8000340c:	00050593          	mv	a1,a0
    80003410:	0287b503          	ld	a0,40(a5)
    80003414:	fffff097          	auipc	ra,0xfffff
    80003418:	25c080e7          	jalr	604(ra) # 80002670 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    8000341c:	07000513          	li	a0,112
    80003420:	fffff097          	auipc	ra,0xfffff
    80003424:	c60080e7          	jalr	-928(ra) # 80002080 <_ZN3TCBnwEm>
    80003428:	00050493          	mv	s1,a0
    8000342c:	00050e63          	beqz	a0,80003448 <_ZN5RiscV18executeForkSyscallEv+0x74>
    80003430:	00200713          	li	a4,2
    80003434:	00090693          	mv	a3,s2
    80003438:	00000613          	li	a2,0
    8000343c:	00000593          	li	a1,0
    80003440:	fffff097          	auipc	ra,0xfffff
    80003444:	b04080e7          	jalr	-1276(ra) # 80001f44 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003448:	0a048e63          	beqz	s1,80003504 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    8000344c:	00008797          	auipc	a5,0x8
    80003450:	af47b783          	ld	a5,-1292(a5) # 8000af40 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003454:	0007b783          	ld	a5,0(a5)
    80003458:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    8000345c:	00008797          	auipc	a5,0x8
    80003460:	acc7b783          	ld	a5,-1332(a5) # 8000af28 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003464:	0007b783          	ld	a5,0(a5)
    80003468:	00f907b3          	add	a5,s2,a5
    8000346c:	00008717          	auipc	a4,0x8
    80003470:	b1473703          	ld	a4,-1260(a4) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003474:	00073683          	ld	a3,0(a4)
    80003478:	0286b683          	ld	a3,40(a3)
    8000347c:	40d787b3          	sub	a5,a5,a3
    80003480:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003484:	00073783          	ld	a5,0(a4)
    80003488:	0687b503          	ld	a0,104(a5)
    8000348c:	0287b783          	ld	a5,40(a5)
    80003490:	40f50533          	sub	a0,a0,a5
    80003494:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003498:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    8000349c:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    800034a0:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    800034a4:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    800034a8:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    800034ac:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    800034b0:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    800034b4:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800034b8:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    800034bc:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    800034c0:	00073783          	ld	a5,0(a4)
    800034c4:	0387b703          	ld	a4,56(a5)
    800034c8:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    800034cc:	0407b783          	ld	a5,64(a5)
    800034d0:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    800034d4:	00048513          	mv	a0,s1
    800034d8:	00001097          	auipc	ra,0x1
    800034dc:	c44080e7          	jalr	-956(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    800034e0:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    800034e4:	00000097          	auipc	ra,0x0
    800034e8:	838080e7          	jalr	-1992(ra) # 80002d1c <_ZN5RiscV16saveA0toSscratchEv>

}
    800034ec:	01813083          	ld	ra,24(sp)
    800034f0:	01013403          	ld	s0,16(sp)
    800034f4:	00813483          	ld	s1,8(sp)
    800034f8:	00013903          	ld	s2,0(sp)
    800034fc:	02010113          	addi	sp,sp,32
    80003500:	00008067          	ret
        status = -1;
    80003504:	fff00493          	li	s1,-1
    80003508:	fd9ff06f          	j	800034e0 <_ZN5RiscV18executeForkSyscallEv+0x10c>
    8000350c:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003510:	00048513          	mv	a0,s1
    80003514:	fffff097          	auipc	ra,0xfffff
    80003518:	c90080e7          	jalr	-880(ra) # 800021a4 <_ZN3TCBdlEPv>
    8000351c:	00090513          	mv	a0,s2
    80003520:	00009097          	auipc	ra,0x9
    80003524:	df8080e7          	jalr	-520(ra) # 8000c318 <_Unwind_Resume>

0000000080003528 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003528:	ff010113          	addi	sp,sp,-16
    8000352c:	00813423          	sd	s0,8(sp)
    80003530:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003534:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003538:	00878793          	addi	a5,a5,8
    8000353c:	00008717          	auipc	a4,0x8
    80003540:	a0473703          	ld	a4,-1532(a4) # 8000af40 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003544:	00f73023          	sd	a5,0(a4)
}
    80003548:	00813403          	ld	s0,8(sp)
    8000354c:	01010113          	addi	sp,sp,16
    80003550:	00008067          	ret

0000000080003554 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003554:	f9010113          	addi	sp,sp,-112
    80003558:	06113423          	sd	ra,104(sp)
    8000355c:	06813023          	sd	s0,96(sp)
    80003560:	04913c23          	sd	s1,88(sp)
    80003564:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    80003568:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    8000356c:	142027f3          	csrr	a5,scause
    80003570:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80003574:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    80003578:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    8000357c:	00008797          	auipc	a5,0x8
    80003580:	a047b783          	ld	a5,-1532(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003584:	0007b783          	ld	a5,0(a5)
    80003588:	14002773          	csrr	a4,sscratch
    8000358c:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80003590:	fd843703          	ld	a4,-40(s0)
    80003594:	00900793          	li	a5,9
    80003598:	10f70663          	beq	a4,a5,800036a4 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    8000359c:	fd843703          	ld	a4,-40(s0)
    800035a0:	00800793          	li	a5,8
    800035a4:	10f70063          	beq	a4,a5,800036a4 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    800035a8:	fd843703          	ld	a4,-40(s0)
    800035ac:	fff00793          	li	a5,-1
    800035b0:	03f79793          	slli	a5,a5,0x3f
    800035b4:	00178793          	addi	a5,a5,1
    800035b8:	26f70463          	beq	a4,a5,80003820 <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    800035bc:	fd843703          	ld	a4,-40(s0)
    800035c0:	fff00793          	li	a5,-1
    800035c4:	03f79793          	slli	a5,a5,0x3f
    800035c8:	00978793          	addi	a5,a5,9
    800035cc:	2ef70263          	beq	a4,a5,800038b0 <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    800035d0:	fd843703          	ld	a4,-40(s0)
    800035d4:	00200793          	li	a5,2
    800035d8:	36f70a63          	beq	a4,a5,8000394c <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    800035dc:	00005517          	auipc	a0,0x5
    800035e0:	b8c50513          	addi	a0,a0,-1140 # 80008168 <CONSOLE_STATUS+0x158>
    800035e4:	fffff097          	auipc	ra,0xfffff
    800035e8:	3a8080e7          	jalr	936(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    800035ec:	00005517          	auipc	a0,0x5
    800035f0:	b8c50513          	addi	a0,a0,-1140 # 80008178 <CONSOLE_STATUS+0x168>
    800035f4:	fffff097          	auipc	ra,0xfffff
    800035f8:	398080e7          	jalr	920(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800035fc:	142027f3          	csrr	a5,scause
    80003600:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003604:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80003608:	00000613          	li	a2,0
    8000360c:	00a00593          	li	a1,10
    80003610:	0005051b          	sext.w	a0,a0
    80003614:	fffff097          	auipc	ra,0xfffff
    80003618:	3bc080e7          	jalr	956(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    8000361c:	00005517          	auipc	a0,0x5
    80003620:	b1c50513          	addi	a0,a0,-1252 # 80008138 <CONSOLE_STATUS+0x128>
    80003624:	fffff097          	auipc	ra,0xfffff
    80003628:	368080e7          	jalr	872(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000362c:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003630:	00000613          	li	a2,0
    80003634:	01000593          	li	a1,16
    80003638:	0005051b          	sext.w	a0,a0
    8000363c:	fffff097          	auipc	ra,0xfffff
    80003640:	394080e7          	jalr	916(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003644:	00005517          	auipc	a0,0x5
    80003648:	ad450513          	addi	a0,a0,-1324 # 80008118 <CONSOLE_STATUS+0x108>
    8000364c:	fffff097          	auipc	ra,0xfffff
    80003650:	340080e7          	jalr	832(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    80003654:	01000693          	li	a3,16
    80003658:	00005617          	auipc	a2,0x5
    8000365c:	ac060613          	addi	a2,a2,-1344 # 80008118 <CONSOLE_STATUS+0x108>
    80003660:	0004859b          	sext.w	a1,s1
    80003664:	00005517          	auipc	a0,0x5
    80003668:	b2450513          	addi	a0,a0,-1244 # 80008188 <CONSOLE_STATUS+0x178>
    8000366c:	fffff097          	auipc	ra,0xfffff
    80003670:	440080e7          	jalr	1088(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80003674:	00008797          	auipc	a5,0x8
    80003678:	90c7b783          	ld	a5,-1780(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000367c:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003680:	00200713          	li	a4,2
    80003684:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003688:	00005517          	auipc	a0,0x5
    8000368c:	b0850513          	addi	a0,a0,-1272 # 80008190 <CONSOLE_STATUS+0x180>
    80003690:	fffff097          	auipc	ra,0xfffff
    80003694:	2fc080e7          	jalr	764(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003698:	fffff097          	auipc	ra,0xfffff
    8000369c:	968080e7          	jalr	-1688(ra) # 80002000 <_ZN3TCB8dispatchEv>
    800036a0:	0800006f          	j	80003720 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800036a4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800036a8:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800036ac:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    800036b0:	00478793          	addi	a5,a5,4
    800036b4:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    800036b8:	00008797          	auipc	a5,0x8
    800036bc:	8c87b783          	ld	a5,-1848(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800036c0:	0007b783          	ld	a5,0(a5)
    800036c4:	fa043703          	ld	a4,-96(s0)
    800036c8:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800036cc:	f9843703          	ld	a4,-104(s0)
    800036d0:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800036d4:	00050793          	mv	a5,a0
        switch(syscallID){
    800036d8:	06100713          	li	a4,97
    800036dc:	02f76463          	bltu	a4,a5,80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    800036e0:	00279793          	slli	a5,a5,0x2
    800036e4:	00005717          	auipc	a4,0x5
    800036e8:	ac070713          	addi	a4,a4,-1344 # 800081a4 <CONSOLE_STATUS+0x194>
    800036ec:	00e787b3          	add	a5,a5,a4
    800036f0:	0007a783          	lw	a5,0(a5)
    800036f4:	00e787b3          	add	a5,a5,a4
    800036f8:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    800036fc:	fffff097          	auipc	ra,0xfffff
    80003700:	658080e7          	jalr	1624(ra) # 80002d54 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003704:	00008797          	auipc	a5,0x8
    80003708:	87c7b783          	ld	a5,-1924(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000370c:	0007b783          	ld	a5,0(a5)
    80003710:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003714:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003718:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000371c:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003720:	fffff097          	auipc	ra,0xfffff
    80003724:	504080e7          	jalr	1284(ra) # 80002c24 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003728:	06813083          	ld	ra,104(sp)
    8000372c:	06013403          	ld	s0,96(sp)
    80003730:	05813483          	ld	s1,88(sp)
    80003734:	07010113          	addi	sp,sp,112
    80003738:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    8000373c:	fffff097          	auipc	ra,0xfffff
    80003740:	650080e7          	jalr	1616(ra) # 80002d8c <_ZN5RiscV21executeMemFreeSyscallEv>
    80003744:	fc1ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    80003748:	fffff097          	auipc	ra,0xfffff
    8000374c:	694080e7          	jalr	1684(ra) # 80002ddc <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003750:	fb5ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    80003754:	00000097          	auipc	ra,0x0
    80003758:	87c080e7          	jalr	-1924(ra) # 80002fd0 <_ZN5RiscV24executeThreadExitSyscallEv>
    8000375c:	fa9ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003760:	fffff097          	auipc	ra,0xfffff
    80003764:	438080e7          	jalr	1080(ra) # 80002b98 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003768:	f9dff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    8000376c:	fffff097          	auipc	ra,0xfffff
    80003770:	744080e7          	jalr	1860(ra) # 80002eb0 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003774:	f91ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    80003778:	00000097          	auipc	ra,0x0
    8000377c:	800080e7          	jalr	-2048(ra) # 80002f78 <_ZN5RiscV25executeThreadStartSyscallEv>
    80003780:	f85ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80003784:	00000097          	auipc	ra,0x0
    80003788:	8a4080e7          	jalr	-1884(ra) # 80003028 <_ZN5RiscV21executeSemOpenSyscallEv>
    8000378c:	f79ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    80003790:	00000097          	auipc	ra,0x0
    80003794:	934080e7          	jalr	-1740(ra) # 800030c4 <_ZN5RiscV22executeSemCloseSyscallEv>
    80003798:	f6dff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    8000379c:	00000097          	auipc	ra,0x0
    800037a0:	988080e7          	jalr	-1656(ra) # 80003124 <_ZN5RiscV21executeSemWaitSyscallEv>
    800037a4:	f61ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    800037a8:	00000097          	auipc	ra,0x0
    800037ac:	9dc080e7          	jalr	-1572(ra) # 80003184 <_ZN5RiscV23executeSemSignalSyscallEv>
    800037b0:	f55ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    800037b4:	00000097          	auipc	ra,0x0
    800037b8:	a18080e7          	jalr	-1512(ra) # 800031cc <_ZN5RiscV23executeTimeSleepSyscallEv>
    800037bc:	f49ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    800037c0:	00000097          	auipc	ra,0x0
    800037c4:	a84080e7          	jalr	-1404(ra) # 80003244 <_ZN5RiscV18executeGetcSyscallEv>
    800037c8:	f3dff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    800037cc:	fffff097          	auipc	ra,0xfffff
    800037d0:	408080e7          	jalr	1032(ra) # 80002bd4 <_ZN5RiscV18executePutcSyscallEv>
    800037d4:	f31ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    800037d8:	00000097          	auipc	ra,0x0
    800037dc:	b04080e7          	jalr	-1276(ra) # 800032dc <_ZN5RiscV22executePutcUtilSyscallEv>
    800037e0:	f25ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	b2c080e7          	jalr	-1236(ra) # 80003310 <_ZN5RiscV24executeThreadFreeSyscallEv>
    800037ec:	f19ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    800037f0:	00000097          	auipc	ra,0x0
    800037f4:	b88080e7          	jalr	-1144(ra) # 80003378 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    800037f8:	f0dff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    800037fc:	00010793          	mv	a5,sp
    80003800:	00007717          	auipc	a4,0x7
    80003804:	72873703          	ld	a4,1832(a4) # 8000af28 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003808:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    8000380c:	00000097          	auipc	ra,0x0
    80003810:	d1c080e7          	jalr	-740(ra) # 80003528 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80003814:	00000097          	auipc	ra,0x0
    80003818:	bc0080e7          	jalr	-1088(ra) # 800033d4 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    8000381c:	ee9ff06f          	j	80003704 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003820:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003824:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003828:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    8000382c:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80003830:	00200793          	li	a5,2
    80003834:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80003838:	00008717          	auipc	a4,0x8
    8000383c:	96070713          	addi	a4,a4,-1696 # 8000b198 <_ZN5RiscV16userMainFinishedE>
    80003840:	00873783          	ld	a5,8(a4)
    80003844:	00178793          	addi	a5,a5,1
    80003848:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    8000384c:	00001097          	auipc	ra,0x1
    80003850:	9a4080e7          	jalr	-1628(ra) # 800041f0 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80003854:	00007717          	auipc	a4,0x7
    80003858:	69c73703          	ld	a4,1692(a4) # 8000aef0 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000385c:	00073783          	ld	a5,0(a4)
    80003860:	00178793          	addi	a5,a5,1
    80003864:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80003868:	00007717          	auipc	a4,0x7
    8000386c:	71873703          	ld	a4,1816(a4) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003870:	00073703          	ld	a4,0(a4)
    80003874:	03073683          	ld	a3,48(a4)
    80003878:	00d7fc63          	bgeu	a5,a3,80003890 <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    8000387c:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003880:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003884:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003888:	14179073          	csrw	sepc,a5
}
    8000388c:	e95ff06f          	j	80003720 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    80003890:	00007797          	auipc	a5,0x7
    80003894:	6607b783          	ld	a5,1632(a5) # 8000aef0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003898:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    8000389c:	00100793          	li	a5,1
    800038a0:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    800038a4:	ffffe097          	auipc	ra,0xffffe
    800038a8:	75c080e7          	jalr	1884(ra) # 80002000 <_ZN3TCB8dispatchEv>
    800038ac:	fd1ff06f          	j	8000387c <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800038b0:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800038b4:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800038b8:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800038bc:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    800038c0:	00007797          	auipc	a5,0x7
    800038c4:	6187b783          	ld	a5,1560(a5) # 8000aed8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800038c8:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800038cc:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800038d0:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800038d4:	00058793          	mv	a5,a1
        if(status & 1UL)
    800038d8:	0017f793          	andi	a5,a5,1
    800038dc:	02078863          	beqz	a5,8000390c <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    800038e0:	00007797          	auipc	a5,0x7
    800038e4:	6387b783          	ld	a5,1592(a5) # 8000af18 <_GLOBAL_OFFSET_TABLE_+0x50>
    800038e8:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    800038ec:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    800038f0:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    800038f4:	00058513          	mv	a0,a1
    800038f8:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    800038fc:	00007797          	auipc	a5,0x7
    80003900:	6247b783          	ld	a5,1572(a5) # 8000af20 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003904:	0007b783          	ld	a5,0(a5)
    80003908:	02079463          	bnez	a5,80003930 <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    8000390c:	00002097          	auipc	ra,0x2
    80003910:	218080e7          	jalr	536(ra) # 80005b24 <plic_claim>
    80003914:	00002097          	auipc	ra,0x2
    80003918:	248080e7          	jalr	584(ra) # 80005b5c <plic_complete>
        RiscV::w_sstatus(sstatus);
    8000391c:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003920:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003924:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003928:	14179073          	csrw	sepc,a5
}
    8000392c:	df5ff06f          	j	80003720 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    80003930:	fff78793          	addi	a5,a5,-1
    80003934:	00007717          	auipc	a4,0x7
    80003938:	5ec73703          	ld	a4,1516(a4) # 8000af20 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000393c:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80003940:	fffff097          	auipc	ra,0xfffff
    80003944:	e54080e7          	jalr	-428(ra) # 80002794 <_ZN11ConsoleUtil8putInputEc>
    80003948:	fc5ff06f          	j	8000390c <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    8000394c:	00007797          	auipc	a5,0x7
    80003950:	6347b783          	ld	a5,1588(a5) # 8000af80 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003954:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003958:	00200713          	li	a4,2
    8000395c:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80003960:	00004517          	auipc	a0,0x4
    80003964:	7d850513          	addi	a0,a0,2008 # 80008138 <CONSOLE_STATUS+0x128>
    80003968:	fffff097          	auipc	ra,0xfffff
    8000396c:	024080e7          	jalr	36(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003970:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003974:	00000613          	li	a2,0
    80003978:	01000593          	li	a1,16
    8000397c:	0005051b          	sext.w	a0,a0
    80003980:	fffff097          	auipc	ra,0xfffff
    80003984:	050080e7          	jalr	80(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003988:	00004517          	auipc	a0,0x4
    8000398c:	79050513          	addi	a0,a0,1936 # 80008118 <CONSOLE_STATUS+0x108>
    80003990:	fffff097          	auipc	ra,0xfffff
    80003994:	ffc080e7          	jalr	-4(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80003998:	00004517          	auipc	a0,0x4
    8000399c:	7a850513          	addi	a0,a0,1960 # 80008140 <CONSOLE_STATUS+0x130>
    800039a0:	fffff097          	auipc	ra,0xfffff
    800039a4:	fec080e7          	jalr	-20(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800039a8:	ffffe097          	auipc	ra,0xffffe
    800039ac:	658080e7          	jalr	1624(ra) # 80002000 <_ZN3TCB8dispatchEv>
    800039b0:	d71ff06f          	j	80003720 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

00000000800039b4 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    800039b4:	fd010113          	addi	sp,sp,-48
    800039b8:	02113423          	sd	ra,40(sp)
    800039bc:	02813023          	sd	s0,32(sp)
    800039c0:	00913c23          	sd	s1,24(sp)
    800039c4:	01213823          	sd	s2,16(sp)
    800039c8:	01313423          	sd	s3,8(sp)
    800039cc:	03010413          	addi	s0,sp,48
    800039d0:	00050913          	mv	s2,a0
    800039d4:	00058493          	mv	s1,a1
    800039d8:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    800039dc:	00058e63          	beqz	a1,800039f8 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    800039e0:	04000513          	li	a0,64
    800039e4:	fffff097          	auipc	ra,0xfffff
    800039e8:	8a0080e7          	jalr	-1888(ra) # 80002284 <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    800039ec:	00051863          	bnez	a0,800039fc <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    800039f0:	00093023          	sd	zero,0(s2)
            return;
    800039f4:	0200006f          	j	80003a14 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    800039f8:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    800039fc:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80003a00:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80003a04:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80003a08:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80003a0c:	01100513          	li	a0,17

    asm("ecall");
    80003a10:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    80003a14:	02813083          	ld	ra,40(sp)
    80003a18:	02013403          	ld	s0,32(sp)
    80003a1c:	01813483          	ld	s1,24(sp)
    80003a20:	01013903          	ld	s2,16(sp)
    80003a24:	00813983          	ld	s3,8(sp)
    80003a28:	03010113          	addi	sp,sp,48
    80003a2c:	00008067          	ret

0000000080003a30 <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    80003a30:	ff010113          	addi	sp,sp,-16
    80003a34:	00813423          	sd	s0,8(sp)
    80003a38:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80003a3c:	01200513          	li	a0,18

    asm("ecall");
    80003a40:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    80003a44:	00813403          	ld	s0,8(sp)
    80003a48:	01010113          	addi	sp,sp,16
    80003a4c:	00008067          	ret

0000000080003a50 <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    80003a50:	ff010113          	addi	sp,sp,-16
    80003a54:	00813423          	sd	s0,8(sp)
    80003a58:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80003a5c:	01300513          	li	a0,19

    asm("ecall");
    80003a60:	00000073          	ecall
}
    80003a64:	00813403          	ld	s0,8(sp)
    80003a68:	01010113          	addi	sp,sp,16
    80003a6c:	00008067          	ret

0000000080003a70 <_ZN5RiscV11putcWrapperEPv>:
{
    80003a70:	fe010113          	addi	sp,sp,-32
    80003a74:	00113c23          	sd	ra,24(sp)
    80003a78:	00813823          	sd	s0,16(sp)
    80003a7c:	02010413          	addi	s0,sp,32
    80003a80:	00c0006f          	j	80003a8c <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    80003a84:	00000097          	auipc	ra,0x0
    80003a88:	fcc080e7          	jalr	-52(ra) # 80003a50 <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    80003a8c:	00007797          	auipc	a5,0x7
    80003a90:	44c7b783          	ld	a5,1100(a5) # 8000aed8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003a94:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003a98:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003a9c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003aa0:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003aa4:	0207f793          	andi	a5,a5,32
    80003aa8:	fc078ee3          	beqz	a5,80003a84 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003aac:	fffff097          	auipc	ra,0xfffff
    80003ab0:	06c080e7          	jalr	108(ra) # 80002b18 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003ab4:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003ab8:	00007797          	auipc	a5,0x7
    80003abc:	4187b783          	ld	a5,1048(a5) # 8000aed0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003ac0:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003ac4:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003ac8:	fef44783          	lbu	a5,-17(s0)
    80003acc:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003ad0:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003ad4:	00007797          	auipc	a5,0x7
    80003ad8:	49c7b783          	ld	a5,1180(a5) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003adc:	0007b783          	ld	a5,0(a5)
    80003ae0:	fa0786e3          	beqz	a5,80003a8c <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003ae4:	fff78793          	addi	a5,a5,-1
    80003ae8:	00007717          	auipc	a4,0x7
    80003aec:	48873703          	ld	a4,1160(a4) # 8000af70 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003af0:	00f73023          	sd	a5,0(a4)
    80003af4:	f99ff06f          	j	80003a8c <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003af8 <_ZN5RiscV6getPMTEv>:

    RiscV::mapConsoleRegisters(uPMT);
    RiscV::ms_sstatus(1<<18);
}

void* RiscV::getPMT(){
    80003af8:	ff010113          	addi	sp,sp,-16
    80003afc:	00113423          	sd	ra,8(sp)
    80003b00:	00813023          	sd	s0,0(sp)
    80003b04:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    80003b08:	00100513          	li	a0,1
    80003b0c:	ffffe097          	auipc	ra,0xffffe
    80003b10:	1d0080e7          	jalr	464(ra) # 80001cdc <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80003b14:	00000793          	li	a5,0
    80003b18:	1ff00713          	li	a4,511
    80003b1c:	00f74c63          	blt	a4,a5,80003b34 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    80003b20:	00379713          	slli	a4,a5,0x3
    80003b24:	00e50733          	add	a4,a0,a4
    80003b28:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    80003b2c:	0017879b          	addiw	a5,a5,1
    80003b30:	fe9ff06f          	j	80003b18 <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    80003b34:	00813083          	ld	ra,8(sp)
    80003b38:	00013403          	ld	s0,0(sp)
    80003b3c:	01010113          	addi	sp,sp,16
    80003b40:	00008067          	ret

0000000080003b44 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    80003b44:	fc010113          	addi	sp,sp,-64
    80003b48:	02113c23          	sd	ra,56(sp)
    80003b4c:	02813823          	sd	s0,48(sp)
    80003b50:	02913423          	sd	s1,40(sp)
    80003b54:	03213023          	sd	s2,32(sp)
    80003b58:	01313c23          	sd	s3,24(sp)
    80003b5c:	01413823          	sd	s4,16(sp)
    80003b60:	01513423          	sd	s5,8(sp)
    80003b64:	04010413          	addi	s0,sp,64
    80003b68:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    80003b6c:	01e5d793          	srli	a5,a1,0x1e
    80003b70:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    80003b74:	0155d913          	srli	s2,a1,0x15
    80003b78:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    80003b7c:	00c5d493          	srli	s1,a1,0xc
    80003b80:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80003b84:	00379793          	slli	a5,a5,0x3
    80003b88:	00f50ab3          	add	s5,a0,a5
    80003b8c:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80003b90:	06078263          	beqz	a5,80003bf4 <_ZN5RiscV15handlePageFaultEPvmm+0xb0>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80003b94:	00a7d513          	srli	a0,a5,0xa
    80003b98:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    80003b9c:	00391913          	slli	s2,s2,0x3
    80003ba0:	01250933          	add	s2,a0,s2
    80003ba4:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    80003ba8:	06050463          	beqz	a0,80003c10 <_ZN5RiscV15handlePageFaultEPvmm+0xcc>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    80003bac:	00a55513          	srli	a0,a0,0xa
    80003bb0:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    80003bb4:	003a1a13          	slli	s4,s4,0x3
    80003bb8:	01450533          	add	a0,a0,s4
    80003bbc:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0) {
    80003bc0:	00079863          	bnez	a5,80003bd0 <_ZN5RiscV15handlePageFaultEPvmm+0x8c>
        ((uint64 *) pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    80003bc4:	00a49493          	slli	s1,s1,0xa
    80003bc8:	0134e9b3          	or	s3,s1,s3
    80003bcc:	01353023          	sd	s3,0(a0)
    }
}
    80003bd0:	03813083          	ld	ra,56(sp)
    80003bd4:	03013403          	ld	s0,48(sp)
    80003bd8:	02813483          	ld	s1,40(sp)
    80003bdc:	02013903          	ld	s2,32(sp)
    80003be0:	01813983          	ld	s3,24(sp)
    80003be4:	01013a03          	ld	s4,16(sp)
    80003be8:	00813a83          	ld	s5,8(sp)
    80003bec:	04010113          	addi	sp,sp,64
    80003bf0:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80003bf4:	00000097          	auipc	ra,0x0
    80003bf8:	f04080e7          	jalr	-252(ra) # 80003af8 <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    80003bfc:	00c55793          	srli	a5,a0,0xc
    80003c00:	00a79793          	slli	a5,a5,0xa
    80003c04:	0017e793          	ori	a5,a5,1
    80003c08:	00fab023          	sd	a5,0(s5)
    80003c0c:	f91ff06f          	j	80003b9c <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    80003c10:	00000097          	auipc	ra,0x0
    80003c14:	ee8080e7          	jalr	-280(ra) # 80003af8 <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    80003c18:	00c55793          	srli	a5,a0,0xc
    80003c1c:	00a79793          	slli	a5,a5,0xa
    80003c20:	0017e793          	ori	a5,a5,1
    80003c24:	00f93023          	sd	a5,0(s2)
    80003c28:	f8dff06f          	j	80003bb4 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

0000000080003c2c <_ZN5RiscV12buildSectionEPvmmm>:
void RiscV::buildSection(void *PMT, uint64 start, uint64 end, uint64 mask) {
    80003c2c:	fd010113          	addi	sp,sp,-48
    80003c30:	02113423          	sd	ra,40(sp)
    80003c34:	02813023          	sd	s0,32(sp)
    80003c38:	00913c23          	sd	s1,24(sp)
    80003c3c:	01213823          	sd	s2,16(sp)
    80003c40:	01313423          	sd	s3,8(sp)
    80003c44:	01413023          	sd	s4,0(sp)
    80003c48:	03010413          	addi	s0,sp,48
    80003c4c:	00050a13          	mv	s4,a0
    80003c50:	00058493          	mv	s1,a1
    80003c54:	00060913          	mv	s2,a2
    80003c58:	00068993          	mv	s3,a3
    for(uint64 i=start;i< end;i+=0x1000) {
    80003c5c:	0324f263          	bgeu	s1,s2,80003c80 <_ZN5RiscV12buildSectionEPvmmm+0x54>
        handlePageFault(PMT,i, mask);
    80003c60:	00098613          	mv	a2,s3
    80003c64:	00048593          	mv	a1,s1
    80003c68:	000a0513          	mv	a0,s4
    80003c6c:	00000097          	auipc	ra,0x0
    80003c70:	ed8080e7          	jalr	-296(ra) # 80003b44 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=start;i< end;i+=0x1000) {
    80003c74:	000017b7          	lui	a5,0x1
    80003c78:	00f484b3          	add	s1,s1,a5
    80003c7c:	fe1ff06f          	j	80003c5c <_ZN5RiscV12buildSectionEPvmmm+0x30>
}
    80003c80:	02813083          	ld	ra,40(sp)
    80003c84:	02013403          	ld	s0,32(sp)
    80003c88:	01813483          	ld	s1,24(sp)
    80003c8c:	01013903          	ld	s2,16(sp)
    80003c90:	00813983          	ld	s3,8(sp)
    80003c94:	00013a03          	ld	s4,0(sp)
    80003c98:	03010113          	addi	sp,sp,48
    80003c9c:	00008067          	ret

0000000080003ca0 <_ZN5RiscV19mapConsoleRegistersEPv>:

void RiscV::mapConsoleRegisters(void *PMT) {
    80003ca0:	fe010113          	addi	sp,sp,-32
    80003ca4:	00113c23          	sd	ra,24(sp)
    80003ca8:	00813823          	sd	s0,16(sp)
    80003cac:	00913423          	sd	s1,8(sp)
    80003cb0:	02010413          	addi	s0,sp,32
    80003cb4:	00050493          	mv	s1,a0
    handlePageFault(PMT, (uint64)CONSOLE_RX_DATA,0xf);
    80003cb8:	00f00613          	li	a2,15
    80003cbc:	00007797          	auipc	a5,0x7
    80003cc0:	2147b783          	ld	a5,532(a5) # 8000aed0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003cc4:	0007b583          	ld	a1,0(a5)
    80003cc8:	00000097          	auipc	ra,0x0
    80003ccc:	e7c080e7          	jalr	-388(ra) # 80003b44 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_TX_DATA,0xf);
    80003cd0:	00f00613          	li	a2,15
    80003cd4:	00007797          	auipc	a5,0x7
    80003cd8:	2447b783          	ld	a5,580(a5) # 8000af18 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003cdc:	0007b583          	ld	a1,0(a5)
    80003ce0:	00048513          	mv	a0,s1
    80003ce4:	00000097          	auipc	ra,0x0
    80003ce8:	e60080e7          	jalr	-416(ra) # 80003b44 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_STATUS,0xf);
    80003cec:	00f00613          	li	a2,15
    80003cf0:	00007797          	auipc	a5,0x7
    80003cf4:	1e87b783          	ld	a5,488(a5) # 8000aed8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003cf8:	0007b583          	ld	a1,0(a5)
    80003cfc:	00048513          	mv	a0,s1
    80003d00:	00000097          	auipc	ra,0x0
    80003d04:	e44080e7          	jalr	-444(ra) # 80003b44 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)0xc201004,0xf);
    80003d08:	00f00613          	li	a2,15
    80003d0c:	0c2015b7          	lui	a1,0xc201
    80003d10:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    80003d14:	00048513          	mv	a0,s1
    80003d18:	00000097          	auipc	ra,0x0
    80003d1c:	e2c080e7          	jalr	-468(ra) # 80003b44 <_ZN5RiscV15handlePageFaultEPvmm>
    80003d20:	01813083          	ld	ra,24(sp)
    80003d24:	01013403          	ld	s0,16(sp)
    80003d28:	00813483          	ld	s1,8(sp)
    80003d2c:	02010113          	addi	sp,sp,32
    80003d30:	00008067          	ret

0000000080003d34 <_ZN5RiscV14buildKernelPMTEv>:
void RiscV::buildKernelPMT() {
    80003d34:	fd010113          	addi	sp,sp,-48
    80003d38:	02113423          	sd	ra,40(sp)
    80003d3c:	02813023          	sd	s0,32(sp)
    80003d40:	00913c23          	sd	s1,24(sp)
    80003d44:	01213823          	sd	s2,16(sp)
    80003d48:	01313423          	sd	s3,8(sp)
    80003d4c:	01413023          	sd	s4,0(sp)
    80003d50:	03010413          	addi	s0,sp,48
    RiscV::kPMT = RiscV::getPMT();
    80003d54:	00000097          	auipc	ra,0x0
    80003d58:	da4080e7          	jalr	-604(ra) # 80003af8 <_ZN5RiscV6getPMTEv>
    80003d5c:	00007497          	auipc	s1,0x7
    80003d60:	43c48493          	addi	s1,s1,1084 # 8000b198 <_ZN5RiscV16userMainFinishedE>
    80003d64:	00a4b823          	sd	a0,16(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003d68:	00007797          	auipc	a5,0x7
    80003d6c:	1987b783          	ld	a5,408(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003d70:	0007b903          	ld	s2,0(a5)
    80003d74:	00c91913          	slli	s2,s2,0xc
    80003d78:	00007797          	auipc	a5,0x7
    80003d7c:	1987b783          	ld	a5,408(a5) # 8000af10 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003d80:	0007b783          	ld	a5,0(a5)
    80003d84:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(kPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80003d88:	00007a17          	auipc	s4,0x7
    80003d8c:	160a3a03          	ld	s4,352(s4) # 8000aee8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003d90:	00b00693          	li	a3,11
    80003d94:	000a0613          	mv	a2,s4
    80003d98:	00100593          	li	a1,1
    80003d9c:	01f59593          	slli	a1,a1,0x1f
    80003da0:	00000097          	auipc	ra,0x0
    80003da4:	e8c080e7          	jalr	-372(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80003da8:	00007997          	auipc	s3,0x7
    80003dac:	1e09b983          	ld	s3,480(s3) # 8000af88 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003db0:	00700693          	li	a3,7
    80003db4:	00098613          	mv	a2,s3
    80003db8:	000a0593          	mv	a1,s4
    80003dbc:	0104b503          	ld	a0,16(s1)
    80003dc0:	00000097          	auipc	ra,0x0
    80003dc4:	e6c080e7          	jalr	-404(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80003dc8:	00007a17          	auipc	s4,0x7
    80003dcc:	1e0a3a03          	ld	s4,480(s4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80003dd0:	01b00693          	li	a3,27
    80003dd4:	000a0613          	mv	a2,s4
    80003dd8:	00098593          	mv	a1,s3
    80003ddc:	0104b503          	ld	a0,16(s1)
    80003de0:	00000097          	auipc	ra,0x0
    80003de4:	e4c080e7          	jalr	-436(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80003de8:	00007997          	auipc	s3,0x7
    80003dec:	1109b983          	ld	s3,272(s3) # 8000aef8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003df0:	01700693          	li	a3,23
    80003df4:	00098613          	mv	a2,s3
    80003df8:	000a0593          	mv	a1,s4
    80003dfc:	0104b503          	ld	a0,16(s1)
    80003e00:	00000097          	auipc	ra,0x0
    80003e04:	e2c080e7          	jalr	-468(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_END, bEnd, 0x7);
    80003e08:	00700693          	li	a3,7
    80003e0c:	00090613          	mv	a2,s2
    80003e10:	00098593          	mv	a1,s3
    80003e14:	0104b503          	ld	a0,16(s1)
    80003e18:	00000097          	auipc	ra,0x0
    80003e1c:	e14080e7          	jalr	-492(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, bEnd, HEAP_END, 0x17);
    80003e20:	01700693          	li	a3,23
    80003e24:	00007797          	auipc	a5,0x7
    80003e28:	1747b783          	ld	a5,372(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80003e2c:	0007b603          	ld	a2,0(a5)
    80003e30:	00090593          	mv	a1,s2
    80003e34:	0104b503          	ld	a0,16(s1)
    80003e38:	00000097          	auipc	ra,0x0
    80003e3c:	df4080e7          	jalr	-524(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(kPMT);
    80003e40:	0104b503          	ld	a0,16(s1)
    80003e44:	00000097          	auipc	ra,0x0
    80003e48:	e5c080e7          	jalr	-420(ra) # 80003ca0 <_ZN5RiscV19mapConsoleRegistersEPv>
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003e4c:	000407b7          	lui	a5,0x40
    80003e50:	1007a073          	csrs	sstatus,a5
}
    80003e54:	02813083          	ld	ra,40(sp)
    80003e58:	02013403          	ld	s0,32(sp)
    80003e5c:	01813483          	ld	s1,24(sp)
    80003e60:	01013903          	ld	s2,16(sp)
    80003e64:	00813983          	ld	s3,8(sp)
    80003e68:	00013a03          	ld	s4,0(sp)
    80003e6c:	03010113          	addi	sp,sp,48
    80003e70:	00008067          	ret

0000000080003e74 <_ZN5RiscV12buildUserPMTEv>:
void RiscV::buildUserPMT() {
    80003e74:	fd010113          	addi	sp,sp,-48
    80003e78:	02113423          	sd	ra,40(sp)
    80003e7c:	02813023          	sd	s0,32(sp)
    80003e80:	00913c23          	sd	s1,24(sp)
    80003e84:	01213823          	sd	s2,16(sp)
    80003e88:	01313423          	sd	s3,8(sp)
    80003e8c:	01413023          	sd	s4,0(sp)
    80003e90:	03010413          	addi	s0,sp,48
    RiscV::uPMT = RiscV::getPMT();
    80003e94:	00000097          	auipc	ra,0x0
    80003e98:	c64080e7          	jalr	-924(ra) # 80003af8 <_ZN5RiscV6getPMTEv>
    80003e9c:	00007497          	auipc	s1,0x7
    80003ea0:	2fc48493          	addi	s1,s1,764 # 8000b198 <_ZN5RiscV16userMainFinishedE>
    80003ea4:	00a4bc23          	sd	a0,24(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003ea8:	00007797          	auipc	a5,0x7
    80003eac:	0587b783          	ld	a5,88(a5) # 8000af00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003eb0:	0007b903          	ld	s2,0(a5)
    80003eb4:	00c91913          	slli	s2,s2,0xc
    80003eb8:	00007797          	auipc	a5,0x7
    80003ebc:	0587b783          	ld	a5,88(a5) # 8000af10 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003ec0:	0007b783          	ld	a5,0(a5)
    80003ec4:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(uPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80003ec8:	00007a17          	auipc	s4,0x7
    80003ecc:	020a3a03          	ld	s4,32(s4) # 8000aee8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003ed0:	00b00693          	li	a3,11
    80003ed4:	000a0613          	mv	a2,s4
    80003ed8:	00100593          	li	a1,1
    80003edc:	01f59593          	slli	a1,a1,0x1f
    80003ee0:	00000097          	auipc	ra,0x0
    80003ee4:	d4c080e7          	jalr	-692(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80003ee8:	00007997          	auipc	s3,0x7
    80003eec:	0a09b983          	ld	s3,160(s3) # 8000af88 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003ef0:	00700693          	li	a3,7
    80003ef4:	00098613          	mv	a2,s3
    80003ef8:	000a0593          	mv	a1,s4
    80003efc:	0184b503          	ld	a0,24(s1)
    80003f00:	00000097          	auipc	ra,0x0
    80003f04:	d2c080e7          	jalr	-724(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80003f08:	00007a17          	auipc	s4,0x7
    80003f0c:	0a0a3a03          	ld	s4,160(s4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80003f10:	01b00693          	li	a3,27
    80003f14:	000a0613          	mv	a2,s4
    80003f18:	00098593          	mv	a1,s3
    80003f1c:	0184b503          	ld	a0,24(s1)
    80003f20:	00000097          	auipc	ra,0x0
    80003f24:	d0c080e7          	jalr	-756(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80003f28:	00007997          	auipc	s3,0x7
    80003f2c:	fd09b983          	ld	s3,-48(s3) # 8000aef8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003f30:	01700693          	li	a3,23
    80003f34:	00098613          	mv	a2,s3
    80003f38:	000a0593          	mv	a1,s4
    80003f3c:	0184b503          	ld	a0,24(s1)
    80003f40:	00000097          	auipc	ra,0x0
    80003f44:	cec080e7          	jalr	-788(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_END, bEnd, 0x7);
    80003f48:	00700693          	li	a3,7
    80003f4c:	00090613          	mv	a2,s2
    80003f50:	00098593          	mv	a1,s3
    80003f54:	0184b503          	ld	a0,24(s1)
    80003f58:	00000097          	auipc	ra,0x0
    80003f5c:	cd4080e7          	jalr	-812(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, bEnd, HEAP_END, 0x17);
    80003f60:	01700693          	li	a3,23
    80003f64:	00007797          	auipc	a5,0x7
    80003f68:	0347b783          	ld	a5,52(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80003f6c:	0007b603          	ld	a2,0(a5)
    80003f70:	00090593          	mv	a1,s2
    80003f74:	0184b503          	ld	a0,24(s1)
    80003f78:	00000097          	auipc	ra,0x0
    80003f7c:	cb4080e7          	jalr	-844(ra) # 80003c2c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(uPMT);
    80003f80:	0184b503          	ld	a0,24(s1)
    80003f84:	00000097          	auipc	ra,0x0
    80003f88:	d1c080e7          	jalr	-740(ra) # 80003ca0 <_ZN5RiscV19mapConsoleRegistersEPv>
    80003f8c:	000407b7          	lui	a5,0x40
    80003f90:	1007a073          	csrs	sstatus,a5
}
    80003f94:	02813083          	ld	ra,40(sp)
    80003f98:	02013403          	ld	s0,32(sp)
    80003f9c:	01813483          	ld	s1,24(sp)
    80003fa0:	01013903          	ld	s2,16(sp)
    80003fa4:	00813983          	ld	s3,8(sp)
    80003fa8:	00013a03          	ld	s4,0(sp)
    80003fac:	03010113          	addi	sp,sp,48
    80003fb0:	00008067          	ret

0000000080003fb4 <_ZN5RiscV10initializeEv>:
void RiscV::initialize(){
    80003fb4:	ff010113          	addi	sp,sp,-16
    80003fb8:	00113423          	sd	ra,8(sp)
    80003fbc:	00813023          	sd	s0,0(sp)
    80003fc0:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003fc4:	00007797          	auipc	a5,0x7
    80003fc8:	f947b783          	ld	a5,-108(a5) # 8000af58 <_GLOBAL_OFFSET_TABLE_+0x90>
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80003fcc:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80003fd0:	00007797          	auipc	a5,0x7
    80003fd4:	f107b783          	ld	a5,-240(a5) # 8000aee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003fd8:	0007b503          	ld	a0,0(a5)
    80003fdc:	00c55513          	srli	a0,a0,0xc
    80003fe0:	00250513          	addi	a0,a0,2
    80003fe4:	000015b7          	lui	a1,0x1
    80003fe8:	00c51513          	slli	a0,a0,0xc
    80003fec:	00000097          	auipc	ra,0x0
    80003ff0:	32c080e7          	jalr	812(ra) # 80004318 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80003ff4:	ffffe097          	auipc	ra,0xffffe
    80003ff8:	210080e7          	jalr	528(ra) # 80002204 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80003ffc:	00000097          	auipc	ra,0x0
    80004000:	108080e7          	jalr	264(ra) # 80004104 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80004004:	ffffe097          	auipc	ra,0xffffe
    80004008:	0ac080e7          	jalr	172(ra) # 800020b0 <_ZN3TCB10initializeEv>
    SCB::initialize();
    8000400c:	ffffd097          	auipc	ra,0xffffd
    80004010:	610080e7          	jalr	1552(ra) # 8000161c <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80004014:	ffffe097          	auipc	ra,0xffffe
    80004018:	69c080e7          	jalr	1692(ra) # 800026b0 <_ZN11ConsoleUtil10initializeEv>
    RiscV::buildKernelPMT();
    8000401c:	00000097          	auipc	ra,0x0
    80004020:	d18080e7          	jalr	-744(ra) # 80003d34 <_ZN5RiscV14buildKernelPMTEv>
    RiscV::buildUserPMT();
    80004024:	00000097          	auipc	ra,0x0
    80004028:	e50080e7          	jalr	-432(ra) # 80003e74 <_ZN5RiscV12buildUserPMTEv>
    RiscV::initialized = true;
    8000402c:	00007797          	auipc	a5,0x7
    80004030:	16c78793          	addi	a5,a5,364 # 8000b198 <_ZN5RiscV16userMainFinishedE>
    80004034:	00100713          	li	a4,1
    80004038:	02e78023          	sb	a4,32(a5)
    RiscV::startVirtualMemory(RiscV::kPMT);
    8000403c:	0107b783          	ld	a5,16(a5)
inline void RiscV::disableTimerInterrupts(){
    RiscV::mc_sie(SIP_SSIE);
}

inline void RiscV::startVirtualMemory(void* PMT) {
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80004040:	00c7d793          	srli	a5,a5,0xc
    80004044:	fff00713          	li	a4,-1
    80004048:	03f71713          	slli	a4,a4,0x3f
    8000404c:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80004050:	18079073          	csrw	satp,a5
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80004054:	00200793          	li	a5,2
    80004058:	1047a073          	csrs	sie,a5
    8000405c:	20000713          	li	a4,512
    80004060:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80004064:	1007a073          	csrs	sstatus,a5
}
    80004068:	00813083          	ld	ra,8(sp)
    8000406c:	00013403          	ld	s0,0(sp)
    80004070:	01010113          	addi	sp,sp,16
    80004074:	00008067          	ret

0000000080004078 <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/kernel/utility.hpp"

char* strcpy(const char* src, char* dst){
    80004078:	ff010113          	addi	sp,sp,-16
    8000407c:	00813423          	sd	s0,8(sp)
    80004080:	01010413          	addi	s0,sp,16
    80004084:	00050793          	mv	a5,a0
    80004088:	00058513          	mv	a0,a1
    while(*src != '\0')
    8000408c:	0007c703          	lbu	a4,0(a5)
    80004090:	00070a63          	beqz	a4,800040a4 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004094:	00178793          	addi	a5,a5,1
    80004098:	00e50023          	sb	a4,0(a0)
    8000409c:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    800040a0:	fedff06f          	j	8000408c <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    800040a4:	00e50023          	sb	a4,0(a0)
    return dst;
}
    800040a8:	00813403          	ld	s0,8(sp)
    800040ac:	01010113          	addi	sp,sp,16
    800040b0:	00008067          	ret

00000000800040b4 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    800040b4:	fe010113          	addi	sp,sp,-32
    800040b8:	00113c23          	sd	ra,24(sp)
    800040bc:	00813823          	sd	s0,16(sp)
    800040c0:	00913423          	sd	s1,8(sp)
    800040c4:	02010413          	addi	s0,sp,32
    800040c8:	00050493          	mv	s1,a0
    800040cc:	00058513          	mv	a0,a1
    char *dest = dst;
    800040d0:	00048593          	mv	a1,s1
    while(*dest != '\0')
    800040d4:	0005c783          	lbu	a5,0(a1) # 1000 <_entry-0x7ffff000>
    800040d8:	00078663          	beqz	a5,800040e4 <_Z6strcatPcPKc+0x30>
        dest++;
    800040dc:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    800040e0:	ff5ff06f          	j	800040d4 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    800040e4:	00000097          	auipc	ra,0x0
    800040e8:	f94080e7          	jalr	-108(ra) # 80004078 <_Z6strcpyPKcPc>
    return dst;
    800040ec:	00048513          	mv	a0,s1
    800040f0:	01813083          	ld	ra,24(sp)
    800040f4:	01013403          	ld	s0,16(sp)
    800040f8:	00813483          	ld	s1,8(sp)
    800040fc:	02010113          	addi	sp,sp,32
    80004100:	00008067          	ret

0000000080004104 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004104:	ff010113          	addi	sp,sp,-16
    80004108:	00813423          	sd	s0,8(sp)
    8000410c:	01010413          	addi	s0,sp,16
}
    80004110:	00813403          	ld	s0,8(sp)
    80004114:	01010113          	addi	sp,sp,16
    80004118:	00008067          	ret

000000008000411c <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    8000411c:	ff010113          	addi	sp,sp,-16
    80004120:	00813423          	sd	s0,8(sp)
    80004124:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004128:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    8000412c:	00007797          	auipc	a5,0x7
    80004130:	0947b783          	ld	a5,148(a5) # 8000b1c0 <_ZN9Scheduler9readyHeadE>
    80004134:	02078263          	beqz	a5,80004158 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004138:	00007797          	auipc	a5,0x7
    8000413c:	0907b783          	ld	a5,144(a5) # 8000b1c8 <_ZN9Scheduler9readyTailE>
    80004140:	04a7b423          	sd	a0,72(a5)
    80004144:	00007797          	auipc	a5,0x7
    80004148:	08a7b223          	sd	a0,132(a5) # 8000b1c8 <_ZN9Scheduler9readyTailE>
}
    8000414c:	00813403          	ld	s0,8(sp)
    80004150:	01010113          	addi	sp,sp,16
    80004154:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004158:	00007797          	auipc	a5,0x7
    8000415c:	06a7b423          	sd	a0,104(a5) # 8000b1c0 <_ZN9Scheduler9readyHeadE>
    80004160:	fe5ff06f          	j	80004144 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004164 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004164:	ff010113          	addi	sp,sp,-16
    80004168:	00813423          	sd	s0,8(sp)
    8000416c:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004170:	00007517          	auipc	a0,0x7
    80004174:	05053503          	ld	a0,80(a0) # 8000b1c0 <_ZN9Scheduler9readyHeadE>
    80004178:	00050a63          	beqz	a0,8000418c <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    8000417c:	04853783          	ld	a5,72(a0)
    80004180:	00007717          	auipc	a4,0x7
    80004184:	04f73023          	sd	a5,64(a4) # 8000b1c0 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004188:	04053423          	sd	zero,72(a0)
    return tmp;
}
    8000418c:	00813403          	ld	s0,8(sp)
    80004190:	01010113          	addi	sp,sp,16
    80004194:	00008067          	ret

0000000080004198 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004198:	ff010113          	addi	sp,sp,-16
    8000419c:	00813423          	sd	s0,8(sp)
    800041a0:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    800041a4:	00007797          	auipc	a5,0x7
    800041a8:	02c7b783          	ld	a5,44(a5) # 8000b1d0 <_ZN9Scheduler12sleepingHeadE>
    800041ac:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800041b0:	00078e63          	beqz	a5,800041cc <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    800041b4:	0587b683          	ld	a3,88(a5)
    800041b8:	05853703          	ld	a4,88(a0)
    800041bc:	00d76863          	bltu	a4,a3,800041cc <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800041c0:	00078613          	mv	a2,a5
    800041c4:	0487b783          	ld	a5,72(a5)
    800041c8:	fe9ff06f          	j	800041b0 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    800041cc:	04f53423          	sd	a5,72(a0)
    if(prev)
    800041d0:	00060a63          	beqz	a2,800041e4 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    800041d4:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    800041d8:	00813403          	ld	s0,8(sp)
    800041dc:	01010113          	addi	sp,sp,16
    800041e0:	00008067          	ret
        sleepingHead = t;
    800041e4:	00007797          	auipc	a5,0x7
    800041e8:	fea7b623          	sd	a0,-20(a5) # 8000b1d0 <_ZN9Scheduler12sleepingHeadE>
}
    800041ec:	fedff06f          	j	800041d8 <_ZN9Scheduler5sleepEP3TCB+0x40>

00000000800041f0 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    800041f0:	fe010113          	addi	sp,sp,-32
    800041f4:	00113c23          	sd	ra,24(sp)
    800041f8:	00813823          	sd	s0,16(sp)
    800041fc:	00913423          	sd	s1,8(sp)
    80004200:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004204:	00007497          	auipc	s1,0x7
    80004208:	fcc4b483          	ld	s1,-52(s1) # 8000b1d0 <_ZN9Scheduler12sleepingHeadE>
    8000420c:	02048c63          	beqz	s1,80004244 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004210:	0584b703          	ld	a4,88(s1)
    80004214:	00007797          	auipc	a5,0x7
    80004218:	d8c7b783          	ld	a5,-628(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    8000421c:	0007b783          	ld	a5,0(a5)
    80004220:	02e7e263          	bltu	a5,a4,80004244 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004224:	0484b783          	ld	a5,72(s1)
    80004228:	00007717          	auipc	a4,0x7
    8000422c:	faf73423          	sd	a5,-88(a4) # 8000b1d0 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004230:	00048513          	mv	a0,s1
    80004234:	00000097          	auipc	ra,0x0
    80004238:	ee8080e7          	jalr	-280(ra) # 8000411c <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    8000423c:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004240:	fc5ff06f          	j	80004204 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004244:	01813083          	ld	ra,24(sp)
    80004248:	01013403          	ld	s0,16(sp)
    8000424c:	00813483          	ld	s1,8(sp)
    80004250:	02010113          	addi	sp,sp,32
    80004254:	00008067          	ret

0000000080004258 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004258:	fe010113          	addi	sp,sp,-32
    8000425c:	00113c23          	sd	ra,24(sp)
    80004260:	00813823          	sd	s0,16(sp)
    80004264:	00913423          	sd	s1,8(sp)
    80004268:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    8000426c:	00007497          	auipc	s1,0x7
    80004270:	f544b483          	ld	s1,-172(s1) # 8000b1c0 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004274:	02048863          	beqz	s1,800042a4 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004278:	00000613          	li	a2,0
    8000427c:	01000593          	li	a1,16
    80004280:	0004851b          	sext.w	a0,s1
    80004284:	ffffe097          	auipc	ra,0xffffe
    80004288:	74c080e7          	jalr	1868(ra) # 800029d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000428c:	00004517          	auipc	a0,0x4
    80004290:	e8c50513          	addi	a0,a0,-372 # 80008118 <CONSOLE_STATUS+0x108>
    80004294:	ffffe097          	auipc	ra,0xffffe
    80004298:	6f8080e7          	jalr	1784(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    8000429c:	0484b483          	ld	s1,72(s1)
    while(iter){
    800042a0:	fd5ff06f          	j	80004274 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    800042a4:	01813083          	ld	ra,24(sp)
    800042a8:	01013403          	ld	s0,16(sp)
    800042ac:	00813483          	ld	s1,8(sp)
    800042b0:	02010113          	addi	sp,sp,32
    800042b4:	00008067          	ret

00000000800042b8 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    800042b8:	fe010113          	addi	sp,sp,-32
    800042bc:	00113c23          	sd	ra,24(sp)
    800042c0:	00813823          	sd	s0,16(sp)
    800042c4:	00913423          	sd	s1,8(sp)
    800042c8:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    800042cc:	00007497          	auipc	s1,0x7
    800042d0:	f044b483          	ld	s1,-252(s1) # 8000b1d0 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    800042d4:	02048863          	beqz	s1,80004304 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    800042d8:	00000613          	li	a2,0
    800042dc:	01000593          	li	a1,16
    800042e0:	0004851b          	sext.w	a0,s1
    800042e4:	0000b097          	auipc	ra,0xb
    800042e8:	b20080e7          	jalr	-1248(ra) # 8000ee04 <_Z8printIntiii>
        printString("\n");
    800042ec:	00004517          	auipc	a0,0x4
    800042f0:	e2c50513          	addi	a0,a0,-468 # 80008118 <CONSOLE_STATUS+0x108>
    800042f4:	0000b097          	auipc	ra,0xb
    800042f8:	978080e7          	jalr	-1672(ra) # 8000ec6c <_Z11printStringPKc>
        iter = iter->next;
    800042fc:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004300:	fd5ff06f          	j	800042d4 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004304:	01813083          	ld	ra,24(sp)
    80004308:	01013403          	ld	s0,16(sp)
    8000430c:	00813483          	ld	s1,8(sp)
    80004310:	02010113          	addi	sp,sp,32
    80004314:	00008067          	ret

0000000080004318 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/kernel/slab.hpp"

void kmem_init(void* space, int block_num){
    80004318:	ff010113          	addi	sp,sp,-16
    8000431c:	00113423          	sd	ra,8(sp)
    80004320:	00813023          	sd	s0,0(sp)
    80004324:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004328:	00001097          	auipc	ra,0x1
    8000432c:	b18080e7          	jalr	-1256(ra) # 80004e40 <_ZN13SlabAllocator10initializeEPvm>
}
    80004330:	00813083          	ld	ra,8(sp)
    80004334:	00013403          	ld	s0,0(sp)
    80004338:	01010113          	addi	sp,sp,16
    8000433c:	00008067          	ret

0000000080004340 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80004340:	ff010113          	addi	sp,sp,-16
    80004344:	00113423          	sd	ra,8(sp)
    80004348:	00813023          	sd	s0,0(sp)
    8000434c:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80004350:	00001097          	auipc	ra,0x1
    80004354:	9e4080e7          	jalr	-1564(ra) # 80004d34 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004358:	00813083          	ld	ra,8(sp)
    8000435c:	00013403          	ld	s0,0(sp)
    80004360:	01010113          	addi	sp,sp,16
    80004364:	00008067          	ret

0000000080004368 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80004368:	ff010113          	addi	sp,sp,-16
    8000436c:	00113423          	sd	ra,8(sp)
    80004370:	00813023          	sd	s0,0(sp)
    80004374:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80004378:	00000097          	auipc	ra,0x0
    8000437c:	78c080e7          	jalr	1932(ra) # 80004b04 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004380:	00813083          	ld	ra,8(sp)
    80004384:	00013403          	ld	s0,0(sp)
    80004388:	01010113          	addi	sp,sp,16
    8000438c:	00008067          	ret

0000000080004390 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80004390:	ff010113          	addi	sp,sp,-16
    80004394:	00113423          	sd	ra,8(sp)
    80004398:	00813023          	sd	s0,0(sp)
    8000439c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    800043a0:	00001097          	auipc	ra,0x1
    800043a4:	ce8080e7          	jalr	-792(ra) # 80005088 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    800043a8:	00813083          	ld	ra,8(sp)
    800043ac:	00013403          	ld	s0,0(sp)
    800043b0:	01010113          	addi	sp,sp,16
    800043b4:	00008067          	ret

00000000800043b8 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    800043b8:	fe010113          	addi	sp,sp,-32
    800043bc:	00113c23          	sd	ra,24(sp)
    800043c0:	00813823          	sd	s0,16(sp)
    800043c4:	02010413          	addi	s0,sp,32
    800043c8:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    800043cc:	fe840513          	addi	a0,s0,-24
    800043d0:	00001097          	auipc	ra,0x1
    800043d4:	e18080e7          	jalr	-488(ra) # 800051e8 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    800043d8:	01813083          	ld	ra,24(sp)
    800043dc:	01013403          	ld	s0,16(sp)
    800043e0:	02010113          	addi	sp,sp,32
    800043e4:	00008067          	ret

00000000800043e8 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    800043e8:	ff010113          	addi	sp,sp,-16
    800043ec:	00113423          	sd	ra,8(sp)
    800043f0:	00813023          	sd	s0,0(sp)
    800043f4:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    800043f8:	00000097          	auipc	ra,0x0
    800043fc:	254080e7          	jalr	596(ra) # 8000464c <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80004400:	00813083          	ld	ra,8(sp)
    80004404:	00013403          	ld	s0,0(sp)
    80004408:	01010113          	addi	sp,sp,16
    8000440c:	00008067          	ret

0000000080004410 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80004410:	ff010113          	addi	sp,sp,-16
    80004414:	00113423          	sd	ra,8(sp)
    80004418:	00813023          	sd	s0,0(sp)
    8000441c:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80004420:	00000097          	auipc	ra,0x0
    80004424:	068080e7          	jalr	104(ra) # 80004488 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80004428:	00813083          	ld	ra,8(sp)
    8000442c:	00013403          	ld	s0,0(sp)
    80004430:	01010113          	addi	sp,sp,16
    80004434:	00008067          	ret

0000000080004438 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80004438:	ff010113          	addi	sp,sp,-16
    8000443c:	00113423          	sd	ra,8(sp)
    80004440:	00813023          	sd	s0,0(sp)
    80004444:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80004448:	00001097          	auipc	ra,0x1
    8000444c:	84c080e7          	jalr	-1972(ra) # 80004c94 <_ZN13SlabAllocator14allocateBufferEm>
}
    80004450:	00813083          	ld	ra,8(sp)
    80004454:	00013403          	ld	s0,0(sp)
    80004458:	01010113          	addi	sp,sp,16
    8000445c:	00008067          	ret

0000000080004460 <_Z5kfreePKv>:

void kfree(const void* objp){
    80004460:	ff010113          	addi	sp,sp,-16
    80004464:	00113423          	sd	ra,8(sp)
    80004468:	00813023          	sd	s0,0(sp)
    8000446c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80004470:	00001097          	auipc	ra,0x1
    80004474:	d0c080e7          	jalr	-756(ra) # 8000517c <_ZN13SlabAllocator10freeBufferEPKv>
    80004478:	00813083          	ld	ra,8(sp)
    8000447c:	00013403          	ld	s0,0(sp)
    80004480:	01010113          	addi	sp,sp,16
    80004484:	00008067          	ret

0000000080004488 <_ZN13SlabAllocator11shrinkCacheEP5Cache>:
    deleteList(cache->emptyHead);
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    cache = nullptr;
}

int SlabAllocator::shrinkCache(Cache *cache) {
    80004488:	fe010113          	addi	sp,sp,-32
    8000448c:	00113c23          	sd	ra,24(sp)
    80004490:	00813823          	sd	s0,16(sp)
    80004494:	00913423          	sd	s1,8(sp)
    80004498:	01213023          	sd	s2,0(sp)
    8000449c:	02010413          	addi	s0,sp,32
    800044a0:	00050493          	mv	s1,a0
    int ret = 0;
    800044a4:	00000913          	li	s2,0
    while(cache->emptyHead){
    800044a8:	0604b503          	ld	a0,96(s1)
    800044ac:	02050463          	beqz	a0,800044d4 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x4c>
        Buddy::free(cache->emptyHead, cache->slabSize);
    800044b0:	0484b583          	ld	a1,72(s1)
    800044b4:	ffffd097          	auipc	ra,0xffffd
    800044b8:	750080e7          	jalr	1872(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
        ret += cache->emptyHead->totalNumOfSlots;
    800044bc:	0604b783          	ld	a5,96(s1)
    800044c0:	0187b703          	ld	a4,24(a5)
    800044c4:	0127093b          	addw	s2,a4,s2
        cache->emptyHead = cache->emptyHead->next;
    800044c8:	0087b783          	ld	a5,8(a5)
    800044cc:	06f4b023          	sd	a5,96(s1)
    while(cache->emptyHead){
    800044d0:	fd9ff06f          	j	800044a8 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x20>
    }
    return ret;
}
    800044d4:	00090513          	mv	a0,s2
    800044d8:	01813083          	ld	ra,24(sp)
    800044dc:	01013403          	ld	s0,16(sp)
    800044e0:	00813483          	ld	s1,8(sp)
    800044e4:	00013903          	ld	s2,0(sp)
    800044e8:	02010113          	addi	sp,sp,32
    800044ec:	00008067          	ret

00000000800044f0 <_ZN13SlabAllocator9printSlabEP4Slab>:

void SlabAllocator::printSlab(Slab *slab) {
    if(slab) {
    800044f0:	14050c63          	beqz	a0,80004648 <_ZN13SlabAllocator9printSlabEP4Slab+0x158>
void SlabAllocator::printSlab(Slab *slab) {
    800044f4:	fe010113          	addi	sp,sp,-32
    800044f8:	00113c23          	sd	ra,24(sp)
    800044fc:	00813823          	sd	s0,16(sp)
    80004500:	00913423          	sd	s1,8(sp)
    80004504:	01213023          	sd	s2,0(sp)
    80004508:	02010413          	addi	s0,sp,32
    8000450c:	00050913          	mv	s2,a0
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    80004510:	01000693          	li	a3,16
    80004514:	00004617          	auipc	a2,0x4
    80004518:	c0460613          	addi	a2,a2,-1020 # 80008118 <CONSOLE_STATUS+0x108>
    8000451c:	0005059b          	sext.w	a1,a0
    80004520:	00004517          	auipc	a0,0x4
    80004524:	e1050513          	addi	a0,a0,-496 # 80008330 <CONSOLE_STATUS+0x320>
    80004528:	ffffe097          	auipc	ra,0xffffe
    8000452c:	584080e7          	jalr	1412(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n",10);
    80004530:	00a00693          	li	a3,10
    80004534:	00004617          	auipc	a2,0x4
    80004538:	be460613          	addi	a2,a2,-1052 # 80008118 <CONSOLE_STATUS+0x108>
    8000453c:	01892583          	lw	a1,24(s2)
    80004540:	00004517          	auipc	a0,0x4
    80004544:	e0050513          	addi	a0,a0,-512 # 80008340 <CONSOLE_STATUS+0x330>
    80004548:	ffffe097          	auipc	ra,0xffffe
    8000454c:	564080e7          	jalr	1380(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n",10);
    80004550:	00a00693          	li	a3,10
    80004554:	00004617          	auipc	a2,0x4
    80004558:	bc460613          	addi	a2,a2,-1084 # 80008118 <CONSOLE_STATUS+0x108>
    8000455c:	01092583          	lw	a1,16(s2)
    80004560:	00004517          	auipc	a0,0x4
    80004564:	df850513          	addi	a0,a0,-520 # 80008358 <CONSOLE_STATUS+0x348>
    80004568:	ffffe097          	auipc	ra,0xffffe
    8000456c:	544080e7          	jalr	1348(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n",10);
    80004570:	00a00693          	li	a3,10
    80004574:	00004617          	auipc	a2,0x4
    80004578:	ba460613          	addi	a2,a2,-1116 # 80008118 <CONSOLE_STATUS+0x108>
    8000457c:	0b000593          	li	a1,176
    80004580:	00004517          	auipc	a0,0x4
    80004584:	df050513          	addi	a0,a0,-528 # 80008370 <CONSOLE_STATUS+0x360>
    80004588:	ffffe097          	auipc	ra,0xffffe
    8000458c:	524080e7          	jalr	1316(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    80004590:	01000693          	li	a3,16
    80004594:	00004617          	auipc	a2,0x4
    80004598:	b8460613          	addi	a2,a2,-1148 # 80008118 <CONSOLE_STATUS+0x108>
    8000459c:	0a092583          	lw	a1,160(s2)
    800045a0:	00004517          	auipc	a0,0x4
    800045a4:	de850513          	addi	a0,a0,-536 # 80008388 <CONSOLE_STATUS+0x378>
    800045a8:	ffffe097          	auipc	ra,0xffffe
    800045ac:	504080e7          	jalr	1284(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) (&slab->allocated), "\n");
    800045b0:	01000693          	li	a3,16
    800045b4:	00004617          	auipc	a2,0x4
    800045b8:	b6460613          	addi	a2,a2,-1180 # 80008118 <CONSOLE_STATUS+0x108>
    800045bc:	0209059b          	addiw	a1,s2,32
    800045c0:	00004517          	auipc	a0,0x4
    800045c4:	dd850513          	addi	a0,a0,-552 # 80008398 <CONSOLE_STATUS+0x388>
    800045c8:	ffffe097          	auipc	ra,0xffffe
    800045cc:	4e4080e7          	jalr	1252(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array: ");
    800045d0:	00004517          	auipc	a0,0x4
    800045d4:	de850513          	addi	a0,a0,-536 # 800083b8 <CONSOLE_STATUS+0x3a8>
    800045d8:	ffffe097          	auipc	ra,0xffffe
    800045dc:	3b4080e7          	jalr	948(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)/8; i++) {
    800045e0:	00000493          	li	s1,0
    800045e4:	02c0006f          	j	80004610 <_ZN13SlabAllocator9printSlabEP4Slab+0x120>
            ConsoleUtil::print("", slab->allocated[i], " ");
    800045e8:	009907b3          	add	a5,s2,s1
    800045ec:	01000693          	li	a3,16
    800045f0:	00004617          	auipc	a2,0x4
    800045f4:	e1860613          	addi	a2,a2,-488 # 80008408 <CONSOLE_STATUS+0x3f8>
    800045f8:	0207c583          	lbu	a1,32(a5)
    800045fc:	00004517          	auipc	a0,0x4
    80004600:	b7450513          	addi	a0,a0,-1164 # 80008170 <CONSOLE_STATUS+0x160>
    80004604:	ffffe097          	auipc	ra,0xffffe
    80004608:	4a8080e7          	jalr	1192(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)/8; i++) {
    8000460c:	00148493          	addi	s1,s1,1
    80004610:	01893783          	ld	a5,24(s2)
    80004614:	00778793          	addi	a5,a5,7
    80004618:	0037d793          	srli	a5,a5,0x3
    8000461c:	fcf4e6e3          	bltu	s1,a5,800045e8 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    80004620:	00004517          	auipc	a0,0x4
    80004624:	af850513          	addi	a0,a0,-1288 # 80008118 <CONSOLE_STATUS+0x108>
    80004628:	ffffe097          	auipc	ra,0xffffe
    8000462c:	364080e7          	jalr	868(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    80004630:	01813083          	ld	ra,24(sp)
    80004634:	01013403          	ld	s0,16(sp)
    80004638:	00813483          	ld	s1,8(sp)
    8000463c:	00013903          	ld	s2,0(sp)
    80004640:	02010113          	addi	sp,sp,32
    80004644:	00008067          	ret
    80004648:	00008067          	ret

000000008000464c <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    8000464c:	fe010113          	addi	sp,sp,-32
    80004650:	00113c23          	sd	ra,24(sp)
    80004654:	00813823          	sd	s0,16(sp)
    80004658:	00913423          	sd	s1,8(sp)
    8000465c:	01213023          	sd	s2,0(sp)
    80004660:	02010413          	addi	s0,sp,32
    80004664:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    80004668:	00004517          	auipc	a0,0x4
    8000466c:	d7050513          	addi	a0,a0,-656 # 800083d8 <CONSOLE_STATUS+0x3c8>
    80004670:	ffffe097          	auipc	ra,0xffffe
    80004674:	31c080e7          	jalr	796(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80004678:	00090513          	mv	a0,s2
    8000467c:	ffffe097          	auipc	ra,0xffffe
    80004680:	310080e7          	jalr	784(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80004684:	00004517          	auipc	a0,0x4
    80004688:	a9450513          	addi	a0,a0,-1388 # 80008118 <CONSOLE_STATUS+0x108>
    8000468c:	ffffe097          	auipc	ra,0xffffe
    80004690:	300080e7          	jalr	768(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80004694:	01000693          	li	a3,16
    80004698:	00004617          	auipc	a2,0x4
    8000469c:	a8060613          	addi	a2,a2,-1408 # 80008118 <CONSOLE_STATUS+0x108>
    800046a0:	0009059b          	sext.w	a1,s2
    800046a4:	00004517          	auipc	a0,0x4
    800046a8:	d4450513          	addi	a0,a0,-700 # 800083e8 <CONSOLE_STATUS+0x3d8>
    800046ac:	ffffe097          	auipc	ra,0xffffe
    800046b0:	400080e7          	jalr	1024(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n",10);
    800046b4:	00a00693          	li	a3,10
    800046b8:	00004617          	auipc	a2,0x4
    800046bc:	a6060613          	addi	a2,a2,-1440 # 80008118 <CONSOLE_STATUS+0x108>
    800046c0:	04892583          	lw	a1,72(s2)
    800046c4:	00004517          	auipc	a0,0x4
    800046c8:	d3450513          	addi	a0,a0,-716 # 800083f8 <CONSOLE_STATUS+0x3e8>
    800046cc:	ffffe097          	auipc	ra,0xffffe
    800046d0:	3e0080e7          	jalr	992(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n",10);
    800046d4:	00a00693          	li	a3,10
    800046d8:	00004617          	auipc	a2,0x4
    800046dc:	a4060613          	addi	a2,a2,-1472 # 80008118 <CONSOLE_STATUS+0x108>
    800046e0:	04092583          	lw	a1,64(s2)
    800046e4:	00004517          	auipc	a0,0x4
    800046e8:	d2c50513          	addi	a0,a0,-724 # 80008410 <CONSOLE_STATUS+0x400>
    800046ec:	ffffe097          	auipc	ra,0xffffe
    800046f0:	3c0080e7          	jalr	960(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800046f4:	01000693          	li	a3,16
    800046f8:	00004617          	auipc	a2,0x4
    800046fc:	a2060613          	addi	a2,a2,-1504 # 80008118 <CONSOLE_STATUS+0x108>
    80004700:	06092583          	lw	a1,96(s2)
    80004704:	00004517          	auipc	a0,0x4
    80004708:	d2450513          	addi	a0,a0,-732 # 80008428 <CONSOLE_STATUS+0x418>
    8000470c:	ffffe097          	auipc	ra,0xffffe
    80004710:	3a0080e7          	jalr	928(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>

    Slab* iter = cache->emptyHead;
    80004714:	06093483          	ld	s1,96(s2)
    while(iter){
    80004718:	02048663          	beqz	s1,80004744 <_ZN13SlabAllocator10printCacheEP5Cache+0xf8>
        ConsoleUtil::print("", (uint64)iter, " ");
    8000471c:	01000693          	li	a3,16
    80004720:	00004617          	auipc	a2,0x4
    80004724:	ce860613          	addi	a2,a2,-792 # 80008408 <CONSOLE_STATUS+0x3f8>
    80004728:	0004859b          	sext.w	a1,s1
    8000472c:	00004517          	auipc	a0,0x4
    80004730:	a4450513          	addi	a0,a0,-1468 # 80008170 <CONSOLE_STATUS+0x160>
    80004734:	ffffe097          	auipc	ra,0xffffe
    80004738:	378080e7          	jalr	888(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    8000473c:	0084b483          	ld	s1,8(s1)
    while(iter){
    80004740:	fd9ff06f          	j	80004718 <_ZN13SlabAllocator10printCacheEP5Cache+0xcc>
    }
    ConsoleUtil::printString("\n");
    80004744:	00004517          	auipc	a0,0x4
    80004748:	9d450513          	addi	a0,a0,-1580 # 80008118 <CONSOLE_STATUS+0x108>
    8000474c:	ffffe097          	auipc	ra,0xffffe
    80004750:	240080e7          	jalr	576(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80004754:	01000693          	li	a3,16
    80004758:	00004617          	auipc	a2,0x4
    8000475c:	9c060613          	addi	a2,a2,-1600 # 80008118 <CONSOLE_STATUS+0x108>
    80004760:	06892583          	lw	a1,104(s2)
    80004764:	00004517          	auipc	a0,0x4
    80004768:	cd450513          	addi	a0,a0,-812 # 80008438 <CONSOLE_STATUS+0x428>
    8000476c:	ffffe097          	auipc	ra,0xffffe
    80004770:	340080e7          	jalr	832(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->partialHead;
    80004774:	06893483          	ld	s1,104(s2)
    while(iter){
    80004778:	02048663          	beqz	s1,800047a4 <_ZN13SlabAllocator10printCacheEP5Cache+0x158>
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
    800047a0:	fd9ff06f          	j	80004778 <_ZN13SlabAllocator10printCacheEP5Cache+0x12c>
    }
    ConsoleUtil::printString("\n");
    800047a4:	00004517          	auipc	a0,0x4
    800047a8:	97450513          	addi	a0,a0,-1676 # 80008118 <CONSOLE_STATUS+0x108>
    800047ac:	ffffe097          	auipc	ra,0xffffe
    800047b0:	1e0080e7          	jalr	480(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    800047b4:	01000693          	li	a3,16
    800047b8:	00004617          	auipc	a2,0x4
    800047bc:	96060613          	addi	a2,a2,-1696 # 80008118 <CONSOLE_STATUS+0x108>
    800047c0:	07092583          	lw	a1,112(s2)
    800047c4:	00004517          	auipc	a0,0x4
    800047c8:	c8450513          	addi	a0,a0,-892 # 80008448 <CONSOLE_STATUS+0x438>
    800047cc:	ffffe097          	auipc	ra,0xffffe
    800047d0:	2e0080e7          	jalr	736(ra) # 80002aac <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->fullHead;
    800047d4:	07093483          	ld	s1,112(s2)
    while(iter){
    800047d8:	02048663          	beqz	s1,80004804 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
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
    80004800:	fd9ff06f          	j	800047d8 <_ZN13SlabAllocator10printCacheEP5Cache+0x18c>
    }
    ConsoleUtil::printString("\n");
    80004804:	00004517          	auipc	a0,0x4
    80004808:	91450513          	addi	a0,a0,-1772 # 80008118 <CONSOLE_STATUS+0x108>
    8000480c:	ffffe097          	auipc	ra,0xffffe
    80004810:	180080e7          	jalr	384(ra) # 8000298c <_ZN11ConsoleUtil11printStringEPKc>
}
    80004814:	01813083          	ld	ra,24(sp)
    80004818:	01013403          	ld	s0,16(sp)
    8000481c:	00813483          	ld	s1,8(sp)
    80004820:	00013903          	ld	s2,0(sp)
    80004824:	02010113          	addi	sp,sp,32
    80004828:	00008067          	ret

000000008000482c <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    8000482c:	ff010113          	addi	sp,sp,-16
    80004830:	00813423          	sd	s0,8(sp)
    80004834:	01010413          	addi	s0,sp,16
    slab->next = head;
    80004838:	00053783          	ld	a5,0(a0)
    8000483c:	00f5b423          	sd	a5,8(a1)
    if(head)
    80004840:	00078463          	beqz	a5,80004848 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    80004844:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    80004848:	0005b023          	sd	zero,0(a1)
    head = slab;
    8000484c:	00b53023          	sd	a1,0(a0)
}
    80004850:	00813403          	ld	s0,8(sp)
    80004854:	01010113          	addi	sp,sp,16
    80004858:	00008067          	ret

000000008000485c <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    8000485c:	fd010113          	addi	sp,sp,-48
    80004860:	02113423          	sd	ra,40(sp)
    80004864:	02813023          	sd	s0,32(sp)
    80004868:	00913c23          	sd	s1,24(sp)
    8000486c:	01213823          	sd	s2,16(sp)
    80004870:	01313423          	sd	s3,8(sp)
    80004874:	03010413          	addi	s0,sp,48
    80004878:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    8000487c:	04853503          	ld	a0,72(a0)
    80004880:	ffffd097          	auipc	ra,0xffffd
    80004884:	45c080e7          	jalr	1116(ra) # 80001cdc <_ZN5Buddy5allocEm>
    if(!slab)
    80004888:	0a050c63          	beqz	a0,80004940 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe4>
    8000488c:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80004890:	00050593          	mv	a1,a0
    80004894:	06098513          	addi	a0,s3,96
    80004898:	00000097          	auipc	ra,0x0
    8000489c:	f94080e7          	jalr	-108(ra) # 8000482c <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    800048a0:	0489b703          	ld	a4,72(s3)
    800048a4:	00100793          	li	a5,1
    800048a8:	00e797bb          	sllw	a5,a5,a4
    800048ac:	00c7979b          	slliw	a5,a5,0xc
    800048b0:	f5078793          	addi	a5,a5,-176
    800048b4:	0409b703          	ld	a4,64(s3)
    800048b8:	02e7d7b3          	divu	a5,a5,a4
    800048bc:	00f4b823          	sd	a5,16(s1)
    800048c0:	00f4bc23          	sd	a5,24(s1)
    if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
    800048c4:	40000713          	li	a4,1024
    800048c8:	00f77863          	bgeu	a4,a5,800048d8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x7c>
        slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    800048cc:	40000793          	li	a5,1024
    800048d0:	00f4b823          	sd	a5,16(s1)
    800048d4:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab));
    800048d8:	0b048793          	addi	a5,s1,176
    800048dc:	0af4b023          	sd	a5,160(s1)
    slab->parent = cache;
    800048e0:	0b34b423          	sd	s3,168(s1)
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)/8;i++)
    800048e4:	00000713          	li	a4,0
    800048e8:	0184b783          	ld	a5,24(s1)
    800048ec:	00778793          	addi	a5,a5,7
    800048f0:	0037d793          	srli	a5,a5,0x3
    800048f4:	00f77a63          	bgeu	a4,a5,80004908 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xac>
        slab->allocated[i] = 0;
    800048f8:	00e487b3          	add	a5,s1,a4
    800048fc:	02078023          	sb	zero,32(a5)
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)/8;i++)
    80004900:	00170713          	addi	a4,a4,1
    80004904:	fe5ff06f          	j	800048e8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x8c>
    if(cache->ctor) {
    80004908:	0509b783          	ld	a5,80(s3)
    8000490c:	02078e63          	beqz	a5,80004948 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xec>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004910:	00000913          	li	s2,0
    80004914:	0184b783          	ld	a5,24(s1)
    80004918:	02f97c63          	bgeu	s2,a5,80004950 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf4>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    8000491c:	0509b703          	ld	a4,80(s3)
    80004920:	0a04b503          	ld	a0,160(s1)
    80004924:	0a84b783          	ld	a5,168(s1)
    80004928:	0407b783          	ld	a5,64(a5)
    8000492c:	032787b3          	mul	a5,a5,s2
    80004930:	00f50533          	add	a0,a0,a5
    80004934:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004938:	00190913          	addi	s2,s2,1
    8000493c:	fd9ff06f          	j	80004914 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xb8>
        return false;
    80004940:	00000513          	li	a0,0
    80004944:	0100006f          	j	80004954 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf8>
    return true;
    80004948:	00100513          	li	a0,1
    8000494c:	0080006f          	j	80004954 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf8>
    80004950:	00100513          	li	a0,1
}
    80004954:	02813083          	ld	ra,40(sp)
    80004958:	02013403          	ld	s0,32(sp)
    8000495c:	01813483          	ld	s1,24(sp)
    80004960:	01013903          	ld	s2,16(sp)
    80004964:	00813983          	ld	s3,8(sp)
    80004968:	03010113          	addi	sp,sp,48
    8000496c:	00008067          	ret

0000000080004970 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80004970:	ff010113          	addi	sp,sp,-16
    80004974:	00813423          	sd	s0,8(sp)
    80004978:	01010413          	addi	s0,sp,16
    if(slab == head)
    8000497c:	00053783          	ld	a5,0(a0)
    80004980:	02b78c63          	beq	a5,a1,800049b8 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80004984:	0085b783          	ld	a5,8(a1)
    80004988:	00078663          	beqz	a5,80004994 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    8000498c:	0005b703          	ld	a4,0(a1)
    80004990:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80004994:	0005b783          	ld	a5,0(a1)
    80004998:	00078663          	beqz	a5,800049a4 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    8000499c:	0085b703          	ld	a4,8(a1)
    800049a0:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    800049a4:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    800049a8:	0005b423          	sd	zero,8(a1)
}
    800049ac:	00813403          	ld	s0,8(sp)
    800049b0:	01010113          	addi	sp,sp,16
    800049b4:	00008067          	ret
        head = slab->next;
    800049b8:	0085b783          	ld	a5,8(a1)
    800049bc:	00f53023          	sd	a5,0(a0)
    800049c0:	fc5ff06f          	j	80004984 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

00000000800049c4 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    800049c4:	fe010113          	addi	sp,sp,-32
    800049c8:	00113c23          	sd	ra,24(sp)
    800049cc:	00813823          	sd	s0,16(sp)
    800049d0:	00913423          	sd	s1,8(sp)
    800049d4:	01213023          	sd	s2,0(sp)
    800049d8:	02010413          	addi	s0,sp,32
    800049dc:	00058913          	mv	s2,a1
    800049e0:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    800049e4:	00060593          	mv	a1,a2
    800049e8:	00000097          	auipc	ra,0x0
    800049ec:	f88080e7          	jalr	-120(ra) # 80004970 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    800049f0:	00048593          	mv	a1,s1
    800049f4:	00090513          	mv	a0,s2
    800049f8:	00000097          	auipc	ra,0x0
    800049fc:	e34080e7          	jalr	-460(ra) # 8000482c <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    80004a00:	01813083          	ld	ra,24(sp)
    80004a04:	01013403          	ld	s0,16(sp)
    80004a08:	00813483          	ld	s1,8(sp)
    80004a0c:	00013903          	ld	s2,0(sp)
    80004a10:	02010113          	addi	sp,sp,32
    80004a14:	00008067          	ret

0000000080004a18 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    80004a18:	fe010113          	addi	sp,sp,-32
    80004a1c:	00113c23          	sd	ra,24(sp)
    80004a20:	00813823          	sd	s0,16(sp)
    80004a24:	00913423          	sd	s1,8(sp)
    80004a28:	01213023          	sd	s2,0(sp)
    80004a2c:	02010413          	addi	s0,sp,32
    80004a30:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80004a34:	00000493          	li	s1,0
    80004a38:	01893683          	ld	a3,24(s2)
    80004a3c:	0ad4f663          	bgeu	s1,a3,80004ae8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd0>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    80004a40:	0034d613          	srli	a2,s1,0x3
    80004a44:	00c907b3          	add	a5,s2,a2
    80004a48:	0207c583          	lbu	a1,32(a5)
    80004a4c:	fff4c793          	not	a5,s1
    80004a50:	0077f793          	andi	a5,a5,7
    80004a54:	40f5d73b          	sraw	a4,a1,a5
    80004a58:	00177713          	andi	a4,a4,1
    80004a5c:	00070663          	beqz	a4,80004a68 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x50>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80004a60:	00148493          	addi	s1,s1,1
    80004a64:	fd5ff06f          	j	80004a38 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    80004a68:	00100713          	li	a4,1
    80004a6c:	00f717bb          	sllw	a5,a4,a5
    80004a70:	00c90633          	add	a2,s2,a2
    80004a74:	00f5e5b3          	or	a1,a1,a5
    80004a78:	02b60023          	sb	a1,32(a2)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80004a7c:	01093783          	ld	a5,16(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004a80:	04f68863          	beq	a3,a5,80004ad0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb8>
    80004a84:	0a893503          	ld	a0,168(s2)
    80004a88:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80004a8c:	fff78793          	addi	a5,a5,-1
    80004a90:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004a94:	04079463          	bnez	a5,80004adc <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc4>
    80004a98:	0a893583          	ld	a1,168(s2)
    80004a9c:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80004aa0:	0005b703          	ld	a4,0(a1)
    80004aa4:	00053783          	ld	a5,0(a0)
    80004aa8:	00f70863          	beq	a4,a5,80004ab8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa0>
                SlabAllocator::move(headFrom, headTo, slab);
    80004aac:	00090613          	mv	a2,s2
    80004ab0:	00000097          	auipc	ra,0x0
    80004ab4:	f14080e7          	jalr	-236(ra) # 800049c4 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    80004ab8:	0a093503          	ld	a0,160(s2)
    80004abc:	0a893783          	ld	a5,168(s2)
    80004ac0:	0407b783          	ld	a5,64(a5)
    80004ac4:	029784b3          	mul	s1,a5,s1
    80004ac8:	00950533          	add	a0,a0,s1
    80004acc:	0200006f          	j	80004aec <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004ad0:	0a893503          	ld	a0,168(s2)
    80004ad4:	06050513          	addi	a0,a0,96
    80004ad8:	fb5ff06f          	j	80004a8c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x74>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004adc:	0a893583          	ld	a1,168(s2)
    80004ae0:	06858593          	addi	a1,a1,104
    80004ae4:	fbdff06f          	j	80004aa0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x88>
    return nullptr;
    80004ae8:	00000513          	li	a0,0
}
    80004aec:	01813083          	ld	ra,24(sp)
    80004af0:	01013403          	ld	s0,16(sp)
    80004af4:	00813483          	ld	s1,8(sp)
    80004af8:	00013903          	ld	s2,0(sp)
    80004afc:	02010113          	addi	sp,sp,32
    80004b00:	00008067          	ret

0000000080004b04 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    80004b04:	fd010113          	addi	sp,sp,-48
    80004b08:	02113423          	sd	ra,40(sp)
    80004b0c:	02813023          	sd	s0,32(sp)
    80004b10:	00913c23          	sd	s1,24(sp)
    80004b14:	01213823          	sd	s2,16(sp)
    80004b18:	01313423          	sd	s3,8(sp)
    80004b1c:	03010413          	addi	s0,sp,48
    80004b20:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    80004b24:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    80004b28:	00048c63          	beqz	s1,80004b40 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
            void* ret = allocateSlot(head);
    80004b2c:	00048513          	mv	a0,s1
    80004b30:	00000097          	auipc	ra,0x0
    80004b34:	ee8080e7          	jalr	-280(ra) # 80004a18 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80004b38:	fe0508e3          	beqz	a0,80004b28 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x24>
                return ret;
    80004b3c:	00050493          	mv	s1,a0
    if(ret){
    80004b40:	02048263          	beqz	s1,80004b64 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x60>
}
    80004b44:	00048513          	mv	a0,s1
    80004b48:	02813083          	ld	ra,40(sp)
    80004b4c:	02013403          	ld	s0,32(sp)
    80004b50:	01813483          	ld	s1,24(sp)
    80004b54:	01013903          	ld	s2,16(sp)
    80004b58:	00813983          	ld	s3,8(sp)
    80004b5c:	03010113          	addi	sp,sp,48
    80004b60:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80004b64:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    80004b68:	00048c63          	beqz	s1,80004b80 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x7c>
            void* ret = allocateSlot(head);
    80004b6c:	00048513          	mv	a0,s1
    80004b70:	00000097          	auipc	ra,0x0
    80004b74:	ea8080e7          	jalr	-344(ra) # 80004a18 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80004b78:	fe0508e3          	beqz	a0,80004b68 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x64>
                return ret;
    80004b7c:	00050493          	mv	s1,a0
    if(ret){
    80004b80:	fc0492e3          	bnez	s1,80004b44 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
    if(cache->objectSize <= sizeof(Slab)) {
    80004b84:	04093703          	ld	a4,64(s2)
    80004b88:	0b000793          	li	a5,176
    80004b8c:	02e7e463          	bltu	a5,a4,80004bb4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0xb0>
        if (!SlabAllocator::allocateSlab(cache))
    80004b90:	00090513          	mv	a0,s2
    80004b94:	00000097          	auipc	ra,0x0
    80004b98:	cc8080e7          	jalr	-824(ra) # 8000485c <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80004b9c:	fa0504e3          	beqz	a0,80004b44 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80004ba0:	06093503          	ld	a0,96(s2)
    80004ba4:	00000097          	auipc	ra,0x0
    80004ba8:	e74080e7          	jalr	-396(ra) # 80004a18 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80004bac:	00050493          	mv	s1,a0
    80004bb0:	f95ff06f          	j	80004b44 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        Slab* slab = (Slab*)SlabAllocator::allocateObject(largeSlabCache);
    80004bb4:	00006517          	auipc	a0,0x6
    80004bb8:	62453503          	ld	a0,1572(a0) # 8000b1d8 <_ZN13SlabAllocator14largeSlabCacheE>
    80004bbc:	00000097          	auipc	ra,0x0
    80004bc0:	f48080e7          	jalr	-184(ra) # 80004b04 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80004bc4:	00050493          	mv	s1,a0
        slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS)) / cache->objectSize;
    80004bc8:	04893703          	ld	a4,72(s2)
    80004bcc:	00100793          	li	a5,1
    80004bd0:	00e797bb          	sllw	a5,a5,a4
    80004bd4:	00c7979b          	slliw	a5,a5,0xc
    80004bd8:	04093703          	ld	a4,64(s2)
    80004bdc:	02e7d7b3          	divu	a5,a5,a4
    80004be0:	00f53823          	sd	a5,16(a0)
    80004be4:	00f53c23          	sd	a5,24(a0)
        if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
    80004be8:	40000713          	li	a4,1024
    80004bec:	00f77863          	bgeu	a4,a5,80004bfc <_ZN13SlabAllocator14allocateObjectEP5Cache+0xf8>
            slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    80004bf0:	40000793          	li	a5,1024
    80004bf4:	00f53823          	sd	a5,16(a0)
    80004bf8:	00f53c23          	sd	a5,24(a0)
        void* slabOffset = Buddy::alloc(cache->slabSize);
    80004bfc:	04893503          	ld	a0,72(s2)
    80004c00:	ffffd097          	auipc	ra,0xffffd
    80004c04:	0dc080e7          	jalr	220(ra) # 80001cdc <_ZN5Buddy5allocEm>
        slab->objectOffset = slabOffset;
    80004c08:	0aa4b023          	sd	a0,160(s1)
        slab->parent = cache;
    80004c0c:	0b24b423          	sd	s2,168(s1)
        slab->next = nullptr;
    80004c10:	0004b423          	sd	zero,8(s1)
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)/8;i++)
    80004c14:	00000713          	li	a4,0
    80004c18:	0184b783          	ld	a5,24(s1)
    80004c1c:	00778793          	addi	a5,a5,7
    80004c20:	0037d793          	srli	a5,a5,0x3
    80004c24:	00f77a63          	bgeu	a4,a5,80004c38 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x134>
            slab->allocated[i] = 0;
    80004c28:	00e487b3          	add	a5,s1,a4
    80004c2c:	02078023          	sb	zero,32(a5)
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)/8;i++)
    80004c30:	00170713          	addi	a4,a4,1
    80004c34:	fe5ff06f          	j	80004c18 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x114>
        if(cache->ctor) {
    80004c38:	05093783          	ld	a5,80(s2)
    80004c3c:	02078a63          	beqz	a5,80004c70 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x16c>
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004c40:	00000993          	li	s3,0
    80004c44:	0184b783          	ld	a5,24(s1)
    80004c48:	02f9f463          	bgeu	s3,a5,80004c70 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x16c>
                cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    80004c4c:	05093703          	ld	a4,80(s2)
    80004c50:	0a04b503          	ld	a0,160(s1)
    80004c54:	0a84b783          	ld	a5,168(s1)
    80004c58:	0407b783          	ld	a5,64(a5)
    80004c5c:	033787b3          	mul	a5,a5,s3
    80004c60:	00f50533          	add	a0,a0,a5
    80004c64:	000700e7          	jalr	a4
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004c68:	00198993          	addi	s3,s3,1
    80004c6c:	fd9ff06f          	j	80004c44 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x140>
        SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80004c70:	00048593          	mv	a1,s1
    80004c74:	06090513          	addi	a0,s2,96
    80004c78:	00000097          	auipc	ra,0x0
    80004c7c:	bb4080e7          	jalr	-1100(ra) # 8000482c <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80004c80:	06093503          	ld	a0,96(s2)
    80004c84:	00000097          	auipc	ra,0x0
    80004c88:	d94080e7          	jalr	-620(ra) # 80004a18 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80004c8c:	00050493          	mv	s1,a0
    80004c90:	eb5ff06f          	j	80004b44 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>

0000000080004c94 <_ZN13SlabAllocator14allocateBufferEm>:
        num--;
    80004c94:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80004c98:	0017d513          	srli	a0,a5,0x1
    80004c9c:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80004ca0:	0027d713          	srli	a4,a5,0x2
    80004ca4:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80004ca8:	0047d713          	srli	a4,a5,0x4
    80004cac:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80004cb0:	0087d713          	srli	a4,a5,0x8
    80004cb4:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80004cb8:	0107d713          	srli	a4,a5,0x10
    80004cbc:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80004cc0:	0207d713          	srli	a4,a5,0x20
    80004cc4:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80004cc8:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80004ccc:	00000713          	li	a4,0
        while(num>1){
    80004cd0:	00100693          	li	a3,1
    80004cd4:	00f6f863          	bgeu	a3,a5,80004ce4 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    80004cd8:	0017d793          	srli	a5,a5,0x1
            deg++;
    80004cdc:	00170713          	addi	a4,a4,1
        while(num>1){
    80004ce0:	ff1ff06f          	j	80004cd0 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    80004ce4:	ffb70713          	addi	a4,a4,-5
    80004ce8:	00c00793          	li	a5,12
    80004cec:	04e7e063          	bltu	a5,a4,80004d2c <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    80004cf0:	ff010113          	addi	sp,sp,-16
    80004cf4:	00113423          	sd	ra,8(sp)
    80004cf8:	00813023          	sd	s0,0(sp)
    80004cfc:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    80004d00:	00371713          	slli	a4,a4,0x3
    80004d04:	00006797          	auipc	a5,0x6
    80004d08:	4d478793          	addi	a5,a5,1236 # 8000b1d8 <_ZN13SlabAllocator14largeSlabCacheE>
    80004d0c:	00e78733          	add	a4,a5,a4
    80004d10:	00873503          	ld	a0,8(a4)
    80004d14:	00000097          	auipc	ra,0x0
    80004d18:	df0080e7          	jalr	-528(ra) # 80004b04 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004d1c:	00813083          	ld	ra,8(sp)
    80004d20:	00013403          	ld	s0,0(sp)
    80004d24:	01010113          	addi	sp,sp,16
    80004d28:	00008067          	ret
        return nullptr;
    80004d2c:	00000513          	li	a0,0
}
    80004d30:	00008067          	ret

0000000080004d34 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80004d34:	fc010113          	addi	sp,sp,-64
    80004d38:	02113c23          	sd	ra,56(sp)
    80004d3c:	02813823          	sd	s0,48(sp)
    80004d40:	02913423          	sd	s1,40(sp)
    80004d44:	03213023          	sd	s2,32(sp)
    80004d48:	01313c23          	sd	s3,24(sp)
    80004d4c:	01413823          	sd	s4,16(sp)
    80004d50:	01513423          	sd	s5,8(sp)
    80004d54:	04010413          	addi	s0,sp,64
    80004d58:	00050993          	mv	s3,a0
    80004d5c:	00058913          	mv	s2,a1
    80004d60:	00060a93          	mv	s5,a2
    80004d64:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80004d68:	00006517          	auipc	a0,0x6
    80004d6c:	4e053503          	ld	a0,1248(a0) # 8000b248 <_ZN13SlabAllocator5cacheE>
    80004d70:	00000097          	auipc	ra,0x0
    80004d74:	d94080e7          	jalr	-620(ra) # 80004b04 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80004d78:	00050493          	mv	s1,a0
    if(ret == nullptr)
    80004d7c:	08050863          	beqz	a0,80004e0c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xd8>
    ret->ctor = ctor;
    80004d80:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80004d84:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80004d88:	06053823          	sd	zero,112(a0)
    80004d8c:	06053423          	sd	zero,104(a0)
    80004d90:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80004d94:	05253023          	sd	s2,64(a0)
        num--;
    80004d98:	fff90793          	addi	a5,s2,-1
        num |= num>>1;
    80004d9c:	0017d713          	srli	a4,a5,0x1
    80004da0:	00e7e7b3          	or	a5,a5,a4
        num |= num>>2;
    80004da4:	0027d713          	srli	a4,a5,0x2
    80004da8:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80004dac:	0047d713          	srli	a4,a5,0x4
    80004db0:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80004db4:	0087d713          	srli	a4,a5,0x8
    80004db8:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80004dbc:	0107d713          	srli	a4,a5,0x10
    80004dc0:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80004dc4:	0207d713          	srli	a4,a5,0x20
    80004dc8:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80004dcc:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80004dd0:	00000713          	li	a4,0
        while(num>1){
    80004dd4:	00100693          	li	a3,1
    80004dd8:	00f6f863          	bgeu	a3,a5,80004de8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xb4>
            num/=2;
    80004ddc:	0017d793          	srli	a5,a5,0x1
            deg++;
    80004de0:	00170713          	addi	a4,a4,1
        while(num>1){
    80004de4:	ff1ff06f          	j	80004dd4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xa0>
    int deg = Buddy::getDeg(Buddy::ceil(size));
    80004de8:	0007071b          	sext.w	a4,a4
    if(size <= sizeof(Slab)){
    80004dec:	0b000793          	li	a5,176
    80004df0:	0527e263          	bltu	a5,s2,80004e34 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x100>
        ret->slabSize = SMALL_CACHE_DEFAULT_SLAB_SIZE;
    80004df4:	00100793          	li	a5,1
    80004df8:	04f4b423          	sd	a5,72(s1)
    strcpy(name, ret->name);
    80004dfc:	00048593          	mv	a1,s1
    80004e00:	00098513          	mv	a0,s3
    80004e04:	fffff097          	auipc	ra,0xfffff
    80004e08:	274080e7          	jalr	628(ra) # 80004078 <_Z6strcpyPKcPc>
}
    80004e0c:	00048513          	mv	a0,s1
    80004e10:	03813083          	ld	ra,56(sp)
    80004e14:	03013403          	ld	s0,48(sp)
    80004e18:	02813483          	ld	s1,40(sp)
    80004e1c:	02013903          	ld	s2,32(sp)
    80004e20:	01813983          	ld	s3,24(sp)
    80004e24:	01013a03          	ld	s4,16(sp)
    80004e28:	00813a83          	ld	s5,8(sp)
    80004e2c:	04010113          	addi	sp,sp,64
    80004e30:	00008067          	ret
        deg-=10;
    80004e34:	ff67071b          	addiw	a4,a4,-10
        ret->slabSize = deg;
    80004e38:	04e4b423          	sd	a4,72(s1)
    80004e3c:	fc1ff06f          	j	80004dfc <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xc8>

0000000080004e40 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80004e40:	fe010113          	addi	sp,sp,-32
    80004e44:	00113c23          	sd	ra,24(sp)
    80004e48:	00813823          	sd	s0,16(sp)
    80004e4c:	00913423          	sd	s1,8(sp)
    80004e50:	01213023          	sd	s2,0(sp)
    80004e54:	02010413          	addi	s0,sp,32
    Buddy::initialize(space, blockNum);
    80004e58:	ffffd097          	auipc	ra,0xffffd
    80004e5c:	ab4080e7          	jalr	-1356(ra) # 8000190c <_ZN5Buddy10initializeEPvm>
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80004e60:	00006917          	auipc	s2,0x6
    80004e64:	08093903          	ld	s2,128(s2) # 8000aee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004e68:	00093583          	ld	a1,0(s2)
    80004e6c:	00c5d593          	srli	a1,a1,0xc
    80004e70:	00158593          	addi	a1,a1,1
    80004e74:	00c59593          	slli	a1,a1,0xc
    80004e78:	00006497          	auipc	s1,0x6
    80004e7c:	36048493          	addi	s1,s1,864 # 8000b1d8 <_ZN13SlabAllocator14largeSlabCacheE>
    80004e80:	06b4b823          	sd	a1,112(s1)
    cache->ctor = nullptr;
    80004e84:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80004e88:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80004e8c:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80004e90:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80004e94:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80004e98:	07800793          	li	a5,120
    80004e9c:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80004ea0:	00200793          	li	a5,2
    80004ea4:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80004ea8:	00003517          	auipc	a0,0x3
    80004eac:	5b050513          	addi	a0,a0,1456 # 80008458 <CONSOLE_STATUS+0x448>
    80004eb0:	fffff097          	auipc	ra,0xfffff
    80004eb4:	1c8080e7          	jalr	456(ra) # 80004078 <_Z6strcpyPKcPc>
    largeSlabCache = (Cache*)BUDDY_META_ADDR_CONST;
    80004eb8:	00093783          	ld	a5,0(s2)
    80004ebc:	fffff737          	lui	a4,0xfffff
    80004ec0:	00e7f7b3          	and	a5,a5,a4
    80004ec4:	00f4b023          	sd	a5,0(s1)
    largeSlabCache->ctor = nullptr;
    80004ec8:	0407b823          	sd	zero,80(a5)
    largeSlabCache->dtor = nullptr;
    80004ecc:	0407bc23          	sd	zero,88(a5)
    largeSlabCache->emptyHead = nullptr;
    80004ed0:	0607b023          	sd	zero,96(a5)
    largeSlabCache->partialHead = nullptr;
    80004ed4:	0607b423          	sd	zero,104(a5)
    largeSlabCache->fullHead = nullptr;
    80004ed8:	0607b823          	sd	zero,112(a5)
    largeSlabCache->objectSize = sizeof(Slab);
    80004edc:	0b000713          	li	a4,176
    80004ee0:	04e7b023          	sd	a4,64(a5)
    largeSlabCache->slabSize = SLAB_HEADER_DEFAULT_SLAB_SIZE;
    80004ee4:	00400713          	li	a4,4
    80004ee8:	04e7b423          	sd	a4,72(a5)
    strcpy("Large Slab Cache", cache->name);
    80004eec:	0704b583          	ld	a1,112(s1)
    80004ef0:	00003517          	auipc	a0,0x3
    80004ef4:	57850513          	addi	a0,a0,1400 # 80008468 <CONSOLE_STATUS+0x458>
    80004ef8:	fffff097          	auipc	ra,0xfffff
    80004efc:	180080e7          	jalr	384(ra) # 80004078 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80004f00:	00000493          	li	s1,0
    80004f04:	0480006f          	j	80004f4c <_ZN13SlabAllocator10initializeEPvm+0x10c>
        sizeN[i] = SlabAllocator::createCache(names[i], 1<<(i+CACHE_LOWER_BOUND), nullptr, nullptr);
    80004f08:	0054871b          	addiw	a4,s1,5
    80004f0c:	00349913          	slli	s2,s1,0x3
    80004f10:	00006797          	auipc	a5,0x6
    80004f14:	f5078793          	addi	a5,a5,-176 # 8000ae60 <_ZN13SlabAllocator5namesE>
    80004f18:	012787b3          	add	a5,a5,s2
    80004f1c:	00000693          	li	a3,0
    80004f20:	00000613          	li	a2,0
    80004f24:	00100593          	li	a1,1
    80004f28:	00e595bb          	sllw	a1,a1,a4
    80004f2c:	0007b503          	ld	a0,0(a5)
    80004f30:	00000097          	auipc	ra,0x0
    80004f34:	e04080e7          	jalr	-508(ra) # 80004d34 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80004f38:	00006797          	auipc	a5,0x6
    80004f3c:	2a078793          	addi	a5,a5,672 # 8000b1d8 <_ZN13SlabAllocator14largeSlabCacheE>
    80004f40:	012787b3          	add	a5,a5,s2
    80004f44:	00a7b423          	sd	a0,8(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80004f48:	0014849b          	addiw	s1,s1,1
    80004f4c:	00c00793          	li	a5,12
    80004f50:	fa97dce3          	bge	a5,s1,80004f08 <_ZN13SlabAllocator10initializeEPvm+0xc8>
}
    80004f54:	01813083          	ld	ra,24(sp)
    80004f58:	01013403          	ld	s0,16(sp)
    80004f5c:	00813483          	ld	s1,8(sp)
    80004f60:	00013903          	ld	s2,0(sp)
    80004f64:	02010113          	addi	sp,sp,32
    80004f68:	00008067          	ret

0000000080004f6c <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80004f6c:	0035d713          	srli	a4,a1,0x3
    80004f70:	00e507b3          	add	a5,a0,a4
    80004f74:	0207c683          	lbu	a3,32(a5)
    80004f78:	fff5c593          	not	a1,a1
    80004f7c:	0075f593          	andi	a1,a1,7
    80004f80:	40b6d7bb          	sraw	a5,a3,a1
    80004f84:	0017f793          	andi	a5,a5,1
    80004f88:	0e078e63          	beqz	a5,80005084 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x118>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80004f8c:	fe010113          	addi	sp,sp,-32
    80004f90:	00113c23          	sd	ra,24(sp)
    80004f94:	00813823          	sd	s0,16(sp)
    80004f98:	00913423          	sd	s1,8(sp)
    80004f9c:	02010413          	addi	s0,sp,32
    80004fa0:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80004fa4:	00100793          	li	a5,1
    80004fa8:	00b795bb          	sllw	a1,a5,a1
    80004fac:	00e50733          	add	a4,a0,a4
    80004fb0:	fff5c593          	not	a1,a1
    80004fb4:	00d5f5b3          	and	a1,a1,a3
    80004fb8:	02b70023          	sb	a1,32(a4) # fffffffffffff020 <end+0xffffffff7ffee020>
    inline bool isFull(){return numOfFreeSlots == 0;}
    80004fbc:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004fc0:	04079a63          	bnez	a5,80005014 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80004fc4:	0a853503          	ld	a0,168(a0)
    80004fc8:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80004fcc:	00178793          	addi	a5,a5,1
    80004fd0:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80004fd4:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004fd8:	04e78463          	beq	a5,a4,80005020 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80004fdc:	0a84b583          	ld	a1,168(s1)
    80004fe0:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80004fe4:	04e78463          	beq	a5,a4,8000502c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80004fe8:	0005b703          	ld	a4,0(a1)
    80004fec:	00053783          	ld	a5,0(a0)
    80004ff0:	00f70863          	beq	a4,a5,80005000 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80004ff4:	00048613          	mv	a2,s1
    80004ff8:	00000097          	auipc	ra,0x0
    80004ffc:	9cc080e7          	jalr	-1588(ra) # 800049c4 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80005000:	01813083          	ld	ra,24(sp)
    80005004:	01013403          	ld	s0,16(sp)
    80005008:	00813483          	ld	s1,8(sp)
    8000500c:	02010113          	addi	sp,sp,32
    80005010:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80005014:	0a853503          	ld	a0,168(a0)
    80005018:	06850513          	addi	a0,a0,104
    8000501c:	fb1ff06f          	j	80004fcc <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80005020:	0a84b583          	ld	a1,168(s1)
    80005024:	06058593          	addi	a1,a1,96
    80005028:	fbdff06f          	j	80004fe4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    8000502c:	00048593          	mv	a1,s1
    80005030:	00000097          	auipc	ra,0x0
    80005034:	940080e7          	jalr	-1728(ra) # 80004970 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            if(slab->parent->objectSize <= sizeof(Slab)) {
    80005038:	0a84b783          	ld	a5,168(s1)
    8000503c:	0407b683          	ld	a3,64(a5)
    80005040:	0b000713          	li	a4,176
    80005044:	00d76c63          	bltu	a4,a3,8000505c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xf0>
                Buddy::free(slab, slab->parent->slabSize);
    80005048:	0487b583          	ld	a1,72(a5)
    8000504c:	00048513          	mv	a0,s1
    80005050:	ffffd097          	auipc	ra,0xffffd
    80005054:	bb4080e7          	jalr	-1100(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
    80005058:	fa9ff06f          	j	80005000 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                Buddy::free(slab->objectOffset, slab->parent->slabSize);
    8000505c:	0487b583          	ld	a1,72(a5)
    80005060:	0a04b503          	ld	a0,160(s1)
    80005064:	ffffd097          	auipc	ra,0xffffd
    80005068:	ba0080e7          	jalr	-1120(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
                SlabAllocator::freeObject(largeSlabCache, slab);
    8000506c:	00048593          	mv	a1,s1
    80005070:	00006517          	auipc	a0,0x6
    80005074:	16853503          	ld	a0,360(a0) # 8000b1d8 <_ZN13SlabAllocator14largeSlabCacheE>
    80005078:	00000097          	auipc	ra,0x0
    8000507c:	010080e7          	jalr	16(ra) # 80005088 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80005080:	f81ff06f          	j	80005000 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80005084:	00008067          	ret

0000000080005088 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80005088:	fe010113          	addi	sp,sp,-32
    8000508c:	00113c23          	sd	ra,24(sp)
    80005090:	00813823          	sd	s0,16(sp)
    80005094:	00913423          	sd	s1,8(sp)
    80005098:	01213023          	sd	s2,0(sp)
    8000509c:	02010413          	addi	s0,sp,32
    800050a0:	00050913          	mv	s2,a0
    800050a4:	00058493          	mv	s1,a1
    if(cache->dtor)
    800050a8:	05853783          	ld	a5,88(a0)
    800050ac:	00078663          	beqz	a5,800050b8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    800050b0:	00058513          	mv	a0,a1
    800050b4:	000780e7          	jalr	a5
    if(cache->ctor)
    800050b8:	05093783          	ld	a5,80(s2)
    800050bc:	00078663          	beqz	a5,800050c8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    800050c0:	00048513          	mv	a0,s1
    800050c4:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    800050c8:	07093503          	ld	a0,112(s2)
    800050cc:	0080006f          	j	800050d4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    800050d0:	00853503          	ld	a0,8(a0)
        while(head){
    800050d4:	02050e63          	beqz	a0,80005110 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    800050d8:	0a053703          	ld	a4,160(a0)
    800050dc:	01853783          	ld	a5,24(a0)
    800050e0:	0a853683          	ld	a3,168(a0)
    800050e4:	0406b583          	ld	a1,64(a3)
    800050e8:	02b787b3          	mul	a5,a5,a1
    800050ec:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    800050f0:	fef4f0e3          	bgeu	s1,a5,800050d0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    800050f4:	fce4eee3          	bltu	s1,a4,800050d0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    800050f8:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    800050fc:	02b755b3          	divu	a1,a4,a1
    80005100:	00000097          	auipc	ra,0x0
    80005104:	e6c080e7          	jalr	-404(ra) # 80004f6c <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80005108:	00100513          	li	a0,1
    8000510c:	0080006f          	j	80005114 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80005110:	00000513          	li	a0,0
    if(deleted)
    80005114:	00050e63          	beqz	a0,80005130 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80005118:	01813083          	ld	ra,24(sp)
    8000511c:	01013403          	ld	s0,16(sp)
    80005120:	00813483          	ld	s1,8(sp)
    80005124:	00013903          	ld	s2,0(sp)
    80005128:	02010113          	addi	sp,sp,32
    8000512c:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80005130:	06893783          	ld	a5,104(s2)
    80005134:	0080006f          	j	8000513c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80005138:	0087b783          	ld	a5,8(a5)
        while(head){
    8000513c:	fc078ee3          	beqz	a5,80005118 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80005140:	0a07b683          	ld	a3,160(a5)
    80005144:	0187b703          	ld	a4,24(a5)
    80005148:	0a87b603          	ld	a2,168(a5)
    8000514c:	04063583          	ld	a1,64(a2)
    80005150:	02b70733          	mul	a4,a4,a1
    80005154:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80005158:	fee4f0e3          	bgeu	s1,a4,80005138 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    8000515c:	fcd4eee3          	bltu	s1,a3,80005138 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80005160:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80005164:	02b6d5b3          	divu	a1,a3,a1
    80005168:	00078513          	mv	a0,a5
    8000516c:	00000097          	auipc	ra,0x0
    80005170:	e00080e7          	jalr	-512(ra) # 80004f6c <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80005174:	00100513          	li	a0,1
    80005178:	fa1ff06f          	j	80005118 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

000000008000517c <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    8000517c:	fe010113          	addi	sp,sp,-32
    80005180:	00113c23          	sd	ra,24(sp)
    80005184:	00813823          	sd	s0,16(sp)
    80005188:	00913423          	sd	s1,8(sp)
    8000518c:	01213023          	sd	s2,0(sp)
    80005190:	02010413          	addi	s0,sp,32
    80005194:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80005198:	00000493          	li	s1,0
    8000519c:	00c00793          	li	a5,12
    800051a0:	0297c863          	blt	a5,s1,800051d0 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    800051a4:	00349713          	slli	a4,s1,0x3
    800051a8:	00006797          	auipc	a5,0x6
    800051ac:	03078793          	addi	a5,a5,48 # 8000b1d8 <_ZN13SlabAllocator14largeSlabCacheE>
    800051b0:	00e787b3          	add	a5,a5,a4
    800051b4:	00090593          	mv	a1,s2
    800051b8:	0087b503          	ld	a0,8(a5)
    800051bc:	00000097          	auipc	ra,0x0
    800051c0:	ecc080e7          	jalr	-308(ra) # 80005088 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    800051c4:	00051663          	bnez	a0,800051d0 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    800051c8:	0014849b          	addiw	s1,s1,1
    800051cc:	fd1ff06f          	j	8000519c <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    800051d0:	01813083          	ld	ra,24(sp)
    800051d4:	01013403          	ld	s0,16(sp)
    800051d8:	00813483          	ld	s1,8(sp)
    800051dc:	00013903          	ld	s2,0(sp)
    800051e0:	02010113          	addi	sp,sp,32
    800051e4:	00008067          	ret

00000000800051e8 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    800051e8:	fe010113          	addi	sp,sp,-32
    800051ec:	00113c23          	sd	ra,24(sp)
    800051f0:	00813823          	sd	s0,16(sp)
    800051f4:	00913423          	sd	s1,8(sp)
    800051f8:	01213023          	sd	s2,0(sp)
    800051fc:	02010413          	addi	s0,sp,32
    80005200:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80005204:	00053903          	ld	s2,0(a0)
    80005208:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    8000520c:	00093503          	ld	a0,0(s2)
    80005210:	02050263          	beqz	a0,80005234 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80005214:	0a853783          	ld	a5,168(a0)
    80005218:	0487b583          	ld	a1,72(a5)
    8000521c:	ffffd097          	auipc	ra,0xffffd
    80005220:	9e8080e7          	jalr	-1560(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80005224:	00093783          	ld	a5,0(s2)
    80005228:	0087b783          	ld	a5,8(a5)
    8000522c:	00f93023          	sd	a5,0(s2)
        while(head){
    80005230:	fddff06f          	j	8000520c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80005234:	0004b903          	ld	s2,0(s1)
    80005238:	06890913          	addi	s2,s2,104
    8000523c:	00093503          	ld	a0,0(s2)
    80005240:	02050263          	beqz	a0,80005264 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80005244:	0a853783          	ld	a5,168(a0)
    80005248:	0487b583          	ld	a1,72(a5)
    8000524c:	ffffd097          	auipc	ra,0xffffd
    80005250:	9b8080e7          	jalr	-1608(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80005254:	00093783          	ld	a5,0(s2)
    80005258:	0087b783          	ld	a5,8(a5)
    8000525c:	00f93023          	sd	a5,0(s2)
        while(head){
    80005260:	fddff06f          	j	8000523c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80005264:	0004b903          	ld	s2,0(s1)
    80005268:	06090913          	addi	s2,s2,96
    8000526c:	00093503          	ld	a0,0(s2)
    80005270:	02050263          	beqz	a0,80005294 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80005274:	0a853783          	ld	a5,168(a0)
    80005278:	0487b583          	ld	a1,72(a5)
    8000527c:	ffffd097          	auipc	ra,0xffffd
    80005280:	988080e7          	jalr	-1656(ra) # 80001c04 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80005284:	00093783          	ld	a5,0(s2)
    80005288:	0087b783          	ld	a5,8(a5)
    8000528c:	00f93023          	sd	a5,0(s2)
        while(head){
    80005290:	fddff06f          	j	8000526c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80005294:	0004b583          	ld	a1,0(s1)
    80005298:	00006517          	auipc	a0,0x6
    8000529c:	fb053503          	ld	a0,-80(a0) # 8000b248 <_ZN13SlabAllocator5cacheE>
    800052a0:	00000097          	auipc	ra,0x0
    800052a4:	de8080e7          	jalr	-536(ra) # 80005088 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    800052a8:	0004b023          	sd	zero,0(s1)
}
    800052ac:	01813083          	ld	ra,24(sp)
    800052b0:	01013403          	ld	s0,16(sp)
    800052b4:	00813483          	ld	s1,8(sp)
    800052b8:	00013903          	ld	s2,0(sp)
    800052bc:	02010113          	addi	sp,sp,32
    800052c0:	00008067          	ret

00000000800052c4 <start>:
    800052c4:	ff010113          	addi	sp,sp,-16
    800052c8:	00813423          	sd	s0,8(sp)
    800052cc:	01010413          	addi	s0,sp,16
    800052d0:	300027f3          	csrr	a5,mstatus
    800052d4:	ffffe737          	lui	a4,0xffffe
    800052d8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed7ff>
    800052dc:	00e7f7b3          	and	a5,a5,a4
    800052e0:	00001737          	lui	a4,0x1
    800052e4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800052e8:	00e7e7b3          	or	a5,a5,a4
    800052ec:	30079073          	csrw	mstatus,a5
    800052f0:	00000797          	auipc	a5,0x0
    800052f4:	16078793          	addi	a5,a5,352 # 80005450 <system_main>
    800052f8:	34179073          	csrw	mepc,a5
    800052fc:	00000793          	li	a5,0
    80005300:	18079073          	csrw	satp,a5
    80005304:	000107b7          	lui	a5,0x10
    80005308:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000530c:	30279073          	csrw	medeleg,a5
    80005310:	30379073          	csrw	mideleg,a5
    80005314:	104027f3          	csrr	a5,sie
    80005318:	2227e793          	ori	a5,a5,546
    8000531c:	10479073          	csrw	sie,a5
    80005320:	fff00793          	li	a5,-1
    80005324:	00a7d793          	srli	a5,a5,0xa
    80005328:	3b079073          	csrw	pmpaddr0,a5
    8000532c:	00f00793          	li	a5,15
    80005330:	3a079073          	csrw	pmpcfg0,a5
    80005334:	f14027f3          	csrr	a5,mhartid
    80005338:	0200c737          	lui	a4,0x200c
    8000533c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005340:	0007869b          	sext.w	a3,a5
    80005344:	00269713          	slli	a4,a3,0x2
    80005348:	000f4637          	lui	a2,0xf4
    8000534c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005350:	00d70733          	add	a4,a4,a3
    80005354:	0037979b          	slliw	a5,a5,0x3
    80005358:	020046b7          	lui	a3,0x2004
    8000535c:	00d787b3          	add	a5,a5,a3
    80005360:	00c585b3          	add	a1,a1,a2
    80005364:	00371693          	slli	a3,a4,0x3
    80005368:	00006717          	auipc	a4,0x6
    8000536c:	ee870713          	addi	a4,a4,-280 # 8000b250 <timer_scratch>
    80005370:	00b7b023          	sd	a1,0(a5)
    80005374:	00d70733          	add	a4,a4,a3
    80005378:	00f73c23          	sd	a5,24(a4)
    8000537c:	02c73023          	sd	a2,32(a4)
    80005380:	34071073          	csrw	mscratch,a4
    80005384:	00000797          	auipc	a5,0x0
    80005388:	6ec78793          	addi	a5,a5,1772 # 80005a70 <timervec>
    8000538c:	30579073          	csrw	mtvec,a5
    80005390:	300027f3          	csrr	a5,mstatus
    80005394:	0087e793          	ori	a5,a5,8
    80005398:	30079073          	csrw	mstatus,a5
    8000539c:	304027f3          	csrr	a5,mie
    800053a0:	0807e793          	ori	a5,a5,128
    800053a4:	30479073          	csrw	mie,a5
    800053a8:	f14027f3          	csrr	a5,mhartid
    800053ac:	0007879b          	sext.w	a5,a5
    800053b0:	00078213          	mv	tp,a5
    800053b4:	30200073          	mret
    800053b8:	00813403          	ld	s0,8(sp)
    800053bc:	01010113          	addi	sp,sp,16
    800053c0:	00008067          	ret

00000000800053c4 <timerinit>:
    800053c4:	ff010113          	addi	sp,sp,-16
    800053c8:	00813423          	sd	s0,8(sp)
    800053cc:	01010413          	addi	s0,sp,16
    800053d0:	f14027f3          	csrr	a5,mhartid
    800053d4:	0200c737          	lui	a4,0x200c
    800053d8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800053dc:	0007869b          	sext.w	a3,a5
    800053e0:	00269713          	slli	a4,a3,0x2
    800053e4:	000f4637          	lui	a2,0xf4
    800053e8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800053ec:	00d70733          	add	a4,a4,a3
    800053f0:	0037979b          	slliw	a5,a5,0x3
    800053f4:	020046b7          	lui	a3,0x2004
    800053f8:	00d787b3          	add	a5,a5,a3
    800053fc:	00c585b3          	add	a1,a1,a2
    80005400:	00371693          	slli	a3,a4,0x3
    80005404:	00006717          	auipc	a4,0x6
    80005408:	e4c70713          	addi	a4,a4,-436 # 8000b250 <timer_scratch>
    8000540c:	00b7b023          	sd	a1,0(a5)
    80005410:	00d70733          	add	a4,a4,a3
    80005414:	00f73c23          	sd	a5,24(a4)
    80005418:	02c73023          	sd	a2,32(a4)
    8000541c:	34071073          	csrw	mscratch,a4
    80005420:	00000797          	auipc	a5,0x0
    80005424:	65078793          	addi	a5,a5,1616 # 80005a70 <timervec>
    80005428:	30579073          	csrw	mtvec,a5
    8000542c:	300027f3          	csrr	a5,mstatus
    80005430:	0087e793          	ori	a5,a5,8
    80005434:	30079073          	csrw	mstatus,a5
    80005438:	304027f3          	csrr	a5,mie
    8000543c:	0807e793          	ori	a5,a5,128
    80005440:	30479073          	csrw	mie,a5
    80005444:	00813403          	ld	s0,8(sp)
    80005448:	01010113          	addi	sp,sp,16
    8000544c:	00008067          	ret

0000000080005450 <system_main>:
    80005450:	fe010113          	addi	sp,sp,-32
    80005454:	00813823          	sd	s0,16(sp)
    80005458:	00913423          	sd	s1,8(sp)
    8000545c:	00113c23          	sd	ra,24(sp)
    80005460:	02010413          	addi	s0,sp,32
    80005464:	00000097          	auipc	ra,0x0
    80005468:	0c4080e7          	jalr	196(ra) # 80005528 <cpuid>
    8000546c:	00006497          	auipc	s1,0x6
    80005470:	b6448493          	addi	s1,s1,-1180 # 8000afd0 <started>
    80005474:	02050263          	beqz	a0,80005498 <system_main+0x48>
    80005478:	0004a783          	lw	a5,0(s1)
    8000547c:	0007879b          	sext.w	a5,a5
    80005480:	fe078ce3          	beqz	a5,80005478 <system_main+0x28>
    80005484:	0ff0000f          	fence
    80005488:	00003517          	auipc	a0,0x3
    8000548c:	16050513          	addi	a0,a0,352 # 800085e8 <CONSOLE_STATUS+0x5d8>
    80005490:	00001097          	auipc	ra,0x1
    80005494:	a7c080e7          	jalr	-1412(ra) # 80005f0c <panic>
    80005498:	00001097          	auipc	ra,0x1
    8000549c:	9d0080e7          	jalr	-1584(ra) # 80005e68 <consoleinit>
    800054a0:	00001097          	auipc	ra,0x1
    800054a4:	15c080e7          	jalr	348(ra) # 800065fc <printfinit>
    800054a8:	00003517          	auipc	a0,0x3
    800054ac:	c7050513          	addi	a0,a0,-912 # 80008118 <CONSOLE_STATUS+0x108>
    800054b0:	00001097          	auipc	ra,0x1
    800054b4:	ab8080e7          	jalr	-1352(ra) # 80005f68 <__printf>
    800054b8:	00003517          	auipc	a0,0x3
    800054bc:	10050513          	addi	a0,a0,256 # 800085b8 <CONSOLE_STATUS+0x5a8>
    800054c0:	00001097          	auipc	ra,0x1
    800054c4:	aa8080e7          	jalr	-1368(ra) # 80005f68 <__printf>
    800054c8:	00003517          	auipc	a0,0x3
    800054cc:	c5050513          	addi	a0,a0,-944 # 80008118 <CONSOLE_STATUS+0x108>
    800054d0:	00001097          	auipc	ra,0x1
    800054d4:	a98080e7          	jalr	-1384(ra) # 80005f68 <__printf>
    800054d8:	00001097          	auipc	ra,0x1
    800054dc:	4b0080e7          	jalr	1200(ra) # 80006988 <kinit>
    800054e0:	00000097          	auipc	ra,0x0
    800054e4:	148080e7          	jalr	328(ra) # 80005628 <trapinit>
    800054e8:	00000097          	auipc	ra,0x0
    800054ec:	16c080e7          	jalr	364(ra) # 80005654 <trapinithart>
    800054f0:	00000097          	auipc	ra,0x0
    800054f4:	5c0080e7          	jalr	1472(ra) # 80005ab0 <plicinit>
    800054f8:	00000097          	auipc	ra,0x0
    800054fc:	5e0080e7          	jalr	1504(ra) # 80005ad8 <plicinithart>
    80005500:	00000097          	auipc	ra,0x0
    80005504:	078080e7          	jalr	120(ra) # 80005578 <userinit>
    80005508:	0ff0000f          	fence
    8000550c:	00100793          	li	a5,1
    80005510:	00003517          	auipc	a0,0x3
    80005514:	0c050513          	addi	a0,a0,192 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80005518:	00f4a023          	sw	a5,0(s1)
    8000551c:	00001097          	auipc	ra,0x1
    80005520:	a4c080e7          	jalr	-1460(ra) # 80005f68 <__printf>
    80005524:	0000006f          	j	80005524 <system_main+0xd4>

0000000080005528 <cpuid>:
    80005528:	ff010113          	addi	sp,sp,-16
    8000552c:	00813423          	sd	s0,8(sp)
    80005530:	01010413          	addi	s0,sp,16
    80005534:	00020513          	mv	a0,tp
    80005538:	00813403          	ld	s0,8(sp)
    8000553c:	0005051b          	sext.w	a0,a0
    80005540:	01010113          	addi	sp,sp,16
    80005544:	00008067          	ret

0000000080005548 <mycpu>:
    80005548:	ff010113          	addi	sp,sp,-16
    8000554c:	00813423          	sd	s0,8(sp)
    80005550:	01010413          	addi	s0,sp,16
    80005554:	00020793          	mv	a5,tp
    80005558:	00813403          	ld	s0,8(sp)
    8000555c:	0007879b          	sext.w	a5,a5
    80005560:	00779793          	slli	a5,a5,0x7
    80005564:	00007517          	auipc	a0,0x7
    80005568:	d1c50513          	addi	a0,a0,-740 # 8000c280 <cpus>
    8000556c:	00f50533          	add	a0,a0,a5
    80005570:	01010113          	addi	sp,sp,16
    80005574:	00008067          	ret

0000000080005578 <userinit>:
    80005578:	ff010113          	addi	sp,sp,-16
    8000557c:	00813423          	sd	s0,8(sp)
    80005580:	01010413          	addi	s0,sp,16
    80005584:	00813403          	ld	s0,8(sp)
    80005588:	01010113          	addi	sp,sp,16
    8000558c:	ffffd317          	auipc	t1,0xffffd
    80005590:	8f430067          	jr	-1804(t1) # 80001e80 <main>

0000000080005594 <either_copyout>:
    80005594:	ff010113          	addi	sp,sp,-16
    80005598:	00813023          	sd	s0,0(sp)
    8000559c:	00113423          	sd	ra,8(sp)
    800055a0:	01010413          	addi	s0,sp,16
    800055a4:	02051663          	bnez	a0,800055d0 <either_copyout+0x3c>
    800055a8:	00058513          	mv	a0,a1
    800055ac:	00060593          	mv	a1,a2
    800055b0:	0006861b          	sext.w	a2,a3
    800055b4:	00002097          	auipc	ra,0x2
    800055b8:	c60080e7          	jalr	-928(ra) # 80007214 <__memmove>
    800055bc:	00813083          	ld	ra,8(sp)
    800055c0:	00013403          	ld	s0,0(sp)
    800055c4:	00000513          	li	a0,0
    800055c8:	01010113          	addi	sp,sp,16
    800055cc:	00008067          	ret
    800055d0:	00003517          	auipc	a0,0x3
    800055d4:	04050513          	addi	a0,a0,64 # 80008610 <CONSOLE_STATUS+0x600>
    800055d8:	00001097          	auipc	ra,0x1
    800055dc:	934080e7          	jalr	-1740(ra) # 80005f0c <panic>

00000000800055e0 <either_copyin>:
    800055e0:	ff010113          	addi	sp,sp,-16
    800055e4:	00813023          	sd	s0,0(sp)
    800055e8:	00113423          	sd	ra,8(sp)
    800055ec:	01010413          	addi	s0,sp,16
    800055f0:	02059463          	bnez	a1,80005618 <either_copyin+0x38>
    800055f4:	00060593          	mv	a1,a2
    800055f8:	0006861b          	sext.w	a2,a3
    800055fc:	00002097          	auipc	ra,0x2
    80005600:	c18080e7          	jalr	-1000(ra) # 80007214 <__memmove>
    80005604:	00813083          	ld	ra,8(sp)
    80005608:	00013403          	ld	s0,0(sp)
    8000560c:	00000513          	li	a0,0
    80005610:	01010113          	addi	sp,sp,16
    80005614:	00008067          	ret
    80005618:	00003517          	auipc	a0,0x3
    8000561c:	02050513          	addi	a0,a0,32 # 80008638 <CONSOLE_STATUS+0x628>
    80005620:	00001097          	auipc	ra,0x1
    80005624:	8ec080e7          	jalr	-1812(ra) # 80005f0c <panic>

0000000080005628 <trapinit>:
    80005628:	ff010113          	addi	sp,sp,-16
    8000562c:	00813423          	sd	s0,8(sp)
    80005630:	01010413          	addi	s0,sp,16
    80005634:	00813403          	ld	s0,8(sp)
    80005638:	00003597          	auipc	a1,0x3
    8000563c:	02858593          	addi	a1,a1,40 # 80008660 <CONSOLE_STATUS+0x650>
    80005640:	00007517          	auipc	a0,0x7
    80005644:	cc050513          	addi	a0,a0,-832 # 8000c300 <tickslock>
    80005648:	01010113          	addi	sp,sp,16
    8000564c:	00001317          	auipc	t1,0x1
    80005650:	5cc30067          	jr	1484(t1) # 80006c18 <initlock>

0000000080005654 <trapinithart>:
    80005654:	ff010113          	addi	sp,sp,-16
    80005658:	00813423          	sd	s0,8(sp)
    8000565c:	01010413          	addi	s0,sp,16
    80005660:	00000797          	auipc	a5,0x0
    80005664:	30078793          	addi	a5,a5,768 # 80005960 <kernelvec>
    80005668:	10579073          	csrw	stvec,a5
    8000566c:	00813403          	ld	s0,8(sp)
    80005670:	01010113          	addi	sp,sp,16
    80005674:	00008067          	ret

0000000080005678 <usertrap>:
    80005678:	ff010113          	addi	sp,sp,-16
    8000567c:	00813423          	sd	s0,8(sp)
    80005680:	01010413          	addi	s0,sp,16
    80005684:	00813403          	ld	s0,8(sp)
    80005688:	01010113          	addi	sp,sp,16
    8000568c:	00008067          	ret

0000000080005690 <usertrapret>:
    80005690:	ff010113          	addi	sp,sp,-16
    80005694:	00813423          	sd	s0,8(sp)
    80005698:	01010413          	addi	s0,sp,16
    8000569c:	00813403          	ld	s0,8(sp)
    800056a0:	01010113          	addi	sp,sp,16
    800056a4:	00008067          	ret

00000000800056a8 <kerneltrap>:
    800056a8:	fe010113          	addi	sp,sp,-32
    800056ac:	00813823          	sd	s0,16(sp)
    800056b0:	00113c23          	sd	ra,24(sp)
    800056b4:	00913423          	sd	s1,8(sp)
    800056b8:	02010413          	addi	s0,sp,32
    800056bc:	142025f3          	csrr	a1,scause
    800056c0:	100027f3          	csrr	a5,sstatus
    800056c4:	0027f793          	andi	a5,a5,2
    800056c8:	10079c63          	bnez	a5,800057e0 <kerneltrap+0x138>
    800056cc:	142027f3          	csrr	a5,scause
    800056d0:	0207ce63          	bltz	a5,8000570c <kerneltrap+0x64>
    800056d4:	00003517          	auipc	a0,0x3
    800056d8:	fd450513          	addi	a0,a0,-44 # 800086a8 <CONSOLE_STATUS+0x698>
    800056dc:	00001097          	auipc	ra,0x1
    800056e0:	88c080e7          	jalr	-1908(ra) # 80005f68 <__printf>
    800056e4:	141025f3          	csrr	a1,sepc
    800056e8:	14302673          	csrr	a2,stval
    800056ec:	00003517          	auipc	a0,0x3
    800056f0:	fcc50513          	addi	a0,a0,-52 # 800086b8 <CONSOLE_STATUS+0x6a8>
    800056f4:	00001097          	auipc	ra,0x1
    800056f8:	874080e7          	jalr	-1932(ra) # 80005f68 <__printf>
    800056fc:	00003517          	auipc	a0,0x3
    80005700:	fd450513          	addi	a0,a0,-44 # 800086d0 <CONSOLE_STATUS+0x6c0>
    80005704:	00001097          	auipc	ra,0x1
    80005708:	808080e7          	jalr	-2040(ra) # 80005f0c <panic>
    8000570c:	0ff7f713          	andi	a4,a5,255
    80005710:	00900693          	li	a3,9
    80005714:	04d70063          	beq	a4,a3,80005754 <kerneltrap+0xac>
    80005718:	fff00713          	li	a4,-1
    8000571c:	03f71713          	slli	a4,a4,0x3f
    80005720:	00170713          	addi	a4,a4,1
    80005724:	fae798e3          	bne	a5,a4,800056d4 <kerneltrap+0x2c>
    80005728:	00000097          	auipc	ra,0x0
    8000572c:	e00080e7          	jalr	-512(ra) # 80005528 <cpuid>
    80005730:	06050663          	beqz	a0,8000579c <kerneltrap+0xf4>
    80005734:	144027f3          	csrr	a5,sip
    80005738:	ffd7f793          	andi	a5,a5,-3
    8000573c:	14479073          	csrw	sip,a5
    80005740:	01813083          	ld	ra,24(sp)
    80005744:	01013403          	ld	s0,16(sp)
    80005748:	00813483          	ld	s1,8(sp)
    8000574c:	02010113          	addi	sp,sp,32
    80005750:	00008067          	ret
    80005754:	00000097          	auipc	ra,0x0
    80005758:	3d0080e7          	jalr	976(ra) # 80005b24 <plic_claim>
    8000575c:	00a00793          	li	a5,10
    80005760:	00050493          	mv	s1,a0
    80005764:	06f50863          	beq	a0,a5,800057d4 <kerneltrap+0x12c>
    80005768:	fc050ce3          	beqz	a0,80005740 <kerneltrap+0x98>
    8000576c:	00050593          	mv	a1,a0
    80005770:	00003517          	auipc	a0,0x3
    80005774:	f1850513          	addi	a0,a0,-232 # 80008688 <CONSOLE_STATUS+0x678>
    80005778:	00000097          	auipc	ra,0x0
    8000577c:	7f0080e7          	jalr	2032(ra) # 80005f68 <__printf>
    80005780:	01013403          	ld	s0,16(sp)
    80005784:	01813083          	ld	ra,24(sp)
    80005788:	00048513          	mv	a0,s1
    8000578c:	00813483          	ld	s1,8(sp)
    80005790:	02010113          	addi	sp,sp,32
    80005794:	00000317          	auipc	t1,0x0
    80005798:	3c830067          	jr	968(t1) # 80005b5c <plic_complete>
    8000579c:	00007517          	auipc	a0,0x7
    800057a0:	b6450513          	addi	a0,a0,-1180 # 8000c300 <tickslock>
    800057a4:	00001097          	auipc	ra,0x1
    800057a8:	498080e7          	jalr	1176(ra) # 80006c3c <acquire>
    800057ac:	00006717          	auipc	a4,0x6
    800057b0:	82870713          	addi	a4,a4,-2008 # 8000afd4 <ticks>
    800057b4:	00072783          	lw	a5,0(a4)
    800057b8:	00007517          	auipc	a0,0x7
    800057bc:	b4850513          	addi	a0,a0,-1208 # 8000c300 <tickslock>
    800057c0:	0017879b          	addiw	a5,a5,1
    800057c4:	00f72023          	sw	a5,0(a4)
    800057c8:	00001097          	auipc	ra,0x1
    800057cc:	540080e7          	jalr	1344(ra) # 80006d08 <release>
    800057d0:	f65ff06f          	j	80005734 <kerneltrap+0x8c>
    800057d4:	00001097          	auipc	ra,0x1
    800057d8:	09c080e7          	jalr	156(ra) # 80006870 <uartintr>
    800057dc:	fa5ff06f          	j	80005780 <kerneltrap+0xd8>
    800057e0:	00003517          	auipc	a0,0x3
    800057e4:	e8850513          	addi	a0,a0,-376 # 80008668 <CONSOLE_STATUS+0x658>
    800057e8:	00000097          	auipc	ra,0x0
    800057ec:	724080e7          	jalr	1828(ra) # 80005f0c <panic>

00000000800057f0 <clockintr>:
    800057f0:	fe010113          	addi	sp,sp,-32
    800057f4:	00813823          	sd	s0,16(sp)
    800057f8:	00913423          	sd	s1,8(sp)
    800057fc:	00113c23          	sd	ra,24(sp)
    80005800:	02010413          	addi	s0,sp,32
    80005804:	00007497          	auipc	s1,0x7
    80005808:	afc48493          	addi	s1,s1,-1284 # 8000c300 <tickslock>
    8000580c:	00048513          	mv	a0,s1
    80005810:	00001097          	auipc	ra,0x1
    80005814:	42c080e7          	jalr	1068(ra) # 80006c3c <acquire>
    80005818:	00005717          	auipc	a4,0x5
    8000581c:	7bc70713          	addi	a4,a4,1980 # 8000afd4 <ticks>
    80005820:	00072783          	lw	a5,0(a4)
    80005824:	01013403          	ld	s0,16(sp)
    80005828:	01813083          	ld	ra,24(sp)
    8000582c:	00048513          	mv	a0,s1
    80005830:	0017879b          	addiw	a5,a5,1
    80005834:	00813483          	ld	s1,8(sp)
    80005838:	00f72023          	sw	a5,0(a4)
    8000583c:	02010113          	addi	sp,sp,32
    80005840:	00001317          	auipc	t1,0x1
    80005844:	4c830067          	jr	1224(t1) # 80006d08 <release>

0000000080005848 <devintr>:
    80005848:	142027f3          	csrr	a5,scause
    8000584c:	00000513          	li	a0,0
    80005850:	0007c463          	bltz	a5,80005858 <devintr+0x10>
    80005854:	00008067          	ret
    80005858:	fe010113          	addi	sp,sp,-32
    8000585c:	00813823          	sd	s0,16(sp)
    80005860:	00113c23          	sd	ra,24(sp)
    80005864:	00913423          	sd	s1,8(sp)
    80005868:	02010413          	addi	s0,sp,32
    8000586c:	0ff7f713          	andi	a4,a5,255
    80005870:	00900693          	li	a3,9
    80005874:	04d70c63          	beq	a4,a3,800058cc <devintr+0x84>
    80005878:	fff00713          	li	a4,-1
    8000587c:	03f71713          	slli	a4,a4,0x3f
    80005880:	00170713          	addi	a4,a4,1
    80005884:	00e78c63          	beq	a5,a4,8000589c <devintr+0x54>
    80005888:	01813083          	ld	ra,24(sp)
    8000588c:	01013403          	ld	s0,16(sp)
    80005890:	00813483          	ld	s1,8(sp)
    80005894:	02010113          	addi	sp,sp,32
    80005898:	00008067          	ret
    8000589c:	00000097          	auipc	ra,0x0
    800058a0:	c8c080e7          	jalr	-884(ra) # 80005528 <cpuid>
    800058a4:	06050663          	beqz	a0,80005910 <devintr+0xc8>
    800058a8:	144027f3          	csrr	a5,sip
    800058ac:	ffd7f793          	andi	a5,a5,-3
    800058b0:	14479073          	csrw	sip,a5
    800058b4:	01813083          	ld	ra,24(sp)
    800058b8:	01013403          	ld	s0,16(sp)
    800058bc:	00813483          	ld	s1,8(sp)
    800058c0:	00200513          	li	a0,2
    800058c4:	02010113          	addi	sp,sp,32
    800058c8:	00008067          	ret
    800058cc:	00000097          	auipc	ra,0x0
    800058d0:	258080e7          	jalr	600(ra) # 80005b24 <plic_claim>
    800058d4:	00a00793          	li	a5,10
    800058d8:	00050493          	mv	s1,a0
    800058dc:	06f50663          	beq	a0,a5,80005948 <devintr+0x100>
    800058e0:	00100513          	li	a0,1
    800058e4:	fa0482e3          	beqz	s1,80005888 <devintr+0x40>
    800058e8:	00048593          	mv	a1,s1
    800058ec:	00003517          	auipc	a0,0x3
    800058f0:	d9c50513          	addi	a0,a0,-612 # 80008688 <CONSOLE_STATUS+0x678>
    800058f4:	00000097          	auipc	ra,0x0
    800058f8:	674080e7          	jalr	1652(ra) # 80005f68 <__printf>
    800058fc:	00048513          	mv	a0,s1
    80005900:	00000097          	auipc	ra,0x0
    80005904:	25c080e7          	jalr	604(ra) # 80005b5c <plic_complete>
    80005908:	00100513          	li	a0,1
    8000590c:	f7dff06f          	j	80005888 <devintr+0x40>
    80005910:	00007517          	auipc	a0,0x7
    80005914:	9f050513          	addi	a0,a0,-1552 # 8000c300 <tickslock>
    80005918:	00001097          	auipc	ra,0x1
    8000591c:	324080e7          	jalr	804(ra) # 80006c3c <acquire>
    80005920:	00005717          	auipc	a4,0x5
    80005924:	6b470713          	addi	a4,a4,1716 # 8000afd4 <ticks>
    80005928:	00072783          	lw	a5,0(a4)
    8000592c:	00007517          	auipc	a0,0x7
    80005930:	9d450513          	addi	a0,a0,-1580 # 8000c300 <tickslock>
    80005934:	0017879b          	addiw	a5,a5,1
    80005938:	00f72023          	sw	a5,0(a4)
    8000593c:	00001097          	auipc	ra,0x1
    80005940:	3cc080e7          	jalr	972(ra) # 80006d08 <release>
    80005944:	f65ff06f          	j	800058a8 <devintr+0x60>
    80005948:	00001097          	auipc	ra,0x1
    8000594c:	f28080e7          	jalr	-216(ra) # 80006870 <uartintr>
    80005950:	fadff06f          	j	800058fc <devintr+0xb4>
	...

0000000080005960 <kernelvec>:
    80005960:	f0010113          	addi	sp,sp,-256
    80005964:	00113023          	sd	ra,0(sp)
    80005968:	00213423          	sd	sp,8(sp)
    8000596c:	00313823          	sd	gp,16(sp)
    80005970:	00413c23          	sd	tp,24(sp)
    80005974:	02513023          	sd	t0,32(sp)
    80005978:	02613423          	sd	t1,40(sp)
    8000597c:	02713823          	sd	t2,48(sp)
    80005980:	02813c23          	sd	s0,56(sp)
    80005984:	04913023          	sd	s1,64(sp)
    80005988:	04a13423          	sd	a0,72(sp)
    8000598c:	04b13823          	sd	a1,80(sp)
    80005990:	04c13c23          	sd	a2,88(sp)
    80005994:	06d13023          	sd	a3,96(sp)
    80005998:	06e13423          	sd	a4,104(sp)
    8000599c:	06f13823          	sd	a5,112(sp)
    800059a0:	07013c23          	sd	a6,120(sp)
    800059a4:	09113023          	sd	a7,128(sp)
    800059a8:	09213423          	sd	s2,136(sp)
    800059ac:	09313823          	sd	s3,144(sp)
    800059b0:	09413c23          	sd	s4,152(sp)
    800059b4:	0b513023          	sd	s5,160(sp)
    800059b8:	0b613423          	sd	s6,168(sp)
    800059bc:	0b713823          	sd	s7,176(sp)
    800059c0:	0b813c23          	sd	s8,184(sp)
    800059c4:	0d913023          	sd	s9,192(sp)
    800059c8:	0da13423          	sd	s10,200(sp)
    800059cc:	0db13823          	sd	s11,208(sp)
    800059d0:	0dc13c23          	sd	t3,216(sp)
    800059d4:	0fd13023          	sd	t4,224(sp)
    800059d8:	0fe13423          	sd	t5,232(sp)
    800059dc:	0ff13823          	sd	t6,240(sp)
    800059e0:	cc9ff0ef          	jal	ra,800056a8 <kerneltrap>
    800059e4:	00013083          	ld	ra,0(sp)
    800059e8:	00813103          	ld	sp,8(sp)
    800059ec:	01013183          	ld	gp,16(sp)
    800059f0:	02013283          	ld	t0,32(sp)
    800059f4:	02813303          	ld	t1,40(sp)
    800059f8:	03013383          	ld	t2,48(sp)
    800059fc:	03813403          	ld	s0,56(sp)
    80005a00:	04013483          	ld	s1,64(sp)
    80005a04:	04813503          	ld	a0,72(sp)
    80005a08:	05013583          	ld	a1,80(sp)
    80005a0c:	05813603          	ld	a2,88(sp)
    80005a10:	06013683          	ld	a3,96(sp)
    80005a14:	06813703          	ld	a4,104(sp)
    80005a18:	07013783          	ld	a5,112(sp)
    80005a1c:	07813803          	ld	a6,120(sp)
    80005a20:	08013883          	ld	a7,128(sp)
    80005a24:	08813903          	ld	s2,136(sp)
    80005a28:	09013983          	ld	s3,144(sp)
    80005a2c:	09813a03          	ld	s4,152(sp)
    80005a30:	0a013a83          	ld	s5,160(sp)
    80005a34:	0a813b03          	ld	s6,168(sp)
    80005a38:	0b013b83          	ld	s7,176(sp)
    80005a3c:	0b813c03          	ld	s8,184(sp)
    80005a40:	0c013c83          	ld	s9,192(sp)
    80005a44:	0c813d03          	ld	s10,200(sp)
    80005a48:	0d013d83          	ld	s11,208(sp)
    80005a4c:	0d813e03          	ld	t3,216(sp)
    80005a50:	0e013e83          	ld	t4,224(sp)
    80005a54:	0e813f03          	ld	t5,232(sp)
    80005a58:	0f013f83          	ld	t6,240(sp)
    80005a5c:	10010113          	addi	sp,sp,256
    80005a60:	10200073          	sret
    80005a64:	00000013          	nop
    80005a68:	00000013          	nop
    80005a6c:	00000013          	nop

0000000080005a70 <timervec>:
    80005a70:	34051573          	csrrw	a0,mscratch,a0
    80005a74:	00b53023          	sd	a1,0(a0)
    80005a78:	00c53423          	sd	a2,8(a0)
    80005a7c:	00d53823          	sd	a3,16(a0)
    80005a80:	01853583          	ld	a1,24(a0)
    80005a84:	02053603          	ld	a2,32(a0)
    80005a88:	0005b683          	ld	a3,0(a1)
    80005a8c:	00c686b3          	add	a3,a3,a2
    80005a90:	00d5b023          	sd	a3,0(a1)
    80005a94:	00200593          	li	a1,2
    80005a98:	14459073          	csrw	sip,a1
    80005a9c:	01053683          	ld	a3,16(a0)
    80005aa0:	00853603          	ld	a2,8(a0)
    80005aa4:	00053583          	ld	a1,0(a0)
    80005aa8:	34051573          	csrrw	a0,mscratch,a0
    80005aac:	30200073          	mret

0000000080005ab0 <plicinit>:
    80005ab0:	ff010113          	addi	sp,sp,-16
    80005ab4:	00813423          	sd	s0,8(sp)
    80005ab8:	01010413          	addi	s0,sp,16
    80005abc:	00813403          	ld	s0,8(sp)
    80005ac0:	0c0007b7          	lui	a5,0xc000
    80005ac4:	00100713          	li	a4,1
    80005ac8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80005acc:	00e7a223          	sw	a4,4(a5)
    80005ad0:	01010113          	addi	sp,sp,16
    80005ad4:	00008067          	ret

0000000080005ad8 <plicinithart>:
    80005ad8:	ff010113          	addi	sp,sp,-16
    80005adc:	00813023          	sd	s0,0(sp)
    80005ae0:	00113423          	sd	ra,8(sp)
    80005ae4:	01010413          	addi	s0,sp,16
    80005ae8:	00000097          	auipc	ra,0x0
    80005aec:	a40080e7          	jalr	-1472(ra) # 80005528 <cpuid>
    80005af0:	0085171b          	slliw	a4,a0,0x8
    80005af4:	0c0027b7          	lui	a5,0xc002
    80005af8:	00e787b3          	add	a5,a5,a4
    80005afc:	40200713          	li	a4,1026
    80005b00:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005b04:	00813083          	ld	ra,8(sp)
    80005b08:	00013403          	ld	s0,0(sp)
    80005b0c:	00d5151b          	slliw	a0,a0,0xd
    80005b10:	0c2017b7          	lui	a5,0xc201
    80005b14:	00a78533          	add	a0,a5,a0
    80005b18:	00052023          	sw	zero,0(a0)
    80005b1c:	01010113          	addi	sp,sp,16
    80005b20:	00008067          	ret

0000000080005b24 <plic_claim>:
    80005b24:	ff010113          	addi	sp,sp,-16
    80005b28:	00813023          	sd	s0,0(sp)
    80005b2c:	00113423          	sd	ra,8(sp)
    80005b30:	01010413          	addi	s0,sp,16
    80005b34:	00000097          	auipc	ra,0x0
    80005b38:	9f4080e7          	jalr	-1548(ra) # 80005528 <cpuid>
    80005b3c:	00813083          	ld	ra,8(sp)
    80005b40:	00013403          	ld	s0,0(sp)
    80005b44:	00d5151b          	slliw	a0,a0,0xd
    80005b48:	0c2017b7          	lui	a5,0xc201
    80005b4c:	00a78533          	add	a0,a5,a0
    80005b50:	00452503          	lw	a0,4(a0)
    80005b54:	01010113          	addi	sp,sp,16
    80005b58:	00008067          	ret

0000000080005b5c <plic_complete>:
    80005b5c:	fe010113          	addi	sp,sp,-32
    80005b60:	00813823          	sd	s0,16(sp)
    80005b64:	00913423          	sd	s1,8(sp)
    80005b68:	00113c23          	sd	ra,24(sp)
    80005b6c:	02010413          	addi	s0,sp,32
    80005b70:	00050493          	mv	s1,a0
    80005b74:	00000097          	auipc	ra,0x0
    80005b78:	9b4080e7          	jalr	-1612(ra) # 80005528 <cpuid>
    80005b7c:	01813083          	ld	ra,24(sp)
    80005b80:	01013403          	ld	s0,16(sp)
    80005b84:	00d5179b          	slliw	a5,a0,0xd
    80005b88:	0c201737          	lui	a4,0xc201
    80005b8c:	00f707b3          	add	a5,a4,a5
    80005b90:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005b94:	00813483          	ld	s1,8(sp)
    80005b98:	02010113          	addi	sp,sp,32
    80005b9c:	00008067          	ret

0000000080005ba0 <consolewrite>:
    80005ba0:	fb010113          	addi	sp,sp,-80
    80005ba4:	04813023          	sd	s0,64(sp)
    80005ba8:	04113423          	sd	ra,72(sp)
    80005bac:	02913c23          	sd	s1,56(sp)
    80005bb0:	03213823          	sd	s2,48(sp)
    80005bb4:	03313423          	sd	s3,40(sp)
    80005bb8:	03413023          	sd	s4,32(sp)
    80005bbc:	01513c23          	sd	s5,24(sp)
    80005bc0:	05010413          	addi	s0,sp,80
    80005bc4:	06c05c63          	blez	a2,80005c3c <consolewrite+0x9c>
    80005bc8:	00060993          	mv	s3,a2
    80005bcc:	00050a13          	mv	s4,a0
    80005bd0:	00058493          	mv	s1,a1
    80005bd4:	00000913          	li	s2,0
    80005bd8:	fff00a93          	li	s5,-1
    80005bdc:	01c0006f          	j	80005bf8 <consolewrite+0x58>
    80005be0:	fbf44503          	lbu	a0,-65(s0)
    80005be4:	0019091b          	addiw	s2,s2,1
    80005be8:	00148493          	addi	s1,s1,1
    80005bec:	00001097          	auipc	ra,0x1
    80005bf0:	a9c080e7          	jalr	-1380(ra) # 80006688 <uartputc>
    80005bf4:	03298063          	beq	s3,s2,80005c14 <consolewrite+0x74>
    80005bf8:	00048613          	mv	a2,s1
    80005bfc:	00100693          	li	a3,1
    80005c00:	000a0593          	mv	a1,s4
    80005c04:	fbf40513          	addi	a0,s0,-65
    80005c08:	00000097          	auipc	ra,0x0
    80005c0c:	9d8080e7          	jalr	-1576(ra) # 800055e0 <either_copyin>
    80005c10:	fd5518e3          	bne	a0,s5,80005be0 <consolewrite+0x40>
    80005c14:	04813083          	ld	ra,72(sp)
    80005c18:	04013403          	ld	s0,64(sp)
    80005c1c:	03813483          	ld	s1,56(sp)
    80005c20:	02813983          	ld	s3,40(sp)
    80005c24:	02013a03          	ld	s4,32(sp)
    80005c28:	01813a83          	ld	s5,24(sp)
    80005c2c:	00090513          	mv	a0,s2
    80005c30:	03013903          	ld	s2,48(sp)
    80005c34:	05010113          	addi	sp,sp,80
    80005c38:	00008067          	ret
    80005c3c:	00000913          	li	s2,0
    80005c40:	fd5ff06f          	j	80005c14 <consolewrite+0x74>

0000000080005c44 <consoleread>:
    80005c44:	f9010113          	addi	sp,sp,-112
    80005c48:	06813023          	sd	s0,96(sp)
    80005c4c:	04913c23          	sd	s1,88(sp)
    80005c50:	05213823          	sd	s2,80(sp)
    80005c54:	05313423          	sd	s3,72(sp)
    80005c58:	05413023          	sd	s4,64(sp)
    80005c5c:	03513c23          	sd	s5,56(sp)
    80005c60:	03613823          	sd	s6,48(sp)
    80005c64:	03713423          	sd	s7,40(sp)
    80005c68:	03813023          	sd	s8,32(sp)
    80005c6c:	06113423          	sd	ra,104(sp)
    80005c70:	01913c23          	sd	s9,24(sp)
    80005c74:	07010413          	addi	s0,sp,112
    80005c78:	00060b93          	mv	s7,a2
    80005c7c:	00050913          	mv	s2,a0
    80005c80:	00058c13          	mv	s8,a1
    80005c84:	00060b1b          	sext.w	s6,a2
    80005c88:	00006497          	auipc	s1,0x6
    80005c8c:	6a048493          	addi	s1,s1,1696 # 8000c328 <cons>
    80005c90:	00400993          	li	s3,4
    80005c94:	fff00a13          	li	s4,-1
    80005c98:	00a00a93          	li	s5,10
    80005c9c:	05705e63          	blez	s7,80005cf8 <consoleread+0xb4>
    80005ca0:	09c4a703          	lw	a4,156(s1)
    80005ca4:	0984a783          	lw	a5,152(s1)
    80005ca8:	0007071b          	sext.w	a4,a4
    80005cac:	08e78463          	beq	a5,a4,80005d34 <consoleread+0xf0>
    80005cb0:	07f7f713          	andi	a4,a5,127
    80005cb4:	00e48733          	add	a4,s1,a4
    80005cb8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005cbc:	0017869b          	addiw	a3,a5,1
    80005cc0:	08d4ac23          	sw	a3,152(s1)
    80005cc4:	00070c9b          	sext.w	s9,a4
    80005cc8:	0b370663          	beq	a4,s3,80005d74 <consoleread+0x130>
    80005ccc:	00100693          	li	a3,1
    80005cd0:	f9f40613          	addi	a2,s0,-97
    80005cd4:	000c0593          	mv	a1,s8
    80005cd8:	00090513          	mv	a0,s2
    80005cdc:	f8e40fa3          	sb	a4,-97(s0)
    80005ce0:	00000097          	auipc	ra,0x0
    80005ce4:	8b4080e7          	jalr	-1868(ra) # 80005594 <either_copyout>
    80005ce8:	01450863          	beq	a0,s4,80005cf8 <consoleread+0xb4>
    80005cec:	001c0c13          	addi	s8,s8,1
    80005cf0:	fffb8b9b          	addiw	s7,s7,-1
    80005cf4:	fb5c94e3          	bne	s9,s5,80005c9c <consoleread+0x58>
    80005cf8:	000b851b          	sext.w	a0,s7
    80005cfc:	06813083          	ld	ra,104(sp)
    80005d00:	06013403          	ld	s0,96(sp)
    80005d04:	05813483          	ld	s1,88(sp)
    80005d08:	05013903          	ld	s2,80(sp)
    80005d0c:	04813983          	ld	s3,72(sp)
    80005d10:	04013a03          	ld	s4,64(sp)
    80005d14:	03813a83          	ld	s5,56(sp)
    80005d18:	02813b83          	ld	s7,40(sp)
    80005d1c:	02013c03          	ld	s8,32(sp)
    80005d20:	01813c83          	ld	s9,24(sp)
    80005d24:	40ab053b          	subw	a0,s6,a0
    80005d28:	03013b03          	ld	s6,48(sp)
    80005d2c:	07010113          	addi	sp,sp,112
    80005d30:	00008067          	ret
    80005d34:	00001097          	auipc	ra,0x1
    80005d38:	1d8080e7          	jalr	472(ra) # 80006f0c <push_on>
    80005d3c:	0984a703          	lw	a4,152(s1)
    80005d40:	09c4a783          	lw	a5,156(s1)
    80005d44:	0007879b          	sext.w	a5,a5
    80005d48:	fef70ce3          	beq	a4,a5,80005d40 <consoleread+0xfc>
    80005d4c:	00001097          	auipc	ra,0x1
    80005d50:	234080e7          	jalr	564(ra) # 80006f80 <pop_on>
    80005d54:	0984a783          	lw	a5,152(s1)
    80005d58:	07f7f713          	andi	a4,a5,127
    80005d5c:	00e48733          	add	a4,s1,a4
    80005d60:	01874703          	lbu	a4,24(a4)
    80005d64:	0017869b          	addiw	a3,a5,1
    80005d68:	08d4ac23          	sw	a3,152(s1)
    80005d6c:	00070c9b          	sext.w	s9,a4
    80005d70:	f5371ee3          	bne	a4,s3,80005ccc <consoleread+0x88>
    80005d74:	000b851b          	sext.w	a0,s7
    80005d78:	f96bf2e3          	bgeu	s7,s6,80005cfc <consoleread+0xb8>
    80005d7c:	08f4ac23          	sw	a5,152(s1)
    80005d80:	f7dff06f          	j	80005cfc <consoleread+0xb8>

0000000080005d84 <consputc>:
    80005d84:	10000793          	li	a5,256
    80005d88:	00f50663          	beq	a0,a5,80005d94 <consputc+0x10>
    80005d8c:	00001317          	auipc	t1,0x1
    80005d90:	9f430067          	jr	-1548(t1) # 80006780 <uartputc_sync>
    80005d94:	ff010113          	addi	sp,sp,-16
    80005d98:	00113423          	sd	ra,8(sp)
    80005d9c:	00813023          	sd	s0,0(sp)
    80005da0:	01010413          	addi	s0,sp,16
    80005da4:	00800513          	li	a0,8
    80005da8:	00001097          	auipc	ra,0x1
    80005dac:	9d8080e7          	jalr	-1576(ra) # 80006780 <uartputc_sync>
    80005db0:	02000513          	li	a0,32
    80005db4:	00001097          	auipc	ra,0x1
    80005db8:	9cc080e7          	jalr	-1588(ra) # 80006780 <uartputc_sync>
    80005dbc:	00013403          	ld	s0,0(sp)
    80005dc0:	00813083          	ld	ra,8(sp)
    80005dc4:	00800513          	li	a0,8
    80005dc8:	01010113          	addi	sp,sp,16
    80005dcc:	00001317          	auipc	t1,0x1
    80005dd0:	9b430067          	jr	-1612(t1) # 80006780 <uartputc_sync>

0000000080005dd4 <consoleintr>:
    80005dd4:	fe010113          	addi	sp,sp,-32
    80005dd8:	00813823          	sd	s0,16(sp)
    80005ddc:	00913423          	sd	s1,8(sp)
    80005de0:	01213023          	sd	s2,0(sp)
    80005de4:	00113c23          	sd	ra,24(sp)
    80005de8:	02010413          	addi	s0,sp,32
    80005dec:	00006917          	auipc	s2,0x6
    80005df0:	53c90913          	addi	s2,s2,1340 # 8000c328 <cons>
    80005df4:	00050493          	mv	s1,a0
    80005df8:	00090513          	mv	a0,s2
    80005dfc:	00001097          	auipc	ra,0x1
    80005e00:	e40080e7          	jalr	-448(ra) # 80006c3c <acquire>
    80005e04:	02048c63          	beqz	s1,80005e3c <consoleintr+0x68>
    80005e08:	0a092783          	lw	a5,160(s2)
    80005e0c:	09892703          	lw	a4,152(s2)
    80005e10:	07f00693          	li	a3,127
    80005e14:	40e7873b          	subw	a4,a5,a4
    80005e18:	02e6e263          	bltu	a3,a4,80005e3c <consoleintr+0x68>
    80005e1c:	00d00713          	li	a4,13
    80005e20:	04e48063          	beq	s1,a4,80005e60 <consoleintr+0x8c>
    80005e24:	07f7f713          	andi	a4,a5,127
    80005e28:	00e90733          	add	a4,s2,a4
    80005e2c:	0017879b          	addiw	a5,a5,1
    80005e30:	0af92023          	sw	a5,160(s2)
    80005e34:	00970c23          	sb	s1,24(a4)
    80005e38:	08f92e23          	sw	a5,156(s2)
    80005e3c:	01013403          	ld	s0,16(sp)
    80005e40:	01813083          	ld	ra,24(sp)
    80005e44:	00813483          	ld	s1,8(sp)
    80005e48:	00013903          	ld	s2,0(sp)
    80005e4c:	00006517          	auipc	a0,0x6
    80005e50:	4dc50513          	addi	a0,a0,1244 # 8000c328 <cons>
    80005e54:	02010113          	addi	sp,sp,32
    80005e58:	00001317          	auipc	t1,0x1
    80005e5c:	eb030067          	jr	-336(t1) # 80006d08 <release>
    80005e60:	00a00493          	li	s1,10
    80005e64:	fc1ff06f          	j	80005e24 <consoleintr+0x50>

0000000080005e68 <consoleinit>:
    80005e68:	fe010113          	addi	sp,sp,-32
    80005e6c:	00113c23          	sd	ra,24(sp)
    80005e70:	00813823          	sd	s0,16(sp)
    80005e74:	00913423          	sd	s1,8(sp)
    80005e78:	02010413          	addi	s0,sp,32
    80005e7c:	00006497          	auipc	s1,0x6
    80005e80:	4ac48493          	addi	s1,s1,1196 # 8000c328 <cons>
    80005e84:	00048513          	mv	a0,s1
    80005e88:	00003597          	auipc	a1,0x3
    80005e8c:	85858593          	addi	a1,a1,-1960 # 800086e0 <CONSOLE_STATUS+0x6d0>
    80005e90:	00001097          	auipc	ra,0x1
    80005e94:	d88080e7          	jalr	-632(ra) # 80006c18 <initlock>
    80005e98:	00000097          	auipc	ra,0x0
    80005e9c:	7ac080e7          	jalr	1964(ra) # 80006644 <uartinit>
    80005ea0:	01813083          	ld	ra,24(sp)
    80005ea4:	01013403          	ld	s0,16(sp)
    80005ea8:	00000797          	auipc	a5,0x0
    80005eac:	d9c78793          	addi	a5,a5,-612 # 80005c44 <consoleread>
    80005eb0:	0af4bc23          	sd	a5,184(s1)
    80005eb4:	00000797          	auipc	a5,0x0
    80005eb8:	cec78793          	addi	a5,a5,-788 # 80005ba0 <consolewrite>
    80005ebc:	0cf4b023          	sd	a5,192(s1)
    80005ec0:	00813483          	ld	s1,8(sp)
    80005ec4:	02010113          	addi	sp,sp,32
    80005ec8:	00008067          	ret

0000000080005ecc <console_read>:
    80005ecc:	ff010113          	addi	sp,sp,-16
    80005ed0:	00813423          	sd	s0,8(sp)
    80005ed4:	01010413          	addi	s0,sp,16
    80005ed8:	00813403          	ld	s0,8(sp)
    80005edc:	00006317          	auipc	t1,0x6
    80005ee0:	50433303          	ld	t1,1284(t1) # 8000c3e0 <devsw+0x10>
    80005ee4:	01010113          	addi	sp,sp,16
    80005ee8:	00030067          	jr	t1

0000000080005eec <console_write>:
    80005eec:	ff010113          	addi	sp,sp,-16
    80005ef0:	00813423          	sd	s0,8(sp)
    80005ef4:	01010413          	addi	s0,sp,16
    80005ef8:	00813403          	ld	s0,8(sp)
    80005efc:	00006317          	auipc	t1,0x6
    80005f00:	4ec33303          	ld	t1,1260(t1) # 8000c3e8 <devsw+0x18>
    80005f04:	01010113          	addi	sp,sp,16
    80005f08:	00030067          	jr	t1

0000000080005f0c <panic>:
    80005f0c:	fe010113          	addi	sp,sp,-32
    80005f10:	00113c23          	sd	ra,24(sp)
    80005f14:	00813823          	sd	s0,16(sp)
    80005f18:	00913423          	sd	s1,8(sp)
    80005f1c:	02010413          	addi	s0,sp,32
    80005f20:	00050493          	mv	s1,a0
    80005f24:	00002517          	auipc	a0,0x2
    80005f28:	7c450513          	addi	a0,a0,1988 # 800086e8 <CONSOLE_STATUS+0x6d8>
    80005f2c:	00006797          	auipc	a5,0x6
    80005f30:	5407ae23          	sw	zero,1372(a5) # 8000c488 <pr+0x18>
    80005f34:	00000097          	auipc	ra,0x0
    80005f38:	034080e7          	jalr	52(ra) # 80005f68 <__printf>
    80005f3c:	00048513          	mv	a0,s1
    80005f40:	00000097          	auipc	ra,0x0
    80005f44:	028080e7          	jalr	40(ra) # 80005f68 <__printf>
    80005f48:	00002517          	auipc	a0,0x2
    80005f4c:	1d050513          	addi	a0,a0,464 # 80008118 <CONSOLE_STATUS+0x108>
    80005f50:	00000097          	auipc	ra,0x0
    80005f54:	018080e7          	jalr	24(ra) # 80005f68 <__printf>
    80005f58:	00100793          	li	a5,1
    80005f5c:	00005717          	auipc	a4,0x5
    80005f60:	06f72e23          	sw	a5,124(a4) # 8000afd8 <panicked>
    80005f64:	0000006f          	j	80005f64 <panic+0x58>

0000000080005f68 <__printf>:
    80005f68:	f3010113          	addi	sp,sp,-208
    80005f6c:	08813023          	sd	s0,128(sp)
    80005f70:	07313423          	sd	s3,104(sp)
    80005f74:	09010413          	addi	s0,sp,144
    80005f78:	05813023          	sd	s8,64(sp)
    80005f7c:	08113423          	sd	ra,136(sp)
    80005f80:	06913c23          	sd	s1,120(sp)
    80005f84:	07213823          	sd	s2,112(sp)
    80005f88:	07413023          	sd	s4,96(sp)
    80005f8c:	05513c23          	sd	s5,88(sp)
    80005f90:	05613823          	sd	s6,80(sp)
    80005f94:	05713423          	sd	s7,72(sp)
    80005f98:	03913c23          	sd	s9,56(sp)
    80005f9c:	03a13823          	sd	s10,48(sp)
    80005fa0:	03b13423          	sd	s11,40(sp)
    80005fa4:	00006317          	auipc	t1,0x6
    80005fa8:	4cc30313          	addi	t1,t1,1228 # 8000c470 <pr>
    80005fac:	01832c03          	lw	s8,24(t1)
    80005fb0:	00b43423          	sd	a1,8(s0)
    80005fb4:	00c43823          	sd	a2,16(s0)
    80005fb8:	00d43c23          	sd	a3,24(s0)
    80005fbc:	02e43023          	sd	a4,32(s0)
    80005fc0:	02f43423          	sd	a5,40(s0)
    80005fc4:	03043823          	sd	a6,48(s0)
    80005fc8:	03143c23          	sd	a7,56(s0)
    80005fcc:	00050993          	mv	s3,a0
    80005fd0:	4a0c1663          	bnez	s8,8000647c <__printf+0x514>
    80005fd4:	60098c63          	beqz	s3,800065ec <__printf+0x684>
    80005fd8:	0009c503          	lbu	a0,0(s3)
    80005fdc:	00840793          	addi	a5,s0,8
    80005fe0:	f6f43c23          	sd	a5,-136(s0)
    80005fe4:	00000493          	li	s1,0
    80005fe8:	22050063          	beqz	a0,80006208 <__printf+0x2a0>
    80005fec:	00002a37          	lui	s4,0x2
    80005ff0:	00018ab7          	lui	s5,0x18
    80005ff4:	000f4b37          	lui	s6,0xf4
    80005ff8:	00989bb7          	lui	s7,0x989
    80005ffc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006000:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006004:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006008:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000600c:	00148c9b          	addiw	s9,s1,1
    80006010:	02500793          	li	a5,37
    80006014:	01998933          	add	s2,s3,s9
    80006018:	38f51263          	bne	a0,a5,8000639c <__printf+0x434>
    8000601c:	00094783          	lbu	a5,0(s2)
    80006020:	00078c9b          	sext.w	s9,a5
    80006024:	1e078263          	beqz	a5,80006208 <__printf+0x2a0>
    80006028:	0024849b          	addiw	s1,s1,2
    8000602c:	07000713          	li	a4,112
    80006030:	00998933          	add	s2,s3,s1
    80006034:	38e78a63          	beq	a5,a4,800063c8 <__printf+0x460>
    80006038:	20f76863          	bltu	a4,a5,80006248 <__printf+0x2e0>
    8000603c:	42a78863          	beq	a5,a0,8000646c <__printf+0x504>
    80006040:	06400713          	li	a4,100
    80006044:	40e79663          	bne	a5,a4,80006450 <__printf+0x4e8>
    80006048:	f7843783          	ld	a5,-136(s0)
    8000604c:	0007a603          	lw	a2,0(a5)
    80006050:	00878793          	addi	a5,a5,8
    80006054:	f6f43c23          	sd	a5,-136(s0)
    80006058:	42064a63          	bltz	a2,8000648c <__printf+0x524>
    8000605c:	00a00713          	li	a4,10
    80006060:	02e677bb          	remuw	a5,a2,a4
    80006064:	00002d97          	auipc	s11,0x2
    80006068:	6acd8d93          	addi	s11,s11,1708 # 80008710 <digits>
    8000606c:	00900593          	li	a1,9
    80006070:	0006051b          	sext.w	a0,a2
    80006074:	00000c93          	li	s9,0
    80006078:	02079793          	slli	a5,a5,0x20
    8000607c:	0207d793          	srli	a5,a5,0x20
    80006080:	00fd87b3          	add	a5,s11,a5
    80006084:	0007c783          	lbu	a5,0(a5)
    80006088:	02e656bb          	divuw	a3,a2,a4
    8000608c:	f8f40023          	sb	a5,-128(s0)
    80006090:	14c5d863          	bge	a1,a2,800061e0 <__printf+0x278>
    80006094:	06300593          	li	a1,99
    80006098:	00100c93          	li	s9,1
    8000609c:	02e6f7bb          	remuw	a5,a3,a4
    800060a0:	02079793          	slli	a5,a5,0x20
    800060a4:	0207d793          	srli	a5,a5,0x20
    800060a8:	00fd87b3          	add	a5,s11,a5
    800060ac:	0007c783          	lbu	a5,0(a5)
    800060b0:	02e6d73b          	divuw	a4,a3,a4
    800060b4:	f8f400a3          	sb	a5,-127(s0)
    800060b8:	12a5f463          	bgeu	a1,a0,800061e0 <__printf+0x278>
    800060bc:	00a00693          	li	a3,10
    800060c0:	00900593          	li	a1,9
    800060c4:	02d777bb          	remuw	a5,a4,a3
    800060c8:	02079793          	slli	a5,a5,0x20
    800060cc:	0207d793          	srli	a5,a5,0x20
    800060d0:	00fd87b3          	add	a5,s11,a5
    800060d4:	0007c503          	lbu	a0,0(a5)
    800060d8:	02d757bb          	divuw	a5,a4,a3
    800060dc:	f8a40123          	sb	a0,-126(s0)
    800060e0:	48e5f263          	bgeu	a1,a4,80006564 <__printf+0x5fc>
    800060e4:	06300513          	li	a0,99
    800060e8:	02d7f5bb          	remuw	a1,a5,a3
    800060ec:	02059593          	slli	a1,a1,0x20
    800060f0:	0205d593          	srli	a1,a1,0x20
    800060f4:	00bd85b3          	add	a1,s11,a1
    800060f8:	0005c583          	lbu	a1,0(a1)
    800060fc:	02d7d7bb          	divuw	a5,a5,a3
    80006100:	f8b401a3          	sb	a1,-125(s0)
    80006104:	48e57263          	bgeu	a0,a4,80006588 <__printf+0x620>
    80006108:	3e700513          	li	a0,999
    8000610c:	02d7f5bb          	remuw	a1,a5,a3
    80006110:	02059593          	slli	a1,a1,0x20
    80006114:	0205d593          	srli	a1,a1,0x20
    80006118:	00bd85b3          	add	a1,s11,a1
    8000611c:	0005c583          	lbu	a1,0(a1)
    80006120:	02d7d7bb          	divuw	a5,a5,a3
    80006124:	f8b40223          	sb	a1,-124(s0)
    80006128:	46e57663          	bgeu	a0,a4,80006594 <__printf+0x62c>
    8000612c:	02d7f5bb          	remuw	a1,a5,a3
    80006130:	02059593          	slli	a1,a1,0x20
    80006134:	0205d593          	srli	a1,a1,0x20
    80006138:	00bd85b3          	add	a1,s11,a1
    8000613c:	0005c583          	lbu	a1,0(a1)
    80006140:	02d7d7bb          	divuw	a5,a5,a3
    80006144:	f8b402a3          	sb	a1,-123(s0)
    80006148:	46ea7863          	bgeu	s4,a4,800065b8 <__printf+0x650>
    8000614c:	02d7f5bb          	remuw	a1,a5,a3
    80006150:	02059593          	slli	a1,a1,0x20
    80006154:	0205d593          	srli	a1,a1,0x20
    80006158:	00bd85b3          	add	a1,s11,a1
    8000615c:	0005c583          	lbu	a1,0(a1)
    80006160:	02d7d7bb          	divuw	a5,a5,a3
    80006164:	f8b40323          	sb	a1,-122(s0)
    80006168:	3eeaf863          	bgeu	s5,a4,80006558 <__printf+0x5f0>
    8000616c:	02d7f5bb          	remuw	a1,a5,a3
    80006170:	02059593          	slli	a1,a1,0x20
    80006174:	0205d593          	srli	a1,a1,0x20
    80006178:	00bd85b3          	add	a1,s11,a1
    8000617c:	0005c583          	lbu	a1,0(a1)
    80006180:	02d7d7bb          	divuw	a5,a5,a3
    80006184:	f8b403a3          	sb	a1,-121(s0)
    80006188:	42eb7e63          	bgeu	s6,a4,800065c4 <__printf+0x65c>
    8000618c:	02d7f5bb          	remuw	a1,a5,a3
    80006190:	02059593          	slli	a1,a1,0x20
    80006194:	0205d593          	srli	a1,a1,0x20
    80006198:	00bd85b3          	add	a1,s11,a1
    8000619c:	0005c583          	lbu	a1,0(a1)
    800061a0:	02d7d7bb          	divuw	a5,a5,a3
    800061a4:	f8b40423          	sb	a1,-120(s0)
    800061a8:	42ebfc63          	bgeu	s7,a4,800065e0 <__printf+0x678>
    800061ac:	02079793          	slli	a5,a5,0x20
    800061b0:	0207d793          	srli	a5,a5,0x20
    800061b4:	00fd8db3          	add	s11,s11,a5
    800061b8:	000dc703          	lbu	a4,0(s11)
    800061bc:	00a00793          	li	a5,10
    800061c0:	00900c93          	li	s9,9
    800061c4:	f8e404a3          	sb	a4,-119(s0)
    800061c8:	00065c63          	bgez	a2,800061e0 <__printf+0x278>
    800061cc:	f9040713          	addi	a4,s0,-112
    800061d0:	00f70733          	add	a4,a4,a5
    800061d4:	02d00693          	li	a3,45
    800061d8:	fed70823          	sb	a3,-16(a4)
    800061dc:	00078c93          	mv	s9,a5
    800061e0:	f8040793          	addi	a5,s0,-128
    800061e4:	01978cb3          	add	s9,a5,s9
    800061e8:	f7f40d13          	addi	s10,s0,-129
    800061ec:	000cc503          	lbu	a0,0(s9)
    800061f0:	fffc8c93          	addi	s9,s9,-1
    800061f4:	00000097          	auipc	ra,0x0
    800061f8:	b90080e7          	jalr	-1136(ra) # 80005d84 <consputc>
    800061fc:	ffac98e3          	bne	s9,s10,800061ec <__printf+0x284>
    80006200:	00094503          	lbu	a0,0(s2)
    80006204:	e00514e3          	bnez	a0,8000600c <__printf+0xa4>
    80006208:	1a0c1663          	bnez	s8,800063b4 <__printf+0x44c>
    8000620c:	08813083          	ld	ra,136(sp)
    80006210:	08013403          	ld	s0,128(sp)
    80006214:	07813483          	ld	s1,120(sp)
    80006218:	07013903          	ld	s2,112(sp)
    8000621c:	06813983          	ld	s3,104(sp)
    80006220:	06013a03          	ld	s4,96(sp)
    80006224:	05813a83          	ld	s5,88(sp)
    80006228:	05013b03          	ld	s6,80(sp)
    8000622c:	04813b83          	ld	s7,72(sp)
    80006230:	04013c03          	ld	s8,64(sp)
    80006234:	03813c83          	ld	s9,56(sp)
    80006238:	03013d03          	ld	s10,48(sp)
    8000623c:	02813d83          	ld	s11,40(sp)
    80006240:	0d010113          	addi	sp,sp,208
    80006244:	00008067          	ret
    80006248:	07300713          	li	a4,115
    8000624c:	1ce78a63          	beq	a5,a4,80006420 <__printf+0x4b8>
    80006250:	07800713          	li	a4,120
    80006254:	1ee79e63          	bne	a5,a4,80006450 <__printf+0x4e8>
    80006258:	f7843783          	ld	a5,-136(s0)
    8000625c:	0007a703          	lw	a4,0(a5)
    80006260:	00878793          	addi	a5,a5,8
    80006264:	f6f43c23          	sd	a5,-136(s0)
    80006268:	28074263          	bltz	a4,800064ec <__printf+0x584>
    8000626c:	00002d97          	auipc	s11,0x2
    80006270:	4a4d8d93          	addi	s11,s11,1188 # 80008710 <digits>
    80006274:	00f77793          	andi	a5,a4,15
    80006278:	00fd87b3          	add	a5,s11,a5
    8000627c:	0007c683          	lbu	a3,0(a5)
    80006280:	00f00613          	li	a2,15
    80006284:	0007079b          	sext.w	a5,a4
    80006288:	f8d40023          	sb	a3,-128(s0)
    8000628c:	0047559b          	srliw	a1,a4,0x4
    80006290:	0047569b          	srliw	a3,a4,0x4
    80006294:	00000c93          	li	s9,0
    80006298:	0ee65063          	bge	a2,a4,80006378 <__printf+0x410>
    8000629c:	00f6f693          	andi	a3,a3,15
    800062a0:	00dd86b3          	add	a3,s11,a3
    800062a4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800062a8:	0087d79b          	srliw	a5,a5,0x8
    800062ac:	00100c93          	li	s9,1
    800062b0:	f8d400a3          	sb	a3,-127(s0)
    800062b4:	0cb67263          	bgeu	a2,a1,80006378 <__printf+0x410>
    800062b8:	00f7f693          	andi	a3,a5,15
    800062bc:	00dd86b3          	add	a3,s11,a3
    800062c0:	0006c583          	lbu	a1,0(a3)
    800062c4:	00f00613          	li	a2,15
    800062c8:	0047d69b          	srliw	a3,a5,0x4
    800062cc:	f8b40123          	sb	a1,-126(s0)
    800062d0:	0047d593          	srli	a1,a5,0x4
    800062d4:	28f67e63          	bgeu	a2,a5,80006570 <__printf+0x608>
    800062d8:	00f6f693          	andi	a3,a3,15
    800062dc:	00dd86b3          	add	a3,s11,a3
    800062e0:	0006c503          	lbu	a0,0(a3)
    800062e4:	0087d813          	srli	a6,a5,0x8
    800062e8:	0087d69b          	srliw	a3,a5,0x8
    800062ec:	f8a401a3          	sb	a0,-125(s0)
    800062f0:	28b67663          	bgeu	a2,a1,8000657c <__printf+0x614>
    800062f4:	00f6f693          	andi	a3,a3,15
    800062f8:	00dd86b3          	add	a3,s11,a3
    800062fc:	0006c583          	lbu	a1,0(a3)
    80006300:	00c7d513          	srli	a0,a5,0xc
    80006304:	00c7d69b          	srliw	a3,a5,0xc
    80006308:	f8b40223          	sb	a1,-124(s0)
    8000630c:	29067a63          	bgeu	a2,a6,800065a0 <__printf+0x638>
    80006310:	00f6f693          	andi	a3,a3,15
    80006314:	00dd86b3          	add	a3,s11,a3
    80006318:	0006c583          	lbu	a1,0(a3)
    8000631c:	0107d813          	srli	a6,a5,0x10
    80006320:	0107d69b          	srliw	a3,a5,0x10
    80006324:	f8b402a3          	sb	a1,-123(s0)
    80006328:	28a67263          	bgeu	a2,a0,800065ac <__printf+0x644>
    8000632c:	00f6f693          	andi	a3,a3,15
    80006330:	00dd86b3          	add	a3,s11,a3
    80006334:	0006c683          	lbu	a3,0(a3)
    80006338:	0147d79b          	srliw	a5,a5,0x14
    8000633c:	f8d40323          	sb	a3,-122(s0)
    80006340:	21067663          	bgeu	a2,a6,8000654c <__printf+0x5e4>
    80006344:	02079793          	slli	a5,a5,0x20
    80006348:	0207d793          	srli	a5,a5,0x20
    8000634c:	00fd8db3          	add	s11,s11,a5
    80006350:	000dc683          	lbu	a3,0(s11)
    80006354:	00800793          	li	a5,8
    80006358:	00700c93          	li	s9,7
    8000635c:	f8d403a3          	sb	a3,-121(s0)
    80006360:	00075c63          	bgez	a4,80006378 <__printf+0x410>
    80006364:	f9040713          	addi	a4,s0,-112
    80006368:	00f70733          	add	a4,a4,a5
    8000636c:	02d00693          	li	a3,45
    80006370:	fed70823          	sb	a3,-16(a4)
    80006374:	00078c93          	mv	s9,a5
    80006378:	f8040793          	addi	a5,s0,-128
    8000637c:	01978cb3          	add	s9,a5,s9
    80006380:	f7f40d13          	addi	s10,s0,-129
    80006384:	000cc503          	lbu	a0,0(s9)
    80006388:	fffc8c93          	addi	s9,s9,-1
    8000638c:	00000097          	auipc	ra,0x0
    80006390:	9f8080e7          	jalr	-1544(ra) # 80005d84 <consputc>
    80006394:	ff9d18e3          	bne	s10,s9,80006384 <__printf+0x41c>
    80006398:	0100006f          	j	800063a8 <__printf+0x440>
    8000639c:	00000097          	auipc	ra,0x0
    800063a0:	9e8080e7          	jalr	-1560(ra) # 80005d84 <consputc>
    800063a4:	000c8493          	mv	s1,s9
    800063a8:	00094503          	lbu	a0,0(s2)
    800063ac:	c60510e3          	bnez	a0,8000600c <__printf+0xa4>
    800063b0:	e40c0ee3          	beqz	s8,8000620c <__printf+0x2a4>
    800063b4:	00006517          	auipc	a0,0x6
    800063b8:	0bc50513          	addi	a0,a0,188 # 8000c470 <pr>
    800063bc:	00001097          	auipc	ra,0x1
    800063c0:	94c080e7          	jalr	-1716(ra) # 80006d08 <release>
    800063c4:	e49ff06f          	j	8000620c <__printf+0x2a4>
    800063c8:	f7843783          	ld	a5,-136(s0)
    800063cc:	03000513          	li	a0,48
    800063d0:	01000d13          	li	s10,16
    800063d4:	00878713          	addi	a4,a5,8
    800063d8:	0007bc83          	ld	s9,0(a5)
    800063dc:	f6e43c23          	sd	a4,-136(s0)
    800063e0:	00000097          	auipc	ra,0x0
    800063e4:	9a4080e7          	jalr	-1628(ra) # 80005d84 <consputc>
    800063e8:	07800513          	li	a0,120
    800063ec:	00000097          	auipc	ra,0x0
    800063f0:	998080e7          	jalr	-1640(ra) # 80005d84 <consputc>
    800063f4:	00002d97          	auipc	s11,0x2
    800063f8:	31cd8d93          	addi	s11,s11,796 # 80008710 <digits>
    800063fc:	03ccd793          	srli	a5,s9,0x3c
    80006400:	00fd87b3          	add	a5,s11,a5
    80006404:	0007c503          	lbu	a0,0(a5)
    80006408:	fffd0d1b          	addiw	s10,s10,-1
    8000640c:	004c9c93          	slli	s9,s9,0x4
    80006410:	00000097          	auipc	ra,0x0
    80006414:	974080e7          	jalr	-1676(ra) # 80005d84 <consputc>
    80006418:	fe0d12e3          	bnez	s10,800063fc <__printf+0x494>
    8000641c:	f8dff06f          	j	800063a8 <__printf+0x440>
    80006420:	f7843783          	ld	a5,-136(s0)
    80006424:	0007bc83          	ld	s9,0(a5)
    80006428:	00878793          	addi	a5,a5,8
    8000642c:	f6f43c23          	sd	a5,-136(s0)
    80006430:	000c9a63          	bnez	s9,80006444 <__printf+0x4dc>
    80006434:	1080006f          	j	8000653c <__printf+0x5d4>
    80006438:	001c8c93          	addi	s9,s9,1
    8000643c:	00000097          	auipc	ra,0x0
    80006440:	948080e7          	jalr	-1720(ra) # 80005d84 <consputc>
    80006444:	000cc503          	lbu	a0,0(s9)
    80006448:	fe0518e3          	bnez	a0,80006438 <__printf+0x4d0>
    8000644c:	f5dff06f          	j	800063a8 <__printf+0x440>
    80006450:	02500513          	li	a0,37
    80006454:	00000097          	auipc	ra,0x0
    80006458:	930080e7          	jalr	-1744(ra) # 80005d84 <consputc>
    8000645c:	000c8513          	mv	a0,s9
    80006460:	00000097          	auipc	ra,0x0
    80006464:	924080e7          	jalr	-1756(ra) # 80005d84 <consputc>
    80006468:	f41ff06f          	j	800063a8 <__printf+0x440>
    8000646c:	02500513          	li	a0,37
    80006470:	00000097          	auipc	ra,0x0
    80006474:	914080e7          	jalr	-1772(ra) # 80005d84 <consputc>
    80006478:	f31ff06f          	j	800063a8 <__printf+0x440>
    8000647c:	00030513          	mv	a0,t1
    80006480:	00000097          	auipc	ra,0x0
    80006484:	7bc080e7          	jalr	1980(ra) # 80006c3c <acquire>
    80006488:	b4dff06f          	j	80005fd4 <__printf+0x6c>
    8000648c:	40c0053b          	negw	a0,a2
    80006490:	00a00713          	li	a4,10
    80006494:	02e576bb          	remuw	a3,a0,a4
    80006498:	00002d97          	auipc	s11,0x2
    8000649c:	278d8d93          	addi	s11,s11,632 # 80008710 <digits>
    800064a0:	ff700593          	li	a1,-9
    800064a4:	02069693          	slli	a3,a3,0x20
    800064a8:	0206d693          	srli	a3,a3,0x20
    800064ac:	00dd86b3          	add	a3,s11,a3
    800064b0:	0006c683          	lbu	a3,0(a3)
    800064b4:	02e557bb          	divuw	a5,a0,a4
    800064b8:	f8d40023          	sb	a3,-128(s0)
    800064bc:	10b65e63          	bge	a2,a1,800065d8 <__printf+0x670>
    800064c0:	06300593          	li	a1,99
    800064c4:	02e7f6bb          	remuw	a3,a5,a4
    800064c8:	02069693          	slli	a3,a3,0x20
    800064cc:	0206d693          	srli	a3,a3,0x20
    800064d0:	00dd86b3          	add	a3,s11,a3
    800064d4:	0006c683          	lbu	a3,0(a3)
    800064d8:	02e7d73b          	divuw	a4,a5,a4
    800064dc:	00200793          	li	a5,2
    800064e0:	f8d400a3          	sb	a3,-127(s0)
    800064e4:	bca5ece3          	bltu	a1,a0,800060bc <__printf+0x154>
    800064e8:	ce5ff06f          	j	800061cc <__printf+0x264>
    800064ec:	40e007bb          	negw	a5,a4
    800064f0:	00002d97          	auipc	s11,0x2
    800064f4:	220d8d93          	addi	s11,s11,544 # 80008710 <digits>
    800064f8:	00f7f693          	andi	a3,a5,15
    800064fc:	00dd86b3          	add	a3,s11,a3
    80006500:	0006c583          	lbu	a1,0(a3)
    80006504:	ff100613          	li	a2,-15
    80006508:	0047d69b          	srliw	a3,a5,0x4
    8000650c:	f8b40023          	sb	a1,-128(s0)
    80006510:	0047d59b          	srliw	a1,a5,0x4
    80006514:	0ac75e63          	bge	a4,a2,800065d0 <__printf+0x668>
    80006518:	00f6f693          	andi	a3,a3,15
    8000651c:	00dd86b3          	add	a3,s11,a3
    80006520:	0006c603          	lbu	a2,0(a3)
    80006524:	00f00693          	li	a3,15
    80006528:	0087d79b          	srliw	a5,a5,0x8
    8000652c:	f8c400a3          	sb	a2,-127(s0)
    80006530:	d8b6e4e3          	bltu	a3,a1,800062b8 <__printf+0x350>
    80006534:	00200793          	li	a5,2
    80006538:	e2dff06f          	j	80006364 <__printf+0x3fc>
    8000653c:	00002c97          	auipc	s9,0x2
    80006540:	1b4c8c93          	addi	s9,s9,436 # 800086f0 <CONSOLE_STATUS+0x6e0>
    80006544:	02800513          	li	a0,40
    80006548:	ef1ff06f          	j	80006438 <__printf+0x4d0>
    8000654c:	00700793          	li	a5,7
    80006550:	00600c93          	li	s9,6
    80006554:	e0dff06f          	j	80006360 <__printf+0x3f8>
    80006558:	00700793          	li	a5,7
    8000655c:	00600c93          	li	s9,6
    80006560:	c69ff06f          	j	800061c8 <__printf+0x260>
    80006564:	00300793          	li	a5,3
    80006568:	00200c93          	li	s9,2
    8000656c:	c5dff06f          	j	800061c8 <__printf+0x260>
    80006570:	00300793          	li	a5,3
    80006574:	00200c93          	li	s9,2
    80006578:	de9ff06f          	j	80006360 <__printf+0x3f8>
    8000657c:	00400793          	li	a5,4
    80006580:	00300c93          	li	s9,3
    80006584:	dddff06f          	j	80006360 <__printf+0x3f8>
    80006588:	00400793          	li	a5,4
    8000658c:	00300c93          	li	s9,3
    80006590:	c39ff06f          	j	800061c8 <__printf+0x260>
    80006594:	00500793          	li	a5,5
    80006598:	00400c93          	li	s9,4
    8000659c:	c2dff06f          	j	800061c8 <__printf+0x260>
    800065a0:	00500793          	li	a5,5
    800065a4:	00400c93          	li	s9,4
    800065a8:	db9ff06f          	j	80006360 <__printf+0x3f8>
    800065ac:	00600793          	li	a5,6
    800065b0:	00500c93          	li	s9,5
    800065b4:	dadff06f          	j	80006360 <__printf+0x3f8>
    800065b8:	00600793          	li	a5,6
    800065bc:	00500c93          	li	s9,5
    800065c0:	c09ff06f          	j	800061c8 <__printf+0x260>
    800065c4:	00800793          	li	a5,8
    800065c8:	00700c93          	li	s9,7
    800065cc:	bfdff06f          	j	800061c8 <__printf+0x260>
    800065d0:	00100793          	li	a5,1
    800065d4:	d91ff06f          	j	80006364 <__printf+0x3fc>
    800065d8:	00100793          	li	a5,1
    800065dc:	bf1ff06f          	j	800061cc <__printf+0x264>
    800065e0:	00900793          	li	a5,9
    800065e4:	00800c93          	li	s9,8
    800065e8:	be1ff06f          	j	800061c8 <__printf+0x260>
    800065ec:	00002517          	auipc	a0,0x2
    800065f0:	10c50513          	addi	a0,a0,268 # 800086f8 <CONSOLE_STATUS+0x6e8>
    800065f4:	00000097          	auipc	ra,0x0
    800065f8:	918080e7          	jalr	-1768(ra) # 80005f0c <panic>

00000000800065fc <printfinit>:
    800065fc:	fe010113          	addi	sp,sp,-32
    80006600:	00813823          	sd	s0,16(sp)
    80006604:	00913423          	sd	s1,8(sp)
    80006608:	00113c23          	sd	ra,24(sp)
    8000660c:	02010413          	addi	s0,sp,32
    80006610:	00006497          	auipc	s1,0x6
    80006614:	e6048493          	addi	s1,s1,-416 # 8000c470 <pr>
    80006618:	00048513          	mv	a0,s1
    8000661c:	00002597          	auipc	a1,0x2
    80006620:	0ec58593          	addi	a1,a1,236 # 80008708 <CONSOLE_STATUS+0x6f8>
    80006624:	00000097          	auipc	ra,0x0
    80006628:	5f4080e7          	jalr	1524(ra) # 80006c18 <initlock>
    8000662c:	01813083          	ld	ra,24(sp)
    80006630:	01013403          	ld	s0,16(sp)
    80006634:	0004ac23          	sw	zero,24(s1)
    80006638:	00813483          	ld	s1,8(sp)
    8000663c:	02010113          	addi	sp,sp,32
    80006640:	00008067          	ret

0000000080006644 <uartinit>:
    80006644:	ff010113          	addi	sp,sp,-16
    80006648:	00813423          	sd	s0,8(sp)
    8000664c:	01010413          	addi	s0,sp,16
    80006650:	100007b7          	lui	a5,0x10000
    80006654:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006658:	f8000713          	li	a4,-128
    8000665c:	00e781a3          	sb	a4,3(a5)
    80006660:	00300713          	li	a4,3
    80006664:	00e78023          	sb	a4,0(a5)
    80006668:	000780a3          	sb	zero,1(a5)
    8000666c:	00e781a3          	sb	a4,3(a5)
    80006670:	00700693          	li	a3,7
    80006674:	00d78123          	sb	a3,2(a5)
    80006678:	00e780a3          	sb	a4,1(a5)
    8000667c:	00813403          	ld	s0,8(sp)
    80006680:	01010113          	addi	sp,sp,16
    80006684:	00008067          	ret

0000000080006688 <uartputc>:
    80006688:	00005797          	auipc	a5,0x5
    8000668c:	9507a783          	lw	a5,-1712(a5) # 8000afd8 <panicked>
    80006690:	00078463          	beqz	a5,80006698 <uartputc+0x10>
    80006694:	0000006f          	j	80006694 <uartputc+0xc>
    80006698:	fd010113          	addi	sp,sp,-48
    8000669c:	02813023          	sd	s0,32(sp)
    800066a0:	00913c23          	sd	s1,24(sp)
    800066a4:	01213823          	sd	s2,16(sp)
    800066a8:	01313423          	sd	s3,8(sp)
    800066ac:	02113423          	sd	ra,40(sp)
    800066b0:	03010413          	addi	s0,sp,48
    800066b4:	00005917          	auipc	s2,0x5
    800066b8:	92c90913          	addi	s2,s2,-1748 # 8000afe0 <uart_tx_r>
    800066bc:	00093783          	ld	a5,0(s2)
    800066c0:	00005497          	auipc	s1,0x5
    800066c4:	92848493          	addi	s1,s1,-1752 # 8000afe8 <uart_tx_w>
    800066c8:	0004b703          	ld	a4,0(s1)
    800066cc:	02078693          	addi	a3,a5,32
    800066d0:	00050993          	mv	s3,a0
    800066d4:	02e69c63          	bne	a3,a4,8000670c <uartputc+0x84>
    800066d8:	00001097          	auipc	ra,0x1
    800066dc:	834080e7          	jalr	-1996(ra) # 80006f0c <push_on>
    800066e0:	00093783          	ld	a5,0(s2)
    800066e4:	0004b703          	ld	a4,0(s1)
    800066e8:	02078793          	addi	a5,a5,32
    800066ec:	00e79463          	bne	a5,a4,800066f4 <uartputc+0x6c>
    800066f0:	0000006f          	j	800066f0 <uartputc+0x68>
    800066f4:	00001097          	auipc	ra,0x1
    800066f8:	88c080e7          	jalr	-1908(ra) # 80006f80 <pop_on>
    800066fc:	00093783          	ld	a5,0(s2)
    80006700:	0004b703          	ld	a4,0(s1)
    80006704:	02078693          	addi	a3,a5,32
    80006708:	fce688e3          	beq	a3,a4,800066d8 <uartputc+0x50>
    8000670c:	01f77693          	andi	a3,a4,31
    80006710:	00006597          	auipc	a1,0x6
    80006714:	d8058593          	addi	a1,a1,-640 # 8000c490 <uart_tx_buf>
    80006718:	00d586b3          	add	a3,a1,a3
    8000671c:	00170713          	addi	a4,a4,1
    80006720:	01368023          	sb	s3,0(a3)
    80006724:	00e4b023          	sd	a4,0(s1)
    80006728:	10000637          	lui	a2,0x10000
    8000672c:	02f71063          	bne	a4,a5,8000674c <uartputc+0xc4>
    80006730:	0340006f          	j	80006764 <uartputc+0xdc>
    80006734:	00074703          	lbu	a4,0(a4)
    80006738:	00f93023          	sd	a5,0(s2)
    8000673c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006740:	00093783          	ld	a5,0(s2)
    80006744:	0004b703          	ld	a4,0(s1)
    80006748:	00f70e63          	beq	a4,a5,80006764 <uartputc+0xdc>
    8000674c:	00564683          	lbu	a3,5(a2)
    80006750:	01f7f713          	andi	a4,a5,31
    80006754:	00e58733          	add	a4,a1,a4
    80006758:	0206f693          	andi	a3,a3,32
    8000675c:	00178793          	addi	a5,a5,1
    80006760:	fc069ae3          	bnez	a3,80006734 <uartputc+0xac>
    80006764:	02813083          	ld	ra,40(sp)
    80006768:	02013403          	ld	s0,32(sp)
    8000676c:	01813483          	ld	s1,24(sp)
    80006770:	01013903          	ld	s2,16(sp)
    80006774:	00813983          	ld	s3,8(sp)
    80006778:	03010113          	addi	sp,sp,48
    8000677c:	00008067          	ret

0000000080006780 <uartputc_sync>:
    80006780:	ff010113          	addi	sp,sp,-16
    80006784:	00813423          	sd	s0,8(sp)
    80006788:	01010413          	addi	s0,sp,16
    8000678c:	00005717          	auipc	a4,0x5
    80006790:	84c72703          	lw	a4,-1972(a4) # 8000afd8 <panicked>
    80006794:	02071663          	bnez	a4,800067c0 <uartputc_sync+0x40>
    80006798:	00050793          	mv	a5,a0
    8000679c:	100006b7          	lui	a3,0x10000
    800067a0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800067a4:	02077713          	andi	a4,a4,32
    800067a8:	fe070ce3          	beqz	a4,800067a0 <uartputc_sync+0x20>
    800067ac:	0ff7f793          	andi	a5,a5,255
    800067b0:	00f68023          	sb	a5,0(a3)
    800067b4:	00813403          	ld	s0,8(sp)
    800067b8:	01010113          	addi	sp,sp,16
    800067bc:	00008067          	ret
    800067c0:	0000006f          	j	800067c0 <uartputc_sync+0x40>

00000000800067c4 <uartstart>:
    800067c4:	ff010113          	addi	sp,sp,-16
    800067c8:	00813423          	sd	s0,8(sp)
    800067cc:	01010413          	addi	s0,sp,16
    800067d0:	00005617          	auipc	a2,0x5
    800067d4:	81060613          	addi	a2,a2,-2032 # 8000afe0 <uart_tx_r>
    800067d8:	00005517          	auipc	a0,0x5
    800067dc:	81050513          	addi	a0,a0,-2032 # 8000afe8 <uart_tx_w>
    800067e0:	00063783          	ld	a5,0(a2)
    800067e4:	00053703          	ld	a4,0(a0)
    800067e8:	04f70263          	beq	a4,a5,8000682c <uartstart+0x68>
    800067ec:	100005b7          	lui	a1,0x10000
    800067f0:	00006817          	auipc	a6,0x6
    800067f4:	ca080813          	addi	a6,a6,-864 # 8000c490 <uart_tx_buf>
    800067f8:	01c0006f          	j	80006814 <uartstart+0x50>
    800067fc:	0006c703          	lbu	a4,0(a3)
    80006800:	00f63023          	sd	a5,0(a2)
    80006804:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006808:	00063783          	ld	a5,0(a2)
    8000680c:	00053703          	ld	a4,0(a0)
    80006810:	00f70e63          	beq	a4,a5,8000682c <uartstart+0x68>
    80006814:	01f7f713          	andi	a4,a5,31
    80006818:	00e806b3          	add	a3,a6,a4
    8000681c:	0055c703          	lbu	a4,5(a1)
    80006820:	00178793          	addi	a5,a5,1
    80006824:	02077713          	andi	a4,a4,32
    80006828:	fc071ae3          	bnez	a4,800067fc <uartstart+0x38>
    8000682c:	00813403          	ld	s0,8(sp)
    80006830:	01010113          	addi	sp,sp,16
    80006834:	00008067          	ret

0000000080006838 <uartgetc>:
    80006838:	ff010113          	addi	sp,sp,-16
    8000683c:	00813423          	sd	s0,8(sp)
    80006840:	01010413          	addi	s0,sp,16
    80006844:	10000737          	lui	a4,0x10000
    80006848:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000684c:	0017f793          	andi	a5,a5,1
    80006850:	00078c63          	beqz	a5,80006868 <uartgetc+0x30>
    80006854:	00074503          	lbu	a0,0(a4)
    80006858:	0ff57513          	andi	a0,a0,255
    8000685c:	00813403          	ld	s0,8(sp)
    80006860:	01010113          	addi	sp,sp,16
    80006864:	00008067          	ret
    80006868:	fff00513          	li	a0,-1
    8000686c:	ff1ff06f          	j	8000685c <uartgetc+0x24>

0000000080006870 <uartintr>:
    80006870:	100007b7          	lui	a5,0x10000
    80006874:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006878:	0017f793          	andi	a5,a5,1
    8000687c:	0a078463          	beqz	a5,80006924 <uartintr+0xb4>
    80006880:	fe010113          	addi	sp,sp,-32
    80006884:	00813823          	sd	s0,16(sp)
    80006888:	00913423          	sd	s1,8(sp)
    8000688c:	00113c23          	sd	ra,24(sp)
    80006890:	02010413          	addi	s0,sp,32
    80006894:	100004b7          	lui	s1,0x10000
    80006898:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000689c:	0ff57513          	andi	a0,a0,255
    800068a0:	fffff097          	auipc	ra,0xfffff
    800068a4:	534080e7          	jalr	1332(ra) # 80005dd4 <consoleintr>
    800068a8:	0054c783          	lbu	a5,5(s1)
    800068ac:	0017f793          	andi	a5,a5,1
    800068b0:	fe0794e3          	bnez	a5,80006898 <uartintr+0x28>
    800068b4:	00004617          	auipc	a2,0x4
    800068b8:	72c60613          	addi	a2,a2,1836 # 8000afe0 <uart_tx_r>
    800068bc:	00004517          	auipc	a0,0x4
    800068c0:	72c50513          	addi	a0,a0,1836 # 8000afe8 <uart_tx_w>
    800068c4:	00063783          	ld	a5,0(a2)
    800068c8:	00053703          	ld	a4,0(a0)
    800068cc:	04f70263          	beq	a4,a5,80006910 <uartintr+0xa0>
    800068d0:	100005b7          	lui	a1,0x10000
    800068d4:	00006817          	auipc	a6,0x6
    800068d8:	bbc80813          	addi	a6,a6,-1092 # 8000c490 <uart_tx_buf>
    800068dc:	01c0006f          	j	800068f8 <uartintr+0x88>
    800068e0:	0006c703          	lbu	a4,0(a3)
    800068e4:	00f63023          	sd	a5,0(a2)
    800068e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800068ec:	00063783          	ld	a5,0(a2)
    800068f0:	00053703          	ld	a4,0(a0)
    800068f4:	00f70e63          	beq	a4,a5,80006910 <uartintr+0xa0>
    800068f8:	01f7f713          	andi	a4,a5,31
    800068fc:	00e806b3          	add	a3,a6,a4
    80006900:	0055c703          	lbu	a4,5(a1)
    80006904:	00178793          	addi	a5,a5,1
    80006908:	02077713          	andi	a4,a4,32
    8000690c:	fc071ae3          	bnez	a4,800068e0 <uartintr+0x70>
    80006910:	01813083          	ld	ra,24(sp)
    80006914:	01013403          	ld	s0,16(sp)
    80006918:	00813483          	ld	s1,8(sp)
    8000691c:	02010113          	addi	sp,sp,32
    80006920:	00008067          	ret
    80006924:	00004617          	auipc	a2,0x4
    80006928:	6bc60613          	addi	a2,a2,1724 # 8000afe0 <uart_tx_r>
    8000692c:	00004517          	auipc	a0,0x4
    80006930:	6bc50513          	addi	a0,a0,1724 # 8000afe8 <uart_tx_w>
    80006934:	00063783          	ld	a5,0(a2)
    80006938:	00053703          	ld	a4,0(a0)
    8000693c:	04f70263          	beq	a4,a5,80006980 <uartintr+0x110>
    80006940:	100005b7          	lui	a1,0x10000
    80006944:	00006817          	auipc	a6,0x6
    80006948:	b4c80813          	addi	a6,a6,-1204 # 8000c490 <uart_tx_buf>
    8000694c:	01c0006f          	j	80006968 <uartintr+0xf8>
    80006950:	0006c703          	lbu	a4,0(a3)
    80006954:	00f63023          	sd	a5,0(a2)
    80006958:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000695c:	00063783          	ld	a5,0(a2)
    80006960:	00053703          	ld	a4,0(a0)
    80006964:	02f70063          	beq	a4,a5,80006984 <uartintr+0x114>
    80006968:	01f7f713          	andi	a4,a5,31
    8000696c:	00e806b3          	add	a3,a6,a4
    80006970:	0055c703          	lbu	a4,5(a1)
    80006974:	00178793          	addi	a5,a5,1
    80006978:	02077713          	andi	a4,a4,32
    8000697c:	fc071ae3          	bnez	a4,80006950 <uartintr+0xe0>
    80006980:	00008067          	ret
    80006984:	00008067          	ret

0000000080006988 <kinit>:
    80006988:	fc010113          	addi	sp,sp,-64
    8000698c:	02913423          	sd	s1,40(sp)
    80006990:	fffff7b7          	lui	a5,0xfffff
    80006994:	0000b497          	auipc	s1,0xb
    80006998:	66b48493          	addi	s1,s1,1643 # 80011fff <end+0xfff>
    8000699c:	02813823          	sd	s0,48(sp)
    800069a0:	01313c23          	sd	s3,24(sp)
    800069a4:	00f4f4b3          	and	s1,s1,a5
    800069a8:	02113c23          	sd	ra,56(sp)
    800069ac:	03213023          	sd	s2,32(sp)
    800069b0:	01413823          	sd	s4,16(sp)
    800069b4:	01513423          	sd	s5,8(sp)
    800069b8:	04010413          	addi	s0,sp,64
    800069bc:	000017b7          	lui	a5,0x1
    800069c0:	01100993          	li	s3,17
    800069c4:	00f487b3          	add	a5,s1,a5
    800069c8:	01b99993          	slli	s3,s3,0x1b
    800069cc:	06f9e063          	bltu	s3,a5,80006a2c <kinit+0xa4>
    800069d0:	0000aa97          	auipc	s5,0xa
    800069d4:	630a8a93          	addi	s5,s5,1584 # 80011000 <end>
    800069d8:	0754ec63          	bltu	s1,s5,80006a50 <kinit+0xc8>
    800069dc:	0734fa63          	bgeu	s1,s3,80006a50 <kinit+0xc8>
    800069e0:	00088a37          	lui	s4,0x88
    800069e4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800069e8:	00004917          	auipc	s2,0x4
    800069ec:	60890913          	addi	s2,s2,1544 # 8000aff0 <kmem>
    800069f0:	00ca1a13          	slli	s4,s4,0xc
    800069f4:	0140006f          	j	80006a08 <kinit+0x80>
    800069f8:	000017b7          	lui	a5,0x1
    800069fc:	00f484b3          	add	s1,s1,a5
    80006a00:	0554e863          	bltu	s1,s5,80006a50 <kinit+0xc8>
    80006a04:	0534f663          	bgeu	s1,s3,80006a50 <kinit+0xc8>
    80006a08:	00001637          	lui	a2,0x1
    80006a0c:	00100593          	li	a1,1
    80006a10:	00048513          	mv	a0,s1
    80006a14:	00000097          	auipc	ra,0x0
    80006a18:	5e4080e7          	jalr	1508(ra) # 80006ff8 <__memset>
    80006a1c:	00093783          	ld	a5,0(s2)
    80006a20:	00f4b023          	sd	a5,0(s1)
    80006a24:	00993023          	sd	s1,0(s2)
    80006a28:	fd4498e3          	bne	s1,s4,800069f8 <kinit+0x70>
    80006a2c:	03813083          	ld	ra,56(sp)
    80006a30:	03013403          	ld	s0,48(sp)
    80006a34:	02813483          	ld	s1,40(sp)
    80006a38:	02013903          	ld	s2,32(sp)
    80006a3c:	01813983          	ld	s3,24(sp)
    80006a40:	01013a03          	ld	s4,16(sp)
    80006a44:	00813a83          	ld	s5,8(sp)
    80006a48:	04010113          	addi	sp,sp,64
    80006a4c:	00008067          	ret
    80006a50:	00002517          	auipc	a0,0x2
    80006a54:	cd850513          	addi	a0,a0,-808 # 80008728 <digits+0x18>
    80006a58:	fffff097          	auipc	ra,0xfffff
    80006a5c:	4b4080e7          	jalr	1204(ra) # 80005f0c <panic>

0000000080006a60 <freerange>:
    80006a60:	fc010113          	addi	sp,sp,-64
    80006a64:	000017b7          	lui	a5,0x1
    80006a68:	02913423          	sd	s1,40(sp)
    80006a6c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006a70:	009504b3          	add	s1,a0,s1
    80006a74:	fffff537          	lui	a0,0xfffff
    80006a78:	02813823          	sd	s0,48(sp)
    80006a7c:	02113c23          	sd	ra,56(sp)
    80006a80:	03213023          	sd	s2,32(sp)
    80006a84:	01313c23          	sd	s3,24(sp)
    80006a88:	01413823          	sd	s4,16(sp)
    80006a8c:	01513423          	sd	s5,8(sp)
    80006a90:	01613023          	sd	s6,0(sp)
    80006a94:	04010413          	addi	s0,sp,64
    80006a98:	00a4f4b3          	and	s1,s1,a0
    80006a9c:	00f487b3          	add	a5,s1,a5
    80006aa0:	06f5e463          	bltu	a1,a5,80006b08 <freerange+0xa8>
    80006aa4:	0000aa97          	auipc	s5,0xa
    80006aa8:	55ca8a93          	addi	s5,s5,1372 # 80011000 <end>
    80006aac:	0954e263          	bltu	s1,s5,80006b30 <freerange+0xd0>
    80006ab0:	01100993          	li	s3,17
    80006ab4:	01b99993          	slli	s3,s3,0x1b
    80006ab8:	0734fc63          	bgeu	s1,s3,80006b30 <freerange+0xd0>
    80006abc:	00058a13          	mv	s4,a1
    80006ac0:	00004917          	auipc	s2,0x4
    80006ac4:	53090913          	addi	s2,s2,1328 # 8000aff0 <kmem>
    80006ac8:	00002b37          	lui	s6,0x2
    80006acc:	0140006f          	j	80006ae0 <freerange+0x80>
    80006ad0:	000017b7          	lui	a5,0x1
    80006ad4:	00f484b3          	add	s1,s1,a5
    80006ad8:	0554ec63          	bltu	s1,s5,80006b30 <freerange+0xd0>
    80006adc:	0534fa63          	bgeu	s1,s3,80006b30 <freerange+0xd0>
    80006ae0:	00001637          	lui	a2,0x1
    80006ae4:	00100593          	li	a1,1
    80006ae8:	00048513          	mv	a0,s1
    80006aec:	00000097          	auipc	ra,0x0
    80006af0:	50c080e7          	jalr	1292(ra) # 80006ff8 <__memset>
    80006af4:	00093703          	ld	a4,0(s2)
    80006af8:	016487b3          	add	a5,s1,s6
    80006afc:	00e4b023          	sd	a4,0(s1)
    80006b00:	00993023          	sd	s1,0(s2)
    80006b04:	fcfa76e3          	bgeu	s4,a5,80006ad0 <freerange+0x70>
    80006b08:	03813083          	ld	ra,56(sp)
    80006b0c:	03013403          	ld	s0,48(sp)
    80006b10:	02813483          	ld	s1,40(sp)
    80006b14:	02013903          	ld	s2,32(sp)
    80006b18:	01813983          	ld	s3,24(sp)
    80006b1c:	01013a03          	ld	s4,16(sp)
    80006b20:	00813a83          	ld	s5,8(sp)
    80006b24:	00013b03          	ld	s6,0(sp)
    80006b28:	04010113          	addi	sp,sp,64
    80006b2c:	00008067          	ret
    80006b30:	00002517          	auipc	a0,0x2
    80006b34:	bf850513          	addi	a0,a0,-1032 # 80008728 <digits+0x18>
    80006b38:	fffff097          	auipc	ra,0xfffff
    80006b3c:	3d4080e7          	jalr	980(ra) # 80005f0c <panic>

0000000080006b40 <kfree>:
    80006b40:	fe010113          	addi	sp,sp,-32
    80006b44:	00813823          	sd	s0,16(sp)
    80006b48:	00113c23          	sd	ra,24(sp)
    80006b4c:	00913423          	sd	s1,8(sp)
    80006b50:	02010413          	addi	s0,sp,32
    80006b54:	03451793          	slli	a5,a0,0x34
    80006b58:	04079c63          	bnez	a5,80006bb0 <kfree+0x70>
    80006b5c:	0000a797          	auipc	a5,0xa
    80006b60:	4a478793          	addi	a5,a5,1188 # 80011000 <end>
    80006b64:	00050493          	mv	s1,a0
    80006b68:	04f56463          	bltu	a0,a5,80006bb0 <kfree+0x70>
    80006b6c:	01100793          	li	a5,17
    80006b70:	01b79793          	slli	a5,a5,0x1b
    80006b74:	02f57e63          	bgeu	a0,a5,80006bb0 <kfree+0x70>
    80006b78:	00001637          	lui	a2,0x1
    80006b7c:	00100593          	li	a1,1
    80006b80:	00000097          	auipc	ra,0x0
    80006b84:	478080e7          	jalr	1144(ra) # 80006ff8 <__memset>
    80006b88:	00004797          	auipc	a5,0x4
    80006b8c:	46878793          	addi	a5,a5,1128 # 8000aff0 <kmem>
    80006b90:	0007b703          	ld	a4,0(a5)
    80006b94:	01813083          	ld	ra,24(sp)
    80006b98:	01013403          	ld	s0,16(sp)
    80006b9c:	00e4b023          	sd	a4,0(s1)
    80006ba0:	0097b023          	sd	s1,0(a5)
    80006ba4:	00813483          	ld	s1,8(sp)
    80006ba8:	02010113          	addi	sp,sp,32
    80006bac:	00008067          	ret
    80006bb0:	00002517          	auipc	a0,0x2
    80006bb4:	b7850513          	addi	a0,a0,-1160 # 80008728 <digits+0x18>
    80006bb8:	fffff097          	auipc	ra,0xfffff
    80006bbc:	354080e7          	jalr	852(ra) # 80005f0c <panic>

0000000080006bc0 <kalloc>:
    80006bc0:	fe010113          	addi	sp,sp,-32
    80006bc4:	00813823          	sd	s0,16(sp)
    80006bc8:	00913423          	sd	s1,8(sp)
    80006bcc:	00113c23          	sd	ra,24(sp)
    80006bd0:	02010413          	addi	s0,sp,32
    80006bd4:	00004797          	auipc	a5,0x4
    80006bd8:	41c78793          	addi	a5,a5,1052 # 8000aff0 <kmem>
    80006bdc:	0007b483          	ld	s1,0(a5)
    80006be0:	02048063          	beqz	s1,80006c00 <kalloc+0x40>
    80006be4:	0004b703          	ld	a4,0(s1)
    80006be8:	00001637          	lui	a2,0x1
    80006bec:	00500593          	li	a1,5
    80006bf0:	00048513          	mv	a0,s1
    80006bf4:	00e7b023          	sd	a4,0(a5)
    80006bf8:	00000097          	auipc	ra,0x0
    80006bfc:	400080e7          	jalr	1024(ra) # 80006ff8 <__memset>
    80006c00:	01813083          	ld	ra,24(sp)
    80006c04:	01013403          	ld	s0,16(sp)
    80006c08:	00048513          	mv	a0,s1
    80006c0c:	00813483          	ld	s1,8(sp)
    80006c10:	02010113          	addi	sp,sp,32
    80006c14:	00008067          	ret

0000000080006c18 <initlock>:
    80006c18:	ff010113          	addi	sp,sp,-16
    80006c1c:	00813423          	sd	s0,8(sp)
    80006c20:	01010413          	addi	s0,sp,16
    80006c24:	00813403          	ld	s0,8(sp)
    80006c28:	00b53423          	sd	a1,8(a0)
    80006c2c:	00052023          	sw	zero,0(a0)
    80006c30:	00053823          	sd	zero,16(a0)
    80006c34:	01010113          	addi	sp,sp,16
    80006c38:	00008067          	ret

0000000080006c3c <acquire>:
    80006c3c:	fe010113          	addi	sp,sp,-32
    80006c40:	00813823          	sd	s0,16(sp)
    80006c44:	00913423          	sd	s1,8(sp)
    80006c48:	00113c23          	sd	ra,24(sp)
    80006c4c:	01213023          	sd	s2,0(sp)
    80006c50:	02010413          	addi	s0,sp,32
    80006c54:	00050493          	mv	s1,a0
    80006c58:	10002973          	csrr	s2,sstatus
    80006c5c:	100027f3          	csrr	a5,sstatus
    80006c60:	ffd7f793          	andi	a5,a5,-3
    80006c64:	10079073          	csrw	sstatus,a5
    80006c68:	fffff097          	auipc	ra,0xfffff
    80006c6c:	8e0080e7          	jalr	-1824(ra) # 80005548 <mycpu>
    80006c70:	07852783          	lw	a5,120(a0)
    80006c74:	06078e63          	beqz	a5,80006cf0 <acquire+0xb4>
    80006c78:	fffff097          	auipc	ra,0xfffff
    80006c7c:	8d0080e7          	jalr	-1840(ra) # 80005548 <mycpu>
    80006c80:	07852783          	lw	a5,120(a0)
    80006c84:	0004a703          	lw	a4,0(s1)
    80006c88:	0017879b          	addiw	a5,a5,1
    80006c8c:	06f52c23          	sw	a5,120(a0)
    80006c90:	04071063          	bnez	a4,80006cd0 <acquire+0x94>
    80006c94:	00100713          	li	a4,1
    80006c98:	00070793          	mv	a5,a4
    80006c9c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006ca0:	0007879b          	sext.w	a5,a5
    80006ca4:	fe079ae3          	bnez	a5,80006c98 <acquire+0x5c>
    80006ca8:	0ff0000f          	fence
    80006cac:	fffff097          	auipc	ra,0xfffff
    80006cb0:	89c080e7          	jalr	-1892(ra) # 80005548 <mycpu>
    80006cb4:	01813083          	ld	ra,24(sp)
    80006cb8:	01013403          	ld	s0,16(sp)
    80006cbc:	00a4b823          	sd	a0,16(s1)
    80006cc0:	00013903          	ld	s2,0(sp)
    80006cc4:	00813483          	ld	s1,8(sp)
    80006cc8:	02010113          	addi	sp,sp,32
    80006ccc:	00008067          	ret
    80006cd0:	0104b903          	ld	s2,16(s1)
    80006cd4:	fffff097          	auipc	ra,0xfffff
    80006cd8:	874080e7          	jalr	-1932(ra) # 80005548 <mycpu>
    80006cdc:	faa91ce3          	bne	s2,a0,80006c94 <acquire+0x58>
    80006ce0:	00002517          	auipc	a0,0x2
    80006ce4:	a5050513          	addi	a0,a0,-1456 # 80008730 <digits+0x20>
    80006ce8:	fffff097          	auipc	ra,0xfffff
    80006cec:	224080e7          	jalr	548(ra) # 80005f0c <panic>
    80006cf0:	00195913          	srli	s2,s2,0x1
    80006cf4:	fffff097          	auipc	ra,0xfffff
    80006cf8:	854080e7          	jalr	-1964(ra) # 80005548 <mycpu>
    80006cfc:	00197913          	andi	s2,s2,1
    80006d00:	07252e23          	sw	s2,124(a0)
    80006d04:	f75ff06f          	j	80006c78 <acquire+0x3c>

0000000080006d08 <release>:
    80006d08:	fe010113          	addi	sp,sp,-32
    80006d0c:	00813823          	sd	s0,16(sp)
    80006d10:	00113c23          	sd	ra,24(sp)
    80006d14:	00913423          	sd	s1,8(sp)
    80006d18:	01213023          	sd	s2,0(sp)
    80006d1c:	02010413          	addi	s0,sp,32
    80006d20:	00052783          	lw	a5,0(a0)
    80006d24:	00079a63          	bnez	a5,80006d38 <release+0x30>
    80006d28:	00002517          	auipc	a0,0x2
    80006d2c:	a1050513          	addi	a0,a0,-1520 # 80008738 <digits+0x28>
    80006d30:	fffff097          	auipc	ra,0xfffff
    80006d34:	1dc080e7          	jalr	476(ra) # 80005f0c <panic>
    80006d38:	01053903          	ld	s2,16(a0)
    80006d3c:	00050493          	mv	s1,a0
    80006d40:	fffff097          	auipc	ra,0xfffff
    80006d44:	808080e7          	jalr	-2040(ra) # 80005548 <mycpu>
    80006d48:	fea910e3          	bne	s2,a0,80006d28 <release+0x20>
    80006d4c:	0004b823          	sd	zero,16(s1)
    80006d50:	0ff0000f          	fence
    80006d54:	0f50000f          	fence	iorw,ow
    80006d58:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006d5c:	ffffe097          	auipc	ra,0xffffe
    80006d60:	7ec080e7          	jalr	2028(ra) # 80005548 <mycpu>
    80006d64:	100027f3          	csrr	a5,sstatus
    80006d68:	0027f793          	andi	a5,a5,2
    80006d6c:	04079a63          	bnez	a5,80006dc0 <release+0xb8>
    80006d70:	07852783          	lw	a5,120(a0)
    80006d74:	02f05e63          	blez	a5,80006db0 <release+0xa8>
    80006d78:	fff7871b          	addiw	a4,a5,-1
    80006d7c:	06e52c23          	sw	a4,120(a0)
    80006d80:	00071c63          	bnez	a4,80006d98 <release+0x90>
    80006d84:	07c52783          	lw	a5,124(a0)
    80006d88:	00078863          	beqz	a5,80006d98 <release+0x90>
    80006d8c:	100027f3          	csrr	a5,sstatus
    80006d90:	0027e793          	ori	a5,a5,2
    80006d94:	10079073          	csrw	sstatus,a5
    80006d98:	01813083          	ld	ra,24(sp)
    80006d9c:	01013403          	ld	s0,16(sp)
    80006da0:	00813483          	ld	s1,8(sp)
    80006da4:	00013903          	ld	s2,0(sp)
    80006da8:	02010113          	addi	sp,sp,32
    80006dac:	00008067          	ret
    80006db0:	00002517          	auipc	a0,0x2
    80006db4:	9a850513          	addi	a0,a0,-1624 # 80008758 <digits+0x48>
    80006db8:	fffff097          	auipc	ra,0xfffff
    80006dbc:	154080e7          	jalr	340(ra) # 80005f0c <panic>
    80006dc0:	00002517          	auipc	a0,0x2
    80006dc4:	98050513          	addi	a0,a0,-1664 # 80008740 <digits+0x30>
    80006dc8:	fffff097          	auipc	ra,0xfffff
    80006dcc:	144080e7          	jalr	324(ra) # 80005f0c <panic>

0000000080006dd0 <holding>:
    80006dd0:	00052783          	lw	a5,0(a0)
    80006dd4:	00079663          	bnez	a5,80006de0 <holding+0x10>
    80006dd8:	00000513          	li	a0,0
    80006ddc:	00008067          	ret
    80006de0:	fe010113          	addi	sp,sp,-32
    80006de4:	00813823          	sd	s0,16(sp)
    80006de8:	00913423          	sd	s1,8(sp)
    80006dec:	00113c23          	sd	ra,24(sp)
    80006df0:	02010413          	addi	s0,sp,32
    80006df4:	01053483          	ld	s1,16(a0)
    80006df8:	ffffe097          	auipc	ra,0xffffe
    80006dfc:	750080e7          	jalr	1872(ra) # 80005548 <mycpu>
    80006e00:	01813083          	ld	ra,24(sp)
    80006e04:	01013403          	ld	s0,16(sp)
    80006e08:	40a48533          	sub	a0,s1,a0
    80006e0c:	00153513          	seqz	a0,a0
    80006e10:	00813483          	ld	s1,8(sp)
    80006e14:	02010113          	addi	sp,sp,32
    80006e18:	00008067          	ret

0000000080006e1c <push_off>:
    80006e1c:	fe010113          	addi	sp,sp,-32
    80006e20:	00813823          	sd	s0,16(sp)
    80006e24:	00113c23          	sd	ra,24(sp)
    80006e28:	00913423          	sd	s1,8(sp)
    80006e2c:	02010413          	addi	s0,sp,32
    80006e30:	100024f3          	csrr	s1,sstatus
    80006e34:	100027f3          	csrr	a5,sstatus
    80006e38:	ffd7f793          	andi	a5,a5,-3
    80006e3c:	10079073          	csrw	sstatus,a5
    80006e40:	ffffe097          	auipc	ra,0xffffe
    80006e44:	708080e7          	jalr	1800(ra) # 80005548 <mycpu>
    80006e48:	07852783          	lw	a5,120(a0)
    80006e4c:	02078663          	beqz	a5,80006e78 <push_off+0x5c>
    80006e50:	ffffe097          	auipc	ra,0xffffe
    80006e54:	6f8080e7          	jalr	1784(ra) # 80005548 <mycpu>
    80006e58:	07852783          	lw	a5,120(a0)
    80006e5c:	01813083          	ld	ra,24(sp)
    80006e60:	01013403          	ld	s0,16(sp)
    80006e64:	0017879b          	addiw	a5,a5,1
    80006e68:	06f52c23          	sw	a5,120(a0)
    80006e6c:	00813483          	ld	s1,8(sp)
    80006e70:	02010113          	addi	sp,sp,32
    80006e74:	00008067          	ret
    80006e78:	0014d493          	srli	s1,s1,0x1
    80006e7c:	ffffe097          	auipc	ra,0xffffe
    80006e80:	6cc080e7          	jalr	1740(ra) # 80005548 <mycpu>
    80006e84:	0014f493          	andi	s1,s1,1
    80006e88:	06952e23          	sw	s1,124(a0)
    80006e8c:	fc5ff06f          	j	80006e50 <push_off+0x34>

0000000080006e90 <pop_off>:
    80006e90:	ff010113          	addi	sp,sp,-16
    80006e94:	00813023          	sd	s0,0(sp)
    80006e98:	00113423          	sd	ra,8(sp)
    80006e9c:	01010413          	addi	s0,sp,16
    80006ea0:	ffffe097          	auipc	ra,0xffffe
    80006ea4:	6a8080e7          	jalr	1704(ra) # 80005548 <mycpu>
    80006ea8:	100027f3          	csrr	a5,sstatus
    80006eac:	0027f793          	andi	a5,a5,2
    80006eb0:	04079663          	bnez	a5,80006efc <pop_off+0x6c>
    80006eb4:	07852783          	lw	a5,120(a0)
    80006eb8:	02f05a63          	blez	a5,80006eec <pop_off+0x5c>
    80006ebc:	fff7871b          	addiw	a4,a5,-1
    80006ec0:	06e52c23          	sw	a4,120(a0)
    80006ec4:	00071c63          	bnez	a4,80006edc <pop_off+0x4c>
    80006ec8:	07c52783          	lw	a5,124(a0)
    80006ecc:	00078863          	beqz	a5,80006edc <pop_off+0x4c>
    80006ed0:	100027f3          	csrr	a5,sstatus
    80006ed4:	0027e793          	ori	a5,a5,2
    80006ed8:	10079073          	csrw	sstatus,a5
    80006edc:	00813083          	ld	ra,8(sp)
    80006ee0:	00013403          	ld	s0,0(sp)
    80006ee4:	01010113          	addi	sp,sp,16
    80006ee8:	00008067          	ret
    80006eec:	00002517          	auipc	a0,0x2
    80006ef0:	86c50513          	addi	a0,a0,-1940 # 80008758 <digits+0x48>
    80006ef4:	fffff097          	auipc	ra,0xfffff
    80006ef8:	018080e7          	jalr	24(ra) # 80005f0c <panic>
    80006efc:	00002517          	auipc	a0,0x2
    80006f00:	84450513          	addi	a0,a0,-1980 # 80008740 <digits+0x30>
    80006f04:	fffff097          	auipc	ra,0xfffff
    80006f08:	008080e7          	jalr	8(ra) # 80005f0c <panic>

0000000080006f0c <push_on>:
    80006f0c:	fe010113          	addi	sp,sp,-32
    80006f10:	00813823          	sd	s0,16(sp)
    80006f14:	00113c23          	sd	ra,24(sp)
    80006f18:	00913423          	sd	s1,8(sp)
    80006f1c:	02010413          	addi	s0,sp,32
    80006f20:	100024f3          	csrr	s1,sstatus
    80006f24:	100027f3          	csrr	a5,sstatus
    80006f28:	0027e793          	ori	a5,a5,2
    80006f2c:	10079073          	csrw	sstatus,a5
    80006f30:	ffffe097          	auipc	ra,0xffffe
    80006f34:	618080e7          	jalr	1560(ra) # 80005548 <mycpu>
    80006f38:	07852783          	lw	a5,120(a0)
    80006f3c:	02078663          	beqz	a5,80006f68 <push_on+0x5c>
    80006f40:	ffffe097          	auipc	ra,0xffffe
    80006f44:	608080e7          	jalr	1544(ra) # 80005548 <mycpu>
    80006f48:	07852783          	lw	a5,120(a0)
    80006f4c:	01813083          	ld	ra,24(sp)
    80006f50:	01013403          	ld	s0,16(sp)
    80006f54:	0017879b          	addiw	a5,a5,1
    80006f58:	06f52c23          	sw	a5,120(a0)
    80006f5c:	00813483          	ld	s1,8(sp)
    80006f60:	02010113          	addi	sp,sp,32
    80006f64:	00008067          	ret
    80006f68:	0014d493          	srli	s1,s1,0x1
    80006f6c:	ffffe097          	auipc	ra,0xffffe
    80006f70:	5dc080e7          	jalr	1500(ra) # 80005548 <mycpu>
    80006f74:	0014f493          	andi	s1,s1,1
    80006f78:	06952e23          	sw	s1,124(a0)
    80006f7c:	fc5ff06f          	j	80006f40 <push_on+0x34>

0000000080006f80 <pop_on>:
    80006f80:	ff010113          	addi	sp,sp,-16
    80006f84:	00813023          	sd	s0,0(sp)
    80006f88:	00113423          	sd	ra,8(sp)
    80006f8c:	01010413          	addi	s0,sp,16
    80006f90:	ffffe097          	auipc	ra,0xffffe
    80006f94:	5b8080e7          	jalr	1464(ra) # 80005548 <mycpu>
    80006f98:	100027f3          	csrr	a5,sstatus
    80006f9c:	0027f793          	andi	a5,a5,2
    80006fa0:	04078463          	beqz	a5,80006fe8 <pop_on+0x68>
    80006fa4:	07852783          	lw	a5,120(a0)
    80006fa8:	02f05863          	blez	a5,80006fd8 <pop_on+0x58>
    80006fac:	fff7879b          	addiw	a5,a5,-1
    80006fb0:	06f52c23          	sw	a5,120(a0)
    80006fb4:	07853783          	ld	a5,120(a0)
    80006fb8:	00079863          	bnez	a5,80006fc8 <pop_on+0x48>
    80006fbc:	100027f3          	csrr	a5,sstatus
    80006fc0:	ffd7f793          	andi	a5,a5,-3
    80006fc4:	10079073          	csrw	sstatus,a5
    80006fc8:	00813083          	ld	ra,8(sp)
    80006fcc:	00013403          	ld	s0,0(sp)
    80006fd0:	01010113          	addi	sp,sp,16
    80006fd4:	00008067          	ret
    80006fd8:	00001517          	auipc	a0,0x1
    80006fdc:	7a850513          	addi	a0,a0,1960 # 80008780 <digits+0x70>
    80006fe0:	fffff097          	auipc	ra,0xfffff
    80006fe4:	f2c080e7          	jalr	-212(ra) # 80005f0c <panic>
    80006fe8:	00001517          	auipc	a0,0x1
    80006fec:	77850513          	addi	a0,a0,1912 # 80008760 <digits+0x50>
    80006ff0:	fffff097          	auipc	ra,0xfffff
    80006ff4:	f1c080e7          	jalr	-228(ra) # 80005f0c <panic>

0000000080006ff8 <__memset>:
    80006ff8:	ff010113          	addi	sp,sp,-16
    80006ffc:	00813423          	sd	s0,8(sp)
    80007000:	01010413          	addi	s0,sp,16
    80007004:	1a060e63          	beqz	a2,800071c0 <__memset+0x1c8>
    80007008:	40a007b3          	neg	a5,a0
    8000700c:	0077f793          	andi	a5,a5,7
    80007010:	00778693          	addi	a3,a5,7
    80007014:	00b00813          	li	a6,11
    80007018:	0ff5f593          	andi	a1,a1,255
    8000701c:	fff6071b          	addiw	a4,a2,-1
    80007020:	1b06e663          	bltu	a3,a6,800071cc <__memset+0x1d4>
    80007024:	1cd76463          	bltu	a4,a3,800071ec <__memset+0x1f4>
    80007028:	1a078e63          	beqz	a5,800071e4 <__memset+0x1ec>
    8000702c:	00b50023          	sb	a1,0(a0)
    80007030:	00100713          	li	a4,1
    80007034:	1ae78463          	beq	a5,a4,800071dc <__memset+0x1e4>
    80007038:	00b500a3          	sb	a1,1(a0)
    8000703c:	00200713          	li	a4,2
    80007040:	1ae78a63          	beq	a5,a4,800071f4 <__memset+0x1fc>
    80007044:	00b50123          	sb	a1,2(a0)
    80007048:	00300713          	li	a4,3
    8000704c:	18e78463          	beq	a5,a4,800071d4 <__memset+0x1dc>
    80007050:	00b501a3          	sb	a1,3(a0)
    80007054:	00400713          	li	a4,4
    80007058:	1ae78263          	beq	a5,a4,800071fc <__memset+0x204>
    8000705c:	00b50223          	sb	a1,4(a0)
    80007060:	00500713          	li	a4,5
    80007064:	1ae78063          	beq	a5,a4,80007204 <__memset+0x20c>
    80007068:	00b502a3          	sb	a1,5(a0)
    8000706c:	00700713          	li	a4,7
    80007070:	18e79e63          	bne	a5,a4,8000720c <__memset+0x214>
    80007074:	00b50323          	sb	a1,6(a0)
    80007078:	00700e93          	li	t4,7
    8000707c:	00859713          	slli	a4,a1,0x8
    80007080:	00e5e733          	or	a4,a1,a4
    80007084:	01059e13          	slli	t3,a1,0x10
    80007088:	01c76e33          	or	t3,a4,t3
    8000708c:	01859313          	slli	t1,a1,0x18
    80007090:	006e6333          	or	t1,t3,t1
    80007094:	02059893          	slli	a7,a1,0x20
    80007098:	40f60e3b          	subw	t3,a2,a5
    8000709c:	011368b3          	or	a7,t1,a7
    800070a0:	02859813          	slli	a6,a1,0x28
    800070a4:	0108e833          	or	a6,a7,a6
    800070a8:	03059693          	slli	a3,a1,0x30
    800070ac:	003e589b          	srliw	a7,t3,0x3
    800070b0:	00d866b3          	or	a3,a6,a3
    800070b4:	03859713          	slli	a4,a1,0x38
    800070b8:	00389813          	slli	a6,a7,0x3
    800070bc:	00f507b3          	add	a5,a0,a5
    800070c0:	00e6e733          	or	a4,a3,a4
    800070c4:	000e089b          	sext.w	a7,t3
    800070c8:	00f806b3          	add	a3,a6,a5
    800070cc:	00e7b023          	sd	a4,0(a5)
    800070d0:	00878793          	addi	a5,a5,8
    800070d4:	fed79ce3          	bne	a5,a3,800070cc <__memset+0xd4>
    800070d8:	ff8e7793          	andi	a5,t3,-8
    800070dc:	0007871b          	sext.w	a4,a5
    800070e0:	01d787bb          	addw	a5,a5,t4
    800070e4:	0ce88e63          	beq	a7,a4,800071c0 <__memset+0x1c8>
    800070e8:	00f50733          	add	a4,a0,a5
    800070ec:	00b70023          	sb	a1,0(a4)
    800070f0:	0017871b          	addiw	a4,a5,1
    800070f4:	0cc77663          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    800070f8:	00e50733          	add	a4,a0,a4
    800070fc:	00b70023          	sb	a1,0(a4)
    80007100:	0027871b          	addiw	a4,a5,2
    80007104:	0ac77e63          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007108:	00e50733          	add	a4,a0,a4
    8000710c:	00b70023          	sb	a1,0(a4)
    80007110:	0037871b          	addiw	a4,a5,3
    80007114:	0ac77663          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007118:	00e50733          	add	a4,a0,a4
    8000711c:	00b70023          	sb	a1,0(a4)
    80007120:	0047871b          	addiw	a4,a5,4
    80007124:	08c77e63          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007128:	00e50733          	add	a4,a0,a4
    8000712c:	00b70023          	sb	a1,0(a4)
    80007130:	0057871b          	addiw	a4,a5,5
    80007134:	08c77663          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007138:	00e50733          	add	a4,a0,a4
    8000713c:	00b70023          	sb	a1,0(a4)
    80007140:	0067871b          	addiw	a4,a5,6
    80007144:	06c77e63          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007148:	00e50733          	add	a4,a0,a4
    8000714c:	00b70023          	sb	a1,0(a4)
    80007150:	0077871b          	addiw	a4,a5,7
    80007154:	06c77663          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007158:	00e50733          	add	a4,a0,a4
    8000715c:	00b70023          	sb	a1,0(a4)
    80007160:	0087871b          	addiw	a4,a5,8
    80007164:	04c77e63          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007168:	00e50733          	add	a4,a0,a4
    8000716c:	00b70023          	sb	a1,0(a4)
    80007170:	0097871b          	addiw	a4,a5,9
    80007174:	04c77663          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007178:	00e50733          	add	a4,a0,a4
    8000717c:	00b70023          	sb	a1,0(a4)
    80007180:	00a7871b          	addiw	a4,a5,10
    80007184:	02c77e63          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007188:	00e50733          	add	a4,a0,a4
    8000718c:	00b70023          	sb	a1,0(a4)
    80007190:	00b7871b          	addiw	a4,a5,11
    80007194:	02c77663          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    80007198:	00e50733          	add	a4,a0,a4
    8000719c:	00b70023          	sb	a1,0(a4)
    800071a0:	00c7871b          	addiw	a4,a5,12
    800071a4:	00c77e63          	bgeu	a4,a2,800071c0 <__memset+0x1c8>
    800071a8:	00e50733          	add	a4,a0,a4
    800071ac:	00b70023          	sb	a1,0(a4)
    800071b0:	00d7879b          	addiw	a5,a5,13
    800071b4:	00c7f663          	bgeu	a5,a2,800071c0 <__memset+0x1c8>
    800071b8:	00f507b3          	add	a5,a0,a5
    800071bc:	00b78023          	sb	a1,0(a5)
    800071c0:	00813403          	ld	s0,8(sp)
    800071c4:	01010113          	addi	sp,sp,16
    800071c8:	00008067          	ret
    800071cc:	00b00693          	li	a3,11
    800071d0:	e55ff06f          	j	80007024 <__memset+0x2c>
    800071d4:	00300e93          	li	t4,3
    800071d8:	ea5ff06f          	j	8000707c <__memset+0x84>
    800071dc:	00100e93          	li	t4,1
    800071e0:	e9dff06f          	j	8000707c <__memset+0x84>
    800071e4:	00000e93          	li	t4,0
    800071e8:	e95ff06f          	j	8000707c <__memset+0x84>
    800071ec:	00000793          	li	a5,0
    800071f0:	ef9ff06f          	j	800070e8 <__memset+0xf0>
    800071f4:	00200e93          	li	t4,2
    800071f8:	e85ff06f          	j	8000707c <__memset+0x84>
    800071fc:	00400e93          	li	t4,4
    80007200:	e7dff06f          	j	8000707c <__memset+0x84>
    80007204:	00500e93          	li	t4,5
    80007208:	e75ff06f          	j	8000707c <__memset+0x84>
    8000720c:	00600e93          	li	t4,6
    80007210:	e6dff06f          	j	8000707c <__memset+0x84>

0000000080007214 <__memmove>:
    80007214:	ff010113          	addi	sp,sp,-16
    80007218:	00813423          	sd	s0,8(sp)
    8000721c:	01010413          	addi	s0,sp,16
    80007220:	0e060863          	beqz	a2,80007310 <__memmove+0xfc>
    80007224:	fff6069b          	addiw	a3,a2,-1
    80007228:	0006881b          	sext.w	a6,a3
    8000722c:	0ea5e863          	bltu	a1,a0,8000731c <__memmove+0x108>
    80007230:	00758713          	addi	a4,a1,7
    80007234:	00a5e7b3          	or	a5,a1,a0
    80007238:	40a70733          	sub	a4,a4,a0
    8000723c:	0077f793          	andi	a5,a5,7
    80007240:	00f73713          	sltiu	a4,a4,15
    80007244:	00174713          	xori	a4,a4,1
    80007248:	0017b793          	seqz	a5,a5
    8000724c:	00e7f7b3          	and	a5,a5,a4
    80007250:	10078863          	beqz	a5,80007360 <__memmove+0x14c>
    80007254:	00900793          	li	a5,9
    80007258:	1107f463          	bgeu	a5,a6,80007360 <__memmove+0x14c>
    8000725c:	0036581b          	srliw	a6,a2,0x3
    80007260:	fff8081b          	addiw	a6,a6,-1
    80007264:	02081813          	slli	a6,a6,0x20
    80007268:	01d85893          	srli	a7,a6,0x1d
    8000726c:	00858813          	addi	a6,a1,8
    80007270:	00058793          	mv	a5,a1
    80007274:	00050713          	mv	a4,a0
    80007278:	01088833          	add	a6,a7,a6
    8000727c:	0007b883          	ld	a7,0(a5)
    80007280:	00878793          	addi	a5,a5,8
    80007284:	00870713          	addi	a4,a4,8
    80007288:	ff173c23          	sd	a7,-8(a4)
    8000728c:	ff0798e3          	bne	a5,a6,8000727c <__memmove+0x68>
    80007290:	ff867713          	andi	a4,a2,-8
    80007294:	02071793          	slli	a5,a4,0x20
    80007298:	0207d793          	srli	a5,a5,0x20
    8000729c:	00f585b3          	add	a1,a1,a5
    800072a0:	40e686bb          	subw	a3,a3,a4
    800072a4:	00f507b3          	add	a5,a0,a5
    800072a8:	06e60463          	beq	a2,a4,80007310 <__memmove+0xfc>
    800072ac:	0005c703          	lbu	a4,0(a1)
    800072b0:	00e78023          	sb	a4,0(a5)
    800072b4:	04068e63          	beqz	a3,80007310 <__memmove+0xfc>
    800072b8:	0015c603          	lbu	a2,1(a1)
    800072bc:	00100713          	li	a4,1
    800072c0:	00c780a3          	sb	a2,1(a5)
    800072c4:	04e68663          	beq	a3,a4,80007310 <__memmove+0xfc>
    800072c8:	0025c603          	lbu	a2,2(a1)
    800072cc:	00200713          	li	a4,2
    800072d0:	00c78123          	sb	a2,2(a5)
    800072d4:	02e68e63          	beq	a3,a4,80007310 <__memmove+0xfc>
    800072d8:	0035c603          	lbu	a2,3(a1)
    800072dc:	00300713          	li	a4,3
    800072e0:	00c781a3          	sb	a2,3(a5)
    800072e4:	02e68663          	beq	a3,a4,80007310 <__memmove+0xfc>
    800072e8:	0045c603          	lbu	a2,4(a1)
    800072ec:	00400713          	li	a4,4
    800072f0:	00c78223          	sb	a2,4(a5)
    800072f4:	00e68e63          	beq	a3,a4,80007310 <__memmove+0xfc>
    800072f8:	0055c603          	lbu	a2,5(a1)
    800072fc:	00500713          	li	a4,5
    80007300:	00c782a3          	sb	a2,5(a5)
    80007304:	00e68663          	beq	a3,a4,80007310 <__memmove+0xfc>
    80007308:	0065c703          	lbu	a4,6(a1)
    8000730c:	00e78323          	sb	a4,6(a5)
    80007310:	00813403          	ld	s0,8(sp)
    80007314:	01010113          	addi	sp,sp,16
    80007318:	00008067          	ret
    8000731c:	02061713          	slli	a4,a2,0x20
    80007320:	02075713          	srli	a4,a4,0x20
    80007324:	00e587b3          	add	a5,a1,a4
    80007328:	f0f574e3          	bgeu	a0,a5,80007230 <__memmove+0x1c>
    8000732c:	02069613          	slli	a2,a3,0x20
    80007330:	02065613          	srli	a2,a2,0x20
    80007334:	fff64613          	not	a2,a2
    80007338:	00e50733          	add	a4,a0,a4
    8000733c:	00c78633          	add	a2,a5,a2
    80007340:	fff7c683          	lbu	a3,-1(a5)
    80007344:	fff78793          	addi	a5,a5,-1
    80007348:	fff70713          	addi	a4,a4,-1
    8000734c:	00d70023          	sb	a3,0(a4)
    80007350:	fec798e3          	bne	a5,a2,80007340 <__memmove+0x12c>
    80007354:	00813403          	ld	s0,8(sp)
    80007358:	01010113          	addi	sp,sp,16
    8000735c:	00008067          	ret
    80007360:	02069713          	slli	a4,a3,0x20
    80007364:	02075713          	srli	a4,a4,0x20
    80007368:	00170713          	addi	a4,a4,1
    8000736c:	00e50733          	add	a4,a0,a4
    80007370:	00050793          	mv	a5,a0
    80007374:	0005c683          	lbu	a3,0(a1)
    80007378:	00178793          	addi	a5,a5,1
    8000737c:	00158593          	addi	a1,a1,1
    80007380:	fed78fa3          	sb	a3,-1(a5)
    80007384:	fee798e3          	bne	a5,a4,80007374 <__memmove+0x160>
    80007388:	f89ff06f          	j	80007310 <__memmove+0xfc>
	...

Disassembly of section .user:

000000008000c4b0 <copy_and_swap-0xb50>:
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
    8000d43c:	b84080e7          	jalr	-1148(ra) # 8000efbc <_Znwm>
    8000d440:	00050913          	mv	s2,a0
    8000d444:	00050863          	beqz	a0,8000d454 <_ZN9BufferCPPC1Ei+0x68>
    8000d448:	00000593          	li	a1,0
    8000d44c:	00002097          	auipc	ra,0x2
    8000d450:	c68080e7          	jalr	-920(ra) # 8000f0b4 <_ZN9SemaphoreC1Ej>
    8000d454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000d458:	01000513          	li	a0,16
    8000d45c:	00002097          	auipc	ra,0x2
    8000d460:	b60080e7          	jalr	-1184(ra) # 8000efbc <_Znwm>
    8000d464:	00050913          	mv	s2,a0
    8000d468:	00050863          	beqz	a0,8000d478 <_ZN9BufferCPPC1Ei+0x8c>
    8000d46c:	00098593          	mv	a1,s3
    8000d470:	00002097          	auipc	ra,0x2
    8000d474:	c44080e7          	jalr	-956(ra) # 8000f0b4 <_ZN9SemaphoreC1Ej>
    8000d478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000d47c:	01000513          	li	a0,16
    8000d480:	00002097          	auipc	ra,0x2
    8000d484:	b3c080e7          	jalr	-1220(ra) # 8000efbc <_Znwm>
    8000d488:	00050913          	mv	s2,a0
    8000d48c:	00050863          	beqz	a0,8000d49c <_ZN9BufferCPPC1Ei+0xb0>
    8000d490:	00100593          	li	a1,1
    8000d494:	00002097          	auipc	ra,0x2
    8000d498:	c20080e7          	jalr	-992(ra) # 8000f0b4 <_ZN9SemaphoreC1Ej>
    8000d49c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000d4a0:	01000513          	li	a0,16
    8000d4a4:	00002097          	auipc	ra,0x2
    8000d4a8:	b18080e7          	jalr	-1256(ra) # 8000efbc <_Znwm>
    8000d4ac:	00050913          	mv	s2,a0
    8000d4b0:	00050863          	beqz	a0,8000d4c0 <_ZN9BufferCPPC1Ei+0xd4>
    8000d4b4:	00100593          	li	a1,1
    8000d4b8:	00002097          	auipc	ra,0x2
    8000d4bc:	bfc080e7          	jalr	-1028(ra) # 8000f0b4 <_ZN9SemaphoreC1Ej>
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
    8000d4ec:	b24080e7          	jalr	-1244(ra) # 8000f00c <_ZdlPv>
    8000d4f0:	00048513          	mv	a0,s1
    8000d4f4:	fffff097          	auipc	ra,0xfffff
    8000d4f8:	e24080e7          	jalr	-476(ra) # 8000c318 <_Unwind_Resume>
    8000d4fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000d500:	00090513          	mv	a0,s2
    8000d504:	00002097          	auipc	ra,0x2
    8000d508:	b08080e7          	jalr	-1272(ra) # 8000f00c <_ZdlPv>
    8000d50c:	00048513          	mv	a0,s1
    8000d510:	fffff097          	auipc	ra,0xfffff
    8000d514:	e08080e7          	jalr	-504(ra) # 8000c318 <_Unwind_Resume>
    8000d518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000d51c:	00090513          	mv	a0,s2
    8000d520:	00002097          	auipc	ra,0x2
    8000d524:	aec080e7          	jalr	-1300(ra) # 8000f00c <_ZdlPv>
    8000d528:	00048513          	mv	a0,s1
    8000d52c:	fffff097          	auipc	ra,0xfffff
    8000d530:	dec080e7          	jalr	-532(ra) # 8000c318 <_Unwind_Resume>
    8000d534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000d538:	00090513          	mv	a0,s2
    8000d53c:	00002097          	auipc	ra,0x2
    8000d540:	ad0080e7          	jalr	-1328(ra) # 8000f00c <_ZdlPv>
    8000d544:	00048513          	mv	a0,s1
    8000d548:	fffff097          	auipc	ra,0xfffff
    8000d54c:	dd0080e7          	jalr	-560(ra) # 8000c318 <_Unwind_Resume>

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
    8000d578:	b78080e7          	jalr	-1160(ra) # 8000f0ec <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000d57c:	0304b503          	ld	a0,48(s1)
    8000d580:	00002097          	auipc	ra,0x2
    8000d584:	b6c080e7          	jalr	-1172(ra) # 8000f0ec <_ZN9Semaphore4waitEv>
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
    8000d5b8:	b64080e7          	jalr	-1180(ra) # 8000f118 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000d5bc:	0204b503          	ld	a0,32(s1)
    8000d5c0:	00002097          	auipc	ra,0x2
    8000d5c4:	b58080e7          	jalr	-1192(ra) # 8000f118 <_ZN9Semaphore6signalEv>

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
    8000d604:	aec080e7          	jalr	-1300(ra) # 8000f0ec <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000d608:	0284b503          	ld	a0,40(s1)
    8000d60c:	00002097          	auipc	ra,0x2
    8000d610:	ae0080e7          	jalr	-1312(ra) # 8000f0ec <_ZN9Semaphore4waitEv>

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
    8000d640:	adc080e7          	jalr	-1316(ra) # 8000f118 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000d644:	0184b503          	ld	a0,24(s1)
    8000d648:	00002097          	auipc	ra,0x2
    8000d64c:	ad0080e7          	jalr	-1328(ra) # 8000f118 <_ZN9Semaphore6signalEv>

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
    8000d690:	a60080e7          	jalr	-1440(ra) # 8000f0ec <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000d694:	0304b503          	ld	a0,48(s1)
    8000d698:	00002097          	auipc	ra,0x2
    8000d69c:	a54080e7          	jalr	-1452(ra) # 8000f0ec <_ZN9Semaphore4waitEv>

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
    8000d6b8:	a64080e7          	jalr	-1436(ra) # 8000f118 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000d6bc:	0284b503          	ld	a0,40(s1)
    8000d6c0:	00002097          	auipc	ra,0x2
    8000d6c4:	a58080e7          	jalr	-1448(ra) # 8000f118 <_ZN9Semaphore6signalEv>

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
    8000d714:	c40080e7          	jalr	-960(ra) # 8000f350 <_ZN7Console4putcEc>
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
    8000d750:	c04080e7          	jalr	-1020(ra) # 8000f350 <_ZN7Console4putcEc>
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
    8000d774:	be0080e7          	jalr	-1056(ra) # 8000f350 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000d778:	00a00513          	li	a0,10
    8000d77c:	00002097          	auipc	ra,0x2
    8000d780:	bd4080e7          	jalr	-1068(ra) # 8000f350 <_ZN7Console4putcEc>
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
    8000df00:	0c0080e7          	jalr	192(ra) # 8000efbc <_Znwm>
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
    8000df50:	070080e7          	jalr	112(ra) # 8000efbc <_Znwm>
    8000df54:	00050493          	mv	s1,a0
    8000df58:	00050863          	beqz	a0,8000df68 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000df5c:	00000593          	li	a1,0
    8000df60:	00001097          	auipc	ra,0x1
    8000df64:	154080e7          	jalr	340(ra) # 8000f0b4 <_ZN9SemaphoreC1Ej>
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
    8000dfd0:	ff0080e7          	jalr	-16(ra) # 8000efbc <_Znwm>
    8000dfd4:	00050b13          	mv	s6,a0
    8000dfd8:	02050663          	beqz	a0,8000e004 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    8000dfdc:	00191493          	slli	s1,s2,0x1
    8000dfe0:	012484b3          	add	s1,s1,s2
    8000dfe4:	00349493          	slli	s1,s1,0x3
    8000dfe8:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000dfec:	00001097          	auipc	ra,0x1
    8000dff0:	1ac080e7          	jalr	428(ra) # 8000f198 <_ZN6ThreadC1Ev>
    8000dff4:	00002797          	auipc	a5,0x2
    8000dff8:	2ac78793          	addi	a5,a5,684 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000dffc:	00fb3023          	sd	a5,0(s6) # 2000 <_entry-0x7fffe000>
    8000e000:	009b3823          	sd	s1,16(s6)
        consumer->start();
    8000e004:	000b0513          	mv	a0,s6
    8000e008:	00001097          	auipc	ra,0x1
    8000e00c:	280080e7          	jalr	640(ra) # 8000f288 <_ZN6Thread5startEv>
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
    8000e02c:	f94080e7          	jalr	-108(ra) # 8000efbc <_Znwm>
    8000e030:	00050493          	mv	s1,a0
    8000e034:	00050e63          	beqz	a0,8000e050 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    8000e038:	00001097          	auipc	ra,0x1
    8000e03c:	160080e7          	jalr	352(ra) # 8000f198 <_ZN6ThreadC1Ev>
    8000e040:	00002797          	auipc	a5,0x2
    8000e044:	21078793          	addi	a5,a5,528 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e048:	00f4b023          	sd	a5,0(s1)
    8000e04c:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e050:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    8000e054:	00048513          	mv	a0,s1
    8000e058:	00001097          	auipc	ra,0x1
    8000e05c:	230080e7          	jalr	560(ra) # 8000f288 <_ZN6Thread5startEv>
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
    8000e08c:	200080e7          	jalr	512(ra) # 8000f288 <_ZN6Thread5startEv>
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
    8000e0c4:	efc080e7          	jalr	-260(ra) # 8000efbc <_Znwm>
    8000e0c8:	00050c13          	mv	s8,a0
    8000e0cc:	fa0506e3          	beqz	a0,8000e078 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    8000e0d0:	00149c93          	slli	s9,s1,0x1
    8000e0d4:	009c8cb3          	add	s9,s9,s1
    8000e0d8:	003c9c93          	slli	s9,s9,0x3
    8000e0dc:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000e0e0:	00001097          	auipc	ra,0x1
    8000e0e4:	0b8080e7          	jalr	184(ra) # 8000f198 <_ZN6ThreadC1Ev>
    8000e0e8:	f81ff06f          	j	8000e068 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    8000e0ec:	00001097          	auipc	ra,0x1
    8000e0f0:	174080e7          	jalr	372(ra) # 8000f260 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000e0f4:	00000493          	li	s1,0
    8000e0f8:	00994e63          	blt	s2,s1,8000e114 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    8000e0fc:	00002517          	auipc	a0,0x2
    8000e100:	28453503          	ld	a0,644(a0) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e104:	00001097          	auipc	ra,0x1
    8000e108:	fe8080e7          	jalr	-24(ra) # 8000f0ec <_ZN9Semaphore4waitEv>
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
    8000e188:	e88080e7          	jalr	-376(ra) # 8000f00c <_ZdlPv>
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
    8000e1d4:	e3c080e7          	jalr	-452(ra) # 8000f00c <_ZdlPv>
    8000e1d8:	00048513          	mv	a0,s1
    8000e1dc:	ffffe097          	auipc	ra,0xffffe
    8000e1e0:	13c080e7          	jalr	316(ra) # 8000c318 <_Unwind_Resume>
    8000e1e4:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    8000e1e8:	00048513          	mv	a0,s1
    8000e1ec:	00001097          	auipc	ra,0x1
    8000e1f0:	e20080e7          	jalr	-480(ra) # 8000f00c <_ZdlPv>
    8000e1f4:	00090513          	mv	a0,s2
    8000e1f8:	ffffe097          	auipc	ra,0xffffe
    8000e1fc:	120080e7          	jalr	288(ra) # 8000c318 <_Unwind_Resume>
    8000e200:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000e204:	000b0513          	mv	a0,s6
    8000e208:	00001097          	auipc	ra,0x1
    8000e20c:	e04080e7          	jalr	-508(ra) # 8000f00c <_ZdlPv>
    8000e210:	00048513          	mv	a0,s1
    8000e214:	ffffe097          	auipc	ra,0xffffe
    8000e218:	104080e7          	jalr	260(ra) # 8000c318 <_Unwind_Resume>
    8000e21c:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e220:	00048513          	mv	a0,s1
    8000e224:	00001097          	auipc	ra,0x1
    8000e228:	de8080e7          	jalr	-536(ra) # 8000f00c <_ZdlPv>
    8000e22c:	00090513          	mv	a0,s2
    8000e230:	ffffe097          	auipc	ra,0xffffe
    8000e234:	0e8080e7          	jalr	232(ra) # 8000c318 <_Unwind_Resume>
    8000e238:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000e23c:	000c0513          	mv	a0,s8
    8000e240:	00001097          	auipc	ra,0x1
    8000e244:	dcc080e7          	jalr	-564(ra) # 8000f00c <_ZdlPv>
    8000e248:	00048513          	mv	a0,s1
    8000e24c:	ffffe097          	auipc	ra,0xffffe
    8000e250:	0cc080e7          	jalr	204(ra) # 8000c318 <_Unwind_Resume>

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
    8000e274:	f28080e7          	jalr	-216(ra) # 8000f198 <_ZN6ThreadC1Ev>
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
    8000e298:	ff4080e7          	jalr	-12(ra) # 8000f288 <_ZN6Thread5startEv>
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
    8000e2d4:	cac080e7          	jalr	-852(ra) # 8000ef7c <_ZN6ThreadD1Ev>
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
    8000e304:	c7c080e7          	jalr	-900(ra) # 8000ef7c <_ZN6ThreadD1Ev>
    8000e308:	00048513          	mv	a0,s1
    8000e30c:	ffffe097          	auipc	ra,0xffffe
    8000e310:	00c080e7          	jalr	12(ra) # 8000c318 <_Unwind_Resume>

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
    8000e374:	fe0080e7          	jalr	-32(ra) # 8000f350 <_ZN7Console4putcEc>
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
    8000e3a4:	fb0080e7          	jalr	-80(ra) # 8000f350 <_ZN7Console4putcEc>
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
    8000e3d0:	f84080e7          	jalr	-124(ra) # 8000f350 <_ZN7Console4putcEc>
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
    8000e3f4:	d28080e7          	jalr	-728(ra) # 8000f118 <_ZN9Semaphore6signalEv>
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
    8000e434:	b4c080e7          	jalr	-1204(ra) # 8000ef7c <_ZN6ThreadD1Ev>
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
    8000e470:	b10080e7          	jalr	-1264(ra) # 8000ef7c <_ZN6ThreadD1Ev>
    8000e474:	00048513          	mv	a0,s1
    8000e478:	00001097          	auipc	ra,0x1
    8000e47c:	b94080e7          	jalr	-1132(ra) # 8000f00c <_ZdlPv>
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
    8000e4b4:	acc080e7          	jalr	-1332(ra) # 8000ef7c <_ZN6ThreadD1Ev>
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
    8000e4f0:	a90080e7          	jalr	-1392(ra) # 8000ef7c <_ZN6ThreadD1Ev>
    8000e4f4:	00048513          	mv	a0,s1
    8000e4f8:	00001097          	auipc	ra,0x1
    8000e4fc:	b14080e7          	jalr	-1260(ra) # 8000f00c <_ZdlPv>
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
    8000e534:	a4c080e7          	jalr	-1460(ra) # 8000ef7c <_ZN6ThreadD1Ev>
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
    8000e570:	a10080e7          	jalr	-1520(ra) # 8000ef7c <_ZN6ThreadD1Ev>
    8000e574:	00048513          	mv	a0,s1
    8000e578:	00001097          	auipc	ra,0x1
    8000e57c:	a94080e7          	jalr	-1388(ra) # 8000f00c <_ZdlPv>
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
    8000e5b4:	9cc080e7          	jalr	-1588(ra) # 8000ef7c <_ZN6ThreadD1Ev>
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
    8000e5f0:	990080e7          	jalr	-1648(ra) # 8000ef7c <_ZN6ThreadD1Ev>
    8000e5f4:	00048513          	mv	a0,s1
    8000e5f8:	00001097          	auipc	ra,0x1
    8000e5fc:	a14080e7          	jalr	-1516(ra) # 8000f00c <_ZdlPv>
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
    8000e680:	a9c080e7          	jalr	-1380(ra) # 8000f118 <_ZN9Semaphore6signalEv>
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
    8000e6fc:	b00080e7          	jalr	-1280(ra) # 8000f1f8 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    8000e700:	fb9ff06f          	j	8000e6b8 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    8000e704:	0104b783          	ld	a5,16(s1)
    8000e708:	0107b503          	ld	a0,16(a5)
    8000e70c:	00001097          	auipc	ra,0x1
    8000e710:	a0c080e7          	jalr	-1524(ra) # 8000f118 <_ZN9Semaphore6signalEv>
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
    8000e794:	82c080e7          	jalr	-2004(ra) # 8000efbc <_Znwm>
    8000e798:	00050993          	mv	s3,a0
    8000e79c:	02050463          	beqz	a0,8000e7c4 <_ZN10ForkThread3runEv+0x98>
    8000e7a0:	010a3483          	ld	s1,16(s4)
    8000e7a4:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e7a8:	00001097          	auipc	ra,0x1
    8000e7ac:	9f0080e7          	jalr	-1552(ra) # 8000f198 <_ZN6ThreadC1Ev>
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
    8000e800:	00000097          	auipc	ra,0x0
    8000e804:	7bc080e7          	jalr	1980(ra) # 8000efbc <_Znwm>
    8000e808:	00050493          	mv	s1,a0
    8000e80c:	fc050ce3          	beqz	a0,8000e7e4 <_ZN10ForkThread3runEv+0xb8>
    8000e810:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e814:	00001097          	auipc	ra,0x1
    8000e818:	984080e7          	jalr	-1660(ra) # 8000f198 <_ZN6ThreadC1Ev>
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
    8000e840:	a4c080e7          	jalr	-1460(ra) # 8000f288 <_ZN6Thread5startEv>
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

000000008000ef18 <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    8000ef18:	ff010113          	addi	sp,sp,-16
    8000ef1c:	00113423          	sd	ra,8(sp)
    8000ef20:	00813023          	sd	s0,0(sp)
    8000ef24:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    8000ef28:	00053783          	ld	a5,0(a0)
    8000ef2c:	0107b783          	ld	a5,16(a5)
    8000ef30:	000780e7          	jalr	a5
}
    8000ef34:	00813083          	ld	ra,8(sp)
    8000ef38:	00013403          	ld	s0,0(sp)
    8000ef3c:	01010113          	addi	sp,sp,16
    8000ef40:	00008067          	ret

000000008000ef44 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    8000ef44:	ff010113          	addi	sp,sp,-16
    8000ef48:	00113423          	sd	ra,8(sp)
    8000ef4c:	00813023          	sd	s0,0(sp)
    8000ef50:	01010413          	addi	s0,sp,16
    8000ef54:	00001797          	auipc	a5,0x1
    8000ef58:	3e478793          	addi	a5,a5,996 # 80010338 <_ZTV9Semaphore+0x10>
    8000ef5c:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    8000ef60:	00853503          	ld	a0,8(a0)
    8000ef64:	ffffe097          	auipc	ra,0xffffe
    8000ef68:	2f0080e7          	jalr	752(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
};
    8000ef6c:	00813083          	ld	ra,8(sp)
    8000ef70:	00013403          	ld	s0,0(sp)
    8000ef74:	01010113          	addi	sp,sp,16
    8000ef78:	00008067          	ret

000000008000ef7c <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    8000ef7c:	00001797          	auipc	a5,0x1
    8000ef80:	3dc78793          	addi	a5,a5,988 # 80010358 <_ZTV6Thread+0x10>
    8000ef84:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000ef88:	00853503          	ld	a0,8(a0)
    8000ef8c:	02050663          	beqz	a0,8000efb8 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    8000ef90:	ff010113          	addi	sp,sp,-16
    8000ef94:	00113423          	sd	ra,8(sp)
    8000ef98:	00813023          	sd	s0,0(sp)
    8000ef9c:	01010413          	addi	s0,sp,16
    delete myHandle;
    8000efa0:	ffffe097          	auipc	ra,0xffffe
    8000efa4:	424080e7          	jalr	1060(ra) # 8000d3c4 <_ZN7_threaddlEPv>
}
    8000efa8:	00813083          	ld	ra,8(sp)
    8000efac:	00013403          	ld	s0,0(sp)
    8000efb0:	01010113          	addi	sp,sp,16
    8000efb4:	00008067          	ret
    8000efb8:	00008067          	ret

000000008000efbc <_Znwm>:
void* operator new(size_t sz){
    8000efbc:	ff010113          	addi	sp,sp,-16
    8000efc0:	00113423          	sd	ra,8(sp)
    8000efc4:	00813023          	sd	s0,0(sp)
    8000efc8:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000efcc:	ffffe097          	auipc	ra,0xffffe
    8000efd0:	054080e7          	jalr	84(ra) # 8000d020 <_Z9mem_allocm>
}
    8000efd4:	00813083          	ld	ra,8(sp)
    8000efd8:	00013403          	ld	s0,0(sp)
    8000efdc:	01010113          	addi	sp,sp,16
    8000efe0:	00008067          	ret

000000008000efe4 <_Znam>:
void* operator new[](size_t sz){
    8000efe4:	ff010113          	addi	sp,sp,-16
    8000efe8:	00113423          	sd	ra,8(sp)
    8000efec:	00813023          	sd	s0,0(sp)
    8000eff0:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000eff4:	ffffe097          	auipc	ra,0xffffe
    8000eff8:	02c080e7          	jalr	44(ra) # 8000d020 <_Z9mem_allocm>
}
    8000effc:	00813083          	ld	ra,8(sp)
    8000f000:	00013403          	ld	s0,0(sp)
    8000f004:	01010113          	addi	sp,sp,16
    8000f008:	00008067          	ret

000000008000f00c <_ZdlPv>:
void operator delete(void *ptr){
    8000f00c:	ff010113          	addi	sp,sp,-16
    8000f010:	00113423          	sd	ra,8(sp)
    8000f014:	00813023          	sd	s0,0(sp)
    8000f018:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    8000f01c:	ffffe097          	auipc	ra,0xffffe
    8000f020:	034080e7          	jalr	52(ra) # 8000d050 <_Z8mem_freePv>
}
    8000f024:	00813083          	ld	ra,8(sp)
    8000f028:	00013403          	ld	s0,0(sp)
    8000f02c:	01010113          	addi	sp,sp,16
    8000f030:	00008067          	ret

000000008000f034 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    8000f034:	fe010113          	addi	sp,sp,-32
    8000f038:	00113c23          	sd	ra,24(sp)
    8000f03c:	00813823          	sd	s0,16(sp)
    8000f040:	00913423          	sd	s1,8(sp)
    8000f044:	02010413          	addi	s0,sp,32
    8000f048:	00050493          	mv	s1,a0
};
    8000f04c:	00000097          	auipc	ra,0x0
    8000f050:	ef8080e7          	jalr	-264(ra) # 8000ef44 <_ZN9SemaphoreD1Ev>
    8000f054:	00048513          	mv	a0,s1
    8000f058:	00000097          	auipc	ra,0x0
    8000f05c:	fb4080e7          	jalr	-76(ra) # 8000f00c <_ZdlPv>
    8000f060:	01813083          	ld	ra,24(sp)
    8000f064:	01013403          	ld	s0,16(sp)
    8000f068:	00813483          	ld	s1,8(sp)
    8000f06c:	02010113          	addi	sp,sp,32
    8000f070:	00008067          	ret

000000008000f074 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    8000f074:	fe010113          	addi	sp,sp,-32
    8000f078:	00113c23          	sd	ra,24(sp)
    8000f07c:	00813823          	sd	s0,16(sp)
    8000f080:	00913423          	sd	s1,8(sp)
    8000f084:	02010413          	addi	s0,sp,32
    8000f088:	00050493          	mv	s1,a0
}
    8000f08c:	00000097          	auipc	ra,0x0
    8000f090:	ef0080e7          	jalr	-272(ra) # 8000ef7c <_ZN6ThreadD1Ev>
    8000f094:	00048513          	mv	a0,s1
    8000f098:	00000097          	auipc	ra,0x0
    8000f09c:	f74080e7          	jalr	-140(ra) # 8000f00c <_ZdlPv>
    8000f0a0:	01813083          	ld	ra,24(sp)
    8000f0a4:	01013403          	ld	s0,16(sp)
    8000f0a8:	00813483          	ld	s1,8(sp)
    8000f0ac:	02010113          	addi	sp,sp,32
    8000f0b0:	00008067          	ret

000000008000f0b4 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000f0b4:	ff010113          	addi	sp,sp,-16
    8000f0b8:	00113423          	sd	ra,8(sp)
    8000f0bc:	00813023          	sd	s0,0(sp)
    8000f0c0:	01010413          	addi	s0,sp,16
    8000f0c4:	00001797          	auipc	a5,0x1
    8000f0c8:	27478793          	addi	a5,a5,628 # 80010338 <_ZTV9Semaphore+0x10>
    8000f0cc:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    8000f0d0:	00850513          	addi	a0,a0,8
    8000f0d4:	ffffe097          	auipc	ra,0xffffe
    8000f0d8:	148080e7          	jalr	328(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000f0dc:	00813083          	ld	ra,8(sp)
    8000f0e0:	00013403          	ld	s0,0(sp)
    8000f0e4:	01010113          	addi	sp,sp,16
    8000f0e8:	00008067          	ret

000000008000f0ec <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    8000f0ec:	ff010113          	addi	sp,sp,-16
    8000f0f0:	00113423          	sd	ra,8(sp)
    8000f0f4:	00813023          	sd	s0,0(sp)
    8000f0f8:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    8000f0fc:	00853503          	ld	a0,8(a0)
    8000f100:	ffffe097          	auipc	ra,0xffffe
    8000f104:	180080e7          	jalr	384(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
}
    8000f108:	00813083          	ld	ra,8(sp)
    8000f10c:	00013403          	ld	s0,0(sp)
    8000f110:	01010113          	addi	sp,sp,16
    8000f114:	00008067          	ret

000000008000f118 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    8000f118:	ff010113          	addi	sp,sp,-16
    8000f11c:	00113423          	sd	ra,8(sp)
    8000f120:	00813023          	sd	s0,0(sp)
    8000f124:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    8000f128:	00853503          	ld	a0,8(a0)
    8000f12c:	ffffe097          	auipc	ra,0xffffe
    8000f130:	180080e7          	jalr	384(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
}
    8000f134:	00813083          	ld	ra,8(sp)
    8000f138:	00013403          	ld	s0,0(sp)
    8000f13c:	01010113          	addi	sp,sp,16
    8000f140:	00008067          	ret

000000008000f144 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    8000f144:	fe010113          	addi	sp,sp,-32
    8000f148:	00113c23          	sd	ra,24(sp)
    8000f14c:	00813823          	sd	s0,16(sp)
    8000f150:	00913423          	sd	s1,8(sp)
    8000f154:	02010413          	addi	s0,sp,32
    8000f158:	00050493          	mv	s1,a0
    8000f15c:	00001797          	auipc	a5,0x1
    8000f160:	1fc78793          	addi	a5,a5,508 # 80010358 <_ZTV6Thread+0x10>
    8000f164:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    8000f168:	00850513          	addi	a0,a0,8
    8000f16c:	ffffe097          	auipc	ra,0xffffe
    8000f170:	fe4080e7          	jalr	-28(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f174:	fff00793          	li	a5,-1
    8000f178:	00f50c63          	beq	a0,a5,8000f190 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    8000f17c:	01813083          	ld	ra,24(sp)
    8000f180:	01013403          	ld	s0,16(sp)
    8000f184:	00813483          	ld	s1,8(sp)
    8000f188:	02010113          	addi	sp,sp,32
    8000f18c:	00008067          	ret
        myHandle = nullptr;
    8000f190:	0004b423          	sd	zero,8(s1)
}
    8000f194:	fe9ff06f          	j	8000f17c <_ZN6ThreadC1EPFvPvES0_+0x38>

000000008000f198 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    8000f198:	fe010113          	addi	sp,sp,-32
    8000f19c:	00113c23          	sd	ra,24(sp)
    8000f1a0:	00813823          	sd	s0,16(sp)
    8000f1a4:	00913423          	sd	s1,8(sp)
    8000f1a8:	02010413          	addi	s0,sp,32
    8000f1ac:	00050493          	mv	s1,a0
    8000f1b0:	00001797          	auipc	a5,0x1
    8000f1b4:	1a878793          	addi	a5,a5,424 # 80010358 <_ZTV6Thread+0x10>
    8000f1b8:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    8000f1bc:	00050613          	mv	a2,a0
    8000f1c0:	00000597          	auipc	a1,0x0
    8000f1c4:	d5858593          	addi	a1,a1,-680 # 8000ef18 <_ZN6Thread7wrapperEPv>
    8000f1c8:	00850513          	addi	a0,a0,8
    8000f1cc:	ffffe097          	auipc	ra,0xffffe
    8000f1d0:	f84080e7          	jalr	-124(ra) # 8000d150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    8000f1d4:	fff00793          	li	a5,-1
    8000f1d8:	00f50c63          	beq	a0,a5,8000f1f0 <_ZN6ThreadC1Ev+0x58>
}
    8000f1dc:	01813083          	ld	ra,24(sp)
    8000f1e0:	01013403          	ld	s0,16(sp)
    8000f1e4:	00813483          	ld	s1,8(sp)
    8000f1e8:	02010113          	addi	sp,sp,32
    8000f1ec:	00008067          	ret
        myHandle = nullptr;
    8000f1f0:	0004b423          	sd	zero,8(s1)
}
    8000f1f4:	fe9ff06f          	j	8000f1dc <_ZN6ThreadC1Ev+0x44>

000000008000f1f8 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    8000f1f8:	ff010113          	addi	sp,sp,-16
    8000f1fc:	00113423          	sd	ra,8(sp)
    8000f200:	00813023          	sd	s0,0(sp)
    8000f204:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    8000f208:	ffffe097          	auipc	ra,0xffffe
    8000f20c:	0d0080e7          	jalr	208(ra) # 8000d2d8 <_Z10time_sleepm>
}
    8000f210:	00813083          	ld	ra,8(sp)
    8000f214:	00013403          	ld	s0,0(sp)
    8000f218:	01010113          	addi	sp,sp,16
    8000f21c:	00008067          	ret

000000008000f220 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    8000f220:	fe010113          	addi	sp,sp,-32
    8000f224:	00113c23          	sd	ra,24(sp)
    8000f228:	00813823          	sd	s0,16(sp)
    8000f22c:	00913423          	sd	s1,8(sp)
    8000f230:	01213023          	sd	s2,0(sp)
    8000f234:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    8000f238:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    8000f23c:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    8000f240:	0004b783          	ld	a5,0(s1)
    8000f244:	0187b783          	ld	a5,24(a5)
    8000f248:	00048513          	mv	a0,s1
    8000f24c:	000780e7          	jalr	a5
        pt->sleep(time);
    8000f250:	00090513          	mv	a0,s2
    8000f254:	00000097          	auipc	ra,0x0
    8000f258:	fa4080e7          	jalr	-92(ra) # 8000f1f8 <_ZN6Thread5sleepEm>
    while(true){
    8000f25c:	fe5ff06f          	j	8000f240 <_ZN14PeriodicThread7wrapperEPv+0x20>

000000008000f260 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000f260:	ff010113          	addi	sp,sp,-16
    8000f264:	00113423          	sd	ra,8(sp)
    8000f268:	00813023          	sd	s0,0(sp)
    8000f26c:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000f270:	ffffe097          	auipc	ra,0xffffe
    8000f274:	ec0080e7          	jalr	-320(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000f278:	00813083          	ld	ra,8(sp)
    8000f27c:	00013403          	ld	s0,0(sp)
    8000f280:	01010113          	addi	sp,sp,16
    8000f284:	00008067          	ret

000000008000f288 <_ZN6Thread5startEv>:
int Thread::start() {
    8000f288:	ff010113          	addi	sp,sp,-16
    8000f28c:	00113423          	sd	ra,8(sp)
    8000f290:	00813023          	sd	s0,0(sp)
    8000f294:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    8000f298:	00853503          	ld	a0,8(a0)
    8000f29c:	ffffe097          	auipc	ra,0xffffe
    8000f2a0:	f48080e7          	jalr	-184(ra) # 8000d1e4 <_Z12thread_startP7_thread>
}
    8000f2a4:	00813083          	ld	ra,8(sp)
    8000f2a8:	00013403          	ld	s0,0(sp)
    8000f2ac:	01010113          	addi	sp,sp,16
    8000f2b0:	00008067          	ret

000000008000f2b4 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f2b4:	fe010113          	addi	sp,sp,-32
    8000f2b8:	00113c23          	sd	ra,24(sp)
    8000f2bc:	00813823          	sd	s0,16(sp)
    8000f2c0:	00913423          	sd	s1,8(sp)
    8000f2c4:	01213023          	sd	s2,0(sp)
    8000f2c8:	02010413          	addi	s0,sp,32
    8000f2cc:	00050493          	mv	s1,a0
    8000f2d0:	00058913          	mv	s2,a1
    8000f2d4:	01000513          	li	a0,16
    8000f2d8:	00000097          	auipc	ra,0x0
    8000f2dc:	ce4080e7          	jalr	-796(ra) # 8000efbc <_Znwm>
    8000f2e0:	00050613          	mv	a2,a0
    8000f2e4:	00050663          	beqz	a0,8000f2f0 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    8000f2e8:	00953023          	sd	s1,0(a0)
    8000f2ec:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000f2f0:	00000597          	auipc	a1,0x0
    8000f2f4:	f3058593          	addi	a1,a1,-208 # 8000f220 <_ZN14PeriodicThread7wrapperEPv>
    8000f2f8:	00048513          	mv	a0,s1
    8000f2fc:	00000097          	auipc	ra,0x0
    8000f300:	e48080e7          	jalr	-440(ra) # 8000f144 <_ZN6ThreadC1EPFvPvES0_>
    8000f304:	00001797          	auipc	a5,0x1
    8000f308:	00478793          	addi	a5,a5,4 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f30c:	00f4b023          	sd	a5,0(s1)
    8000f310:	01813083          	ld	ra,24(sp)
    8000f314:	01013403          	ld	s0,16(sp)
    8000f318:	00813483          	ld	s1,8(sp)
    8000f31c:	00013903          	ld	s2,0(sp)
    8000f320:	02010113          	addi	sp,sp,32
    8000f324:	00008067          	ret

000000008000f328 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    8000f328:	ff010113          	addi	sp,sp,-16
    8000f32c:	00113423          	sd	ra,8(sp)
    8000f330:	00813023          	sd	s0,0(sp)
    8000f334:	01010413          	addi	s0,sp,16
    return ::getc();
    8000f338:	ffffe097          	auipc	ra,0xffffe
    8000f33c:	fcc080e7          	jalr	-52(ra) # 8000d304 <_Z4getcv>
}
    8000f340:	00813083          	ld	ra,8(sp)
    8000f344:	00013403          	ld	s0,0(sp)
    8000f348:	01010113          	addi	sp,sp,16
    8000f34c:	00008067          	ret

000000008000f350 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    8000f350:	ff010113          	addi	sp,sp,-16
    8000f354:	00113423          	sd	ra,8(sp)
    8000f358:	00813023          	sd	s0,0(sp)
    8000f35c:	01010413          	addi	s0,sp,16
    ::putc(c);
    8000f360:	ffffe097          	auipc	ra,0xffffe
    8000f364:	fcc080e7          	jalr	-52(ra) # 8000d32c <_Z4putcc>
}
    8000f368:	00813083          	ld	ra,8(sp)
    8000f36c:	00013403          	ld	s0,0(sp)
    8000f370:	01010113          	addi	sp,sp,16
    8000f374:	00008067          	ret

000000008000f378 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    8000f378:	ff010113          	addi	sp,sp,-16
    8000f37c:	00813423          	sd	s0,8(sp)
    8000f380:	01010413          	addi	s0,sp,16
    8000f384:	00813403          	ld	s0,8(sp)
    8000f388:	01010113          	addi	sp,sp,16
    8000f38c:	00008067          	ret

000000008000f390 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    8000f390:	ff010113          	addi	sp,sp,-16
    8000f394:	00813423          	sd	s0,8(sp)
    8000f398:	01010413          	addi	s0,sp,16
    8000f39c:	00813403          	ld	s0,8(sp)
    8000f3a0:	01010113          	addi	sp,sp,16
    8000f3a4:	00008067          	ret

000000008000f3a8 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    8000f3a8:	ff010113          	addi	sp,sp,-16
    8000f3ac:	00113423          	sd	ra,8(sp)
    8000f3b0:	00813023          	sd	s0,0(sp)
    8000f3b4:	01010413          	addi	s0,sp,16
    8000f3b8:	00001797          	auipc	a5,0x1
    8000f3bc:	f5078793          	addi	a5,a5,-176 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f3c0:	00f53023          	sd	a5,0(a0)
    8000f3c4:	00000097          	auipc	ra,0x0
    8000f3c8:	bb8080e7          	jalr	-1096(ra) # 8000ef7c <_ZN6ThreadD1Ev>
    8000f3cc:	00813083          	ld	ra,8(sp)
    8000f3d0:	00013403          	ld	s0,0(sp)
    8000f3d4:	01010113          	addi	sp,sp,16
    8000f3d8:	00008067          	ret

000000008000f3dc <_ZN14PeriodicThreadD0Ev>:
    8000f3dc:	fe010113          	addi	sp,sp,-32
    8000f3e0:	00113c23          	sd	ra,24(sp)
    8000f3e4:	00813823          	sd	s0,16(sp)
    8000f3e8:	00913423          	sd	s1,8(sp)
    8000f3ec:	02010413          	addi	s0,sp,32
    8000f3f0:	00050493          	mv	s1,a0
    8000f3f4:	00001797          	auipc	a5,0x1
    8000f3f8:	f1478793          	addi	a5,a5,-236 # 80010308 <_ZTV14PeriodicThread+0x10>
    8000f3fc:	00f53023          	sd	a5,0(a0)
    8000f400:	00000097          	auipc	ra,0x0
    8000f404:	b7c080e7          	jalr	-1156(ra) # 8000ef7c <_ZN6ThreadD1Ev>
    8000f408:	00048513          	mv	a0,s1
    8000f40c:	00000097          	auipc	ra,0x0
    8000f410:	c00080e7          	jalr	-1024(ra) # 8000f00c <_ZdlPv>
    8000f414:	01813083          	ld	ra,24(sp)
    8000f418:	01013403          	ld	s0,16(sp)
    8000f41c:	00813483          	ld	s1,8(sp)
    8000f420:	02010113          	addi	sp,sp,32
    8000f424:	00008067          	ret

000000008000f428 <_Z11bodyWrapperPFvPvES_>:
#include "../../h/user/user_wrappers.hpp"
#include "../../h/user/syscall_c.h"
#include "tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    8000f428:	ff010113          	addi	sp,sp,-16
    8000f42c:	00113423          	sd	ra,8(sp)
    8000f430:	00813023          	sd	s0,0(sp)
    8000f434:	01010413          	addi	s0,sp,16
    8000f438:	00050793          	mv	a5,a0
    body(args);
    8000f43c:	00058513          	mv	a0,a1
    8000f440:	000780e7          	jalr	a5
    thread_exit();
    8000f444:	ffffe097          	auipc	ra,0xffffe
    8000f448:	cc4080e7          	jalr	-828(ra) # 8000d108 <_Z11thread_exitv>
}
    8000f44c:	00813083          	ld	ra,8(sp)
    8000f450:	00013403          	ld	s0,0(sp)
    8000f454:	01010113          	addi	sp,sp,16
    8000f458:	00008067          	ret

000000008000f45c <_Z15userMainWrapperPv>:

void userMainWrapper(void* args) {
    8000f45c:	ff010113          	addi	sp,sp,-16
    8000f460:	00113423          	sd	ra,8(sp)
    8000f464:	00813023          	sd	s0,0(sp)
    8000f468:	01010413          	addi	s0,sp,16
    userMain();
    8000f46c:	fffff097          	auipc	ra,0xfffff
    8000f470:	ea8080e7          	jalr	-344(ra) # 8000e314 <_Z8userMainv>
    8000f474:	00813083          	ld	ra,8(sp)
    8000f478:	00013403          	ld	s0,0(sp)
    8000f47c:	01010113          	addi	sp,sp,16
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
    80010308:	f3a8 8000 0000 0000 f3dc 8000 0000 0000     ................
    80010318:	f378 8000 0000 0000 f390 8000 0000 0000     x...............

0000000080010328 <_ZTV9Semaphore>:
	...
    80010338:	ef44 8000 0000 0000 f034 8000 0000 0000     D.......4.......

0000000080010348 <_ZTV6Thread>:
	...
    80010358:	ef7c 8000 0000 0000 f074 8000 0000 0000     |.......t.......
    80010368:	f378 8000 0000 0000                         x.......

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
