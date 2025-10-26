library ieee;
use ieee.std_logic_1164.all;

package q2 is
    
    entity sequence_detectore is
        port (
            clock,input_number : in  std_logic;
            sequence_match : out std_logic);
    end entity;

    architecture FSM of sequence_detectore is
		type states is (s0, s1, s2, s3, s4, s5, s6, s7);
		signal running_state : states;
	    signal next_state    : states;
	    signal pattern_match : std_logic;
    begin
        process (clock)
        begin
            if rising_edge(clock) then running_state <= next_state; pattern_match <= '0';
                if running_state = s7 then pattern_match <= '1';
                end if;
            end if;
        end process;

        process (running_state, input_number)
        begin
            case running_state is 
				
                when S0 => if input_number = '1' then next_state <= S1; else next_state <= S0; end if;
				when S1 => if input_number = '0' then next_state <= S2; else next_state <= S1; end if;	
				when S2 => if input_number = '0' then next_state <= S3;	else next_state <= S2; end if;	 
				when S3 => if input_number = '1' then next_state <= S4; else next_state <= S3; end if;
				when S4 => if input_number = '0' then next_state <= S5; else next_state <= S4; end if;
				when S5 => if input_number = '0' then next_state <= S6; else next_state <= S5; end if;
				when S6 => if input_number = '1' then next_state <= S7;	else next_state <= S6; end if;
				when s7 => next_state <= s7;
			end case;
        end process;
	   sequence_match <= pattern_match;
	 end architecture;
	
	entity second_sequence_detectore is
        port (
            clock   : in  std_logic;
            input_number : in  std_logic;
            sequence_match : out std_logic);
    end entity;

    architecture FSM2 of second_sequence_detectore is
		type states is (s0, s1, s2, s3, s4, s5);
		signal running_state : states;
	    signal next_state    : states;
	    signal pattern_match : std_logic;
    begin
        process (clock)
        begin
            if rising_edge(clock) then running_state <= next_state;	pattern_match <= '0';
                if running_state = s5 then pattern_match <= '1';
                end if;
            end if;
        end process;

        process (running_state, input_number)
        begin
            case running_state is 
				
                when S0 => if input_number = '0' then next_state <= S1;	else next_state <= S0; end if;
				when S1 => if input_number = '0' then next_state <= S2;	else next_state <= S1; end if;	
				when S2 => if input_number = '1' then next_state <= S3; else next_state <= S2; end if;	 
				when S3 => if input_number = '0' then next_state <= S4;	else next_state <= S3; end if;
				when S4 => if input_number = '0' then next_state <= S5;	else next_state <= S4; end if;
				when S5 => next_state <= s5;
			end case;
        end process;
	   sequence_match <= pattern_match;
	 end architecture;
	
	function bits (input_number_vector : in std_logic_vector) return std_logic_vector;
	function add_no_ones (input_number_vector : in std_logic_vector, n : in integer) return std_logic_vector;
end package q2; 

package body q2 is
	
	function bits(input_number_vector : in std_logic_vector) return std_logic_vector is
	    variable out_vec : std_logic_vector(input_number_vector'length - 1 downto 0);
	begin
	    for i in input_number_vector'range loop
	        if input_number_vector(i) = '0' then out_vec(i) := '1';	else out_vec(i) := '0';	end if;
	    end loop;
	  return out_vec;
	end function;
	
	function add_no_ones(input_number_vector : in std_logic_vector, n : in integer) return std_logic_vector is
	    variable out_vec : std_logic_vector(input_number_vector'length - 1 downto 0);
	    variable carry : std_logic := '1';
	begin
	    for i in input_number_vector'range loop
	        if input_number_vector(i) = '0' and carry = '1' then out_vec(i) := '1';	carry := '0';
	        elsif input_number_vector(i) = '1' and carry = '1' then	out_vec(i) := '0'; carry := '1';
	        else out_vec(i) := input_number_vector(i);
	       end if;
	    end loop;
	  return out_vec(n downto 0);
	end function;	
end package body;


library ieee;
use ieee.std_logic_1164.all;
use work.q2.all;

entity fsm_dec is
	generic(n : integer)
	port(
	clock : in std_logic;
	input_number : in std_logic_vector(n downto 0);
	output : out std_logic_vector(n downto 0));
end entity;

architecture behavioral of fsm_dec is
	component sequence_detectore is
        port (
            clock   : in  std_logic;
            input_number : in  std_logic;
            sequence_match : out std_logic);
    end component;
	component second_sequence_detectore is
        port (
            clock   : in  std_logic;
            input_number : in  std_logic;
            sequence_match : out std_logic);
    end component;
	
	signal first_match : std_logic := '0';
	signal second_match : std_logic := '0';	
	shared variable out_vec : std_logic_vector(n downto 0) := (others => '0');

begin
	process(clock)
		
	begin		 
		for i in input_number'Range loop
			
			first_detector : sequence_detectore
                port map (
                    clock   => clock,
                    input_number => input_number(i),
                    sequence_match => first_match);
				
			second_detector : second_sequence_detectore
                port map (
                    clock   => clock,
                    input_number => input_number(i),
                    sequence_match => second_match);
		end loop;
		
		if first_match = '1' then out_vec <= bits(input_number);
		else if second_sequence_detectore = '1' then out_vec <= add_no_ones(input_number, n);
		else out_vec <= input_number;
		end if;
	end process
   output <=  out_vec;
end architecture;	