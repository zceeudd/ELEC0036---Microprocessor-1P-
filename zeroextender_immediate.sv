module zeroextender_immediate(
	input logic [3:0] nextended,
	output logic [15:0] extended
	);
	logic extend = 12'b000000000000;
	assign extended =  {extend,nextended};
endmodule
