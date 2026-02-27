; .rodata strings:
;   0x80486e0  "%s - %d\n"
;   0x80486eb  "/home/user/level8/.pass"
;   0x8048703  "~~"
;   0x80486e9  "r"
; .bss globals:
;   0x8049960  c[68]    (global char array, stores the password)
; .got.plt entries:
;   0x8049928  puts@GOT  [overwrite target -> m()]
; heap layout:
;   c1        = malloc(8)  -> {type=1, data=malloc(8)}
;   c2        = malloc(8)  -> {type=2, data=malloc(8)}
;   overflow c1->data (8 bytes) by 4 -> overwrites c2->data pointer

080484f4 <m>:                             ; void m(void)  [never called directly - GOT target]
 80484f4:	push   ebp
 80484f5:	mov    ebp,esp
 80484f7:	sub    esp,0x18
 80484fa:	mov    DWORD PTR [esp],0x0    ; time(NULL)
 8048501:	call   80483d0 <time@plt>
 8048506:	mov    edx,0x80486e0          ; "%s - %d\n"
 804850b:	mov    DWORD PTR [esp+0x8],eax ; time result
 804850f:	mov    DWORD PTR [esp+0x4],0x8049960 ; c  (global char[68])
 8048517:	mov    DWORD PTR [esp],edx
 804851a:	call   80483b0 <printf@plt>   ; printf("%s - %d\n", c, time(NULL))
 804851f:	leave
 8048520:	ret

08048521 <main>:                          ; int main(int argc, char **argv)
 8048521:	push   ebp
 8048522:	mov    ebp,esp
 8048524:	and    esp,0xfffffff0
 8048527:	sub    esp,0x20               ; c1 @ esp+0x1c, c2 @ esp+0x18, f @ (implicit)
 804852a:	mov    DWORD PTR [esp],0x8    ; size=8
 8048531:	call   80483f0 <malloc@plt>
 8048536:	mov    DWORD PTR [esp+0x1c],eax ; c1 = malloc(8)
 804853a:	mov    eax,DWORD PTR [esp+0x1c]
 804853e:	mov    DWORD PTR [eax],0x1    ; c1->type = 1
 8048544:	mov    DWORD PTR [esp],0x8    ; size=8
 804854b:	call   80483f0 <malloc@plt>
 8048550:	mov    edx,eax
 8048552:	mov    eax,DWORD PTR [esp+0x1c]
 8048556:	mov    DWORD PTR [eax+0x4],edx ; c1->data = malloc(8)
 8048559:	mov    DWORD PTR [esp],0x8    ; size=8
 8048560:	call   80483f0 <malloc@plt>
 8048565:	mov    DWORD PTR [esp+0x18],eax ; c2 = malloc(8)
 8048569:	mov    eax,DWORD PTR [esp+0x18]
 804856d:	mov    DWORD PTR [eax],0x2    ; c2->type = 2
 8048573:	mov    DWORD PTR [esp],0x8    ; size=8
 804857a:	call   80483f0 <malloc@plt>
 804857f:	mov    edx,eax
 8048581:	mov    eax,DWORD PTR [esp+0x18]
 8048585:	mov    DWORD PTR [eax+0x4],edx ; c2->data = malloc(8)
 8048588:	mov    eax,DWORD PTR [ebp+0xc] ; argv
 804858b:	add    eax,0x4                ; &argv[1]
 804858e:	mov    eax,DWORD PTR [eax]    ; argv[1]
 8048590:	mov    edx,eax
 8048592:	mov    eax,DWORD PTR [esp+0x1c]
 8048596:	mov    eax,DWORD PTR [eax+0x4] ; c1->data
 8048599:	mov    DWORD PTR [esp+0x4],edx
 804859d:	mov    DWORD PTR [esp],eax
 80485a0:	call   80483e0 <strcpy@plt>   ; strcpy(c1->data, argv[1])  [overflow - overwrites c2->data ptr]
 80485a5:	mov    eax,DWORD PTR [ebp+0xc] ; argv
 80485a8:	add    eax,0x8                ; &argv[2]
 80485ab:	mov    eax,DWORD PTR [eax]    ; argv[2]
 80485ad:	mov    edx,eax
 80485af:	mov    eax,DWORD PTR [esp+0x18]
 80485b3:	mov    eax,DWORD PTR [eax+0x4] ; c2->data  (now controlled)
 80485b6:	mov    DWORD PTR [esp+0x4],edx
 80485ba:	mov    DWORD PTR [esp],eax
 80485bd:	call   80483e0 <strcpy@plt>   ; strcpy(c2->data, argv[2])  [writes argv[2] to controlled addr]
 80485c2:	mov    edx,0x80486e9          ; "r"
 80485c7:	mov    eax,0x80486eb          ; "/home/user/level8/.pass"
 80485cc:	mov    DWORD PTR [esp+0x4],edx
 80485d0:	mov    DWORD PTR [esp],eax
 80485d3:	call   8048430 <fopen@plt>    ; f = fopen("/home/user/level8/.pass", "r")
 80485d8:	mov    DWORD PTR [esp+0x8],eax ; f
 80485dc:	mov    DWORD PTR [esp+0x4],0x44 ; n=68
 80485e4:	mov    DWORD PTR [esp],0x8049960 ; c  (global)
 80485eb:	call   80483c0 <fgets@plt>    ; fgets(c, 68, f)
 80485f0:	mov    DWORD PTR [esp],0x8048703 ; "~~"
 80485f7:	call   8048400 <puts@plt>     ; puts("~~")
 80485fc:	mov    eax,0x0
 8048601:	leave
 8048602:	ret
