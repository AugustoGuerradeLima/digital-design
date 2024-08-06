library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Datapath is
end tb_Datapath;

architecture Behavioral of tb_Datapath is
    -- Componente sendo testado (UUT - Unit Under Test)
    component Datapath
        port (
            Clock             : in std_logic;
            Subindo           : in std_logic;
            Descendo          : in std_logic;
            Atualizar         : in std_logic;
            Abre              : in std_logic;
            Escolher          : in std_logic;
				Enviar				: in std_logic;
            Digito            : in std_logic_vector(3 downto 0);
            Andar             : in std_logic_vector(3 downto 0);
            Peso              : in std_logic_vector(9 downto 0);
            Sobe              : out std_logic;
            Desce             : out std_logic;
            Igual             : out std_logic;
            Peso_Ultrapassado : out std_logic;
            Verificado        : out std_logic;
            BCD1              : out std_logic_vector(6 downto 0);
            BCD2              : out std_logic_vector(6 downto 0);
            Sig_Peso          : buffer std_logic_vector(9 downto 0);
            Sig_Senha         : buffer std_logic_vector(15 downto 0);
            Sig_Proximo       : buffer std_logic_vector(3 downto 0);
            Sig_Andar         : buffer std_logic_vector(3 downto 0);
            Sig_Reg_FilaAndar : buffer std_logic_vector(15 downto 0);
            Sig_AndarSelecionado : buffer std_logic
        );
    end component;

    -- Sinais para conectar ao UUT
    signal Clock             : std_logic := '0';
    signal Subindo           : std_logic := '0';
    signal Descendo          : std_logic := '0';
    signal Atualizar         : std_logic := '0';
    signal Abre              : std_logic := '0';
    signal Escolher          : std_logic := '0';
	 signal Enviar				  : std_logic := '0';
    signal Digito            : std_logic_vector(3 downto 0) := (others => '0');
    signal Andar             : std_logic_vector(3 downto 0) := (others => '0');
    signal Peso              : std_logic_vector(9 downto 0) := (others => '0');
    signal Sobe              : std_logic;
    signal Desce             : std_logic;
    signal Igual             : std_logic;
    signal Peso_Ultrapassado : std_logic;
    signal Verificado        : std_logic;
    signal BCD1              : std_logic_vector(6 downto 0);
    signal BCD2              : std_logic_vector(6 downto 0);
    signal Sig_Peso          : std_logic_vector(9 downto 0);
    signal Sig_Senha         : std_logic_vector(15 downto 0);
    signal Sig_Proximo       : std_logic_vector(3 downto 0);
    signal Sig_Andar         : std_logic_vector(3 downto 0);
    signal Sig_Reg_FilaAndar : std_logic_vector(15 downto 0);
    signal Sig_AndarSelecionado : std_logic;

    -- Definição do período do clock
    constant Clock_Period : time := 6 ns;

begin
    -- Instanciar o UUT
    uut: Datapath
        port map (
            Clock => Clock,
            Subindo => Subindo,
            Descendo => Descendo,
            Atualizar => Atualizar,
            Abre => Abre,
            Escolher => Escolher,
				Enviar	=> Enviar,
            Digito => Digito,
            Andar => Andar,
            Peso => Peso,
            Sobe => Sobe,
            Desce => Desce,
            Igual => Igual,
            Peso_Ultrapassado => Peso_Ultrapassado,
            Verificado => Verificado,
            BCD1 => BCD1,
            BCD2 => BCD2,
            Sig_Peso => Sig_Peso,
            Sig_Senha => Sig_Senha,
            Sig_Proximo => Sig_Proximo,
            Sig_Andar => Sig_Andar,
            Sig_Reg_FilaAndar => Sig_Reg_FilaAndar,
            Sig_AndarSelecionado => Sig_AndarSelecionado
        );

    -- Gerador de clock
    Clock_process :process
    begin
        Clock <= '0';
        wait for Clock_Period/2;
        Clock <= '1';
        wait for Clock_Period/2;
    end process;

    -- Estímulos de teste
    stim_proc: process
    begin
        -- Inicialização
        Atualizar <= '0';
        Abre <= '0';
        Escolher <= '0';
        Subindo <= '0';
        Descendo <= '0';
        Digito <= "0000";
        Andar <= "0000";
        Peso <= "0000000000";
		  
		  Enviar	<= '1';
		  Digito <= "0001"; -- 1
        wait for Clock_Period;
			Enviar	<= '0';
			  wait for Clock_Period;
			Enviar	<= '1';
			Digito <= "0010"; -- 2
        wait for Clock_Period;
			Enviar	<= '0';
			  wait for Clock_Period;
			Enviar	<= '1';
        Digito <= "0011"; -- 3
        wait for Clock_Period;
		  			Enviar	<= '0';
			  wait for Clock_Period;
			Enviar	<= '1';
        Digito <= "0100"; -- 4
        wait for Clock_Period;
        -- Aguardar algumas bordas de clock
        wait for 100 ns;
        
        -- Estímulos de teste
        -- Definir alguns andares
        Andar <= "0010"; -- Andar 2
        Escolher <= '1';
        wait for Clock_Period;
        Escolher <= '0';

        Andar <= "0101"; -- Andar 5
        Escolher <= '1';
        wait for Clock_Period;
        Escolher <= '0';

        -- Subir
        Subindo <= '1';
        wait for 100 ns;
        Atualizar <= '1';
        wait for 10 ns;
        Atualizar <= '0';
        wait for 100 ns;
        Atualizar <= '1';
        wait for 10 ns;
        Atualizar <= '0';
        wait for 100 ns;

        -- Peso ultrapassado
        Peso <= "1100100001"; -- 801 em binário
        wait for 10 * Clock_Period;

        -- Descer
        Descendo <= '1';
        wait for 10 * Clock_Period;
        Descendo <= '0';
        
        -- Verificação de senha

        -- Finalização do teste
        wait;
    end process;

end Behavioral;
