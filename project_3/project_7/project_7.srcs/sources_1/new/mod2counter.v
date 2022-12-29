module mod_2counter(clk, rst, en, q, tco);

input clk, rst, en;
output reg q;
output reg tco;

always @(negedge rst or posedge clk)
    if (~rst)
        begin
        q <= 1'b0;
        tco <= 1'b0;
        end
    else if (q == 1'd0)
        begin
        q <= q + 1'b1;
        tco <= 1'b0;
        end
    else
        begin
        q <= 1'b0;
        tco <= 1'b1;
        end
endmodule