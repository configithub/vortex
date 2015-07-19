#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>


#define e(); if(((unsigned int)ptr & 0xff000000)==0xca000000) { setresuid(geteuid(), geteuid(), geteuid()); execlp("/bin/sh", "sh", "-i", NULL); }
// if the address contained in ptr meets a certain value, call /bin/sh

void print(unsigned char *buf, int len)
{
        int i;

        printf("[ ");
        for(i=0; i < len; i++) printf("%x ", buf[i]); 
        printf(" ]\n");
}

int main()
{


        unsigned char buf[512]; 
        unsigned char *ptr = buf + (sizeof(buf)/2); // ptr points to the middle of buf
        unsigned int x;
        printf("EOF : %x\n", EOF);

        x = 0xff000000;
        //printf("0xff000000 : %d\n", x);
        //printf("0xff000000 : %x\n", x);
        x = 0xca000000;
        //printf("0xca000000 : %d\n", x);
        printf("target: 0xca000000 : %x\n", x);

        while((x = getchar()) != EOF) { 
                //printf("ptr : %d\n", (unsigned int)ptr);
                printf("ptr : %x\n", (unsigned int)ptr);
                //printf("ptr and : %d\n", (unsigned int)ptr & 0xff000000);
                printf("ptr and : %x\n", (unsigned int)ptr & 0xff000000);
                switch(x) {
                        case '\n': print(buf, sizeof(buf)); continue; break; // print whole buffer
                        case '\\': printf("decr ptr\n"); ptr--; break; // move pointer towards the beginning (or end?) of the buffer
                        default: printf("calling e\n"); e(); if(ptr > buf + sizeof(buf)) continue; ptr++[0] = x; break;
                              // try to call e, 
                              // if ptr is after buffer continue, meaning it cannot be incremented more
                              // else change the value pointed by ptr and increment it
                }
        }
        printf("All done\n");
}
