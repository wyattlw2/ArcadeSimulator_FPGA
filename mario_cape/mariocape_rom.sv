module mariocape_rom (
	input logic clock,
	input logic [9:0] address,
	output logic [3:0] q
);

logic [3:0] memory [0:799] /* synthesis ram_init_file = "./mariocape/mariocape.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
