library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity tb_mean_4_clocks is
end tb_mean_4_clocks;

architecture arch of tb_mean_4_clocks is
	component mean_4_clocks is
	generic
	(
		W : natural := 4
	);

	port (
		CLK, RESET: in std_logic;
		INPUT: 	 in std_logic_vector (W-1 downto 0);
		OUTPUT: 	 out std_logic_vector(W-1 downto 0)
	);
end component;

signal CLK, RESET : std_logic;
signal INPUT : std_logic_vector(3 downto 0);
signal OUTPUT : std_logic_vector(3 downto 0);

begin
	instancia_mean4: mean_4_clocks
		generic map (W => 4) 
		port map (
			  CLK    => CLK,
			  RESET  => RESET,
			  INPUT  => INPUT,
			  OUTPUT => OUTPUT
		 );

	clock_process: process begin
		CLK <= '0';
		wait for 15 ns;  
		CLK <= '1';
		wait for 15 ns;
	end process;

	INPUT <= "0100", "1100" after 30 ns, "1110" after 60 ns, "0010" after 90 ns;
end arch;
