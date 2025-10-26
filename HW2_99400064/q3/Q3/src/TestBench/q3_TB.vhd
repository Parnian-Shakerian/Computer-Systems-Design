library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

entity q3_tb is
end q3_tb;

architecture TB_ARCHITECTURE of q3_tb is

	component q3
	port(
		expression_input : in STD_LOGIC_VECTOR(15 downto 0);
		output : out STD_LOGIC_VECTOR(1 downto 0));
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