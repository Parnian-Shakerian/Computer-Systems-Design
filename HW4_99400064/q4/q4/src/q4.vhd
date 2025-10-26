library ieee;
use ieee.std_logic_1164.all;

package utils is
	function double_ones(input_vector : std_logic_vector(7 downto 0)) return std_logic_vector;
	function add_one_in_front(input_vector : std_logic_vector(7 downto 0)) return std_logic_vector;
end package;

package body utils is
	 function double_ones(input_vector : std_logic_vector(7 downto 0)) return std_logic_vector is
	    variable ones_count : integer := 0;
	    variable output_vector : std_logic_vector(7 downto 0) := (others => '0');
	begin
	    -- Count the number of ones 
	    for i in 0 to 7 loop
	        if input_vector(i) = '1' then
	            ones_count := ones_count + 1;
	        end if;
	    end loop;
		
		if ones_count = 0 then
			return output_vector;
		end if;
	
	    -- Double the number of ones 
	    for i in 0 to (ones_count * 2)-1 loop
	    	output_vector(i + ones_count) := '1';
	    end loop;
	
	    return output_vector;
	end function;
	
	function add_one_in_front(input_vector : std_logic_vector(7 downto 0)) return std_logic_vector is
	    variable output_vector : std_logic_vector(7 downto 0) := (0 => '1', others => '0');
	begin
	    for i in 0 to 6 loop
	        output_vector(i+1) := input_vector(i);
	    end loop;
	    return output_vector;
	end function; 
	
end package body;
	
library ieee;
use ieee.std_logic_1164.all;
use work.utils.all;


entity binary_to_unary is
    port (
        binary : in  std_logic_vector(2 downto 0);
        unary  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture behavioral of binary_to_unary is
begin
    process(binary)
	variable output : std_logic_vector(7 downto 0) := (others => '0');
    begin
		for i in 0 to 2 loop
			if binary(i) = '1' then
				output := add_one_in_front(output);
			end if;
			if i /= 2 then
				output := double_ones(output);
			end if;
		end loop;
		unary <= output;
    end process;
end architecture behavioral;