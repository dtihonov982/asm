;TODO: check max and min int64 
;TODO: connect reads function and str_to_int64
extern printf
section .data
    number_str  db      "-9223372036854775808", 0
    fmt         db      "%ld", 10, 0
    err_msg     db      "Error", 10, 0
section .bss
    buffer      resb    50
section .text
    global main

main:
    push        rbp
    mov         rbp, rsp
    sub         rsp, 8

    mov         rdi, buffer
    mov         rsi, 50
    call        reads

    ;mov         rdi, number_str ; rdi = &number_str
    mov         rdi, buffer ; rdi = &number_str
    lea         rsi, [rsp] ; rsi = &num
    call        str_to_int64

    test        rax, rax ; rax = 0 if OK
    jz          .normal

    mov         rdi, err_msg ; rax != 0
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

;rdi - string
;rsi - dst variable adress
;rax - 0 if correct, 1 if error
str_to_int64:
    push        rbp
    mov         rbp, rsp
.start:
    xor         r8, r8 ; tmp 
    mov         r10, 0 ; negative flag
    mov         r11, 0 ; result
    cmp         byte [rdi], "-"
    jne         .nextc
.set_neg:
    mov         r10b, 1
    inc         rdi
.nextc:
    sub         byte [rdi], 48 ; digit -= '0'
    cmp         byte [rdi], 0 ; digit < 0 ?
    jl          .error
    cmp         byte [rdi], 9 ; digit > 9 ?
    jg          .error
.adding:
    imul        r11, 10 ; num *= 10
    mov         r8b, byte [rdi] ; tmp = *ptr
    add         r11, r8 ; num += tmp
    inc         rdi
.check_end:
    cmp         byte [rdi], 0 
    je          .before_finish
    jmp         .nextc
.before_finish:
    cmp         r10, 0 ; neg == false ?
    jne         .neg_finish
    jmp         .finish
.neg_finish:
    neg         r11 ; num = -num
.finish:
    mov         rax, 0
    mov         qword [rsi], r11 ; *dst = num
    leave
    ret
.error:
    mov         rax, 1
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

;rdi - buffer
;rsi - length
;TODO: make normal string reading
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
    cmp         al, 10
    je          .done

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
