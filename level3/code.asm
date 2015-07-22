   0x0804842d <+0>: push   %ebp                           # function prolog
   0x0804842e <+1>: mov    %esp,%ebp                      # keep current stack pointer in base pointer
   0x08048430 <+3>: and    $0xfffffff0,%esp
   0x08048433 <+6>: sub    $0xa0,%esp                     # keep 160 bytes for local vars?
   0x08048439 <+12>:  movl   $0x8049748,0x9c(%esp)        # store some value at esp+(12+9x16) = esp+156, I suspect esp+156 is the lpp pointer
   0x08048444 <+23>:  cmpl   $0x2,0x8(%ebp)               # compare 2 to ebp+8 : this is the check on the number of args, ebp+8 is the first arg of main
   0x08048448 <+27>:  je     0x8048456 <main+41>          # if argc = 2 jump to main+41
   0x0804844a <+29>:  movl   $0x1,(%esp)                  # this is the exit system call preparation, I think
   0x08048451 <+36>:  call   0x8048310 <exit@plt>         # exit program, if there is only 2 args
   0x08048456 <+41>:  mov    0xc(%ebp),%eax               # jmp leads here if argc == 2, mv ebp+12 in eax, ebp+12 should be argv[1] 
   0x08048459 <+44>:  add    $0x4,%eax                    # add 4 to eax
   0x0804845c <+47>:  mov    (%eax),%eax                  # move the address pointed by eax in eax 
   0x0804845e <+49>:  mov    %eax,0x4(%esp)
   0x08048462 <+53>:  lea    0x18(%esp),%eax              # keep a pointer, esp+24
   0x08048466 <+57>:  mov    %eax,(%esp)
   0x08048469 <+60>:  call   0x80482f0 <strcpy@plt>       # copy of argv[1] in the buffer
   0x0804846e <+65>:  mov    0x9c(%esp),%eax              # keep value at esp+156 in eax
   0x08048475 <+72>:  mov    $0x0,%ax                     # keep 0 in ax
   0x08048479 <+76>:  cmp    $0x8040000,%eax              # compare 0x804 and eax, eax should be lpp, this seems to complicate the overflow of the buffer
   0x0804847e <+81>:  je     0x804848c <main+95>          # jump here if lpp meets 0x804, this is not the case if I overflow it...
   0x08048480 <+83>:  movl   $0x2,(%esp)                  # else leave with exit code 2, this is what happens if I simply overflow the buffer
   0x08048487 <+90>:  call   0x8048310 <exit@plt>         # exit program
   0x0804848c <+95>:  mov    0x9c(%esp),%eax              # move esp+156 (aka lpp) in eax
   0x08048493 <+102>: mov    (%eax),%eax
   0x08048495 <+104>: mov    %eax,0x98(%esp)              # move eax at esp+152
   0x0804849c <+111>: mov    0x9c(%esp),%eax              # do the opposite?
   0x080484a3 <+118>: mov    (%eax),%eax 
   0x080484a5 <+120>: lea    0x18(%esp),%edx              # keep the address esp+24 in edx
   0x080484a9 <+124>: mov    %edx,(%eax)                  # move that in eax
   0x080484ab <+126>: movl   $0x0,(%esp)                  # exit system call
   0x080484b2 <+133>: call   0x8048310 <exit@plt>

