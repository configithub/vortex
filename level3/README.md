lpp -> lp -> unsigned long val (31337)
tmp -> unsigned int
char buf[128]

lpp and tmp should be just before the beginning of buf in the memory layout

copy argv[1] in buf

compare the 2 first bytes of lpp to 0x0804

if it is different leave with exit code 2

else tmp =  lp
val = beginning of buf


We want to overflow the buffer to include our shell code at the return of the main function.

We need to do this while also satisfying with the condition on lpp or else the program will exit.

Things are complicated by the fact that the main function does not actually return, so we can't just overflow to RET. See .dtors section...


