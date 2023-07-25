section .data
    ; numbers of system calls
    NR_create   equ 85 ; creat syscall

    ; roles of access
    S_IRUSR             equ 00400q   ; owner can read
    S_IWUSR             equ 00200q   ; owner can write

    filename            db  "testfile.txt", 0
    error_create        db  "error creating file", 10, 0
    success_create      db  "file created and opened", 10, 0
    FD                  dq  0 ; file descriptor
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, filename
    call    createFile
    mov     qword [FD], rax ; file descriptor
    
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

;creates and openes file with [rdi] name, prints message
;returns descriptor in [rax]
global createFile
createFile:
    mov     rax, NR_create ; number of sys call
    mov     rsi, S_IRUSR | S_IWUSR ; roles
    syscall

    cmp     rax, 0
    jl      create_error
    mov     rdi, success_create
    push    rax
    call    prints
    pop     rax
    
    ret

create_error:
    mov     rdi, error_create
    call    prints
    ret

