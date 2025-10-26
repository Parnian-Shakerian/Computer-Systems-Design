library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package recursive_functions is
    function bcd_to_binary(bcd: std_logic_vector) return std_logic_vector;
    function binary_reverser(binary: std_logic_vector) return std_logic_vector;
end package;

package body recursive_functions is
    function bcd_to_binary(bcd: std_logic_vector) return std_logic_vector is
        variable binary: std_logic_vector(bcd'length - 1 downto 0);
        variable bcd_int: integer := to_integer(unsigned(bcd));
    begin
        for i in binary'range loop
            binary(i) := std_logic'val(bcd_int mod 2);
            bcd_int := bcd_int / 2;
        end loop;
        return binary;
    end function;

    function binary_reverser(binary: std_logic_vector) return std_logic_vector is
        variable reversed: std_logic_vector(binary'range);
    begin
        for i in binary'range loop
            reversed(reversed'high - i) := binary(i);
        end loop;
        return reversed;
    end function;
end package body;

----------------------------------------------------- 
--reverse a binary number with length of 5

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.recursive_functions.all;

entity BinaryReverser is
    generic (
        BIT_WIDTH: natural := 5
    );
    port (
        binary_in: in std_logic_vector(BIT_WIDTH - 1 downto 0);
        binary_out: out std_logic_vector(BIT_WIDTH - 1 downto 0)
    );
end entity BinaryReverser;

architecture Behavioral of BinaryReverser is
begin
    binary_out <= binary_reverser(binary_in);
end architecture Behavioral;
