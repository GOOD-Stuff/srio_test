@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim srio_testbench_behav -key {Behavioral:sim_1:Functional:srio_testbench} -tclbatch srio_testbench.tcl -view C:/Projects/srio_test/srio_test/srio_testbench_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
