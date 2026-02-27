; .rodata strings:
;   0x8048600  "Wait what?!\n"
;   0x804860d  "/bin/sh"
; .bss globals:
;   0x804988c  m        (int, initialized to 0)
;   0x8049860  stdout

080484a4 <v>:                             ; void v(void)
 80484a4:	push   ebp
 80484a5:	mov    ebp,esp
 80484a7:	sub    esp,0x218              ; buf[520] @ ebp-0x208
 80484ad:	mov    eax,ds:0x8049860       ; stdin
 80484b2:	mov    DWORD PTR [esp+0x8],eax
 80484b6:	mov    DWORD PTR [esp+0x4],0x200 ; n=512
 80484be:	lea    eax,[ebp-0x208]        ; buf
 80484c4:	mov    DWORD PTR [esp],eax
 80484c7:	call   80483a0 <fgets@plt>    ; fgets(buf, 512, stdin)
 80484cc:	lea    eax,[ebp-0x208]        ; buf
 80484d2:	mov    DWORD PTR [esp],eax
 80484d5:	call   8048390 <printf@plt>   ; printf(buf)  [format string vuln]
 80484da:	mov    eax,ds:0x804988c       ; m  (global int, addr 0x804988c)
 80484df:	cmp    eax,0x40               ; if (m == 64)
 80484e2:	jne    8048518 <v+0x74>
 80484e4:	mov    eax,ds:0x8049880       ; stdout
 80484e9:	mov    edx,eax
 80484eb:	mov    eax,0x8048600          ; "Wait what?!\n"
 80484f0:	mov    DWORD PTR [esp+0xc],edx
 80484f4:	mov    DWORD PTR [esp+0x8],0xc ; len=12
 80484fc:	mov    DWORD PTR [esp+0x4],0x1
 8048504:	mov    DWORD PTR [esp],eax
 8048507:	call   80483b0 <fwrite@plt>   ; fwrite("Wait what?!\n", 1, 12, stdout)
 804850c:	mov    DWORD PTR [esp],0x804860d ; "/bin/sh"
 8048513:	call   80483c0 <system@plt>   ; system("/bin/sh")
 8048518:	leave
 8048519:	ret

0804851a <main>:                          ; int main(void)
 804851a:	push   ebp
 804851b:	mov    ebp,esp
 804851d:	and    esp,0xfffffff0
 8048520:	call   80484a4 <v>            ; v()
 8048525:	leave
 8048526:	ret
