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
    
    logic open_debounced;
    logic [1:0] open_sync;
    
    // Synchronize the 'open' button to the clock
    always_ff @(posedge clk or negedge reset) begin
        if (!reset)
            open_sync <= 2'b00;
        else 
            open_sync <= {open_sync[0], open};
    end
    
    assign open_debounced = (open_sync == 2'b01); // Detect 0 to 1 transition
    
    logic [3:0] failed_attempts_next;
    assign failed_attempts_next =  4'b0000;
    
    nbit_counter#(.n(4)) count_inst (
            .clk(clk),
            .areset(reset),
            .en((in_pass != q) && open_debounced),
            .up_down(1'b0),
            .d(failed_attempts_next),
            .load(unlock | fail),
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
      
    localparam CLOCK_FREQ_HZ = 100_000_000; // 100 MHz
    localparam TIMER_MAX = 10 * CLOCK_FREQ_HZ; // 10 seconds
    reg [29:0] timer; // Enough to hold up to 1_000_000_000
    wire timer_done = (timer == TIMER_MAX);

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) 
            timer <= 0;
        else if (current_state == failed && !timer_done)
            timer <= timer + 1;
        else
            timer <= 0;
    end
      
       // Next-state logic:
      always_comb begin
        case (current_state)
            locked: begin
                    if (failed_attempts >= 3) 
                        next_state = failed; 
                    else if ((in_pass == q) && open) 
                        next_state = unlocked; 
                    else 
                        next_state = locked;
            end
            unlocked: next_state = close ? locked : unlocked;
            failed: begin
                if (timer_done) begin
                    next_state = locked;
                end else begin
                    next_state = failed;
                end
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
