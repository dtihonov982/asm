extern printf
extern c_area
extern c_circum
extern r_area
extern r_circum

global pi

section .data
    pi      dq  3.141592654
    R       dq  10.0
    a       dq  4
    b       dq  5
    fmtf    db  "%f",10,0
    fmti    db  "%d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    
    ;circle area
    movsd xmm0, qword [R]
    call c_area

    mov rdi, fmtf
    mov rax, 1
    call printf

    ;circle circum
    movsd xmm0, qword [R]
    call c_circum

    mov rdi, fmtf
    mov rax, 1
    call printf

    ;rectangle area
    mov rdi, [a]
    mov rsi, [b]
    call r_area
    
    mov rdi, fmti
    mov rsi, rax
    xor rax, rax
    call printf

    ;rectangle circum
    mov rdi, [a]
    mov rsi, [b]
    call r_circum

    mov rdi, fmti
    mov rsi, rax
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp
    ret





