`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:51:36 09/17/2015
// Design Name:   FullAdder
// Module Name:   C:/Users/cjtsai/lab1/FullAdder_tb.v
// Project Name:  lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FullAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FullAdder_tb;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg Cin;

	// Outputs
	wire [3:0] S;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	FullAdder uut (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.S(S), 
		.Cout(Cout)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		Cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		A = 4'b0101;
		B = 4'b1010;
		#50;
		A = 4'b1111;
		B = 4'b0001;
		#50;
		A = 4'b0000;
		B = 4'b1111;
		Cin = 1'b1;
		#50;
		A = 4'b0110;
		B = 4'b0001;

	end
      
endmodule

