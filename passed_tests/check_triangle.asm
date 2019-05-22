use16  

org 100h
jmp start

a db ?
b db ?
c db ?
sum db ?
 equality db 'Triangle is ravnostoronniy $'
    ravnobedr db 'Triangle is ravnobedrenniy $'
    raznostor db 'Triangle is raznostronniy $'
    impossible db 'Triangle can not exist $'

 start:
 
 mov [a],5
 mov [b],4
 mov [c],1  
 
 ; check if triangle is possible
 mov bl,[a]
 mov [sum],bl
 mov bl,[b]
 add [sum],bl
 mov bl,[c]
 cmp [sum],bl     ; if sum is lower then 3 side -> jump into imossible condition 
 jle not_possible
 mov bl,[a]
 mov [sum],bl
 mov bl,[c]
 add [sum],bl
 mov bl,[b]
 cmp [sum],bl
 jle not_possible
 mov bl,[b]
 mov [sum],bl
 mov bl,[c]
 add [sum],bl
 mov bl,[a]
 cmp [sum],bl
 jle not_possible   
 
 ; check for ravnostor/ravnobedr/simple'
 mov bl,[b]
 cmp [a],bl
 jne not_equal1
 mov bl,[c]
 cmp [a],bl
 je equal       ; a = b and c = a
 jmp ravnob     ; a = b ravnobedr
  not_equal1:   ; a != b...
  mov bl,[c] 
 cmp [a],bl
 je ravnob      ; c = a ravnobedr
 mov bl,[b]
 cmp [c],bl
 je ravnob      ; b = c ravnobedr 
 
 
 jmp razno  ; a != b and b !=c and c != a
 
 
 
 equal: 
   mov ah,9
   mov dx,equality
   int 21h
   ;mov ax,4C00h
   ;int 21h
   ret
 
 
 razno:
   mov ah,9
   mov dx,raznostor
   int 21h
  ; mov ax,4C00h
  ; int 21h
   ret
 
 
  ravnob:
   mov ah,9
   mov dx,ravnobedr
   int 21h
  ; mov ax,4C00h                 
   ;int 21h 
   ret
   
   
   not_possible:
   mov ah,9
     mov dx,impossible
     int 21h
    ; mov ax,4C00h
     ;int 21h
     ret



