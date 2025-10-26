SetActiveLib -work
comp -include "$dsn\src\Q3.vhd" 
comp -include "$dsn\src\TestBench\q3_TB.vhd" 
asim +access +r TESTBENCH_FOR_q3 
wave 
wave -noreg expression_input
wave -noreg output
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\q3_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_q3 
