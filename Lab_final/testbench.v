`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:38:37 01/16/2017
// Design Name:   final_project
// Module Name:   D:/project/testbench.v
// Project Name:  project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: final_project
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] reg1;
	wire [7:0] reg2;
	wire [7:0] reg3;
	wire [7:0] reg4;
 
 

	// Instantiate the Unit Under Test (UUT)
	final_project uut (
		.clk(clk), 
		.reset(reset), 
		.reg1(reg1),
		.reg2(reg2), 
		.reg3(reg3), 
		.reg4(reg4)
    
  );
   parameter cycle=20;
   always # (cycle/2) clk=~clk;

	initial begin
    clk = 0;
    reset = 0;
    @(posedge clk)
    reset = 1;
    @(posedge clk)
    reset = 1;
    @(posedge clk)
    reset = 0;
    
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    
    #100;
	 end
endmodule

