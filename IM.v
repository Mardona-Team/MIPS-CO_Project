/* Instruction Memory  

Inputs : the clock as IM is a state machine and the address to be fetched from the program counter 
outputs : the required instruction read from the program file 

Functionality : it takes the input address from the program counter then 
read the required address from the file in which the program to be executed is written . The output is a 32 bit address instruction. */

module IM (address,clk,data_out);
	input clk ;                 
	input [31:0] address ;     
	output data_out ;        
	reg [31:0] data_out; n
	reg[31:0] my_IM [0:1023]; // assigning the IM with a depth of 1024 addresses , each of 32 bit width. 
	
	
	// In the initial block ,the program file is read in the IM.
	initial
		begin
			$readmemhy("file name.ext",my_IM);	 // the file is written in the hexadecimal form.
		end	
		
		
	// In the always block,on the positive edge of the clock the required address from the file is put into data_out 
	always @(posedge clk )
		begin
			data_out = my_IM[address];
		end	
	endmodule
	