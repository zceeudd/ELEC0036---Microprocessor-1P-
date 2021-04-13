module pipeline_register_MemoryWriteback(
	input logic clk,
	input logic [15:0] Mhi, Mlo, //outputs of hi and lo registers
	input logic [15:0] Malu, //output of ALU
	input logic [15:0] Mdmout, //output of datamemory
	input logic [3:0] Mwriteadd, //output of mux selecting which address in the RF to write to
	input logic [1:0] Mregdata, //mux select for the RF write data mux
	input logic Mwe3, //RF write enable
	input logic [15:0] Mmodout,
	input logic Mmod,
	
 	output logic [15:0] Whi, Wlo, //outputs of hi and lo registers
	output logic [15:0] Walu, //output of ALU
	output logic [15:0] Wdmout, //output of datamemory
	output logic [3:0] Wwriteadd, //output of mux selecting which address in the RF to write to
	output logic [1:0] Wregdata, //mux select for the RF write data mux
	output logic Wwe3, //RF write enable
	output logic [15:0] Wmodout,
	output logic Wmod
	);

	reg [15:0] plr_DE1[3:0];
	reg [1:0] plr_DE2;
	reg plr_DE3;
	reg [3:0] plr_DE4;
	reg [15:0] plr_DE5;
	reg plr_DE6;
	

	always_ff@(posedge clk) begin
		plr_DE1[0] <= Mhi;
		plr_DE1[1] <= Mlo;
		plr_DE1[2] <= Malu;
		plr_DE1[3] <= Mdmout;
		plr_DE2 <= Mregdata;
		plr_DE3 <= Mwe3;
		plr_DE4 <= Mwriteadd;
		plr_DE5 <= Mmodout;
		plr_DE6 <= Mmod;
	end

	assign Whi = plr_DE1[0];
	assign Wlo = plr_DE1[1];
	assign Walu = plr_DE1[2];
	assign Wdmout = plr_DE1[3];
	assign Wwriteadd = plr_DE4;
	assign Wregdata = plr_DE2;
	assign Wwe3 = plr_DE3;
	assign Wmodout = plr_DE5;
	assign Wmod = plr_DE6;

endmodule




