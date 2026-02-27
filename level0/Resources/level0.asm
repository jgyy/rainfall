; .rodata strings (statically linked - embedded libc strings):
;   0x80c5348  "/bin/sh"
;   0x80c5350  "No !\n"
;   0x80ee170  stderr

08048ec0 <main>:                          ; int main(int argc, char **argv)
 8048ec0:	push   ebp
 8048ec1:	mov    ebp,esp
 8048ec3:	and    esp,0xfffffff0
 8048ec6:	sub    esp,0x20               ; locals: args[0] @ esp+0x10, args[1] @ esp+0x14, euid @ esp+0x18, egid @ esp+0x1c
 8048ec9:	mov    eax,DWORD PTR [ebp+0xc] ; argv
 8048ecc:	add    eax,0x4                 ; &argv[1]
 8048ecf:	mov    eax,DWORD PTR [eax]     ; argv[1]
 8048ed1:	mov    DWORD PTR [esp],eax
 8048ed4:	call   8049710 <atoi>          ; n = atoi(argv[1])
 8048ed9:	cmp    eax,0x1a7              ; if (n == 423)
 8048ede:	jne    8048f58 <main+0x98>    ; else -> fwrite "No !\n"
 8048ee0:	mov    DWORD PTR [esp],0x80c5348  ; "/bin/sh"
 8048ee7:	call   8050bf0 <__strdup>     ; args[0] = strdup("/bin/sh")
 8048eec:	mov    DWORD PTR [esp+0x10],eax
 8048ef0:	mov    DWORD PTR [esp+0x14],0x0  ; args[1] = NULL
 8048ef8:	call   8054680 <__getegid>    ; egid = getegid()
 8048efd:	mov    DWORD PTR [esp+0x1c],eax
 8048f01:	call   8054670 <__geteuid>    ; euid = geteuid()
 8048f06:	mov    DWORD PTR [esp+0x18],eax
 8048f0a:	mov    eax,DWORD PTR [esp+0x1c]
 8048f0e:	mov    DWORD PTR [esp+0x8],eax
 8048f12:	mov    eax,DWORD PTR [esp+0x1c]
 8048f16:	mov    DWORD PTR [esp+0x4],eax
 8048f1a:	mov    eax,DWORD PTR [esp+0x1c]
 8048f1e:	mov    DWORD PTR [esp],eax
 8048f21:	call   8054700 <__setresgid>  ; setresgid(egid, egid, egid)
 8048f26:	mov    eax,DWORD PTR [esp+0x18]
 8048f2a:	mov    DWORD PTR [esp+0x8],eax
 8048f2e:	mov    eax,DWORD PTR [esp+0x18]
 8048f32:	mov    DWORD PTR [esp+0x4],eax
 8048f36:	mov    eax,DWORD PTR [esp+0x18]
 8048f3a:	mov    DWORD PTR [esp],eax
 8048f3d:	call   8054690 <__setresuid>  ; setresuid(euid, euid, euid)
 8048f42:	lea    eax,[esp+0x10]         ; args[]
 8048f46:	mov    DWORD PTR [esp+0x4],eax
 8048f4a:	mov    DWORD PTR [esp],0x80c5348  ; "/bin/sh"
 8048f51:	call   8054640 <execv>        ; execv("/bin/sh", args)
 8048f56:	jmp    8048f80 <main+0xc0>
 8048f58:	mov    eax,ds:0x80ee170       ; stderr
 8048f5d:	mov    edx,eax
 8048f5f:	mov    eax,0x80c5350          ; "No !\n"
 8048f64:	mov    DWORD PTR [esp+0xc],edx
 8048f68:	mov    DWORD PTR [esp+0x8],0x5
 8048f70:	mov    DWORD PTR [esp+0x4],0x1
 8048f78:	mov    DWORD PTR [esp],eax
 8048f7b:	call   804a230 <_IO_fwrite>   ; fwrite("No !\n", 1, 5, stderr)
 8048f80:	mov    eax,0x0
 8048f85:	leave
 8048f86:	ret
