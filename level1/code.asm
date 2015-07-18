   0x080485c0 <+0>: push   %ebp                                # keep current base pointer register on the stack, it will be needed to restore the stack frame 
   0x080485c1 <+1>: mov    %esp,%ebp                           # these 2 instructions are the function prolog, put the stack's top address in the base register
   0x080485c3 <+3>: push   %esi                                # push instruction pointer to the stack, to allow a return here after the function call 
   0x080485c4 <+4>: push   %ebx                                # push value stored in ebx on top of the stack (which is pointed to by esp)
   0x080485c5 <+5>: and    $0xfffffff0,%esp                    # and operation betwen value 0xffffffff0 and esp (the value which was in ebx before)
   0x080485c8 <+8>: sub    $0x220,%esp                         # substract 544 (512+32) to esp : keep room for local vars? buffer : 512, ptr : 4, x : 4 and the rest?
   0x080485ce <+14>:  mov    %gs:0x14,%eax                     # 14 -> 20
   0x080485d4 <+20>:  mov    %eax,0x21c(%esp)                  # 21c = 12+16+512 = 540 
   0x080485db <+27>:  xor    %eax,%eax      # eax = 0          # [lea reg,addr] stores the address in register, [mov reg, addr] stores the values at addr in reg
   0x080485dd <+29>:  lea    0x1c(%esp),%eax                   # 0x1c(%esp) should be the address where the buffer starts ( = esp + 28 )
   0x080485e1 <+33>:  add    $0x100,%eax                       # add 256 to eax, this should be where ptr points to
   0x080485e6 <+38>:  mov    %eax,0x14(%esp)                   # move the value in eax to esp+20 (keep ptr value)
   0x080485ea <+42>:  jmp    0x804868e <main+206>              # jump to getchar
   0x080485ef <+47>:  mov    0x18(%esp),%eax                   # move esp+24 in eax 
   0x080485f3 <+51>:  cmp    $0xa,%eax                         # compare esp+24 to 0xa (= 10) 
   0x080485f6 <+54>:  je     0x80485ff <main+63>               # if equal jump to 63     
   0x080485f8 <+56>:  cmp    $0x5c,%eax                        # else compare esp+24 to 92
   0x080485fb <+59>:  je     0x8048615 <main+85>               # if equal jump to 85
   0x080485fd <+61>:  jmp    0x804861c <main+92>               # else jump to 92
   0x080485ff <+63>:  movl   $0x200,0x4(%esp)                  # move value 512 to esp+4
   0x08048607 <+71>:  lea    0x1c(%esp),%eax                   # keep the address esp+28 in eax
   0x0804860b <+75>:  mov    %eax,(%esp)                       # move eax to esp, this looks like function exit ? 
   0x0804860e <+78>:  call   0x804856d <print>                 # call the print function
   0x08048613 <+83>:  jmp    0x804868e <main+206>              # jump to getchar
   0x08048615 <+85>:  subl   $0x1,0x14(%esp)                   # decrement esp+20 => esp+20 is ptr
   0x0804861a <+90>:  jmp    0x804868e <main+206>              # jump to getchar
   0x0804861c <+92>:  mov    0x14(%esp),%eax                   # move the value at esp+20 in eax (i.e. put ptr in eax)
   0x08048620 <+96>:  and    $0xff000000,%eax                  # ptr and 0xff000000 => trim 6 digits at the right of ptr, keep the 2 leading digits (or the leading byte)
   0x08048625 <+101>: cmp    $0xca000000,%eax                  # compare the result to 0xca000000
   0x0804862a <+106>: jne    0x804866b <main+171>              # if not equal jump to instruction 171
   0x0804862c <+108>: call   0x8048430 <geteuid@plt>           # else call geteuid + /bin/sh, this is what we want to achieve on the vortex host
   0x08048631 <+113>: mov    %eax,%esi
   0x08048633 <+115>: call   0x8048430 <geteuid@plt>
   0x08048638 <+120>: mov    %eax,%ebx
   0x0804863a <+122>: call   0x8048430 <geteuid@plt>
   0x0804863f <+127>: mov    %esi,0x8(%esp)
   0x08048643 <+131>: mov    %ebx,0x4(%esp)
   0x08048647 <+135>: mov    %eax,(%esp)
   0x0804864a <+138>: call   0x80483e0 <setresuid@plt>
   0x0804864f <+143>: movl   $0x0,0x8(%esp)
   0x08048657 <+151>: movl   $0x804876a,0x4(%esp)
   0x0804865f <+159>: movl   $0x804876d,(%esp)
   0x08048666 <+166>: call   0x8048420 <execlp@plt>
   0x0804866b <+171>: lea    0x1c(%esp),%eax
   0x0804866f <+175>: add    $0x200,%eax
   0x08048674 <+180>: cmp    %eax,0x14(%esp)
   0x08048678 <+184>: jbe    0x804867c <main+188>
   0x0804867a <+186>: jmp    0x804868d <main+205>
   0x0804867c <+188>: mov    0x14(%esp),%eax
   0x08048680 <+192>: lea    0x1(%eax),%edx
   0x08048683 <+195>: mov    %edx,0x14(%esp)
   0x08048687 <+199>: mov    0x18(%esp),%edx
   0x0804868b <+203>: mov    %dl,(%eax)
   0x0804868d <+205>: nop
   0x0804868e <+206>: call   0x8048400 <getchar@plt>
   0x08048693 <+211>: mov    %eax,0x18(%esp)
   0x08048697 <+215>: cmpl   $0xffffffff,0x18(%esp)
   0x0804869c <+220>: jne    0x80485ef <main+47>
   0x080486a2 <+226>: movl   $0x8048775,(%esp)
   0x080486a9 <+233>: call   0x8048440 <puts@plt>
   0x080486ae <+238>: mov    $0x0,%eax
   0x080486b3 <+243>: mov    0x21c(%esp),%ecx
   0x080486ba <+250>: xor    %gs:0x14,%ecx
   0x080486c1 <+257>: je     0x80486c8 <main+264>
   0x080486c3 <+259>: call   0x8048410 <__stack_chk_fail@plt>
   0x080486c8 <+264>: lea    -0x8(%ebp),%esp
   0x080486cb <+267>: pop    %ebx
   0x080486cc <+268>: pop    %esi
   0x080486cd <+269>: pop    %ebp
   0x080486ce <+270>: ret    

