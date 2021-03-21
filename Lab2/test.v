`timescale 1ns / 1ps

module test;

reg reset_reg, clk_reg;
wire clk, reset;
reg [7:0] a;
reg [7:0] b;
wire busy;
wire [23:0] y_bo;
reg start_i;

main main_1(
	.clk_i(clk_reg),
	.start_i(start_i),
	.rst_i(reset),
	.a_bi(a),
	.b_bi(b),
	.busy_o(busy),
	.y_bo(y_bo)
);

//#10

assign reset = reset_reg;
assign clk = clk_reg;

initial begin
	clk_reg = 1;
	start_i = 1;
	forever
		#10 clk_reg = ~clk_reg;
end

initial begin
	a <= 0;
	b <= 0;
	reset_reg <= 1;
end

always @(posedge clk_reg) begin
	if (reset_reg) begin
		reset_reg = 0;
	end

	if (!busy) begin
		$display("cube (%d)+ fsqr(%d) = %d", a, b, y_bo);
		if (!reset_reg) begin
			a <= a + 1;
			b <= b + 1;
		    #70 reset_reg <= 1;
		end
	end

end
//always 
endmodule