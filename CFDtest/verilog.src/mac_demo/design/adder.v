//
// Module to add two numbers together
//


module  adder  #(parameter width = 32)  
		( input   signed [width-1 : 0] a ,
		  input   signed [width-1 : 0] b , 
		  output  signed [width-1 : 0] sum
		) ;

    assign   sum = a + b ;

endmodule
