name "strings"

org 100h
  
jmp start

    str1 db "********************$"
    str2 db "---------------$"
    
start:

    mov cx, 10
    mov si, offset[str2] + 5
    mov di, offset[str1] + 3
    cld
    
    rep movsb           ; si <- di 
    
    mov dx, offset str1
    mov ah, 09h
    int 21h


ret




