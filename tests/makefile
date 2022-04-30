BASE_DIR = /home/meetowl/uni/project/cores/steel-core-mine

BIN_DIR = $(BASE_DIR)/tests/bin
BIN_NAME = test-sim
BIN_PATH = $(BIN_DIR)/$(BIN_NAME)

TESTS_DIR = $(BASE_DIR)/tests
RISCV_DIR = $(BASE_DIR)/riscv-tests
RISCV_BIN_PATH = $(RISCV_DIR)/$(BIN_NAME)

IVERILOG = iverilog
IVERILOG_FLAGS += -l../steel_core.v

REGISTERS = 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
INTEGER_FILES = 0 1 2

$(BIN_DIR):
	mkdir $(BIN_DIR)

integer_file: $(BIN_DIR)
	$(foreach r, $(REGISTERS), $(foreach i, $(INTEGER_FILES), $(IVERILOG) $(IVERILOG_FLAGS) -DIRF_TEST_FAULT -DIRF_TEST_FAULT_$(i) -DERROR_ADDR=$(r) -o$(BIN_PATH) integer_file_tb.v && $(BIN_PATH)))

integer_file_scrub: $(BIN_DIR)
	$(foreach i, $(INTEGER_FILES), $(IVERILOG) $(IVERILOG_FLAGS) -DIRF_TEST_FAULT -DIRF_TEST_FAULT_$(i) -DIRF_SCRUB -o$(BIN_PATH) integer_file_tb.v && $(BIN_PATH))

steel_core: $(BIN_DIR)
	$(IVERILOG) $(IVERILOG_FLAGS) -DIRF_TEST_FAULT -DERROR_ADDR=2 -o$(RISCV_BIN_PATH) $(TESTS_DIR)/steel_core_tb.v 
	cd $(RISCV_DIR) && $(BIN_PATH) | grep "^Result: "

steel_core_scrub: $(BIN_DIR)
	$(IVERILOG) $(IVERILOG_FLAGS) -DIRF_TEST_FAULT -DIRF_SCRUB -o$(RISCV_BIN_PATH) $(TESTS_DIR)/steel_core_tb.v
	cd $(RISCV_DIR) && $(BIN_PATH) | grep "^Result: "
