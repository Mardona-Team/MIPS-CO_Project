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
		
	   if(ALUOp==2'b00)	 operation <= 4'b0010; 	//lw & sw & addi
	   else if (ALUOp==2'b11)  operation <= 4'b0110;  //Beq	
	   else if (ALUOp[2]==1 && ALUOp[0]==1)  operation<=4'b0001;  //ori
	   else if (ALUOp[2]==1 && ALUOp[0]==0)  operation<=4'b0000;  //andi	   
       else if (ALUOp[1]==1)begin  
							case(funct)	  //r-formate
								6'b100000: operation<=4'b0010;  //add
								6'b100010: operation<=4'b0110;  //sub
								6'b100100: operation<=4'b0000;  //and
								6'b100101: operation<=4'b0001;  //or
							    6'b101010: operation<=4'b0111; //slt 
								6'b000000: operation<=4'b0101; //sll
								6'b100111: operation<=4'b1011;  //nor
								6'b001000: operation<=4'b0010;  //jr
							endcase	
							end
		if (ALUOp[1]==1 && funct==6'b001000) Jr=1;
			else Jr=0;
			
	   end			
endmodule 