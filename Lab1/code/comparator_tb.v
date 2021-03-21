`timescale 1ns / 1ps

module comparator_tb;

reg a0_in, a1_in, a2_in, a3_in,
b0_in, b1_in, b2_in, b3_in;

wire result_eq_out, result_low_out, result_gr_out;


comparator comparator_1(
.a0(a0_in),
.a1(a1_in),
.a2(a2_in),
.a3(a3_in),

.b0(b0_in),
.b1(b1_in),
.b2(b2_in),
.b3(b3_in),

.result_eq(result_eq_out),
.result_gr(result_gr_out),
.result_low(result_low_out)
);

integer i, j;
reg [4:0] test_val_a, test_val_b;

initial begin

for (i=0; i<16; i=i+1) begin
test_val_a = i;
a0_in = test_val_a[0];
a1_in = test_val_a[1];
a2_in = test_val_a[2];
a3_in = test_val_a[3];
for (j=0; j<16; j=j+1) begin
test_val_b=j;
b0_in = test_val_b[0];
b1_in = test_val_b[1];
b2_in = test_val_b[2];
b3_in = test_val_b[3];


#10

$display ("comparator output is correct. a_0=%b, a_1=%b, a_2=%b, a_3=%b, b_0=%b, b_1=%b, b_2=%b, b_3=%b, a=%b, b=%b, result_gr=%b, result_eq=%b, result_low=%b",
a0_in, a1_in, a2_in, a3_in,
b0_in, b1_in, b2_in, b3_in,
test_val_a, test_val_b, result_gr_out, result_eq_out, result_low_out);

end

end

#10 $stop;

end


endmodule
