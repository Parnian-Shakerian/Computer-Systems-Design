library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity filter is
	 generic( n:integer:=3 );
end filter;

package my_package is
	type filter_type is array(0 to 2,0 to 2) of Real;
	type PE_tmp is array(0 to 2, 0 to 2) of integer;
end package;

use work.my_package.all;
entity PE is
	generic(f_size : integer :=3);
	 port(array_no1: in filter_type;
		  array_no2: in PE_tmp;
		  results : out Real);
end PE;

architecture Behavioral of PE is
begin
	process
	 variable calc: Real :=0.0;
      begin
        for i in 0 to f_size-1 loop
			for j in 0 to f_size-1 loop
			 calc := calc + (array_no1(i,j)* Real(array_no2(i,j)));
			end loop;	
        end loop;
	 results <= calc;
   end process;
end Behavioral;
architecture Behavioral of filter is
		type filter_type is array(0 to 2, 0 to 2) of Real;
	    type input is array(0 to 255,0 to 255) of integer;
		type PE_tmp is array(0 to 2,0 to 2) of integer;
	    type tmp is array(0 to 254,0 to 254) of real;
	    type output is array(0 to n-1) of tmp;
	    type filters is array(0 to n-1) of filter_type; -- generic n
		component PE is
		 generic (f_size: integer);
			Port (array_no1 : in filter_type;
				  array_no2 : in PE_tmp;
				  results : out real);
		end component;
		
		signal IFM : input;											
		signal testing_filter : filters;
		signal OFM : output;
		
		shared variable core1,core2:integer;
		impure function Random_Filter return filter_type is 
			variable r : real;
			constant maximum: real := 1.00000001;
			constant minimum: real := -0.0000001;
			variable filter :filter_type;
		begin
			for i in 0 to 2 loop
				for j in 0 to 2 loop
					uniform(core1, core2, r);
					filter(i,j) := r* (maximum-minimum) + minimum;
				end loop;
			  end loop;
			return filter;
		end function;
		
		impure function core(s1,s2: integer) return boolean is
		begin
			core1 := s1;
			core2 := s2;
			return True;
		end function;
		signal core_ret: boolean;
		file files_vec: text;		
    begin	
	  process
		variable iline: line;
		variable space: character;
		variable lin: integer := 0;
		variable IFM_Variable: input;
   	begin
		file_open(files_vec, "input_vectors.txt", read_mode);
		  while not endfile(files_vec) loop		
			readline(files_vec, iline);
			  for i in 0 to 5 loop
				read(iline, IFM_Variable(lin,i));
				IFM(lin,i) <= IFM_Variable(lin,i);
				read(iline, space);  -- read in the space character
			  end loop;
			lin := lin + 1;
		  end loop;
		file_close(files_vec);
	  wait;
	end process;	
	process 
	begin
		for i in 0 to n-1 loop
			core_ret <= core(10*i + 1 , 20*i + 1);
			testing_filter(i) <= Random_Filter;
		end loop;
	end process;	
	number1:for i in 0 to n-1 generate 
		number2:for j in 1 to 225 generate --start from 1 because stride is 1!!
			number3:for z in 1 to 225 generate
			end generate number3;
		end generate number2;
	end generate number1;
end Behavioral;