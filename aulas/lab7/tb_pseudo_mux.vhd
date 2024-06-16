library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pseudo_mux is
end tb_pseudo_mux;

architecture test_bench of tb_pseudo_mux is
    signal RESET_tb, CLOCK_tb, S_tb, A_tb, B_tb, C_tb, D_tb : std_logic := '0';
    signal Q_tb : std_logic;

    component pseudo_mux
        port (
            RESET   : in    std_logic;
            CLOCK   : in    std_logic;
            S       : in    std_logic;
            A, B, C, D : in    std_logic;
            Q       : out   std_logic
        );
    end component;

begin

    MUX : pseudo_mux
        port map (
            RESET  => RESET_tb,
            CLOCK  => CLOCK_tb,
            S      => S_tb,
            A      => A_tb,
            B      => B_tb,
            C      => C_tb,
            D      => D_tb,
            Q      => Q_tb
        );

    process
    begin
        CLOCK_tb <= '0';
        wait for 10 ns;
        CLOCK_tb <= '1';
        wait for 10 ns;
    end process;

    process
    begin
        RESET_tb <= '1';
        wait for 20 ns;
        RESET_tb <= '0';
        wait;
    end process;

    process
    begin
        wait for 30 ns;

        A_tb <= '0';
        B_tb <= '0';
        C_tb <= '0';
        D_tb <= '0';
        S_tb <= '0';
        wait for 20 ns;

        A_tb <= '0';
        B_tb <= '0';
        C_tb <= '0';
        D_tb <= '0';
        S_tb <= '1';
        wait for 20 ns;

        A_tb <= '0';
        B_tb <= '1';
        C_tb <= '0';
        D_tb <= '0';
        S_tb <= '1';
        wait for 20 ns;

        A_tb <= '0';
        B_tb <= '1';
        C_tb <= '0';
        D_tb <= '0';
        S_tb <= '0';
        wait for 20 ns;

        A_tb <= '0';
        B_tb <= '0';
        C_tb <= '1';
        D_tb <= '0';
        S_tb <= '0';
        wait for 20 ns;

        A_tb <= '0';
        B_tb <= '0';
        C_tb <= '0';
        D_tb <= '1';
        S_tb <= '1';
        wait for 20 ns;

        wait;
    end process;

end test_bench;