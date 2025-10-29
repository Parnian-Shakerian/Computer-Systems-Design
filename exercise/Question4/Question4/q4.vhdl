library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY jkff IS
PORT (j, k, clk, rst : IN STD_LOGIC; q : OUT STD_LOGIC);
END jkff;

ARCHITECTURE behavioral OF jkff IS
BEGIN
  PROCESS (clk, rst)
  BEGIN
    IF (rst = '1') THEN
      q <= '0';
    ELSIF (clk'EVENT AND clk = '1') THEN
      IF (j = '1' AND k = '0') THEN
        q <= '1';
      ELSIF (j = '0' AND k = '1') THEN
        q <= '0';
      ELSIF (j = '1' AND k = '1') THEN
        q <= NOT q;
      END IF;
    END IF;
  END PROCESS;
END behavioral;

ENTITY eight_bit_d_register IS
PORT (d_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      clock, reset : IN STD_LOGIC;
      q_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END eight_bit_d_register;

ARCHITECTURE behavioral OF eight_bit_d_register IS
  COMPONENT jkff IS
    PORT (j, k, clk, rst : IN STD_LOGIC; q : OUT STD_LOGIC);
  END COMPONENT;
  
  SIGNAL j_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL k_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL q_temp : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
  -- Generate 8 JK flip-flops
  gen_jkff: FOR i IN 0 TO 7 GENERATE
    jkff_inst : jkff PORT MAP (j => j_in(i), k => k_in(i), clk => clock, rst => reset, q => q_temp(i));
  END GENERATE;

  -- Connect D input to J input and its complement to K input
  j_in <= d_in;
  k_in <= NOT d_in;

  -- Output the Q values
  q_out <= q_temp;
END behavioral;

-- Testbench for eight_bit_d_register entity
ENTITY tb_eight_bit_d_register IS
END tb_eight_bit_d_register;

ARCHITECTURE behavior OF tb_eight_bit_d_register IS
  SIGNAL d_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL clock : STD_LOGIC := '0';
  SIGNAL reset : STD_LOGIC := '0';
  SIGNAL q_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
  uut: eight_bit_d_register PORT MAP (d_in => d_in, clock => clock, reset => reset, q_out => q_out);
  
  -- Clock generation
  clk_process: PROCESS
  BEGIN
    WHILE (TRUE) LOOP
      clock <= NOT clock;
      WAIT FOR 10 ns;
    END LOOP;
  END PROCESS;
  
  -- Stimulus process
  stim_proc: PROCESS
  BEGIN
    WAIT FOR 100 ns;
    
    d_in <= "10101010";
    
    WAIT FOR 100 ns;
    
    d_in <= "01010101";
    
    WAIT FOR 100 ns;
    
    reset <= '1';
    WAIT FOR 10 ns;
    reset <= '0';
    
    WAIT;
  END PROCESS;
END behavior;