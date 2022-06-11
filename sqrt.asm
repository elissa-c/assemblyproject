bits    64
default rel
global  main

extern  printf
extern  scanf

section .data
    format_scan       db '%lf', 0
    format_res        db '%lf', 10, 0
    format_print      db 'sqrt(%f) = %f', 10, 0

section .bss
    number      resq 1

section .text
    main:
      sub   rsp, 8
      lea   rdi, [format_scan]
      lea   rsi, [number]
      call  scanf wrt ..plt
      
      movlpd    xmm5, [number]      ;ending
      movlpd    xmm6, 0.125         ;increment
      movq      xmm4, xmm6          ;value
      xor       rax, rax
      
   sqrt:
      movsd     xmm3, xmm4
      lea       rdi, [format_print]
      sqrtsd    xmm0, xmm3
      mov       al, 2
      call      printf wrt ..plt
