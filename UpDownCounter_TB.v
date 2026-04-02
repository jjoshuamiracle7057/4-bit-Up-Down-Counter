`timescale 1ns / 1ps

module UpDownCounter_TB();

    // Inputs to the Unit Under Test (UUT)
    reg clk;
    reg reset;
    reg up_down;

    // Outputs from the UUT
    wire [3:0] count;

    // Instantiate the 4-bit Counter Core (Bypassing Clock Divider for simulation speed)
    UpDown_Core uut (
        .clk(clk),
        .rst(reset),
        .mode(up_down),
        .q(count)
    );

    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;      // Start with Reset Active
        up_down = 1;    // Default mode: UP

        // Wait 20ns for global reset
        #20;
        reset = 0;      // Release Reset

        // --- TEST CASE 1: COUNT UP ---
        $display("Starting Up-Count Test...");
        #160;           // Wait for 16 clock cycles (0 to 15)
        
        // --- TEST CASE 2: TOGGLE TO DOWN ---
        $display("Toggling to Down-Count...");
        up_down = 0;    // Change mode to DOWN
        #100;           // Observe decrementing logic

        // --- TEST CASE 3: ASYNCHRONOUS RESET ---
        $display("Testing Asynchronous Reset...");
        #25;
        reset = 1;      // Trigger Reset
        #10;
        reset = 0;      // Release Reset

        // --- TEST CASE 4: WRAP AROUND ---
        // Verify 0 -> 15 (Underflow) and 15 -> 0 (Overflow)
        up_down = 0;
        #40;
        
        $display("Simulation Complete.");
        $finish;
    end

    // Monitor the outputs in the console
    initial begin
        $monitor("Time=%0t | Reset=%b | Mode=%b | Count=%d (%b)", 
                 $time, reset, up_down, count, count);
    end

endmodule
