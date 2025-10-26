 library ieee; 
 
 use ieee.std_logic_1164.all;
 
 entity UnaryToBinary is
    Port ( unary_input : in  std_logic_vector(15 downto 0);
           binary_output : out  std_logic_vector(3 downto 0));
end UnaryToBinary;
 
architecture Behavioral of UnaryToBinary is
begin
 
    convert : process(unary_input)
    begin
        case unary_input is
            when "0000000000000000" =>
                binary_output <= "0000";
            when "0000000000000001" =>
                binary_output <= "0001";
            when "0000000000000011" =>
                binary_output <= "0010";
            when "0000000000000111" =>
                binary_output <= "0011";
            when "0000000000001111" =>
                binary_output <= "0100";
            when "0000000000011111" =>
                binary_output <= "0101";
            when "0000000000111111" =>
                binary_output <= "0110";
            when "0000000001111111" =>
                binary_output <= "0111";
            when "0000000011111111" =>
                binary_output <= "1000";
            when "0000000111111111" =>
                binary_output <= "1001";
            when "0000001111111111" =>
                binary_output <= "1010";
            when "0000011111111111" =>
                binary_output <= "1011";
            when "0000111111111111" =>
                binary_output <= "1100";
            when "0001111111111111" =>
                binary_output <= "1101";
            when "0011111111111111" =>
                binary_output <= "1110";
            when others =>
                binary_output <= "1111";
        end case;
    end process;
 
end Behavioral;

------------------------------------------------
---testbench---

  library ieee;
use ieee.std_logic_1164.all;

entity unarytobinary_tb is
end unarytobinary_tb;

architecture TB_ARCHITECTURE of unarytobinary_tb is
	component unarytobinary
	port(
		unary_input : in STD_LOGIC_VECTOR(15 downto 0);
		binary_output : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	signal unary_input : STD_LOGIC_VECTOR(15 downto 0);
	signal binary_output : STD_LOGIC_VECTOR(3 downto 0);

begin

	UUT : unarytobinary
		port map (
			unary_input => unary_input,
			binary_output => binary_output
		);
   
	process
	begin  
		wait for 100ns;
		unary_input <= "0000000000111111";
		wait for 100ns;
		unary_input <= "0000000001111111";
	    wait for 100ns;
		unary_input <= "0000000011111111";
		--other input
			
	end process;	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_unarytobinary of unarytobinary_tb is
	for TB_ARCHITECTURE
		for UUT : unarytobinary
			use entity work.unarytobinary(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_unarytobinary;