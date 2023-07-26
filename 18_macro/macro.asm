extern printf

%define     double_it(r)    sal r, 1

%macro      prntf 2
    section .data
        %%arg1  db  %1, 0
        %%fmtint    db  "%s %ld", 10, 0

    section .text
        mov rdi, %%fmtint
        mov rsi, %%arg1
        mov rdx, [%2]
        mov rax, 0
        call printf
%endmacro

section .data
    n   dq  15
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    prntf   "The n is ", n
    mov     rax, [n]
    double_it(rax)
    mov     [n], rax
    prntf   "New value: ", n
    leave
    ret

