.386
.model flat, stdcall
.stack 4096
option casemap : none

includelib kernel32.lib
includelib user32.lib

ExitProcess		PROTO, dwExitCode :DWORD
GetStdHandle	PROTO :DWORD						; handler's number
WriteConsoleA	PROTO :DWORD,						; descriptor
				:PTR BYTE,							; pointer to message buffer
				:DWORD,								; message buffer size
				:PTR DWORD,							; place to write
				:DWORD								; flags
ReadConsoleA PROTO hConsoleInput:DWORD,				; https://docs.microsoft.com/en-us/windows/console/readconsole
				   lpBuffer2:PTR BYTE,
				   nNumberOfCharsToRead:DWORD,
				   lpNumberOfCharsRead:PTR DWORD,
				   pInputControl:PTR BYTE
;wsprintf	PROTO :PTR BYTE,
;			:PTR BYTE,
;			:DWORD


BSIZE equ 5											; array size
NUMBUFSIZE equ 15									; output number buffer size
STD_INPUT_HANDLE equ -10							; https://docs.microsoft.com/en-us/windows/console/getstdhandle
STD_OUTPUT_HANDLE equ -11							; define std output handle var
NULL equ 0

.data
ifmt			BYTE "%d", 0
buf				BYTE NUMBUFSIZE dup(?)
digit			DWORD ?
inputBuffer		BYTE NUMBUFSIZE dup(?)
stdout			DWORD ?								; std out descriptor
stdin			DWORD ?								; std in descriptor
PrimeNumbers	DWORD 1, 2, 3, 4, 5					; array
msg				BYTE "Sum of el'ts of array: ", 0dh, 0ah
cWritten		DWORD ?								; addr to write string

.code
main PROC
; -------------------------------------
mov ecx, BSIZE				; put into edx array size
mov eax, 0
mov edi, 0

next:						; get through the array and sum el-ts
	add eax, PrimeNumbers[edi]
	add edi, 2
loop next

mov digit, eax										; remember in register

invoke GetStdHandle, STD_OUTPUT_HANDLE				; get output handle
mov stdout, eax
invoke GetStdHandle, STD_INPUT_HANDLE				; get input handle
mov stdin, eax


invoke WriteConsoleA, stdout, offset msg, sizeof msg, offset cWritten, 0				; write message	to console	
;invoke wsprintf, offset buf, offset ifmt, digit								
invoke WriteConsoleA, stdout, offset buf, sizeof buf, offset cWritten, 0				; write message	to console
invoke ReadConsoleA, stdin, offset inputBuffer, NUMBUFSIZE, offset cWritten, 0			; kinda system("pause")

push 0																				; invoke ExitProcess with DWORD param
call ExitProcess
; -------------------------------------
main ENDP
END main