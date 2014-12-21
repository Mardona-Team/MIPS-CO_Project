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
		
	   if(ALUOp==2'b00)	begin operation <= 4'b0010; Jr=0; end	//lw & sw & addi
	   else if (ALUOp[0]==1) begin operation <= 4'b0110; Jr=0; end  //Beq	
	   else if (ALUOp[2]==1 && ALUOp[0]==1) begin operation<=4'b0001; Jr=0; end //ori
	   else if (ALUOp[2]==1 && ALUOp[0]==0) begin operation<=4'b0000; Jr=0; end //andi	   
       else if (ALUOp[1]==1)begin  
							case(funct)	  //r-formate
								6'b100000: begin operation<=4'b0010; Jr=0; end	//add
								6'b100001: begin operation<=4'b0110; Jr=0; end	//sub
								6'b100100: begin operation<=4'b0000; Jr=0; end //and
								6'b100101: begin operation<=4'b0001; Jr=0; end	//or
							    6'b101010: begin operation<=4'b0111; Jr=0; end//slt 
								6'b000000: begin operation<=4'b0101; Jr=0; end   //sll
								6'b100111: begin operation<=4'b1011; Jr=0; end   //nor
								6'b001000: begin operation<=4'b0010; Jr=1; end //jr
							endcase	
							end
			
	   end			
endmodule 