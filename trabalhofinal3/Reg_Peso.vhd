library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg_Peso is
    generic (
        W : natural := 10
    );
    port (
        Carregar : in std_logic;
        Clock    : in std_logic;
        Dado     : in std_logic_vector(W-1 downto 0);
        Saida    : out std_logic_vector(W-1 downto 0)
    );
end entity Reg_Peso;

architecture Behavioral of Reg_Peso is
    signal reg : std_logic_vector(W-1 downto 0) := (others => '0');
begin
    process (Clock)
    begin
        if rising_edge(Clock) then
            if Carregar = '1' then
                reg <= Dado;
            end if;
        end if;
    end process;

    Saida <= reg;
end architecture Behavioral;