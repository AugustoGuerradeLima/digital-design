library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity tb_fulladder is
end tb_fulladder;

architecture teste of tb_fulladder is

  -- Declaração do componente a ser simulado:
  component fulladder is

    port ( Cin : in std_logic;
           x   : in std_logic;
           y   : in std_logic;
           s   : out std_logic;
           Cout : out std_logic
        );

  end component;

  signal Cin, Cout, x, y, s: std_logic;

begin

 -- Instancie o componente "Somador" declarado acima para simulação, conectando-o aos "fios" com os estímulos:
 instancia_fulladder: fulladder port map (Cin=>Cin,Cout=>Cout,x=>x,y=>y,s=>s);

s_process :process begin
  x <= '0';
  wait for 40 ns;  
  x <= '1';
  wait for 40 ns;  
end process;

cout_process :process begin
  y <= '0';
  wait for 20 ns;  
  y <= '1';
  wait for 20 ns;  
end process;

cin_process :process begin
  Cin <= '0';
  wait for 10 ns;  
  Cin <= '1';
  wait for 10 ns;  
end process;

end teste;