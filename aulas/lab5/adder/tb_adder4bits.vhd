LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_adder4bits is
END tb_adder4bits;

ARCHITECTURE structural of tb_adder4bits is
  COMPONENT fulladder is
        port (
            Cin : in std_logic;
            x   : in std_logic;
            y   : in std_logic;
            s   : out std_logic;
            Cout : out std_logic
        );
  END COMPONENT;

SIGNAL Cout0, Cout1, Cout2, Cout3: std_logic;
SIGNAL A, B : std_logic_vector(3 downto 0);
SIGNAL Cin : std_logic;
SIGNAL Sum : std_logic_vector(3 downto 0);
SIGNAL Cout : std_logic;

BEGIN 
  instancia_fa0: fulladder port map (Cin, A(0), B(0), Sum(0), Cout0);
  instancia_fa1: fulladder port map (Cout0, A(1), B(1), Sum(1), Cout1);
  instancia_fa2: fulladder port map (Cout1, A(2), B(2), Sum(2), Cout2);
  instancia_fa3: fulladder port map (Cout2, A(3), B(3), Sum(3), Cout3);
--Ultimo carry exposto
  Cout<=Cout3;
  
  A <= b"0000", b"0101" after 20ns, b"1111" after 60ns;
  B <= b"0000", b"0111" after 40ns, b"1111" after 80ns;
  Cin <= '0', '1' after 10ns, '0' after 25ns, '1' after 70ns;
  
END structural;