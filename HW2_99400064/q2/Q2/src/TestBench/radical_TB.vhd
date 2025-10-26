library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity radical_tb is
end radical_tb;

architecture TB_ARCHITECTURE of radical_tb is
	component radical
	port(
		in_vec : in STD_LOGIC_VECTOR(9 downto 0);
		out_vec : out STD_LOGIC_VECTOR(5 downto 0) );
	end component;
	signal in_vec : STD_LOGIC_VECTOR(9 downto 0);
	signal out_vec : STD_LOGIC_VECTOR(5 downto 0);

begin

	UUT : radical
		port map (
			in_vec => in_vec,
			out_vec => out_vec);

	-- Add your stimulus here ...
	process 
       begin 	
        in_vec <= "0001110000"; -- 112
        wait for 10 ns;
		
    end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_radical of radical_tb is
	for TB_ARCHITECTURE
		for UUT : radical
			use entity work.radical(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_radical;

