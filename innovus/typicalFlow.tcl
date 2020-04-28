source init.tcl

assignPtnPin

set_global report_timing_format {arc arrival cell delay edge fanin fanout hpin instance load net pin pin_load required slew stolen timing_point wire_load}

setBudgetingMode -reportOrModifyBudget true -virtualOptEngine none

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

deriveTimingBudget
saveTimingBudget -dir budget

buildTimingGraph

report_timing > timing_report_typical.txt

setAnalysisMode -analysisType onChipVariation
timeDesign -postRoute

get_metric timing.setup.TNS.all
