# 4-bit-Up-Down-Counter
The 4-bit Up/Down Counter is a sequential circuit that cycles through 0-15 (0000-1111) using the ZedBoard's clock. It employs four flip-flops and a mode-select input for direction: high increments, while low decrements. Synchronous design ensures all bits transition together, preventing glitches. 

📌 Project Overview
This repository contains the Verilog HDL implementation of a 4-bit Synchronous Up/Down Counter. Designed for the Xilinx ZedBoard (Zynq-7000 SoC), the project demonstrates key sequential logic concepts, including state transitions, clock synchronization, and hardware-level control.

The counter cycles through binary values 0 to 15 (0000 to 1111). A dedicated mode-select input allows the user to toggle between incrementing (up) and decrementing (down) the count in real-time.

🚀 Features 
* Directional Control: Toggle counting direction using a physical sliding switch.
* Synchronous Logic: All flip-flops trigger on the same clock edge, eliminating "ripple" glitches.
* Frequency Scaling: Includes a clock divider to slow the onboard 100MHz clock to a human-readable 1Hz/2Hz frequency.
* Asynchronous Reset: Instantaneous reset to 0000 via an onboard pushbutton.

🛠 Technical Specifications
* FPGA: XC7Z020-CLG484-1
* Language: Verilog HDL
* Toolchain: Xilinx Vivado Design Suite 2026
* Clock Frequency: 100 MHz (Internal) / Scaled for LED display.

🎮 Hardware Mapping
Signal               ZedBoard Hardware          Description
Clock                Y9 (Onboard Osc)           100MHz System Clock
Reset                BTNC (Center Button)       Resets count to 0
Mode                 SW0 (Switch)               High: Up / Low: Down
Count                LD3 - LD0 (LEDs)           4-bit Binary Output

