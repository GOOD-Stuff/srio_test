#
#Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
#
set_param project.singleFileAddWarning.threshold 0
set_param xicom.use_bs_reader 1
set_param chipscope.flow 0
set part xc7k325tffg676-1
set ip_vlnv xilinx.com:ip:xsdbm:2.0
set ip_module_name dbg_hub_CV
set params {{{PARAM_VALUE.C_BSCAN_MODE} {false} {PARAM_VALUE.C_BSCAN_MODE_WITH_CORE} {false} {PARAM_VALUE.C_CLK_INPUT_FREQ_HZ} {300000000} {PARAM_VALUE.C_ENABLE_CLK_DIVIDER} {false} {PARAM_VALUE.C_NUM_BSCAN_MASTER_PORTS} {0} {PARAM_VALUE.C_TWO_PRIM_MODE} {false} {PARAM_VALUE.C_USER_SCAN_CHAIN} {1} {PARAM_VALUE.C_USE_EXT_BSCAN} {false} {PARAM_VALUE.C_XSDB_NUM_SLAVES} {2}}}
set output_xci c:/Projects/srio_test/srio_test/srio_test.runs/impl_3/.Xil/Vivado-2736-vldmr-PC/dbg_hub_CV.0/out/result.xci
set output_dcp c:/Projects/srio_test/srio_test/srio_test.runs/impl_3/.Xil/Vivado-2736-vldmr-PC/dbg_hub_CV.0/out/result.dcp
set output_dir c:/Projects/srio_test/srio_test/srio_test.runs/impl_3/.Xil/Vivado-2736-vldmr-PC/dbg_hub_CV.0/out
set ip_repo_paths {}
set ip_output_repo C:/Projects/srio_test/srio_test/srio_test.cache/ip
set ip_cache_permissions {read write}

set oopbus_ip_repo_paths [get_param chipscope.oopbus_ip_repo_paths]

set synth_opts {}
set xdc_files {}
source {C:/Xilinx/Vivado/2016.3/scripts/ip/ipxchipscope.tcl}

set failed [catch {ipx::chipscope::gen_and_synth_ip $part $ip_vlnv $ip_module_name $params $output_xci $output_dcp $output_dir $ip_repo_paths $ip_output_repo $ip_cache_permissions $oopbus_ip_repo_paths $synth_opts $xdc_files} errMessage]

if { $failed } {
  puts "Caught exception:"
  puts "$errMessage"
  exit 1
}
