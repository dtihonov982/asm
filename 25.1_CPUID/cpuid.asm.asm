extern printb
section .data
    flags   dq  0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    xor     r12, r12
    mov     eax, 1
    cpuid

    mov     rdi, rax

    call    printb

    leave
    ret
