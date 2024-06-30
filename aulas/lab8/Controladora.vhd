library IEEE;
use IEEE.std_logic_1164.all;

entity Controladora is
    port 
    (
        RESET     : in    std_logic;
        CLOCK     : in    std_logic;
        Maior     : in    std_logic;
        Menor     : in    std_logic;
        Load_E    : out   std_logic;
        Reset_MA  : out   std_logic;
        Subindo   : out   std_logic;
        Descendo  : out   std_logic;
        Atualize  : out   std_logic
    );
end Controladora;

architecture Moore_TPM of Controladora is
    type estado is (S0, S1, S2, S3, S4);
    signal estado_atual, proximo_estado : estado;
begin
    -----------------------------------------
    sequencial_process:
    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            estado_atual <= S0;
        elsif rising_edge(CLOCK) then
            estado_atual <= proximo_estado;
        end if;
    end process sequencial_process;
    
    -----------------------------------------
    combinacional_process:
    process(estado_atual, Maior, Menor)
    begin
        proximo_estado <= estado_atual;
        
        case estado_atual is
            when S0 => 
                Load_E    <= '1';
                Reset_MA  <= '1';
                Subindo   <= '1';
                Descendo  <= '1';
                Atualize  <= '1';
                proximo_estado <= S1;

            when S1 =>
                Load_E    <= '1';
                Reset_MA  <= '0';
                Atualize  <= '0';

                if Maior = '1' then
                    proximo_estado <= S2;
                elsif Maior = '0' and Menor = '1' then
                    proximo_estado <= S3;
                elsif Maior = '0' and Menor = '0' then
                    proximo_estado <= S4;
                end if;

            when S2 => 
                Load_E    <= '1';
                Subindo   <= '1';
                Descendo  <= '0';
                Atualize  <= '1';
                Reset_MA  <= '0';
                proximo_estado <= S1;

            when S3 => 
                Load_E    <= '1';
                Subindo   <= '0';
                Descendo  <= '1';
                Atualize  <= '1';
                Reset_MA  <= '0';
                proximo_estado <= S1;

            when S4 =>
                Load_E    <= '1';
                Subindo   <= '0';
                Descendo  <= '0';
                Atualize  <= '1';
                Reset_MA  <= '0';
                proximo_estado <= S1;

            when others =>
                Load_E    <= '0';
                Subindo   <= '0';
                Descendo  <= '0';
                Atualize  <= '0';
                Reset_MA  <= '0';
        end case;
    end process combinacional_process;
end Moore_TPM;