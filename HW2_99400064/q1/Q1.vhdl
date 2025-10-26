library ieee;
use ieee.std_logic_1164.all; 
use IEEE.NUMERIC_STD.all;
library Q1;
use IEEE.NUMERIC_STD.all;

package my_array is	
	type my_type is array(0 to 9) of std_logic_vector(7 downto 0);
end;  

library ieee;
use ieee.std_logic_1164.all;
library Q1;
use Q1.my_array.all;	
use IEEE.NUMERIC_STD.all;

entity my_example is
  port (
  input_vector : in  my_type;
  output_vector : out my_type);  
end my_example;

architecture behave of my_example is
begin  
	process(input_vector)	
		variable temp : std_logic_vector(0 to 7);
		variable result_array : my_type;  
	begin
	  result_array := input_vector;
	  for i in 0 to 9 loop --create a loops over array
	    for j in 0 to 9 loop	
        	if ( unsigned(result_array(i)) <= unsigned(result_array(j)) ) then
		        temp := result_array(i);
		        result_array(i) := result_array(j);
		        result_array(j) := temp;
	      	end if; 
	    end loop;        
	  end loop;
	  output_vector <= result_array;
		
	end process;

end behave;	   


------------------testbench------------------   

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
      output_vector : out my_type
    );
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
