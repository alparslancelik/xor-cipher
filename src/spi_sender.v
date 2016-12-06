`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: -
// 
// Create Date:    15:05:17 12/02/2015 
// Design Name: 	-
// Module Name:    spi_sender 
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

module spi_sender(
	input reset, clk, gonder_komutu_posedge,
	input [7:0] gonderilecek_data,
	output reg spi_data_out, spi_clk, spi_ce);
	
	reg gonder_komutu_posedge_buf, state;
	reg [7:0] gonderilecek_data_buf;
	reg [2:0] data_sayisi;

	always@(clk)
		spi_clk <= ~clk;

	always@(posedge clk or negedge reset) begin
		if (reset==1'b0) begin
			spi_data_out<=1'b0;
			spi_ce<=1'b1;
			state<=1'b0;
			gonder_komutu_posedge_buf<=1'b0;
			data_sayisi<=3'b111;
		end
		else begin
			gonder_komutu_posedge_buf<=gonder_komutu_posedge;

			case(state)
				1'b0: begin
					data_sayisi<=3'b111;
					spi_data_out<=1'b0;
					spi_ce<=1'b1;
			
					if (gonder_komutu_posedge_buf==1'b0 && gonder_komutu_posedge==1'b1) begin
						state<=1'b1;
						gonderilecek_data_buf<=gonderilecek_data;
					end
				end
				
				1'b1: begin
					if (data_sayisi > 0)
						data_sayisi<=data_sayisi-1;
					else begin
						data_sayisi<=3'b111;
						state<=1'b0;
					end
					
					spi_data_out<=gonderilecek_data_buf[data_sayisi];
					spi_ce<=1'b0;
				end
				default: state<=1'b0;
			endcase
		end
	end
endmodule
