extern printf
section .data
    arg1    db  "A", 0
    arg2    db  "B", 0
    arg3    db  "C", 0
    arg4    db  "D", 0
    arg5    db  "E", 0
    arg6    db  "F", 0
    arg7    db  "G", 0
    arg8    db  "H", 0
    arg9    db  "I", 0
    arg10   db  "J", 0
    fmt1    db  "%s%s%s%s%s%s%s%s%s%s", 10, 0 ;10 strings
    fmt2    db  "%f", 10, 0
    pi      dq  3.14
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, fmt1
    mov     rsi, arg1
    mov     rdx, arg2
    mov     rcx, arg3
    mov     r8,  arg4
    mov     r9,  arg5   
    ;and     rsp, 0xfffffffffffffff0
    push    0
    push    arg10
    push    arg9
    push    arg8
    push    arg7
    push    arg6
    mov     rax, 0


    call    printf

    movsd   xmm0, [pi]
    mov     rax, 1
    mov     rdi, fmt2
    call    printf

    leave
    ret
