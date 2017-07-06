//
// Module to implement a multiplier
//


module multiplier  #(parameter width = 16)
   ( input    signed  [width-1 : 0] multiplicand,
     input    signed  [width-1 : 0] multiplier,   
     output   signed  [2 * width - 1 : 0] product
   ) ;

   assign  product = multiplicand * multiplier ;

endmodule
