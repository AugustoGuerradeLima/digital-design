library ieee;
use ieee.std_logic_1164.all;

entity dff_master_slave is
    port (
        clk, d : in std_logic;
        q, qbar : out std_logic
    );
end dff_master_slave;

architecture dataflow of dff_master_slave is
    signal master_out, slave_out : std_logic;
begin
    -- Lógica do Flip-Flop Mestre
    process (clk)
    begin
        if rising_edge(clk) then
            master_out <= d;
        end if;
    end process;

    -- Lógica do Flip-Flop Escravo
    process (clk)
    begin
        if falling_edge(clk) then
            slave_out <= master_out;
        end if;
    end process;

    -- Saídas do Flip-Flop D
    q <= slave_out;
    qbar <= not slave_out;
end dataflow;
