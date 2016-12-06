`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: -
// 
// Create Date:    15:30:50 12/02/2015 
// Design Name: 	-
// Module Name:    spi_communicator 
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

module spi_communicator(
	input reset, clk,
	input [7:0] encoder_out,
	output reg clk_out, reset_lcd, d_c, spi_sender, slow_clk,
	output reg [2:0] encoder_key,
	output reg [3:0] ram_R_A,
	output reg [7:0] parallel_data );
	
	reg [3:0] counter;
	integer state;
	reg [10:0] counter_clk;
	reg [6:0] ctr;

	// Reset signal going directly to nokia lcd
	always@(posedge clk)
		reset_lcd <= reset;
	
	// Asynchronous reset
	always@(posedge clk or negedge reset)
		if(reset == 0) begin
			counter_clk <= 0;
			slow_clk <= 0;
			clk_out <= 0;
		end
		else begin
			counter_clk <= counter_clk + 1;
			slow_clk <= counter_clk[10];
			clk_out <= slow_clk;
		end
	
	// Asynchronous reset
	always@(posedge slow_clk or negedge reset)
		if (reset == 0) begin
			ram_R_A <= 4'bx;
			ctr <= 7'bx;
			encoder_key <= 3'bx;
			state <= 0;			
			parallel_data <= 8'h00;			
			spi_sender <= 1'b0;			
			d_c <= 1'b0;					
			counter <= 4'b0000;
		end
		else
			case(state)
				0: begin
					encoder_key <= 3'bx; 
					parallel_data<=8'h21;
					spi_sender<=1'b1;					
					d_c<=1'b0;	
					if (counter< 4'b1111)
						counter<=counter+1;	
					else begin						
						counter<=4'b0000;
						state<=1;
						spi_sender<=1'b0;
						
						ram_R_A <= 4'bx; 
						ctr <= 7'bx;
					end
				end
				
				1: begin
					encoder_key <= 3'bx;
					parallel_data<=8'hb0;
					spi_sender<=1'b1;
					d_c<=1'b0;	
			
					if (counter< 4'b1111)
						counter<=counter+1;
					else begin
						counter<=4'b0000;
						state<=2;
						spi_sender<=1'b0;
						
						ram_R_A <= 4'bx;
						ctr <= 7'bx;
					end
				end
				
				2: begin
					encoder_key <= 3'bx;
					parallel_data<=8'h04;
					spi_sender<=1'b1;
					d_c<=1'b0;	
			
					if (counter< 4'b1111)
						counter<=counter+1;
					else begin
						counter<=4'b0000;
						state<=3;
						spi_sender<=1'b0;
						
						ram_R_A <= 4'bx;
						ctr <= 7'bx;
					end
				end
				
				3: begin
					encoder_key <= 3'bx;
					parallel_data<=8'h14;
					spi_sender<=1'b1;
					d_c<=1'b0;	
			
					if (counter< 4'b1111)
						counter<=counter+1;
					else begin
						counter<=4'b0000;
						state<=4;
						spi_sender<=1'b0;
						
						ram_R_A <= 4'bx;
						ctr <= 7'bx;
					end
				end
				
				4: begin
					encoder_key <= 3'bx;
					parallel_data<=8'h20;
					spi_sender<=1'b1;
					d_c<=1'b0;	
			
					if (counter< 4'b1111)
						counter<=counter+1;
					else begin
						counter<=4'b0000;
						state<=5;
						spi_sender<=1'b0;
						
						ram_R_A <= 4'bx;
						ctr <= 7'bx;
					end
				end
				
				5: begin
					ram_R_A <= 4'bx; //Initialize read address
					encoder_key <= 3'bx;
					parallel_data<=8'h0c;
					spi_sender<=1'b1;
					d_c<=1'b0;
					
					if (counter< 4'b1111)
						counter<=counter+1;
					else begin
						counter<=4'b0000;
						state<=6;
						spi_sender<=1'b0;
						
						ram_R_A <= 4'b0;
						ctr <= 7'b0;
					end
				end
				
				//Data begining
				6: begin
					encoder_key <= 3'b000;
					parallel_data <= encoder_out;
					spi_sender <= 1'b1;
					d_c <= 1'b1;	
					
					if (counter < 4'b1111)
						counter <= counter+1;
					else begin
						counter <=  4'b0000;
						state <= 7;
						spi_sender <= 1'b0;
						
						ram_R_A <= ram_R_A;
						ctr <= ctr;
					end
				end
				
				7: begin
					encoder_key <= 3'b001;
					parallel_data <= encoder_out;
					spi_sender <= 1'b1;
					d_c <= 1'b1;	
					
					if (counter < 4'b1111)
						counter <= counter+1;
					else begin
						counter <= 4'b0000;
						state <= 8;
						spi_sender <= 1'b0;
						
						ram_R_A <= ram_R_A;
						ctr <= ctr;
					end
				end
				
				8: begin
					encoder_key <= 3'b010;
					parallel_data <= encoder_out;
					spi_sender <= 1'b1;
					d_c <= 1'b1;	

					if (counter < 4'b1111)
						counter <= counter+1;
					else begin
						counter <= 4'b0000;
						state <= 9;
						spi_sender <= 1'b0;
						
						ram_R_A <= ram_R_A;
						ctr <= ctr;
					end
				end
				
				9: begin
					encoder_key <= 3'b011;
					parallel_data <= encoder_out;
					spi_sender <= 1'b1;
					d_c <= 1'b1;	
					
					if (counter < 4'b1111)
						counter <= counter+1;
					else begin
						counter <= 4'b0000;
						state <= 10;
						spi_sender <= 1'b0;
						
						ram_R_A <= ram_R_A;
						ctr <= ctr;
					end
				end
				
				10: begin
					encoder_key <= 3'b100;
					parallel_data <= encoder_out;
					spi_sender <= 1'b1;
					d_c <= 1'b1;	
					
					if (counter < 4'b1111)
						counter <= counter+1;
					else begin
						counter <= 4'b0000;
						state <= 11;
						spi_sender <= 1'b0;
						
						ram_R_A <= ram_R_A;
						ctr <= ctr;
					end
				end
				
				11: begin
					encoder_key <= 3'b101;
					parallel_data <= encoder_out;
					spi_sender <= 1'b1;
					d_c <= 1'b1;
					
					if (counter < 4'b1111)
						counter <= counter+1;
					else begin
						counter <= 4'b0000;
						state <= 12;
						spi_sender <= 1'b0;
						
						ram_R_A <= ram_R_A;
						ctr <= ctr;
					end
				end
				
				12: begin
					state <= 6;
					
					if(ctr == 83) begin
						ram_R_A <= 0;
						ctr <= 0;
					end 
					else
						if (ctr >= 15) begin
							ram_R_A <= 15;
							ctr <= ctr + 1;
						end
						else begin
							ram_R_A <= ram_R_A + 1;
							ctr <= ctr + 1;
						end
				end
				
				default: state <= 0;
		endcase
endmodule
