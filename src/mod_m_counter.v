`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    10:32:01 12/19/2015 
// Design Name: 	-
// Module Name:    mod_m_counter 
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

module mod_m_counter
	#(
		parameter	N = 8,  // number of bits in counter
						M = 163 // mod M
	)
	(
		input wire clk, rst,
		output wire max_tick,
		output wire [N-1:0] out
    );
	
	// signal decleration
	reg [N-1:0] state;
	wire [N-1:0] nstate;
	
	// state register
	always @(posedge clk, posedge rst)
		if(rst)
			state <= 0;
		else
			state <= nstate;
	
	// next-state logic
	assign nstate = (state == M-1) ? 0 : state + 1;
	
	// output logic
	assign out = state;
	assign max_tick = (state == M-1) ? 1'b1 : 1'b0;

endmodule
