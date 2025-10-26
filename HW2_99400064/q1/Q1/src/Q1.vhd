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

