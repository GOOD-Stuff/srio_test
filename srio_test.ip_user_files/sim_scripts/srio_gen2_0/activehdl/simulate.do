onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+srio_gen2_0 -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_4 -L fifo_generator_v13_1_2 -L srio_gen2_v4_0_5 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.srio_gen2_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {srio_gen2_0.udo}

run -all

endsim

quit -force
