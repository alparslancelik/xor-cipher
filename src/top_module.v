`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    22:18:22 12/22/2015 
// Design Name: 	-
// Module Name:    top_module 
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

module top_module
	(
		input clk, reset,
		input wire crypt, b1, b2, b3,
		output wire led_init, led_wait1,
		output wire clk_out, reset_lcd, d_c,
		output wire spi_data_out, spi_clk, spi_ce
    );

	wire encry_completed, copy_completed, en_encryption, clr_RAM, en_copier;
	wire [1:0] key;
	
	controller cont( .clk(clk), .reset(reset), .crypt(crypt), .encry_completed(encry_completed), 
					.b1(b1), .b2(b2), .b3(b3), .copy_completed(copy_completed),
					.en_encryption(en_encryption), .clr_RAM(clr_RAM), .key(key), 
					.led_init(led_init), .led_wait1(led_wait1), .en_copier(en_copier) );
	 
	datapath data ( .clk(clk), .reset(reset), .en_encryption(en_encryption), 
				.clr_RAM(clr_RAM), .key(key), .encry_completed(encry_completed), 
				.copy_completed(copy_completed), .en_copier(en_copier), .clk_out(clk_out), .reset_lcd(reset_lcd), 
				.d_c(d_c), .spi_data_out(spi_data_out), .spi_clk(spi_clk), .spi_ce(spi_ce) );

endmodule
