library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Demux is
	generic (
		W : integer := 16;
		Log2W : integer := 4  -- log2(16) = 4, para valores maiores, ajustar manualmente
	);
	port (
		Input_vector : in  std_logic_vector(W-1 downto 0);
		Selector     : in  std_logic_vector(log2W-1 downto 0);
		Output_value : out std_logic
	);
end Demux;

architecture Behavioral of Demux is
	begin
		process(Input_vector, Selector)
		begin
			if to_integer(unsigned(Selector)) < W then
				Output_value <= Input_vector(to_integer(unsigned(Selector)));
			else
				Output_value <= 'Z'; -- Valor default ou erro
			end if;
	end process;
end Behavioral;