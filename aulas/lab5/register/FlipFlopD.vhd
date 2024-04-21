library IEEE;
use ieee.std_logic_1164.all;

entity FlipFlopD is
    port(
        clock: in std_logic;
        D:  in std_logic;
        Q: out std_logic  
    );
end FlipFlopD;

architecture dataflow of FlipFlopD is
    signal m1, m2, m3, m4: std_logic;
	 signal s1, s2, s3 , s4: std_logic;
begin
    m1 <= (D NAND NOT(clock));
    m2 <= (NOT(D) NAND NOT(clock));
    m3 <= m1 NAND m4;
    m4 <= m2 NAND m3;
	
	 s1 <= (m3 	NAND clock);
	 s2 <= (NOT(m3) NAND NOT(clock));
	 s3 <=  s1 NAND s4;
	 s4 <=  s2 NAND s3;
	 
	 Q<= s3;
	 
end dataflow;