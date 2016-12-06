`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    04:40:32 12/19/2015 
// Design Name: 	-
// Module Name:    glcd 
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

module glcd
	(
		input clk, reset, ram_write_en, clr_lcd_reg,
		input [3:0] ram_W_A,
		input [7:0] ram_data,
		output clk_out, reset_lcd, d_c,
		output spi_data_out, spi_clk, spi_ce 
	);

	wire slow_clk, spi_sender;
	wire [2:0] encoder_key;
	wire [3:0] ram_R_A; 
	wire [6:0] char_rom_address;
	wire [7:0] parallel_data, encoder_out, char_binary;
	wire [39:0] char_disp_out;
	
	spi_communicator spi_com( .clk(clk), .reset(reset), 
			.encoder_out(encoder_out),
			.clk_out(clk_out), .reset_lcd(reset_lcd), .d_c(d_c),
			.spi_sender(spi_sender), .slow_clk(slow_clk),
			.encoder_key(encoder_key), .ram_R_A(ram_R_A), 
			.parallel_data(parallel_data) );
	
	spi_sender spi_sen( .clk(slow_clk), .reset(reset), 
						.gonderilecek_data(parallel_data), .gonder_komutu_posedge(spi_sender), 
						.spi_data_out(spi_data_out), .spi_clk(spi_clk), .spi_ce(spi_ce) );
	
	ascii_to_char_encoder ascii_encoder( .char(char_binary), 
					.key(encoder_key), .char_disp_out(char_disp_out),
					.out(encoder_out), .char_rom_address(char_rom_address)  );
	
	rom_glcd rom( .clk(clk), .reset(1'b0), .R_A(char_rom_address), .R_D(char_disp_out) );
	
	register_8x16bit lcd_register ( .clk(clk), .clr(clr_lcd_reg), 
					.W_E(ram_write_en), .W_A(ram_W_A), .W_D(ram_data), 
					.R_A(ram_R_A), .R_D(char_binary) );
endmodule
