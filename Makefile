all:
	nasm -f elf32 start.asm -o start.o
	gcc -Wall -g -m32 -c kernel.c -o k.o
	ld -m elf_i386 -T link.ld -o boot/kernel.bin start.o k.o
	[ -d "isodir" ] || mkdir isodir
	cp boot/kernel.bin isodir
	cp boot/grub.cfg isodir
	grub-mkrescue -o Zildj1anOS.iso isodir
	rm -rf isodir
	rm start.o
	rm k.o
	qemu-system-x86_64 -cdrom Zildj1anOS.iso
