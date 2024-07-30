library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Contador is
end tb_Contador;

architecture behavior of tb_Contador is
    -- Sinais para conectar ao DUT (Design Under Test)
    signal Clock   : std_logic := '0';
    signal Reset   : std_logic := '0';
    signal Control : std_logic := '0';
    signal W       : integer := 15;
    signal Count   : integer;

    -- Periodo do clock
    constant Clock_Period : time := 10 ns;

    -- Instância do DUT
    component Contador
        Port (
            Clock   : in  std_logic;
            Reset   : in  std_logic;
            Control : in  std_logic;
            W       : in  integer;
            Count   : out integer
        );
    end component;
begin
    -- Instância do Contador
    uut: Contador
        Port map (
            Clock   => Clock,
            Reset   => Reset,
            Control => Control,
            W       => W,
            Count   => Count
        );

    -- Geração do clock
    Clock_Process : process
    begin
        Clock <= '0';
        wait for Clock_Period / 2;
        Clock <= '1';
        wait for Clock_Period / 2;
    end process;

    -- Estímulos para o DUT
    Stimulus_Process : process
    begin
        -- Inicialização
        Reset <= '1';
        wait for Clock_Period * 2;
        Reset <= '0';
        
        -- Teste de incremento
        Control <= '1';  -- Modo de incremento
        wait for Clock_Period * 10;  -- Espera para ver o incremento

        -- Teste de decremento
        Control <= '0';  -- Modo de decremento
        wait for Clock_Period * 10;  -- Espera para ver o decremento

        -- Teste com valor máximo
        Control <= '1';  -- Modo de incremento
        wait for Clock_Period * (W - Count + 1);  -- Espera até o contador atingir W

        -- Teste de decremento após atingir o máximo
        Control <= '0';  -- Modo de decremento
        wait for Clock_Period * (W - Count + 1);  -- Espera para ver o decremento

        -- Finalização da simulação
        wait;
    end process;
end behavior;
