extern  scanf
extern  printf
section .data
    fmt_out     db  "Enter a number:", 0
    fmt_in      db  "%d", 0
    fmt_result  db  "%d", 10, 0
section .bss
    N   resq    1
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    ;Getting a number
    mov     rdi, fmt_out
    mov     rax, 0
    call    printf

    mov     rdi, fmt_in
    mov     rsi, N
    mov     rax, 0
    call    scanf
    
    mov     rdi, qword  [N]
    call    fib

    mov     rdi, fmt_result
    mov     rsi, rax
    mov     rax, 0
    call    printf

    leave
    ret

fib:
    push    rbp
    mov     rbp, rsp

    ;save place for storage temporary values
    sub     rsp, 16
    ;save argument on stack
    mov     qword  [rbp - 8], rdi


    ;if x > 1 then jump
    cmp     rdi, 1
    jg      .L0

    ;if x <= 1 return x
    mov     rax, rdi
    jmp     .L1

.L0:
    ;fib(x-1)
    sub     rdi, 1
    call    fib

    ;save fib(x-1) on stack
    mov     qword  [rbp-16], rax

    ;restore x from stack
    mov     rdi, qword  [rbp - 8]
    ;call fib(x-2)
    sub     rdi, 2
    call    fib
    
    ;fix(x-1) + fib(x-2)
    add     rax, qword  [rbp-16]

.L1:
    leave
    ret
