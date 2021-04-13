module equality(
	input logic [15:0] input1,
	input logic [15:0] input2,
	output logic flag
	);
	
	assign flag = (input1 == input2) ? 1'b1 : 1'b0;

endmodule