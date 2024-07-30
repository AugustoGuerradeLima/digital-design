library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controladora is
    port (
        Clock      : in std_logic;
        Reset      : in std_logic;
        Sobe       : in std_logic;  -- Entrada do Datapath
        Desce      : in std_logic;  -- Entrada do Datapath
        Igual      : in std_logic;
        Atualizar  : out std_logic;
        Subindo    : out std_logic  -- Saída de controle para indicar subida
    );
end Controladora;

architecture Behavioral of Controladora is

    -- Define os estados da FSM
    type state_type is (Inicial, ElevadorSubindo, ElevadorDescendo);
    signal state, next_state : state_type;

begin

    -- Processo de transição de estados
    process (Clock, Reset)
    begin
        if Reset = '1' then
            state <= Inicial;
        elsif rising_edge(Clock) then
            state <= next_state;
        end if;
    end process;

    -- Processo de lógica de controle
    process (state, Sobe, Desce, Igual)
    begin
        -- Inicializa as saídas
        Atualizar <= '0';
        Subindo <= '0';

        case state is
            when Inicial =>
					Subindo <= '0';
                if Sobe = '1' then
                    next_state <= ElevadorSubindo;
                    Atualizar <= '1';
                    Subindo <= '1';
                elsif Desce = '1' then
                    next_state <= ElevadorDescendo;
                    Atualizar <= '1';
                    Subindo <= '0';
                else
                    next_state <= Inicial;
                end if;
        
            when ElevadorSubindo =>
                if Igual = '1' then
                    next_state <= Inicial;
                else
                    next_state <= ElevadorSubindo;
                    Atualizar <= '1';
                    Subindo <= '1';
                end if;
        
            when ElevadorDescendo =>
                if Igual = '1' then
                    next_state <= Inicial;
                else
                    next_state <= ElevadorDescendo;
                    Atualizar <= '1';
                    Subindo <= '0';
                end if;
        
            when others =>
                next_state <= Inicial;
        end case;
    end process;

end Behavioral;
