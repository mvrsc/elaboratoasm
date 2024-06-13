

pianificatore: main.o hpf.o read_push.o
	ld -m elf_i386 read_push.o hpf.o main.o -o pianificatore

main.o: main.s
	as --32 -gstabs -o main.o main.s
	
hpf.o: hpf.s
	as --32 -gstabs -o hpf.o hpf.s

read_push.o: read_push.s
	as --32 -gstabs -o read_push.o read_push.s
	
	

	
