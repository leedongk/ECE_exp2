module stateseg(input wire [6:0] bcd, output reg [20:0] seg);

always @*
    case(bcd)
    7'b101_0000 : seg = 21'b0010010_1111001_0001000 ; // state = S1 , A
    7'b101_0110 : seg = 21'b0010010_0100100_0001000 ; // state = S1 , A
    7'b101_1010 : seg = 21'b0010010_0110000_0001000 ; // state = S1 , A
    7'b101_0001 : seg = 21'b0010010_1111001_0001100 ; // state = S1 , P
    7'b101_0111 : seg = 21'b0010010_0100100_0001100 ; // state = S1 , P
    7'b101_1000 : seg = 21'b0010010_0110000_0001100 ; // state = S1 , P
    
    default : seg = 21'b000000000000000111111 ;
    endcase
    
endmodule