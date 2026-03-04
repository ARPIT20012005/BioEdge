module dna_encoder(
    input wire clk,
    input wire btn_in,      // Manual tap
    input wire scan_en,     // SW0: Start Auto-Scan
    output reg valid_out,
    output wire scanning    
);
    reg [23:0] auto_timer = 0;
    reg [6:0] auto_pulse_count = 0;
    reg auto_scanning = 0;
    reg btn_sync_0, btn_sync_1, btn_state;
    reg [19:0] debounce_count = 0;

    assign scanning = auto_scanning;

    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
        valid_out <= 1'b0;

        // Auto-Scan Logic
        if (scan_en && !auto_scanning && auto_pulse_count == 0) begin
            auto_scanning <= 1'b1;
        end

        if (auto_scanning) begin
            auto_timer <= auto_timer + 1;
            if (auto_timer >= 24'd1_000_000) begin // 10ms pulses
                auto_timer <= 0;
                valid_out <= 1'b1;
                auto_pulse_count <= auto_pulse_count + 1;
                // 127 Pulse Overdrive
                if (auto_pulse_count >= 7'd127) auto_scanning <= 1'b0;
            end
        end else if (!scan_en) begin
            auto_pulse_count <= 0;
            auto_timer <= 0;
        end

        // Manual Debounce Override
        if (!auto_scanning) begin
            if (btn_state == btn_sync_1) debounce_count <= 0;
            else begin
                debounce_count <= debounce_count + 1;
                if (debounce_count >= 20'd1_000_000) begin
                    btn_state <= btn_sync_1;
                    if (btn_sync_1) valid_out <= 1'b1;
                end
            end
        end
    end
endmodule