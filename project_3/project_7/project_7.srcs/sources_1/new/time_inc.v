module time_inc(rst, key2, en, state_select);

input key2, rst, en;
output reg[2:0] state_select;
integer cnt;

always @(negedge key2 or negedge rst) begin
    if(~rst)
        begin
        cnt <= 0;
        state_select <= 3'b000;
        end
    else if(en)
        if(cnt == 0) 
            begin
            state_select = 3'b011;
            cnt <= cnt + 1;
            end
        else if(cnt == 1)
            begin
            state_select = 3'b101;
            cnt <= cnt + 1;
            end
        else if (cnt == 2)
            begin
            state_select = 3'b000;
            cnt <= 0;
            end
        else
            state_select <= 3'b000;
        end
endmodule 