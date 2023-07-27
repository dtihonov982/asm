section .data
section .bss
section .text
    global main

main:
    push        rbp
    mov         rbp, rsp

    call        read_int

    leave
    ret

read_int:

section .data
section .bss
    .buf  resb    1
section .text
    push        rbp
    mov         rbp, rsp
    push        r14
    
    mov         r14, 0

.readc:
    mov         rax, 0 ; read
    mov         rdi, 1 ; stdin
    lea         rsi, [.buf] ; buffer adress
    mov         rdx, 1 ; symbol count
    syscall

    mov         al, [.buf] 

    sub         al, 48 ; ASCII '0' is 48
    cmp         al, 0
    jl          .done  
    cmp         al, 9 
    jg          .done

    imul        r14, 10
    add         r14, rax

    jmp         .readc

.done:
    mov         rax, r14

    pop         r14
    leave
    ret
