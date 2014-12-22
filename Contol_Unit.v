//This is the control unit of the single cycle implementation of a MIPS processor , it takes 
// the first 6 bits of the instruction (opcode) as an input and it then provides the control signals to the rest
// of the blocks in the processor [RegDst,Branch,Jump,ALUSrc,ALUOp,MemToReg,RegWrite,MemWrite,MemRead]
//This verilog code takes the opcode and inserts it in a switch case condition , and depending on the value
// value of the opcode it changes the values of the control signals.
// Author: Alaa El-Nouby

module control_unit(RegDst,Branch,Jump,ALUSrc,ALUOp,MemToReg,RegWrite,MemWrite,MemRead,opcode);
	
	input [5:0] opcode;
	output reg Branch,Jump,ALUSrc,RegWrite,MemWrite,MemRead;
	output reg [2:0] ALUOp ;
	output reg [1:0] MemToReg;
	output reg [1:0] RegDst;
	
	parameter dummy=0,r_format=6'b000000,beq=6'b000100,addi=6'b001000,andi=6'b001100
	         ,ori=6'b001101,jal=6'b000011,lw=6'b100011,sw=6'b101011 ;
	
	
	always @(opcode) begin 
	 
		case(opcode) 
		
		  lw: begin
		      RegDst <=2'b00;ALUSrc <=1;MemToReg <=2'b01;RegWrite <=1;MemRead <=1;MemWrite <=0;Branch <=0;ALUOp <=2'b00;Jump <=0;
		      end
		    
		  sw: begin
		      RegDst<=2'bxx;ALUSrc<=1;MemToReg<=2'bxx;RegWrite<=0;MemRead<=0;MemWrite<=1;Branch<=0;ALUOp<=2'b00;Jump<=0;
		      end	 
		  
		  r_format: begin
				  	RegDst<=2'b01;ALUSrc<=0;MemToReg<=2'b00;RegWrite<=1;MemRead<=0;MemWrite<=0;Branch<=0;ALUOp<=2'b10;Jump<=0;
		            end
		  
		  beq:begin
			  RegDst<=2'bxx;ALUSrc<=0;MemToReg<=2'bxx;RegWrite<=0;MemRead<=0;MemWrite<=0;Branch<=1;ALUOp<=2'b01;Jump<=0;
		      end
		  
	      addi: begin
			    RegDst<=2'b00;ALUSrc<=1;MemToReg<=2'b00;RegWrite<=1;MemRead<=0;MemWrite<=0;Branch<=0;ALUOp<=2'b00;Jump<=0;
		        end
		  
		  andi:	begin
			    RegDst<=2'b00;ALUSrc<=1;MemToReg<=2'b00;RegWrite<=1;MemRead<=0;MemWrite<=0;Branch<=0;ALUOp<=3'b100;Jump<=0;
		        end
		  
		 ori: begin
			   RegDst<=2'b00;ALUSrc<=1;MemToReg<=2'b00;RegWrite<=1;MemRead<=0;MemWrite<=0;Branch<=0;ALUOp<=3'b101;Jump<=0;
		      end 
		 
		  jal: begin
			   RegDst<=2'b10;ALUSrc<=1'bx;MemToReg<=2'b10;RegWrite<=1;MemRead<=0;MemWrite<=0;Branch<=1'bx;ALUOp<=2'bxx;Jump<=1;
		       end
		
		endcase	
	
	end	
	
endmodule