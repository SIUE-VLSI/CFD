
// #########################################################################################
//
// Initialization task
// 
// #########################################################################################
task init;
	integer i;

	AVDD = 0; 	//Analog supply
	AGND = 0; 	//Analog ground
	AVSS = 0; 	//Analog reference
	SVSS = 0; 	//Substrate ground
	DVDD3 = 0; 	//Digital logice supply

	STB = 0;	//Main clock line
	SI = 0;		//Shift data input line
	SI_CLK = 0;	//Shift in clock
	SO_CLK = 0;	//Shift out clock

	/* Set address, mode, and data lines low */
	for(i = 0; i < ADDRBITS; i = i + 1) begin
		ADDR[i] = 0;
	end

	for(i = 0; i < DATABITS; i = i + 1) begin
		DATA[i] = 0;
	end

	for(i = 0; i < MODEBITS; i = i + 1) begin
		MODE[i] = 0;
	end

	/* Set pulse trigger and peak lines low */
	for(i = 0; i < CHANNELS; i = i + 1) begin
		TRIG[i] = 0;
		PEAK[i] = 0;
	end
endtask


// #########################################################################################
//
// Power on task
// 
// #########################################################################################
task power_on(real delay);
		AVDD = 5.0;
		AGND = 2.5;
		DVDD3 = 3.3;	
endtask

// #########################################################################################
//
// Change the address lines
// 
// #########################################################################################
task set_cv_dac(integer channel, input[CVBITS-1:0] data);
	integer i;
	reg[ADDRBITS-1:0] addr;

	#(TRF)
	addr = 0;
	for(i = 0; i < channel; i = i + 1) begin
		addr = addr + 1;
	end
	ADDR = addr;
	MODE[MODEBITS-2:0] = CVMODE;
	DATA[CVBITS-1:0] = data;
endtask

// #########################################################################################
//
// Set the Leading Edge descriminator threshold DAC
// 
// #########################################################################################
task set_le_dac(integer channel, input[LEBITS-1:0] data);	
	integer i;
	reg[ADDRBITS-1:0] addr;

	#(TRF)
	addr = 0;
	for(i = 0; i < channel; i = i + 1) begin
		addr = addr + 1;
	end
	ADDR = addr;
	MODE[MODEBITS-2:0] = LEMODE;
	DATA[LEBITS-1:0] = data;
endtask

// #########################################################################################
//
// Set the test point select mux
// 
// #########################################################################################
task set_tp_mux(integer channel, input[TPBITS-1:0] data);	
	integer i;
	reg[ADDRBITS-1:0] addr;

	#(TRF)
	addr = 0;
	for(i = 0; i < channel; i = i + 1) begin
		addr = addr + 1;
	end
	ADDR = addr;
	MODE[MODEBITS-2:0] = TPMODE;
	DATA[TPBITS-1:0] = data;
endtask

// #########################################################################################
//
// Set the programmable capacitor bus
// 
// #########################################################################################
task set_prog_cap;
	input[SBITS-1:0] data;

	#(TRF)
	ADDR = COMMON;
	MODE[MODEBITS-2:0] = SMODE;
	DATA[SBITS-1:0] = data;
endtask

// #########################################################################################
//
// Set the test point channel select mux
// 
// #########################################################################################
task set_chan_mux;
	input[CHMUXBITS-1:0] data;
	
	#(TRF)
	ADDR = COMMON;
	MODE[MODEBITS-2:0] = MUXMODE;
	DATA[CHMUXBITS-1:0] = data;
endtask

// #########################################################################################
//
// Sets/resets the global mode bit
// 
// #########################################################################################
task set_gmode(integer gmode);
	if(gmode > 1 || gmode < 0) gmode = 0; 
	MODE[MODEBITS-1] = gmode;
endtask

// #########################################################################################
//
// Produces n clock cycles on the STB line
// 
// #########################################################################################
task clock_stb(integer npulses);
	integer i;
	for(i = 0; i < npulses; i = i + 1) begin
		#(STBPERIOD/2.0)
		STB = 1;
		#(STBPERIOD/2.0)
		STB = 0;
	end	
endtask

