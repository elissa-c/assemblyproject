bits    64
default rel
global  main

extern  printf
extern  scanf

section .data
    format_scan       db '%lf', 0
    format_res        db '%lf', 10, 0
    format_print      db 'sqrt(%f) = %f', 10, 0
    ;data              dd 0.125

section .bss
    number      resq 1

section .text
    main:
      sub   rsp, 8
      lea   rdi, [format_scan]
      lea   rsi, [number]
      call  scanf wrt ..plt
      
      movlpd    xmm5, [number]      ;ending
      mov       rax, __?float64?__(0.125)
      movq      xmm6, rax           ;increment
      movq      xmm4, xmm6          ;value
      xor       rax, rax
      
   .sqrt:
      movsd     xmm3, xmm4
      lea       rdi, [format_print]
      sqrtsd    xmm0, xmm3
      mov       al, 2
      call      printf wrt ..plt
      
      addsd     xmm4, xmm6
      comisd    xmm4, xmm5
      jle       .sqrt
      
      xor       rax, rax
      jmp       .end
      
    .end:
      add       rsp, 8
      ret
