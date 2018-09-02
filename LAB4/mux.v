`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:46:49 12/02/2016 
// Design Name: 
// Module Name:    mux 
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
module data_template(input clk, input rst, output [31:0] sum);

	wire [7:0] in0, in1, in2, in3, in4, in5, in6, in7;
   reg [7:0] data0[0:31];
	reg [7:0] data1[0:31];
	reg [7:0] data2[0:31];
	reg [7:0] data3[0:31];
	reg [7:0] data4[0:31];
	reg [7:0] data5[0:31];
	reg [7:0] data6[0:31];
	reg [7:0] data7[0:31];
    reg [4:0] choser;
    reg mux_data_available;
    wire [63:0] chose_data;
    
    //divided the mux chose      
	                              assign in0=chose_data[7:0];
                                 assign in1=chose_data[15:8];
                                 assign in2=chose_data[23:16];
                                 assign in3=chose_data[31:24];
                                 assign in4=chose_data[39:32];
                                 assign in5=chose_data[47:40];
                                 assign in6=chose_data[55:48];
                                 assign in7=chose_data[63:56];
    
    //muxpliter
	 
     muxpliter//remember name function
	  name(  
		 .rst(rst),// rst sure to compose mux
        .in0({data0[0],data1[0],data2[0],data3[0],data4[0],data5[0],data6[0],data7[0]}),
        
        .in1({data0[1],data1[1],data2[1],data3[1],data4[1],data5[1],data6[1],data7[1]}),
        
        .in2({data0[2],data1[2],data2[2],data3[2],data4[2],data5[2],data6[2],data7[2]}),
        
        .in3({data0[3],data1[3],data2[3],data3[3],data4[3],data5[3],data6[3],data7[3]}),
        
        .in4({data0[4],data1[4],data2[4],data3[4],data4[4],data5[4],data6[4],data7[4]}),
        
        .in5({data0[5],data1[5],data2[5],data3[5],data4[5],data5[5],data6[5],data7[5]}),
        
        .in6({data0[6],data1[6],data2[6],data3[6],data4[6],data5[6],data6[6],data7[6]}),
        
        .in7({data0[7],data1[7],data2[7],data3[7],data4[7],data5[7],data6[7],data7[7]}), 
        
        .in8({data0[8],data1[8],data2[8],data3[8],data4[8],data5[8],data6[8],data7[8]}),
        
        .in9({data0[9],data1[9],data2[9],data3[9],data4[9],data5[9],data6[9],data7[9]}),
        
        .in10({data0[10],data1[10],data2[10],data3[10],data4[10],data5[10],data6[10],data7[10]}),
        
        .in11({data0[11],data1[11],data2[11],data3[11],data4[11],data5[11],data6[11],data7[11]}),
        
        .in12({data0[12],data1[12],data2[12],data3[12],data4[12],data5[12],data6[12],data7[12]}),
        
        .in13({data0[13],data1[13],data2[13],data3[13],data4[13],data5[13],data6[13],data7[13]}),
        
        .in14({data0[14],data1[14],data2[14],data3[14],data4[14],data5[14],data6[14],data7[14]}),
        
        .in15({data0[15],data1[15],data2[15],data3[15],data4[15],data5[15],data6[15],data7[15]}), 
        
        .in16({data0[16],data1[16],data2[16],data3[16],data4[16],data5[16],data6[16],data7[16]}),
        
        .in17({data0[17],data1[17],data2[17],data3[17],data4[17],data5[17],data6[17],data7[17]}),
        
        .in18({data0[18],data1[18],data2[18],data3[18],data4[18],data5[18],data6[18],data7[18]}),
        
        .in19({data0[19],data1[19],data2[19],data3[19],data4[19],data5[19],data6[19],data7[19]}),
        
        .in20({data0[20],data1[20],data2[20],data3[20],data4[20],data5[20],data6[20],data7[20]}),
        
        .in21({data0[21],data1[21],data2[21],data3[21],data4[21],data5[21],data6[21],data7[21]}),
        
        .in22({data0[22],data1[22],data2[22],data3[22],data4[22],data5[22],data6[22],data7[22]}),
        
        .in23({data0[23],data1[23],data2[23],data3[23],data4[23],data5[23],data6[23],data7[23]}),
        
        .in24({data0[24],data1[24],data2[24],data3[24],data4[24],data5[24],data6[24],data7[24]}),
        
        .in25({data0[25],data1[25],data2[25],data3[25],data4[25],data5[25],data6[25],data7[25]}),
        
        .in26({data0[26],data1[26],data2[26],data3[26],data4[26],data5[26],data6[26],data7[26]}),
        
        .in27({data0[27],data1[27],data2[27],data3[27],data4[27],data5[27],data6[27],data7[27]}),
        
        .in28({data0[28],data1[28],data2[28],data3[28],data4[28],data5[28],data6[28],data7[28]}),
        
        .in29({data0[29],data1[29],data2[29],data3[29],data4[29],data5[29],data6[29],data7[29]}),
        
        .in30({data0[30],data1[30],data2[30],data3[30],data4[30],data5[30],data6[30],data7[30]}),
        
        .in31({data0[31],data1[31],data2[31],data3[31],data4[31],data5[31],data6[31],data7[31]}),
		  .chose(choser), 
        .out(chose_data));
    
    adder_tree add (
		.clk(clk),
		.rst(rst),
		.in_valid(mux_data_available),
		.in0(in0),
		.in1(in1),
		.in2(in2),
		.in3(in3),
		.in4(in4),
		.in5(in5),
		.in6(in6),
		.in7(in7),
		.sum(sum)
	);

  always @(posedge clk)
    if (rst) begin
      data0[ 0] <=   0; data0[ 1] <= 144; data0[ 2] <=  49; data0[ 3] <= 207; data0[ 4] <= 149; data0[ 5] <= 122; data0[ 6] <=  89; data0[ 7] <= 229; data0[ 8] <= 210; data0[ 9] <= 191; data0[10] <=  44; data0[11] <= 219; data0[12] <= 181; data0[13] <= 131; data0[14] <=  77; data0[15] <=   3; data0[16] <=  23; data0[17] <=  93; data0[18] <=  37; data0[19] <=  42; data0[20] <= 253; data0[21] <= 114; data0[22] <=  30; data0[23] <=   1; data0[24] <=   2; data0[25] <=  96; data0[26] <= 136; data0[27] <= 146; data0[28] <= 154; data0[29] <= 155; data0[30] <=  42; data0[31] <= 169;
		data1[ 0] <= 115; data1[ 1] <=  90; data1[ 2] <=  14; data1[ 3] <= 155; data1[ 4] <= 200; data1[ 5] <= 205; data1[ 6] <= 133; data1[ 7] <=  77; data1[ 8] <= 224; data1[ 9] <= 186; data1[10] <= 244; data1[11] <= 236; data1[12] <= 138; data1[13] <=  36; data1[14] <= 118; data1[15] <=  60; data1[16] <= 220; data1[17] <=  53; data1[18] <= 199; data1[19] <= 215; data1[20] <= 255; data1[21] <= 255; data1[22] <= 156; data1[23] <= 100; data1[24] <=  68; data1[25] <=  76; data1[26] <= 215; data1[27] <=   6; data1[28] <=  96; data1[29] <=  23; data1[30] <= 173; data1[31] <=  14;
		data2[ 0] <=   2; data2[ 1] <= 235; data2[ 2] <=  70; data2[ 3] <=  69; data2[ 4] <= 150; data2[ 5] <= 176; data2[ 6] <= 214; data2[ 7] <= 185; data2[ 8] <= 124; data2[ 9] <=  52; data2[10] <= 190; data2[11] <= 119; data2[12] <= 117; data2[13] <= 242; data2[14] <= 190; data2[15] <=  27; data2[16] <= 153; data2[17] <=  98; data2[18] <= 188; data2[19] <= 155; data2[20] <= 146; data2[21] <=  92; data2[22] <=  38; data2[23] <=  57; data2[24] <= 108; data2[25] <= 205; data2[26] <= 132; data2[27] <= 253; data2[28] <= 192; data2[29] <=  88; data2[30] <=  43; data2[31] <= 168;
		data3[ 0] <= 125; data3[ 1] <=  16; data3[ 2] <= 179; data3[ 3] <= 129; data3[ 4] <=  37; data3[ 5] <= 243; data3[ 6] <=  36; data3[ 7] <= 231; data3[ 8] <= 177; data3[ 9] <=  77; data3[10] <= 109; data3[11] <=  18; data3[12] <= 247; data3[13] <= 174; data3[14] <=  39; data3[15] <= 224; data3[16] <= 210; data3[17] <= 149; data3[18] <=  48; data3[19] <=  45; data3[20] <= 209; data3[21] <= 121; data3[22] <=  39; data3[23] <= 129; data3[24] <= 187; data3[25] <= 103; data3[26] <=  71; data3[27] <= 145; data3[28] <= 174; data3[29] <= 193; data3[30] <= 184; data3[31] <= 121;
		data4[ 0] <=  31; data4[ 1] <=  94; data4[ 2] <= 213; data4[ 3] <=   8; data4[ 4] <= 132; data4[ 5] <= 169; data4[ 6] <= 109; data4[ 7] <=  26; data4[ 8] <= 243; data4[ 9] <= 235; data4[10] <= 140; data4[11] <=  88; data4[12] <= 120; data4[13] <=  95; data4[14] <= 216; data4[15] <=  81; data4[16] <= 116; data4[17] <=  69; data4[18] <= 251; data4[19] <=  76; data4[20] <= 189; data4[21] <= 145; data4[22] <=  50; data4[23] <= 194; data4[24] <= 214; data4[25] <= 101; data4[26] <= 128; data4[27] <= 227; data4[28] <=   7; data4[29] <= 254; data4[30] <= 146; data4[31] <=  12;
		data5[ 0] <= 136; data5[ 1] <=  49; data5[ 2] <= 215; data5[ 3] <= 160; data5[ 4] <= 168; data5[ 5] <=  50; data5[ 6] <= 215; data5[ 7] <=  31; data5[ 8] <=  28; data5[ 9] <= 190; data5[10] <=  80; data5[11] <= 240; data5[12] <=  73; data5[13] <=  86; data5[14] <=  35; data5[15] <= 187; data5[16] <= 213; data5[17] <= 181; data5[18] <= 153; data5[19] <= 191; data5[20] <=  64; data5[21] <=  36; data5[22] <=   0; data5[23] <=  15; data5[24] <= 206; data5[25] <= 218; data5[26] <=  53; data5[27] <=  29; data5[28] <= 141; data5[29] <=   3; data5[30] <=  29; data5[31] <= 116;
		data6[ 0] <= 192; data6[ 1] <= 175; data6[ 2] <= 139; data6[ 3] <=  18; data6[ 4] <= 111; data6[ 5] <=  51; data6[ 6] <= 178; data6[ 7] <=  74; data6[ 8] <= 111; data6[ 9] <=  59; data6[10] <= 147; data6[11] <= 136; data6[12] <= 160; data6[13] <=  41; data6[14] <= 129; data6[15] <= 246; data6[16] <= 178; data6[17] <= 236; data6[18] <=  48; data6[19] <=  86; data6[20] <=  45; data6[21] <= 254; data6[22] <= 117; data6[23] <= 255; data6[24] <=  24; data6[25] <= 160; data6[26] <=  24; data6[27] <= 112; data6[28] <= 238; data6[29] <=  12; data6[30] <= 229; data6[31] <=  74;
		data7[ 0] <=  58; data7[ 1] <= 196; data7[ 2] <= 105; data7[ 3] <=  51; data7[ 4] <= 160; data7[ 5] <= 154; data7[ 6] <= 115; data7[ 7] <= 119; data7[ 8] <= 153; data7[ 9] <= 162; data7[10] <= 218; data7[11] <= 212; data7[12] <= 159; data7[13] <= 184; data7[14] <= 144; data7[15] <=  96; data7[16] <=  47; data7[17] <= 188; data7[18] <= 142; data7[19] <= 231; data7[20] <=  62; data7[21] <=  48; data7[22] <= 154; data7[23] <= 178; data7[24] <= 149; data7[25] <=  89; data7[26] <= 126; data7[27] <=  20; data7[28] <= 189; data7[29] <= 156; data7[30] <= 158; data7[31] <= 176;
	   choser <= 0; 
       mux_data_available<=1;
      
    end
	 else begin
     if(choser==31)begin
            mux_data_available<=0;
        end
        if(choser<31)begin
            choser<=choser+1;
        end
     end
endmodule

//normalizer
module normalizer(input clk, input rst, output [7:0] led);

 wire [31:0] sum;
 
  data_template data 
( .clk(clk),
  .rst(rst),
  .sum(sum) 
  );
  
  reg [31:0] average;

 assign led[0]=average[8];//final sum's average 
 assign led[1]=average[9];
 assign led[2]=average[10];
 assign led[3]=average[11];
 assign led[4]=average[12];
 assign led[5]=average[13];
 assign led[6]=average[14];
 assign led[7]=average[15];
 
 
 
 always @(posedge clk)begin
    if(rst)begin
        average<=0;
    end
    else begin
        if(sum!=0)begin
            average<=sum+128;
        end
        else begin
            average<=average;
        end
       end
end
 endmodule
 
 module muxpliter(rst,chose,out,in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,
                  in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31);
       input rst;// rst sure to compose mux
       input [5:0] chose;
       input [63:0] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,
		              in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31;
       output reg [63:0] out;
       always@(rst or chose or in0 or in1 or in2 or in3 or in4 or in5 or in6 or in7 or in8 or in9 or in10 or in11 or in12 or in13 or in14 or in15 or in16 or in17 or in18 or in19 or in20 or in21 or in22 or in23 or in24 or in25 or in26 or in27 or in28 or in29 or in30 or in31)
        if(rst)// rst sure to compose mux
		  begin
			out = 64'b0;
		  end
		  else
		  begin
		  case(chose)
            6'd0:out=in0;
            6'd1:out=in1;
            6'd2:out=in2;
            6'd3:out=in3;
            6'd4:out=in4;
            6'd5:out=in5;
            6'd6:out=in6;
            6'd7:out=in7;
            6'd8:out=in8;
            6'd9:out=in9;
            6'd10:out=in10;
            6'd11:out=in11;
            6'd12:out=in12;
            6'd13:out=in13;
            6'd14:out=in14;
            6'd15:out=in15;
            6'd16:out=in16;
            6'd17:out=in17;
            6'd18:out=in18;
            6'd19:out=in19;
            6'd20:out=in20;
            6'd21:out=in21;
            6'd22:out=in22;
            6'd23:out=in23;
            6'd24:out=in24;
            6'd25:out=in25;
            6'd26:out=in26;
            6'd27:out=in27;
            6'd28:out=in28;
            6'd29:out=in29;
            6'd30:out=in30;
            6'd31:out=in31;
       endcase
       end
   endmodule

