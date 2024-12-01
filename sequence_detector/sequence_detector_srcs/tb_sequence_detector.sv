`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 12:53:24 PM
// Design Name: 
// Module Name: tb_sequence_detector
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


module tb_sequence_detector;
    logic clk;
    logic reset;
    logic in_bit;
    logic detected;
    logic [3:0] count;
    
    sequence_detector dut(
        .clk(clk),
        .reset(reset),
        .in_bit(in_bit),
        .detected(detected),
        .seq_count(count)
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
