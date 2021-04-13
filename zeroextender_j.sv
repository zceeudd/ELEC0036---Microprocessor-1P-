module zeroextender_j(
	input logic [11:0] nextended,
	output logic [15:0] extended
	);
	logic extend = 4'b0000;
	assign extended =  {extend,nextended};
endmodule