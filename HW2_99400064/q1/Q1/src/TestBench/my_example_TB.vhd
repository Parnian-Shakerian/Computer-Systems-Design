library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library Q1;
use Q1.my_array.all;

entity my_example_tb is
end my_example_tb;

architecture testbench of my_example_tb is
  signal input_vector_tb : my_type;
  signal output_vector_tb : my_type;

  component my_example
    port (
      input_vector : in my_type;
      output_vector : out my_type);
  end component;

begin
  uut: my_example
    port map (
      input_vector => input_vector_tb,
      output_vector => output_vector_tb
    );

  stimulus_process: process
  begin
    -- Provide input values
    input_vector_tb <= (
      
      "00000100",
	  "00000001",
      "00000010",
      "00000101",
      "00000110",
	  "00001001",
	  "00000111",
      "00001000",
	  "00000011",
      "00001010"
    );

    -- Wait for simulation to complete
    wait for 100 ns;

    -- Display output values
    for i in input_vector_tb'range loop
      
    end loop;

    -- End simulation
    wait;
  end process stimulus_process;
end testbench;
