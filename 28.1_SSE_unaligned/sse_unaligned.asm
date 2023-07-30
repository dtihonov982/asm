extern printf
section .data
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
    spvector_res resd 4
    dpvector_res resq 2

section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    
    ;add two vectors of 4 float
    movups  xmm0, [spvector1]
    movups  xmm1, [spvector2]
    addps   xmm0, xmm1

    ;save vector to memory
    movups  [spvector_res], xmm0

    ;print vector
    mov     rsi, spvector_res
    mov     rdi, fmt4
    call    printspfp


    leave
    return

printspfp:

    push     rbp
    mov      rbp, rsp

    ;save from memory to xmm0 reg first element of vector
    movss    xmm0, [rsi]
    cvtss2sd xmm0, xmm0

    movss    xmm1, [rsi + 4]
    cvtss2sd xmm1, xmm1

    movss    xmm2, [rsi + 8]
    cvtss2sd xmm2, xmm2

    movss    xmm3, [rsi + 12]
    cvtss2sd xmm3, xmm3

    mov      rax, 4
    call     printf

    leave
    ret

