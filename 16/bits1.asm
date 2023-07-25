extern printb
extern printf
section .data
    msg db  "%d"
    x   dq  -72
    y   dq  1064
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, [x]
    call    printb

    mov     rdi, [y]
    call    printb
    
    mov     rax, [x]
    xor     rax, [y]

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    or      rax, [y]

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    and     rax, [y]

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    not     rax

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    shl     al, 2

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    shr     al, 2

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    sal     al, 2

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    sar     al, 2

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    rol     al, 2

    mov     rdi, rax
    call    printb

    mov     rax, [y]
    rol     al, 2

    mov     rdi, rax
    call    printb

    mov     rax, [x]
    ror     al, 2

    mov     rdi, rax
    call    printb

    mov     rax, [y]
    ror     al, 2

    mov     rdi, rax
    call    printb

    leave
    ret
