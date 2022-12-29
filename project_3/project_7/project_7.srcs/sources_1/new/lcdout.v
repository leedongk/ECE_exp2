module ledout(input [3:0] bcd, output reg[3:0] led);

always@*
    case(bcd)
    
    4'b0000 : led = 4'b0000; // 0
    4'b0001 : led = 4'b0001; // 1
    4'b0010 : led = 4'b0010; // 2
    4'b0011 : led = 4'b0011; // 3
    4'b0100 : led = 4'b0100; // 4
    4'b0101 : led = 4'b0101; // 5
    4'b0110 : led = 4'b0110; // 6
    4'b0111 : led = 4'b0111; // 7
    4'b1000 : led = 4'b1000; // 8
    4'b1001 : led = 4'b1001; // 9
    default : led = 4'b0000;
    endcase
endmodule