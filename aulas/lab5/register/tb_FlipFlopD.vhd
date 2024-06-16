library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_FlipFlopD is
end tb_FlipFlopD;

architecture behavior of tb_FlipFlopD is
    component FlipFlopD is
        port (
            clock : in std_logic;
            D     : in std_logic;
            Q     : out std_logic
        );
    end component;

    signal clock : std_logic := '0';
    signal D     : std_logic := '0';
    signal Q     : std_logic;

begin
    uut: FlipFlopD port map (
        clock => clock,
        D     => D,
        Q     => Q
    );

    clock_process: process
    begin
        while true loop
            clock <= '0';
            wait for 10 ns;  
            clock <= '1';
            wait for 10 ns;  
        end loop;
    end process;

    test_process: process
    begin
        wait for 5 ns; 
        D <= '0'; 
        wait for 10 ns;

        D <= '1';  
        wait for 20 ns;

        D <= '0';  
        wait for 20 ns;

        D <= '1';  
        wait for 20 ns;
        wait;
    end process;

end behavior;