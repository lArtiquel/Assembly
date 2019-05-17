; TASK: FIND NUMBER OF ENTRIES OF THE WORD
name "asm_work_with_files"  

; general rules for file system emulation:

; 1. the emulator emulates all drive paths in c:\emu8086\vdrive\
;    for example: the real path for "c:\test1" is "c:\emu8086\vdrive\c\test1"

; 2. paths without drive letter are emulated to c:\emu8086\MyBuild\
;    for example: the real path for "myfile.txt" is "c:\emu8086\MyBuild\myfile.txt"

; 3. if compiled file is running outside of the emulator rules 1 and 2 do not apply.

org 100h  

jmp     start 

word db "word", '$'           ; word to search  
word_len = $ - word
file db "myfile.txt", 0           ; filename
buffer db 1024 dup(?)         ; buffer for data
buffer_len = $ - buffer
anyKeyMessage db 0Dh, 0Ah, "press any key", 0Dh,0Ah,'$' ; any key message 
message db "finded entries: ", '$'      ; entries message
numOfWords dw 0


start:

    ; open file
    mov dx, offset file
    mov ah, 3Dh
    mov al, 00h      ; just reading mode
    int 21h
    
    jc exit          ; carry flag == 0
    mov bx, ax       ; bx = file identidier
    mov di, 01       ; di = STDOUT identifier
    
    ; read data and write it to STDOUT
    read_data:
        mov cx, 1024     ; block data length
        mov dx, offset buffer  
        mov ah, 3Fh
        int 21h;         ; read 16 bytes from file 
        jc close_file    ; close file if error
        mov cx, ax       ; cx = number of readed bytes
        jcxz close_file  ; if cx = 0(EOF) -> close file
        ; print reade from file data
        ; xchg di, bx      ; bx = 1 -- STDOUT idenifier
        ; int 21h          ; write to stdout
        ; xchg di, bx      ; bx = file identifier    
        ; jc close_file    ; if failed to write -> close_file
        
        ; try to find word
        lea di, buffer   ; put di offset to word str 
        mov dx, 0        ; num of char to compare  
        lea si, word
          
        next_char:  
            mov al, [di]
            mov bl, [si]
            inc di 
            cmp al, bl
            call char_equ
        loop next_char    
    
    jmp read_data    ; read another block of data
    
    close_file:
    mov ah, 3Eh
    int 21h 
    
    ; write number of entries message
    mov ah, 9
    mov dx, offset message 
    int 21h    
    ; and then put number into ax, then print it
    mov ax, numOfWords
    call print_ax
    
     
    ; write any key message
    mov ah, 9
    mov dx, offset anyKeyMessage 
    int 21h 
    ; wait for any key....        
    mov     ah, 0 
    int     16h        
    
    exit:
        ret

char_equ proc               ; if chars are equal
    inc si
    inc dx
    cmp dx, word_len
    je word_finded          ; IF THE WORD FINDED
        ret
    word_finded:            ; try to find another word
        mov dx, 0 
        sub si, buffer_len
        inc numOfWords
        ret
endp 
                            
print_ax proc               ; to print AX register
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