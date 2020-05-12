//////////////////////////////////////////////////////////////////////////////////
// Engineer: Rafael de Oliveira Calçada (rafaelcalcada@gmail.com)
// 
// Create Date: 26.04.2020 20:52:25
// Module Name: tb_load_unit
// Project Name: Steel Core
// Description: RISC-V Steel Core Load Unit testbench
// 
// Dependencies: load_unit.v
// 
// Version 0.01
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "../globals.vh"

module tb_steel_top();

    reg CLK;
    reg RESET;              
    wire [31:0] I_ADDR;
    reg [31:0] INSTR;        
    wire [31:0] D_ADDR;
    wire [31:0] DATA_OUT;
    wire WR_REQ;
    wire [3:0] WR_MASK;
    reg [31:0] DATA_IN;        
    reg E_IRQ;
    reg T_IRQ;
    reg S_IRQ;

    steel_top dut(

        .CLK(CLK),
        .RESET(RESET),        
        .REAL_TIME(64'b0),        
        .I_ADDR(I_ADDR),
        .INSTR(INSTR),        
        .D_ADDR(D_ADDR),
        .DATA_OUT(DATA_OUT),
        .WR_REQ(WR_REQ),
        .WR_MASK(WR_MASK),
        .DATA_IN(DATA_IN),        
        .E_IRQ(E_IRQ),
        .T_IRQ(T_IRQ),
        .S_IRQ(S_IRQ)

    );
    
    reg [7:0] ram [0:65535]; // 8KB RAM
    integer i;
    integer f;
    wire [11:0] eff_i_addr;
    wire [11:0] eff_d_addr;
    
    assign eff_i_addr = I_ADDR[11:0];
    assign eff_d_addr = D_ADDR[11:0];
    
    always
    begin
        #10 CLK = !CLK;
    end
    
    initial
    begin
    
        f = $fopen("beq.txt","w");
        
        // LOADS PROGRAM INTO MEMORY 
        for(i = 0; i < 65535; i=i+1) ram[i] = 8'b0;
        $readmemh("beq.mem",ram);
        
        // INITIAL VALUES
        RESET = 1'b0;        
        CLK = 1'b0;        
        E_IRQ = 1'b0;
        T_IRQ = 1'b0;
        S_IRQ = 1'b0;
        
        // RESET
        #5;
        RESET = 1'b1;
        #15;
        RESET = 1'b0;
                
        #1000;
        
        $fwrite(f, "%d", ram[32]);
        $fclose(f);
        
    end
    
    always @(posedge CLK or posedge RESET)
    begin
        if(RESET)
        begin
            INSTR = {ram[eff_i_addr+3],ram[eff_i_addr+2],ram[eff_i_addr+1],ram[eff_i_addr]};
            DATA_IN = {ram[eff_d_addr+3],ram[eff_d_addr+2],ram[eff_d_addr+1],ram[eff_d_addr]};
        end
        else
        begin
            INSTR = {ram[eff_i_addr+3],ram[eff_i_addr+2],ram[eff_i_addr+1],ram[eff_i_addr]};
            DATA_IN = {ram[eff_d_addr+3],ram[eff_d_addr+2],ram[eff_d_addr+1],ram[eff_d_addr]};
            if(WR_REQ)
            begin
                ram[eff_d_addr] <= DATA_OUT[7:0];
                if(WR_MASK[1])
                begin
                    ram[eff_d_addr+1] <= DATA_OUT[15:8];
                end
                if(WR_MASK[2])
                begin
                    ram[eff_d_addr+2] <= DATA_OUT[23:16];
                end
                if(WR_MASK[3])
                begin
                    ram[eff_d_addr+3] <= DATA_OUT[31:24];
                end
            end
            else
            begin                
                DATA_IN = {ram[eff_d_addr+3],ram[eff_d_addr+2],ram[eff_d_addr+1],ram[eff_d_addr]};
            end
        end
    end

endmodule