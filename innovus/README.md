This README covers the scripts, design, and results of our Innovus approach to timing budgeting.

TESTING OUR DESIGN:
Warning: if you have your own configuration for Innovus then our runInnovus.csh scripts could potential change your Innovus version until you start a new session on the server

Follow the steps below to test our typical flow and modify flow designs if using Innovus-191:
1.) source runInnovus.csh
2.) Wait for Innovus-191 to open in non-gui mode
3.) For the modify flow run:
    source modifyFlow.tcl

    For the typical flow run:
    source typicalFlow.tcl
4.) Wait a while for the script to finish running
5.) Output data is available in the places mentioned below

Follow the steps below to test our typical flow and modify flow designs if using Innovus-171:
1.) source runInnovus-171.csh
2.) Wait for Innovus-171 to open in non-gui mode
3.) source setup-171.tcl
4.) Wait for flow to finish, and once done the data is available in the folder mentioned below

DESCRIPTION OF SCRIPTS WE WROTE AND THE STEPS INVOLVED IN RUNNING THEM:
runInnovus.csh
- This script opens Innovus-191 in the non-gui mode

runInnovus-171.csh
- This script opens Innovus-171 in the non-gui mode

init.tcl
- This script initializes the typicalFlow.tcl and modifyFlow.tcl scripts and should not be called directly

typicalFlow.tcl
- This script runs a flow of initializing the design by floorplanning, placement, etc. then derives the timing budgets for each partition before saving all of the data (no modifications attempted)

modifyFlow.tcl
- This script runs through the typical flow discussed above then attempts budget modifications and saving the modifications to a budgetMod/ folder

setup-171.tcl
- This script is essentially the same as the modifyFlow.tcl script but instead runs on Innovus-171 (it is separate due to a lack of backwards compatibility within Innovus)

budgetModify.tcl
- This script is used by the modifyBudget command and should not be called directly


DETAILED DESCRIPTION OF DESIGN PROCESS:
Since a hierarchical design is required to make timing budgeting relevant, we used a hierarchical RTL design from an ECE 6132 lab. The RTL code for this design is inside the rtl/ folder and the hierarchy of the design is shown below:

Hierarchy:
1) Top module: PresentEnc
2) 1st (below top) level modules: AsyncMux, Reg, slayer, pLayer, keyupd, PresentStateMachine, counter
3) 2nd (below 1st) level modules: slayer

The rtl code was compiled using Synopsys Design Vision and saved as the verilog file PRESENT_ENC_MAPPED.v. The first step of using Innovus was to properly setup the project by the creation of a Default.view MMMC file, including a LEF file, and including PRESENT_ENC_MAPPED.v file mentioned earlier. The LEF filed used was the gscl45nm.lef file that was provided for our lab in ECE 6133. The Default.view file was setup as follows:
- Library set created using gscl45nm.tlf
- Constraint mode created using constraints.sdc
    - These constraints are based on what we used in ECE 6132 with modifications to aid in debugging. We also have a constraints-171.sdc file that is used with Innovus-171 since for some reason the same constraint file doesn't work for both Innovus-171 and Innovus-191
- Delay corner created using the library set previously mentioned
- An analysis view called present_enc_av using the present_enc_cm constraint mode and the gscl45nm_dm delay corner previously mentioned
- We created the setup and hold views for the present_enc_av analysis view

In order to obtain the results sought after or in order to enable certain features of Innovus used for timing budgeting we set set the following modes/global variables (code at top of init.tcl):
- analysisType was set to onChipVariation
- setBudgetingMode had reportOrModifyBudget set to true and virtualOptEngine set to none
- all constraint modes were set to interactive to allow for easy debugging
- the global timing_allow_input_delay_on_clock_source was set to true to allow for easy testing of modifying the timing of a given path
- report_timing_format was set to {arc arrival cell delay edge fanin fanout hpin instance load net pin pin_load required slew stolen timing_point wire_load} to get the information we wanted

After the initial setup of the project, we followed the recommended design flow for budget modifications by using text commands in the following order (specific parameters can be found in script files):
1.) floorplan
2.) createGuide (required for definePartition)
3.) defintePartition
4.) place_design
5.) route_design
6.) assignPtnPin
7.) deriveTimingBudget -justify
8.) saveTimingBudget (required for next steps)
9.) buildTimingGraph (required for data collection)
10.) timeDesign
11.) modifyBudget
12.) saveTimingBudget
13.) buildTimingGraph
14.) timeDesign

The above flow was used for attempted budget modifications, but we also have other flows for a typicalFlow for simple data collection.

DESCRIPTION OF THE TIMING BUDGETING RESULTS/DATA THAT WE COLLECTED:
In our typicalFlow we saved our partition and in our modifyFlow we saved our timing budgets with justifications of the budgets. The map for where to find specific data is listed below:

Partition information:
- Folders AsyncMux_width64/ and AsyncMux_width80/ and  Reg_width64/ and  Reg_width80/ and PresentEnc/

Budget justifications:
- Before modifications look in budget_justify/
- After modifications the budget was saved to the budget_justify_mod/ folder but as mentioned in our report, there are no differences due to issues with Innovus

Timing report:
- The folder timingReports/
