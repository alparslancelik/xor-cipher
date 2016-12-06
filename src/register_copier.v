`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    11:50:58 12/13/2015 
// Design Name: 	-
// Module Name:    Screen_Updater 
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

module register_copier
	(
		input clk, reset,
		input [7:0] RAM_data,
		output reg tRAM_CLR, tRAM_W_EN, spi_com_reset, SU_completed, 
		output reg [3:0] RAM_WR_A,
		output reg [7:0] tRAM_data
	);
	
	reg slow_clk;
	reg [5:0] ctr;
	reg [3:0] address_ctr;
	reg [1:0] state, nstate, address_ctr_key, tRAM_data_key;
	
	localparam [1:0]
		s0=2'b00, 
		s1=2'b01, 
		s2=2'b10, 
		s3=2'b11;
	
	// Slow clock generator
	always@(posedge clk or negedge reset)
		if(reset==0) begin
			ctr <= 0;
			slow_clk <= 0;
		end
		else begin
			ctr <= ctr + 1;
			if(ctr == 6'b010000) slow_clk <= 1;
			else slow_clk <= 0;
		end
	
	// State register
	always@(posedge slow_clk or negedge reset)
		if(reset==0)
			begin 
				state <= s0;
				RAM_WR_A <= 4'bx;
			end
		else
			begin
				state <= nstate;
				RAM_WR_A <= address_ctr;
				case(address_ctr_key)
					2'b00: address_ctr <= 0;
					2'b01: address_ctr <= address_ctr;
					2'b10: address_ctr <= address_ctr + 1;
					default: address_ctr <= 4'bx;
				endcase
				case(tRAM_data_key)
					2'b00: tRAM_data <= tRAM_data;
					2'b01: tRAM_data <= RAM_data;
					default: tRAM_data <= 8'bx;
				endcase
			end
	
	// Next state logic
	always@(state, address_ctr) begin
		case(state)
			s0: nstate = s1;
			s1: nstate = s2;
			s2: nstate = (address_ctr < 15) ? s1 : s3; 
			s3: nstate = s3;
			default: nstate = s0;
		endcase
	end
	
	// Output logic
	always@(state, RAM_data, address_ctr_key) begin
		tRAM_CLR = 0; 
		tRAM_W_EN = 1;
		address_ctr_key = 2'b01;
		
		case(state)
			s0: 
				begin
					tRAM_CLR = 1; 
					address_ctr_key = 2'b00;
					tRAM_data_key = 2'b10;
					spi_com_reset = 0;
					SU_completed = 0;
				end
				
			s1: 
				begin	
					tRAM_data_key = 2'b01;
					spi_com_reset = 0;
					SU_completed = 0;
				end 
			
			s2: 
				begin
					tRAM_data_key = 2'b00;
					address_ctr_key = 2'b10;
					spi_com_reset = 0;
					SU_completed = 0;
				end
			
			s3: 
				begin
					tRAM_W_EN = 0;
					tRAM_data_key = 2'b10;
					spi_com_reset = 1;
					SU_completed = 1;
				end
			
			default: 
				begin
					tRAM_CLR = 1'bx; 
					tRAM_W_EN = 1'bx;
					spi_com_reset = 1'bx;
					address_ctr_key = 2'b11;
					tRAM_data_key = 2'b10;
					SU_completed = 1'bx;
				end
		endcase
	end
endmodule
