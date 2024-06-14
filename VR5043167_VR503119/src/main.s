.section .data

inizio:
	.string "Inserisci 1 per EDF, 2 per HPF, 3 per uscire.\n"
inizio_len:
	.long . -inizio
	
err_input:
	.string "hai inserito un carattere non valido\n"
err_input_len:
	.long . -err_input
	
err_param:
	.string "Errore! Questo programma richiede esattamente un file di testo come parametro\n"
err_param_len:
	.long . -err_param

.section .bss
input:
	.string ""

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
	je EXIT
	
selezione:	
	########################
	#SCRIVI MESSAGGIO	
	call print_menu

	
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


	#######################
	#TORNA AL MENU SE LA SELEZIONE NON E' VALIDA
input_error:
	call print_input_err
	jmp selezione
	
	#######################
	#ESCI SE NON HAI UN FILE DA APRIRE O NE HAI TROPPI
param_error:
	call print_param_err
	jmp EXIT

