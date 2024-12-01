`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 02:31:59 PM
// Design Name: 
// Module Name: tb_even_odd_detector
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


module tb_even_odd_detector;
    logic clk;
    logic reset;
    logic in_bit;
    logic zeros_even;
    logic ones_even;
    
    even_odd_detector dut(
        .clk(clk),
        .reset(reset),
        .in_bit(in_bit),
        .zeros_even(zeros_even),
        .ones_even(ones_even)
     );
     
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset = 0; in_bit = 0; #10
        reset = 1; #10
        reset = 0; #10
        
        in_bit = 0; #10
        in_bit = 1; #10
        in_bit = 1; #10
        in_bit = 1; #10
        in_bit = 0; #10
        in_bit = 1; #10
        in_bit = 1; #10
        in_bit = 0; #10
        
        reset = 1; #10
        reset = 0; #10
        
        
        in_bit = 1; #10
        in_bit = 0; #10
        in_bit = 1; #10
        in_bit = 1; #10
        in_bit = 1; #10
        in_bit = 0; #10
        in_bit = 1; #10
        in_bit = 1; #10
        
        $finish;
     end
endmodule
