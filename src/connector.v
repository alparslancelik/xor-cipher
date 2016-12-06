`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    20:15:19 12/22/2015 
// Design Name: 	-
// Module Name:    connector 
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

module connector
	( 
		input [1:0] key,
		input wire [7:0] r_d1, r_d2, r_d3,
		input [3:0] r_a_in,
		output wire [3:0] r_a1, r_a2, r_a3,
		output wire [7:0] r_d_out
    );
	
	assign r_a1 = (key==2'b00) ? r_a_in : 4'bx;
	assign r_a2 = (key==2'b01) ? r_a_in : 4'bx;
	assign r_a3 = (key==2'b10) ? r_a_in : 4'bx;
	
	assign r_d_out = (key==2'b00) ? r_d1 :
							(key==2'b01) ? r_d2 :
							(key==2'b10) ? r_d3 : 4'bx;
endmodule
