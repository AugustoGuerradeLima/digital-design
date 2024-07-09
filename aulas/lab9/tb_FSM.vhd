LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY tb_FSM is
END tb_FSM;

ARCHITECTURE behavior OF tb_FSM is 

  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT FSM
    PORT (
      RESET  : IN  std_logic;
      CLOCK  : IN  std_logic;
      E      : IN  std_logic_vector(3 downto 0);
      MEDIA  : OUT std_logic_vector(6 downto 0);
      SOBE   : OUT std_logic;
      DESCE  : OUT std_logic
      --SIG_E  : OUT std_logic_vector(3 downto 0);
      --SIG_M  : OUT std_logic_vector(3 downto 0)
    );
  END COMPONENT;

  -- Inputs
  SIGNAL RESET : std_logic := '0';
  SIGNAL CLOCK : std_logic := '0';
  SIGNAL E     : std_logic_vector(3 downto 0) := (others => '0');

  -- Outputs
  SIGNAL MEDIA : std_logic_vector(6 downto 0);
  SIGNAL SOBE  : std_logic;
  SIGNAL DESCE : std_logic;
  --SIGNAL SIG_E : std_logic_vector(3 downto 0);
  --SIGNAL SIG_M : std_logic_vector(3 downto 0);

  -- Clock period definitions
  CONSTANT CLOCK_PERIOD : time := 20 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: FSM PORT MAP (
    RESET => RESET,
    CLOCK => CLOCK,
    E     => E,
    MEDIA => MEDIA,
    SOBE  => SOBE,
    DESCE => DESCE
    --SIG_E => SIG_E,
    --SIG_M => SIG_M
  );

  -- Clock process definitions
  CLOCK_process : process
  begin
    while true loop
      CLOCK <= '0';
      wait for CLOCK_PERIOD / 2;
      CLOCK <= '1';
      wait for CLOCK_PERIOD / 2;
    end loop;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    -- Hold reset state for 30 ns.
    RESET <= '1';
    wait for 30 ns;
    RESET <= '0';
    E <= "0000";
    wait for 100 ns;

    -- Apply input stimulus with varying E values
    E <= "0001";
    wait for 20 ns;
    
    E <= "0110";
    wait for 20 ns;
    
    E <= "0010";
    wait for 20 ns;
    
    E <= "0100";
    wait for 20 ns;
    
    E <= "0101";
    wait for 20 ns;

    E <= "0000";
    wait for 20 ns;



    -- Add more test sequences as required
    wait;
  end process;

END;
