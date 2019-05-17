     ; a+(b-c)/d
org 100h  

name "my prg" 

jmp start ; go to code...

.data
msg db "result: $"
a dw 7
b dw 6
c dw 2
d db 2

.code
start:

mov dx, offset msg
mov ah, 09h
int 21h

mov ax, b
sub ax, c 
mov dh, d
div dh
add ax, a 

; unsigned decimal
call print_ax

; wait for any key func
mov ah, 1
int 21h 

ret 

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
