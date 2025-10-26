library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity Radical is
    Port  
	     (in_vec:in STD_LOGIC_VECTOR (9 downto 0);
		  out_vec:out STD_LOGIC_VECTOR (5 downto 0));
		 
end Radical;

architecture Behavioral of Radical is
  begin
    process(in_vec)
        variable in_int: integer;
        variable out_int: integer;
        variable radical_res: real;
		
      begin
		-- Convert the input vector to an integer
        in_int:= to_integer(unsigned(in_vec));
		-- Calculate the square root of the input integer
        radical_res:= SQRT(real(in_int));
		-- Round up the square root to the nearest integer
        out_int:= integer(CEIL(radical_res));
		-- Convert the output integer to a vector and assign it to the output port
        out_vec<= std_logic_vector(to_unsigned(out_int, 6));
		
    end process;
	
end Behavioral;