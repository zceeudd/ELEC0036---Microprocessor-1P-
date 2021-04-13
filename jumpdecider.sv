module jumpdecider(
	input logic [5:0] opcode,
	output jumpmux
	);

	assign jumpmux = (opcode==6'b011101) ? 1'b1 : 1'b0;



endmodule
