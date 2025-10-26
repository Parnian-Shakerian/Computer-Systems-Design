SetActiveLib -work
comp -include "$dsn\src\q3.vhd" 
comp -include "$dsn\src\TestBench\mealy_code_TB.vhd" 
asim +access +r TESTBENCH_FOR_mealy_code 
wave 
wave -noreg clock
wave -noreg reset
wave -noreg input
wave -noreg output
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\mealy_code_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_mealy_code 
