SetActiveLib -work
comp -include "$dsn\src\q1.vhd" 
comp -include "$dsn\src\TestBench\q1block_TB.vhd" 
asim +access +r TESTBENCH_FOR_q1block 
wave 
wave -noreg clock
wave -noreg input
wave -noreg beginZeroF
wave -noreg beginZeroL
wave -noreg endZeroF
wave -noreg endZeroL
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\q1block_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_q1block 
