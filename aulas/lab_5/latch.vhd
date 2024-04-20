library ieee;
use ieee.std_logic_1164.all;

entity latch_sr_dataflow is
    port (
        s, r, clk : in std_logic;
        q, qbar   : out std_logic
    );
end latch_sr_dataflow;

architecture dataflow of latch_sr_dataflow is
begin
    q <= (s and not qbar) or (not r and q);
    qbar <= not q;
end dataflow;