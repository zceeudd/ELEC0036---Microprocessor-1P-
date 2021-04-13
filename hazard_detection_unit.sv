module hazard_detection_unit(
	input logic [3:0] Daddress1, //first RF address in the DECODE stage
	input logic Mmod,
	input logic [3:0] Daddress2, //second RF adddress in the DECODE stage
	input logic [3:0] Eaddress1, //first RF address in the EXECUTE stage
	input logic [3:0] Eaddress2, //second RF adddress in the EXECUTE stage
	input logic [3:0] Erfwriteaddress, //RF write address in the EXECUTE stage
	input logic [3:0] Mrfwriteaddress, //RF write address in the MEMORY stage
	input logic [3:0] Wrfwriteaddress, //RF write address in the WRITEBACK stage
	input logic Ewe3, //write enable for the RF in the EXECUTE stage
	input logic Mwe3, //write enable for the RF in the MEMORY stage
	input logic Wwe3, //write enable for the RF in the WRITEBACK stage
	input logic [1:0] Eregdata, //mux select for choosing data for RF write in the EXECUTE stage
	input logic [1:0] Mregdata, //mux select for choosing data for RF write in the MEMORY stage
	input logic [1:0] Dbranch, //branch control signal in the DECODE stage (generated from the control unit)
	input logic Djr, //jr control signal in the DECODE stage
	input logic Dj, //j control signal in the DECODE stage
	output logic [2:0] Dforward1, //select for the first forwarding mux for branching (in the decode stage)
	output logic [2:0] Dforward2, //select for the second forwarding mux for branching (in the decode stage)
	output logic [2:0] Dforward3, //select for forwarding mux for one of the PC input mux inputs (in the decode stage)
	output logic [2:0] Eforward1, //select for the first forwarding mux for ALU (in the execute stage)
	output logic [2:0] Eforward2, //select for the second forwarding mux for ALU (in the execute stage)
	output logic Fstall,
	output logic Dstall, 
	output logic Eflush
	);

	//////ALU FORWARDING MUX's LOGIC////
	assign Eforward1 = ((Eaddress1 != 4'b0000)&&(Eaddress1 == Mrfwriteaddress)&&(Mwe3==1'b1)&&(Mregdata != 2'b11)&&(Mmod == 1'b0)&&(Mregdata != 2'b10)) ? (3'b010) : ( ((Eaddress1 != 4'b0000)&&(Eaddress1 == Wrfwriteaddress)&&(Wwe3)) ? 3'b001 : (((Eaddress1 != 4'b0000)&&(Eaddress1 == Mrfwriteaddress)&&(Mregdata == 2'b11)) ? 3'b100 : ( ((Eaddress1 != 4'b0000)&&(Eaddress1 == Mrfwriteaddress)&&(Mregdata == 2'b10)) ? 3'b011 : ( ((Eaddress1 != 4'b0000)&&(Eaddress1 == Mrfwriteaddress)&&(Mmod==1'b1)) ? 3'b101 : 3'b000 ))));
	assign Eforward2 = ((Eaddress2 != 4'b0000)&&(Eaddress2 == Mrfwriteaddress)&&(Mwe3==1'b1)&&(Mregdata != 2'b11)&&(Mmod == 1'b0)&&(Mregdata != 2'b10)) ? (3'b010) : ( ((Eaddress2 != 4'b0000)&&(Eaddress2 == Wrfwriteaddress)&&(Wwe3)) ? 3'b001 : (((Eaddress2 != 4'b0000)&&(Eaddress2 == Mrfwriteaddress)&&(Mregdata == 2'b11)) ? 3'b100 : ( ((Eaddress2 != 4'b0000)&&(Eaddress2 == Mrfwriteaddress)&&(Mregdata == 2'b10)) ? 3'b011 : ( ((Eaddress2 != 4'b0000)&&(Eaddress2 == Mrfwriteaddress)&&(Mmod==1'b1)) ? 3'b101 : 3'b000 ))));


	/////LW STALL LOGIC/////
	wire lwstall;
	
	//may need to test the functionality of this code, which can be done with a seperate sv project just testing this module and a tb that would change lwstall
	assign lwstall = (((Erfwriteaddress==Daddress1)||(Erfwriteaddress==Daddress2))&&(Eregdata == 2'b01)) ? 1'b1 : 1'b0;
	//assign Fstall = lwstall;
	//assign Dstall = lwstall;
	//assign Eflush = lwstall;

	//////BRANCH FORWARDING MUX LOGIC//// 
	assign Dforward1 = ((Daddress1 != 4'b0000)&&(Daddress1 == Mrfwriteaddress)&&(Mwe3 == 1'b1)&&(Mmod==1'b0)&&(Mregdata!=2'b10)&&(Mregdata!=2'b11)) ? (3'b001) : ( ((Daddress1 != 4'b0000)&&(Daddress1==Mrfwriteaddress)&&(Mwe3==1'b1)&&(Mregdata==2'b10)) ? (3'b010) : ( ((Daddress1 != 4'b0000)&&(Daddress1==Mrfwriteaddress)&&(Mwe3==1'b1)&&(Mregdata==2'b11)) ? (3'b011) : ( ((Daddress1 != 4'b0000)&&(Daddress1==Mrfwriteaddress)&&(Mwe3==1'b1)&&(Mmod==1'b1)) ? (3'b100) : (3'b000))));
	assign Dforward2 = ((Daddress2 != 4'b0000)&&(Daddress2 == Mrfwriteaddress)&&(Mwe3 == 1'b1)&&(Mmod==1'b0)&&(Mregdata!=2'b10)&&(Mregdata!=2'b11)) ? (3'b001) : ( ((Daddress2 != 4'b0000)&&(Daddress2==Mrfwriteaddress)&&(Mwe3==1'b1)&&(Mregdata==2'b10)) ? (3'b010) : ( ((Daddress2 != 4'b0000)&&(Daddress2==Mrfwriteaddress)&&(Mwe3==1'b1)&&(Mregdata==2'b11)) ? (3'b011) : ( ((Daddress2 != 4'b0000)&&(Daddress2==Mrfwriteaddress)&&(Mwe3==1'b1)&&(Mmod==1'b1)) ? (3'b100) : (3'b000))));

	/////////BRANCH STALLING LOGIC//////
	wire branchstall;
	assign branchstall = ((Dbranch == 2'b01 || Dbranch == 2'b00)&&(Ewe3==1'b1)&&((Erfwriteaddress==Daddress2)||(Erfwriteaddress==Daddress1))) || ((Dbranch == 2'b0x)&&(Mregdata==2'b01)&&((Mrfwriteaddress==Daddress2)||(Mrfwriteaddress==Daddress1))) ? 1'b1 : 1'b0;

	////////JUMP REGISTER FORWARDING LOGIC//
	assign Dforward3 = ((Daddress1 != 4'b0000)&&(Daddress1 == Mrfwriteaddress)&&(Mregdata != 2'b11)&&(Mregdata != 2'b10)&&(Mmod == 1'b0)&&(Mwe3)) ? 3'b001 : ( ((Daddress1 != 4'b0000)&&(Daddress1==Mrfwriteaddress)&&(Mregdata==2'b10)&&(Mwe3==1'b1))? (3'b010) : ( ((Daddress1 != 4'b0000)&&(Daddress1==Mrfwriteaddress)&&(Mregdata==2'b11)&&(Mwe3==1'b1)) ? (3'b011) : ( ((Daddress1 != 4'b0000)&&(Daddress1==Mrfwriteaddress)&&(Mmod==1'b1)&&(Mwe3==1'b1)) ? (3'b100) : (3'b000))));


	////////JUMP REGISTER STALLING LOGIC///
	wire jumpregstall;
	assign jumpregstall = ((Djr==1'b1)&&(Ewe3==1'b1)&&(Erfwriteaddress==Daddress1)) || ((Djr==1'b1)&&(Mregdata==2'b01)&&(Mrfwriteaddress==Daddress1)) ? 1'b1 : 1'b0 ;


	assign Fstall = lwstall || branchstall || jumpregstall;
	assign Dstall = lwstall || branchstall || jumpregstall;
	assign Eflush = lwstall || branchstall || jumpregstall || Dj;

endmodule