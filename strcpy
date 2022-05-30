bits    64
default rel

global  main

extern  printf

section .data
    format      db 'Hello world!', 0xA, 0

section .bss

section	.text
	global	strcpy

strcpy:
	sub 		rsp, 8
	xor		rcx, rcx
	jmp		change

change:
	mov		rdx, [rsi + rcx]
	mov		[rdi + rcx], rdx
	cmp		dl, 0
	je		exit
	inc		rcx
	jmp		change

exit:
	mov     	al, 0
	call    	printf wrt ..plt
	mov		rax, rdi
	ret
