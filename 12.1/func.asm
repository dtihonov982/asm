extern printf
section .data
    r dq 10.0
    pi dq 3.14
    fmt db "%.2f", 10, 0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    
    call area

    mov rdi, fmt
    ;movsd xmm1, [r]
    mov rax, 1
    call printf

    leave
    ret

area:
    push rbp
    mov rbp, rsp
    movsd xmm0, [r]
    mulsd xmm0, [r]
    mulsd xmm0, [pi]
    leave
    ret
    
