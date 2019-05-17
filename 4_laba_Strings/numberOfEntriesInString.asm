name "strings"

org 100h
  
jmp start

    str db "s-ss--*-*r$"
    symbol db ?
    counter db 0
    
start:
    mov symbol, 's'       ; enter symbol to search
    
    mov cx, 10
    mov si, offset[str] ; put into si offset
    mov bl, symbol      ; into bh symbol
    lo:
        lodsb           ; it will increment si and put byte into al
        cmp al, bl
        jne noincrement
        inc counter
        noincrement:
        loop lo
        
    mov al, counter

ret




