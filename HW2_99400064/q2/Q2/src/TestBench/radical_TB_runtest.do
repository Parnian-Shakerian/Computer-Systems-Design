SetActiveLib -work
comp -include "$dsn\src\Q2.vhd" 
comp -include "$dsn\src\TestBench\radical_TB.vhd" 
asim +access +r TESTBENCH_FOR_radical 
wave 
wave -noreg in_vec
wave -noreg out_vec
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\radical_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_radical 
