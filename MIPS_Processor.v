module mips();
	
	
    reg clk;	
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
	wire [31:0] rd;
	wire [31:0] data;
	integer cur_time;
	integer count;
	integer i;
	
	
	pc pc1(pc,pcplus4,clk,Branch,Jump,zero,instruction,ReadData1,Jr);
	IM #400 im1(pc,clk,instruction,count);
	control_unit #80 c1(RegDst,Branch,Jump,ALUSrc,ALUOp,MemToReg,RegWrite,MemWrite,MemRead,instruction[31:26]);	
	mux3x2 #30 m1(mux1_out,RegDst,instruction[20:16],instruction[15:11],31);
	Register_File r1(instruction[25:21],instruction[20:16],mux1_out,mux3_out,clk,RfWrite,ReadData1,ReadData2,rd); //Delay is inside the module
	ALU_control ac1(operation,Jr,instruction[5:0],ALUOp);
	sign_ext sx1(sign_ext_out,instruction[15:0]);
	mux2x1 #30 m2(ALUSrc,ReadData2,sign_ext_out,mux2_out);	
	ALU #100 a1(result,zero,ReadData1,mux2_out,operation,instruction[10:6]);
	DM #300 dm1(data_read,data,ReadData2, clk, MemWrite,result,MemRead);
	mux3x2 #30 m3(mux3_out,MemToReg,result,data_read,pcplus4); 
	and(RfWrite,RegWrite,~Jr);
	

	always #600 clk=~clk;
	always @(posedge clk) cur_time=$realtime; 
	
	initial begin 
		clk=0;	
	  $monitor($time," instr=%h     pc=%h   rs=%h   rt=%h   rd=%h  MemWrite=%h  DM_Write=%h Alu-rslt~DM_adrss=%h",instruction,pc,ReadData1,ReadData2,rd,MemWrite,ReadData2,result) ;
	  #19900 
	  for (i=0;i<=32;i++)begin
	  $display("%h",r1.Registers[i]);
	  end  
	  $finish; 
	  
	end 
	
	
endmodule	