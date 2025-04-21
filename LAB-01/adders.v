`ifndef ADDERS
`define ADDERS
`include "gates.v"

// half adder, gate level modeling
module HA(output C, S, input A, B);
	XOR g0(S, A, B);
	AND g1(C, A, B);
endmodule

// full adder, gate level modeling
module FA(output CO, S, input A, B, CI);
	wire c0, s0, c1, s1;
	HA ha0(c0, s0, A, B);
	HA ha1(c1, s1, s0, CI);
	assign S = s1;
	OR or0(CO, c0, c1);
endmodule

// adder without delay, register-transfer level modeling
module adder_rtl(
	output C3,       // carry output
	output[2:0] S,   // sum
	input[2:0] A, B, // operands
	input C0         // carry input
	);
	assign {C3, S} = A+B+C0;
endmodule

//  ripple-carry adder, gate level modeling
//  Do not modify the input/output of module
module rca_gl(
	output C3,       // carry output
	output[2:0] S,   // sum
	input[2:0] A, B, // operands
	input C0         // carry input
	);

	// TODO:: Implement gate-level RCA
	wire c1 , c2;
	FA fa0(c1 , S[0] , A[0] , B[0] , C0);
	FA fa1(c2 , S[1] , A[1] , B[1] , c1);
	FA fa2(C3 , S[2] , A[2] , B[2] , c2);
endmodule

// carry-lookahead adder, gate level modeling
// Do not modify the input/output of module
module cla_gl(
	output C3,       // carry output
	output[2:0] S,   // sum
	input[2:0] A, B, // operands
	input C0         // carry input
	);

	// TODO:: Implement gate-level CLA
	wire[2:0] p , g;
	wire[3:0] c;
	wire[20:0] t;
	assign c[0] = C0;
	
	//g p
	AND and0(g[0] , A[0] , B[0]);
	//XOR xor0(p[0] , A[0] , B[0]);
	assign p[0] = A[0] + B[0];

	AND and1(g[1] , A[1] , B[1]);
	//XOR xor1(p[1] , A[1] , B[1]);
	assign p[1] = A[1] + B[1];

	AND and2(g[2] , A[2] , B[2]);
	//XOR xor2(p[2] , A[2] , B[2]);
	assign p[2] = A[2] + B[2];
	
	//c
	AND and3(t[0] , p[0] , c[0]); 
	OR or0(c[1] , g[0] , t[0]);

	AND4 and40(t[1] , c[0] , p[0] , p[1] , 1'b1);
	AND and4(t[2] , g[0] , p[1]);
	OR4 or40(c[2] , t[1] , t[2] , g[1] , 1'b0);

	AND4 and41(t[3] , c[0] , p[0] , p[1] , p[2]);
	AND4 and42(t[4] , g[0] , p[1] , p[2] , 1'b1);
	AND and5(t[5] , g[1] , p[2]);
	OR4 or41(c[3] , t[3] , t[4] , t[5] , g[2]);

	//s
	XOR xor3(S[0] , p[0] , c[0]);
	XOR xor4(S[1] , p[1] , c[1]);
	XOR xor5(S[2] , p[2] , c[2]);

	assign C3 = c[3];
endmodule

`endif
