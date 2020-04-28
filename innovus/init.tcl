setAnalysisMode -analysisType onChipVariation
setBudgetingMode -reportOrModifyBudget true -virtualOptEngine none
set_interactive_constraint_modes [all_constraint_modes -active]
set_global timing_allow_input_delay_on_clock_source true
set_global report_timing_format {arc arrival cell delay edge fanin fanout hpin instance load net pin pin_load required slew stolen timing_point wire_load}

set init_verilog PRESENT_ENC_MAPPED.v
set init_lef_file gscl45nm.lef
set init_mmmc_file Default.view
init_design

floorplan -r {1 [0.7 [0 0 0 0]]}

createGuide regText 0 0 75 75
createGuide regKey 0 0 75 75
createGuide mux_80 0 0 75 75
createGuide mux_64 0 0 75 75
definePartition -hinst regText
definePartition -hinst regKey
definePartition -hinst mux_80
definePartition -hinst mux_64

place_design
routeDesign -global
