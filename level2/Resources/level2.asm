; .rodata strings:
;   0x8048620  "(%p)\n"

080484d4 <p>:                             ; void p(void)
 80484d4:	push   ebp
 80484d5:	mov    ebp,esp
 80484d7:	sub    esp,0x68               ; buf[76] @ ebp-0x4c, ret @ ebp-0xc
 80484da:	mov    eax,ds:0x8049860       ; stdout
 80484df:	mov    DWORD PTR [esp],eax
 80484e2:	call   80483b0 <fflush@plt>   ; fflush(stdout)
 80484e7:	lea    eax,[ebp-0x4c]         ; buf
 80484ea:	mov    DWORD PTR [esp],eax
 80484ed:	call   80483c0 <gets@plt>     ; gets(buf)  [no bounds check - overflow]
 80484f2:	mov    eax,DWORD PTR [ebp+0x4] ; __builtin_return_address(0)
 80484f5:	mov    DWORD PTR [ebp-0xc],eax ; ret = return address
 80484f8:	mov    eax,DWORD PTR [ebp-0xc]
 80484fb:	and    eax,0xb0000000         ; check if ret & 0xb0000000
 8048500:	cmp    eax,0xb0000000
 8048505:	jne    8048527 <p+0x53>       ; if not stack/mmap -> continue
 8048507:	mov    eax,0x8048620          ; "(%p)\n"
 804850c:	mov    edx,DWORD PTR [ebp-0xc]
 804850f:	mov    DWORD PTR [esp+0x4],edx
 8048513:	mov    DWORD PTR [esp],eax
 8048516:	call   80483a0 <printf@plt>   ; printf("(%p)\n", ret)
 804851b:	mov    DWORD PTR [esp],0x1
 8048522:	call   80483d0 <_exit@plt>    ; _exit(1)
 8048527:	lea    eax,[ebp-0x4c]         ; buf
 804852a:	mov    DWORD PTR [esp],eax
 804852d:	call   80483f0 <puts@plt>     ; puts(buf)
 8048532:	lea    eax,[ebp-0x4c]         ; buf
 8048535:	mov    DWORD PTR [esp],eax
 8048538:	call   80483e0 <strdup@plt>   ; strdup(buf)  [return value = heap addr -> eax]
 804853d:	leave
 804853e:	ret                           ; EIP overwritten -> shellcode on heap via strdup

0804853f <main>:                          ; int main(void)
 804853f:	push   ebp
 8048540:	mov    ebp,esp
 8048542:	and    esp,0xfffffff0
 8048545:	call   80484d4 <p>            ; p()
 804854a:	leave
 804854b:	ret
