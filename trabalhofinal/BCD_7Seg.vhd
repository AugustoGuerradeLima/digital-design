LIBRARY IEEE;
use ieee.std_logic_1164.all;

Entity BCD_7Seg is
	port (
		Entrada : in std_logic_vector (3 downto 0);
		Saida_1 : out std_logic_vector (6 downto 0);
		Saida_2 : out std_logic_vector (6 downto 0)
	);
end Bcd_7Seg;

architecture Behavioral of BCD_7Seg is
begin
	with Entrada select
		Saida_1 <= not "0000000" when "0000", -- A
			  not "0000000" when "0001", --1
			  not "0000000" when "0010", --2
			  not "0000000" when "0011", --3
			  not "0000000" when "0100", --4
			  not "0000000" when "0101", --5
			  not "0000000" when "0110", --6
			  not "0000000" when "0111", --7
			  not "0000000" when "1000", --8
			  not "0000000" when "1001", --9
			  not "1001111" when "1010", --10
			  not "1001111" when "1011", --11
			  not "1001111" when "1100", --12
			  not "1001111" when "1101", --13
			  not "1001111" when "1110", --14
			  not "1001111" when "1111", --15
			  not "1111111" when others;
	with Entrada select
		Saida_2 <= "0000100" when "0000", -- A
					  "1001111" when "0001", --1
					  "0010010" when "0010", --2
					  "0000110" when "0011", --3
					  "1001100" when "0100", --4
					  "0100100" when "0101", --5
					  "0100000" when "0110", --6
					  "0001111" when "0111", --7
					  "0000000" when "1000", --8
					  "0000001" when "1001", --9
					  "0001000" when "1010", --10
					  "0010010" when "1011", --11
					  "0000110" when "1100", --12
					  "1001100" when "1101", --13
					  "0100100" when "1110", --14
					  "0100000" when "1111", --15
					  "1111111" when others;
end Behavioral;
