`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 04:15:25 PM
// Design Name: 
// Module Name: tb_digital_lock
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


module tb_digital_lock;
    reg clk = 0;
    reg reset, unlock, open, close, fail;
    reg [3:0] in_pass;
    

    always #5 clk = ~clk;

    digital_lock dut(
        .clk(clk),
        .reset(reset),
        .in_pass(in_pass),
        .open(open),
        .close(close),
        .unlock(unlock),
        .fail(fail)
    );
    
    
    initial begin
        // Test sequence
        reset = 1; in_pass = 4'b0000; open = 0; close = 0; #10;
        reset = 0; #10;
        reset = 1;
        // Wrong password attempts
        in_pass = 4'b1110; open = 1; #10; open = 0; #10;
        in_pass = 4'b0110; open = 1; #10; open = 0; #10;
        in_pass = 4'b0110; open = 1; #10; open = 0; #10;
        
        repeat(10) @(posedge clk); // Tested with 10 cycles for convenience
        @(negedge clk);
        // Correct password attempt after reset
        in_pass = 4'b1111; open = 1; #10; open = 0; close = 1; #10; close = 0; 

        // Test timer functionality in failed state
        in_pass = 4'b1110; open = 1; #10; open = 0; #10;
        in_pass = 4'b1110; open = 1; #10; open = 0; #10;
        in_pass = 4'b1110; open = 1; #10; open = 0; #10; // 3 failed attempts trigger failed state

        repeat(10) @(posedge clk); // Wait for timer to expire

        // Attempt unlock after timer expiry
        in_pass = 4'b1111; open = 1; #10; open = 0; close = 1; #10; close = 0; 

        $finish;
    end 
endmodule
