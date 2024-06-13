.section .data
filename: 
	.string ""	

.section .text
	.global _start

_start:
	####################
	#LEGGI PARAMETRO

	movl %esp, %ecx #metti l'indirizzo dello stack in ecx
	addl $8, %ecx #scorri indietro di 2 posizioni
	movl (%ecx), %ebx #l'indirizzo del file è ora in ebx
	
	call read_push
	
	call hpf
	#######################
	#CHIUDI PROGRAMMA
	movl $1, %eax # exit(0)
	movl $0, %ebx
	int  $0x80

