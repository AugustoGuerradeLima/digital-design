-- Testbench para a Controladora
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Controladora is
end tb_Controladora;

architecture behavior of tb_Controladora is
    -- Component declaration
    component Controladora
        port (
            Clock      : in std_logic;
            Reset      : in std_logic;
            Sobe       : in std_logic;
            Desce      : in std_logic;
            Atualizar  : out std_logic;
            Subindo    : out std_logic
        );
    end component;

    -- Signal declaration
    signal Clock      : std_logic := '0';
    signal Reset      : std_logic := '0';
    signal Sobe       : std_logic := '0';
    signal Desce      : std_logic := '0';
    signal Atualizar  : std_logic;
    signal Subindo    : std_logic;

    -- Clock period definition
    constant clk_period : time := 2 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Controladora
        port map (
            Clock      => Clock,
            Reset      => Reset,
            Sobe       => Sobe,
            Desce      => Desce,
            Atualizar  => Atualizar,
            Subindo    => Subindo
        );

    -- Clock generation process
    clk_process : process
    begin
        Clock <= '0';
        wait for clk_period / 2;
        Clock <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_process : process
    begin
        -- Reset
        Reset <= '1';
        wait for clk_period * 10;
        Reset <= '0';
        wait for clk_period * 10;

        -- Test the Sobe input
        Sobe <= '1';
        wait for clk_period;
        Sobe <= '0';
        wait for clk_period * 2;

        -- Test the Desce input
        Desce <= '1';
        wait for clk_period;
        Desce <= '0';
        wait for clk_period * 2;

        -- End simulation
        wait;
    end process;

end behavior;