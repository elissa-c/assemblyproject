bits    64
default rel

;global  main

extern  printf
extern 	scanf

section .data
    	;format      db 'Hello world!', 0xA, 0
	format_input	db '%1023s', 0
	format_output	db '%s', 10, 0

section .bss
	input   resb 1024
	output  resb 1024

section	.text
	global	strcpy

strcpy:
	sub 		rsp, 8
	
	lea 		rdi, [format_input]
	lea		rsi, [input]
	mov 		rax, 0
	call 		scanf wrt ..plt
	
	lea		rsi, [input]
	lea		rdi, [output]
	
	;mov		rcx, 0
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
	lea		rsi, [output]
	lea		rdi, [format_output]
	mov     	al, 0
	call    	printf wrt ..plt
	
	mov		rax, rdi
	add		rsp, 8
	ret
