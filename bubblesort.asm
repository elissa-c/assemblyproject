bits    64

default rel

global  main

extern  scanf
extern  printf

section .data
    format_input            db '%d', 0
    format_output           db '%d', 0xA, 0
    
    
section .bss
    count         resd 1
    array         resd 100

section .text
    main:
      sub   rsp, 8
      
      lea   r8, [array]         ; R8 LOAD ARRAY
      lea   r9, [count]         ; R9 COUNT
      
    read:  
	    cmp	r8, r9     ; check n >= 100
	    jge	.read_too_many

	    lea	rdi, [fmt_scan]
	    mov	rsi, r8
	    mov	rax, 0
	    call	scanf wrt ..plt

	    inc	dword [n]
	    add	r8, 4
	    cmp	rax, 1
	    jz	.read_arr
        
    .read_end:                
	    lea	r9, [array+4]
	    cmp	r8, r9
	    jnz	.read_ok  
	    xor	rax, rax  
	    inc	rax
	    add	rsp, 8
	    ret
        
    .read_too_many:
        inc	dword [n]
        
    .read_ok:
        dec	dword [n]
        lea	r9, [array]
        sub	r8, r9
        shr	r8, 2
        
        cmp	r8, 2
        jz	.end

        mov   dx, r9
        
      oloop:
          mov       cx, dword [n]
          dec       cx
          lea       si, [array]

          iloop:
	      lea	si, [si + 4*cx]
	      lea	di, [si-4]
	      
              mov       al, dword [si]                 ; compare can't have both memory
              cmp       al, dword [di]
              jl        allgood                      ; skip if al is less than [si+1] Skip 
              
              xchg      al, dword [di]
              mov       dword [si], al                    ; Coz we can't use two memory locations in xchg directly.

              allgood:
                  sub       si, 4
		  sub	    di, 4
                  loop      iloop

          cmp       dx, 0
          je        .print
          
          dec dx
          jnz oloop

          
    .print:
        mov     rsi, [r8]
        lea     rdi, [format_output]
        mov     al, 0
        call    printf wrt ..plt
        
        add     r8, 4
        dec     r9
        jnz     .print
    .end:
        add     rsp, 8
        sub     rax, rax
        ret
  

