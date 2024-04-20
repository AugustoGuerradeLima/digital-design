library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity tb_RegW is
end tb_RegW;


architecture teste of tb_RegW is

  -- Declaração do componente a ser simulado:
  component RegW is

	generic
	(
		W : natural := 4
	);

	port 
	(
				clock: in std_logic;
				load:  in std_logic;
				reset: in std_logic;
				D: 	 in std_logic_vector (W-1 downto 0);
				Q: 	 out std_logic_vector(W-1 downto 0)
	);

  end component;

  -- signal fio_a, fio_b, fio_soma: std_logic_vector(3 downto 0);
  
   signal clock,load, reset: std_logic;
	signal D,Q: std_logic_vector(3 downto 0);
  
	begin 
	instancia_reg: RegW generic map (W=>4) port map (clock=>clock, load=>load, reset=>reset, D=>D, Q=>Q);
	
	clock_process :process
   begin
        clock <= '0';
        wait for 1 ns;  
        clock <= '1';
        wait for 1 ns;  
   end process;
	
	D<= b"0000", b"0101" after 20 ns , b"1111" after 40 ns, b"0111" after 60 ns;
	load<= '0' , '1' after 30 ns , '0' after 50 ns;
	reset<= '0', '1' after 70 ns;
	
	end teste;
	
	--:)