onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_4 -L fifo_generator_v13_1_2 -L srio_gen2_v4_0_5 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.srio_gen2_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {srio_gen2_0.udo}

run -all

quit -force
