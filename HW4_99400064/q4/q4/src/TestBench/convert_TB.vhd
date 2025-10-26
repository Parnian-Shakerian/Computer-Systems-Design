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
