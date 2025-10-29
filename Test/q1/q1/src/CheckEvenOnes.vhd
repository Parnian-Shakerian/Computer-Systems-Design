library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CheckEvenOnes is
    port (
        A : in std_logic_vector(7 downto 0);
        EvenOnes : out std_logic
    );
end CheckEvenOnes;

architecture Behavioral of CheckEvenOnes is
    signal OnesCount : integer range 0 to 8;
begin
    process(A)
    begin
        OnesCount <= 0;
        for i in A'range loop
            if A(i) = '1' then
                OnesCount <= OnesCount + 1;
            end if;
        end loop;
    end process;

    EvenOnes <= '1' when OnesCount mod 2 = 0 else '0';
end Behavioral;
