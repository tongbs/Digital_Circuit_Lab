`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:54 10/21/2016 
// Design Name: 
// Module Name:    postfix 
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
module postfix(
			CLK,
			RESET,
			OP_MODE,
			IN_VALID,
			IN,
			OUT,
			OUT_VALID
			
    );
	input IN_VALID;
	input [3:0] IN;
	input CLK;
	input RESET;
	input OP_MODE;
	output reg OUT_VALID;
	output reg [15:0] OUT;
	reg [19:0]stack[15:0];
	reg [4:0] stack_count;
	reg [15:0] check_ans;
	
	integer i;
	
	always@(posedge CLK or negedge RESET)begin
		if(!RESET)begin
			stack_count<=5'd0;
			for(i=0;i<16;i=i+1)begin
				stack[stack_count]<=16'd0;
			end
		end
		else if(IN_VALID)begin
			if(OP_MODE)begin
				if(IN==4'b0001)begin//++++
					stack[stack_count-2]<=stack[stack_count-2]+stack[stack_count-1];
					stack_count<=stack_count-1;
				end
				else if(IN==4'b0010)begin//----
					stack[stack_count-2]<=stack[stack_count-2]-stack[stack_count-1];
					stack_count<=stack_count-1;
				end
				else if(IN==4'b0100)begin//****
					stack[stack_count-2]<=stack[stack_count-2]*stack[stack_count-1];
					stack_count<=stack_count-1;
				end
			else begin
				for(i=0;i<16;i=i+1)begin
					stack[stack_count]<=stack[stack_count];
				end
				stack_count<=stack_count;
				end
			end
			else begin
					stack[stack_count]<=IN;
					stack_count<=stack_count+1;
				end
			end
			else begin
				stack_count<=5'd0;
				for(i=0;i<16;i=i+1)begin
					stack[stack_count]<=16'd0;
				end
				check_ans<=0;
			end
		end
		
		reg[1:0]output_state;//final
			
always@(posedge CLK)begin
	if(!RESET)begin
		OUT<=16'd0;
		OUT_VALID<=0;
		output_state<=2'd0;
	end
	else begin
		if(IN_VALID)begin
			output_state<=2'd1;
			OUT<=16'd0;
			OUT_VALID<=0;
		end
		else begin
			if(output_state==2'd1)begin
				output_state<=2'd2;
				OUT_VALID<=0;
				OUT<=16'd0;
			end
			else if(output_state==2'd2)begin
				output_state<=2'd0;
				OUT_VALID<=1;
				OUT<=stack[0];
			end
			else begin
				output_state<=2'd0;
				OUT_VALID<=0;
				OUT<=16'd0;
			end
		end
	end
end			
			
		
endmodule 
