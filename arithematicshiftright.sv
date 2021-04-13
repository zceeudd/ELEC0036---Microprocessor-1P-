module arithematicshiftright(
	input logic [15:0] in,
	output logic [15:0] out
	);
	//this is an arithematic shift right by 1
	//coded behaviourally 
	
	wire MSB = in[15];

	assign out = {MSB,in[15:1]};

	//arithematic shift right is simmilar to logical shift right, only now the 
	//MSB after shifting is the value of the previous MSB.
endmodule