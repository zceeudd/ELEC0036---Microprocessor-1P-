module processor2(
	input logic clk
	);
	//this is the top-level module instantiating both the data path and the
	//control unit for processor 1
	//the only input the processor takes is the clk, the instructions are loaded
	//directly into instruction memory (within the datapath)
	/////////////////INTERNAL SIGNALS/////////////////////////////////////
	//These are the signals between the control unit and the datapath 
	//they are the outputs of the control unit, and inputs of the datapath
	wire we3;
	wire ALUsrc;
	wire [4:0] ALUcontrol;
	wire we;
	wire [1:0] regdata;
	wire [1:0] regwrite;
	wire wehilo;
	wire multdiv;
	wire [1:0] branch;
	wire [5:0] opcode;
	wire ALUcout;
	wire mod;
	wire j;
	wire jr;
	////////////////////////////////////////////////////////////////////////
	////////////////CONTROL UNIT////////////////////////////////////////////
	control_unit processor2_control(
	.we3(we3),.ALUsrc(ALUsrc),.ALUcontrol(ALUcontrol),.we(we),.regdata(regdata),
	.regwrite(regwrite),.wehilo(wehilo),.multdiv(multdiv),.branch(branch),
	.opcode(opcode),.j(j),.jr(jr),.mod(mod)
	);
	////////////////////////////////////////////////////////////////////////

	////////////////DATA PATH////////////////////////////////////////////
	datapath processor2_datapath(
	.we3(we3),.ALUsrc(ALUsrc),.ALUcontrol(ALUcontrol),.we(we),.regdata(regdata),
	.regwrite(regwrite),.wehilo(wehilo),.multdiv(multdiv),.branch(branch),
	.clk(clk),.ALUcout(ALUcout),.opcode(opcode),.jr(jr),.j(j),.mod(mod)
	);
	////////////////////////////////////////////////////////////////////////
	
endmodule