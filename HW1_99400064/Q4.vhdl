library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

 package dot is 
	type dot_type is array (7 downto 0) of integer;
	
 end dot;
 use work.dot.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dot_product is
    port (
        a : in dot_type;
        b : in dot_type;
        result : out integer
    );
end entity;

architecture rtl of dot_product is    
begin
    process (a, b)
        variable temp : integer;
    begin
        temp := 0;
        
        for i in a'range loop
            temp := temp + a(i) * b(i);
        end loop;
        
        result <= temp;
    end process;
    
end architecture;	  
-------------------------------------------------------

---testbench---

library Q4;
use Q4.dot.all;

entity dot_product_tb is
end dot_product_tb;

architecture TB_ARCHITECTURE of dot_product_tb is
	component dot_product
	port(
		a : in dot_type;
		b : in dot_type;
		result : out INTEGER );
	end component;
	signal a : dot_type;
	signal b : dot_type;
	signal result : INTEGER;

begin

	UUT : dot_product
		port map (
			a => a,
			b => b,
			result => result
		);

	-- Add your stimulus here ...  
		process begin 
  wait for 100ns;   
  a(0) <= 1; 
  a(1) <= 0;  
  a(2) <= 0;
  a(3) <= 0;  
  a(4) <= 0;
  a(5) <= 0;
  a(6) <= 0;  
  a(7) <= 0;  
  b(0) <= 1;  
  b(1) <= 0;
  b(2) <= 0;  
  b(3) <= 0;
  b(4) <= 0;  
  b(5) <= 0;
  b(6) <= 0;  
  b(7) <= 0;
  wait; end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_dot_product of dot_product_tb is
	for TB_ARCHITECTURE
		for UUT : dot_product
			use entity work.dot_product(rtl);
		end for;
	end for;
end TESTBENCH_FOR_dot_product;

