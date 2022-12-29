module mod60count(clk,rst,en,q,tc2);

input clk,rst,en;
output [6:0] q;
output tc2;
wire tc1,tco1,tc3;

assign tc1 = en && tco;
assign tc2 = tc1 && tco1;

bcd_ct U0(clk, rst, en, q[3:0], tco);
mod_6counter U1(clk, rst, tc1, q[6:4], tco1);

endmodule

