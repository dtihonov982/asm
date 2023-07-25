extern  scanf
extern  printf
section .data
    arr     dq  -1, 1, 3, 4, 5
    len     dq  ($-arr)/8
    fmt     db  "%d", 10, 0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    xor     rax, rax
    xor     rcx, rcx 

.L1:
    cmp     rcx, [len]
    je      .L0

    add     rax, qword [arr+rcx*8]
    inc     rcx
    jmp     .L1

.L0:

    mov     rdi, fmt
    mov     rsi, rax
    mov     rax, 0
    call    printf

    leave
    ret

