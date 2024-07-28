library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg_FilaAndar is
end tb_Reg_FilaAndar;

architecture Behavioral of tb_Reg_FilaAndar is
    -- Component declaration for the Unit Under Test (UUT)
    component Reg_FilaAndar
        generic (
            W     : natural := 16;
            log2W : natural := 4
        );
        port (
            Dado      : in  std_logic;
            Carregar  : in  std_logic;
            Clock     : in  std_logic;
            Seletor   : in  std_logic_vector(log2W - 1 downto 0);
            Saida     : out std_logic_vector(W-1 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal Dado     : std_logic;
    signal Carregar : std_logic;
    signal Clock    : std_logic := '0';
    signal Seletor  : std_logic_vector(3 downto 0);
    signal Saida    : std_logic_vector(15 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Reg_FilaAndar
        generic map (
            W => 16,
            log2W => 4
        )
        port map (
            Dado      => Dado,
            Carregar  => Carregar,
            Clock     => Clock,
            Seletor   => Seletor,
            Saida     => Saida
        );

    -- Clock generation
    Clock <= not Clock after 10 ns;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize Inputs
        Dado <= '0';
        Carregar <= '0';
        Seletor <= (others => '0');
        wait for 20 ns;

        -- Test case 1: Load bit 0 with '1'
        Dado <= '1';
        Seletor <= "0000";
        Carregar <= '1';
        wait for 20 ns;  -- Wait for clock edge
        Carregar <= '0';
        wait for 20 ns;

        -- Test case 2: Load bit 15 with '1'
        Dado <= '1';
        Seletor <= "1111";
        Carregar <= '1';
        wait for 20 ns;  -- Wait for clock edge
        Carregar <= '0';
        wait for 20 ns;

        -- Test case 3: Load bit 8 with '0'
        Dado <= '0';
        Seletor <= "1000";
        Carregar <= '1';
        wait for 20 ns;  -- Wait for clock edge
        Carregar <= '0';
        wait for 20 ns;

		 -- Test case 4: Load bit 15 with '0'
        Dado <= '0';
        Seletor <= "1111";
        Carregar <= '1';
        wait for 20 ns;  -- Wait for clock edge
        Carregar <= '0';
        wait for 20 ns;
		  
        -- Stop the simulation
        wait;
    end process;

end architecture Behavioral;
