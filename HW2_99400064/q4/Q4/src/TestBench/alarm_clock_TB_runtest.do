SetActiveLib -work
comp -include "$dsn\src\Q4.vhd" 
comp -include "$dsn\src\TestBench\alarm_clock_TB.vhd" 
asim +access +r TESTBENCH_FOR_alarm_clock 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg set
wave -noreg hours_in
wave -noreg minutes_in
wave -noreg alarm_hours_in
wave -noreg alarm_minutes_in
wave -noreg alarm_set
wave -noreg alarm_stop
wave -noreg on_alarm
wave -noreg hour0_output
wave -noreg hour1_output
wave -noreg min0_output
wave -noreg min1_output
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\alarm_clock_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_alarm_clock 
