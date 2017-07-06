//Verilog HDL for "HinpLib_3_test", "load_config_reg_HINP4" "functional"

`timescale 100ns/10ns

`define T_LOAD_CONFIG_REG      3000

module load_config_reg_HINP4 (sinp, sclk);
	output sinp;
	output sclk;

	reg [47:0] config_reg;
	reg sinp;
	reg sclk;

	integer i;

	initial begin
		sclk = 1'b0;
		sinp = 1'b0;

		// To enable all CFDs place 0s
		config_reg = 30'b00000000_00000000_00000000_000000;
                 
		// Bit 30 is testmode_peak	(1 => High gain peak sample brought to pin)
		config_reg[30] = 1'b0;	

		// Bit 31 is PULSER_HG		(0 => Pulser in HIGH GAIN mode)
		config_reg[31] = 1'b0;	

		// Bit 32 is HOLES              (0 => Collects HOLES)
		config_reg[32] = 1'b1;          

		// Bit 33 is four_usec_l        (0 => 4 us range selected for TVC)
		config_reg[33] = 1'b0;

		// Bit 34 is testmode_core      (1 => Bring CA core output to pins)
		config_reg[34] = 1'b0;

		// Bit 35 is testmode_CSA       (1 => test mode selected)
		config_reg[35] = 1'b0;

		// Bit 36 is use_even_pulser    (1 => Pulse even channels)
		config_reg[36] = 1'b0;

		// Bit 37 is testmode_peak      (1 => Peak sampler should be driven by external signal)
		config_reg[37] = 1'b0;

		// Bit 38 is testmode_shaper    (1 => test mode selected)
		config_reg[38] = 1'b0;

		// Bit 39 is use_odd_pulser     (1 => pulse odd channels)
		config_reg[39] = 1'b0;

		// Set chip id
		config_reg[47:40] = 8'b00000000;

		#`T_LOAD_CONFIG_REG
		for (i=47; i>=0; i=i-1) begin
			sinp = config_reg[i];

			#10
			sclk = 1'b1;

			#10
			sclk = 1'b0;
		end
	end
endmodule
