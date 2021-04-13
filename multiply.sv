module multiply #(parameter N=16)
	(
	input logic [N-1:0] a,b,
	output logic [2*N-1:0] y
	);
	assign y  = a*b;
	//multiplier coded behaviourally
endmodule
