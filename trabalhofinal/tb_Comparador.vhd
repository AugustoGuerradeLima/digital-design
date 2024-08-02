library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity tb_Comparador is
end tb_Comparador;

architecture teste of tb_Comparador is

component Comparador is 

	generic
	(
		W : natural := 16
	);

	port 
	(
		A	: in std_logic_vector	((W-1) downto 0);
		B	: in std_logic_vector	((W-1) downto 0);
		Maior	: out std_logic;
		Menor	: out std_logic;
		Igual	: out std_logic
	);

end component;

signal fio_A, fio_B: std_logic_vector(3 downto 0);
signal fio_maior, fio_menor, fio_igual: std_logic;

begin

-- Note que o componente é instanciado com apenas 4 bits nas entradas para facilitar A simulação:
instancia_comparador: Comparador generic map (W => 4) port map(A=>fio_A,B=>fio_B,Maior=>fio_maior, Menor=>fio_menor,Igual=>fio_igual);

-- Dados de entrada de 4 bits são expressos em "hexadecimal" usando "x":
fio_A <= x"0", x"8" after 20 ns, x"7" after 40 ns, x"4" after 60 ns;
fio_B <= x"0", x"7" after 10 ns, x"8" after 30 ns, x"1" after 50 ns;
end teste;