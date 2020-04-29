set_global timing_allow_input_delay_on_clock_source true
set init_verilog PRESENT_ENC_MAPPED.v
set init_lef_file gscl45nm.lef
set init_mmmc_file Default-171.view
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
routeDesign -globalDetail

assignPtnPin

set_global report_timing_format {arc arrival cell delay edge fanin fanout hpin instance load net pin pin_load required slew stolen timing_point wire_load}

setBudgetingMode -reportOrModifyBudget true 

deriveTimingBudget -justify -ptn Reg_width64
deriveTimingBudget -justify -ptn Reg_width80
deriveTimingBudget -justify -ptn AsyncMux_width80
deriveTimingBudget -justify -ptn AsyncMux_width64

partition Reg_width64
partition Reg_width80
partition AsyncMux_width80
partition AsyncMux_width64

savePartition
saveTimingBudget -ptn Reg_width64
saveTimingBudget -ptn Reg_width80
saveTimingBudget -ptn AsyncMux_width80
saveTimingBudget -ptn AsyncMux_width64


saveTimingBudget -dir budgetMod

buildTimingGraph

report_timing > timing_report-171.txt

setAnalysisMode -analysisType onChipVariation
timeDesign -postRoute

get_metric timing.setup.TNS.all

set_interactive_constraint_modes [all_constraint_modes -active]
modifyBudget -file budgetModify.tcl -inst regText -view present_enc_av
saveTimingBudget -dir budgetMod
