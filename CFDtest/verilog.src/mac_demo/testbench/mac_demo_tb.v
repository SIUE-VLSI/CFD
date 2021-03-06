//
// Testbench for multiply-accumulate cell
//

`define  PERIOD    	50
`define  WIDTH       	16

module mac_demo_tb ;

   reg    clk ;
   reg    reset ;
   reg    ena ;

   reg    [`WIDTH-1 : 0] k ;
   reg    [`WIDTH-1 : 0] x ;
   wire   [2 * `WIDTH-1 : 0] acc_out ;


// Instantiate mac

   mac_demo dut(.clk(clk),
           .reset(reset),
           .ena(ena),
           .k(k),
           .x(x),
           .acc_out(acc_out)
           ) ;

// Generate clock

   initial begin
      clk = 0 ;
      forever # (`PERIOD/2)  clk = ~clk ;
   end

// Generate reset

   initial begin
       ena = 0 ;
       reset = 0 ;
      # (4 * `PERIOD/2) reset = 1 ;
      # (10 * `PERIOD) reset = 0 ; 
       ena = 1 ;
   end
 
// Apply test vectors
   
   initial begin
      k = 5 ;
      x = 1 ;
      # (100 * `PERIOD) $finish ;
   end

endmodule

      
