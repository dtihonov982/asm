extern printf
section .data
    number dq 1000000000
    fmt db "sum(0..%ld)=%ld", 10, 0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    mov rbx, 0
    mov rax, 0
jloop:
    add rax, rbx
    inc rbx
    cmp rbx, [number]
    jle jloop
    
    mov rdi, fmt
    mov rsi, [number]
    mov rdx, rax
    mov rax, 0
    call printf

    mov rsp, rbp
    pop rbp
    ret
