set_input_delay 1000 -clock clk -max -fall -add_delay [all_inputs]
set_input_delay 1000 -clock clk -max -rise -add_delay [all_inputs]
set_input_delay 1000 -clock clk -max -rise -add_delay [get_ports {input[63]}]
set_input_delay 1000 -clock {_INN_superClk_v0_setuphold} -max -rise [get_ports {input[63]}] -add_delay
set_input_delay 1000 -clock {_INN_superClk_v0_setuphold} -max -fall [get_ports {input[63]}] -add_delay
set_input_delay 1000 -clock {clk_v0_setuphold} -max -rise [get_ports {input[63]}] -add_delay
set_input_delay 1000 -clock {clk_v0_setuphold} -max -fall [get_ports {input[63]}] -add_delay
