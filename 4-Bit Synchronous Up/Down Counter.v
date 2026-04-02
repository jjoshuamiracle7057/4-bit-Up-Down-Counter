// 4-Bit Synchronous Up/Down Counter with Clock Divider
// Target Board: Xilinx ZedBoard (Zynq-7000)

module Top_Counter_Module(
    input clk,          // 100MHz onboard clock (Pin Y9)
    input reset,        // Center Pushbutton (BTNC)
    input up_down,      // Switch (SW0): 1 = Up, 0 = Down
    output [3:0] count  // LEDs (LD3-LD0)
    );

    wire slow_clk;

    // Instantiate Clock Divider to slow 100MHz to ~1Hz
    Clock_Divider clk_gen (
        .clk_in(clk),
        .rst(reset),
        .clk_out(slow_clk)
    );

    // Instantiate the 4-bit Counter
    UpDown_Core counter_inst (
        .clk(slow_clk),
        .rst(reset),
        .mode(up_down),
        .q(count)
    );

endmodule

// --- 4-Bit Counter Core Logic ---
module UpDown_Core(
    input clk,
    input rst,
    input mode,
    output reg [3:0] q
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 4'b0000;
        end else begin
            if (mode) 
                q <= q + 1; // Count Up
            else 
                q <= q - 1; // Count Down
        end
    end
endmodule

// --- Clock Divider Module (100MHz to ~1Hz) ---
module Clock_Divider(
    input clk_in,
    input rst,
    output reg clk_out
    );

    reg [26:0] counter;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else if (counter == 50_000_000) begin // Toggle every 0.5 seconds
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
