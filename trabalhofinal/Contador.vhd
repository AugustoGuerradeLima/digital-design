library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Contador is
    port (
        Clock   : in  std_logic;                 -- Clock
        Reset   : in  std_logic;                 -- Reset
        Control : in  std_logic;                 -- Controle (1 para incrementar, 0 para decrementar)
        Start   : in  std_logic_vector(3 downto 0); -- Valor inicial para o contador (4 bits)
        Enable  : in  std_logic;                 -- Habilitação
        Count   : out std_logic_vector(3 downto 0)  -- Saída do contador (4 bits)
    );
end Contador;

architecture Behavioral of Contador is
    signal cnt : std_logic_vector(3 downto 0) := (others => '0'); -- Contador interno (4 bits)
    signal W_int : integer := 15; -- Valor máximo fixo para 4 bits
    signal counting_up : boolean := true; -- Sinal para controlar a direção do contador
begin
    process (Clock, Reset)
    begin
        if Reset = '1' then
            cnt <= Start; -- Reset do contador e iniciar com o valor de Start
            counting_up <= Control = '1'; -- Define a direção inicial com base em Control
        elsif rising_edge(Clock) then
            if Enable = '1' then
                if Control = '1' then -- Incrementar
                    if counting_up then
                        if to_integer(unsigned(cnt)) < W_int then
                            cnt <= std_logic_vector(unsigned(cnt) + 1); -- Incrementa
                        else
                            counting_up <= false; -- Mudar para decrementar
                            cnt <= std_logic_vector(unsigned(cnt) - 1); -- Mudar para decrementar
                        end if;
                    else
                        if to_integer(unsigned(cnt)) > 0 then
                            cnt <= std_logic_vector(unsigned(cnt) - 1); -- Decrementa
                        else
                            counting_up <= true; -- Mudar para incrementar
                            cnt <= std_logic_vector(unsigned(cnt) + 1); -- Mudar para incrementar
                        end if;
                    end if;
                elsif Control = '0' then -- Decrementar
                    if counting_up then
                        if to_integer(unsigned(cnt)) > 0 then
                            cnt <= std_logic_vector(unsigned(cnt) - 1); -- Decrementa
                        else
                            counting_up <= false; -- Mudar para incrementar
                            cnt <= std_logic_vector(unsigned(cnt) + 1); -- Mudar para incrementar
                        end if;
                    else
                        if to_integer(unsigned(cnt)) < W_int then
                            cnt <= std_logic_vector(unsigned(cnt) + 1); -- Incrementa
                        else
                            counting_up <= true; -- Mudar para decrementar
                            cnt <= std_logic_vector(unsigned(cnt) - 1); -- Mudar para decrementar
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Atribuição do contador para a saída
    Count <= cnt;
end Behavioral;
