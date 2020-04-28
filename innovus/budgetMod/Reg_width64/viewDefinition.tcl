
create_constraint_mode -name present_enc_cm -sdc_files Reg_width64_present_enc_av.constr.pt
create_library_set -name gscl45nm_ls\
   -timing\
    [list ../../gscl45nm.tlf]
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
   -library_set gscl45nm_ls\
   -rc_corner default_rc_corner
create_analysis_view -name present_enc_av -delay_corner gscl45nm_dc -constraint_mode present_enc_cm
set_analysis_view -setup [list present_enc_av] -hold [list present_enc_av]
