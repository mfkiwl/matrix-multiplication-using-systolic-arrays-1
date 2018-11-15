`timescale 1ns / 1ps


module PE(a,b,c,o1,o2,o3,clk);
    input clk;
    input [7:0]a,b,c; //a,b,c are the floating point numeber
    output reg [7:0]o1,o2,o3;
    wire [7:0] mul,w;
    //assign o1 = a;
    //assign o2 = b;
    floatingPntMult(mul,a,b,clk);
    flotAdd(w,c,mul,clk);
    always@(posedge clk)
        begin
            o1=a;
            o2=b;
            o3=w;
        end
    endmodule