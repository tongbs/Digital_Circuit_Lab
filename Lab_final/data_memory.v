`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:11 01/05/2017 
// Design Name: 
// Module Name:    data_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_memory( 
input reset,
input clk,
input [19:0] instruction,
output [8:0] reg1,//9-bit register
output [8:0] reg2,
output [8:0] reg3,
output [8:0] reg4,
output z_flag
); 
reg [8:0] register [3:0];
assign reg1 = register[0];
assign reg2 = register[1];
assign reg3 = register[2];
assign reg4 = register[3];
//declare wire
wire signed [7:0]  p1;
wire signed [7:0]  p2;
wire  [3:0]   control;
//assign zero_flag
assign z_flag = (register[p1]==0)? 1:0;
assign control = instruction [19:16] ;
assign p1 = instruction [15:8] ;
assign p2 = instruction [7:0] ;
//wire declared
wire [8:0] add_total;
wire [8:0] add1_total;
wire [8:0] sub_total;
wire [8:0] sub1_total;
wire Add_ca;//addition carry
wire Add1_ca;
wire Sub_ca;//subtract carry
wire Sub1_ca;
reg consequence;//to store 
//declare function
addition add(
	.a(register[p1][7:0]),
	.b(register[p2][7:0]),
	.sum(add_total), 
	.carryout(Add_ca)
	);
addition addition(		
	.a(register[p1][7:0]),
	.b(p2),
	.sum(add1_total), 
	.carryout(Add1_ca)
	);
subtract sub(
	.a(register[p1][7:0]),
	.b(register[p2][7:0]),
	.sum(sub_total), 
	.carryout(Sub_ca)
	);
subtract subi(		
	.a(register[p1][7:0]),
	.b(p2),
	.sum(sub1_total), 
	.carryout(Sub1_ca)
	);
//important part
always @( posedge clk )
	if(reset) begin
		register[0] <= 0;
		register[1] <= 0;
		register[2] <= 0;	
		register[3] <= 0;
		consequence <= 0;
	end 
	else begin
		case(control)//op_code
			4'b0000:	
					consequence <= 0;
			4'b0010:	
	    			register[p1] <= {Add_ca,add_total};     
			4'b0011:	
	                register[p1] <= {Add1_ca,add1_total}; 
			4'b0100:	
					register[p1] <= {Sub_ca,sub_total};
			4'b0101:	
	                register[p1] <= {Sub1_ca,sub1_total}; 	
			4'b1110:	
	                register[p1] <= register[p1] & register[p2];//logical operator
			4'b1100:	
	    			register[p1] <= register[p1] | register[p2];
			4'b1010:	
	                register[p1] <= register[p1] ^ register[p2];
			4'b1000:	
	                register[p1] <= ~(register[p1]);
			default:
					consequence <= 0;
		endcase
end
endmodule
////////////////////////////////////////////////////////////////////
//doing minus

//fulladder derive from lab1
module subtract(a, b, sum, carryout);
	input [7:0] a, b;
	output [8:0] sum;
	output carryout;
	wire [8:0] x;
	wire cin, z;
	assign x = 9'd1;
	assign cin = 1'b0;
	wire [8:0]ta, tb, tc, td;
	assign ta[0] = a[0];
	assign ta[1] = a[1];
	assign ta[2] = a[2];
	assign ta[3] = a[3];
	assign ta[4] = a[4];
	assign ta[5] = a[5];
	assign ta[6] = a[6];
	assign ta[7] = a[7];
	assign ta[8] = a[7];

	assign tb[0] = b[0];
	assign tb[1] = b[1];
	assign tb[2] = b[2];
	assign tb[3] = b[3];
	assign tb[4] = b[4];
	assign tb[5] = b[5];
	assign tb[6] = b[6];
	assign tb[7] = b[7];
	assign tb[8] = b[7];
	Complement number (.K(tb), .S(tc));	
	//1干计
	FullAdder fa(.A(tc), .B(x), .Cin(cin), .S(td), .Cout(z));  
	//2干计
	FullAdder sum1(.A(ta), .B(td), .Cin(cin), .S(sum), .Cout(carryout));
endmodule
//////////////////////////////////////////////////////////////////////////
module addition(a, b, sum, carryout);
//declare
	input [7:0] a, b;
	output [8:0] sum;
	output carryout;
	wire cin;
	assign cin = 1'b0;

	wire [8:0]ua, ub, tc, td;
	assign ua[0] = a[0];
	assign ua[1] = a[1];
	assign ua[2] = a[2];
	assign ua[3] = a[3];
	assign ua[4] = a[4];
	assign ua[5] = a[5];
	assign ua[6] = a[6];
	assign ua[7] = a[7];
	assign ua[8] = a[7];

	assign ub[0] = b[0];
	assign ub[1] = b[1];
	assign ub[2] = b[2];
	assign ub[3] = b[3];
	assign ub[4] = b[4];
	assign ub[5] = b[5];
	assign ub[6] = b[6];
	assign ub[7] = b[7];
	assign ub[8] = b[7];

	FullAdder sum2(.A(ua), .B(ub), .Cin(cin), .S(sum), .Cout(carryout));
endmodule
////////////////////////////////////////////////////////////////////////////////
module FullAdder(A, B, Cin, S, Cout);
	input [8:0] A, B;
	input Cin;
	output [8:0] S;
	output Cout;
	wire [7:0] tt;

	FA_1bit FA0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(tt[0]));
	FA_1bit FA1(.A(A[1]), .B(B[1]), .Cin(tt[0]), .S(S[1]), .Cout(tt[1]));
	FA_1bit FA2(.A(A[2]), .B(B[2]), .Cin(tt[1]), .S(S[2]), .Cout(tt[2]));
	FA_1bit FA3(.A(A[3]), .B(B[3]), .Cin(tt[2]), .S(S[3]), .Cout(tt[3]));
	FA_1bit FA4(.A(A[4]), .B(B[4]), .Cin(tt[3]), .S(S[4]), .Cout(tt[4]));
	FA_1bit FA5(.A(A[5]), .B(B[5]), .Cin(tt[4]), .S(S[5]), .Cout(tt[5]));
	FA_1bit FA6(.A(A[6]), .B(B[6]), .Cin(tt[5]), .S(S[6]), .Cout(tt[6]));
	FA_1bit FA7(.A(A[7]), .B(B[7]), .Cin(tt[6]), .S(S[7]), .Cout(tt[7]));
	FA_1bit FA8(.A(A[8]), .B(B[8]), .Cin(tt[7]), .S(S[8]), .Cout(Cout));

endmodule

/////////////////////////////////////////////1-bit
module FA_1bit(A, B, Cin, S, Cout);
	input A, B, Cin;
	output S, Cout;
	assign S = Cin ^ A ^ B;
	assign Cout = (A & B) | (Cin & B) | (Cin & A);
	
endmodule

////////////////////////////complement
module Complement(K, S);
input [8:0]K;
output [8:0]S;
assign S[0] = !K[0];
assign S[1] = !K[1];
assign S[2] = !K[2];
assign S[3] = !K[3];
assign S[4] = !K[4];
assign S[5] = !K[5];
assign S[6] = !K[6];
assign S[7] = !K[7];
assign S[8] = !K[8];
endmodule 

