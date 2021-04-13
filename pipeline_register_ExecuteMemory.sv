//this is the pipeline register between the execute and memory stages

module pipeline_register_ExecuteMemory(
	input logic clk,
	input logic Emod, //modulus control signal in the EXECUTE stage
	input logic [15:0] Ehi, Elo, //outputs of hi and lo registers
	input logic [15:0] Ealu, //output of ALU
	input logic [15:0] Edmwrite, //value to be written to data memory (if this is being done)
	input logic Ewe3, //write enable for the RF
	input logic Ewe, //write enable for the data memory
	input logic [1:0] Eregdata, //mux select for the RF write data mux 
	input logic [3:0] Ewriteadd, //output of mux selecting which address in the RF to write to
	input logic [15:0] Emodout, //modulus output of the divide circuit in the EXECUTE stage
	output logic [15:0] Mhi, Mlo, //outputs of hi and lo registers
	output logic [15:0] Malu, //output of ALU
	output logic [15:0] Mdmwrite, //value to be written to data memory (if this is being done)
	output logic Mwe3, //write enable for the RF
	output logic Mwe, //write enable for the data memory
	output logic [1:0] Mregdata, //mux select for the RF write data mux 
	output logic [3:0] Mwriteadd, //output of mux selecting which address in the RF to write to
	output logic [15:0] Mmodout, //modulus output in the MEMORY stage
	output logic Mmod //modulus control signal in the MEMORY stage
	);

	reg [15:0] plr_DE1[3:0];
	reg [1:0] plr_DE2 [1:0];
	reg [1:0] plr_DE3;
	reg [3:0] plr_DE4;
	reg [15:0] plr_DE5; //modulus value
	reg plr_DE6; //modulus control signal

	always_ff@(posedge clk) begin 

		plr_DE1[0] <= Ehi;
		plr_DE1[1] <= Elo;
		plr_DE1[2] <= Ealu;
		plr_DE1[3] <= Edmwrite;
		plr_DE2[0] <= Ewe3;
		plr_DE2[1] <= Ewe;
		plr_DE3 <= Eregdata;	
		plr_DE4 <= Ewriteadd;	
		plr_DE5 <= Emodout;
		plr_DE6 <= Emod;

	end

	assign Mhi = plr_DE1[0];
	assign Mlo = plr_DE1[1];
	assign Malu = plr_DE1[2];
 	assign Mdmwrite = plr_DE1[3];
	assign Mwriteadd = plr_DE4;
	assign Mwe3 = plr_DE2[0]; 
	assign Mwe = plr_DE2[1];
	assign Mregdata = plr_DE3;
	assign Mmodout = plr_DE5;
	assign Mmod = plr_DE6;

endmodule

