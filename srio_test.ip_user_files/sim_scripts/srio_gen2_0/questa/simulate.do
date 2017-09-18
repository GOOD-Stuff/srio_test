onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib srio_gen2_0_opt

do {wave.do}

view wave
view structure
view signals

do {srio_gen2_0.udo}

run -all

quit -force
