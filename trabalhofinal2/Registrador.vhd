library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg_FilaAndar is
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
end entity Reg_FilaAndar;

architecture Behavioral of Reg_FilaAndar is
    signal reg : std_logic_vector(W-1 downto 0) := (others => '0');
begin
    process (Clock)
    begin
        if rising_edge(Clock) then
            if Carregar = '1' then
                reg(to_integer(unsigned(Seletor))) <= Dado;
            end if;
        end if;
    end process;

    Saida <= reg;

end architecture Behavioral;