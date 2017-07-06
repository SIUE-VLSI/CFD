#
# SDC file for mac design
#

#
# Period and fanout information in global.tcl file
#
set  MAX_FAN_OUT  50

set  CLOCK_PERIOD  10

set_max_fanout ${MAX_FAN_OUT} [current_design]

# Create the transmitter clock

create_clock	-name {clk} \
		-period ${CLOCK_PERIOD} \
		-waveform [list [expr ${CLOCK_PERIOD} / 2.0] 0] \
		[get_ports {clk}]


# Set input and output delays
#

set_input_delay 0.1 -clock clk [remove_from_collection [all_inputs] {clk}]

set_output_delay 0.1 -clock clk [all_outputs]

set_false_path  -from  [get_ports {reset}]

