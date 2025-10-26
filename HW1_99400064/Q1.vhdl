library ieee;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package C_array is	 
	type custom_type is array(0 to 2, 0 to 2) of std_logic_vector(0 to 3);
end;

library ieee; 
library Q1;
use Q1.C_array.all;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sum is	
    port (
	in_vec : in custom_type;
	out_vec : out std_logic_vector(0 to 7)
	);
end sum;

---sum of 8 bit numbers---

architecture Behavioral of sum is
begin	

		out_vec <= std_logic_vector(unsigned("0000" & in_vec(0,0))+ unsigned("0000" &  in_vec(0,1))+ unsigned("0000" &  in_vec(0,2))+
		unsigned("0000" & in_vec(1,0))+ unsigned("0000" & in_vec(1,1))+ unsigned("0000" & in_vec(1,2))+
		unsigned("0000" & in_vec(2,0))+ unsigned("0000" & in_vec(2,1))+ unsigned("0000" & in_vec(2,2)));

	
end Behavioral;

-------------------------------------------------------

---testbench---

library q1;
use q1.C_array.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

entity sum_tb is
end sum_tb;

architecture TB_ARCHITECTURE of sum_tb is
	component sum
	port(
		in_vec : in custom_type;
		out_vec : out STD_LOGIC_VECTOR(0 to 7) );
	end component;

	signal in_vec : custom_type;
	signal out_vec : STD_LOGIC_VECTOR(0 to 7);


begin

	UUT : sum
		port map (
			in_vec => in_vec,
			out_vec => out_vec
		);

	-- Add your stimulus here ...
	
		process
	begin 
		wait for 100ns;	
		in_vec(0,0) <= "0001";	
		in_vec(0,1) <= "0000";
		in_vec(0,2) <= "0000";
		in_vec(1,0) <= "0000";
		in_vec(1,1) <= "0000";
		in_vec(1,2) <= "0000";
		in_vec(2,0) <= "0000";
		in_vec(2,1) <= "0000";
		in_vec(2,2) <= "0000";	
		wait;
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_sum of sum_tb is
	for TB_ARCHITECTURE
		for UUT : sum
			use entity work.sum(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_sum;