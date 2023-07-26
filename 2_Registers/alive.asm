;alive.asm
section .data
    msg1 db "Hello, world!",  0
    msg2 db "Alive and Kicking!", 0
    radius dq 357
    pi dq 3.14
    fmtstr db "%s", 10, 0
    fmtflt db "%lf", 10, 0
    fmtint db "%d", 10, 0
section .bss
section .text
extern printf
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rax, 0
    mov     rdi, fmtstr
    mov     rsi, msg1
    call printf

    mov     rax, 0
    mov     rdi, fmtstr
    mov     rsi, msg2
    call printf

    mov     rax, 0
    mov     rdi, fmtint
    mov     rsi, [radius]
    call printf

    mov     rax, 1
    movq    xmm0, [pi]
    mov     rdi, fmtflt
    call printf
    mov     rsp, rbp
    pop     rbp
    ret
