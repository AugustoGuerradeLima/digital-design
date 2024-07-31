library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Reg_Senha is
end tb_Reg_Senha;

architecture Behavioral of tb_Reg_Senha is

    -- Component declaration for the Reg_Senha
    component Reg_Senha is
        Port ( clk     : in  STD_LOGIC;
               reset   : in  STD_LOGIC;
               carregar: in  STD_LOGIC;
               digito  : in  STD_LOGIC_VECTOR (3 downto 0);
               senha   : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    -- Signals to connect to the Reg_Senha
    signal clk     : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '0';
    signal carregar: STD_LOGIC := '0';
    signal digito  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal senha   : STD_LOGIC_VECTOR (15 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Reg_Senha
    uut: Reg_Senha
        Port map (
            clk => clk,
            reset => reset,
            carregar => carregar,
            digito => digito,
            senha => senha
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin	
        -- Reset the Reg_Senha
        reset <= '1';
        wait for clk_period*2;
        reset <= '0';
        
        -- Load the first digit (1)
        carregar <= '1';
        digito <= "0001";
        wait for clk_period*1;
        carregar <= '0';
        wait for clk_period*2;

        -- Load the second digit (2)
        carregar <= '1';
        digito <= "0010";
        wait for clk_period*1;
        carregar <= '0';
        wait for clk_period*2;

        -- Load the third digit (3)
        carregar <= '1';
        digito <= "0011";
        wait for clk_period*1;
        carregar <= '0';
        wait for clk_period*2;

        -- Load the fourth digit (4)
        carregar <= '1';
        digito <= "0100";
        wait for clk_period*1;
        carregar <= '0';
        wait for clk_period*2;

        -- Finish simulation
        wait;
    end process;

end Behavioral;
