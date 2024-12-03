module digital_lock_top(
    input wire CLK100MHZ,    // using the same name as pin names
    input wire CPU_RESETN,   
    input wire BTNC, BTNU, BTND,
    output wire CA, CB, CC, CD, CE, CF, CG, DP,
    output wire [7:0] AN,    
    input wire [15:0] SW     
);


logic reset_n;
logic clk;

assign reset_n = CPU_RESETN;
assign clk = CLK100MHZ;


// Seven segments Controller
wire [6:0] Seg;
wire [3:0] digits[0:7];

logic unlock, fail;

digital_lock digital_lock_inst(
        .clk(clk),
        .reset(CPU_RESETN),
        .in_pass(SW[3:0]),
        .open(BTNU),
        .close(BTND),
        .unlock(unlock),
        .fail(fail)
    );
    
    
logic [3:0] unlock_dig;
always_comb begin 
    if (unlock)
        unlock_dig = 4'b0000;
    else if (fail)
        unlock_dig = 4'b1111;
    else
        unlock_dig = 4'b1100;
end

// Method 2:
//assign unlock_dig = unlock ? 4'b0000 : 
//       fail ? 4'b1111 :
//       4'b1100;


assign digits[0] = SW[3:0];
assign digits[1] = unlock_dig;
assign digits[2] = 4'b1111;
assign digits[3] = 4'b1111;
assign digits[4] = 4'b1111;
assign digits[5] = 4'b1111;
assign digits[6] = 4'b1111;
assign digits[7] = 4'b1111;


sev_seg_controller ssc(
    .clk(clk),
    .resetn(reset_n),
    .digits(digits),
    .Seg(Seg),
    .AN(AN)
);


assign CA = Seg[0];
assign CB = Seg[1];
assign CC = Seg[2];
assign CD = Seg[3];
assign CE = Seg[4];
assign CF = Seg[5];
assign CG = Seg[6];
assign DP = 1'b1; // turn off the dot point on seven segs


endmodule : digital_lock_top
