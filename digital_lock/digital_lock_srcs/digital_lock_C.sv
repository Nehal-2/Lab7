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
    output logic unlock
    );
    
    typedef enum logic [1:0] {
        locked,
        unlocked
    } state_t;
    
    state_t current_state, next_state;
    
    logic [3:0] q;
    logic [3:0] password;
    
    assign password = 4'b1111;
     
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
      
      // Next-state logic:
      always_comb begin
        case (current_state)
            locked: next_state = ((in_pass == q) & open) ? unlocked : locked;
            unlocked: next_state = close ? locked : unlocked;
            default: next_state = locked;
         endcase

       end
       
       // Output logic:
       always_comb begin
            unlock = (current_state == unlocked);
       end
        
endmodule
