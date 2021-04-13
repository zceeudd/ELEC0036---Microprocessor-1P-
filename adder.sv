module adder(
	output logic [15:0] S,
	output logic Cout,
 	input logic [15:0] A, BB,
 	input logic Cin 
	);
  always_comb
     {Cout, S} = A + BB + Cin;
endmodule