###########################################################################
#
#	pop dei prodotti nello stack
#	stampa id e tempo in cui verra' mandato in produzione
#	aggiorna tempo considerando la produzione del prodotto appena letto
#	calcola eventuale penalita' in caso di ritardo
#	accumula penalita' e tempo in due variabili
#	stampa conclusione (tempo) e penalita'
#
############################################################################

.section .data

id:	
	.long 0
dur:	
	.long 0
scad:	
	.long 0
prior:  
	.long 0
conta_p:  #contatore di prodotti (= conta push) PARAMETRO CHE DEVE RICEVERE DAL MAIN
	.long 0
tempo:	# conto gli slot nella pianificazione 
	.long 0
penalty:	# accumulo le penalita'
	.long 0
car:	#char per la stampa
	.byte 0
conclusione: 
	.ascii "Conclusione: "
conclusione_len:
	.long . - conclusione
penalty_str:
	.ascii "Penalty: ""
penalty_len:
	.long . - penalty_str


 


.section .text			#### cambiare in function
	.global output
	
.type output, @function

output:

##########################################################
# pop prodotto
# stampa id pianificazione
# calcolo penalita'
##########################################################



#### VALORIZZARE CONTA_P 
	popl %ebp
	movl %edi, conta_p


pop_prodotto:
	cmpl $0, conta_p
	je stampa_conclusione
	popw %ax
	movb %al, prior
	movb %ah, scad
	popw %ax
	movb %ah, id
	movb %al, dur
	decl conta_p

stampa_pianficazione:		
#stampa id:tempo (stampa prima di aggiornare la variabile tempo)
	
	xorl %eax, %eax
	movl id, %eax
	call itoa 			##########################	call di	itoa (da modificare eventualmente)
	#stampa i due punti
	movl   $4, %eax
	movl   $1, %ebx
	movb $58, car
	leal  car, %ecx		
	movl    $1, %edx
	int $0x80
	
	xorl %eax, %eax
	movl tempo, %eax
	call itoa			##########################	call di	itoa (da modificare eventualmente)
	#stampa \n
	movl   $4, %eax
	movl   $1, %ebx
	movb $10, car
	leal  car, %ecx		
	movl    $1, %edx
	int $0x80

	
calcola_tempo:
	movb tempo, %bl
	addb dur, %bl
	movb %bl, tempo
	
calcola_penalty:
	cmp scad, %bl
	jle pop_prodotto
	sub scad, %bl # tempo - scadenza = slot che superano la scadenza (vanno in bl)
	xorl %eax, %eax
	movb prior, %al
	mul %bl
	addw %ax, penalty
	jmp pop_prodotto

stampa_conclusione:
	movl   $4, %eax
	movl   $1, %ebx
	movb $10, car
	leal  conclusione, %ecx		
	movl    conclusione_len, %edx
	int $0x80
	movl tempo, %eax
	decl %eax #perche' conta anche lo slot 0
	call itoa
	#stampa \n
	movl   $4, %eax
	movl   $1, %ebx
	movb $10, car
	leal  car, %ecx		
	movl    $1, %edx
	int $0x80
	
stampa_penalty:
	movl   $4, %eax
	movl   $1, %ebx
	movb $10, car
	leal  penalty_str, %ecx		
	movl   penalty_len, %edx
	int $0x80
	movl penalty, %eax
	call itoa
	#stampa \n
	movl   $4, %eax
	movl   $1, %ebx
	movb $10, car
	leal  car, %ecx		
	movl    $1, %edx
	int $0x80
	

fine:
	pushl %ebp
	ret
