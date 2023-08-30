extern printf
section .data
    string1 db "Foo bar!", 0
    fmt_s db "%s", 10, 0
    fmt_i db "%d", 10, 0
section .bss
section .text
    global main
main:
    push rbp
    mov  rbp, rsp

    mov  rdi, fmt_s
    mov  rsi, string1
    xor  rax, rax
    call printf

    mov  rdi, string1
    call pstrlen

    mov  rdi, fmt_i
    mov  rsi, rax
    xor  rax, rax
    call printf

    leave
    ret

pstrlen:
    push rbp
    mov  rbp, rsp

    mov  rax, -16
    pxor xmm0, xmm0
.not_found:
    add  rax, 16

    pcmpistri xmm0, [rdi + rax], 00001000b 
    jnz  .not_found
    add  rax, rcx
    inc  rax

    leave
    ret

