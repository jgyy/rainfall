; .rodata strings:
;   0x8048570  "Good... Wait what?\n"
;   0x8048584  "/bin/sh"

08048444 <run>:                           ; void run(void)
 8048444:	push   ebp
 8048445:	mov    ebp,esp
 8048447:	sub    esp,0x18
 804844a:	mov    eax,ds:0x80497c0       ; stdout
 804844f:	mov    edx,eax
 8048451:	mov    eax,0x8048570          ; "Good... Wait what?\n"
 8048456:	mov    DWORD PTR [esp+0xc],edx
 804845a:	mov    DWORD PTR [esp+0x8],0x13 ; len=19
 8048462:	mov    DWORD PTR [esp+0x4],0x1
 804846a:	mov    DWORD PTR [esp],eax
 804846d:	call   8048350 <fwrite@plt>   ; fwrite("Good... Wait what?\n", 1, 19, stdout)
 8048472:	mov    DWORD PTR [esp],0x8048584 ; "/bin/sh"
 8048479:	call   8048360 <system@plt>   ; system("/bin/sh")
 804847e:	leave
 804847f:	ret

08048480 <main>:                          ; int main(void)
 8048480:	push   ebp
 8048481:	mov    ebp,esp
 8048483:	and    esp,0xfffffff0
 8048486:	sub    esp,0x50               ; buf[64] @ esp+0x10
 8048489:	lea    eax,[esp+0x10]         ; buf
 804848d:	mov    DWORD PTR [esp],eax
 8048490:	call   8048340 <gets@plt>     ; gets(buf)  [no bounds check - overflow]
 8048495:	leave
 8048496:	ret                           ; EIP overwritten -> jumps to run()
