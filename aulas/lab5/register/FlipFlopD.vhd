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
    signal s1, s2, s3, s4: std_logic;
begin
    -- Implementando NAND gates usando AND e NOT
    m1 <= NOT (D AND NOT(clock));
    m2 <= NOT (NOT(D) AND NOT(clock));
    m3 <= NOT (m1 AND m4);
    m4 <= NOT (m2 AND m3);

    s1 <= NOT (m3 AND clock);
    s2 <= NOT (NOT(m3) AND NOT(clock));
    s3 <= NOT (s1 AND s4);
    s4 <= NOT (s2 AND s3);

    Q <= s3;
end dataflow;