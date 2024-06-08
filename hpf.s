.section .data
#testbench di 4 elementi
a:
	.long 0b00000100000010100000110000000100 #4,10,12,4
	
b: 
	.long 0b00001100000001110010000000000001 #12,7,32,1

c:
	.long 0b00000010000001100000100100001100 #2,6,9,12

d:
	.long 0b00000011000010000000110000001000 #3,8,12,8

e:
	.long 0b00010111000100000000001000000101 #23,16,2,5

f:
	.long 0b00001100010001100001010100000011 #12,70,21,3

	
len: 
	.long 6 #



.section .text
	.global _start
	
_start:
	
	###################
	#CARICO IL TESTBENCH NELLO STACK

	movl a, %eax
	pushl %eax
	movl b, %eax
	pushl %eax
	movl c, %eax
	pushl %eax
	movl d, %eax
	pushl %eax
	movl e, %eax
	pushl %eax
	movl f, %eax
	pushl %eax
	
	#################################################
	#RICERCA DELLA PRIORITA' MASSIMA
	#SORTING DELLO STACK
	#per fare il sorting dello stack realizzo un algoritmo abbastanza intuitivo
	#che fa uso di nested loops
	#uso edi per salvare il mio indice massimo
	#uso ecx come contatore per il loop esterno
	#quindi quando ecx raggiunge il valore limite in edi usciamo dal loop
	#uso eax come contatore del loop interno
	#quando eax raggiunge il valore limite in edi salviamo il valore trovato
	#nell'indirizzo puntato da ecx 
	#poi incrementiamo ecx e continuiamo la ricerca

	movl len, %edi 	#uso edi per salvare il mio indice massimo
	xorl %ecx, %ecx #azzero ecx che mi servirà da contatore


loop_esterno:
	cmpl %ecx, %edi #se il contatore esterno è arrivato all'ultimo numero esco
		je fine
	movl (%esp, %ecx, 4), %ebx #carico il primo numero da confrontare
	movl %ecx, %eax #setto il contatore interno uguale a quello esterno

loop_interno:
	movl (%esp, %eax, 4), %edx #carico in edx il valore da confrontare con il nostro minimo corrente
	cmpb %dl, %bl #confronto questi due registri perché mi interessa il campo PRIORITA'
		jl nuovo_massimo		
	continua:
	inc %eax 
	cmpl %eax, %edi #controlliamo di non uscire dalla memoria che ci interessa
		je uscita_loop_interno	
	jmp loop_interno
	
nuovo_massimo:
	xchg (%esp, %eax, 4), %ebx
	jmp continua

uscita_loop_interno:
	movl %ebx, (%esp, %ecx, 4) #salvo il valore trovato nell'indirizzo indicato da ecx
	inc %ecx #incremento ecx prima di continuare la ricerca
	jmp loop_esterno

fine:
	popl %eax
	popl %eax
	popl %eax
	popl %eax
	popl %eax
	popl %eax
	#######################
	#CHIUDI PROGRAMMA
	movl $1, %eax # exit(0)
	movl $0, %ebx
	int  $0x80
	
	
