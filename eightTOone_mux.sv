module eightTOone_mux
	(
	input logic [15:0] a0,
	input logic [15:0] a1,
	input logic [15:0] a2,
	input logic [15:0] a3,	
	input logic [15:0] a4,
	input logic [15:0] a5,
	input logic [15:0] a6,
	input logic [15:0] a7,
	input logic [2:0] sel,
	output logic [15:0] out
	);
	assign out = sel[2] ? (sel[1] ? (sel[0] ? a7 : a6) : (sel[0] ? a5 : a4)) : (sel[1] ? (sel[0] ? a3 : a2) : (sel[0] ? a1 : a0)); 
endmodule