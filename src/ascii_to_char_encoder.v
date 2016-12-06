`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:	-
// Engineer: Ahmet Alparslan Celik
// 
// Create Date:    18:22:43 12/05/2015 
// Design Name: 	-
// Module Name:    Register4x4bit 
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
module ascii_to_char_encoder(
	input [7:0] char,
	input [2:0] key,
	input [39:0] char_disp_out,
	output reg [7:0] out,
	output reg [6:0] char_rom_address );
	
	// Output logic
	always@(key or char_disp_out)
		case(key)
			3'b000: out = char_disp_out[39:32];
			3'b001: out = char_disp_out[31:24];
			3'b010: out = char_disp_out[23:16];
			3'b011: out = char_disp_out[15:8];
			3'b100: out = char_disp_out[7:0];
			3'b101: out = 8'h00;
			default: out = 8'hxx;
		endcase
	
	// Encoder for chars
	always@(char)
		case(char)
			8'h20: char_rom_address = 0; //
			8'h21: char_rom_address = 1; // !
			8'h22: char_rom_address = 2; // "
			8'h23: char_rom_address = 3; // #
			8'h24: char_rom_address = 4; // $
			8'h25: char_rom_address = 5; // %
			8'h26: char_rom_address = 6; // &
			8'h27: char_rom_address = 7; // '
			8'h28: char_rom_address = 8; // (
			8'h29: char_rom_address = 9; // )
			8'h2a: char_rom_address = 10; // *
			8'h2b: char_rom_address = 11; // +
			8'h2c: char_rom_address = 12; // ,
			8'h2d: char_rom_address = 13; // -
			8'h2e: char_rom_address = 14; // .
			8'h2f: char_rom_address = 15; // /
			8'h30: char_rom_address = 16; // 0
			8'h31: char_rom_address = 17; // 1
			8'h32: char_rom_address = 18; // 2
			8'h33: char_rom_address = 19; // 3
			8'h34: char_rom_address = 20; // 4
			8'h35: char_rom_address = 21; // 5
			8'h36: char_rom_address = 22; // 6
			8'h37: char_rom_address = 23; // 7
			8'h38: char_rom_address = 24; // 8
			8'h39: char_rom_address = 25; // 9
			8'h3a: char_rom_address = 26; // :
			8'h3b: char_rom_address = 27; // ;
			8'h3c: char_rom_address = 28; // <
			8'h3d: char_rom_address = 29; // =
			8'h3e: char_rom_address = 30; // >
			8'h3f: char_rom_address = 31; // ?
			8'h40: char_rom_address = 32; // @
			8'h41: char_rom_address = 33; // A
			8'h42: char_rom_address = 34; // B
			8'h43: char_rom_address = 35; // C
			8'h44: char_rom_address = 36; // D
			8'h45: char_rom_address = 37; // E
			8'h46: char_rom_address = 38; // F
			8'h47: char_rom_address = 39; // G
			8'h48: char_rom_address = 40; // H
			8'h49: char_rom_address = 41; // I
			8'h4a: char_rom_address = 42; // J
			8'h4b: char_rom_address = 43; // K
			8'h4c: char_rom_address = 44; // L
			8'h4d: char_rom_address = 45; // M
			8'h4e: char_rom_address = 46; // N
			8'h4f: char_rom_address = 47; // O
			8'h50: char_rom_address = 48; // P
			8'h51: char_rom_address = 48; // Q
			8'h52: char_rom_address = 50; // R
			8'h53: char_rom_address = 51; // S
			8'h54: char_rom_address = 52; // T
			8'h55: char_rom_address = 53; // U
			8'h56: char_rom_address = 54; // V
			8'h57: char_rom_address = 55; // W
			8'h58: char_rom_address = 56; // X
			8'h59: char_rom_address = 57; // Y
			8'h5a: char_rom_address = 58; // Z
			8'h5b: char_rom_address = 59; // [
			8'h5c: char_rom_address = 60; // \
			8'h5d: char_rom_address = 61; // ]
			8'h5e: char_rom_address = 62; // ^
			8'h5f: char_rom_address = 63; // _
			8'h60: char_rom_address = 64; // `
			8'h61: char_rom_address = 65; // a
			8'h62: char_rom_address = 66; // b
			8'h63: char_rom_address = 67; // c
			8'h64: char_rom_address = 68; // d
			8'h65: char_rom_address = 69; // e
			8'h66: char_rom_address = 70; // f
			8'h67: char_rom_address = 71; // g
			8'h68: char_rom_address = 72; // h
			8'h69: char_rom_address = 73; // i
			8'h6a: char_rom_address = 74; // j
			8'h6b: char_rom_address = 75; // k
			8'h6c: char_rom_address = 76; // l
			8'h6d: char_rom_address = 77; // m
			8'h6e: char_rom_address = 78; // n
			8'h6f: char_rom_address = 79; // o
			8'h70: char_rom_address = 80; // p
			8'h71: char_rom_address = 81; // q
			8'h72: char_rom_address = 82; // r
			8'h73: char_rom_address = 83; // s
			8'h74: char_rom_address = 84; // t
			8'h75: char_rom_address = 85; // u
			8'h76: char_rom_address = 86; // v
			8'h77: char_rom_address = 87; // w
			8'h78: char_rom_address = 88; // x
			8'h79: char_rom_address = 89; // y
			8'h7a: char_rom_address = 90; // z
			8'h7b: char_rom_address = 91; // {
			8'h7c: char_rom_address = 92; // |
			8'h7d: char_rom_address = 93; // }
			8'h7e: char_rom_address = 94; // ~
			8'h7f: char_rom_address = 95; // DEL
			default: char_rom_address = 0; // ~
		endcase
		
endmodule
