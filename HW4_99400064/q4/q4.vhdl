library ieee;
use ieee.std_logic_1164.all;

entity convert is
    Port (
        binary_input : in  std_logic_vector(2 downto 0);
        unary_output : out std_logic_vector(7 downto 0));
end convert;

architecture Behavioral of convert is
begin
    process (binary_input)
    begin
        case binary_input is
            when "000" =>
                unary_output <= "00000000";
            when "001" =>
                unary_output <= "00000001";
            when "010" =>
                unary_output <= "00000011";
            when "011" =>
                unary_output <= "00000111";
            when "100" =>
                unary_output <= "00001111";
            when "101" =>
                unary_output <= "00011111";
            when "110" =>
                unary_output <= "00111111";
            when "111" =>
                unary_output <= "01111111";
            when others =>
                unary_output <= "11111111";
        end case;
    end process;
end Behavioral;	 
---------------------------------------------------
---testbench---
library ieee;
use ieee.std_logic_1164.all;

entity convert_tb is
end convert_tb;

architecture TB_ARCHITECTURE of convert_tb is
    component convert
    port (
        binary_input : in  std_logic_vector(2 downto 0);
        unary_output : out std_logic_vector(7 downto 0));
    end component;

    signal binary_input : std_logic_vector(2 downto 0);
    signal unary_output : std_logic_vector(7 downto 0);

begin

    UUT : convert
    port map (
        binary_input => binary_input,
        unary_output => unary_output);

    -- Stimulus process
    process
    begin
        -- Test case 1
        --binary_input <= "001";
        --wait for 10 ns;

        -- Test case 2
        --binary_input <= "010";
        --wait for 10 ns;

        -- Test case 3
        binary_input <= "100";
        wait for 10 ns;

        wait;
    end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_convert of convert_tb is
    for TB_ARCHITECTURE
        for UUT : convert
            use entity work.convert(behavioral);
        end for;
    end for;
end TESTBENCH_FOR_convert;
