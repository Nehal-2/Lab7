`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 02:56:48 PM
// Design Name: 
// Module Name: nbit_counter
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


module nbit_counter#(
        parameter n = 4
)(
        input logic clk,
        input logic areset,
        input logic en,
        input logic load,
        input logic up_down, // down count if high
        input logic [n-1:0] d,
        output logic [n-1:0] q 
        
    );
    
    logic [n-1:0] next_q;
    
    always @(*)
    begin
        if (load)
            next_q = d;
        else if (en) begin
            if (up_down)
                next_q = q - 1;
            else 
                next_q = q + 1;
        end else
            next_q = q; // Hold if enable is low
    end
    
    genvar i;
    
    generate 
     for(i = 0; i < n; i = i+1) begin : flipflop_gen_loop
        d_flipflop FF(.clk(clk), .en(en | load), .d(next_q[i]), .areset(areset), .qs(q[i]));
        end
    endgenerate

endmodule