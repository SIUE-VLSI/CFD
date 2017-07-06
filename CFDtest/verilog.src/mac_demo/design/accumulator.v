//
// Module to implement an accumulator
//


module accumulator #(parameter width = 32) 
	(input    clk,
     	 input    ena,
         input    reset,
         input	  signed [width - 1 : 0] acc_in,
   	 output   reg signed [width - 1 : 0] acc_out
	) ;

   always @(posedge clk) begin
      if (reset)  acc_out <= 0 ;
      else if (ena) acc_out <= acc_in ;
   end

endmodule
