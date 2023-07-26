section .data
    num1    dq  128
    num2    dq  19
    neg_num dq  -12

section .bss
    resulti resq 1
    modulo  resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    ;add
    mov rax, [num1]
    add rax, [num2]
    mov [resulti], rax

    ;sub
    mov rax, [num1]
    sub rax, [num2]
    mov [resulti], rax


    mov rax, [num1]
    inc rax
    mov [resulti], rax

    mov rax, [num1]
    dec rax
    mov [resulti], rax

    mov rax, [num1]
    sal rax, 2
    mov [resulti], rax

    mov rax, [num1]
    sar rax, 2
    mov [resulti], rax

    mov rax, [neg_num]
    sar rax, 2
    mov [resulti], rax

    mov rax, [num1]
    imul qword [num2]
    mov [resulti], rax

    mov rax, [num1]
    mov rdx, 0
    idiv qword [num2]
    mov [resulti], rax
    mov [modulo], rdx

    mov rsp, rbp
    pop rbp
    ret
