library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg_Senha is
end entity tb_Reg_Senha;

architecture Behavioral of tb_Reg_Senha is
    constant W : natural := 14;
    
    signal Carregar : std_logic := '0';
    signal Clock    : std_logic := '0';
    signal Dado     : std_logic_vector(W-1 downto 0) := (others => '0');
    signal Saida    : std_logic_vector(W-1 downto 0);

    -- Clock period definition
    constant Clock_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    instancia_Reg_Senha : entity work.Reg_Senha
        generic map (
            W => W  -- Pass the generic value W
        )
        port map (
            Dado     => Dado,      -- Connect Dado signal
            Carregar => Carregar,  -- Connect Carregar signal
            Clock    => Clock,     -- Connect Clock signal
            Saida    => Saida      -- Connect Saida signal
        );
    
    -- Clock generation process
    Clock_process : process
    begin
        Clock <= '0';
        wait for Clock_period / 2;
        Clock <= '1';
        wait for Clock_period / 2;
    end process Clock_process;

    -- Stimulus process
    Stimulus: process
    begin
        -- Initialize inputs
        Carregar <= '0';
        Dado <= (others => '0');
        wait for Clock_period;

        -- Test case 1: Load 0001 into the register
        Dado <= "10101010100001";
        Carregar <= '1';
        wait for Clock_period;
        Carregar <= '0';
        wait for Clock_period;
        
        -- Test case 2: Load 0010 into the register
        Dado <= "10101010100010";
        Carregar <= '1';
        wait for Clock_period;
        Carregar <= '0';
        wait for Clock_period;

        -- Test case 3: No load, keep the previous value
        Dado <= "10101010100100";
        Carregar <= '0';
        wait for Clock_period;

        -- Test case 4: Load 1111 into the register
        Dado <= "10101010101111";
        Carregar <= '1';
        wait for Clock_period;
        Carregar <= '0';
        wait for Clock_period;

        -- Test case 5: No load, keep the previous value
        Dado <= "10101010100000";
        Carregar <= '0';
        wait for Clock_period;

        wait;
    end process Stimulus;

end architecture Behavioral;
