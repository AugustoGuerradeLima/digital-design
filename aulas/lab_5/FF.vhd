library ieee;
use ieee.std_logic_1164.all;

entity d_flipflop_dataflow is
    port (
        d, clk : in std_logic;
        q, qbar : out std_logic
    );
end d_flipflop_dataflow;

architecture dataflow of d_flipflop_dataflow is
    signal master_q, master_qbar, slave_q, slave_qbar : std_logic;
begin
    -- Latch SR Mestre
    master_q <= (d and not slave_qbar) or (not d and slave_q);
    master_qbar <= not master_q;

    -- Latch SR Escravo
    slave_q <= (master_q and not slave_qbar) or (not master_q and slave_q);
    slave_qbar <= not slave_q;

    -- Saídas do Flip-Flop D
    q <= slave_q;
    qbar <= slave_qbar;
end dataflow;
