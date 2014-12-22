//-----------------------------------------------------------------------------
//
// Title       : PC
// Design      : MIPS single cycle implementation
// Author      : Ahmed Anwer
// Program counter
//-----------------------------------------------------------------------------

module pc (pc,pcplus4,clock,branch_control,jump_control,alu_zero_control,instruction,ReadData1,Jr);  
		
	input clock;	
	input  branch_control;
	input  alu_zero_control;
	input  jump_control;
	input [31:0] instruction;
	input [31:0] ReadData1 ;
	input Jr;
	output[31:0] pc; 
	output reg[31:0]  pcplus4;
	reg[31:0] pc; 
	

 //internal wires 
 wire[31:0]  badder; // final branch adress
 wire[31:0]  mux1;
 wire[31:0]  mux2;
 wire[31:0]  mux3;
 wire[31:0] newpc;
 wire [31:0]  branchsignextend;
 wire[15:0] braddres; 
 
 
 assign braddres = instruction[15:0];	// adress of the branching in 15 :0
 assign branchsignextend ={{16{braddres[15]}},braddres[15:0]} ;		// ssign extend


initial
	begin
		   pc=0;			
	end
 // code start here  
 
 
  always @(posedge clock) 
	begin	 
       pcplus4 =pc+4 ;
	   
 	end
 	
	 
 
 branchadder branchadder1(pcplus4  ,branchsignextend , badder);	   // badder   = (pc+4) + shift left 2 branch branchsignextend
 
 // now badder have final value of adress to be branched and pcplus4 have final value of pc+4
 //to support jump we will :
 
 wire [28:0] jumpAdd;
 assign jumpAdd = ( instruction[25:0]<<2 );  // now it is 28 bit
 wire[31:0] jumpFinaladd;
 assign	   jumpFinaladd={pcplus4[31:28],jumpAdd}  ;	  
 
 
 
 // now jumpFinaladd have final jump adress , we need 2 muxes
 
 //muxx 1
 //selection line will be
 and(s1,branch_control, alu_zero_control); 
 mux2x1 m1(s1,pcplus4,badder,mux1);	 
 mux2x1 m2(jump_control,mux1,jumpFinaladd,mux2);
 mux2x1 m3(Jr,mux2,ReadData1,mux3);
 
 
 assign newpc=mux3;
 always @(newpc) pc = newpc;
 
  
		 
  
 
 
endmodule



module branchadder (pcplus4,branchsignextend,PCbranch) ;
	input  [31:0] pcplus4; 
	input  [31:0] branchsignextend;	 
	
	output [31:0] 	 PCbranch;
	reg[31:0]  PCbranch ;		
	
	always @( pcplus4 or  branchsignextend)
		begin
  PCbranch <= pcplus4+$signed((branchsignextend<<2));	 //pc +4 plus branch shift left by 2 
		 end
	endmodule		
	
	
