library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Controladora is
end tb_Controladora;

architecture Behavioral of tb_Controladora is


    component Controladora
        port (
            Clock      : in std_logic;
            Reset      : in std_logic;
            Sobe       : in std_logic;
            Desce      : in std_logic;
            Igual      : in std_logic;
            Atualizar  : out std_logic;
            Subindo    : out std_logic;
				Descendo	  : out std_logic
        );
    end component;


    signal Clock      : std_logic := '0';
    signal Reset      : std_logic := '0';
    signal Sobe       : std_logic := '0';
    signal Desce      : std_logic := '0';
    signal Igual      : std_logic := '0';
    signal Atualizar  : std_logic;
    signal Subindo    : std_logic;
    signal Descendo   : std_logic;


    constant Clock_period : time := 10 ns;

begin


    uut: Controladora
        port map (
            Clock     => Clock,
            Reset     => Reset,
            Sobe      => Sobe,
            Desce     => Desce,
            Igual     => Igual,
            Atualizar => Atualizar,
            Subindo   => Subindo,
				Descendo	 => Descendo
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
        wait for Clock_period*2;
        Reset <= '0';


        Sobe <= '1';
        wait for Clock_period*5;
        Sobe <= '0';


        Igual <= '1';
        wait for Clock_period*5;
        Igual <= '0';


        Desce <= '1';
        wait for Clock_period*5;
        Desce <= '0';


        Igual <= '1';
        wait for Clock_period*5;
        Igual <= '0';


        wait;
    end process;

end Behavioral;
