library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Datapath is
	port
	(
		E 		: in std_logic_vector(3 downto 0);
		Sobe	: out std_logic := '0';
		Desce	: out	std_logic := '0';
		Media	: out std_logic_vector(6 downto 0);

		load_E 		: in std_logic;
		Reset_MA 	: in std_logic;
		Maior			: out std_logic;
		Menor			: out std_logic;
		Descendo		: in std_logic;
		Subindo		: in std_logic;
		Atualizar	: in std_logic;
		clock			: in std_logic;

		Sig_E_out : out std_logic_vector(3 downto 0);
		Sig_M_out : out std_logic_vector(3 downto 0)
	);
end Datapath;

architecture structural of Datapath is
	component	Reg_W	is
		generic
		(
				W: natural
		);
		port
		(
			clock: in std_logic;
			load:  in std_logic;
			reset: in std_logic;
			D: 	 in std_logic_vector (W-1 downto 0);
			Q: 	 out std_logic_vector(W-1 downto 0)
		);
	end component;
	
	component 	Reg_MA is
		port
		(
			clock   : in  std_logic;
			RESET   : in  std_logic;
			INPUT   : in  std_logic_vector(3 downto 0);
			OUTPUT  : out std_logic_vector(3 downto 0)
		);
	end component;
	
	component	Comparador is
		generic
		(
				DATA_WIDTH: natural := 4
		);
		port
		(
			a,b : in std_logic_vector(DATA_WIDTH-1 downto 0);
			maior, menor, igual : out std_logic
		);
	end component;
	
	component	BCD_7seg is
		port
		(
			entrada: in std_logic_vector 	(3 downto 0);
			saida:	out std_logic_vector (6 downto 0)
		);
	end component;
	
    signal Sig_E : std_logic_vector(3 downto 0) := "0000";
    signal Sig_M : std_logic_vector(3 downto 0) := "0000";
	 
	begin
		instancia_Reg_E		:	Reg_W   		generic map(W=>4) port map(clock=>clock, reset=>'0', load=>load_E, D=>E, Q=>Sig_E);
		instancia_Reg_SD		:	Reg_W   		generic map(W=>2) port map(clock=>clock, reset=>'0', load=>Atualizar, D(1)=>Subindo, D(0)=>Descendo, Q(1)=>Sobe, Q(0)=>Desce);
		instancia_Reg_MA		:	Reg_MA 		port map	(clock=>clock, RESET=>Reset_MA, INPUT=>Sig_E, OUTPUT=>Sig_M);
		instancia_Comparador	:	Comparador 	port map(a=>Sig_E,b=>Sig_M, maior=>Maior, menor=>Menor);
		instancia_BCD_7seg	:	BCD_7seg		port map(entrada=>Sig_M, saida=>Media);
		
		Sig_E_out <= Sig_E;
		Sig_M_out <= Sig_M;
	
end structural;
