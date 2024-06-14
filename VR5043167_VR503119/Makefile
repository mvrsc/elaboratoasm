EXE_DIR = ./bin/
OBJ_DIR = ./obj/
SRC_DIR = ./src/


ASFLAGS= --32 -gstabs
LDFLAGS= -m elf_i386
EXE = $(EXE_DIR)Pianificatore
OBJ = $(OBJ_DIR)main.o $(OBJ_DIR)hpf.o $(OBJ_DIR)edf.o $(OBJ_DIR)read_push.o $(OBJ_DIR)itoa.o $(OBJ_DIR)output.o $(OBJ_DIR)print_msg.o

$(EXE): $(OBJ)
	ld $(LDFLAGS) $(OBJ) -o $(EXE)

$(OBJ_DIR)main.o: $(SRC_DIR)main.s
	as $(ASFLAGS) -o $(OBJ_DIR)main.o $(SRC_DIR)main.s
	
$(OBJ_DIR)edf.o: $(SRC_DIR)edf.s
	as $(ASFLAGS) -o $(OBJ_DIR)edf.o $(SRC_DIR)edf.s
	
$(OBJ_DIR)hpf.o: $(SRC_DIR)hpf.s
	as $(ASFLAGS) -o $(OBJ_DIR)hpf.o $(SRC_DIR)hpf.s

$(OBJ_DIR)read_push.o: $(SRC_DIR)read_push.s
	as $(ASFLAGS) -o $(OBJ_DIR)read_push.o $(SRC_DIR)read_push.s
	
$(OBJ_DIR)itoa.o: $(SRC_DIR)itoa.s
	as $(ASFLAGS) -o $(OBJ_DIR)itoa.o $(SRC_DIR)itoa.s

$(OBJ_DIR)output.o: $(SRC_DIR)output.s 
	as $(ASFLAGS) -o $(OBJ_DIR)output.o $(SRC_DIR)output.s

$(OBJ_DIR)print_msg.o: $(SRC_DIR)print_msg.s 
	as $(ASFLAGS) -o $(OBJ_DIR)print_msg.o $(SRC_DIR)print_msg.s
	
clean:
	rm -f $(OBJ_DIR)*.o
	rm -f $(EXE)
	
	

	
