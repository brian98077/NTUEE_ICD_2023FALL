module sigmoid (
	input         clk,
	input         rst_n,
	input         i_in_valid,
	input  [ 7:0] i_x,
	output [15:0] o_y,
	output        o_out_valid,
	output [50:0] number
);

// Your design

	wire [50:0] number0,partialnumber42,number42,partialnumber21,number21,number11,number12,number24,numberDFF;
	wire [6:0] ans_n4ton2,ans_n2ton1,ans_n1top1,ans_p1top2,ans_p2top4; // ans wire -4 to -2, -2 to -1 etc.

	// x = [-4,-2)
	wire [3:0] constant42;
	assign constant42 = 4'b1010; //approximation of 0.19971  7'b0011010
	wire [6:0] shift5; // input multiply 1/32
	//assign shift5[7] = i_x[7];
	assign shift5[6] = i_x[7];
	assign shift5[5] = i_x[7];
	assign shift5[4] = i_x[7];
	assign shift5[3] = i_x[6];
	assign shift5[2] = i_x[5];
	assign shift5[1] = i_x[4];
	assign shift5[0] = i_x[3];

	wire [6:0] shift6; // input multiply 1/64
	//assign shift6[7] = i_x[7];
	assign shift6[6] = i_x[7];
	assign shift6[5] = i_x[7];
	assign shift6[4] = i_x[7];
	assign shift6[3] = i_x[7];
	assign shift6[2] = i_x[6];
	assign shift6[1] = i_x[5];
	assign shift6[0] = i_x[4];

	wire [3:0] ax42; // ax of ax+b in [-4,-2) and [2,4): approximation of 0.04767x
	FA4 partialsum42(ax42,shift5[3:0],shift6[3:0],partialnumber42);
	wire [3:0] subans_n4ton2;
	FA4 ans42(subans_n4ton2,ax42,constant42,number42);
	assign ans_n4ton2 = {3'b000, subans_n4ton2};

	// x = [-2,-1)	
	wire [5:0] constant21;
	assign constant21 = 6'b110111; // approximation of 0.42199  7'b0110111
	wire [6:0] shift3; // input multiply 1/8
	//assign shift3[7] = i_x[7];
	assign shift3[6] = i_x[7];
	assign shift3[5] = i_x[6];
	assign shift3[4] = i_x[5];
	assign shift3[3] = i_x[4];
	assign shift3[2] = i_x[3];
	assign shift3[1] = i_x[2];
	assign shift3[0] = i_x[1];

	wire [5:0] ax21; // ax of ax+b in [-2,-1) and [1,2): approximation of 0.15881x
	FA6 partialsum21(ax21,shift5[5:0],shift3[5:0],partialnumber21);
	wire [5:0] subans_n2ton1;
	FA6 ans21(subans_n2ton1,ax21,constant21,number21);
	assign ans_n2ton1 = {1'b0, subans_n2ton1};

	// x = [-1,1) // y = 0.25x+0.5 = 0.25(x+2)
	wire [6:0] plus2;
	IV plus_2(plus2[6],i_x[6],number11);
	assign plus2[5] = i_x[5];
	assign plus2[4] = i_x[4];
	assign plus2[3] = i_x[3];
	assign plus2[2] = i_x[2];
	assign plus2[1] = i_x[1];
	assign plus2[0] = i_x[0];
	assign ans_n1top1 = plus2;

	// x = [1,2)
	wire [5:0] constant12;
	assign constant12 = 6'b001011; // approximation of 0.57801  7'b1001011
	//wire [5:0] ax12; // ax of ax+b in [1,2) : approximation of 0.15881x
	//FA6 partialsum12(ax12,shift3[5:0],shift5[5:0]);
	wire [5:0] subans_p1top2;
	FA6 ans12(subans_p1top2,ax21,constant12,number12);
	assign ans_p1top2 = {1'b1, subans_p1top2};

	// x = [2,4)
	wire [3:0] constant24;
	assign constant24 = 4'b1000; // approximation of 0.80029  7'b1101000
	wire [3:0] subans_p2top4;
	FA4 ans24(subans_p2top4,ax42,constant24,number24);
	assign ans_p2top4 = {3'b111, subans_p2top4};

	// output stage 
	wire [50:0] numbersubout1,numbersubout2,numbersubout3,numberout,numbereq3;
	wire[6:0] subout1,subout2,subout3,finalans;
	wire inputMSB3; // highest 3 bits same?
	EQ3 msb3eq(inputMSB3,i_x[7],i_x[6],i_x[5],numbereq3);
	MUX7 mux12_24(subout1,ans_p1top2,ans_p2top4,i_x[6],numbersubout1);
	MUX7 mux42_21(subout2,ans_n4ton2,ans_n2ton1,i_x[6],numbersubout2);
	MUX7 muxsubout(subout3,subout1,subout2,i_x[7],numbersubout3);
	MUX7 ansout(finalans,subout3,ans_n1top1,inputMSB3,numberout);

	wire [6:0] temp;
	REGP dff1(clk,rst_n,temp,finalans,numberDFF);
	assign o_y = {1'b0, temp, 8'd0};

	REGP0 dff0(clk,rst_n,o_out_valid,i_in_valid,number0);

	assign number = number0+partialnumber42+number42+partialnumber21+number21+number11+number12+number24+numberDFF+numbersubout1+numbersubout2+numbersubout3+numberout+numbereq3;

// end of design
endmodule

//BW-bit FD2
module REGP#(
	parameter BW = 7
)(
	input           clk,
	input           rst_n,
	output [BW-1:0] Q,
	input  [BW-1:0] D,
	output [  50:0] number
);

wire [50:0] numbers [0:BW-1];

genvar i;
generate
	for (i=0; i<BW; i=i+1) begin
		FD2 f0(Q[i], D[i], clk, rst_n, numbers[i]);
	end
endgenerate

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<BW; j=j+1) begin 
		sum = sum + numbers[j];
	end
end

assign number = sum;

endmodule

module REGP0#(
	parameter BW = 1
)(
	input           clk,
	input           rst_n,
	output [BW-1:0] Q,
	input  [BW-1:0] D,
	output [  50:0] number
);

wire [50:0] numbers [0:BW-1];

genvar i;
generate
	for (i=0; i<BW; i=i+1) begin
		FD2 f0(Q[i], D[i], clk, rst_n, numbers[i]);
	end
endgenerate

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<BW; j=j+1) begin 
		sum = sum + numbers[j];
	end
