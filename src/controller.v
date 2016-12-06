`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    11:34:22 12/22/2015 
// Design Name: 	-
// Module Name:    controller 
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

module controller
	(
		input clk, reset, 
		input crypt, encry_completed, b1, b2, b3,
		input copy_completed,
		output reg en_encryption, clr_RAM, en_copier,
		output reg [1:0] key,
		output reg led_init, led_wait1
    );
	
	// signal decleration
	reg [2:0] state, nstate;

	localparam [2:0]
		init = 3'b000,
		encryption = 3'b001,
		wait1 = 3'b010,
		text_copy = 3'b011,
		key_copy = 3'b100,
		cipher_copy = 3'b101;
	
	// state register
	always @(posedge clk)
		if(reset == 1'b0)
			state <= init;
		else
			state <= nstate;
			
	// next-state logic
	always @(state, crypt, encry_completed, b1, b2, b3, copy_completed)
		case(state)
			init: nstate = (crypt) ? wait1 : init;
			encryption: nstate = (encry_completed) ? wait1 : encryption;
			wait1: 
				case({b1, b2, b3})
					3'b100: nstate = text_copy;
					3'b010: nstate = key_copy;
					3'b001: nstate = cipher_copy;
					default: nstate = wait1;
				endcase
			text_copy: nstate = (copy_completed) ? wait1 : text_copy;
			key_copy: nstate = (copy_completed) ? wait1 : key_copy;
			cipher_copy: nstate = (copy_completed) ? wait1 : cipher_copy;
			
			default: nstate = init;
		endcase
	
	// output logic
	always @(state, crypt)
		begin
			led_init = 0;
			led_wait1 = 0;
			
			case(state)
				init:
					begin
						en_encryption = 0;
						clr_RAM = 1;
						key = 2'bx;
						led_init = 1;
						en_copier = 0;
					end
				
				encryption:
					begin
						en_encryption = 1;
						clr_RAM = 0;
						key = 2'b10;
						en_copier = 1;
					end
				
				wait1:
					begin
						en_encryption = 0;
						clr_RAM = 0;
						key = 2'bx;
						led_wait1 = 1;
						en_copier = 0;
					end
					
				text_copy:
					begin
						en_encryption = 0;
						clr_RAM = 0;
						key = 2'b00;
						en_copier = 1;
					end
					
				key_copy:
					begin
						en_encryption = 0;
						clr_RAM = 0;
						key = 2'b01;
						en_copier = 1;
					end
					
				cipher_copy:
					begin
						en_encryption = 0;
						clr_RAM = 0;
						key = 2'b10;
						en_copier = 1;
					end
					
				default:
					begin
						en_encryption = 1'bx;
						clr_RAM = 1'bx;
						key = 2'bx;
						en_copier = 1'bx;
					end
			endcase
		end
endmodule
