module logicalshiftleftVARIABLE(
	input logic [15:0] in,
	input logic [15:0] rfread, //this is the value from the rf output
	output logic [15:0] out
	);
	//this is a logical shift left by a variable amount (4 LSB of rf value)
	//coded behaviourally 
	assign out = in << rfread[3:0];
	//TECHNICALLY SHOULD HAVE A 4BIT RFREAD INPUT WHICH IS AN INDEX - CAN SORT
	//THIS LATER WHEN TESTING WHOLE DATA PATH
endmodule

