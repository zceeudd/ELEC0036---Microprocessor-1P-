module sixteenTOone_mux
	(
	input logic [15:0] a0,
	input logic [15:0] a1,
	input logic [15:0] a2,
	input logic [15:0] a3,	
	input logic [15:0] a4,
	input logic [15:0] a5,
	input logic [15:0] a6,
	input logic [15:0] a7,
	input logic [15:0] a8,
	input logic [15:0] a9,
	input logic [15:0] a10,
	input logic [15:0] a11,
	input logic [15:0] a12,
	input logic [15:0] a13,
	input logic [15:0] a14,
	input logic [15:0] a15,
	input logic [3:0] sel,
	output logic [15:0] out
	);

	assign out = sel[3] ? (sel[2] ? (sel[1] ? (sel[0] ? a15 : a14) : (sel[0] ? a13 : a12)) : (sel[1] ? (sel[0] ? a11 : a10) : (sel[0] ? a9 : a8))) : (sel[2] ? (sel[1] ? (sel[0] ? a7 : a6) : (sel[0] ? a5 : a4)) : (sel[1] ? (sel[0] ? a3 : a2) : (sel[0] ? a1 : a0)));  
endmodule