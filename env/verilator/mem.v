`timescale 1ns

/* verilator lint_off UNUSED */
module mem
  (   input clk, //clock
      input         rst,
      
      input         wr_en, //write enable for port 0
      input [3:0]   wr_mask,
      input [31:0]  addr_in_0, //address for port 0
      input [31:0]  data_in, //Input data to port 0.
      output [31:0] data_out_0, //output data from port 0.
      
      input [31:0]  addr_in_1, //address for port 1
      output [31:0] data_out_1 //output data from port 1.
      );

   localparam       SIZE = 128;
   //memory declaration.
   reg [7:0]        ram[SIZE - 1:0];

   reg [7:0]        lmao1;
   reg [7:0]        lmao2;


   //writing to the RAM
   always@(posedge clk)
     begin
        if (wr_en)
          begin
             if (wr_mask[3]) 
               ram[addr_in_0]     <= data_in[31:24];
             if (wr_mask[2])
               ram[addr_in_0 + 1] <= data_in[23:16];
             if (wr_mask[1])
               ram[addr_in_0 + 2] <= data_in[15:8];
             if (wr_mask[0])
               ram[addr_in_0 + 3] <= data_in[7:0];
          end
     end

   always @(posedge clk) begin
      data_out_0[31:24] <= ram[addr_in_0];
      data_out_0[23:16] <= ram[addr_in_0 + 1];
      data_out_0[15:8]  <= ram[addr_in_0 + 2];
      data_out_0[7:0]   <= ram[addr_in_0 + 3];

      data_out_1[31:24] <= ram[addr_in_1];
      data_out_1[23:16] <= ram[addr_in_1 + 1];
      data_out_1[15:8]  <= ram[addr_in_1 + 2];
      data_out_1[7:0]   <= ram[addr_in_1 + 3];
   end // always @ (posedge clk)



   integer k;
   always @(posedge clk)
     if (rst)
       begin
          ram[64] <= 8'hfe;
          ram[65] <= 8'h01;
          ram[66] <= 8'h01;
          ram[67] <= 8'h13;

          ram[68] <= 8'h00;
          ram[69] <= 8'h81;
          ram[70] <= 8'h2e;
          ram[71] <= 8'h23;

          ram[72] <= 8'h02;
          ram[73] <= 8'h01;
          ram[74] <= 8'h04;
          ram[75] <= 8'h13;

          ram[76] <= 8'hfe;
          ram[77] <= 8'h04;
          ram[78] <= 8'h26;
          ram[79] <= 8'h23;

          ram[80] <= 8'hfe;
          ram[81] <= 8'hc4;
          ram[82] <= 8'h27;
          ram[83] <= 8'h83;

          ram[84] <= 8'h00;
          ram[85] <= 8'h37;
          ram[86] <= 8'h87;
          ram[87] <= 8'h93;

          ram[88] <= 8'hfe;
          ram[89] <= 8'hf4;
          ram[90] <= 8'h26;
          ram[91] <= 8'h23;

          ram[92] <= 8'hff;
          ram[93] <= 8'h5f;
          ram[94] <= 8'hf0;
          ram[95] <= 8'h6f;

       end // if (rst)
endmodule // mem

