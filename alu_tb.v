// Testbench for the ALU module
module alu_testbench;
 reg [3:0] x_operand, y_operand;
 reg [1:0] ctrl_signal;
 reg clock;
 wire [3:0] result;
arithmetic_logic_unit alu_instance (
 .input_x(x_operand),
 .input_y(y_operand),
 .control_signal(ctrl_signal),
 .clk(clock),
 .output_result(result)
 );
 initial begin
 // Initialize signals
 x_operand = 4'b0000;
 y_operand = 4'b0000;
 ctrl_signal = 2'b00;
 clock = 0;
 // Generate VCD file for waveform analysis
 $dumpfile("alu_simulation.vcd");
 $dumpvars(0, alu_testbench);
 $monitor($time, " clk=%b ctrl_signal=%b x_operand=%b y_operand=%b result=%b", clock, 
ctrl_signal, x_operand, y_operand, result);
// Testing all with different values
// Test addition operation
 #10 x_operand = 4'b1010; y_operand = 4'b0101; ctrl_signal = 2'b01;
 #10 clock = 1; #10 clock = 0;
// Test subtraction operation
 #10 x_operand = 4'b1100; y_operand = 4'b0110; ctrl_signal = 2'b10;
 #10 clock = 1; #10 clock = 0;
 #10 x_operand = 4'b0111; y_operand = 4'b0011; ctrl_signal = 2'b10;
 #10 clock = 1; #10 clock = 0;
// Test no operation
 #10 x_operand = 4'b1111; y_operand = 4'b0000; ctrl_signal = 2'b11; // No operation
 #10 clock = 1; #10 clock = 0;
// Test ALU off
 #10 ctrl_signal = 2'b00; // ALU off
 #10 clock = 1; #10 clock = 0;
 $finish;
 end
endmodule
