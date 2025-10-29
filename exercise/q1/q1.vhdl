library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port (
        clk: in std_logic;
        clear: in std_logic; -- asynchronous clear (active high)
        preset: in std_logic; -- synchronous preset (active low)
        count: in std_logic; -- synchronous count (active high)
        q: out unsigned(11 downto 0) -- 12-bit counter output
    );
end counter;

architecture behavioral of counter is
    signal counter_value: unsigned(11 downto 0);
begin
    process(clk, clear)
    begin
        if clear = '1' then -- asynchronous clear
            counter_value <= (others => '0');
        elsif falling_edge(clk) then -- synchronous operations on falling edge of clock
            if preset = '0' then -- synchronous preset
                counter_value <= to_unsigned(67, 12);
            elsif count = '1' then -- synchronous count
                counter_value <= counter_value + 7;
            end if;
        end if;
    end process;

    q <= counter_value; -- assign counter value to output
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture behavioral of counter_tb is
    -- component declaration for the unit under test (UUT)
    component counter
        port (
            clk: in std_logic;
            clear: in std_logic;
            preset: in std_logic;
            count: in std_logic;
            q: out unsigned(11 downto 0)
        );
    end component;

    -- inputs
    signal clk: std_logic := '0';
    signal clear: std_logic := '0';
    signal preset: std_logic := '1';
    signal count: std_logic := '0';

    -- output
    signal q: unsigned(11 downto 0);

    -- clock period definition
    constant clk_period: time := 10 ns;

begin
    -- instantiate the unit under test (UUT)
    uut: counter port map (
        clk => clk,
        clear => clear,
        preset => preset,
        count => count,
        q => q
    );

    -- clock process definition
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns
        clear <= '1';
        wait for 100 ns;

        -- release reset and wait for 50 ns
        clear <= '0';
        wait for 50 ns;

        -- apply preset and wait for 50 ns
        preset <= '0';
        wait for 50 ns;

        -- release preset and wait for 50 ns
        preset <= '1';
        wait for 50 ns;

        -- apply count and wait for 100 ns
        count <= '1';
        wait for 100 ns;

        -- stop the simulation
        wait;
    end process;
end behavioral;
