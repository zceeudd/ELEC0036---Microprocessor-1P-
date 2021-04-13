module instructionmemory(
	input logic [15:0]a, //address (i.e. PC), can select 65,536 memory locations
	output logic [17:0]rd //output (i.e. the instruction)
	);

	//(remember we modified our instruction length to 18-bits rather than 16-bits,
	//in order to accomadate more instructions)
	reg [17:0] SRAM[65535:0];
	//defining our instruction memory

	assign rd = SRAM[a];
endmodule