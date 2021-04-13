//note this module is effectively a top-level module for our ALU
//since our ALU incorporates other modules (e.g. adders).
module ALU(
	input logic [15:0] a, 
	input logic [15:0] b,
	input logic [4:0] ALUcontrol,
	output logic [15:0] y,
	output logic Cout,
	output logic zeroflag
	);


	////////////////////INTERNAL SIGNALS////////////////////
	wire[15:0] BB;
	wire[15:0] adderout;
	wire[15:0] zeroexout;
	wire[15:0] firstAND = a&BB;
	wire[15:0] firstOR = a|BB;
	wire[15:0] NOTfirstAND = ~firstAND;
	wire[15:0] NOTfirstOR = ~firstOR;
	//we have to define some internal signals that our instantiated modules will be using
	//and pass between eachother. 'BB' is the output signal of the first 2:1 MUX and also the
	//input signal of our adder module.
	//'adderout' is the output of our adder module and also the input signal of our final MUX,
	//the zero extender also indexes this 'adderout' signal for its input
	//'zeroexout' is the output of our zero extender, which also acts as one of the inputs to the
	//4:1 MUX
	//'firstAND' and 'firstOR' are the initial AND and OR gate outputs (taking signals 'a' and 'BB)
	//NOTfirstAND and NOTfirstOR are inversions of firstAND and firstOR

	wire[15:0] ASRout; 
	//output of arithematic shift right
	wire[15:0] LSLVout;
	//output of logical shift left (variable)
	wire[15:0] LSRVout;
	//output of logical shift right (variable)
	//////////////////////////////////////////////////////

	///////////////////INSTANTIATE ADDER////////////////
	//input 'A' of adder is just same as input 'a' of ALU
	//output 'Cout' of adder is same as output 'Cout' of ALU
	//input 'BB' of adder is the ALU input signal 'b' but after
	//going through a 2x1 multiplexer (which selects either 'B', or
	//inverted 'B') - therefore we need to create an intermediate logic
	//signal 'BB'
	//Input 'Cin' of the adder is the MSB of the ALU's 'ALUcontrol' signal,
	//so we have to specify this
	wire [1] ALUcontrolMSB = ALUcontrol[4];
	wire [4] ALUcontrolLSB = ALUcontrol[3:0];
	//THESE TWO LINES WORK WHEN USING 'WIRE' BUT NOT WHEN USING LOGIC
	//created temporary variables to split up the ALU control signal so as to input it into our seperate modules
	//accordingly - NOTE this seems to be a slightly brutish method of doing it, ideally I would should be able
	//to find some way of indexing the single 'ALUcontrol' signal and inputting indexed values into my instantiated
	//modules (kind of the opposite of the top-level module thing I did to split up the instruction memory output)
	adder ALU_adder(
	.A(a),.Cout(Cout),.BB(BB),.Cin(ALUcontrolMSB), .S(adderout)
	);
	////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////

	////////////////INSTANTIATE 2:1 MUX/////////////////////////
	//This 2:1 MUX is near the input, and is used the select either
	//'B' or the inverse of B (usually for negative arithematic) at
	//the input to our ALU
	twoTOone_mux ALU_input_mux(
	.a0(b),
	.a1(~b),
	.sel(ALUcontrolMSB),
	.out(BB)
	);
	//for this first mux (2:1) we have to input our ALU signal 'b', and an inverted
	//version of this ALU signal as 'a0' and 'a1' of the mux respectively. The select 
	//signal is the MSB of ALU signal 'ALUcontrol' and the output is our defined ALU intermediate
	//signal 'BB'.
	////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////

	/////////////////INSTANTIATE ZERO EXTENDER/////////////////
	//This zeroextender is what we use for the SLT function.
	//The zero extender takes a single bit input (MSB of the 
	//adder output) which is an index of our ALU internal signal
	//'adderout'
	//The output of the zero extender is also the ALU internal signal
	//'zeroexout'
	zeroextender ALU_zeroextender(
	.nextended(adderout[15]),.extended(zeroexout)
	);
	//////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////

	////////////////INSTANTIATE ASR////////////////////////////////
	arithematicshiftright ALU_ASR(
	.in(BB),
	.out(ASRout)
	);
	///////////////////////////////////////////////////////////////

	////////////////INSTANTIATE LSLV///////////////////////////////
	logicalshiftleftVARIABLE ALU_LSLV(
	.in(BB),.rfread(a),.out(LSLVout)
	);
	///////////////////////////////////////////////////////////////


	////////////////INSTANTIATE LSRV///////////////////////////////
	logicalshiftrightVARIABLE ALU_LSRV(
	.in(BB),.rfread(a),.out(LSRVout)
	);
	///////////////////////////////////////////////////////////////

	////////////////INSTANTIATE 16:1 MUX///////////////////////////
	//This is the final MUX in our ALU, and provides our ALU output
	//'y'
	//All of the MUX input signals will be internal ALU signals, these
	//are the output of our zero extender 'zeroexout', the output of our
	//adder 'adderout',the output of our OR and AND gates 'ORout' and
	//'ANDout' respectively and the outputs of each shifter. (The AND and OR gates take our ALU input signal
	//'a' and ALU internal signal 'BB' as inputs)
	//This MUX will also take the 3 LSB's of the ALU's input signal
	//'ALUControl', which are 'ALUControlLSB'

	sixteenTOone_mux ALU_mux(
	.a0(NOTfirstOR|firstAND),
	.a1(NOTfirstOR|firstAND),
	.a2(NOTfirstAND&firstOR),
	.a3(NOTfirstAND&firstOR),
	.a4(NOTfirstAND),
	.a5(NOTfirstAND),
	.a6(NOTfirstOR),
	.a7(NOTfirstOR),
	.a8(firstAND),
	.a9(LSRVout),
	.a10(firstOR),
	.a11(firstOR),
	.a12(adderout),
	.a13(LSLVout),
	.a14(zeroexout),
	.a15(ASRout),
	.sel(ALUcontrolLSB),
	.out(y)
	);

	////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////

	//////////////////////////ZERO FLAG/////////////////////////////
	assign zeroflag = y ? 0 : 1;
	
endmodule