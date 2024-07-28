library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Contador is
    port (
			Clock   : in  std_logic;                 -- Clock
			Reset   : in  std_logic;                 -- Reset
			Control : in  std_logic;                 -- Controle (1 para incrementar, 0 para decrementar)
			Start	  : in  std_logic_vector(3 downto 0); -- Valor inicial para o contador (4 bits)
			Enable  : in  std_logic;                 	  -- Habilitação
			W       : in  std_logic_vector(3 downto 0); -- Valor máximo para o contador (4 bits)
			Count   : out std_logic_vector(3 downto 0)  -- Saída do contador (4 bits)
    );
end Contador;

architecture Behavioral of Contador is
    signal cnt : std_logic_vector(3 downto 0) := (others => '0'); -- Contador interno (4 bits)
    signal W_int : integer; -- Valor máximo convertido para integer
    signal direction : std_logic := '1'; -- Direção do contador ('1' para incrementar, '0' para decrementar)
begin
    -- Conversão de W de std_logic_vector para integer
    W_int <= to_integer(unsigned(W));

    process (Clock, Reset)
    begin
        if Reset = '1' then
            cnt <= std_logic_vector(unsigned(Start)); -- Reset do contador e iniciar com o valor de Start
            direction <= '1'; -- Reiniciar a direção para incrementar
        elsif rising_edge(Clock) then
            if Enable = '1' then
                if direction = '1' then
                    if to_integer(unsigned(cnt)) < W_int then
                        cnt <= std_logic_vector(unsigned(cnt) + 1); -- Incrementa
                    else
                        direction <= '0'; -- Mudar direção para decrementar
                    end if;
                elsif direction = '0' then
                    if to_integer(unsigned(cnt)) > 0 then
                        cnt <= std_logic_vector(unsigned(cnt) - 1); -- Decrementa
                    else
                        direction <= '1'; -- Mudar direção para incrementar
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Conversão de std_logic_vector para std_logic_vector para saída
    Count <= cnt; -- Saída do contador
end Behavioral;
