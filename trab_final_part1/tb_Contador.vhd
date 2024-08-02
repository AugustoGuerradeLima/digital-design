library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Contador is
end tb_Contador;

architecture Behavioral of tb_Contador is


    component Contador is
        port (
            Clock   : in  std_logic;
            Reset   : in  std_logic;
            Control : in  std_logic;
            Start   : in  std_logic_vector(3 downto 0);
            Enable  : in  std_logic;
            Count   : out std_logic_vector(3 downto 0)
        );
    end component;


    signal Clock   : std_logic := '0';
    signal Reset   : std_logic := '0';
    signal Control : std_logic := '0';
    signal Start   : std_logic_vector(3 downto 0) := "0000";
    signal Enable  : std_logic := '0';
    signal Count   : std_logic_vector(3 downto 0);


    constant Clock_period : time := 10 ns;

begin


    uut: Contador
        port map (
            Clock   => Clock,
            Reset   => Reset,
            Control => Control,
            Start   => Start,
            Enable  => Enable,
            Count   => Count
        );


    Clock_process :process
    begin
        Clock <= '0';
        wait for Clock_period/2;
        Clock <= '1';
        wait for Clock_period/2;
    end process;


    stim_proc: process
    begin        

        wait for 20 ns;  
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';


        Start <= "0000";
        Control <= '1';
        Enable <= '1';
        wait for 20 ns;
        

        Enable <= '0';
        wait for 20 ns;


        Enable <= '1';
        Control <= '0';
        wait for 40 ns;
        
		  wait for 20 ns;
        Start <= "0100";
		  Reset <= '1';
		  wait for 20 ns;
        Reset <= '0';
        Control <= '1';
        wait for 100 ns;

        wait;
    end process;

end Behavioral;