end

assign number = sum;

endmodule

module FA4(S,A,B,number); // 4bits FA
	
	input [3:0] A,B;
	output [3:0]S;
	output [50:0] number;
	wire [3:0] CI;
	assign CI[0] = 1'b0;
	wire [50:0] numbers [0:3];

	HA1 ha(CI[1], S[0], A[0], B[0], numbers[0]);
	genvar i;
	generate
		for (i=1; i<3; i=i+1) begin
			FA1 fa(CI[i+1], S[i], A[i], B[i], CI[i], numbers[i]);
		end
	endgenerate

	myFA1 fa4(S[3],A[3],B[3],CI[3],numbers[3]);

	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<4; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end

	assign number = sum;
endmodule

module FA5(S,A,B,number); // 5bits FA
	
	input [4:0] A,B;
	output [4:0]S;
	output [50:0] number;
	wire [4:0] CI;
	assign CI[0] = 1'b0;
	wire [50:0] numbers [0:4];

	HA1 ha(CI[1], S[0], A[0], B[0], numbers[0]);
	genvar i;
	generate
		for (i=1; i<4; i=i+1) begin
			FA1 fa(CI[i+1], S[i], A[i], B[i], CI[i], numbers[i]);
		end
	endgenerate

	myFA1 fa5(S[4],A[4],B[4],CI[4],numbers[4]);

	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<5; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end

	assign number = sum;
endmodule

module FA6(S,A,B,number); // 6bits FA
	
	input [5:0] A,B;
	output [5:0]S;
	output [50:0] number;
	wire [5:0] CI;
	assign CI[0] = 1'b0;
	wire [50:0] numbers [0:5];

	HA1 ha(CI[1], S[0], A[0], B[0], numbers[0]);
	genvar i;
	generate
		for (i=1; i<5; i=i+1) begin
			FA1 fa(CI[i+1], S[i], A[i], B[i], CI[i], numbers[i]);
		end
	endgenerate

	myFA1 fa6(S[5],A[5],B[5],CI[5],numbers[5]);

	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<6; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end

	assign number = sum;
endmodule

