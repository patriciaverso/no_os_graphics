# Graphics without OS
Current state:

![Screenshot from QEMU displaying a yellow square inside a red square inside a black background](./images/yellow_red_squares.png)

## Notes
;; 1 - changes ASM to 16-bit real mode (BIOS default) [1]
BITS 16
;; 2 - moves start of program to address 0x7C00 (BIOS starts there) [1]
ORG 0x7C00
;; 3 - move 13 to AX to set the video mode 13 (320x200 - 256 colors [2]
mov ax, 0x0013
int 0x10
;; 4 - move A000 to AX to set ES as the VGA Framebuffer address [2]
mov ax, 0xA000
mov es, ax
;; 5 - clear screen starting (di = 0 = start of framebuffer, al = 0 = black, cx = 320*200 = number of addresses to repeat command, repeat stosb cx times) [4]
xor di, di
mov al, 0
mov cx, 320*200
rep stosb
;; 6 - draw red square calling draw_square (al = read, bx = x_start, dx = y_start, bp = width, si = height) [6]
mov al, 12
mov bx, 20
mov dx, 20
mov bp, 100 
mov si, 100
call draw_square
