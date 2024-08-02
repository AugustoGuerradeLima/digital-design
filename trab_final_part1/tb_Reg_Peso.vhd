library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg_Peso is
end entity tb_Reg_Peso;

architecture Behavioral of tb_Reg_Peso is
    constant W : natural := 10;

    signal Carregar : std_logic := '0';
    signal Clock    : std_logic := '0';
    signal Dado     : std_logic_vector(W-1 downto 0) := (others => '0');
    signal Saida    : std_logic_vector(W-1 downto 0);


    component Reg_Peso is
        generic (
            W : natural := 10
        );
        port (
            Carregar : in std_logic;
            Clock    : in std_logic;
            Dado     : in std_logic_vector(W-1 downto 0);
            Saida    : out std_logic_vector(W-1 downto 0)
        );
    end component;

begin

    uut: Reg_Peso
        generic map (
            W => W
        )
        port map (
            Carregar => Carregar,
            Clock    => Clock,
            Dado     => Dado,
            Saida    => Saida
        );


    Clock <= not Clock after 10 ns;


    stim_proc: process
    begin

        Carregar <= '0';
        Dado <= (others => '0');
        wait for 20 ns;


        Dado <= "0000001010";
        Carregar <= '1';
        wait for 20 ns;
        Carregar <= '0';
        wait for 20 ns;


        Dado <= "0010010101";
        Carregar <= '1';
        wait for 20 ns;
        Carregar <= '0';
        wait for 20 ns;


        Dado <= "1011111111";
        Carregar <= '1';
        wait for 20 ns;
        Carregar <= '0';
        wait for 20 ns;


        wait;
    end process;
end architecture Behavioral;
