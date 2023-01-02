////
//// Created by os on 1/2/23.
////
//
//#ifndef KERNEL_FOR_RISCV_ARCHITECURE_BUDDYTEST_HPP
//#define KERNEL_FOR_RISCV_ARCHITECURE_BUDDYTEST_HPP
//
//#endif //KERNEL_FOR_RISCV_ARCHITECURE_BUDDYTEST_HPP
//bool error = false;
//
//void *mem[2048];
//for(int i=0;i<2048;i++){
//mem[i] = Buddy::alloc(0);
//if(!mem[i]){
//error = true;
//}
//}
//
//if(error)
//ConsoleUtil::printString("ERROR\n");
//else
//ConsoleUtil::printString("ALL OK\n");
//
//error = false;
//
//for(int i=1;i<2048;i++){
//if((uint64)mem[i] - (uint64)mem[i-1] != 4096) {
//error = true;
//break;
//}
//}
//
//if(error)
//ConsoleUtil::printString("ERROR\n");
//else
//ConsoleUtil::printString("ALL OK\n");
//
//error = false;
//
//for(int i=0;i<2048;i++){
//Buddy::free(mem[i],0);
//}
//
//if(!Buddy::canAllocate(12))
//ConsoleUtil::printString("ERROR\n");
//else
//ConsoleUtil::printString("ALL OK\n");
//
//
//Buddy::alloc(11);
//Buddy::alloc(11);
//
//void *check = Buddy::alloc(0);
//
//if(check != nullptr)
//ConsoleUtil::printString("ERROR\n");
//else
//ConsoleUtil::printString("ALL OK\n");