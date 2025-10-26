library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use ieee.math_real.floor;
use ieee.math_real.uniform;

package MatrixPack is		
type complex_no is record
      real: real;
      imag: real;
end record complex_no;
type matrix_op is array (0 to 8-1, 0 to 8-1) of complex_no; -- Define the type for the matrix operation
  
    function add_function(A: in matrix_op; B: in matrix_op)
		return matrix_op;
    function multi_function(A: in matrix_op; B: in matrix_op)    
		return matrix_op;

    procedure Random_in(M: out matrix_op);
    procedure PrintResult(M: in matrix_op);

end MatrixPack;

package body MatrixPack is

	-- Implementation of the add_function
    function add_function(A: in matrix_op; B: in matrix_op) 
		return matrix_op is
        variable Result: matrix_op;
    begin
        for i in 0 to 8-1 loop
            for z in 0 to 8-1 loop
                Result(i, z).real := A(i, z).real + B(i, z).real;
                Result(i, z).imag := A(i, z).imag + B(i, z).imag;
            end loop;
        end loop;
      return Result;
    end add_function;
	
	 -- Implementation of the multi_function
    function multi_function(A: in matrix_op; B: in matrix_op) 
	    return matrix_op is
        variable Result: matrix_op;
    begin
        for i in 0 to 8-1 loop
            for z in 0 to 8-1 loop
                for k in 0 to 8-1 loop
                    Result(i, z).real := Result(i, z).real + (A(i, k).real * B(k, z).real - A(i, k).imag * B(k, z).imag);
                    Result(i, z).imag := Result(i, z).imag + (A(i, k).real * B(k, z).imag + A(i, k).imag * B(k, z).real);
                end loop;
            end loop;
        end loop;
      return Result;
    end multi_function;
	
-- Implementation of the Random_in procedure  
procedure Random_in(M: out matrix_op) is 
	variable x1: real;
	variable x2: real;
	variable core11: integer :=1;
	variable core12: integer := 1;  
	variable core21: integer := 2;
	variable core22: integer := 3;
    begin
        for i in 0 to 8-1 loop
            for z in 0 to 8-1 loop   
				uniform(core11, core12, x1);
				uniform(core21, core22, x2);
                M(i, z).real := Real(integer(floor(x1 * 10.0))); M(i, z).imag := Real(integer(floor(x2 * 10.0)));	
            end loop;
        end loop;
end Random_in;

-- Implementation of the PrintResult procedure
procedure PrintResult(M: in matrix_op) is
    begin
        for i in 0 to 8 - 1 loop
            for z in 0 to 8 - 1 loop
                report "Element(" & integer'image(i) & "," & integer'image(z) & "): " & real'image(M(i, z).real) & " + " & real'image(M(i, z).imag) & "i";
            end loop;
        end loop;
    end PrintResult;
end MatrixPack;