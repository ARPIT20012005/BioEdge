module weight_rom_multi (
    input wire clk,
    input wire [8:0] address,   // 2-bit Gene Select + 7-bit Position
    output reg [7:0] weight     // Unsigned 8-bit output
);
    reg [7:0] rom [0:511];      // Unsigned memory array

    initial begin
        // Ensure multi_gene_weights.mem is in your project directory
        $readmemh("multi_gene_weights.mem", rom);
    end

    always @(posedge clk) begin
        // Synchronous read for stability on Arty A7
        weight <= rom[address];
    end
endmodule