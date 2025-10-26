library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

entity alarm_clock_tb is
end alarm_clock_tb;

architecture TB_ARCHITECTURE of alarm_clock_tb is

	component alarm_clock
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		set : in STD_LOGIC;
		hours_in : in STD_LOGIC_VECTOR(5 downto 0);
		minutes_in : in STD_LOGIC_VECTOR(7 downto 0);
		alarm_hours_in : in STD_LOGIC_VECTOR(5 downto 0);
		alarm_minutes_in : in STD_LOGIC_VECTOR(7 downto 0);
		alarm_set : in STD_LOGIC;
		alarm_stop : in STD_LOGIC;
		on_alarm : out STD_LOGIC;
		hour0_output : out STD_LOGIC_VECTOR(3 downto 0);
		hour1_output : out STD_LOGIC_VECTOR(1 downto 0);
		min0_output : out STD_LOGIC_VECTOR(3 downto 0);
		min1_output : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal set : STD_LOGIC := '0';
	signal hours_in : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	signal minutes_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal alarm_hours_in : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	signal alarm_minutes_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal alarm_set : STD_LOGIC := '0';
	signal alarm_stop : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal on_alarm : STD_LOGIC;
	signal hour0_output : STD_LOGIC_VECTOR(3 downto 0);
	signal hour1_output : STD_LOGIC_VECTOR(1 downto 0);
	signal min0_output : STD_LOGIC_VECTOR(3 downto 0);
	signal min1_output : STD_LOGIC_VECTOR(3 downto 0);

begin

	UUT : alarm_clock
		port map (
			clk => clk,
			reset => reset,
			set => set,
			hours_in => hours_in,
			minutes_in => minutes_in,
			alarm_hours_in => alarm_hours_in,
			alarm_minutes_in => alarm_minutes_in,
			alarm_set => alarm_set,
			alarm_stop => alarm_stop,
			on_alarm => on_alarm,
			hour0_output => hour0_output,
			hour1_output => hour1_output,
			min0_output => min0_output,
			min1_output => min1_output
		);

	-- Clock process
	clock_process: process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;

	-- Stimulus process
	stimulus_process: process
	begin
		-- Reset
		reset <= '1';
		wait for 10 ns;
		reset <= '0';
		wait for 10 ns;

		-- Set initial time and alarm
		hours_in <= "000001";
		minutes_in <= "00000000";
		alarm_hours_in <= "000001";
		alarm_minutes_in <= "00000001";
		alarm_set <= '1';
		alarm_stop <= '0';
		wait for 10 ns;

		-- Advance time
		set <= '1';
		wait for 10 ns;
		set <= '0';
		wait for 60 ns;

		-- Stop alarm
		wait until on_alarm = '1';
		wait for 10 ns;
		alarm_stop <= '1';
		-- End test
		wait;
	end process;

	-- Monitor process
	monitor_process: process
	begin
		while now < 500 ns loop  -- Run for 500 ns
			
			-- Display current time and alarm status
			report "Time: " & integer'image(to_integer(unsigned(hour1_output))) & integer'image(to_integer(unsigned(hour0_output))) &
				   ":" & integer'image(to_integer(unsigned(min1_output))) & integer'image(to_integer(unsigned(min0_output)));
			report "Alarm: " & std_logic'image(on_alarm);
			wait for 10 ns;
		end loop;
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alarm_clock of alarm_clock_tb is
	for TB_ARCHITECTURE
		for UUT : alarm_clock
			use entity work.alarm_clock(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alarm_clock;