module control_unit(
	input logic [5:0] opcode,
	output logic we3,
	output logic ALUsrc,
	output logic [4:0] ALUcontrol,
	output logic we,
	output logic [1:0] regdata,
	output logic [1:0] regwrite,
	output logic j,
	output logic wehilo,
	output logic jr,
	output logic multdiv,
	output logic [1:0] branch,
	output logic mod
	);

	//this decodes the opcode and outputs the control signals for the datapath inputs

	logic [18:0] signals;
	assign {multdiv,ALUsrc,ALUcontrol,j,jr,regwrite,branch,we,regdata,we3,wehilo,mod} = signals;
	//all output (control) signals concatenated so they may be used in the following case statement	

	//TEST THIS! ...
	//always_comb
	//{multdiv,ALUsrc,ALUcontrol,j,jr,regwrite,branch,we,regdata,we3,wehilo} = signals;

	//assign opcode = 6'b011101;

	always_comb
	case(opcode)
		6'b000000  :signals = 19'b0001100000110000100; //ADD
		6'b000001  :signals = 19'b0011100000110000100; //SUB
		6'b000010  :signals = 19'b0101100000010001100; //LW
		6'b000011  :signals = 19'b0101100000010100000; //SW
		6'b000100  :signals = 19'b0001000000110000100; //AND
		6'b000101  :signals = 19'b0001010000110000100; //OR
		6'b000110  :signals = 19'b0000100000110000100; //NAND
		6'b000111  :signals = 19'b0000110000110000100; //NOR
		6'b001000  :signals = 19'b0000010000110000100; //XOR
		6'b001001  :signals = 19'b0000000000110000100; //XNOR
		6'b001010  :signals = 19'b0011000000110000100; //AND NOTB
		6'b001011  :signals = 19'b0011010000110000100; //OR NOTB
		6'b001100  :signals = 19'b0010100000110000100; //NAND NOTB
		6'b001101  :signals = 19'b0010110000110000100; //NOR NOTB
		6'b001110  :signals = 19'b0010000000110000100; //XNOR NOTB
		6'b001111  :signals = 19'b0010010000110000100; //XOR NOTB
		6'b010000  :signals = 19'b0011110000110000100; //SLT
		6'b010001  :signals = 19'b0011100000000000000; //BEQ
		6'b010010  :signals = 19'b0011100000001000000; //BNE
		6'b110011  :signals = 19'b0101100000010000100; //ADDi
		6'b010100  :signals = 19'b0000000000010000010; //MULT
		6'b010101  :signals = 19'b1000000000010000010; //DIV
		6'b010110  :signals = 19'b0000000000010010100; //mfhi
		6'b010111  :signals = 19'b0000000000010011100; //mflo
		6'b011010  :signals = 19'b0001111000110000100; //arithematic shift right
		6'b011011  :signals = 19'b0001101000110000100; //logical shift left (variable)
		6'b011100  :signals = 19'b0001001000110000100; //logical shift right (variable)
		6'b011101  :signals = 19'b0000000100010000000; //j
		6'b011110  :signals = 19'b0000000010010000000; //jr
		6'b011111 :signals = 19'b0000000000110000101; //mod
	endcase
	
endmodule