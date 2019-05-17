name "strings"

org 100h
  
jmp start

    str1 db "sssARTsss$"
    str2 db "ART$"
    symbol db ?
    counter db 0 
    positivemsg db "founded!$"
    negativemsg db "not founded!$" 
    
start:
   
    mov cx, 9           ; str1 length
    mov si, offset[str1]
    mov di, offset[str2]
    cld
    
    mainlo:
        cmpsb
        je incrementCounter ; if 1 symbol not match
        dec di
        mov dl, counter
        sub di, dx          ; sub from di counter value
        mov counter, 0              
        loop mainlo         ; continue to search
        jmp str_ended
        incrementCounter:
        cmp counter, 02      ; cmp with str2 length-1
        jne notfoundedyet
        mov dx, offset positivemsg  ; output that word is founded
        mov ah, 09h
        int 21h
        ret
        notfoundedyet:
        inc counter
        loop mainlo
str_ended:        
mov dx, offset negativemsg  ; output that word is founded
mov ah, 09h
int 21h 
        
ret




