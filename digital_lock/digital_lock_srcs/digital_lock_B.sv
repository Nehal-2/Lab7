`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 04:00:52 PM
// Design Name: 
// Module Name: digital_lock
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


module digital_lock(
    input logic clk,
    input logic reset,
    input logic [3:0] in_pass,
    input logic open,
    input logic close,
    output logic unlock,
    output logic fail 
    );
    
    typedef enum logic [1:0] {
        locked,
        unlocked,
        failed
    } state_t;
    
    state_t current_state, next_state;
    
    logic [3:0] q;
    logic [3:0] password;
    logic [3:0] failed_attempts;
    
    assign password = 4'b1111;
    
    nbit_counter#(.n(4)) count_inst (
            .clk(clk),
            .areset(reset),
            .en((in_pass != q) && open),
            .up_down(1'b0),
            .q(failed_attempts)
       );
     
     // State transition:
     always_ff @(posedge clk or negedge reset) begin
        if (!reset)
            current_state <= locked;
        else
            current_state <= next_state;
      end
      
      // Register
      register_nbit #(.n(4)) reg_password(
            .clk(clk),
            .areset(reset),
            .en(1'b1),
            .d(password),
            .q(q)
      );
      
      // 10-second timer (100 MHz clock, 10 seconds = 1_000_000_000 clock cycles)
    localparam TIMER_MAX = 1_000_000_000; // Tested with TIMER_MAX = 10 for convenience
    reg [29:0] timer; // Enough to hold up to 1_000_000_000
    wire timer_done = (timer == TIMER_MAX);

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) 
            timer <= 0;
        else if (current_state == failed && !timer_done)
            timer <= timer + 1;
        else if (current_state != failed)
            timer <= 0;
    end

      
       // Next-state logic:
      always_comb begin
        case (current_state)
            locked: begin
                    if (failed_attempts == 3) 
                        next_state = failed; 
                    else if ((in_pass == q) && open) 
                        next_state = unlocked; 
                    else 
                        next_state = locked;
            end
            unlocked: next_state = close ? locked : unlocked;
            failed: begin
                if (timer_done)
                    next_state = locked;
                else
                    next_state = failed;
            end  
            default: next_state = locked;
         endcase

       end
       
       // Output logic:
       always_comb begin
            unlock = (current_state == unlocked);
            fail = (current_state == failed);
       end
        
endmodule
