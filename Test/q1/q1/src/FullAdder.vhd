library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    port (
        A, B, Cin : in std_logic;
        Sum, Cout : out std_logic
    );
end FullAdder;

architecture Behavioral of FullAdder is
begin
    Sum <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end Behavioral;
