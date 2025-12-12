compile:
	nasm -f bin $(FILE).asm -o $(FILE).bin

burn:
	dd if=/dev/zero of=floppy.img bs=512 count=2880
	dd if=$(FILE).bin of=floppy.img bs=512 count=1 conv=notrunc

run:
	qemu-system-i386 -fda floppy.img -boot a -m 16

all: compile burn run
