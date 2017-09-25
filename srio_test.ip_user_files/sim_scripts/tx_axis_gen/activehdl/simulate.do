onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+tx_axis_gen -L xil_defaultlib -L xpm -L fifo_generator_v13_1_2 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.tx_axis_gen xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {tx_axis_gen.udo}

run -all

endsim

quit -force
