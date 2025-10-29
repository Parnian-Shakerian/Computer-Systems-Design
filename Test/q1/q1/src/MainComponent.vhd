library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MainComponent is
    generic (
        N : integer range 2 to 7
    );
    port (
        A, B : in std_logic_vector(7 downto 0);
        C : out std_logic_vector(7 downto 0)
    );
end MainComponent;

architecture Behavioral of MainComponent is
    component NBitAdder is
        generic (
            N : integer range 2 to 7
        );
        port (
            A, B : in std_logic_vector(N-1 downto 0);
            Cin : in std_logic;
            Sum : out std_logic_vector(N-1 downto 0);
            Cout : out std_logic
        );
    end component NBitAdder;

    component OutputGenerator is
        generic (
            N : integer range 2 to 7
        );
        port (
            A, B : in std_logic_vector(N-1 downto 0);
            Result : out std_logic_vector(N downto 0)
        );
    end component OutputGenerator;

    component CheckEvenOnes is
        port (
            A : in std_logic_vector(7 downto 0);
            EvenOnes : out std_logic
        );
    end component CheckEvenOnes;

    signal Sum : std_logic_vector(N-1 downto 0);
    signal Cout : std_logic;
    signal Result : std_logic_vector(N downto 0);
    signal EvenOnes : std_logic;

begin
    Adder : NBitAdder generic map (N)
        port map (
            A => A(N-1 downto 0),
            B => B(N-1 downto 0),
            Cin => '0',
            Sum => Sum,
            Cout => Cout
        );

    OutputGen : OutputGenerator generic map (N)
        port map (
            A => A(N-1 downto 0),
            B => B(N-1 downto 0),
            Result => Result
        );

    CheckOnes : CheckEvenOnes
        port map (
            A => A,
            EvenOnes => EvenOnes
        );

    C <= Result(N-1 downto 0) & Sum;

end Behavioral;
