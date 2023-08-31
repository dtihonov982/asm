extern printf
section .data
    spvector1   dd    1.1
                dd    2.1
                dd    3.1
                dd    4.1
                dd    5.1
                dd    6.1
                dd    7.1
                dd    8.1
    spvector2   dd    1.1
                dd    2.2
                dd    3.2
                dd    4.2
                dd    5.2
                dd    6.2
                dd    7.2
                dd    8.2
    dpvector1   dq    1.1
                dq    2.2
                dq    3.3
                dq    4.4
    dpvector2   dq    5.5
                dq    6.6
                dq    7.7
                dq    8.8
section .bss
    spvector_res    resd    8
    dpvector_res    resq    4
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    
    vmovups ymm0, [spvector1]
    vextractf128 xmm2, ymm0, 0
    vextractf128 xmm2, ymm0, 1

    vmovups ymm1, [spvector2]
    vextractf128 xmm2, ymm1, 0
    vextractf128 xmm2, ymm1, 1

    vaddps  ymm2, ymm0, ymm1
    vmovups [spvector_res], ymm2

    mov     rsi, spvector_res
    call    printspfpv

    leave
    ret

printspfpv:
section .data
    .NL     db  10, 0
    .fmt1   db  "%.1f, ", 0
section .text
    push    rbp
    mov     rbp, rsp

    push    rcx
    push    rbx
    mov     rcx, 8
    mov     rbx, 0
    mov     rax, 1

.loop:
    movss   xmm0, [rsi + rbx]
    cvtss2sd xmm0, xmm0
    mov     rdi, .fmt1
    push    rsi
    push    rcx
    call    printf
    pop     rcx
    pop     rsi
    add     rbx, 4
    loop    .loop

    xor     rax, rax
    mov     rdi, .NL
    call    printf
    pop     rbx
    pop     rcx

    leave
    ret
