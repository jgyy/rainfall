; .rodata strings:
;   0x8048810  "%p, %p \n"
;   0x8048819  "auth "
;   0x804881f  "reset"
;   0x8048825  "service"   (compared with ecx=6, effectively "servic")
;   0x804882d  "login"
;   0x8048833  "/bin/sh"
;   0x804883b  "Password:\n"
; .bss globals:
;   0x8049aac  auth     (char*)
;   0x8049ab0  service  (char*)
;   0x8049a80  stdin
;   0x8049aa0  stdout
; exploit: auth=malloc(4), free(auth), service=strdup(...) reuses same chunk
;          service data at auth+32 -> auth[32] non-zero -> system("/bin/sh")

08048564 <main>:                          ; int main(void)
 8048564:	push   ebp                    ; char *auth = NULL  (0x8049aac)
 8048565:	mov    ebp,esp                ; char *service = NULL  (0x8049ab0)
 8048567:	push   edi
 8048568:	push   esi
 8048569:	and    esp,0xfffffff0
 804856c:	sub    esp,0xa0               ; buf[128] @ esp+0x20
 8048572:	jmp    8048575 <main+0x11>    ; -> loop start

                                          ; --- loop ---
 8048574:	nop
 8048575:	mov    ecx,DWORD PTR ds:0x8049ab0 ; service
 804857b:	mov    edx,DWORD PTR ds:0x8049aac ; auth
 8048581:	mov    eax,0x8048810          ; "%p, %p \n"
 8048586:	mov    DWORD PTR [esp+0x8],ecx
 804858a:	mov    DWORD PTR [esp+0x4],edx
 804858e:	mov    DWORD PTR [esp],eax
 8048591:	call   8048410 <printf@plt>   ; printf("%p, %p \n", auth, service)
 8048596:	mov    eax,ds:0x8049a80       ; stdin
 804859b:	mov    DWORD PTR [esp+0x8],eax
 804859f:	mov    DWORD PTR [esp+0x4],0x80 ; n=128
 80485a7:	lea    eax,[esp+0x20]         ; buf
 80485ab:	mov    DWORD PTR [esp],eax
 80485ae:	call   8048440 <fgets@plt>    ; if (!fgets(buf, 128, stdin)) break
 80485b3:	test   eax,eax
 80485b5:	je     804872c <main+0x1c8>   ; -> return 0

                                          ; strncmp(buf, "auth ", 5)
 80485bb:	lea    eax,[esp+0x20]
 80485bf:	mov    edx,eax
 80485c1:	mov    eax,0x8048819          ; "auth "
 80485c6:	mov    ecx,0x5
 80485cb:	mov    esi,edx
 80485cd:	mov    edi,eax
 80485cf:	repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
 80485d1:	seta   dl
 80485d4:	setb   al
 80485d7:	mov    ecx,edx
 80485d9:	sub    cl,al
 80485db:	mov    eax,ecx
 80485dd:	movsx  eax,al
 80485e0:	test   eax,eax
 80485e2:	jne    8048642 <main+0xde>    ; -> check "reset"
 80485e4:	mov    DWORD PTR [esp],0x4    ; size=4
 80485eb:	call   8048470 <malloc@plt>
 80485f0:	mov    ds:0x8049aac,eax       ; auth = malloc(4)  [only 4 bytes!]
 80485f5:	mov    eax,ds:0x8049aac
 80485fa:	mov    DWORD PTR [eax],0x0    ; auth[0] = '\0'
 8048600:	lea    eax,[esp+0x20]
 8048604:	add    eax,0x5                ; buf+5
 8048607:	mov    DWORD PTR [esp+0x1c],0xffffffff
 804860f:	mov    edx,eax
 8048611:	mov    eax,0x0
 8048616:	mov    ecx,DWORD PTR [esp+0x1c]
 804861a:	mov    edi,edx
 804861c:	repnz scas al,BYTE PTR es:[edi] ; strlen(buf+5)
 804861e:	mov    eax,ecx
 8048620:	not    eax
 8048622:	sub    eax,0x1
 8048625:	cmp    eax,0x1e               ; if (strlen(buf+5) < 31)
 8048628:	ja     8048642 <main+0xde>    ; else skip strcpy
 804862a:	lea    eax,[esp+0x20]
 804862e:	lea    edx,[eax+0x5]          ; buf+5
 8048631:	mov    eax,ds:0x8049aac       ; auth
 8048636:	mov    DWORD PTR [esp+0x4],edx
 804863a:	mov    DWORD PTR [esp],eax
 804863d:	call   8048460 <strcpy@plt>   ; strcpy(auth, buf+5)

                                          ; strncmp(buf, "reset", 5)
 8048642:	lea    eax,[esp+0x20]
 8048646:	mov    edx,eax
 8048648:	mov    eax,0x804881f          ; "reset"
 804864d:	mov    ecx,0x5
 8048652:	mov    esi,edx
 8048654:	mov    edi,eax
 8048656:	repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
 8048658:	seta   dl
 804865b:	setb   al
 804865e:	mov    ecx,edx
 8048660:	sub    cl,al
 8048662:	mov    eax,ecx
 8048664:	movsx  eax,al
 8048667:	test   eax,eax
 8048669:	jne    8048678 <main+0x114>   ; -> check "service"
 804866b:	mov    eax,ds:0x8049aac       ; auth
 8048670:	mov    DWORD PTR [esp],eax
 8048673:	call   8048420 <free@plt>     ; free(auth)

                                          ; strncmp(buf, "service", 7) - note: len 6 only checked
 8048678:	lea    eax,[esp+0x20]
 804867c:	mov    edx,eax
 804867e:	mov    eax,0x8048825          ; "service"
 8048683:	mov    ecx,0x6                ; only 6 chars compared (bug: "servic")
 8048688:	mov    esi,edx
 804868a:	mov    edi,eax
 804868c:	repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
 804868e:	seta   dl
 8048691:	setb   al
 8048694:	mov    ecx,edx
 8048696:	sub    cl,al
 8048698:	mov    eax,ecx
 804869a:	movsx  eax,al
 804869d:	test   eax,eax
 804869f:	jne    80486b5 <main+0x151>   ; -> check "login"
 80486a1:	lea    eax,[esp+0x20]
 80486a5:	add    eax,0x7                ; buf+7
 80486a8:	mov    DWORD PTR [esp],eax
 80486ab:	call   8048430 <strdup@plt>
 80486b0:	mov    ds:0x8049ab0,eax       ; service = strdup(buf+7)  [heap alloc after free(auth)]

                                          ; strncmp(buf, "login", 5)
 80486b5:	lea    eax,[esp+0x20]
 80486b9:	mov    edx,eax
 80486bb:	mov    eax,0x804882d          ; "login"
 80486c0:	mov    ecx,0x5
 80486c5:	mov    esi,edx
 80486c7:	mov    edi,eax
 80486c9:	repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
 80486cb:	seta   dl
 80486ce:	setb   al
 80486d1:	mov    ecx,edx
 80486d3:	sub    cl,al
 80486d5:	mov    eax,ecx
 80486d7:	movsx  eax,al
 80486da:	test   eax,eax
 80486dc:	jne    8048574 <main+0x10>    ; -> loop
 80486e2:	mov    eax,ds:0x8049aac       ; auth
 80486e7:	mov    eax,DWORD PTR [eax+0x20] ; auth[32]  [use-after-free: service data overlaps here]
 80486ea:	test   eax,eax
 80486ec:	je     80486ff <main+0x19b>   ; -> "Password:\n"
 80486ee:	mov    DWORD PTR [esp],0x8048833 ; "/bin/sh"
 80486f5:	call   8048480 <system@plt>   ; system("/bin/sh")
 80486fa:	jmp    8048574 <main+0x10>    ; -> loop
 80486ff:	mov    eax,ds:0x8049aa0       ; stdout
 8048704:	mov    edx,eax
 8048706:	mov    eax,0x804883b          ; "Password:\n"
 804870b:	mov    DWORD PTR [esp+0xc],edx
 804870f:	mov    DWORD PTR [esp+0x8],0xa ; len=10
 8048717:	mov    DWORD PTR [esp+0x4],0x1
 804871f:	mov    DWORD PTR [esp],eax
 8048722:	call   8048450 <fwrite@plt>   ; fwrite("Password:\n", 1, 10, stdout)
 8048727:	jmp    8048574 <main+0x10>    ; -> loop

 804872c:	mov    eax,0x0
 8048732:	lea    esp,[ebp-0x8]
 8048735:	pop    esi
 8048736:	pop    edi
 8048737:	pop    ebp
 8048738:	ret
