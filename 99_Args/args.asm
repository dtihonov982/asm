section .data
    NL      db     10
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    push    r12
    push    r13

    mov     r12, rsi ; char **argv
    mov     r13, rdi ; argc

.loop:
    test    r13, r13 ; while (argc > 0)
    jz      .done

    mov     rdi, qword [r12] ; rdi = *argv
    call    prints     ; print(rdi)

    mov     rdi, NL
    call    prints

    dec     r13    ; argc--
    add     r12, 8 ; argv++

    jmp     .loop

.done:
    pop     r13
    pop     r12
    leave
    ret

;prints a string on addess [rdi]
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

