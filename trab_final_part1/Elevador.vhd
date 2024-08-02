library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Elevador is
    port (
        Clock_Controladora   : in std_logic;
        Clock_Datapath        : in std_logic;
        Reset                 : in std_logic;
        Andar                 : in std_logic_vector(3 downto 0);
        Escolher              : in std_logic;
        Sobe                  : out std_logic;
        Desce                 : out std_logic;
		  Igual						: out std_logic;
        BCD1                  : out std_logic_vector(6 downto 0);
        BCD2                  : out std_logic_vector(6 downto 0);
        Subindo               : out std_logic;
		  Descendo					: out std_logic;
        Atualizar             : out std_logic
    );
end Elevador;
architecture Structural of Elevador is

    signal Atualizar_Controladora : std_logic;
    signal Descendo_Controladora  : std_logic;
	 signal Subindo_Controladora   : std_logic;
	 signal Sobe_Datapath          : std_logic;
    signal Desce_Datapath         : std_logic;
	 signal Igual_Datapath			 : std_logic;
    signal Sig_Proximo            : std_logic_vector(3 downto 0);
    signal Sig_Andar              : std_logic_vector(3 downto 0);
    signal Sig_Reg_FilaAndar      : std_logic_vector(15 downto 0);
    signal Sig_AndarSelecionado   : std_logic;

    component Controladora is
        port (
            Clock      : in std_logic;
            Reset      : in std_logic;
            Sobe       : in std_logic;
            Desce      : in std_logic;
				Igual		  : in std_logic;
            Atualizar  : out std_logic;
            Subindo    : out std_logic;
				Descendo	  : out std_logic
        );
    end component;

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
            BCD1                 : out std_logic_vector(6 downto 0);
            BCD2                 : out std_logic_vector(6 downto 0);
            Sig_Proximo          : out std_logic_vector(3 downto 0);
            Sig_Andar            : out std_logic_vector(3 downto 0);
            Sig_Reg_FilaAndar    : out std_logic_vector(15 downto 0);
            Sig_AndarSelecionado : out std_logic
        );
    end component;

begin

    U1: Controladora
        port map (
            Clock      => Clock_Controladora,
            Reset      => Reset,
            Sobe       => Sobe_Datapath,
            Desce      => Desce_Datapath,
				Igual		  => Igual_Datapath,
            Atualizar  => Atualizar_Controladora,
            Subindo    => Subindo_Controladora,
				Descendo	  => Descendo_Controladora
        );

    U2: Datapath
        port map (
            Subindo              => Subindo_Controladora,
				Descendo					=> Descendo_Controladora,
            Clock                => Clock_Datapath,
            Atualizar            => Atualizar_Controladora,
            Andar                => Andar,
            Escolher             => Escolher,
            Sobe                 => Sobe_Datapath,
            Desce                => Desce_Datapath,
				Igual						=> Igual_Datapath,
            BCD1                 => BCD1,
            BCD2                 => BCD2,
            Sig_Proximo          => Sig_Proximo,
            Sig_Andar            => Sig_Andar,
            Sig_Reg_FilaAndar    => Sig_Reg_FilaAndar,
            Sig_AndarSelecionado => Sig_AndarSelecionado
        );

    Subindo <= Subindo_Controladora;
	 Descendo <= Descendo_Controladora;
    Atualizar <= Atualizar_Controladora;
	 Sobe	<= Sobe_Datapath;
	 Desce <= Desce_Datapath;
	 Igual <= Igual_Datapath;

end Structural;