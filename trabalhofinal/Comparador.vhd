library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity Comparador is
	generic
	(
		W: natural := 16
	);
	port
	(
		A,B : in std_logic_vector(W-1 downto 0);
		Maior, Menor, Igual : out std_logic
	);	
end entity;

architecture Behavorial of Comparador is 
Begin
	
	Maior <= '1' when (signed(A) > signed(B)) else '0';
	Menor <= '1' when (signed(A) < signed(B)) else '0';
	Igual <= '1' when (signed(A) = signed(B)) else '0';

end Behavorial;