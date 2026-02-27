; .rodata strings:
;   0x80485b0  "/bin/cat /home/user/level7/.pass"
;   0x80485d1  "Nope"
; heap layout (adjacent malloc blocks):
;   buf = malloc(64)   [esp+0x1c]
;   fp  = malloc(4)    [esp+0x18]  <- overflow from buf reaches here

08048454 <n>:                             ; void n(void)
 8048454:	push   ebp
 8048455:	mov    ebp,esp
 8048457:	sub    esp,0x18
 804845a:	mov    DWORD PTR [esp],0x80485b0 ; "/bin/cat /home/user/level7/.pass"
 8048461:	call   8048370 <system@plt>   ; system("/bin/cat /home/user/level7/.pass")
 8048466:	leave
 8048467:	ret

08048468 <m>:                             ; void m(void)
 8048468:	push   ebp
 8048469:	mov    ebp,esp
 804846b:	sub    esp,0x18
 804846e:	mov    DWORD PTR [esp],0x80485d1 ; "Nope"
 8048475:	call   8048360 <puts@plt>     ; puts("Nope")
 804847a:	leave
 804847b:	ret

0804847c <main>:                          ; int main(int argc, char **argv)
 804847c:	push   ebp
 804847d:	mov    ebp,esp
 804847f:	and    esp,0xfffffff0
 8048482:	sub    esp,0x20               ; buf @ esp+0x1c, fp @ esp+0x18
 8048485:	mov    DWORD PTR [esp],0x40   ; size=64
 804848c:	call   8048350 <malloc@plt>
 8048491:	mov    DWORD PTR [esp+0x1c],eax ; buf = malloc(64)
 8048495:	mov    DWORD PTR [esp],0x4    ; size=4
 804849c:	call   8048350 <malloc@plt>
 80484a1:	mov    DWORD PTR [esp+0x18],eax ; fp = malloc(4)
 80484a5:	mov    edx,0x8048468          ; &m
 80484aa:	mov    eax,DWORD PTR [esp+0x18]
 80484ae:	mov    DWORD PTR [eax],edx    ; *fp = m
 80484b0:	mov    eax,DWORD PTR [ebp+0xc] ; argv
 80484b3:	add    eax,0x4                ; &argv[1]
 80484b6:	mov    eax,DWORD PTR [eax]    ; argv[1]
 80484b8:	mov    edx,eax
 80484ba:	mov    eax,DWORD PTR [esp+0x1c] ; buf
 80484be:	mov    DWORD PTR [esp+0x4],edx
 80484c2:	mov    DWORD PTR [esp],eax
 80484c5:	call   8048340 <strcpy@plt>   ; strcpy(buf, argv[1])  [overflow - buf adj to fp]
 80484ca:	mov    eax,DWORD PTR [esp+0x18] ; fp
 80484ce:	mov    eax,DWORD PTR [eax]    ; *fp
 80484d0:	call   eax                    ; (*fp)()  -> overwritten to call n()
 80484d2:	leave
 80484d3:	ret
