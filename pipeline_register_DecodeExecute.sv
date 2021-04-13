//this is the pipeline register between the decode and execute stages

module pipeline_register_DecodeExecute(
	input logic clk, reset,
	input logic [15:0] Drd1, Drd2, //register read ports
	input logic Dmod,
	input logic [3:0] Da1, Da2, //1st and 2nd address for register file
	input logic [15:0] Dsignextimm, //sign-extended immediate
	input logic [3:0] Da3, //3rd address for register file (used for specifying destination RF address from immediate)
	input logic Dhilowrite, //control signal which is the write enable for the hi and lo registers
	input logic Dmultdiv, //mux select signal for the mux before hi and lo registers
	input logic [4:0] Dalucontrol, //alu control signal for the alu
	input logic Dalusrc, //alu source mux select signal
	input logic [1:0] Dregwrite, //mux select signal for the mux choosing the rf write address
	input logic Dwe3, //write enable for the RF
	input logic Dwe, //write enable for the data memory
	input logic [1:0] Dregdata, //mux select for the RF write data mux 
	output logic [15:0] Erd1, Erd2, 
	output logic [3:0] Ea1, Ea2, 
	output logic [15:0] Esignextimm, 
	output logic [3:0] Ea3, 
	output logic Ehilowrite,
	output logic Emultdiv, 
	output logic [4:0] Ealucontrol, 
	output logic Ealusrc, 
	output logic [1:0] Eregwrite, 
	output logic Ewe3, 
	output logic Ewe,
	output logic [1:0] Eregdata,
	output logic Emod
	);

	//this pipeline register has multiple inputs (which have all been 
	//'derived' from the F/D register output)

	//since our inputs (and therefore outputs) are of a range of sizes, we must define multiple
	//registers of different sizes

	reg [15:0] plr_DE1[2:0];
	reg [4:0] plr_DE2;
	reg [1:0] plr_DE3[1:0];
	reg plr_DE4[4:0];
	reg [3:0] plr_DE5[2:0];
	reg plr_DE6;

	always_ff@(posedge clk) begin

		if (reset) begin
		plr_DE1[0] <= 16'b0000000000000000;
		plr_DE1[1] <= 16'b0000000000000000;
		plr_DE1[2] <= 16'b0000000000000000;
		plr_DE2 <= 5'b00000;
		plr_DE3[0] <= 2'b00;
		plr_DE3[1] <= 2'b00;
		plr_DE4[0] <= 1'b0;
		plr_DE4[1] <= 1'b0;
		plr_DE4[2] <= 1'b0;
		plr_DE4[3] <= 1'b0;
		plr_DE4[4] <= 1'b0;
		plr_DE5[0] <= 4'b0000;
		plr_DE5[1] <= 4'b0000;
		plr_DE5[2] <= 4'b0000;
		plr_DE6 <= 1'b0;
		end

		else begin
		plr_DE1[0] <= Drd1;
		plr_DE1[1] <= Drd2;
		plr_DE1[2] <= Dsignextimm;
		plr_DE2 <= Dalucontrol;
		plr_DE3[0] <= Dregwrite;
		plr_DE3[1] <= Dregdata;
		plr_DE4[0] <= Dhilowrite;
		plr_DE4[1] <= Dmultdiv;
		plr_DE4[2] <= Dalusrc;
		plr_DE4[3] <= Dwe3;
		plr_DE4[4] <= Dwe;
		plr_DE5[0] <= Da1;
		plr_DE5[1] <= Da2;
		plr_DE5[2] <= Da3;
		plr_DE6 <= Dmod;
		end
	
	end

	assign Erd1 = plr_DE1[0];
	assign Erd2 = plr_DE1[1];
	assign Esignextimm = plr_DE1[2];
	assign Ealucontrol = plr_DE2;
	assign Eregwrite = plr_DE3[0];
	assign Eregdata = plr_DE3[1];
	assign Ehilowrite = plr_DE4[0];
	assign Emultdiv = plr_DE4[1];
	assign Ealusrc = plr_DE4[2];
	assign Ewe3 = plr_DE4[3];
	assign Ewe = plr_DE4[4];
	assign Ea1 = plr_DE5[0];
	assign Ea2 = plr_DE5[1];
	assign Ea3 = plr_DE5[2];
	assign Emod = plr_DE6;
	
endmodule