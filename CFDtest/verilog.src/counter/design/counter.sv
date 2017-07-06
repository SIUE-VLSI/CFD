//
// Verilog code for 3 bit counter
//

module counter(	input  	clk,
		input	reset,
		output 	reg	[3:0] count,
		output  real      num
 	      ) ;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
                    count <= 0 ;
		    num <= 0.0 ;
                 end
		else begin
                    count <= count + 1 ;
                    num <= num + 0.5 ;
                end
	end

endmodule
