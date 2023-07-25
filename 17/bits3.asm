extern printb
section .data
    flags   dq  0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, [flags]
    call    printb

    bts     qword [flags], 4
    mov     rdi, [flags]
    call    printb

    bts     qword [flags], 7
    mov     rdi, [flags]
    call    printb


    bts     qword [flags], 8
    mov     rdi, [flags]
    call    printb

    bts     qword [flags], 61
    mov     rdi, [flags]
    call    printb

    btr     qword [flags], 8
    mov     rdi, [flags]
    call    printb

    xor     rdi, rdi
    mov     rax, 61
    bt      [flags], rax
    setc    dil
    call    printb

    leave
    ret
