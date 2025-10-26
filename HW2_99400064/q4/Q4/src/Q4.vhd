library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
use IEEE.numeric_std.all;

entity alarm_clock is
    Port ( clk,reset,set : in  std_logic;
		   hours_in: in std_logic_vector(5 downto 0);
		   minutes_in: in std_logic_vector(7 downto 0);
		   alarm_hours_in: in std_logic_vector(5 downto 0);
		   alarm_minutes_in: in std_logic_vector(7 downto 0);
		   alarm_set: in std_logic;
		   alarm_stop: in std_logic;
		   on_alarm: out std_logic;
		   hour0_output: out std_logic_vector(3 downto 0);
		   hour1_output: out std_logic_vector(1 downto 0);
		   min0_output: out std_logic_vector(3 downto 0);
		   min1_output: out std_logic_vector(3 downto 0));
end alarm_clock;

architecture Behavioral of alarm_clock is

signal count_seconds : integer range 0 to 59 := 0;
signal count_minutes : integer range 0 to 59 := 0;
signal count_hours : integer range 0 to 23 := 0;

begin

process(clk,reset,set)
	variable dh0 : std_logic_vector(3 downto 0);	
	variable dh1 : std_logic_vector(1 downto 0);	
	variable dm0 : std_logic_vector(3 downto 0);	
	variable dm1 : std_logic_vector(3 downto 0);	
begin
    if(reset='1') then
        count_seconds <= 0;
        count_minutes <= 0;
        count_hours <= 0;
	elsif ( set='1' ) then
	    count_seconds <= 0;
        count_minutes <= to_integer(unsigned(minutes_in(7 downto 4))) * 10 + to_integer(unsigned(minutes_in(3 downto 0)));
        count_hours <= to_integer(unsigned(hours_in(5 downto 4))) * 10 + to_integer(unsigned(hours_in(3 downto 0)));
    elsif(rising_edge(clk)) then
        if(count_seconds = 59) then
            count_seconds <= 0;
            if(count_minutes = 59) then
                count_minutes <= 0;
                if(count_hours = 23) then
                    count_hours <= 0;
                else
                    count_hours <= count_hours +1;
                end if;
            else
                count_minutes <= count_minutes +1;
            end if;
        else
            count_seconds <= count_seconds +1;
        end if; 
    end if; 
	dh0 := std_logic_vector(to_unsigned(count_hours mod 10,4));
	dh1 := std_logic_vector(to_unsigned(count_hours / 10,2));
	dm0 := std_logic_vector(to_unsigned(count_minutes mod 10,4));
	dm1 := std_logic_vector(to_unsigned(count_minutes / 10,4));  
	if ( alarm_set='1' ) then
		if (dh1 & dh0= alarm_hours_in and dm1 & dm0 = alarm_minutes_in) then
			on_alarm <= '1'; 
		end if;
	end if;													 
	if (alarm_stop = '1') then
		on_alarm <= '0';
	end if;
	hour0_output <= dh0;
	hour1_output <= dh1;
	min0_output <= dm0;
	min1_output <= dm1;  
end process;

end Behavioral;