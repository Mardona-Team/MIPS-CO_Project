module FA( sum,co,address,b);

   input address,b;
   output sum,co;
   
  reg cin;
   
 wire [31:0] sum;
 wire  co;
 wire [31:0] address;
 wire [2:0] b;
 
 
 	
 initial  cin=0;
	 always @ (co)
		 cin = co;
	 
      assign {co,sum} = address + b+ cin;  
	 	  
     endmodule
	 
 
   

	 
   
   
   
 