module FA7(S,A,B,number); // 7bits FA
	
	input [6:0] A,B;
	output [6:0]S;
	output [50:0] number;
	wire [7:0] CI;
	assign CI[0] = 1'b0;
	wire [50:0] numbers [0:6];

	HA1 ha(CI[1], S[0], A[0], B[0], numbers[0]);
	genvar i;
	generate
		for (i=1; i<6; i=i+1) begin
			FA1 fa(CI[i+1], S[i], A[i], B[i], CI[i], numbers[i]);
		end
	endgenerate

	myFA1 fa7(S[6],A[6],B[6],CI[6],numbers[6]);
	wire CO6;
	// //FA1 fa0(CI[1], S[0], A[0], B[0], CI[0], numbers[0]);
	// FA1 fa1(CI[2], S[1], A[1], B[1], CI[1], numbers[1]);
	// FA1 fa2(CI[3], S[2], A[2], B[2], CI[2], numbers[2]);
	// FA1 fa3(CI[4], S[3], A[3], B[3], CI[3], numbers[3]);
	// FA1 fa4(CI[5], S[4], A[4], B[4], CI[4], numbers[4]);
	// FA1 fa5(CO6, S[5], A[5], B[5], CI[5], numbers[5]);
	// FA1 fa6(CI[7], S[6], A[6], B[6], CI[6], numbers[6]);
	// FA1 fa7(CI[8], S[7], A[7], B[7], CI[7], numbers[7]);
	
	// // carry skip
	// wire [50:0] EOnumber0,EOnumber1,EOnumber2,EOnumber3,EOnumber4,EOnumber5,EOnumber6;
	// wire [50:0] ANnumber0,ANnumber1,ANnumber2,ANnumber3,ANnumber4,ANnumber5,ANnumber6;
	// wire [50:0] ppnumber1,ppnumber2,ggnumber1,ggnumber2,MUXnumber1,MUXnumber2;
	// wire p0,p1,p2,p3,p4,p5,p6;
	// wire g0,g1,g2,g3,g4,g5,g6;
	// wire p03,p36; // carry propagate
	// wire g03,g46; // carry generate
	// EO eo0(p0,A[0],B[0],EOnumber0);
	// EO eo1(p1,A[1],B[1],EOnumber1);
	// EO eo2(p2,A[2],B[2],EOnumber2);
	// EO eo3(p3,A[3],B[3],EOnumber3);
	// EO eo4(p4,A[4],B[4],EOnumber4);
	// EO eo5(p5,A[5],B[5],EOnumber5);
	// EO eo6(p6,A[6],B[6],EOnumber6);
	// //AN4 pp1(p03,p0,p1,p2,p3,ppnumber1);
	// AN4 pp2(p36,P3,p4,p5,p2,ppnumber2);

	// // AN2 an0(g0,A[0],B[0],ANnumber0);
	// // AN2 an1(g1,A[1],B[1],ANnumber1);
	// // AN2 an2(g2,A[2],B[2],ANnumber2);
	// // AN2 an3(g3,A[3],B[3],ANnumber3);
	// // AN2 an4(g4,A[4],B[4],ANnumber4);
	// // AN2 an5(g5,A[5],B[5],ANnumber5);
	// // AN2 an6(g6,A[6],B[6],ANnumber6);
	// // ND4 gg1(g03,g0,g1,g2,g3,ggnumber1);
	// // ND3 gg2(g46,g4,g5,g6,ggnumber2);

	// //wire w1,w2,invg03,invg46;
	// //IV invg1(invg03,g03);
	// //IV invg2(invg46,g46);
	// // ND2 a1(w1,CI[0],p03);
	// // ND2 aa1(CI[4],w1,g03);
	// // ND2 a2(w2,CI[4],p46);
	// // ND2 aa2(CI[7],w2,g46);

	// //MUX21H mux1(CI[4],CO3,CI[0],p1,MUXnumber1);
	// MUX21H mux2(CI[6],CO6,CI[2],p36,MUXnumber2);

	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<7; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end

	assign number = sum;
endmodule

module MUX7(Z,A,B,CTRL,number); // 7bits MUX

	input [6:0] A,B;
	input CTRL;
	output [6:0] Z;
	wire [50:0] numbers [0:6];
	output [50:0] number;

	genvar i;
	generate
		for (i=0; i<7; i=i+1) begin
			MUX21H mux(Z[i], A[i], B[i], CTRL, numbers[i]);
		end
	endgenerate

	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<7; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end

	assign number = sum;
endmodule

module EQ3(Z,A,B,C,number); // equivalence

	input A,B,C;
	output Z;
	output [50:0] number;
	wire W1,W2;
	wire [50:0] number1,number2,number3;
	AN3 SUB1(W1,A,B,C,number1);
	NR3 SUB2(W2,A,B,C,number2);
	OR2 SUB3(Z,W1,W2,number3);
	
	assign number = number1+number2+number3; // 8 + 6 + 6

endmodule

module myFA1(S,A,B,CI,number); // FA without carry out

	input A,B,CI;
	output S;
	output [50:0] number;
	wire [50:0] n1;
	
	EO3 a1(S,A,B,CI,number);
	

endmodule