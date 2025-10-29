library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OutputGenerator is
    generic (
        N : integer range 2 to 7
    );
    port (
        A, B : in std_logic_vector(N-1 downto 0);
        Result : out std_logic_vector(N downto 0)
    );
end OutputGenerator;

architecture Behavioral of OutputGenerator is
begin
    Result <= '0' & (not A) & B;
end Behavioral;
