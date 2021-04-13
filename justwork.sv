module justwork(
	input logic jr,
	input logic branchcircuit,
	output logic [1:0] justworkout
	);

	//assign justworkout = jr ? 1'b1 : j ? 1'b1 : branch ? 1'b1 : 1'b0;
	//assign justworkout = 2'b00;
	//assign justworkout = (branchcircuit == 1'bx) ? 2'b00 : ( (branchcircuit == 1'b0) ? 2'b00 : 2'b00); 
	

	//this block below works
	/*
	always_comb begin

	if (branchcircuit == 1'b1) begin
		justworkout = 2'b01;
	end
	else begin
		justworkout = 2'b00;
	end

	end
	*/

	//this block below works
	/*
	always_comb begin

	if (branchcircuit == 1'b1 && j == 1'b1) begin
		justworkout = 2'b01;
	end
	else begin
		justworkout = 2'b00;
	end

	end 
	*/

	//this block below works
	/*	
	always_comb begin

	if (branchcircuit == 1'b1 && j == 1'b1) begin
		justworkout = 2'b01;
	end
	
	else if (branchcircuit == 1'b1) begin
		justworkout = 2'b10;
	end

	else begin
		justworkout = 2'b00;
	end
	
	end
	*/

	//this one below works
	always_comb begin

	if (branchcircuit == 1'b1) begin
		justworkout = 2'b01;
	end
	
	else if (jr == 1'b1) begin
		justworkout = 2'b11;
	end

	else begin
		justworkout = 2'b00;
	end
	
	end
	

endmodule

	