name "stack params" 

org 100h 

jmp start 

str1 db "Hello $" 
str2 db "my dear $" 
str3 db "friend", 0Dh, 0Ah, '$'

start: 
mov cx, 3 

lo:  
    push offset str3 
    push offset str2 
    push offset str1
    call printStr
    loop lo 
    
; wait for any key press:
mov ah, 0
int 16h

ret 

printStr proc
    push bp
    mov bp, sp
    
    mov dx, [bp+4]  
    mov ah, 09h 
    int 21h
    
    mov dx, [bp+6]  
    int 21h
    
    mov dx, [bp+8] 
    int 21h
    
    pop bp   
ret 6 
endp

