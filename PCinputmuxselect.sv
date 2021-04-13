module PCinputmuxselect(
	input logic [1] br,
	input logic [1] j,
	input logic [1] jr,
	output logic [1:0] pcinputmuxselect
	);

	logic [2:0] signals;
	
	assign {br,j,jr} = signals; 

	always_comb
	case(signals)
		3'b100  : pcinputmuxselect = 2'b01; //Branch
		3'b010  : pcinputmuxselect = 2'b10; //Jump
		3'b001  : pcinputmuxselect = 2'b11; //Jump Register
		3'b000  : pcinputmuxselect = 2'b00;
		3'b011  : pcinputmuxselect = 2'b00; 
		3'b101  : pcinputmuxselect = 2'b00; 
		3'b110  : pcinputmuxselect = 2'b00; 
		3'b111  : pcinputmuxselect = 2'b00; 
		3'bxxx  : pcinputmuxselect = 2'b00;
	endcase


endmodule