BIN_DIR = ./bin

IVERILOG = iverilog
IVERILOG_FLAGS = -l../steel_core.v

$(BIN_DIR):
	mkdir $(BIN_DIR)

integer_file: $(BIN_DIR)
	$(IVERILOG) $(IVERILOG_FLAGS) -o$(BIN_DIR)/integer_file integer_file_tb.v
