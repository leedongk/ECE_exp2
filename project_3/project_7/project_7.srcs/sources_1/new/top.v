module top(clk, rst, key1, key2, key3, sw0, leds, HEX0, HEX1, HEX2, HEX3, HEX4, HEX6, HEX7. led, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, LCD_ON);

input clk, rst, key1, key2, key3, sw0;

output [7:0] leds;
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;
output [6:0] HEX6;
output [6:0] HEX7;
output led;
output [7:0] LCD_DATA;
output LCD_RW, LCD_EN, LCD_RS, LCD_ON;

wire en, alm, tick;
wire [19:0] q, q1, q2;
wire [2:0] mode, state_select;
wire [1:0] lcdmod;
wire twokhz, onehz;

assign en = 1'b1;
assign q = (mode[0] == 0) ? q1 : ((mode[1] == 1) ? q1 : q2);

modsel U0(en, key1, twokhz, mode);

altpll_2Khz U1(clk,twokhz);
mod_2000counter U2(twokhz, rst, en, onehz);

OS U3(key3, twokhz, tick);

clock U4(onehzltick, rst, en, mode[1], tick, {state_select[2] & mode[1], (state_select[1] & mode[1]), ((~state_select[0]) & mode[1])}, q1);

time_inc U5 (rst, key2, mode[1], state_select);

time_set U6 (twokhz, rst, en & mode[2], key2, key3, q1[6:0], q2);

ledout U7(q[3:0], leds[3:0]);
ledout U8({1'b0, q[6:4]}, leds[7:4]);
hexseg U9(q[10:7], HEX0[6:0]);
hexseg U10({1'b0,q[13:11]}, HEX1[6:0]);
hexseg U11(q[17:14], HEX2[6:0]);
hexseg U12({3'b000,q[18]}, HEX3[6:0]);
stateseg U13({3'b101, mode[2:0], q[19]}, {HEX7[6:0], HEX6[6:0], HEX4[6:0]});
kit_lcd U14(clk, 1'b1, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, LCD_ON);
endmodule
