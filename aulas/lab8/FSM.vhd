LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSM is
  PORT (
    RESET  : IN  std_logic;
    CLOCK  : IN  std_logic;
    E      : IN  std_logic_vector(3 downto 0);
    MEDIA  : OUT std_logic_vector(6 downto 0);
    SOBE   : OUT std_logic;
    DESCE  : OUT std_logic;
    SIG_E  : OUT std_logic_vector(3 downto 0);
    SIG_M  : OUT std_logic_vector(3 downto 0)
  );
END FSM;

ARCHITECTURE structural OF FSM is
  COMPONENT Datapath is
    PORT (
      E         : IN  std_logic_vector(3 downto 0);
      Sobe      : OUT std_logic;
      Desce     : OUT std_logic;
      Media     : OUT std_logic_vector(6 downto 0);
      load_E    : IN  std_logic;
      Reset_MA  : IN  std_logic;
      Maior     : OUT std_logic;
      Menor     : OUT std_logic;
      Descendo  : IN  std_logic;
      Subindo   : IN  std_logic;
      Atualizar : IN  std_logic;
      clock     : IN  std_logic;
      Sig_E_out : OUT std_logic_vector(3 downto 0);
      Sig_M_out : OUT std_logic_vector(3 downto 0)
    );
  END COMPONENT;

  COMPONENT Controladora is
    PORT (
      RESET    : IN  std_logic;
      CLOCK    : IN  std_logic;
      Maior    : IN  std_logic;
      Menor    : IN  std_logic;
      Load_E   : OUT std_logic;
      Reset_MA : OUT std_logic;
      Subindo  : OUT std_logic;
      Descendo : OUT std_logic;
      Atualize : OUT std_logic
    );
  END COMPONENT;

  SIGNAL Load_E, Reset_MA, Maior, Menor, Descendo, Subindo, Atualize : std_logic;

BEGIN
  instancia_Controladora: Controladora PORT MAP (
    RESET => RESET,
    CLOCK => CLOCK,
    Maior => Maior,
    Menor => Menor,
    Load_E => Load_E,
    Reset_MA => Reset_MA,
    Subindo => Subindo,
    Descendo => Descendo,
    Atualize => Atualize
  );

  instancia_Datapath: Datapath PORT MAP (
    E => E,
    Sobe => SOBE,
    Desce => DESCE,
    Media => MEDIA,
    load_E => Load_E,
    Reset_MA => Reset_MA,
    Maior => Maior,
    Menor => Menor,
    Descendo => Descendo,
    Subindo => Subindo,
    Atualizar => Atualize,
    clock => CLOCK,
    Sig_E_out => SIG_E,
    Sig_M_out => SIG_M
  );

END structural;
