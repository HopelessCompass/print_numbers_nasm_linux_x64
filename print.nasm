global _start

section .rodata
    
section .data
    x: dq 0
    temp: dq 1
    minus: dq '-', 0
    
section .text

; number from -9 to 9
; Внутри функции запрещено менять регистры 
; RBX, RSP, RBP и R12–R15, 
; в соответствии со стандартном Linux 64-bit.

print_number:
    mov rax, 1          
    mov [x], rdi
    cmp rdi, 0
    jl .less
    jmp .space
    
.less:
    mov [temp], rdi
    
    mov rax, 1
    mov rdi, 1
    mov rsi, minus
    mov rdx, 1
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, [temp]
    mov rdx, 1
    syscall
    
    mov rdi, [temp]
    ret

.space:
    add byte [x], '0'
    mov rsi, x
    mov byte [rsi + 1], ' '
    mov rdi, 1          
    mov rdx, 2          
    syscall
    ret

_start:
    mov rdi, 5
    call print_number
    mov rdi, -7
    call print_number
    
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
