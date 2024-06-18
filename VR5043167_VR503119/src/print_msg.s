.section .data

inizio:
	.string "Inserisci 1 per EDF, 2 per HPF, 3 per uscire.\n"
inizio_len:
	.long . -inizio
	
pian_edf:
	.string "Pianificazione EDF:\n"
pian_edf_len:
	.long . -pian_edf
	
pian_hpf:
	.string "Pianificazione HPF:\n"
pian_hpf_len:
	.long . -pian_hpf
	
err_input:
	.string "Errore: hai inserito un carattere non valido\n\n"
err_input_len:
	.long . -err_input
	
err_param:
	.string "Errore: Questo programma richiede esattamente un file di testo come parametro\n"
err_param_len:
	.long . -err_param
	
err_file: 
	.string "Errore nell'apertura del file\n"	
err_file_len: 
	.long  . -err_file
	
err_value: 
	.string "Errore: almeno un valore nel file non rispetta le specifiche del programma:\n1)Identificativo compreso fra 1 e 127\n2)Durata compreso fra 1 e 10\n3)Scadenza compreso fra 1 e 100\n4)Priorità compreso fra 1 e 5\n"
err_value_len:
	.long . -err_value
	
err_field: 
	.string "Errore: il file presenta dei dati incompleti\n"	
err_field_len: 
	.long  . -err_field
	
err_format: 
	.string "Errore generico nella formattazione del file\n"	
err_format_len: 
	.long  . -err_format

.section .text
	.global print_menu
	.global print_edf
	.global print_hpf
	.global print_input_err
	.global print_param_err
	.global print_file_err
	.global print_value_err
	.global print_field_err
	.global print_format_err
	
.type print_menu, @function
.type print_hpf, @function
.type print_edf, @function
.type print_input_err, @function
.type print_param_err, @function
.type print_file_err, @function
.type print_value_err, @function
.type print_field_err, @function
.type print_format_err, @function

print_menu:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal inizio, %ecx # metti il messaggio in ECX
	movl inizio_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret
	
print_edf:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal pian_edf, %ecx # metti il messaggio in ECX
	movl pian_edf_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret

print_hpf:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal pian_hpf, %ecx # metti il messaggio in ECX
	movl pian_hpf_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret
	
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

print_file_err:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal err_file, %ecx # metti il messaggio in ECX
	movl err_file_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret
	
print_value_err:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal err_value, %ecx # metti il messaggio in ECX
	movl err_value_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret

print_field_err:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal err_field, %ecx # metti il messaggio in ECX
	movl err_field_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret

print_format_err:
	movl $4, %eax # 4 = syscall WRITE
	movl $1, %ebx # 1 = write to standard output
	leal err_format, %ecx # metti il messaggio in ECX
	movl err_format_len, %edx #lunghezza del messaggio in EDX
	int  $0x80
	ret
	


	

	
	
