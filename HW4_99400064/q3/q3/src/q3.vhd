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
