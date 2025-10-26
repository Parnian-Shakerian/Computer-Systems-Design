library ieee;
use ieee.std_logic_1164.all;
--mealy	code q3

entity mealy_code is
    port (
        clock,reset,input : in  std_logic;
        output: out std_logic);
end entity;

architecture behavioral of mealy_code is
    type state_type is (s0, s1, s2, s3);
    signal state : state_type := s0;
begin
    process(clock, reset)
    begin
        if reset = '1' then	state <= s0; output <= '0'; elsif rising_edge(clock) then
            case state is 
				-- Set the output to '0' then Transition to state s1 if input is '1' Stay in state s0 if input is '0'
                when s0 => output <= '0'; if input = '1' then state <= s1; else	state <= s0; end if; 
                when s1 => output <= '0'; if input = '1' then state <= s2; else	state <= s0; end if;
                when s2 => output <= '0'; if input = '1' then state <= s3; else	state <= s0; end if;
                when s3 => state <= s0;	output <= '1';
            end case;
        end if;
    end process;
end architecture behavioral; 
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
--moore	code q3

entity moore_code is
    port (
        clock,input : in  std_logic;
        output: out std_logic);
end entity;

architecture behavioral of moore_code is
    type state_type is (s0, s1, s2, s3);
    signal state : state_type := s0;
begin
    process(clock)
    begin
        if rising_edge(clock) then
            case state is
                when s0 => if input = '1' then state <= s1; output <= '0'; else	state <= s0; output <= '0';	end if;	-- Transition to state s1 if input is '1' Set the output to '0' in state s0 Stay in state s0 if input is '0' Set the output to '0' in state s0
                when s1 => if input = '1' then state <= s2;	output <= '0'; else	state <= s0; output <= '0';	end if; -- Transition to state s2 if input is '1' Set the output to '0' in state s1 Return to state s0 if input is '0' Set the output to '0' in state s1
                when s2 => if input = '1' then state <= s3;	output <= '0'; else	state <= s0; output <= '0';	end if; -- Transition to state s3 if input is '1' Set the output to '0' in state s2 Return to state s0 if input is '0' Set the output to '0' in state s2
                when s3 => if input = '0' then state <= s0;	output <= '1'; else	state <= s0; output <= '0';	end if;	-- Transition back to state s0 if input is '0' Set the output to '1' in state s3 Return to state s0 if input is '1' Set the output to '0' in state s3
            end case;
        end if;
    end process;
end architecture behavioral;

--------------------------------------------------
--testbench--
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