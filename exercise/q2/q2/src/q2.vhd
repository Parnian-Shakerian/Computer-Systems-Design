library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ha is
    port (
        a, b: in std_logic;
        sum, carry: out std_logic
    );
end ha;

architecture behavioral of ha is
begin
    sum <= a xor b;
    carry <= a and b;
end behavioral;





library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fa is
    port (
        a, b, cin: in std_logic;
        sum, cout: out std_logic
    );
end fa;

architecture behavioral of fa is
begin
    sum <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end behavioral;






library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_adder is
    port (
        a, b: in std_logic_vector(3 downto 0);
        sum: out std_logic_vector(3 downto 0);
        carry: out std_logic
    );
end bcd_adder;

architecture behavioral of bcd_adder is
    component ha is
        port (
            a, b: in std_logic;
            sum, carry: out std_logic
        );
    end component;
    
    component fa is
        port (
            a, b, cin: in std_logic;
            sum, cout: out std_logic
        );
    end component;
    
    signal c1, c2, c3: std_logic;
begin
    u1: ha port map (a(0), b(0), sum(0), c1);
    u2: fa port map (a(1), b(1), c1, sum(1), c2);
    u3: fa port map (a(2), b(2), c2, sum(2), c3);
    u4: fa port map (a(3), b(3), c3, sum(3), carry);
end behavioral;	


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_sum is
    generic (n: integer := 3);
    port (
        a: in std_logic_vector(10 * n * 4 - 1 downto 0);
        sum: out integer;
		sum_vec :out std_logic_vector(n * 4 - 1 downto 0)
    );
end bcd_sum;

architecture behavioral of bcd_sum is
    component bcd_adder is
        port (
            a, b: in std_logic_vector(3 downto 0);
            sum: out std_logic_vector(3 downto 0);
            carry: out std_logic
        );
    end component;
    
    signal temp_sum: std_logic_vector(n * 4 - 1 downto 0) := (others => '0');
    signal carry: std_logic;
begin
    adder_loop: for i in 0 to 9 generate
        digit_loop: for j in 0 to n - 1 generate
            u: bcd_adder port map (
                a(i * n * 4 + j * 4 + 3 downto i * n * 4 + j * 4),
                temp_sum(j * 4 + 3 downto j * 4),
                temp_sum(j * 4 + 3 downto j * 4),
                carry
            );
        end generate;
    end generate;
	   sum_vec <= temp_sum;
    sum <= to_integer(unsigned(temp_sum));
end behavioral;