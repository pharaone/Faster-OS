{\rtf1\ansi\ansicpg1252\cocoartf1555
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red236\green236\blue236;}
{\*\expandedcolortbl;;\cssrgb\c94118\c94118\c94118;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs26 \cf0 \cb2 \expnd0\expndtw0\kerning0
BITS 16\
\
start:\
	mov ax, 07C0h		; Set up 4K stack space after this bootloader\
	add ax, 288		; (4096 + 512) / 16 bytes per paragraph\
	mov ss, ax\
	mov sp, 4096\
\
	mov ax, 07C0h		; Set data segment to where we're loaded\
	mov ds, ax\
\
\
	mov si, text_string	; Put string position into SI\
	call print_string	; Call our string-printing routine\
\
	jmp $			; Jump here - infinite loop!\
\
\
	text_string db 'This is my cool new OS!', 0\
\
\
print_string:			; Routine: output string in SI to screen\
	mov ah, 0Eh		; int 10h 'print char' function\
\
.repeat:\
	lodsb			; Get character from string\
	cmp al, 0\
	je .done		; If char is zero, end of string\
	int 10h			; Otherwise, print it\
	jmp .repeat\
\
.done:\
	ret\
\
\
	times 510-($-$$) db 0	; Pad remainder of boot sector with 0s\
	dw 0xAA55		; The standard PC boot signature}