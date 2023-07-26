section .data
    msg1        db      "Hello, world!", 10, 0

    msg2        db      "Your turn (a-z): ", 0

    msg3        db      "Yourn answered: ", 0

    inputlen    equ     10
    NL          db      0xa

section .bss
    input       resb    inputlen + 1
section .text
    global main

main:
    push        rbp
    mov         rbp, rsp

    mov         rdi, msg1
    call        prints

    mov         rdi, msg2
    call        prints

    mov         rdi, input
    mov         rsi, inputlen
    call        reads

    mov         rdi, msg3
    call        prints

    mov         rdi, input
    call        prints

    mov         rdi, NL
    call        prints

    add         rsp, 16
    leave
    ret

prints:
    ; rdi - address of output string
    push        rbp
    mov         rbp, rsp
    push        r12

    xor         rdx, rdx ; len
    mov         r12, rdi

.lengthloop:
    cmp         byte [r12], 0
    je          .lengthfound
    inc         rdx
    inc         r12
    jmp         .lengthloop

.lengthfound:
    cmp         rdx, 0
    je          .done
    mov         rsi, rdi
    mov         rax, 1
    mov         rdi, 1
    syscall

.done:
    pop         r12
    leave
    ret

reads:
section .data
section .bss
    .inputchar  resb    1
section .text
    push        rbp
    mov         rbp, rsp

    push        r12
    push        r13
    push        r14

    mov         r12, rdi ; buffer address
    mov         r13, rsi ; length
    xor         r14, r14

.readc:
    mov         rax, 0 ; read
    mov         rdi, 1 ; stdin
    lea         rsi, [.inputchar] ; buffer adress
    mov         rdx, 1 ; symbol count
    syscall

    mov         al, [.inputchar] ; check if \n entered
    cmp         al, byte [NL]
    je          .done

    cmp         al, 97
    jl          .readc ; code < 97

    cmp         al, 122 ; code > 122
    jg          .readc

    inc         r14
    cmp         r14, r13
    ja          .readc
    mov         byte [r12], al
    inc         r12 ; ptr++
    jmp         .readc

.done:
    inc         r12
    mov         byte [r12], 0
    pop         r14
    pop         r13
    pop         r12

    leave
    ret
