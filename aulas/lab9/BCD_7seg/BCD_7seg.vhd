LIBRARY IEEE;
use IEEE.std_logic_1164.all;


-- Testado e fornecido com pinagem para Kit Terasic Altera DE2:
entity Bcd_7seg is
   port 
	(
		entrada: in std_logic_vector 	(3 downto 0);
		saida:	out std_logic_vector (6 downto 0)
	);
end Bcd_7seg;

architecture with_select_bcd7seg of Bcd_7seg is
begin
  with entrada select
  saida <=  not"1111110" when "0000", 	--0
	    not"0110000" when "0001", 		--1
	    not"1101101" when "0010", 		--2
	    not"1111001" when "0011", 		--3
	    not"0110011" when "0100", 		--4
	    not"1011011" when "0101", 		--5
	    not"1011111" when "0110",		  	--6
	    not"1110000" when "0111", 		--7
	    not"1111111" when "1000", 		--8
	    not"1111011" when "1001", 		--9
	    not"1110111" when "1010", 		--A
	    not"0011111" when "1011", 		--B
	    not"1001110" when "1100", 		--C
	    not"0111101" when "1101", 		--D
	    not"1001111" when "1110", 		--E
	    not"1000111" when "1111", 		--F
	    not"0000000" when others;
				
end with_select_bcd7seg;