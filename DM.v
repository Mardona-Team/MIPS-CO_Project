/* 		
Data Memory Module	
Inputs:
clock ,as the data memory is a state machine , the memory write signal , the calculated address and the
data to be written

Outputs:
the data to be read from the desitantion address in the program file.

Fuctionality :
it operates on the load and store instructions
In the load instruction , memory read is high(1) and the value is read from address calculated in the ALU then
written in the required register in the register file.
In the store instruction, memory write is high (1) and the value read from the destination register in the ALU 
is written in the required address in the program file through the data memory.
*/
module DM (data_read,data,data_write, clk, mem_write,address,mem_read);
	input clk ;
	input mem_write;// the memory write signal
	input [31:0] address ; 
	input mem_read;
	input [31:0] data_write ;
	output data_read ;
	reg[31:0] data_read;
	reg[7:0] my_DM [0:1023];// Assigning data memory as of depth 1024 addresses , each of 32 bit wide 
	output wire [31:0] data;
	integer i;
	
	// In the Initial block, the program file to be executed is read into the data memory
	initial 
		begin
		$readmemb("DM.list",my_DM);  // the file is written in the Binary form.
		end	  
		
	/* In the always block,at the clock edge it's checked whether the memory write signal
	is active or not */
	always @ (negedge clk)
		begin
			if (mem_write == 1)
				begin
					{my_DM[address],my_DM[address+1],my_DM[address+2],my_DM[address+3]} = data_write ;
		        end	
			end	
	always @ (negedge clk) begin		
			 if(mem_read ==1)
				begin
			       data_read = {my_DM[address],my_DM[address+1],my_DM[address+2],my_DM[address+3]};
			    end
			end	  
			
			
			assign data= {my_DM[address],my_DM[address+1],my_DM[address+2],my_DM[address+3]};
		
endmodule
			
		   