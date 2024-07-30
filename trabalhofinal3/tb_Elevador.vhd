library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_Elevador is
end tb_Elevador;

architecture behavior of tb_Elevador is
    -- Sinais de teste
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

    -- Clock period
    constant Clock_Period_Controladora : time := 50 ns;
    constant Clock_Period_Datapath      : time := 2 ns;

begin
    -- Clock generation for Controladora
    process
    begin
        Clock_Controladora <= '0';
        wait for Clock_Period_Controladora / 2;
        Clock_Controladora <= '1';
        wait for Clock_Period_Controladora / 2;
    end process;

    -- Clock generation for Datapath
    process
    begin
        Clock_Datapath <= '0';
        wait for Clock_Period_Datapath / 2;
        Clock_Datapath <= '1';
        wait for Clock_Period_Datapath / 2;
    end process;

    -- Instance of the Elevador
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

    -- Stimulus process
    process
    begin
        -- Reset
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';

        -- Test Case 1
        Andar <= "0010"; -- Exemplo de andar
        Escolher <= '1';
        wait for 50 ns;
        Escolher <= '0';
        wait for 50 ns;

        -- Test Case 2
        Andar <= "0100"; -- Outro exemplo de andar
        Escolher <= '1';
        wait for 50 ns;
        Escolher <= '0';
        wait for 50 ns;

        -- Test Case 3
        Andar <= "0001"; -- Outro exemplo de andar
        Escolher <= '1';
        wait for 50 ns;
        Escolher <= '0';
        wait for 50 ns;

        -- Finalize simulation
        wait;
    end process;

end behavior;
