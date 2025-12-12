BITS 16
ORG 0x7C00

start:
	mov ax, 0x0013
	int 0x10

	mov ax, 0xA000
	mov es, ax

	xor di, di
	mov al, 0
	mov cx, 320*200
	rep stosb

	mov al, 12
	mov bx, 20
	mov dx, 20
	mov bp, 100 
	mov si, 100
	call draw_square

	mov al, 14
	mov bx, 50
	mov dx, 50
	mov bp, 25
	mov si, 25
	call draw_square

hang:
	cli
	hlt
	jmp hang

draw_hline:
	mov di, dx
	shl di, 8
	mov si, dx
	shl si, 6
	add di, si
	add di, bx
	rep stosb
	ret

draw_vline:
	mov di, dx
	shl di, 8
	mov si, dx
	shl si, 6
	add di, si
	add di, bx
draw:
	mov es:[di], al
	add di, 320
	dec cx
	jnz draw
	ret

; x on bx
; y on dx
; width on bp
; height on si
; color on al
draw_square:
	push ax
	mov di, dx
	shl di, 8
	mov ax, dx
	shl ax, 6
	add di, ax
	add di, bx
	; clamp width
	mov ax, 320
	sub ax, bx
	cmp bp, ax
	jle ok_length
	mov bp, ax
ok_length:
	mov ax, 200
	sub ax, dx
	cmp si, ax
	jle ok_width
	mov si, ax
ok_width:
	pop ax
loop_square:
	mov cx, bp
	rep stosb
	add di, 320
	sub di, bp
	dec si
	jnz loop_square
	ret

times 510-($-$$) db 0
dw 0xAA55
