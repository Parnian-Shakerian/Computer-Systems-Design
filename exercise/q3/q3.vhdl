library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

-- c) Use a block statement to write a VHDL description for this flip-flop.
entity special_flip_flop is
    port(
        T: in bit;
        D: in bit;
        R: in bit;
        Clock: in bit;
        TQ: inout bit;
        DQ: out bit
    );
end special_flip_flop;

architecture behavior of special_flip_flop is
    -- a) Declare the TD record containing two bits for the flip-flop outputs.
    type TD is record
        TQ: bit;
        DQ: bit;
    end record;

    -- b) Declare an array with bit-type indices and elements of type TD.
    type TD_array is array(bit, bit, bit) of TD;
    signal lookup_table: TD_array;
begin  
	lookup_table('0', '0', '0') <= (TQ => TQ, DQ => '0');
    lookup_table('0', '0', '1') <= (TQ => TQ, DQ => '1');
    lookup_table('0', '1', '0') <= (TQ => '0', DQ => '0');
    lookup_table('0', '1', '1') <= (TQ => '0', DQ => '0');
    lookup_table('1', '0', '0') <= (TQ => not TQ, DQ => '0');
    lookup_table('1', '0', '1') <= (TQ => not TQ, DQ => '1');
    lookup_table('1', '1', '0') <= (TQ => '0', DQ => '0');
    lookup_table('1', '1', '1') <= (TQ => '0', DQ => '0');
    process(Clock)
	variable next_state: TD;
    begin
        if Clock'event and Clock = '1' then
            next_state := lookup_table(T, R, D);
            TQ <= next_state.TQ;
            DQ <= next_state.DQ;
        end if;
    end process;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;

entity special_flip_flop_tb is
end special_flip_flop_tb;

architecture behavior of special_flip_flop_tb is
    component special_flip_flop is
        port(
            T: in bit;
            D: in bit;
            R: in bit;
            Clock: in bit;
            TQ: inout bit;
            DQ: out bit
        );
    end component;

    signal T: bit := '0';
    signal D: bit := '0';
    signal R: bit := '0';
    signal Clock: bit := '0';
    signal TQ: bit;
    signal DQ: bit;

    constant clock_period: time := 10 ns;
begin
    uut: special_flip_flop
        port map(
            T => T,
            D => D,
            R => R,
            Clock => Clock,
            TQ => TQ,
            DQ => DQ
        );

    clock_process: process
    begin
        Clock <= '0';
        wait for clock_period / 2;
        Clock <= '1';
        wait for clock_period / 2;
    end process;

    stimulus_process: process
    begin
        -- Test case 1: Reset outputs
        R <= '1';
        wait for clock_period;
        assert (TQ = '0' and DQ = '0') report "Test case 1 failed" severity error;

        -- Test case 2: Transfer D to DQ
        R <= '0';
        D <= '1';
        wait for clock_period;
        assert (DQ = '1') report "Test case 2 failed" severity error;

        -- Test case 3: Toggle TQ
        T <= '1';
        wait for clock_period;
        assert (TQ = '1') report "Test case 3 failed" severity error;

        -- Test case 4: Reset outputs again
        R <= '1';
        wait for clock_period;
        assert (TQ = '0' and DQ = '0') report "Test case 4 failed" severity error;

        -- End of test
        wait;
    end process;
end behavior;
