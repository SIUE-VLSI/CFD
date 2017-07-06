/*	Pulse characteristics	*/
localparam PW = 100ns; 
localparam TRF = 10ns;
localparam TPD = 100ns;
localparam STBPERIOD = 1us; //main clock
localparam SFTPERIOD = 1us; //shift clocks
localparam DEADBAND = 100ns; //shift clock non-overlap time

/*	Bit widths	*/
localparam CVBITS = 2;
localparam ADDRBITS = 4;
localparam DATABITS = 6;
localparam MODEBITS = 4;
localparam SBITS = 4;
localparam LEBITS = 6;
localparam TPBITS = 3;
localparam CHMUXBITS = 4;
localparam CHANNELS = 16;
localparam SHIFTLEN = (SBITS + CHMUXBITS + (CVBITS + LEBITS + TPBITS)*CHANNELS);

/*	Mode values 	*/
localparam SMODE = 3'h0;
localparam MUXMODE = 3'h1;
localparam LEMODE = 3'h2;
localparam TPMODE = 3'h3;
localparam CVMODE = 3'h4;
localparam GMODE = 3'h8; //global mode
localparam COMMON = 4'h0; //address for common area devices

/*	TP MUX selectors	*/
localparam TP_AGND = 3'h0;
localparam TP_ZC_OUT = 3'h1;
localparam TP_LE_OUT = 3'h2;
localparam TP_ZCP = 3'h3;
localparam TP_ZCM = 3'h4;
localparam TP_LE_NOWLIN = 3'h5;
localparam TP_CV_OUT = 3'h6;
localparam TP_LE_VTH = 3'h7; 

/*	Simulation parameters	*/
localparam EPSILON = 1e-6;
localparam SIMDELAY = 375us;
localparam POWER = 1ns;
localparam ALLREGS = (SBITS + CHMUXBITS + 3*CHANNELS); //number of cycles to load all regs
localparam SHIFTDATA = 184'h5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a;

/*	Event schedule	*/
localparam CONFIG_ALL = 10us; //use GMODE to set all regs.
localparam HIT_ALL = 25us;
localparam CONFIG_EVEN = 75us;
localparam HIT_EVEN = 125us;
localparam CONFIG_ODD = 175us;
localparam HIT_ODD = 225us;
localparam SHIFTIN = 275us; //shift data in
localparam SHIFTOUT = 325us; //shift data out
