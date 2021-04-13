module fourTOone_mux
	(
	input logic [3:0] a0,
	input logic [3:0] a1,
	input logic [3:0] a2,
	input logic [3:0] a3,
	input logic [1:0] sel,
	output logic [3:0] out
	);
	assign out = sel[1] ? (sel[0] ? a3 : a2) : (sel[0] ? a1 : a0); 
endmodule
