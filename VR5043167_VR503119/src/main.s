.section .bss
input:
	.byte 

.section .text
	.global _start

_start:
	####################
	#CONTROLLA VALIDITA' PARAMETRO
	movl (%esp), %ebx
	cmpl $2, %ebx
	jne param_error

restart:
	####################
	#LEGGI PARAMETRO
	movl %esp, %ecx #metti l'indirizzo dello stack in ecx
	addl $8, %ecx #scorri indietro di 2 posizioni
	movl (%ecx), %ebx #l'indirizzo del file è ora in ebx

	####################
	#SCRIVI IL FILE NELLO STACK	
	call read_push
	cmpl $0, %edi #esco se la funzione mi ha restituito un errore
	je EXIT #il messaggio di errore è stato stampato dalla funzione
	
selezione:	
	########################
	#SCRIVI MESSAGGIO	
	call print_menu

	########################
	#LEGGI INPUT UTENTE
	movl $3, %eax # 3 = syscall READ
	movl $0, %ebx # 0 = read from keyboard
	leal input, %ecx # metti quello che leggi in input
	movl $20, %edx #leggo un buffer lungo di caratteri per evitare trailing input
	int  $0x80
	
	########################
	#SELEZIONE
	cmpb $49, input
		je sel_EDF
	cmpb $50, input
		je sel_HPF
	cmpb $51, input
		je EXIT	
	jmp input_error #se l'input non è valido comunicalo all'utente
	
sel_EDF:
	call edf	
	jmp calcola	
	
sel_HPF:
	call hpf

calcola:
	call output
	jmp  restart
	
EXIT:
	movl $1, %eax # exit(0)
	movl $0, %ebx
	int  $0x80

input_error:
	#######################
	#TORNA AL MENU SE LA SELEZIONE NON E' VALIDA
	call print_input_err
	jmp selezione
	
param_error:
	#######################
	#ESCI SE NON HAI UN FILE DA APRIRE O NE HAI TROPPI
	call print_param_err
	jmp EXIT

