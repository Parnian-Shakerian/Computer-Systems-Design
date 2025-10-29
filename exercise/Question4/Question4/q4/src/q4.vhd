LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

USE IEEE.std_logic_UNSIGNED.all;
USE ieee.numeric_std.all;

ENTITY jkff IS
	PORT (j, k, c : IN BIT; q : inOUT BIT);
END jkff;
ARCHITECTURE behavior OF jkff IS
BEGIN
    PROCESS (j, k, c)
    BEGIN
        IF c'EVENT AND c = '1' THEN
            IF j = '1' AND k = '0' THEN
                q <= '1';
            ELSIF j = '0' AND k = '1' THEN
                q <= '0';
            ELSIF j = '1' AND k = '1' THEN
                q <= NOT q;
            END IF;
        END IF;
    END PROCESS;
END behavior;


ENTITY d_reg IS
  PORT (d: IN bit_VECTOR(7 DOWNTO 0);
        clk: IN bit;
        q_vec: OUT bit_VECTOR(7 DOWNTO 0));
END d_reg;


ARCHITECTURE behavioral OF d_reg IS	

  COMPONENT jkff IS
    PORT (j, k,c: in Bit; 
	q : inout BIT);
  END COMPONENT;
  signal q_c : bit_vector (7 downto 0):=(
		0 => not d(0),
		1 => not d(1),
		2 => not d(2),
		3 => not d(3),
		4 => not d(4),
		5 => not d(5),
		6 => not d(6),
		7 => not d(7)
	);
  signal q_temp: bit_VECTOR(7 DOWNTO 0);
  BEGIN
	process(clk) 
		
	begin  
--	report bit'image(q_c(0))&bit'image(q_c(1))&bit'image(d(0))&bit'image(d(1))
--		severity NOTE;
		
	end process;	  
	GEN_FF: FOR i IN 0 TO 7 GENERATE
    	jk_instance: jkff PORT MAP (d(i), q_c(i), clk, q_temp(i));
	END GENERATE GEN_FF;
	q_vec <= q_temp;

END behavioral;		