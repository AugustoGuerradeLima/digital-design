library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Controladora is
    port (
        Clock      : in std_logic;
        Reset      : in std_logic;
        Sobe       : in std_logic;  -- Entrada do Datapath
        Desce      : in std_logic;  -- Entrada do Datapath
        Atualizar  : out std_logic;
        Subindo    : out std_logic  -- Saída de controle para indicar subida
    );
end Controladora;

architecture Behavioral of Controladora is

    -- Define os estados da FSM
    type state_type is (Inicial, Subindo_State, Descendo);
    signal state, next_state : state_type;

begin

    -- Processamento de transição de estados e atualização de sinais
    process(Clock, Reset)
    begin
        if Reset = '1' then
            state <= Inicial;
        elsif rising_edge(Clock) then
            state <= next_state;
        end if;
    end process;

    -- Lógica para determinar o próximo estado e as saídas
    process(state, Sobe, Desce)
    begin
        -- Inicialmente, defina Atualizar como '0'
        Atualizar <= '0';
        Subindo <= '1';  -- Inicialmente, desativa o sinal de subida
        
        case state is
            when Inicial =>
					Atualizar <= '0';
                if Sobe = '1' then
							Atualizar <= '1';
                    next_state <= Subindo_State;
                elsif Desce = '1' then
							Atualizar <= '1';	
							next_state <= Descendo;
                else
                    next_state <= Inicial;  -- Manter no estado Inicial se não houver comando
                end if;
                
            when Subindo_State =>
					Subindo <=	 '1';    -- Ativa o sinal de subida
					Atualizar <= '1';
					next_state <= Inicial;  -- Volta ao estado Inicial após ativar Atualizar

            when Descendo =>
                Subindo <= '0';    -- Desativa o sinal de subida
					Atualizar <= '1';
						next_state <= Inicial;  -- Volta ao estado Inicial após desativar Atualizar
                
            when others =>
                next_state <= Inicial;  -- Definir um estado padrão para casos não cobertos
        end case;
    end process;

end Behavioral;
