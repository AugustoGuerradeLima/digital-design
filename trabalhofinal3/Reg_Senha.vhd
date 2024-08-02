library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Reg_Senha is
    Port ( clk     : in  std_logic;
           reset   : in  std_logic;
           carregar: in  std_logic;
           digito  : in  std_logic_vector (3 downto 0);
           senha   : out std_logic_vector (15 downto 0));
end Reg_Senha;

architecture Behavioral of Reg_Senha is
    signal sig_senha : std_logic_vector (15 downto 0) := (others => '0'); -- Registrador para armazenar os 4 dígitos da senha
    signal last_carregar : std_logic := '0'; -- Para detectar a borda de subida de carregar
    signal count : integer := 0; -- Contador para acompanhar o número de dígitos inseridos
begin

process(clk, reset)
begin
    if reset = '1' then
        sig_senha <= (others => '0');
        count <= 0;
    elsif rising_edge(clk) then
        if carregar = '1' and last_carregar = '0' then -- Detecta a borda de subida de carregar
            if count < 4 then
                sig_senha(15 downto 12) <= sig_senha(11 downto 8);
                sig_senha(11 downto 8) <= sig_senha(7 downto 4);
                sig_senha(7 downto 4) <= sig_senha(3 downto 0);
                sig_senha(3 downto 0) <= digito;
                count <= count + 1;
            end if;
        end if;
        last_carregar <= carregar; -- Atualiza o último estado de carregar
    end if;
end process;

senha <= sig_senha;

end Behavioral;
