//
// Module to implement a multiply-accumulate cell
//

`define  MAC_WID    16

module mac_demo(input    clk, 
           input    reset, 
           input    ena,
   	   input    signed [`MAC_WID-1 : 0] k,
           input    signed [`MAC_WID-1 : 0] x,   
           output   signed [2 * `MAC_WID - 1 : 0] acc_out
          ) ;

           wire     signed [2 * `MAC_WID - 1 : 0] p ;
           wire     signed [2 * `MAC_WID - 1 : 0] acc_in ;

// Instantiate the multiplier

   multiplier  #(.width(`MAC_WID)) mult_0(.multiplicand(k),
                                          .multiplier(x),
                       			  .product(p)
                			  ) ;

// Instantiate the adder

   adder     #(.width(2*`MAC_WID)) add_0(.a(p),
                			 .b(acc_out),
                			 .sum(acc_in)
               				) ;

// Instantiate the accumulator register

   accumulator  #(.width(2*`MAC_WID))  acc_0(.clk(clk),
                   			     .reset(reset),
                   			     .ena(ena),
                   			     .acc_in(acc_in),
                   			     .acc_out(acc_out)
                   			) ;

endmodule
