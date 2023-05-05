module sprite_rip_rom (
	input logic clock,
	input logic [17:0] address,
	output logic [7:0] q
);

logic [7:0] memory [0:179999] /* synthesis ram_init_file = "./sprite_rip/sprite_rip.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
