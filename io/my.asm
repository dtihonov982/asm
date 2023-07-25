extern  scanf
extern  printf
section .data
    fmt_out db  "Enter a number:", 0
    fmt_in  db  "%d",0
    fmt_result  db  "%d", 10, 0
section .bss
    N resq 1
section .text
    global main
main:
    push rbp
    mov     rbp, rsp
    mov     rdi, fmt_out
    mov     rax, 0
    call    printf

    mov     rdi, fmt_in
    mov     rsi, N
    mov rax, 0
    call scanf

    mov rdi, fmt_result
    mov rsi, [N]
    mov rax, 0
    call printf

    leave
    ret

