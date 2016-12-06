`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    20:12:41 12/22/2015  
// Design Name: 	-
// Module Name:    key_rom_8x16bit 
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

module key_rom_8x16bit
	#(
		parameter	B = 8, // number of data bits
						W = 4  // number of address bits
	)
	(
		input clk, reset,
		input [3:0] R_A,
		output [7:0] R_D
    );

	reg [B-1:0] ROM [2**W-1:0];
	
	assign R_D = ROM[R_A];
	
	always @(posedge clk)
		if(reset!=1'b0)
			begin
				ROM[0] <= 8'h5A;  //k
				ROM[1] <= 8'h68;  //e
				ROM[2] <= 8'h5A;  //y
				ROM[3] <= 8'h68;  //
				ROM[4] <= 8'h5A;  //v
				ROM[5] <= 8'h68;  //a
				ROM[6] <= 8'h5A;  //l
				ROM[7] <= 8'h68;  //u
				ROM[8] <= 8'h5A;  //e
				ROM[9] <= 8'h68;  //
				ROM[10] <= 8'h5A; //c
				ROM[11] <= 8'h68; //s
				ROM[12] <= 8'h00;
				ROM[13] <= 8'h00;
				ROM[14] <= 8'h00;
				ROM[15] <= 8'h00;
			end
endmodule
