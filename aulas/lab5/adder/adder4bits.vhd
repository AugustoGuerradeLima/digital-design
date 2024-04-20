LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY adder4bits is
  port(
    A,B: in std_logic_vector(3 downto 0);
    Cin: in std_logic;
    Sum: out std_logic_vector(3 downto 0);
    Cout: out std_logic
  );
END adder4bits;

ARCHITECTURE structural of adder4bits is
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

BEGIN 
  instancia_fa0: fulladder port map (Cin, A(0), B(0), Sum(0), Cout0);
  instancia_fa1: fulladder port map (Cout0, A(1), B(1), Sum(1), Cout1);
  instancia_fa2: fulladder port map (Cout1, A(2), B(2), Sum(2), Cout2);
  instancia_fa3: fulladder port map (Cout2, A(3), B(3), Sum(3), Cout3);
--Ultimo carry exposto
  Cout<=Cout3;
END structural;