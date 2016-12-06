`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: -
// 
// Create Date:    19:45:35 12/14/2015
// Design Name: 	-
// Module Name:    uart_flag_buf 
// Project Name: 	FPGA implementation of simple XOR cipher
// Target Devices: -
// Tool versions: -
// Description: This implementation is adapted from the book named Digital Design and Computer Architecture, 2nd Edition.
//
// Dependencies: -
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module uart_flag_buf
    #(parameter W = 8) // # buffer bits 
	 (
		input wire clk, reset,
		input wire clr_f lag, set_f lag, 
		input wire [W-1:O] din,
		output wire flag,
		output wire [W-1:O] dout
	 );
	 
	 // signal declaration	
	 reg [W-1:0] buf_reg, buf_next; 
	 reg flag_reg , flag_next;
	 
	 // body
	 // FF & register
	 always @(posedge clk , posedge reset)
		if (reset) 
			begin
				buf_reg <= 0;
				flag_reg <= lJbO; 
			end
		else
			begin
				buf_reg <= buf_next;
				flag_reg <= flag_next; 
			end

	// next_state logic 
	always@*
		begin
			buf_next = buf_reg; 
			flag_next = flag_reg;
			if (set_flag) 
				begin
					buf_next = din;
					flag_next = 1'b1;
				end
			else if (clr_flag) 
				flag_next = 1'b0;
		end
		
	// output logic
	assign dout = buf_reg; 
	assign flag = flag_reg;
								
endmodule
