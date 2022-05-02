<p align="center">
  <img width="100" src="https://user-images.githubusercontent.com/22325319/85179004-38513880-b256-11ea-9a1a-4d204183bb13.png">
</p>

Steel is a RISC-V processor core that implements the RV32I and Zicsr instruction sets of the RISC-V specifications. It is designed to be simple and easy to use.

This fork is a modification of the original steel core, to implement Fault-Tolerance into the integer file. Please refer to the parent of this project for official documentation and guidance.

This work serves as the source code to my B.Sc. Dissertation.

## Key features

* Simple, easy to use
* Free, open-source
* RV32I base instruction set + Zicsr extension + M-mode privileged architecture
* 3 pipeline stages, single-issue
* Hardware described in Verilog
* RISC-V compliant
* Integer-File Fault-Tolerance (scrubbing enabled with IRF_SCRUB macro)

## Testing
* To test the core 
  ```
  cd tests
  make integer_file # to test the integer file with fault-tolerance testing
  make integer_file_scrub # to test the integer file with fault-tolerance testing with scrubbing enabled
  make steel_core # to test the entire core
  make steel_core_scrub # to test the entire core with integer file scrubbing enabled
  ```
* To display statistics about the synthesised cores
  ```
  cd env/yosys
  yosys run.ys
  ```

