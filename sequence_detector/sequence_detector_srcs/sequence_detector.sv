`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 12:41:40 PM
// Design Name: 
// Module Name: sequence_detector
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

// Detects the sequence 1101. Alows overlapping
module sequence_detector(
    input logic clk,
    input logic reset,
    input logic in_bit,
    output logic detected,
    output logic [3:0] seq_count
    );
    
    typedef enum logic [2:0] {
        A,
        B,
        C,
        D,
        E
     } state_t;
     
     state_t current_state, next_state;
     
     // State transition:
     always_ff @(posedge clk or negedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
      end
      
      // Next-state logic:
      always_comb begin
        case (current_state)
            A: next_state = in_bit ? B : A;
            B: next_state = in_bit ? B : C;
            C: next_state = in_bit ? D : A;
            D: next_state = in_bit ? E : C;
            E: next_state = in_bit ? B : C;
            default: next_state = A;
         endcase
       end
       
       // Output logic:
       always_comb begin
            detected = (current_state == E);
       end
       
       nbit_counter#(.n(4)) count_inst (
            .clk(clk),
            .areset(reset),
            .en(detected),
            .up_down(1'b0),
            .q(seq_count)
       );
              
endmodule
