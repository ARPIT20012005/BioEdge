module mac_engine (
    input wire clk,
    input wire rst,
    input wire [7:0] dna_in,
    input wire [7:0] weight,
    input wire enable,
    output reg [15:0] accum 
);
    // Explicitly using unsigned math to prevent "False Reds"
    always @(posedge clk) begin
        if (rst) begin
            accum <= 16'h0000;
        end else if (enable) begin
            accum <= $unsigned(accum) + ($unsigned(dna_in) * $unsigned(weight));
        end
    end
endmodule