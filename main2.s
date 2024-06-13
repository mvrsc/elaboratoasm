# stampo menu'

# leggo file e push valori su stack

#riordino lo stack 

#calcolo tempo e stampo
#calcolo penalita' e stampo

.section .data

selezione:
  .ascii "Quale algoritmo vuoi usare?\nDigita \"EDF\" per Earliest Deadline First.\nDigita \"HPF\" per Highest Priority First.\nDigita \"ESC\" per uscire\n" 
selezione_len:
	.long . - selezione
	
scelta_non_valida:
	.ascii "\nScelta non valida\n\n" 
scelta_non_valida_len:
	.long . - scelta_non_valida
	
pianificazione_EDF:
	.ascii "Pianificazione EDF:\n"
pianificazione_EDF_len:
	.long . - pianificazione_EDF
	
pianificazione_HPF:
	.ascii "Pianificazione HPF:\n"
pianificazione_HPF_len:
	.long . - pianificazione_HPF

scelta:
	.ascii "000"
	.ascii "\n"
	


.section .text
  .global _start


_start:

stampa_selezione:
	xorl %eax,%eax
	xorl %ebx,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	
	movl $4, %eax
	movl $1, %ebx
	leal selezione, %ecx
	movl selezione_len,%edx
	int $0x80  
	
leggi_selezione:
	xorl %eax,%eax
	xorl %ebx,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	movl $3, %eax         # Set system call READ
	movl $0, %ebx         # | <- keyboard
	leal scelta, %ecx        # | <- destination
	movl $3, %edx        # | <- string length
	int $0x80             # Execute syscall

######################################################################################################### 

#										LEGGI FILE E PUSH SU STACK 

#											@function read_push

#########################################################################################################


esegui_scelta:
	xorl %eax,%eax
	xorl %ebx,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	movl scelta, %eax
	
	#chiudi il programma
	cmp $172184389, %eax
	je fine
	cmp $174289765, %eax
	je fine	
	
	#chiamata algoritmo EDF	
	cmp $172377157, %eax
	je call_EDF	
	cmp $174482533, %eax
	je call_EDF	
	
	#chiamata algoritmo HPF
	cmp $172380232, %eax
	je call_HPF
	cmp $174485608, %eax
	je call_HPF	
	
stampa_scelta_non_valida:
	xorl %eax,%eax
	xorl %ebx,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	
	movl $4, %eax
	movl $1, %ebx
	leal scelta_non_valida, %ecx
	movl scelta_non_valida_len, %edx
	int $0x80
	jmp stampa_selezione
	
call_EDF:
	movl $1, %ecx
	
call_HPF:
	movl $1, %edx

##################################################################################		

#						CALCOLO PIANIFICAZIONE -> STAMPA
#						CALCOLO CONCLUSIONE E PENALTY -> STAMPA

##################################################################################


fine:
  movl $1, %eax
  movl $0, %ebx
  int $0x80
