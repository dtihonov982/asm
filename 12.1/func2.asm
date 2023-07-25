extern printf
section .data
    r dq 10.0
section .bss
section .text

area:
section .data
    .pi dq 3.141592654
section .text
    push rbp
    mov rbp, rsp
    movsd xmm0, [r]
    mulsd xmm0, [r]
    mulsd xmm0, [.pi]
    leave
    ret
    
circum:
section .data
        .pi dq 3.14
section .text
    push rbp
    mov rbp, rsp
    movsd xmm0, [r]
    addsd xmm0, [r]
    mulsd xmm0, [.pi]
    leave
    ret

circle:
section .data
    .fmt db "%.2f", 10, 0
section .text
    push rbp
    mov rbp, rsp
    
    call area
    mov rdi, .fmt
    mov rax, 1
    call printf

    call circum
    mov rdi, .fmt
    mov rax, 1
    call printf

    leave
    ret

    global main
main:
    push rbp
    mov rbp, rsp
    
    call circle

    leave
    ret
