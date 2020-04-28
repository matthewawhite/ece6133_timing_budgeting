source init.tcl

assignPtnPin

setBudgetingMode -reportOrModifyBudget true -virtualOptEngine none

deriveTimingBudget -justify -parameterized
saveTimingBudget -dir budget

buildTimingGraph
timeDesign -postRoute

modifyBudget -file budgetModify.tcl -ptn Reg_width64 -view present_enc_av -setup
modifyBudget -file budgetModify.tcl -ptn Reg_width80 -view present_enc_av -setup
modifyBudget -file budgetModify.tcl -ptn AsyncMux_width64 -view present_enc_av -setup
modifyBudget -file budgetModify.tcl -ptn AsyncMux_width80 -view present_enc_av -setup
saveTimingBudget -dir budgetMod

buildTimingGraph
timeDesign -postRoute
