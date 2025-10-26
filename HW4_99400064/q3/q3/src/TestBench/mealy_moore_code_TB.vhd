library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture behavior of testbench is
    -- Constants
    constant CLOCK_PERIOD: time := 10 ns;  -- Clock period
    constant RESET_PERIOD: time := 20 ns;  -- Reset period

    -- Component declaration
    component mealy_code is
        port (
            clock, reset, input : in std_logic;
            output : out std_logic
        );
    end component;

    -- Signals
    signal clock_signal : std_logic := '0';
    signal reset_signal : std_logic := '0';
    signal input_signal : std_logic := '0';
    signal output_signal : std_logic;

begin
    -- Instantiate the DUT (Device Under Test)
    dut : mealy_code
        port map (
            clock => clock_signal,
            reset => reset_signal,
            input => input_signal,
            output => output_signal
        );

    -- Clock generation process
    clock_process : process
    begin
        while now < 1000 ns loop  -- Simulate for 1000 ns
            clock_signal <= '0';
            wait for CLOCK_PERIOD / 2;
            clock_signal <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Reset generation process
    reset_process : process
    begin
        reset_signal <= '1';
        wait for RESET_PERIOD;
        reset_signal <= '0';
        wait;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        wait for RESET_PERIOD + CLOCK_PERIOD;  -- Wait for reset to complete

        -- Test case 1
        input_signal <= '0';
        wait for CLOCK_PERIOD;
        assert output_signal = '0' report "Test case 1 failed!" severity error;

        -- Test case 2
        input_signal <= '1';
        wait for CLOCK_PERIOD;
        assert output_signal = '0' report "Test case 2 failed!" severity error;

        -- Test case 3
        input_signal <= '1';
        wait for CLOCK_PERIOD;
        assert output_signal = '0' report "Test case 3 failed!" severity error;

        -- Test case 4
        input_signal <= '1';
        wait for CLOCK_PERIOD;
        assert output_signal = '1' report "Test case 4 failed!" severity error;

        -- Test case 5
        input_signal <= '0';
        wait for CLOCK_PERIOD;
        assert output_signal = '0' report "Test case 5 failed!" severity error;

        -- Test case 6
        input_signal <= '1';
        wait for CLOCK_PERIOD;
        assert output_signal = '0' report "Test case 6 failed!" severity error;

        -- Test case 7
        input_signal <= '0';
        wait for CLOCK_PERIOD;
        assert output_signal = '0' report "Test case 7 failed!" severity error;

        -- Test case 8
        input_signal <= '0';
        wait for CLOCK_PERIOD;
        assert output_signal = '0' report "Test case 8 failed!" severity error;

        wait;
    end process;

end architecture;


