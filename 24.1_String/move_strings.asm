%macro prnt 2
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, %1
    mov     rdx, %2
    syscall

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, NL
    mov     rdx, 1
    syscall
%endmacro

section .data
    string1 db  "my_string of ASCII:"
    length  equ 95
    NL      db  0xa
section .bss
    my_string   resb length
    other_string resb length
section .text
    global main
main:
    push rbp
    mov  rbp, rsp
    prnt string1, 18

    mov     rax, 32
    mov     rdi, my_string
    mov     rcx, length
str_loop1:
    mov     byte [rdi], al
    inc     al
    inc     rdi
    loop    str_loop1
    
    prnt    my_string, length

    mov     rax, 48
    mov     rdi, my_string
    mov     rcx, length

str_loop2:
    stosb
    loop str_loop2
    prnt    my_string, length

    mov     rax, 49
    mov     rdi, my_string
    mov     rcx, length
    rep     stosb;
    prnt    my_string, length

    mov     rax, 32
    mov     rdi, my_string
    mov     rcx, length

str_loop3:
    mov     byte [rdi], al
    inc     al
    inc     rdi
    loop    str_loop3
    prnt    my_string, length

    mov     rsi, my_string
    mov     rdi, other_string
    mov     rcx, length
    rep     movsb
    prnt    other_string, length

    mov     rax, 48
    mov     rdi, other_string
    mov     rcx, length
    rep     stosb
    prnt    other_string, length

    lea     rsi, [my_string + length - 4]
    lea     rdi, [other_string + length]
    mov     rcx, 27
    std
    rep     movsb
    prnt    other_string, length

    leave
    ret
