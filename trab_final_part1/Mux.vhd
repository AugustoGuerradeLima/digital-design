library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mux is
	generic (
		W : integer := 16;
		Log2W : integer := 4
	);
	port (
		Input_vector : in  std_logic_vector(W-1 downto 0);
		Selector     : in  std_logic_vector(log2W-1 downto 0);
		Output_value : out std_logic
	);
end Mux;

architecture Behavioral of Mux is
	begin
		process(Input_vector, Selector)
		begin
			if to_integer(unsigned(Selector)) < W then
				Output_value <= Input_vector(to_integer(unsigned(Selector)));
			else
				Output_value <= 'Z';
			end if;
	end process;
end Behavioral;
