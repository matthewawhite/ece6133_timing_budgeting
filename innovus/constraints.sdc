#create the clock
create_clock -period 1 -waveform {0 0.5} clk

#set driving strength of all inputs first
set_driving_cell -library gscl45nm -lib_cell NAND2X1 -pin Y -multiply_by 2 [all_inputs]

#set drive strength of clk to .25
set_drive .25 {clk}

#set load of all outputs
set_load [expr 10 * [get_property [get_lib_pins gscl45nm/INVX1/A] capacitance]] [all_outputs]

#set input delay
set_input_delay 5.0 -clock clk [all_inputs]

#set output delay
set_output_delay 5.0 -clock clk [all_outputs]
