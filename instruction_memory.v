`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2024 23:08:49
// Design Name: 
// Module Name: instruction_memory
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

module instruction_memory(
    input clk,
    input reset,
    input [31:0] read_addr,
    output  [31:0] instr_out
    );
    integer k=0;
    reg [31:0] Memory [3:0];
    assign instr_out = Memory[k];
    always @(posedge clk, negedge reset)
    begin
    if(~reset)
        Memory[k] = 'b0;
    else
        Memory[k] = read_addr ;
//    for(k=0;k<64;k=k+1)
//    begin
//    Memory[k] = k;
//    end
    end
    initial
        $display("..................Instruction_Memory is executed.............................");
    
    //  $monitor("@time=%0t,read_addr=%0h,instr_out=%0h",$time,read_addr,instr_out);
    
endmodule
