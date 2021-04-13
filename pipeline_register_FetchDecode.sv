//this is the pipeline register between the fetch and decode stage

//this register takes the instruction from the FETCH stage, and then, rather
//than simply pushing a single output (the instruction in the DECODE stage, 
//which would then be indexed in the DECODE stage) it indexes the FETCH instruction
//within the pipeline itself so that its outputs in the DECODE stage are already 
//correctly indexed (NOTE: despite coding in this way, we have still outputted the
//whole instruction in the DECODE stage aswell, so that it may still be indexed
//in the DECODE stage if we decide do this instead)

module pipeline_register_FetchDecode(
	input logic clk, reset, Dstall,
	input logic [17:0] Finstruction,
	input logic [15:0] Finstruction_increment,//
	output logic [17:0] Dinstruction,
	output logic [15:0] Dinstruction_increment,//
	output logic [3:0] Daddress1,
	output logic [3:0] Daddress2,
	output logic [3:0] Dimmediate,
	output logic [11:0] Djumpaddress,
	output logic [5:0] Dopcode
	);

	reg [17:0] plr_FD1;
	//since our instructions are 18-bits long, this fetch/decode pipeline
	//register will be the only register with 18-bit values instead of 
	//16-bit

	reg [3:0] plr_FD2[1:0];
	//this second set of registers stores the two RF addresses 

	reg [3:0] plr_FD3;
	//this register holds the immediate from the instruction 
	
	reg [11:0] plr_FD4;
	//this register holds the jump address (least significant 12 bits of a jump instruction)

	reg [5:0] plr_FD5;
	//this register stores the opcode 

	reg [15:0] plr_FD6;
	//this register stores the incremented program counter
	
	wire [11:0] jumpaddress = Finstruction[11:0];
	wire [5:0] opcode = Finstruction[17:12];
	wire [3:0] address1 = Finstruction[11:8];
	wire [3:0] address2 = Finstruction[7:4];
	wire [3:0] immediate = Finstruction[3:0];

	always_ff@(posedge clk) begin

		 if (Dstall==1'b1) begin
			plr_FD1 <= plr_FD1;
			plr_FD2[0] <= plr_FD2[0];
			plr_FD2[1] <= plr_FD2[1];
			plr_FD3 <= plr_FD3;
			plr_FD4 <= plr_FD4;
			plr_FD5 <= plr_FD5;
			plr_FD6 <= plr_FD6;
		end


		else if(reset==1'b1) begin
			plr_FD1 <= 18'b000000000000000000;
			plr_FD2[0] <= 4'b0000;
			plr_FD2[1] <= 4'b0000;
			plr_FD3 <= 4'b0000;
			plr_FD4 <= 12'b000000000000;
			plr_FD5 <= 6'b000000;
			plr_FD6 <= 16'b0000000000000000;
		end


		else begin
			plr_FD1 <= Finstruction;
			plr_FD2[0] <= address1;
			plr_FD2[1] <= address2;
			plr_FD3 <= immediate;
			plr_FD4 <= jumpaddress;
			plr_FD5 <= opcode;
			plr_FD6 <= Finstruction_increment;
		end
	
	end
	
	
	

	assign Djumpaddress = plr_FD4;
	assign Dopcode = plr_FD5;

	assign Dinstruction = plr_FD1;

	assign Daddress1 = plr_FD2[0];
	assign Daddress2 = plr_FD2[1];

	assign Dimmediate = plr_FD3;

	assign Dinstruction_increment = plr_FD6;
	
endmodule