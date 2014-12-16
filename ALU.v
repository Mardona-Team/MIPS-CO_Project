module ALU(result,zero,A,B,ctrl);		  

//input &output declaration 
input A,B,ctrl;
output result,zero;
//ports declaration	
 wire[31:0] A;
 wire[31:0] B;
wire[3:0]ctrl;
reg[31:0]result; 
wire zero;
wire slt;
//code
assign zero=($signed(A)==$signed(B))?1'b1:1'b0;	
assign slt=($signed(A)<$signed(B))?1'b1:1'b0;	

always@(*)begin
	case (ctrl)
		4'b0010:result<=($signed(A)+$signed(B));	   //add,lw,sw,addi
		4'b0110:result<=($signed(A)-$signed(B));	   //sub
		4'b0001:result<=A|B;	                       //or,ori
		4'b0000:result<=A & B;	                      //and,andi
		4'b0111:result<=slt;	                     //slt 			 
		4'b0101:result<=A<<B;                       //sll 
		4'b1011:result<=~(A | B);                 //nor
		
		/*4'b0110:result<={{31{1'b0}}, slt};	//slt
		4'b0111:result<=A & B;  //and
		4'b1000:result<=A & B;  //andi  
		4'b1001:result<=A | B; //or
		4'b1010:result<=A | B;  //ori
	
		  */
	endcase
end
endmodule


	