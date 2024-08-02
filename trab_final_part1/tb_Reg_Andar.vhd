library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg_Andar is
end entity tb_Reg_Andar;

architecture Behavioral of tb_Reg_Andar is
    constant W : natural := 4;
    
    signal Carregar : std_logic := '0';
    signal Clock    : std_logic := '0';
    signal Dado     : std_logic_vector(W-1 downto 0) := (others => '0');
    signal Saida    : std_logic_vector(W-1 downto 0);


    constant Clock_period : time := 10 ns;

begin
    uut: entity work.Reg_Andar
        generic map (
            W => W
        )
        port map (
            Carregar => Carregar,
            Clock    => Clock,
            Dado     => Dado,
            Saida    => Saida
        );


    Clock_process : process
    begin
        Clock <= '0';
        wait for Clock_period / 2;
        Clock <= '1';
        wait for Clock_period / 2;
    end process Clock_process;


    Stimulus: process
    begin

        Carregar <= '0';
        Dado <= (others => '0');
        wait for Clock_period;


        Dado <= "0001";
        Carregar <= '1';
        wait for Clock_period;
        Carregar <= '0';
        wait for Clock_period;
        assert (Saida = "0001") report "Test case 1 failed" severity error;
        
 
        Dado <= "0010";
        Carregar <= '1';
        wait for Clock_period;
        Carregar <= '0';
        wait for Clock_period;
        assert (Saida = "0010") report "Test case 2 failed" severity error;

 
        Dado <= "0100";
        Carregar <= '0';
        wait for Clock_period;
        assert (Saida = "0010") report "Test case 3 failed" severity error;

 
        Dado <= "1111";
        Carregar <= '1';
        wait for Clock_period;
        Carregar <= '0';
        wait for Clock_period;
        assert (Saida = "1111") report "Test case 4 failed" severity error;


        Dado <= "0000";
        Carregar <= '0';
        wait for Clock_period;
        assert (Saida = "1111") report "Test case 5 failed" severity error;

        wait;
    end process Stimulus;

end architecture Behavioral;
