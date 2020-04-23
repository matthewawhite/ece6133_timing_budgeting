
create_constraint_mode -name present_enc_cm -sdc_files PresentEnc_present_enc_av.top.constr \
	 -ilm_sdc_files \
	 [list ../constraints.sdc]
create_library_set -name gscl45nm_ls_budgeting_max\
   -timing\
    [list ../gscl45nm.tlf\
    ./AsyncMux_width64_present_enc_av_max.lib]
create_library_set -name gscl45nm_ls_budgeting_min\
   -timing\
    [list ../gscl45nm.tlf\
    ./AsyncMux_width64_present_enc_av_min.lib]
create_rc_corner -name default_rc_corner\
   -preRoute_res 1\
   -preRoute_cap 1\
   -postRoute_res {1}\
   -postRoute_cap {1}\
   -postRoute_xcap {1}\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -postRoute_clkres {0 0 0}\
   -postRoute_clkcap {0 0 0}
create_delay_corner -name gscl45nm_dc\
   -late_library_set gscl45nm_ls_budgeting_max\
   -early_library_set gscl45nm_ls_budgeting_min\
   -rc_corner default_rc_corner
create_analysis_view -name present_enc_av -delay_corner gscl45nm_dc -constraint_mode present_enc_cm
set_analysis_view -setup [list present_enc_av] -hold [list present_enc_av]
