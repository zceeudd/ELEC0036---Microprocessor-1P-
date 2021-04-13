module datamemory(
	input logic clk, we, //clock and write enable
	input logic [15:0]a, wd, //address to be selected and write data value, can select up to 2^16 addresses
	output logic [15:0]rd //read data value - data from selected address 'a'
	);	
	reg [15:0] SRAM[65535:0];
	//defining our RAM
	always_ff@(posedge clk)begin
		if(we)begin
			SRAM[a] <= wd;
			//RAM value at address 'a' updated on clock edge (if write 	
			//is enabled)
		end
	end
	assign rd = SRAM[a];
	//read output of our memory block is updated combinationally
endmodule