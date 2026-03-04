`timescale 1ns / 1ps

module tb_bioedge();
    reg clk;
    reg rst_btn;
    reg [3:0] sw;
    reg btn_inject;
    
    wire [3:0] led_red;
    wire [3:0] led_green;
    
    integer i; 

    bioedge_top uut (
        .clk(clk),
        .rst_btn(rst_btn),
        .sw(sw),
        .btn_inject(btn_inject),
        .led_red(led_red),
        .led_green(led_green)
    );

    // Generate 100MHz clock
    always #5 clk = ~clk; 

    initial begin
        // 1. Initialize System
        clk = 0;
        rst_btn = 1;      
        
        // --- THE CRITICAL CHANGE ---
        // We set the switches to 0001. 
        // SW[3:2] = 00 (Gene Bank 0: BRCA1)
        // SW[1:0] = 01 (DNA input is now '1' instead of '0')
        sw = 4'b0001;     
        
        btn_inject = 0;
        
        #100;
        rst_btn = 0;      // Release Reset
        #100;

        // 2. Automate 122 Button Presses!
        for (i = 0; i < 122; i = i + 1) begin
            btn_inject = 1; 
            #200; 
            btn_inject = 0; 
            #200; 
        end

        // Wait a moment to observe the final LED outputs
        #500;
        $finish;
    end
endmodule