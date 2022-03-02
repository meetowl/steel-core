// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2017 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
//======================================================================

// For std::unique_ptr
#include <memory>

// Include common routines
#include <verilated.h>

// Include model header, generated from Verilating "top.v"
#include "Vtop.h"

// Legacy function required only so linking works on Cygwin and MSVC++
double sc_time_stamp() { return 0; }

int main(int argc, char** argv, char** env) {
    // This is a more complicated example, please also see the simpler examples/make_hello_c.

    // Prevent unused variable warnings
    if (false && argc && argv && env) {}

    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    contextp->debug(0);
    contextp->randReset(2);
    contextp->traceEverOn(true);
    contextp->commandArgs(argc, argv);
    const std::unique_ptr<Vtop> top{new Vtop{contextp.get(), "TOP"}};

    // Set Vtop's input signals
    top->rst = 1;
    top->clk = 0;
    // Make sure registers are in a state we want
    for (int i = 0; i < 10; i++) {
            contextp->timeInc(1);
            top->clk = !top->clk;
            top->eval();
    }
    top->rst = 0;

    
    for (int i = 0; i < 50; i++) {
            contextp->timeInc(1);
            top->clk = !top->clk;
            top->eval();
    }
    // // Simulate until $finish
    // while (!contextp->gotFinish()) {
    //     contextp->timeInc(1);
    //     top->clk = !top->clk;
    //     top->eval();
    // }

    // Final model cleanup
    top->final();

    return 0;
}
