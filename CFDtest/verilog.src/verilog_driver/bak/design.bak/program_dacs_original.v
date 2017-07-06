`timescale 100ns/10ns

`define T_PROGRAM_DACS         120
`define T_LOAD_CONFIG_REG      300
`define T_READOUT             3060

module program_dacs (sel_ext_addr, dac_stb, dac_data);
	output sel_ext_addr;		// Select external address
	output dac_stb;			// DAC Strobe
	output [5:0] dac_data;		// DAC Data / Channel Address

	reg sel_ext_addr;
	reg dac_stb;
	reg [5:0] dac_data_reg;

	parameter dac_sign = 0;
	parameter dac_value = 30;

	integer i;

	assign dac_data = (sel_ext_addr ? dac_data_reg : 6'bzz_zzzz);

	initial begin
// We don't want external addressing for the time being.  Don't program the DAC now.
		sel_ext_addr = 1'b0;
		dac_stb = 1'b0;
		dac_data_reg = 6'b0_0000;

		// Wait for a specified time and program the DACs
		#`T_PROGRAM_DACS
		for (i=0; i<=15; i=i+1) begin
			// Load the channel address.
			#1
			sel_ext_addr = 1'b1;
			dac_data_reg = i;

			// Strobe it into the address latch.
			#1
			dac_stb = 1'b1;

			// Load the DAC setting.
			#1
			dac_data_reg[5] = dac_sign;
			dac_data_reg[4:0] = dac_value;

			// Strobe it into the DAC latch.
			#1
			dac_stb = 1'b0;

			// Disable external addressing.
			#1
			sel_ext_addr = 1'b0;
		end
	end
endmodule
