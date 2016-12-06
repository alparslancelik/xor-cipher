`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    01:18:33 12/19/2015 
// Design Name: 	-
// Module Name:    encryption 
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

module encryption
	(
		input clk, en,
		input [7:0] text_data, key_data,
		output reg cipher_w_en, finished,
		output reg [3:0] text_address_ctr, key_address_ctr,
		output reg [7:0] cipher_data 
	);
	
	reg [2:0] state, nstate;
	reg [1:0] key;
	
	localparam [2:0]	
		s0=3'b000,
		s1=3'b001,
		s2=3'b010,
		s3=3'b011,
		s4=3'b100;
		
	// state register
	always @(posedge clk or negedge en)
		if(en==0) state <= s0;
		else 
			begin
				state <= nstate;
				case(key)
					2'b00:
						begin
							text_address_ctr <= 4'b0;
							key_address_ctr <= 4'b0;
						end
					
					2'b01:
						begin
							key_address_ctr <= key_address_ctr + 1;
							text_address_ctr <= text_address_ctr + 1;
						end
					
					2'b10:
						begin
							text_address_ctr <= text_address_ctr;
							key_address_ctr <= 4'b0;
						end
					
					2'b11:
						begin
							text_address_ctr <= text_address_ctr;
							key_address_ctr <= key_address_ctr;
						end
					default:
						begin
							text_address_ctr <= 4'bx;
							key_address_ctr <= 4'bx;
						end
				endcase
			end
	
	// next state combinational logic
	always @(state, key_data, text_data)
		case(state)
			s0: nstate = (key_data != 8'b0 && text_data != 8'b0) ? s1 : s4;
			s1: 
				begin
					if( key_data != 8'b0 && text_data != 8'b0 ) nstate = s3;
					else if( key_data == 8'b0 && text_data != 8'b0 ) nstate = s2;
					else if( key_data != 8'b0 && text_data == 8'b0 ) nstate = s4;
					else if( key_data == 8'b0 && text_data == 8'b0 ) nstate = s4;
					else nstate = s1;
				end
			
			s2|s3: nstate = s1;
			s4: nstate = s4;
			default: nstate = s0;
		endcase
			
	// output combinational logic
	always @(state, key_data, text_data, key) 
		begin
			case(state)
				s0:
					begin
						key = 2'b00;
						cipher_w_en = 0;
						cipher_data = 8'bx;
						finished = 0;
					end
				
				s1:
					begin
						key = 2'b11;
						cipher_w_en = 1;
						cipher_data = key_data ^ text_data;
						finished = 0;
					end
				
				s2: 
					begin
						key = 2'b10;
						cipher_w_en = 0;
						cipher_data = 8'bx;
						finished = 0;
					end
					
				s3: 
					begin
						key = 2'b01;
						cipher_w_en = 0;
						cipher_data = 8'bx;
						finished = 0;
					end
				
				s4: 
					begin
						key = 2'b11;
						cipher_w_en = 0;
						finished = 1;
						cipher_data = 8'bx;
					end
				
				default:
					begin
						key = 2'b00;
						cipher_w_en = 1'bx;
						finished = 1'bx;
						cipher_data = 8'bx;
					end
			endcase
		end
endmodule
