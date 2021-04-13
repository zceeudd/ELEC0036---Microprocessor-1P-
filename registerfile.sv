module registerfile(
	output logic [15:0]rd1,rd2, //read data outputs
	input logic clk,we3, //clock and write enable
	input logic [3:0]ra1,ra2,wa3, //read and write address (read/write ports)
	input logic [15:0]wd3 //write data input
	);

	reg [15:0] rf[15:0];
	//declaring a register file that holds 16 16-bit registers

	always_ff@(negedge clk)begin
		if(we3)begin 
			rf[wa3] <= wd3;
		end
	end
	

	assign rd1 = (ra1 != 4'b0000) ? rf[ra1] : 16'b0000000000000000;
	assign rd2 = (ra2 != 4'b0000) ? rf[ra2] : 16'b0000000000000000;
/*
	always_ff@(negedge clk) begin
		rd1 <= (ra1 != 4'b0000) ? rf[ra1] : 16'b0000000000000000;	
		rd2 <= (ra2 != 4'b0000) ? rf[ra2] : 16'b0000000000000000;
	end*/

	


		//It is a three ported register file, two ports are read combinationally
		//(read data outputs - rd1/rd2) which is why blocking assignments are used
		//in the always_ff block. The third port is written to on the rising
		//edge of the clock (wa3) which is why we use the non-blocking assignment
		//for this in the if statement.

endmodule

			