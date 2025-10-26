library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port (
	a:in std_logic_vector(1 downto 0);
	b:in std_logic_vector(1 downto 0);
	ctrl:in std_logic_vector(1 downto 0);
	res:out std_logic_vector(1 downto 0)
		);
end ALU;

architecture behavior of ALU is	
signal temp : signed(2 downto 0);
begin
	res<=std_logic_vector(unsigned(a) + unsigned(b)) when ctrl = "00" else
		 std_logic_vector(unsigned(a) - unsigned(b)) when ctrl = "01" else
		 a and b when ctrl = "10" else
		 a or b when ctrl = "11";
end behavior;

------------------------------------------------------------------

---testbench---


library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	component alu
	port(
		a : in STD_LOGIC_VECTOR(1 downto 0);
		b : in STD_LOGIC_VECTOR(1 downto 0);
		ctrl : in STD_LOGIC_VECTOR(1 downto 0);
		res : out STD_LOGIC_VECTOR(1 downto 0) );
	end component;

	signal a : STD_LOGIC_VECTOR(1 downto 0);
	signal b : STD_LOGIC_VECTOR(1 downto 0);
	signal ctrl : STD_LOGIC_VECTOR(1 downto 0);
	signal res : STD_LOGIC_VECTOR(1 downto 0);

begin

	UUT : alu
		port map (
			a => a,
			b => b,
			ctrl => ctrl,
			res => res
		);

	-- Add your stimulus here ...	
	
	  process
	begin
		wait for 100ns;
		a<="00";
		b<="00";
		ctrl<="00";
		wait for 100ns;
		a<="00";
		b<="01";
		ctrl<="00";		
		wait for 100ns;
		a<="01";
		b<="00";
		ctrl<="00";
		wait for 100ns;
		a<="01";
		b<="01";
		ctrl<="00";		
		wait for 100ns;
		a<="10";
		b<="00";
		ctrl<="00";
		wait for 100ns;
		a<="10";
		b<="01";
		ctrl<="00";		
		wait for 100ns;
		a<="11";
		b<="00";
		ctrl<="00";
		wait for 100ns;
		a<="11";
		b<="01";
		ctrl<="00";		
		wait for 100ns;
		a<="00";
		b<="00";
		ctrl<="01";
		wait for 100ns;
		a<="00";
		b<="01";
		ctrl<="01";		
		wait for 100ns;
		a<="01";
		b<="00";
		ctrl<="01";
		wait for 100ns;
		a<="01";
		b<="01";
		ctrl<="01";		
		wait for 100ns;
		a<="10";
		b<="00";
		ctrl<="01";
		wait for 100ns;
		a<="10";
		b<="01";
		ctrl<="01";		
		wait for 100ns;
		a<="11";
		b<="00";
		ctrl<="01";
		wait for 100ns;
		a<="11";
		b<="01";
		ctrl<="01";		
		wait for 100ns;
		a<="00";
		b<="00";
		ctrl<="10";
		wait for 100ns;
		a<="00";
		b<="01";
		ctrl<="10";		
		wait for 100ns;
		a<="01";
		b<="00";
		ctrl<="10";
		wait for 100ns;
		a<="01";
		b<="01";
		ctrl<="10";		
		wait for 100ns;
		a<="10";
		b<="00";
		ctrl<="10";
		wait for 100ns;
		a<="10";
		b<="01";
		ctrl<="10";		
		wait for 100ns;
		a<="11";
		b<="00";
		ctrl<="10";
		wait for 100ns;
		a<="11";
		b<="01";
		ctrl<="10";	
		wait for 100ns;
		a<="00";
		b<="00";
		ctrl<="11";
		wait for 100ns;
		a<="00";
		b<="01";
		ctrl<="11";
		wait for 100ns;
		a<="01";
		b<="00";
		ctrl<="11";
		wait for 100ns;
		a<="01";
		b<="01";
		ctrl<="11";
		wait for 100ns;
		a<="10";
		b<="00";
		ctrl<="11";
		wait for 100ns;
		a<="10";
		b<="01";
		ctrl<="11";		
		wait for 100ns;
		a<="11";
		b<="00";
		ctrl<="11";
		wait for 100ns;
		a<="11";
		b<="01";
		ctrl<="11";
		
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(behavior);
		end for;
	end for;
end TESTBENCH_FOR_alu;