module mario_rom (
	input logic clock,
	input logic [9:0] address,
	output logic [4:0] q
);

logic [4:0] memory [0:799] /* synthesis ram_init_file = "./mario/mario.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
