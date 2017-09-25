onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib tx_axis_gen_opt

do {wave.do}

view wave
view structure
view signals

do {tx_axis_gen.udo}

run -all

quit -force
