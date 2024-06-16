library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity mean_4_clocks is
	generic 
	(
		W       : natural := 4
	);
	port (
		clock     : in  std_logic;
		RESET   : in  std_logic;
		INPUT   : in  std_logic_vector(W - 1 downto 0);
		OUTPUT  : out std_logic_vector(W - 1 downto 0)
	);
end mean_4_clocks;

architecture arch of mean_4_clocks is
	signal var1, var2, var3, var4 : unsigned(W + 1 downto 0) := (others => '0');
	signal sum : unsigned(W + 1 downto 0) := (others => '0');
begin
	process(clock, RESET) begin
		if RESET = '1' then
		    var1 <= (others => '0');
		    var2 <= (others => '0');
		    var3 <= (others => '0');
		    var4 <= (others => '0');
		elsif rising_edge(clock) then
		    var1 <= unsigned("00" & INPUT);
		    var2 <= var1;
		    var3 <= var2;
		    var4 <= var3;
		end if;
	end process;
	sum <= (var1 + var2) + (var3 + var4);
	OUTPUT <= std_logic_vector((sum(W+1 downto 2)));
end arch;