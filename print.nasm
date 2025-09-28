global _start

section .rodata
    
section .data
    temp: dw ?
    minus: db '-', 0
    
section .text

; number from -9 to 9
; Внутри функции запрещено менять регистры 
; RBX, RSP, RBP и R12–R15, 
; в соответствии со стандартном Linux 64-bit.

cook_syswrite_registers:
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    ret
    
print_positive_number:
    mov [temp], di
    add byte [temp], '0'
    mov byte [temp + 1], ' '
    
    mov rax, 1
    mov rsi, temp
    mov rdi, 1          
    mov rdx, 2          
    syscall
    
    ret                  

print_number:
    mov [temp], di
    
    cmp rdi, 0
    jl .less
    call print_positive_number    ; x >= 0
    ret
    
.less:
    call cook_syswrite_registers
    
    mov rsi, minus
    syscall
    
    movzx rax, word [temp]
    mov rcx, -1
    mul rcx
    mov [temp], ax
    add byte [temp], '0'
    mov byte [temp + 1], ' '
    mov rax, 1
    mov rsi, temp
    mov rdx, 2
    syscall
    
    ret
    
; main
_start:
    mov rdi, -1
    call print_number
    mov rdi, 7
    call print_number
    
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
