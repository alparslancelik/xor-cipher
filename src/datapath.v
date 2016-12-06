`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    04:38:04 12/19/2015 
// Design Name: 	-
// Module Name:    datapath 
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

module datapath
	(
		input clk, reset,
		input wire en_encryption, clr_RAM, en_copier,
		input wire [1:0] key,
		output wire encry_completed, copy_completed,
		output wire clk_out, reset_lcd, d_c,
		output wire spi_data_out, spi_clk, spi_ce
    );
	
	wire en_RAM, w_en;
	wire [3:0] rw_address, r_a1, r_a2, r_a3, c_text_ram_W_A, 
					c_key_ram_W_A, r_a_mux1, r_a_mux2;
	wire [7:0] ram_data1, ram_data2, r_d1, r_d2, r_d3, cipher_data;
	
	glcd lcd( .clk(clk), .reset(reset), .ram_write_en(en_RAM), .clr_lcd_reg(clr_RAM),
		.ram_W_A(rw_address), .ram_data(ram_data1), .clk_out(clk_out), 
		.reset_lcd(reset_lcd), .d_c(d_c), .spi_data_out(spi_data_out), 
		.spi_clk(spi_clk), .spi_ce(spi_ce) );
	
	register_copier reg_copier( .clk(clk), .reset(en_copier), .RAM_data(ram_data2), 
			.tRAM_CLR(), .tRAM_W_EN(en_RAM), .spi_com_reset(), 
			.SU_completed(copy_completed), .RAM_WR_A(rw_address), .tRAM_data(ram_data1) );
	//tRAM_CLR() -> clr_lcd_reg()
	connector connect( .key(key), .r_d1(r_d1), .r_d2(r_d2), .r_d3(r_d3), .r_a_in(rw_address),
					.r_a1(r_a1), .r_a2(r_a2), .r_a3(r_a3), .r_d_out(ram_data2) );
	
	ptext_rom_8x16bit plain_text( .clk(clk), .reset(reset), .R_A(r_a_mux1), .R_D(r_d1) );
	
	key_rom_8x16bit key_text( .clk(clk), .reset(reset), .R_A(r_a_mux2), .R_D(r_d2) );
	
	mux2to1_4bit mux1( .in1(r_a2), .in2(c_key_ram_W_A), .key(en_encryption), .out(r_a_mux2) );
	
	mux2to1_4bit mux2( .in1(r_a1), .in2(c_text_ram_W_A), .key(en_encryption), .out(r_a_mux1) );
	
	register_8x16bit cipher_text ( .clk(clk), .clr(clr_RAM), 
					.W_E(w_en), .W_A(c_text_ram_W_A), .W_D(cipher_data), 
					.R_A(r_a3), .R_D(r_d3) );
					
	encryption encrypt( .clk(clk), .en(en_encryption), .text_data(r_d1), .key_data(r_d2), 
		.cipher_w_en(w_en), .finished(encry_completed), .text_address_ctr(c_text_ram_W_A), 
		.key_address_ctr(c_key_ram_W_A), .cipher_data(cipher_data) );
	
endmodule
