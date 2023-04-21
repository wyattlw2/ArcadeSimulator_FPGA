module mahrio_rom (
	input logic clock,
	input logic [18:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:339999] /* synthesis ram_init_file = "./mahrio/mahrio.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
