//I have made dedicated pipeline register modules for each of my 4 pipeline register
//to avoid confusion

module pipeline_register_pc(
	input logic clk,
	input logic [15:0] pipeline_in,
	output logic [15:0] pipeline_out
	);

	reg [15:0] plr_pc;
	//pipeline is a sing 16-bit number, simply storing the PC 

	always_ff@(posedge clk) begin
		plr_pc <= pipeline_in;
	end

	assign pipeline_out = plr_pc;
	
	//this module is effectively the same as the PC
endmodule

