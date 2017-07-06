`timescale 1ns/1ps

`define LEN_OF_SIM		400us

`define		ADDRBITS		4
`define		DATABITS		6
`define		MODEBITS		4
`define		CHANNELS		16

module verilog_driver_tb;
	// Need to create a VCD (Value Change Dump) file

	initial begin
		$dumpfile("/home/CFD/cds/CFDtest/vcd/verilog_driver.vcd") ;
		$dumpvars(1, AVDD, AGND, AVSS, SVSS, DVDD3, SI, STB, SI_CLK, SO_CLK,
				  ADDR0, ADDR1, ADDR2, ADDR3, DATA0, DATA1, DATA2, DATA3, DATA4,
				  DATA5, MODE0, MODE1, MODE2, MODE3, PEAK0, PEAK1, PEAK2, PEAK3, 
				  PEAK4, PEAK5, PEAK6, PEAK7, PEAK8, PEAK9, PEAK10, PEAK11, 
				  PEAK12, PEAK13, PEAK14, PEAK15, TRIG0, TRIG1, TRIG2, TRIG3, 
				  TRIG4, TRIG5, TRIG6, TRIG7, TRIG8, TRIG9, TRIG10, TRIG11, 
				  TRIG12, TRIG13, TRIG14, TRIG15) ;
	end

	real AVDD, AGND, AVSS, SVSS, DVDD3;
	wire SI, STB, SI_CLK, SO_CLK;
	wire[`ADDRBITS-1:0] ADDR;
	wire[`DATABITS-1:0] DATA;
	wire[`MODEBITS-1:0] MODE;
	real PEAK[`CHANNELS-1:0];
	wire[`CHANNELS-1:0] TRIG;

	wire ADDR0, ADDR1, ADDR2, ADDR3;
	wire DATA0, DATA1, DATA2, DATA3, DATA4, DATA5;
	wire MODE0, MODE1, MODE2, MODE3;
	real PEAK0, PEAK1, PEAK2, PEAK3, PEAK4, PEAK5, PEAK6, PEAK7;
	real PEAK8, PEAK9, PEAK10, PEAK11, PEAK12, PEAK13, PEAK14, PEAK15;
	wire TRIG0, TRIG1, TRIG2, TRIG3, TRIG4, TRIG5, TRIG6, TRIG7;
	wire TRIG8, TRIG9, TRIG10, TRIG11, TRIG12, TRIG13, TRIG14, TRIG15;
	
	verilog_driver dut( 	    .AVDD(AVDD),
				    .AGND(AGND),
				    .AVSS(AVSS),
					.SVSS(SVSS),
					.DVDD3(DVDD3),
					.ADDR(ADDR),
					.DATA(DATA),
					.MODE(MODE),
					.PEAK(PEAK),
					.TRIG(TRIG),
					.STB(STB),
					.SI(SI),
					.SI_CLK(SI_CLK),
					.SO_CLK(SO_CLK) );
	
	assign ADDR0 = ADDR[0];
	assign ADDR1 = ADDR[1];
	assign ADDR2 = ADDR[2];
	assign ADDR3 = ADDR[3];

	assign DATA0 = DATA[0];
	assign DATA1 = DATA[1];
	assign DATA2 = DATA[2];
	assign DATA3 = DATA[3];
	assign DATA4 = DATA[4];
	assign DATA5 = DATA[5];
	
	assign MODE0 = MODE[0];
	assign MODE1 = MODE[1];
	assign MODE2 = MODE[2];
	assign MODE3 = MODE[3];

	assign TRIG0 = TRIG[0];
	assign TRIG1 = TRIG[1];
	assign TRIG2 = TRIG[2];
	assign TRIG3 = TRIG[3];
	assign TRIG4 = TRIG[4];
	assign TRIG5 = TRIG[5];
	assign TRIG6 = TRIG[6];
	assign TRIG7 = TRIG[7];
	assign TRIG8 = TRIG[8];
	assign TRIG9 = TRIG[9];
	assign TRIG10 = TRIG[10];
	assign TRIG11 = TRIG[11];
	assign TRIG12 = TRIG[12];
	assign TRIG13 = TRIG[13];
	assign TRIG14 = TRIG[14];
	assign TRIG15 = TRIG[15];

	assign PEAK0 = PEAK[0];
	assign PEAK1 = PEAK[1];
	assign PEAK2 = PEAK[2];
	assign PEAK3 = PEAK[3];
	assign PEAK4 = PEAK[4];
	assign PEAK5 = PEAK[5];
	assign PEAK6 = PEAK[6];
	assign PEAK7 = PEAK[7];
	assign PEAK8 = PEAK[8];
	assign PEAK9 = PEAK[9];
	assign PEAK10 = PEAK[10];
	assign PEAK11 = PEAK[11];
	assign PEAK12 = PEAK[12];
	assign PEAK13 = PEAK[13];
	assign PEAK14 = PEAK[14];
	assign PEAK15 = PEAK[15];

	// Run simulation for a bit and then finish
	initial begin
		 	# (`LEN_OF_SIM)		$finish ;
	end
endmodule
