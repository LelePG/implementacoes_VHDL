onerror {quit -f}
vlib work
vlog -work work hadamard.vo
vlog -work work hadamard.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.hadamard_vlg_vec_tst
vcd file -direction hadamard.msim.vcd
vcd add -internal hadamard_vlg_vec_tst/*
vcd add -internal hadamard_vlg_vec_tst/i1/*
add wave /*
run -all
