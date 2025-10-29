SetActiveLib -work
comp -include "$dsn\src\q4.vhd" 
comp -include "$dsn\src\TestBench\d_reg_TB.vhd" 
asim +access +r TESTBENCH_FOR_d_reg 
wave 
wave -noreg d
wave -noreg clk
wave -noreg q_vec
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\d_reg_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_d_reg 
