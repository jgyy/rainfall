; vtable @ 0x8048848:
;   [0x8048848]  -> 0x0804873a  N::operator+
;   [0x804884c]  -> 0x0804874e  N::operator-
; N object layout (size = 0x6c = 108 bytes):
;   +0x00  vtable ptr  (4 bytes)
;   +0x04  str[100]    (100 bytes)  <- memcpy writes here, no bounds check
;   +0x68  n           (4 bytes, int)
; heap layout:
;   a = new N(5)  @ heap chunk A
;   b = new N(6)  @ heap chunk B  (adjacent, 108 bytes after A)
;   a->str overflow of >104 bytes overwrites b's vtable ptr

080486f6 <_ZN1NC1Ei>:                     ; N::N(int value)
 80486f6:	push   ebp
 80486f7:	mov    ebp,esp
 80486f9:	mov    eax,DWORD PTR [ebp+0x8] ; this
 80486fc:	mov    DWORD PTR [eax],0x8048848 ; vtable ptr -> [operator+, operator-]
 8048702:	mov    eax,DWORD PTR [ebp+0x8] ; this
 8048705:	mov    edx,DWORD PTR [ebp+0xc] ; value
 8048708:	mov    DWORD PTR [eax+0x68],edx ; this->n = value  (str[100] + 4 bytes = offset 0x68)
 804870b:	pop    ebp
 804870c:	ret

0804870e <_ZN1N13setAnnotationEPc>:       ; void N::setAnnotation(char *s)
 804870e:	push   ebp
 804870f:	mov    ebp,esp
 8048711:	sub    esp,0x18
 8048714:	mov    eax,DWORD PTR [ebp+0xc] ; s
 8048717:	mov    DWORD PTR [esp],eax
 804871a:	call   8048520 <strlen@plt>   ; len = strlen(s)
 804871f:	mov    edx,DWORD PTR [ebp+0x8] ; this
 8048722:	add    edx,0x4                ; this->str  (vtable ptr at +0, str at +4)
 8048725:	mov    DWORD PTR [esp+0x8],eax ; len
 8048729:	mov    eax,DWORD PTR [ebp+0xc] ; s
 804872c:	mov    DWORD PTR [esp+0x4],eax
 8048730:	mov    DWORD PTR [esp],edx
 8048733:	call   8048510 <memcpy@plt>   ; memcpy(this->str, s, len)  [no bounds - overflow into b's vtable]
 8048738:	leave
 8048739:	ret

0804873a <_ZN1NplERS_>:                   ; N N::operator+(N &rhs)
 804873a:	push   ebp
 804873b:	mov    ebp,esp
 804873d:	mov    eax,DWORD PTR [ebp+0x8] ; this
 8048740:	mov    edx,DWORD PTR [eax+0x68] ; this->n
 8048743:	mov    eax,DWORD PTR [ebp+0xc] ; rhs
 8048746:	mov    eax,DWORD PTR [eax+0x68] ; rhs.n
 8048749:	add    eax,edx                ; rhs.n + this->n
 804874b:	pop    ebp
 804874c:	ret

0804874e <_ZN1NmiERS_>:                   ; N N::operator-(N &rhs)
 804874e:	push   ebp
 804874f:	mov    ebp,esp
 8048751:	mov    eax,DWORD PTR [ebp+0x8] ; this
 8048754:	mov    edx,DWORD PTR [eax+0x68] ; this->n
 8048757:	mov    eax,DWORD PTR [ebp+0xc] ; rhs
 804875a:	mov    eax,DWORD PTR [eax+0x68] ; rhs.n
 804875d:	mov    ecx,edx
 804875f:	sub    ecx,eax                ; this->n - rhs.n
 8048761:	mov    eax,ecx
 8048763:	pop    ebp
 8048764:	ret

080485f4 <main>:                          ; int main(int argc, char **argv)
 80485f4:	push   ebp
 80485f5:	mov    ebp,esp
 80485f7:	push   ebx
 80485f8:	and    esp,0xfffffff0
 80485fb:	sub    esp,0x20               ; a @ esp+0x1c, b @ esp+0x18
 80485fe:	cmp    DWORD PTR [ebp+0x8],0x1 ; argc
 8048602:	jg     8048610 <main+0x1c>    ; if argc < 2 -> _exit
 8048604:	mov    DWORD PTR [esp],0x1
 804860b:	call   80484f0 <_exit@plt>    ; _exit(1)
 8048610:	mov    DWORD PTR [esp],0x6c   ; size=108 (vtable ptr 4 + str[100] + n 4)
 8048617:	call   8048530 <_Znwj@plt>    ; operator new(108)
 804861c:	mov    ebx,eax
 804861e:	mov    DWORD PTR [esp+0x4],0x5 ; value=5
 8048626:	mov    DWORD PTR [esp],ebx
 8048629:	call   80486f6 <_ZN1NC1Ei>   ; a = new N(5)
 804862e:	mov    DWORD PTR [esp+0x1c],ebx
 8048632:	mov    DWORD PTR [esp],0x6c   ; size=108
 8048639:	call   8048530 <_Znwj@plt>    ; operator new(108)
 804863e:	mov    ebx,eax
 8048640:	mov    DWORD PTR [esp+0x4],0x6 ; value=6
 8048648:	mov    DWORD PTR [esp],ebx
 804864b:	call   80486f6 <_ZN1NC1Ei>   ; b = new N(6)
 8048650:	mov    DWORD PTR [esp+0x18],ebx
 8048654:	mov    eax,DWORD PTR [esp+0x1c] ; a
 8048658:	mov    DWORD PTR [esp+0x14],eax
 804865c:	mov    eax,DWORD PTR [esp+0x18] ; b
 8048660:	mov    DWORD PTR [esp+0x10],eax
 8048664:	mov    eax,DWORD PTR [ebp+0xc] ; argv
 8048667:	add    eax,0x4                ; &argv[1]
 804866a:	mov    eax,DWORD PTR [eax]    ; argv[1]
 804866c:	mov    DWORD PTR [esp+0x4],eax
 8048670:	mov    eax,DWORD PTR [esp+0x14] ; a
 8048674:	mov    DWORD PTR [esp],eax
 8048677:	call   804870e <_ZN1N13setAnnotationEPc> ; a->setAnnotation(argv[1])  [overflow into b's vtable]
 804867c:	mov    eax,DWORD PTR [esp+0x10] ; b
 8048680:	mov    eax,DWORD PTR [eax]    ; b->vtable ptr  (now controlled)
 8048682:	mov    edx,DWORD PTR [eax]    ; vtable[0] = operator+
 8048684:	mov    eax,DWORD PTR [esp+0x14] ; a
 8048688:	mov    DWORD PTR [esp+0x4],eax
 804868c:	mov    eax,DWORD PTR [esp+0x10] ; b
 8048690:	mov    DWORD PTR [esp],eax
 8048693:	call   edx                    ; (*b + *a)  -> calls shellcode via corrupted vtable
 8048695:	mov    ebx,DWORD PTR [ebp-0x4]
 8048698:	leave
 8048699:	ret
