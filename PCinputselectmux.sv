module PCinputselectmux(
	output logic [1:0] out,
	input logic branch,
	input logic j,
	input logic jr
	);

	//this is the select signal for our single mux
	//selecting the PC input - the select signal 
	//depends on which one of our generated branch signal,
	//control j signal or control jr signal are high

	//assign out = branch ? 2'b01 : (j ? 2'b10 : (jr ? 2'b11 : 2'b00));

	logic [2:0] signals;

	assign {branch,j,jr} = signals;
	
	always_comb begin
		if (branch==1'b1) begin
			out = 2'b01;
		end
		else if (j==1'b1) begin		
			out = 2'b10;
		end
		else if (jr==1'b1) begin 
			out = 2'b11;
		end
		else if (branch==1'bx) begin
			out = 2'b00;
		end
	end
	
	//checks if branch is high
	//branch high - output 01
	//branch low - checks if j is high
	//j high - output 10
	//j low - checks if jr is high
	//jr high - output 11
	//jr low (i.e. all low) - output 00
	//We are able to use this approach since 3 of the 4 output
	//combinations correspond to only 1 of our 3 input signals
	//being high (the final corresponding to all input signals 
	//being low)

	//logic [2:0] signals;
	//assign {branch,j,jr} = signals;

	/*
	always_comb
	case(signals)
		3'b000  :out = 2'b00;
	endcase*/

endmodule