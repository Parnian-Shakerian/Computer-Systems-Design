library ieee;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package complexOFnum is	
	type custom_type is array(0 to 1) of integer;
end;

library ieee; 
library Q5;
use Q5.complexOFnum.all;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Q5 is	
    port (
	a,b : in custom_type;	
	signal_of_sum,signal_of_sub,signal_of_mul: in std_logic;
	output : out custom_type
	);
end Q5;

architecture Behavioral of Q5 is
begin	
	output(0)<=	 
	a(0) + b(0) when ( signal_of_sum = '1' ) else
	a(0) - b(0) when ( signal_of_sub = '1' ) else
	(a(0) * b(0)) - (a(1) * b(1)) when ( signal_of_mul = '1' );	
	
	output(1)<=	 
	a(1) + b(1) when ( signal_of_sum = '1' ) else
	a(1) - b(1) when ( signal_of_sub = '1' ) else
	(a(0) * b(1)) - (a(1) * b(0)) when ( signal_of_mul = '1' );	

	
end Behavioral;

--------------------------------------------------------------

---testbench---

library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
library q5;
use q5.complexOFnum.all;
library ieee;
use ieee.std_logic_1164.all;


entity q5_tb is
end q5_tb;

architecture TB_ARCHITECTURE of q5_tb is

	component q5
	port(
		a : in custom_type;
		b : in custom_type;
		signal_of_sum : in STD_LOGIC;
		signal_of_sub : in STD_LOGIC;
		signal_of_mul : in STD_LOGIC;
		output : out custom_type );
	end component;

	signal a : custom_type;
	signal b : custom_type;
	signal signal_of_sum : STD_LOGIC;
	signal signal_of_sub : STD_LOGIC;
	signal signal_of_mul : STD_LOGIC;
	signal output : custom_type;

begin

	UUT : q5
		port map (
			a => a,
			b => b,
			signal_of_sum => signal_of_sum,
			signal_of_sub => signal_of_sub,
			signal_of_mul => signal_of_mul,
			output => output
		);

	-- Add your stimulus here ... 
		process
	begin 
		wait for 100ns;	
		a(0)<= 1;
		a(1)<= 0;	  
		b(0)<= 2;
		b(1)<= 1;
		signal_of_sum <= '1';
		signal_of_sub <= '0';
		signal_of_mul <= '0';	
		wait for 100ns;	
		a(0)<= 3;
		a(1)<= 3;	  
		b(0)<= 0;
		b(1)<= 2;
		signal_of_sum <= '0';
		signal_of_sub <= '1';
		signal_of_mul <= '0';
		wait for 100ns;	
		a(0)<= 1;
		a(1)<= 3;	  
		b(0)<= 0;
		b(1)<= 2;
		signal_of_sum <= '0';
		signal_of_sub <= '1';
		signal_of_mul <= '0';
		wait;
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_q5 of q5_tb is
	for TB_ARCHITECTURE
		for UUT : q5
			use entity work.q5(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_q5;
