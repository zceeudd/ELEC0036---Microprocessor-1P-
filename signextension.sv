module sign_extension (
		input logic signed [3:0] imm,
		output logic signed [15:0] signimm
		);
	//input logic is the immediate value from
	//an instruction from our instruction memory 
	//the output logic is the sign-extended version
	//of our input logic 
	assign signimm = imm;
	//the logic input and output signals have to be 
	//defined as signed, otherwise the immediate value
	//does take the correct negative values, however when 
	//we do this assign step (the actual sign extension)
	//the immediate gets extended as if it is an VALUE value
	//(just zeros added), so the new sign extended value doesnt
	//keep the same value as the immediate for negative numbers. 
endmodule