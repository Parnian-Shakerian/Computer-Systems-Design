library ieee;
use ieee.std_logic_1164.all;

entity q1block is
    port(
        clock: in  Std_logic;
        input: in  Bit;
        beginZeroF,beginZeroL,endZeroF,endZeroL: out integer);
end entity;

architecture behavioral of q1block is
    type state_type is (s0, s1, s2, s3, s4); -- Define the possible states of the state machine
    signal state : state_type := s0;
    signal index : integer := 0; -- Counter variable to keep track of the clock cycles 
begin
    process(clock) -- Variables to hold the indices for different occurrences
		variable beginZeroF_index : integer := 0;
	    variable beginZeroL_index   : integer := 0;
	    variable endZeroF_index  : integer := 0;
	    variable endZeroL_index    : integer := 0;
    begin
        if rising_edge(clock) then
		  index <= index + 1;
			case state is -- State machine logic
				when s0 => if input = '1' then state <= s1; else state <= s0; end if;
				when s1 => if input = '1' then state <= s1; else state <= s2; beginZeroF_index := index; end if;
				when s2 => if input = '0' then state <= s2; else state <= s3; beginZeroL_index := index-1; end if;
				when s3 => if input = '1' then state <= s3; else state <= s4; endZeroF_index := index; end if;	
                when s4 => if input = '0' then state <= s4; else state <= s3; endZeroL_index := index -1; end if;	
            end case;
			-- Assign the variable values to the output signals
			beginZeroF <= beginZeroF_index;
	        beginZeroL   <= beginZeroL_index;
	        endZeroF  <= endZeroF_index;
	        endZeroL    <= endZeroL_index;	
        end if;
    end process;
end architecture behavioral;
--------------------------------------------------------
---testbench---
library ieee;
use ieee.std_logic_1164.all;

entity q1block_tb is
end q1block_tb;

architecture TB_ARCHITECTURE of q1block_tb is
    -- Component declaration of the tested unit
    component q1block is
        port (
            clock : in std_logic;
            input : in bit;
            beginZeroF : out integer;
            beginZeroL : out integer;
            endZeroF : out integer;
            endZeroL : out integer
        );
    end component;

    -- Stimulus signals - signals mapped to the input and inout ports of tested entity
    signal clock : std_logic;
    signal input : bit;
    -- Observed signals - signals mapped to the output ports of tested entity
    signal beginZeroF : integer;
    signal beginZeroL : integer;
    signal endZeroF : integer;
    signal endZeroL : integer;

begin

    -- Unit Under Test port map
    UUT : q1block
        port map (
            clock => clock,
            input => input,
            beginZeroF => beginZeroF,
            beginZeroL => beginZeroL,
            endZeroF => endZeroF,
            endZeroL => endZeroL
        );

    -- Stimulus process
    stimulus_proc: process
    begin
        -- Initialize inputs
        clock <= '0';
        input <= '0';

        -- Wait for a few clock cycles
        wait for 5 ns;

        -- Set input to trigger state transitions
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';

        -- Wait for a rising edge of the clock
        wait until rising_edge(clock);

        -- Check the values of the output signals
        assert beginZeroF = 3 report "Error: beginZeroF mismatch" severity error;
        assert beginZeroL = 4 report "Error: beginZeroL mismatch" severity error;
        assert endZeroF = 11 report "Error: endZeroF mismatch" severity error;
        assert endZeroL = 16 report "Error: endZeroL mismatch" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end TB_ARCHITECTURE;
