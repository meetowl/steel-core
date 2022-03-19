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

   localparam       SIZE = 256;
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
          ram[69] <= 8'h11;
          ram[70] <= 8'h2e;
          ram[71] <= 8'h23;

          ram[72] <= 8'h00;
          ram[73] <= 8'h81;
          ram[74] <= 8'h2c;
          ram[75] <= 8'h23;

          ram[76] <= 8'h02;
          ram[77] <= 8'h01;
          ram[78] <= 8'h04;
          ram[79] <= 8'h13;

          ram[80] <= 8'h00;
          ram[81] <= 8'h00;
          ram[82] <= 8'h05;
          ram[83] <= 8'h13;

          ram[84] <= 8'hfe;
          ram[85] <= 8'ha4;
          ram[86] <= 8'h2a;
          ram[87] <= 8'h23;

          ram[88] <= 8'h00;
          ram[89] <= 8'h50;
          ram[90] <= 8'h05;
          ram[91] <= 8'h93;

          ram[92] <= 8'hfe;
          ram[93] <= 8'hb4;
          ram[94] <= 8'h28;
          ram[95] <= 8'h23;

          ram[96] <= 8'hff;
          ram[97] <= 8'h04;
          ram[98] <= 8'h25;
          ram[99] <= 8'h83;

          ram[100] <= 8'h01;
          ram[101] <= 8'h05;
          ram[102] <= 8'h85;
          ram[103] <= 8'h93;

          ram[104] <= 8'h00;
          ram[105] <= 8'h0a;
          ram[106] <= 8'h50;
          ram[107] <= 8'h73;

          ram[108] <= 8'hfe;
          ram[109] <= 8'hb4;
          ram[110] <= 8'h26;
          ram[111] <= 8'h23;

          ram[112] <= 8'h01;
          ram[113] <= 8'h81;
          ram[114] <= 8'h24;
          ram[115] <= 8'h03;

          ram[116] <= 8'h01;
          ram[117] <= 8'hc1;
          ram[118] <= 8'h20;
          ram[119] <= 8'h83;

          ram[120] <= 8'h02;
          ram[121] <= 8'h01;
          ram[122] <= 8'h01;
          ram[123] <= 8'h13;

          ram[124] <= 8'hfc;
          ram[125] <= 8'h5f;
          ram[126] <= 8'hf0;
          ram[127] <= 8'h6f;
       end // if (rst)
endmodule // mem

