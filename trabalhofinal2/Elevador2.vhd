library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Elevador is
    port (
        Clock_Controladora   : in std_logic;  -- Clock para a Controladora
        Clock_Datapath        : in std_logic;  -- Clock para o Datapath
        Reset                 : in std_logic;
        Andar                 : in std_logic_vector(3 downto 0); -- Entrada para o Datapath
        Escolher              : in std_logic;  -- Entrada para o Datapath
        Sobe                  : out std_logic; -- Saída do Datapath
        Desce                 : out std_logic; -- Saída do Datapath
        BCD1                  : out std_logic_vector(6 downto 0); -- Saída para BCD1
        BCD2                  : out std_logic_vector(6 downto 0); -- Saída para BCD2
        Subindo               : buffer std_logic;  -- Usado para observar o estado
        Atualizar             : buffer std_logic   -- Usado para observar o estado
    );
end Elevador;

architecture Structural of Elevador is

    -- Sinais internos
    signal Atualizar_Controladora : std_logic;
    signal Subindo_Controladora   : std_logic;
    signal Sobe_Datapath           : std_logic;
    signal Desce_Datapath          : std_logic;
    signal Enable_internal         : std_logic;
    signal Sig_Proximo             : std_logic_vector(3 downto 0);
    signal Sig_Andar               : std_logic_vector(3 downto 0);
    signal Sig_Reg_FilaAndar       : std_logic_vector(15 downto 0);
    signal Sig_AndarSelecionado    : std_logic;
    signal Sig_Igual               : std_logic;

    -- Instâncias dos componentes
    component Controladora is
        port (
            Clock      : in std_logic;
            Reset      : in std_logic;
            Sobe       : in std_logic;  -- Recebe do Datapath
            Desce      : in std_logic;  -- Recebe do Datapath
            Atualizar  : out std_logic;
            Subindo    : out std_logic
        );
    end component;

    component Datapath is
        port (
            Subindo              : in std_logic;
            Clock                : in std_logic;
            Atualizar            : in std_logic;
            Andar                : in std_logic_vector(3 downto 0);
            Escolher             : in std_logic;
            Sobe                 : out std_logic;
            Desce                : out std_logic;
            BCD1                 : out std_logic_vector(6 downto 0);
            BCD2                 : out std_logic_vector(6 downto 0);
            Enable_internal      : out std_logic;
            Sig_Proximo          : out std_logic_vector(3 downto 0);
            Sig_Andar            : out std_logic_vector(3 downto 0);
            Sig_Reg_FilaAndar    : out std_logic_vector(15 downto 0);
            Sig_AndarSelecionado : out std_logic;
            Sig_Igual            : out std_logic
        );
    end component;

begin

    -- Instância da Controladora
    instancia_Controladora : Controladora
        port map (
            Clock      => Clock_Controladora,
            Reset      => Reset,
            Sobe       => Sobe_Datapath,
            Desce      => Desce_Datapath,
            Atualizar  => Atualizar_Controladora,
            Subindo    => Subindo_Controladora
        );

    -- Instância do Datapath
    instancia_Datapath : Datapath
        port map (
            Subindo              => Subindo_Controladora,
            Clock                => Clock_Datapath,
            Atualizar            => Atualizar_Controladora,
            Andar                => Andar,
            Escolher             => Escolher,
            Sobe                 => Sobe,
            Desce                => Desce,
            BCD1                 => BCD1,
            BCD2                 => BCD2,
            Enable_internal      => Enable_internal,
            Sig_Proximo          => Sig_Proximo,
            Sig_Andar            => Sig_Andar,
            Sig_Reg_FilaAndar    => Sig_Reg_FilaAndar,
            Sig_AndarSelecionado => Sig_AndarSelecionado,
            Sig_Igual            => Sig_Igual
        );

    -- Atribuindo sinais buffer
    Subindo <= Subindo_Controladora;
    Atualizar <= Atualizar_Controladora;

end Structural;
