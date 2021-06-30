onerror {quit -f}
vlib work
vlog -work work TrabalhoFinal.vo
vlog -work work TrabalhoFinal.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.processador_vlg_vec_tst
vcd file -direction TrabalhoFinal.msim.vcd
vcd add -internal processador_vlg_vec_tst/*
vcd add -internal processador_vlg_vec_tst/i1/*
add wave /*
run -all
