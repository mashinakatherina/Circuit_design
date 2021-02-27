`timescale 1ns / 1ps

module comparator(
input a0,
input a1,
input a2,
input a3,

input b0,
input b1,
input b2,
input b3,

output result_gr,
output result_eq,
output result_low

);

wire not_b0, not_b1, not_b2, not_b3,
t1, t2, t3, t4,
an0, an1, an2, an3, 
ax1, ax2, ax3, ax4, ax5, ax6;

nand(not_b0, b0, b0);
nand(not_b1, b1, b1);
nand(not_b2, b2, b2);
nand(not_b3, b3, b3);

xnor (t1, a0, b0);
xnor (t2, a1, b1);
xnor (t3, a2, b2);
xnor (t4, a3, b3);

and (an0,a0, not_b0);
and (an1,a1, not_b1);
and (an2,a2, not_b2);
and (an3,a3, not_b3);

and (result_eq, t1, t2, t3, t4);

and (ax4, an0, t2, t3, t4);

and (ax5, ax7, an1, t3);

and (ax6, an3, t4);

or (result_gr, ax4, ax5, ax6, an3);

not (result_low, result_eq, result_gr);

endmodule