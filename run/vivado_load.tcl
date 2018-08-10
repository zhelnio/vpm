
# Path where project will be created
set project_path [pwd]
set script_path [file dirname [file normalize [info script]]]

#################################################################################
# settings START
#################################################################################

# source files path
set source_path $script_path/../rtl
set tb_path     $script_path/../tb
set const_path  $script_path/../run

set project_name    "system"
set project_part    "xczu9eg-ffvb1156-2-e"
set project_board   "xilinx.com:zcu102:part0:3.1"

set source_files [list \
    "[file normalize "$tb_path/tb_pipeline.sv"]" \
    "[file normalize "$source_path/vpm.svh"]" \
    "[file normalize "$source_path/prm_register.v"]" \
    "[file normalize "$source_path/prm_register_c.v"]" \
    "[file normalize "$source_path/prm_register_ce.v"]" \
    "[file normalize "$source_path/prm_register_cce.v"]" \
    "[file normalize "$source_path/prm_register_cc.v"]" \
]

set constr_files [list \
    "[file normalize "$const_path/vivado.xdc"]" \
]

set sim_files [list \
    "[file normalize "$tb_path/tb_top.sv"]" \
    "[file normalize "$tb_path/tb.sv"]" \
]

set testbench_top   "tb"

# IP cores repository path
# set ip_repo_paths [list \
#     "./" \
#     "../xilinx_ip" \
# ]

#################################################################################
# Settings END
#################################################################################

# Create project
create_project $project_name $project_path -part $project_part -force

# Set project properties
set obj [current_project]
set_property -name "board_part" -value $project_board -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "dsa.num_compute_units" -value "60" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$project_path/${project_name}.cache/ip" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_FIFO XPM_MEMORY" -objects $obj
#set_property -name "ip_repo_paths" -value $ip_repo_paths -objects $obj
update_ip_catalog -rebuild

# Create 'sources_1' fileset
if {[string equal [get_filesets -quiet sources_1] ""]} {
    create_fileset -srcset sources_1
}

# Fill 'sources_1' fileset
if {[info exists source_files]} {
    set obj [get_filesets sources_1]
    add_files -norecurse -fileset $obj $source_files
}

# Create 'constrs_1' fileset
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Fill 'constrs_1' fileset
if {[info exists constr_files]} {
    set obj [get_filesets constrs_1]
    add_files -norecurse -fileset $obj $constr_files
}

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Fill 'sim_1' fileset
if {[info exists sim_files]} {
    set obj [get_filesets sim_1]
    add_files -norecurse -fileset $obj $sim_files
    set_property top $testbench_top $obj
}

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run  -name synth_1 \
                -part $project_part \
                -flow {Vivado Synthesis 2017} \
                -strategy "Vivado Synthesis Defaults" \
                -report_strategy {No Reports} -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2017" [get_runs synth_1]
}

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run  -name impl_1 \
                -part $project_part \
                -flow {Vivado Implementation 2017} \
                -strategy "Vivado Implementation Defaults" \
                -report_strategy {No Reports} \
                -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2017" [get_runs impl_1]
}

set obj [get_runs impl_1]
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:$project_name"

#exit
