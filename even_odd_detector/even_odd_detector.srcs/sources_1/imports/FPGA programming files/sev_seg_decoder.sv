module sev_seg_decoder(
    input  wire [3:0] bin,      // 4-bit binary input (0–F)
    output logic  [6:0] seg       // 7-bit output for segments a-g
);

assign seg[0] = (~bin[3] & bin[2] & ~bin[1] & ~bin[0]) | (~bin[3] & ~bin[2] & ~bin[1] & bin[0]) | (bin[3] & bin[2] & ~bin[1] & bin[0]) | (bin[3] & ~bin[2] & bin[1] & bin[0]);
assign seg[1] = (~bin[3] & bin[2] & ~bin[1] & bin[0]) | (bin[3] & bin[2] & ~bin[0]) | (bin[3] & bin[1] & bin[0]) | (bin[2] & bin[1] & ~bin[0]) | (bin[3] & bin[2] & bin[1]);
assign seg[2] = (bin[3] & bin[2] & ~bin[0]) | (bin[3] & bin[2] & bin[1]) | (~bin[3] & ~bin[2] & bin[1] & ~bin[0]);
assign seg[3] = (~bin[3] & bin[2] & ~bin[1] & ~bin[0]) | (~bin[3] & ~bin[2] & ~bin[1] & bin[0]) |(bin[3] & ~bin[2] & bin[1] & ~bin[0]) | (bin[2] & bin[1] & bin[0]);
assign seg[4] = (~bin[3] & bin[2] & ~bin[1] & ~bin[0]) | (~bin[2] & ~bin[1] & bin[0]) | (~bin[3] & bin[0]);
assign seg[5] = (~bin[3] & ~bin[2] & bin[0]) | (~bin[3] & bin[1] & bin[0]) | (~bin[3] & ~bin[2] & bin[1]) | (bin[3] & bin[2] & ~bin[1] & bin[0]);  
assign seg[6] = (~bin[3] & ~bin[2] & ~bin[1]) | (~bin[3] & bin[2] & bin[1] & bin[0]) | (bin[3] & bin[2] & ~bin[1] & ~bin[0]);

endmodule
