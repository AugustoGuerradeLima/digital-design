library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity comparador is

	generic
	(
		DATA_WIDTH: natural := 4
	);
	
	
	port
	(
		a,b : in std_logic_vector(DATA_WIDTH-1 downto 0);
		maior, menor, igual : out std_logic
	);
	
	
end entity;

architecture comp4b of comparador is 
begin
	
	maior <= '1' when (unsigned(a)>unsigned(b)) else '0';
	menor <= '1' when (unsigned(a)<unsigned(b)) else '0';
	igual <= '1' when (unsigned(a)=unsigned(b)) else '0';

end comp4b;