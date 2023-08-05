extern printf
section .data
;make sure that data unaligned
    dummmy      db    13
align 16
    spvector1   dd    1.1
                dd    2.2
                dd    3.3
                dd    4.4

    spvector2   dd    1.1
                dd    2.2
                dd    3.3
                dd    4.4

    dpvector1   dq    1.1
                dq    2.2

    dpvector2   dq    1.1
                dq    2.2

    fmt4 db "%f, %f, %f, %f", 10, 0
    fmt2 db "%f, %f", 10, 0

section .bss
    ; result of adding two float vectors
alignb 16
    spvector_res resd 4
    dpvector_res resq 2

section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    
    ;load two vectors from memory to xmm registers
    ;unaligned
    movaps  xmm0, [spvector1]
    addps   xmm0, [spvector2]

    ;save vector to memory
    movaps  [spvector_res], xmm0

    ;print vector
    mov     rsi, spvector_res
    mov     rdi, fmt4
    call    printspfp

    leave
    ret

;prints float vector. rdi - format string, rsi - address of vector in memory
printspfp:

    push     rbp
    mov      rbp, rsp

    ;save from memory to xmm0 reg first element of vector
    movss    xmm0, [rsi]
    ;convert to double precision
    cvtss2sd xmm0, xmm0

    ;-//- second element of vector
    movss    xmm1, [rsi + 4]
    cvtss2sd xmm1, xmm1

    ;-//- third element of vector
    movss    xmm2, [rsi + 8]
    cvtss2sd xmm2, xmm2

    ;-//- fourth element of vector
    movss    xmm3, [rsi + 12]
    cvtss2sd xmm3, xmm3

    ; there are 4 xmm values for printing
    mov      rax, 4
    call     printf

    leave
    ret

