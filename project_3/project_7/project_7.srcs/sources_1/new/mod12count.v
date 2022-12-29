Xmodule mod12count(clk, rst, en, q, tc2);

input clk, rst, en;
output [4:0] q;
output tc2;

wire x, tco, tco1, rstn;

assign tc1 = en && tco;
assign tc2 = q[4] && q[0] && en;
assign x = q[4] && q[1];
assign rstn = rst && (~x);

bcd_ut U0(clk, rstn, en, q[3:0], tco);
mod_2_counter U1(clk, rstn, tc1, q[4], tco1);

endmodule