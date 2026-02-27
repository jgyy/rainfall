; .rodata strings:
;   0x8048590  "/bin/cat /home/user/level5/.pass"
; .bss globals:
;   0x8049810  m        (int, initialized to 0)  [format string write target]
;   0x8049804  stdin

08048444 <p>:                             ; void p(char *s)
 8048444:	push   ebp
 8048445:	mov    ebp,esp
 8048447:	sub    esp,0x18
 804844a:	mov    eax,DWORD PTR [ebp+0x8] ; s
 804844d:	mov    DWORD PTR [esp],eax
 8048450:	call   8048340 <printf@plt>    ; printf(s)  [format string vuln - one level removed]
 8048455:	leave
 8048456:	ret

08048457 <n>:                             ; void n(void)
 8048457:	push   ebp
 8048458:	mov    ebp,esp
 804845a:	sub    esp,0x218              ; buf[520] @ ebp-0x208
 8048460:	mov    eax,ds:0x8049804       ; stdin
 8048465:	mov    DWORD PTR [esp+0x8],eax
 8048469:	mov    DWORD PTR [esp+0x4],0x200 ; n=512
 8048471:	lea    eax,[ebp-0x208]        ; buf
 8048477:	mov    DWORD PTR [esp],eax
 804847a:	call   8048350 <fgets@plt>    ; fgets(buf, 512, stdin)
 804847f:	lea    eax,[ebp-0x208]        ; buf
 8048485:	mov    DWORD PTR [esp],eax
 8048488:	call   8048444 <p>            ; p(buf)
 804848d:	mov    eax,ds:0x8049810       ; m  (global int, GOT addr 0x8049810)
 8048492:	cmp    eax,0x1025544          ; if (m == 0x1025544)
 8048497:	jne    80484a5 <n+0x4e>
 8048499:	mov    DWORD PTR [esp],0x8048590 ; "/bin/cat /home/user/level5/.pass"
 80484a0:	call   8048360 <system@plt>   ; system("/bin/cat /home/user/level5/.pass")
 80484a5:	leave
 80484a6:	ret

080484a7 <main>:                          ; int main(void)
 80484a7:	push   ebp
 80484a8:	mov    ebp,esp
 80484aa:	and    esp,0xfffffff0
 80484ad:	call   8048457 <n>            ; n()
 80484b2:	leave
 80484b3:	ret
