//Verilog HDL for "HinpLib_3_test", "MH_verilog_driver" "functional"

`timescale 100ns/10ns

`define T_READOUT             5110

module verilog_driver (acq_all, acq_clk, global_cfd_en, common_stop, force_rst,
    force_track, hit_sclk, hit_sin, id_in, dig_rst, sclk, sinp, token_into_chip,
    veto_rst, sel_ext_addr, dac_stb, dac_data, hit_transfer, external_shaper, dac_sgn);

	output sel_ext_addr;		// Select external address
	output dac_stb;			// DAC strobe
	output [4:0] dac_data;		// DAC data (Magnitude only)
	output [7:0] id_in;		// Chip ID
	output dig_rst;			// Digital reset
	output veto_rst;		// Veto reset
	output force_rst;		// Force reset
	output force_track;		// Force track
	output global_cfd_en;		// CFD global enable
	output common_stop;		// Common stop
	output acq_all;			// Acquisition all
	output acq_clk;			// Acquisition clock
	output token_into_chip;		// Token into chip
	output hit_transfer;		// Shadow register transfer
	output hit_sclk;		// Shadow register serial clock
	output hit_sin;			// Shadow register serial input
	output sclk;			// Configuration register serial clock
	output sinp;			// Configuration register serial input
	output external_shaper;		// External shaper mode
        output dac_sgn;                 // Sign bit to DAC

	reg [7:0] id_in;
	reg dig_rst;
	reg veto_rst;
	reg force_rst;
	reg force_track;
	reg global_cfd_en;
	reg common_stop;
	reg acq_all;
	reg acq_clk;
	reg token_into_chip;
	reg hit_transfer;
	reg hit_sclk;
	reg hit_sin;
	reg external_shaper;



	integer i, j;

	program_dacs InstPD1(.sel_ext_addr(sel_ext_addr), .dac_stb(dac_stb), .dac_data(dac_data), .dac_sgn(dac_sgn));
	load_config_reg_HINP4 InstLCR2(.sinp(sinp), .sclk(sclk));

	initial begin
		   dig_rst = 1'b0;	// Power-on reset
		#1500 dig_rst = 1'b1;   // At 150u
		#250 dig_rst = 1'b0;    
	end

	initial begin
		// Initialize each signal to 0.
		global_cfd_en = 1'b0;		// Disable all CFDs
		id_in = 8'b0000_0000;		// Set chip id to #0
		token_into_chip = 1'b0;		// Make token into chip active
		acq_all = 1'b0;			// Do not assert the acq_all signal
		acq_clk = 1'b0;			// Hold acq_clk low
		veto_rst = 1'b0;		// Do not veto the reset
		common_stop = 1'b0;		// Deassert common stop
		force_rst = 1'b0;		// Deassert force reset
		force_track = 1'b0;		// Deassert force track
		external_shaper = 1'b0;		// Deassert external shaper mode

		// Enable the CFDs
		#3700 force_rst = 1'b1;		// At 370u
		#100 force_rst = 1'b0;          // At 380u 
		#100 global_cfd_en = 1'b1;      // At 390u


//Next two lines is for TVC in 4u sec mode


                #1140 common_stop = 1'b1;       // At 504u
                      global_cfd_en = 1'b0;     // At 504u


/*
//Next two lines if for TVC in 1u sec mode

                #1110 common_stop = 1'b1;       // At 504u
                      global_cfd_en = 1'b0;     // At 504u
*/

                #20   veto_rst = 1'b1;          // At 506u
   
		#500 common_stop = 1'b0;	// At 556u
	end

	initial begin
		// Acquire the results
		#`T_READOUT
		for (i=0; i<=15; i=i+1) begin
			acq_clk = 1'b1;

			#80
			acq_clk = 1'b0;

			#80 ;
		end
	end

	initial begin
		#7690        
		veto_rst = 1'b0;	    // At 633u
	        #50 force_rst = 1'b1;       // At 638u
	        #50 force_rst = 1'b0;       // At 643u
		#50 global_cfd_en = 1'b1;   // At 648u

	end

	initial begin
		hit_sin = 1'b0;
		hit_sclk = 1'b0;
		hit_transfer = 1'b0;

/*		// Read out the shadow register
		#`T_READOUT
		for (j=0; j<=15; j=j+1) begin
			   hit_sclk = 1'b1;
			#1 hit_sclk = 1'b0;
			#1 ;
		end
		
		// Shift in data into the shadow register
		#10
		hit_sin = 1'b1;
		for (j=15; j>=8; j=j-1) begin
			#1 hit_sclk = 1'b1;
			#1 hit_sclk = 1'b0;
		end
		hit_sin = 1'b0;
		for (j=7; j>=0; j=j-1) begin
			#1 hit_sclk = 1'b1;
			#1 hit_sclk = 1'b0;
		end*/
	end
/*
	initial begin
		#`T_READOUT
		#140 hit_transfer = 1'b1;
		#1   hit_transfer = 1'b0;

		#20
		for (i=0; i<=15; i=i+1) begin
			acq_clk = 1'b1;

			#20
			acq_clk = 1'b0;

			#20 ;
		end
	end
*/

endmodule
