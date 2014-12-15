								   //-----------------------------------------------------------------------------
//
// Title       : mux  2/1
// Design      : MIPS single cycle implementation
// Author      : Ahmed Anwer
// MUX 2x1 and 4x1
//-----------------------------------------------------------------------------


module mux2x1 (sl,in1,in2,outpt);
input [31:0] in1,in2;	   
input sl;
output [31:0] outpt;
reg [31:0] outpt;	 
always @(  sl or in1 or in2 )
	case (sl)
	0:outpt= in1;	
	1:outpt= in2;  
	endcase
endmodule


module mux3x2 (out,sl,in1,in2,in3);
input [31:0] in1,in2,in3,in4;	   
input [1:0] sl;
output [31:0] out;
reg [31:0] out;	 
always @(  sl or in1 or in2 or in3  )
	case (sl)
	0:out= in1;	
	1:out= in2; 
	2:out= in3;	
	
	endcase
endmodule