`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 02:14:32 PM
// Design Name: 
// Module Name: even_odd_detector
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


module even_odd_detector(
    input logic clk,
    input logic reset,
    input logic in_bit,
    output logic zeros_even,
    output logic ones_even
    );
    
    typedef enum logic [2:0] {
        A,
        B,
        C,
        D
     } state_t;
     
     state_t current_state, next_state;
     
     // State transition:
     always_ff @(posedge clk or negedge reset) begin
        if (!reset)
            current_state <= A;
        else
            current_state <= next_state;
      end
      
      
      
      // Next-state logic:
      always_comb begin
        case (current_state)
            A: next_state = in_bit ? D : B;
            B: next_state = in_bit ? C : A;
            C: next_state = in_bit ? B : D;
            D: next_state = in_bit ? A : C;
            default: next_state = A;
         endcase

       end
       
       // Output logic:
       always_comb begin
            zeros_even = (current_state == A | current_state == D);
            ones_even = (current_state == A | current_state == B);
       end
endmodule
