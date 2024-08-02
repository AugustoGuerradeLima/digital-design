library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Datapath is
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
		BCD1						: out std_logic_vector(6 downto 0);
		BCD2						: out std_logic_vector(6 downto 0);
		Enable_internal      : buffer std_logic; -- Change to buffer
		Sig_Proximo          : buffer std_logic_vector(3 downto 0);
		Sig_Andar            : buffer std_logic_vector(3 downto 0);
		Sig_Reg_FilaAndar    : buffer std_logic_vector(15 downto 0);
		Sig_AndarSelecionado : buffer std_logic
	);
end Datapath;

architecture Structural of Datapath is
	component Contador is
		port (
			Clock   : in  std_logic;
			Reset   : in  std_logic;
			Control : in  std_logic;
			Enable  : in  std_logic;
			Start	  : in  std_logic_vector (3 downto 0) := "0000";
			Count   : out std_logic_vector (3 downto 0)
		);
	end component;
	
	component Reg_FilaAndar is
		generic (
			W     : natural := 16;
			log2W : natural := 4
		);
		port (
			Chamar    : in  std_logic;
			Carregar  : in  std_logic;
			Clock     : in  std_logic;
			Limpar    : in  std_logic;
			Seletor   : in  std_logic_vector(log2W - 1 downto 0);
			SeletorClear : in std_logic_vector(log2W - 1 downto 0);
			Saida     : out std_logic_vector(W-1 downto 0)
		);
	end component;
	
	component Reg_Andar is
		generic (
			W : natural := 4
		);
		port (
			Carregar  : in  std_logic;
			Clock     : in  std_logic;
			Dado      : in  std_logic_vector(W-1 downto 0);
			Saida     : out std_logic_vector(W-1 downto 0)
		);
	end component;
	
	component Mux is
		generic (
			W : integer := 16;
			log2W : integer := 4
		);
		port (
			input_vector : in  std_logic_vector(W-1 downto 0);
			selector     : in  std_logic_vector(log2W-1 downto 0);
			output_value : out std_logic
		);
	end component;
	
	component Comparador is
		generic (
			W: natural := 4
		);
		port (
			A, B : in std_logic_vector(W-1 downto 0);
			Enable : in std_logic;
			Maior, Menor, Igual : out std_logic
		);
	end component;
	
	component BCD_7seg is
		port (
			Entrada: in std_logic_vector(3 downto 0);
			Saida_1: out std_logic_vector(6 downto 0);
			Saida_2: out std_logic_vector(6 downto 0)
		);
	end component;
	
	signal s_Sig_Proximo           : std_logic_vector(3 downto 0);
	signal s_Sig_Andar             : std_logic_vector(3 downto 0);
	signal s_Sig_Reg_FilaAndar     : std_logic_vector(15 downto 0);
	signal s_Sig_AndarSelecionado  : std_logic;
	signal s_Sig_Igual             : std_logic;
	signal s_Enable_internal       : std_logic;
	signal s_Control               : std_logic;

	begin
	
		s_Enable_internal <= not(s_Sig_AndarSelecionado);
		s_Control <= Subindo OR (NOT Descendo) ;

		instancia_ContadorProximo : Contador port map(
			Clock => Clock,
			Reset => Atualizar,
			Start => s_Sig_Andar,
			Enable => s_Enable_internal,
			Control => s_Control, 
			Count => s_Sig_Proximo
		);
		
		instancia_ContadorAndar : Contador port map(
			Clock => Atualizar, 
			Reset => '0', 
			Control => Subindo,
			Enable => '1',
			Count => s_Sig_Andar
		);
	
		instancia_Mux : Mux generic map(W => 16, log2W => 4) 
			port map(
				input_vector => s_Sig_Reg_FilaAndar,
				selector => s_Sig_Proximo,
				output_value => s_Sig_AndarSelecionado
			);
	
		instancia_Reg_FilaAndar : Reg_FilaAndar generic map(W => 16, log2W => 4) 
		port map(
			Chamar => Escolher,
			Limpar => s_Sig_Igual,
			Carregar => '1',
			Clock => Clock,
			Seletor => Andar,
			SeletorClear => s_Sig_Andar,
			Saida => s_Sig_Reg_FilaAndar
		);
		
		instancia_Comparador1 : Comparador generic map(W => 4) 
		port map(
			A => s_Sig_Proximo,
			B => s_Sig_Andar,
			Enable => s_Sig_AndarSelecionado,
			Igual => s_Sig_Igual,
			Maior => Sobe,
			Menor => Desce
		);
		
		instancia_BCD : BCD_7Seg port map(
			Entrada  => s_Sig_Andar,
			Saida_1	=> BCD1,
			Saida_2	=> BCD2
		);

		-- Assign intermediate signals to output ports
		Sig_Proximo <= s_Sig_Proximo;
		Sig_Andar <= s_Sig_Andar;
		Sig_Reg_FilaAndar <= s_Sig_Reg_FilaAndar;
		Sig_AndarSelecionado <= s_Sig_AndarSelecionado;
		Igual <= s_Sig_Igual;
		Enable_internal <= s_Enable_internal;
	
end Structural;
