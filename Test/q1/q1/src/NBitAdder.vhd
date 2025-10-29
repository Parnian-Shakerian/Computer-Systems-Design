library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NBitAdder is
    generic (
        N : integer range 2 to 7
    );
    port (
        A, B : in std_logic_vector(N-1 downto 0);
        Cin : in std_logic;
        Sum : out std_logic_vector(N-1 downto 0);
        Cout : out std_logic
    );
end NBitAdder;

architecture Behavioral of NBitAdder is
    component FullAdder is
        port (
            A, B, Cin : in std_logic;
            Sum, Cout : out std_logic
        );
    end component FullAdder;

    signal Carry : std_logic_vector(N downto 0);
begin
    Carry(0) <= Cin;
    FA: for i in 0 to N-1 generate
        FullAdd: FullAdder port map (
            A => A(i),
            B => B(i),
            Cin => Carry(i),
            Sum => Sum(i),
            Cout => Carry(i+1)
        );
    end generate FA;

    Cout <= Carry(N);
end Behavioral;
