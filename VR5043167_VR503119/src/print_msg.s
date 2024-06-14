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
	
err_file: 
	.string "Errore nell'apertura del file\n"	
err_file_len: 
	.long  . -err_file

.section .text
	.global print_input_err
	.global print_param_err
	.global print_menu
	.global print_file_err
.type print_input_err, @function
.type print_param_err, @function
.type print_menu, @function
.type print_file_err, @function
	
print_input_err:	
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal err_input, %ecx # metti il messaggio in ECX
	movl err_input_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret

print_param_err:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal err_param, %ecx # metti il messaggio in ECX
	movl err_param_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret

print_menu:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal inizio, %ecx # metti il messaggio in ECX
	movl inizio_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret

print_file_err:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal err_file, %ecx # metti il messaggio in ECX
	movl err_file_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret
	

	

	
	
