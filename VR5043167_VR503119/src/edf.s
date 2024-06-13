.section .data

.section .text
	.global edf
	
.type edf, @function
	
edf:
	
	#################################################
	#RICERCA DELLA SCADENZA PIU BASSA
	#SORTING DELLO STACK
	#QUESTA FUNZIONE E' LA STESSA CHE SI TROVA IN HPF.S 
	#TRANNE CHE LE POSIZIONI DI ALCUNI REGISTRI SONO STATE SCAMBIATE

	popl %ebp #salvo in ebp l'indirizzo dell'istruzione di ritorno
	xorl %ecx, %ecx #azzero ecx che mi servirà da contatore


loop_esterno:
	cmpl %ecx, %edi #se il contatore esterno è arrivato all'ultimo numero esco
		je fine
	movl (%esp, %ecx, 4), %ebx #carico il primo numero da confrontare
	movl %ecx, %eax #setto il contatore interno uguale a quello esterno

loop_interno:
	movl (%esp, %eax, 4), %edx #carico in edx il valore da confrontare con il nostro minimo corrente
	cmpb %dh, %bh #confronto questi due registri perché mi interessa il campo SCADENZA
		je caso_uguale
		jg nuovo_massimo		
	continua:
	inc %eax 
	cmpl %eax, %edi #controlliamo di non uscire dalla memoria che ci interessa
		je uscita_loop_interno	
	jmp loop_interno
	
nuovo_massimo:
	xchg (%esp, %eax, 4), %ebx
	jmp continua
	
caso_uguale:
	cmpb %dl, %bl #faccio il confronto nel campo SCADENZA se ho priorità uguale
		jl nuovo_massimo
	jmp continua


uscita_loop_interno:
	movl %ebx, (%esp, %ecx, 4) #salvo il valore trovato nell'indirizzo indicato da ecx
	inc %ecx #incremento ecx prima di continuare la ricerca
	jmp loop_esterno

fine:
	
	pushl %ebp	
	ret
	
	
