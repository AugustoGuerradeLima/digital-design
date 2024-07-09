library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity tb_datapath is
end tb_datapath;

architecture testbench of tb_datapath is

    signal E            : std_logic_vector(3 downto 0) := "0000";
    signal Sobe         : std_logic;
    signal Desce        : std_logic;
    signal Media        : std_logic_vector(6 downto 0) := "0000000";
    signal load_E       : std_logic := '0';
    signal Reset_MA     : std_logic := '0';
    signal Maior        : std_logic;
    signal Menor        : std_logic;
    signal Descendo     : std_logic := '0';
    signal Subindo      : std_logic := '0';
    signal Atualizar    : std_logic := '0';
    signal clock        : std_logic := '0';
    signal Sig_E_out    : std_logic_vector(3 downto 0) := "0000";
    signal Sig_M_out    : std_logic_vector(3 downto 0) := "0000";

    constant clock_period : time := 10 ns;

begin

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
            clock => clock,  -- Corrected clock signal
            Sig_E_out => Sig_E_out,
            Sig_M_out => Sig_M_out
        );

    clock_process : process
    begin
        while true loop
            clock <= '0';
            wait for clock_period / 2;
            clock <= '1';
            wait for clock_period / 2;
        end loop;
    end process;

    test_process : process
    begin
        load_E <= '1';
        E <= "1000";
        Reset_MA <= '0';
        Descendo <= '0';
        Subindo <= '0';
        Atualizar <= '1';
        wait for 10 ns;

        load_E <= '1';
        E <= "0101";
        wait for 10 ns;

        Subindo <= '1';
        Descendo <= '0';
		  Atualizar <= '1';
		  
        wait for 10 ns;
        E <= "1010";
        wait for 10 ns;

        wait for 10 ns;
        Reset_MA <= '0';
        wait for 10 ns;

        E <= "1000";
        wait for 10 ns;
        E <= "0110";

        wait;
    end process;

end architecture;
