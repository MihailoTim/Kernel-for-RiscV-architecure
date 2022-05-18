//
// Created by os on 5/17/22.
//

#include "../h/tests.hpp"


//Utility::printMemTrace() can be used to show free and allocated memory lists

void mallocTest(){
    Utility::printString("Testing a few mallocs and frees\n\n");

    object* o = new object;
    o->a = 3;
    void* m1 = mem_alloc(10);
    void* m2 = mem_alloc(100);
    void* m3 = mem_alloc(1000);
    void* m4 = mem_alloc(10000);
    void* m5 = mem_alloc(1);

    if(!m1 || !m2 || !m3 || !m4 || !m5){
        Utility::printString("not OK\n");
        return;
    }

    delete (uint64*)m1;
    delete (uint64*)m3;
    delete (uint64*)m4;
    delete (uint64*)m2;
    delete (uint64*)m5;
    delete o;

    Utility::printString("SUCCESSFUL: Testing a few mallocs and frees\n\n");
}

void mallocEverything(){
    Utility::printString("Testing allocating whole address space\n\n");

    uint64 neg_size = (uint64)HEAP_START_ADDR - (uint64)HEAP_END_ADDR -sizeof(MemoryAllocator::BlockHeader);

    void* m = mem_alloc(neg_size);

    if(m!=nullptr){
        Utility::printString("not OK\n");
        return;
    }

    uint64 blockSize = (((uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR - sizeof(MemoryAllocator::BlockHeader))>>6)-300;

    m = mem_alloc(blockSize<<6);

    if(m==nullptr){
        Utility::printString("not OK\n");
        return;
    }

//    there should be some space left still, depending on source file size and output buffer size
//    excess allocation should fail and small_chunk should succeed

//    void *excess = mem_alloc(100);
//
//    if(excess!=nullptr){
//        Utility::printString("not OK\n");
//        return;
//    }
//
    void *small_chunk = mem_alloc(1);

    if(small_chunk == nullptr){
        Utility::printString("not OK\n");
        return;
    }

    delete (uint64*)m;
    //delete (uint64*)small_chunk;

    Utility::printString("SUCCESSFUL: Testing allocating whole address space\n\n");
}

void mallocGapFillTest(){
    Utility::printString("Testing gap filling and chunk merge after multiple mallocs and frees\n\n");

    const int N = 10;

    void *m[N];

    for(int i=0;i<N;i++)
    {
        m[i] = mem_alloc((i<<6)+1);
        if(m[i] == nullptr){
            Utility::printString("not OK\n");
            return;
        }
    }

    delete (uint64*)m[2];

    void* tmp1 = mem_alloc(1);
    void* tmp2 = mem_alloc(1);
    void* tmp3 = mem_alloc(1);

    if(!tmp1 || !tmp2 || !tmp3)
    {
        Utility::printString("not OK\n");
        return;
    }

    uint64 im1 = (uint64)m[1];
    uint64 im3 = (uint64)m[3];
    uint64 im5 = (uint64)m[5];
    uint64 imN = (uint64)m[N];

    uint64 itmp1 = (uint64)tmp1;
    uint64 itmp2 = (uint64)tmp2;
    uint64 itmp3 = (uint64)tmp3;

    if(!(im1<itmp1 && itmp1<im3 && im1<itmp2 && itmp2<im3 && itmp3>imN))
    {
        Utility::printString("not OK\n");
        return;
    }

    delete (uint64*)m[3];
    delete (uint64*)m[4];

    void* tmp4 = mem_alloc(640);
    void* tmp5 = mem_alloc(576);

    if(!tmp4 || !tmp5){
        Utility::printString("not OK\n");
        return;
    }

    uint64 itmp4 = (uint64)tmp4;
    uint64 itmp5 = (uint64)tmp5;

    if(!(itmp5>itmp2 && itmp5<im5 && itmp4>itmp3)){
        Utility::printString("not OK\n");
        return;
    }

    for(int i=0;i<N;i++){
        delete (uint64*)m[i];
    }

    delete (uint64*)tmp1;
    delete (uint64*)tmp2;
    delete (uint64*)tmp3;
    delete (uint64*)tmp4;
    delete (uint64*)tmp5;

    Utility::printString("SUCCESSFUL: Testing gap filling and chunk merge after multiple mallocs and frees\n\n");
}

void badFree(){
    Utility::printString("Testing deletion of a invalid pointer\n\n");

    char *p = nullptr;
    int status = mem_free(p);
    if(status == 0) {
        Utility::printString("not OK\n");
    }

    Utility::printString("SUCCESSFUL: Testing deletion of a invalid pointer\n\n");
}
