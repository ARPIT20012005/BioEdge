`timescale 1ns / 1ps

module bioedge_top (
    input wire clk,
    input wire rst_btn,
    input wire [3:0] sw,
    input wire btn_inject,
    output reg [3:0] rgb_red,       
    output reg [3:0] rgb_green,     
    output reg [3:0] led_progress,  
    output wire [7:0] pmod_ja       
);

    wire bit_ready;
    wire [7:0] current_weight;
    wire [15:0] total_score;
    reg [6:0] pos_counter;

    wire [8:0] rom_addr = {sw[3:2], pos_counter};

    dna_encoder encoder_inst (
        .clk(clk), 
        .btn_in(btn_inject), 
        .scan_en(sw[0]), 
        .valid_out(bit_ready),
        .scanning()  
    );

    weight_rom_multi rom_inst (
        .clk(clk), 
        .address(rom_addr), 
        .weight(current_weight)
    );

    mac_engine mac_inst (
        .clk(clk), 
        .rst(rst_btn), 
        .dna_in(sw[1] ? 8'd1 : 8'd0), 
        .weight(current_weight), 
        .enable(bit_ready), 
        .accum(total_score)
    );

    // ====================================================================
    // THE SMART BUS: PIN BYPASS
    // ====================================================================
    // We are deliberately abandoning pmod_ja[0] for the switches!
    // We are now sending SW2 on pmod_ja[1] (D0) and SW3 on pmod_ja[2] (D1).
    assign pmod_ja = (sw[0] == 1'b0) ? {5'd0, sw[3], sw[2], 1'b0} : 
                     (sw[3] && sw[2] && sw[1]) ? 8'd0 : 
                     total_score[11:4];

    // ====================================================================
    // LOCAL VISUAL STATE MACHINE
    // ====================================================================
    always @(posedge clk) begin
        if (rst_btn) begin
            pos_counter <= 7'd0;
            rgb_red <= 4'b0000;
            rgb_green <= 4'b0000;
            led_progress <= 4'b0000;
        end else begin
            
            if (bit_ready && (pos_counter < 7'd122)) begin
                pos_counter <= pos_counter + 1;
            end

            if (pos_counter > 7'd0)  led_progress[0] <= 1'b1; else led_progress[0] <= 1'b0;
            if (pos_counter > 7'd30) led_progress[1] <= 1'b1; else led_progress[1] <= 1'b0;
            if (pos_counter > 7'd60) led_progress[2] <= 1'b1; else led_progress[2] <= 1'b0;
            if (pos_counter > 7'd90) led_progress[3] <= 1'b1; else led_progress[3] <= 1'b0;

            if (pos_counter >= 7'd122) begin
                if (sw[3] == 1'b1 && sw[2] == 1'b1 && sw[1] == 1'b1) begin
                    rgb_red <= 4'b0000;
                    rgb_green <= 4'b1111;
                end 
                else if (total_score > 16'd2000) begin
                    rgb_red <= 4'b1111;
                    rgb_green <= 4'b0000;
                end else begin
                    rgb_red <= 4'b0000;
                    rgb_green <= 4'b1111;
                end
            end else begin
                rgb_red <= 4'b0000;
                rgb_green <= 4'b0000;
            end
        end
    end
endmodule