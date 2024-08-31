// Module for a single-bit full adder.
module bit_adder (
 input x, y, carry_in,
 output sum_out, carry_out
);
 assign {carry_out, sum_out} = x + y + carry_in;
endmodule
// Module for a 4-bit ripple carry adder
module four_bit_adder_module (
 input [3:0] input_x, input_y,
 output [3:0] sum_result,
 output carry_out
);
 wire carry1, carry2, carry3;
 bit_adder adder0 (.x(input_x[0]), .y(input_y[0]), .carry_in(1'b0), .sum_out(sum_result[0]), 
.carry_out(carry1));
 bit_adder adder1 (.x(input_x[1]), .y(input_y[1]), .carry_in(carry1), .sum_out(sum_result[1]), 
.carry_out(carry2));
 bit_adder adder2 (.x(input_x[2]), .y(input_y[2]), .carry_in(carry2), .sum_out(sum_result[2]), 
.carry_out(carry3));
 bit_adder adder3 (.x(input_x[3]), .y(input_y[3]), .carry_in(carry3), .sum_out(sum_result[3]), 
.carry_out(carry_out));
endmodule
// Module for a 4-bit ripple carry subtractor
module four_bit_subtractor_module (
 input [3:0] input_x, input_y,
 output [3:0] difference,
 output borrow_out
);
 wire borrow1, borrow2, borrow3;
 bit_adder sub0 (.x(input_x[0]), .y(~input_y[0]), .carry_in(1'b1), .sum_out(difference[0]), 
.carry_out(borrow1));
 bit_adder sub1 (.x(input_x[1]), .y(~input_y[1]), .carry_in(borrow1), .sum_out(difference[1]), 
.carry_out(borrow2));
 bit_adder sub2 (.x(input_x[2]), .y(~input_y[2]), .carry_in(borrow2), .sum_out(difference[2]), 
.carry_out(borrow3));
 bit_adder sub3 (.x(input_x[3]), .y(~input_y[3]), .carry_in(borrow3), .sum_out(difference[3]), 
.carry_out(borrow_out));
endmodule
// Top module for the Arithmetic Logic Unit (ALU)
module arithmetic_logic_unit (
 input [3:0] input_x, input_y,
 input [1:0] control_signal,
 input clk,
 output reg [3:0] output_result
);
 wire [3:0] sum_result, difference;
 wire carry_out, borrow_out;
 four_bit_adder_module adder_instance (.input_x(input_x), .input_y(input_y), 
.sum_result(sum_result), .carry_out(carry_out));
 four_bit_subtractor_module subtractor_instance (.input_x(input_x), .input_y(input_y), 
.difference(difference), .borrow_out(borrow_out));
 always @(posedge clk) begin
 case (control_signal)
 2'b00: output_result <= 4'b0000;
 2'b01: output_result <= sum_result;
 2'b10: output_result <= difference;
 2'b11: output_result <= output_result;
 endcase
 end
endmodule
