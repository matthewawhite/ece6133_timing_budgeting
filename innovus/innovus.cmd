#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Apr 24 01:54:54 2020                
#                                                     
#######################################################

#@(#)CDS: Innovus v19.11-s128_1 (64bit) 08/20/2019 20:54 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 19.11-s128_1 NR190815-2055/19_11-UB (database version 18.20, 469.7.1) {superthreading v1.51}
#@(#)CDS: AAE 19.11-s034 (64bit) 08/20/2019 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 19.11-s040_1 () Aug  1 2019 08:53:57 ( )
#@(#)CDS: SYNTECH 19.11-e010_1 () Jul 15 2019 20:31:02 ( )
#@(#)CDS: CPE v19.11-s006
#@(#)CDS: IQuantus/TQuantus 19.1.2-s245 (64bit) Thu Aug 1 10:22:01 PDT 2019 (Linux 2.6.32-431.11.2.el6.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
setAnalysisMode -analysisType onChipVariation
setBudgetingMode -reportOrModifyBudget true -virtualOptEngine none
all_constraint_modes -active
set_interactive_constraint_modes [all_constraint_modes -active]
set_global timing_allow_input_delay_on_clock_source true
set_global report_timing_format {arc arrival cell delay edge fanin fanout hpin instance load net pin pin_load required slew stolen timing_point wire_load}
set init_verilog PRESENT_ENC_MAPPED.v
set init_lef_file gscl45nm.lef
set init_mmmc_file Default.view
init_design
floorPlan -r {1 [0.7 [0 0 0 0]]}
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
assignPtnPin
setBudgetingMode -reportOrModifyBudget true -virtualOptEngine none
deriveTimingBudget
saveTimingBudget -dir budget
buildTimingGraph
timeDesign -postRoute
modifyBudget -file budgetModify.tcl -ptn Reg_width64 -view present_enc_av
saveTimingBudget -dir budgetMod
buildTimingGraph
timeDesign -postRoute
