`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:43:16 10/20/2015 
// Design Name: 
// Module Name:    lab5 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// matrix_additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module lab6(
    input clk,
    input reset,
    input button,
    input rx,
    output tx,
    output [7:0] led
    ); 
		
//localparam
localparam [1:0] S_IDLE = 2'b00, S_Waitmatrix_aIT = 2'b01, S_SEND = 2'b10, S_INCR = 2'b11;
localparam MEM_SIZE = 130;

// declare system variables
wire btn_pressed;
reg [7:0] send_counter;
reg [1:0] Q, Q_next;
reg [7:0] data[0:MEM_SIZE-1];
integer idx;

// declare Umatrix_aRT signals
wire transmit;
wire received;
wire [7:0] rx_byte;
reg  [7:0] rx_temp;
wire [7:0] tx_byte;
wire is_receiving;
wire is_transmitting;
wire recv_error;
wire [7:0] recv_true;//receive is correct
assign recv_true=rx_byte-48;

assign led = { 7'b0, btn_pressed };
assign tx_byte = data[send_counter];
//debounce
debounce btn_db(
    .clk(clk),
    .btn_input(button),
    .btn_output(btn_pressed)
    );
//uart
uart uart(
    .clk(clk),
    .rst(reset),
    .rx(rx),
    .tx(tx),
    .transmit(transmit),
    .tx_byte(tx_byte),
    .received(received),
    .rx_byte(rx_byte),
    .is_receiving(is_receiving),
    .is_transmitting(is_transmitting),
    .recv_error(recv_error)
    );
// Initializes the "Hello, World! " string
/*always begin
  data[ 0] = 8'h48;
  data[ 1] = 8'h65;
  data[ 2] = 8'h6C;
  data[ 3] = 8'h6C;
  data[ 4] = 8'h6F;
  data[ 5] = 8'h2C;
  data[ 6] = 8'h20;
  data[ 7] = 8'h57;
  data[ 8] = 8'h6F;
  data[ 9] = 8'h72;
  data[10] = 8'h6C;
  data[11] = 8'h64;
  data[12] = 8'h21;
  data[13] = 8'h20;
  data[14] = 8'h0;  // end of string
  for (idx = 15; idx < MEM_SIZE; idx = idx + 1) data[idx] = 8'h0;
end
*/
// ------------------------------------------------------------------------
// FSM of the "Hello, World!" transmission controller

always @(posedge clk) begin
  if (reset) Q <= S_IDLE;
  else Q <= Q_next;
end

always @(*) begin // FSM next-state logic
  case (Q)
    S_IDLE: // wait for button click
      if (btn_pressed == 1) Q_next = S_Waitmatrix_aIT;
      else Q_next = S_IDLE;
    S_Waitmatrix_aIT: // wait for the transmission of current data byte begins
      if (is_transmitting == 1) Q_next = S_SEND;
      else Q_next = S_Waitmatrix_aIT;
    S_SEND: // wait for the transmission of current data byte finishes
      if (is_transmitting == 0) Q_next = S_INCR; // transmit next character
      else Q_next = S_SEND;
    S_INCR:
      if (tx_byte == 8'h0) Q_next = S_IDLE; // string transmission ends
      else Q_next = S_Waitmatrix_aIT;
  endcase
end

// FSM output logics
assign transmit = (Q == S_Waitmatrix_aIT)? 1 : 0;

// FSM-controlled send_counter incrementing data path
always @(posedge clk) begin
  if (reset || (Q == S_IDLE))
    send_counter <= 0;
  else if (Q == S_INCR)
    send_counter <= send_counter + 1;
end

// End of the FSM of the "Hello, World! " transmission controller
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// The following logic stores the Umatrix_aRT input in a temporary buffer
// You must replace this code by your own code to store multiple
// bytes of data.

//declare variables
reg [7:0]matrix1[0:15];
reg [7:0]vector[0:3];
reg [7:0]matrix2[0:15];
integer k=0;
integer index=0;
integer h=0;

 always@(posedge clk)begin
      if (reset)begin
		rx_temp <= 8'd0;
	  end 
	  else if(received)begin//read the input file
		case(index)
			0:begin
			  rx_temp<=rx_temp+recv_true*100;//百位
			  index=index+1;
              end
			1:begin
			  rx_temp <= rx_temp + recv_true*10;//十位
			  index=index+1;
              end
			2:begin
              rx_temp <= rx_temp + recv_true;//個位
              index=index+1;
              end
       endcase
      end 
	  else if(index==3)begin
		index=0;
			if(k<=15)begin
				matrix1[k]<=rx_temp;
				k=k+1;
			end
			else if(k<=19)begin
				vector[k-16]<=rx_temp;
				k=k+1;
			end
			else if(k<=35)begin
				matrix2[k-20]<=rx_temp;
				k=k+1;
			end
		rx_temp<=0;
	  end
 end
//declared 
reg [19:0] Ans1 [0:3];//part A answer(unchange)
reg [19:0] Ans2 [0:15];//part B answer(unchange)
integer part1_index; 
integer matrix1_index;
integer part2_index;
integer matrix1part2_index;
integer matrix2part2_index; 

always @(posedge clk)begin
  if(reset)begin
	part1_index = 0;
	matrix1_index = 0;
	part2_index = 0;
	matrix1part2_index = 0;
	matrix2part2_index = 0;
	for(h=0; h<4; h=h+1)begin
		Ans1[h] <= 8'd0;
	end
	for(h=0; h<16; h=h+1)begin
		Ans2[h] <= 8'd0;
	end
  end 
  else if(k==36)begin
	if(matrix1_index<15)begin//part A calculate
		Ans1[part1_index] <= matrix1[matrix1_index] * vector[0] + matrix1[matrix1_index+1] * vector[1] + matrix1[matrix1_index+2] * vector[2] + matrix1[matrix1_index+3] * vector[3];
	end
	else if(matrix1part2_index<14) begin
		Ans2[part2_index] <= matrix1[matrix1part2_index] * matrix2[matrix2part2_index] + matrix1[ matrix1part2_index + 1] * matrix2[matrix2part2_index + 4] + matrix1[matrix1part2_index + 2] * matrix2[matrix2part2_index + 8] + matrix1[matrix1part2_index + 3] * matrix2[matrix2part2_index+ 12];
		if(matrix2part2_index<3)begin
			part2_index = part2_index + 1;
			matrix2part2_index = matrix2part2_index + 1;
		end 
		else if(matrix2part2_index==3)begin//when matrix2 column reach 3
			part2_index = part2_index + 1;
			matrix2part2_index = 0;//return to 0 column
			matrix1part2_index = matrix1part2_index + 4;
		end
    end
  part1_index = part1_index + 1;
  matrix1_index = matrix1_index + 4;
  end
end
//Turn answer(20 bits) into 16 bits
always@(posedge clk)begin
  if(reset)begin 
  end
  else if(matrix1part2_index>=14)begin
	//part A
    data[0]<= (Ans1[0][19:16]<=9 )? Ans1[0][19:16]+48: Ans1[0][19:16]+55;
    data[1]<= (Ans1[0][15:12]<=9 )? Ans1[0][15:12]+48: Ans1[0][15:12]+55;
    data[2]<= (Ans1[0][11:8]<=9 )? Ans1[0][11:8]+48: Ans1[0][11:8]+55;
    data[3]<= (Ans1[0][7:4]<=9 )? Ans1[0][7:4]+48: Ans1[0][7:4]+55;
    data[4]<= (Ans1[0][3:0]<=9 )? Ans1[0][3:0]+48: Ans1[0][3:0]+55;
    data[5]<=13;
    data[6]<=10;
    data[7]<= (Ans1[1][19:16]<=9 )? Ans1[1][19:16]+48: Ans1[1][19:16]+55;
    data[8]<= (Ans1[1][15:12]<=9 )? Ans1[1][15:12]+48: Ans1[1][15:12]+55;
    data[9]<= (Ans1[1][11:8]<=9 )? Ans1[1][11:8]+48: Ans1[1][11:8]+55;
    data[10]<= (Ans1[1][7:4]<=9 )? Ans1[1][7:4]+48: Ans1[1][7:4]+55;
    data[11]<= (Ans1[1][3:0]<=9 )? Ans1[1][3:0]+48: Ans1[1][3:0]+55;
    data[12]<=13;
    data[13]<=10;
    data[14]<= (Ans1[2][19:16]<=9 )? Ans1[2][19:16]+48: Ans1[2][19:16]+55;
    data[15]<= (Ans1[2][15:12]<=9 )? Ans1[2][15:12]+48: Ans1[2][15:12]+55;
    data[16]<= (Ans1[2][11:8]<=9 )? Ans1[2][11:8]+48: Ans1[2][11:8]+55;
    data[17]<= (Ans1[2][7:4]<=9 )? Ans1[2][7:4]+48: Ans1[2][7:4]+55;
    data[18]<= (Ans1[2][3:0]<=9 )? Ans1[2][3:0]+48: Ans1[2][3:0]+55;
    data[19]<=13;
    data[20]<=10;
    data[21]<= (Ans1[3][19:16]<=9 )? Ans1[3][19:16]+48: Ans1[3][19:16]+55;
    data[22]<= (Ans1[3][15:12]<=9 )? Ans1[3][15:12]+48: Ans1[3][15:12]+55;
    data[23]<= (Ans1[3][11:8]<=9 )? Ans1[3][11:8]+48: Ans1[3][11:8]+55;
    data[24]<= (Ans1[3][7:4]<=9 )? Ans1[3][7:4]+48: Ans1[3][7:4]+55;
    data[25]<= (Ans1[3][3:0]<=9 )? Ans1[3][3:0]+48: Ans1[3][3:0]+55;
    data[26]<=13;//CR
    data[27]<=10;//LF
	//part B
    data[28]<= (Ans2[0][19:16]<=9 )? Ans2[0][19:16]+48: Ans2[0][19:16]+55;
    data[29]<= (Ans2[0][15:12]<=9 )? Ans2[0][15:12]+48: Ans2[0][15:12]+55;
    data[30]<= (Ans2[0][11:8]<=9 )? Ans2[0][11:8]+48: Ans2[0][11:8]+55;
    data[31]<= (Ans2[0][7:4]<=9 )? Ans2[0][7:4]+48: Ans2[0][7:4]+55;
    data[32]<= (Ans2[0][3:0]<=9 )? Ans2[0][3:0]+48: Ans2[0][3:0]+55;
    data[33]<= 32;//space
    data[34]<= (Ans2[1][19:16]<=9 )? Ans2[1][19:16]+48: Ans2[1][19:16]+55;
    data[35]<= (Ans2[1][15:12]<=9 )? Ans2[1][15:12]+48: Ans2[1][15:12]+55;
    data[36]<= (Ans2[1][11:8]<=9 )? Ans2[1][11:8]+48: Ans2[1][11:8]+55;	
    data[37]<= (Ans2[1][7:4]<=9 )? Ans2[1][7:4]+48: Ans2[1][7:4]+55;
    data[38]<= (Ans2[1][3:0]<=9 )? Ans2[1][3:0]+48: Ans2[1][3:0]+55;
    data[39]<= 32;
    data[40]<= (Ans2[2][19:16]<=9 )? Ans2[2][19:16]+48: Ans2[2][19:16]+55;
    data[41]<= (Ans2[2][15:12]<=9 )? Ans2[2][15:12]+48: Ans2[2][15:12]+55;
    data[42]<= (Ans2[2][11:8]<=9 )? Ans2[2][11:8]+48: Ans2[2][11:8]+55;
    data[43]<= (Ans2[2][7:4]<=9 )? Ans2[2][7:4]+48: Ans2[2][7:4]+55;
    data[44]<= (Ans2[2][3:0]<=9 )? Ans2[2][3:0]+48: Ans2[2][3:0]+55;
    data[45]<= 32;
    data[46]<= (Ans2[3][19:16]<=9 )? Ans2[3][19:16]+48: Ans2[3][19:16]+55;
    data[47]<= (Ans2[3][15:12]<=9 )? Ans2[3][15:12]+48: Ans2[3][15:12]+55;
    data[48]<= (Ans2[3][11:8]<=9 )? Ans2[3][11:8]+48: Ans2[3][11:8]+55;
    data[49]<= (Ans2[3][7:4]<=9 )? Ans2[3][7:4]+48: Ans2[3][7:4]+55;
    data[50]<= (Ans2[3][3:0]<=9 )? Ans2[3][3:0]+48: Ans2[3][3:0]+55;
    data[51]<= 13;
    data[52]<= 10;
    data[53]<= (Ans2[4][19:16]<=9 )? Ans2[4][19:16]+48: Ans2[4][19:16]+55;
    data[54]<= (Ans2[4][15:12]<=9 )? Ans2[4][15:12]+48: Ans2[4][15:12]+55;
    data[55]<= (Ans2[4][11:8]<=9 )? Ans2[4][11:8]+48: Ans2[4][11:8]+55;
    data[56]<= (Ans2[4][7:4]<=9 )? Ans2[4][7:4]+48: Ans2[4][7:4]+55;
    data[57]<= (Ans2[4][3:0]<=9 )? Ans2[4][3:0]+48: Ans2[4][3:0]+55;
    data[58]<= 32;
    data[59]<= (Ans2[5][19:16]<=9 )? Ans2[5][19:16]+48: Ans2[5][19:16]+55;
    data[60]<= (Ans2[5][15:12]<=9 )? Ans2[5][15:12]+48: Ans2[5][15:12]+55;
    data[61]<= (Ans2[5][11:8]<=9 )? Ans2[5][11:8]+48: Ans2[5][11:8]+55;
    data[62]<= (Ans2[5][7:4]<=9 )? Ans2[5][7:4]+48: Ans2[5][7:4]+55;
    data[63]<= (Ans2[5][3:0]<=9 )? Ans2[5][3:0]+48: Ans2[5][3:0]+55;
    data[64]<= 32;
    data[65]<= (Ans2[6][19:16]<=9 )? Ans2[6][19:16]+48: Ans2[6][19:16]+55;
    data[66]<= (Ans2[6][15:12]<=9 )? Ans2[6][15:12]+48: Ans2[6][15:12]+55;
    data[67]<= (Ans2[6][11:8]<=9 )? Ans2[6][11:8]+48: Ans2[6][11:8]+55;
    data[68]<= (Ans2[6][7:4]<=9 )? Ans2[6][7:4]+48: Ans2[6][7:4]+55;
    data[69]<= (Ans2[6][3:0]<=9 )? Ans2[6][3:0]+48: Ans2[6][3:0]+55;
    data[70]<= 32;
    data[71]<= (Ans2[7][19:16]<=9 )? Ans2[7][19:16]+48: Ans2[7][19:16]+55;
    data[72]<= (Ans2[7][15:12]<=9 )? Ans2[7][15:12]+48: Ans2[7][15:12]+55;
    data[73]<= (Ans2[7][11:8]<=9 )? Ans2[7][11:8]+48: Ans2[7][11:8]+55;
    data[74]<= (Ans2[7][7:4]<=9 )? Ans2[7][7:4]+48: Ans2[7][7:4]+55;
    data[75]<= (Ans2[7][3:0]<=9 )? Ans2[7][3:0]+48: Ans2[7][3:0]+55;
    data[76]<= 13;
    data[77]<= 10;
    data[78]<= (Ans2[8][19:16]<=9 )? Ans2[8][19:16]+48: Ans2[8][19:16]+55;
    data[79]<= (Ans2[8][15:12]<=9 )? Ans2[8][15:12]+48: Ans2[8][15:12]+55;
    data[80]<= (Ans2[8][11:8]<=9 )? Ans2[8][11:8]+48: Ans2[8][11:8]+55;
    data[81]<= (Ans2[8][7:4]<=9 )? Ans2[8][7:4]+48: Ans2[8][7:4]+55;
    data[82]<= (Ans2[8][3:0]<=9 )? Ans2[8][3:0]+48: Ans2[8][3:0]+55;
    data[83]<= 32;
    data[84]<= (Ans2[9][19:16]<=9 )? Ans2[9][19:16]+48: Ans2[9][19:16]+55;
    data[85]<= (Ans2[9][15:12]<=9 )? Ans2[9][15:12]+48: Ans2[9][15:12]+55;
    data[86]<= (Ans2[9][11:8]<=9 )? Ans2[9][11:8]+48: Ans2[9][11:8]+55;
    data[87]<= (Ans2[9][7:4]<=9 )? Ans2[9][7:4]+48: Ans2[9][7:4]+55;
    data[88]<= (Ans2[9][3:0]<=9 )? Ans2[9][3:0]+48: Ans2[9][3:0]+55;
    data[89]<= 32;
    data[90]<= (Ans2[10][19:16]<=9 )? Ans2[10][19:16]+48: Ans2[10][19:16]+55;
    data[91]<= (Ans2[10][15:12]<=9 )? Ans2[10][15:12]+48: Ans2[10][15:12]+55;
    data[92]<= (Ans2[10][11:8]<=9 )? Ans2[10][11:8]+48: Ans2[10][11:8]+55;
    data[93]<= (Ans2[10][7:4]<=9 )? Ans2[10][7:4]+48: Ans2[10][7:4]+55;
    data[94]<= (Ans2[10][3:0]<=9 )? Ans2[10][3:0]+48: Ans2[10][3:0]+55;
    data[95]<= 32;
    data[96]<= (Ans2[11][19:16]<=9 )? Ans2[11][19:16]+48: Ans2[11][19:16]+55;
    data[97]<= (Ans2[11][15:12]<=9 )? Ans2[11][15:12]+48: Ans2[11][15:12]+55;
    data[98]<= (Ans2[11][11:8]<=9 )? Ans2[11][11:8]+48: Ans2[11][11:8]+55;
    data[99]<= (Ans2[11][7:4]<=9 )? Ans2[11][7:4]+48: Ans2[11][7:4]+55;
    data[100]<= (Ans2[11][3:0]<=9 )? Ans2[11][3:0]+48: Ans2[11][3:0]+55;
    data[101]<= 13;
    data[102]<= 10;
    data[103]<= (Ans2[12][19:16]<=9 )? Ans2[12][19:16]+48: Ans2[12][19:16]+55;
    data[104]<= (Ans2[12][15:12]<=9 )? Ans2[12][15:12]+48: Ans2[12][15:12]+55;
    data[105]<= (Ans2[12][11:8]<=9 )? Ans2[12][11:8]+48: Ans2[12][11:8]+55;
    data[106]<= (Ans2[12][7:4]<=9 )? Ans2[12][7:4]+48: Ans2[12][7:4]+55;
    data[107]<= (Ans2[12][3:0]<=9 )? Ans2[12][3:0]+48: Ans2[12][3:0]+55;
    data[108]<= 32;
    data[109]<= (Ans2[13][19:16]<=9 )? Ans2[13][19:16]+48: Ans2[13][19:16]+55;
    data[110]<= (Ans2[13][15:12]<=9 )? Ans2[13][15:12]+48: Ans2[13][15:12]+55;
    data[111]<= (Ans2[13][11:8]<=9 )? Ans2[13][11:8]+48: Ans2[13][11:8]+55;
    data[112]<= (Ans2[13][7:4]<=9 )? Ans2[13][7:4]+48: Ans2[13][7:4]+55;
    data[113]<= (Ans2[13][3:0]<=9 )? Ans2[13][3:0]+48: Ans2[13][3:0]+55;
    data[114]<= 32;
    data[115]<= (Ans2[14][19:16]<=9 )? Ans2[14][19:16]+48: Ans2[14][19:16]+55;
    data[116]<= (Ans2[14][15:12]<=9 )? Ans2[14][15:12]+48: Ans2[14][15:12]+55;
    data[117]<= (Ans2[14][11:8]<=9 )? Ans2[14][11:8]+48: Ans2[14][11:8]+55;
    data[118]<= (Ans2[14][7:4]<=9 )? Ans2[14][7:4]+48: Ans2[14][7:4]+55;
    data[119]<= (Ans2[14][3:0]<=9 )? Ans2[14][3:0]+48: Ans2[14][3:0]+55;
    data[120]<= 32;
    data[121]<= (Ans2[15][19:16]<=9 )? Ans2[15][19:16]+48: Ans2[15][19:16]+55;
    data[122]<= (Ans2[15][15:12]<=9 )? Ans2[15][15:12]+48: Ans2[15][15:12]+55;
    data[123]<= (Ans2[15][11:8]<=9 )? Ans2[15][11:8]+48: Ans2[15][11:8]+55;
    data[124]<= (Ans2[15][7:4]<=9 )? Ans2[15][7:4]+48: Ans2[15][7:4]+55;
    data[125]<= (Ans2[15][3:0]<=9 )? Ans2[15][3:0]+48: Ans2[15][3:0]+55;  
	  data[126]<= 13;
		data[127]<= 10;
		data[128]<= 0;
  end
end
endmodule

  