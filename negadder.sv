//adder accomodates subtraction aswell

module negadder(
	output logic [15:0] S,
 	input logic signed [15:0] A, 
	input logic [15:0] B
	);
  always_comb
     S = A + B;
endmodule