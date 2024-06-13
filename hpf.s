.section .data

.section .text
	.global hpf
	
.type hpf, @function
	
hpf:
	
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
	#la dimensione dello stack da ordinare deve essere stato messo in EDI dall chiamante

	popl %esi #salvo in esi l'indirizzo dell'istruzione di ritorno
	xorl %ecx, %ecx #azzero ecx che mi servirà da contatore


loop_esterno:
	cmpl %ecx, %edi #se il contatore esterno è arrivato all'ultimo numero esco
		je fine
	movl (%esp, %ecx, 4), %ebx #carico il primo numero da confrontare
	movl %ecx, %eax #setto il contatore interno uguale a quello esterno

loop_interno:
	movl (%esp, %eax, 4), %edx #carico in edx il valore da confrontare con il nostro minimo corrente
	cmpb %dl, %bl #confronto questi due registri perché mi interessa il campo PRIORITA'
		je caso_uguale
		jl nuovo_massimo		
	continua:
	inc %eax 
	cmpl %eax, %edi #controlliamo di non uscire dalla memoria che ci interessa
		je uscita_loop_interno	
	jmp loop_interno
	
nuovo_massimo:
	xchg (%esp, %eax, 4), %ebx
	jmp continua
	
caso_uguale:
	cmpb %dh, %bh #faccio il confronto nel campo SCADENZA se ho priorità uguale
		jg nuovo_massimo
	jmp continua


uscita_loop_interno:
	movl %ebx, (%esp, %ecx, 4) #salvo il valore trovato nell'indirizzo indicato da ecx
	inc %ecx #incremento ecx prima di continuare la ricerca
	jmp loop_esterno

fine:
	
	pushl %esi	
	ret
	
	
