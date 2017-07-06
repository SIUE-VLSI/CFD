//
// Testbench for HINP4 verilog driver
//

`timescale  100ns/10ns

// Some defines

`define		T_READOUT	3060	
`define		LEN_OF_SIM	10000

// Here is the testbench

module verilog_driver_tb ;

// Need to create a VCD (Value Change Dump) file

initial begin
    $dumpfile("/local_home/gle/cds/HINPtest/vcd/verilog_driver.vcd") ;
    $dumpvars(1) ;
end

// Wires for all of the outputs

wire	sel_ext_addr ;
wire	dac_stb ;
wire	dac4, dac3, dac2, dac1, dac0 ;
wire	id7, id6, id5, id4, id3, id2, id1, id0 ;
wire	dig_rst ;
wire	veto_rst ;
wire	force_rst ;
wire	global_cfd_en ;
wire	common_stop ;
wire	acq_all ;
wire	acq_clk ;
wire	token_into_chip ;
wire	hit_transfer ;
wire	hit_sclk ;
wire	hit_sin ;
wire	sclk ;
wire	sinp ;
wire	external_shaper ;
wire    dac_sgn;

// Instantiate the verilog driver module

verilog_driver  dut  	(.acq_all(acq_all),
			.acq_clk(acq_clk),
			.global_cfd_en(global_cfd_en),
			.common_stop(common_stop),
			.force_rst(force_rst),
			.force_track(force_track),
			.hit_sclk(hit_sclk),
			.hit_sin(hit_sin),
			.id_in({id7,id6,id5,id4,id3,id2,id1,id0}),
			.dig_rst(dig_rst),
			.sclk(sclk),
			.sinp(sinp),
			.token_into_chip(token_into_chip),
			.veto_rst(veto_rst),
			.sel_ext_addr(sel_ext_addr),
			.dac_stb(dac_stb),
			.dac_data({dac4,dac3,dac2,dac1,dac0}),
			.hit_transfer(hit_transfer),
			.external_shaper(external_shaper),
			.dac_sgn(dac_sgn)		
			) ;

// Run simulation for a bit and then finish

initial begin
     	# (`LEN_OF_SIM)		$finish ;
end

endmodule
