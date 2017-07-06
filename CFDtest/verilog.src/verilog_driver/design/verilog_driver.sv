`include "localparams.vh"
	
module verilog_driver(
	output reg [ADDRBITS-1:0] ADDR,
	output reg [DATABITS-1:0] DATA,
	output reg [MODEBITS-1:0] MODE,
	output reg [CHANNELS-1:0] TRIG,
	output reg STB,
	output reg SI_CLK,
	output reg SO_CLK,
	output reg SI,
	output real AGND,
	output real AVDD,
	output real AVSS,
	output real SVSS,
	output real DVDD3,
	output real PEAK[CHANNELS-1:0]
	);

	`include "verilog_driver_tasks.sv"
	
	integer i;
	real level[CHANNELS-1:0];
	real delay[CHANNELS-1:0];

	initial begin
		fork
			/* Initialize the chip */
			init;
		
			/* Apply power (AVDD, AGND, DVDD3) */
			#(POWER) begin
				power_on(POWER);
			end
			#(CONFIG_ALL) begin fork
				set_gmode(1);
				set_prog_cap(4'h7);
				#1.0us	clock_stb(5);
				#1.5us	set_chan_mux(5);
				#2.5us	set_le_dac(0, 6'h2);
				#3.5us  set_cv_dac(0, 2'h1);
				#4.5us  set_tp_mux(0, TP_LE_VTH);
				#5.5us  set_gmode(0);
			join end
		
			#(HIT_ALL) begin
			begin
				/* Trigger the exp pules */
					for(i = 0; i < CHANNELS; i = i + 1) begin
						delay[i] = $urandom_range(90,10)*1ns + $urandom_range(9,0)*100ps;
					end
					
					level[0] = 0.02;
					level[1] = -0.02;
					level[2] = 0.1;
					level[3] = -0.1;
					level[4] = 0.233;
					level[5] = -0.233;
					level[6] = 0.675;
					level[7] = -0.675;
					level[8] = 0.96;
					level[9] = -0.96;
					level[10] = 1.125;
					level[11] = -1.125;
					level[12] = 1.431;
					level[13] = -1.431;
					level[14] = 2;
					level[15] = -2;
					trigger_pulse(level, delay);			
				end
			end

			#(CONFIG_EVEN) begin fork
				set_prog_cap(4'h3);
				#1.0us	clock_stb(26);
				#1.5us	set_chan_mux(0);
					/*	Channel 0	*/
				#2.5us	set_le_dac(0, 6'h0);
				#3.5us	set_cv_dac(0, 2'h0);
				#4.5us	set_tp_mux(0, TP_ZC_OUT);
					/*	Channel 2	*/
				#3.5us	set_le_dac(2, 6'h1);
				#4.5us	set_cv_dac(2, 2'h1);
				#5.5us	set_tp_mux(2, TP_AGND);
					/*	Channel 4	*/
				#6.5us	set_le_dac(4, 6'h4);
				#7.5us	set_cv_dac(4, 2'h2);
				#8.5us	set_tp_mux(4, TP_LE_OUT);
					/*	Channel 6	*/
				#9.5us	set_le_dac(6, 6'h7);
				#10.5us	set_cv_dac(6, 2'h3);
				#11.5us	set_tp_mux(6, TP_ZCP);
					/*	Channel 8	*/
				#12.5us	set_le_dac(8, 6'ha);
				#13.5us	set_cv_dac(8, 2'h0);
				#14.5us	set_tp_mux(8, TP_ZCM);
					/*	Channel 10	*/
				#15.5us	set_le_dac(10, 6'hb);
				#16.5us	set_cv_dac(10, 2'h1);
				#17.5us	set_tp_mux(10, TP_CV_OUT);
					/*	Channel 12	*/
				#18.5us	set_le_dac(12, 6'hc);
				#19.5us	set_cv_dac(12, 2'h2);
				#20.5us	set_tp_mux(12, TP_LE_VTH);
					/*	Channel 14	*/
				#21.5us	set_le_dac(14, 6'hd);
				#22.5us	set_cv_dac(14, 2'h3);
				#23.5us	set_tp_mux(14, TP_LE_NOWLIN);
			join end

			#(HIT_EVEN) begin		
				begin
					/* Trigger the exp pules */
					for(i = 0; i < CHANNELS; i = i + 2) begin
						delay[i] = $urandom_range(90,10)*1ns + $urandom_range(9,0)*100ps;
					end
					
					level[0] = 0.035;
					level[2] = 0.087;
					level[4] = 0.333;
					level[6] = 0.789;
					level[8] = 0.999;
					level[10] = 1.13;
					level[12] = 1.67;
					level[14] = 1.779;
					trigger_pulse(level, delay);			
				end
			end

			#(CONFIG_ODD) begin fork
				set_prog_cap(4'h5);
				#1.0us	clock_stb(26);
				#1.5us	set_chan_mux(13);
					/*	Channel 1	*/
				#2.5us	set_le_dac(1, 6'h20);
				#3.5us	set_cv_dac(1, 2'h0);
				#4.5us	set_tp_mux(1, TP_ZC_OUT);
					/*	Channel 3	*/
				#5.5us	set_le_dac(3, 6'h21);
				#6.5us	set_cv_dac(3, 2'h1);
				#7.5us	set_tp_mux(3, TP_AGND);
					/*	Channel 5	*/
				#8.5us	set_le_dac(5, 6'h24);
				#9.5us	set_cv_dac(5, 2'h2);
				#10.5us	set_tp_mux(5, TP_LE_OUT);
					/*	Channel 7	*/
				#11.5us	set_le_dac(7, 6'h27);
				#12.5us	set_cv_dac(7, 2'h3);
				#13.5us	set_tp_mux(7, TP_ZCP);
					/*	Channel 9	*/
				#14.5us	set_le_dac(9, 6'h2a);
				#15.5us	set_cv_dac(9, 2'h0);
				#16.5us	set_tp_mux(9, TP_ZCM);
					/*	Channel 11	*/
				#17.5us	set_le_dac(11, 6'h2b);
				#18.5us	set_cv_dac(11, 2'h1);
				#19.5us	set_tp_mux(11, TP_CV_OUT);
					/*	Channel 13	*/
				#20.5us	set_le_dac(13, 6'h2c);
				#21.5us	set_cv_dac(13, 2'h2);
				#22.5us	set_tp_mux(13, TP_LE_VTH);
					/*	Channel 15	*/
				#23.5us	set_le_dac(15, 6'h2d);
				#24.5us	set_cv_dac(15, 2'h3);
				#25.5us	set_tp_mux(15, TP_LE_NOWLIN);
			join end

			#(HIT_ODD) begin		
				begin
					/* Trigger the exp pules */
					for(i =1; i < CHANNELS; i = i + 2) begin
						delay[i] = $urandom_range(90,10)*1ns + $urandom_range(9,0)*100ps;
					end
					
					level[1] = -0.035;
					level[3] = -0.087;
					level[5] = -0.333;
					level[7] = -0.789;
					level[9] = -0.999;
					level[11] = -1.13;
					level[13] = -1.67;
					level[15] = -1.779;
					trigger_pulse(level, delay);			
				end
			end
		
			/* Shift data into config regs */
			#(SHIFTIN) begin
				shift(SHIFTLEN, SHIFTDATA);
			end	

			/* Shift data out of config regs */
			#(SHIFTOUT) begin
				shift(SHIFTLEN);
			end
		join
	end
endmodule
