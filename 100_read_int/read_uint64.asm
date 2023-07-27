extern printf
section .data
    err_msg     db      "Error", 10, 0
    fmt         db      "%lu", 10, 0
section .bss
section .text
    global main

main:
    push        rbp
    mov         rbp, rsp
    sub         rsp, 8

    lea         rdi, [rsp]
    call        read_int

    test        rax, rax
    jz          .normal

    mov         rdi, err_msg
    call        prints
    jmp         .done

.normal:
    mov         rdi, fmt
    mov         rsi, [rsp]
    sub         rsp, 8
    xor         rax, rax
    call        printf

.done:

    xor         rax, rax
    leave
    ret

;rdi - adress of result
;rax - 0 if OK, -1 if error
read_int:

section .data
section .bss
    .buf  resb    1
section .text
    push        rbp
    mov         rbp, rsp
    push        r12
    push        r13
    push        r14
    
    xor         r12, r12 ; error flag
    mov         r13, rdi ; adress of a result
    mov         r14, 0   ; temporary number

.getch:
    mov         rax, 0 ; read
    mov         rdi, 1 ; stdin
    lea         rsi, [.buf] ; buffer adress
    mov         rdx, 1 ; symbol count
    syscall

    mov         al, [.buf] 
    cmp         al, 0xa
    je          .loop_done

    test        r12, r12 ; err_flag
    jnz          .getch

    sub         al, 48 ; char
    cmp         al, 0 ; char
    jl          .set_err
    
    cmp         al, 9 ; ch
    jg          .set_err

    imul        r14, 10 ; number
    add         r14, rax
    jmp         .getch

.set_err:
    mov         r12, 1
    jmp         .getch

.loop_done:
    test        r12, r12
    jz          .good
    mov         rax, -1
    jmp         .done

.good:
    mov         rax, 0
    mov         [r13], r14;

.done:
    pop         r14
    pop         r13
    pop         r12
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

