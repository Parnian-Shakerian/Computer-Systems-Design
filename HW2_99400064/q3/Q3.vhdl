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

--------------------testbench--------------------	

library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

entity q3_tb is
end q3_tb;

architecture TB_ARCHITECTURE of q3_tb is

	component q3
	port(
		expression_input : in STD_LOGIC_VECTOR(15 downto 0);
		output : out STD_LOGIC_VECTOR(1 downto 0) );
	end component;

	signal expression_input : STD_LOGIC_VECTOR(15 downto 0);
	signal output : STD_LOGIC_VECTOR(1 downto 0);

begin

	UUT : q3
		port map (
			expression_input => expression_input,
			output => output);

	-- Add your stimulus here ...
	process
	    begin  
	
		expression_input <= "1100110000111111"; --input of doc
		--expression_input <= "1100110000111110"; --other input
		--expression_input <= "1100110000001001"; --other input
		--expression_input <= "0101010101010101"; --other input
		--expression_input <= "1010101010101010"; --other input
		--expression_input <= "0000000000101010"; --other input
		wait for 100ns;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_q3 of q3_tb is
	for TB_ARCHITECTURE
		for UUT : q3
			use entity work.q3(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_q3;