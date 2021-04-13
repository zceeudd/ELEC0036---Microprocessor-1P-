module hiloreg(
	output logic [15:0]rd, //read data output
	input logic clk,wehilo, //clock and write enable 
	input logic [15:0]wd //write data input
	);

	reg [15:0] rf;
	//declaring a register file that holds 1 16-bit register (either hi or lo)

	
	always_ff@(negedge clk)begin
		if(wehilo)begin 
			rf <= wd;
		end
	end  

	/*	
	always_ff@(posedge wehilo)begin
		rf <= wd;
	end */

	//if the write signal is enabled then the single 16 bit register is written to
	
	assign rd = rf;
	//read port always reads the single register value

endmodule

			