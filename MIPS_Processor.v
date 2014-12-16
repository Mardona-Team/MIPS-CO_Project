module mips();
	
	
	wire clk;	
	wire [31:0] pc ;
	wire [31:0] pcplus4;
	wire [31:0] instruction;	
	wire Branch,Jump,RegWrite,MemWrite,MemRead,ALUSrc; 
	wire [1:0] RegDst;
	wire [2:0]ALUOp;
	wire [1:0]MemToReg;
	wire [4:0]mux1_out;
	wire [31:0] mux2_out;
	wire [31:0] mux3_out;
	wire [31:0]ReadData1;
	wire [31:0]ReadData2; 
	wire [3:0]operation;
	wire  Jr;
	wire  [31:0] sign_ext_out;
	wire  [31:0]result;
	wire  zero ;
	wire [31:0] data_read;
	wire RfWrite;
	reg [4:0] ra=31;
	
	pc pc1(pc,pcplus4,clk,Branch,Jump,zero,instruction,ReadData1,Jr);
	IM im1(pc,clk,instruction);
	control_unit c1(RegDst,Branch,Jump,ALUSrc,ALUOp,MemToReg,RegWrite,MemWrite,MemRead,instruction[31:26]);	
	mux3x2 m1(mux1_out,RegDst,instruction[20:16],instruction[15:11],ra);
	Register_File r1(instruction[25:21],instruction[20:16],mux1_out,mux3_out,clk,RfWrite,ReadData1,ReadData2);
	ALU_control ac1(operation,Jr,instruction[5:0],ALUOp);
	sign_ext sx1(sign_ext_out,instruction[15:0]);
	mux2x1 m2(ALUSrc,ReadData2,sign_ext_out,mux2_out);	
	ALU a1(result,zero,ReadData1,mux2_out,operation);
	DM dm1(data_read,ReadData2, clk, MemWrite,result,MemRead);
	mux3x2 m3(mux3_out,MemToReg,result,data_read,pcplus4); 
	and(RfWrite,RegWrite,~Jr);
	

	//assign #5 clk=~clk;
	
	
endmodule	