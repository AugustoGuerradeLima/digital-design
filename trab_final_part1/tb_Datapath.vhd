library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Datapath is
end tb_Datapath;

architecture behavior of tb_Datapath is


    component Datapath is
        port (
            Subindo              : in std_logic;
				Descendo					: in std_logic;
            Clock                : in std_logic;
            Atualizar            : in std_logic;
            Andar                : in std_logic_vector(3 downto 0);
            Escolher             : in std_logic;
            Sobe                 : out std_logic;
            Desce                : out std_logic;
				Igual						: out std_logic;
            Enable_internal      : buffer std_logic;
            Sig_Proximo          : buffer std_logic_vector(3 downto 0);
            Sig_Andar            : buffer std_logic_vector(3 downto 0);
            Sig_Reg_FilaAndar    : buffer std_logic_vector(15 downto 0);
            Sig_AndarSelecionado : buffer std_logic
        );
    end component;


    signal Subindo              : std_logic := '0';
	 signal Descendo				  : std_logic := '0';
    signal Clock                : std_logic := '0';
    signal Atualizar            : std_logic := '0';
    signal Andar                : std_logic_vector(3 downto 0) := (others => '0');
    signal Escolher             : std_logic := '0';
    signal Sobe                 : std_logic;
    signal Desce                : std_logic;
    signal Sig_Proximo          : std_logic_vector(3 downto 0);
    signal Sig_Andar            : std_logic_vector(3 downto 0);
    signal Sig_Reg_FilaAndar    : std_logic_vector(15 downto 0);
    signal Sig_AndarSelecionado : std_logic;
    signal Sig_Igual            : std_logic;
    signal Enable_internal      : std_logic;


    constant Clock_period : time := 2 ns;

begin


    uut: Datapath
        port map (
            Subindo              => Subindo,
				Descendo					=> Descendo,
            Clock                => Clock,
            Atualizar            => Atualizar,
            Andar                => Andar,
            Escolher             => Escolher,
            Sobe                 => Sobe,
            Desce                => Desce,
            Sig_Proximo          => Sig_Proximo,
            Sig_Andar            => Sig_Andar,
            Sig_Reg_FilaAndar    => Sig_Reg_FilaAndar,
            Sig_AndarSelecionado => Sig_AndarSelecionado,
            Igual            		=> Sig_Igual,
            Enable_internal      => Enable_internal
        );


    Clock_process : process
    begin
        Clock <= '0';
        wait for Clock_period / 2;
        Clock <= '1';
        wait for Clock_period / 2;
    end process;


    stim_proc: process
    begin

        Subindo <= '1';
        Atualizar <= '0';
        Andar <= "0000";
        Escolher <= '0';
        

        wait for 50 ns;
        

        wait for 50 ns;
        

        wait for 50 ns;
        

		  Andar <= "0010";
        Escolher <= '1';

        wait for 50 ns;
        Escolher <= '0';
        wait for 50 ns;
        

        wait for 50 ns;
        Atualizar <= '1';
        wait for 50 ns;
        Atualizar <= '0';
        wait for 50 ns;
        Atualizar <= '1';
        wait for 50 ns;
        Atualizar <= '0';
		  
		  Andar <= "0101";
        Escolher <= '1';
		  Subindo <= '1';
        wait for 50 ns;
        Escolher <= '0';
        wait for 50 ns;
        Atualizar <= '1';
        wait for 50 ns;
        Atualizar <= '0';
        wait for 50 ns;
        Atualizar <= '1';
        wait for 50 ns;
        Atualizar <= '0';
        wait for 50 ns;
        Atualizar <= '1';
        wait for 50 ns;
        Atualizar <= '0';
		  Andar <= "0001";
        Escolher <= '1';
		  Subindo <= '0';
        wait for 50 ns;
        Atualizar <= '1';
        wait for 50 ns;
        Atualizar <= '0';
        wait for 50 ns;
        Atualizar <= '1';
        wait for 50 ns;
        Atualizar <= '0';
        wait;
    end process;

end behavior;
