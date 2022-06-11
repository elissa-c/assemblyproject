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
      lae   rdi, [format_input]
      mov   rsi, r8
      mov   rax, 0
      call  scanf wrt ..plt     ; scanning all or scanning one? add some loop for array reading
      
      
    
      mov   dx, r9
      oloop:
          mov       cx, r9
          lea       si, r8

          iloop:
              mov       al, [si]                 ; compare can't have both memory
              cmp       al, [si+1]
              jl        allgood                      ; skip if al is less than [si+1] Skip 
              
              xchg      al, [si+1]
              mov       [si], al                    ; Coz we can't use two memory locations in xchg directly.

              allgood:
                  INC       si
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
        
        add     r8, 1
        dec     r9
        jnz     .print
    .end:
        add     rsp, 8
        sub     rax, rax
        ret
  

