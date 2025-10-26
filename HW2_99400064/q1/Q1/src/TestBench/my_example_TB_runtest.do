SetActiveLib -work
comp -include "$dsn\src\Q1.vhd" 
comp -include "$dsn\src\TestBench\my_example_TB.vhd" 
asim +access +r TESTBENCH_FOR_my_example 
wave 
wave -noreg input_vector
wave -noreg output_vector
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\my_example_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_my_example 
