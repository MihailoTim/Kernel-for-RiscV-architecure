
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	ff013103          	ld	sp,-16(sp) # 8000aff0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	4d0050ef          	jal	ra,800054ec <start>

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
    80001088:	025020ef          	jal	ra,800038ac <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001238:	cac78793          	addi	a5,a5,-852 # 8000aee0 <_ZL11CACHE_NAMES>
    8000123c:	00e787b3          	add	a5,a5,a4
    80001240:	000c0b13          	mv	s6,s8
    80001244:	00000693          	li	a3,0
    80001248:	00000613          	li	a2,0
    8000124c:	000c0593          	mv	a1,s8
    80001250:	0007b503          	ld	a0,0(a5)
    80001254:	00003097          	auipc	ra,0x3
    80001258:	1dc080e7          	jalr	476(ra) # 80004430 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000125c:	00050a13          	mv	s4,a0

    struct objects_s *objs = (struct objects_s*)(kmalloc(sizeof(struct objects_s) * data.iterations));
    80001260:	f9842b83          	lw	s7,-104(s0)
    80001264:	004b9513          	slli	a0,s7,0x4
    80001268:	00003097          	auipc	ra,0x3
    8000126c:	2c0080e7          	jalr	704(ra) # 80004528 <_Z7kmallocm>
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
    80001290:	1cc080e7          	jalr	460(ra) # 80004458 <_Z16kmem_cache_allocP5Cache>
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
    800012d8:	184080e7          	jalr	388(ra) # 80004458 <_Z16kmem_cache_allocP5Cache>
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
    80001300:	754080e7          	jalr	1876(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    80001304:	fa9ff06f          	j	800012ac <_Z4workPv+0xd0>
    }

    kmem_cache_info(cache);
    80001308:	000a0513          	mv	a0,s4
    8000130c:	00003097          	auipc	ra,0x3
    80001310:	1cc080e7          	jalr	460(ra) # 800044d8 <_Z15kmem_cache_infoP5Cache>
    kmem_cache_info(data.shared);
    80001314:	f9043503          	ld	a0,-112(s0)
    80001318:	00003097          	auipc	ra,0x3
    8000131c:	1c0080e7          	jalr	448(ra) # 800044d8 <_Z15kmem_cache_infoP5Cache>

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
    8000133c:	718080e7          	jalr	1816(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        }
        kmem_cache_free(objs[i].cache, objs[i].data);
    80001340:	0084b583          	ld	a1,8(s1)
    80001344:	0004b503          	ld	a0,0(s1)
    80001348:	00003097          	auipc	ra,0x3
    8000134c:	138080e7          	jalr	312(ra) # 80004480 <_Z15kmem_cache_freeP5CachePv>
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
    80001388:	1cc080e7          	jalr	460(ra) # 80004550 <_Z5kfreePKv>
    kmem_cache_destroy(cache);
    8000138c:	000a0513          	mv	a0,s4
    80001390:	00003097          	auipc	ra,0x3
    80001394:	118080e7          	jalr	280(ra) # 800044a8 <_Z18kmem_cache_destroyP5Cache>
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
    8000147c:	fb8080e7          	jalr	-72(ra) # 80004430 <_Z17kmem_cache_createPKcmPFvPvES3_>
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
    800014b0:	ffc080e7          	jalr	-4(ra) # 800044a8 <_Z18kmem_cache_destroyP5Cache>
}
    800014b4:	03813083          	ld	ra,56(sp)
    800014b8:	03013403          	ld	s0,48(sp)
    800014bc:	02813483          	ld	s1,40(sp)
    800014c0:	04010113          	addi	sp,sp,64
    800014c4:	00008067          	ret

00000000800014c8 <_ZN6SystemC1Ev>:
bool System::initialized = false;


System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
    800014c8:	0000a797          	auipc	a5,0xa
    800014cc:	bf87c783          	lbu	a5,-1032(a5) # 8000b0c0 <_ZN6System11initializedE>
    800014d0:	00078463          	beqz	a5,800014d8 <_ZN6SystemC1Ev+0x10>
    800014d4:	00008067          	ret
System::System() {
    800014d8:	fc010113          	addi	sp,sp,-64
    800014dc:	02113c23          	sd	ra,56(sp)
    800014e0:	02813823          	sd	s0,48(sp)
    800014e4:	02913423          	sd	s1,40(sp)
    800014e8:	03213023          	sd	s2,32(sp)
    800014ec:	01313c23          	sd	s3,24(sp)
    800014f0:	01413823          	sd	s4,16(sp)
    800014f4:	04010413          	addi	s0,sp,64
        initialized = true;
    800014f8:	00100793          	li	a5,1
    800014fc:	0000a717          	auipc	a4,0xa
    80001500:	bcf70223          	sb	a5,-1084(a4) # 8000b0c0 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    80001504:	00003097          	auipc	ra,0x3
    80001508:	ba0080e7          	jalr	-1120(ra) # 800040a4 <_ZN5RiscV10initializeEv>

        Cache *tmp1 = kmem_cache_create("TMP1", 1<<17, nullptr, nullptr);
    8000150c:	00000693          	li	a3,0
    80001510:	00000613          	li	a2,0
    80001514:	000205b7          	lui	a1,0x20
    80001518:	00007517          	auipc	a0,0x7
    8000151c:	b3050513          	addi	a0,a0,-1232 # 80008048 <CONSOLE_STATUS+0x38>
    80001520:	00003097          	auipc	ra,0x3
    80001524:	f10080e7          	jalr	-240(ra) # 80004430 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001528:	00050493          	mv	s1,a0
//        Cache *tmp2 = kmem_cache_create("TMP2", 2048, nullptr, nullptr);
        void* ret1 = kmem_cache_alloc(tmp1);
    8000152c:	00003097          	auipc	ra,0x3
    80001530:	f2c080e7          	jalr	-212(ra) # 80004458 <_Z16kmem_cache_allocP5Cache>
    80001534:	00050913          	mv	s2,a0
        void* ret2 = kmem_cache_alloc(tmp1);
    80001538:	00048513          	mv	a0,s1
    8000153c:	00003097          	auipc	ra,0x3
    80001540:	f1c080e7          	jalr	-228(ra) # 80004458 <_Z16kmem_cache_allocP5Cache>
    80001544:	00050993          	mv	s3,a0
        void* ret3 = kmem_cache_alloc(tmp1);
    80001548:	00048513          	mv	a0,s1
    8000154c:	00003097          	auipc	ra,0x3
    80001550:	f0c080e7          	jalr	-244(ra) # 80004458 <_Z16kmem_cache_allocP5Cache>
    80001554:	00050a13          	mv	s4,a0
        if(ret1 && ret2 && ret3){
    80001558:	0c090263          	beqz	s2,8000161c <_ZN6SystemC1Ev+0x154>
    8000155c:	0c098063          	beqz	s3,8000161c <_ZN6SystemC1Ev+0x154>
    80001560:	0a050e63          	beqz	a0,8000161c <_ZN6SystemC1Ev+0x154>
            SlabAllocator::printSlab(tmp1->partialHead);
    80001564:	0704b503          	ld	a0,112(s1)
    80001568:	00003097          	auipc	ra,0x3
    8000156c:	038080e7          	jalr	56(ra) # 800045a0 <_ZN13SlabAllocator9printSlabEP4Slab>
            kmem_cache_free(tmp1, ret3);
    80001570:	000a0593          	mv	a1,s4
    80001574:	00048513          	mv	a0,s1
    80001578:	00003097          	auipc	ra,0x3
    8000157c:	f08080e7          	jalr	-248(ra) # 80004480 <_Z15kmem_cache_freeP5CachePv>
            SlabAllocator::printSlab(tmp1->partialHead);
    80001580:	0704b503          	ld	a0,112(s1)
    80001584:	00003097          	auipc	ra,0x3
    80001588:	01c080e7          	jalr	28(ra) # 800045a0 <_ZN13SlabAllocator9printSlabEP4Slab>
            kmem_cache_free(tmp1, ret2);
    8000158c:	00098593          	mv	a1,s3
    80001590:	00048513          	mv	a0,s1
    80001594:	00003097          	auipc	ra,0x3
    80001598:	eec080e7          	jalr	-276(ra) # 80004480 <_Z15kmem_cache_freeP5CachePv>
            kmem_cache_free(tmp1, ret1);
    8000159c:	00090593          	mv	a1,s2
    800015a0:	00048513          	mv	a0,s1
    800015a4:	00003097          	auipc	ra,0x3
    800015a8:	edc080e7          	jalr	-292(ra) # 80004480 <_Z15kmem_cache_freeP5CachePv>
            kmem_cache_info(tmp1);
    800015ac:	00048513          	mv	a0,s1
    800015b0:	00003097          	auipc	ra,0x3
    800015b4:	f28080e7          	jalr	-216(ra) # 800044d8 <_Z15kmem_cache_infoP5Cache>
            Buddy::printList();
    800015b8:	00001097          	auipc	ra,0x1
    800015bc:	87c080e7          	jalr	-1924(ra) # 80001e34 <_ZN5Buddy9printListEv>
            int ret = kmem_cache_shrink(tmp1);
    800015c0:	00048513          	mv	a0,s1
    800015c4:	00003097          	auipc	ra,0x3
    800015c8:	f3c080e7          	jalr	-196(ra) # 80004500 <_Z17kmem_cache_shrinkP5Cache>
    800015cc:	00050913          	mv	s2,a0
            Buddy::printList();
    800015d0:	00001097          	auipc	ra,0x1
    800015d4:	864080e7          	jalr	-1948(ra) # 80001e34 <_ZN5Buddy9printListEv>
            ConsoleUtil::print("",ret,"\n",10);
    800015d8:	00a00693          	li	a3,10
    800015dc:	00007617          	auipc	a2,0x7
    800015e0:	b4460613          	addi	a2,a2,-1212 # 80008120 <CONSOLE_STATUS+0x110>
    800015e4:	00090593          	mv	a1,s2
    800015e8:	00007517          	auipc	a0,0x7
    800015ec:	b9050513          	addi	a0,a0,-1136 # 80008178 <CONSOLE_STATUS+0x168>
    800015f0:	00001097          	auipc	ra,0x1
    800015f4:	580080e7          	jalr	1408(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
            kmem_cache_info(tmp1);
    800015f8:	00048513          	mv	a0,s1
    800015fc:	00003097          	auipc	ra,0x3
    80001600:	edc080e7          	jalr	-292(ra) # 800044d8 <_Z15kmem_cache_infoP5Cache>
            kmem_cache_alloc(tmp1);
    80001604:	00048513          	mv	a0,s1
    80001608:	00003097          	auipc	ra,0x3
    8000160c:	e50080e7          	jalr	-432(ra) # 80004458 <_Z16kmem_cache_allocP5Cache>
            SlabAllocator::printSlab(tmp1->partialHead);
    80001610:	0704b503          	ld	a0,112(s1)
    80001614:	00003097          	auipc	ra,0x3
    80001618:	f8c080e7          	jalr	-116(ra) # 800045a0 <_ZN13SlabAllocator9printSlabEP4Slab>
        }

        test2();
    8000161c:	00000097          	auipc	ra,0x0
    80001620:	e30080e7          	jalr	-464(ra) # 8000144c <_Z5test2v>
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), userMainWrapper, nullptr);
    80001624:	00000613          	li	a2,0
    80001628:	0000a597          	auipc	a1,0xa
    8000162c:	9d05b583          	ld	a1,-1584(a1) # 8000aff8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001630:	fc840513          	addi	a0,s0,-56
    80001634:	00002097          	auipc	ra,0x2
    80001638:	e9c080e7          	jalr	-356(ra) # 800034d0 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    8000163c:	fc843783          	ld	a5,-56(s0)
    80001640:	0107a703          	lw	a4,16(a5)
    80001644:	00200793          	li	a5,2
    80001648:	00f70863          	beq	a4,a5,80001658 <_ZN6SystemC1Ev+0x190>
            RiscV::threadDispatchUtil();
    8000164c:	00002097          	auipc	ra,0x2
    80001650:	f20080e7          	jalr	-224(ra) # 8000356c <_ZN5RiscV18threadDispatchUtilEv>
    80001654:	fe9ff06f          	j	8000163c <_ZN6SystemC1Ev+0x174>
        }

        //finalize the machine
        RiscV::finalize();
    80001658:	00001097          	auipc	ra,0x1
    8000165c:	6e0080e7          	jalr	1760(ra) # 80002d38 <_ZN5RiscV8finalizeEv>
    }
    80001660:	03813083          	ld	ra,56(sp)
    80001664:	03013403          	ld	s0,48(sp)
    80001668:	02813483          	ld	s1,40(sp)
    8000166c:	02013903          	ld	s2,32(sp)
    80001670:	01813983          	ld	s3,24(sp)
    80001674:	01013a03          	ld	s4,16(sp)
    80001678:	04010113          	addi	sp,sp,64
    8000167c:	00008067          	ret

0000000080001680 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80001680:	ff010113          	addi	sp,sp,-16
    80001684:	00813423          	sd	s0,8(sp)
    80001688:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    8000168c:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80001690:	00053823          	sd	zero,16(a0)
}
    80001694:	00813403          	ld	s0,8(sp)
    80001698:	01010113          	addi	sp,sp,16
    8000169c:	00008067          	ret

00000000800016a0 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    800016a0:	ff010113          	addi	sp,sp,-16
    800016a4:	00813423          	sd	s0,8(sp)
    800016a8:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    800016ac:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    800016b0:	00053823          	sd	zero,16(a0)
    800016b4:	00813403          	ld	s0,8(sp)
    800016b8:	01010113          	addi	sp,sp,16
    800016bc:	00008067          	ret

00000000800016c0 <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    800016c0:	ff010113          	addi	sp,sp,-16
    800016c4:	00113423          	sd	ra,8(sp)
    800016c8:	00813023          	sd	s0,0(sp)
    800016cc:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    800016d0:	00000697          	auipc	a3,0x0
    800016d4:	fd068693          	addi	a3,a3,-48 # 800016a0 <_ZN3SCB4dtorEPv>
    800016d8:	00000617          	auipc	a2,0x0
    800016dc:	fa860613          	addi	a2,a2,-88 # 80001680 <_ZN3SCB4ctorEPv>
    800016e0:	01800593          	li	a1,24
    800016e4:	00007517          	auipc	a0,0x7
    800016e8:	99450513          	addi	a0,a0,-1644 # 80008078 <CONSOLE_STATUS+0x68>
    800016ec:	00003097          	auipc	ra,0x3
    800016f0:	d44080e7          	jalr	-700(ra) # 80004430 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800016f4:	0000a797          	auipc	a5,0xa
    800016f8:	9ca7ba23          	sd	a0,-1580(a5) # 8000b0c8 <_ZN3SCB8scbCacheE>
}
    800016fc:	00813083          	ld	ra,8(sp)
    80001700:	00013403          	ld	s0,0(sp)
    80001704:	01010113          	addi	sp,sp,16
    80001708:	00008067          	ret

000000008000170c <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    8000170c:	ff010113          	addi	sp,sp,-16
    80001710:	00813423          	sd	s0,8(sp)
    80001714:	01010413          	addi	s0,sp,16
    val = init;
    80001718:	00b52023          	sw	a1,0(a0)
}
    8000171c:	00813403          	ld	s0,8(sp)
    80001720:	01010113          	addi	sp,sp,16
    80001724:	00008067          	ret

0000000080001728 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80001728:	fe010113          	addi	sp,sp,-32
    8000172c:	00113c23          	sd	ra,24(sp)
    80001730:	00813823          	sd	s0,16(sp)
    80001734:	00913423          	sd	s1,8(sp)
    80001738:	01213023          	sd	s2,0(sp)
    8000173c:	02010413          	addi	s0,sp,32
    80001740:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80001744:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80001748:	02050063          	beqz	a0,80001768 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    8000174c:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80001750:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80001754:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80001758:	00003097          	auipc	ra,0x3
    8000175c:	ab4080e7          	jalr	-1356(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80001760:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80001764:	fe5ff06f          	j	80001748 <_ZN3SCBD1Ev+0x20>
}
    80001768:	01813083          	ld	ra,24(sp)
    8000176c:	01013403          	ld	s0,16(sp)
    80001770:	00813483          	ld	s1,8(sp)
    80001774:	00013903          	ld	s2,0(sp)
    80001778:	02010113          	addi	sp,sp,32
    8000177c:	00008067          	ret

0000000080001780 <_ZN3SCB5blockEv>:
void SCB::block() {
    80001780:	ff010113          	addi	sp,sp,-16
    80001784:	00113423          	sd	ra,8(sp)
    80001788:	00813023          	sd	s0,0(sp)
    8000178c:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80001790:	00853783          	ld	a5,8(a0)
    80001794:	04078063          	beqz	a5,800017d4 <_ZN3SCB5blockEv+0x54>
    80001798:	01053703          	ld	a4,16(a0)
    8000179c:	0000a797          	auipc	a5,0xa
    800017a0:	8a47b783          	ld	a5,-1884(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800017a4:	0007b783          	ld	a5,0(a5)
    800017a8:	04f73423          	sd	a5,72(a4)
    800017ac:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    800017b0:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    800017b4:	00300713          	li	a4,3
    800017b8:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800017bc:	00001097          	auipc	ra,0x1
    800017c0:	908080e7          	jalr	-1784(ra) # 800020c4 <_ZN3TCB8dispatchEv>
}
    800017c4:	00813083          	ld	ra,8(sp)
    800017c8:	00013403          	ld	s0,0(sp)
    800017cc:	01010113          	addi	sp,sp,16
    800017d0:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800017d4:	0000a797          	auipc	a5,0xa
    800017d8:	86c7b783          	ld	a5,-1940(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800017dc:	0007b783          	ld	a5,0(a5)
    800017e0:	00f53423          	sd	a5,8(a0)
    800017e4:	fc9ff06f          	j	800017ac <_ZN3SCB5blockEv+0x2c>

00000000800017e8 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    800017e8:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    800017ec:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    800017f0:	04853703          	ld	a4,72(a0)
    800017f4:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    800017f8:	04053423          	sd	zero,72(a0)
    if(tcb) {
    800017fc:	02050a63          	beqz	a0,80001830 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80001800:	ff010113          	addi	sp,sp,-16
    80001804:	00113423          	sd	ra,8(sp)
    80001808:	00813023          	sd	s0,0(sp)
    8000180c:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80001810:	00100793          	li	a5,1
    80001814:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80001818:	00003097          	auipc	ra,0x3
    8000181c:	9f4080e7          	jalr	-1548(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>
}
    80001820:	00813083          	ld	ra,8(sp)
    80001824:	00013403          	ld	s0,0(sp)
    80001828:	01010113          	addi	sp,sp,16
    8000182c:	00008067          	ret
    80001830:	00008067          	ret

0000000080001834 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80001834:	0000a797          	auipc	a5,0xa
    80001838:	80c7b783          	ld	a5,-2036(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000183c:	0007b783          	ld	a5,0(a5)
    80001840:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80001844:	00052783          	lw	a5,0(a0)
    80001848:	fff7879b          	addiw	a5,a5,-1
    8000184c:	00f52023          	sw	a5,0(a0)
    80001850:	02079713          	slli	a4,a5,0x20
    80001854:	00074463          	bltz	a4,8000185c <_ZN3SCB4waitEv+0x28>
    80001858:	00008067          	ret
void SCB::wait() {
    8000185c:	ff010113          	addi	sp,sp,-16
    80001860:	00113423          	sd	ra,8(sp)
    80001864:	00813023          	sd	s0,0(sp)
    80001868:	01010413          	addi	s0,sp,16
        block();
    8000186c:	00000097          	auipc	ra,0x0
    80001870:	f14080e7          	jalr	-236(ra) # 80001780 <_ZN3SCB5blockEv>
}
    80001874:	00813083          	ld	ra,8(sp)
    80001878:	00013403          	ld	s0,0(sp)
    8000187c:	01010113          	addi	sp,sp,16
    80001880:	00008067          	ret

0000000080001884 <_ZN3SCB6signalEv>:
    if(val++<0)
    80001884:	00052783          	lw	a5,0(a0)
    80001888:	0017871b          	addiw	a4,a5,1
    8000188c:	00e52023          	sw	a4,0(a0)
    80001890:	0007c463          	bltz	a5,80001898 <_ZN3SCB6signalEv+0x14>
    80001894:	00008067          	ret
void SCB::signal(){
    80001898:	ff010113          	addi	sp,sp,-16
    8000189c:	00113423          	sd	ra,8(sp)
    800018a0:	00813023          	sd	s0,0(sp)
    800018a4:	01010413          	addi	s0,sp,16
        deblock();
    800018a8:	00000097          	auipc	ra,0x0
    800018ac:	f40080e7          	jalr	-192(ra) # 800017e8 <_ZN3SCB7deblockEv>
}
    800018b0:	00813083          	ld	ra,8(sp)
    800018b4:	00013403          	ld	s0,0(sp)
    800018b8:	01010113          	addi	sp,sp,16
    800018bc:	00008067          	ret

00000000800018c0 <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    800018c0:	ff010113          	addi	sp,sp,-16
    800018c4:	00113423          	sd	ra,8(sp)
    800018c8:	00813023          	sd	s0,0(sp)
    800018cc:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    800018d0:	00009517          	auipc	a0,0x9
    800018d4:	7f853503          	ld	a0,2040(a0) # 8000b0c8 <_ZN3SCB8scbCacheE>
    800018d8:	00003097          	auipc	ra,0x3
    800018dc:	b80080e7          	jalr	-1152(ra) # 80004458 <_Z16kmem_cache_allocP5Cache>
}
    800018e0:	00813083          	ld	ra,8(sp)
    800018e4:	00013403          	ld	s0,0(sp)
    800018e8:	01010113          	addi	sp,sp,16
    800018ec:	00008067          	ret

00000000800018f0 <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    800018f0:	ff010113          	addi	sp,sp,-16
    800018f4:	00113423          	sd	ra,8(sp)
    800018f8:	00813023          	sd	s0,0(sp)
    800018fc:	01010413          	addi	s0,sp,16
    80001900:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80001904:	00009517          	auipc	a0,0x9
    80001908:	7c453503          	ld	a0,1988(a0) # 8000b0c8 <_ZN3SCB8scbCacheE>
    8000190c:	00003097          	auipc	ra,0x3
    80001910:	b74080e7          	jalr	-1164(ra) # 80004480 <_Z15kmem_cache_freeP5CachePv>
}
    80001914:	00813083          	ld	ra,8(sp)
    80001918:	00013403          	ld	s0,0(sp)
    8000191c:	01010113          	addi	sp,sp,16
    80001920:	00008067          	ret

0000000080001924 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80001924:	ff010113          	addi	sp,sp,-16
    80001928:	00813423          	sd	s0,8(sp)
    8000192c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001930:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80001934:	05200513          	li	a0,82
    asm("ecall");
    80001938:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000193c:	00050513          	mv	a0,a0
}
    80001940:	0005051b          	sext.w	a0,a0
    80001944:	00813403          	ld	s0,8(sp)
    80001948:	01010113          	addi	sp,sp,16
    8000194c:	00008067          	ret

0000000080001950 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80001950:	ff010113          	addi	sp,sp,-16
    80001954:	00813423          	sd	s0,8(sp)
    80001958:	01010413          	addi	s0,sp,16
    8000195c:	00100793          	li	a5,1
    80001960:	00f50863          	beq	a0,a5,80001970 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001964:	00813403          	ld	s0,8(sp)
    80001968:	01010113          	addi	sp,sp,16
    8000196c:	00008067          	ret
    80001970:	000107b7          	lui	a5,0x10
    80001974:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001978:	fef596e3          	bne	a1,a5,80001964 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    8000197c:	00009797          	auipc	a5,0x9
    80001980:	6247b783          	ld	a5,1572(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001984:	0007b703          	ld	a4,0(a5)
    80001988:	00c75793          	srli	a5,a4,0xc
    8000198c:	00278793          	addi	a5,a5,2
    80001990:	00c79793          	slli	a5,a5,0xc
    80001994:	00009697          	auipc	a3,0x9
    80001998:	73c68693          	addi	a3,a3,1852 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000199c:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800019a0:	fffff7b7          	lui	a5,0xfffff
    800019a4:	00f77733          	and	a4,a4,a5
    800019a8:	00e6b423          	sd	a4,8(a3)
    800019ac:	fb9ff06f          	j	80001964 <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800019b0 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    800019b0:	ff010113          	addi	sp,sp,-16
    800019b4:	00813423          	sd	s0,8(sp)
    800019b8:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    800019bc:	00009717          	auipc	a4,0x9
    800019c0:	71470713          	addi	a4,a4,1812 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    800019c4:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800019c8:	00009797          	auipc	a5,0x9
    800019cc:	5d87b783          	ld	a5,1496(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800019d0:	0007b783          	ld	a5,0(a5)
    800019d4:	fffff6b7          	lui	a3,0xfffff
    800019d8:	00d7f7b3          	and	a5,a5,a3
    800019dc:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    800019e0:	00009797          	auipc	a5,0x9
    800019e4:	52b7b823          	sd	a1,1328(a5) # 8000af10 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    800019e8:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800019ec:	00000713          	li	a4,0
        while(num>1){
    800019f0:	00100693          	li	a3,1
    800019f4:	00f6f863          	bgeu	a3,a5,80001a04 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    800019f8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800019fc:	00170713          	addi	a4,a4,1
        while(num>1){
    80001a00:	ff1ff06f          	j	800019f0 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80001a04:	00371713          	slli	a4,a4,0x3
    80001a08:	00009797          	auipc	a5,0x9
    80001a0c:	6c878793          	addi	a5,a5,1736 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001a10:	00e78733          	add	a4,a5,a4
    80001a14:	00a73823          	sd	a0,16(a4)
    80001a18:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001a1c:	00000713          	li	a4,0
        while(num>1){
    80001a20:	00100693          	li	a3,1
    80001a24:	00f6f863          	bgeu	a3,a5,80001a34 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80001a28:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001a2c:	00170713          	addi	a4,a4,1
        while(num>1){
    80001a30:	ff1ff06f          	j	80001a20 <_ZN5Buddy10initializeEPvm+0x70>
    80001a34:	00371713          	slli	a4,a4,0x3
    80001a38:	00009797          	auipc	a5,0x9
    80001a3c:	69878793          	addi	a5,a5,1688 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001a40:	00e78733          	add	a4,a5,a4
    80001a44:	06a73c23          	sd	a0,120(a4)
    80001a48:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001a4c:	00000713          	li	a4,0
        while(num>1){
    80001a50:	00100693          	li	a3,1
    80001a54:	00f6f863          	bgeu	a3,a5,80001a64 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80001a58:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001a5c:	00170713          	addi	a4,a4,1
        while(num>1){
    80001a60:	ff1ff06f          	j	80001a50 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80001a64:	00371713          	slli	a4,a4,0x3
    80001a68:	00009797          	auipc	a5,0x9
    80001a6c:	66878793          	addi	a5,a5,1640 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001a70:	00e78733          	add	a4,a5,a4
    80001a74:	01073783          	ld	a5,16(a4)
    80001a78:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80001a7c:	00000793          	li	a5,0
    80001a80:	00c0006f          	j	80001a8c <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80001a84:	0015d593          	srli	a1,a1,0x1
            deg++;
    80001a88:	00178793          	addi	a5,a5,1
        while(num>1){
    80001a8c:	00100713          	li	a4,1
    80001a90:	feb76ae3          	bltu	a4,a1,80001a84 <_ZN5Buddy10initializeEPvm+0xd4>
    80001a94:	00379793          	slli	a5,a5,0x3
    80001a98:	00009717          	auipc	a4,0x9
    80001a9c:	63870713          	addi	a4,a4,1592 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001aa0:	00f707b3          	add	a5,a4,a5
    80001aa4:	0787b783          	ld	a5,120(a5)
    80001aa8:	0007b023          	sd	zero,0(a5)
}
    80001aac:	00813403          	ld	s0,8(sp)
    80001ab0:	01010113          	addi	sp,sp,16
    80001ab4:	00008067          	ret

0000000080001ab8 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001ab8:	00c00793          	li	a5,12
    80001abc:	10f50063          	beq	a0,a5,80001bbc <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80001ac0:	fd010113          	addi	sp,sp,-48
    80001ac4:	02113423          	sd	ra,40(sp)
    80001ac8:	02813023          	sd	s0,32(sp)
    80001acc:	00913c23          	sd	s1,24(sp)
    80001ad0:	01213823          	sd	s2,16(sp)
    80001ad4:	01313423          	sd	s3,8(sp)
    80001ad8:	03010413          	addi	s0,sp,48
    80001adc:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80001ae0:	00351713          	slli	a4,a0,0x3
    80001ae4:	00009797          	auipc	a5,0x9
    80001ae8:	5ec78793          	addi	a5,a5,1516 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001aec:	00e787b3          	add	a5,a5,a4
    80001af0:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80001af4:	00000993          	li	s3,0
    80001af8:	0180006f          	j	80001b10 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80001afc:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80001b00:	04f70463          	beq	a4,a5,80001b48 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80001b04:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80001b08:	08f70063          	beq	a4,a5,80001b88 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80001b0c:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80001b10:	08048863          	beqz	s1,80001ba0 <_ZN5Buddy8compressEm+0xe8>
    80001b14:	0004b683          	ld	a3,0(s1)
    80001b18:	08068463          	beqz	a3,80001ba0 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80001b1c:	00009797          	auipc	a5,0x9
    80001b20:	5b47b783          	ld	a5,1460(a5) # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b24:	40f48733          	sub	a4,s1,a5
    80001b28:	00c9061b          	addiw	a2,s2,12
    80001b2c:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80001b30:	40f687b3          	sub	a5,a3,a5
    80001b34:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80001b38:	00177613          	andi	a2,a4,1
    80001b3c:	fc0610e3          	bnez	a2,80001afc <_ZN5Buddy8compressEm+0x44>
    80001b40:	00170713          	addi	a4,a4,1
    80001b44:	fbdff06f          	j	80001b00 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80001b48:	00098863          	beqz	s3,80001b58 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    80001b4c:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffee000>
    80001b50:	00d9b023          	sd	a3,0(s3)
    80001b54:	fb5ff06f          	j	80001b08 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80001b58:	0006b603          	ld	a2,0(a3)
    80001b5c:	00391593          	slli	a1,s2,0x3
    80001b60:	00009697          	auipc	a3,0x9
    80001b64:	57068693          	addi	a3,a3,1392 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b68:	00b686b3          	add	a3,a3,a1
    80001b6c:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    80001b70:	f8061ce3          	bnez	a2,80001b08 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    80001b74:	00009697          	auipc	a3,0x9
    80001b78:	55c68693          	addi	a3,a3,1372 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b7c:	00b686b3          	add	a3,a3,a1
    80001b80:	0006b823          	sd	zero,16(a3)
    80001b84:	f85ff06f          	j	80001b08 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80001b88:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80001b8c:	00190593          	addi	a1,s2,1
    80001b90:	00048513          	mv	a0,s1
    80001b94:	00000097          	auipc	ra,0x0
    80001b98:	02c080e7          	jalr	44(ra) # 80001bc0 <_ZN5Buddy6insertEPvm>
    80001b9c:	f71ff06f          	j	80001b0c <_ZN5Buddy8compressEm+0x54>
}
    80001ba0:	02813083          	ld	ra,40(sp)
    80001ba4:	02013403          	ld	s0,32(sp)
    80001ba8:	01813483          	ld	s1,24(sp)
    80001bac:	01013903          	ld	s2,16(sp)
    80001bb0:	00813983          	ld	s3,8(sp)
    80001bb4:	03010113          	addi	sp,sp,48
    80001bb8:	00008067          	ret
    80001bbc:	00008067          	ret

0000000080001bc0 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80001bc0:	00050693          	mv	a3,a0
    if(!head[size]){
    80001bc4:	00359713          	slli	a4,a1,0x3
    80001bc8:	00009797          	auipc	a5,0x9
    80001bcc:	50878793          	addi	a5,a5,1288 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001bd0:	00e787b3          	add	a5,a5,a4
    80001bd4:	0787b783          	ld	a5,120(a5)
    80001bd8:	02078c63          	beqz	a5,80001c10 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80001bdc:	ff010113          	addi	sp,sp,-16
    80001be0:	00113423          	sd	ra,8(sp)
    80001be4:	00813023          	sd	s0,0(sp)
    80001be8:	01010413          	addi	s0,sp,16
    80001bec:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80001bf0:	00068713          	mv	a4,a3
    80001bf4:	04f6e063          	bltu	a3,a5,80001c34 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80001bf8:	00000613          	li	a2,0
            while (iter != nullptr) {
    80001bfc:	06078863          	beqz	a5,80001c6c <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80001c00:	04f76c63          	bltu	a4,a5,80001c58 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80001c04:	00078613          	mv	a2,a5
                    iter = iter->next;
    80001c08:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80001c0c:	ff1ff06f          	j	80001bfc <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80001c10:	00009797          	auipc	a5,0x9
    80001c14:	4c078793          	addi	a5,a5,1216 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c18:	00e78533          	add	a0,a5,a4
    80001c1c:	00d53823          	sd	a3,16(a0)
    80001c20:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80001c24:	0006b023          	sd	zero,0(a3)
    80001c28:	07853783          	ld	a5,120(a0)
    80001c2c:	0007b023          	sd	zero,0(a5)
        return;
    80001c30:	00008067          	ret
            newHead->next = head[size];
    80001c34:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80001c38:	00359713          	slli	a4,a1,0x3
    80001c3c:	00009797          	auipc	a5,0x9
    80001c40:	49478793          	addi	a5,a5,1172 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c44:	00e787b3          	add	a5,a5,a4
    80001c48:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80001c4c:	00000097          	auipc	ra,0x0
    80001c50:	e6c080e7          	jalr	-404(ra) # 80001ab8 <_ZN5Buddy8compressEm>
            return;
    80001c54:	0440006f          	j	80001c98 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    80001c58:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80001c5c:	00d63023          	sd	a3,0(a2)
                    compress(size);
    80001c60:	00000097          	auipc	ra,0x0
    80001c64:	e58080e7          	jalr	-424(ra) # 80001ab8 <_ZN5Buddy8compressEm>
                    return;
    80001c68:	0300006f          	j	80001c98 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    80001c6c:	00351713          	slli	a4,a0,0x3
    80001c70:	00009797          	auipc	a5,0x9
    80001c74:	46078793          	addi	a5,a5,1120 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c78:	00e787b3          	add	a5,a5,a4
    80001c7c:	0107b703          	ld	a4,16(a5)
    80001c80:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80001c84:	0107b703          	ld	a4,16(a5)
    80001c88:	00073703          	ld	a4,0(a4)
    80001c8c:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80001c90:	00000097          	auipc	ra,0x0
    80001c94:	e28080e7          	jalr	-472(ra) # 80001ab8 <_ZN5Buddy8compressEm>
}
    80001c98:	00813083          	ld	ra,8(sp)
    80001c9c:	00013403          	ld	s0,0(sp)
    80001ca0:	01010113          	addi	sp,sp,16
    80001ca4:	00008067          	ret

0000000080001ca8 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80001ca8:	02050663          	beqz	a0,80001cd4 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80001cac:	ff010113          	addi	sp,sp,-16
    80001cb0:	00113423          	sd	ra,8(sp)
    80001cb4:	00813023          	sd	s0,0(sp)
    80001cb8:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80001cbc:	00000097          	auipc	ra,0x0
    80001cc0:	f04080e7          	jalr	-252(ra) # 80001bc0 <_ZN5Buddy6insertEPvm>
}
    80001cc4:	00813083          	ld	ra,8(sp)
    80001cc8:	00013403          	ld	s0,0(sp)
    80001ccc:	01010113          	addi	sp,sp,16
    80001cd0:	00008067          	ret
    80001cd4:	00008067          	ret

0000000080001cd8 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001cd8:	ff010113          	addi	sp,sp,-16
    80001cdc:	00813423          	sd	s0,8(sp)
    80001ce0:	01010413          	addi	s0,sp,16
    80001ce4:	03c0006f          	j	80001d20 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001ce8:	00b5859b          	addiw	a1,a1,11
    80001cec:	00100713          	li	a4,1
    80001cf0:	00b715bb          	sllw	a1,a4,a1
    80001cf4:	00b505b3          	add	a1,a0,a1
    80001cf8:	00379693          	slli	a3,a5,0x3
    80001cfc:	00009717          	auipc	a4,0x9
    80001d00:	3d470713          	addi	a4,a4,980 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d04:	00d70733          	add	a4,a4,a3
    80001d08:	00b73823          	sd	a1,16(a4)
    80001d0c:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80001d10:	0005b023          	sd	zero,0(a1)
    80001d14:	07873703          	ld	a4,120(a4)
    80001d18:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001d1c:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80001d20:	fff5879b          	addiw	a5,a1,-1
    80001d24:	04c7c863          	blt	a5,a2,80001d74 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80001d28:	00379693          	slli	a3,a5,0x3
    80001d2c:	00009717          	auipc	a4,0x9
    80001d30:	3a470713          	addi	a4,a4,932 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d34:	00d70733          	add	a4,a4,a3
    80001d38:	01073683          	ld	a3,16(a4)
    80001d3c:	fa0686e3          	beqz	a3,80001ce8 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001d40:	00b5859b          	addiw	a1,a1,11
    80001d44:	00100713          	li	a4,1
    80001d48:	00b715bb          	sllw	a1,a4,a1
    80001d4c:	00b505b3          	add	a1,a0,a1
    80001d50:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80001d54:	00379693          	slli	a3,a5,0x3
    80001d58:	00009717          	auipc	a4,0x9
    80001d5c:	37870713          	addi	a4,a4,888 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d60:	00d70733          	add	a4,a4,a3
    80001d64:	01073683          	ld	a3,16(a4)
    80001d68:	0006b683          	ld	a3,0(a3)
    80001d6c:	00d73823          	sd	a3,16(a4)
    80001d70:	fadff06f          	j	80001d1c <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80001d74:	00813403          	ld	s0,8(sp)
    80001d78:	01010113          	addi	sp,sp,16
    80001d7c:	00008067          	ret

0000000080001d80 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80001d80:	fe010113          	addi	sp,sp,-32
    80001d84:	00113c23          	sd	ra,24(sp)
    80001d88:	00813823          	sd	s0,16(sp)
    80001d8c:	00913423          	sd	s1,8(sp)
    80001d90:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80001d94:	00c00793          	li	a5,12
    80001d98:	06a7ec63          	bltu	a5,a0,80001e10 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001d9c:	00050593          	mv	a1,a0
    80001da0:	00c00793          	li	a5,12
    80001da4:	06b7ea63          	bltu	a5,a1,80001e18 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80001da8:	00359713          	slli	a4,a1,0x3
    80001dac:	00009797          	auipc	a5,0x9
    80001db0:	32478793          	addi	a5,a5,804 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001db4:	00e787b3          	add	a5,a5,a4
    80001db8:	0787b483          	ld	s1,120(a5)
    80001dbc:	00049663          	bnez	s1,80001dc8 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001dc0:	00158593          	addi	a1,a1,1
    80001dc4:	fddff06f          	j	80001da0 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80001dc8:	0004b703          	ld	a4,0(s1)
    80001dcc:	00359693          	slli	a3,a1,0x3
    80001dd0:	00009797          	auipc	a5,0x9
    80001dd4:	30078793          	addi	a5,a5,768 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001dd8:	00d787b3          	add	a5,a5,a3
    80001ddc:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80001de0:	00070e63          	beqz	a4,80001dfc <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80001de4:	0005061b          	sext.w	a2,a0
    80001de8:	0005859b          	sext.w	a1,a1
    80001dec:	00048513          	mv	a0,s1
    80001df0:	00000097          	auipc	ra,0x0
    80001df4:	ee8080e7          	jalr	-280(ra) # 80001cd8 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80001df8:	0240006f          	j	80001e1c <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80001dfc:	00009797          	auipc	a5,0x9
    80001e00:	2d478793          	addi	a5,a5,724 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001e04:	00d787b3          	add	a5,a5,a3
    80001e08:	0007b823          	sd	zero,16(a5)
    80001e0c:	fd9ff06f          	j	80001de4 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80001e10:	00000493          	li	s1,0
    80001e14:	0080006f          	j	80001e1c <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80001e18:	00000493          	li	s1,0
}
    80001e1c:	00048513          	mv	a0,s1
    80001e20:	01813083          	ld	ra,24(sp)
    80001e24:	01013403          	ld	s0,16(sp)
    80001e28:	00813483          	ld	s1,8(sp)
    80001e2c:	02010113          	addi	sp,sp,32
    80001e30:	00008067          	ret

0000000080001e34 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80001e34:	fe010113          	addi	sp,sp,-32
    80001e38:	00113c23          	sd	ra,24(sp)
    80001e3c:	00813823          	sd	s0,16(sp)
    80001e40:	00913423          	sd	s1,8(sp)
    80001e44:	01213023          	sd	s2,0(sp)
    80001e48:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80001e4c:	00000913          	li	s2,0
    80001e50:	0180006f          	j	80001e68 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80001e54:	00006517          	auipc	a0,0x6
    80001e58:	2cc50513          	addi	a0,a0,716 # 80008120 <CONSOLE_STATUS+0x110>
    80001e5c:	00001097          	auipc	ra,0x1
    80001e60:	bf4080e7          	jalr	-1036(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001e64:	0019091b          	addiw	s2,s2,1
    80001e68:	00c00793          	li	a5,12
    80001e6c:	0727c663          	blt	a5,s2,80001ed8 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80001e70:	00000613          	li	a2,0
    80001e74:	00a00593          	li	a1,10
    80001e78:	00090513          	mv	a0,s2
    80001e7c:	00001097          	auipc	ra,0x1
    80001e80:	c18080e7          	jalr	-1000(ra) # 80002a94 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80001e84:	00006517          	auipc	a0,0x6
    80001e88:	20450513          	addi	a0,a0,516 # 80008088 <CONSOLE_STATUS+0x78>
    80001e8c:	00001097          	auipc	ra,0x1
    80001e90:	bc4080e7          	jalr	-1084(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80001e94:	00391713          	slli	a4,s2,0x3
    80001e98:	00009797          	auipc	a5,0x9
    80001e9c:	23878793          	addi	a5,a5,568 # 8000b0d0 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ea0:	00e787b3          	add	a5,a5,a4
    80001ea4:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80001ea8:	fa0486e3          	beqz	s1,80001e54 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    80001eac:	00000613          	li	a2,0
    80001eb0:	01000593          	li	a1,16
    80001eb4:	0004851b          	sext.w	a0,s1
    80001eb8:	00001097          	auipc	ra,0x1
    80001ebc:	bdc080e7          	jalr	-1060(ra) # 80002a94 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80001ec0:	00006517          	auipc	a0,0x6
    80001ec4:	56850513          	addi	a0,a0,1384 # 80008428 <CONSOLE_STATUS+0x418>
    80001ec8:	00001097          	auipc	ra,0x1
    80001ecc:	b88080e7          	jalr	-1144(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80001ed0:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80001ed4:	fd5ff06f          	j	80001ea8 <_ZN5Buddy9printListEv+0x74>
    80001ed8:	01813083          	ld	ra,24(sp)
    80001edc:	01013403          	ld	s0,16(sp)
    80001ee0:	00813483          	ld	s1,8(sp)
    80001ee4:	00013903          	ld	s2,0(sp)
    80001ee8:	02010113          	addi	sp,sp,32
    80001eec:	00008067          	ret

0000000080001ef0 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80001ef0:	ff010113          	addi	sp,sp,-16
    80001ef4:	00113423          	sd	ra,8(sp)
    80001ef8:	00813023          	sd	s0,0(sp)
    80001efc:	01010413          	addi	s0,sp,16
    80001f00:	000105b7          	lui	a1,0x10
    80001f04:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001f08:	00100513          	li	a0,1
    80001f0c:	00000097          	auipc	ra,0x0
    80001f10:	a44080e7          	jalr	-1468(ra) # 80001950 <_Z41__static_initialization_and_destruction_0ii>
    80001f14:	00813083          	ld	ra,8(sp)
    80001f18:	00013403          	ld	s0,0(sp)
    80001f1c:	01010113          	addi	sp,sp,16
    80001f20:	00008067          	ret

0000000080001f24 <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/kernel/system.hpp"

int main() {
    80001f24:	fe010113          	addi	sp,sp,-32
    80001f28:	00113c23          	sd	ra,24(sp)
    80001f2c:	00813823          	sd	s0,16(sp)
    80001f30:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80001f34:	fe840513          	addi	a0,s0,-24
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	590080e7          	jalr	1424(ra) # 800014c8 <_ZN6SystemC1Ev>

    return 0;
    80001f40:	00000513          	li	a0,0
    80001f44:	01813083          	ld	ra,24(sp)
    80001f48:	01013403          	ld	s0,16(sp)
    80001f4c:	02010113          	addi	sp,sp,32
    80001f50:	00008067          	ret

0000000080001f54 <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80001f54:	ff010113          	addi	sp,sp,-16
    80001f58:	00813423          	sd	s0,8(sp)
    80001f5c:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80001f60:	00100793          	li	a5,1
    80001f64:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80001f68:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80001f6c:	00052a23          	sw	zero,20(a0)
}
    80001f70:	00813403          	ld	s0,8(sp)
    80001f74:	01010113          	addi	sp,sp,16
    80001f78:	00008067          	ret

0000000080001f7c <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80001f7c:	ff010113          	addi	sp,sp,-16
    80001f80:	00813423          	sd	s0,8(sp)
    80001f84:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80001f88:	00100793          	li	a5,1
    80001f8c:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80001f90:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80001f94:	00052a23          	sw	zero,20(a0)
    80001f98:	00813403          	ld	s0,8(sp)
    80001f9c:	01010113          	addi	sp,sp,16
    80001fa0:	00008067          	ret

0000000080001fa4 <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80001fa4:	ff010113          	addi	sp,sp,-16
    80001fa8:	00113423          	sd	ra,8(sp)
    80001fac:	00813023          	sd	s0,0(sp)
    80001fb0:	01010413          	addi	s0,sp,16
    if(running->mode == TCB::Mode::SUPERVISOR)
    80001fb4:	00009797          	auipc	a5,0x9
    80001fb8:	1fc7b783          	ld	a5,508(a5) # 8000b1b0 <_ZN3TCB7runningE>
    80001fbc:	0147a703          	lw	a4,20(a5)
    80001fc0:	00100793          	li	a5,1
    80001fc4:	02f70c63          	beq	a4,a5,80001ffc <_ZN3TCB7wrapperEPv+0x58>
        RiscV::popSppSpieUser();
    80001fc8:	00001097          	auipc	ra,0x1
    80001fcc:	c5c080e7          	jalr	-932(ra) # 80002c24 <_ZN5RiscV14popSppSpieUserEv>
    running->body(running->args);
    80001fd0:	00009797          	auipc	a5,0x9
    80001fd4:	1e07b783          	ld	a5,480(a5) # 8000b1b0 <_ZN3TCB7runningE>
    80001fd8:	0187b703          	ld	a4,24(a5)
    80001fdc:	0207b503          	ld	a0,32(a5)
    80001fe0:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    80001fe4:	00001097          	auipc	ra,0x1
    80001fe8:	568080e7          	jalr	1384(ra) # 8000354c <_ZN5RiscV14threadExitUtilEv>
}
    80001fec:	00813083          	ld	ra,8(sp)
    80001ff0:	00013403          	ld	s0,0(sp)
    80001ff4:	01010113          	addi	sp,sp,16
    80001ff8:	00008067          	ret
        RiscV::popSppSpieSystem();
    80001ffc:	00001097          	auipc	ra,0x1
    80002000:	c08080e7          	jalr	-1016(ra) # 80002c04 <_ZN5RiscV16popSppSpieSystemEv>
    80002004:	fcdff06f          	j	80001fd0 <_ZN3TCB7wrapperEPv+0x2c>

0000000080002008 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002008:	ff010113          	addi	sp,sp,-16
    8000200c:	00813423          	sd	s0,8(sp)
    80002010:	01010413          	addi	s0,sp,16
    80002014:	04053823          	sd	zero,80(a0)
    80002018:	04053c23          	sd	zero,88(a0)
    8000201c:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002020:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002024:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002028:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    8000202c:	02058a63          	beqz	a1,80002060 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80002030:	00068793          	mv	a5,a3
    80002034:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002038:	02058863          	beqz	a1,80002068 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    8000203c:	000017b7          	lui	a5,0x1
    80002040:	00f686b3          	add	a3,a3,a5
    80002044:	00d53023          	sd	a3,0(a0)
    80002048:	00000797          	auipc	a5,0x0
    8000204c:	f5c78793          	addi	a5,a5,-164 # 80001fa4 <_ZN3TCB7wrapperEPv>
    80002050:	00f53423          	sd	a5,8(a0)
}
    80002054:	00813403          	ld	s0,8(sp)
    80002058:	01010113          	addi	sp,sp,16
    8000205c:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002060:	00000793          	li	a5,0
    80002064:	fd1ff06f          	j	80002034 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002068:	00000693          	li	a3,0
    8000206c:	fd9ff06f          	j	80002044 <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080002070 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002070:	ff010113          	addi	sp,sp,-16
    80002074:	00113423          	sd	ra,8(sp)
    80002078:	00813023          	sd	s0,0(sp)
    8000207c:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002080:	02853503          	ld	a0,40(a0)
    80002084:	00002097          	auipc	ra,0x2
    80002088:	4cc080e7          	jalr	1228(ra) # 80004550 <_Z5kfreePKv>
}
    8000208c:	00813083          	ld	ra,8(sp)
    80002090:	00013403          	ld	s0,0(sp)
    80002094:	01010113          	addi	sp,sp,16
    80002098:	00008067          	ret

000000008000209c <_ZN3TCBD1Ev>:
TCB::~TCB(){
    8000209c:	ff010113          	addi	sp,sp,-16
    800020a0:	00113423          	sd	ra,8(sp)
    800020a4:	00813023          	sd	s0,0(sp)
    800020a8:	01010413          	addi	s0,sp,16
    free();
    800020ac:	00000097          	auipc	ra,0x0
    800020b0:	fc4080e7          	jalr	-60(ra) # 80002070 <_ZN3TCB4freeEv>
}
    800020b4:	00813083          	ld	ra,8(sp)
    800020b8:	00013403          	ld	s0,0(sp)
    800020bc:	01010113          	addi	sp,sp,16
    800020c0:	00008067          	ret

00000000800020c4 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    800020c4:	fe010113          	addi	sp,sp,-32
    800020c8:	00113c23          	sd	ra,24(sp)
    800020cc:	00813823          	sd	s0,16(sp)
    800020d0:	00913423          	sd	s1,8(sp)
    800020d4:	02010413          	addi	s0,sp,32
    TCB* old = running;
    800020d8:	00009497          	auipc	s1,0x9
    800020dc:	0d84b483          	ld	s1,216(s1) # 8000b1b0 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    800020e0:	0104a703          	lw	a4,16(s1)
    800020e4:	00100793          	li	a5,1
    800020e8:	04e7f663          	bgeu	a5,a4,80002134 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    800020ec:	00002097          	auipc	ra,0x2
    800020f0:	168080e7          	jalr	360(ra) # 80004254 <_ZN9Scheduler3getEv>
    800020f4:	00009797          	auipc	a5,0x9
    800020f8:	0aa7be23          	sd	a0,188(a5) # 8000b1b0 <_ZN3TCB7runningE>
    if(running) {
    800020fc:	02050263          	beqz	a0,80002120 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002100:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002104:	00001097          	auipc	ra,0x1
    80002108:	bf0080e7          	jalr	-1040(ra) # 80002cf4 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    8000210c:	00009597          	auipc	a1,0x9
    80002110:	0a45b583          	ld	a1,164(a1) # 8000b1b0 <_ZN3TCB7runningE>
    80002114:	00048513          	mv	a0,s1
    80002118:	fffff097          	auipc	ra,0xfffff
    8000211c:	008080e7          	jalr	8(ra) # 80001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002120:	01813083          	ld	ra,24(sp)
    80002124:	01013403          	ld	s0,16(sp)
    80002128:	00813483          	ld	s1,8(sp)
    8000212c:	02010113          	addi	sp,sp,32
    80002130:	00008067          	ret
        Scheduler::put(old);
    80002134:	00048513          	mv	a0,s1
    80002138:	00002097          	auipc	ra,0x2
    8000213c:	0d4080e7          	jalr	212(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>
    80002140:	fadff06f          	j	800020ec <_ZN3TCB8dispatchEv+0x28>

0000000080002144 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002144:	ff010113          	addi	sp,sp,-16
    80002148:	00113423          	sd	ra,8(sp)
    8000214c:	00813023          	sd	s0,0(sp)
    80002150:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002154:	00009517          	auipc	a0,0x9
    80002158:	06453503          	ld	a0,100(a0) # 8000b1b8 <_ZN3TCB8tcbCacheE>
    8000215c:	00002097          	auipc	ra,0x2
    80002160:	2fc080e7          	jalr	764(ra) # 80004458 <_Z16kmem_cache_allocP5Cache>
}
    80002164:	00813083          	ld	ra,8(sp)
    80002168:	00013403          	ld	s0,0(sp)
    8000216c:	01010113          	addi	sp,sp,16
    80002170:	00008067          	ret

0000000080002174 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002174:	fe010113          	addi	sp,sp,-32
    80002178:	00113c23          	sd	ra,24(sp)
    8000217c:	00813823          	sd	s0,16(sp)
    80002180:	00913423          	sd	s1,8(sp)
    80002184:	01213023          	sd	s2,0(sp)
    80002188:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    8000218c:	00000697          	auipc	a3,0x0
    80002190:	df068693          	addi	a3,a3,-528 # 80001f7c <_ZN3TCB4dtorEPv>
    80002194:	00000617          	auipc	a2,0x0
    80002198:	dc060613          	addi	a2,a2,-576 # 80001f54 <_ZN3TCB4ctorEPv>
    8000219c:	07000593          	li	a1,112
    800021a0:	00006517          	auipc	a0,0x6
    800021a4:	ef050513          	addi	a0,a0,-272 # 80008090 <CONSOLE_STATUS+0x80>
    800021a8:	00002097          	auipc	ra,0x2
    800021ac:	288080e7          	jalr	648(ra) # 80004430 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800021b0:	00009797          	auipc	a5,0x9
    800021b4:	00a7b423          	sd	a0,8(a5) # 8000b1b8 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    800021b8:	07000513          	li	a0,112
    800021bc:	00000097          	auipc	ra,0x0
    800021c0:	f88080e7          	jalr	-120(ra) # 80002144 <_ZN3TCBnwEm>
    800021c4:	00050493          	mv	s1,a0
    800021c8:	00050e63          	beqz	a0,800021e4 <_ZN3TCB10initializeEv+0x70>
    800021cc:	00200713          	li	a4,2
    800021d0:	00000693          	li	a3,0
    800021d4:	00000613          	li	a2,0
    800021d8:	00000593          	li	a1,0
    800021dc:	00000097          	auipc	ra,0x0
    800021e0:	e2c080e7          	jalr	-468(ra) # 80002008 <_ZN3TCBC1EPFvPvES0_Pmm>
    800021e4:	00009797          	auipc	a5,0x9
    800021e8:	fc97b623          	sd	s1,-52(a5) # 8000b1b0 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    800021ec:	00100793          	li	a5,1
    800021f0:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    800021f4:	00001537          	lui	a0,0x1
    800021f8:	00002097          	auipc	ra,0x2
    800021fc:	330080e7          	jalr	816(ra) # 80004528 <_Z7kmallocm>
    80002200:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002204:	07000513          	li	a0,112
    80002208:	00000097          	auipc	ra,0x0
    8000220c:	f3c080e7          	jalr	-196(ra) # 80002144 <_ZN3TCBnwEm>
    80002210:	00050493          	mv	s1,a0
    80002214:	02050063          	beqz	a0,80002234 <_ZN3TCB10initializeEv+0xc0>
    80002218:	00200713          	li	a4,2
    8000221c:	00090693          	mv	a3,s2
    80002220:	00000613          	li	a2,0
    80002224:	00009597          	auipc	a1,0x9
    80002228:	da45b583          	ld	a1,-604(a1) # 8000afc8 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000222c:	00000097          	auipc	ra,0x0
    80002230:	ddc080e7          	jalr	-548(ra) # 80002008 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002234:	00009797          	auipc	a5,0x9
    80002238:	f897b623          	sd	s1,-116(a5) # 8000b1c0 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    8000223c:	00100793          	li	a5,1
    80002240:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    80002244:	00048513          	mv	a0,s1
    80002248:	00002097          	auipc	ra,0x2
    8000224c:	fc4080e7          	jalr	-60(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>
}
    80002250:	01813083          	ld	ra,24(sp)
    80002254:	01013403          	ld	s0,16(sp)
    80002258:	00813483          	ld	s1,8(sp)
    8000225c:	00013903          	ld	s2,0(sp)
    80002260:	02010113          	addi	sp,sp,32
    80002264:	00008067          	ret

0000000080002268 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    80002268:	ff010113          	addi	sp,sp,-16
    8000226c:	00113423          	sd	ra,8(sp)
    80002270:	00813023          	sd	s0,0(sp)
    80002274:	01010413          	addi	s0,sp,16
    80002278:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    8000227c:	00009517          	auipc	a0,0x9
    80002280:	f3c53503          	ld	a0,-196(a0) # 8000b1b8 <_ZN3TCB8tcbCacheE>
    80002284:	00002097          	auipc	ra,0x2
    80002288:	1fc080e7          	jalr	508(ra) # 80004480 <_Z15kmem_cache_freeP5CachePv>
}
    8000228c:	00813083          	ld	ra,8(sp)
    80002290:	00013403          	ld	s0,0(sp)
    80002294:	01010113          	addi	sp,sp,16
    80002298:	00008067          	ret

000000008000229c <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    8000229c:	ff010113          	addi	sp,sp,-16
    800022a0:	00813423          	sd	s0,8(sp)
    800022a4:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    800022a8:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    800022ac:	05100513          	li	a0,81
    asm("ecall");
    800022b0:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    800022b4:	00050513          	mv	a0,a0
}
    800022b8:	0005051b          	sext.w	a0,a0
    800022bc:	00813403          	ld	s0,8(sp)
    800022c0:	01010113          	addi	sp,sp,16
    800022c4:	00008067          	ret

00000000800022c8 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    800022c8:	ff010113          	addi	sp,sp,-16
    800022cc:	00813423          	sd	s0,8(sp)
    800022d0:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    800022d4:	00009797          	auipc	a5,0x9
    800022d8:	ccc7b783          	ld	a5,-820(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800022dc:	0007b783          	ld	a5,0(a5)
    800022e0:	00c7d793          	srli	a5,a5,0xc
    800022e4:	00278793          	addi	a5,a5,2
    800022e8:	00c79793          	slli	a5,a5,0xc
    800022ec:	01000737          	lui	a4,0x1000
    800022f0:	00e787b3          	add	a5,a5,a4
    800022f4:	00009717          	auipc	a4,0x9
    800022f8:	eec70713          	addi	a4,a4,-276 # 8000b1e0 <_ZN15MemoryAllocator11freeMemTailE>
    800022fc:	00f73023          	sd	a5,0(a4)
    80002300:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002304:	0007b823          	sd	zero,16(a5)
    80002308:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    8000230c:	00073823          	sd	zero,16(a4)
    80002310:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    80002314:	00009697          	auipc	a3,0x9
    80002318:	d446b683          	ld	a3,-700(a3) # 8000b058 <_GLOBAL_OFFSET_TABLE_+0xd0>
    8000231c:	0006b683          	ld	a3,0(a3)
    80002320:	40f686b3          	sub	a3,a3,a5
    80002324:	fe868693          	addi	a3,a3,-24
    80002328:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    8000232c:	00873783          	ld	a5,8(a4)
    80002330:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80002334:	00100793          	li	a5,1
    80002338:	02f70023          	sb	a5,32(a4)
}
    8000233c:	00813403          	ld	s0,8(sp)
    80002340:	01010113          	addi	sp,sp,16
    80002344:	00008067          	ret

0000000080002348 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002348:	ff010113          	addi	sp,sp,-16
    8000234c:	00813423          	sd	s0,8(sp)
    80002350:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    80002354:	14050663          	beqz	a0,800024a0 <_ZN15MemoryAllocator7kmallocEm+0x158>
    80002358:	00050793          	mv	a5,a0
    8000235c:	00009517          	auipc	a0,0x9
    80002360:	e8c53503          	ld	a0,-372(a0) # 8000b1e8 <_ZN15MemoryAllocator11freeMemHeadE>
    80002364:	0a050e63          	beqz	a0,80002420 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80002368:	00053703          	ld	a4,0(a0)
    8000236c:	12f76e63          	bltu	a4,a5,800024a8 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002370:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80002374:	00000613          	li	a2,0
    80002378:	00c0006f          	j	80002384 <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    8000237c:	00050613          	mv	a2,a0
    80002380:	01053503          	ld	a0,16(a0)
    80002384:	00050863          	beqz	a0,80002394 <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002388:	00053683          	ld	a3,0(a0)
    8000238c:	01878713          	addi	a4,a5,24
    80002390:	fee6e6e3          	bltu	a3,a4,8000237c <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002394:	08050663          	beqz	a0,80002420 <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    80002398:	00053683          	ld	a3,0(a0)
    8000239c:	01868713          	addi	a4,a3,24
    800023a0:	00e50733          	add	a4,a0,a4
    800023a4:	00009597          	auipc	a1,0x9
    800023a8:	cb45b583          	ld	a1,-844(a1) # 8000b058 <_GLOBAL_OFFSET_TABLE_+0xd0>
    800023ac:	0005b583          	ld	a1,0(a1)
    800023b0:	00b76463          	bltu	a4,a1,800023b8 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    800023b4:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    800023b8:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    800023bc:	05700593          	li	a1,87
    800023c0:	08d5f063          	bgeu	a1,a3,80002440 <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    800023c4:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    800023c8:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    800023cc:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    800023d0:	01053583          	ld	a1,16(a0)
    800023d4:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    800023d8:	00853583          	ld	a1,8(a0)
    800023dc:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    800023e0:	fe868693          	addi	a3,a3,-24
    800023e4:	00d7b023          	sd	a3,0(a5)

            if(prev)
    800023e8:	04060263          	beqz	a2,8000242c <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    800023ec:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    800023f0:	00009797          	auipc	a5,0x9
    800023f4:	e087b783          	ld	a5,-504(a5) # 8000b1f8 <_ZN15MemoryAllocator12allocMemHeadE>
    800023f8:	06078463          	beqz	a5,80002460 <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    800023fc:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80002400:	08070063          	beqz	a4,80002480 <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    80002404:	00873783          	ld	a5,8(a4)
    80002408:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    8000240c:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80002410:	00873783          	ld	a5,8(a4)
    80002414:	06078063          	beqz	a5,80002474 <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    80002418:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    8000241c:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80002420:	00813403          	ld	s0,8(sp)
    80002424:	01010113          	addi	sp,sp,16
    80002428:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    8000242c:	00009697          	auipc	a3,0x9
    80002430:	db468693          	addi	a3,a3,-588 # 8000b1e0 <_ZN15MemoryAllocator11freeMemTailE>
    80002434:	00f6b023          	sd	a5,0(a3)
    80002438:	00f6b423          	sd	a5,8(a3)
    8000243c:	fb5ff06f          	j	800023f0 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    80002440:	00060863          	beqz	a2,80002450 <_ZN15MemoryAllocator7kmallocEm+0x108>
    80002444:	01053783          	ld	a5,16(a0)
    80002448:	00f63823          	sd	a5,16(a2)
    8000244c:	fa5ff06f          	j	800023f0 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    80002450:	01053783          	ld	a5,16(a0)
    80002454:	00009697          	auipc	a3,0x9
    80002458:	d8f6ba23          	sd	a5,-620(a3) # 8000b1e8 <_ZN15MemoryAllocator11freeMemHeadE>
    8000245c:	f95ff06f          	j	800023f0 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    80002460:	00009797          	auipc	a5,0x9
    80002464:	d8078793          	addi	a5,a5,-640 # 8000b1e0 <_ZN15MemoryAllocator11freeMemTailE>
    80002468:	00a7b823          	sd	a0,16(a5)
    8000246c:	00a7bc23          	sd	a0,24(a5)
    80002470:	fadff06f          	j	8000241c <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    80002474:	00009797          	auipc	a5,0x9
    80002478:	d8a7b223          	sd	a0,-636(a5) # 8000b1f8 <_ZN15MemoryAllocator12allocMemHeadE>
    8000247c:	fa1ff06f          	j	8000241c <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    80002480:	00009797          	auipc	a5,0x9
    80002484:	d6078793          	addi	a5,a5,-672 # 8000b1e0 <_ZN15MemoryAllocator11freeMemTailE>
    80002488:	0107b703          	ld	a4,16(a5)
    8000248c:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80002490:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80002494:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002498:	00a7b823          	sd	a0,16(a5)
    8000249c:	f81ff06f          	j	8000241c <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    800024a0:	00000513          	li	a0,0
    800024a4:	f7dff06f          	j	80002420 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    800024a8:	00000513          	li	a0,0
    800024ac:	f75ff06f          	j	80002420 <_ZN15MemoryAllocator7kmallocEm+0xd8>

00000000800024b0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    800024b0:	ff010113          	addi	sp,sp,-16
    800024b4:	00813423          	sd	s0,8(sp)
    800024b8:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    800024bc:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800024c0:	00000713          	li	a4,0
    800024c4:	00078a63          	beqz	a5,800024d8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    800024c8:	00a7f863          	bgeu	a5,a0,800024d8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800024cc:	00078713          	mv	a4,a5
    800024d0:	0107b783          	ld	a5,16(a5)
    800024d4:	ff1ff06f          	j	800024c4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    800024d8:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    800024dc:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    800024e0:	00078463          	beqz	a5,800024e8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    800024e4:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    800024e8:	02070263          	beqz	a4,8000250c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    800024ec:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    800024f0:	0005b703          	ld	a4,0(a1)
    800024f4:	00009797          	auipc	a5,0x9
    800024f8:	cf47b783          	ld	a5,-780(a5) # 8000b1e8 <_ZN15MemoryAllocator11freeMemHeadE>
    800024fc:	00f70c63          	beq	a4,a5,80002514 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80002500:	00813403          	ld	s0,8(sp)
    80002504:	01010113          	addi	sp,sp,16
    80002508:	00008067          	ret
        *head = blk;
    8000250c:	00a5b023          	sd	a0,0(a1)
    80002510:	fe1ff06f          	j	800024f0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002514:	01053783          	ld	a5,16(a0)
    80002518:	00078a63          	beqz	a5,8000252c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    8000251c:	00053683          	ld	a3,0(a0)
    80002520:	00d50733          	add	a4,a0,a3
    80002524:	01870713          	addi	a4,a4,24
    80002528:	02f70e63          	beq	a4,a5,80002564 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    8000252c:	00853783          	ld	a5,8(a0)
    80002530:	fc0788e3          	beqz	a5,80002500 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80002534:	0007b683          	ld	a3,0(a5)
    80002538:	00d78733          	add	a4,a5,a3
    8000253c:	01870713          	addi	a4,a4,24
    80002540:	fca710e3          	bne	a4,a0,80002500 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80002544:	00053703          	ld	a4,0(a0)
    80002548:	00e68733          	add	a4,a3,a4
    8000254c:	01870713          	addi	a4,a4,24
    80002550:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80002554:	00853783          	ld	a5,8(a0)
    80002558:	01053703          	ld	a4,16(a0)
    8000255c:	00e7b823          	sd	a4,16(a5)
}
    80002560:	fa1ff06f          	j	80002500 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80002564:	0007b703          	ld	a4,0(a5)
    80002568:	00e68733          	add	a4,a3,a4
    8000256c:	01870713          	addi	a4,a4,24
    80002570:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80002574:	0107b783          	ld	a5,16(a5)
    80002578:	00f53823          	sd	a5,16(a0)
    8000257c:	fb1ff06f          	j	8000252c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080002580 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80002580:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80002584:	00009697          	auipc	a3,0x9
    80002588:	c746b683          	ld	a3,-908(a3) # 8000b1f8 <_ZN15MemoryAllocator12allocMemHeadE>
    8000258c:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002590:	00050a63          	beqz	a0,800025a4 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80002594:	fe870793          	addi	a5,a4,-24
    80002598:	00a78663          	beq	a5,a0,800025a4 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    8000259c:	01053503          	ld	a0,16(a0)
    800025a0:	ff1ff06f          	j	80002590 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    800025a4:	08050463          	beqz	a0,8000262c <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    800025a8:	ff010113          	addi	sp,sp,-16
    800025ac:	00113423          	sd	ra,8(sp)
    800025b0:	00813023          	sd	s0,0(sp)
    800025b4:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    800025b8:	00009797          	auipc	a5,0x9
    800025bc:	c387b783          	ld	a5,-968(a5) # 8000b1f0 <_ZN15MemoryAllocator12allocMemTailE>
    800025c0:	04a78663          	beq	a5,a0,8000260c <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    800025c4:	04d50c63          	beq	a0,a3,8000261c <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    800025c8:	01053783          	ld	a5,16(a0)
    800025cc:	00078663          	beqz	a5,800025d8 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    800025d0:	00853703          	ld	a4,8(a0)
    800025d4:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    800025d8:	00853783          	ld	a5,8(a0)
    800025dc:	00078663          	beqz	a5,800025e8 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    800025e0:	01053703          	ld	a4,16(a0)
    800025e4:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    800025e8:	00009597          	auipc	a1,0x9
    800025ec:	c0058593          	addi	a1,a1,-1024 # 8000b1e8 <_ZN15MemoryAllocator11freeMemHeadE>
    800025f0:	00000097          	auipc	ra,0x0
    800025f4:	ec0080e7          	jalr	-320(ra) # 800024b0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    800025f8:	00000513          	li	a0,0
}
    800025fc:	00813083          	ld	ra,8(sp)
    80002600:	00013403          	ld	s0,0(sp)
    80002604:	01010113          	addi	sp,sp,16
    80002608:	00008067          	ret
            allocMemTail = blk->prev;
    8000260c:	00853783          	ld	a5,8(a0)
    80002610:	00009717          	auipc	a4,0x9
    80002614:	bef73023          	sd	a5,-1056(a4) # 8000b1f0 <_ZN15MemoryAllocator12allocMemTailE>
    80002618:	fadff06f          	j	800025c4 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    8000261c:	01053783          	ld	a5,16(a0)
    80002620:	00009717          	auipc	a4,0x9
    80002624:	bcf73c23          	sd	a5,-1064(a4) # 8000b1f8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002628:	fa1ff06f          	j	800025c8 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    8000262c:	fff00513          	li	a0,-1
}
    80002630:	00008067          	ret

0000000080002634 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80002634:	fe010113          	addi	sp,sp,-32
    80002638:	00113c23          	sd	ra,24(sp)
    8000263c:	00813823          	sd	s0,16(sp)
    80002640:	00913423          	sd	s1,8(sp)
    80002644:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80002648:	00009497          	auipc	s1,0x9
    8000264c:	bb04b483          	ld	s1,-1104(s1) # 8000b1f8 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80002650:	00006517          	auipc	a0,0x6
    80002654:	a5050513          	addi	a0,a0,-1456 # 800080a0 <CONSOLE_STATUS+0x90>
    80002658:	0000c097          	auipc	ra,0xc
    8000265c:	670080e7          	jalr	1648(ra) # 8000ecc8 <_Z11printStringPKc>
    while(iter!=nullptr){
    80002660:	04048663          	beqz	s1,800026ac <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80002664:	00000613          	li	a2,0
    80002668:	00a00593          	li	a1,10
    8000266c:	0004851b          	sext.w	a0,s1
    80002670:	0000c097          	auipc	ra,0xc
    80002674:	7f0080e7          	jalr	2032(ra) # 8000ee60 <_Z8printIntiii>
        putc(' ');
    80002678:	02000513          	li	a0,32
    8000267c:	0000b097          	auipc	ra,0xb
    80002680:	cb0080e7          	jalr	-848(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    80002684:	00000613          	li	a2,0
    80002688:	00a00593          	li	a1,10
    8000268c:	0004a503          	lw	a0,0(s1)
    80002690:	0000c097          	auipc	ra,0xc
    80002694:	7d0080e7          	jalr	2000(ra) # 8000ee60 <_Z8printIntiii>
        putc('\n');
    80002698:	00a00513          	li	a0,10
    8000269c:	0000b097          	auipc	ra,0xb
    800026a0:	c90080e7          	jalr	-880(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    800026a4:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800026a8:	fb9ff06f          	j	80002660 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    800026ac:	00006517          	auipc	a0,0x6
    800026b0:	a1450513          	addi	a0,a0,-1516 # 800080c0 <CONSOLE_STATUS+0xb0>
    800026b4:	0000c097          	auipc	ra,0xc
    800026b8:	614080e7          	jalr	1556(ra) # 8000ecc8 <_Z11printStringPKc>
    iter = freeMemHead;
    800026bc:	00009497          	auipc	s1,0x9
    800026c0:	b2c4b483          	ld	s1,-1236(s1) # 8000b1e8 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    800026c4:	04048663          	beqz	s1,80002710 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    800026c8:	00000613          	li	a2,0
    800026cc:	00a00593          	li	a1,10
    800026d0:	0004851b          	sext.w	a0,s1
    800026d4:	0000c097          	auipc	ra,0xc
    800026d8:	78c080e7          	jalr	1932(ra) # 8000ee60 <_Z8printIntiii>
        putc(' ');
    800026dc:	02000513          	li	a0,32
    800026e0:	0000b097          	auipc	ra,0xb
    800026e4:	c4c080e7          	jalr	-948(ra) # 8000d32c <_Z4putcc>
        printInt(iter->size);
    800026e8:	00000613          	li	a2,0
    800026ec:	00a00593          	li	a1,10
    800026f0:	0004a503          	lw	a0,0(s1)
    800026f4:	0000c097          	auipc	ra,0xc
    800026f8:	76c080e7          	jalr	1900(ra) # 8000ee60 <_Z8printIntiii>
        putc('\n');
    800026fc:	00a00513          	li	a0,10
    80002700:	0000b097          	auipc	ra,0xb
    80002704:	c2c080e7          	jalr	-980(ra) # 8000d32c <_Z4putcc>
        iter=iter->next;
    80002708:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    8000270c:	fb9ff06f          	j	800026c4 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80002710:	00006517          	auipc	a0,0x6
    80002714:	9d050513          	addi	a0,a0,-1584 # 800080e0 <CONSOLE_STATUS+0xd0>
    80002718:	0000c097          	auipc	ra,0xc
    8000271c:	5b0080e7          	jalr	1456(ra) # 8000ecc8 <_Z11printStringPKc>
}
    80002720:	01813083          	ld	ra,24(sp)
    80002724:	01013403          	ld	s0,16(sp)
    80002728:	00813483          	ld	s1,8(sp)
    8000272c:	02010113          	addi	sp,sp,32
    80002730:	00008067          	ret

0000000080002734 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80002734:	ff010113          	addi	sp,sp,-16
    80002738:	00813423          	sd	s0,8(sp)
    8000273c:	01010413          	addi	s0,sp,16
    80002740:	00050813          	mv	a6,a0
    80002744:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80002748:	00000793          	li	a5,0
    8000274c:	00c7fe63          	bgeu	a5,a2,80002768 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80002750:	00f50733          	add	a4,a0,a5
    80002754:	00f806b3          	add	a3,a6,a5
    80002758:	0006c683          	lbu	a3,0(a3)
    8000275c:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80002760:	00178793          	addi	a5,a5,1
    80002764:	fe9ff06f          	j	8000274c <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80002768:	00813403          	ld	s0,8(sp)
    8000276c:	01010113          	addi	sp,sp,16
    80002770:	00008067          	ret

0000000080002774 <_ZN11ConsoleUtil10initializeEv>:
//char ConsoleUtil::inputBuffer[8192];
//char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    80002774:	fe010113          	addi	sp,sp,-32
    80002778:	00113c23          	sd	ra,24(sp)
    8000277c:	00813823          	sd	s0,16(sp)
    80002780:	00913423          	sd	s1,8(sp)
    80002784:	01213023          	sd	s2,0(sp)
    80002788:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    8000278c:	01800513          	li	a0,24
    80002790:	fffff097          	auipc	ra,0xfffff
    80002794:	130080e7          	jalr	304(ra) # 800018c0 <_ZN3SCBnwEm>
    80002798:	00050493          	mv	s1,a0
    8000279c:	00050863          	beqz	a0,800027ac <_ZN11ConsoleUtil10initializeEv+0x38>
    800027a0:	00000593          	li	a1,0
    800027a4:	fffff097          	auipc	ra,0xfffff
    800027a8:	f68080e7          	jalr	-152(ra) # 8000170c <_ZN3SCBC1Em>
    800027ac:	00009797          	auipc	a5,0x9
    800027b0:	a497be23          	sd	s1,-1444(a5) # 8000b208 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    800027b4:	01800513          	li	a0,24
    800027b8:	fffff097          	auipc	ra,0xfffff
    800027bc:	108080e7          	jalr	264(ra) # 800018c0 <_ZN3SCBnwEm>
    800027c0:	00050493          	mv	s1,a0
    800027c4:	00050863          	beqz	a0,800027d4 <_ZN11ConsoleUtil10initializeEv+0x60>
    800027c8:	00000593          	li	a1,0
    800027cc:	fffff097          	auipc	ra,0xfffff
    800027d0:	f40080e7          	jalr	-192(ra) # 8000170c <_ZN3SCBC1Em>
    800027d4:	00009917          	auipc	s2,0x9
    800027d8:	a3490913          	addi	s2,s2,-1484 # 8000b208 <_ZN11ConsoleUtil8inputSemE>
    800027dc:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    800027e0:	00008497          	auipc	s1,0x8
    800027e4:	73848493          	addi	s1,s1,1848 # 8000af18 <_ZN11ConsoleUtil10bufferSizeE>
    800027e8:	0004b503          	ld	a0,0(s1)
    800027ec:	00002097          	auipc	ra,0x2
    800027f0:	d3c080e7          	jalr	-708(ra) # 80004528 <_Z7kmallocm>
    800027f4:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    800027f8:	0004b503          	ld	a0,0(s1)
    800027fc:	00002097          	auipc	ra,0x2
    80002800:	d2c080e7          	jalr	-724(ra) # 80004528 <_Z7kmallocm>
    80002804:	00a93c23          	sd	a0,24(s2)
}
    80002808:	01813083          	ld	ra,24(sp)
    8000280c:	01013403          	ld	s0,16(sp)
    80002810:	00813483          	ld	s1,8(sp)
    80002814:	00013903          	ld	s2,0(sp)
    80002818:	02010113          	addi	sp,sp,32
    8000281c:	00008067          	ret
    80002820:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80002824:	00048513          	mv	a0,s1
    80002828:	fffff097          	auipc	ra,0xfffff
    8000282c:	0c8080e7          	jalr	200(ra) # 800018f0 <_ZN3SCBdlEPv>
    80002830:	00090513          	mv	a0,s2
    80002834:	0000a097          	auipc	ra,0xa
    80002838:	ba4080e7          	jalr	-1116(ra) # 8000c3d8 <_Unwind_Resume>
    8000283c:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80002840:	00048513          	mv	a0,s1
    80002844:	fffff097          	auipc	ra,0xfffff
    80002848:	0ac080e7          	jalr	172(ra) # 800018f0 <_ZN3SCBdlEPv>
    8000284c:	00090513          	mv	a0,s2
    80002850:	0000a097          	auipc	ra,0xa
    80002854:	b88080e7          	jalr	-1144(ra) # 8000c3d8 <_Unwind_Resume>

0000000080002858 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80002858:	00009717          	auipc	a4,0x9
    8000285c:	9b070713          	addi	a4,a4,-1616 # 8000b208 <_ZN11ConsoleUtil8inputSemE>
    80002860:	02073683          	ld	a3,32(a4)
    80002864:	00168793          	addi	a5,a3,1
    80002868:	00008617          	auipc	a2,0x8
    8000286c:	6b063603          	ld	a2,1712(a2) # 8000af18 <_ZN11ConsoleUtil10bufferSizeE>
    80002870:	02c7f7b3          	remu	a5,a5,a2
    80002874:	02873703          	ld	a4,40(a4)
    80002878:	04e78e63          	beq	a5,a4,800028d4 <_ZN11ConsoleUtil8putInputEc+0x7c>
void ConsoleUtil::putInput(char c) {
    8000287c:	ff010113          	addi	sp,sp,-16
    80002880:	00113423          	sd	ra,8(sp)
    80002884:	00813023          	sd	s0,0(sp)
    80002888:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    8000288c:	00009717          	auipc	a4,0x9
    80002890:	97c70713          	addi	a4,a4,-1668 # 8000b208 <_ZN11ConsoleUtil8inputSemE>
    80002894:	01073783          	ld	a5,16(a4)
    80002898:	00d786b3          	add	a3,a5,a3
    8000289c:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    800028a0:	02073783          	ld	a5,32(a4)
    800028a4:	00178793          	addi	a5,a5,1
    800028a8:	00008697          	auipc	a3,0x8
    800028ac:	6706b683          	ld	a3,1648(a3) # 8000af18 <_ZN11ConsoleUtil10bufferSizeE>
    800028b0:	02d7f7b3          	remu	a5,a5,a3
    800028b4:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    800028b8:	00073503          	ld	a0,0(a4)
    800028bc:	fffff097          	auipc	ra,0xfffff
    800028c0:	fc8080e7          	jalr	-56(ra) # 80001884 <_ZN3SCB6signalEv>
}
    800028c4:	00813083          	ld	ra,8(sp)
    800028c8:	00013403          	ld	s0,0(sp)
    800028cc:	01010113          	addi	sp,sp,16
    800028d0:	00008067          	ret
    800028d4:	00008067          	ret

00000000800028d8 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    800028d8:	fe010113          	addi	sp,sp,-32
    800028dc:	00113c23          	sd	ra,24(sp)
    800028e0:	00813823          	sd	s0,16(sp)
    800028e4:	00913423          	sd	s1,8(sp)
    800028e8:	02010413          	addi	s0,sp,32
    inputSem->wait();
    800028ec:	00009497          	auipc	s1,0x9
    800028f0:	91c48493          	addi	s1,s1,-1764 # 8000b208 <_ZN11ConsoleUtil8inputSemE>
    800028f4:	0004b503          	ld	a0,0(s1)
    800028f8:	fffff097          	auipc	ra,0xfffff
    800028fc:	f3c080e7          	jalr	-196(ra) # 80001834 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80002900:	0284b783          	ld	a5,40(s1)
    80002904:	0204b703          	ld	a4,32(s1)
    80002908:	02e78c63          	beq	a5,a4,80002940 <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    8000290c:	0104b703          	ld	a4,16(s1)
    80002910:	00f70733          	add	a4,a4,a5
    80002914:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80002918:	00178793          	addi	a5,a5,1
    8000291c:	00008717          	auipc	a4,0x8
    80002920:	5fc73703          	ld	a4,1532(a4) # 8000af18 <_ZN11ConsoleUtil10bufferSizeE>
    80002924:	02e7f7b3          	remu	a5,a5,a4
    80002928:	02f4b423          	sd	a5,40(s1)

    return c;
}
    8000292c:	01813083          	ld	ra,24(sp)
    80002930:	01013403          	ld	s0,16(sp)
    80002934:	00813483          	ld	s1,8(sp)
    80002938:	02010113          	addi	sp,sp,32
    8000293c:	00008067          	ret
        return -1;
    80002940:	0ff00513          	li	a0,255
    80002944:	fe9ff06f          	j	8000292c <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080002948 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80002948:	00009797          	auipc	a5,0x9
    8000294c:	8c078793          	addi	a5,a5,-1856 # 8000b208 <_ZN11ConsoleUtil8inputSemE>
    80002950:	0307b703          	ld	a4,48(a5)
    80002954:	00170713          	addi	a4,a4,1
    80002958:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    8000295c:	0387b683          	ld	a3,56(a5)
    80002960:	00168713          	addi	a4,a3,1
    80002964:	00008617          	auipc	a2,0x8
    80002968:	5b463603          	ld	a2,1460(a2) # 8000af18 <_ZN11ConsoleUtil10bufferSizeE>
    8000296c:	02c77733          	remu	a4,a4,a2
    80002970:	0407b783          	ld	a5,64(a5)
    80002974:	06f70463          	beq	a4,a5,800029dc <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    80002978:	ff010113          	addi	sp,sp,-16
    8000297c:	00113423          	sd	ra,8(sp)
    80002980:	00813023          	sd	s0,0(sp)
    80002984:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80002988:	00009797          	auipc	a5,0x9
    8000298c:	88078793          	addi	a5,a5,-1920 # 8000b208 <_ZN11ConsoleUtil8inputSemE>
    80002990:	0187b703          	ld	a4,24(a5)
    80002994:	00d706b3          	add	a3,a4,a3
    80002998:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    8000299c:	0387b703          	ld	a4,56(a5)
    800029a0:	00170713          	addi	a4,a4,1
    800029a4:	00008697          	auipc	a3,0x8
    800029a8:	5746b683          	ld	a3,1396(a3) # 8000af18 <_ZN11ConsoleUtil10bufferSizeE>
    800029ac:	02d77733          	remu	a4,a4,a3
    800029b0:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    800029b4:	0307b703          	ld	a4,48(a5)
    800029b8:	fff70713          	addi	a4,a4,-1
    800029bc:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    800029c0:	0087b503          	ld	a0,8(a5)
    800029c4:	fffff097          	auipc	ra,0xfffff
    800029c8:	ec0080e7          	jalr	-320(ra) # 80001884 <_ZN3SCB6signalEv>
}
    800029cc:	00813083          	ld	ra,8(sp)
    800029d0:	00013403          	ld	s0,0(sp)
    800029d4:	01010113          	addi	sp,sp,16
    800029d8:	00008067          	ret
    800029dc:	00008067          	ret

00000000800029e0 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    800029e0:	fe010113          	addi	sp,sp,-32
    800029e4:	00113c23          	sd	ra,24(sp)
    800029e8:	00813823          	sd	s0,16(sp)
    800029ec:	00913423          	sd	s1,8(sp)
    800029f0:	02010413          	addi	s0,sp,32
    outputSem->wait();
    800029f4:	00009497          	auipc	s1,0x9
    800029f8:	81448493          	addi	s1,s1,-2028 # 8000b208 <_ZN11ConsoleUtil8inputSemE>
    800029fc:	0084b503          	ld	a0,8(s1)
    80002a00:	fffff097          	auipc	ra,0xfffff
    80002a04:	e34080e7          	jalr	-460(ra) # 80001834 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80002a08:	0404b783          	ld	a5,64(s1)
    80002a0c:	0384b703          	ld	a4,56(s1)
    80002a10:	02e78c63          	beq	a5,a4,80002a48 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    80002a14:	0184b703          	ld	a4,24(s1)
    80002a18:	00f70733          	add	a4,a4,a5
    80002a1c:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80002a20:	00178793          	addi	a5,a5,1
    80002a24:	00008717          	auipc	a4,0x8
    80002a28:	4f473703          	ld	a4,1268(a4) # 8000af18 <_ZN11ConsoleUtil10bufferSizeE>
    80002a2c:	02e7f7b3          	remu	a5,a5,a4
    80002a30:	04f4b023          	sd	a5,64(s1)

    return c;
}
    80002a34:	01813083          	ld	ra,24(sp)
    80002a38:	01013403          	ld	s0,16(sp)
    80002a3c:	00813483          	ld	s1,8(sp)
    80002a40:	02010113          	addi	sp,sp,32
    80002a44:	00008067          	ret
        return -1;
    80002a48:	0ff00513          	li	a0,255
    80002a4c:	fe9ff06f          	j	80002a34 <_ZN11ConsoleUtil9getOutputEv+0x54>

0000000080002a50 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80002a50:	fe010113          	addi	sp,sp,-32
    80002a54:	00113c23          	sd	ra,24(sp)
    80002a58:	00813823          	sd	s0,16(sp)
    80002a5c:	00913423          	sd	s1,8(sp)
    80002a60:	02010413          	addi	s0,sp,32
    80002a64:	00050493          	mv	s1,a0
    while (*string != '\0')
    80002a68:	0004c503          	lbu	a0,0(s1)
    80002a6c:	00050a63          	beqz	a0,80002a80 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80002a70:	00000097          	auipc	ra,0x0
    80002a74:	ed8080e7          	jalr	-296(ra) # 80002948 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80002a78:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002a7c:	fedff06f          	j	80002a68 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80002a80:	01813083          	ld	ra,24(sp)
    80002a84:	01013403          	ld	s0,16(sp)
    80002a88:	00813483          	ld	s1,8(sp)
    80002a8c:	02010113          	addi	sp,sp,32
    80002a90:	00008067          	ret

0000000080002a94 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80002a94:	fb010113          	addi	sp,sp,-80
    80002a98:	04113423          	sd	ra,72(sp)
    80002a9c:	04813023          	sd	s0,64(sp)
    80002aa0:	02913c23          	sd	s1,56(sp)
    80002aa4:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80002aa8:	00005797          	auipc	a5,0x5
    80002aac:	68078793          	addi	a5,a5,1664 # 80008128 <CONSOLE_STATUS+0x118>
    80002ab0:	0007b703          	ld	a4,0(a5)
    80002ab4:	fce43423          	sd	a4,-56(s0)
    80002ab8:	0087b703          	ld	a4,8(a5)
    80002abc:	fce43823          	sd	a4,-48(s0)
    80002ac0:	0107c783          	lbu	a5,16(a5)
    80002ac4:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002ac8:	00060463          	beqz	a2,80002ad0 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80002acc:	08054263          	bltz	a0,80002b50 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002ad0:	0005051b          	sext.w	a0,a0
    neg = 0;
    80002ad4:	00000813          	li	a6,0
    }

    i = 0;
    80002ad8:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002adc:	0005871b          	sext.w	a4,a1
    80002ae0:	02b577bb          	remuw	a5,a0,a1
    80002ae4:	00048693          	mv	a3,s1
    80002ae8:	0014849b          	addiw	s1,s1,1
    80002aec:	02079793          	slli	a5,a5,0x20
    80002af0:	0207d793          	srli	a5,a5,0x20
    80002af4:	fe040613          	addi	a2,s0,-32
    80002af8:	00f607b3          	add	a5,a2,a5
    80002afc:	fe87c603          	lbu	a2,-24(a5)
    80002b00:	fe040793          	addi	a5,s0,-32
    80002b04:	00d787b3          	add	a5,a5,a3
    80002b08:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80002b0c:	0005061b          	sext.w	a2,a0
    80002b10:	02b5553b          	divuw	a0,a0,a1
    80002b14:	fce674e3          	bgeu	a2,a4,80002adc <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80002b18:	00080c63          	beqz	a6,80002b30 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80002b1c:	fe040793          	addi	a5,s0,-32
    80002b20:	009784b3          	add	s1,a5,s1
    80002b24:	02d00793          	li	a5,45
    80002b28:	fcf48c23          	sb	a5,-40(s1)
    80002b2c:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80002b30:	fff4849b          	addiw	s1,s1,-1
    80002b34:	0204c463          	bltz	s1,80002b5c <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80002b38:	fe040793          	addi	a5,s0,-32
    80002b3c:	009787b3          	add	a5,a5,s1
    80002b40:	fd87c503          	lbu	a0,-40(a5)
    80002b44:	00000097          	auipc	ra,0x0
    80002b48:	e04080e7          	jalr	-508(ra) # 80002948 <_ZN11ConsoleUtil9putOutputEc>
    80002b4c:	fe5ff06f          	j	80002b30 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80002b50:	40a0053b          	negw	a0,a0
        neg = 1;
    80002b54:	00100813          	li	a6,1
        x = -xx;
    80002b58:	f81ff06f          	j	80002ad8 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80002b5c:	04813083          	ld	ra,72(sp)
    80002b60:	04013403          	ld	s0,64(sp)
    80002b64:	03813483          	ld	s1,56(sp)
    80002b68:	05010113          	addi	sp,sp,80
    80002b6c:	00008067          	ret

0000000080002b70 <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    80002b70:	fd010113          	addi	sp,sp,-48
    80002b74:	02113423          	sd	ra,40(sp)
    80002b78:	02813023          	sd	s0,32(sp)
    80002b7c:	00913c23          	sd	s1,24(sp)
    80002b80:	01213823          	sd	s2,16(sp)
    80002b84:	01313423          	sd	s3,8(sp)
    80002b88:	03010413          	addi	s0,sp,48
    80002b8c:	00058913          	mv	s2,a1
    80002b90:	00060493          	mv	s1,a2
    80002b94:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    80002b98:	00000097          	auipc	ra,0x0
    80002b9c:	eb8080e7          	jalr	-328(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    80002ba0:	00000613          	li	a2,0
    80002ba4:	00098593          	mv	a1,s3
    80002ba8:	00090513          	mv	a0,s2
    80002bac:	00000097          	auipc	ra,0x0
    80002bb0:	ee8080e7          	jalr	-280(ra) # 80002a94 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80002bb4:	00048513          	mv	a0,s1
    80002bb8:	00000097          	auipc	ra,0x0
    80002bbc:	e98080e7          	jalr	-360(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
}
    80002bc0:	02813083          	ld	ra,40(sp)
    80002bc4:	02013403          	ld	s0,32(sp)
    80002bc8:	01813483          	ld	s1,24(sp)
    80002bcc:	01013903          	ld	s2,16(sp)
    80002bd0:	00813983          	ld	s3,8(sp)
    80002bd4:	03010113          	addi	sp,sp,48
    80002bd8:	00008067          	ret

0000000080002bdc <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80002bdc:	ff010113          	addi	sp,sp,-16
    80002be0:	00813423          	sd	s0,8(sp)
    80002be4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80002be8:	04300513          	li	a0,67

    asm("ecall");
    80002bec:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80002bf0:	00050513          	mv	a0,a0

    return (char)status;
}
    80002bf4:	0ff57513          	andi	a0,a0,255
    80002bf8:	00813403          	ld	s0,8(sp)
    80002bfc:	01010113          	addi	sp,sp,16
    80002c00:	00008067          	ret

0000000080002c04 <_ZN5RiscV16popSppSpieSystemEv>:
    RiscV::startVirtualMemory(RiscV::kPMT);
    RiscV::enableInterrupts();
}

//get previous privilege and previous interrupt status
void RiscV::popSppSpieSystem() {
    80002c04:	ff010113          	addi	sp,sp,-16
    80002c08:	00813423          	sd	s0,8(sp)
    80002c0c:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80002c10:	14109073          	csrw	sepc,ra
    asm("sret");
    80002c14:	10200073          	sret
}
    80002c18:	00813403          	ld	s0,8(sp)
    80002c1c:	01010113          	addi	sp,sp,16
    80002c20:	00008067          	ret

0000000080002c24 <_ZN5RiscV14popSppSpieUserEv>:

void RiscV::popSppSpieUser() {
    80002c24:	ff010113          	addi	sp,sp,-16
    80002c28:	00813423          	sd	s0,8(sp)
    80002c2c:	01010413          	addi	s0,sp,16
    asm("csrw sepc, %[ra]" : : [ra] "r" ((uint64)popSppSpieUserWrapper));
    80002c30:	00008797          	auipc	a5,0x8
    80002c34:	3d87b783          	ld	a5,984(a5) # 8000b008 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002c38:	14179073          	csrw	sepc,a5
    asm("mv a0, %[iarg]" : : [iarg] "r" (TCB::running->body));
    80002c3c:	00008797          	auipc	a5,0x8
    80002c40:	4047b783          	ld	a5,1028(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002c44:	0007b783          	ld	a5,0(a5)
    80002c48:	0187b703          	ld	a4,24(a5)
    80002c4c:	00070513          	mv	a0,a4
    asm("mv a1, %[iarg]" : : [iarg] "r" (TCB::running->args));
    80002c50:	0207b783          	ld	a5,32(a5)
    80002c54:	00078593          	mv	a1,a5
    asm("sret");
    80002c58:	10200073          	sret
}
    80002c5c:	00813403          	ld	s0,8(sp)
    80002c60:	01010113          	addi	sp,sp,16
    80002c64:	00008067          	ret

0000000080002c68 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80002c68:	ff010113          	addi	sp,sp,-16
    80002c6c:	00113423          	sd	ra,8(sp)
    80002c70:	00813023          	sd	s0,0(sp)
    80002c74:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80002c78:	00008797          	auipc	a5,0x8
    80002c7c:	3c87b783          	ld	a5,968(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002c80:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80002c84:	00100713          	li	a4,1
    80002c88:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002c8c:	fffff097          	auipc	ra,0xfffff
    80002c90:	438080e7          	jalr	1080(ra) # 800020c4 <_ZN3TCB8dispatchEv>
}
    80002c94:	00813083          	ld	ra,8(sp)
    80002c98:	00013403          	ld	s0,0(sp)
    80002c9c:	01010113          	addi	sp,sp,16
    80002ca0:	00008067          	ret

0000000080002ca4 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80002ca4:	ff010113          	addi	sp,sp,-16
    80002ca8:	00113423          	sd	ra,8(sp)
    80002cac:	00813023          	sd	s0,0(sp)
    80002cb0:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80002cb4:	00008797          	auipc	a5,0x8
    80002cb8:	5a47c783          	lbu	a5,1444(a5) # 8000b258 <_ZN5RiscV16userMainFinishedE>
    80002cbc:	00079c63          	bnez	a5,80002cd4 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80002cc0:	00008717          	auipc	a4,0x8
    80002cc4:	37873703          	ld	a4,888(a4) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80002cc8:	00073783          	ld	a5,0(a4)
    80002ccc:	00178793          	addi	a5,a5,1
    80002cd0:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80002cd4:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80002cd8:	0ff57513          	andi	a0,a0,255
    80002cdc:	00000097          	auipc	ra,0x0
    80002ce0:	c6c080e7          	jalr	-916(ra) # 80002948 <_ZN11ConsoleUtil9putOutputEc>
}
    80002ce4:	00813083          	ld	ra,8(sp)
    80002ce8:	00013403          	ld	s0,0(sp)
    80002cec:	01010113          	addi	sp,sp,16
    80002cf0:	00008067          	ret

0000000080002cf4 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80002cf4:	ff010113          	addi	sp,sp,-16
    80002cf8:	00813423          	sd	s0,8(sp)
    80002cfc:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80002d00:	00008797          	auipc	a5,0x8
    80002d04:	3407b783          	ld	a5,832(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002d08:	0007b783          	ld	a5,0(a5)
    80002d0c:	0147a703          	lw	a4,20(a5)
    80002d10:	00100793          	li	a5,1
    80002d14:	00f70c63          	beq	a4,a5,80002d2c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sstatus(uint64 mask) {
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80002d18:	10000793          	li	a5,256
    80002d1c:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    80002d20:	00813403          	ld	s0,8(sp)
    80002d24:	01010113          	addi	sp,sp,16
    80002d28:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80002d2c:	10000793          	li	a5,256
    80002d30:	1007a073          	csrs	sstatus,a5
}
    80002d34:	fedff06f          	j	80002d20 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080002d38 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80002d38:	ff010113          	addi	sp,sp,-16
    80002d3c:	00113423          	sd	ra,8(sp)
    80002d40:	00813023          	sd	s0,0(sp)
    80002d44:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80002d48:	00100793          	li	a5,1
    80002d4c:	00008717          	auipc	a4,0x8
    80002d50:	50f70623          	sb	a5,1292(a4) # 8000b258 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80002d54:	00008797          	auipc	a5,0x8
    80002d58:	2e47b783          	ld	a5,740(a5) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80002d5c:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80002d60:	00008797          	auipc	a5,0x8
    80002d64:	2807b783          	ld	a5,640(a5) # 8000afe0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002d68:	0007b023          	sd	zero,0(a5)
inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80002d6c:	00200793          	li	a5,2
    80002d70:	1047b073          	csrc	sie,a5
    80002d74:	20000793          	li	a5,512
    80002d78:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80002d7c:	00008797          	auipc	a5,0x8
    80002d80:	2947b783          	ld	a5,660(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002d84:	0007b783          	ld	a5,0(a5)
    80002d88:	00078c63          	beqz	a5,80002da0 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80002d8c:	0487b703          	ld	a4,72(a5)
    80002d90:	00008797          	auipc	a5,0x8
    80002d94:	2807b783          	ld	a5,640(a5) # 8000b010 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002d98:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80002d9c:	fe1ff06f          	j	80002d7c <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80002da0:	00008797          	auipc	a5,0x8
    80002da4:	2787b783          	ld	a5,632(a5) # 8000b018 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002da8:	0007b503          	ld	a0,0(a5)
    80002dac:	00001097          	auipc	ra,0x1
    80002db0:	460080e7          	jalr	1120(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002db4:	00008797          	auipc	a5,0x8
    80002db8:	2747b783          	ld	a5,628(a5) # 8000b028 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002dbc:	0007b703          	ld	a4,0(a5)
    80002dc0:	00008797          	auipc	a5,0x8
    80002dc4:	2707b783          	ld	a5,624(a5) # 8000b030 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80002dc8:	0007b783          	ld	a5,0(a5)
    80002dcc:	00f70863          	beq	a4,a5,80002ddc <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    80002dd0:	fffff097          	auipc	ra,0xfffff
    80002dd4:	2f4080e7          	jalr	756(ra) # 800020c4 <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002dd8:	fddff06f          	j	80002db4 <_ZN5RiscV8finalizeEv+0x7c>
}
    80002ddc:	00813083          	ld	ra,8(sp)
    80002de0:	00013403          	ld	s0,0(sp)
    80002de4:	01010113          	addi	sp,sp,16
    80002de8:	00008067          	ret

0000000080002dec <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80002dec:	ff010113          	addi	sp,sp,-16
    80002df0:	00813423          	sd	s0,8(sp)
    80002df4:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80002df8:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80002dfc:	00008717          	auipc	a4,0x8
    80002e00:	24473703          	ld	a4,580(a4) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002e04:	00073703          	ld	a4,0(a4)
    80002e08:	06873703          	ld	a4,104(a4)
    80002e0c:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80002e10:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80002e14:	00078593          	mv	a1,a5
}
    80002e18:	00813403          	ld	s0,8(sp)
    80002e1c:	01010113          	addi	sp,sp,16
    80002e20:	00008067          	ret

0000000080002e24 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80002e24:	ff010113          	addi	sp,sp,-16
    80002e28:	00113423          	sd	ra,8(sp)
    80002e2c:	00813023          	sd	s0,0(sp)
    80002e30:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80002e34:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80002e38:	fffff097          	auipc	ra,0xfffff
    80002e3c:	510080e7          	jalr	1296(ra) # 80002348 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80002e40:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80002e44:	00000097          	auipc	ra,0x0
    80002e48:	fa8080e7          	jalr	-88(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80002e4c:	00813083          	ld	ra,8(sp)
    80002e50:	00013403          	ld	s0,0(sp)
    80002e54:	01010113          	addi	sp,sp,16
    80002e58:	00008067          	ret

0000000080002e5c <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80002e5c:	ff010113          	addi	sp,sp,-16
    80002e60:	00113423          	sd	ra,8(sp)
    80002e64:	00813023          	sd	s0,0(sp)
    80002e68:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80002e6c:	00008797          	auipc	a5,0x8
    80002e70:	1e47b783          	ld	a5,484(a5) # 8000b050 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80002e74:	0007c783          	lbu	a5,0(a5)
    80002e78:	02079263          	bnez	a5,80002e9c <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80002e7c:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002e80:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80002e84:	00000097          	auipc	ra,0x0
    80002e88:	f68080e7          	jalr	-152(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80002e8c:	00813083          	ld	ra,8(sp)
    80002e90:	00013403          	ld	s0,0(sp)
    80002e94:	01010113          	addi	sp,sp,16
    80002e98:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80002e9c:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80002ea0:	fffff097          	auipc	ra,0xfffff
    80002ea4:	6e0080e7          	jalr	1760(ra) # 80002580 <_ZN15MemoryAllocator5kfreeEPv>
    80002ea8:	fd9ff06f          	j	80002e80 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080002eac <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80002eac:	fc010113          	addi	sp,sp,-64
    80002eb0:	02113c23          	sd	ra,56(sp)
    80002eb4:	02813823          	sd	s0,48(sp)
    80002eb8:	02913423          	sd	s1,40(sp)
    80002ebc:	03213023          	sd	s2,32(sp)
    80002ec0:	01313c23          	sd	s3,24(sp)
    80002ec4:	01413823          	sd	s4,16(sp)
    80002ec8:	01513423          	sd	s5,8(sp)
    80002ecc:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80002ed0:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80002ed4:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80002ed8:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80002edc:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002ee0:	07000513          	li	a0,112
    80002ee4:	fffff097          	auipc	ra,0xfffff
    80002ee8:	260080e7          	jalr	608(ra) # 80002144 <_ZN3TCBnwEm>
    80002eec:	00050493          	mv	s1,a0
    80002ef0:	00050e63          	beqz	a0,80002f0c <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    80002ef4:	00200713          	li	a4,2
    80002ef8:	000a8693          	mv	a3,s5
    80002efc:	000a0613          	mv	a2,s4
    80002f00:	00098593          	mv	a1,s3
    80002f04:	fffff097          	auipc	ra,0xfffff
    80002f08:	104080e7          	jalr	260(ra) # 80002008 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80002f0c:	04048863          	beqz	s1,80002f5c <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    80002f10:	0184b783          	ld	a5,24(s1)
    80002f14:	00078863          	beqz	a5,80002f24 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    80002f18:	00048513          	mv	a0,s1
    80002f1c:	00001097          	auipc	ra,0x1
    80002f20:	2f0080e7          	jalr	752(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80002f24:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80002f28:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002f2c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80002f30:	00000097          	auipc	ra,0x0
    80002f34:	ebc080e7          	jalr	-324(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80002f38:	03813083          	ld	ra,56(sp)
    80002f3c:	03013403          	ld	s0,48(sp)
    80002f40:	02813483          	ld	s1,40(sp)
    80002f44:	02013903          	ld	s2,32(sp)
    80002f48:	01813983          	ld	s3,24(sp)
    80002f4c:	01013a03          	ld	s4,16(sp)
    80002f50:	00813a83          	ld	s5,8(sp)
    80002f54:	04010113          	addi	sp,sp,64
    80002f58:	00008067          	ret
        status = -1;
    80002f5c:	fff00793          	li	a5,-1
    80002f60:	fcdff06f          	j	80002f2c <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    80002f64:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002f68:	00048513          	mv	a0,s1
    80002f6c:	fffff097          	auipc	ra,0xfffff
    80002f70:	2fc080e7          	jalr	764(ra) # 80002268 <_ZN3TCBdlEPv>
    80002f74:	00090513          	mv	a0,s2
    80002f78:	00009097          	auipc	ra,0x9
    80002f7c:	460080e7          	jalr	1120(ra) # 8000c3d8 <_Unwind_Resume>

0000000080002f80 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80002f80:	fc010113          	addi	sp,sp,-64
    80002f84:	02113c23          	sd	ra,56(sp)
    80002f88:	02813823          	sd	s0,48(sp)
    80002f8c:	02913423          	sd	s1,40(sp)
    80002f90:	03213023          	sd	s2,32(sp)
    80002f94:	01313c23          	sd	s3,24(sp)
    80002f98:	01413823          	sd	s4,16(sp)
    80002f9c:	01513423          	sd	s5,8(sp)
    80002fa0:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80002fa4:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80002fa8:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80002fac:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80002fb0:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80002fb4:	07000513          	li	a0,112
    80002fb8:	fffff097          	auipc	ra,0xfffff
    80002fbc:	18c080e7          	jalr	396(ra) # 80002144 <_ZN3TCBnwEm>
    80002fc0:	00050493          	mv	s1,a0
    80002fc4:	00050e63          	beqz	a0,80002fe0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80002fc8:	00200713          	li	a4,2
    80002fcc:	000a8693          	mv	a3,s5
    80002fd0:	00090613          	mv	a2,s2
    80002fd4:	00098593          	mv	a1,s3
    80002fd8:	fffff097          	auipc	ra,0xfffff
    80002fdc:	030080e7          	jalr	48(ra) # 80002008 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80002fe0:	04048263          	beqz	s1,80003024 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    80002fe4:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    80002fe8:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80002fec:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    80002ff0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002ff4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80002ff8:	00000097          	auipc	ra,0x0
    80002ffc:	df4080e7          	jalr	-524(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80003000:	03813083          	ld	ra,56(sp)
    80003004:	03013403          	ld	s0,48(sp)
    80003008:	02813483          	ld	s1,40(sp)
    8000300c:	02013903          	ld	s2,32(sp)
    80003010:	01813983          	ld	s3,24(sp)
    80003014:	01013a03          	ld	s4,16(sp)
    80003018:	00813a83          	ld	s5,8(sp)
    8000301c:	04010113          	addi	sp,sp,64
    80003020:	00008067          	ret
        status = -1;
    80003024:	fff00793          	li	a5,-1
    80003028:	fcdff06f          	j	80002ff4 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    8000302c:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003030:	00048513          	mv	a0,s1
    80003034:	fffff097          	auipc	ra,0xfffff
    80003038:	234080e7          	jalr	564(ra) # 80002268 <_ZN3TCBdlEPv>
    8000303c:	00090513          	mv	a0,s2
    80003040:	00009097          	auipc	ra,0x9
    80003044:	398080e7          	jalr	920(ra) # 8000c3d8 <_Unwind_Resume>

0000000080003048 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003048:	ff010113          	addi	sp,sp,-16
    8000304c:	00113423          	sd	ra,8(sp)
    80003050:	00813023          	sd	s0,0(sp)
    80003054:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003058:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    8000305c:	02051263          	bnez	a0,80003080 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003060:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003064:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003068:	00000097          	auipc	ra,0x0
    8000306c:	d84080e7          	jalr	-636(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80003070:	00813083          	ld	ra,8(sp)
    80003074:	00013403          	ld	s0,0(sp)
    80003078:	01010113          	addi	sp,sp,16
    8000307c:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003080:	00100793          	li	a5,1
    80003084:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003088:	00001097          	auipc	ra,0x1
    8000308c:	184080e7          	jalr	388(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003090:	fffff097          	auipc	ra,0xfffff
    80003094:	034080e7          	jalr	52(ra) # 800020c4 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003098:	00000793          	li	a5,0
    8000309c:	fc9ff06f          	j	80003064 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

00000000800030a0 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    800030a0:	ff010113          	addi	sp,sp,-16
    800030a4:	00113423          	sd	ra,8(sp)
    800030a8:	00813023          	sd	s0,0(sp)
    800030ac:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    800030b0:	00008797          	auipc	a5,0x8
    800030b4:	f907b783          	ld	a5,-112(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800030b8:	0007b783          	ld	a5,0(a5)
    800030bc:	02078a63          	beqz	a5,800030f0 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    800030c0:	00200713          	li	a4,2
    800030c4:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    800030c8:	fffff097          	auipc	ra,0xfffff
    800030cc:	ffc080e7          	jalr	-4(ra) # 800020c4 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    800030d0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800030d4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800030d8:	00000097          	auipc	ra,0x0
    800030dc:	d14080e7          	jalr	-748(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    800030e0:	00813083          	ld	ra,8(sp)
    800030e4:	00013403          	ld	s0,0(sp)
    800030e8:	01010113          	addi	sp,sp,16
    800030ec:	00008067          	ret
        status = -1;
    800030f0:	fff00793          	li	a5,-1
    800030f4:	fe1ff06f          	j	800030d4 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

00000000800030f8 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    800030f8:	fd010113          	addi	sp,sp,-48
    800030fc:	02113423          	sd	ra,40(sp)
    80003100:	02813023          	sd	s0,32(sp)
    80003104:	00913c23          	sd	s1,24(sp)
    80003108:	01213823          	sd	s2,16(sp)
    8000310c:	01313423          	sd	s3,8(sp)
    80003110:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003114:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003118:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    8000311c:	01800513          	li	a0,24
    80003120:	ffffe097          	auipc	ra,0xffffe
    80003124:	7a0080e7          	jalr	1952(ra) # 800018c0 <_ZN3SCBnwEm>
    80003128:	00050493          	mv	s1,a0
    8000312c:	00050863          	beqz	a0,8000313c <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    80003130:	00098593          	mv	a1,s3
    80003134:	ffffe097          	auipc	ra,0xffffe
    80003138:	5d8080e7          	jalr	1496(ra) # 8000170c <_ZN3SCBC1Em>
    if(scb == nullptr){
    8000313c:	02048a63          	beqz	s1,80003170 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    80003140:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80003144:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003148:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000314c:	00000097          	auipc	ra,0x0
    80003150:	ca0080e7          	jalr	-864(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80003154:	02813083          	ld	ra,40(sp)
    80003158:	02013403          	ld	s0,32(sp)
    8000315c:	01813483          	ld	s1,24(sp)
    80003160:	01013903          	ld	s2,16(sp)
    80003164:	00813983          	ld	s3,8(sp)
    80003168:	03010113          	addi	sp,sp,48
    8000316c:	00008067          	ret
        status = -1;
    80003170:	fff00793          	li	a5,-1
    80003174:	fd5ff06f          	j	80003148 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    80003178:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    8000317c:	00048513          	mv	a0,s1
    80003180:	ffffe097          	auipc	ra,0xffffe
    80003184:	770080e7          	jalr	1904(ra) # 800018f0 <_ZN3SCBdlEPv>
    80003188:	00090513          	mv	a0,s2
    8000318c:	00009097          	auipc	ra,0x9
    80003190:	24c080e7          	jalr	588(ra) # 8000c3d8 <_Unwind_Resume>

0000000080003194 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003194:	fe010113          	addi	sp,sp,-32
    80003198:	00113c23          	sd	ra,24(sp)
    8000319c:	00813823          	sd	s0,16(sp)
    800031a0:	00913423          	sd	s1,8(sp)
    800031a4:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800031a8:	00058493          	mv	s1,a1
    if(scb == nullptr){
    800031ac:	02049463          	bnez	s1,800031d4 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    800031b0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800031b4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800031b8:	00000097          	auipc	ra,0x0
    800031bc:	c34080e7          	jalr	-972(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    800031c0:	01813083          	ld	ra,24(sp)
    800031c4:	01013403          	ld	s0,16(sp)
    800031c8:	00813483          	ld	s1,8(sp)
    800031cc:	02010113          	addi	sp,sp,32
    800031d0:	00008067          	ret
        delete (SCB*)ihandle;
    800031d4:	00048513          	mv	a0,s1
    800031d8:	ffffe097          	auipc	ra,0xffffe
    800031dc:	550080e7          	jalr	1360(ra) # 80001728 <_ZN3SCBD1Ev>
    800031e0:	00048513          	mv	a0,s1
    800031e4:	ffffe097          	auipc	ra,0xffffe
    800031e8:	70c080e7          	jalr	1804(ra) # 800018f0 <_ZN3SCBdlEPv>
    uint64 status = 0;
    800031ec:	00000793          	li	a5,0
    800031f0:	fc5ff06f          	j	800031b4 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

00000000800031f4 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    800031f4:	ff010113          	addi	sp,sp,-16
    800031f8:	00113423          	sd	ra,8(sp)
    800031fc:	00813023          	sd	s0,0(sp)
    80003200:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003204:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003208:	02051c63          	bnez	a0,80003240 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    8000320c:	00008797          	auipc	a5,0x8
    80003210:	e347b783          	ld	a5,-460(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003214:	0007b783          	ld	a5,0(a5)
    80003218:	0607b783          	ld	a5,96(a5)
    8000321c:	02078863          	beqz	a5,8000324c <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003220:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003224:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003228:	00000097          	auipc	ra,0x0
    8000322c:	bc4080e7          	jalr	-1084(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80003230:	00813083          	ld	ra,8(sp)
    80003234:	00013403          	ld	s0,0(sp)
    80003238:	01010113          	addi	sp,sp,16
    8000323c:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003240:	ffffe097          	auipc	ra,0xffffe
    80003244:	5f4080e7          	jalr	1524(ra) # 80001834 <_ZN3SCB4waitEv>
    80003248:	fc5ff06f          	j	8000320c <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    8000324c:	00000793          	li	a5,0
    80003250:	fd5ff06f          	j	80003224 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003254 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003254:	ff010113          	addi	sp,sp,-16
    80003258:	00113423          	sd	ra,8(sp)
    8000325c:	00813023          	sd	s0,0(sp)
    80003260:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003264:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003268:	02051263          	bnez	a0,8000328c <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    8000326c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003270:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003274:	00000097          	auipc	ra,0x0
    80003278:	b78080e7          	jalr	-1160(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    8000327c:	00813083          	ld	ra,8(sp)
    80003280:	00013403          	ld	s0,0(sp)
    80003284:	01010113          	addi	sp,sp,16
    80003288:	00008067          	ret
        ((SCB*)ihandle)->signal();
    8000328c:	ffffe097          	auipc	ra,0xffffe
    80003290:	5f8080e7          	jalr	1528(ra) # 80001884 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003294:	00000793          	li	a5,0
    80003298:	fd9ff06f          	j	80003270 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

000000008000329c <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    8000329c:	fe010113          	addi	sp,sp,-32
    800032a0:	00113c23          	sd	ra,24(sp)
    800032a4:	00813823          	sd	s0,16(sp)
    800032a8:	00913423          	sd	s1,8(sp)
    800032ac:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    800032b0:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    800032b4:	00008797          	auipc	a5,0x8
    800032b8:	d8c7b783          	ld	a5,-628(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800032bc:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    800032c0:	00008797          	auipc	a5,0x8
    800032c4:	fa07b783          	ld	a5,-96(a5) # 8000b260 <_ZN5RiscV10globalTimeE>
    800032c8:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    800032cc:	00e787b3          	add	a5,a5,a4
    800032d0:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    800032d4:	00048513          	mv	a0,s1
    800032d8:	00001097          	auipc	ra,0x1
    800032dc:	fb0080e7          	jalr	-80(ra) # 80004288 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    800032e0:	00300793          	li	a5,3
    800032e4:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    800032e8:	fffff097          	auipc	ra,0xfffff
    800032ec:	ddc080e7          	jalr	-548(ra) # 800020c4 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    800032f0:	00000793          	li	a5,0
    800032f4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800032f8:	00000097          	auipc	ra,0x0
    800032fc:	af4080e7          	jalr	-1292(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80003300:	01813083          	ld	ra,24(sp)
    80003304:	01013403          	ld	s0,16(sp)
    80003308:	00813483          	ld	s1,8(sp)
    8000330c:	02010113          	addi	sp,sp,32
    80003310:	00008067          	ret

0000000080003314 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003314:	fe010113          	addi	sp,sp,-32
    80003318:	00113c23          	sd	ra,24(sp)
    8000331c:	00813823          	sd	s0,16(sp)
    80003320:	00913423          	sd	s1,8(sp)
    80003324:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003328:	00008797          	auipc	a5,0x8
    8000332c:	f307c783          	lbu	a5,-208(a5) # 8000b258 <_ZN5RiscV16userMainFinishedE>
    80003330:	00079c63          	bnez	a5,80003348 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003334:	00008717          	auipc	a4,0x8
    80003338:	cac73703          	ld	a4,-852(a4) # 8000afe0 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000333c:	00073783          	ld	a5,0(a4)
    80003340:	00178793          	addi	a5,a5,1
    80003344:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003348:	fffff097          	auipc	ra,0xfffff
    8000334c:	590080e7          	jalr	1424(ra) # 800028d8 <_ZN11ConsoleUtil8getInputEv>
    80003350:	00050493          	mv	s1,a0
    if(c==13) {
    80003354:	00d00793          	li	a5,13
    80003358:	02f50663          	beq	a0,a5,80003384 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    8000335c:	01b00793          	li	a5,27
    80003360:	04f51063          	bne	a0,a5,800033a0 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003364:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003368:	00000097          	auipc	ra,0x0
    8000336c:	a84080e7          	jalr	-1404(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80003370:	01813083          	ld	ra,24(sp)
    80003374:	01013403          	ld	s0,16(sp)
    80003378:	00813483          	ld	s1,8(sp)
    8000337c:	02010113          	addi	sp,sp,32
    80003380:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003384:	00d00513          	li	a0,13
    80003388:	fffff097          	auipc	ra,0xfffff
    8000338c:	5c0080e7          	jalr	1472(ra) # 80002948 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003390:	00a00513          	li	a0,10
    80003394:	fffff097          	auipc	ra,0xfffff
    80003398:	5b4080e7          	jalr	1460(ra) # 80002948 <_ZN11ConsoleUtil9putOutputEc>
    8000339c:	fc9ff06f          	j	80003364 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    800033a0:	fffff097          	auipc	ra,0xfffff
    800033a4:	5a8080e7          	jalr	1448(ra) # 80002948 <_ZN11ConsoleUtil9putOutputEc>
    800033a8:	fbdff06f          	j	80003364 <_ZN5RiscV18executeGetcSyscallEv+0x50>

00000000800033ac <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    800033ac:	ff010113          	addi	sp,sp,-16
    800033b0:	00113423          	sd	ra,8(sp)
    800033b4:	00813023          	sd	s0,0(sp)
    800033b8:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    800033bc:	fffff097          	auipc	ra,0xfffff
    800033c0:	624080e7          	jalr	1572(ra) # 800029e0 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    800033c4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800033c8:	00000097          	auipc	ra,0x0
    800033cc:	a24080e7          	jalr	-1500(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    800033d0:	00813083          	ld	ra,8(sp)
    800033d4:	00013403          	ld	s0,0(sp)
    800033d8:	01010113          	addi	sp,sp,16
    800033dc:	00008067          	ret

00000000800033e0 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    800033e0:	fe010113          	addi	sp,sp,-32
    800033e4:	00113c23          	sd	ra,24(sp)
    800033e8:	00813823          	sd	s0,16(sp)
    800033ec:	00913423          	sd	s1,8(sp)
    800033f0:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800033f4:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    800033f8:	02049463          	bnez	s1,80003420 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800033fc:	fff00793          	li	a5,-1
    80003400:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003404:	00000097          	auipc	ra,0x0
    80003408:	9e8080e7          	jalr	-1560(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    8000340c:	01813083          	ld	ra,24(sp)
    80003410:	01013403          	ld	s0,16(sp)
    80003414:	00813483          	ld	s1,8(sp)
    80003418:	02010113          	addi	sp,sp,32
    8000341c:	00008067          	ret
        kfree(thr->stack);
    80003420:	0284b503          	ld	a0,40(s1)
    80003424:	00001097          	auipc	ra,0x1
    80003428:	12c080e7          	jalr	300(ra) # 80004550 <_Z5kfreePKv>
        delete thr;
    8000342c:	00048513          	mv	a0,s1
    80003430:	fffff097          	auipc	ra,0xfffff
    80003434:	c6c080e7          	jalr	-916(ra) # 8000209c <_ZN3TCBD1Ev>
    80003438:	00048513          	mv	a0,s1
    8000343c:	fffff097          	auipc	ra,0xfffff
    80003440:	e2c080e7          	jalr	-468(ra) # 80002268 <_ZN3TCBdlEPv>
    80003444:	fb9ff06f          	j	800033fc <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080003448 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003448:	fe010113          	addi	sp,sp,-32
    8000344c:	00113c23          	sd	ra,24(sp)
    80003450:	00813823          	sd	s0,16(sp)
    80003454:	00913423          	sd	s1,8(sp)
    80003458:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000345c:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003460:	02049463          	bnez	s1,80003488 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003464:	fff00793          	li	a5,-1
    80003468:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    8000346c:	00000097          	auipc	ra,0x0
    80003470:	980080e7          	jalr	-1664(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80003474:	01813083          	ld	ra,24(sp)
    80003478:	01013403          	ld	s0,16(sp)
    8000347c:	00813483          	ld	s1,8(sp)
    80003480:	02010113          	addi	sp,sp,32
    80003484:	00008067          	ret
        delete scb;
    80003488:	00048513          	mv	a0,s1
    8000348c:	ffffe097          	auipc	ra,0xffffe
    80003490:	29c080e7          	jalr	668(ra) # 80001728 <_ZN3SCBD1Ev>
    80003494:	00048513          	mv	a0,s1
    80003498:	ffffe097          	auipc	ra,0xffffe
    8000349c:	458080e7          	jalr	1112(ra) # 800018f0 <_ZN3SCBdlEPv>
    800034a0:	fc5ff06f          	j	80003464 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

00000000800034a4 <_ZN5RiscV5getPCEv>:

    RiscV::saveA0toSscratch();

}

void RiscV::getPC(){
    800034a4:	ff010113          	addi	sp,sp,-16
    800034a8:	00813423          	sd	s0,8(sp)
    800034ac:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    800034b0:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    800034b4:	00878793          	addi	a5,a5,8
    800034b8:	00008717          	auipc	a4,0x8
    800034bc:	b4873703          	ld	a4,-1208(a4) # 8000b000 <_GLOBAL_OFFSET_TABLE_+0x78>
    800034c0:	00f73023          	sd	a5,0(a4)
}
    800034c4:	00813403          	ld	s0,8(sp)
    800034c8:	01010113          	addi	sp,sp,16
    800034cc:	00008067          	ret

00000000800034d0 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    800034d0:	fd010113          	addi	sp,sp,-48
    800034d4:	02113423          	sd	ra,40(sp)
    800034d8:	02813023          	sd	s0,32(sp)
    800034dc:	00913c23          	sd	s1,24(sp)
    800034e0:	01213823          	sd	s2,16(sp)
    800034e4:	01313423          	sd	s3,8(sp)
    800034e8:	03010413          	addi	s0,sp,48
    800034ec:	00050913          	mv	s2,a0
    800034f0:	00058493          	mv	s1,a1
    800034f4:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    800034f8:	00058e63          	beqz	a1,80003514 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    800034fc:	04000513          	li	a0,64
    80003500:	fffff097          	auipc	ra,0xfffff
    80003504:	e48080e7          	jalr	-440(ra) # 80002348 <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    80003508:	00051863          	bnez	a0,80003518 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    8000350c:	00093023          	sd	zero,0(s2)
            return;
    80003510:	0200006f          	j	80003530 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    80003514:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80003518:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    8000351c:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80003520:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80003524:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80003528:	01100513          	li	a0,17

    asm("ecall");
    8000352c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    80003530:	02813083          	ld	ra,40(sp)
    80003534:	02013403          	ld	s0,32(sp)
    80003538:	01813483          	ld	s1,24(sp)
    8000353c:	01013903          	ld	s2,16(sp)
    80003540:	00813983          	ld	s3,8(sp)
    80003544:	03010113          	addi	sp,sp,48
    80003548:	00008067          	ret

000000008000354c <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    8000354c:	ff010113          	addi	sp,sp,-16
    80003550:	00813423          	sd	s0,8(sp)
    80003554:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80003558:	01200513          	li	a0,18

    asm("ecall");
    8000355c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    80003560:	00813403          	ld	s0,8(sp)
    80003564:	01010113          	addi	sp,sp,16
    80003568:	00008067          	ret

000000008000356c <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    8000356c:	ff010113          	addi	sp,sp,-16
    80003570:	00813423          	sd	s0,8(sp)
    80003574:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80003578:	01300513          	li	a0,19

    asm("ecall");
    8000357c:	00000073          	ecall
}
    80003580:	00813403          	ld	s0,8(sp)
    80003584:	01010113          	addi	sp,sp,16
    80003588:	00008067          	ret

000000008000358c <_ZN5RiscV11putcWrapperEPv>:
{
    8000358c:	fe010113          	addi	sp,sp,-32
    80003590:	00113c23          	sd	ra,24(sp)
    80003594:	00813823          	sd	s0,16(sp)
    80003598:	02010413          	addi	s0,sp,32
    8000359c:	00c0006f          	j	800035a8 <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    800035a0:	00000097          	auipc	ra,0x0
    800035a4:	fcc080e7          	jalr	-52(ra) # 8000356c <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    800035a8:	00008797          	auipc	a5,0x8
    800035ac:	9f07b783          	ld	a5,-1552(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0x10>
    800035b0:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800035b4:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800035b8:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800035bc:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    800035c0:	0207f793          	andi	a5,a5,32
    800035c4:	fc078ee3          	beqz	a5,800035a0 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    800035c8:	fffff097          	auipc	ra,0xfffff
    800035cc:	614080e7          	jalr	1556(ra) # 80002bdc <_ZN11ConsoleUtil15putcUtilSyscallEv>
    800035d0:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    800035d4:	00008797          	auipc	a5,0x8
    800035d8:	9bc7b783          	ld	a5,-1604(a5) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0x8>
    800035dc:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    800035e0:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    800035e4:	fef44783          	lbu	a5,-17(s0)
    800035e8:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    800035ec:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    800035f0:	00008797          	auipc	a5,0x8
    800035f4:	a487b783          	ld	a5,-1464(a5) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800035f8:	0007b783          	ld	a5,0(a5)
    800035fc:	fa0786e3          	beqz	a5,800035a8 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003600:	fff78793          	addi	a5,a5,-1
    80003604:	00008717          	auipc	a4,0x8
    80003608:	a3473703          	ld	a4,-1484(a4) # 8000b038 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000360c:	00f73023          	sd	a5,0(a4)
    80003610:	f99ff06f          	j	800035a8 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003614 <_ZN5RiscV6getPMTEv>:

    RiscV::mapConsoleRegisters(uPMT);
    RiscV::ms_sstatus(1<<18);
}

void* RiscV::getPMT(){
    80003614:	ff010113          	addi	sp,sp,-16
    80003618:	00113423          	sd	ra,8(sp)
    8000361c:	00813023          	sd	s0,0(sp)
    80003620:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(0);
    80003624:	00000513          	li	a0,0
    80003628:	ffffe097          	auipc	ra,0xffffe
    8000362c:	758080e7          	jalr	1880(ra) # 80001d80 <_ZN5Buddy5allocEm>
    if(!ret)
    80003630:	02050263          	beqz	a0,80003654 <_ZN5RiscV6getPMTEv+0x40>
        return nullptr;
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80003634:	00000793          	li	a5,0
    80003638:	1ff00713          	li	a4,511
    8000363c:	00f74c63          	blt	a4,a5,80003654 <_ZN5RiscV6getPMTEv+0x40>
        arr[i] = 0;
    80003640:	00379713          	slli	a4,a5,0x3
    80003644:	00e50733          	add	a4,a0,a4
    80003648:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    8000364c:	0017879b          	addiw	a5,a5,1
    80003650:	fe9ff06f          	j	80003638 <_ZN5RiscV6getPMTEv+0x24>
    return ret;
}
    80003654:	00813083          	ld	ra,8(sp)
    80003658:	00013403          	ld	s0,0(sp)
    8000365c:	01010113          	addi	sp,sp,16
    80003660:	00008067          	ret

0000000080003664 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    80003664:	fd010113          	addi	sp,sp,-48
    80003668:	02113423          	sd	ra,40(sp)
    8000366c:	02813023          	sd	s0,32(sp)
    80003670:	00913c23          	sd	s1,24(sp)
    80003674:	01213823          	sd	s2,16(sp)
    80003678:	01313423          	sd	s3,8(sp)
    8000367c:	03010413          	addi	s0,sp,48
    80003680:	00058493          	mv	s1,a1
    80003684:	00060993          	mv	s3,a2
    uint64 satp = 0;
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
}

inline uint64 RiscV::getPMT2Entry(uint64 addr) {
    return (addr >> 30) & (0x1ff);
    80003688:	01e5d793          	srli	a5,a1,0x1e
    8000368c:	1ff7f793          	andi	a5,a5,511
    uint64 pmt2Desc = ((uint64*)PMT)[RiscV::getPMT2Entry(addr)];
    80003690:	00379793          	slli	a5,a5,0x3
    80003694:	00f50933          	add	s2,a0,a5
    80003698:	00093783          	ld	a5,0(s2)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    8000369c:	06078263          	beqz	a5,80003700 <_ZN5RiscV15handlePageFaultEPvmm+0x9c>
            return;
        uint64 frame = (uint64)pmt1 >> 12;
        ((uint64*)PMT)[RiscV::getPMT2Entry(addr)] = (frame << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    800036a0:	00a7d513          	srli	a0,a5,0xa
    800036a4:	00c51513          	slli	a0,a0,0xc
}

inline uint64 RiscV::getPMT1Entry(uint64 addr) {
    return (addr >> 21) & (0x1ff);
    800036a8:	0154d913          	srli	s2,s1,0x15
    800036ac:	1ff97913          	andi	s2,s2,511
    uint64 pmt1Desc = ((uint64*)pmt1)[RiscV::getPMT1Entry(addr)];
    800036b0:	00391913          	slli	s2,s2,0x3
    800036b4:	01250933          	add	s2,a0,s2
    800036b8:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    800036bc:	06050263          	beqz	a0,80003720 <_ZN5RiscV15handlePageFaultEPvmm+0xbc>
            return;
        uint64 frame = (uint64)pmt0 >> 12;
        ((uint64*)pmt1)[RiscV::getPMT1Entry(addr)] = (frame << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    800036c0:	00a55513          	srli	a0,a0,0xa
    800036c4:	00c51513          	slli	a0,a0,0xc
    uint64 frame = addr >> 12;
    800036c8:	00c4d493          	srli	s1,s1,0xc
    ((uint64 *) pmt0)[RiscV::getPMT0Entry(addr)] = (frame << 10) | mask;
    800036cc:	00a49613          	slli	a2,s1,0xa
}

inline uint64 RiscV::getPMT0Entry(uint64 addr) {
    return (addr >> 12) & (0x1ff);
    800036d0:	1ff4f493          	andi	s1,s1,511
    800036d4:	00349493          	slli	s1,s1,0x3
    800036d8:	009504b3          	add	s1,a0,s1
    800036dc:	013669b3          	or	s3,a2,s3
    800036e0:	0134b023          	sd	s3,0(s1)
}
    800036e4:	02813083          	ld	ra,40(sp)
    800036e8:	02013403          	ld	s0,32(sp)
    800036ec:	01813483          	ld	s1,24(sp)
    800036f0:	01013903          	ld	s2,16(sp)
    800036f4:	00813983          	ld	s3,8(sp)
    800036f8:	03010113          	addi	sp,sp,48
    800036fc:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80003700:	00000097          	auipc	ra,0x0
    80003704:	f14080e7          	jalr	-236(ra) # 80003614 <_ZN5RiscV6getPMTEv>
        if(pmt1 == nullptr)
    80003708:	fc050ee3          	beqz	a0,800036e4 <_ZN5RiscV15handlePageFaultEPvmm+0x80>
        uint64 frame = (uint64)pmt1 >> 12;
    8000370c:	00c55793          	srli	a5,a0,0xc
        ((uint64*)PMT)[RiscV::getPMT2Entry(addr)] = (frame << 10) | (uint64)1;
    80003710:	00a79793          	slli	a5,a5,0xa
    80003714:	0017e793          	ori	a5,a5,1
    80003718:	00f93023          	sd	a5,0(s2)
    8000371c:	f8dff06f          	j	800036a8 <_ZN5RiscV15handlePageFaultEPvmm+0x44>
        pmt0 = RiscV::getPMT();
    80003720:	00000097          	auipc	ra,0x0
    80003724:	ef4080e7          	jalr	-268(ra) # 80003614 <_ZN5RiscV6getPMTEv>
        if(pmt0 == nullptr)
    80003728:	fa050ee3          	beqz	a0,800036e4 <_ZN5RiscV15handlePageFaultEPvmm+0x80>
        uint64 frame = (uint64)pmt0 >> 12;
    8000372c:	00c55793          	srli	a5,a0,0xc
        ((uint64*)pmt1)[RiscV::getPMT1Entry(addr)] = (frame << 10) | (uint64)1;
    80003730:	00a79793          	slli	a5,a5,0xa
    80003734:	0017e793          	ori	a5,a5,1
    80003738:	00f93023          	sd	a5,0(s2)
    8000373c:	f8dff06f          	j	800036c8 <_ZN5RiscV15handlePageFaultEPvmm+0x64>

0000000080003740 <_ZN5RiscV18executeForkSyscallEv>:
void RiscV::executeForkSyscall() {
    80003740:	fe010113          	addi	sp,sp,-32
    80003744:	00113c23          	sd	ra,24(sp)
    80003748:	00813823          	sd	s0,16(sp)
    8000374c:	00913423          	sd	s1,8(sp)
    80003750:	01213023          	sd	s2,0(sp)
    80003754:	02010413          	addi	s0,sp,32
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003758:	04000513          	li	a0,64
    8000375c:	fffff097          	auipc	ra,0xfffff
    80003760:	bec080e7          	jalr	-1044(ra) # 80002348 <_ZN15MemoryAllocator7kmallocEm>
    80003764:	00050913          	mv	s2,a0
    handlePageFault(kPMT, (uint64)stack, 0x17);
    80003768:	01700613          	li	a2,23
    8000376c:	00050593          	mv	a1,a0
    80003770:	00008517          	auipc	a0,0x8
    80003774:	af853503          	ld	a0,-1288(a0) # 8000b268 <_ZN5RiscV4kPMTE>
    80003778:	00000097          	auipc	ra,0x0
    8000377c:	eec080e7          	jalr	-276(ra) # 80003664 <_ZN5RiscV15handlePageFaultEPvmm>
    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003780:	00008797          	auipc	a5,0x8
    80003784:	8c07b783          	ld	a5,-1856(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003788:	0007b783          	ld	a5,0(a5)
    8000378c:	00001637          	lui	a2,0x1
    80003790:	00090593          	mv	a1,s2
    80003794:	0287b503          	ld	a0,40(a5)
    80003798:	fffff097          	auipc	ra,0xfffff
    8000379c:	f9c080e7          	jalr	-100(ra) # 80002734 <_ZN15MemoryAllocator6memcpyEPvS0_m>
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    800037a0:	07000513          	li	a0,112
    800037a4:	fffff097          	auipc	ra,0xfffff
    800037a8:	9a0080e7          	jalr	-1632(ra) # 80002144 <_ZN3TCBnwEm>
    800037ac:	00050493          	mv	s1,a0
    800037b0:	00050e63          	beqz	a0,800037cc <_ZN5RiscV18executeForkSyscallEv+0x8c>
    800037b4:	00200713          	li	a4,2
    800037b8:	00090693          	mv	a3,s2
    800037bc:	00000613          	li	a2,0
    800037c0:	00000593          	li	a1,0
    800037c4:	fffff097          	auipc	ra,0xfffff
    800037c8:	844080e7          	jalr	-1980(ra) # 80002008 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(forked) {
    800037cc:	0a048e63          	beqz	s1,80003888 <_ZN5RiscV18executeForkSyscallEv+0x148>
        forked->context.ra = TCB::currentPC;
    800037d0:	00008797          	auipc	a5,0x8
    800037d4:	8307b783          	ld	a5,-2000(a5) # 8000b000 <_GLOBAL_OFFSET_TABLE_+0x78>
    800037d8:	0007b783          	ld	a5,0(a5)
    800037dc:	00f4b423          	sd	a5,8(s1)
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    800037e0:	00008797          	auipc	a5,0x8
    800037e4:	8087b783          	ld	a5,-2040(a5) # 8000afe8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037e8:	0007b783          	ld	a5,0(a5)
    800037ec:	00f907b3          	add	a5,s2,a5
    800037f0:	00008717          	auipc	a4,0x8
    800037f4:	85073703          	ld	a4,-1968(a4) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800037f8:	00073683          	ld	a3,0(a4)
    800037fc:	0286b683          	ld	a3,40(a3)
    80003800:	40d787b3          	sub	a5,a5,a3
    80003804:	00f4b023          	sd	a5,0(s1)
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003808:	00073783          	ld	a5,0(a4)
    8000380c:	0687b503          	ld	a0,104(a5)
    80003810:	0287b783          	ld	a5,40(a5)
    80003814:	40f50533          	sub	a0,a0,a5
    80003818:	00a90933          	add	s2,s2,a0
        forked->a0Location = registerStartSP;
    8000381c:	0724b423          	sd	s2,104(s1)
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003820:	00058693          	mv	a3,a1
        asm("mv %[a0], a0": [a0] "=r"(a0));
    80003824:	00050793          	mv	a5,a0
        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003828:	00090513          	mv	a0,s2
        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    8000382c:	00090593          	mv	a1,s2
        asm("sd a0, 16(a1)");
    80003830:	00a5b823          	sd	a0,16(a1)
        asm("li a0, 0");
    80003834:	00000513          	li	a0,0
        asm("sd a0, 80(a1)");
    80003838:	04a5b823          	sd	a0,80(a1)
        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    8000383c:	00068593          	mv	a1,a3
        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003840:	00078513          	mv	a0,a5
        forked->sepc = TCB::running->sepc;
    80003844:	00073783          	ld	a5,0(a4)
    80003848:	0387b703          	ld	a4,56(a5)
    8000384c:	02e4bc23          	sd	a4,56(s1)
        forked->sstatus = TCB::running->sstatus;
    80003850:	0407b783          	ld	a5,64(a5)
    80003854:	04f4b023          	sd	a5,64(s1)
        Scheduler::put(forked);
    80003858:	00048513          	mv	a0,s1
    8000385c:	00001097          	auipc	ra,0x1
    80003860:	9b0080e7          	jalr	-1616(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003864:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003868:	fffff097          	auipc	ra,0xfffff
    8000386c:	584080e7          	jalr	1412(ra) # 80002dec <_ZN5RiscV16saveA0toSscratchEv>
}
    80003870:	01813083          	ld	ra,24(sp)
    80003874:	01013403          	ld	s0,16(sp)
    80003878:	00813483          	ld	s1,8(sp)
    8000387c:	00013903          	ld	s2,0(sp)
    80003880:	02010113          	addi	sp,sp,32
    80003884:	00008067          	ret
        status = -1;
    80003888:	fff00493          	li	s1,-1
    8000388c:	fd9ff06f          	j	80003864 <_ZN5RiscV18executeForkSyscallEv+0x124>
    80003890:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003894:	00048513          	mv	a0,s1
    80003898:	fffff097          	auipc	ra,0xfffff
    8000389c:	9d0080e7          	jalr	-1584(ra) # 80002268 <_ZN3TCBdlEPv>
    800038a0:	00090513          	mv	a0,s2
    800038a4:	00009097          	auipc	ra,0x9
    800038a8:	b34080e7          	jalr	-1228(ra) # 8000c3d8 <_Unwind_Resume>

00000000800038ac <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    800038ac:	f9010113          	addi	sp,sp,-112
    800038b0:	06113423          	sd	ra,104(sp)
    800038b4:	06813023          	sd	s0,96(sp)
    800038b8:	04913c23          	sd	s1,88(sp)
    800038bc:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    800038c0:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800038c4:	142027f3          	csrr	a5,scause
    800038c8:	fcf43423          	sd	a5,-56(s0)
    return scause;
    800038cc:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    800038d0:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    800038d4:	00007797          	auipc	a5,0x7
    800038d8:	76c7b783          	ld	a5,1900(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800038dc:	0007b783          	ld	a5,0(a5)
    800038e0:	14002773          	csrr	a4,sscratch
    800038e4:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    800038e8:	fd843703          	ld	a4,-40(s0)
    800038ec:	00900793          	li	a5,9
    800038f0:	10f70e63          	beq	a4,a5,80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x160>
    800038f4:	fd843703          	ld	a4,-40(s0)
    800038f8:	00800793          	li	a5,8
    800038fc:	10f70863          	beq	a4,a5,80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x160>
    else if(scause == (0x01UL<<63 | 0x1)){
    80003900:	fd843703          	ld	a4,-40(s0)
    80003904:	fff00793          	li	a5,-1
    80003908:	03f79793          	slli	a5,a5,0x3f
    8000390c:	00178793          	addi	a5,a5,1
    80003910:	26f70c63          	beq	a4,a5,80003b88 <_ZN5RiscV20handleSupervisorTrapEv+0x2dc>
    else if(scause == (0x01UL<<63 | 0x9)){
    80003914:	fd843703          	ld	a4,-40(s0)
    80003918:	fff00793          	li	a5,-1
    8000391c:	03f79793          	slli	a5,a5,0x3f
    80003920:	00978793          	addi	a5,a5,9
    80003924:	2ef70a63          	beq	a4,a5,80003c18 <_ZN5RiscV20handleSupervisorTrapEv+0x36c>
    else if(scause == 0x02){
    80003928:	fd843703          	ld	a4,-40(s0)
    8000392c:	00200793          	li	a5,2
    80003930:	38f70263          	beq	a4,a5,80003cb4 <_ZN5RiscV20handleSupervisorTrapEv+0x408>
        ConsoleUtil::printString("Error: \n");
    80003934:	00005517          	auipc	a0,0x5
    80003938:	83c50513          	addi	a0,a0,-1988 # 80008170 <CONSOLE_STATUS+0x160>
    8000393c:	fffff097          	auipc	ra,0xfffff
    80003940:	114080e7          	jalr	276(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003944:	00005517          	auipc	a0,0x5
    80003948:	83c50513          	addi	a0,a0,-1988 # 80008180 <CONSOLE_STATUS+0x170>
    8000394c:	fffff097          	auipc	ra,0xfffff
    80003950:	104080e7          	jalr	260(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003954:	142027f3          	csrr	a5,scause
    80003958:	fcf43823          	sd	a5,-48(s0)
    return scause;
    8000395c:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80003960:	00000613          	li	a2,0
    80003964:	00a00593          	li	a1,10
    80003968:	0005051b          	sext.w	a0,a0
    8000396c:	fffff097          	auipc	ra,0xfffff
    80003970:	128080e7          	jalr	296(ra) # 80002a94 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003974:	00004517          	auipc	a0,0x4
    80003978:	7ac50513          	addi	a0,a0,1964 # 80008120 <CONSOLE_STATUS+0x110>
    8000397c:	fffff097          	auipc	ra,0xfffff
    80003980:	0d4080e7          	jalr	212(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("sepc: ");
    80003984:	00004517          	auipc	a0,0x4
    80003988:	7bc50513          	addi	a0,a0,1980 # 80008140 <CONSOLE_STATUS+0x130>
    8000398c:	fffff097          	auipc	ra,0xfffff
    80003990:	0c4080e7          	jalr	196(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003994:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003998:	00000613          	li	a2,0
    8000399c:	01000593          	li	a1,16
    800039a0:	0005051b          	sext.w	a0,a0
    800039a4:	fffff097          	auipc	ra,0xfffff
    800039a8:	0f0080e7          	jalr	240(ra) # 80002a94 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800039ac:	00004517          	auipc	a0,0x4
    800039b0:	77450513          	addi	a0,a0,1908 # 80008120 <CONSOLE_STATUS+0x110>
    800039b4:	fffff097          	auipc	ra,0xfffff
    800039b8:	09c080e7          	jalr	156(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stval: ",stval,"\n");
    800039bc:	01000693          	li	a3,16
    800039c0:	00004617          	auipc	a2,0x4
    800039c4:	76060613          	addi	a2,a2,1888 # 80008120 <CONSOLE_STATUS+0x110>
    800039c8:	0004859b          	sext.w	a1,s1
    800039cc:	00004517          	auipc	a0,0x4
    800039d0:	7c450513          	addi	a0,a0,1988 # 80008190 <CONSOLE_STATUS+0x180>
    800039d4:	fffff097          	auipc	ra,0xfffff
    800039d8:	19c080e7          	jalr	412(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    800039dc:	00007797          	auipc	a5,0x7
    800039e0:	6647b783          	ld	a5,1636(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800039e4:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800039e8:	00200713          	li	a4,2
    800039ec:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    800039f0:	00004517          	auipc	a0,0x4
    800039f4:	7a850513          	addi	a0,a0,1960 # 80008198 <CONSOLE_STATUS+0x188>
    800039f8:	fffff097          	auipc	ra,0xfffff
    800039fc:	058080e7          	jalr	88(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003a00:	ffffe097          	auipc	ra,0xffffe
    80003a04:	6c4080e7          	jalr	1732(ra) # 800020c4 <_ZN3TCB8dispatchEv>
    80003a08:	0800006f          	j	80003a88 <_ZN5RiscV20handleSupervisorTrapEv+0x1dc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003a0c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003a10:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003a14:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80003a18:	00478793          	addi	a5,a5,4
    80003a1c:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    80003a20:	00007797          	auipc	a5,0x7
    80003a24:	6207b783          	ld	a5,1568(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003a28:	0007b783          	ld	a5,0(a5)
    80003a2c:	fa043703          	ld	a4,-96(s0)
    80003a30:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80003a34:	f9843703          	ld	a4,-104(s0)
    80003a38:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80003a3c:	00050793          	mv	a5,a0
        switch(syscallID){
    80003a40:	06100713          	li	a4,97
    80003a44:	02f76463          	bltu	a4,a5,80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
    80003a48:	00279793          	slli	a5,a5,0x2
    80003a4c:	00004717          	auipc	a4,0x4
    80003a50:	76070713          	addi	a4,a4,1888 # 800081ac <CONSOLE_STATUS+0x19c>
    80003a54:	00e787b3          	add	a5,a5,a4
    80003a58:	0007a783          	lw	a5,0(a5)
    80003a5c:	00e787b3          	add	a5,a5,a4
    80003a60:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003a64:	fffff097          	auipc	ra,0xfffff
    80003a68:	3c0080e7          	jalr	960(ra) # 80002e24 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003a6c:	00007797          	auipc	a5,0x7
    80003a70:	5d47b783          	ld	a5,1492(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003a74:	0007b783          	ld	a5,0(a5)
    80003a78:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003a7c:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003a80:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003a84:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003a88:	fffff097          	auipc	ra,0xfffff
    80003a8c:	26c080e7          	jalr	620(ra) # 80002cf4 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003a90:	06813083          	ld	ra,104(sp)
    80003a94:	06013403          	ld	s0,96(sp)
    80003a98:	05813483          	ld	s1,88(sp)
    80003a9c:	07010113          	addi	sp,sp,112
    80003aa0:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003aa4:	fffff097          	auipc	ra,0xfffff
    80003aa8:	3b8080e7          	jalr	952(ra) # 80002e5c <_ZN5RiscV21executeMemFreeSyscallEv>
    80003aac:	fc1ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x11 : executeThreadCreateSyscall();break;
    80003ab0:	fffff097          	auipc	ra,0xfffff
    80003ab4:	3fc080e7          	jalr	1020(ra) # 80002eac <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003ab8:	fb5ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x12 : executeThreadExitSyscall();break;
    80003abc:	fffff097          	auipc	ra,0xfffff
    80003ac0:	5e4080e7          	jalr	1508(ra) # 800030a0 <_ZN5RiscV24executeThreadExitSyscallEv>
    80003ac4:	fa9ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003ac8:	fffff097          	auipc	ra,0xfffff
    80003acc:	1a0080e7          	jalr	416(ra) # 80002c68 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003ad0:	f9dff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003ad4:	fffff097          	auipc	ra,0xfffff
    80003ad8:	4ac080e7          	jalr	1196(ra) # 80002f80 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003adc:	f91ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x15 : executeThreadStartSyscall();break;
    80003ae0:	fffff097          	auipc	ra,0xfffff
    80003ae4:	568080e7          	jalr	1384(ra) # 80003048 <_ZN5RiscV25executeThreadStartSyscallEv>
    80003ae8:	f85ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x21 : executeSemOpenSyscall();break;
    80003aec:	fffff097          	auipc	ra,0xfffff
    80003af0:	60c080e7          	jalr	1548(ra) # 800030f8 <_ZN5RiscV21executeSemOpenSyscallEv>
    80003af4:	f79ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x22 : executeSemCloseSyscall();break;
    80003af8:	fffff097          	auipc	ra,0xfffff
    80003afc:	69c080e7          	jalr	1692(ra) # 80003194 <_ZN5RiscV22executeSemCloseSyscallEv>
    80003b00:	f6dff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x23 : executeSemWaitSyscall();break;
    80003b04:	fffff097          	auipc	ra,0xfffff
    80003b08:	6f0080e7          	jalr	1776(ra) # 800031f4 <_ZN5RiscV21executeSemWaitSyscallEv>
    80003b0c:	f61ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x24 : executeSemSignalSyscall();break;
    80003b10:	fffff097          	auipc	ra,0xfffff
    80003b14:	744080e7          	jalr	1860(ra) # 80003254 <_ZN5RiscV23executeSemSignalSyscallEv>
    80003b18:	f55ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x31 : executeTimeSleepSyscall();break;
    80003b1c:	fffff097          	auipc	ra,0xfffff
    80003b20:	780080e7          	jalr	1920(ra) # 8000329c <_ZN5RiscV23executeTimeSleepSyscallEv>
    80003b24:	f49ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x41 : executeGetcSyscall();break;
    80003b28:	fffff097          	auipc	ra,0xfffff
    80003b2c:	7ec080e7          	jalr	2028(ra) # 80003314 <_ZN5RiscV18executeGetcSyscallEv>
    80003b30:	f3dff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x42 : executePutcSyscall();break;
    80003b34:	fffff097          	auipc	ra,0xfffff
    80003b38:	170080e7          	jalr	368(ra) # 80002ca4 <_ZN5RiscV18executePutcSyscallEv>
    80003b3c:	f31ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x43 : executePutcUtilSyscall();break;
    80003b40:	00000097          	auipc	ra,0x0
    80003b44:	86c080e7          	jalr	-1940(ra) # 800033ac <_ZN5RiscV22executePutcUtilSyscallEv>
    80003b48:	f25ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x51 : executeThreadFreeSyscall();break;
    80003b4c:	00000097          	auipc	ra,0x0
    80003b50:	894080e7          	jalr	-1900(ra) # 800033e0 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80003b54:	f19ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80003b58:	00000097          	auipc	ra,0x0
    80003b5c:	8f0080e7          	jalr	-1808(ra) # 80003448 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80003b60:	f0dff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80003b64:	00010793          	mv	a5,sp
    80003b68:	00007717          	auipc	a4,0x7
    80003b6c:	48073703          	ld	a4,1152(a4) # 8000afe8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003b70:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80003b74:	00000097          	auipc	ra,0x0
    80003b78:	930080e7          	jalr	-1744(ra) # 800034a4 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80003b7c:	00000097          	auipc	ra,0x0
    80003b80:	bc4080e7          	jalr	-1084(ra) # 80003740 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80003b84:	ee9ff06f          	j	80003a6c <_ZN5RiscV20handleSupervisorTrapEv+0x1c0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003b88:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003b8c:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003b90:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003b94:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80003b98:	00200793          	li	a5,2
    80003b9c:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80003ba0:	00007717          	auipc	a4,0x7
    80003ba4:	6b870713          	addi	a4,a4,1720 # 8000b258 <_ZN5RiscV16userMainFinishedE>
    80003ba8:	00873783          	ld	a5,8(a4)
    80003bac:	00178793          	addi	a5,a5,1
    80003bb0:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80003bb4:	00000097          	auipc	ra,0x0
    80003bb8:	72c080e7          	jalr	1836(ra) # 800042e0 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80003bbc:	00007717          	auipc	a4,0x7
    80003bc0:	3f473703          	ld	a4,1012(a4) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003bc4:	00073783          	ld	a5,0(a4)
    80003bc8:	00178793          	addi	a5,a5,1
    80003bcc:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80003bd0:	00007717          	auipc	a4,0x7
    80003bd4:	47073703          	ld	a4,1136(a4) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003bd8:	00073703          	ld	a4,0(a4)
    80003bdc:	03073683          	ld	a3,48(a4)
    80003be0:	00d7fc63          	bgeu	a5,a3,80003bf8 <_ZN5RiscV20handleSupervisorTrapEv+0x34c>
        RiscV::w_sstatus(sstatus);
    80003be4:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003be8:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003bec:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003bf0:	14179073          	csrw	sepc,a5
}
    80003bf4:	e95ff06f          	j	80003a88 <_ZN5RiscV20handleSupervisorTrapEv+0x1dc>
            TCB::timeSliceCounter = 0;
    80003bf8:	00007797          	auipc	a5,0x7
    80003bfc:	3b87b783          	ld	a5,952(a5) # 8000afb0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003c00:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80003c04:	00100793          	li	a5,1
    80003c08:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80003c0c:	ffffe097          	auipc	ra,0xffffe
    80003c10:	4b8080e7          	jalr	1208(ra) # 800020c4 <_ZN3TCB8dispatchEv>
    80003c14:	fd1ff06f          	j	80003be4 <_ZN5RiscV20handleSupervisorTrapEv+0x338>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003c18:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003c1c:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003c20:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003c24:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    80003c28:	00007797          	auipc	a5,0x7
    80003c2c:	3707b783          	ld	a5,880(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003c30:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003c34:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003c38:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003c3c:	00058793          	mv	a5,a1
        if(status & 1UL)
    80003c40:	0017f793          	andi	a5,a5,1
    80003c44:	02078863          	beqz	a5,80003c74 <_ZN5RiscV20handleSupervisorTrapEv+0x3c8>
            data = CONSOLE_TX_DATA;
    80003c48:	00007797          	auipc	a5,0x7
    80003c4c:	3907b783          	ld	a5,912(a5) # 8000afd8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003c50:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80003c54:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80003c58:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80003c5c:	00058513          	mv	a0,a1
    80003c60:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80003c64:	00007797          	auipc	a5,0x7
    80003c68:	37c7b783          	ld	a5,892(a5) # 8000afe0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003c6c:	0007b783          	ld	a5,0(a5)
    80003c70:	02079463          	bnez	a5,80003c98 <_ZN5RiscV20handleSupervisorTrapEv+0x3ec>
        plic_complete(plic_claim());
    80003c74:	00002097          	auipc	ra,0x2
    80003c78:	0d0080e7          	jalr	208(ra) # 80005d44 <plic_claim>
    80003c7c:	00002097          	auipc	ra,0x2
    80003c80:	100080e7          	jalr	256(ra) # 80005d7c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80003c84:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003c88:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003c8c:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003c90:	14179073          	csrw	sepc,a5
}
    80003c94:	df5ff06f          	j	80003a88 <_ZN5RiscV20handleSupervisorTrapEv+0x1dc>
                ConsoleUtil::pendingGetc--;
    80003c98:	fff78793          	addi	a5,a5,-1
    80003c9c:	00007717          	auipc	a4,0x7
    80003ca0:	34473703          	ld	a4,836(a4) # 8000afe0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003ca4:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80003ca8:	fffff097          	auipc	ra,0xfffff
    80003cac:	bb0080e7          	jalr	-1104(ra) # 80002858 <_ZN11ConsoleUtil8putInputEc>
    80003cb0:	fc5ff06f          	j	80003c74 <_ZN5RiscV20handleSupervisorTrapEv+0x3c8>
        TCB* old = TCB::running;
    80003cb4:	00007797          	auipc	a5,0x7
    80003cb8:	38c7b783          	ld	a5,908(a5) # 8000b040 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003cbc:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003cc0:	00200713          	li	a4,2
    80003cc4:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80003cc8:	00004517          	auipc	a0,0x4
    80003ccc:	47850513          	addi	a0,a0,1144 # 80008140 <CONSOLE_STATUS+0x130>
    80003cd0:	fffff097          	auipc	ra,0xfffff
    80003cd4:	d80080e7          	jalr	-640(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003cd8:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003cdc:	00000613          	li	a2,0
    80003ce0:	01000593          	li	a1,16
    80003ce4:	0005051b          	sext.w	a0,a0
    80003ce8:	fffff097          	auipc	ra,0xfffff
    80003cec:	dac080e7          	jalr	-596(ra) # 80002a94 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003cf0:	00004517          	auipc	a0,0x4
    80003cf4:	43050513          	addi	a0,a0,1072 # 80008120 <CONSOLE_STATUS+0x110>
    80003cf8:	fffff097          	auipc	ra,0xfffff
    80003cfc:	d58080e7          	jalr	-680(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80003d00:	00004517          	auipc	a0,0x4
    80003d04:	44850513          	addi	a0,a0,1096 # 80008148 <CONSOLE_STATUS+0x138>
    80003d08:	fffff097          	auipc	ra,0xfffff
    80003d0c:	d48080e7          	jalr	-696(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003d10:	ffffe097          	auipc	ra,0xffffe
    80003d14:	3b4080e7          	jalr	948(ra) # 800020c4 <_ZN3TCB8dispatchEv>
    80003d18:	d71ff06f          	j	80003a88 <_ZN5RiscV20handleSupervisorTrapEv+0x1dc>

0000000080003d1c <_ZN5RiscV12buildSectionEPvmmm>:
void RiscV::buildSection(void *PMT, uint64 start, uint64 end, uint64 mask) {
    80003d1c:	fd010113          	addi	sp,sp,-48
    80003d20:	02113423          	sd	ra,40(sp)
    80003d24:	02813023          	sd	s0,32(sp)
    80003d28:	00913c23          	sd	s1,24(sp)
    80003d2c:	01213823          	sd	s2,16(sp)
    80003d30:	01313423          	sd	s3,8(sp)
    80003d34:	01413023          	sd	s4,0(sp)
    80003d38:	03010413          	addi	s0,sp,48
    80003d3c:	00050a13          	mv	s4,a0
    80003d40:	00058493          	mv	s1,a1
    80003d44:	00060913          	mv	s2,a2
    80003d48:	00068993          	mv	s3,a3
    for(uint64 i=start;i<end;i+=0x1000) {
    80003d4c:	0324f263          	bgeu	s1,s2,80003d70 <_ZN5RiscV12buildSectionEPvmmm+0x54>
        handlePageFault(PMT,i, mask);
    80003d50:	00098613          	mv	a2,s3
    80003d54:	00048593          	mv	a1,s1
    80003d58:	000a0513          	mv	a0,s4
    80003d5c:	00000097          	auipc	ra,0x0
    80003d60:	908080e7          	jalr	-1784(ra) # 80003664 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=start;i<end;i+=0x1000) {
    80003d64:	000017b7          	lui	a5,0x1
    80003d68:	00f484b3          	add	s1,s1,a5
    80003d6c:	fe1ff06f          	j	80003d4c <_ZN5RiscV12buildSectionEPvmmm+0x30>
}
    80003d70:	02813083          	ld	ra,40(sp)
    80003d74:	02013403          	ld	s0,32(sp)
    80003d78:	01813483          	ld	s1,24(sp)
    80003d7c:	01013903          	ld	s2,16(sp)
    80003d80:	00813983          	ld	s3,8(sp)
    80003d84:	00013a03          	ld	s4,0(sp)
    80003d88:	03010113          	addi	sp,sp,48
    80003d8c:	00008067          	ret

0000000080003d90 <_ZN5RiscV19mapConsoleRegistersEPv>:

void RiscV::mapConsoleRegisters(void *PMT) {
    80003d90:	fe010113          	addi	sp,sp,-32
    80003d94:	00113c23          	sd	ra,24(sp)
    80003d98:	00813823          	sd	s0,16(sp)
    80003d9c:	00913423          	sd	s1,8(sp)
    80003da0:	02010413          	addi	s0,sp,32
    80003da4:	00050493          	mv	s1,a0
    handlePageFault(PMT, (uint64)CONSOLE_STATUS,0x1f);
    80003da8:	01f00613          	li	a2,31
    80003dac:	00007797          	auipc	a5,0x7
    80003db0:	1ec7b783          	ld	a5,492(a5) # 8000af98 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003db4:	0007b583          	ld	a1,0(a5)
    80003db8:	00000097          	auipc	ra,0x0
    80003dbc:	8ac080e7          	jalr	-1876(ra) # 80003664 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_TX_DATA,0x1f);
    80003dc0:	01f00613          	li	a2,31
    80003dc4:	00007797          	auipc	a5,0x7
    80003dc8:	2147b783          	ld	a5,532(a5) # 8000afd8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003dcc:	0007b583          	ld	a1,0(a5)
    80003dd0:	00048513          	mv	a0,s1
    80003dd4:	00000097          	auipc	ra,0x0
    80003dd8:	890080e7          	jalr	-1904(ra) # 80003664 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_RX_DATA,0x1f);
    80003ddc:	01f00613          	li	a2,31
    80003de0:	00007797          	auipc	a5,0x7
    80003de4:	1b07b783          	ld	a5,432(a5) # 8000af90 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003de8:	0007b583          	ld	a1,0(a5)
    80003dec:	00048513          	mv	a0,s1
    80003df0:	00000097          	auipc	ra,0x0
    80003df4:	874080e7          	jalr	-1932(ra) # 80003664 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)PLIC_CLAIM_PF,0x1f);
    80003df8:	01f00613          	li	a2,31
    80003dfc:	0c2015b7          	lui	a1,0xc201
    80003e00:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    80003e04:	00048513          	mv	a0,s1
    80003e08:	00000097          	auipc	ra,0x0
    80003e0c:	85c080e7          	jalr	-1956(ra) # 80003664 <_ZN5RiscV15handlePageFaultEPvmm>
    80003e10:	01813083          	ld	ra,24(sp)
    80003e14:	01013403          	ld	s0,16(sp)
    80003e18:	00813483          	ld	s1,8(sp)
    80003e1c:	02010113          	addi	sp,sp,32
    80003e20:	00008067          	ret

0000000080003e24 <_ZN5RiscV14buildKernelPMTEv>:
void RiscV::buildKernelPMT() {
    80003e24:	fd010113          	addi	sp,sp,-48
    80003e28:	02113423          	sd	ra,40(sp)
    80003e2c:	02813023          	sd	s0,32(sp)
    80003e30:	00913c23          	sd	s1,24(sp)
    80003e34:	01213823          	sd	s2,16(sp)
    80003e38:	01313423          	sd	s3,8(sp)
    80003e3c:	01413023          	sd	s4,0(sp)
    80003e40:	03010413          	addi	s0,sp,48
    RiscV::kPMT = RiscV::getPMT();
    80003e44:	fffff097          	auipc	ra,0xfffff
    80003e48:	7d0080e7          	jalr	2000(ra) # 80003614 <_ZN5RiscV6getPMTEv>
    80003e4c:	00007497          	auipc	s1,0x7
    80003e50:	40c48493          	addi	s1,s1,1036 # 8000b258 <_ZN5RiscV16userMainFinishedE>
    80003e54:	00a4b823          	sd	a0,16(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003e58:	00007797          	auipc	a5,0x7
    80003e5c:	1687b783          	ld	a5,360(a5) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003e60:	0007b903          	ld	s2,0(a5)
    80003e64:	00c91913          	slli	s2,s2,0xc
    80003e68:	00007797          	auipc	a5,0x7
    80003e6c:	1687b783          	ld	a5,360(a5) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003e70:	0007b783          	ld	a5,0(a5)
    80003e74:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(kPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80003e78:	00007a17          	auipc	s4,0x7
    80003e7c:	130a3a03          	ld	s4,304(s4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003e80:	00b00693          	li	a3,11
    80003e84:	000a0613          	mv	a2,s4
    80003e88:	00100593          	li	a1,1
    80003e8c:	01f59593          	slli	a1,a1,0x1f
    80003e90:	00000097          	auipc	ra,0x0
    80003e94:	e8c080e7          	jalr	-372(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80003e98:	00007997          	auipc	s3,0x7
    80003e9c:	1b09b983          	ld	s3,432(s3) # 8000b048 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003ea0:	00700693          	li	a3,7
    80003ea4:	00098613          	mv	a2,s3
    80003ea8:	000a0593          	mv	a1,s4
    80003eac:	0104b503          	ld	a0,16(s1)
    80003eb0:	00000097          	auipc	ra,0x0
    80003eb4:	e6c080e7          	jalr	-404(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80003eb8:	00007a17          	auipc	s4,0x7
    80003ebc:	1b0a3a03          	ld	s4,432(s4) # 8000b068 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80003ec0:	01b00693          	li	a3,27
    80003ec4:	000a0613          	mv	a2,s4
    80003ec8:	00098593          	mv	a1,s3
    80003ecc:	0104b503          	ld	a0,16(s1)
    80003ed0:	00000097          	auipc	ra,0x0
    80003ed4:	e4c080e7          	jalr	-436(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80003ed8:	00007997          	auipc	s3,0x7
    80003edc:	0e09b983          	ld	s3,224(s3) # 8000afb8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003ee0:	01700693          	li	a3,23
    80003ee4:	00098613          	mv	a2,s3
    80003ee8:	000a0593          	mv	a1,s4
    80003eec:	0104b503          	ld	a0,16(s1)
    80003ef0:	00000097          	auipc	ra,0x0
    80003ef4:	e2c080e7          	jalr	-468(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_END, bEnd, 0x7);
    80003ef8:	00700693          	li	a3,7
    80003efc:	00090613          	mv	a2,s2
    80003f00:	00098593          	mv	a1,s3
    80003f04:	0104b503          	ld	a0,16(s1)
    80003f08:	00000097          	auipc	ra,0x0
    80003f0c:	e14080e7          	jalr	-492(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, bEnd, HEAP_END, 0x17);
    80003f10:	01700693          	li	a3,23
    80003f14:	00007797          	auipc	a5,0x7
    80003f18:	1447b783          	ld	a5,324(a5) # 8000b058 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80003f1c:	0007b603          	ld	a2,0(a5)
    80003f20:	00090593          	mv	a1,s2
    80003f24:	0104b503          	ld	a0,16(s1)
    80003f28:	00000097          	auipc	ra,0x0
    80003f2c:	df4080e7          	jalr	-524(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(kPMT);
    80003f30:	0104b503          	ld	a0,16(s1)
    80003f34:	00000097          	auipc	ra,0x0
    80003f38:	e5c080e7          	jalr	-420(ra) # 80003d90 <_ZN5RiscV19mapConsoleRegistersEPv>
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003f3c:	000407b7          	lui	a5,0x40
    80003f40:	1007a073          	csrs	sstatus,a5
}
    80003f44:	02813083          	ld	ra,40(sp)
    80003f48:	02013403          	ld	s0,32(sp)
    80003f4c:	01813483          	ld	s1,24(sp)
    80003f50:	01013903          	ld	s2,16(sp)
    80003f54:	00813983          	ld	s3,8(sp)
    80003f58:	00013a03          	ld	s4,0(sp)
    80003f5c:	03010113          	addi	sp,sp,48
    80003f60:	00008067          	ret

0000000080003f64 <_ZN5RiscV12buildUserPMTEv>:
void RiscV::buildUserPMT() {
    80003f64:	fd010113          	addi	sp,sp,-48
    80003f68:	02113423          	sd	ra,40(sp)
    80003f6c:	02813023          	sd	s0,32(sp)
    80003f70:	00913c23          	sd	s1,24(sp)
    80003f74:	01213823          	sd	s2,16(sp)
    80003f78:	01313423          	sd	s3,8(sp)
    80003f7c:	01413023          	sd	s4,0(sp)
    80003f80:	03010413          	addi	s0,sp,48
    RiscV::uPMT = RiscV::getPMT();
    80003f84:	fffff097          	auipc	ra,0xfffff
    80003f88:	690080e7          	jalr	1680(ra) # 80003614 <_ZN5RiscV6getPMTEv>
    80003f8c:	00007497          	auipc	s1,0x7
    80003f90:	2cc48493          	addi	s1,s1,716 # 8000b258 <_ZN5RiscV16userMainFinishedE>
    80003f94:	00a4bc23          	sd	a0,24(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003f98:	00007797          	auipc	a5,0x7
    80003f9c:	0287b783          	ld	a5,40(a5) # 8000afc0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003fa0:	0007b903          	ld	s2,0(a5)
    80003fa4:	00c91913          	slli	s2,s2,0xc
    80003fa8:	00007797          	auipc	a5,0x7
    80003fac:	0287b783          	ld	a5,40(a5) # 8000afd0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003fb0:	0007b783          	ld	a5,0(a5)
    80003fb4:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(uPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80003fb8:	00007a17          	auipc	s4,0x7
    80003fbc:	ff0a3a03          	ld	s4,-16(s4) # 8000afa8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003fc0:	00b00693          	li	a3,11
    80003fc4:	000a0613          	mv	a2,s4
    80003fc8:	00100593          	li	a1,1
    80003fcc:	01f59593          	slli	a1,a1,0x1f
    80003fd0:	00000097          	auipc	ra,0x0
    80003fd4:	d4c080e7          	jalr	-692(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80003fd8:	00007997          	auipc	s3,0x7
    80003fdc:	0709b983          	ld	s3,112(s3) # 8000b048 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003fe0:	00700693          	li	a3,7
    80003fe4:	00098613          	mv	a2,s3
    80003fe8:	000a0593          	mv	a1,s4
    80003fec:	0184b503          	ld	a0,24(s1)
    80003ff0:	00000097          	auipc	ra,0x0
    80003ff4:	d2c080e7          	jalr	-724(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80003ff8:	00007a17          	auipc	s4,0x7
    80003ffc:	070a3a03          	ld	s4,112(s4) # 8000b068 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80004000:	01b00693          	li	a3,27
    80004004:	000a0613          	mv	a2,s4
    80004008:	00098593          	mv	a1,s3
    8000400c:	0184b503          	ld	a0,24(s1)
    80004010:	00000097          	auipc	ra,0x0
    80004014:	d0c080e7          	jalr	-756(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80004018:	00007997          	auipc	s3,0x7
    8000401c:	fa09b983          	ld	s3,-96(s3) # 8000afb8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004020:	01700693          	li	a3,23
    80004024:	00098613          	mv	a2,s3
    80004028:	000a0593          	mv	a1,s4
    8000402c:	0184b503          	ld	a0,24(s1)
    80004030:	00000097          	auipc	ra,0x0
    80004034:	cec080e7          	jalr	-788(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_END, bEnd, 0x7);
    80004038:	00700693          	li	a3,7
    8000403c:	00090613          	mv	a2,s2
    80004040:	00098593          	mv	a1,s3
    80004044:	0184b503          	ld	a0,24(s1)
    80004048:	00000097          	auipc	ra,0x0
    8000404c:	cd4080e7          	jalr	-812(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, bEnd, HEAP_END, 0x17);
    80004050:	01700693          	li	a3,23
    80004054:	00007797          	auipc	a5,0x7
    80004058:	0047b783          	ld	a5,4(a5) # 8000b058 <_GLOBAL_OFFSET_TABLE_+0xd0>
    8000405c:	0007b603          	ld	a2,0(a5)
    80004060:	00090593          	mv	a1,s2
    80004064:	0184b503          	ld	a0,24(s1)
    80004068:	00000097          	auipc	ra,0x0
    8000406c:	cb4080e7          	jalr	-844(ra) # 80003d1c <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(uPMT);
    80004070:	0184b503          	ld	a0,24(s1)
    80004074:	00000097          	auipc	ra,0x0
    80004078:	d1c080e7          	jalr	-740(ra) # 80003d90 <_ZN5RiscV19mapConsoleRegistersEPv>
    8000407c:	000407b7          	lui	a5,0x40
    80004080:	1007a073          	csrs	sstatus,a5
}
    80004084:	02813083          	ld	ra,40(sp)
    80004088:	02013403          	ld	s0,32(sp)
    8000408c:	01813483          	ld	s1,24(sp)
    80004090:	01013903          	ld	s2,16(sp)
    80004094:	00813983          	ld	s3,8(sp)
    80004098:	00013a03          	ld	s4,0(sp)
    8000409c:	03010113          	addi	sp,sp,48
    800040a0:	00008067          	ret

00000000800040a4 <_ZN5RiscV10initializeEv>:
void RiscV::initialize(){
    800040a4:	ff010113          	addi	sp,sp,-16
    800040a8:	00113423          	sd	ra,8(sp)
    800040ac:	00813023          	sd	s0,0(sp)
    800040b0:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    800040b4:	00007797          	auipc	a5,0x7
    800040b8:	f6c7b783          	ld	a5,-148(a5) # 8000b020 <_GLOBAL_OFFSET_TABLE_+0x98>
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    800040bc:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    800040c0:	00007797          	auipc	a5,0x7
    800040c4:	ee07b783          	ld	a5,-288(a5) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800040c8:	0007b503          	ld	a0,0(a5)
    800040cc:	00c55513          	srli	a0,a0,0xc
    800040d0:	00250513          	addi	a0,a0,2
    800040d4:	000015b7          	lui	a1,0x1
    800040d8:	00c51513          	slli	a0,a0,0xc
    800040dc:	00000097          	auipc	ra,0x0
    800040e0:	32c080e7          	jalr	812(ra) # 80004408 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    800040e4:	ffffe097          	auipc	ra,0xffffe
    800040e8:	1e4080e7          	jalr	484(ra) # 800022c8 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    800040ec:	00000097          	auipc	ra,0x0
    800040f0:	108080e7          	jalr	264(ra) # 800041f4 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    800040f4:	ffffe097          	auipc	ra,0xffffe
    800040f8:	080080e7          	jalr	128(ra) # 80002174 <_ZN3TCB10initializeEv>
    SCB::initialize();
    800040fc:	ffffd097          	auipc	ra,0xffffd
    80004100:	5c4080e7          	jalr	1476(ra) # 800016c0 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80004104:	ffffe097          	auipc	ra,0xffffe
    80004108:	670080e7          	jalr	1648(ra) # 80002774 <_ZN11ConsoleUtil10initializeEv>
    RiscV::buildKernelPMT();
    8000410c:	00000097          	auipc	ra,0x0
    80004110:	d18080e7          	jalr	-744(ra) # 80003e24 <_ZN5RiscV14buildKernelPMTEv>
    RiscV::buildUserPMT();
    80004114:	00000097          	auipc	ra,0x0
    80004118:	e50080e7          	jalr	-432(ra) # 80003f64 <_ZN5RiscV12buildUserPMTEv>
    RiscV::initialized = true;
    8000411c:	00007797          	auipc	a5,0x7
    80004120:	13c78793          	addi	a5,a5,316 # 8000b258 <_ZN5RiscV16userMainFinishedE>
    80004124:	00100713          	li	a4,1
    80004128:	02e78023          	sb	a4,32(a5)
    RiscV::startVirtualMemory(RiscV::kPMT);
    8000412c:	0107b783          	ld	a5,16(a5)
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80004130:	00c7d793          	srli	a5,a5,0xc
    80004134:	fff00713          	li	a4,-1
    80004138:	03f71713          	slli	a4,a4,0x3f
    8000413c:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80004140:	18079073          	csrw	satp,a5
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80004144:	00200793          	li	a5,2
    80004148:	1047a073          	csrs	sie,a5
    8000414c:	20000713          	li	a4,512
    80004150:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80004154:	1007a073          	csrs	sstatus,a5
}
    80004158:	00813083          	ld	ra,8(sp)
    8000415c:	00013403          	ld	s0,0(sp)
    80004160:	01010113          	addi	sp,sp,16
    80004164:	00008067          	ret

0000000080004168 <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/kernel/utility.hpp"

char* strcpy(const char* src, char* dst){
    80004168:	ff010113          	addi	sp,sp,-16
    8000416c:	00813423          	sd	s0,8(sp)
    80004170:	01010413          	addi	s0,sp,16
    80004174:	00050793          	mv	a5,a0
    80004178:	00058513          	mv	a0,a1
    while(*src != '\0')
    8000417c:	0007c703          	lbu	a4,0(a5)
    80004180:	00070a63          	beqz	a4,80004194 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004184:	00178793          	addi	a5,a5,1
    80004188:	00e50023          	sb	a4,0(a0)
    8000418c:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004190:	fedff06f          	j	8000417c <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004194:	00e50023          	sb	a4,0(a0)
    return dst;
}
    80004198:	00813403          	ld	s0,8(sp)
    8000419c:	01010113          	addi	sp,sp,16
    800041a0:	00008067          	ret

00000000800041a4 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    800041a4:	fe010113          	addi	sp,sp,-32
    800041a8:	00113c23          	sd	ra,24(sp)
    800041ac:	00813823          	sd	s0,16(sp)
    800041b0:	00913423          	sd	s1,8(sp)
    800041b4:	02010413          	addi	s0,sp,32
    800041b8:	00050493          	mv	s1,a0
    800041bc:	00058513          	mv	a0,a1
    char *dest = dst;
    800041c0:	00048593          	mv	a1,s1
    while(*dest != '\0')
    800041c4:	0005c783          	lbu	a5,0(a1) # 1000 <_entry-0x7ffff000>
    800041c8:	00078663          	beqz	a5,800041d4 <_Z6strcatPcPKc+0x30>
        dest++;
    800041cc:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    800041d0:	ff5ff06f          	j	800041c4 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    800041d4:	00000097          	auipc	ra,0x0
    800041d8:	f94080e7          	jalr	-108(ra) # 80004168 <_Z6strcpyPKcPc>
    return dst;
    800041dc:	00048513          	mv	a0,s1
    800041e0:	01813083          	ld	ra,24(sp)
    800041e4:	01013403          	ld	s0,16(sp)
    800041e8:	00813483          	ld	s1,8(sp)
    800041ec:	02010113          	addi	sp,sp,32
    800041f0:	00008067          	ret

00000000800041f4 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    800041f4:	ff010113          	addi	sp,sp,-16
    800041f8:	00813423          	sd	s0,8(sp)
    800041fc:	01010413          	addi	s0,sp,16
}
    80004200:	00813403          	ld	s0,8(sp)
    80004204:	01010113          	addi	sp,sp,16
    80004208:	00008067          	ret

000000008000420c <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    8000420c:	ff010113          	addi	sp,sp,-16
    80004210:	00813423          	sd	s0,8(sp)
    80004214:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004218:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    8000421c:	00007797          	auipc	a5,0x7
    80004220:	0647b783          	ld	a5,100(a5) # 8000b280 <_ZN9Scheduler9readyHeadE>
    80004224:	02078263          	beqz	a5,80004248 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004228:	00007797          	auipc	a5,0x7
    8000422c:	0607b783          	ld	a5,96(a5) # 8000b288 <_ZN9Scheduler9readyTailE>
    80004230:	04a7b423          	sd	a0,72(a5)
    80004234:	00007797          	auipc	a5,0x7
    80004238:	04a7ba23          	sd	a0,84(a5) # 8000b288 <_ZN9Scheduler9readyTailE>
}
    8000423c:	00813403          	ld	s0,8(sp)
    80004240:	01010113          	addi	sp,sp,16
    80004244:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004248:	00007797          	auipc	a5,0x7
    8000424c:	02a7bc23          	sd	a0,56(a5) # 8000b280 <_ZN9Scheduler9readyHeadE>
    80004250:	fe5ff06f          	j	80004234 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004254 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004254:	ff010113          	addi	sp,sp,-16
    80004258:	00813423          	sd	s0,8(sp)
    8000425c:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004260:	00007517          	auipc	a0,0x7
    80004264:	02053503          	ld	a0,32(a0) # 8000b280 <_ZN9Scheduler9readyHeadE>
    80004268:	00050a63          	beqz	a0,8000427c <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    8000426c:	04853783          	ld	a5,72(a0)
    80004270:	00007717          	auipc	a4,0x7
    80004274:	00f73823          	sd	a5,16(a4) # 8000b280 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004278:	04053423          	sd	zero,72(a0)
    return tmp;
}
    8000427c:	00813403          	ld	s0,8(sp)
    80004280:	01010113          	addi	sp,sp,16
    80004284:	00008067          	ret

0000000080004288 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004288:	ff010113          	addi	sp,sp,-16
    8000428c:	00813423          	sd	s0,8(sp)
    80004290:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004294:	00007797          	auipc	a5,0x7
    80004298:	ffc7b783          	ld	a5,-4(a5) # 8000b290 <_ZN9Scheduler12sleepingHeadE>
    8000429c:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800042a0:	00078e63          	beqz	a5,800042bc <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    800042a4:	0587b683          	ld	a3,88(a5)
    800042a8:	05853703          	ld	a4,88(a0)
    800042ac:	00d76863          	bltu	a4,a3,800042bc <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800042b0:	00078613          	mv	a2,a5
    800042b4:	0487b783          	ld	a5,72(a5)
    800042b8:	fe9ff06f          	j	800042a0 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    800042bc:	04f53423          	sd	a5,72(a0)
    if(prev)
    800042c0:	00060a63          	beqz	a2,800042d4 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    800042c4:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    800042c8:	00813403          	ld	s0,8(sp)
    800042cc:	01010113          	addi	sp,sp,16
    800042d0:	00008067          	ret
        sleepingHead = t;
    800042d4:	00007797          	auipc	a5,0x7
    800042d8:	faa7be23          	sd	a0,-68(a5) # 8000b290 <_ZN9Scheduler12sleepingHeadE>
}
    800042dc:	fedff06f          	j	800042c8 <_ZN9Scheduler5sleepEP3TCB+0x40>

00000000800042e0 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    800042e0:	fe010113          	addi	sp,sp,-32
    800042e4:	00113c23          	sd	ra,24(sp)
    800042e8:	00813823          	sd	s0,16(sp)
    800042ec:	00913423          	sd	s1,8(sp)
    800042f0:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    800042f4:	00007497          	auipc	s1,0x7
    800042f8:	f9c4b483          	ld	s1,-100(s1) # 8000b290 <_ZN9Scheduler12sleepingHeadE>
    800042fc:	02048c63          	beqz	s1,80004334 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004300:	0584b703          	ld	a4,88(s1)
    80004304:	00007797          	auipc	a5,0x7
    80004308:	d5c7b783          	ld	a5,-676(a5) # 8000b060 <_GLOBAL_OFFSET_TABLE_+0xd8>
    8000430c:	0007b783          	ld	a5,0(a5)
    80004310:	02e7e263          	bltu	a5,a4,80004334 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004314:	0484b783          	ld	a5,72(s1)
    80004318:	00007717          	auipc	a4,0x7
    8000431c:	f6f73c23          	sd	a5,-136(a4) # 8000b290 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004320:	00048513          	mv	a0,s1
    80004324:	00000097          	auipc	ra,0x0
    80004328:	ee8080e7          	jalr	-280(ra) # 8000420c <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    8000432c:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004330:	fc5ff06f          	j	800042f4 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004334:	01813083          	ld	ra,24(sp)
    80004338:	01013403          	ld	s0,16(sp)
    8000433c:	00813483          	ld	s1,8(sp)
    80004340:	02010113          	addi	sp,sp,32
    80004344:	00008067          	ret

0000000080004348 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004348:	fe010113          	addi	sp,sp,-32
    8000434c:	00113c23          	sd	ra,24(sp)
    80004350:	00813823          	sd	s0,16(sp)
    80004354:	00913423          	sd	s1,8(sp)
    80004358:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    8000435c:	00007497          	auipc	s1,0x7
    80004360:	f244b483          	ld	s1,-220(s1) # 8000b280 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004364:	02048863          	beqz	s1,80004394 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004368:	00000613          	li	a2,0
    8000436c:	01000593          	li	a1,16
    80004370:	0004851b          	sext.w	a0,s1
    80004374:	ffffe097          	auipc	ra,0xffffe
    80004378:	720080e7          	jalr	1824(ra) # 80002a94 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000437c:	00004517          	auipc	a0,0x4
    80004380:	da450513          	addi	a0,a0,-604 # 80008120 <CONSOLE_STATUS+0x110>
    80004384:	ffffe097          	auipc	ra,0xffffe
    80004388:	6cc080e7          	jalr	1740(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    8000438c:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004390:	fd5ff06f          	j	80004364 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004394:	01813083          	ld	ra,24(sp)
    80004398:	01013403          	ld	s0,16(sp)
    8000439c:	00813483          	ld	s1,8(sp)
    800043a0:	02010113          	addi	sp,sp,32
    800043a4:	00008067          	ret

00000000800043a8 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    800043a8:	fe010113          	addi	sp,sp,-32
    800043ac:	00113c23          	sd	ra,24(sp)
    800043b0:	00813823          	sd	s0,16(sp)
    800043b4:	00913423          	sd	s1,8(sp)
    800043b8:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    800043bc:	00007497          	auipc	s1,0x7
    800043c0:	ed44b483          	ld	s1,-300(s1) # 8000b290 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    800043c4:	02048863          	beqz	s1,800043f4 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    800043c8:	00000613          	li	a2,0
    800043cc:	01000593          	li	a1,16
    800043d0:	0004851b          	sext.w	a0,s1
    800043d4:	0000b097          	auipc	ra,0xb
    800043d8:	a8c080e7          	jalr	-1396(ra) # 8000ee60 <_Z8printIntiii>
        printString("\n");
    800043dc:	00004517          	auipc	a0,0x4
    800043e0:	d4450513          	addi	a0,a0,-700 # 80008120 <CONSOLE_STATUS+0x110>
    800043e4:	0000b097          	auipc	ra,0xb
    800043e8:	8e4080e7          	jalr	-1820(ra) # 8000ecc8 <_Z11printStringPKc>
        iter = iter->next;
    800043ec:	0484b483          	ld	s1,72(s1)
    while(iter){
    800043f0:	fd5ff06f          	j	800043c4 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    800043f4:	01813083          	ld	ra,24(sp)
    800043f8:	01013403          	ld	s0,16(sp)
    800043fc:	00813483          	ld	s1,8(sp)
    80004400:	02010113          	addi	sp,sp,32
    80004404:	00008067          	ret

0000000080004408 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/kernel/slab.hpp"

void kmem_init(void* space, int block_num){
    80004408:	ff010113          	addi	sp,sp,-16
    8000440c:	00113423          	sd	ra,8(sp)
    80004410:	00813023          	sd	s0,0(sp)
    80004414:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004418:	00001097          	auipc	ra,0x1
    8000441c:	af4080e7          	jalr	-1292(ra) # 80004f0c <_ZN13SlabAllocator10initializeEPvm>
}
    80004420:	00813083          	ld	ra,8(sp)
    80004424:	00013403          	ld	s0,0(sp)
    80004428:	01010113          	addi	sp,sp,16
    8000442c:	00008067          	ret

0000000080004430 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80004430:	ff010113          	addi	sp,sp,-16
    80004434:	00113423          	sd	ra,8(sp)
    80004438:	00813023          	sd	s0,0(sp)
    8000443c:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80004440:	00001097          	auipc	ra,0x1
    80004444:	9c0080e7          	jalr	-1600(ra) # 80004e00 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004448:	00813083          	ld	ra,8(sp)
    8000444c:	00013403          	ld	s0,0(sp)
    80004450:	01010113          	addi	sp,sp,16
    80004454:	00008067          	ret

0000000080004458 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80004458:	ff010113          	addi	sp,sp,-16
    8000445c:	00113423          	sd	ra,8(sp)
    80004460:	00813023          	sd	s0,0(sp)
    80004464:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80004468:	00000097          	auipc	ra,0x0
    8000446c:	768080e7          	jalr	1896(ra) # 80004bd0 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004470:	00813083          	ld	ra,8(sp)
    80004474:	00013403          	ld	s0,0(sp)
    80004478:	01010113          	addi	sp,sp,16
    8000447c:	00008067          	ret

0000000080004480 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80004480:	ff010113          	addi	sp,sp,-16
    80004484:	00113423          	sd	ra,8(sp)
    80004488:	00813023          	sd	s0,0(sp)
    8000448c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80004490:	00001097          	auipc	ra,0x1
    80004494:	c64080e7          	jalr	-924(ra) # 800050f4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80004498:	00813083          	ld	ra,8(sp)
    8000449c:	00013403          	ld	s0,0(sp)
    800044a0:	01010113          	addi	sp,sp,16
    800044a4:	00008067          	ret

00000000800044a8 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    800044a8:	fe010113          	addi	sp,sp,-32
    800044ac:	00113c23          	sd	ra,24(sp)
    800044b0:	00813823          	sd	s0,16(sp)
    800044b4:	02010413          	addi	s0,sp,32
    800044b8:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    800044bc:	fe840513          	addi	a0,s0,-24
    800044c0:	00001097          	auipc	ra,0x1
    800044c4:	e30080e7          	jalr	-464(ra) # 800052f0 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    800044c8:	01813083          	ld	ra,24(sp)
    800044cc:	01013403          	ld	s0,16(sp)
    800044d0:	02010113          	addi	sp,sp,32
    800044d4:	00008067          	ret

00000000800044d8 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    800044d8:	ff010113          	addi	sp,sp,-16
    800044dc:	00113423          	sd	ra,8(sp)
    800044e0:	00813023          	sd	s0,0(sp)
    800044e4:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    800044e8:	00000097          	auipc	ra,0x0
    800044ec:	204080e7          	jalr	516(ra) # 800046ec <_ZN13SlabAllocator10printCacheEP5Cache>
}
    800044f0:	00813083          	ld	ra,8(sp)
    800044f4:	00013403          	ld	s0,0(sp)
    800044f8:	01010113          	addi	sp,sp,16
    800044fc:	00008067          	ret

0000000080004500 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80004500:	ff010113          	addi	sp,sp,-16
    80004504:	00113423          	sd	ra,8(sp)
    80004508:	00813023          	sd	s0,0(sp)
    8000450c:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80004510:	00001097          	auipc	ra,0x1
    80004514:	d44080e7          	jalr	-700(ra) # 80005254 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80004518:	00813083          	ld	ra,8(sp)
    8000451c:	00013403          	ld	s0,0(sp)
    80004520:	01010113          	addi	sp,sp,16
    80004524:	00008067          	ret

0000000080004528 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80004528:	ff010113          	addi	sp,sp,-16
    8000452c:	00113423          	sd	ra,8(sp)
    80004530:	00813023          	sd	s0,0(sp)
    80004534:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80004538:	00001097          	auipc	ra,0x1
    8000453c:	828080e7          	jalr	-2008(ra) # 80004d60 <_ZN13SlabAllocator14allocateBufferEm>
}
    80004540:	00813083          	ld	ra,8(sp)
    80004544:	00013403          	ld	s0,0(sp)
    80004548:	01010113          	addi	sp,sp,16
    8000454c:	00008067          	ret

0000000080004550 <_Z5kfreePKv>:

void kfree(const void* objp){
    80004550:	ff010113          	addi	sp,sp,-16
    80004554:	00113423          	sd	ra,8(sp)
    80004558:	00813023          	sd	s0,0(sp)
    8000455c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80004560:	00001097          	auipc	ra,0x1
    80004564:	c88080e7          	jalr	-888(ra) # 800051e8 <_ZN13SlabAllocator10freeBufferEPKv>
}
    80004568:	00813083          	ld	ra,8(sp)
    8000456c:	00013403          	ld	s0,0(sp)
    80004570:	01010113          	addi	sp,sp,16
    80004574:	00008067          	ret

0000000080004578 <_Z16kmem_cache_errorP5Cache>:

int kmem_cache_error(kmem_cache_t* cachep){
    80004578:	ff010113          	addi	sp,sp,-16
    8000457c:	00113423          	sd	ra,8(sp)
    80004580:	00813023          	sd	s0,0(sp)
    80004584:	01010413          	addi	s0,sp,16
    return SlabAllocator::cacheErrorHandler(cachep);
    80004588:	00001097          	auipc	ra,0x1
    8000458c:	ee0080e7          	jalr	-288(ra) # 80005468 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache>
    80004590:	00813083          	ld	ra,8(sp)
    80004594:	00013403          	ld	s0,0(sp)
    80004598:	01010113          	addi	sp,sp,16
    8000459c:	00008067          	ret

00000000800045a0 <_ZN13SlabAllocator9printSlabEP4Slab>:
    }
    return ret;
}

void SlabAllocator::printSlab(Slab *slab) {
    if(slab) {
    800045a0:	14050463          	beqz	a0,800046e8 <_ZN13SlabAllocator9printSlabEP4Slab+0x148>
void SlabAllocator::printSlab(Slab *slab) {
    800045a4:	fe010113          	addi	sp,sp,-32
    800045a8:	00113c23          	sd	ra,24(sp)
    800045ac:	00813823          	sd	s0,16(sp)
    800045b0:	00913423          	sd	s1,8(sp)
    800045b4:	01213023          	sd	s2,0(sp)
    800045b8:	02010413          	addi	s0,sp,32
    800045bc:	00050913          	mv	s2,a0
        ConsoleUtil::printString("\nNOW SHOWING SLAB INFO\n");
    800045c0:	00004517          	auipc	a0,0x4
    800045c4:	d7850513          	addi	a0,a0,-648 # 80008338 <CONSOLE_STATUS+0x328>
    800045c8:	ffffe097          	auipc	ra,0xffffe
    800045cc:	488080e7          	jalr	1160(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    800045d0:	01000693          	li	a3,16
    800045d4:	00004617          	auipc	a2,0x4
    800045d8:	b4c60613          	addi	a2,a2,-1204 # 80008120 <CONSOLE_STATUS+0x110>
    800045dc:	0009059b          	sext.w	a1,s2
    800045e0:	00004517          	auipc	a0,0x4
    800045e4:	d7050513          	addi	a0,a0,-656 # 80008350 <CONSOLE_STATUS+0x340>
    800045e8:	ffffe097          	auipc	ra,0xffffe
    800045ec:	588080e7          	jalr	1416(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n",10);
    800045f0:	00a00693          	li	a3,10
    800045f4:	00004617          	auipc	a2,0x4
    800045f8:	b2c60613          	addi	a2,a2,-1236 # 80008120 <CONSOLE_STATUS+0x110>
    800045fc:	01892583          	lw	a1,24(s2)
    80004600:	00004517          	auipc	a0,0x4
    80004604:	d6050513          	addi	a0,a0,-672 # 80008360 <CONSOLE_STATUS+0x350>
    80004608:	ffffe097          	auipc	ra,0xffffe
    8000460c:	568080e7          	jalr	1384(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n",10);
    80004610:	00a00693          	li	a3,10
    80004614:	00004617          	auipc	a2,0x4
    80004618:	b0c60613          	addi	a2,a2,-1268 # 80008120 <CONSOLE_STATUS+0x110>
    8000461c:	01092583          	lw	a1,16(s2)
    80004620:	00004517          	auipc	a0,0x4
    80004624:	d5850513          	addi	a0,a0,-680 # 80008378 <CONSOLE_STATUS+0x368>
    80004628:	ffffe097          	auipc	ra,0xffffe
    8000462c:	548080e7          	jalr	1352(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n",10);
    80004630:	00a00693          	li	a3,10
    80004634:	00004617          	auipc	a2,0x4
    80004638:	aec60613          	addi	a2,a2,-1300 # 80008120 <CONSOLE_STATUS+0x110>
    8000463c:	0b000593          	li	a1,176
    80004640:	00004517          	auipc	a0,0x4
    80004644:	d5050513          	addi	a0,a0,-688 # 80008390 <CONSOLE_STATUS+0x380>
    80004648:	ffffe097          	auipc	ra,0xffffe
    8000464c:	528080e7          	jalr	1320(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    80004650:	01000693          	li	a3,16
    80004654:	00004617          	auipc	a2,0x4
    80004658:	acc60613          	addi	a2,a2,-1332 # 80008120 <CONSOLE_STATUS+0x110>
    8000465c:	0a092583          	lw	a1,160(s2)
    80004660:	00004517          	auipc	a0,0x4
    80004664:	d4850513          	addi	a0,a0,-696 # 800083a8 <CONSOLE_STATUS+0x398>
    80004668:	ffffe097          	auipc	ra,0xffffe
    8000466c:	508080e7          	jalr	1288(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array: ");
    80004670:	00004517          	auipc	a0,0x4
    80004674:	d4850513          	addi	a0,a0,-696 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80004678:	ffffe097          	auipc	ra,0xffffe
    8000467c:	3d8080e7          	jalr	984(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)>>3; i++) {
    80004680:	00000493          	li	s1,0
    80004684:	02c0006f          	j	800046b0 <_ZN13SlabAllocator9printSlabEP4Slab+0x110>
            ConsoleUtil::print("", slab->allocated[i], " ");
    80004688:	009907b3          	add	a5,s2,s1
    8000468c:	01000693          	li	a3,16
    80004690:	00004617          	auipc	a2,0x4
    80004694:	d9860613          	addi	a2,a2,-616 # 80008428 <CONSOLE_STATUS+0x418>
    80004698:	0207c583          	lbu	a1,32(a5)
    8000469c:	00004517          	auipc	a0,0x4
    800046a0:	adc50513          	addi	a0,a0,-1316 # 80008178 <CONSOLE_STATUS+0x168>
    800046a4:	ffffe097          	auipc	ra,0xffffe
    800046a8:	4cc080e7          	jalr	1228(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)>>3; i++) {
    800046ac:	00148493          	addi	s1,s1,1
    800046b0:	01893783          	ld	a5,24(s2)
    800046b4:	00778793          	addi	a5,a5,7
    800046b8:	0037d793          	srli	a5,a5,0x3
    800046bc:	fcf4e6e3          	bltu	s1,a5,80004688 <_ZN13SlabAllocator9printSlabEP4Slab+0xe8>
        }
        ConsoleUtil::printString("\n");
    800046c0:	00004517          	auipc	a0,0x4
    800046c4:	a6050513          	addi	a0,a0,-1440 # 80008120 <CONSOLE_STATUS+0x110>
    800046c8:	ffffe097          	auipc	ra,0xffffe
    800046cc:	388080e7          	jalr	904(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    800046d0:	01813083          	ld	ra,24(sp)
    800046d4:	01013403          	ld	s0,16(sp)
    800046d8:	00813483          	ld	s1,8(sp)
    800046dc:	00013903          	ld	s2,0(sp)
    800046e0:	02010113          	addi	sp,sp,32
    800046e4:	00008067          	ret
    800046e8:	00008067          	ret

00000000800046ec <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    if(cache) {
    800046ec:	1e050a63          	beqz	a0,800048e0 <_ZN13SlabAllocator10printCacheEP5Cache+0x1f4>
void SlabAllocator::printCache(Cache *cache) {
    800046f0:	fe010113          	addi	sp,sp,-32
    800046f4:	00113c23          	sd	ra,24(sp)
    800046f8:	00813823          	sd	s0,16(sp)
    800046fc:	00913423          	sd	s1,8(sp)
    80004700:	01213023          	sd	s2,0(sp)
    80004704:	02010413          	addi	s0,sp,32
    80004708:	00050913          	mv	s2,a0
        ConsoleUtil::printString("\nNOW SHOWING CACHE INFO\n");
    8000470c:	00004517          	auipc	a0,0x4
    80004710:	ccc50513          	addi	a0,a0,-820 # 800083d8 <CONSOLE_STATUS+0x3c8>
    80004714:	ffffe097          	auipc	ra,0xffffe
    80004718:	33c080e7          	jalr	828(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Cache name: ");
    8000471c:	00004517          	auipc	a0,0x4
    80004720:	cdc50513          	addi	a0,a0,-804 # 800083f8 <CONSOLE_STATUS+0x3e8>
    80004724:	ffffe097          	auipc	ra,0xffffe
    80004728:	32c080e7          	jalr	812(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString(cache->name);
    8000472c:	00090513          	mv	a0,s2
    80004730:	ffffe097          	auipc	ra,0xffffe
    80004734:	320080e7          	jalr	800(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("\n");
    80004738:	00004517          	auipc	a0,0x4
    8000473c:	9e850513          	addi	a0,a0,-1560 # 80008120 <CONSOLE_STATUS+0x110>
    80004740:	ffffe097          	auipc	ra,0xffffe
    80004744:	310080e7          	jalr	784(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("Cache address: ", (uint64) cache, "\n");
    80004748:	01000693          	li	a3,16
    8000474c:	00004617          	auipc	a2,0x4
    80004750:	9d460613          	addi	a2,a2,-1580 # 80008120 <CONSOLE_STATUS+0x110>
    80004754:	0009059b          	sext.w	a1,s2
    80004758:	00004517          	auipc	a0,0x4
    8000475c:	cb050513          	addi	a0,a0,-848 # 80008408 <CONSOLE_STATUS+0x3f8>
    80004760:	ffffe097          	auipc	ra,0xffffe
    80004764:	410080e7          	jalr	1040(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Cache slab size: ", (uint64) cache->slabSize, "\n", 10);
    80004768:	00a00693          	li	a3,10
    8000476c:	00004617          	auipc	a2,0x4
    80004770:	9b460613          	addi	a2,a2,-1612 # 80008120 <CONSOLE_STATUS+0x110>
    80004774:	04892583          	lw	a1,72(s2)
    80004778:	00004517          	auipc	a0,0x4
    8000477c:	ca050513          	addi	a0,a0,-864 # 80008418 <CONSOLE_STATUS+0x408>
    80004780:	ffffe097          	auipc	ra,0xffffe
    80004784:	3f0080e7          	jalr	1008(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Cache object size: ", (uint64) cache->objectSize, "\n", 10);
    80004788:	00a00693          	li	a3,10
    8000478c:	00004617          	auipc	a2,0x4
    80004790:	99460613          	addi	a2,a2,-1644 # 80008120 <CONSOLE_STATUS+0x110>
    80004794:	04092583          	lw	a1,64(s2)
    80004798:	00004517          	auipc	a0,0x4
    8000479c:	c9850513          	addi	a0,a0,-872 # 80008430 <CONSOLE_STATUS+0x420>
    800047a0:	ffffe097          	auipc	ra,0xffffe
    800047a4:	3d0080e7          	jalr	976(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Empty head: ", (uint64) cache->emptyHead, "\n");
    800047a8:	01000693          	li	a3,16
    800047ac:	00004617          	auipc	a2,0x4
    800047b0:	97460613          	addi	a2,a2,-1676 # 80008120 <CONSOLE_STATUS+0x110>
    800047b4:	06892583          	lw	a1,104(s2)
    800047b8:	00004517          	auipc	a0,0x4
    800047bc:	c9050513          	addi	a0,a0,-880 # 80008448 <CONSOLE_STATUS+0x438>
    800047c0:	ffffe097          	auipc	ra,0xffffe
    800047c4:	3b0080e7          	jalr	944(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>

        Slab *iter = cache->emptyHead;
    800047c8:	06893483          	ld	s1,104(s2)
    800047cc:	0280006f          	j	800047f4 <_ZN13SlabAllocator10printCacheEP5Cache+0x108>
        while (iter) {
            ConsoleUtil::print("", (uint64) iter, " ");
    800047d0:	01000693          	li	a3,16
    800047d4:	00004617          	auipc	a2,0x4
    800047d8:	c5460613          	addi	a2,a2,-940 # 80008428 <CONSOLE_STATUS+0x418>
    800047dc:	0004859b          	sext.w	a1,s1
    800047e0:	00004517          	auipc	a0,0x4
    800047e4:	99850513          	addi	a0,a0,-1640 # 80008178 <CONSOLE_STATUS+0x168>
    800047e8:	ffffe097          	auipc	ra,0xffffe
    800047ec:	388080e7          	jalr	904(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
            iter = iter->next;
    800047f0:	0084b483          	ld	s1,8(s1)
        while (iter) {
    800047f4:	fc049ee3          	bnez	s1,800047d0 <_ZN13SlabAllocator10printCacheEP5Cache+0xe4>
        }
        ConsoleUtil::printString("\n");
    800047f8:	00004517          	auipc	a0,0x4
    800047fc:	92850513          	addi	a0,a0,-1752 # 80008120 <CONSOLE_STATUS+0x110>
    80004800:	ffffe097          	auipc	ra,0xffffe
    80004804:	250080e7          	jalr	592(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>

        ConsoleUtil::print("Partial head: ", (uint64) cache->partialHead, "\n");
    80004808:	01000693          	li	a3,16
    8000480c:	00004617          	auipc	a2,0x4
    80004810:	91460613          	addi	a2,a2,-1772 # 80008120 <CONSOLE_STATUS+0x110>
    80004814:	07092583          	lw	a1,112(s2)
    80004818:	00004517          	auipc	a0,0x4
    8000481c:	c4050513          	addi	a0,a0,-960 # 80008458 <CONSOLE_STATUS+0x448>
    80004820:	ffffe097          	auipc	ra,0xffffe
    80004824:	350080e7          	jalr	848(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>

        iter = cache->partialHead;
    80004828:	07093483          	ld	s1,112(s2)
        while (iter) {
    8000482c:	02048663          	beqz	s1,80004858 <_ZN13SlabAllocator10printCacheEP5Cache+0x16c>
            ConsoleUtil::print("", (uint64) iter, " ");
    80004830:	01000693          	li	a3,16
    80004834:	00004617          	auipc	a2,0x4
    80004838:	bf460613          	addi	a2,a2,-1036 # 80008428 <CONSOLE_STATUS+0x418>
    8000483c:	0004859b          	sext.w	a1,s1
    80004840:	00004517          	auipc	a0,0x4
    80004844:	93850513          	addi	a0,a0,-1736 # 80008178 <CONSOLE_STATUS+0x168>
    80004848:	ffffe097          	auipc	ra,0xffffe
    8000484c:	328080e7          	jalr	808(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
            iter = iter->next;
    80004850:	0084b483          	ld	s1,8(s1)
        while (iter) {
    80004854:	fd9ff06f          	j	8000482c <_ZN13SlabAllocator10printCacheEP5Cache+0x140>
        }
        ConsoleUtil::printString("\n");
    80004858:	00004517          	auipc	a0,0x4
    8000485c:	8c850513          	addi	a0,a0,-1848 # 80008120 <CONSOLE_STATUS+0x110>
    80004860:	ffffe097          	auipc	ra,0xffffe
    80004864:	1f0080e7          	jalr	496(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>

        ConsoleUtil::print("Full head: ", (uint64) cache->fullHead, "\n");
    80004868:	01000693          	li	a3,16
    8000486c:	00004617          	auipc	a2,0x4
    80004870:	8b460613          	addi	a2,a2,-1868 # 80008120 <CONSOLE_STATUS+0x110>
    80004874:	07892583          	lw	a1,120(s2)
    80004878:	00004517          	auipc	a0,0x4
    8000487c:	bf050513          	addi	a0,a0,-1040 # 80008468 <CONSOLE_STATUS+0x458>
    80004880:	ffffe097          	auipc	ra,0xffffe
    80004884:	2f0080e7          	jalr	752(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>

        iter = cache->fullHead;
    80004888:	07893483          	ld	s1,120(s2)
    8000488c:	0280006f          	j	800048b4 <_ZN13SlabAllocator10printCacheEP5Cache+0x1c8>
        while (iter) {
            ConsoleUtil::print("", (uint64) iter, " ");
    80004890:	01000693          	li	a3,16
    80004894:	00004617          	auipc	a2,0x4
    80004898:	b9460613          	addi	a2,a2,-1132 # 80008428 <CONSOLE_STATUS+0x418>
    8000489c:	0004859b          	sext.w	a1,s1
    800048a0:	00004517          	auipc	a0,0x4
    800048a4:	8d850513          	addi	a0,a0,-1832 # 80008178 <CONSOLE_STATUS+0x168>
    800048a8:	ffffe097          	auipc	ra,0xffffe
    800048ac:	2c8080e7          	jalr	712(ra) # 80002b70 <_ZN11ConsoleUtil5printEPKciS1_i>
            iter = iter->next;
    800048b0:	0084b483          	ld	s1,8(s1)
        while (iter) {
    800048b4:	fc049ee3          	bnez	s1,80004890 <_ZN13SlabAllocator10printCacheEP5Cache+0x1a4>
        }
        ConsoleUtil::printString("\n");
    800048b8:	00004517          	auipc	a0,0x4
    800048bc:	86850513          	addi	a0,a0,-1944 # 80008120 <CONSOLE_STATUS+0x110>
    800048c0:	ffffe097          	auipc	ra,0xffffe
    800048c4:	190080e7          	jalr	400(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    800048c8:	01813083          	ld	ra,24(sp)
    800048cc:	01013403          	ld	s0,16(sp)
    800048d0:	00813483          	ld	s1,8(sp)
    800048d4:	00013903          	ld	s2,0(sp)
    800048d8:	02010113          	addi	sp,sp,32
    800048dc:	00008067          	ret
    800048e0:	00008067          	ret

00000000800048e4 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    800048e4:	ff010113          	addi	sp,sp,-16
    800048e8:	00813423          	sd	s0,8(sp)
    800048ec:	01010413          	addi	s0,sp,16
    slab->next = head;
    800048f0:	00053783          	ld	a5,0(a0)
    800048f4:	00f5b423          	sd	a5,8(a1)
    if(head)
    800048f8:	00078463          	beqz	a5,80004900 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    800048fc:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    80004900:	0005b023          	sd	zero,0(a1)
    head = slab;
    80004904:	00b53023          	sd	a1,0(a0)
}
    80004908:	00813403          	ld	s0,8(sp)
    8000490c:	01010113          	addi	sp,sp,16
    80004910:	00008067          	ret

0000000080004914 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    80004914:	fd010113          	addi	sp,sp,-48
    80004918:	02113423          	sd	ra,40(sp)
    8000491c:	02813023          	sd	s0,32(sp)
    80004920:	00913c23          	sd	s1,24(sp)
    80004924:	01213823          	sd	s2,16(sp)
    80004928:	01313423          	sd	s3,8(sp)
    8000492c:	03010413          	addi	s0,sp,48
    80004930:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    80004934:	04853503          	ld	a0,72(a0)
    80004938:	ffffd097          	auipc	ra,0xffffd
    8000493c:	448080e7          	jalr	1096(ra) # 80001d80 <_ZN5Buddy5allocEm>
    if(!slab) {
    80004940:	08050063          	beqz	a0,800049c0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xac>
    80004944:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80004948:	00050593          	mv	a1,a0
    8000494c:	06898513          	addi	a0,s3,104
    80004950:	00000097          	auipc	ra,0x0
    80004954:	f94080e7          	jalr	-108(ra) # 800048e4 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80004958:	0489b703          	ld	a4,72(s3)
    8000495c:	00100793          	li	a5,1
    80004960:	00e797bb          	sllw	a5,a5,a4
    80004964:	00c7979b          	slliw	a5,a5,0xc
    80004968:	f5078793          	addi	a5,a5,-176
    8000496c:	0409b703          	ld	a4,64(s3)
    80004970:	02e7d7b3          	divu	a5,a5,a4
    80004974:	00f4b823          	sd	a5,16(s1)
    80004978:	00f4bc23          	sd	a5,24(s1)
    if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
    8000497c:	40000713          	li	a4,1024
    80004980:	00f77863          	bgeu	a4,a5,80004990 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x7c>
        slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    80004984:	40000793          	li	a5,1024
    80004988:	00f4b823          	sd	a5,16(s1)
    8000498c:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab));
    80004990:	0b048793          	addi	a5,s1,176
    80004994:	0af4b023          	sd	a5,160(s1)
    slab->parent = cache;
    80004998:	0b34b423          	sd	s3,168(s1)
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
    8000499c:	00000713          	li	a4,0
    800049a0:	0184b783          	ld	a5,24(s1)
    800049a4:	00778793          	addi	a5,a5,7
    800049a8:	0037d793          	srli	a5,a5,0x3
    800049ac:	02f77263          	bgeu	a4,a5,800049d0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xbc>
        slab->allocated[i] = 0;
    800049b0:	00e487b3          	add	a5,s1,a4
    800049b4:	02078023          	sb	zero,32(a5)
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
    800049b8:	00170713          	addi	a4,a4,1
    800049bc:	fe5ff06f          	j	800049a0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x8c>
        cache->errCode = 2;
    800049c0:	00200793          	li	a5,2
    800049c4:	04f9b823          	sd	a5,80(s3)
        return false;
    800049c8:	00000513          	li	a0,0
    800049cc:	0480006f          	j	80004a14 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x100>
    if(cache->ctor) {
    800049d0:	0589b783          	ld	a5,88(s3)
    800049d4:	02078a63          	beqz	a5,80004a08 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800049d8:	00000913          	li	s2,0
    800049dc:	0184b783          	ld	a5,24(s1)
    800049e0:	02f97863          	bgeu	s2,a5,80004a10 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xfc>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800049e4:	0589b703          	ld	a4,88(s3)
    800049e8:	0a04b503          	ld	a0,160(s1)
    800049ec:	0a84b783          	ld	a5,168(s1)
    800049f0:	0407b783          	ld	a5,64(a5)
    800049f4:	032787b3          	mul	a5,a5,s2
    800049f8:	00f50533          	add	a0,a0,a5
    800049fc:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004a00:	00190913          	addi	s2,s2,1
    80004a04:	fd9ff06f          	j	800049dc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xc8>
    return true;
    80004a08:	00100513          	li	a0,1
    80004a0c:	0080006f          	j	80004a14 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x100>
    80004a10:	00100513          	li	a0,1
}
    80004a14:	02813083          	ld	ra,40(sp)
    80004a18:	02013403          	ld	s0,32(sp)
    80004a1c:	01813483          	ld	s1,24(sp)
    80004a20:	01013903          	ld	s2,16(sp)
    80004a24:	00813983          	ld	s3,8(sp)
    80004a28:	03010113          	addi	sp,sp,48
    80004a2c:	00008067          	ret

0000000080004a30 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80004a30:	ff010113          	addi	sp,sp,-16
    80004a34:	00813423          	sd	s0,8(sp)
    80004a38:	01010413          	addi	s0,sp,16
    if(slab == head)
    80004a3c:	00053783          	ld	a5,0(a0)
    80004a40:	02b78c63          	beq	a5,a1,80004a78 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80004a44:	0085b783          	ld	a5,8(a1)
    80004a48:	00078663          	beqz	a5,80004a54 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    80004a4c:	0005b703          	ld	a4,0(a1)
    80004a50:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80004a54:	0005b783          	ld	a5,0(a1)
    80004a58:	00078663          	beqz	a5,80004a64 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    80004a5c:	0085b703          	ld	a4,8(a1)
    80004a60:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80004a64:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80004a68:	0005b423          	sd	zero,8(a1)
}
    80004a6c:	00813403          	ld	s0,8(sp)
    80004a70:	01010113          	addi	sp,sp,16
    80004a74:	00008067          	ret
        head = slab->next;
    80004a78:	0085b783          	ld	a5,8(a1)
    80004a7c:	00f53023          	sd	a5,0(a0)
    80004a80:	fc5ff06f          	j	80004a44 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

0000000080004a84 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    80004a84:	fe010113          	addi	sp,sp,-32
    80004a88:	00113c23          	sd	ra,24(sp)
    80004a8c:	00813823          	sd	s0,16(sp)
    80004a90:	00913423          	sd	s1,8(sp)
    80004a94:	01213023          	sd	s2,0(sp)
    80004a98:	02010413          	addi	s0,sp,32
    80004a9c:	00058913          	mv	s2,a1
    80004aa0:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    80004aa4:	00060593          	mv	a1,a2
    80004aa8:	00000097          	auipc	ra,0x0
    80004aac:	f88080e7          	jalr	-120(ra) # 80004a30 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    80004ab0:	00048593          	mv	a1,s1
    80004ab4:	00090513          	mv	a0,s2
    80004ab8:	00000097          	auipc	ra,0x0
    80004abc:	e2c080e7          	jalr	-468(ra) # 800048e4 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
}
    80004ac0:	01813083          	ld	ra,24(sp)
    80004ac4:	01013403          	ld	s0,16(sp)
    80004ac8:	00813483          	ld	s1,8(sp)
    80004acc:	00013903          	ld	s2,0(sp)
    80004ad0:	02010113          	addi	sp,sp,32
    80004ad4:	00008067          	ret

0000000080004ad8 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    80004ad8:	fe010113          	addi	sp,sp,-32
    80004adc:	00113c23          	sd	ra,24(sp)
    80004ae0:	00813823          	sd	s0,16(sp)
    80004ae4:	00913423          	sd	s1,8(sp)
    80004ae8:	01213023          	sd	s2,0(sp)
    80004aec:	02010413          	addi	s0,sp,32
    80004af0:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80004af4:	00000493          	li	s1,0
    80004af8:	01893683          	ld	a3,24(s2)
    80004afc:	0ad4f663          	bgeu	s1,a3,80004ba8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd0>
        if(!(slab->allocated[i>>3] & (1<<(7 - (i&7))))){
    80004b00:	0034d613          	srli	a2,s1,0x3
    80004b04:	00c907b3          	add	a5,s2,a2
    80004b08:	0207c583          	lbu	a1,32(a5)
    80004b0c:	fff4c793          	not	a5,s1
    80004b10:	0077f793          	andi	a5,a5,7
    80004b14:	40f5d73b          	sraw	a4,a1,a5
    80004b18:	00177713          	andi	a4,a4,1
    80004b1c:	00070663          	beqz	a4,80004b28 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x50>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80004b20:	00148493          	addi	s1,s1,1
    80004b24:	fd5ff06f          	j	80004af8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i>>3] |= (1<<(7 - (i&7)));
    80004b28:	00100713          	li	a4,1
    80004b2c:	00f717bb          	sllw	a5,a4,a5
    80004b30:	00c90633          	add	a2,s2,a2
    80004b34:	00f5e5b3          	or	a1,a1,a5
    80004b38:	02b60023          	sb	a1,32(a2)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80004b3c:	01093783          	ld	a5,16(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004b40:	04f68863          	beq	a3,a5,80004b90 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb8>
    80004b44:	0a893503          	ld	a0,168(s2)
    80004b48:	07050513          	addi	a0,a0,112
            slab->numOfFreeSlots--;
    80004b4c:	fff78793          	addi	a5,a5,-1
    80004b50:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004b54:	04079463          	bnez	a5,80004b9c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc4>
    80004b58:	0a893583          	ld	a1,168(s2)
    80004b5c:	07858593          	addi	a1,a1,120
            if(headTo != headFrom)
    80004b60:	0005b703          	ld	a4,0(a1)
    80004b64:	00053783          	ld	a5,0(a0)
    80004b68:	00f70863          	beq	a4,a5,80004b78 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa0>
                SlabAllocator::move(headFrom, headTo, slab);
    80004b6c:	00090613          	mv	a2,s2
    80004b70:	00000097          	auipc	ra,0x0
    80004b74:	f14080e7          	jalr	-236(ra) # 80004a84 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    80004b78:	0a093503          	ld	a0,160(s2)
    80004b7c:	0a893783          	ld	a5,168(s2)
    80004b80:	0407b783          	ld	a5,64(a5)
    80004b84:	029784b3          	mul	s1,a5,s1
    80004b88:	00950533          	add	a0,a0,s1
    80004b8c:	02c0006f          	j	80004bb8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xe0>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80004b90:	0a893503          	ld	a0,168(s2)
    80004b94:	06850513          	addi	a0,a0,104
    80004b98:	fb5ff06f          	j	80004b4c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x74>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80004b9c:	0a893583          	ld	a1,168(s2)
    80004ba0:	07058593          	addi	a1,a1,112
    80004ba4:	fbdff06f          	j	80004b60 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x88>
    slab->parent->errCode = 1;
    80004ba8:	0a893783          	ld	a5,168(s2)
    80004bac:	00100713          	li	a4,1
    80004bb0:	04e7b823          	sd	a4,80(a5)
    return nullptr;
    80004bb4:	00000513          	li	a0,0
}
    80004bb8:	01813083          	ld	ra,24(sp)
    80004bbc:	01013403          	ld	s0,16(sp)
    80004bc0:	00813483          	ld	s1,8(sp)
    80004bc4:	00013903          	ld	s2,0(sp)
    80004bc8:	02010113          	addi	sp,sp,32
    80004bcc:	00008067          	ret

0000000080004bd0 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    80004bd0:	fd010113          	addi	sp,sp,-48
    80004bd4:	02113423          	sd	ra,40(sp)
    80004bd8:	02813023          	sd	s0,32(sp)
    80004bdc:	00913c23          	sd	s1,24(sp)
    80004be0:	01213823          	sd	s2,16(sp)
    80004be4:	01313423          	sd	s3,8(sp)
    80004be8:	03010413          	addi	s0,sp,48
    80004bec:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    80004bf0:	07053483          	ld	s1,112(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    80004bf4:	00048c63          	beqz	s1,80004c0c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
            void* ret = allocateSlot(head);
    80004bf8:	00048513          	mv	a0,s1
    80004bfc:	00000097          	auipc	ra,0x0
    80004c00:	edc080e7          	jalr	-292(ra) # 80004ad8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80004c04:	fe0508e3          	beqz	a0,80004bf4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x24>
                return ret;
    80004c08:	00050493          	mv	s1,a0
    if(ret){
    80004c0c:	02048263          	beqz	s1,80004c30 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x60>
}
    80004c10:	00048513          	mv	a0,s1
    80004c14:	02813083          	ld	ra,40(sp)
    80004c18:	02013403          	ld	s0,32(sp)
    80004c1c:	01813483          	ld	s1,24(sp)
    80004c20:	01013903          	ld	s2,16(sp)
    80004c24:	00813983          	ld	s3,8(sp)
    80004c28:	03010113          	addi	sp,sp,48
    80004c2c:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80004c30:	06893483          	ld	s1,104(s2)
        while(head != nullptr){
    80004c34:	00048c63          	beqz	s1,80004c4c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x7c>
            void* ret = allocateSlot(head);
    80004c38:	00048513          	mv	a0,s1
    80004c3c:	00000097          	auipc	ra,0x0
    80004c40:	e9c080e7          	jalr	-356(ra) # 80004ad8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80004c44:	fe0508e3          	beqz	a0,80004c34 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x64>
                return ret;
    80004c48:	00050493          	mv	s1,a0
    if(ret){
    80004c4c:	fc0492e3          	bnez	s1,80004c10 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
    if(cache->objectSize <= sizeof(Slab)) {
    80004c50:	04093703          	ld	a4,64(s2)
    80004c54:	0b000793          	li	a5,176
    80004c58:	02e7e463          	bltu	a5,a4,80004c80 <_ZN13SlabAllocator14allocateObjectEP5Cache+0xb0>
        if (!SlabAllocator::allocateSlab(cache))
    80004c5c:	00090513          	mv	a0,s2
    80004c60:	00000097          	auipc	ra,0x0
    80004c64:	cb4080e7          	jalr	-844(ra) # 80004914 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80004c68:	fa0504e3          	beqz	a0,80004c10 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80004c6c:	06893503          	ld	a0,104(s2)
    80004c70:	00000097          	auipc	ra,0x0
    80004c74:	e68080e7          	jalr	-408(ra) # 80004ad8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80004c78:	00050493          	mv	s1,a0
    80004c7c:	f95ff06f          	j	80004c10 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>
        Slab* slab = (Slab*)SlabAllocator::allocateObject(largeSlabCache);
    80004c80:	00006517          	auipc	a0,0x6
    80004c84:	61853503          	ld	a0,1560(a0) # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    80004c88:	00000097          	auipc	ra,0x0
    80004c8c:	f48080e7          	jalr	-184(ra) # 80004bd0 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80004c90:	00050493          	mv	s1,a0
        slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS)) / cache->objectSize;
    80004c94:	04893703          	ld	a4,72(s2)
    80004c98:	00100793          	li	a5,1
    80004c9c:	00e797bb          	sllw	a5,a5,a4
    80004ca0:	00c7979b          	slliw	a5,a5,0xc
    80004ca4:	04093703          	ld	a4,64(s2)
    80004ca8:	02e7d7b3          	divu	a5,a5,a4
    80004cac:	00f53823          	sd	a5,16(a0)
    80004cb0:	00f53c23          	sd	a5,24(a0)
        if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
    80004cb4:	40000713          	li	a4,1024
    80004cb8:	00f77863          	bgeu	a4,a5,80004cc8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0xf8>
            slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    80004cbc:	40000793          	li	a5,1024
    80004cc0:	00f53823          	sd	a5,16(a0)
    80004cc4:	00f53c23          	sd	a5,24(a0)
        void* slabOffset = Buddy::alloc(cache->slabSize);
    80004cc8:	04893503          	ld	a0,72(s2)
    80004ccc:	ffffd097          	auipc	ra,0xffffd
    80004cd0:	0b4080e7          	jalr	180(ra) # 80001d80 <_ZN5Buddy5allocEm>
        slab->objectOffset = slabOffset;
    80004cd4:	0aa4b023          	sd	a0,160(s1)
        slab->parent = cache;
    80004cd8:	0b24b423          	sd	s2,168(s1)
        slab->next = nullptr;
    80004cdc:	0004b423          	sd	zero,8(s1)
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
    80004ce0:	00000713          	li	a4,0
    80004ce4:	0184b783          	ld	a5,24(s1)
    80004ce8:	00778793          	addi	a5,a5,7
    80004cec:	0037d793          	srli	a5,a5,0x3
    80004cf0:	00f77a63          	bgeu	a4,a5,80004d04 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x134>
            slab->allocated[i] = 0;
    80004cf4:	00e487b3          	add	a5,s1,a4
    80004cf8:	02078023          	sb	zero,32(a5)
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
    80004cfc:	00170713          	addi	a4,a4,1
    80004d00:	fe5ff06f          	j	80004ce4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x114>
        if(cache->ctor) {
    80004d04:	05893783          	ld	a5,88(s2)
    80004d08:	02078a63          	beqz	a5,80004d3c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x16c>
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004d0c:	00000993          	li	s3,0
    80004d10:	0184b783          	ld	a5,24(s1)
    80004d14:	02f9f463          	bgeu	s3,a5,80004d3c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x16c>
                cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    80004d18:	05893703          	ld	a4,88(s2)
    80004d1c:	0a04b503          	ld	a0,160(s1)
    80004d20:	0a84b783          	ld	a5,168(s1)
    80004d24:	0407b783          	ld	a5,64(a5)
    80004d28:	033787b3          	mul	a5,a5,s3
    80004d2c:	00f50533          	add	a0,a0,a5
    80004d30:	000700e7          	jalr	a4
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80004d34:	00198993          	addi	s3,s3,1
    80004d38:	fd9ff06f          	j	80004d10 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x140>
        SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80004d3c:	00048593          	mv	a1,s1
    80004d40:	06890513          	addi	a0,s2,104
    80004d44:	00000097          	auipc	ra,0x0
    80004d48:	ba0080e7          	jalr	-1120(ra) # 800048e4 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80004d4c:	06893503          	ld	a0,104(s2)
    80004d50:	00000097          	auipc	ra,0x0
    80004d54:	d88080e7          	jalr	-632(ra) # 80004ad8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80004d58:	00050493          	mv	s1,a0
    80004d5c:	eb5ff06f          	j	80004c10 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x40>

0000000080004d60 <_ZN13SlabAllocator14allocateBufferEm>:
        num--;
    80004d60:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80004d64:	0017d513          	srli	a0,a5,0x1
    80004d68:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80004d6c:	0027d713          	srli	a4,a5,0x2
    80004d70:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80004d74:	0047d713          	srli	a4,a5,0x4
    80004d78:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80004d7c:	0087d713          	srli	a4,a5,0x8
    80004d80:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80004d84:	0107d713          	srli	a4,a5,0x10
    80004d88:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80004d8c:	0207d713          	srli	a4,a5,0x20
    80004d90:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80004d94:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80004d98:	00000713          	li	a4,0
        while(num>1){
    80004d9c:	00100693          	li	a3,1
    80004da0:	00f6f863          	bgeu	a3,a5,80004db0 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    80004da4:	0017d793          	srli	a5,a5,0x1
            deg++;
    80004da8:	00170713          	addi	a4,a4,1
        while(num>1){
    80004dac:	ff1ff06f          	j	80004d9c <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    80004db0:	ffb70713          	addi	a4,a4,-5
    80004db4:	00c00793          	li	a5,12
    80004db8:	04e7e063          	bltu	a5,a4,80004df8 <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    80004dbc:	ff010113          	addi	sp,sp,-16
    80004dc0:	00113423          	sd	ra,8(sp)
    80004dc4:	00813023          	sd	s0,0(sp)
    80004dc8:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    80004dcc:	00371713          	slli	a4,a4,0x3
    80004dd0:	00006797          	auipc	a5,0x6
    80004dd4:	4c878793          	addi	a5,a5,1224 # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    80004dd8:	00e78733          	add	a4,a5,a4
    80004ddc:	00873503          	ld	a0,8(a4)
    80004de0:	00000097          	auipc	ra,0x0
    80004de4:	df0080e7          	jalr	-528(ra) # 80004bd0 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004de8:	00813083          	ld	ra,8(sp)
    80004dec:	00013403          	ld	s0,0(sp)
    80004df0:	01010113          	addi	sp,sp,16
    80004df4:	00008067          	ret
        return nullptr;
    80004df8:	00000513          	li	a0,0
}
    80004dfc:	00008067          	ret

0000000080004e00 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80004e00:	fc010113          	addi	sp,sp,-64
    80004e04:	02113c23          	sd	ra,56(sp)
    80004e08:	02813823          	sd	s0,48(sp)
    80004e0c:	02913423          	sd	s1,40(sp)
    80004e10:	03213023          	sd	s2,32(sp)
    80004e14:	01313c23          	sd	s3,24(sp)
    80004e18:	01413823          	sd	s4,16(sp)
    80004e1c:	01513423          	sd	s5,8(sp)
    80004e20:	04010413          	addi	s0,sp,64
    80004e24:	00050a93          	mv	s5,a0
    80004e28:	00058493          	mv	s1,a1
    80004e2c:	00060a13          	mv	s4,a2
    80004e30:	00068993          	mv	s3,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80004e34:	00006517          	auipc	a0,0x6
    80004e38:	4d453503          	ld	a0,1236(a0) # 8000b308 <_ZN13SlabAllocator5cacheE>
    80004e3c:	00000097          	auipc	ra,0x0
    80004e40:	d94080e7          	jalr	-620(ra) # 80004bd0 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80004e44:	00050913          	mv	s2,a0
    if(ret == nullptr)
    80004e48:	08050e63          	beqz	a0,80004ee4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xe4>
    strcpy(name, ret->name);
    80004e4c:	00050593          	mv	a1,a0
    80004e50:	000a8513          	mv	a0,s5
    80004e54:	fffff097          	auipc	ra,0xfffff
    80004e58:	314080e7          	jalr	788(ra) # 80004168 <_Z6strcpyPKcPc>
    ret->ctor = ctor;
    80004e5c:	05493c23          	sd	s4,88(s2)
    ret->dtor = dtor;
    80004e60:	07393023          	sd	s3,96(s2)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80004e64:	06093c23          	sd	zero,120(s2)
    80004e68:	06093823          	sd	zero,112(s2)
    80004e6c:	06093423          	sd	zero,104(s2)
    ret->objectSize = size;
    80004e70:	04993023          	sd	s1,64(s2)
    ret->errCode = 0;
    80004e74:	04093823          	sd	zero,80(s2)
    if(size <= sizeof(Slab))
    80004e78:	0b000793          	li	a5,176
    80004e7c:	0097e863          	bltu	a5,s1,80004e8c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x8c>
        ret->slabSize = SMALL_CACHE_DEFAULT_SLAB_SIZE;
    80004e80:	00100793          	li	a5,1
    80004e84:	04f93423          	sd	a5,72(s2)
    80004e88:	05c0006f          	j	80004ee4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xe4>
        num--;
    80004e8c:	fff48793          	addi	a5,s1,-1
        num |= num>>1;
    80004e90:	0017d493          	srli	s1,a5,0x1
    80004e94:	0097e7b3          	or	a5,a5,s1
        num |= num>>2;
    80004e98:	0027d493          	srli	s1,a5,0x2
    80004e9c:	0097e7b3          	or	a5,a5,s1
        num |= num>>4;
    80004ea0:	0047d713          	srli	a4,a5,0x4
    80004ea4:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80004ea8:	0087d713          	srli	a4,a5,0x8
    80004eac:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80004eb0:	0107d713          	srli	a4,a5,0x10
    80004eb4:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80004eb8:	0207d713          	srli	a4,a5,0x20
    80004ebc:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80004ec0:	00178793          	addi	a5,a5,1
        uint64 deg = 0;
    80004ec4:	00000713          	li	a4,0
        while(num>1){
    80004ec8:	00100693          	li	a3,1
    80004ecc:	00f6f863          	bgeu	a3,a5,80004edc <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xdc>
            num/=2;
    80004ed0:	0017d793          	srli	a5,a5,0x1
            deg++;
    80004ed4:	00170713          	addi	a4,a4,1
        while(num>1){
    80004ed8:	ff1ff06f          	j	80004ec8 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xc8>
        ret->slabSize = Buddy::getDeg(Buddy::ceil(size))-10;
    80004edc:	ff670713          	addi	a4,a4,-10
    80004ee0:	04e93423          	sd	a4,72(s2)
}
    80004ee4:	00090513          	mv	a0,s2
    80004ee8:	03813083          	ld	ra,56(sp)
    80004eec:	03013403          	ld	s0,48(sp)
    80004ef0:	02813483          	ld	s1,40(sp)
    80004ef4:	02013903          	ld	s2,32(sp)
    80004ef8:	01813983          	ld	s3,24(sp)
    80004efc:	01013a03          	ld	s4,16(sp)
    80004f00:	00813a83          	ld	s5,8(sp)
    80004f04:	04010113          	addi	sp,sp,64
    80004f08:	00008067          	ret

0000000080004f0c <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80004f0c:	fe010113          	addi	sp,sp,-32
    80004f10:	00113c23          	sd	ra,24(sp)
    80004f14:	00813823          	sd	s0,16(sp)
    80004f18:	00913423          	sd	s1,8(sp)
    80004f1c:	01213023          	sd	s2,0(sp)
    80004f20:	02010413          	addi	s0,sp,32
    Buddy::initialize(space, blockNum);
    80004f24:	ffffd097          	auipc	ra,0xffffd
    80004f28:	a8c080e7          	jalr	-1396(ra) # 800019b0 <_ZN5Buddy10initializeEPvm>
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80004f2c:	00006917          	auipc	s2,0x6
    80004f30:	07493903          	ld	s2,116(s2) # 8000afa0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004f34:	00093583          	ld	a1,0(s2)
    80004f38:	00c5d593          	srli	a1,a1,0xc
    80004f3c:	00158593          	addi	a1,a1,1
    80004f40:	00c59593          	slli	a1,a1,0xc
    80004f44:	00006497          	auipc	s1,0x6
    80004f48:	35448493          	addi	s1,s1,852 # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    80004f4c:	06b4b823          	sd	a1,112(s1)
    cache->ctor = nullptr;
    80004f50:	0405bc23          	sd	zero,88(a1)
    cache->dtor = nullptr;
    80004f54:	0605b023          	sd	zero,96(a1)
    cache->emptyHead = nullptr;
    80004f58:	0605b423          	sd	zero,104(a1)
    cache->partialHead = nullptr;
    80004f5c:	0605b823          	sd	zero,112(a1)
    cache->fullHead = nullptr;
    80004f60:	0605bc23          	sd	zero,120(a1)
    cache->objectSize = sizeof(Cache);
    80004f64:	08000793          	li	a5,128
    80004f68:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80004f6c:	00200793          	li	a5,2
    80004f70:	04f5b423          	sd	a5,72(a1)
    cache->errCode = 0;
    80004f74:	0405b823          	sd	zero,80(a1)
    strcpy("Main Cache", cache->name);
    80004f78:	00003517          	auipc	a0,0x3
    80004f7c:	50050513          	addi	a0,a0,1280 # 80008478 <CONSOLE_STATUS+0x468>
    80004f80:	fffff097          	auipc	ra,0xfffff
    80004f84:	1e8080e7          	jalr	488(ra) # 80004168 <_Z6strcpyPKcPc>
    largeSlabCache = (Cache*)BUDDY_META_ADDR_CONST;
    80004f88:	00093783          	ld	a5,0(s2)
    80004f8c:	fffff737          	lui	a4,0xfffff
    80004f90:	00e7f7b3          	and	a5,a5,a4
    80004f94:	00f4b023          	sd	a5,0(s1)
    largeSlabCache->ctor = nullptr;
    80004f98:	0407bc23          	sd	zero,88(a5)
    largeSlabCache->dtor = nullptr;
    80004f9c:	0607b023          	sd	zero,96(a5)
    largeSlabCache->emptyHead = nullptr;
    80004fa0:	0607b423          	sd	zero,104(a5)
    largeSlabCache->partialHead = nullptr;
    80004fa4:	0607b823          	sd	zero,112(a5)
    largeSlabCache->fullHead = nullptr;
    80004fa8:	0607bc23          	sd	zero,120(a5)
    largeSlabCache->objectSize = sizeof(Slab);
    80004fac:	0b000713          	li	a4,176
    80004fb0:	04e7b023          	sd	a4,64(a5)
    largeSlabCache->slabSize = SLAB_HEADER_DEFAULT_SLAB_SIZE;
    80004fb4:	00400713          	li	a4,4
    80004fb8:	04e7b423          	sd	a4,72(a5)
    cache->errCode = 0;
    80004fbc:	0704b583          	ld	a1,112(s1)
    80004fc0:	0405b823          	sd	zero,80(a1)
    strcpy("Large Slab Cache", cache->name);
    80004fc4:	00003517          	auipc	a0,0x3
    80004fc8:	4c450513          	addi	a0,a0,1220 # 80008488 <CONSOLE_STATUS+0x478>
    80004fcc:	fffff097          	auipc	ra,0xfffff
    80004fd0:	19c080e7          	jalr	412(ra) # 80004168 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80004fd4:	00000493          	li	s1,0
    80004fd8:	0480006f          	j	80005020 <_ZN13SlabAllocator10initializeEPvm+0x114>
        sizeN[i] = SlabAllocator::createCache(names[i], 1<<(i+CACHE_LOWER_BOUND), nullptr, nullptr);
    80004fdc:	0054871b          	addiw	a4,s1,5
    80004fe0:	00349913          	slli	s2,s1,0x3
    80004fe4:	00006797          	auipc	a5,0x6
    80004fe8:	f3c78793          	addi	a5,a5,-196 # 8000af20 <_ZN13SlabAllocator5namesE>
    80004fec:	012787b3          	add	a5,a5,s2
    80004ff0:	00000693          	li	a3,0
    80004ff4:	00000613          	li	a2,0
    80004ff8:	00100593          	li	a1,1
    80004ffc:	00e595bb          	sllw	a1,a1,a4
    80005000:	0007b503          	ld	a0,0(a5)
    80005004:	00000097          	auipc	ra,0x0
    80005008:	dfc080e7          	jalr	-516(ra) # 80004e00 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    8000500c:	00006797          	auipc	a5,0x6
    80005010:	28c78793          	addi	a5,a5,652 # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    80005014:	012787b3          	add	a5,a5,s2
    80005018:	00a7b423          	sd	a0,8(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    8000501c:	0014849b          	addiw	s1,s1,1
    80005020:	00c00793          	li	a5,12
    80005024:	fa97dce3          	bge	a5,s1,80004fdc <_ZN13SlabAllocator10initializeEPvm+0xd0>
}
    80005028:	01813083          	ld	ra,24(sp)
    8000502c:	01013403          	ld	s0,16(sp)
    80005030:	00813483          	ld	s1,8(sp)
    80005034:	00013903          	ld	s2,0(sp)
    80005038:	02010113          	addi	sp,sp,32
    8000503c:	00008067          	ret

0000000080005040 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index>>3] & (1<<(7 - (index&7)))) {
    80005040:	0035d713          	srli	a4,a1,0x3
    80005044:	00e507b3          	add	a5,a0,a4
    80005048:	0207c683          	lbu	a3,32(a5)
    8000504c:	fff5c593          	not	a1,a1
    80005050:	0075f593          	andi	a1,a1,7
    80005054:	40b6d7bb          	sraw	a5,a3,a1
    80005058:	0017f793          	andi	a5,a5,1
    8000505c:	08078a63          	beqz	a5,800050f0 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb0>
    80005060:	00050613          	mv	a2,a0
        slab->allocated[index>>3] &= ~(1<<(7 - (index&7)));
    80005064:	00100793          	li	a5,1
    80005068:	00b795bb          	sllw	a1,a5,a1
    8000506c:	00e50733          	add	a4,a0,a4
    80005070:	fff5c593          	not	a1,a1
    80005074:	00d5f5b3          	and	a1,a1,a3
    80005078:	02b70023          	sb	a1,32(a4) # fffffffffffff020 <end+0xffffffff7ffee020>
    inline bool isFull(){return numOfFreeSlots == 0;}
    8000507c:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80005080:	04079c63          	bnez	a5,800050d8 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x98>
    80005084:	0a853503          	ld	a0,168(a0)
    80005088:	07850513          	addi	a0,a0,120
        slab->numOfFreeSlots++;
    8000508c:	00178793          	addi	a5,a5,1
    80005090:	00f63823          	sd	a5,16(a2)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80005094:	01863703          	ld	a4,24(a2)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80005098:	04e78663          	beq	a5,a4,800050e4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa4>
    8000509c:	0a863583          	ld	a1,168(a2)
    800050a0:	07058593          	addi	a1,a1,112
            if (headTo != headFrom)
    800050a4:	0005b703          	ld	a4,0(a1)
    800050a8:	00053783          	ld	a5,0(a0)
    800050ac:	04f70263          	beq	a4,a5,800050f0 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb0>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    800050b0:	ff010113          	addi	sp,sp,-16
    800050b4:	00113423          	sd	ra,8(sp)
    800050b8:	00813023          	sd	s0,0(sp)
    800050bc:	01010413          	addi	s0,sp,16
                SlabAllocator::move(headFrom, headTo, slab);
    800050c0:	00000097          	auipc	ra,0x0
    800050c4:	9c4080e7          	jalr	-1596(ra) # 80004a84 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    800050c8:	00813083          	ld	ra,8(sp)
    800050cc:	00013403          	ld	s0,0(sp)
    800050d0:	01010113          	addi	sp,sp,16
    800050d4:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800050d8:	0a853503          	ld	a0,168(a0)
    800050dc:	07050513          	addi	a0,a0,112
    800050e0:	fadff06f          	j	8000508c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x4c>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800050e4:	0a863583          	ld	a1,168(a2)
    800050e8:	06858593          	addi	a1,a1,104
    800050ec:	fb9ff06f          	j	800050a4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x64>
    800050f0:	00008067          	ret

00000000800050f4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    800050f4:	fe010113          	addi	sp,sp,-32
    800050f8:	00113c23          	sd	ra,24(sp)
    800050fc:	00813823          	sd	s0,16(sp)
    80005100:	00913423          	sd	s1,8(sp)
    80005104:	01213023          	sd	s2,0(sp)
    80005108:	02010413          	addi	s0,sp,32
    8000510c:	00050913          	mv	s2,a0
    80005110:	00058493          	mv	s1,a1
    if(cache->dtor)
    80005114:	06053783          	ld	a5,96(a0)
    80005118:	00078663          	beqz	a5,80005124 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    8000511c:	00058513          	mv	a0,a1
    80005120:	000780e7          	jalr	a5
    if(cache->ctor)
    80005124:	05893783          	ld	a5,88(s2)
    80005128:	00078663          	beqz	a5,80005134 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    8000512c:	00048513          	mv	a0,s1
    80005130:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80005134:	07893503          	ld	a0,120(s2)
    80005138:	0080006f          	j	80005140 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    8000513c:	00853503          	ld	a0,8(a0)
        while(head){
    80005140:	02050e63          	beqz	a0,8000517c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80005144:	0a053703          	ld	a4,160(a0)
    80005148:	01853783          	ld	a5,24(a0)
    8000514c:	0a853683          	ld	a3,168(a0)
    80005150:	0406b583          	ld	a1,64(a3)
    80005154:	02b787b3          	mul	a5,a5,a1
    80005158:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    8000515c:	fef4f0e3          	bgeu	s1,a5,8000513c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80005160:	fce4eee3          	bltu	s1,a4,8000513c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80005164:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80005168:	02b755b3          	divu	a1,a4,a1
    8000516c:	00000097          	auipc	ra,0x0
    80005170:	ed4080e7          	jalr	-300(ra) # 80005040 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80005174:	00100513          	li	a0,1
    80005178:	0080006f          	j	80005180 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    8000517c:	00000513          	li	a0,0
    if(deleted)
    80005180:	00050e63          	beqz	a0,8000519c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80005184:	01813083          	ld	ra,24(sp)
    80005188:	01013403          	ld	s0,16(sp)
    8000518c:	00813483          	ld	s1,8(sp)
    80005190:	00013903          	ld	s2,0(sp)
    80005194:	02010113          	addi	sp,sp,32
    80005198:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    8000519c:	07093783          	ld	a5,112(s2)
    800051a0:	0080006f          	j	800051a8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    800051a4:	0087b783          	ld	a5,8(a5)
        while(head){
    800051a8:	fc078ee3          	beqz	a5,80005184 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    800051ac:	0a07b683          	ld	a3,160(a5)
    800051b0:	0187b703          	ld	a4,24(a5)
    800051b4:	0a87b603          	ld	a2,168(a5)
    800051b8:	04063583          	ld	a1,64(a2)
    800051bc:	02b70733          	mul	a4,a4,a1
    800051c0:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    800051c4:	fee4f0e3          	bgeu	s1,a4,800051a4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    800051c8:	fcd4eee3          	bltu	s1,a3,800051a4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    800051cc:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    800051d0:	02b6d5b3          	divu	a1,a3,a1
    800051d4:	00078513          	mv	a0,a5
    800051d8:	00000097          	auipc	ra,0x0
    800051dc:	e68080e7          	jalr	-408(ra) # 80005040 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    800051e0:	00100513          	li	a0,1
    800051e4:	fa1ff06f          	j	80005184 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

00000000800051e8 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    800051e8:	fe010113          	addi	sp,sp,-32
    800051ec:	00113c23          	sd	ra,24(sp)
    800051f0:	00813823          	sd	s0,16(sp)
    800051f4:	00913423          	sd	s1,8(sp)
    800051f8:	01213023          	sd	s2,0(sp)
    800051fc:	02010413          	addi	s0,sp,32
    80005200:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80005204:	00000493          	li	s1,0
    80005208:	00c00793          	li	a5,12
    8000520c:	0297c863          	blt	a5,s1,8000523c <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80005210:	00349713          	slli	a4,s1,0x3
    80005214:	00006797          	auipc	a5,0x6
    80005218:	08478793          	addi	a5,a5,132 # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    8000521c:	00e787b3          	add	a5,a5,a4
    80005220:	00090593          	mv	a1,s2
    80005224:	0087b503          	ld	a0,8(a5)
    80005228:	00000097          	auipc	ra,0x0
    8000522c:	ecc080e7          	jalr	-308(ra) # 800050f4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80005230:	00051663          	bnez	a0,8000523c <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80005234:	0014849b          	addiw	s1,s1,1
    80005238:	fd1ff06f          	j	80005208 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    8000523c:	01813083          	ld	ra,24(sp)
    80005240:	01013403          	ld	s0,16(sp)
    80005244:	00813483          	ld	s1,8(sp)
    80005248:	00013903          	ld	s2,0(sp)
    8000524c:	02010113          	addi	sp,sp,32
    80005250:	00008067          	ret

0000000080005254 <_ZN13SlabAllocator11shrinkCacheEP5Cache>:
int SlabAllocator::shrinkCache(Cache *cache) {
    80005254:	fe010113          	addi	sp,sp,-32
    80005258:	00113c23          	sd	ra,24(sp)
    8000525c:	00813823          	sd	s0,16(sp)
    80005260:	00913423          	sd	s1,8(sp)
    80005264:	01213023          	sd	s2,0(sp)
    80005268:	02010413          	addi	s0,sp,32
    8000526c:	00050493          	mv	s1,a0
    int ret = 0;
    80005270:	00000913          	li	s2,0
    80005274:	0300006f          	j	800052a4 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x50>
            Buddy::free(cache->emptyHead->objectOffset, cache->slabSize);
    80005278:	0a053503          	ld	a0,160(a0)
    8000527c:	ffffd097          	auipc	ra,0xffffd
    80005280:	a2c080e7          	jalr	-1492(ra) # 80001ca8 <_ZN5Buddy4freeEPvm>
            SlabAllocator::freeObject(largeSlabCache, cache->emptyHead);
    80005284:	0684b583          	ld	a1,104(s1)
    80005288:	00006517          	auipc	a0,0x6
    8000528c:	01053503          	ld	a0,16(a0) # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    80005290:	00000097          	auipc	ra,0x0
    80005294:	e64080e7          	jalr	-412(ra) # 800050f4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
        cache->emptyHead = cache->emptyHead->next;
    80005298:	0684b783          	ld	a5,104(s1)
    8000529c:	0087b783          	ld	a5,8(a5)
    800052a0:	06f4b423          	sd	a5,104(s1)
    while(cache->emptyHead){
    800052a4:	0684b503          	ld	a0,104(s1)
    800052a8:	02050663          	beqz	a0,800052d4 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x80>
        ret += (1<<cache->slabSize);
    800052ac:	0484b583          	ld	a1,72(s1)
    800052b0:	00100793          	li	a5,1
    800052b4:	00b797bb          	sllw	a5,a5,a1
    800052b8:	0127893b          	addw	s2,a5,s2
        if(cache->objectSize <= sizeof(Slab)) {
    800052bc:	0404b703          	ld	a4,64(s1)
    800052c0:	0b000793          	li	a5,176
    800052c4:	fae7eae3          	bltu	a5,a4,80005278 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x24>
            Buddy::free(cache->emptyHead, cache->slabSize);
    800052c8:	ffffd097          	auipc	ra,0xffffd
    800052cc:	9e0080e7          	jalr	-1568(ra) # 80001ca8 <_ZN5Buddy4freeEPvm>
    800052d0:	fc9ff06f          	j	80005298 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x44>
}
    800052d4:	00090513          	mv	a0,s2
    800052d8:	01813083          	ld	ra,24(sp)
    800052dc:	01013403          	ld	s0,16(sp)
    800052e0:	00813483          	ld	s1,8(sp)
    800052e4:	00013903          	ld	s2,0(sp)
    800052e8:	02010113          	addi	sp,sp,32
    800052ec:	00008067          	ret

00000000800052f0 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    800052f0:	fe010113          	addi	sp,sp,-32
    800052f4:	00113c23          	sd	ra,24(sp)
    800052f8:	00813823          	sd	s0,16(sp)
    800052fc:	00913423          	sd	s1,8(sp)
    80005300:	01213023          	sd	s2,0(sp)
    80005304:	02010413          	addi	s0,sp,32
    80005308:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    8000530c:	00053903          	ld	s2,0(a0)
    80005310:	07890913          	addi	s2,s2,120
    80005314:	0340006f          	j	80005348 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x58>
        while(head){
            if(head->parent->objectSize <= sizeof(Slab)) {
                Buddy::free(head, head->parent->slabSize);
            }
            else{
                Buddy::free(head->objectOffset, head->parent->slabSize);
    80005318:	0487b583          	ld	a1,72(a5)
    8000531c:	0a053503          	ld	a0,160(a0)
    80005320:	ffffd097          	auipc	ra,0xffffd
    80005324:	988080e7          	jalr	-1656(ra) # 80001ca8 <_ZN5Buddy4freeEPvm>
                SlabAllocator::freeObject(largeSlabCache, head);
    80005328:	00093583          	ld	a1,0(s2)
    8000532c:	00006517          	auipc	a0,0x6
    80005330:	f6c53503          	ld	a0,-148(a0) # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    80005334:	00000097          	auipc	ra,0x0
    80005338:	dc0080e7          	jalr	-576(ra) # 800050f4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
            }
            head = head->next;
    8000533c:	00093783          	ld	a5,0(s2)
    80005340:	0087b783          	ld	a5,8(a5)
    80005344:	00f93023          	sd	a5,0(s2)
        while(head){
    80005348:	00093503          	ld	a0,0(s2)
    8000534c:	02050263          	beqz	a0,80005370 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x80>
            if(head->parent->objectSize <= sizeof(Slab)) {
    80005350:	0a853783          	ld	a5,168(a0)
    80005354:	0407b683          	ld	a3,64(a5)
    80005358:	0b000713          	li	a4,176
    8000535c:	fad76ee3          	bltu	a4,a3,80005318 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x28>
                Buddy::free(head, head->parent->slabSize);
    80005360:	0487b583          	ld	a1,72(a5)
    80005364:	ffffd097          	auipc	ra,0xffffd
    80005368:	944080e7          	jalr	-1724(ra) # 80001ca8 <_ZN5Buddy4freeEPvm>
    8000536c:	fd1ff06f          	j	8000533c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
    deleteList(cache->partialHead);
    80005370:	0004b903          	ld	s2,0(s1)
    80005374:	07090913          	addi	s2,s2,112
    80005378:	0340006f          	j	800053ac <_ZN13SlabAllocator11deleteCacheERP5Cache+0xbc>
                Buddy::free(head->objectOffset, head->parent->slabSize);
    8000537c:	0487b583          	ld	a1,72(a5)
    80005380:	0a053503          	ld	a0,160(a0)
    80005384:	ffffd097          	auipc	ra,0xffffd
    80005388:	924080e7          	jalr	-1756(ra) # 80001ca8 <_ZN5Buddy4freeEPvm>
                SlabAllocator::freeObject(largeSlabCache, head);
    8000538c:	00093583          	ld	a1,0(s2)
    80005390:	00006517          	auipc	a0,0x6
    80005394:	f0853503          	ld	a0,-248(a0) # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    80005398:	00000097          	auipc	ra,0x0
    8000539c:	d5c080e7          	jalr	-676(ra) # 800050f4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
            head = head->next;
    800053a0:	00093783          	ld	a5,0(s2)
    800053a4:	0087b783          	ld	a5,8(a5)
    800053a8:	00f93023          	sd	a5,0(s2)
        while(head){
    800053ac:	00093503          	ld	a0,0(s2)
    800053b0:	02050263          	beqz	a0,800053d4 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xe4>
            if(head->parent->objectSize <= sizeof(Slab)) {
    800053b4:	0a853783          	ld	a5,168(a0)
    800053b8:	0407b683          	ld	a3,64(a5)
    800053bc:	0b000713          	li	a4,176
    800053c0:	fad76ee3          	bltu	a4,a3,8000537c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x8c>
                Buddy::free(head, head->parent->slabSize);
    800053c4:	0487b583          	ld	a1,72(a5)
    800053c8:	ffffd097          	auipc	ra,0xffffd
    800053cc:	8e0080e7          	jalr	-1824(ra) # 80001ca8 <_ZN5Buddy4freeEPvm>
    800053d0:	fd1ff06f          	j	800053a0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xb0>
    deleteList(cache->emptyHead);
    800053d4:	0004b903          	ld	s2,0(s1)
    800053d8:	06890913          	addi	s2,s2,104
    800053dc:	0340006f          	j	80005410 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x120>
                Buddy::free(head->objectOffset, head->parent->slabSize);
    800053e0:	0487b583          	ld	a1,72(a5)
    800053e4:	0a053503          	ld	a0,160(a0)
    800053e8:	ffffd097          	auipc	ra,0xffffd
    800053ec:	8c0080e7          	jalr	-1856(ra) # 80001ca8 <_ZN5Buddy4freeEPvm>
                SlabAllocator::freeObject(largeSlabCache, head);
    800053f0:	00093583          	ld	a1,0(s2)
    800053f4:	00006517          	auipc	a0,0x6
    800053f8:	ea453503          	ld	a0,-348(a0) # 8000b298 <_ZN13SlabAllocator14largeSlabCacheE>
    800053fc:	00000097          	auipc	ra,0x0
    80005400:	cf8080e7          	jalr	-776(ra) # 800050f4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
            head = head->next;
    80005404:	00093783          	ld	a5,0(s2)
    80005408:	0087b783          	ld	a5,8(a5)
    8000540c:	00f93023          	sd	a5,0(s2)
        while(head){
    80005410:	00093503          	ld	a0,0(s2)
    80005414:	02050263          	beqz	a0,80005438 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x148>
            if(head->parent->objectSize <= sizeof(Slab)) {
    80005418:	0a853783          	ld	a5,168(a0)
    8000541c:	0407b683          	ld	a3,64(a5)
    80005420:	0b000713          	li	a4,176
    80005424:	fad76ee3          	bltu	a4,a3,800053e0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xf0>
                Buddy::free(head, head->parent->slabSize);
    80005428:	0487b583          	ld	a1,72(a5)
    8000542c:	ffffd097          	auipc	ra,0xffffd
    80005430:	87c080e7          	jalr	-1924(ra) # 80001ca8 <_ZN5Buddy4freeEPvm>
    80005434:	fd1ff06f          	j	80005404 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x114>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80005438:	0004b583          	ld	a1,0(s1)
    8000543c:	00006517          	auipc	a0,0x6
    80005440:	ecc53503          	ld	a0,-308(a0) # 8000b308 <_ZN13SlabAllocator5cacheE>
    80005444:	00000097          	auipc	ra,0x0
    80005448:	cb0080e7          	jalr	-848(ra) # 800050f4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    8000544c:	0004b023          	sd	zero,0(s1)
}
    80005450:	01813083          	ld	ra,24(sp)
    80005454:	01013403          	ld	s0,16(sp)
    80005458:	00813483          	ld	s1,8(sp)
    8000545c:	00013903          	ld	s2,0(sp)
    80005460:	02010113          	addi	sp,sp,32
    80005464:	00008067          	ret

0000000080005468 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache>:

int SlabAllocator::cacheErrorHandler(Cache *cache) {
    80005468:	fe010113          	addi	sp,sp,-32
    8000546c:	00113c23          	sd	ra,24(sp)
    80005470:	00813823          	sd	s0,16(sp)
    80005474:	00913423          	sd	s1,8(sp)
    80005478:	02010413          	addi	s0,sp,32
    8000547c:	00050493          	mv	s1,a0
    switch(cache->errCode){
    80005480:	05053783          	ld	a5,80(a0)
    80005484:	00100713          	li	a4,1
    80005488:	02e78e63          	beq	a5,a4,800054c4 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x5c>
    8000548c:	00200713          	li	a4,2
    80005490:	04e78463          	beq	a5,a4,800054d8 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x70>
    80005494:	00078e63          	beqz	a5,800054b0 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x48>
        case 0: ConsoleUtil::printString("No errors\n");break;
        case 1: ConsoleUtil::printString("No available slots\n");break;
        case 2: ConsoleUtil::printString("Couldn't allocate slab\n");break;
    }
    return cache->errCode;
    80005498:	0504a503          	lw	a0,80(s1)
    8000549c:	01813083          	ld	ra,24(sp)
    800054a0:	01013403          	ld	s0,16(sp)
    800054a4:	00813483          	ld	s1,8(sp)
    800054a8:	02010113          	addi	sp,sp,32
    800054ac:	00008067          	ret
        case 0: ConsoleUtil::printString("No errors\n");break;
    800054b0:	00003517          	auipc	a0,0x3
    800054b4:	ff050513          	addi	a0,a0,-16 # 800084a0 <CONSOLE_STATUS+0x490>
    800054b8:	ffffd097          	auipc	ra,0xffffd
    800054bc:	598080e7          	jalr	1432(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    800054c0:	fd9ff06f          	j	80005498 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>
        case 1: ConsoleUtil::printString("No available slots\n");break;
    800054c4:	00003517          	auipc	a0,0x3
    800054c8:	fec50513          	addi	a0,a0,-20 # 800084b0 <CONSOLE_STATUS+0x4a0>
    800054cc:	ffffd097          	auipc	ra,0xffffd
    800054d0:	584080e7          	jalr	1412(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    800054d4:	fc5ff06f          	j	80005498 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>
        case 2: ConsoleUtil::printString("Couldn't allocate slab\n");break;
    800054d8:	00003517          	auipc	a0,0x3
    800054dc:	ff050513          	addi	a0,a0,-16 # 800084c8 <CONSOLE_STATUS+0x4b8>
    800054e0:	ffffd097          	auipc	ra,0xffffd
    800054e4:	570080e7          	jalr	1392(ra) # 80002a50 <_ZN11ConsoleUtil11printStringEPKc>
    800054e8:	fb1ff06f          	j	80005498 <_ZN13SlabAllocator17cacheErrorHandlerEP5Cache+0x30>

00000000800054ec <start>:
    800054ec:	ff010113          	addi	sp,sp,-16
    800054f0:	00813423          	sd	s0,8(sp)
    800054f4:	01010413          	addi	s0,sp,16
    800054f8:	300027f3          	csrr	a5,mstatus
    800054fc:	ffffe737          	lui	a4,0xffffe
    80005500:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed7ff>
    80005504:	00e7f7b3          	and	a5,a5,a4
    80005508:	00001737          	lui	a4,0x1
    8000550c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005510:	00e7e7b3          	or	a5,a5,a4
    80005514:	30079073          	csrw	mstatus,a5
    80005518:	00000797          	auipc	a5,0x0
    8000551c:	16078793          	addi	a5,a5,352 # 80005678 <system_main>
    80005520:	34179073          	csrw	mepc,a5
    80005524:	00000793          	li	a5,0
    80005528:	18079073          	csrw	satp,a5
    8000552c:	000107b7          	lui	a5,0x10
    80005530:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005534:	30279073          	csrw	medeleg,a5
    80005538:	30379073          	csrw	mideleg,a5
    8000553c:	104027f3          	csrr	a5,sie
    80005540:	2227e793          	ori	a5,a5,546
    80005544:	10479073          	csrw	sie,a5
    80005548:	fff00793          	li	a5,-1
    8000554c:	00a7d793          	srli	a5,a5,0xa
    80005550:	3b079073          	csrw	pmpaddr0,a5
    80005554:	00f00793          	li	a5,15
    80005558:	3a079073          	csrw	pmpcfg0,a5
    8000555c:	f14027f3          	csrr	a5,mhartid
    80005560:	0200c737          	lui	a4,0x200c
    80005564:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005568:	0007869b          	sext.w	a3,a5
    8000556c:	00269713          	slli	a4,a3,0x2
    80005570:	000f4637          	lui	a2,0xf4
    80005574:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005578:	00d70733          	add	a4,a4,a3
    8000557c:	0037979b          	slliw	a5,a5,0x3
    80005580:	020046b7          	lui	a3,0x2004
    80005584:	00d787b3          	add	a5,a5,a3
    80005588:	00c585b3          	add	a1,a1,a2
    8000558c:	00371693          	slli	a3,a4,0x3
    80005590:	00006717          	auipc	a4,0x6
    80005594:	d8070713          	addi	a4,a4,-640 # 8000b310 <timer_scratch>
    80005598:	00b7b023          	sd	a1,0(a5)
    8000559c:	00d70733          	add	a4,a4,a3
    800055a0:	00f73c23          	sd	a5,24(a4)
    800055a4:	02c73023          	sd	a2,32(a4)
    800055a8:	34071073          	csrw	mscratch,a4
    800055ac:	00000797          	auipc	a5,0x0
    800055b0:	6e478793          	addi	a5,a5,1764 # 80005c90 <timervec>
    800055b4:	30579073          	csrw	mtvec,a5
    800055b8:	300027f3          	csrr	a5,mstatus
    800055bc:	0087e793          	ori	a5,a5,8
    800055c0:	30079073          	csrw	mstatus,a5
    800055c4:	304027f3          	csrr	a5,mie
    800055c8:	0807e793          	ori	a5,a5,128
    800055cc:	30479073          	csrw	mie,a5
    800055d0:	f14027f3          	csrr	a5,mhartid
    800055d4:	0007879b          	sext.w	a5,a5
    800055d8:	00078213          	mv	tp,a5
    800055dc:	30200073          	mret
    800055e0:	00813403          	ld	s0,8(sp)
    800055e4:	01010113          	addi	sp,sp,16
    800055e8:	00008067          	ret

00000000800055ec <timerinit>:
    800055ec:	ff010113          	addi	sp,sp,-16
    800055f0:	00813423          	sd	s0,8(sp)
    800055f4:	01010413          	addi	s0,sp,16
    800055f8:	f14027f3          	csrr	a5,mhartid
    800055fc:	0200c737          	lui	a4,0x200c
    80005600:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005604:	0007869b          	sext.w	a3,a5
    80005608:	00269713          	slli	a4,a3,0x2
    8000560c:	000f4637          	lui	a2,0xf4
    80005610:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005614:	00d70733          	add	a4,a4,a3
    80005618:	0037979b          	slliw	a5,a5,0x3
    8000561c:	020046b7          	lui	a3,0x2004
    80005620:	00d787b3          	add	a5,a5,a3
    80005624:	00c585b3          	add	a1,a1,a2
    80005628:	00371693          	slli	a3,a4,0x3
    8000562c:	00006717          	auipc	a4,0x6
    80005630:	ce470713          	addi	a4,a4,-796 # 8000b310 <timer_scratch>
    80005634:	00b7b023          	sd	a1,0(a5)
    80005638:	00d70733          	add	a4,a4,a3
    8000563c:	00f73c23          	sd	a5,24(a4)
    80005640:	02c73023          	sd	a2,32(a4)
    80005644:	34071073          	csrw	mscratch,a4
    80005648:	00000797          	auipc	a5,0x0
    8000564c:	64878793          	addi	a5,a5,1608 # 80005c90 <timervec>
    80005650:	30579073          	csrw	mtvec,a5
    80005654:	300027f3          	csrr	a5,mstatus
    80005658:	0087e793          	ori	a5,a5,8
    8000565c:	30079073          	csrw	mstatus,a5
    80005660:	304027f3          	csrr	a5,mie
    80005664:	0807e793          	ori	a5,a5,128
    80005668:	30479073          	csrw	mie,a5
    8000566c:	00813403          	ld	s0,8(sp)
    80005670:	01010113          	addi	sp,sp,16
    80005674:	00008067          	ret

0000000080005678 <system_main>:
    80005678:	fe010113          	addi	sp,sp,-32
    8000567c:	00813823          	sd	s0,16(sp)
    80005680:	00913423          	sd	s1,8(sp)
    80005684:	00113c23          	sd	ra,24(sp)
    80005688:	02010413          	addi	s0,sp,32
    8000568c:	00000097          	auipc	ra,0x0
    80005690:	0c4080e7          	jalr	196(ra) # 80005750 <cpuid>
    80005694:	00006497          	auipc	s1,0x6
    80005698:	9fc48493          	addi	s1,s1,-1540 # 8000b090 <started>
    8000569c:	02050263          	beqz	a0,800056c0 <system_main+0x48>
    800056a0:	0004a783          	lw	a5,0(s1)
    800056a4:	0007879b          	sext.w	a5,a5
    800056a8:	fe078ce3          	beqz	a5,800056a0 <system_main+0x28>
    800056ac:	0ff0000f          	fence
    800056b0:	00003517          	auipc	a0,0x3
    800056b4:	f9850513          	addi	a0,a0,-104 # 80008648 <CONSOLE_STATUS+0x638>
    800056b8:	00001097          	auipc	ra,0x1
    800056bc:	a74080e7          	jalr	-1420(ra) # 8000612c <panic>
    800056c0:	00001097          	auipc	ra,0x1
    800056c4:	9c8080e7          	jalr	-1592(ra) # 80006088 <consoleinit>
    800056c8:	00001097          	auipc	ra,0x1
    800056cc:	154080e7          	jalr	340(ra) # 8000681c <printfinit>
    800056d0:	00003517          	auipc	a0,0x3
    800056d4:	a5050513          	addi	a0,a0,-1456 # 80008120 <CONSOLE_STATUS+0x110>
    800056d8:	00001097          	auipc	ra,0x1
    800056dc:	ab0080e7          	jalr	-1360(ra) # 80006188 <__printf>
    800056e0:	00003517          	auipc	a0,0x3
    800056e4:	f3850513          	addi	a0,a0,-200 # 80008618 <CONSOLE_STATUS+0x608>
    800056e8:	00001097          	auipc	ra,0x1
    800056ec:	aa0080e7          	jalr	-1376(ra) # 80006188 <__printf>
    800056f0:	00003517          	auipc	a0,0x3
    800056f4:	a3050513          	addi	a0,a0,-1488 # 80008120 <CONSOLE_STATUS+0x110>
    800056f8:	00001097          	auipc	ra,0x1
    800056fc:	a90080e7          	jalr	-1392(ra) # 80006188 <__printf>
    80005700:	00001097          	auipc	ra,0x1
    80005704:	4a8080e7          	jalr	1192(ra) # 80006ba8 <kinit>
    80005708:	00000097          	auipc	ra,0x0
    8000570c:	148080e7          	jalr	328(ra) # 80005850 <trapinit>
    80005710:	00000097          	auipc	ra,0x0
    80005714:	16c080e7          	jalr	364(ra) # 8000587c <trapinithart>
    80005718:	00000097          	auipc	ra,0x0
    8000571c:	5b8080e7          	jalr	1464(ra) # 80005cd0 <plicinit>
    80005720:	00000097          	auipc	ra,0x0
    80005724:	5d8080e7          	jalr	1496(ra) # 80005cf8 <plicinithart>
    80005728:	00000097          	auipc	ra,0x0
    8000572c:	078080e7          	jalr	120(ra) # 800057a0 <userinit>
    80005730:	0ff0000f          	fence
    80005734:	00100793          	li	a5,1
    80005738:	00003517          	auipc	a0,0x3
    8000573c:	ef850513          	addi	a0,a0,-264 # 80008630 <CONSOLE_STATUS+0x620>
    80005740:	00f4a023          	sw	a5,0(s1)
    80005744:	00001097          	auipc	ra,0x1
    80005748:	a44080e7          	jalr	-1468(ra) # 80006188 <__printf>
    8000574c:	0000006f          	j	8000574c <system_main+0xd4>

0000000080005750 <cpuid>:
    80005750:	ff010113          	addi	sp,sp,-16
    80005754:	00813423          	sd	s0,8(sp)
    80005758:	01010413          	addi	s0,sp,16
    8000575c:	00020513          	mv	a0,tp
    80005760:	00813403          	ld	s0,8(sp)
    80005764:	0005051b          	sext.w	a0,a0
    80005768:	01010113          	addi	sp,sp,16
    8000576c:	00008067          	ret

0000000080005770 <mycpu>:
    80005770:	ff010113          	addi	sp,sp,-16
    80005774:	00813423          	sd	s0,8(sp)
    80005778:	01010413          	addi	s0,sp,16
    8000577c:	00020793          	mv	a5,tp
    80005780:	00813403          	ld	s0,8(sp)
    80005784:	0007879b          	sext.w	a5,a5
    80005788:	00779793          	slli	a5,a5,0x7
    8000578c:	00007517          	auipc	a0,0x7
    80005790:	bb450513          	addi	a0,a0,-1100 # 8000c340 <cpus>
    80005794:	00f50533          	add	a0,a0,a5
    80005798:	01010113          	addi	sp,sp,16
    8000579c:	00008067          	ret

00000000800057a0 <userinit>:
    800057a0:	ff010113          	addi	sp,sp,-16
    800057a4:	00813423          	sd	s0,8(sp)
    800057a8:	01010413          	addi	s0,sp,16
    800057ac:	00813403          	ld	s0,8(sp)
    800057b0:	01010113          	addi	sp,sp,16
    800057b4:	ffffc317          	auipc	t1,0xffffc
    800057b8:	77030067          	jr	1904(t1) # 80001f24 <main>

00000000800057bc <either_copyout>:
    800057bc:	ff010113          	addi	sp,sp,-16
    800057c0:	00813023          	sd	s0,0(sp)
    800057c4:	00113423          	sd	ra,8(sp)
    800057c8:	01010413          	addi	s0,sp,16
    800057cc:	02051663          	bnez	a0,800057f8 <either_copyout+0x3c>
    800057d0:	00058513          	mv	a0,a1
    800057d4:	00060593          	mv	a1,a2
    800057d8:	0006861b          	sext.w	a2,a3
    800057dc:	00002097          	auipc	ra,0x2
    800057e0:	c58080e7          	jalr	-936(ra) # 80007434 <__memmove>
    800057e4:	00813083          	ld	ra,8(sp)
    800057e8:	00013403          	ld	s0,0(sp)
    800057ec:	00000513          	li	a0,0
    800057f0:	01010113          	addi	sp,sp,16
    800057f4:	00008067          	ret
    800057f8:	00003517          	auipc	a0,0x3
    800057fc:	e7850513          	addi	a0,a0,-392 # 80008670 <CONSOLE_STATUS+0x660>
    80005800:	00001097          	auipc	ra,0x1
    80005804:	92c080e7          	jalr	-1748(ra) # 8000612c <panic>

0000000080005808 <either_copyin>:
    80005808:	ff010113          	addi	sp,sp,-16
    8000580c:	00813023          	sd	s0,0(sp)
    80005810:	00113423          	sd	ra,8(sp)
    80005814:	01010413          	addi	s0,sp,16
    80005818:	02059463          	bnez	a1,80005840 <either_copyin+0x38>
    8000581c:	00060593          	mv	a1,a2
    80005820:	0006861b          	sext.w	a2,a3
    80005824:	00002097          	auipc	ra,0x2
    80005828:	c10080e7          	jalr	-1008(ra) # 80007434 <__memmove>
    8000582c:	00813083          	ld	ra,8(sp)
    80005830:	00013403          	ld	s0,0(sp)
    80005834:	00000513          	li	a0,0
    80005838:	01010113          	addi	sp,sp,16
    8000583c:	00008067          	ret
    80005840:	00003517          	auipc	a0,0x3
    80005844:	e5850513          	addi	a0,a0,-424 # 80008698 <CONSOLE_STATUS+0x688>
    80005848:	00001097          	auipc	ra,0x1
    8000584c:	8e4080e7          	jalr	-1820(ra) # 8000612c <panic>

0000000080005850 <trapinit>:
    80005850:	ff010113          	addi	sp,sp,-16
    80005854:	00813423          	sd	s0,8(sp)
    80005858:	01010413          	addi	s0,sp,16
    8000585c:	00813403          	ld	s0,8(sp)
    80005860:	00003597          	auipc	a1,0x3
    80005864:	e6058593          	addi	a1,a1,-416 # 800086c0 <CONSOLE_STATUS+0x6b0>
    80005868:	00007517          	auipc	a0,0x7
    8000586c:	b5850513          	addi	a0,a0,-1192 # 8000c3c0 <tickslock>
    80005870:	01010113          	addi	sp,sp,16
    80005874:	00001317          	auipc	t1,0x1
    80005878:	5c430067          	jr	1476(t1) # 80006e38 <initlock>

000000008000587c <trapinithart>:
    8000587c:	ff010113          	addi	sp,sp,-16
    80005880:	00813423          	sd	s0,8(sp)
    80005884:	01010413          	addi	s0,sp,16
    80005888:	00000797          	auipc	a5,0x0
    8000588c:	2f878793          	addi	a5,a5,760 # 80005b80 <kernelvec>
    80005890:	10579073          	csrw	stvec,a5
    80005894:	00813403          	ld	s0,8(sp)
    80005898:	01010113          	addi	sp,sp,16
    8000589c:	00008067          	ret

00000000800058a0 <usertrap>:
    800058a0:	ff010113          	addi	sp,sp,-16
    800058a4:	00813423          	sd	s0,8(sp)
    800058a8:	01010413          	addi	s0,sp,16
    800058ac:	00813403          	ld	s0,8(sp)
    800058b0:	01010113          	addi	sp,sp,16
    800058b4:	00008067          	ret

00000000800058b8 <usertrapret>:
    800058b8:	ff010113          	addi	sp,sp,-16
    800058bc:	00813423          	sd	s0,8(sp)
    800058c0:	01010413          	addi	s0,sp,16
    800058c4:	00813403          	ld	s0,8(sp)
    800058c8:	01010113          	addi	sp,sp,16
    800058cc:	00008067          	ret

00000000800058d0 <kerneltrap>:
    800058d0:	fe010113          	addi	sp,sp,-32
    800058d4:	00813823          	sd	s0,16(sp)
    800058d8:	00113c23          	sd	ra,24(sp)
    800058dc:	00913423          	sd	s1,8(sp)
    800058e0:	02010413          	addi	s0,sp,32
    800058e4:	142025f3          	csrr	a1,scause
    800058e8:	100027f3          	csrr	a5,sstatus
    800058ec:	0027f793          	andi	a5,a5,2
    800058f0:	10079c63          	bnez	a5,80005a08 <kerneltrap+0x138>
    800058f4:	142027f3          	csrr	a5,scause
    800058f8:	0207ce63          	bltz	a5,80005934 <kerneltrap+0x64>
    800058fc:	00003517          	auipc	a0,0x3
    80005900:	e0c50513          	addi	a0,a0,-500 # 80008708 <CONSOLE_STATUS+0x6f8>
    80005904:	00001097          	auipc	ra,0x1
    80005908:	884080e7          	jalr	-1916(ra) # 80006188 <__printf>
    8000590c:	141025f3          	csrr	a1,sepc
    80005910:	14302673          	csrr	a2,stval
    80005914:	00003517          	auipc	a0,0x3
    80005918:	e0450513          	addi	a0,a0,-508 # 80008718 <CONSOLE_STATUS+0x708>
    8000591c:	00001097          	auipc	ra,0x1
    80005920:	86c080e7          	jalr	-1940(ra) # 80006188 <__printf>
    80005924:	00003517          	auipc	a0,0x3
    80005928:	e0c50513          	addi	a0,a0,-500 # 80008730 <CONSOLE_STATUS+0x720>
    8000592c:	00001097          	auipc	ra,0x1
    80005930:	800080e7          	jalr	-2048(ra) # 8000612c <panic>
    80005934:	0ff7f713          	andi	a4,a5,255
    80005938:	00900693          	li	a3,9
    8000593c:	04d70063          	beq	a4,a3,8000597c <kerneltrap+0xac>
    80005940:	fff00713          	li	a4,-1
    80005944:	03f71713          	slli	a4,a4,0x3f
    80005948:	00170713          	addi	a4,a4,1
    8000594c:	fae798e3          	bne	a5,a4,800058fc <kerneltrap+0x2c>
    80005950:	00000097          	auipc	ra,0x0
    80005954:	e00080e7          	jalr	-512(ra) # 80005750 <cpuid>
    80005958:	06050663          	beqz	a0,800059c4 <kerneltrap+0xf4>
    8000595c:	144027f3          	csrr	a5,sip
    80005960:	ffd7f793          	andi	a5,a5,-3
    80005964:	14479073          	csrw	sip,a5
    80005968:	01813083          	ld	ra,24(sp)
    8000596c:	01013403          	ld	s0,16(sp)
    80005970:	00813483          	ld	s1,8(sp)
    80005974:	02010113          	addi	sp,sp,32
    80005978:	00008067          	ret
    8000597c:	00000097          	auipc	ra,0x0
    80005980:	3c8080e7          	jalr	968(ra) # 80005d44 <plic_claim>
    80005984:	00a00793          	li	a5,10
    80005988:	00050493          	mv	s1,a0
    8000598c:	06f50863          	beq	a0,a5,800059fc <kerneltrap+0x12c>
    80005990:	fc050ce3          	beqz	a0,80005968 <kerneltrap+0x98>
    80005994:	00050593          	mv	a1,a0
    80005998:	00003517          	auipc	a0,0x3
    8000599c:	d5050513          	addi	a0,a0,-688 # 800086e8 <CONSOLE_STATUS+0x6d8>
    800059a0:	00000097          	auipc	ra,0x0
    800059a4:	7e8080e7          	jalr	2024(ra) # 80006188 <__printf>
    800059a8:	01013403          	ld	s0,16(sp)
    800059ac:	01813083          	ld	ra,24(sp)
    800059b0:	00048513          	mv	a0,s1
    800059b4:	00813483          	ld	s1,8(sp)
    800059b8:	02010113          	addi	sp,sp,32
    800059bc:	00000317          	auipc	t1,0x0
    800059c0:	3c030067          	jr	960(t1) # 80005d7c <plic_complete>
    800059c4:	00007517          	auipc	a0,0x7
    800059c8:	9fc50513          	addi	a0,a0,-1540 # 8000c3c0 <tickslock>
    800059cc:	00001097          	auipc	ra,0x1
    800059d0:	490080e7          	jalr	1168(ra) # 80006e5c <acquire>
    800059d4:	00005717          	auipc	a4,0x5
    800059d8:	6c070713          	addi	a4,a4,1728 # 8000b094 <ticks>
    800059dc:	00072783          	lw	a5,0(a4)
    800059e0:	00007517          	auipc	a0,0x7
    800059e4:	9e050513          	addi	a0,a0,-1568 # 8000c3c0 <tickslock>
    800059e8:	0017879b          	addiw	a5,a5,1
    800059ec:	00f72023          	sw	a5,0(a4)
    800059f0:	00001097          	auipc	ra,0x1
    800059f4:	538080e7          	jalr	1336(ra) # 80006f28 <release>
    800059f8:	f65ff06f          	j	8000595c <kerneltrap+0x8c>
    800059fc:	00001097          	auipc	ra,0x1
    80005a00:	094080e7          	jalr	148(ra) # 80006a90 <uartintr>
    80005a04:	fa5ff06f          	j	800059a8 <kerneltrap+0xd8>
    80005a08:	00003517          	auipc	a0,0x3
    80005a0c:	cc050513          	addi	a0,a0,-832 # 800086c8 <CONSOLE_STATUS+0x6b8>
    80005a10:	00000097          	auipc	ra,0x0
    80005a14:	71c080e7          	jalr	1820(ra) # 8000612c <panic>

0000000080005a18 <clockintr>:
    80005a18:	fe010113          	addi	sp,sp,-32
    80005a1c:	00813823          	sd	s0,16(sp)
    80005a20:	00913423          	sd	s1,8(sp)
    80005a24:	00113c23          	sd	ra,24(sp)
    80005a28:	02010413          	addi	s0,sp,32
    80005a2c:	00007497          	auipc	s1,0x7
    80005a30:	99448493          	addi	s1,s1,-1644 # 8000c3c0 <tickslock>
    80005a34:	00048513          	mv	a0,s1
    80005a38:	00001097          	auipc	ra,0x1
    80005a3c:	424080e7          	jalr	1060(ra) # 80006e5c <acquire>
    80005a40:	00005717          	auipc	a4,0x5
    80005a44:	65470713          	addi	a4,a4,1620 # 8000b094 <ticks>
    80005a48:	00072783          	lw	a5,0(a4)
    80005a4c:	01013403          	ld	s0,16(sp)
    80005a50:	01813083          	ld	ra,24(sp)
    80005a54:	00048513          	mv	a0,s1
    80005a58:	0017879b          	addiw	a5,a5,1
    80005a5c:	00813483          	ld	s1,8(sp)
    80005a60:	00f72023          	sw	a5,0(a4)
    80005a64:	02010113          	addi	sp,sp,32
    80005a68:	00001317          	auipc	t1,0x1
    80005a6c:	4c030067          	jr	1216(t1) # 80006f28 <release>

0000000080005a70 <devintr>:
    80005a70:	142027f3          	csrr	a5,scause
    80005a74:	00000513          	li	a0,0
    80005a78:	0007c463          	bltz	a5,80005a80 <devintr+0x10>
    80005a7c:	00008067          	ret
    80005a80:	fe010113          	addi	sp,sp,-32
    80005a84:	00813823          	sd	s0,16(sp)
    80005a88:	00113c23          	sd	ra,24(sp)
    80005a8c:	00913423          	sd	s1,8(sp)
    80005a90:	02010413          	addi	s0,sp,32
    80005a94:	0ff7f713          	andi	a4,a5,255
    80005a98:	00900693          	li	a3,9
    80005a9c:	04d70c63          	beq	a4,a3,80005af4 <devintr+0x84>
    80005aa0:	fff00713          	li	a4,-1
    80005aa4:	03f71713          	slli	a4,a4,0x3f
    80005aa8:	00170713          	addi	a4,a4,1
    80005aac:	00e78c63          	beq	a5,a4,80005ac4 <devintr+0x54>
    80005ab0:	01813083          	ld	ra,24(sp)
    80005ab4:	01013403          	ld	s0,16(sp)
    80005ab8:	00813483          	ld	s1,8(sp)
    80005abc:	02010113          	addi	sp,sp,32
    80005ac0:	00008067          	ret
    80005ac4:	00000097          	auipc	ra,0x0
    80005ac8:	c8c080e7          	jalr	-884(ra) # 80005750 <cpuid>
    80005acc:	06050663          	beqz	a0,80005b38 <devintr+0xc8>
    80005ad0:	144027f3          	csrr	a5,sip
    80005ad4:	ffd7f793          	andi	a5,a5,-3
    80005ad8:	14479073          	csrw	sip,a5
    80005adc:	01813083          	ld	ra,24(sp)
    80005ae0:	01013403          	ld	s0,16(sp)
    80005ae4:	00813483          	ld	s1,8(sp)
    80005ae8:	00200513          	li	a0,2
    80005aec:	02010113          	addi	sp,sp,32
    80005af0:	00008067          	ret
    80005af4:	00000097          	auipc	ra,0x0
    80005af8:	250080e7          	jalr	592(ra) # 80005d44 <plic_claim>
    80005afc:	00a00793          	li	a5,10
    80005b00:	00050493          	mv	s1,a0
    80005b04:	06f50663          	beq	a0,a5,80005b70 <devintr+0x100>
    80005b08:	00100513          	li	a0,1
    80005b0c:	fa0482e3          	beqz	s1,80005ab0 <devintr+0x40>
    80005b10:	00048593          	mv	a1,s1
    80005b14:	00003517          	auipc	a0,0x3
    80005b18:	bd450513          	addi	a0,a0,-1068 # 800086e8 <CONSOLE_STATUS+0x6d8>
    80005b1c:	00000097          	auipc	ra,0x0
    80005b20:	66c080e7          	jalr	1644(ra) # 80006188 <__printf>
    80005b24:	00048513          	mv	a0,s1
    80005b28:	00000097          	auipc	ra,0x0
    80005b2c:	254080e7          	jalr	596(ra) # 80005d7c <plic_complete>
    80005b30:	00100513          	li	a0,1
    80005b34:	f7dff06f          	j	80005ab0 <devintr+0x40>
    80005b38:	00007517          	auipc	a0,0x7
    80005b3c:	88850513          	addi	a0,a0,-1912 # 8000c3c0 <tickslock>
    80005b40:	00001097          	auipc	ra,0x1
    80005b44:	31c080e7          	jalr	796(ra) # 80006e5c <acquire>
    80005b48:	00005717          	auipc	a4,0x5
    80005b4c:	54c70713          	addi	a4,a4,1356 # 8000b094 <ticks>
    80005b50:	00072783          	lw	a5,0(a4)
    80005b54:	00007517          	auipc	a0,0x7
    80005b58:	86c50513          	addi	a0,a0,-1940 # 8000c3c0 <tickslock>
    80005b5c:	0017879b          	addiw	a5,a5,1
    80005b60:	00f72023          	sw	a5,0(a4)
    80005b64:	00001097          	auipc	ra,0x1
    80005b68:	3c4080e7          	jalr	964(ra) # 80006f28 <release>
    80005b6c:	f65ff06f          	j	80005ad0 <devintr+0x60>
    80005b70:	00001097          	auipc	ra,0x1
    80005b74:	f20080e7          	jalr	-224(ra) # 80006a90 <uartintr>
    80005b78:	fadff06f          	j	80005b24 <devintr+0xb4>
    80005b7c:	0000                	unimp
	...

0000000080005b80 <kernelvec>:
    80005b80:	f0010113          	addi	sp,sp,-256
    80005b84:	00113023          	sd	ra,0(sp)
    80005b88:	00213423          	sd	sp,8(sp)
    80005b8c:	00313823          	sd	gp,16(sp)
    80005b90:	00413c23          	sd	tp,24(sp)
    80005b94:	02513023          	sd	t0,32(sp)
    80005b98:	02613423          	sd	t1,40(sp)
    80005b9c:	02713823          	sd	t2,48(sp)
    80005ba0:	02813c23          	sd	s0,56(sp)
    80005ba4:	04913023          	sd	s1,64(sp)
    80005ba8:	04a13423          	sd	a0,72(sp)
    80005bac:	04b13823          	sd	a1,80(sp)
    80005bb0:	04c13c23          	sd	a2,88(sp)
    80005bb4:	06d13023          	sd	a3,96(sp)
    80005bb8:	06e13423          	sd	a4,104(sp)
    80005bbc:	06f13823          	sd	a5,112(sp)
    80005bc0:	07013c23          	sd	a6,120(sp)
    80005bc4:	09113023          	sd	a7,128(sp)
    80005bc8:	09213423          	sd	s2,136(sp)
    80005bcc:	09313823          	sd	s3,144(sp)
    80005bd0:	09413c23          	sd	s4,152(sp)
    80005bd4:	0b513023          	sd	s5,160(sp)
    80005bd8:	0b613423          	sd	s6,168(sp)
    80005bdc:	0b713823          	sd	s7,176(sp)
    80005be0:	0b813c23          	sd	s8,184(sp)
    80005be4:	0d913023          	sd	s9,192(sp)
    80005be8:	0da13423          	sd	s10,200(sp)
    80005bec:	0db13823          	sd	s11,208(sp)
    80005bf0:	0dc13c23          	sd	t3,216(sp)
    80005bf4:	0fd13023          	sd	t4,224(sp)
    80005bf8:	0fe13423          	sd	t5,232(sp)
    80005bfc:	0ff13823          	sd	t6,240(sp)
    80005c00:	cd1ff0ef          	jal	ra,800058d0 <kerneltrap>
    80005c04:	00013083          	ld	ra,0(sp)
    80005c08:	00813103          	ld	sp,8(sp)
    80005c0c:	01013183          	ld	gp,16(sp)
    80005c10:	02013283          	ld	t0,32(sp)
    80005c14:	02813303          	ld	t1,40(sp)
    80005c18:	03013383          	ld	t2,48(sp)
    80005c1c:	03813403          	ld	s0,56(sp)
    80005c20:	04013483          	ld	s1,64(sp)
    80005c24:	04813503          	ld	a0,72(sp)
    80005c28:	05013583          	ld	a1,80(sp)
    80005c2c:	05813603          	ld	a2,88(sp)
    80005c30:	06013683          	ld	a3,96(sp)
    80005c34:	06813703          	ld	a4,104(sp)
    80005c38:	07013783          	ld	a5,112(sp)
    80005c3c:	07813803          	ld	a6,120(sp)
    80005c40:	08013883          	ld	a7,128(sp)
    80005c44:	08813903          	ld	s2,136(sp)
    80005c48:	09013983          	ld	s3,144(sp)
    80005c4c:	09813a03          	ld	s4,152(sp)
    80005c50:	0a013a83          	ld	s5,160(sp)
    80005c54:	0a813b03          	ld	s6,168(sp)
    80005c58:	0b013b83          	ld	s7,176(sp)
    80005c5c:	0b813c03          	ld	s8,184(sp)
    80005c60:	0c013c83          	ld	s9,192(sp)
    80005c64:	0c813d03          	ld	s10,200(sp)
    80005c68:	0d013d83          	ld	s11,208(sp)
    80005c6c:	0d813e03          	ld	t3,216(sp)
    80005c70:	0e013e83          	ld	t4,224(sp)
    80005c74:	0e813f03          	ld	t5,232(sp)
    80005c78:	0f013f83          	ld	t6,240(sp)
    80005c7c:	10010113          	addi	sp,sp,256
    80005c80:	10200073          	sret
    80005c84:	00000013          	nop
    80005c88:	00000013          	nop
    80005c8c:	00000013          	nop

0000000080005c90 <timervec>:
    80005c90:	34051573          	csrrw	a0,mscratch,a0
    80005c94:	00b53023          	sd	a1,0(a0)
    80005c98:	00c53423          	sd	a2,8(a0)
    80005c9c:	00d53823          	sd	a3,16(a0)
    80005ca0:	01853583          	ld	a1,24(a0)
    80005ca4:	02053603          	ld	a2,32(a0)
    80005ca8:	0005b683          	ld	a3,0(a1)
    80005cac:	00c686b3          	add	a3,a3,a2
    80005cb0:	00d5b023          	sd	a3,0(a1)
    80005cb4:	00200593          	li	a1,2
    80005cb8:	14459073          	csrw	sip,a1
    80005cbc:	01053683          	ld	a3,16(a0)
    80005cc0:	00853603          	ld	a2,8(a0)
    80005cc4:	00053583          	ld	a1,0(a0)
    80005cc8:	34051573          	csrrw	a0,mscratch,a0
    80005ccc:	30200073          	mret

0000000080005cd0 <plicinit>:
    80005cd0:	ff010113          	addi	sp,sp,-16
    80005cd4:	00813423          	sd	s0,8(sp)
    80005cd8:	01010413          	addi	s0,sp,16
    80005cdc:	00813403          	ld	s0,8(sp)
    80005ce0:	0c0007b7          	lui	a5,0xc000
    80005ce4:	00100713          	li	a4,1
    80005ce8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80005cec:	00e7a223          	sw	a4,4(a5)
    80005cf0:	01010113          	addi	sp,sp,16
    80005cf4:	00008067          	ret

0000000080005cf8 <plicinithart>:
    80005cf8:	ff010113          	addi	sp,sp,-16
    80005cfc:	00813023          	sd	s0,0(sp)
    80005d00:	00113423          	sd	ra,8(sp)
    80005d04:	01010413          	addi	s0,sp,16
    80005d08:	00000097          	auipc	ra,0x0
    80005d0c:	a48080e7          	jalr	-1464(ra) # 80005750 <cpuid>
    80005d10:	0085171b          	slliw	a4,a0,0x8
    80005d14:	0c0027b7          	lui	a5,0xc002
    80005d18:	00e787b3          	add	a5,a5,a4
    80005d1c:	40200713          	li	a4,1026
    80005d20:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005d24:	00813083          	ld	ra,8(sp)
    80005d28:	00013403          	ld	s0,0(sp)
    80005d2c:	00d5151b          	slliw	a0,a0,0xd
    80005d30:	0c2017b7          	lui	a5,0xc201
    80005d34:	00a78533          	add	a0,a5,a0
    80005d38:	00052023          	sw	zero,0(a0)
    80005d3c:	01010113          	addi	sp,sp,16
    80005d40:	00008067          	ret

0000000080005d44 <plic_claim>:
    80005d44:	ff010113          	addi	sp,sp,-16
    80005d48:	00813023          	sd	s0,0(sp)
    80005d4c:	00113423          	sd	ra,8(sp)
    80005d50:	01010413          	addi	s0,sp,16
    80005d54:	00000097          	auipc	ra,0x0
    80005d58:	9fc080e7          	jalr	-1540(ra) # 80005750 <cpuid>
    80005d5c:	00813083          	ld	ra,8(sp)
    80005d60:	00013403          	ld	s0,0(sp)
    80005d64:	00d5151b          	slliw	a0,a0,0xd
    80005d68:	0c2017b7          	lui	a5,0xc201
    80005d6c:	00a78533          	add	a0,a5,a0
    80005d70:	00452503          	lw	a0,4(a0)
    80005d74:	01010113          	addi	sp,sp,16
    80005d78:	00008067          	ret

0000000080005d7c <plic_complete>:
    80005d7c:	fe010113          	addi	sp,sp,-32
    80005d80:	00813823          	sd	s0,16(sp)
    80005d84:	00913423          	sd	s1,8(sp)
    80005d88:	00113c23          	sd	ra,24(sp)
    80005d8c:	02010413          	addi	s0,sp,32
    80005d90:	00050493          	mv	s1,a0
    80005d94:	00000097          	auipc	ra,0x0
    80005d98:	9bc080e7          	jalr	-1604(ra) # 80005750 <cpuid>
    80005d9c:	01813083          	ld	ra,24(sp)
    80005da0:	01013403          	ld	s0,16(sp)
    80005da4:	00d5179b          	slliw	a5,a0,0xd
    80005da8:	0c201737          	lui	a4,0xc201
    80005dac:	00f707b3          	add	a5,a4,a5
    80005db0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005db4:	00813483          	ld	s1,8(sp)
    80005db8:	02010113          	addi	sp,sp,32
    80005dbc:	00008067          	ret

0000000080005dc0 <consolewrite>:
    80005dc0:	fb010113          	addi	sp,sp,-80
    80005dc4:	04813023          	sd	s0,64(sp)
    80005dc8:	04113423          	sd	ra,72(sp)
    80005dcc:	02913c23          	sd	s1,56(sp)
    80005dd0:	03213823          	sd	s2,48(sp)
    80005dd4:	03313423          	sd	s3,40(sp)
    80005dd8:	03413023          	sd	s4,32(sp)
    80005ddc:	01513c23          	sd	s5,24(sp)
    80005de0:	05010413          	addi	s0,sp,80
    80005de4:	06c05c63          	blez	a2,80005e5c <consolewrite+0x9c>
    80005de8:	00060993          	mv	s3,a2
    80005dec:	00050a13          	mv	s4,a0
    80005df0:	00058493          	mv	s1,a1
    80005df4:	00000913          	li	s2,0
    80005df8:	fff00a93          	li	s5,-1
    80005dfc:	01c0006f          	j	80005e18 <consolewrite+0x58>
    80005e00:	fbf44503          	lbu	a0,-65(s0)
    80005e04:	0019091b          	addiw	s2,s2,1
    80005e08:	00148493          	addi	s1,s1,1
    80005e0c:	00001097          	auipc	ra,0x1
    80005e10:	a9c080e7          	jalr	-1380(ra) # 800068a8 <uartputc>
    80005e14:	03298063          	beq	s3,s2,80005e34 <consolewrite+0x74>
    80005e18:	00048613          	mv	a2,s1
    80005e1c:	00100693          	li	a3,1
    80005e20:	000a0593          	mv	a1,s4
    80005e24:	fbf40513          	addi	a0,s0,-65
    80005e28:	00000097          	auipc	ra,0x0
    80005e2c:	9e0080e7          	jalr	-1568(ra) # 80005808 <either_copyin>
    80005e30:	fd5518e3          	bne	a0,s5,80005e00 <consolewrite+0x40>
    80005e34:	04813083          	ld	ra,72(sp)
    80005e38:	04013403          	ld	s0,64(sp)
    80005e3c:	03813483          	ld	s1,56(sp)
    80005e40:	02813983          	ld	s3,40(sp)
    80005e44:	02013a03          	ld	s4,32(sp)
    80005e48:	01813a83          	ld	s5,24(sp)
    80005e4c:	00090513          	mv	a0,s2
    80005e50:	03013903          	ld	s2,48(sp)
    80005e54:	05010113          	addi	sp,sp,80
    80005e58:	00008067          	ret
    80005e5c:	00000913          	li	s2,0
    80005e60:	fd5ff06f          	j	80005e34 <consolewrite+0x74>

0000000080005e64 <consoleread>:
    80005e64:	f9010113          	addi	sp,sp,-112
    80005e68:	06813023          	sd	s0,96(sp)
    80005e6c:	04913c23          	sd	s1,88(sp)
    80005e70:	05213823          	sd	s2,80(sp)
    80005e74:	05313423          	sd	s3,72(sp)
    80005e78:	05413023          	sd	s4,64(sp)
    80005e7c:	03513c23          	sd	s5,56(sp)
    80005e80:	03613823          	sd	s6,48(sp)
    80005e84:	03713423          	sd	s7,40(sp)
    80005e88:	03813023          	sd	s8,32(sp)
    80005e8c:	06113423          	sd	ra,104(sp)
    80005e90:	01913c23          	sd	s9,24(sp)
    80005e94:	07010413          	addi	s0,sp,112
    80005e98:	00060b93          	mv	s7,a2
    80005e9c:	00050913          	mv	s2,a0
    80005ea0:	00058c13          	mv	s8,a1
    80005ea4:	00060b1b          	sext.w	s6,a2
    80005ea8:	00006497          	auipc	s1,0x6
    80005eac:	54048493          	addi	s1,s1,1344 # 8000c3e8 <cons>
    80005eb0:	00400993          	li	s3,4
    80005eb4:	fff00a13          	li	s4,-1
    80005eb8:	00a00a93          	li	s5,10
    80005ebc:	05705e63          	blez	s7,80005f18 <consoleread+0xb4>
    80005ec0:	09c4a703          	lw	a4,156(s1)
    80005ec4:	0984a783          	lw	a5,152(s1)
    80005ec8:	0007071b          	sext.w	a4,a4
    80005ecc:	08e78463          	beq	a5,a4,80005f54 <consoleread+0xf0>
    80005ed0:	07f7f713          	andi	a4,a5,127
    80005ed4:	00e48733          	add	a4,s1,a4
    80005ed8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005edc:	0017869b          	addiw	a3,a5,1
    80005ee0:	08d4ac23          	sw	a3,152(s1)
    80005ee4:	00070c9b          	sext.w	s9,a4
    80005ee8:	0b370663          	beq	a4,s3,80005f94 <consoleread+0x130>
    80005eec:	00100693          	li	a3,1
    80005ef0:	f9f40613          	addi	a2,s0,-97
    80005ef4:	000c0593          	mv	a1,s8
    80005ef8:	00090513          	mv	a0,s2
    80005efc:	f8e40fa3          	sb	a4,-97(s0)
    80005f00:	00000097          	auipc	ra,0x0
    80005f04:	8bc080e7          	jalr	-1860(ra) # 800057bc <either_copyout>
    80005f08:	01450863          	beq	a0,s4,80005f18 <consoleread+0xb4>
    80005f0c:	001c0c13          	addi	s8,s8,1
    80005f10:	fffb8b9b          	addiw	s7,s7,-1
    80005f14:	fb5c94e3          	bne	s9,s5,80005ebc <consoleread+0x58>
    80005f18:	000b851b          	sext.w	a0,s7
    80005f1c:	06813083          	ld	ra,104(sp)
    80005f20:	06013403          	ld	s0,96(sp)
    80005f24:	05813483          	ld	s1,88(sp)
    80005f28:	05013903          	ld	s2,80(sp)
    80005f2c:	04813983          	ld	s3,72(sp)
    80005f30:	04013a03          	ld	s4,64(sp)
    80005f34:	03813a83          	ld	s5,56(sp)
    80005f38:	02813b83          	ld	s7,40(sp)
    80005f3c:	02013c03          	ld	s8,32(sp)
    80005f40:	01813c83          	ld	s9,24(sp)
    80005f44:	40ab053b          	subw	a0,s6,a0
    80005f48:	03013b03          	ld	s6,48(sp)
    80005f4c:	07010113          	addi	sp,sp,112
    80005f50:	00008067          	ret
    80005f54:	00001097          	auipc	ra,0x1
    80005f58:	1d8080e7          	jalr	472(ra) # 8000712c <push_on>
    80005f5c:	0984a703          	lw	a4,152(s1)
    80005f60:	09c4a783          	lw	a5,156(s1)
    80005f64:	0007879b          	sext.w	a5,a5
    80005f68:	fef70ce3          	beq	a4,a5,80005f60 <consoleread+0xfc>
    80005f6c:	00001097          	auipc	ra,0x1
    80005f70:	234080e7          	jalr	564(ra) # 800071a0 <pop_on>
    80005f74:	0984a783          	lw	a5,152(s1)
    80005f78:	07f7f713          	andi	a4,a5,127
    80005f7c:	00e48733          	add	a4,s1,a4
    80005f80:	01874703          	lbu	a4,24(a4)
    80005f84:	0017869b          	addiw	a3,a5,1
    80005f88:	08d4ac23          	sw	a3,152(s1)
    80005f8c:	00070c9b          	sext.w	s9,a4
    80005f90:	f5371ee3          	bne	a4,s3,80005eec <consoleread+0x88>
    80005f94:	000b851b          	sext.w	a0,s7
    80005f98:	f96bf2e3          	bgeu	s7,s6,80005f1c <consoleread+0xb8>
    80005f9c:	08f4ac23          	sw	a5,152(s1)
    80005fa0:	f7dff06f          	j	80005f1c <consoleread+0xb8>

0000000080005fa4 <consputc>:
    80005fa4:	10000793          	li	a5,256
    80005fa8:	00f50663          	beq	a0,a5,80005fb4 <consputc+0x10>
    80005fac:	00001317          	auipc	t1,0x1
    80005fb0:	9f430067          	jr	-1548(t1) # 800069a0 <uartputc_sync>
    80005fb4:	ff010113          	addi	sp,sp,-16
    80005fb8:	00113423          	sd	ra,8(sp)
    80005fbc:	00813023          	sd	s0,0(sp)
    80005fc0:	01010413          	addi	s0,sp,16
    80005fc4:	00800513          	li	a0,8
    80005fc8:	00001097          	auipc	ra,0x1
    80005fcc:	9d8080e7          	jalr	-1576(ra) # 800069a0 <uartputc_sync>
    80005fd0:	02000513          	li	a0,32
    80005fd4:	00001097          	auipc	ra,0x1
    80005fd8:	9cc080e7          	jalr	-1588(ra) # 800069a0 <uartputc_sync>
    80005fdc:	00013403          	ld	s0,0(sp)
    80005fe0:	00813083          	ld	ra,8(sp)
    80005fe4:	00800513          	li	a0,8
    80005fe8:	01010113          	addi	sp,sp,16
    80005fec:	00001317          	auipc	t1,0x1
    80005ff0:	9b430067          	jr	-1612(t1) # 800069a0 <uartputc_sync>

0000000080005ff4 <consoleintr>:
    80005ff4:	fe010113          	addi	sp,sp,-32
    80005ff8:	00813823          	sd	s0,16(sp)
    80005ffc:	00913423          	sd	s1,8(sp)
    80006000:	01213023          	sd	s2,0(sp)
    80006004:	00113c23          	sd	ra,24(sp)
    80006008:	02010413          	addi	s0,sp,32
    8000600c:	00006917          	auipc	s2,0x6
    80006010:	3dc90913          	addi	s2,s2,988 # 8000c3e8 <cons>
    80006014:	00050493          	mv	s1,a0
    80006018:	00090513          	mv	a0,s2
    8000601c:	00001097          	auipc	ra,0x1
    80006020:	e40080e7          	jalr	-448(ra) # 80006e5c <acquire>
    80006024:	02048c63          	beqz	s1,8000605c <consoleintr+0x68>
    80006028:	0a092783          	lw	a5,160(s2)
    8000602c:	09892703          	lw	a4,152(s2)
    80006030:	07f00693          	li	a3,127
    80006034:	40e7873b          	subw	a4,a5,a4
    80006038:	02e6e263          	bltu	a3,a4,8000605c <consoleintr+0x68>
    8000603c:	00d00713          	li	a4,13
    80006040:	04e48063          	beq	s1,a4,80006080 <consoleintr+0x8c>
    80006044:	07f7f713          	andi	a4,a5,127
    80006048:	00e90733          	add	a4,s2,a4
    8000604c:	0017879b          	addiw	a5,a5,1
    80006050:	0af92023          	sw	a5,160(s2)
    80006054:	00970c23          	sb	s1,24(a4)
    80006058:	08f92e23          	sw	a5,156(s2)
    8000605c:	01013403          	ld	s0,16(sp)
    80006060:	01813083          	ld	ra,24(sp)
    80006064:	00813483          	ld	s1,8(sp)
    80006068:	00013903          	ld	s2,0(sp)
    8000606c:	00006517          	auipc	a0,0x6
    80006070:	37c50513          	addi	a0,a0,892 # 8000c3e8 <cons>
    80006074:	02010113          	addi	sp,sp,32
    80006078:	00001317          	auipc	t1,0x1
    8000607c:	eb030067          	jr	-336(t1) # 80006f28 <release>
    80006080:	00a00493          	li	s1,10
    80006084:	fc1ff06f          	j	80006044 <consoleintr+0x50>

0000000080006088 <consoleinit>:
    80006088:	fe010113          	addi	sp,sp,-32
    8000608c:	00113c23          	sd	ra,24(sp)
    80006090:	00813823          	sd	s0,16(sp)
    80006094:	00913423          	sd	s1,8(sp)
    80006098:	02010413          	addi	s0,sp,32
    8000609c:	00006497          	auipc	s1,0x6
    800060a0:	34c48493          	addi	s1,s1,844 # 8000c3e8 <cons>
    800060a4:	00048513          	mv	a0,s1
    800060a8:	00002597          	auipc	a1,0x2
    800060ac:	69858593          	addi	a1,a1,1688 # 80008740 <CONSOLE_STATUS+0x730>
    800060b0:	00001097          	auipc	ra,0x1
    800060b4:	d88080e7          	jalr	-632(ra) # 80006e38 <initlock>
    800060b8:	00000097          	auipc	ra,0x0
    800060bc:	7ac080e7          	jalr	1964(ra) # 80006864 <uartinit>
    800060c0:	01813083          	ld	ra,24(sp)
    800060c4:	01013403          	ld	s0,16(sp)
    800060c8:	00000797          	auipc	a5,0x0
    800060cc:	d9c78793          	addi	a5,a5,-612 # 80005e64 <consoleread>
    800060d0:	0af4bc23          	sd	a5,184(s1)
    800060d4:	00000797          	auipc	a5,0x0
    800060d8:	cec78793          	addi	a5,a5,-788 # 80005dc0 <consolewrite>
    800060dc:	0cf4b023          	sd	a5,192(s1)
    800060e0:	00813483          	ld	s1,8(sp)
    800060e4:	02010113          	addi	sp,sp,32
    800060e8:	00008067          	ret

00000000800060ec <console_read>:
    800060ec:	ff010113          	addi	sp,sp,-16
    800060f0:	00813423          	sd	s0,8(sp)
    800060f4:	01010413          	addi	s0,sp,16
    800060f8:	00813403          	ld	s0,8(sp)
    800060fc:	00006317          	auipc	t1,0x6
    80006100:	3a433303          	ld	t1,932(t1) # 8000c4a0 <devsw+0x10>
    80006104:	01010113          	addi	sp,sp,16
    80006108:	00030067          	jr	t1

000000008000610c <console_write>:
    8000610c:	ff010113          	addi	sp,sp,-16
    80006110:	00813423          	sd	s0,8(sp)
    80006114:	01010413          	addi	s0,sp,16
    80006118:	00813403          	ld	s0,8(sp)
    8000611c:	00006317          	auipc	t1,0x6
    80006120:	38c33303          	ld	t1,908(t1) # 8000c4a8 <devsw+0x18>
    80006124:	01010113          	addi	sp,sp,16
    80006128:	00030067          	jr	t1

000000008000612c <panic>:
    8000612c:	fe010113          	addi	sp,sp,-32
    80006130:	00113c23          	sd	ra,24(sp)
    80006134:	00813823          	sd	s0,16(sp)
    80006138:	00913423          	sd	s1,8(sp)
    8000613c:	02010413          	addi	s0,sp,32
    80006140:	00050493          	mv	s1,a0
    80006144:	00002517          	auipc	a0,0x2
    80006148:	60450513          	addi	a0,a0,1540 # 80008748 <CONSOLE_STATUS+0x738>
    8000614c:	00006797          	auipc	a5,0x6
    80006150:	3e07ae23          	sw	zero,1020(a5) # 8000c548 <pr+0x18>
    80006154:	00000097          	auipc	ra,0x0
    80006158:	034080e7          	jalr	52(ra) # 80006188 <__printf>
    8000615c:	00048513          	mv	a0,s1
    80006160:	00000097          	auipc	ra,0x0
    80006164:	028080e7          	jalr	40(ra) # 80006188 <__printf>
    80006168:	00002517          	auipc	a0,0x2
    8000616c:	fb850513          	addi	a0,a0,-72 # 80008120 <CONSOLE_STATUS+0x110>
    80006170:	00000097          	auipc	ra,0x0
    80006174:	018080e7          	jalr	24(ra) # 80006188 <__printf>
    80006178:	00100793          	li	a5,1
    8000617c:	00005717          	auipc	a4,0x5
    80006180:	f0f72e23          	sw	a5,-228(a4) # 8000b098 <panicked>
    80006184:	0000006f          	j	80006184 <panic+0x58>

0000000080006188 <__printf>:
    80006188:	f3010113          	addi	sp,sp,-208
    8000618c:	08813023          	sd	s0,128(sp)
    80006190:	07313423          	sd	s3,104(sp)
    80006194:	09010413          	addi	s0,sp,144
    80006198:	05813023          	sd	s8,64(sp)
    8000619c:	08113423          	sd	ra,136(sp)
    800061a0:	06913c23          	sd	s1,120(sp)
    800061a4:	07213823          	sd	s2,112(sp)
    800061a8:	07413023          	sd	s4,96(sp)
    800061ac:	05513c23          	sd	s5,88(sp)
    800061b0:	05613823          	sd	s6,80(sp)
    800061b4:	05713423          	sd	s7,72(sp)
    800061b8:	03913c23          	sd	s9,56(sp)
    800061bc:	03a13823          	sd	s10,48(sp)
    800061c0:	03b13423          	sd	s11,40(sp)
    800061c4:	00006317          	auipc	t1,0x6
    800061c8:	36c30313          	addi	t1,t1,876 # 8000c530 <pr>
    800061cc:	01832c03          	lw	s8,24(t1)
    800061d0:	00b43423          	sd	a1,8(s0)
    800061d4:	00c43823          	sd	a2,16(s0)
    800061d8:	00d43c23          	sd	a3,24(s0)
    800061dc:	02e43023          	sd	a4,32(s0)
    800061e0:	02f43423          	sd	a5,40(s0)
    800061e4:	03043823          	sd	a6,48(s0)
    800061e8:	03143c23          	sd	a7,56(s0)
    800061ec:	00050993          	mv	s3,a0
    800061f0:	4a0c1663          	bnez	s8,8000669c <__printf+0x514>
    800061f4:	60098c63          	beqz	s3,8000680c <__printf+0x684>
    800061f8:	0009c503          	lbu	a0,0(s3)
    800061fc:	00840793          	addi	a5,s0,8
    80006200:	f6f43c23          	sd	a5,-136(s0)
    80006204:	00000493          	li	s1,0
    80006208:	22050063          	beqz	a0,80006428 <__printf+0x2a0>
    8000620c:	00002a37          	lui	s4,0x2
    80006210:	00018ab7          	lui	s5,0x18
    80006214:	000f4b37          	lui	s6,0xf4
    80006218:	00989bb7          	lui	s7,0x989
    8000621c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006220:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006224:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006228:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000622c:	00148c9b          	addiw	s9,s1,1
    80006230:	02500793          	li	a5,37
    80006234:	01998933          	add	s2,s3,s9
    80006238:	38f51263          	bne	a0,a5,800065bc <__printf+0x434>
    8000623c:	00094783          	lbu	a5,0(s2)
    80006240:	00078c9b          	sext.w	s9,a5
    80006244:	1e078263          	beqz	a5,80006428 <__printf+0x2a0>
    80006248:	0024849b          	addiw	s1,s1,2
    8000624c:	07000713          	li	a4,112
    80006250:	00998933          	add	s2,s3,s1
    80006254:	38e78a63          	beq	a5,a4,800065e8 <__printf+0x460>
    80006258:	20f76863          	bltu	a4,a5,80006468 <__printf+0x2e0>
    8000625c:	42a78863          	beq	a5,a0,8000668c <__printf+0x504>
    80006260:	06400713          	li	a4,100
    80006264:	40e79663          	bne	a5,a4,80006670 <__printf+0x4e8>
    80006268:	f7843783          	ld	a5,-136(s0)
    8000626c:	0007a603          	lw	a2,0(a5)
    80006270:	00878793          	addi	a5,a5,8
    80006274:	f6f43c23          	sd	a5,-136(s0)
    80006278:	42064a63          	bltz	a2,800066ac <__printf+0x524>
    8000627c:	00a00713          	li	a4,10
    80006280:	02e677bb          	remuw	a5,a2,a4
    80006284:	00002d97          	auipc	s11,0x2
    80006288:	4ecd8d93          	addi	s11,s11,1260 # 80008770 <digits>
    8000628c:	00900593          	li	a1,9
    80006290:	0006051b          	sext.w	a0,a2
    80006294:	00000c93          	li	s9,0
    80006298:	02079793          	slli	a5,a5,0x20
    8000629c:	0207d793          	srli	a5,a5,0x20
    800062a0:	00fd87b3          	add	a5,s11,a5
    800062a4:	0007c783          	lbu	a5,0(a5)
    800062a8:	02e656bb          	divuw	a3,a2,a4
    800062ac:	f8f40023          	sb	a5,-128(s0)
    800062b0:	14c5d863          	bge	a1,a2,80006400 <__printf+0x278>
    800062b4:	06300593          	li	a1,99
    800062b8:	00100c93          	li	s9,1
    800062bc:	02e6f7bb          	remuw	a5,a3,a4
    800062c0:	02079793          	slli	a5,a5,0x20
    800062c4:	0207d793          	srli	a5,a5,0x20
    800062c8:	00fd87b3          	add	a5,s11,a5
    800062cc:	0007c783          	lbu	a5,0(a5)
    800062d0:	02e6d73b          	divuw	a4,a3,a4
    800062d4:	f8f400a3          	sb	a5,-127(s0)
    800062d8:	12a5f463          	bgeu	a1,a0,80006400 <__printf+0x278>
    800062dc:	00a00693          	li	a3,10
    800062e0:	00900593          	li	a1,9
    800062e4:	02d777bb          	remuw	a5,a4,a3
    800062e8:	02079793          	slli	a5,a5,0x20
    800062ec:	0207d793          	srli	a5,a5,0x20
    800062f0:	00fd87b3          	add	a5,s11,a5
    800062f4:	0007c503          	lbu	a0,0(a5)
    800062f8:	02d757bb          	divuw	a5,a4,a3
    800062fc:	f8a40123          	sb	a0,-126(s0)
    80006300:	48e5f263          	bgeu	a1,a4,80006784 <__printf+0x5fc>
    80006304:	06300513          	li	a0,99
    80006308:	02d7f5bb          	remuw	a1,a5,a3
    8000630c:	02059593          	slli	a1,a1,0x20
    80006310:	0205d593          	srli	a1,a1,0x20
    80006314:	00bd85b3          	add	a1,s11,a1
    80006318:	0005c583          	lbu	a1,0(a1)
    8000631c:	02d7d7bb          	divuw	a5,a5,a3
    80006320:	f8b401a3          	sb	a1,-125(s0)
    80006324:	48e57263          	bgeu	a0,a4,800067a8 <__printf+0x620>
    80006328:	3e700513          	li	a0,999
    8000632c:	02d7f5bb          	remuw	a1,a5,a3
    80006330:	02059593          	slli	a1,a1,0x20
    80006334:	0205d593          	srli	a1,a1,0x20
    80006338:	00bd85b3          	add	a1,s11,a1
    8000633c:	0005c583          	lbu	a1,0(a1)
    80006340:	02d7d7bb          	divuw	a5,a5,a3
    80006344:	f8b40223          	sb	a1,-124(s0)
    80006348:	46e57663          	bgeu	a0,a4,800067b4 <__printf+0x62c>
    8000634c:	02d7f5bb          	remuw	a1,a5,a3
    80006350:	02059593          	slli	a1,a1,0x20
    80006354:	0205d593          	srli	a1,a1,0x20
    80006358:	00bd85b3          	add	a1,s11,a1
    8000635c:	0005c583          	lbu	a1,0(a1)
    80006360:	02d7d7bb          	divuw	a5,a5,a3
    80006364:	f8b402a3          	sb	a1,-123(s0)
    80006368:	46ea7863          	bgeu	s4,a4,800067d8 <__printf+0x650>
    8000636c:	02d7f5bb          	remuw	a1,a5,a3
    80006370:	02059593          	slli	a1,a1,0x20
    80006374:	0205d593          	srli	a1,a1,0x20
    80006378:	00bd85b3          	add	a1,s11,a1
    8000637c:	0005c583          	lbu	a1,0(a1)
    80006380:	02d7d7bb          	divuw	a5,a5,a3
    80006384:	f8b40323          	sb	a1,-122(s0)
    80006388:	3eeaf863          	bgeu	s5,a4,80006778 <__printf+0x5f0>
    8000638c:	02d7f5bb          	remuw	a1,a5,a3
    80006390:	02059593          	slli	a1,a1,0x20
    80006394:	0205d593          	srli	a1,a1,0x20
    80006398:	00bd85b3          	add	a1,s11,a1
    8000639c:	0005c583          	lbu	a1,0(a1)
    800063a0:	02d7d7bb          	divuw	a5,a5,a3
    800063a4:	f8b403a3          	sb	a1,-121(s0)
    800063a8:	42eb7e63          	bgeu	s6,a4,800067e4 <__printf+0x65c>
    800063ac:	02d7f5bb          	remuw	a1,a5,a3
    800063b0:	02059593          	slli	a1,a1,0x20
    800063b4:	0205d593          	srli	a1,a1,0x20
    800063b8:	00bd85b3          	add	a1,s11,a1
    800063bc:	0005c583          	lbu	a1,0(a1)
    800063c0:	02d7d7bb          	divuw	a5,a5,a3
    800063c4:	f8b40423          	sb	a1,-120(s0)
    800063c8:	42ebfc63          	bgeu	s7,a4,80006800 <__printf+0x678>
    800063cc:	02079793          	slli	a5,a5,0x20
    800063d0:	0207d793          	srli	a5,a5,0x20
    800063d4:	00fd8db3          	add	s11,s11,a5
    800063d8:	000dc703          	lbu	a4,0(s11)
    800063dc:	00a00793          	li	a5,10
    800063e0:	00900c93          	li	s9,9
    800063e4:	f8e404a3          	sb	a4,-119(s0)
    800063e8:	00065c63          	bgez	a2,80006400 <__printf+0x278>
    800063ec:	f9040713          	addi	a4,s0,-112
    800063f0:	00f70733          	add	a4,a4,a5
    800063f4:	02d00693          	li	a3,45
    800063f8:	fed70823          	sb	a3,-16(a4)
    800063fc:	00078c93          	mv	s9,a5
    80006400:	f8040793          	addi	a5,s0,-128
    80006404:	01978cb3          	add	s9,a5,s9
    80006408:	f7f40d13          	addi	s10,s0,-129
    8000640c:	000cc503          	lbu	a0,0(s9)
    80006410:	fffc8c93          	addi	s9,s9,-1
    80006414:	00000097          	auipc	ra,0x0
    80006418:	b90080e7          	jalr	-1136(ra) # 80005fa4 <consputc>
    8000641c:	ffac98e3          	bne	s9,s10,8000640c <__printf+0x284>
    80006420:	00094503          	lbu	a0,0(s2)
    80006424:	e00514e3          	bnez	a0,8000622c <__printf+0xa4>
    80006428:	1a0c1663          	bnez	s8,800065d4 <__printf+0x44c>
    8000642c:	08813083          	ld	ra,136(sp)
    80006430:	08013403          	ld	s0,128(sp)
    80006434:	07813483          	ld	s1,120(sp)
    80006438:	07013903          	ld	s2,112(sp)
    8000643c:	06813983          	ld	s3,104(sp)
    80006440:	06013a03          	ld	s4,96(sp)
    80006444:	05813a83          	ld	s5,88(sp)
    80006448:	05013b03          	ld	s6,80(sp)
    8000644c:	04813b83          	ld	s7,72(sp)
    80006450:	04013c03          	ld	s8,64(sp)
    80006454:	03813c83          	ld	s9,56(sp)
    80006458:	03013d03          	ld	s10,48(sp)
    8000645c:	02813d83          	ld	s11,40(sp)
    80006460:	0d010113          	addi	sp,sp,208
    80006464:	00008067          	ret
    80006468:	07300713          	li	a4,115
    8000646c:	1ce78a63          	beq	a5,a4,80006640 <__printf+0x4b8>
    80006470:	07800713          	li	a4,120
    80006474:	1ee79e63          	bne	a5,a4,80006670 <__printf+0x4e8>
    80006478:	f7843783          	ld	a5,-136(s0)
    8000647c:	0007a703          	lw	a4,0(a5)
    80006480:	00878793          	addi	a5,a5,8
    80006484:	f6f43c23          	sd	a5,-136(s0)
    80006488:	28074263          	bltz	a4,8000670c <__printf+0x584>
    8000648c:	00002d97          	auipc	s11,0x2
    80006490:	2e4d8d93          	addi	s11,s11,740 # 80008770 <digits>
    80006494:	00f77793          	andi	a5,a4,15
    80006498:	00fd87b3          	add	a5,s11,a5
    8000649c:	0007c683          	lbu	a3,0(a5)
    800064a0:	00f00613          	li	a2,15
    800064a4:	0007079b          	sext.w	a5,a4
    800064a8:	f8d40023          	sb	a3,-128(s0)
    800064ac:	0047559b          	srliw	a1,a4,0x4
    800064b0:	0047569b          	srliw	a3,a4,0x4
    800064b4:	00000c93          	li	s9,0
    800064b8:	0ee65063          	bge	a2,a4,80006598 <__printf+0x410>
    800064bc:	00f6f693          	andi	a3,a3,15
    800064c0:	00dd86b3          	add	a3,s11,a3
    800064c4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800064c8:	0087d79b          	srliw	a5,a5,0x8
    800064cc:	00100c93          	li	s9,1
    800064d0:	f8d400a3          	sb	a3,-127(s0)
    800064d4:	0cb67263          	bgeu	a2,a1,80006598 <__printf+0x410>
    800064d8:	00f7f693          	andi	a3,a5,15
    800064dc:	00dd86b3          	add	a3,s11,a3
    800064e0:	0006c583          	lbu	a1,0(a3)
    800064e4:	00f00613          	li	a2,15
    800064e8:	0047d69b          	srliw	a3,a5,0x4
    800064ec:	f8b40123          	sb	a1,-126(s0)
    800064f0:	0047d593          	srli	a1,a5,0x4
    800064f4:	28f67e63          	bgeu	a2,a5,80006790 <__printf+0x608>
    800064f8:	00f6f693          	andi	a3,a3,15
    800064fc:	00dd86b3          	add	a3,s11,a3
    80006500:	0006c503          	lbu	a0,0(a3)
    80006504:	0087d813          	srli	a6,a5,0x8
    80006508:	0087d69b          	srliw	a3,a5,0x8
    8000650c:	f8a401a3          	sb	a0,-125(s0)
    80006510:	28b67663          	bgeu	a2,a1,8000679c <__printf+0x614>
    80006514:	00f6f693          	andi	a3,a3,15
    80006518:	00dd86b3          	add	a3,s11,a3
    8000651c:	0006c583          	lbu	a1,0(a3)
    80006520:	00c7d513          	srli	a0,a5,0xc
    80006524:	00c7d69b          	srliw	a3,a5,0xc
    80006528:	f8b40223          	sb	a1,-124(s0)
    8000652c:	29067a63          	bgeu	a2,a6,800067c0 <__printf+0x638>
    80006530:	00f6f693          	andi	a3,a3,15
    80006534:	00dd86b3          	add	a3,s11,a3
    80006538:	0006c583          	lbu	a1,0(a3)
    8000653c:	0107d813          	srli	a6,a5,0x10
    80006540:	0107d69b          	srliw	a3,a5,0x10
    80006544:	f8b402a3          	sb	a1,-123(s0)
    80006548:	28a67263          	bgeu	a2,a0,800067cc <__printf+0x644>
    8000654c:	00f6f693          	andi	a3,a3,15
    80006550:	00dd86b3          	add	a3,s11,a3
    80006554:	0006c683          	lbu	a3,0(a3)
    80006558:	0147d79b          	srliw	a5,a5,0x14
    8000655c:	f8d40323          	sb	a3,-122(s0)
    80006560:	21067663          	bgeu	a2,a6,8000676c <__printf+0x5e4>
    80006564:	02079793          	slli	a5,a5,0x20
    80006568:	0207d793          	srli	a5,a5,0x20
    8000656c:	00fd8db3          	add	s11,s11,a5
    80006570:	000dc683          	lbu	a3,0(s11)
    80006574:	00800793          	li	a5,8
    80006578:	00700c93          	li	s9,7
    8000657c:	f8d403a3          	sb	a3,-121(s0)
    80006580:	00075c63          	bgez	a4,80006598 <__printf+0x410>
    80006584:	f9040713          	addi	a4,s0,-112
    80006588:	00f70733          	add	a4,a4,a5
    8000658c:	02d00693          	li	a3,45
    80006590:	fed70823          	sb	a3,-16(a4)
    80006594:	00078c93          	mv	s9,a5
    80006598:	f8040793          	addi	a5,s0,-128
    8000659c:	01978cb3          	add	s9,a5,s9
    800065a0:	f7f40d13          	addi	s10,s0,-129
    800065a4:	000cc503          	lbu	a0,0(s9)
    800065a8:	fffc8c93          	addi	s9,s9,-1
    800065ac:	00000097          	auipc	ra,0x0
    800065b0:	9f8080e7          	jalr	-1544(ra) # 80005fa4 <consputc>
    800065b4:	ff9d18e3          	bne	s10,s9,800065a4 <__printf+0x41c>
    800065b8:	0100006f          	j	800065c8 <__printf+0x440>
    800065bc:	00000097          	auipc	ra,0x0
    800065c0:	9e8080e7          	jalr	-1560(ra) # 80005fa4 <consputc>
    800065c4:	000c8493          	mv	s1,s9
    800065c8:	00094503          	lbu	a0,0(s2)
    800065cc:	c60510e3          	bnez	a0,8000622c <__printf+0xa4>
    800065d0:	e40c0ee3          	beqz	s8,8000642c <__printf+0x2a4>
    800065d4:	00006517          	auipc	a0,0x6
    800065d8:	f5c50513          	addi	a0,a0,-164 # 8000c530 <pr>
    800065dc:	00001097          	auipc	ra,0x1
    800065e0:	94c080e7          	jalr	-1716(ra) # 80006f28 <release>
    800065e4:	e49ff06f          	j	8000642c <__printf+0x2a4>
    800065e8:	f7843783          	ld	a5,-136(s0)
    800065ec:	03000513          	li	a0,48
    800065f0:	01000d13          	li	s10,16
    800065f4:	00878713          	addi	a4,a5,8
    800065f8:	0007bc83          	ld	s9,0(a5)
    800065fc:	f6e43c23          	sd	a4,-136(s0)
    80006600:	00000097          	auipc	ra,0x0
    80006604:	9a4080e7          	jalr	-1628(ra) # 80005fa4 <consputc>
    80006608:	07800513          	li	a0,120
    8000660c:	00000097          	auipc	ra,0x0
    80006610:	998080e7          	jalr	-1640(ra) # 80005fa4 <consputc>
    80006614:	00002d97          	auipc	s11,0x2
    80006618:	15cd8d93          	addi	s11,s11,348 # 80008770 <digits>
    8000661c:	03ccd793          	srli	a5,s9,0x3c
    80006620:	00fd87b3          	add	a5,s11,a5
    80006624:	0007c503          	lbu	a0,0(a5)
    80006628:	fffd0d1b          	addiw	s10,s10,-1
    8000662c:	004c9c93          	slli	s9,s9,0x4
    80006630:	00000097          	auipc	ra,0x0
    80006634:	974080e7          	jalr	-1676(ra) # 80005fa4 <consputc>
    80006638:	fe0d12e3          	bnez	s10,8000661c <__printf+0x494>
    8000663c:	f8dff06f          	j	800065c8 <__printf+0x440>
    80006640:	f7843783          	ld	a5,-136(s0)
    80006644:	0007bc83          	ld	s9,0(a5)
    80006648:	00878793          	addi	a5,a5,8
    8000664c:	f6f43c23          	sd	a5,-136(s0)
    80006650:	000c9a63          	bnez	s9,80006664 <__printf+0x4dc>
    80006654:	1080006f          	j	8000675c <__printf+0x5d4>
    80006658:	001c8c93          	addi	s9,s9,1
    8000665c:	00000097          	auipc	ra,0x0
    80006660:	948080e7          	jalr	-1720(ra) # 80005fa4 <consputc>
    80006664:	000cc503          	lbu	a0,0(s9)
    80006668:	fe0518e3          	bnez	a0,80006658 <__printf+0x4d0>
    8000666c:	f5dff06f          	j	800065c8 <__printf+0x440>
    80006670:	02500513          	li	a0,37
    80006674:	00000097          	auipc	ra,0x0
    80006678:	930080e7          	jalr	-1744(ra) # 80005fa4 <consputc>
    8000667c:	000c8513          	mv	a0,s9
    80006680:	00000097          	auipc	ra,0x0
    80006684:	924080e7          	jalr	-1756(ra) # 80005fa4 <consputc>
    80006688:	f41ff06f          	j	800065c8 <__printf+0x440>
    8000668c:	02500513          	li	a0,37
    80006690:	00000097          	auipc	ra,0x0
    80006694:	914080e7          	jalr	-1772(ra) # 80005fa4 <consputc>
    80006698:	f31ff06f          	j	800065c8 <__printf+0x440>
    8000669c:	00030513          	mv	a0,t1
    800066a0:	00000097          	auipc	ra,0x0
    800066a4:	7bc080e7          	jalr	1980(ra) # 80006e5c <acquire>
    800066a8:	b4dff06f          	j	800061f4 <__printf+0x6c>
    800066ac:	40c0053b          	negw	a0,a2
    800066b0:	00a00713          	li	a4,10
    800066b4:	02e576bb          	remuw	a3,a0,a4
    800066b8:	00002d97          	auipc	s11,0x2
    800066bc:	0b8d8d93          	addi	s11,s11,184 # 80008770 <digits>
    800066c0:	ff700593          	li	a1,-9
    800066c4:	02069693          	slli	a3,a3,0x20
    800066c8:	0206d693          	srli	a3,a3,0x20
    800066cc:	00dd86b3          	add	a3,s11,a3
    800066d0:	0006c683          	lbu	a3,0(a3)
    800066d4:	02e557bb          	divuw	a5,a0,a4
    800066d8:	f8d40023          	sb	a3,-128(s0)
    800066dc:	10b65e63          	bge	a2,a1,800067f8 <__printf+0x670>
    800066e0:	06300593          	li	a1,99
    800066e4:	02e7f6bb          	remuw	a3,a5,a4
    800066e8:	02069693          	slli	a3,a3,0x20
    800066ec:	0206d693          	srli	a3,a3,0x20
    800066f0:	00dd86b3          	add	a3,s11,a3
    800066f4:	0006c683          	lbu	a3,0(a3)
    800066f8:	02e7d73b          	divuw	a4,a5,a4
    800066fc:	00200793          	li	a5,2
    80006700:	f8d400a3          	sb	a3,-127(s0)
    80006704:	bca5ece3          	bltu	a1,a0,800062dc <__printf+0x154>
    80006708:	ce5ff06f          	j	800063ec <__printf+0x264>
    8000670c:	40e007bb          	negw	a5,a4
    80006710:	00002d97          	auipc	s11,0x2
    80006714:	060d8d93          	addi	s11,s11,96 # 80008770 <digits>
    80006718:	00f7f693          	andi	a3,a5,15
    8000671c:	00dd86b3          	add	a3,s11,a3
    80006720:	0006c583          	lbu	a1,0(a3)
    80006724:	ff100613          	li	a2,-15
    80006728:	0047d69b          	srliw	a3,a5,0x4
    8000672c:	f8b40023          	sb	a1,-128(s0)
    80006730:	0047d59b          	srliw	a1,a5,0x4
    80006734:	0ac75e63          	bge	a4,a2,800067f0 <__printf+0x668>
    80006738:	00f6f693          	andi	a3,a3,15
    8000673c:	00dd86b3          	add	a3,s11,a3
    80006740:	0006c603          	lbu	a2,0(a3)
    80006744:	00f00693          	li	a3,15
    80006748:	0087d79b          	srliw	a5,a5,0x8
    8000674c:	f8c400a3          	sb	a2,-127(s0)
    80006750:	d8b6e4e3          	bltu	a3,a1,800064d8 <__printf+0x350>
    80006754:	00200793          	li	a5,2
    80006758:	e2dff06f          	j	80006584 <__printf+0x3fc>
    8000675c:	00002c97          	auipc	s9,0x2
    80006760:	ff4c8c93          	addi	s9,s9,-12 # 80008750 <CONSOLE_STATUS+0x740>
    80006764:	02800513          	li	a0,40
    80006768:	ef1ff06f          	j	80006658 <__printf+0x4d0>
    8000676c:	00700793          	li	a5,7
    80006770:	00600c93          	li	s9,6
    80006774:	e0dff06f          	j	80006580 <__printf+0x3f8>
    80006778:	00700793          	li	a5,7
    8000677c:	00600c93          	li	s9,6
    80006780:	c69ff06f          	j	800063e8 <__printf+0x260>
    80006784:	00300793          	li	a5,3
    80006788:	00200c93          	li	s9,2
    8000678c:	c5dff06f          	j	800063e8 <__printf+0x260>
    80006790:	00300793          	li	a5,3
    80006794:	00200c93          	li	s9,2
    80006798:	de9ff06f          	j	80006580 <__printf+0x3f8>
    8000679c:	00400793          	li	a5,4
    800067a0:	00300c93          	li	s9,3
    800067a4:	dddff06f          	j	80006580 <__printf+0x3f8>
    800067a8:	00400793          	li	a5,4
    800067ac:	00300c93          	li	s9,3
    800067b0:	c39ff06f          	j	800063e8 <__printf+0x260>
    800067b4:	00500793          	li	a5,5
    800067b8:	00400c93          	li	s9,4
    800067bc:	c2dff06f          	j	800063e8 <__printf+0x260>
    800067c0:	00500793          	li	a5,5
    800067c4:	00400c93          	li	s9,4
    800067c8:	db9ff06f          	j	80006580 <__printf+0x3f8>
    800067cc:	00600793          	li	a5,6
    800067d0:	00500c93          	li	s9,5
    800067d4:	dadff06f          	j	80006580 <__printf+0x3f8>
    800067d8:	00600793          	li	a5,6
    800067dc:	00500c93          	li	s9,5
    800067e0:	c09ff06f          	j	800063e8 <__printf+0x260>
    800067e4:	00800793          	li	a5,8
    800067e8:	00700c93          	li	s9,7
    800067ec:	bfdff06f          	j	800063e8 <__printf+0x260>
    800067f0:	00100793          	li	a5,1
    800067f4:	d91ff06f          	j	80006584 <__printf+0x3fc>
    800067f8:	00100793          	li	a5,1
    800067fc:	bf1ff06f          	j	800063ec <__printf+0x264>
    80006800:	00900793          	li	a5,9
    80006804:	00800c93          	li	s9,8
    80006808:	be1ff06f          	j	800063e8 <__printf+0x260>
    8000680c:	00002517          	auipc	a0,0x2
    80006810:	f4c50513          	addi	a0,a0,-180 # 80008758 <CONSOLE_STATUS+0x748>
    80006814:	00000097          	auipc	ra,0x0
    80006818:	918080e7          	jalr	-1768(ra) # 8000612c <panic>

000000008000681c <printfinit>:
    8000681c:	fe010113          	addi	sp,sp,-32
    80006820:	00813823          	sd	s0,16(sp)
    80006824:	00913423          	sd	s1,8(sp)
    80006828:	00113c23          	sd	ra,24(sp)
    8000682c:	02010413          	addi	s0,sp,32
    80006830:	00006497          	auipc	s1,0x6
    80006834:	d0048493          	addi	s1,s1,-768 # 8000c530 <pr>
    80006838:	00048513          	mv	a0,s1
    8000683c:	00002597          	auipc	a1,0x2
    80006840:	f2c58593          	addi	a1,a1,-212 # 80008768 <CONSOLE_STATUS+0x758>
    80006844:	00000097          	auipc	ra,0x0
    80006848:	5f4080e7          	jalr	1524(ra) # 80006e38 <initlock>
    8000684c:	01813083          	ld	ra,24(sp)
    80006850:	01013403          	ld	s0,16(sp)
    80006854:	0004ac23          	sw	zero,24(s1)
    80006858:	00813483          	ld	s1,8(sp)
    8000685c:	02010113          	addi	sp,sp,32
    80006860:	00008067          	ret

0000000080006864 <uartinit>:
    80006864:	ff010113          	addi	sp,sp,-16
    80006868:	00813423          	sd	s0,8(sp)
    8000686c:	01010413          	addi	s0,sp,16
    80006870:	100007b7          	lui	a5,0x10000
    80006874:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006878:	f8000713          	li	a4,-128
    8000687c:	00e781a3          	sb	a4,3(a5)
    80006880:	00300713          	li	a4,3
    80006884:	00e78023          	sb	a4,0(a5)
    80006888:	000780a3          	sb	zero,1(a5)
    8000688c:	00e781a3          	sb	a4,3(a5)
    80006890:	00700693          	li	a3,7
    80006894:	00d78123          	sb	a3,2(a5)
    80006898:	00e780a3          	sb	a4,1(a5)
    8000689c:	00813403          	ld	s0,8(sp)
    800068a0:	01010113          	addi	sp,sp,16
    800068a4:	00008067          	ret

00000000800068a8 <uartputc>:
    800068a8:	00004797          	auipc	a5,0x4
    800068ac:	7f07a783          	lw	a5,2032(a5) # 8000b098 <panicked>
    800068b0:	00078463          	beqz	a5,800068b8 <uartputc+0x10>
    800068b4:	0000006f          	j	800068b4 <uartputc+0xc>
    800068b8:	fd010113          	addi	sp,sp,-48
    800068bc:	02813023          	sd	s0,32(sp)
    800068c0:	00913c23          	sd	s1,24(sp)
    800068c4:	01213823          	sd	s2,16(sp)
    800068c8:	01313423          	sd	s3,8(sp)
    800068cc:	02113423          	sd	ra,40(sp)
    800068d0:	03010413          	addi	s0,sp,48
    800068d4:	00004917          	auipc	s2,0x4
    800068d8:	7cc90913          	addi	s2,s2,1996 # 8000b0a0 <uart_tx_r>
    800068dc:	00093783          	ld	a5,0(s2)
    800068e0:	00004497          	auipc	s1,0x4
    800068e4:	7c848493          	addi	s1,s1,1992 # 8000b0a8 <uart_tx_w>
    800068e8:	0004b703          	ld	a4,0(s1)
    800068ec:	02078693          	addi	a3,a5,32
    800068f0:	00050993          	mv	s3,a0
    800068f4:	02e69c63          	bne	a3,a4,8000692c <uartputc+0x84>
    800068f8:	00001097          	auipc	ra,0x1
    800068fc:	834080e7          	jalr	-1996(ra) # 8000712c <push_on>
    80006900:	00093783          	ld	a5,0(s2)
    80006904:	0004b703          	ld	a4,0(s1)
    80006908:	02078793          	addi	a5,a5,32
    8000690c:	00e79463          	bne	a5,a4,80006914 <uartputc+0x6c>
    80006910:	0000006f          	j	80006910 <uartputc+0x68>
    80006914:	00001097          	auipc	ra,0x1
    80006918:	88c080e7          	jalr	-1908(ra) # 800071a0 <pop_on>
    8000691c:	00093783          	ld	a5,0(s2)
    80006920:	0004b703          	ld	a4,0(s1)
    80006924:	02078693          	addi	a3,a5,32
    80006928:	fce688e3          	beq	a3,a4,800068f8 <uartputc+0x50>
    8000692c:	01f77693          	andi	a3,a4,31
    80006930:	00006597          	auipc	a1,0x6
    80006934:	c2058593          	addi	a1,a1,-992 # 8000c550 <uart_tx_buf>
    80006938:	00d586b3          	add	a3,a1,a3
    8000693c:	00170713          	addi	a4,a4,1
    80006940:	01368023          	sb	s3,0(a3)
    80006944:	00e4b023          	sd	a4,0(s1)
    80006948:	10000637          	lui	a2,0x10000
    8000694c:	02f71063          	bne	a4,a5,8000696c <uartputc+0xc4>
    80006950:	0340006f          	j	80006984 <uartputc+0xdc>
    80006954:	00074703          	lbu	a4,0(a4)
    80006958:	00f93023          	sd	a5,0(s2)
    8000695c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006960:	00093783          	ld	a5,0(s2)
    80006964:	0004b703          	ld	a4,0(s1)
    80006968:	00f70e63          	beq	a4,a5,80006984 <uartputc+0xdc>
    8000696c:	00564683          	lbu	a3,5(a2)
    80006970:	01f7f713          	andi	a4,a5,31
    80006974:	00e58733          	add	a4,a1,a4
    80006978:	0206f693          	andi	a3,a3,32
    8000697c:	00178793          	addi	a5,a5,1
    80006980:	fc069ae3          	bnez	a3,80006954 <uartputc+0xac>
    80006984:	02813083          	ld	ra,40(sp)
    80006988:	02013403          	ld	s0,32(sp)
    8000698c:	01813483          	ld	s1,24(sp)
    80006990:	01013903          	ld	s2,16(sp)
    80006994:	00813983          	ld	s3,8(sp)
    80006998:	03010113          	addi	sp,sp,48
    8000699c:	00008067          	ret

00000000800069a0 <uartputc_sync>:
    800069a0:	ff010113          	addi	sp,sp,-16
    800069a4:	00813423          	sd	s0,8(sp)
    800069a8:	01010413          	addi	s0,sp,16
    800069ac:	00004717          	auipc	a4,0x4
    800069b0:	6ec72703          	lw	a4,1772(a4) # 8000b098 <panicked>
    800069b4:	02071663          	bnez	a4,800069e0 <uartputc_sync+0x40>
    800069b8:	00050793          	mv	a5,a0
    800069bc:	100006b7          	lui	a3,0x10000
    800069c0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800069c4:	02077713          	andi	a4,a4,32
    800069c8:	fe070ce3          	beqz	a4,800069c0 <uartputc_sync+0x20>
    800069cc:	0ff7f793          	andi	a5,a5,255
    800069d0:	00f68023          	sb	a5,0(a3)
    800069d4:	00813403          	ld	s0,8(sp)
    800069d8:	01010113          	addi	sp,sp,16
    800069dc:	00008067          	ret
    800069e0:	0000006f          	j	800069e0 <uartputc_sync+0x40>

00000000800069e4 <uartstart>:
    800069e4:	ff010113          	addi	sp,sp,-16
    800069e8:	00813423          	sd	s0,8(sp)
    800069ec:	01010413          	addi	s0,sp,16
    800069f0:	00004617          	auipc	a2,0x4
    800069f4:	6b060613          	addi	a2,a2,1712 # 8000b0a0 <uart_tx_r>
    800069f8:	00004517          	auipc	a0,0x4
    800069fc:	6b050513          	addi	a0,a0,1712 # 8000b0a8 <uart_tx_w>
    80006a00:	00063783          	ld	a5,0(a2)
    80006a04:	00053703          	ld	a4,0(a0)
    80006a08:	04f70263          	beq	a4,a5,80006a4c <uartstart+0x68>
    80006a0c:	100005b7          	lui	a1,0x10000
    80006a10:	00006817          	auipc	a6,0x6
    80006a14:	b4080813          	addi	a6,a6,-1216 # 8000c550 <uart_tx_buf>
    80006a18:	01c0006f          	j	80006a34 <uartstart+0x50>
    80006a1c:	0006c703          	lbu	a4,0(a3)
    80006a20:	00f63023          	sd	a5,0(a2)
    80006a24:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006a28:	00063783          	ld	a5,0(a2)
    80006a2c:	00053703          	ld	a4,0(a0)
    80006a30:	00f70e63          	beq	a4,a5,80006a4c <uartstart+0x68>
    80006a34:	01f7f713          	andi	a4,a5,31
    80006a38:	00e806b3          	add	a3,a6,a4
    80006a3c:	0055c703          	lbu	a4,5(a1)
    80006a40:	00178793          	addi	a5,a5,1
    80006a44:	02077713          	andi	a4,a4,32
    80006a48:	fc071ae3          	bnez	a4,80006a1c <uartstart+0x38>
    80006a4c:	00813403          	ld	s0,8(sp)
    80006a50:	01010113          	addi	sp,sp,16
    80006a54:	00008067          	ret

0000000080006a58 <uartgetc>:
    80006a58:	ff010113          	addi	sp,sp,-16
    80006a5c:	00813423          	sd	s0,8(sp)
    80006a60:	01010413          	addi	s0,sp,16
    80006a64:	10000737          	lui	a4,0x10000
    80006a68:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80006a6c:	0017f793          	andi	a5,a5,1
    80006a70:	00078c63          	beqz	a5,80006a88 <uartgetc+0x30>
    80006a74:	00074503          	lbu	a0,0(a4)
    80006a78:	0ff57513          	andi	a0,a0,255
    80006a7c:	00813403          	ld	s0,8(sp)
    80006a80:	01010113          	addi	sp,sp,16
    80006a84:	00008067          	ret
    80006a88:	fff00513          	li	a0,-1
    80006a8c:	ff1ff06f          	j	80006a7c <uartgetc+0x24>

0000000080006a90 <uartintr>:
    80006a90:	100007b7          	lui	a5,0x10000
    80006a94:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006a98:	0017f793          	andi	a5,a5,1
    80006a9c:	0a078463          	beqz	a5,80006b44 <uartintr+0xb4>
    80006aa0:	fe010113          	addi	sp,sp,-32
    80006aa4:	00813823          	sd	s0,16(sp)
    80006aa8:	00913423          	sd	s1,8(sp)
    80006aac:	00113c23          	sd	ra,24(sp)
    80006ab0:	02010413          	addi	s0,sp,32
    80006ab4:	100004b7          	lui	s1,0x10000
    80006ab8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80006abc:	0ff57513          	andi	a0,a0,255
    80006ac0:	fffff097          	auipc	ra,0xfffff
    80006ac4:	534080e7          	jalr	1332(ra) # 80005ff4 <consoleintr>
    80006ac8:	0054c783          	lbu	a5,5(s1)
    80006acc:	0017f793          	andi	a5,a5,1
    80006ad0:	fe0794e3          	bnez	a5,80006ab8 <uartintr+0x28>
    80006ad4:	00004617          	auipc	a2,0x4
    80006ad8:	5cc60613          	addi	a2,a2,1484 # 8000b0a0 <uart_tx_r>
    80006adc:	00004517          	auipc	a0,0x4
    80006ae0:	5cc50513          	addi	a0,a0,1484 # 8000b0a8 <uart_tx_w>
    80006ae4:	00063783          	ld	a5,0(a2)
    80006ae8:	00053703          	ld	a4,0(a0)
    80006aec:	04f70263          	beq	a4,a5,80006b30 <uartintr+0xa0>
    80006af0:	100005b7          	lui	a1,0x10000
    80006af4:	00006817          	auipc	a6,0x6
    80006af8:	a5c80813          	addi	a6,a6,-1444 # 8000c550 <uart_tx_buf>
    80006afc:	01c0006f          	j	80006b18 <uartintr+0x88>
    80006b00:	0006c703          	lbu	a4,0(a3)
    80006b04:	00f63023          	sd	a5,0(a2)
    80006b08:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006b0c:	00063783          	ld	a5,0(a2)
    80006b10:	00053703          	ld	a4,0(a0)
    80006b14:	00f70e63          	beq	a4,a5,80006b30 <uartintr+0xa0>
    80006b18:	01f7f713          	andi	a4,a5,31
    80006b1c:	00e806b3          	add	a3,a6,a4
    80006b20:	0055c703          	lbu	a4,5(a1)
    80006b24:	00178793          	addi	a5,a5,1
    80006b28:	02077713          	andi	a4,a4,32
    80006b2c:	fc071ae3          	bnez	a4,80006b00 <uartintr+0x70>
    80006b30:	01813083          	ld	ra,24(sp)
    80006b34:	01013403          	ld	s0,16(sp)
    80006b38:	00813483          	ld	s1,8(sp)
    80006b3c:	02010113          	addi	sp,sp,32
    80006b40:	00008067          	ret
    80006b44:	00004617          	auipc	a2,0x4
    80006b48:	55c60613          	addi	a2,a2,1372 # 8000b0a0 <uart_tx_r>
    80006b4c:	00004517          	auipc	a0,0x4
    80006b50:	55c50513          	addi	a0,a0,1372 # 8000b0a8 <uart_tx_w>
    80006b54:	00063783          	ld	a5,0(a2)
    80006b58:	00053703          	ld	a4,0(a0)
    80006b5c:	04f70263          	beq	a4,a5,80006ba0 <uartintr+0x110>
    80006b60:	100005b7          	lui	a1,0x10000
    80006b64:	00006817          	auipc	a6,0x6
    80006b68:	9ec80813          	addi	a6,a6,-1556 # 8000c550 <uart_tx_buf>
    80006b6c:	01c0006f          	j	80006b88 <uartintr+0xf8>
    80006b70:	0006c703          	lbu	a4,0(a3)
    80006b74:	00f63023          	sd	a5,0(a2)
    80006b78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006b7c:	00063783          	ld	a5,0(a2)
    80006b80:	00053703          	ld	a4,0(a0)
    80006b84:	02f70063          	beq	a4,a5,80006ba4 <uartintr+0x114>
    80006b88:	01f7f713          	andi	a4,a5,31
    80006b8c:	00e806b3          	add	a3,a6,a4
    80006b90:	0055c703          	lbu	a4,5(a1)
    80006b94:	00178793          	addi	a5,a5,1
    80006b98:	02077713          	andi	a4,a4,32
    80006b9c:	fc071ae3          	bnez	a4,80006b70 <uartintr+0xe0>
    80006ba0:	00008067          	ret
    80006ba4:	00008067          	ret

0000000080006ba8 <kinit>:
    80006ba8:	fc010113          	addi	sp,sp,-64
    80006bac:	02913423          	sd	s1,40(sp)
    80006bb0:	fffff7b7          	lui	a5,0xfffff
    80006bb4:	0000b497          	auipc	s1,0xb
    80006bb8:	44b48493          	addi	s1,s1,1099 # 80011fff <end+0xfff>
    80006bbc:	02813823          	sd	s0,48(sp)
    80006bc0:	01313c23          	sd	s3,24(sp)
    80006bc4:	00f4f4b3          	and	s1,s1,a5
    80006bc8:	02113c23          	sd	ra,56(sp)
    80006bcc:	03213023          	sd	s2,32(sp)
    80006bd0:	01413823          	sd	s4,16(sp)
    80006bd4:	01513423          	sd	s5,8(sp)
    80006bd8:	04010413          	addi	s0,sp,64
    80006bdc:	000017b7          	lui	a5,0x1
    80006be0:	01100993          	li	s3,17
    80006be4:	00f487b3          	add	a5,s1,a5
    80006be8:	01b99993          	slli	s3,s3,0x1b
    80006bec:	06f9e063          	bltu	s3,a5,80006c4c <kinit+0xa4>
    80006bf0:	0000aa97          	auipc	s5,0xa
    80006bf4:	410a8a93          	addi	s5,s5,1040 # 80011000 <end>
    80006bf8:	0754ec63          	bltu	s1,s5,80006c70 <kinit+0xc8>
    80006bfc:	0734fa63          	bgeu	s1,s3,80006c70 <kinit+0xc8>
    80006c00:	00088a37          	lui	s4,0x88
    80006c04:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006c08:	00004917          	auipc	s2,0x4
    80006c0c:	4a890913          	addi	s2,s2,1192 # 8000b0b0 <kmem>
    80006c10:	00ca1a13          	slli	s4,s4,0xc
    80006c14:	0140006f          	j	80006c28 <kinit+0x80>
    80006c18:	000017b7          	lui	a5,0x1
    80006c1c:	00f484b3          	add	s1,s1,a5
    80006c20:	0554e863          	bltu	s1,s5,80006c70 <kinit+0xc8>
    80006c24:	0534f663          	bgeu	s1,s3,80006c70 <kinit+0xc8>
    80006c28:	00001637          	lui	a2,0x1
    80006c2c:	00100593          	li	a1,1
    80006c30:	00048513          	mv	a0,s1
    80006c34:	00000097          	auipc	ra,0x0
    80006c38:	5e4080e7          	jalr	1508(ra) # 80007218 <__memset>
    80006c3c:	00093783          	ld	a5,0(s2)
    80006c40:	00f4b023          	sd	a5,0(s1)
    80006c44:	00993023          	sd	s1,0(s2)
    80006c48:	fd4498e3          	bne	s1,s4,80006c18 <kinit+0x70>
    80006c4c:	03813083          	ld	ra,56(sp)
    80006c50:	03013403          	ld	s0,48(sp)
    80006c54:	02813483          	ld	s1,40(sp)
    80006c58:	02013903          	ld	s2,32(sp)
    80006c5c:	01813983          	ld	s3,24(sp)
    80006c60:	01013a03          	ld	s4,16(sp)
    80006c64:	00813a83          	ld	s5,8(sp)
    80006c68:	04010113          	addi	sp,sp,64
    80006c6c:	00008067          	ret
    80006c70:	00002517          	auipc	a0,0x2
    80006c74:	b1850513          	addi	a0,a0,-1256 # 80008788 <digits+0x18>
    80006c78:	fffff097          	auipc	ra,0xfffff
    80006c7c:	4b4080e7          	jalr	1204(ra) # 8000612c <panic>

0000000080006c80 <freerange>:
    80006c80:	fc010113          	addi	sp,sp,-64
    80006c84:	000017b7          	lui	a5,0x1
    80006c88:	02913423          	sd	s1,40(sp)
    80006c8c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006c90:	009504b3          	add	s1,a0,s1
    80006c94:	fffff537          	lui	a0,0xfffff
    80006c98:	02813823          	sd	s0,48(sp)
    80006c9c:	02113c23          	sd	ra,56(sp)
    80006ca0:	03213023          	sd	s2,32(sp)
    80006ca4:	01313c23          	sd	s3,24(sp)
    80006ca8:	01413823          	sd	s4,16(sp)
    80006cac:	01513423          	sd	s5,8(sp)
    80006cb0:	01613023          	sd	s6,0(sp)
    80006cb4:	04010413          	addi	s0,sp,64
    80006cb8:	00a4f4b3          	and	s1,s1,a0
    80006cbc:	00f487b3          	add	a5,s1,a5
    80006cc0:	06f5e463          	bltu	a1,a5,80006d28 <freerange+0xa8>
    80006cc4:	0000aa97          	auipc	s5,0xa
    80006cc8:	33ca8a93          	addi	s5,s5,828 # 80011000 <end>
    80006ccc:	0954e263          	bltu	s1,s5,80006d50 <freerange+0xd0>
    80006cd0:	01100993          	li	s3,17
    80006cd4:	01b99993          	slli	s3,s3,0x1b
    80006cd8:	0734fc63          	bgeu	s1,s3,80006d50 <freerange+0xd0>
    80006cdc:	00058a13          	mv	s4,a1
    80006ce0:	00004917          	auipc	s2,0x4
    80006ce4:	3d090913          	addi	s2,s2,976 # 8000b0b0 <kmem>
    80006ce8:	00002b37          	lui	s6,0x2
    80006cec:	0140006f          	j	80006d00 <freerange+0x80>
    80006cf0:	000017b7          	lui	a5,0x1
    80006cf4:	00f484b3          	add	s1,s1,a5
    80006cf8:	0554ec63          	bltu	s1,s5,80006d50 <freerange+0xd0>
    80006cfc:	0534fa63          	bgeu	s1,s3,80006d50 <freerange+0xd0>
    80006d00:	00001637          	lui	a2,0x1
    80006d04:	00100593          	li	a1,1
    80006d08:	00048513          	mv	a0,s1
    80006d0c:	00000097          	auipc	ra,0x0
    80006d10:	50c080e7          	jalr	1292(ra) # 80007218 <__memset>
    80006d14:	00093703          	ld	a4,0(s2)
    80006d18:	016487b3          	add	a5,s1,s6
    80006d1c:	00e4b023          	sd	a4,0(s1)
    80006d20:	00993023          	sd	s1,0(s2)
    80006d24:	fcfa76e3          	bgeu	s4,a5,80006cf0 <freerange+0x70>
    80006d28:	03813083          	ld	ra,56(sp)
    80006d2c:	03013403          	ld	s0,48(sp)
    80006d30:	02813483          	ld	s1,40(sp)
    80006d34:	02013903          	ld	s2,32(sp)
    80006d38:	01813983          	ld	s3,24(sp)
    80006d3c:	01013a03          	ld	s4,16(sp)
    80006d40:	00813a83          	ld	s5,8(sp)
    80006d44:	00013b03          	ld	s6,0(sp)
    80006d48:	04010113          	addi	sp,sp,64
    80006d4c:	00008067          	ret
    80006d50:	00002517          	auipc	a0,0x2
    80006d54:	a3850513          	addi	a0,a0,-1480 # 80008788 <digits+0x18>
    80006d58:	fffff097          	auipc	ra,0xfffff
    80006d5c:	3d4080e7          	jalr	980(ra) # 8000612c <panic>

0000000080006d60 <kfree>:
    80006d60:	fe010113          	addi	sp,sp,-32
    80006d64:	00813823          	sd	s0,16(sp)
    80006d68:	00113c23          	sd	ra,24(sp)
    80006d6c:	00913423          	sd	s1,8(sp)
    80006d70:	02010413          	addi	s0,sp,32
    80006d74:	03451793          	slli	a5,a0,0x34
    80006d78:	04079c63          	bnez	a5,80006dd0 <kfree+0x70>
    80006d7c:	0000a797          	auipc	a5,0xa
    80006d80:	28478793          	addi	a5,a5,644 # 80011000 <end>
    80006d84:	00050493          	mv	s1,a0
    80006d88:	04f56463          	bltu	a0,a5,80006dd0 <kfree+0x70>
    80006d8c:	01100793          	li	a5,17
    80006d90:	01b79793          	slli	a5,a5,0x1b
    80006d94:	02f57e63          	bgeu	a0,a5,80006dd0 <kfree+0x70>
    80006d98:	00001637          	lui	a2,0x1
    80006d9c:	00100593          	li	a1,1
    80006da0:	00000097          	auipc	ra,0x0
    80006da4:	478080e7          	jalr	1144(ra) # 80007218 <__memset>
    80006da8:	00004797          	auipc	a5,0x4
    80006dac:	30878793          	addi	a5,a5,776 # 8000b0b0 <kmem>
    80006db0:	0007b703          	ld	a4,0(a5)
    80006db4:	01813083          	ld	ra,24(sp)
    80006db8:	01013403          	ld	s0,16(sp)
    80006dbc:	00e4b023          	sd	a4,0(s1)
    80006dc0:	0097b023          	sd	s1,0(a5)
    80006dc4:	00813483          	ld	s1,8(sp)
    80006dc8:	02010113          	addi	sp,sp,32
    80006dcc:	00008067          	ret
    80006dd0:	00002517          	auipc	a0,0x2
    80006dd4:	9b850513          	addi	a0,a0,-1608 # 80008788 <digits+0x18>
    80006dd8:	fffff097          	auipc	ra,0xfffff
    80006ddc:	354080e7          	jalr	852(ra) # 8000612c <panic>

0000000080006de0 <kalloc>:
    80006de0:	fe010113          	addi	sp,sp,-32
    80006de4:	00813823          	sd	s0,16(sp)
    80006de8:	00913423          	sd	s1,8(sp)
    80006dec:	00113c23          	sd	ra,24(sp)
    80006df0:	02010413          	addi	s0,sp,32
    80006df4:	00004797          	auipc	a5,0x4
    80006df8:	2bc78793          	addi	a5,a5,700 # 8000b0b0 <kmem>
    80006dfc:	0007b483          	ld	s1,0(a5)
    80006e00:	02048063          	beqz	s1,80006e20 <kalloc+0x40>
    80006e04:	0004b703          	ld	a4,0(s1)
    80006e08:	00001637          	lui	a2,0x1
    80006e0c:	00500593          	li	a1,5
    80006e10:	00048513          	mv	a0,s1
    80006e14:	00e7b023          	sd	a4,0(a5)
    80006e18:	00000097          	auipc	ra,0x0
    80006e1c:	400080e7          	jalr	1024(ra) # 80007218 <__memset>
    80006e20:	01813083          	ld	ra,24(sp)
    80006e24:	01013403          	ld	s0,16(sp)
    80006e28:	00048513          	mv	a0,s1
    80006e2c:	00813483          	ld	s1,8(sp)
    80006e30:	02010113          	addi	sp,sp,32
    80006e34:	00008067          	ret

0000000080006e38 <initlock>:
    80006e38:	ff010113          	addi	sp,sp,-16
    80006e3c:	00813423          	sd	s0,8(sp)
    80006e40:	01010413          	addi	s0,sp,16
    80006e44:	00813403          	ld	s0,8(sp)
    80006e48:	00b53423          	sd	a1,8(a0)
    80006e4c:	00052023          	sw	zero,0(a0)
    80006e50:	00053823          	sd	zero,16(a0)
    80006e54:	01010113          	addi	sp,sp,16
    80006e58:	00008067          	ret

0000000080006e5c <acquire>:
    80006e5c:	fe010113          	addi	sp,sp,-32
    80006e60:	00813823          	sd	s0,16(sp)
    80006e64:	00913423          	sd	s1,8(sp)
    80006e68:	00113c23          	sd	ra,24(sp)
    80006e6c:	01213023          	sd	s2,0(sp)
    80006e70:	02010413          	addi	s0,sp,32
    80006e74:	00050493          	mv	s1,a0
    80006e78:	10002973          	csrr	s2,sstatus
    80006e7c:	100027f3          	csrr	a5,sstatus
    80006e80:	ffd7f793          	andi	a5,a5,-3
    80006e84:	10079073          	csrw	sstatus,a5
    80006e88:	fffff097          	auipc	ra,0xfffff
    80006e8c:	8e8080e7          	jalr	-1816(ra) # 80005770 <mycpu>
    80006e90:	07852783          	lw	a5,120(a0)
    80006e94:	06078e63          	beqz	a5,80006f10 <acquire+0xb4>
    80006e98:	fffff097          	auipc	ra,0xfffff
    80006e9c:	8d8080e7          	jalr	-1832(ra) # 80005770 <mycpu>
    80006ea0:	07852783          	lw	a5,120(a0)
    80006ea4:	0004a703          	lw	a4,0(s1)
    80006ea8:	0017879b          	addiw	a5,a5,1
    80006eac:	06f52c23          	sw	a5,120(a0)
    80006eb0:	04071063          	bnez	a4,80006ef0 <acquire+0x94>
    80006eb4:	00100713          	li	a4,1
    80006eb8:	00070793          	mv	a5,a4
    80006ebc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006ec0:	0007879b          	sext.w	a5,a5
    80006ec4:	fe079ae3          	bnez	a5,80006eb8 <acquire+0x5c>
    80006ec8:	0ff0000f          	fence
    80006ecc:	fffff097          	auipc	ra,0xfffff
    80006ed0:	8a4080e7          	jalr	-1884(ra) # 80005770 <mycpu>
    80006ed4:	01813083          	ld	ra,24(sp)
    80006ed8:	01013403          	ld	s0,16(sp)
    80006edc:	00a4b823          	sd	a0,16(s1)
    80006ee0:	00013903          	ld	s2,0(sp)
    80006ee4:	00813483          	ld	s1,8(sp)
    80006ee8:	02010113          	addi	sp,sp,32
    80006eec:	00008067          	ret
    80006ef0:	0104b903          	ld	s2,16(s1)
    80006ef4:	fffff097          	auipc	ra,0xfffff
    80006ef8:	87c080e7          	jalr	-1924(ra) # 80005770 <mycpu>
    80006efc:	faa91ce3          	bne	s2,a0,80006eb4 <acquire+0x58>
    80006f00:	00002517          	auipc	a0,0x2
    80006f04:	89050513          	addi	a0,a0,-1904 # 80008790 <digits+0x20>
    80006f08:	fffff097          	auipc	ra,0xfffff
    80006f0c:	224080e7          	jalr	548(ra) # 8000612c <panic>
    80006f10:	00195913          	srli	s2,s2,0x1
    80006f14:	fffff097          	auipc	ra,0xfffff
    80006f18:	85c080e7          	jalr	-1956(ra) # 80005770 <mycpu>
    80006f1c:	00197913          	andi	s2,s2,1
    80006f20:	07252e23          	sw	s2,124(a0)
    80006f24:	f75ff06f          	j	80006e98 <acquire+0x3c>

0000000080006f28 <release>:
    80006f28:	fe010113          	addi	sp,sp,-32
    80006f2c:	00813823          	sd	s0,16(sp)
    80006f30:	00113c23          	sd	ra,24(sp)
    80006f34:	00913423          	sd	s1,8(sp)
    80006f38:	01213023          	sd	s2,0(sp)
    80006f3c:	02010413          	addi	s0,sp,32
    80006f40:	00052783          	lw	a5,0(a0)
    80006f44:	00079a63          	bnez	a5,80006f58 <release+0x30>
    80006f48:	00002517          	auipc	a0,0x2
    80006f4c:	85050513          	addi	a0,a0,-1968 # 80008798 <digits+0x28>
    80006f50:	fffff097          	auipc	ra,0xfffff
    80006f54:	1dc080e7          	jalr	476(ra) # 8000612c <panic>
    80006f58:	01053903          	ld	s2,16(a0)
    80006f5c:	00050493          	mv	s1,a0
    80006f60:	fffff097          	auipc	ra,0xfffff
    80006f64:	810080e7          	jalr	-2032(ra) # 80005770 <mycpu>
    80006f68:	fea910e3          	bne	s2,a0,80006f48 <release+0x20>
    80006f6c:	0004b823          	sd	zero,16(s1)
    80006f70:	0ff0000f          	fence
    80006f74:	0f50000f          	fence	iorw,ow
    80006f78:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006f7c:	ffffe097          	auipc	ra,0xffffe
    80006f80:	7f4080e7          	jalr	2036(ra) # 80005770 <mycpu>
    80006f84:	100027f3          	csrr	a5,sstatus
    80006f88:	0027f793          	andi	a5,a5,2
    80006f8c:	04079a63          	bnez	a5,80006fe0 <release+0xb8>
    80006f90:	07852783          	lw	a5,120(a0)
    80006f94:	02f05e63          	blez	a5,80006fd0 <release+0xa8>
    80006f98:	fff7871b          	addiw	a4,a5,-1
    80006f9c:	06e52c23          	sw	a4,120(a0)
    80006fa0:	00071c63          	bnez	a4,80006fb8 <release+0x90>
    80006fa4:	07c52783          	lw	a5,124(a0)
    80006fa8:	00078863          	beqz	a5,80006fb8 <release+0x90>
    80006fac:	100027f3          	csrr	a5,sstatus
    80006fb0:	0027e793          	ori	a5,a5,2
    80006fb4:	10079073          	csrw	sstatus,a5
    80006fb8:	01813083          	ld	ra,24(sp)
    80006fbc:	01013403          	ld	s0,16(sp)
    80006fc0:	00813483          	ld	s1,8(sp)
    80006fc4:	00013903          	ld	s2,0(sp)
    80006fc8:	02010113          	addi	sp,sp,32
    80006fcc:	00008067          	ret
    80006fd0:	00001517          	auipc	a0,0x1
    80006fd4:	7e850513          	addi	a0,a0,2024 # 800087b8 <digits+0x48>
    80006fd8:	fffff097          	auipc	ra,0xfffff
    80006fdc:	154080e7          	jalr	340(ra) # 8000612c <panic>
    80006fe0:	00001517          	auipc	a0,0x1
    80006fe4:	7c050513          	addi	a0,a0,1984 # 800087a0 <digits+0x30>
    80006fe8:	fffff097          	auipc	ra,0xfffff
    80006fec:	144080e7          	jalr	324(ra) # 8000612c <panic>

0000000080006ff0 <holding>:
    80006ff0:	00052783          	lw	a5,0(a0)
    80006ff4:	00079663          	bnez	a5,80007000 <holding+0x10>
    80006ff8:	00000513          	li	a0,0
    80006ffc:	00008067          	ret
    80007000:	fe010113          	addi	sp,sp,-32
    80007004:	00813823          	sd	s0,16(sp)
    80007008:	00913423          	sd	s1,8(sp)
    8000700c:	00113c23          	sd	ra,24(sp)
    80007010:	02010413          	addi	s0,sp,32
    80007014:	01053483          	ld	s1,16(a0)
    80007018:	ffffe097          	auipc	ra,0xffffe
    8000701c:	758080e7          	jalr	1880(ra) # 80005770 <mycpu>
    80007020:	01813083          	ld	ra,24(sp)
    80007024:	01013403          	ld	s0,16(sp)
    80007028:	40a48533          	sub	a0,s1,a0
    8000702c:	00153513          	seqz	a0,a0
    80007030:	00813483          	ld	s1,8(sp)
    80007034:	02010113          	addi	sp,sp,32
    80007038:	00008067          	ret

000000008000703c <push_off>:
    8000703c:	fe010113          	addi	sp,sp,-32
    80007040:	00813823          	sd	s0,16(sp)
    80007044:	00113c23          	sd	ra,24(sp)
    80007048:	00913423          	sd	s1,8(sp)
    8000704c:	02010413          	addi	s0,sp,32
    80007050:	100024f3          	csrr	s1,sstatus
    80007054:	100027f3          	csrr	a5,sstatus
    80007058:	ffd7f793          	andi	a5,a5,-3
    8000705c:	10079073          	csrw	sstatus,a5
    80007060:	ffffe097          	auipc	ra,0xffffe
    80007064:	710080e7          	jalr	1808(ra) # 80005770 <mycpu>
    80007068:	07852783          	lw	a5,120(a0)
    8000706c:	02078663          	beqz	a5,80007098 <push_off+0x5c>
    80007070:	ffffe097          	auipc	ra,0xffffe
    80007074:	700080e7          	jalr	1792(ra) # 80005770 <mycpu>
    80007078:	07852783          	lw	a5,120(a0)
    8000707c:	01813083          	ld	ra,24(sp)
    80007080:	01013403          	ld	s0,16(sp)
    80007084:	0017879b          	addiw	a5,a5,1
    80007088:	06f52c23          	sw	a5,120(a0)
    8000708c:	00813483          	ld	s1,8(sp)
    80007090:	02010113          	addi	sp,sp,32
    80007094:	00008067          	ret
    80007098:	0014d493          	srli	s1,s1,0x1
    8000709c:	ffffe097          	auipc	ra,0xffffe
    800070a0:	6d4080e7          	jalr	1748(ra) # 80005770 <mycpu>
    800070a4:	0014f493          	andi	s1,s1,1
    800070a8:	06952e23          	sw	s1,124(a0)
    800070ac:	fc5ff06f          	j	80007070 <push_off+0x34>

00000000800070b0 <pop_off>:
    800070b0:	ff010113          	addi	sp,sp,-16
    800070b4:	00813023          	sd	s0,0(sp)
    800070b8:	00113423          	sd	ra,8(sp)
    800070bc:	01010413          	addi	s0,sp,16
    800070c0:	ffffe097          	auipc	ra,0xffffe
    800070c4:	6b0080e7          	jalr	1712(ra) # 80005770 <mycpu>
    800070c8:	100027f3          	csrr	a5,sstatus
    800070cc:	0027f793          	andi	a5,a5,2
    800070d0:	04079663          	bnez	a5,8000711c <pop_off+0x6c>
    800070d4:	07852783          	lw	a5,120(a0)
    800070d8:	02f05a63          	blez	a5,8000710c <pop_off+0x5c>
    800070dc:	fff7871b          	addiw	a4,a5,-1
    800070e0:	06e52c23          	sw	a4,120(a0)
    800070e4:	00071c63          	bnez	a4,800070fc <pop_off+0x4c>
    800070e8:	07c52783          	lw	a5,124(a0)
    800070ec:	00078863          	beqz	a5,800070fc <pop_off+0x4c>
    800070f0:	100027f3          	csrr	a5,sstatus
    800070f4:	0027e793          	ori	a5,a5,2
    800070f8:	10079073          	csrw	sstatus,a5
    800070fc:	00813083          	ld	ra,8(sp)
    80007100:	00013403          	ld	s0,0(sp)
    80007104:	01010113          	addi	sp,sp,16
    80007108:	00008067          	ret
    8000710c:	00001517          	auipc	a0,0x1
    80007110:	6ac50513          	addi	a0,a0,1708 # 800087b8 <digits+0x48>
    80007114:	fffff097          	auipc	ra,0xfffff
    80007118:	018080e7          	jalr	24(ra) # 8000612c <panic>
    8000711c:	00001517          	auipc	a0,0x1
    80007120:	68450513          	addi	a0,a0,1668 # 800087a0 <digits+0x30>
    80007124:	fffff097          	auipc	ra,0xfffff
    80007128:	008080e7          	jalr	8(ra) # 8000612c <panic>

000000008000712c <push_on>:
    8000712c:	fe010113          	addi	sp,sp,-32
    80007130:	00813823          	sd	s0,16(sp)
    80007134:	00113c23          	sd	ra,24(sp)
    80007138:	00913423          	sd	s1,8(sp)
    8000713c:	02010413          	addi	s0,sp,32
    80007140:	100024f3          	csrr	s1,sstatus
    80007144:	100027f3          	csrr	a5,sstatus
    80007148:	0027e793          	ori	a5,a5,2
    8000714c:	10079073          	csrw	sstatus,a5
    80007150:	ffffe097          	auipc	ra,0xffffe
    80007154:	620080e7          	jalr	1568(ra) # 80005770 <mycpu>
    80007158:	07852783          	lw	a5,120(a0)
    8000715c:	02078663          	beqz	a5,80007188 <push_on+0x5c>
    80007160:	ffffe097          	auipc	ra,0xffffe
    80007164:	610080e7          	jalr	1552(ra) # 80005770 <mycpu>
    80007168:	07852783          	lw	a5,120(a0)
    8000716c:	01813083          	ld	ra,24(sp)
    80007170:	01013403          	ld	s0,16(sp)
    80007174:	0017879b          	addiw	a5,a5,1
    80007178:	06f52c23          	sw	a5,120(a0)
    8000717c:	00813483          	ld	s1,8(sp)
    80007180:	02010113          	addi	sp,sp,32
    80007184:	00008067          	ret
    80007188:	0014d493          	srli	s1,s1,0x1
    8000718c:	ffffe097          	auipc	ra,0xffffe
    80007190:	5e4080e7          	jalr	1508(ra) # 80005770 <mycpu>
    80007194:	0014f493          	andi	s1,s1,1
    80007198:	06952e23          	sw	s1,124(a0)
    8000719c:	fc5ff06f          	j	80007160 <push_on+0x34>

00000000800071a0 <pop_on>:
    800071a0:	ff010113          	addi	sp,sp,-16
    800071a4:	00813023          	sd	s0,0(sp)
    800071a8:	00113423          	sd	ra,8(sp)
    800071ac:	01010413          	addi	s0,sp,16
    800071b0:	ffffe097          	auipc	ra,0xffffe
    800071b4:	5c0080e7          	jalr	1472(ra) # 80005770 <mycpu>
    800071b8:	100027f3          	csrr	a5,sstatus
    800071bc:	0027f793          	andi	a5,a5,2
    800071c0:	04078463          	beqz	a5,80007208 <pop_on+0x68>
    800071c4:	07852783          	lw	a5,120(a0)
    800071c8:	02f05863          	blez	a5,800071f8 <pop_on+0x58>
    800071cc:	fff7879b          	addiw	a5,a5,-1
    800071d0:	06f52c23          	sw	a5,120(a0)
    800071d4:	07853783          	ld	a5,120(a0)
    800071d8:	00079863          	bnez	a5,800071e8 <pop_on+0x48>
    800071dc:	100027f3          	csrr	a5,sstatus
    800071e0:	ffd7f793          	andi	a5,a5,-3
    800071e4:	10079073          	csrw	sstatus,a5
    800071e8:	00813083          	ld	ra,8(sp)
    800071ec:	00013403          	ld	s0,0(sp)
    800071f0:	01010113          	addi	sp,sp,16
    800071f4:	00008067          	ret
    800071f8:	00001517          	auipc	a0,0x1
    800071fc:	5e850513          	addi	a0,a0,1512 # 800087e0 <digits+0x70>
    80007200:	fffff097          	auipc	ra,0xfffff
    80007204:	f2c080e7          	jalr	-212(ra) # 8000612c <panic>
    80007208:	00001517          	auipc	a0,0x1
    8000720c:	5b850513          	addi	a0,a0,1464 # 800087c0 <digits+0x50>
    80007210:	fffff097          	auipc	ra,0xfffff
    80007214:	f1c080e7          	jalr	-228(ra) # 8000612c <panic>

0000000080007218 <__memset>:
    80007218:	ff010113          	addi	sp,sp,-16
    8000721c:	00813423          	sd	s0,8(sp)
    80007220:	01010413          	addi	s0,sp,16
    80007224:	1a060e63          	beqz	a2,800073e0 <__memset+0x1c8>
    80007228:	40a007b3          	neg	a5,a0
    8000722c:	0077f793          	andi	a5,a5,7
    80007230:	00778693          	addi	a3,a5,7
    80007234:	00b00813          	li	a6,11
    80007238:	0ff5f593          	andi	a1,a1,255
    8000723c:	fff6071b          	addiw	a4,a2,-1
    80007240:	1b06e663          	bltu	a3,a6,800073ec <__memset+0x1d4>
    80007244:	1cd76463          	bltu	a4,a3,8000740c <__memset+0x1f4>
    80007248:	1a078e63          	beqz	a5,80007404 <__memset+0x1ec>
    8000724c:	00b50023          	sb	a1,0(a0)
    80007250:	00100713          	li	a4,1
    80007254:	1ae78463          	beq	a5,a4,800073fc <__memset+0x1e4>
    80007258:	00b500a3          	sb	a1,1(a0)
    8000725c:	00200713          	li	a4,2
    80007260:	1ae78a63          	beq	a5,a4,80007414 <__memset+0x1fc>
    80007264:	00b50123          	sb	a1,2(a0)
    80007268:	00300713          	li	a4,3
    8000726c:	18e78463          	beq	a5,a4,800073f4 <__memset+0x1dc>
    80007270:	00b501a3          	sb	a1,3(a0)
    80007274:	00400713          	li	a4,4
    80007278:	1ae78263          	beq	a5,a4,8000741c <__memset+0x204>
    8000727c:	00b50223          	sb	a1,4(a0)
    80007280:	00500713          	li	a4,5
    80007284:	1ae78063          	beq	a5,a4,80007424 <__memset+0x20c>
    80007288:	00b502a3          	sb	a1,5(a0)
    8000728c:	00700713          	li	a4,7
    80007290:	18e79e63          	bne	a5,a4,8000742c <__memset+0x214>
    80007294:	00b50323          	sb	a1,6(a0)
    80007298:	00700e93          	li	t4,7
    8000729c:	00859713          	slli	a4,a1,0x8
    800072a0:	00e5e733          	or	a4,a1,a4
    800072a4:	01059e13          	slli	t3,a1,0x10
    800072a8:	01c76e33          	or	t3,a4,t3
    800072ac:	01859313          	slli	t1,a1,0x18
    800072b0:	006e6333          	or	t1,t3,t1
    800072b4:	02059893          	slli	a7,a1,0x20
    800072b8:	40f60e3b          	subw	t3,a2,a5
    800072bc:	011368b3          	or	a7,t1,a7
    800072c0:	02859813          	slli	a6,a1,0x28
    800072c4:	0108e833          	or	a6,a7,a6
    800072c8:	03059693          	slli	a3,a1,0x30
    800072cc:	003e589b          	srliw	a7,t3,0x3
    800072d0:	00d866b3          	or	a3,a6,a3
    800072d4:	03859713          	slli	a4,a1,0x38
    800072d8:	00389813          	slli	a6,a7,0x3
    800072dc:	00f507b3          	add	a5,a0,a5
    800072e0:	00e6e733          	or	a4,a3,a4
    800072e4:	000e089b          	sext.w	a7,t3
    800072e8:	00f806b3          	add	a3,a6,a5
    800072ec:	00e7b023          	sd	a4,0(a5)
    800072f0:	00878793          	addi	a5,a5,8
    800072f4:	fed79ce3          	bne	a5,a3,800072ec <__memset+0xd4>
    800072f8:	ff8e7793          	andi	a5,t3,-8
    800072fc:	0007871b          	sext.w	a4,a5
    80007300:	01d787bb          	addw	a5,a5,t4
    80007304:	0ce88e63          	beq	a7,a4,800073e0 <__memset+0x1c8>
    80007308:	00f50733          	add	a4,a0,a5
    8000730c:	00b70023          	sb	a1,0(a4)
    80007310:	0017871b          	addiw	a4,a5,1
    80007314:	0cc77663          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007318:	00e50733          	add	a4,a0,a4
    8000731c:	00b70023          	sb	a1,0(a4)
    80007320:	0027871b          	addiw	a4,a5,2
    80007324:	0ac77e63          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007328:	00e50733          	add	a4,a0,a4
    8000732c:	00b70023          	sb	a1,0(a4)
    80007330:	0037871b          	addiw	a4,a5,3
    80007334:	0ac77663          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007338:	00e50733          	add	a4,a0,a4
    8000733c:	00b70023          	sb	a1,0(a4)
    80007340:	0047871b          	addiw	a4,a5,4
    80007344:	08c77e63          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007348:	00e50733          	add	a4,a0,a4
    8000734c:	00b70023          	sb	a1,0(a4)
    80007350:	0057871b          	addiw	a4,a5,5
    80007354:	08c77663          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007358:	00e50733          	add	a4,a0,a4
    8000735c:	00b70023          	sb	a1,0(a4)
    80007360:	0067871b          	addiw	a4,a5,6
    80007364:	06c77e63          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007368:	00e50733          	add	a4,a0,a4
    8000736c:	00b70023          	sb	a1,0(a4)
    80007370:	0077871b          	addiw	a4,a5,7
    80007374:	06c77663          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007378:	00e50733          	add	a4,a0,a4
    8000737c:	00b70023          	sb	a1,0(a4)
    80007380:	0087871b          	addiw	a4,a5,8
    80007384:	04c77e63          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007388:	00e50733          	add	a4,a0,a4
    8000738c:	00b70023          	sb	a1,0(a4)
    80007390:	0097871b          	addiw	a4,a5,9
    80007394:	04c77663          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    80007398:	00e50733          	add	a4,a0,a4
    8000739c:	00b70023          	sb	a1,0(a4)
    800073a0:	00a7871b          	addiw	a4,a5,10
    800073a4:	02c77e63          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    800073a8:	00e50733          	add	a4,a0,a4
    800073ac:	00b70023          	sb	a1,0(a4)
    800073b0:	00b7871b          	addiw	a4,a5,11
    800073b4:	02c77663          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    800073b8:	00e50733          	add	a4,a0,a4
    800073bc:	00b70023          	sb	a1,0(a4)
    800073c0:	00c7871b          	addiw	a4,a5,12
    800073c4:	00c77e63          	bgeu	a4,a2,800073e0 <__memset+0x1c8>
    800073c8:	00e50733          	add	a4,a0,a4
    800073cc:	00b70023          	sb	a1,0(a4)
    800073d0:	00d7879b          	addiw	a5,a5,13
    800073d4:	00c7f663          	bgeu	a5,a2,800073e0 <__memset+0x1c8>
    800073d8:	00f507b3          	add	a5,a0,a5
    800073dc:	00b78023          	sb	a1,0(a5)
    800073e0:	00813403          	ld	s0,8(sp)
    800073e4:	01010113          	addi	sp,sp,16
    800073e8:	00008067          	ret
    800073ec:	00b00693          	li	a3,11
    800073f0:	e55ff06f          	j	80007244 <__memset+0x2c>
    800073f4:	00300e93          	li	t4,3
    800073f8:	ea5ff06f          	j	8000729c <__memset+0x84>
    800073fc:	00100e93          	li	t4,1
    80007400:	e9dff06f          	j	8000729c <__memset+0x84>
    80007404:	00000e93          	li	t4,0
    80007408:	e95ff06f          	j	8000729c <__memset+0x84>
    8000740c:	00000793          	li	a5,0
    80007410:	ef9ff06f          	j	80007308 <__memset+0xf0>
    80007414:	00200e93          	li	t4,2
    80007418:	e85ff06f          	j	8000729c <__memset+0x84>
    8000741c:	00400e93          	li	t4,4
    80007420:	e7dff06f          	j	8000729c <__memset+0x84>
    80007424:	00500e93          	li	t4,5
    80007428:	e75ff06f          	j	8000729c <__memset+0x84>
    8000742c:	00600e93          	li	t4,6
    80007430:	e6dff06f          	j	8000729c <__memset+0x84>

0000000080007434 <__memmove>:
    80007434:	ff010113          	addi	sp,sp,-16
    80007438:	00813423          	sd	s0,8(sp)
    8000743c:	01010413          	addi	s0,sp,16
    80007440:	0e060863          	beqz	a2,80007530 <__memmove+0xfc>
    80007444:	fff6069b          	addiw	a3,a2,-1
    80007448:	0006881b          	sext.w	a6,a3
    8000744c:	0ea5e863          	bltu	a1,a0,8000753c <__memmove+0x108>
    80007450:	00758713          	addi	a4,a1,7
    80007454:	00a5e7b3          	or	a5,a1,a0
    80007458:	40a70733          	sub	a4,a4,a0
    8000745c:	0077f793          	andi	a5,a5,7
    80007460:	00f73713          	sltiu	a4,a4,15
    80007464:	00174713          	xori	a4,a4,1
    80007468:	0017b793          	seqz	a5,a5
    8000746c:	00e7f7b3          	and	a5,a5,a4
    80007470:	10078863          	beqz	a5,80007580 <__memmove+0x14c>
    80007474:	00900793          	li	a5,9
    80007478:	1107f463          	bgeu	a5,a6,80007580 <__memmove+0x14c>
    8000747c:	0036581b          	srliw	a6,a2,0x3
    80007480:	fff8081b          	addiw	a6,a6,-1
    80007484:	02081813          	slli	a6,a6,0x20
    80007488:	01d85893          	srli	a7,a6,0x1d
    8000748c:	00858813          	addi	a6,a1,8
    80007490:	00058793          	mv	a5,a1
    80007494:	00050713          	mv	a4,a0
    80007498:	01088833          	add	a6,a7,a6
    8000749c:	0007b883          	ld	a7,0(a5)
    800074a0:	00878793          	addi	a5,a5,8
    800074a4:	00870713          	addi	a4,a4,8
    800074a8:	ff173c23          	sd	a7,-8(a4)
    800074ac:	ff0798e3          	bne	a5,a6,8000749c <__memmove+0x68>
    800074b0:	ff867713          	andi	a4,a2,-8
    800074b4:	02071793          	slli	a5,a4,0x20
    800074b8:	0207d793          	srli	a5,a5,0x20
    800074bc:	00f585b3          	add	a1,a1,a5
    800074c0:	40e686bb          	subw	a3,a3,a4
    800074c4:	00f507b3          	add	a5,a0,a5
    800074c8:	06e60463          	beq	a2,a4,80007530 <__memmove+0xfc>
    800074cc:	0005c703          	lbu	a4,0(a1)
    800074d0:	00e78023          	sb	a4,0(a5)
    800074d4:	04068e63          	beqz	a3,80007530 <__memmove+0xfc>
    800074d8:	0015c603          	lbu	a2,1(a1)
    800074dc:	00100713          	li	a4,1
    800074e0:	00c780a3          	sb	a2,1(a5)
    800074e4:	04e68663          	beq	a3,a4,80007530 <__memmove+0xfc>
    800074e8:	0025c603          	lbu	a2,2(a1)
    800074ec:	00200713          	li	a4,2
    800074f0:	00c78123          	sb	a2,2(a5)
    800074f4:	02e68e63          	beq	a3,a4,80007530 <__memmove+0xfc>
    800074f8:	0035c603          	lbu	a2,3(a1)
    800074fc:	00300713          	li	a4,3
    80007500:	00c781a3          	sb	a2,3(a5)
    80007504:	02e68663          	beq	a3,a4,80007530 <__memmove+0xfc>
    80007508:	0045c603          	lbu	a2,4(a1)
    8000750c:	00400713          	li	a4,4
    80007510:	00c78223          	sb	a2,4(a5)
    80007514:	00e68e63          	beq	a3,a4,80007530 <__memmove+0xfc>
    80007518:	0055c603          	lbu	a2,5(a1)
    8000751c:	00500713          	li	a4,5
    80007520:	00c782a3          	sb	a2,5(a5)
    80007524:	00e68663          	beq	a3,a4,80007530 <__memmove+0xfc>
    80007528:	0065c703          	lbu	a4,6(a1)
    8000752c:	00e78323          	sb	a4,6(a5)
    80007530:	00813403          	ld	s0,8(sp)
    80007534:	01010113          	addi	sp,sp,16
    80007538:	00008067          	ret
    8000753c:	02061713          	slli	a4,a2,0x20
    80007540:	02075713          	srli	a4,a4,0x20
    80007544:	00e587b3          	add	a5,a1,a4
    80007548:	f0f574e3          	bgeu	a0,a5,80007450 <__memmove+0x1c>
    8000754c:	02069613          	slli	a2,a3,0x20
    80007550:	02065613          	srli	a2,a2,0x20
    80007554:	fff64613          	not	a2,a2
    80007558:	00e50733          	add	a4,a0,a4
    8000755c:	00c78633          	add	a2,a5,a2
    80007560:	fff7c683          	lbu	a3,-1(a5)
    80007564:	fff78793          	addi	a5,a5,-1
    80007568:	fff70713          	addi	a4,a4,-1
    8000756c:	00d70023          	sb	a3,0(a4)
    80007570:	fec798e3          	bne	a5,a2,80007560 <__memmove+0x12c>
    80007574:	00813403          	ld	s0,8(sp)
    80007578:	01010113          	addi	sp,sp,16
    8000757c:	00008067          	ret
    80007580:	02069713          	slli	a4,a3,0x20
    80007584:	02075713          	srli	a4,a4,0x20
    80007588:	00170713          	addi	a4,a4,1
    8000758c:	00e50733          	add	a4,a0,a4
    80007590:	00050793          	mv	a5,a0
    80007594:	0005c683          	lbu	a3,0(a1)
    80007598:	00178793          	addi	a5,a5,1
    8000759c:	00158593          	addi	a1,a1,1
    800075a0:	fed78fa3          	sb	a3,-1(a5)
    800075a4:	fee798e3          	bne	a5,a4,80007594 <__memmove+0x160>
    800075a8:	f89ff06f          	j	80007530 <__memmove+0xfc>
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
}
    8000d3dc:	00813083          	ld	ra,8(sp)
    8000d3e0:	00013403          	ld	s0,0(sp)
    8000d3e4:	01010113          	addi	sp,sp,16
    8000d3e8:	00008067          	ret

000000008000d3ec <_Z21popSppSpieUserWrapperPFvPvES_>:

void popSppSpieUserWrapper(void (*body)(void*), void* args)
{
    8000d3ec:	ff010113          	addi	sp,sp,-16
    8000d3f0:	00113423          	sd	ra,8(sp)
    8000d3f4:	00813023          	sd	s0,0(sp)
    8000d3f8:	01010413          	addi	s0,sp,16
    8000d3fc:	00050793          	mv	a5,a0
    body(args);
    8000d400:	00058513          	mv	a0,a1
    8000d404:	000780e7          	jalr	a5
    thread_exit();
    8000d408:	00000097          	auipc	ra,0x0
    8000d40c:	d00080e7          	jalr	-768(ra) # 8000d108 <_Z11thread_exitv>
    8000d410:	00813083          	ld	ra,8(sp)
    8000d414:	00013403          	ld	s0,0(sp)
    8000d418:	01010113          	addi	sp,sp,16
    8000d41c:	00008067          	ret

000000008000d420 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000d420:	fd010113          	addi	sp,sp,-48
    8000d424:	02113423          	sd	ra,40(sp)
    8000d428:	02813023          	sd	s0,32(sp)
    8000d42c:	00913c23          	sd	s1,24(sp)
    8000d430:	01213823          	sd	s2,16(sp)
    8000d434:	01313423          	sd	s3,8(sp)
    8000d438:	03010413          	addi	s0,sp,48
    8000d43c:	00050493          	mv	s1,a0
    8000d440:	00058993          	mv	s3,a1
    8000d444:	0015879b          	addiw	a5,a1,1
    8000d448:	0007851b          	sext.w	a0,a5
    8000d44c:	00f4a023          	sw	a5,0(s1)
    8000d450:	0004a823          	sw	zero,16(s1)
    8000d454:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000d458:	00251513          	slli	a0,a0,0x2
    8000d45c:	00000097          	auipc	ra,0x0
    8000d460:	bc4080e7          	jalr	-1084(ra) # 8000d020 <_Z9mem_allocm>
    8000d464:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    8000d468:	01000513          	li	a0,16
    8000d46c:	00002097          	auipc	ra,0x2
    8000d470:	bac080e7          	jalr	-1108(ra) # 8000f018 <_Znwm>
    8000d474:	00050913          	mv	s2,a0
    8000d478:	00050863          	beqz	a0,8000d488 <_ZN9BufferCPPC1Ei+0x68>
    8000d47c:	00000593          	li	a1,0
    8000d480:	00002097          	auipc	ra,0x2
    8000d484:	c90080e7          	jalr	-880(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000d488:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000d48c:	01000513          	li	a0,16
    8000d490:	00002097          	auipc	ra,0x2
    8000d494:	b88080e7          	jalr	-1144(ra) # 8000f018 <_Znwm>
    8000d498:	00050913          	mv	s2,a0
    8000d49c:	00050863          	beqz	a0,8000d4ac <_ZN9BufferCPPC1Ei+0x8c>
    8000d4a0:	00098593          	mv	a1,s3
    8000d4a4:	00002097          	auipc	ra,0x2
    8000d4a8:	c6c080e7          	jalr	-916(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000d4ac:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000d4b0:	01000513          	li	a0,16
    8000d4b4:	00002097          	auipc	ra,0x2
    8000d4b8:	b64080e7          	jalr	-1180(ra) # 8000f018 <_Znwm>
    8000d4bc:	00050913          	mv	s2,a0
    8000d4c0:	00050863          	beqz	a0,8000d4d0 <_ZN9BufferCPPC1Ei+0xb0>
    8000d4c4:	00100593          	li	a1,1
    8000d4c8:	00002097          	auipc	ra,0x2
    8000d4cc:	c48080e7          	jalr	-952(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000d4d0:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000d4d4:	01000513          	li	a0,16
    8000d4d8:	00002097          	auipc	ra,0x2
    8000d4dc:	b40080e7          	jalr	-1216(ra) # 8000f018 <_Znwm>
    8000d4e0:	00050913          	mv	s2,a0
    8000d4e4:	00050863          	beqz	a0,8000d4f4 <_ZN9BufferCPPC1Ei+0xd4>
    8000d4e8:	00100593          	li	a1,1
    8000d4ec:	00002097          	auipc	ra,0x2
    8000d4f0:	c24080e7          	jalr	-988(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000d4f4:	0324b823          	sd	s2,48(s1)
}
    8000d4f8:	02813083          	ld	ra,40(sp)
    8000d4fc:	02013403          	ld	s0,32(sp)
    8000d500:	01813483          	ld	s1,24(sp)
    8000d504:	01013903          	ld	s2,16(sp)
    8000d508:	00813983          	ld	s3,8(sp)
    8000d50c:	03010113          	addi	sp,sp,48
    8000d510:	00008067          	ret
    8000d514:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    8000d518:	00090513          	mv	a0,s2
    8000d51c:	00002097          	auipc	ra,0x2
    8000d520:	b4c080e7          	jalr	-1204(ra) # 8000f068 <_ZdlPv>
    8000d524:	00048513          	mv	a0,s1
    8000d528:	fffff097          	auipc	ra,0xfffff
    8000d52c:	eb0080e7          	jalr	-336(ra) # 8000c3d8 <_Unwind_Resume>
    8000d530:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000d534:	00090513          	mv	a0,s2
    8000d538:	00002097          	auipc	ra,0x2
    8000d53c:	b30080e7          	jalr	-1232(ra) # 8000f068 <_ZdlPv>
    8000d540:	00048513          	mv	a0,s1
    8000d544:	fffff097          	auipc	ra,0xfffff
    8000d548:	e94080e7          	jalr	-364(ra) # 8000c3d8 <_Unwind_Resume>
    8000d54c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000d550:	00090513          	mv	a0,s2
    8000d554:	00002097          	auipc	ra,0x2
    8000d558:	b14080e7          	jalr	-1260(ra) # 8000f068 <_ZdlPv>
    8000d55c:	00048513          	mv	a0,s1
    8000d560:	fffff097          	auipc	ra,0xfffff
    8000d564:	e78080e7          	jalr	-392(ra) # 8000c3d8 <_Unwind_Resume>
    8000d568:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000d56c:	00090513          	mv	a0,s2
    8000d570:	00002097          	auipc	ra,0x2
    8000d574:	af8080e7          	jalr	-1288(ra) # 8000f068 <_ZdlPv>
    8000d578:	00048513          	mv	a0,s1
    8000d57c:	fffff097          	auipc	ra,0xfffff
    8000d580:	e5c080e7          	jalr	-420(ra) # 8000c3d8 <_Unwind_Resume>

000000008000d584 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    8000d584:	fe010113          	addi	sp,sp,-32
    8000d588:	00113c23          	sd	ra,24(sp)
    8000d58c:	00813823          	sd	s0,16(sp)
    8000d590:	00913423          	sd	s1,8(sp)
    8000d594:	01213023          	sd	s2,0(sp)
    8000d598:	02010413          	addi	s0,sp,32
    8000d59c:	00050493          	mv	s1,a0
    8000d5a0:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    8000d5a4:	01853503          	ld	a0,24(a0) # 1018 <_entry-0x7fffefe8>
    8000d5a8:	00002097          	auipc	ra,0x2
    8000d5ac:	ba0080e7          	jalr	-1120(ra) # 8000f148 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000d5b0:	0304b503          	ld	a0,48(s1)
    8000d5b4:	00002097          	auipc	ra,0x2
    8000d5b8:	b94080e7          	jalr	-1132(ra) # 8000f148 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000d5bc:	0084b783          	ld	a5,8(s1)
    8000d5c0:	0144a703          	lw	a4,20(s1)
    8000d5c4:	00271713          	slli	a4,a4,0x2
    8000d5c8:	00e787b3          	add	a5,a5,a4
    8000d5cc:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000d5d0:	0144a783          	lw	a5,20(s1)
    8000d5d4:	0017879b          	addiw	a5,a5,1
    8000d5d8:	0004a703          	lw	a4,0(s1)
    8000d5dc:	02e7e7bb          	remw	a5,a5,a4
    8000d5e0:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    8000d5e4:	0304b503          	ld	a0,48(s1)
    8000d5e8:	00002097          	auipc	ra,0x2
    8000d5ec:	b8c080e7          	jalr	-1140(ra) # 8000f174 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000d5f0:	0204b503          	ld	a0,32(s1)
    8000d5f4:	00002097          	auipc	ra,0x2
    8000d5f8:	b80080e7          	jalr	-1152(ra) # 8000f174 <_ZN9Semaphore6signalEv>

}
    8000d5fc:	01813083          	ld	ra,24(sp)
    8000d600:	01013403          	ld	s0,16(sp)
    8000d604:	00813483          	ld	s1,8(sp)
    8000d608:	00013903          	ld	s2,0(sp)
    8000d60c:	02010113          	addi	sp,sp,32
    8000d610:	00008067          	ret

000000008000d614 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    8000d614:	fe010113          	addi	sp,sp,-32
    8000d618:	00113c23          	sd	ra,24(sp)
    8000d61c:	00813823          	sd	s0,16(sp)
    8000d620:	00913423          	sd	s1,8(sp)
    8000d624:	01213023          	sd	s2,0(sp)
    8000d628:	02010413          	addi	s0,sp,32
    8000d62c:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000d630:	02053503          	ld	a0,32(a0)
    8000d634:	00002097          	auipc	ra,0x2
    8000d638:	b14080e7          	jalr	-1260(ra) # 8000f148 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000d63c:	0284b503          	ld	a0,40(s1)
    8000d640:	00002097          	auipc	ra,0x2
    8000d644:	b08080e7          	jalr	-1272(ra) # 8000f148 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000d648:	0084b703          	ld	a4,8(s1)
    8000d64c:	0104a783          	lw	a5,16(s1)
    8000d650:	00279693          	slli	a3,a5,0x2
    8000d654:	00d70733          	add	a4,a4,a3
    8000d658:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000d65c:	0017879b          	addiw	a5,a5,1
    8000d660:	0004a703          	lw	a4,0(s1)
    8000d664:	02e7e7bb          	remw	a5,a5,a4
    8000d668:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    8000d66c:	0284b503          	ld	a0,40(s1)
    8000d670:	00002097          	auipc	ra,0x2
    8000d674:	b04080e7          	jalr	-1276(ra) # 8000f174 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000d678:	0184b503          	ld	a0,24(s1)
    8000d67c:	00002097          	auipc	ra,0x2
    8000d680:	af8080e7          	jalr	-1288(ra) # 8000f174 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000d684:	00090513          	mv	a0,s2
    8000d688:	01813083          	ld	ra,24(sp)
    8000d68c:	01013403          	ld	s0,16(sp)
    8000d690:	00813483          	ld	s1,8(sp)
    8000d694:	00013903          	ld	s2,0(sp)
    8000d698:	02010113          	addi	sp,sp,32
    8000d69c:	00008067          	ret

000000008000d6a0 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8000d6a0:	fe010113          	addi	sp,sp,-32
    8000d6a4:	00113c23          	sd	ra,24(sp)
    8000d6a8:	00813823          	sd	s0,16(sp)
    8000d6ac:	00913423          	sd	s1,8(sp)
    8000d6b0:	01213023          	sd	s2,0(sp)
    8000d6b4:	02010413          	addi	s0,sp,32
    8000d6b8:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000d6bc:	02853503          	ld	a0,40(a0)
    8000d6c0:	00002097          	auipc	ra,0x2
    8000d6c4:	a88080e7          	jalr	-1400(ra) # 8000f148 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000d6c8:	0304b503          	ld	a0,48(s1)
    8000d6cc:	00002097          	auipc	ra,0x2
    8000d6d0:	a7c080e7          	jalr	-1412(ra) # 8000f148 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    8000d6d4:	0144a783          	lw	a5,20(s1)
    8000d6d8:	0104a903          	lw	s2,16(s1)
    8000d6dc:	0327ce63          	blt	a5,s2,8000d718 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000d6e0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    8000d6e4:	0304b503          	ld	a0,48(s1)
    8000d6e8:	00002097          	auipc	ra,0x2
    8000d6ec:	a8c080e7          	jalr	-1396(ra) # 8000f174 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000d6f0:	0284b503          	ld	a0,40(s1)
    8000d6f4:	00002097          	auipc	ra,0x2
    8000d6f8:	a80080e7          	jalr	-1408(ra) # 8000f174 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000d6fc:	00090513          	mv	a0,s2
    8000d700:	01813083          	ld	ra,24(sp)
    8000d704:	01013403          	ld	s0,16(sp)
    8000d708:	00813483          	ld	s1,8(sp)
    8000d70c:	00013903          	ld	s2,0(sp)
    8000d710:	02010113          	addi	sp,sp,32
    8000d714:	00008067          	ret
        ret = cap - head + tail;
    8000d718:	0004a703          	lw	a4,0(s1)
    8000d71c:	4127093b          	subw	s2,a4,s2
    8000d720:	00f9093b          	addw	s2,s2,a5
    8000d724:	fc1ff06f          	j	8000d6e4 <_ZN9BufferCPP6getCntEv+0x44>

000000008000d728 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000d728:	fe010113          	addi	sp,sp,-32
    8000d72c:	00113c23          	sd	ra,24(sp)
    8000d730:	00813823          	sd	s0,16(sp)
    8000d734:	00913423          	sd	s1,8(sp)
    8000d738:	02010413          	addi	s0,sp,32
    8000d73c:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000d740:	00a00513          	li	a0,10
    8000d744:	00002097          	auipc	ra,0x2
    8000d748:	c68080e7          	jalr	-920(ra) # 8000f3ac <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000d74c:	00003517          	auipc	a0,0x3
    8000d750:	8b450513          	addi	a0,a0,-1868 # 80010000 <userDataStart>
    8000d754:	00001097          	auipc	ra,0x1
    8000d758:	574080e7          	jalr	1396(ra) # 8000ecc8 <_Z11printStringPKc>
    while (getCnt()) {
    8000d75c:	00048513          	mv	a0,s1
    8000d760:	00000097          	auipc	ra,0x0
    8000d764:	f40080e7          	jalr	-192(ra) # 8000d6a0 <_ZN9BufferCPP6getCntEv>
    8000d768:	02050c63          	beqz	a0,8000d7a0 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    8000d76c:	0084b783          	ld	a5,8(s1)
    8000d770:	0104a703          	lw	a4,16(s1)
    8000d774:	00271713          	slli	a4,a4,0x2
    8000d778:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    8000d77c:	0007c503          	lbu	a0,0(a5)
    8000d780:	00002097          	auipc	ra,0x2
    8000d784:	c2c080e7          	jalr	-980(ra) # 8000f3ac <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000d788:	0104a783          	lw	a5,16(s1)
    8000d78c:	0017879b          	addiw	a5,a5,1
    8000d790:	0004a703          	lw	a4,0(s1)
    8000d794:	02e7e7bb          	remw	a5,a5,a4
    8000d798:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000d79c:	fc1ff06f          	j	8000d75c <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8000d7a0:	02100513          	li	a0,33
    8000d7a4:	00002097          	auipc	ra,0x2
    8000d7a8:	c08080e7          	jalr	-1016(ra) # 8000f3ac <_ZN7Console4putcEc>
    Console::putc('\n');
    8000d7ac:	00a00513          	li	a0,10
    8000d7b0:	00002097          	auipc	ra,0x2
    8000d7b4:	bfc080e7          	jalr	-1028(ra) # 8000f3ac <_ZN7Console4putcEc>
    mem_free(buffer);
    8000d7b8:	0084b503          	ld	a0,8(s1)
    8000d7bc:	00000097          	auipc	ra,0x0
    8000d7c0:	894080e7          	jalr	-1900(ra) # 8000d050 <_Z8mem_freePv>
    delete itemAvailable;
    8000d7c4:	0204b503          	ld	a0,32(s1)
    8000d7c8:	00050863          	beqz	a0,8000d7d8 <_ZN9BufferCPPD1Ev+0xb0>
    8000d7cc:	00053783          	ld	a5,0(a0)
    8000d7d0:	0087b783          	ld	a5,8(a5)
    8000d7d4:	000780e7          	jalr	a5
    delete spaceAvailable;
    8000d7d8:	0184b503          	ld	a0,24(s1)
    8000d7dc:	00050863          	beqz	a0,8000d7ec <_ZN9BufferCPPD1Ev+0xc4>
    8000d7e0:	00053783          	ld	a5,0(a0)
    8000d7e4:	0087b783          	ld	a5,8(a5)
    8000d7e8:	000780e7          	jalr	a5
    delete mutexTail;
    8000d7ec:	0304b503          	ld	a0,48(s1)
    8000d7f0:	00050863          	beqz	a0,8000d800 <_ZN9BufferCPPD1Ev+0xd8>
    8000d7f4:	00053783          	ld	a5,0(a0)
    8000d7f8:	0087b783          	ld	a5,8(a5)
    8000d7fc:	000780e7          	jalr	a5
    delete mutexHead;
    8000d800:	0284b503          	ld	a0,40(s1)
    8000d804:	00050863          	beqz	a0,8000d814 <_ZN9BufferCPPD1Ev+0xec>
    8000d808:	00053783          	ld	a5,0(a0)
    8000d80c:	0087b783          	ld	a5,8(a5)
    8000d810:	000780e7          	jalr	a5
}
    8000d814:	01813083          	ld	ra,24(sp)
    8000d818:	01013403          	ld	s0,16(sp)
    8000d81c:	00813483          	ld	s1,8(sp)
    8000d820:	02010113          	addi	sp,sp,32
    8000d824:	00008067          	ret

000000008000d828 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    8000d828:	fe010113          	addi	sp,sp,-32
    8000d82c:	00113c23          	sd	ra,24(sp)
    8000d830:	00813823          	sd	s0,16(sp)
    8000d834:	00913423          	sd	s1,8(sp)
    8000d838:	01213023          	sd	s2,0(sp)
    8000d83c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000d840:	00000913          	li	s2,0
    8000d844:	0380006f          	j	8000d87c <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000d848:	00000097          	auipc	ra,0x0
    8000d84c:	8e8080e7          	jalr	-1816(ra) # 8000d130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000d850:	00148493          	addi	s1,s1,1
    8000d854:	000027b7          	lui	a5,0x2
    8000d858:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000d85c:	0097ee63          	bltu	a5,s1,8000d878 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000d860:	00000713          	li	a4,0
    8000d864:	000077b7          	lui	a5,0x7
    8000d868:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000d86c:	fce7eee3          	bltu	a5,a4,8000d848 <_Z11workerBodyAPv+0x20>
    8000d870:	00170713          	addi	a4,a4,1
    8000d874:	ff1ff06f          	j	8000d864 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000d878:	00190913          	addi	s2,s2,1
    8000d87c:	00900793          	li	a5,9
    8000d880:	0527e063          	bltu	a5,s2,8000d8c0 <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000d884:	00002517          	auipc	a0,0x2
    8000d888:	79450513          	addi	a0,a0,1940 # 80010018 <userDataStart+0x18>
    8000d88c:	00001097          	auipc	ra,0x1
    8000d890:	43c080e7          	jalr	1084(ra) # 8000ecc8 <_Z11printStringPKc>
    8000d894:	00000613          	li	a2,0
    8000d898:	00a00593          	li	a1,10
    8000d89c:	0009051b          	sext.w	a0,s2
    8000d8a0:	00001097          	auipc	ra,0x1
    8000d8a4:	5c0080e7          	jalr	1472(ra) # 8000ee60 <_Z8printIntiii>
    8000d8a8:	00003517          	auipc	a0,0x3
    8000d8ac:	8a050513          	addi	a0,a0,-1888 # 80010148 <userDataStart+0x148>
    8000d8b0:	00001097          	auipc	ra,0x1
    8000d8b4:	418080e7          	jalr	1048(ra) # 8000ecc8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d8b8:	00000493          	li	s1,0
    8000d8bc:	f99ff06f          	j	8000d854 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000d8c0:	00002517          	auipc	a0,0x2
    8000d8c4:	76050513          	addi	a0,a0,1888 # 80010020 <userDataStart+0x20>
    8000d8c8:	00001097          	auipc	ra,0x1
    8000d8cc:	400080e7          	jalr	1024(ra) # 8000ecc8 <_Z11printStringPKc>
    finishedA = true;
    8000d8d0:	00100793          	li	a5,1
    8000d8d4:	00003717          	auipc	a4,0x3
    8000d8d8:	a8f70e23          	sb	a5,-1380(a4) # 80010370 <finishedA>
}
    8000d8dc:	01813083          	ld	ra,24(sp)
    8000d8e0:	01013403          	ld	s0,16(sp)
    8000d8e4:	00813483          	ld	s1,8(sp)
    8000d8e8:	00013903          	ld	s2,0(sp)
    8000d8ec:	02010113          	addi	sp,sp,32
    8000d8f0:	00008067          	ret

000000008000d8f4 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    8000d8f4:	fe010113          	addi	sp,sp,-32
    8000d8f8:	00113c23          	sd	ra,24(sp)
    8000d8fc:	00813823          	sd	s0,16(sp)
    8000d900:	00913423          	sd	s1,8(sp)
    8000d904:	01213023          	sd	s2,0(sp)
    8000d908:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000d90c:	00000913          	li	s2,0
    8000d910:	0380006f          	j	8000d948 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000d914:	00000097          	auipc	ra,0x0
    8000d918:	81c080e7          	jalr	-2020(ra) # 8000d130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000d91c:	00148493          	addi	s1,s1,1
    8000d920:	000027b7          	lui	a5,0x2
    8000d924:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000d928:	0097ee63          	bltu	a5,s1,8000d944 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000d92c:	00000713          	li	a4,0
    8000d930:	000077b7          	lui	a5,0x7
    8000d934:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000d938:	fce7eee3          	bltu	a5,a4,8000d914 <_Z11workerBodyBPv+0x20>
    8000d93c:	00170713          	addi	a4,a4,1
    8000d940:	ff1ff06f          	j	8000d930 <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000d944:	00190913          	addi	s2,s2,1
    8000d948:	00f00793          	li	a5,15
    8000d94c:	0527e063          	bltu	a5,s2,8000d98c <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000d950:	00002517          	auipc	a0,0x2
    8000d954:	6e050513          	addi	a0,a0,1760 # 80010030 <userDataStart+0x30>
    8000d958:	00001097          	auipc	ra,0x1
    8000d95c:	370080e7          	jalr	880(ra) # 8000ecc8 <_Z11printStringPKc>
    8000d960:	00000613          	li	a2,0
    8000d964:	00a00593          	li	a1,10
    8000d968:	0009051b          	sext.w	a0,s2
    8000d96c:	00001097          	auipc	ra,0x1
    8000d970:	4f4080e7          	jalr	1268(ra) # 8000ee60 <_Z8printIntiii>
    8000d974:	00002517          	auipc	a0,0x2
    8000d978:	7d450513          	addi	a0,a0,2004 # 80010148 <userDataStart+0x148>
    8000d97c:	00001097          	auipc	ra,0x1
    8000d980:	34c080e7          	jalr	844(ra) # 8000ecc8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000d984:	00000493          	li	s1,0
    8000d988:	f99ff06f          	j	8000d920 <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000d98c:	00002517          	auipc	a0,0x2
    8000d990:	6ac50513          	addi	a0,a0,1708 # 80010038 <userDataStart+0x38>
    8000d994:	00001097          	auipc	ra,0x1
    8000d998:	334080e7          	jalr	820(ra) # 8000ecc8 <_Z11printStringPKc>
    finishedB = true;
    8000d99c:	00100793          	li	a5,1
    8000d9a0:	00003717          	auipc	a4,0x3
    8000d9a4:	9cf708a3          	sb	a5,-1583(a4) # 80010371 <finishedB>
    thread_dispatch();
    8000d9a8:	fffff097          	auipc	ra,0xfffff
    8000d9ac:	788080e7          	jalr	1928(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000d9b0:	01813083          	ld	ra,24(sp)
    8000d9b4:	01013403          	ld	s0,16(sp)
    8000d9b8:	00813483          	ld	s1,8(sp)
    8000d9bc:	00013903          	ld	s2,0(sp)
    8000d9c0:	02010113          	addi	sp,sp,32
    8000d9c4:	00008067          	ret

000000008000d9c8 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    8000d9c8:	fe010113          	addi	sp,sp,-32
    8000d9cc:	00113c23          	sd	ra,24(sp)
    8000d9d0:	00813823          	sd	s0,16(sp)
    8000d9d4:	00913423          	sd	s1,8(sp)
    8000d9d8:	01213023          	sd	s2,0(sp)
    8000d9dc:	02010413          	addi	s0,sp,32
    8000d9e0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000d9e4:	00100793          	li	a5,1
    8000d9e8:	02a7f863          	bgeu	a5,a0,8000da18 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000d9ec:	00a00793          	li	a5,10
    8000d9f0:	02f577b3          	remu	a5,a0,a5
    8000d9f4:	02078e63          	beqz	a5,8000da30 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000d9f8:	fff48513          	addi	a0,s1,-1
    8000d9fc:	00000097          	auipc	ra,0x0
    8000da00:	fcc080e7          	jalr	-52(ra) # 8000d9c8 <_Z9fibonaccim>
    8000da04:	00050913          	mv	s2,a0
    8000da08:	ffe48513          	addi	a0,s1,-2
    8000da0c:	00000097          	auipc	ra,0x0
    8000da10:	fbc080e7          	jalr	-68(ra) # 8000d9c8 <_Z9fibonaccim>
    8000da14:	00a90533          	add	a0,s2,a0
}
    8000da18:	01813083          	ld	ra,24(sp)
    8000da1c:	01013403          	ld	s0,16(sp)
    8000da20:	00813483          	ld	s1,8(sp)
    8000da24:	00013903          	ld	s2,0(sp)
    8000da28:	02010113          	addi	sp,sp,32
    8000da2c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000da30:	fffff097          	auipc	ra,0xfffff
    8000da34:	700080e7          	jalr	1792(ra) # 8000d130 <_Z15thread_dispatchv>
    8000da38:	fc1ff06f          	j	8000d9f8 <_Z9fibonaccim+0x30>

000000008000da3c <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    8000da3c:	fe010113          	addi	sp,sp,-32
    8000da40:	00113c23          	sd	ra,24(sp)
    8000da44:	00813823          	sd	s0,16(sp)
    8000da48:	00913423          	sd	s1,8(sp)
    8000da4c:	01213023          	sd	s2,0(sp)
    8000da50:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000da54:	00000493          	li	s1,0
    8000da58:	0400006f          	j	8000da98 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000da5c:	00002517          	auipc	a0,0x2
    8000da60:	5ec50513          	addi	a0,a0,1516 # 80010048 <userDataStart+0x48>
    8000da64:	00001097          	auipc	ra,0x1
    8000da68:	264080e7          	jalr	612(ra) # 8000ecc8 <_Z11printStringPKc>
    8000da6c:	00000613          	li	a2,0
    8000da70:	00a00593          	li	a1,10
    8000da74:	00048513          	mv	a0,s1
    8000da78:	00001097          	auipc	ra,0x1
    8000da7c:	3e8080e7          	jalr	1000(ra) # 8000ee60 <_Z8printIntiii>
    8000da80:	00002517          	auipc	a0,0x2
    8000da84:	6c850513          	addi	a0,a0,1736 # 80010148 <userDataStart+0x148>
    8000da88:	00001097          	auipc	ra,0x1
    8000da8c:	240080e7          	jalr	576(ra) # 8000ecc8 <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000da90:	0014849b          	addiw	s1,s1,1
    8000da94:	0ff4f493          	andi	s1,s1,255
    8000da98:	00200793          	li	a5,2
    8000da9c:	fc97f0e3          	bgeu	a5,s1,8000da5c <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    8000daa0:	00002517          	auipc	a0,0x2
    8000daa4:	5b050513          	addi	a0,a0,1456 # 80010050 <userDataStart+0x50>
    8000daa8:	00001097          	auipc	ra,0x1
    8000daac:	220080e7          	jalr	544(ra) # 8000ecc8 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000dab0:	00700313          	li	t1,7
    thread_dispatch();
    8000dab4:	fffff097          	auipc	ra,0xfffff
    8000dab8:	67c080e7          	jalr	1660(ra) # 8000d130 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000dabc:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000dac0:	00002517          	auipc	a0,0x2
    8000dac4:	5a050513          	addi	a0,a0,1440 # 80010060 <userDataStart+0x60>
    8000dac8:	00001097          	auipc	ra,0x1
    8000dacc:	200080e7          	jalr	512(ra) # 8000ecc8 <_Z11printStringPKc>
    8000dad0:	00000613          	li	a2,0
    8000dad4:	00a00593          	li	a1,10
    8000dad8:	0009051b          	sext.w	a0,s2
    8000dadc:	00001097          	auipc	ra,0x1
    8000dae0:	384080e7          	jalr	900(ra) # 8000ee60 <_Z8printIntiii>
    8000dae4:	00002517          	auipc	a0,0x2
    8000dae8:	66450513          	addi	a0,a0,1636 # 80010148 <userDataStart+0x148>
    8000daec:	00001097          	auipc	ra,0x1
    8000daf0:	1dc080e7          	jalr	476(ra) # 8000ecc8 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000daf4:	00c00513          	li	a0,12
    8000daf8:	00000097          	auipc	ra,0x0
    8000dafc:	ed0080e7          	jalr	-304(ra) # 8000d9c8 <_Z9fibonaccim>
    8000db00:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000db04:	00002517          	auipc	a0,0x2
    8000db08:	56450513          	addi	a0,a0,1380 # 80010068 <userDataStart+0x68>
    8000db0c:	00001097          	auipc	ra,0x1
    8000db10:	1bc080e7          	jalr	444(ra) # 8000ecc8 <_Z11printStringPKc>
    8000db14:	00000613          	li	a2,0
    8000db18:	00a00593          	li	a1,10
    8000db1c:	0009051b          	sext.w	a0,s2
    8000db20:	00001097          	auipc	ra,0x1
    8000db24:	340080e7          	jalr	832(ra) # 8000ee60 <_Z8printIntiii>
    8000db28:	00002517          	auipc	a0,0x2
    8000db2c:	62050513          	addi	a0,a0,1568 # 80010148 <userDataStart+0x148>
    8000db30:	00001097          	auipc	ra,0x1
    8000db34:	198080e7          	jalr	408(ra) # 8000ecc8 <_Z11printStringPKc>
    8000db38:	0400006f          	j	8000db78 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000db3c:	00002517          	auipc	a0,0x2
    8000db40:	50c50513          	addi	a0,a0,1292 # 80010048 <userDataStart+0x48>
    8000db44:	00001097          	auipc	ra,0x1
    8000db48:	184080e7          	jalr	388(ra) # 8000ecc8 <_Z11printStringPKc>
    8000db4c:	00000613          	li	a2,0
    8000db50:	00a00593          	li	a1,10
    8000db54:	00048513          	mv	a0,s1
    8000db58:	00001097          	auipc	ra,0x1
    8000db5c:	308080e7          	jalr	776(ra) # 8000ee60 <_Z8printIntiii>
    8000db60:	00002517          	auipc	a0,0x2
    8000db64:	5e850513          	addi	a0,a0,1512 # 80010148 <userDataStart+0x148>
    8000db68:	00001097          	auipc	ra,0x1
    8000db6c:	160080e7          	jalr	352(ra) # 8000ecc8 <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000db70:	0014849b          	addiw	s1,s1,1
    8000db74:	0ff4f493          	andi	s1,s1,255
    8000db78:	00500793          	li	a5,5
    8000db7c:	fc97f0e3          	bgeu	a5,s1,8000db3c <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    8000db80:	00002517          	auipc	a0,0x2
    8000db84:	4a050513          	addi	a0,a0,1184 # 80010020 <userDataStart+0x20>
    8000db88:	00001097          	auipc	ra,0x1
    8000db8c:	140080e7          	jalr	320(ra) # 8000ecc8 <_Z11printStringPKc>
    finishedC = true;
    8000db90:	00100793          	li	a5,1
    8000db94:	00002717          	auipc	a4,0x2
    8000db98:	7ef70223          	sb	a5,2020(a4) # 80010378 <finishedC>
    thread_dispatch();
    8000db9c:	fffff097          	auipc	ra,0xfffff
    8000dba0:	594080e7          	jalr	1428(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000dba4:	01813083          	ld	ra,24(sp)
    8000dba8:	01013403          	ld	s0,16(sp)
    8000dbac:	00813483          	ld	s1,8(sp)
    8000dbb0:	00013903          	ld	s2,0(sp)
    8000dbb4:	02010113          	addi	sp,sp,32
    8000dbb8:	00008067          	ret

000000008000dbbc <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    8000dbbc:	fe010113          	addi	sp,sp,-32
    8000dbc0:	00113c23          	sd	ra,24(sp)
    8000dbc4:	00813823          	sd	s0,16(sp)
    8000dbc8:	00913423          	sd	s1,8(sp)
    8000dbcc:	01213023          	sd	s2,0(sp)
    8000dbd0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000dbd4:	00a00493          	li	s1,10
    8000dbd8:	0400006f          	j	8000dc18 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000dbdc:	00002517          	auipc	a0,0x2
    8000dbe0:	49c50513          	addi	a0,a0,1180 # 80010078 <userDataStart+0x78>
    8000dbe4:	00001097          	auipc	ra,0x1
    8000dbe8:	0e4080e7          	jalr	228(ra) # 8000ecc8 <_Z11printStringPKc>
    8000dbec:	00000613          	li	a2,0
    8000dbf0:	00a00593          	li	a1,10
    8000dbf4:	00048513          	mv	a0,s1
    8000dbf8:	00001097          	auipc	ra,0x1
    8000dbfc:	268080e7          	jalr	616(ra) # 8000ee60 <_Z8printIntiii>
    8000dc00:	00002517          	auipc	a0,0x2
    8000dc04:	54850513          	addi	a0,a0,1352 # 80010148 <userDataStart+0x148>
    8000dc08:	00001097          	auipc	ra,0x1
    8000dc0c:	0c0080e7          	jalr	192(ra) # 8000ecc8 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000dc10:	0014849b          	addiw	s1,s1,1
    8000dc14:	0ff4f493          	andi	s1,s1,255
    8000dc18:	00c00793          	li	a5,12
    8000dc1c:	fc97f0e3          	bgeu	a5,s1,8000dbdc <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000dc20:	00002517          	auipc	a0,0x2
    8000dc24:	46050513          	addi	a0,a0,1120 # 80010080 <userDataStart+0x80>
    8000dc28:	00001097          	auipc	ra,0x1
    8000dc2c:	0a0080e7          	jalr	160(ra) # 8000ecc8 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000dc30:	00500313          	li	t1,5
    thread_dispatch();
    8000dc34:	fffff097          	auipc	ra,0xfffff
    8000dc38:	4fc080e7          	jalr	1276(ra) # 8000d130 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000dc3c:	01000513          	li	a0,16
    8000dc40:	00000097          	auipc	ra,0x0
    8000dc44:	d88080e7          	jalr	-632(ra) # 8000d9c8 <_Z9fibonaccim>
    8000dc48:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000dc4c:	00002517          	auipc	a0,0x2
    8000dc50:	44450513          	addi	a0,a0,1092 # 80010090 <userDataStart+0x90>
    8000dc54:	00001097          	auipc	ra,0x1
    8000dc58:	074080e7          	jalr	116(ra) # 8000ecc8 <_Z11printStringPKc>
    8000dc5c:	00000613          	li	a2,0
    8000dc60:	00a00593          	li	a1,10
    8000dc64:	0009051b          	sext.w	a0,s2
    8000dc68:	00001097          	auipc	ra,0x1
    8000dc6c:	1f8080e7          	jalr	504(ra) # 8000ee60 <_Z8printIntiii>
    8000dc70:	00002517          	auipc	a0,0x2
    8000dc74:	4d850513          	addi	a0,a0,1240 # 80010148 <userDataStart+0x148>
    8000dc78:	00001097          	auipc	ra,0x1
    8000dc7c:	050080e7          	jalr	80(ra) # 8000ecc8 <_Z11printStringPKc>
    8000dc80:	0400006f          	j	8000dcc0 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000dc84:	00002517          	auipc	a0,0x2
    8000dc88:	3f450513          	addi	a0,a0,1012 # 80010078 <userDataStart+0x78>
    8000dc8c:	00001097          	auipc	ra,0x1
    8000dc90:	03c080e7          	jalr	60(ra) # 8000ecc8 <_Z11printStringPKc>
    8000dc94:	00000613          	li	a2,0
    8000dc98:	00a00593          	li	a1,10
    8000dc9c:	00048513          	mv	a0,s1
    8000dca0:	00001097          	auipc	ra,0x1
    8000dca4:	1c0080e7          	jalr	448(ra) # 8000ee60 <_Z8printIntiii>
    8000dca8:	00002517          	auipc	a0,0x2
    8000dcac:	4a050513          	addi	a0,a0,1184 # 80010148 <userDataStart+0x148>
    8000dcb0:	00001097          	auipc	ra,0x1
    8000dcb4:	018080e7          	jalr	24(ra) # 8000ecc8 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000dcb8:	0014849b          	addiw	s1,s1,1
    8000dcbc:	0ff4f493          	andi	s1,s1,255
    8000dcc0:	00f00793          	li	a5,15
    8000dcc4:	fc97f0e3          	bgeu	a5,s1,8000dc84 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000dcc8:	00002517          	auipc	a0,0x2
    8000dccc:	3d850513          	addi	a0,a0,984 # 800100a0 <userDataStart+0xa0>
    8000dcd0:	00001097          	auipc	ra,0x1
    8000dcd4:	ff8080e7          	jalr	-8(ra) # 8000ecc8 <_Z11printStringPKc>
    finishedD = true;
    8000dcd8:	00100793          	li	a5,1
    8000dcdc:	00002717          	auipc	a4,0x2
    8000dce0:	68f70ea3          	sb	a5,1693(a4) # 80010379 <finishedD>
    thread_dispatch();
    8000dce4:	fffff097          	auipc	ra,0xfffff
    8000dce8:	44c080e7          	jalr	1100(ra) # 8000d130 <_Z15thread_dispatchv>
}
    8000dcec:	01813083          	ld	ra,24(sp)
    8000dcf0:	01013403          	ld	s0,16(sp)
    8000dcf4:	00813483          	ld	s1,8(sp)
    8000dcf8:	00013903          	ld	s2,0(sp)
    8000dcfc:	02010113          	addi	sp,sp,32
    8000dd00:	00008067          	ret

000000008000dd04 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000dd04:	fc010113          	addi	sp,sp,-64
    8000dd08:	02113c23          	sd	ra,56(sp)
    8000dd0c:	02813823          	sd	s0,48(sp)
    8000dd10:	02913423          	sd	s1,40(sp)
    8000dd14:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000dd18:	00000613          	li	a2,0
    8000dd1c:	00000597          	auipc	a1,0x0
    8000dd20:	b0c58593          	addi	a1,a1,-1268 # 8000d828 <_Z11workerBodyAPv>
    8000dd24:	fc040513          	addi	a0,s0,-64
    8000dd28:	fffff097          	auipc	ra,0xfffff
    8000dd2c:	354080e7          	jalr	852(ra) # 8000d07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000dd30:	00002517          	auipc	a0,0x2
    8000dd34:	38050513          	addi	a0,a0,896 # 800100b0 <userDataStart+0xb0>
    8000dd38:	00001097          	auipc	ra,0x1
    8000dd3c:	f90080e7          	jalr	-112(ra) # 8000ecc8 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000dd40:	00000613          	li	a2,0
    8000dd44:	00000597          	auipc	a1,0x0
    8000dd48:	bb058593          	addi	a1,a1,-1104 # 8000d8f4 <_Z11workerBodyBPv>
    8000dd4c:	fc840513          	addi	a0,s0,-56
    8000dd50:	fffff097          	auipc	ra,0xfffff
    8000dd54:	32c080e7          	jalr	812(ra) # 8000d07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    8000dd58:	00002517          	auipc	a0,0x2
    8000dd5c:	37050513          	addi	a0,a0,880 # 800100c8 <userDataStart+0xc8>
    8000dd60:	00001097          	auipc	ra,0x1
    8000dd64:	f68080e7          	jalr	-152(ra) # 8000ecc8 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000dd68:	00000613          	li	a2,0
    8000dd6c:	00000597          	auipc	a1,0x0
    8000dd70:	cd058593          	addi	a1,a1,-816 # 8000da3c <_Z11workerBodyCPv>
    8000dd74:	fd040513          	addi	a0,s0,-48
    8000dd78:	fffff097          	auipc	ra,0xfffff
    8000dd7c:	304080e7          	jalr	772(ra) # 8000d07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    8000dd80:	00002517          	auipc	a0,0x2
    8000dd84:	36050513          	addi	a0,a0,864 # 800100e0 <userDataStart+0xe0>
    8000dd88:	00001097          	auipc	ra,0x1
    8000dd8c:	f40080e7          	jalr	-192(ra) # 8000ecc8 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000dd90:	00000613          	li	a2,0
    8000dd94:	00000597          	auipc	a1,0x0
    8000dd98:	e2858593          	addi	a1,a1,-472 # 8000dbbc <_Z11workerBodyDPv>
    8000dd9c:	fd840513          	addi	a0,s0,-40
    8000dda0:	fffff097          	auipc	ra,0xfffff
    8000dda4:	2dc080e7          	jalr	732(ra) # 8000d07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    8000dda8:	00002517          	auipc	a0,0x2
    8000ddac:	35050513          	addi	a0,a0,848 # 800100f8 <userDataStart+0xf8>
    8000ddb0:	00001097          	auipc	ra,0x1
    8000ddb4:	f18080e7          	jalr	-232(ra) # 8000ecc8 <_Z11printStringPKc>
    8000ddb8:	00c0006f          	j	8000ddc4 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000ddbc:	fffff097          	auipc	ra,0xfffff
    8000ddc0:	374080e7          	jalr	884(ra) # 8000d130 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000ddc4:	00002797          	auipc	a5,0x2
    8000ddc8:	5ac7c783          	lbu	a5,1452(a5) # 80010370 <finishedA>
    8000ddcc:	fe0788e3          	beqz	a5,8000ddbc <_Z18Threads_C_API_testv+0xb8>
    8000ddd0:	00002797          	auipc	a5,0x2
    8000ddd4:	5a17c783          	lbu	a5,1441(a5) # 80010371 <finishedB>
    8000ddd8:	fe0782e3          	beqz	a5,8000ddbc <_Z18Threads_C_API_testv+0xb8>
    8000dddc:	00002797          	auipc	a5,0x2
    8000dde0:	59c7c783          	lbu	a5,1436(a5) # 80010378 <finishedC>
    8000dde4:	fc078ce3          	beqz	a5,8000ddbc <_Z18Threads_C_API_testv+0xb8>
    8000dde8:	00002797          	auipc	a5,0x2
    8000ddec:	5917c783          	lbu	a5,1425(a5) # 80010379 <finishedD>
    8000ddf0:	fc0786e3          	beqz	a5,8000ddbc <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    8000ddf4:	fc040493          	addi	s1,s0,-64
    8000ddf8:	0080006f          	j	8000de00 <_Z18Threads_C_API_testv+0xfc>
    8000ddfc:	00848493          	addi	s1,s1,8
    8000de00:	fe040793          	addi	a5,s0,-32
    8000de04:	00f48c63          	beq	s1,a5,8000de1c <_Z18Threads_C_API_testv+0x118>
    8000de08:	0004b503          	ld	a0,0(s1)
    8000de0c:	fe0508e3          	beqz	a0,8000ddfc <_Z18Threads_C_API_testv+0xf8>
    8000de10:	fffff097          	auipc	ra,0xfffff
    8000de14:	5b4080e7          	jalr	1460(ra) # 8000d3c4 <_ZN7_threaddlEPv>
    8000de18:	fe5ff06f          	j	8000ddfc <_Z18Threads_C_API_testv+0xf8>
}
    8000de1c:	03813083          	ld	ra,56(sp)
    8000de20:	03013403          	ld	s0,48(sp)
    8000de24:	02813483          	ld	s1,40(sp)
    8000de28:	04010113          	addi	sp,sp,64
    8000de2c:	00008067          	ret

000000008000de30 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    8000de30:	f8010113          	addi	sp,sp,-128
    8000de34:	06113c23          	sd	ra,120(sp)
    8000de38:	06813823          	sd	s0,112(sp)
    8000de3c:	06913423          	sd	s1,104(sp)
    8000de40:	07213023          	sd	s2,96(sp)
    8000de44:	05313c23          	sd	s3,88(sp)
    8000de48:	05413823          	sd	s4,80(sp)
    8000de4c:	05513423          	sd	s5,72(sp)
    8000de50:	05613023          	sd	s6,64(sp)
    8000de54:	03713c23          	sd	s7,56(sp)
    8000de58:	03813823          	sd	s8,48(sp)
    8000de5c:	03913423          	sd	s9,40(sp)
    8000de60:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    8000de64:	00010b93          	mv	s7,sp
        printString("Unesite broj proizvodjaca?\n");
    8000de68:	00002517          	auipc	a0,0x2
    8000de6c:	2a850513          	addi	a0,a0,680 # 80010110 <userDataStart+0x110>
    8000de70:	00001097          	auipc	ra,0x1
    8000de74:	e58080e7          	jalr	-424(ra) # 8000ecc8 <_Z11printStringPKc>
        getString(input, 30);
    8000de78:	01e00593          	li	a1,30
    8000de7c:	f8040493          	addi	s1,s0,-128
    8000de80:	00048513          	mv	a0,s1
    8000de84:	00001097          	auipc	ra,0x1
    8000de88:	ec0080e7          	jalr	-320(ra) # 8000ed44 <_Z9getStringPci>
        threadNum = stringToInt(input);
    8000de8c:	00048513          	mv	a0,s1
    8000de90:	00001097          	auipc	ra,0x1
    8000de94:	f80080e7          	jalr	-128(ra) # 8000ee10 <_Z11stringToIntPKc>
    8000de98:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    8000de9c:	00002517          	auipc	a0,0x2
    8000dea0:	29450513          	addi	a0,a0,660 # 80010130 <userDataStart+0x130>
    8000dea4:	00001097          	auipc	ra,0x1
    8000dea8:	e24080e7          	jalr	-476(ra) # 8000ecc8 <_Z11printStringPKc>
        getString(input, 30);
    8000deac:	01e00593          	li	a1,30
    8000deb0:	00048513          	mv	a0,s1
    8000deb4:	00001097          	auipc	ra,0x1
    8000deb8:	e90080e7          	jalr	-368(ra) # 8000ed44 <_Z9getStringPci>
        n = stringToInt(input);
    8000debc:	00048513          	mv	a0,s1
    8000dec0:	00001097          	auipc	ra,0x1
    8000dec4:	f50080e7          	jalr	-176(ra) # 8000ee10 <_Z11stringToIntPKc>
    8000dec8:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    8000decc:	00002517          	auipc	a0,0x2
    8000ded0:	28450513          	addi	a0,a0,644 # 80010150 <userDataStart+0x150>
    8000ded4:	00001097          	auipc	ra,0x1
    8000ded8:	df4080e7          	jalr	-524(ra) # 8000ecc8 <_Z11printStringPKc>
    8000dedc:	00000613          	li	a2,0
    8000dee0:	00a00593          	li	a1,10
    8000dee4:	00090513          	mv	a0,s2
    8000dee8:	00001097          	auipc	ra,0x1
    8000deec:	f78080e7          	jalr	-136(ra) # 8000ee60 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000def0:	00002517          	auipc	a0,0x2
    8000def4:	27850513          	addi	a0,a0,632 # 80010168 <userDataStart+0x168>
    8000def8:	00001097          	auipc	ra,0x1
    8000defc:	dd0080e7          	jalr	-560(ra) # 8000ecc8 <_Z11printStringPKc>
    8000df00:	00000613          	li	a2,0
    8000df04:	00a00593          	li	a1,10
    8000df08:	00048513          	mv	a0,s1
    8000df0c:	00001097          	auipc	ra,0x1
    8000df10:	f54080e7          	jalr	-172(ra) # 8000ee60 <_Z8printIntiii>
        printString(".\n");
    8000df14:	00002517          	auipc	a0,0x2
    8000df18:	26c50513          	addi	a0,a0,620 # 80010180 <userDataStart+0x180>
    8000df1c:	00001097          	auipc	ra,0x1
    8000df20:	dac080e7          	jalr	-596(ra) # 8000ecc8 <_Z11printStringPKc>
        if(threadNum > n) {
    8000df24:	0324c663          	blt	s1,s2,8000df50 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    8000df28:	03205e63          	blez	s2,8000df64 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    8000df2c:	03800513          	li	a0,56
    8000df30:	00001097          	auipc	ra,0x1
    8000df34:	0e8080e7          	jalr	232(ra) # 8000f018 <_Znwm>
    8000df38:	00050a93          	mv	s5,a0
    8000df3c:	04050063          	beqz	a0,8000df7c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
    8000df40:	00048593          	mv	a1,s1
    8000df44:	fffff097          	auipc	ra,0xfffff
    8000df48:	4dc080e7          	jalr	1244(ra) # 8000d420 <_ZN9BufferCPPC1Ei>
    8000df4c:	0300006f          	j	8000df7c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000df50:	00002517          	auipc	a0,0x2
    8000df54:	23850513          	addi	a0,a0,568 # 80010188 <userDataStart+0x188>
    8000df58:	00001097          	auipc	ra,0x1
    8000df5c:	d70080e7          	jalr	-656(ra) # 8000ecc8 <_Z11printStringPKc>
            return;
    8000df60:	0140006f          	j	8000df74 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000df64:	00002517          	auipc	a0,0x2
    8000df68:	26450513          	addi	a0,a0,612 # 800101c8 <userDataStart+0x1c8>
    8000df6c:	00001097          	auipc	ra,0x1
    8000df70:	d5c080e7          	jalr	-676(ra) # 8000ecc8 <_Z11printStringPKc>
            return;
    8000df74:	000b8113          	mv	sp,s7
    8000df78:	24c0006f          	j	8000e1c4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    8000df7c:	01000513          	li	a0,16
    8000df80:	00001097          	auipc	ra,0x1
    8000df84:	098080e7          	jalr	152(ra) # 8000f018 <_Znwm>
    8000df88:	00050493          	mv	s1,a0
    8000df8c:	00050863          	beqz	a0,8000df9c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000df90:	00000593          	li	a1,0
    8000df94:	00001097          	auipc	ra,0x1
    8000df98:	17c080e7          	jalr	380(ra) # 8000f110 <_ZN9SemaphoreC1Ej>
    8000df9c:	00002717          	auipc	a4,0x2
    8000dfa0:	3d470713          	addi	a4,a4,980 # 80010370 <finishedA>
    8000dfa4:	00973823          	sd	s1,16(a4)
        Thread *producers[threadNum];
    8000dfa8:	00391793          	slli	a5,s2,0x3
    8000dfac:	00f78793          	addi	a5,a5,15
    8000dfb0:	ff07f793          	andi	a5,a5,-16
    8000dfb4:	40f10133          	sub	sp,sp,a5
    8000dfb8:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    8000dfbc:	0019069b          	addiw	a3,s2,1
    8000dfc0:	00169793          	slli	a5,a3,0x1
    8000dfc4:	00d787b3          	add	a5,a5,a3
    8000dfc8:	00379793          	slli	a5,a5,0x3
    8000dfcc:	00f78793          	addi	a5,a5,15
    8000dfd0:	ff07f793          	andi	a5,a5,-16
    8000dfd4:	40f10133          	sub	sp,sp,a5
    8000dfd8:	00010993          	mv	s3,sp
        threadData[threadNum].id = threadNum;
    8000dfdc:	00191793          	slli	a5,s2,0x1
    8000dfe0:	012787b3          	add	a5,a5,s2
    8000dfe4:	00379793          	slli	a5,a5,0x3
    8000dfe8:	00f987b3          	add	a5,s3,a5
    8000dfec:	0127a023          	sw	s2,0(a5)
        threadData[threadNum].buffer = buffer;
    8000dff0:	0157b423          	sd	s5,8(a5)
        threadData[threadNum].sem = waitForAll;
    8000dff4:	01073703          	ld	a4,16(a4)
    8000dff8:	00e7b823          	sd	a4,16(a5)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000dffc:	01800513          	li	a0,24
    8000e000:	00001097          	auipc	ra,0x1
    8000e004:	018080e7          	jalr	24(ra) # 8000f018 <_Znwm>
    8000e008:	00050b13          	mv	s6,a0
    8000e00c:	02050663          	beqz	a0,8000e038 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    8000e010:	00191493          	slli	s1,s2,0x1
    8000e014:	012484b3          	add	s1,s1,s2
    8000e018:	00349493          	slli	s1,s1,0x3
    8000e01c:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000e020:	00001097          	auipc	ra,0x1
    8000e024:	1d4080e7          	jalr	468(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e028:	00002797          	auipc	a5,0x2
    8000e02c:	27878793          	addi	a5,a5,632 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e030:	00fb3023          	sd	a5,0(s6) # 2000 <_entry-0x7fffe000>
    8000e034:	009b3823          	sd	s1,16(s6)
        consumer->start();
    8000e038:	000b0513          	mv	a0,s6
    8000e03c:	00001097          	auipc	ra,0x1
    8000e040:	2a8080e7          	jalr	680(ra) # 8000f2e4 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    8000e044:	0009a023          	sw	zero,0(s3)
        threadData[0].buffer = buffer;
    8000e048:	0159b423          	sd	s5,8(s3)
        threadData[0].sem = waitForAll;
    8000e04c:	00002797          	auipc	a5,0x2
    8000e050:	3347b783          	ld	a5,820(a5) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e054:	00f9b823          	sd	a5,16(s3)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e058:	01800513          	li	a0,24
    8000e05c:	00001097          	auipc	ra,0x1
    8000e060:	fbc080e7          	jalr	-68(ra) # 8000f018 <_Znwm>
    8000e064:	00050493          	mv	s1,a0
    8000e068:	00050e63          	beqz	a0,8000e084 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    8000e06c:	00001097          	auipc	ra,0x1
    8000e070:	188080e7          	jalr	392(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e074:	00002797          	auipc	a5,0x2
    8000e078:	1dc78793          	addi	a5,a5,476 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e07c:	00f4b023          	sd	a5,0(s1)
    8000e080:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e084:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    8000e088:	00048513          	mv	a0,s1
    8000e08c:	00001097          	auipc	ra,0x1
    8000e090:	258080e7          	jalr	600(ra) # 8000f2e4 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    8000e094:	00100493          	li	s1,1
    8000e098:	0300006f          	j	8000e0c8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x298>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000e09c:	00002797          	auipc	a5,0x2
    8000e0a0:	1dc78793          	addi	a5,a5,476 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e0a4:	00fc3023          	sd	a5,0(s8)
    8000e0a8:	019c3823          	sd	s9,16(s8)
            producers[i] = new Producer(&threadData[i]);
    8000e0ac:	00349793          	slli	a5,s1,0x3
    8000e0b0:	00fa07b3          	add	a5,s4,a5
    8000e0b4:	0187b023          	sd	s8,0(a5)
            producers[i]->start();
    8000e0b8:	000c0513          	mv	a0,s8
    8000e0bc:	00001097          	auipc	ra,0x1
    8000e0c0:	228080e7          	jalr	552(ra) # 8000f2e4 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    8000e0c4:	0014849b          	addiw	s1,s1,1
    8000e0c8:	0524dc63          	bge	s1,s2,8000e120 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2f0>
            threadData[i].id = i;
    8000e0cc:	00149793          	slli	a5,s1,0x1
    8000e0d0:	009787b3          	add	a5,a5,s1
    8000e0d4:	00379793          	slli	a5,a5,0x3
    8000e0d8:	00f987b3          	add	a5,s3,a5
    8000e0dc:	0097a023          	sw	s1,0(a5)
            threadData[i].buffer = buffer;
    8000e0e0:	0157b423          	sd	s5,8(a5)
            threadData[i].sem = waitForAll;
    8000e0e4:	00002717          	auipc	a4,0x2
    8000e0e8:	29c73703          	ld	a4,668(a4) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e0ec:	00e7b823          	sd	a4,16(a5)
            producers[i] = new Producer(&threadData[i]);
    8000e0f0:	01800513          	li	a0,24
    8000e0f4:	00001097          	auipc	ra,0x1
    8000e0f8:	f24080e7          	jalr	-220(ra) # 8000f018 <_Znwm>
    8000e0fc:	00050c13          	mv	s8,a0
    8000e100:	fa0506e3          	beqz	a0,8000e0ac <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    8000e104:	00149c93          	slli	s9,s1,0x1
    8000e108:	009c8cb3          	add	s9,s9,s1
    8000e10c:	003c9c93          	slli	s9,s9,0x3
    8000e110:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000e114:	00001097          	auipc	ra,0x1
    8000e118:	0e0080e7          	jalr	224(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e11c:	f81ff06f          	j	8000e09c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    8000e120:	00001097          	auipc	ra,0x1
    8000e124:	19c080e7          	jalr	412(ra) # 8000f2bc <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000e128:	00000493          	li	s1,0
    8000e12c:	00994e63          	blt	s2,s1,8000e148 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    8000e130:	00002517          	auipc	a0,0x2
    8000e134:	25053503          	ld	a0,592(a0) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e138:	00001097          	auipc	ra,0x1
    8000e13c:	010080e7          	jalr	16(ra) # 8000f148 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    8000e140:	0014849b          	addiw	s1,s1,1
    8000e144:	fe9ff06f          	j	8000e12c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
        delete waitForAll;
    8000e148:	00002517          	auipc	a0,0x2
    8000e14c:	23853503          	ld	a0,568(a0) # 80010380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000e150:	00050863          	beqz	a0,8000e160 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x330>
    8000e154:	00053783          	ld	a5,0(a0)
    8000e158:	0087b783          	ld	a5,8(a5)
    8000e15c:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    8000e160:	00000493          	li	s1,0
    8000e164:	0080006f          	j	8000e16c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x33c>
        for (int i = 0; i < threadNum; i++) {
    8000e168:	0014849b          	addiw	s1,s1,1
    8000e16c:	0324d263          	bge	s1,s2,8000e190 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
            delete producers[i];
    8000e170:	00349793          	slli	a5,s1,0x3
    8000e174:	00fa07b3          	add	a5,s4,a5
    8000e178:	0007b503          	ld	a0,0(a5)
    8000e17c:	fe0506e3          	beqz	a0,8000e168 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
    8000e180:	00053783          	ld	a5,0(a0)
    8000e184:	0087b783          	ld	a5,8(a5)
    8000e188:	000780e7          	jalr	a5
    8000e18c:	fddff06f          	j	8000e168 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
        delete consumer;
    8000e190:	000b0a63          	beqz	s6,8000e1a4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x374>
    8000e194:	000b3783          	ld	a5,0(s6)
    8000e198:	0087b783          	ld	a5,8(a5)
    8000e19c:	000b0513          	mv	a0,s6
    8000e1a0:	000780e7          	jalr	a5
        delete buffer;
    8000e1a4:	000a8e63          	beqz	s5,8000e1c0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x390>
    8000e1a8:	000a8513          	mv	a0,s5
    8000e1ac:	fffff097          	auipc	ra,0xfffff
    8000e1b0:	57c080e7          	jalr	1404(ra) # 8000d728 <_ZN9BufferCPPD1Ev>
    8000e1b4:	000a8513          	mv	a0,s5
    8000e1b8:	00001097          	auipc	ra,0x1
    8000e1bc:	eb0080e7          	jalr	-336(ra) # 8000f068 <_ZdlPv>
    8000e1c0:	000b8113          	mv	sp,s7
    }
    8000e1c4:	f8040113          	addi	sp,s0,-128
    8000e1c8:	07813083          	ld	ra,120(sp)
    8000e1cc:	07013403          	ld	s0,112(sp)
    8000e1d0:	06813483          	ld	s1,104(sp)
    8000e1d4:	06013903          	ld	s2,96(sp)
    8000e1d8:	05813983          	ld	s3,88(sp)
    8000e1dc:	05013a03          	ld	s4,80(sp)
    8000e1e0:	04813a83          	ld	s5,72(sp)
    8000e1e4:	04013b03          	ld	s6,64(sp)
    8000e1e8:	03813b83          	ld	s7,56(sp)
    8000e1ec:	03013c03          	ld	s8,48(sp)
    8000e1f0:	02813c83          	ld	s9,40(sp)
    8000e1f4:	08010113          	addi	sp,sp,128
    8000e1f8:	00008067          	ret
    8000e1fc:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    8000e200:	000a8513          	mv	a0,s5
    8000e204:	00001097          	auipc	ra,0x1
    8000e208:	e64080e7          	jalr	-412(ra) # 8000f068 <_ZdlPv>
    8000e20c:	00048513          	mv	a0,s1
    8000e210:	ffffe097          	auipc	ra,0xffffe
    8000e214:	1c8080e7          	jalr	456(ra) # 8000c3d8 <_Unwind_Resume>
    8000e218:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    8000e21c:	00048513          	mv	a0,s1
    8000e220:	00001097          	auipc	ra,0x1
    8000e224:	e48080e7          	jalr	-440(ra) # 8000f068 <_ZdlPv>
    8000e228:	00090513          	mv	a0,s2
    8000e22c:	ffffe097          	auipc	ra,0xffffe
    8000e230:	1ac080e7          	jalr	428(ra) # 8000c3d8 <_Unwind_Resume>
    8000e234:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000e238:	000b0513          	mv	a0,s6
    8000e23c:	00001097          	auipc	ra,0x1
    8000e240:	e2c080e7          	jalr	-468(ra) # 8000f068 <_ZdlPv>
    8000e244:	00048513          	mv	a0,s1
    8000e248:	ffffe097          	auipc	ra,0xffffe
    8000e24c:	190080e7          	jalr	400(ra) # 8000c3d8 <_Unwind_Resume>
    8000e250:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000e254:	00048513          	mv	a0,s1
    8000e258:	00001097          	auipc	ra,0x1
    8000e25c:	e10080e7          	jalr	-496(ra) # 8000f068 <_ZdlPv>
    8000e260:	00090513          	mv	a0,s2
    8000e264:	ffffe097          	auipc	ra,0xffffe
    8000e268:	174080e7          	jalr	372(ra) # 8000c3d8 <_Unwind_Resume>
    8000e26c:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000e270:	000c0513          	mv	a0,s8
    8000e274:	00001097          	auipc	ra,0x1
    8000e278:	df4080e7          	jalr	-524(ra) # 8000f068 <_ZdlPv>
    8000e27c:	00048513          	mv	a0,s1
    8000e280:	ffffe097          	auipc	ra,0xffffe
    8000e284:	158080e7          	jalr	344(ra) # 8000c3d8 <_Unwind_Resume>

000000008000e288 <_Z8testUserv>:
    long id;
    bool finished;
};


void testUser() {
    8000e288:	fc010113          	addi	sp,sp,-64
    8000e28c:	02113c23          	sd	ra,56(sp)
    8000e290:	02813823          	sd	s0,48(sp)
    8000e294:	02913423          	sd	s1,40(sp)
    8000e298:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e29c:	fc040493          	addi	s1,s0,-64
    8000e2a0:	00048513          	mv	a0,s1
    8000e2a4:	00001097          	auipc	ra,0x1
    8000e2a8:	f50080e7          	jalr	-176(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e2ac:	00002797          	auipc	a5,0x2
    8000e2b0:	01c78793          	addi	a5,a5,28 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e2b4:	fcf43023          	sd	a5,-64(s0)
    8000e2b8:	00100793          	li	a5,1
    8000e2bc:	fcf43823          	sd	a5,-48(s0)
    8000e2c0:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    8000e2c4:	00048513          	mv	a0,s1
    8000e2c8:	00001097          	auipc	ra,0x1
    8000e2cc:	01c080e7          	jalr	28(ra) # 8000f2e4 <_ZN6Thread5startEv>
        return finished;
    8000e2d0:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    8000e2d4:	00079863          	bnez	a5,8000e2e4 <_Z8testUserv+0x5c>
        thread_dispatch();
    8000e2d8:	fffff097          	auipc	ra,0xfffff
    8000e2dc:	e58080e7          	jalr	-424(ra) # 8000d130 <_Z15thread_dispatchv>
    8000e2e0:	ff1ff06f          	j	8000e2d0 <_Z8testUserv+0x48>
    }

//    ConsoleUtil::printString("User main finished\n");
    printString("User main finished\n");
    8000e2e4:	00002517          	auipc	a0,0x2
    8000e2e8:	f1450513          	addi	a0,a0,-236 # 800101f8 <userDataStart+0x1f8>
    8000e2ec:	00001097          	auipc	ra,0x1
    8000e2f0:	9dc080e7          	jalr	-1572(ra) # 8000ecc8 <_Z11printStringPKc>
class ForkThread : public Thread {
    8000e2f4:	00002797          	auipc	a5,0x2
    8000e2f8:	fd478793          	addi	a5,a5,-44 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e2fc:	fcf43023          	sd	a5,-64(s0)
    8000e300:	fc040513          	addi	a0,s0,-64
    8000e304:	00001097          	auipc	ra,0x1
    8000e308:	cd4080e7          	jalr	-812(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e30c:	03813083          	ld	ra,56(sp)
    8000e310:	03013403          	ld	s0,48(sp)
    8000e314:	02813483          	ld	s1,40(sp)
    8000e318:	04010113          	addi	sp,sp,64
    8000e31c:	00008067          	ret
    8000e320:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    8000e324:	00002797          	auipc	a5,0x2
    8000e328:	fa478793          	addi	a5,a5,-92 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e32c:	fcf43023          	sd	a5,-64(s0)
    8000e330:	fc040513          	addi	a0,s0,-64
    8000e334:	00001097          	auipc	ra,0x1
    8000e338:	ca4080e7          	jalr	-860(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e33c:	00048513          	mv	a0,s1
    8000e340:	ffffe097          	auipc	ra,0xffffe
    8000e344:	098080e7          	jalr	152(ra) # 8000c3d8 <_Unwind_Resume>

000000008000e348 <_Z8userMainv>:
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta
#include "testUser.hpp"
#include "../../../h/kernel/buddy_allocator.hpp"


void userMain() {
    8000e348:	ff010113          	addi	sp,sp,-16
    8000e34c:	00113423          	sd	ra,8(sp)
    8000e350:	00813023          	sd	s0,0(sp)
    8000e354:	01010413          	addi	s0,sp,16

//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    8000e358:	00000097          	auipc	ra,0x0
    8000e35c:	ad8080e7          	jalr	-1320(ra) # 8000de30 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>
    testUser();
    8000e360:	00000097          	auipc	ra,0x0
    8000e364:	f28080e7          	jalr	-216(ra) # 8000e288 <_Z8testUserv>
}
    8000e368:	00813083          	ld	ra,8(sp)
    8000e36c:	00013403          	ld	s0,0(sp)
    8000e370:	01010113          	addi	sp,sp,16
    8000e374:	00008067          	ret

000000008000e378 <_Z15userMainWrapperPv>:

void userMainWrapper(void* args) {
    8000e378:	ff010113          	addi	sp,sp,-16
    8000e37c:	00113423          	sd	ra,8(sp)
    8000e380:	00813023          	sd	s0,0(sp)
    8000e384:	01010413          	addi	s0,sp,16
    userMain();
    8000e388:	00000097          	auipc	ra,0x0
    8000e38c:	fc0080e7          	jalr	-64(ra) # 8000e348 <_Z8userMainv>
    8000e390:	00813083          	ld	ra,8(sp)
    8000e394:	00013403          	ld	s0,0(sp)
    8000e398:	01010113          	addi	sp,sp,16
    8000e39c:	00008067          	ret

000000008000e3a0 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    8000e3a0:	fd010113          	addi	sp,sp,-48
    8000e3a4:	02113423          	sd	ra,40(sp)
    8000e3a8:	02813023          	sd	s0,32(sp)
    8000e3ac:	00913c23          	sd	s1,24(sp)
    8000e3b0:	01213823          	sd	s2,16(sp)
    8000e3b4:	01313423          	sd	s3,8(sp)
    8000e3b8:	03010413          	addi	s0,sp,48
    8000e3bc:	00050913          	mv	s2,a0
            int i = 0;
    8000e3c0:	00000993          	li	s3,0
    8000e3c4:	0100006f          	j	8000e3d4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    8000e3c8:	00a00513          	li	a0,10
    8000e3cc:	00001097          	auipc	ra,0x1
    8000e3d0:	fe0080e7          	jalr	-32(ra) # 8000f3ac <_ZN7Console4putcEc>
            while (!threadEnd) {
    8000e3d4:	00002797          	auipc	a5,0x2
    8000e3d8:	fa07a783          	lw	a5,-96(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e3dc:	04079a63          	bnez	a5,8000e430 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    8000e3e0:	01093783          	ld	a5,16(s2)
    8000e3e4:	0087b503          	ld	a0,8(a5)
    8000e3e8:	fffff097          	auipc	ra,0xfffff
    8000e3ec:	22c080e7          	jalr	556(ra) # 8000d614 <_ZN9BufferCPP3getEv>
                i++;
    8000e3f0:	0019849b          	addiw	s1,s3,1
    8000e3f4:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    8000e3f8:	0ff57513          	andi	a0,a0,255
    8000e3fc:	00001097          	auipc	ra,0x1
    8000e400:	fb0080e7          	jalr	-80(ra) # 8000f3ac <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    8000e404:	05000793          	li	a5,80
    8000e408:	02f4e4bb          	remw	s1,s1,a5
    8000e40c:	fc0494e3          	bnez	s1,8000e3d4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    8000e410:	fb9ff06f          	j	8000e3c8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    8000e414:	01093783          	ld	a5,16(s2)
    8000e418:	0087b503          	ld	a0,8(a5)
    8000e41c:	fffff097          	auipc	ra,0xfffff
    8000e420:	1f8080e7          	jalr	504(ra) # 8000d614 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    8000e424:	0ff57513          	andi	a0,a0,255
    8000e428:	00001097          	auipc	ra,0x1
    8000e42c:	f84080e7          	jalr	-124(ra) # 8000f3ac <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    8000e430:	01093783          	ld	a5,16(s2)
    8000e434:	0087b503          	ld	a0,8(a5)
    8000e438:	fffff097          	auipc	ra,0xfffff
    8000e43c:	268080e7          	jalr	616(ra) # 8000d6a0 <_ZN9BufferCPP6getCntEv>
    8000e440:	fca04ae3          	bgtz	a0,8000e414 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    8000e444:	01093783          	ld	a5,16(s2)
    8000e448:	0107b503          	ld	a0,16(a5)
    8000e44c:	00001097          	auipc	ra,0x1
    8000e450:	d28080e7          	jalr	-728(ra) # 8000f174 <_ZN9Semaphore6signalEv>
        }
    8000e454:	02813083          	ld	ra,40(sp)
    8000e458:	02013403          	ld	s0,32(sp)
    8000e45c:	01813483          	ld	s1,24(sp)
    8000e460:	01013903          	ld	s2,16(sp)
    8000e464:	00813983          	ld	s3,8(sp)
    8000e468:	03010113          	addi	sp,sp,48
    8000e46c:	00008067          	ret

000000008000e470 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    8000e470:	ff010113          	addi	sp,sp,-16
    8000e474:	00113423          	sd	ra,8(sp)
    8000e478:	00813023          	sd	s0,0(sp)
    8000e47c:	01010413          	addi	s0,sp,16
    8000e480:	00002797          	auipc	a5,0x2
    8000e484:	e2078793          	addi	a5,a5,-480 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e488:	00f53023          	sd	a5,0(a0)
    8000e48c:	00001097          	auipc	ra,0x1
    8000e490:	b4c080e7          	jalr	-1204(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e494:	00813083          	ld	ra,8(sp)
    8000e498:	00013403          	ld	s0,0(sp)
    8000e49c:	01010113          	addi	sp,sp,16
    8000e4a0:	00008067          	ret

000000008000e4a4 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    8000e4a4:	fe010113          	addi	sp,sp,-32
    8000e4a8:	00113c23          	sd	ra,24(sp)
    8000e4ac:	00813823          	sd	s0,16(sp)
    8000e4b0:	00913423          	sd	s1,8(sp)
    8000e4b4:	02010413          	addi	s0,sp,32
    8000e4b8:	00050493          	mv	s1,a0
    8000e4bc:	00002797          	auipc	a5,0x2
    8000e4c0:	de478793          	addi	a5,a5,-540 # 800102a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000e4c4:	00f53023          	sd	a5,0(a0)
    8000e4c8:	00001097          	auipc	ra,0x1
    8000e4cc:	b10080e7          	jalr	-1264(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e4d0:	00048513          	mv	a0,s1
    8000e4d4:	00001097          	auipc	ra,0x1
    8000e4d8:	b94080e7          	jalr	-1132(ra) # 8000f068 <_ZdlPv>
    8000e4dc:	01813083          	ld	ra,24(sp)
    8000e4e0:	01013403          	ld	s0,16(sp)
    8000e4e4:	00813483          	ld	s1,8(sp)
    8000e4e8:	02010113          	addi	sp,sp,32
    8000e4ec:	00008067          	ret

000000008000e4f0 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    8000e4f0:	ff010113          	addi	sp,sp,-16
    8000e4f4:	00113423          	sd	ra,8(sp)
    8000e4f8:	00813023          	sd	s0,0(sp)
    8000e4fc:	01010413          	addi	s0,sp,16
    8000e500:	00002797          	auipc	a5,0x2
    8000e504:	d5078793          	addi	a5,a5,-688 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e508:	00f53023          	sd	a5,0(a0)
    8000e50c:	00001097          	auipc	ra,0x1
    8000e510:	acc080e7          	jalr	-1332(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e514:	00813083          	ld	ra,8(sp)
    8000e518:	00013403          	ld	s0,0(sp)
    8000e51c:	01010113          	addi	sp,sp,16
    8000e520:	00008067          	ret

000000008000e524 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    8000e524:	fe010113          	addi	sp,sp,-32
    8000e528:	00113c23          	sd	ra,24(sp)
    8000e52c:	00813823          	sd	s0,16(sp)
    8000e530:	00913423          	sd	s1,8(sp)
    8000e534:	02010413          	addi	s0,sp,32
    8000e538:	00050493          	mv	s1,a0
    8000e53c:	00002797          	auipc	a5,0x2
    8000e540:	d1478793          	addi	a5,a5,-748 # 80010250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000e544:	00f53023          	sd	a5,0(a0)
    8000e548:	00001097          	auipc	ra,0x1
    8000e54c:	a90080e7          	jalr	-1392(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e550:	00048513          	mv	a0,s1
    8000e554:	00001097          	auipc	ra,0x1
    8000e558:	b14080e7          	jalr	-1260(ra) # 8000f068 <_ZdlPv>
    8000e55c:	01813083          	ld	ra,24(sp)
    8000e560:	01013403          	ld	s0,16(sp)
    8000e564:	00813483          	ld	s1,8(sp)
    8000e568:	02010113          	addi	sp,sp,32
    8000e56c:	00008067          	ret

000000008000e570 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    8000e570:	ff010113          	addi	sp,sp,-16
    8000e574:	00113423          	sd	ra,8(sp)
    8000e578:	00813023          	sd	s0,0(sp)
    8000e57c:	01010413          	addi	s0,sp,16
    8000e580:	00002797          	auipc	a5,0x2
    8000e584:	cf878793          	addi	a5,a5,-776 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e588:	00f53023          	sd	a5,0(a0)
    8000e58c:	00001097          	auipc	ra,0x1
    8000e590:	a4c080e7          	jalr	-1460(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e594:	00813083          	ld	ra,8(sp)
    8000e598:	00013403          	ld	s0,0(sp)
    8000e59c:	01010113          	addi	sp,sp,16
    8000e5a0:	00008067          	ret

000000008000e5a4 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    8000e5a4:	fe010113          	addi	sp,sp,-32
    8000e5a8:	00113c23          	sd	ra,24(sp)
    8000e5ac:	00813823          	sd	s0,16(sp)
    8000e5b0:	00913423          	sd	s1,8(sp)
    8000e5b4:	02010413          	addi	s0,sp,32
    8000e5b8:	00050493          	mv	s1,a0
    8000e5bc:	00002797          	auipc	a5,0x2
    8000e5c0:	cbc78793          	addi	a5,a5,-836 # 80010278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000e5c4:	00f53023          	sd	a5,0(a0)
    8000e5c8:	00001097          	auipc	ra,0x1
    8000e5cc:	a10080e7          	jalr	-1520(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e5d0:	00048513          	mv	a0,s1
    8000e5d4:	00001097          	auipc	ra,0x1
    8000e5d8:	a94080e7          	jalr	-1388(ra) # 8000f068 <_ZdlPv>
    8000e5dc:	01813083          	ld	ra,24(sp)
    8000e5e0:	01013403          	ld	s0,16(sp)
    8000e5e4:	00813483          	ld	s1,8(sp)
    8000e5e8:	02010113          	addi	sp,sp,32
    8000e5ec:	00008067          	ret

000000008000e5f0 <_ZN10ForkThreadD1Ev>:
    8000e5f0:	ff010113          	addi	sp,sp,-16
    8000e5f4:	00113423          	sd	ra,8(sp)
    8000e5f8:	00813023          	sd	s0,0(sp)
    8000e5fc:	01010413          	addi	s0,sp,16
    8000e600:	00002797          	auipc	a5,0x2
    8000e604:	cc878793          	addi	a5,a5,-824 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e608:	00f53023          	sd	a5,0(a0)
    8000e60c:	00001097          	auipc	ra,0x1
    8000e610:	9cc080e7          	jalr	-1588(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e614:	00813083          	ld	ra,8(sp)
    8000e618:	00013403          	ld	s0,0(sp)
    8000e61c:	01010113          	addi	sp,sp,16
    8000e620:	00008067          	ret

000000008000e624 <_ZN10ForkThreadD0Ev>:
    8000e624:	fe010113          	addi	sp,sp,-32
    8000e628:	00113c23          	sd	ra,24(sp)
    8000e62c:	00813823          	sd	s0,16(sp)
    8000e630:	00913423          	sd	s1,8(sp)
    8000e634:	02010413          	addi	s0,sp,32
    8000e638:	00050493          	mv	s1,a0
    8000e63c:	00002797          	auipc	a5,0x2
    8000e640:	c8c78793          	addi	a5,a5,-884 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e644:	00f53023          	sd	a5,0(a0)
    8000e648:	00001097          	auipc	ra,0x1
    8000e64c:	990080e7          	jalr	-1648(ra) # 8000efd8 <_ZN6ThreadD1Ev>
    8000e650:	00048513          	mv	a0,s1
    8000e654:	00001097          	auipc	ra,0x1
    8000e658:	a14080e7          	jalr	-1516(ra) # 8000f068 <_ZdlPv>
    8000e65c:	01813083          	ld	ra,24(sp)
    8000e660:	01013403          	ld	s0,16(sp)
    8000e664:	00813483          	ld	s1,8(sp)
    8000e668:	02010113          	addi	sp,sp,32
    8000e66c:	00008067          	ret

000000008000e670 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    8000e670:	fe010113          	addi	sp,sp,-32
    8000e674:	00113c23          	sd	ra,24(sp)
    8000e678:	00813823          	sd	s0,16(sp)
    8000e67c:	00913423          	sd	s1,8(sp)
    8000e680:	02010413          	addi	s0,sp,32
    8000e684:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    8000e688:	fffff097          	auipc	ra,0xfffff
    8000e68c:	c7c080e7          	jalr	-900(ra) # 8000d304 <_Z4getcv>
    8000e690:	0005059b          	sext.w	a1,a0
    8000e694:	01b00793          	li	a5,27
    8000e698:	00f58c63          	beq	a1,a5,8000e6b0 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    8000e69c:	0104b783          	ld	a5,16(s1)
    8000e6a0:	0087b503          	ld	a0,8(a5)
    8000e6a4:	fffff097          	auipc	ra,0xfffff
    8000e6a8:	ee0080e7          	jalr	-288(ra) # 8000d584 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    8000e6ac:	fddff06f          	j	8000e688 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    8000e6b0:	00100793          	li	a5,1
    8000e6b4:	00002717          	auipc	a4,0x2
    8000e6b8:	ccf72023          	sw	a5,-832(a4) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    8000e6bc:	0104b783          	ld	a5,16(s1)
    8000e6c0:	02100593          	li	a1,33
    8000e6c4:	0087b503          	ld	a0,8(a5)
    8000e6c8:	fffff097          	auipc	ra,0xfffff
    8000e6cc:	ebc080e7          	jalr	-324(ra) # 8000d584 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    8000e6d0:	0104b783          	ld	a5,16(s1)
    8000e6d4:	0107b503          	ld	a0,16(a5)
    8000e6d8:	00001097          	auipc	ra,0x1
    8000e6dc:	a9c080e7          	jalr	-1380(ra) # 8000f174 <_ZN9Semaphore6signalEv>
        }
    8000e6e0:	01813083          	ld	ra,24(sp)
    8000e6e4:	01013403          	ld	s0,16(sp)
    8000e6e8:	00813483          	ld	s1,8(sp)
    8000e6ec:	02010113          	addi	sp,sp,32
    8000e6f0:	00008067          	ret

000000008000e6f4 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    8000e6f4:	fe010113          	addi	sp,sp,-32
    8000e6f8:	00113c23          	sd	ra,24(sp)
    8000e6fc:	00813823          	sd	s0,16(sp)
    8000e700:	00913423          	sd	s1,8(sp)
    8000e704:	01213023          	sd	s2,0(sp)
    8000e708:	02010413          	addi	s0,sp,32
    8000e70c:	00050493          	mv	s1,a0
            int i = 0;
    8000e710:	00000913          	li	s2,0
            while (!threadEnd) {
    8000e714:	00002797          	auipc	a5,0x2
    8000e718:	c607a783          	lw	a5,-928(a5) # 80010374 <_ZN19ConsumerProducerCPP9threadEndE>
    8000e71c:	04079263          	bnez	a5,8000e760 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8000e720:	0104b783          	ld	a5,16(s1)
    8000e724:	0007a583          	lw	a1,0(a5)
    8000e728:	0305859b          	addiw	a1,a1,48
    8000e72c:	0087b503          	ld	a0,8(a5)
    8000e730:	fffff097          	auipc	ra,0xfffff
    8000e734:	e54080e7          	jalr	-428(ra) # 8000d584 <_ZN9BufferCPP3putEi>
                i++;
    8000e738:	0019071b          	addiw	a4,s2,1
    8000e73c:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    8000e740:	0104b783          	ld	a5,16(s1)
    8000e744:	0007a783          	lw	a5,0(a5)
    8000e748:	00e787bb          	addw	a5,a5,a4
    8000e74c:	00500513          	li	a0,5
    8000e750:	02a7e53b          	remw	a0,a5,a0
    8000e754:	00001097          	auipc	ra,0x1
    8000e758:	b00080e7          	jalr	-1280(ra) # 8000f254 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    8000e75c:	fb9ff06f          	j	8000e714 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    8000e760:	0104b783          	ld	a5,16(s1)
    8000e764:	0107b503          	ld	a0,16(a5)
    8000e768:	00001097          	auipc	ra,0x1
    8000e76c:	a0c080e7          	jalr	-1524(ra) # 8000f174 <_ZN9Semaphore6signalEv>
        }
    8000e770:	01813083          	ld	ra,24(sp)
    8000e774:	01013403          	ld	s0,16(sp)
    8000e778:	00813483          	ld	s1,8(sp)
    8000e77c:	00013903          	ld	s2,0(sp)
    8000e780:	02010113          	addi	sp,sp,32
    8000e784:	00008067          	ret

000000008000e788 <_ZN10ForkThread3runEv>:
    virtual void run() {
    8000e788:	fc010113          	addi	sp,sp,-64
    8000e78c:	02113c23          	sd	ra,56(sp)
    8000e790:	02813823          	sd	s0,48(sp)
    8000e794:	02913423          	sd	s1,40(sp)
    8000e798:	03213023          	sd	s2,32(sp)
    8000e79c:	01313c23          	sd	s3,24(sp)
    8000e7a0:	01413823          	sd	s4,16(sp)
    8000e7a4:	01513423          	sd	s5,8(sp)
    8000e7a8:	01613023          	sd	s6,0(sp)
    8000e7ac:	04010413          	addi	s0,sp,64
    8000e7b0:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    8000e7b4:	00002517          	auipc	a0,0x2
    8000e7b8:	a5c50513          	addi	a0,a0,-1444 # 80010210 <userDataStart+0x210>
    8000e7bc:	00000097          	auipc	ra,0x0
    8000e7c0:	50c080e7          	jalr	1292(ra) # 8000ecc8 <_Z11printStringPKc>
        printInt(id,10);
    8000e7c4:	00000613          	li	a2,0
    8000e7c8:	00a00593          	li	a1,10
    8000e7cc:	010a2503          	lw	a0,16(s4)
    8000e7d0:	00000097          	auipc	ra,0x0
    8000e7d4:	690080e7          	jalr	1680(ra) # 8000ee60 <_Z8printIntiii>
        printString("\n");
    8000e7d8:	00002517          	auipc	a0,0x2
    8000e7dc:	97050513          	addi	a0,a0,-1680 # 80010148 <userDataStart+0x148>
    8000e7e0:	00000097          	auipc	ra,0x0
    8000e7e4:	4e8080e7          	jalr	1256(ra) # 8000ecc8 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    8000e7e8:	02000513          	li	a0,32
    8000e7ec:	00001097          	auipc	ra,0x1
    8000e7f0:	82c080e7          	jalr	-2004(ra) # 8000f018 <_Znwm>
    8000e7f4:	00050993          	mv	s3,a0
    8000e7f8:	02050463          	beqz	a0,8000e820 <_ZN10ForkThread3runEv+0x98>
    8000e7fc:	010a3483          	ld	s1,16(s4)
    8000e800:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e804:	00001097          	auipc	ra,0x1
    8000e808:	9f0080e7          	jalr	-1552(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e80c:	00002797          	auipc	a5,0x2
    8000e810:	abc78793          	addi	a5,a5,-1348 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e814:	00f9b023          	sd	a5,0(s3)
    8000e818:	0099b823          	sd	s1,16(s3)
    8000e81c:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    8000e820:	010a3503          	ld	a0,16(s4)
    8000e824:	00351513          	slli	a0,a0,0x3
    8000e828:	ffffe097          	auipc	ra,0xffffe
    8000e82c:	7f8080e7          	jalr	2040(ra) # 8000d020 <_Z9mem_allocm>
    8000e830:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    8000e834:	10050863          	beqz	a0,8000e944 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    8000e838:	00000913          	li	s2,0
    8000e83c:	0140006f          	j	8000e850 <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    8000e840:	00391793          	slli	a5,s2,0x3
    8000e844:	00fa87b3          	add	a5,s5,a5
    8000e848:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    8000e84c:	00190913          	addi	s2,s2,1
    8000e850:	010a3783          	ld	a5,16(s4)
    8000e854:	02f95e63          	bge	s2,a5,8000e890 <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    8000e858:	02000513          	li	a0,32
    8000e85c:	00000097          	auipc	ra,0x0
    8000e860:	7bc080e7          	jalr	1980(ra) # 8000f018 <_Znwm>
    8000e864:	00050493          	mv	s1,a0
    8000e868:	fc050ce3          	beqz	a0,8000e840 <_ZN10ForkThread3runEv+0xb8>
    8000e86c:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000e870:	00001097          	auipc	ra,0x1
    8000e874:	984080e7          	jalr	-1660(ra) # 8000f1f4 <_ZN6ThreadC1Ev>
    8000e878:	00002797          	auipc	a5,0x2
    8000e87c:	a5078793          	addi	a5,a5,-1456 # 800102c8 <_ZTV10ForkThread+0x10>
    8000e880:	00f4b023          	sd	a5,0(s1)
    8000e884:	0164b823          	sd	s6,16(s1)
    8000e888:	00048c23          	sb	zero,24(s1)
    8000e88c:	fb5ff06f          	j	8000e840 <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    8000e890:	06098a63          	beqz	s3,8000e904 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    8000e894:	00098513          	mv	a0,s3
    8000e898:	00001097          	auipc	ra,0x1
    8000e89c:	a4c080e7          	jalr	-1460(ra) # 8000f2e4 <_ZN6Thread5startEv>
    8000e8a0:	00050913          	mv	s2,a0
    8000e8a4:	04051863          	bnez	a0,8000e8f4 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    8000e8a8:	00050493          	mv	s1,a0
    8000e8ac:	0100006f          	j	8000e8bc <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    8000e8b0:	fffff097          	auipc	ra,0xfffff
    8000e8b4:	880080e7          	jalr	-1920(ra) # 8000d130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    8000e8b8:	0014849b          	addiw	s1,s1,1
    8000e8bc:	000017b7          	lui	a5,0x1
    8000e8c0:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e8c4:	0097ce63          	blt	a5,s1,8000e8e0 <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    8000e8c8:	00090713          	mv	a4,s2
    8000e8cc:	000017b7          	lui	a5,0x1
    8000e8d0:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000e8d4:	fce7cee3          	blt	a5,a4,8000e8b0 <_ZN10ForkThread3runEv+0x128>
    8000e8d8:	0017071b          	addiw	a4,a4,1
    8000e8dc:	ff1ff06f          	j	8000e8cc <_ZN10ForkThread3runEv+0x144>
        return finished;
    8000e8e0:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    8000e8e4:	00079863          	bnez	a5,8000e8f4 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    8000e8e8:	fffff097          	auipc	ra,0xfffff
    8000e8ec:	848080e7          	jalr	-1976(ra) # 8000d130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8000e8f0:	ff1ff06f          	j	8000e8e0 <_ZN10ForkThread3runEv+0x158>
                delete thread;
    8000e8f4:	0009b783          	ld	a5,0(s3)
    8000e8f8:	0087b783          	ld	a5,8(a5)
    8000e8fc:	00098513          	mv	a0,s3
    8000e900:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    8000e904:	00000493          	li	s1,0
    8000e908:	0080006f          	j	8000e910 <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    8000e90c:	00148493          	addi	s1,s1,1
    8000e910:	010a3783          	ld	a5,16(s4)
    8000e914:	02f4d263          	bge	s1,a5,8000e938 <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    8000e918:	00349793          	slli	a5,s1,0x3
    8000e91c:	00fa87b3          	add	a5,s5,a5
    8000e920:	0007b503          	ld	a0,0(a5)
    8000e924:	fe0504e3          	beqz	a0,8000e90c <_ZN10ForkThread3runEv+0x184>
    8000e928:	00053783          	ld	a5,0(a0)
    8000e92c:	0087b783          	ld	a5,8(a5)
    8000e930:	000780e7          	jalr	a5
    8000e934:	fd9ff06f          	j	8000e90c <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    8000e938:	000a8513          	mv	a0,s5
    8000e93c:	ffffe097          	auipc	ra,0xffffe
    8000e940:	714080e7          	jalr	1812(ra) # 8000d050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    8000e944:	00002517          	auipc	a0,0x2
    8000e948:	8e450513          	addi	a0,a0,-1820 # 80010228 <userDataStart+0x228>
    8000e94c:	00000097          	auipc	ra,0x0
    8000e950:	37c080e7          	jalr	892(ra) # 8000ecc8 <_Z11printStringPKc>
        printInt(id,10);
    8000e954:	00000613          	li	a2,0
    8000e958:	00a00593          	li	a1,10
    8000e95c:	010a2503          	lw	a0,16(s4)
    8000e960:	00000097          	auipc	ra,0x0
    8000e964:	500080e7          	jalr	1280(ra) # 8000ee60 <_Z8printIntiii>
        printString("\n");
    8000e968:	00001517          	auipc	a0,0x1
    8000e96c:	7e050513          	addi	a0,a0,2016 # 80010148 <userDataStart+0x148>
    8000e970:	00000097          	auipc	ra,0x0
    8000e974:	358080e7          	jalr	856(ra) # 8000ecc8 <_Z11printStringPKc>
        finished = true;
    8000e978:	00100793          	li	a5,1
    8000e97c:	00fa0c23          	sb	a5,24(s4)
    }
    8000e980:	03813083          	ld	ra,56(sp)
    8000e984:	03013403          	ld	s0,48(sp)
    8000e988:	02813483          	ld	s1,40(sp)
    8000e98c:	02013903          	ld	s2,32(sp)
    8000e990:	01813983          	ld	s3,24(sp)
    8000e994:	01013a03          	ld	s4,16(sp)
    8000e998:	00813a83          	ld	s5,8(sp)
    8000e99c:	00013b03          	ld	s6,0(sp)
    8000e9a0:	04010113          	addi	sp,sp,64
    8000e9a4:	00008067          	ret

000000008000e9a8 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000e9a8:	fe010113          	addi	sp,sp,-32
    8000e9ac:	00113c23          	sd	ra,24(sp)
    8000e9b0:	00813823          	sd	s0,16(sp)
    8000e9b4:	00913423          	sd	s1,8(sp)
    8000e9b8:	01213023          	sd	s2,0(sp)
    8000e9bc:	02010413          	addi	s0,sp,32
    8000e9c0:	00050493          	mv	s1,a0
    8000e9c4:	00058913          	mv	s2,a1
    8000e9c8:	0015879b          	addiw	a5,a1,1
    8000e9cc:	0007851b          	sext.w	a0,a5
    8000e9d0:	00f4a023          	sw	a5,0(s1)
    8000e9d4:	0004a823          	sw	zero,16(s1)
    8000e9d8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000e9dc:	00251513          	slli	a0,a0,0x2
    8000e9e0:	ffffe097          	auipc	ra,0xffffe
    8000e9e4:	640080e7          	jalr	1600(ra) # 8000d020 <_Z9mem_allocm>
    8000e9e8:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000e9ec:	00000593          	li	a1,0
    8000e9f0:	02048513          	addi	a0,s1,32
    8000e9f4:	fffff097          	auipc	ra,0xfffff
    8000e9f8:	828080e7          	jalr	-2008(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    8000e9fc:	00090593          	mv	a1,s2
    8000ea00:	01848513          	addi	a0,s1,24
    8000ea04:	fffff097          	auipc	ra,0xfffff
    8000ea08:	818080e7          	jalr	-2024(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    8000ea0c:	00100593          	li	a1,1
    8000ea10:	02848513          	addi	a0,s1,40
    8000ea14:	fffff097          	auipc	ra,0xfffff
    8000ea18:	808080e7          	jalr	-2040(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    8000ea1c:	00100593          	li	a1,1
    8000ea20:	03048513          	addi	a0,s1,48
    8000ea24:	ffffe097          	auipc	ra,0xffffe
    8000ea28:	7f8080e7          	jalr	2040(ra) # 8000d21c <_Z8sem_openPP10_semaphorej>
}
    8000ea2c:	01813083          	ld	ra,24(sp)
    8000ea30:	01013403          	ld	s0,16(sp)
    8000ea34:	00813483          	ld	s1,8(sp)
    8000ea38:	00013903          	ld	s2,0(sp)
    8000ea3c:	02010113          	addi	sp,sp,32
    8000ea40:	00008067          	ret

000000008000ea44 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000ea44:	fe010113          	addi	sp,sp,-32
    8000ea48:	00113c23          	sd	ra,24(sp)
    8000ea4c:	00813823          	sd	s0,16(sp)
    8000ea50:	00913423          	sd	s1,8(sp)
    8000ea54:	01213023          	sd	s2,0(sp)
    8000ea58:	02010413          	addi	s0,sp,32
    8000ea5c:	00050493          	mv	s1,a0
    8000ea60:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000ea64:	01853503          	ld	a0,24(a0)
    8000ea68:	fffff097          	auipc	ra,0xfffff
    8000ea6c:	818080e7          	jalr	-2024(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    8000ea70:	0304b503          	ld	a0,48(s1)
    8000ea74:	fffff097          	auipc	ra,0xfffff
    8000ea78:	80c080e7          	jalr	-2036(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    8000ea7c:	0084b783          	ld	a5,8(s1)
    8000ea80:	0144a703          	lw	a4,20(s1)
    8000ea84:	00271713          	slli	a4,a4,0x2
    8000ea88:	00e787b3          	add	a5,a5,a4
    8000ea8c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000ea90:	0144a783          	lw	a5,20(s1)
    8000ea94:	0017879b          	addiw	a5,a5,1
    8000ea98:	0004a703          	lw	a4,0(s1)
    8000ea9c:	02e7e7bb          	remw	a5,a5,a4
    8000eaa0:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    8000eaa4:	0304b503          	ld	a0,48(s1)
    8000eaa8:	fffff097          	auipc	ra,0xfffff
    8000eaac:	804080e7          	jalr	-2044(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    8000eab0:	0204b503          	ld	a0,32(s1)
    8000eab4:	ffffe097          	auipc	ra,0xffffe
    8000eab8:	7f8080e7          	jalr	2040(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

}
    8000eabc:	01813083          	ld	ra,24(sp)
    8000eac0:	01013403          	ld	s0,16(sp)
    8000eac4:	00813483          	ld	s1,8(sp)
    8000eac8:	00013903          	ld	s2,0(sp)
    8000eacc:	02010113          	addi	sp,sp,32
    8000ead0:	00008067          	ret

000000008000ead4 <_ZN6Buffer3getEv>:

int Buffer::get() {
    8000ead4:	fe010113          	addi	sp,sp,-32
    8000ead8:	00113c23          	sd	ra,24(sp)
    8000eadc:	00813823          	sd	s0,16(sp)
    8000eae0:	00913423          	sd	s1,8(sp)
    8000eae4:	01213023          	sd	s2,0(sp)
    8000eae8:	02010413          	addi	s0,sp,32
    8000eaec:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8000eaf0:	02053503          	ld	a0,32(a0)
    8000eaf4:	ffffe097          	auipc	ra,0xffffe
    8000eaf8:	78c080e7          	jalr	1932(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    8000eafc:	0284b503          	ld	a0,40(s1)
    8000eb00:	ffffe097          	auipc	ra,0xffffe
    8000eb04:	780080e7          	jalr	1920(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8000eb08:	0084b703          	ld	a4,8(s1)
    8000eb0c:	0104a783          	lw	a5,16(s1)
    8000eb10:	00279693          	slli	a3,a5,0x2
    8000eb14:	00d70733          	add	a4,a4,a3
    8000eb18:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000eb1c:	0017879b          	addiw	a5,a5,1
    8000eb20:	0004a703          	lw	a4,0(s1)
    8000eb24:	02e7e7bb          	remw	a5,a5,a4
    8000eb28:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000eb2c:	0284b503          	ld	a0,40(s1)
    8000eb30:	ffffe097          	auipc	ra,0xffffe
    8000eb34:	77c080e7          	jalr	1916(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    8000eb38:	0184b503          	ld	a0,24(s1)
    8000eb3c:	ffffe097          	auipc	ra,0xffffe
    8000eb40:	770080e7          	jalr	1904(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000eb44:	00090513          	mv	a0,s2
    8000eb48:	01813083          	ld	ra,24(sp)
    8000eb4c:	01013403          	ld	s0,16(sp)
    8000eb50:	00813483          	ld	s1,8(sp)
    8000eb54:	00013903          	ld	s2,0(sp)
    8000eb58:	02010113          	addi	sp,sp,32
    8000eb5c:	00008067          	ret

000000008000eb60 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000eb60:	fe010113          	addi	sp,sp,-32
    8000eb64:	00113c23          	sd	ra,24(sp)
    8000eb68:	00813823          	sd	s0,16(sp)
    8000eb6c:	00913423          	sd	s1,8(sp)
    8000eb70:	01213023          	sd	s2,0(sp)
    8000eb74:	02010413          	addi	s0,sp,32
    8000eb78:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    8000eb7c:	02853503          	ld	a0,40(a0)
    8000eb80:	ffffe097          	auipc	ra,0xffffe
    8000eb84:	700080e7          	jalr	1792(ra) # 8000d280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    8000eb88:	0304b503          	ld	a0,48(s1)
    8000eb8c:	ffffe097          	auipc	ra,0xffffe
    8000eb90:	6f4080e7          	jalr	1780(ra) # 8000d280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    8000eb94:	0144a783          	lw	a5,20(s1)
    8000eb98:	0104a903          	lw	s2,16(s1)
    8000eb9c:	0327ce63          	blt	a5,s2,8000ebd8 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000eba0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    8000eba4:	0304b503          	ld	a0,48(s1)
    8000eba8:	ffffe097          	auipc	ra,0xffffe
    8000ebac:	704080e7          	jalr	1796(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8000ebb0:	0284b503          	ld	a0,40(s1)
    8000ebb4:	ffffe097          	auipc	ra,0xffffe
    8000ebb8:	6f8080e7          	jalr	1784(ra) # 8000d2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000ebbc:	00090513          	mv	a0,s2
    8000ebc0:	01813083          	ld	ra,24(sp)
    8000ebc4:	01013403          	ld	s0,16(sp)
    8000ebc8:	00813483          	ld	s1,8(sp)
    8000ebcc:	00013903          	ld	s2,0(sp)
    8000ebd0:	02010113          	addi	sp,sp,32
    8000ebd4:	00008067          	ret
        ret = cap - head + tail;
    8000ebd8:	0004a703          	lw	a4,0(s1)
    8000ebdc:	4127093b          	subw	s2,a4,s2
    8000ebe0:	00f9093b          	addw	s2,s2,a5
    8000ebe4:	fc1ff06f          	j	8000eba4 <_ZN6Buffer6getCntEv+0x44>

000000008000ebe8 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000ebe8:	fe010113          	addi	sp,sp,-32
    8000ebec:	00113c23          	sd	ra,24(sp)
    8000ebf0:	00813823          	sd	s0,16(sp)
    8000ebf4:	00913423          	sd	s1,8(sp)
    8000ebf8:	02010413          	addi	s0,sp,32
    8000ebfc:	00050493          	mv	s1,a0
    putc('\n');
    8000ec00:	00a00513          	li	a0,10
    8000ec04:	ffffe097          	auipc	ra,0xffffe
    8000ec08:	728080e7          	jalr	1832(ra) # 8000d32c <_Z4putcc>
    printString("Buffer deleted!\n");
    8000ec0c:	00001517          	auipc	a0,0x1
    8000ec10:	3f450513          	addi	a0,a0,1012 # 80010000 <userDataStart>
    8000ec14:	00000097          	auipc	ra,0x0
    8000ec18:	0b4080e7          	jalr	180(ra) # 8000ecc8 <_Z11printStringPKc>
    while (getCnt() > 0) {
    8000ec1c:	00048513          	mv	a0,s1
    8000ec20:	00000097          	auipc	ra,0x0
    8000ec24:	f40080e7          	jalr	-192(ra) # 8000eb60 <_ZN6Buffer6getCntEv>
    8000ec28:	02a05c63          	blez	a0,8000ec60 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    8000ec2c:	0084b783          	ld	a5,8(s1)
    8000ec30:	0104a703          	lw	a4,16(s1)
    8000ec34:	00271713          	slli	a4,a4,0x2
    8000ec38:	00e787b3          	add	a5,a5,a4
        putc(ch);
    8000ec3c:	0007c503          	lbu	a0,0(a5)
    8000ec40:	ffffe097          	auipc	ra,0xffffe
    8000ec44:	6ec080e7          	jalr	1772(ra) # 8000d32c <_Z4putcc>
        head = (head + 1) % cap;
    8000ec48:	0104a783          	lw	a5,16(s1)
    8000ec4c:	0017879b          	addiw	a5,a5,1
    8000ec50:	0004a703          	lw	a4,0(s1)
    8000ec54:	02e7e7bb          	remw	a5,a5,a4
    8000ec58:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    8000ec5c:	fc1ff06f          	j	8000ec1c <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000ec60:	02100513          	li	a0,33
    8000ec64:	ffffe097          	auipc	ra,0xffffe
    8000ec68:	6c8080e7          	jalr	1736(ra) # 8000d32c <_Z4putcc>
    putc('\n');
    8000ec6c:	00a00513          	li	a0,10
    8000ec70:	ffffe097          	auipc	ra,0xffffe
    8000ec74:	6bc080e7          	jalr	1724(ra) # 8000d32c <_Z4putcc>
    mem_free(buffer);
    8000ec78:	0084b503          	ld	a0,8(s1)
    8000ec7c:	ffffe097          	auipc	ra,0xffffe
    8000ec80:	3d4080e7          	jalr	980(ra) # 8000d050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    8000ec84:	0204b503          	ld	a0,32(s1)
    8000ec88:	ffffe097          	auipc	ra,0xffffe
    8000ec8c:	5cc080e7          	jalr	1484(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    8000ec90:	0184b503          	ld	a0,24(s1)
    8000ec94:	ffffe097          	auipc	ra,0xffffe
    8000ec98:	5c0080e7          	jalr	1472(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    8000ec9c:	0304b503          	ld	a0,48(s1)
    8000eca0:	ffffe097          	auipc	ra,0xffffe
    8000eca4:	5b4080e7          	jalr	1460(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    8000eca8:	0284b503          	ld	a0,40(s1)
    8000ecac:	ffffe097          	auipc	ra,0xffffe
    8000ecb0:	5a8080e7          	jalr	1448(ra) # 8000d254 <_Z9sem_closeP10_semaphore>
}
    8000ecb4:	01813083          	ld	ra,24(sp)
    8000ecb8:	01013403          	ld	s0,16(sp)
    8000ecbc:	00813483          	ld	s1,8(sp)
    8000ecc0:	02010113          	addi	sp,sp,32
    8000ecc4:	00008067          	ret

000000008000ecc8 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000ecc8:	fe010113          	addi	sp,sp,-32
    8000eccc:	00113c23          	sd	ra,24(sp)
    8000ecd0:	00813823          	sd	s0,16(sp)
    8000ecd4:	00913423          	sd	s1,8(sp)
    8000ecd8:	02010413          	addi	s0,sp,32
    8000ecdc:	00050493          	mv	s1,a0
    LOCK();
    8000ece0:	00100613          	li	a2,1
    8000ece4:	00000593          	li	a1,0
    8000ece8:	00001517          	auipc	a0,0x1
    8000ecec:	6a050513          	addi	a0,a0,1696 # 80010388 <lockPrint>
    8000ecf0:	ffffe097          	auipc	ra,0xffffe
    8000ecf4:	310080e7          	jalr	784(ra) # 8000d000 <copy_and_swap>
    8000ecf8:	fe0514e3          	bnez	a0,8000ece0 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000ecfc:	0004c503          	lbu	a0,0(s1)
    8000ed00:	00050a63          	beqz	a0,8000ed14 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000ed04:	ffffe097          	auipc	ra,0xffffe
    8000ed08:	628080e7          	jalr	1576(ra) # 8000d32c <_Z4putcc>
        string++;
    8000ed0c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000ed10:	fedff06f          	j	8000ecfc <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000ed14:	00000613          	li	a2,0
    8000ed18:	00100593          	li	a1,1
    8000ed1c:	00001517          	auipc	a0,0x1
    8000ed20:	66c50513          	addi	a0,a0,1644 # 80010388 <lockPrint>
    8000ed24:	ffffe097          	auipc	ra,0xffffe
    8000ed28:	2dc080e7          	jalr	732(ra) # 8000d000 <copy_and_swap>
    8000ed2c:	fe0514e3          	bnez	a0,8000ed14 <_Z11printStringPKc+0x4c>
}
    8000ed30:	01813083          	ld	ra,24(sp)
    8000ed34:	01013403          	ld	s0,16(sp)
    8000ed38:	00813483          	ld	s1,8(sp)
    8000ed3c:	02010113          	addi	sp,sp,32
    8000ed40:	00008067          	ret

000000008000ed44 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    8000ed44:	fd010113          	addi	sp,sp,-48
    8000ed48:	02113423          	sd	ra,40(sp)
    8000ed4c:	02813023          	sd	s0,32(sp)
    8000ed50:	00913c23          	sd	s1,24(sp)
    8000ed54:	01213823          	sd	s2,16(sp)
    8000ed58:	01313423          	sd	s3,8(sp)
    8000ed5c:	01413023          	sd	s4,0(sp)
    8000ed60:	03010413          	addi	s0,sp,48
    8000ed64:	00050993          	mv	s3,a0
    8000ed68:	00058a13          	mv	s4,a1
    LOCK();
    8000ed6c:	00100613          	li	a2,1
    8000ed70:	00000593          	li	a1,0
    8000ed74:	00001517          	auipc	a0,0x1
    8000ed78:	61450513          	addi	a0,a0,1556 # 80010388 <lockPrint>
    8000ed7c:	ffffe097          	auipc	ra,0xffffe
    8000ed80:	284080e7          	jalr	644(ra) # 8000d000 <copy_and_swap>
    8000ed84:	fe0514e3          	bnez	a0,8000ed6c <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000ed88:	00000913          	li	s2,0
    8000ed8c:	00090493          	mv	s1,s2
    8000ed90:	0019091b          	addiw	s2,s2,1
    8000ed94:	03495a63          	bge	s2,s4,8000edc8 <_Z9getStringPci+0x84>
        cc = getc();
    8000ed98:	ffffe097          	auipc	ra,0xffffe
    8000ed9c:	56c080e7          	jalr	1388(ra) # 8000d304 <_Z4getcv>
        if(cc < 1)
    8000eda0:	02050463          	beqz	a0,8000edc8 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000eda4:	009984b3          	add	s1,s3,s1
    8000eda8:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000edac:	00a00793          	li	a5,10
    8000edb0:	00f50a63          	beq	a0,a5,8000edc4 <_Z9getStringPci+0x80>
    8000edb4:	00d00793          	li	a5,13
    8000edb8:	fcf51ae3          	bne	a0,a5,8000ed8c <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000edbc:	00090493          	mv	s1,s2
    8000edc0:	0080006f          	j	8000edc8 <_Z9getStringPci+0x84>
    8000edc4:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    8000edc8:	009984b3          	add	s1,s3,s1
    8000edcc:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000edd0:	00000613          	li	a2,0
    8000edd4:	00100593          	li	a1,1
    8000edd8:	00001517          	auipc	a0,0x1
    8000eddc:	5b050513          	addi	a0,a0,1456 # 80010388 <lockPrint>
    8000ede0:	ffffe097          	auipc	ra,0xffffe
    8000ede4:	220080e7          	jalr	544(ra) # 8000d000 <copy_and_swap>
    8000ede8:	fe0514e3          	bnez	a0,8000edd0 <_Z9getStringPci+0x8c>
    return buf;
}
    8000edec:	00098513          	mv	a0,s3
    8000edf0:	02813083          	ld	ra,40(sp)
    8000edf4:	02013403          	ld	s0,32(sp)
    8000edf8:	01813483          	ld	s1,24(sp)
    8000edfc:	01013903          	ld	s2,16(sp)
    8000ee00:	00813983          	ld	s3,8(sp)
    8000ee04:	00013a03          	ld	s4,0(sp)
    8000ee08:	03010113          	addi	sp,sp,48
    8000ee0c:	00008067          	ret

000000008000ee10 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000ee10:	ff010113          	addi	sp,sp,-16
    8000ee14:	00813423          	sd	s0,8(sp)
    8000ee18:	01010413          	addi	s0,sp,16
    8000ee1c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000ee20:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000ee24:	0006c603          	lbu	a2,0(a3)
    8000ee28:	fd06071b          	addiw	a4,a2,-48
    8000ee2c:	0ff77713          	andi	a4,a4,255
    8000ee30:	00900793          	li	a5,9
    8000ee34:	02e7e063          	bltu	a5,a4,8000ee54 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000ee38:	0025179b          	slliw	a5,a0,0x2
    8000ee3c:	00a787bb          	addw	a5,a5,a0
    8000ee40:	0017979b          	slliw	a5,a5,0x1
    8000ee44:	00168693          	addi	a3,a3,1
    8000ee48:	00c787bb          	addw	a5,a5,a2
    8000ee4c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000ee50:	fd5ff06f          	j	8000ee24 <_Z11stringToIntPKc+0x14>
    return n;
}
    8000ee54:	00813403          	ld	s0,8(sp)
    8000ee58:	01010113          	addi	sp,sp,16
    8000ee5c:	00008067          	ret

000000008000ee60 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000ee60:	fc010113          	addi	sp,sp,-64
    8000ee64:	02113c23          	sd	ra,56(sp)
    8000ee68:	02813823          	sd	s0,48(sp)
    8000ee6c:	02913423          	sd	s1,40(sp)
    8000ee70:	03213023          	sd	s2,32(sp)
    8000ee74:	01313c23          	sd	s3,24(sp)
    8000ee78:	04010413          	addi	s0,sp,64
    8000ee7c:	00050493          	mv	s1,a0
    8000ee80:	00058913          	mv	s2,a1
    8000ee84:	00060993          	mv	s3,a2
    LOCK();
    8000ee88:	00100613          	li	a2,1
    8000ee8c:	00000593          	li	a1,0
    8000ee90:	00001517          	auipc	a0,0x1
    8000ee94:	4f850513          	addi	a0,a0,1272 # 80010388 <lockPrint>
    8000ee98:	ffffe097          	auipc	ra,0xffffe
    8000ee9c:	168080e7          	jalr	360(ra) # 8000d000 <copy_and_swap>
    8000eea0:	fe0514e3          	bnez	a0,8000ee88 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000eea4:	00098463          	beqz	s3,8000eeac <_Z8printIntiii+0x4c>
    8000eea8:	0804c463          	bltz	s1,8000ef30 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000eeac:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000eeb0:	00000593          	li	a1,0
    }

    i = 0;
    8000eeb4:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000eeb8:	0009079b          	sext.w	a5,s2
    8000eebc:	0325773b          	remuw	a4,a0,s2
    8000eec0:	00048613          	mv	a2,s1
    8000eec4:	0014849b          	addiw	s1,s1,1
    8000eec8:	02071693          	slli	a3,a4,0x20
    8000eecc:	0206d693          	srli	a3,a3,0x20
    8000eed0:	00001717          	auipc	a4,0x1
    8000eed4:	41070713          	addi	a4,a4,1040 # 800102e0 <digits>
    8000eed8:	00d70733          	add	a4,a4,a3
    8000eedc:	00074683          	lbu	a3,0(a4)
    8000eee0:	fd040713          	addi	a4,s0,-48
    8000eee4:	00c70733          	add	a4,a4,a2
    8000eee8:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    8000eeec:	0005071b          	sext.w	a4,a0
    8000eef0:	0325553b          	divuw	a0,a0,s2
    8000eef4:	fcf772e3          	bgeu	a4,a5,8000eeb8 <_Z8printIntiii+0x58>
    if(neg)
    8000eef8:	00058c63          	beqz	a1,8000ef10 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    8000eefc:	fd040793          	addi	a5,s0,-48
    8000ef00:	009784b3          	add	s1,a5,s1
    8000ef04:	02d00793          	li	a5,45
    8000ef08:	fef48823          	sb	a5,-16(s1)
    8000ef0c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000ef10:	fff4849b          	addiw	s1,s1,-1
    8000ef14:	0204c463          	bltz	s1,8000ef3c <_Z8printIntiii+0xdc>
        putc(buf[i]);
    8000ef18:	fd040793          	addi	a5,s0,-48
    8000ef1c:	009787b3          	add	a5,a5,s1
    8000ef20:	ff07c503          	lbu	a0,-16(a5)
    8000ef24:	ffffe097          	auipc	ra,0xffffe
    8000ef28:	408080e7          	jalr	1032(ra) # 8000d32c <_Z4putcc>
    8000ef2c:	fe5ff06f          	j	8000ef10 <_Z8printIntiii+0xb0>
        x = -xx;
    8000ef30:	4090053b          	negw	a0,s1
        neg = 1;
    8000ef34:	00100593          	li	a1,1
        x = -xx;
    8000ef38:	f7dff06f          	j	8000eeb4 <_Z8printIntiii+0x54>

    UNLOCK();
    8000ef3c:	00000613          	li	a2,0
    8000ef40:	00100593          	li	a1,1
    8000ef44:	00001517          	auipc	a0,0x1
    8000ef48:	44450513          	addi	a0,a0,1092 # 80010388 <lockPrint>
    8000ef4c:	ffffe097          	auipc	ra,0xffffe
    8000ef50:	0b4080e7          	jalr	180(ra) # 8000d000 <copy_and_swap>
    8000ef54:	fe0514e3          	bnez	a0,8000ef3c <_Z8printIntiii+0xdc>
    8000ef58:	03813083          	ld	ra,56(sp)
    8000ef5c:	03013403          	ld	s0,48(sp)
    8000ef60:	02813483          	ld	s1,40(sp)
    8000ef64:	02013903          	ld	s2,32(sp)
    8000ef68:	01813983          	ld	s3,24(sp)
    8000ef6c:	04010113          	addi	sp,sp,64
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
    80010250:	e4f0 8000 0000 0000 e524 8000 0000 0000     ........$.......
    80010260:	e670 8000 0000 0000                         p.......

0000000080010268 <_ZTVN19ConsumerProducerCPP8ProducerE>:
	...
    80010278:	e570 8000 0000 0000 e5a4 8000 0000 0000     p...............
    80010288:	e6f4 8000 0000 0000                         ........

0000000080010290 <_ZTVN19ConsumerProducerCPP8ConsumerE>:
	...
    800102a0:	e470 8000 0000 0000 e4a4 8000 0000 0000     p...............
    800102b0:	e3a0 8000 0000 0000                         ........

00000000800102b8 <_ZTV10ForkThread>:
	...
    800102c8:	e5f0 8000 0000 0000 e624 8000 0000 0000     ........$.......
    800102d8:	e788 8000 0000 0000                         ........

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
