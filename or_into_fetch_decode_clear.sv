module or_into_fetch_decode_clear(
	input logic jr, branchout,
	output logic fetch_decode_clear
	);

	assign fetch_decode_clear = jr ? 1'b1 : branchout ? 1'b1 : 0 ;

endmodule