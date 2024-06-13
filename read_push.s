###########################################################################

#funzione che legge il file degli ordini e copia i valori nello stack


#		LOOP fino a EOF
# loop read_char fino a \n
	# loop read_char fino a ,
	# leggi stringa e converti in mumero (variabile num)
	# quando leggi virgola conta quanti campi del prodotto hai gia' letto (0, 1 o 2)
	# 0 campi letti -> hai appena letto il primo campo (id)
	# 1 campi letti -> hai appena letto il secondo campo (durata)
	# 2 campi letti -> hai appena letto il terzo campo (scadenza)
# quando leggi \n trasferisci i campi letti in AX due alla volta (in AL e in AH) e fai push su stack (x2)
# quando arrivi a EOF fai push degli ultimi campi letti e chiudi file 

############################################################################

.section .data

filename: 
	.string "ordini.txt"	
fd:
	.long 0	
char:
	.string ""
num:	#variabile in cui converto la stringa in numero
	.long 0
id:	#variabile in cui sposto num per fare la push
	.long 0
dur:	#variabile in cui sposto num per fare la push
	.long 0
scad:	#variabile in cui sposto num per fare la push
	.long 0
prior:	#variabile in cui sposto num per fare la push
	.long 0
conta_c:	#contatore dei campi letti per fare pushw di AX su stack 
	.long 0
conta_p:	#conta quanti prodotti ho inserito da passare come valore per il SORTING (conta le push eseguite)
	.long 0

.section .text			#### cambiare in function
	.global read_push
	
.type read_push, @function

read_push:

	popl %edi #salvo in edi l'indirizzo dell'istruzione da chiamare a fine funzione

##########################################################

#				APRI FILE	

##########################################################

	movl $5, %eax #syscall apri file
	#l'indirizzo del file è stato messo in ebx dal chiamante
	#//leal filename, %ebx #indirizzo del file in ebx
	xorl %ecx, %ecx #azzero ecx perche' read only
	int $0x80
	
	movl %eax, fd 	#indirizzo file in eax
		
	cmp $0, %eax   #in caso di errore apertura chiude file
	jle close_file
	


#########################################################

#				LEGGI FILE e PUSH su STACK

#########################################################

readchar_loop:
	movl $3, %eax #syscall read
	movl fd, %ebx #leggi da fd
	movl $char, %ecx #quello che leggi va messo in char
	movl $1, %edx #leggi un solo carattere
	int $0x80
	cmp $0, %eax        # Controllo se ci sono errori o EOF
		je fine_file     

	xorl %ebx, %ebx
	movb char, %bl 	#metto in bl il char letto dal file
	cmp $13, %bl    #lavorando in windows mette sia 13 che 10 alla fine della linea (CRLF)
		je readchar_loop
	cmp $10, %bl	# vedo se e' stato letto il carattere '\n'
		je fine_riga	# se ho letto \n vado alla push
	cmp $44, %bl    # vedo se e' stato letto il carattere ','
		je fine_campo	# se ho letto ',' controllo quanti campi ho letto

	
	subb $48, %bl            # converto il codice ASCII della cifra nel numero corrispondente
	movl $10, %edx
	movl num, %eax		#metto in EAX il numero letto finora
	mulb %dl                # EAX = EAX * 10 (alla prima occorrenza ho EAX=0)
	addl %ebx, %eax		  # sommo EBX (ultima cifra letta) a EAX (e la somma va in EAX)
	movl %eax, num		#metto in num il valore aggiornato
	jmp readchar_loop	#leggo il carattere seguente

fine_campo:
# se ho letto ',' controllo quanti campi ho letto per capire che variabile valorizzare
	cmpl $0, conta_c		
	jne durata
	incl conta_c	# incremento numero campi lette
	movl num, %eax
	movl %eax, id	
	movl $0, num #azzero num
	jmp readchar_loop # leggo il carattere successivo (cioe' la campo successiva)

durata:
	cmpl $1, conta_c
	jne scadenza
	incl conta_c # incremento numero campi letti
	movl num, %eax
	movl %eax, dur
	movl $0, num #azzero num
	jmp readchar_loop

scadenza:
	movl num, %eax
	movl %eax, scad
	movl $0, num #azzero num
	jmp readchar_loop	
	

fine_riga:		# push dei valori letti sullo stack
	
	movb id, %ah
 	movb dur, %al
	pushw %ax	
 	movl num, %eax
	movl %eax, prior
	movb scad, %ah
 	movb prior, %al
	pushw %ax	
	movl $0, conta_c #azzero contatore campi letti
	movl $0, num #azzero num
	movl $0, id
	movl $0, dur
	movl $0, scad
	movl $0, prior
	incl conta_p	#incremento numero prodotti caricati
	jmp readchar_loop

fine_file:	# push dei valori letti sullo stack e fine read_char loop
#eventualmente invertire ordine (vedere ordine nel sorting)


/* QUESTA PARTE NON SERVE PER FILE DI TESTO FORMATTATI PER LINUX
	movl num, %eax
	movl %eax, prior
	movb id, %ah
 	movb dur, %al
	pushw %ax	
 	movl num, %eax
	movl %eax, prior
	movb scad, %ah
 	movb prior, %al
	pushw %ax	
	incl conta_p	#incremento numero prodotti caricati
*/


#############################

#		CHIUDI FILE

#############################

close_file:	
	movl $6, %eax # SYS CLOSE
	movl fd, %ebx # chiudi questo file qua
	int  $0x80
	
	pushl %edi #rimetto in cima allo stack l'indirizzo della funzione da chiamare
	
	movl conta_p, %edi #metto la lunghezza in edi per chiamare l'algoritmo di sorting
	
	ret


  
