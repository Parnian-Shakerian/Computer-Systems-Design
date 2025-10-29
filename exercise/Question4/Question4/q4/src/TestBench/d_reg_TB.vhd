LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY tb_d_reg IS
END tb_d_reg;

ARCHITECTURE behavior OF tb_d_reg IS 
    COMPONENT d_reg
        PORT(
            d : IN  bit_vector(7 downto 0);
            clk : IN  bit;
            q_vec : OUT  bit_vector(7 downto 0)
        );
    END COMPONENT;

    signal d : bit_vector(7 downto 0) := (others => '0');
    signal clk : bit := '0';
    signal q_vec : bit_vector(7 downto 0);

    constant clk_period : time := 10 ns;
BEGIN
    uut: d_reg PORT MAP (
        d => d,
        clk => clk,
        q_vec => q_vec
    );

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
		wait for clk_period/2;
        wait for clk_period*2;
        d <= "00000001";
        wait for clk_period*2;
        d <= "00000010";
        
        wait;
    end process; 
	

END behavior;