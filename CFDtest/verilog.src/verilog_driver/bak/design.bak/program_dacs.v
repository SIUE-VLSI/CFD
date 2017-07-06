`timescale 100ns/10ns

`define T_PROGRAM_DACS         1950

module program_dacs (sel_ext_addr, dac_stb, dac_data, dac_sgn);
	output sel_ext_addr;		// Select external address
	output dac_stb;			// DAC Strobe
	output [4:0] dac_data;		// DAC Data (Magnitude only) / Channel Address
	output dac_sgn;			// Sign bit of DAC


	reg sel_ext_addr;
	reg dac_stb;
	reg dac_sgn;
	reg [4:0] dac_data_reg;


	parameter dac_sign = 0;  // 0 for electrons
	parameter dac_value = 3;

	integer i;

	assign dac_data = dac_data_reg;

	initial begin
// We don't want external addressing for the time being.  Don't program the DAC now.
		sel_ext_addr = 1'b0;
		dac_stb = 1'b0;
		dac_sgn = 1'b0;
		dac_data_reg = 5'b0_0000;


		// Wait for a specified time and program the DACs
		#`T_PROGRAM_DACS
		for (i=0; i<=15; i=i+1) begin
			// Load the channel address.
			#10                             
			sel_ext_addr = 1'b1;
			dac_data_reg = i;

			// Strobe it into the address latch.
			#10				
			dac_stb = 1'b1;


			// Load the DAC setting.
			#10                             
			dac_sgn = dac_sign;
			dac_data_reg[4:0] = dac_value;

			// Strobe it into the DAC latch.
			#10
			dac_stb = 1'b0;


			// Disable external addressing.
			#10
			sel_ext_addr = 1'b0;
		end
	end

	initial begin
	#2800 sel_ext_addr = 1'b1;	//280us
	      dac_data_reg = 5'b0_0101;
        #2260 sel_ext_addr = 1'b0;      //At 506us where veto_rst goes high sel_ext_addr made low 
	end

endmodule
