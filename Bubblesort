bits    64

default rel

global  main

extern  scanf
extern  printf

section .data
    format_2x_lf            db '%lf %lf', 0
    less_than_str           db '%lf is less than %lf', 0xA, 0
    greater_or_equal_str    db '%lf is greater or equal to %lf', 0xA, 0

section .bss
    array_double    resq 2

section .text
    main:
      lea     rdx, [array_double + 8]     ; 3rd integer/pointer argument
      lea     rsi, [array_double + 0]     ; 2nd integer/pointer argument
      lea     rdi, [format_2x_lf]         ; 1st integer/pointer argument
      mov     al, 0                       ; no floating-point arguments
      call    scanf wrt ..plt
    
      mov dx, count
      oloop:
          mov cx, count
          lea si, nums

          iloop:
              mov al, [si]                 ; Because compare can't have both memory
              cmp al, [si+1]
              jl common                      ; if al is less than [si+1] Skip the below two lines for swapping.
              xchg al, [si+1]
              mov [si], al                    ; Coz we can't use two memory locations in xchg directly.

              common:
                  INC si
                  loop iloop

          dec dx
          jnz oloop

  .exit
  end
