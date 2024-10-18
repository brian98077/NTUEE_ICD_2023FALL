`timescale 1ns/1ps

module poker(type, i0, i1, i2, i3, i4);
//DO NOT CHANGE!
	input  [5:0] i0, i1, i2, i3, i4;
	output [3:0] type;
//---------------------------------------------------

	// one pair
	wire onepout1,onepout2,onepout3,onepout4,onepout5,onepout6,onepout7,onepout8,onepout9,onepout10;
	wire isonepair;

	onepairinv onep1(onepout1,i0,i1);
	onepairinv onep2(onepout2,i0,i2);
	onepairinv onep3(onepout3,i0,i3);
	onepairinv onep4(onepout4,i0,i4);
	onepairinv onep5(onepout5,i1,i2);
	onepairinv onep6(onepout6,i1,i3);
	onepairinv onep7(onepout7,i1,i4);
	onepairinv onep8(onepout8,i2,i3);
	onepairinv onep9(onepout9,i2,i4);
	onepairinv onep10(onepout10,i3,i4);
	ND10 onepans(isonepair,onepout1,onepout2,onepout3,onepout4,onepout5,onepout6,onepout7,onepout8,onepout9,onepout10);

	// two pairs
	wire istwopairs;
	twopairs twopairsans(istwopairs,i0,i1,i2,i3,i4);

	// three of a kind
	wire threeout1,threeout2,threeout3,threeout4,threeout5,threeout6,threeout7,threeout8,threeout9,threeout10;
	wire isthree;

	threesameinv three1(threeout1,i0,i1,i2);
	threesameinv three2(threeout2,i0,i1,i3);
	threesameinv three3(threeout3,i0,i1,i4);
	threesameinv three4(threeout4,i0,i2,i3);
	threesameinv three5(threeout5,i0,i2,i4);
	threesameinv three6(threeout6,i0,i3,i4);
	threesameinv three7(threeout7,i1,i2,i3);
	threesameinv three8(threeout8,i1,i2,i4);
	threesameinv three9(threeout9,i1,i3,i4);
	threesameinv three10(threeout10,i2,i3,i4);
	ND10 threeans(isthree,threeout1,threeout2,threeout3,threeout4,threeout5,threeout6,threeout7,threeout8,threeout9,threeout10);
	
	// full house
	wire isfullhouse;
	fullhouse fullhouseans(isfullhouse,i0,i1,i2,i3,i4);

	// four of a kind
	wire fourout1,fourout2,fourout3,fourout4,fourout5;
	wire isfour;
	foursameinv four1(fourout1,i0,i1,i2,i3);
	foursameinv four2(fourout2,i0,i1,i2,i4);
	foursameinv four3(fourout3,i0,i1,i3,i4);
	foursameinv four5(fourout5,i0,i2,i3,i4);
	foursameinv four4(fourout4,i1,i2,i3,i4);
	ND5 fourans(isfour,fourout1,fourout2,fourout3,fourout4,fourout5);

	// flush
	wire isflush;
	flush flushans(isflush,i0,i1,i2,i3,i4);

	// straight
	wire isstraight;
	wire W1,W2,W3,W4,W5,W6,W7,W8,W9,W10;
	wire W11,W12,W13,W14,W15;
	wire W22,W23,W24,W25,W26;
	wire W33,W34,W35,W36,W37;
	wire W44,W45,W46,W47,W48;
	wire W55,W56,W57,W58,W59;
	wire W66,W67,W68,W69,W610;
	wire W77,W78,W79,W710,W711;
	wire W88,W89,W810,W811,W812;
	wire W99,W910,W911,W912,W913;
	wire W1010,W1011,W1012,W1013,W101;
	
	exist1 straight11(W11,i0,i1,i2,i3,i4);
	exist2 straight12(W12,i0,i1,i2,i3,i4);
	exist3 straight13(W13,i0,i1,i2,i3,i4);
	exist4 straight14(W14,i0,i1,i2,i3,i4);
	exist5 straight15(W15,i0,i1,i2,i3,i4);
	ND5 straightout1(W1,W11,W12,W13,W14,W15);

	exist2 straight22(W22,i0,i1,i2,i3,i4);
	exist3 straight23(W23,i0,i1,i2,i3,i4);
	exist4 straight24(W24,i0,i1,i2,i3,i4);
	exist5 straight25(W25,i0,i1,i2,i3,i4);
	exist6 straight26(W26,i0,i1,i2,i3,i4);
	ND5 straightout2(W2,W22,W23,W24,W25,W26);

	exist3 straight33(W33,i0,i1,i2,i3,i4);
	exist4 straight34(W34,i0,i1,i2,i3,i4);
	exist5 straight35(W35,i0,i1,i2,i3,i4);
	exist6 straight36(W36,i0,i1,i2,i3,i4);
	exist7 straight37(W37,i0,i1,i2,i3,i4);
	ND5 straightout3(W3,W33,W34,W35,W36,W37);

	exist4 straight44(W44,i0,i1,i2,i3,i4);
	exist5 straight45(W45,i0,i1,i2,i3,i4);
	exist6 straight46(W46,i0,i1,i2,i3,i4);
	exist7 straight47(W47,i0,i1,i2,i3,i4);
	exist8 straight48(W48,i0,i1,i2,i3,i4);
	ND5 straightout4(W4,W44,W45,W46,W47,W48);

	exist5 straight55(W55,i0,i1,i2,i3,i4);
	exist6 straight56(W56,i0,i1,i2,i3,i4);
	exist7 straight57(W57,i0,i1,i2,i3,i4);
	exist8 straight58(W58,i0,i1,i2,i3,i4);
	exist9 straight59(W59,i0,i1,i2,i3,i4);
	ND5 straightout5(W5,W55,W56,W57,W58,W59);

	exist6 straight66(W66,i0,i1,i2,i3,i4);
	exist7 straight67(W67,i0,i1,i2,i3,i4);
	exist8 straight68(W68,i0,i1,i2,i3,i4);
	exist9 straight69(W69,i0,i1,i2,i3,i4);
	exist10 straight610(W610,i0,i1,i2,i3,i4);
	ND5 straightout6(W6,W66,W67,W68,W69,W610);

	exist7 straight77(W77,i0,i1,i2,i3,i4);
	exist8 straight78(W78,i0,i1,i2,i3,i4);
	exist9 straight79(W79,i0,i1,i2,i3,i4);
	exist10 straight710(W710,i0,i1,i2,i3,i4);
	exist11 straight711(W711,i0,i1,i2,i3,i4);
	ND5 straightout7(W7,W77,W78,W79,W710,W711);

	exist8 straight88(W88,i0,i1,i2,i3,i4);
	exist9 straight89(W89,i0,i1,i2,i3,i4);
	exist10 straight810(W810,i0,i1,i2,i3,i4);
	exist11 straight811(W811,i0,i1,i2,i3,i4);
	exist12 straight812(W812,i0,i1,i2,i3,i4);
	ND5 straightout8(W8,W88,W89,W810,W811,W812);

	exist9 straight99(W99,i0,i1,i2,i3,i4);
	exist10 straight910(W910,i0,i1,i2,i3,i4);
	exist11 straight911(W911,i0,i1,i2,i3,i4);
	exist12 straight912(W912,i0,i1,i2,i3,i4);
	exist13 straight913(W913,i0,i1,i2,i3,i4);
	ND5 straightout9(W9,W99,W910,W911,W912,W913);

	exist10 straight1010(W1010,i0,i1,i2,i3,i4);
	exist11 straight1011(W1011,i0,i1,i2,i3,i4);
	exist12 straight1012(W1012,i0,i1,i2,i3,i4);
	exist13 straight1013(W1013,i0,i1,i2,i3,i4);
	exist1 straight101(W101,i0,i1,i2,i3,i4);
	ND5 straightout10(W10,W1010,W1011,W1012,W1013,W101);

	ND10 straightans(isstraight,W1,W2,W3,W4,W5,W6,W7,W8,W9,W10);

	//straight flush
	wire isstraightflush;
	AN2 sf(isstraightflush,isstraight,isflush);

	// output stage
	// output0
	wire onepoutiv,threeoutiv,flushoutiv,fouroutiv,out01,out02,out03;
	IV onepiv(onepoutiv,isonepair);
	OR3 subout01(out01,onepoutiv,istwopairs,isfullhouse);
	IV threeiv(threeoutiv,isthree);
	OR2 subout02(out02,threeoutiv,isfullhouse);
	IV flushiv(flushoutiv,isflush);
	OR2 subout03(out03,flushoutiv,isstraightflush);
	IV fouriv(fouroutiv,isfour);
	ND4 output0(type[0],out01,out02,out03,fouroutiv);

	//output1
	MYOR4 output1(type[1],istwopairs,isthree,isfullhouse,isfour);

	//output2
	wire straightoutiv,fullhouseoutiv,out21,out22;
	IV straightiv(straightoutiv,isstraight);
	OR2 subout21(out21,isstraightflush,straightoutiv);
	OR2 subout22(out22,isstraightflush,flushoutiv);
	IV fullhouseiv(fullhouseoutiv,isfullhouse);
	ND4 output2(type[2],out21,out22,fullhouseoutiv,fouroutiv);

	//output3
	AN2 output3(type[3],isstraight,isflush);


endmodule


// inverted one pair
module onepairinv(Z,A,B);

	input [5:0] A,B;
	output Z;
	wire W0,W1,W2,W3;

	EQ2 SUB0(W0,A[0],B[0]);
	EQ2 SUB1(W1,A[1],B[1]);
	EQ2 SUB2(W2,A[2],B[2]);
	EQ2 SUB3(W3,A[3],B[3]);
	ND4 SUB4(Z,W0,W1,W2,W3);

endmodule

// two pairs
module twopairs(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire WAB,WAC,WAD,WAE,WBC,WBD,WBE,WCD,WCE,WDE;
	wire WABCD,WABCE,WABDE;
	wire WACBD,WACBE,WACDE;
	wire WADBC,WADBE,WADCE;
	wire WAEBC,WAEBD,WAECD;
	wire WBCAD,WBCAE,WBCDE;
	wire WBDAC,WBDAE,WBDCE;
	wire WBEAC,WBEAD,WBECD;
	wire WCDAB,WCDAE,WCDBE;
	wire WCEAB,WCEAD,WCEBD;
	wire WDEAB,WDEAC,WDEBC;
	wire W1,W2,W3,W4,W5,W6,W7,W8,W9,W10;

	onepairinv SUB1(WAB,A,B);
	onepairinv SUB2(WAC,A,C);
	onepairinv SUB3(WAD,A,D);
	onepairinv SUB4(WAE,A,E);
	onepairinv SUB5(WBC,B,C);
	onepairinv SUB6(WBD,B,D);
	onepairinv SUB7(WBE,B,E);
	onepairinv SUB8(WCD,C,D);
	onepairinv SUB9(WCE,C,E);
	onepairinv SUB10(WDE,D,E);

	NR2 SUBA1(WABCD,WAB,WCD);
	NR2 SUBA2(WABCE,WAB,WCE);
	NR2 SUBA3(WABDE,WAB,WDE);
	NR3 O1(W1,WABCD,WABCE,WABDE);

	NR2 SUBB1(WACBD,WAC,WBD);
	NR2 SUBB2(WACBE,WAC,WBE);
	NR2 SUBB3(WACDE,WAC,WDE);
	NR3 O2(W2,WACBD,WACBE,WACDE);

	NR2 SUBC1(WADBC,WAD,WBC);
	NR2 SUBC2(WADBE,WAD,WBE);
	NR2 SUBC3(WADCE,WAD,WCE);
	NR3 O3(W3,WADBC,WADBE,WADCE);

	NR2 SUBD1(WAEBC,WAE,WBC);
	NR2 SUBD2(WAEBD,WAE,WBD);
	NR2 SUBD3(WAECD,WAE,WCD);
	NR3 O4(W4,WAEBC,WAEBD,WAECD);

	NR2 SUBE1(WBCAD,WBC,WAD);
	NR2 SUBE2(WBCAE,WBC,WAE);
	NR2 SUBE3(WBCDE,WBC,WDE);
	NR3 O5(W5,WBCAD,WBCAE,WBCDE);

	NR2 SUBF1(WBDAC,WBD,WAC);
	NR2 SUBF2(WBDAE,WBD,WAE);
	NR2 SUBF3(WBDCE,WBD,WCE);
	NR3 O6(W6,WBDAC,WBDAE,WBDCE);

	NR2 SUBG1(WBEAC,WBE,WAC);
	NR2 SUBG2(WBEAD,WBE,WAD);
	NR2 SUBG3(WBECD,WBE,WCD);
	NR3 O7(W7,WBEAC,WBEAD,WBECD);

	NR2 SUBH1(WCDAB,WCD,WAB);
	NR2 SUBH2(WCDAE,WCD,WAE);
	NR2 SUBH3(WCDBE,WCD,WBE);
	NR3 O8(W8,WCDAB,WCDAE,WCDBE);

	NR2 SUBI1(WCEAB,WCE,WAB);
	NR2 SUBI2(WCEAD,WCE,WAD);
	NR2 SUBI3(WCEBD,WCE,WBD);
	NR3 O9(W9,WCEAB,WCEAD,WCEBD);

	NR2 SUBJ1(WDEAB,WDE,WAB);
	NR2 SUBJ2(WDEAC,WDE,WAC);
	NR2 SUBJ3(WDEBC,WDE,WBC);
	NR3 O10(W10,WDEAB,WDEAC,WDEBC);

	ND10 ANS(Z,W1,W2,W3,W4,W5,W6,W7,W8,W9,W10);

endmodule

// inverted three of a kind
module threesameinv(Z,A,B,C);

	input [5:0] A,B,C;
	output Z;
	wire W0,W1,W2,W3;
	
	EQ3 SUB0(W0,A[0],B[0],C[0]);
	EQ3 SUB1(W1,A[1],B[1],C[1]);
	EQ3 SUB2(W2,A[2],B[2],C[2]);
	EQ3 SUB3(W3,A[3],B[3],C[3]);
	ND4 SUB4(Z,W0,W1,W2,W3);

endmodule

// full house
module fullhouse(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire WAB,WAC,WAD,WAE,WBC,WBD,WBE,WCD,WCE,WDE;
	wire WABC,WABD,WABE,WACD,WACE,WADE,WBCD,WBCE,WBDE,WCDE;
	wire W1,W2,W3,W4,W5,W6,W7,W8,W9,W10;
	
	onepairinv SUBA1(WAB,A,B);
	onepairinv SUBA2(WAC,A,C);
	onepairinv SUBA3(WAD,A,D);
	onepairinv SUBA4(WAE,A,E);
	onepairinv SUBA5(WBC,B,C);
	onepairinv SUBA6(WBD,B,D);
	onepairinv SUBA7(WBE,B,E);
	onepairinv SUBA8(WCD,C,D);
	onepairinv SUBA9(WCE,C,E);
	onepairinv SUBA10(WDE,D,E);

	threesameinv SUBB1(WABC,A,B,C);
	threesameinv SUBB2(WABD,A,B,D);
	threesameinv SUBB3(WABE,A,B,E);
	threesameinv SUBB4(WACD,A,C,D);
	threesameinv SUBB5(WACE,A,C,E);
	threesameinv SUBB6(WADE,A,D,E);
	threesameinv SUBB7(WBCD,B,C,D);
	threesameinv SUBB8(WBCE,B,C,E);
	threesameinv SUBB9(WBDE,B,D,E);
	threesameinv SUBB10(WCDE,C,D,E);

	OR2 O1(W1,WABC,WDE);
	OR2 O2(W2,WABD,WCE);
	OR2 O3(W3,WABE,WCD);
	OR2 O4(W4,WACD,WBE);
	OR2 O5(W5,WACE,WBD);
	OR2 O6(W6,WADE,WBC);
	OR2 O7(W7,WBCD,WAE);
	OR2 O8(W8,WBCE,WAD);
	OR2 O9(W9,WBDE,WAC);
	OR2 O10(W10,WCDE,WAB);
	
	ND10 ANS(Z,W1,W2,W3,W4,W5,W6,W7,W8,W9,W10);

endmodule

// inverted four of a kind
module foursameinv(Z,A,B,C,D);

	input [5:0] A,B,C,D;
	output Z;
	wire W0,W1,W2,W3;

	EQ4 SUB0(W0,A[0],B[0],C[0],D[0]);
	EQ4 SUB1(W1,A[1],B[1],C[1],D[1]);
	EQ4 SUB2(W2,A[2],B[2],C[2],D[2]);
	EQ4 SUB3(W3,A[3],B[3],C[3],D[3]);
	ND4 SUB4(Z,W0,W1,W2,W3);

endmodule

// flush
module flush(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W4,W5;

	EQ5 SUB4(W4,A[4],B[4],C[4],D[4],E[4]);
	EQ5 SUB5(W5,A[5],B[5],C[5],D[5],E[5]);
	AN2 ANS(Z,W4,W5);

endmodule

// number 1 to 13 exist?
module exist1(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR3 SUBA1(W1,A[1],A[2],A[3]);
	ND2 SUBA2(WA,W1,A[0]);
	NR3 SUBB1(W2,B[1],B[2],B[3]);
	ND2 SUBB2(WB,W2,B[0]);
	NR3 SUBC1(W3,C[1],C[2],C[3]);
	ND2 SUBC2(WC,W3,C[0]);
	NR3 SUBD1(W4,D[1],D[2],D[3]);
	ND2 SUBD2(WD,W4,D[0]);
	NR3 SUBE1(W5,E[1],E[2],E[3]);
	ND2 SUBE2(WE,W5,E[0]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist2(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR3 SUBA1(W1,A[0],A[2],A[3]);
	ND2 SUBA2(WA,W1,A[1]);
	NR3 SUBB1(W2,B[0],B[2],B[3]);
	ND2 SUBB2(WB,W2,B[1]);
	NR3 SUBC1(W3,C[0],C[2],C[3]);
	ND2 SUBC2(WC,W3,C[1]);
	NR3 SUBD1(W4,D[0],D[2],D[3]);
	ND2 SUBD2(WD,W4,D[1]);
	NR3 SUBE1(W5,E[0],E[2],E[3]);
	ND2 SUBE2(WE,W5,E[1]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist3(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR2 SUBA1(W1,A[2],A[3]);
	ND3 SUBA2(WA,W1,A[0],A[1]);
	NR2 SUBB1(W2,B[2],B[3]);
	ND3 SUBB2(WB,W2,B[0],B[1]);
	NR2 SUBC1(W3,C[2],C[3]);
	ND3 SUBC2(WC,W3,C[0],C[1]);
	NR2 SUBD1(W4,D[2],D[3]);
	ND3 SUBD2(WD,W4,D[0],D[1]);
	NR2 SUBE1(W5,E[2],E[3]);
	ND3 SUBE2(WE,W5,E[0],E[1]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist4(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR3 SUBA1(W1,A[1],A[0],A[3]);
	ND2 SUBA2(WA,W1,A[2]);
	NR3 SUBB1(W2,B[1],B[0],B[3]);
	ND2 SUBB2(WB,W2,B[2]);
	NR3 SUBC1(W3,C[1],C[0],C[3]);
	ND2 SUBC2(WC,W3,C[2]);
	NR3 SUBD1(W4,D[1],D[0],D[3]);
	ND2 SUBD2(WD,W4,D[2]);
	NR3 SUBE1(W5,E[1],E[0],E[3]);
	ND2 SUBE2(WE,W5,E[2]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist5(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR2 SUBA1(W1,A[1],A[3]);
	ND3 SUBA2(WA,W1,A[0],A[2]);
	NR2 SUBB1(W2,B[1],B[3]);
	ND3 SUBB2(WB,W2,B[0],B[2]);
	NR2 SUBC1(W3,C[1],C[3]);
	ND3 SUBC2(WC,W3,C[0],C[2]);
	NR2 SUBD1(W4,D[1],D[3]);
	ND3 SUBD2(WD,W4,D[0],D[2]);
	NR2 SUBE1(W5,E[1],E[3]);
	ND3 SUBE2(WE,W5,E[0],E[2]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist6(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR2 SUBA1(W1,A[0],A[3]);
	ND3 SUBA2(WA,W1,A[2],A[1]);
	NR2 SUBB1(W2,B[0],B[3]);
	ND3 SUBB2(WB,W2,B[2],B[1]);
	NR2 SUBC1(W3,C[0],C[3]);
	ND3 SUBC2(WC,W3,C[2],C[1]);
	NR2 SUBD1(W4,D[0],D[3]);
	ND3 SUBD2(WD,W4,D[2],D[1]);
	NR2 SUBE1(W5,E[0],E[3]);
	ND3 SUBE2(WE,W5,E[2],E[1]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist7(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	IV  SUBA1(W1,A[3]);
	ND4 SUBA2(WA,W1,A[0],A[1],A[2]);
	IV  SUBB1(W2,B[3]);
	ND4 SUBB2(WB,W2,B[0],B[1],B[2]);
	IV  SUBC1(W3,C[3]);
	ND4 SUBC2(WC,W3,C[0],C[1],C[2]);
	IV  SUBD1(W4,D[3]);
	ND4 SUBD2(WD,W4,D[0],D[1],D[2]);
	IV  SUBE1(W5,E[3]);
	ND4 SUBE2(WE,W5,E[0],E[1],E[2]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist8(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR3 SUBA1(W1,A[1],A[2],A[0]);
	ND2 SUBA2(WA,W1,A[3]);
	NR3 SUBB1(W2,B[1],B[2],B[0]);
	ND2 SUBB2(WB,W2,B[3]);
	NR3 SUBC1(W3,C[1],C[2],C[0]);
	ND2 SUBC2(WC,W3,C[3]);
	NR3 SUBD1(W4,D[1],D[2],D[0]);
	ND2 SUBD2(WD,W4,D[3]);
	NR3 SUBE1(W5,E[1],E[2],E[0]);
	ND2 SUBE2(WE,W5,E[3]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist9(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR2 SUBA1(W1,A[2],A[1]);
	ND3 SUBA2(WA,W1,A[0],A[3]);
	NR2 SUBB1(W2,B[2],B[1]);
	ND3 SUBB2(WB,W2,B[0],B[3]);
	NR2 SUBC1(W3,C[2],C[1]);
	ND3 SUBC2(WC,W3,C[0],C[3]);
	NR2 SUBD1(W4,D[2],D[1]);
	ND3 SUBD2(WD,W4,D[0],D[3]);
	NR2 SUBE1(W5,E[2],E[1]);
	ND3 SUBE2(WE,W5,E[0],E[3]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist10(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR2 SUBA1(W1,A[2],A[0]);
	ND3 SUBA2(WA,W1,A[1],A[3]);
	NR2 SUBB1(W2,B[2],B[0]);
	ND3 SUBB2(WB,W2,B[1],B[3]);
	NR2 SUBC1(W3,C[2],C[0]);
	ND3 SUBC2(WC,W3,C[1],C[3]);
	NR2 SUBD1(W4,D[2],D[0]);
	ND3 SUBD2(WD,W4,D[1],D[3]);
	NR2 SUBE1(W5,E[2],E[0]);
	ND3 SUBE2(WE,W5,E[1],E[3]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist11(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	IV  SUBA1(W1,A[2]);
	ND4 SUBA2(WA,W1,A[0],A[1],A[3]);
	IV  SUBB1(W2,B[2]);
	ND4 SUBB2(WB,W2,B[0],B[1],B[3]);
	IV  SUBC1(W3,C[2]);
	ND4 SUBC2(WC,W3,C[0],C[1],C[3]);
	IV  SUBD1(W4,D[2]);
	ND4 SUBD2(WD,W4,D[0],D[1],D[3]);
	IV  SUBE1(W5,E[2]);
	ND4 SUBE2(WE,W5,E[0],E[1],E[3]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist12(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	NR2 SUBA1(W1,A[0],A[1]);
	ND3 SUBA2(WA,W1,A[2],A[3]);
	NR2 SUBB1(W2,B[0],B[1]);
	ND3 SUBB2(WB,W2,B[2],B[3]);
	NR2 SUBC1(W3,C[0],C[1]);
	ND3 SUBC2(WC,W3,C[2],C[3]);
	NR2 SUBD1(W4,D[0],D[1]);
	ND3 SUBD2(WD,W4,D[2],D[3]);
	NR2 SUBE1(W5,E[0],E[1]);
	ND3 SUBE2(WE,W5,E[2],E[3]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule

module exist13(Z,A,B,C,D,E);

	input [5:0] A,B,C,D,E;
	output Z;
	wire W1,W2,W3,W4,W5;
	wire WA,WB,WC,WD,WE;
	
	IV  SUBA1(W1,A[1]);
	ND4 SUBA2(WA,W1,A[0],A[3],A[2]);
	IV  SUBB1(W2,B[1]);
	ND4 SUBB2(WB,W2,B[0],B[3],B[2]);
	IV  SUBC1(W3,C[1]);
	ND4 SUBC2(WC,W3,C[0],C[3],C[2]);
	IV  SUBD1(W4,D[1]);
	ND4 SUBD2(WD,W4,D[0],D[3],D[2]);
	IV  SUBE1(W5,E[1]);
	ND4 SUBE2(WE,W5,E[0],E[3],E[2]);
	ND5 ANS(Z,WA,WB,WC,WD,WE);

endmodule


// gates needed
module AN5(Z,A,B,C,D,E);

	input A,B,C,D,E;
	output Z;
	wire W1,W2;

	AN2 SUB1(W1,A,B);
	AN3 SUB2(W2,C,D,E);
	AN2 SUB3(Z,W1,W2);

endmodule

module MYOR4(Z,A,B,C,D);

	input A,B,C,D;
	output Z;
	wire W1;

	NR4 SUB1(W1,A,B,C,D);
	IV  SUB2(Z,W1);

endmodule

module OR10(Z,A,B,C,D,E,F,G,H,I,J);

	input A,B,C,D,E,F,G,H,I,J;
	output Z;
	wire W1,W2,W3;
	
	OR3 SUB1(W1,A,B,C);
	OR3 SUB2(W2,D,E,F);
	OR3 SUB3(W3,G,H,I);
	MYOR4 SUB4(Z,W1,W2,W3,J);

endmodule

module ND5(Z,A,B,C,D,E);

	input A,B,C,D,E;
	output Z;
	wire W1,W2;

	AN2 SUB1(W1,A,B);
	AN3 SUB2(W2,C,D,E);
	ND2 SUB3(Z,W1,W2);

endmodule

module ND10(Z,A,B,C,D,E,F,G,H,I,J);

	input A,B,C,D,E,F,G,H,I,J;
	output Z;
	wire W1,W2,W3;

	AN3 SUB1(W1,B,C,D);
	AN3 SUB2(W2,E,F,G);
	AN3 SUB3(W3,H,I,J);
	ND4 SUB4(Z,A,W1,W2,W3);

endmodule

module NR5(Z,A,B,C,D,E);

	input A,B,C,D,E;
	output Z;
	wire W1,W2;

	NR4 SUB1(W1,A,B,C,D);
	NR2 SUB2(W2,A,E);
	AN2 SUB3(Z,W1,W2);

endmodule

//equivalance gate
module EQ2(Z,A,B);

	input A,B;
	output Z;
	wire W1;

	EO SUB1(W1,A,B);
	IV SUB2(Z,W1);

endmodule

module EQ3(Z,A,B,C);

	input A,B,C;
	output Z;
	wire W1,W2;

	AN3 SUB1(W1,A,B,C);
	NR3 SUB2(W2,A,B,C);
	OR2 SUB3(Z,W1,W2);

endmodule

module EQ4(Z,A,B,C,D);

	input A,B,C,D;
	output Z;
	wire W1,W2;

	AN4 SUB1(W1,A,B,C,D);
	NR4 SUB2(W2,A,B,C,D);
	OR2 SUB3(Z,W1,W2);

endmodule

module EQ5(Z,A,B,C,D,E);

	input A,B,C,D,E;
	output Z;
	wire W1,W2;

	AN5 SUB1(W1,A,B,C,D,E);
	NR5 SUB2(W2,A,B,C,D,E);
	OR2 SUB3(Z,W1,W2);

endmodule
