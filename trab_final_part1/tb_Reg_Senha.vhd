library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Reg_Senha is
end tb_Reg_Senha;

architecture Behavioral of tb_Reg_Senha is


    component Reg_Senha is
        Port ( clk     : in  std_logic;
               reset   : in  std_logic;
               carregar: in  std_logic;
               digito  : in  std_logic_vector (3 downto 0);
               senha   : out std_logic_vector (15 downto 0));
    end component;


    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal carregar: std_logic := '0';
    signal digito  : std_logic_vector (3 downto 0) := (others => '0');
    signal senha   : std_logic_vector (15 downto 0);


    constant clk_period : time := 10 ns;

begin


    uut: Reg_Senha
        Port map (
            clk => clk,
            reset => reset,
            carregar => carregar,
            digito => digito,
            senha => senha
        );


    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;


    stim_proc: process
    begin	

        reset <= '1';
        wait for clk_period*2;
        reset <= '0';
        

        carregar <= '1';
        digito <= "0001";
        wait for clk_period*2;
        carregar <= '0';
        wait for clk_period*2;


        carregar <= '1';
        digito <= "0010";
        wait for clk_period*2;
        carregar <= '0';
        wait for clk_period*2;


        carregar <= '1';
        digito <= "0011";
        wait for clk_period*2;
        carregar <= '0';
        wait for clk_period*2;


        carregar <= '1';
        digito <= "0100";
        wait for clk_period*2;
        carregar <= '0';
        wait for clk_period*2;


        wait;
    end process;

end Behavioral;