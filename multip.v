`timescale 1ns / 1ps

module multip(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3,b4,b5,b6,b7,b8,b9,clk,o1,o2,o3,o4,o5,o6,o7,o8,o9);
    parameter n=1;
    input [n-1:0]a1,a2,a3,a4,a5,a6,a7,a8,a9;
    
    input [n-1:0]b1,b2,b3,b4,b5,b6,b7,b8,b9;
    output reg o1,o2,o3,o4,o5,o6=0,o7=1,o8=0,o9=0;
    input clk;
    wire [n-1:0]pe_out1[18:0];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    wire [n-1:0]pe_out2[18:0];
    wire [2*n+3:0]pe_out3[18:0] ;
    wire [n-1:0]de_out1[5:0];
    wire [n-1:0]de_out2[5:0];
    reg [n-1:0]ai[0:4],bi[0:4];
    reg flag=0;
    integer j; 
    initial begin
      for (j=0;j<=4;j=j+1)
      begin
        ai[j] = 0;
        bi[j] = 0;
        end
    end
    integer i=0;
    always@(posedge clk)
//        begin
//        if(~flag)
//            begin
//                if(k<9)
//                    begin
//                        A[k]=dat;
//                        k=k+1;
//                        add=add+1;
//                    end
//                if(k>=9 && k<18)
//                    begin
//                        B[k-9]=dat;
//                        k=k+1;
//                        add<=add+1;
//                    end
//                if(k==18)
//                    flag=~flag;
//            end
//        if(flag)
            begin
                i=i+1;
                case(i)
                    1://first clock
                        begin
                            ai[0]=/*A[0]*/a1; ai[1]=/*A[1]*/a2; ai[2]=/*A[2]*/a3; ai[3]=0; ai[4]=0;
                            bi[0]=/*B[0]*/b1; bi[1]=/*B[3]*/b4; bi[2]=/*B[6]*/b7; bi[3]=0; bi[4]=0;
                        end
                    2://second clock
                        begin
                            ai[0]=0; ai[1]=/*A[3]*/a4; ai[2]=/*A[4]*/a5; ai[3]=/*A[5]*/a6; ai[4]=0;
                            bi[0]=0; bi[1]=/*B[1]*/b2; bi[2]=/*B[4]*/b5; bi[3]=/*B[7]*/b8; bi[4]=0;
                        end
                    3://third clock
                        begin
                            ai[0]=0; ai[1]=0; ai[2]=/*A[6]*/a7; ai[3]=/*A[7]*/a8; ai[4]=/*A[8]*/a9;
                            bi[0]=0; bi[1]=0; bi[2]=/*B[2]*/b3; bi[3]=/*B[5]*/b6; bi[4]=/*B[8]*/b9;
                        end
                        
                   //till 4th clock cycle everything is very fine.
                    6://6th clock, output assignment starts
                        begin
                            o1<=pe_out3[18]; //third output of 19th PE.
                            o2<=pe_out3[15]; //third output of 16th PE
                            o3<=pe_out3[11]; //thirf output of 12th PE
                            o4<=pe_out3[17]; //third outpur of 18th PE
                            o7<=pe_out3[16]; //third output of 17th PE
                            
        
                        end
                        
                   
                    7://7th clock
                        begin
                            o5<=pe_out3[18]; //third output of 19th PE
                            o6<=pe_out3[15]; //third output of 16th PE
                            o8<=pe_out3[17]; //third output of 18th PE
        
        
                        end
                    8://8th clock
                        begin
                            o9<=pe_out3[18]; //third output of 19th PE.
        
        
                        end
                    default:
                        begin
                            ai[0]=0; ai[1]=0; ai[2]=0; ai[3]=0; ai[4]=0;
                            bi[0]=0; bi[1]=0; bi[2]=0; bi[3]=0; bi[4]=0;
                        end
                endcase
            end
        //end




    //first row
    PE pe1(ai[0],bi[0],0,pe_out1[0],pe_out2[0],pe_out3[0],clk);
    PE pe2(pe_out1[0],bi[1],0,pe_out1[1],pe_out2[1],pe_out3[1],clk);
    PE pe3(pe_out1[1],bi[2],0,pe_out1[2],pe_out2[2],pe_out3[2],clk);
    De d1(pe_out1[2],bi[3],de_out1[0],de_out2[0],clk);
    De d2(de_out1[0],bi[4],de_out1[1],de_out2[1],clk);
    
    //second row
    PE pe4(ai[1],pe_out2[0],0,pe_out1[3],pe_out2[3],pe_out3[3],clk);
    PE pe5(pe_out1[3],pe_out2[1],pe_out3[0],pe_out1[4],pe_out2[4],pe_out3[4],clk);
    PE pe6(pe_out1[4],pe_out2[2],pe_out3[1],pe_out1[5],pe_out2[5],pe_out3[5],clk);
    PE pe7(pe_out1[5],de_out2[0],pe_out3[2],pe_out1[6],pe_out2[6],pe_out3[6],clk);
    De d3(pe_out1[6],de_out2[1],de_out1[2],de_out2[2],clk);
    
    //third row
    PE pe8(ai[2],pe_out2[3],0,pe_out1[7],pe_out2[7],pe_out3[7],clk);
    PE pe9(pe_out1[7],pe_out2[4],pe_out3[3],pe_out1[8],pe_out2[8],pe_out3[8],clk);
    PE pe10(pe_out1[8],pe_out2[5],pe_out3[4],pe_out1[9],pe_out2[9],pe_out3[9],clk);
    PE pe11(pe_out1[9],pe_out2[6],pe_out3[5],pe_out1[10],pe_out2[10],pe_out3[10],clk);
    PE pe12(pe_out1[10],de_out2[2],pe_out3[6],pe_out1[11],pe_out2[11],pe_out3[11],clk);
    
    //fourth row
    De d4(ai[3],pe_out2[7],de_out1[3],de_out2[3],clk);
    PE pe13(de_out1[3],pe_out2[8],pe_out3[7],pe_out1[12],pe_out2[12],pe_out3[12],clk);
    PE pe14(pe_out1[12],pe_out2[9],pe_out3[8],pe_out1[13],pe_out2[13],pe_out3[13],clk);
    PE pe15(pe_out1[13],pe_out2[10],pe_out3[9],pe_out1[14],pe_out2[14],pe_out3[14],clk);
    PE pe16(pe_out1[14],pe_out2[11],pe_out3[10],pe_out1[15],pe_out2[15],pe_out3[15],clk);
    
    //fifth row
    De d5(ai[4],de_out2[3],de_out1[4],de_out2[4],clk);
    De d6(de_out1[4],pe_out2[12],de_out1[5],de_out2[5],clk);
    PE pe17(de_out1[5],pe_out2[13],pe_out3[12],pe_out1[16],pe_out2[16],pe_out3[16],clk);
    PE pe18(pe_out1[16],pe_out2[14],pe_out3[13],pe_out1[17],pe_out2[17],pe_out3[17],clk);
    PE pe19(pe_out1[17],pe_out2[15],pe_out3[14],pe_out1[18],pe_out2[18],pe_out3[18],clk);
    

endmodule