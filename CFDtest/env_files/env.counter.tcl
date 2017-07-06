#
# Env file for ddr memory controller (ddr_top_
#

set   	PHOME		$env(PHOME) ; 	# Get the project home directory

# Specify simulaton mode!!!!!!!

set	SIM_MODE	rtl ;		# Simulation mode: rtl, syn, or pnr

# Specify basename
	
set 	BASENAME	counter  ; 	# Set the root cell	

# Controls what rc_synthesis script does

set	RC_ELAB_ONLY	false		; # Stop after elaborating
set	RC_LOAD_DSN	false		; # Only want to load a design
set	ENC_LOAD_DSN	false		; # Only want to load a design

# Let the place and route tool know which modules have been placed and routed

set	MODULE_LIST	""

#
# Source the file containing the standard options
# we would like to employ
#

source ${PHOME}/tcl_dir/defaults.tcl

# ---------------------------------------------------------------------------

# Point to key source directories

set     DSN 		${SRC}/counter/design
set     TB         	${SRC}/counter/testbench

#
# These files are used for RTL simulations (sim rtl)
# RTL simulations use RTL_VLOG_FILES and RTL_VHDL_FILES lists!!!!
# Use " " so that variables get assigned values
#

set 	RTL_VLOG_FILES 	"\
$DSN/counter.sv
"

# These files are used by the synthesis tool

set	NET		$PHOME/syn_dir/netlists
set 	SYN_VLOG_FILES 	""

# Point to the testbench files to be used

set 	RTL_TB_FILE	${TB}/${BASENAME}_tb.sv
set	SYN_TB_FILE	${TB}/${BASENAME}_syn_tb.v
set	PNR_TB_FILE	${TB}/${BASENAME}_pnr_tb.v

#
# Choreograph RTL compiler flow
#

set 	RC_TO_DO_LIST {\
${TCL_DIR}/rc/rc_synthesis.tcl \
}

# Choreograph encounter flow

set  ENC_TO_DO_LIST  {\
${ENC}/LoadConfig.tcl \
${ENC}/CreateFP.tcl\
${ENC}/PowerPlan.tcl \
${ENC}/PlaceDesign.tcl \
${ENC}/CTS.tcl \
${ENC}/RouteDesign.tcl \
${ENC}/TimeDesign.tcl \
${ENC}/VerifyDesign.tcl \
${ENC}/SaveDesign.tcl \
}

##############################################################

# Provide X and Y dimensions of the core

set	CORE_X			1000
set	CORE_Y			2000

# Set the aspect ratio for the layout
# A values less than 1.0 means wide and not so high!

set	ASPECT			0.5

# Establish a boundary outside of the core area 

set	CORE_TO_BOUND		40

# Utilization

set	UTILIZATION		0.65

##############################################################


# We need to do something special with the ncvlog opts
# since we don't have an include directory
# Alsi I am allowing for compilation of system verilog files

set	NCVLOG_OPTS	"-cdslib ${CDS_LIB} \
			-hdlvar  ${HDL_VAR} \
                        -errormax ${ERR_MAX} \
                        -update \
                        -linedebug \
			-sv \
                        -status "
