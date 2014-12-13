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
module DM (data_write, clk, mem_write,address,data_read);
	input clk ;
	input mem_write;	     // the memory write signal
	input [31:0] address ;
	input [31:0] data_write ;
	output data_read ;
	reg[31:0] data_read;
	reg[31:0] my_DM [0:1023];// Assigning data memory as of depth 1024 addresses , each of 32 bit wide
	
	// In the Initial block, the program file to be executed is read into the data memory
	initial 
		begin
			$memreadh("test.txt",my_DM);	// the file is written in hexadecimal form 
		end	  
		
	/* In the always block,at the clock edge it's checked whether the memory write signal
	is active or not */
	always @ (posedge clk)
		begin
			if (mem_write = = 1)
				begin
					my_DM [address] = data_write ;
				end	 				
				
	/* In this always block, if the write signal is inactive then value from the 
		memory address is read to be wriiten in the destination register in the register file*/
	always @ (my_DM[address])
		begin
			data_read = my_DM[address];
		end
		
endmodule
			
		   