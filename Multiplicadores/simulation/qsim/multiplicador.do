onerror {quit -f}
vlib work
vlog -work work multiplicador.vo
vlog -work work multiplicador.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.multiplicadorSequencial_vlg_vec_tst
vcd file -direction multiplicador.msim.vcd
vcd add -internal multiplicadorSequencial_vlg_vec_tst/*
vcd add -internal multiplicadorSequencial_vlg_vec_tst/i1/*
add wave /*
run -all
