module even_odd_detector_top(
    input wire CLK100MHZ,    // using the same name as pin names
    input wire CPU_RESETN,   
    input wire BTNC,
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

logic zeros_even;
logic ones_even;

even_odd_detector detector_inst(
        .clk(BTNC),
        .reset(CPU_RESETN),
        .in_bit(SW[0]),
        .zeros_even(zeros_even),
        .ones_even(ones_even)
     );

assign digits[0] = {{3{1'b0}},zeros_even};
assign digits[1] = 4'b1111;
assign digits[2] = {{3{1'b0}},ones_even};
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


endmodule : even_odd_detector_top
