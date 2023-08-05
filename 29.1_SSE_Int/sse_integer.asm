extern printf
section .data
    dummy   db  13
align 16
    pdivector1  dd  1 
                dd  2
                dd  3
                dd  4
    pdivector2  dd  5 
                dd  6
                dd  7
                dd  8
    fmt     db  "%d %d %d %d", 10, 0
section .bss
alignb 16
    pdivector_res   resd  4
    pdivector_other resd  4
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rsi, pdivector1
    mov     rdi, fmt
    call    printpdi

    mov     rsi, pdivector2
    mov     rdi, fmt
    call    printpdi

    ;load first vector to xmm0
    movdqa  xmm0, [pdivector1]
    ;add second vector to first
    paddd   xmm0, [pdivector2]

    ;store result to memory
    movdqa  [pdivector_res], xmm0

    ;print result
    mov     rsi, pdivector_res
    mov     rdi, fmt
    call    printpdi

    movdqa  xmm3, [pdivector_res]

    ;extracting packed values from vector
    pextrd  eax, xmm3, 0
    pextrd  ebx, xmm3, 1
    pextrd  ecx, xmm3, 2
    pextrd  edx, xmm3, 3

    ;insert values in reverse order
    pinsrd  xmm0, eax, 3
    pinsrd  xmm0, ebx, 2
    pinsrd  xmm0, ecx, 1
    pinsrd  xmm0, edx, 0

    ;store reversed vector
    movdqa  [pdivector_other], xmm0

    mov     rsi, pdivector_other
    mov     rdi, fmt
    call    printpdi
    
    leave
    ret

printpdi:
push    rbp
mov     rbp, rsp
    movdqa  xmm0, [rsi]
    pextrd  esi, xmm0, 0
    pextrd  edx, xmm0, 1
    pextrd  ecx, xmm0, 2
    pextrd  r8d, xmm0, 3
    mov     rax, 0
    call    printf
leave
ret
