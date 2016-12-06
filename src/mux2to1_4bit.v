`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    21:54:01 12/22/2015 
// Design Name: 	-
// Module Name:    mux2to1_4bit 
// Project Name: 	FPGA implementation of simple XOR cipher
// Target Devices: -
// Tool versions: -
// Description: -
//
// Dependencies: -
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module mux2to1_4bit
	(
		input [3:0] in1, in2,
		input key,
		output reg [3:0] out 
	);
	
	always @(in1, in2, key)
		case(key)
			1'b0: out <= in1;
			1'b1: out <= in2;
			default: out <= 1'bx;
		endcase

endmodule
