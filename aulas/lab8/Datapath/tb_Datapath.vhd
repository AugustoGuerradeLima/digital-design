library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity tb_datapath is
end tb_datapath;

architecture testbench of tb_datapath is

    signal E            : std_logic_vector(3 downto 0) := "0000";
    signal Sobe         : std_logic;
    signal Desce        : std_logic;
    signal Media        : std_logic_vector(6 downto 0);
    signal load_E       : std_logic := '0';
    signal Reset_MA     : std_logic := '0';
    signal Maior        : std_logic;
    signal Menor        : std_logic;
    signal Descendo     : std_logic := '0';
    signal Subindo      : std_logic := '0';
    signal Atualizar    : std_logic := '0';
    signal clock        : std_logic := '0';
    signal Sig_E        : std_logic_vector(3 downto 0) := "0000";
    signal Sig_M        : std_logic_vector(3 downto 0) := "0000";

    constant clock_period : time  := 10 ns;
    signal clock_count    : integer := 0;
    signal stop_clock     : boolean := false;

    component Clk_Gen is
        port (
            clock_out : out std_logic
        );
    end component;

    signal clk_tb : std_logic;
begin

    clk_gen_inst : Clk_Gen
        port map (
            clock_out => clk_tb
        );

    datapath_inst : entity work.Datapath
        port map (
            E => E,
            Sobe => Sobe,
            Desce => Desce,
            Media => Media,
            load_E => load_E,
            Reset_MA => Reset_MA,
            Maior => Maior,
            Menor => Menor,
            Descendo => Descendo,
            Subindo => Subindo,
            Atualizar => Atualizar,
            clock => clk_tb,
            Sig_E => Sig_E,
            Sig_M => Sig_M
        );

    clock_process : process
    begin
        while not stop_clock loop
            clock <= '0';
            wait for clock_period / 2;
            clock <= '1';
            wait for clock_period / 2;
            clock_count <= clock_count + 1;
            if clock_count = 20 then
                stop_clock <= true;
            end if;
        end loop;
        wait;
    end process;

    test_process : process
    begin
        E <= "0000";
        load_E <= '0';
        Reset_MA <= '0';
        Descendo <= '0';
        Subindo <= '0';
        Atualizar <= '0';
        wait for 10 ns;

        load_E <= '1';
        E <= "0101";
        wait for 10 ns;
        load_E <= '0';
        wait for 10 ns;

        Atualizar <= '1';
        Subindo <= '1';
        Descendo <= '0';
        wait for 10 ns;
        E <= "1010";
        Atualizar <= '0';
        wait for 10 ns;

        Reset_MA <= '1';
        wait for 10 ns;
        Reset_MA <= '0';
        wait for 10 ns;

        E <= "1000";
        wait for 10 ns;

        wait;
    end process;

end architecture;
