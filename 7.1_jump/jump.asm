extern printf
section .data
    x dq 42
    y dq 41
    fmt_ge db "x >= y", 10, 0
    fmt_l db "x < y", 10, 0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    
    mov rax, [x]
    mov rdx, [y]
    cmp rax, rdx
    jge greater
    
    mov rdi, fmt_l
    mov rax, 0
    call printf
    jmp exit

    
greater:
    mov rdi, fmt_ge
    mov rax, 0
    call printf
exit:
    mov rsp, rbp
    pop rbp
    ret