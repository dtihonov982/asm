extern printf
section .data
    x dq 9.0
    y dq 73.0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    
    movsd xmm2, [x]
    addsd xmm2, [y]

    movsd xmm2, [x]
    subsd xmm2, [y]

    movsd xmm2, [x]
    mulsd xmm2, [y]

    movsd xmm2, [x]
    divsd xmm2, [y]

    sqrtsd xmm1, [x]

    mov rsp, rbp
    pop rbp
    ret
