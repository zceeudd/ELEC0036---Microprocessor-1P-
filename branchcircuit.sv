module branchcircuit(
	input logic [1:0] branch, //this is the control signal 'branch', based on the operation
	//we choose it determines if we should alter PCsrc so as to branch
	input logic zeroflag, //this is the zeroflag output from the ALU
	output logic branchcircuitout
	);

	//I have determined and drawn the structural circuit model for this branch operation, but
	//will code its operation behaviourally
	
	always_comb
	case({branch,zeroflag})
		3'b000 :branchcircuitout = 0;
		3'b001 :branchcircuitout = 1;
		3'b010 :branchcircuitout = 1;
		3'b011 :branchcircuitout = 0;
		3'b100 :branchcircuitout = 0;
		3'b101 :branchcircuitout = 0;
		3'b110 :branchcircuitout = 0;
		3'b111 :branchcircuitout = 0;
	endcase

endmodule