// #########################################################################################
//
// Shifts n bits in/out of the configuration registers.
// 
// #########################################################################################
task shift(integer ncycles, reg[SHIFTLEN-1:0] data = 0);
	integer i;
	for(i = 0; i < ncycles; i = i + 1) begin
		SI = data[i];
		#(DEADBAND)
		SI_CLK = 1;
		#(SFTPERIOD/2.0)
		SI_CLK = 0;
		#(DEADBAND)
		SO_CLK = 1;
		#(SFTPERIOD/2.0)
		SO_CLK = 0;
	end	
endtask

// #########################################################################################
//
// Sets the exponential pulse peak line, and creates a trigger pulse to begin the output
// 
// #########################################################################################
task trigger_pulse(real level[CHANNELS-1:0], real delay[CHANNELS-1:0]);
	integer i;
	begin
		fork
			begin
				/* Create exp pulse peak voltage pulse */
				for(i = 0; i < CHANNELS; i = i + 1) begin
					PEAK[i] = EPSILON;
				end
				
				#(TRF)
				for(i = 0; i < CHANNELS; i = i + 1) begin
					PEAK[i] = level[i];
				end

				#(PW)
				for(i = 0; i < CHANNELS; i = i + 1) begin
					PEAK[i] = level[i] + EPSILON;
				end

				#(TRF)
				for(i = 0; i < CHANNELS; i = i + 1) begin
					PEAK[i] = 0;					
				end
			end

			/* Trigger an exp pulse on each channel if a peak voltage is set */
			begin
				if(level[0] != 0) begin
				#(delay[0]) TRIG[0] = 1;
				#(PW)	    TRIG[0] = 0;
				end
			end

			begin
				if(level[1] != 0) begin
				#(delay[1]) TRIG[1] = 1;
				#(PW)	    TRIG[1] = 0;
				end
			end

			begin
				if(level[2] != 0) begin
				#(delay[2]) TRIG[2] = 1;
				#(PW)	    TRIG[2] = 0;
				end
			end

			begin
				if(level[3] != 0) begin
				#(delay[3]) TRIG[3] = 1;
				#(PW)	    TRIG[3] = 0;
				end
			end

			begin
				if(level[4] != 0) begin
				#(delay[4]) TRIG[4] = 1;
				#(PW)	    TRIG[4] = 0;
				end
			end

			begin
				if(level[5] != 0) begin
				#(delay[5]) TRIG[5] = 1;
				#(PW)	    TRIG[5] = 0;
				end
			end

			begin
				if(level[6] != 0) begin
				#(delay[6]) TRIG[6] = 1;
				#(PW)	    TRIG[6] = 0;
				end
			end

			begin
				if(level[7] != 0) begin
				#(delay[7]) TRIG[7] = 1;
				#(PW)	    TRIG[7] = 0;
				end
			end

			begin
				if(level[8] != 0) begin
				#(delay[8]) TRIG[8] = 1;
				#(PW)	    TRIG[8] = 0;
				end
			end

			begin
				if(level[9] != 0) begin
				#(delay[9]) TRIG[9] = 1;
				#(PW)	    TRIG[9] = 0;
				end
			end

			begin
				if(level[10] != 0) begin
				#(delay[10]) TRIG[10] = 1;
				#(PW)	    TRIG[10] = 0;
				end
			end

			begin
				if(level[11] != 0) begin
				#(delay[11]) TRIG[11] = 1;
				#(PW)	    TRIG[11] = 0;
				end
			end

			begin
				if(level[12] != 0) begin
				#(delay[12]) TRIG[12] = 1;
				#(PW)	    TRIG[12] = 0;
				end
			end

			begin
				if(level[13] != 0) begin
				#(delay[13]) TRIG[13] = 1;
				#(PW)	    TRIG[13] = 0;
				end
			end

			begin
				if(level[14] != 0) begin
				#(delay[14]) TRIG[14] = 1;
				#(PW)	    TRIG[14] = 0;
				end
			end

			begin
				if(level[15] != 0) begin
				#(delay[15]) TRIG[15] = 1;
				#(PW)	    TRIG[15] = 0;
				end
			end
		join
	end
endtask
