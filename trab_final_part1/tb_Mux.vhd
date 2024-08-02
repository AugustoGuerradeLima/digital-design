library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Mux is
end tb_Mux;

architecture Behavioral of tb_Mux is
    component Mux
        generic (
            W : integer := 16;
            log2W : integer := 4
        );
        Port (
            input_vector : in  std_logic_vector(W-1 downto 0);
            selector     : in  std_logic_vector(log2W-1 downto 0);
            output_value : out std_logic
        );
    end component;

    constant W : integer := 16;
    constant log2_W : integer := 4;

    signal input_vector : std_logic_vector(W-1 downto 0);
    signal selector     : std_logic_vector(log2_W-1 downto 0);
    signal output_value : std_logic;

begin
    uut: Mux
        generic map (
            W => W,
            log2W => log2_W
        )
        port map (
            input_vector => input_vector,
            selector     => selector,
            output_value => output_value
        );

    stim_proc: process
    begin
        input_vector <= (others => '0');
        selector <= (others => '0');
        wait for 10 ns;

        input_vector <= "0000000000000001";
        selector <= "0000";
        wait for 10 ns;
        assert (output_value = '1') report "Test case 1 failed" severity error;

        input_vector <= "0000000000000010";
        selector <= "0001";
        wait for 10 ns;
        assert (output_value = '1') report "Test case 2 failed" severity error;

        input_vector <= "0000000010000000";
        selector <= "0010";
        wait for 10 ns;
        assert (output_value = '1') report "Test case 3 failed" severity error;

        input_vector <= "1000000000000000";
        selector <= "1111";
        wait for 10 ns;
        assert (output_value = '1') report "Test case 4 failed" severity error;

        wait;
    end process;
end Behavioral;
