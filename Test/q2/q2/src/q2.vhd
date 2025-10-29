library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package q2 is

    function addition(a, b : std_logic_vector(7 downto 0)) return std_logic_vector;
    function subtraction(a, b : std_logic_vector(7 downto 0)) return std_logic_vector;

end q2;

package body q2 is

    function addition(a, b : std_logic_vector(7 downto 0)) return std_logic_vector is
        variable sum : std_logic_vector(8 downto 0);
    begin
        sum := (others => '0');
        for i in 0 to 7 loop
            sum(i) := a(i) xor b(i) xor sum(i);
            sum(i + 1) := (a(i) and b(i)) or (sum(i) and (a(i) xor b(i)));
        end loop;
        return sum(7 downto 0);
    end addition;

    function subtraction(a, b : std_logic_vector(7 downto 0)) return std_logic_vector is
        variable diff : std_logic_vector(8 downto 0);
    begin
        diff := (others => '0');
        for i in 0 to 7 loop
            diff(i) := a(i) xor b(i) xor diff(i);
            diff(i + 1) := (not a(i) and b(i)) or (diff(i) and (a(i) xor b(i)));
        end loop;
        return diff(7 downto 0);
    end subtraction;

end q2;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.q2.all;

entity Calculator is
    port (
        a, b : in std_logic_vector(7 downto 0);
        op : in std_logic;
        result : out std_logic_vector(7 downto 0)
    );
end Calculator;

architecture Behavioral of Calculator is
begin
    process (a, b, op)
    begin
        if op = '0' then
            -- Addition operation
            result <= addition(a, b);
        else
            -- Subtraction operation
            result <= subtraction(a, b);
        end if;
    end process;

end Behavioral;