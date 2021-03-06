/* Instruction Memory  

Inputs : the clock as IM is a state machine and the address to be fetched from the program counter 
outputs : the required instruction read from the program file 

Functionality : it takes the input address from the program counter then 
read the required address from the file in which the program to be executed is written . The output is a 32 bit address instruction. */

module IM (address,clk,data_out,i);
	input clk ;                 
	input [31:0] address ;     
	output data_out ;        
	reg [31:0] data_out; 
	reg [7:0] my_IM [0:1023]; // assigning the IM with depth to 1024 , 8 bits in width 
	output integer i;
	
	
	// In the initial block ,the program file is read in the IM.
	initial
		begin
			$readmemb("IM.list",my_IM);	 // the file is written in the Binary form.
			i=0;
			while(my_IM[i]!==8'bxxxxxxxx)begin
			 i=i+1;
			end
			i=(i/4);
		end	
		
		
	// In the always block,on the positive edge of the clock the required address from the file is put into data_out 
	always @(posedge clk )
		begin
			data_out = {my_IM[address],my_IM[address+1],my_IM[address+2],my_IM[address+3]};
		end	
	endmodule
	