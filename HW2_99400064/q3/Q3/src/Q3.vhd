library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Q3 is
    port (
        expression_input: in std_logic_vector(15 downto 0);
        output: out std_logic_vector(1 downto 0));
end entity Q3;

architecture Behavioral of Q3 is    
begin
    process(expression_input)
     variable sum_even: integer range 0 to 16:=0;
     variable sum_odd: integer range 0 to 16:=0;   
	 
	begin
        for i in expression_input'range loop
			if expression_input(i) = '1'
				then
			 if (i+1) mod 2 = 0 
				 then
                sum_even := sum_even + 1;-- even index
             else  
                sum_odd := sum_odd + 1;-- odd index
            end if;
		   end if;
         end loop;
        output <= "00";  -- default value
        if sum_even mod 3 = 0 then
            output(1) <= '1';
        end if;
        
        if sum_odd mod 5 = 0 then
            output(0) <= '1';
        end if;
    end process;
end architecture Behavioral;
