`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 04:06:54 PM
// Design Name: 
// Module Name: register_nbit
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


module register_nbit#(
    parameter n = 8
)(
    input logic clk,
    input logic areset,
    input logic en,
    input logic [n-1:0] d,
    output logic [n-1:0] q
);

    always_ff @(posedge clk or negedge areset) begin
        if (~areset)
            q <= {n{1'b0}};
        else if (en)
            q <= d;

    end
endmodule
