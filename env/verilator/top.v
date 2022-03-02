// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2003 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
// ======================================================================

// This is intended to be a complex example of several features, please also
// see the simpler examples/make_hello_c.
`timescale 1ns
module top
  (
   // Declare some signals so we can see how I/O works
   input              clk,
   input              rst
   );

   wire [31:0]        i_mem_addr;
   wire [31:0]        i_mem_instr;

   wire [31:0]        d_mem_addr;
   wire [31:0]        d_mem_in;        
   wire [31:0]        d_mem_out;

   wire               wr_en;
   wire [3:0]         wr_mask;
   
   steel_core_top #(.BOOT_ADDRESS(32'd64)) sct (.CLK(clk),
                                                .RESET(rst),
                                                .REAL_TIME(0),
                                                .I_ADDR(i_mem_addr),
                                                .INSTR(i_mem_instr),
                                                .D_ADDR(d_mem_addr),
                                                .DATA_IN(d_mem_in),
                                                .DATA_OUT(d_mem_out),
                                                .WR_REQ(wr_en),
                                                .WR_MASK(wr_mask),

                                                .E_IRQ(0),
                                                .T_IRQ(0),
                                                .S_IRQ(0)
                                                );
   
   
   mem m(.clk(clk),
         .rst(rst),
         
         .wr_en(wr_en),
         .wr_mask(wr_mask),
         .addr_in_0(d_mem_addr),
         .data_in(d_mem_out),
         .data_out_0(d_mem_in),

         .addr_in_1(i_mem_addr),
         .data_out_1(i_mem_instr)
         );
         
                      
   // Print some stuff as an example
   initial begin
      if ($test$plusargs("trace") != 0) begin
         $display("[%0t] Tracing to dump.vcd...\n", $time);
         $dumpfile("dump.vcd");
         $dumpvars();
      end
      $display("[%0t] Model running...\n", $time);
   end

endmodule



   
          
                  
        
   
   
   
   
   
