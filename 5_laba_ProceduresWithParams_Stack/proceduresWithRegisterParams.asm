name "register params" 

org 100h 

jmp start 

a dw ?

start: 
mov cx, 4
mov a, 1

lo: 
    mov ax, a  
    call printABC 
    inc a
    loop lo 
    
; wait for any key press:
mov ah, 0
int 16h
                             
ret 

printABC proc
cmp ax, 0
jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_ax_r:
    pusha
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx    
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pn_done
pn_done:
    popa  
    ret  
endp   

