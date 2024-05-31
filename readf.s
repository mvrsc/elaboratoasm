.section .data
filename: 
	.string "ordini.txt"	
fd:
	.long 0	
char:
	.string ""	
.section .text
	.global _start

_start:

	###############
	#APRI FILE	
	movl $5, %eax #syscall apri file
	leal filename, %ebx #indirizzo del file in ebx
	xorl %ecx, %ecx #azzero ecx perché read only
	int $0x80
	#ora ho l'indirizzo del file in eax
	movl %eax, fd

writechar:
	################
	#LEGGI CHAR
	movl $3, %eax #syscall read
	movl fd, %ebx #leggi da fd
	movl $char, %ecx #quello che leggi va messo in char
	movl $1, %edx #leggi un solo carattere
	int $0x80
	
	cmpl $0, %eax
	jle EXIT
	
	###################
	#SCRIVI CARATTERE 
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	movl $char, %ecx # metti il messaggio in ECX
	movl $1, %edx #lunghezza del messaggio in EDX
	int  $0x80
	
	jmp writechar

EXIT:	
	#############
	#CHIUDI FILE
	movl $6, %eax # SYS CLOSE
	movl fd, %ebx # chiudi questo file qua
	int  $0x80
	

	#######################
	#CHIUDI PROGRAMMA
	movl $1, %eax # exit(0)
	movl $0, %ebx
	int  $0x80

