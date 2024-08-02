library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_Elevador is
end tb_Elevador;

architecture behavior of tb_Elevador is

    signal Clock_Controladora   : std_logic := '0';
    signal Clock_Datapath        : std_logic := '0';
    signal Reset                 : std_logic := '0';
    signal Andar                 : std_logic_vector(3 downto 0) := (others => '0');
    signal Escolher              : std_logic := '0';
    signal Sobe                  : std_logic;
    signal Desce                 : std_logic;
	 signal Igual						: std_logic;
    signal BCD1                  : std_logic_vector(6 downto 0);
    signal BCD2                  : std_logic_vector(6 downto 0);
    signal Subindo               : std_logic;
    signal Atualizar             : std_logic;


    constant Clock_Period_Controladora : time := 500 ns;
    constant Clock_Period_Datapath      : time := 20 ns;

begin

    process
    begin
        Clock_Controladora <= '0';
        wait for Clock_Period_Controladora / 2;
        Clock_Controladora <= '1';
        wait for Clock_Period_Controladora / 2;
    end process;


    process
    begin
        Clock_Datapath <= '0';
        wait for Clock_Period_Datapath / 2;
        Clock_Datapath <= '1';
        wait for Clock_Period_Datapath / 2;
    end process;


    uut: entity work.Elevador
        port map (
            Clock_Controladora => Clock_Controladora,
            Clock_Datapath      => Clock_Datapath,
            Reset               => Reset,
            Andar               => Andar,
            Escolher            => Escolher,
            Sobe                => Sobe,
            Desce               => Desce,
				Igual					  => Igual,
            BCD1                => BCD1,
            BCD2                => BCD2,
            Subindo             => Subindo,
            Atualizar           => Atualizar
        );


    process
    begin

        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';


        Andar <= "0010";
        Escolher <= '1';
        wait for 500 ns;
        Escolher <= '0';
        wait for 500 ns;


        Andar <= "0100";
        Escolher <= '1';
        wait for 500 ns;
        Escolher <= '0';
        wait for 500 ns;

        Andar <= "0001";
        Escolher <= '1';
        wait for 50 ns;
        Escolher <= '0';
        wait for 50 ns;


        wait;
    end process;

end behavior;
