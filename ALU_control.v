// Block: ALU Control Unit
// Inputs: ALUOp (control unit), Funct (Instruction[5:0])
//outputs: operation (ALU input) , Jr (jump register control signal)
//Author: Alaa El-Nouby
//-------------------------------------------------------------------

module ALU_control(operation,Jr,funct,ALUOp);
	
	
	input [2:0] ALUOp;
	input [5:0] funct;
	output reg Jr;
	output reg [3:0] operation;
	
	 always @ (ALUOp or funct) begin  
	   if(ALUOp==2'b00)	operation <= 4'b0010;	//lw & sw & addi
	   else if (ALUOp[0]==1) operation <= 4'b0110;  //Beq	
	   else if (ALUOp[2]==1 && ALUOp[0]==1) operation<=4'b0001; //ori
	   else if (ALUOp[2]==1 && ALUOp[0]==0) operation<=4'b0000; //andi	   
       else if (ALUOp[1]==1)begin  
							case(funct)	  //r-formate
								4'b0000: operation<=4'b0010;	//add
								4'b0010: operation<=4'b0110;	//sub
								4'b0100: operation<=4'b0000; //and
								4'b0101: operation<=4'b0001;	//or
								4'b1010: operation<=4'b0111;	//slt
								4'b1000: begin operation<=4'b0010; Jr=1;end //jr
							endcase	
							end
			
	   end			
endmodule 