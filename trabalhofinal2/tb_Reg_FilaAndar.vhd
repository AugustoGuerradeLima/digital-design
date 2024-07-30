library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg_FilaAndar is
end entity tb_Reg_FilaAndar;

architecture behavior of tb_Reg_FilaAndar is
    -- Component declaration for the unit under test (UUT)
    component Reg_FilaAndar is
        generic (
            W     : natural := 16;
            log2W : natural := 4
        );
        port (
            Chamar    : in  std_logic;
            Limpar    : in  std_logic;
            Carregar  : in  std_logic;
            Clock     : in  std_logic;
            Seletor   : in  std_logic_vector(log2W - 1 downto 0);
            SeletorClear : in  std_logic_vector(log2W - 1 downto 0);
            Saida     : out std_logic_vector(W-1 downto 0)
        );
    end component;

    -- Signals for testbench
    signal Chamar        : std_logic := '0';
    signal Limpar        : std_logic := '0';
    signal Carregar      : std_logic := '0';
    signal Clock         : std_logic := '0';
    signal Seletor       : std_logic_vector(3 downto 0) := (others => '0');
    signal SeletorClear  : std_logic_vector(3 downto 0) := (others => '0');
    signal Saida         : std_logic_vector(15 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Reg_FilaAndar
        generic map (
            W     => 16,
            log2W => 4
        )
        port map (
            Chamar        => Chamar,
            Limpar        => Limpar,
            Carregar      => Carregar,
            Clock         => Clock,
            Seletor       => Seletor,
            SeletorClear  => SeletorClear,
            Saida         => Saida
        );

    -- Clock generation process
    clk_process : process
    begin
        Clock <= '0';
        wait for clk_period/2;
        Clock <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial values
        Chamar        <= '0';
        Limpar        <= '0';
        Carregar      <= '0';
        Seletor       <= "0000";  -- Select floor 0
        SeletorClear  <= "0000";  -- Clear floor 0
        wait for clk_period;

        -- Test case 1: Load floor 3
        Carregar      <= '1';
        Chamar        <= '1';
        Seletor       <= "0011";  -- Select floor 3
        wait for clk_period;
        Carregar      <= '0';
        Chamar        <= '0';
        wait for clk_period;

        -- Check output for floor 3
        assert (Saida = "0000000000001000")
            report "Test Case 1 Failed: Expected floor 3 to be set."
            severity error;

        -- Test case 2: Clear floor 3
        Carregar      <= '1';
        Limpar        <= '1';
        SeletorClear  <= "0011";  -- Select floor 3
        wait for clk_period;
        Carregar      <= '0';
        Limpar        <= '0';
        wait for clk_period;

        -- Check output for floor 3
        assert (Saida = "0000000000000000")
            report "Test Case 2 Failed: Expected floor 3 to be cleared."
            severity error;

        -- Test case 3: Load floor 7
        Carregar      <= '1';
        Chamar        <= '1';
        Seletor       <= "0111";  -- Select floor 7
        wait for clk_period;
        Carregar      <= '0';
        Chamar        <= '0';
        wait for clk_period;

        -- Check output for floor 7
        assert (Saida = "0000000100000000")
            report "Test Case 3 Failed: Expected floor 7 to be set."
            severity error;

        -- Test case 4: Load floor 0 and floor 15
        Carregar      <= '1';
        Chamar        <= '1';
        Seletor       <= "0000";  -- Select floor 0
        wait for clk_period;
        Seletor       <= "1111";  -- Select floor 15
        wait for clk_period;
        Carregar      <= '0';
        Chamar        <= '0';
        wait for clk_period;

        -- Check output for floor 0 and floor 15
        assert (Saida = "1000000000000001")
            report "Test Case 4 Failed: Expected floor 0 and 15 to be set."
            severity error;

        -- End simulation
        wait;
    end process;

end architecture behavior;