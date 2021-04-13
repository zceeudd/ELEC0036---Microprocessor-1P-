module zeroextender(
	input logic nextended,
	output logic [15:0] extended
	);
	logic extend = 15'b000000000000000;
	assign extended =  {extend,nextended};
endmodule