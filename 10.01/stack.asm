extern printf
section .data
    string  db  "ABCDE", 0
    stringLen    equ $ - string - 1
    fmt     db  "%s",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    xor rax, rax
    mov rbx, string
    mov rcx, stringLen
    mov r12, 0

    pushLoop:
        mov al, byte [rbx + r12]
        push rax
        inc r12
        loop pushLoop

    mov rbx, string
    mov rcx, stringLen
    mov r12, 0

    popLoop:
        pop rax
        mov byte [rbx + r12], al
        inc r12
        loop popLoop

    mov byte [rbx + 12], 0

    mov rdi, fmt
    mov rsi, string
    mov rax, 0
    call printf

    mov rsp, rbp
    pop rbp
    ret
