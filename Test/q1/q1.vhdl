---MainComponent---
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

---NBitAdder---
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

---OutputGenerator---
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

---CheckEvenOnes---
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

---FullAdder---
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
