`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2024 23:09:55
// Design Name: 
// Module Name: RISCV_TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module RISCV_TOP(
input [31:0] PC_in,
input clk,
input reset,
//input valid,
output zero_flag,
output [31:0]alu_result,
output bt
);
wire [31:0]w_pc_out;
program_counter pc (.clk(clk),
                    .reset(reset),
                    .PC_in(PC_in),
                    .PC_out(w_pc_out)
                    );
                    

wire [31:0]w_instr_out;
instruction_memory im (.clk(clk),
                       .reset(reset),
                       .read_addr(w_pc_out),
                       .instr_out(w_instr_out)
                      );
                       
wire [31:0]w_read_data1;
wire [31:0]w_read_data2;
wire [4:0]w_write_reg;
instruction_decoder id(
                       .clk(clk),    
                       .reset(reset),
                       .pc_reg(w_instr_out),
                       .read_data1(w_read_data1),
                       .read_data2(w_read_data2),
                       .write_reg(w_write_reg)
//                       .w_RegWriteData(wr_back_data),
//                       .w_wb_en(wb_en)
                      );

    
wire [1:0]w_alu_sel;
wire [2:0]w_alu_control;
wire w_wb_mux;
 control_unit ct(
                 .clk(clk),
                 .reset(reset),
                 .pc_reg(w_instr_out),
                 .alu_sel(w_alu_sel),
                 .alu_control(w_alu_control)
                // .wb_mux(1)//(w_wb_mux)
                 );

//wire w1_alu_control;
//wire w2_alu_sel;
//synchronization syn(
//    .clk(clk),
//    .reset(reset),
//    .alu_control_in(),
//    .alu_sel_in(),
//    .alu_control_out(),
//    .alu_sel_out()
//    );
    

ALU_design ad(
                  .clk(clk),  
                  .reset(reset),
                  //.valid(valid),
                  .read_data1(w_read_data1),
                  .read_data2(w_read_data2),
                  .alu_control(w_alu_control),
                  .alu_sel(w_alu_sel),
                  .alu_result(alu_result),
                  .zero_flag(zero_flag),
                  .bt(bt)
   );
 
 wire [31:0]w_alu_result;
 assign w_alu_result = alu_result;
 data_memory dm(
    .clk(clk),
    .reset(reset),
    .addr(w_write_reg),
    .write_data(w_alu_result),    
    //.wr_en(),
    //.rd_en(),
    .read_data(read_data)
    );
   
 wire [31:0]w_read_data; 
 wire w_RegWriteData; 
 wire w_wb_en; 
 write_back wr(
  .alu_result(w_alu_result),
  .MemoryData(w_read_data),
  .wb_en(),       //w_wb_en
  .clk(clk),
  .reset(reset),
  .RegWriteData() //w_RegWriteData
);
    
endmodule
