module processor2_tb();

	logic clk;

	processor2 processor2TEST(
	.clk(clk)
	);

	initial begin
	clk = 0;
	processor2TEST.processor2_datapath.data_PC.pc=16'b0000000000000000;
	$readmemh("global_test1_proper2.dat",processor2TEST.processor2_datapath.data_im.SRAM);
	forever #10ps clk = ~clk;
	end

endmodule
	
