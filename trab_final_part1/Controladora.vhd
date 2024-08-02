library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controladora is
    port (
        Clock      : in std_logic;
        Reset      : in std_logic;
        Sobe       : in std_logic;
        Desce      : in std_logic;
        Igual      : in std_logic;
        Atualizar  : out std_logic;
        Subindo    : out std_logic;
        Descendo   : out std_logic
    );
end Controladora;

architecture Behavioral of Controladora is

    type state_type is (Inicial, ElevadorSubindo, ElevadorDescendo);
    signal state, next_state : state_type;

begin

    process (Clock, Reset)
    begin
        if Reset = '1' then
            state <= Inicial;
        elsif rising_edge(Clock) then
            state <= next_state;
        end if;
    end process;

    process (state, Sobe, Desce, Igual)
    begin
        Atualizar <= '0';
        Subindo <= '0';
        Descendo <= '0';

        case state is
            when Inicial =>
                if Sobe = '1' then
                    next_state <= ElevadorSubindo;
                elsif Desce = '1' then
                    next_state <= ElevadorDescendo;
                else
                    next_state <= Inicial;
                end if;

            when ElevadorSubindo =>
                next_state <= Inicial;
                Atualizar <= '1';
                Subindo <= '1';

            when ElevadorDescendo =>
                next_state <= Inicial;
                Atualizar <= '1';
                Descendo <= '1';

            when others =>
                next_state <= Inicial;
        end case;
    end process;

end Behavioral;
