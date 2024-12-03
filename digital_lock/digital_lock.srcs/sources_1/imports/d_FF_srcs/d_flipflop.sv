`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 06:39:40 PM
// Design Name: 
// Module Name: d_flipflop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module d_flipflop(
//        input logic clk,
//        input logic areset,
//        input logic en,
//        input logic d,
//        output logic qm,
//        output logic qs

//    );
    
//    d_latch_asynch master(.d(d), .clk(clk), .en(en), .areset(areset), .q(qm));
//    d_latch_asynch slave(.d(qm), .clk(~clk), .en(en), .areset(areset), .q(qs));
    
//endmodule


module d_flipflop(
        input logic d,
        input logic en,
        input logic clk,
        input logic areset,
        output logic qm,
        output logic qs

    );
    
    always @(posedge clk, negedge areset)
    begin 
        if(~areset) qs <= 0;
        else if(en) qs <= d;
    end
    
    assign qm = 0;
    
endmodule
