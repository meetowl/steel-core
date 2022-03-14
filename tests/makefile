BIN_DIR = ./bin
BIN_NAME = test-sim
BIN_PATH = $(BIN_DIR)/$(BIN_NAME)

IVERILOG = iverilog
IVERILOG_FLAGS = -l../steel_core.v

$(BIN_DIR):
	mkdir $(BIN_DIR)

integer_file: $(BIN_DIR)
	$(IVERILOG) $(IVERILOG_FLAGS) -o$(BIN_PATH) integer_file_tb.v

run: $(BIN_DIR)
	$(BIN_PATH)

