.section .data

inizio:
	.string "Inserisci 1 per EDF, 2 per HPF, 3 per uscire.\n"
inizio_len:
	.long . -inizio
	
err_input:
	.string "hai inserito una combinazione di caratteri non valida\n"
err_input_len:
	.long . -err_input

.section .bss
input:
	.byte 0

.section .text
	.global _start

_start:
	####################
	#LEGGI PARAMETRO

	movl %esp, %ecx #metti l'indirizzo dello stack in ecx
	addl $8, %ecx #scorri indietro di 2 posizioni
	movl (%ecx), %ebx #l'indirizzo del file è ora in ebx
	
	call read_push
	
selezione:	
	########################
	#SCRIVI MESSAGGIO
	
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal inizio, %ecx # metti il messaggio in ECX
	movl inizio_len, %edx #lunghezza del messaggio in EDX
	int  $0x80

	########################
	#LEGGI INPUT UTENTE
	movl $3, %eax # 3 = syscall READ
	movl $0, %ebx # 0 = read from keyboard
	leal input, %ecx # metti quello che leggi in input
	movl $1, %edx #leggi un carattere solo
	int  $0x80

	########################
	#SELEZIONE

	cmpb $49, input
		je sel_EDF
	cmpb $50, input
		je sel_HPF
	cmpb $51, input
		je EXIT
	
	jmp input_error
		
	

sel_EDF:
	call edf
	jmp calcola	
	
sel_HPF:	
	call hpf

calcola:
	call output
	
EXIT:

	movl $1, %eax # exit(0)
	movl $0, %ebx
	int  $0x80

	#######################
	#TORNA AL MENU SE LA SELEZIONE NON E' VALIDA
input_error:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal err_input, %ecx # metti il messaggio in ECX
	movl err_input_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	jmp selezione
	
	


