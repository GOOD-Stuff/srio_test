@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 57c85ee0affe44c98a252c813579de81 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L blk_mem_gen_v8_3_4 -L fifo_generator_v13_1_2 -L srio_gen2_v4_0_5 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot srio_example_test_behav xil_defaultlib.srio_example_test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
