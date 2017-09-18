proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Projects/srio_test/srio_test/srio_test.cache/wt [current_project]
  set_property parent.project_path C:/Projects/srio_test/srio_test/srio_test.xpr [current_project]
  set_property ip_output_repo C:/Projects/srio_test/srio_test/srio_test.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet C:/Projects/srio_test/srio_test/srio_test.runs/synth_2/srio_example_test.dcp
  add_files -quiet c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/ila_0/ila_0.dcp
  set_property netlist_only true [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/ila_0/ila_0.dcp]
  add_files -quiet C:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/srio_gen2_0/srio_gen2_0.dcp
  set_property netlist_only true [get_files C:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/srio_gen2_0/srio_gen2_0.dcp]
  add_files -quiet c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/vio_0/vio_0.dcp
  set_property netlist_only true [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/vio_0/vio_0.dcp]
  read_xdc -mode out_of_context -ref ila_0 -cells inst c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc
  set_property processing_order EARLY [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc]
  read_xdc -ref ila_0 -cells inst c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc
  set_property processing_order EARLY [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc]
  read_xdc -mode out_of_context -ref srio_gen2_0 c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_ooc.xdc
  set_property processing_order EARLY [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_ooc.xdc]
  read_xdc -ref srio_gen2_0 c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/srio_gen2_0/srio_gen2_0_core.xdc
  set_property processing_order EARLY [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/srio_gen2_0/srio_gen2_0_core.xdc]
  read_xdc -mode out_of_context -ref vio_0 c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/vio_0/vio_0_ooc.xdc
  set_property processing_order EARLY [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/vio_0/vio_0_ooc.xdc]
  read_xdc -ref vio_0 c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/vio_0/vio_0.xdc
  set_property processing_order EARLY [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/vio_0/vio_0.xdc]
  read_xdc C:/Projects/srio_test/srio_test/top.xdc
  link_design -top srio_example_test -part xc7k160tffg676-2
  write_hwdef -file srio_example_test.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force srio_example_test_opt.dcp
  report_drc -file srio_example_test_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force srio_example_test_placed.dcp
  report_io -file srio_example_test_io_placed.rpt
  report_utilization -file srio_example_test_utilization_placed.rpt -pb srio_example_test_utilization_placed.pb
  report_control_sets -verbose -file srio_example_test_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force srio_example_test_routed.dcp
  report_drc -file srio_example_test_drc_routed.rpt -pb srio_example_test_drc_routed.pb -rpx srio_example_test_drc_routed.rpx
  report_methodology -file srio_example_test_methodology_drc_routed.rpt -rpx srio_example_test_methodology_drc_routed.rpx
  report_timing_summary -warn_on_violation -max_paths 10 -file srio_example_test_timing_summary_routed.rpt -rpx srio_example_test_timing_summary_routed.rpx
  report_power -file srio_example_test_power_routed.rpt -pb srio_example_test_power_summary_routed.pb -rpx srio_example_test_power_routed.rpx
  report_route_status -file srio_example_test_route_status.rpt -pb srio_example_test_route_status.pb
  report_clock_utilization -file srio_example_test_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force srio_example_test_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  catch { write_mem_info -force srio_example_test.mmi }
  write_bitstream -force -no_partial_bitfile srio_example_test.bit 
  catch { write_sysdef -hwdef srio_example_test.hwdef -bitfile srio_example_test.bit -meminfo srio_example_test.mmi -file srio_example_test.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

