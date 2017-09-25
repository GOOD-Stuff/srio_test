# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7k325tffg676-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Projects/srio_test/srio_test/srio_test.cache/wt [current_project]
set_property parent.project_path C:/Projects/srio_test/srio_test/srio_test.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Projects/srio_test/srio_test/srio_test.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen.xci
set_property is_locked true [get_files c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir C:/Projects/srio_test/srio_test/srio_test.runs/tx_axis_gen_synth_1 -new_name tx_axis_gen -ip [get_ips tx_axis_gen]]

if { $cached_ip eq {} } {

synth_design -top tx_axis_gen -part xc7k325tffg676-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix tx_axis_gen_ tx_axis_gen.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ tx_axis_gen_stub.v
 lappend ipCachedFiles tx_axis_gen_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ tx_axis_gen_stub.vhdl
 lappend ipCachedFiles tx_axis_gen_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ tx_axis_gen_sim_netlist.v
 lappend ipCachedFiles tx_axis_gen_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ tx_axis_gen_sim_netlist.vhdl
 lappend ipCachedFiles tx_axis_gen_sim_netlist.vhdl

 config_ip_cache -add -dcp tx_axis_gen.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips tx_axis_gen]
}

rename_ref -prefix_all tx_axis_gen_

write_checkpoint -force -noxdef tx_axis_gen.dcp

catch { report_utilization -file tx_axis_gen_utilization_synth.rpt -pb tx_axis_gen_utilization_synth.pb }

if { [catch {
  file copy -force C:/Projects/srio_test/srio_test/srio_test.runs/tx_axis_gen_synth_1/tx_axis_gen.dcp c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force C:/Projects/srio_test/srio_test/srio_test.runs/tx_axis_gen_synth_1/tx_axis_gen.dcp c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force C:/Projects/srio_test/srio_test/srio_test.runs/tx_axis_gen_synth_1/tx_axis_gen_stub.v c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/Projects/srio_test/srio_test/srio_test.runs/tx_axis_gen_synth_1/tx_axis_gen_stub.vhdl c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/Projects/srio_test/srio_test/srio_test.runs/tx_axis_gen_synth_1/tx_axis_gen_sim_netlist.v c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/Projects/srio_test/srio_test/srio_test.runs/tx_axis_gen_synth_1/tx_axis_gen_sim_netlist.vhdl c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir C:/Projects/srio_test/srio_test/srio_test.ip_user_files/ip/tx_axis_gen]} {
  catch { 
    file copy -force c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_stub.v C:/Projects/srio_test/srio_test/srio_test.ip_user_files/ip/tx_axis_gen
  }
}

if {[file isdir C:/Projects/srio_test/srio_test/srio_test.ip_user_files/ip/tx_axis_gen]} {
  catch { 
    file copy -force c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_stub.vhdl C:/Projects/srio_test/srio_test/srio_test.ip_user_files/ip/tx_axis_gen
  }
}
