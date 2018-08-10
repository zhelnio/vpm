
set project_name  "system"
set synth_task    "synth_1"
set impl_task     "impl_1"
set timing_report "timing_1"

open_project "$project_name.xpr"

# synth
set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-mode out_of_context} -objects [get_runs $synth_task]
reset_run $synth_task
launch_runs $synth_task -jobs 6
wait_on_run -verbose $synth_task

launch_runs $impl_task -jobs 6
wait_on_run -verbose $impl_task

# open & report
open_run $impl_task -name $impl_task
start_gui
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -routable_nets -name $timing_report
