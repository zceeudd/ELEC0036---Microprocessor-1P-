module PC(
	input logic clk,Fstall,
	input logic [15:0] pcnext,
	output logic [15:0] pcout
	);

	//remember our pc effectively is the address values
	//in our insruction memory. As we have 65536 total
	//instruction addresses (2^16), our PC register must be 16 bits.
	//The PC is one 16 bit word (that gets incremented)

	reg [15:0] pc;
	//PC is one 16-bit number 

	always_ff@(posedge clk) begin
		if(Fstall==1'b1) begin
			pc <= pc;
		end
		
		else begin
			pc <= pcnext;
		end
	end

	assign pcout = pc;
	//output of our pc register (effecitvely our pc value)
	//takes pc registers value immediately 

	//pc register holds a pc value (pcnext) which may simply
	//be a +1 increment of pcout, or something more complex than this
	//(e.g. in the event of branching)

endmodule