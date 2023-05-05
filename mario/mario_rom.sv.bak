module mario_rom (
	input logic clock,
	input logic [16:0] address,
	output logic [7:0] q
);

logic [7:0] memory [0:83999] /* synthesis ram_init_file = "./mario/mario.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
