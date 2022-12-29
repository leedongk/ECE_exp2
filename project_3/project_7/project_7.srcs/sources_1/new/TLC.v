module trafficlight(clk,rst,x,S_W, N_W, W_W, E_W, S_E, N_E, W_E, E_E, S_GREEN, N_GREEN, W_GREEN, E_GREEN,S_GREEN, N_GREEN, W_GREEN, E_GREEN, S_RED, N_RED, W_RED, E_RED, S_LEFT, N_LEFT, W_LEFT, E_LEFT, count1, count2); // L1 : 

// x = 주간야간 구분
input clk,rst,x;
output  [11:0] S_W, N_W, W_W, E_W, S_E, N_E, W_E, E_E, S_GREEN, N_GREEN, W_GREEN, E_GREEN;
output  [11:0] S_GREEN, N_GREEN, W_GREEN, E_GREEN, S_RED, N_RED, W_RED, E_RED, S_LEFT, N_LEFT, W_LEFT, E_LEFT;
output [3:0] count1;
output [3:0] count2;
reg     [11:0] S_W, N_W, W_W, E_W, S_E, N_E, W_E, E_E, S_GREEN, N_GREEN, W_GREEN, E_GREEN;
reg     [11:0] S_GREEN, N_GREEN, W_GREEN, E_GREEN, S_RED, N_RED, W_RED, E_RED, S_LEFT, N_LEFT, W_LEFT, E_LEFT;
reg  [3:0] count1;
reg [3:0] count2;

reg [1:0] pstate, nstate;

parameter [3:0] S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;
parameter RED       = 2'b000;
parameter GREEN     = 2'b001;
parameter YELLOW    = 2'b10;

always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        pstate <= 0;
        count1 <= 0;
        end
    else
        pstate <= nstate;
end
always @(pstate)
begin
    case(pstate)
        S0 : // A
        begin
            S_W     = RED;
            S_E     = RED;
            N_W     = RED;
            N_E     = RED;
            W_W     = GREEN;
            W_E     = GREEN;
            E_W     = GREEN;
            E_E     = GREEN;
            S_GREEN = GREEN;
            N_GREEN = GREEN;
            W_RED   = RED;
            E_RED   = RED;
            if (x == 1'b0) // 주간
                nstate = S3; // D
            else
                if (count1 == 0) 
                    begin
                    nstate = S2; // C
                    count1 <= count1 + 1;
                    end
                else if (count1 == 1)
                    begin
                    nstate = S4; // E
                    count1 <= count1 - 1;
                    end
        end
        S1 : // B
        begin
            S_W     = RED;
            S_E     = RED;
            N_W     = RED;
            N_E     = RED;
            W_W     = RED;
            W_E     = RED;
            E_W     = GREEN;
            E_E     = GREEN;
            S_RED   = RED;
            N_GREEN = GREEN;
            N_LEFT  = GREEN;
            W_RED   = RED;
            E_RED   = RED; 
            if (x == 1'b1) // 야간
                nstate = S0; // A
        end
        S2 : // C
        begin
            S_W     = RED;
            S_E     = RED;
            N_W     = RED;
            N_E     = RED;
            W_W     = GREEN;
            W_E     = GREEN;
            E_W     = RED;
            E_E     = RED;
            S_LEFT  = GREEN;
            S_GREEN = GREEN;
            N_RED   = RED;
            W_RED   = RED;
            E_RED   = RED;
            if (x == 1'b1) // 야간
                nstate = S0; // A
        end
        S3 : // D
        begin
            S_W     = RED;
            S_E     = RED;
            N_W     = RED;
            N_E     = RED;
            W_W     = RED;
            W_E     = RED;
            E_W     = RED;
            E_E     = RED;
            S_LEFT  = GREEN;
            N_LEFT  = GREEN;
            W_RED   = RED;
            E_RED   = RED;
            if (x == 1'b0) // 주간
                nstate = S5; // F
        end
        S4 : // E
        begin
            S_W     = GREEN;
            S_E     = GREEN;
            N_W     = GREEN;
            N_E     = GREEN;
            W_W     = RED;
            W_E     = RED;
            E_W     = RED;
            E_E     = RED;
            S_RED   = RED;
            N_RED   = RED;
            W_GREEN = GREEN;
            E_GREEN = GREEN;
            if (x == 1'b0) // 주간
                if (count2 == 0)
                    begin
                    nstate = S6; // G 0R A 로 가야됨
                    count2 <= count2 + 1;
                    end
                else if (count2 == 1)
                    begin
                    nstate = S0; // A로 이동
                    count2 <= count2 - 1;
                    end
            else
                nstate = S7; // H
                
        end
        S5 : // F
        begin
            S_W     = RED;
            S_E     = RED;
            N_W     = GREEN;
            N_E     = GREEN;
            W_W     = RED;
            W_E     = RED;
            E_W     = RED;
            E_E     = RED;
            S_RED   = RED;
            N_RED   = RED;
            W_GREEN = GREEN;
            W_LEFT  = GREEN;
            E_RED   = RED;
            if (x == 1'b0) // 주간
                nstate = S4; // E
        end
        S6 : // G
        begin
            S_W     = GREEN;
            S_E     = GREEN;
            N_W     = RED;
            N_E     = RED;
            W_W     = RED;
            W_E     = RED;
            E_W     = RED;
            E_E     = RED;
            S_RED   = RED;
            N_RED   = RED;
            W_RED   = RED;
            E_LEFT  = GREEN;
            E_GREEN = GREEN;
            if (x == 1'b0) // 주간
                nstate = S4; // E
        end
        S7 : // H
        begin
            S_W     = RED;
            S_E     = RED;
            N_W     = RED;
            N_E     = RED;
            W_W     = RED;
            W_E     = RED;
            E_W     = RED;
            E_E     = RED;
            S_RED   = RED;
            N_RED   = RED;
            W_LEFT  = GREEN;
            E_LEFT  = GREEN;
            if (x == 1'b1) // 야간
                nstate = S1; // B
        end
    endcase
end
endmodule
                

        
        