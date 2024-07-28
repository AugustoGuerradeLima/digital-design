library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Demux is
    generic (
        W : integer := 16;
        log2W : integer := 4  -- log2(16) = 4, para valores maiores, ajustar manualmente
    );
    Port (
        input_vector : in  std_logic_vector(W-1 downto 0);
        selector     : in  std_logic_vector(log2W-1 downto 0);
        output_value : out std_logic
    );
end Demux;

architecture Behavioral of Demux is
    function log2(x: integer) return integer is
        variable result: integer := 0;
        variable temp: integer := x;
    begin
        while temp > 1 loop
            temp := temp / 2;
            result := result + 1;
        end loop;
        return result;
    end function;
begin
    process(input_vector, selector)
    begin
        if to_integer(unsigned(selector)) < W then
            output_value <= input_vector(to_integer(unsigned(selector)));
        else
            output_value <= 'Z'; -- Valor default ou erro
        end if;
    end process;
end Behavioral;