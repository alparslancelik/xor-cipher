`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    18:22:43 12/05/2015
// Design Name: 	-
// Module Name:    Register4x4bit 
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

module register_8x16bit
	#(
		parameter	B = 8, // number of bits
						W = 4  // number of address bits 
	)
	(
		input clk, clr, W_E,
		input [3:0] R_A, W_A,
		input [7:0] W_D,
		output [7:0] R_D 
	);
	
	reg [B-1:0] RAM [2**W-1:0];
	reg [3:0] i;
	
	assign R_D = RAM[R_A];
	
	always@(posedge clk or posedge clr)
		if(clr==1)
			begin
				for (i = 0; i < 2**W - 1; i = i + 1)  // Setting individual memory cells to 0
					  RAM[i] <= 8'h00;
			end
		else 
			begin
				if(W_E) RAM[W_A] <= W_D;
			end

endmodule
