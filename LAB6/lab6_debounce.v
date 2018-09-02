`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:25 12/23/2016 
// Design Name: 
// Module Name:    debounce 
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
module debounce(input  clk, input btn_input, output btn_output);

parameter DEBOUNCE_PERIOD = 1000000; /* 20 msec @ 50MHz */

reg [20:0] counter;
reg debounced_btn_state;
reg pressed;

assign btn_output = debounced_btn_state;

always@(posedge clk) begin
	if (btn_input == 0)
	begin
		counter <= 0;
		pressed <= 0;
	end
	else
	begin
		counter <= (counter > DEBOUNCE_PERIOD) ? counter : counter + 1;
		pressed <= (debounced_btn_state == 1)? 1 : 0;
		if (counter == DEBOUNCE_PERIOD && pressed == 0)
			debounced_btn_state <= 1;
		else if (counter > DEBOUNCE_PERIOD)
		begin
			debounced_btn_state <= 0;
		end
	end
end



endmodule 