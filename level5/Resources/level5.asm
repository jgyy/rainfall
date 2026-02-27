; .rodata strings:
;   0x80485f0  "/bin/sh"
; .got.plt entries:
;   0x8049838  exit@GOT  [format string overwrite target -> o()]

080484a4 <o>:                             ; void o(void)
 80484a4:	push   ebp
 80484a5:	mov    ebp,esp
 80484a7:	sub    esp,0x18
 80484aa:	mov    DWORD PTR [esp],0x80485f0 ; "/bin/sh"
 80484b1:	call   80483b0 <system@plt>   ; system("/bin/sh")
 80484b6:	mov    DWORD PTR [esp],0x1
 80484bd:	call   8048390 <_exit@plt>    ; _exit(1)

080484c2 <n>:                             ; void n(void)
 80484c2:	push   ebp
 80484c3:	mov    ebp,esp
 80484c5:	sub    esp,0x218              ; buf[520] @ ebp-0x208
 80484cb:	mov    eax,ds:0x8049848       ; stdin
 80484d0:	mov    DWORD PTR [esp+0x8],eax
 80484d4:	mov    DWORD PTR [esp+0x4],0x200 ; n=512
 80484dc:	lea    eax,[ebp-0x208]        ; buf
 80484e2:	mov    DWORD PTR [esp],eax
 80484e5:	call   80483a0 <fgets@plt>    ; fgets(buf, 512, stdin)
 80484ea:	lea    eax,[ebp-0x208]        ; buf
 80484f0:	mov    DWORD PTR [esp],eax
 80484f3:	call   8048380 <printf@plt>   ; printf(buf)  [format string vuln]
 80484f8:	mov    DWORD PTR [esp],0x1
 80484ff:	call   80483d0 <exit@plt>     ; exit(1)  [GOT overwrite target: exit -> o()]

08048504 <main>:                          ; int main(void)
 8048504:	push   ebp
 8048505:	mov    ebp,esp
 8048507:	and    esp,0xfffffff0
 804850a:	call   80484c2 <n>            ; n()
 804850f:	leave
 8048510:	ret
