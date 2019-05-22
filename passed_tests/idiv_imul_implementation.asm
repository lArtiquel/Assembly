name "someShit"

org 100h

; skipt data area:
jmp start

name "multiply and division"


;1) 2 multiply 2 (not mul)
;2) 2 division 2 (not div)  
a dw 8
b dw 0 

res db "result: $"
spaces db "  ", 0Dh, 0Ah, '$'
error0 db "division on zero$!"

start:

;call imultiply and idivision
call imultiply
call idivision


; wait for any key....
mov ah, 0
int 16h

ret ; return to operating system.

imultiply proc
    mov bx, b
    cmp bx, 0
    jne continue1
        mov dx, offset res
        mov ah, 9
        int 21h  
        
        mov ax, a
        call print_ax
        
        mov dx, offset spaces
        mov ah, 9
        int 21h
        ret  
        
    continue1:
        mov cx, b
        dec cx
        
        mov ax, a
        
        lo1:
            mov bx, a 
            add ax, bx
            loop lo1
       
        mov bx, ax
             
        mov dx, offset res
        mov ah, 9
        int 21h  
        
        mov ax, bx
        call print_ax
        
        mov dx, offset spaces
        mov ah, 9
        int 21h 
        
        ret
endp

idivision proc
    mov bx, b
    cmp bx, 0
    jne continue2
        mov dx, offset error0
        mov ah, 9 
        int 21h 
        ret
        
    continue2:     
        mov cx, 0
        lo2: 
            mov ax, a 
            mov bx, b
            sub ax, bx
             
            mov a, ax
            mov b, bx
            inc cx
            cmp a, 0
            jne lo2
           
        
        mov dx, offset res
        mov ah, 9
        int 21h  
        
        mov ax, cx
        call print_ax
        
        mov dx, offset spaces
        mov ah, 9 
        int 21h 
        
        ret
endp   

print_ax proc
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